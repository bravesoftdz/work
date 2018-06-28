unit PaiCashRegClose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  Buttons, ADODB, SuperComboADO, uPai, siComp, siLangRT, uFilePersistence;

type

  TPaymentTotal = class
    Total: Currency;
  end;

  TFrmPaiCashRegClose = class(TFrmPai)
    Label23: TLabel;
    pnlCloseCash: TPanel;
    Panel10: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    grpCoin: TGroupBox;
    Edit0100: TEdit;
    Edit050: TEdit;
    Edit025: TEdit;
    Edit010: TEdit;
    Edit005: TEdit;
    Edit001: TEdit;
    EditTot001: TEdit;
    EditTot005: TEdit;
    EditTot010: TEdit;
    EditTot025: TEdit;
    EditTot050: TEdit;
    EditTot0100: TEdit;
    grpBill: TGroupBox;
    Edit100: TEdit;
    Edit50: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit10: TEdit;
    Edit20: TEdit;
    EditTot100: TEdit;
    EditTot50: TEdit;
    EditTot20: TEdit;
    EditTot10: TEdit;
    EditTot5: TEdit;
    EditTot2: TEdit;
    EditTot1: TEdit;
    EditTotCash: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditTime: TEdit;
    pnlOther: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Panel6: TPanel;
    lblCashierTotal: TLabel;
    EditTotCashier: TEdit;
    lblSystemTotal: TLabel;
    EditTotSystem: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditDiference: TEdit;
    lblDifference: TLabel;
    Shape1: TShape;
    tmrCloseCash: TTimer;
    Panel5: TPanel;
    Image5: TImage;
    Image8: TImage;
    lblTipCash: TLabel;
    lblSubTipCash: TLabel;
    lblSugBill: TLabel;
    lblCountBill: TLabel;
    Label33: TLabel;
    lblCountCoin: TLabel;
    lblSugCoin: TLabel;
    Label36: TLabel;
    pnlCountBill: TPanel;
    wwDBEdit1: TEdit;
    wwDBEdit2: TEdit;
    wwDBEdit3: TEdit;
    wwDBEdit4: TEdit;
    wwDBEdit5: TEdit;
    wwDBEdit6: TEdit;
    wwDBEdit7: TEdit;
    pnlCountCoin: TPanel;
    wwDBEdit8: TEdit;
    wwDBEdit9: TEdit;
    wwDBEdit10: TEdit;
    wwDBEdit11: TEdit;
    wwDBEdit12: TEdit;
    wwDBEdit13: TEdit;
    pnllblCoin: TPanel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    pnllblBill: TPanel;
    Label56: TLabel;
    Label55: TLabel;
    Label54: TLabel;
    Label53: TLabel;
    Label52: TLabel;
    Label51: TLabel;
    Label50: TLabel;
    pnlDeposit: TPanel;
    Label3: TLabel;
    EditTotDeposit: TEdit;
    Label4: TLabel;
    EditTotCounted: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditOpenCash: TEdit;
    Label9: TLabel;
    Shape2: TShape;
    Label10: TLabel;
    wwDBEdit15: TEdit;
    wwDBEdit14: TEdit;
    cmbTotalCard: TEdit;
    btnTotalCard: TSpeedButton;
    cmbTotalPre: TEdit;
    btnPostDate: TSpeedButton;
    cmbTotalCheck: TEdit;
    btnCheckTotal: TSpeedButton;
    cmbTotalOther: TEdit;
    btnOtherTotal: TSpeedButton;
    btCancel: TButton;
    cmbUser: TDBLookupComboBox;
    lbDebitCard: TLabel;
    cmbTotalDebit: TEdit;
    btnTotalDebit: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure AtuTotals(Sender : TObject);
    procedure AtuTotOthers(Sender : TObject);
    procedure tmrCloseCashTimer(Sender: TObject);
    procedure ApagaEdit(MyGroup : TGroupBox);
    procedure spHelpClick(Sender: TObject);
    procedure Edit100KeyPress(Sender: TObject; var Key: Char);
    procedure cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotalCardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTotalCardExit(Sender: TObject);
  private
    { Private declarations }
    sCloseCash12, sCloseCash22,
    sEnterQty, sEnterQtyDeposit,
    sCount, sNext, sCancel,
    sCounted, sDeposit,
    sDeposit2, sBack : String;
    TotCashGeral, TotOtherGeral : Double;
    MyIDOpenUser, MyIDCashRegMov : integer;
    MyResidual, TotCounted   : Double;
    TpOperation  : integer;
    fCall : Integer;
    procedure StartDeposit;
    procedure StartCheck;
    procedure AtuTotCashier;
    function  TestaPreenchimento(MyControl : TControl) : Boolean;
    procedure ReadLogFile(fFile:String);
    procedure SetOthersValues(AIDCashRegMov: Integer);
  protected
    FReducaoEmitida: Boolean;
    function TestBeforeClose:Boolean; virtual;
  public
    function Start(IDCashRegMov : integer) : Boolean;
  end;

