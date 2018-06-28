unit UDBoxes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeBoxesDlg = class(TForm)
    pnlBoxes: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    lblCount: TLabel;
    editCount: TEdit;
    {Border}
    gbBorder: TGroupBox;
    lblBorderStyle: TLabel;
    cbBorderStyle: TComboBox;
    lblBorderWidth: TLabel;
    editBorderWidth: TEdit;
    lblBorderColor: TLabel;
    cbDropShadow: TCheckBox;
    {FillColor}
    lblFillColor: TLabel;
    {Format options}
    cbCloseBorder: TCheckBox;
    cbExtend: TCheckBox;
    cbSuppress: TCheckBox;
    {CornerRounding}
    gbCornerRounding: TGroupBox;
    lblCornerRoundingHeight: TLabel;
    lblCornerRoundingWidth: TLabel;
    editCornerRoundingHeight: TEdit;
    editCornerRoundingWidth: TEdit;
    {Size and Position}
    gbSizeAndPosition: TGroupBox;
    pnlSize: TPanel;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblBottom: TLabel;
    lblRight: TLabel;
    editTop: TEdit;
    editLeft: TEdit;
    editBottom: TEdit;
    editRight: TEdit;
    rgUnits: TRadioGroup;
    lblSectionStart: TLabel;
    cbSectionStart: TComboBox;
    lblSectionEnd: TLabel;
    cbSectionEnd: TComboBox;
    {Buttons}
    btnOk: TButton;
    btnClear: TButton;
    cbBorderColor: TColorBox;
    cbFillColor: TColorBox;
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateBoxes;
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure cbBorderColorChange(Sender: TObject);
    procedure cbFillColorChange(Sender: TObject);
    procedure cbBorderStyleChange(Sender: TObject);
    procedure editBorderWidthEnter(Sender: TObject);
    procedure editBorderWidthExit(Sender: TObject);
    procedure cbCloseBorderClick(Sender: TObject);
    procedure cbExtendClick(Sender: TObject);
    procedure cbSuppressClick(Sender: TObject);
    procedure editCornerRoundingEnter(Sender: TObject);
    procedure editCornerRoundingExit(Sender: TObject);
    procedure cbSectionStartChange(Sender: TObject);
    procedure cbSectionEndChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cbDropShadowClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rgUnitsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr                : TCrpe;
    BoxIndex          : smallint;
    PrevSize          : string;
    CustomBorderColor : TColor;
    CustomFillColor   : TColor;
  end;

var
  CrpeBoxesDlg: TCrpeBoxesDlg;
  bBoxes      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  BoxIndex := -1;
  btnOk.Tag := 1;
  bBoxes := True;
  cbBorderColor.Selected := clBlack;
  cbFillColor.Selected := clNone;
  {Border}
  with cbBorderStyle.Items do
  begin
    Add('lsNone');
    Add('lsSingle');
    Add('lsDouble');
    Add('lsDash');
    Add('lsDot');
  end;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.FormShow(Sender: TObject);
begin
  UpdateBoxes;
end;
{------------------------------------------------------------------------------}
{ UpdateBoxes                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.UpdateBoxes;
var
  OnOff : boolean;
  i     : integer;
begin
  BoxIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Boxes.Count > 0);
    {Get Boxes Index}
    if OnOff then
    begin
      if Cr.Boxes.ItemIndex > -1 then
        BoxIndex := Cr.Boxes.ItemIndex
      else
        BoxIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSectionStart.Clear;
    cbSectionStart.Items.AddStrings(Cr.SectionFormat.Names);
    cbSectionEnd.Clear;
    cbSectionEnd.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.Boxes.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Boxes.Count);
    lbNumbers.ItemIndex := BoxIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TColorBox then
        TColorBox(Components[i]).Enabled := OnOff;
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
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.lbNumbersClick(Sender: TObject);
begin
  BoxIndex := lbNumbers.ItemIndex;
  {Border}
  cbBorderStyle.ItemIndex := Ord(Cr.Boxes[BoxIndex].BorderStyle);
  editBorderWidth.Text := IntToStr(Cr.Boxes.Item.BorderWidth);
  cbBorderColor.Selected := Cr.Boxes.Item.BorderColor;
  cbDropShadow.Checked := Cr.Boxes.Item.DropShadow;
  {FillColor}
  cbFillColor.Selected := Cr.Boxes.Item.FillColor;

  {Format Options}
  cbCloseBorder.Checked := Cr.Boxes.Item.CloseBorder;
  cbExtend.Checked := Cr.Boxes.Item.Extend;
  cbSuppress.Checked := Cr.Boxes.Item.Suppress;
  {Corner Rounding}
  editCornerRoundingHeight.Text := IntToStr(Cr.Boxes.Item.CornerRoundingHeight);
  editCornerRoundingWidth.Text := IntToStr(Cr.Boxes.Item.CornerRoundingWidth);
  {Size and Position}
  cbSectionStart.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Boxes.Item.SectionStart);
  cbSectionEnd.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Boxes.Item.SectionEnd);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbBorderStyleChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbBorderStyleChange(Sender: TObject);
