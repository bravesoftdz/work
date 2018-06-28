unit mrConfigLookupCli;

interface

uses
  SysUtils, Classes, DB, Contnrs, Provider, ADODB, Variants, DBClient;

type
  TRecordType = (rtEnabled, rtDisabled, rtBoth);

  TmrCommandButton = (cbNew, cbOpen, cbDelete, cbClear);
  TmrCommandButtons = set of TmrCommandButton;

  TmrConfigLookupCli = class(TComponent)
  private
    FLookupComboList: TObjectList;
    FFchClassName: String;
    FRecordType: TRecordType;
    FListFieldName: String;
    FKeyFieldName: String;
    FSQLWhereClause: String;
    FSQLOrderClause: String;
    FSQLGroupClause: String;
    FCommanButtons: TmrCommandButtons;
    FOnGetDataSetProperties: TGetDSProps;
    FDataSetProvider: TDataSetProvider;
    FConnectionSourceName: String;
    FProviderSourceName: String;
    FOnBeforeGetRecords: TRemoteEvent;
    FOnAfterGetRecords: TRemoteEvent;
    FTableNamePrefix: String;
    procedure SetLookupCombos;
    procedure SetCommanButtons(const Value: TmrCommandButtons);
    procedure SetKeyFieldName(const Value: String);
    procedure SetListFieldName(const Value: String);
    procedure SetSQLWhereClause(const Value: String);
    procedure SetSQLOrderClause(const Value: String);
    procedure SetSQLGroupClause(const Value: String);
    function GetCommandButtons(ACommandButtons: TmrCommandButtons): String;
    procedure SetDataSetProvider(const Value: TDataSetProvider);
    procedure DoGetDataSetProperties(Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
    procedure DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure DoAfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
  published
    property DataSetProvider: TDataSetProvider read FDataSetProvider write SetDataSetProvider;
    property ConnectionSourceName: String read FConnectionSourceName write FConnectionSourceName;
    property ProviderSourceName: String read FProviderSourceName write FProviderSourceName;
    property FchClassName: String read FFchClassName write FFchClassName;
    property RecordType: TRecordType read FRecordType write FRecordType;
    property ListFieldName: String read FListFieldName write SetListFieldName;
    property TableNamePrefix: String read FTableNamePrefix write FTableNamePrefix;
    property KeyFieldName: String read FKeyFieldName write SetKeyFieldName;
    property SQLWhereClause: String read FSQLWhereClause write SetSQLWhereClause;
    property SQLOrderClause: String read FSQLOrderClause write SetSQLOrderClause;
    property SQLGroupClause: String read FSQLGroupClause write SetSQLGroupClause;
    property CommandButtons: TmrCommandButtons read FCommanButtons write SetCommanButtons default [cbNew, cbOpen, cbDelete, cbClear];
    property OnAfterGetRecords: TRemoteEvent read FOnAfterGetRecords write FOnAfterGetRecords;
    property OnBeforeGetRecords: TRemoteEvent read FOnBeforeGetRecords write FOnBeforeGetRecords;
    property OnGetDataSetProperties: TGetDSProps read FOnGetDataSetProperties write FOnGetDataSetProperties;
  end;

procedure Register;

implementation

uses mrLookupCombo;

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigLookupCli]);
end;

{ TmrConfigLookupCli }

procedure TmrConfigLookupCli.DoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
var
  CommandButtonsList: OleVariant;
begin
  Properties := VarArrayCreate([0, 8], varVariant);

  CommandButtonsList := GetCommandButtons(CommandButtons);
  Properties[0] := VarArrayOf(['CommandButtons', CommandButtonsList, True]);
  Properties[1] := VarArrayOf(['FchClassName', FFchClassName, True]);
  Properties[2] := VarArrayOf(['KeyFieldName', FKeyFieldName, True]);
  Properties[3] := VarArrayOf(['ListFieldName', FListFieldName, True]);
  Properties[4] := VarArrayOf(['ConnectionSourceName', FConnectionSourceName, True]);
  Properties[5] := VarArrayOf(['ProviderSourceName', FProviderSourceName, True]);
  Properties[6] := VarArrayOf(['SQLWhereClause', FSQLWhereClause, True]);
  Properties[7] := VarArrayOf(['SQLOrderClause', FSQLOrderClause, True]);
  Properties[8] := VarArrayOf(['SQLGroupClause', FSQLGroupClause, True]);

  if Assigned(FOnGetDataSetProperties) then
    OnGetDataSetProperties(Sender, DataSet, Properties);
