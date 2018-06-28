(*
-----------------------------------------------------------------------------------------------------

Version : (288 - 282)
Date    : 02.22.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Connection is lost when user backs to adjust routine (press adjust button).
Solution: After refresh, quForm got lost references.
Version : (288 - 283)
-----------------------------------------------------------------------------------------------------

Version : (288 - 281)
Date    : 02.18.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : quForm IdModel not found
Solution: change name of parameter to position inside query object.
Version : (288 - 282)
-----------------------------------------------------------------------------------------------------
*)


unit uFchModel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, Variants,
  LblEffct, ExtCtrls, FormConfig, Grids, ComCtrls, DBGrids,
  uFrmNewBarCode, Buttons, PaideFichaTab, uInvoice, SuperEdit,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, DateBox, RadioButtonAll,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, SMDBGrid, SubListPanel, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, uInventoryCalc,
  mrBarCodeEdit, uDMInventory, uFrmBarcodeSearch, DBClient, uFrmModelPrice,
  cxImageComboBox, cxDBEdit;

const
    COL_SPACE = 10;

type
  TFchModel = class(TbrwFrmParent)
    quBarCode: TADOQuery;
    dsBarCode: TDataSource;
    quBarCodeIDModel: TIntegerField;
    quBarCodeIDBarcode: TStringField;
    quBarCodeData: TDateTimeField;
    quAddSpecialPrice: TADOQuery;
    quSpecialPrice: TADOQuery;
    dsSpecialPrice: TDataSource;
    quRemoveSpecialPrice: TADOQuery;
    quKitModel: TADOQuery;
    quKitModelSellingPrice: TFloatField;
    dsKitModel: TDataSource;
    quKitModelIDModel: TIntegerField;
    dsQuantity: TDataSource;
    spquQuantity: TADOStoredProc;
    spquQuantityName: TStringField;
    spquQuantityCurrentCost: TFloatField;
    spquQuantityStoreID: TIntegerField;
    quInvHold: TADOQuery;
    quInvHoldIDPreSale: TIntegerField;
    quInvHoldPreSaleDate: TDateTimeField;
    DsInvHold: TDataSource;
    quSerial: TADOQuery;
    dsSerial: TDataSource;
    quSerialName: TStringField;
    quSerialSerial: TStringField;
    quSerialStoreID: TIntegerField;
    quInvHoldFirstName: TStringField;
    quInvHoldLastName: TStringField;
    quGrid: TADOQuery;
    quGridIDModel: TIntegerField;
    quGridColor: TStringField;
    quGridCodColor: TStringField;
    quGridSizeName: TStringField;
    quGridCodSize: TStringField;
    quGridSellingPrice: TFloatField;
    quGridSuggRetail: TFloatField;
    Panel5: TPanel;
    pnlMaster: TPanel;
    Label11: TLabel;
    Label14: TLabel;
    Label32: TLabel;
    Label37: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label2: TLabel;
    EditModel: TDBEdit;
    DBEditDescription: TDBEdit;
    scSubManufacture: TDBSuperComboADO;
    cmbGroup: TDBSuperComboADO;
    pnlAlways: TPanel;
    lblColor: TLabel;
    lblSize: TLabel;
    scColor: TDBSuperComboADO;
    scSize: TDBSuperComboADO;
    pgModel: TPageControl;
    tsGrid: TTabSheet;
    sgGrid: TStringGrid;
    pnlTitle1: TPanel;
    tbCostRetail: TTabSheet;
    pnlSalePrice: TPanel;
    lbOurPrice1: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    lbMSRP1: TLabel;
    pnlTitle3: TPanel;
    EditSalePrice: TDBEdit;
    DBEdit2: TDBEdit;
    pnlCost: TPanel;
    Label12: TLabel;
    Label4: TLabel;
    Label18: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    Label3: TLabel;
    pnlTitle2: TPanel;
    editNetCost: TDBEdit;
    editOtherCost: TDBEdit;
    editFreightCost: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit11: TDBEdit;
    dbLastCost: TDBEdit;
    pnlQuantity: TPanel;
    pnlTitle4: TPanel;
    tbSpecialPrice: TTabSheet;
    Panel10: TPanel;
    btRemoveBarCode: TSpeedButton;
    btAddBarCode: TSpeedButton;
    pnlTitle5: TPanel;
    Panel9: TPanel;
    btAddSpecialPrice: TSpeedButton;
    btRemoveSpecialPrice: TSpeedButton;
    pnlTitle6: TPanel;
    tbKitModel: TTabSheet;
    Panel13: TPanel;
    pnlTitle7: TPanel;
    Panel16: TPanel;
    btAddSerial: TSpeedButton;
    btSerialRemove: TSpeedButton;
    pnlTitle8: TPanel;
    tbPurcHistory: TTabSheet;
    pnlTitle9: TPanel;
    tbSaleHist: TTabSheet;
    pnlTitle10: TPanel;
    tbMovHistory: TTabSheet;
    pnlTitle11: TPanel;
    tbMovTotal: TTabSheet;
    pnlTitle12: TPanel;
    tbOrder: TTabSheet;
    pnlTitle13: TPanel;
    tbInvoicesHold: TTabSheet;
    pnlTitle14: TPanel;
    tsOrderPoint: TTabSheet;
    Label9: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label40: TLabel;
    Label39: TLabel;
    Label26: TLabel;
    Label41: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit8: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    pnlTitle15: TPanel;
    pnlLookUp: TPanel;
    Label10: TLabel;
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    btBarcodeSearch: TSpeedButton;
    scLookUp: TSuperComboADO;
    rbLookByModel: TRadioButton;
    rbLookByBarCode: TRadioButton;
    btAddColor: TSpeedButton;
    btAddSize: TSpeedButton;
    Shape3: TShape;
    lbCustoMedio: TLabel;
    edtAvgCosta: TDBEdit;
    quSpecialPriceIDSpecialPrice: TIntegerField;
    quSpecialPriceSpecialPrice: TStringField;
    quSpecialPriceMarkUp: TBCDField;
    lblSubTip: TLabel;
    btKitAdd: TSpeedButton;
    btKitRemove: TSpeedButton;
    DBEdit9: TDBEdit;
    lbLastMovDate: TLabel;
    lbTotalOnHand: TLabel;
    btEditSerial: TSpeedButton;
    btnPrintBarcode: TSpeedButton;
    btnAddSizeColor: TSpeedButton;
    chkQtyUpdate: TCheckBox;
    grdBarcode: TSMDBGrid;
    grdSpecialPrice: TSMDBGrid;
    grdSerial: TSMDBGrid;
    SubListPurHistory: TSubListPanel;
    SubListSalesHistory: TSubListPanel;
    SubListMovHistory: TSubListPanel;
    SubListMovTotal: TSubListPanel;
    SubListOrderHistory: TSubListPanel;
    tsPackModel: TTabSheet;
    dsPackModel: TDataSource;
    quPackModel: TADOQuery;
    quPackModelIDPackModel: TIntegerField;
    quPackModelIDModel: TIntegerField;
    quPackModelModel: TStringField;
    quPackModelDescription: TStringField;
    quPackModelSellingPrice: TBCDField;
    quPackModelVendorCost: TBCDField;
    quPackModelFinalCost: TBCDField;
    Panel15: TPanel;
    Label88: TLabel;
    Label93: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    edtNumPack: TEdit;
    edtPackCost: TEdit;
    edtPackSale: TEdit;
    btnCalcPrice: TButton;
    Panel38: TPanel;
    btnAddPack: TSpeedButton;
    btnRemovePack: TSpeedButton;
    Label82: TLabel;
    Label83: TLabel;
    Label86: TLabel;
    gridPackModel: TSMDBGrid;
    scModelPack: TSuperComboADO;
    edtQtyOut: TEdit;
    tsInternet: TTabSheet;
    quAccessory: TADOQuery;
    dsAccessory: TDataSource;
    quAccessoryIDInvAccessory: TIntegerField;
    quAccessoryIDModel: TIntegerField;
    quAccessoryModel: TStringField;
    quAccessoryDescription: TStringField;
    pgWebInfo: TPageControl;
    tsWebImagems: TTabSheet;
    tsAccessory: TTabSheet;
    SubListInternet: TSubListPanel;
    Panel8: TPanel;
    btAddAccessory: TSpeedButton;
    btDelAccessory: TSpeedButton;
    lbAccessory: TLabel;
    lbAccHint: TLabel;
    pnlAccessTitle: TPanel;
    gridAccessory: TSMDBGrid;
    scModelAccessory: TSuperComboADO;
    edtAccessotyHint: TEdit;
    quFeatures: TADOQuery;
    dsFeatures: TDataSource;
    quFeaturesIDInvFeatures: TIntegerField;
    quFeaturesFeature: TStringField;
    tsFeatures: TTabSheet;
    Panel11: TPanel;
    btnAddFeature: TSpeedButton;
    btnDelFeature: TSpeedButton;
    lbFeatures: TLabel;
    pnlFeatures: TPanel;
    grdFeatures: TSMDBGrid;
    edtFeature: TEdit;
    Panel12: TPanel;
    btnTechAdd: TSpeedButton;
    btnTechDel: TSpeedButton;
    lbTechFeatures: TLabel;
    pnlTechFeature: TPanel;
    grdInvTech: TSMDBGrid;
    edtTechFeature: TEdit;
    quTechFeature: TADOQuery;
    dsTechFeature: TDataSource;
    quTechFeatureIDInvTechFeatures: TIntegerField;
    quTechFeatureTechFeature: TStringField;
    pnlFloatPercent: TPanel;
    lbFloatPercent: TLabel;
    edtFloatPercent: TDBEdit;
    SubListInternet2: TSubListPanel;
    pnlTaxWithCost: TPanel;
    lbOurPrice2: TLabel;
    Shape4: TShape;
    lbIqual1: TLabel;
    lbActuMarkUp2: TLabel;
    lbMarkUp2: TLabel;
    lbPluss2: TLabel;
    lbLastUpdate2: TLabel;
    pnlTitle16: TPanel;
    DBEdit10: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    btnCalcSaleTax: TButton;
    SubRecalcSalePrice: TSubListPanel;
    Shape5: TShape;
    Shape6: TShape;
    edtAvgCost2: TStaticText;
    pnlCustomQty: TPanel;
    lbCostRepos: TLabel;
    lbLastPurRepos: TLabel;
    lbCustoMedio1: TLabel;
    pnlCalcCostRepos: TPanel;
    DBEdit20: TDBEdit;
    DBEdit24: TDBEdit;
    edtAvgCost3: TStaticText;
    DBEdit21: TDBEdit;
    lbCustoReposition: TLabel;
    Shape8: TShape;
    lbSaleTax: TLabel;
    edtSalePlusTax: TStaticText;
    lbSun2: TLabel;
    lbActualCost: TLabel;
    edtActualCost: TStaticText;
    lbPlus3: TLabel;
    tsAdvanced: TTabSheet;
    quGridDesativado: TIntegerField;
    lbPromotion: TLabel;
    DBEdit19: TDBEdit;
    lbDiscountPerc: TLabel;
    DBEdit22: TDBEdit;
    lbSalePriceInfo: TLabel;
    DBEdit25: TDBEdit;
    quVendorCode: TADOQuery;
    quVendorCodeIDVendorModelCode: TIntegerField;
    quVendorCodeIDPessoa: TIntegerField;
    quVendorCodeIDModel: TIntegerField;
    quVendorCodeVendorCode: TStringField;
    quVendorCodeVendor: TStringField;
    DBEdit1: TDBEdit;
    lbModelSubGroup: TLabel;
    scModelSubGroup: TDBSuperComboADO;
    spModelSizeColorName: TADOStoredProc;
    pnlFranchiseCost: TPanel;
    lbCostStore: TLabel;
    Shape7: TShape;
    lbStoreAvg: TLabel;
    pnlStoreCost: TPanel;
    pnlFranchaseSale: TPanel;
    lbStoreSellPrice: TLabel;
    Shape9: TShape;
    pnlStoreSale: TPanel;
    edtStoreAvgCost: TStaticText;
    edtStoreCost: TStaticText;
    edtStoreSalle: TStaticText;
    quStorePrice: TADODataSet;
    quStorePriceSellingPrice: TBCDField;
    quStorePriceStoreCostPrice: TBCDField;
    quStorePriceStoreAvgPrice: TBCDField;
    scModelGroup: TDBSuperComboADO;
    lbModelGroup: TLabel;
    quKitModelQty: TFloatField;
    spquQuantityQtyOnPreSale: TFloatField;
    spquQuantityQtyOnHand: TFloatField;
    spquQuantityQtyOnOrder: TFloatField;
    spquQuantityQtyOnRepair: TFloatField;
    spquQuantityQtyOnPrePurchase: TFloatField;
    spquQuantityFloatPercent: TIntegerField;
    quInvHoldQty: TFloatField;
    quPackModelQty: TFloatField;
    quPackModelTotQtyOnHand: TFloatField;
    quGridTotQtyOnHand: TFloatField;
    pgModelInfo: TPageControl;
    tsModelInfo: TTabSheet;
    tsVendorInfo: TTabSheet;
    Panel6: TPanel;
    pnlModelConfig: TPanel;
    chkNotCheckQty: TDBCheckBox;
    chkDisableItem: TCheckBox;
    chkHiddenItem: TCheckBox;
    chkAskSalePrice: TDBCheckBox;
    Panel14: TPanel;
    lbMeasure: TLabel;
    lbWeight: TLabel;
    lbCaseQty: TLabel;
    lbModelSubGroup2: TLabel;
    lbModelGroup2: TLabel;
    pnlModelMeasure: TPanel;
    scUnidade: TDBSuperComboADO;
    DBEdit23: TDBEdit;
    DBEdit26: TDBEdit;
    scModelSubGroup2: TDBSuperComboADO;
    scModelGroup2: TDBSuperComboADO;
    pnlVendorList: TPanel;
    btnRemoveVendorList: TSpeedButton;
    btnAddVendorList: TSpeedButton;
    pnlVendorOrder: TPanel;
    quModelVendor: TADOQuery;
    dsModelVendor: TDataSource;
    quModelVendorIDPessoa: TIntegerField;
    quModelVendorIDModel: TIntegerField;
    quModelVendorVendorOrder: TIntegerField;
    quModelVendorVendor: TStringField;
    btnModelVendorUP: TSpeedButton;
    btnModelVendorDown: TSpeedButton;
    edtBarcode: TmrBarCodeEdit;
    btnSearchDesc: TBitBtn;
    tsPrintReceipt: TTabSheet;
    pnlModelReceipt: TPanel;
    btRemoveModelReceipt: TSpeedButton;
    btAddModelReceipt: TSpeedButton;
    pnlReceiptTextTitle: TPanel;
    SMDBGrid1: TSMDBGrid;
    quModelReceipt: TADOQuery;
    dsModelReceipt: TDataSource;
    quModelReceiptIDModelReceipt: TStringField;
    quModelReceiptReceiptText: TStringField;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    quBarCodeBarcodeOrder: TIntegerField;
    quModelVendorMinQtyPO: TFloatField;
    chkSendToTrash: TDBCheckBox;
    pnlCaseCost: TPanel;
    lbCaseCost: TLabel;
    edtCaseCost: TSuperEdit;
    grdKitModelDBTableView: TcxGridDBTableView;
    grdKitModelLevel: TcxGridLevel;
    grdKitModel: TcxGrid;
    grdKitModelDBTableViewSellingPrice: TcxGridDBColumn;
    grdKitModelDBTableViewIDModel: TcxGridDBColumn;
    grdKitModelDBTableViewQty: TcxGridDBColumn;
    grdKitModelDBMarginPer: TcxGridDBColumn;
    quKitModelMarginPerc: TFloatField;
    quModelVendorCaseQty: TFloatField;
    btnOpenVendorList: TSpeedButton;
    quBarCodeQty: TFloatField;
    chbAskSPOnSale: TDBCheckBox;
    btnClearMaxDisc: TSpeedButton;
    cdsModelVendor: TClientDataSet;
    cdsModelVendorIDModel: TIntegerField;
    cdsModelVendorIDVendor: TIntegerField;
    cdsModelVendorVendor: TStringField;
    cdsModelVendorVendorOrder: TIntegerField;
    cdsModelVendorMinQtyPO: TFloatField;
    cdsModelVendorCaseQty: TFloatField;
    cdsModelVendorVendorCodeList: TStringField;
    grdModelVendor: TcxGrid;
    grdModelVendorTV: TcxGridDBTableView;
    grdModelVendorLvl: TcxGridLevel;
    grdModelVendorTVVendor: TcxGridDBColumn;
    grdModelVendorTVVendorOrder: TcxGridDBColumn;
    grdModelVendorTVMinQtyPO: TcxGridDBColumn;
    grdModelVendorTVCaseQty: TcxGridDBColumn;
    grdModelVendorTVVendorCodeList: TcxGridDBColumn;
    quModelVendorVendorCost: TBCDField;
    quModelVendorCostLastChange: TDateTimeField;
    cdsModelVendorVendorCost: TCurrencyField;
    cdsModelVendorCostLastChange: TDateTimeField;
    grdModelVendorTVVendorCost: TcxGridDBColumn;
    grdModelVendorTVCostLastChange: TcxGridDBColumn;
    pgInventory: TPageControl;
    tsQty: TTabSheet;
    tsPrice: TTabSheet;
    SubQty: TSubListPanel;
    pnlAdjust: TPanel;
    btAdjust: TSpeedButton;
    SubPrice: TSubListPanel;
    btnQty: TSpeedButton;
    btnPrice: TSpeedButton;
    btPriceTable: TSpeedButton;
    btPriceTable2: TSpeedButton;
    btPriceTable3: TSpeedButton;
    quInvHoldSaleCode: TStringField;
    grdInvHoldDBTableView: TcxGridDBTableView;
    grdInvHoldLevel: TcxGridLevel;
    grdInvHold: TcxGrid;
    grdInvHoldDBTableViewSaleCode: TcxGridDBColumn;
    grdInvHoldDBTableViewPreSaleDate: TcxGridDBColumn;
    grdInvHoldDBTableViewFirstName: TcxGridDBColumn;
    grdInvHoldDBTableViewLastName: TcxGridDBColumn;
    grdInvHoldDBTableViewQty: TcxGridDBColumn;
    grdStyle: TcxStyleRepository;
    DefaultStyle: TcxStyle;
    pnlMarkUp: TPanel;
    Label23: TLabel;
    Label25: TLabel;
    lbActuMarkUp1: TLabel;
    lbMarkUp1: TLabel;
    Label27: TLabel;
    lbLastUpdate1: TLabel;
    btnClearSellPrice: TSpeedButton;
    DBEdit12: TDBEdit;
    dbedDesireValue: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    btUpdate: TButton;
    edtAvgCost: TEdit;
    chkManualCalcPrice: TDBCheckBox;
    chkUseScale: TDBCheckBox;
    lbValidDay: TLabel;
    DBEdit27: TDBEdit;
    lbScaleExpday: TLabel;
    chkLotControl: TDBCheckBox;
    tsGovernement: TTabSheet;
    Panel7: TPanel;
    Panel17: TPanel;
    lbIndexProd: TLabel;
    cbxIndexProd: TcxDBImageComboBox;
    lbIndexRound: TLabel;
    cbxIndexRound: TcxDBImageComboBox;
    pnlNCM: TPanel;
    pnlNCMInfo: TPanel;
    lbNCM: TLabel;
    scNCM: TDBSuperComboADO;
    lbNCMTaxIn: TLabel;
    lbNCMTaxOut: TLabel;
    lbNCMPayTax: TLabel;
    lbTaxInValue: TLabel;
    lbTaxOutValue: TLabel;
    Panel19: TPanel;
    DBWebDescription: TDBMemo;
    lbShort: TLabel;
    pnlWebDescription: TPanel;
    pnlStateTax: TPanel;
    pnlStateTaxInfo: TPanel;
    btnRemoveStateTax: TSpeedButton;
    btnAddStateTax: TSpeedButton;
    cxGrid1: TcxGrid;
    cxGridDBStateTax: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsStateTax: TDataSource;
    quStateTax: TADODataSet;
    quStateTaxEstado: TStringField;
    quStateTaxTaxCategory: TStringField;
    quStateTaxTax: TBCDField;
    cxGridDBStateTaxEstado: TcxGridDBColumn;
    cxGridDBStateTaxTaxCategory: TcxGridDBColumn;
    cxGridDBStateTaxTax: TcxGridDBColumn;
    quStateTaxIDEstado: TStringField;
    quStateTaxIDTaxCategory: TIntegerField;
    tsNutrition: TTabSheet;
    Panel18: TPanel;
    btnRemoveNutrition: TSpeedButton;
    btnAddNutrition: TSpeedButton;
    pnlNutrition: TPanel;
    cxGridNutrition: TcxGrid;
    cxGridDBTVNutrition: TcxGridDBTableView;
    cxGridLevelNutrition: TcxGridLevel;
    dsNutritionItem: TDataSource;
    quNutritionList: TADODataSet;
    quNutritionListIDNutritionItem: TIntegerField;
    quNutritionListIDModel: TIntegerField;
    quNutritionListQtyPortion: TBCDField;
    quNutritionListVDPortion: TBCDField;
    quNutritionListDescription: TStringField;
    cxGridDBTVNutritionDescription: TcxGridDBColumn;
    cxGridDBTVNutritionQtyPortion: TcxGridDBColumn;
    cxGridDBTVNutritionVDPortion: TcxGridDBColumn;
    lbPortion: TLabel;
    DBEdit28: TDBEdit;
    lbCFOP: TLabel;
    scCFOP: TDBSuperComboADO;
    edtLastPurchase: TEdit;
    quFormModel: TStringField;
    quFormIDModel: TIntegerField;
    quFormGroupID: TIntegerField;
    quFormDescription: TStringField;
    quFormFreightCost: TBCDField;
    quFormOtherCost: TBCDField;
    quFormVendorCost: TBCDField;
    quFormSuggRetail: TBCDField;
    quFormDateLastCost: TDateTimeField;
    quFormMarkUp: TBCDField;
    quFormSellingPrice: TBCDField;
    quFormDateLastSellingPrice: TDateTimeField;
    quFormIDUserLastSellingPrice: TIntegerField;
    quFormPeso: TBCDField;
    quFormIDFabricante: TIntegerField;
    quFormSystem: TBooleanField;
    quFormDesativado: TIntegerField;
    quFormHidden: TIntegerField;
    quFormModelType: TStringField;
    quFormIDColor: TIntegerField;
    quFormIDSize: TIntegerField;
    quFormIDUnidade: TIntegerField;
    quFormLastCost: TBCDField;
    quFormLastMovDate: TDateTimeField;
    quFormClasseABC: TStringField;
    quFormES: TBCDField;
    quFormPVD: TBCDField;
    quFormPP: TBCDField;
    quFormTR: TIntegerField;
    quFormAutomaticRequest: TBooleanField;
    quFormAvgCost: TBCDField;
    quFormReplacementCost: TBCDField;
    quFormFloatPercent: TIntegerField;
    quFormNotVerifyQty: TBooleanField;
    quFormPromotionPrice: TBCDField;
    quFormDiscountPerc: TFloatField;
    quFormTotQtyOnHand: TBCDField;
    quFormCustomSalePrice: TBooleanField;
    quFormCaseQty: TBCDField;
    quFormVerify: TBooleanField;
    quFormIDModelGroup: TIntegerField;
    quFormIDModelSubGroup: TIntegerField;
    quFormSendToTrash: TBooleanField;
    quFormAskUserOnSale: TBooleanField;
    quFormUpdatePrice: TBooleanField;
    quFormUseScale: TBooleanField;
    quFormScaleValidDay: TIntegerField;
    quFormUseLot: TBooleanField;
    quFormIndicadorProducao: TStringField;
    quFormIndicadorAT: TStringField;
    quFormIDNCM: TIntegerField;
    quFormWebDescription: TStringField;
    quFormPortion: TStringField;
    quFormIDCFOP: TIntegerField;
    quFormlastReceived: TDateTimeField;
    quFormRealMarkupPercet: TCurrencyField;
    quFormRealMarkupValue: TCurrencyField;
    quFormFinalCost: TCurrencyField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsIMTbyYearStateChange(Sender: TObject);
    procedure btRemoveBarCodeClick(Sender: TObject);
    procedure dsBarCodeDataChange(Sender: TObject; Field: TField);
    procedure btAddBarCodeClick(Sender: TObject);
    procedure quBarCodePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure quFormCalcFields(DataSet: TDataSet);
    procedure dsBarCodeStateChange(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure AtuLastCostDate(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btAddSpecialPriceClick(Sender: TObject);
    procedure pgModelChange(Sender: TObject);
    procedure btRemoveSpecialPriceClick(Sender: TObject);
    procedure quKitModelPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure quKitModelNewRecord(DataSet: TDataSet);
    procedure quKitModelAfterPost(DataSet: TDataSet);
    procedure scLookUpSelectItem(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btAdjustClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure rbLookByModelClick(Sender: TObject);
    procedure rbLookByBarCodeClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure btAddSerialClick(Sender: TObject);
    procedure btSerialRemoveClick(Sender: TObject);
    procedure btBarcodeSearchClick(Sender: TObject);
    procedure quSpecialPriceAfterOpen(DataSet: TDataSet);
    procedure btAddSizeClick(Sender: TObject);
    procedure btAddColorClick(Sender: TObject);
    procedure sgGridDblClick(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure cmbGroupSelectItem(Sender: TObject);
    procedure quFormBeforeCancel(DataSet: TDataSet);
    procedure postOnExit(Sender: TObject);
    procedure dsSpecialPriceStateChange(Sender: TObject);
    procedure quSpecialPriceAfterEdit(DataSet: TDataSet);
    procedure dsSerialStateChange(Sender: TObject);
    procedure quSerialAfterOpen(DataSet: TDataSet);
    procedure btKitAddClick(Sender: TObject);
    procedure dsKitModelStateChange(Sender: TObject);
    procedure quKitModelAfterOpen(DataSet: TDataSet);
    procedure btKitRemoveClick(Sender: TObject);
    procedure quKitModelAfterEdit(DataSet: TDataSet);
    procedure btEditSerialClick(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
    procedure btnAddSizeColorClick(Sender: TObject);
    procedure grdSpecialPriceGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure spquQuantityAfterOpen(DataSet: TDataSet);
    procedure btnRemovePackClick(Sender: TObject);
    procedure btnAddPackClick(Sender: TObject);
    procedure quPackModelAfterOpen(DataSet: TDataSet);
    procedure edtQtyOutKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcPriceClick(Sender: TObject);
    procedure btAddAccessoryClick(Sender: TObject);
    procedure btDelAccessoryClick(Sender: TObject);
    procedure pgWebInfoChange(Sender: TObject);
    procedure btnAddFeatureClick(Sender: TObject);
    procedure btnDelFeatureClick(Sender: TObject);
    procedure btnTechAddClick(Sender: TObject);
    procedure btnTechDelClick(Sender: TObject);
    procedure edtFloatPercentKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcSaleTaxClick(Sender: TObject);
    procedure quFormBeforeOpen(DataSet: TDataSet);
    procedure chkDisableItemClick(Sender: TObject);
    procedure chkHiddenItemClick(Sender: TObject);
    procedure scSubManufactureSelectItem(Sender: TObject);
    procedure scModelSubGroupSelectItem(Sender: TObject);
    procedure quStorePriceAfterOpen(DataSet: TDataSet);
    procedure scModelGroupSelectItem(Sender: TObject);
    procedure editNetCostClick(Sender: TObject);
    procedure pgModelInfoChange(Sender: TObject);
    procedure btnRemoveVendorListClick(Sender: TObject);
    procedure btnAddVendorListClick(Sender: TObject);
    procedure btnModelVendorUPClick(Sender: TObject);
    procedure btnModelVendorDownClick(Sender: TObject);
    procedure dsModelVendorStateChange(Sender: TObject);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure quFormFreightCostChange(Sender: TField);
    procedure btRemoveModelReceiptClick(Sender: TObject);
    procedure btAddModelReceiptClick(Sender: TObject);
    procedure dsModelReceiptStateChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnClearSellPriceClick(Sender: TObject);
    procedure editNetCostExit(Sender: TObject);
    procedure editOtherCostExit(Sender: TObject);
    procedure editFreightCostExit(Sender: TObject);
    procedure EditModelExit(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure edtCaseCostKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit26Exit(Sender: TObject);
    procedure edtCaseCostExit(Sender: TObject);
    procedure grdKitModelDBTableViewSellingPricePropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure grdKitModelExit(Sender: TObject);
    procedure grdKitModelDBTableViewQtyPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure quKitModelMarginPercValidate(Sender: TField);
    procedure DBEdit2Exit(Sender: TObject);
    procedure grdKitModelDBMarginPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EditSalePriceExit(Sender: TObject);
    procedure edtCaseCostChange(Sender: TObject);
    procedure btnOpenVendorListClick(Sender: TObject);
    procedure dbedDesireValueExit(Sender: TObject);
    procedure btnClearMaxDiscClick(Sender: TObject);
    procedure btnQtyClick(Sender: TObject);
    procedure btnPriceClick(Sender: TObject);
    procedure btPriceTableClick(Sender: TObject);
    procedure grdInvHoldDBTableViewDblClick(Sender: TObject);
    procedure quFormSellingPriceChange(Sender: TField);
    procedure scNCMSelectItem(Sender: TObject);
    procedure btnAddStateTaxClick(Sender: TObject);
    procedure btnRemoveStateTaxClick(Sender: TObject);
    procedure btnAddNutritionClick(Sender: TObject);
    procedure quFormUseScaleChange(Sender: TField);
    procedure btnRemoveNutritionClick(Sender: TObject);
    procedure quNutritionListAfterOpen(DataSet: TDataSet);
    procedure chkUseScaleClick(Sender: TObject);
    procedure chkManualCalcPriceClick(Sender: TObject);
    procedure quFormAfterScroll(DataSet: TDataSet);
  private
    FDMInventory: TDMInventory;
    sRetail, sCost, sProfit,
    sMarkup, sDesiredMarkup,
    sDesiredMargin,
    sProfValor,
    sPayTax, sNoPayTax : String;
    MyDate               : TDateTime;
    OriginalHeight       : integer;
    OriginalKeyHeight    : integer;
    OriginalDetailHeight : integer;
    FrmInvoice           : TFrmInvoice;
    SubModelFch          : TFchModel;
    iOriginalFormHeight  : Integer;
    HlpContext           : Integer;
    bMarkUpOverCost      : Boolean;
    bTaxIncludedInCost   : Boolean;
    bUseMarkupOnCost     : Boolean;
    bCostReposition      : Boolean;
    bHasSubCalcTax       : Boolean;
    bHasChangePrice      : Boolean;
    bChangePrices        : Boolean;
    cCostOld, cSaleOld   : Currency;

    bShowMasterPanel,
    bShowPageControl,
    bShowTitlePanel,
    bApplyMargin: boolean;

    FFrmBarcodeSearch : TFrmBarcodeSearch;
    FFrmModelPrice : TFrmModelPrice;

    FPriceRound: TPriceRound;
    FSalePriceMargem: TPriceMargem;
    FMSRPMargem: TPriceMargem;

    FSellingPrice, FMSRP: Currency;

    procedure OnBeforeDoCancel; override;
    function OnAfterSaveChange(var iError:Integer): Boolean; override;

    procedure KitModelOpen;
    procedure KitModelClose;
    procedure KitModelPost;
    procedure KitModelRequery;

    procedure PackModelOpen;
    procedure PackModelClose;
    procedure PackModelRefresh;
    procedure PackCalcTotal;

    procedure AccessoryClose;
    procedure AccessoryOpen;
    procedure AccessoryRefresh;

    procedure FeaturesClose;
    procedure FeaturesOpen;
    procedure FeaturesRefresh;

    procedure TechFeaturesClose;
    procedure TechFeaturesOpen;
    procedure TechFeaturesRefresh;

    procedure VendorCodeRefresh;
    procedure VendorCodeOpen;
    procedure VendorCodeClose;

    procedure ModelVendorListClose;
    procedure ModelVendorListOpen;
    procedure ModelVendorListRefresh;
    procedure UpdateVendorOrder;

    procedure ModelVendorRefresh;
    procedure ModelVendorOpen;
    procedure ModelVendorClose;

    procedure ModelNutritionRefresh;
    procedure ModelNutritionOpen;
    procedure ModelNutritionClose;

    procedure StateTaxRefresh;
    procedure StateTaxOpen;
    procedure StateTaxClose;

    procedure ModelReceiptRefresh;
    procedure ModelReceiptOpen;
    procedure ModelReceiptClose;

    procedure StoreInfoOpen;
    procedure StoreInfoClose;
    procedure StoreInfoRefresh;

    procedure BarCodeOpen;
    procedure BarCodeClose;
    procedure BarCodeRefresh;

    procedure OnBeforeShow; override;
    procedure FormRefresh;
    procedure CloseQuery;
    procedure LoadInvoiceForm;
    procedure RefreshTabGrid;
    procedure RefreshTab(CloseDataSet: Boolean);
    procedure RefreshTabInternet;
    procedure GridPaint;
    procedure LoadSubModelFch;
    procedure FreeSubModelFch;
    procedure SetFormHeight;
    procedure CalcCaseCost;

    procedure AutoRecalPrices;

    procedure SendToTrashOption;

    function CreateNewModel(Barcode: String): String;

    function CalcAvgCost: Double;
    function CalcSaleWithTax(Sale: Double): Double;
    function CalcSalePrice(PerNet, Cost, Tax: Double): Currency;
    function CalcMarkUp(CostPrice: Currency; Markup: Currency): Currency;
    procedure InsertBarcode(IDBarcode: String; Qty: Double);
    procedure VerifyModelCatalog;
    procedure UpdateKitPromoPrice(CostPrice: Currency);
    procedure FormatPrices;
    function LocateStoreQty: Integer;
    procedure CheckTabVisible(ATabSheet: TTabSheet);
    function TestSizeAndColor : Boolean;
    procedure SavePriceChanges;

    procedure RefreshNCM;
  public
    IsDetail: Boolean;
    ShowLookUp: Boolean;
  end;

implementation

uses uDM, xBase, uPassword, uModelAdjustQty, uMsgBox, uNewSerial, uCharFunctions,
     uFrmModelAddSize, uFrmModelAddColor, uMsgConstant, uFchInventory,
     uNumericFunctions, uSystemTypes, uDMGlobal, uFrmBarcodePrint,
     uFrmModelAddSizeColor, uSystemConst, uNewFornecedor, uNewModelReceipt,
     uDMCalcPrice, uFrmModelQuickEntry, ufrmModelAdd, uContentClasses, uObjectServices,
     uFrmModelStateTax, uFrmAddNutrition;

{$R *.DFM}

function TFchModel.CalcAvgCost: Double;
begin
  if quFormAvgCost.IsNull then
    Result := quFormVendorCost.AsCurrency
  else
    Result := quFormAvgCost.AsCurrency;

  edtAvgCost.Text := FormatFloat('#,##0.00', Result);
  edtAvgCost2.Caption := FormatFloat('#,##0.00', Result);
  edtAvgCost3.Caption := FormatFloat('#,##0.00', Result);
end;

procedure TFchModel.OnBeforeShow;
begin
  if ShowLookUp then
  begin
    Position := poDefault;
    Top  := 0;
    Left := 0;
  end;
end;

procedure TFchModel.FormShow(Sender: TObject);
var
  myBol: Boolean;
begin
  inherited;
  // Controle de acesso ao Cost
  if ShowLookUp then
    // Estou no view inevtory
    myBol := PassWord.HasFuncRight(30)
  else
    // Estou no Model
    myBol    := PassWord.HasFuncRight(33);

  // Aplica
  if myBol then
  begin
    dbLastCost.Color := clWindow;
    editNetCost.Color := clWindow;
    editOtherCost.Color := clWindow;
    editFreightCost.Color := clWindow;

    dbLastCost.ReadOnly := False;
    editNetCost.ReadOnly := False;
    editOtherCost.ReadOnly := False;
    editFreightCost.ReadOnly := False;
  end
  else
  begin
    dbLastCost.ParentColor := True;
    editNetCost.ParentColor := True;
    editOtherCost.ParentColor := True;
    editFreightCost.ParentColor := True;

    dbLastCost.ReadOnly := True;
    editNetCost.ReadOnly := True;
    editOtherCost.ReadOnly := True;
    editFreightCost.ReadOnly := True;
  end;

  // Controle de acesso da Qtde
  if ShowLookUp then
  begin
    btAdjust.Visible := PassWord.HasFuncRight(29);
  end
  else
  begin
    btAdjust.Visible := PassWord.HasFuncRight(32);
  end;

  if ShowLookUp AND (quForm.Active = False) then
    SetFormHeight;

  // Seta o controle com o foco, e o caption do botao de cancel
  if ShowLookUp then
  begin
    //btCancel.Caption := 'Close';
    //scLookUp.SetFocus;
    edtBarcode.Setfocus;

    // Habilita para ser escolhido os itens que vão ser visualizados.
    scLookUp.Enabled  := True;
    scLookUp.Color    := clWindow;
    scLookUp.TabStop  := True;
    scLookUp.ReadOnly := False;
  end
  else
  begin
    //amfsouza 11.11.2010 
    btCancel.Caption := 'Close';
    if pnlMaster.Visible then
    begin
      //Se for um novo item, o focus vai para o Group
      if frmCommand = btInc then
        cmbGroup.SetFocus
      else
        EditModel.SetFocus;
    end
    else
      if pgModel.CanFocus then
        pgModel.SetFocus;
  end;

  // seta o enabled se o form nao for restrito pra replicagem
  if fIsRestricForm then
  begin
    //Restric for server only
    btAdjust.Enabled             := (DM.fSystem.VersionType <> SYSTEM_SERVER_TYPE);
    chkQtyUpdate.Visible         := (DM.fSystem.VersionType <> SYSTEM_SERVER_TYPE);

    btUpdate.Enabled             := False;
    btAddColor.Enabled           := False;
    btAddSize.Enabled            := False;
    btnCalcPrice.Enabled         := False;
    btnAddSizeColor.Enabled      := False;
    btAddBarCode.Visible         := False;
    btnAddPack.Visible           := False;
    btnRemovePack.Visible        := False;
    btRemoveBarCode.Visible      := False;
    btAddSpecialPrice.Visible    := False;
    btRemoveSpecialPrice.Visible := False;
    btKitAdd.Visible             := False;
    btKitRemove.Visible          := False;
    btAddSerial.Visible          := False;
    btEditSerial.Visible         := False;
    btSerialRemove.Visible       := False;
    btAddAccessory.Visible       := False;
    btDelAccessory.Visible       := False;
    btnAddFeature.Visible        := False;
    btnDelFeature.Visible        := False;
    btnTechAdd.Visible           := False;
    btnTechDel.Visible           := False;
  end;

  if bUseMarkupOnCost then
    lbMarkUp1.Caption := sDesiredMarkup
  else
    lbMarkUp1.Caption := sDesiredMargin;

end;

procedure TFchModel.SetFormHeight;
var
  iNewHeight: Integer;
begin
  // Mostro ou nao os panels
  Panel2.Visible    := bShowTitlePanel OR ShowLookUp;
  pnlLookUp.Visible := ShowLookUp;
  pnlMaster.Visible := bShowMasterPanel;
  pnlAlways.Visible := bShowPageControl;
  pgModel.Visible   := bShowPageControl;

  if ShowLookUp then
    //InventoryItems
    if bShowMasterPanel then
      HlpContext:= 1790
    else
      HlpContext := 1780
  else
    //View Inventory
    HlpContext := 1650;


  // Seto a latura correta da tela
  iNewHeight := iOriginalFormHeight;

  if not bShowTitlePanel then
    iNewHeight := iNewHeight - Panel2.Height;

  if not ShowLookUp then
    iNewHeight := iNewHeight - pnlLookUp.Height;

  if not bShowMasterPanel then
    iNewHeight := iNewHeight - pnlMaster.Height;

  Self.Height := iNewHeight;
end;

procedure TFchModel.FormCreate(Sender: TObject);
var
  bCanSeeCost: Boolean;
begin
  inherited;

  FDMInventory := TDMInventory.Create(Self);

  rbLookByModel.Checked := True;

  iOriginalFormHeight := Self.Height;

  IsDetail       := True;
  ShowLookUp     := False;

  pgModel.ActivePage := tbCostRetail;

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];

  bMarkUpOverCost := DM.fSystem.SrvParam[PARAM_MARKUPOVERCOST];

  bTaxIncludedInCost := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
  bCostReposition    := DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST];
  bUseMarkupOnCost   := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];

  if bTaxIncludedInCost then
  begin
    pnlTaxWithCost.Visible := (not bUseMarkupOnCost);
    pnlSalePrice.Visible   := bUseMarkupOnCost;
    Label23.Visible        := not bUseMarkupOnCost;
    edtAvgCost.Visible     := Label23.Visible;
    Label25.Visible        := Label23.Visible;
  end
  else
    pnlSalePrice.Visible     := True;

  tsGovernement.TabVisible := bTaxIncludedInCost;
  bCanSeeCost := Password.HasFuncRight(2);

  pnlCustomQty.Visible   := (bCostReposition) and bCanSeeCost;
  pnlCost.Visible        := (not bCostReposition) and bCanSeeCost;
  pnlMarkUp.Visible      := bCanSeeCost;

  pnlFranchiseCost.Visible := False;
  pnlFranchaseSale.Visible := False;

  if DM.fStore.Franchase then
  begin
    pnlCustomQty.Visible     := False;
    pnlTaxWithCost.Visible   := False;
    pnlSalePrice.Visible     := False;
    pnlCost.Visible          := False;
    pnlFranchiseCost.Visible := True;
    pnlFranchaseSale.Visible := True;
  end;

  SubQty.CreateSubList;
  SubPrice.CreateSubList;

  if bTaxIncludedInCost then
  begin
    SubRecalcSalePrice.CreateSubList;
    lbCustoMedio.Visible  := True;
    lbCustoMedio1.Visible := True;
    edtAvgCost2.Visible   := True;
    edtAvgCost3.Visible   := True;
  end;

  if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
  begin
    lbTotalOnHand.Visible := False;
    DBEdit9.Visible       := False;
  end;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sRetail        := 'Retail   ';
      sCost          := 'Cost     ';
      sProfit        := 'Profit % ';
      sMarkup        := 'MarkUp % ';
      sDesiredMarkup := 'Desired Mark-Up :';
      sDesiredMargin := 'Desired Margin :';
      sProfValor     := 'Profit Amount';
      sPayTax        := 'Pay Tax';
      sNoPayTax      := 'No Pay tax';
      sUrlHelp       := '';
      sUrlVideo      := '';
    end;

    LANG_PORTUGUESE:
    begin
      sRetail        := 'Venda    ';
      sCost          := 'Custo    ';
      sProfit        := '% Lucro  ';
      sMarkup        := '% Margem ';
      sProfValor     := 'Valor Lucro';
      sDesiredMarkup := 'Mark-Up :';
      sDesiredMargin := 'Margem :';
      sPayTax        := 'Incide';
      sNoPayTax      := 'Não Incide';
      sUrlHelp       := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Produto_Comum.htm';
      sUrlVideo      := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Produto_Cadastro_Completo/Adicionar_Produto_Cadastro_Completo.html';
    end;

    LANG_SPANISH :
    begin
      sRetail        := 'Venta    ';
      sCost          := 'Costo    ';
      sProfit        := '% Lucro  ';
      sMarkup        := '% Margen ';
      sProfValor     := 'Valor Margen';
      sDesiredMarkup := 'Mark-Up :';
      sDesiredMargin := 'Margem :';
      sPayTax        := 'Incide';
      sNoPayTax      := 'Não Incide';
      sUrlHelp       := '';
      sUrlVideo      := '';
    end;
  end;

  //Replicatin
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddFeature.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnTechAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddAccessory.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddVendorList.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddBarCode.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddSpecialPrice.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btKitAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddSerial.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddModelReceipt.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddStateTax.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddNutrition.Glyph);

  DM.imgSmall.GetBitmap(BTN18_DELETE, btnTechDel.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDelFeature.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btDelAccessory.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveVendorList.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveSpecialPrice.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveBarCode.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btSerialRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btKitRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveModelReceipt.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveStateTax.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveNutrition.Glyph);

  DM.imgSmall.GetBitmap(BTN18_OPEN, btEditSerial.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnOpenVendorList.Glyph);
  DM.imgSmall.GetBitmap(BTN18_BARCODE, btnPrintBarcode.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DOWN, btnModelVendorDown.Glyph);
  DM.imgSmall.GetBitmap(BTN18_UP, btnModelVendorUP.Glyph);

  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);

  bApplyMargin := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];

  chkManualCalcPrice.Visible := bApplyMargin;
  chkManualCalcPrice.Checked := False;

