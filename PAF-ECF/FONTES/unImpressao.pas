unit unImpressao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmImpressao = class(TForm)
    memEditor: TMemo;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImpressao: TfrmImpressao;

implementation

{$R *.dfm}

procedure TfrmImpressao.btnOkClick(Sender: TObject);
begin
  Close;
end;

end.
