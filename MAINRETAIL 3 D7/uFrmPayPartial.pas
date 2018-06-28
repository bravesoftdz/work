unit uFrmPayPartial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, Grids, DateBox, ComCtrls, ImgList;

const
  P_NAME    = 0;
  P_FREQ    = 1;
  P_DATE    = 2;
  P_AMOUNT  = 3;

type

  TPartialPay = class
    NomeCliente,
    Telefone,
    DocCliente,
    Banco,
    NumeroDoc,
    OBS,
    Authorization: ShortString;
    ExpireDate,
    PreSaleDate : TDateTime;
    Valor : Double;
    IDPreSale,
    IDPaymentType,
    TypeOfPayment,
    IDCashRegMov,
    IDLancamento,
    PaymentPlace: Integer;
    IDCashRegMovClosed: Integer;
  end;

  TFrmPayPartial = class(TFrmParentAll)
    cmbPaymentType: TSuperComboADO;
    btnDel: TSpeedButton;
    btnDelAll: TSpeedButton;
    ImageList1: TImageList;
    btnAdd: TSpeedButton;
    pnlCustomer: TPanel;
    shpHelp: TShape;
    lbCustomerInfo: TLabel;
    lbName: TLabel;
    edtName: TEdit;
    lbDoc: TLabel;
    edtCustomerDocument: TEdit;
    lbPhone: TLabel;
    edtPhone: TEdit;
    pnlPaymentInfo: TPanel;
    Shape1: TShape;
    lbPayment: TLabel;
    pnlEdit: TPanel;
    pnlFinalNumber: TPanel;
    edtFinalNumber: TEdit;
    pnlInitialNumber: TPanel;
    edtInitialNumber: TEdit;
    pnlBank: TPanel;
    scBank: TSuperComboADO;
    pnlFrequency: TPanel;
    edtFrequency: TEdit;
    lbFrequency: TLabel;
    lbBank: TLabel;
    lbIniCheck: TLabel;
    lbCheckEnd: TLabel;
    pnlDepositDate: TPanel;
    EditDepositDate: TDateBox;
    pnlAmount: TPanel;
    edtAmount: TEdit;
    lbDate: TLabel;
    lbAmount: TLabel;
    pnlPayments: TPanel;
    lbPayments: TLabel;
    tvPartialPay: TTreeView;
    pnlPayDetail: TPanel;
    pnlOBSDetail: TPanel;
    lbPOBS: TLabel;
    sbSaveOBS: TSpeedButton;
    edtOBS: TEdit;
    pnlAmountDetail: TPanel;
    lbPAmount: TLabel;
    edtValue: TEdit;
    pnlDocDetail: TPanel;
    lbPDoc: TLabel;
    edtDoc: TEdit;
    pnlDateDetail: TPanel;
    lbPDate: TLabel;
    edtDate: TDateBox;
    pnlBankDetail: TPanel;
    lbPBank: TLabel;
    Shape2: TShape;
    scBankEdit: TSuperComboADO;
    sbSerasa: TSpeedButton;
    lblConsulta: TLabel;
    pnlPaymentPlace: TPanel;
    cmbPaymentPlace: TComboBox;
    lblPaymentPlace: TLabel;
    edtDDD: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure edtFrequencyKeyPress(Sender: TObject; var Key: Char);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
    procedure edtFrequencyChange(Sender: TObject);
    procedure btnDelAllClick(Sender: TObject);
    procedure tvPartialPayChange(Sender: TObject; Node: TTreeNode);
    procedure tvPartialPayClick(Sender: TObject);
    procedure edtFinalNumberChange(Sender: TObject);
    procedure edtInitialNumberChange(Sender: TObject);
    procedure sbSaveOBSClick(Sender: TObject);
    procedure edtOBSExit(Sender: TObject);
    procedure sbSerasaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fTotal,
    fTotalEntered,
    fResto,
    fTotalPayment : Currency;
    fFrequency,
    iPaymentType,
    fIDCashRegMov : Integer;
    fHasDeposit : Boolean;
    IDPreSale: Integer;
    fPreMessage,
    fAuthorization : String;
    fPreSaleDate: TDateTime;
    fFormOfPayment,
    fPaymentPlace : Integer;
    lstDeleted : TList;
    procedure SetDetailVisible(bVisible:Boolean);
    procedure ClearPayments;
    procedure GetTotalEntered;
    function VerifyTotal:Boolean;
    function CalculaParcela(Parcelas: Integer): Currency;
    procedure EnablePanels;
    procedure RemovePartialPay(Node: TTreeNode);
    procedure UpdateOBS;
    procedure GetCustomerInfo(IDCostumer: Integer);
    procedure HidePayments;
    procedure HidePanels;
    procedure NewPartialPay(NomeCliente, Telefone,
      DocCliente, Banco, NumeroDoc, OBS, Authorization: ShortString;
      ExpireDate, PreSaleDate: TDateTime; Valor: Double; IDPreSale, IDPaymentType,
      IDCashRegMov, IDLancamento, PaymentPlace, IDCashRegMovClosed: Integer);
    procedure GetPayments;
    procedure EnableSerasa;
    function IsDeleted(IDLancamento: Integer): Boolean;
    function ValidatePartialPay(iBegin, iEnd: LongInt; sBank: String) : Boolean;
    function ValidateFields:Boolean;
    function IsInTree(sDocument, sIDBanco: String) : Boolean;
  public
    { Public declarations }
    procedure ClearPaymentList;
    property HasDeposit : Boolean read fHasDeposit;
    function Start(IDPaymentType, IDCustomer, IDPreSale, IDCashRegMov:Integer;
                   Total: Currency;PreSaleDate: TDateTime;
                   Authorization: ShortString;
                   FormOfPayment, PaymentPlace: Integer):String;
  end;

