unit uCashRegClose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  Buttons, ADODB, SuperComboADO, siComp, siLangRT, ComCtrls, ppBands,
  ppClass, ppCtrls, ppPrnabl, ppCache, ppProd, ppReport, ppComm, ppRelatv,
  ppDB, ppDBPipe, ppParameter, ppModule, raCodMod, Variants, ppVar;

type
  PPayment = ^TPayment;

  TPayment = record
    IDLancamento: Integer;
    CheckNumber : String;
    ValorNominal: Double;
    Checked     : Boolean;
    IDPreSale   : Integer;
    MeioPag     : String;
    ExpireDate  : TDateTime;
    IDCashRegMov: Integer;
    SaleCode:     String;
    IDMeioPag:    Integer;
    IDBanco:      Integer;
    PreSaleDate:  TDateTime;
    InvoiceTotal: Currency;
    CustomerDocument: String;
    CustomerName:     String;
    CustomerPhone:    String;
    NumDesdobramento: String;
  end;



  TCashRegClose = class(TFrmParent)
    btCancel: TButton;
    tmrCloseCash: TTimer;
    spHelp: TSpeedButton;
    PPC: TPageControl;
    tsPOS: TTabSheet;
    Label23: TLabel;
    Panel5: TPanel;
    lblSubTipCash: TLabel;
    Image5: TImage;
    Image8: TImage;
    lblTipCash: TLabel;
    pnlCloseCash: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCashierTotal: TLabel;
    lblSystemTotal: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblDifference: TLabel;
    Shape1: TShape;
    cmbUser: TDBSuperComboADO;
    EditTime: TEdit;
    EditTotCashier: TEdit;
    EditTotSystem: TEdit;
    EditDiference: TEdit;
    pnlOther: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    btnPostDate: TSpeedButton;
    btnCheckTotal: TSpeedButton;
    btnOtherTotal: TSpeedButton;
    btnTotalCard: TSpeedButton;
    Panel6: TPanel;
    cmbTotalCard: TEdit;
    cmbTotalPre: TEdit;
    cmbTotalCheck: TEdit;
    cmbTotalOther: TEdit;
    Panel10: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    grpCoin: TGroupBox;
    lblCountCoin: TLabel;
    lblSugCoin: TLabel;
    Label36: TLabel;
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
    grpBill: TGroupBox;
    lblSugBill: TLabel;
    lblCountBill: TLabel;
    Label33: TLabel;
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
    pnlCountBill: TPanel;
    wwDBEdit1: TEdit;
    wwDBEdit2: TEdit;
    wwDBEdit3: TEdit;
    wwDBEdit4: TEdit;
    wwDBEdit5: TEdit;
    wwDBEdit6: TEdit;
    wwDBEdit7: TEdit;
    pnllblBill: TPanel;
    Label56: TLabel;
    Label55: TLabel;
    Label54: TLabel;
    Label53: TLabel;
    Label52: TLabel;
    Label51: TLabel;
    Label50: TLabel;
    EditTotCash: TEdit;
    wwDBEdit15: TEdit;
    wwDBEdit14: TEdit;
    pnlDeposit: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Shape2: TShape;
    EditTotDeposit: TEdit;
    EditTotCounted: TEdit;
    EditOpenCash: TEdit;
    tsOffice: TTabSheet;
    Panel4: TPanel;
    lblCheck: TLabel;
    lblCash: TLabel;
    lblOther: TLabel;
    lblCard: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel7: TPanel;
    edtCash: TEdit;
    edtCard: TEdit;
    edtCheck: TEdit;
    edtOther: TEdit;
    quPayment: TADOQuery;
    quPaymentTipo: TIntegerField;
    quPaymentValorTotal: TBCDField;
    quPaymentsReport: TADOQuery;
    quPaymentsReportIDLancamento: TIntegerField;
    quPaymentsReportCheckNumber: TStringField;
    quPaymentsReportCustomerDocument: TStringField;
    quPaymentsReportCustomerName: TStringField;
    quPaymentsReportCustomerPhone: TStringField;
    quPaymentsReportValorNominal: TBCDField;
    quPaymentsReportDataVencimento: TDateTimeField;
    quPaymentsReportBanco: TStringField;
    quPaymentsReportTipo: TIntegerField;
    quPaymentsReportDescTipo: TStringField;
    pplPaymentsReport: TppDBPipeline;
    ppPaymentsReport: TppReport;
    dsPaymentsReport: TDataSource;
    quPaymentsByType: TADOQuery;
    quPaymentsByTypeIDLancamento: TIntegerField;
    quPaymentsByTypeCheckNumber: TStringField;
    quPaymentsByTypeCustomerDocument: TStringField;
    quPaymentsByTypeCustomerName: TStringField;
    quPaymentsByTypeCustomerPhone: TStringField;
    quPaymentsByTypeValorNominal: TBCDField;
    quPaymentsByTypeDataVencimento: TDateTimeField;
    quPaymentsByTypeBanco: TStringField;
    quPaymentsByTypeIDPreSale: TIntegerField;
    quPaymentsReportIDPreSale: TIntegerField;
    quPaymentsByTypeMeioPag: TStringField;
    edtTotal: TEdit;
    Label11: TLabel;
    quPaymentsByTypeIDCashRegMov: TIntegerField;
    btnPrint: TSpeedButton;
    SpeedButton4: TSpeedButton;
    quTempCRT: TADOQuery;
    quTempDRP: TADOQuery;
    quTempINS: TADOQuery;
    quPaymentsReportClosed: TADOQuery;
    quPaymentsReportIDCashRegMovClosed: TIntegerField;
    ppPaymentsReportClosed: TppReport;
    quPaymentsByTypeSaleCode: TStringField;
    quPaymentsReportSaleCode: TStringField;
    quPaymentsReportQuitado: TStringField;
    lblCredit: TLabel;
    edtCredit: TEdit;
    SpeedButton5: TSpeedButton;
    quPaymentsCRT: TADOQuery;
    quPaymentsDRP: TADOQuery;
    spGetPayments: TADOStoredProc;
    quPaymentsReportInvoiceTotal: TBCDField;
    quPaymentsReportPreSaleDate: TDateTimeField;
    quPaymentsReportIsQuitado: TBooleanField;
    quPaymentsReportTotalDays: TIntegerField;
    quPaymentsReportMeioPag: TStringField;
    quPaymentsReportNumDesdobramento: TStringField;
    quPaymentsReportClosedPreSaleDate: TDateTimeField;
    quPaymentsReportClosedQuitado: TStringField;
    quPaymentsReportClosedTotalDays: TIntegerField;
    quPaymentsReportClosedIDLancamento: TIntegerField;
    quPaymentsReportClosedCheckNumber: TStringField;
    quPaymentsReportClosedCustomerDocument: TStringField;
    quPaymentsReportClosedCustomerName: TStringField;
    quPaymentsReportClosedCustomerPhone: TStringField;
    quPaymentsReportClosedValorNominal: TBCDField;
    quPaymentsReportClosedDataVencimento: TDateTimeField;
    quPaymentsReportClosedBanco: TStringField;
    quPaymentsReportClosedIDPreSale: TIntegerField;
    quPaymentsReportClosedTipo: TIntegerField;
    quPaymentsReportClosedSaleCode: TStringField;
    quPaymentsReportClosedInvoiceTotal: TBCDField;
    quPaymentsReportClosedDescTipo: TStringField;
    quPaymentsReportClosedMeioPag: TStringField;
    quPaymentsReportClosedNumDesdobramento: TStringField;
    quPaymentsReportClosedIDCashRegMovClosed: TIntegerField;
    quPaymentsReportClosedDataLancamento: TDateTimeField;
    quPaymentsReportClosedIsQuitado: TBooleanField;
    quTotalMeioPag: TADOQuery;
    lbDebit: TLabel;
    cmbTotalDebit: TEdit;
    btnTotalDebit: TSpeedButton;
    quTotalDeposit: TADOQuery;
    lbDebitCard: TLabel;
    edtDebit: TEdit;
    SpeedButton6: TSpeedButton;
    ppHeaderBand1: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel10: TppLabel;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel4: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText8: TppDBText;
    ppShape3: TppShape;
    ppLine1: TppLine;
    ppFooterBand1: TppFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel6: TppLabel;
    ppDBText9: TppDBText;
    ppLabel13: TppLabel;
    ppDBText13: TppDBText;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppDBCalc1: TppDBCalc;
    ppLabel14: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppVariable1: TppVariable;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppLabel22: TppLabel;
    ClosedDate: TppParameter;
    ppSystemVariable: TppSystemVariable;
    lblDate: TppLabel;
    ppLabel24: TppLabel;
    ClosedStore: TppParameter;
    ppHeaderBand2: TppHeaderBand;
    ppLabel2: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel11: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppVariable3: TppVariable;
    ppVariable4: TppVariable;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDetailBand2: TppDetailBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText10: TppDBText;
    ppShape1: TppShape;
    ppLine2: TppLine;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppLabel18: TppLabel;
    ppDBText1: TppDBText;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppLabel12: TppLabel;
    ppDBText11: TppDBText;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppDBCalc2: TppDBCalc;
    ppDBText17: TppDBText;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppGroup5: TppGroup;
    ppGroupHeaderBand5: TppGroupHeaderBand;
    ppVariable2: TppVariable;
    ppGroupFooterBand5: TppGroupFooterBand;
    raCodeModule2: TraCodeModule;
    ppParameterList2: TppParameterList;
    IDLanguageClosed: TppParameter;
    StoreClose: TppParameter;
    DateClose: TppParameter;
    lblUser: TppLabel;
    ppLabel26: TppLabel;
    ClosedUser: TppParameter;
    lblStore: TppLabel;
    quPaymentsByTypeIDMeioPag: TIntegerField;
    quPaymentsByTypeIDBanco: TIntegerField;
    quPaymentsByTypePreSaleDate: TDateTimeField;
    quPaymentsByTypeInvoiceTotal: TCurrencyField;
    quPaymentsByTypeNumDesdobramento: TStringField;
    cmdInsPaymentsUnSelected: TADOCommand;
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
    procedure quPaymentsReportCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure quPaymentsReportClosedCalcFields(DataSet: TDataSet);
    procedure SpeedButton6Click(Sender: TObject);
  private
    sCloseCash12, sCloseCash22,
    sEnterQty, sEnterQtyDeposit,
    sCount, sNext, sCancel,
    sCounted, sDeposit,
    sDeposit2, sBack,
    sCash, sCheck, sCard, sOther,
    sClosed, sNotClosed, sCredit, sDebit: String;
    TotCashGeral, TotOtherGeral: Double;
    MyIDOpenUser, MyIDCashRegMov: Integer;
    MyResidual, TotCounted: Double;
    TpOperation: integer;
    fCall: Integer;
    FCashType: Integer;
    fIDStore: Variant;
    fIDCashRegMov: Variant;
    fCloseDate: TDateTime;

    lstCash, lstCheck, lstCard, lstOther, lstCredit, lstDebit: TList;

    procedure StartDepositPOS;
    procedure StartCheckPOS;
    procedure AtuTotCashier;
    function  TestaPreenchimento(MyControl: TControl) : Boolean;
    procedure POSNext;
    procedure FormShowPOS;
    function GetTotalPaymentByType(TypePayment: Integer): Double;
    procedure OfficeNext;
    procedure FormShowOffice;
    procedure StartCheckOffice;
    function FillPayments(Tipo: Integer; Lista: TList): Double;
    function ShowCashregCloseConfer(Lista: TList): Boolean;
    function CalcPaymentsList(Lista: TList): Double;
    procedure CalcClick(Sender: TObject);
    procedure SetTotal;
    function InsereLancamentosTemp(Lista: TList): Boolean;
    procedure OfficeCreateTemp;
    procedure OfficeDropTemp;
    procedure PrintCashClose(Fechado: Integer);
    procedure GetPaymentsTemp(Caixa, CaixaFechado, TipoPag, IDStore: Variant;
      IsFechado: Boolean);
    procedure SetOthersValues(IDCashRegMov: Integer);
  public
    function RePrintOffice(IDCashRegClose, IDStore: Integer; CloseDate: TDateTime): Boolean;
    // CashType => 1 - Office; 2 - POS
    function Start(IDCashRegMov, CashType: Integer): Boolean;
  end;

