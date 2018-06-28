unit UDGroupSelection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeGroupSelectionDlg = class(TForm)
    pnlSelection1: TPanel;
    lblSelectionText: TLabel;
    memoSelection: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    btnCheck: TButton;
    procedure FormShow(Sender: TObject);
    procedure memoSelectionChange(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  CrpeGroupSelectionDlg: TCrpeGroupSelectionDlg;
  bGroupSelection      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate Method                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.FormCreate(Sender: TObject);
begin
  bGroupSelection := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow Method                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.FormShow(Sender: TObject);
begin
  rFormula := TStringList.Create;
  rFormula.Assign(Cr.GroupSelection.Formula);
  UpdateSelection;
end;
{------------------------------------------------------------------------------}
{ UpdateSelection Method                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.UpdateSelection;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    memoSelection.OnChange := nil;
    memoSelection.Lines.Assign(Cr.GroupSelection.Formula);
    memoSelection.OnChange := memoSelectionChange;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeGroupSelectionDlg.memoSelectionChange(Sender: TObject);
begin
  Cr.GroupSelection.Formula.Assign(memoSelection.Lines);
end;
{------------------------------------------------------------------------------}
{ btnCheckClick Method                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.btnCheckClick(Sender: TObject);
begin
  if Cr.GroupSelection.Check then
    MessageDlg('GroupSelection Formula is Good!', mtInformation, [mbOk], 0)
  else
    MessageDlg('GroupSelection Formula has an Error.' + Chr(10) +
      Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnClearClick Method                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.btnClearClick(Sender: TObject);
begin
  Cr.GroupSelection.Clear;
  UpdateSelection;
end;
{------------------------------------------------------------------------------}
{ btnOkClick Method                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  ModalResult := mrOk;
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick Method                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose Method                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.GroupSelection.Formula.Assign(rFormula);
  end;
  rFormula.Free;
  bGroupSelection := False;
  Release;
end;


end.
