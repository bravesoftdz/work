unit mrDBComboBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, ExtCtrls, DBCtrls, mrBoundLabel,
  Types, Graphics, Messages, cxDBEdit;

type
  TmrDBComboBox = class(TcxDBComboBox)
  private
    FMyDataLink: TFieldDataLink;
    FEditLabel: TmrBoundLabel;
    FRequiredLabel: TmrBoundLabel;
    FLocked: Boolean;
    FRequired: Boolean;
    FLabelSpacing: Integer;
    FLabelPosition: TLabelPosition;
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetLocked(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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

procedure Register;
begin
  RegisterComponents('MultiTierDataControls', [TmrDBComboBox]);
end;

{ TmrDBComboBox }

procedure TmrDBComboBox.CMBidimodechanged(var Message: TMessage);
begin
  FEditLabel.BiDiMode := BiDiMode;
  FRequiredLabel.BiDiMode := BiDiMode;
end;

procedure TmrDBComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
  if (AComponent = FRequiredLabel) and (Operation = opRemove) then
    FRequiredLabel := nil;
end;

procedure TmrDBComboBox.CMEnabledchanged(var Message: TMessage);
begin
  FEditLabel.Enabled := Enabled;
  FRequiredLabel.Enabled := Enabled;
end;

procedure TmrDBComboBox.CMVisiblechanged(var Message: TMessage);
begin
  FEditLabel.Visible := Visible;
  FRequiredLabel.Visible := Visible;
  if Visible and Required then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;
end;

procedure TmrDBComboBox.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TmrDBComboBox.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
  Properties.ReadOnly := Value;
  ParentColor := Value;
  if not Value then
    Color := clWindow;
end;

procedure TmrDBComboBox.SetName(const Value: TComponentName);
begin
  inherited;
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TmrDBComboBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

procedure TmrDBComboBox.SetRequired(const Value: Boolean);
begin
  FRequired := Value;
  if Value then
    FRequiredLabel.Parent := Self.Parent
  else
    FRequiredLabel.Parent := nil;

  if Assigned(FMyDataLink.Field) then
    Required := FMyDataLink.Field.Required;
end;

constructor TmrDBComboBox.Create(AOwner: TComponent);
begin
  FMyDataLink := TFieldDataLink.Create;
  FMyDataLink.Control := Self;
  inherited Create(AOwner);
  FLabelPosition := lpLeft;
  FLabelSpacing := 6;
  SetupInternalLabel;
end;

procedure TmrDBComboBox.SetLabelPosition(const Value: TLabelPosition);
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

procedure TmrDBComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);

  if Assigned(FMyDataLink.Field) then
    Required := FMyDataLink.Field.Required;

end;

procedure TmrDBComboBox.SetupInternalLabel;
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

destructor TmrDBComboBox.Destroy;
begin
  FMyDataLink.Free;
  inherited Destroy;
end;

end.