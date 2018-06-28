unit UDDatabaseFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeDatabaseFieldsDlg = class(TForm)
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
    procedure UpdateDatabaseFields;
    procedure rgUnitsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    DBIndex  : smallint;
    PrevSize : string;
  end;

var
  CrpeDatabaseFieldsDlg: TCrpeDatabaseFieldsDlg;
  bDatabaseFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFieldSelect, UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.FormCreate(Sender: TObject);
begin
  bDatabaseFields := True;
  LoadFormPos(Self);
  DBIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateDatabaseFields;
end;
{------------------------------------------------------------------------------}
{ UpdateDatabaseFields                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.UpdateDatabaseFields;
var
  i     : smallint;
  OnOff : boolean;
begin
  DBIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.DatabaseFields.Count > 0);
    {Get DatabaseFields Index}
    if OnOff then
    begin
      if Cr.DatabaseFields.ItemIndex > -1 then
        DBIndex := Cr.DatabaseFields.ItemIndex
      else
        DBIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.DatabaseFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.DatabaseFields.Count);
    lbNumbers.ItemIndex := DBIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeDatabaseFieldsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  DBIndex := lbNumbers.ItemIndex;
  Cr.DatabaseFields[DBIndex];
  OnOff := (Cr.DatabaseFields.Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFont.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  {Get Object info}
  editFieldName.Text := Cr.DatabaseFields.Item.FieldName;
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
    Ord(Cr.DatabaseFields.Item.FieldType));
  editFieldLength.Text := IntToStr(Cr.DatabaseFields.Item.FieldLength);
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.DatabaseFields.Item.Section);
  rgUnitsClick(Self);
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.DatabaseFields.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.DatabaseFields.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.DatabaseFields.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.DatabaseFields.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.DatabaseFields.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateDatabaseFields; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.DatabaseFields.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.DatabaseFields.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.DatabaseFields.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.DatabaseFields.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.DatabaseFields.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.DatabaseFields.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.DatabaseFields.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.DatabaseFields.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.DatabaseFields.Item.Top);
    editLeft.Text := IntToStr(Cr.DatabaseFields.Item.Left);
    editWidth.Text := IntToStr(Cr.DatabaseFields.Item.Width);
    editHeight.Text := IntToStr(Cr.DatabaseFields.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.DatabaseFields.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.DatabaseFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.DatabaseFields.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.DatabaseFields.Item.Font);
    if FontDialog1.Execute then
      Cr.DatabaseFields.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.DatabaseFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.DatabaseFields.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.DatabaseFields.Clear;
  UpdateDatabaseFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (DBIndex > -1) then
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
procedure TCrpeDatabaseFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bDatabaseFields := False;
  Release;
end;


end.