implementation

uses uDM, uItemsCalc, uPrintCashReg, uCashRegEnvelop, uMsgBox, uSystemConst,
     uNumericFunctions, uMsgConstant, uSystemTypes, uCharFunctions, uDMGlobal,
     uTXTCashInfo, uDMPDV, uFrmMain;

const TP_CHECKING = 1;
      TP_DEPOSIT  = 2;

{$R *.DFM}

function TFrmPaiCashRegClose.Start(IDCashRegMov : integer) : Boolean;
begin
  DMPDV.CanTransferFile := False;

  Result := False;
  fCall  := -1;

  // Teste de mesmo usuario que abriu
  DM.fPOS.GetCashRegisterResidual(IDCashRegMov, MyIDOpenUser, MyResidual);
  MyIDCashRegMov := IDCashRegMov;

  // Seta o usuario e time
  cmbUser.KeyValue := DM.fUser.ID;
  EditTime.Text    := DateTimeToStr(Now);

  // Open CashRegister
  DM.OpenCashRegister;

  //Load Payments info
  if DM.PersistenceType = ptTXT then
    ReadLogFile(DM.SaleWritter.LocalWorkingDir + DM.fCashRegister.SalesFileName)
  else
    SetOthersValues(MyIDCashRegMov);

  Result := (ShowModal = mrOK);

  DMPDV.CanTransferFile := True;

end;

procedure TFrmPaiCashRegClose.AtuTotals(Sender : TObject);
var
  Razao        : Double;
  EditValor    : TEdit;
begin
  EditValor := TEdit(Sender);
  Razao     := (EditValor.Tag)/100;

  case EditValor.Tag of
    10000 : EditValor := EditTot100;
    5000  : EditValor := EditTot50;
    2000  : EditValor := EditTot20;
    1000  : EditValor := EditTot10;
     500  : EditValor := EditTot5;
     200  : EditValor := EditTot2;
     100  : if EditValor.Parent.tag = 0 then
              EditValor := EditTot1
            else
              EditValor := EditTot0100;
       1  : EditValor := EditTot001;
       5  : EditValor := EditTot005;
      10  : EditValor := EditTot010;
      25  : EditValor := EditTot025;
      50  : EditValor := EditTot050;
  end;

  EditValor.Text := FloatToStrF(MyStrToMoney(TEdit(Sender).Text)*Razao,
                    ffCurrency, 20, 2);

  // Atualiza o total geral
  TotCashGeral := MyStrToMoney(Edit100.Text)*100;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit50.Text)*50;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit20.Text)*20;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit10.Text)*10;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit5.Text)*5;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit2.Text)*2;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit1.Text);
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit001.Text)*0.01;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit005.Text)*0.05;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit010.Text)*0.1;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit025.Text)*0.25;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit050.Text)*0.5;
  TotCashGeral := TotCashGeral + MyStrToMoney(Edit0100.Text);

  EditTotCash.Text := FloatToStrF(TotCashGeral, ffCurrency, 20, 2);

  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TFrmPaiCashRegClose.AtuTotCashier;
begin
  EditTotCashier.Text := FloatToStrF(TotCashGeral + TotOtherGeral, ffCurrency, 20, 2);
  EditDiference.Text  := FloatToStrF(TotCashGeral + TotOtherGeral - MyResidual, ffCurrency, 20, 2);

  EditTotDeposit.Text := FloatToStrF(TotCashGeral + TotOtherGeral, ffCurrency, 20, 2);
  EditOpenCash.Text   := FloatToStrF(TotCounted - TotCashGeral - TotOtherGeral, ffCurrency, 20, 2);
end;

