unit UDCrossTabs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeCrossTabsDlg = class(TForm)
    pnlCrossTabs: TPanel;
    gbObjectFormatting: TGroupBox;
    btnBorder: TButton;
    btnFormat: TButton;
    editTop: TEdit;
    lblTop: TLabel;
    lblLeft: TLabel;
    editLeft: TEdit;
    lblSection: TLabel;
    editWidth: TEdit;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editHeight: TEdit;
    cbSection: TComboBox;
    btnOk: TButton;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    gbGridOptions: TGroupBox;
    cbShowCellMargins: TCheckBox;
    cbShowGridLines: TCheckBox;
    cbRepeatRowLabels: TCheckBox;
    cbKeepColumnsTogether: TCheckBox;
    cbSuppressEmptyRows: TCheckBox;
    cbSuppressEmptyColumns: TCheckBox;
    cbSuppressRowGrandTotals: TCheckBox;
    cbSuppressColumnGrandTotals: TCheckBox;
    lblColorRowGrandTotals: TLabel;
    cbColorRowGrandTotals: TComboBox;
    ColorDialog1: TColorDialog;
    lblColorColumnGrandTotals: TLabel;
    cbColorColumnGrandTotals: TComboBox;
    rgUnits: TRadioGroup;
    btnSummaries: TButton;
    btnRowGroups: TButton;
    btnColumnGroups: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure UpdateCrossTabs;
    procedure lbNumbersClick(Sender: TObject);
    procedure cbColorRowGrandTotalsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cbColorColumnGrandTotalsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cbColorRowGrandTotalsChange(Sender: TObject);
    procedure cbColorColumnGrandTotalsChange(Sender: TObject);
    procedure cbShowCellMarginsClick(Sender: TObject);
    procedure cbShowGridLinesClick(Sender: TObject);
    procedure cbRepeatRowLabelsClick(Sender: TObject);
    procedure cbKeepColumnsTogetherClick(Sender: TObject);
    procedure cbSuppressEmptyRowsClick(Sender: TObject);
    procedure cbSuppressEmptyColumnsClick(Sender: TObject);
    procedure cbSuppressRowGrandTotalsClick(Sender: TObject);
    procedure cbSuppressColumnGrandTotalsClick(Sender: TObject);
    procedure btnSummariesClick(Sender: TObject);
    procedure btnRowGroupsClick(Sender: TObject);
    procedure btnColumnGroupsClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr                : TCrpe;
    CrossTabIndex     : smallint;
    PrevSize          : string;
    CustomRowColor    : TColor;
    CustomColumnColor : TColor;
  end;

var
  CrpeCrossTabsDlg: TCrpeCrossTabsDlg;
  bCrossTabs      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat, UDCrossTabSummaries, UDCrossTabGroups;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.FormCreate(Sender: TObject);
begin
  bCrossTabs := True;
  LoadFormPos(Self);
  CrossTabIndex := -1;
  btnOk.Tag := 1;
  CustomRowColor := clNone;
  CustomColumnColor := clNone;
  {ColorColumnGrandTotals}
  with cbColorColumnGrandTotals.Items do
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
    AddObject('Custom', Pointer(CustomColumnColor));
  end;
  {ColorRowGrandTotals}
  with cbColorRowGrandTotals.Items do
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
    AddObject('Custom', Pointer(CustomRowColor));
  end;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.FormShow(Sender: TObject);
begin
  UpdateCrossTabs;
end;
{------------------------------------------------------------------------------}
{ UpdateCrossTabs                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.UpdateCrossTabs;
var
  i     : integer;
  OnOff : boolean;
begin
  CrossTabIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.CrossTabs.Count > 0);
    {Get CrossTab Index}
    if OnOff then
    begin
      if Cr.CrossTabs.ItemIndex > -1 then
        CrossTabIndex := Cr.CrossTabs.ItemIndex
      else
        CrossTabIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.CrossTabs.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.CrossTabs.Count);
    lbNumbers.ItemIndex := CrossTabIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.lbNumbersClick(Sender: TObject);
