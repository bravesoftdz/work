(*
-----------------------------------------------------------------------------------------------------
Version : (288 - 278)
Date    : 12.31.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Solution: I saw that first solution could be wrong because stored procedure sp_presale_quPreSale
          wait for idpresale parameter input. I implemented a new function to get 'IdPreSale'
          having a hold number.
Version : (288 - 279)
-----------------------------------------------------------------------------------------------------

Version : (288 - 277)
Date    : 12.13.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Details were not showed
Solution: I had to verify if sale was finalized or not.
Version : (288 - 278)
-----------------------------------------------------------------------------------------------------
*)

unit uFchPessoa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideFichaTab, ComCtrls, FormConfig, Db, DBTables,
  LblEffct, ExtCtrls, StdCtrls, Grids, DBCtrls, Mask, Variants,
  MemoStr, Buttons, uInvoice, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, DateBox, siComp, siLangRT, DBGrids, SMDBGrid, SubListPanel,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, uSystemTypes;

const
   PT_CUSTOMER    = 1;
   PT_VENDOR      = 2;
   PT_COMMISSION  = 3;
   PT_SALESPERSON = 4;
   PT_GUIDE       = 5;
   PT_AGENCY      = 6;
   PT_OTHER       = 9;
   PT_MANUFACTURE = 10;

