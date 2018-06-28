unit uFilePersistence;

interface

uses Classes, DB, uStringFunctions, SysUtils, Variants, Math, DBClient, IniFiles, Windows;

const
  FMT_DATE = 'YYYYMMDDHHNNSS';


  TAM_DATE    = Length(FMT_DATE);
  TAM_INT     = 11;
  TAM_REAL    = 21;
  TAM_BOOLEAN = 1;

  TAM_DEC     = 4;

  CHR_SPACE   = ' ';
  CHR_ZERO    = '0';

  STR_CRLF    = #13#10;

  STR_MEMO_SEP = 'G';

  SUB_HIDDEN_NAME = '\security\logs\transactions.log';

type
  TSaleLineType = (sltUnknow, sltOpenCash, sltOpenSale, sltAddItem,
                   sltAddPayment, sltCloseSale, sltCloseCash,
                   sltAddCustomer, sltWC, sltPC, sltCancelSale,
                   sltRemovedItem, sltReducaoZ, sltAbortSale, sltCancelItem,
                   sltAddSerialNumber, sltOBS, sltCupomVinculado, sltTotParcial);

  TLastSaleItem = class
    FCanceled : Boolean;
    FItemLine : String;
    FSerialList: TList;
  private
    procedure ClearSerialList;
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TLastSaleItemSerial = class
    FItemSerialLine : String;
  end;

  TLastSale = class
    FOpenSaleLine : String;
    FCloseSaleLine : String;
    FCustomerLine : String;
    FSaleCode : String;
    FOBS : String;
    FIDCashRegister : Integer;
    FIDUser : Integer;
    FCanceled : Boolean;
    FItemList : TStringList;
    FPaymentList : TStringList;

    procedure AddItem(ALine:String);
    procedure AddPayment(ALine:String);
    procedure AddItemSerial(ALine:String);
    procedure ClearLastSale;
    procedure CancelItem(APosition : Integer);

    constructor Create;
    destructor Destroy;override;
  end;

  TRegTribReducaoZ = record
    Codigo: String;
    ValorAcumulado: Currency;
  end;

  TRegReducaoZ = record
    AMovDate          : TDateTime;
    ANumeroSerie      : String;
    ANumeroLoja       : Integer;
    ANumeroECF        : Integer;
    ANumReducaoZ      : Integer;
    ACOOInicial       : Integer;
    ACOOFinal         : Integer;
    ANumCancelamentos : Integer;
    AValCancelamentos : Currency;
    AValDescontos     : Currency;
    AGTInicial        : Currency;
    AGTFinal          : Currency;
    ASubstituicaoTrib : Currency;
    AIsencao          : Currency;
    ANaoTributavel    : Currency;
    AAliquota         : array of Double;
    ABaseCalculo      : array of Currency;
    AValImposto       : array of Currency;
    ////////////////////////////////////////////////////////////////////////////
    // NOVOS CAMPOS PARA O PAF-ECF
    ATipoECF                  : String;
    AMarcaECF                 : String;
    AModeloECF                : String;
    AVersaoSBECF              : String;
    ADataInstalacaoSBECF      : TDateTime;
    AMFAdicional              : String;
    AContadorReducaoZ         : Integer;
    AContadorOrdemOperacao    : Integer;
    AContadorReinicioOperacao : Integer;
    ANumeroUsuarioECF         : Integer;
    AIncideISSQN              : Boolean;
    ADataEmissao              : TDateTime;
    ATribReducaoZList         : array of TRegTribReducaoZ;
  end;

  TRegOpenCash = record
    A100, A50, A20, A10, A05, A02, A01,
    A0100, A050, A025, A010, A005, A001, AIDCashReg, AIDUser: Integer;
    ATotalCount, ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
    ATotalOther, ATotalDebit: Currency; ADate: TDateTime;
    ACOO, AGNF : Integer;
    AIDCashRegMov: Integer;
  end;

  TRegOpenSale = record
    AIDCashreg, AIDPreSale, ADeliverType, AIDCustomer, AIDMedia, AIDOtherComm,
    AIDStore, AIDTourGroup: Integer;
    AIsLayaway, ATaxExempt, APuppyTracker: Boolean;
    AFName, ALName, AZip, AInvObs, ASaleCode, ACOO, ASerialECF: String;
    APreSaleDate: TDateTime; APreSaleType: Integer; ACCF : String;
  end;

  TRegAddCustomer = record
    AIDTipoPessoa, AIDTipoPessoaRoot: Integer;
    AFirstName, ALastName, AEndereco, ACidade, ABairro, AZip, ADocumento,
    ATelefone, AEstado, ATelDDD, ACelDDD, ACelelular, AEmail, AWebSite,
    ACPF, AIdentidate, AOrgEmiss, ACustCard, ACMotorista,
    ANomeJuridico, AInscEstadual, AInscMunicipal, AContato, AOBS: String;
    AJuridico:Boolean; AExpDate, ABirthDate : TDateTime;
  end;

  TRegAddItem = record
    AIDCustomer, AIDHold, AIDModel, AIDStore, AIDDepartment : Integer;
    AQty: Double; ADiscount, ASale, ACost: Currency; AIDUser,
    AIDCommis: Integer; AMovDate, ADate: TDateTime; AResetDisc,
    AManager: Boolean; AIDDescriptionPrice, AIDVendorPrice: Integer;
    ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentType: Integer;
    ATotParcial : String;
  end;

  TRegAddPayment = record
    AIDPreSale, AIDStore, AIDUser,
    AIDCustomer, AIDMeioPag, AIDCashRegMov, APayType: Integer; APreSaleDate,
    AExpireDate: TDateTime; ANumParcela, AAutotize: String;
    ATotalInvoice: Currency; ACheckNumber, ACustomerDocument, ACustomerName,
    ACustomerPhone: String; AIDBankCheck: Integer; AOBS: String;
    APaymentPlace: Integer; AIsPreDatado: Boolean;
  end;

  TRegAddPC = record
    AIDCashRegMov, AIDUser: Integer;
    ACash : Currency;
    ADate : TDateTime;
    AOBS: String;
    ACOO, AGNF : Integer;
  end;

  TRegAddWC = record
    AIDCashRegMov, AIDUser, A100,
    A50, A20, A10, A05, A02, A01, A0100, A050, A025, A010, A005,
    A001: Integer; ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
    ATotalOther, ATotalDebit: Currency; AEnvolop: String; ADate: TDateTime;
    AOBS: String; AIDReason : Integer; ACOO, AGNF : Integer;
  end;

  TRegCloseSale = record
    AIDPreSale, AIDTourGroup, AIDOtherCommis,
    AIDCashRegMov, AIDStore: Integer; ADate, APayDate: TDateTime;
    ACashReceived, ASaleDiscount: Currency;
  end;

  TRegCloseCash = record
    AIDCashRegMov, AIDUser, A100, A50,
    A20, A10, A05, A02, A01, A0100, A050, A025, A010, A005, A001: Integer;
    ATotalCount, ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
    ATotalOther, ATotalDebit: Currency; AEnvolop: String; ADate: TDateTime;
  end;

  TRegCancelSale = record
    ACOO:     String;
    AIDUser:  Integer;

    // Não serão preenchido pelo getCancelSale
    // Adicionados para uso exclusivo na
    // classd TTXTCashInfo
    ACash:    Currency;
    ACard:    Currency;
    APreCard: Currency;
    ACheck:   Currency;
    AOther:   Currency;
  end;

  TRegRemovedItem = record
    AIDCashReg, AIDModel, AIDStore, AIDDepartment: Integer;
    AQty: Double;
    ADiscount, ASale, ACost: Currency;
    AIDUser, AIDUserAuto, AIDCommis: Integer;
    AMovDate: TDateTime;
    ASaleCode, ATotParcial : String;
    APosicaoItem, AIDNotasCanceladas,
    AIDPreSale: Integer; AAcrescimo : Currency;
  end;

  TRegSerialNumber = record
    APosition: Integer;
    ASerialNumber: String;
    AIdentificationNumber: String;
  end;

  TRegOBS = record
    AOBS: String;
  end;

  TRegCupomVinculado = record
    ACOOVinc,
    AGNFVinc,
    ACDC: Integer;
    ADataHora: TDateTime
  end;

  TFieldValueKind = (fvkInt, fvkFloat, fvkDate, fvkBoolean, fvkString, fvkDummy, fvkMemo);

  TPDVTextFile = class
  private
    FFileName: String;
  public
  protected
    function HasMoreLines: Boolean;virtual;abstract;
    function NextLine: String;virtual;abstract;
    property FileName: String  read FFileName write FFileName;
  end;

  TFieldToStringParser = class;

  TDBExportFile = class(TPDVTextFile)
  private
    FSource: TDataSet;
    FSaveConfig: Boolean;
    FConfigFileName: String;
    FFieldToStringParser: TFieldToStringParser;
    function PrepareLine: String;
    function PrepareField(AField: TField): String;
    procedure WriteConfig;
  protected
    function HasMoreLines: Boolean;override;
    function NextLine: String;override;

  public
    property SaveConfig:     Boolean  read FSaveConfig     write FSaveConfig default True;
    property ConfigFileName: String   read FConfigFileName write FConfigFileName;
    property Source:         TDataSet read FSource         write FSource;
    function SaveAll: Boolean;
    property FileName;

    constructor Create;
    destructor Destroy;override;
  end;

  TStringToFieldParser = class
  private
    FValue: String;
  public
    property Value: String read FValue write FValue;
    function ParseInt: Variant;
    function ParseFloat: Variant;
    function ParseLongFloat: Variant;    
    function ParseDate: Variant;
    function ParseBoolean: Variant;
    function ParseMemo: Variant;

    procedure CutBoolean(var AValue: Boolean; var ALine: String);
    procedure CutDate(var AValue: TDateTime; var ALine: String);
    procedure CutInteger(var AValue: Integer; var ALine: String);
    procedure CutReal(var AValue: Currency; var ALine: String);
    procedure CutLongReal(var AValue: Currency; var ALine: String);    
    procedure CutString(var AValue, ALine: String; const ASize: Integer);
    procedure CutMemo(var AValue: String; var ALine: String);
    procedure CutDouble(var AValue: Double; var ALine: String);
  end;


  TFieldToStringParser = class
  private
    function GetSignal(Value: Variant): Char;
  public
    function PrepareFieldBoolean(AValue: Variant;
      AIsNull: Boolean): String;
    function PrepareFieldDate(AValue: Variant; AIsNull: Boolean): String;
    function PrepareFieldInt(AValue: Variant; AIsNull: Boolean): String;
    function PrepareFieldReal(AValue: Variant; AIsNull: Boolean): String;
    function PrepareFieldString(AValue: String; AIsNull: Boolean;
      ASize: Integer): String;
    function PrepareFieldMemo(AValue: Variant; AIsNull: Boolean): String;
  end;

  TFieldMapping = class
  private
    FFieldName: String;
    FFieldValueKind: TFieldValueKind;
    FSize: Integer;
    FFound: Boolean;
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
    procedure SetFieldValueKind(const Value: TFieldValueKind);
  public
    property FieldName:      String          read FFieldName      write FFieldName;
    property FieldValueKind: TFieldValueKind read FFieldValueKind write SetFieldValueKind;
    property Size:           Integer         read GetSize         write SetSize;
    property Found:          Boolean         read FFound          write FFound;
  end;

  TCDSImportFile = class(TPDVTextFile)
  private
    FClientDataSet: TClientDataSet;
    FMappingList:   TStringList;
    FData:          TStringList;
    FCurrentLine:   Integer;
    FStringToFieldParser:   TStringToFieldParser;
    FIndexField: String;
    function GetFieldMaps(Index: Integer): TFieldMapping;
    procedure SetFieldMaps(Index: Integer; const Value: TFieldMapping);

    function SaveLine(ALine: String): Boolean;
    procedure TestMappings;
  protected
    function HasMoreLines: Boolean;override;
    function NextLine: String;override;
  public

    property ClientDataSet: TClientDataSet read FClientDataSet write FClientDataSet;
    property FieldMaps[Index: Integer]: TFieldMapping read GetFieldMaps write SetFieldMaps;
    property FileName;
    property IndexField: String read FIndexField write FIndexField;

    constructor Create;
    destructor Destroy;override;

    function AddMapping(AFieldName: String; AFieldValueKind: TFieldValueKind; ASize: Integer = 0): Integer;
    function MappingByName(AName: String): TFieldMapping;
    function Count: Integer;
    procedure Clear;

    procedure Reset;

    function SaveAll: Boolean;

    function ReadTableConfig(AININame, ATableName: String): Boolean;

  end;

  TConfigWritter = class
  private
    FConfigFilename: String;
    FDataSet: TDataSet;
    FTablename: String;
    function SaveFieldConfig(AIni: TIniFile; AField: TField): Boolean;
  public
    property ConfigFilename: String read FConfigFilename write FConfigFileName;
    property DataSet: TDataSet read FDataSet write FDataSet;
    property TableName: String read FTablename write FTableName;

    function SaveConfig: Boolean;
  end;


  TSaleWritter = class
  private
    FFieldToStringParser: TFieldToStringParser;
    FSaleLines: TStringList;
    FIDCashReg: Integer;
    FFileOpened: Boolean;
    FLocalWorkingDir: String;
    FRemoteWorkingDir: String;
    FFileName: String;
    FLogicalFile: TextFile;
    FHiddenFile: TextFile;
    function CreateNewFile: Boolean;
    function WriteSaleToFile: Boolean;
    procedure DeleteHiddenFileLog(iDays, iFileSizeMB : Integer);
    procedure OpenHiddenFile;
    function GetLinhaReducaoZ(AReducaoZ: TRegReducaoZ): String;
    function GetLinhaTotParcial(AReducaoZ: TRegReducaoZ): String;
  public
    property IDCashReg:        Integer read FIDCashReg        write FIDCashReg;
    property FileName:         String  read FFileName         write FFileName;
    property FileOpened:       Boolean read FFileOpened       write FFileOpened;
    property LocalWorkingDir:  String  read FLocalWorkingDir  write FLocalWorkingDir;
    property RemoteWorkingDir: String  read FRemoteWorkingDir write FRemoteWorkingDir;

    constructor Create(iDays, iFileSizeMB : Integer);
    destructor Destroy;override;


    procedure CloseSaleFile;


     function AddCustomer(AIDTipoPessoa, AIDTipoPessoaRoot: Integer;
       AFirstName, ALastName, AEndereco, ACidade, ABairro, AZip, ADocumento,
       ATelefone, {novos} AEstado, ATelDDD, ACelDDD, ACelelular, AEmail, AWebSite,
       ACPF, AIdentidate, AOrgEmiss, ACustCard, ACMotorista,
       ANomeJuridico, AInscEstadual, AInscMunicipal, AContato, AOBS: String;
       AJuridico:Boolean; AExpDate, ABirthDate : TDateTime):  String;


     function AddHoldItem(AIDCustomer, AIDHold, AIDModel, AIDStore, AIDDepartment : Integer; AQty: Double;
                          ADiscount, ASale, ACost: Currency;
                          AIDUser, AIDCommis: Integer;
                          AMovDate, ADate: TDateTime;
                          AResetDisc, AManager: Boolean;
                          AIDDescriptionPrice, AIDVendorPrice: Integer;
                          ASuggPrice: Currency; ADocumentNumber: String;
                          AIDDocumentNumber: Integer; ATotParcial : String): String;


     function AddRemovedItem(AIDCashReg, AIDModel, AIDStore, AIDDepartment : Integer; AQty: Double;
                          ADiscount, ASale, ACost: Currency;
                          AIDUser, AIDUserAuto, AIDCommis: Integer;
                          AMovDate: TDateTime; ASaleCode : String): String;

     function AddPayment(AIDPreSale, AIDStore, AIDUser, AIDCustomer,
                         AIDMeioPag, AIDCashRegMov: Integer;
                         APreSaleDate, AExpireDate: TDateTime;
                         ANumParcela, AAutotize: String;
                         ATotalInvoice: Currency;
                         ACheckNumber, ACustomerDocument,
                         ACustomerName, ACustomerPhone: String;
                         AIDBankCheck: Integer;
                         AOBS: String;
                         APaymentPlace: Integer;
                         AIsPreDatado: Boolean; APayType: Integer): String;

    function AddPettyCash(AIDCashRegMov, AIDUser: Integer; ACash: Currency;
      ADate: TDateTime; AOBS: String; ACOO, AGNF : Integer): Boolean;

    function CancelFiscalSale(ACOO: String; IDUser: Integer): Boolean;

    function AbortSale(ACOO: String): String;

    function SaveObs(AOBS: String): String;

    function CancelItem(Position: Integer): String;

    function CreateHold(ADeliverType: Integer; AIsLayaway: Boolean;
      AIDStore: Integer; AFName, ALName, AZip: String;
      AIDTourGroup: Integer; APreSaleDate: TDateTime; AIDCustomer,
      AIDMedia, AIDOtherComm: Integer; AInvObs,
      ASaleCode, ACOO: String; ATaxExempt: Boolean; AIDPreSale: Integer;
      APuppyTracker: Boolean; AECFSerial, ACCF : String): String;

    function GetSaleCloseLine(AIDPreSale, AIDTourGroup, AIDOtherCommis,
                              AIDCashRegMov, AIDStore: Integer;
                              ADate, APayDate: TDateTime;
                              ACashReceived, ASaleDiscount: Currency): String;

   function PreSalePay(AIDPreSale, AIDTourGroup, AIDOtherCommis,
                       AIDCashRegMov, AIDStore: Integer;
                       ADate, APayDate: TDateTime;
                       ACashReceived, ASaleDiscount: Currency): String;

   function OpenCashRegister(A100, A50, A20, A10, A05, A02, A01,
                             A0100, A050, A025, A010, A005, A001: Integer;
                             AIDCashReg, AIDUser: Integer;
                             ATotalCount, ATotalCash, ATotalCard, ATotalPreCard,
                             ATotalCheck, ATotalOther: Currency;
                             ADate: TDateTime; ATotalDebit: Currency;
                             ACOO, AGNF : Integer; AReducaoZ: TRegReducaoZ): Boolean;

   function OpenFile(AFileName: String): Boolean;

   function CloseCashRegister(AIDCashRegMov, AIDUser: Integer;
                              A100, A50, A20, A10, A05, A02, A01,
                              A0100, A050, A025, A010, A005, A001: Integer;
                              ATotalCount, ATotalCash, ATotalCard, ATotalPreCard,
                              ATotalCheck, ATotalOther: Currency;
                              AEnvolop: String; ADate: TDateTime; ATotalDebit: Currency;
                              AReducaoZ: TRegReducaoZ): Boolean;

   function WithdrawCashRegister(AIDCashRegMov, AIDUser: Integer;
                              A100, A50, A20, A10, A05, A02, A01,
                              A0100, A050, A025, A010, A005, A001: Integer;
                              ATotalCash, ATotalCard, ATotalPreCard,
                              ATotalCheck, ATotalOther: Currency;
                              AEnvolop: String;
                              ADate: TDateTime;
                              AOBS: String; ATotalDebit: Currency;
                              AIDReason : Integer;
                              ACOO, AGNF: Integer): Boolean;

   function AddSerialNumber(APosition: Integer; ASerialNumber, AIdentificationNumber: String): Boolean;

   function AddVinculadoInfo(ACOOVinc, AGNFVinc, ACDC : Integer; ADataHora: TDateTime) : Boolean;

  end;

  TSaleLineParser = class
  private
    FStringToFieldParser: TStringToFieldParser;
  public
    constructor Create;
    destructor Destroy;override;

    procedure GetAddCustomer(const ALine: String;
      var RAC: TRegAddCustomer);
    procedure GetAddItem(const ALine: String; var RAI: TRegAddItem);
    procedure GetAddPayment(const ALine: String; var RAP: TRegAddPayment);
    procedure GetAddPC(const ALine: String; var RAPC: TRegAddPC);
    procedure GetAddWC(const ALine: String; var RAWC: TRegAddWC);
    procedure GetCloseCash(ALine: String; var RCC: TRegCloseCash);
    procedure GetCloseSale(const ALine: String; var RCS: TRegCloseSale);
    procedure GetOpenCash(const ALine: String; var ROC: TRegOpenCash);
    procedure GetOpenSale(const ALine: String; var ROS: TRegOpenSale);
    procedure GetCancelSale(const ALine: String; var RCS: TRegCancelSale);
    procedure GetRemovedItem(const ALine: String; var RRI: TRegRemovedItem);
    procedure GetReducaoZ(const ALine: String; var RRZ: TRegReducaoZ);
    procedure GetTotParcial(const ALine: String; var RRZ: TRegReducaoZ);
    procedure GetItemCanceled(const ALine: String; var Position: Integer);
    procedure GetAddSerialNumber(const ALine: String; var RSN: TRegSerialNumber);
    procedure GetOBS(const ALine: String; var ROBS: TRegOBS);
    procedure GetCupomVinculado(const ALine: String; var RCupomVinculado : TRegCupomVinculado);

    function LineType(ALine: String): TSaleLineType;
  end;

  procedure SetCDSIndex(AClientDataSet: TClientDataSet; AIndexField: String);

