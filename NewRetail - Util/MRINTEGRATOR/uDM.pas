unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, Registry, Windows, IniFiles, Forms,
  ufrmServerInfo, Dialogs;


const

   KEY_CUSTOMER_COLUMN = 'ImportCustomerColumn';

   MR_INI_FILE = 'MRIntegrator.ini';

   ACC_SOFTWARE_MAS90 = 'Mas90_';

   ORIGINAL_CUSTOMER_WHERE = 'Path LIKE ''.001%'' AND	P.Desativado = 0 AND P.Hidden = 0';

   ORIGINAL_WHERE = 'P.Desativado = 0 AND P.Hidden = 0';

   SOFTWARE_QUICKEN    = 0;
   SOFTWARE_QUICKBOOKS = 1;
   SOFTWARE_PEACHTREE  = 2;
   SOFTWARE_MAS90      = 3;

   ENTITY_CUSTOMER     = 0;
   ENTITY_PAYMENT      = 1;
   ENTITY_SALE_INVOICE = 2;

   COLUMN_ID           = 0;
   COLUMN_OTHER_ACC    = 1;
   COLUMN_OFFICEM      = 2;

type
  TMRDatabase = class
    private
     fDatabaseName : String;
     fServer       : String;
     fUser         : String;
     fPW           : String;
    public
     property DatabaseName : String read fDatabaseName write fDatabaseName;
     property Server       : String read fServer       write fServer;
     property User         : String read fUser         write fUser;
     property PW           : String read fPW           write fPW;
  end;


  TDM = class(TDataModule)
    MRDBConnection: TADOConnection;
    quCustomer: TADODataSet;
    quPaymentTotal: TADODataSet;
    quPaymentDetail: TADODataSet;
    quPaymentTotalIDPaymentType: TIntegerField;
    quPaymentTotalType: TIntegerField;
    quPaymentTotalPaymentType: TStringField;
    quPaymentTotalTotalType: TBCDField;
    quSaleInvoice: TADODataSet;
    quStoreList: TADODataSet;
    quCategoryList: TADODataSet;
    quStoreListIDStore: TIntegerField;
    quTaxScheduleList: TADODataSet;
    quTaxScheduleListIDTaxCategory: TIntegerField;
    quTaxScheduleListTaxCategory: TStringField;
    quCategoryListIDGroup: TIntegerField;
    quCategoryListName: TStringField;
    quStoreListStore: TStringField;
    quSaleInvoiceInvoiceNumber: TStringField;
    quSaleInvoiceInvoiceDate: TDateTimeField;
    quSaleInvoiceCustomer_No: TIntegerField;
    quSaleInvoiceDiscount: TStringField;
    quSaleInvoiceProductLine: TIntegerField;
    quSaleInvoiceUnitPrice: TBCDField;
    quSaleInvoicePriceExtension: TBCDField;
    quSaleInvoiceTaxableAmount: TBCDField;
    quSaleInvoiceNonTaxableAmount: TBCDField;
    quSaleInvoiceSalesTax: TBCDField;
    quSaleInvoiceLineDiscountPercent: TBCDField;
    quSaleInvoiceUnitCost: TBCDField;
    quSaleInvoiceItemDescription: TStringField;
    quSaleInvoiceShippingDate: TDateTimeField;
    quSaleInvoiceOrderDate: TDateTimeField;
    quSaleInvoiceInvoiceDueDate: TDateTimeField;
    quSaleInvoiceDiscountDueDate: TDateTimeField;
    quSaleInvoiceCustomerName: TStringField;
    quSaleInvoiceCustomerAddress: TStringField;
    quSaleInvoiceCustomerCity: TStringField;
    quSaleInvoiceCustomerZip: TStringField;
    quSaleInvoiceCustomerStateCode: TStringField;
    quSaleInvoiceCustomerState: TStringField;
    quSaleInvoiceShipToAddress: TStringField;
    quSaleInvoiceDiscountValue: TBCDField;
    quSaleInvoiceExtTotalSale: TBCDField;
    quSaleInvoiceStoreName: TStringField;
    quSaleInvoiceCategoryName: TStringField;
    quSaleInvoiceTaxCategory: TStringField;
    quSaleInvoiceTaxClass: TStringField;
    quSaleInvoiceSerialNumber: TStringField;
    quSaleInvoiceCommentLine: TStringField;
    quSaleInvoiceFreight: TBCDField;
    quSaleInvoiceItemNumber: TStringField;
    quSaleInvoiceUserCode: TStringField;
    quPaymentDetailInvoiceNumber: TStringField;
    quPaymentDetailRecordDate: TStringField;
    quPaymentDetailCustomerFullName: TStringField;
    quPaymentDetailCustomer_No: TIntegerField;
    quPaymentDetailUserCode: TStringField;
    quPaymentDetailIDPaymentType: TIntegerField;
    quPaymentDetailType: TIntegerField;
    quPaymentDetailPaymentType: TStringField;
    quPaymentDetailTotalAmount: TBCDField;
    quCustomerStoreNumber: TIntegerField;
    quCustomerCustomer_No: TIntegerField;
    quCustomerUserCode: TStringField;
    quCustomerEntityFullName: TStringField;
    quCustomerAddress: TStringField;
    quCustomerDBA: TStringField;
    quCustomerCity: TStringField;
    quCustomerZip: TStringField;
    quCustomerCountry: TStringField;
    quCustomerPhone: TStringField;
    quCustomerCellPhone: TStringField;
    quCustomerFax: TStringField;
    quCustomerContact: TStringField;
    quCustomerType: TBooleanField;
    quCustomerBirthDay: TDateTimeField;
    quCustomerSocialSecurity: TStringField;
    quCustomerFederalID: TStringField;
    quCustomerSalesTax: TStringField;
    quCustomerCompanyContact: TStringField;
    quCustomerDriveLicence: TStringField;
    quCustomerLastName: TStringField;
    quCustomerFirstName: TStringField;
    quCustomerHorsPerWeek: TIntegerField;
    quCustomerHourValue: TBCDField;
    quCustomerOverHourValue: TBCDField;
    quCustomerDoubleHourValue: TBCDField;
    quCustomerCustomerCard: TStringField;
    quCustomerCode: TIntegerField;
    quCustomerHomePage: TStringField;
    quCustomerEmail: TStringField;
    quCustomerOBS: TStringField;
    quCustomerStateCode: TStringField;
    quCustomerState: TStringField;
    quSaleInvoiceMiscItemFlag: TStringField;
    quSaleInvoiceMiscItemCode: TStringField;
    quSaleInvoiceQty: TFloatField;
    quSaleInvoiceLineType: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure quSaleInvoiceCalcFields(DataSet: TDataSet);
  private
    fMRIntegrator : TIniFile;
    fSoftDefault  :String;
    procedure SetSoftDefault(aSoftDefault: String);
  public
    fMRDatabase : TMRDatabase;
    iSoftware    :Integer;
    iEntityType  :Integer;
    fLocalPath   :String;
    property SoftDefault    : String  read fSoftDefault     write SetSoftDefault;
    procedure OpenCustomer;
    procedure OpenSaleInvoiceCustomer(Cod :String);
    procedure CloseSaleInvoiceCustomer;
    procedure CloseCustomer;
    procedure OpenSaleInvoice(BeginDate, EndDate: String);
    procedure CloseSaleInvoice;
    procedure OpenPaymentTotal(BeginDate, EndDate: String);
    procedure ClosePaymentTotal;
    procedure OpenPaymentDetail(IDMeioPag: Integer; BeginDate, EndDate: String);
    procedure ClosePaymentDetail;
    procedure CloseQuerys;
    procedure CloseQuerysMas90List;
    procedure OpenStoreList;
    procedure OpenCategoryList;
    procedure OpenTaxScheduleList;
    procedure CloseStoreList;
    procedure CloseCategoryList;
    procedure CloseTaxScheduleList;
    function GetIniFile(sSection, sKey : String):String;
    procedure SetIniFileString(sSection, sKey : String; Text : String);

    procedure SetConnection(sServer, sDB, sUser, sPW : String);
    function OpenDatabase:Boolean;
    procedure BuildConnection;
    function GetConnection: String;
    function CloseDatabase:Boolean;
  end;

