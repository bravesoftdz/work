unit UDExportXML;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeXML1Dlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlHTML4: TPanel;
    cbSeparatePages: TCheckBox;
    cbPrompt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbPromptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeXML1Dlg: TCrpeXML1Dlg;

implementation

{$R *.DFM}

uses UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.FormShow(Sender: TObject);
begin
  cbPrompt.Checked := Cr.ExportOptions.XML.Prompt;
  cbSeparatePages.Checked := Cr.ExportOptions.XML.SeparatePages;
end;
{------------------------------------------------------------------------------}
{ cbPromptClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.cbPromptClick(Sender: TObject);
begin
  cbSeparatePages.Enabled := cbPrompt.Checked = False;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.XML.Prompt := cbPrompt.Checked;
  Cr.ExportOptions.XML.SeparatePages := cbSeparatePages.Checked;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeXML1Dlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;



end.
