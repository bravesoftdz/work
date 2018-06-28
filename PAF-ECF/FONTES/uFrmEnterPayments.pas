unit uFrmEnterPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, uPayments, Mask, DateBox,
  ExtCtrls, StdCtrls, SuperComboADO, ComCtrls, ImgList, uPreSale, DBCtrls;

type
  TFrmEnterPayments = class(TFrmParentAll)
    lbName: TLabel;
    edtName: TEdit;
    lbDoc: TLabel;
    edtCustomerDocument: TEdit;
    lbPhone: TLabel;
    edtPhone: TEdit;
    pnlDepositDate: TPanel;
    lbDate: TLabel;
    dtPayment: TDateBox;
    pnlAmount: TPanel;
    lbAmount: TLabel;
    edtAmount: TEdit;
    pnlEdit: TPanel;
    pnlFinalNumber: TPanel;
    lbCheckEnd: TLabel;
    edtFinalNumber: TEdit;
    pnlInitialNumber: TPanel;
    lbIniCheck: TLabel;
    edtInitialNumber: TEdit;
    pnlBank: TPanel;
    lbBank: TLabel;
    pnlFrequency: TPanel;
    Label1: TLabel;
    edtFrequency: TEdit;
    imgPayments: TImageList;
    lvwPayments: TListView;
    lbOBS: TLabel;
    edtOBS: TEdit;
    lbAuthori: TLabel;
    edtAuthor: TEdit;
    lbSearchCustomer: TLabel;
    cmbBank: TDBLookupComboBox;
    pnlTipoParcela: TPanel;
    Label2: TLabel;
    rbLoja: TRadioButton;
    rbAdm: TRadioButton;
    chPreComGarantia: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtInitialNumberExit(Sender: TObject);
    procedure edtFinalNumberExit(Sender: TObject);
    procedure lvwPaymentsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFrequencyChange(Sender: TObject);
    procedure edtFrequencyKeyPress(Sender: TObject; var Key: Char);
    procedure edtInitialNumberChange(Sender: TObject);
    procedure edtFinalNumberChange(Sender: TObject);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
    procedure rbLojaClick(Sender: TObject);
    procedure rbAdmClick(Sender: TObject);
  private
    PreSaleInfo : TPreSaleInfo;
    bResult : Boolean;
    Payment: TPayment;
    Items: TList;
    fTotalAmount: Currency;
    procedure HidePanels;
    procedure EnablePanels(PayType:Integer);
    procedure FillList;
    function ValidatePayments:Boolean;
    procedure CalcParcela;
    function RetNumParcelas: Integer;
    procedure RePaintList;
    procedure RefreshCustomer;
  public
    function Start(fPayment:TPayment; fPreSaleInfo : TPreSaleInfo; var AItems:TList):Boolean;
  end;

implementation

uses uSystemConst, uNumericFunctions, uDM, uMsgBox, uMsgConstant,
     uCharFunctions, uFrmSearchOption, uTEFConsts;

{$R *.dfm}

{ TFrmEnterPayments }

procedure TFrmEnterPayments.HidePanels;
begin
  pnlFrequency.Visible     := False;
  pnlBank.Visible          := False;
  pnlFinalNumber.Visible   := False;
  pnlInitialNumber.Visible := False;
  pnlTipoParcela.Visible   := False;
end;

procedure TFrmEnterPayments.EnablePanels(PayType:Integer);
Var
  bIsCheque : Boolean;
  bIsCardTEFDedicado : Boolean;
begin
  HidePanels;

  bIsCheque := (PayType = PAYMENT_TYPE_CHECK);
  bIsCardTEFDedicado := (PayType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT])
                         and (DM.fCashRegister.UseTef = TEF_DEDICADO);

  pnlTipoParcela.Visible   := bIsCardTEFDedicado;
  pnlFrequency.Visible     := Not bIsCheque;
  pnlBank.Visible          := bIsCheque;
  pnlInitialNumber.Visible := bIsCheque;
  pnlFinalNumber.Visible   := bIsCheque;
  lbAuthori.Visible        := not bIsCheque;
  edtAuthor.Visible        := not bIsCheque;
  chPreComGarantia.Visible := False;

  if DM.fCashRegister.UseTef = TEF_DEDICADO then
  begin
    Case Payment.Tipo of
      PAYMENT_TYPE_CARD : begin
                           rbLoja.Caption := 'Loja';
                           rbAdm.Caption  := 'Administradora';
                           end;
      PAYMENT_TYPE_DEBIT : begin
                           rbLoja.Caption := 'Pré-Datado';
                           rbAdm.Caption  := 'Parcelado';
                           chPreComGarantia.Visible := rbLoja.Checked;
                           end;
    end;
  end;


