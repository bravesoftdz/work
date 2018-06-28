unit mrSuperCombo;

interface

uses
  Windows, Classes, cxDBLookupComboBox, cxEdit, DB, DBClient, uNTDataSetControl,
  SysUtils, mrBoundLabel, ExtCtrls, Types, Graphics, StdCtrls, Controls,
  Messages, Menus, cxDBEdit, cxDBLookupEdit, uNTUpdateControl, uNTTraceControl,
  uUserObj, Variants, uSystemTypes;

type
  TmrSuperCombo = class;

  TmrDependentLookUp = class(TCollectionItem)
  private
    FName: String;
    FLookUp: TmrSuperCombo;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Name: String read FName write FName;
    property LookUp: TmrSuperCombo read FLookUp write FLookUp;
  end;

  TmrDependentLookUps = class(TCollection)
  private
    FOwner: TPersistent;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TmrDependentLookUp;
    procedure SetItem(Index: Integer; Value: TmrDependentLookUp);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(AOwner: TPersistent); virtual;
    property Items[Index: Integer]: TmrDependentLookUp read GetItem write SetItem; default;
  end;

  TmrSuperComboProperties = class(TcxLookupComboBoxProperties)
  published
    property Buttons;
  end;

  TmrSuperCombo = class(TcxLookupComboBox)
  private
    FProviderListName: String;
    FConnectionListName: String;
    FSession: TmrSession;
    FDataSetList: TClientDataSet;
    FDataSourceList: TDataSource;
    FEditLabel: TmrBoundLabel;
    FPopupMenuButton: TPopupMenu;
    FRequiredLabel: TmrBoundLabel;
    FLabelPosition: TLabelPosition;
    FLocked: Boolean;
    FRequired: Boolean;
    FLabelSpacing: Integer;
    FDisableButtons: Boolean;
    FFchClassName: String;
    FProviderSourceName: String;
    FConnectionSourceName: String;
    FDataSetControl: TmrDataSetControl;
    FTraceControl: TmrTraceControl;
    FUpdateControl: TmrUpdateControl;
    FSystemUser : TUser;
    FOnBeforeGetRecordsList: TRemoteEvent;
    FParams: String;
    FDependentLookUps: TmrDependentLookUps;
    FSchClassName: String;
    FOnStartSearch: TOnGetParams;
    procedure PopupClick(Sender: TObject);
    function GetProperties: TmrSuperComboProperties;
    procedure SetProperties(const Value: TmrSuperComboProperties);
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetLocked(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
    procedure SetupInternalLabel;
    procedure SetInternalButtons;
    procedure SetCommandButtons;
    procedure SetInternalList;
    procedure SetInternalPopup;
    procedure SetConfigFch;
    procedure OpenListSource;
    procedure DoBeforeGetRecordsList(Sender: TObject; var OwnerData: OleVariant);
    procedure DoBeforeGetRecordsSource(Sender: TObject; var OwnerData: OleVariant);

    procedure InsertRecord(AParams: String = '');
    procedure OpenRecord(AParams: String = '');
    procedure DeleteRecord;
    procedure SearchRecord;
    procedure SetDependentLookUps(const Value: TmrDependentLookUps);
    procedure RefreshDependentLookups;
    procedure SetSchClassName(const Value: String);
  protected
    procedure ClearValue; virtual;
    procedure SetDBValues(DataSet: TDataSet); overload; virtual;
    procedure SetDBValues(AFieldValue : Variant); overload; virtual;
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure DoButtonUp(Index: Integer); override;
    property TraceControl: TmrTraceControl read FTraceControl write FTraceControl;
    property DataSetControl: TmrDataSetControl read FDataSetControl write FDataSetControl;
    property UpdateControl: TmrUpdateControl read FUpdateControl write FUpdateControl;
    property Session: TmrSession read FSession write FSession;
    property DataSetList: TClientDataSet read FDataSetList write FDataSetList;
    property DataSourceList: TDataSource read FDataSourceList write FDataSourceList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure CreateListSource(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser; AParams : String = '');
    procedure ApplyFilters(AFilter : String);
    function GetFieldValue(AFieldName: String): Variant;
  published
    property OnBeforeGetRecordsList : TRemoteEvent read FOnBeforeGetRecordsList write FOnBeforeGetRecordsList;
    property Properties: TmrSuperComboProperties read GetProperties write SetProperties;
    property DisableButtons: Boolean read FDisableButtons write FDisableButtons;
    property ConnectionListName: String read FConnectionListName write FConnectionListName;
    property ConnectionSourceName: String read FConnectionSourceName write FConnectionSourceName;
    property ProviderListName: String read FProviderListName write FProviderListName;
    property ProviderSourceName: String read FProviderSourceName write FProviderSourceName;
    property FchClassName: String read FFchClassName write FFchClassName;
    property SchClassName: String read FSchClassName write SetSchClassName;
    property EditLabel: TmrBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
    property Required: Boolean read FRequired write SetRequired;
    property Locked: Boolean read FLocked write SetLocked;
    property Params : String read FParams write FParams;
    property DependentLookUps: TmrDependentLookUps read FDependentLookUps write SetDependentLookUps;
    property OnStartSearch : TOnGetParams read FOnStartSearch write FOnStartSearch;
  end;

  TmrDBSuperCombo = class(TmrSuperCombo)
  private
    function GetDataBinding: TcxDBTextEditDataBinding;
    procedure SetDataBinding(Value: TcxDBTextEditDataBinding);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure ClearValue; override;
    procedure SetDBValues(DataSet: TDataSet); overload; override;
    procedure SetDBValues(AFieldValue : Variant); overload; override; 
    class function GetDataBindingClass: TcxEditDataBindingClass; override;
  published
    property DataBinding: TcxDBTextEditDataBinding read GetDataBinding write SetDataBinding;
  end;

procedure Register;

implementation

uses cxLookupDBGrid, cxDropDownEdit, mrMsgBox, uParentCustomFch,
  uClasseFunctions, uMRSQLParam, uParentSearchForm;

procedure Register;
begin
  RegisterComponents('MultiTierDataControls', [TmrSuperCombo]);
  RegisterComponents('MultiTierDataControls', [TmrDBSuperCombo]);
end;

{ TmrSuperCombo }

constructor TmrSuperCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpLeft;
  FLabelSpacing := 6;
  Properties.ListOptions.ShowHeader := False;
  SetupInternalLabel;
  SetInternalButtons;
  SetInternalPopup;

  FDependentLookUps := TmrDependentLookUps.Create(Self);
  FDependentLookUps.OnChange := Properties.OnChange;
end;

procedure TmrSuperCombo.CreateListSource(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
  AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser; AParams : String);
begin
  TraceControl := ATraceControl;
  DataSetControl := ADataSetControl;
  UpdateControl := AUpdateControl;
  FSystemUser := ASystemUser;
  FParams := AParams;

  // Get Session if necesary
  if not Assigned(ASession) then
    Session := FDataSetControl.CreateSession
  else
    Session := ASession;

  // Get DataSource if necesary
  if DataSourceList = nil then
  begin
    DataSourceList := TDataSource.Create(Self);
    Properties.ListSource := DataSourceList;
  end;

  // Get Dataset if necesary
  if DataSetList = nil then
  begin
    DataSetList := Session.CreateDataSet(ConnectionListName, ProviderListName);
    // Set combo filter event
    DataSetList.BeforeGetRecords := DoBeforeGetRecordsList;
    // Set DataSource
    Properties.ListSource.DataSet := DataSetList;

    OpenListSource;
    SetConfigFch;
    SetInternalList;
    SetCommandButtons;
  end;
end;

destructor TmrSuperCombo.Destroy;
begin
  FPopupMenuButton.Free;
  FreeAndNil(FDependentLookUps);
  inherited Destroy;
end;

procedure TmrSuperCombo.DoBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin
  if Assigned(FOnBeforeGetRecordsList) then
    OnBeforeGetRecordsList(Sender, OwnerData);
end;

procedure TmrSuperCombo.DoBeforeGetRecordsSource(Sender: TObject;
  var OwnerData: OleVariant);
begin
  with TMRSQLParam.Create do
    try
      AddKey(Properties.KeyFieldNames).AsString := EditValue;
      KeyByName(Properties.KeyFieldNames).Condition := tcEquals;
      OwnerData := ParamString;
    finally
      Free;
    end;
end;

function TmrSuperCombo.GetProperties: TmrSuperComboProperties;
begin
  Result := TmrSuperComboProperties(FProperties);
end;

class function TmrSuperCombo.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TmrSuperComboProperties;
end;

procedure TmrSuperCombo.OpenListSource;
begin
  with DataSetList do
  begin
    if Active then
      Close;
    Open;
  end;
end;

procedure TmrSuperCombo.SetInternalList;
begin
  if Properties.ListFieldNames = '' then
    Properties.ListFieldNames := UpperCase(DataSetList.GetOptionalParam('ListFieldNames'));
  if Properties.KeyFieldNames = '' then
    Properties.KeyFieldNames := UpperCase(DataSetList.GetOptionalParam('KeyFieldName'));
end;

procedure TmrSuperCombo.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if Assigned(FEditLabel) then
  begin
    FLabelPosition := Value;
    case Value of
      lpAbove: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
      lpBelow: P := Point(Left, Top + Height + FLabelSpacing);
      lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing,
                      Top + ((Height - FEditLabel.Height) div 2));
      lpRight: P := Point(Left + Width + FLabelSpacing,
                      Top + ((Height - FEditLabel.Height) div 2));
    end;
    FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
  end;
  if Assigned(FRequiredLabel) then
    FRequiredLabel.SetBounds(Left + Width + 3, Top + 1, FRequiredLabel.Width, FRequiredLabel.Height);
