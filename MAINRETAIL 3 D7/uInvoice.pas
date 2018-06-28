(*
-----------------------------------------------------------------------------------------------------
Version : (289 - 285)
Date    : 03.11.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : total invoice shows 4 decimal places.
Solution: set up correct mask to display format properfield object.
Version : (289 - 285)
-----------------------------------------------------------------------------------------------------

Version : (288 - 277)
Date    : 12.14.2010
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Details were not showed
Solution: I had to treat string SQL on open.
Version : (288 - 278)
-----------------------------------------------------------------------------------------------------
*)


unit uInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, DBCtrls, Mask, Grids, DBGrids,
  LblEffct, ExtCtrls, DB, DBTables, MemoStr, DateBox, uPreSaleItem,
  ComCtrls, Buttons, uPrintReceipt, Spin, ADODB, SuperComboADO,
  siComp, siLangRT, SMDBGrid, SubListPanel, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxDBEdit,
  Variants, uFrmJoinHold, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  SuperEdit, SuperEditCurrency, uFrmAddInvoiceOBS, uFrmAddItems, Menus,
  cxSpinEdit, clsInfoCashSale;

type
  TFrmInvoice = class(TFrmParent)
    Panel4: TPanel;
    pnlPreSale: TPanel;
    btAddItem: TSpeedButton;
    btRemoveItem: TSpeedButton;
    Label16: TLabel;
    dsPreSaleInfo: TDataSource;
    quPreSaleInfo: TADOQuery;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    btDiscountItem: TSpeedButton;
    dsPreSaleValue: TDataSource;
    Label19: TLabel;
    EditPreSaleDate: TDBEdit;
    lblInvoiceDate: TLabel;
    dsPreSaleItem: TDataSource;
    btRefund: TSpeedButton;
    TmrRefreshItem: TTimer;
    spquPreSaleItem: TADOStoredProc;
    spquPreSaleItemDescription: TStringField;
    spquPreSaleItemSalePrice: TFloatField;
    spquPreSaleItemDiscount: TFloatField;
    spquPreSaleItemIDInventoryMov: TIntegerField;
    spquPreSaleItemTotalItem: TFloatField;
    spquPreSaleValue: TADOStoredProc;
    spquPreSaleValueTaxIsent: TBooleanField;
    spquPreSaleValueSubTotal: TFloatField;
    spquPreSaleValueItemDiscount: TFloatField;
    spquPreSaleValueTax: TFloatField;
    spquPreSaleValueTaxPrc: TFloatField;
    spquPreSaleValueDiscountPrc: TFloatField;
    spquPreSaleValueTotalInvoice: TFloatField;
    spTestRefresh: TADOStoredProc;
    spquPreSaleValueSpecialPriceID: TIntegerField;
    spquPreSaleValueSpecialPrice: TStringField;
    quDiscRange: TADOQuery;
    dsDiscRange: TDataSource;
    quDiscRangeTotVendaMin: TFloatField;
    quDiscRangePercDiscMax: TFloatField;
    pnlUsers: TPanel;
    EditOpenUser: TDBEdit;
    Label9: TLabel;
    spquPreSaleValuenOpenUser: TIntegerField;
    spquPreSaleValueShowOpenUser: TIntegerField;
    btCancel: TButton;
    spquPreSaleItemModelID: TIntegerField;
    spquPreSaleItemModel: TStringField;
    quPayMin: TADOQuery;
    dsPayMin: TDataSource;
    btSerial: TSpeedButton;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPayMinDifDay: TIntegerField;
    quPayMinTotalSale: TFloatField;
    quPayMinIDMeioPag: TIntegerField;
    pgInvoice: TPageControl;
    tbTourist: TTabSheet;
    tbDeliver: TTabSheet;
    tbDeposit: TTabSheet;
    tbNote: TTabSheet;
    tbDiscount: TTabSheet;
    EditNote: TDbMemoStr;
    cmbPayType: TDBSuperComboADO;
    Label17: TLabel;
    quDescTourist: TADOQuery;
    quDescTouristTipTouristGroup: TStringField;
    Label21: TLabel;
    Shape1: TShape;
    quPreSaleInfoIDPreSale: TIntegerField;
    pnlPessoa: TPanel;
    pnlOther: TPanel;
    Label3: TLabel;
    cmbOther: TDBSuperComboADO;
    Panel5: TPanel;
    Label7: TLabel;
    dbSpecialPrice: TDBEdit;
    btMakeSpecialPrice: TSpeedButton;
    quPreSaleInfoMediaID: TIntegerField;
    Panel7: TPanel;
    btDetGroup: TSpeedButton;
    Panel8: TPanel;
    cmbDelType: TDBSuperComboADO;
    Label4: TLabel;
    Panel9: TPanel;
    Label11: TLabel;
    Label8: TLabel;
    EditAmountDisc: TEdit;
    Panel10: TPanel;
    btTaxIsent: TSpeedButton;
    spPayVisa: TSpeedButton;
    spPayMaster: TSpeedButton;
    spPayAmerican: TSpeedButton;
    Label10: TLabel;
    EditDepositDate: TDBDateBox;
    spquPreSaleItemIDComission: TIntegerField;
    spquPreSaleItemCostPrice: TFloatField;
    lblTourGroup: TLabel;
    tbPrint: TTabSheet;
    Panel12: TPanel;
    btImpHold: TBitBtn;
    Panel13: TPanel;
    btImpHoldHotel: TBitBtn;
    btChangeTourGuide: TSpeedButton;
    btUpHold: TSpeedButton;
    spUpHold: TADOStoredProc;
    spquPreSaleItemExchangeInvoice: TIntegerField;
    spquPreSaleValueNewSubTotal: TFloatField;
    btPayment: TBitBtn;
    lblTotalLine: TLabel;
    btChangeUser: TSpeedButton;
    EditInvoiceDate: TDBEdit;
    pnlSpecialDiscount: TPanel;
    btSpecialPrice: TSpeedButton;
    Label1: TLabel;
    btApplyPriceManager: TBitBtn;
    spquPreSaleItemSuggRetail: TFloatField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoIDStore: TIntegerField;
    spquPreSaleItemSerialNumber: TBooleanField;
    quPreSaleInfoAddress: TStringField;
    spquPreSaleValueTaxIsemptValue: TFloatField;
    spquPreSaleValueSubTotalTaxable: TCurrencyField;
    spquPreSaleValueTaxIsemptItemDiscount: TFloatField;
    spquPreSaleItemIDUser: TIntegerField;
    quPreSaleInfoLayaway: TBooleanField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoZip: TStringField;
    scMedia: TDBSuperComboADO;
    Label24: TLabel;
    pnlInvoiceCustomer: TPanel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label26: TLabel;
    Label27: TLabel;
    spHelp: TSpeedButton;
    quVerifyOpenHold: TADOQuery;
    quVerifyOpenHoldnOpenUser: TIntegerField;
    quVerifyOpenHoldnOpenHoldCaixa: TIntegerField;
    quPreSaleInfoPrintNotes: TBooleanField;
    dbPrintNotes: TDBCheckBox;
    grdDiscRange: TSMDBGrid;
    grdPayMin: TSMDBGrid;
    Panel6: TPanel;
    quPreSaleInfoDeliverOBS: TStringField;
    quPreSaleInfoDeliverConfirmation: TBooleanField;
    tbOtherCosts: TTabSheet;
    tbPaymentType: TTabSheet;
    Label29: TLabel;
    Label30: TLabel;
    btAddCost: TSpeedButton;
    btRemoveCost: TSpeedButton;
    grdSerial: TSMDBGrid;
    quAditionalExpenses: TADODataSet;
    dsAditinalExpenses: TDataSource;
    quAditionalExpensesCostType: TStringField;
    quAditionalExpensesIDInvoiceCost: TIntegerField;
    quAditionalExpensesIDCostType: TIntegerField;
    quAditionalExpensesAmount: TBCDField;
    editCustoUnitario: TEdit;
    scCostType: TSuperComboADO;
    spquPreSaleValueAditionalExpenses: TBCDField;
    pnlPayments: TPanel;
    pnlSpecialPrice: TPanel;
    Label2: TLabel;
    pnlTaxIsempt: TPanel;
    Label12: TLabel;
    Label22: TLabel;
    DBEdit2: TDBEdit;
    pnlSubTotalTaxable: TPanel;
    Label14: TLabel;
    Label18: TLabel;
    DBEdit1: TDBEdit;
    pnlSubTotal: TPanel;
    lblSubTotal: TLabel;
    Label23: TLabel;
    EditSubTotal: TDBEdit;
    pnlTax: TPanel;
    Label13: TLabel;
    Label20: TLabel;
    DBEdit7: TDBEdit;
    pnlOtherCosts: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    DBEdit6: TDBEdit;
    quPreSaleInfoIDFormOfPayment: TIntegerField;
    Label33: TLabel;
    Label25: TLabel;
    DBEdit3: TDBEdit;
    SubPaymentType: TSubListPanel;
    btnDoPayments: TSpeedButton;
    cbxFormOfPayment: TcxDBImageComboBox;
    pnlConfirmDeliver: TPanel;
    sbHistory: TSpeedButton;
    btSplitHold: TBitBtn;
    quPreSaleInfoIDPreSaleParent: TIntegerField;
    quPreSaleInfoSaleCode: TStringField;
    quPreSaleInfoInvoiceCode: TStringField;
    SubCustomer: TSubListPanel;
    cbxType: TComboBox;
    btCommissions: TSpeedButton;
    spquPreSaleItemSalesPerson: TStringField;
    spquPreSaleItemNotVerifyQty: TBooleanField;
    spquPreSaleItemTax: TBCDField;
    spquPreSaleItemQty: TFloatField;
    spquPreSaleItemIDDepartment: TIntegerField;
    spquPreSaleItemRequestCustomer: TBooleanField;
    spquPreSaleItemPuppyTracker: TBooleanField;
    quPreSaleInfoPuppyTracker: TBooleanField;
    spquPreSaleItemPromo: TBooleanField;
    spquPreSaleItemIDMovParent: TIntegerField;
    spquPreSaleItemCaseQty: TFloatField;
    Panel: TPanel;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsDBModelID: TcxGridDBColumn;
    grdItemsDBQty: TcxGridDBColumn;
    grdItemsDBModel: TcxGridDBColumn;
    grdItemsDBDescription: TcxGridDBColumn;
    grdItemsDBSalesPerson: TcxGridDBColumn;
    grdItemsDBTotalSalePrice: TcxGridDBColumn;
    grdItemsDBDiscount: TcxGridDBColumn;
    grdItemsDBTotalItem: TcxGridDBColumn;
    grdItemsDBTax: TcxGridDBColumn;
    grdItemsDBSerialNumber: TcxGridDBColumn;
    grdItemsDBIDInventoryMov: TcxGridDBColumn;
    grdItemsDBIDComission: TcxGridDBColumn;
    grdItemsDBCostPrice: TcxGridDBColumn;
    grdItemsDBExchangeInvoice: TcxGridDBColumn;
    grdItemsDBSuggRetail: TcxGridDBColumn;
    grdItemsDBIDUser: TcxGridDBColumn;
    grdItemsDBNotVerifyQty: TcxGridDBColumn;
    grdItemsDBIDDepartment: TcxGridDBColumn;
    grdItemsDBPromo: TcxGridDBColumn;
    grdItemsDBCaseQty: TcxGridDBColumn;
    grdItemsLevel: TcxGridLevel;
    btColumn: TSpeedButton;
    spquPreSaleValueInvoiceDiscount: TCurrencyField;
    pnlTotalDiscount: TPanel;
    lbDiscount: TLabel;
    DBEdit8: TDBEdit;
    Label36: TLabel;
    spquPreSaleValueTotalDiscount: TCurrencyField;
    pnlReturn: TPanel;
    lbReturn: TLabel;
    EditFullTotal: TSuperEditCurrency;
    edtTotalReturn: TSuperEditCurrency;
    edtDisTotalInv: TSuperEditCurrency;
    btnAddOBS: TButton;
    btnAddQuick: TSpeedButton;
    pmAddItem: TPopupMenu;
    miAddItem: TMenuItem;
    miQuickEntry: TMenuItem;
    spnSpecialDiscount: TcxSpinEdit;
    spquPreSaleItemDepartment: TStringField;
    grdItemsDBDepartment: TcxGridDBColumn;
    btnRemoveGroup: TSpeedButton;
    tsComplement: TTabSheet;
    scCFOP: TDBSuperComboADO;
    lblCFOP: TLabel;
    edtInvoiceCode: TDBEdit;
    lblInvoiceCode: TLabel;
    quInvoiceOBS: TADODataSet;
    dsInvoiceOBS: TDataSource;
    quInvoiceOBSIDPreSale: TIntegerField;
    quInvoiceOBSIDCFOP: TIntegerField;
    quInvoiceOBSIDPessoaTax: TIntegerField;
    quInvoiceOBSIDInvoiceOBS: TIntegerField;
    quInvoiceOBSIDCarrier: TIntegerField;
    quInvoiceOBSFreightType: TIntegerField;
    gbxPersonTax: TGroupBox;
    lblPessoaTax: TLabel;
    scPessoaTax: TDBSuperComboADO;
    gbxCarrier: TGroupBox;
    lbCarrier: TLabel;
    scCarrier: TDBSuperComboADO;
    scFilterPessoaTax: TSuperComboADO;
    lbFilterPersonTax: TLabel;
    lbFilterCarrier: TLabel;
    scFilterCarrier: TSuperComboADO;
    lbFreightType: TLabel;
    cbxFreightType: TComboBox;
    quInvoiceOBSIDUserDeliver: TIntegerField;
    quInvoiceOBSIDPessoaAddress: TIntegerField;
    pnlCustomerAddress: TPanel;
    lbAddress1: TLabel;
    scCustomerAddress: TDBSuperComboADO;
    pnlDeliverInfo: TPanel;
    Label6: TLabel;
    EditDelAddress: TDBEdit;
    Label34: TLabel;
    Label28: TLabel;
    edtDelOBS: TDBEdit;
    Label5: TLabel;
    EditDelDate: TDBDateBox;
    Label35: TLabel;
    btnDelivery: TBitBtn;
    lbConfirmDelivery: TLabel;
    btnEditDate: TSpeedButton;
    edtDollarDiscount: TSuperEditCurrency;
    btnRepostPuppy: TBitBtn;
    pnInfoTotal: TPanel;
    Panel11: TPanel;
    Panel14: TPanel;
    Shape5: TShape;
    Shape2: TShape;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    spquPreSaleValueTotalSaved: TCurrencyField;
    spquPreSaleItemUnitDiscount: TCurrencyField;
    grdItemsDBSalePrice: TcxGridDBColumn;
    grdItemsDBUnitDiscount: TcxGridDBColumn;
    spquPreSaleItemTotalSalePrice: TCurrencyField;
    lblItemDiscountSign: TLabel;
    lblSaleDiscountSign: TLabel;
    subTotalDisplay: TLabel;
    itemDiscountDisplay: TLabel;
    saleDiscountDisplay: TLabel;
    taxDisplay: TLabel;
    otherCostsDisplay: TLabel;
    totalInvoiceDisplay: TLabel;
    totalSavedDisplay: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddItemClick(Sender: TObject);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
    procedure btDiscountItemClick(Sender: TObject);
    procedure btRemoveItemClick(Sender: TObject);
    procedure btMakeSpecialPriceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btTaxIsentClick(Sender: TObject);
    procedure cmbSpecialDiscSelectItem(Sender: TObject);
    procedure TmrRefreshItemTimer(Sender: TObject);
    procedure spquPreSaleItemCalcFields(DataSet: TDataSet);
    procedure dsPreSaleValueDataChange(Sender: TObject; Field: TField);
    procedure btCancelClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure pgInvoiceChange(Sender: TObject);
    procedure btDetGroupClick(Sender: TObject);
    procedure quPreSaleInfoAfterOpen(DataSet: TDataSet);
    procedure quPreSaleInfoNewRecord(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spPayVisaClick(Sender: TObject);
    procedure spPayMasterClick(Sender: TObject);
    procedure spPayAmericanClick(Sender: TObject);
    procedure tbDepositExit(Sender: TObject);
    procedure btImpHoldClick(Sender: TObject);
    procedure btImpHoldHotelClick(Sender: TObject);
    procedure btChangeTourGuideClick(Sender: TObject);
    procedure scMediaSelectItem(Sender: TObject);
    procedure btUpHoldClick(Sender: TObject);
    procedure btPaymentClick(Sender: TObject);
    procedure spquPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure btChangeUserClick(Sender: TObject);
    procedure btSpecialPriceClick(Sender: TObject);
    procedure btApplyPriceManagerClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdPayMinDblClick(Sender: TObject);
    procedure cmbPayTypeSelectItem(Sender: TObject);
    procedure grdDiscRangeDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdPayMinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure scCostTypeSelectItem(Sender: TObject);
    procedure btAddCostClick(Sender: TObject);
    procedure btRemoveCostClick(Sender: TObject);
    procedure editCustoUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnDoPaymentsClick(Sender: TObject);
    procedure btnDeliveryClick(Sender: TObject);
    procedure cmbDelTypeSelectItem(Sender: TObject);
    procedure SubPaymentTypeAfterParamChanged(Changes: String);
    procedure sbHistoryClick(Sender: TObject);
    procedure btSplitHoldClick(Sender: TObject);
    procedure quPreSaleInfoDeliverDateValidate(Sender: TField);
    procedure SubCustomerAfterParamChanged(Changes: String);
    procedure cbxTypeChange(Sender: TObject);
    procedure btCommissionsClick(Sender: TObject);
    procedure grdItemsDBCustomization(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure grdItemsDBDblClick(Sender: TObject);
    procedure edtDisTotalInvCurrChange(Sender: TObject);
    procedure btnAddOBSClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure miQuickEntryClick(Sender: TObject);
    procedure spnSpecialDiscountPropertiesChange(Sender: TObject);
    procedure SubCustomerDataChange;
    procedure edtDisTotalInvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRemoveGroupClick(Sender: TObject);
    procedure scCFOPSelectItem(Sender: TObject);
    procedure scPessoaTaxSelectItem(Sender: TObject);
    procedure scFilterPessoaTaxSelectItem(Sender: TObject);
    procedure scFilterCarrierSelectItem(Sender: TObject);
    procedure quInvoiceOBSBeforePost(DataSet: TDataSet);
    procedure quInvoiceOBSAfterOpen(DataSet: TDataSet);
    procedure cbxFreightTypeChange(Sender: TObject);
    procedure quPreSaleInfoBeforeClose(DataSet: TDataSet);
    procedure scCustomerAddressSelectItem(Sender: TObject);
    procedure btnEditDateClick(Sender: TObject);
    procedure btRefundClick(Sender: TObject);
    procedure edtDollarDiscountKeyPress(Sender: TObject; var Key: Char);
    procedure edtDollarDiscountCurrChange(Sender: TObject);
    procedure btnRepostPuppyClick(Sender: TObject);
  private
    //Translation
    sChangePrice,
    sApplyPrice,
    sCopyHold,
    sCopyInvoice,
    sInvNum,
    sNewHold,
    sLayawayNum,
    sHoldNum,
    sHold,
    sFinalizar,
    sReceive,
    sClose,
    sRestorTax,
    sExemptTax,
    sItems,
    sPayNow,
    sPayLater,
    sDeliveryConf,
    sDeliveryNConf,
    sDeliveryOK,
    sJunction,
    sInvNumText : String;

    sSaleCode : String;

    fShowTabPaymentType : Boolean;
    IsNewPreSale : Boolean;
    bIsExchangeItem : Boolean;
    FScreenType : Integer;

    IsPrintReceipt : Boolean;
    iReceiptType : Integer;

    IsFirst   : Boolean;
    IsInvoice : Boolean;
    IsLayaway  : Boolean;
    IsGenericIDPessoa : Boolean;
    StatusUser, HlpContext : Integer;
    IDPreSale    : Integer;
    OldMedia     : Integer;
    OldTag : Integer;
    FrmPreSaleItem : TFrmPreSaleItem;
    FrmAddInvoiceOBS: TFrmAddInvoiceOBS;
    FrmAddItems : TFrmAddItems;
    MyPreSaleType, MyIDCashRegMov  : Integer;
    OldRefreshInvoice : Integer;
    MaxVendaMin : Double;
    fCustomerAddress : String;
    fTotalReturn : Currency;
    fIDItemsReturnList : TStringList;

    ApplyAll : Boolean;
    FPaymentChange: Double;
    AView    : TcxCustomGridTableView;
    fRegistryPath : String;
    AOptions: TcxGridStorageOptions;

    fInfocash: InfoCashSale;

    procedure showTotalInvoice();

    //Antonio M F Souza May 31, 2012 - to set signal to discounts
    procedure setSignalDiscount(pHasSaleDiscount, pHasItemDiscount, prefund: boolean);

    procedure GetCustomer;
    procedure AtuDescTourist;
    procedure ShowDiscRanges;
    function  TestUserComission : Boolean;
    procedure AtuPreSaleControls;
    procedure RefreshInfo(AIdPreSale: Integer);
    procedure RefreshItem(PreInventMovID : Integer);
    procedure RefreshValue;
    procedure CreateParams( var Params: TCreateParams ); override;
    procedure SetTaxIsention(Force : Boolean);
    procedure CanCreateHoldNum;
    procedure RefreshPasswordOption;

    procedure RefreshDeliveryInfo;
    function GetLayawayBalance: Currency;
    function DoPay: Boolean;
    function ValidadeHold: Boolean;
    function ValidateInvoiceDiscount(ADiscount: Currency): Boolean;
    function ValidateDiscountPercente(ADiscount: Currency): Boolean;

    procedure OpenInvCosts;
    procedure CloseInvCosts;
    procedure RefreshInvCosts;
    procedure OpenInvOBS;
    procedure CloseInvOBS;
    procedure RefreshInvOBS;
    procedure RefreshInvPayments;
    procedure UpdateCommissions;

    //Pay Min
    procedure OpenPayMin;
    procedure ClosePayMin;
    procedure RefreshPayMin;

    procedure LoadImages;
    procedure ShowTabs;
    procedure FinalizeHold(bCloseForm: Boolean);
    procedure CanFinalizeLayaway;
    function IsDeliveryEnabled: Boolean;
    procedure SetToHold;
    procedure ShowDivideHold(IDPreSale: Integer;sCustomerName: String);
    function GetIsChield: Boolean;
    procedure ShowChildControls;
    function CanSplit: Boolean;

    procedure PrintReceipt(iPrinType : Integer; arg_objInfocash: InfoCashSale = nil);
    procedure SetCustomerProperties;

    procedure UpdateTouristChildGroup(IDTrouristGroup : Integer);

    procedure CallEstimatedPayment;
    procedure RefreshCustomerAddress(IDCustomer : Integer);

    function ProcessInvoiceBonus : Boolean;
  public
    procedure Start(PreSaleNumber, PreSaleType, IDCashRegMov : Integer; IsNew : Boolean);
    property IsChield : Boolean read GetIsChield;
  end;

var
  SpecialPrice : Integer;

implementation

uses uDM, uMakeSpcPrice, uTaxIsent, uPassword, uSetDelPreSaleDate, uSystemConst,
     uFrmSerialNumber, uFchTouristGroup, uPreSaleReceive, uFrmChangeTourGroup,
     uAskManager, uFchPessoa, uInvoicePayment, uMsgBox, uMsgConstant, uCharFunctions,
     uNumericFunctions, uSystemTypes, uDateTimeFunctions, uDMGlobal, uParamFunctions,
     uFrmHistoryManage, uSplitPreSale, DateUtils, uFileFunctions, uFrmAddItemCommission,
     uSelectDepartment, uHandleError, uBonusBucks, Math, uFrmEstimatedInfo,
     uFrmInvoiceRefund, MRPuppyIntegrationCls, uDebugFunctions, uInvoiceInfo;

{$R *.DFM}

procedure TFrmInvoice.LoadImages;
begin
  dm.imgBTN.GetBitmap(BTN_REPOST_PUPPY, btnRepostPuppy.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADD, btAddItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDiscountItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemoveItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_REFRESH, btUpHold.Glyph);
  DM.imgBTN.GetBitmap(BTN_KEY, btChangeUser.Glyph);
  DM.imgBTN.GetBitmap(BTN_PRINT, btImpHold.Glyph);
  DM.imgBTN.GetBitmap(BTN_PRINT, btImpHoldHotel.Glyph);
  DM.imgBTN.GetBitmap(BTN_HISTORY, sbHistory.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btSplitHold.Glyph);
  DM.imgBTN.GetBitmap(BTN_USER, btCommissions.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btnRemoveGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDetGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADD, btChangeTourGuide.Glyph);
  DM.imgBTN.GetBitmap(BTN_RESTORE, btRefund.Glyph);

  DM.imgSmall.GetBitmap(BTN18_LAMP,btSpecialPrice.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnEditDate.Glyph);
end;

procedure TFrmInvoice.ClosePayMin;
begin
  with quPayMin do
    if Active then
      Close;
end;

procedure TFrmInvoice.RefreshPayMin;
begin
  ClosePayMin;

  if cmbPayType.LookUpValue <> '' then
  begin
    quPayMin.Parameters.ParambyName('IDMeioPag').Value := MyStrToInt(cmbPayType.LookUpValue);
    OpenPayMin;
  end;
end;

procedure TFrmInvoice.OpenPayMin;
begin
  with quPayMin do
    if not Active then
      Open;
end;

procedure TFrmInvoice.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams(Params);
  Params.Style := WS_THICKFRAME or WS_POPUP or WS_BORDER;
end;

procedure TFrmInvoice.Start(PreSaleNumber, PreSaleType, IDCashRegMov : Integer; IsNew : Boolean);
var
  Action : TCloseAction;
  iOpenHoldCaixa, iOpenHold : integer; //OpenHolds
begin
  IDPreSale       := PreSaleNumber;
  MyPreSaleType   := PreSaleType;

  MyIDCashRegMov  := IDCashRegMov;
  IsNewPreSale    := IsNew;

  fInfoCash := InfocashSale.Create;

  if DM.fPOS.fCommisList = Nil then
    DM.fPOS.fCommisList := TStringList.Create;

  ApplyAll := False;

  {if not FIsNew then
   begin
    AddCommissionsList;
    if fCommisList <> Nil then
       if fCommisList.Count > 1 then
          ModifytoCommissions;
   end; }

  IsFirst := True;

  // Desabilita refresh do timer
  TmrRefreshItem.Enabled := False;

  OldRefreshInvoice := 0;

  //PreSale Estatico
  RefreshInfo(idPreSale);

  IsInvoice := (quPreSaleInfoIDInvoice.AsString <> '');
  IsLayaway  := quPreSaleInfoLayaway.AsBoolean;
  IsGenericIDPessoa := (quPreSaleInfoIDCustomer.AsInteger = 1);

  // PreSale Items
  RefreshItem(0);

  setSignalDiscount((spquPreSaleValueInvoiceDiscount.Value > 0), (spquPreSaleValueTotalDiscount.Value > 0), (spquPreSaleItemQty.Value < 0));

  if (spquPreSaleItem.RecordCount > 0) and (not IsInvoice) then
  begin
    //PollDisplay
    DM.PollDisplayCloseSale;
    DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                          Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                          spquPreSaleValueAditionalExpenses.AsCurrency,
                          spquPreSaleValueTotalDiscount.AsCurrency,
                          spquPreSaleValueTax.AsCurrency,
                          spquPreSaleValueSubTotal.AsCurrency);

    DM.PollDisplayOpenHoldItems(spquPreSaleItem);
  end;

  StatusUser := 0;

  // Teste se deve mostrar o combo de other cost
  pnlOther.Visible := (PreSaleType = SALE_CASHREG);

  if not IsInvoice then
  begin
    TmrRefreshItem.Enabled := True;

    //Testa se o Hold esta aberto
    with quVerifyOpenHold do
    begin
      if Active then
        Close;

      Parameters.ParambyName('IDPreSale').Value := IDPreSale;
      Open;

      iOpenHoldCaixa := quVerifyOpenHoldnOpenHoldCaixa.AsInteger;
      iOpenHold      := quVerifyOpenHoldnOpenUser.AsInteger;

      Close;
    end;

    //Atualiza o qty no OpenHold
    //Hold esta sendo aberto no Caixa
    case MyPreSaleType of
      SALE_CASHREG:
      begin
        try
          DM.ADODBConnect.BeginTrans;

          with DM.quFreeSQL do
          begin
            if Active then
              Close;
            SQL.Clear;
            SQL.Add('UPDATE Invoice');
            SQL.Add('SET nOpenHoldCaixa = ' + IntToStr(iOpenHoldCaixa+1) );
            SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
            ExecSQL;
          end;

          DM.ADODBConnect.CommitTrans;
        except
          DM.ADODBConnect.RollbackTrans;
        end;
      end;

      //Hold esta sendo aberto in PreSale
      SALE_PRESALE:
      begin
        try
          DM.ADODBConnect.BeginTrans;

          with DM.quFreeSQL do
          begin
            if Active then
              Close;
            SQL.Clear;
            SQL.Add('UPDATE Invoice');
            SQL.Add('SET nOpenUser = ' + IntToStr(iOpenHold+1) );
            SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
            ExecSQL;
          end;

          DM.ADODBConnect.CommitTrans;
        except
          DM.ADODBConnect.RollbackTrans;
        end;
      end;

      SALE_CANCELED:
      begin
      end;
    end; //end Case

    //Se o hold estiver sendo usado, ele chama o evento onClose do form
    //OnClose - Fecha todas as Queries e atualza a qty OpenUser
    if iOpenHoldCaixa > 0 then
    begin
      MessageBeep(MB_ICONASTERISK);
      MsgBox(MSG_INF_HOLD_PAYING, vbOKOnly + vbInformation);
      FormClose(nil, Action);
      Exit;
    end;

    if iOpenHold > 0 then
    begin
      MessageBeep(MB_ICONASTERISK);
      if (PreSaleType = SALE_CASHREG) then //foi aberto pelo caixa
      begin
        MsgBox(MSG_INF_HOLD_IS_LOCK, vbOKOnly + vbInformation);
        FormClose(nil, Action);
        Exit;
      end
      else begin
        //foi aberto por outro hold
        //No needs any more MsgBox(MSG_INF_HOLD_IS_USING, vbOKOnly + vbInformation);
        ;
      end;

      MyPreSaleType := SALE_PRESALE;
    end;
  end; //end else IsNotInvoice

  // Teste se venda e para Media que isenta taxa automatica
  SetTaxIsention(False);

  // Prepara Controles levando em conta se e master/slave ou Invoice
  AtuPreSaleControls;

  //Mostra os Tab do invoice
  ShowTabs;

  CanFinalizeLayaway;

  // Desabilita edição, caso seja um PreSale Filho
  ShowChildControls;

  //Inicializa no OtherCosts
  if tbOtherCosts.TabVisible then
    pgInvoice.ActivePage := tbOtherCosts;

  if tsComplement.TabVisible then
  begin
    scFilterCarrier.LookUpValue := DM.FMainRetailConfig.ReadString('Sale', 'CarrierFilter', '');
    scCFOP.LookUpValue          := DM.FMainRetailConfig.ReadString('Sale', 'CFOP', '');
    scFilterCarrierSelectItem(Self);
  end;

  btnRepostPuppy.Visible := ( DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] = 'True' );

  ShowModal;

  if tsComplement.TabVisible then
  begin
    DM.FMainRetailConfig.WriteString('Sale', 'CarrierFilter', scFilterCarrier.LookUpValue);
    DM.FMainRetailConfig.WriteString('Sale', 'CFOP', scCFOP.LookUpValue);
  end;