end;

function TFrmEnterPayments.Start(fPayment: TPayment; fPreSaleInfo : TPreSaleInfo;
  var AItems: TList): Boolean;
begin
  if DM.PersistenceType = ptDB then
    cmbBank.ListSource.DataSet.Open;

  bResult               := False;
  Payment               := fPayment;
  Items                 := AItems;
  fTotalAmount          := Payment.Amount;
  edtAmount.Text        := MyFloatToStr(Payment.Amount);
  dtPayment.Date        := Trunc(Now);
  PreSaleInfo           := fPreSaleInfo;
  rbLoja.Enabled        := True;

  RefreshCustomer;

  edtInitialNumber.Text := '1';
  edtFinalNumber.Text   := '1';

  EnablePanels(fPayment.Tipo);
  ShowModal;
  fPayment.TEFPreDatadaComGarantia := chPreComGarantia.Checked;
  Result := bResult;
end;

procedure TFrmEnterPayments.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  oSearch: TObject;
begin
  inherited;
  case Key of
    VK_RETURN:
      begin
        if DM.fCashRegister.UseTef = TEF_DEDICADO then
          if rbLoja.Checked then
            Payment.TEFTipoParcelamento := TEF_PARCELAMENTO_LOJA
          else
            Payment.TEFTipoParcelamento := TEF_PARCELAMENTO_ADM;

        if fTotalAmount = 0 then
           begin
           bResult := True;
           Close;
           Exit;
           end;

        if DM.fCashRegister.UseTef = TEF_DEDICADO then
          if rbLoja.Checked and (Payment.Tipo = PAYMENT_TYPE_DEBIT) then
              Payment.TEFPreDatada := Trunc(dtPayment.Date);

        if not ValidatePayments then
           Exit;

        FillList;
      end;

    VK_ESCAPE:
      begin
      bResult := False;
      Close;
      end;

    VK_F2:
      begin
       with TFrmSearchOption.Create(Self) do
       begin
       if StartOption(OP_CUSTOMER, oSearch) and (oSearch <> nil) then
          with PreSaleInfo do
             begin
             if oSearch is TCustomerInfo then
                CustomerInfo := TCustomerInfo(oSearch);
             end;
       Free;
       end;
      RefreshCustomer;
      end;
  end;
end;

procedure TFrmEnterPayments.FillList;
var
  I,
  IniPag,
  FimPag: Integer;
  Resta, Parc: Double;
  PartialPay: TPartialPay;
begin

  if Payment.Tipo = PAYMENT_TYPE_CHECK then
    begin
      IniPag := StrToInt(edtInitialNumber.Text);
      FimPag := StrToInt(edtFinalNumber.Text);
    end
  else
    begin
      IniPag := 1;
      FimPag := StrToInt(edtFrequency.Text);
    end;

  if (FimPag = IniPag) then
      Resta := MyStrToMoney(edtAmount.Text)
  else
      Resta := fTotalAmount;

  fTotalAmount := fTotalAmount - Resta;

  Parc  := MyRound(Resta / (FimPag - IniPag + 1), 2);
  for I := IniPag to FimPag do
  begin
    PartialPay := TPartialPay.Create;
    with PartialPay do
    begin
      if I = FimPag then
        Value := Resta
      else
        begin
          Value := Parc;
          Resta := Resta - Parc;
        end;
      if pnlBank.Visible then
        IDBanco       := cmbBank.KeyValue
      else
        IDBanco       := 0;

      NumeroDoc     := IntToStr(I);
      Telefone      := edtPhone.Text;
      Parcela       := IntToStr(I - IniPag + 1) + '/' + IntToStr(FimPag - IniPag + 1);
      OBS           := edtOBS.Text;
      Autorization  := edtAuthor.Text;
      NomeCliente   := edtName.Text;
      DocCliente    := edtCustomerDocument.Text;
      ExpireDate    := IncMonth(dtPayment.Date, I - IniPag);
      Banco         := cmbBank.Text;
    end;
    Items.Add(PartialPay);
  end;

  RePaintList;

  if DM.fCashRegister.UseTef = TEF_DEDICADO then
    if Payment.Tipo = PAYMENT_TYPE_DEBIT then
    begin
      rbLoja.Enabled := False;
    end;


