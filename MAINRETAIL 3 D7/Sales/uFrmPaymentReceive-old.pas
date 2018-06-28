(*
-----------------------------------------------------------------------------------------------------
Date    : 12.30.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Activity: New implementation to gift card.
-----------------------------------------------------------------------------------------------------

Version : (290 - 286)
Date    : 03.28.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : duplicate bonus bucks
Solution: Bonus Bucks is a payment type so, is alredy loaded like that.
          Don't needs anymore loaded after read payments.  
Version : (290 - 287)
-----------------------------------------------------------------------------------------------------

Version : (288 - 279)
Date    : 02.12.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Discover card get a wrong type when swipped.
Solution: Were done two changes to fix them:
          - in unit DM function IdentifySwipedCard
          - on this unit, when is  found an undefined card will be showed
            a list of valid cards.
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------

Version : (287 - 272)
Date    : 10.14.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : replace message "Customer cannot be empty" ( to layway payment )
          replace message "Payment Type can not be empty" ( to layaway payment )
Solution: Implemented Specific Layaway message to client.
          Implemented Specific Layaway message to Layaway payment.
          Improvement in layaway Payment Receive screen.
Version : (287 - 273)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmPaymentReceive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  XiButton, DB, ADODB, uInvoiceInfo, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, DBClient, SuperEdit, uFrmListPayments,
  uSaleReceive, uFrmPayPartial, uPayment, uBonusBucks, uFrmGiftCardNumber,
  Provider, uPaymentStoreCredit, uFrmCashBackValue, uDocumentInfo, uFrmPromoControl;

type
  TProcessor = (tpNoProcessor, tpPCharge, tpMercury, tpManual );
  TProcessors = set of TProcessor;

  TFrmPaymentReceive = class(TFrmParentAll)
    pnlPaymentList: TPanel;
    pnlPayment: TPanel;
    pnlSubTotal: TPanel;
    Shape5: TShape;
    Label1: TLabel;
    Panel2: TPanel;
    Shape1: TShape;
    Panel4: TPanel;
    Shape2: TShape;
    Label2: TLabel;
    btnPayCash: TXiButton;
    btnAdd20: TXiButton;
    btnAdd10: TXiButton;
    btnAdd5: TXiButton;
    btnPayCreditCard: TXiButton;
    btnPayCheck: TXiButton;
    btnPayDebitCard: TXiButton;
    btnPayGift: TXiButton;
    btnPayBonus: TXiButton;
    btnPayStoreCredit: TXiButton;
    btnPayOther: TXiButton;
    btnFinish: TXiButton;
    btnLayaway: TXiButton;
    btnCustomer: TXiButton;
    pnlValue: TPanel;
    Shape4: TShape;
    Label4: TLabel;
    Panel5: TPanel;
    Shape3: TShape;
    Label3: TLabel;
    lbChange: TLabel;
    strepPayments: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    csBackground: TcxStyle;
    cdsPayments: TClientDataSet;
    dsPayments: TDataSource;
    lbLayway: TLabel;
    lbCustomer: TLabel;
    lbSalesTotal: TStaticText;
    lbPayments: TStaticText;
    lbTotalDue: TStaticText;
    lbChangeValue: TStaticText;
    edtPayValue: TSuperEdit;
    cdsPaymentsPaymentType: TStringField;
    cdsPaymentsPaymentForm: TStringField;
    cdsPaymentsPaymentDate: TDateTimeField;
    cdsPaymentsPaymentValue: TCurrencyField;
    cdsPaymentsID: TIntegerField;
    cdsPaymentsImage: TIntegerField;
    csGroup: TcxStyle;
    csPayment: TcxStyle;
    csAmount: TcxStyle;
    quPaymentTypes: TADODataSet;
    dspPaymentTypes: TDataSetProvider;
    cdsPaymentTypes: TClientDataSet;
    grdPayments: TcxGrid;
    grdPaymentsDB: TcxGridDBTableView;
    grdPaymentsDBIDMeioPag: TcxGridDBColumn;
    grdPaymentsDBImageIndex: TcxGridDBColumn;
    grdPaymentsDBMeioPag: TcxGridDBColumn;
    grdPaymentsDBPaymentForm: TcxGridDBColumn;
    grdPaymentsLevel: TcxGridLevel;
    grdPaymentsDBPaymentValue: TcxGridDBColumn;
    btnRemovePayment: TSpeedButton;
    quCustomerInfo: TADODataSet;
    lbStoreCredit: TLabel;
    quCustomerCredits: TADOQuery;
    sdpCustomerCredit: TDataSetProvider;
    cdsCustomerCredit: TClientDataSet;
    quCustomerCreditsMarked: TBooleanField;
    quCustomerCreditsIDCustomerCredit: TIntegerField;
    quCustomerCreditsIDPessoa: TIntegerField;
    quCustomerCreditsIDUser: TIntegerField;
    quCustomerCreditsIDStore: TIntegerField;
    quCustomerCreditsCreditDate: TDateTimeField;
    quCustomerCreditsExpirationDate: TDateTimeField;
    quCustomerCreditsIDLancamento: TIntegerField;
    quCustomerCreditsAmount: TBCDField;
    tmrProccess: TTimer;
    editInputString: TEdit;
    lbCardError: TLabel;
    btnPayStoreAcc: TXiButton;
    Bevel1: TBevel;
    procedure btCloseClick(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
    procedure btnLayawayClick(Sender: TObject);
    procedure btnAdd20Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPayValueExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPayCashClick(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
    procedure edtPayValueChange(Sender: TObject);
    procedure btnRemovePaymentClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPayValueKeyPress(Sender: TObject; var Key: Char);
    procedure tmrProccessTimer(Sender: TObject);
    procedure editInputStringChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FNoProcessor: TProcessors;
    FManualProcessor: TProcessors;
    FCCProcessor: TProcessors;

    (* >> Mudança << *)
    FquPreSaleInfo : TADOQuery;
    (* >> Mudança << *)
    FquPreSaleValue: TADOStoredProc;
    (* >> Mudança << *)
    FquPreSaleItem : TADOStoredProc;
    FBonnusBuck    : Currency;
    (* >> Mudança Externa << *)
    FInvoiceInfo   : TInvoiceInfo;
    FAmount        : Currency;
    (* >> Mudança Externa << *)
    FSaleReceive   : TSaleReceive;

    FDocumentInfo: TDocumentInfo;

    FFrmPromoControl: TFrmPromoControl;


    FChange        : Currency;
    FResult        : Boolean;
    FLeftBonus     : Currency;
    FCustomerCredit: Currency;
    FInputText     : WideString;
    FCoupon        : String;

    FFrmListPayments: TFrmListPayments;
    (* >> Mudança Externa << *)
    FFrmPayPartial: TFrmPayPartial;
    FrmGiftCardNumber: TFrmGiftCardNumber;
    FFrmCashBackValue : TFrmCashBackValue;

    FCanClosewindow : Boolean;

    // Antonio 10/08/2015 -
    procedure reloadPaymentFromSaleReceive();
    procedure RefreshCustomer;
    procedure RefreshPayments;
    procedure RefreshInitialValues;
    procedure RefreshValues;
    procedure SetAmount(const Value: Currency);
    procedure SetChange(const Value: Currency);

    procedure InsertCash(AIDPayment: Integer; AAmount: Currency);
    procedure InsertCashBack(AIDPayment:Integer);
    procedure InsertCheck(AIDPayment: Integer; AAmount: Currency; APreDatado: Boolean);
    procedure InsertBonusBucks(AIDPayment: Integer; ABonusBucks: TBonusBucks = nil);
    procedure InsertOther(AIDPayment: Integer; AAmount: Currency);
    procedure InsertGiftCard(AIDPayment: Integer; AAmount: Currency; APreDatado: Boolean; Swiped : Boolean);
    procedure InsertCustomerCredit(AIDPayment: Integer; AAmount: Currency);
    procedure InsertStoreAccount(AIDPayment: Integer; AAmount: Currency);

    //amfsouza 10.18.2011 - Gift card from anothers companies
    procedure InsertGiftCardMercury(AIDPayment: Integer; AAmount: Currency; APreDatado: Boolean; Swiped : Boolean);
    procedure CalculatePaymentType(argiType, argiIDPaymentType: Integer; argAmount: Currency; argPredatado: Boolean);

    function ValidatePayment(AType: Integer) : Boolean;
    function ValidateInsertPayment(AType, AIDPaymentType: Integer) : Boolean;
    function ValidateReceive : Boolean;
    function ValidateCancel : Boolean;
    function ValidadeStoreAccount : Boolean;
    function IdentifyCard(AInputText : WideString): Boolean;

    function UseBonusBuck(ABonusBucks : TBonusBucks) : Boolean;
    procedure InsertBBList;
    procedure InsertPayment(AType, AIDPayment: Integer; AAmount: Currency);
    procedure AddPaymentList(APayment: TPayment);
    procedure RemovePaymentList(AID: Integer);

    function GetDescType(AType: Integer): String;

    procedure OpenPaymentTypes;
    procedure ClosePaymentTypes;
    function GetPaymentTypeValues(ID : Integer; Field : String):Variant;

    function CloseLayaway: Boolean;

    procedure OpenCustomerCredit;
    procedure CloseCustomerCredit;
    procedure RefreshCustomerCredit;
    function GetCustomerCredit : Currency;

    procedure ClearCardSwipeError;

    procedure CallFunction(Key: Word);

    procedure RefreshCashButtons;
    procedure FormatCashButtons(ABtn : TXiButton; AValue : Integer);
    function GetFirstBill(Value:Integer):Integer;
    function GetMidleBill(Value:Integer):Integer;
    function GetLastBill(Value:Integer):Integer;

    function GetTotalDue: Currency;
    function TestCupon: Boolean;

    property TotalDue: Currency read GetTotalDue;
    property Amount  : Currency read FAmount write SetAmount;
    property Change  : Currency read FChange write SetChange;

    function GetStateK (Key: integer): boolean;

    // This function verify if cc processor setting was configured.
    function getConfigProcessor: TProcessor;
    function getConfigDeviceProcess: Integer;
    procedure initializeVariables();

    // Antonio 05/26/2016: function to get list of payments
    function CallListPayment(arg_typeOfPayment: Integer): Boolean;

  public
    procedure InsertCreditCard(AIDPayment: Integer; AAmount: Currency; APreDatado: Boolean; Swiped : Boolean);
    procedure InsertDebitCard(AIDPayment: Integer; AAmount: Currency);

    (* >> Mudança No Chamador << *)
    function Start(quPreSaleInfo: TADOQuery;
                   quPreSaleValue: TADOStoredProc;
                   quPreSaleItem: TADOStoredProc;
                   InvoiceInfo: TInvoiceInfo;
                   FrmPromoControl: TFrmPromoControl;
                   var AChange: Double): Boolean;overload;

    function Start(ADocumentInfo: TDocumentInfo; AIDCashRegMov : Integer;
                   var AChange: Double): Boolean; overload;
  end;

implementation

uses uFrmSearchCustomer, uMsgBox, uMsgConstant, uCharFunctions, uPassword,
  uNumericFunctions, uSystemConst, uDM, uDMGlobal, StrUtils, Math,
  uGynboSyncClasses, uDebugFunctions;

{$R *.dfm}

{ TFrmPaymentReceive }

function TFrmPaymentReceive.Start(ADocumentInfo: TDocumentInfo; AIDCashRegMov : Integer;
   var AChange: Double): Boolean;
begin

  // start 2

  FResult         := False;

  FquPreSaleInfo  := nil;
  FquPreSaleValue := nil;
  FquPreSaleItem  := nil;

  FInvoiceInfo    := TInvoiceInfo.Create(DM.ADODBConnect);
  FInvoiceInfo.IDCashRegMov := AIDCashRegMov;

  FDocumentInfo   := ADocumentInfo;

  cdsPayments.CreateDataSet;

  FSaleReceive                 := TSaleReceive.Create(DM.ADODBConnect, DM.FTraceControl);
  FSaleReceive.LocalPath       := DM.LocalPath;
  FSaleReceive.SoftwareVersion := 'MainRetail ' + DM.fSystem.VerBuild;

  RefreshPayments;

  RefreshInitialValues;
  RefreshCustomer;

  ShowModal;

  FInvoiceInfo.Free;

  Result := FResult;
  AChange := FChange;

end;


(* >> Mudança No Chamador e na << *)
function TFrmPaymentReceive.Start(quPreSaleInfo: TADOQuery; quPreSaleValue,
  quPreSaleItem: TADOStoredProc; InvoiceInfo: TInvoiceInfo;
  FrmPromoControl: TFrmPromoControl; var AChange: Double): Boolean;
var
  totalInvoiceStr: String;
  commaPosition: Integer;
begin

  // start 1

  FResult         := False;

  FquPreSaleInfo  := quPreSaleInfo;
  FquPreSaleValue := quPreSaleValue;
  FquPreSaleItem  := quPreSaleItem;
  FInvoiceInfo    := InvoiceInfo;

  FFrmPromoControl := FrmPromoControl;

  FDocumentInfo := TDocumentInfo.Create;
  with FDocumentInfo do
  begin
    LayAway          := FquPreSaleInfo.FieldByName('LayAway').AsBoolean;
//    totalInvoiceStr  := FloatToStrF(FquPreSaleValue.FieldByName('TotalInvoice').AsCurrency, ffnumber, 14, 3);
    // Antonio 2014 Jun 16
    totalInvoiceStr  := floatToStr(myRound(InvoiceInfo.TotalInvoice, 2));      //FloatToStr(MyRound(FquPreSaleValue.FieldByName('TotalInvoice').AsCurrency, 2));



    commaPosition    := pos(',', totalInvoiceStr);
    if ( commaPosition > 0 ) then
       delete(totalInvoiceStr, commaPosition, 1);

    DocumentTotal    := StrToFloat(totalInvoiceStr);
//    DocumentTotal    := FquPreSaleValue.FieldByName('TotalInvoice').AsCurrency;
    IDTouristGroup   := FquPreSaleInfo.FieldByName('IDTouristGroup').AsInteger;
    IDCustomer       := FquPreSaleInfo.FieldByName('IDCustomer').AsInteger;
    ID               := FquPreSaleInfo.FieldByName('IDPreSale').AsInteger;
    OtherComissionID := FquPreSaleInfo.FieldByName('OtherComissionID').AsInteger;
    IDStore          := FquPreSaleInfo.FieldByName('IDStore').AsInteger;
    DocumentType     := dtInvoice;
  end;
  cdsPayments.CreateDataSet;

  FSaleReceive                 := TSaleReceive.Create(DM.ADODBConnect, DM.FTraceControl);
  FSaleReceive.LocalPath       := DM.LocalPath;
  FSaleReceive.SoftwareVersion := 'MainRetail ' + DM.fSystem.VerBuild;

  RefreshPayments;

  RefreshInitialValues;


  RefreshCustomer;

  ShowModal;


  Result := FResult;
  AChange := FChange;
end;

procedure TFrmPaymentReceive.btCloseClick(Sender: TObject);
begin
  inherited;
  if ValidateCancel then
    Close;
end;

procedure TFrmPaymentReceive.RefreshInitialValues;
begin
  lbSalesTotal.Caption := FormatFloat('#,##0.00', FDocumentInfo.DocumentTotal);
  RefreshValues;
  lbLayway.Visible     := FDocumentInfo.Layaway;
  Change               := 0;
  FCustomerCredit      := 0;
end;

procedure TFrmPaymentReceive.btnCustomerClick(Sender: TObject);
var
  iIDCustomer: Integer;
begin
  inherited;
    case FDocumentInfo.DocumentType of
      dtInvoice:
        begin
          if not FInvoiceInfo.IsShipping then
            if FquPreSaleInfo.Active then
            begin
              with TFrmSearchCustomer.Create(Self) do
                iIDCustomer := Start;

              if (iIDCustomer <> -1) and (FDocumentInfo.IDCustomer <> iIDCustomer) then
                if FSaleReceive.GetPaymentTotalByType(PAYMENT_TYPE_CREDIT) > 0 then
                  begin
                    MsgBox(MSG_INF_DEL_CUSTOMER_CREDIT, vbInformation + vbOkOnly);
                    Exit;
                  end;

              if iIDCustomer <> -1 then
              begin
                FquPreSaleInfo.Edit;
                FquPreSaleInfo.FieldByName('IDCustomer').AsInteger := iIDCustomer;
                FDocumentInfo.IDCustomer                           := iIDCustomer;
                FquPreSaleInfo.Post;
                RefreshCustomer;
              end;
            end;
        end;
      dtServiceOrder:;
    end;

end;

procedure TFrmPaymentReceive.btnLayawayClick(Sender: TObject);
begin
  inherited;

  // if document type is layaway do nothing.
  case FDocumentInfo.DocumentType of
    dtInvoice:
      begin
        if not FInvoiceInfo.IsShipping then
          if FquPreSaleInfo.Active then
            if cdsPayments.IsEmpty then begin
              //amfsouza: 10.14.2010: specific to layaway payment.
              MsgBox(MSG_CRT_LAYAWAY_DOWNPAYMENT, vbInformation + vbOKOnly);
              FDocumentInfo.LayAway := true;
//              FInvoiceInfo.Layaway := true;
              lbLayway.Visible := True;
            end
            else if FDocumentInfo.IDCustomer <> 1 then
            begin
              FquPreSaleInfo.Edit;
              FquPreSaleInfo.FieldByName('Layaway').AsBoolean := True;
              FDocumentInfo.Layaway := True;
              FquPreSaleInfo.Post;
              lbLayway.Visible := True;
              FInvoiceInfo.Layaway := True;
            end
            else
              //amfsouza: 10.14.2010: specific to layaway customer.
              MsgBox(MSG_CRT_LAYAWAY_CUSTOMER, vbInformation + vbOkOnly);
      end;
    dtServiceOrder:;
  end;

end;

procedure TFrmPaymentReceive.btnAdd20Click(Sender: TObject);
begin
  inherited;

  ClearCardSwipeError;
  if ValidatePayment(1) then
    if (Amount <> 0) then
    begin
      InsertCash(1, TXiButton(Sender).Tag);
      RefreshValues;

      edtPayValue.SetFocus;
      edtPayValue.SelectAll;
    end;

end;

procedure TFrmPaymentReceive.SetAmount(const Value: Currency);
begin
  FAmount := Value;
  edtPayValue.Text := floatToStrF(Famount, ffNumber, 15, 2);
end;

procedure TFrmPaymentReceive.FormShow(Sender: TObject);
begin
  inherited;
  FCanClosewindow := True;

  edtPayValue.SetFocus;
  ClearCardSwipeError;
end;

procedure TFrmPaymentReceive.edtPayValueExit(Sender: TObject);
begin
  inherited;
  FAmount := MyRound(MyStrToMoney(edtPayValue.Text), 2);
end;

procedure TFrmPaymentReceive.FormCreate(Sender: TObject);
begin
  inherited;
  FFrmListPayments := TFrmListPayments.Create(Self);
  FFrmPayPartial := TFrmPayPartial.Create(Self);
  FrmGiftCardNumber := TFrmGiftCardNumber.Create(Self);
  FFrmCashBackValue := TFrmCashBackValue.Create(Self);
  OpenPaymentTypes;

  //sets
  FNoProcessor     := [tpNoProcessor];
  FManualProcessor := [tpManual];
  FCCProcessor     := [tpPCharge, tpMercury];
end;

procedure TFrmPaymentReceive.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FFrmListPayments) then
    FreeAndNil(FFrmListPayments);

  if Assigned(FFrmPayPartial) then
    FreeAndNil(FFrmPayPartial);

  if Assigned(FrmGiftCardNumber) then
    FreeAndNil(FrmGiftCardNumber);

  if Assigned(FSaleReceive) then
    FreeAndNil(FSaleReceive);

  if Assigned(FFrmCashBackValue) then
    FreeAndNil(FFrmCashBackValue);

  //Somente quando o qu estiver <> nil
  if Assigned(FquPreSaleInfo) then
    FreeAndNil(FDocumentInfo);

  ClosePaymentTypes;

end;

procedure TFrmPaymentReceive.btnPayCashClick(Sender: TObject);
var
  bPreDatado: Boolean;
  iType, iIDPaymentType: Integer;
  cdsGetPaymentType: TClientDataset;
begin
  inherited;

  iType := TXiButton(Sender).Tag;
  ClearCardSwipeError;

  case FDocumentInfo.DocumentType of
    dtServiceOrder:
       begin
         case iType of
           PAYMENT_TYPE_GIFTCARD,
           PAYMENT_TYPE_BONUSBUCK,
           PAYMENT_TYPE_CREDIT : Exit;
         end;
       end;
  end;


  if ValidatePayment(iType) then begin
      // Alex 09/25/2015 - Removed fDeviceProcess and added AllowSelectPaymentType
      // Antonio 03/09/2016 - AllowSelectPaymentType := not(iType in [PAYMENT_TYPE_CARD,PAYMENT_TYPE_DEBIT]);

{
      AllowSelectPaymentType := dm.fMRMercury.Processor in [PROCESSOR_MERCURY];
      AllowSelectPaymentType := AllowSelectPaymentType and (dm.fMRMercury.DeviceProcess in [PROCESSING_TYPE_MANUAL_CHARGE, PROCESSING_TYPE_DSICLIENTX]);
      AllowSelectPaymentType := AllowSelectPaymentType and (iType in [PAYMENT_TYPE_CARD,PAYMENT_TYPE_DEBIT]);

      //PAYMENT_TYPE_OTHER = 3
}
      if ( CallListPayment(iType) ) then begin
          if ( FFrmListPayments.Start(iType, iIDPaymentType, bPreDatado) ) then begin
              CalculatePaymentType(iType, iIDPaymentType, Amount, bPredatado);
          end;
      end else begin
               // I don't need card name but I need an iIDPayment
               // Antonio 04/18/2016
               cdsGetPaymentType := dm.getPaymentWayByPayType(iType, 'sale');
               iIDPaymentType := cdsGetPaymentType.FieldByName('IDMeioPag').Value;
               CalculatePaymentType(iType, iIDPaymentType, Amount, bPredatado);
               freeAndNil(cdsGetPaymentType);
          end;

      RefreshValues;
  end;

  edtPayValue.SetFocus;
  edtPayValue.SelectAll;
end;

procedure TFrmPaymentReceive.RefreshPayments;
var
  i: Integer;
begin
  FSaleReceive.LoadPayments(FDocumentInfo, DM.fUser.ID);

  if FSaleReceive.PaymentList.Count > 0 then
    for i := 0 to Pred(FSaleReceive.PaymentList.Count) do
      AddPaymentList(TPayment(FSaleReceive.PaymentList[i]));
end;

procedure TFrmPaymentReceive.btnFinishClick(Sender: TObject);
var
  cBonusValue: Currency;
  BonusBucks: TBonusBucks;
begin
  inherited;

  DM.FTraceControl.TraceIn('TFrmPaymentReceive.btnFinishClick');

  FResult := False;

  if ValidateReceive then
  begin
    if FSaleReceive.ProcessPayments then
    begin

      case FDocumentInfo.DocumentType of
        dtInvoice:
        begin

          if (not FDocumentInfo.Layaway) or
             ((TotalDue = 0) and  CloseLayaway) then
          begin
            cBonusValue := 0;

            if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
            try
              BonusBucks := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
              BonusBucks.IDPreSaleCreated := FInvoiceInfo.IDPreSale;
              cBonusValue := BonusBucks.DiscountValue + FLeftBonus;
              FLeftBonus := 0;
            finally
              FreeAndNil(BonusBucks);
            end;

            DM.FBonusSync.MemberCard  := FDocumentInfo.CustomerCard;
            DM.FBonusSync.MemberEmail := FDocumentInfo.CustomerEmail;

            if not FSaleReceive.CompleteSale(FInvoiceInfo, FDocumentInfo.IDTouristGroup,
                                      FDocumentInfo.OtherComissionID, cBonusValue,
                                      (FSaleReceive.GetPaymentTotalByType(PAYMENT_TYPE_CASH) - Change),
                                      DM.FBonusSync) then
            begin
              //MsgBox(FSaleReceive.ErrorMsg, vbCritical + vbOkOnly);
              ShowMessage(FSaleReceive.ErrorMsg);
              Exit;
            end
            else //ELIANDRO
            begin
              FFrmPromoControl.NewAdjustFrequentPromo;
            end;

          end;
        end;

        dtServiceOrder :
        begin
          if (TotalDue = 0) then
            if not FSaleReceive.CompleteServiceOrder then
            begin
              ShowMessage(FSaleReceive.ErrorMsg);
              Exit;
            end;
        end;
      end;

     //AQUI


    end
    else
      begin
        //MsgBox(FSaleReceive.ErrorMsg, vbCritical + vbOkOnly);
        ShowMessage(FSaleReceive.ErrorMsg);
        Exit;
      end;

    //OU AQUI


    FResult := True;
    Close;
  end;

  DM.FTraceControl.TraceOut;

end;

function TFrmPaymentReceive.CloseLayaway: Boolean;
begin
  Result := (MsgBox(MSG_QST_CLOSE_LAYAWAY, vbYesNo + vbQuestion) = vbYes);
end;


procedure TFrmPaymentReceive.InsertPayment(AType, AIDPayment: Integer; AAmount: Currency);
begin
  RefreshValues;
end;

procedure TFrmPaymentReceive.AddPaymentList(APayment: TPayment);
begin
  with cdsPayments do
  begin
    Append;
    FieldByName('ID').AsInteger := APayment.PaymentIndex;
    FieldByName('Image').AsInteger := StrToIntDef(VarToStr(GetPaymentTypeValues(APayment.IDPaymentType, 'ImageIndex')),0);
    FieldByName('PaymentForm').AsString := VarToStr(GetPaymentTypeValues(APayment.IDPaymentType, 'MeioPag'));
    FieldByName('PaymentType').AsString := GetDescType(APayment.GetPaymentType);
    FieldByName('PaymentDate').AsDateTime := APayment.PaymentDate;
    FieldByName('PaymentValue').AsCurrency := APayment.PaymentValue;
    Post;
  end;

  //PollDisplay
  DM.PollDisplayAddPayment(cdsPayments.FieldByName('ID').AsInteger,
                           cdsPayments.FieldByName('PaymentForm').AsString,
                           cdsPayments.FieldByName('PaymentValue').AsCurrency);

end;

procedure TFrmPaymentReceive.RefreshValues;
begin
  Amount                := TotalDue;
  lbPayments.Caption    := FormatFloat('#,##0.00', FSaleReceive.GetPaymentTotal);
  lbTotalDue.Caption    := FormatFloat('#,##0.00', Amount);
  FSaleReceive.ErrorMsg := '';
  FInputText            := '';
  RefreshCashButtons;
  grdPaymentsDB.DataController.Groups.FullExpand;

end;

procedure TFrmPaymentReceive.InsertCash(AIDPayment: Integer; AAmount: Currency);
begin
  if ABS(AAmount) > ABS(TotalDue) then
  begin
    Change := (TotalDue - ABS(AAmount));
    AAmount := TotalDue;
  end;

  if FSaleReceive.InsertPayment(PAYMENT_TYPE_CASH, AIDPayment,
     FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
     Now, AAmount) then
    AddPaymentList(FSaleReceive.GetLastPayment)
  else
    //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
    ShowMessage(FSaleReceive.ErrorMsg);
end;

procedure TFrmPaymentReceive.InsertCashBack(AIDPayment:Integer);
var
  dAmount: Currency;
begin
  if FFrmCashBackValue.Start then
  begin
    dAmount := (FFrmCashBackValue.CashBackValue * -1);
    //FSaleReceive.IsCashBack := true;
    if FSaleReceive.InsertPayment(PAYMENT_TYPE_CASH, AIDPayment,
       FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
       Now, dAmount) then
      AddPaymentList(FSaleReceive.GetLastPayment)
    else
      //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
      ShowMessage(FSaleReceive.ErrorMsg);
  end;
end;

procedure TFrmPaymentReceive.InsertCreditCard(AIDPayment: Integer;
  AAmount: Currency; APreDatado: Boolean; Swiped : Boolean);
var
  i: Integer;
begin

  if ( dm.fPCCharge.DeviceProcess <> PROCESSING_TYPE_MANUAL_CHARGE ) then begin

      if ( getConfigProcessor in FNoProcessor ) then
      begin
         MsgBox(MSG_CRT_PAYMENT_PROCESSOR_NOT_FOUND, vbInformation + vbOKOnly);
         exit;
      end;

  end;

  // Antonio 2013 Oct 28, MR-80
  if ( AAmount < 0 ) then begin
     fInvoiceInfo.IDPreSaleRefund := FInvoiceInfo.IDPreSale;
     FInvoiceInfo.RefundDate := now;
  end;

  if APreDatado and (not Swiped) then
  begin
    FFrmPayPartial.Start(AIDPayment, FDocumentInfo.IDCustomer,
      FInvoiceInfo.IDPreSale, FInvoiceInfo.IDCashRegMov, AAmount, Now, '99999', 1, 0);

    if FFrmPayPartial.HasDeposit then
     for i := 0 to FFrmPayPartial.tvPartialPay.Items.Count-1 do
       if FSaleReceive.InsertPaymentCreditCard(PAYMENT_TYPE_CARD,
                         AIDPayment,
                         FInvoiceInfo.IDCashRegMov,
                         FDocumentInfo.IDCustomer,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).ExpireDate,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).Valor,
                         '',
                         FInvoiceInfo.IDPreSaleRefund,
                         FInvoiceInfo.RefundDate) then
         AddPaymentList(FSaleReceive.GetLastPayment);
  end
  else
  if FSaleReceive.InsertPaymentCreditCard(PAYMENT_TYPE_CARD, AIDPayment,
     FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
     Now, AAmount, FInputText, FInvoiceInfo.IDPreSaleRefund,
     FInvoiceInfo.RefundDate) then
  begin
    AddPaymentList(FSaleReceive.GetLastPayment);
  end
  else
  if not Swiped then begin
    //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
    ShowMessage(FSaleReceive.ErrorMsg);
  end;
