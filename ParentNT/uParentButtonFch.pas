unit uParentButtonFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentCustomFch, DB, StdCtrls, ExtCtrls, uSystemTypes,
  mrConfigFch, XiButton, ImgList, mrDBEdit, mrDBCurrencyEdit, mrSuperCombo,
  mrDBMemo, mrDBDateEdit, mrDBCheckBox, mrDBImageComboBox;

type
  TParentButtonFch = class(TParentCustomFch)
    pnlBottom: TPanel;
    btnOk: TXiButton;
    btnCancel: TXiButton;
    btnFirst: TXiButton;
    btnPrior: TXiButton;
    btnNext: TXiButton;
    btnLast: TXiButton;
    procedure ConfigFchAfterStart(Sender: TObject);
  protected
    procedure ConfigButtons(aActionType: TActionType); override;
    procedure ConfigNavigation(aCanPrior, aCanNext: Boolean); override;
    procedure SetPageControl(PageIndex: Integer); override;
    procedure RestrictForm; override;
  end;

implementation

{$R *.dfm}

{ TParentButtonFch }

procedure TParentButtonFch.ConfigButtons(aActionType: TActionType);
begin

end;

procedure TParentButtonFch.ConfigNavigation(aCanPrior, aCanNext: Boolean);
var
  bVisible : boolean;
begin

  bVisible := not ((ConfigFch.Connection <> '') or (ActionType = atAppend));

  btnFirst.Visible := bVisible;
  btnPrior.Visible := bVisible;
  btnNext.Visible  := bVisible;
  btnLast.Visible  := bVisible;

end;

procedure TParentButtonFch.SetPageControl(PageIndex: Integer);
begin

end;

procedure TParentButtonFch.ConfigFchAfterStart(Sender: TObject);
begin
  inherited;
  pnlTitulo.Caption := '   ' + Self.Caption;
end;

procedure TParentButtonFch.RestrictForm;
var
  i : Integer;
begin
  inherited;
  btnOk.Enabled := False;
  btnOk.Visible := False;

  with DataSet do
    for i:=0 to FieldCount-1 do
       Fields.Fields[i].ReadOnly := True;

  for i := 0 to (ComponentCount -1) do
  begin
    if Components[I] is TmrDBEdit then
       TmrDBEdit(Components[I]).Locked := True
    else if Components[I] is TmrDBCurrencyEdit then
       TmrDBCurrencyEdit(Components[I]).Locked := True
    else if Components[I] is TmrDBSuperCombo then
       TmrDBSuperCombo(Components[I]).Locked := True
    else if Components[I] is TmrSuperCombo then
       TmrSuperCombo(Components[I]).Locked := True
    else if Components[I] is TmrDBMemo then
       TmrDBMemo(Components[I]).Locked := True
    else if Components[I] is TmrDBDateEdit then
       TmrDBDateEdit(Components[I]).Locked := True
    else if Components[I] is TmrDBCheckBox then
       TmrDBCheckBox(Components[I]).Locked := True
    else if Components[I] is TmrDBImageComboBox then
       TmrDBImageComboBox(Components[I]).Locked := True;
  end;

end;

end.