end;

procedure TFrmEnterPayments.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmEnterPayments.ValidatePayments: Boolean;
var
  i,
  fInit, fEnd, fDoc : Integer;
begin
  Result := False;

  if RetNumParcelas > DM.fSystem.SrvParam[PARAM_MAX_NUMBER_PAYMENTS] then
  begin
    MsgBox(MSG_CRT_ERROR_MAX_PAYMENTS, vbCritical);
    Exit;
  end;

  if (Trim(edtAmount.Text) = '') and (MyStrToMoney(edtAmount.Text) <= 0) then
     begin
     MsgBox(MSG_CRT_NO_AMOUNT_ZERO, vbOKOnly + vbInformation);
     edtAmount.Text := FormatFloat('#,##0.00', fTotalAmount/RetNumParcelas);
     Exit;
     end;

  if (Payment.Tipo  = PAYMENT_TYPE_CARD) then
  begin
  if Trim(edtFrequency.Text) = '' then
     Exit;
  end;


  if (RetNumParcelas = 1) and ((MyStrToMoney(edtAmount.Text) * 1) > fTotalAmount) then
  begin
     MsgBox(MSG_CRT_NO_TOTAL_DIFFERENT, vbOKOnly + vbInformation);
     edtAmount.Text := FormatFloat('#,##0.00', MyRound(fTotalAmount/RetNumParcelas,2));
     Exit;
  end;


  if (Payment.Tipo  = PAYMENT_TYPE_CHECK) then
    begin
      if cmbBank.KeyValue = NULL then
      begin
        MsgBox(MSG_INF_CHOOSE_BANK, vbCritical + vbOKOnly);
        if cmbBank.CanFocus then
          cmbBank.SetFocus;
        Exit;
      end;

      if (Trim(edtInitialNumber.Text) = '') or (Trim(edtFinalNumber.Text) = '') then
         Exit;

      fInit := StrToInt(edtInitialNumber.Text);
      fEnd  := StrToInt(edtFinalNumber.Text);

      if fInit > fEnd then
      begin
        MsgBox(MSG_CRT_INVALID_DOCUMENT, vbCritical + vbOKOnly);
        if edtFinalNumber.CanFocus then
           edtFinalNumber.SetFocus;
        Exit;
      end;

      for I := 0 to Items.Count-1 do
        begin
        fDoc := MyStrToInt(TPartialPay(Items[i]).NumeroDoc);
        if (fDoc in [fInit..fEnd]) then
        begin
          MsgBox(Format(MSG_CRT_DOCUMENT_ALREDY_EXIST, [fDoc]), vbCritical + vbOkOnly);
          if edtInitialNumber.CanFocus then
             edtInitialNumber.SetFocus;
          Exit;
        end;
        end;
    end;

  Result := True;

end;

procedure TFrmEnterPayments.edtInitialNumberExit(Sender: TObject);
begin
  if MyStrToFloat(edtFinalNumber.Text) < MyStrToFloat(edtInitialNumber.Text) then
    edtFinalNumber.Text := edtInitialNumber.Text;
end;

procedure TFrmEnterPayments.CalcParcela;
var
  Parc : Currency;
begin
  Parc  := fTotalAmount / RetNumParcelas;
  edtAmount.Text := MyFloatToStr(MyRound(Parc, 2));
end;

function TFrmEnterPayments.RetNumParcelas: Integer;
var
  IniPag, FimPag: Integer;
begin
  if Payment.Tipo = PAYMENT_TYPE_CHECK then
    begin
      IniPag := StrToInt(edtInitialNumber.Text);
      FimPag := StrToInt(edtFinalNumber.Text);
    end
  else
    begin
      IniPag := 1;
      FimPag := StrToInt(edtFrequency.Text);
    end;
  Result := (FimPag - IniPag + 1);
end;

procedure TFrmEnterPayments.edtFinalNumberExit(Sender: TObject);
begin
  if MyStrToFloat(edtFinalNumber.Text) < MyStrToFloat(edtInitialNumber.Text) then
    edtFinalNumber.Text := edtInitialNumber.Text;
  CalcParcela;
end;

procedure TFrmEnterPayments.RePaintList;
var
  i : Integer;
  lviItem: TListItem;