type
  TFchPessoa = class(TbrwFrmTabParent)
    Basic: TTabSheet;
    PurchaseHistory: TTabSheet;
    lblTipoPessoa: TLabel;
    scPessoaTipo: TDBSuperComboADO;
    pnlFisico: TPanel;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    pnlJuridico: TPanel;
    Label2: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EditDBA: TDBEdit;
    EditFederalID: TDBEdit;
    EditSalesTax: TDBEdit;
    Label9: TLabel;
    Label16: TLabel;
    DBEdit12: TDBEdit;
    pnlAddress: TPanel;
    Label8: TLabel;
    Label6: TLabel;
    edtZIP: TDBEdit;
    Label7: TLabel;
    scState: TDBSuperComboADO;
    edtCity: TDBEdit;
    Label5: TLabel;
    edtAddress: TDBEdit;
    Label3: TLabel;
    EditContact: TDBEdit;
    Label20: TLabel;
    Label22: TLabel;
    EditEMail: TDBEdit;
    EditHomePage: TDBEdit;
    Label23: TLabel;
    MemoFax: TDbMemoStr;
    Label4: TLabel;
    Label45: TLabel;
    DbEditCellular: TDBEdit;
    Label46: TLabel;
    DBEditBeeper: TDBEdit;
    Label24: TLabel;
    scCountry: TDBSuperComboADO;
    InvoiceHistory: TTabSheet;
    GroupHistory: TTabSheet;
    Accounting: TTabSheet;
    dsPurchaseHistory: TDataSource;
    quFormIDPessoa: TIntegerField;
    quFormPessoa: TStringField;
    quFormIDTipoPessoa: TIntegerField;
    quFormIDStore: TIntegerField;
    quFormNomeJuridico: TStringField;
    quFormEndereco: TStringField;
    quFormCidade: TStringField;
    quFormCEP: TStringField;
    quFormPais: TStringField;
    quFormTelefone: TStringField;
    quFormCellular: TStringField;
    quFormFax: TStringField;
    quFormBeeper: TStringField;
    quFormContato: TStringField;
    quFormEmail: TStringField;
    quFormOBS: TStringField;
    quFormJuridico: TBooleanField;
    quFormTotalMovimentado: TFloatField;
    quFormLimite: TFloatField;
    quFormNascimento: TDateTimeField;
    quFormIDEstado: TStringField;
    quFormDiaQuitacao: TIntegerField;
    quFormIDPessoaBoss: TIntegerField;
    quFormIDTipoPessoaFilho: TIntegerField;
    quFormIDRamoAtividade: TIntegerField;
    quFormCPF: TStringField;
    quFormCGC: TStringField;
    quFormIdentidade: TStringField;
    quFormCartTrabalho: TStringField;
    quFormInscEstadual: TStringField;
    quFormInscMunicipal: TStringField;
    quFormContatos: TStringField;
    quFormNumAtrasos: TIntegerField;
    quFormDiasAtraso: TIntegerField;
    quFormNumTransacoes: TIntegerField;
    quFormHomePage: TStringField;
    quFormOrgaoEmissor: TStringField;
    quFormBairro: TStringField;
    quFormNumMovimentacoes: TIntegerField;
    quFormSystem: TBooleanField;
    quFormDesativado: TIntegerField;
    quFormHidden: TIntegerField;
    quFormComissaoSobreGuia: TFloatField;
    quFormDescontaCoordenacao: TBooleanField;
    quFormAjusteComiss: TFloatField;
    quFormIDUser: TIntegerField;
    quFormShortName: TStringField;
    quFormCode: TIntegerField;
    quFormIDTipoPessoaRoot: TIntegerField;
    quFormIDPais: TIntegerField;
    quGroupHistory: TADOQuery;
    dsGroupHistory: TDataSource;
    quGroupHistoryEnterDate: TDateTimeField;
    quGroupHistoryNumTourist: TIntegerField;
    quGroupHistoryAgency: TStringField;
    quGroupHistoryGuide: TStringField;
    quGroupHistoryQTYInvoice: TIntegerField;
    quGroupHistoryTotalInvoice: TFloatField;
    quGroupHistoryIDTouristGroup: TIntegerField;
    pnCommission: TPanel;
    pnGuia: TPanel;
    DBCheckBox2: TDBCheckBox;
    pnlGroupHistoryFilter: TPanel;
    Label1: TLabel;
    Label14: TLabel;
    btGHGo: TSpeedButton;
    Label21312312: TLabel;
    Label48213: TLabel;
    btPHGo: TSpeedButton;
    pnlPurchaseHistoryFilter: TPanel;
    pnlAccountingFilter: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    btAGo: TSpeedButton;
    dsAccount: TDataSource;
    dsInvoiceHistory: TDataSource;
    quFormCustomerCard: TStringField;
    pnlPersonal: TPanel;
    lblPessoa: TLabel;
    editPessoa: TDBEdit;
    Label21: TLabel;
    Label31: TLabel;
    dbEditLastName: TDBEdit;
    Label33: TLabel;
    pnlBusiness: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    dbedtCompany: TDBEdit;
    quFormPessoaFirstName: TStringField;
    tsVendorTerm: TTabSheet;
    Panel8: TPanel;
    Label13: TLabel;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    dsTerm: TDataSource;
    quTerm: TADOQuery;
    quTermIDPessoa: TIntegerField;
    quTermDueDateShift: TIntegerField;
    quTermDiscount: TBCDField;
    edtCoord: TDBEdit;
    TipoCli: TRadioGroup;
    Label12: TLabel;
    dstPurchaseHistory: TADODataSet;
    dstPurchaseHistoryIDPurchase: TIntegerField;
    dstPurchaseHistoryModel: TStringField;
    dstPurchaseHistoryCategory: TStringField;
    dstPurchaseHistoryMovDate: TDateTimeField;
    dstPurchaseHistoryCostPrice: TBCDField;
    dstPurchaseHistoryFreight: TBCDField;
    dstPurchaseHistoryOtherCost: TBCDField;
    dstPurchaseHistoryTotal: TBCDField;
    dstInvoiceHistory: TADODataSet;
    dstInvoiceHistoryInvoiceDate: TDateTimeField;
    dstInvoiceHistoryStore: TStringField;
    dstInvoiceHistoryValue: TBCDField;
    dtPHIni: TDateBox;
    dtPHFim: TDateBox;
    dtGHIni: TDateBox;
    dtGHFim: TDateBox;
    dtAIni: TDateBox;
    dtAFim: TDateBox;
    dxDBGridPH: TSMDBGrid;
    dxDBGridGH: TSMDBGrid;
    grdTerm: TSMDBGrid;
    DBDateBox1: TDBDateBox;
    Label19: TLabel;
    edtBairro: TDBEdit;
    pnlSearchZip: TPanel;
    sbSearchZip: TSpeedButton;
    tsCredit: TTabSheet;
    btAddCredit: TSpeedButton;
    btDelCredit: TSpeedButton;
    quCustomerCredits: TADOQuery;
    dsCustomerCredits: TDataSource;
    quCustomerCreditsStore: TStringField;
    quCustomerCreditsSystemUser: TStringField;
    quCustomerCreditsCreditDate: TDateTimeField;
    quCustomerCreditsExpirationDate: TDateTimeField;
    quCustomerCreditsAmount: TBCDField;
    quCustomerCreditsIDCustomerCredit: TIntegerField;
    quGetTotalCredit: TADOQuery;
    quGetTotalCreditTotalCredit: TBCDField;
    quCustomerCreditsIsUsed: TBooleanField;
    pnlPODetail: TPanel;
    Label39: TLabel;
    Label25: TLabel;
    Label43: TLabel;
    edtNotUsed: TEdit;
    edtUsed: TEdit;
    tsVendorTax: TTabSheet;
    quVendorTax: TADOQuery;
    dsVendorTax: TDataSource;
    quVendorTaxIDVendorTax: TIntegerField;
    quVendorTaxIDPessoa: TIntegerField;
    quVendorTaxIDGroup: TIntegerField;
    quVendorTaxIDTaxCategory: TIntegerField;
    lbVendorTax: TLabel;
    scVendorAddTax: TSuperComboADO;
    btnNewVendorTax: TSpeedButton;
    SMDBGrid1: TSMDBGrid;
    btnRemovTax: TSpeedButton;
    quVendorTaxTaxCategory: TStringField;
    quVendorTaxTax: TBCDField;
    quVendorTaxDebit: TBooleanField;
    tsPet: TTabSheet;
    btnDelPet: TSpeedButton;
    btnAddPet: TSpeedButton;
    quPet: TADOQuery;
    dsPet: TDataSource;
    btnOpenPet: TSpeedButton;
    quFormShort_Name: TStringField;
    spGetPessoaRoot: TADOStoredProc;
    quFormPhoneAreaCode: TStringField;
    quFormCellAreaCode: TStringField;
    edtPhoneDDD: TDBEdit;
    edtCellDDD: TDBEdit;
    lbHasAdr: TLabel;
    lbHasBairro: TLabel;
    lbHasCty: TLabel;
    lbHasStat: TLabel;
    lbHasZip: TLabel;
    lbHasPhone: TLabel;
    lbHasCPF: TLabel;
    tsModelCod: TTabSheet;
    quVendorCode: TADOQuery;
    dsVendorCode: TDataSource;
    quVendorCodeIDVendorModelCode: TIntegerField;
    quVendorCodeIDPessoa: TIntegerField;
    quVendorCodeIDModel: TIntegerField;
    quVendorCodeVendorCode: TStringField;
    quVendorCodeModel: TStringField;
    quVendorCodeDescription: TStringField;
    grdVendorCode: TSMDBGrid;
    btnDelVCode: TSpeedButton;
    pnlInfo: TPanel;
    lblCode: TLabel;
    DBEdit2: TDBEdit;
    Label27: TLabel;
    scStore: TDBSuperComboADO;
    Label41: TLabel;
    scUser: TDBSuperComboADO;
    quFormCartMotorista: TStringField;
    quFormDataExpedicao: TDateTimeField;
    pnlCPF: TPanel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBDateBox2: TDBDateBox;
    pnlOBS: TPanel;
    lbOBS: TLabel;
    memOBS: TDBMemo;
    dstPurchaseHistoryQty: TFloatField;
    tsHistory: TTabSheet;
    pnlHistoryAdd: TPanel;
    btnHistoryAdd: TSpeedButton;
    btnHistoryDelete: TSpeedButton;
    btnHistoryEdit: TSpeedButton;
    quPessoaHistory: TADODataSet;
    dsPessoaHistory: TDataSource;
    grdHistory: TcxGrid;
    grdHistoryDB: TcxGridDBTableView;
    grdHistoryLevel: TcxGridLevel;
    grdHistoryDBMovDate: TcxGridDBColumn;
    grdHistoryDBObs: TcxGridDBColumn;
    grdHistoryDBSystemUser: TcxGridDBColumn;
    grdHistoryDBPessoaHistoryType: TcxGridDBColumn;
    grdHistoryDBPessoaHistoryResult: TcxGridDBColumn;
    quPessoaHistoryIDPessoaHistory: TIntegerField;
    quPessoaHistoryIDPessoa: TIntegerField;
    quPessoaHistoryIDUser: TIntegerField;
    quPessoaHistoryIDPessoaHistoryType: TIntegerField;
    quPessoaHistoryIDPessoaHistoryResult: TIntegerField;
    quPessoaHistoryMovDate: TDateTimeField;
    quPessoaHistoryObs: TStringField;
    quPessoaHistorySystemUser: TStringField;
    quPessoaHistoryPessoaHistoryType: TStringField;
    quPessoaHistoryPessoaHistoryResult: TStringField;
    quFormCreationDate: TDateTimeField;
    quFormSalesTaxExempt: TBooleanField;
    chkExempSaleTax: TDBCheckBox;
    tsAddress: TTabSheet;
    Panel5: TPanel;
    btAddAddress: TSpeedButton;
    btRemoveAddress: TSpeedButton;
    btDetailAddress: TSpeedButton;
    grdAddress: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsAddress: TDataSource;
    cxGridDBTableViewIDPessoaAddress: TcxGridDBColumn;
    cxGridDBTableViewIDPessoa: TcxGridDBColumn;
    cxGridDBTableViewName: TcxGridDBColumn;
    cxGridDBTableViewAddress: TcxGridDBColumn;
    cxGridDBTableViewCity: TcxGridDBColumn;
    cxGridDBTableViewZIP: TcxGridDBColumn;
    cxGridDBTableViewIDTaxCategory: TcxGridDBColumn;
    cxGridDBTableViewIDPais: TcxGridDBColumn;
    cxGridDBTableViewIDEstado: TcxGridDBColumn;
    cxGridDBTableViewSystem: TcxGridDBColumn;
    cxGridDBTableViewHidden: TcxGridDBColumn;
    cxGridDBTableViewDesativado: TcxGridDBColumn;
    quAddress: TPowerADOQuery;
    quAddressIDPessoaAddress: TIntegerField;
    quAddressIDPessoa: TIntegerField;
    quAddressName: TStringField;
    quAddressAddress: TStringField;
    quAddressCity: TStringField;
    quAddressZIP: TStringField;
    quAddressIDTaxCategory: TIntegerField;
    quAddressIDPais: TIntegerField;
    quAddressIDEstado: TStringField;
    quAddressSystem: TBooleanField;
    quAddressHidden: TBooleanField;
    quAddressDesativado: TBooleanField;
    quAddressIsBillTo: TBooleanField;
    cxGridDBTableViewIsBillTo: TcxGridDBColumn;
    quAddressPais: TStringField;
    quAddressEstado: TStringField;
    cxGridDBTableViewCountry: TcxGridDBColumn;
    cxGridDBTableViewState: TcxGridDBColumn;
    grdPetDBTableView: TcxGridDBTableView;
    grdPetLevel: TcxGridLevel;
    grdPet: TcxGrid;
    grdPetDBTableViewIDPet: TcxGridDBColumn;
    grdPetDBTableViewName: TcxGridDBColumn;
    grdPetDBTableViewSex: TcxGridDBColumn;
    grdPetDBTableViewPorte: TcxGridDBColumn;
    grdPetDBTableViewBreed: TcxGridDBColumn;
    grdPetDBTableViewSpecies: TcxGridDBColumn;
    quPetIDPet: TIntegerField;
    quPetName: TStringField;
    quPetSex: TStringField;
    quPetPorte: TStringField;
    quPetSpecies: TStringField;
    grdStoreCreditDBTableView: TcxGridDBTableView;
    grdStoreCreditLevel: TcxGridLevel;
    grdStoreCredit: TcxGrid;
    grdStoreCreditDBTableViewIDCustomerCredit: TcxGridDBColumn;
    grdStoreCreditDBTableViewStore: TcxGridDBColumn;
    grdStoreCreditDBTableViewSystemUser: TcxGridDBColumn;
    grdStoreCreditDBTableViewCreditDate: TcxGridDBColumn;
    grdStoreCreditDBTableViewExpirationDate: TcxGridDBColumn;
    grdStoreCreditDBTableViewAmount: TcxGridDBColumn;
    grdStoreCreditDBTableViewIsUsed: TcxGridDBColumn;
    quPetBreed: TStringField;
    quAccount: TADOQuery;
    quAccountIDLancamento: TIntegerField;
    quAccountDataVencimento: TDateTimeField;
    quAccountLancamentoTipo: TStringField;
    quAccountDataFimQuitacao: TDateTimeField;
    quAccountValorNominal: TFloatField;
    quAccountTotalQuitado: TFloatField;
    quAccountPagando: TBooleanField;
    quAccountHistorico: TMemoField;
    grdAccountDBTableView: TcxGridDBTableView;
    grdAccountLevel: TcxGridLevel;
    grdAccount: TcxGrid;
    grdAccountDBTableViewIDLancamento: TcxGridDBColumn;
    grdAccountDBTableViewDataVencimento: TcxGridDBColumn;
    grdAccountDBTableViewLancamentoTipo: TcxGridDBColumn;
    grdAccountDBTableViewDataFimQuitacao: TcxGridDBColumn;
    grdAccountDBTableViewValorNominal: TcxGridDBColumn;
    grdAccountDBTableViewTotalQuitado: TcxGridDBColumn;
    grdAccountDBTableViewPagando: TcxGridDBColumn;
    grdAccountDBTableViewHistorico: TcxGridDBColumn;
    quAddressNeighborhood: TStringField;
    quAddressCompanyReg: TStringField;
    cxGridDBTableViewNeighborhood: TcxGridDBColumn;
    cxGridDBTableViewCompanyReg: TcxGridDBColumn;
    quFormPessoaLastName: TStringField;
    lbHasCountry: TLabel;
    lbHasCel: TLabel;
    lbHasEmail: TLabel;
    lbHasBeeper: TLabel;
    lbHasFax: TLabel;
    lbHasHomePage: TLabel;
    lnHasIdent: TLabel;
    lbHasBirth: TLabel;
    lbDriversLinc: TLabel;
    lbHasNomeJur: TLabel;
    lbHasContact: TLabel;
    lbHasIncEst: TLabel;
    lnHasInscMun: TLabel;
    quGroupHistoryIDPreSale: TIntegerField;
    quPetWhelpDate: TDateTimeField;
    grdPetDBTableViewWhelpDate: TcxGridDBColumn;
    lbOCMin: TLabel;
    DBEdit5: TDBEdit;
    lbProfession: TLabel;
    scProfession: TDBSuperComboADO;
    quFormSexo: TBooleanField;
    lbSex: TLabel;
    rgGender: TRadioGroup;
    quAccountIDPessoa: TIntegerField;
    quFormComplemento: TStringField;
    quFormComplementoNum: TIntegerField;
    quFormIDMunicipio: TIntegerField;
    edtNumero: TDBEdit;
    edtComplement: TDBEdit;
    lbMunicipio: TLabel;
    scMunicipio: TDBSuperComboADO;
    tsStoreAccount: TTabSheet;
    quFormStoreAccountLimit: TBCDField;
    quFormNonpayer: TBooleanField;
    chkDeliquent: TDBCheckBox;
    lbStoreAccountLimit: TLabel;
    DBEdit6: TDBEdit;
    cmdStoreAccLog: TADOCommand;
    quFormUserCode: TStringField;
    pgSale: TPageControl;
    tsInvoice: TTabSheet;
    tsInvoiceItens: TTabSheet;
    dxDBGrid2: TSMDBGrid;
    pnlInvoiceHsitoryFilter: TPanel;
    Label26: TLabel;
    Label28: TLabel;
    btIHGo: TSpeedButton;
    dtIHIni: TDateBox;
    dtIHFim: TDateBox;
    dstInvoiceItem: TADODataSet;
    dsInvoiceItem: TDataSource;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    dstInvoiceItemInvoiceDate: TDateTimeField;
    dstInvoiceItemQty: TBCDField;
    dstInvoiceItemDiscount: TBCDField;
    dstInvoiceItemSalePrice: TBCDField;
    dstInvoiceItemModel: TStringField;
    dstInvoiceItemDescription: TStringField;
    dstInvoiceItemCategory: TStringField;
    grdBrowseDBInvoiceDate: TcxGridDBColumn;
    grdBrowseDBQty: TcxGridDBColumn;
    grdBrowseDBDiscount: TcxGridDBColumn;
    grdBrowseDBSalePrice: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBCategory: TcxGridDBColumn;
    dstInvoiceHistoryHold: TStringField;
    dstInvoiceHistoryIDInvoice: TStringField;
    Panelm6: TPanel;
    btGroup: TSpeedButton;
    btExcel: TSpeedButton;
    lbHasCodMunicipio: TLabel;
    lbHasCustCard: TLabel;
    edtCustomerCard: TDBEdit;
    Label32: TLabel;
    edtPhone: TDBEdit;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btPHGoClick(Sender: TObject);
    procedure btGHGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAGoClick(Sender: TObject);
    procedure btIHGoClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdTermKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure quTermNewRecord(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure dsTermStateChange(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure TipoCliClick(Sender: TObject);
    procedure quTermAfterEdit(DataSet: TDataSet);
    procedure dxDBGrid2DblClick(Sender: TObject);
    procedure sbSearchZipClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btDelCreditClick(Sender: TObject);
    procedure btAddCreditClick(Sender: TObject);
    procedure btnNewVendorTaxClick(Sender: TObject);
    procedure btnRemovTaxClick(Sender: TObject);
    procedure dsVendorTaxStateChange(Sender: TObject);
    procedure btnAddPetClick(Sender: TObject);
    procedure btnDelPetClick(Sender: TObject);
    procedure dsPetStateChange(Sender: TObject);
    procedure DBEdit12Exit(Sender: TObject);
    procedure EditFederalIDExit(Sender: TObject);
    procedure btnDelVCodeClick(Sender: TObject);
    procedure dsVendorCodeStateChange(Sender: TObject);
    procedure btnHistoryAddClick(Sender: TObject);
    procedure btnHistoryEditClick(Sender: TObject);
    procedure btnHistoryDeleteClick(Sender: TObject);
    procedure btAddAddressClick(Sender: TObject);
    procedure btRemoveAddressClick(Sender: TObject);
    procedure btDetailAddressClick(Sender: TObject);
    procedure dsAddressDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure scPessoaTipoSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxDBGridGHDblClick(Sender: TObject);
    procedure EditFederalIDKeyPress(Sender: TObject; var Key: Char);
    procedure rgGenderEnter(Sender: TObject);
    procedure DBEdit6Change(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure edtPhoneDDDExit(Sender: TObject);
    procedure edtPhoneExit(Sender: TObject);
    procedure edtCellDDDExit(Sender: TObject);
    procedure DbEditCellularExit(Sender: TObject);
    procedure EditEMailExit(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    FrmInvoice : TFrmInvoice;
    IsAgency, IsCommission, IsManufMant : Boolean;
    sIDTipoPessoa : string;
    LEntiryFilters : TStringList;
    sAddress : String;
    bAlterStoreAccLimit : Boolean;

    procedure SetHelpContext;

    procedure LoadInvoiceForm;
    procedure OnBeforePrepare;
    procedure RefreshTipoPessoa;
    procedure RefreshJurFis;
    procedure ValidateFileds;
    procedure DisplayClientFields;

    // Term
    procedure VendorTermRefresh;
    procedure VendorTermPost;
    procedure VendorTermCancel;
    procedure VendorTermOpen;
    procedure VendorTermClose;

    //Acount
    procedure AccountOpen;
    procedure AccountClose;
    procedure AccountRefresh;

    //InvoiceHist
    procedure InvoiceHistOpen;
    procedure InvoiceHistClose;
    procedure InvoiceHistRefresh;

    //InvoiceItem
    procedure InvoiceItemOpen;
    procedure InvoiceItemClose;
    procedure InvoiceItemRefresh;

    //PurchaseHist
    procedure PurchaseHistOpen;
    procedure PurchaseHistClose;
    procedure PurchaseHistRefresh;

    //GroupHist
    procedure GroupHistOpen;
    procedure GroupHistClose;
    procedure GroupHistRefresh;

    //Store Credit
    procedure CreditOpen;
    procedure CreditClose;
    procedure CreditRefresh;
    procedure CreditGetTotal;

    //Vendor Tax
    procedure VendorTaxOpen;
    procedure VendorTaxClose;
    procedure VendorTaxRefresh;
    procedure VendorTaxPos;

    //Pet
    procedure PetOpen;
    procedure PetClose;
    procedure PetRefresh;

    //Model Code
    procedure ModelCodeOpen;
    procedure ModelCodeClose;
    procedure ModelCodeRefresh;

    //History
    procedure PessoaHistoryRefresh;
    procedure PessoaHistoryClose;
    procedure PessoaHistoryOpen;
    procedure PessoaHistoryDelete;

    //Customer Address
    procedure AddressRefresh;
    procedure AddressOpen;
    procedure AddressClose;
    procedure AddressDelete;

    function DocAlreadyExists(sDoc: string; IDPessoa, iDocType: Integer): Boolean;
    procedure OpenAddressForm(btKind: TBtnCommandType);

    procedure LoadUserType(AIDTipoUsuario : Integer);
    procedure LoadUserSetting(APersonal : Boolean);
    procedure SetRequiredField(AFieldName : String; ARequired : Boolean; ALabel : TLabel);

    //Astore Accront
    procedure SaveStoreAccLog;

    // Validations
    function ValidateObligatoryFields(): boolean;
    procedure ValidatePhoneAreaCode(areaCode: string);
    procedure ValidateCellAreaCode(areaCode: string);
    procedure ValidateCelPhone(number: string);
    procedure ValidatePhone(number: string);
    procedure ValidateEmail(email: string);
    procedure ValidateAddress(addr: string);
    procedure ValidateCity(city: string);
    procedure ValidateState(state: string);
    procedure ValidateZipCode(zip: string);
    procedure ValidateSaleTax(saleTax: double);

    function GetOnlyNumbers(alphaNumber: string): string;

  protected
    strFieldPessoa : String;
    sPessoaPath : String;
    PessoaTipo: Integer;
    function OnValidadeField: Boolean; override;
    procedure NextAppend; override;
    procedure OnAfterUpdateNavegator; override;

  end;

implementation

uses uDM, uMsgBox, XBase, uPassword, PaiDeBrowses, uParamFunctions,
     uDateTimeFunctions, uDMGlobal, uSystemConst, PaiDeTodos, uFrmZipSearch,
     PaiDeFichas, uCharFunctions, uFrmCustomerAddCredit, uFchPet,
     uValidaDocs, uMsgConstant, uFrmPessoaHistory, uFchPessoaAddress,
     MaskUtils, uFrmExport, uStringFunctions;

{$R *.DFM}


procedure TFchPessoa.LoadInvoiceForm;
begin
  if FrmInvoice = nil then
    FrmInvoice := TFrmInvoice.Create(Self);
end;

procedure TFchPessoa.ValidateFileds;
begin

  //Valida os campos
  quFormPessoaFirstName.Required := False;
  quFormPessoaLastName.Required  := False;
  quFormPessoa.Required          := False;

  Case TipoCli.ItemIndex of
     0 : begin
         quFormPessoaFirstName.Required := True;
         quFormPessoaLastName.Required  := True;
         end;

     1 : quFormPessoa.Required := True;
  end;

  LoadUserSetting(TipoCli.ItemIndex = 0);

end;

procedure TFchPessoa.GroupHistOpen;
begin

  With quGroupHistory do
      If not Active then
         begin
         If PessoaTipo = PT_AGENCY then
            begin
            Parameters.ParambyName('IDAgency').Value := quFormIDPessoa.AsInteger;
            Parameters.ParambyName('IDGuide').Value := Null;
           end
         else If PessoaTipo = PT_GUIDE then
            begin
            Parameters.ParambyName('IDAgency').Value := Null;
            Parameters.ParambyName('IDGuide').Value := quFormIDPessoa.AsInteger;
            end;
          Parameters.ParambyName('DataIni').Value := dtGHIni.Date;
          Parameters.ParambyName('DataFim').Value := dtGHFim.Date;
          Open;
          end;
end;

procedure TFchPessoa.GroupHistClose;
begin
    with quGroupHistory do
       if Active then
          Close;
end;

procedure TFchPessoa.GroupHistRefresh;
begin

   GroupHistClose;
   GroupHistOpen;

end;

procedure TFchPessoa.PurchaseHistOpen;
begin

  With dstPurchaseHistory do
      If not Active then
         begin
         Parameters.ParambyName('IDTipoPessoa').Value := quFormIDPessoa.AsInteger;
         Parameters.ParambyName('DataInicio').Value   := dtPHIni.Date;
         Parameters.ParambyName('DataFim').Value      := dtPHFim.Date;
         Open;
         end;

end;

procedure TFchPessoa.PurchaseHistClose;
begin

  with dstPurchaseHistory do
    if Active then
       Close;

end;

procedure TFchPessoa.PurchaseHistRefresh;
begin

  PurchaseHistClose;
  PurchaseHistOpen;

end;



procedure TFchPessoa.InvoiceHistOpen;
var
 sSQL,
 sWhere : String;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
  begin
    sWhere :=
      'WHERE'
      +'  I.PreSaleDate >= :DataIni '
      +'  AND'
      +'  I.PreSaleDate < :DataFim '
      +'  AND'
      +'  I.IDCustomer = :IDPessoa ';
  end
  else
  begin
    sWhere :=
      'WHERE'
      +'  I.InvoiceDate >= :DataIni '
      +'  AND'
      +'  I.InvoiceDate < :DataFim '
      +'  AND'
      +'  I.IDCustomer = :IDPessoa ';
  end;

  sSQL :=
     'SELECT'
    +'    I.SaleCode as Hold, '
    +'    I.InvoiceCode as IDInvoice, '
    +'    IsNull(I.InvoiceDate, I.PreSaleDate) as InvoiceDate, '
    +'    S.Name as Store, '
    +'    (I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax) as Value '
    +'FROM '
    +'    Invoice I (NOLOCK) '
    +'    JOIN Store S (NOLOCK) ON (I.IDStore = S.IDStore) '
    + sWhere
    +'ORDER BY '
    +'   I.InvoiceDate DESC ';

  with dstInvoiceHistory do
    if not Active then
    begin
      dstInvoiceHistory.CommandText := sSQL;
      Parameters.ParambyName('IDPessoa').Value := quFormIDPessoa.AsInteger;
      Parameters.ParambyName('DataIni').Value  := dtIHIni.Date;
      Parameters.ParambyName('DataFim').Value  := dtIHFim.Date + 1;
      Open;
    end;

end;

procedure TFchPessoa.InvoiceHistClose;
begin
   with dstInvoiceHistory do
      if Active then
        Close;
end;


procedure TFchPessoa.InvoiceHistRefresh;
begin

  InvoiceHistClose;
  InvoiceHistOpen;

end;


procedure TFchPessoa.AccountRefresh;
begin

  AccountClose;
  AccountOpen;

end;

procedure TFchPessoa.AccountOpen;
begin
  with quAccount do
      if not Active then
         begin
         Parameters.ParambyName('IDPessoa').Value := quFormIDPessoa.AsInteger;
         Parameters.ParambyName('Inicio').Value   := dtAIni.Date;
         Parameters.ParambyName('Fim').Value      := dtAFim.Date;
         Open;
         end;

end;

procedure TFchPessoa.AccountClose;
begin

  with quAccount do
     if Active then
        Close;

end;


procedure TFchPessoa.VendorTermRefresh;
var
  iDueDateShift: integer;
begin
  iDueDateShift := quTermDueDateShift.AsInteger;
  VendorTermClose;
  VendorTermOpen;
  quTerm.Locate('DueDateShift', IntToStr(iDueDateShift), [] );
end;

procedure TFchPessoa.VendorTermOpen;
begin

  with quTerm do
    if not Active then
      begin
      Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
      Open;
      end;

end;

procedure TFchPessoa.VendorTermClose;
begin

  VendorTermPost;

  quTerm.Close;

end;


procedure TFchPessoa.VendorTermPost;
begin

  with quTerm do
    if State in dsEditModes then
      Post;

end;

procedure TFchPessoa.VendorTermCancel;
begin

  with quTerm do
    if State in dsEditModes then
      Cancel;
end;


procedure TFchPessoa.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;

  quFormIDStore.asInteger        := DM.fStore.ID;
  quFormIDUser.asInteger         := DM.fUser.ID;
  quFormCreationDate.AsDateTime  := Now;
  quFormSalesTaxExempt.AsBoolean := False;
  quFormNonpayer.AsBoolean       := False;

  sIDTipoPessoa := ParseParam(Self.sParam, 'IDTipoPessoa');
  If sIDTipoPessoa <> '' then
     quFormIDTipoPessoa.AsString := sIDTipoPessoa;

  //Commission
  If IsCommission then
     begin
     quFormDescontaCoordenacao.AsBoolean := False;
     if IsAgency then
        quFormComissaoSobreGuia.Value := 0;
     end;
     
end;

procedure TFchPessoa.RefreshJurFis;
begin
  inherited;

  ValidateFileds;

  case TipoCli.ItemIndex of
       0 : begin
              // Cliente fisico
              pnlOBS.Visible        := False;
              pnlJuridico.Visible   := False;
              pnlFisico.Visible     := True;
              pnlBusiness.Visible   := False;
              pnlPersonal.Visible   := True;
              pnlOBS.Visible        := True;
           end;
       1 : begin
              // Cliente juridico
              pnlOBS.Visible        := False;
              pnlJuridico.Visible   := True;
              pnlFisico.Visible     := False;
              pnlBusiness.Visible   := True;
              pnlPersonal.Visible   := False;
              pnlOBS.Visible        := True;
           end;
  end;

end;

procedure TFchPessoa.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  RefreshTipoPessoa;
  bAlterStoreAccLimit := False;

  // mask to phone
  TStringField(Dataset.FieldByName('PhoneAreaCode')).EditMask := '(###)';
  TStringField(Dataset.FieldByName('PhoneAreaCode')).DisplayLabel := '(###)';

  TStringField(Dataset.FieldByName('Telefone')).EditMask := '###-####';
  TStringField(Dataset.FieldByName('Telefone')).DisplayLabel := '###-####';

  // mas to cell phone
  TStringField(Dataset.FieldByName('CellAreaCode')).EditMask := '(###)';
  TStringField(Dataset.FieldByName('CellAreaCode')).DisplayLabel := '(###)';

  TStringField(Dataset.FieldByName('Cellular')).EditMask := '###-####';
  TStringField(Dataset.FieldByName('Cellular')).DisplayLabel := '###-####';

end;

procedure TFchPessoa.RefreshTipoPessoa;
var
  Path, s: String;
begin
  inherited;
  // Descubro qual o tipo da pessoa e guardo em uma variavel
  if quFormIDTipoPessoa.AsString = '' then
    exit;

  Path := DM.DescCodigo(['IDTipoPessoa'], [quFormIDTipoPessoa.AsString],
                         'TipoPessoa', 'Path');
  //Verifico se e agencia, commission, Fornecedor
  IsAgency     := (LeftStr(Path, 8) = '.003.003');
  IsCommission := (LeftStr(Path, 4) = '.003');
  IsManufMant  := (LeftStr(Path, 4) = '.004');

  //Copio o tipo das commisson
  s := Copy(Path,1,8);
     If ((s = '.003.001') or (s = '.003.002'))
     or ((s = '.003.003') or (s = '.003.004')) then
        scPessoaTipo.SpcWhereClause := 'Path LIKE ' + #39 + LeftStr(Path, 8) + '%' + #39
     else
        scPessoaTipo.SpcWhereClause := 'Path LIKE ' + #39 + LeftStr(Path, 4) + '%' + #39;

  //Estes tabs sempre ficam visiveis
  Basic.TabVisible      := True;
  Accounting.TabVisible := True;


  //Set os Tabs invible
  tsVendorTerm.TabVisible    := False;
  InvoiceHistory.TabVisible  := False;
  PurchaseHistory.TabVisible := False;
  GroupHistory.TabVisible    := False;
  tsCredit.TabVisible        := False;
  tsStoreAccount.TabVisible  := False;
  tsVendorTax.TabVisible     := False;
  tsModelCod.TabVisible      := False;
  tsPet.TabVisible           := False;
  chkExempSaleTax.Visible    := False;
  tsAddress.TabVisible       := False;

  pnCommission.Visible  := False;
  pnGuia.Visible        := False;

  if quFormSexo.IsNull then
    rgGender.ItemIndex := -1
  else if quFormSexo.AsBoolean then
    rgGender.ItemIndex := 0
  else
    rgGender.ItemIndex := 1;

  //Exbir as Tabs
  if  LeftStr(Path, 4) = '.001' then
    begin
      PessoaTipo                 := PT_CUSTOMER;
      sPessoaPath                := '.001';
      lblTipoPessoa.Caption      := 'Customer Type :';
      InvoiceHistory.TabVisible  := True;
      tsPet.TabVisible           := DM.fSystem.SrvParam[PARAM_PETSHOP_OPTIONS];
      tsCredit.TabVisible        := True;
      tsStoreAccount.TabVisible  := True;
      chkExempSaleTax.Visible    := True;
      tsAddress.TabVisible       := True;
      if frmCommand = btInc then
         TipoCli.ItemIndex       := 0
      else
         TipoCli.ItemIndex       := Integer(quForm.Active and quFormJuridico.AsBoolean);

      if Length(Path) = 4 then
         DisplayClientFields;

      if DMGlobal.IDLanguage = LANG_ENGLISH then
      begin
        Label10.Visible := False;
        DBEdit9.Visible := False;
      end;
    end
  else if LeftStr(Path, 4) = '.002' then
    begin
      PessoaTipo                 := PT_VENDOR;
      sPessoaPath                := '.002';
      lblTipoPessoa.Caption      := 'Vendor Type :';
      PurchaseHistory.TabVisible := True;
      tsVendorTerm.TabVisible    := True;
      tsVendorTax.TabVisible     := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
      tsModelCod.TabVisible      := True;
      TipoCli.ItemIndex          := 1;
    end
  else if (LeftStr(Path, 4) = '.003') and
        (length(Path) = 4) then
    begin
      PessoaTipo        := PT_COMMISSION;
      sPessoaPath       := '.003';
      TipoCli.ItemIndex := 0;
    end
  else if LeftStr(Path, 4) = '.004' then
    begin
      PessoaTipo        := PT_MANUFACTURE;
      sPessoaPath       := '.004';
      TipoCli.ItemIndex := 1;
    end
  else if LeftStr(Path, 8) = '.003.001' then
    begin
      PessoaTipo        := PT_SALESPERSON;
      sPessoaPath       := '.003.001';
      TipoCli.ItemIndex := 0;
    end
  else if LeftStr(Path, 8) = '.003.002' then
    begin
      PessoaTipo := PT_GUIDE;
      sPessoaPath                := '.003.002';
      pnGuia.Visible             := True;
      GroupHistory.TabVisible    := True;
      //dxDBGridGHGuide.Visible    := False;
      //dxDBGridGHAgency.Visible   := True;
      TipoCli.ItemIndex          := 0;
    end
  else if LeftStr(Path, 8) = '.003.003' then
    begin
      PessoaTipo                 := PT_AGENCY;
      sPessoaPath                := '.003.003';
      pnCommission.Visible       := True;
      GroupHistory.TabVisible    := True;
      //dxDBGridGHGuide.Visible    := True;
      //dxDBGridGHAgency.Visible   := False;
      TipoCli.ItemIndex          := 1;
    end
  else if LeftStr(Path, 8) = '.003.004' then
    begin
      sPessoaPath       := '.003.004';
      PessoaTipo        := PT_OTHER;
      TipoCli.ItemIndex := 0;
    end;

end;

procedure TFchPessoa.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  //Devido a um bug do componentete tenho que colocar o valor nulo antes
  //de abrir a query, se nao ele traz o valor anterior do campo - Rodrigo
  scPessoaTipo.SpcWhereClause := '';
  PurchaseHistClose;
  InvoiceHistClose;
  InvoiceItemClose;
  GroupHistClose;
  AccountClose;
  VendorTermClose;
  CreditClose;
end;

procedure TFchPessoa.btPHGoClick(Sender: TObject);
begin
  inherited;

  If not ValidTwoDates(dtPHIni.Text, dtPHFim.Text) then
     Exit;

  Screen.Cursor := crHourGlass;

  PurchaseHistRefresh;

  Screen.Cursor := crDefault;

end;

procedure TFchPessoa.btGHGoClick(Sender: TObject);
begin
  inherited;
  If not ValidTwoDates(dtGHIni.Text, dtGHFim.Text) then
     Exit;

  Screen.Cursor := crHourGlass;

  GroupHistRefresh;

  Screen.Cursor := crDefault;

end;

procedure TFchPessoa.OnBeforePrepare;
begin

end;

procedure TFchPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  // Seta as datas default para os filtros
  dtPHIni.Date := FirstDateMonth;
  dtPHFim.Date := LastDateMonth;

  dtIHIni.Date := FirstDateMonth;
  dtIHFim.Date := LastDateMonth;

  dtGHIni.Date := FirstDateMonth;
  dtGHFim.Date := LastDateMonth;

  dtAIni.Date  := FirstDateMonth;
  dtAFim.Date  := LastDateMonth;

  btAddCredit.Visible := Password.HasFuncRight(48);
  btDelCredit.Visible := btAddCredit.Visible;

  if fIsRestricForm then
     begin
     btNew.Visible           := False;
     btDelete.Visible        := False;
     btPost.Visible          := False;
     btCancelPost.Visible    := False;
     btAddCredit.Visible     := False;
     btDelCredit.Visible     := False;
     btnNewVendorTax.Visible := False;
     btnRemovTax.Visible     := False;
     end;

  pnlSearchZip.Visible := (DM.fSystem.SrvParam[PARAM_CONSULTA_ZIPCODE]<>'');
  pnlCPF.Visible       := (DMGlobal.IDLanguage = LANG_PORTUGUESE);
  DBEdit9.Visible      := not pnlCPF.Visible;

  DM.imgSmall.GetBitmap(BTN18_NEW, btnHistoryAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnHistoryEdit.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnHistoryDelete.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);

  LEntiryFilters := TStringList.Create;

  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) then
  begin
    edtAddress.Width      := 309;
    edtNumero.Visible     := True;
    edtComplement.Visible := True;
    lbMunicipio.Visible   := True;
    scMunicipio.Visible   := True;
  end
  else
  begin
    edtAddress.Width      := 442;
    edtNumero.Visible     := False;
    edtComplement.Visible := False;
    lbMunicipio.Visible   := False;
    scMunicipio.Visible   := False;
  end;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sAddress := 'Address :';
    end;

    LANG_PORTUGUESE:
    begin
      sAddress := 'Endereço/Nº/Compl. :';
    end;

    LANG_SPANISH:
    begin
      sAddress := 'Dirección :';
    end;
  end;


end;

procedure TFchPessoa.btAGoClick(Sender: TObject);
begin
  inherited;

  If not ValidTwoDates(dtAIni.Text, dtAFim.Text) then
     Exit;

  Screen.Cursor := crHourGlass;

  AccountRefresh;

  Screen.Cursor := crDefault;

end;

procedure TFchPessoa.btIHGoClick(Sender: TObject);
begin
  inherited;

  If not ValidTwoDates(dtIHIni.Text, dtIHFim.Text) then
     Exit;

  Screen.Cursor := crHourGlass;

  InvoiceHistRefresh;
  InvoiceItemRefresh;

  Screen.Cursor := crDefault;

end;

procedure TFchPessoa.spHelpClick(Sender: TObject);
begin

  SetHelpContext;
  inherited;

end;

procedure TFchPessoa.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) {and (grdTerm.FocusedField = quTermDiscount)} then
    btPostClick(nil);

end;

procedure TFchPessoa.btNewClick(Sender: TObject);
begin
  inherited;

  quTerm.Insert;
  if grdTerm.CanFocus then
     grdTerm.SetFocus;
  //grdTerm.FocusedField := quTermDueDateShift;
  quTermDueDateShift.FocusControl;

end;

procedure TFchPessoa.btDeleteClick(Sender: TObject);
begin
  inherited;

  quTerm.Delete;
  dsTermStateChange(Nil);
  
end;

procedure TFchPessoa.btPostClick(Sender: TObject);
begin
  inherited;

  VendorTermPost;
  VendorTermRefresh;

end;

procedure TFchPessoa.btCancelPostClick(Sender: TObject);
begin
  inherited;

  VendorTermCancel;

end;

procedure TFchPessoa.quTermNewRecord(DataSet: TDataSet);
begin
  inherited;

  quTermIDPessoa.AsInteger := quFormIDPessoa.AsInteger;
  quTermDiscount.AsInteger := 0;

end;

procedure TFchPessoa.PageControlChange(Sender: TObject);
begin
  inherited;

  if PageControl.ActivePage = tsVendorTerm then
    VendorTermOpen
  else if PageControl.ActivePage = tsCredit then
    CreditRefresh
  else if PageControl.ActivePage = tsVendorTax then
    VendorTaxRefresh
  else if PageControl.ActivePage = tsPet then
    PetRefresh
  else if PageControl.ActivePage = tsModelCod then
    ModelCodeRefresh
  else if PageControl.ActivePage = tsHistory then
    PessoaHistoryRefresh
  else if PageControl.ActivePage = tsAddress then
    AddressRefresh;

end;

procedure TFchPessoa.dsTermStateChange(Sender: TObject);
begin
  inherited;

  if fIsRestricForm then
     Exit;

  btNew.Enabled := quTerm.Active;

  with quTerm do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quTerm.State in dsEditModes);
  btDelete.Visible := not (quTerm.State in dsEditModes);

  btPost.Visible := (quTerm.State in dsEditModes);
  btCancelPost.Visible := (quTerm.State in dsEditModes);
  
end;

procedure TFchPessoa.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;

  if TipoCli.ItemIndex = 0 then
     quFormJuridico.AsBoolean := False
  else
     quFormJuridico.AsBoolean := True;

  if rgGender.ItemIndex = 0 then
    quFormSexo.AsBoolean := True
  else
    quFormSexo.AsBoolean := False;

  if TipoCli.ItemIndex = 0 then
     if (Trim(quFormPessoaLastName.AsString) <> '') and
        (Trim(quFormPessoaFirstName.AsString) <> '') then
        if DMGlobal.IDLanguage = LANG_ENGLISH then
           quFormPessoa.AsString := Trim(quFormPessoaLastName.AsString) +
                                    ', ' + Trim(quFormPessoaFirstName.AsString)
        else
           quFormPessoa.AsString := Trim(quFormPessoaFirstName.AsString) +
                                    ' ' + Trim(quFormPessoaLastName.AsString);

  if bAlterStoreAccLimit then
    SaveStoreAccLog;

end;

procedure TFchPessoa.TipoCliClick(Sender: TObject);
begin
  inherited;

  RefreshJurFis;

end;

procedure TFchPessoa.quTermAfterEdit(DataSet: TDataSet);
begin
  inherited;

  quForm.Edit;

end;

procedure TFchPessoa.dxDBGrid2DblClick(Sender: TObject);
var
   idPreSale: Integer;
begin
  inherited;
  // Abre a tela do hold selecionado
  if (dstInvoiceHistory.Active) and not dstInvoiceHistory.IsEmpty then
    begin
      LoadInvoiceForm;

      //amfsouza 12.31.2010 - to get IdPresale by hold number
      idPreSale := dm.getIdPreSale(dstInvoiceHistoryHold.AsInteger);
      FrmInvoice.Start(idPreSale, SALE_INVOICE, 0, False);
    end;
end;

procedure TFchPessoa.sbSearchZipClick(Sender: TObject);
var
 sResult : String;
begin
  inherited;

  with TFrmZipSearch.Create(Self) do
       sResult := Start;

  if sResult <> '' then
     begin
     quForm.Edit;
     quFormEndereco.AsString := ParseParam(sResult, FIELD_TITULO)    + ' ' +
                                ParseParam(sResult, FIELD_LOGRADOURO)+ ' ' +
                                ParseParam(sResult, FIELD_COMPLEMENTO);
     quFormBairro.AsString   := ParseParam(sResult, FIELD_BAIRRO);
     quFormCidade.AsString   := ParseParam(sResult, FIELD_LOCALIDADE);
     quFormIDEstado.AsString := ParseParam(sResult, FIELD_IDESTADO);
     quFormCEP.AsString      := ParseParam(sResult, FIELD_ZIPCODE);
     edtAddress.SetFocus;
     edtAddress.SelStart := Length(quFormEndereco.AsString);
     end;

end;

procedure TFchPessoa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2 : begin
            if pnlSearchZip.Visible then
               sbSearchZipClick(sbSearchZip);
            end;
  end;
end;

procedure TFchPessoa.CreditClose;
begin

  with quCustomerCredits do
    if Active then
       Close;

end;

procedure TFchPessoa.CreditOpen;
begin

  with quCustomerCredits do
    if not Active then
      begin
      Parameters.ParamByName('IDCustomer').Value := quFormIDPessoa.AsInteger;
      Open;
      end;

end;

procedure TFchPessoa.CreditRefresh;
begin
  CreditClose;
  CreditOpen;
  CreditGetTotal;
end;

procedure TFchPessoa.btDelCreditClick(Sender: TObject);
begin
  inherited;
  if quCustomerCreditsIDCustomerCredit.IsNull then
    Exit;

  if not quCustomerCredits.FieldByName('IsUsed').AsBoolean then
    if MsgBox(MSG_QST_DELETE, vbCritical + vbYesNo) = vbYes then
    begin
      with DM.quFreeSQL do
      begin
        If Active then
          Close;
        SQL.Clear;
        SQL.Add('UPDATE CustomerCredit ');
        SQL.Add('SET IsUsed = 1');
        SQL.Add('WHERE IDCustomerCredit = ' + quCustomerCreditsIDCustomerCredit.AsString);
        ExecSQL;
      end;
    end;
  
  CreditRefresh;
end;

procedure TFchPessoa.CreditGetTotal;
var
  fUsed,
  fNotUsed : Currency;
begin
  //Used Credit
  with quGetTotalCredit do
    begin
    SQL.Clear;
    SQL.Add('SELECT SUM(ISNULL(Amount, 0)) AS TotalCredit');
    SQL.Add('FROM	CustomerCredit (NOLOCK) ');
    SQL.Add('WHERE IDPessoa = '+quFormIDPessoa.AsString+' ');
    SQL.Add('AND IsUsed = 0');
    Open;
    fNotUsed := quGetTotalCreditTotalCredit.AsCurrency;
    Close;
    end;

  //Not Used Credit
  with quGetTotalCredit do
    begin
    SQL.Clear;
    SQL.Add('SELECT SUM(IsNull(L.ValorNominal,0)) AS TotalCredit');
    SQL.Add('FROM Fin_Lancamento L (NOLOCK) ');
    SQL.Add('JOIN Invoice I (NOLOCK) ON (I.IDPreSale = L.IDPreSale) ');
    SQL.Add('JOIN MeioPag MP (NOLOCK) ON (MP.IDMeioPag = L.IDQuitacaoMeioPrevisto) ');
    SQL.Add('WHERE I.IDCustomer = '+quFormIDPessoa.AsString+' ');
    SQL.Add('AND MP.Tipo = 5');
    Open;
    fUsed := quGetTotalCreditTotalCredit.AsCurrency;
    Close;
    end;

  edtUsed.Text      := FormatFloat('#,##0.00', fUsed);
  edtNotUsed.Text   := FormatFloat('#,##0.00', fNotUsed);

end;

procedure TFchPessoa.btAddCreditClick(Sender: TObject);
begin
  inherited;
  with TFrmCustomerAddCredit.Create(Self) do
     if Start(quFormIDPessoa.AsInteger) then
        CreditRefresh;
end;


procedure TFchPessoa.VendorTaxClose;
begin

  VendorTaxPos;

  with quVendorTax do
     if Active then
        Close;
end;

procedure TFchPessoa.VendorTaxOpen;
begin
  with quVendorTax do
     if not Active then
        begin
        Parameters.ParamByName('IDVendor').Value := quFormIDPessoa.AsInteger;
        Open;
        end;
end;

procedure TFchPessoa.VendorTaxPos;
begin
  with quVendorTax do
    if State in dsEditModes then
      Post;
end;

procedure TFchPessoa.VendorTaxRefresh;
begin
  VendorTaxClose;
  VendorTaxOpen;
end;

procedure TFchPessoa.btnNewVendorTaxClick(Sender: TObject);
var
  fID  : Integer;
  sSQL : String;
begin
  inherited;
  if scVendorAddTax.LookUpValue = '' then
     Exit;

  fID := DM.GetNextID(MR_PURCHASE_VENDOR_TAX_ID);
  sSQL := 'INSERT INTO VendorTax (IDVendorTax, IDPessoa, IDGroup, IDTaxCategory) ' +
          'VALUES ( '+IntToStr(fID)+','+quFormIDPessoa.AsString+',NULL,'+scVendorAddTax.LookUpValue+')';
  if DM.RunSQL(sSQL) then
     VendorTaxRefresh;
end;

procedure TFchPessoa.btnRemovTaxClick(Sender: TObject);
begin
  inherited;

  if (not quVendorTax.Active) and quVendorTaxIDVendorTax.IsNull then
     Exit;

  if (MsgBox(MSG_QST_DEL_VENDOR_TAX, vbYesNo + vbSuperCritical) = vbYes) then
  try
    DM.ADODBConnect.BeginTrans;
    DM.RunSQL('DELETE Pur_PurchaseItemTax WHERE IDVendorTax = ' + quVendorTaxIDVendorTax.AsString);
    DM.RunSQL('DELETE VendorTax WHERE IDVendorTax = ' + quVendorTaxIDVendorTax.AsString);
    DM.ADODBConnect.CommitTrans;
    
    VendorTaxRefresh;
  except
    DM.ADODBConnect.RollbackTrans;
  end;


end;

procedure TFchPessoa.dsVendorTaxStateChange(Sender: TObject);
begin
  inherited;

  if fIsRestricForm then
     Exit;

  btnNewVendorTax.Enabled := quVendorTax.Active;

  with quVendorTax do
    btnRemovTax.Enabled := not (EOF AND BOF);

end;

procedure TFchPessoa.btnAddPetClick(Sender: TObject);
var
   PosID1, PosID2 : String;
   fResult : Boolean;
   sMenu : String;
   Command : TBtnCommandType;
begin
  inherited;

  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := 'Pet';

  try
      if TSpeedButton(Sender).Tag = 0 then
         Command := btInc
      else
         begin
         Command := btAlt;
         PosID1 := quPetIDPet.AsString;
         end;

      with TFchPet.Create(Self) do
        begin
        fResult := Start(Command, nil, False, PosID1, PosID2, nil);
        Free;
        end;

      if fResult then
         begin
         if Command = btInc then
            DM.RunSQL('INSERT Pet_PessoaToPet (IDPessoa, IDPet) VALUES ('+quFormIDPessoa.AsString+','+PosID1+')');
         PetRefresh;
         end;
  finally
     DM.fMainMenu.SubMenuName := sMenu;
     end;
end;

procedure TFchPessoa.btnDelPetClick(Sender: TObject);
begin
  inherited;
  //Remove Pet
  if quPetIDPet.AsInteger = 0 then
     Exit;
  DM.RunSQL('DELETE Pet_PessoaToPet WHERE IDPessoa = '+quFormIDPessoa.AsString+' AND IDPet = '+quPetIDPet.AsString);
  PetRefresh;
end;

procedure TFchPessoa.PetClose;
begin
  with quPet do
     if Active then
        Close;
end;

procedure TFchPessoa.PetOpen;
begin
  with quPet do
     if not Active then
        begin
        Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsString;   
        Open;
        end;
end;

procedure TFchPessoa.PetRefresh;
begin
   PetClose;
   PetOpen;
end;

procedure TFchPessoa.dsPetStateChange(Sender: TObject);
begin
  inherited;
  with quPet do
    btnOpenPet.Enabled := not (EOF AND BOF);
  btnDelPet.Enabled := btnOpenPet.Enabled;
end;

procedure TFchPessoa.DBEdit12Exit(Sender: TObject);
begin
  inherited;
  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) and
     (Length(DBEdit12.Text) > 0) and
     (TipoCli.ItemIndex = 0) then
  begin
     if not ValidaCPF(DBEdit12.Text) then
        begin
        MsgBox(MSG_CRT_INVALID_DOCUMENT + '('+Label16.Caption+')', vbCritical + vbOkOnly);
        DBEdit12.SetFocus;
        end;
  end;
