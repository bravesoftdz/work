unit UDExportRTF;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeRichTextFormatDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlPDF: TPanel;
    pnlPageRange: TPanel;
    lblFirstPage: TLabel;
    lblLastPage: TLabel;
    cbUsePageRange: TCheckBox;
    editFirstPage: TEdit;
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
  CrpeRichTextFormatDlg: TCrpeRichTextFormatDlg;

implementation

{$R *.DFM}

uses SysUtils, UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.FormShow(Sender: TObject);
begin
  cbPrompt.Checked := Cr.ExportOptions.RTF.Prompt;
  cbUsePageRange.Checked := Cr.ExportOptions.RTF.UsePageRange;
  editFirstPage.Text := IntToStr(Cr.ExportOptions.RTF.FirstPage);
  editLastPage.Text := IntToStr(Cr.ExportOptions.RTF.LastPage);
  editFirstPage.Enabled := cbUsePageRange.Checked;
  editLastPage.Enabled := cbUsePageRange.Checked;
  editFirstPage.Color := ColorState(cbUsePageRange.Checked);
  editLastPage.Color := ColorState(cbUsePageRange.Checked);
  {Activate/Deactivate controls}
  cbPromptClick(Self);
  cbUsePageRangeClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbPromptClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.cbPromptClick(Sender: TObject);
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
procedure TCrpeRichTextFormatDlg.cbUsePageRangeClick(Sender: TObject);
begin
  editFirstPage.Enabled := cbUsePageRange.Checked;
  editLastPage.Enabled := cbUsePageRange.Checked;
  editFirstPage.Color := ColorState(cbUsePageRange.Checked);
  editLastPage.Color := ColorState(cbUsePageRange.Checked);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.RTF.Prompt := cbPrompt.Checked;
  Cr.ExportOptions.RTF.UsePageRange := cbUsePageRange.Checked;
  if IsNumeric(editFirstPage.Text) then
    Cr.ExportOptions.RTF.FirstPage := StrToInt(editFirstPage.Text);
  if IsNumeric(editLastPage.Text) then
    Cr.ExportOptions.RTF.LastPage := StrToInt(editLastPage.Text);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeRichTextFormatDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