implementation

uses uDM, uItemsCalc, uPrintCashReg, uCashRegEnvelop, uMsgBox, uSystemConst,
     uNumericFunctions, uMsgConstant, uSystemTypes, uCharFunctions, uDMGlobal,
     RTLConsts, uCashregCloseConfer, DateUtils;

const TP_CHECKING = 1;
      TP_DEPOSIT  = 2;

{$R *.DFM}

function TCashRegClose.Start(IDCashRegMov, CashType : Integer) : Boolean;
begin
  fIDCashRegMov := Null;
  FCashType := CashType;

  case FCashType of
    CASHREG_TYPE_POS :
       begin
       PPC.ActivePage := tsPOS;
       SetOthersValues(IDCashRegMov);
       end;
    CASHREG_TYPE_OFFICE,
    CASHREG_TYPE_SHIPPING:
       begin
       PPC.ActivePage  := tsOffice;
       Width           := 457;
       Height          := 496;
       if DM.fCashRegister.ViewOthers then
         fIDCashRegMov := Null
       else
         fIDCashRegMov := IDCashRegMov;

       if DM.fCashRegister.ViewOthersStores then
          fIDStore := Null
       else
          fIDStore := DM.fStore.ID;

       quPaymentsCRT.ExecSQL;
       end;
    else
      begin
      PPC.ActivePage := tsPOS;
      SetOthersValues(IDCashRegMov);
      end;
  end;

  Result := False;
  fCall  := -1;

  // Teste de mesmo usuario que abriu
  DM.fPOS.GetCashRegisterResidual(IDCashRegMov, MyIDOpenUser, MyResidual);
  MyIDCashRegMov := IDCashRegMov;

  AtuTotOthers(Self);

  // Seta o usuario e time
  cmbUser.LookUpValue := IntToStr(DM.fUser.ID);
  EditTime.Text       := DateTimeToStr(Now);

  // Open CashRegister
  DM.OpenCashRegister(DRAW_KICK_TYPO_CLOSE_REG);

  Result := (ShowModal = mrOK);