implementation

uses uDM, uDMGlobal, uCharFunctions, uNumericFunctions, uDateTimeFunctions,
     uMsgConstant, uMsgBox, ADODB, uSystemConst, uPassword, uFrmSERASA;

{$R *.dfm}

function TFrmPayPartial.VerifyTotal:Boolean;
begin

  Result := False;

  if not (fTotal = fTotalEntered) then
     begin
     MsgBox(MSG_CRT_NO_TOTAL_DIFFERENT, vbOKOnly + vbInformation);
     Exit;
     end;


  Result := True;

end;

procedure TFrmPayPartial.GetTotalEntered;
Var
   I, x : Integer;
begin
   fTotalEntered := 0;
   fFrequency := tvPartialPay.Items.Count - 1;
   for I := 0 to tvPartialPay.Items.Count - 1 do
     fTotalEntered := fTotalEntered + TPartialPay(tvPartialPay.Items[I].Data).Valor;

   edtAmount.Text        := CurrToStr(fTotal-fTotalEntered);

   edtFrequency.Text     := '1';
   edtInitialNumber.Text := '';
   edtFinalNumber.Text   := '';

end;

procedure TFrmPayPartial.ClearPaymentList;
var
  i : Integer;
begin
  fHasDeposit := False;
  fTotal      := 0;

  while tvPartialPay.Items.Count > 0 do
    RemovePartialPay(tvPartialPay.Items[0]);

  scBank.LookUpValue := '';

end;

function TFrmPayPartial.Start(IDPaymentType, IDCustomer, IDPreSale,
                              IDCashRegMov:Integer; Total: Currency;
                              PreSaleDate: TDateTime;
                              Authorization: ShortString;
                              FormOfPayment,
                              PaymentPlace: Integer):String;
begin
  Self.IDPreSale := IDPreSale;
  cmbPaymentType.LookUpValue := IntToStr(IDPaymentType);
  lbPayment.Caption          := cmbPaymentType.Text;
  EditDepositDate.Date       := Now;

  iPaymentType               := MyStrToInt(DM.DescCodigo(['IDMeioPag'], [cmbPaymentType.LookUpValue], 'MeioPag', 'Tipo'));
  fAuthorization             := Authorization;
  fIDCashRegMov              := IDCashRegMov;
  fPreSaleDate               := PreSaleDate;
  fFormOfPayment             := FormOfPayment;
  fPaymentPlace              := PaymentPlace;

  cmbPaymentPlace.ItemIndex  := fPaymentPlace;

  lblConsulta.Visible        := (PaymentPlace in [1, 2]) and (iPaymentType = PAYMENT_TYPE_CHECK);

  GetPayments;

  fTotal                     := Total + fTotalPayment;

  GetTotalEntered;

  EnablePanels;
  GetCustomerInfo(IDCustomer);

  SetDetailVisible(False);

  ShowModal;

  if not fHasDeposit then
     Result := ''
  else
     Result := fPreMessage;

