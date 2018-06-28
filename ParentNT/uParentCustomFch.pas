unit uParentCustomFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, mrConfigFch, uNTDataSetControl, uNTUpdateControl,
  DBClient, uSystemTypes, DB, StdCtrls, ExtCtrls, uMRSQLParam, uNTTraceControl,
  XiButton, uUserObj;

type
  TParentCustomFch = class(TParentForm)
    dsFch: TDataSource;
    pnlTitulo: TPanel;
    PrintFch: TPrintDialog;
    ConfigFch: TmrConfigFch;
    btnLoop: TXiButton;
    lbLoop: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OnFirstClick(Sender: TObject);
    procedure OnPriorClick(Sender: TObject);
    procedure OnNextClick(Sender: TObject);
    procedure OnLastClick(Sender: TObject);
    procedure OnPrintClick(Sender: TObject);
    procedure OnLoopClick(Sender: TObject);
    procedure dsFchStateChange(Sender: TObject);
  private
    FDataSet: TClientDataSet;
    FParams: String;
    FActionType: TActionType;
    FTransaction: TmrTransaction;
    FOwnerTransaction: Boolean;
    FSession: TmrSession;
    FTraceControl: TmrTraceControl;
    FDataSetControl: TmrDataSetControl;
    FUpdateControl: TmrUpdateControl;
    FOwnerSession: Boolean;
    FInInsertLoop: Boolean;
    FOnGetTransaction: TOnGetTransaction;
    FOnGetForeignKeyValue: TOnGetForeignKeyValue;
    FOnLastRecord: TNotifyEvent;
    FOnPriorRecord: TNotifyEvent;
    FOnFirstRecord: TNotifyEvent;
    FOnNextRecord: TNotifyEvent;
    FOnCanNextRecord: TOnCanNavigate;
    FOnCanPriorRecord: TOnCanNavigate;
    FKeyFieldName : String;
    procedure ConfigAppend;
    procedure ConfigEdit;
    procedure ConfigBrowse;
    procedure UpdateNavigation;
    procedure UpdateButtons;
    procedure CancelChanges;
    procedure SetTransaction;
    procedure SetDefaultFieldsValues;
    procedure SetFieldValue(aFieldName: String; aValue: Variant);
    procedure GetIdentityField;
    procedure SetIdentityField;
    procedure SetCodeField;
    procedure SetForeignField;
    function GetForeignFieldName: String;
    function GetKeyFieldName: String;
    function TestBeforeNavigation: Integer;
    function TestFieldFill: Boolean;
    function TesteFieldsFill(sFields: String): Boolean;
    function TestUniqueFields: Boolean;
    function FormRestricted : Boolean;
  protected
    FSystemUser : TUser;
    procedure ConfigButtons(aActionType: TActionType); virtual; abstract;
    procedure ConfigNavigation(aCanPrior, aCanNext: Boolean); virtual; abstract;
    procedure SetPageControl(PageIndex: Integer); virtual; abstract;
    procedure RestrictForm; virtual;
  public
    destructor Destroy; override;
    procedure Init(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ADataSet: TClientDataSet;
      ASystemUser : TUser; AParams: String = '');
    function ShowFch: Boolean;
    function ApplyChanges: Boolean;
    function GetKeyFieldValue: String;
    procedure Append(AParams: String = '');
    procedure Open(AParams: String = '');
    property KeyFieldName: String read GetKeyFieldName;
    property ForeignFieldName: String read GetForeignFieldName;
    property DataSet: TClientDataSet read FDataSet write FDataSet;
    property ActionType: TActionType read FActionType write FActionType;
    property Params: String read FParams write FParams;
    property Session: TmrSession read FSession write FSession;
    property TraceControl: TmrTraceControl read FTraceControl;
    property DataSetControl: TmrDataSetControl read FDataSetControl;
    property UpdateControl: TmrUpdateControl read FUpdateControl;
    property OwnerSession: Boolean read FOwnerSession write FOwnerSession;
    property Transaction: TmrTransaction read FTransaction write FTransaction;
    property OwnerTransaction: Boolean read FOwnerTransaction write FOwnerTransaction;
    property OnFirstRecord: TNotifyEvent read FOnFirstRecord write FOnFirstRecord;
    property OnPriorRecord: TNotifyEvent read FOnPriorRecord write FOnPriorRecord;
    property OnNextRecord: TNotifyEvent read FOnNextRecord write FOnNextRecord;
    property OnLastRecord: TNotifyEvent read FOnLastRecord write FOnLastRecord;
    property OnCanPriorRecord: TOnCanNavigate read FOnCanPriorRecord write FOnCanPriorRecord;
    property OnCanNextRecord: TOnCanNavigate read FOnCanNextRecord write FOnCanNextRecord;
    property OnGetTransaction: TOnGetTransaction read FOnGetTransaction write FOnGetTransaction;
    property OnGetForeignKeyValue: TOnGetForeignKeyValue read FOnGetForeignKeyValue write FOnGetForeignKeyValue;
  end;

