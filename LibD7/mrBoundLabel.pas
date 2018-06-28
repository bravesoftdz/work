unit mrBoundLabel;

interface

uses ExtCtrls, Classes;

type
  TmrBoundLabel = class(TBoundLabel)
  protected
    procedure AdjustBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses mrDBEdit, mrDBMemo, mrDBComboBox;

{ TawBoundLabel }

procedure TmrBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Owner is TmrDBEdit then
    TmrDBEdit(Owner).SetLabelPosition(TmrDBEdit(Owner).LabelPosition)
  else if Owner is TmrDBMemo then
    TmrDBMemo(Owner).SetLabelPosition(TmrDBMemo(Owner).LabelPosition)
  else if Owner is TmrDBComboBox then
    TmrDBComboBox(Owner).SetLabelPosition(TmrDBComboBox(Owner).LabelPosition);
end;

constructor TmrBoundLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