end;

constructor TmrConfigLookupCli.Create(AComponent: TComponent);
begin
  inherited Create(AComponent);
  FCommanButtons := [cbNew, cbOpen, cbDelete, cbClear];
  FLookupComboList := TObjectList.Create;
  FLookupComboList.OwnsObjects := False;
end;

destructor TmrConfigLookupCli.Destroy;
begin
  FLookupComboList.Free;
  inherited;
end;

function TmrConfigLookupCli.GetCommandButtons(ACommandButtons: TmrCommandButtons): String;
begin
  Result := '';
  if cbNew in ACommandButtons then
    Result := Result + 'cbNew;';
  if cbOpen in ACommandButtons then
    Result := Result + 'cbOpen;';
  if cbDelete in ACommandButtons then
    Result := Result + 'cbDelete;';
  if cbClear in ACommandButtons then
    Result := Result + 'cbClear;';
end;

procedure TmrConfigLookupCli.SetCommanButtons(const Value: TmrCommandButtons);
begin
  FCommanButtons := Value;
  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetDataSetProvider(
  const Value: TDataSetProvider);
begin
  FDataSetProvider := Value;
  with FDataSetProvider do
    if Value <> nil then
    begin
      OnGetDataSetProperties := DoGetDataSetProperties;
      BeforeGetRecords := DoBeforeGetRecords;
      AfterGetRecords := DoAfterGetRecords;
    end;
end;

procedure TmrConfigLookupCli.SetKeyFieldName(const Value: String);
begin
  FKeyFieldName := Value;
  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetListFieldName(const Value: String);
begin
  FListFieldName := Value;
  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetSQLWhereClause(const Value: String);
begin
  FSQLWhereClause := Value;
//  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetSQLOrderClause(const Value: String);
begin
  FSQLOrderClause := Value;
//  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetSQLGroupClause(const Value: String);
begin
  FSQLGroupClause := Value;
//  SetLookupCombos;
end;

procedure TmrConfigLookupCli.SetLookupCombos;
var
  I: Integer;
begin
  for I := 0 to FLookupComboList.Count - 1 do
    TmrLookupCombo(FLookupComboList[I]).SetInternalList;
end;

procedure TmrConfigLookupCli.DoBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
var
 OldSql : String;
 sWhere : String;
begin
  if Assigned(FOnBeforeGetRecords) then
    OnBeforeGetRecords(Sender, OwnerData);

  with TADOQuery(FDataSetProvider.DataSet) do
    if (OwnerData <> '')
       or (FSQLWhereClause <> '')
       or (FSQLGroupClause <> '')
       or (FSQLOrderClause <> '') then
    begin
      OldSql := SQL.Text;

      sWhere := '';

      if FSQLWhereClause <> '' then
        if Pos(SQL.Text,'Where') = 0 then
          sWhere := sWhere + 'WHERE ' + FSQLWhereClause
        else
          sWhere := sWhere + 'AND   ' + FSQLWhereClause;

      if OwnerData <> '' then
        if sWhere = '' then
          sWhere := sWhere + 'WHERE ' + OwnerData
        else
          sWhere := sWhere + #13 + #10 + 'AND   ' + OwnerData;

      if sWhere <> '' then
        SQL.Add(sWhere);

      if FSQLGroupClause <> '' then
        SQL.Add('GROUP BY ' + FSQLGroupClause);

      if FSQLOrderClause <> '' then
        SQL.Add('ORDER BY ' + FSQLOrderClause)
      else if FListFieldName <> '' then
        if FTableNamePrefix <> '' then
          SQL.Add('ORDER BY ' + FTableNamePrefix + '.' + FListFieldName)
        else
          SQL.Add('ORDER BY ' + FListFieldName);

      OwnerData := OldSql;
    end
    else
      OwnerData := '';
end;

procedure TmrConfigLookupCli.DoAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  with TADOQuery(FDataSetProvider.DataSet) do
    if OwnerData <> '' then
      SQL.Text := OwnerData;

  if Assigned(FOnAfterGetRecords) then
    OnAfterGetRecords(Sender, OwnerData);

end;

end.