implementation

uses uNTFieldFunctions, mrMsgBox, uMRParam, uParamFunctions;

{$R *.dfm}

{ TParentCustomFch }

procedure TParentCustomFch.ConfigEdit;
begin
  FTraceControl.TraceIn('TParentCustomFch.ConfigEdit');

  ActionType := atEdit;
  if Assigned(ConfigFch.OnBeforeEdit) then
    ConfigFch.OnBeforeEdit(Self);

  SetTransaction;
  UpdateButtons;
  
  if Assigned(ConfigFch.OnAfterEdit) then
    ConfigFch.OnAfterEdit(Self);

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.ConfigAppend;
begin
  FTraceControl.TraceIn('TParentCustomFch.ConfigAppend');

  ActionType := atAppend;
  if Assigned(ConfigFch.OnBeforeAppend) then
    ConfigFch.OnBeforeAppend(Self);

  SetTransaction;
  SetDefaultFieldsValues;
  UpdateButtons;

  if Assigned(ConfigFch.OnAfterAppend) then
    ConfigFch.OnAfterAppend(Self);

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.ConfigBrowse;
begin
  FTraceControl.TraceIn('TParentCustomFch.ConfigBrowse');

  ActionType := atBrowse;
  if Assigned(ConfigFch.OnBeforeBrowse) then
    ConfigFch.OnBeforeBrowse(Self);

  UpdateButtons;
    
  if Assigned(ConfigFch.OnAfterBrowse) then
    ConfigFch.OnAfterBrowse(Self);

  FTraceControl.TraceOut;
end;

destructor TParentCustomFch.Destroy;
begin
  FTraceControl.TraceIn('TParentCustomFch.Destroy');

  if OwnerSession then
    Session.Terminate;
  inherited Destroy;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.dsFchStateChange(Sender: TObject);
begin
  FTraceControl.TraceIn('TParentCustomFch.Destroy');

  try
    if dsFch.State in [dsInsert] then
      ConfigAppend
    else if dsFch.State in [dsEdit] then
      ConfigEdit
    else
      ConfigBrowse;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
end;

procedure TParentCustomFch.Init(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
  AUpdateControl: TmrUpdateControl; ASession: TmrSession; ADataSet: TClientDataSet;
  ASystemUser : TUser; AParams: String = '');
begin
  FInInsertLoop := False;

  FTraceControl := ATraceControl;
  FDataSetControl := ADataSetControl;
  FUpdateControl := AUpdateControl;
  FSystemUser := ASystemUser;

  FTraceControl.TraceIn('TParentCustomFch.Init');
  try
    Params := AParams;

    Self.Caption := ParseParam(Params, 'MenuDisplay');

    ConfigFch.DoBeforeStart;

    OwnerSession := ASession = nil;
    if OwnerSession then
      Session := FDataSetControl.CreateSession
    else
      Session := ASession;

    if ADataSet = nil then
      DataSet := Session.CreateDataSet(ConfigFch.Connection, ConfigFch.ProviderName)
    else
      DataSet := ADataSet;

    dsFch.DataSet := DataSet;
    dsFch.OnStateChange := dsFchStateChange;

    //Seto PacketRecords=0 para abrir o sem dar o fetch.
    //E preciso carregar os fields (MetaData) para configurar a grid.
    //Depois e preciso setar a PacketRecords=-1 para abrir dando o fetch.
    if not DataSet.Active then
    try
      DataSet.PacketRecords := 0;
      DataSet.Open;
    finally
      DataSet.PacketRecords := -1;
    end;

    FKeyFieldName := DataSet.GetOptionalParam('IdentityField');

    if FormRestricted then
      RestrictForm;

    ConfigFch.DoAfterStart;

    FTraceControl.TraceOut;

  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

procedure TParentCustomFch.SetTransaction;
var
  ATransaction: TmrTransaction;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetTransaction');

  ATransaction := nil;
  if Assigned(FOnGetTransaction) then
    OnGetTransaction(Self, ATransaction);

  OwnerTransaction := ATransaction = nil;
  if OwnerTransaction then
    ATransaction := FUpdateControl.CreateTransaction;
  Transaction := ATransaction;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.SetDefaultFieldsValues;
