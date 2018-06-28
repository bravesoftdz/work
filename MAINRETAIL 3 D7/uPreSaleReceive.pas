unit uPreSaleReceive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DateBox, DBCtrls, DB, DBTables, Grids, DBGrids,
  Buttons, DBCGrids, ComCtrls, ADODB, SuperComboADO, siComp, siLangRT,
  PaiDeForms, Variants, uFrmPayPartial, uCCMercuryIntegration,
  uFrmCreditPay, uPCCIntegration, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid;

type
  TPreSaleReceive = class(TFrmParentForms)
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    spTestPayType: TADOStoredProc;
    spquPayTypeMin: TADOStoredProc;
    spquPayTypeMinDifDay: TIntegerField;
    spquPayTypeMinTotalSale: TFloatField;
    pgReceive: TPageControl;
    tbSingle: TTabSheet;
    tbMultiple: TTabSheet;
    pnlPaymentType: TPanel;
    Image1: TImage;
    Image3: TImage;
    Label4: TLabel;
    pnlPayTitle: TPanel;
    cmbPaymentType: TSuperComboADO;
    pnlDepositDate: TPanel;
    lblPreDate: TLabel;
    Image6: TImage;
    Image7: TImage;
    spDep30: TSpeedButton;
    spDep60: TSpeedButton;
    spDep90: TSpeedButton;
    pnlDateTitle: TPanel;
    EditDepositDate: TDateBox;
    Label8: TLabel;
    EditTotalInvoice: TEdit;
    pnlShowCash: TPanel;
    lblCashTotal: TLabel;
    EditTotalCash: TEdit;
    lblPlus: TLabel;
    lblReceived: TLabel;
    EditReceived: TEdit;
    lblMinus: TLabel;
    spLine: TShape;
    lblChange: TLabel;
    EditChange: TEdit;
    lblEqual: TLabel;
    Label13: TLabel;
    EditReceiveDate: TDateBox;
    pnlShowAuthorization: TPanel;
    Label1: TLabel;
    EditAuthorization: TEdit;
    pnlMultiParcela: TPanel;
    pnlParc1: TPanel;
    lblParc1: TLabel;
    Label12: TLabel;
    cmbPayType1: TSuperComboADO;
    lblAuto1: TLabel;
    EditAuto1: TEdit;
    EditDep1: TDateBox;
    lblDep1: TLabel;
    Label16: TLabel;
    EditValue1: TEdit;
    pnlParc2: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    lblAuto2: TLabel;
    lblDep2: TLabel;
    Label22: TLabel;
    cmbPayType2: TSuperComboADO;
    EditAuto2: TEdit;
    EditDep2: TDateBox;
    EditValue2: TEdit;
    pnlParc3: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    lblAuto3: TLabel;
    lblDep3: TLabel;
    Label28: TLabel;
    cmbPayType3: TSuperComboADO;
    EditAuto3: TEdit;
    EditDep3: TDateBox;
    EditValue3: TEdit;
    pnlParc4: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    lblAuto4: TLabel;
    lblDep4: TLabel;
    Label33: TLabel;
    cmbPayType4: TSuperComboADO;
    EditAuto4: TEdit;
    EditDep4: TDateBox;
    EditValue4: TEdit;
    pnlParc5: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    lblAuto5: TLabel;
    lblDep5: TLabel;
    Label38: TLabel;
    cmbPayType5: TSuperComboADO;
    EditAuto5: TEdit;
    EditDep5: TDateBox;
    EditValue5: TEdit;
    cbxCloseLayaway: TCheckBox;
    Image4: TImage;
    Image5: TImage;
    pnlLayway: TPanel;
    lblPayment: TLabel;
    lblLayaway: TLabel;
    lbMenus: TLabel;
    Shape1: TShape;
    lbIqual: TLabel;
    lbBalance: TLabel;
    edPayment: TEdit;
    edLayaway: TEdit;
    edtBalance: TEdit;
    spHelp: TSpeedButton;
    btOK: TButton;
    btCancel: TButton;
    btnPartialPayment2: TSpeedButton;
    lbPartialInfo2: TLabel;
    pnlDelayPayments: TPanel;
    lbPartialInfo: TLabel;
    btnPartialPayment: TSpeedButton;
    cbPayPlace1: TComboBox;
    lbPayPlace1: TLabel;
    lbPayPlace2: TLabel;
    cbPayPlace2: TComboBox;
    lbPayPlace3: TLabel;
    cbPayPlace3: TComboBox;
    lbPayPlace4: TLabel;
    cbPayPlace4: TComboBox;
    lbPayPlace5: TLabel;
    cbPayPlace5: TComboBox;
    lblCustomerCredit: TLabel;
    lblCustomerCreditValue: TLabel;
    pnlPaymentPlace: TPanel;
    lbPaymentPlace: TLabel;
    cbPaymentPlace: TComboBox;
    spPreSaleDeleteSingleDelayPayment: TADOStoredProc;
    pnlMultiButtons: TPanel;
    btMulti2: TSpeedButton;
    btMulti3: TSpeedButton;
    btMulti4: TSpeedButton;
    btMulti5: TSpeedButton;
    pnlPayButton: TPanel;
    spPayCash: TSpeedButton;
    spPayVisa: TSpeedButton;
    spPayMaster: TSpeedButton;
    spPayAmerican: TSpeedButton;
    spPayCheck: TSpeedButton;
    pnlShowAccount: TPanel;
    lbAccount: TLabel;
    edtAccountCard: TEdit;
    lbAccountCredit: TLabel;
    lbAccountCreditValue: TLabel;
    quAccountBalance: TADODataSet;
    quAccountBalanceAmount: TBCDField;
    pnlAccount1: TPanel;
    lbAccount1: TLabel;
    edtAccount1: TEdit;
    pnlAccount2: TPanel;
    lbAccount2: TLabel;
    edtAccount2: TEdit;
    pnlAccount3: TPanel;
    lbAccount3: TLabel;
    edtAccount3: TEdit;
    pnlAccount4: TPanel;
    lbAccount4: TLabel;
    edtAccount4: TEdit;
    pnlAccount5: TPanel;
    lbAccount5: TLabel;
    edtAccount5: TEdit;
    quAccountBalanceExpirationDate: TDateTimeField;
    pnlPaySuggestion: TPanel;
    Image2: TImage;
    Image8: TImage;
    pnlPaymentSugg: TPanel;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseDBImageIndex: TcxGridDBColumn;
    grdBrowseDBMeioPag: TcxGridDBColumn;
    grdBrowseDBAmount: TcxGridDBColumn;
    grdBrowseDBOBS: TcxGridDBColumn;
    grdBrowseLevel: TcxGridLevel;
    quUpPayment: TADODataSet;
    quUpPaymentIDPaymentCondition: TIntegerField;
    quUpPaymentIDMeioPag: TIntegerField;
    quUpPaymentMeioPag: TStringField;
    quUpPaymentImageIndex: TIntegerField;
    quUpPaymentAmount: TBCDField;
    quUpPaymentOBS: TStringField;
    dsUpPayment: TDataSource;
    quUpPaymentEstimetedDate: TDateTimeField;
    grdBrowseDBEstimetedDate: TcxGridDBColumn;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spPayCashClick(Sender: TObject);
    procedure spPayVisaClick(Sender: TObject);
    procedure cmbPaymentTypeSelectItem(Sender: TObject);
    procedure spDep30Click(Sender: TObject);
    procedure spPayMasterClick(Sender: TObject);
    procedure spPayAmericanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditReceivedChange(Sender: TObject);
    procedure SelecionaParcela(Sender: TObject);
    procedure cmbPayType1SelectItem(Sender: TObject);
    procedure cmbPayType2SelectItem(Sender: TObject);
    procedure cmbPayType3SelectItem(Sender: TObject);
    procedure cmbPayType4SelectItem(Sender: TObject);
    procedure cmbPayType5SelectItem(Sender: TObject);
    procedure pgReceiveChange(Sender: TObject);
    procedure RecalcTotals(Sender : TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditReceivedExit(Sender: TObject);
    procedure edPaymentChange(Sender: TObject);
    procedure edPaymentExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure edPaymentKeyPress(Sender: TObject; var Key: Char);
    procedure EditValue1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPartialPaymentClick(Sender: TObject);
    procedure btnPartialPayment2Click(Sender: TObject);
    procedure cbPaymentPlaceSelect(Sender: TObject);
    procedure cbPayPlace1Change(Sender: TObject);
    procedure cbPayPlace2Change(Sender: TObject);
    procedure cbPayPlace3Change(Sender: TObject);
    procedure cbPayPlace4Change(Sender: TObject);
    procedure cbPayPlace5Change(Sender: TObject);
    procedure spPayCheckClick(Sender: TObject);
    procedure NeedSwipe(Sender: TObject; var SwipedTrack: WideString;
      var Canceled: Boolean);
    procedure edtAccountCardExit(Sender: TObject);
    procedure edtAccountCardKeyPress(Sender: TObject; var Key: Char);
    procedure edtAccountCardEnter(Sender: TObject);

  private
    MyPayType,
    MyIDPreSale,
    MyIDCliente,
    IDInvoice        : Integer;

    sRefound,
    sTotalRef,
    sReceive,
    sTotalRec,
    sSetDateTo,
    sPaymentPlaces,
    sCadastrar,
    sBonusInfo,
    sBonusCodeValue  : String;

    MyTotInvoice,
    TotParcela,
    MyLayaway,
    MyTotCash,
    MyPayment        : Currency;

    MyquPreSaleInfo  : TADOQuery;
    MyquPreSaleItem  : TADOStoredProc;

    MyPaymentTypeID,
    MyOtherComID,
    MyIDTouristGroup : Integer;
    MyDepositDate,

    MyPreSaleDate    : TDateTime;
    MyIsLayaway      : Boolean;
    IsToPrintLayaway : Boolean;
    IsLayawayToClose : Boolean;
    MyIDCashRegMov   : Integer;
    OldTag           : Integer;
    MyquPreSaleValue : TADOStoredProc;
    nParcela         : Integer;
    IsOnRecalc       : Boolean;
    fHasDeposit      : Boolean;
    fFormOfPayment   : Integer;
    FPaymentChange   : Double;
    FBonnusBuck      : Currency;
    FIDBonnus        : Integer;
    fConfirmEst      : Boolean;
    fPrintBoleto     : Boolean;

    fCustSAMax       : Currency;
    fCustDeliquent   : Boolean;

    FErrorMsg : String;

    FrmPayPartial   : TFrmPayPartial;

    FrmCreditPay    : TFrmCreditPay;

    procedure PushError(ErrorType: Integer; sError: String);

    function ValidSinglePaymentType : Boolean;
    function ValidateMultiple(IsSaving : Boolean) : Boolean;
    function ValidadeLocalPayment:Boolean;
    function ValidateCustomer: Boolean;
    function ValidadeStoreAccount(APayment : Currency):Boolean;

    function AddPayment:Boolean;
    function DoPay:Boolean;
    function PrintDocument:Boolean;

    procedure RefreshPaySugg;
    procedure OpenPaySugg;
    procedure ClosePaySugg;

    procedure StartSingle;
    procedure StartMultiple;
    procedure PaintPanel(PanelTag : Integer; Color : Integer);
    procedure AtuDepositState(PaymentTypeID : Integer);
    procedure CreateParams( var Params: TCreateParams ); override;

    function GetPayment:Double;
    procedure CancelPreDatar;
    function DeletePayment: Boolean;
    function ShowCloseLayAway(TotLayAway: Currency): Boolean;
    procedure SetComboPaymentPlaces(sComboPaymentPlaces: String; bVisible: Boolean);
    function ValidateReceive: Boolean;
    function PagamentoJaSelecionado(Tipo: Integer; IDMeioPag: String;
      Parcela: Integer; RaiseMessage: Boolean): Boolean;
    procedure cmbPayTypeSelectItem(Sender: TObject);
    procedure cbPayPlaceChange(Sender: TObject);
    function ShowCredit(var Amount: Double; Const Verify: Boolean) : Boolean;
    function GetAccountCredit(Account : String; var Amount : Currency; var ExpDate : TDateTime):Boolean;
    procedure ClearCredit;
    function TipoPagamentoJaSelecionado(Tipo, Parcela: Integer;
      RaiseMessage: Boolean): Boolean;
    procedure RefreshCustomerCredit;
    procedure RefreshAccountCredit;
    procedure RefreshCustomerInfo;
    //PCCharge
    function DoPCCharge(var AAuth, ATroud, ALastDigits: String; Processor, MercantNum:String; AAmount: Currency; iPayType:Integer): Boolean;
    function HasCreditCardProcessor(IDMeioPag: Integer; PayType:Integer):Boolean;
    function CallProcessor(IDMeioPag: Integer; PayType: Integer; var AAuth, ATroud, ALastDigits: String; AAmount: Currency):Boolean;
    procedure SucessFullSwipe(Sender: TObject; const ACardNumber,
      ACardMember, ACardExpireDate: WideString);

    //Mercury CC
    function DoMercury(var AAuth, ATroud, ALastDigits: String; AAmount: Currency; iPayType : Integer): Boolean;
    function MercuryResult(AmercuryWidget : TCCWidget): Boolean;

    procedure DisablePriorPayments(ALastToDisable: Integer);
    function PriorPaymentsSelected(ALastPayment: Integer): Boolean;
    procedure NeedTroutD(Sender: TObject; var ATrouD, ARefNo, AAuthCode: WideString;
      var ACanceled: Boolean);
    procedure PreparePCC(APCCT: TPCCTransaction; AProcessor,
      AMercantNum: String);
    function PCCResult(APCCT: TPCCTransaction): Boolean;
    function DoPCVoid(var AAuth, ATroud, ALastDigits: String; Processor, MercantNum: String): Boolean;
    function PaymentIsLast(ALastPayment: Integer): Boolean;
    function PriorPaymetValues(ALastPayment: Integer): Currency;

    function GetBonusPayment:Integer;

    procedure PrintBankBillet;
    procedure RecalcInvoiceTotal;
    function ProcessInvoiceBonus : Boolean;
    function getPaymentCard(arg_processor, arg_paymentType: Integer): TCCWidget;

  public
    function processCardCreditIsPresent(arg_amount: Double; arg_widget:TCCWidget): boolean;
    function processCardDebitIsPresent(arg_amount: Double; arg_widget: TCCWidget): boolean;
    function processCardIsNotPresent(arg_amount: Double; arg_widget: TCCWidget): boolean;

    function Start(quPreSaleInfo:  TADOQuery;
                   quPreSaleValue: TADOStoredProc;
                   quPreSaleItem:  TADOStoredProc;
                   IDCashRegMov:   integer;
                   IsLayaway:      Boolean;
                   IsToPrint:      Boolean;
                   FormOfPayment:  Integer;
                   BonnusBuck:     Currency;
                   var Change: Double): Boolean;
  end;

implementation

uses uDM, xBase, uPassword, uPrintReceipt, uMsgBox, uMsgConstant, uHandleError,
     uNumericFunctions, uDateTimeFunctions, uCharFunctions, uDMGlobal, uSystemConst,
     Math, uFrmPCCSwipeCard, ufrmPCCharge, ufrmPCVoid, ConvUtils, uBonusBucks,
     uCreditCardFunction, uFrmPrintBoleto;

{$R *.DFM}

procedure TPreSaleReceive.PushError(ErrorType: Integer; sError: String);
begin

   DM.SetError(ErrorType, Self.Name, sError);

end;


function TPreSaleReceive.GetBonusPayment:Integer;
var
  myQuery : TADODataSet;
begin

  myQuery := TADODataSet.Create(Self);
  try
    myQuery.Connection  := DM.ADODBConnect;
    myQuery.CommandText := 'Select IDMeioPag From MeioPag (NOLOCK) Where Tipo = 8 AND Desativado = 0 AND Hidden = 0';
    myQuery.Open;
    if myQuery.RecordCount > 0 then
      Result := myQuery.FieldByName('IDMeioPag').AsInteger
    else
      Result := -1;
  finally
    FreeAndNil(myQuery);
  end;
end;

function TPreSaleReceive.GetPayment:Double;
begin

   if MyIsLayaway then
      Result := MyPayment
   else
      Result := MyTotInvoice;

end;

function TPreSaleReceive.DoPay:Boolean;
var
  cCash: Currency;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.DoPay');

  Result := True;
  try
     if pnlShowCash.Visible then
       cCash := MyStrToMoney(EditReceived.Text);

      Result := DM.fPOS.PreSalePay(MyIDPreSale,
                                   MyIDTouristGroup,
                                   MyOtherComID,
                                   MyIDCashRegMov,
                                   DM.fStore.ID,
                                   Now,
                                   EditReceiveDate.Date,
                                   cCash,
                                   DM.FBonusSync.BonusValue,
                                   DM.FBonusSync.BonusCode,
                                   IDInvoice);

      if not Result then
        raise Exception.Create('error receiving');
  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'TPreSaleReceive');
      Result := False;
    end;
  end;