var
  DM: TDM;

implementation

uses uSqlFunctions, uParamFunctions, uEncryptFunctions;

{$R *.dfm}

procedure TDM.ClosePaymentDetail;
begin
 with quPaymentDetail do
    if Active then
       Close;
end;

procedure TDM.ClosePaymentTotal;
begin
 with quPaymentTotal do
    if Active then
       Close;
end;

procedure TDM.CloseCustomer;
begin
 with quCustomer do
    if Active then
       Close;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
   fMRDatabase    := TMRDatabase.Create;
   fMRIntegrator  := TIniFile.Create(ExtractFilePath(Application.ExeName)+MR_INI_FILE);

   fMRDatabase.DatabaseName := fMRIntegrator.ReadString('MRSetting','Database','');

   fSoftDefault   := fMRIntegrator.ReadString('Setup','SoftwareDefault','');

   fLocalPath     := fMRIntegrator.ReadString('Setup',fSoftDefault+'_FilePath','');

   if fLocalPath='' then
    fLocalPath    := ExtractFilePath(Application.ExeName);

   BuildConnection;

   OpenDatabase; 
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  CloseDatabase; 
  FreeAndNil(fMRIntegrator);
  FreeAndNil(fMRDatabase);
end;

function TDM.GetIniFile(sSection, sKey : String): String;
begin
  Result := fMRIntegrator.ReadString(sSection, sKey, '');