end;

procedure TFchPessoa.EditFederalIDExit(Sender: TObject);
begin
  inherited;

  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) and
     (Length(EditFederalID.Text) > 0) and
     (TipoCli.ItemIndex = 1) then
     if not ValidaCNPJ(EditFederalID.Text) then
        begin
        MsgBox(MSG_CRT_INVALID_DOCUMENT + ' ('+Label17.Caption+')', vbCritical + vbOkOnly);
        EditFederalID.SetFocus;
        end;

end;

function TFchPessoa.OnValidadeField: Boolean;
begin

  Result := True;
  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) then
  begin

    if (Trim(DBEdit12.Text) <> '') and DocAlreadyExists(DBEdit12.Text, quFormIDPessoa.AsInteger, 1) then
    begin
      MsgBox(MSG_CRT_CPF_ALREADY_EXISTS, vbCritical);
      Result := False;
    end;

    if (Trim(EditFederalID.Text) <> '') and DocAlreadyExists(EditFederalID.Text, quFormIDPessoa.AsInteger, 2) then
    begin
      MsgBox('CNPJ já cadastrado!', vbCritical);
      Result := False;
    end;

  end;

end;


function TFchPessoa.DocAlreadyExists(sDoc: string; IDPessoa, iDocType: Integer): Boolean;
var
  sField : String;
  sSQL : String;