procedure TFrmPaiCashRegClose.FormShow(Sender: TObject);
begin
  inherited;
  EditTotSystem.Visible := not DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  EditDiference.Visible := not DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  wwdbedit14.Visible    := DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  wwdbedit15.Visible    := DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  if DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM] then
  begin
    wwdbedit14.Text := FloatToStrF(50000+Random(5000), ffCurrency, 20, 2);
    wwdbedit15.Text := FloatToStrF(50000+Random(5000), ffCurrency, 20, 2);
  end;

  StartCheck;
end;

procedure TFrmPaiCashRegClose.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPaiCashRegClose.btCancelClick(Sender: TObject);
begin
  inherited;
  if TpOperation = TP_DEPOSIT then
    StartCheck
  else
    ModalResult := mrCancel;
end;

function TFrmPaiCashRegClose.TestBeforeClose:Boolean;
begin
   Result := True;
end;

procedure TFrmPaiCashRegClose.btCloseClick(Sender: TObject);
var
  iError, IDCashRegLog: Integer;
  Envelop: String;
  ReducaoZ: TRegReducaoZ;
  FResult : Boolean;
begin
  inherited;
  // Testa o estado que se encontra a tela e passa para o proximo
  iError := 0;

  if TpOperation = TP_CHECKING then
    StartDeposit
  else
  begin
    //if (MsgBox(MSG_QST_CONFIRM_CLOSE_REGISTER, vbYesNo + vbQuestion) = vbYes) then
    //begin
      // Pede o numero do envelope para deposito
      with TCashRegEnvelop.Create(Self) do
        if not Start(Envelop) then Exit;

           //Test modulo fiscal
           if not TestBeforeClose then
              Exit;

           FResult := True;

           case DM.PersistenceType of
             ptDB :
             begin
               DM.fPOS.CloseCashRegister(MyIDCashRegMov,
                                       DM.fUser.ID,
                                       MyStrToInt(Edit100.Text),
                                       MyStrToInt(Edit50.Text),
                                       MyStrToInt(Edit20.Text),
                                       MyStrToInt(Edit10.Text),
                                       MyStrToInt(Edit5.Text),
                                       MyStrToInt(Edit2.Text),
                                       MyStrToInt(Edit1.Text),
                                       MyStrToInt(Edit0100.Text),
                                       MyStrToInt(Edit050.Text),
                                       MyStrToInt(Edit025.Text),
                                       MyStrToInt(Edit010.Text),
                                       MyStrToInt(Edit005.Text),
                                       MyStrToInt(Edit001.Text),
                                       TotCounted,
                                       TotCashGeral,
                                       MyStrToMoney(cmbTotalCard.Text),
                                       MyStrToMoney(cmbTotalPre.Text),
                                       MyStrToMoney(cmbTotalCheck.Text),
                                       MyStrToMoney(cmbTotalOther.Text),
                                       MyStrToMoney(cmbTotalDebit.Text),
                                       Envelop,
                                       Now,
                                       IDCashRegLog,
                                       iError);

               if DM.fCashRegister.GeneratePAFSintegra and FReducaoEmitida then
               begin
                 ReducaoZ := DM.DadosReducaoZ;
                 if ReducaoZ.ANumeroSerie <> '' then
                   DM.fPOS.InsertReducaoZ(ReducaoZ.AMovDate, ReducaoZ.ANumeroSerie,
                     ReducaoZ.ANumeroLoja, ReducaoZ.ANumeroECF, ReducaoZ.ANumReducaoZ,
                     ReducaoZ.ACOOInicial, ReducaoZ.ACOOFinal, ReducaoZ.ANumCancelamentos,
                     ReducaoZ.AValCancelamentos, ReducaoZ.AValDescontos, ReducaoZ.AGTInicial,
                     ReducaoZ.AGTFinal, ReducaoZ.ASubstituicaoTrib, ReducaoZ.AIsencao,
                     ReducaoZ.ANaoTributavel, ReducaoZ.AAliquota, ReducaoZ.ABaseCalculo,
                     ReducaoZ.AValImposto, ReducaoZ.ATipoECF, ReducaoZ.AMarcaECF,
                     ReducaoZ.AModeloECF, ReducaoZ.AVersaoSBECF, ReducaoZ.ADataInstalacaoSBECF,
                     ReducaoZ.AMFAdicional, ReducaoZ.AContadorReducaoZ, ReducaoZ.AContadorOrdemOperacao,
                     ReducaoZ.AContadorReinicioOperacao, ReducaoZ.ANumeroUsuarioECF, ReducaoZ.AIncideISSQN,
                     ReducaoZ.ADataEmissao, ReducaoZ.ATribReducaoZList);
               end;
             end;

             ptTXT:
             begin
               if DM.fCashRegister.GeneratePAFSintegra and FReducaoEmitida then
                 ReducaoZ := DM.DadosReducaoZ;

               FResult := DM.SaleWritter.CloseCashRegister(MyIDCashRegMov,
                                       DM.fUser.ID,
                                       MyStrToInt(Edit100.Text),
                                       MyStrToInt(Edit50.Text),
                                       MyStrToInt(Edit20.Text),
                                       MyStrToInt(Edit10.Text),
                                       MyStrToInt(Edit5.Text),
                                       MyStrToInt(Edit2.Text),
                                       MyStrToInt(Edit1.Text),
                                       MyStrToInt(Edit0100.Text),
                                       MyStrToInt(Edit050.Text),
                                       MyStrToInt(Edit025.Text),
                                       MyStrToInt(Edit010.Text),
                                       MyStrToInt(Edit005.Text),
                                       MyStrToInt(Edit001.Text),
                                       TotCounted,
                                       TotCashGeral,
                                       MyStrToMoney(cmbTotalCard.Text),
                                       MyStrToMoney(cmbTotalPre.Text),
                                       MyStrToMoney(cmbTotalCheck.Text),
                                       MyStrToMoney(cmbTotalOther.Text),
                                       Envelop,
                                       Now,
                                       MyStrToMoney(cmbTotalDebit.Text),
                                       ReducaoZ);
             end;
           end;

         if FResult then
         begin
           DM.fCashRegister.RecentClosedCash := DM.fCashRegister.SalesFileName;
           DM.fCashRegister.SalesFileName := '';
         end;

         if (DM.PersistenceType = ptTXT) and FResult then
           DMPDV.SaveFilesToServer(True);

         if iError = -1 then
            begin
            MsgBox(MSG_INF_CSR_IS_CLOSED, vbOKOnly + vbInformation);
            Exit;
            end;

         FrmMain.FCloseRegister := True;

      if DM.fPrintReceipt.PrintReceipt then
        begin
          with TPrintCashReg.Create(Self) do
            Start(IDCashRegLog, TICKET_CASH_CLOSE);
        end;

      // Animacao de fechamento de caixa
      tmrCloseCash.Enabled := True;
    //end;

  end;
