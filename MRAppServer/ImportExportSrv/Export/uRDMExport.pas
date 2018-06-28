unit uRDMExport;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigTable;

type
  TRDMExport = class(TRemoteDataModule, IRDMExport)
    dspInvoice: TDataSetProvider;
    qryInvoice: TADODataSet;
    ADOConn: TADOConnection;
    qryInvoiceMarked: TBooleanField;
    qryInvoiceIDInvoice: TIntegerField;
    qryInvoiceMediaID: TIntegerField;
    qryInvoiceFirstName: TStringField;
    qryInvoiceLastName: TStringField;
    qryInvoiceCustomer: TStringField;
    qryInvoiceInvoiceDate: TDateTimeField;
    qryInvoiceIDPreSale: TIntegerField;
    qryInvoiceCanceled: TBooleanField;
    qryInvoiceTotalInvoice: TBCDField;
    qryInvoiceSubTotal: TBCDField;
    qryInvoiceTax: TBCDField;
    qryInvoiceLayaway: TBooleanField;
    qryInvoiceAditionalExpenses: TBCDField;
    qryInvoiceSaleCode: TStringField;
    qryInvoiceInvoiceCode: TStringField;
    qryInvoiceAccGLMainAccount: TStringField;
    qryInvoiceAccInvoiceNumber: TStringField;
    qryInvoiceAccSalesTaxCode: TStringField;
    qryInvoiceAccCashAccount: TStringField;
    qryInvoiceAccCustomerID: TStringField;
    qryCategory: TADODataSet;
    dspCategory: TDataSetProvider;
    qryCategoryCategory: TStringField;
    qryCategoryIDCategory: TIntegerField;
    qryEntity: TADODataSet;
    dspEntity: TDataSetProvider;
    qryEntityIDPessoa: TIntegerField;
    qryEntityIDTipoPessoa: TIntegerField;
    qryEntityPath: TStringField;
    qryEntityPessoa: TStringField;
    qryEntityTelefone: TStringField;
    qryEntityCellular: TStringField;
    qryEntityFax: TStringField;
    qryEntityCode: TIntegerField;
    qryEntitySystem: TBooleanField;
    qryEntityDesativado: TIntegerField;
    qryEntityHidden: TIntegerField;
    qryEntityCountry: TStringField;
    qryEntityStateName: TStringField;
    qryEntityState: TStringField;
    qryEntityAddress: TStringField;
    qryEntityCity: TStringField;
    qryEntityZip: TStringField;
    qryEntityEmail: TStringField;
    qryEntityContact: TStringField;
    qryEntityFederalID: TStringField;
    qryEntitySalesTax: TStringField;
    qryEntityDriverLicense: TStringField;
    qryEntityJobDoc: TStringField;
    qryEntityUserCode: TStringField;
    qryEntitySocialSecurity: TStringField;
    qryEntitySCDate: TDateTimeField;
    qryEntitySCGov: TStringField;
    qryEntityLastName: TStringField;
    qryEntityFirstName: TStringField;
    qryEntityCPF: TStringField;
    qryEntityCGC: TStringField;
    qryEntityCustomerCard: TStringField;
    qryEntityNeighborwood: TStringField;
    qryEntityPhoneAreaCode: TStringField;
    qryEntityCellAreaCode: TStringField;
    qryEntityNascimento: TDateTimeField;
    qryInvoiceTelefone: TStringField;
    qryInvoiceCountry: TStringField;
    qryInvoiceState: TStringField;
    qryInvoiceAddress: TStringField;
    qryInvoiceCity: TStringField;
    qryInvoiceZip: TStringField;
    qryInvoiceEmail: TStringField;
    qryInvoiceContact: TStringField;
    qryInvoicePhoneAreaCode: TStringField;
    qryInvoiceFax: TStringField;
    qrySaleItem: TADODataSet;
    dspSaleItem: TDataSetProvider;
    qrySaleItemModelID: TIntegerField;
    qrySaleItemCaseQty: TBCDField;
    qrySaleItemModel: TStringField;
    qrySaleItemDescription: TStringField;
    qrySaleItemCategory: TStringField;
    qrySaleItemSuggRetail: TBCDField;
    qrySaleItemQty: TBCDField;
    qrySaleItemExchangeInvoice: TIntegerField;
    qrySaleItemSalePrice: TBCDField;
    qrySaleItemCostPrice: TBCDField;
    qrySaleItemDiscount: TBCDField;
    qrySaleItemItemTotalSold: TBCDField;
    qrySaleItemIDUser: TIntegerField;
    qrySaleItemIDComission: TIntegerField;
    qrySaleItemIDInventoryMov: TIntegerField;
    qrySaleItemTax: TBCDField;
    qrySaleItemNotVerifyQty: TBooleanField;
    qrySaleItemIDDepartment: TIntegerField;
    qrySaleItemRequestCustomer: TBooleanField;
    qrySaleItemPuppyTracker: TBooleanField;
    qrySaleItemPromo: TBooleanField;
    qrySaleItemSellingPrice: TBCDField;
    qrySaleItemIDMovParent: TIntegerField;
    qrySalePayment: TADODataSet;
    dspSalePayment: TDataSetProvider;
    qrySalePaymentIDLancamento: TIntegerField;
    qrySalePaymentValorNominal: TBCDField;
    qrySalePaymentMeioPag: TStringField;
    qrySalePaymentTipo: TIntegerField;
    qrySalePaymentDataLancamento: TDateTimeField;
    qryTimeClock: TADODataSet;
    dspTimeClock: TDataSetProvider;
    qryTimeClockEnterDate: TDateTimeField;
    qryTimeClockExitDate: TDateTimeField;
    qryTimeClockWorkedHour: TDateTimeField;
    qryTimeClockWorkHourPay: TIntegerField;
    qryTimeClockWorkMunitPay: TBCDField;
    qryTimeClockPessoa: TStringField;
    qryTimeClockIDUser: TIntegerField;
    qryTimeClockStore: TStringField;
    qryTimeClockMarked: TBooleanField;
    dspQBCashRegMov: TDataSetProvider;
    ctQBCashRegMov: TmrConfigTable;
    qryQBCashRegMov: TADOQuery;
    qryQBCashRegMovMarked: TBooleanField;
    qryQBCashRegMovIDCashRegMov: TIntegerField;
    qryQBCashRegMovOpenTime: TDateTimeField;
    qryQBCashRegMovGrandTotal: TCurrencyField;
    qryQBCashRegMovTotalCash: TBCDField;
    dspQBPayments: TDataSetProvider;
    ctQBPayments: TmrConfigTable;
    quQBPayments: TADOQuery;
    quQBPaymentsIDMeioPag: TIntegerField;
    quQBPaymentsMeioPag: TStringField;
    quQBPaymentsAmount: TBCDField;
    qryQBCashRegMovCashRegister: TStringField;
    qryQBCashRegMovTotalCheck: TBCDField;
    qryQBCashRegMovIDStore: TIntegerField;
    qryQBCashRegMovTransDate: TDateTimeField;
    qryQBCashRegMovTransNum: TStringField;
    dspQBCashRegItem: TDataSetProvider;
    ctQBCashRegItem: TmrConfigTable;
    quQBCashRegItem: TADOQuery;
    quQBCashRegItemIDGroup: TIntegerField;
    quQBCashRegItemCategory: TStringField;
    quQBCashRegItemItemTotalSold: TBCDField;
    quQBCashRegItemTax: TBCDField;
    qryQBCashRegMovTotalTax: TCurrencyField;
    qryQBCashRegMovTotalPetty: TBCDField;
    procedure dspInvoiceBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspInvoiceAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspEntityAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspEntityBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspSaleItemAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspSaleItemBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspSalePaymentAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspSalePaymentBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspTimeClockAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspTimeClockBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure qryQBCashRegMovCalcFields(DataSet: TDataSet);
    procedure ctQBCashRegMovBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure ctQBPaymentsBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FOldSQL: String;
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
    function GetOtherTotal(AIDCashRegMov : Integer) : Currency;
    function GetTotalTax(AIDCashRegMov : Integer) : Currency;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    function ExportPO(AFile: OleVariant; const PONumber: WideString;
      var AMsgLog: WideString): OleVariant; safecall;
    function InsertConfigExport(IDPessoa: Integer; const DelimiterSeparator,
      DecimalSeparator, HeaderConfig, FileFormat: WideString;
      HeaderFile: WordBool; ExportType: Integer;
      var AMsgLog: WideString): WordBool; safecall;
    function GetConfigExport(IDPessoa, ExportType: Integer;
      var DelimiterSeparator, DecimalSeparator, HeaderConfig,
      FileFormat: WideString; var HeaderFile: WordBool;
      var AMsgLog: WideString): WordBool; safecall;
  end;