implementation

uses DateUtils;

{ TDBExportFile }

function TDBExportFile.HasMoreLines: Boolean;
begin
  Result := (not (FSource.Eof or FSource.IsEmpty)) and FSource.Active;
end;

function TDBExportFile.NextLine: String;
begin
  Result := PrepareLine;
  FSource.Next;
end;

function TDBExportFile.PrepareLine: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FSource.FieldCount - 1 do
    Result := Result + PrepareField(FSource.Fields[I]);
end;

function TDBExportFile.PrepareField(AField: TField): String;
begin
  case AField.DataType of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint,
    ftAutoInc:
      Result := FFieldToStringParser.PrepareFieldInt(AField.Value, AField.IsNull);
    ftFloat,
    ftCurrency,
    ftBCD:
      Result := FFieldToStringParser.PrepareFieldReal(AField.Value, AField.IsNull);
    ftDate,
    ftTime,
    ftDateTime:
      Result := FFieldToStringParser.PrepareFieldDate(AField.Value, AField.IsNull);
    ftBoolean:
      Result := FFieldToStringParser.PrepareFieldBoolean(AField.Value, AField.IsNull);
    ftString, ftWideString:
      Result := FFieldToStringParser.PrepareFieldString(AField.AsString, AField.IsNull, AField.Size);
    ftMemo:
      Result := FFieldToStringParser.PrepareFieldMemo(AField.AsString, AField.IsNull);
    else
      result := '';
  end;
