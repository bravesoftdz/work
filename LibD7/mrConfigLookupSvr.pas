unit mrConfigLookupSvr;

interface

uses sysutils, classes, Provider, DBClient, DB, Variants, ADODB;

type
  TmrCommandButton = (cbNew, cbOpen, cbDelete,cbClear);
  TmrCommandButtons = set of TmrCommandButton;

  TmrRecordType = (rtEnabled, rtDisabled, rtBoth);
  TmrRecordTypes = set of TmrRecordType;

  TmrConfigLookupSvr = class(TComponent)
  private
    FCommandButtons: TmrCommandButtons;
    FConnectionSourceName: String;
    FDataSetProvider: TDataSetProvider;
    FFchClassName: String;
    FKeyFieldName: String;
    FListFieldNames: TStringList;
    FProviderSourceName: String;
    FRecordTypes: TmrRecordTypes;
    FTableNamePrefix: String;
    { Eventos }
    FOnAfterGetRecords: TRemoteEvent;
    FOnBeforeGetRecords: TRemoteEvent;
    FOnGetDataSetProperties: TGetDSProps;
    procedure SetDataSetProvider(const Value: TDataSetProvider);
    function GetLisTmrCommandButtons: String;
    function GetListFieldNames(ListFieldNames: TStringList): String;
    procedure SetListFieldNames(const Value: TStringList);
    procedure DoGetDataSetProperties(Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
    procedure DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure DoAfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CommandButtons: TmrCommandButtons read FCommandButtons write FCommandButtons;
    property ConnectionSourceName: String read FConnectionSourceName write FConnectionSourceName;
    property DataSetProvider: TDataSetProvider read FDataSetProvider write SetDataSetProvider;
    property FchClassName: String read FFchClassName write FFchClassName;
    property KeyFieldName: String read FKeyFieldName write FKeyFieldName;
    property ListFieldNames: TStringList read FListFieldNames write SetListFieldNames;
    property ProviderSourceName: String read FProviderSourceName write FProviderSourceName;
    property RecordTypes: TmrRecordTypes read FRecordTypes write FRecordTypes;
    property TableNamePrefix: String read FTableNamePrefix write FTableNamePrefix;
    property OnAfterGetRecords: TRemoteEvent read FOnAfterGetRecords write FOnAfterGetRecords;
    property OnBeforeGetRecords: TRemoteEvent read FOnBeforeGetRecords write FOnBeforeGetRecords;
    property OnGetDataSetProperties: TGetDSProps read FOnGetDataSetProperties write FOnGetDataSetProperties;
  end;

procedure Register;

implementation

uses uSQLFunctions, uMRSQLParam;

{ TmrConfigLookupSvr }

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigLookupSvr]);
end;

procedure TmrConfigLookupSvr.SetListFieldNames(const Value: TStringList);
begin
  FListFieldNames.Assign(Value);
end;

constructor TmrConfigLookupSvr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListFieldNames := TStringList.Create;
end;

destructor TmrConfigLookupSvr.Destroy;
begin
  FListFieldNames.Free;
  inherited Destroy;
end;

function TmrConfigLookupSvr.GetLisTmrCommandButtons: String;
begin
  Result := '';

  if cbNew in FCommandButtons then
    Result := Result + 'CBNEW;';
  if cbOpen in FCommandButtons then
    Result := Result + 'CBOPEN';
  if cbDelete in FCommandButtons then
    Result := Result + 'CBDELETE';
  if cbClear in FCommandButtons then
    Result := Result + 'CBCLEAR';
end;

procedure TmrConfigLookupSvr.DoAfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
begin
  if OwnerData <> '' then
    TADOQuery(FDataSetProvider.DataSet).SQL.Text := OwnerData;

  if Assigned(FOnAfterGetRecords) then
     OnAfterGetRecords(Self, OwnerData);
end;

procedure TmrConfigLookupSvr.DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
var
  sOldSQL: String;
  Where: TMRSQLParam;
begin
  try
    sOldSQL := TADOQuery(FDataSetProvider.DataSet).SQL.Text;
    Where := TMRSQLParam.Create;
    Where.ParamString := OwnerData;

    if Assigned(FOnBeforeGetRecords) then
      OnBeforeGetRecords(Self, OwnerData)
    else
      OwnerData := Where.GetWhereSQL;

    TADOQuery(FDataSetProvider.DataSet).SQL.Text :=
      ChangeWhereClause(TADOQuery(FDataSetProvider.DataSet).SQL.Text, OwnerData, True);

    OwnerData := sOldSQL;
  finally
    FreeAndNil(Where);
  end;
end;

{ TmrConfigLookupSvr }

procedure TmrConfigLookupSvr.DoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
var
  ListFieldNames: OleVariant;
begin
  Properties := VarArrayCreate([0, 5], varVariant);
  Properties[0] := VarArrayOf(['ConnectionSourceName', FConnectionSourceName, True]);
  Properties[1] := VarArrayOf(['ProviderSourceName', FProviderSourceName, True]);
  Properties[2] := VarArrayOf(['FchClassName', FFchClassName, True]);
  Properties[3] := VarArrayOf(['KeyFieldName', FKeyFieldName, True]);

  if Assigned(FListFieldNames) then
    ListFieldNames := GetListFieldNames(FListFieldNames);
  Properties[4] := VarArrayOf(['ListFieldNames', ListFieldNames, True]);

  Properties[5] := VarArrayOf(['CommandButtons', GetLisTmrCommandButtons, True]);

  if Assigned(FOnGetDataSetProperties) then
    OnGetDataSetProperties(Self, DataSet, Properties);
end;

function TmrConfigLookupSvr.GetListFieldNames(ListFieldNames: TStringList): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ListFieldNames.Count-1 do
    Result := Result + ListFieldNames[I] + ';';
end;

procedure TmrConfigLookupSvr.SetDataSetProvider(const Value: TDataSetProvider);
begin
  FDataSetProvider := Value;

  with FDataSetProvider do
    if Assigned(FDataSetProvider) then
    begin
      OnGetDataSetProperties := DoGetDataSetProperties;
      BeforeGetRecords := DoBeforeGetRecords;
      AfterGetRecords := DoAfterGetRecords;
    end;
end;

end.