end;

procedure TFchModel.dsIMTbyYearStateChange(Sender: TObject);
begin
  inherited;
  if not btClose.Enabled then
    btClose.Enabled := (quBarCode.State in dsEditModes);
end;

procedure TFchModel.btRemoveBarCodeClick(Sender: TObject);
var
  IDBarcode, sSQL :String;
begin
  inherited;
  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
  begin
    try
      DM.ADODBConnect.BeginTrans;
      IDBarcode := Trim(quBarCodeIDBarcode.AsString);

      with quBarCode do
      begin
        DisableControls;
        if Locate('BarcodeOrder', quBarCodeBarcodeOrder.AsInteger, []) then
        begin
          Next;
          while not EOF do
          begin
            Edit;
            quBarCodeBarcodeOrder.AsInteger := quBarCodeBarcodeOrder.AsInteger - 1;
            Post;
            Next;
          end;
        end;
        EnableControls;
      end;

      try
        sSQL := 'DELETE Barcode WHERE IDBarcode = ' + QuotedStr(IDBarcode);

        DM.RunSQL(sSQL);
      except
          MsgBox(MSG_INF_BARCODE_NOT_DEL, vbOKOnly + vbExclamation);
      end;

      DM.ADODBConnect.CommitTrans;
    except
      DM.ADODBConnect.RollbackTrans;
    end;
    BarCodeRefresh;
  end;