end;

procedure TDM.OpenCustomer;
begin
 with quCustomer do
  begin
  if Active then
   Close;
  Open;
  end;
end;

procedure TDM.OpenPaymentDetail(IDMeioPag: Integer; BeginDate, EndDate: String);
begin
 with quPaymentDetail do
   begin
   if Active then
    Close;
    Parameters.ParamByName('IDMeioPag').Value := IDMeioPag;
    Parameters.ParamByName('BeginDate').Value := BeginDate;
    Parameters.ParamByName('EndDate').Value   := EndDate;
    Open;
   end;
end;

procedure TDM.OpenPaymentTotal(BeginDate, EndDate: String);
begin
 with quPaymentTotal do
   begin
   if Active then
    Close;
    Parameters.ParamByName('BeginDate').Value := BeginDate;
    Parameters.ParamByName('EndDate').Value   := EndDate;
    Open;
   end;
end;

procedure TDM.SetIniFileString(sSection, sKey : String; Text : String);
begin
  fMRIntegrator.WriteString(sSection, sKey, Text);
end;

procedure TDM.CloseSaleInvoice;
begin
 with quSaleInvoice do
    if Active then
       Close;
end;

procedure TDM.OpenSaleInvoice(BeginDate, EndDate: String);
begin
 with quSaleInvoice do
   begin
   if Active then
    Close;
    Parameters.ParamByName('BeginDate').Value := BeginDate;
    Parameters.ParamByName('EndDate').Value   := EndDate;
    Open;
   end;
end;

procedure TDM.CloseQuerys;
begin
 case iEntityType of
  ENTITY_CUSTOMER      : CloseCustomer;
  ENTITY_PAYMENT       :
   begin
    ClosePaymentTotal;
    ClosePaymentDetail;
   end;
  ENTITY_SALE_INVOICE  : CloseSaleInvoice;
 end;
end;

procedure TDM.quSaleInvoiceCalcFields(DataSet: TDataSet);
begin
 if quSaleInvoice.FieldByName('DiscountValue').Value <> 0 then
  quSaleInvoice.FieldByName('Discount').Value := 'Y'
 else
  quSaleInvoice.FieldByName('Discount').Value := 'N';

 if quSaleInvoice.FieldByName('TaxIsent').Value = 1 then
  begin
  quSaleInvoice.FieldByName('TaxableAmount').Value := 0;
  quSaleInvoice.FieldByName('non_TaxableAmount').Value := quSaleInvoice.FieldByName('TotalSale').Value;
  end
 else
  begin
  quSaleInvoice.FieldByName('TaxableAmount').Value := quSaleInvoice.FieldByName('ExtTotalSale').Value;
  quSaleInvoice.FieldByName('non_TaxableAmount').Value := 0;
  end;
end;

