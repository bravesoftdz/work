unit uFrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, StdCtrls, cxButtons, ExtCtrls;

type
  TFrmConfig = class(TForm)
    Panel1: TPanel;
    btnOk: TcxButton;
    Label1: TLabel;
    edtCodRevendedor: TcxTextEdit;
    edtRevendedor: TcxTextEdit;
    Label2: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;

implementation

uses uFrmMain;

{$R *.dfm}

procedure TFrmConfig.btnOkClick(Sender: TObject);
begin
  FrmPrincipal.SetAppProperty('Default', 'CodigoRevendedor', edtCodRevendedor.Text);
  FrmPrincipal.SetAppProperty('Default', 'NomeRevendedor', edtRevendedor.Text);
  Close;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  edtCodRevendedor.Text := FrmPrincipal.GetAppProperty('Default', 'CodigoRevendedor');
  edtRevendedor.Text := FrmPrincipal.GetAppProperty('Default', 'NomeRevendedor');
end;

end.