end;

procedure TFchModel.dsBarCodeDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btRemoveBarCode.Enabled := not (quBarcode.Eof and quBarcode.Bof);
  btnPrintBarcode.Enabled := btRemoveBarCode.Enabled;
end;

procedure TFchModel.btAddBarCodeClick(Sender: TObject);
var
  sBarcode: String;
  dQty: Double;
begin
  inherited;
  with TFrmNewBarCode.Create(Self) do
    if Start(sBarcode, dQty) then
      InsertBarcode(sBarcode, dQty);
end;

procedure TFchModel.quBarCodePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  Action := daAbort;
  raise exception.create(MSG_EXC_BARCODE_EXISTE);
end;

procedure TFchModel.quFormCalcFields(DataSet: TDataSet);
var
  cAmount, cTax: Currency;
begin
  inherited;
  if bTaxIncludedInCost and (not bHasSubCalcTax) then
  begin
    SubRecalcSalePrice.Param := 'IDGroup='+quFormGroupID.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';
    bHasSubCalcTax := True;
  end;

  quFormFinalCost.AsCurrency := quFormVendorCost.AsCurrency +
                                quFormOtherCost.AsCurrency +
                                quFormFreightCost.AsCurrency;

  if bCostReposition then
    cAmount := quFormReplacementCost.AsCurrency
  else
    if bMarkUpOverCost then
      cAmount := quFormFinalCost.AsCurrency
    else
      if quFormAvgCost.IsNull then
        cAmount := quFormFinalCost.AsCurrency
      else
        cAmount := quFormAvgCost.AsCurrency;

  if bTaxIncludedInCost and (not bUseMarkupOnCost) then
  begin
    //Cost calculated with tax
    cTax := CalcSaleWithTax(quFormSellingPrice.AsCurrency);
    quFormRealMarkUpValue.AsCurrency := quFormSellingPrice.AsCurrency - cAmount - cTax;

    if (quFormSellingPrice.AsCurrency > 0) then
      quFormRealMarkUpPercet.AsFloat   := (quFormRealMarkUpValue.AsCurrency / quFormSellingPrice.AsCurrency) * 100;

    edtActualCost.Caption := FormatFloat('#,##0.00', cAmount);
    edtSalePlusTax.Caption := FormatFloat('#,##0.00', cTax);
  end
  else
  begin
    quFormRealMarkUpValue.AsCurrency := quFormSellingPrice.AsCurrency - cAmount;
    if (cAmount > 0) then
      quFormRealMarkUpPercet.AsFloat   := (quFormRealMarkUpValue.AsCurrency / cAmount) * 100;
  end;
end;

procedure TFchModel.dsBarCodeStateChange(Sender: TObject);
begin
  inherited;
  if not btClose.Enabled then
    btClose.Enabled := (quBarCode.State in dsEditModes);
end;

procedure TFchModel.btUpdateClick(Sender: TObject);
var
  SellingPrice, CostPrice, SuggRetail : Currency;
  saveSellingPrice: currency;
begin
  inherited;

 {
  if chkManualCalcPrice.Checked then
    Exit;
  }

  DoPost;

  //amfsouza 03.23.2011 - quForm.Refresh;
  quForm.Close;
  quForm.Open;

  SellingPrice := 0;
  CostPrice    := 0;
  SuggRetail   := 0;

  //amfsouza 06.03.2011
  saveSellingPrice := quForm.fieldByName('SellingPrice').Value;

  if (quFormMarkUp.AsFloat <> 0) then
  begin
    if bMarkUpOverCost then
      CostPrice := quFormFinalCost.AsCurrency
    else
      if quFormAvgCost.IsNull then
        CostPrice := quFormFinalCost.AsCurrency
      else
        CostPrice := quFormAvgCost.AsCurrency;

    if bUseMarkupOnCost then
      SellingPrice := DM.FDMCalcPrice.GetMarkupPrice(CostPrice, quFormMarkUp.AsFloat)
    else if (quFormMarkUp.AsFloat < 100) then begin
      SellingPrice := DM.FDMCalcPrice.GetMarginPrice(CostPrice, quFormMarkUp.AsFloat);

      //amfsouza 06.05.2011 - using increase only parameter.
      if ( SellingPrice < saveSellingPrice ) then begin
         if ( dm.FDMCalcPrice.IncreasePriceOnly ) then
            SellingPrice := saveSellingPrice;
      end;
    end;

    //amfsouza 11.23.2011 - DM.FDMCalcPrice.CalcRounding(quFormGroupID.AsInteger, SellingPrice);
  end
  else
  begin
    CostPrice   := DM.FDMCalcPrice.FormatPrice(quFormVendorCost.AsCurrency + quFormOtherCost.AsCurrency +
                    quFormFreightCost.AsCurrency);

    SellingPrice := DM.FDMCalcPrice.CalcSalePrice(quFormIDModel.AsInteger,
                                                  quFormGroupID.AsInteger,
                                                  quFormIDModelGroup.AsInteger,
                                                  quFormIDModelSubGroup.AsInteger,
                                                  CostPrice);

    if (CostPrice = SellingPrice) then
      SellingPrice := quFormSellingPrice.AsFloat;

  end;

  SuggRetail := DM.FDMCalcPrice.CalcMSRPPrice(quFormGroupID.AsInteger,
                                              quFormIDModelGroup.AsInteger,
                                              quFormIDModelSubGroup.AsInteger,
                                              CostPrice);

  if (CostPrice = SuggRetail) then
    SuggRetail := quFormSuggRetail.AsFloat;

    
  with quForm do
    begin
      if not (State in dsEditModes) then
        Edit;

      if (SellingPrice = 0) then
         MsgBox(MSG_INF_PRICE_INVALID, vbOKOnly + vbInformation)
      else
        begin
          if quFormSellingPrice.AsCurrency <> SellingPrice then
          begin
            quFormDateLastSellingPrice.AsDateTime := Now;
            quFormIDUserLastSellingPrice.AsInteger := DM.fUser.ID;
          end;

          quFormSellingPrice.AsFloat := SellingPrice;
        end;

      if (SuggRetail <> 0) then
        quFormSuggRetail.AsFloat := SuggRetail;

    end;

  UpdateKitPromoPrice(CostPrice);