end;

function TFrmPaiCashRegClose.TestaPreenchimento(MyControl : TControl) : Boolean;
var
  i : integer;
begin
  Result := True;
  Exit;   // Foi colocado a pedido do Lui
  with MyControl do
    for i := 0 to ControlCount -1 do
      if (Controls[i] is TEdit) and TEdit(Controls[i]).TabStop and
         (TEdit(Controls[i]).Text = '') then
      begin
        MsgBox(MSG_INF_COUNT_ITEMS, vbOKOnly + vbInformation);
        TEdit(Controls[i]).SetFocus;
        Result := False;
        Exit;
      end;
end;

procedure TFrmPaiCashRegClose.AtuTotOthers(Sender : TObject);
begin
  TotOtherGeral := MyStrToMoney(cmbTotalCard.text)  +
                   MyStrToMoney(cmbTotalPre.text)   +
                   MyStrToMoney(cmbTotalCheck.text) +
                   MyStrToMoney(cmbTotalOther.text) +
                   MyStrToMoney(cmbTotalDebit.text);
  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TFrmPaiCashRegClose.tmrCloseCashTimer(Sender: TObject);
begin
  inherited;
  if pnlCloseCash.Height - 21 < 0 then
  begin
    pnlCloseCash.Visible := False;
    tmrCloseCash.Enabled := False;
    ModalResult := mrOk;
  end
  else
    pnlCloseCash.Height := pnlCloseCash.Height - 20;
end;