end;

function TPreSaleReceive.PrintDocument:Boolean;
var
 iPrinType : Integer;
begin

      try

       if MyIsLayaway then
          iPrinType := RECEIPT_TYPE_LAYAWAY_RECEIVE
       else
          iPrinType := RECEIPT_TYPE_HOLD;

       if (DM.fPrintReceipt.PrintReceipt) then
          with TPrintReceipt.Create(Self) do
               Start(MyIDPreSale, iPrinType, MyStrToCurrency(EditChange.Text));

       Result := True;
      Except
        on E: Exception do
           begin
           PushError(CRITICAL_ERROR, 'PreSaleReceive.PrintDocument.Exception' + #13#10 + E.Message);
           Result := False;
           end;
      end;

end;

function TPreSaleReceive.AddPayment:Boolean;

  function GetAuthorization(sAuthorization: String): String;
  begin
    if sAuthorization = '' Then
      Result := Trim(EditAuthorization.Text)
    else
      Result := sAuthorization;
  end;

var
  Authorization : String;

  sValue : String;
  ExprireDate : TDateTime;
  i : Integer;
  fCustomerDoc : String;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.AddPayment');

  Result := True;
  fCustomerDoc := '';

  try
    btOK.Enabled := False;
    btCancel.Enabled := False;

    if MyStrToInt(cmbPaymentType.LookUpValue) = 1 then
      ExprireDate := Int(EditReceiveDate.Date)
    else
      ExprireDate := Int(EditDepositDate.Date);

    if pnlShowAuthorization.Visible then
      Authorization := EditAuthorization.Text
    else
      Authorization := '';

    // Grava nova parcela
    if pgReceive.ActivePage = tbSingle then
    begin
      MyStrToMoney(EditReceived.Text);
      if (DM.fPos.GetPayType(cmbPaymentType.LookUpValue) = PAYMENT_TYPE_CREDIT) and
         (GetPayment >= 0) then
        FrmCreditPay.DiscountCredit(GetPayment);

      //Debito no gitf
      if MyPayType = PAYMENT_TYPE_GIFTCARD then
        fCustomerDoc := edtAccountCard.Text;

      //Adicionar pagamento pre-datados caso tenha
      if fHasDeposit then
      begin
        for i := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
        begin
          if TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDCashRegMovClosed = -1 then
          begin
            Result := DM.fPOS.AddPayment(MyIDPreSale,
                               DM.fStore.ID,
                               DM.fUser.ID,
                               MyIDCliente,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDPaymentType,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDCashRegMov,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).PreSaleDate,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).ExpireDate,
                               IntToStr(i+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count),
                               GetAuthorization(TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Authorization),
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Valor,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).NumeroDoc,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).DocCliente,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).NomeCliente,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Telefone,
                               MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Banco),
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).OBS,
                               TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).PaymentPlace,
                               True); //Sempre que o pagamento foi criado pelo formulário de pre datado
                                      // Ele será pre datado

              //PollDisplay
              DM.PollDisplayAddPayment(TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDPaymentType,
                                       cmbPaymentType.Text,
                                       TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Valor);

            end;
        end;
      end
      else
        if GetPayment <> 0 Then
        begin
          Result := DM.fPOS.AddPayment(MyIDPreSale,
                             DM.fStore.ID,
                             DM.fUser.ID,
                             MyIDCliente,
                             MyStrToInt(cmbPaymentType.LookUpValue),
                             MyIDCashRegMov,
                             EditReceiveDate.Date,
                             ExprireDate,
                             '1/1',
                             Authorization,
                             GetPayment,
                             '', fCustomerDoc, '',  '', 0, '',
                             cbPaymentPlace.ItemIndex,
                             False);

        //PollDisplay
        DM.PollDisplayAddPayment(MyStrToInt(cmbPaymentType.LookUpValue),
                                 cmbPaymentType.Text,
                                 GetPayment);


        end;
      end
      else
      begin
        // Usa o validate para incluir
        Result := ValidateMultiple(True);
      end;

    if not Result then
      raise Exception.Create('error paying');

  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'TPreSaleReceive');
      Result := False;
    end;
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TPreSaleReceive.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  Params.Style := WS_THICKFRAME or WS_POPUP;
end;

function TPreSaleReceive.Start( quPreSaleInfo:  TADOQuery;
                                quPreSaleValue: TADOStoredProc;
                                quPreSaleItem:  TADOStoredProc;
                                IDCashRegMov:   integer;
                                IsLayaway:      Boolean;
                                IsToPrint:      Boolean;
                                FormOfPayment:  Integer;
                                BonnusBuck:     Currency;
                                var Change: Double): Boolean;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.Start');

  try
    MyIDCashRegMov   := IDCashRegMov;
    IsToPrintLayaway := IsToPrint;

    MyIDPreSale      := quPreSaleInfo.FieldByName('IDPreSale').AsInteger;
    MyIDCliente      := quPreSaleInfo.FieldByName('IDCustomer').AsInteger;

    MyTotInvoice     := MyRound(quPreSaleValue.FieldByName('TotalInvoice').AsFloat, 2);

    MyPaymentTypeID  := quPreSaleInfo.FieldByName('IDMeioPag').AsInteger;
    MyDepositDate    := quPreSaleInfo.FieldByName('DepositDate').AsDateTime;
    MyPreSaleDate    := quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime;

    MyOtherComID     := quPreSaleInfo.FieldByName('OtherComissionID').AsInteger;
    MyIDTouristGroup := quPreSaleInfo.FieldByName('IDTouristGroup').AsInteger;

    MyquPreSaleInfo  := quPreSaleInfo;
    MyquPreSaleValue := quPreSaleValue;
    MyquPreSaleItem  := quPreSaleItem;
    MyIsLayaway      := IsLayaway;
    EditReceiveDate.Date := Now;

    cbxCloseLayaway.Checked := False;
    cbxCloseLayaway.Visible := False;

    fHasDeposit := False;

    fFormOfPayment := FormOfPayment;

    //Refresh nos totais
    RecalcInvoiceTotal;

    // Exibe Crédito acumulado do Cliente
    RefreshCustomerCredit;

    //Atualizo informacoes do cliente
    RefreshCustomerInfo;

    // Numero de Parcelas
    nParcela  := 1;

    Left   := 0;
    Top    := 102;
    Height := Screen.Height - Top;

    FBonnusBuck := BonnusBuck;
    FIDBonnus   := -1;

    Result := (ShowModal = mrOK );
    Change := FPaymentChange;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TPreSaleReceive.btOKClick(Sender: TObject);
var
  bCanExec : Boolean;
  IDError : Integer;
  ErrorMsg : String;
  bCloseSale : boolean;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.btOKClick');

  try
    bCanExec := True;
    //Faz todas as validaçoes aqui e depois chama a rotina correta
    if ValidateReceive then
    begin

      //Close Sale
      bCloseSale := not (MyIsLayaway) or ((MyRound(MyTotInvoice-(MyPayment + MyLayaway),2)=0) and (cbxCloseLayaway.Checked));

      if bCloseSale then
      begin
        bCanExec := ProcessInvoiceBonus;
        if not bCanExec then
          Exit;
      end;

      try
        DM.ADODBConnect.BeginTrans;

        if not (MyIsLayaway) or (MyIsLayaway and (MyPayment <> 0)) then
        begin
          if MyIsLayaway Then
            bCanexec := DeletePayment;
          if bCanExec Then
            bCanExec := AddPayment;
        end;
        //Close Payment
        if bCanExec and bCloseSale then
            bCanExec := DoPay;
      finally
        if bCanExec then
        begin
          DM.ADODBConnect.CommitTrans;
          btCancel.Enabled := True;
          PrintBankBillet;
          btOK.Enabled := True;
          ModalResult := mrOK;
        end
        else
        begin
          DM.ADODBConnect.RollbackTrans;
          DM.FTraceControl.SaveTrace(DM.fUser.ID);
          btCancel.Enabled := True;
          btOK.Enabled := True;
          if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
            DM.BonusVoid(DM.FBonusSync.BonusCode, IDError, ErrorMsg);
          MsgBox(MSG_INF_NOT_RECEIVE_HOLD, vbInformation + vbOkOnly);
          ModalResult := mrNone;
        end;
      end;
    end;
    except
      on E: Exception do
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
    end;

  DM.FTraceControl.TraceOut;
  
end;

procedure TPreSaleReceive.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  CancelPreDatar;
end;

procedure TPreSaleReceive.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsNormal;

  // Seta Panel so do Cash
  // pnlShowCash.Visible := False;
  pnlShowCash.Visible := not IsLayawayToClose;

  // Carrega valores iniciais do pagamento
  EditTotalInvoice.Text  := FloatToStrF(MyTotInvoice, ffCurrency, 20, 2);

  lblMinus.Visible   := MyTotInvoice > 0;
  EditChange.Visible := lblMinus.Visible;
  lblEqual.Visible   := lblMinus.Visible;
  lblChange.Visible  := lblMinus.Visible;
  spLine.Visible     := lblMinus.Visible;
  fPrintBoleto       := False;

  if MyTotInvoice < 0 then
  begin
    btOk.Caption := sRefound;
    lblCashTotal.Caption := sTotalRef;
  end
  else
  begin
    lblCashTotal.Caption := sTotalRec;
    btOk.Caption := sReceive;
  end;

  if FBonnusBuck <> 0 then
  begin
    FIDBonnus := GetBonusPayment;
    if FIDBonnus <> -1 then
    begin
      StartMultiple;
      cmbPayType1.LookUpValue := IntToStr(FIDBonnus);
      cmbPayType1SelectItem(cmbPayType1);
      EditValue1.Text := FormatFloat('#,##0.00', FBonnusBuck);
      Exit;
    end
    else
      MsgBox(MSG_CRT_NO_BONUS_PAYMENT_SET, vbSuperCritical + vbOkOnly);
  end;

  StartSingle;


end;

procedure TPreSaleReceive.spPayCashClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_CASH);
  cmbPaymentTypeSelectItem(nil);
  if MyIsLayaway then
  begin
    if edPayment.CanFocus then
      edPayment.SetFocus;
  end
  else
  begin
    if not pnlShowCash.Visible then
      pnlShowCash.Visible := True;
    if EditReceived.CanFocus then
      EditReceived.SetFocus;
  end;
end;

procedure TPreSaleReceive.spPayVisaClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_VISA);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TPreSaleReceive.cmbPaymentTypeSelectItem(Sender: TObject);
var
  FrmCreditPay: TFrmCreditPay;
  CreditUse: Double;
  sAuto, sRout, sLastDigits, FCoupon: String;
  bError : Boolean;
  cBonusValue : Currency;
  iIDError : Integer;
  sErrorStr : String;
  BonusBucks: TBonusBucks;