end;

procedure TmrSuperCombo.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
  Properties.ReadOnly := Value;
  ParentColor := Value;
  if not Value then
    Color := clWindow;
end;

procedure TmrSuperCombo.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TmrSuperCombo.SetProperties(const Value: TmrSuperComboProperties);
begin
  FProperties.Assign(Value);
end;

procedure TmrSuperCombo.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if Value then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrSuperCombo.SetupInternalLabel;
begin
  if not Assigned(FEditLabel) then
  begin
    FEditLabel := TmrBoundLabel.Create(Self);
    FEditLabel.Name := 'SubEditLabel';
    FEditLabel.SetSubComponent(True);
    FEditLabel.FreeNotification(Self);
    TLabel(FEditLabel).FocusControl := Self;
  end;
  if not Assigned(FRequiredLabel) then
  begin
    FRequiredLabel := TmrBoundLabel.Create(Self);
    with FRequiredLabel do
    begin
      Name := 'SubRequiredLabel';
      SetSubComponent(True);
      FreeNotification(Self);
      Caption := '*';
      Font.Color := $00804000;
      Font.Style := [fsBold];
      Font.Size := 15;
      Font.Name := 'Verdana';
      Transparent := True;
    end;
  end;
end;

procedure TmrSuperCombo.SetName(const Value: TComponentName);
begin
  inherited;
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TmrSuperCombo.CMBidimodechanged(var Message: TMessage);
begin
  FEditLabel.BiDiMode := BiDiMode;
  FRequiredLabel.BiDiMode := BiDiMode;