end;

procedure TFrmPaymentReceive.InsertDebitCard(AIDPayment: Integer; AAmount: Currency);
begin
  if ( getConfigProcessor in FNoProcessor ) then
  begin
     MsgBox(MSG_CRT_PAYMENT_PROCESSOR_NOT_FOUND, vbInformation + vbOKOnly);
     exit;
  end;

  if FSaleReceive.InsertPaymentDebitCard(PAYMENT_TYPE_DEBIT, AIDPayment,
     FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
     Now, AAmount, DM.fPinPad, FInvoiceInfo.IDPreSaleRefund,
     FInvoiceInfo.RefundDate) then
   AddPaymentList(FSaleReceive.GetLastPayment)
  else begin
    //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
    ShowMessage(FSaleReceive.ErrorMsg);
    FSaleReceive.SavePaymentTypeDebitCard := -11;
    FSaleReceive.SaveIdPaymentTypeDebitCard := 0;
  end;
end;

procedure TFrmPaymentReceive.InsertCheck(AIDPayment: Integer;
  AAmount: Currency; APreDatado: Boolean);
var
  i: Integer;
begin
  if APreDatado then
  begin
    FFrmPayPartial.Start(AIDPayment, FDocumentInfo.IDCustomer,
      FInvoiceInfo.IDPreSale, FInvoiceInfo.IDCashRegMov, AAmount, Now, '99999', 1, 0);

    if FFrmPayPartial.HasDeposit then
     for i := 0 to FFrmPayPartial.tvPartialPay.Items.Count-1 do
       if FSaleReceive.InsertPaymentCheck(PAYMENT_TYPE_CHECK,
                         AIDPayment,
                         FInvoiceInfo.IDCashRegMov,
                         FDocumentInfo.IDCustomer,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).ExpireDate,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).Valor,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).NumeroDoc,
                         IntToStr(i+1) + '/' + IntToStr(FFrmPayPartial.tvPartialPay.Items.Count),
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).DocCliente,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).NomeCliente,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).Telefone,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).OBS,
                         MyStrToInt(TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).Banco),
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).PaymentPlace,
                         APreDatado) then
         AddPaymentList(FSaleReceive.GetLastPayment);
  end
  else
    if FSaleReceive.InsertPayment(PAYMENT_TYPE_CHECK, AIDPayment,
       FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
       Now, AAmount) then
      AddPaymentList(FSaleReceive.GetLastPayment)
    else
      //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
      ShowMessage(FSaleReceive.ErrorMsg);