end;

procedure TFrmPayPartial.FormCreate(Sender: TObject);
begin
  inherited;

  lstDeleted := TList.Create;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           fPreMessage  := 'Particionate Payment';
           end;

     LANG_PORTUGUESE :
           begin
           fPreMessage  := 'Pgtos Cadastrado';
           end;

     LANG_SPANISH :
           begin
           fPreMessage  := 'Pre-Datado';
           end;
   end;


  DM.imgSmall.GetBitmap(BTN18_NEW, btnAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDel.Glyph);

end;

procedure TFrmPayPartial.EnableSerasa;
begin
  sbSerasa.Visible := DM.fSystem.SrvParam[PARAM_CONSULTA_SERASA]
                      and (TPartialPay(tvPartialPay.Selected.Data).TypeOfPayment = PAYMENT_TYPE_CHECK)
                      and (DMGlobal.IDLanguage = LANG_PORTUGUESE) ;
end;

procedure TFrmPayPartial.btCloseClick(Sender: TObject);
begin
  inherited;

  if not VerifyTotal then
     Exit;

  Close;
end;

procedure TFrmPayPartial.btnAddClick(Sender: TObject);
var
  fFreq, fInitIn : Integer;
  i : LongInt;
  MyDate : TDate;
  fSunPayments, fValor : Currency;
  Node : TTreeNode;
begin
  inherited;

  if not ValidateFields then
     Exit;

  fHasDeposit := True;

  MyDate       := EditDepositDate.Date;
  fSunPayments := 0;

  case iPaymentType of
    PAYMENT_TYPE_CHECK:
      begin
        fInitIn := StrToInt(edtInitialNumber.Text);
        fFreq   := StrToInt(edtFinalNumber.Text);
      end;
    else
      begin
        fInitIn := 1;
        fFreq   := StrToInt(edtFrequency.Text);
      end;
  end;

  if not ValidatePartialPay(fInitIn, fFreq, scBank.LookUpValue) then
    Exit;


  //Calcular a ultima parcela para nao ter diferenca
  for i := fInitIn to fFreq do
  begin
    if (i = fFreq) and (fFreq > 1) and (fResto<>0)then
      begin
        fValor  := MyStrToMoney(edtAmount.Text)+fResto;
      end
    else
      begin
        fValor  := MyStrToMoney(edtAmount.Text);
        fSunPayments := fSunPayments + MyStrToMoney(edtAmount.Text);
      end;

    NewPartialPay(edtName.Text,
                  edtPhone.Text,
                  edtCustomerDocument.Text,
                  scBank.LookUpValue,
                  IntToStr(I),
                  '',
                  '',
                  MyDate,
                  fPreSaleDate,
                  fValor,
                  IDPreSale,
                  MyStrToInt(cmbPaymentType.LookUpValue),
                  fIDCashRegMov,
                  -1,
                  cmbPaymentPlace.ItemIndex,
                  -1);


     //Next Values
     if fFormOfPayment <>  0 then
       MyDate := IncMonth(MyDate, 1);
  end;

  EditDepositDate.Date := MyDate;

  GetTotalEntered;

end;

function TFrmPayPartial.ValidatePartialPay(iBegin, iEnd: LongInt; sBank: String) : Boolean;
var
  I : Integer;
  iMaxDaysPayingNow : Integer;
