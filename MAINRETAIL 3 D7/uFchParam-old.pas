(*
Date    : 12.30.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Task    : Create a new client parameter called: gift processor. This parameter
          will be saved in windows's registry. This one will be used to new
          implementation related gift cards ( Internal MR gift card and Mercury ).
-----------------------------------------------------------------------------------------------------

Date    : 12.23.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Task    : New Tab to deal Mercury Gift Card settings.
-----------------------------------------------------------------------------------------------------

*)

unit uFchParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, LblEffct, StdCtrls, ExtCtrls, DB, Mask, DBCtrls, registry,
  Buttons, SuperComboADO, dximctrl, siComp, siLangRT, ComCtrls, ExtDlgs,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  SubListPanel, IniFiles, Grids, cxContainer, cxTextEdit, cxMaskEdit,
  cxSpinEdit;

Const
  PARAM_OPEN_ALL       = -1;
  PARAM_OPEN_CASHREG   = 0;
  PARAM_OPEN_IDIOM     = 1;
  PARAM_OPEN_INVOICE   = 2;         
  PARAM_OPEN_PRINTER   = 3;
  PARAM_OPEN_MENU      = 4;
  PARAM_OPEN_GRID      = 5;
  PARAM_OPEN_PURCHASE  = 6;
  PARAM_OPEN_PROCESSOR = 7;
  PARAM_OPEN_GYNBO_PROCESSOR = 8;
  PARAM_OPEN_SHIPPING  = 9;
  PARAM_OPEN_POLLDISPLAY = 10;
  PARAM_OPEN_PRICE       = 11;
  PARAM_OPEN_PETCENTER   = 12;
  PARAM_OPEN_SCALE       = 13;

  COLOR_MENU_HIGHLIGHT          = 'MH=';
  COLOR_MENU_TEXT_HIGHLIGHT     = 'MTH=';
  COLOR_MENU_BACKGROUND         = 'MBG=';
  COLOR_BACKGROUND              = 'BKG=';
  COLOR_SUB_MENU_FONT           = 'SMF=';
  COLOR_SUB_MENU_FONT_HIGHLIGHT = 'SMFH=';
  COLOR_PANEL_SHORTCUTS         = 'PSFT=';
  COLOR_PANEL_SYSTEM            = 'PSYS=';
  COLOR_PANEL_HELP              = 'PHLP=';

  FILE_IMAGEM = 'JPG, BMP|*.jpg; *.bmp|JPG (*.jpg)|*.jpg|BPM (*.bmp)|*.bmp';
  FILE_REPORT = 'RTM (*.RTM)|*.rtm';
  FILE_EXEC   = 'SOFTWARE (*.EXE)|*.exe';

  TEMPLATE_FILE = 'MenuColor.ini'; 