end;

function TFrmPaymentReceive.GetDescType(AType: Integer): String;
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
      case AType of
        1: Result := 'Cash';
        2: Result := 'Credit Card';
        3: Result := 'Other';
        4: Result := 'Check';
        5: Result := 'Store Credit';
        6: Result := 'Gift Card';
        7: Result := 'Debit Card';
        8: Result := 'Bonus Bucks';
      end;

    LANG_PORTUGUESE:
      case AType of
        1: Result := 'Cash';
        2: Result := 'Credit Card';
        3: Result := 'Other';
        4: Result := 'Check';
        5: Result := 'Store Credit';
        6: Result := 'Gift Card';
        7: Result := 'Debit Card';
        8: Result := 'Bonus Bucks';
      end;

    LANG_SPANISH :
      case AType of
        1: Result := 'Cash';
        2: Result := 'Credit Card';
        3: Result := 'Other';
        4: Result := 'Check';
        5: Result := 'Store Credit';
        6: Result := 'Gift Card';
        7: Result := 'Debit Card';
        8: Result := 'Bonus Bucks';
      end;
  end;
end;

procedure TFrmPaymentReceive.InsertBonusBucks(AIDPayment: Integer;
  ABonusBucks: TBonusBucks = nil);
var
  bValidCoupon: Boolean;
  cAmount: Currency;
  bbBonus: TBonusBucks;
