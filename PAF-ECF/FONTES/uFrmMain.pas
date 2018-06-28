unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, uTefConsts;

type
  TFrmMain = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    procedure ValidateTXTCashRegister;
  public
    FCloseRegister : Boolean;
    function Start: Boolean;
  end;

var
  FrmMain: TFrmMain;

implementation

uses uCashRegOpen, uCashRegManager, uPassword, uDM, uSystemConst, uFchParam,
     uEncryptFunctions, uMsgBox, EFiscal, uTXTCashInfo, uFilePersistence,
     DateUtils;

{$R *.dfm}

function TFrmMain.Start: Boolean;
var
  iIDCashRegMov: Integer;
begin

  FCloseRegister := False;

  if not Password.Start(1,1) then //Cash Register (Menu)
    Close;

  //Call parameter for system
  if not (DM.fCashRegister.IDDefault > 0) then
  begin
    with TFchParameter.Create(Self) do
    begin
      Start(PARAM_OPEN_CASHREG);
    end;
    Exit;
  end;

  try
    case DM.CheckCashRegState(iIDCashRegMov) of
      CASHREG_OPEN:
      begin
        //Caixa aberta, abre tela de Manipulação
        with TCashRegManager.Create(Self) do
          Start(iIDCashRegMov, True);
      end;

      CASHREG_CLOSE:
      begin
        // Caixa Fechada, abre tela da abertura
        with TCashRegOpen.Create(Self) do
          ShowModal;
      end;
    end;

  if FCloseRegister and (DM.fCashRegister.MsgAfterCloseReg <> '') then
    MsgBox(DM.fCashRegister.MsgAfterCloseReg, vbOKOnly + vbSuperCritical);

  finally
    Result := True;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  bResult, bImpressoraLigada: Boolean;
  iStatus: LongInt;
  iTEFDialType : set of Byte;
  sSenha, FTotalizadoresParciais : String;
begin
  bResult := True;

  if True then
  begin
    if not DM.VerifyMD5 then
    begin
      ShowMessage('MD5 não registrado!');
      Close;
      Exit;
    end;

    bImpressoraLigada := DM.EFiscal1.VerificaImpressoraLigada;

    if not bImpressoraLigada then
      MsgBox('Impressora Desligada ou Desconectada',  vbCritical + vbOkOnly);

    //Homologacao BA
    if bResult then
    begin
      DM.ReadSerialNumbers;
      if (not DM.VerifySerialNumber) then
      begin
        //Salva o Novo numero de seria para arquivo
        sSenha := InputBox('Entre com a senha de desenvolvedor', 'Senha', '');
        if (sSenha = '') or ((sSenha <> '') and (sSenha <> 'mainretail')) then
        begin
          MsgBox('Senha invalida!', vbCritical + vbOkOnly);
          bResult := False;
        end
        else
          DM.CreateSerialNumber;
      end;

      if bResult and bImpressoraLigada and (not DM.VerifySerialNumber) then
      begin
        if MsgBox('Nº de série não encontrado._Deseja cadastrar número?', vbYesNo + vbQuestion) = vbYes then
        begin
          DM.CreateSerialNumber;
          bResult := DM.VerifySerialNumber;
        end
        else
          bResult := False;
      end;
    end;

    if bResult and bImpressoraLigada then
      bResult := DM.fModuloFiscal.ValidateSystemDate;

    //Verificar se teve cupom aberto e cancela
    if bResult and bImpressoraLigada then
    begin
      DM.fModuloFiscal.PrinterDate := DM.EFiscal1.DataImpressora;

      if DM.EFiscal1.TemCupom then
      begin
        MsgBox('O último cupom fiscal ficou aberto e sera cancelado!', vbCritical + vbOkOnly);
        DM.EFiscal1.CancelaCupomAtualSemErro((DM.fCashRegister.UseTef in [TEF_DIAL, TEF_DEDICADO]));
        Sleep(10);
        if DM.PersistenceType = ptTXT then
          DM.SaleWritter.AbortSale('XXXXXX');
      end;

      DM.EFiscal1.FechaCupomVinculadoSemErro('');
      Sleep(10);

      DM.EFiscal1.FechaRelatorioGerencial;
      Sleep(10);
    end
    else
      DM.fModuloFiscal.PrinterDate := Trunc(NOW);

    // Codigo de ativação dos TEFs
    case DM.fCashRegister.UseTef of
      TEF_DIAL:
        begin
          iTEFDialType := DM.FTEFDialTypes;

          if 0 in iTEFDialType then
          begin
            DM.TEFDial1.TEFDIALType := 0;
            while not DM.TEFDial1.Ativacao(False) do
            begin
              Sleep(0);
            end;
          end;

          if 1 in iTEFDialType then
          begin
            DM.TEFDial1.TEFDIALType := 1;
            while not DM.TEFDial1.Ativacao(False) do
            begin
              Sleep(0);
            end;
          end;

        end;
      TEF_DEDICADO:
        begin
          iStatus := DM.TEFDedicado1.ConfiguraInt;
          //('localhost', '00000000', 'SE000001')
        end;

    end;

    if bResult then
    case DM.fCashRegister.UseTef of
      TEF_DIAL : repeat
                 until DM.TEFDial1.ResolvePendencias;
      TEF_DEDICADO: repeat
                    until DM.TEFDedicado1.ResolvePendencias;
    end;

    //PAF
    DM.EFiscal1.RetornaInformacao('140', 1164, FTotalizadoresParciais);
    DM.fModuloFiscal.TotParciais := Copy(PChar(FTotalizadoresParciais), 843, 80);

    if bResult then
    begin
      if DM.EFiscal1.IsReducaoAutomatica and Assigned(DM.EFiscal1.AfterReducaoZ) then
        DM.EFiscal1.AfterReducaoZ(DM.EFiscal1);
    end;

  end
  else
    ValidateTXTCashRegister;


  if bResult then
    Start;

  Close;
end;

procedure TFrmMain.ValidateTXTCashRegister;
var
  CashInfo : TTXTCashInfo;
  logObject: TObject;
begin

  if (DM.PersistenceType = ptTXT) and (DM.fCashRegister.SalesFileName <> '') then
  begin

    CashInfo := TTXTCashInfo.Create;
    try
      CashInfo.FileName := DM.SaleWritter.LocalWorkingDir + DM.fCashRegister.SalesFileName;
      if CashInfo.Load then
        begin
          logObject := TLogHolder(CashInfo.LogList[CashInfo.LogList.Count-1]).RegObject;
          case TLogHolder(CashInfo.LogList[CashInfo.LogList.Count-1]).RegType of
            sltOpenSale, sltAddItem,
            sltAddPayment, sltAddCustomer,
            sltCancelItem : begin
                            MsgBox('O último cupom ficou aberto e sera cancelado!', vbCritical + vbOkOnly);
                            DM.SaleWritter.AbortSale('XXXXXX');
                            end;
          end;
        end
      else
        MsgBox('Não foi possível carregar o arquivo '+ CashInfo.FileName, vbCritical + vbOkOnly);
    finally
      CashInfo.Free;
    end;
  end;

end;

end.