end;

procedure TCashRegClose.SetOthersValues(IDCashRegMov: Integer);
var
  cash, card, others, check, debit: Double;
begin
  with quTotalMeioPag do
  begin
   try
     if Active then
       Close;

     Parameters.ParamByName('IDCashRegMov').Value := IDCashRegMov;
     Open;

     cash      := 0;
     card      := 0;
     others    := 0;
     check     := 0;
     debit     := 0;

     First;
     while not Eof do
     begin
       case FieldByName('Tipo').AsInteger of
         PAYMENT_TYPE_CASH         : cash := cash + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_CARD         : card := card + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_OTHER        : others := others + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_CHECK        : check := check + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_CREDIT       : others := others + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_GIFTCARD     : others := others + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_DEBIT        : debit := debit + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_BONUSBUCK    : others := others + FieldByName('Total').AsFloat;
         PAYMENT_TYPE_STOREACCOUNT : others := others + FieldByName('Total').AsFloat;
        end;
        Next;
     end;
   finally
     Close;
   end;
  end;

  with quTotalDeposit do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDCashRegMov').Value := IDCashRegMov;
    Open;
    First;
    while not Eof do
    begin
      cash   := cash - FieldByName('TotalCash').AsFloat;
      card   := card - FieldByName('TotalCard').AsFloat;
      others := others - FieldByName('TotalOther').AsFloat;
      check  := check - FieldByName('TotalCheck').AsFloat;
      debit  := debit - FieldByName('TotalDebit').AsFloat;;
      Next;
    end;
  finally
    Close;
  end;

  cmbTotalCard.Text :=  MyFloatToStr(card);
  cmbTotalCheck.Text := MyFloatToStr(check);
  cmbTotalOther.Text := MyFloatToStr(others);
  cmbTotalDebit.Text := MyFloatToStr(debit);