end;

procedure TFchModel.AtuLastCostDate(Sender: TObject);
begin
  if bApplyMargin then
    AutoRecalPrices;
end;

procedure TFchModel.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormModelType.AsString := MODEL_TYPE_REGULAR;

  if DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL] then
    quFormModel.AsString := FDMInventory.GetValidModelCode;

  bHasChangePrice := False;
  bChangePrices   := False;

  FormRefresh;
end;

procedure TFchModel.btAddSpecialPriceClick(Sender: TObject);
begin
  inherited;
  try
    // Cria a ModelToSpecialPrice
    with quAddSpecialPrice do
    begin
      Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
      ExecSQL;
    end;

    // Refresh na quSpecialPrice
    RefreshTab(True);
    grdSpecialPrice.SetFocus;
  except
  end;
end;

procedure TFchModel.pgModelChange(Sender: TObject);
begin
  inherited;
  RefreshTab(False);
end;

procedure TFchModel.btRemoveSpecialPriceClick(Sender: TObject);
begin
  inherited;
  // Cria a ModelToSpecialPrice
  with quRemoveSpecialPrice do
  begin
    Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
    ExecSQL;
  end;

  // Refresh na quSpecialPrice
  RefreshTab(True);
  btAddSpecialPrice.Enabled := True;
end;

procedure TFchModel.quKitModelPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  if quKitModelSellingPrice.AsCurrency = 0 then
  begin
    MsgBox(MSG_INF_PRICE_INVALID, vbOKOnly + vbInformation);
    quKitModelSellingPrice.AsCurrency := quFormSellingPrice.AsCurrency;
    Action := daAbort;
  end
  else if quKitModelQty.AsFloat = 0 then
  begin
    MsgBox(MSG_INF_WRONG_QTY, vbOKOnly + vbInformation);
    quKitModelQty.AsFloat := 2;
    Action := daAbort;
  end
  else
  begin
    MsgBox(MSG_INF_NOT_DUPLICATED_QTY, vbOKOnly + vbInformation);
    quKitModelQty.AsFloat := quKitModelQty.AsFloat + 1;
    Action := daAbort;
  end;
end;

procedure TFchModel.quKitModelNewRecord(DataSet: TDataSet);
begin
  inherited;
  quKitModelIDModel.AsInteger := quFormIDModel.AsInteger;
  quKitModelSellingPrice.AsCurrency := quFormSellingPrice.AsCurrency;
end;

procedure TFchModel.quKitModelAfterPost(DataSet: TDataSet);
begin
  inherited;
  KitModelRequery;
end;

procedure TFchModel.scLookUpSelectItem(Sender: TObject);
begin
  inherited;

  if not(DM.ModelRestored(StrToInt(scLookUp.LookUpValue))) then
      begin
        edtBarcode.Text := '';
        scLookUp.LookUpValue := '';
        exit;
      end;

  with quForm do
  begin
    if (state in dsEditModes) or (frmCommand = btInc) then
    begin
      if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbYes then
      begin
        UpdateRecord; // Force pending updates
        Post;
      end
      else
        DoCancel(True);
    end;

    Close;
    Parameters[0].Value := MyStrToInt(scLookUp.LookUpValue);
    Open;
  end;

  frmCommand := btAlt;
end;

procedure TFchModel.btCloseClick(Sender: TObject);
begin

  if ShowLookUp then
  begin
    with quForm do
    begin
      if State in dsEditModes then
      begin
        if MsgBox(MSG_QST_SURE, vbYesNo + vbQuestion) = vbYes then
        begin
          SendToTrashOption;
          UpdateRecord; // Force pending updates
          Post;
        end
        else
          DoCancel(True);
      end
    end;

    frmCommand := btAlt;
    sclookUp.GetNextValue;
    scLookUpSelectItem(nil);
    edtBarCode.SetFocus;
  end
  else
  begin
    grdKitModelExit(nil);
    inherited;
  end;
end;

procedure TFchModel.btAddClick(Sender: TObject);
begin
  inherited;
  with quForm do
  begin
    if (state in dsEditModes) or (frmCommand = btInc) then
    begin
      if MsgBox(MSG_QST_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbYes then
      begin
        UpdateRecord; // Force pending updates
        Post;
      end
      else
        DoCancel(True);
    end;
  end;

  frmCommand := btInc;
  NextAppend;
  scLookUp.Text := 'New Model';
  pgModelChange(nil);
end;

procedure TFchModel.btAdjustClick(Sender: TObject);
var
  iIDStore : Integer;
  PosID1, PosID2 : string;
begin

  inherited;
  //Antes de chamar esta opcao tem que verificar se as informacao estao completas
  //pois se add e atualiza as qty e clica em cancel, fica lixo no sistema.
  if not TestFieldFill then
    Exit;

  DoPost;

  if pgInventory.ActivePage = tsQty then
  begin
    // Abre ficha de ajuste de estoque
    with TModelAdjustQty.Create(self) do
    begin

      iIDStore := LocateStoreQty;

      if spquQuantity.IsEmpty then
        Start(quFormIDModel.AsInteger, iIDStore, 0, 0, 0, 0)
      else
        Start(quFormIDModel.AsInteger,
              iIDStore,
              spquQuantityQtyOnHand.AsFloat,
              spquQuantityQtyOnRepair.AsFloat,
              spquQuantityQtyOnOrder.AsFloat,
              spquQuantityQtyOnPrePurchase.AsFloat);
    end;
  end
  else if pgInventory.ActivePage = tsPrice then
  begin
    iIDStore := SubPrice.CurrentKey;
    if (quFormIDModel.AsInteger = 0) or
       (iIDStore = 0) or
       (quFormModelType.AsString = 'M') then
       Exit;

    if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
      PosID1 := IntToStr(DM.fStore.ID)
    else
      PosID1 := IntToStr(iIDStore);

    PosID2 := quFormIDModel.AsString;

    //Inventory view inventory
    with TFchInventory.Create(Self) do
       Start(btAlt, nil, False, PosID1, PosID2, nil);
  end;

  with spquQuantity do
  begin
    Close;
    Open;
  end;

  //amfsouza 02.22.2011 - quForm.Refresh;
  quForm.Edit;

end;

procedure TFchModel.btRemoveClick(Sender: TObject);
begin
  inherited;
  // Deleta o Model

  if scLookUp.LookUpValue = '' then
    begin
      msgbox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbExclamation);
      exit;
    end;

  if msgbox(MSG_QST_DELETE_MODEL, + vbYesNo + vbQuestion) = vbYes then
    begin
      try
        with quForm do
          begin
            if State in dsEditModes then Cancel;
            Delete;
            scLookUp.LookUpValue := '';
            edtBarCode.SetFocus;
            msgbox(MSG_INF_MODEL_DELETED, vbOk + vbInformation);
          end;
        except
          raise exception.create('This model cannot be deleted.');
    end;
  end;
end;

procedure TFchModel.rbLookByModelClick(Sender: TObject);
begin
  inherited;
  scLookUp.LookUpValue  := '';
  scLookUp.LookUpSource := DM.dsLookUpModel;
  scLookUp.SetFocus;
end;

procedure TFchModel.rbLookByBarCodeClick(Sender: TObject);
begin
  inherited;
  scLookUp.LookUpValue  := '';
  scLookUp.LookUpSource := DM.dsLookUpBarCode;
  scLookUp.SetFocus;
end;

procedure TFchModel.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormRefresh;
  CalcAvgCost;
  //pnlCaseCost.Visible := (quFormCaseQty.Value > 1);
  CalcCaseCost;
  bApplyMargin := False;
  bHasChangePrice := False;
  bChangePrices   := False;

  if not(quFormSuggRetail.IsNull) then
    FMSRP :=  quFormSuggRetail.OldValue;

  if not(quFormSellingPrice.IsNull) then
    FSellingPrice := quFormSellingPrice.OldValue;

  cCostOld := quFormFinalCost.AsCurrency;
  cSaleOld := quFormSellingPrice.AsCurrency;

  if tsGovernement.TabVisible then
  begin
    lbTaxInValue.Caption := FormatFloat('0.00 %', 0);
    lbTaxOutValue.Caption := FormatFloat('0.00 %', 0);
    lbNCMPayTax.Caption := '.';

    RefreshNCM;
  end;

  tsNutrition.TabVisible := quFormUseScale.AsBoolean;

  { Nao funciona com o LookUp
  scModelGroup.SpcWhereClause := '';
  scModelSubGroup.SpcWhereClause := '';

  if cmbGroup.LookUpValue <> '' then
   begin
   scModelGroup.SpcWhereClause := 'IDGroup='+cmbGroup.LookUpValue;
   scModelGroup2.SpcWhereClause := 'IDGroup='+cmbGroup.LookUpValue;
   end;

  if scModelGroup.LookUpValue<>'' then
   begin
   scModelSubGroup.SpcWhereClause := 'IDModelGroup='+scModelGroup.LookUpValue;
   scModelSubGroup2.SpcWhereClause := 'IDModelGroup='+scModelGroup.LookUpValue;
   end;
   }
end;

procedure TFchModel.CloseQuery;
begin
  quBarCode.Close;
  quKitModel.Close;
  spquQuantity.Close;
  quSpecialPrice.Close;
  quInvHold.Close;
  quSerial.Close;
  quGrid.Close;
  quPackModel.Close;
  quAccessory.Close;
  quFeatures.Close;
  quTechFeature.Close;
  StateTaxClose;
end;

procedure TFchModel.RefreshTab(CloseDataSet: Boolean);
begin
  // Se necesssario fecho os datas set's que alimentam os tab's
  if CloseDataSet then
    CloseQuery;

  if pgModel.ActivePage = tsGrid then
  begin
    GridPaint;
  end
  else if pgModel.ActivePage = tsPackModel then
  begin
    PackModelOpen;
    //Nao pode lista o mesmo model como PackModel
    if quFormIDModel.AsString <> '' then
      scModelPack.SpcWhereClause := 'Model.IDModel <> ' + quFormIDModel.AsString;
  end
  else if pgModel.ActivePage = tbCostRetail then
  begin
    with spquQuantity do
      if not Active then
      begin
        Parameters.ParambyName('@ModelID').Value := quFormIDModel.AsInteger;
        Open;
      end;
      //Atualiza os custos da franquia
      if DM.fStore.Franchase then
        StoreInfoRefresh;
  end
  else if pgModel.ActivePage = tsAdvanced then
  begin
    if pgModelInfo.ActivePage = tsVendorInfo then
    begin
      ModelVendorListRefresh;
      ModelVendorRefresh;
      VendorCodeRefresh;
    end
    else if pgModelInfo.ActivePage = tsPrintReceipt then
      ModelReceiptRefresh
    else if pgModelInfo.ActivePage = tsGovernement then
      StateTaxRefresh;
  end
  else if pgModel.ActivePage = tsInternet then
  begin
    RefreshTabInternet;
    //Nao pode lista o mesmo model como acessorio
    if quFormIDModel.AsString <> '' then
      scModelAccessory.SpcWhereClause := 'Model.IDModel <> ' + quFormIDModel.AsString;
  end
  else if pgModel.ActivePage = tbSpecialPrice then
  begin
    with quSpecialPrice do
      if not Active then
      begin
        Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
      end;

    with quBarCode do
      if not Active then
      begin
        Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
      end;
  end
  else if pgModel.ActivePage = tbKitModel then
  begin
    KitModelOpen;

    with quSerial do
      if not Active then
      begin
        Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
      end;
  end
  else if pgModel.ActivePage = tbMovTotal then
  begin
    //Create Sub Mov total
    SubListMovTotal.CreateSubList;
    SubListMovTotal.Param := 'IDModel='+quFormIDModel.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';
  end
  else if pgModel.ActivePage = tbPurcHistory then
  begin
    SubListPurHistory.CreateSubList;
    SubListPurHistory.Param := 'IDModel='+quFormIDModel.AsString+';IDStore=-1;';
  end
  else if pgModel.ActivePage = tbSaleHist then
  begin
    SubListSalesHistory.CreateSubList;
    SubListSalesHistory.Param := 'IDModel='+quFormIDModel.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';
  end
  else if pgModel.ActivePage = tbMovHistory then
  begin
    //Create Sub Mov History
    SubListMovHistory.CreateSubList;
    SubListMovHistory.Param := 'IDModel='+quFormIDModel.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';
  end
  else if pgModel.ActivePage = tbOrder then
  begin
    //Create Order Sub List
    SubListOrderHistory.CreateSubList;
    SubListOrderHistory.Param := 'IDModel='+quFormIDModel.AsString+';ViewType=1';
  end
  else if pgModel.ActivePage = tbInvoicesHold then
  begin
    with quInvHold do
      if not Active then
      begin
        Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
      end;
  end;
end;

procedure TFchModel.btAddSerialClick(Sender: TObject);
begin
  inherited;
  with TNewSerial.Create(Self) do
  begin
    if Start(quFormIDModel.AsInteger) then
    begin
      quSerial.Close;
      quSerial.Open;
    end;
    Free;
  end;
end;

procedure TFchModel.btSerialRemoveClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE_SERIALNUMBER, vbQuestion + vbYesNo) = vbYes then
  begin
    DM.RunSQL('DELETE InventorySerial WHERE ModelID = ' + quFormIDModel.AsString +
              ' AND StoreID = ' + quSerialStoreID.AsString +
              ' AND Serial = ' + Chr(39) + quSerialSerial.AsString + Chr(39));

    quSerial.Close;
    quSerial.Open;
  end;
end;

procedure TFchModel.btBarcodeSearchClick(Sender: TObject);
var
  R: Integer;
begin
  inherited;
  if not Assigned(fFrmBarcodeSearch) then
    fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  with fFrmBarcodeSearch do
  begin
    R := Start;

    if R <> -1 then
    begin
      scLookUp.LookUpValue := IntToStr(R);
      scLookUpSelectItem(nil);
    end;
  end;
end;

procedure TFchModel.quSpecialPriceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dsSpecialPriceStateChange(nil);
end;

procedure TFchModel.GridPaint;
var
  slColor,
  slSize: TStringList;
  sCurrentColor: String;
  iMaxSizeWidth, iMaxColorWidth: integer;
  i, j: integer;
  s: String;

// ----------------------
// Sub
// ----------------------
   function IndexOfColor(sColor: String): integer;
   begin
     Result := slColor.IndexOf(sColor);
     if Result = -1 then
       begin
         Result := slColor.Add(sColor);
         sgGrid.RowCount := slColor.Count + 1;
       end;
     Result := Result + 1;
   end;

   function IndexOfSize(sSize: String): integer;
   begin
     Result := slSize.IndexOf(sSize);
     if Result = -1 then
       begin
         Result := slSize.Add(sSize);
         sgGrid.ColCount := slSize.Count + 1;
       end;
     Result := Result + 1;
   end;
