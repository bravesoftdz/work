unit UDGroupNameFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeGroupNameFieldsDlg = class(TForm)
    btnOk: TButton;
    btnClear: TButton;
    pnlCrossTabs: TPanel;
    lblNumber: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
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
    btnHiliteConditions: TButton;
    FontDialog1: TFontDialog;
    rgUnits: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure UpdateGroupNameFields;
    procedure rgUnitsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    GNIndex  : smallint;
    PrevSize : string;
  end;

var
  CrpeGroupNameFieldsDlg: TCrpeGroupNameFieldsDlg;
  bGroupnameFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.FormCreate(Sender: TObject);
begin
  bGroupnameFields := True;
  LoadFormPos(Self);
  GNIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateGroupNameFields;
end;
{------------------------------------------------------------------------------}
{ UpdateGroupNameFields                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.UpdateGroupNameFields;
var
  OnOff : boolean;
  i     : integer;
begin
  GNIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.GroupNameFields.Count > 0);
    {Get GroupNameFields Index}
    if OnOff then
    begin
      if Cr.GroupNameFields.ItemIndex > -1 then
        GNIndex := Cr.GroupNameFields.ItemIndex
      else
        GNIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.GroupNameFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.GroupNameFields.Count);
    lbNumbers.ItemIndex := GNIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  GNIndex := lbNumbers.ItemIndex;
  Cr.GroupNameFields[GNIndex];
  OnOff := (Cr.GroupNameFields.Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFont.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editFieldName.Text := Cr.GroupNameFields.Item.FieldName;
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
    Ord(Cr.GroupNameFields.Item.FieldType));
  editFieldLength.Text := IntToStr(Cr.GroupNameFields.Item.FieldLength);
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.GroupNameFields.Item.Section);
  rgUnitsClick(Self);
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.GroupNameFields.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ Initialize                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.InitializeControls(OnOff: boolean);
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
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.GroupNameFields.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.editSizeExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GNIndex = -1 then Exit;
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.GroupNameFields.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.GroupNameFields.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.GroupNameFields.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.GroupNameFields.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateGroupNameFields; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.GroupNameFields.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.GroupNameFields.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.GroupNameFields.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.GroupNameFields.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.GroupNameFields.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.GroupNameFields.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.GroupNameFields.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.GroupNameFields.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.GroupNameFields.Item.Top);
    editLeft.Text := IntToStr(Cr.GroupNameFields.Item.Left);
    editWidth.Text := IntToStr(Cr.GroupNameFields.Item.Width);
    editHeight.Text := IntToStr(Cr.GroupNameFields.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.GroupNameFields.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.GroupNameFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.GroupNameFields.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.GroupNameFields.Item.Font);
    if FontDialog1.Execute then
      Cr.GroupNameFields.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.GroupNameFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.GroupNameFields.Clear;
  UpdateGroupNameFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (GNIndex > -1) then 
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
procedure TCrpeGroupNameFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bGroupnameFields := False;
  Release;
end;


end.
