unit uDMThread;

interface

uses
  Windows, SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, Provider, DBClient, PowerADOQuery, LookUpADOQuery,
  DB, ADODB, ImgList, Controls, uPOSServerConsts, uFilePersistence,
  ufrmServerInfo, uSQLObj, uParamFunctions, forms, uSaveToFile, Variants,
  uSystemConst, uPOSServerTypes, ActiveX, Registry, uInvoiceClasses,
  AbUnzper, AbBase, AbBrowse, AbZBrows, AbZipper, DateUtils;

const
  TEMP_DIR                 = 'TMP\';
  ZIP_GLOBAL_FILE_NAME     = 'Global.zip';
  ZIP_STORE_FILE_NAME      = 'Store_%S.zip';
  FTP_TIMEOUT              = 300000; //-1 default
  FTP_TRANSFER_TIMEOUT     = 300000; //300000 = 5 minutos //-1 default

type
  TArquivoImportar = class
    Nome: string;
    Data: TDateTime;
  end;

  TFileInfo = class
    FileName : String;
    Line     : Integer;
    SaleCode : String;
    LineCount: Integer;
  end;

  TDMThread = class(TDataModule)
    spGetNextID: TADOStoredProc;
    ADODBConnect: TADOConnection;
    quFreeSQL: TADOQuery;
    ADOCommand: TADOCommand;
    imgLarge: TImageList;
    quMedia: TADODataSet;
    quMediaIDMedia: TIntegerField;
    quMediaMedia: TStringField;
    quSystemUser: TADODataSet;
    quSystemUserUserTypeID: TIntegerField;
    quSystemUserIDUser: TIntegerField;
    quSystemUserSystemUser: TStringField;
    quSystemUserComissionID: TIntegerField;
    quSystemUserStoresAccess: TStringField;
    quSystemUserPW: TStringField;
    quSystemUserIDTipoPessoa: TIntegerField;
    quOtherCommission: TADODataSet;
    quOtherCommissionIDPessoa: TIntegerField;
    quOtherCommissionIDComissionado: TIntegerField;
    quOtherCommissionPessoa: TStringField;
    quCustomer: TADODataSet;
    quCustomerIDPessoa: TIntegerField;
    quCustomerPessoa: TStringField;
    quCustomerPessoaFirstName: TStringField;
    quCustomerPessoaLastName: TStringField;
    quCustomerEndereco: TStringField;
    quCustomerCidade: TStringField;
    quCustomerCEP: TStringField;
    quCustomerTelefone: TStringField;
    quCustomerCPF: TStringField;
    quCustomerInscEstadual: TStringField;
    quCustomerBairro: TStringField;
    quParam: TADODataSet;
    quParamIDParam: TIntegerField;
    quParamSrvParameter: TStringField;
    quParamSrvValue: TStringField;
    quParamSrvType: TStringField;
    quParamDescription: TStringField;
    quParamDefaultValue: TStringField;
    quStore: TADODataSet;
    quStoreIDStore: TIntegerField;
    quStoreName: TStringField;
    quStoreTicketHeader: TMemoField;
    quStoreTicketLayawayFooter: TMemoField;
    quStoreTicketTaxIsemptFooter: TMemoField;
    quStoreTicketFooter: TMemoField;
    quStoreTicketDetail: TMemoField;
    quStoreTicketTotals: TMemoField;
    quStorePrintTicketHeader: TBooleanField;
    quStorePrintLayawayFooter: TBooleanField;
    quStorePrintTaxInsemptFooter: TBooleanField;
    quStorePrintTicketFooter: TBooleanField;
    quStoreIDEstado: TStringField;
    quStoreAddress: TStringField;
    quStoreCity: TStringField;
    quStoreZip: TStringField;
    quStoreTelephone: TStringField;
    quStoreCellular: TStringField;
    quStoreBeeper: TStringField;
    quStoreFax: TStringField;
    quStoreContato: TStringField;
    quStoreEmail: TStringField;
    quStoreWebPage: TStringField;
    quUserTypeToSysFunction: TADODataSet;
    quUserTypeToSysFunctionIDUserType: TIntegerField;
    quUserTypeToSysFunctionIDSysFunction: TIntegerField;
    quUserTypeToSysFunctionAcesso: TBooleanField;
    quUserRights: TADODataSet;
    quUserRightsIDUserType: TIntegerField;
    quUserRightsIDUser: TIntegerField;
    quUserRightsCanAccess: TBooleanField;
    quUserRightsCanInsert: TBooleanField;
    quUserRightsCanDelete: TBooleanField;
    quUserRightsCanPrint: TBooleanField;
    quUserRightsCanUpdate: TBooleanField;
    quUserRightsSystemUser: TStringField;
    quUserRightsMenuID: TIntegerField;
    quUserRightsSubMenuID: TIntegerField;
    quUserRightsComissionID: TIntegerField;
    quUserRightsPW: TStringField;
    quModelAccessory: TADODataSet;
    quModelAccessoryIDInvAccessory: TIntegerField;
    quModelAccessoryIDModel: TIntegerField;
    quModelAccessorySellingPrice: TBCDField;
    quModelAccessoryModel: TStringField;
    quModelAccessoryDescription: TStringField;
    quModelAccessoryHint: TStringField;
    quModelAccessoryLargeImage: TStringField;
    quModelAccessoryPromotionPrice: TBCDField;
    quModelAccessoryDiscountPerc: TFloatField;
    quModel: TADODataSet;
    quModelInvSellingPrice: TBCDField;
    quModelVendorCost: TBCDField;
    quBarcode: TADODataSet;
    quBarcodeIDModel: TIntegerField;
    quBarcodeIDBarcode: TStringField;
    quBarcodeModel: TStringField;
    quMeioPag: TADODataSet;
    quMeioPagIDMeioPag: TIntegerField;
    quMeioPagMeioPag: TStringField;
    quMeioPagImageIndex: TIntegerField;
    quMeioPagTipo: TIntegerField;
    dsLookUpCashReg: TDataSource;
    spCashRegOpen: TADOStoredProc;
    spCashRegClose: TADOStoredProc;
    spNewSaleCode: TADOStoredProc;
    quSearchPreSale: TADOQuery;
    quSearchCashRegMov: TADOQuery;
    quRun: TADOQuery;
    quQty: TADODataSet;
    quQtyName: TStringField;
    quQtyStoreID: TIntegerField;
    quQtyCurrentCost: TBCDField;
    quQtyFloatPercent: TIntegerField;
    quQtyIDModel: TIntegerField;
    cmdPessoa: TADOCommand;
    cmdExemptTax: TADOCommand;
    quSearchPreSaleID: TADOQuery;
    spCashRegWidraw: TADOStoredProc;
    spCashRegPetty: TADOStoredProc;
    quCashReg: TADODataSet;
    quCashRegIDCashRegister: TIntegerField;
    quCashRegName: TStringField;
    quCashRegIsAssociated: TBooleanField;
    quAccess: TADODataSet;
    quAccessIDUser: TIntegerField;
    quAccessCanAccess: TBooleanField;
    quAccessPW: TStringField;
    quAccessMenuID: TIntegerField;
    quAccessSubMenuID: TIntegerField;
    quTaxCategory: TADODataSet;
    quTaxCategoryIDTaxCategory: TIntegerField;
    quTaxCategoryTaxCategory: TStringField;
    quTaxCategoryTax: TBCDField;
    spCancelInvoice: TADOStoredProc;
    quBanco: TADODataSet;
    quBancoIDBanco: TIntegerField;
    quBancoCodigoBanco: TStringField;
    quBancoBanco: TStringField;
    quDiscRange: TADODataSet;
    quDiscRangeIDTipoComissionado: TIntegerField;
    quDiscRangeTotVendaMin: TBCDField;
    quDiscRangePercDiscMax: TBCDField;
    quKitModel: TADODataSet;
    quKitModelIDModel: TIntegerField;
    quKitModelSellingPrice: TBCDField;
    quInvFeatures: TADODataSet;
    quInvFeaturesIDInvFeatures: TIntegerField;
    quInvFeaturesIDModel: TIntegerField;
    quInvFeaturesFeature: TStringField;
    quInvTechFeatures: TADODataSet;
    quInvTechFeaturesIDInvTechFeatures: TIntegerField;
    quInvTechFeaturesIDModel: TIntegerField;
    quInvTechFeaturesTechFeature: TStringField;
    quInvDepartment: TADODataSet;
    quInvDepartmentIDDepartment: TIntegerField;
    quInvDepartmentDepartment: TStringField;
    quInvModelDepartment: TADODataSet;
    quInvModelDepartmentModelID: TIntegerField;
    quInvModelDepartmentIDDepartment: TIntegerField;
    quInvModelDepartmentDepartment: TStringField;
    cdsBarcode: TClientDataSet;
    dspBarcode: TDataSetProvider;
    cdsMedia: TClientDataSet;
    dspMedia: TDataSetProvider;
    cdsSystemUser: TClientDataSet;
    dspSystemUser: TDataSetProvider;
    cdsOtherCommission: TClientDataSet;
    dspOtherCommission: TDataSetProvider;
    cdsCustomer: TClientDataSet;
    dspCustomer: TDataSetProvider;
    cdsParam: TClientDataSet;
    dspParam: TDataSetProvider;
    cdsStore: TClientDataSet;
    dspStore: TDataSetProvider;
    cdsUserTypeToSysFunction: TClientDataSet;
    dspUserTypeToSysFunction: TDataSetProvider;
    cdsUserRights: TClientDataSet;
    dspUserRights: TDataSetProvider;
    cdsModel: TClientDataSet;
    dspModel: TDataSetProvider;
    cdsModelAccessory: TClientDataSet;
    dspModelAccessory: TDataSetProvider;
    cdsQty: TClientDataSet;
    cdsCashReg: TClientDataSet;
    cdsInvDepartment: TClientDataSet;
    cdsTaxCategory: TClientDataSet;
    cdsMeioPag: TClientDataSet;
    dspMeioPag: TDataSetProvider;
    dspQty: TDataSetProvider;
    dspCashReg: TDataSetProvider;
    cdsInvModelDepartment: TClientDataSet;
    cdsAccess: TClientDataSet;
    dspAccess: TDataSetProvider;
    dspTaxCategory: TDataSetProvider;
    cdsKitModel: TClientDataSet;
    dspKitModel: TDataSetProvider;
    dspInvDepartment: TDataSetProvider;
    dspInvModelDepartment: TDataSetProvider;
    cdsBanco: TClientDataSet;
    dspBanco: TDataSetProvider;
    cdsDiscRange: TClientDataSet;
    dspDiscRange: TDataSetProvider;
    cdsInvFeatures: TClientDataSet;
    dspInvFeatures: TDataSetProvider;
    cdsInvTechFeatures: TClientDataSet;
    dspInvTechFeatures: TDataSetProvider;
    FTP: TIdFTP;
    dsLookUpStore: TDataSource;
    cmdAddDeletedItem: TADOCommand;
    quTestRemovedItem: TADODataSet;
    quTestRemovedItemIDRemovedItem: TIntegerField;
    quTestReducaoZ: TADOQuery;
    cmdInsertTributacaoECF: TADOCommand;
    spCashRegAddCash: TADOStoredProc;
    quSystemUserCodSystemUser: TStringField;
    spCancelHold: TADOStoredProc;
    quKitModelQty: TBCDField;
    quQtyQtyOnPreSale: TBCDField;
    quQtyQtyOnHand: TBCDField;
    quQtyQtyOnOrder: TBCDField;
    quQtyQtyOnRepair: TBCDField;
    quQtyQtyOnPrePurchase: TBCDField;
    quInvSerial: TADODataSet;
    cdsInvSerial: TClientDataSet;
    dspInvSerial: TDataSetProvider;
    quInvSerialStoreID: TIntegerField;
    quInvSerialModelID: TIntegerField;
    quInvSerialSerial: TStringField;
    quStoreTablePrice: TADODataSet;
    cdsStoreTablePrice: TClientDataSet;
    dspStoreTablePrice: TDataSetProvider;
    quModelTablePrice: TADODataSet;
    cdsModelTablePrice: TClientDataSet;
    dspModelTablePrice: TDataSetProvider;
    quStoreTablePriceIDStore: TIntegerField;
    quStoreTablePriceIDModel: TIntegerField;
    quStoreTablePriceIDDescriptionPrice: TIntegerField;
    quStoreTablePriceIDVendor: TIntegerField;
    quStoreTablePriceSuggPrice: TBCDField;
    quStoreTablePriceSalePrice: TBCDField;
    quStoreTablePriceDescriptionPrice: TStringField;
    quStoreTablePriceVendor: TStringField;
    quModelTablePriceIDModel: TIntegerField;
    quModelTablePriceIDDescriptionPrice: TIntegerField;
    quModelTablePriceIDVendor: TIntegerField;
    quModelTablePriceSuggPrice: TBCDField;
    quModelTablePriceSalePrice: TBCDField;
    quModelTablePriceDescriptionPrice: TStringField;
    quModelTablePriceVendor: TStringField;
    quDocumentType: TADODataSet;
    cdsDocumentType: TClientDataSet;
    dspDocumentType: TDataSetProvider;
    quDocumentTypeIDDocumentType: TIntegerField;
    quDocumentTypeDocumentType: TStringField;
    quDocumentTypeDefaultType: TBooleanField;
    Zipper: TAbZipper;
    UnZipper: TAbUnZipper;
    quCashRegLogReason: TADOQuery;
    quCashRegLogReasonIDCashRegLogReason: TIntegerField;
    quCashRegLogReasonReason: TStringField;
    dspCashRegLogReason: TDataSetProvider;
    cdsCashRegLogReason: TClientDataSet;
    cdsCashRegLogReasonIDCashRegLogReason: TIntegerField;
    cdsCashRegLogReasonReason: TStringField;
    quModelSellingPrice: TCurrencyField;
    quModelIDModel: TIntegerField;
    quModelDescription: TStringField;
    quModelModel: TStringField;
    quModelReplacementCost: TBCDField;
    quModelPeso: TBCDField;
    quModelSuggRetail: TBCDField;
    quModelAvgCost: TBCDField;
    quModelLargeImage: TStringField;
    quModelLargeImage2: TStringField;
    quModelPromotionPrice: TBCDField;
    quModelAskUserOnSale: TBooleanField;
    quModelDiscountPerc: TFloatField;
    quModelCustomSalePrice: TBooleanField;
    quModelStoreSellingPrice: TBCDField;
    quModelTabGroup: TStringField;
    quModelUnidade: TStringField;
    quModelSigla: TStringField;
    quModelFabricante: TStringField;
    quModelSizeName: TStringField;
    quModelCodSize: TStringField;
    quModelColor: TStringField;
    quModelCodColor: TStringField;
    quModelRequestCustomer: TBooleanField;
    quModelPuppyTracker: TBooleanField;
    quModelVendorCostM: TBCDField;
    quModelVendorCostI: TBCDField;
    quModelInvSellingPriceM: TBCDField;
    quModelInvSellingPriceI: TBCDField;
    quModelIDTaxCategory: TIntegerField;
    quModelIDDepartment: TIntegerField;
    quModelFornecedor: TStringField;
    quModelCaseQty: TBCDField;
    quModelSerialNumber: TBooleanField;
    quModelUseDocumentOnSale: TBooleanField;
    quModelUseScale: TBooleanField;
    dsMeioPagMinSale: TADODataSet;
    cdsMeioPagMinSale: TClientDataSet;
    dspMeioPagMinSale: TDataSetProvider;
    dsMeioPagMinSaleIDMeioPag: TIntegerField;
    dsMeioPagMinSaleDifDay: TIntegerField;
    dsMeioPagMinSaleTotalSale: TBCDField;
    quMeioPagRequireCustomer: TBooleanField;
    cmdInsertLancComplement: TADOCommand;
    cmdInsertNotaCancel: TADOCommand;
    quPreSaleItemCanceled: TADODataSet;
    cmdInsertTotalizadorParcial: TADOCommand;
    cmdInsertReducaoZ: TADOCommand;
    quModelIndicadorProducao: TStringField;
    quModelIndicadorAT: TStringField;
    quModelSituacaoTributaria: TIntegerField;
    quModelDescSituTribut: TStringField;
    spPreSaleRemove: TADOStoredProc;
    quCustomerStoreAccountLimit: TBCDField;
    quCustomerNonpayer: TBooleanField;
    quMeioPagValidateNonpayer: TBooleanField;
    quBarcodeCaseQty: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure quModelBeforeOpen(DataSet: TDataSet);
    procedure quModelAccessoryBeforeOpen(DataSet: TDataSet);
    procedure quInvModelDepartmentBeforeOpen(DataSet: TDataSet);
    procedure quModelCalcFields(DataSet: TDataSet);
    procedure FTPDisconnected(Sender: TObject);
    procedure FTPConnected(Sender: TObject);
  private
    fIDStore: Integer;

    FLastSale: TLastSale;

    IDCashReg,
    IDCashRegMov,
    IDCashRegLog,
    IDPreSale,
    LastIDPreSale,
    IDPessoa: Integer;

    iIDReducaoZ,
    iIDCashRegReducaoZ: Integer;
    bHasReducaoZ: Boolean;

    CashImported,
    PreSaleImported,
    CashClosed: Boolean;

    FSaleLineParser: TSaleLineParser;

    FFileInfo: TFileInfo;

    FIsFranquia: Boolean;
    FServerConnection: TServerConnection;
    FLocalSetting: TLocalSetting;
    FForceSynchronization: Boolean;
    FCashRegInfolist: TStringList;
    FSynchronizationType: Integer;
    FThread: TThread;

    FFileCount: Integer;
    FFileIndex: Integer;

    FInvoice: TInvoice;

    {T}
    FTmpLastCloseLine: String;
    FPreSaleDate: TDateTime;

    procedure AddErrorHistory(Text: String);
    procedure AddHistory(Text: String);
    procedure AddImportHistory(Text: String);
    procedure CloseConnection;
    function GetConnection(AForceDialog: Boolean = False) : String;
    function GetConnectionInfo(sConnection: String): String;
    function LoadErrorFile: String;
    function OpenConnection(AForceDialog: Boolean = False):Boolean;
    procedure ReportError(sText: String);
    function StartConnection(AForceDialog: Boolean = False):Boolean;
    function StopConnection: Boolean;
    function CreateGlobalFiles(fDataSet: TClientDataSet; fPath,
      fFileName: String): Boolean;
    function CreatingAllGlobal: Boolean;
    function FomartConnection(sParam: String): String;
    function AddCustomer(ALine: String): Boolean;
    function AddItem(ALine: String; ASerialNumbers : TList; Index : Integer): Boolean;
    function AddItemRemoved(ALine: String; Index : Integer): Boolean;
    function AddPayment(ALine: String): Boolean;
    function AddPC(ALine: String): Boolean;
    function AddRemovedItem(ALine: String): Boolean;
    function AddSubRemovedItem(RRI: TRegRemovedItem; TestImported: Boolean): Boolean;
    function AddWC(ALine: String): Boolean;
    function CancelHold(AIDPreSale, AIDUser : Integer; ACOO : String): Boolean;
    function CancelInvoice(AIDPreSale, AIDUser: Integer): Boolean;
    function CancelInvoiceFiscal(ACOO: String; AIDUser: Integer): Boolean;
    function CancelSale(ALine: String): Boolean;
    function CloseCash(ALine: String): Boolean;
    function CloseSale(ALine: String): Boolean;
    function CreateSaleCode(AIDPreSale, AIDPreSaleParent,
      AIDStore: Integer; ACOO, ASaleCode: String; APuppyTracker: Boolean;
      ECFSerial: String): String;
    procedure DeleteHold(AIDPreSale: Integer);
    function ExemptTax(fIDPreSale: Integer; fExempt: Boolean): Boolean;
    function GetCashRegMovID(AIDCashReg: Integer; AOpenTime: TDateTime;
      var AOpened: Boolean): Integer;
    function GetPreSaleID(AIDStore, AIDCashReg: Integer;
      APreSaleDate: TDateTime; ASaleCode: String): Integer;
    function HoldExists(AIDPreSale: Integer; var IsInvoice: Boolean): Boolean;
    function ImportDir(ADir: String; AIDCashReg: Integer; IncludeSince:String;
         var LastDate: String): Boolean;
    function ImportFile(AFileName: String;
      var ACashClosed: Boolean): Boolean;
    function ImportLine(ALine: String; var ACashClosed,
      ErrorCashClosed: Boolean): Boolean;
    function LogExists(AIDCashReg: Integer; ADate: TDateTime): Boolean;
    function OpenCash(ALine: String;
      var ErrorCashClosed: Boolean): Boolean;
    function OpenSale(ALine: String): Boolean;
    function SaleOBS(ALine: String): Boolean;
    function CupomVinculado(ALine: String): Boolean;
    function RemovedItemImported(RRI: TRegRemovedItem): Boolean;
    procedure ResetCashReg;
    function AddReducaoZ(ALine: String): Boolean;
    function AddTotParcial(ALine: String): Boolean;
    procedure DecHold(IDPreSale: Integer);
    function FormatError(sError: String): String;
    function GetPessoaID(APessoa, ATel: String): Integer;
    function GetNextID(ATable: String): LongInt;
    procedure SetStatus(Msg: String; Count: Integer);
    procedure Completed;
    procedure ShowDebug(Debug: String);
    procedure IncPBPos;
    function ImportTerminals: Boolean;
    procedure WriteIniBool(ASection, AKey: String; AValue: Boolean);
    procedure WriteIniDateTime(ASection, AKey: String; AValue: TDateTime);
    procedure WriteIniString(ASection, AKey, AValue: String);
    procedure WriteIniInteger(ASection, AKey: String; AValue: Integer);
    procedure SaveNextSchedule(sType: String);
    function FakeTFrmServerInfoStart(StrartType: Char; IsError: Boolean;
      sMSG: String; var bAbort: Boolean): String;
    function TransferServerFiles : Boolean;
    function ZipServerFiles : Boolean;
    function ImportSale: Boolean;
    procedure MoverCaixasFechados(ACaixaFechado: TStringList; AIDCashReg: Integer);

    function ZipFile(sBaseDir, sFileName, sZipFileName : String) : Boolean;
    procedure UnZipFile(DestDir, ZipFileName: String);

    function UnZipServerFiles : Boolean;
    function CreateZipFile(FileName : String) : Boolean;

    //FTP
    function GetFTPFile(fFile: String): Boolean;
    function SetFTPFile(fLocalDir, fRemoteDir, fFile: String): Boolean;
    function ConnectFTP : Boolean;
    procedure DisconnectFTP;
    function ChangeFTPDir(fDir : String) : Boolean;
    function FileSizeFTP(fFile : String) : Integer;
    function DirUpFTP : Boolean;

    {T}
    function ForceClosingSale: Boolean;

   function GetCOOInicial(AIDCashRegister: Integer; AMovDate: TDateTime): Integer;
   function GetNumCancelamento(AIDCashRegister: Integer; AMovDate: TDateTime): Integer;

   function VinculadoImported : Boolean;

   function ValidateInvoiceNum(ANum : String) : Integer;
  public
    property IDStore : Integer read fIDStore write fIDStore;
    property ServerConnection: TServerConnection read FServerConnection write FServerConnection;
    property LocalSetting: TLocalSetting read FLocalSetting write FLocalSetting;
    property ForceSynchronization : Boolean read FForceSynchronization write FForceSynchronization;
    property CashRegInfolist: TStringList read FCashRegInfolist write FCashRegInfolist;
    property SynchronizationType: Integer read FSynchronizationType write FSynchronizationType;

    property Thread: TThread read FThread write FThread;

    function Execute: Boolean;
  protected
      FrmServrInfo : TFrmServerInfo;
      fSQLSvrConnectParam : TSQLConnection;
  end;