end;

procedure TFrmInvoice.FormShow(Sender: TObject);
begin
  inherited;
  OldTag          := 0;
  WindowState     := wsNormal;
  OldMedia        := MyStrToInt(scMedia.LookUpValue);
  bIsExchangeItem := False;

  if DM.fCashRegister.IDMedia <> -1 then
    scMedia.Enabled := False;

  // Seta as coordenadas iniciais
  //  Height := Screen.Height;
  //  Width  := Screen.Width;
  //Left   := 0;
  //Top    := 0;


  RefreshPasswordOption;

  // Seta o Media
  //EditMedia.Text := DM.DescCodigo(['IDMedia'], [quPreSaleInfoMediaID.AsString], 'Media', 'Media');

  if not quPreSaleInfoNote.IsNull then
    pgInvoice.ActivePage := tbNote;

  //Refresh na pgControl
  pgInvoiceChange(Nil);

  //Display invoices info
  if quPreSaleInfoSaleCode.AsString = '' then
    lblSubMenu.Caption := sNewHold
  else
    if IsInvoice then
      lblSubMenu.Caption := sInvNum + quPreSaleInfoInvoiceCode.AsString
    else if IsLayaway then
      lblSubMenu.Caption := sLayawayNum + quPreSaleInfoSaleCode.AsString
    else
      lblSubMenu.Caption := sHoldNum+ quPreSaleInfoSaleCode.AsString;

  CalcLabelMenuLength;
  AtuDescTourist;

  //Antonio M F Souza 03.18.2011
  edtDisTotalInv.DisplayFormat := dm.FQtyDecimalFormat;
  self.BorderIcons := [biSystemMenu];
  self.BorderStyle := bsSingle;

  // Antonio 2104 Jun 17
  showTotalInvoice();
end;

procedure TFrmInvoice.btCloseClick(Sender: TObject);
begin
  if ((MyPreSaleType = SALE_PRESALE) or (MyPreSaleType = SALE_CASHREG)) and Password.HasFuncRight(91) then
    CallEstimatedPayment
  else
    FinalizeHold(True);
end;

