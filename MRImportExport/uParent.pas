unit uParent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, siComp;

type
  TFrmParent = class(TForm)
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal;

{$R *.dfm}

procedure TFrmParent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

end.
