unit UDSelection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSelectionDlg = class(TForm)
    pnlSelection1: TPanel;
    lblSelectionText: TLabel;
    memoSelection: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    btnCheck: TButton;
    procedure memoSelectionChange(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSelection;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    rFormula : TStringList;
  end;

var
  CrpeSelectionDlg: TCrpeSelectionDlg;
  bSelection      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate Method                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.FormCreate(Sender: TObject);
begin
  bSelection := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow Method                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.FormShow(Sender: TObject);
begin
  rFormula := TStringList.Create;
  rFormula.Assign(Cr.Selection.Formula);
  UpdateSelection;
end;
{------------------------------------------------------------------------------}
{ UpdateSelection Method                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.UpdateSelection;
var
  OnOff : Boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    memoSelection.OnChange := nil;
    memoSelection.Lines.Assign(Cr.Selection.Formula);
    memoSelection.OnChange := memoSelectionChange;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ memoSelectionChange Method                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.memoSelectionChange(Sender: TObject);
begin
  Cr.Selection.Formula.Assign(memoSelection.Lines);
end;
{------------------------------------------------------------------------------}
{ btnCheckClick Method                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.btnCheckClick(Sender: TObject);
begin
  if Cr.Selection.Check then
    MessageDlg('Selection Formula is Good!', mtInformation, [mbOk], 0)
  else
    MessageDlg('Selection Formula has an Error.' + Chr(10) +
      Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnClearClick Method                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.btnClearClick(Sender: TObject);
begin
  Cr.Selection.Clear;
  UpdateSelection;
end;
{------------------------------------------------------------------------------}
{ btnOkClick Method                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  ModalResult := mrOk;
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick Method                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose Method                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.Selection.Formula.Assign(rFormula);
  end;
  rFormula.Free;
  bSelection := False;
  Release;
end;


end.