type
  TFchParameter = class(TFrmParent)
    btCancel: TButton;
    spHelp: TSpeedButton;
    pgParam: TPageControl;
    tsCashInfo: TTabSheet;
    tdIdiom: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cmbCashReg: TSuperComboADO;
    cmbStore: TSuperComboADO;
    EditOpenCode: TEdit;
    cbOpenCashReg: TCheckBox;
    Label4: TLabel;
    cbxLanguage: TdxImageComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtDecimal: TEdit;
    edtThousand: TEdit;
    lbEx1: TLabel;
    lbEx2: TLabel;
    Label7: TLabel;
    cbxDateFormat: TComboBox;
    tsInvoice: TTabSheet;
    Label8: TLabel;
    cbxXpressType: TComboBox;
    pnlSuperMarketImg: TPanel;
    Label9: TLabel;
    edtXSaleImg: TEdit;
    SpeedButton1: TSpeedButton;
    OP: TOpenDialog;
    tsPrinterSetup: TTabSheet;
    tsMenuColor: TTabSheet;
    CD: TColorDialog;
    pnlMenuHighlight: TPanel;
    Label13: TLabel;
    pnlMenuTextHighlight: TPanel;
    Label14: TLabel;
    pnlMenuBackGround: TPanel;
    Label16: TLabel;
    pnlBackGroundColor: TPanel;
    Label17: TLabel;
    pnlSubMenuFontColor: TPanel;
    Label18: TLabel;
    pnlSMHighlightFontColor: TPanel;
    Label19: TLabel;
    Bevel1: TBevel;
    Label20: TLabel;
    Bevel2: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    edtLogo: TEdit;
    sbBackGround: TSpeedButton;
    cbxColor: TComboBox;
    btnApplay: TButton;
    tsGridLayout: TTabSheet;
    GridLayoutSub: TSubListPanel;
    Label25: TLabel;
    scMedia: TSuperComboADO;
    Bevel3: TBevel;
    pnlShorcutsColor: TPanel;
    Label26: TLabel;
    pnlHelpColor: TPanel;
    Label27: TLabel;
    pnlSystemColor: TPanel;
    Label28: TLabel;
    btnSaveColors: TBitBtn;
    Label29: TLabel;
    memOBSInv: TMemo;
    tsInvoiceOptions: TTabSheet;
    chkDisplayBudget: TCheckBox;
    chkDisplayHold: TCheckBox;
    chkDisplaySearch: TCheckBox;
    chkDisplayCloseDay: TCheckBox;
    chkDisplayFinalize: TCheckBox;
    ldDefStore: TLabel;
    scDefaultSaleStore: TSuperComboADO;
    tsPurchase: TTabSheet;
    Label33: TLabel;
    scPurchaseStore: TSuperComboADO;
    chkViewOtherRegister: TCheckBox;
    tsProcessor: TTabSheet;
    lbPayProcessor: TLabel;
    cbxProcessors: TComboBox;
    lbCutCode: TLabel;
    edtAfterPrintCode: TEdit;
    chkWindowMode: TCheckBox;
    Bevel4: TBevel;
    Label32: TLabel;
    btnSANew: TPageControl;
    tsPrintInvoice: TTabSheet;
    tsPrintBudget: TTabSheet;
    lbBNumCopies: TLabel;
    lbBudget: TLabel;
    btnBudgetNew: TSpeedButton;
    btnBudgetOpen: TSpeedButton;
    btnBudgetDel: TSpeedButton;
    EdtBudgetReportPath: TEdit;
    Label30: TLabel;
    cbxPaperType: TComboBox;
    cbPrintReceipt: TCheckBox;
    pnlInvoiceA4: TPanel;
    lbHoldReport: TLabel;
    EdtHoldReportPath: TEdit;
    btnNewReport: TSpeedButton;
    btnOpenReport: TSpeedButton;
    btnDelReport: TSpeedButton;
    pnlInvoice80Col: TPanel;
    pnlFontSetup: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    lbFontExample: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    SpeedButton2: TSpeedButton;
    cbxFontName: TComboBox;
    edtFontSize: TEdit;
    udFont: TUpDown;
    edtLinespace: TEdit;
    udSpaceLine: TUpDown;
    edtLineWidth: TEdit;
    upLineWidth: TUpDown;
    tsPrintDeliver: TTabSheet;
    lbDNumCopies: TLabel;
    edtNumCopyDelivery: TEdit;
    chkDeliveryCommis: TCheckBox;
    udDelivery: TUpDown;
    lbDeliveryRep: TLabel;
    EdtDeveliryReportPath: TEdit;
    btnDeliveryNew: TSpeedButton;
    btnDeliveryOpen: TSpeedButton;
    btnDeliveryDel: TSpeedButton;
    tsPrintCommission: TTabSheet;
    lbCommission: TLabel;
    edtCommisReportPath: TEdit;
    btnCommiNew: TSpeedButton;
    btnCommiOpen: TSpeedButton;
    btnCommiDel: TSpeedButton;
    tsPrintTransfer: TTabSheet;
    lbTNumCopies: TLabel;
    edtNumCopyTransfer: TEdit;
    chkPreviewTransfer: TCheckBox;
    udTransfer: TUpDown;
    lbCoNumCopies: TLabel;
    edtNumCopyCommis: TEdit;
    chkPreviewCommis: TCheckBox;
    udCommis: TUpDown;
    lbTransferRep: TLabel;
    EdtTransferReportPath: TEdit;
    btnNewTransfer: TSpeedButton;
    btnOpenTransfer: TSpeedButton;
    btnDelTransfer: TSpeedButton;
    tsPrintPO: TTabSheet;
    lbPONumCopies: TLabel;
    edtNumCopyPO: TEdit;
    chkPreviewPO: TCheckBox;
    udPO: TUpDown;
    lbPOPrint: TLabel;
    edtPOReportPath: TEdit;
    btnPONew: TSpeedButton;
    btnPOOpen: TSpeedButton;
    btnPODel: TSpeedButton;
    chkPreview: TCheckBox;
    chkBudgetCommis: TCheckBox;
    edtNumCopyBudget: TEdit;
    udBudget: TUpDown;
    cbxTransferPrinter: TComboBox;
    lbTPrinter: TLabel;
    lbPOPrinter: TLabel;
    cbxPOPrinter: TComboBox;
    cbxCommisPrinter: TComboBox;
    lbCoPrinter: TLabel;
    lbDPrinter: TLabel;
    cbxDeliveryPrinter: TComboBox;
    lbBPrinter: TLabel;
    cbxBudgetPrinter: TComboBox;
    lbInvPrinter: TLabel;
    cbxInvoicePrinter: TComboBox;
    pnlUSB: TPanel;
    chkAskUser: TCheckBox;
    pgCharge: TPageControl;
    tsCardSetup: TTabSheet;
    tsPinPad: TTabSheet;
    ntProcessor: TNotebook;
    lbPCPath: TLabel;
    btnPCPath: TSpeedButton;
    lblPCChargeUser: TLabel;
    lbPCTimeOut: TLabel;
    lbLastValidDate: TLabel;
    lbPCPrintNum: TLabel;
    lbPCServer: TLabel;
    lbPCPort: TLabel;
    edtPCPath: TEdit;
    edtPCUser: TEdit;
    edtPCTimeOut: TEdit;
    edtPCLastValidDate: TEdit;
    edtPCPrintNum: TEdit;
    chkMultProcessor: TCheckBox;
    edtServer: TEdit;
    edtPort: TEdit;
    DeviceBox: TComboBox;
    lbPinDevice: TLabel;
    BaudBox: TComboBox;
    lbPinBaud: TLabel;
    GroupBox6: TGroupBox;
    SevRadio: TRadioButton;
    EightRadio: TRadioButton;
    ParityBox: TComboBox;
    lbPinParity: TLabel;
    CommBox: TComboBox;
    lbPinCom: TLabel;
    Label31: TLabel;
    lbEncMethod: TLabel;
    EdtEncryptMe: TEdit;
    lbPintimeOut: TLabel;
    edtPinTimeOut: TEdit;
    Label35: TLabel;
    Label10: TLabel;
    cbxPrinterPort: TComboBox;
    pnlWinCommand: TPanel;
    lbUSBOpenDraw: TLabel;
    Label37: TLabel;
    lbUSBCut: TLabel;
    Label36: TLabel;
    chkUSB: TCheckBox;
    edtUSBOpenCode: TEdit;
    edtUSBCutCode: TEdit;
    lbReportFooter: TLabel;
    edtReportFooter: TEdit;
    btnOpenStoreFooter: TSpeedButton;
    btnDelStoreFooter: TSpeedButton;
    chkDisplayPOSHold: TCheckBox;
    tsShipping: TTabSheet;
    lbSHRegister: TLabel;
    cmbShippingRegister: TSuperComboADO;
    lbSHPacking: TLabel;
    edtSHPacking: TEdit;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    lbSHPick: TLabel;
    edtSHPickTicket: TEdit;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    chkSuggestPrintTransf: TCheckBox;
    chkViewOtherStore: TCheckBox;
    tsPollDisplay: TTabSheet;
    Label38: TLabel;
    edtPollDisplayIP: TEdit;
    edtPollDisplayPort: TEdit;
    Label39: TLabel;
    chkClearSale: TCheckBox;
    tsPrice: TTabSheet;
    scRecordType: TSuperComboADO;
    scDocumentType: TSuperComboADO;
    scPaymentType: TSuperComboADO;
    seDueDateDays: TcxSpinEdit;
    lblRecordType: TLabel;
    lblDocumentType: TLabel;
    lblPaymentType: TLabel;
    lblDueDateDays: TLabel;
    tsPetCenter: TTabSheet;
    Label40: TLabel;
    edtPetIP: TEdit;
    Label41: TLabel;
    edtPetPort: TEdit;
    tsPrintRepair: TTabSheet;
    lbRepairNumCopies: TLabel;
    lbRepairPrint: TLabel;
    btnRepairNew: TSpeedButton;
    btnRepairOpen: TSpeedButton;
    btnRepairDel: TSpeedButton;
    lbRepairPrinter: TLabel;
    edtNumCopyRepair: TEdit;
    chkPreviewRepair: TCheckBox;
    udRepair: TUpDown;
    edtRepairReportPath: TEdit;
    cbxRepairPrinter: TComboBox;
    tsPrintReceiving: TTabSheet;
    lbReceivingNumCopies: TLabel;
    lbReceivingPrint: TLabel;
    btnReceivingNew: TSpeedButton;
    btnReceivingOpen: TSpeedButton;
    btnReceivingDel: TSpeedButton;
    lbReceivingPrinter: TLabel;
    edtNumCopyReceiving: TEdit;
    chkPreviewReceiving: TCheckBox;
    udReceiving: TUpDown;
    edtReceivingReportPath: TEdit;
    cbxReceivingPrinter: TComboBox;
    cbxPOEmailFile: TComboBox;
    lblEmailFile: TLabel;
    tsServiceOrder: TTabSheet;
    chkSOPreview: TCheckBox;
    lnSONumCopy: TLabel;
    edtNumCopySO: TEdit;
    upSO: TUpDown;
    lbSOReport: TLabel;
    edtSOReportPath: TEdit;
    btnSONew: TSpeedButton;
    btnSOEdit: TSpeedButton;
    btnSODel: TSpeedButton;
    lbSOPrinter: TLabel;
    cbxSOPrinter: TComboBox;
    tsStoreAcc: TTabSheet;
    chkSAPreview: TCheckBox;
    lnSANumCopy: TLabel;
    edtNumCopySA: TEdit;
    upSA: TUpDown;
    lbSAReport: TLabel;
    edtSAReportPath: TEdit;
    SpeedButton9: TSpeedButton;
    btnSAEdit: TSpeedButton;
    btnSADel: TSpeedButton;
    lbSAPrinter: TLabel;
    cbxSAPrinter: TComboBox;
    tsScaleSetup: TTabSheet;
    chkScale: TCheckBox;
    cbxScaleType: TComboBox;
    lbSOCategory: TLabel;
    scCategoria: TSuperComboADO;
    btnPetPath: TSpeedButton;
    Label34: TLabel;
    edtNumCopies: TEdit;
    udCopies: TUpDown;
    edtMerIPPort: TEdit;
    lbMerIPPot: TLabel;
    edtMerchantID: TEdit;
    edtMerIPAddress: TEdit;
    lbMerMerchantID: TLabel;
    lbMerIPAddress: TLabel;
    lbIPAddressHint: TLabel;
    edtMerConTimeOut: TEdit;
    lbMerConTimeOut: TLabel;
    edtResponseTimeout: TEdit;
    lbMerResponseTimeout: TLabel;
    lbMerConTimeOutHint: TLabel;
    lbMerRespTimeoutHint: TLabel;
    tsCCSweep: TTabSheet;
    grdPayment: TStringGrid;
    cbxProcessor: TComboBox;
    cxCardType: TComboBox;
    lbFixItem: TLabel;
    edtFixItem: TEdit;
    UPFixItem: TUpDown;
    lbFixItemDesc: TLabel;
    tsGCBBProcessor: TTabSheet;
    lbBBUrl: TLabel;
    edtBBUrl: TEdit;
    lbBBUrlUser: TLabel;
    edtBBUrlUser: TEdit;
    lbBBUrlPw: TLabel;
    edtBBUrlPW: TEdit;
    lbBBPartnerAcc: TLabel;
    edtBBPartnerAcc: TEdit;
    edtBBPartnerKey: TEdit;
    lbBBPartnerKey: TLabel;
    lbBBStoreNum: TLabel;
    edtBBStoreNum: TEdit;
    lbBBTerminal: TLabel;
    edtBBTerminal: TEdit;
    btnBBTestConnection: TButton;
    lbBBTestResult: TLabel;
    tabMercuryGift: TTabSheet;
    nbMercuryGift: TNotebook;
    Label42: TLabel;
    SpeedButton10: TSpeedButton;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    CheckBox1: TCheckBox;
    Edit6: TEdit;
    Edit7: TEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    edtMercGiftPort: TEdit;
    edtMercMechantID: TEdit;
    edtMercIPAddress: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    pnGCProcessor: TPanel;
    cbbGCProcessor: TComboBox;
    Label57: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure cbxDateFormatChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbxXpressTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxFontNameChange(Sender: TObject);
    procedure cbxPrinterPortChange(Sender: TObject);
    procedure pnlMenuHighlightClick(Sender: TObject);
    procedure cbxColorChange(Sender: TObject);
    procedure btnApplayClick(Sender: TObject);
    procedure pgParamChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnSaveColorsClick(Sender: TObject);
    procedure btnDelReportClick(Sender: TObject);
    procedure sbBackGroundClick(Sender: TObject);
    procedure btnNewReportClick(Sender: TObject);
    procedure btnOpenReportClick(Sender: TObject);
    procedure btnDeliveryNewClick(Sender: TObject);
    procedure btnDeliveryOpenClick(Sender: TObject);
    procedure btnDeliveryDelClick(Sender: TObject);
    procedure btnBudgetNewClick(Sender: TObject);
    procedure btnBudgetOpenClick(Sender: TObject);
    procedure btnBudgetDelClick(Sender: TObject);
    procedure btnCommiDelClick(Sender: TObject);
    procedure btnCommiOpenClick(Sender: TObject);
    procedure btnCommiNewClick(Sender: TObject);
    procedure btnDelTransferClick(Sender: TObject);
    procedure btnOpenTransferClick(Sender: TObject);
    procedure btnNewTransferClick(Sender: TObject);
    procedure btnPCPathClick(Sender: TObject);
    procedure cbxProcessorsChange(Sender: TObject);
    procedure grdPaymentSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbxProcessorChange(Sender: TObject);
    procedure cbxProcessorExit(Sender: TObject);
    procedure btnPONewClick(Sender: TObject);
    procedure btnPOOpenClick(Sender: TObject);
    procedure btnPODelClick(Sender: TObject);
    procedure cbxPaperTypeChange(Sender: TObject);
    procedure chkUSBClick(Sender: TObject);
    procedure btnDelStoreFooterClick(Sender: TObject);
    procedure btnOpenStoreFooterClick(Sender: TObject);
    procedure cxCardTypeChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure btnRepairNewClick(Sender: TObject);
    procedure btnRepairOpenClick(Sender: TObject);
    procedure btnRepairDelClick(Sender: TObject);
    procedure btnReceivingNewClick(Sender: TObject);
    procedure btnReceivingOpenClick(Sender: TObject);
    procedure btnReceivingDelClick(Sender: TObject);
    procedure btnSOEditClick(Sender: TObject);
    procedure btnSODelClick(Sender: TObject);
    procedure btnSONewClick(Sender: TObject);
    procedure btnSADelClick(Sender: TObject);
    procedure btnSAEditClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure chkScaleClick(Sender: TObject);
    procedure btnPetPathClick(Sender: TObject);
    procedure btnBBTestConnectionClick(Sender: TObject);
    procedure pgChargeChange(Sender: TObject);
    procedure cbbGCProcessorCloseUp(Sender: TObject);
    procedure cbxProcessorsCloseUp(Sender: TObject);
  private
    isOfficeMode: Boolean;
    fIniFile    : TIniFile;
    fMode       : Integer;

    sIDCashReg,
    sAPayType,
    sAProcessor,
    sAMerchNumber,
    sAReceiptCopies,
    sCardID: String;
    procedure RefreshExamples;
    procedure LoadTemplates;
    function getIniColor(Section:String):String;
    procedure setIniColor(Section, Colors:String);
    procedure RefreshProcessor;
    procedure BuildProcessor;
    procedure SaveProcessor;
    procedure RefreshPrice;
    procedure SavePrice;
  public
    procedure Start(Mode: Integer);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, MenuPrincipal, cxLookAndFeels,
     cxStyleSheetEditor, uFrmPreviewTicket, uSystemConst, uParamFunctions,
     uTranslateScript, uPrintReceipt, uFrmPrintDelivery, uFrmEstimatedPrint,
     uFrmPagaVendedor, uFrmPrintTranfer, ADODB, uFrmPrintPO, Printers,
     uFrmPrintRepair, uFrmPrintReceiving, uFrmServiceOrderPrint,
     uFrmPrintStoreAccount, uGynboSyncClasses, uOperationSystem;