begin
  bValidCoupon := False;

  if not Assigned(ABonusBucks) then
  begin
    FCoupon := UpperCase(InputBox('Enter Coupon', 'Coupon Number: ', ''));
    if (FCoupon <> '') and TestCupon then
    begin
      bbBonus := TBonusBucks(FInvoiceInfo.BonusBuckList[FInvoiceInfo.BonusBuckList.Add(TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync))]);
      bbBonus.IDPreSaleCreated := FInvoiceInfo.IDPreSale;
      bbBonus.LoadByCupom(FCoupon);
      bValidCoupon := bbBonus.ValidateCoupon;

      if not bValidCoupon then
      begin
        MsgBox(bbBonus.ErrorMsg, vbInformation + vbOKOnly);
        FInvoiceInfo.BonusBuckList.Remove(bbBonus);
      end
      else
        ABonusBucks := bbBonus;
    end;
  end;

  if bValidCoupon or Assigned(ABonusBucks) then
  begin
    if MyRound(ABonusBucks.DiscountValue, 2) > TotalDue then
    begin
      cAmount := TotalDue;
      FLeftBonus := MyRound(ABonusBucks.DiscountValue, 2) - TotalDue;
    end
    else
      cAmount := MyRound(ABonusBucks.DiscountValue, 2);

    if (cAmount > 0) then
      if UseBonusBuck(ABonusBucks) then
      begin
        if ABonusBucks.DiscountValue <> 0 then
           cAmount := ABonusBucks.DiscountValue;
           
        if FSaleReceive.InsertPaymentBonusBucks(PAYMENT_TYPE_BONUSBUCK, AIDPayment,
           FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
           Now, cAmount, ABonusBucks) then
          AddPaymentList(FSaleReceive.GetLastPayment)
        else
        begin
          //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
          ShowMessage(FSaleReceive.ErrorMsg);
          //UndoBonus
        end;
      end;
  end;

