unit UDFormulas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeFormulasDlg = class(TForm)
    pnlFormulas: TPanel;
    lblFormula: TLabel;
    lblNames: TLabel;
    lbNames: TListBox;
    memoFormulas: TMemo;
    editCount: TEdit;
    lblCount: TLabel;
    cbFormulaSyntax: TComboBox;
    lblFormulaSyntax: TLabel;
    gbFormat: TGroupBox;
    editFieldName: TEdit;
    lblFieldName: TLabel;
    lblFieldType: TLabel;
    editFieldType: TEdit;
    lblFieldLength: TLabel;
    editFieldLength: TEdit;
    btnBorder: TButton;
    btnFont: TButton;
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
    btnClear: TButton;
    FontDialog1: TFontDialog;
    btnCheck: TButton;
    btnCheckAll: TButton;
    rgUnits: TRadioGroup;
    btnHiliteConditions: TButton;
    cbObjectPropertiesActive: TCheckBox;
    procedure btnCheckClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure lbNamesClick(Sender: TObject);
    procedure memoFormulasChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateFormulas;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbFormulaSyntaxChange(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure InitializeFormatControls(OnOff: boolean);
    procedure cbObjectPropertiesActiveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr           : TCrpe;
    PrevSize     : string;
    FormulaIndex : integer;
  end;

var
  CrpeFormulasDlg: TCrpeFormulasDlg;
  bFormulas      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.FormCreate(Sender: TObject);
begin
  bFormulas := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  FormulaIndex := -1;
  cbObjectPropertiesActive.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.FormShow(Sender: TObject);
begin
  UpdateFormulas;
end;
{------------------------------------------------------------------------------}
{ UpdateFormulas                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.UpdateFormulas;
var
  OnOff : boolean;
begin
  FormulaIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Formulas.Count > 0);
    {Get Formulas Index}
    if OnOff then
    begin
      if Cr.Formulas.ItemIndex > -1 then
        FormulaIndex := Cr.Formulas.ItemIndex
      else
        FormulaIndex := 0;
    end;
  end;
  cbObjectPropertiesActive.Checked := Cr.Formulas.ObjectPropertiesActive;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Names ListBox}
    lbNames.Items.AddStrings(Cr.Formulas.Names);
    cbFormulaSyntax.ItemIndex := Ord(Cr.FormulaSyntax);
    editCount.Text := IntToStr(Cr.Formulas.Count);
    lbNames.ItemIndex := FormulaIndex;
    lbNamesClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeFormatControls                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.InitializeFormatControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    {Check Tag}
    if TComponent(Components[i]).Tag <> 0 then
      Continue;
    {Make sure these components are owned by the Format groupbox}
    if Components[i] is TButton then
    begin
      if TButton(Components[i]).Parent <> gbFormat then Continue;
      TButton(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TRadioGroup then
    begin
      if TRadioGroup(Components[i]).Parent <> gbFormat then Continue;
      TRadioGroup(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TComboBox then
    begin
      if TComboBox(Components[i]).Parent <> gbFormat then Continue;
      TComboBox(Components[i]).Color := ColorState(OnOff);
      TComboBox(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent <> gbFormat then Continue;
      TEdit(Components[i]).Text := '';
      if TEdit(Components[i]).ReadOnly = False then
        TEdit(Components[i]).Color := ColorState(OnOff);
      TEdit(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNamesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.lbNamesClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  FormulaIndex := lbNames.ItemIndex;
  memoFormulas.OnChange := nil;
  memoFormulas.Lines.Assign(Cr.Formulas[FormulaIndex].Formula);
  memoFormulas.OnChange := memoFormulasChange;
  cbFormulaSyntax.ItemIndex := Ord(Cr.FormulaSyntax);

  {Activate Format options}
  OnOff := Cr.Formulas.Item.Handle > 0;
  InitializeFormatControls(OnOff);
  if OnOff then
  begin
    {Field Info}
    editFieldName.Text := Cr.Formulas.Item.FieldName;
    editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
      Ord(Cr.Formulas.Item.FieldType));
    editFieldLength.Text := IntToStr(Cr.Formulas.Item.FieldLength);
    {Size and Position}
    cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Formulas.Item.Section);
    rgUnitsClick(Self);
  end;
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.Formulas.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Formulas.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.Formulas.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.Formulas.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.Formulas.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Formulas.Item.Top);
    editLeft.Text := IntToStr(Cr.Formulas.Item.Left);
    editWidth.Text := IntToStr(Cr.Formulas.Item.Width);
    editHeight.Text := IntToStr(Cr.Formulas.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ memoFormulasChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.memoFormulasChange(Sender: TObject);
begin
  Cr.Formulas.Item.Formula.Assign(memoFormulas.Lines);
end;
{------------------------------------------------------------------------------}
{ cbFormulaSyntaxChange                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.cbFormulaSyntaxChange(Sender: TObject);
begin
  Cr.FormulaSyntax := TCrFormulaSyntax(cbFormulaSyntax.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnCheckClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnCheckClick(Sender: TObject);
begin
  if Cr.Formulas.Item.Check then
    MessageDlg('Formula is Good!', mtInformation, [mbOk], 0)
  else
    MessageDlg('Formula has an Error.' + Chr(10) +
      Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnCheckAllClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnCheckAllClick(Sender: TObject);
var
  i : integer;
  s : string;
begin
  Screen.Cursor := crHourglass;
  lbNames.ItemIndex := 0;
  for i := 0 to (lbNames.Items.Count - 1) do
  begin
    lbNames.ItemIndex:= i;
    memoFormulas.OnChange := nil;
    memoFormulas.Lines.Assign(Cr.Formulas[i].Formula);
    memoFormulas.OnChange := memoFormulasChange;
    if not Cr.Formulas.Item.Check then
    begin
      MessageBeep(0);
      s := 'The Formula "' + Cr.Formulas.Item.Name + '" has an error!' +
        Chr(10) + 'Continue checking?';
      if Application.MessageBox(PChar(s), 'Formula Error', MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then
        Continue
      else
        Break;
    end;
  end;
  if i = (lbNames.Items.Count) then
  begin
    MessageBeep(0);
    MessageDlg('Finished verifying formulas!', mtInformation, [mbOk], 0)
  end;
  Screen.Cursor := crDefault;
end;
{------------------------------------------------------------------------------}
{ cbObjectPropertiesActiveClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.cbObjectPropertiesActiveClick(Sender: TObject);
begin
  Cr.Formulas.ObjectPropertiesActive := cbObjectPropertiesActive.Checked;
  UpdateFormulas;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Formulas.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Formulas.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Formulas.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Formulas.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateFormulas; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Formulas.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Formulas.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Formulas.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Formulas.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.cbSectionChange(Sender: TObject);
begin
  Cr.Formulas.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.Formulas.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.Formulas.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.Formulas.Item.Font);
    if FontDialog1.Execute then
      Cr.Formulas.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.Formulas.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.Formulas.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnClearClick(Sender: TObject);
begin
  Cr.Formulas.Clear;
  UpdateFormulas;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateFormulas call}
  if (not IsStrEmpty(Cr.ReportName)) and (FormulaIndex > -1) then 
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
procedure TCrpeFormulasDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bFormulas := False;
  Release;
end;


end.


