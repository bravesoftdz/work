unit mrConfigTable;

interface

uses
  SysUtils, Classes, Provider, ADODB, DB, DBClient, Variants;

type
  TmrConfigTable = class(TComponent)
  private
    FAutoGenerateCode: Boolean;
    FAutoGenerateIdentity: Boolean;
    FCodeField: string;
    FDataSetProvider: TDataSetProvider;
    FDependentTables: TStringList;
    FForeignField: String;
    FIdentityField: String;
    FIsVersion: Boolean;
    FLogicalDeleteField: String;
    FReadOnlyFields: TStringList;
    FReadOnlyFieldsOnEdit: TStringList;
    FTableName: String;
    FTableNamePrefix: String;
    FUniqueFields: TStringList;
    FVesionTableKey: String;
    FVersionTableName: String;
    { Eventos}
    FOnAfterGetRecords: TRemoteEvent;
    FOnAfterUpdateRecords: TAfterUpdateRecordEvent;
    FOnBeforeGetRecords: TRemoteEvent;
    FOnBeforeUpdateRecords: TBeforeUpdateRecordEvent;
    FOnGetDataSetProperties: TGetDSProps;
    FOnNewRecord: TRemoteEvent;
    FHiddenFields: TStringList;

    procedure SetDataSetProvider(const Value: TDataSetProvider);
    procedure DoGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DoAfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure DoAfterUpdateRecords(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
    procedure DoBeforeUpdateRecords(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);

    procedure DoInsertRecords(DeltaDS: TCustomClientDataSet; Applied: Boolean);
    procedure DoUpdateRecords(DeltaDS: TCustomClientDataSet; Applied: Boolean);
    procedure DoDeleteRecords(DeltaDS: TCustomClientDataSet; Applied: Boolean);

    procedure DeleteDependentTables(aID: String);

    function GetListFields(ListFields: TStringList): String;
    procedure SetReadOnlyFields(const Value: TStringList);
    procedure SetDependentTables(const Value: TStringList);
    procedure SetReadOnlyFieldsOnEdit(const Value: TStringList);
    procedure SetUniqueFields(const Value: TStringList);
    procedure SetHiddenFields(const Value: TStringList);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoGenerateCode: Boolean read FAutoGenerateCode write FAutoGenerateCode default False;
    property AutoGenerateIdentity: Boolean read FAutoGenerateIdentity write FAutoGenerateIdentity default False;
    property CodeField: string read FCodeField write FCodeField;
    property DataSetProvider: TDataSetProvider read FDataSetProvider write SetDataSetProvider;
    property DependentTables: TStringList read FDependentTables write SetDependentTables;
    property ForeignField: string read FForeignField write FForeignField;
    property IdentityField: string read FIdentityField write FIdentityField;
    property IsVersion: Boolean read FIsVersion write FIsVersion default False;
    property LogicalDeleteField: string read FLogicalDeleteField write FLogicalDeleteField;
    property ReadOnlyFields: TStringList read FReadOnlyFields write SetReadOnlyFields;
    property ReadOnlyFieldsOnEdit: TStringList read FReadOnlyFieldsOnEdit write SetReadOnlyFieldsOnEdit;
    property TableName: string read FTableName write FTableName;
    property TableNamePrefix: string read FTableNamePrefix write FTableNamePrefix;
    property UniqueFields: TStringList read FUniqueFields write SetUniqueFields;
    property VesionTableKey: string read FVesionTableKey write FVesionTableKey;
    property VersionTableName: string read FVersionTableName write FVersionTableName;
    property HiddenFields: TStringList read FHiddenFields write SetHiddenFields;
    {Declarações dos Eventos}
    property OnAfterGetRecords: TRemoteEvent read FOnAfterGetRecords write FOnAfterGetRecords;
    property OnAfterUpdateRecords: TAfterUpdateRecordEvent read FOnAfterUpdateRecords write FOnAfterUpdateRecords;
    property OnBeforeGetRecords: TRemoteEvent read FOnBeforeGetRecords write FOnBeforeGetRecords;
    property OnBeforeUpdateRecords: TBeforeUpdateRecordEvent read FOnBeforeUpdateRecords write FOnBeforeUpdateRecords;
    property OnGetDataSetProperties: TGetDSProps read FOnGetDataSetProperties write FOnGetDataSetProperties;
    property OnNewRecord: TRemoteEvent  read FOnNewRecord write FOnNewRecord;

  end;

procedure Register;

implementation

uses uSQLFunctions, uMRSQLParam;

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigTable]);
end;