end;

procedure TFrmPaymentReceive.edtPayValueChange(Sender: TObject);
var
  commaPos: Integer;
  valueStr: String;
begin
  inherited;
  try
    valueStr:= edtPayValue.Text;
    commaPos := Pos(',', valueStr);
    if ( commaPos > 0 ) then
      delete(valueStr, commaPos, 1);
    FAmount := StrToCurr(valueStr);
  except
  end;
end;

procedure TFrmPaymentReceive.InsertOther(AIDPayment: Integer;
  AAmount: Currency);
begin
  if FSaleReceive.InsertPayment(PAYMENT_TYPE_OTHER, AIDPayment,
     FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
     Now, AAmount) then
    AddPaymentList(FSaleReceive.GetLastPayment)
  else
    //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
    ShowMessage(FSaleReceive.ErrorMsg);

end;

procedure TFrmPaymentReceive.InsertGiftCard(AIDPayment: Integer; AAmount: Currency; APreDatado: Boolean; Swiped : Boolean);
var
   idPaymentType: Integer;
   IdMeioPag: Integer;
begin
  debugtofile('inside insertGiftCard Method - begin');
  idMeioPag := dm.createMercuryPaymentType(AIdPayment);
  if ( idMeioPag > 0 ) then begin
      if ( ValidateInsertPayment(PAYMENT_TYPE_GIFTCARD, IDMeioPag) ) then begin
           if ( FSaleReceive.InsertPaymentGiftCardMercury(PAYMENT_TYPE_GIFTCARD, IDMeioPag,
                FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer, now(), AAmount, FInputText,
                FInvoiceInfo.IDPreSaleRefund, FInvoiceInfo.RefundDate) ) then
                AddPaymentList(FSaleReceive.GetLastPayment)
           else
                ShowMessage(FSaleReceive.ErrorMsg);
      end;
  end
  else begin
      if ( ValidateInsertPayment(PAYMENT_TYPE_GIFTCARD, AIDPayment) ) then begin
          if FrmGiftCardNumber.Start then
          begin
            if FSaleReceive.InsertPaymentGiftCard(PAYMENT_TYPE_GIFTCARD, AIDPayment,
               FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
               Now, AAmount, FrmGiftCardNumber.GiftCardNumber) then
              AddPaymentList(FSaleReceive.GetLastPayment)
            else
              //MsgBox(FSaleReceive.ErrorMsg, vbCritical + vbOKOnly);
              ShowMessage(FSaleReceive.ErrorMsg);
          end;
      end;
  end;

end;

procedure TFrmPaymentReceive.btnRemovePaymentClick(Sender: TObject);
var
  paymentTotal : Currency;
  iType: Integer;
begin
  inherited;
  // Antonio 10/05/2015
  RefreshValues();

  if not cdsPayments.IsEmpty then
  begin

    case FDocumentInfo.DocumentType of
      dtServiceOrder:
          begin
            if not Password.HasFuncRight(77) then
            begin
              MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly);
              Exit;
            end;
          end;
      else
          begin
            if not Password.HasFuncRight(44) then
            begin
              MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly);
              Exit;
            end;
          end;
    end;

    if FSaleReceive.DeletePayment(cdsPaymentsID.AsInteger) then
    begin
      paymentTotal := FSaleReceive.GetPaymentTotal;

      if ABS(paymentTotal) > ABS(FDocumentInfo.DocumentTotal) then
        Change := TotalDue
      else
        Change := 0;

//    showMessage(format('cdsPayments = %d, SaleReceivePayments = %d ', [cdsPayments.RecordCount, fsaleReceive.PaymentList.Count]));
    
    if ( cdsPaymentsPaymentType.asString = 'Credit Card' ) then begin
         RemovePaymentList(cdsPaymentsID.AsInteger);
         RefreshPayments;

         reloadPaymentFromSaleReceive();

    end else begin
         RemovePaymentList(cdsPaymentsID.AsInteger);
        end;

      RefreshValues;
    end
    else
      MsgBox(MSG_CRT_NO_DEL_PAYMENT, vbInformation + vbOkOnly);
  end;

end;

procedure TFrmPaymentReceive.RemovePaymentList(AID: Integer);
begin
  with cdsPayments do
  begin
    if Locate('ID', AID, []) then
    begin
      Delete;
      //PollDisplay
      DM.PollDisplayDeletePayment(AID);
    end;
  end;
end;

procedure TFrmPaymentReceive.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsPayments.Close;
end;

procedure TFrmPaymentReceive.ClosePaymentTypes;
begin
  with cdsPaymentTypes do
    if Active then
      Close;
end;

procedure TFrmPaymentReceive.OpenPaymentTypes;
begin
  with cdsPaymentTypes do
    if not Active then
      Open;
end;

function TFrmPaymentReceive.GetPaymentTypeValues(ID: Integer;
  Field: String): Variant;
begin
  Result := Null;

  with cdsPaymentTypes do
    if Locate('IDMeioPag', ID, []) then
      Result := FieldByName(Field).Value;

end;

procedure TFrmPaymentReceive.SetChange(const Value: Currency);
begin
  FChange := Value;

  lbChangeValue.Visible := (FChange <> 0);
  lbChange.Visible      := (FChange <> 0);

  lbChangeValue.Caption := FormatFloat('#,##0.00', FChange);
  
end;

procedure TFrmPaymentReceive.RefreshCustomer;
begin
  lbCustomer.Caption := '';
  lbStoreCredit.Caption := '';

  if (FDocumentInfo.IDCustomer <> 1) then
  begin
    with quCustomerInfo do
    try
      Parameters.ParamByName('IDPessoa').Value := FDocumentInfo.IDCustomer;
      Open;
      if not IsEmpty then
      begin
        lbCustomer.Caption              := FieldByName('Pessoa').AsString;
        FDocumentInfo.Nonpayer          := FieldByName('Nonpayer').AsBoolean;
        FDocumentInfo.StoreAccountLimit := FieldByName('StoreAccountLimit').AsCurrency;
        FDocumentInfo.CustomerCard      := FieldByName('CustomerCard').AsString;
        FDocumentInfo.CustomerEmail     := FieldByName('Email').AsString;
      end;
    finally
      Close;
      end;

    RefreshCustomerCredit;

    FCustomerCredit := GetCustomerCredit;

    if (FCustomerCredit <> 0) then
      lbStoreCredit.Caption := 'Store Credit : ' + FormatFloat('#,##0.00', FCustomerCredit);
  end;
