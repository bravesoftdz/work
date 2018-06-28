unit PaideFichaTab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, ComCtrls, FormConfig, Db, DBTables,
  LblEffct, ExtCtrls, StdCtrls, Buttons, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmTabParent = class(TbrwFrmParent)
    PageControl: TPageControl;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal;

{$R *.DFM}

procedure TbrwFrmTabParent.FormShow(Sender: TObject);
begin
  inherited;
  // ** Se o PageControl possuir mais de um Tab, dá o foco para o primeiro tab
  if PageControl.PageCount > 0 then
     PageControl.ActivePage := PageControl.Pages[0];
end;


end.