begin
  pnlDepositDate.Visible       := False;
  pnlShowCash.Visible          := False;
  pnlDelayPayments.Visible     := False;
  pnlShowAuthorization.Visible := False;

  if cmbPaymentType.LookUpValue = '' then
    Exit;

  ClearCredit; // Limpa os créditos selecionados para utilização
  MyTotCash := 0;

  //Process Bonus

  case MyStrToInt(cmbPaymentType.LookUpValue) of
    PAY_TYPE_CASH:
    begin
      spPayCash.Down := True;
      MyTotCash := MyTotInvoice;
      if MyIsLayaway then
        EditTotalCash.Text := FloatToStrF(MyPayment, ffCurrency, 20, 2)
      else
        EditTotalCash.Text := FloatToStrF(MyTotCash, ffCurrency, 20, 2);
    end;
    PAY_TYPE_VISA:
      spPayVisa.Down := True;
    PAY_TYPE_AMERICAN:
      spPayAmerican.Down := True;
    PAY_TYPE_MASTER:
      spPayMaster.Down   := True;
    PAY_TYPE_CHECK:
      spPayCheck.Down    := True;
    else
    begin
      // nao seleciona
      spPayCash.Down     := False;
      spPayVisa.Down     := False;
      spPayAmerican.Down := False;
      spPayMaster.Down   := False;
      spPayCheck.Down    := False;
    end;
  end;

  // Atualiza estado do Deposit Date
  AtuDepositState(MyStrToInt(cmbPaymentType.LookUpValue));

  //Verifica o Tipo de Pagamento
  MyPayType := DM.fPOS.GetPayType(cmbPaymentType.LookUpValue);

  if MyPayType = PAYMENT_TYPE_BONUSBUCK then
  begin
    FCoupon := UpperCase(InputBox(sBonusInfo, sBonusCodeValue, ''));
    if (FCoupon <> '') then
    begin
      if (Length(FCoupon) <> 34) then
      begin
        MsgBox(MSG_CRT_BONUS_IS_NOT_VALID, vbCritical + vbOKOnly);
        cmbPaymentType.LookUpValue := '';
        Exit;
      end;

      if DM.BonusUse(FCoupon, cBonusValue, iIDError, sErrorStr) then
        try
          if MyIsLayaway then
            MyPayment := cBonusValue
          else
            MyTotInvoice := cBonusValue;
          AddPayment;
          RecalcInvoiceTotal;
          //Dou baixa do bonus no sistema
          BonusBucks := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
          BonusBucks.SetUsed(MyIDPreSale, FCoupon);
          cmbPaymentType.LookUpValue := '';
        finally
          btOK.Enabled := True;
          btCancel.Enabled := True;
          FreeAndNil(BonusBucks);
        end
      else
        MsgBox(MSG_CRT_ERROR_USING_BONUS + sErrorStr, vbOKOnly + vbSuperCritical);
    end;
    Exit;
  end;

  if (MyStrToInt(cmbPaymentType.LookUpValue) > 0) and not ValidSinglePaymentType then
     Exit;
  
  if (MyPayType = PAYMENT_TYPE_CREDIT) and (GetPayment > 0) then
  begin
    CreditUse := GetPayment;
    if not ShowCredit(CreditUse, True) then
    begin
      if CreditUse < GetPayment then
      begin
        pgReceive.ActivePage := tbMultiple;
        pgReceiveChange(pgReceive);
        cmbPayType1.LookUpValue := cmbPaymentType.LookUpValue;
        EditValue1.Text := MyFloatToStr(CreditUse);
      end
      else
        cmbPaymentType.LookUpValue := '';
      Exit;
    end;
  end else if (MyPayType = PAYMENT_TYPE_CREDIT) and (GetPayment < 0) then
  begin
    if MyIDCliente = 1 then
    begin
     MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOkOnly);
     cmbPaymentType.LookUpValue := '';
    end;
  end;

  if (MyPayType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_OTHER, PAYMENT_TYPE_STOREACCOUNT]) then
  begin
    pnlDelayPayments.Visible     := DM.fSystem.SrvParam[PARAM_DISPLAY_PRE_DATADO];
    pnlShowAuthorization.Visible := (MyPayType in [PAYMENT_TYPE_CARD]);
    EditAuthorization.Text       := '';
    if EditAuthorization.CanFocus then
      EditAuthorization.SetFocus;
    if pnlDelayPayments.Visible then
      btnPartialPayment.Caption := sCadastrar + cmbPaymentType.Text;
  end
  else
  begin
    pnlShowAuthorization.Visible := False;
    pnlDelayPayments.Visible     := False;
  end;

  // Mostra o panel de Cash se pagamento for do tipo cash
  pnlShowCash.Visible := (MyTotCash > 0);

  if pnlShowCash.Visible then
    if EditReceived.CanFocus then
      EditReceived.SetFocus;

  //Cancela Pre-Datado se trocar de tipo de pago
  CancelPreDatar;

  EditAuthorization.Text := '';

  //Test Processor
  if HasCreditCardProcessor(StrToInt(cmbPaymentType.LookUpValue), MyPayType) then
    if CallProcessor(StrToInt(cmbPaymentType.LookUpValue), MyPayType, sAuto, sRout, sLastDigits, GetPayment) then
    begin
      EditAuthorization.Text    := 'A:'+ sAuto + ' R:' + sRout + ' L:' + sLastDigits;
      EditAuthorization.Enabled := False;
      btCancel.Enabled          := False;
      tbMultiple.TabVisible     := False;
      cmbPaymentType.Enabled    := False;
      btnPartialPayment.Visible := False;
      edPayment.Enabled         := False;
      pnlPayButton.Visible      := False;
    end
    else
      cmbPaymentType.LookUpValue := '';

  if MyPayType = PAYMENT_TYPE_GIFTCARD then
  begin
    pnlShowAccount.Visible := True;
    edtAccountCard.Clear;
    edtAccountCard.SetFocus;
  end
  else
  begin
    pnlShowAccount.Visible       := False;
    lbAccountCredit.Visible      := False;
    lbAccountCreditValue.Visible := False;
  end;

end;

procedure TPreSaleReceive.spDep30Click(Sender: TObject);
begin
  EditDepositDate.Text := DateToStr(Int(EditReceiveDate.Date) +
                          MyStrToInt(RightStr(TSpeedButton(Sender).Caption, 1)));
end;

procedure TPreSaleReceive.spPayMasterClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_MASTER);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TPreSaleReceive.spPayAmericanClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_AMERICAN);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TPreSaleReceive.AtuDepositState(PaymentTypeID : Integer);
begin
  // Desabilita tudo
  spDep30.Down := False;
  spDep60.Down := False;
  spDep90.Down := False;

  {
  spDep30.Visible    := False;
  spDep60.Visible    := False;
  spDep90.Visible    := False;
  lblPreDate.Visible := False;
  }

  spDep30.Visible    := cbPaymentPlace.ItemIndex in [PAYMENT_PLACE_OUTROS];
  spDep60.Visible    := cbPaymentPlace.ItemIndex in [PAYMENT_PLACE_OUTROS];
  spDep90.Visible    := cbPaymentPlace.ItemIndex in [PAYMENT_PLACE_OUTROS];
  lblPreDate.Visible := cbPaymentPlace.ItemIndex in [PAYMENT_PLACE_OUTROS];

  with spquPayTypeMin do
  begin
    if Active then
      Close;
    Parameters.ParambyName('@IDMeioPag').Value := PaymentTypeID;
    Open;
    First;
    while not Eof do
    begin
      if (spquPayTypeMinDifDay.AsInteger > 0) and
         (MyTotInvoice >= spquPayTypeMinTotalSale.AsFloat) then
      begin
        if not spDep30.Visible then
        begin
          spDep30.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
          spDep30.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
          spDep30.Visible := True;
        end
        else if not spDep60.Visible then
        begin
          spDep60.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
          spDep60.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
          spDep60.Visible := True;
        end
        else if not spDep90.Visible then
        begin
          spDep90.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
          spDep90.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
          spDep90.Visible := True;
        end;
      end;
      Next;
    end;

    Close;

    // testa se mostra o panel de deposit date
    pnlDepositDate.Visible := spDep30.Visible;

    lblPreDate.Visible := (not spDep30.Visible) and (not Password.HasFuncRight(17));

    if lblPreDate.Visible then
    begin
      EditDepositDate.Color    := clSilver;
      EditDepositDate.ReadOnly := True;
    end
    else
    begin
      EditDepositDate.Color    := clWhite;
      EditDepositDate.ReadOnly := False;
    end;
  end;
end;

procedure TPreSaleReceive.PaintPanel(PanelTag : Integer; Color : Integer);
begin
  case PanelTag of
    1: pnlPayTitle.Color := Color;
    2: pnlDateTitle.Color := Color;
  end;
end;

procedure TPreSaleReceive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  ClosePaySugg;
end;

procedure TPreSaleReceive.EditReceivedChange(Sender: TObject);
var
  Code: Integer;
  Value: Real;
begin
  // Muda o change automatico
  if Trim(EditReceived.Text) = '' then
    EditChange.Text := FloatToStrF(0, ffCurrency, 20, 2);

  Value := MyStrToMoney(Trim(EditReceived.Text));
  if pgReceive.ActivePage = tbSingle then
  begin
    EditChange.Text := FloatToStrF(Value-GetPayment, ffCurrency, 20, 2);
    FPaymentChange := Value - GetPayment;
  end
  else
  begin
    EditChange.Text := FloatToStrF(Value-MyTotCash, ffCurrency, 20, 2);
    FPaymentChange := Value-GetPayment;
  end;
end;

procedure TPreSaleReceive.SelecionaParcela(Sender: TObject);
var
  i, j : integer;
  MyPanel : TPanel;
begin
  // Numero de Parcelas
  nParcela := TSpeedButton(Sender).Tag;

  // Seleciona as parcelas que vao aparecer
  with pnlMultiParcela do
  begin
    for i := 0 to (ControlCount - 1) do
    begin
      if not (Controls[i] is TPanel) then
        Continue;

      // Mostra as parcelas dependendo do numero selecionado
      Controls[i].Visible := (Controls[i].Tag <= TSpeedButton(Sender).Tag);
      // Apaga todos os valores dos campos
      MyPanel := TPanel(Controls[i]);
      try
        IsOnRecalc := True;
        for j := 0 to (MyPanel.ControlCount - 1) do
        begin
          if MyPanel.Controls[j] is TSuperComboADO then
          begin
            TSuperComboADO(MyPanel.Controls[j]).LookUpValue := '';
            TSuperComboADO(MyPanel.Controls[j]).OnSelectItem(MyPanel.Controls[j]);
          end
          else if MyPanel.Controls[j] is TEdit then
            TEdit(MyPanel.Controls[j]).Text := ''
          else if MyPanel.Controls[j] is TDateBox then
            TDateBox(MyPanel.Controls[j]).Date := Int(EditReceiveDate.Date)
          else if MyPanel.Controls[j] is TPanel then
            TPanel(MyPanel.Controls[j]).Visible := False;
        end;
      finally
        IsOnRecalc := False;
      end;
    end;
  end;

  RecalcTotals(nil);
  
  if FIDBonnus <> -1 then
  begin
    cmbPayType1.LookUpValue := IntToStr(FIDBonnus);
    cmbPayType1SelectItem(cmbPayType1);
    EditValue1.Text := FormatFloat('#,##0.00', FBonnusBuck);
  end;


end;

function TPreSaleReceive.PriorPaymentsSelected(ALastPayment: Integer): Boolean;
var
  I : Integer;
  cmbPayType: TSuperComboADO;
begin
  Result := True;
  for I := 1 to ALastPayment do
  begin
    cmbPayType := TSuperComboADO(FindComponent('cmbPayType' + IntToStr(I)));
    if cmbPayType.LookUpValue = '' then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TPreSaleReceive.PaymentIsLast(ALastPayment: Integer): Boolean;
var
  cmbPayType: TSuperComboADO;
begin
  if ALastPayment = 5 then
    Result := True
  else
  begin
    cmbPayType := TSuperComboADO(FindComponent('cmbPayType' + IntToStr(ALastPayment + 1)));
    Result := not TWinControl(cmbPayType.Parent).Visible;
  end;
end;

procedure TPreSaleReceive.DisablePriorPayments(ALastToDisable: Integer);
var
  I: Integer;
  cmbPayType: TSuperComboADO;
  lblAuto, lblDep: TLabel;
  EditAuto, EditValue: TEdit;
  cbPayPlace: TComboBox;
  pnlAccount: TPanel;
  EditDep: TDateBox;
begin
  for I := 1 to ALastToDisable do
  begin
    cmbPayType := TSuperComboADO(FindComponent('cmbPayType' + IntToStr(I)));
    lblAuto    := TLabel(FindComponent('lblAuto' + IntToStr(I)));
    EditAuto   := TEdit(FindComponent('EditAuto' + IntToStr(I)));
    pnlAccount := TPanel(FindComponent('pnlAccount' + IntToStr(I)));

    EditDep    := TDateBox(FindComponent('EditDep' + IntToStr(I)));
    lblDep     := TLabel(FindComponent('lblDep' + IntToStr(I)));

    cbPayPlace := TComboBox(FindComponent('cbPayPlace' + IntToStr(I)));

    EditValue  := TEdit(FindComponent('EditValue' + IntToStr(I)));

    EditAuto.Enabled          := False;
    btCancel.Enabled          := False;
    tbSingle.TabVisible       := False;
    cmbPayType.Enabled        := False;
    EditValue.Enabled         := False;
    pnlAccount.Visible        := False;
  end;

  pnlMultiButtons.Visible     := False;
end;

function TPresaleReceive.PriorPaymetValues(ALastPayment: Integer): Currency;
var
  MyEditValue: TEdit;
  I: Integer;
begin
  Result := 0;
  for I := 1 to ALastPayment - 1 do
  begin
    MyEditValue  := TEdit(Self.FindComponent('EditValue' + Trim(IntToStr(I))));
    Result := MyStrToCurrency(MyEditValue.text);
  end;
end;

// Encapsula o SelectItem dos 5 TSuperComboADO de Tipo de Pagamento
// Do tab Multiple
procedure TPreSaleReceive.cmbPayTypeSelectItem(Sender: TObject);
var
  iPayType : Integer;
  cmbPayType: TSuperComboADO;
  lblAuto, lblDep : TLabel;
  pnlAccount : TPanel;
  EditAuto, EditValue, edtGiftCard : TEdit;
  cbPayPlace : TComboBox;
  EditDep: TDateBox;
  CreditUse : Double;
  bProcessor: Boolean;
  sAuto, sRout: String;
  sLastDigits: String;
  fAmount : Currency;
  fExpDate : TDateTime;
