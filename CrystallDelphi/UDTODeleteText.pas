unit UDTODeleteText;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeDeleteTextDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlDeleteText: TPanel;
    editTextStart: TEdit;
    lblTextStart: TLabel;
    lblTextEnd: TLabel;
    editTextEnd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeDeleteTextDlg: TCrpeDeleteTextDlg;

implementation

{$R *.DFM}

uses SysUtils, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDeleteTextDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDeleteTextDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  if IsNumeric(editTextStart.Text) and IsNumeric(editTextEnd.Text) then
    Cr.TextObjects.Item.DeleteText(StrToInt(editTextStart.Text),
      StrToInt(editTextEnd.Text));
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDeleteTextDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeDeleteTextDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