var
  Field, Fields: String;
  Value: Variant;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetDefaultFieldsValues');

  // Pega informações passadas pelo servidor através do evento
  // BeforeGetParam do DataSetProvider
  Fields := DataSet.GetOptionalParam('FieldsDefaultValues');
  while Fields <> '' do
  begin
    GetParamDefaultValue(Fields, Field, Value);
    SetFieldValue(Field, Value);
  end;

  SetIdentityField;
  SetCodeField;
  SetForeignField;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.SetFieldValue(aFieldName: String; aValue: Variant);
var
  fField: TField;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetFieldValue');

  fField := DataSet.FindField(aFieldName);
  if fField <> nil then
  begin
    if (fField is TDateTimeField) or (fField is TSQLTimeStampField) then
      TDateTimeField(fField).AsDateTime := aValue
    else if fField is TBooleanField then
      TBooleanField(fField).AsBoolean := aValue
    else
      fField.Value := aValue;
  end;

  FTraceControl.TraceOut;
  end;

function TParentCustomFch.GetForeignFieldName: String;
begin
  Result := DataSet.GetOptionalParam('ForeignField');
end;

procedure TParentCustomFch.SetForeignField;
var
  ForeignKeyValue: TMRSQLParam;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetForeignField');

  if DataSet.GetOptionalParam('ForeignField') <> '' then
    try
      ForeignKeyValue := TMRSQLParam.Create;
      if Assigned(FOnGetForeignKeyValue) then
      begin
        OnGetForeignKeyValue(Self, ForeignKeyValue);
        DataSet.FieldByName(DataSet.GetOptionalParam('ForeignField')).Value :=
          ForeignKeyValue.KeyByName(DataSet.GetOptionalParam('ForeignField')).AsString;
      end;
    finally
      ForeignKeyValue.Free;
    end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.SetCodeField;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetCodeField');

  if DataSet.GetOptionalParam('AutoGenerateCode') then
    DataSet.FieldByName(DataSet.GetOptionalParam('CodeField')).Value :=
      FDataSetControl.Connection.AppServer.GetNextCode(
      DataSet.GetOptionalParam('TableName'),
      DataSet.GetOptionalParam('CodeField'));

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.SetIdentityField;
begin
  FTraceControl.TraceIn('TParentCustomFch.SetIdentityField');

  if DataSet.GetOptionalParam('AutoGenerateIdentity') then
    GetIdentityField;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.GetIdentityField;
begin
  FTraceControl.TraceIn('TParentCustomFch.GetIdentityField');

  if GetKeyFieldName <> '' then
    DataSet.FieldByName(GetKeyFieldName).Value :=
      FDataSetControl.Connection.AppServer.GetNextCode(
        DataSet.GetOptionalParam('TableName'), GetKeyFieldName);

  FTraceControl.TraceOut;
end;

function TParentCustomFch.GetKeyFieldName: String;
begin
  Result := FKeyFieldName;
end;

function TParentCustomFch.GetKeyFieldValue: String;
var
  i: Integer;
begin
  FTraceControl.TraceIn('TParentCustomFch.GetKeyFieldValue');

  try
  
    for i := 0 to DataSet.Fields.Count-1 do
      if pfInKey in DataSet.Fields[i].ProviderFlags then
      begin
        Result := DataSet.Fields[i].AsString;
        Break;
      end;
    FTraceControl.TraceOut;

  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

function TParentCustomFch.ShowFch: Boolean;
var
  TabIndex: Integer;
begin

  Result := False;
  FTraceControl.TraceIn('TParentCustomFch.ShowFch');
  try
    TabIndex := 0;
    ConfigFch.DoActiveTab(TabIndex);
    SetPageControl(TabIndex);
    UpdateNavigation;
    Result := (ShowModal = mrOk);

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

procedure TParentCustomFch.Open(AParams: String);
begin
  FTraceControl.TraceIn('TParentCustomFch.Open');

  try
    Params := AParams;
    ConfigBrowse;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomFch.Append(AParams: String);
begin

  FTraceControl.TraceIn('TParentCustomFch.Append');
  try
    Params := AParams;
    DataSet.Append;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