begin
  CrossTabIndex := lbNumbers.ItemIndex;
  Cr.CrossTabs[CrossTabIndex];
  {CrossTab options}
  cbShowCellMargins.Checked := Cr.CrossTabs.Item.ShowCellMargins;
  cbShowGridLines.Checked := Cr.CrossTabs.Item.ShowGridLines;
  cbRepeatRowLabels.Checked := Cr.CrossTabs.Item.RepeatRowLabels;
  cbKeepColumnsTogether.Checked := Cr.CrossTabs.Item.KeepColumnsTogether;
  cbSuppressEmptyRows.Checked := Cr.CrossTabs.Item.SuppressEmptyRows;
  cbSuppressEmptyColumns.Checked := Cr.CrossTabs.Item.SuppressEmptyColumns;
  cbSuppressRowGrandTotals.Checked := Cr.CrossTabs.Item.SuppressRowGrandTotals;
  cbSuppressColumnGrandTotals.Checked := Cr.CrossTabs.Item.SuppressColumnGrandTotals;
  {ColorColumnGrandTotals}
  case Cr.CrossTabs.Item.ColorColumnGrandTotals of
    clBlack   : cbColorColumnGrandTotals.ItemIndex := 0;
    clMaroon  : cbColorColumnGrandTotals.ItemIndex := 1;
    clGreen   : cbColorColumnGrandTotals.ItemIndex := 2;
    clOlive   : cbColorColumnGrandTotals.ItemIndex := 3;
    clNavy    : cbColorColumnGrandTotals.ItemIndex := 4;
    clPurple  : cbColorColumnGrandTotals.ItemIndex := 5;
    clTeal    : cbColorColumnGrandTotals.ItemIndex := 6;
    clGray    : cbColorColumnGrandTotals.ItemIndex := 7;
    clSilver  : cbColorColumnGrandTotals.ItemIndex := 8;
    clRed     : cbColorColumnGrandTotals.ItemIndex := 9;
    clLime    : cbColorColumnGrandTotals.ItemIndex := 10;
    clYellow  : cbColorColumnGrandTotals.ItemIndex := 11;
    clBlue    : cbColorColumnGrandTotals.ItemIndex := 12;
    clFuchsia : cbColorColumnGrandTotals.ItemIndex := 13;
    clAqua    : cbColorColumnGrandTotals.ItemIndex := 14;
    clWhite   : cbColorColumnGrandTotals.ItemIndex := 15;
    clNone    : cbColorColumnGrandTotals.ItemIndex := 16;
    else {Custom}
    begin
      cbColorColumnGrandTotals.ItemIndex := 17;
      CustomColumnColor := Cr.CrossTabs.Item.ColorColumnGrandTotals;
      cbColorColumnGrandTotals.Items.Objects[17] := Pointer(CustomColumnColor);
    end;
  end;
  {ColorRowGrandTotals}
  case Cr.CrossTabs.Item.ColorRowGrandTotals of
    clBlack   : cbColorRowGrandTotals.ItemIndex := 0;
    clMaroon  : cbColorRowGrandTotals.ItemIndex := 1;
    clGreen   : cbColorRowGrandTotals.ItemIndex := 2;
    clOlive   : cbColorRowGrandTotals.ItemIndex := 3;
    clNavy    : cbColorRowGrandTotals.ItemIndex := 4;
    clPurple  : cbColorRowGrandTotals.ItemIndex := 5;
    clTeal    : cbColorRowGrandTotals.ItemIndex := 6;
    clGray    : cbColorRowGrandTotals.ItemIndex := 7;
    clSilver  : cbColorRowGrandTotals.ItemIndex := 8;
    clRed     : cbColorRowGrandTotals.ItemIndex := 9;
    clLime    : cbColorRowGrandTotals.ItemIndex := 10;
    clYellow  : cbColorRowGrandTotals.ItemIndex := 11;
    clBlue    : cbColorRowGrandTotals.ItemIndex := 12;
    clFuchsia : cbColorRowGrandTotals.ItemIndex := 13;
    clAqua    : cbColorRowGrandTotals.ItemIndex := 14;
    clWhite   : cbColorRowGrandTotals.ItemIndex := 15;
    clNone    : cbColorRowGrandTotals.ItemIndex := 16;
    else {Custom}
    begin
      cbColorRowGrandTotals.ItemIndex := 17;
      CustomRowColor := Cr.CrossTabs.Item.ColorRowGrandTotals;
      cbColorRowGrandTotals.Items.Objects[17] := Pointer(CustomRowColor);
    end;
  end;
  {Size and Position}
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.CrossTabs.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
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
{ cbColorRowGrandTotalsDrawItem                                                }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbColorRowGrandTotalsDrawItem(
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
  ColorR.Bottom := Rect.Top + cbColorRowGrandTotals.ItemHeight - 1;
  TextR.Left := Rect.Left + 18{ColorWidth} + 4;
  TextR.Top := Rect.Top + 1;
  TextR.Right := Rect.Right;
  TextR.Bottom := Rect.Bottom - 1;
  with cbColorRowGrandTotals.Canvas do
  begin
    FillRect(Rect);	{ clear the rectangle }
    OldColor := Brush.Color;
    Brush.Color := TColor(cbColorRowGrandTotals.Items.Objects[Index]);
    Rectangle(ColorR.Left, ColorR.Top, ColorR.Right, ColorR.Bottom);
    Brush.Color := OldColor;
    DrawText(Handle, PChar(cbColorRowGrandTotals.Items[Index]), -1, TextR, DT_VCENTER or DT_SINGLELINE);
  end;
end;
{------------------------------------------------------------------------------}
{ cbColorColumnGrandTotalsDrawItem                                             }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbColorColumnGrandTotalsDrawItem(
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
  ColorR.Bottom := Rect.Top + cbColorColumnGrandTotals.ItemHeight - 1;
  TextR.Left := Rect.Left + 18{ColorWidth} + 4;
  TextR.Top := Rect.Top + 1;
  TextR.Right := Rect.Right;
  TextR.Bottom := Rect.Bottom - 1;
  with cbColorColumnGrandTotals.Canvas do
  begin
    FillRect(Rect);	{ clear the rectangle }
    OldColor := Brush.Color;
    Brush.Color := TColor(cbColorColumnGrandTotals.Items.Objects[Index]);
    Rectangle(ColorR.Left, ColorR.Top, ColorR.Right, ColorR.Bottom);
    Brush.Color := OldColor;
    DrawText(Handle, PChar(cbColorColumnGrandTotals.Items[Index]), -1, TextR, DT_VCENTER or DT_SINGLELINE);
  end;
end;
{------------------------------------------------------------------------------}
{ cbColorRowGrandTotalsChange                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbColorRowGrandTotalsChange(Sender: TObject);
var
  xColor : TColor;
  i      : integer;
begin
  i := cbColorRowGrandTotals.ItemIndex;
  xColor := TColor(cbColorRowGrandTotals.Items.Objects[i]);
  if cbColorRowGrandTotals.Items[i] = 'Custom' then
  begin
    ColorDialog1.Color := xColor;
    if ColorDialog1.Execute then
    begin
      xColor := ColorDialog1.Color;
      CustomRowColor := xColor;
      cbColorRowGrandTotals.Items.Objects[i] := Pointer(CustomRowColor);
    end;
  end;
  Cr.CrossTabs[CrossTabIndex].ColorRowGrandTotals := xColor;
end;
{------------------------------------------------------------------------------}
{ cbColorColumnGrandTotalsChange                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbColorColumnGrandTotalsChange(
  Sender: TObject);
var
  xColor : TColor;
  i      : integer;
begin
  i := cbColorColumnGrandTotals.ItemIndex;
  xColor := TColor(cbColorColumnGrandTotals.Items.Objects[i]);
  if cbColorColumnGrandTotals.Items[i] = 'Custom' then
  begin
    ColorDialog1.Color := xColor;
    if ColorDialog1.Execute then
    begin
      xColor := ColorDialog1.Color;
      CustomColumnColor := xColor;
      cbColorColumnGrandTotals.Items.Objects[i] := Pointer(CustomColumnColor);
    end;
  end;
  Cr.CrossTabs[CrossTabIndex].ColorColumnGrandTotals := xColor;
end;
{------------------------------------------------------------------------------}
{ cbShowCellMarginsClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbShowCellMarginsClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.ShowCellMargins := cbShowCellMargins.Checked;
end;
{------------------------------------------------------------------------------}
{ cbShowGridLinesClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbShowGridLinesClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.ShowGridLines := cbShowGridLines.Checked;
end;
{------------------------------------------------------------------------------}
{ cbRepeatRowLabelsClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbRepeatRowLabelsClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.RepeatRowLabels := cbRepeatRowLabels.Checked;
end;
{------------------------------------------------------------------------------}
{ cbKeepColumnsTogetherClick                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbKeepColumnsTogetherClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.KeepColumnsTogether := cbKeepColumnsTogether.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressEmptyRowsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbSuppressEmptyRowsClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.SuppressEmptyRows := cbSuppressEmptyRows.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressEmptyColumnsClick                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbSuppressEmptyColumnsClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.SuppressEmptyColumns := cbSuppressEmptyColumns.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressRowGrandTotalsClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbSuppressRowGrandTotalsClick(Sender: TObject);
begin
  Cr.CrossTabs.Item.SuppressRowGrandTotals := cbSuppressRowGrandTotals.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressColumnGrandTotalsClick                                             }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbSuppressColumnGrandTotalsClick(
  Sender: TObject);
begin
  Cr.CrossTabs.Item.SuppressColumnGrandTotals := cbSuppressColumnGrandTotals.Checked;
end;
{------------------------------------------------------------------------------}
{ btnSummariesClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnSummariesClick(Sender: TObject);
begin
  CrpeCrossTabSummariesDlg := TCrpeCrossTabSummariesDlg.Create(Application);
  CrpeCrossTabSummariesDlg.Crs := Cr.CrossTabs[CrossTabIndex].Summaries;
  CrpeCrossTabSummariesDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnRowGroupsClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnRowGroupsClick(Sender: TObject);
begin
  CrpeCrossTabGroupsDlg := TCrpeCrossTabGroupsDlg.Create(Application);
  CrpeCrossTabGroupsDlg.Caption := 'CrossTab RowGroups';
  CrpeCrossTabGroupsDlg.Crg := Cr.CrossTabs[CrossTabIndex].RowGroups;
  CrpeCrossTabGroupsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnColumnGroupsClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnColumnGroupsClick(Sender: TObject);
begin
  CrpeCrossTabGroupsDlg := TCrpeCrossTabGroupsDlg.Create(Application);
  CrpeCrossTabGroupsDlg.Caption := 'CrossTab ColumnGroups';
  CrpeCrossTabGroupsDlg.Crg := Cr.CrossTabs[CrossTabIndex].ColumnGroups;
  CrpeCrossTabGroupsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.CrossTabs[CrossTabIndex].Top);
    editLeft.Text := TwipsToInchesStr(Cr.CrossTabs[CrossTabIndex].Left);
    editWidth.Text := TwipsToInchesStr(Cr.CrossTabs[CrossTabIndex].Width);
    editHeight.Text := TwipsToInchesStr(Cr.CrossTabs[CrossTabIndex].Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.CrossTabs[CrossTabIndex].Top);
    editLeft.Text := IntToStr(Cr.CrossTabs[CrossTabIndex].Left);
    editWidth.Text := IntToStr(Cr.CrossTabs[CrossTabIndex].Width);
    editHeight.Text := IntToStr(Cr.CrossTabs[CrossTabIndex].Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.CrossTabs[CrossTabIndex].Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.CrossTabs[CrossTabIndex].Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.CrossTabs[CrossTabIndex].Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.CrossTabs[CrossTabIndex].Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateCrossTabs; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.CrossTabs[CrossTabIndex].Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.CrossTabs[CrossTabIndex].Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.CrossTabs[CrossTabIndex].Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.CrossTabs[CrossTabIndex].Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.CrossTabs[CrossTabIndex].Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.CrossTabs[CrossTabIndex].Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.CrossTabs[CrossTabIndex].Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (CrossTabIndex > -1) then 
  begin
    editSizeExit(editTop);
    editSizeExit(editLeft);
    editSizeExit(editWidth);
    editSizeExit(editHeight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bCrossTabs := False;
  Release;
end;


end.
