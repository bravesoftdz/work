unit uCashRegClose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiCashRegClose, ExtCtrls, StdCtrls, Buttons, Mask,
  SuperComboADO, siComp, siLangRT, DBCtrls;

type
  TCashRegClose = class(TFrmPaiCashRegClose)
  private
    { Private declarations }
  protected
    function TestBeforeClose:Boolean; override;
  public
    { Public declarations }
  end;

var
  CashRegClose: TCashRegClose;

implementation

uses uDM, uPassword, uMsgBox, uMsgConstant, uDateTimeFunctions, DateUtils,
  Registry;

{$R *.dfm}

function TCashRegClose.TestBeforeClose:Boolean;
var
  {Cancelou, Permite: Boolean;}
  bImpressoraLigada: Boolean;
  AIDUserAuth: Integer;
  sD1, sD2 : String;

begin
  Result := True;
  FReducaoEmitida := False;

 if DM.fCashRegister.FiscalPrinter then
 begin
    if not DM.fModuloFiscal.ValidateSystemDate then
    begin
      Result := false;
      Exit;
    end;

    if (DM.fCashRegister.GeneratePAFSintegra) and (not DM.EFiscal1.VerificaImpressoraLigada) then
    begin
      MsgBox('Impressora Desligada ou Desconectada',  vbCritical + vbOkOnly);
      Result := False;
      Exit;
    end;

    if MsgBox('Deseja Emitir a Redução Z ?_A Redução Z impossibilitará novas impressões de Cupons Fiscais!',
       vbYesNo + vbSuperCritical) = vbYes then
    begin
      FReducaoEmitida := True;
      {Cancelou := False;
      Permite := Password.HasFuncRight(64);
      if not Permite then
        repeat
          Permite := False;
          Password.PermanentLogOn := False;
          Cancelou := not Password.Start(1, 1);
          if not Cancelou then
            Permite := Password.HasFuncRight(64);
          if not Permite then
              MsgBox('A Redução Z não foi emitida._' +
                    'Verificar permissão para emitir a Redução Z ', vbOKOnly + vbInformation);


        until Cancelou or Permite;

      if Permite then
        Result := DM.EFiscal1.FechaDiaFiscal(cmbUser.Text)
      else
        Result := False;}

        Result := Password.AquireAccess(64,
                                        'A Redução Z não foi emitida._' +
                                        'Verificar permissão para emitir a Redução Z ',
                                        AIDUserAuth
                                        );
        if Result then
          Result := DM.EFiscal1.FechaDiaFiscal(cmbUser.Text);

        //PAF
        {
        if Result then
          if MonthsBetween((DM.fModuloFiscal.LeituraDataMFD), DM.fModuloFiscal.PrinterDate+1) <> 0 then
          begin
            sD1 := FormatDatetime('dd/mm/yyyy', InicioDoMes(IncMonth(DM.fModuloFiscal.PrinterDate, -1)));
            sD2 := FormatDatetime('dd/mm/yyyy', FimMes(IncMonth(DM.fModuloFiscal.PrinterDate, -1)));
            DM.EFiscal1.LeituraMemoriaFiscalData(sD1, sD2);

            with TRegistry.Create do
            try
              RootKey := HKEY_LOCAL_MACHINE;
              OpenKey(REGISTRY_PATH_POS, True);
              if not ValueExists('LeituraDataMFD') then
                WriteDate('LeituraDataMFD', Trunc(InicioDoMes(DM.fModuloFiscal.PrinterDate)));
            finally
              Free;
            end;

          end;
        }

    end;
  end;
end;

end.
