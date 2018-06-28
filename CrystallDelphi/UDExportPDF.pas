unit UDExportPDF;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeAdobeAcrobatPDFDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlPDF: TPanel;
    pnlPageRange: TPanel;
    cbUsePageRange: TCheckBox;
    lblFirstPage: TLabel;
    editFirstPage: TEdit;
    lblLastPage: TLabel;
    editLastPage: TEdit;
    cbPrompt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbUsePageRangeClick(Sender: TObject);
    procedure cbPromptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeAdobeAcrobatPDFDlg: TCrpeAdobeAcrobatPDFDlg;

implementation

{$R *.DFM}

uses SysUtils, UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.FormShow(Sender: TObject);
var
  OnOff : Boolean;
begin
  cbPrompt.Checked := Cr.ExportOptions.PDF.Prompt;
  cbUsePageRange.Checked := Cr.ExportOptions.PDF.UsePageRange;
  editFirstPage.Text := IntToStr(Cr.ExportOptions.PDF.FirstPage);
  editLastPage.Text := IntToStr(Cr.ExportOptions.PDF.LastPage);
  editFirstPage.Enabled := cbUsePageRange.Checked;
  editLastPage.Enabled := cbUsePageRange.Checked;
  editFirstPage.Color := ColorState(cbUsePageRange.Checked);
  editLastPage.Color := ColorState(cbUsePageRange.Checked);
  {Activate/Deactivate controls}
  OnOff := not cbPrompt.Checked;
  cbUsePageRange.Enabled := OnOff;
  if OnOff then OnOff := cbUsePageRange.Checked;
  editFirstPage.Enabled := OnOff;
  editLastPage.Enabled := OnOff;
  editFirstPage.Color := ColorState(OnOff);
  editLastPage.Color := ColorState(OnOff);
end;
{------------------------------------------------------------------------------}
{ cbPromptClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.cbPromptClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  {Activate/Deactivate controls}
  OnOff := not cbPrompt.Checked;
  cbUsePageRange.Enabled := OnOff;
  if OnOff then OnOff := cbUsePageRange.Checked;
  editFirstPage.Enabled := OnOff;
  editLastPage.Enabled := OnOff;
  editFirstPage.Color := ColorState(OnOff);
  editLastPage.Color := ColorState(OnOff);
end;
{------------------------------------------------------------------------------}
{ cbUsePageRangeClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.cbUsePageRangeClick(Sender: TObject);
begin
  editFirstPage.Enabled := cbUsePageRange.Checked;
  editLastPage.Enabled := cbUsePageRange.Checked;
  editFirstPage.Color := ColorState(cbUsePageRange.Checked);
  editLastPage.Color := ColorState(cbUsePageRange.Checked);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.PDF.Prompt := cbPrompt.Checked;
  Cr.ExportOptions.PDF.UsePageRange := cbUsePageRange.Checked;
  if IsNumeric(editFirstPage.Text) then
    Cr.ExportOptions.PDF.FirstPage := StrToInt(editFirstPage.Text);
  if IsNumeric(editLastPage.Text) then
    Cr.ExportOptions.PDF.LastPage := StrToInt(editLastPage.Text);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeAdobeAcrobatPDFDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
