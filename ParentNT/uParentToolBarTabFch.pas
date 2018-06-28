unit uParentToolBarTabFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentToolBarFch, cxControls, cxPC, dxBar, DB, uConfigFch, StdCtrls,
  ExtCtrls, ewSubListPanel;

type
  TParentToolBarTabFch = class(TParentToolBarFch)
    pcFch: TcxPageControl;
    procedure ConfigFchAfterNavigation(Sender: TObject);
  protected
    procedure SetPageControl(PageIndex: Integer); override;
  end;

implementation

{$R *.dfm}

{ TParentToolBarTabFch }

procedure TParentToolBarTabFch.SetPageControl(PageIndex: Integer);
begin
  with pcFch do
    ActivePage := Pages[PageIndex];
end;

procedure TParentToolBarTabFch.ConfigFchAfterNavigation(Sender: TObject);
var
  i: Integer;
  RefreshTab: TcxTabSheet;
begin
  inherited;
  RefreshTab := pcFch.ActivePage;

  for i := 0 to RefreshTab.ControlCount-1 do
    if RefreshTab.Controls[i] is TewSubListPanel then
      TewSubListPanel(RefreshTab.Controls[i]).CreateSubList(Session);
end;

end.