begin
  cmbPayType := TSuperComboADO(Sender);
  if cmbPayType.LookUpValue = '' then
    Exit;

  if MyIsLayaway then
    if MyStrToMoney(edPayment.Text) = 0 then
    begin
      MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical);
      cmbPayType.LookUpValue := '';
      Exit;
    end;

  if (not PriorPaymentsSelected(cmbPayType.Tag)) then
  begin
    MsgBox('All prior payment types must be selected in order to complete this operation', vbCritical);
    cmbPayType.LookUpValue := '';
    Exit;
  end;

  lblAuto    := TLabel(FindComponent('lblAuto' + IntToStr(cmbPayType.Tag)));
  EditAuto   := TEdit(FindComponent('EditAuto' + IntToStr(cmbPayType.Tag)));

  EditDep    := TDateBox(FindComponent('EditDep' + IntToStr(cmbPayType.Tag)));
  lblDep     := TLabel(FindComponent('lblDep' + IntToStr(cmbPayType.Tag)));

  cbPayPlace := TComboBox(FindComponent('cbPayPlace' + IntToStr(cmbPayType.Tag)));

  EditValue  := TEdit(FindComponent('EditValue' + IntToStr(cmbPayType.Tag)));

  pnlAccount  := TPanel(FindComponent('pnlAccount' + IntToStr(cmbPayType.Tag)));
  edtGiftCard := TEdit(FindComponent('edtAccount' + IntToStr(cmbPayType.Tag)));

  if not TipoPagamentoJaSelecionado(PAYMENT_TYPE_CREDIT, -1, False) then
    ClearCredit;

  iPayType := DM.fPOS.GetPayType(cmbPayType.LookUpValue);

  if iPayType <> PAYMENT_TYPE_CREDIT then
    if PagamentoJaSelecionado(iPayType, cmbPayType.LookUpValue, cmbPayType.Tag, True) then
    begin
      cmbPayType.LookUpValue := '';
      cmbPayType.Clear;
      Exit;
    end;

  if (iPayType = PAYMENT_TYPE_CREDIT) and (MyStrToMoney(EditValue.Text) >= 0) then
  begin
    CreditUse := MyStrToMoney(EditValue.Text);
    ShowCredit(CreditUse, False);
    if CreditUse < MyStrToMoney(EditValue.Text) then
      EditValue.Text := MyFloatToStr(CreditUse);

    if CreditUse = 0 then
    begin
      cmbPayType.LookUpValue := '';
      cmbPayType.Clear;
      Exit;
    end;
  end else if (iPayType = PAYMENT_TYPE_CREDIT) and (MyStrToMoney(EditValue.Text) < 0) then
  begin
    if MyIDCliente = 1 then
    begin
     MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOkOnly);
     cmbPayType.LookUpValue := '';
     cmbPayType.Clear;
     Exit;
    end;
  end;


  if ((iPayType = PAYMENT_TYPE_GIFTCARD) and (MyStrToMoney(EditValue.Text) >= 0)) and
     (edtGiftCard.Text <> '') then
  begin
    if not GetAccountCredit(edtGiftCard.Text,  fAmount, fExpDate) then
      MsgBox(Format(MSG_CRT_NO_GIFT_ACCOUNT, [edtGiftCard.Text]), vbInformation + vbOkOnly);

    if fAmount = 0 then
      MsgBox(Format(MSG_CRT_GIFT_ACCOUNT_ZERO, [edtGiftCard.Text]), vbInformation + vbOkOnly);

    if fExpDate < Trunc(Now) then
     MsgBox(Format(MSG_CRT_GIFT_EXPIRED,[edtAccountCard.Text]), vbOKOnly + vbCritical);

    if fAmount < MyStrToMoney(EditValue.Text) then
      EditValue.Text := MyFloatToStr(fAmount);
  end;

  lblAuto.Visible    := (iPayType in [PAYMENT_TYPE_CARD]);
  EditAuto.Visible   := lblAuto.Visible;

  pnlAccount.Visible := (iPayType in [PAYMENT_TYPE_GIFTCARD]);

  EditDep.Visible    := (not (iPayType in [PAYMENT_TYPE_CASH, PAYMENT_TYPE_BONUSBUCK])) or (cbPayPlace.ItemIndex in [PAYMENT_PLACE_OUTROS]);
  lblDep.Visible     := EditDep.Visible;
  RecalcTotals(EditValue);

  //Test Processor
  if HasCreditCardProcessor(StrToInt(cmbPayType.LookUpValue), iPayType) then
  begin
    if PaymentIsLast(cmbPayType.Tag) then
    begin
      if ((PriorPaymetValues(cmbPayType.Tag) + MyStrToCurrency(EditValue.Text)) < MyTotInvoice) then
      begin
        MsgBox('The last payment must complete the amount.', vbCritical);
        cmbPayType.LookUpValue := '';
        Exit;
      end;
    end;
    if CallProcessor(StrToInt(cmbPayType.LookUpValue), iPayType, sAuto, sRout, sLastDigits, MyStrToCurrency(EditValue.Text)) then
    begin
      EditAuto.Text    := 'A:'+ sAuto + ' R:' + sRout + ' L:' + sLastDigits;
      DisablePriorPayments(cmbPayType.Tag);

      if MyIsLayaway then
        edPayment.Enabled := False;
    end
    else
      cmbPayType.LookUpValue := '';
  end;
end;

procedure TPreSaleReceive.cmbPayType1SelectItem(Sender: TObject);
var
  iPayType : Integer;
begin
  cmbPayTypeSelectItem(Sender);
  iPayType := DM.fPOS.GetPayType(cmbPayType1.LookUpValue);
  btnPartialPayment2.Visible := (not HasCreditCardProcessor(StrToIntDef(cmbPayType1.LookUpValue, 0), iPayType)) and (DM.fSystem.SrvParam[PARAM_DISPLAY_PRE_DATADO] AND (iPayType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_OTHER, PAYMENT_TYPE_STOREACCOUNT]));

  //Cancela pre-datado caso tenha
  CancelPreDatar;
end;

procedure TPreSaleReceive.cmbPayType2SelectItem(Sender: TObject);
begin
  cmbPayTypeSelectItem(Sender);
end;

procedure TPreSaleReceive.cmbPayType3SelectItem(Sender: TObject);
begin
  cmbPayTypeSelectItem(Sender);
end;

procedure TPreSaleReceive.cmbPayType4SelectItem(Sender: TObject);
begin
  cmbPayTypeSelectItem(Sender);
end;

procedure TPreSaleReceive.cmbPayType5SelectItem(Sender: TObject);
begin
  cmbPayTypeSelectItem(Sender);
end;

procedure TPreSaleReceive.pgReceiveChange(Sender: TObject);
begin
  // Ajusta qual modo vai aparecer
  case pgReceive.ActivePage.TabIndex of
    0: StartSingle;
    1: StartMultiple;
  end;

  //Cancela Pre Datado Caso tenha
  CancelPreDatar;
end;

procedure TPreSaleReceive.StartSingle;
begin
  pgReceive.ActivePage := tbSingle;

  spDep30.Down := False;
  spDep60.Down := False;
  spDep90.Down := False;

  cmbPaymentType.LookUpValue := '';
  cmbPaymentTypeSelectItem(nil);

  EditDepositDate.Date := Int(EditReceiveDate.Date);

  // Testa se vendedor fez algum Deposit Date pre setado
  if ( MyPaymentTypeID > 0 ) then
  begin
    // Seleciona a forma de pagamento escolhida pelo vendedor
    cmbPaymentType.LookUpValue := IntToStr(MyPaymentTypeID);
    cmbPaymentTypeSelectItem(nil);
    EditDepositDate.Date       := MyDepositDate;
    MsgBox(MSG_INF_INVOICE_HAS_SETUP, vbOKOnly + vbInformation);
  end;

  if not IsLayawayToClose then
  begin
    if pnlPaymentPlace.Visible then
    begin
      if cbPaymentPlace.CanFocus then
        cbPaymentPlace.SetFocus;
    end
    else if cmbPaymentType.CanFocus then
      cmbPaymentType.SetFocus;
  end;

  RefreshPaySugg;

end;

procedure TPreSaleReceive.StartMultiple;
begin
  pgReceive.ActivePage := tbMultiple;
  IsOnRecalc           := False;

  pnlShowCash.Visible  := False;

  btMulti2.Down := True;
  SelecionaParcela(btMulti2);
end;

procedure TPreSaleReceive.RecalcTotals(Sender : TObject);
var
  i            : integer;
  SubTotal     : Double;
  MyEditValue  : TEdit;
  MycmbPayType : TSuperComboADO;
  fAmount      : Currency;
begin
  // Recalcula os totais para que sempre sobre a divisao do numero de parcelas
  if IsOnRecalc then Exit;

  if MyIsLayaway then
    fAmount := MyStrToMoney(edPayment.Text)
  else
    fAmount := MyTotInvoice;
  MyTotCash := 0;
  SubTotal  := 0;

  // Desabilita o Loop do change to text do controle
  IsOnRecalc  := True;

  with pnlMultiParcela do
  begin
    for i := 0 to (ControlCount - 1) do
    begin
      if not (Controls[i] is TPanel) then
        Continue;
      if not Controls[i].Visible then
        Continue;

        MyEditValue  := TEdit(Self.FindComponent('EditValue' + Trim(IntToStr(Controls[i].Tag))));
        MycmbPayType := TSuperComboADO(Self.FindComponent('cmbPayType' + Trim(IntToStr(Controls[i].Tag))));

        if Sender = nil then
          begin
           // Entra quando for todas as parcelas
           MyEditValue.Text := MyFloatToStr(MyRound(fAmount/nParcela, 2));
          end
        else
          begin
           // Entra quando estiver editando um field
           if Controls[i].Tag > TSpeedButton(Sender).Tag then
             begin
               // Calcula dividido pelo resto dos outros campos
               MyEditValue.Text := MyFloatToStr(MyRound((fAmount-SubTotal)/(nParcela-TSpeedButton(Sender).Tag), 2));
               if MyStrToInt(MycmbPayType.LookUpValue) = 1 then
                  MyTotCash := MyTotCash + MyStrToMoney(MyEditValue.Text);
             end
           else
             begin
               SubTotal := SubTotal + MyStrToMoney(MyEditValue.Text);
               if MyStrToInt(MycmbPayType.LookUpValue) = 1 then
                  MyTotCash := MyTotCash + MyStrToMoney(MyEditValue.Text);
             end;
          end;
      end;
   end;

   if (MyTotCash > 0) then
     begin
     pnlShowCash.Visible := True;
     EditTotalCash.Text  := FloatToStrF(MyTotCash, ffCurrency, 20, 2);
     EditReceived.Text   := FormatFloat('###0.00', MyTotCash);
     EditChange.Text     := FloatToStrF(0, ffCurrency, 20, 2);
     end
   else
     pnlShowCash.Visible := False;

   IsOnRecalc  := False;
end;

procedure TPreSaleReceive.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssAlt] then
    begin
      if UpperCase(Chr(Key)) = 'S' then
         StartSingle
      else if UpperCase(Chr(Key)) = 'M' then
         StartMultiple;
    end;
end;

function TPreSaleReceive.ValidateMultiple(IsSaving : Boolean) : Boolean;
  function GetAuthorization(sAuthorization: String): String;
  begin
    if sAuthorization = '' Then
      Result := Trim(EditAuto1.Text)
    else
      Result := sAuthorization;
  end;
var
  MyEditValue   : TEdit;
  MycmbPayType  : TSuperComboADO;
  MyEditAuto    : TEdit;
  MyEditDep     : TDateBox;
  MyEditGift    : TEdit;
  i, j          : integer;
  Authorization : String;
  ExprireDate   : TDateTime;
  MycbPayPlace  : TComboBox;
  sCustomerDoc  : String;
  fAmount       : Currency;
  fExpDate      : TDateTime;
