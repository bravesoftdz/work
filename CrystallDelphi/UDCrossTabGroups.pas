unit UDCrossTabGroups;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeCrossTabGroupsDlg = class(TForm)
    pnlCrossTabGroups: TPanel;
    editFieldName: TEdit;
    lblFieldName: TLabel;
    lblGOCondition: TLabel;
    cbCondition: TComboBox;
    lblGODirection: TLabel;
    cbDirection: TComboBox;
    cbSuppressSubtotal: TCheckBox;
    cbSuppressLabel: TCheckBox;
    lblBackgroundColor: TLabel;
    cbBackgroundColor: TComboBox;
    btnOk: TButton;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    lblCount: TLabel;
    editCount: TEdit;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure editFieldNameChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure UpdateCrossTabGroups;
    procedure InitializeControls(OnOff: boolean);
    procedure lbNumbersClick(Sender: TObject);
    procedure cbConditionChange(Sender: TObject);
    procedure cbDirectionChange(Sender: TObject);
    procedure cbBackgroundColorChange(Sender: TObject);
    procedure cbSuppressSubtotalClick(Sender: TObject);
    procedure cbSuppressLabelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cbBackgroundColorDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    Crg           : TCrpeCrossTabGroups;
    CIndex        : integer;
    CustomBGColor : TColor;
  end;

var
  CrpeCrossTabGroupsDlg: TCrpeCrossTabGroupsDlg;
  bCrossTabGroups      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  CIndex := -1;
  bCrossTabGroups := True;
  CustomBGColor := clNone;
  {ColorColumnGrandTotals}
  with cbBackgroundColor.Items do
  begin
    AddObject('clBlack', Pointer(clBlack));
    AddObject('clMaroon', Pointer(clMaroon));
    AddObject('clGreen', Pointer(clGreen));
    AddObject('clOlive', Pointer(clOlive));
    AddObject('clNavy', Pointer(clNavy));
    AddObject('clPurple', Pointer(clPurple));
    AddObject('clTeal', Pointer(clTeal));
    AddObject('clGray', Pointer(clGray));
    AddObject('clSilver', Pointer(clSilver));
    AddObject('clRed', Pointer(clRed));
    AddObject('clLime', Pointer(clLime));
    AddObject('clYellow', Pointer(clYellow));
    AddObject('clBlue', Pointer(clBlue));
    AddObject('clFuchsia', Pointer(clFuchsia));
    AddObject('clAqua', Pointer(clAqua));
    AddObject('clWhite', Pointer(clWhite));
    AddObject('clNone', Pointer(clNone));
    AddObject('Custom', Pointer(CustomBGColor));
  end;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.FormShow(Sender: TObject);
begin
  UpdateCrossTabGroups;
