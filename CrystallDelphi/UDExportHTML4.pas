unit UDExportHTML4;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeHTML4Dlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlHTML4: TPanel;
    cbPageNavigator: TCheckBox;
    cbSeparatePages: TCheckBox;
    gbPageRange: TGroupBox;
    rbAllPages: TRadioButton;
    rbFirstPage: TRadioButton;
    editFirstPage: TEdit;
    lblLastPage: TLabel;
    editLastPage: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbAllPagesClick(Sender: TObject);
    procedure rbFirstPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeHTML4Dlg: TCrpeHTML4Dlg;

implementation

{$R *.DFM}

uses SysUtils, UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.FormShow(Sender: TObject);
begin
  cbPageNavigator.Checked := Cr.ExportOptions.HTML.PageNavigator;
  cbSeparatePages.Checked := Cr.ExportOptions.HTML.SeparatePages;
  editFirstPage.Text := IntToStr(Cr.ExportOptions.HTML.FirstPage);
  editLastPage.Text := IntToStr(Cr.ExportOptions.HTML.LastPage);
  if Cr.ExportOptions.HTML.UsePageRange then
  begin
    rbFirstPage.Checked := True;
    rbFirstPageClick(Self);
  end
  else
  begin
    rbAllPages.Checked := True;
    rbAllPagesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ rbAllPagesClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.rbAllPagesClick(Sender: TObject);
begin
  editFirstPage.Enabled := False;
  editLastPage.Enabled := False;
  editFirstPage.Color := ColorState(False);
  editLastPage.Color := ColorState(False);
end;
{------------------------------------------------------------------------------}
{ rbFirstPageClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.rbFirstPageClick(Sender: TObject);
begin
  editFirstPage.Enabled := True;
  editLastPage.Enabled := True;
  editFirstPage.Color := ColorState(True);
  editLastPage.Color := ColorState(True);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.HTML.PageNavigator := cbPageNavigator.Checked;
  Cr.ExportOptions.HTML.SeparatePages := cbSeparatePages.Checked;
  Cr.ExportOptions.HTML.FirstPage := CrStrToInteger(editFirstPage.Text);
  Cr.ExportOptions.HTML.LastPage := CrStrToInteger(editLastPage.Text);
  Cr.ExportOptions.HTML.UsePageRange := (rbFirstPage.Checked);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeHTML4Dlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
