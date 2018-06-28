unit dxDBDateEdit;

interface

uses
  Messages, Classes, Controls, dxDateEdit, DB, DBCtrls;

type
  TdxDBDateEdit = class(TCustomdxDateEdit)
  private
    FDataLink: TFieldDataLink;

    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);

    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);

    procedure WMClear(var Message: TMessage); message WM_CLEAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure DoDateChanged; override;
    function DoEditCanModify: Boolean; virtual;
    function GetShowClearButton: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property ShowTodayButton;
    property ShowClearButton;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property OnDateChanged;
  end;

implementation

uses
  Windows;

{ TdxDBDateEdit }

constructor TdxDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TdxDBDateEdit.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

function TdxDBDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TdxDBDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TdxDBDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TdxDBDateEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TdxDBDateEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TdxDBDateEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsNull then
      Text := ''
    else
      Text := GetDateText(DateOf(FDataLink.Field.AsDateTime))
  else
    if csDesigning in ComponentState then Text := Name
    else Text := '';
end;

procedure TdxDBDateEdit.UpdateData(Sender: TObject);
begin
  if Date = NullDate then FDataLink.Field.Clear
  else
    with FDataLink.Field do
      AsDateTime := Date + TimeOf(AsDateTime);
end;

procedure TdxDBDateEdit.WMClear(var Message: TMessage);
begin
  DoEditCanModify;
  inherited;
end;

procedure TdxDBDateEdit.WMCut(var Message: TMessage);
begin
  DoEditCanModify;
  inherited;
end;

procedure TdxDBDateEdit.WMPaste(var Message: TMessage);
begin
  DoEditCanModify;
  inherited;
end;

procedure TdxDBDateEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TdxDBDateEdit.CMGetDatalink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TdxDBDateEdit.DoDateChanged;
var
  PrevText: string;
begin
  if FDataLink.Field <> nil then
  begin
    PrevText := Text;
    if FDataLink.CanModify then
    begin
      try
        FDataLink.Edit;
      except
        DataChange(nil);
        raise;
      end;
      if not FDataLink.Editing then DataChange(nil)
      else
      begin
        Text := PrevText;
        FDataLink.Modified;
      end;
    end
    else DataChange(nil);
  end;
  inherited DoDateChanged;
end;

function TdxDBDateEdit.DoEditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
  if Result then FDataLink.Modified;
end;

function TdxDBDateEdit.GetShowClearButton: Boolean;
begin
  Result := inherited GetShowClearButton and
    ((FDataLink.Field = nil) or not FDataLink.Field.Required);
end;

procedure TdxDBDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then DoEditCanModify;
  inherited KeyDown(Key, Shift);
end;

procedure TdxDBDateEdit.KeyPress(var Key: Char);
begin
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    #8, #32..#255:
      DoEditCanModify;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

procedure TdxDBDateEdit.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then DataChange(Self);
end;

procedure TdxDBDateEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

end.