procedure TFrmPaiCashRegClose.StartCheck;
begin
  TpOperation           := TP_CHECKING;

  // Titulo do tip
  lblTipCash.Caption    := sCloseCash12;
  lblSubTipCash.Caption := sEnterQty;

  // Invisible panel de valores ja contados
  pnlCountBill.Visible := False;
  pnlCountCoin.Visible := False;

  lblSugBill.Visible   := False;
  lblSugCoin.Visible   := False;

  pnllblBill.Top       := 33;
  pnllblCoin.Top       := 36;

  lblCountBill.Caption := sCount;
  lblCountCoin.Caption := sCount;

  // Troca o captions dos controles
  btClose.Caption      := sNext;
  btCancel.Caption     := sCancel;

  // Apaga os valores dos edits
  // ApagaEdit(grpBill);
  // ApagaEdit(grpCoin);

  // Seta os valores contados nos edits
  Edit100.Text  := wwDBEdit1.Text;
  Edit50.Text   := wwDBEdit2.Text;
  Edit20.Text   := wwDBEdit3.Text;
  Edit10.Text   := wwDBEdit4.Text;
  Edit5.Text    := wwDBEdit5.Text;
  Edit2.Text    := wwDBEdit6.Text;
  Edit1.Text    := wwDBEdit7.Text;
  Edit0100.Text := wwDBEdit8.Text;
  Edit050.Text  := wwDBEdit9.Text;
  Edit025.Text  := wwDBEdit10.Text;
  Edit010.Text  := wwDBEdit11.Text;
  Edit005.Text  := wwDBEdit12.Text;
  Edit001.Text  := wwDBEdit13.Text;

  // Seta o TotSystem
  EditTotSystem.Text  := FloatToStrF(MyResidual, ffCurrency, 20, 2);

  pnlDeposit.Visible := False;

  Edit100.SetFocus;
end;

procedure TFrmPaiCashRegClose.StartDeposit;
var
  aCaixa : TCaixa;
begin
  TpOperation           := TP_DEPOSIT;

  // Titulo do tip
  lblTipCash.Caption    := sCloseCash22;
  lblSubTipCash.Caption := sEnterQtyDeposit;

  // Invisible panel de valores ja contados
  pnlCountBill.Visible := True;
  pnlCountCoin.Visible := True;

  lblSugBill.Visible   := True;
  lblSugCoin.Visible   := True;

  pnllblBill.Top       := 13;
  pnllblCoin.Top       := 12;

  pnlCountBill.Top     := 32;
  pnlCountCoin.Top     := 36;

  lblSugBill.Caption   := sCounted;
  lblCountBill.Caption := sDeposit;

  lblSugCoin.Caption   := sCounted;
  lblCountCoin.Caption := sDeposit;

  // Troca o captions dos controles
  btClose.Caption      := sDeposit2;
  btCancel.Caption     := sBack;

  TotCounted           := TotCashGeral + TotOtherGeral;
  EditTotCounted.Text  := FloatToStrF(TotCounted, ffCurrency, 20, 2);

  // Seta os valores contados nos edits
  wwDBEdit1.Text         := Edit100.Text;
  wwDBEdit2.Text         := Edit50.Text;
  wwDBEdit3.Text         := Edit20.Text;
  wwDBEdit4.Text         := Edit10.Text;
  wwDBEdit5.Text         := Edit5.Text;
  wwDBEdit6.Text         := Edit2.Text;
  wwDBEdit7.Text         := Edit1.Text;
  wwDBEdit8.Text         := Edit0100.Text;
  wwDBEdit9.Text         := Edit050.Text;
  wwDBEdit10.Text        := Edit025.Text;
  wwDBEdit11.Text        := Edit010.Text;
  wwDBEdit12.Text        := Edit005.Text;
  wwDBEdit13.Text        := Edit001.Text;

  // Ajusta os valores do suggested
  aCaixa[0] := MyStrToInt(Edit100.Text);
  aCaixa[1] := MyStrToInt(Edit50.Text);
  aCaixa[2] := MyStrToInt(Edit20.Text);
  aCaixa[3] := MyStrToInt(Edit10.Text);
  aCaixa[4] := MyStrToInt(Edit5.Text);
  aCaixa[5] := MyStrToInt(Edit2.Text);
  aCaixa[6] := MyStrToInt(Edit1.Text);
  aCaixa[7] := MyStrToInt(Edit0100.Text);
  aCaixa[8] := MyStrToInt(Edit050.Text);
  aCaixa[9] := MyStrToInt(Edit025.Text);
  aCaixa[10] := MyStrToInt(Edit010.Text);
  aCaixa[11] := MyStrToInt(Edit005.Text);
  aCaixa[12] := MyStrToInt(Edit001.Text);

  // Funcao que retorna a melhor combinacao para retirar 500.00
  CountToDesired(aCaixa, TotCashGeral, DM.fSystem.SrvParam[PARAM_CASHREGRESTANT]);

  // Mostra so a diferenca

  // Coloca nos edits o resultado da funcao
  Edit100.Text := IntToStr(MyStrToInt(Edit100.Text)-aCaixa[0]);
  Edit50.Text  := IntToStr(MyStrToInt(Edit50.Text)-aCaixa[1]);
  Edit20.Text  := IntToStr(MyStrToInt(Edit20.Text)-aCaixa[2]);
  Edit10.Text  := IntToStr(MyStrToInt(Edit10.Text)-aCaixa[3]);
  Edit5.Text   := IntToStr(MyStrToInt(Edit5.Text)-aCaixa[4]);
  Edit2.Text   := IntToStr(MyStrToInt(Edit2.Text)-aCaixa[5]);
  Edit1.Text   := IntToStr(MyStrToInt(Edit1.Text)-aCaixa[6]);
  Edit0100.Text := IntToStr(MyStrToInt(Edit0100.Text)-aCaixa[7]);
  Edit050.Text  := IntToStr(MyStrToInt(Edit050.Text)-aCaixa[8]);
  Edit025.Text  := IntToStr(MyStrToInt(Edit025.Text)-aCaixa[9]);
  Edit010.Text  := IntToStr(MyStrToInt(Edit010.Text)-aCaixa[10]);
  Edit005.Text  := IntToStr(MyStrToInt(Edit005.Text)-aCaixa[11]);
  Edit001.Text  := IntToStr(MyStrToInt(Edit001.Text)-aCaixa[12]);

  pnlDeposit.Visible := True;

  Edit100.SetFocus;