begin
  Result := True;

  if (tvPartialPay.Items.Count + iEnd - iBegin + 1) > DM.fSystem.SrvParam[PARAM_MAX_NUMBER_PAYMENTS] then
  begin
    Result := False;
    MsgBox(MSG_CRT_ERROR_MAX_PAYMENTS, vbCritical);
    Exit;
  end;

  if cmbPaymentPlace.ItemIndex < 0 then
  begin
    Result := False;
    MsgBox(MSG_CRT_NO_VALID_SELECTION, vbCritical);
    if cmbPaymentPlace.CanFocus then
      cmbPaymentPlace.SetFocus;
    Exit;
  end;

  iMaxDaysPayingNow  := DM.fSystem.SrvParam[PARAM_MAX_NUMBER_DAYS_PAYING_NOW];

  if (fFormOfPayment = 0) and (iMaxDaysPayingNow >= 0) then
    if (EditDepositDate.Date - Date) > iMaxDaysPayingNow then
    begin
      MsgBox(Format(MSG_CRT_ERROR_MAX_NUM_PAYNOW, [iMaxDaysPayingNow]), vbCritical);
      Result := False;
      Exit;
    end;

  if (iPaymentType = PAYMENT_TYPE_CHECK) then
  begin
    if scBank.LookUpValue = '' then
    begin
      MsgBox(MSG_INF_CHOOSE_BANK, vbCritical + vbOKOnly);
      Result := False;
      Exit;
    end;

    for I := iBegin to iEnd do
    begin
      if IsInTree(IntToStr(I), sBank) then
      begin
        MsgBox(Format(MSG_CRT_DOCUMENT_ALREDY_EXIST, [I]), vbCritical + vbOkOnly);
        Result := False;
        Break;
      end;
    end;

  end;

end;

procedure TFrmPayPartial.btnDelClick(Sender: TObject);
var
  bCanDelete: boolean;
begin
  bCanDelete := True;
  if tvPartialPay.Selected <> nil then
  begin

    if (TPartialPay(tvPartialPay.Selected.Data).IDCashRegMovClosed <> -1) then
      begin
        bCanDelete := False;
        MsgBox(MSG_CRT_NO_DEL_RECEIVED_PAYMENT, vbCritical + vbOkOnly);
        Exit;
      end;

    if (TPartialPay(tvPartialPay.Selected.Data).IDCashRegMov <> fIDCashRegMov) and
       (TPartialPay(tvPartialPay.Selected.Data).IDLancamento <> -1) then
    begin
      bCanDelete := Password.HasFuncRight(44);
      if bCanDelete then
        begin
          bCanDelete := MsgBox(MSG_QST_DEL_REGISTERED_PAYMENT1+'()'+
                               MSG_QST_DEL_REGISTERED_PAYMENT2,
                               vbYesNo + vbQuestion) = vbYes;
        end
      else
        MsgBox(MSG_CRT_NO_ACCESS, vbOKOnly + vbInformation);
    end;

    If bCanDelete Then
    begin
      if TPartialPay(tvPartialPay.Selected.Data).IDLancamento <> -1 then
        lstDeleted.Add(Pointer(LongInt(TPartialPay(tvPartialPay.Selected.Data).IDLancamento)));
      RemovePartialPay(tvPartialPay.Selected);
    end;
  end;

  GetTotalEntered;

  if tvPartialPay.Items.Count<=0 then
     ClearPayments;
end;

procedure TFrmPayPartial.RemovePartialPay(Node: TTreeNode);
begin
  TPartialPay(Node.Data).Free;
  Node.Data := Nil;
  tvPartialPay.Items.Delete(Node);
end;

procedure TFrmPayPartial.edtFrequencyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateQty(Key);
end;

procedure TFrmPayPartial.edtAmountKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

procedure TFrmPayPartial.edtFrequencyChange(Sender: TObject);
begin
  if (Trim(edtFrequency.Text) = '') or (MyStrToInt(edtFrequency.Text) = 0) then
    edtFrequency.Text := '1';



  //Testa pra ver so a ultima parcela vai ser menor que zero
  if ((CalculaParcela(MyStrToInt(edtFrequency.Text))+fResto) < 0) and (fTotal > 0) then
     begin
     MsgBox(MSG_CRT_NO_TOTAL_DIFFERENT, vbOKOnly + vbInformation);
     edtFrequency.Text := '1';
     Exit;
     end;
  edtAmount.Text := FormatFloat('#,##0.00', CalculaParcela(MyStrToInt(edtFrequency.Text)) );