var
  DMThread: TDMThread;

implementation

uses tExecuteTask, uEncryptFunctions, uFileFunctions, ShellAPI, uOperationSystem;

{$R *.dfm}

function TDMThread.TransferServerFiles : Boolean;
var
  sLocal, sTempDir: String;
begin
  Result := True;

  sTempDir := ExtractFilePath(Application.ExeName) + TEMP_DIR + '*.*';
  sLocal   := ExtractFilepath(Application.ExeName) + PDV_GLOBAL_DIR;

  if not DirectoryExists(sLocal) then
    ForceDirectories(sLocal);

  try
    CopyFolder(sTempDir, sLocal, FO_MOVE, True, False);
  except
    Result := False;
    AddErrorHistory('Error copying global files.');
  end;
  
end;


function TDMThread.FakeTFrmServerInfoStart(StrartType:Char; IsError:Boolean; sMSG:String; var bAbort:Boolean):String;
var
  sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
  Reg : TRegistry;



  sDatabase,
  sPassword: String;

  bSQL : Boolean;
  bUseLib: Boolean;

const fRegistryKey = 'ServerInfo';
var
  buildInfo: String;
begin

  Reg    := nil;
  bAbort := False;
  Result := SV_SERVER   +'(local);'+
            SV_DATABASE +'MainRetailDB;'+
            SV_USER     +'mruser;'+
            SV_PASSWORD +'mruser2000;'+
            SV_WIN_LOGIN+'N;'+
            SV_USE_NETLIB+'N;';

  Try
      Reg := TRegistry.Create;
      if ( getOS(buildInfo) = osW7 ) then
        reg.RootKey := HKEY_CURRENT_USER
      else
        reg.RootKey := HKEY_LOCAL_MACHINE;

      Reg.OpenKey('SOFTWARE\AppleNet', True);

      (*

      if IsError then
         if sMSG <> '' then
            begin
            lbInfo.Font.Color := clRed;
            lbInfo.Caption    := 'Error: '+sMSG+#10#13+'Try it again!';
            chkUseLib.Visible := True;
            end;

      *)

      if not Reg.ValueExists(fRegistryKey) then
         begin
         Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));
         IsError := True;
         end;

      Result := DecodeServerInfo(Reg.ReadString(fRegistryKey), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

      sServer    := ParseParam(Result, SV_SERVER);
      sDatabase  := ParseParam(Result, SV_DATABASE);
      sUser      := ParseParam(Result, SV_USER);
      sPassword  := ParseParam(Result, SV_PASSWORD);
      bSQL     := (ParseParam(Result, SV_WIN_LOGIN)='N');
      bUseLib := (ParseParam(Result, SV_USE_NETLIB)='Y');

      if not ((StrartType in ['1','2','3','4']) and (IsError)) then
         Exit;

      (*

      ShowModal;

      if (ModalResult = mrAbort) then
         begin
         bAbort := True;
         Exit;
         end;
      *)

      //Encriptografar os dados;
      sServer   := SV_SERVER   +sServer  +';';
      sDBAlias  := SV_DATABASE +sDatabase+';';
      sUser     := SV_USER     +sUser    +';';
      sPW       := SV_PASSWORD +sPassword+';';
      if bSQL then
         sWinLogin := SV_WIN_LOGIN + 'Y;'
      else
         sWinLogin := SV_WIN_LOGIN + 'N;';

      if bUseLib then
         sLib := SV_USE_NETLIB + 'Y;'
      else
         sLib := SV_USE_NETLIB + 'N;';

      //Encriptografar os dados;
      Result := sServer + sDBAlias + sUser + sPW + sWinLogin + sLib;
      Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;

end;


function TDMThread.GetConnection(AForceDialog: Boolean = False) : String;
var
  b: Boolean;
begin

  //Server Connection
  b := False;


  //Server Connection
  Result := FakeTFrmServerInfoStart('4', AForceDialog, '', b);

end;

function TDMThread.GetConnectionInfo(sConnection:String):String;
var
  sServer, sDBAlias, sUserName, sPW : String;
  bWinLogin, bUseNetLib : String;
begin
  sServer    := ParseParam(sConnection, SV_SERVER);
  sDBAlias   := ParseParam(sConnection, SV_DATABASE);
  sUserName  := ParseParam(sConnection, SV_USER);
  sPW        := ParseParam(sConnection, SV_PASSWORD);
  bWinLogin  := ParseParam(sConnection, SV_WIN_LOGIN);
  bUseNetLib := ParseParam(sConnection, SV_USE_NETLIB);
  Result := 'Server=' + sServer + ';Database=' + sDBAlias + ';User=' +
            sUserName +' ;WinLogin=' + bWinLogin + ';UseNetLib=' + bUseNetLib + ';';
end;


function TDMThread.StartConnection(AForceDialog: Boolean = False):Boolean;
begin

  case FServerConnection.ConnectType of
  CON_TYPE_SERVER :
     begin
       Result := OpenConnection(AForceDialog);
     end;

  CON_TYPE_FTP :
     begin
       Result := ConnectFTP;
     end;
  end;


end;

function TDMThread.StopConnection:Boolean;
begin
  CloseConnection;
end;

function TDMThread.OpenConnection(AForceDialog: Boolean = False):Boolean;
var
  sResult : String;
  b: Boolean;
begin
  Result := False;

   //Connection open, exit
  if ADODBConnect.Connected then
  begin
    Result := True;
    Exit;
  end;

  //Server Connection
  b := False;
  sResult := GetConnection(AForceDialog);

  while not b do
  try
    sResult := FomartConnection(sResult);
    ADODBConnect.ConnectionString := sResult;

    ADODBConnect.Open;
    b := True;
    Result := True;
  except
    on E: Exception do
      sResult := FrmServrInfo.Start('4', True, E.Message, b);
  end;

end;

procedure TDMThread.CloseConnection;
begin

  case fServerConnection.ConnectType of
    CON_TYPE_SERVER :
        begin
          if ADODBConnect.Connected then
            ADODBConnect.Close;
        end;

   CON_TYPE_FTP :
        begin
          DisconnectFTP;
        end;

  end;
end;

function TDMThread.LoadErrorFile:String;
var
  textFile:TStringList;
begin
  if FileExists(ExtractFilePath(Application.ExeName)+ERROR_FILE) then
  try
    textFile := TStringlist.create;
    textFile.LoadFromFile(ExtractFilePath(Application.ExeName)+ERROR_FILE);
    Result := textFile.Text;
  finally
    FreeAndNil(textFile);
  end;
end;

procedure TDMThread.AddHistory(Text:String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := ExtractFilepath(Application.ExeName) + HISTORY_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TDMThread.AddImportHistory(Text: String);
var
  fFile : TSaveFile;
begin
  //WriteIniBoolean('Settings','Error', True);
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := ExtractFilepath(Application.ExeName) + IMPORT_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TDMThread.AddErrorHistory(Text:String);
var
  fFile : TSaveFile;
begin
  //WriteIniBoolean('Settings','Error', True);
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := ExtractFilepath(Application.ExeName) + ERROR_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TDMThread.ReportError(sText:String);
begin
  //Register Error history
  AddHistory(sText);
  AddErrorHistory(sText);
end;

function TDMThread.FomartConnection(sParam: String): String;
var
  sServer, sDBAlias, sUserName, sPW : String;
  bWinLogin, bUseNetLib : Boolean;
begin
  sServer    := ParseParam(sParam, SV_SERVER);
  sDBAlias   := ParseParam(sParam, SV_DATABASE);
  sUserName  := ParseParam(sParam, SV_USER);
  sPW        := ParseParam(sParam, SV_PASSWORD);
  bWinLogin  := (ParseParam(sParam, SV_WIN_LOGIN)[1] in ['Y']);
  bUseNetLib := (ParseParam(sParam, SV_USE_NETLIB)[1] = 'Y');

  if not bWinLogin then
    if bUseNetLib then
      Result := SetConnectionStr(sUserName, sPW, sDBAlias, sServer)
    else
      Result := SetConnectionStrNoNETLIB(sUserName, sPW, sDBAlias, sServer)
  else
    if bUseNetLib then
      Result := SetWinConnectionStr(sDBAlias, sServer)
    else
      Result := SetWinConnectionStrNoNETLIB(sDBAlias, sServer);
end;


function TDMThread.CreateGlobalFiles(fDataSet: TClientDataSet; fPath, fFileName: String): Boolean;
var
  EF : TDBExportFile;
begin

  try

    if not DirectoryExists(fPath) then
      ForceDirectories(fPath);

    Result := False;
    try
      fDataSet.Open;
      fFileName := fPath + fFileName + '.xml';
      fDataSet.SaveToFile(fFileName, dfXML);
      Result := True;
      if Result then
         AddImportHistory('SQL (Global) : Arquivo criado ' + fFileName)
      else
         AddErrorHistory('SQL (Global) : Erro criando ' + fFileName);
    finally
      fDataSet.Close;
    end;

  except
    on E: Exception do
      AddErrorHistory('SQL (Global - '+fFileName+'.xml) : ' + E.Message);
  end;
end;

function TDMThread.CreatingAllGlobal: Boolean;
var
  sFileName : String;
  sPath : String;
  sStoreList : TStringList;
  i, iSize : Integer;
  IDStoreOriginal : Integer;
begin
  if not DirectoryExists(ExtractFilepath(Application.ExeName) + PDV_GLOBAL_DIR) then
    ForceDirectories(ExtractFilepath(Application.ExeName) + PDV_GLOBAL_DIR);

  case fServerConnection.ConnectType of
    CON_TYPE_SERVER :
    begin
      SetStatus('Criando arquivos globais ...', 25);
      AddHistory('SQL (Global) : Inicio de arquivos');

      with quRun do
       try
         if Active then
           Close;

         SQL.Clear;
         SQL.ADD(Format('SELECT Franchise FROM Store WHERE IDStore = %D', [fIDStore]));
         Open;
         FIsFranquia := FieldByName('Franchise').AsBoolean;
       finally
         Close;
       end;

       sPath := ExtractFilePath(Application.ExeName) + TEMP_DIR;

       Result := CreateGlobalFiles(cdsMedia, sPath, PDV_MEDIA_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsSystemUser, sPath, PDV_SYSTEM_USER_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsOtherCommission, sPath, PDV_OTHER_COMMIS_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsCustomer, sPath, PDV_CUSTOMER_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsParam, sPath, PDV_PARAM_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsStore, sPath, PDV_STORE_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsBarcode, sPath, PDV_BARCODE_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsUserTypeToSysFunction, sPath, PDV_USER_TO_SYS_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsUserRights, sPath, PDV_USER_RIGHTS_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsModel, sPath, PDV_MODEL_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsModelAccessory, sPath, PDV_ACCESSORY_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsMeioPag, sPath, PDV_PAY_TYPR_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsQty, sPath, PDV_QTY_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsCashReg, sPath, PDV_CASHREGISTER_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsAccess, sPath, PDV_ACCES_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsTaxCategory, sPath, PDV_TAXCATEGORY_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsKitModel, sPath, PDV_KITMODEL_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsBanco, sPath, PDV_BANK_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsDiscRange, sPath, PDV_DISCRANGE_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsInvFeatures, sPath, PDV_INV_FEATURES_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsInvTechFeatures, sPath, PDV_INV_TECH_FEATURES_FILE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsInvDepartment, sPath, PDV_INV_DEPARTMENT);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsInvModelDepartment, sPath, PDV_INV_MODEL_DEPARTMENT);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsInvSerial, sPath, PDV_INV_MODEL_SERIAL);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsStoreTablePrice, sPath, PDV_INV_STORE_PRICE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsModelTablePrice, sPath, PDV_INV_MODEL_PRICE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsDocumentType, sPath, PDV_MNT_DOCUMENT_TYPE);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsCashRegLogReason, sPath, PDV_CASH_REG_LOG_REASON);
       IncPBPos;
       if Result then
          Result := CreateGlobalFiles(cdsMeioPagMinSale, sPath, PDV_PAY_TYPE_MIN_SALE);
       IncPBPos;

       if Result and (fLocalSetting.IDStoreList <> '') then
       try
         IDStoreOriginal := fIDStore;
         sStoreList := TStringList.Create;
         sStoreList.CommaText := FLocalSetting.IDStoreList;
         for i := 0 to sStoreList.Count -1 do
         begin
           fIDStore := StrToInt(sStoreList.Strings[i]);
           SetStatus('Criando arquivos para loja ...', 3);
           if Result then
             Result := CreateGlobalFiles(cdsModel, sPath + sStoreList.Strings[i], '\' + PDV_MODEL_FILE);
           IncPBPos;
           if Result then
             Result := CreateGlobalFiles(cdsModelAccessory, sPath + sStoreList.Strings[i], '\' + PDV_ACCESSORY_FILE);
           IncPBPos;
           if Result then
             Result := CreateGlobalFiles(cdsInvModelDepartment, sPath + sStoreList.Strings[i], '\' + PDV_INV_MODEL_DEPARTMENT);
           IncPBPos;
           if Result then
             Result := CreateGlobalFiles(cdsStoreTablePrice, sPath + sStoreList.Strings[i], '\' + PDV_INV_STORE_PRICE);
           IncPBPos;
         end;
       finally;
         fIDStore := IDStoreOriginal;
         FreeAndNil(sStoreList);
         end;

       if Result then
       begin
         Result := TransferServerFiles;
         AddHistory('SQL (Global) : Final da criação dos arquivo');

         if Result then
         begin
           Result := ZipServerFiles;
           AddHistory('SQL (Global) : Zippar os arquivo');
           WriteIniDateTime('ServerSchedule','SuccedDate', Now);
         end;
       end
       else
         AddErrorHistory('SQL (Global) : Erro arquivos não atualizados.');
     end;

   CON_TYPE_FTP :
     begin
       SetStatus('Download arquivos do FTP ...', 2);
       AddHistory('FTP (Global) : inicio do download ');

       ChangeFTPDir(FServerConnection.GlobalDir);
       IncPBPos;
       Result := GetFTPFile(ZIP_GLOBAL_FILE_NAME);
       IncPBPos;

       //Importar arquivos para loja
       SetStatus('Download arquivos da loja pelo FTP ...', 3);
       if Result then
       begin
         try
           ChangeFTPDir(IntToStr(fIDStore));

           iSize := FileSizeFTP(Format(ZIP_STORE_FILE_NAME, [IntToStr(fIDStore)]));
           if (iSize <> -1) then
             Result := GetFTPFile(Format(ZIP_STORE_FILE_NAME, [IntToStr(fIDStore)]));

         except
           on E: Exception do
            ReportError('FTP (Global) : ' + E.Message);
          end;

         DirUpFTP;
       end;

       IncPBPos;
       DirUpFTP;

       if Result then
       begin
          Result := UnZipServerFiles;
          AddHistory('SQL (Global) : Unzippar os arquivo OK');

          if Result then
          begin
            Result := TransferServerFiles;
            AddHistory('FTP (Global) : download OK');
            WriteIniDateTime('ServerSchedule','SuccedDate', Now);
          end;
       end
       else
         AddErrorHistory('FTP (Global) : Error transferindo arquivos');
     end;
   end;
end;

function TDMThread.ImportDir(ADir: String; AIDCashReg: Integer; IncludeSince: String;
  var LastDate: String): Boolean;
var
  SR: TSearchRec;
  stlArquivos: TStringList;
  stlCaixaFechado: TStringList;
  AI: TArquivoImportar;
  I : Integer;
  DataArquivo: String;
  FechouCaixa: Boolean;
  LastFileName : String;
  ARemoteDir: String;
begin
  Result := True;
  try
    ARemoteDir := IntToStr(AIDCashReg);
    LastDate := IncludeSince;
    stlArquivos := TStringList.Create;
    try
      if FindFirst(ADir + '*.ven', faAnyFile, SR) = 0 then
      try
        repeat
          if (SR.Attr and faDirectory) = 0 then
          begin
            AI          := TArquivoImportar.Create;
            AI.Nome     := SR.Name;
            AI.Data     := FileDateToDateTime(SR.Time);
            DataArquivo := FormatDateTime('YYYYMMDDHHNNSS', AI.Data);
            if (IncludeSince = '') or ((IncludeSince <> '') and (DataArquivo > IncludeSince)) then
              stlArquivos.AddObject(DataArquivo, AI);
          end;
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;

      stlArquivos.Sort;

      FFileCount := stlArquivos.Count;
      FFileIndex := 0;

      ShowDebug('Arquivos para importar : ' + stlArquivos.Text);

      case FServerConnection.ConnectType of

        CON_TYPE_SERVER :
          begin
            stlCaixaFechado := TStringList.Create;
            try
              iIDCashRegReducaoZ := AIDCashReg;
              ResetCashReg;
              if stlArquivos.Count > 0 then
                AddHistory('SQL (POS) : Importando :' + ADir);
              for I := 0 to stlArquivos.Count - 1 do
              begin
                Inc(FFileIndex);
                FechouCaixa := False;
                Result := ImportFile(ADir + TArquivoImportar(stlArquivos.Objects[I]).Nome, FechouCaixa);
                //Mover caixa para arquivo morto
                if FechouCaixa then
                  stlCaixaFechado.Add(IntToStr(AIDCashReg) + '\' + TArquivoImportar(stlArquivos.Objects[I]).Nome);
                if not Result then
                  Break;
                if FechouCaixa then
                  LastDate := FormatDateTime('YYYYMMDDHHNNSS', TArquivoImportar(stlArquivos.Objects[I]).Data);
                LastFileName := TArquivoImportar(stlArquivos.Objects[I]).Nome;
              end;

              if stlCaixaFechado.Count > 0 then
                MoverCaixasFechados(stlCaixaFechado, AIDCashReg);

              if stlArquivos.Count > 0 then
              begin
                AddHistory('SQL (POS) : Importado  : ' + ADir + ' OK');
                WriteIniDateTime(ARemoteDir, POS_LAST_IMPORT_DATE, Now);
                WriteIniString(ARemoteDir, POS_PDV_KEY_LAST_FILE, LastFileName);
                WriteIniString(IntToStr(AIDCashreg), POS_PDV_KEY_LAST_DATE, LastDate);
              end;

            finally
              FreeAndNil(stlCaixaFechado);
            end;
          end;

        CON_TYPE_FTP :
          begin
            SetStatus('FTP Transferindo (POS files) ...', stlArquivos.Count);

            AddHistory('FTP (POS) : Trocando dir ' + FServerConnection.POSDir);
            ChangeFTPDir(FServerConnection.POSDir);
            AddHistory('FTP (POS) : Dir trocado ' + FServerConnection.POSDir);

            for I := 0 to stlArquivos.Count - 1 do
            begin

              if CanOpenFileFS(ADir + TArquivoImportar(stlArquivos.Objects[I]).Nome) then
              begin
                if SetFTPFile(ADir, ARemoteDir, TArquivoImportar(stlArquivos.Objects[I]).Nome) then
                begin
                  LastDate     := FormatDateTime('YYYYMMDDHHNNSS', TArquivoImportar(stlArquivos.Objects[I]).Data);
                  LastFileName := TArquivoImportar(stlArquivos.Objects[I]).Nome;
                  WriteIniDateTime(ARemoteDir, POS_LAST_IMPORT_DATE, Now);
                  WriteIniString(ARemoteDir, POS_PDV_KEY_LAST_FILE, LastFileName);
                  WriteIniString(IntToStr(AIDCashreg), POS_PDV_KEY_LAST_DATE, LastDate);
                end;
              end else
                AddHistory('FTP (POS) : arquivo em uso : ' + ADir + TArquivoImportar(stlArquivos.Objects[I]).Nome);
                
              IncPBPos;
            end;

            if stlArquivos.Count > 0 then
              AddHistory('FTP (POS) : Transferido '+IntToStr(stlArquivos.Count)+' file(s) OK');

            DirUpFTP;
          end;
     end;

    finally
      stlArquivos.Free;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(E.Message);
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

procedure TDMThread.ResetCashReg;
begin
  IDCashReg    := -1;
  IDCashRegMov := -1;
  IDCashRegLog := -1;
  IDPreSale    := -1;
  IDPessoa     := -1;
  CashImported := False;
  PreSaleImported := False;
  CashClosed      := False;
end;

function TDMThread.ImportFile(AFileName: String; var ACashClosed: Boolean): Boolean;
var
  LinhaFechamento, ErrorCashClosed: Boolean;
  //Arq: TextFile;
  sTemp: String;
  stlCountLines: TStringList;
  i, iLine : Integer;
  stlSaleFile: TStringList;
begin
  ResetCashReg;
  Result := True;

  try
    stlCountLines := TStringList.Create;
    try
      LoadFileNoLock(stlCountLines, AFileName);
      FFileInfo.LineCount := stlCountLines.Count;
    finally
      stlCountLines.Free;
    end;
  except
  end;

  FFileInfo.FileName := ExtractFileName(AFileName);
  FFileInfo.Line     := 0;
  iLine              := 0;

  AddImportHistory('SQL (Import POS file): ' + AFileName);
  ShowDebug('Importando : ' + FFileInfo.FileName);

  SetStatus(Format('%S (%D/%D)', [FFileInfo.FileName, FFileIndex, FFileCount]), FFileInfo.LineCount);

  try
    stlSaleFile := TStringList.Create;
    ADODBConnect.BeginTrans;
    try
      ACashClosed := False;
      LinhaFechamento := False;
      stlSaleFile.LoadFromFile(AFileName);

      try
        for i := 0 to stlSaleFile.Count-1 do
        begin
          IncPBPos;
          inc(iLine);
          sTemp := stlSaleFile.Strings[i];

          if (Trim(sTemp) <> '') then
            Result := Result and ImportLine(sTemp, LinhaFechamento, ErrorCashClosed)
          else
            Result := True;

          if ErrorCashClosed then
          begin
            ACashClosed := True;
            Result := True; // Se sair como false ele não continua os outros arquivos
            Break;
          end;

          if not Result then
          begin
            Result := True; // Se sair como false ele não continua os outros arquivos
            ADODBConnect.RollbackTrans;
            AddErrorHistory(Format(' *** Erro *** %S', [FFileInfo.FileName + ' line (' +  IntToStr(iLine) + ') Sale ' + FFileInfo.SaleCode]));
            Break;
          end;
          ACashClosed := ACashClosed or LinhaFechamento or ErrorCashClosed;
        end;

      finally
        FreeAndNil(stlSaleFile);
      end;

      // A transação pode ter sido abortada
      // precisa testar antes
      if ADODBConnect.InTransaction then
        ADODBConnect.CommitTrans;
    except
      on E: Exception do
      begin
        if ADODBConnect.InTransaction then
          ADODBConnect.RollbackTrans;
        if FFileInfo.Line <> 0 then
          iLine := FFileInfo.Line;
        raise Exception.Create(FFileInfo.FileName + ' ' + E.Message + '. line: ' + IntToStr(iLine));
      end;
    end
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
  ResetCashReg;
end;

function TDMThread.ImportLine(ALine: String; var ACashClosed: Boolean; var ErrorCashClosed: Boolean): Boolean;
var
  iPos : Integer;
begin
  ErrorCashClosed := False;
  ACashClosed     := False;
  Result          := True;
  case FSaleLineParser.LineType(ALine) of
    sltOpenCash:    begin
                    FLastSale.ClearLastSale;
                    Result := OpenCash(ALine, ErrorCashClosed);
                    end;
    sltOpenSale:    begin
                      if FLastSale.FOpenSaleLine <> '' then
                      begin
                        {T - !!!DANGER!!! - T}
                        if FLastSale.FPaymentList.Count > 0 then
                          Result := ForceClosingSale
                        else
                          FLastSale.ClearLastSale;
                      end;
                      FLastSale.FOpenSaleLine := ALine;
                    end;
    sltAddCustomer: FLastSale.FCustomerLine := ALine;
    sltAddItem:     FLastSale.AddItem(ALine);
    sltAddSerialNumber: FLastSale.AddItemSerial(ALine);
    sltAddPayment:  FLastSale.AddPayment(ALine);
    sltCloseSale:   begin
                    FTmpLastCloseLine := ALine;
                    FLastSale.FCloseSaleLine := ALine;
                    Result := ImportSale;
                    end;
    sltAbortSale: begin

                    if FLastSale.FOpenSaleLine <> '' then
                    begin
                      FLastSale.FCanceled := True;
                      Result := ImportSale;
                    end
                    else
                      Result := True;

                  end;
    sltCancelItem: begin
                     FSaleLineParser.GetItemCanceled(ALine, iPos);
                     FLastSale.CancelItem(iPos);
                   end;
    sltCloseCash:
    begin
      if FLastSale.FOpenSaleLine <> '' then
      begin
        {T - !!!DANGER!!! - T}
        if FLastSale.FPaymentList.Count > 0 then
          Result := ForceClosingSale
        else
          FLastSale.ClearLastSale;
      end;

      Result := CloseCash(ALine);
      ACashClosed := Result;
      FLastSale.ClearLastSale;
    end;
    sltPC:          Result := AddPC(ALine);
    sltWC:          Result := AddWC(ALine);
    sltCancelSale:
    begin
      Result := CancelSale(ALine);
      FLastSale.ClearLastSale;
    end;
    sltRemovedItem:    Result := AddRemovedItem(ALine);
    sltReducaoZ:       Result := AddReducaoZ(ALine);
    sltTotParcial:     Result := AddTotParcial(ALine);
    sltOBS:            Result := SaleOBS(ALine);
    sltCupomVinculado: Result := CupomVinculado(ALine);
    sltUnknow:         Result := False;
  end;
end;

function TDMThread.OpenCash(ALine: String; var ErrorCashClosed: Boolean): Boolean;
var
  ROC: TRegOpenCash;
begin
  Result := True;
  try
    if IDCashRegMov <> -1 then
      raise Exception.Create('SQL (POS) %S : Caixa já esta aberto');

    FSaleLineParser.GetOpenCash(ALine, ROC);

    IDCashReg := ROC.AIDCashReg;

    ROC.AIDCashRegMov := GetCashRegMovID(ROC.AIDCashReg, ROC.ADate, CashClosed);
    CashClosed := not CashClosed;

    ErrorCashClosed := False;

    if ROC.AIDCashRegMov <> -1 then
    begin
      if CashClosed then
      begin
        ErrorCashClosed := True;
        Raise Exception.Create('SQL (POS) %S : Caixa já esta fechado');
      end
      else
      begin
        IDCashRegMov := ROC.AIDCashRegMov;
        Exit;
      end;
    end;

    CashClosed := False;

    with spCashRegOpen do
    begin
      Parameters.ParamByName('@Bill100').Value        := ROC.A100;
      Parameters.ParamByName('@Bill50').Value         := ROC.A50;
      Parameters.ParamByName('@Bill20').Value         := ROC.A20;
      Parameters.ParamByName('@Bill10').Value         := ROC.A10;
      Parameters.ParamByName('@Bill5').Value          := ROC.A05;
      Parameters.ParamByName('@Bill2').Value          := ROC.A02;
      Parameters.ParamByName('@Bill1').Value          := ROC.A01;
      Parameters.ParamByName('@Coin1').Value          := ROC.A0100;
      Parameters.ParamByName('@Coin050').Value        := ROC.A050;
      Parameters.ParamByName('@Coin025').Value        := ROC.A025;
      Parameters.ParamByName('@Coin010').Value        := ROC.A010;
      Parameters.ParamByName('@Coin005').Value        := ROC.A005;
      Parameters.ParamByName('@Coin001').Value        := ROC.A001;
      Parameters.ParamByName('@IDCashregister').Value := ROC.AIDCashReg;
      Parameters.ParamByName('@IDUser').Value         := ROC.AIDUser;
      Parameters.ParamByName('@OpenMoney').Value      := ROC.ATotalCount;
      Parameters.ParamByName('@TotalCash').Value      := ROC.ATotalCash;
      Parameters.ParamByName('@TotalCard').Value      := ROC.ATotalCard;
      Parameters.ParamByName('@TotalCardPre').Value   := ROC.ATotalPreCard;
      Parameters.ParamByName('@TotalCheck').Value     := ROC.ATotalCheck;
      Parameters.ParamByName('@TotalOther').Value     := ROC.ATotalOther;
      Parameters.ParamByName('@TotalDebit').Value     := ROC.ATotalDebit;
      Parameters.ParamByName('@Date').Value           := ROC.ADate;
      Parameters.ParamByName('@COO').Value            := ROC.ACOO;
      Parameters.ParamByName('@GNF').Value            := ROC.AGNF;
      ExecProc;
      if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
        raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
      IDCashRegLog := spCashRegOpen.Parameters.ParamByName('@IDCashRegLog').Value;
      IDCashRegMov := spCashRegOpen.Parameters.ParamByName('@IDCashRegMov').Value;

      //WriteIniString(Copy(FFileInfo.FileName, 0, 4),Copy(FFileInfo.FileName, 6, 15),'Aberta');
    end;
  except
    on E: Exception do
    begin
      if Pos('Caixa já esta fechado', E.Message) > 0 then
        AddHistory(FormatError(E.Message))
      else
        AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.OpenSale(ALine: String): Boolean;
var
  ROS: TRegOpenSale;
  iIDPreSale : Integer;
begin
  Result := True;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    if IDPreSale <> -1 then
      raise Exception.Create('SQL (POS) %S : Já existe uma venda aberta');

    FSaleLineParser.GetOpenSale(ALine, ROS);

    FFileInfo.SaleCode := ROS.ASaleCode;

    FLastSale.FSaleCode := ROS.ASaleCode;
    FLastSale.FIDCashRegister := ROS.AIDCashreg;
    FLastSale.FIDUser := 0;
    LastIDPreSale := 0;

    IDPessoa := 1;

    if ROS.AIDPreSale = -1 then
    begin
      ROS.AIDPreSale := GetPreSaleID(ROS.AIDStore, ROS.AIDCashreg, ROS.APreSaleDate, ROS.ASaleCode);
      if ROS.AIDPreSale <> -1 then
      begin
        IDPreSale       := ROS.AIDPreSale;
        FPreSaleDate    := ROS.APreSaleDate;
        PreSaleImported := True;
        LastIDPreSale   := IDPreSale;
        Exit;
      end;
    end
    else
    begin
      if HoldExists(ROS.AIDPreSale, PreSaleImported) then
      begin
        if not PreSaleImported then
        begin
          iIDPreSale     := ROS.AIDPreSale;
          ROS.AIDPreSale := GetPreSaleID(ROS.AIDStore, ROS.AIDCashreg, ROS.APreSaleDate, ROS.ASaleCode);
          if ROS.AIDPreSale <> -1 then
          begin
            IDPreSale       := ROS.AIDPreSale;
            FPreSaleDate    := ROS.APreSaleDate;
            PreSaleImported := True;
            LastIDPreSale   := ROS.AIDPreSale;
            Exit;
          end
          else
          begin
            DeleteHold(iIDPreSale);
            DecHold(ROS.AIDPreSale);
          end;
        end;
        IDPreSale     := ROS.AIDPreSale;
        LastIDPreSale := ROS.AIDPreSale;
      end
      else //Se nao existir com o mesmo ID verificar se ja foi importado com outro ID
      begin
        ROS.AIDPreSale := GetPreSaleID(ROS.AIDStore, ROS.AIDCashreg, ROS.APreSaleDate, ROS.ASaleCode);
        if ROS.AIDPreSale <> -1 then
        begin
          IDPreSale       := ROS.AIDPreSale;
          FPreSaleDate    := ROS.APreSaleDate;
          PreSaleImported := True;
          LastIDPreSale   := ROS.AIDPreSale;
          Exit;
        end;
      end;
    end;

    FInvoice := TInvoice.Create(ADODBConnect);

    FInvoice.IDDeliverType    := ROS.ADeliverType;
    FInvoice.IsLayaway        := ROS.AIsLayaway;
    FInvoice.IDStore          := ROS.AIDStore;
    FInvoice.FirstName        := ROS.AFName;
    FInvoice.LastName         := ROS.ALName;
    FInvoice.Zip              := ROS.AZip;
    FInvoice.PreSaleDate      := ROS.APreSaleDate;
    FInvoice.InvoiceDate      := ROS.APreSaleDate;
    FInvoice.IDCustomer       := IDPessoa;
    FInvoice.IDMedia          := ROS.AIDMedia;
    FInvoice.IDOtherComission := ROS.AIDOtherComm;
    FInvoice.IDTouristGroup   := ROS.AIDTourGroup;
    //FInvoice.Note             := Trim(ROS.AInvObs);
    FInvoice.Note             := FLastSale.FOBS;
    FInvoice.COO              := ROS.ACOO;
    FInvoice.SaleCode         := ROS.ASaleCode;
    FInvoice.InvoiceCode      := ROS.ACCF;
    FInvoice.PuppyTracker     := ROS.APuppyTracker;
    FInvoice.ECFSerial        := ROS.ASerialECF;
    FInvoice.TaxExempt        := ROS.ATaxExempt;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.AddCustomer(ALine: String): Boolean;
var
  RAC: TRegAddCustomer;
  APessoa: String;
  tmpIDPessoa: Integer;
begin
  Result := True;
  try
    FSaleLineParser.GetAddCustomer(ALine, RAC);

    // Remove quebra de linha
    RAC.AOBS := StringReplace(RAC.AOBS, #13#10, ' ', [rfReplaceAll]);
    APessoa := Copy(Trim(RAC.AFirstName + ' ' + RAC.ALastName), 1, 50);
    tmpIDPessoa := GetPessoaID(APessoa, Trim(RAC.ATelefone));

    if not PreSaleImported then
    begin
      FInvoice.FirstName := RAC.AFirstName;
      FInvoice.LastName  := RAC.ALastName;
      FInvoice.CPFCGC    := RAC.ACPF;
    end;

    if tmpIDPessoa <> -1 then
    begin
      IDPessoa := tmpIDPessoa;
      Exit;
    end
    else
      tmpIDPessoa := GetNextID(MR_PESSOA_ID);

    with cmdPessoa do
    begin
       Parameters.ParamByName('IDPessoa').Value         := tmpIDPessoa;
       Parameters.ParamByName('IDTipoPessoa').Value     := 1;
       Parameters.ParamByName('IDStore').Value          := IDStore;
       Parameters.ParamByName('IDTipoPessoaRoot').Value := 1;
       Parameters.ParamByName('IDUser').Value           := 0;
       Parameters.ParamByName('Pessoa').Value           := APessoa;
       Parameters.ParamByName('PessoaFirstName').Value  := Copy(Trim(RAC.AFirstName), 1, 30);;
       Parameters.ParamByName('PessoaLastName').Value   := Copy(Trim(RAC.ALastName), 1, 30);;
       Parameters.ParamByName('Endereco').Value         := RAC.AEndereco;
       Parameters.ParamByName('Cidade').Value           := RAC.ACidade;
       Parameters.ParamByName('CEP').Value              := RAC.AZip;
       Parameters.ParamByName('Telefone').Value         := Trim(RAC.ATelefone);
       Parameters.ParamByName('Juridico').Value         := RAC.AJuridico;
       Parameters.ParamByName('CPF').Value              := RAC.ACPF;
       Parameters.ParamByName('Bairro').Value           := RAC.ABairro;
       Parameters.ParamByName('PhoneAreaCode').Value    := RAC.ATelDDD;
       Parameters.ParamByName('CellAreaCode').Value     := RAC.ACelDDD;
       Parameters.ParamByName('Cellular').Value         := RAC.ACelelular;
       Parameters.ParamByName('Email').Value            := RAC.AEmail;
       Parameters.ParamByName('HomePage').Value         := RAC.AWebSite;
       Parameters.ParamByName('Identidade').Value       := RAC.AIdentidate;
       Parameters.ParamByName('OrgaoEmissor').Value     := RAC.AOrgEmiss;
       Parameters.ParamByName('CreationDate').Value     := Now;

       if RAC.AExpDate <> 0 then
          Parameters.ParamByName('DataExpedicao').Value := RAC.AExpDate;
       if RAC.ABirthDate <> 0 then
          Parameters.ParamByName('Nascimento').Value     := RAC.ABirthDate;

       Parameters.ParamByName('CustomerCard').Value     := RAC.ACustCard;
       Parameters.ParamByName('CartMotorista').Value    := RAC.ACMotorista;
       Parameters.ParamByName('NomeJuridico').Value     := RAC.ANomeJuridico;
       Parameters.ParamByName('InscEstadual').Value     := RAC.AInscEstadual;
       Parameters.ParamByName('InscMunicipal').Value    := RAC.AInscMunicipal;
       Parameters.ParamByName('Contatos').Value         := RAC.AContato;
       Parameters.ParamByName('OBS').Value              := RAC.AOBS;
       try
         Execute;
       except
         if RAC.AExpDate <> 0 then
            Parameters.ParamByName('DataExpedicao').Value := null;
         if RAC.ABirthDate <> 0 then
            Parameters.ParamByName('Nascimento').Value     := null;
         Execute;
       end;
       IDPessoa := tmpIDPessoa;
    end;

    FInvoice.IDCustomer := IDPessoa;
  except
    on E: Exception do
    begin
      AddErrorHistory(Format('SQL (POS) %S : ', [FormatError(E.Message)]));
    end;
  end;
end;

function TDMThread.RemovedItemImported(RRI: TRegRemovedItem): Boolean;
begin

   Result := True;

   with quTestRemovedItem do
   try
     if Active then
       Close;
      Parameters.ParamByName('IDCashRegister').Value := RRI.AIDCashReg;
      Parameters.ParamByName('IDModel').Value        := RRI.AIDModel;
      Parameters.ParamByName('IDStore').Value        := RRI.AIDStore;
      Parameters.ParamByName('IDUserAuto').Value     := RRI.AIDUserAuto;
      Parameters.ParamByName('MovDate').Value        := RRI.AMovDate;
      Parameters.ParamByName('SaleCode').Value       := RRI.ASaleCode;
      Parameters.ParamByName('PosicaoItem').Value    := RRI.APosicaoItem;
      Open;
      Result := (RecordCount>0);
   finally
     Close;
     end;
end;

function TDMThread.AddSubRemovedItem(RRI: TRegRemovedItem;
  TestImported: Boolean): Boolean;
begin
  Result := True;

  if PreSaleImported then
    Exit;

  try

    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    if TestImported and RemovedItemImported(RRI) then
      Exit;

    with cmdAddDeletedItem do
    begin
      Parameters.ParamByName('IDRemovedItem').Value      := GetNextID('Sal_RemovedItem.IDRemovedItem');
      Parameters.ParamByName('IDCashRegister').Value     := RRI.AIDCashReg;
      Parameters.ParamByName('IDModel').Value            := RRI.AIDModel;
      Parameters.ParamByName('IDStore').Value            := RRI.AIDStore;
      Parameters.ParamByName('IDDepartment').Value       := RRI.AIDDepartment;
      Parameters.ParamByName('IDUserAuto').Value         := RRI.AIDUserAuto;
      Parameters.ParamByName('IDPessoa').Value           := RRI.AIDCommis;
      Parameters.ParamByName('IDUser').Value             := RRI.AIDUser;
      Parameters.ParamByName('MovDate').Value            := RRI.AMovDate;
      Parameters.ParamByName('Qty').Value                := RRI.AQty;
      Parameters.ParamByName('SalePrice').Value          := RRI.ASale;
      Parameters.ParamByName('CostPrice').Value          := RRI.ACost;
      Parameters.ParamByName('Discount').Value           := RRI.ADiscount;
      Parameters.ParamByName('SaleCode').Value           := RRI.ASaleCode;

      Parameters.ParamByName('PosicaoItem').Value        := RRI.APosicaoItem;
      Parameters.ParamByName('Acrescimo').Value          := RRI.AAcrescimo;
      Parameters.ParamByName('TotalizadorParcial').Value := RRI.ATotParcial;
      if RRI.AIDNotasCanceladas <> 0 then
        Parameters.ParamByName('IDNotasCanceladas').Value  := RRI.AIDNotasCanceladas
      else
        Parameters.ParamByName('IDNotasCanceladas').Value  := Null;
      if (RRI.AIDPreSale <> 0) and (RRI.AIDPreSale <> -1) then
        Parameters.ParamByName('IDPreSale').Value          := RRI.AIDPreSale
      else
        Parameters.ParamByName('IDPreSale').Value          := Null;
      Execute;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;

end;

function TDMThread.AddRemovedItem(ALine : String):Boolean;
var
  RRI: TRegRemovedItem;
begin
  Result := True;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetRemovedItem(ALine, RRI);

    Result := AddSubRemovedItem(RRI, True);

  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.AddItemRemoved(ALine: String; Index : Integer): Boolean;
var
  InvoiceRemovedItem : TInvoiceRemovedItem;
  fRAI: TRegAddItem;
begin

  Result := True;

  if PreSaleImported then
    Exit;

  try
  
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetAddItem(ALine, fRAI);

    InvoiceRemovedItem := TInvoiceRemovedItem.Create(ADODBConnect);

    InvoiceRemovedItem.IDCashRegister     := FLastSale.FIDCashRegister;
    InvoiceRemovedItem.IDCustomer         := IDPessoa;
    InvoiceRemovedItem.IDPreSale          := IDPreSale;
    InvoiceRemovedItem.IDModel            := fRAI.AIDModel;
    InvoiceRemovedItem.IDStore            := fRAI.AIDStore;
    InvoiceRemovedItem.Qty                := fRAI.AQty;
    InvoiceRemovedItem.Discount           := fRAI.ADiscount;
    InvoiceRemovedItem.SalePrice          := fRAI.ASale;
    InvoiceRemovedItem.CostPrice          := fRAI.ACost;
    InvoiceRemovedItem.IDUser             := fRAI.AIDUser;
    InvoiceRemovedItem.IDComission        := fRAI.AIDCommis;
    InvoiceRemovedItem.MovDate            := fRAI.AMovDate;
    InvoiceRemovedItem.IsPromo            := False;
    InvoiceRemovedItem.IDDepartment       := fRAI.AIDDepartment;
    InvoiceRemovedItem.TotParcial         := fRAI.ATotParcial;
    InvoiceRemovedItem.ItemIndex          := Index;
    InvoiceRemovedItem.Acrescimo          := 0;

    FInvoice.AddInvoiceRemovedItem(InvoiceRemovedItem);

  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;

end;

function TDMThread.AddItem(ALine: String; ASerialNumbers : TList; Index : Integer): Boolean;
var
  RAI: TRegAddItem;
  InvoiceItem: TInvoiceItem;
  InvoiceItemCommission: TInvoiceItemCommission;
  InvoiceItemSerial: TInvoiceItemSerial;
  InvoiceItemPrice: TInvoiceItemPrice;
  InvoiceItemDocument: TInvoiceItemDocument;
  i : Integer;
  RSN: TRegSerialNumber;
begin

  Result := True;
  if PreSaleImported then
    Exit;
    
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    //if IDPreSale = -1 then
    //  raise Exception.Create('SQL (POS) %S : Não existe venda aberta');

    FSaleLineParser.GetAddItem(ALine, RAI);

    // Adiciona o item
    InvoiceItem := TInvoiceItem.Create(ADODBConnect);
    InvoiceItemCommission := TInvoiceItemCommission.Create(ADODBConnect);

    InvoiceItem.IDCashRegister     := FLastSale.FIDCashRegister;
    InvoiceItem.IDCustomer         := IDPessoa;
    InvoiceItem.IDPreSale          := IDPreSale;
    InvoiceItem.IDModel            := RAI.AIDModel;
    InvoiceItem.IDStore            := RAI.AIDStore;
    InvoiceItem.Qty                := RAI.AQty;
    InvoiceItem.Discount           := RAI.ADiscount;
    InvoiceItem.SalePrice          := RAI.ASale;
    InvoiceItem.CostPrice          := RAI.ACost;
    InvoiceItem.IDUser             := RAI.AIDUser;
    InvoiceItem.IDComission        := RAI.AIDCommis;
    InvoiceItem.MovDate            := RAI.AMovDate;
    InvoiceItem.IsPromo            := False;
    InvoiceItem.IDDepartment       := RAI.AIDDepartment;
    InvoiceItem.ItemIndex          := Index;
    InvoiceItem.TotParcial         := RAI.ATotParcial;

    InvoiceItemCommission.IDCommission      := RAI.AIDCommis;
    InvoiceItemCommission.CommissionPercent := 100;

    InvoiceItem.CommssionList.Add(InvoiceItemCommission);

    for i := 0 to Pred(ASerialNumbers.Count) do
    begin
      FSaleLineParser.GetAddSerialNumber(TLastSaleItemSerial(ASerialNumbers[I]).FItemSerialLine, RSN);
      InvoiceItemSerial := TInvoiceItemSerial.Create(ADODBConnect);
      InvoiceItemSerial.SerialNumber         := RSN.ASerialNumber;
      InvoiceItemSerial.IdentificationNumber := RSN.AIdentificationNumber;
      InvoiceItemSerial.IDModel              := InvoiceItem.IDModel;
      InvoiceItemSerial.IDStore              := InvoiceItem.IDStore;
      InvoiceItemSerial.IDPreSale            := InvoiceItem.IDPreSale;
      InvoiceItemSerial.GiftIDUser           := InvoiceItem.IDUser;
      InvoiceItemSerial.GiftTotal            := ((InvoiceItem.SalePrice * InvoiceItem.Qty) - InvoiceItem.Discount);
      InvoiceItem.SerialNumberList.Add(InvoiceItemSerial);
    end;

    if RAI.AIDDescriptionPrice <> 0 then
    begin
      InvoiceItemPrice := TInvoiceItemPrice.Create(ADODBConnect);
      InvoiceItemPrice.IDDescriptionPrice := RAI.AIDDescriptionPrice;
      InvoiceItemPrice.IDVendorPrice      := RAI.AIDVendorPrice;
      InvoiceItemPrice.SuggPrice          := RAI.ASuggPrice;

      InvoiceItem.ItemPrice := InvoiceItemPrice;
    end;

    if RAI.ADocumentNumber <> '' then
    begin
      InvoiceItemDocument := TInvoiceItemDocument.Create(ADODBConnect);
      InvoiceItemDocument.DocumentNumber := RAI.ADocumentNumber;
      InvoiceItemDocument.IDDocumentType := RAI.AIDDocumentType;

      InvoiceItem.ItemDocument := InvoiceItemDocument;
    end;

    FInvoice.AddInvoiceItem(InvoiceItem);
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
  
end;

function TDMThread.AddPayment(ALine: String): Boolean;
var
  RAP: TRegAddPayment;
  InvoicePayment: TInvoicePayment;
begin
  Result := True;
  if PreSaleImported then
    Exit;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    //if IDPreSale = -1 then
    //  raise Exception.Create('SQL (POS) %S : Não existe venda aberta');

    FSaleLineParser.GetAddPayment(ALine, RAP);

    InvoicePayment := TInvoicePayment.Create(ADODBConnect);

    InvoicePayment.IDPreSale        := IDPreSale;
    InvoicePayment.IDStore          := RAP.AIDStore;
    InvoicePayment.IDUser           := RAP.AIDUser;
    InvoicePayment.IDCustomer       := IDPessoa;
    InvoicePayment.IDMeioPag        := RAP.AIDMeioPag;
    InvoicePayment.IDCashRegMov     := IDCashRegMov;
    InvoicePayment.PreSaleDate      := RAP.APreSaleDate;
    InvoicePayment.ExpirationDate   := Int(RAP.AExpireDate);
    InvoicePayment.Parcela          := RAP.ANumParcela;
    InvoicePayment.Authorization    := RAP.AAutotize;
    InvoicePayment.PaymentValue     := RAP.ATotalInvoice;
    InvoicePayment.CheckNumber      := '';
    InvoicePayment.CustomerDocument := '';
    InvoicePayment.CustomerName     := '';
    InvoicePayment.CustomerPhone    := '';
    InvoicePayment.IDBankCheck      := 0;
    InvoicePayment.OBS              := '';
    InvoicePayment.PaymentPlace     := RAP.APaymentPlace;
    InvoicePayment.IsPredatado      := RAP.AIsPreDatado;

    FInvoice.PaymentList.Add(InvoicePayment);
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.AddPC(ALine: String): Boolean;
var
  RAPC: TRegAddPC;
begin
  Result := True;
  if PreSaleImported then
    Exit;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetAddPC(ALine, RAPC);
    if LogExists(IDCashReg, RAPC.ADate) then
      Exit;

    with spCashRegAddCash do
    begin
       Parameters.ParamByName('@IDCashRegMov').Value := IDCashRegMov;
       Parameters.ParamByName('@IDUser').Value       := RAPC.AIDUser;
       Parameters.ParamByName('@TotalCash').Value    := RAPC.ACash;
       Parameters.ParamByName('@Date').Value         := RAPC.ADate;
       Parameters.ParamByName('@IDReason').Value     := 0;
       if Trim(RAPC.AOBS) <> '' then
         Parameters.ParamByName('@OBS').Value        := RAPC.AOBS
       else
         Parameters.ParamByName('@OBS').Value        := Null;

       Parameters.ParamByName('@COO').Value          := RAPC.ACOO;
       Parameters.ParamByName('@GNF').Value          := RAPC.AGNF;

       ExecProc;
       if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
         raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.AddWC(ALine: String): Boolean;
var
  RAWC: TRegAddWC;
begin
  Result := True;
  if PreSaleImported then
    Exit;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetAddWC(ALine, RAWC);

    if LogExists(IDCashReg, RAWC.ADate) then
      Exit;

    with spCashRegWidraw do
    begin
      Parameters.ParamByName('@IDCashRegMov').Value := IDCashRegMov;
      Parameters.ParamByName('@IDUser').Value       := RAWC.AIDUser;
      Parameters.ParamByName('@Bill100').Value      := RAWC.A100;
      Parameters.ParamByName('@Bill50').Value       := RAWC.A50;
      Parameters.ParamByName('@Bill20').Value       := RAWC.A20;
      Parameters.ParamByName('@Bill10').Value       := RAWC.A10;
      Parameters.ParamByName('@Bill5').Value        := RAWC.A05;
      Parameters.ParamByName('@Bill2').Value        := RAWC.A02;
      Parameters.ParamByName('@Bill1').Value        := RAWC.A01;
      Parameters.ParamByName('@Coin1').Value        := RAWC.A0100;
      Parameters.ParamByName('@Coin050').Value      := RAWC.A050;
      Parameters.ParamByName('@Coin025').Value      := RAWC.A025;
      Parameters.ParamByName('@Coin010').Value      := RAWC.A010;
      Parameters.ParamByName('@Coin005').Value      := RAWC.A005;
      Parameters.ParamByName('@Coin001').Value      := RAWC.A001;
      Parameters.ParamByName('@TotalCash').Value    := RAWC.ATotalCash;
      Parameters.ParamByName('@TotalCard').Value    := RAWC.ATotalCard;
      Parameters.ParamByName('@TotalCardPre').Value := RAWC.ATotalPreCard;
      Parameters.ParamByName('@TotalCheck').Value   := RAWC.ATotalCheck;
      Parameters.ParamByName('@TotalOther').Value   := RAWC.ATotalOther;
      Parameters.ParamByName('@TotalDebit').Value   := RAWC.ATotalDebit;
      Parameters.ParamByName('@LogDocument').Value  := RAWC.AEnvolop;
      Parameters.ParamByName('@Date').Value         := RAWC.ADate;
      Parameters.ParamByName('@IDReason').Value     := RAWC.AIDReason;
      Parameters.ParamByName('@COO').Value          := RAWC.ACOO;
      Parameters.ParamByName('@GNF').Value          := RAWC.AGNF;

       if Trim(RAWC.AOBS) <> '' then
         Parameters.ParamByName('@OBS').Value         := RAWC.AOBS
       else
         Parameters.ParamByName('@OBS').Value         := Null;

      ExecProc;
      if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
        raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));

    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.CloseSale(ALine: String): Boolean;
var
  RCS: TRegCloseSale;
begin
  Result := True;

  if PreSaleImported then
  begin
    PreSaleImported := False;
    IDPreSale := -1;
    Exit;
  end;

  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetCloseSale(ALine, RCS);

    FInvoice.CashReceived    := RCS.ACashReceived;
    FInvoice.IDCashRegMov    := IDCashRegMov;
    FInvoice.InvoiceDiscount := RCS.ASaleDiscount;
    FInvoice.IDCustomer      := IDPessoa;
    FInvoice.CreateInvoice;

    LastIDPreSale := FInvoice.IDPreSale;
    IDPreSale     := -1;
    IDPessoa      := -1;

    FFileInfo.SaleCode := '';
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.CancelSale(ALine: String): Boolean;
var
  RCS: TRegCancelSale;
begin
  Result := True;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    FSaleLineParser.GetCancelSale(ALine, RCS);
    CancelInvoiceFiscal(RCS.ACOO, RCS.AIDUser);
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.CloseCash(ALine: String): Boolean;
var
  RCC: TRegCloseCash;
begin
  Result := True;
  try
    if (IDCashRegMov = -1) OR ((IDCashRegMov <> -1) and CashClosed) then
      raise Exception.Create('SQL (POS) %S : Não existe Caixa aberto');

    if IDPreSale <> -1 then
      raise Exception.Create('SQL (POS) %S : Não pode fechar o Caixa com vendas pendentes');

    FSaleLineParser.GetCloseCash(ALine, RCC);
    with spCashRegClose do
    begin
      Parameters.ParamByName('@IDCashRegMov').Value := IDCashRegMov;
      Parameters.ParamByName('@IDUser').Value       := RCC.AIDUser;
      Parameters.ParamByName('@IDUsuario').Value    := RCC.AIDUser;
      Parameters.ParamByName('@Bill100').Value      := RCC.A100;
      Parameters.ParamByName('@Bill50').Value       := RCC.A50;
      Parameters.ParamByName('@Bill20').Value       := RCC.A20;
      Parameters.ParamByName('@Bill10').Value       := RCC.A10;
      Parameters.ParamByName('@Bill5').Value        := RCC.A05;
      Parameters.ParamByName('@Bill2').Value        := RCC.A02;
      Parameters.ParamByName('@Bill1').Value        := RCC.A01;
      Parameters.ParamByName('@Coin1').Value        := RCC.A0100;
      Parameters.ParamByName('@Coin050').Value      := RCC.A050;
      Parameters.ParamByName('@Coin025').Value      := RCC.A025;
      Parameters.ParamByName('@Coin010').Value      := RCC.A010;
      Parameters.ParamByName('@Coin005').Value      := RCC.A005;
      Parameters.ParamByName('@Coin001').Value      := RCC.A001;
      Parameters.ParamByName('@FinalCount').Value   := RCC.ATotalCount;
      Parameters.ParamByName('@TotalCash').Value    := RCC.ATotalCash;
      Parameters.ParamByName('@TotalCard').Value    := RCC.ATotalCard;
      Parameters.ParamByName('@TotalCardPre').Value := RCC.ATotalPreCard;
      Parameters.ParamByName('@TotalCheck').Value   := RCC.ATotalCheck;
      Parameters.ParamByName('@TotalOther').Value   := RCC.ATotalOther;
      Parameters.ParamByName('@TotalDebit').Value   := RCC.ATotalDebit;
      Parameters.ParamByName('@LogDocument').Value  := RCC.AEnvolop;
      Parameters.ParamByName('@Date').Value         := RCC.ADate;
      ExecProc;
      if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
        raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
      (* CHECKAR
      FrmMain.fPOSConfig.DeleteKey(Copy(FFileInfo.FileName, 0, 4),Copy(FFileInfo.FileName, 6, 15));
      *)
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;

  FTmpLastCloseLine := '';
  ResetCashReg;
end;

function TDMThread.GetPreSaleID(AIDStore, AIDCashReg: Integer;
  APreSaleDate: TDateTime; ASaleCode: String): Integer;
begin
  with quSearchPreSale do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDStore').Value        := AIDStore;
    Parameters.ParamByName('IDCashRegister').Value := AIDCashReg;
    Parameters.ParamByName('pPreSaleDate').Value   := FormatDateTime('DD/MM/YYYY hh:nn:ss', APreSaleDate);
    Parameters.ParamByName('SaleCode').Value       := ASaleCode;
    Open;
    if IsEmpty then
      Result := -1
    else
    begin
      Result := FieldByName('IDPreSale').AsInteger;
      IDPessoa := FieldByName('IDCustomer').AsInteger;
    end;
  finally
    Close;
  end;
end;

function TDMThread.GetCashRegMovID(AIDCashReg: Integer;AOpenTime: TDateTime; var AOpened: Boolean): Integer;
begin
  with quSearchCashRegMov do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDCashRegister').Value := AIDCashReg;
    Parameters.ParamByName('OpenTime').Value       := AOpenTime;
    Open;
    if IsEmpty then
    begin
      Result := -1;
      AOpened := False;
    end
    else
    begin
      Result := FieldByName('IDCashRegMov').AsInteger;
      AOpened := FieldByName('IDCashregStatus').AsInteger = 1;
    end;
  finally
    Close;
  end;
end;

function TDMThread.CreateSaleCode(AIDPreSale, AIDPreSaleParent,
  AIDStore: Integer; ACOO, ASaleCode: String; APuppyTracker : Boolean;
  ECFSerial : String): String;
var
  SQLFiscal: String;
begin
  if (ACOO = '') or (ACOO = CUPOM_VAZIO) then
  begin
    with spNewSaleCode do
    begin
      Result := ASaleCode;
    end;
    SQLFiscal := ', CupomFiscal = NULL, NumeroSeriePrinter = NULL';
  end
  else
  begin
    Result := ACOO;
    SQLFiscal :=  ', CupomFiscal ='+ QuotedStr(ACOO);
    if Trim(ECFSerial) <> '' then
      SQLFiscal := SQLFiscal + ' , NumeroSeriePrinter = ' + QuotedStr(ECFSerial);
  end;

  with quRun do
  try
    if Active then
      Close;
    SQL.Text := 'UPDATE Invoice SET SaleCode = '+QuotedStr(Result)+ SQLFiscal +
                ', PuppyTracker = ' + IntToStr(Byte(APuppyTracker)) +
                ' WHERE IDPreSale = ' + IntToStr(AIDPreSale);
    ExecSQL;
  finally
    Close;
  end;
end;

function TDMThread.ExemptTax(fIDPreSale : Integer; fExempt :Boolean):Boolean;
begin
  try
    with cmdExemptTax do
    begin
      Parameters.ParambyName('IDPreSale').Value := fIDPreSale;
      Parameters.ParambyName('TaxIsent').Value  := fExempt;
      Execute;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TDMThread.HoldExists(AIDPreSale: Integer; var IsInvoice: Boolean): Boolean;
begin
  with quSearchPreSaleID do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPreSale').Value := AIDPreSale;
    Open;
    Result := not IsEmpty;

    IsInvoice := not FieldByName('IDInvoice').IsNull;

    if Result then
      IDPessoa := FieldByName('IDCustomer').Value;

  finally
    Close;
  end;
end;

procedure TDMThread.DeleteHold(AIDPreSale: Integer);
begin
  with spPreSaleRemove do
  begin
    Parameters.ParamByName('@PreSaleID').Value := AIDPreSale;
    Parameters.ParamByName('@IDUser').Value    := FLastSale.FIDUser;
    ExecProc;
    if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
      raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', ['spPreSaleRemove', VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
  end;
end;

function TDMThread.CancelHold(AIDPreSale, AIDUser : Integer; ACOO : String): Boolean;
var
  RRI: TRegRemovedItem;
  iIDNotasCanceladas, i : Integer;
begin
  Result := True;

  if PreSaleImported then
  begin
    PreSaleImported := False;
    IDPreSale := -1;
    Exit;
  end;

  //Verifica se o Hold ja foi importado
  try
    with quRun do
      try
        if Active then
          Close;
        SQL.Clear;
        SQL.Add(Format('SELECT IDNotasCanceladas From Sal_NotasCanceladas Where COO = %D AND IDCashRegMov = %D', [StrToInt(Trim(ACOO)), IDCashRegMov]));
        Open;
        if IsEmpty then
        begin
          //PAF
          iIDNotasCanceladas := GetNextID('Sal_NotasCanceladas.IDNotasCanceladas');

          //Inserir tabela de notas canceladas
          with cmdInsertNotaCancel do
          begin
            Parameters.ParamByName('IDNotasCanceladas').Value := iIDNotasCanceladas;
            Parameters.ParamByName('IDPessoa').Value          := FInvoice.IDCustomer;
            Parameters.ParamByName('Cliente').Value           := FInvoice.FirstName + ' ' + FInvoice.LastName;
            Parameters.ParamByName('CPFCGC').Value            := FInvoice.CPFCGC;
            Parameters.ParamByName('IDUser').Value            := 0;
            Parameters.ParamByName('COO').Value               := ValidateInvoiceNum(FInvoice.COO);
            Parameters.ParamByName('CCF').Value               := ValidateInvoiceNum(FInvoice.InvoiceCode);
            Parameters.ParamByName('DataNota').Value          := FInvoice.PreSaleDate;
            Parameters.ParamByName('SubTotal').Value          := FInvoice.SubTotal;
            Parameters.ParamByName('Desconto').Value          := FInvoice.InvoiceDiscount + FInvoice.ItemDiscount;
            Parameters.ParamByName('Acrescimo').Value         := 0;
            Parameters.ParamByName('TipoAcrescimo').Value     := 'V';
            Parameters.ParamByName('TipoDesconto').Value      := 'V';
            Parameters.ParamByName('IDCashRegMov').Value      := IDCashRegMov;
            Execute;
         end;

         //Inserir tabela de items canceladas
         for i := 0 to FInvoice.ItemList.Count-1 do
         begin
            RRI.AIDCashReg         := IDCashReg;
            RRI.AIDModel           := TInvoiceItem(FInvoice.ItemList[i]).IDModel;
            RRI.AIDStore           := TInvoiceItem(FInvoice.ItemList[i]).IDStore;
            RRI.AIDDepartment      := TInvoiceItem(FInvoice.ItemList[i]).IDDepartment;
            RRI.AIDUserAuto        := TInvoiceItem(FInvoice.ItemList[i]).IDUser;
            RRI.AIDCommis          := TInvoiceItem(FInvoice.ItemList[i]).IDComission;
            RRI.AIDUser            := TInvoiceItem(FInvoice.ItemList[i]).IDUser;
            RRI.AMovDate           := TInvoiceItem(FInvoice.ItemList[i]).MovDate;
            RRI.AQty               := TInvoiceItem(FInvoice.ItemList[i]).Qty;
            RRI.ASale              := TInvoiceItem(FInvoice.ItemList[i]).SalePrice;
            RRI.ACost              := TInvoiceItem(FInvoice.ItemList[i]).CostPrice;
            RRI.ADiscount          := TInvoiceItem(FInvoice.ItemList[i]).Discount;
            RRI.ASaleCode          := TInvoiceItem(FInvoice.ItemList[i]).SaleCode;
            RRI.APosicaoItem       := TInvoiceItem(FInvoice.ItemList[i]).ItemIndex;
            RRI.AAcrescimo         := 0;
            RRI.ATotParcial        := TInvoiceItem(FInvoice.ItemList[i]).TotParcial;
            RRI.AIDNotasCanceladas := iIDNotasCanceladas;
            RRI.AIDPreSale         := 0;
            Result := AddSubRemovedItem(RRI, False);
            if not Result then
              Break;
          end;

         //Inserir tabela de items canceladas
         for i := 0 to FInvoice.RemovedItemList.Count-1 do
         begin
            RRI.AIDCashReg         := IDCashReg;
            RRI.AIDModel           := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDModel;
            RRI.AIDStore           := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDStore;
            RRI.AIDDepartment      := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDDepartment;
            RRI.AIDUserAuto        := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDUser;
            RRI.AIDCommis          := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDComission;
            RRI.AIDUser            := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).IDUser;
            RRI.AMovDate           := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).MovDate;
            RRI.AQty               := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).Qty;
            RRI.ASale              := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).SalePrice;
            RRI.ACost              := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).CostPrice;
            RRI.ADiscount          := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).Discount;
            RRI.ASaleCode          := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).SaleCode;
            RRI.APosicaoItem       := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).ItemIndex;
            RRI.AAcrescimo         := 0;
            RRI.ATotParcial        := TInvoiceRemovedItem(FInvoice.RemovedItemList[i]).TotParcial;
            RRI.AIDNotasCanceladas := iIDNotasCanceladas;
            RRI.AIDPreSale         := 0;
            Result := AddSubRemovedItem(RRI, False);
            if not Result then
              Break;
          end;

          //Caso a nota tenha sido cancelada sem pagamento, tenho que preencher a informacao do caixa
          with ADOCommand do
          begin
            CommandText := 'UPDATE Invoice SET CashRegMovID = ' + IntToStr(IDCashRegMov) +
                           ' WHERE IDPreSale = ' + IntToStr(IDPreSale);
            Execute;
          end;
        end;
      finally
        Close;
      end;
  except
    on E: Exception do
    begin
      AddErrorHistory(Format('SQL (POS) %S : ', [FormatError(E.Message)]));
      Result := False;
    end;
  end;

  try

    with spCancelHold do
    begin
      Parameters.ParamByName('@IDPreSale').Value := AIDPreSale;
      Parameters.ParamByName('@IDUser').Value    := AIDUser;
      ExecProc;
      if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
        raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
    end;

    IDPreSale := -1;
    IDPessoa  := -1;

    FFileInfo.SaleCode := '';

  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.CancelInvoice(AIDPreSale, AIDUser: Integer): Boolean;