end;

procedure TCashRegClose.AtuTotals(Sender : TObject);
var
  Razao: Double;
  EditValor: TEdit;
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

  EditValor.Text := FloatToStrF(MyStrToFloat(TEdit(Sender).Text)*Razao,
                    ffCurrency, 20, 2);

  // Atualiza o total geral
  TotCashGeral := MyStrToFloat(Edit100.Text)*100;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit50.Text)*50;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit20.Text)*20;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit10.Text)*10;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit5.Text)*5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit2.Text)*2;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit1.Text);
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit001.Text)*0.01;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit005.Text)*0.05;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit010.Text)*0.1;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit025.Text)*0.25;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit050.Text)*0.5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit0100.Text);

  EditTotCash.Text := FloatToStrF(TotCashGeral, ffCurrency, 20, 2);

  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TCashRegClose.AtuTotCashier;
begin
  EditTotCashier.Text := FloatToStrF(TotCashGeral + TotOtherGeral, ffCurrency, 20, 2);
  EditDiference.Text  := FloatToStrF(TotCashGeral + TotOtherGeral - MyResidual, ffCurrency, 20, 2);

  EditTotDeposit.Text := FloatToStrF(TotCashGeral + TotOtherGeral, ffCurrency, 20, 2);
  EditOpenCash.Text   := FloatToStrF(TotCounted - TotCashGeral - TotOtherGeral, ffCurrency, 20, 2);
end;

procedure TCashRegClose.FormShow(Sender: TObject);
begin
  inherited;
  case FCashType of
    CASHREG_TYPE_POS      : FormShowPOS;
    CASHREG_TYPE_OFFICE,
    CASHREG_TYPE_SHIPPING : FormShowOffice;
    else
      FormShowPOS;
  end;
end;

procedure TCashRegClose.FormShowPOS;
begin
  EditTotSystem.Visible := not DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  EditDiference.Visible := not DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  wwdbedit14.Visible    := DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  wwdbedit15.Visible    := DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM];
  if DM.fSystem.SrvParam[PARAM_CLOSECASHRANDOM] then
  begin
    wwdbedit14.Text := FloatToStrF(50000+Random(5000), ffCurrency, 20, 2);
    wwdbedit15.Text := FloatToStrF(50000+Random(5000), ffCurrency, 20, 2);
  end;

  StartCheckPOS;
end;

procedure TCashRegClose.FormShowOffice;
begin
  StartCheckOffice;
end;

procedure TCashRegClose.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  if FCashType in [CASHREG_TYPE_OFFICE, CASHREG_TYPE_SHIPPING] then
    quPaymentsDRP.ExecSQL;
end;

procedure TCashRegClose.btCancelClick(Sender: TObject);
begin
  inherited;
  if TpOperation = TP_DEPOSIT then
    StartCheckPOS
  else
    ModalResult := mrCancel;
end;

procedure TCashRegClose.btCloseClick(Sender: TObject);
begin
  case FCashType of
    CASHREG_TYPE_POS : POSNext;

    CASHREG_TYPE_OFFICE,
    CASHREG_TYPE_SHIPPING:
       begin
        OfficeCreateTemp;
        try
          OfficeNext;
        finally
          OfficeDropTemp;
        end;

       end;
    else
      POSNext;
  end;
end;

procedure TCashRegClose.POSNext;
var
  Envelop : String;
  iError,
  IDCashRegLog  : Integer;
begin
  inherited;
  // Testa o estado que se encontra a tela e passa para o proximo
  if TpOperation = TP_CHECKING then
    StartDepositPOS
  else
  begin
    //if (MsgBox(MSG_QST_CONFIRM_CLOSE_REGISTER, vbYesNo + vbQuestion) = vbYes) then
    //begin
      // Pede o numero do envelope para deposito
      with TCashRegEnvelop.Create(Self) do
        if not Start(Envelop) then Exit;

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
                                     MyStrToFloat(cmbTotalCard.Text),
                                     MyStrToFloat(cmbTotalPre.Text),
                                     MyStrToFloat(cmbTotalCheck.Text),
                                     MyStrToFloat(cmbTotalOther.Text),
                                     MyStrToFloat(cmbTotalDebit.Text),
                                     Envelop,
                                     Now,
                                     IDCashRegLog,
                                     iError);

         if iError = -1 then
            begin
            MsgBox(MSG_INF_CSR_IS_CLOSED, vbOKOnly + vbInformation);
            Exit;
            end;

      if DM.fPrintReceipt.PrintReceipt then
        // Imprime o ticket do caixa
        with TPrintCashReg.Create(Self) do
          Start(IDCashRegLog, TICKET_CASH_CLOSE);

      // Animacao de fechamento de caixa
      tmrCloseCash.Enabled := True;
    //end;
  end;