begin
  // Valida multiplas parcelas
  Result := False;

  Authorization := '';
  sCustomerDoc  := '';

  with pnlMultiParcela do
   begin
    for i := 0 to (ControlCount - 1) do
      begin
        if not (Controls[i] is TPanel) then Continue;
        if not Controls[i].Visible then Continue;

        MyEditValue  := TEdit(Self.FindComponent('EditValue' + Trim(IntToStr(Controls[i].Tag))));
        MycmbPayType := TSuperComboADO(Self.FindComponent('cmbPayType' + Trim(IntToStr(Controls[i].Tag))));
        MyEditAuto   := TEdit(Self.FindComponent('EditAuto' + Trim(IntToStr(Controls[i].Tag))));
        MyEditDep    := TDateBox(Self.FindComponent('EditDep' + Trim(IntToStr(Controls[i].Tag))));
        MycbPayPlace := TComboBox(Self.FindComponent('cbPayPlace' + Trim(IntToStr(Controls[i].Tag))));
        MyEditGift   := TEdit(Self.FindComponent('edtAccount' + Trim(IntToStr(Controls[i].Tag))));
        sCustomerDoc := MyEditGift.Text;

        if IsSaving then
           begin
           if MyStrToInt(MycmbPayType.LookUpValue) = 1 then
           //if MyStrToInt(cmbPaymentType.LookUpValue) = 1 then  ????? Isso num  tá erado ?
             ExprireDate := EditReceiveDate.Date
           else
             ExprireDate := MyEditDep.Date;

           if MyEditAuto.Visible then
             Authorization := MyEditAuto.Text
           else
             Authorization := '';

           if (DM.fPos.GetPayType(MycmbPayType.LookUpValue) = PAYMENT_TYPE_CREDIT) and
              (MyStrToMoney(MyEditValue.Text) > 0) then
               FrmCreditPay.DiscountCredit(MyStrToMoney(MyEditValue.Text));

           If fHasDeposit then
               begin
               for j := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
                   begin
                   DM.fPOS.AddPayment(MyIDPreSale,
                                      DM.fStore.ID,
                                      DM.fUser.ID,
                                      MyIDCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).IDPaymentType,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).IDCashRegMov,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).PreSaleDate,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).ExpireDate,
                                      IntToStr(i+1)+'/'+IntToStr(ControlCount-3) + ' - ' +IntToStr(j+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count),
                                      GetAuthorization(TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Authorization),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Valor,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).NumeroDoc,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).DocCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).NomeCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Telefone,
                                      MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Banco),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).OBS,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).PaymentPlace,
                                      True);  // Sempre que o pagamento for cadastrado no formulário pre-datado
                                              // Ele será pre-datatado

                    //PollDisplay
                    DM.PollDisplayAddPayment(TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).IDPaymentType,
                                             MycmbPayType.Text,
                                             TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Valor);

                   end;
                //Depois que efetuar o Pre-Datado tenho que limpar os valores
                CancelPreDatar;
                end
           else
                begin
                DM.fPOS.AddPayment(MyIDPreSale,
                                   DM.fStore.ID,
                                   DM.fUser.ID,
                                   MyIDCliente,
                                   MyStrToInt(MycmbPayType.LookUpValue),
                                   MyIDCashRegMov,
                                   EditReceiveDate.Date,
                                   ExprireDate,
                                   IntToStr(i+1)+'/'+IntToStr(ControlCount-3),
                                   Authorization,
                                   MyStrToMoney(MyEditValue.Text),
                                   '', sCustomerDoc,  '',  '', 0, '',
                                   MycbPayPlace.ItemIndex,
                                   False);

                //PollDisplay
                DM.PollDisplayAddPayment(MyStrToInt(MycmbPayType.LookUpValue),
                                         MycmbPayType.Text,
                                         MyStrToMoney(MyEditValue.Text));

                end;

           Continue;  // Passa para o proximo campo
        end;

      //Testa PaymentPlace
      if MycbPayPlace.Visible then
         if MycbPayPlace.ItemIndex = PAYMENT_PLACE_EMPTY then
            begin
            MsgBox(MSG_INF_CHOOSE_PAYPLACE, vbInformation + vbOkOnly);
            MycbPayPlace.SetFocus;
            Exit;
            end;

        // Testa se authorization e valida
        if MycmbPayType.LookUpValue = '' then
          begin
            MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbInformation);
            if MyEditAuto.CanFocus then
               MyEditAuto.SetFocus;
            Exit;
          end;

        // Testa se valor e branco
        if MyStrToMoney(MyEditValue.Text) = 0 then
          begin
            MsgBox(MSG_CRT_NO_AMOUNT, vbOKOnly + vbInformation);
            if MyEditValue.CanFocus then
               MyEditValue.SetFocus;
            Exit;
          end;

        // Testa se authorization e valida
        if MyEditAuto.Visible and (MyEditAuto.Text = '') then
          begin
            MsgBox(MSG_CRT_NO_AUTHORIZANUMBER, vbOKOnly + vbInformation);
            if MyEditAuto.CanFocus then
               MyEditAuto.SetFocus;
            Exit;
          end;

        // Teste de Invoice com Special Price com Payment Type diferente de Cash
        if (MyquPreSaleInfo.FieldByName('MediaID').AsInteger = MEDIA_TYPE_GUIDE) and
            MyquPreSaleValue.FieldByName('TaxIsent').AsBoolean and
           (MyStrToInt(MycmbPayType.LookUpValue) <> PAY_TYPE_CASH) then
          begin
            if Password.HasFuncRight(18) then
              begin
               if MsgBox(MSG_QST_INVOICE_ONLY_CASH, vbYesNo + vbQuestion) = vbNo then
                  Exit;
              end
            else
              begin
                  if MycmbPayType.CanFocus then
                     MycmbPayType.SetFocus;
                  MsgBox(MSG_INF_INVOICE_REC_ONLY_CASH, vbOKOnly + vbInformation);
                  Exit;
              end;
          end;

          if (DM.fPos.GetPayType(MycmbPayType.LookUpValue) = PAYMENT_TYPE_GIFTCARD) then
          begin
             if not GetAccountCredit(MyEditGift.Text,  fAmount, fExpDate) then
             begin
               MsgBox(Format(MSG_CRT_NO_GIFT_ACCOUNT, [MyEditGift.Text]), vbInformation + vbOkOnly);
               Exit;
             end;


             if fAmount <= 0 then
             begin
               MsgBox(Format(MSG_CRT_GIFT_ACCOUNT_ZERO, [MyEditGift.Text]), vbInformation + vbOkOnly);
               MyEditValue.SetFocus;
               Exit;
             end;

             if fExpDate < Trunc(Now) then
             begin
              MsgBox(Format(MSG_CRT_GIFT_EXPIRED,[edtAccountCard.Text]), vbOKOnly + vbCritical);
              Exit;
             end;

             if fAmount < MyStrToMoney(MyEditValue.Text) then
             begin
              MsgBox(Format(MSG_CRT_NOT_GIFT_ACCOUN_BALANCE,[MyEditGift.Text, fAmount]), vbOKOnly + vbCritical);
              MyEditValue.SetFocus;
              Exit;
             end;
          end;


        // teste de data valida
        if MyEditDep.visible and not TestDate(MyEditDep.Text) then
          begin
           if MyEditDep.Visible then
              MyEditDep.SetFocus;
           MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbInformation);
           Exit;
          end;

        //Testa se tem boleto para imprimir
       if (not fPrintBoleto) and (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE]) and (MyStrToMoney(MyEditValue.Text) > 0) then
         fPrintBoleto := (MycmbPayType.GetFieldByName('PrintBankBillet') <> 0);


        // Teste de pre date valido
        // testa valor minimo para pagamento em cada tipo
        if (MyEditDep.Visible) and (MyTotInvoice > 0) then
          with spTestpayType do
          begin
            Parameters.ParambyName('@IDMeioPag').Value  := MyStrToInt(MycmbPayType.LookUpValue);
            //#Rod - Round
            Parameters.ParambyName('@DifDay').Value     := Int(MyEditDep.Date-Int(EditReceiveDate.Date));
            Parameters.ParambyName('@Value').Value      := MyTotInvoice;
            ExecProc;

            case Parameters.ParambyName('RETURN_VALUE').Value of
              1: begin
                   if Password.HasFuncRight(17) then
                   begin
                     if MsgBox(MSG_QST_AMOUN_NOT_REACH_MIN, vbYesNo + vbQuestion) = vbNo then
                     begin
                       MyEditValue.SetFocus;
                       Exit;
                     end;
                   end
                   else
                   begin
                     MyEditDep.SetFocus;
                     MsgBox(MSG_INF_INVOICE_NOT_REACH_DATE, vbOKOnly + vbInformation);
                     Exit;
                   end;
                 end;
              -1: begin
                    if Password.HasFuncRIght(17) then
                    begin
                      if MsgBox(MSG_QST_PAYTYPE_NOT_ALLOW_DATE, vbYesNo + vbQuestion) = vbNo then
                      begin
                        MyEditValue.SetFocus;
                        Exit;
                      end;
                    end
                    else
                    begin
                      MyEditDep.SetFocus;
                      MsgBox(MSG_INF_PAYTYPE_NOT_THIS_DATE, vbOKOnly + vbInformation);
                      Exit;
                    end;
                  end;
            end;
          end;

        //Verificar se cliente e requerido
        if (MycmbPayType.GetFieldByName('RequireCustomer')) and (MyIDCliente <= 1) then
        begin
          MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
          Result := False;
          Exit;
        end;

        //Validar Store Account Balance
        if (DM.fPos.GetPayType(MycmbPayType.LookUpValue) = PAYMENT_TYPE_STOREACCOUNT) then
         if not ValidadeStoreAccount(MyStrToMoney(MyEditValue.Text)) then
           Exit;

        //Validar inadimplencia
        if (MyIDCliente > 1) and (not Password.HasFuncRight(90)) then
        begin
          if fCustDeliquent and MycmbPayType.GetFieldByName('ValidateNonpayer') then
          begin
            MsgBox(MSG_CRT_CUSTOMER_NOTUSE_PAYMENT, vbInformation + vbOkOnly);
            Result := False;
            Exit;
          end;
        end;

      end;
   end;

  Result := True;

end;

procedure TPreSaleReceive.EditReceivedExit(Sender: TObject);
begin
   EditReceived.Text := FormatFloat('###0.00', MyStrToMoney(EditReceived.Text));
end;

function TPreSaleReceive.ValidSinglePaymentType : Boolean;
begin
   Result := False;
   try

     // Valida o recebimento single
     if cmbPaymentType.LookUpValue = '' then
       begin
        cmbPaymentType.SetFocus;
        MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbCritical);
        Exit;
       end;

     if not TestDate(EditDepositDate.Text) and pnlDepositDate.Visible then
       begin
        EditDepositdate.SetFocus;
        MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
        Exit;
       end;

     // Testa Layaway
     if MyIsLayaway then
        if (MyPayment = 0) and edPayment.Visible  then
           begin
           MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
           if edPayment.CanFocus then
              edPayment.SetFocus;
           exit;
           end;


     // Teste de Invoice com Special Price com Payment Type diferente de Cash
     if (MyquPreSaleInfo.FieldByName('MediaID').AsInteger = MEDIA_TYPE_GUIDE) and
         MyquPreSaleValue.FieldByName('TaxIsent').AsBoolean and
        (MyStrToInt(cmbPaymentType.LookUpValue) <> PAY_TYPE_CASH) then
       begin
         if Password.HasFuncRight(18) then
           begin
            if MsgBox(MSG_QST_INVOICE_ONLY_CASH, vbYesNo + vbQuestion) = vbNo then
               Exit;
           end
         else
           begin
               if cmbPaymentType.CanFocus then
                  cmbPaymentType.SetFocus;
               MsgBox(MSG_INF_INVOICE_REC_ONLY_CASH, vbOKOnly + vbInformation);
               Exit;
           end;
       end;

     if MyTotInvoice > 0 then
       begin
        // testa valor minimo para pagamento em cada tipo
        with spTestpayType do
          begin
            Parameters.ParambyName('@IDMeioPag').Value := MyStrToInt(cmbPaymentType.LookUpValue);
            Parameters.ParambyName('@DifDay').Value    := Int(EditDepositDate.Date-Int(EditReceiveDate.Date));
            Parameters.ParambyName('@Value').Value     := MyTotInvoice;
            ExecProc;

            case Parameters.ParambyName('RETURN_VALUE').Value of
                 1           : begin
                                 if Password.HasFuncRight(17) then
                                   begin
                                    if MsgBox(MSG_QST_AMOUN_NOT_REACH_MIN, vbYesNo + vbQuestion) = vbNo then
                                       Exit;
                                   end
                                 else
                                   begin
                                     if pnlDepositDate.Visible then
                                        EditDepositDate.SetFocus;
                                     MsgBox(MSG_INF_INVOICE_NOT_REACH_DATE, vbOKOnly + vbInformation);
                                     Exit;
                                   end;
                               end;
                -1           : begin
                                 if Password.HasFuncRight(17) then
                                   begin
                                    if MsgBox(MSG_QST_PAYTYPE_NOT_ALLOW_DATE, vbYesNo + vbQuestion) = vbNo then
                                       Exit;
                                   end
                                 else
                                   begin
                                     if pnlDepositDate.Visible then
                                        EditDepositDate.SetFocus;
                                     MsgBox(MSG_INF_PAYTYPE_NOT_THIS_DATE, vbOKOnly + vbInformation);
                                     Exit;
                                   end;
                               end;
            end;
          end;
       end;

     if (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE]) and (GetPayment > 0) and (not fPrintBoleto) then
       fPrintBoleto := (cmbPaymentType.GetFieldByName('PrintBankBillet') <> 0);


     if (DM.fPOS.GetPayType(cmbPaymentType.LookUpValue) = PAYMENT_TYPE_STOREACCOUNT) then
       if not ValidadeStoreAccount(GetPayment) then
         Exit;

     if not ValidateCustomer then
       Exit;

     Result := True;
   finally
     if not Result then
       cmbPaymentType.LookUpValue := '';
   end;
end;

procedure TPreSaleReceive.edPaymentChange(Sender: TObject);
var
   Code, I  : Integer;
   Value    : Real;
   cPayment : Currency;
   bVisible : Boolean;
begin
  // Muda o change automatico
  if Trim(edPayment.Text) = '' then
     MyPayment := 0
  else
     MyPayment := MyStrToMoney(edPayment.Text);

   //Val(edPayment.Text, Value, Code);
   //if Code = 0 then
   //  MyPayment := Value;

   EditReceived.Text := edPayment.Text;

   EditTotalCash.Text := FloatToStrF(MyPayment, ffCurrency, 20, 2);

   Try
     cPayment := MyStrToMoney(edPayment.Text);
   Except
     cPayment := 0
   end;

   cbxCloseLayaway.Visible := ShowCloseLayAway(cPayment + MyLayaway) and (not DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_PAYMENTS]);

  //Cancela Pre-Datado se trocar o valor ha pagar
  // Apenas se a mudança não foi gerada pelo OnExit do próprio (Formatação)
  if edPayment.Tag = 0 then
    CancelPreDatar;

  if pgReceive.ActivePage = tbMultiple then
  begin
    btMulti2.Down := True;
    btMulti2.OnClick(btMulti2);
  end;
end;

procedure TPreSaleReceive.edPaymentExit(Sender: TObject);
var
  MyTotInvoiceCurrency: currency;
begin

  if cmbPaymentType.Text = '' then
     Exit;
  // Formata, fazendo com que o OnChange não seja chamado
  // (O Tag é tratado no OnChange)
  edPayment.Tag := 1;
  try
    edPayment.Text := FormatFloat('###0.00', MyPayment);
  finally
    edPayment.Tag := 0;
  end;

  if MyPayment = 0 then
    begin
      MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
      if edPayment.CanFocus then
         edPayment.SetFocus;
      exit;
    end;

  MyTotInvoiceCurrency := MyRound(MyTotInvoice, 2);

  if MyPayment > (MyTotInvoiceCurrency - MyLayaway) then
    begin
      MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
      if edPayment.CanFocus then
         edPayment.SetFocus;
      Exit;
    end;