var
  RRI: TRegRemovedItem;
  iIDNotasCanceladas : Integer;
begin
  Result := True;

  try

    //PAF
    quPreSaleItemCanceled.Parameters.ParamByName('IDPreSale').Value := AIDPreSale;
    quPreSaleItemCanceled.Open;

    if not quPreSaleItemCanceled.IsEmpty then
    begin
      quPreSaleItemCanceled.First;
      iIDNotasCanceladas := GetNextID('Sal_NotasCanceladas.IDNotasCanceladas');

      //Inserir tabela de notas canceladas
      with cmdInsertNotaCancel do
      begin
        Parameters.ParamByName('IDNotasCanceladas').Value := iIDNotasCanceladas;
        Parameters.ParamByName('IDPessoa').Value          := quPreSaleItemCanceled.FieldByName('IDCustomer').AsInteger;
        Parameters.ParamByName('Cliente').Value           := quPreSaleItemCanceled.FieldByName('Customer').AsString;
        Parameters.ParamByName('CPFCGC').Value            := quPreSaleItemCanceled.FieldByName('CPFCGC').AsString;
        Parameters.ParamByName('IDUser').Value            := quPreSaleItemCanceled.FieldByName('IDUser').AsInteger;
        Parameters.ParamByName('COO').Value               := quPreSaleItemCanceled.FieldByName('COO').AsString;
        Parameters.ParamByName('CCF').Value               := quPreSaleItemCanceled.FieldByName('InvoiceCode').AsString;
        Parameters.ParamByName('DataNota').Value          := quPreSaleItemCanceled.FieldByName('PreSaleDate').AsDateTime;
        Parameters.ParamByName('SubTotal').Value          := quPreSaleItemCanceled.FieldByName('SubTotal').AsCurrency;
        Parameters.ParamByName('Desconto').Value          := quPreSaleItemCanceled.FieldByName('Discount').AsCurrency;
        Parameters.ParamByName('Acrescimo').Value         := 0;
        Parameters.ParamByName('TipoAcrescimo').Value     := 'V';
        Parameters.ParamByName('TipoDesconto').Value      := 'V';
        Parameters.ParamByName('IDCashRegMov').Value      := quPreSaleItemCanceled.FieldByName('CashRegMovID').AsInteger;
        Execute;
     end;

     //Inserir tabela de items canceladas

     While not quPreSaleItemCanceled.Eof do
     begin
        RRI.AIDCashReg         := IDCashReg;
        RRI.AIDModel           := quPreSaleItemCanceled.FieldByName('ModelID').AsInteger;
        RRI.AIDStore           := quPreSaleItemCanceled.FieldByName('StoreID').AsInteger;
        RRI.AIDDepartment      := quPreSaleItemCanceled.FieldByName('IDDepartment').AsInteger;
        RRI.AIDUserAuto        := quPreSaleItemCanceled.FieldByName('IDUser').AsInteger;
        RRI.AIDCommis          := 0;
        RRI.AIDUser            := quPreSaleItemCanceled.FieldByName('IDUser').AsInteger;
        RRI.AMovDate           := quPreSaleItemCanceled.FieldByName('PreSaleDate').AsDateTime;
        RRI.AQty               := quPreSaleItemCanceled.FieldByName('Qty').AsFloat;
        RRI.ASale              := quPreSaleItemCanceled.FieldByName('SalePrice').AsCurrency;
        RRI.ACost              := quPreSaleItemCanceled.FieldByName('CostPrice').AsCurrency;
        RRI.ADiscount          := quPreSaleItemCanceled.FieldByName('Discount').AsCurrency;
        RRI.ASaleCode          := quPreSaleItemCanceled.FieldByName('COO').AsString;
        RRI.APosicaoItem       := quPreSaleItemCanceled.FieldByName('SequencyNum').AsInteger;
        RRI.AAcrescimo         := 0;
        RRI.ATotParcial        := quPreSaleItemCanceled.FieldByName('TotalizadorParcial').AsString;
        RRI.AIDNotasCanceladas := iIDNotasCanceladas;
        RRI.AIDPreSale         := 0;

        Result := AddSubRemovedItem(RRI, True);

        if not Result then
          Break;

        quPreSaleItemCanceled.Next;
      end;

      quPreSaleItemCanceled.Close;

      if Result then
      begin
        ADOCommand.CommandText := 'UPDATE Sal_RemovedItem SET IDPreSale = NULL, IDNotasCanceladas = ' + IntToStr(iIDNotasCanceladas) +
                                  ' WHERE IDPreSale = ' + IntToStr(AIDPreSale);
        ADOCommand.Execute;
      end;

    end;

    with spCancelInvoice do
    begin
      Parameters.ParamByName('@IDPreSale').Value := AIDPreSale;
      Parameters.ParamByName('@IDUser').Value    := AIDUser;
      ExecProc;
      if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
        raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
    end;

  except
    on E: Exception do
    begin
      quPreSaleItemCanceled.Close;
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.CancelInvoiceFiscal(ACOO: String; AIDUser: Integer): Boolean;
begin
  Result := True;
  try
    with quRun do
      try
        if Active then
          Close;
        SQL.Clear;
        SQL.Add(Format('SELECT IDPreSale FROM Invoice WHERE CupomFiscal = %S AND CashRegMovID = %D AND Canceled = 0', [QuotedStr(Trim(ACOO)), IDCashRegMov]));
        Open;
        if not IsEmpty then
          CancelInvoice(FieldByName('IDPreSale').AsInteger, AIDUser);
      finally
        Close;
      end;
  except
    on E: Exception do
    begin
      AddErrorHistory(Format('SQL (POS) %S : ', [FormatError(E.Message)]));
      Result := False;
    end;
  end;