// ----------------------
// Main
// ----------------------
begin
  // Utilizo dois StringList para incluir e recuperar os Index
  slColor        := TStringList.Create;
  slSize         := TStringList.Create;
  iMaxSizeWidth  := 0;
  iMaxColorWidth := 0;

  with quGrid do
     begin
      If Active then
         Exit;
      Parameters.ParambyName('IDModelParent').Value := quFormIDModel.AsInteger;
      Open;
     end;

  with sgGrid do
    begin
      ColCount := 0;
      RowCount := 0;

      while not quGrid.EOF do
        begin
        if (quGridDesativado.AsInteger=0) then
          Cells[ IndexOfSize(quGridSizeName.AsString),
                 IndexOfColor(quGridColor.AsString) ] := quGridTotQtyOnHand.AsString
        else
          Cells[ IndexOfSize(quGridSizeName.AsString),
                 IndexOfColor(quGridColor.AsString) ] := 'X';
          quGrid.Next;
        end;

      // Ajusto as Larguras das cell
      for i := 0 to slColor.Count-1 do
        begin
          j := Canvas.TextWidth(slColor[i]);
          if iMaxColorWidth < j then
            iMaxColorWidth := j;
        end;
      ColWidths[0] := iMaxColorWidth + COL_SPACE;

      for i := 0 to slSize.Count-1 do
        begin
          j := Canvas.TextWidth(slSize[i]);
          if iMaxSizeWidth < j then
            iMaxSizeWidth := j;
        end;
      for i := 1 to ColCount-1 do
        ColWidths[i] := iMaxSizeWidth + COL_SPACE;

      // Pinto os titulos das colunas e das linhas
      if ColCount > 1 then
        FixedCols := 1;

      if RowCount > 1 then
        FixedRows := 1;

      for i := 0 to slColor.Count-1 do
        Cells[0, i+1] := slColor[i];

      for i := 0 to slSize.Count-1 do
        Cells[i+1, 0] := slSize[i];

    end;

  slColor.Free;
  slSize.Free;
end;


procedure TFchModel.btAddSizeClick(Sender: TObject);
begin
  inherited;

  DoPost;

  if TestSizeAndColor then
    with TFrmModelAddSize.Create(self) do
      begin
        if Start(quFormIDModel.AsInteger) then
          begin
            quGrid.Close;
            RefreshTab(False);
          end;
      end;

end;

procedure TFchModel.btAddColorClick(Sender: TObject);
begin
  inherited;

  DoPost;

  if TestSizeAndColor then
    with TFrmModelAddColor.Create(self) do
      begin
        if Start(quFormIDModel.AsInteger) then
          begin
            quGrid.Close;
            RefreshTab(False);
          end;
      end;

end;

procedure TFchModel.sgGridDblClick(Sender: TObject);
var
  ID1, ID2, Qty: String;
begin
  inherited;
  // Abre o sub model
  LoadSubModelFch;

  DoPost;

  with sgGrid do
    if (Cells[0, Row] <> '') and (Cells[Col, 0] <> '') then
      quGrid.Locate('Color;SizeName', VarArrayOf([Cells[0, Row], Cells[Col, 0]]), [])
    else if Cells[0, Row] <> '' then
      quGrid.Locate('Color', Cells[0, Row], [])
    else if Cells[Col, 0] <> '' then
      quGrid.Locate('SizeName', Cells[Col, 0], []);

  ID1 := quGridIDModel.AsString;
  ID2 := '';
  Qty := quGridTotQtyOnHand.AsString;

  if ID1 <> '' then
     if not chkQtyUpdate.Checked then
        begin
        //Abre o detalhe da ficha
        if not SubModelFch.Start(btAlt, nil, False, ID1, ID2, nil) then
           Exit;
        end
     else
        begin
        //Abre ficha de ajuste de estoque
        with TModelAdjustQty.Create(self) do
           if not Start(StrToInt(ID1), DM.fStore.ID, MyStrToFloat(Qty), 0, 0, 0) then
              Exit;
        end;

  RefreshTab(True);
  quForm.Refresh; 

end;

procedure TFchModel.LoadSubModelFch;
begin
  if SubModelFch = nil then
     SubModelFch := TFchModel.Create(Self);
end;

procedure TFchModel.FreeSubModelFch;
begin
  if SubModelFch <> nil then
    SubModelFch.Free;
end;

procedure TFchModel.RefreshTabGrid;
var
  c: TColor;
  bIsMaster: Boolean;
  sModelType: Char;
  bCanSeeCost: Boolean;
begin
  bShowPageControl := IsDetail;
  bIsMaster := quFormModelType.AsString = MODEL_TYPE_MASTER;

  if bIsMaster then
  begin
    EditModel.MaxLength         := 15;
    DBEditDescription.MaxLength := 25;
  end
  else
  begin
    EditModel.MaxLength         := 30;
    DBEditDescription.MaxLength := 50;
  end;

  // Seta os tabs, e campo especificos do Master Model
  tsGrid.TabVisible := (quFormModelType.AsString = MODEL_TYPE_MASTER);
  scColor.Visible   := (quFormModelType.AsString <> MODEL_TYPE_MASTER);
  lblColor.Visible  := scColor.Visible;
  scSize.Visible    := (quFormModelType.AsString <> MODEL_TYPE_MASTER);
  lblSize.Visible   := scSize.Visible;

  //Setar visivel para os tabs
  if quFormModelType.AsString = '' then
     sModelType := #0
  else
     sModelType := quFormModelType.AsString[1];

  bCanSeeCost := Password.HasFuncRight(2);

  tsPackModel.TabVisible    := (sModelType IN [MODEL_TYPE_PACKAGE]);
  tsInternet.TabVisible     := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE, MODEL_TYPE_CREDIT]));
  tsAdvanced.TabVisible     := (not (sModelType IN [MODEL_TYPE_MASTER]));
  tbKitModel.TabVisible     := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE, MODEL_TYPE_CREDIT]));
  tbPurcHistory.TabVisible  := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE, MODEL_TYPE_CREDIT, MODEL_TYPE_GIFTCARD])) and bCanSeeCost;
  tbOrder.TabVisible        := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE, MODEL_TYPE_CREDIT, MODEL_TYPE_GIFTCARD]));
  tsOrderPoint.TabVisible   := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE, MODEL_TYPE_CREDIT, MODEL_TYPE_GIFTCARD]));
  tbSpecialPrice.TabVisible := (not (sModelType IN [MODEL_TYPE_MASTER, MODEL_TYPE_SERVICE]));
  tbInvoicesHold.TabVisible := (not (sModelType IN [MODEL_TYPE_MASTER]));
  tbSaleHist.TabVisible     := (not (sModelType IN [MODEL_TYPE_MASTER])) and bCanSeeCost;
  tbMovHistory.TabVisible   := (not (sModelType IN [MODEL_TYPE_MASTER])) and bCanSeeCost;
  tbMovTotal.TabVisible     := (not (sModelType IN [MODEL_TYPE_MASTER]));
  tbInvoicesHold.TabVisible := (not (sModelType IN [MODEL_TYPE_MASTER]));
  tsPrice.TabVisible        := bCanSeeCost;
  tsVendorInfo.TabVisible   := bCanSeeCost;

  btnPrice.Visible := bCanSeeCost;

  CheckTabVisible(tsGrid);
  CheckTabVisible(tsPackModel);
  CheckTabVisible(tbCostRetail);
  CheckTabVisible(tsAdvanced);
  CheckTabVisible(tsInternet);
  CheckTabVisible(tbSpecialPrice);
  CheckTabVisible(tbKitModel);
  CheckTabVisible(tbPurcHistory);
  CheckTabVisible(tbSaleHist);
  CheckTabVisible(tbMovHistory);
  CheckTabVisible(tbMovTotal);
  CheckTabVisible(tbOrder);
  CheckTabVisible(tbInvoicesHold);
  CheckTabVisible(tsOrderPoint);

  // Seta os campos e tabs especificos do Sub Model
  bShowMasterPanel := (quFormModelType.AsString <> MODEL_TYPE_SUB);
  bShowTitlePanel  := (quFormModelType.AsString <> MODEL_TYPE_SUB) OR (Owner.Name <> 'FchModel');

  if quFormModelType.AsString = MODEL_TYPE_SUB then
     begin
     chkDisableItem.Visible := True;
     chkDisableItem.Checked := (quFormDesativado.AsInteger=1);
     end
  else
     chkDisableItem.Visible := False;

  chkHiddenItem.Checked := (quFormHidden.AsInteger=1);    

  // Seta a cor dos titulos
  if (quFormModelType.AsString = MODEL_TYPE_SUB) or (quFormModelType.AsString = MODEL_TYPE_REGULAR) then
    c := clBtnShadow
  else
    if quFormModelType.AsString = MODEL_TYPE_MASTER then
       c := $00976435 // Azul personalizado
    else
      if quFormModelType.AsString = MODEL_TYPE_SERVICE then
        c := clOlive
      else
        if quFormModelType.AsString = MODEL_TYPE_CREDIT then
          c := clMaroon // Lilás
        else
          if quFormModelType.AsString = MODEL_TYPE_GIFTCARD then
            c := $00004000 // Verde Escuro personalizado
          else
            c := clGreen;

  SetFormHeight;

  pnlLookUp.Color := c;
  pnlTitle1.Color := c;
  pnlTitle2.Color := c;
  pnlTitle3.Color := c;
  pnlTitle4.Color := c;
  pnlTitle5.Color := c;
  pnlTitle6.Color := c;
  pnlTitle7.Color := c;
  pnlTitle8.Color := c;
  pnlTitle9.Color := c;
  pnlTitle10.Color := c;
  pnlTitle11.Color := c;
  pnlTitle12.Color := c;
  pnlTitle13.Color := c;
  pnlTitle14.Color := c;
  pnlTitle15.Color := c;
  pnlTitle16.Color := c;
  pnlCalcCostRepos.Color := c;
  Label82.Color          := c;
  Label84.Color          := c;
  pnlAccessTitle.Color   := c;
  pnlFeatures.Color      := c;
  pnlTechFeature.Color   := c;
  pnlModelConfig.Color   := c;
  pnlModelMeasure.Color  := c;
  pnlStoreCost.Color     := c;
  pnlStoreSale.Color     := c;
  pnlVendorOrder.Color   := c;

  // seta o enabled do botao do ajust de qty
  btAdjust.Enabled := (quFormModelType.AsString <> MODEL_TYPE_MASTER);

  pnlFloatPercent.Visible := (not bIsMaster) and (DM.fSystem.SrvParam[PARAM_DISPLAY_QTY_FLOATING]);

  chkSendToTrash.Visible := (DM.fSystem.SrvParam[PARAM_SEND_ITEM_FOR_TRASH]);

  if cmbGroup.LookUpValue <> '' then
  begin
    btPriceTable.Visible := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'UsePriceTable') = 'True';
    btPriceTable2.Visible := btPriceTable.Visible;
    btPriceTable3.Visible := btPriceTable.Visible;
  end
  else
  begin
    btPriceTable.Visible := False;
    btPriceTable2.Visible := btPriceTable.Visible;
    btPriceTable3.Visible := btPriceTable.Visible;
  end;

  // Seta o Tab padrao de abertura
  {if quFormModelType.AsString = MODEL_TYPE_MASTER then
    pgModel.ActivePage := tsGrid
  else
    pgModel.ActivePage := tbCostRetail;}

end;


procedure TFchModel.LoadInvoiceForm;
begin
  if FrmInvoice = nil then
    FrmInvoice := TFrmInvoice.Create(Self);
end;

procedure TFchModel.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  CloseQuery;
end;

procedure TFchModel.cmbGroupSelectItem(Sender: TObject);
var
  sSizeAndColor,
  sPackModel,
  sService,
  sCredit,
  sGiftCard: string;

begin
  inherited;
  if (cmbGroup.LookUpValue <> '') and (frmCommand = btInc) then
    begin
      // A partir do tabgroup defino qual o ModelType
      sSizeAndColor := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'SizeAndColor');
      sPackModel    := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'PackModel');
      sService      := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'Service');
      sCredit       := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'Credit');
      sGiftCard     := DM.DescCodigo(['IDGroup'], [cmbGroup.LookUpValue], 'TabGroup', 'GiftCard');

      if sSizeAndColor = 'True' then
        quFormModelType.AsString := MODEL_TYPE_MASTER
      else
        if sPackModel = 'True' then
           quFormModelType.AsString := MODEL_TYPE_PACKAGE
        else
          if sService = 'True' then
            quFormModelType.AsString := MODEL_TYPE_SERVICE
          else
            if sCredit = 'True' then
              quFormModelType.AsString := MODEL_TYPE_CREDIT
            else
              if sGiftCard = 'True' then
                quFormModelType.AsString := MODEL_TYPE_GIFTCARD
              else
                quFormModelType.AsString := MODEL_TYPE_REGULAR;

      if (not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL]) and (VarToStr(cmbGroup.GetFieldByName('UserCode')) <> '') then
         begin
         quForm.Edit;
         quFormModel.AsString := quFormModel.AsString + cmbGroup.GetFieldByName('UserCode');
         end;

      RefreshTabGrid;
    end;

  if bTaxIncludedInCost then
     SubRecalcSalePrice.Param := 'IDGroup='+quFormGroupID.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';

  { Nao funciona com o LookUp
  if cmbGroup.LookUpValue <> '' then
   begin
   scModelGroup.SpcWhereClause := 'IDGroup = ' + cmbGroup.LookUpValue;
   scModelGroup2.SpcWhereClause := 'IDGroup = ' + cmbGroup.LookUpValue;
   end;
   }
end;

procedure TFchModel.FormRefresh;
begin
  // Refresh completo da Tela
  RefreshTabGrid;
  RefreshTab(True);
end;

function TFchModel.OnAfterSaveChange(var iError:Integer):Boolean;
begin

  try
  
    SendToTrashOption;

    if quFormModelType.AsString = MODEL_TYPE_MASTER then
      with spModelSizeColorName do
      begin
        Parameters.ParamByName('@IDModelMaster').Value := quFormIDModel.AsInteger;
        ExecProc;
      end;
    Result := True;
  except
    Result := False;
  end;
  
end;


procedure TFchModel.quFormBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  CloseQuery;
end;

procedure TFchModel.postOnExit(Sender: TObject);
begin
  inherited;
  with TDBGrid(Sender).DataSource.DataSet do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFchModel.dsSpecialPriceStateChange(Sender: TObject);
begin
  inherited;
  if  quSpecialPrice.Active then
    begin
      btAddSpecialPrice.Enabled := quSpecialPrice.RecordCount=0;
      btRemoveSpecialPrice.Enabled := not (btAddSpecialPrice.Enabled);
    end
  else
    begin
      btAddSpecialPrice.Enabled := False;
      btRemoveSpecialPrice.Enabled := False;
    end;

end;

procedure TFchModel.quSpecialPriceAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchModel.dsSerialStateChange(Sender: TObject);
begin
  inherited;

  btAddSerial.Enabled := quSerial.Active;

  with quSerial do
    if Active then
       begin
       btSerialRemove.Enabled := not IsEmpty;
       btEditSerial.Enabled := not IsEmpty;
       end
    else
       begin
       btSerialRemove.Enabled := False;
       btEditSerial.Enabled   := False;
       end;

end;

procedure TFchModel.quSerialAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dsSerialStateChange(nil);
end;

procedure TFchModel.btKitAddClick(Sender: TObject);
begin
  inherited;
  quKitModel.Insert;
  quForm.Edit;
end;

procedure TFchModel.KitModelOpen;
begin
  with quKitModel do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
    end;
end;

Procedure TFchModel.PackCalcTotal;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT	SUM(M.SellingPrice * PM.Qty), SUM(M.FinalCost * PM.Qty), MIN(M.TotQtyOnHand / PM.Qty)');
    SQL.Add('FROM PackModel PM LEFT OUTER JOIN Model M ON (PM.IDModel = M.IDModel)');
    SQL.Add('WHERE PM.IDPackModel = ' + quFormIDModel.AsString);
    Open;
    edtPackSale.Text := FormatFloat('0.00', Fields.Fields[0].AsCurrency);
    edtPackCost.Text := FormatFloat('0.00', Fields.Fields[1].AsCurrency);
    edtNumPack.Text  := Fields.Fields[2].AsString;
    Close;
  end;
end;

procedure TFchModel.PackModelOpen;
begin
  with quPackModel do
    if not Active then
    begin
      Parameters.ParamByName('IDPackModel').Value := quFormIDModel.AsInteger;
      Open;
    end;
end;

procedure TFchModel.PackModelClose;
begin
  with quPackModel do
    if Active then
      Close;
end;

procedure TFchModel.PackModelRefresh;
begin
  PackModelClose;
  PackModelOpen;
end;

procedure TFchModel.KitModelClose;
begin
  KitModelPost;
  quKitModel.Close;
end;

procedure TFchModel.KitModelPost;
begin
  with quKitModel do
    if State in dsEditModes then
      Post;
end;

procedure TFchModel.KitModelRequery;
var
  sID: String;
begin
  sID := quKitModelQty.AsString;

  KitModelClose;
  KitModelOpen;

  if quKitModelQty.AsString <> '' then
    quKitModel.Locate('Qty', sID, []);
end;

procedure TFchModel.dsKitModelStateChange(Sender: TObject);
begin
  inherited;
  // Seto os botoes de inclusao e delecao
  btKitAdd.Enabled := quKitModel.Active;
  btKitRemove.Enabled := btKitAdd.Enabled and (not quKitModel.IsEmpty);
end;

procedure TFchModel.quKitModelAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dsKitModelStateChange(nil);

end;

procedure TFchModel.btKitRemoveClick(Sender: TObject);
begin
  inherited;
  quKitModel.Delete;
  KitModelRequery;
end;