function TParentCustomFch.ApplyChanges: Boolean;
begin

  FTraceControl.TraceIn('TParentCustomFch.ApplyChanges');
  Result := False;

  try

    if (GetKeyFieldName <> '') and (DataSet.FieldByName(GetKeyFieldName).Value = null) then
      GetIdentityField;

    DataSet.UpdateRecord;
    if TestFieldFill and TestUniqueFields and ConfigFch.DoBeforeApplyChanges then
    begin
      DataSet.CheckBrowseMode;
      Transaction.PostUpdate(DataSet);
      if OwnerTransaction then
      begin
        ConfigFch.DoBeforeCommitTransaction;
        if Transaction.CommitTransaction then
        begin
          Transaction := nil;
          OwnerTransaction := False;
          Result := True;
          ConfigFch.DoAfterApplyChanges;
          DataSet.Refresh;
          ConfigFch.DoAfterNavigation;
        end
        else
          raise Exception.Create('Transaction.CommitTransaction error');
      end
      else
        Result := True;
    end;

    FTraceControl.TraceOut;

  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

function TParentCustomFch.TestFieldFill: Boolean;
var
  sFields: String;
  i: Integer;
begin
  FTraceControl.TraceIn('TParentCustomFch.TestFieldFill');

  sFields := '';
  with dsFch.DataSet do
    for i := 0 to FieldCount-1 do
      if Fields[i].Required then
      begin
        if sFields <> '' then
          sFields := sFields + ';';
        sFields := sFields + Fields[i].FieldName;
      end;

  Result := TesteFieldsFill(sFields);

  FTraceControl.TraceOut;
end;

function TParentCustomFch.TesteFieldsFill(sFields: String): Boolean;
var
  i: Integer;
  Msg1, Msg2: String;
  slFields: TStringList;
  fField: TField;
begin
  FTraceControl.TraceIn('TParentCustomFch.TesteFieldsFill');

  Msg2 := '';
  Result := True;
  slFields := TStringList.Create;

  with slFields do
  try
    Delimiter := ';';
    DelimitedText := sFields;
    for i := 0 to Count-1 do
    begin
      fField := DataSet.FieldByName(Strings[i]);
      if (fField.AsString = '') and (Result) then
      begin
        Result := False;
        Msg1 := 'Required field [' + fField.DisplayLabel + '].';
        fField.FocusControl;
      end;
      if fField.AsString = '' then
      begin
        if Msg2 <> '' then
          Msg2 := Msg2 + ',';
        Msg2 := Msg2 + fField.DisplayLabel;
      end;
    end;
    if not Result then
      MsgBox(Msg1 + '_The required fields are :' + Msg2, vbInformation + vbOKOnly);
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

function TParentCustomFch.TestUniqueFields: Boolean;
var
  sMsg,
  sTableName,
  sFieldToCompare,
  sValueToCompare,
  sField,
  sUniqueFields,
  sUniqueFieldsList: String;
  i: Integer;
begin
  FTraceControl.TraceIn('TParentCustomFch.TestUniqueFields');

  Result := True;

  sTableName := UpperCase(DataSet.GetOptionalParam('TableName'));
  sUniqueFieldsList := UpperCase(DataSet.GetOptionalParam('UniqueFields'));

  while sUniqueFieldsList <> '' do
  begin
    sFieldToCompare := '';
    sValueToCompare := '';
    sMsg := '';

    sUniqueFields := Copy(sUniqueFieldsList, 1, Pos(';', sUniqueFieldsList)-1);
    sUniqueFieldsList := Copy(sUniqueFieldsList, Pos(';', sUniqueFieldsList)+1, Length(sUniqueFieldsList));

    while sUniqueFields <> '' do
    begin
      if Pos(',', sUniqueFields) > 0 then
      begin
        sField := Copy(sUniqueFields, 1, Pos(',', sUniqueFields)-1);
        sUniqueFields := Copy(sUniqueFields, Pos(',', sUniqueFields)+1, Length(sUniqueFields));
      end
      else
      begin
        sField := sUniqueFields;
        sUniqueFields := '';
      end;

      for i := 0 to DataSet.Fields.Count-1 do
        if UpperCase(DataSet.Fields[i].FieldName) = sField then
        begin
          if sMsg = '' then
            sMsg := 'The value [' + DataSet.Fields[i].AsString + '] of the field [' +
              DataSet.Fields[i].DisplayLabel + '] was already used and cannot be equal.';

          if sFieldToCompare <> '' then
            sFieldToCompare := sFieldToCompare + ',';
          sFieldToCompare := sFieldToCompare + DataSet.Fields[i].FieldName;

          if sValueToCompare <> '' then
            sValueToCompare := sValueToCompare + ',';
          sValueToCompare := sValueToCompare + DataSet.Fields[i].AsString;
        end;
    end;

    if (sFieldToCompare <> '') and (sValueToCompare <> '') then
      Result := FDataSetControl.Connection.AppServer.TestUniqueFields(sTableName,
        sFieldToCompare, sValueToCompare, GetKeyFieldName, GetKeyFieldValue);

    if not Result then
    begin
      MsgBox(sMsg, vbInformation + vbOKOnly);
      Exit;
    end;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.CancelChanges;
