unit UDSectionFont;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeSectionFontDlg = class(TForm)
    pnlSectionFont: TPanel;
    lblName: TLabel;
    lblSize: TLabel;
    lblCharSet: TLabel;
    lblFamily: TLabel;
    lblWeight: TLabel;
    lblSection: TLabel;
    editName: TEdit;
    pnlSample: TPanel;
    lblSample: TLabel;
    editSize: TEdit;
    btnSelectFont: TBitBtn;
    cbCharSet: TComboBox;
    cbItalic: TCheckBox;
    cbUnderlined: TCheckBox;
    cbStrikeThrough: TCheckBox;
    cbFamily: TComboBox;
    rgScope: TRadioGroup;
    rgPitch: TRadioGroup;
    cbWeight: TComboBox;
    lbSections: TListBox;
    btnOk: TButton;
    btnClear: TButton;
    FontDialog1: TFontDialog;
    lblCount: TLabel;
    editCount: TEdit;
    procedure btnSelectFontClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lbSectionsClick(Sender: TObject);
    procedure editNameChange(Sender: TObject);
    procedure cbItalicClick(Sender: TObject);
    procedure cbUnderlinedClick(Sender: TObject);
    procedure cbStrikeThroughClick(Sender: TObject);
    procedure editSizeKeyPress(Sender: TObject; var Key: Char);
    procedure editSizeExit(Sender: TObject);
    procedure cbWeightChange(Sender: TObject);
    procedure rgScopeClick(Sender: TObject);
    procedure rgPitchClick(Sender: TObject);
    procedure cbCharSetChange(Sender: TObject);
    procedure cbFamilyChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateSectionFont;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr      : TCrpe;
    SFIndex : smallint;
  end;

var
  CrpeSectionFontDlg: TCrpeSectionFontDlg;
  bSectionFont      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.FormCreate(Sender: TObject);
begin
  bSectionFont := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.FormShow(Sender: TObject);
begin
  {Fill in the Combo Boxes}
  {FontWeight}
  cbWeight.Clear;
  cbWeight.Items.Add('fwDefault');
  cbWeight.Items.Add('fwThin');
  cbWeight.Items.Add('fwExtraLight');
  cbWeight.Items.Add('fwLight');
  cbWeight.Items.Add('fwNormal');
  cbWeight.Items.Add('fwMedium');
  cbWeight.Items.Add('fwSemiBold');
  cbWeight.Items.Add('fwBold');
  cbWeight.Items.Add('fwExtraBold');
  cbWeight.Items.Add('fwHeavy');
  {FontCharSet}
  cbCharSet.Clear;
  cbCharSet.Items.Add('fcAnsi');
  cbCharSet.Items.Add('fcDefault');
  cbCharSet.Items.Add('fcSymbol');
  cbCharSet.Items.Add('fcShiftJis');
  cbCharSet.Items.Add('fcHangeul');
  cbCharSet.Items.Add('fcChineseBig5');
  cbCharSet.Items.Add('fcOEM');
  {FontFamily}
  cbFamily.Clear;
  cbFamily.Items.Add('ffDefault');
  cbFamily.Items.Add('ffRoman');
  cbFamily.Items.Add('ffSwiss');
  cbFamily.Items.Add('ffModern');
  cbFamily.Items.Add('ffScript');
  cbFamily.Items.Add('ffDecorative');
  UpdateSectionFont;