var
  RDMExport: TRDMExport;
  RDMExportFactory: TComponentFactory;

implementation

uses uDMExportPO, uDMExportTextFile, uSqlFunctions, uMRSQLParam;

{$R *.DFM}

class procedure TRDMExport.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TRDMExport.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMExport.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMExport.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection
    else if Components[i] is TADODataSet then
      TADODataSet(Components[i]).Connection := FSQLConnection;

end;

function TRDMExport.ExportPO(AFile: OleVariant; const PONumber: WideString;
  var AMsgLog: WideString): OleVariant;
begin
  with TDMExportPO.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    IDPO := StrToInt(PONumber);
    ExportFile;
    Result := TextFile.Data;
    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

procedure TRDMExport.dspInvoiceBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin

  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if OwnerData <> '' then
    begin
      FOldSQL := qryInvoice.CommandText;
      qryInvoice.CommandText := FOldSQL + ' WHERE ' + Param.GetWhereSQL;
    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';

end;

procedure TRDMExport.dspInvoiceAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qryInvoice.CommandText := FOldSQL;
end;

procedure TRDMExport.dspEntityAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qryEntity.CommandText := FOldSQL;
end;

procedure TRDMExport.dspEntityBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin

  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if OwnerData <> '' then
    begin
      FOldSQL := qryEntity.CommandText;
      qryEntity.CommandText := FOldSQL + ' WHERE ' + Param.GetWhereSQL;
    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';

