unit UDPFPValues;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, UCrpe32;

type
  TCrpePFPromptValuesDlg = class(TForm)
    btnOk: TButton;
    pnlValues: TPanel;
    gbDescriptionOptions: TGroupBox;
    lblSortMethod: TLabel;
    cbSortMethod: TComboBox;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editText: TEdit;
    lblText: TLabel;
    lblDescription: TLabel;
    editDescription: TEdit;
    cbDescriptionOnly: TCheckBox;
    cbSortByDescription: TCheckBox;
    btnAdd: TButton;
    btnDelete: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    btnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdatePromptValues;
    procedure cbSortMethodChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure editDescriptionExit(Sender: TObject);
    procedure cbDescriptionOnlyClick(Sender: TObject);
    procedure cbSortByDescriptionClick(Sender: TObject);
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
    Crv     : TCrpeParamFieldPromptValues;
    PVIndex : integer;
  end;

var
  CrpePFPromptValuesDlg: TCrpePFPromptValuesDlg;

implementation

{$R *.DFM}

uses Dialogs, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  PVIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.FormShow(Sender: TObject);
begin
  UpdatePromptValues;
end;
{------------------------------------------------------------------------------}
{ UpdatePromptValues procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.UpdatePromptValues;
var
  OnOff : boolean;
  i     : integer;
begin
  PVIndex := -1;
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
    {Get PromptValues Index}
    if OnOff then
    begin
      if Crv.ItemIndex > -1 then
        PVIndex := Crv.ItemIndex
      else
        PVIndex := 0;
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
    lbNumbers.ItemIndex := PVIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpePFPromptValuesDlg.lbNumbersClick(Sender: TObject);
begin
  PVIndex := lbNumbers.ItemIndex;
  {Disable Events}
  cbDescriptionOnly.OnClick := nil;
  cbSortByDescription.OnClick := nil;
  cbSortMethod.OnChange := nil;
  {Clear}
  editText.Clear;
  editDescription.Clear;
  {Update Edit fields}
  editText.Text := Crv[PVIndex].Text;
  editDescription.Text := Crv[PVIndex].Description;
  {Update Description Options}
  cbDescriptionOnly.Checked := Crv.DescriptionOnly;
  cbSortByDescription.Checked := Crv.SortByDescription;
  cbSortMethod.ItemIndex := Ord(Crv.SortMethod);
  {Re-Activate Events}
  cbDescriptionOnly.OnClick := cbDescriptionOnlyClick;
  cbSortByDescription.OnClick := cbSortByDescriptionClick;
  cbSortMethod.OnChange := cbSortMethodChange;
end;
{------------------------------------------------------------------------------}
{ editTextExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.editTextExit(Sender: TObject);
begin
  if IsStrEmpty(Crv.Cr.ReportName) then Exit;
  if PVIndex < 0 then Exit;
  Crv[PVIndex].Text := editText.Text;
  UpdatePromptValues;
end;
{------------------------------------------------------------------------------}
{ editDescriptionExit procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.editDescriptionExit(Sender: TObject);
begin
  if IsStrEmpty(Crv.Cr.ReportName) then Exit;
  if PVIndex < 0 then Exit;
  Crv[PVIndex].Description := editDescription.Text;
  UpdatePromptValues;
end;
{------------------------------------------------------------------------------}
{ btnAddClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.btnAddClick(Sender: TObject);
var
  s : string;
begin
  if InputQuery('PromptValues.Add', 'Add Prompt Value: ', s) then
  begin
    Crv.Add(s);
    UpdatePromptValues;
  end;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.btnDeleteClick(Sender: TObject);
begin
  Crv.Delete(PVIndex);
  UpdatePromptValues;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.btnClearClick(Sender: TObject);
begin
  Crv.Clear;
  UpdatePromptValues;
end;
{------------------------------------------------------------------------------}
{ cbDescriptionOnlyClick procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.cbDescriptionOnlyClick(Sender: TObject);
begin
  Crv.DescriptionOnly := cbDescriptionOnly.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSortByDescriptionClick procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.cbSortByDescriptionClick(Sender: TObject);
begin
  Crv.SortByDescription := cbSortByDescription.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSortMethodChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.cbSortMethodChange(Sender: TObject);
begin
  Crv.SortMethod := TCrPickListSortMethod(cbSortMethod.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.btnOkClick(Sender: TObject);
begin
  editTextExit(editText);
  editDescriptionExit(editDescription);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePFPromptValuesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