end;

procedure TFrmPaymentReceive.InsertCustomerCredit(AIDPayment: Integer;
  AAmount: Currency);
begin
  if (FCustomerCredit <> 0) or (AAmount < 0) then
  begin
    if AAmount > FCustomerCredit then
      AAmount := FCustomerCredit;

    (* amfsouza 09.26.2011-debug *)dm.FTraceControl.SaveTrace(dm.fUser.ID, 'Debug-Step-begin: try insert payment credit card', '(PII):'+ self.ClassName);
    if FSaleReceive.InsertPayment(PAYMENT_TYPE_CREDIT, AIDPayment,
       FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
       Now, AAmount) then
    begin
      AddPaymentList(FSaleReceive.GetLastPayment);
      TPaymentStoreCredit(FSaleReceive.GetLastPayment).CreditList := cdsCustomerCredit;
          (* amfsouza 09.26.2011-debug *)dm.FTraceControl.SaveTrace(dm.fUser.ID, 'Debug-Step-end: try insert payment credit card', '(PII):'+ self.ClassName);
    end
    else
      //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
      ShowMessage(FSaleReceive.ErrorMsg);

  end;
end;


function TFrmPaymentReceive.ValidateReceive: Boolean;
begin

  Result := False;

  case FDocumentInfo.DocumentType of
    dtInvoice:
    begin

      //INVOICE TESTE
      if not (FDocumentInfo.Layaway) then
      begin
        if TotalDue <> 0 then
        begin
          if (MsgBox(Format(MSG_QST_ADD_CASH_FINISH, [FormatFloat('#,##0.00', Amount)]), vbYesNo + vbQuestion) = vbYes) then
            btnPayCashClick(btnPayCash)
          else
            Exit;
        end;

        if (TotalDue <> 0) then
        begin
          MsgBox(MSG_INF_TOTAL_MUST_BE_ZERO, vbOKOnly + vbInformation);
          Exit;
        end;
      end
      else begin
         //LAYAWAY TESTE
         if (FDocumentInfo.Layaway) then begin
            btnLayawayClick(self);

            result := ( FDocumentInfo.IDCustomer <> 1 );
            if ( not result ) then
               exit;

         end;
      end;

    end;

    dtServiceOrder:
    begin

    end;

  end;

 Result := True;

end;

function TFrmPaymentReceive.ValidatePayment(AType: Integer): Boolean;
begin
  Result := False;

  if TotalDue = 0 then
  begin
    MsgBox(MSG_INF_NOT_ADD_PAYMANETS, vbOKOnly + vbInformation);
    Exit;
  end;

  if (Amount = 0) then
  begin
    MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
    Exit;
  end;

  if (not (AType in [PAYMENT_TYPE_CASH, PAYMENT_TYPE_OTHER])) and (ABS(Amount) > ABS(TotalDue)) then
  begin
    MsgBox(MSG_INF_NOT_GRATER_TOTAL_DUE, vbCritical + vbOkOnly);
    Amount := TotalDue;
    Exit;
  end;

  if (AType = PAYMENT_TYPE_STOREACCOUNT) and (FDocumentInfo.IDCustomer <= 1 ) then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOkOnly);
    btnCustomerClick(Self);
    Exit;
  end;

  //amfsouza 11.03.2011 -
  if (AType = PAYMENT_TYPE_CREDIT) and (FDocumentInfo.IDCustomer <= 1 ) then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOkOnly);
    btnCustomerClick(Self);
    Exit;
  end;

  if DM.fSystem.SrvParam[PARAM_INV_RETURN_WITH_STORECREDIT_ONLY] then
    if (FInvoiceInfo.IDPreSaleRefund = 0) and (Amount < 0 ) and (AType <> PAYMENT_TYPE_CREDIT) then
    begin
      MsgBox(MSG_CRT_INV_RET_WITH_STOREACC, vbCritical + vbOkOnly);
      Exit;
    end;

  if (AType = PAYMENT_TYPE_STOREACCOUNT) then
  begin

    if (Amount < 0 ) then
    begin
      MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
      Exit;
    end;

    if not ValidadeStoreAccount then
      Exit;

  end;

  Result := True;
end;

function TFrmPaymentReceive.ValidateInsertPayment(AType, AIDPaymentType: Integer) : Boolean;
begin
  Result := False;

  // Antonio 2013 Oct 23, MR-74
  ClosePaymentTypes;
  OpenPaymentTypes;

  //Antonio M F Souza, Fev 01, 2013
  if ( AType = PAYMENT_TYPE_CREDIT ) then begin
      if ( abs(amount) > abs(totalDue) ) then begin
         msgBox('Amount = ' + floatToStr(amount) + 'Total due = ' + floatTostr(totalDue) + ' Amount tendered is not equal total due', vbCritical + vbOkOnly);
         exit;
      end;
  end;

  if (AType <> PAYMENT_TYPE_CASHBACK) and (AType <> PAYMENT_TYPE_CASH) and (ABS(Amount) > ABS(TotalDue)) then
  begin
    MsgBox(MSG_INF_NOT_GRATER_TOTAL_DUE, vbCritical + vbOkOnly);
    Amount := TotalDue;
    Exit;
  end;

  if AIDPaymentType <> -1 then
    if StrToBool(GetPaymentTypeValues(AIDPaymentType, 'RequireCustomer')) and (FDocumentInfo.IDCustomer <= 1) then
    begin
      MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
      Exit;
    end;

  if ((FDocumentInfo.IDCustomer > 1)) and (not Password.HasFuncRight(90)) then
  begin
    if FDocumentInfo.Nonpayer and GetPaymentTypeValues(AIDPaymentType, 'ValidateNonpayer') then
    begin
      MsgBox(MSG_CRT_CUSTOMER_NOTUSE_PAYMENT, vbInformation + vbOkOnly);
      Exit;
    end;
  end;

  Result := True;
end;

function TFrmPaymentReceive.ValidateCancel: Boolean;
begin
  Result := False;
  dm.FTraceControl.SaveTrace(dm.fUser.ID, 'debug step: Sale Canceled', self.Name);

  if (not FDocumentInfo.Layaway) and FSaleReceive.HasAutoProcessPayment then
  begin
    MsgBox(MSG_INF_PAYMENTS_CANNOT_CLOSE, vbCritical + vbOkOnly);
    Exit;
  end;

  Result := True;
end;


procedure TFrmPaymentReceive.InsertBBList;
var
  i, iPayType, iIDPaymentType: Integer;
  bPreDatado: Boolean;
  cTotalBonus : Currency;
  sBonusNotAdded : String;
begin
  cTotalBonus := 0;
  sBonusNotAdded := '';
  iPayType := PAYMENT_TYPE_BONUSBUCK;
  if FFrmListPayments.Start(iPayType, iIDPaymentType, bPreDatado) then
    for i:= 0 to Pred(FInvoiceInfo.BonusBuckList.Count) do
    begin
      cTotalBonus := cTotalBonus + TBonusBucks(FInvoiceInfo.BonusBuckList[i]).DiscountValue;
      if (TotalDue = 0)  then
        sBonusNotAdded := sBonusNotAdded + BONUS_BUCKS_PREFIX + IntToStr(TBonusBucks(FInvoiceInfo.BonusBuckList[i]).IDPreSaleCreated) + '. '
      else
        InsertBonusBucks(iIDPaymentType, TBonusBucks(FInvoiceInfo.BonusBuckList[i]));
    end;

  if sBonusNotAdded <> '' then
   MsgBox(MSG_INF_COUPONS_NOT_DISCOUNTED + sBonusNotAdded, vbCritical + vbOkOnly);

end;

function TFrmPaymentReceive.GetTotalDue: Currency;
begin
   Result := FDocumentInfo.DocumentTotal - FSaleReceive.GetPaymentTotal;//FSaleReceive.GetPaymentTotal(FSaleReceive.IsCashBack);
end;

procedure TFrmPaymentReceive.CloseCustomerCredit;
begin
  with cdsCustomerCredit do
    if Active then
      Close;