begin
  Result := False;

  if iDocType = 1 then
    sField := ' P.CPF '
  else
    sField := ' P.InscEstadual ';

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    sSQL := Format('SELECT '+ sField +
                   ' FROM Pessoa P (NOLOCK) ' +
                   ' JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa) ' +
                   'WHERE '+ sField + ' = %S AND P.IDPessoa <> %D AND TP.Path Like %S', [QuotedStr(sDoc), IDPessoa, QuotedStr(sPessoaPath + '%')]);
    SQL.Add(sSQL);

    Open;
    Result := not IsEmpty;
  finally
    Close;
  end;
end;

procedure TFchPessoa.NextAppend;
begin
  inherited;

  with spGetPessoaRoot do
     begin
     Parameters.ParamByName('@IDTipoPessoa').Value := sIDTipoPessoa;
     Parameters.ParamByName('@IDPessoa').Value := quFormIDPessoa.AsInteger;
     ExecProc;
     quFormCode.AsString := Parameters.ParamByName('@Code').Value;
     quFormIDTipoPessoaRoot.AsInteger := Parameters.ParamByName('@IDTipoPessoaRoot').Value;
     end;

end;

procedure TFchPessoa.DisplayClientFields;
var
  bVisible : Boolean;
begin

  bVisible := not DM.fSystem.SrvParam[PARAM_DISPLAY_CUSTOMER_INFO];

  if bVisible then
     pnlAddress.Height := 190
  else
     pnlAddress.Height := 122;

  //Country
  Label24.Visible   := bVisible;
  scCountry.Visible := bVisible;
  //Beeper
  Label46.Visible      := bVisible;
  DBEditBeeper.Visible := bVisible;
  //Fax
  Label4.Visible  := bVisible;
  MemoFax.Visible := bVisible;
  //Web
  Label23.Visible      := bVisible;
  EditHomePage.Visible := bVisible;
  //Cartao Cliente
  Label32.Visible := bVisible;
  edtCustomerCard.Visible := bVisible;
  //CMotorista
  Label11.Visible  := bVisible;
  DBEdit10.Visible := bVisible;

