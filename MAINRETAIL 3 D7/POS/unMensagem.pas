unit unMensagem;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms;

type
  TfrmMensagem = class(TForm)
    lblLinha1: TLabel;
    lblLinha2: TLabel;
    lblLinha3: TLabel;
    lblLinha4: TLabel;
  end;

var
  frmMensagem: TfrmMensagem;

implementation

{$R *.DFM}

end.