end;

procedure TPreSaleReceive.spHelpClick(Sender: TObject);
begin
   Application.HelpContext(1060);
end;

procedure TPreSaleReceive.edPaymentKeyPress(Sender: TObject;
  var Key: Char);
begin

 Key := ValidateCurrency(Key);

end;

procedure TPreSaleReceive.EditValue1KeyPress(Sender: TObject;
  var Key: Char);
begin

  Key := ValidateCurrency(Key);

end;

procedure TPreSaleReceive.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sRefound       := '&Refund';
           sTotalRef      := 'Total Refund :';
           sReceive       := '&Receive';
           sTotalRec      := 'Cash Total :';
           sSetDateTo     := 'Set Date to ';
           sPaymentPlaces := 'Store,Out,Other,';
           sCadastrar     := 'Register ';
           sBonusInfo     := 'Enter Bonus';
           sBonusCodeValue:= 'Code : ';
           end;

     LANG_PORTUGUESE :
           begin
           sRefound       := '&Reembolso';
           sTotalRef      := 'Total :';
           sReceive       := '&Receber';
           sTotalRec      := 'Total :';
           sSetDateTo     := 'Colocar data para ';
           sPaymentPlaces := 'Loja,Contra-Entrega,Outros,';
           sCadastrar     := 'Cadastrar ';
           sBonusInfo     := 'Informar código do bonus';
           sBonusCodeValue:= 'Código do bonus : ';
           end;

     LANG_SPANISH :
           begin
           sRefound       := '&Reembolso';
           sTotalRef      := 'Total :';
           sReceive       := '&Reciber';
           sTotalRec      := 'Total :';
           sSetDateTo     := 'Colocar fecha para ';
           sPaymentPlaces := 'Tienda,Contra-Entrega,Otros,';
           sCadastrar     := 'Registar ';
           sBonusInfo     := 'Informar código do bonus';
           sBonusCodeValue:= 'Código do bonus : ';
           end;
   end;

   FrmPayPartial := Nil;

   FrmCreditPay := nil;

   pnlDelayPayments.Visible := DM.fSystem.SrvParam[PARAM_DISPLAY_PRE_DATADO];
   SetComboPaymentPlaces(sPaymentPlaces, DM.fSystem.SrvParam[PARAM_DISPLAY_PAYMENT_PLACE]);
   fConfirmEst := DM.fSystem.SrvParam[PARAM_CONFIRM_BUDGET];
end;

procedure TPreSaleReceive.FormDestroy(Sender: TObject);
begin
  inherited;

  if FrmPayPartial <> nil then
     FreeAndNil(FrmPayPartial);

  if FrmCreditPay <> nil then
     FreeAndNil(FrmCreditPay);

end;

procedure TPreSaleReceive.CancelPreDatar;
begin
  fHasDeposit := false;
  If FrmPayPartial <> nil then
     FrmPayPartial.ClearPaymentList;

  lbPartialInfo.Caption  := '';
  lbPartialInfo2.Caption := '';

end;


procedure TPreSaleReceive.btnPartialPaymentClick(Sender: TObject);
var
  Amount : Currency;
begin
  inherited;

  if not ValidadeLocalPayment then
     Exit;

  if MyIsLayaway then
     if MyPayment <> 0 then //Testa o pagamento se nao for zero, para nao adicionar parcelas zeradas
        if (MyTotInvoice>0) and (MyStrToMoney(edPayment.Text)<=0) then
           Exit;

  If FrmPayPartial = nil then
     FrmPayPartial := TFrmPayPartial.Create(Self);

  if MyIsLayaway then
     Amount := MyStrToMoney(edPayment.Text)
  else
     Amount := MyTotInvoice;

  lbPartialInfo.Caption :=
    FrmPayPartial.Start(StrToInt(cmbPaymentType.LookUpValue),
                        MyIDCliente,
                        MyIDPreSale,
                        MyIDCashRegMov,
                        Amount,
                        EditReceiveDate.Date,
                        EditAuthorization.Text,
                        fFormOfPayment,
                        cbPaymentPlace.ItemIndex);

  fHasDeposit := FrmPayPartial.HasDeposit;
end;

procedure TPreSaleReceive.btnPartialPayment2Click(Sender: TObject);
begin
  inherited;

  if StrToCurr(EditValue1.Text) = 0 then
     Exit;

  if cbPayPlace1.Visible then
     if cbPayPlace1.ItemIndex = PAYMENT_PLACE_EMPTY then
        begin
        MsgBox(MSG_INF_CHOOSE_PAYPLACE, vbInformation + vbOkOnly);
        cbPayPlace1.SetFocus;
        Exit;
        end;

  If FrmPayPartial = nil then
     FrmPayPartial := TFrmPayPartial.Create(Self);

  lbPartialInfo2.Caption :=
    FrmPayPartial.Start(StrToInt(cmbPayType1.LookUpValue),
                        MyIDCliente,
                        MyIDPreSale,
                        MyIDCashRegMov,
                        MyStrToMoney(EditValue1.Text),
                        editReceiveDate.Date,
                        EditAuto1.Text,
                        fFormOfPayment,
                        cbPayPlace1.ItemIndex);

  fHasDeposit := FrmPayPartial.HasDeposit;
end;

function TPreSaleReceive.DeletePayment: Boolean;
var
  I : Integer;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.DeletePayment');

  Result := True;

  try
    If (FrmPayPartial <> nil) Then
      if (FrmPayPartial.tvPartialPay.Items.Count > 0) Then
        for I := 0 to FrmPayPartial.tvPartialPay.Items.Count - 1 do
          if TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDCashRegMovClosed = -1 then
            with spPreSaleDeleteSingleDelayPayment do
            begin
              Parameters.ParamByName('@IDLancamento').Value := TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDLancamento;
              Parameters.ParamByName('@IDUser').Value    := DM.fUser.ID;
              ExecProc;
            end;
  except
    on E: Exception do
      DM.FTraceControl.SetException(E.Message, 'TPreSaleReceive');
  end;

  DM.FTraceControl.TraceOut;
end;


function TPreSaleReceive.ShowCloseLayAway(TotLayAway: Currency): Boolean;
begin
    Result := MyRound(MyTotInvoice-TotLayAway,2)=0;

   if DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_ON_SALE] then
     Result := Result and MyquPreSaleInfo.FieldByName('DeliverConfirmation').AsBoolean;
end;


procedure TPreSaleReceive.SetComboPaymentPlaces(sComboPaymentPlaces: String; bVisible: Boolean);
var
  I, J : Integer;
  MyPanel : TPanel;
  AssociatedLabel : TLabel;
begin
  // Passa a lista de locais de pagamento para todos os respectivos ComboBox

  cbPaymentPlace.Items.CommaText := sComboPaymentPlaces;
  cbPaymentPlace.ItemIndex       := PAYMENT_PLACE_LOJA;
  pnlPaymentPlace.Visible        := bVisible;

  with pnlMultiParcela do
    for I := 0 to (ControlCount - 1) do
    begin
      if not (Controls[I] is TPanel) then Continue;
      MyPanel := TPanel(Controls[I]);
      for J := 0 to (MyPanel.ControlCount - 1) do
        if MyPanel.Controls[J] is TComboBox then
        begin
           TComboBox(MyPanel.Controls[J]).Visible := bVisible;
           TComboBox(MyPanel.Controls[J]).Items.CommaText := sComboPaymentPlaces;
           TComboBox(MyPanel.Controls[J]).ItemIndex       := PAYMENT_PLACE_EMPTY;
           AssociatedLabel := TLabel(Self.FindComponent('lbPayPlace' + Trim(IntToStr(MyPanel.Controls[J].Tag))));
           if AssociatedLabel <> nil then
             AssociatedLabel.Visible := bVisible;
        end;
    end;

end;

function TPreSaleReceive.ValidateReceive : Boolean;
var
  fAmount : Currency;
  fExpDate : TDateTime;
  MyTotInvoiceCurrency: currency;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.ValidateReceive');

  try
    Result := False;

    if not ValidadeLocalPayment then
      Exit;

    MyTotInvoiceCurrency := MyRound(MyTotInvoice, 2);

    if MyIsLayaway then
      if (DM.fSystem.SrvParam[PARAM_ENTER_LAYAWAY_FULL_AMOUNT]) and
         (((MyPayment + MyLayaway) - MyTotInvoiceCurrency ) <> 0) then
      begin
        MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
        Exit;
      end;

    if not IsLayawayToClose then
    begin
      if pgReceive.ActivePage = tbSingle then
      begin
        if not ValidSinglePaymentType then
          Exit;

        if MyPayType = PAYMENT_TYPE_GIFTCARD then
        begin
          if not GetAccountCredit(edtAccountCard.Text,  fAmount, fExpDate) then
          begin
            MsgBox(Format(MSG_CRT_NO_GIFT_ACCOUNT, [edtAccountCard.Text]), vbInformation + vbOkOnly);
            Exit;
          end;

          if fAmount <= 0 then
          begin
            MsgBox(Format(MSG_CRT_GIFT_ACCOUNT_ZERO,[edtAccountCard.Text]), vbOKOnly + vbCritical);
            Exit;
          end;

          if fExpDate < Trunc(Now) then
          begin
            MsgBox(Format(MSG_CRT_GIFT_EXPIRED,[edtAccountCard.Text]), vbOKOnly + vbCritical);
            Exit;
          end;

          if fAmount < GetPayment then
          begin
            pgReceive.ActivePage := tbMultiple;
            pgReceiveChange(pgReceive);
            cmbPayType1.LookUpValue := cmbPaymentType.LookUpValue;
            EditValue1.Text := MyFloatToStr(fAmount);
            pnlAccount1.Visible := True;
            edtAccount1.Text := edtAccountCard.Text;
            Exit;
          end;
        end;

        if pnlShowAuthorization.Visible and (EditAuthorization.Text = '') then
        begin
          EditAuthorization.SetFocus;
          MsgBox(MSG_CRT_NO_AUTHORIZANUMBER, vbOKOnly + vbCritical);
          Exit;
        end;
      end
      else
      begin
        // Valida o recebimento Multiple
        if not ValidateMultiple(False) then
          Exit;
      end;

      if not TestDate(EditReceiveDate.Text) then
      begin
        MsgBox(MSG_CRT_INVAL_DATE_RECEIVE, vbCritical + vbOkOnly);
        if EditReceiveDate.CanFocus then
          EditReceiveDate.SetFocus;
        Exit;
      end;

      // Testa o troco dado
      // Teste se Received > Total PreSale
      if MyIsLayaway then
      begin
        if (spPayCash.Down and (MyRound(MyPayment-MyStrToMoney(EditReceived.Text), 2)>0)) then
        begin
          if EditReceived.CanFocus then
            EditReceived.SetFocus;
          MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
          Exit;
        end;

        // Payment cannot be zero
        if (MyPayment = 0) and edPayment.Visible  then
        begin
          MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
          if edPayment.CanFocus then
            edPayment.SetFocus;
          exit;
        end;

        MyTotInvoiceCurrency := MyRound(MyTotInvoice, 2);

        // Invalid Payment
        if MyPayment > (MyTotInvoiceCurrency - MyLayaway) then
        begin
          MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
          if edPayment.CanFocus then
            edPayment.SetFocus;
          Exit;
        end;
      end
      else
      begin
        if ((MyTotCash > 0) and (MyRound(MyTotCash-MyStrToMoney(EditReceived.Text), 2)>0)) then
        begin
          if EditReceived.CanFocus then
            EditReceived.SetFocus;
          MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
          Exit;
        end;
      end;
    end;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
  end;

  Result := True;

  DM.FTraceControl.TraceOut;
end;

function TPreSaleReceive.PagamentoJaSelecionado(Tipo: Integer; IDMeioPag: String; Parcela: Integer;RaiseMessage: Boolean): Boolean;
var
  i, j : Integer;
  MyPanel: Tpanel;
  Combo : TSuperComboADO;
begin
  Result := False;

  if Tipo = PAYMENT_TYPE_CARD then
    Exit;

  with pnlMultiParcela do
    for i := 0 to (ControlCount - 1) do
    begin

    if Result then
      Break;
    if not (Controls[i] is TPanel) then
      Continue;

    MyPanel := TPanel(Controls[i]);

    for j := 0 to (MyPanel.ControlCount - 1) do
     if MyPanel.Controls[j] is TSuperComboADO then
       begin
         Combo := TSuperComboADO(MyPanel.Controls[j]);
         if (Combo.LookUpValue <> '') and
            (Combo.Tag <> Parcela) and
            (Combo.LookUpValue = IDMeioPag) and
            (Combo.Tag <= NParcela) Then
         begin
           if RaiseMessage then
             MsgBox(MSG_INF_PAYTYPE_SELECTED, vbCritical);
           Result := True;
           Break;
         end;
       end
    end;

end;

function TPreSaleReceive.TipoPagamentoJaSelecionado(Tipo: Integer; Parcela: Integer;RaiseMessage: Boolean): Boolean;
var
  i, j : Integer;
  MyPanel: Tpanel;
  Combo : TSuperComboADO;
begin
  Result := False;

  // Não testa para Cartão de crédito
  if Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_GIFTCARD] then
    Exit;
    
  with pnlMultiParcela do
    for i := 0 to (ControlCount - 1) do
    begin

    if Result then
      Break;
    if not (Controls[i] is TPanel) then
      Continue;

    MyPanel := TPanel(Controls[i]);

    for j := 0 to (MyPanel.ControlCount - 1) do
     if MyPanel.Controls[j] is TSuperComboADO then
       begin
         Combo := TSuperComboADO(MyPanel.Controls[j]);
         if (Combo.LookUpValue <> '') and
            (Combo.Tag <> Parcela) and
            (DM.fPOS.GetPayType(Combo.LookUpValue) = Tipo) and
            (Combo.Tag <= NParcela) Then
         begin
           if RaiseMessage then
             MsgBox(MSG_INF_PAYTYPE_SELECTED, vbCritical);
           Result := True;
           Break;
         end;
       end
    end;