end;

procedure TFchPessoa.ModelCodeClose;
begin
  with quVendorCode do
     if Active then
        Close;
end;

procedure TFchPessoa.ModelCodeOpen;
begin
  with quVendorCode do
     if not Active then
        begin
        Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
        Open;
        end;
end;

procedure TFchPessoa.ModelCodeRefresh;
begin
   ModelCodeClose;
   ModelCodeOpen;
end;

procedure TFchPessoa.btnDelVCodeClick(Sender: TObject);
begin
  inherited;
  if (quVendorCode.Active) and (quVendorCodeIDVendorModelCode.AsInteger <> 0) then
     begin
     DM.RunSQL('DELETE VendorModelCode WHERE IDVendorModelCode = ' + quVendorCodeIDVendorModelCode.AsString);
     ModelCodeRefresh;
     end;
end;

procedure TFchPessoa.dsVendorCodeStateChange(Sender: TObject);
begin
  inherited;
  if quVendorCode.Active then
      btnDelVCode.Enabled := quVendorCode.RecordCount<>0
  else
      btnDelVCode.Enabled := False;
end;

procedure TFchPessoa.btnHistoryAddClick(Sender: TObject);
var
 FIDHistory : Integer;
begin
  inherited;
  with TFrmPessoaHistory.Create(Self) do
    if Start(quFormIDPessoa.AsInteger, -1, FIDHistory) then
      PessoaHistoryRefresh;

