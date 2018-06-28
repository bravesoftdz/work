unit TreeItemBrowseConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig;

type
  TTreeItemBrowseConfig = class(TBrowseConfig)
  private
    { Private declarations }
    FTituloTodosItens : String;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property TituloTodosItens     : String  read FTituloTodosItens write FTituloTodosItens;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TTreeItemBrowseConfig]);
end;

end.