procedure TFchModel.quKitModelAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchModel.btEditSerialClick(Sender: TObject);
begin
  inherited;
  with TNewSerial.Create(Self) do
    begin
      if Update(quFormIDModel.AsInteger,
                quSerialStoreID.AsInteger,
                quSerialSerial.AsString) then
        begin
          quSerial.Close;
          quSerial.Open;
        end;
      Free;
    end;

end;

procedure TFchModel.btnPrintBarcodeClick(Sender: TObject);
var
  MyBarcode,
  MyIDModel : String;
begin
  inherited;

  //Print Barcode
  If quBarcode.Active then
     begin
     MyBarcode := Trim(quBarCodeIDBarcode.AsString);
     MyIDModel := quBarCodeIDModel.AsString;
     end;

  with TFrmBarcodePrint.Create(Self) do
     Start(MyIDModel, MyBarcode);
     
end;

procedure TFchModel.btnAddSizeColorClick(Sender: TObject);
begin
  inherited;
  //Add Grid

  DoPost;

  if TestSizeAndColor then
    with TFrmModelAddSizeColor.Create(self) do
    begin
      if Start(quFormIDModel.AsInteger) then
        begin
          quGrid.Close;
          RefreshTab(False);
        end;
    end;

end;

procedure TFchModel.grdSpecialPriceGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  inherited;

  //if (Table1.FieldByName('CustNo').AsInteger = 13) and
  if (Field.Name = 'SpecialPrice') then

  // if (Field.FieldByName('SpecialPrice').AsString <> '') then
      Background := clBtnFace;

end;

procedure TFchModel.spquQuantityAfterOpen(DataSet: TDataSet);
begin
  inherited;
  spquQuantity.Parameters.ParambyName('@ModelID').Value := quFormIDModel.AsInteger;
  SubQty.Param := 'IDModel='+quFormIDModel.AsString+';';
  if bTaxIncludedInCost then
     SubRecalcSalePrice.Param := 'IDGroup='+quFormGroupID.AsString+';IDStore='+IntToStr(DM.fStore.ID)+';';
  SubPrice.Param := 'IDModel='+quFormIDModel.AsString+';ShowCost=1;ShowAvgCost=1;';
end;

procedure TFchModel.btnRemovePackClick(Sender: TObject);
begin
  inherited;

  if (quPackModelIDModel.AsString = '') or
     (quPackModelIDPackModel.AsString = '') then
     Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('DELETE PackModel');
    SQL.Add('WHERE IDPackModel = '+quPackModelIDPackModel.AsString+' AND IDModel = '+quPackModelIDModel.AsString);
    ExecSQL;
    end;

  PackModelRefresh;

end;

procedure TFchModel.btnAddPackClick(Sender: TObject);
var
  sQty : String;
begin
  inherited;

  //Check empty Model
  if scModelPack.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbExclamation);
    Exit;
  end;

  //Check empty Qty
  if (edtQtyOut.Text = '') or (StrToFloat(edtQtyOut.Text) <= 0) then
  begin
    MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbCritical + vbOKOnly);
    edtQtyOut.SetFocus;
    Exit;
  end;

  with quPackModel do
  begin
    if not Active then
      Exit;
    if Locate('IDPackModel;IDModel',VarArrayOf([quFormIDModel.AsString,scModelPack.LookUpValue]),[]) then
    begin
      msgbox(MSG_CRT_NO_DUPLICATE_MODEL, vbOkOnly + vbExclamation);
      Exit;
    end;
  end;

  sQty := edtQtyOut.Text;
  sQty := MyFormatTax(StrToFloat(sQty),'.');
  sQty := QuotedStr(sQty);

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('INSERT PackModel (IDPackModel, IDModel, Qty)');
    SQL.Add('VALUES ( '+quFormIDModel.AsString+','+scModelPack.LookUpValue+','+sQty+')');
    ExecSQL;
  end;

  PackModelRefresh;
  scModelPack.LookUpValue := '';
  edtQtyOut.Clear;

end;

procedure TFchModel.quPackModelAfterOpen(DataSet: TDataSet);
begin
  inherited;
  PackCalcTotal;
end;

procedure TFchModel.edtQtyOutKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TFchModel.btnCalcPriceClick(Sender: TObject);
begin
  inherited;
  //UPdate Cost and Sale Price
  with quForm do
  begin
    if not (State in dsEditModes) then
       Edit;
    quFormVendorCost.AsCurrency   := StrToCurr(edtPackCost.Text);
    quFormSellingPrice.AsCurrency := StrToCurr(edtPackSale.Text);
  end;

  pgModel.ActivePage := tbCostRetail;
end;

procedure TFchModel.AccessoryClose;
begin
  with quAccessory do
     if Active then
        Close;
end;

procedure TFchModel.AccessoryOpen;
begin
  with quAccessory do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
        end;
end;

procedure TFchModel.AccessoryRefresh;
begin
   AccessoryClose;
   AccessoryOpen;
end;

procedure TFchModel.btAddAccessoryClick(Sender: TObject);
  function ValidateAccessory:Boolean;
  begin

  Result := False;

  if scModelAccessory.LookUpValue = '' then
     begin
     msgbox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbExclamation);
     Exit;
     end;

  with quAccessory do
    begin
    if not Active then
       Exit;
    if Locate('IDInvAccessory;IDModel',VarArrayOf([scModelAccessory.LookUpValue,quFormIDModel.AsString]),[]) then
       begin
       msgbox(MSG_CRT_NO_DUPLICATE_MODEL, vbOkOnly + vbExclamation);
       Exit;
       end;
    end;

  Result := True;

  end;

begin
  inherited;

  if not ValidateAccessory then
     Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('INSERT InvAccessory (IDInvAccessory, IDModel, Description)');
    SQL.Add('VALUES ( '+scModelAccessory.LookUpValue+','+quFormIDModel.AsString+','+QuotedStr(edtAccessotyHint.Text)+')');
    ExecSQL;
    end;

  AccessoryRefresh;
  scModelAccessory.LookUpValue := '';
  edtAccessotyHint.Clear;
  scModelAccessory.SetFocus;
end;

procedure TFchModel.btDelAccessoryClick(Sender: TObject);
begin
  inherited;

  if (quAccessoryIDInvAccessory.AsString = '') or
     (quAccessoryIDModel.AsString = '') then
     Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('DELETE InvAccessory');
    SQL.Add('WHERE IDInvAccessory = '+quAccessoryIDInvAccessory.AsString+' AND IDModel = '+quAccessoryIDModel.AsString);
    ExecSQL;
    end;

  AccessoryRefresh;

end;

procedure TFchModel.FeaturesClose;
begin
  with quFeatures do
     if Active then
        Close;
end;

procedure TFchModel.FeaturesOpen;
begin
  with quFeatures do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
        end;
end;

procedure TFchModel.FeaturesRefresh;
begin
  FeaturesClose;
  FeaturesOpen;
end;

procedure TFchModel.pgWebInfoChange(Sender: TObject);
begin
  inherited;
  RefreshTabInternet;
end;

procedure TFchModel.btnAddFeatureClick(Sender: TObject);
  function ValidateFeature:Boolean;
  begin
  Result := False;
  if edtFeature.Text = '' then
     begin
     msgbox(MSG_CRT_NO_FEATURE, vbOkOnly + vbExclamation);
     Exit;
     end;
  Result := True;
  end;
var
  iID : Integer;
begin
  inherited;

  if not ValidateFeature then
     Exit;

  iID := DM.GetNextID(MR_INV_FEATURE_ID);

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('INSERT InvFeatures (IDInvFeatures, IDModel, Feature)');
    SQL.Add('VALUES ( '+IntToStr(iID)+','+quFormIDModel.AsString+','+QuotedStr(edtFeature.Text)+')');
    ExecSQL;
    end;

  FeaturesRefresh;
  edtFeature.Clear;
  edtFeature.SetFocus;

end;

procedure TFchModel.btnDelFeatureClick(Sender: TObject);
begin
  inherited;

  if (quFeaturesIDInvFeatures.AsString = '') then
     Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('DELETE InvFeatures');
    SQL.Add('WHERE IDInvFeatures = '+quFeaturesIDInvFeatures.AsString);
    ExecSQL;
    end;

  FeaturesRefresh;

end;

procedure TFchModel.TechFeaturesClose;
begin

  with quTechFeature do
     if Active then
        Close;

end;

procedure TFchModel.TechFeaturesOpen;
begin

  with quTechFeature do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
        Open;
        end;

end;

procedure TFchModel.TechFeaturesRefresh;
begin
  TechFeaturesClose;
  TechFeaturesOpen;
end;

procedure TFchModel.btnTechAddClick(Sender: TObject);
  function ValidateFeature:Boolean;
  begin
  Result := False;
  if edtTechFeature.Text = '' then
     begin
     msgbox(MSG_CRT_NO_FEATURE, vbOkOnly + vbExclamation);
     Exit;
     end;
  Result := True;
  end;
var
  iID : Integer;
begin
  inherited;

  if not ValidateFeature then
     Exit;

  iID := DM.GetNextID(MR_INV_TECH_FEATURE_ID);

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('INSERT InvTechFeatures (IDInvTechFeatures, IDModel, TechFeature)');
    SQL.Add('VALUES ( '+IntToStr(iID)+','+quFormIDModel.AsString+','+QuotedStr(edtTechFeature.Text)+')');
    ExecSQL;
    end;

  TechFeaturesRefresh;
  edtTechFeature.Clear;
  edtTechFeature.SetFocus;

end;

procedure TFchModel.btnTechDelClick(Sender: TObject);
begin
  inherited;

  if (quTechFeatureIDInvTechFeatures.AsString = '') then
     Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('DELETE InvTechFeatures');
    SQL.Add('WHERE IDInvTechFeatures = '+quTechFeatureIDInvTechFeatures.AsString);
    ExecSQL;
    end;

  TechFeaturesRefresh;

end;

procedure TFchModel.edtFloatPercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFchModel.RefreshTabInternet;
begin

  if pgWebInfo.ActivePage = tsAccessory then
    begin
    AccessoryOpen;
    end
  else if pgWebInfo.ActivePage = tsFeatures then
    begin
    FeaturesOpen;
    TechFeaturesOpen;
    end
  else if pgWebInfo.ActivePage = tsWebImagems then
    begin
    SubListInternet.CreateSubList;
    SubListInternet2.CreateSubList;
    SubListInternet.Param  := 'IDModel='+quFormIDModel.AsString+';StartImage=;ShowOpen=1;ImageNum=1;';
    SubListInternet2.Param := 'IDModel='+quFormIDModel.AsString+';StartImage=;ShowOpen=1;ImageNum=2;';
    end;

end;

procedure TFchModel.btnCalcSaleTaxClick(Sender: TObject);
var
 cValor,
 cPercent : Double;
 cSalePrice : Currency;
 s : String;
begin
  inherited;

  if bMarkUpOverCost then
     cValor := quFormFinalCost.AsCurrency
  else
     if quFormAvgCost.IsNull then
        cValor := quFormFinalCost.AsCurrency
     else
        cValor := quFormAvgCost.AsCurrency;

  with quForm do
    begin
      if not (State in dsEditModes) then
         Edit;

      //quFormSellingPrice.AsFloat := cValor * (1 + (quFormMarkUp.AsFloat / 100));

      cPercent := StrToFloatDef(SubRecalcSalePrice.GetSubListInfo(s),0);

      cSalePrice := CalcSalePrice(quFormMarkUp.AsFloat, cValor, (cPercent/100));

      if cSalePrice <> quFormSellingPrice.AsFloat then
      begin
        quFormDateLastSellingPrice.AsDateTime := Now;
        quFormIDUserLastSellingPrice.AsInteger := DM.fUser.ID;
      end;

      quFormSellingPrice.AsFloat := cSalePrice;

    end;

end;

function TFchModel.CalcSaleWithTax(Sale: Double): Double;
var
 s : String;
 TotalPercent : Double;
begin

  TotalPercent := StrToFloatDef(SubRecalcSalePrice.GetSubListInfo(s),0);
  Result := (Sale * (TotalPercent/100));

end;

function TFchModel.CalcSalePrice(PerNet, Cost, Tax: Double): Currency;
begin
  Result := (((PerNet/100)*Cost)+Cost)/(1-Tax);
end;

procedure TFchModel.quFormBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if bTaxIncludedInCost then
     bHasSubCalcTax := False;
end;

procedure TFchModel.chkDisableItemClick(Sender: TObject);
begin
  inherited;

  if (quFormTotQtyOnHand.AsFloat > 0) and chkDisableItem.Checked then
     begin
     MsgBox(MSG_INF_ITEM_HAS_POS_QTY, vbOkOnly + vbExclamation);
     chkDisableItem.Checked := False;
     Exit;
     end;

  quForm.Edit;
  if chkDisableItem.Checked then
     quFormDesativado.AsInteger := 1
  else
     quFormDesativado.AsInteger := 0;
end;

procedure TFchModel.chkHiddenItemClick(Sender: TObject);
begin
  inherited;

  quForm.Edit;
  if chkHiddenItem.Checked then
     quFormHidden.AsInteger := 1
  else
     quFormHidden.AsInteger := 0;

end;

procedure TFchModel.VendorCodeClose;
begin
  with quVendorCode do
    if Active then
       Close;
end;

procedure TFchModel.VendorCodeOpen;
begin
  with quVendorCode do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
      First;
      while not EOf do
      begin
        if cdsModelVendor.Locate('IDVendor;IDModel', VarArrayOf([FieldByName('IDPessoa').AsInteger, quFormIDModel.AsInteger]), []) then
        begin
          cdsModelVendor.Edit;
          cdsModelVendorVendorCodeList.AsString := cdsModelVendorVendorCodeList.AsString + FieldByName('VendorCode').AsString + '; ';
          cdsModelVendor.Post;
        end
        else
        begin
          cdsModelVendor.Append;
          cdsModelVendorIDModel.AsInteger       := quFormIDModel.AsInteger;
          cdsModelVendorIDVendor.AsInteger      := FieldByName('IDPessoa').AsInteger;
          cdsModelVendorVendor.AsString         := FieldByName('Vendor').AsString;
          cdsModelVendorVendorCodeList.AsString := FieldByName('VendorCode').AsString  + ';';
          cdsModelVendor.Post;
        end;
        Next;
      end;
    end;
end;

procedure TFchModel.VendorCodeRefresh;
begin
  VendorCodeClose;
  VendorCodeOpen;
end;

procedure TFchModel.scSubManufactureSelectItem(Sender: TObject);
begin
  inherited;

  if (scSubManufacture.LookUpValue <> '') and (not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL]) and
     (frmCommand = btInc) then
    if VarToStr(scSubManufacture.GetFieldByName('UserCode')) <> '' then
       begin
       quForm.Edit;
       quFormModel.AsString := quFormModel.AsString + scSubManufacture.GetFieldByName('UserCode');
       end;

end;

procedure TFchModel.scModelSubGroupSelectItem(Sender: TObject);
begin
  inherited;

  if (frmCommand = btInc) and (not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL]) and
     (VarToStr(scModelSubGroup.GetFieldByName('UserCode')) <> '') then
     begin
     quForm.Edit;
     quFormModel.AsString := quFormModel.AsString + scModelSubGroup.GetFieldByName('UserCode');
     end;

end;

procedure TFchModel.quStorePriceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtStoreCost.Caption    := FormatFloat('#,##0.00', quStorePriceStoreCostPrice.AsCurrency);
  edtStoreAvgCost.Caption := FormatFloat('#,##0.00', quStorePriceStoreAvgPrice.AsCurrency);
  edtStoreSalle.Caption   := FormatFloat('#,##0.00', quStorePriceSellingPrice.AsCurrency);
end;

procedure TFchModel.StoreInfoClose;
begin
  with quStorePrice do
     if Active then
        Close;
end;

procedure TFchModel.StoreInfoOpen;
begin
  with quStorePrice do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
        Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
        Open;
        end;
end;

procedure TFchModel.StoreInfoRefresh;
begin
  StoreInfoClose;
  StoreInfoOpen;
end;

procedure TFchModel.scModelGroupSelectItem(Sender: TObject);
begin
  inherited;

  {Nao Funciona com o Lookup
  if (scModelGroup.LookUpValue <> '') then
   begin
   scModelSubGroup.SpcWhereClause := 'IDModelGroup = '+ scModelGroup.LookUpValue;
   scModelSubGroup2.SpcWhereClause := 'IDModelGroup = ' + scModelGroup.LookUpValue;
   end;
  }

  if (frmCommand = btInc) and (not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL]) and 
     (VarToStr(scModelGroup.GetFieldByName('UserCode')) <> '') then
     begin
     quForm.Edit;
     quFormModel.AsString := quFormModel.AsString + scModelGroup.GetFieldByName('UserCode');
     end;
  
end;

procedure TFchModel.editNetCostClick(Sender: TObject);
begin
  inherited;
  TDBEdit(Sender).SelectAll; 
end;

procedure TFchModel.ModelVendorClose;
begin
  with quModelVendor do
    if Active then
       Close;
end;

