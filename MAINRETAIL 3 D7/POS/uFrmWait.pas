unit uFrmWait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmWait = class(TForm)
    lbWait: TLabel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
  end;

implementation

{$R *.dfm}

procedure TFrmWait.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  Self.Visible := True;
end;

end.