end;

procedure TCashRegClose.OfficeNext;
var
  Envelop : String;
  iError,
  IDCashRegLog  : Integer;
  I : Integer;
  bCanExec : Boolean;
begin
  bCanExec := True;
  inherited;

  // Pede o numero do envelope para deposito
  with TCashRegEnvelop.Create(Self) do
    if not Start(Envelop) then Exit;

  bCanExec := InsereLancamentosTemp(lstCard);
  if bCanExec then
    bCanExec := InsereLancamentosTemp(lstCheck);
  if bCanExec then
    bCanExec := InsereLancamentosTemp(lstOther);
  if bCanExec then
    bCanExec := InsereLancamentosTemp(lstCash);
  if bCanExec then
    bCanExec := InsereLancamentosTemp(lstCredit);
  if bCanExec then
    bCanExec := InsereLancamentosTemp(lstDebit);


 DM.fPOS.SubCloseCashRegister(MyIDCashRegMov,
                              DM.fUser.ID,
                              MyStrToFloat(edtTotal.Text),
                              MyStrToFloat(edtCash.Text),
                              MyStrToFloat(edtCard.Text),
                              0,
                              MyStrToFloat(edtCheck.Text),
                              MyStrToFloat(edtOther.Text),
                              MyStrToFloat(edtDebit.Text),
                              Envelop,
                              Now,
                              IDCashRegLog,
                              iError);

   if iError = -1 then
      begin
      bCanExec := False;
      MsgBox(MSG_INF_CSR_IS_CLOSED, vbOKOnly + vbInformation);
      end;



  if bCanExec then
  if DM.fPrintReceipt.PrintReceipt then
    // Imprime o ticket do caixa
    with TPrintCashReg.Create(Self) do
      Start(IDCashRegLog, TICKET_CASH_CLOSE);

  if not bCanExec then
    raise Exception.Create(MSG_INF_CSR_IS_CLOSED);


  PrintCashClose(1);
  // Animacao de fechamento de caixa
  tmrCloseCash.Enabled := True;
end;

procedure TCashRegClose.OfficeCreateTemp;
begin
  quTempCRT.ExecSQL;
end;

procedure TCashRegClose.OfficeDropTemp;
begin
  quTempDRP.ExecSQL;
end;

function TCashRegClose.TestaPreenchimento(MyControl : TControl) : Boolean;
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

procedure TCashRegClose.AtuTotOthers(Sender : TObject);
begin
  TotOtherGeral := MyStrToFloat(cmbTotalCard.text)  +
                   MyStrToFloat(cmbTotalPre.text)   +
                   MyStrToFloat(cmbTotalCheck.text) +
                   MyStrToFloat(cmbTotalOther.text) +
                   MyStrToFloat(cmbTotalDebit.text);
  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TCashRegClose.tmrCloseCashTimer(Sender: TObject);
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

procedure TCashRegClose.StartCheckPOS;
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
  if Edit100.CanFocus then
    Edit100.SetFocus;
end;

procedure TCashRegClose.StartCheckOffice;
begin
  TpOperation       := TP_CHECKING;

  btClose.Caption   := sDeposit2;

  lblCAsh.Caption   := sCash;
  lblCard.Caption   := sCard;
  lblCheck.Caption  := sCheck;
  lblOther.Caption  := sOther;
  lblCredit.Caption := sCredit;

  GetPaymentsTemp(MyIDCashRegMov, MyIDCashRegMov, Null, fIDStore, False);

  edtCash.Text   := MyFloatToStr(FillPayments(PAYMENT_TYPE_CASH, lstCash));
  edtCard.Text   := MyFloatToStr(FillPayments(PAYMENT_TYPE_CARD, lstCard));
  edtCheck.Text  := MyFloatToStr(FillPayments(PAYMENT_TYPE_CHECK, lstCheck));
  edtOther.Text  := MyFloatToStr(FillPayments(PAYMENT_TYPE_OTHER, lstOther));
  edtCredit.Text := MyFloatToStr(FillPayments(PAYMENT_TYPE_CREDIT, lstCredit));
  edtDebit.Text  := MyFloatToStr(FillPayments(PAYMENT_TYPE_DEBIT, lstDebit));

  SetTotal;

  PrintCashClose(0);
end;

procedure TCashRegClose.StartDepositPOS;
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

procedure TCashRegClose.ApagaEdit(MyGroup : TGroupBox);
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

procedure TCashRegClose.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1070);
end;

procedure TCashRegClose.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Key := ValidateNumbers(Key);

end;

procedure TCashRegClose.cmbTotalCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
     begin
       fCall := TEdit(Sender).Tag;
       btnTotalCardClick(Self);
     end;

end;

