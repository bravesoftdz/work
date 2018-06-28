unit uParentToolBarFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentCustomFch, DB, uConfigFch, ExtCtrls, dxBar, StdCtrls,
  uSystemTypes, mrConfigFch;

type
  TParentToolBarFch = class(TParentCustomFch)
    bmFch: TdxBarManager;
    bbPrint: TdxBarButton;
    bbFirst: TdxBarButton;
    bbPrior: TdxBarButton;
    bbNext: TdxBarButton;
    bbLast: TdxBarButton;
    bbLoop: TdxBarButton;
    pnlBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    btnSave: TButton;
  protected
    procedure ConfigButtons(aActionType: TActionType); override;
    procedure ConfigNavigation(aCanPrior, aCanNext: Boolean); override;
    procedure SetPageControl(PageIndex: Integer); override;
  end;

implementation

{$R *.dfm}

{ TParentToolBarFch }

procedure TParentToolBarFch.ConfigButtons(aActionType: TActionType);
begin
  if aActionType in [atAppend, atEdit] then
  begin
    btnOk.Enabled := True;
    btnCancel.Caption := 'Cancelar';
    btnSave.Enabled := True;
  end
  else
  begin
    btnOk.Enabled := False;
    btnCancel.Caption := 'Fechar';
    btnSave.Enabled := False;
  end;
end;

procedure TParentToolBarFch.ConfigNavigation(aCanPrior, aCanNext: Boolean);
begin
  bbFirst.Enabled := aCanPrior;
  bbPrior.Enabled := aCanPrior;
  bbNext.Enabled := aCanNext;
  bbLast.Enabled := aCanNext;
end;

procedure TParentToolBarFch.SetPageControl(PageIndex: Integer);
begin

end;

end.
