unit uFrmStoreAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SubListPanel, ComCtrls, DB, ADODB, DBClient, Provider, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData, uFrmPayPartial,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, uPCCIntegration,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  SuperComboADO, SuperEdit, uFrmCreditPay, uCCMercuryIntegration, registry,
  uOperationSystem, contnrs;

type
  // MR doesn't use class structures well defined.
  TCustomerStoreAccount = class
  private
      idPerson: String;
      fullName: String;
      email: String;
      totalAmount:String;
  protected
      procedure SetIdPerson(value: String);
      function GetIdPerson(): String;

      procedure SetFullName(value: String);
      function GetFullName(): String;

      procedure SetEmail(value: String);
      function GetEmail(): String;

      procedure SetTotalAmount(value: String);
      function GetTotalAmount(): String;
  public
      property CustomerId: String read GetIdPerson write SetIdPerson;
      property CustomerName: String read GetFullName write SetFullName;
      property CustomerEmail: String read GetEmail write SetEmail;
      property CustomerTotalAmount: String read GetTotalAmount write SetTotalAmount;
  end;

  THold = class
  private
     date: String;
     dueDate: String;
     store: String;
     holdNumberCode: String;
     invoiceNumber: String;
     total: String;
  protected
     procedure SetDate(value: String);
     function GetDate(): String;

     procedure SetDueDate(value: String);
     function GetDueDate(): String;

     procedure SetStore(value: String);
     function GetStore(): String;

     procedure SetHoldNumber(value: String);
     function GetHoldNumBer(): String;

     procedure SetInvoiceNumber(value: String);
     function  GetInvoiceNumber(): String;

     procedure SetHoldTotal(value: string);
     function GetHoldTotal(): String;

  public
     property HoldDate: String read GetDate write SetDate;
     property HoldDueDate: String read GetDueDate write SetDueDate;
     property HoldStore: String read GetStore write SetStore;
     property HoldNumber: String read GetHoldNumber write SetHoldNumber;
     property HoldInvoiceNumber: String read GetInvoiceNumber write SetInvoiceNumber;
     property HoldTotal: String read GetHoldTotal write setHoldTotal;
  end;

  TFrmStoreAccount = class(TFrmParentAll)
    pnlCustomer: TPanel;
    Shape4: TShape;
    Label4: TLabel;
    SubCustomer: TSubListPanel;
    pgHistory: TPageControl;
    tsActiveAcc: TTabSheet;
    tsHistory: TTabSheet;
    quStoreAccount: TADODataSet;
    dspStoreAccount: TDataSetProvider;
    cdsStoreAccount: TClientDataSet;
    dsStoreAccount: TDataSource;
    cdsStoreAccountChecked: TBooleanField;
    cdsStoreAccountIDStoreAccount: TIntegerField;
    cdsStoreAccountIDPessoa: TIntegerField;
    cdsStoreAccountIDUser: TIntegerField;
    cdsStoreAccountIDStore: TIntegerField;
    cdsStoreAccountIDLancamento: TIntegerField;
    cdsStoreAccountTransactionDate: TDateTimeField;
    cdsStoreAccountAmount: TBCDField;
    cdsStoreAccountSystemUser: TStringField;
    cdsStoreAccountStore: TStringField;
    cdsStoreAccountInvoiceCode: TStringField;
    cdsStoreAccountSaleCode: TStringField;
    grdAccount: TcxGrid;
    grdAccountDB: TcxGridDBTableView;
    grdAccountLevel: TcxGridLevel;
    grdAccountDBChecked: TcxGridDBColumn;
    grdAccountDBTransactionDate: TcxGridDBColumn;
    grdAccountDBAmount: TcxGridDBColumn;
    grdAccountDBSystemUser: TcxGridDBColumn;
    grdAccountDBStore: TcxGridDBColumn;
    grdAccountDBInvoiceCode: TcxGridDBColumn;
    grdAccountDBSaleCode: TcxGridDBColumn;
    btnCustomer: TBitBtn;
    btnSellAll: TBitBtn;
    btnClearAll: TBitBtn;
    Panel4: TPanel;
    Shape2: TShape;
    Label2: TLabel;
    lbTotalDue: TStaticText;
    Bevel1: TBevel;
    pnlValue: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    edtPayValue: TSuperEdit;
    btnPayment: TButton;
    cmbPaymentType: TSuperComboADO;
    quStoreAccountChecked: TBooleanField;
    quStoreAccountIDStoreAccount: TIntegerField;
    quStoreAccountIDPessoa: TIntegerField;
    quStoreAccountIDUser: TIntegerField;
    quStoreAccountIDStore: TIntegerField;
    quStoreAccountIDLancamento: TIntegerField;
    quStoreAccountTransactionDate: TDateTimeField;
    quStoreAccountAmount: TBCDField;
    quStoreAccountSystemUser: TStringField;
    quStoreAccountStore: TStringField;
    quStoreAccountInvoiceCode: TStringField;
    quStoreAccountSaleCode: TStringField;
    btnCheck: TBitBtn;
    btnUncheck: TBitBtn;
    btnPrint: TBitBtn;
    grdHistory: TcxGrid;
    cxgrdHistoryDB: TcxGridDBTableView;
    cxgrdHistoryLevel: TcxGridLevel;
    quHistory: TADODataSet;
    dsHistory: TDataSource;
    quHistoryIDStoreAccount: TIntegerField;
    quHistoryIDPessoa: TIntegerField;
    quHistoryIDUser: TIntegerField;
    quHistoryIDStore: TIntegerField;
    quHistoryIDLancamento: TIntegerField;
    quHistoryTransactionDate: TDateTimeField;
    quHistoryAmount: TBCDField;
    quHistorySystemUser: TStringField;
    quHistoryStore: TStringField;
    cxgrdHistoryDBIDStoreAccount: TcxGridDBColumn;
    cxgrdHistoryDBTransactionDate: TcxGridDBColumn;
    cxgrdHistoryDBAmount: TcxGridDBColumn;
    cxgrdHistoryDBSystemUser: TcxGridDBColumn;
    cxgrdHistoryDBStore: TcxGridDBColumn;
    lbChange: TLabel;
    lbChangeValue: TStaticText;
    edtLoyalty: TEdit;
    Label3: TLabel;
    Shape22: TShape;
    quCustomerCard: TADODataSet;
    quCustomerCardIDPessoa: TIntegerField;
    lbPaymentAmount: TLabel;
    tsTemp: TTabSheet;
    quTemporary: TADODataSet;
    dsTemporary: TDataSource;
    cxGrid1: TcxGrid;
    dbGridTemp: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    btnRemoveTemp: TBitBtn;
    quTemporaryIDStoreAccount: TIntegerField;
    quTemporaryIDPessoa: TIntegerField;
    quTemporaryIDUser: TIntegerField;
    quTemporaryIDStore: TIntegerField;
    quTemporaryTransactionDate: TDateTimeField;
    quTemporaryAmount: TBCDField;
    quTemporarySystemUser: TStringField;
    quTemporaryStore: TStringField;
    dbGridTempTransactionDate: TcxGridDBColumn;
    dbGridTempAmount: TcxGridDBColumn;
    dbGridTempSystemUser: TcxGridDBColumn;
    dbGridTempStore: TcxGridDBColumn;
    quStoreAccountIDContaCorrente: TIntegerField;
    cdsStoreAccountIDContaCorrente: TIntegerField;
    quStoreAccountIDMeioPag: TIntegerField;
    cdsStoreAccountIDMeioPag: TIntegerField;
    quStoreAccountDueDate: TDateTimeField;
    cdsStoreAccountDueDate: TDateTimeField;
    grdAccountDBDueDate: TcxGridDBColumn;
    btnPartialPayment: TSpeedButton;
    lbPartialInfo: TLabel;
    quStoreAccountFlatPenalty: TBooleanField;
    quStoreAccountPenaltyValue: TBCDField;
    quStoreAccountDailtInterest: TBCDField;
    quStoreAccountInterest: TCurrencyField;
    quStoreAccountTotal: TCurrencyField;
    cdsStoreAccountFlatPenalty: TBooleanField;
    cdsStoreAccountPenaltyValue: TBCDField;
    cdsStoreAccountDailtInterest: TBCDField;
    cdsStoreAccountInterest: TCurrencyField;
    cdsStoreAccountTotal: TCurrencyField;
    grdAccountDBInterest: TcxGridDBColumn;
    grdAccountDBTotal: TcxGridDBColumn;
    btnEmail: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnUncheckClick(Sender: TObject);
    procedure btnSellAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure cmbPaymentTypeSelectItem(Sender: TObject);
    procedure edtPayValueChange(Sender: TObject);
    procedure edtPayValueExit(Sender: TObject);
    procedure edtPayValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnPaymentClick(Sender: TObject);
    procedure NeedSwipe(Sender: TObject; var SwipedTrack: WideString;
      var Canceled: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure edtLoyaltyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRemoveTempClick(Sender: TObject);
    procedure btnPartialPaymentClick(Sender: TObject);
    procedure quStoreAccountCalcFields(DataSet: TDataSet);
    procedure btnEmailClick(Sender: TObject);

  private
    FNumMeioQuitPrevistoMounted: String;
    // Antonio 01/20/2016
    FMerchantID, FEntryMethod, FDate, FTime, FAppLabel, FAID, FTVR, FIAD, FTSI, FARC, FCVM, FAppLabelTranCode, FAppLabelRecordNo : String;
    FCopies: Integer;
    FProcessorType: Integer;
    FProcessingType: Integer;
    FCardID: Integer;
    FIsChipMethod: String;

    FrmCreditPay : TFrmCreditPay;
    FPaymentType : Integer;
    FIDPayment   : Integer;
    FIDSALancamento : Integer;
    FIDEmpresa : Integer;
    FIDCentroCusto : Integer;
    FIDContaCorrente : Integer;
    FIDCashregMov, FIDCustomer : Integer;
    FAuthorization : String;
    FIDStoreAccount : Integer;
    FTicketNum : String;
    FErrorMsg : String;
    FrmPayPartial : TFrmPayPartial;

    FAmount : Currency;
    FBalance : Currency;
    FChange : Currency;

    hold: THold;
    customer: TCustomerStoreAccount;
    customers: TObjectList;
    holds: TObjectList;

    procedure SetChange(const Value: Currency);

    function SearchCustomerCard(CustomerCard:String):Boolean;

    procedure ClearCustomer;
    procedure RefreshCustomer;

    procedure RefreshStoreAccount;
    procedure CloseStoreAccount;
    procedure OpenStoreAccount;

    procedure CloseStoreAccountHistory;
    procedure OpenStoreAccountHistory;

    procedure CloseTempAccount;
    procedure OpenTempAccount;

    procedure CalculateBalanceDue;
    procedure MarkStoreAccount(ACheck : Boolean);
    procedure MarkAllStoreAccount(ACheck : Boolean);

    function ValidatePayment : Boolean;
    function ProcessPayment : Boolean;

    function CreateCreditAccountNum : Boolean;
    function CreateStoreAccLancamento : Boolean;
    function CreateStoreAccCredit(AIDStoreAccount, AIDLancamento : Integer;
       AAmount : Currency; AIsUsed, AIsReceiving : Boolean; ADate : TDateTime) : Boolean;
    function UpdateAccountHistory : Boolean;

    function AdjustStoreAccount(AIDStoreAcc, AIDLancamento : Integer; AInterest, AAmount, AAmountLeft : Currency; ADate : TDateTime) : Currency;
    function UpdateStoreAccountStatus(AIDStoreAcc : Integer) : boolean;
    function InsertStoreAccountQuitacao(AIDLancamento : Integer; AAmount, AInterest : Currency) : boolean;

    function PrintReceipt(AIDStoreAccount : Integer) : Boolean;

    function ShowCredit(var Amount: Double; Const Verify: Boolean) : Boolean;

    //PCCharge
    function ProcessCharge : Boolean;
    function HasCreditCardProcessor(IDMeioPag: Integer; PayType:Integer):Boolean;
    function CallProcessor(IDMeioPag: Integer; PayType: Integer; var AAuth, ATroud, ALastDigits: String; AAmount: Currency):Boolean;
    function DoPCCharge(var AAuth, ATroud, ALastDigits: String; Processor, MercantNum:String; AAmount: Currency; iPayType:Integer): Boolean;
    procedure PreparePCC(APCCT: TPCCTransaction; AProcessor, AMercantNum: String);
    procedure SucessFullSwipe(Sender: TObject; const ACardNumber, ACardMember, ACardExpireDate: WideString);
    function PCCResult(APCCT: TPCCTransaction): Boolean;


    //Mercury CC
    function DoMercury(var AAuth, ATroud, ALastDigits: String; AAmount: Currency; iPayType : Integer): Boolean;
    function MercuryResult(AMercuryWidget : TCCWidget): Boolean;
    function getPaymentCard(arg_processor: Integer; arg_paymentType: Integer): TCCWidget;

    property Change  : Currency read FChange write SetChange;
    procedure ClearPostDate;
    procedure loadClientProcessor();

    function CreateCustomer(): TCustomerStoreAccount;
    function CreateHold(): THold;

  public
    function Start(AIDCashregMov, AIDCustomer : Integer) : Boolean;
  end;

implementation

uses uFrmSearchCustomer, uDM, uCharFunctions, uMsgBox, uMsgConstant,
  uNumericFunctions, uSystemConst, ufrmPCCharge, uCreditCardFunction,
  uFrmPCCSwipeCard, uFrmPrintStoreAccount, uDMGlobal, ufrmEmailBuilder;

{$R *.dfm}

procedure TFrmStoreAccount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cmbPaymentType.SpcWhereClause := '';
  cmbPaymentType.ClearFilters;

  if FrmCreditPay <> nil then
     FreeAndNil(FrmCreditPay);

  if FrmPayPartial <> nil then
     FreeAndNil(FrmPayPartial);

  if ( customers <> nil ) then begin
     FreeAndNil(customers);
  end;

  if ( holds <> nil ) then begin
     FreeAndNil(holds);
  end;

  Action := caFree;
end;

procedure TFrmStoreAccount.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmStoreAccount.Start(AIDCashregMov,
  AIDCustomer: Integer): Boolean;
var
  buildInfo: String;
begin

  FIDCashregMov  := AIDCashregMov;
  FIDCustomer    := AIDCustomer;
  FIDPayment     := -1;
  Change         := 0;
  FAuthorization := '';
  RefreshCustomer;

  with TRegistry.Create do
  try
    if ( getOS(buildInfo) = osW7 ) then
       RootKey := HKEY_CURRENT_USER
    else
       RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH, True);
    FProcessorType := ReadInteger('ProcessorType');
    FProcessingType := readInteger('ProcessType');

    // Antonio 01/20/2016
    loadClientProcessor();


  finally
    Free;
  end;

  ShowModal;

  Result := True;

