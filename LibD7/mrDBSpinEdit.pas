unit mrDBSpinEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, mrBoundLabel,
  Types, Graphics, Messages, cxDBEdit, cxSpinEdit;
type
  TmrDBSpinEdit = class(TcxDBSpinEdit)
  private
    FEditLabel: TmrBoundLabel;
    FRequiredLabel: TmrBoundLabel;
    FLocked: Boolean;
    FRequired: Boolean;
    FLabelSpacing: Integer;
    FLabelPosition: TLabelPosition;
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetLocked(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
    procedure GetFieldConfig;
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetupInternalLabel;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  published
    property EditLabel: TmrBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
    property Required: Boolean read FRequired write SetRequired;
    property Locked: Boolean read FLocked write SetLocked;
  end;

procedure Register;

implementation

uses DB;

procedure Register;
begin
  RegisterComponents('MultiTierDataControls', [TmrDBSpinEdit]);
end;

{ TcxDBSpinEdit }

procedure TmrDBSpinEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.BiDiMode := BiDiMode;
  FRequiredLabel.BiDiMode := BiDiMode;
end;

procedure TmrDBSpinEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Enabled := Enabled;
  FRequiredLabel.Enabled := Enabled;
end;

procedure TmrDBSpinEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Visible := Visible;
  FRequiredLabel.Visible := Visible;
  if Visible and Required then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

constructor TmrDBSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpLeft;
  FLabelSpacing := 6;
  SetupInternalLabel;
end;

procedure TmrDBSpinEdit.GetFieldConfig;
begin
  if Assigned(DataBinding.DataLink.Field) then
  begin
    FEditLabel.Caption := DataBinding.DataLink.Field.DisplayLabel;
    Required := DataBinding.DataLink.Field.Required;
    Locked := DataBinding.DataLink.Field.ReadOnly;
  end;
end;

procedure TmrDBSpinEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
  if (AComponent = FRequiredLabel) and (Operation = opRemove) then
    FRequiredLabel := nil;
end;

procedure TmrDBSpinEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
  GetFieldConfig;
end;

procedure TmrDBSpinEdit.SetLabelPosition(const Value: TLabelPosition);
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

procedure TmrDBSpinEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TmrDBSpinEdit.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
  Properties.ReadOnly := Value;
  ParentColor := Value;
  if not Value then
    Color := clWindow;
end;

procedure TmrDBSpinEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TmrDBSpinEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

procedure TmrDBSpinEdit.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if Value then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;

  if Assigned(DataBinding.DataLink.Field) then
    DataBinding.DataLink.Field.Required := Value;
end;

procedure TmrDBSpinEdit.SetupInternalLabel;
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

end.