begin
  Cr.Boxes.Item.BorderStyle := TCrLineStyle(cbBorderStyle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editBorderWidthEnter                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editBorderWidthEnter(Sender: TObject);
begin
  PrevSize := editBorderWidth.Text;
end;
{------------------------------------------------------------------------------}
{ editBorderWidthExit                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editBorderWidthExit(Sender: TObject);
begin
  if not IsNumeric(editBorderWidth.Text) then
    editBorderWidth.Text := PrevSize
  else
    Cr.Boxes.Item.BorderWidth := StrToInt(editBorderWidth.Text);
end;
{------------------------------------------------------------------------------}
{ cbBorderColorChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbBorderColorChange(Sender: TObject);
begin
  Cr.Boxes.Item.BorderColor := cbBorderColor.Selected;
end;
{------------------------------------------------------------------------------}
{ cbFillColorChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbFillColorChange(Sender: TObject);
begin
  Cr.Boxes.Item.FillColor := cbFillColor.Selected;
end;
{------------------------------------------------------------------------------}
{ cbDropShadowClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbDropShadowClick(Sender: TObject);
begin
  Cr.Boxes.Item.DropShadow := cbDropShadow.Checked;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Boxes.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editBottom' then
        Cr.Boxes.Item.Bottom := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Boxes.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Cr.Boxes.Item.Right := InchesStrToTwips(TEdit(Sender).Text);
      UpdateBoxes; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Boxes.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editBottom' then
        Cr.Boxes.Item.Bottom := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Boxes.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Cr.Boxes.Item.Right := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Boxes.Item.Top);
    editBottom.Text := TwipsToInchesStr(Cr.Boxes.Item.Bottom);
    editLeft.Text := TwipsToInchesStr(Cr.Boxes.Item.Left);
    editRight.Text := TwipsToInchesStr(Cr.Boxes.Item.Right);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Boxes.Item.Top);
    editBottom.Text := IntToStr(Cr.Boxes.Item.Bottom);
    editLeft.Text := IntToStr(Cr.Boxes.Item.Left);
    editRight.Text := IntToStr(Cr.Boxes.Item.Right);
  end;
end;
{------------------------------------------------------------------------------}
{ cbCloseBorderClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbCloseBorderClick(Sender: TObject);
begin
  Cr.Boxes.Item.CloseBorder := cbCloseBorder.Checked;
end;
{------------------------------------------------------------------------------}
{ cbExtendClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbExtendClick(Sender: TObject);
begin
  Cr.Boxes.Item.Extend := cbExtend.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbSuppressClick(Sender: TObject);
begin
  Cr.Boxes.Item.Suppress := cbSuppress.Checked;
end;
{------------------------------------------------------------------------------}
{ editCornerRoundingEnter                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editCornerRoundingEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editCornerRoundingExit                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.editCornerRoundingExit(Sender: TObject);
begin
  if not IsNumeric(TEdit(Sender).Text) then
    TEdit(Sender).Text := PrevSize
  else
  begin
    if TEdit(Sender).Name = 'editCornerRoundingHeight' then
      Cr.Boxes.Item.CornerRoundingHeight := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editCornerRoundingWidth' then
      Cr.Boxes.Item.CornerRoundingWidth := StrToInt(TEdit(Sender).Text);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionStartChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbSectionStartChange(Sender: TObject);
begin
  Cr.Boxes.Item.SectionStart := cbSectionStart.Items[cbSectionStart.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ cbSectionEndChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.cbSectionEndChange(Sender: TObject);
begin
  Cr.Boxes.Item.SectionEnd := cbSectionEnd.Items[cbSectionEnd.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.btnClearClick(Sender: TObject);
begin
  Cr.Boxes.Clear;
  UpdateBoxes;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateBoxes call}
  if (not IsStrEmpty(Cr.ReportName)) and (BoxIndex > -1) then
  begin
    editSizeExit(editTop);
    editSizeExit(editBottom);
    editSizeExit(editLeft);
    editSizeExit(editRight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bBoxes := False;
  Release;
end;


end.