end;

procedure TFrmStoreAccount.FormCreate(Sender: TObject);
begin
  inherited;
  SubCustomer.CreateSubList;
  // MR-161 -> added type 6 ( Gift Card )
  cmbPaymentType.SpcWhereClause := 'Tipo in (1, 2, 3, 4, 5, 6, 7)';
  FrmPayPartial := TFrmPayPartial.Create(Self);

  customers := TObjectList.Create(true);
  holds := TObjectList.Create(true);

end;

procedure TFrmStoreAccount.ClearCustomer;
begin
  SubCustomer.Param := 'IDCUSTOMER=0;DisplayType=R;BackColor=$00DEE2E4;';
end;

procedure TFrmStoreAccount.RefreshCustomer;
begin

  if FIDCustomer > 1 then
  begin
    SubCustomer.Param := Format('IDCUSTOMER=%S;DisplayType=R;BackColor=$00DEE2E4;', [IntToStr(FIDCustomer)]);
    RefreshStoreAccount;
  end
  else
    ClearCustomer;

end;

procedure TFrmStoreAccount.btnCustomerClick(Sender: TObject);
var
  iIDCustomer : Integer;
begin
  inherited;

  with TFrmSearchCustomer.Create(Self) do
    iIDCustomer := Start;

  if iIDCustomer > 1 then
  begin
    FIDCustomer := iIDCustomer;
    RefreshCustomer;
  end;
  
end;

procedure TFrmStoreAccount.CloseStoreAccountHistory;
begin
  with quHistory do
    if Active then
      Close;
end;

procedure TFrmStoreAccount.OpenStoreAccountHistory;
begin
  with quHistory do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := FIDCustomer;
      if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
        Parameters.ParamByName('IDStore').Value  := DM.fStore.ID
      else
        Parameters.ParamByName('IDStore').Value  := Null;
      Open;
    end;
end;

procedure TFrmStoreAccount.CloseStoreAccount;
begin
  with cdsStoreAccount do
    if Active then
      Close;
end;