end;

function TFrmPayPartial.CalculaParcela(Parcelas: Integer) : Currency;
begin
  inherited;
  fResto   := (fTotal-fTotalEntered) - MyRound(((fTotal-fTotalEntered)/Parcelas),2) * Parcelas;
  Result := MyRound((fTotal-fTotalEntered)/Parcelas,2);
end;

procedure TFrmPayPartial.btnDelAllClick(Sender: TObject);
begin
  inherited;
  ClearPaymentList;
  lstDeleted.Clear;
  Close;
end;

procedure TFrmPayPartial.tvPartialPayChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if Node <> nil then
  begin
    scBankEdit.LookUpValue  := TPartialPay(Node.Data).Banco;
    edtDoc.Text             := TPartialPay(Node.Data).DocCliente;
    edtDate.Date            := TPartialPay(Node.Data).ExpireDate;
    edtValue.Text           := FormatFloat('#,##0.00', TPartialPay(Node.Data).Valor);
    edtOBS.Text             := TPartialPay(Node.Data).OBS;
    EnableSerasa;
  end;
end;

procedure TFrmPayPartial.tvPartialPayClick(Sender: TObject);
begin
  inherited;
     SetDetailVisible(tvPartialPay.Selected <> Nil);
end;

procedure TFrmPayPartial.edtFinalNumberChange(Sender: TObject);
begin
  inherited;
  if MyStrToInt(edtFinalNumber.Text) > 0 Then
    edtAmount.Text := FormatFloat('#,##0.00', CalculaParcela(MyStrToInt(edtFinalNumber.Text) - MyStrToInt(edtInitialNumber.Text) + 1));
end;

procedure TFrmPayPartial.HidePanels;
begin
  pnlFrequency.Visible     := False;
  pnlFinalNumber.Visible   := False;
  pnlInitialNumber.Visible := False;
  pnlBank.Visible          := False;
end;

procedure TFrmPayPartial.EnablePanels;
Var
  bIsCheque : Boolean;
begin
  HidePanels;

  bIsCheque := iPaymentType = PAYMENT_TYPE_CHECK;
  pnlFrequency.Visible     := Not bIsCheque;
  pnlBank.Visible          := bIsCheque;
  pnlInitialNumber.Visible := bIsCheque;
  pnlFinalNumber.Visible   := bIsCheque;
end;

procedure TFrmPayPartial.edtInitialNumberChange(Sender: TObject);
begin
  inherited;
  edtFinalNumber.Text := edtInitialNumber.Text;
end;

procedure TFrmPayPartial.UpdateOBS;
begin
  if tvPartialPay.Selected <> nil then
    TPartialPay(tvPartialPay.Selected.Data).OBS := edtOBS.Text;
end;

procedure TFrmPayPartial.sbSaveOBSClick(Sender: TObject);
begin
  inherited;
  UpdateOBS;
end;


procedure TFrmPayPartial.GetCustomerInfo(IDCostumer: Integer);
begin
  If IDCostumer <= 1 Then
    Exit;
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text :=
    Format(
      'SELECT PessoaFirstName, PessoaLastName,'+
      'Telefone,CPF, PhoneAreaCode FROM Pessoa WHERE IDPESSOA = %D',
      [IDCostumer]);
    try
      Open;
      edtName.Text             := FieldByName('PessoaFirstName').AsString + ' ' +
                                  FieldByName('PessoaLastName').AsString;
      edtCustomerDocument.Text := FieldByName('CPF').AsString;
      edtPhone.Text            := FieldByName('Telefone').AsString;
      edtDDD.Text              := FieldByName('PhoneAreaCode').AsString;
    finally
      Close;
    end;
  end;
end;

procedure TFrmPayPartial.SetDetailVisible(bVisible:Boolean);
begin
  HidePayments;
  Application.ProcessMessages;
  pnlBankDetail.Visible   := bVisible And
    (TPartialPay(tvPartialPay.Selected.Data).TypeOfPayment = PAYMENT_TYPE_CHECK);
  pnlDateDetail.Visible   := bVisible;
  pnlDocDetail.Visible    := bVisible;
  pnlAmountDetail.Visible := bVisible;
  pnlOBSDetail.Visible    := bVisible;