{$R *.DFM}

procedure TFchParameter.setIniColor(Section, Colors:String);
begin

   FIniFile.WriteString(Section, 'Colors', Colors);
   
end;

function TFchParameter.getIniColor(Section:String):String;
begin

   if not fIniFile.SectionExists(Section) then
      Exit;

   Result := fIniFile.ReadString(Section, 'Colors', '');

end;

procedure TFchParameter.LoadTemplates;
var
  i : Integer;
  fIniSection : TStringList;
  FileMenuColor: Boolean;
begin

  FileMenuColor := FileExists(DM.fSystem.LocalPath + TEMPLATE_FILE);

  fIniSection := nil;
  try
    fIniSection := TStringList.Create;
    fIniFile    := TIniFile.Create(DM.fSystem.LocalPath + TEMPLATE_FILE);

    if not FileMenuColor then
      begin
        setIniColor('Green','MH=clWhite;MTH=clBlack;MBG=clGreen;BKG=$00ECFFEC;SMF=$00408000;SMFH=clRed;PSFT=$00408000;PSYS=$00408000;PHLP=$00408000;');
        setIniColor('Orange','MH=clWhite;MTH=clBlack;MBG=$000080FF;BKG=$00F0F8FF;SMF=$000080FF;SMFH=clBlue;PSFT=clTeal;PSYS=$008080FF;PHLP=$00C08000;');
        setIniColor('Blue','MH=clWhite;MTH=clBlack;MBG=$00804000;BKG=clWhite;SMF=clNavy;SMFH=clGreen;PSFT=clTeal;PSYS=$008080FF;PHLP=$00C08000;');
        setIniColor('Gray','MH=clWhite;MTH=clBlack;MBG=clGray;BKG=clWhite;SMF=clGray;SMFH=clRed;PSFT=clGray;PSYS=clGray;PHLP=clGray;');
        setIniColor('Aqua','MH=$00B78900;MTH=clWhite;MBG=$00FFF8E6;BKG=$00B78900;SMF=clWhite;SMFH=$00FFF8E6;PSFT=$00FFF8E6;PSYS=$00FFF8E6;PHLP=$00FFF8E6;');
        setIniColor('Yellow','MH=clBlack;MTH=clBlack;MBG=clYellow;BKG=$00F0FFFF;SMF=$00000040;SMFH=clSilver;PSFT=$FFFFFFFF;PSYS=clBlack;PHLP=clBlack;');
      end;

    fIniFile.ReadSections(fIniSection);

    for i := 0 to fIniSection.Count -1 do
      cbxColor.Items.Add(fIniSection[i]);
  finally
    FreeAndNil(fIniSection);
    end;
    
end;

procedure TFchParameter.Start(Mode:Integer);
var
  i : Integer;
begin
  fMode := Mode;
  isOfficeMode := (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE);

  if fMode <> PARAM_OPEN_ALL then
  begin
    For i:=PARAM_OPEN_CASHREG to (PARAM_OPEN_SCALE+1) do
      pgParam.Pages[i].TabVisible := False;
    pgParam.Pages[fMode].TabVisible := True;
    if fMode = PARAM_OPEN_MENU then
       begin
       LoadTemplates;
       pgParam.Pages[PARAM_OPEN_GRID].TabVisible := True;
       end
  end
  else
    fMode := PARAM_OPEN_CASHREG;

  if tsInvoiceOptions.TabVisible then
     tsInvoiceOptions.TabVisible := isOfficeMode;

  if tsPurchase.TabVisible then
     tsPurchase.TabVisible := isOfficeMode;

  chkViewOtherRegister.Visible := isOfficeMode;
  chkViewOtherStore.Visible    := isOfficeMode;
  ldDefStore.Visible           := isOfficeMode;
  scDefaultSaleStore.Visible   := isOfficeMode;

  tsPetCenter.TabVisible       := (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '');

  ShowModal;
end;


procedure TFchParameter.FormShow(Sender: TObject);
var
  buildInfo: String;
