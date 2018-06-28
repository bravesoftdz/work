unit uFrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, StdCtrls, cxButtons, ExtCtrls, Buttons;

type
  TFrmConfig = class(TForm)
    Panel1: TPanel;
    btnOk: TcxButton;
    Label1: TLabel;
    edtPath: TcxTextEdit;
    OpenDialog: TOpenDialog;
    SpeedButton: TSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
  end;

implementation

uses uFrmMain;

{$R *.dfm}

procedure TFrmConfig.btnOkClick(Sender: TObject);
begin
  FrmMain.SetAppProperty('Default', 'FilePath', edtPath.Text);
  Close;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  edtPath.Text := FrmMain.GetAppProperty('Default', 'FilePath');
end;

procedure TFrmConfig.SpeedButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtPath.Text := OpenDialog.FileName;
end;

end.