procedure TFrmStoreAccount.OpenStoreAccount;
begin

  with cdsStoreAccount do
    if not Active then
    begin
      Params.ParamByName('IDPessoa').Value := FIDCustomer;

      //showMessage(format('Idpessoa = %d, IdStore = %d', [FIdCustomer, Dm.fStore.id])) ;

      if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
        Params.ParamByName('IDStore').Value  := DM.fStore.ID
      else
        Params.ParamByName('IDStore').Value  := Null;

      Open;

      btnEmail.Enabled := ( (cdsStoreAccount.RecordCount > 0) and (customer.CustomerEmail <> '') );

    end;

  CalculateBalanceDue;

end;

procedure TFrmStoreAccount.RefreshStoreAccount;
begin
  CloseStoreAccount;
  OpenStoreAccount;

  CloseStoreAccountHistory;
  OpenStoreAccountHistory;

  CloseTempAccount;
  OpenTempAccount;
end;

procedure TFrmStoreAccount.CalculateBalanceDue;
var
  iPos : Integer;
  customerInfo: TClientdataset;
begin

  FBalance := 0;

  with cdsStoreAccount do
    if Active then
      try
        Screen.Cursor := crHourGlass;
        DisableControls;
        iPos := RecNo;
        First;

        // to avoid duplicates on the list
        holds.Clear();

        while not EOF do
        begin

          hold := CreateHold();
          hold.date := formatDateTime('yyyy/mm/dd', fieldByName('TransactionDate').value); 
          hold.dueDate := formatDateTime('yyyy/mm/dd', fieldbyname('DueDate').value);
          hold.store := fieldByName('Store').AsString;
          hold.holdNumberCode := fieldByName('SaleCode').AsString;
          hold.invoiceNumber := fieldByName('InvoiceCode').asString;
          hold.total := FormatFloat('#,##0.00', fieldByName('total').value);
          holds.Add(hold);

          if FieldByName('Checked').AsBoolean then
            FBalance := FBalance + FieldByName('Total').AsCurrency;
          Next;
        end;

        // load customer
        customerInfo := dm.ReadCustomerInfo(FIDCustomer);
        customer := CreateCustomer();
        customer.CustomerId := IntToStr(FIdCustomer);
        customer.CustomerName := customerInfo.fieldByName('pessoa').Value;
        customer.CustomerEmail := customerInfo.fieldByName('email').Value;
        customer.CustomerTotalAmount := formatFloat('#,##0.00', FBalance);

        customers.Clear();
        customers.Add(customer);

        RecNo := iPos;
        lbTotalDue.Caption  := FormatFloat('#,##0.00', FBalance);
        edtPayValue.Text    := FormatFloat('#,##0.00', FBalance);
      finally
        EnableControls;
        Screen.Cursor := crDefault;
        FreeAndNil(customerInfo);
      end;

end;

procedure TFrmStoreAccount.MarkStoreAccount(ACheck: Boolean);
begin

  with cdsStoreAccount do
  if Active and (not IsEmpty) then
    begin
      Edit;
      FieldByName('Checked').AsBoolean := ACheck;
      Post;
    end;

end;

procedure TFrmStoreAccount.btnCheckClick(Sender: TObject);
begin
  inherited;
  MarkStoreAccount(True);
  CalculateBalanceDue;
end;

procedure TFrmStoreAccount.btnUncheckClick(Sender: TObject);
begin
  inherited;
  MarkStoreAccount(False);
  CalculateBalanceDue;
end;

procedure TFrmStoreAccount.btnSellAllClick(Sender: TObject);
begin
  inherited;
  MarkAllStoreAccount(True);
end;

procedure TFrmStoreAccount.MarkAllStoreAccount(ACheck: Boolean);
begin

  with cdsStoreAccount do
    if Active then
      try
        Screen.Cursor := crHourGlass;
        DisableControls;
        First;
        while not EOF do
        begin
          MarkStoreAccount(ACheck);
          Next;
        end;
        CalculateBalanceDue;
      finally
        EnableControls;
        Screen.Cursor := crDefault;
      end;

end;

procedure TFrmStoreAccount.btnClearAllClick(Sender: TObject);
begin
  inherited;
  MarkAllStoreAccount(False);
end;

procedure TFrmStoreAccount.cmbPaymentTypeSelectItem(Sender: TObject);
begin
  inherited;

  FPaymentType := cmbPaymentType.GetFieldByName('Tipo');
  FIDPayment   := StrToInt(cmbPaymentType.LookUpValue);

  btnPartialPayment.Visible := (FPaymentType = PAYMENT_TYPE_CHECK);

end;

procedure TFrmStoreAccount.edtPayValueChange(Sender: TObject);
begin
  inherited;
  try
    FAmount := StrToCurr(edtPayValue.Text);
  except
    FAmount := 0;
  end;

  if FAmount > FBalance then
    Change := (FAmount - FBalance)
  else
    Change := 0;

  ClearPostDate;

end;

procedure TFrmStoreAccount.edtPayValueExit(Sender: TObject);
begin
  inherited;
  FAmount := MyRound(MyStrToMoney(edtPayValue.Text), 2);
  ClearPostDate;
end;

procedure TFrmStoreAccount.edtPayValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Key := ValidateDouble(Key);

end;

function TFrmStoreAccount.ValidatePayment: Boolean;
var
  CreditUse: Double;
  FValue : Double;
begin

  Result := False;

  if (FAmount <= 0) or (FBalance <= 0) then
  begin
    MsgBox(MSG_CRT_NO_AMOUNT, vbOKOnly + vbInformation);
    Exit;
  end;

  if (FIDPayment = -1) or (cmbPaymentType.LookUpValue = '') then
  begin
    MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbInformation);
    Exit;
  end;

  if (FPaymentType in [PAYMENT_TYPE_GIFTCARD, PAYMENT_TYPE_BONUSBUCK, PAYMENT_TYPE_STOREACCOUNT]) then
  begin
    MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbInformation);
    Exit;
  end;

  if (FPaymentType = PAYMENT_TYPE_CREDIT) then
  begin
    if FAmount >= 0 then
    begin
      CreditUse := FAmount;
      if ShowCredit(CreditUse, True) then
      begin
        FValue := FAmount;
        if (CreditUse = 0) or (FValue > CreditUse) then
        begin
          cmbPaymentType.LookUpValue := '';
          cmbPaymentType.SetFocus;
          Exit;
        end;
      end
      else
        Exit;
    end;
  end;


  Result := True;

end;

procedure TFrmStoreAccount.btnPaymentClick(Sender: TObject);
begin
  inherited;

  if ValidatePayment then
    ProcessPayment;

end;

function TFrmStoreAccount.ProcessPayment: Boolean;
var
  bInTrann : Boolean;
begin
  DM.FTraceControl.TraceIn('TFrmStoreAccount.ProcessPayment');

  {  try

    //Cria o proximo Store Account Credit Number
    Result := CreateCreditAccountNum;

    bInTrann := False;

    if FBalance < FAmount then
      FAmount := FBalance;

    //Processar PCCharge
    if Result then
      Result := ProcessCharge;

    if Result then
    begin
      DM.ADODBConnect.BeginTrans;
      bInTrann := True;

      //Criar Lancamento de Recebimento e atualizar o saldo caixa (Begin trans)
      Result := CreateStoreAccLancamento;

      //Criar linha de Store Account de Credit
      if Result then
        Result := CreateStoreAccCredit(FIDStoreAccount, FIDSALancamento, FAmount, True, True, Now);

      //Marcar Store Accounts como finalizado e quita os lancamentos (Commit Trans)
      if Result then
        Result := UpdateAccountHistory;

      if Result and (FPaymentType = PAYMENT_TYPE_CREDIT) and (FrmCreditPay <> nil) then
        FrmCreditPay.DiscountCredit(FAmount);

      if Result then
        DM.ADODBConnect.CommitTrans
      else
        DM.ADODBConnect.RollbackTrans;

      if Result then
      begin
        //Print receipt
        PrintReceipt(FIDStoreAccount);
        //Refresh screen
        RefreshStoreAccount;
        cmbPaymentType.LookUpValue := '';
      end;
    end;


  except
    on E: Exception do
    begin
      if bInTrann then
        DM.ADODBConnect.RollbackTrans;
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmStoreAccount');
      MsgBox(E.Message, vbCritical);
    end;
  end;


  Result := True;
}


  try

    //Cria o proximo Store Account Credit Number
    Result := CreateCreditAccountNum;

    bInTrann := False;

    if FBalance < FAmount then
      FAmount := FBalance;

    //Processar PCCharge
    if Result then
      Result := ProcessCharge;

    if Result then
    begin
      DM.ADODBConnect.BeginTrans;
      bInTrann := True;

      //Criar Lancamento de Recebimento e atualizar o saldo caixa (Begin trans)
      Result := CreateStoreAccLancamento;

      //Criar linha de Store Account de Credit
      if Result then
        Result := CreateStoreAccCredit(FIDStoreAccount, FIDSALancamento, FAmount, True, True, Now);

      //Marcar Store Accounts como finalizado e quita os lancamentos (Commit Trans)
      if Result then
        Result := UpdateAccountHistory;

      if Result and (FPaymentType = PAYMENT_TYPE_CREDIT) and (FrmCreditPay <> nil) then
        FrmCreditPay.DiscountCredit(FAmount);

      if Result then
        DM.ADODBConnect.CommitTrans
      else
        DM.ADODBConnect.RollbackTrans;

      if Result then
      begin
        //Print receipt