procedure TFrmInvoice.FinalizeHold(bCloseForm: Boolean);
begin
  if (btClose.Tag = 1) and (spquPreSaleItem.IsEmpty) then
  begin
    MsgBox(MSG_CRT_NO_ITEM_PAY, vbOKOnly + vbInformation);
    Exit;
  end;

  // Teste se todos os serial numbers foram preenchidos
  // Rodrigo fazer o teste no hold e no Sales
  if (MyPreSaleType = SALE_PRESALE) or (MyPreSaleType = SALE_CASHREG) then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('SELECT IDPreInventoryMov ');
      SQL.Add('FROM	PreInventoryMov PIM (NOLOCK) ');
      SQL.Add('LEFT OUTER JOIN PreSerialMov PSM (NOLOCK) ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
      SQL.Add('JOIN Model M ON (PIM.ModelID = M.IDModel)');
      SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
      SQL.Add('WHERE TG.SerialNumber = 1');
      SQL.Add('AND PIM.UserID = ' + IntToStr(DM.fUser.ID));
      SQL.Add('AND  PIM.DocumentID = ' + quPreSaleInfoIDPreSale.AsString);
      SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
      SQL.Add('HAVING COUNT(PSM.SerialNumber) < ABS(PIM.Qty)');
      Open;

      if not IsEmpty then
      begin
        MsgBox(MSG_CRT_NO_SERIAL_NUMBER, vbCritical + vbOkOnly);
        Close;
        Exit;
      end;

      Close;
    end;
  end;

  // So atualiza se for Master
  if (StatusUser = 0) then
  begin
    //Criar novo numero para hold
    CanCreateHoldNum;

    SetCustomerProperties;

    if (quPreSaleInfo.State in dsEditModes) then
    begin
      quPreSaleInfo.UpdateRecord;
      quPreSaleInfo.Post;
    end;

    if (quInvoiceOBS.State in dsEditModes) then
    begin
      quInvoiceOBS.UpdateRecord;
      quInvoiceOBS.Post;
    end;

    // Desliga o timer
    tmrRefreshItem.Enabled := False;

    btClose.visible   := False;
    btCancel.visible  := False;
    btPayment.visible := False;

    if MyPreSaleType = SALE_CASHREG then
    begin
      if btClose.Tag = 3 then
      begin
        //Finaliza o Layaway
        if not DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE] then
        begin
          DoPay;
          Self.Close;
          Exit;
        end
        else
        begin
          // Pôe para Hold
          SetToHold;
          Exit;
        end;
      end;

      with TPreSaleReceive.Create(Self) do
      begin
        IsPrintReceipt := Start(quPreSaleInfo, spquPreSaleValue, spquPreSaleItem, MyIDCashRegMov, IsLayaway, bCloseForm, cbxFormOfPayment.ItemIndex, 0, FPaymentChange);
        if IsPrintReceipt then
        begin
          iReceiptType   := RECEIPT_TYPE_INVOICE;
          if bCloseForm then
            Self.Close;
        end;
      end;
    end;

    if ((FScreenType = CASHREG_TYPE_OFFICE) and (not tbPaymentType.TabVisible)
       and (sSaleCode <> '') and (MyPreSaleType <> SALE_CASHREG)) then
      MsgBox(sHoldNum + ' ' +sSaleCode, vbOKOnly + vbInformation);

    btClose.visible  := not (fShowTabPaymentType and IsLayaway);
    btCancel.visible := True;
    btPayment.visible := IsInvoice or IsLayaway;
  end;

  if (MyPreSaleType <> SALE_CASHREG) and bCloseForm then
    Close;
end;

procedure TFrmInvoice.ShowTabs;
begin
  fShowTabPaymentType      := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_PAYMENTS];
  FScreenType              := DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE];

  tbPaymentType.TabVisible := (fShowTabPaymentType and IsLayaway);
  tbTourist.TabVisible     := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_AGENTS];
  tbDeposit.TabVisible     := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DEPOSIT_DATE];
  tbDiscount.TabVisible    := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DISCOUNT];

  if tbDiscount.TabVisible then
  begin
    if ( edtDollarDiscount.Text <> '0.00' ) then
       edtDollarDiscount.Clear;

    if ( edtDisTotalInv.Text <> '0.00' ) then
       edtDisTotalInv.Clear;

    pnlSpecialDiscount.Visible := False;
    btSpecialPrice.Down := False;
  end;

  tbDeliver.TabVisible     := (DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DELIVERY]);
  tbOtherCosts.TabVisible  := (DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_OTHER_COSTS]);
  tsComplement.TabVisible  := (DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_COMPLEMENT]);

  if (FScreenType = CASHREG_TYPE_OFFICE) and (MyPreSaleType = SALE_PRESALE) then
  begin
    tbDeliver.TabVisible     := (DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DELIVERY] and tbPaymentType.TabVisible);
    tbOtherCosts.TabVisible  := (DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_OTHER_COSTS] and tbPaymentType.TabVisible);
  end;
end;

procedure TFrmInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  IsPrintReceipt := False;
  iReceiptType   := RECEIPT_TYPE_HOLD;
  TmrRefreshItem.Enabled  := False;
  TmrRefreshItem.Interval := DM.fSystem.SrvParam[PARAM_REFRESHINTERVAL];
  FrmPreSaleItem := TFrmPreSaleItem.Create(Self);
  SubCustomer.CreateSubList;
  fIDItemsReturnList := TStringList.Create;

  SpecialPrice := 0;

  if tbDiscount.TabVisible then
    pgInvoice.ActivePage := tbDiscount;

  case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sChangePrice   := '&Change Special Price';
           sApplyPrice    := 'A&pply Special Price';
           sCopyHold      := 'Copy of Hold';
           sCopyInvoice   := 'Copy of Invoice';
           sInvNum        := 'Invoice # ';
           sNewHold       := 'New Hold';
           sLayawayNum    := 'Layaway hold # ';
           sHoldNum       := 'Hold # ';
           sHold          := '&Hold';
           sFinalizar     := '&Finalize';
           sReceive       := '&Receive';
           sClose         := 'Close';
           sRestorTax     := 'Restore &Tax';
           sExemptTax     := '&Tax Exempt';
           sItems         := ' Items';
           sPayNow        := 'Now';
           sPayLater      := 'Later';
           sDeliveryConf  := 'Confirm Delivery';
           sDeliveryNConf := 'Cancel Delivery';
           sDeliveryOK    := 'Delivery Confirmed';
           sJunction      := 'Junction with Hold # ';
           sInvNumText    := 'Enter invoice refund number';
           end;

     LANG_PORTUGUESE :
           begin
           sChangePrice   := 'Mudar &Preço Especial';
           sApplyPrice    := 'A&plicar Preço Especial';
           sCopyHold      := 'Cópia do Pedido';
           sCopyInvoice   := 'Cópia da Nota';
           sInvNum        := 'Nº Nota ';
           sNewHold       := 'Novo Pedido';
           sLayawayNum    := 'Nº Pedido ';
           sHoldNum       := 'Nº Pedido ';
           sHold          := 'Re&ter';
           sFinalizar     := '&Finalizar';
           sReceive       := '&Receber';
           sClose         := 'Fechar';
           sRestorTax     := 'Restaurar Impos&to';
           sExemptTax     := 'Isentar Impos&to';
           sItems         := ' Itens';
           sPayNow        := 'À vista';
           sPayLater      := 'A Prazo';
           sDeliveryConf  := 'Confirmar Entrega';
           sDeliveryNConf := 'Desmarcar Entrega';
           sDeliveryOK    := 'ENTREGA CONFIRMADA';
           sJunction      := 'Junção com o Pedido Nº ';
           sInvNumText    := 'Informe o nº da nota de troca';
           end;

     LANG_SPANISH :
           begin
           sChangePrice   := 'Cambiar &Precio Especial';
           sApplyPrice    := 'A&plicar Precio Especial';
           sCopyHold      := 'Copia de Boleta Pendiente';
           sCopyInvoice   := 'Copia de Boleta';
           sInvNum        := 'Boleta # ';
           sNewHold       := 'Nuevo Boleto';
           sHoldNum       := 'Boleta Pend # ';
           sLayawayNum    := 'Crédito # ';
           sHold          := '&Retener';
           sFinalizar     := '&Fin';
           sReceive       := '&Recibir';
           sClose         := 'Cerrar';
           sRestorTax     := 'Res&tablecer Impuesto';
           sExemptTax     := 'Exen&tar Impuesto';
           sItems         := ' Items';
           sPayNow        := 'Ahora';
           sPayLater      := 'Luego';
           sDeliveryConf  := 'Entrega Confirmó';
           sDeliveryNConf := 'Entrega Canceló';
           sDeliveryOK    := 'Confirmó Entrega';
           sJunction      := 'El empalme con Boleta Nº ';
           sInvNumText    := 'Informe o # da nota de troca';
           end;
   end;

  cbxFormOfPayment.Properties.Items.Items[0].Description := sPayNow;
  cbxFormOfPayment.Properties.Items.Items[1].Description := sPayLater;

  AView := TcxCustomGridTableView(grdItems.FocusedView);
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
    TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  grdItemsDBTax.Visible := not DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
  //grdItems.Columns[7].Visible := not DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
  //Panel5.Visible := not DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];

  btImpHoldHotel.Visible := (FScreenType <> CASHREG_TYPE_OFFICE);

  // preparando formatação de acordo com o servidor.

  edtDisTotalInv.DisplayFormat := DM.FQtyDecimalFormat;
  editFullTotal.DisplayFormat := DM.FQtyDecimalFormat;
  edtTotalReturn.DisplayFormat := DM.FQtyDecimalFormat;
  edtDollarDiscount.DisplayFormat := DM.FQtyDecimalFormat;

end;

procedure TFrmInvoice.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmPreSaleItem.Free;
  fIDItemsReturnList.Free;
  FreeAndNil(FrmAddInvoiceOBS);
  freeAndNil(fInfoCash);
end;

procedure TFrmInvoice.FormClose(Sender: TObject; var Action: TCloseAction);
var
  bEmpty : Boolean;
  iOpenHoldCaixa, iOpenHold : integer; //Open Holds
begin
  inherited;
  Screen.Cursor := crHourGlass;

  // Desabilita refresh do timer
  TmrRefreshItem.Enabled := False;

  with quPreSaleInfo do
  begin
    if Active and (State in dsEditModes) then
      Cancel;
    Close;
  end;

  spquPreSaleValue.Close;
  spquPreSaleItem.Close;

  // Fecha Query dos ranges
  with quDiscRange do
    if Active then Close;

  with quPayMin do
    if Active then Close;

  if (not IsInvoice) then
  begin
    with quVerifyOpenHold do
    begin
      if Active then
            Close;

         Parameters.ParambyName('IDPreSale').Value := IDPreSale;
         Open;

         iOpenHoldCaixa := quVerifyOpenHoldnOpenHoldCaixa.AsInteger;
         iOpenHold      := quVerifyOpenHoldnOpenUser.AsInteger;

         Close;
         end;


     //Atualiza o qty No Hold
     Case MyPreSaleType of
        SALE_CASHREG : begin //Hold esta sendo aberto no Caixa
                       try
                          DM.ADODBConnect.BeginTrans;

                          with DM.quFreeSQL do
                             begin
                             If Active then
                                Close;
                             SQL.Clear;
                             SQL.Add('UPDATE Invoice');
                             SQL.Add('SET nOpenHoldCaixa = ' + IntToStr(iOpenHoldCaixa-1) );
                             SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                             ExecSQL;
                             end;

                          DM.ADODBConnect.CommitTrans;

                       except
                          DM.ADODBConnect.RollbackTrans;
                          Exit;
                          end;
                        end;

        SALE_PRESALE : begin //Hold esta sendo aberto in PreSale
                       try
                          DM.ADODBConnect.BeginTrans;

                          with DM.quFreeSQL do
                             begin
                             If Active then
                             Close;
                             SQL.Clear;
                             SQL.Add('UPDATE Invoice');
                             SQL.Add('SET nOpenUser = ' + IntToStr(iOpenHold-1) );
                             SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                             ExecSQL;
                             end;

                          DM.ADODBConnect.CommitTrans;

                          except
                             DM.ADODBConnect.RollbackTrans;
                             Exit;
                             end;
                      end;
        SALE_CANCELED : begin
                        end;
        end; //end Case
     end; //end if IsNotInvoice

  //Rodrigo somente se for Hold
  If MyPreSaleType = SALE_PRESALE then
     begin
     //Rodrigo - Verificar se o hold esta vazio
     with spquPreSaleItem do
        begin
        Close;
        Parameters.ParambyName('@DocumentID').Value := IDPreSale;
        Parameters.ParambyName('@IsPreSale').Value  := True;
        Parameters.ParambyName('@Date').Value       := Now;
        Open;
        end;

      bEmpty := spquPreSaleItem.IsEmpty;

     If bEmpty then
        DM.fPOS.DeleteHold(IDPreSale, DM.fUser.ID);

     end;

  Screen.Cursor := crDefault;

  DM.fPOS.ClearCommissionList;
  FreeAndNil(DM.fPOS.fCommisList);

  if IsPrintReceipt then
    PrintReceipt(iReceiptType, fInfoCash);

  //Poll Display
  DM.PollDisplayCloseSale;


end;

procedure TFrmInvoice.btAddItemClick(Sender: TObject);
var
   PreInventMovID : Integer;
begin
  inherited;
  // Inclui novo item