end;

procedure TFrmPayPartial.ClearPayments;
begin
  HidePayments;

  scBankEdit.Clear;
  edtDate.Clear;
  edtDoc.Clear;
  edtValue.Clear;
end;

procedure TFrmPayPartial.HidePayments;
begin
  pnlOBSDetail.Visible    := False;
  pnlAmountDetail.Visible := False;
  pnlDocDetail.Visible    := False;
  pnlDateDetail.Visible   := False;
  pnlBankDetail.Visible   := False;
end;

procedure TFrmPayPartial.edtOBSExit(Sender: TObject);
begin
  inherited;
  UpdateOBS;
end;

procedure TFrmPayPartial.NewPartialPay(NomeCliente, Telefone,
      DocCliente, Banco, NumeroDoc, OBS, Authorization: ShortString;
      ExpireDate, PreSaleDate: TDateTime; Valor: Double; IDPreSale, IDPaymentType,
      IDCashRegMov, IDLancamento, PaymentPlace, IDCashRegMovClosed: Integer);
Var
  Node : TTreeNode;
begin
  Node := tvPartialPay.Items.Add(tvPartialPay.Items.GetFirstNode, NumeroDoc);
  Node.ImageIndex := 0;

  Node.Data := TPartialPay.Create;

  TPartialPay(Node.Data).ExpireDate    := ExpireDate;
  TPartialPay(Node.Data).IDPaymentType := IDPaymentType;
  TPartialPay(Node.Data).Banco         := Banco;
  TPartialPay(Node.Data).DocCliente    := DocCliente;

  TPartialPay(Node.Data).NomeCliente   := NomeCliente;
  TPartialPay(Node.Data).Telefone      := Telefone;
  TPartialPay(Node.Data).NumeroDoc     := NumeroDoc;
  TPartialPay(Node.Data).IDPreSale     := IDPreSale;
  TPartialPay(Node.Data).OBS           := OBS;
  TPartialPay(Node.Data).Valor         := Valor;

  TPartialPay(Node.Data).Authorization := Authorization;
  TPartialPay(Node.Data).PreSaleDate   := PreSaleDate;
  TPartialPay(Node.Data).IDCashRegMov  := IDCashRegMov;
  TPartialPay(Node.Data).IDLancamento  := IDLancamento;
  TPartialPay(Node.Data).PaymentPlace  := PaymentPlace;

  TPartialPay(Node.Data).IDCashRegMovClosed := IDCashRegMovClosed;

  TPartialPay(Node.Data).TypeOfPayment :=
      MyStrToInt(DM.DescCodigo(['IDMeioPag'], [IntToStr(IDPaymentType)],
                 'MeioPag', 'Tipo'));

end;

procedure TFrmPayPartial.GetPayments;
var
  I : Integer;
  lstItems : TList;
  Node : TTreeNode;