//        showMessage('IdStoreAccount = ' + intToStr(FIDStoreAccount));
        PrintReceipt(FIDStoreAccount);

        //Refresh screen
        RefreshStoreAccount;
        cmbPaymentType.LookUpValue := '';
      end;
    end;


  except
    on E: Exception do
    begin
      if bInTrann then
        DM.ADODBConnect.RollbackTrans;
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmStoreAccount');
      MsgBox(E.Message, vbCritical);
    end;
  end;


  Result := True;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.ProcessCharge: Boolean;
var
  sAuto, sRout, sLastDigits: String;
begin

  Result := False;

  if (DMGlobal.IDLanguage = LANG_ENGLISH) and (FPaymentType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) then begin
     Result := HasCreditCardProcessor(FIDPayment, FPaymentType);

    if Result then begin
      Result := CallProcessor(FIDPayment, FPaymentType, sAuto, sRout, sLastDigits, FAmount);
    end;

    if Result then begin
      FAuthorization := 'A:'+ sAuto + ' R:' + sRout + ' L:' + sLastDigits;
      result := true;
    end
  end else begin
          result := true;
      end

end;

function TFrmStoreAccount.HasCreditCardProcessor(IDMeioPag,
  PayType: Integer): Boolean;
begin

   result := ( FProcessorType <> 0 ) and (FMerchantID <> '' );

   if ( not Result ) then begin
      if (Fprocessortype = 0) then
        MsgBox('Invalid "Processor"._Card not charged', vbSuperCritical + vbOkOnly)
      else if (Trim(FMerchantID) = '') then
        MsgBox('Invalid "Mercant Number"._Card not charged', vbSuperCritical + vbOkOnly);
   end;

end;

function TFrmStoreAccount.CallProcessor(IDMeioPag, PayType: Integer;
  var AAuth, ATroud, ALastDigits: String; AAmount: Currency): Boolean;
var
  TrouD: String;
  Authorization : String;
  ATransactResult: Boolean;
  iCopies: Integer;
begin

  DM.FTraceControl.TraceIn('TFrmStoreAccount.CallProcessor');

  Result := False;
  ATransactResult := False;
  try
    AAuth  := '';
    ATroud := '';

    if ( FProcessorType in [PROCESSOR_MERCURY, PROCESSOR_WORLDPAY] ) then begin
         ATransactResult := DoMercury(Authorization, TrouD, ALastDigits, AAmount, PayType);
    end;

    if not ATransactResult then
      raise Exception.Create('Card not charged!!!_'+FErrorMsg)
    else begin
       Result := True;
       AAuth  := Authorization;
       ATroud := TrouD;
       ALastDigits := ALastDigits;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmStoreAccount');
      MsgBox(E.Message, vbCritical);
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.DoPCCharge(var AAuth, ATroud,
  ALastDigits: String; Processor, MercantNum: String; AAmount: Currency;
  iPayType: Integer): Boolean;
var
  PCCT: TPCCTransaction;
  sMsg: String;
  frmPCCharge : TfrmPCCharge;
  MsgResult : Integer;
  iAction : Integer;
begin

  DM.FTraceControl.TraceIn('TFrmStoreAccount.DoPCCharge');

  Result := False;
  PCCT := TPCCTransaction.Create(Self);
  try
    try

      PreparePCC(PCCT, Processor, MercantNum);

      if iPayType = PAYMENT_TYPE_CARD then
      begin
        MsgResult := MsgBox('Is the customer card present?_Total to be proccessed: '+FormatCurr('#,##0.00',AAmount), vbYesNoCancel);
        if MsgResult = vbCancel then
          Exit;
      end
      else
        MsgResult := vbYes;

      if (MsgResult = vbYes) then
        begin
          PCCT.OnNeedSwipe          := NeedSwipe;
          PCCT.AfterSucessfullSwipe := SucessFullSwipe;
          if iPayType = PAYMENT_TYPE_CARD then
            PCCT.RetailCreditOrAutorizationCardPresent(MyFormatCur(Abs(AAmount), '.'), FTicketNum, '', AAmount < 0)
          else
            begin
            if (AAmount > 0) then
               iAction := DEBIT_SALE
            else
               iAction := DEBIT_RETURN;
            PCCT.RetailDebitCardPresent(MyFormatCur(Abs(AAmount), '.'), '0.00', FTicketNum, '', iAction);
            end;

          Result := PCCResult(PCCT);
        end
      else
        begin
          frmPCCharge := TfrmPCCharge.Create(Self);
          try
            Result := frmPCCharge.Start(PCCT, FTicketNum, AAmount);
          finally
            frmPCCharge.Free;
          end;
        end;

      if Result then
      begin
        AAuth       := PCCT.Auth;
        ATroud      := PCCT.TroutD;
        ALastDigits := PCCT.LastDigits;
      end;

    except
      on E: Exception do
      begin
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmStoreAccount');
        Result := False;
      end;
    end;
  finally
    PCCT.Free;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmStoreAccount.PreparePCC(APCCT: TPCCTransaction; AProcessor,
  AMercantNum: String);
begin

  DM.FTraceControl.TraceIn('TFrmStoreAccount.PreparePCC');

  APCCT.Path                 := DM.fPCCharge.Path;
  APCCT.User                 := DM.fPCCharge.User;
  APCCT.TimeOut              := DM.fPCCharge.TimeOut;
  APCCT.Multi                := IntToStr(Byte(DM.fPCCharge.MultTrans));
  APCCT.LastValidDate        := IntToStr(DM.fPCCharge.LastDate);
  APCCT.PrintReceipts        := IntToStr(DM.fPCCharge.PrintNum);
  APCCT.Processor            := AProcessor;
  APCCT.Port                 := DM.fPCCharge.Port;
  APCCT.IPAddress            := DM.fPCCharge.Server;
  APCCT.MerchantNumber       := AMercantNum;
  APCCT.OnNeedSwipe          := nil;
  APCCT.AfterSucessfullSwipe := nil;
  APCCT.OnNeedTroutD         := nil;
  //PinPad
  APCCT.PinTimeOut           := StrToInt(DM.fPinPad.TimeOut);
  APCCT.PinEncryptMethod     := StrToInt(DM.fPinPad.EncryptMethod);
  APCCT.PinDevice            := StrToInt(DM.fPinPad.GetDevice);
  APCCT.PinBaud              := DM.fPinPad.Baud;
  APCCT.PinDataBits          := DM.fPinPad.DataBits;
  APCCT.PinParity            := DM.fPinPad.Parity;
  APCCT.PinComm              := DM.fPinPad.Comm;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmStoreAccount.NeedSwipe(Sender: TObject;
  var SwipedTrack: WideString; var Canceled: Boolean);
var
  SC : TFrmPCCSwipeCard;
  iIDMeioPag : Integer;
begin

  DM.FTraceControl.TraceIn('TFrmStoreAccount.NeedSwipe');

  SC := TFrmPCCSwipeCard.Create(Self);
  try
    try
      Canceled := not SC.Start(SwipedTrack, iIDMeioPag);
    finally
      SC.Free;
    end;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmStoreAccount');
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmStoreAccount.SucessFullSwipe(Sender: TObject;
  const ACardNumber, ACardMember, ACardExpireDate: WideString);
var
  sMsg: String;
begin
  // Adicionar neste evento qualquer código que precise ser executado após
  // uma tentativa bem sucedida de leitura do cartão
end;

function TFrmStoreAccount.PCCResult(APCCT: TPCCTransaction): Boolean;
var
  sMsg: String;