end;

procedure TPreSaleReceive.cbPaymentPlaceSelect(Sender: TObject);
begin
  inherited;
  AtuDepositState(MyStrToInt(cmbPaymentType.LookUpValue));
end;


// Encapsula o change de cada um dos 5 PayPlaces
// do Tab Multiple
procedure TPreSaleReceive.cbPayPlaceChange(Sender: TObject);
var
  iPayType: Integer;
  EditDep : TDateBox;
  lblDep  : TLabel;
  cbPayPlace : TComboBox;
  cmbPayType : TSuperComboADO;
begin
   EditDep := TDateBox(FindComponent('EditDep' + IntToStr(TComponent(Sender).Tag)));
   lblDep  := TLabel(FindComponent('lblDep' + IntToStr(TComponent(Sender).Tag)));

   cbPayPlace := TComboBox(FindComponent('cbPayPlace' + IntToStr(TComponent(Sender).Tag)));
   cmbPayType := TSuperComboADO(FindComponent('cmbPayType' + IntToStr(TComponent(Sender).Tag)));


   iPayType := DM.fPOS.GetPayType(cmbPayType.LookUpValue);

   EditDep.Visible    := (iPayType <> PAYMENT_TYPE_CASH) or (cbPayPlace.ItemIndex in [PAYMENT_PLACE_OUTROS]);
   lblDep.Visible     := EditDep.Visible;
end;

procedure TPreSaleReceive.cbPayPlace1Change(Sender: TObject);
begin
  inherited;
  cbPayPlaceChange(Sender);
end;

procedure TPreSaleReceive.cbPayPlace2Change(Sender: TObject);
begin
  inherited;
  cbPayPlaceChange(Sender);
end;

procedure TPreSaleReceive.cbPayPlace3Change(Sender: TObject);
begin
  inherited;
  cbPayPlaceChange(Sender);
end;

procedure TPreSaleReceive.cbPayPlace4Change(Sender: TObject);
begin
  inherited;
  cbPayPlaceChange(Sender);
end;

procedure TPreSaleReceive.cbPayPlace5Change(Sender: TObject);
begin
  inherited;
  cbPayPlaceChange(Sender);
end;


function TPreSaleReceive.ShowCredit(var Amount: Double; Const Verify: Boolean) : Boolean;
var
  VerifyAmount : Double;
begin

  Result := True;
  VerifyAmount := Amount;
  if FrmCreditPay = nil then
    FrmCreditPay := TFrmCreditPay.Create(Self)
  else
    FrmCreditPay.UnloadCredit;


  // Se necessita verificar confere se o cliente possui crédito antes de abrir
  if Verify then
    Result := (VerifyAmount <= FrmCreditPay.GetTotalCredit(MyIDCliente, DM.fStore.ID, MyIDPreSale));

  if not Result then
  begin
    MsgBox(MSG_INF_CREDIT_GREATER_INVOICE, vbCritical + vbOKOnly);
    Exit;
  end;

  Result := FrmCreditPay.Start(MyIDCliente, MyIDPreSale, NOW, Amount);
  if Result and (Verify and (VerifyAmount > Amount)) then
  begin
    Result := False;
    MsgBox(MSG_INF_CREDIT_SMALLER_TOTAL, vbCritical + vbOKOnly);
  end;
end;

procedure TPreSaleReceive.ClearCredit;
begin
  if FrmCreditPay <> nil then
    FrmCreditPay.UnloadCredit;
end;

procedure TPreSaleReceive.RefreshCustomerCredit;
var
  dCredit : Double;
begin
  if FrmCreditPay = nil then
    FrmCreditPay := TFrmCreditPay.Create(Self);

  dCredit := FrmCreditPay.GetTotalCredit(MyIDCliente, DM.fStore.ID, MyIDPreSale);

  lblCustomerCreditValue.Caption := ' : ' + MyFloatToStr(dCredit);

  lblCustomerCredit.Visible      := dCredit > 0;
  lblCustomerCreditValue.Visible := lblCustomerCredit.Visible;
end;

function TPreSaleReceive.ValidadeLocalPayment: Boolean;
begin
   Result := True;

   if pgReceive.ActivePage = tbSingle then
      if pnlPaymentPlace.Visible then
         if cbPaymentPlace.ItemIndex = PAYMENT_PLACE_EMPTY then
            begin
            MsgBox(MSG_INF_CHOOSE_PAYPLACE, vbInformation + vbOkOnly);
            cbPaymentPlace.SetFocus;
            Result := False;
            end;

end;

procedure TPreSaleReceive.spPayCheckClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_CHECK);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TPreSaleReceive.PreparePCC(APCCT: TPCCTransaction; AProcessor, AMercantNum : String);
begin

  DM.FTraceControl.TraceIn('TPreSaleReceive.PreparePCC');

  try
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
  except
    on E: Exception do
    begin
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
    end;
  end;

  DM.FTraceControl.TraceOut;


end;

function TPreSaleReceive.PCCResult(APCCT: TPCCTransaction) : Boolean;
var
  sMsg: String;
begin

  DM.FTraceControl.TraceIn('TPreSaleReceive.PCCResult');

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
      Application.MessageBox(PChar(sMsg), 'Transaction result', MB_OK + MB_ICONINFORMATION);
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

function TPreSaleReceive.DoPCCharge(var AAuth, ATroud, ALastDigits: String;
        Processor, MercantNum : String; AAmount: Currency; iPayType:Integer): Boolean;
var
  PCCT: TPCCTransaction;
  sMsg: String;
  frmPCCharge : TfrmPCCharge;
  MsgResult : Integer;
  iAction : Integer;
begin

  DM.FTraceControl.TraceIn('TPreSaleReceive.DoPCCharge');

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
            PCCT.RetailCreditOrAutorizationCardPresent(MyFormatCur(Abs(AAmount), '.'), IntToStr(MyIDPreSale), '', AAmount < 0)
          else
            begin
            if (AAmount > 0) then
               iAction := DEBIT_SALE
            else
               iAction := DEBIT_RETURN;
            PCCT.RetailDebitCardPresent(MyFormatCur(Abs(AAmount), '.'), '0.00', IntToStr(MyIDPreSale), '', iAction);
            end;

          Result := PCCResult(PCCT);
        end
      else
        begin
          frmPCCharge := TfrmPCCharge.Create(Self);
          try
            Result := frmPCCharge.Start(PCCT, IntToStr(MyIDPreSale), AAmount);
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

      //Result := PCCResult(PCCT, AAuth, ATroud, ALastDigits);

    except
      on E: Exception do
      begin
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
        Result := False;
      end;
    end;
  finally
    PCCT.Free;
  end;

  DM.FTraceControl.TraceOut;

end;

function TPreSaleReceive.DoPCVoid(var AAuth, ATroud, ALastDigits: String;
        Processor, MercantNum : String): Boolean;
var
  PCCT: TPCCTransaction;
begin
  Result := False;
  PCCT := TPCCTransaction.Create(Self);
  try
    try
      PreparePCC(PCCT, Processor, MercantNum);
      PCCT.OnNeedTroutD := NeedTroutD;

      PCCT.RetailVoidSale;

      Result := PCCResult(PCCT);

      if Result then
      begin
        AAuth       := PCCT.Auth;
        ATroud      := PCCT.TroutD;
        ALastDigits := PCCT.LastDigits;
      end;

    except
      Result := False;
    end;
  finally
    PCCT.Free;
  end;
end;

procedure TPreSaleReceive.NeedSwipe(Sender: TObject;
  var SwipedTrack: WideString; var Canceled: Boolean);
var
  SC : TFrmPCCSwipeCard;
  iIDMeioPag : Integer;
begin

  DM.FTraceControl.TraceIn('TPreSaleReceive.NeedSwipe');

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
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TPreSaleReceive.SucessFullSwipe(Sender: TObject; const ACardNumber,
  ACardMember, ACardExpireDate: WideString);
var
  sMsg: String;
begin
  // Adicionar neste evento qualquer código que precise ser executado após
  // uma tentativa bem sucedida de leitura do cartão
end;


procedure TPreSaleReceive.NeedTroutD(Sender: TObject; var ATrouD, ARefNo,
  AAuthCode: WideString; var ACanceled: Boolean);
var
  PCV: TfrmPCVoid;
begin
  PCV := TfrmPCVoid.Create(Self);
  try
    ACanceled := not PCV.Start(GetPayment, ATrouD, ARefNo, AAuthCode, nil);
  finally
    PCV.Free;
  end;
end;


function TPreSaleReceive.HasCreditCardProcessor(IDMeioPag: Integer; PayType:Integer): Boolean;
var
  fProcessor  : String;
  fMercantNum : String;
  fCardID : String;
  iCopies: Integer;
begin

   //DM.fPos.GetPayType(cmbPaymentType.LookUpValue)
   Result := (PayType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) and
             (DM.fPCCharge.ProcessorType <> 0);

   if Result then
    begin
    (*
      if DM.fPCCharge.ProcessorType = PROCESSOR_PCCHARGE then
      begin
        DM.fPCCharge.GetProcessor(IDMeioPag, fProcessor, fMercantNum, iCopies, fCardID);
        Result := ((Trim(fProcessor)<>'') and (Trim(fMercantNum)<>''));
      end
      else *) if DM.fPCCharge.ProcessorType = PROCESSOR_MERCURY then
        Result := ((Trim(DM.fMRMercury.IpAddress)<>'') and (Trim(DM.fMRMercury.MerchantID)<>''));

      if not Result then
      begin
        if (Trim(fProcessor) = '') then
          MsgBox('Invalid "Processor"._Card not charged', vbSuperCritical + vbOkOnly)
        else if (Trim(fMercantNum) = '') then
          MsgBox('Invalid "Mercant Number"._Card not charged', vbSuperCritical + vbOkOnly);
      end;
    end;

end;

function TPreSaleReceive.CallProcessor(IDMeioPag : Integer; PayType: Integer;
    var AAuth, ATroud, ALastDigits: String; AAmount: Currency): Boolean;
var
  TrouD: String;
  fProcessor  : String;
  fMercantNum : String;
  fCardID : String;
  Authorization : String;
  ATransactResult: Boolean;
  iCopies: Integer;
begin

  DM.FTraceControl.TraceIn('TPreSaleReceive.CallProcessor');

  Result := False;
  ATransactResult := False;
  try
    AAuth  := '';
    ATroud := '';
    (*
    if DM.fPCCharge.ProcessorType = PROCESSOR_PCCHARGE then
    begin
      DM.fPCCharge.GetProcessor(IDMeioPag, fProcessor, fMercantNum, iCopies, fCardID);
      if (fProcessor <> '') or (fMercantNum <> '') then
         ATransactResult := DoPCCharge(Authorization, TrouD, ALastDigits, fProcessor, fMercantNum, AAmount, PayType);
    end
    else *)
      if DM.fPCCharge.ProcessorType = PROCESSOR_MERCURY then
        ATransactResult := DoMercury(Authorization, TrouD, ALastDigits, AAmount, PayType);

    if not ATransactResult then
      raise Exception.Create('Card not charged!!!_' + FErrorMsg)
    else
    begin
      Result := True;
      AAuth  := Authorization;
      ATroud := TrouD;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
      MsgBox(E.Message, vbCritical);
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

function TPreSaleReceive.GetAccountCredit(Account: String;
  var Amount: Currency; var ExpDate : TDateTime): Boolean;
begin
  with quAccountBalance do
  begin
    Parameters.ParamByName('CardNumber').Value := Account;
    try
      Open;
      Amount  := quAccountBalanceAmount.AsCurrency;
      if quAccountBalanceExpirationDate.IsNull then
        ExpDate := Trunc(Now)
      else
        ExpDate := Trunc(quAccountBalanceExpirationDate.AsDateTime);
      Result := not IsEmpty;
    finally
      Close;
      end;
  end;
end;

procedure TPreSaleReceive.RefreshAccountCredit;
var
  fAmount : Currency;
  fExpDate : TDateTime;
begin

  if edtAccountCard.Text <> '' then
  begin
    lbAccountCredit.Visible      := False;
    lbAccountCreditValue.Visible := lbAccountCredit.Visible;

    if not GetAccountCredit(edtAccountCard.Text,  fAmount, fExpDate) then
    begin
      MsgBox(Format(MSG_CRT_NO_GIFT_ACCOUNT, [edtAccountCard.Text]), vbInformation + vbOkOnly);
      Exit;
    end;

    if fAmount = 0 then
    begin
      MsgBox(Format(MSG_CRT_GIFT_ACCOUNT_ZERO, [edtAccountCard.Text]), vbInformation + vbOkOnly);
      Exit;
    end;

    if fExpDate < Trunc(Now) then
    begin
     MsgBox(Format(MSG_CRT_GIFT_EXPIRED,[edtAccountCard.Text]), vbOKOnly + vbCritical);
     Exit;
    end;

    lbAccountCreditValue.Caption := ' : ' + MyFloatToStr(fAmount);
    lbAccountCredit.Visible      := True;
    lbAccountCreditValue.Visible := lbAccountCredit.Visible;

    if (fAmount < GetPayment) and (fAmount <> 0) then
    begin
      pgReceive.ActivePage := tbMultiple;
      pgReceiveChange(pgReceive);
      cmbPayType1.LookUpValue := cmbPaymentType.LookUpValue;
      EditValue1.Text := MyFloatToStr(fAmount);
      pnlAccount1.Visible := True;
      edtAccount1.Text := edtAccountCard.Text;
      lblAuto1.Visible := False;
      EditAuto1.Visible := False;
      EditAuto1.Text := '';
      cmbPayType1.SetFocus;
      Exit;
    end;
  end;

end;

procedure TPreSaleReceive.edtAccountCardExit(Sender: TObject);
begin
  inherited;
  RefreshAccountCredit;
  btOk.Default := True;
end;