end;

procedure TRDMExport.dspSaleItemAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qrySaleItem.CommandText := FOldSQL;
end;

procedure TRDMExport.dspSaleItemBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
  sWhereSQL : String;
begin

  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if OwnerData <> '' then
    begin
      FOldSQL := qrySaleItem.CommandText;

      sWhereSQL := Param.GetWhereSQL;

      if sWhereSQL <> '' then
        sWhereSQL := sWhereSQL + ' AND IM.IDParentPack Is Null AND IM.InventMovTypeID = 1 '
      else
        sWhereSQL := ' IM.IDParentPack Is Null AND IM.InventMovTypeID = 1 ';

      qrySaleItem.CommandText := FOldSQL + ' WHERE ' + sWhereSQL;


    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';

end;

procedure TRDMExport.dspSalePaymentAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qrySalePayment.CommandText := FOldSQL;
end;

procedure TRDMExport.dspSalePaymentBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin

  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if OwnerData <> '' then
    begin
      FOldSQL := qrySalePayment.CommandText;
      qrySalePayment.CommandText := FOldSQL + ' WHERE ' + Param.GetWhereSQL;
    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';

end;

procedure TRDMExport.dspTimeClockAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qryTimeClock.CommandText := FOldSQL;
end;

procedure TRDMExport.dspTimeClockBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin

  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if OwnerData <> '' then
    begin
      FOldSQL := qryTimeClock.CommandText;
      qryTimeClock.CommandText := FOldSQL + ' WHERE ' + Param.GetWhereSQL;
    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';

end;

procedure TRDMExport.qryQBCashRegMovCalcFields(DataSet: TDataSet);
var
  cCash, cCheck : Currency;