begin

  DM.FTraceControl.TraceIn('TFrmStoreAccount.PCCResult');

  Result := false;
  sMsg := '';
  try

    case APCCT.TransactionReturn of
      ttrSuccessfull:
      begin
        Result := True;
        sMsg   := Format('%S'#13#10#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'TroutD: %S', [APCCT.PCCResult, APCCT.Auth, APCCT.RefNumber, APCCT.TroutD]);

        if APCCT.AVS <> '' then
          sMsg := Format(sMsg + #13#10'AVS: %S', [APCCT.AVS]);

        if APCCT.CVV2Ver <> '' then
          sMsg := Format(sMsg + #13#10'CVV2: %S', [APCCT.CVV2Ver]);

        Application.MessageBox(PChar(sMsg), 'Transaction result', MB_OK + MB_ICONINFORMATION);
      end;

      ttrNotSuccessfull:
      begin
        sMsg := Format('%S'#13#10#13#10'Reason: %S', [APCCT.PCCResult, APCCT.Auth]);
        raise Exception.Create(sMsg);
      end;

      ttrError:
      begin
        sMsg := Format('%S'#13#10'Error: %D - %S', [APCCT.PCCResult, APCCT.ErrorCode, APCCT.ErrorDesc]);
        raise Exception.Create(sMsg);
      end;

      ttrException:
      begin
        sMsg := Format(''#13#10'Error: %S', [APCCT.ErrorDesc]);
        raise Exception.Create(sMsg);
      end;
    end;

  except
    on E: Exception do
    begin
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
      Result := False;
      Application.MessageBox(PChar(sMsg), 'TFrmStoreAccount result', MB_OK + MB_ICONINFORMATION);
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.CreateCreditAccountNum: Boolean;
begin

  Result := False;

  FIDStoreAccount  := DM.GetNextID('Sal_StoreAccount.IDStoreAccount');
  FTicketNum       := 'SA' + IntToStr(FIDStoreAccount);
  FIDEmpresa       := StrToInt(DM.DescCodigo(['IDStore'], [IntToStr(DM.fStore.ID)], 'Store', 'IDEmpresa'));
  FIDCentroCusto   := StrToIntDef(DM.DescCodigo(['IDStore'], [IntToStr(DM.fStore.ID)], 'Store', 'IDCentroCusto'), 0);
  FIDContaCorrente := StrToIntDef(DM.DescCodigo(['IDStore', 'IDMeioPag'], [IntToStr(DM.fStore.ID), cdsStoreAccountIDMeioPag.AsString], 'MeioPagToStore', 'IDContaCorrente'), 0);
  FIDContaCorrente := cdsStoreAccountIDContaCorrente.AsInteger;

  Result := True;

end;

function TFrmStoreAccount.CreateStoreAccLancamento: Boolean;
var
  CmdPayment : TADOCommand;
  i : Integer;
  sQuery : String;
begin

  Result := False;

  DM.FTraceControl.TraceIn('TFrmStoreAccount.CreateStoreAccLancamento');

  sQuery := 'INSERT INTO Fin_Lancamento (' +
            'IDLancamento,' +
            'IDCashRegMov,' +
            'IDEmpresa,' +
            'IDPessoa,' +
            'IDUsuarioLancamento,' +
            'IDLancamentoTipo,' +
            'IDCentroCusto,' +
            'IDContaCorrentePrevista,' +
            'Pagando,' +
            'IDQuitacaoMeioPrevisto,' +
            'DataLancamento,' +
            'DataVencimento,' +
            'DataEmissao,' +
            'ValorNominal,' +
            'Situacao,' +
            'NumDocumento, '+
            'IDPessoaTipo, '+
            'NumDesdobramento, ' +
            'IDBankCheck, ' +
            'CheckNumber, ' +
            'CustomerDocument, ' +
            'CustomerName, ' +
            'CustomerPhone, ' +
            'Historico, ' +
            'IsPreDatado, ' +
            'PaymentPlace, ' +
            'TotalJuros, ' +
            'IDDocumentoTipo, ' +
            'NumMeioQuitPrevisto )' +
            'VALUES (' +
            ':IDLancamento,' +
            ':IDCashRegMov,' +
            ':IDEmpresa,' +
            ':IDPessoa,' +
            ':IDUsuarioLancamento,' +
            ':IDLancamentoTipo,' +
            ':IDCentroCusto,' +
            ':IDContaCorrentePrevista,' +
            ':Pagando,' +
            ':IDQuitacaoMeioPrevisto,' +
            ':DataLancamento,' +
            ':DataVencimento,' +
            ':DataEmissao,' +
            ':ValorNominal,' +
            ':Situacao, ' +
            ':NumDocumento, '+
            ':IDPessoaTipo, '+
            ':NumDesdobramento, ' +
            ':IDBankCheck, ' +
            ':CheckNumber, ' +
            ':CustomerDocument, ' +
            ':CustomerName, ' +
            ':CustomerPhone, ' +
            ':Historico, ' +
            ':IsPreDatado, ' +
            ':PaymentPlace, ' +
            ':TotalJuros, ' +
            ':IDDocumentoTipo, ' +
            ':NumQuitMeioPrevisto)';


  //Cria o Lancamento
  CmdPayment := TADOCommand.Create(nil);
  with CmdPayment do
  try
    Connection := DM.ADODBConnect;
    CommandText := sQuery;

    Parameters.ParamByName('IDCashRegMov').Value            := FIDCashRegMov;
    Parameters.ParamByName('IDEmpresa').Value               := FIDEmpresa;
    Parameters.ParamByName('IDPessoa').Value                := FIDCustomer;
    Parameters.ParamByName('IDUsuarioLancamento').Value     := DM.fUser.ID;
    Parameters.ParamByName('IDLancamentoTipo').Value        := 0;
    Parameters.ParamByName('IDCentroCusto').Value           := FIDCentroCusto;
    if FIDContaCorrente <> 0 then
      Parameters.ParamByName('IDContaCorrentePrevista').Value := FIDContaCorrente
    else
      Parameters.ParamByName('IDContaCorrentePrevista').Value := Null;
    Parameters.ParamByName('Pagando').Value                 := 0;
    Parameters.ParamByName('IDQuitacaoMeioPrevisto').Value  := FIDPayment;
    Parameters.ParamByName('DataLancamento').Value          := Trunc(Now);
    Parameters.ParamByName('DataEmissao').Value             := Trunc(Now);
    Parameters.ParamByName('Situacao').Value                := 1;
    Parameters.ParamByName('NumDocumento').Value            := Copy(FTicketNum, 1, 20);
    Parameters.ParamByName('IDPessoaTipo').Value            := 1;
    Parameters.ParamByName('IDDocumentoTipo').Value         := 1001;
    Parameters.ParamByName('TotalJuros').Value              := 0;

    // Antonio 02/04/2016
    Parameters.paramByName('NumQuitMeioPrevisto').value := Null;

    if ( FPaymentType in [PAYMENT_TYPE_CARD] ) then begin
        Parameters.paramByName('NumQuitMeioPrevisto').value := FNumMeioQuitPrevistoMounted;
    end;

    if (FPaymentType = PAYMENT_TYPE_CHECK) and (FrmPayPartial.tvPartialPay.Items.Count > 0) then
    begin
      for i := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
      begin
        FIDSALancamento := DM.GetNextID('Fin_Lancamento.IDLancamento');

        Parameters.ParamByName('IDLancamento').Value            := FIDSALancamento;

        Parameters.ParamByName('DataVencimento').Value          := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).ExpireDate;
        Parameters.ParamByName('ValorNominal').Value            := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Valor;
        Parameters.ParamByName('NumDesdobramento').Value        := IntToStr(i+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count);
        Parameters.ParamByName('IDBankCheck').Value             := MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Banco);
        Parameters.ParamByName('CheckNumber').Value             := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).NumeroDoc;
        Parameters.ParamByName('CustomerDocument').Value        := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).DocCliente;
        Parameters.ParamByName('CustomerName').Value            := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).NomeCliente;
        Parameters.ParamByName('CustomerPhone').Value           := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Telefone;
        Parameters.ParamByName('Historico').Value               := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).OBS;
        Parameters.ParamByName('IsPreDatado').Value             := 1;
        Parameters.ParamByName('PaymentPlace').Value            := TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).PaymentPlace;
        Execute;
      end;
    end
    else
    begin
      FIDSALancamento := DM.GetNextID('Fin_Lancamento.IDLancamento');
      Parameters.ParamByName('IDLancamento').Value            := FIDSALancamento;
      Parameters.ParamByName('DataVencimento').Value          := Trunc(Now);
      Parameters.ParamByName('ValorNominal').Value            := FAmount;
      Parameters.ParamByName('TotalJuros').Value              := 0;
      Parameters.ParamByName('NumDesdobramento').Value        := '1/1';
      Parameters.ParamByName('IDBankCheck').Value             := 0;
      Parameters.ParamByName('CheckNumber').Value             := '';
      Parameters.ParamByName('CustomerDocument').Value        := '';
      Parameters.ParamByName('CustomerName').Value            := '';
      Parameters.ParamByName('CustomerPhone').Value           := '';
      Parameters.ParamByName('Historico').Value               := '';
      Parameters.ParamByName('IsPreDatado').Value             := 0;
      Parameters.ParamByName('PaymentPlace').Value            := 0;
      Execute;
    end;

  finally
    FreeAndNil(CmdPayment);
  end;

  //Altera o total do caixa
  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'UPDATE CashRegMov ' +
                   'SET TotalSales = IsNull(TotalSales, 0) + ROUND(IsNull(:Value,0),2) ' +
                   'WHERE IDCashRegMov = :IDCashRegMov';
    Parameters.ParamByName('IDCashRegMov').Value := FIDCashRegMov;
    Parameters.ParamByName('Value').Value := FAmount;
    Execute;
  finally
    Free;
  end;

  Result := True;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.CreateStoreAccCredit(AIDStoreAccount, AIDLancamento : Integer;
  AAmount : Currency; AIsUsed, AIsReceiving : Boolean; ADate : TDateTime) : Boolean;