end;

procedure TFrmPaymentReceive.OpenCustomerCredit;
begin
  with cdsCustomerCredit do
    if not Active then
    begin
      Params.ParamByName('IDDocument').Value := FInvoiceInfo.IDPreSale;
      Params.ParamByName('IDCustomer').Value := FDocumentInfo.IDCustomer;
      Open;
    end;
end;

procedure TFrmPaymentReceive.RefreshCustomerCredit;
begin
  CloseCustomerCredit;
  OpenCustomerCredit;
end;

function TFrmPaymentReceive.GetCustomerCredit: Currency;
begin

  Result := 0;
  with cdsCustomerCredit do
    if Active then
    begin
      First;
      while not EOF do
      begin
        Result := Result + FieldByName('Amount').AsCurrency;
        Next;
      end;
    end;
    
end;


procedure TFrmPaymentReceive.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if ((Key = VK_F4) and (ssAlt in Shift)) then
    FCanClosewindow := False
  else
  begin
   case Key of
    VK_MENU    : ; //Alt
    VK_SHIFT   : ; //Shift
    VK_CONTROL : ; //Crtl
    VK_ESCAPE  : ; //Enter
   else
     CallFunction(Key)
   end;
  end;

end;

procedure TFrmPaymentReceive.CallFunction(Key: Word);
begin

  case Key of
    VK_F1:  btnPayCashClick(btnPayCash);
    VK_F2:  btnPayCashClick(btnPayCheck);
    VK_F3:  btnPayCashClick(btnPayCreditCard);
    VK_F4:  btnPayCashClick(btnPayDebitCard);
    VK_F5:  btnPayCashClick(btnPayGift);
    VK_F6:  btnPayCashClick(btnPayBonus);
    VK_F7:  btnPayCashClick(btnPayStoreCredit);
    VK_F8:  btnPayCashClick(btnPayOther);
    VK_F9:  btnPayCashClick(btnPayStoreAcc);
    VK_F10: btnCustomerClick(Self);
    VK_F11: btnLayawayClick(Self);
    VK_F12: btnFinishClick(Self);
  end;

end;

procedure TFrmPaymentReceive.RefreshCashButtons;
var
  Value20, Value10, Value5 : Integer;
begin

  try
    if TotalDue < 1 then
    begin
      Value5  := 1;
      Value10 := 5;
      Value20 := 10;
    end
    else if TotalDue < 5 then
    begin
      Value5  := 5;
      Value10 := 10;
      Value20 := 20;
    end
    else if TotalDue < 10 then
    begin
      Value5  := 10;
      Value10 := 20;
      Value20 := 50;
    end
    else
    begin
      Value5  := GetFirstBill(Trunc(TotalDue)+1);
      Value10 := GetMidleBill(Value5);
      Value20 := GetLastBill(Value10);
    end;

    FormatCashButtons(btnAdd20, Value20);
    FormatCashButtons(btnAdd10, Value10);
    FormatCashButtons(btnAdd5, Value5);
  except
    end;

end;

procedure TFrmPaymentReceive.FormatCashButtons(ABtn: TXiButton;
  AValue: Integer);
begin
  ABtn.Tag := AValue;
  Abtn.Caption := FormatCurr('$#', AValue);
end;

procedure TFrmPaymentReceive.edtPayValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case Key of
    '%': begin
         Key := #0;
         editInputString.Clear;
//         editInputString.Text := '%B5424180279791765^VERIFONE TEST 1^081210110001111A123456789012?;5424180279791765=08121011000001234567?';
         editInputString.SetFocus;

         // using sets
         if ( not (getConfigProcessor in FCCProcessor) ) then
         begin
           MsgBox(MSG_CRT_PAYMENT_PROCESSOR_NOT_FOUND, vbInformation + vbOKOnly);
           exit;
         end;
         //Master - %B5424180279791765^VERIFONE TEST 1^081210110001111A123456789012?;5424180279791765=08121011000001234567?
         //Visa - %B4012000033330026^VERIFONE TEST 3^081210110001111A123456789012?;4012000033330026=08121011000001234567?
         //editInputString.Text := '%B5424180279791765^VERIFONE TEST 1^081210110001111A123456789012?;5424180279791765=08121011000001234567?';
       end;
  end;

  Key := ValidateDouble(Key);
end;

function TFrmPaymentReceive.GetFirstBill(Value: Integer): Integer;
var
 Temp : Integer;
begin
  Result := Value;
  if Frac(TotalDue) = 0 then
  begin
    Temp := StrToInt(Copy(IntToStr(Result), Length(IntToStr(Result)), 1));
    if (Temp < 5) then
      Result := Result + (5 - Temp)
    else
      Result := Result + (10 - Temp);
  end;
end;

function TFrmPaymentReceive.GetMidleBill(Value: Integer): Integer;
begin
  Result := (StrToInt(Copy(IntToStr(Value), 1, Length(IntToStr(Value))-1))+1) * 10;
end;

function TFrmPaymentReceive.GetLastBill(Value: Integer): Integer;
begin
  Result := StrToInt(Copy(IntToStr(Value), Length(IntToStr(Value))-1, 2));
  if Result < 10 then
    Result := Value + (10 - Result)
  else if Result < 20 then
    Result := Value + (20 - Result)
  else if Result < 50 then
    Result := Value + (50 - Result)
  else
    Result := Value + (100 - Result)
end;


procedure TFrmPaymentReceive.tmrProccessTimer(Sender: TObject);
var
  iType: Integer;