procedure TFchModel.ModelVendorOpen;
begin
  with quModelVendor do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
      First;
      while not EOf do
      begin
        if cdsModelVendor.Locate('IDVendor;IDModel', VarArrayOf([FieldByName('IDPessoa').AsInteger, quFormIDModel.AsInteger]), []) then
        begin
          cdsModelVendor.Edit;
          cdsModelVendorVendorOrder.AsInteger := FieldByName('VendorOrder').AsInteger;
          cdsModelVendorMinQtyPO.AsFloat      := FieldByName('MinQtyPO').AsFloat;
          cdsModelVendorCaseQty.AsFloat       := FieldByName('CaseQty').AsFloat;
          cdsModelVendorVendorCost.AsCurrency     := FieldByName('VendorCost').AsCurrency;
          cdsModelVendorCostLastChange.AsDateTime := FieldByName('CostLastChange').AsDateTime;
          cdsModelVendor.Post;
        end
        else
        begin
          cdsModelVendor.Append;
          cdsModelVendorIDModel.AsInteger     := quFormIDModel.AsInteger;
          cdsModelVendorIDVendor.AsInteger    := FieldByName('IDPessoa').AsInteger;
          cdsModelVendorVendor.AsString       := FieldByName('Vendor').AsString;
          cdsModelVendorVendorOrder.AsInteger := FieldByName('VendorOrder').AsInteger;
          cdsModelVendorMinQtyPO.AsFloat      := FieldByName('MinQtyPO').AsFloat;
          cdsModelVendorCaseQty.AsFloat       := FieldByName('CaseQty').AsFloat;
          cdsModelVendorVendorCost.AsCurrency     := FieldByName('VendorCost').AsCurrency;
          cdsModelVendorCostLastChange.AsDateTime := FieldByName('CostLastChange').AsDateTime;
          cdsModelVendor.Post;
        end;
        Next;
      end;
    end;
end;

procedure TFchModel.ModelVendorRefresh;
begin
  ModelVendorClose;
  ModelVendorOpen;
end;

procedure TFchModel.pgModelInfoChange(Sender: TObject);
begin
  inherited;
  if pgModelInfo.ActivePage = tsVendorInfo then
  begin
    ModelVendorListRefresh;
    ModelVendorRefresh;
    VendorCodeRefresh;
  end
  else if pgModelInfo.ActivePage = tsPrintReceipt then
    ModelReceiptRefresh
  else if pgModelInfo.ActivePage = tsGovernement then
    StateTaxRefresh
  else if pgModelInfo.ActivePage = tsNutrition then
    ModelNutritionRefresh;

end;

procedure TFchModel.btnRemoveVendorListClick(Sender: TObject);
var
  sSQL : String;
  iIDVendor, iIDModel : Integer;
begin
  inherited;

  with cdsModelVendor do
    if Active and (not IsEmpty) then
    begin
      iIDVendor := FieldByName('IDVendor').AsInteger;
      iIDModel  := FieldByName('IDMOdel').AsInteger;

      sSQL := 'DELETE Inv_ModelVendor WHERE IDPessoa = ' + IntToStr(iIDVendor) +
              ' AND IDModel = ' + IntToStr(iIDModel);
      DM.RunSQL(sSQL);

      sSQL := 'DELETE VendorModelCode WHERE IDPessoa = ' + IntToStr(iIDVendor) +
              ' AND IDModel = ' + IntToStr(iIDModel);
      DM.RunSQL(sSQL);

      ModelVendorListRefresh;
      UpdateVendorOrder;
      VendorCodeRefresh;
    end;

end;

procedure TFchModel.btnAddVendorListClick(Sender: TObject);
begin
  inherited;

  with TNewFornecedor.Create(Self) do
    if Start(-1, quFormIDModel.AsInteger, quModelVendor) then
    begin
      ModelVendorListRefresh;
      ModelVendorRefresh;
      VendorCodeRefresh;
    end;
end;

procedure TFchModel.btnModelVendorUPClick(Sender: TObject);
begin
  inherited;

  if not cdsModelVendor.IsEmpty then
    with quModelVendor do
    if Locate('IDModel;IDPessoa', VarArrayOf([cdsModelVendorIDModel.AsString, cdsModelVendorIDVendor.AsString]), []) then
      if not BOF then
      begin
        Edit;
        quModelVendorVendorOrder.AsInteger := quModelVendorVendorOrder.AsInteger - 1;
        Post;
        Prior;
        Edit;
        quModelVendorVendorOrder.AsInteger := quModelVendorVendorOrder.AsInteger + 1;
        Post;

        ModelVendorListRefresh;
        ModelVendorRefresh;
        VendorCodeRefresh;
      end;

end;

procedure TFchModel.btnModelVendorDownClick(Sender: TObject);
begin
  inherited;

  if not cdsModelVendor.IsEmpty then
    with quModelVendor do
    if Locate('IDModel;IDPessoa', VarArrayOf([cdsModelVendorIDModel.AsString, cdsModelVendorIDVendor.AsString]), []) then
      if not EOF then
      begin
        Edit;
        quModelVendorVendorOrder.AsInteger := quModelVendorVendorOrder.AsInteger + 1;
        Post;
        Next;
        Edit;
        quModelVendorVendorOrder.AsInteger := quModelVendorVendorOrder.AsInteger - 1;
        Post;

        ModelVendorListRefresh;
        ModelVendorRefresh;
        VendorCodeRefresh;
      end;

end;

procedure TFchModel.dsModelVendorStateChange(Sender: TObject);
begin
  inherited;
  if quModelVendor.Active then
    btnRemoveVendorList.Enabled := (quModelVendor.RecordCount > 0)
  else
    btnRemoveVendorList.Enabled := False;
end;

procedure TFchModel.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchModel.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TFchModel.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  iIDModel: Integer;
  IDModelParent : Variant;
  sBarcode: String;
begin
  inherited;
  with edtBarcode do
  begin
    if SearchResult then
    begin
      iIDModel := GetFieldValue('IDModel');
      IDModelParent := GetFieldValue('IDModelParent');


      if (IDModelParent <> NULL) and (IDModelParent <> 0) then
      begin
       pgModel.ActivePage := tsGrid;
       iIDModel := IDModelParent;
      end;

      scLookUp.LookUpValue := IntToStr(iIDModel);
      scLookUpSelectItem(nil);
        
    end else if (DM.fSystem.VersionType <> QuotedStr(SYSTEM_CLIENT_TYPE)) then
      if (MsgBox(MSG_INF_MODEL_NOT_FOUND_CREATE, vbQuestion + vbYesNo) = vbYes) then
      begin
        sBarcode := CreateNewModel(edtBarcode.Text);
        if sBarcode <> '' then
        begin
          Clear;
          Text := sBarcode;
          DoKeyPress(#13);
        end;
      end;
  end;

  edtBarcode.Clear;
end;

procedure TFchModel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDMInventory);

  if Assigned(fFrmBarcodeSearch) then
    FreeAndNil(fFrmBarcodeSearch);

  if Assigned(FFrmModelPrice) then
    FreeAndNil(FFrmModelPrice);
end;

procedure TFchModel.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;
  if not Assigned(fFrmBarcodeSearch) then
    fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  with fFrmBarcodeSearch do
  begin
    R := Start;
    if R <> -1 then
      scModelPack.LookUpValue := IntToStr(R);
  end;
end;

procedure TFchModel.quFormFreightCostChange(Sender: TField);
begin
  inherited;
  bApplyMargin  := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  bChangePrices := True;
end;

procedure TFchModel.OnBeforeDoCancel;
begin
  inherited;
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQl.Text := 'DELETE IM ' +
                'FROM InventoryMov IM JOIN Model M ON (IM.ModelID = M.IDModel) ' +
                'WHERE M.IDModelParent = ' + quFormIDModel.AsString;
    ExecSQL;

    SQl.Text := 'DELETE I ' +
                'FROM Inventory I JOIN Model M ON (I.ModelID = M.IDModel) ' +
                'WHERE M.IDModelParent = ' + quFormIDModel.AsString;
    ExecSQL;

    SQl.Text := 'DELETE B FROM Barcode B JOIN Model M ON (B.IDModel = M.IDModel) WHERE M.IDModelParent = ' + quFormIDModel.AsString;
    ExecSQL;

    SQl.Text := 'DELETE Model WHERE IDModelParent = ' + quFormIDModel.AsString;
    ExecSQL;
  end;
end;

procedure TFchModel.ModelReceiptClose;
begin
  with quModelReceipt do
    if Active then
      Close;
end;

procedure TFchModel.ModelReceiptOpen;
begin
  with quModelReceipt do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
    end;
end;

procedure TFchModel.ModelReceiptRefresh;
begin
  ModelReceiptClose;
  ModelReceiptOpen;
end;

procedure TFchModel.btRemoveModelReceiptClick(Sender: TObject);
begin
  if (quModelReceipt.Active) and (quModelReceiptIDModelReceipt.AsInteger <> 0) then
  begin
    DM.RunSQL('DELETE Inv_ModelReceipt WHERE IDModelReceipt = ' + quModelReceiptIDModelReceipt.AsString);
    ModelReceiptRefresh;
  end;
end;

procedure TFchModel.btAddModelReceiptClick(Sender: TObject);
begin
  inherited;
  with TNewModelReceipt.Create(Self) do
    if Start(quFormIDModel.AsInteger) then
      ModelReceiptRefresh;
end;

procedure TFchModel.dsModelReceiptStateChange(Sender: TObject);
begin
  inherited;
  if quModelReceipt.Active then
    btRemoveModelReceipt.Enabled := quModelReceipt.RecordCount > 0
  else
    btRemoveModelReceipt.Enabled := False;
end;

procedure TFchModel.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  with quBarCode do
  if not BOF then
  begin
    Edit;
    quBarCodeBarcodeOrder.AsInteger := quBarCodeBarcodeOrder.AsInteger - 1;
    Post;
    Prior;
    Edit;
    quBarCodeBarcodeOrder.AsInteger := quBarCodeBarcodeOrder.AsInteger + 1;
    Post;
    BarCodeRefresh
  end;
end;

procedure TFchModel.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  with quBarCode do
  if not EOF then
  begin
    Edit;
    quBarCodeBarcodeOrder.AsInteger := quBarCodeBarcodeOrder.AsInteger + 1;
    Post;
    Next;
    Edit;
    quBarCodeBarcodeOrder.AsInteger := quBarCodeBarcodeOrder.AsInteger - 1;
    Post;
    BarCodeRefresh
  end;
end;



procedure TFchModel.BarCodeRefresh;
begin
  BarCodeClose;
  BarCodeOpen;
end;

procedure TFchModel.BarCodeClose;
begin
  with quBarcode do
     if Active then
        Close;
end;

procedure TFchModel.BarCodeOpen;
begin
  with quBarcode do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
    end;
end;

procedure TFchModel.btnClearSellPriceClick(Sender: TObject);
begin
  inherited;
  with quForm do
  begin
    if not (State in dsEditModes) then
      Edit;
    quFormDateLastSellingPrice.AsString := '';
  end;
end;

function TFchModel.CalcMarkUp(CostPrice:Currency; Markup: Currency): Currency;
var
  PriceMarkup : TPriceMarkup;
begin
  PriceMarkup := TPriceMarkup.Create(CostPrice, Markup);
  try
    Result := PriceMarkup.CalcMarkup;
  finally
    FreeAndNil(PriceMarkup);
    end;
end;

procedure TFchModel.editNetCostExit(Sender: TObject);
begin
  if quForm.State in (dsEditModes) then
  begin
    if bApplyMargin then
      AutoRecalPrices;

    CalcCaseCost;
  end;
end;

procedure TFchModel.editOtherCostExit(Sender: TObject);
begin
  if quForm.State in (dsEditModes) then
    if bApplyMargin then
      AutoRecalPrices;
end;

procedure TFchModel.editFreightCostExit(Sender: TObject);
begin
  if quForm.State in (dsEditModes) then
    if bApplyMargin then
      AutoRecalPrices;
end;

function TFchModel.CreateNewModel(Barcode : String): String;
var
//  FFrmModelQuickEntry : TFrmModelQuickEntry; amfsouza 11.16.2010
  FFrmModelAdd: TFrmModelAdd;
  ABarcode : TBarcode;
begin
  try
    Result := '';
    FFrmModelAdd := TFrmModelAdd.Create(Self);
    ABarcode := FFrmModelAdd.Start(False, True, True, Barcode);
    if VarToStr(ABarcode.IDBarcode) <> '' then
      Result := ABarcode.IDBarcode
    else if ABarcode.Model.Model <> '' then
      Result := ABarcode.Model.Model;
  finally
    FreeAndNil(FFrmModelAdd);
    end;
end;

procedure TFchModel.EditModelExit(Sender: TObject);
begin
  if (Trim(EditModel.Text) <> '') and (frmCommand = btInc) and DM.fSystem.SrvParam[PARAM_USE_CATALOG] then
    VerifyModelCatalog;
end;

procedure TFchModel.InsertBarcode(IDBarcode: String; Qty: Double);
var
    LastBarcode: Integer;
begin
  with quBarCode do
    begin
      DisableControls;

      Last;
      LastBarcode := quBarCodeBarcodeOrder.AsInteger;

      Append;
      quBarCodeIDModel.AsInteger      := quFormIDModel.AsInteger;
      quBarCodeIDBarCode.AsString     := IDBarcode;
      quBarCodeData.AsDateTime        := Date;
      quBarCodeBarcodeOrder.AsInteger := LastBarcode + 1;
      if Qty > 1 then
        quBarCodeQty.AsFloat          := Qty;

      try
        Post;
      except
        on exception do
        begin
          Cancel;
          MessageBeep(MB_ICONASTERISK);
          MsgBox(MSG_EXC_BARCODE_EXISTE, vbOKOnly + vbExclamation);
        end;
      end;
      BarCodeRefresh;
      EnableControls;
    end;
end;

procedure TFchModel.quFormBeforePost(DataSet: TDataSet);
begin

  if not fIsRestricForm then
    quFormVerify.AsBoolean := False;

  if quFormMarkUp.AsString = '' then
    quFormMarkUp.AsFloat := 0;

  if bHasChangePrice then
  begin
    quFormDateLastSellingPrice.AsDateTime := Now;
    quFormIDUserLastSellingPrice.AsInteger := DM.fUser.ID;
  end;

  if bChangePrices then
    SavePriceChanges;

  FormatPrices;

end;

procedure TFchModel.FormatPrices;
begin
  quFormFreightCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormFreightCost.AsCurrency);
  quFormOtherCost.AsCurrency   := DM.FDMCalcPrice.FormatPrice(quFormOtherCost.AsCurrency);
  quFormVendorCost.AsCurrency  := DM.FDMCalcPrice.FormatPrice(quFormVendorCost.AsCurrency);
end;

procedure TFchModel.VerifyModelCatalog;
var
  CatalogModelService : TCatalogModelService;
  Barcode: TBarcode;
  Model :TModel;
begin
  try
    CatalogModelService   := TCatalogModelService.Create();
    Barcode               := TBarcode.Create();
    Model                 := TModel.Create();

    CatalogModelService.SQLConnection := DM.ADODBConnect;

    Barcode.Model       := Model;
    Barcode.Model.Model := EditModel.Text;
    Barcode.Model.IDModel := quFormIDModel.Value;

    if CatalogModelService.Find(Barcode.Model) then
    begin
      quFormDescription.Value := Barcode.Model.Description;
      quFormVendorCost.Value  := Barcode.Model.VendorCost;
      quFormCaseQty.Value     := Barcode.Model.CaseQty;
      quFormSuggRetail.Value  := Barcode.Model.SuggRetail;

      if VarToStr(Barcode.Model.Category.IDGroup) <> '' then
      begin
        quFormGroupID.Value := Barcode.Model.Category.IDGroup;
        btUpdateClick(Self);
      end;

      if VarToStr(Barcode.Model.ModelGroup.IDModelGroup) <> '' then
        quFormIDModelGroup.Value   := Barcode.Model.ModelGroup.IDModelGroup;

      if VarToStr(Barcode.Model.ModelSubGroup.IDModelSubGroup) <> '' then
        quFormIDModelSubGroup.Value   := Barcode.Model.ModelSubGroup.IDModelSubGroup;

      if Barcode.Model.Manufacturer.IDManufacturer <> 0 then
        quFormIDFabricante.Value := Barcode.Model.Manufacturer.IDManufacturer;

      if (Barcode.IDBarcode <> Null) and (Barcode.IDBarcode <> '') then
      begin
        BarCodeRefresh;
        InsertBarcode(Barcode.IDBarcode, 0);
      end;
    end;
  finally
    if Assigned(CatalogModelService) then
      FreeAndNil(CatalogModelService);

    if Assigned(Barcode) then
      FreeAndNil(Barcode);

  end;
end;

procedure TFchModel.edtCaseCostKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFchModel.CalcCaseCost;
begin
  if (quFormCaseQty.Value > 1) then
  begin
    pnlCaseCost.Visible := True;
    edtCaseCost.Text := FormatCurr('#,##0.00',quFormCaseQty.Value * (quFormVendorCost.Value + quFormOtherCost.Value + quFormFreightCost.Value));
  end
  else
    pnlCaseCost.Visible := False