begin
  inherited;

  // Seta os parametros locais da maquina
  with TRegistry.Create do
    begin

      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey := HKEY_LOCAL_MACHINE;
        
      OpenKey(REGISTRY_PATH, True);
      cmbCashReg.LookUpValue         := IntToStr(ReadInteger('DefaultCashRegID'));
      sIDCashReg                     := cmbCashReg.LookUpValue;
      cmbShippingRegister.LookUpValue:= IntToStr(ReadInteger('IDShippingReg'));
      edtSHPacking.Text              := ReadString('ShippingPackingRep');
      edtSHPickTicket.Text           := ReadString('ShippingPickRep');
      EditOpenCode.Text              := ReadString('CashRegOpenCodeStr');
      edtAfterPrintCode.Text         := ReadString('CashRegAfterPrintStr');
      chkViewOtherRegister.Checked   := ReadBool('CashRegViewOthers');
      chkViewOtherStore.Checked      := ReadBool('CashRegViewOthersStores');
      cbxXpressType.ItemIndex        := ReadInteger('XPressSaleType');
      cmbStore.LookUpValue           := IntToStr(ReadInteger('DefaultStoreID'));
      scDefaultSaleStore.LookUpValue := IntToStr(ReadInteger('DefaultSaleStoreID'));
      scMedia.LookUpValue            := IntToStr(ReadInteger('DefaultMediaID'));
      cbPrintReceipt.Checked         := ReadBool('PrintReceipt');
      cbOpenCashReg.Checked          := ReadBool('OpenCashReg');
      cbxLanguage.ItemIndex          := (ReadInteger('DefaultLanguage')-1);
      edtDecimal.Text                := ReadString('DefaultDecimalSeparator');
      edtThousand.Text               := ReadString('DefaultThousandSeparator');
      cbxDateFormat.Text             := ReadString('DefaultDateFormat');
      edtXSaleImg.Text               := ReadString('XpressSaleImage');
      cbxFontName.Text               := ReadString('PrinterFontName');
      udFont.Position                := ReadInteger('PrinterFontSize');
      udSpaceLine.Position           := ReadInteger('PrinterLineSpace');
      upLineWidth.Position           := ReadInteger('PrinterLineWidth');
      pnlMenuHighlight.Color         := StringToColor(ReadString('MenuHighlightColor'));
      pnlMenuTextHighlight.Color     := StringToColor(ReadString('MenuHighlightTextColor'));
      pnlMenuBackGround.Color        := StringToColor(ReadString('MenuBackgroundColor'));
      pnlBackGroundColor.Color       := StringToColor(ReadString('BackgroundColor'));
      pnlSubMenuFontColor.Color      := StringToColor(ReadString('SubMenuTextColor'));
      pnlSMHighlightFontColor.Color  := StringToColor(ReadString('SubMenuHighlightColor'));
      pnlShorcutsColor.Color         := StringToColor(ReadString('PanelShortcutsColor'));
      pnlSystemColor.Color           := StringToColor(ReadString('PanelSystemColor'));
      pnlHelpColor.Color             := StringToColor(ReadString('PanelHelpColor'));
      edtLogo.Text                   := ReadString('CompanyLogo');
      memOBSInv.Text                 := ReadString('InvObsText');
      cbxPaperType.ItemIndex         := ReadInteger('PaperType');
      cbxPaperTypeChange(Self);
      cbxPrinterPort.ItemIndex       := (ReadInteger('PrinterType')-1);
      cbxPrinterPortChange(Self);
      chkPreview.Checked             := ReadBool('PreviewA4');
      udCopies.Position              := ReadInteger('NumCopiesA4');
      EdtHoldReportPath.Text         := ReadString('ReportPathA4');
      edtReportFooter.Text           := ReadString('ReportPathA4Footer');
      cbxInvoicePrinter.Text         := ReadString('InvoiceReportPrinter');
      chkUSB.Checked                 := ReadBool('UseUSBPrinter');
      edtUSBOpenCode.Text            := ReadString('USBOpenDraw');
      edtUSBCutCode.Text             := ReadString('USBCutPaper');
      pnlUSB.Visible                 := chkUSB.Checked;
      EdtBudgetReportPath.Text       := ReadString('BudgetReportPathA4');
      chkBudgetCommis.Checked        := ReadBool('BudgetReportPreview');
      udBudget.Position              := ReadInteger('BudgetReportNumCopy');
      cbxBudgetPrinter.Text          := ReadString('BudgetReportPrinter');
      EdtDeveliryReportPath.Text     := ReadString('DeliveryReportPathA4');
      chkDeliveryCommis.Checked      := ReadBool('DeliveryReportPreview');
      udDelivery.Position            := ReadInteger('DeliveryReportNumCopy');
      cbxDeliveryPrinter.Text        := ReadString('DeliveryReportPrinter');
      EdtTransferReportPath.Text     := ReadString('TransferReportPathA4');
      chkPreviewTransfer.Checked     := ReadBool('TransferReportPreview');
      chkSuggestPrintTransf.Checked  := ReadBool('TransferSuggestPrint');
      udTransfer.Position            := ReadInteger('TransferReportNumCopy');
      cbxTransferPrinter.Text        := ReadString('TransferReportPrinter');
      edtPOReportPath.Text           := ReadString('POReportPathA4');
      chkPreviewPO.Checked           := ReadBool('POReportPreview');
      udPO.Position                  := ReadInteger('POReportNumCopy');
      cbxPOPrinter.Text              := ReadString('POReportPrinter');
      cbxPOEmailFile.ItemIndex       := ReadInteger('POEmailFile');
      edtCommisReportPath.Text       := ReadString('CommissionReportPathA4');
      chkPreviewCommis.Checked       := ReadBool('CommissionReportPreview');
      udCommis.Position              := ReadInteger('CommissionReportNumCopy');
      cbxCommisPrinter.Text          := ReadString('CommissionReportPrinter');
      edtRepairReportPath.Text       := ReadString('RepairReportPathA4');
      chkPreviewRepair.Checked       := ReadBool('RepairReportPreview');
      udRepair.Position              := ReadInteger('RepairReportNumCopy');
      cbxRepairPrinter.Text          := ReadString('RepairReportPrinter');
      chkSOPreview.Checked           := ReadBool('ServiceReportPreview');
      chkSAPreview.Checked           := ReadBool('StoreAccReportPreview');
      upSO.Position                  := ReadInteger('ServiceReportNumCopy');
      upSA.Position                  := ReadInteger('StoreAccReportNumCopy');
      edtSOReportPath.Text           := ReadString('ServiceReportPathA4');
      edtSAReportPath.Text           := ReadString('StoreAccReportPathA4');
      cbxSOPrinter.Text              := ReadString('ServiceReportPrinter');
      cbxSAPrinter.Text              := ReadString('StoreAccReportPrinter');
      UPFixItem.Position             := ReadInteger('PrintItemsPerPage');
      scCategoria.LookUpValue        := ReadString('ServiceDefaulCateg');
      edtReceivingReportPath.Text    := ReadString('ReceivingReportPathA4');
      chkPreviewReceiving.Checked    := ReadBool('ReceivingReportPreview');
      udReceiving.Position           := ReadInteger('ReceivingReportNumCopy');
      cbxReceivingPrinter.Text       := ReadString('ReceivingReportPrinter');
      chkDisplayBudget.Checked       := ReadBool('DisplayBudget');
      chkDisplayPOSHold.Checked      := ReadBool('DisplayPOSHold');
      chkDisplayHold.Checked         := ReadBool('DisplayHold');
      chkDisplaySearch.Checked       := ReadBool('DisplaySearch');
      chkDisplayCloseDay.Checked     := ReadBool('DisplayCloseDay');
      chkDisplayFinalize.Checked     := ReadBool('DisplayFinalize');
      scPurchaseStore.LookUpValue    := IntToStr(ReadInteger('PurchaseDefaultStoreID'));
      edtPCTimeOut.Text              := IntToStr(ReadInteger('PCChargeTimeOut'));
      edtPCPrintNum.Text             := IntToStr(ReadInteger('PCChargePrintNum'));
      edtPCLastValidDate.Text        := IntToStr(ReadInteger('PCChargeLastDate'));
      edtPort.Text                   := IntToStr(ReadInteger('PCChargePort'));
      edtPCUser.Text                 := ReadString('PCChargeUser');
      edtPCPath.Text                 := ReadString('PCChargePath');
      edtServer.Text                 := ReadString('PCChargeServer');
      cbxProcessors.ItemIndex        := ReadInteger('ProcessorType');
      chkMultProcessor.Checked       := ReadBool('PCChargeMultTrans');
      edtMerIPPort.Text              := IntToStr(ReadInteger('MercuryIPPort'));
      edtMerchantID.Text             := ReadString('MercuryMerchatID');
      edtMerIPAddress.Text           := ReadString('MercuryIPs');
      edtMerConTimeOut.Text          := IntToStr(ReadInteger('MercuryConnectTimeout'));
      edtResponseTimeout.Text        := IntToStr(ReadInteger('MercuryResponseTimeout'));
      edtBBStoreNum.Text             := IntToStr(ReadInteger('GynboStoreNum'));
      edtBBUrl.Text                  := ReadString('GynboUrl');
      edtBBTerminal.Text             := ReadString('GynboTerminal');
      edtBBPartnerKey.Text           := ReadString('GynboPartnerKey');
      edtBBUrlPW.Text                := ReadString('GynboUrlPW');
      edtBBUrlUser.Text              := ReadString('GynboUrlUser');
      edtBBPartnerAcc.Text           := ReadString('PartnerAcc');
      chkWindowMode.Checked          := ReadBool('MRWindowMode');
      chkAskUser.Checked             := ReadBool('AskSalesPerson');
      DeviceBox.ItemIndex            := DeviceBox.Items.IndexOf(ReadString('PinPadDevice'));
      BaudBox.ItemIndex              := BaudBox.Items.IndexOf(ReadString('PinPadBaud'));
      ParityBox.ItemIndex            := ParityBox.Items.IndexOf(ReadString('PinPadParity'));
      CommBox.Text                   := ReadString('PinPadComm');
      EdtEncryptMe.Text              := ReadString('PinEncryptMethod');
      edtPinTimeOut.Text             := ReadString('PinTimeOut');
      edtPollDisplayIP.Text          := ReadString('PollDisplayIP');
      edtPollDisplayPort.Text        := IntToStr(ReadInteger('PollDisplayPort'));
      chkClearSale.Checked           := ReadBool('PollDisplayClearSale');
      edtPetIP.Text                  := ReadString('PetCenterIP');
      edtPetPort.Text                := IntToStr(ReadInteger('PetCenterPort'));
      chkScale.Checked               := ReadBool('ScaleCheck');
      cbxScaleType.ItemIndex         := ReadInteger('ScaleType');

      cbxScaleType.Visible  := chkScale.Checked;

      if ReadString('PinPadDataBits') = '7' then
        SevRadio.Checked := True
      else
        EightRadio.Checked := True;
      RefreshProcessor;
      Free;
    end;

  pnlSuperMarketImg.Visible   := (cbxXpressType.ItemIndex=1);
  pnlFontSetup.Visible        := (cbxPrinterPort.ItemIndex=2);
  pgParam.ActivePageIndex     := fMode;

  RefreshPrice;
  RefreshExamples;
end;

procedure TFchParameter.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFchParameter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(fIniFile) then
     FreeAndNil(fIniFile);
  Action := caFree;
end;

procedure TFchParameter.btCloseClick(Sender: TObject);
var
  buildInfo: String;