begin
  FTraceControl.TraceIn('TParentCustomFch.CancelChanges');

  ConfigFch.DoBeforeCancelChanges;

  DataSet.Cancel;

  if OwnerTransaction then
  begin
    Transaction.RollBackTransaction;
    Transaction := nil;
    OwnerTransaction := False;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.OnLastClick(Sender: TObject);
begin
  FTraceControl.TraceIn('TParentCustomFch.OnLastClick');

  if TestBeforeNavigation <> 0 then
  try
    OnLastRecord(Sender);
    UpdateNavigation;
  finally
    ConfigFch.DoAfterNavigation;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.OnLoopClick(Sender: TObject);
begin
  FInInsertLoop := not FInInsertLoop;
  lbLoop.Visible := FInInsertLoop;
end;

procedure TParentCustomFch.OnPriorClick(Sender: TObject);
begin
  FTraceControl.TraceIn('TParentCustomFch.OnPriorClick');

  if TestBeforeNavigation <> 0 then
  try
    OnPriorRecord(Sender);
    UpdateNavigation;
  finally
    ConfigFch.DoAfterNavigation;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.OnPrintClick(Sender: TObject);
begin
  if PrintFch.Execute then
    Print;
end;

procedure TParentCustomFch.OnFirstClick(Sender: TObject);
begin
  FTraceControl.TraceIn('TParentCustomFch.OnFirstClick');

  if TestBeforeNavigation <> 0 then
  try
    OnFirstRecord(Sender);
    UpdateNavigation;
  finally
    ConfigFch.DoAfterNavigation;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.OnNextClick(Sender: TObject);
begin
  FTraceControl.TraceIn('TParentCustomFch.OnNextClick');

  if TestBeforeNavigation <> 0 then
  try
    OnNextRecord(Sender);
    UpdateNavigation;
  finally
    ConfigFch.DoAfterNavigation;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  FTraceControl.TraceIn('TParentCustomFch.FormCloseQuery');
  CanClose := False;

  if DataSet.State in dsEditModes then
  begin
    if ModalResult = mrOk then
    begin
      if ConfigFch.ConfirmApply then
        if MsgBox('Apply changes?', vbQuestion + vbYesNo) = vbNo then
          Exit;

      if not ApplyChanges then
        Exit
      else
        CanClose := True;

      if FInInsertLoop then
      begin
        Append;
        ModalResult := mrNone;
      end;
    end
    else
    begin
      if ConfigFch.ConfirmCancel then
        if MsgBox('Cancel changes?', vbQuestion + vbYesNo) = vbNo then
          Exit;
      CancelChanges;
      CanClose := True;
    end;
  end
  else
    CanClose := True;
  FTraceControl.TraceOut;
end;

function TParentCustomFch.TestBeforeNavigation: Integer;
var
  Msg: Integer;
begin
  FTraceControl.TraceIn('TParentCustomFch.TestBeforeNavigation');

  Result := 0;
  if dsFch.State in dsEditModes then
  begin
    Msg := MsgBox('Save changes?', vbQuestion + vbYesNoCancel);
    if Msg = vbYes then
    begin
      if not ApplyChanges then
        Exit;
      ActionType := atBrowse;
      Result := 2;
    end
    else if Msg = vbNo then
    begin
      CancelChanges;
      ActionType := atBrowse;
      Result := 1;
    end;
  end
  else
    Result := 1;

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.UpdateButtons;
begin
  FTraceControl.TraceIn('TParentCustomFch.UpdateButtons');
  btnLoop.Visible := (ActionType = atAppend);
  ConfigButtons(ActionType);
  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.UpdateNavigation;
var
  CanPrior, CanNext: Boolean;
begin
  FTraceControl.TraceIn('TParentCustomFch.UpdateNavigation');

  CanPrior := False;
  CanNext := False;

  if Assigned(OnCanPriorRecord) then
    OnCanPriorRecord(Self, CanPrior);

  if Assigned(OnCanNextRecord) then
    OnCanNextRecord(Self, CanNext);

  ConfigNavigation(CanPrior, CanNext);

  FTraceControl.TraceOut;
end;

procedure TParentCustomFch.RestrictForm;
begin
  //Herdado
end;

function TParentCustomFch.FormRestricted: Boolean;
begin

  Result := False;

  if Assigned(FDataSetControl) then
  begin
    if (Pos(Self.Name, FDataSetControl.RestrictForms) > 0) then
      Result := True;

    if not Result then
      Result := FDataSetControl.SoftwareExpired;
  end;

end;

end.