end;

procedure TmrSuperCombo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
  if (AComponent = FRequiredLabel) and (Operation = opRemove) then
    FRequiredLabel := nil;
end;

procedure TmrSuperCombo.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

procedure TmrSuperCombo.CMEnabledchanged(var Message: TMessage);
begin
  FEditLabel.Enabled := Enabled;
  FRequiredLabel.Enabled := Enabled;
end;

procedure TmrSuperCombo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TmrSuperCombo.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Visible := Visible;
  FRequiredLabel.Visible := Visible;
  if Visible and Required then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrSuperCombo.SetInternalButtons;
begin
  Properties.Buttons.Add;
  Properties.Buttons[1].Kind := bkEllipsis;
end;

procedure TmrSuperCombo.SetInternalPopup;

  procedure CreateMenuItem(Caption: String);
  var
    MenuItem: TMenuItem;
  begin
    MenuItem := TMenuItem.Create(FPopupMenuButton);
    FPopupMenuButton.Items.Add(MenuItem);
    MenuItem.Caption := Caption;
    MenuItem.OnClick := PopupClick;
  end;

begin
  // Create and config the PoppuMenu
  if not Assigned(FPopupMenuButton) then
  begin
    // I like to use the statemant "with", but it does not function
    FPopupMenuButton := TPopupMenu.Create(Self);
    FPopupMenuButton.Name := 'SubPopupMenu';
    FPopupMenuButton.SetSubComponent(True);
    FPopupMenuButton.FreeNotification(Self);
    CreateMenuItem('&New...');
    CreateMenuItem('&Open...');
    CreateMenuItem('&Delete...');
    CreateMenuItem('-');
    CreateMenuItem('Clear');
  end;
end;

