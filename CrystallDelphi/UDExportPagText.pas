unit UDExportPagText;

interface

uses
  SysUtils, Forms, Windows, StdCtrls, Buttons, Controls, Classes,
  ExtCtrls, UCrpe32;

type
  TCrpePagTextDlg = class(TForm)
    panel1: TPanel;
    lblLinesPerPage: TLabel;
    editLinesPerPage: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    editCharPerInch: TEdit;
    lblCharNote: TLabel;
    lblLinesNote: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure editLinesPerPageKeyPress(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpePagTextDlg: TCrpePagTextDlg;
  
implementation

{$R *.DFM}

uses UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.FormShow(Sender: TObject);
begin
  editLinesPerPage.Text := IntToStr(Cr.ExportOptions.Text.LinesPerPage);
  editCharPerInch.Text := IntToStr(Cr.ExportOptions.Text.CharPerInch);
end;
{------------------------------------------------------------------------------}
{ editLinesPerPageKeyPress                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.editLinesPerPageKeyPress(Sender: TObject;
  var Key: Char);
begin
  {Do not allow letters or extended ascii}
  if Ord(Key) in [33..47] then Key := Char(0);
  if Ord(Key) in [58..255] then Key := Char(0);
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.Text.LinesPerPage := CrStrToInteger(editLinesPerPage.Text);
  Cr.ExportOptions.Text.CharPerInch := CrStrToInteger(editCharPerInch.Text);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePagTextDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
