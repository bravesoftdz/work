unit mrLookupCombo;

interface

uses
  Windows, Classes, cxDBLookupComboBox, cxEdit, DB, DBClient, uNTDataSetControl,
  SysUtils, mrBoundLabel, ExtCtrls, Types, Graphics, StdCtrls, Controls,
  Messages, Menus, cxDBEdit, cxDBLookupEdit, uNTUpdateControl, uNTTraceControl,
  uUserObj;

type
  TmrLookupComboBoxProperties = class(TcxLookupComboBoxProperties)
  published
    property Buttons;
  end;

  TmrLookupCombo = class(TcxLookupComboBox)
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
    procedure PopupClick(Sender: TObject);
    function GetProperties: TmrLookupComboBoxProperties;
    procedure SetProperties(const Value: TmrLookupComboBoxProperties);
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetLocked(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
    procedure SetupInternalLabel;
    procedure SetInternalButtons;
    procedure SetCommandButtons;
    procedure SetInternalPopup;
    procedure SetConfigFch;
    procedure OpenListSource;
    procedure DoBeforeGetRecordsList(Sender: TObject; var OwnerData: OleVariant);
    procedure DoBeforeGetRecordsSource(Sender: TObject; var OwnerData: OleVariant);

    procedure InsertRecord(AParams: String = '');
    procedure OpenRecord(AParams: String = '');
    procedure DeleteRecord;
  protected
    procedure ClearValue; virtual;
    procedure SetDBValues(DataSet: TDataSet); virtual;
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
    procedure SetInternalList;
    procedure CreateListSource(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser);
  published
    property Properties: TmrLookupComboBoxProperties read GetProperties write SetProperties;
    property DisableButtons: Boolean read FDisableButtons write FDisableButtons;
    property ConnectionListName: String read FConnectionListName write FConnectionListName;
    property ConnectionSourceName: String read FConnectionSourceName write FConnectionSourceName;
    property ProviderListName: String read FProviderListName write FProviderListName;
    property ProviderSourceName: String read FProviderSourceName write FProviderSourceName;
    property FchClassName: String read FFchClassName write FFchClassName;
    property EditLabel: TmrBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
    property Required: Boolean read FRequired write SetRequired;
    property Locked: Boolean read FLocked write SetLocked;
  end;

  TmrDBLookupCombo = class(TmrLookupCombo)
  private
    function GetDataBinding: TcxDBTextEditDataBinding;
    procedure SetDataBinding(Value: TcxDBTextEditDataBinding);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure ClearValue; override;
    procedure SetDBValues(DataSet: TDataSet); override;
    class function GetDataBindingClass: TcxEditDataBindingClass; override;
  published
    property DataBinding: TcxDBTextEditDataBinding read GetDataBinding write SetDataBinding;
  end;

procedure Register;

implementation

uses cxLookupDBGrid, cxDropDownEdit, mrMsgBox, uParentCustomFch,
  uClasseFunctions, uMRSQLParam;

procedure Register;
begin
  RegisterComponents('MultiTierDataControls', [TmrLookupCombo]);
  RegisterComponents('MultiTierDataControls', [TmrDBLookupCombo]);
end;

{ TmrLookupCombo }

constructor TmrLookupCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpLeft;
  FLabelSpacing := 6;
  Properties.ListOptions.ShowHeader := False;
  SetupInternalLabel;
  SetInternalButtons;
  SetInternalPopup;
end;

procedure TmrLookupCombo.CreateListSource(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
  AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser);
begin
  TraceControl := ATraceControl;
  DataSetControl := ADataSetControl;
  UpdateControl := AUpdateControl;
  Session := ASession;
  FSystemUser := ASystemUser;

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

destructor TmrLookupCombo.Destroy;
begin
  FPopupMenuButton.Free;
  inherited Destroy;
end;

procedure TmrLookupCombo.DoBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin

end;

procedure TmrLookupCombo.DoBeforeGetRecordsSource(Sender: TObject;
  var OwnerData: OleVariant);
var
  Filter: TMRSQLParam;
begin
  with TMRSQLParam.Create do
    try
      AddKey(Properties.KeyFieldNames).AsString := EditValue;
      KeyByName(Properties.KeyFieldNames).Condition := tcLike;
      OwnerData := ParamString;
    finally
      Free;
    end;
end;

function TmrLookupCombo.GetProperties: TmrLookupComboBoxProperties;
begin
  Result := TmrLookupComboBoxProperties(FProperties);
end;

class function TmrLookupCombo.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TmrLookupComboBoxProperties;
end;

procedure TmrLookupCombo.OpenListSource;
begin
  with DataSetList do
  begin
    if Active then
      Close;
    Open;
  end;
end;

procedure TmrLookupCombo.SetInternalList;
begin
  Properties.ListFieldNames := UpperCase(DataSetList.GetOptionalParam('ListFieldNames'));
  Properties.KeyFieldNames := UpperCase(DataSetList.GetOptionalParam('KeyFieldName'));
end;

procedure TmrLookupCombo.SetLabelPosition(const Value: TLabelPosition);
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

procedure TmrLookupCombo.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
  Properties.ReadOnly := Value;
  ParentColor := Value;
  if not Value then
    Color := clWindow;
end;

procedure TmrLookupCombo.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TmrLookupCombo.SetProperties(const Value: TmrLookupComboBoxProperties);
begin
  FProperties.Assign(Value);
end;

procedure TmrLookupCombo.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if Value then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrLookupCombo.SetupInternalLabel;
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

procedure TmrLookupCombo.SetName(const Value: TComponentName);
begin
  inherited;
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TmrLookupCombo.CMBidimodechanged(var Message: TMessage);
begin
  FEditLabel.BiDiMode := BiDiMode;
  FRequiredLabel.BiDiMode := BiDiMode;
end;

procedure TmrLookupCombo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
  if (AComponent = FRequiredLabel) and (Operation = opRemove) then
    FRequiredLabel := nil;
end;

procedure TmrLookupCombo.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

procedure TmrLookupCombo.CMEnabledchanged(var Message: TMessage);
begin
  FEditLabel.Enabled := Enabled;
  FRequiredLabel.Enabled := Enabled;
end;

procedure TmrLookupCombo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TmrLookupCombo.CMVisiblechanged(var Message: TMessage);
begin
  FEditLabel.Visible := Visible;
  FRequiredLabel.Visible := Visible;
  if Visible and Required then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrLookupCombo.SetInternalButtons;
begin
  Properties.Buttons.Add;
  Properties.Buttons[1].Kind := bkEllipsis;
end;

procedure TmrLookupCombo.SetInternalPopup;

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
    CreateMenuItem('&Novo...');
    CreateMenuItem('&Abrir...');
    CreateMenuItem('&Excluir...');
    CreateMenuItem('-');
    CreateMenuItem('Limpar');
  end;
end;

procedure TmrLookupCombo.PopupClick(Sender: TObject);
begin
  case TMenuItem(Sender).MenuIndex of
    0: InsertRecord;
    1: OpenRecord;
    2: if MsgBox('Confirma a remoção de [' + Text + '] ?', vbQuestion + vbYesNo) = mrYes then
         DeleteRecord;
    4: ClearValue;
  end;
end;

procedure TmrLookupCombo.DoButtonUp(Index: Integer);
var
  CursorPos: TPoint;
begin
  if (Index = 1) then
  begin
    SetCommandButtons;
    GetCursorPos(CursorPos);
    FPopupMenuButton.Popup(CursorPos.X, CursorPos.Y);
  end;
  // obsolete FOnEditButtonClick
  EditButtonClick;
end;

procedure TmrLookupCombo.SetCommandButtons;
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

procedure TmrLookupCombo.InsertRecord(AParams: String);
var
  NewSession: TmrSession;
  NewDataSet: TClientDataSet;
  Records, NewKey: Integer;
begin
  NewSession := nil;
  with TParentCustomFch(CreateForm(Self, FchClassName)) do
    try
      NewSession := DataSetControl.CreateSession;
      NewDataSet := NewSession.CreateDataSet(ConnectionSourceName, ProviderSourceName);
      NewDataSet.Open;
      Records := NewDataSet.RecordCount;
      Init(TraceControl, DataSetControl, UpdateControl, NewSession, NewDataSet, Self.FSystemUser);
      Append;
      ShowFch;
      NewKey := NewDataSet.FieldByName(Properties.KeyFieldNames).AsInteger;
      if NewDataSet.RecordCount > Records then
        SetDBValues(NewDataSet);
    finally
      Free;
      OpenListSource;
      if NewDataSet.RecordCount > Records then
        SetEditValue(NewKey);
      NewSession.Terminate;
    end;
end;

procedure TmrLookupCombo.OpenRecord(AParams: String);
var
  NewSession: TmrSession;
  NewDataSet: TClientDataSet;
  ChangedKey: Integer;
begin
  NewSession := nil;
  with TParentCustomFch(CreateForm(Self, FchClassName)) do
    try
      NewSession := DataSetControl.CreateSession;
      NewDataSet := NewSession.CreateDataSet(ConnectionSourceName, ProviderSourceName);
      NewDataSet.BeforeGetRecords := DoBeforeGetRecordsSource;
      NewDataSet.Open;
      Init(TraceControl, DataSetControl, UpdateControl, NewSession, NewDataSet, Self.FSystemUser);
      Open(AParams);
      ShowFch;
      ChangedKey := EditValue;
    finally
      Free;
      NewSession.Terminate;
      OpenListSource;
      SetEditValue(ChangedKey);
    end;
end;

procedure TmrLookupCombo.DeleteRecord;
begin
  with DataSetList do
    try
      if Locate(Properties.KeyFieldNames, EditValue, []) then
      begin
        Delete;
        ApplyUpdates(0);
      end;
    finally
      ClearValue;
      OpenListSource;
    end;
end;

procedure TmrLookupCombo.SetConfigFch;
begin
  FFchClassName := UpperCase(DataSetList.GetOptionalParam('FchClassName'));
  FConnectionSourceName := UpperCase(DataSetList.GetOptionalParam('ConnectionSourceName'));
  FProviderSourceName := UpperCase(DataSetList.GetOptionalParam('ProviderSourceName'));
end;

procedure TmrLookupCombo.ClearValue;
begin
  Self.Clear;
end;

procedure TmrLookupCombo.SetDBValues(DataSet: TDataSet);
begin
  // para ser herdado
end;

{ TmrDBLookupCombo }

procedure TmrDBLookupCombo.ClearValue;
begin
  inherited;
  if DataBinding <> nil then
  begin
    DataBinding.DataSource.DataSet.Edit;
    DataBinding.DataSource.DataSet.FieldByName(DataBinding.DataField).Clear;
  end;
end;

procedure TmrDBLookupCombo.CMGetDataLink(var Message: TMessage);
begin
  if not IsInplace then
    Message.Result := Integer(TcxDBEditDataBinding(DataBinding).DataLink);
end;

function TmrDBLookupCombo.GetDataBinding: TcxDBTextEditDataBinding;
begin
  Result := TcxDBTextEditDataBinding(FDataBinding);
end;

class function TmrDBLookupCombo.GetDataBindingClass: TcxEditDataBindingClass;
begin
  Result := TcxDBEditDataBinding;
end;

procedure TmrDBLookupCombo.SetDataBinding(Value: TcxDBTextEditDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TmrDBLookupCombo.SetDBValues(DataSet: TDataSet);
begin
  if DataBinding <> nil then
  begin
    DataBinding.DataSource.Edit;
    DataBinding.DataLink.Field.Value := DataSet.FieldByName(Properties.KeyFieldNames).AsString;
  end;
end;

end.