begin

  Result := False;

  DM.FTraceControl.TraceIn('TFrmStoreAccount.CreateStoreAccCredit');

  //Altera o total do caixa
  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'INSERT Sal_StoreAccount (IDStoreAccount, IDPessoa, IDUser, IDStore, IDLancamento, TransactionDate, Amount, IsUsed, IsReceiving) ' +
                   'VALUES (:IDStoreAccount, :IDPessoa, :IDUser, :IDStore, :IDLancamento, :TransactionDate, :Amount, :IsUsed, :IsReceiving) ';

    Parameters.ParamByName('IDStoreAccount').Value  := AIDStoreAccount;
    Parameters.ParamByName('IDPessoa').Value        := FIDCustomer;
    Parameters.ParamByName('IDUser').Value          := DM.fUser.ID;
    Parameters.ParamByName('IDStore').Value         := DM.fStore.ID;
    Parameters.ParamByName('IDLancamento').Value    := AIDLancamento;
    Parameters.ParamByName('TransactionDate').Value := ADate;
    Parameters.ParamByName('Amount').Value          := AAmount;
    Parameters.ParamByName('IsUsed').Value          := AIsUsed;
    Parameters.ParamByName('IsReceiving').Value     := AIsReceiving;
    Execute;
  finally
    Free;
  end;


  Result := True;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.UpdateAccountHistory: Boolean;
var
  cBalanceLeft : Currency;
begin

  Result := False;

  DM.FTraceControl.TraceIn('CreateStoreAccCredit');

  cBalanceLeft := FAmount;

  try
     try
        cdsStoreAccount.DisableControls;
        cdsStoreAccount.First;
        while not cdsStoreAccount.Eof do begin

              if ( cdsStoreAccount.FieldByName('Checked').asBoolean ) then begin
//                  showmessage(format('InvoiceCode = %d, IDStoreAccount = %d', [cdsStoreAccount.FieldByName('InvoiceCode').asInteger, cdsStoreAccount.fieldByName('IDStoreAccount').asInteger]));
                  cBalanceLeft := AdjustStoreAccount(cdsStoreAccount.FieldByName('IDStoreAccount').AsInteger,
                                                     cdsStoreAccount.FieldByName('IDLancamento').AsInteger,
                                                     cdsStoreAccount.FieldByName('Interest').AsCurrency,
                                                     cdsStoreAccount.FieldByName('Amount').AsCurrency,
                                                     cBalanceLeft,
                                                     cdsStoreAccount.FieldByName('TransactionDate').AsDateTime);

                 if ( cBalanceLeft <= 0 ) then begin
                    break;
                 end;

              end;

              cdsStoreAccount.Next;

        end;
     except
         on e:Exception do begin
             raise Exception.Create('Fail to Update Account History: ' + e.Message);
         end;

     end

  finally
      cdsStoreAccount.EnableControls;
  end;

  Result := True;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.AdjustStoreAccount(AIDStoreAcc,  AIDLancamento: Integer;
  AInterest, AAmount, AAmountLeft: Currency; ADate : TDateTime): Currency;
begin

  if ((AAmount + AInterest) <= AAmountLeft) then
  begin
    //Marcar o Store Account como recebido
    UpdateStoreAccountStatus(AIDStoreAcc);

    //Quitar lancamento do Store Account
    InsertStoreAccountQuitacao(AIDLancamento, AAmount, AInterest);
  end
  else
  begin
    //Marcar o Store Account como recebido
    UpdateStoreAccountStatus(AIDStoreAcc);

    //Quitar parcialmente o lancamento
    InsertStoreAccountQuitacao(AIDLancamento, AAmountLeft, 0);

    //Criar um novo Store Account com o balanco final
    CreateStoreAccCredit(DM.GetNextID('Sal_StoreAccount.IDStoreAccount'),
                         AIDLancamento, (AAmount - AAmountLeft), False, False, ADate);

  end;

  Result := AAmountLeft - AAmount;

end;

function TFrmStoreAccount.UpdateStoreAccountStatus(
  AIDStoreAcc: Integer): boolean;
begin

  Result := False;

  DM.FTraceControl.TraceIn('UpdateStoreAccountStatus');

  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'UPDATE Sal_StoreAccount ' +
                   'SET IDStoreAccountUsed = :IDStoreAccountUsed, IsUsed = :IsUsed ' +
                   'WHERE IDStoreAccount = :IDStoreAccount';
    Parameters.ParamByName('IDStoreAccountUsed').Value := FIDStoreAccount;
    Parameters.ParamByName('IDStoreAccount').Value     := AIDStoreAcc;
    Parameters.ParamByName('IsUsed').Value             := True;
    Execute;
  finally
    Free;
  end;

  Result := True;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.InsertStoreAccountQuitacao(
  AIDLancamento: Integer; AAmount, AInterest: Currency): boolean;
var
  iIDQuitacao : Integer;
begin

  Result := False;

  DM.FTraceControl.TraceIn('InsertStoreAccountQuitacao');

  if AInterest <> 0 then
    with TADOCommand.Create(nil) do
    try
      Connection := DM.ADODBConnect;
      CommandText := 'UPDATE Fin_Lancamento SET TotalJuros = :TotalJuros ' +
                     'WHERE IDLancamento = :IDLancamento';

      Parameters.ParamByName('IDLancamento').Value  := AIDLancamento;
      Parameters.ParamByName('TotalQuitacao').Value := AInterest;
      Execute;
    finally
      Free;
    end;

  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'INSERT Fin_Quitacao (IDQuitacao, Pagando, IDContaCorrente, IDUsuarioQuitacao, DataQuitacao, IDQuitacaoMeio, NumeroMeioQuit, ValorQuitacao) ' +
                   'VALUES (:IDQuitacao, :Pagando, :IDContaCorrente, :IDUsuarioQuitacao, :DataQuitacao, :IDQuitacaoMeio, :NumeroMeioQuit, :ValorQuitacao) ';

    iIDQuitacao := DM.GetNextID('Fin_Quitacao.IDQuitacao');

    Parameters.ParamByName('IDQuitacao').Value        := iIDQuitacao;
    Parameters.ParamByName('Pagando').Value           := False;
    Parameters.ParamByName('IDContaCorrente').Value   := FIDContaCorrente;
    Parameters.ParamByName('IDUsuarioQuitacao').Value := DM.fUser.ID;
    Parameters.ParamByName('DataQuitacao').Value      := Trunc(Now);
    Parameters.ParamByName('IDQuitacaoMeio').Value    := FIDPayment;

    if FAuthorization <> '' then
      Parameters.ParamByName('NumeroMeioQuit').Value  := Copy(FNumMeioQuitPrevistoMounted[20], 1, 20)
    else
      Parameters.ParamByName('NumeroMeioQuit').Value  := Copy(FTicketNum, 1, 20);

    Parameters.ParamByName('ValorQuitacao').Value     := AAmount + AInterest;
    Execute;
  finally
    Free;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'INSERT Fin_LancQuit (IDLancamento, IDQuitacao, ValorQuitado, DataQuitacao, IDUsuarioQuitacao) ' +
                   'VALUES (:IDLancamento, :IDQuitacao, :ValorQuitado, :DataQuitacao, :IDUsuarioQuitacao)';

    Parameters.ParamByName('IDLancamento').Value      := AIDLancamento;
    Parameters.ParamByName('IDQuitacao').Value        := iIDQuitacao;
    Parameters.ParamByName('ValorQuitado').Value      := 0;
    Parameters.ParamByName('DataQuitacao').Value      := Trunc(Now);
    Parameters.ParamByName('IDUsuarioQuitacao').Value := DM.fUser.ID;

    Execute;

  finally
    Free;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    CommandText := 'UPDATE Fin_Lancamento SET DataFimQuitacao = :DataFimQuitacao, NumMeioQuitPrevisto = :quitprevisto, ' +
                   'TotalQuitado = :TotalQuitado ' +
                   'WHERE IDLancamento = :IDLancamento ';

    Parameters.ParamByName('IDLancamento').Value    := AIDLancamento;
    Parameters.ParamByName('DataFimQuitacao').Value := Trunc(Now);
    Parameters.ParamByName('TotalQuitado').Value    := AAmount;
    parameters.parambyname('quitprevisto').value := FNumMeioQuitPrevistoMounted;
    Execute;

  finally
    Free;
  end;


  Result := True;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmStoreAccount.btnPrintClick(Sender: TObject);