begin
  inherited;

  if (MsgBox(MSG_QST_CONFIRM_CHANGE_LOCAL, vbYesNo + vbQuestion) = vbYes) then
  begin
    // Teste de chash register ja sendo usado por outro usuario
    if fMode = PARAM_OPEN_CASHREG then
      if (cmbCashReg.LookUpValue <> '') and (cmbCashReg.LookUpValue <> sIDCashReg) then
        if (UpperCase(DM.DescCodigo(['IDCashRegister'], [cmbCashReg.LookUpValue],
            'dbo.CashRegister', 'IsAssociated')) = 'TRUE') and
           (MsgBox(MSG_QST_CASH_IS_IN_USER, vbYesNo + vbQuestion) = vbNo) then
          Exit;

    // Abre o registry
    With TRegistry.Create( KEY_READ OR KEY_WRITE OR $0100 ) do
    try

      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey := HKEY_LOCAL_MACHINE;

      OpenKey(REGISTRY_PATH, True);
      if Trim(cmbCashReg.LookUpValue) <> '' then
        WriteInteger('DefaultCashRegID', StrToInt(cmbCashReg.LookUpValue));
      if Trim(cmbShippingRegister.LookUpValue) <> '' then
        WriteInteger('IDShippingReg', StrToInt(cmbShippingRegister.LookUpValue));
      WriteString('ShippingPackingRep', Trim(edtSHPacking.text));
      WriteString('ShippingPickRep', Trim(edtSHPickTicket.text));
      if Trim(cmbStore.LookUpValue) <> '' then
        WriteInteger('DefaultStoreID', StrToInt(cmbStore.LookUpValue));
      WriteInteger('DefaultMediaID', StrToIntDef(scMedia.LookUpValue,-1));
      WriteString('CashRegOpenCodeStr', Trim(EditOpenCode.text));
      WriteString('CashRegAfterPrintStr', Trim(edtAfterPrintCode.text));
      WriteBool('PrintReceipt', cbPrintReceipt.Checked);
      WriteBool('OpenCashReg', cbOpenCashReg.Checked);
      WriteInteger('DefaultLanguage', cbxLanguage.ItemIndex+1);
      WriteString('DefaultDecimalSeparator', edtDecimal.Text);
      WriteString('DefaultThousandSeparator', edtThousand.Text);
      WriteString('DefaultDateFormat', cbxDateFormat.Text);
      WriteBool('AskSalesPerson', chkAskUser.Checked);

      //Invoice Type
      WriteString('InvObsText', memOBSInv.Text);
      DM.fInvoice.OBSText := memOBSInv.Text;
      WriteInteger('XPressSaleType', cbxXpressType.ItemIndex);
      DM.fInvoice.XpressSaleType := cbxXpressType.ItemIndex;
      if (Trim(edtXSaleImg.Text)<>'') or (FileExists(edtXSaleImg.Text)) then
      begin
        WriteString('XpressSaleImage', edtXSaleImg.Text);
        DM.fInvoice.XpressSaleImage := edtXSaleImg.Text;
      end
      else
        WriteString('XpressSaleImage', '');
      WriteBool('DisplayBudget', chkDisplayBudget.Checked);
      DM.fInvoice.DisplayBudget  := chkDisplayBudget.Checked;
      WriteBool('DisplayHold', chkDisplayHold.Checked);
      DM.fInvoice.DisplayHold := chkDisplayHold.Checked;
      WriteBool('DisplaySearch', chkDisplaySearch.Checked);
      DM.fInvoice.DisplaySearch := chkDisplaySearch.Checked;
      WriteBool('DisplayCloseDay', chkDisplayCloseDay.Checked);
      DM.fInvoice.DisplayCloseDay := chkDisplayCloseDay.Checked;
      WriteBool('DisplayFinalize', chkDisplayFinalize.Checked);
      DM.fInvoice.DisplayFinalize := chkDisplayFinalize.Checked;
      WriteBool('DisplayPOSHold', chkDisplayPOSHold.Checked);
      DM.fInvoice.DisplayPOSHold := chkDisplayPOSHold.Checked;

      //Printer
      WriteInteger('PrinterType', cbxPrinterPort.ItemIndex+1);
      WriteString('PrinterPort', Trim(cbxPrinterPort.Text));
      WriteString('PrinterFontName', Trim(cbxFontName.Text));
      WriteInteger('PrinterFontSize', StrToInt(edtFontSize.Text));
      WriteInteger('PrinterLineSpace', StrToInt(edtLinespace.Text));
      WriteInteger('PrinterLineWidth', StrToInt(edtLineWidth.Text));
      WriteInteger('PaperType', cbxPaperType.ItemIndex);
      WriteBool('PreviewA4', chkPreview.Checked);
      WriteInteger('NumCopiesA4', udCopies.Position);
      WriteString('ReportPathA4', Trim(EdtHoldReportPath.Text));
      WriteString('ReportPathA4Footer', Trim(edtReportFooter.Text));
      WriteString('InvoiceReportPrinter', cbxInvoicePrinter.Text);
      WriteBool('UseUSBPrinter', chkUSB.Checked);
      WriteString('USBOpenDraw', edtUSBOpenCode.Text);
      WriteString('USBCutPaper', edtUSBCutCode.Text);
      WriteString('BudgetReportPathA4', Trim(EdtBudgetReportPath.Text));
      WriteBool('BudgetReportPreview', chkBudgetCommis.Checked);
      WriteInteger('BudgetReportNumCopy', udBudget.Position);
      WriteString('BudgetReportPrinter', cbxBudgetPrinter.Text);
      WriteString('DeliveryReportPathA4', Trim(EdtDeveliryReportPath.Text));
      WriteBool('DeliveryReportPreview', chkDeliveryCommis.Checked);
      WriteInteger('DeliveryReportNumCopy', udDelivery.Position);
      WriteString('DeliveryReportPrinter', cbxDeliveryPrinter.Text);
      WriteString('TransferReportPathA4', Trim(EdtTransferReportPath.Text));
      WriteBool('TransferReportPreview', chkPreviewTransfer.Checked);
      WriteBool('TransferSuggestPrint', chkSuggestPrintTransf.Checked);
      WriteInteger('TransferReportNumCopy', udTransfer.Position);
      WriteString('TransferReportPrinter', cbxTransferPrinter.Text);
      WriteString('POReportPathA4', Trim(edtPOReportPath.Text));
      WriteBool('POReportPreview', chkPreviewPO.Checked);
      WriteInteger('POReportNumCopy', udPO.Position);
      WriteString('POReportPrinter', cbxPOPrinter.Text);
      WriteInteger('POEmailFile', cbxPOEmailFile.ItemIndex);
      WriteString('CommissionReportPathA4', Trim(edtCommisReportPath.Text));
      WriteBool('CommissionReportPreview', chkPreviewCommis.Checked);
      WriteInteger('CommissionReportNumCopy', udCommis.Position);
      WriteString('CommissionReportPrinter', cbxCommisPrinter.Text);
      WriteString('RepairReportPathA4', Trim(edtRepairReportPath.Text));
      WriteBool('RepairReportPreview', chkPreviewRepair.Checked);
      WriteInteger('RepairReportNumCopy', udRepair.Position);
      WriteString('RepairReportPrinter', cbxRepairPrinter.Text);
      WriteString('ReceivingReportPathA4', Trim(edtReceivingReportPath.Text));
      WriteBool('ReceivingReportPreview', chkPreviewReceiving.Checked);
      WriteInteger('ReceivingReportNumCopy', udReceiving.Position);
      WriteString('ReceivingReportPrinter', cbxReceivingPrinter.Text);
      WriteString('ServiceReportPathA4', Trim(edtSOReportPath.Text));
      WriteString('StoreAccReportPathA4', Trim(edtSAReportPath.Text));
      WriteBool('ServiceReportPreview', chkSOPreview.Checked);
      WriteBool('StoreAccReportPreview', chkSAPreview.Checked);
      WriteInteger('ServiceReportNumCopy', upSO.Position);
      WriteInteger('StoreAccReportNumCopy', upSA.Position);
      WriteString('ServiceReportPrinter', cbxSOPrinter.Text);
      WriteString('StoreAccReportPrinter', cbxSAPrinter.Text);
      WriteString('ServiceDefaulCateg', scCategoria.LookUpValue);
      WriteInteger('PrintItemsPerPage', UPFixItem.Position);

      DM.fPrintReceipt.PrinterType        := cbxPrinterPort.ItemIndex+1;
      DM.fPrintReceipt.PrinterPort        := Trim(cbxPrinterPort.Text);
      DM.fPrintReceipt.PrinterFontName    := Trim(cbxFontName.Text);
      DM.fPrintReceipt.PrinterFontSize    := StrToInt(edtFontSize.Text);
      DM.fPrintReceipt.PrinterLineSpace   := StrToInt(edtLinespace.Text);
      DM.fPrintReceipt.PrinterLineWidth   := StrToInt(edtLineWidth.Text);
      DM.fPrintReceipt.PaperType          := cbxPaperType.ItemIndex;
      DM.fPrintReceipt.Preview            := chkPreview.Checked;
      DM.fPrintReceipt.NumOfCopies        := udCopies.Position;
      DM.fPrintReceipt.ReportPath         := Trim(EdtHoldReportPath.Text);
      DM.fPrintReceipt.DeliveryReportPath := Trim(EdtDeveliryReportPath.Text);
      DM.fPrintReceipt.BudgetReportPath   := Trim(EdtBudgetReportPath.Text);
      DM.fPrintReceipt.TransferReportPath := Trim(EdtTransferReportPath.Text);
      DM.fPrintReceipt.ServiceReportPath  := Trim(edtSOReportPath.Text);
      DM.fPrintReceipt.PrintItemsPerPage  := UPFixItem.Position;

      //Menu
      WriteString('MenuHighlightColor', ColorToString(pnlMenuHighlight.Color));
      WriteString('MenuHighlightTextColor', ColorToString(pnlMenuTextHighlight.Color));
      WriteString('MenuBackgroundColor', ColorToString(pnlMenuBackGround.Color));
      WriteString('BackgroundColor', ColorToString(pnlBackGroundColor.Color));
      WriteString('SubMenuTextColor', ColorToString(pnlSubMenuFontColor.Color));
      WriteString('SubMenuHighlightColor', ColorToString(pnlSMHighlightFontColor.Color));
      WriteString('PanelShortcutsColor', ColorToString(pnlShorcutsColor.Color));
      WriteString('PanelSystemColor', ColorToString(pnlSystemColor.Color));
      WriteString('PanelHelpColor', ColorToString(pnlHelpColor.Color));
      WriteString('CompanyLogo', edtLogo.Text);
      WriteBool('MRWindowMode', chkWindowMode.Checked);

      //PCCharge
      WriteString('PCChargeServer', edtServer.Text);
      WriteString('PCChargeUser', edtPCUser.Text);
      WriteString('PCChargePath', edtPCPath.Text);
      WriteInteger('PCChargeTimeOut', StrToIntDef(edtPCTimeOut.Text, 10));
      WriteInteger('PCChargePrintNum', StrToIntDef(edtPCPrintNum.Text, 1));
      WriteInteger('PCChargePort', StrToIntDef(edtPort.Text, 0));
      WriteInteger('PCChargeLastDate', StrToIntDef(edtPCLastValidDate.Text, 12));
      WriteInteger('ProcessorType', cbxProcessors.ItemIndex);
      WriteBool('PCChargeMultTrans', chkMultProcessor.Checked);

      //Mercury
      WriteString('MercuryIPs', edtMerIPAddress.Text);
      WriteInteger('MercuryIPPort', StrToInt(edtMerIPPort.Text));
      WriteString('MercuryMerchatID', edtMerchantID.Text);
      WriteInteger('MercuryConnectTimeout', StrToInt(edtMerConTimeOut.Text));
      WriteInteger('MercuryResponseTimeout', StrToInt(edtResponseTimeout.Text));

      //amfsouza 12.30.2011 - settings to Mercury Gift Card.
      WriteInteger('GiftProcessor', cbbGCProcessor.ItemIndex);

      //amfsouza 12.23.2011 - settings to Mercury Gift Card.
      WriteString('MercuryGiftIPs', edtMercIPAddress.Text);
      WriteInteger('MercuryGiftIPPort', StrToInt(edtMercGiftPort.Text));
      WriteString('MercuryGiftMerchantID', edtMerchantID.Text);