end;

procedure TFrmPaiCashRegClose.ApagaEdit(MyGroup : TGroupBox);
var
  i : integer;
begin
  with MyGroup do
  begin
    for i := 0 to ControlCount -1 do
    begin
      if (Controls[i] is TEdit) then
        TEdit(Controls[i]).Text := '';
    end;
  end;
end;

procedure TFrmPaiCashRegClose.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(40);
end;

procedure TFrmPaiCashRegClose.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Key := ValidateNumbers(Key);

end;

procedure TFrmPaiCashRegClose.cmbTotalCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
     begin
       fCall := TEdit(Sender).Tag;
       btnTotalCardClick(Self);
     end;

end;

procedure TFrmPaiCashRegClose.btnTotalCardClick(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
     begin
        Case TSpeedButton(Sender).Tag of
         1 : AddValue(cmbTotalCard.Text);
         2 : AddValue(cmbTotalPre.Text);
         3 : AddValue(cmbTotalCheck.Text);
         4 : AddValue(cmbTotalOther.Text);
         5 : AddValue(cmbTotalDebit.Text);
        end;

     if ShowModal = mrOK then
        begin
        if fCall = -1 then
           fCall := TSpeedButton(Sender).Tag;
        Case fCall of
         1 : cmbTotalCard.Text  := MyFloatToStr(TotGeral);
         2 : cmbTotalPre.Text   := MyFloatToStr(TotGeral);
         3 : cmbTotalCheck.Text := MyFloatToStr(TotGeral);
         4 : cmbTotalOther.Text := MyFloatToStr(TotGeral);
         5 : cmbTotalDebit.Text := MyFloatToStr(TotGeral);
        end;
       fCall := -1;
     end;

     Free;
     end;

end;

procedure TFrmPaiCashRegClose.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sCloseCash12     := 'Closing Cash Register - Step 1/2';
           sCloseCash22     := 'Make Final Deposit - Step 2/2';
           sEnterQty        := 'Enter the quantity for each denomination in the appropriate box below plus respective other amounts.';
           sEnterQtyDeposit := 'Deposit quantities suggested in DEPOSIT row plus respective other amounts.';
           sCount           := 'Count :';
           sNext            := '&Next >>';
           sCancel          := '&Cancel';
           sCounted         := 'Counted :';
           sDeposit         := 'Deposit :';
           sDeposit2        := '&Deposit';
           sBack            := '<< &Back';
           end;

     LANG_PORTUGUESE :
           begin
           sCloseCash12     := 'Verificando o Total do Caixa com Total do Sistema - Passo 1/2';
           sCloseCash22     := 'Fazendo o depósito final - Passo 2/2';
           sEnterQty        := 'Entrar com a quantidade para cada denominação no campo apropriado.';
           sEnterQtyDeposit := 'Deposite no envelope as quantidades sugeridas na linha de ENVELOPE.';
           sCount           := 'Contado :';
           sNext            := '&Seguir >>';
           sCancel          := '&Cancelar';
           sCounted         := 'Contado :';
           sDeposit         := 'Envelope :';
           sDeposit2        := '&Depositar';
           sBack            := '<< &Voltar';
           end;

     LANG_SPANISH :
           begin
           sCloseCash12     := 'Verificando Total de Caja con Total del Sistema - Paso 1/2';
           sCloseCash22     := 'Depósito final - Paso 2/2';
           sEnterQty        := 'Entrar la cantidad para cada denominación en el campo adecuado.';
           sEnterQtyDeposit := 'Deposite las cantidades sugeridas en la fila del DEPOSITO.';
           sCount           := 'Contar :';
           sNext            := '&Siguiente >>';
           sCancel          := '&Cancelar';
           sCounted         := 'Contado :';
           sDeposit         := 'Depósito :';
           sDeposit2        := '&Depositar';
           sBack            := '<< &Voltar';
           end;
   end;
  
end;

procedure TFrmPaiCashRegClose.cmbTotalCardExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := FormatFloat('#,##0.00', MyStrToMoney(TEdit(Sender).Text)); 
end;

procedure TFrmPaiCashRegClose.ReadLogFile(fFile: String);
var
  CashInfo : TTXTCashInfo;
  i : Integer;
  logObject: TObject;
begin
  if (fFile = '') or (not FileExists(fFile)) then
     Exit;

  CashInfo := TTXTCashInfo.Create;
  try
    CashInfo.FileName := fFile;
    CashInfo.Load;

    cmbTotalCard.Text  := MyFloatToStr(CashInfo.SaleTotalCard + CashInfo.SaleTotalPreCard);
    cmbTotalCheck.Text := MyFloatToStr(CashInfo.SaleTotalCheck);
    cmbTotalOther.Text := MyFloatToStr(CashInfo.SaleTotalOther);
    cmbTotalDebit.Text := MyFloatToStr(CashInfo.SaleTotalDebit);

  finally
    FreeAndNil(CashInfo);
  end;

end;

procedure TFrmPaiCashRegClose.SetOthersValues(AIDCashRegMov: Integer);
var
  dCash, dCard, dOthers, dCheck, dDebit: Double;
begin

  dCash   := 0;
  dCard   := 0;
  dOthers := 0;
  dCheck  := 0;
  dDebit  := 0;

  with DMPDV.quTotalMeioPag do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDCashRegMov').Value := AIDCashRegMov;
    Open;
    First;
    while not Eof do
    begin
      case FieldByName('Tipo').AsInteger of
        PAYMENT_TYPE_CASH    : dCash   := dCash + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_CARD    : dCard   := dCard + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_OTHER   : dOthers := dOthers + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_CHECK   : dCheck  := dCheck + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_CREDIT  : dOthers := dOthers + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_GIFTCARD: dOthers := dOthers + FieldByName('Total').AsFloat;
        PAYMENT_TYPE_DEBIT   : dDebit  := dDebit + FieldByName('Total').AsFloat;
      end;
      Next;
    end;
  finally
    Close;
  end;

  with DMPDV.quTotalDeposited do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDCashRegMov').Value := AIDCashRegMov;
    Open;
    First;
    while not Eof do
    begin
      dCard   := dCard - FieldByName('TotalCard').AsFloat - FieldByName('TotalPre').AsFloat;
      dOthers := dOthers - FieldByName('TotalOther').AsFloat;
      dCheck  := dCheck - FieldByName('TotalCheck').AsFloat;
      dDebit  := dDebit - FieldByName('TotalDebit').AsFloat;
      Next;
    end;
  finally
    Close;
  end;

  cmbTotalCard.Text  := MyFloatToStr(dCard);
  cmbTotalCheck.Text := MyFloatToStr(dCheck);
  cmbTotalOther.Text := MyFloatToStr(dOthers);
  cmbTotalDebit.Text := MyFloatToStr(dDebit);
end;

end.
