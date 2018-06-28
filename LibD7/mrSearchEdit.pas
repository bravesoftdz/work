unit mrSearchEdit;

interface

uses
  Windows, SysUtils, Classes, Graphics, Messages, cxButtonEdit, mrBoundLabel,
  ExtCtrls, Controls, Types, Menus, StdCtrls, cxEdit;

type
  TmrSearchEdit = class(TcxButtonEdit)
  private
    FEditLabel: TmrBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    FRequiredLabel: TmrBoundLabel;
    FPopupMenuButton: TPopupMenu;
    FRequired: Boolean;
    FLocked: Boolean;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetInternalButton;
    procedure SetInternalPopup;
    procedure SetupInternalLabel;
    procedure SetCommandButtons;
    procedure MyOnButtonClick(Sender: TObject; AbsoluteIndex: Integer);
    procedure SetRequired(const Value: Boolean);
    procedure PopupClick(Sender: TObject);
    procedure SearchRecord;
    procedure OpenRecord;
    procedure ClearValue;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMExit(var Message: TCMExit);
    procedure SetParent(AParent: TWinControl); override;
    procedure DoButtonUp(Index: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    property Required: Boolean read FRequired write SetRequired;
    property Locked: Boolean read FLocked write FLocked;
  published
    property EditLabel: TmrBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
  end;

  TmrDBSearchEdit = class(TmrSearchEdit)
  end;

procedure Register;

implementation

uses mrSearchEditFrm;

procedure Register;
begin
  RegisterComponents('MultiTierDataControls', [TmrSearchEdit]);
  RegisterComponents('MultiTierDataControls', [TmrDBSearchEdit]);
end;

{ TmrSearchEdit }

procedure TmrSearchEdit.ClearValue;
begin

end;

procedure TmrSearchEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  // TODO
  //FKeyFieldValue := DataSource.DataSet.FieldByName(FKeyField).AsString;
end;

procedure TmrSearchEdit.CMBidimodechanged(var Message: TMessage);
begin
  FEditLabel.BiDiMode := BiDiMode;
  FRequiredLabel.BiDiMode := BiDiMode;
end;

procedure TmrSearchEdit.CMExit(var Message: TCMExit);
begin
  // TODO
  //SetKeyField;
end;

procedure TmrSearchEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Enabled := Enabled;
  FRequiredLabel.Enabled := Enabled;
end;

procedure TmrSearchEdit.CMVisiblechanged(var Message: TMessage);
begin
  FEditLabel.Visible := Visible;
  FRequiredLabel.Visible := Visible;
  if Visible and Required then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

constructor TmrSearchEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetInternalButton;
  SetInternalPopup;
  Properties.ReadOnly := True;
  FLabelPosition := lpLeft;
  FLabelSpacing := 6;
  SetupInternalLabel;
  Properties.OnButtonClick := MyOnButtonClick;
end;

destructor TmrSearchEdit.Destroy;
begin
  FPopupMenuButton.Free;
  inherited Destroy;
end;

procedure TmrSearchEdit.MyOnButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  DoButtonUp(AbsoluteIndex);
end;

procedure TmrSearchEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FEditLabel then
      FEditLabel := nil;
    if AComponent = FRequiredLabel then
      FRequiredLabel := nil;
  end;
end;

procedure TmrSearchEdit.OpenRecord;
begin

end;

procedure TmrSearchEdit.PopupClick(Sender: TObject);
begin
  case TMenuItem(Sender).MenuIndex of
    0: OpenRecord;
    2: ClearValue;
  end;
end;

procedure TmrSearchEdit.SetInternalPopup;

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
  if not Assigned(FPopupMenuButton) then
  begin
    FPopupMenuButton := TPopupMenu.Create(Self);
    FPopupMenuButton.Name := 'SubPopupMenu';
    FPopupMenuButton.SetSubComponent(True);
    FPopupMenuButton.FreeNotification(Self);
    CreateMenuItem('&Open...');
    CreateMenuItem('-');
    CreateMenuItem('Clear');
  end;
end;

procedure TmrSearchEdit.SetLabelPosition(const Value: TLabelPosition);
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

procedure TmrSearchEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TmrSearchEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TmrSearchEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

procedure TmrSearchEdit.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if Value then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrSearchEdit.SetupInternalLabel;
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

procedure TmrSearchEdit.DoButtonUp(Index: Integer);
var
  CursorPos: TPoint;
begin
  case Index of
    0:
    if not FLocked then
      SearchRecord;
    1:
    begin
      SetCommandButtons;
      GetCursorPos(CursorPos);
      FPopupMenuButton.Popup(CursorPos.X, CursorPos.Y);
    end;
  end;

  // TODO
  //EditButtonClick;
end;

procedure TmrSearchEdit.SetInternalButton;
begin
  with Properties.Buttons do
  begin
    Add;
    Items[0].Kind := bkGlyph;
    Items[1].Kind := bkEllipsis;
  end;
end;

procedure TmrSearchEdit.SearchRecord;
begin
  with TSearchEditFrm.Create(Self) do
  try
    Init;
    ShowSearch;
  finally
    Free;
  end;
end;

procedure TmrSearchEdit.SetCommandButtons;
begin
  FPopupMenuButton.Items[0].Visible := True;
  FPopupMenuButton.Items[1].Visible := True;
  FPopupMenuButton.Items[2].Visible := True;

  FPopupMenuButton.Items[1].Enabled := True;
  FPopupMenuButton.Items[2].Enabled := not FLocked;
end;

procedure TmrSearchEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

end.