//      WriteInteger('MercuryConnectTimeout', StrToInt(edtMerConTimeOut.Text));
//      WriteInteger('MercuryResponseTimeout', StrToInt(edtResponseTimeout.Text));

      //Gynbo
      WriteInteger('GynboStoreNum', StrToIntDef(edtBBStoreNum.Text, 0));
      WriteString('GynboUrl', edtBBUrl.Text);
      WriteString('GynboTerminal', edtBBTerminal.Text);
      WriteString('GynboPartnerKey', edtBBPartnerKey.Text);
      WriteString('GynboUrlPW', edtBBUrlPW.Text);
      WriteString('GynboUrlUser', edtBBUrlUser.Text);
      WriteString('PartnerAcc', edtBBPartnerAcc.Text);

      //Poll Display
      WriteString('PollDisplayIP', edtPollDisplayIP.Text);
      WriteInteger('PollDisplayPort', StrToIntDef(edtPollDisplayPort.Text, 9091));
      WriteBool('PollDisplayClearSale', chkClearSale.Checked);

      //PetCenter
      WriteString('PetCenterIP', edtPetIP.Text);
      WriteInteger('PetCenterPort', StrToIntDef(edtPetPort.Text, 1555));

      //PinPad
      WriteString('PinPadDevice', DeviceBox.Items.Strings[DeviceBox.ItemIndex]);
      WriteString('PinPadBaud', BaudBox.Items.Strings[BaudBox.ItemIndex]);
      WriteString('PinPadParity', ParityBox.Items.Strings[ParityBox.ItemIndex]);
      if SevRadio.Checked then
        WriteString('PinPadDataBits', '7')
      else
        WriteString('PinPadDataBits', '8');
      WriteString('PinPadComm', CommBox.Text);
      WriteString('PinEncryptMethod', EdtEncryptMe.Text);
      WriteString('PinTimeOut', edtPinTimeOut.Text);

      //Scale
      WriteInteger('ScaleType', cbxScaleType.ItemIndex);
      WriteBool('ScaleCheck', chkScale.Checked);

      SaveProcessor;
      SavePrice;

      //Campos para modulo de Office
      if isOfficeMode then
      begin
        if chkViewOtherRegister.Visible then
          WriteBool('CashRegViewOthers', chkViewOtherRegister.Checked);

        if chkViewOtherStore.Visible then
          WriteBool('CashRegViewOthersStores', chkViewOtherStore.Checked);

        if Trim(scDefaultSaleStore.LookUpValue) <> '' then
          WriteInteger('DefaultSaleStoreID', StrToIntDef(scDefaultSaleStore.LookUpValue, 1))
        else
          WriteInteger('DefaultSaleStoreID', -1);

        if Trim(scPurchaseStore.LookUpValue) <> '' then
          WriteInteger('PurchaseDefaultStoreID', StrToIntDef(scPurchaseStore.LookUpValue, 1))
        else
          WriteInteger('PurchaseDefaultStoreID', -1);
      end
      else
      begin
        WriteBool('CashRegViewOthers', False);
        if Trim(cmbStore.LookUpValue) <> '' then
        begin
          WriteInteger('DefaultSaleStoreID', StrToIntDef(cmbStore.LookUpValue, 1));
          WriteInteger('PurchaseDefaultStoreID', StrToIntDef(cmbStore.LookUpValue, 1));
        end;
      end;
    finally
      Free;
    end;

    btnApplay.Click;

    //Nao perguntar msg para esses parametros
    if not (pgParam.ActivePage.PageIndex in [PARAM_OPEN_PRINTER, PARAM_OPEN_INVOICE,
                                             PARAM_OPEN_MENU, PARAM_OPEN_GRID,
                                             PARAM_OPEN_PURCHASE]) then
    begin
      //Update Database with Language Scrip
      if (DMGlobal.IDLanguage <> cbxLanguage.ItemIndex+1) then
        if (MsgBox(MSG_QST_CONFIRM_CHANGE_LANG, vbYesNo + vbSuperCritical) = vbYes) then
            TranslateDatabase(cbxLanguage.ItemIndex+1, DM.quFreeSQL);
          MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly + vbInformation);
    end;

    Close;
  end;
end;

procedure TFchParameter.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2040);
end;

procedure TFchParameter.RefreshExamples;
begin
  lbEx1.Caption := '1'+edtThousand.Text+'000'+edtDecimal.Text+'00';
  lbEx2.Caption := FormatDateTime(cbxDateFormat.Text ,now);
end;

procedure TFchParameter.cbxDateFormatChange(Sender: TObject);
begin
  inherited;
  RefreshExamples;
end;

procedure TFchParameter.SpeedButton1Click(Sender: TObject);
begin
  inherited;

  OP.Filter := FILE_IMAGEM;
  
  if OP.Execute then
     edtXSaleImg.Text := OP.FileName;
end;

procedure TFchParameter.cbxXpressTypeChange(Sender: TObject);
begin
  inherited;
  pnlSuperMarketImg.Visible  := (cbxXpressType.ItemIndex=1);
end;

procedure TFchParameter.FormCreate(Sender: TObject);
begin
  inherited;
  cbxFontName.Items := Screen.Fonts;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sAPayType       := 'Payment Type';
      sAProcessor     := 'Processor';
      sAMerchNumber   := 'Merchant Num';
      sAReceiptCopies := '# Copies';
      sCardID         := 'Card ID';
    end;

    LANG_PORTUGUESE:
    begin
      sAPayType       := 'Tipo de Pagamento';
      sAProcessor     := 'Processador';
      sAMerchNumber   := 'Número do Estabelecimento';
      sAReceiptCopies := 'N. Vias';
      sCardID         := 'ID Cartao';
    end;

    LANG_SPANISH:
    begin
      sAPayType       := 'Tipo Del Pago';
      sAProcessor     := 'Procesador';
      sAMerchNumber   := 'Número Mercantil';
      sAReceiptCopies := 'N. Copias';
      sCardID         := 'ID Tarjta'
    end;
  end;

  //amfsouza 12.29.2011
  pgCharge.ActivePage := tsCashInfo;
  cbxTransferPrinter.Items  := Printer.Printers;
  cbxPOPrinter.Items        := Printer.Printers;
  cbxCommisPrinter.Items    := Printer.Printers;
  cbxDeliveryPrinter.Items  := Printer.Printers;
  cbxBudgetPrinter.Items    := Printer.Printers;
  cbxInvoicePrinter.Items   := Printer.Printers;
  cbxRepairPrinter.Items    := Printer.Printers;
  cbxReceivingPrinter.Items := Printer.Printers;
  cbxSOPrinter.Items        := Printer.Printers;
  cbxSAPrinter.Items        := Printer.Printers;
  edtMercGiftPort.Text := '0';
  edtMercMechantID.Text := edtMerchantID.Text;
  edtMercIPAddress.Text := 'NO_DNS';
  cbbGCProcessorCloseUp(sender);
end;

procedure TFchParameter.cbxFontNameChange(Sender: TObject);
begin
  inherited;
  lbFontExample.Font.Name := cbxFontName.Text;
  lbFontExample.Font.Size := StrToInt(edtFontSize.Text);
end;

procedure TFchParameter.cbxPrinterPortChange(Sender: TObject);
begin
  inherited;
  pnlFontSetup.Visible := (cbxPrinterPort.ItemIndex=2);
  pnlWinCommand.Visible := pnlFontSetup.Visible or (cbxPaperType.ItemIndex = 0);
  if (cbxPaperType.ItemIndex = 1) and (cbxPrinterPort.ItemIndex <> 2) then
    chkUSB.Checked := False;
end;

procedure TFchParameter.pnlMenuHighlightClick(Sender: TObject);
begin
  inherited;
  CD.Color := TPanel(Sender).Color;
  if CD.Execute then
     TPanel(Sender).Color := CD.Color;
end;

procedure TFchParameter.cbxColorChange(Sender: TObject);
var
 r : String;