end;

procedure TFchPessoa.btnHistoryEditClick(Sender: TObject);
var
 FIDHistory : Integer;
 iIDPessoa, iIDPessoaHistory : Integer;
begin
  inherited;
  if quPessoaHistory.Active and (quPessoaHistory.RecordCount > 0) then
  begin
    iIDPessoa        := quFormIDPessoa.AsInteger;
    iIDPessoaHistory := quPessoaHistoryIDPessoaHistory.AsInteger;
    with TFrmPessoaHistory.Create(Self) do
      if Start(iIDPessoa, iIDPessoaHistory, FIDHistory) then
        PessoaHistoryRefresh;
  end;
end;

procedure TFchPessoa.PessoaHistoryRefresh;
begin
  PessoaHistoryClose;
  PessoaHistoryOpen;
end;

procedure TFchPessoa.PessoaHistoryClose;
begin
  with quPessoaHistory do
    if Active then
      Close;
end;

procedure TFchPessoa.PessoaHistoryOpen;
begin
  with quPessoaHistory do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
      Open;
    end;
end;

procedure TFchPessoa.btnHistoryDeleteClick(Sender: TObject);
begin
  inherited;
  PessoaHistoryDelete;
end;

procedure TFchPessoa.PessoaHistoryDelete;
begin
  with quPessoaHistory do
    if Active and (RecordCount > 0) then
    begin
      DM.RunSQL('DELETE Mnt_PessoaHistory WHERE IDPessoaHistory = ' + quPessoaHistoryIDPessoaHistory.AsString);
      PessoaHistoryRefresh;
    end;
