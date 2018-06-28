unit uParentFchTab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, ComCtrls, StdCtrls,  Buttons, ExtCtrls, Db,
  DBTables, FormConfig, dxBar, ImgList, ADODB, PowerADOQuery, siComp,
  siLangRT;

type
  TParentFchTab = class(TParentFch)
    pnlBottomAlign: TPanel;
    pnlLeftSpace: TPanel;
    pnlRightSpace: TPanel;
    PPageControl: TPageControl;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SetPageControl(Pageindex: integer); override;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}



procedure TParentFchTab.FormShow(Sender: TObject);
var
  i: integer;

begin
  inherited;

  with PPageControl do
    if PageCount > 0 then
      begin
        for i := 0 to (PageCount-1) do
          begin
            if Pages[i].TabVisible then
              begin
                ActivePage := Pages[i];
                Break;
              end;
          end;
      end;
end;

procedure TParentFchTab.FormCreate(Sender: TObject);
begin
  inherited;
  // Se tiver um tab só, não mostra o pagecontrol
  if PPageControl.PageCount = 1 then
    begin
      PPageControl.Visible := False;
      PPageControl.Pages[0].Parent := pnlBottomAlign;
    end;

end;

procedure TParentFchTab.FormDestroy(Sender: TObject);
begin
  inherited;
  // Desfaz a mudança do pagecontrol
  if PPageControl.PageCount = 1 then
    begin
      PPageControl.Pages[0].Parent := PPageControl;
    end;

end;

procedure TParentFchTab.SetPageControl(Pageindex: integer);
begin

  with PPageControl do
    ActivePage := Pages[PageIndex];

end;

end.