begin
  inherited;
  Case cbxColor.ItemIndex of
    //Default
    -1: btnSaveColors.Enabled         := True;
    0 : begin
        btnSaveColors.Enabled         := False;
        pnlMenuHighlight.Color        := clWhite;
        pnlMenuTextHighlight.Color    := clBlack;
        pnlMenuBackGround.Color       := $00B78900;
        pnlBackGroundColor.Color      := clWhite;
        pnlSubMenuFontColor.Color     := $00B78900;
        pnlSMHighlightFontColor.Color := $000080FF;
        pnlShorcutsColor.Color        := clTeal;
        pnlSystemColor.Color          := $008080FF;
        pnlHelpColor.Color            := $00C08000;
        end;
    else
        begin
        r := getIniColor(cbxColor.Text);
        if r = '' then
           Exit;
        btnSaveColors.Enabled         := True;
        pnlMenuHighlight.Color        := StringToColor(ParseParam(r, COLOR_MENU_HIGHLIGHT));
        pnlMenuTextHighlight.Color    := StringToColor(ParseParam(r, COLOR_MENU_TEXT_HIGHLIGHT));
        pnlMenuBackGround.Color       := StringToColor(ParseParam(r, COLOR_MENU_BACKGROUND));
        pnlBackGroundColor.Color      := StringToColor(ParseParam(r, COLOR_BACKGROUND));
        pnlSubMenuFontColor.Color     := StringToColor(ParseParam(r, COLOR_SUB_MENU_FONT));
        pnlSMHighlightFontColor.Color := StringToColor(ParseParam(r, COLOR_SUB_MENU_FONT_HIGHLIGHT));
        pnlShorcutsColor.Color        := StringToColor(ParseParam(r, COLOR_PANEL_SHORTCUTS));
        pnlSystemColor.Color          := StringToColor(ParseParam(r, COLOR_PANEL_SYSTEM));
        pnlHelpColor.Color            := StringToColor(ParseParam(r, COLOR_PANEL_HELP));
        end;
  end;
end;

procedure TFchParameter.btnApplayClick(Sender: TObject);
begin
  inherited;
      //Update Color
      DM.fMainMenu.SetColors(pnlMenuHighlight.Color,
                             pnlMenuTextHighlight.Color,
                             pnlMenuBackGround.Color,
                             pnlBackGroundColor.Color,
                             pnlSubMenuFontColor.Color,
                             pnlSMHighlightFontColor.Color,
                             pnlShorcutsColor.Color,
                             pnlSystemColor.Color,
                             pnlHelpColor.Color);

      DM.fMainMenu.Logo := edtLogo.Text;

      MainMenu.RefreshColor;
end;

procedure TFchParameter.pgParamChange(Sender: TObject);
begin
  inherited;
  if pgParam.ActivePage = tsGridLayout then
     GridLayoutSub.CreateSubList
  else if pgParam.ActivePage = tsMenuColor then
     LoadTemplates
  else if pgParam.ActivePage = tsProcessor then
     BuildProcessor;
end;

procedure TFchParameter.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  with TFrmPreviewTicket.Create(Self) do
     Start(DM.fStore.ID, NORMAL);
end;

procedure TFchParameter.btnSaveColorsClick(Sender: TObject);
var
 r : String;
begin
  Case cbxColor.ItemIndex of
    //Default
    0 : Exit;
    else
        begin
        r := COLOR_MENU_HIGHLIGHT+ColorToString(pnlMenuHighlight.Color)+';'+
             COLOR_MENU_TEXT_HIGHLIGHT+ColorToString(pnlMenuTextHighlight.Color)+';'+
             COLOR_MENU_BACKGROUND+ColorToString(pnlMenuBackGround.Color)+';'+
             COLOR_BACKGROUND+ColorToString(pnlBackGroundColor.Color)+';'+
             COLOR_SUB_MENU_FONT+ColorToString(pnlSubMenuFontColor.Color)+';'+
             COLOR_SUB_MENU_FONT_HIGHLIGHT+ColorToString(pnlSMHighlightFontColor.Color)+';'+
             COLOR_PANEL_SHORTCUTS+ColorToString(pnlShorcutsColor.Color)+';'+
             COLOR_PANEL_SYSTEM+ColorToString(pnlSystemColor.Color)+';'+
             COLOR_PANEL_HELP+ColorToString(pnlHelpColor.Color)+';';
        setIniColor(cbxColor.Text, r);
        LoadTemplates;
        end;
  end;
end;

procedure TFchParameter.btnDelReportClick(Sender: TObject);
begin
  inherited;
  EdtHoldReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.sbBackGroundClick(Sender: TObject);
begin
  inherited;

  OP.Filter := FILE_IMAGEM;

  if OP.Execute then
     edtLogo.Text := OP.FileName;

end;

procedure TFchParameter.btnNewReportClick(Sender: TObject);
begin
  inherited;
  with TPrintReceipt.Create(Self) do
     begin
     DesignReport;
     Close;
     end;
end;

procedure TFchParameter.btnOpenReportClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     EdtHoldReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnDeliveryNewClick(Sender: TObject);
begin
  inherited;

  with TFrmPrintDelivery.Create(Self) do
     begin
     DesignReport;
     Close;
     end;

end;

procedure TFchParameter.btnDeliveryOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     EdtDeveliryReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnDeliveryDelClick(Sender: TObject);
begin
  inherited;
  EdtDeveliryReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnBudgetNewClick(Sender: TObject);
begin
  inherited;

  with TFrmEstimatedPrint.Create(Self) do
     begin
     DesignReport;
     Close;
     end;

end;

procedure TFchParameter.btnBudgetOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     EdtBudgetReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnBudgetDelClick(Sender: TObject);
begin
  inherited;
  EdtBudgetReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnCommiDelClick(Sender: TObject);
begin
  inherited;
  edtCommisReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnCommiOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtCommisReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnCommiNewClick(Sender: TObject);
begin
  inherited;

  with TFrmPagaVendedor.Create(Self) do
     begin
     DesignReport;
     Close;
     end;

end;

procedure TFchParameter.btnDelTransferClick(Sender: TObject);
begin
  inherited;
  EdtTransferReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnOpenTransferClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     EdtTransferReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnNewTransferClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintTransfer.Create(Self) do
     begin
     DesignReport;
     Close;
     end;
end;

procedure TFchParameter.btnPCPathClick(Sender: TObject);
begin
  inherited;
  OP.Filter :=   FILE_EXEC;
  if OP.Execute then
     edtPCPath.Text := ExtractFilePath(OP.FileName);
end;

procedure TFchParameter.cbxProcessorsChange(Sender: TObject);
begin
  inherited;
  RefreshProcessor;
  BuildProcessor;
end;

procedure TFchParameter.RefreshProcessor;
begin
  inherited;
  //amfsouza
  pgCharge.Visible := ( (cbxProcessors.ItemIndex <> 0) and (cbxProcessors.ItemIndex <> 3) );
  if ( pgCharge.Visible ) then begin
      ntProcessor.PageIndex := (cbxProcessors.ItemIndex -1);
      pnGCProcessor.Visible := cbxProcessors.ItemIndex = 2;
      tabMercuryGift.TabVisible := ( (cbbGCProcessor.Visible) and (cbbGCProcessor.ItemIndex >= 1) );
  end;
end;


procedure TFchParameter.BuildProcessor;
var
  sProcessor,
  sMercantNum,
  CardID : String;
  iCopies: Integer;
begin

  if grdPayment.RowCount <> 1 then
    Exit;

  with DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('Select IDMeioPag, MeioPag from MeioPag');
    SQL.Add('Where Tipo in (2,7)');
    Open;
    grdPayment.Cells[0,0]  := sAPayType;
    if cbxProcessors.ItemIndex = PROCESSOR_PCCHARGE then
    begin
      grdPayment.Cells[1,0]  := sAProcessor;
      grdPayment.Cells[2,0]  := sAMerchNumber;
    end
    else
    begin
      grdPayment.Cells[1,0]  := 'Blank field';
      grdPayment.Cells[2,0]  := 'Blank field';
    end;
    grdPayment.Cells[3,0]  := sAReceiptCopies;
    grdPayment.Cells[4,0]  := sCardID;
    grdPayment.RowCount    := RecordCount+1;
    grdPayment.FixedRows   := 1;
    First;
    while not EOF do
      begin
      DM.fPCCharge.GetProcessor(FieldByName('IDMeioPag').AsInteger, sProcessor, sMercantNum, iCopies, CardID);
      grdPayment.Cells[0,RecNo] := FieldByName('MeioPag').AsString;

      if cbxProcessors.ItemIndex = PROCESSOR_PCCHARGE then
      begin
        grdPayment.Cells[1,RecNo] := sProcessor;
        grdPayment.Cells[2,RecNo] := sMercantNum;
      end
      else
      begin
        grdPayment.Cells[1,RecNo] := '';
        grdPayment.Cells[2,RecNo] := '';
      end;
      grdPayment.Cells[3,RecNo] := IntToStr(iCopies);
      grdPayment.Cells[4,RecNo] := CardID;
      Next;
      end;
    Close;
    end;
end;

procedure TFchParameter.SaveProcessor;
var
  i : Integer;
begin
  if grdPayment.RowCount = 1 then
     Exit;

  for i:=1 to grdPayment.RowCount-1 do
  begin
    DM.fPCCharge.SetProcessor(grdPayment.Cells[0,i], grdPayment.Cells[1,i], grdPayment.Cells[2,i], StrToIntDef(grdPayment.Cells[3,i], 1), grdPayment.Cells[4,i]);
  end;

end;