begin

  lvwPayments.Items.BeginUpdate;
  try
    lvwPayments.Items.Clear;
    for i:=0 to Items.Count-1 do
    begin
      lviItem := lvwPayments.Items.Add;
      lviItem.Caption := TPartialPay(Items[i]).Parcela;
      lviItem.SubItems.Add(TPartialPay(Items[i]).NumeroDoc);
      lviItem.SubItems.Add(TPartialPay(Items[i]).Banco);
      lviItem.SubItems.Add(FormatDateTime('ddddd', TPartialPay(Items[i]).ExpireDate));
      lviItem.SubItems.Add(FormatFloat('#,##0.00',TPartialPay(Items[i]).Value));

      lviItem.Data := Items[i];
      lviItem.ImageIndex := 0;
    end;
  finally
    lvwPayments.Items.EndUpdate;
  end;

  edtFrequency.Text := '1';
  edtAmount.Text    := FormatFloat('#,##0.00',fTotalAmount);

  if lvwPayments.Items.Count > 0 then
     lvwPayments.Selected := lvwPayments.Items[lvwPayments.Items.Count - 1];

end;

procedure TFrmEnterPayments.lvwPaymentsKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  PartialPay : TPartialPay;
begin
  inherited;

  Case Key of
   VK_DELETE : begin
               if lvwPayments.Selected <> nil then
                  begin
                  PartialPay := Items[Items.IndexOf(lvwPayments.Selected.Data)];
                  Items.Delete(Items.IndexOf(lvwPayments.Selected.Data));
                  fTotalAmount := fTotalAmount + PartialPay.Value;
                  RePaintList;
                  if ((DM.fCashRegister.UseTef = TEF_DEDICADO) and (Payment.Tipo = PAYMENT_TYPE_DEBIT)) then
                    rbLoja.Enabled := (lvwPayments.Items.Count = 0);
                  end;
               end;
  end;
  
end;

procedure TFrmEnterPayments.edtFrequencyChange(Sender: TObject);
begin
  inherited;
  if (Trim(edtFrequency.Text) = '') or (MyStrToInt(edtFrequency.Text) = 0) then
      edtFrequency.Text := '1';

  if DM.fCashRegister.UseTef = TEF_DEDICADO then
    if (Payment.Tipo = PAYMENT_TYPE_DEBIT) and rbLoja.Checked then
    begin
      edtFrequency.Text := '1';
    end;

  CalcParcela;
end;

procedure TFrmEnterPayments.edtFrequencyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmEnterPayments.edtInitialNumberChange(Sender: TObject);
begin
  inherited;
  if (Trim(edtInitialNumber.Text) = '') or (MyStrToInt(edtInitialNumber.Text) = 0) then
      edtInitialNumber.Text := '1';
  edtFinalNumber.Text := edtInitialNumber.Text;
end;

procedure TFrmEnterPayments.edtFinalNumberChange(Sender: TObject);
begin
  inherited;
  if ((Trim(edtFinalNumber.Text) = '') or (MyStrToInt(edtFinalNumber.Text) = 0)) then
      edtFinalNumber.Text := edtInitialNumber.Text;
end;

procedure TFrmEnterPayments.edtAmountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmEnterPayments.RefreshCustomer;
begin
  if PreSaleInfo.CustomerInfo <> nil then
     begin
     edtName.Text             := PreSaleInfo.CustomerInfo.FirstName + ' ' +
                                 PreSaleInfo.CustomerInfo.LastName;;
     edtCustomerDocument.Text := PreSaleInfo.CustomerInfo.CPF;
     edtPhone.Text            := PreSaleInfo.CustomerInfo.Telefone;
     end;
end;

procedure TFrmEnterPayments.rbLojaClick(Sender: TObject);
begin
  inherited;
  if DM.fCashRegister.UseTef = TEF_DEDICADO then
  begin
    if Payment.Tipo = PAYMENT_TYPE_DEBIT then
    begin
      edtFrequency.Text := '1';
    end;
    chPreComGarantia.Visible := (rbLoja.Checked and (Payment.Tipo = PAYMENT_TYPE_DEBIT));
  end;
end;

procedure TFrmEnterPayments.rbAdmClick(Sender: TObject);
begin
  inherited;
  if DM.fCashRegister.UseTef = TEF_DEDICADO then
    chPreComGarantia.Visible := (rbLoja.Checked and (Payment.Tipo = PAYMENT_TYPE_DEBIT));
end;

end.