end;

function TDBExportFile.SaveAll: Boolean;
var
  stlSave: TStringList;
begin
  Result := True;
  try
    if FSaveConfig then
      WriteConfig;

    stlSave := TStringList.Create;
    try
      while HasMoreLines() do
        stlSave.Add(NextLine);
      stlSave.SaveToFile(FileName);
    finally
      stlSave.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TDBExportFile.WriteConfig;
var
  ConfW: TConfigWritter;
begin
  ConfW := TConfigWritter.Create;
  try
    ConfW.ConfigFilename := FConfigFileName;
    ConfW.TableName      := UpperCase(ChangeFileExt(ExtractFileName(FileName), ''));
    ConfW.DataSet        := FSource;
    ConfW.SaveConfig;
  finally
    ConfW.Free;
  end;
end;

constructor TDBExportFile.Create;
begin
  inherited Create;
  FSaveConfig := True;
  FFieldToStringParser := TFieldToStringParser.Create;
end;

destructor TDBExportFile.Destroy;
begin
  FFieldToStringParser.Free;
  inherited Destroy;
end;


{ TFieldMapping }

function TFieldMapping.GetSize: Integer;
begin
  Result := FSize;
end;

procedure TFieldMapping.SetFieldValueKind(const Value: TFieldValueKind);
begin
  FFieldValueKind := Value;
  case Value of
    fvkInt:
      FSize := TAM_INT;
    fvkFloat:
      FSize := TAM_REAL;
    fvkDate:
      FSize := TAM_DATE;
    fvkBoolean:
      FSize := TAM_BOOLEAN;
    fvkMemo:
      FSize := 0;
  end;
end;

procedure TFieldMapping.SetSize(const Value: Integer);
begin
  if (FFieldValueKind in [fvkString, fvkDummy]) then
    begin
      if Value <= 0 then
        raise Exception.Create('Size value must be greater zero for string or dummy fields.');
      if (FSize <> Value) then
        FSize := Value;
    end
end;

{ TStringToFieldParser }

procedure TStringToFieldParser.CutInteger(var AValue: Integer; var ALine: String);
var
  Result : Variant;
begin
  FValue := Copy(ALine, 1, TAM_INT);
  Result := ParseInt;
  if Result = Null then
    AValue := 0
  else
    AValue := ParseInt;
  Delete(ALine, 1, TAM_INT);
end;

procedure TStringToFieldParser.CutDouble(var AValue: Double; var ALine: String);
var
  Result : Variant;
begin
  FValue := Copy(ALine, 1, TAM_REAL);
  Result := ParseFloat;
  if Result = Null then
    AValue := 0
  else
    AValue := ParseFloat;
  Delete(ALine, 1, TAM_REAL);
end;

procedure TStringToFieldParser.CutReal(var AValue: Currency; var ALine: String);
var
  Result : Variant;
begin
  FValue := Copy(ALine, 1, TAM_REAL);
  Result := ParseFloat;
  if Result = Null then
    AValue := 0
  else
    AValue := ParseFloat;
  Delete(ALine, 1, TAM_REAL);
end;

procedure TStringToFieldParser.CutLongReal(var AValue: Currency; var ALine: String);
var
  Result : Variant;
begin
  FValue := Copy(ALine, 1, TAM_REAL);
  Result := ParseLongFloat;
  if Result = Null then
    AValue := 0
  else
    AValue := ParseLongFloat;
  Delete(ALine, 1, TAM_REAL);
end;

procedure TStringToFieldParser.CutDate(var AValue: TDateTime; var ALine: String);
var
  Result : Variant;
begin
  FValue := Copy(ALine, 1, TAM_DATE);
  Result := ParseDate;
  if Result = Null then
    AValue := 0
  else
    AValue := ParseDate;
  Delete(ALine, 1, TAM_DATE);
end;

procedure TStringToFieldParser.CutBoolean(var AValue: Boolean; var ALine: String);
begin
  FValue := Copy(ALine, 1, TAM_BOOLEAN);
  AValue := ParseBoolean;
  Delete(ALine, 1, TAM_BOOLEAN);
end;

procedure TStringToFieldParser.CutMemo(var AValue: String; var ALine: String);
var
  iEndMemo: Integer;
begin
   /// PAREI AQUI !!!
  Delete(ALine, 1, 1);
  iEndMemo := Pos(STR_MEMO_SEP, ALine);
  FValue := Copy(ALine, 1, iEndMemo - 1);
  Delete(ALine, 1, iEndMemo);
  AValue := ParseMemo;

end;


procedure TStringToFieldParser.CutString(var AValue: String; var ALine: String; const ASize: Integer);
begin
  AValue := Trim(Copy(ALine, 1, ASize));
  Delete(ALine, 1, ASize);
end;

function TStringToFieldParser.ParseBoolean: Variant;
begin
  if Trim(FValue) = '' then
    Result := False
  else
    Result := Boolean(Byte(StrToInt(FValue)));
end;

function TStringToFieldParser.ParseDate: Variant;
begin
  if Trim(FValue) = '' then
    Result := NULL
  else
    Result := EncodeDateTime(StrToInt(Copy(FValue,  1, 4)),
                             StrToInt(Copy(FValue,  5, 2)),
                             StrToInt(Copy(FValue,  7, 2)),
                             StrToInt(Copy(FValue,  9, 2)),
                             StrToInt(Copy(FValue, 11, 2)),
                             StrToInt(Copy(FValue, 13, 2)),
                             0
                             );
end;

function TStringToFieldParser.ParseFloat: Variant;
var
  ValorFloat: Currency;
begin
  if Trim(FValue) = '' then
    Result := NULL
  else
    begin
      ValorFloat := Integer(StrToInt64(FValue)) / Power(10, TAM_DEC);
      Result := ValorFloat;
    end;
end;

function TStringToFieldParser.ParseLongFloat: Variant;
var
  ValorFloat: Currency;
begin
  if Trim(FValue) = '' then
    Result := NULL
  else
    begin
      ValorFloat := StrToInt64(FValue) / Power(10, TAM_DEC);
      Result := ValorFloat;
    end;
end;

function TStringToFieldParser.ParseInt: Variant;
begin
  if Trim(FValue) = '' then
    Result := NULL
  else
    Result := Integer(StrToInt64(FValue));
end;

function TStringToFieldParser.ParseMemo: Variant;
var
  sLine, sResult: String;
begin
  if Trim(FValue) = '' then
    Result := ''
  else
    begin
      sResult := '';
      sLine   := FValue;
      while Length(sLine) > 1 do
      begin
        sResult := sResult + Chr(Byte(StrToInt('$' + Copy(sLine, 1, 2))));
        Delete(sLine, 1, 2);
      end;
      Result := sResult;
    end;
end;

{ TCDSImportFile }

function TCDSImportFile.AddMapping(AFieldName: String;
  AFieldValueKind: TFieldValueKind; ASize: Integer): Integer;
var
  FM: TFieldMapping;
begin
  FM := TFieldMapping.Create;
  with FM do
  begin
    Found          := False;
    FieldName      := AFieldName;
    FieldValueKind := AFieldValueKind;
    Size           := ASize;
  end;
  Result := FMappingList.AddObject(AFieldName, FM);
end;

procedure TCDSImportFile.Clear;
var
  FM: TFieldMapping;
begin
  while FMappingList.Count > 0 do
  begin
    FM := TFieldMapping(FMappingList.Objects[0]);
    FM.Free;
    FMappingList.Objects[0] := nil;
    FMappingList.Delete(0);;
  end;
end;

function TCDSImportFile.Count: Integer;
begin
  Result := FMappingList.Count;
end;

constructor TCDSImportFile.Create;
begin
  inherited Create;
  FStringToFieldParser := TStringToFieldParser.Create;
  FCurrentLine := 0;
  FMappingList := TStringList.Create;
  FData        := TStringList.Create;
end;

destructor TCDSImportFile.Destroy;
begin
  Reset;
  FMappingList.Free;
  FData.Clear;
  FStringToFieldParser.Free;
  inherited Destroy;
end;

function TCDSImportFile.GetFieldMaps(Index: Integer): TFieldMapping;
begin
  Result := TFieldMapping(FMappingList.Objects[Index]);
end;

function TCDSImportFile.HasMoreLines: Boolean;
begin
  Result := (FData.Count > 0) and (FCurrentLine < FData.Count);
end;

function TCDSImportFile.MappingByName(AName: String): TFieldMapping;
var
  Posicao: Integer;
begin
  Posicao := FMappingList.IndexOf(AName);
  if Posicao >= 0 then
    Result := TFieldMapping(FMappingList.Objects[Posicao])
  else
    result := nil;
end;

function TCDSImportFile.NextLine: String;
begin
  Result := FData[FCurrentLine];
  Inc(FCurrentLine);
end;

function TCDSImportFile.ReadTableConfig(AININame,
  ATableName: String): Boolean;
