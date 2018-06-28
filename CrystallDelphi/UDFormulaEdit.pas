unit UDFormulaEdit;

interface

uses
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons;

type
  TCrpeFormulaEditDlg = class(TForm)
    memoFormula: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SenderList : TStrings;
  end;

var
  CrpeFormulaEditDlg: TCrpeFormulaEditDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.FormShow(Sender: TObject);
begin
  memoFormula.Lines.Assign(SenderList);
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.btnClearClick(Sender: TObject);
begin
  memoFormula.Clear;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormulaEditDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    SenderList.Assign(memoFormula.Lines);
  Release;
end;


end.