end;

procedure TFchModel.DBEdit26Exit(Sender: TObject);
begin
  inherited;
  CalcCaseCost;
end;

procedure TFchModel.edtCaseCostExit(Sender: TObject);
begin
  inherited;
  if quForm.State in (dsEditModes) then
  begin
    quFormVendorCost.Value := DM.FDMCalcPrice.FormatPrice(quFormVendorCost.Value);

    if (quFormCaseQty.Value <> 0) and
       (quFormVendorCost.Value <> (MyStrToDouble(edtCaseCost.Text,DecimalSeparator) / (quFormCaseQty.Value))) then
    begin
      dsForm.Edit;
      quFormVendorCost.Value := DM.FDMCalcPrice.FormatPrice(MyStrToDouble(edtCaseCost.Text,DecimalSeparator) / (quFormCaseQty.Value));
    end;
  end;
end;

procedure TFchModel.grdKitModelDBTableViewSellingPricePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if Error then
  begin
    MsgBox(MSG_INF_PRICE_INVALID, vbInformation + vbOKOnly);
    quKitModelSellingPrice.AsCurrency := quFormSellingPrice.AsCurrency;
    ErrorText := '';
  end;
end;

procedure TFchModel.grdKitModelExit(Sender: TObject);
begin
  inherited;
  with quKitModel do
    if State in dsEditModes then
    begin
      UpdateRecord;
      if quKitModelQty.AsFloat <> 0 then
        KitModelPost
      else
        quKitModel.Cancel;
    end;
end;

procedure TFchModel.UpdateKitPromoPrice(CostPrice: Currency);
begin
  with quKitModel do
  begin
    if not(quKitModel.IsEmpty) then
    begin
      First;
      while not Eof do
      begin
        if quKitModelMarginPerc.AsFloat <> 0 then
        begin
          Edit;
          quKitModelSellingPrice.AsFloat := DM.FDMCalcPrice.GetMarginPrice(CostPrice, quKitModelMarginPerc.AsFloat);
          Post;
        end;
        Next;
      end;
    end;
  end;
end;

procedure TFchModel.grdKitModelDBTableViewQtyPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if Error then
  begin
    MsgBox(MSG_INF_WRONG_QTY, vbInformation + vbOKOnly);
    quKitModelQty.AsFloat := 2;
    ErrorText := '';
  end;
end;

procedure TFchModel.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited FormCloseQuery(Sender,CanClose);

  if (quForm.Active) and (not fIsRestricForm) then
  begin
    if quFormVerify.AsBoolean then
    begin
      if not(quForm.State in dsEditModes) then
        quForm.Edit;

      quFormVerify.AsBoolean := False;
      quForm.Post;
    end;

    if ((bTaxIncludedInCost and not(bUseMarkupOnCost)) and bApplyMargin) then
    begin
      if not(quForm.State in dsEditModes) then
        quForm.Edit;

      quFormMarkUp.AsFloat := quFormRealMarkUpPercet.AsFloat;
      quForm.Post;
    end;
  end;

end;

procedure TFchModel.quKitModelMarginPercValidate(Sender: TField);
var
  CostPrice: Currency;
begin
  inherited;
  if quKitModelMarginPerc.AsFloat <> 0 then
    begin
      if quKitModelMarginPerc.AsFloat > 99.99 then
        quKitModelMarginPerc.AsFloat := 99.99;

      CostPrice := (quFormVendorCost.AsCurrency + quFormOtherCost.AsCurrency +
                    quFormFreightCost.AsCurrency);

      quKitModelSellingPrice.AsFloat := DM.FDMCalcPrice.GetMarginPrice(CostPrice, quKitModelMarginPerc.AsFloat);
    end;
end;

procedure TFchModel.DBEdit2Exit(Sender: TObject);
begin
  inherited;

  if chkManualCalcPrice.Checked then
    Exit;
  
  if quForm.State in (dsEditModes) then
  begin
    quFormSuggRetail.Value := DM.FDMCalcPrice.FormatPrice(quFormSuggRetail.Value);

    if (quFormSuggRetail.NewValue <> FMSRP) then
     begin
      quFormSuggRetail.AsCurrency :=
              DM.FDMCalcPrice.FormatPrice(DM.FDMCalcPrice.CalcRounding(quFormGroupID.AsInteger, quFormSuggRetail.AsCurrency));
      FMSRP := quFormSuggRetail.AsCurrency;
     end;
  end;
end;

procedure TFchModel.grdKitModelDBMarginPerPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if Error then
  begin
    if DisplayValue < 0.01 then
      quKitModelMarginPerc.AsFloat := 1
    else
      quKitModelMarginPerc.AsFloat := 99.99;
    ErrorText := '';
  end;
end;

procedure TFchModel.EditSalePriceExit(Sender: TObject);
begin
  inherited;

  if chkManualCalcPrice.Checked then
    Exit;

  if quForm.State in (dsEditModes) then
  begin
    quFormSellingPrice.Value := DM.FDMCalcPrice.FormatPrice(quFormSellingPrice.Value);

    if (quFormSellingPrice.NewValue <> FSellingPrice) then
    begin
      quFormSellingPrice.AsCurrency :=
            DM.FDMCalcPrice.FormatPrice(DM.FDMCalcPrice.CalcRounding(quFormGroupID.AsInteger, quFormSellingPrice.AsCurrency));

      FSellingPrice := quFormSellingPrice.AsCurrency;
    end;
  end;
end;

procedure TFchModel.edtCaseCostChange(Sender: TObject);
begin
  inherited;
  if not (quForm.State in dsEditModes) then
    quForm.Edit;
end;

procedure TFchModel.btnOpenVendorListClick(Sender: TObject);
begin
  inherited;

  if cdsModelVendor.Active and (not cdsModelVendor.IsEmpty) then
    with TNewFornecedor.Create(Self) do
      if Start(cdsModelVendorIDVendor.AsInteger, cdsModelVendorIDModel.AsInteger, nil) then
      begin
        ModelVendorListRefresh;
        ModelVendorRefresh;
        VendorCodeRefresh;
      end;

end;

function TFchModel.LocateStoreQty : Integer;
begin

  if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
    Result := DM.fStore.ID
  else
  begin
    if SubQty.CurrentKey > 0 then
      Result := SubQty.CurrentKey
    else
      Result := DM.fStore.ID;
  end;

  with spquQuantity do
  begin
    if not Active then
      Open;
    First;
    while not Eof do
    begin
      if spquQuantityStoreID.Value = Result then
        Break;
      Next;
    end;
  end;
  
end;

procedure TFchModel.dbedDesireValueExit(Sender: TObject);
begin
  inherited;
  if not bUseMarkupOnCost then
    if ( (quFormMarkUp.AsFloat >= 100) or (quFormMarkUp.AsFloat < -100) ) then
    begin
      MsgBox(MSG_INF_PERCENT_NEGATIVE_POSITIVE, vbCritical + vbOKOnly);
      dbedDesireValue.SetFocus;
    end;
end;

procedure TFchModel.btnClearMaxDiscClick(Sender: TObject);
begin
  inherited;
  //Nova
  quForm.Edit;
  quForm.FieldByName('DiscountPerc').Value := Null;
end;

procedure TFchModel.ModelVendorListClose;
begin
  with cdsModelVendor do
    if Active then
      Close;
end;

procedure TFchModel.ModelVendorListOpen;
begin
  with cdsModelVendor do
    if not Active then
      CreateDataSet;
end;

procedure TFchModel.ModelVendorListRefresh;
begin
  ModelVendorListClose;
  ModelVendorListOpen;
end;

procedure TFchModel.btnQtyClick(Sender: TObject);
begin
  inherited;
  pgInventory.ActivePageIndex := 0;
end;

procedure TFchModel.btnPriceClick(Sender: TObject);
begin
  inherited;
  pgInventory.ActivePageIndex := 1;
end;

procedure TFchModel.btPriceTableClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FFrmModelPrice) then
    FFrmModelPrice := TFrmModelPrice.Create(Self);

  FFrmModelPrice.Start(quFormIDModel.AsInteger);
end;

procedure TFchModel.CheckTabVisible(ATabSheet: TTabSheet);
begin
  if not ATabSheet.TabVisible then
    ATabSheet.PageIndex := pgModel.PageCount - 1;
end;

procedure TFchModel.grdInvHoldDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  // Abre a tela do hold selecionado
  LoadInvoiceForm;
  FrmInvoice.Start(quInvHoldIDPreSale.AsInteger, SALE_PRESALE, 0, False);
end;

procedure TFchModel.SendToTrashOption;
begin
  if (frmCommand = btAlt) and (quForm.FieldByName('SendToTrash').AsBoolean) and (quForm.FieldByName('TotQtyOnHand').AsFloat <= 0) then
  begin
    quForm.Edit;
    quForm.FieldByName('Desativado').AsInteger := 1;
  end;
end;

procedure TFchModel.AutoRecalPrices;
var
  fCostPrice, NewSale, NewMSRPSale : Currency;
begin

  NewMSRPSale := 0;
  fCostPrice  := 0;
  NewSale     := 0;

  if (not chkManualCalcPrice.Checked) then
  try

    with quForm do
      if not (State in dsEditModes) then
        Edit;

      quFormDateLastCost.AsDateTime := Date();

      if (quFormMarkUp.AsFloat <> 0) then
      begin
        if bMarkUpOverCost then
          fCostPrice := quFormFinalCost.AsCurrency
        else
          if quFormAvgCost.IsNull then
            fCostPrice := quFormFinalCost.AsCurrency
          else
            fCostPrice := quFormAvgCost.AsCurrency;

        if bUseMarkupOnCost then
          NewSale := DM.FDMCalcPrice.GetMarkupPrice(fCostPrice, quFormMarkUp.AsFloat)
        else if (quFormMarkUp.AsFloat < 100) then
          NewSale := DM.FDMCalcPrice.GetMarginPrice(fCostPrice, quFormMarkUp.AsFloat);

        NewSale := DM.FDMCalcPrice.CalcRounding(quFormGroupID.AsInteger, NewSale);
       //NewSale := DM.FDMCalcPrice.CalcRounding(quFormGroupID.AsInteger, CalcMarkUp(fCostPrice, quFormMarkUp.AsFloat));

      end
      else
      begin

        fCostPrice := DM.FDMCalcPrice.FormatPrice(quFormVendorCost.AsCurrency + quFormOtherCost.AsCurrency +
                      quFormFreightCost.AsCurrency);


        NewSale     := DM.FDMCalcPrice.CalcSalePrice(quFormIDModel.AsInteger,
                                                   quFormGroupID.AsInteger,
                                                   quFormIDModelGroup.AsInteger,
                                                   quFormIDModelSubGroup.AsInteger,
                                                   fCostPrice);

        NewMSRPSale := DM.FDMCalcPrice.CalcMSRPPrice(quFormGroupID.AsInteger,
                                                   quFormIDModelGroup.AsInteger,
                                                   quFormIDModelSubGroup.AsInteger,
                                                   fCostPrice);
      end;

      if (NewSale <> fCostPrice) or (NewMSRPSale <> fCostPrice) then
        if (MsgBox(MSG_QST_CALC_SALE_PRICE, vbYesNo + vbQuestion) = vbYes) then
        begin
          if (NewSale <> 0) and (NewSale <> fCostPrice) then
          begin
            if (quFormSellingPrice.AsCurrency <> NewSale) then
            begin
              quFormDateLastSellingPrice.AsDateTime  := Now;
              quFormIDUserLastSellingPrice.AsInteger := DM.fUser.ID;
            end;

            quFormSellingPrice.AsFloat := NewSale;
          end;

          if (NewMSRPSale <> 0) and (NewMSRPSale <> fCostPrice) then
            quFormSuggRetail.AsFloat   := NewMSRPSale;
        end;

    UpdateKitPromoPrice(fCostPrice);

  finally
    bApplyMargin := False;
  end;
end;

function TFchModel.TestSizeAndColor: Boolean;
begin

  Result := True;

  if (frmCommand = btInc) then
    if (quFormModel.AsString = '') or (quFormDescription.AsString = '') or
       (quFormSellingPrice.AsCurrency = 0) or (quFormVendorCost.AsCurrency = 0) then
       begin
         MsgBox(MSG_INF_VALIDATE_SIZE_AND_COLOR, vbOKOnly + vbInformation);
         Result := False;
       end;

end;

procedure TFchModel.UpdateVendorOrder;
var
  iPos : Integer;
  bHasChange : Boolean;
begin

  ModelVendorRefresh;
  bHasChange := False;

  with quModelVendor do
  try
    DisableControls;
    iPos := 1;
    First;
    while not EOF do
    begin
      if quModelVendorVendorOrder.AsInteger <> iPos then
      begin
        Edit;
        quModelVendorVendorOrder.AsInteger := iPos;
        Post;
        bHasChange := True;
      end;
      inc(iPos);
      Next;
    end;
  finally
    if bHasChange then
      ModelVendorRefresh;
    EnableControls;
  end;
end;

procedure TFchModel.quFormSellingPriceChange(Sender: TField);
begin
  inherited;

  bHasChangePrice := (quFormSellingPrice.OldValue <> quFormSellingPrice.AsCurrency);
  bChangePrices   := True;
end;

procedure TFchModel.SavePriceChanges;
begin

  FDMInventory.ModelPriceLog(quFormIDModel.AsInteger,
                             DM.fUser.ID,
                             0,
                             cCostOld,
                             quFormFinalCost.AsCurrency,
                             cSaleOld,
                             quFormSellingPrice.AsCurrency);
end;

procedure TFchModel.scNCMSelectItem(Sender: TObject);
begin
  inherited;

  RefreshNCM;

end;

procedure TFchModel.RefreshNCM;
begin
  if (scNCM.LookUpValue <> '') then
  begin
    lbTaxInValue.Caption := FormatFloat('0.00 %', scNCM.GetFieldByName('MVAInterno'));
    lbTaxOutValue.Caption := FormatFloat('0.00 %', scNCM.GetFieldByName('MVAInterestadual'));
    if scNCM.GetFieldByName('Incide') then
      lbNCMPayTax.Caption := sPayTax
    else
      lbNCMPayTax.Caption := sNoPayTax;
  end;
end;

procedure TFchModel.StateTaxClose;
begin
  with quStateTax do
    if Active then
      Close;
end;

procedure TFchModel.StateTaxOpen;
begin
  with quStateTax do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
    end;
end;

procedure TFchModel.StateTaxRefresh;
begin
  StateTaxClose;
  StateTaxOpen;
end;

procedure TFchModel.btnAddStateTaxClick(Sender: TObject);
begin
  inherited;

  with TFrmModelStateTax.Create(Self) do
    Start(quFormIDModel.AsInteger);

  StateTaxRefresh;

end;

procedure TFchModel.btnRemoveStateTaxClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;

  if quStateTax.Active and (quStateTax.RecordCount > 0) then
  begin
    sSQL := 'DELETE Inv_ModelStateTax WHERE ' +
            'IDModel = ' + quFormIDModel.AsString +
            ' AND IDEstado = ' + QuotedStr(quStateTaxIDEstado.AsString) +
            ' AND IDTaxCategory = ' + quStateTaxIDTaxCategory.AsString;

    DM.RunSQL(sSQL);

    StateTaxRefresh;
  end;

end;

procedure TFchModel.btnAddNutritionClick(Sender: TObject);
begin
  inherited;
  
  with TFrmAddNutrition.Create(Self) do
    if Start(quFormIDModel.AsInteger) then
      ModelNutritionRefresh;

end;

procedure TFchModel.quFormUseScaleChange(Sender: TField);
begin
  inherited;
  tsNutrition.TabVisible := quFormUseScale.AsBoolean;
end;

procedure TFchModel.ModelNutritionClose;
begin

  with quNutritionList do
    if Active then
      Close;

end;

procedure TFchModel.ModelNutritionOpen;
begin

  with quNutritionList do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := quFormIDModel.AsInteger;
      Open;
    end;

end;

procedure TFchModel.ModelNutritionRefresh;
begin
  ModelNutritionClose;
  ModelNutritionOpen;
end;

procedure TFchModel.btnRemoveNutritionClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;

  sSQL := 'DELETE Inv_ModelNutrition WHERE IDModel = ' + quFormIDModel.AsString;
  DM.RunSQL(sSQL);
  ModelNutritionRefresh;

end;

procedure TFchModel.quNutritionListAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnAddNutrition.Enabled := quNutritionlist.IsEmpty;
end;

procedure TFchModel.chkUseScaleClick(Sender: TObject);
begin
  inherited;
  tsNutrition.TabVisible := chkUseScale.Checked;
end;

procedure TFchModel.chkManualCalcPriceClick(Sender: TObject);
begin
  inherited;
  btUpdate.Enabled := ( not chkManualCalcPrice.Checked );
end;

procedure TFchModel.quFormAfterScroll(DataSet: TDataSet);
begin
  inherited;
  //amfsouza 02.14.2011 - MR allows to insert model without purchase.
  edtLastPurchase.Visible := ( quForm.FieldByName('lastReceived').Value = NULL );
end;

end.
