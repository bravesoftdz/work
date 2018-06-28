unit UDHiliteConditions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32, UCrpeClasses;

type
  TCrpeHiliteConditionsDlg = class(TForm)
    btnOk: TButton;
    btnClear: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    pnlSummaryFields: TPanel;
    lblNumber: TLabel;
    lblCount: TLabel;
    lblRangeCondition: TLabel;
    lblStartValue: TLabel;
    lblEndValue: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    cbRangeCondition: TComboBox;
    editStartValue: TEdit;
    editEndValue: TEdit;
    lblFontColor: TLabel;
    lblBorderStyle: TLabel;
    cbBorderStyle: TComboBox;
    lblPriority: TLabel;
    sbPriorityUp: TSpeedButton;
    sbPriorityDown: TSpeedButton;
    lblBackground: TLabel;
    lblFontStyle: TLabel;
    cbFontStyle: TComboBox;
    cbFontColor: TColorBox;
    cbBackground: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cbRangeConditionChange(Sender: TObject);
    procedure cbFontColorChange(Sender: TObject);
    procedure cbBackgroundChange(Sender: TObject);
    procedure cbBorderStyleChange(Sender: TObject);
    procedure UpdateHiliteConditions;
    procedure InitializeControls(OnOff: boolean);
    procedure btnClearClick(Sender: TObject);
    procedure sbPriorityUpClick(Sender: TObject);
    procedure sbPriorityDownClick(Sender: TObject);
    procedure editStartValueEnter(Sender: TObject);
    procedure editStartValueExit(Sender: TObject);
    procedure editEndValueEnter(Sender: TObject);
    procedure editEndValueExit(Sender: TObject);
    procedure cbFontStyleChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Crh              : TCrpeHiliteConditions;
    HIndex           : smallint;
    CustomFontColor  : TColor;
    CustomBackground : TColor;
    PrevSize         : string;
  end;

var
  CrpeHiliteConditionsDlg: TCrpeHiliteConditionsDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  HIndex := -1;
  btnOk.Tag := 1;
  btnAdd.Tag := 1;
  cbFontColor.Selected := clBlack;
  cbBackground.Selected := clWhite;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.FormShow(Sender: TObject);
begin
  UpdateHiliteConditions;
end;
{------------------------------------------------------------------------------}
{ UpdateHiliteConditions                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.UpdateHiliteConditions;
var
  i     : smallint;
  OnOff : boolean;
begin
  HIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(TCrpe(Crh.Cx).ReportName) then
  begin
    OnOff := False;
    btnAdd.Enabled := False;
  end
  else
  begin
    OnOff := (Crh.Count > 0);
    btnAdd.Enabled := True;
    {Get HiliteConditions Index}
    if OnOff then
    begin
      if Crh.ItemIndex > -1 then
        HIndex := Crh.ItemIndex
      else
        HIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Crh.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crh.Count);
    lbNumbers.ItemIndex := HIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TColorBox then
        TColorBox(Components[i]).Enabled := OnOff;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
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
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.lbNumbersClick(Sender: TObject);
begin
  HIndex := lbNumbers.ItemIndex;
  cbRangeCondition.ItemIndex := Ord(Crh[HIndex].RangeCondition);
  editStartValue.Text := CrFloatingToStr(Crh.Item.StartValue);
  editEndValue.Text := CrFloatingToStr(Crh.Item.EndValue);
  cbFontColor.Selected := Crh.Item.FontColor;
  cbBackground.Selected := Crh.Item.Background;
  cbBorderStyle.ItemIndex := Ord(Crh.Item.BorderStyle);
  cbFontStyle.ItemIndex := Ord(Crh.Item.FontStyle);
end;
{------------------------------------------------------------------------------}
{ sbPriorityUpClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.sbPriorityUpClick(Sender: TObject);
begin
  if lbNumbers.ItemIndex > 0 then
  begin
    Crh.Item.SetPriority(lbNumbers.ItemIndex-1);
    UpdateHiliteConditions;
  end;
end;
{------------------------------------------------------------------------------}
{ sbPriorityDownClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.sbPriorityDownClick(Sender: TObject);
begin
  if lbNumbers.ItemIndex < (lbNumbers.Items.Count-1) then
  begin
    Crh.Item.SetPriority(lbNumbers.ItemIndex+1);
    UpdateHiliteConditions;
  end;
end;
{------------------------------------------------------------------------------}
{ cbRangeConditionChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.cbRangeConditionChange(Sender: TObject);
begin
  Crh.Item.RangeCondition := TCrHiliteRangeCondition(cbRangeCondition.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editStartValueEnter                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.editStartValueEnter(Sender: TObject);
begin
  PrevSize := editStartValue.Text;
end;
{------------------------------------------------------------------------------}
{ editStartValueExit                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.editStartValueExit(Sender: TObject);
begin
  if IsStrEmpty(TCrpe(Crh.Cx).ReportName) then Exit;
  if HIndex < 0 then Exit;
  if IsFloating(editStartValue.Text) then
    Crh.Item.StartValue := CrStrToFloating(editStartValue.Text)
  else
    editStartValue.Text := PrevSize;
end;
{------------------------------------------------------------------------------}
{ editEndValueEnter                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.editEndValueEnter(Sender: TObject);
begin
  PrevSize := editEndValue.Text;
end;
{------------------------------------------------------------------------------}
{ editEndValueExit                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.editEndValueExit(Sender: TObject);
begin
  if IsStrEmpty(TCrpe(Crh.Cx).ReportName) then Exit;
  if HIndex < 0 then Exit;
  if IsFloating(editEndValue.Text) then
    Crh.Item.EndValue := CrStrToFloating(editEndValue.Text)
  else
    editEndValue.Text := PrevSize;
end;
{------------------------------------------------------------------------------}
{ cbFontColorChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.cbFontColorChange(Sender: TObject);
begin
  Crh.Item.FontColor := cbFontColor.Selected;
end;
{------------------------------------------------------------------------------}
{ cbBackgroundChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.cbBackgroundChange(Sender: TObject);
begin
  Crh.Item.Background := cbBackground.Selected;
end;
{------------------------------------------------------------------------------}
{ cbBorderStyleChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.cbBorderStyleChange(Sender: TObject);
begin
  Crh.Item.BorderStyle := TCrHiliteBorderStyle(cbBorderStyle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbFontStyleChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.cbFontStyleChange(Sender: TObject);
begin
  Crh.Item.FontStyle := TCrHiliteFontStyle(cbFontStyle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.btnClearClick(Sender: TObject);
begin
  Crh.Clear;
  UpdateHiliteConditions;
end;
{------------------------------------------------------------------------------}
{ btnAddClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.btnAddClick(Sender: TObject);
begin
  Crh.Add;
  UpdateHiliteConditions;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.btnDeleteClick(Sender: TObject);
begin
  Crh.Delete(lbNumbers.ItemIndex);
  UpdateHiliteConditions;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
