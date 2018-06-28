unit uFrmMsgTEF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmMsgTEF = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMsgTEF: TFrmMsgTEF;

implementation

{$R *.dfm}

procedure TFrmMsgTEF.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
end;

end.