procedure TCashRegClose.btnTotalCardClick(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
     begin
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

procedure TCashRegClose.FormCreate(Sender: TObject);
begin
  inherited;

  lstCheck  := TList.Create;
  lstCard   := TList.Create;
  lstOther  := TList.Create;
  lstCash   := TList.Create;
  lstCredit := TList.Create;
  lstDebit  := TList.Create;

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
           sCash            := 'Cash';
           sCheck           := 'Checks';
           sCard            := 'Credit Cards';
           sOther           := 'Others';
           sClosed          := 'Paid';
           sNotClosed       := 'Not Paid';
           sCredit          := 'Customer Credit';
           sDebit           := 'Debit Cards';
           end;

     LANG_PORTUGUESE :
           begin
           sCloseCash12     := 'Verificando o Total do Caixa com Total do Sistema - Passo 1/2';
           sCloseCash22     := 'Fazendo o depósito final - Passo 2/2';
           sEnterQty        := 'Entre com a quantidade para cada denominação no campo apropriado.';
           sEnterQtyDeposit := 'Deixe no caixa as quantidades sugeridas na linha DEIXAR.';
           sCount           := 'Contar :';
           sNext            := '&Seguir >>';
           sCancel          := '&Cancelar';
           sCounted         := 'Contado :';
           sDeposit         := 'Deixar :';
           sDeposit2        := '&Depositar';
           sBack            := '<< &Voltar';
           sCash            := 'Dinheiro';
           sCheck           := 'Cheques';
           sCard            := 'Cartões de Crédito';
           sOther           := 'Outros';
           sClosed          := 'Quitado';
           sNotClosed       := 'Não Quitado';
           sCredit          := 'Crédito';
           sDebit           := 'Débito';
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
           sCash            := 'Dinero';
           sCheck           := 'Cheques';
           sCard            := 'Tarjetas de Crédito';
           sOther           := 'Otros';
           sClosed          := 'Pago';
           sNotClosed       := 'No pago';
           sCredit          := 'Crédito';
           sDebit           := 'Débito';
           end;
   end;

end;

function TCashRegClose.GetTotalPaymentByType(TypePayment: Integer) : Double;
begin
  Result := 0;
  with quPayment do
  begin
    if Active then
      Close;
    try
       Parameters.ParamByName('Tipo').Value         := TypePayment;
       Parameters.ParamByName('IDCashRegMov').Value := MyIDCashRegMov;
       Open;

       Result := quPaymentValorTotal.Value;
    finally
      Close;
    end;
  end;
end;

procedure TCashRegClose.quPaymentsReportCalcFields(DataSet: TDataSet);
begin
  inherited;
  case quPaymentsReportTipo.AsInteger of
    PAYMENT_TYPE_CASH   : quPaymentsReportDescTipo.AsString := sCash;
    PAYMENT_TYPE_CARD   : quPaymentsReportDescTipo.AsString := sCard;
    PAYMENT_TYPE_OTHER  : quPaymentsReportDescTipo.AsString := sOther;
    PAYMENT_TYPE_CHECK  : quPaymentsReportDescTipo.AsString := sCheck;
    PAYMENT_TYPE_CREDIT : quPaymentsReportDescTipo.AsString := sCredit;
    PAYMENT_TYPE_DEBIT  : quPaymentsReportDescTipo.AsString := sDebit;
    else
      quPaymentsReportDescTipo.AsString := 'n/a';
  end;

  if quPaymentsReportIDCashRegMovClosed.IsNull then
    begin
    quPaymentsReportIsQuitado.AsBoolean := False;
    quPaymentsReportQuitado.AsString := sNotClosed;
    end
  else
    begin
    quPaymentsReportIsQuitado.AsBoolean := True;
    quPaymentsReportQuitado.AsString := sClosed;
    end;

  quPaymentsReportTotalDays.AsInteger := DaysBetween(quPaymentsReportPreSaleDate.AsDateTime, Now);

end;

procedure TCashRegClose.FormDestroy(Sender: TObject);
begin
  inherited;
  lstCheck.Free;
  lstCard.Free;
  lstOther.Free;
  lstCash.Free;
end;

function TCashRegClose.FillPayments(Tipo: Integer; Lista: TList) : Double;
var
  ptrPayment : PPayment;
begin
  Result := 0;
  with quPaymentsByType do
  begin
    if Active then
      Close;
    try
       Parameters.ParamByName('Tipo').Value := Tipo;

       if DM.fCashRegister.ViewOthersStores then
         Parameters.ParamByName('IDStore').Value := NULL
       else
         Parameters.ParamByName('IDStore').Value := fIDStore;

       if DM.fCashRegister.ViewOthers then
         Parameters.ParamByName('IDCashRegMov').Value := NULL
       else
         Parameters.ParamByName('IDCashRegMov').Value := fIDCashRegMov;

       Open;

       while not EOF do
       begin
         New(ptrPayment);
         ptrPayment^.IDLancamento     := quPaymentsByTypeIDLancamento.AsInteger;
         ptrPayment^.CheckNumber      := quPaymentsByTypeCheckNumber.AsString;
         ptrPayment^.ValorNominal     := quPaymentsByTypeValorNominal.Value;
         ptrPayment^.IDPreSale        := quPaymentsByTypeIDPreSale.AsInteger;
         ptrPayment^.MeioPag          := quPaymentsByTypeMeioPag.AsString;
         ptrPayment^.ExpireDate       := quPaymentsByTypeDataVencimento.AsDateTime;
         ptrPayment^.IDCashRegMov     := quPaymentsByTypeIDCashRegMov.AsInteger;
         ptrPayment^.SaleCode         := quPaymentsByTypeSaleCode.AsString;
         ptrPayment^.Checked          := True;
         ptrPayment^.IDMeioPag        := quPaymentsByTypeIDMeioPag.AsInteger;
         ptrPayment^.IDBanco          := quPaymentsByTypeIDBanco.AsInteger;
         ptrPayment^.PreSaleDate      := quPaymentsByTypePreSaleDate.AsDateTime;
         ptrPayment^.InvoiceTotal     := quPaymentsByTypeInvoiceTotal.AsCurrency;
         ptrPayment^.CustomerDocument := quPaymentsByTypeCustomerDocument.AsString;
         ptrPayment^.CustomerName     := quPaymentsByTypeCustomerName.AsString;
         ptrPayment^.CustomerPhone    := quPaymentsByTypeCustomerPhone.AsString;
         ptrPayment^.NumDesdobramento := quPaymentsByTypeNumDesdobramento.AsString;

         Lista.Add(ptrPayment);
         Result := Result + quPaymentsByTypeValorNominal.Value;
         Next;
       end;
    finally
      Close;
    end;
  end;
end;

function TCashRegClose.CalcPaymentsList(Lista: TList): Double;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to Lista.Count-1 do
    if PPayment(Lista[I])^.Checked then
      Result := Result + PPayment(Lista[I])^.ValorNominal;
end;

function TCashRegClose.ShowCashregCloseConfer(Lista: TList) : Boolean;
var
  CashregCloseConfer: TCashregCloseConfer;
begin
  CashregCloseConfer := TCashregCloseConfer.Create(Self);

  Result := CashregCloseConfer.Start(Lista);
end;



procedure TCashRegClose.CalcClick(Sender : TObject);
var
  Lista : TList;
begin
  case TEdit(Sender).Tag of
    2: Lista := lstCard;
    3: Lista := lstOther;
    4: Lista := lstCheck;
    5: Lista := lstCredit;
    6: Lista := lstDebit;
    Else
      Lista := lstCash;
  end;
  ShowCashregCloseConfer(Lista);
  TEdit(Sender).Text := MyFloatToStr(CalcPaymentsList(Lista));
  SetTotal;
end;

procedure TCashRegClose.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtCard);
end;