begin
  inherited;
  iType := TXiButton(Sender).Tag;
  tmrProccess.Enabled := False;

 (* not working ( to remove this instructions
  //to try avoid wrong debit_cc results ( in database and print receipt )
  if ( iType = PAYMENT_TYPE_DEBIT ) then
     exit;

  *)

  if (Trim(editInputString.Text) <> '') then
  begin
    if ValidateInsertPayment(PAYMENT_TYPE_CARD, -1) then
    begin

      FInputText := editInputString.Text;

      if (FInputText <> '') and (Copy(FInputText, 1, 1) <> '%') then
        FInputText := '%' + FInputText;

      IdentifyCard(FInputText);
    end;
    edtPayValue.SetFocus;
    edtPayValue.SelectAll;
  end;

end;

procedure TFrmPaymentReceive.editInputStringChange(Sender: TObject);
begin
  inherited;
  tmrProccess.Enabled := False;
  tmrProccess.Enabled := True;
end;

function TFrmPaymentReceive.IdentifyCard(AInputText: WideString): Boolean;
var
  IDMeioPag : Integer;
  bPreDatado : Boolean;
begin

  Result := False;

  IDMeioPag := DM.fPCCharge.IdentifySwipedCard(AInputText);

  if (IDMeioPag <> -1) and ValidateInsertPayment(PAYMENT_TYPE_CARD, IDMeioPag) then
  begin
    (* 12.26.2011 - why so specific ? ( InsertCreditCard ). If were a debit card ?... *)
    InsertCreditCard(IDMeioPag, Amount, bPreDatado, True);
    Result := (FSaleReceive.ErrorMsg = '');
    if not Result then
      lbCardError.Caption := FSaleReceive.ErrorMsg
    else
      ClearCardSwipeError;
    RefreshValues;
    if Result and (TotalDue = 0) then
      btnFinishClick(Self);
  end
  else begin  //amfsouza 02.12.2011
    lbCardError.Caption := 'Card not recognized. Try it again or configure the credit card on the Client Parameters!';
    btnPayCashClick(self);
  end;

end;

function TFrmPaymentReceive.TestCupon: Boolean;
var
  c: Char;
  i: integer;
  s: String;
begin
  Result := True;
  try
    if (Length(FCoupon) <> 34) then
      if Copy(FCoupon, 1, 2) = 'BB' then
      begin
        s := Copy(FCoupon, 3, length(FCoupon));
        StrToInt(s);
      end;
  except
    MsgBox(MSG_CRT_BONUS_IS_NOT_VALID, vbCritical + vbOKOnly);
    Result := False;
  end;
end;

procedure TFrmPaymentReceive.ClearCardSwipeError;
begin
  lbCardError.Caption   := '';
end;


procedure TFrmPaymentReceive.InsertStoreAccount(AIDPayment: Integer;
  AAmount: Currency);
begin

  // Antonio 09/03/2016 - Delinquent customer. Payment must be aborted.
  if ( FDocumentInfo.Nonpayer ) then begin
     raise Exception.Create('Account payment due. Contact manager.');
  end;

  if (AAmount <> 0) then
  begin

    if FSaleReceive.InsertPayment(PAYMENT_TYPE_STOREACCOUNT, AIDPayment,
       FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer, Now, AAmount) then
      AddPaymentList(FSaleReceive.GetLastPayment)
    else
      //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
      ShowMessage(FSaleReceive.ErrorMsg);
  end;

end;

function TFrmPaymentReceive.ValidadeStoreAccount: Boolean;
var
  fSABanlace : Currency;
begin

  if (FDocumentInfo.IDCustomer > 1) and (not Password.HasFuncRight(89)) then
  begin
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(SA.Amount) as Amount');
      SQL.Add('FROM Sal_StoreAccount SA (NOLOCK)');
      SQL.Add('WHERE SA.IDStoreAccountUsed IS NULL');
      SQL.Add('AND SA.IsUsed = 0');
      SQL.Add('AND SA.IsReceiving = 0');
      SQL.Add('AND SA.IDPessoa = ' + IntToStr(FDocumentInfo.IDCustomer));
      SQL.Add('AND SA.Verify = 0');
      Open;
      fSABanlace := FieldByName('Amount').AsCurrency;
    finally
      Close;
    end;

    if FDocumentInfo.StoreAccountLimit < (fSABanlace + Amount) then
    begin
      MsgBox(Format(MSG_CRT_AS_EXCEED_BALANCE, [FormatFloat('#,##0.00', (fSABanlace + Amount)), FormatFloat('#,##0.00', FDocumentInfo.StoreAccountLimit)]), vbOKOnly + vbCritical);
      Exit;
    end;
  end;

  Result := True;

end;

procedure TFrmPaymentReceive.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := FCanClosewindow;
  FCanClosewindow := True;
end;

function TFrmPaymentReceive.GetStateK(Key: integer): boolean;
begin
  Result := Odd (GetKeyState (Key));
end;

function TFrmPaymentReceive.getConfigProcessor: TProcessor;
begin
  result := TProcessor(dm.fPCCharge.ProcessorType);
end;

function TFrmPaymentReceive.UseBonusBuck(ABonusBucks : TBonusBucks): Boolean;
var
  bError : Boolean;
begin
  Result := False;
  ABonusBucks.DiscountValue := 0;

  if (ABonusBucks.BonusCode <> '') then
  begin
     DM.FBonusSync.BonusCode := ABonusBucks.BonusCode;
      try
        bError := True;
        if DM.FBonusSync.Use then
        begin
          bError := (DM.FBonusSync.IDResult <> 0);
          if not bError then
            ABonusBucks.DiscountValue := DM.FBonusSync.BonusValue;
        end;
      except
      end;

      if bError then
        MsgBox(MSG_CRT_ERROR_USING_BONUS + DM.FBonusSync.ResultMessage, vbOK + vbInformation);
  end;

  Result := True;

end;

procedure TFrmPaymentReceive.InsertGiftCardMercury(AIDPayment: Integer;
  AAmount: Currency; APreDatado, Swiped: Boolean);
var
  i: Integer;
begin

  if ( getConfigProcessor in FNoProcessor ) then
  begin
     MsgBox(MSG_CRT_PAYMENT_PROCESSOR_NOT_FOUND, vbInformation + vbOKOnly);
     exit;
  end;

  if APreDatado and (not Swiped) then
  begin
    FFrmPayPartial.Start(AIDPayment, FDocumentInfo.IDCustomer,
      FInvoiceInfo.IDPreSale, FInvoiceInfo.IDCashRegMov, AAmount, Now, '99999', 1, 0);

    if FFrmPayPartial.HasDeposit then
     for i := 0 to FFrmPayPartial.tvPartialPay.Items.Count-1 do
       if FSaleReceive.InsertPaymentGiftCardMercury(PAYMENT_TYPE_CARD,
                         AIDPayment,
                         FInvoiceInfo.IDCashRegMov,
                         FDocumentInfo.IDCustomer,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).ExpireDate,
                         TPartialPay(FFrmPayPartial.tvPartialPay.Items[i].Data).Valor,
                         '',
                         FInvoiceInfo.IDPreSaleRefund,
                         FInvoiceInfo.RefundDate) then
         AddPaymentList(FSaleReceive.GetLastPayment);
  end
  else
  if FSaleReceive.InsertPaymentGiftCardMercury(PAYMENT_TYPE_CARD, AIDPayment,
     FInvoiceInfo.IDCashRegMov, FDocumentInfo.IDCustomer,
     Now, AAmount, FInputText, FInvoiceInfo.IDPreSaleRefund,
     FInvoiceInfo.RefundDate) then
  begin
     AddPaymentList(FSaleReceive.GetLastPayment);
  end
  else
  if not Swiped then
    //MsgBox(FSaleReceive.ErrorMsg, vbInformation + vbOkOnly);
    ShowMessage(FSaleReceive.ErrorMsg);
end;

function TFrmPaymentReceive.getConfigDeviceProcess: Integer;
begin
   result := dm.fPCCharge.DeviceProcess;
end;

procedure TFrmPaymentReceive.reloadPaymentFromSaleReceive();
var
  i: Integer;
  payment: TPayment;
begin
   cdsPayments.EmptyDataSet;
  for i := 0 to Pred(FSaleReceive.PaymentList.Count) do begin
      payment := TPayment(FSaleReceive.PaymentList[i]);
      AddPaymentList(payment);
  end;
end;


procedure TFrmPaymentReceive.initializeVariables;
begin
  if ( fInvoiceInfo = nil ) then begin
       FInvoiceInfo    := TInvoiceInfo.Create(DM.ADODBConnect);
       //FInvoiceInfo.IDCashRegMov := AIDCashRegMov;
  end;

  if ( fDocumentInfo = nil ) then begin
     //FDocumentInfo   := ADocumentInfo;
  end;

  //cdsPayments.CreateDataSet;
  if ( fSaleReceive = nil ) then begin
    FSaleReceive                 := TSaleReceive.Create(DM.ADODBConnect, DM.FTraceControl);
    FSaleReceive.LocalPath       := DM.LocalPath;
    FSaleReceive.SoftwareVersion := 'MainRetail ' + DM.fSystem.VerBuild;
  end;

end;

procedure TFrmPaymentReceive.CalculatePaymentType(argiType,
  argiIDPaymentType: Integer; argAmount: Currency; argPredatado: Boolean);
begin
  if ( ValidateInsertPayment(argiType, argiIDPaymentType) ) then begin
      case argiType of
          PAYMENT_TYPE_CASH         : InsertCash(argiIDPaymentType, argAmount);
          PAYMENT_TYPE_CARD         : InsertCreditCard(argiIDPaymentType, argAmount, argPreDatado, False);
          PAYMENT_TYPE_OTHER        : InsertOther(argiIDPaymentType, argAmount);
          PAYMENT_TYPE_CHECK        : InsertCheck(argiIDPaymentType, argAmount, argPreDatado);
          PAYMENT_TYPE_CREDIT       : begin
              InsertCustomerCredit(argiIDPaymentType, argAmount);
          end;

          PAYMENT_TYPE_GIFTCARD       : InsertGiftCard(argiIDPaymentType, argAmount, argPreDatado, False );

          PAYMENT_TYPE_DEBIT        : begin
              //amfsouza 04.15.2011 - I just save to use later before PaymentType list creation
              FSaleReceive.SavePaymentTypeDebitCard := argiType;
              FSaleReceive.SaveIdPaymentTypeDebitCard := argiIdPaymentType;
              InsertDebitCard(argiIDPaymentType, argAmount);
          end;

          PAYMENT_TYPE_BONUSBUCK    : InsertBonusBucks(argiIDPaymentType);

          PAYMENT_TYPE_CASHBACK     : begin
              InsertCashBack(argiIDPaymentType);
          end;

          PAYMENT_TYPE_STOREACCOUNT : begin
              InsertStoreAccount(argiIDPaymentType, argAmount);
          end;
      end;
  end;
end;

function TFrmPaymentReceive.CallListPayment(arg_typeOfPayment: Integer): Boolean;
begin
    result := false;

    if ( dm.fMRMercury.DeviceProcess in [PROCESSING_TYPE_DSICLIENTX, PROCESSING_TYPE_MANUAL_CHARGE] ) then begin
       result := true;
    end else if ( arg_typeOfPayment in [PAYMENT_TYPE_OTHER] ) then begin
           result := true;
        end;
end;

end.