var
  Ini: TINIFile;
  stlLinhas: TStringList;
  I: Integer;
  ATipo : Char;
  ASize: string;
begin
  Result := True;
  try
    Reset;
    Ini := TINIFile.Create(AININame);
    try
      stlLinhas := TStringList.Create;
      try
        Ini.ReadSection(ATableName, stlLinhas);
        for I := 0 to stlLinhas.Count - 1 do
        begin
          ASize := Ini.ReadString(ATableName, stlLinhas[I], 'S0');
          ATipo := ASize[1];
          Delete(ASize, 1, 1);

          case ATipo of
            'I': AddMapping(stlLinhas[I], fvkInt);
            'F': AddMapping(stlLinhas[I], fvkFloat);
            'B': AddMapping(stlLinhas[I], fvkBoolean);
            'D': AddMapping(stlLinhas[I], fvkDate);
            'S': AddMapping(stlLinhas[I], fvkString, StrToInt(ASize));
            'Y': AddMapping(stlLinhas[I], fvkDummy, StrToInt(ASize));
            'M': AddMapping(stlLinhas[I], fvkMemo);
          end;

        end;
      finally
        stlLinhas.Free;
      end;

    finally
      Ini.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TCDSImportFile.Reset;
begin
  Clear;
  FCurrentLine := 0;
end;

function TCDSImportFile.SaveAll: Boolean;
begin
  Result := True;
  try
    FData.LoadFromFile(FFileName);

    if FClientDataSet.Active then
       FClientDataSet.Close;

    FClientDataSet.DisableControls;
    try
      FClientDataSet.CreateDataSet;

      if FIndexField <> '' then
        SetCDSIndex(FClientDataSet, FIndexField);

      TestMappings;

      while HasMoreLines() do
        SaveLine(NextLine);

      FClientDataSet.First;
    finally
      FClientDataSet.EnableControls;
    end;
  except
    Result := False;
  end;
end;

procedure TCDSImportFile.TestMappings;
var
  I: Integer;
begin
  for I:= 0 to FMappingList.Count - 1 do
    TFieldMapping(FMappingList.Objects[I]).Found := FClientDataSet.FindField(FMappingList[I]) <> nil;
end;

function TCDSImportFile.SaveLine(ALine: String): Boolean;
var
  I: Integer;
  sLinha: String;
  M: TFieldMapping;
  sMemo: String;
begin
  Result := True;
  try
    sLinha := ALine;
    FClientDataSet.Append;
    try
      for I := 0 to FMappingList.Count - 1 do
      begin
        M := TFieldMapping(FMappingList.Objects[I]);

        if M.Found then
        begin
          FStringToFieldParser.Value := Copy(sLinha, 1, M.Size);
          case M.FFieldValueKind of
            fvkInt:     FClientDataSet.FieldByName(FMappingList[I]).Value := FStringToFieldParser.ParseInt;
            fvkFloat:   FClientDataSet.FieldByName(FMappingList[I]).Value := FStringToFieldParser.ParseFloat;
            fvkDate:    FClientDataSet.FieldByName(FMappingList[I]).Value := FStringToFieldParser.ParseDate;
            fvkBoolean: FClientDataSet.FieldByName(FMappingList[I]).Value := FStringToFieldParser.ParseBoolean;
            fvkString:  FClientDataSet.FieldByName(FMappingList[I]).Value := FStringToFieldParser.Value;
            fvkMemo:
            begin
              FStringToFieldParser.CutMemo(sMemo, sLinha);
              FClientDataSet.FieldByName(FMappingList[I]).Value := sMemo;
            end;
          end;
        end;

        Delete(sLinha, 1, M.Size);
      end;
      FClientDataSet.Post;
    except
      FClientDataSet.Cancel;
      raise;
    end;
  except
    Result := False;
  end;
end;

procedure TCDSImportFile.SetFieldMaps(Index: Integer;
  const Value: TFieldMapping);
begin
  FMappingList.Objects[Index] := Value;
  FMappingList.Strings[Index] := Value.FieldName;
end;


{ TConfigWritter }

function TConfigWritter.SaveConfig: Boolean;
var
  I: Integer;
  AIni: TIniFile;
begin
  Result := True;
  try
    AIni := TIniFile.Create(FConfigFilename);
    try
      if AIni.SectionExists(FTableName) then
        AIni.EraseSection(FTableName);
      for I := 0 to FDataSet.FieldCount - 1 do
        SaveFieldConfig(AIni, FDataSet.Fields[I]);
    finally
      AIni.Free;
    end;
  except
    Result := False;
  end;
end;

function TConfigWritter.SaveFieldConfig(AIni: TIniFile; AField: TField): Boolean;
begin
  Result := True;
  try
    case AField.DataType of
      ftSmallint,
      ftInteger,
      ftWord,
      ftLargeint,
      ftAutoInc:
        AIni.WriteString(FTablename, AField.FieldName, 'I0');
      ftFloat,
      ftCurrency,
      ftBCD:
        AIni.WriteString(FTablename, AField.FieldName, 'F0');
      ftDate,
      ftTime,
      ftDateTime:
        AIni.WriteString(FTablename, AField.FieldName, 'D0');
      ftBoolean:
        AIni.WriteString(FTablename, AField.FieldName, 'B0');
      ftString, ftWideString:
        AIni.WriteString(FTablename, AField.FieldName, Format('S%D', [AField.Size]));
      ftMemo:
        AIni.WriteString(FTablename, AField.FieldName, 'M0');
    end;
  except
    Result := False;
  end;
end;


{ TSaleWritter }

function TSaleWritter.AddCustomer(AIDTipoPessoa, AIDTipoPessoaRoot: Integer;
  AFirstName, ALastName, AEndereco, ACidade, ABairro, AZip, ADocumento,
  ATelefone, AEstado, ATelDDD, ACelDDD, ACelelular, AEmail, AWebSite,
  ACPF, AIdentidate, AOrgEmiss, ACustCard, ACMotorista,
  ANomeJuridico, AInscEstadual, AInscMunicipal, AContato, AOBS: String;
  AJuridico:Boolean; AExpDate, ABirthDate : TDateTime):  String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'CL';

    AValue := AIDTipoPessoa;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDTipoPessoaRoot;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := AJuridico;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);

    AValue := AExpDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);
    AValue := ABirthDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := AFirstName;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := ALastName;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := AEndereco;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 80);
    AValue := ACidade;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 40);
    AValue := ABairro;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 50);
    AValue := AZip;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 12);
    AValue := ADocumento;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := ATelefone;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 40);
    //Novos campos
    AValue := AEstado;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 3);
    AValue := ATelDDD;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 5);
    AValue := ACelDDD;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 5);
    AValue := ACelelular;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 18);
    AValue := AEmail;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 50);
    AValue := AWebSite;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 200);
    AValue := ACPF;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := AIdentidate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := AOrgEmiss;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 50);
    AValue := ACustCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := ACMotorista;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 15);
    AValue := ANomeJuridico;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 50);
    AValue := AInscEstadual;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := AInscMunicipal;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);
    AValue := AContato;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 255);
    AValue := AOBS;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 100);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TSaleWritter.AddHoldItem(AIDCustomer, AIDHold, AIDModel, AIDStore, AIDDepartment : Integer;
  AQty: Double; ADiscount, ASale, ACost: Currency; AIDUser,
  AIDCommis: Integer; AMovDate, ADate: TDateTime; AResetDisc,
  AManager: Boolean; AIDDescriptionPrice, AIDVendorPrice: Integer;
  ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentNumber: Integer; ATotParcial : String): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'AI';

    AValue := AIDCustomer;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDHold;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDModel;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDStore;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AQty;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCommis;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDDepartment;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ADiscount;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ASale;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ACost;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := AMovDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);
    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := AResetDisc;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);
    AValue := AManager;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);

    AValue := AIDDescriptionPrice;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := AIDVendorPrice;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ASuggPrice;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ADocumentNumber;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    AValue := AIDDocumentNumber;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    //PAF
    AValue := ATotParcial;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 10);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TSaleWritter.AddPayment(AIDPreSale, AIDStore, AIDUser,
  AIDCustomer, AIDMeioPag, AIDCashRegMov: Integer; APreSaleDate,
  AExpireDate: TDateTime; ANumParcela, AAutotize: String;
  ATotalInvoice: Currency; ACheckNumber, ACustomerDocument, ACustomerName,
  ACustomerPhone: String; AIDBankCheck: Integer; AOBS: String;
  APaymentPlace: Integer; AIsPreDatado: Boolean; APayType: Integer): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'AP';

    AValue := AIDPreSale;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDStore;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCustomer;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDMeioPag;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCashRegMov;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDBankCheck;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := APaymentPlace;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := APayType;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := APreSaleDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);
    AValue := AExpireDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := ATotalInvoice;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := AIsPreDatado;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);


    AValue := ANumParcela;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := AAutotize;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 50);
    AValue := ACheckNumber;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := ACustomerDocument;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := ACustomerName;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 80);
    AValue := ACustomerPhone;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := AOBS;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 255);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;


function TSaleWritter.AddPettyCash(AIDCashRegMov, AIDUser: Integer;
                                   ACash : Currency;
                                   ADate : TDateTime;
                                   AOBS: String;
                                   ACOO, AGNF : Integer): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := True;
  try
    sLinha := 'PC';

    AValue := AIDCashRegMov;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ACash;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := Copy(AOBS, 1, 255);
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 255);

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AGNF;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    Result := False;
  end;
end;

function TSaleWritter.SaveObs(AOBS: String): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'OB';

    AValue := AOBS;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 255);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TSaleWritter.AbortSale(ACOO: String): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'AS';

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 8);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;


function TSaleWritter.CancelItem(Position: Integer): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'CI';

    AValue := Position;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;


function TSaleWritter.CancelFiscalSale(ACOO: String;
  IDUser: Integer): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := True;
  try
    sLinha := 'CS';

    AValue := IDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 8);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    Result := False;
  end;
end;