end;

function TDMThread.LogExists(AIDCashReg: Integer; ADate: TDateTime): Boolean;
var
  sSQL : String;
begin
  with quRun do
  try
    if Active then
      Close;
    SQL.Clear;
    sSQL :=  Format('SELECT IDCashRegLog FROM CashRegLog WHERE IDCashRegMov = %D AND LogTime = Convert(DateTime, %S, 120)', [IDCashRegMov, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', ADate))]);
    SQL.Add(sSQL);
    Open;
    Result := not IsEmpty;
  finally
    Close;
  end;
end;

function TDMThread.GetPessoaID(APessoa, ATel: String): Integer;
begin
  with quRun do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(Format('SELECT IDPessoa FROM Pessoa WHERE Pessoa = %S AND IsNull(Telefone, '''') = %S', [QuotedStr(APessoa), QuotedStr(ATel)]));
    Open;
    if IsEmpty then
      Result := -1
    else
      Result := FieldByName('IDPessoa').AsInteger;
  finally
    Close;
  end;
end;

procedure TDMThread.DecHold(IDPreSale: Integer);
begin
  with ADOCommand do
  begin
    CommandText := 'UPDATE Invoice SET nOpenHoldCaixa = IsNull(nOpenHoldCaixa,0) - 1 ' +
                   'WHERE IDPreSale = ' + IntToStr(IDPreSale);
    Execute;
  end;
end;

function TDMThread.FormatError(sError: String): String;
begin
   Result := Format(sError, [FFileInfo.FileName + ' line (' +  IntToStr(FFileInfo.Line) + ') Sale ' + FFileInfo.SaleCode])
end;


function TDMThread.AddReducaoZ(ALine: String): Boolean;
var
  RRZ: TRegReducaoZ;
  i : Integer;
begin
  Result := True;
  iIDReducaoZ  := 0;
  bHasReducaoZ := False;

  try
    FSaleLineParser.GetReducaoZ(ALine, RRZ);

    with quTestReducaoZ do
    begin
      if Active then
        Close;

      Parameters.ParamByName('MovDate').Value := RRZ.AMovDate;
      Parameters.ParamByName('NumeroSerie').Value := RRZ.ANumeroSerie;
      Open;
      bHasReducaoZ := not IsEmpty;
      Close;
    end;

    if not bHasReducaoZ then
    begin
      with cmdInsertReducaoZ do
      begin
        iIDReducaoZ := GetNextID('Sal_ReducaoZ.IDReducaoZ');

        Parameters.ParamByName('IDReducaoZ').Value               := iIDReducaoZ;
        Parameters.ParamByName('MovDate').Value                  := RRZ.AMovDate;
        Parameters.ParamByName('NumeroSerie').Value              := RRZ.ANumeroSerie;
        Parameters.ParamByName('NumeroLoja').Value               := RRZ.ANumeroLoja;
        Parameters.ParamByName('NumeroECF').Value                := RRZ.ANumeroECF;
        Parameters.ParamByName('NumReducaoZ').Value              := RRZ.ANumReducaoZ;
        Parameters.ParamByName('COOInicial').Value               := GetCOOInicial(iIDCashRegReducaoZ, RRZ.AMovDate);
        Parameters.ParamByName('COOFinal').Value                 := RRZ.AContadorOrdemOperacao;
        Parameters.ParamByName('NumCancelamentos').Value         := GetNumCancelamento(iIDCashRegReducaoZ, RRZ.AMovDate);;
        Parameters.ParamByName('ValCancelamentos').Value         := RRZ.AValCancelamentos;
        Parameters.ParamByName('ValDescontos').Value             := RRZ.AValDescontos;
        Parameters.ParamByName('GTInicial').Value                := RRZ.AGTInicial;
        Parameters.ParamByName('GTFinal').Value                  := RRZ.AGTFinal;
        Parameters.ParamByName('SubstituicaoTrib').Value         := RRZ.ASubstituicaoTrib;
        Parameters.ParamByName('Isencao').Value                  := RRZ.AIsencao;
        Parameters.ParamByName('NaoTributavel').Value            := RRZ.ANaoTributavel;
        // NOVOS CAMPOS PAF-ECF
        Parameters.ParamByName('TipoECF').Value                  := RRZ.ATipoECF;
        Parameters.ParamByName('MarcaECF').Value                 := RRZ.AMarcaECF;
        Parameters.ParamByName('ModeloECF').Value                := RRZ.AModeloECF;
        Parameters.ParamByName('VersaoSBECF').Value              := RRZ.AVersaoSBECF;
        Parameters.ParamByName('DataInstalacaoSBECF').Value      := RRZ.ADataInstalacaoSBECF;
        Parameters.ParamByName('MFAdicional').Value              := RRZ.AMFAdicional;
        Parameters.ParamByName('ContadorReducaoZ').Value         := RRZ.AContadorReducaoZ;
        Parameters.ParamByName('ContadorOrdemOperacao').Value    := RRZ.AContadorOrdemOperacao;
        Parameters.ParamByName('ContadorReinicioOperacao').Value := RRZ.AContadorReinicioOperacao;
        Parameters.ParamByName('NumeroUsuarioECF').Value         := RRZ.ANumeroUsuarioECF;
        Parameters.ParamByName('IncideISSQN').Value              := RRZ.AIncideISSQN;
        Parameters.ParamByName('DataEmissao').Value              := RRZ.ADataEmissao;
        Parameters.ParamByName('IDCashRegister').Value           := iIDCashRegReducaoZ;
        Execute;
      end;

      for i := 0 to Pred(Length(RRZ.AAliquota)) do
      begin
        with cmdInsertTributacaoECF do
        begin
          Parameters.ParamByName('IDTributacaoECF').Value := GetNextID('Sal_TributacaoECF.IDTributacaoECF');
          Parameters.ParamByName('Aliquota').Value        := RRZ.AAliquota[i];
          Parameters.ParamByName('BaseCalculo').Value     := RRZ.ABaseCalculo[i];
          Parameters.ParamByName('ValImposto').Value      := RRZ.AValImposto[i];
          Parameters.ParamByName('IDReducaoZ').Value      := iIDReducaoZ;
          Execute;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;



procedure TDMThread.DataModuleCreate(Sender: TObject);
begin
  fSQLSvrConnectParam := TSQLConnection.Create;
  FSaleLineParser     := TSaleLineParser.Create;
  FFileInfo           := TFileInfo.Create;
  FLastSale           := TLastSale.Create;
  FLastSale.ClearLastSale;
end;

procedure TDMThread.DataModuleDestroy(Sender: TObject);
begin
  CloseConnection;
  FreeAndNil(fSQLSvrConnectParam);
  FreeAndNil(FrmServrInfo);
  FreeAndNil(FSaleLineParser);
  FreeAndNil(FFileInfo);
  FreeAndNil(FLastSale);

  CoUninitialize;
end;

procedure TDMThread.quModelBeforeOpen(DataSet: TDataSet);
begin
  quModel.Parameters.ParamByName('IDStore').Value := fIDStore;
end;

procedure TDMThread.quModelAccessoryBeforeOpen(DataSet: TDataSet);
begin
  quModelAccessory.Parameters.ParamByName('IDStore').Value := fIDStore;
end;

procedure TDMThread.quInvModelDepartmentBeforeOpen(DataSet: TDataSet);
begin
  quInvModelDepartment.Parameters.ParamByName('IDStore').Value := fIDStore;
end;

procedure TDMThread.quModelCalcFields(DataSet: TDataSet);
begin
  if FIsFranquia then
    begin
      quModelInvSellingPrice.Value := quModelInvSellingPriceI.Value;
      quModelVendorCost.Value      := quModelVendorCostI.Value;
    end
  else
    begin
      if quModelInvSellingPriceI.Value <> 0 then
      begin
        quModelInvSellingPrice.Value := quModelInvSellingPriceI.Value;
        quModelSellingPrice.Value    := quModelInvSellingPriceI.Value;
      end
      else
      begin
        quModelInvSellingPrice.Value := quModelInvSellingPriceM.Value;
        quModelSellingPrice.Value    := quModelInvSellingPriceM.Value;
      end;

      if quModelVendorCostI.Value <> 0 then
        quModelVendorCost.Value := quModelVendorCostI.Value
      else
        quModelVendorCost.Value := quModelVendorCostM.Value;

    end;


  case quModelSituacaoTributaria.AsInteger of
    0,1 : quModelDescSituTribut.AsString := 'Tributável';
    2 : quModelDescSituTribut.AsString := 'Não Tributável';
    3 : quModelDescSituTribut.AsString := 'Substit. Tributária';
    4 : quModelDescSituTribut.AsString := 'Isento';
    5 : quModelDescSituTribut.AsString := 'ISS';
  end;

end;


function TDMThread.ImportTerminals: Boolean;
var
  sPDVList   : TStringList;
  i          : integer;
  iIDCashReg : Integer;
  sImportDir, IncludeSince, LastDate: String;

  ACashRegInfo: TCashRegInfo;
begin

  Result := False;
  try
    for I := 0 to FCashRegInfolist.Count - 1 do
    begin
      ACashRegInfo := TCashRegInfo(FCashRegInfolist.Objects[I]);

      sImportDir := ExtractFilePath(Application.ExeName) + POS_DIR_FILES +  IntToStr(ACashRegInfo.IDCashreg) + '\';

      ShowDebug('Import Dir : ' + sImportDir + ' since : ' + IncludeSince);

      Result := ImportDir(sImportDir, ACashRegInfo.IDCashreg, ACashRegInfo.IncludeSince, ACashRegInfo.LastImportedFileDate);
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory('Erro Importando PDV: ' + E.Message);
      Result := False;
    end;
  end;

end;

function TDMThread.Execute: Boolean;
var
  bResult: boolean;
begin

  try

    AddHistory('Iniciando o horario ...');

    bResult := StartConnection();

    if bResult then
    begin
      case FSynchronizationType of
          SINC_TYPE_SERVER   :
            begin
              try
                 WriteIniBool('Settings','UsingServerFiles', True);
                 bResult := CreatingAllGlobal;
              finally
                 WriteIniBool('Settings','UsingServerFiles', False);
                 WriteIniDateTime('Settings','ServerFilesDate', Now);
              end;
            end;

          SINC_TYPE_CASH_LOG :
            begin
              bResult := ImportTerminals;
            end;
          else
            Exit;
        end;
    end
    else
      AddHistory('Falha na conexão!');

   case fSynchronizationType of
      SINC_TYPE_SERVER   :
        SaveNextSchedule(SCH_SERVER);

      SINC_TYPE_CASH_LOG : begin
                           SaveNextSchedule(SCH_POS);
                           if bResult then
                             AddHistory('Arquivos do PDV ' + MR_HST_OK);
                           end;
   end;

  if bResult then
    AddHistory('Concluindo horario ...');

  finally
    Completed;
    StopConnection;
  end;

end;


function TDMThread.GetNextID(ATable: String): LongInt;
begin
  with spGetNextID do
  begin
    Parameters.ParamByName('@Tabela').Value := ATable;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  end;
end;

procedure TDMThread.ShowDebug(Debug: String);
begin
  
end;

procedure TDMThread.SetStatus(Msg: String; Count: Integer);
begin
  if Assigned(TThreadExecuteTask(FThread).OnPOSServerStatusEvent) then
    TThreadExecuteTask(FThread).OnPOSServerStatusEvent(Msg, Count);
end;

procedure TDMThread.IncPBPos;
begin
  if Assigned(TThreadExecuteTask(FThread).OnPOSServerStepCompleted) then
    TThreadExecuteTask(FThread).OnPOSServerStepCompleted;
end;

procedure TDMThread.WriteIniBool(ASection, AKey: String; AValue: Boolean);
begin
  if Assigned(TThreadExecuteTask(FThread).OnNeedWriteIniBool) then
    TThreadExecuteTask(FThread).OnNeedWriteIniBool(ASection, AKey, AValue);
end;

procedure TDMThread.WriteIniDateTime(ASection, AKey: String; AValue: TDateTime);
begin
  if Assigned(TThreadExecuteTask(FThread).OnNeedWriteIniDateTime) then
    TThreadExecuteTask(FThread).OnNeedWriteIniDateTime(ASection, AKey, AValue);
end;

procedure TDMThread.WriteIniString(ASection, AKey: String; AValue: String);
begin
  if Assigned(TThreadExecuteTask(FThread).OnNeedWriteIniString) then
    TThreadExecuteTask(FThread).OnNeedWriteIniString(ASection, AKey, AValue);
end;

procedure TDMThread.WriteIniInteger(ASection, AKey: String; AValue: Integer);
begin
  if Assigned(TThreadExecuteTask(FThread).OnNeedWriteIniInteger) then
    TThreadExecuteTask(FThread).OnNeedWriteIniInteger(ASection, AKey, AValue);
end;

procedure TDMThread.Completed;
begin
  if Assigned(TThreadExecuteTask(FThread).OnPOSServerCompleted) then
    TThreadExecuteTask(FThread).OnPOSServerCompleted;
end;

procedure TDMThread.SaveNextSchedule(sType: String);
begin
  if Assigned(TThreadExecuteTask(FThread).OnSaveNextSchedule) then
    TThreadExecuteTask(FThread).OnSaveNextSchedule(sType);
end;


function TDMThread.ImportSale : Boolean;
var
  i, j : Integer;
  FLastSaleItem : TLastSaleItem;
  FLastSaleItemSerial : TLastSaleItemSerial;
begin

  //Open Sale
  Result := OpenSale(FLastSale.FOpenSaleLine);

  if not Result then
    Exit;

  //Customer
  if FLastSale.FCustomerLine <> '' then
    Result := AddCustomer(FLastSale.FCustomerLine);

  if not Result then
    Exit;

    //Items
    for i := 0 to FLastSale.FItemList.Count-1 do
    begin
      FLastSaleItem := TLastSaleItem(FLastSale.FItemList.Objects[i]);
      if not FLastSaleItem.FCanceled then
      begin
        Result := AddItem(FLastSaleItem.FItemLine, FLastSaleItem.FSerialList, i+1);
        if not Result then
         Exit;
      end
      else
      begin
        Result := AddItemRemoved(FLastSaleItem.FItemLine, i+1);
        if not Result then
         Exit;
      end;
    end;

  //Payments
  for i := 0 to FLastSale.FPaymentList.Count-1 do
    Result := AddPayment(FLastSale.FPaymentList.Strings[i]);

  if not Result then
    Exit;

  //Close Sale
  if not FLastSale.FCanceled then
    Result := CloseSale(FLastSale.FCloseSaleLine)
  else
    Result := CancelHold(IDPreSale, FLastSale.FIDUser, FLastSale.FSaleCode);

  FLastSale.ClearLastSale;

  if Assigned(FInvoice) then
    FreeAndNil(FInvoice);

end;

function TDMThread.ForceClosingSale: Boolean;
var
  SaleWritter: TSaleWritter;
  RCS: TRegCloseSale;
  sLine: String;
  bCashClosed, bErrorCashClosed: Boolean;
begin
  {T}
  SaleWritter := TSaleWritter.Create(1, 1);
  try
    FSaleLineParser.GetCloseSale(FTmpLastCloseLine, RCS);
    RCS.AIDPreSale := IDPreSale;
    RCS.AIDTourGroup := 0;
    RCS.AIDOtherCommis := 0;
    RCS.AIDCashRegMov := IDCashRegMov;
    RCS.AIDStore := IDStore;
    RCS.ADate := FPreSaleDate;
    RCS.APayDate := FPreSaleDate;
    RCS.ACashReceived := 0;
    RCS.ASaleDiscount := 0;
    FTmpLastCloseLine := SaleWritter.GetSaleCloseLine(RCS.AIDPreSale, RCS.AIDTourGroup,
      RCS.AIDOtherCommis, RCS.AIDCashRegMov, RCS.AIDStore, RCS.ADate, RCS.APayDate, RCS.ACashReceived, RCS.ASaleDiscount);
  finally
    FreeAndNil(SaleWritter);
  end;

  FLastSale.FCloseSaleLine := FTmpLastCloseLine;
  Result := ImportSale;

  if not Result then
    AddErrorHistory(FormatError('SQL (POS) %S : Erro ao forçar fechamento de venda.'));
  {T}
end;

function TDMThread.ZipServerFiles : Boolean;
var
  sLocal, sStoreZipFile : String;
  sStoreList : TStringList;
  i : Integer;
begin
  Result := True;

  sLocal := ExtractFilepath(Application.ExeName) + PDV_GLOBAL_DIR;

  try

    Result := CreateZipFile(sLocal + ZIP_GLOBAL_FILE_NAME);

    Result := ZipFile(sLocal, '*.xml', sLocal + ZIP_GLOBAL_FILE_NAME);

    sStoreList := TStringList.Create;
    try
      sStoreList.CommaText := FLocalSetting.IDStoreList;
      for i := 0 to sStoreList.Count -1 do
      begin
        sStoreZipFile := sLocal + sStoreList.Strings[i] + '\' + Format(ZIP_STORE_FILE_NAME, [sStoreList.Strings[i]]);
        Result := CreateZipFile(sStoreZipFile);
        if Result then
           Result := ZipFile(sLocal, sLocal + sStoreList.Strings[i] + '\*.xml', sStoreZipFile);
      end;
    finally
      FreeAndNil(sStoreList);
    end;

  except
    Result := False;
    AddErrorHistory('Error zipping global files.');
  end;

end;

function TDMThread.ZipFile(sBaseDir, sFileName, sZipFileName: String): Boolean;
begin

  Result := True;

  try
    Zipper.BaseDirectory := sBaseDir;
    Zipper.FileName := sZipFileName;
    try
      Zipper.AddFiles(sFileName, 0);

      Sleep(5);
      Application.ProcessMessages;

      Zipper.Save;

      Sleep(5);
      Application.ProcessMessages;
    finally
      Zipper.CloseArchive;
    end;
  except
     on E: Exception do
     begin
        Result := False;
        AddErrorHistory('ZIP erro : ' + E.Message);
        ShowDebug(E.Message);
     end;
    end;

end;

function TDMThread.UnZipServerFiles : Boolean;
var
  sDir : String;
begin

  Result := False;

  sDir := ExtractFilepath(Application.ExeName) + TEMP_DIR;

  if FileExists(sDir + ZIP_GLOBAL_FILE_NAME) then
    UnZipFile(sDir, sDir + ZIP_GLOBAL_FILE_NAME);

  if FileExists(sDir + Format(ZIP_STORE_FILE_NAME, [IntToStr(fIDStore)])) then
    UnZipFile(sDir, sDir + Format(ZIP_STORE_FILE_NAME, [IntToStr(fIDStore)]));

  Result := True;
end;

function TDMThread.CreateZipFile(FileName: String): Boolean;
var
  fs : TFileStream;
begin

  try

    Result := False;

    if FileExists(FileName) then
      DeleteFile(FileName);

    fs := TFileStream.Create(FileName, fmCreate);
    try
    finally
      fs.Free;
    end;
    Sleep(0);

    Result := True;

  except
     on E: Exception do
     begin
        Result := False;
        AddErrorHistory('Criando ZIP erro : ' + E.Message);
        ShowDebug(E.Message);
     end;
    end;

end;

procedure TDMThread.UnZipFile(DestDir, ZipFileName: String);
begin
  try
    UnZipper.BaseDirectory := DestDir;
    UnZipper.FileName      := ZipFileName;
    try
      UnZipper.ExtractFiles('*.*');
    finally
      UnZipper.CloseArchive;
    end;
  except
  end;
end;

function TDMThread.SaleOBS(ALine: String): Boolean;
var
  ROBS: TRegOBS;
begin
  FSaleLineParser.GetOBS(ALine, ROBS);
  FLastSale.FOBS := ROBS.AOBS;
end;

function TDMThread.ConnectFTP: Boolean;
begin

  Result := False;
  {
  with ApdFtp do
  begin
    ServerAddress   := FServerConnection.FTP;
    Username        := FServerConnection.User;
    Password        := FServerConnection.PW;
    TransferTimeout := FTP_TRANSFER_TIMEOUT;
    try
      AddHistory('FTP conectando ...');

      if not Login then
        AddHistory('FTP Login error ...');

      Result := True;
    except
     on E: Exception do
     begin
        AddErrorHistory('FTP erro : ' + E.Message);
        ShowDebug(E.Message);
     end;
    end;
  end
  }

  with FTP do
  begin
    Host        := FServerConnection.FTP;
    Port        := FServerConnection.Port;
    Username    := FServerConnection.User;
    Password    := FServerConnection.PW;
    ReadTimeout := FTP_TRANSFER_TIMEOUT;
    try
      AddHistory('FTP conectando ...');

      if not Connected then
        Connect(True, FTP_TIMEOUT);

      Result := Connected;
    except
     on E: Exception do
     begin
        AddErrorHistory('FTP erro : ' + E.Message);
        ShowDebug(E.Message);
     end;
    end;
  end

end;

procedure TDMThread.DisconnectFTP;
begin
  {
  ApdFtp.Logout;
  }

  if FTP.Connected then
    FTP.Quit;

end;

function TDMThread.GetFTPFile(fFile:String):Boolean;
begin

 Result := False;
 {
 with ApdFtp do
 begin
   try
     Result := Retrieve(ExtractFilepath(Application.ExeName) + TEMP_DIR + fFile, fFile, TFtpRetrieveMode(1));
     if not Result then
       AddHistory('Erro baixando : ' + fFile);
   except
    on E: Exception do
      ReportError('Erro baixando ('+fFile+'): ' + E.Message);
     end;
 end;
 }

 with FTP do
 begin
   try
     Get(fFile, ExtractFilepath(Application.ExeName) + TEMP_DIR + fFile, True);
     Result := True;
   except
    on E: Exception do
      ReportError('Erro no arquivo ('+fFile+'): ' + E.Message);
     end;
 end;


end;

function TDMThread.SetFTPFile(fLocalDir, fRemoteDir, fFile:String):Boolean;
begin

 Result := False;

 {
 with ApdFtp do
 begin
   try
     Result := Store(fRemoteDir+ '/' + fFile, fLocalDir + fFile, TFtpStoreMode(1));
     if not Result then
       AddHistory('Erro enviando : ' + fFile);
   except
    on E: Exception do
      ReportError('Erro no arquivo ('+fFile+'): ' + E.Message);
     end;
 end;
 }

  with FTP do
  begin
    try
       Put(fLocalDir + fFile, fRemoteDir+ '/' + fFile, False);
       Result := True;
    except
      on E: Exception do
        ReportError('Erro no arquivo ('+fFile+'): ' + E.Message);
      end;
  end;

end;

function TDMThread.ChangeFTPDir(fDir: String): Boolean;
begin

  Result := False;

  {
  try
     Result := ApdFtp.ChangeDir(fDir);
     if not Result then
       AddHistory('Erro trocando dir : ' + fDir);
  except
    on E: Exception do
      ReportError('Erro trocar dir ('+fDir+'): ' + E.Message);
  end;
  }

  try
     FTP.ChangeDir(fDir);
     Result := True;
  except
    on E: Exception do
      ReportError('Erro trocar dir ('+fDir+'): ' + E.Message);
  end;

end;

function TDMThread.FileSizeFTP(fFile: String): Integer;
begin

  Result := -1;
  try
    Result := FTP.Size(fFile);
  except
    on E: Exception do
      ReportError('Erro tamanho arquivo ('+fFile+'): ' + E.Message);
  end;

end;

function TDMThread.DirUpFTP: Boolean;
begin

  Result := False;
  {
  try
     Result := ApdFtp.ChangeDir('.');
     if not Result then
       AddHistory('Erro DirUp');
  except
    on E: Exception do
      ReportError('Erro DirUp : ' + E.Message);
  end;
  }

  try
    FTP.ChangeDirUp;
    Result := True;
  except
    on E: Exception do
      ReportError('Erro DirUp : ' + E.Message);
  end;

end;

procedure TDMThread.FTPDisconnected(Sender: TObject);
begin
  AddHistory('FTP desconectado!');
end;

procedure TDMThread.FTPConnected(Sender: TObject);
begin
  AddHistory('FTP conectado!');
end;

procedure TDMThread.MoverCaixasFechados(ACaixaFechado: TStringList; AIDCashReg: Integer);
var
  i : Integer;
  sRootDir : String;
begin

  sRootDir := ExtractFilePath(Application.ExeName);

  if not DirectoryExists(sRootDir + POS_DIR_FILES_HISTORY + IntToStr(AIDCashReg) + '\') then
    ForceDirectories(sRootDir + POS_DIR_FILES_HISTORY + IntToStr(AIDCashReg) + '\');

  for i := 0 to ACaixaFechado.Count-1 do
  begin
    //Removo o destino
    if FileExists(sRootDir + POS_DIR_FILES_HISTORY + ACaixaFechado.Strings[i]) then
      FileDelete(sRootDir + POS_DIR_FILES_HISTORY + ACaixaFechado.Strings[i]);
      
    //Copio a origem para o destino
    if FileExists(sRootDir + POS_DIR_FILES + ACaixaFechado.Strings[i]) then
      MoveFile(sRootDir + POS_DIR_FILES + ACaixaFechado.Strings[i],
               sRootDir + POS_DIR_FILES_HISTORY + ACaixaFechado.Strings[i]);
  end;

end;

function TDMThread.VinculadoImported: Boolean;
begin

  Result := False;

  if LastIDPreSale = 0 then
    Exit;

  with quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('Select Count(L.IDLancamento) Imported');
    SQL.Add('From Fin_LancamentoComplement LC (NOLOCK)');
    SQL.Add('JOIN Fin_Lancamento L (NOLOCK) ON (L.IDLancamento = LC.IDLancamento)');
    SQL.Add('Where L.IDPreSale = ' + IntToStr(LastIDPreSale));
    Open;
    Result := FieldByName('Imported').AsInteger = 0;
  finally
    Close;
  end;

end;


function TDMThread.CupomVinculado(ALine: String): Boolean;
var
  RCupomVinc: TRegCupomVinculado;
begin

  Result := True;

  if not VinculadoImported then
    Exit;

  try
    FSaleLineParser.GetCupomVinculado(ALine, RCupomVinc);
    with cmdInsertLancComplement do
    begin
      Parameters.ParamByName('IDPreSale').Value   := LastIDPreSale;
      Parameters.ParamByName('COO').Value         := RCupomVinc.ACOOVinc;
      Parameters.ParamByName('GNF').Value         := RCupomVinc.AGNFVinc;
      Parameters.ParamByName('CDC').Value         := RCupomVinc.ACDC;
      Parameters.ParamByName('DataEmissao').Value := RCupomVinc.ADataHora;
      Execute;
      LastIDPreSale := 0;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(FFileInfo.FileName + ' ' + E.Message);
    end;
  end;


end;

function TDMThread.AddTotParcial(ALine: String): Boolean;
var
  RRZ: TRegReducaoZ;
  i: Integer;
  bHasReducaoZ: Boolean;
begin
  Result := True;
  try
    FSaleLineParser.GetTotParcial(ALine, RRZ);

    if bHasReducaoZ and (iIDReducaoZ <> 0)then
    begin
      // NOVA TABELA PARA PAF-ECF
      for i := 0 to Pred(Length(RRZ.ATribReducaoZList)) do
      begin
        with cmdInsertTotalizadorParcial do
        begin
          Parameters.ParamByName('IDTotalizadorParcial').Value := GetNextID('Sal_TotalizadorParcial.IDTotalizadorParcial');
          Parameters.ParamByName('Codigo').Value               := RRZ.ATribReducaoZList[i].Codigo;
          Parameters.ParamByName('ValorAcumulado').Value       := RRZ.ATribReducaoZList[i].ValorAcumulado;
          Parameters.ParamByName('IDReducaoZ').Value           := iIDReducaoZ;
          Execute;
        end;
      end;

    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(FormatError(E.Message));
      Result := False;
      ShowDebug('Error : ' + FormatError(E.Message));
    end;
  end;
end;

function TDMThread.GetCOOInicial(AIDCashRegister: Integer;
  AMovDate: TDateTime): Integer;
begin
  with quFreeSQL do
  try
    Close;
    SQL.Text := 'SELECT TOP 1 ' +
                '  CRLC.COO COOInicial ' +
                'FROM ' +
                '  CashRegLogComplement CRLC (NOLOCK) ' +
                '  JOIN CashRegLog CRL (NOLOCK) ON (CRLC.IDCashRegLog = CRL.IDCashRegLog) ' +
                '  JOIN CashRegMov CRM (NOLOCK) ON (CRL.IDCashRegMov = CRM.IDCashRegMov) ' +
                'WHERE ' +
                '  	CRM.IDCashRegister = :IDCashRegister ' +
                '  	AND CRL.IDCashRegTipoLog = 1 ' +
                '  	AND CRL.LogTime >= :DataIni ' +
                '  	AND CRL.LogTime < :DataFim ' +
                '  ORDER BY' +
                '  	CRL.LogTime';
    Parameters.ParamByName('IDCashRegister').Value := AIDCashRegister;
    Parameters.ParamByName('DataIni').Value := AMovDate;
    Parameters.ParamByName('DataFim').Value := IncDay(AMovDate);
    Open;

    if not IsEmpty then
      Result := FieldByName('COOInicial').AsInteger;
  finally
    Close;
  end;
end;

function TDMThread.GetNumCancelamento(AIDCashRegister: Integer;
  AMovDate: TDateTime): Integer;
begin
  with quFreeSQL do
  try
    Close;
    SQL.Text := 'SELECT ' +
                '  COUNT(IDNotasCanceladas) NumCancelamento ' +
                'FROM ' +
                '	 Sal_NotasCanceladas SNC (NOLOCK) ' +
                '	 JOIN CashRegMov CRM (NOLOCK) ON (SNC.IDCashRegMov = CRM.IDCashRegMov) ' +
                'WHERE ' +
                '	 CRM.IDCashRegister = :IDCashRegister ' +
                '	 AND SNC.DataNota >= :DataIni ' +
                '	 AND SNC.DataNota < :DataFim ';
    Parameters.ParamByName('IDCashRegister').Value := AIDCashRegister;
    Parameters.ParamByName('DataIni').Value := AMovDate;
    Parameters.ParamByName('DataFim').Value := IncDay(AMovDate);
    Open;

    if not IsEmpty then
      Result := FieldByName('NumCancelamento').AsInteger;
  finally
    Close;
  end;
end;


function TDMThread.ValidateInvoiceNum(ANum: String): Integer;
begin
  try
    Result := StrToIntDef(ANum, 0);
  except
    Result := 0;
  end;
end;

end.