begin

  cCash := qryQBCashRegMov.FieldByName('TotalCash').AsCurrency;

  if cCash < 0 then
    cCash := 0;

  cCheck := qryQBCashRegMov.FieldByName('TotalCheck').AsCurrency;

  if cCheck < 0 then
    cCheck := 0;

  qryQBCashRegMov.FieldByName('GrandTotal').AsCurrency := cCash + cCheck +
                 GetOtherTotal(qryQBCashRegMov.FieldByName('IDCashRegMov').AsInteger);

  qryQBCashRegMov.FieldByName('TransNum').AsString :=
                 IntToStr(qryQBCashRegMov.FieldByName('IDStore').asInteger) +
                 FormatDateTime('yymmdd', qryQBCashRegMov.FieldByName('TransDate').AsDateTime);

  qryQBCashRegMov.FieldByName('TotalTax').AsCurrency :=
                 GetTotalTax(qryQBCashRegMov.FieldByName('IDCashRegMov').AsInteger);

end;

function TRDMExport.GetOtherTotal(AIDCashRegMov: Integer): Currency;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add('SELECT IsNull(SUM(L.ValorNominal),0) as TotalOther');
    FQuery.SQL.Add('FROM Fin_Lancamento L (NOLOCK)');
    FQuery.SQL.Add('JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)');
    FQuery.SQL.Add('WHERE L.IDCashRegMov = :IDCashRegMov');
    FQuery.SQL.Add('AND MP.Tipo IN (2, 7)');
    FQuery.Parameters.ParamByName('IDCashRegMov').Value := AIDCashRegMov;
    FQuery.Open;
    Result := FQuery.FieldByName('TotalOther').Value;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

procedure TRDMExport.ctQBCashRegMovBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sWhere: WideString;
  Where: TMRSQLParam;
begin

  try
    Where := TMRSQLParam.Create;
    Where.ParamString := OwnerData;

    sWhere := Where.GetWhereSQL +
                 ' AND CRM.IDCashRegStatus in (2, 3) ';

    OwnerData := sWhere;

  finally
    FreeAndNil(Where);
  end;

end;

procedure TRDMExport.ctQBPaymentsBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sWhere: WideString;
  Where: TMRSQLParam;
begin

  try
    Where := TMRSQLParam.Create;
    Where.ParamString := OwnerData;

    sWhere := Where.GetWhereSQL +
                 ' AND MP.Tipo IN (2, 7) ';

    OwnerData := sWhere;

  finally
    FreeAndNil(Where);
  end;

end;

function TRDMExport.GetTotalTax(AIDCashRegMov: Integer): Currency;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add('SELECT SUM(I.Tax) as SaleTax');
    FQuery.SQL.Add('FROM Invoice I (NOLOCK)');
    FQuery.SQL.Add('WHERE I.CashRegMovID = :IDCashRegMov');
    FQuery.Parameters.ParamByName('IDCashRegMov').Value := AIDCashRegMov;
    FQuery.Open;
    Result := FQuery.FieldByName('SaleTax').Value;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TRDMExport.InsertConfigExport(IDPessoa: Integer;
  const DelimiterSeparator, DecimalSeparator, HeaderConfig,
  FileFormat: WideString; HeaderFile: WordBool; ExportType: Integer;
  var AMsgLog: WideString): WordBool;
begin
  with TDMExportTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    Result := CreateConfigExport(IDPessoa, DelimiterSeparator, DecimalSeparator,
                                 HeaderConfig, FileFormat, HeaderFile,
                                 ExportType);
    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

function TRDMExport.GetConfigExport(IDPessoa, ExportType: Integer;
  var DelimiterSeparator, DecimalSeparator, HeaderConfig,
  FileFormat: WideString; var HeaderFile: WordBool;
  var AMsgLog: WideString): WordBool;

var
  ADelimiterSeparator, ADecimalSeparator, AHeaderConfig, AFileFormat: String;
  AHeaderFile: WordBool;
begin
  with TDMExportTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    Result := GetConfigExport(IDPessoa, ExportType,
                              ADelimiterSeparator, ADecimalSeparator,
                              AHeaderConfig, AFileFormat, AHeaderFile);

    DelimiterSeparator := ADelimiterSeparator;
    DecimalSeparator := ADecimalSeparator;
    HeaderConfig := AHeaderConfig;
    FileFormat := AFileFormat;
    HeaderFile := AHeaderFile;

    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

initialization
  RDMExportFactory := TComponentFactory.Create(ComServer, TRDMExport,
    Class_RDMExport, ciInternal, tmApartment);
end.
