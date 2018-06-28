unit UDExportWord;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeWordDlg = class(TForm)
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
  CrpeWordDlg: TCrpeWordDlg;

implementation

{$R *.DFM}

uses SysUtils, UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWordDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWordDlg.FormShow(Sender: TObject);
begin
  cbPrompt.Checked := Cr.ExportOptions.Word.Prompt;
  cbUsePageRange.Checked := Cr.ExportOptions.Word.UsePageRange;
  editFirstPage.Text := IntToStr(Cr.ExportOptions.Word.FirstPage);
  editLastPage.Text := IntToStr(Cr.ExportOptions.Word.LastPage);
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
procedure TCrpeWordDlg.cbPromptClick(Sender: TObject);
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
procedure TCrpeWordDlg.cbUsePageRangeClick(Sender: TObject);
begin
  editFirstPage.Enabled := cbUsePageRange.Checked;
  editLastPage.Enabled := cbUsePageRange.Checked;
  editFirstPage.Color := ColorState(cbUsePageRange.Checked);
  editLastPage.Color := ColorState(cbUsePageRange.Checked);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWordDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.Word.Prompt := cbPrompt.Checked;
  Cr.ExportOptions.Word.UsePageRange := cbUsePageRange.Checked;
  if IsNumeric(editFirstPage.Text) then
    Cr.ExportOptions.Word.FirstPage := StrToInt(editFirstPage.Text);
  if IsNumeric(editLastPage.Text) then
    Cr.ExportOptions.Word.LastPage := StrToInt(editLastPage.Text);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWordDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWordDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