procedure TmrSuperCombo.PopupClick(Sender: TObject);
begin
  case TMenuItem(Sender).MenuIndex of
    0: InsertRecord(Self.Params);
    1: OpenRecord(Self.Params);
    2: if MsgBox('Delete [' + Text + '] ?', vbQuestion + vbYesNo) = mrYes then
         DeleteRecord;
    4: ClearValue;
  end;
end;

procedure TmrSuperCombo.DoButtonUp(Index: Integer);
var
  CursorPos: TPoint;
begin
  if not Locked then
    case Index of
      1: begin
           SetCommandButtons;
           GetCursorPos(CursorPos);
           FPopupMenuButton.Popup(CursorPos.X, CursorPos.Y);
         end;
      2: begin
           SearchRecord;
         end;
    end;

  EditButtonClick;
end;

procedure TmrSuperCombo.SetCommandButtons;
var
  CommandButtonsList: String;
begin
  CommandButtonsList := UpperCase(DataSetList.GetOptionalParam('CommandButtons'));

  FPopupMenuButton.Items[0].Visible := (Pos('CBNEW', CommandButtonsList) > 0) and not DisableButtons and not Locked;
  FPopupMenuButton.Items[1].Visible := (Pos('CBOPEN', CommandButtonsList) > 0) and not DisableButtons;
  FPopupMenuButton.Items[2].Visible := (Pos('CBDELETE', CommandButtonsList) > 0) and not DisableButtons and not Locked;
  FPopupMenuButton.Items[4].Visible := (Pos('CBCLEAR', CommandButtonsList) > 0) and not Locked;

  FPopupMenuButton.Items[1].Enabled := (Trim(Text) <> '');
  FPopupMenuButton.Items[2].Enabled := (Trim(Text) <> '');
end;

procedure TmrSuperCombo.InsertRecord(AParams: String);
var
  NewSession: TmrSession;
  NewDataSet: TClientDataSet;
  Records : Integer;
  NewKey : Variant;
begin
  NewKey := -1;
  NewSession := nil;
  with TParentCustomFch(CreateForm(Self, FchClassName)) do
    try
      NewSession := Self.DataSetControl.CreateSession;
      NewDataSet := NewSession.CreateDataSet(ConnectionSourceName, ProviderSourceName);
      NewDataSet.Open;
      Records := NewDataSet.RecordCount;
      Init(Self.TraceControl, Self.DataSetControl, Self.UpdateControl, NewSession, NewDataSet, Self.FSystemUser, AParams);
      Append;
      ShowFch;
      NewKey := NewDataSet.FieldByName(Properties.KeyFieldNames).Value;
      if NewDataSet.RecordCount > Records then
      begin
        SetDBValues(NewDataSet);
        RefreshDependentLookups;
      end;
     finally
       Free;
       NewSession.Terminate;
       OpenListSource;
       SetEditValue(NewKey);
    end;
end;

procedure TmrSuperCombo.OpenRecord(AParams: String);
var
  NewSession: TmrSession;
  NewDataSet: TClientDataSet;
  ChangedKey: Variant;
begin
  ChangedKey := -1;
  NewSession := nil;
  with TParentCustomFch(CreateForm(Self, FchClassName)) do
    try
      NewSession := Self.DataSetControl.CreateSession;
      NewDataSet := NewSession.CreateDataSet(ConnectionSourceName, ProviderSourceName);
      NewDataSet.BeforeGetRecords := DoBeforeGetRecordsSource;
      NewDataSet.Open;
      Init(Self.TraceControl, Self.DataSetControl, Self.UpdateControl, NewSession, NewDataSet, Self.FSystemUser, AParams);
      Open(AParams);
      ShowFch;
      ChangedKey := EditValue;
      RefreshDependentLookups;
    finally
      Free;
      NewSession.Terminate;
      OpenListSource;
      SetEditValue(ChangedKey);
    end;
end;

procedure TmrSuperCombo.DeleteRecord;
begin
  with DataSetList do
    try
      if Locate(Properties.KeyFieldNames, EditValue, []) then
      begin
        Delete;
        if ApplyUpdates(0) = 0 then
          RefreshDependentLookups;
      end;
    finally
      ClearValue;
      OpenListSource;
    end;
end;

procedure TmrSuperCombo.SetConfigFch;
begin
  if FFchClassName = '' then
    FFchClassName := UpperCase(DataSetList.GetOptionalParam('FchClassName'));
  if FConnectionSourceName = '' then
    FConnectionSourceName := UpperCase(DataSetList.GetOptionalParam('ConnectionSourceName'));
  if FProviderSourceName = '' then
    FProviderSourceName := UpperCase(DataSetList.GetOptionalParam('ProviderSourceName'));
