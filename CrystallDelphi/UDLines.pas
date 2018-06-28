unit UDLines;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeLinesDlg = class(TForm)
    lblNumber: TLabel;
    lbNumbers: TListBox;
    lblCount: TLabel;
    editCount: TEdit;
    cbExtend: TCheckBox;
    cbSuppress: TCheckBox;
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
    ColorDialog1: TColorDialog;
    pnlLines: TPanel;
    lblLineStyle: TLabel;
    lblWidth: TLabel;
    lblColor: TLabel;
    cbLineStyle: TComboBox;
    editWidth: TEdit;
    cbColor: TColorBox;
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateLines;
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
    procedure cbLineStyleChange(Sender: TObject);
    procedure editWidthEnter(Sender: TObject);
    procedure editWidthExit(Sender: TObject);
    procedure cbExtendClick(Sender: TObject);
    procedure cbSuppressClick(Sender: TObject);
    procedure cbSectionStartChange(Sender: TObject);
    procedure cbSectionEndChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr          : TCrpe;
    LineIndex   : smallint;
    PrevSize    : string;
    CustomColor : TColor;
  end;

var
  CrpeLinesDlg: TCrpeLinesDlg;
  bLines      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.FormCreate(Sender: TObject);
begin
  bLines := True;
  LoadFormPos(Self);
  LineIndex := -1;
  btnOk.Tag := 1;
  CustomColor := clBlack;
  {LineStyle}
  cbLineStyle.Clear;
  with cbLineStyle.Items do
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
procedure TCrpeLinesDlg.FormShow(Sender: TObject);
begin
  UpdateLines;
end;
{------------------------------------------------------------------------------}
{ UpdateLines                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.UpdateLines;
var
  OnOff : boolean;
  i     : integer;
begin
  LineIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Lines.Count > 0);
    {Get Lines Index}
    if OnOff then
    begin
      if Cr.Lines.ItemIndex > -1 then
        LineIndex := Cr.Lines.ItemIndex
      else
        LineIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSectionStart.Clear;
    cbSectionStart.Items.AddStrings(Cr.SectionFormat.Names);
    cbSectionEnd.Clear;
    cbSectionEnd.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.Lines.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Lines.Count);
    lbNumbers.ItemIndex := LineIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeLinesDlg.lbNumbersClick(Sender: TObject);
begin
  LineIndex := lbNumbers.ItemIndex;
  cbLineStyle.ItemIndex := Ord(Cr.Lines[LineIndex].LineStyle);
  editWidth.Text := IntToStr(Cr.Lines.Item.Width);
  cbColor.Selected := Cr.Lines.Item.Color;
  {Format Options}
  cbExtend.Checked := Cr.Lines.Item.Extend;
  cbSuppress.Checked := Cr.Lines.Item.Suppress;
  {Size and Position}
  cbSectionStart.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Lines.Item.SectionStart);
  cbSectionEnd.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Lines.Item.SectionEnd);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbLineStyleChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbLineStyleChange(Sender: TObject);
begin
  Cr.Lines.Item.LineStyle := TCrLineStyle(cbLineStyle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editWidthEnter                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.editWidthEnter(Sender: TObject);
begin
  PrevSize := editWidth.Text;
end;
{------------------------------------------------------------------------------}
{ editWidthExit                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.editWidthExit(Sender: TObject);
begin
  if not IsNumeric(editWidth.Text) then
    editWidth.Text := PrevSize
  else
    Cr.Lines.Item.Width := StrToInt(editWidth.Text);
end;
{------------------------------------------------------------------------------}
{ cbColorChange                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbColorChange(Sender: TObject);
begin
  Cr.Lines.Item.Color := cbColor.Selected;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Lines.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editBottom' then
        Cr.Lines.Item.Bottom := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Lines.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Cr.Lines.Item.Right := InchesStrToTwips(TEdit(Sender).Text);
      UpdateLines; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Lines.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editBottom' then
        Cr.Lines.Item.Bottom := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Lines.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Cr.Lines.Item.Right := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Lines.Item.Top);
    editBottom.Text := TwipsToInchesStr(Cr.Lines.Item.Bottom);
    editLeft.Text := TwipsToInchesStr(Cr.Lines.Item.Left);
    editRight.Text := TwipsToInchesStr(Cr.Lines.Item.Right);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Lines.Item.Top);
    editBottom.Text := IntToStr(Cr.Lines.Item.Bottom);
    editLeft.Text := IntToStr(Cr.Lines.Item.Left);
    editRight.Text := IntToStr(Cr.Lines.Item.Right);
  end;
end;
{------------------------------------------------------------------------------}
{ cbExtendClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbExtendClick(Sender: TObject);
begin
  Cr.Lines.Item.Extend := cbExtend.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbSuppressClick(Sender: TObject);
begin
  Cr.Lines.Item.Suppress := cbSuppress.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSectionStartChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbSectionStartChange(Sender: TObject);
begin
  Cr.Lines.Item.SectionStart := cbSectionStart.Items[cbSectionStart.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ cbSectionEndChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.cbSectionEndChange(Sender: TObject);
begin
  Cr.Lines.Item.SectionEnd := cbSectionEnd.Items[cbSectionEnd.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.btnClearClick(Sender: TObject);
begin
  Cr.Lines.Clear;
  UpdateLines;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeLinesDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateLines call}
  if (not IsStrEmpty(Cr.ReportName)) and (LineIndex > -1) then 
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
procedure TCrpeLinesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bLines := False;
  Release;
end;


end.