begin
  inherited;

  with quHistory do begin
    if Active and (not IsEmpty) then
      PrintReceipt(FieldByName('IDStoreAccount').AsInteger);
  end;

end;

function TFrmStoreAccount.PrintReceipt(AIDStoreAccount: Integer): Boolean;
begin

  with TFrmPrintStoreAccount.Create(Self) do begin
    Start(AIDStoreAccount);
  end;

end;

procedure TFrmStoreAccount.SetChange(const Value: Currency);
begin

  FChange := Value;

  lbChangeValue.Visible := (FChange <> 0);
  lbChange.Visible      := (FChange <> 0);

  lbChangeValue.Caption := FormatFloat('#,##0.00', FChange);

end;

procedure TFrmStoreAccount.edtLoyaltyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (key = VK_RETURN) then
  begin
    SearchCustomerCard(edtLoyalty.Text);
    edtLoyalty.Clear;
  end;

end;

function TFrmStoreAccount.SearchCustomerCard(
  CustomerCard: String): Boolean;
begin

  Result := False;

  if Trim(CustomerCard) = '' then
    Exit;

  with quCustomerCard do
  begin
    if Active then
      Close;
    Parameters.ParamByName('CustomerCard').Value := CustomerCard;
    Open;
    try
      if not IsEmpty then
      begin
        Result := True;
        FIDCustomer := quCustomerCardIDPessoa.AsInteger;
        RefreshCustomer;
      end;
    finally
      Close;
    end;
  end;

end;

function TFrmStoreAccount.ShowCredit(var Amount: Double;
  const Verify: Boolean): Boolean;
var
  VerifyAmount : Double;
  TotCredit : Currency;
begin

  VerifyAmount := Amount;

  if FrmCreditPay = nil then
    FrmCreditPay := TFrmCreditPay.Create(Self)
  else
    FrmCreditPay.UnloadCredit;

  TotCredit := FrmCreditPay.GetTotalCredit(FIDCustomer, DM.fStore.ID, -1);

  // Se necessita verificar confere se o cliente possui crédito antes de abrir
  if Verify then
    Result := (VerifyAmount <= TotCredit);

  if not Result then
  begin
    MsgBox(MSG_INF_CREDIT_GREATER_INVOICE, vbCritical + vbOKOnly);
    edtPayValue.Text := FormatFloat('#,##0.00', TotCredit);;
    Exit;
  end;

  Result := FrmCreditPay.Start(FIDCustomer, -1, Now, Amount);
  if Result and (Verify and (VerifyAmount > Amount)) then
  begin
    Result := False;
    MsgBox(MSG_INF_CREDIT_SMALLER_TOTAL, vbCritical + vbOKOnly);
    Exit;
  end;

  Result := True;


end;

function TFrmStoreAccount.DoMercury(var AAuth, ATroud, ALastDigits: String;
  AAmount: Currency; iPayType : Integer): Boolean;
var
  FMercuryWidget : TCCWidget;
  sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2 : String;
  MsgResult : Integer;
  processResult: TCCWidget;
begin
  DM.FTraceControl.TraceIn('TFrmStoreAccount.DoMercury');

  Result := False;
  if iPayType = PAYMENT_TYPE_CARD then
    FMercuryWidget := getPaymentCard(fProcessorType, PAYMENT_TYPE_CREDIT)
  else
    FMercuryWidget := getPaymentCard(fProcessorType, PAYMENT_TYPE_DEBIT);

  try
    if iPayType = PAYMENT_TYPE_CARD then
    begin
      MsgResult := MsgBox('Is the customer card present?_Total to be proccessed: '+FormatCurr('#,##0.00',AAmount), vbYesNoCancel);
      if MsgResult = vbCancel then
        Exit;
    end
    else
      MsgResult := vbYes;

    if (MsgResult = vbYes) then
    begin
      FMercuryWidget.OnNeedSwipe          := NeedSwipe;
      FMercuryWidget.AfterSucessfullSwipe := SucessFullSwipe;

      if iPayType = PAYMENT_TYPE_CARD then
      begin
        with TCCredit(FMercuryWidget) do
        begin
            Memo                := 'MainRetail ' + dm.fSystem.VerBuild;
            OperatorID          := IntToStr(DM.fUser.ID);
            InvoiceNo           := FTicketNum;
            RefNo               := FTicketNum;
            Purchase            := AAmount;
            Tax                 := 0;
            AcctNo              := sCardNumber;
            ExpDate             := sExpireDate;
            Address             := sStreetAddress;
            Zip                 := sZipCode;
            CustomerCode        := sMemberName;
            Track2              := '';
            CVVData             := sCVV2;

            TCCredit(FMercuryWidget).setCreditDevice(fProcessorType, fProcessingType);


          if (AAmount > 0) then
            ProcessSale
          else
            ProcessReturn;
        end;
      end
      else
      begin
        with TCDebit(FMercuryWidget) do
        begin
          //Manual entry card
//          FMPinPad.FBaudRate   := DM.fPinPad.Baud;
//          FMPinPad.FComPort    := DM.fPinPad.Comm;
//          FMPinPad.FTimeout    := StrToInt(DM.fPinPad.TimeOut);
            Memo                := 'MainRetail ' + dm.fSystem.VerBuild;
            OperatorID          := IntToStr(DM.fUser.ID);
            InvoiceNo           := FTicketNum;
            RefNo               := FTicketNum;
            Purchase            := AAmount;
            Tax                 := 0;
            AcctNo              := sCardNumber;
            ExpDate             := sExpireDate;
            Address             := sStreetAddress;
            Zip                 := sZipCode;
            CustomerCode        := sMemberName;
            Track2              := '';
            CVVData             := sCVV2;

          TCDebit(FMercuryWidget).setDebitDevice(fProcessorType, fProcessingType);

          if (AAmount > 0) then
            ProcessSale
          else
            ProcessReturn;
        end;
      end;

    end
    else //Card not Present
    begin
      with TfrmPCCharge.Create(nil) do
      try
        Result := StartMercury(sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2);
        if Result then
        begin
          with TCCredit(FMercuryWidget) do
          begin
            //Manual entry card
            OnNeedSwipe          := nil;
            AfterSucessfullSwipe := nil;
            OnNeedTroutD         := nil;

            Memo                := 'MainRetail ' + dm.fSystem.VerBuild;
            OperatorID          := IntToStr(DM.fUser.ID);
            InvoiceNo           := FTicketNum;
            RefNo               := FTicketNum;
            Purchase            := AAmount;
            Tax                 := 0;
            AcctNo              := sCardNumber;
            ExpDate             := sExpireDate;
            Address             := sStreetAddress;
            Zip                 := sZipCode;
            CustomerCode        := sMemberName;
            Track2              := '';
            CVVData             := sCVV2;

            TCCredit(FMercuryWidget).setCreditDevice(fProcessorType, fProcessingType);

            if (AAmount > 0) then
              ProcessSale
            else
              ProcessReturn;
          end;

        end
        else
          FErrorMsg := 'Canceled by user.';
      finally
        Free;
      end;
    end;

    Result := MercuryResult(FMercuryWidget);

    if Result then begin

      // Antonio 01/22/2016
      processResult := FMercuryWidget.getActiveTransaction();

      if ( processResult <> nil ) then begin

         if ( processResult.ChipMethod = 'chip' ) then begin
            FNumMeioQuitPrevistoMounted :=  'A:'+ processResult.AuthCode + ' R:' + processResult.RefNo +
                                            ' L:' + processResult.LastDigits + ' M:' + processResult.MerchantID +
                                            ' E:' + processResult.EntryMethod +
                                            ' D:' + processResult.DateTransaction + ' T:' + processResult.TimeTransaction +
                                            ' C:' + 'chip' + ' P:' + processResult.AppLabel +
                                            ' AID:' + processResult.AppLabelAID + ' TVR:' + processResult.AppLabelTVR +
                                            ' IAD:' + processResult.AppLabelIAD + ' TSI:' + processResult.AppLabelTSI +
                                            ' ARC:' + processResult.AppLabelARC + ' CVM:' + processResult.AppLabelCVM +
                                            ' TC:'+ processResult.AppLabelTranCode
         end else begin
                  FNumMeioQuitPrevistoMounted := 'A:'+ processResult.AuthCode + ' R:' + processResult.RefNo + ' L:' + processResult.LastDigits +
                                                 ' M:' + processResult.MerchantID + ' E:' + processResult.EntryMethod +
                                                 ' D:' + processResult.DateTransaction +
                                                 ' T:' + processResult.TimeTransaction + ' C:' + ' P:' + processResult.AppLabel;
             end;

         // Antonio 02/04/2016
         AAuth  := processResult.AuthCode;
         ATroud := processResult.RefNo;
         ALastDigits := processResult.LastDigits;

      end;

    end;

  finally
    FreeAndNil(FMercuryWidget);
  end;

  DM.FTraceControl.TraceOut;