end;
{------------------------------------------------------------------------------}
{ UpdateSectionFont procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.UpdateSectionFont;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    SFIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SectionFont.Count > 0);
    {Get SectionFont Index}
    if OnOff then
    begin
      if Cr.SectionFont.ItemIndex > -1 then
        SFIndex := Cr.SectionFont.ItemIndex
      else
        SFIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    lbSections.Items.AddStrings(Cr.SectionFormat.Names);
    editCount.Text := IntToStr(Cr.SectionFont.Count);
    lbSections.ItemIndex := SFIndex;
    lbSectionsClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TBitBtn then
        TBitBtn(Components[i]).Enabled := OnOff;
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
{ lbSectionsClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.lbSectionsClick(Sender: TObject);
begin
  SFIndex := lbSections.ItemIndex;
  {Disable events}
  editSize.OnExit := nil;
  {Update form}
  editName.Text := Cr.SectionFont[SFIndex].Name;
  editSize.Text := IntToStr(Cr.SectionFont.Item.Size);
  cbWeight.ItemIndex := Ord(Cr.SectionFont.Item.Weight);
  cbCharSet.ItemIndex := Ord(Cr.SectionFont.Item.CharSet);
  cbFamily.ItemIndex := Ord(Cr.SectionFont.Item.Family);
  case Ord(Cr.SectionFont.Item.Italic) of
    0: cbItalic.State := cbUnchecked;
    1: cbItalic.State := cbChecked;
    2: cbItalic.State := cbGrayed;
  end;
  case Ord(Cr.SectionFont.Item.Underlined) of
    0: cbUnderlined.State := cbUnchecked;
    1: cbUnderlined.State := cbChecked;
    2: cbUnderlined.State := cbGrayed;
  end;
  case Ord(Cr.SectionFont.Item.StrikeThrough) of
    0: cbStrikeThrough.State := cbUnchecked;
    1: cbStrikeThrough.State := cbChecked;
    2: cbStrikeThrough.State := cbGrayed;
  end;
  rgScope.ItemIndex := Ord(Cr.SectionFont.Item.Scope);
  rgPitch.ItemIndex := Ord(Cr.SectionFont.Item.Pitch);
  {Enable events}
  editSize.OnExit := editSizeExit;
end;
{------------------------------------------------------------------------------}
{ btnSelectFontClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.btnSelectFontClick(Sender: TObject);
var
  nIndex  : integer;
  i       : integer;
begin
  if Cr.SectionFont.Item.Name = '' then
  begin
    {Update Font Dialog font}
    FontDialog1.Font.Name := 'System';
    FontDialog1.Font.Size := 10;
    FontDialog1.Font.Style := [];
  end
  else
  begin
    {Update Font Dialog defaults}
    FontDialog1.Font.Name := Cr.SectionFont.Item.Name;
    FontDialog1.Font.Size := Cr.SectionFont.Item.Size;

    if (Cr.SectionFont.Item.Italic = cTrue) then
      FontDialog1.Font.Style := FontDialog1.Font.Style + [fsItalic]
    else
      FontDialog1.Font.Style := FontDialog1.Font.Style - [fsItalic];

    if (Cr.SectionFont.Item.Underlined = cTrue) then
      FontDialog1.Font.Style := FontDialog1.Font.Style + [fsUnderline]
    else
      FontDialog1.Font.Style := FontDialog1.Font.Style - [fsUnderline];

    if (Cr.SectionFont.Item.StrikeThrough = cTrue) then
      FontDialog1.Font.Style := FontDialog1.Font.Style + [fsStrikeOut]
    else
      FontDialog1.Font.Style := FontDialog1.Font.Style - [fsStrikeOut];

    if (Cr.SectionFont.Item.Weight <> fwDefault) then
      FontDialog1.Font.Style := FontDialog1.Font.Style + [fsBold]
    else
      FontDialog1.Font.Style := FontDialog1.Font.Style - [fsBold];
  end;
  if FontDialog1.Execute then
  begin
    Refresh;
    nIndex := lbSections.ItemIndex;
    {Update Form}
    editName.Text := FontDialog1.Font.Name;
    editSize.Text := IntToStr(FontDialog1.Font.Size);
    cbItalic.Checked := (fsItalic in FontDialog1.Font.Style);
    cbUnderlined.Checked := (fsUnderline in FontDialog1.Font.Style);
    cbStrikeThrough.Checked := (fsStrikeOut in FontDialog1.Font.Style);
    if fsBold in FontDialog1.Font.Style then
      cbWeight.ItemIndex := 7  {fwBold}
    else
      cbWeight.ItemIndex := 0;  {fwDefault}
    {Update Font sample text}
    lblSample.Font.Name := FontDialog1.Font.Name;
    lblSample.Font.Size := FontDialog1.Font.Size;
    lblSample.Font.Style := FontDialog1.Font.Style;
    lblSample.Caption := FontDialog1.Font.Name;
    if lblSample.Font.Size > 0 then
      lblSample.Caption := lblSample.Caption + ' ' +
        editSize.Text + ' point';
    {Update the VCL}
    for i := 0 to (lbSections.Items.Count - 1) do
    begin
      if lbSections.Selected[i] then
      begin
        Cr.SectionFont[i];
        Cr.SectionFont.Item.Name := FontDialog1.Font.Name;
        Cr.SectionFont.Item.Size := FontDialog1.Font.Size;
        if cbItalic.Checked then
          Cr.SectionFont.Item.Italic := cTrue;
        if cbUnderlined.Checked then
          Cr.SectionFont.Item.Underlined := cTrue;
        if cbStrikeThrough.Checked then
          Cr.SectionFont.Item.StrikeThrough := cTrue;
        if cbWeight.ItemIndex = 7 then
          Cr.SectionFont.Item.Weight := fwBold;
      end;
    end;
    lbSections.ItemIndex := nIndex;
    Cr.SectionFont[nIndex];
  end;
end;
{------------------------------------------------------------------------------}
{ editNameChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.editNameChange(Sender: TObject);
begin
  Cr.SectionFont.Item.Name := editName.Text;
  lblSample.Font.Name := editName.Text;
  lblSample.Caption := editName.Text;
  if lblSample.Font.Size > 0 then
    lblSample.Caption := lblSample.Caption + ' ' +
        editSize.Text + ' point';
end;
{------------------------------------------------------------------------------}
{ cbItalicClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbItalicClick(Sender: TObject);
begin
  case cbItalic.State of
    cbUnchecked : Cr.SectionFont.Item.Italic := cFalse;
    cbChecked   : Cr.SectionFont.Item.Italic := cTrue;
    cbGrayed    : Cr.SectionFont.Item.Italic := cDefault;
  end;
  if cbItalic.State = cbUnchecked then
    lblSample.Font.Style := lblSample.Font.Style - [fsItalic];
  if cbItalic.State = cbChecked then
    lblSample.Font.Style := lblSample.Font.Style + [fsItalic];
end;
{------------------------------------------------------------------------------}
{ cbUnderlinedClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbUnderlinedClick(Sender: TObject);
begin
  case cbUnderlined.State of
    cbUnchecked : Cr.SectionFont.Item.Underlined := cFalse;
    cbChecked   : Cr.SectionFont.Item.Underlined := cTrue;
    cbGrayed    : Cr.SectionFont.Item.Underlined := cDefault;
  end;
  if cbUnderlined.State = cbUnchecked then
    lblSample.Font.Style := lblSample.Font.Style - [fsUnderline];
  if cbUnderlined.State = cbChecked then
    lblSample.Font.Style := lblSample.Font.Style + [fsUnderline];
end;
{------------------------------------------------------------------------------}
{ cbStrikeThroughClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbStrikeThroughClick(Sender: TObject);
begin
  case cbStrikeThrough.State of
    cbUnchecked : Cr.SectionFont.Item.StrikeThrough := cFalse;
    cbChecked   : Cr.SectionFont.Item.StrikeThrough := cTrue;
    cbGrayed    : Cr.SectionFont.Item.StrikeThrough := cDefault;
  end;
  if cbStrikeThrough.State = cbUnchecked then
    lblSample.Font.Style := lblSample.Font.Style - [fsStrikeOut];
  if cbStrikeThrough.State = cbChecked then
    lblSample.Font.Style := lblSample.Font.Style + [fsStrikeOut];
end;
{------------------------------------------------------------------------------}
{ cbWeightChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbWeightChange(Sender: TObject);
begin
  Cr.SectionFont.Item.Weight := TCrFontWeight(cbWeight.ItemIndex);
  if Cr.SectionFont.Item.Weight = fwBold then
    lblSample.Font.Style := lblSample.Font.Style + [fsBold];
  if Cr.SectionFont.Item.Weight = fwDefault then
    lblSample.Font.Style := lblSample.Font.Style - [fsBold];
end;
{------------------------------------------------------------------------------}
{ cbCharSetChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbCharSetChange(Sender: TObject);
begin
  Cr.SectionFont.Item.CharSet := TCrFontCharSet(cbCharSet.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbFamilyChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.cbFamilyChange(Sender: TObject);
begin
  Cr.SectionFont.Item.Family := TCrFontFamily(cbFamily.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ rgScopeClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.rgScopeClick(Sender: TObject);
begin
  Cr.SectionFont.Item.Scope := TCrFontScope(rgScope.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ rgPitchClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.rgPitchClick(Sender: TObject);
begin
  Cr.SectionFont.Item.Pitch := TFontPitch(rgPitch.ItemIndex);
  lblSample.Font.Pitch := Cr.SectionFont.Item.Pitch;
end;
{------------------------------------------------------------------------------}
{ editSizeKeyPress procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.editSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(wm_NextDlgCtl,0,0);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.editSizeExit(Sender: TObject);
var
  i : integer;
begin
  try
    i := StrToInt(editSize.Text);
    Cr.SectionFont.Item.Size := i;
    lblSample.Font.Size := i;
    lblSample.Caption := editName.Text;
    if lblSample.Font.Size > 0 then
      lblSample.Caption := lblSample.Caption + ' ' +
        editSize.Text + ' point';
  except
    MessageDlg('Size value must be numeric!', mtWarning, [mbOk], 0);
    editSize.SetFocus;
    editSize.SelLength := Length(editSize.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.btnClearClick(Sender: TObject);
begin
  Cr.SectionFont.Clear;
  UpdateSectionFont;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSectionFont := False;
  Release;
end;


end.