//  TmrRefreshItem.Enabled := False;

  //Verificar se pode incluir item do pedido na edicao
  if (not Password.HasFuncRight(80)) and (not IsNewPreSale) then
  begin
    MsgBox(MSG_INF_NOT_ADD_ITEMS_SALE, vbOKOnly + vbInformation);
    Exit;
  end;

  if TestUserComission then
     FrmPreSaleItem.Start(IDPreSale, PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem, spquPreSaleValue,
                          IsNewPreSale, 0);

  if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
     (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoPuppyTracker.AsBoolean := DM.SaleHavePuppyTrackerItem(IDPreSale);
    end;

  CanFinalizeLayaway;
  grdItems.SetFocus;

  if pgInvoice.ActivePage = tbDiscount then
    ShowDiscRanges;

end;

procedure TFrmInvoice.dsPreSaleItemDataChange(Sender: TObject; Field: TField);
var
   IsEnabled : Boolean;
begin
  inherited;

  IsEnabled := not (spquPreSaleItem.Bof and spquPreSaleItem.Eof);
  btSerial.Enabled       := IsEnabled and spquPreSaleItemSerialNumber.AsBoolean;
  if ((StatusUser = 0) and not IsInvoice) then
  begin
    btRemoveItem.Enabled   := IsEnabled;
    btDiscountItem.Enabled := IsEnabled;
  end;
  btSplitHold.Visible    := (not IsInvoice) and (not IsChield);
end;

procedure TFrmInvoice.RefreshItem(PreInventMovID : Integer);
begin

  Screen.Cursor := crHourGlass;

  fTotalReturn := 0;
  fIDItemsReturnList.Clear;

  with spquPreSaleItem do
    begin
       Close;
       if IsInvoice then
          Parameters.ParambyName('@DocumentID').Value := quPreSaleInfoIDInvoice.AsInteger
       else
          Parameters.ParambyName('@DocumentID').Value := IDPreSale;

       Parameters.ParambyName('@IsPreSale').Value     := not IsInvoice;
       Parameters.ParambyName('@Date').Value          := Now;
       Open;
       if PreInventMovID <> 0 then
          Locate('IDInventoryMov', IntToStr(PreInventMovID), []);
    end;

{  if (SpecialPrice > 0) and (spquPreSaleItemDiscount.Value = 0) then
     begin
       tmrRefreshItem.enabled := False;
       MsgBox ('Cannot sell below cost price', vbOkOnly + vbExclamation);
       tmrRefreshItem.enabled := True;
     end;}

  RefreshValue;

  Screen.Cursor := crDefault;
end;

procedure TFrmInvoice.btDiscountItemClick(Sender: TObject);
Var
PreInventMovID : Integer;
begin
  inherited;
//  TmrRefreshItem.Enabled := False;

  if spquPreSaleItem.IsEmpty then
     Exit;

  //Verificar se pode incluir item do pedido na edicao
  if (not Password.HasFuncRight(81)) and (not IsNewPreSale) then
  begin
    MsgBox(MSG_INF_NOT_EDIT_ITEMS_SALE, vbOKOnly + vbInformation);
    Exit;
  end;

  if TestUserComission then
    begin
     if (spquPreSaleItemIDComission.AsInteger <> DM.fUser.IDCommission) then
      begin
        if not Password.HasFuncRight(14) then
          begin
            MsgBox(MSG_INF_NOT_CHANGE_ITEMS, vbOKOnly + vbInformation);
            Exit;
          end
      end;

     // Muda desconto novo item
     PreInventMovID := spquPreSaleItemIDInventoryMov.AsInteger;
     FrmPreSaleItem.QuSerialMov.Close;
     FrmPreSaleItem.QuSerialMov.Parameters.Items[0].Value := PreInventMovID;
     FrmPreSaleItem.QuSerialMov.Open;

     FrmPreSaleItem.Start(IDPreSale, PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem, spquPreSaleValue, IsNewPreSale,
                          spquPreSaleItem.FieldByName('IDDepartment').AsInteger);

    end;

  grdItems.SetFocus;
  CanFinalizeLayaway;
  RefreshItem(0);

  if pgInvoice.ActivePage = tbDiscount then
    ShowDiscRanges;

  if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
     (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoPuppyTracker.AsBoolean := DM.SaleHavePuppyTrackerItem(IDPreSale);
    end;
end;

procedure TFrmInvoice.btRemoveItemClick(Sender: TObject);
var
  Msg : String;
  iError, iIDInvMov : Integer;
begin
  inherited;

  //Verificar se pode deletar Layaway
  if quPreSaleInfoLayaway.AsBoolean then
     if (not Password.HasFuncRight(42)) and (not IsNewPreSale) then
       begin
       MsgBox(MSG_INF_NOT_DEL_ITEMS_LAYAWAY, vbOKOnly + vbInformation);
       Exit;
       end;

  //Verificar se pode deletar item do pedido.
  if not quPreSaleInfoLayaway.AsBoolean then
  if (not Password.HasFuncRight(66)) then//and IsNewPreSale then
    begin
      MsgBox(MSG_INF_NOT_DEL_ITEMS_SALE, vbOKOnly + vbInformation);
      Exit;
    end;

  //Verificar se pode incluir item do pedido na edicao
  if (not Password.HasFuncRight(82)) and (not IsNewPreSale) then
  begin
    MsgBox(MSG_INF_NOT_DEL_ITEMS_SALE, vbOKOnly + vbInformation);
    Exit;
  end;

  //O Comissionamento nao esta sendo feita mais assim
  {
  if (spquPreSaleItemIDComission.AsInteger <> DM.fUser.IDCommission) then
    begin
     if not Password.HasFuncRight(15) then
       begin
       MsgBox(MSG_INF_NOT_DELETE_ITEMS, vbOKOnly + vbInformation);
       Exit;
       end
    end;
  }

  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
    begin

    Screen.Cursor := crHourGlass;

    iIDInvMov := spquPreSaleItemIDInventoryMov.AsInteger;

    DM.fPOS.DeleteHoldItem(IDPreSale,
                           spquPreSaleItemIDInventoryMov.AsInteger,
                           spquPreSaleItemModelID.AsInteger,
                           DM.fUser.ID,
                           spquPreSaleItemQty.AsFloat,
                           spquPreSaleItemDiscount.AsFloat,
                           spquPreSaleItemSalePrice.AsFloat,
                           False, False, Password.HasFuncRight(9), Now, iError);

     if iError <> 0  then
        begin
        if (Password.HasFuncRight(9)) then
           Msg := MSG_QST_DISCOUNT_REACHED
        else
           Msg := MSG_QST_ERASE_ALL_DISCOUNT;

        if MsgBox(Msg, vbYesNo + vbQuestion) = vbYes then
           DM.fPOS.DeleteHoldItem(IDPreSale,
                                  spquPreSaleItemIDInventoryMov.AsInteger,
                                  spquPreSaleItemModelID.AsInteger,
                                  DM.fUser.ID,
                                  spquPreSaleItemQty.AsFloat,
                                  spquPreSaleItemDiscount.AsFloat,
                                  spquPreSaleItemSalePrice.AsFloat,
                                  (not Password.HasFuncRight(9)),
                                  Password.HasFuncRight(9), Password.HasFuncRight(9), Now, iError);
        end;

        
    RefreshItem(0);
    
    //PollDisplay
    DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                          Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                          spquPreSaleValueAditionalExpenses.AsCurrency,
                          spquPreSaleValueTotalDiscount.AsCurrency,
                          spquPreSaleValueTax.AsCurrency,
                          spquPreSaleValueSubTotal.AsCurrency,
                          True);
     DM.PollDisplayDeleteItem(iIDInvMov);



    if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
       (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoPuppyTracker.AsBoolean := DM.SaleHavePuppyTrackerItem(IDPreSale);
    end;

    Screen.Cursor := crDefault;
    CanFinalizeLayaway;

    if pgInvoice.ActivePage = tbDiscount then
      ShowDiscRanges;

    end;

  //Atualiza o impost ST
  if DM.fSystem.SrvParam[PARAM_ENABLE_INDUSTRY_OPTION] then
    DM.CalcularImpostoST(quPreSaleInfoIDPreSale.AsInteger);

  grdItems.SetFocus;
end;

procedure TFrmInvoice.btMakeSpecialPriceClick(Sender: TObject);
begin
  inherited;

  // ** remove o special price do manager
  btSpecialprice.Down := false;
  btSpecialPriceclick(nil);

  // Chama special Prices
  with TFrmMakeSpcPrice.Create(Self) do
    begin
      if Start(IDPreSale, spquPreSaleValueSpecialPriceID.AsInteger) then
         RefreshItem(0);
    end;

  grdItems.SetFocus;
end;

procedure TFrmInvoice.FormActivate(Sender: TObject);
begin
  inherited;
  if IsFirst then
    begin
      IsFirst := False;

      case MyPreSaleType of

        SALE_PRESALE : begin // PreSale em modo PreSale (nao caixa)
                         btClose.Caption  := sHold;
                         btClose.Visible  := True;
                         //if IsLayaway then
                         btCancel.Visible := True;
                         btClose.Tag      := 0;
                         //Nao pode receber pagamentos aqui
                         btnDoPayments.Enabled := False;
                         btnDoPayments.Visible := False;
//                         showMessage('presale');
                       end;

        SALE_CASHREG : begin //Aberto no caixa
                         btCancel.Visible := True;
                         btCancel.Caption := sHold;
//                         showMessage('cashreg');
                         if StatusUser = 1 then
                           begin
                            btClose.Caption  := sHold;
                            btCancel.Visible := False;
                            btClose.Tag      := 0;
                           end
                         else
                            begin
                            //Validar o botao de pagamento
                            btClose.Visible := not (fShowTabPaymentType and IsLayaway);
                            btClose.Caption := sReceive;
                            btClose.Tag     := 1;
                            //Display LaywayToFisih
                            CanFinalizeLayaway;
                            end;
                       end;
        SALE_CANCELED : begin
                        btCancel.Caption := sClose;
                        btCancel.Visible := True;
                        btClose.Visible  := False;
                        //Nao pode receber pagamentos aqui
                        btnDoPayments.Enabled := False;
                        btnDoPayments.Visible := False;
//                        showmessage('canceled');
                        end;

        else           //Pedido ja virou invoice
                       begin
                         btCancel.Visible := False;
                         btClose.Visible  := True;
                         btClose.Caption  := sClose;
                         btClose.Tag      := 0;
                         //Nao pode receber pagamentos aqui
                         btnDoPayments.Enabled := False;
                         btnDoPayments.Visible := False;
//                         showmessage('other');
                       end;
      end;

      // Arruma os botoes na tela - Nao estava dando certo - Rodrigo
{      if btCancel.Visible then
        begin
          btCancel.Left := 276;
          btClose.Left  := 168;
        end
      else
        btClose.Left  := 276;}

      // Desabilita edição, caso seja um PreSale Filho
      ShowChildControls;

      // Teste de AutoInclusao
      if spquPreSaleItem.IsEmpty then
        if not IsChield then
         btAddItem.Click
      else
         grdItems.SetFocus;
    end;
end;

procedure TFrmInvoice.btTaxIsentClick(Sender: TObject);
begin
  inherited;
  with TFrmTaxIsent.Create(Self) do
    if Start(IDPreSale, quPreSaleInfo, (spquPreSaleValueSpecialPriceID.AsInteger > 0),
             not spquPreSaleValueTaxIsent.AsBoolean) then
    begin
       RefreshValue;
       //PollDisplay
       DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                            Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                            spquPreSaleValueAditionalExpenses.AsCurrency,
                            spquPreSaleValueTotalDiscount.AsCurrency,
                            spquPreSaleValueTax.AsCurrency,
                            spquPreSaleValueSubTotal.AsCurrency,
                            True);
    end;

  grdItems.SetFocus;
end;

procedure TFrmInvoice.RefreshValue;
var
  fPercentDisc : Currency;
begin

  Screen.Cursor := crHourGlass;

  pnlSpecialPrice.Visible  := False;
  pnlReturn.Visible        := False;
  pnlSubTotal.Visible      := False;
  pnlTax.Visible           := False;
  pnlOtherCosts.Visible    := False;
  pnlTotalDiscount.Visible := False;

  with spquPreSaleValue do
    begin
      if Active then Close;
      Parameters.ParambyName('@PreSaleID').Value := IDPreSale;
      Open;
      if spquPreSaleValueTaxIsent.AsBoolean then
         btTaxIsent.Caption := sRestorTax
      else
         btTaxIsent.Caption := sExemptTax;
    end;

  pnlTotalDiscount.Visible := (spquPreSaleValueTotalDiscount.AsCurrency <> 0);
  pnlOtherCosts.Visible    := tbOtherCosts.TabVisible and (spquPreSaleValueAditionalExpenses.AsCurrency > 0);
  if DM.fSystem.SrvParam[PARAM_ENABLE_INDUSTRY_OPTION] then
    pnlTax.Visible           := (spquPreSaleValueTax.AsCurrency <> 0);

  pnlSubTotal.Visible      := True;

  if Abs(fTotalReturn) > 0 then
  begin
    pnlReturn.Visible := True;
    edtTotalReturn.Text := FormatFloat(DM.FQtyDecimalFormat, Abs(fTotalReturn));
  end;

  // Testa se deve mostrar o Panel de SpecialPrice
  if spquPreSaleValueSpecialPriceID.AsInteger > 0 then
     begin
     pnlSpecialPrice.Visible := True;
     EditFullTotal.Text := FloatToStrF(DM.fPOS.GetSpecialPriceTotal(IDPreSale) -
                                       spquPreSaleValueItemDiscount.AsFloat -
                                       spquPreSaleValueInvoiceDiscount.AsFloat, ffCurrency, 20 , DM.FQtyDecimal);
     end
  else
     begin
       if (spquPreSaleValueTotalDiscount.AsCurrency > 0) then
       begin
       pnlSpecialPrice.Visible := True;
       EditFullTotal.Text := FloatToStrF(spquPreSaleValueTotalInvoice.AsFloat +
                                         spquPreSaleValueItemDiscount.AsFloat +
                                         spquPreSaleValueInvoiceDiscount.AsFloat, ffCurrency, 20 , DM.FQtyDecimal);
       end
       else
         pnlSpecialPrice.Visible := False;
     end;

  // Testa se deve mostrar o panel de TaxIsemptValue
  if spquPreSaleValueTaxIsemptValue.AsCurrency <> 0 then
    begin
      //Nao faz mais isso - TaxAble esta no TaxCategory
      //pnlTaxIsempt.Visible := True;
      //pnlSubTotalTaxable.Visible := True;
    end
  else
    begin
      pnlTaxIsempt.Visible := False;
      pnlSubTotalTaxable.Visible := False;
    end;

  if edtDisTotalInv.Visible then
  begin
    case cbxType.ItemIndex of
      0: fPercentDisc := spnSpecialDiscount.Value;
      1: begin
           if spquPreSaleValueSubTotal.AsCurrency <> 0 then
             fPercentDisc := (MyStrToCurrency(edtDollarDiscount.Text) * 100) / spquPreSaleValueSubTotal.AsCurrency
           else
             fPercentDisc := 0;
         end;
    end;

    if fPercentDisc = 0 then
      edtDisTotalInv.Text := FormatFloat(DM.FQtyDecimalFormat,
                                         spquPreSaleValueSubTotal.AsCurrency -
                                         (spquPreSaleValueSubTotal.AsCurrency * (spnSpecialDiscount.Value / power(10, DM.FQtyDecimal))));
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmInvoice.RefreshInfo(AIdPreSale: Integer);
var
  sqlWhere: String;
  sql: String;
begin

    //Antonio M F Souza 12.14.2010
    sql :=
        'SELECT                  ' +
        'IDPreSale,              ' +
        'IDMeioPag ,             ' +
        'IDTouristGroup,         ' +
        'PreSaleDate ,           ' +
        'OtherComissionID ,      ' +
        'IDCustomer ,            ' +
        'DeliverTypeID ,         ' +
        'DeliverDate ,           ' +
        'DeliverAddress ,        ' +
        'PassportDate , AirLine , ' +
        'CompanyName ,            ' +
        'CompanyCGC ,            ' +
        'DepositDate ,           ' +
        'Note ,                  ' +
        'PrintNotes,             ' +
        'InvoiceDate ,           ' +
        'IDInvoice ,             ' +
        'Passport ,              ' +
        'Ticket,                 ' +
        'MediaID,                ' +
        'CardNumber,             ' +
        'IDStore,                ' +
        'Address,                ' +
        'Layaway,                ' +
        'FirstName,              ' +
        'LastName,               ' +
        'Zip,                    ' +
        'DeliverOBS,             ' +
        'DeliverConfirmation,    ' +
        'IDFormOfPayment,        ' +
        'IDPreSaleParent,        ' +
        'SaleCode,               ' +
        'InvoiceCode,            ' +
        'PuppyTracker            ' +
        'FROM                    ' +
        'Invoice Invoice (NOLOCK) ';

{
    if ( MyPreSaleType = SALE_INVOICE )  then begin
       sqlWhere := ' where InvoiceCode = :invoicecode';
       quPreSaleInfo.SQL.Text := sql + sqlWhere;
       quPreSaleInfo.Parameters.ParambyName('invoicecode').Value := AIDPreSale;
    end
    else begin           }
       sqlWhere := ' where IdPreSale = :idpresale ';
       quPreSaleInfo.SQL.Text := sql + sqlWhere;
       quPreSaleInfo.Parameters.ParambyName('IDPreSale').Value := AIDPreSale;
//    end;

    if ( not quPreSaleInfo.Active) then
       quPreSaleInfo.Open;
end;

procedure TFrmInvoice.cmbSpecialDiscSelectItem(Sender: TObject);
begin
  inherited;
  // Atualiza o special discount
end;

procedure TFrmInvoice.TmrRefreshItemTimer(Sender: TObject);
var
  NewRefresh : Integer;
begin
  inherited;
  if IDPreSale <> 0 then
  begin
    with spTestRefresh do
      begin
        Parameters.ParambyName('@IDPreSale').Value := IDPreSale;
        ExecProc;
        NewRefresh := Parameters.ParambyName('@RefreshInvoice').Value;
      end;

    if OldRefreshInvoice <> NewRefresh then
      begin
       OldRefreshInvoice := NewRefresh;
       RefreshItem(spquPreSaleItemIDInventoryMov.AsInteger);
       // Refresh do discount ranges
       if pgInvoice.ActivePage = tbDiscount then
          ShowDiscRanges;
      end;
  end;
end;

procedure TFrmInvoice.AtuPreSaleControls;
var
  IsEnabled,
  DeliveryEnabled : Boolean;
  MyColor   : Integer;
begin

  IsEnabled := ((StatusUser = 0) and not IsInvoice);

  //Case seja Type invoice Cancelado habilitar os botoes
  if MyPreSaleType = SALE_CANCELED then
     IsEnabled := False;

  if IsEnabled then
     MyColor := clWindow
  else
     MyColor := clBtnFace;

  pnlInvoiceCustomer.Visible := IsGenericIDPessoa;
  pnlPessoa.Visible := not IsGenericIDPessoa;

  // Delivery
  cmbDelType.ReadOnly      := not IsEnabled;
  cmbDelType.Color         := MyColor;

  DeliveryEnabled          := IsInvoice;

  pnlConfirmDeliver.Visible := DeliveryEnabled;

  cmbDelType.TabStop       := IsEnabled;
  EditDelDate.ReadOnly     := not IsEnabled;
  EditDelDate.Color        := MyColor;
  EditDelAddress.ReadOnly  := not IsEnabled;
  EditDelAddress.Color     := MyColor;
  edtDelOBS.ReadOnly       := not IsEnabled;
  edtDelOBS.Color          := MyColor;
  btnDelivery.Visible      := IsEnabled;

  cmbOther.Enabled         := not IsEnabled;
  cmbOther.Color           := MyColor;

  EditNote.ReadOnly        := not IsEnabled;
  cbxFormOfPayment.Enabled := IsEnabled;

  with EditNote do
       if IsEnabled then Color := clInfoBk else Color := MyColor;

  spPayVisa.Enabled        := IsEnabled;
  spPayMaster.Enabled      := IsEnabled;
  spPayAmerican.Enabled    := IsEnabled;
  cmbPayType.ReadOnly      := not IsEnabled;
  EditDepositDate.ReadOnly := not IsEnabled;

  scCostType.Enabled         := IsEnabled;
  scCostType.Color           := MyColor;
  editCustoUnitario.ReadOnly := not IsEnabled;
  editCustoUnitario.Color    := MyColor;
  btAddCost.Visible          := IsEnabled;
  btRemoveCost.Visible       := IsEnabled;

  btSpecialPrice.Enabled   := IsEnabled;

  btTaxIsent.Enabled        := IsEnabled;
  btMakeSpecialPrice.Enabled := IsEnabled;

  //Inverte a opcao do Invoice
  IsEnabled := not IsInvoice;

  //Case seja Type invoice Cancelado habilitar os botoes
  if MyPreSaleType = SALE_CANCELED then
     IsEnabled := False;

  if IsInvoice then
     btImpHold.Caption := sCopyInvoice
  else
     btImpHold.Caption := sCopyHold;

  pnlUsers.Visible         := IsEnabled;
  btnEditDate.Visible      := IsEnabled;

  if btnEditDate.Visible then
    EditPreSaleDate.Width := 106
  else
    EditPreSaleDate.Width := 128;

  btPayment.Visible        := IsInvoice or IsLayaway;

  btAddItem.Enabled        := IsEnabled;
  btnAddQuick.Enabled      := IsEnabled;
  btRemoveItem.Enabled     := IsEnabled;
  btDiscountItem.Enabled   := IsEnabled;
  btUpHold.Visible         := IsEnabled;
  btSerial.Visible         := IsEnabled;
  btChangeUser.Visible     := IsEnabled;
  btRefund.Visible         := IsEnabled;

  // Mostra o PayDate
  EditInvoiceDate.Visible  := not IsEnabled;
  lblInvoiceDate.Visible   := not IsEnabled;

  //Pode Unir Pedido
  btUpHold.Visible         := Password.HasFuncRight(57);
  btRefund.Visible         := (not IsInvoice) and Password.HasFuncRight(52);

  // Setar o Help Context dependendo da tela origem (Cash Reg/Inv History)
  if IsInvoice then
    HlpContext:= 1130
  else
    HlpContext:= 1050;

  //Replication mode only   
  if fIsRestricForm then
     begin
     btAddItem.Visible          := False;
     btnAddQuick.Enabled        := False;
     btRemoveItem.Visible       := False;
     btClose.Enabled            := False;
     btMakeSpecialPrice.Enabled := False;
     btTaxIsent.Enabled         := False;
     btSpecialPrice.Enabled     := False;
     EditNote.ReadOnly          := True;
     dbPrintNotes.ReadOnly      := True;
     cmbPayType.Enabled         := False;
     spPayVisa.Enabled          := False;
     spPayMaster.Enabled        := False;
     spPayAmerican.Enabled      := False;
     EditDepositDate.Enabled    := False;
     cmbDelType.Enabled         := False;
     cmbOther.Enabled           := False;
     btDetGroup.Enabled         := False;
     btChangeTourGuide.Enabled  := False;
     btSerial.Visible           := False;
     btUpHold.Visible           := False;
     btRefund.Visible           := False;
     btChangeUser.Visible       := False;
     btnEditDate.Visible        := False;
     EditDelDate.Enabled        := False;
     EditDelAddress.Enabled     := False;
     end;

end;

function TFrmInvoice.TestUserComission : Boolean;
begin
  Result := (DM.fUser.IDCommission > 0);
  if not Result then
    begin
     MessageBeep(MB_ICONASTERISK);
     MsgBox(MSG_NO_ASSOCIATED_COMMITION, vbOKOnly + vbInformation);
    end;
end;

procedure TFrmInvoice.spquPreSaleItemCalcFields(DataSet: TDataSet);
var
   tempSaleItemQty: Extended;
   tempSaleItemSalePrice: Extended;
   tempSaleItemTotalSalePrice: Extended;
   tempSaleItemDiscount: Extended;
   tempSaleItemTax: Extended;

begin
  inherited;
  // Antonio M F Souza November 21, 2012 - begin
  tempSaleItemQty := 0;
  tempSaleItemSalePrice := 0;
  tempSaleItemTotalSalePrice := 0;
  tempSaleItemDiscount := 0;
  tempSaleItemTax := 0;

  // Antonio M F Souza April 18, 2013
  tempSaleItemDiscount := spquPreSaleItemDiscount.Value;

  // Antonio M F Souza November 14, 2012
  tempSaleItemQty      := spquPresaleItemQty.Value;

  // unit price
 //Antonio MF Souza December 3, 2012 tempSaleItemSalePrice    := truncMoney(spquPreSaleItemSalePrice.Value, length(spquPreSaleItemSalePrice.asString));
  tempSaleItemSalePrice    := spquPreSaleItemSalePrice.Value;
  spquPreSaleItemSalePrice.Value := tempSaleItemsalePrice;

  // Ext. Price
  //tempSaleItemSalePrice := forceRoundInThirdPosition(tempSaleItemSalePrice);
  tempSaleItemTotalSalePrice := tempSaleItemQty * tempSaleItemSalePrice;

  // Antonio M F Souza, December 19, 2012   spquPreSaleItemTotalSalePrice.Value := forceRoundInThirdPosition(tempSaleItemTotalSalePrice, 2);
  tempSaleItemTotalSalePrice := roundLikeDatabase(tempSaleItemTotalSalePrice, 2);
  spquPreSaleItemTotalSalePrice.Value := tempSaleItemTotalSalePrice;

  // Antonio M F Souza: April 18, 2013 - Extended Discount
  spquPreSaleItemDiscount.Value := tempSaleItemDiscount;

  // Subtotal
  spquPresaleItemTotalItem.Value := tempSaleItemTotalSalePrice - tempSaleItemDiscount;

  if spquPreSaleItemQty.AsFloat < 0 then
  begin
    if fIDItemsReturnList.IndexOf(spquPreSaleItemIDInventoryMov.AsString) = -1 then
    begin
      fIDItemsReturnList.Add(spquPreSaleItemIDInventoryMov.AsString);
      fTotalReturn := forceRoundInThirdPosition((fTotalReturn + spquPreSaleItemTotalItem.Value), 2);
    end;
  end;
end;

procedure TFrmInvoice.ShowDiscRanges;
var
  MaxDiscount: Double;
  OldPage    : TTabSheet;
begin
  // Acha o max venda minimo
  DM.fPOS.GetMinSaleAndMaxDiscount(IDPreSale, DM.fUser.ID,
                                   MaxVendaMin, MaxDiscount);

  with quDiscRange do
  begin
    if Active then
      Close;
    Parameters.ParambyName('IDUser').Value := DM.fUser.ID;
    Open;

    if Locate('TotVendaMin', MaxVendaMin, []) then
      EditAmountDisc.Text := FormatFloat(DM.FQtyDecimalFormat,
                               MaxDiscount -
                               spquPreSaleValueItemDiscount.AsFloat -
                               spquPreSaleValueInvoiceDiscount.AsFloat)
    else
      EditAmountDisc.Text := FormatFloat(DM.FQtyDecimalFormat, 0);
  end;
end;

procedure TFrmInvoice.dsPreSaleValueDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if spquPreSaleValueShowOpenUser.AsInteger > 0 then
    EditOpenUser.Font.Color := clBlack
  else
    EditOpenUser.Font.Color := clWhite;

  if spquPreSaleValueSpecialPriceID.AsInteger > 0 then
    btMakeSpecialPrice.Caption := sChangePrice
  else
    btMakeSpecialPrice.Caption := sApplyPrice;
end;

procedure TFrmInvoice.btCancelClick(Sender: TObject);
begin
  SetToHold;
end;

procedure TFrmInvoice.SetToHold;
var
  bIsEmpty : Boolean;
begin
  inherited;
  if not ValidadeHold then
    Exit;

  SetCustomerProperties;

  if (quPreSaleInfo.State in dsEditModes) then
  begin
    if MyPreSaleType = SALE_CASHREG then
    begin
      quPreSaleInfo.UpdateRecord;
      quPreSaleInfo.Post;

      if (quInvoiceOBS.State in dsEditModes) then
      begin
        quInvoiceOBS.UpdateRecord;
        quInvoiceOBS.Post;
      end;
    end
    else
    begin
      quPreSaleInfo.Cancel;

      if quInvoiceOBS.Active then
        quInvoiceOBS.Cancel;
    end;
  end;

  //Rodrigo - Verificar se o hold esta vazio e deletar
  with spquPreSaleItem do
  begin
    fTotalReturn := 0;
    fIDItemsReturnList.Clear;
    Close;

    if IsInvoice then
      Parameters.ParambyName('@DocumentID').Value := quPreSaleInfoIDInvoice.AsInteger
    else
      Parameters.ParambyName('@DocumentID').Value := IDPreSale;

    Parameters.ParambyName('@IsPreSale').Value  := not IsInvoice;
    Parameters.ParambyName('@Date').Value      := Now;
    Open;
  end;

  quPreSaleInfo.Refresh;
  IsInvoice := (quPreSaleInfoIDInvoice.AsString <> '');
  bIsEmpty := spquPreSaleItem.IsEmpty;

  if bIsEmpty and (not IsInvoice) then
  begin
    if (FScreenType = CASHREG_TYPE_OFFICE) and
       (DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE]) then
      DM.fPOS.CancelHold(IDPreSale, DM.fUser.ID)
    else
      DM.fPOS.DeleteHold(IDPreSale, DM.fUser.ID);
  end
  else
    //Criar novo numero para hold
    CanCreateHoldNum;

  Close;