procedure TCashRegClose.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtCheck);
end;

procedure TCashRegClose.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtOther);
end;


procedure TCashRegClose.SetTotal;
begin
  edtTotal.Text :=
      MyFloatToStr(MyStrToFloat(edtCash.Text)  +
                   MyStrToFloat(edtCard.Text)  +
                   MyStrToFloat(edtCheck.Text) +
                   MyStrToFloat(edtOther.Text) +
                   MyStrToFloat(edtDebit.Text) +
                   MyStrToFloat(edtCredit.Text));
end;

function TCashRegClose.InsereLancamentosTemp(Lista: TList): Boolean;
var
  I : Integer;
begin
  Result := True;
  for I := 0 to Lista.Count -1 do
  begin
    try
      if PPayment(Lista[I])^.Checked then
      begin
        quTempINS.Parameters.ParamByName('IDLancamento').Value := PPayment(Lista[I])^.IDLancamento;
        quTempINS.Parameters.ParamByName('IDCashRegMov').Value := PPayment(Lista[I])^.IDCashRegMov;
        quTempINS.ExecSQL;
      end
      else
      begin
        if DM.fSystem.SrvParam[PARAM_SAVE_UNPOSTED_PAYMENT_ON_CLOSE] then
          with cmdInsPaymentsUnSelected do
          begin
            Parameters.ParamByName('IDPaymentLog').Value     := DM.GetNextID('CashRegMovPaymentLog.IDPaymentLog');
            Parameters.ParamByName('IDCashRegMov').Value     := MyIDCashRegMov;
            Parameters.ParamByName('IDMeioPag').Value        := PPayment(Lista[I])^.IDMeioPag;
            Parameters.ParamByName('IDBanco').Value          := PPayment(Lista[I])^.IDBanco;
            Parameters.ParamByName('SaleCode').Value         := PPayment(Lista[I])^.SaleCode;
            Parameters.ParamByName('PreSaleDate').Value      := PPayment(Lista[I])^.PreSaleDate;
            Parameters.ParamByName('InvoiceTotal').Value     := PPayment(Lista[I])^.InvoiceTotal;
            Parameters.ParamByName('CheckNumber').Value      := PPayment(Lista[I])^.CheckNumber;
            Parameters.ParamByName('CustomerDocument').Value := PPayment(Lista[I])^.CustomerDocument;
            Parameters.ParamByName('CustomerName').Value     := PPayment(Lista[I])^.CustomerName;
            Parameters.ParamByName('CustomerPhone').Value    := PPayment(Lista[I])^.CustomerPhone;
            Parameters.ParamByName('ValorNominal').Value     := PPayment(Lista[I])^.ValorNominal;
            Parameters.ParamByName('DataVencimento').Value   := PPayment(Lista[I])^.ExpireDate;
            Parameters.ParamByName('NumDesdobramento').Value := PPayment(Lista[I])^.NumDesdobramento;
            Parameters.ParamByName('IDPreSale').Value        := PPayment(Lista[I])^.IDPreSale;
            Execute;
          end;
      end;
    except
      Result := False;
    end;
    if not Result then Break
  end;