end;

procedure TFchPessoa.btAddAddressClick(Sender: TObject);
begin
  inherited;
  OpenAddressForm(btInc);
end;

procedure TFchPessoa.AddressClose;
begin
  with quAddress do
    if Active then
      Close;
end;

procedure TFchPessoa.AddressDelete;
begin
  with quAddress do
    if Active and (not IsEmpty) then
    begin
      DM.RunSQL('DELETE Mnt_PessoaAddress WHERE IDPessoaAddress = ' + quAddressIDPessoaAddress.AsString);
      AddressRefresh;
    end;
end;

procedure TFchPessoa.AddressOpen;
begin
  with quAddress do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger; 
      Open;
    end;
end;

procedure TFchPessoa.AddressRefresh;
begin
  AddressClose;
  AddressOpen;
end;

procedure TFchPessoa.btRemoveAddressClick(Sender: TObject);
begin
  inherited;
  if (MsgBox(MSG_QST_DELETE, vbCritical + vbYesNo) = vbYes) then
    AddressDelete;
end;

procedure TFchPessoa.btDetailAddressClick(Sender: TObject);
begin
  inherited;
  OpenAddressForm(btAlt);
end;

procedure TFchPessoa.OpenAddressForm(btKind: TBtnCommandType);
var
  FchAddress: TFchPessoaAddress;
  sID1, sID2: String;
begin
  try
    FchAddress := TFchPessoaAddress.Create(Self);
    FchAddress.sParam := FchAddress.sParam + 'IDPessoa=' + quFormIDPessoa.AsString + ';';
    if FchAddress.Start(btKind, quAddress, False, sID1, sID2, grdAddress) then
      AddressRefresh;
  finally
    FreeAndNil(FchAddress);
  end;
end;

procedure TFchPessoa.dsAddressDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  with quAddress do
  begin
    if Active then
      btDetailAddress.Enabled := not IsEmpty;
      btRemoveAddress.Enabled := not IsEmpty;
  end;
end;

procedure TFchPessoa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(LEntiryFilters);
end;

procedure TFchPessoa.SetRequiredField(AFieldName: String; ARequired :
  Boolean; ALabel: TLabel);
begin
  quForm.FieldByName(AFieldName).Required := ARequired;
  ALabel.Visible := ARequired;
end;


procedure TFchPessoa.LoadUserType(AIDTipoUsuario : Integer);
begin
  LEntiryFilters.Clear;
  LEntiryFilters.CommaText := DM.FilterEntyField(AIDTipoUsuario);

  SetRequiredField('Endereco', (LEntiryFilters.IndexOf('Endereco') > -1), lbHasAdr);
  SetRequiredField('Bairro', (LEntiryFilters.IndexOf('Bairro') > -1), lbHasBairro);
  SetRequiredField('Cidade', (LEntiryFilters.IndexOf('Cidade') > -1), lbHasCty);
  SetRequiredField('IDMunicipio', (LEntiryFilters.IndexOf('IDMunicipio') > -1), lbHasCodMunicipio);
  SetRequiredField('IDEstado', (LEntiryFilters.IndexOf('IDEstado') > -1), lbHasStat);
  SetRequiredField('CEP', (LEntiryFilters.IndexOf('CEP') > -1), lbHasZip);
  SetRequiredField('IDPais', (LEntiryFilters.IndexOf('IDPais') > -1), lbHasCountry);
  SetRequiredField('Telefone', (LEntiryFilters.IndexOf('Telefone') > -1), lbHasPhone);
  SetRequiredField('PhoneAreaCode', (LEntiryFilters.IndexOf('Telefone') > -1), lbHasPhone);
  SetRequiredField('Cellular', (LEntiryFilters.IndexOf('Cellular') > -1), lbHasCel);
  SetRequiredField('CellAreaCode', (LEntiryFilters.IndexOf('Cellular') > -1), lbHasCel);
  SetRequiredField('Email', (LEntiryFilters.IndexOf('Email') > -1), lbHasEmail);
  SetRequiredField('Beeper', (LEntiryFilters.IndexOf('Beeper') > -1), lbHasBeeper);
  SetRequiredField('Fax', (LEntiryFilters.IndexOf('Fax') > -1), lbHasFax);
  SetRequiredField('HomePage', (LEntiryFilters.IndexOf('HomePage') > -1), lbHasHomePage);
  SetRequiredField('Contato', (LEntiryFilters.IndexOf('Contato') > -1), lbHasContact);

  LoadUserSetting(TipoCli.ItemIndex = 0);

end;

procedure TFchPessoa.scPessoaTipoSelectItem(Sender: TObject);
begin
  inherited;
  LoadUserType(StrToIntDef(scPessoaTipo.LookUpValue, 0));
end;


procedure TFchPessoa.OnAfterUpdateNavegator;
begin
  inherited;
end;

procedure TFchPessoa.FormShow(Sender: TObject);
begin
  inherited;
  LoadUserType(quFormIDTipoPessoa.AsInteger);
  Label3.Caption := sAddress;
end;

procedure TFchPessoa.dxDBGridGHDblClick(Sender: TObject);
begin
  inherited;

  // Abre a tela do hold selecionado
  if (quGroupHistory.Active) and not quGroupHistory.IsEmpty then
    begin
      LoadInvoiceForm;
      FrmInvoice.Start(quGroupHistoryIDPreSale.AsInteger, SALE_INVOICE, 0, False);
    end;

end;