function TSaleWritter.CloseCashRegister(AIDCashRegMov, AIDUser, A100, A50,
  A20, A10, A05, A02, A01, A0100, A050, A025, A010, A005, A001: Integer;
  ATotalCount, ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
  ATotalOther: Currency; AEnvolop: String; ADate: TDateTime;
  ATotalDebit: Currency; AReducaoZ: TRegReducaoZ): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := True;
  try
    sLinha := 'FC';

    AValue := AIDCashRegMov;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A50;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A20;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A10;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A05;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A02;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A01;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A0100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A050;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A025;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A010;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A005;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A001;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ATotalCount;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCash;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalPreCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCheck;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalOther;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := AEnvolop;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    AValue := ATotalDebit;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;

    if AReducaoZ.ANumeroSerie <> '' then
    begin
      sLinha := GetLinhaReducaoZ(AReducaoZ);
      FSaleLines.Add(sLinha);
      sLinha := GetLinhaTotParcial(AReducaoZ);
      FSaleLines.Add(sLinha);
      WriteSaleToFile;
    end;

    CloseSaleFile;
  except
    Result := False;
  end;
end;

procedure TSaleWritter.CloseSaleFile;
begin
  if FFileOpened then
  begin
    Flush(FLogicalFile);
    CloseFile(FLogicalFile);
    FFileOpened          := False;
    FFileName            := '';
  end;
  {$I-}
  CloseFile(FHiddenFile);
  {$I+}
end;

constructor TSaleWritter.Create(iDays, iFileSizeMB : Integer);
begin
  inherited Create;
  FFileOpened          := False;
  FFieldToStringParser := TFieldToStringParser.Create;
  FSaleLines           := TStringList.Create;
  DeleteHiddenFileLog(iDays, iFileSizeMB);
  OpenHiddenFile;
end;

procedure TSaleWritter.DeleteHiddenFileLog(iDays, iFileSizeMB : Integer);
var
  PWinDir: PChar;
  sWinDir: String;
  sArquivo : String;
  bDeleteLog : Boolean;
  slHiddenFileLog : TStringList;
  dDeleteDate : TDateTime;
begin

  try

    PWinDir := PChar(StringOfChar(#0, MAX_PATH + 1));
    //FillChar(PWinDir, MAX_PATH, 0);
    GetWindowsDirectory(pWinDir, MAX_PATH);
    sWindir := StrPas(pWinDir);

    sArquivo := sWindir + SUB_HIDDEN_NAME;

    if not DirectoryExists(ExtractFilePath(sArquivo)) then
      ForceDirectories((ExtractFilePath(sArquivo)));

    AssignFile(FHiddenFile, sArquivo);
    Reset(FHiddenFile);
    try
      bDeleteLog := ((FileSize(FHiddenFile)/(1024)/(1024)) >= iFileSizeMB);
    finally
      {$I-}
      CloseFile(FHiddenFile);
      {$I+}
      end;

    if bDeleteLog then
    try
      slHiddenFileLog := TStringList.Create;

      slHiddenFileLog.LoadFromFile(sArquivo);
      dDeleteDate := (Now - iDays);

      bDeleteLog := False;

      while EncodeDate(StrToInt(Copy(slHiddenFileLog.Strings[0],1,4)),
                       StrToInt(Copy(slHiddenFileLog.Strings[0],6,2)),
                       StrToInt(Copy(slHiddenFileLog.Strings[0],9,2))) <= dDeleteDate do
      begin
        slHiddenFileLog.Delete(0);
        bDeleteLog := True;
      end;

      if bDeleteLog then
        slHiddenFileLog.SaveToFile(sArquivo);

    finally
      FreeAndNil(slHiddenFileLog);
    end;
    
  except
    end;

end;


function TSaleWritter.CreateHold(ADeliverType: Integer;
            AIsLayaway: Boolean; AIDStore: Integer;
            AFName, ALName, AZip: String;
            AIDTourGroup: Integer; APreSaleDate: TDateTime;
            AIDCustomer, AIDMedia, AIDOtherComm: Integer;
            AInvObs, ASaleCode, ACOO:String; ATaxExempt: Boolean;
            AIDPreSale: Integer; APuppyTracker: Boolean;
            AECFSerial, ACCF : String):  String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'AV';

    // Campos Integer
    AValue := AIDPreSale;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := FIDCashreg;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := ADeliverType;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDStore;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDTourGroup;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCustomer;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDMedia;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDOtherComm;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    // Campo Boolean
    AValue := AIsLayaway;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);

    AValue := ATaxExempt;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);

    AValue := APuppyTracker;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldBoolean(AValue, False);
    
    // Campos Data
    AValue := APreSaleDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    // Campos String
    AValue := AFName;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := ALName;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := AZip;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
    AValue := AInvObs;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 150);

    AValue := ASaleCode;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 8);

    AValue := AECFSerial;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    //PAF
    AValue := ACCF;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 10);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

procedure TSaleWritter.OpenHiddenFile;
var
  PWinDir: PChar;
  sWinDir: String;
  sArquivo : String;
begin
  PWinDir := PChar(StringOfChar(#0, MAX_PATH + 1));
  //FillChar(PWinDir, MAX_PATH, 0);
  GetWindowsDirectory(pWinDir, MAX_PATH);
  sWindir := StrPas(pWinDir);

  sArquivo := sWindir + SUB_HIDDEN_NAME;

  if not DirectoryExists(ExtractFilePath(sArquivo)) then
    ForceDirectories((ExtractFilePath(sArquivo)));

  AssignFile(FHiddenFile, sArquivo);
  {$I-}
  if not FileExists(sArquivo) then
    ReWrite(FHiddenFile);

  Append(FHiddenFile);
  {$I+}
end;

function TSaleWritter.CreateNewFile: Boolean;
begin
  try
    {$I-}
    if FFileOpened then
    begin
      CloseFile(FLogicalFile);
      FFileOpened := False;
    end;
    {$I+}

    if not DirectoryExists(FLocalWorkingDir) then
      ForceDirectories(FLocalWorkingDir);

    FFilename := 'PDV' + IntToStr(IDCashReg) + FormatDateTime('-YYYYMMDD-HHNNSS', NOW) + '.ven';
    AssignFile(FLogicalFile, FLocalWorkingDir + FFilename);

    {$I-}
    Rewrite(FLogicalFile);
    Result := IOResult = 0;
    {$I+}
  except
    Result := False;
  end;

  FFileOpened := Result;
end;

destructor TSaleWritter.Destroy;
begin
  CloseSaleFile;
  FFieldToStringParser.Free;
  FSaleLines.Free;
  inherited Destroy;
end;


function TSaleWritter.OpenCashRegister(A100, A50, A20, A10, A05, A02, A01,
  A0100, A050, A025, A010, A005, A001, AIDCashReg, AIDUser: Integer;
  ATotalCount, ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
  ATotalOther: Currency; ADate: TDateTime; ATotalDebit: Currency;
  ACOO, AGNF : Integer; AReducaoZ: TRegReducaoZ): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := True;
  try
    CreateNewFile;

    if AReducaoZ.ANumeroSerie <> '' then
    begin
      sLinha := GetLinhaReducaoZ(AReducaoZ);
      FSaleLines.Add(sLinha);
      sLinha := GetLinhaTotParcial(AReducaoZ);
      FSaleLines.Add(sLinha);
    end;

    sLinha := 'AC';

    AValue := A100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A50;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A20;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A10;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A05;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A02;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A01;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A0100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A050;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A025;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A010;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A005;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A001;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCashReg;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ATotalCount;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCash;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalPreCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCheck;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalOther;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := ATotalDebit;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AGNF;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    Result := False;
  end;
end;

function TSaleWritter.OpenFile(AFileName: String): Boolean;
{var
  sLinha: String;}
begin
  try
    FSaleLines.Clear;
    Result := FileExists(FLocalWorkingDir + AFileName);
    if not Result then
      Exit;

    FFileName := AFileName;
    AssignFile(FLogicalFile, FLocalWorkingDir + AFileName);

    (*

    // Antigo procedimento para editar o arquivo. Substituido pelo append
    // mas ainda está em teste
    
    {$I-}
    Reset(FLogicalFile);
    while not EOF(FLogicalFile) do
    begin
      Readln(FLogicalFile, sLinha);
      FSaleLines.Add(sLinha);
    end;
    CloseFile(FLogicalFile);

    Rewrite(FLogicalFile);
    {$I+}
    *)

    {$I-}
    Reset(FLogicalFile);
    Append(FLogicalFile);
    {$I+}

    FFileOpened := IOResult = 0;
    Result := FFileOpened;

    if FFileOpened then
      Result := WriteSaleToFile;
  except
    Result := False;
  end;
end;

function TSaleWritter.PreSalePay(AIDPreSale, AIDTourGroup, AIDOtherCommis,
  AIDCashRegMov, AIDStore: Integer; ADate, APayDate: TDateTime;
  ACashReceived, ASaleDiscount: Currency): String;
var
  sLinha: String;
begin
  Result := '';
  try
    sLinha := GetSaleCloseLine(AIDPreSale, AIDTourGroup, AIDOtherCommis,
                               AIDCashRegMov, AIDStore, ADate, APayDate,
                               ACashReceived, ASaleDiscount);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TSaleWritter.WithdrawCashRegister(AIDCashRegMov, AIDUser, A100,
  A50, A20, A10, A05, A02, A01, A0100, A050, A025, A010, A005,
  A001: Integer; ATotalCash, ATotalCard, ATotalPreCard, ATotalCheck,
  ATotalOther: Currency; AEnvolop: String; ADate: TDateTime;
  AOBS: String; ATotalDebit: Currency; AIDReason : Integer;
  ACOO, AGNF: Integer): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := True;
  try
    sLinha := 'WC';

    AValue := AIDCashRegMov;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A50;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A20;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A10;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A05;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A02;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A01;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A0100;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A050;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A025;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A010;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A005;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := A001;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);


    AValue := ATotalCash;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalPreCard;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalCheck;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ATotalOther;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := AEnvolop;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    AValue := Copy(AOBS, 1, 255);
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 255);

    AValue := ATotalDebit;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := AIDReason;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ACOO;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AGNF;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    
    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    Result := False;
  end;
end;

function TSaleWritter.WriteSaleToFile: Boolean;
var
  I: Integer;
  lstTmp: TStringList;
  sArquivoLocal, sArquivoRemoto: String;
