unit uRepConfigFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, dximctrl, siComp, Printers;

type
  TRepConfigFrm = class(TForm)
    edtPath: TEdit;
    sbOpenBKP: TSpeedButton;
    Label2: TLabel;
    OD: TOpenDialog;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edtLogoPath: TEdit;
    btnLogo: TSpeedButton;
    Bevel1: TBevel;
    Label3: TLabel;
    cbxWebDownload: TComboBox;
    Label4: TLabel;
    cbxLanguage: TdxImageComboBox;
    siLang: TsiLang;
    Label5: TLabel;
    cmbPrinter: TComboBox;
    procedure sbOpenBKPClick(Sender: TObject);
    procedure btnLogoClick(Sender: TObject);
    procedure cbxLanguageChange(Sender: TObject);
  public
    function Start: Boolean;
  end;

implementation

uses uDMReport, uDMGlobalNTier;

{$R *.dfm}

procedure TRepConfigFrm.sbOpenBKPClick(Sender: TObject);
var
  sFile : String;
begin
  if OD.Execute then
  begin
    sFile := LowerCase(OD.FileName);
    edtPath.Text := sFile;
  end;
end;

function TRepConfigFrm.Start: Boolean;
var
  sPrinterList : String;
begin
  edtPath.Text          := DMReport.GetAppProperty('Default', 'ReportPath');
  edtLogoPath.Text      := DMReport.GetAppProperty('Default', 'LogoPath');
  cbxWebDownload.Text   := DMReport.GetAppProperty('Default', 'UpdateFile');
  cbxLanguage.ItemIndex := StrToIntDef(DMReport.GetAppProperty('Default', 'IDLanguage'),0);
  cmbPrinter.Items      := Printer.Printers;
  cmbPrinter.Text       := DMReport.GetAppProperty('Settings', 'Printer');

  ShowModal;
  Result := (ModalResult = mrOK);

  if Result then
  begin
    DMReport.SetAppProperty('Default', 'ReportPath', edtPath.Text);
    DMReport.SetAppProperty('Default', 'LogoPath', edtLogoPath.Text);
    DMReport.SetAppProperty('Default', 'UpdateFile', cbxWebDownload.Text);
    DMReport.SetAppProperty('Default', 'IDLanguage', IntToStr(cbxLanguage.ItemIndex));
    DMReport.SetAppProperty('Settings', 'ImageDir', 'Image\');
    DMReport.SetAppProperty('Settings', 'Printer', cmbPrinter.Text);
    sPrinterList := cmbPrinter.Items.CommaText;
    DMReport.SetAppProperty('Settings', 'PrinterList', sPrinterList);
  end;
end;

procedure TRepConfigFrm.btnLogoClick(Sender: TObject);
var
  sFile : String;
begin
  if OD.Execute then
  begin
    sFile := LowerCase(OD.FileName);
    edtLogoPath.Text := sFile;
  end;
end;

procedure TRepConfigFrm.cbxLanguageChange(Sender: TObject);
begin
  case cbxLanguage.ItemIndex of
    0 : cbxWebDownload.ItemIndex := 1; //English
    1 : cbxWebDownload.ItemIndex := 0; //Portugues
    2 : cbxWebDownload.ItemIndex := 1; //Espanhol
  end;
end;

end.