end;

procedure TFrmInvoice.btSerialClick(Sender: TObject);
var
   T: Integer;
   listIdPreInventoryOnSameSale:TStringList;
begin
  inherited;

  if spquPreSaleItem.IsEmpty then
    Exit;

  if IsInvoice then
    T := SERIAL_INVOICE
  else
    T := SERIAL_HOLD;

  try
     listIdPreInventoryOnSameSale := TStringList.Create;
     ListIdPreInventoryOnSameSale.Add( intToStr(IDPresale)+ '/' + intTostr(spquPreSaleItemIDInventoryMov.AsInteger));


     with TFrmSerialNumber.Create(Self) do begin
     setListFromPreInventoryMovOnSameSale(ListIdPreInventoryOnSameSale);
     StartOnSales(T,
                  spquPreSaleItemModelID.AsInteger,
                  DM.fStore.ID,
                  spquPreSaleItemQty.AsFloat,
                  spquPreSaleItemIDInventoryMov.AsInteger);
     end;
  finally
     freeAndNil(listIdPreInventoryOnSameSale);
  end;

end;

procedure TFrmInvoice.RefreshInvPayments;
var
  bEstimated : Boolean;
begin

  bEstimated := False;

  if (not IsInvoice) then
    bEstimated := Password.HasFuncRight(91);

  SubPaymentType.CreateSubList;
  SubPaymentType.Param := 'IDPreSale='+IntToStr(IDPreSale)+';'+
                          'ShowDetail=False;Enabled='+IntToStr(Byte(not IsInvoice))+';'+
                          'IsNewInvoice='+IntToStr(Byte(IsNewPreSale))+';'+
                          'Estimated='+IntToStr(Byte(bEstimated))+';';
end;

procedure TFrmInvoice.pgInvoiceChange(Sender: TObject);
begin
  inherited;
  if pgInvoice.ActivePage = tsComplement then
  begin
    RefreshInvOBS;
  end
  else if pgInvoice.ActivePage = tbOtherCosts then
  begin
    RefreshInvCosts;
  end
  else if pgInvoice.ActivePage = tbPaymentType then
  begin
    RefreshInvPayments;
  end
  else if pgInvoice.ActivePage = tbDeposit then
  begin
    if quPreSaleInfoIDMeioPag.AsInteger > 0 then
    begin
      // Desabilita o Deposit Date
      cmbPayType.LookUpvalue   := quPreSaleInfoIDMeioPag.AsString;
    end;
    cmbPayTypeSelectItem(nil);
  end
  else if pgInvoice.ActivePage = tbDiscount then
  begin
    ShowDiscRanges;
  end
  else if pgInvoice.ActivePage = tbDeliver then
  begin
    pnlConfirmDeliver.Visible := IsDeliveryEnabled;
  end;
end;

procedure TFrmInvoice.btDetGroupClick(Sender: TObject);
var
   PosID1, PosID2 : String;
begin
  inherited;

  PosID1 := quPreSaleInfoIDTouristGroup.AsString;
  with TFchTouristGroup.Create(self) do
  begin
    ShowCusto := False;
    if Start(btAlt, nil, False, PosID1, PosID2, nil) then
      AtuDescTourist;

    Free;
  end;
end;

procedure TFrmInvoice.quPreSaleInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GetCustomer;
  RefreshDeliveryInfo;
  sSaleCode := quPreSaleInfoSaleCode.AsString;
end;

procedure TFrmInvoice.AtuDescTourist;
begin
  // Da o refresh do descTourist
  with quDescTourist do
  begin
    if quPreSaleInfoIDTouristGroup.IsNull then
    begin
      lblTourGroup.Caption      := '';
      btDetGroup.Enabled        := False;
      btnRemoveGroup.Enabled    := False;
    end
    else
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDTouristGroup').Value := quPreSaleInfoIDTouristGroup.AsInteger;
      Open;
      lblTourGroup.Caption      := quDescTouristTipTouristGroup.AsString;
      btDetGroup.Enabled        := Password.HasFuncRight(16);
      btChangeTourGuide.Enabled := btDetGroup.Enabled;
      btnRemoveGroup.Enabled    := btDetGroup.Enabled;
      Close;
    end;
  end;
end;

procedure TFrmInvoice.GetCustomer;
var
  sResult : String;
begin
  SubCustomer.Param := Format('IDCUSTOMER=%S;ChangeCustomer=1;', [quPreSaleInfoIDCustomer.AsString]);

  sResult := SubCustomer.GetSubListInfo(sResult);

  fCustomerAddress := Trim(ParseParam(sResult, 'ADDRESS'));

  pnlCustomerAddress.Visible := StrToIntDef(Trim(ParseParam(sResult, 'NUMOFADDRESS')), 0) > 0;
  RefreshCustomerAddress(StrToIntDef(ParseParam(sResult, 'IDCUSTOMER'), 1));

end;

procedure TFrmInvoice.quPreSaleInfoNewRecord(DataSet: TDataSet);
begin
  inherited;
  quPreSaleInfoDeliverTypeID.AsInteger       := DELIVER_TYPE_ONHAND;
  quPreSaleInfoIDFormOfPayment.AsInteger     := 1;
  quPreSaleInfoDeliverConfirmation.AsBoolean := False;
end;

procedure TFrmInvoice.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if ((ssAlt in Shift) and (Key = VK_F4)) then
     if DM.fUser.IDUserType <> USER_TYPE_ADMINISTRATOR then
        begin
        Key := 0;
        Exit;
        end;

  case Key of

       VK_F2  : begin //Add New Item
                if btAddItem.Enabled and btAddItem.Visible then
                   btAddItemClick(nil);
                end;

       VK_F3  : begin //Edit Item
                if btDiscountItem.Enabled and btDiscountItem.Visible then
                   btDiscountItemClick(nil);
                end;

       VK_F4  : begin //Remove Item
                if not (ssAlt in Shift) then
                   if btRemoveItem.Enabled and btRemoveItem.Visible then
                      btRemoveItemClick(nil);
                end;

       VK_F5  : begin //Enter Serial
                if btSerial.Enabled then
                   btSerialClick(nil);
                end;

       VK_F6  : begin //Chang User
                if btChangeUser.Enabled then
                   btChangeUserClick(nil);
                end;

       VK_F7  : begin
                 if not tbTourist.TabVisible then
                    Exit;
                 pgInvoice.ActivePage := tbTourist;
                 pgInvoiceChange(nil);
                end;

       VK_F8  : begin
                 if not tbDeliver.TabVisible then
                    Exit;
                 pgInvoice.ActivePage := tbDeliver;
                 if cmbDelType.Enabled then cmbDelType.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F9 : begin
                 if not tbDeposit.TabVisible then
                    Exit;
                 pgInvoice.ActivePage := tbDeposit;
                 if cmbPayType.Enabled then cmbPayType.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F10 : begin
                 pgInvoice.ActivePage := tbNote;
                 if EditNote.Enabled then EditNote.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F11 : begin
                 if not tbDiscount.TabVisible then
                    Exit;
                 pgInvoice.ActivePage := tbDiscount;
                 pgInvoiceChange(nil);
                end;

       VK_F12 : begin
                 pgInvoice.ActivePage := tbPrint;
                 pgInvoiceChange(nil);
                end;
  end;
end;



procedure TFrmInvoice.spPayVisaClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_VISA;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmInvoice.spPayMasterClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_MASTER;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmInvoice.spPayAmericanClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_AMERICAN;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmInvoice.tbDepositExit(Sender: TObject);
var
  MyDifDay : integer;
  // Na saida do tab valido a data de deposit date
begin
  inherited;

  if not quPayMin.Active then
     Exit;

  // teste de data válida para o campo
  if TestDate(EditDepositDate.Text) then
    begin
      // testa se pode dar este deposit date para o minimo de venda
      MyDifDay := -1;
      with quPayMin do
        begin

          DisableControls;
          Last;
          while not Bof do
            begin
              if spquPreSaleValueTotalInvoice.AsFloat > quPayMinTotalSale.AsFloat then
                begin
                 MyDifDay := quPayMinDifDay.AsInteger;
                 Break;
                end;
              Prior;
            end;
          First;
          EnableControls;
        end;

      if (MyDifDay < 0) or ((quPreSaleInfoDepositDate.AsDateTime - Date) > MyDifDay) then
        begin
          MsgBox(MSG_INF_INVOICE_NOT_REACH, vbOKOnly + vbInformation);
          quPreSaleInfo.Edit;
          quPreSaleInfoDepositDate.Clear;
          quPreSaleInfoIDMeioPag.Clear;
          cmbPayTypeSelectItem(nil);

          if not (pgInvoice.ActivePage = tbDeposit) then
             begin
             pgInvoice.ActivePage := tbDeposit;
             cmbPayType.SetFocus;
             end
          else
             cmbPayType.SetFocus;

        end;
    end
  else
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoDepositDate.Clear;
      quPreSaleInfoIDMeioPag.Clear;
      cmbPayTypeSelectItem(nil);

      if not (pgInvoice.ActivePage = tbDeposit) then
         begin
         pgInvoice.ActivePage := tbDeposit;
         cmbPayType.SetFocus;
         end
      else
         cmbPayType.SetFocus;

    end;
end;

procedure TFrmInvoice.btImpHoldClick(Sender: TObject);
begin
  inherited;

  with quPreSaleInfo do
  if State in dsEditModes  then
  begin
    UpdateRecord;
    Post;
  end;

  if quInvoiceOBS.Active and (quInvoiceOBS.State in dsEditModes) then
  begin
    quInvoiceOBS.UpdateRecord;
    quInvoiceOBS.Post;
  end;

  //Criar novo numero para hold
  CanCreateHoldNum;

  PrintReceipt(RECEIPT_TYPE_HOLD, fInfoCash);

end;

