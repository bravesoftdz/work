unit UDPFCValues;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpePFCurrentValuesDlg = class(TForm)
    pnlValues: TPanel;
    lblText: TLabel;
    editText: TEdit;
    lbNumbers: TListBox;
    lblNumber: TLabel;
    btnOk: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure UpdateCurrentValues;
    procedure lbNumbersClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure editTextExit(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Crv     : TCrpeParamFieldCurrentValues;
    CVIndex : integer;
  end;

var
  CrpePFCurrentValuesDlg: TCrpePFCurrentValuesDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  CVIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.FormShow(Sender: TObject);
begin
  UpdateCurrentValues;
end;
{------------------------------------------------------------------------------}
{ UpdateCurrentValues procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.UpdateCurrentValues;
var
  OnOff : boolean;
  i     : integer;
begin
  CVIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crv.Cr.ReportName) then
  begin
    OnOff := False;
    btnAdd.Enabled := False;
  end
  else
  begin
    OnOff := (Crv.Count > 0);
    btnAdd.Enabled := True;
    {Get CurrentValues Index}
    if OnOff then
    begin
      if Crv.ItemIndex > -1 then
        CVIndex := Crv.ItemIndex
      else
        CVIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    lbNumbers.Clear;
    for i := 0 to Crv.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crv.Count);
    lbNumbers.ItemIndex := CVIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        if not OnOff then
          TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.lbNumbersClick(Sender: TObject);
begin
  CVIndex := lbNumbers.ItemIndex;
  editText.Text := Crv[CVIndex].Text;
end;
{------------------------------------------------------------------------------}
{ editTextExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.editTextExit(Sender: TObject);
begin
  if IsStrEmpty(Crv.Cr.ReportName) then Exit;
  if CVIndex < 0 then Exit;
  Crv[CVIndex].Text := editText.Text;
  UpdateCurrentValues;
end;
{------------------------------------------------------------------------------}
{ btnAddClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.btnAddClick(Sender: TObject);
var
  s : string;
begin
  if InputQuery('CurrentValues.Add', 'Add Current Value: ', s) then
  begin
    Crv.Add(s);
    UpdateCurrentValues;
  end;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.btnDeleteClick(Sender: TObject);
begin
  Crv.Delete(lbNumbers.ItemIndex);
  UpdateCurrentValues;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.btnClearClick(Sender: TObject);
begin
  Crv.Clear;
  UpdateCurrentValues;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.btnOkClick(Sender: TObject);
begin
  editTextExit(editText);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePFCurrentValuesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