begin
  Result := True;

  {$I-}
  for I := 0 to FSaleLines.Count - 1 do
  begin
    Writeln(FHiddenFile,  FormatDateTime('YYYY-MM-DD - ', Date) +  FSaleLines[I]);
    if IOResult <> 0 then
      Break;

    Flush(FHiddenFile);
    if IOResult <> 0 then
      Break;
  end;
  {$I+}



  {$I+}
  for I := 0 to FSaleLines.Count - 1 do
  begin
    Writeln(FLogicalFile,  FSaleLines[I]);
    Result := IOResult = 0;

    if Result then
    begin
      Flush(FLogicalFile);
      Result := Result and (IOResult = 0);
    end;

    if not Result then
      Break;
  end;
  {$I+}

  FSaleLines.Clear;

  {
  //Removido para a thread

  if Result and (FRemoteWorkingDir <> '') then
    try
      sArquivoLocal  := FLocalWorkingDir + FFilename;
      sArquivoRemoto := FRemoteWorkingDir + IntToStr(FIDCashReg) + '\' + FFilename;

      if not DirectoryExists(ExtractFilePath(sArquivoRemoto)) then
        ForceDirectories(ExtractFilePath(sArquivoRemoto));

      lstTmp := TStringList.Create;
      try
        LoadListNoLock(lstTmp, sArquivoLocal);
        if FileExists(sArquivoRemoto) then
          DeleteFile(PChar(sArquivoRemoto));
        lstTmp.SaveToFile(sArquivoRemoto);
      finally
        lstTmp.Free;
      end;
    except
    end;}
end;

function TSaleWritter.AddRemovedItem(AIDCashReg, AIDModel, AIDStore, AIDDepartment: Integer;
  AQty: Double; ADiscount, ASale, ACost: Currency; AIDUser, AIDUserAuto,
  AIDCommis: Integer; AMovDate: TDateTime; ASaleCode : String): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'RI-';

    AValue := AIDCashReg;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDModel;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDStore;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AQty;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := AIDUser;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDUserAuto;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCommis;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDDepartment;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ADiscount;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ASale;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := ACost;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := AMovDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := ASaleCode;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 20);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TSaleWritter.AddSerialNumber(APosition: Integer;
  ASerialNumber, AIdentificationNumber: String): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := false;
  try
    sLinha := 'SN-';

    AValue := APosition;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ASerialNumber;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);

    AValue := AIdentificationNumber;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldString(AValue, False, 30);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;
  except
    on E: Exception do
      Result := False;
  end;
end;


function TSaleWritter.GetLinhaReducaoZ(AReducaoZ: TRegReducaoZ): String;
var
  i: Integer;
  AValue: Variant;
begin
  Result := 'RZ';

  AValue := AReducaoZ.AMovDate;
  Result := Result + FFieldToStringParser.PrepareFieldDate(AValue, False);
  AValue := AReducaoZ.ANumeroSerie;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
  AValue := AReducaoZ.ANumeroLoja;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ANumeroECF;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ANumReducaoZ;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ACOOInicial;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ACOOFinal;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ANumCancelamentos;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.AValCancelamentos;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.AValDescontos;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.AGTInicial;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.AGTFinal;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.ASubstituicaoTrib;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.AIsencao;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  AValue := AReducaoZ.ANaoTributavel;
  Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);

  // PAF-ECF
  AValue := AReducaoZ.ATipoECF;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
  AValue := AReducaoZ.AMarcaECF;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
  AValue := AReducaoZ.AModeloECF;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 20);
  AValue := AReducaoZ.AVersaoSBECF;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 10);
  AValue := AReducaoZ.ADataInstalacaoSBECF;
  Result := Result + FFieldToStringParser.PrepareFieldDate(AValue, False);
  AValue := AReducaoZ.AMFAdicional;
  Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 1);
  AValue := AReducaoZ.AContadorReducaoZ;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.AContadorOrdemOperacao;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.AContadorReinicioOperacao;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.ANumeroUsuarioECF;
  Result := Result + FFieldToStringParser.PrepareFieldInt(AValue, False);
  AValue := AReducaoZ.AIncideISSQN;
  Result := Result + FFieldToStringParser.PrepareFieldBoolean(AValue, False);
  AValue := AReducaoZ.ADataEmissao;
  Result := Result + FFieldToStringParser.PrepareFieldDate(AValue, False);

  for i := 0 to Pred(Length(AReducaoZ.AAliquota)) do
  begin
    AValue := AReducaoZ.AAliquota[i];
    Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := AReducaoZ.ABaseCalculo[i];
    Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
    AValue := AReducaoZ.AValImposto[i];
    Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  end;
end;

function TSaleWritter.GetSaleCloseLine(AIDPreSale, AIDTourGroup,
  AIDOtherCommis, AIDCashRegMov, AIDStore: Integer; ADate,
  APayDate: TDateTime; ACashReceived, ASaleDiscount: Currency): String;
var
  sLinha: String;
  AValue: Variant;
begin
  Result := '';
  try
    sLinha := 'FV';

    AValue := AIDPreSale;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDTourGroup;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDOtherCommis;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDCashRegMov;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AIDStore;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ADate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);
    AValue := APayDate;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    AValue := ACashReceived;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);

    AValue := ASaleDiscount;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldReal(AValue, False);
  finally
    Result := sLinha;
  end;
end;

function TSaleWritter.AddVinculadoInfo(ACOOVinc, AGNFVinc, ACDC: Integer;
  ADataHora: TDateTime): Boolean;
var
  sLinha: String;
  AValue: Variant;
begin

  try
    sLinha := 'VI';

    AValue := ACOOVinc;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := AGNFVinc;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);
    AValue := ACDC;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldInt(AValue, False);

    AValue := ADataHora;
    sLinha := sLinha + FFieldToStringParser.PrepareFieldDate(AValue, False);

    FSaleLines.Add(sLinha);
    WriteSaleToFile;

    Result := True;
  except
    on E: Exception do
      Result := False;
  end;
end;

function TSaleWritter.GetLinhaTotParcial(AReducaoZ: TRegReducaoZ): String;
var
  i: Integer;
  AValue: Variant;
begin
  Result := 'TP';

  for i := 0 to Pred(Length(AReducaoZ.ATribReducaoZList)) do
  begin
    AValue := AReducaoZ.ATribReducaoZList[i].Codigo;
    Result := Result + FFieldToStringParser.PrepareFieldString(AValue, False, 10);
    AValue := AReducaoZ.ATribReducaoZList[i].ValorAcumulado;
    Result := Result + FFieldToStringParser.PrepareFieldReal(AValue, False);
  end;
end;

{ TFieldToStringParser }

function TFieldToStringParser.PrepareFieldInt(AValue: Variant; AIsNull: Boolean): String;
var
  ValorInt: Integer;
  Sinal: Char;
begin
  if AIsNull then
    Result := StringOfChar(CHR_SPACE, TAM_INT)
  else
    begin
      ValorInt := Trunc(ABS(AValue));
      Sinal    := GetSignal(AValue);
      Result   := Sinal + SizedStr(IntToStr(ValorInt), TAM_INT - 1, CHR_ZERO, sspLeft);
    end;
end;

function TFieldToStringParser.PrepareFieldReal(AValue: Variant; AIsNull: Boolean): String;
var
  ValorInt: Int64;
  Sinal: Char;
begin
  if AIsNull then
    Result := StringOfChar(CHR_SPACE, TAM_REAL)
  else
    begin
      ValorInt := Int64(Trunc(ABS(AValue * Power(10, TAM_DEC))));
      Sinal    := GetSignal(AValue);
      Result   := Sinal + SizedStr(IntToStr(ValorInt), TAM_REAL - 1, CHR_ZERO, sspLeft);
    end;
end;

function TFieldToStringParser.PrepareFieldDate(AValue: Variant; AIsNull: Boolean): String;
var
  ValorDate: TDateTime;
begin
  if AIsNull then
    Result := StringOfChar(CHR_SPACE, TAM_DATE)
  else
    begin
      ValorDate := AValue;
      Result    := FormatDateTime(FMT_DATE, ValorDate);
    end;
end;

function TFieldToStringParser.PrepareFieldBoolean(AValue: Variant; AIsNull: Boolean): String;
var
  ValorBoolean: Boolean;
begin
  if AIsNull then
    ValorBoolean := False
  else
    ValorBoolean := AValue;
  Result := IntToStr(Byte(ValorBoolean));
end;

function TFieldToStringParser.PrepareFieldString(AValue: String; AIsNull: Boolean; ASize: Integer): String;
var
  ValorString: String;
begin
  if AIsNull then
    Result := StringOfChar(CHR_SPACE, ASize)
  else
    begin
      ValorString := StringReplace(AValue, STR_CRLF, CHR_SPACE, [rfReplaceAll]);
      ValorString := Trim(ValorString);
      Result := SizedStr(ValorString, ASize, CHR_SPACE, sspRight);
    end;
end;

function TFieldToStringParser.GetSignal(Value: Variant): Char;
begin
  if Value >= 0 then
    Result := '0'
  else
    Result := '-';
end;

function TFieldToStringParser.PrepareFieldMemo(AValue: Variant;
  AIsNull: Boolean): String;
var
  strTmp: String;
  I: Integer;
begin
  Result := STR_MEMO_SEP;
  if not AIsNull then
  begin
    strTmp := VarToStr(AValue);

    for I := 1 to Length(strTmp) do
      Result := Result + IntToHex(Ord(strTmp[I]), 2);
  end;
  Result := Result + STR_MEMO_SEP;
end;

{ TSaleLineParser }

constructor TSaleLineParser.Create;
begin
  inherited Create;
  FStringToFieldParser := TStringToFieldParser.Create;
end;

destructor TSaleLineParser.Destroy;
begin
  FStringToFieldParser.Free;
  inherited;
end;

procedure TSaleLineParser.GetOpenCash(Const ALine: String; var ROC: TRegOpenCash);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(ROC.A100, strTmp);
    CutInteger(ROC.A50, strTmp);
    CutInteger(ROC.A20, strTmp);
    CutInteger(ROC.A10, strTmp);
    CutInteger(ROC.A05, strTmp);
    CutInteger(ROC.A02, strTmp);
    CutInteger(ROC.A01, strTmp);
    CutInteger(ROC.A0100, strTmp);
    CutInteger(ROC.A050, strTmp);
    CutInteger(ROC.A025, strTmp);
    CutInteger(ROC.A010, strTmp);
    CutInteger(ROC.A005, strTmp);
    CutInteger(ROC.A001, strTmp);
    CutInteger(ROC.AIDCashReg, strTmp);
    CutInteger(ROC.AIDUser, strTmp);

    CutReal(ROC.ATotalCount, strTmp);
    CutReal(ROC.ATotalCash, strTmp);
    CutReal(ROC.ATotalCard, strTmp);
    CutReal(ROC.ATotalPreCard, strTmp);
    CutReal(ROC.ATotalCheck, strTmp);
    CutReal(ROC.ATotalOther, strTmp);

    CutDate(ROC.ADate, strTmp);

    CutReal(ROC.ATotalDebit, strTmp);

    CutInteger(ROC.ACOO, strTmp);
    CutInteger(ROC.AGNF, strTmp);
  end;

