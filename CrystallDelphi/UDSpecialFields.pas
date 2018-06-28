unit UDSpecialFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeSpecialFieldsDlg = class(TForm)
    pnlSpecialFields: TPanel;
    lblNames: TLabel;
    lbNumbers: TListBox;
    btnOk: TButton;
    btnClear: TButton;
    FontDialog1: TFontDialog;
    lblFieldName: TLabel;
    lblFieldType: TLabel;
    lblFieldLength: TLabel;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblSection: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editFieldName: TEdit;
    editFieldType: TEdit;
    editFieldLength: TEdit;
    btnBorder: TButton;
    btnFont: TButton;
    btnFormat: TButton;
    editTop: TEdit;
    editLeft: TEdit;
    editWidth: TEdit;
    editHeight: TEdit;
    cbSection: TComboBox;
    lblCount: TLabel;
    editCount: TEdit;
    btnHiliteConditions: TButton;
    rgUnits: TRadioGroup;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSpecialFields;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    SFIndex : smallint;
    PrevSize : string;
  end;

var
  CrpeSpecialFieldsDlg: TCrpeSpecialFieldsDlg;
  bSpecialFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.FormCreate(Sender: TObject);
begin
  bSpecialFields := True;
  LoadFormPos(Self);
  SFIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateSpecialFields;
end;
{------------------------------------------------------------------------------}
{ UpdateSpecialFields                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.UpdateSpecialFields;
var
  i     : smallint;
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
    OnOff := (Cr.SpecialFields.Count > 0);
    {Get SpecialFields Index}
    if OnOff then
    begin
      if Cr.SpecialFields.ItemIndex > -1 then
        SFIndex := Cr.SpecialFields.ItemIndex
      else
        SFIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.SpecialFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.SpecialFields.Count);
    lbNumbers.ItemIndex := SFIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  SFIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.SpecialFields[SFIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFont.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editFieldName.Text := Cr.SpecialFields.Item.FieldName;
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
    Ord(Cr.SpecialFields.Item.FieldType));
  editFieldLength.Text := IntToStr(Cr.SpecialFields.Item.FieldLength);
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.SpecialFields.Item.Section);
  rgUnitsClick(Self);
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.SpecialFields.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.InitializeControls(OnOff: boolean);
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
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SpecialFields.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SpecialFields.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SpecialFields.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SpecialFields.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateSpecialFields; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SpecialFields.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SpecialFields.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SpecialFields.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SpecialFields.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.SpecialFields.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.SpecialFields.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.SpecialFields.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.SpecialFields.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.SpecialFields.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.SpecialFields.Item.Top);
    editLeft.Text := IntToStr(Cr.SpecialFields.Item.Left);
    editWidth.Text := IntToStr(Cr.SpecialFields.Item.Width);
    editHeight.Text := IntToStr(Cr.SpecialFields.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.SpecialFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.SpecialFields.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.SpecialFields.Item.Font);
    if FontDialog1.Execute then
      Cr.SpecialFields.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.SpecialFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.SpecialFields.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.SpecialFields.Clear;
  UpdateSpecialFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (SFIndex > -1) then
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
procedure TCrpeSpecialFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSpecialFields := False;
  Release;
end;


end.
