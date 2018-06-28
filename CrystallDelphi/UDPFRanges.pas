unit UDPFRanges;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, UCrpe32;

type
  TCrpeParamFieldRangesDlg = class(TForm)
    btnOk: TButton;
    pnlPFValues: TPanel;
    lblRangeStart: TLabel;
    lblRangeEnd: TLabel;
    editRangeStart: TEdit;
    editRangeEnd: TEdit;
    lblBounds: TLabel;
    cbBounds: TComboBox;
    lbNumbers: TListBox;
    lblNumber: TLabel;
    btnClear: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateRanges;
    procedure lbNumbersClick(Sender: TObject);
    procedure cbBoundsChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure editRangeStartEnter(Sender: TObject);
    procedure editRangeStartExit(Sender: TObject);
    procedure editRangeEndEnter(Sender: TObject);
    procedure editRangeEndExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Crr     : TCrpeParamFieldRanges;
    RIndex  : integer;
    PrevVal : string;
  end;

var
  CrpeParamFieldRangesDlg: TCrpeParamFieldRangesDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  RIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.FormShow(Sender: TObject);
begin
  UpdateRanges;
end;
{------------------------------------------------------------------------------}
{ UpdateRanges procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.UpdateRanges;
var
  OnOff : boolean;
  i     : integer;
begin
  RIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crr.Cr.ReportName) then
  begin
    OnOff := False;
    btnAdd.Enabled := False;
  end
  else
  begin
    OnOff := (Crr.Count > 0);
    btnAdd.Enabled := True;
    {Get Ranges Index}
    if OnOff then
    begin
      if Crr.ItemIndex > -1 then
        RIndex := Crr.ItemIndex
      else
        RIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    lbNumbers.Clear;
    for i := 0 to Crr.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crr.Count);
    lbNumbers.ItemIndex := RIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
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
procedure TCrpeParamFieldRangesDlg.lbNumbersClick(Sender: TObject);
begin
  RIndex := lbNumbers.ItemIndex;
  editRangeStart.Text := Crr[RIndex].RangeStart;
  editRangeEnd.Text := Crr[RIndex].RangeEnd;
  cbBounds.ItemIndex := Ord(Crr[RIndex].Bounds);
end;
{------------------------------------------------------------------------------}
{ editRangeStartEnter procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.editRangeStartEnter(Sender: TObject);
begin
  PrevVal := editRangeStart.Text;
end;
{------------------------------------------------------------------------------}
{ editRangeStartExit procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.editRangeStartExit(Sender: TObject);
begin
  if IsStrEmpty(Crr.Cr.ReportName) then Exit;
  if RIndex < 0 then Exit;
  if IsFloating(editRangeStart.Text) then
    Crr.Item.RangeStart := editRangeStart.Text
  else
    editRangeStart.Text := PrevVal;
end;
{------------------------------------------------------------------------------}
{ editRangeEndEnter procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.editRangeEndEnter(Sender: TObject);
begin
  PrevVal := editRangeEnd.Text;
end;
{------------------------------------------------------------------------------}
{ editRangeEndExit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.editRangeEndExit(Sender: TObject);
begin
  if IsStrEmpty(Crr.Cr.ReportName) then Exit;
  if RIndex < 0 then Exit;
  if IsFloating(editRangeEnd.Text) then
    Crr.Item.RangeEnd := editRangeEnd.Text
  else
    editRangeEnd.Text := PrevVal;
end;
{------------------------------------------------------------------------------}
{ cbBoundsChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.cbBoundsChange(Sender: TObject);
begin
  Crr[RIndex].Bounds := TCrRangeBounds(cbBounds.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnAddClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.btnAddClick(Sender: TObject);
begin
  Crr.Add;
  UpdateRanges;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.btnDeleteClick(Sender: TObject);
begin
  Crr.Delete(RIndex);
  UpdateRanges;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.btnClearClick(Sender: TObject);
begin
  Crr.Clear;
  UpdateRanges;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldRangesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