end;


procedure TSaleLineParser.GetOpenSale(const ALine: String; var ROS: TRegOpenSale);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(ROS.AIDPreSale, strTmp);
    CutInteger(ROS.AIDCashreg, strTmp); // Só para limpar a String
    CutInteger(ROS.ADeliverType, strTmp);
    CutInteger(ROS.AIDStore, strTmp);
    CutInteger(ROS.AIDTourGroup, strTmp);
    CutInteger(ROS.AIDCustomer, strTmp);
    CutInteger(ROS.AIDMedia, strTmp);
    CutInteger(ROS.AIDOtherComm, strTmp);

    CutBoolean(ROS.AIsLayaway, strTmp);
    CutBoolean(ROS.ATaxExempt, strTmp);
    CutBoolean(ROS.APuppyTracker, strTmp);

    CutDate(ROS.APreSaleDate, strTmp);

    CutString(ROS.AFName, strTmp, 20);
    CutString(ROS.ALName, strTmp, 20);
    CutString(ROS.AZip, strTmp, 20);
    CutString(ROS.AInvObs, strTmp, 150);

    CutString(ROS.ASaleCode, strTmp, 20);
    CutString(ROS.ACOO, strTmp, 8);
    CutString(ROS.ASerialECF, strTmp, 20);
    CutString(ROS.ACCF, strTmp, 10);
  end;

end;

procedure TSaleLineParser.GetAddCustomer(const ALine: String; var RAC: TRegAddCustomer);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RAC.AIDTipoPessoa, strTmp);
    CutInteger(RAC.AIDTipoPessoaRoot, strTmp);

    CutBoolean(RAC.AJuridico, strTmp);

    CutDate(RAC.AExpDate, strTmp);
    CutDate(RAC.ABirthDate, strTmp);

    CutString(RAC.AFirstName, strTmp, 30);
    CutString(RAC.ALastName, strTmp, 30);
    CutString(RAC.AEndereco, strTmp, 80);
    CutString(RAC.ACidade, strTmp, 40);
    CutString(RAC.ABairro, strTmp, 50);
    CutString(RAC.AZip, strTmp, 12);
    CutString(RAC.ADocumento, strTmp, 30);
    CutString(RAC.ATelefone, strTmp, 40);
    CutString(RAC.AEstado, strTmp, 3);
    CutString(RAC.ATelDDD, strTmp, 5);
    CutString(RAC.ACelDDD, strTmp, 5);
    CutString(RAC.ACelelular, strTmp, 18);
    CutString(RAC.AEmail, strTmp, 50);
    CutString(RAC.AWebSite, strTmp, 200);
    CutString(RAC.ACPF, strTmp, 30);
    CutString(RAC.AIdentidate, strTmp, 30);
    CutString(RAC.AOrgEmiss, strTmp, 50);
    CutString(RAC.ACustCard, strTmp, 20);
    CutString(RAC.ACMotorista, strTmp, 15);
    CutString(RAC.ANomeJuridico, strTmp, 50);
    CutString(RAC.AInscEstadual, strTmp, 30);
    CutString(RAC.AInscMunicipal, strTmp, 30);
    CutString(RAC.AContato, strTmp, 255);
    CutString(RAC.AOBS, strTmp, 100);
  end;

end;

procedure TSaleLineParser.GetRemovedItem(const ALine: String;
  var RRI: TRegRemovedItem);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 3);

  with FStringToFieldParser do
  begin
    CutInteger(RRI.AIDCashReg, strTmp);
    CutInteger(RRI.AIDModel, strTmp);
    CutInteger(RRI.AIDStore, strTmp);
    CutDouble(RRI.AQty, strTmp);
    CutInteger(RRI.AIDUser, strTmp);
    CutInteger(RRI.AIDUserAuto, strTmp);
    CutInteger(RRI.AIDCommis, strTmp);
    CutInteger(RRI.AIDDepartment, strTmp);

    CutReal(RRI.ADiscount, strTmp);
    CutReal(RRI.ASale, strTmp);
    CutReal(RRI.ACost, strTmp);

    CutDate(RRI.AMovDate, strTmp);

    CutString(RRI.ASaleCode, strTmp, 20);
  end;
end;

procedure TSaleLineParser.GetItemCanceled(const ALine: String; var Position: Integer);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);
  with FStringToFieldParser do
    CutInteger(Position, strTmp);
end;

procedure TSaleLineParser.GetAddItem(const ALine: String; var RAI: TRegAddItem);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RAI.AIDCustomer, strTmp);
    CutInteger(RAI.AIDHold, strTmp);
    CutInteger(RAI.AIDModel, strTmp);
    CutInteger(RAI.AIDStore, strTmp);
    CutDouble(RAI.AQty, strTmp);
    CutInteger(RAI.AIDUser, strTmp);
    CutInteger(RAI.AIDCommis, strTmp);
    CutInteger(RAI.AIDDepartment, strTmp);

    CutReal(RAI.ADiscount, strTmp);
    CutReal(RAI.ASale, strTmp);
    CutReal(RAI.ACost, strTmp);

    CutDate(RAI.AMovDate, strTmp);
    CutDate(RAI.ADate, strTmp);

    CutBoolean(RAI.AResetDisc, strTmp);
    CutBoolean(RAI.AManager, strTmp);

    CutInteger(RAI.AIDDescriptionPrice, strTmp);
    CutInteger(RAI.AIDVendorPrice, strTmp);
    CutReal(RAI.ASuggPrice, strTmp);

    CutString(RAI.ADocumentNumber, strTmp, 20);
    CutInteger(RAI.AIDDocumentType, strTmp);

    CutString(RAI.ATotParcial, strTmp, 10);
  end;
end;

procedure TSaleLineParser.GetAddPayment(const ALine: String; var RAP: TRegAddPayment);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RAP.AIDPreSale, strTmp);
    CutInteger(RAP.AIDStore, strTmp);
    CutInteger(RAP.AIDUser, strTmp);
    CutInteger(RAP.AIDCustomer, strTmp);
    CutInteger(RAP.AIDMeioPag, strTmp);
    CutInteger(RAP.AIDCashRegMov, strTmp);
    CutInteger(RAP.AIDBankCheck, strTmp);
    CutInteger(RAP.APaymentPlace, strTmp);
    CutInteger(RAP.APayType, strTmp);

    CutDate(RAP.APreSaleDate, strTmp);
    CutDate(RAP.AExpireDate, strTmp);

    CutReal(RAP.ATotalInvoice, strTmp);

    CutBoolean(RAP.AIsPreDatado, strTmp);

    CutString(RAP.ANumParcela, strTmp, 20);
    CutString(RAP.AAutotize, strTmp, 50);
    CutString(RAP.ACheckNumber, strTmp, 20);
    CutString(RAP.ACustomerDocument, strTmp, 20);
    CutString(RAP.ACustomerName, strTmp, 80);
    CutString(RAP.ACustomerPhone, strTmp, 20);
    CutString(RAP.AOBS, strTmp, 255);
  end;
end;


procedure TSaleLineParser.GetAddPC(const ALine: String; var RAPC: TRegAddPC);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RAPC.AIDCashRegMov, strTmp);
    CutInteger(RAPC.AIDUser, strTmp);

    CutReal(RAPC.ACash, strTmp);

    CutDate(RAPC.ADate, strTmp);

    CutString(RAPC.AOBS, strTmp, 255);

    CutInteger(RAPC.ACOO, strTmp);
    CutInteger(RAPC.AGNF, strTmp);
  end;
end;


procedure TSaleLineParser.GetAddWC(const Aline: String; var RAWC: TRegAddWC);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RAWC.AIDCashRegMov, strTmp);
    CutInteger(RAWC.AIDUser, strTmp);
    CutInteger(RAWC.A100, strTmp);
    CutInteger(RAWC.A50, strTmp);
    CutInteger(RAWC.A20, strTmp);
    CutInteger(RAWC.A10, strTmp);
    CutInteger(RAWC.A05, strTmp);
    CutInteger(RAWC.A02, strTmp);
    CutInteger(RAWC.A01, strTmp);
    CutInteger(RAWC.A0100, strTmp);
    CutInteger(RAWC.A050, strTmp);
    CutInteger(RAWC.A025, strTmp);
    CutInteger(RAWC.A010, strTmp);
    CutInteger(RAWC.A005, strTmp);
    CutInteger(RAWC.A001, strTmp);

    CutReal(RAWC.ATotalCash, strTmp);
    CutReal(RAWC.ATotalCard, strTmp);
    CutReal(RAWC.ATotalPreCard, strTmp);
    CutReal(RAWC.ATotalCheck, strTmp);
    CutReal(RAWC.ATotalOther, strTmp);

    CutDate(RAWC.ADate, strTmp);

    CutString(RAWC.AEnvolop, strTmp, 20);

    CutString(RAWC.AOBS, strTmp, 255);

    CutReal(RAWC.ATotalDebit, strTmp);

    CutInteger(RAWC.AIDReason, strTmp);

    CutInteger(RAWC.ACOO, strTmp);
    CutInteger(RAWC.AGNF, strTmp);
  end;
end;

procedure TSaleLineParser.GetCloseSale(const ALine: String; var RCS: TRegCloseSale);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RCS.AIDPreSale, strTmp);
    CutInteger(RCS.AIDTourGroup, strTmp);
    CutInteger(RCS.AIDOtherCommis, strTmp);
    CutInteger(RCS.AIDCashRegMov, strTmp);
    CutInteger(RCS.AIDStore, strTmp);

    CutDate(RCS.ADate, strTmp);
    CutDate(RCS.APayDate, strTmp);

    CutReal(RCS.ACashReceived, strTmp);
    CutReal(RCS.ASaleDiscount, strTmp);
  end;
end;

procedure TSaleLineParser.GetCancelSale(const ALine: String;
  var RCS: TRegCancelSale);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RCS.AIDUser, strTmp);
    CutString(RCS.ACOO, strTmp, 8);
  end;
end;