procedure TPreSaleReceive.edtAccountCardKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    RefreshAccountCredit;
end;

procedure TPreSaleReceive.edtAccountCardEnter(Sender: TObject);
begin
  inherited;
  btOk.Default := False;
end;

procedure TPreSaleReceive.ClosePaySugg;
begin

  with quUpPayment do
    if Active then
      Close;

end;

procedure TPreSaleReceive.OpenPaySugg;
begin

  with quUpPayment do
    if not Active then
    begin
      Parameters.ParamByName('IDPreSale').Value := MyIDPreSale;
      Open;
    end;

end;

procedure TPreSaleReceive.RefreshPaySugg;
begin

  if fConfirmEst then
  begin
    ClosePaySugg;
    OpenPaySugg;
    pnlPaySuggestion.Visible := (not quUpPayment.IsEmpty);
  end
  else
    pnlPaySuggestion.Visible := False;

end;

function TPreSaleReceive.ValidateCustomer: Boolean;
begin

  Result := True;

  if (cmbPaymentType.LookUpSource.DataSet.FieldByName('RequireCustomer').AsBoolean) and (MyIDCliente <= 1) then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
    Result := False;
    Exit;
  end;

  //Validar inadimplencia
  if (MyIDCliente > 1) and (not Password.HasFuncRight(90)) then
  begin
    if fCustDeliquent and cmbPaymentType.GetFieldByName('ValidateNonpayer') then
    begin
      MsgBox(MSG_CRT_CUSTOMER_NOTUSE_PAYMENT, vbInformation + vbOkOnly);
      Result := False;
      Exit;
    end;
  end;

end;

function TPreSaleReceive.DoMercury(var AAuth, ATroud, ALastDigits: String;
  AAmount: Currency; iPayType: Integer): Boolean;
var
  FMercuryWidget : TCCWidget;
  MsgResult : Integer;
begin
  DM.FTraceControl.TraceIn('TFrmStoreAccount.DoMercury');

  Result := False;
  if iPayType = PAYMENT_TYPE_CARD then
    FMercuryWidget := getPaymentCard(dm.fPCCharge.ProcessorType, iPayType)
  else
    FMercuryWidget := getPaymentCard(dm.fPCCharge.ProcessorType, iPayType);

  try
    if iPayType = PAYMENT_TYPE_CARD then
    begin
      MsgResult := MsgBox('Is the customer card present?_Total to be proccessed: '+FormatCurr('#,##0.00',AAmount), vbYesNoCancel);
      if MsgResult = vbCancel then
        Exit;
    end
    else
      MsgResult := vbYes;

    // antonio aug 10 2015 - call correct interface to process transaction with card present or not
    if ( msgResult = vbYes ) then begin
       if ( ipayType = PAYMENT_TYPE_CARD ) then begin
         processCardCreditIsPresent(AAmount, fMercuryWidget)
       end else begin
              processCardDebitIsPresent(AAmount, fMercuryWidget);
           end
    end else begin
            processCardIsNotPresent(AAmount, fMercuryWidget);
        end;

  finally
    FreeAndNil(FMercuryWidget);
  end;

  DM.FTraceControl.TraceOut;

end;

function TPreSaleReceive.MercuryResult(AmercuryWidget: TCCWidget): Boolean;
var
  sMsg: String;
begin
  DM.FTraceControl.TraceIn(Self.ClassName + '.MercuryResult');
  Result := False;

  sMsg := '';
  try

    case AmercuryWidget.TransactionReturn of
      ttrSuccessfull:
      begin
        Result := True;
        sMsg := Format('%S'#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'RefDataD: %S', [AmercuryWidget.Msg, AmercuryWidget.ResultAuth, AmercuryWidget.ResultRefNo, AmercuryWidget.ResultAcqRefData]);
      end;

      ttrNotSuccessfull:
      begin
        sMsg := Format('%S'#13#10'Reason: %S', [AmercuryWidget.Msg, AmercuryWidget.ResultAuth]);
        raise Exception.Create(sMsg);
      end;

      ttrError:
      begin
        sMsg := Format(#13#10'Error: %S', [AmercuryWidget.Msg]);
        raise Exception.Create(sMsg);
      end;

      ttrException:
      begin
        sMsg := Format(''#13#10'Error: %S', [AmercuryWidget.Msg + ' ' + AmercuryWidget.ErrorMsg]);
        raise Exception.Create(sMsg);
      end;
    end;
  except
    FErrorMsg := sMsg;
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TPreSaleReceive.PrintBankBillet;
begin
  if fPrintBoleto then
  begin
    with DM.quFreeSQL do
    try
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('SELECT L.IDLancamento');
      SQL.Add('FROM Fin_Lancamento L (NOLOCK)');
      SQL.Add('JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)');
      SQL.Add('WHERE L.IDPreSale = ' + IntToStr(MyIDPreSale));
      SQL.Add('AND IsNull(MP.PrintBankBillet,0) = 1');
      Open;
      if not IsEmpty then
      begin
        First;
        while not EOF do
        begin
          with TFrmPrintBoleto.Create(Self) do
            Start(FieldByName('IDLancamento').AsInteger);
          Next;
        end;
      end;

    finally
      Close;
    end;
  end;
end;

function TPreSaleReceive.ValidadeStoreAccount(APayment : Currency): Boolean;
var
  fSABanlace : Currency;
begin

  if (MyIDCliente <= 1) then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
    Result := False;
    Exit;
  end;

  if (GetPayment <= 0) then
  begin
    MsgBox(MSG_CRT_INVALID_AMOUNT, vbOKOnly + vbCritical);
    Exit;
  end;

  //Validar Saldo
  if (not Password.HasFuncRight(89)) then
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
      SQL.Add('AND SA.IDPessoa = ' + IntToStr(MyIDCliente));
      Open;
      fSABanlace := FieldByName('Amount').AsCurrency;
    finally
      Close;
    end;

    if fCustSAMax < (fSABanlace + APayment) then
    begin
      MsgBox(Format(MSG_CRT_AS_EXCEED_BALANCE, [FormatFloat('#,##0.00', (fSABanlace + APayment)), FormatFloat('#,##0.00', fCustSAMax)]), vbOKOnly + vbCritical);
      Exit;
    end;
  end;

  Result := True;

end;

procedure TPreSaleReceive.RefreshCustomerInfo;
begin

  if (MyIDCliente > 1) then
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT P.StoreAccountLimit, P.Nonpayer');
      SQL.Add('FROM Pessoa P (NOLOCK)');
      SQL.Add('WHERE P.IDPessoa = ' + IntToStr(MyIDCliente));
      Open;
      fCustSAMax := FieldByName('StoreAccountLimit').AsCurrency;
      fCustDeliquent := FieldByName('Nonpayer').AsBoolean;
    finally
      Close;
    end;

end;

procedure TPreSaleReceive.RecalcInvoiceTotal;
var
  cBonusPayment : Currency;
begin

    if MyIsLayaway then
      begin
        // Calculo o total de layaway
        MyLayaway := DM.fPOS.GetInvoicePayments(MyIDPreSale);

        // Sugiro o valor restante a pagar
        MyPayment       := MyTotInvoice - MyLayaway;
        edLayaway.text  := FloatToStrF(MyLayaway, ffCurrency, 20, 2);
        edtBalance.text := FloatToStrF(MyPayment, ffCurrency, 20, 2);

        // Mostros os campos do Layaway se Balance nao for zero
        lblPayment.Visible := (MyPayment<>0);
        edPayment.Visible  := lblPayment.Visible;
        lbIqual.Visible    := lblPayment.Visible;
        // Mostros os campos do Layaway
        lblLayaway.Visible := True;
        edLayaway.Visible  := True;
        lbMenus.Visible    := True;
        lbBalance.Visible  := True;
        edtBalance.Visible := True;

        IsLayawayToClose := ShowCloseLayAway(MyLayaway);

        //Verifico se e para fechar o Layaway
        if  IsLayawayToClose then
           begin
           pnlPaymentType.Visible  := False;
           pnlShowCash.Visible     := False;
           lblPayment.Visible      := False;
           edPayment.Visible       := False;
           lbIqual.Visible         := False;

           cbxCloseLayaway.Visible := not DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_PAYMENTS];
           //cbxCloseLayaway.Enabled := False;
           end
        else
           begin
           cbxCloseLayaway.Visible := False;
           if DM.fSystem.SrvParam[PARAM_ENTER_LAYAWAY_FULL_AMOUNT] then
             edPayment.Text := FormatFloat('#,##0.00', MyPayment)
           else
             edPayment.Clear;
           end;
      end
    else
      begin
        if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
        begin
          cBonusPayment := DM.fPOS.GetInvoicePayments(MyIDPreSale);
          if (cBonusPayment <> 0) then
          begin
            MyTotInvoice := MyRound(MyquPreSaleValue.FieldByName('TotalInvoice').AsFloat, 2) - cBonusPayment;
            EditTotalInvoice.Text := FloatToStrF(MyTotInvoice, ffCurrency, 20, 2);
          end;
        end;

        // Sumo com os campos do layaway
        lblPayment.Visible := False;
        edPayment.Visible  := False;
        lblLayaway.Visible := False;
        edPayment.Visible  := False;
        edLayaway.Visible  := False;
        lbMenus.Visible    := False;
        lbIqual.Visible    := False;
        lbBalance.Visible  := False;
        edtBalance.Visible := False;
      end;

end;

function TPreSaleReceive.ProcessInvoiceBonus : Boolean;
var
  BonusBucks: TBonusBucks;
  cDiscountValue: Currency;
  GetBonus : Boolean;
  BonusCode : String;
  IDError : Integer;
  ErrorMsg : String;
  sInvoiceNum : String;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.ProcessInvoiceBonus');

  GetBonus := False;
  Result := True;
  try
    try
      BonusCode := '';
      DM.FBonusSync.BonusCode := '';
      DM.FBonusSync.BonusValue := 0;

      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      begin
        BonusBucks := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
        BonusBucks.IDPreSaleCreated := MyIDPreSale;
        cDiscountValue := BonusBucks.DiscountValue;
        sInvoiceNum := MyquPreSaleInfo.FieldByName('SaleCode').AsString;

        if cDiscountValue > 0 then
          if not DM.BonusGenerate(MyTotInvoice, cDiscountValue, sInvoiceNum, Trunc(Now), BonusCode, IDError, ErrorMsg) then
          begin
            DM.FBonusSync.BonusValue := 0;
            if (MsgBox(MSG_QST_PROCESS_BONUS + ErrorMsg, vbYesNo + vbQuestion) = vbNo) then
            begin
              Result := False;
              Exit;
            end;
          end;
        GetBonus := True;
      end
      else
        cDiscountValue := 0;

      if not Result then
        raise Exception.Create('error receiving');
        
    finally
      if GetBonus then
        FreeAndNil(BonusBucks);
    end;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'TPreSaleReceive');
      Result := False;
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

function TPreSaleReceive.getPaymentCard(arg_processor,
  arg_paymentType: Integer): TCCWidget;
begin
    case (arg_paymentType) of
       PAYMENT_TYPE_CARD: begin
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

function TPreSaleReceive.processCardCreditIsPresent(arg_amount: Double; arg_widget: TCCWidget): Boolean;
begin
  arg_widget.OnNeedSwipe          := NeedSwipe;
  arg_widget.AfterSucessfullSwipe := SucessFullSwipe;

  arg_widget.Memo                := 'MainRetail ' + DM.fSystem.VerBuild;
  arg_widget.OperatorID          := IntToStr(DM.fUser.ID);
  arg_widget.InvoiceNo           := IntToStr(MyIDPreSale);
  arg_widget.RefNo               := IntToStr(MyIDPreSale);
  arg_widget.Purchase            := arg_amount;
  arg_widget.AcctNo              := '';
  arg_widget.ExpDate             := '';
  arg_widget.Track2              := '';
  arg_widget.Tax := 0;
  arg_widget.Address := '';
  arg_widget.zip := '';
  arg_widget.CustomerCode := '';
  arg_widget.cvvData := '';

  if ( arg_amount > 0 ) then begin
     arg_widget.ProcessSale();
  end else begin
         arg_widget.ProcessReturn();
      end;
end;

function TPreSaleReceive.processCardDebitIsPresent(arg_amount: Double; arg_widget: TCCWidget): Boolean;
begin
(*
   arg_widget.fmPinPad.fbaudRate := dm.fpinPad.baud;
   arg_widget.fmPinPad.FCommport := dm.fpinpad.comm;
   arg_widget.ftimeout := strToInt(dm.fPinPad.TimeOut);
 *)
 
   if ( arg_amount > 0 ) then begin
      arg_widget.processSale();
   end else begin
          arg_widget.ProcessReturn();
       end;
end;

function TPreSaleReceive.processCardIsNotPresent(arg_amount: Double; arg_widget: TCCWidget): Boolean;
var sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2 : String;
begin
    with TfrmPCCharge.Create(nil) do
    try
      Result := StartMercury(sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2);

      if ( Result ) then begin
        arg_widget.OnNeedSwipe := nil;
        arg_widget.AfterSucessfullSwipe := nil;
        arg_widget.OnNeedTroutD := nil;
        arg_widget.Memo := 'MainRetail';
        arg_widget.OperatorID := intToStr(dm.fUser.ID);
        arg_widget.InvoiceNo := intToStr(MyIDPreSale);
        arg_widget.RefNo := intToStr(myIdPresale);
        arg_widget.Purchase := arg_amount;
        arg_widget.tax := 0;
        arg_widget.AcctNo := sCardNumber;
        arg_widget.ExpDate := sExpireDate;
        arg_widget.address := sStreetAddress;
        arg_widget.zip := sZipCode;
        arg_widget.cvvData := sCVV2;
        arg_widget.CustomerCode := sMemberName;
        arg_widget.Track2 := '';

        if ( arg_amount > 0 ) then begin
           arg_widget.ProcessSale()
        end else begin
               arg_widget.ProcessReturn();
            end;
      end
      else
        FErrorMsg := 'Canceled by user.';
    finally
      Free;
    end;
end;

end.