end;

procedure TmrSuperCombo.ClearValue;
begin
  Self.Clear;
end;

procedure TmrSuperCombo.SetDBValues(DataSet: TDataSet);
begin
  // para ser herdado
end;

procedure TmrSuperCombo.ApplyFilters(AFilter: String);
begin
  if (DataSetList <> nil) then
  begin
    DataSetList.Filtered := False;
    DataSetList.Filter   := AFilter;
    if AFilter <> '' then
      DataSetList.Filtered := True;
  end;
end;

procedure TmrSuperCombo.SetDependentLookUps(const Value: TmrDependentLookUps);
begin
  FDependentLookUps.Assign(Value);
end;

procedure TmrSuperCombo.RefreshDependentLookups;
var
  i: Integer;
begin
  for i := 0 to Pred(FDependentLookUps.Count) do
    FDependentLookUps[i].LookUp.OpenListSource;
end;

procedure TmrSuperCombo.SetSchClassName(const Value: String);
begin
  FSchClassName := Value;

  if (Value <> '') and (Properties.Buttons.Count = 2) then
  begin
    Properties.Buttons.Add;
    Properties.Buttons[2].Kind := bkGlyph;
  end;
end;

procedure TmrSuperCombo.SearchRecord;
var
  NewKey : Variant;
  SearchParam : String;
begin
  NewKey := Null;

  with TParentSearchForm(CreateForm(Self, SchClassName)) do
  try
    if Assigned(FOnStartSearch) then
      FOnStartSearch(Self, SearchParam);

    NewKey := Search(SearchParam);
  finally
    Free;
  end;

  if NewKey <> Null then
  begin
    SetDBValues(NewKey);
    SetEditValue(NewKey);
  end;

end;

procedure TmrSuperCombo.SetDBValues(AFieldValue: Variant);
begin
  //Para ser herdado
end;

function TmrSuperCombo.GetFieldValue(AFieldName: String): Variant;
begin
  Result := Null;
  if FDataSetList.Locate(Properties.KeyFieldNames, EditValue, []) then
    Result := FDataSetList.FieldByName(AFieldName).Value;
end;

{ TmrDBSuperCombo }

procedure TmrDBSuperCombo.ClearValue;
begin
  inherited;
  if DataBinding <> nil then
  begin
    DataBinding.DataSource.DataSet.Edit;
    DataBinding.DataSource.DataSet.FieldByName(DataBinding.DataField).Clear;
  end;
end;

procedure TmrDBSuperCombo.CMGetDataLink(var Message: TMessage);
begin
  if not IsInplace then
    Message.Result := Integer(TcxDBEditDataBinding(DataBinding).DataLink);
end;

function TmrDBSuperCombo.GetDataBinding: TcxDBTextEditDataBinding;
begin
  Result := TcxDBTextEditDataBinding(FDataBinding);
end;

class function TmrDBSuperCombo.GetDataBindingClass: TcxEditDataBindingClass;
begin
  Result := TcxDBEditDataBinding;
end;

procedure TmrDBSuperCombo.SetDataBinding(Value: TcxDBTextEditDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TmrDBSuperCombo.SetDBValues(DataSet: TDataSet);
begin
  if DataBinding <> nil then
  begin
    DataBinding.DataSource.Edit;
    DataBinding.DataLink.Field.Value := DataSet.FieldByName(Properties.KeyFieldNames).AsString;
  end;
end;

procedure TmrDBSuperCombo.SetDBValues(AFieldValue: Variant);
begin
  inherited;
  if DataBinding <> nil then
  begin
    DataBinding.DataSource.Edit;
    DataBinding.DataLink.Field.Value := AFieldValue;
  end;
end;

{ TmrDependentLookUps }

constructor TmrDependentLookUps.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
  inherited Create(TmrDependentLookUp);
end;

function TmrDependentLookUps.GetItem(Index: Integer): TmrDependentLookUp;
begin
  Result := TmrDependentLookUp(inherited GetItem(Index));
end;

function TmrDependentLookUps.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TmrDependentLookUps.SetItem(Index: Integer;
  Value: TmrDependentLookUp);
begin
  inherited SetItem(Index, Value);
end;

procedure TmrDependentLookUps.Update(Item: TCollectionItem);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TmrDependentLookUp }

constructor TmrDependentLookUp.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

end.