procedure TSaleLineParser.GetCloseCash(ALine: String; var RCC: TRegCloseCash);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RCC.AIDCashRegMov, strTmp);
    CutInteger(RCC.AIDUser, strTmp);
    CutInteger(RCC.A100, strTmp);
    CutInteger(RCC.A50, strTmp);
    CutInteger(RCC.A20, strTmp);
    CutInteger(RCC.A10, strTmp);
    CutInteger(RCC.A05, strTmp);
    CutInteger(RCC.A02, strTmp);
    CutInteger(RCC.A01, strTmp);
    CutInteger(RCC.A0100, strTmp);
    CutInteger(RCC.A050, strTmp);
    CutInteger(RCC.A025, strTmp);
    CutInteger(RCC.A010, strTmp);
    CutInteger(RCC.A005, strTmp);
    CutInteger(RCC.A001, strTmp);

    CutReal(RCC.ATotalCount, strTmp);
    CutReal(RCC.ATotalCash, strTmp);
    CutReal(RCC.ATotalCard, strTmp);
    CutReal(RCC.ATotalPreCard, strTmp);
    CutReal(RCC.ATotalCheck, strTmp);
    CutReal(RCC.ATotalOther, strTmp);

    CutDate(RCC.ADate, strTmp);

    CutString(RCC.AEnvolop, strTmp, 20);

    CutReal(RCC.ATotalDebit, strTmp);
  end;
end;

function TSaleLineParser.LineType(ALine: String) : TSaleLineType;
var
  strTmp: String;
begin
  // É feio mas não tem outro jeito :-/

  strTmp := Copy(ALine, 1, 2);
  if strTmp = 'AC' then
    Result := sltOpenCash
  else
    if strTmp = 'AV' then
      Result := sltOpenSale
    else
      if strTmp = 'AI' then
        Result := sltAddItem
      else
        if strTmp = 'AP' then
          Result := sltAddPayment
        else
          if strTmp = 'FV' then
            Result := sltCloseSale
          else
            if strTmp = 'FC' then
              Result := sltCloseCash
            else
              if strTmp = 'CL' then
                Result := sltAddCustomer
              else
                if strTmp = 'PC' then
                  Result := sltPC
                else
                  if strTmp = 'WC' then
                    Result := sltWC
                  else
                    if strTmp = 'CS' then
                      Result := sltCancelSale
                    else
                      if strTmp = 'RI' then
                        Result := sltRemovedItem
                      else
                        if strTmp = 'RZ' then
                          Result := sltReducaoZ
                        else
                          if strTmp = 'AS' then
                            Result := sltAbortSale
                          else
                            if strTmp = 'CI' then
                              Result := sltCancelItem
                            else
                              if strTmp = 'SN' then
                                 Result := sltAddSerialNumber
                              else
                                if strTmp = 'OB' then
                                   Result := sltOBS
                                else
                                  if strTmp = 'VI' then
                                    Result := sltCupomVinculado
                                  else
                                    if strTmp = 'TP' then
                                      Result := sltTotParcial
                                    else
                                      Result := sltUnknow;

end;

procedure SetCDSIndex(AClientDataSet: TClientDataSet; AIndexField: String);
var
  sInidice: string;
  stlIndexes: TStringList;
  I: Integer;
begin
  stlIndexes := TStringList.Create;
  try
    if not AClientDataSet.Active then
      AClientDataSet.Open;
    AClientDataSet.IndexName := '';
    AClientDataSet.GetIndexNames(stlIndexes);
    for I := 0 to stlIndexes.Count - 1 do
      if (stlIndexes[I] <> 'DEFAULT_ORDER') and (stlIndexes[I] <> 'CHANGEINDEX') then
        AClientDataSet.DeleteIndex(stlIndexes[I]);
    sInidice := Format('%S', [AIndexField]);
    AClientDataSet.AddIndex(sInidice, AIndexField, [ixCaseInsensitive]);
    AClientDataSet.IndexName := sInidice;
  finally
    stlIndexes.Free;
  end;
end;

procedure TSaleLineParser.GetReducaoZ(const ALine: String;
  var RRZ: TRegReducaoZ);
var
  strTmp: String;
  cAliquota, cBaseCalculo, cImposto: Currency;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutDate(RRZ.AMovDate, strTmp);

    CutString(RRZ.ANumeroSerie, strTmp, 20);

    CutInteger(RRZ.ANumeroLoja, strTmp);
    CutInteger(RRZ.ANumeroECF, strTmp);
    CutInteger(RRZ.ANumReducaoZ, strTmp);
    CutInteger(RRZ.ACOOInicial, strTmp);
    CutInteger(RRZ.ACOOFinal, strTmp);
    CutInteger(RRZ.ANumCancelamentos, strTmp);

    CutReal(RRZ.AValCancelamentos, strTmp);
    CutReal(RRZ.AValDescontos, strTmp);
    CutLongReal(RRZ.AGTInicial, strTmp);
    CutLongReal(RRZ.AGTFinal, strTmp);
    CutReal(RRZ.ASubstituicaoTrib, strTmp);
    CutReal(RRZ.AIsencao, strTmp);
    CutReal(RRZ.ANaoTributavel, strTmp);

    //PAF
    CutString(RRZ.ATipoECF, strTmp, 20);
    CutString(RRZ.AMarcaECF, strTmp, 20);
    CutString(RRZ.AModeloECF, strTmp, 20);
    CutString(RRZ.AVersaoSBECF, strTmp, 10);

    CutDate(RRZ.ADataInstalacaoSBECF, strTmp);

    CutString(RRZ.AMFAdicional, strTmp, 1);

    CutInteger(RRZ.AContadorReducaoZ, strTmp);
    CutInteger(RRZ.AContadorOrdemOperacao, strTmp);
    CutInteger(RRZ.AContadorReinicioOperacao, strTmp);
    CutInteger(RRZ.ANumeroUsuarioECF, strTmp);

    CutBoolean(RRZ.AIncideISSQN, strTmp);

    CutDate(RRZ.ADataEmissao, strTmp);

    while strTmp <> '' do
    begin
      CutReal(cAliquota, strTmp);
      SetLength(RRZ.AAliquota, Length(RRZ.AAliquota)+1);
      RRZ.AAliquota[Length(RRZ.AAliquota)-1] := cAliquota;

      CutReal(cBaseCalculo, strTmp);
      SetLength(RRZ.ABaseCalculo, Length(RRZ.ABaseCalculo)+1);
      RRZ.ABaseCalculo[Length(RRZ.ABaseCalculo)-1] := cBaseCalculo;

      CutReal(cImposto, strTmp);
      SetLength(RRZ.AValImposto, Length(RRZ.AValImposto)+1);
      RRZ.AValImposto[Length(RRZ.AValImposto)-1] := cImposto;
    end;
  end;
end;

procedure TSaleLineParser.GetAddSerialNumber(const ALine: String;
  var RSN: TRegSerialNumber);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 3);

  with FStringToFieldParser do
  begin
    CutInteger(RSN.APosition, strTmp);

    CutString(RSN.ASerialNumber, strTmp, 30);
    CutString(RSN.AIdentificationNumber, strTmp, 30);
  end;
end;

procedure TSaleLineParser.GetOBS(const ALine: String; var ROBS: TRegOBS);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
    CutString(ROBS.AOBS, strTmp, 255);
    
end;

procedure TSaleLineParser.GetCupomVinculado(const ALine: String;
  var RCupomVinculado: TRegCupomVinculado);
var
  strTmp: String;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);

  with FStringToFieldParser do
  begin
    CutInteger(RCupomVinculado.ACOOVinc, strTmp);
    CutInteger(RCupomVinculado.AGNFVinc, strTmp);
    CutInteger(RCupomVinculado.ACDC, strTmp);

    CutDate(RCupomVinculado.ADataHora, strTmp);
  end;
end;

procedure TSaleLineParser.GetTotParcial(const ALine: String;
  var RRZ: TRegReducaoZ);
var
  strTmp, sCodigo: String;
  fValorAcumulado : Currency;
  i : Integer;
begin
  strTmp := ALine;
  Delete(strTmp, 1, 2);
  i := 0;

  with FStringToFieldParser do
    while strTmp <> '' do
    begin
      inc(i);
      SetLength(RRZ.ATribReducaoZList, i);
      CutString(RRZ.ATribReducaoZList[i-1].Codigo, strTmp, 10);
      CutReal(RRZ.ATribReducaoZList[i-1].ValorAcumulado, strTmp);
    end;

end;

{ TLastSale }

procedure TLastSale.AddItem(ALine: String);
var
  LSI : TLastSaleItem;
begin
  LSI := TLastSaleItem.Create;
  LSI.FItemLine := ALine;
  LSI.FCanceled := False;
  FItemList.AddObject('', LSI);
end;

procedure TLastSale.AddItemSerial(ALine: String);
var
  LSIS : TLastSaleItemSerial;
begin
  LSIS := TLastSaleItemSerial.Create;
  LSIS.FItemSerialLine := ALine;
  TLastSaleItem(FItemList.Objects[Pred(FItemList.Count)]).FSerialList.Add(LSIS);
end;

procedure TLastSale.AddPayment(ALine: String);
begin
  FPaymentList.Add(ALine);
end;

procedure TLastSale.CancelItem(APosition: Integer);
var
  LSI : TLastSaleItem;
begin
  if FItemList.Count >= APosition then
  begin
    APosition := APosition-1;
    LSI := TLastSaleItem(FItemList.Objects[APosition]);
    LSI.FCanceled := True;
    FItemList.Objects[APosition] := LSI;
  end;
end;

procedure TLastSale.ClearLastSale;
var
  LSI : TLastSaleItem;
  LSIS : TLastSaleItemSerial;
begin
  FOpenSaleLine := '';
  FCloseSaleLine := '';
  FCustomerLine := '';
  FSaleCode := '';
  FOBS := '';
  FIDCashRegister := -1;
  FIDUser := -1;

  FCanceled := False;
  FPaymentList.Clear;

  while FItemList.Count <> 0 do
  begin
    if FItemList.Objects[0] <> nil then
    begin
      LSI := TLastSaleItem(FItemList.Objects[0]);
      FreeAndNil(LSI);
    end;
    FItemList.Delete(0);
  end;

end;

constructor TLastSale.Create;
begin
  inherited Create;
  FItemList := TStringList.Create;
  FPaymentList := TStringList.Create;
end;

destructor TLastSale.Destroy;
begin
  FItemList.Free;
  FPaymentList.Free;
  inherited Destroy;
end;

{ TLastSaleItem }

constructor TLastSaleItem.Create;
begin
  inherited Create;
  FSerialList := TList.Create;
end;


procedure TLastSaleItem.ClearSerialList;
var
  i: Integer;
  LSIS: TLastSaleItemSerial;
begin
  for i := 0 to Pred(FSerialList.Count) do
  begin
    LSIS := TLastSaleItemSerial(FSerialList[i]);
    if LSIS <> nil then
      FreeAndNil(LSIS);
  end;
  FSerialList.Clear;
end;


destructor TLastSaleItem.Destroy;
begin
  ClearSerialList;
  inherited Destroy;
end;

end.