procedure TFrmInvoice.btImpHoldHotelClick(Sender: TObject);
begin
  inherited;

  with quPreSaleInfo do
  if State in dsEditModes  then
  begin
    UpdateRecord;
    Post;
  end;

  if quInvoiceOBS.Active and (quInvoiceOBS.State in dsEditModes) then
  begin
    quInvoiceOBS.UpdateRecord;
    quInvoiceOBS.Post;
  end;
  
  //Criar novo numero para hold
  CanCreateHoldNum;

  PrintReceipt(RECEIPT_TYPE_TICKET);
  
end;

procedure TFrmInvoice.btChangeTourGuideClick(Sender: TObject);
var
   NewTourGroup: Integer;
begin
  inherited;

  with TFrmChangeTourGroup.Create(Self) do
    NewTourGroup := Start;

  if NewTourGroup >= 0 then
    with quPreSaleInfo do
      begin
        if not (State in dsEditModes) then
           Edit;
        quPreSaleInfoIDTouristGroup.AsInteger := NewTourGroup;
        UpdateTouristChildGroup(NewTourGroup);
      end;

  AtuDescTourist;

end;

procedure TFrmInvoice.scMediaSelectItem(Sender: TObject);
var
   NewTourGroup : integer;
begin
  inherited;
                                           
  if MyStrToInt(scMedia.LookUpValue) = MEDIA_TYPE_TOURGROUP then
    begin
      btChangeTourGuide.Enabled := True;

      with TFrmChangeTourGroup.Create(Self) do
        NewTourGroup := Start;

      if NewTourGroup >= 0 then
        with quPreSaleInfo do
          begin
            if not (State in dsEditModes) then Edit;
            quPreSaleInfoIDTouristGroup.AsInteger := NewTourGroup;
          end
      else
        with quPreSaleInfo do
          begin
            btChangeTourGuide.Enabled := False;
            if not (State in dsEditModes) then Edit;
            quPreSaleInfoMediaID.AsInteger := OldMedia;
          end;

      AtuDescTourist;
    end
  else
    with quPreSaleInfo do
      begin
        btChangeTourGuide.Enabled := False;
        if not (State in dsEditModes) then Edit;
        quPreSaleInfoIDTouristGroup.Clear;
        AtuDescTourist;
      end;

  grdItems.SetFocus;

  if (OldMedia <> quPreSaleInfoMediaID.AsInteger) then
     SetTaxIsention(True);

  OldMedia := MyStrToInt(scMedia.LookUpValue);
end;

procedure TFrmInvoice.SetTaxIsention(Force : Boolean);
begin

  // Testa para isentar o imposto
  if DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] then
     begin
     pnlTax.Visible     := False;
     btTaxIsent.Enabled := False;
     Panel10.Visible    := False;
     if (not IsInvoice) and (not spquPreSaleValueTaxIsent.AsBoolean) then
        DM.fPOS.ExemptTax(IDPreSale, True);
     Exit;
     end;

  // Teste se vendapara para guia e isenta a taxa
  if (not IsInvoice) and (Force or (spquPreSaleItem.EOF and spquPreSaleItem.BOF)) then
     begin
     DM.fPOS.SetExemptTax(IDPreSale, quPreSaleInfoMediaID.AsInteger, Now);
     RefreshValue;
     end;

end;

procedure TFrmInvoice.btUpHoldClick(Sender: TObject);
var
   Origem, Cliente, OBS : String;

begin
  inherited;

  with TFrmJoinHold.Create(Self) do
      Origem := IntToStr(Start(quPreSaleInfoIDPreSale.AsInteger, Cliente, OBS, False));

  If Origem = '-1' then
     Exit;

  // digitou um numero valido?
  if MyStrToInt(Origem) > 0 then
    begin
      // Existe um hold com este numero?
      if (Cliente <> '') then
        begin
          // O carinha tem certesa?
          if MsgBox(MSG_QST_PART1_MOVE_INVOICE_ITEM + ' ' +MSG_QST_PART2_MOVE_INVOICE_ITEM + ' ('+Cliente+')',
             vbYesNo + vbQuestion) = vbYes Then
            begin
              with spUpHold do
                begin
                  Parameters.ParambyName('@IDPreSaleOrigem').Value  := MyStrToInt(Origem);
                  Parameters.ParambyName('@IDPreSaleDestino').Value := IDPreSale;
                  Parameters.ParambyName('@Date').Value             := Now;
                  Parameters.ParambyName('@IDUser').Value           := DM.fUser.ID;
                  ExecProc;
                end;

              // Refresh Hold
              RefreshItem(0);

              quPreSaleInfo.Edit;
              if OBS = '' then
                quPreSaleInfoNote.AsString := quPreSaleInfoNote.AsString + #13#10 + OBS + #13#10 + sJunction + Origem
              else
                quPreSaleInfoNote.AsString := quPreSaleInfoNote.AsString + #13#10 + sJunction + Origem;

              //Registra o Numero do Pedido
              CanCreateHoldNum;

              if (spquPreSaleItem.RecordCount > 0) and (not IsInvoice) then
              begin
                //PollDisplay
                DM.PollDisplayCloseSale;
                DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                                      Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                                      spquPreSaleValueAditionalExpenses.AsCurrency,
                                      spquPreSaleValueTotalDiscount.AsCurrency,
                                      spquPreSaleValueTax.AsCurrency,
                                      spquPreSaleValueSubTotal.AsCurrency);

                DM.PollDisplayOpenHoldItems(spquPreSaleItem);
              end;

            end;
        end
      else
        begin
        MsgBox(MSG_EXC_PART1_NO_HOLD_NUMBER + Origem + MSG_EXC_PART2_NO_HOLD_NUMBER, vbOkOnly + vbExclamation)
        end
    end
  else
    begin
      MsgBox(Origem + MSG_EXC_INVALID_HOLD_NUMBER, vbOkOnly + vbExclamation)
    end;
end;

procedure TFrmInvoice.btPaymentClick(Sender: TObject);
begin
  inherited;
  // Mostra payments do Invoice
  with TInvoicePayment.Create(Self) do
     Start(quPreSaleInfoIDPreSale.AsInteger, IsLayaway, IsInvoice);
end;

procedure TFrmInvoice.spquPreSaleItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblTotalLine.Caption := IntToStr(spquPreSaleItem.RecordCount) + sItems;
end;

procedure TFrmInvoice.btChangeUserClick(Sender: TObject);
begin

  //Destrava o Permanente logon
  if Password.PermanentLogOn then
     Password.PermanentLogOn := False;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     lblUserName.Caption := DM.fUser.UserName;

  RefreshPasswordOption;

  pgInvoiceChange(Self);

end;

procedure TFrmInvoice.btSpecialPriceClick(Sender: TObject);
begin
  inherited;
  edtDisTotalInv.Text := FormatFloat(DM.FQtyDecimalFormat,
                           spquPreSaleValueTotalInvoice.AsCurrency +
                           spquPreSaleValueInvoiceDiscount.AsCurrency);

  pnlSpecialDiscount.visible := btSpecialPrice.Down;
  if pnlSpecialDiscount.visible then
    case cbxType.ItemIndex of
      0: spnSpecialDiscount.SetFocus;
      1: edtDollarDiscount.SetFocus;
    end;
end;

procedure TFrmInvoice.btApplyPriceManagerClick(Sender: TObject);
var
  fPercentDisc : Double;
begin

  case cbxType.ItemIndex of
    0: fPercentDisc := spnSpecialDiscount.Value;
    1: begin
         if spquPreSaleValueSubTotal.AsCurrency <> 0 then
           fPercentDisc := (MyStrToCurrency(edtDollarDiscount.Text) * 100) / spquPreSaleValueSubTotal.AsCurrency
         else
           fPercentDisc := 0;
       end;
  end;

  if (fPercentDisc <> 0) then
    if (spquPreSaleValueItemDiscount.AsCurrency > 0) and (not Password.HasFuncRight(74)) then
    begin
      MsgBox(MSG_INF_ITEM_ALREADY_DISC, vbOKOnly + vbInformation);
      Exit;
    end;
  
  if DM.fSystem.SrvParam[PARAM_APPLY_INV_DISCOUNT_ON_ITEMS] then
  begin
    fPercentDisc := StrToFloat(FormatFloat(DM.FQtyDecimalFormat, fPercentDisc));

    if not Password.HasFuncRight(9) then
      if (not ValidateDiscountPercente(fPercentDisc)) then
      begin
        MsgBox(MSG_INF_NOT_GIVE_DICOUNT + '_Max Disc.= ' + EditAmountDisc.Text, vbInformation + vbOKOnly);
        Exit;
      end;

    DM.fPOS.ManageDiscount(IDPreSale, fPercentDisc, Now, DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE], Password.HasFuncRight(9), False);

    if (pnlSpecialDiscount.visible) and (spnSpecialDiscount.value = 0) then
      SpecialPrice := 0 // ** estou no special price de manager/assist. manager e foi marcado discount=0
    else
      SpecialPrice := 999; // ** para forçar a mensagem de erro

    SpecialPrice := 0;
  end
  else
  begin
    case cbxType.ItemIndex of
      0: fPercentDisc := (spquPreSaleValueSubTotal.AsCurrency * (spnSpecialDiscount.Value / power(10, DM.FQtyDecimal)));
      1: fPercentDisc := MyStrToCurrency(edtDollarDiscount.Text);
    end;

    if not ValidateInvoiceDiscount(fPercentDisc) then
    begin
      MsgBox(MSG_INF_NOT_GIVE_DICOUNT, vbInformation + vbOKOnly);
      Exit;
    end;

    DM.RunSQL('UPDATE Invoice SET InvoiceDiscount = ' + MyFormatCur(fPercentDisc, '.') + ' WHERE IDPreSale = ' +  quPreSaleInfoIDPreSale.AsString);
  end;

    RefreshItem(0);

  //PollDisplay
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency,
                        True);

  //Atualiza o impost ST
  if DM.fSystem.SrvParam[PARAM_ENABLE_INDUSTRY_OPTION] then
    DM.CalcularImpostoST(quPreSaleInfoIDPreSale.AsInteger);
                        
  ShowDiscRanges;
  grdItems.SetFocus;
end;

procedure TFrmInvoice.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(HlpContext);
end;

procedure TFrmInvoice.grdPayMinDblClick(Sender: TObject);
begin
  inherited;

  if not quPayMin.Active then
     Exit;

  if quPayMinTotalSale.AsFloat <= spquPreSaleValueTotalInvoice.AsFloat then
    begin
     quPreSaleInfo.Edit;
     quPreSaleInfoDepositDate.AsDateTime  := quPayMinDifDay.AsInteger + Date;
    end;

end;

procedure TFrmInvoice.cmbPayTypeSelectItem(Sender: TObject);
begin
  inherited;

  // Atualiza o estado dos botoes
  case MyStrToInt(cmbPayType.LookUpValue) of
    PAY_TYPE_VISA     : spPayVisa.Down     := True;
    PAY_TYPE_AMERICAN : spPayAmerican.Down := True;
    PAY_TYPE_MASTER   : spPayMaster.Down   := True;
  else
    begin
      // nao seleciona
      spPayVisa.Down     := False;
      spPayAmerican.Down := False;
      spPayMaster.Down   := False;
    end;
  end;

  RefreshPayMin;
                                                
  if ((StatusUser = 0) and not IsInvoice) then
    begin
      if (cmbPayType.LookUpValue <> '') then
        begin
         EditDepositDate.ReadOnly := False;
         EditDepositDate.Color    := clWindow;
        end
      else
        begin
         EditDepositDate.ReadOnly := True;
         EditDepositDate.Color    := clBtnFace;
        end;
    end;
end;


procedure TFrmInvoice.grdDiscRangeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
begin
  inherited;
  {
  i := TDBGrid(Sender).ColumnByFieldName('TotVendaMin').Index;

  i := 0;

  if Column = MaxVendaMin then
     begin
     AColor      := clYellow;
     AFont.Color := clBlack;
     end;
  }
end;

end;

procedure TFrmInvoice.grdPayMinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  {
  i := TdxDBGrid(Sender).ColumnByFieldName('TotalSale').Index;
  i := 0;

  if Column[i] <= spquPreSaleValueTotalInvoice.AsFloat then
     begin
     AColor      := clYellow;
     AFont.Color := clBlack;
     end;
  }
end;

procedure TFrmInvoice.scCostTypeSelectItem(Sender: TObject);
begin
  inherited;
  editCustoUnitario.Text := DM.DescCodigo(['IDCostType'], [scCostType.LookUpValue],
                                           'CostType', 'DefaultValue');
  if editCustoUnitario.CanFocus then
     editCustoUnitario.SetFocus;
end;

procedure TFrmInvoice.btAddCostClick(Sender: TObject);
  function ValidateCosts : Boolean;
  begin
  Result := False;

  if scCostType.LookUpValue = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_COSTTYPE, vbCritical + vbOkOnly);
     if scCostType.CanFocus then
        scCostType.SetFocus;
     Exit;
     end;

  if (MyStrToMoney(editCustoUnitario.Text) = 0) then
     begin
     MsgBox(MSG_CRT_INVAL_COST_PRICE, vbCritical + vbOkOnly);
     if editCustoUnitario.CanFocus then
        editCustoUnitario.SetFocus;
     Exit;
     end;

  //Verificar se pode incluir item do pedido na edicao
  if (not Password.HasFuncRight(80)) and (not IsNewPreSale) then
  begin
    MsgBox(MSG_INF_NOT_ADD_ITEMS_SALE, vbOKOnly + vbInformation);
    Exit;
  end;

  Result := True;

  end;
begin
  inherited;

  if not ValidateCosts then
     Exit;

  DM.fPOS.AddInvoiceAdtionalCost(IDPreSale,
                                 StrToInt(scCostType.LookUpValue),
                                 MyStrToMoney(editCustoUnitario.Text));

  scCostType.SetFocus;
  editCustoUnitario.Clear; 
  RefreshInvCosts;
  RefreshValue;

  //PollDisplay
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency,
                        True);

end;

procedure TFrmInvoice.btRemoveCostClick(Sender: TObject);
  function TestDeleteCosts : Boolean;
  begin
    Result := True;

    if not (quAditionalExpenses.Active) then
       Exit;

    //Verificar se pode incluir item do pedido na edicao
    if (not Password.HasFuncRight(82)) and (not IsNewPreSale) then
    begin
      MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbOKOnly + vbInformation);
      Result := False;
      Exit;
    end;

    Result := (quAditionalExpensesIDInvoiceCost.AsInteger <> 0);

    if not Result then
       MsgBox(MSG_CRT_ERROR_DELETING, vbCritical + vbOkOnly);

  end;
begin
  inherited;
  if not TestDeleteCosts then
     Exit;

  DM.fPOS.DeleteInvoiceAdtionalCost(quAditionalExpensesIDInvoiceCost.AsInteger);

  RefreshInvCosts;
  RefreshValue;

  //PollDisplay
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency,
                        True);

end;

procedure TFrmInvoice.editCustoUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Key := ValidateCurrency(Key);

end;

procedure TFrmInvoice.CloseInvCosts;
begin
   with quAditionalExpenses do
      if Active then
         Close;
end;

procedure TFrmInvoice.OpenInvCosts;
begin
   with quAditionalExpenses do
      if not Active then
         begin
         Parameters.ParamByName('IDPreSale').Value := IDPreSale;
         Open;
         end;

end;

procedure TFrmInvoice.RefreshInvCosts;
begin
  CloseInvCosts;
  OpenInvCosts;
end;

procedure TFrmInvoice.btnDoPaymentsClick(Sender: TObject);
begin
  inherited;
  if cbxFormOfPayment.ItemIndex = -1 then
     begin
     MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbInformation);
     if cbxFormOfPayment.CanFocus then
        cbxFormOfPayment.SetFocus;
     Exit;
     end;

  if Password.HasFuncRight(91) then
  begin
    CallEstimatedPayment;
    RefreshInvPayments;
  end
  else
  begin
    FinalizeHold(False);
    RefreshInvPayments;
    CanFinalizeLayaway;
  end;

end;

procedure TFrmInvoice.CanFinalizeLayaway;
begin

   if (not fShowTabPaymentType) or ((not IsLayaway) or IsInvoice) then
      Exit;

   if (not spquPreSaleItem.IsEmpty) and ((GetLayawayBalance = 0) or IsChield) then
      begin

      if (not DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_ON_SALE]) or
         (DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_ON_SALE] and
         (quPreSaleInfoDeliverConfirmation.AsBoolean)) then
         begin
           btClose.Visible       := True;
           btClose.Caption       := sFinalizar;
           btClose.Tag           := 3;
           btCancel.Visible      := False;
           btnDoPayments.Enabled := False;

           if (not DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_ON_SALE]) then
              btCancel.Visible := True;
         end
      else
         begin
           btClose.Visible       := False;
           btClose.Tag           := 1;
           btCancel.Visible      := True;
           btnDoPayments.Enabled := True;
         end;
      end
   else
      begin
      btClose.Visible       := False;
      btClose.Tag           := 1;
      btCancel.Visible      := True;
      if tbPaymentType.TabVisible then
         btnDoPayments.Enabled := True;
      end;

end;