{ TmrConfigTable }

procedure TmrConfigTable.DoAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if OwnerData <> '' then
    TADOQuery(FDataSetProvider.DataSet).SQL.Text := OwnerData;

  if Assigned(FOnAfterGetRecords) then
     OnAfterGetRecords(Self, OwnerData);
end;

procedure TmrConfigTable.DoAfterUpdateRecords(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
begin
  if Assigned(FOnAfterUpdateRecords) then
    OnAfterUpdateRecords(Self, SourceDS, DeltaDS, UpdateKind);
end;

procedure TmrConfigTable.DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
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

procedure TmrConfigTable.DoBeforeUpdateRecords(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if Assigned(FOnBeforeUpdateRecords) then
    OnBeforeUpdateRecords(Self, SourceDS, DeltaDS, UpdateKind, Applied);

  if UpdateKind = ukInsert then
    DoInsertRecords(DeltaDS, Applied)

  else if UpdateKind = ukModify then
    DoUpdateRecords(DeltaDS, Applied)

  else if UpdateKind = ukDelete then
    DoDeleteRecords(DeltaDS, Applied);
end;

procedure TmrConfigTable.DoDeleteRecords(DeltaDS: TCustomClientDataSet;
  Applied: Boolean);
begin
  // Deleção nas tabelas dependentes
  if FDependentTables.Text <> '' then
    DeleteDependentTables(DeltaDS.FieldByName(FIdentityField).AsString);
end;

procedure TmrConfigTable.DoInsertRecords(DeltaDS: TCustomClientDataSet;
  Applied: Boolean);
begin
  if not Applied then
     Exit;

  DeltaDS.ApplyRange
end;

procedure TmrConfigTable.DoUpdateRecords(DeltaDS: TCustomClientDataSet;
  Applied: Boolean);
begin
  if not Applied then
     Exit;

  DeltaDS.ApplyRange
end;

procedure TmrConfigTable.SetDataSetProvider(const Value: TDataSetProvider);
begin
  FDataSetProvider := Value;

  with FDataSetProvider do
    if Assigned(FDataSetProvider) then
    begin
      AfterGetRecords := DoAfterGetRecords;
      BeforeGetRecords := DoBeforeGetRecords;
      AfterUpdateRecord := DoAfterUpdateRecords;
      BeforeUpdateRecord := DoBeforeUpdateRecords;
      OnGetDataSetProperties := DoGetDataSetProperties;
    end;
end;

constructor TmrConfigTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReadOnlyFields       := TStringList.Create;
  FReadOnlyFieldsOnEdit := TStringList.Create;
  FUniqueFields         := TStringList.Create;
  FDependentTables      := TStringList.Create;
  FHiddenFields         := TStringList.Create;;
end;

destructor TmrConfigTable.Destroy;
begin
  FReadOnlyFields.Free;
  FReadOnlyFieldsOnEdit.Free;
  FUniqueFields.Free;
  FDependentTables.Free;
  FHiddenFields.Free;
  inherited Destroy;
end;

procedure TmrConfigTable.DoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
var
  FieldsDefaultValues,
  ReadOnlyFieldsList,
  ReadOnlyFieldsOnEditList,
  UniqueFieldsList,
  HiddenFieldsList :OleVariant;
begin
  Properties := VarArrayCreate([0, 12], varVariant);
  Properties[0] := VarArrayOf(['TableName', FTableName, True]);
  Properties[1] := VarArrayOf(['TableNamePrefix', FTableNamePrefix, True]);
  Properties[2] := VarArrayOf(['ForeignField', FForeignField, True]);
  Properties[3] := VarArrayOf(['IdentityField', FIdentityField, True]);
  Properties[4] := VarArrayOf(['AutoGenerateIdentity', FAutoGenerateIdentity, True]);
  Properties[5] := VarArrayOf(['CodeField', FCodeField, True]);
  Properties[6] := VarArrayOf(['AutoGenerateCode', FAutoGenerateCode, True]);
  Properties[7] := VarArrayOf(['LogicalDeleteField', FLogicalDeleteField, True]);

  FieldsDefaultValues := '';
  if Assigned(FOnNewRecord) then
    OnNewRecord(Self, FieldsDefaultValues);
  Properties[8] := VarArrayOf(['FieldsDefaultValues', FieldsDefaultValues, True]);

  ReadOnlyFieldsList := '';
  if Assigned(FReadOnlyFields) then
    ReadOnlyFieldsList := GetListFields(FReadOnlyFields);
  Properties[9] := VarArrayOf(['ReadOnlyFields', ReadOnlyFieldsList, True]);

  ReadOnlyFieldsOnEditList := '';
  if Assigned(FReadOnlyFieldsOnEdit) then
    ReadOnlyFieldsOnEditList := GetListFields(FReadOnlyFieldsOnEdit);
  Properties[10] := VarArrayOf(['ReadOnlyOnEditFields', ReadOnlyFieldsOnEditList, True]);

  UniqueFieldsList := '';
  if Assigned(FUniqueFields) then
    UniqueFieldsList := GetListFields(FUniqueFields);
  Properties[11] := VarArrayOf(['UniqueFields', UniqueFieldsList, True]);

  HiddenFieldsList := '';
  if Assigned(FHiddenFields) then
    HiddenFieldsList := GetListFields(FHiddenFields);
  Properties[12] := VarArrayOf(['HiddenFields', HiddenFieldsList, True]);

  if Assigned(FOnGetDataSetProperties) then
    OnGetDataSetProperties(Self, DataSet, Properties);
end;

function TmrConfigTable.GetListFields(ListFields: TStringList): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ListFields.Count-1 do
    Result := Result + ListFields[I] + ';';
end;

procedure TmrConfigTable.SetReadOnlyFields(const Value: TStringList);
begin
  FReadOnlyFields.Assign(Value);
end;

procedure TmrConfigTable.SetReadOnlyFieldsOnEdit(const Value: TStringList);
begin
  FReadOnlyFieldsOnEdit.Assign(Value);
end;

procedure TmrConfigTable.SetUniqueFields(const Value: TStringList);
begin
  FUniqueFields.Assign(Value);
end;

procedure TmrConfigTable.SetDependentTables(const Value: TStringList);
begin
  FDependentTables.Assign(Value);
end;

procedure TmrConfigTable.DeleteDependentTables(aID: String);
var
  i: Integer;
  sTableName: String;
  sWhereClause: String;
  Connection: TADOConnection;
begin
  Connection := TADOQuery(DataSetProvider.DataSet).Connection;

  with FDependentTables do
    for i := 0 to Count-1 do
    begin
      sTableName := Copy(Strings[i], 1, Pos(',', Strings[i])-1);
      sWhereClause := Copy(Strings[i], Pos(',', Strings[i])+1, Length(Strings[i])) + ' = ' + aID;
      Connection.Execute('DELETE ' + sTableName + ' WHERE ' + sWhereClause);
    end;
end;

procedure TmrConfigTable.SetHiddenFields(const Value: TStringList);
begin
  FHiddenFields.Assign(Value);
end;

end.