end;
{------------------------------------------------------------------------------}
{ UpdateCrossTabGroups                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.UpdateCrossTabGroups;
var
  i     : integer;
  OnOff : boolean;
begin
  CIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crg.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crg.Count > 0);
    {Get CrossTabGroup Index}
    if OnOff then
    begin
      if Crg.ItemIndex > -1 then
        CIndex := Crg.ItemIndex
      else
        CIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Crg.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crg.Count);
    lbNumbers.ItemIndex := CIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
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
{ editFieldNameChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.editFieldNameChange(Sender: TObject);
begin
  Crg[CIndex].FieldName := editFieldName.Text;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.lbNumbersClick(Sender: TObject);
begin
  CIndex := lbNumbers.ItemIndex;
  editFieldName.Text := Crg[CIndex].FieldName;
  cbCondition.ItemIndex := Ord(Crg.Item.Condition);
  cbDirection.ItemIndex := Ord(Crg.Item.Direction);
  {BackgroundColor}
  case Crg.Item.BackgroundColor of
    clBlack   : cbBackgroundColor.ItemIndex := 0;
    clMaroon  : cbBackgroundColor.ItemIndex := 1;
    clGreen   : cbBackgroundColor.ItemIndex := 2;
    clOlive   : cbBackgroundColor.ItemIndex := 3;
    clNavy    : cbBackgroundColor.ItemIndex := 4;
    clPurple  : cbBackgroundColor.ItemIndex := 5;
    clTeal    : cbBackgroundColor.ItemIndex := 6;
    clGray    : cbBackgroundColor.ItemIndex := 7;
    clSilver  : cbBackgroundColor.ItemIndex := 8;
    clRed     : cbBackgroundColor.ItemIndex := 9;
    clLime    : cbBackgroundColor.ItemIndex := 10;
    clYellow  : cbBackgroundColor.ItemIndex := 11;
    clBlue    : cbBackgroundColor.ItemIndex := 12;
    clFuchsia : cbBackgroundColor.ItemIndex := 13;
    clAqua    : cbBackgroundColor.ItemIndex := 14;
    clWhite   : cbBackgroundColor.ItemIndex := 15;
    clNone    : cbBackgroundColor.ItemIndex := 16;
    else {Custom}
    begin
      cbBackgroundColor.ItemIndex := 17;
      CustomBGColor := Crg.Item.BackgroundColor;
      cbBackgroundColor.Items.Objects[17] := Pointer(CustomBGColor);
    end;
  end;
  cbSuppressSubtotal.Checked := Crg.Item.SuppressSubtotal;
  cbSuppressLabel.Checked := Crg.Item.SuppressLabel;
end;
{------------------------------------------------------------------------------}
{ cbConditionChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbConditionChange(Sender: TObject);
begin
  Crg.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbDirectionChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbDirectionChange(Sender: TObject);
begin
  Crg[CIndex].Direction := TCrGroupDirection(cbDirection.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbBackgroundColorChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbBackgroundColorChange(Sender: TObject);
var
  xColor : TColor;
  i      : integer;
begin
  i := cbBackgroundColor.ItemIndex;
  xColor := TColor(cbBackgroundColor.Items.Objects[i]);
  if cbBackgroundColor.Items[i] = 'Custom' then
  begin
    ColorDialog1.Color := xColor;
    if ColorDialog1.Execute then
    begin
      xColor := ColorDialog1.Color;
      CustomBGColor := xColor;
      cbBackgroundColor.Items.Objects[i] := Pointer(CustomBGColor);
      cbBackgroundColor.Invalidate;
    end;
  end;
  Crg[CIndex].BackgroundColor := xColor;
end;
{------------------------------------------------------------------------------}
{ cbBackgroundColorDrawItem                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbBackgroundColorDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  ColorR   : TRect;
  TextR    : TRect;
  OldColor : TColor;
begin
  ColorR.Left := Rect.Left + 1;
  ColorR.Top := Rect.Top + 1;
  ColorR.Right := Rect.Left + 18{ColorWidth} - 1;
  ColorR.Bottom := Rect.Top + cbBackgroundColor.ItemHeight - 1;
  TextR.Left := Rect.Left + 18{ColorWidth} + 4;
  TextR.Top := Rect.Top + 1;
  TextR.Right := Rect.Right;
  TextR.Bottom := Rect.Bottom - 1;
  with cbBackgroundColor.Canvas do
  begin
    FillRect(Rect);	{ clear the rectangle }
    OldColor := Brush.Color;
    Brush.Color := TColor(cbBackgroundColor.Items.Objects[Index]);
    Rectangle(ColorR.Left, ColorR.Top, ColorR.Right, ColorR.Bottom);
    Brush.Color := OldColor;
    DrawText(Handle, PChar(cbBackgroundColor.Items[Index]), -1, TextR, DT_VCENTER or DT_SINGLELINE);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSuppressSubtotalClick                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbSuppressSubtotalClick(Sender: TObject);
begin
  Crg.Item.SuppressSubtotal := cbSuppressSubtotal.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressLabelClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.cbSuppressLabelClick(Sender: TObject);
begin
  Crg.Item.SuppressLabel := cbSuppressLabel.Checked;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.btnClearClick(Sender: TObject);
begin
  Crg.Clear;
  UpdateCrossTabGroups;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabGroupsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bCrossTabGroups := False;
  Release;
end;


end.
