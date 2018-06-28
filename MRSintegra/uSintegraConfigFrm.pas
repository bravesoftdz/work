unit uSintegraConfigFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxTextEdit, cxControls,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxButtons, ExtCtrls, DB, cxButtonEdit,
  ComCtrls, dxCntner, dxExEdtr, dxEdLib;

type
  TSintegraConfigFrm = class(TForm)
    pnlBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    odgFilePath: TOpenDialog;
    Label5: TLabel;
    Label22: TLabel;
    edtFilePath: TcxButtonEdit;
    edtValidator: TcxButtonEdit;
    Label12: TLabel;
    luCompany: TcxLookupComboBox;
    Label24: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtTED: TcxButtonEdit;
    procedure btnOkClick(Sender: TObject);
    procedure edtFilePathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtValidatorPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtTEDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    procedure LoadConfig;
    procedure SaveConfig;
  public
    procedure Start;
  end;

implementation

uses uDMSintegra;

{$R *.dfm}

{ TSintegraConfigFrm }

procedure TSintegraConfigFrm.LoadConfig;
var
  sIDEmpresa: String;
begin
  sIDEmpresa := DMSintegra.GetAppProperty('Settings', 'IDEmpresa');
  if sIDEmpresa <> '' then
    luCompany.EditValue := sIDEmpresa;

  edtFilePath.Text := DMSintegra.GetAppProperty('Settings', 'SintegraFileName');
  edtValidator.Text := DMSintegra.GetAppProperty('Settings', 'ValidadorPath');
  edtTED.Text := DMSintegra.GetAppProperty('Settings', 'TEDPath');
end;

procedure TSintegraConfigFrm.SaveConfig;
begin
  DMSintegra.SetAppProperty('Settings', 'IDEmpresa', luCompany.EditValue);
  DMSintegra.SetAppProperty('Settings', 'SintegraFileName', edtFilePath.Text);
  DMSintegra.SetAppProperty('Settings', 'ValidadorPath', edtValidator.Text);
  DMSintegra.SetAppProperty('Settings', 'TEDPath', edtTED.Text);
end;

procedure TSintegraConfigFrm.Start;
begin
  with DMSintegra do
  begin
    if qryLuEmpresa.Active then
      qryLuEmpresa.Close;
    qryLuEmpresa.Open;
  end;

  LoadConfig;
  ShowModal;

  DMSintegra.qryLuEmpresa.Close
end;

procedure TSintegraConfigFrm.btnOkClick(Sender: TObject);
begin
  SaveConfig;
end;

procedure TSintegraConfigFrm.edtFilePathPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if odgFilePath.Execute then
    edtFilePath.Text := odgFilePath.FileName;
end;

procedure TSintegraConfigFrm.edtValidatorPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if odgFilePath.Execute then
    edtValidator.Text := odgFilePath.FileName;
end;

procedure TSintegraConfigFrm.edtTEDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if odgFilePath.Execute then
    edtTED.Text := odgFilePath.FileName;
end;

end.