//  iIDLancamento : Integer;
begin
  lstItems := TList.Create;
  try
    for I := 0 to tvPartialPay.Items.Count-1 do
      if TPartialPay(tvPartialPay.Items[I].Data).IDLancamento <> -1 then
      lstItems.Add(tvPartialPay.Items[I]);

    for I := 0 to lstItems.Count-1 do
    begin
      Node := TTreeNode(lstItems.Items[I]);
      RemovePartialPay(Node);
    end;
  finally
    lstItems.Free;
  end;

  fTotalPayment := 0;
  with TADOQuery.Create(Self) do
  begin
    try
      Connection := DM.ADODBConnect;
      LockType   := ltReadOnly;
      CursorType := ctOpenForwardOnly;
      SQL.Text   :=
        Format('SELECT CheckNumber, IDBankCheck, CustomerDocument, CustomerName,'+
               'CustomerPhone, ValorNominal, Historico, IDQuitacaoMeioPrevisto, '+
               'DataVencimento, IDCashRegMov, DataLancamento, NumMeioQuitPrevisto, '+
               'IDLancamento, PaymentPlace, IsNull(IDCashRegMovClosed, -1) AS IDCashRegMovClosed '+
               'FROM Fin_Lancamento INNER JOIN MeioPag ON '+
               'Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag '+
               'WHERE IDPreSale = %D AND '+
               '(MeioPag.Tipo in (%D, %D)) '+
               'AND IsPreDatado = 1 '+
               'ORDER BY NumDesdobramento',
                [IDPreSale, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_CARD]);
      Open;
      while not EOF do
      begin
        if not IsDeleted(FieldByName('IDLancamento').AsInteger) then
        begin

          {if FieldByName('IDCashRegMov').IsNull Then
            iCashregMov := -1
          else
            iCashregMov := FieldByName('IDCashRegMov').AsInteger;}

          NewPartialPay(FieldByName('CustomerName').AsString,
                        FieldByName('CustomerPhone').AsString,
                        FieldByName('CustomerDocument').AsString,
                        FieldByName('IDBankCheck').AsString,
                        FieldByName('CheckNumber').AsString,
                        FieldByName('Historico').AsString,
                        FieldByName('NumMeioQuitPrevisto').AsString,
                        FieldByName('DataVencimento').AsDateTime,
                        FieldByName('DataLancamento').AsDateTime,
                        FieldByName('ValorNominal').AsCurrency,
                        IDPreSale,
                        FieldByName('IDQuitacaoMeioPrevisto').AsInteger,
                        FieldByName('IDCashRegMov').AsInteger,
                        FieldByName('IDLancamento').AsInteger,
                        FieldByName('PaymentPlace').AsInteger,
                        FieldByName('IDCashRegMovClosed').AsInteger);

        end;
        fTotalPayment := fTotalPayment + FieldByName('ValorNominal').AsCurrency;
        Next;
      end;
    finally
      Close;
      Free;
    end;
  end;

end;

function TFrmPayPartial.IsDeleted(IDLancamento: Integer): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 0 to lstDeleted.Count -1 do
    If LongInt(lstDeleted[I]) =  LongInt(IDLancamento) Then
    begin
      Result := true;
      Break;
    end;
end;

function TFrmPayPartial.IsInTree(sDocument, sIDBanco: String) : Boolean;
var
  I,
  iBanco : Integer;
begin
  Result := False;
  for I := 0 to tvPartialPay.Items.Count-1 do
  begin
    if (StrToint(TPartialPay(tvPartialPay.Items[I].Data).NumeroDoc) = StrToInt(sDocument)) and
      (TPartialPay(tvPartialPay.Items[I].Data).Banco = sIDBanco) Then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TFrmPayPartial.sbSerasaClick(Sender: TObject);
var
  FrmSERASAConsulta : TFrmSERASA;
begin
  inherited;
  with TFrmSERASA.Create(Self) do
  FrmSERASAConsulta := TFrmSERASA.Create(Self);

  FrmSERASAConsulta.Start(
    edtName.Text,
    edtCustomerDocument.Text,
    edtDDD.Text, 
    edtPhone.Text,
    scBank.LookUpValue,
    edtInitialNumber.Text, edtFinalNumber.Text, EditDepositDate.Date,
    MyStrToMoney(edtAmount.Text));
end;

function TFrmPayPartial.ValidateFields: Boolean;
begin
  Result := True;

  if (Trim(edtAmount.Text) = '') and (MyStrToMoney(edtAmount.Text) <= 0) then
     begin
     MsgBox(MSG_CRT_NO_AMOUNT_ZERO, vbOKOnly + vbInformation);
     Result := False;
     Exit;
     end;

  case iPaymentType of
    PAYMENT_TYPE_CHECK:
      begin
        if (Trim(edtInitialNumber.Text) = '') or (Trim(edtFinalNumber.Text) = '') then
           begin
           MsgBox(MSG_CRT_INVALID_CHECK_NUMBER, vbOKOnly + vbInformation);
           Result := False;
           Exit;
           end;
      end;
    else
      begin
      if Trim(edtFrequency.Text) = '' then
         begin
           MsgBox(MSG_CRT_NO_VALID_FREQUENCY, vbOKOnly + vbInformation);
           Result := False;
           Exit;
         end;
      end;
  end;

end;

procedure TFrmPayPartial.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstDeleted);
end;

end.