end;

procedure TCashRegClose.btnPrintClick(Sender: TObject);
begin
  inherited;
  ppPaymentsReport.Print;
end;

procedure TCashRegClose.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtCash);
end;


procedure TCashRegClose.PrintCashClose(Fechado : Integer);
var
  Report : TppReport;
begin
  if Fechado = 1 then
    GetPaymentsTemp(MyIDCashRegMov, MyIDCashRegMov, null, fIDStore, True);

  with quPaymentsReport do
  begin
    if Active then
      Close;

    if DM.fCashRegister.ViewOthers then
      Parameters.ParamByName('IDCashRegMov').Value := NULL
    else
      Parameters.ParamByName('IDCashRegMov').Value := fIDCashRegMov;

    if DM.fCashRegister.ViewOthersStores then
      Parameters.ParamByName('IDStore').Value := NULL
    else
      Parameters.ParamByName('IDStore').Value := fIDStore;

    {
    Parameters.ParamByName('IDCashRegMovClosed').Value := MyIDCashRegMov;
    Parameters.ParamByName('IsFechado').Value          := Fechado;
    }
    Open;
  end;

  case Fechado Of
    0 : begin
          quPaymentsReport.Sort :=
            'SaleCode, Tipo, DataVencimento';
          Report := ppPaymentsReport;
          ClosedDate.AsString  := FormatDateTime('ddddd', Now);
          ClosedStore.AsString := DM.fStore.Name;
          ClosedUser.AsString := DM.fUser.UserName;
        end;
    1 : begin
          quPaymentsReport.Sort :=
            'IDCashRegMovClosed DESC, Tipo, MeioPag, SaleCode, DataVencimento, CheckNumber';
          Report := ppPaymentsReportClosed;
          StoreClose.AsString := DM.fStore.Name;
          DateClose.AsString  := FormatDateTime('ddddd', Now);
        end;
  end;

  IDLanguage.AsInteger := DMGlobal.IDLanguage;
  IDLanguageClosed.AsInteger := DMGlobal.IDLanguage;

  //Pega a mesma impressora que o invoice
  if DM.fPrintReceipt.InvoiceReportPrinter <> '' then
    Report.PrinterSetup.PrinterName := DM.fPrintReceipt.InvoiceReportPrinter;

  Report.Print;

end;


procedure TCashRegClose.GetPaymentsTemp(Caixa, CaixaFechado, TipoPag, IDStore: Variant;
                                         IsFechado: Boolean);
begin
  with spGetPayments do
  begin
    Parameters.ParamByName('@Caixa').Value        := Caixa;
    Parameters.ParamByName('@CaixaFechado').Value := CaixaFechado;
    Parameters.ParamByName('@TipoPag').Value      := TipoPag;
    Parameters.ParamByName('@IsFechado').Value    := IsFechado;
    Parameters.ParamByName('@IDStore').Value      := IDStore;
    ExecProc;
  end;
end;

procedure TCashRegClose.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtCredit);
end;

function TCashRegClose.RePrintOffice(IDCashRegClose,
  IDStore: Integer; CloseDate : TDateTime): Boolean;
begin

  dsPaymentsReport.DataSet := quPaymentsReportClosed;
  fCloseDate := CloseDate;
  MyIDCashRegMov := IDCashRegClose;

  try
    with quPaymentsReportClosed do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDCashRegMov1').Value := IDCashRegClose;
      Parameters.ParamByName('IDCashRegMov2').Value := IDCashRegClose;
      Parameters.ParamByName('IDStore').Value       := IDStore;
      Open;
    end;

    //quPaymentsReportClosed.Sort :=
    //  'IDCashRegMovClosed DESC, Tipo, MeioPag, SaleCode, CheckNumber';

    StoreClose.AsString := DM.fStore.Name;
    DateClose.AsString  := FormatDateTime('ddddd', fCloseDate);

    IDLanguage.AsInteger := DMGlobal.IDLanguage;
    IDLanguageClosed.AsInteger := DMGlobal.IDLanguage;

    ppPaymentsReportClosed.Print;

  finally
    quPaymentsReportClosed.Close;
    Self.Close;  
    end;


end;

procedure TCashRegClose.quPaymentsReportClosedCalcFields(
  DataSet: TDataSet);
begin
  inherited;

  case quPaymentsReportClosedTipo.AsInteger of
    1: quPaymentsReportClosedDescTipo.AsString := sCash;
    2: quPaymentsReportClosedDescTipo.AsString := sCard;
    3: quPaymentsReportClosedDescTipo.AsString := sOther;
    4: quPaymentsReportClosedDescTipo.AsString := sCheck;
    5: quPaymentsReportClosedDescTipo.AsString := sCredit;
    else
      quPaymentsReportClosedDescTipo.AsString := 'n/a';
  end;

  if not quPaymentsReportClosedIsQuitado.AsBoolean then
    quPaymentsReportClosedQuitado.AsString := sNotClosed
  else
    quPaymentsReportClosedQuitado.AsString := sClosed;

  quPaymentsReportClosedTotalDays.AsInteger := DaysBetween(quPaymentsReportClosedPreSaleDate.AsDateTime, Now);
  
end;

procedure TCashRegClose.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  CalcClick(edtDebit);
end;

end.