procedure TDM.OpenSaleInvoiceCustomer(Cod :string);
var
    sWhere :string;
begin
  if quCustomer.Active then
   quCustomer.Close;

  sWhere                 := ORIGINAL_CUSTOMER_WHERE + ' AND IDPessoa IN ('+Cod+')';
  quCustomer.Commandtext := ChangeWhereClause(quCustomer.CommandText,sWhere,True);
  quCustomer.Open;
end;

procedure TDM.CloseSaleInvoiceCustomer;
begin
 if quCustomer.Active then
  begin
  quCustomer.Close;
  quCustomer.Commandtext := ChangeWhereClause(quCustomer.CommandText,ORIGINAL_CUSTOMER_WHERE,True);
  end;
end;


procedure TDM.SetSoftDefault(aSoftDefault: String);
begin
 fSoftDefault := aSoftDefault;
 fMRIntegrator.WriteString('Setup','SoftwareDefault',aSoftDefault);
end;

function TDM.CloseDatabase;
begin
  with MRDBConnection do
     if Connected then
        try
          Close;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;
end;

function TDM.OpenDatabase: Boolean;
begin
  with MRDBConnection do
   try
      ConnectionString := GetConnection;
      Open;
      Result := True;
   except
    on E: Exception do
       begin
       Result := False;
       ShowMessage(E.Message);
       end;
    end;
end;

procedure TDM.OpenCategoryList;
begin
 with quCategoryList do
  begin
  if Active then
   Close;
  Open;
  end;
end;

procedure TDM.OpenStoreList;
begin
 with quStoreList do
  begin
  if Active then
   Close;
  Open;
  end;
end;

procedure TDM.CloseCategoryList;
begin
 with quCategoryList do
    if Active then
       Close;
end;

procedure TDM.CloseStoreList;
begin
 with quStoreList do
    if Active then
       Close;
end;

procedure TDM.CloseTaxScheduleList;
begin
 with quTaxScheduleList do
    if Active then
       Close;
end;

procedure TDM.OpenTaxScheduleList;
begin
 with quTaxScheduleList do
  begin
  if Active then
   Close;
  Open;
  end;
end;

procedure TDM.CloseQuerysMas90List;
begin
 CloseStoreList;
 CloseCategoryList;
 CloseTaxScheduleList;
end;

procedure TDM.BuildConnection;
begin
 fMRDatabase.DatabaseName := DecodeServerInfo(GetIniFile('MRSetting','Database'), 'Database', CIPHER_TEXT_STEALING, FMT_UU);
 fMRDatabase.Server       := DecodeServerInfo(GetIniFile('MRSetting','Server'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);
 fMRDatabase.User         := DecodeServerInfo(GetIniFile('MRSetting','User'), 'User', CIPHER_TEXT_STEALING, FMT_UU);
 fMRDatabase.PW           := DecodeServerInfo(GetIniFile('MRSetting','PW'), 'PW', CIPHER_TEXT_STEALING, FMT_UU);

end;

function TDM.GetConnection: String;
begin
 Result := 'Provider=SQLOLEDB.1;Password='+fMRDatabase.PW+';Persist Security Info=True;'+
           'User ID='+fMRDatabase.User+';Initial Catalog='+fMRDatabase.DatabaseName+
           ';Data Source='+fMRDatabase.Server+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=DESENV003;Use Encryption for Data=False;Tag with column collation when possible=False';
end;

procedure TDM.SetConnection(sServer, sDB, sUser, sPW: String);
begin
  sDB     := EncodeServerInfo(sDB, 'Database', CIPHER_TEXT_STEALING, FMT_UU);
  sServer := EncodeServerInfo(sServer, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  sUser   := EncodeServerInfo(sUser, 'User', CIPHER_TEXT_STEALING, FMT_UU);
  sPW     := EncodeServerInfo(sPW, 'PW', CIPHER_TEXT_STEALING, FMT_UU);

  SetIniFileString('MRSetting','Database', sDB);
  SetIniFileString('MRSetting','Server', sServer);
  SetIniFileString('MRSetting','User', sUser);
  SetIniFileString('MRSetting','PW', sPW);
  BuildConnection;
  
end;

end.