procedure TFchPessoa.EditFederalIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if DMGlobal.IDLanguage = LANG_PORTUGUESE then
  begin
    if not (Key in ['0'..'9', #8]) then
    Key := #0;
  end;
end;

procedure TFchPessoa.LoadUserSetting(APersonal: Boolean);
begin

  SetRequiredField('Identidade', False, lnHasIdent);
  SetRequiredField('OrgaoEmissor', False, lnHasIdent);
  SetRequiredField('DataExpedicao', False, lnHasIdent);
  SetRequiredField('CartMotorista', False, lbDriversLinc);
  SetRequiredField('Nascimento', False, lbHasBirth);
  SetRequiredField('CustomerCard', False, lbHasCustCard);
  SetRequiredField('CPF', False, lbHasCPF);

  SetRequiredField('NomeJuridico', False, lbHasNomeJur);
  SetRequiredField('InscEstadual', False, lbHasIncEst);
  SetRequiredField('InscMunicipal', False, lnHasInscMun);

  if APersonal then
  begin
    //Cliente Fisico
    SetRequiredField('Identidade', (LEntiryFilters.IndexOf('Identidade') > -1), lnHasIdent);
    SetRequiredField('OrgaoEmissor', (LEntiryFilters.IndexOf('Identidade') > -1), lnHasIdent);
    SetRequiredField('DataExpedicao', (LEntiryFilters.IndexOf('Identidade') > -1), lnHasIdent);
    SetRequiredField('CartMotorista', (LEntiryFilters.IndexOf('CartMotorista') > -1), lbDriversLinc);
    SetRequiredField('Nascimento', (LEntiryFilters.IndexOf('Nascimento') > -1), lbHasBirth);
    SetRequiredField('CustomerCard', (LEntiryFilters.IndexOf('CustomerCard') > -1), lbHasCustCard);
    SetRequiredField('CPF', (LEntiryFilters.IndexOf('CPF') > -1), lbHasCPF);
  end
  else
  begin
    //Cliente Fisico
    SetRequiredField('NomeJuridico', (LEntiryFilters.IndexOf('NomeJuridico') > -1), lbHasNomeJur);
    SetRequiredField('InscEstadual', (LEntiryFilters.IndexOf('InscEstadual') > -1), lbHasIncEst);
    SetRequiredField('InscMunicipal', (LEntiryFilters.IndexOf('InscMunicipal') > -1), lnHasInscMun);
  end;

end;

procedure TFchPessoa.rgGenderEnter(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchPessoa.DBEdit6Change(Sender: TObject);
begin
  inherited;
  bAlterStoreAccLimit := True;
end;

procedure TFchPessoa.SaveStoreAccLog;
begin
  with cmdStoreAccLog do
  begin
    Parameters.ParamByName('ID').Value       := DM.GetNextID('Sal_StoreAccountLimetLog.IDStoreAccountLimtLog');
    Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
    Parameters.ParamByName('IDUser').Value   := DM.fUser.ID;
    Parameters.ParamByName('LogDate').Value  := Now;
    Parameters.ParamByName('Amount').Value   := quFormStoreAccountLimit.AsCurrency;
    Execute;
  end;
end;

procedure TFchPessoa.SetHelpContext;
begin

  sUrlHelp  := '';
  sUrlVideo := '';

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      case PessoaTipo of
        PT_VENDOR  : begin
                       sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Fornecedor.htm';
                       sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Fornecedor/Adicionar_Fornecedor.html';
                     end;
        PT_MANUFACTURE:
                     begin
                       sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Fabricante.htm';
                       sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Fabricante/Adicionar_Fabricante.html';
                     end;
      else
        sUrlHelp  := '';
        sUrlVideo := '';
      end;
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;


end;

procedure TFchPessoa.btnVideoClick(Sender: TObject);
begin

  SetHelpContext;
  inherited;

end;

procedure TFchPessoa.InvoiceItemClose;
begin
   with dstInvoiceItem do
      if Active then
        close;
end;

procedure TFchPessoa.InvoiceItemOpen;
var
  sSQL : String ;
begin

  if not DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
  begin
    sSQL :=
       'SELECT'
      +'    CONVERT(DATETIME, CONVERT(VARCHAR, I.PreSaleDate,112)) as InvoiceDate,'
      +'    IM.Qty,'
      +'    IM.Discount,'
      +'    ((IM.QTY * IM.SalePrice) - IM.Discount) as SalePrice,'
      +'    M.Model,'
      +'    M.Description,'
      +'    TG.Name as Category,'
      +'    I.InvoiceCode '
      +'FROM '
      +'    Invoice I (NOLOCK)'
      +'    JOIN Store S (NOLOCK) ON (I.IDStore = S.IDStore)'
      +'    JOIN InventoryMov IM (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.InventmovTypeID = 1)'
      +'    JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'
      +'    JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'
      +'WHERE'
      +'  I.InvoiceDate >= :DataIni '
      +'  AND'
      +'  I.InvoiceDate < :DataFim '
      +'  AND'
      +'  I.IDCustomer = :IDPessoa '
      +'  AND'
      +'  I.IDInvoice IS NOT NULL';
  end
  else
  begin
     sSQL :=
       'SELECT DISTINCT '
      +'    CONVERT(DATETIME, CONVERT(VARCHAR, I.PreSaleDate,112)) as InvoiceDate,'
      +'    IM.Qty,'
      +'    IM.Discount,'
      +'    ((IM.QTY * IM.SalePrice) - IM.Discount) as SalePrice,'
      +'    M.Model, '
      +'    M.Description, '
      +'    TG.Name as Category '
      +'FROM '
      +'    vwSaleItem IM (NOLOCK)'
      +'    JOIN vwInvoiceParents I (NOLOCK) ON (I.DocumentID = IM.IDPreSale)'
      +'    JOIN Store S (NOLOCK) ON (I.IDStore = S.IDStore)'
      +'    JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'
      +'    JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID) '
      +'WHERE'
      +'  IM.PreSaleDate >= :DataIni '
      +'  AND'
      +'  IM.PreSaleDate < :DataFim '
      +'  AND'
      +'  I.IDCustomer = :IDPessoa ';
  end;

  with dstInvoiceItem do
    if not Active then
    begin
      CommandText := sSQL;
      Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
      Parameters.ParamByName('DataIni').Value :=  dtIHIni.Date;
      Parameters.ParamByName('DataFim').Value :=  dtIHFim.Date + 1;
      Open;
    end;

end;

procedure TFchPessoa.InvoiceItemRefresh;
begin

  InvoiceItemClose;
  InvoiceItemOpen;

end;

procedure TFchPessoa.btGroupClick(Sender: TObject);
begin
  inherited;
 if btGroup.Down then
    begin
      TcxGridDBTableView(TcxCustomGridTableView(grdBrowse.FocusedView)).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowse do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(TcxCustomGridTableView(grdBrowse.FocusedView)).GroupedItemCount > 0 do
            TcxGridDBTableView(TcxCustomGridTableView(grdBrowse.FocusedView)).GroupedColumns[TcxGridDBTableView(TcxCustomGridTableView(grdBrowse.FocusedView)).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(TcxCustomGridTableView(grdBrowse.FocusedView)).OptionsView.GroupByBox := False;
        end;
    end;
end;

procedure TFchPessoa.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not quForm.Active) or
    (quForm.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdBrowse, lblSubMenu.Caption);

end;

procedure TFchPessoa.ValidatePhoneAreaCode(areaCode: string);
begin
   if ( trim(areaCode) <> '' ) then begin
       if ( length(areaCode) > 0 ) then begin
           if ( (length(areaCode) < 3 ) or (length(areaCode) > 3) ) then begin
              MsgBox(MSG_INF_RANGE_AREACODE, vbOKOnly + vbInformation);
              edtPhoneDDD.SetFocus;
              Exit;
           end;
       end;
   end;
end;

procedure TFchPessoa.ValidateCelPhone(number: string);
begin
   if ( trim(number) <> '-' ) then begin
       if ( length(number) > 0 ) then begin
           if ( (length(number) < 7 ) or (length(number) > 7) ) then begin
              MsgBox(MSG_INF_RANGE_PHONE_NUMBER, vbOKOnly + vbInformation);
              DbEditCellular.SetFocus;
              Exit;
           end;
       end;
   end;
end;

procedure TFchPessoa.ValidatePhone(number: string);
begin
   if ( trim(number) <> '-' ) then begin
       if ( length(number) > 0 ) then begin
           if ( (length(number) < 7 ) or (length(number) > 7) ) then begin
              MsgBox(MSG_INF_RANGE_PHONE_NUMBER, vbOKOnly + vbInformation);
              edtPhone.SetFocus;
              Exit;
           end;
       end;
   end;
end;

procedure TFchPessoa.edtPhoneDDDExit(Sender: TObject);
begin
  inherited;
  ValidatePhoneAreaCode(GetOnlyNumbers(edtPhoneDDD.EditText));
end;

procedure TFchPessoa.edtPhoneExit(Sender: TObject);
begin
  inherited;
  ValidatePhone(GetOnlyNumbers(edtPhone.EditText));
end;

function TFchPessoa.GetOnlyNumbers(alphaNumber: string): string;
begin
   result := ReturnNumber(alphaNumber);
end;

procedure TFchPessoa.edtCellDDDExit(Sender: TObject);
begin
  inherited;
  ValidateCellAreaCode(GetOnlyNumbers(edtCellDDD.EditText));
end;

procedure TFchPessoa.DbEditCellularExit(Sender: TObject);
begin
  inherited;
  ValidateCelPhone(GetOnlyNumbers(DbEditCellular.EditText));
end;

procedure TFchPessoa.ValidateCellAreaCode(areaCode: string);
begin
   if ( trim(areaCode) <> '' ) then begin
       if ( length(areaCode) > 0 ) then begin
           if ( (length(areaCode) < 3 ) or (length(areaCode) > 3) ) then begin
              MsgBox(MSG_INF_RANGE_AREACODE, vbOKOnly + vbInformation);
              edtCellDDD.SetFocus;
              Exit;
           end;
       end;
   end;
end;

procedure TFchPessoa.ValidateEmail(email: string);
begin
	if ( length(email) > 0 ) then begin
      if ( Pos('@', email) = 0 ) then begin
          MsgBox(MSG_INF_INVALID_EMAIL, vbOKOnly + vbInformation);
          EditEMail.SetFocus;
          Exit;
      end;
   end;
end;

procedure TFchPessoa.EditEMailExit(Sender: TObject);
begin
  inherited;
  ValidateEmail(EditEMail.EditText);
end;

procedure TFchPessoa.ValidateAddress(addr: string);
begin
   if ( length(addr) = 0 ) then begin
      MsgBox(MSG_INF_OBLIGATORY_ADDRESS, vbOKOnly + vbInformation);
      edtAddress.SetFocus;
      Exit;
   end;
end;

procedure TFchPessoa.ValidateCity(city: string);
begin
   if ( length(city) = 0 ) then begin
      MsgBox(MSG_INF_OBLIGATORY_CITY, vbOKOnly + vbInformation);
      edtCity.SetFocus;
      Exit;
   end;
end;

procedure TFchPessoa.ValidateSaleTax(saleTax: double);
begin
   if ( length(EditSalesTax.EditText) = 0 ) then begin
      MsgBox(MSG_INF_OBLIGATORY_SALETAX, vbOKOnly + vbInformation);
      scState.SetFocus;
      Exit;
   end;
end;

procedure TFchPessoa.ValidateState(state: string);
begin
   if ( length(state) = 0 ) then begin
      MsgBox(MSG_INF_OBLIGATORY_STATE, vbOKOnly + vbInformation);
      scState.SetFocus;
      Exit;
   end;
end;

procedure TFchPessoa.ValidateZipCode(zip: string);
begin
   if ( length(zip) = 0 ) then begin
      MsgBox(MSG_INF_OBLIGATORY_ZIPCODE, vbOKOnly + vbInformation);
      edtZIP.SetFocus;
      Exit;
   end;
end;

function TFchPessoa.ValidateObligatoryFields(): boolean;
begin

  result := false;

  if ( length(edtAddress.EditText) = 0 ) then begin
      ValidateAddress(edtAddress.EditText);
  end else if ( length(edtCity.EditText) = 0 ) then begin
         ValidateCity(edtCity.EditText);
      end else if ( length(scState.EditText) = 0 ) then begin
             ValidateState(scState.EditText);
          end else if ( length(edtZIP.EditText) = 0 ) then begin
                 ValidateZipCode(edtZIP.EditText);
              end else if ( length(EditSalesTax.EditText) = 0 ) then begin
                     ValidateSaleTax(EditSalesTax.Field.Value);
                   end else begin
                          result := true;
                       end;
end;

procedure TFchPessoa.btCancelClick(Sender: TObject);
begin
  if ( dsForm.DataSet.State in [dsInsert, dsEdit] ) then begin
     dsForm.DataSet.Cancel;
  end;

  inherited;

end;

procedure TFchPessoa.btCloseClick(Sender: TObject);
begin
  if ( ValidateObligatoryFields() ) then begin
  		inherited;
  end;

end;

end.