procedure TFchParameter.grdPaymentSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  inherited;
  //Somente na Coluna desejada
  if ((ACol = 1) AND (ARow <> 0)) then begin
   {Size and position the combo box to fit the cell}
    R := grdPayment.CellRect(ACol, ARow);
    R.Left := R.Left + grdPayment.Left;
    R.Right := R.Right + grdPayment.Left;
    R.Top := R.Top + grdPayment.Top;
    R.Bottom := R.Bottom + grdPayment.Top;
    cbxProcessor.Left := R.Left + 1;
    cbxProcessor.Top := R.Top + 1;
    cbxProcessor.Width := (R.Right + 1) - R.Left;
    cbxProcessor.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbxProcessor.Text := grdPayment.Cells[ACol, ARow];
    cbxProcessor.Visible := True;
    cbxProcessor.SetFocus;
  end;

  //Somente na Coluna desejada
  if ((ACol = 4) AND (ARow <> 0)) then begin
   {Size and position the combo box to fit the cell}
    R := grdPayment.CellRect(ACol, ARow);
    R.Left := R.Left + grdPayment.Left;
    R.Right := R.Right + grdPayment.Left;
    R.Top := R.Top + grdPayment.Top;
    R.Bottom := R.Bottom + grdPayment.Top;
    cxCardType.Left := R.Left + 1;
    cxCardType.Top := R.Top + 1;
    cxCardType.Width := (R.Right + 1) - R.Left;
    cxCardType.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cxCardType.Text := grdPayment.Cells[ACol, ARow];
    cxCardType.Visible := True;
    cxCardType.SetFocus;
  end;


  CanSelect := True;
end;

procedure TFchParameter.cbxProcessorChange(Sender: TObject);
begin
  inherited;
  {Get the ComboBox selection and place in the grid}
  grdPayment.Cells[grdPayment.Col, grdPayment.Row] := cbxProcessor.Items[cbxProcessor.ItemIndex];

  cbxProcessor.Visible := False;
  grdPayment.SetFocus;

end;

procedure TFchParameter.cbxProcessorExit(Sender: TObject);
begin
  inherited;
  {Get the ComboBox selection and place in the grid}
  grdPayment.Cells[grdPayment.Col, grdPayment.Row] := cbxProcessor.Items[cbxProcessor.ItemIndex];
  cbxProcessor.Visible := False;
  grdPayment.SetFocus;
end;

procedure TFchParameter.btnPONewClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintPO.Create(Self) do
     begin
     DesignReport;
     Close;
     end;

end;

procedure TFchParameter.btnPOOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtPOReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnPODelClick(Sender: TObject);
begin
  inherited;
  edtPOReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.cbxPaperTypeChange(Sender: TObject);
begin
  inherited;
  if cbxPaperType.ItemIndex = 1 then
  begin
    pnlInvoice80Col.Visible := True;
    pnlInvoiceA4.Visible    := False;
    Label10.Visible         := True;
    cbxPrinterPort.Visible  := True;
  end
  else
  begin
    pnlInvoice80Col.Visible := False;
    pnlInvoiceA4.Visible    := True;
    Label10.Visible         := False;
    cbxPrinterPort.Visible  := False;
  end;
end;

procedure TFchParameter.chkUSBClick(Sender: TObject);
begin
  inherited;
  pnlUSB.Visible := chkUSB.Checked;
end;

procedure TFchParameter.btnDelStoreFooterClick(Sender: TObject);
begin
  inherited;
  edtReportFooter.Text := '';
end;

procedure TFchParameter.btnOpenStoreFooterClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtReportFooter.Text := OP.FileName;
end;

procedure TFchParameter.cxCardTypeChange(Sender: TObject);
begin
  inherited;

  {Get the ComboBox selection and place in the grid}
  grdPayment.Cells[grdPayment.Col, grdPayment.Row] := cxCardType.Items[cxCardType.ItemIndex];

  cxCardType.Visible := False;
  grdPayment.SetFocus;

end;

procedure TFchParameter.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtSHPacking.Text := OP.FileName;
end;

procedure TFchParameter.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  edtSHPacking.Text := '[SYSTEM]';
end;

procedure TFchParameter.SpeedButton7Click(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtSHPickTicket.Text := OP.FileName;
end;

procedure TFchParameter.SpeedButton8Click(Sender: TObject);
begin
  inherited;
  edtSHPickTicket.Text := '[SYSTEM]';
end;

procedure TFchParameter.RefreshPrice;
begin
  if DM.fSystem.SrvParam[PARAM_USE_PRICE] then
  begin
    tsPrice.TabVisible := True;
    scRecordType.LookUpValue := DM.DescCodigo(['Property'], [QuotedStr('PriceRecordType')], 'Sis_PropertyDomain', 'PropertyValue');
    scDocumentType.LookUpValue := DM.DescCodigo(['Property'], [QuotedStr('PriceDocumentType')], 'Sis_PropertyDomain', 'PropertyValue');
    scPaymentType.LookUpValue := DM.DescCodigo(['Property'], [QuotedStr('PricePaymentType')], 'Sis_PropertyDomain', 'PropertyValue');
    seDueDateDays.Value := DM.DescCodigo(['Property'], [QuotedStr('PriceDueDateDays')], 'Sis_PropertyDomain', 'PropertyValue');
  end
  else
    tsPrice.TabVisible := False;
end;

procedure TFchParameter.SavePrice;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('UPDATE Sis_PropertyDomain SET PropertyValue = ' + QuotedStr(scRecordType.LookUpValue) + ' WHERE Property = ' + QuotedStr('PriceRecordType'));
    ExecSQL;

    SQL.Clear;
    SQL.Add('UPDATE Sis_PropertyDomain SET PropertyValue = ' + QuotedStr(scDocumentType.LookUpValue) + ' WHERE Property = ' + QuotedStr('PriceDocumentType'));
    ExecSQL;

    SQL.Clear;
    SQL.Add('UPDATE Sis_PropertyDomain SET PropertyValue = ' + QuotedStr(scPaymentType.LookUpValue) + ' WHERE Property = ' + QuotedStr('PricePaymentType'));
    ExecSQL;

    SQL.Clear;
    SQL.Add('UPDATE Sis_PropertyDomain SET PropertyValue = ' + IntToStr(seDueDateDays.Value) + ' WHERE Property = ' + QuotedStr('PriceDueDateDays'));
    ExecSQL;
  finally
    SQL.Clear;
    Close;
  end;
end;

procedure TFchParameter.btnRepairNewClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintRepair.Create(Self) do
  begin
    DesignReport;
    Close;
  end;
end;

procedure TFchParameter.btnRepairOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtRepairReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnRepairDelClick(Sender: TObject);
begin
  inherited;
  edtRepairReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnReceivingNewClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintReceiving.Create(Self) do
  begin
    DesignReport;
    Close;
  end;
end;

procedure TFchParameter.btnReceivingOpenClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtReceivingReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnReceivingDelClick(Sender: TObject);
begin
  inherited;
  edtReceivingReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnSOEditClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtSOReportPath.Text := OP.FileName;
end;

procedure TFchParameter.btnSODelClick(Sender: TObject);
begin
  inherited;
  edtSOReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnSONewClick(Sender: TObject);
begin
  inherited;

  with TFrmServiceOrderPrint.Create(Self) do
  begin
    DesignReport;
    Close;
  end;

end;

procedure TFchParameter.btnSADelClick(Sender: TObject);
begin
  inherited;
  edtSAReportPath.Text := '[SYSTEM]';
end;

procedure TFchParameter.btnSAEditClick(Sender: TObject);
begin
  inherited;
  OP.Filter := FILE_REPORT;
  if OP.Execute then
     edtSAReportPath.Text := OP.FileName;
end;

procedure TFchParameter.SpeedButton9Click(Sender: TObject);
begin
  inherited;

  with TFrmPrintStoreAccount.Create(Self) do
  begin
    DesignReport;
    Close;
  end;

end;

procedure TFchParameter.chkScaleClick(Sender: TObject);
begin
  inherited;
  cbxScaleType.Visible  := chkScale.Checked;
end;

procedure TFchParameter.btnPetPathClick(Sender: TObject);
begin
  inherited;

  OP.Filter := FILE_EXEC;
  if OP.Execute then
     edtPetIP.Text := OP.FileName;

end;

procedure TFchParameter.btnBBTestConnectionClick(Sender: TObject);
begin
  inherited;

  DM.FBonusSync.Init(DM.HTTPReqRespCatalog, edtBBUrl.Text, edtBBUrlUser.Text, edtBBUrlPW.Text,
                     edtBBPartnerAcc.Text, edtBBPartnerKey.Text, StrToInt(edtBBStoreNum.Text));

  try
    DM.FBonusSync.BonusCode := '0';
    DM.FBonusSync.Use;
    if DM.FBonusSync.IDResult = 2005 then
      lbBBTestResult.Caption := 'Connection OK!'
    else
      lbBBTestResult.Caption := 'Connection FAIL! ' + DM.FBonusSync.ResultMessage;
  except
    on E: Exception do
      lbBBTestResult.Caption := 'Connection FAIL! ' + E.Message;
  end;

end;

procedure TFchParameter.pgChargeChange(Sender: TObject);
begin
  inherited;
  if ( pgCharge.ActivePage = tabMercuryGift ) then begin
     edtMercGiftPort.Text := '9100';
     edtMercMechantID.Text := edtMerchantID.Text;
     edtMercIPAddress.Text := 'g1.mercurypay.com;g2.backuppay.com';
  end;
end;

procedure TFchParameter.cbbGCProcessorCloseUp(Sender: TObject);
begin
  inherited;
  tabMercuryGift.TabVisible := ( cbbGCProcessor.ItemIndex >= 1 );
end;

procedure TFchParameter.cbxProcessorsCloseUp(Sender: TObject);
begin
  inherited;
  pnGCProcessor.Visible := cbxProcessors.ItemIndex = 2;
end;

end.