end;

function TFrmStoreAccount.MercuryResult(AMercuryWidget : TCCWidget): Boolean;
var
  sMsg: String;
  processResult: TCCWidget;

begin
  DM.FTraceControl.TraceIn(Self.ClassName + '.MercuryResult');
  Result := False;

  sMsg := '';
  try

    processResult := AMercuryWidget.getActiveTransaction();

    case processResult.TransactionReturn of
      ttrSuccessfull:
      begin
        Result := True;
        sMsg := Format('%S'#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'RefDataD: %S', [processResult.Msg, processResult.AuthCode, processResult.RefNo, processResult.ResultAcqRefData]);
      end;

      ttrNotSuccessfull:
      begin
        sMsg := Format('%S'#13#10'Reason: %S', [processResult.Msg, processResult.AuthCode]);
        raise Exception.Create(sMsg);
      end;

      ttrError:
      begin
        sMsg := Format(#13#10'Error: %S', [processResult.Msg]);
        raise Exception.Create(sMsg);
      end;

      ttrException:
      begin
        sMsg := Format(''#13#10'Error: %S', [processResult.Msg + ' ' + FErrorMsg]);
        raise Exception.Create(sMsg);
      end;
    end;
  except
    FErrorMsg := sMsg;
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TFrmStoreAccount.CloseTempAccount;
begin
  with quTemporary do
    if Active then
      Close;
end;

procedure TFrmStoreAccount.OpenTempAccount;
begin

  with quTemporary do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := FIDCustomer;
      if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
        Parameters.ParamByName('IDStore').Value  := DM.fStore.ID
      else
        Parameters.ParamByName('IDStore').Value  := Null;
      Open;
      tsTemp.TabVisible := not IsEmpty;
    end;

end;

procedure TFrmStoreAccount.btnRemoveTempClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;
  if quTemporary.Active and (quTemporary.FieldByName('IDStoreAccount').AsInteger <> 0) then
  begin
    sSQL := 'DELETE Sal_StoreAccount WHERE IDStoreAccount = ' + quTemporary.FieldByName('IDStoreAccount').AsString;
    DM.RunSQL(sSQL);
    CloseTempAccount;
    OpenTempAccount;
  end;
end;

procedure TFrmStoreAccount.btnPartialPaymentClick(Sender: TObject);
begin
  inherited;
  ClearPostDate;
  lbPartialInfo.Caption := FrmPayPartial.Start(FIDPayment, FIDCustomer, 0, FIDCashregMov, FAmount, Now, '', 1, 0);
end;

procedure TFrmStoreAccount.ClearPostDate;
begin

  if FrmPayPartial.tvPartialPay.Items.Count > 0 then
    FrmPayPartial.ClearPaymentList;

  lbPartialInfo.Caption := '';

end;

procedure TFrmStoreAccount.quStoreAccountCalcFields(DataSet: TDataSet);
var
  sMulta: Currency;
  sJuros: Currency;
  sqtday: Integer;
  svldaily: Currency;
begin
  inherited;
  sMulta := 0;
  sJuros := 0;
  quStoreAccountInterest.AsCurrency := 0;

  // Verifica a qtd de dias de atraso.
  sqtday := (Trunc(Now) - Trunc(quStoreAccountDueDate.AsDateTime));

  if sqtday > 0 then
  begin
    // Valida se é $ ou %
    if quStoreAccountFlatPenalty.AsBoolean then
      sMulta := quStoreAccountPenaltyValue.AsCurrency
    else
      sMulta := quStoreAccountAmount.AsCurrency * (quStoreAccountPenaltyValue.AsCurrency / 100);

    //Recebe o valor do Juros do banco e transforma em %
    sJuros := (quStoreAccountDailtInterest.AsCurrency / 100);

    // Calcula o valor diário
    svldaily := (sJuros * quStoreAccountAmount.AsCurrency);
    //Cálculo do valor total do campo Interest
    quStoreAccountInterest.AsCurrency := (sMulta + (svldaily * sqtday));
    //Cálculo do Total a Pagar

    quStoreAccountTotal.AsCurrency := ({(quStoreAccountInterest.AsCurrency + } quStoreAccountAmount.AsCurrency);
  end;

end;

function TFrmStoreAccount.getPaymentCard(arg_processor,
  arg_paymentType: Integer): TCCWidget;
begin
    case (arg_paymentType) of
     PAYMENT_TYPE_CREDIT: begin
       result := TCCredit.Create();
     end;

     PAYMENT_TYPE_DEBIT: begin
       result := TCDebit.Create();
     end;

     PAYMENT_TYPE_GIFTCARD: begin
       result := TCPrePaid.Create();
     end;

   end;
end;

procedure TFrmStoreAccount.loadClientProcessor;
begin
   FMerchantID := dm.fMRMercury.MerchantID;
   FCopies := 0; // did not find in FMRMercury
   FCardID := 0; // did not find in FMRMercury
end;


{ TCustomerStoreAccount }

function TCustomerStoreAccount.GetEmail: String;
begin
   result := self.email;
end;

function TCustomerStoreAccount.GetFullName: String;
begin
   result := self.fullName;
end;

function TCustomerStoreAccount.GetIdPerson: String;
begin
  result := self.idPerson;
end;

function TCustomerStoreAccount.GetTotalAmount: String;
begin
   result := self.totalAmount;
end;

procedure TCustomerStoreAccount.SetEmail(value: String);
begin
   self.email := value;
   if ( Pos('@', self.email) = 0 ) then begin
      self.email := '';
      raise Exception.Create('Email cannot be blank or invalid format. Please, go to Customer File and type a valid e-mail.');
   end;

end;

procedure TCustomerStoreAccount.SetFullName(value: String);
begin
  self.fullName := value;
end;

procedure TCustomerStoreAccount.SetIdPerson(value: String);
begin
  self.idPerson := value;
end;

procedure TCustomerStoreAccount.SetTotalAmount(value: String);
begin
   self.totalAmount := value;
end;

{ THold }

function THold.GetDate: String;
begin
  result := self.date;
end;

function THold.GetDueDate: String;
begin
  result := self.dueDate;
end;

function THold.GetHoldNumBer: String;
begin
   result := self.holdNumberCode;
end;

function THold.GetHoldTotal: String;
begin
   result := self.total;
end;

function THold.GetInvoiceNumber: String;
begin
   result := self.invoiceNumber;
end;

function THold.GetStore: String;
begin
  result := self.store;
end;

procedure THold.SetDate(value: String);
begin
   self.date := value;
end;

procedure THold.SetDueDate(value: String);
begin
  self.dueDate := value;
end;

procedure THold.SetHoldNumber(value: String);
begin
   self.HoldNumber := value;
end;

procedure THold.SetHoldTotal(value: string);
begin
   self.total := value;
end;

procedure THold.SetInvoiceNumber(value: String);
begin
   self.invoiceNumber := value;
end;

procedure THold.SetStore(value: String);
begin
  self.store := value;
end;

function TFrmStoreAccount.CreateCustomer(): TCustomerStoreAccount;
begin
   if ( customer = nil ) then begin
      result := TCustomerStoreAccount.Create();
   end else begin
         result := customer;
       end
end;

function TFrmStoreAccount.CreateHold(): THold;
begin
  if ( hold = nil ) then begin
      result := THold.Create();
  end else begin
          result := hold;
      end;
end;

procedure TFrmStoreAccount.btnEmailClick(Sender: TObject);
var
   viewEmail: TFrmEmailBuilder;
begin
  inherited;
  try
     viewEmail := TFrmEmailBuilder.Create(nil);
     viewEmail.Start(FIDCustomer, customers, holds);

  finally
     FreeAndNil(viewEmail);
  end;

end;

end.