procedure TFrmInvoice.btnDeliveryClick(Sender: TObject);

  function ValidadeDelivery : Boolean;
  var
    fQtyDelivered : Double;
    bHasDelivery : Boolean;
    i : Integer;
    AQtyAvaiable: Double;
  begin
    Result := False;

    if spquPreSaleItem.IsEmpty then
    begin
      MsgBox(MSG_INF_INVOICE_NOT_HAVE_ITEM, vbOKOnly + vbInformation);
      Exit;
    end;

    if ( fShowTabPaymentType and ((GetLayawayBalance <> 0) and (not IsChield)) ) then
    begin
      MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbCritical + vbOkOnly);
      Exit;
    end;

    if quPreSaleInfoDeliverDate.AsString  = '' then
    begin
      MsgBox(MSG_CRT_NO_DATE, vbCritical + vbOkOnly);
      if EditDelDate.CanFocus then
        EditDelDate.SetFocus;
      Exit;
    end;

    if quPreSaleInfoDeliverDate.AsDateTime < Date then
    begin
      MsgBox(MSG_CRT_DELIVER_DATE_SMALER, vbCritical + vbOkOnly);
      if EditDelDate.CanFocus then
        EditDelDate.SetFocus;
      Exit;
    end;

    if quPreSaleInfoDeliverAddress.AsString = '' then
    begin
      MsgBox(MSG_INF_NOT_EMPTY_ADDRESS, vbCritical + vbOkOnly);
      if EditDelAddress.CanFocus then
        EditDelAddress.SetFocus;
      Exit;
    end;

    //Verifica pgto antes de entregar
    if (FScreenType = CASHREG_TYPE_OFFICE) and
       (DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE] = True) and
       (not bIsExchangeItem) and
       DM.fSystem.SrvParam[PARAM_VERIFY_PGTO_BEFORE_DELIVERY] = True then
    begin
      if DM.fPOS.HasPaymentPending(quPreSaleInfoIDPreSale.AsInteger) then
      begin
        MsgBox(MSG_INF_PAYMENT_NOT_RECEIVE, vbCritical + vbOkOnly);
        Exit;
      end;
    end;

    if (FScreenType = CASHREG_TYPE_OFFICE) and
       (DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE] = True) and
       (not bIsExchangeItem) then
    begin
      spquPreSaleItem.DisableControls;
      spquPreSaleItem.First;
      try
        while not spquPreSaleItem.Eof do
        begin
          if ((spquPreSaleItemQty.AsFloat > 0) and
             (not spquPreSaleItemNotVerifyQty.AsBoolean)) then
          begin
            //Verificar estoque
            if not Password.HasFuncRight(8) then
            begin

              if DM.fPOS.IsNegativeStoreDelivery(quPreSaleInfoIDPreSale.AsInteger, DM.fStore.IDStoreSale, spquPreSaleItemModelID.AsInteger, AQtyAvaiable) then
              begin
                MsgBox(Format(MSG_CRT_INVENTORY_NEGATIVE, [spquPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;

              if (AQtyAvaiable - spquPreSaleItemQty.AsFloat) < 0 then
              begin
                MsgBox(Format(MSG_CRT_UNAVAIlABLE_INVENTORY, [spquPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;

            end;

            //Verificar entrega
            fQtyDelivered := DM.fPOS.QtyInDelivered(spquPreSaleItemModelID.AsInteger, DM.fStore.IDStoreSale, bHasDelivery);
            if (bHasDelivery) and (fQtyDelivered < spquPreSaleItemQty.AsFloat) then
            begin
              MsgBox(Format(MSG_CRT_MODEL_IS_IN_DELIVER, [spquPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
              Exit;
            end;

            //Validade last delivery
            if Password.HasFuncRight(87) then
              if not DM.fPOS.CanMarkDelivery(quPreSaleInfoIDPreSale.AsInteger, spquPreSaleItemModelID.AsInteger,
                                             quPreSaleInfoPreSaleDate.AsDateTime,
                                             AQtyAvaiable, spquPreSaleItemQty.AsFloat) then
              begin
                MsgBox(Format(MSG_CRT_CANNOT_MARK_DELIVER, [spquPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;
          end;
          spquPreSaleItem.Next;
        end;
      finally
        spquPreSaleItem.EnableControls;
      end;
    end;

    //Validate Delivery Hour
    if (DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR] <> -1) and (not Password.HasFuncRight(55)) then
      //if CompareDate(quPreSaleInfoDeliverDate.AsDateTime, (Now+1)) = 0 then
      if (Trunc(quPreSaleInfoDeliverDate.AsDateTime) = Trunc(Now+1)) then
        if (HourOf(Now) > DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR]) then
        begin
          i :=  DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR];
          MsgBox(Format(MSG_CRT_MARK_DELIVERY_NEXTDAY, [i]), vbCritical + vbOkOnly);
          Exit;
        end;

    Result := True;
  end;

var
  sDelivers: String;
begin
  inherited;

  if not quPreSaleInfoDeliverConfirmation.AsBoolean then
    if not ValidadeDelivery then
      Exit;

  if not (quPreSaleInfo.State in dsEditModes) then
    quPreSaleInfo.Edit;

  quPreSaleInfoDeliverConfirmation.AsBoolean := not quPreSaleInfoDeliverConfirmation.AsBoolean;
  OpenInvOBS;
  if not (quInvoiceOBS.State in (dsEditModes)) then
    quInvoiceOBS.Edit;
  quInvoiceOBS.FieldByName('IDUserDeliver').AsInteger := DM.fUser.ID;
  quInvoiceOBS.Post;

  RefreshDeliveryInfo;
  CanFinalizeLayaway;

  //Criar novo numero para hold
  CanCreateHoldNum;

  //Caso confirmado verificar se tem outros pedidos abertos
  if quPreSaleInfoDeliverConfirmation.AsBoolean then
  begin
    sDelivers := DM.fPOS.GetCustomerDeliverOpenHold(quPreSaleInfoIDCustomer.asInteger,
                                                     quPreSaleInfoIDPreSale.asInteger);
    if sDelivers <> '' then
      MsgBox(Format(MSG_INF_INVOICE_NOT_DELEVERED,
             [quPreSaleInfoFirstName.AsString + ' ' + quPreSaleInfoLastName.AsString, sDelivers]), vbInformation + vbOkOnly);
  end;
end;

procedure TFrmInvoice.RefreshDeliveryInfo;
begin
  if quPreSaleInfoDeliverConfirmation.AsBoolean then
  begin
    lbConfirmDelivery.Caption := sDeliveryOK;
    btnDelivery.Caption       := sDeliveryNConf;
  end
  else
  begin
    lbConfirmDelivery.Caption := '';
    btnDelivery.Caption       := sDeliveryConf;
  end;
end;

function TFrmInvoice.GetLayawayBalance: Currency;
var
   MyTotalInvoiceCurrency: currency;
begin

   MyTotalInvoiceCurrency := MyRound(spquPreSaleValueTotalInvoice.AsCurrency, 2);

   Result := MyTotalInvoiceCurrency -
             DM.fPOS.GetInvoicePayments(quPreSaleInfoIDPreSale.AsInteger);
end;

function TFrmInvoice.DoPay:Boolean;
var
  IDError, IDInvoice: Integer;
  ErrorMsg : String;
begin
  Result := True;

  if GetLayawayBalance <> 0 then
    Exit;

  if not ProcessInvoiceBonus then
  begin
    Result := False;
    Exit;
  end;

  try

    DM.ADODBConnect.BeginTrans;
    
    Result := DM.fPOS.PreSalePay(IDPreSale,
                                 quPreSaleInfoIDTouristGroup.AsInteger,
                                 quPreSaleInfoOtherComissionID.AsInteger,
                                 MyIDCashRegMov,
                                 DM.fStore.ID,
                                 Now,
                                 Now, //DueDate
                                 0, //CashReceived
                                 DM.FBonusSync.BonusValue,
                                 DM.FBonusSync.BonusCode,
                                 IDInvoice);

    if Result then
    begin
      DM.ADODBConnect.CommitTrans;
      iReceiptType   := RECEIPT_TYPE_LAYAWAY_RECEIVE;
      IsPrintReceipt := True;

      if DM.SaleHavePuppyTrackerItem(IDPreSale) then
      begin
        DM.SendPuppyInfo(IDInvoice);
        DM.SendPetCenterInfo(IDPreSale);
      end;
    end
    else
      raise Exception.Create('Error receiving');

  except
    on E: Exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      begin
        ErrorMsg := '';
        IDError := 0;
        DM.BonusVoid(DM.FBonusSync.BonusCode, IDError, ErrorMsg);
      end;
      DM.SetError(CRITICAL_ERROR, Self.Name, 'FrmInvoice.DoPay.Exception' + #13#10 + E.Message + ' ' + ErrorMsg);
    end;
  end;
end;

function TFrmInvoice.ValidadeHold: Boolean;
begin
  Result := True;

  if MyPreSaleType = SALE_CASHREG then
    if ((not IsInvoice) and (fShowTabPaymentType and IsLayaway)) and (DM.fSystem.SrvParam[PARAM_ENTER_LAYAWAY_FULL_AMOUNT]) then
      if (not spquPreSaleItem.IsEmpty) and ((GetLayawayBalance <> 0) and (not IsChield)) then
      begin
        MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbCritical + vbOkOnly);
        Result := False;
      end;
end;

function TFrmInvoice.IsDeliveryEnabled: Boolean;
begin
  if cmbDelType.LookUpValue <> '' then
    Result := (UpperCase(DM.DescCodigo(['IDDeliverType'], [cmbDelType.LookUpValue], 'DeliverType', 'CanConfirmDeliver')) <> 'FALSE');
end;

procedure TFrmInvoice.cmbDelTypeSelectItem(Sender: TObject);
var
  fIsExchange: Variant;
begin
  inherited;
  pnlConfirmDeliver.Visible := IsDeliveryEnabled;

  if pnlConfirmDeliver.Visible and (quPreSaleInfoDeliverAddress.AsString = '') then
  begin
    quPreSaleInfo.Edit;
    quPreSaleInfoDeliverAddress.asString := fCustomerAddress;
  end;

  fIsExchange := cmbDelType.GetFieldByName('CanExchangeItem');
  if fIsExchange <> Null then
    bIsExchangeItem := StrToBoolDef(fIsExchange, False)
  else
    bIsExchangeItem := False;
end;

procedure TFrmInvoice.SubPaymentTypeAfterParamChanged(Changes: String);
begin
  inherited;
  if ParseParam(Changes, 'DELETED') = 'TRUE' then
  begin
    btClose.Visible       := False;
    btClose.Tag           := 1;
    btCancel.Visible      := True;
    btnDoPayments.Enabled := True;
  end;
end;

procedure TFrmInvoice.sbHistoryClick(Sender: TObject);
begin
  inherited;
  with TFrmHistoryManage.Create(Self) do
    Start(quPreSaleInfoIDPreSale.AsInteger);
end;

procedure TFrmInvoice.ShowDivideHold(IDPreSale: Integer;sCustomerName: String);
var
  FrmSplitPreSale : TSplitPreSale;
begin
  FrmSplitPreSale := TSplitPreSale.Create(Self);
  FrmSplitPreSale.Start(IDPreSale,quPreSaleInfoIDCustomer.AsInteger,
                        sCustomerName, fCustomerAddress);
  TmrRefreshItemTimer(Self);
end;

procedure TFrmInvoice.btSplitHoldClick(Sender: TObject);
begin
  inherited;
  if not CanSplit then
    Exit;

  //Criar novo numero para hold
  CanCreateHoldNum;

  ShowDivideHold(IDPreSale, quPreSaleInfoFirstName.AsString + ' ' +quPreSaleInfoLastName.AsString);
end;

function TFrmInvoice.GetIsChield: Boolean;
begin
  Result := not quPreSaleInfoIDPreSaleParent.IsNull;
end;

procedure TFrmInvoice.ShowChildControls;
var
  IsParent : Boolean;
begin
  IsParent                 := not GetIsChield;

  //Se for Pai, nao deve fazer esses testes
  if IsParent then
    Exit;

  btSplitHold.Visible        := IsParent;
  tbOtherCosts.TabVisible    := IsParent;
  tbPaymentType.TabVisible   := IsParent;
  tbTourist.TabVisible       := IsParent;
  tbDeposit.TabVisible       := IsParent;
  tbDiscount.TabVisible      := IsParent;
  btAddItem.Visible          := IsParent;
  btnAddQuick.Enabled        := IsParent;
  btDiscountItem.Visible     := IsParent;
  btRemoveItem.Visible       := IsParent;
  btSerial.Visible           := IsParent;
  btUpHold.Visible           := IsParent;
  btRefund.Visible           := IsParent;
  btnEditDate.Visible        := IsParent;
  pnlCustomerAddress.Visible := IsParent;
end;

function TFrmInvoice.CanSplit : Boolean;
var
  fBalance : Double;
begin
  Result := False;
  if (GetLayawayBalance <> 0) then
  begin
    MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbCritical + vbOkOnly);
    Exit;
  end;

  if (spquPreSaleItem.RecordCount = 1) and (spquPreSaleItemQty.AsFloat = 1) then
  begin
    MsgBox(MSG_INF_CANNOT_SLIT_LESS2, vbCritical + vbOkOnly);
    Exit;
  end;

  if IsChield then
  begin
    MsgBox(MSG_INF_SPLITED_HOLD_DIVIDE, vbCritical + vbOkOnly);
    Exit;
  end;

  if quPreSaleInfoDeliverConfirmation.AsBoolean then
  begin
    MsgBox(MSG_CRT_NOT_SPLITED_DELIVER, vbCritical + vbOkOnly);
    Exit;
  end;

  Result := True;
end;

procedure TFrmInvoice.quPreSaleInfoDeliverDateValidate(Sender: TField);
var
  sMaxDays : String;
  Data : TDateTime;
  i : Integer;
begin
  inherited;
  if (cmbDelType.LookUpValue = '') or (quPreSaleInfoDeliverDate.Newvalue = null) then Exit;
  sMaxDays := DM.DescCodigo(['IDDeliverType'], [cmbDelType.LookUpValue], 'DeliverType', 'MaxDeliverDelay');
  if sMaxDays <> '' then
  begin
    Data := Trunc(quPreSaleInfoDeliverDate.Newvalue);//editDelDate.Date;
    if Data > (Date + StrToInt(sMaxDays)) then
      raise Exception.Create(MSG_INF_MAX_DELIVERY_DAYS1 + sMaxDays + MSG_INF_MAX_DELIVERY_DAYS2);
  end;

end;

procedure TFrmInvoice.SubCustomerAfterParamChanged(Changes: String);
var
  sResult: String;
begin
  inherited;

  if ParseParam(Changes, 'CHANGED')='TRUE' then
  begin
    if not (quPreSaleInfo.State in dsEditModes) then
      quPreSaleInfo.Edit;
    sResult                         := SubCustomer.GetSubListInfo(sResult);
    fCustomerAddress                := Trim(ParseParam(sResult, 'ADDRESS'));
    quPreSaleInfoFirstName.ASString := Trim(ParseParam(sResult, 'FIRSTNAME'));
    quPreSaleInfoLastName.ASString  := Trim(ParseParam(sResult, 'LASTNAME'));

    pnlCustomerAddress.Visible := StrToIntDef(Trim(ParseParam(sResult, 'NUMOFADDRESS')), 0) > 0;
    RefreshCustomerAddress(StrToIntDef(ParseParam(sResult, 'IDCUSTOMER'), 1));

    if pnlConfirmDeliver.Visible and (quPreSaleInfoDeliverAddress.AsString <> '') then
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoDeliverAddress.asString := fCustomerAddress;
    end;
  end;
end;

procedure TFrmInvoice.CanCreateHoldNum;
begin
  if (not DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE]) and (sSaleCode='') then
    sSaleCode := DM.fPOS.CreateSaleCode(IDPreSale, 0, DM.fStore.ID);
end;

procedure TFrmInvoice.cbxTypeChange(Sender: TObject);
begin
  inherited;
  case cbxType.ItemIndex of
   0: begin
        spnSpecialDiscount.Visible := True;
        edtDollarDiscount.Visible  := False;
        spnSpecialDiscount.Value   := 0;
      end;
   1: begin
        spnSpecialDiscount.Visible := False;
        edtDollarDiscount.Visible  := True;
        edtDollarDiscount.Text     := '0';
      end;
  end;

  edtDisTotalInv.Text := FormatFloat(DM.FQtyDecimalFormat,
                           spquPreSaleValueTotalInvoice.AsCurrency +
                           spquPreSaleValueInvoiceDiscount.AsCurrency);
end;

procedure TFrmInvoice.btCommissionsClick(Sender: TObject);
begin
  if not Password.HasFuncRight(63) then
  begin
    MsgBox(MSG_INF_NOT_MODIFY_COMMISSION, vbOKOnly + vbInformation);
    Exit;
  end;

  DM.fPOS.AddCommissionsList(spquPreSaleItemIDInventoryMov.AsInteger,MyPreSaleType);

  with TFrmAddItemCommission.Create(Self) do
    Start(1, ApplyAll);

  UpdateCommissions;
  DM.fPOS.ClearCommissionList;
  RefreshItem(0);
end;

procedure TFrmInvoice.UpdateCommissions;
var i : Integer;
    PreSaleType : String;
begin
  if DM.fPOS.fCommisList.Count > 0 then
    if ApplyAll then
    begin
      spquPreSaleItem.First;

      while not spquPreSaleItem.Eof do
      begin
        DM.fPOS.AddSaleItemCommission(spquPreSaleItemIDInventoryMov.AsInteger,MyPreSaleType);
        spquPreSaleItem.Next;
      end;
    end
    else
      DM.fPOS.AddSaleItemCommission(spquPreSaleItemIDInventoryMov.AsInteger,MyPreSaleType);
end;

procedure TFrmInvoice.PrintReceipt(iPrinType : Integer; arg_objInfocash: InfoCashSale);
begin
  try
    try
      //Self.Enabled := False;
      with TPrintReceipt.Create(Self) do
        Start(IDPreSale, iPrinType, FPaymentChange, arg_objInfocash); 
    finally
      //Self.Enabled := True;
      end;
  except
    on E: Exception do
    begin
       DM.SetError(CRITICAL_ERROR, Self.Name, 'FrmInvoice.PrintDocument.Exception' + #13#10 + E.Message);
       MsgBox(MSG_CRT_ERROR_PRINT, vbCritical + vbOkOnly);
    end;
  end;
end;

procedure TFrmInvoice.grdItemsDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(TcxCustomGridTableView(grdItems.FocusedView)).Controller.Customization;
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

procedure TFrmInvoice.btColumnClick(Sender: TObject);
begin
  inherited;
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmInvoice.SetCustomerProperties;
var
  sCustomerProperties: String;
begin
  sCustomerProperties := SubCustomer.GetSubListInfo('');

  if StrToInt(ParseParam(sCustomerProperties, 'IDCUSTOMER')) <> -1 then
    if quPreSaleInfoIDCustomer.AsInteger <> StrToInt(ParseParam(sCustomerProperties, 'IDCUSTOMER')) then
    begin
      if not (quPreSaleInfo.State in dsEditModes) then
        quPreSaleInfo.Edit;

      quPreSaleInfoIDCustomer.AsInteger := StrToInt(ParseParam(sCustomerProperties, 'IDCUSTOMER'));
      quPreSaleInfoFirstName.AsString   := ParseParam(sCustomerProperties, 'FIRSTNAME');
      quPreSaleInfoLastName.AsString    := ParseParam(sCustomerProperties, 'LASTNAME');
      quPreSaleInfoAddress.AsString     := ParseParam(sCustomerProperties, 'ADDRESS');
      quPreSaleInfoZip.AsString         := ParseParam(sCustomerProperties, 'ZIP');
    end;
end;

procedure TFrmInvoice.grdItemsDBDblClick(Sender: TObject);
begin
  inherited;
  if IsInvoice then
    //btSerialClick(nil)
  else
    btDiscountItemClick(nil);
end;

procedure TFrmInvoice.edtDisTotalInvCurrChange(Sender: TObject);
begin
  inherited;
  if edtDisTotalInv.Focused then
    case cbxType.ItemIndex of
      0: begin
           if spquPreSaleValueSubTotal.AsCurrency <> 0 then
             spnSpecialDiscount.Value := FormatFloat(DM.FQtyDecimalFormat, ((spquPreSaleValueSubTotal.AsCurrency - MyStrToMoney(edtDisTotalInv.Text)) / spquPreSaleValueSubTotal.AsCurrency)* power(10, DM.FQtyDecimal))
           else
             spnSpecialDiscount.Value := FormatFloat(DM.FQtyDecimalFormat, 0);
         end;
      1: edtDollarDiscount.Text := FormatFloat(DM.FQtyDecimalFormat,
           spquPreSaleValueSubTotal.AsCurrency -
           MyStrToMoney(edtDisTotalInv.Text));
    end;
end;

procedure TFrmInvoice.btnAddOBSClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmAddInvoiceOBS) then
    FrmAddInvoiceOBS := TFrmAddInvoiceOBS.Create(Self);

  if not (dsPreSaleInfo.State in dsEditModes) then
    quPreSaleInfo.Edit;

  quPreSaleInfoNote.AsString := quPreSaleInfoNote.AsString + FrmAddInvoiceOBS.Start;
end;

procedure TFrmInvoice.btnAddQuickClick(Sender: TObject);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  pmAddItem.Popup(P.X, P.Y);
end;

procedure TFrmInvoice.miQuickEntryClick(Sender: TObject);
begin
  inherited;
  //
end;

function TFrmInvoice.ValidateDiscountPercente(ADiscount: Currency): Boolean;
var
  dPercDisc: Double;
begin
  dPercDisc := 0;

  with quDiscRange do
  begin
    First;

    while not Eof do
    begin
      if spquPreSaleValueSubTotal.AsCurrency > FieldByName('TotVendaMin').AsCurrency then
        dPercDisc := FieldByName('PercDiscMax').AsFloat;
      Next;
    end;

    First;
  end;

  if dPercDisc = 0 then
    Result := True
  else
    Result := (ADiscount <= dPercDisc);
    
end;

function TFrmInvoice.ValidateInvoiceDiscount(ADiscount: Currency): Boolean;
var
  dPercDisc: Double;
  cValidDiscount: Currency;
begin
  dPercDisc := 0;

  with quDiscRange do
  begin
    First;

    while not Eof do
    begin
      if spquPreSaleValueSubTotal.AsCurrency > FieldByName('TotVendaMin').AsCurrency then
        dPercDisc := FieldByName('PercDiscMax').AsFloat;
      Next;
    end;

    First;
  end;

  if dPercDisc = 0 then
    Result := False
  else
  begin
    cValidDiscount := spquPreSaleValueSubTotal.AsCurrency * (dPercDisc / power(10, DM.FQtyDecimal));
    Result := cValidDiscount >= ADiscount;
  end;
end;

procedure TFrmInvoice.spnSpecialDiscountPropertiesChange(Sender: TObject);
begin
  inherited;
  if spnSpecialDiscount.Focused then
  begin
    btApplyPriceManager.enabled := (spnSpecialDiscount.Value >= 0) and
                                   (spnSpecialDiscount.Value <= 100);

    if btApplyPriceManager.enabled then
      edtDisTotalInv.Text := FormatFloat(DM.FQtyDecimalFormat,
                                         spquPreSaleValueSubTotal.AsCurrency -
                                         (spquPreSaleValueSubTotal.AsCurrency * (spnSpecialDiscount.Value / power(10, DM.FQtyDecimal))));
  end;
end;

procedure TFrmInvoice.SubCustomerDataChange;
begin
  inherited;
  if pnlConfirmDeliver.Visible and (quPreSaleInfoDeliverAddress.AsString <> '') then
  begin
    quPreSaleInfo.Edit;
    quPreSaleInfoDeliverAddress.asString := fCustomerAddress;
  end;
end;

procedure TFrmInvoice.RefreshPasswordOption;
var
  bCanSeeCost: Boolean;
begin
  bCanSeeCost := Password.HasFuncRight(11);
  grdItemsDBCostPrice.Hidden := not bCanSeeCost;
  btColumn.Enabled := bCanSeeCost;

  btSpecialPrice.visible := Password.HasFuncRight(41);
end;

procedure TFrmInvoice.edtDisTotalInvKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if cbxType.ItemIndex <> 1 then
  begin
    cbxType.ItemIndex := 1;
    cbxTypeChange(Self);
  end;
end;

procedure TFrmInvoice.btnRemoveGroupClick(Sender: TObject);
begin
  inherited;
  quPreSaleInfo.Edit;
  quPreSaleInfoIDTouristGroup.AsVariant := Null;
  UpdateTouristChildGroup(-1);
  AtuDescTourist;
end;

procedure TFrmInvoice.CloseInvOBS;
begin
  with quInvoiceOBS do
    if Active then
      Close;
end;

procedure TFrmInvoice.OpenInvOBS;
begin
  with quInvoiceOBS do
  begin
    if not Active then
    begin
      Parameters.ParamByName('IDPreSale').Value := IDPreSale;
      Open;
    end;

    if IsEmpty then
    begin
      Append;
      FieldByName('IDInvoiceOBS').AsInteger := DM.GetNextID('InvoiceOBS.IDInvoiceOBS');;
      FieldByName('IDPreSale').AsInteger := IDPreSale;
    end;
  end;
end;

procedure TFrmInvoice.RefreshInvOBS;
begin
  CloseInvOBS;
  OpenInvOBS;
end;

procedure TFrmInvoice.scCFOPSelectItem(Sender: TObject);
begin
  inherited;
  if not (quPreSaleInfo.State in dsEditModes) then
    quPreSaleInfo.Edit;
end;

procedure TFrmInvoice.scPessoaTaxSelectItem(Sender: TObject);
begin
  inherited;
  if not (quPreSaleInfo.State in dsEditModes) then
    quPreSaleInfo.Edit;
end;

procedure TFrmInvoice.scFilterPessoaTaxSelectItem(Sender: TObject);
begin
  inherited;
  if scFilterPessoaTax.LookUpValue = '' then
    scPessoaTax.SpcWhereClause := ''
  else
    scPessoaTax.SpcWhereClause := 'IDTipoPessoa = ' + scFilterPessoaTax.LookUpValue;
end;

procedure TFrmInvoice.scFilterCarrierSelectItem(Sender: TObject);
begin
  inherited;
  if scFilterCarrier.LookUpValue = '' then
    scCarrier.SpcWhereClause := ''
  else
    scCarrier.SpcWhereClause := 'IDTipoPessoa = ' + scFilterCarrier.LookUpValue;
end;

procedure TFrmInvoice.quInvoiceOBSBeforePost(DataSet: TDataSet);
begin
  inherited;
  if cbxFreightType.ItemIndex <> -1 then
  begin
    if not (quInvoiceOBS.State in dsEditModes) then
    begin
      quInvoiceOBS.Edit;
      quPreSaleInfo.Edit;
    end;

    quInvoiceOBSFreightType.AsInteger := (cbxFreightType.ItemIndex+1);
  end;
end;

procedure TFrmInvoice.quInvoiceOBSAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if quInvoiceOBSFreightType.AsInteger <> 0 then
    cbxFreightType.ItemIndex := quInvoiceOBSFreightType.AsInteger-1;

end;

procedure TFrmInvoice.cbxFreightTypeChange(Sender: TObject);
begin
  inherited;

  if not (quInvoiceOBS.State in dsEditModes) then
  begin
    quInvoiceOBS.Edit;
    quPreSaleInfo.Edit;
  end;

end;

procedure TFrmInvoice.quPreSaleInfoBeforeClose(DataSet: TDataSet);
begin
  inherited;
  CloseInvOBS;
end;

procedure TFrmInvoice.UpdateTouristChildGroup(IDTrouristGroup: Integer);
var
  SQL : String;
begin
  if IDTrouristGroup = -1 then
    SQL := 'UPDATE Invoice Set IDTouristGroup = NULL WHERE IDPreSaleParent = ' + quPreSaleInfoIDPreSale.AsString
  else
    SQL := 'UPDATE Invoice Set IDTouristGroup = '+ IntToStr(IDTrouristGroup)+ ' WHERE IDPreSaleParent = ' + quPreSaleInfoIDPreSale.AsString;

  DM.RunSQL(SQL);  
end;

procedure TFrmInvoice.CallEstimatedPayment;
begin

  with TFrmEstimatedInfo.Create(Self) do
    StartPreSale(quPreSaleInfoIDPreSale.AsInteger, spquPreSaleValueTotalInvoice.AsFloat);

end;

procedure TFrmInvoice.scCustomerAddressSelectItem(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
    quPreSaleInfo.Edit;

  quPreSaleInfoDeliverAddress.AsString := scCustomerAddress.GetFieldByName('Address');

end;

procedure TFrmInvoice.RefreshCustomerAddress(IDCustomer : Integer);
begin

  if pnlCustomerAddress.Visible then
  begin
    scCustomerAddress.SpcWhereClause := 'IDPessoa = ' + IntToStr(IDCustomer);
    OpenInvOBS;
  end;

end;

procedure TFrmInvoice.btnEditDateClick(Sender: TObject);
begin
  inherited;

  with TSetDelPreSaleDate.Create(Self) do
      Start(IDPreSale);

  grdItems.SetFocus;

end;

procedure TFrmInvoice.btRefundClick(Sender: TObject);
var
  iResult : Integer;
  iIDRefund: Integer;
  dRefundDate : TDatetime;
  InvoiceNum : String;
begin
  inherited;

  InvoiceNum := InputBox(sInvNumText, sInvNum, '');
  setSignalDiscount(false, false, false);
  if Trim(InvoiceNum) <> '' then
    with TFrmInvoiceRefund.Create(Self) do
      if Start(quPreSaleInfoIDPreSale.AsInteger, InvoiceNum, iIDRefund, dRefundDate) <> 0 then
      begin
(*
        // Antonio 2103 Oct 28
        FInvoiceInfo.IDPreSaleRefund := iIDRefund;
        FInvoiceInfo.RefundDate := dRefundDate;
*)        
        RefreshItem(0);
        //Antonio 2012 May 31 - deal sign to sale or refund
        setSignalDiscount(false, false, true);
      end;

end;

procedure TFrmInvoice.edtDollarDiscountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmInvoice.edtDollarDiscountCurrChange(Sender: TObject);
begin
  inherited;

  if edtDollarDiscount.Focused then
    edtDisTotalInv.Text := FormatFloat(DM.FQtyDecimalFormat,
      spquPreSaleValueSubTotal.AsCurrency - MyStrToMoney(edtDollarDiscount.Text));

end;

function TFrmInvoice.ProcessInvoiceBonus: Boolean;
var
  BonusBucks: TBonusBucks;
  cDiscountValue, cTotalInvoice: Currency;
  BonusCode : String;
  IDError : Integer;
  ErrorMsg : String;
  sInvoiceNum : String;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.ProcessInvoiceBonus');

  Result := True;
  try
      BonusCode := '';
      DM.FBonusSync.BonusCode := '';
      DM.FBonusSync.BonusValue := 0;

      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      try
        BonusBucks                  := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
        BonusBucks.IDPreSaleCreated := quPreSaleInfo.FieldByName('IDPreSale').AsInteger;
        cDiscountValue              := BonusBucks.DiscountValue;
        sInvoiceNum                 := quPreSaleInfo.FieldByName('SaleCode').AsString;
        cTotalInvoice               := spquPreSaleValueTotalInvoice.AsFloat;

        if cDiscountValue > 0 then
          if not DM.BonusGenerate(cTotalInvoice, cDiscountValue, sInvoiceNum, Trunc(Now), BonusCode, IDError, ErrorMsg) then
          begin
            DM.FBonusSync.BonusValue := 0;
            if (MsgBox(MSG_QST_PROCESS_BONUS + ErrorMsg, vbYesNo + vbQuestion) = vbNo) then
            begin
              Result := False;
              Exit;
            end;
          end;

      finally
        FreeAndNil(BonusBucks);
      end;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'TFrmInvoice.ProcessInvoiceBonus');
      Result := False;
    end;
  end;

  DM.FTraceControl.TraceOut;
  
end;

procedure TFrmInvoice.btnRepostPuppyClick(Sender: TObject);
var
   objPuppyInteg: TMRPuppyIntegration;
   hasRefund: Boolean;
begin
  inherited;
  try
    DebugToFile('creating a puppyIntegration object');
    objPuppyInteg := TMRPuppyIntegration.Create(dm.ADODBConnect);
    DebugToFile('calling PuppySoldPuppyTracker method');
    objPuppyInteg.PuppySoldToPuppyTracker(quPreSaleInfoIDInvoice.AsInteger, IDPreSale, false );
  finally
    freeAndNil(objPuppyInteg);
    DebugToFile('destroying puppyIntegration object ');
  end;
end;

procedure TFrmInvoice.setSignalDiscount(pHasSaleDiscount, pHasItemDiscount,
  prefund: boolean);
begin
   lblSaleDiscountSign.Visible := pHasSaleDiscount;
   lblItemDiscountSign.Visible := pHasItemDiscount;

   if ( prefund ) then
       lblSaleDiscountSign.Caption := '+'
   else
       lblSaleDiscountSign.Caption := '-';

   if ( prefund ) then
       lblItemDiscountSign.Caption := '+'
   else
       lblItemDiscountSign.Caption := '-';
end;

procedure TFrmInvoice.showTotalInvoice;
var
  invoiceInfo: TInvoiceInfo;
begin
  try
    try
      invoiceInfo := TInvoiceInfo.Create(dm.ADODBConnect);
      invoiceInfo.treatInvoiceTotals(spquPresaleValue);

      // Labels
      subtotalDisplay.caption := floatToStrF(InvoiceInfo.subtotal, ffNumber, 11, 2);
      itemDiscountDisplay.caption := floatToStrF(InvoiceInfo.itemsDiscount, ffNumber, 11, 2);
      saleDiscountDisplay.caption := floatToStrF(InvoiceInfo.InvoiceDiscount, ffNumber, 11, 2);
      taxDisplay.caption := floatToStrF(InvoiceInfo.tax, ffNumber, 11, 2);
      totalInvoiceDisplay.Caption := floatToStrF(InvoiceInfo.TotalInvoice, ffNumber, 11, 2);
      totalSavedDisplay.caption := floatToStrF(InvoiceInfo.totalDiscount, ffNumber, 11, 2);
      totalSavedDisplay.caption := floatToStrF(InvoiceInfo.totalDiscount, ffNumber, 11, 2);
      otherCostsDisplay.caption := floatToStrF(InvoiceInfo.AddExpens, ffNumber, 11, 2);

    except
      on e: Exception do begin
        raise Exception.Create(format('Error to get Total to Invoice: %s', [e.Message]));
      end;
    end;
  finally
      freeAndNil(invoiceInfo);
  end;
end;

end.

