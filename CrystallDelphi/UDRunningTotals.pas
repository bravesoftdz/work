unit UDRunningTotals;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeRunningTotalsDlg = class(TForm)
    pnlRunningTotals: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
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
    editName: TEdit;
    cbSummaryType: TComboBox;
    editSummaryTypeN: TEdit;
    cbSummaryTypeField: TComboBox;
    cbSummaryField: TComboBox;
    lblName: TLabel;
    lineSummary: TBevel;
    lblSummary: TLabel;
    lblSummaryField: TLabel;
    lblSummaryType: TLabel;
    lblSummaryTypeN: TLabel;
    lblEvaluate: TLabel;
    lineEvaluate: TBevel;
    pnlEvaluate: TPanel;
    rbEvalNoCondition: TRadioButton;
    rbEvalOnChangeField: TRadioButton;
    rbEvalOnChangeGroup: TRadioButton;
    rbEvalOnFormula: TRadioButton;
    cbEvalField: TComboBox;
    cbEvalGroup: TComboBox;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    sbEvalFormula: TSpeedButton;
    lblReset: TLabel;
    lineReset: TBevel;
    pnlReset: TPanel;
    sbResetFormula: TSpeedButton;
    rbResetNoCondition: TRadioButton;
    rbResetOnChangeField: TRadioButton;
    rbResetOnChangeGroup: TRadioButton;
    rbResetOnFormula: TRadioButton;
    cbResetField: TComboBox;
    cbResetGroup: TComboBox;
    rgUnits: TRadioGroup;
    btnHiliteConditions: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure EditSizeEnter(Sender: TObject);
    procedure EditSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure cbSummaryTypeChange(Sender: TObject);
    procedure cbSummaryFieldChange(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure rbEvalOnChangeFieldClick(Sender: TObject);
    procedure rbEvalOnChangeGroupClick(Sender: TObject);
    procedure rbEvalOnFormulaClick(Sender: TObject);
    procedure rbResetNoConditionClick(Sender: TObject);
    procedure rbEvalNoConditionClick(Sender: TObject);
    procedure rbResetOnChangeFieldClick(Sender: TObject);
    procedure rbResetOnChangeGroupClick(Sender: TObject);
    procedure rbResetOnFormulaClick(Sender: TObject);
    procedure editNameChange(Sender: TObject);
    procedure cbSummaryTypeFieldChange(Sender: TObject);
    procedure editSummaryTypeNChange(Sender: TObject);
    procedure cbEvalFieldChange(Sender: TObject);
    procedure cbEvalGroupChange(Sender: TObject);
    procedure cbResetFieldChange(Sender: TObject);
    procedure cbResetGroupChange(Sender: TObject);
    procedure UpdateRunningTotals;
    procedure InitializeControls(OnOff: boolean);
    procedure InitializeFormatControls(OnOff: boolean);
    procedure sbEvalFormulaClick(Sender: TObject);
    procedure sbResetFormulaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    RTIndex  : integer;
    PrevSize : string;
  end;

var
  CrpeRunningTotalsDlg: TCrpeRunningTotalsDlg;
  bRunningTotals      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFormulaEdit, UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.FormCreate(Sender: TObject);
begin
  bRunningTotals := True;
  LoadFormPos(Self);
  RTIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.FormShow(Sender: TObject);
begin
  UpdateRunningTotals;
end;
{------------------------------------------------------------------------------}
{ UpdateRunningTotals                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.UpdateRunningTotals;
var
  i     : smallint;
  OnOff : boolean;
begin
  RTIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.RunningTotals.Count > 0);
    {Get RunningTotal Index}
    if OnOff then
    begin
      if Cr.RunningTotals.ItemIndex > -1 then
        RTIndex := Cr.RunningTotals.ItemIndex
      else
        RTIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill SummarizedField ComboBox}
    cbSummaryField.Clear;
    cbSummaryField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill SummaryTypeField ComboBox}
    cbSummaryTypeField.Clear;
    cbSummaryTypeField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill EvalField ComboBox}
    cbEvalField.Clear;
    cbEvalField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill EvalGroup ComboBox}
    cbEvalGroup.Clear;
    cbEvalGroup.Items.AddStrings(Cr.Groups.Names);
    {Fill ResetField ComboBox}
    cbResetField.Clear;
    cbResetField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill ResetGroup ComboBox}
    cbResetGroup.Clear;
    cbResetGroup.Items.AddStrings(Cr.Groups.Names);
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.RunningTotals.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.RunningTotals.Count);
    lbNumbers.ItemIndex := RTIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioButton then
        TRadioButton(Components[i]).Enabled := OnOff;
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
{ InitializeFormatControls                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.InitializeFormatControls(OnOff: boolean);
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
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.lbNumbersClick(Sender: TObject);
var
  i         : integer;
  FieldInfo : TCrFieldInfo;
  OnOff     : Boolean;
begin
  RTIndex := lbNumbers.ItemIndex;
  {Name}
  editName.OnChange := nil;
  editName.Text := Cr.RunningTotals[RTIndex].Name;
  editName.OnChange := editNameChange;
  {SummaryField}
  cbSummaryField.OnChange := nil;
  cbSummaryField.ItemIndex := cbSummaryField.Items.IndexOf(Cr.RunningTotals.Item.SummaryField);
  cbSummaryField.OnChange := cbSummaryFieldChange;
  {Fill SummaryType ComboBox - Integer gets all options}
  cbSummaryType.OnChange := nil;
  cbSummaryType.Clear;
  FieldInfo := Cr.FieldNameToFieldInfo(Cr.RunningTotals.Item.SummaryField);
  Cr.Tables.GetFieldInfo(FieldInfo);
  if FieldInfo.FieldType in [fvInt8s..fvCurrency] then
  begin
    cbSummaryType.Items.Add('stSum');
    cbSummaryType.Items.Add('stAverage');
    cbSummaryType.Items.Add('stSampleVariance');
    cbSummaryType.Items.Add('stSampleStdDev');
    cbSummaryType.Items.Add('stMaximum');
    cbSummaryType.Items.Add('stMinimum');
    cbSummaryType.Items.Add('stCount');
    cbSummaryType.Items.Add('stPopVariance');
    cbSummaryType.Items.Add('stPopStdDev');
    cbSummaryType.Items.Add('stDistinctCount');
    cbSummaryType.Items.Add('stCorrelation');
    cbSummaryType.Items.Add('stCoVariance');
    cbSummaryType.Items.Add('stWeightedAvg');
    cbSummaryType.Items.Add('stMedian');
    cbSummaryType.Items.Add('stPercentile');
    cbSummaryType.Items.Add('stNthLargest');
    cbSummaryType.Items.Add('stNthSmallest');
    cbSummaryType.Items.Add('stMode');
    cbSummaryType.Items.Add('stNthMostFrequent');
    cbSummaryType.Items.Add('stPercentage');
    cbSummaryType.ItemIndex := Ord(Cr.RunningTotals.Item.SummaryType);
  end
  {Fill SummaryType ComboBox - String/Date/Time,etc. only get some options}
  else
  begin
    cbSummaryType.Items.Add('stMaximum');
    cbSummaryType.Items.Add('stMinimum');
    cbSummaryType.Items.Add('stCount');
    cbSummaryType.Items.Add('stDistinctCount');
    cbSummaryType.Items.Add('stNthLargest');
    cbSummaryType.Items.Add('stNthSmallest');
    cbSummaryType.Items.Add('stMode');
    cbSummaryType.Items.Add('stNthMostFrequent');
    cbSummaryType.Items.Add('stPercentage');
    case Cr.RunningTotals.Item.SummaryType of
      stMaximum         : cbSummaryType.ItemIndex := 0;
      stMinimum         : cbSummaryType.ItemIndex := 1;
      stCount           : cbSummaryType.ItemIndex := 2;
      stDistinctCount   : cbSummaryType.ItemIndex := 3;
      stNthLargest      : cbSummaryType.ItemIndex := 4;
      stNthSmallest     : cbSummaryType.ItemIndex := 5;
      stMode            : cbSummaryType.ItemIndex := 6;
      stNthMostFrequent : cbSummaryType.ItemIndex := 7;
      stPercentage      : cbSummaryType.ItemIndex := 8;
      else
        cbSummaryType.ItemIndex := 0;
    end;
  end;
  cbSummaryType.OnChange := cbSummaryTypeChange;

  {SummaryTypeN/Field}
  editSummaryTypeN.OnChange := nil;
  cbSummaryTypeField.OnChange := nil;
  editSummaryTypeN.Text := IntToStr(Cr.RunningTotals.Item.SummaryTypeN);
  case Cr.RunningTotals.Item.SummaryType of
    stSum,
    stAverage,
    stSampleVariance,
    stSampleStdDev,
    stMaximum,
    stMinimum,
    stCount,
    stPopVariance,
    stPopStdDev,
    stDistinctCount,
    stMedian,
    stMode            :
      begin
        lblSummaryTypeN.Visible := False;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := False;
      end;
    {Use SummaryTypeField}
    stCorrelation,
    stCoVariance,
    stWeightedAvg     :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Cr.RunningTotals.Item.SummaryTypeField);
      end;
    {Use SummaryTypeN}
    stPercentile,
    stNthLargest,
    stNthSmallest,
    stNthMostFrequent :
      begin
        lblSummaryTypeN.Visible := True;
        cbSummaryTypeField.Visible := False;
        editSummaryTypeN.Visible := True;
      end;
    {Use SummaryTypeField with GrandTotal field}
    stPercentage      :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        i := cbSummaryTypeField.Items.IndexOf(Cr.RunningTotals.Item.SummaryTypeField);
        if i > -1 then
          cbSummaryTypeField.ItemIndex := i
        else
          cbSummaryTypeField.Text := Cr.RunningTotals.Item.SummaryTypeField;
      end;
  end;
  editSummaryTypeN.OnChange := editSummaryTypeNChange;
  cbSummaryTypeField.OnChange := cbSummaryTypeFieldChange;

  {Evaluate}
  case Cr.RunningTotals.Item.EvalCondition of
    rtcNoCondition   : rbEvalNoConditionClick(Self);
    rtcOnChangeField : rbEvalOnChangeFieldClick(Self);
    rtcOnChangeGroup :
      begin
        if Cr.Groups.Count > 0 then
          rbEvalOnChangeGroupClick(Self)
        else
          rbEvalNoConditionClick(Self);
      end;
    rtcOnFormula     : rbEvalOnFormulaClick(Self);
  end;
  {Reset}
  case Cr.RunningTotals.Item.ResetCondition of
    rtcNoCondition   : rbResetNoConditionClick(Self);
    rtcOnChangeField : rbResetOnChangeFieldClick(Self);
    rtcOnChangeGroup :
      begin
        if Cr.Groups.Count > 0 then
          rbResetOnChangeGroupClick(Self)
        else
          rbResetNoConditionClick(Self);
      end;
    rtcOnFormula     : rbResetOnFormulaClick(Self);
  end;

  {Activate Format options}
  OnOff := Cr.RunningTotals.Handle > 0;
  InitializeFormatControls(OnOff);
  if OnOff then
  begin
    {Field Info}
    editFieldName.Text := Cr.RunningTotals.Item.FieldName;
    editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
      Ord(Cr.RunningTotals.Item.FieldType));
    editFieldLength.Text := IntToStr(Cr.RunningTotals.Item.FieldLength);
    {Size and Position}
    cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.RunningTotals.Item.Section);
    rgUnitsClick(Self);
  end;
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.RunningTotals.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ cbSummaryFieldChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbSummaryFieldChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.SummaryField := cbSummaryField.Text;
  UpdateRunningTotals; {needed to refresh SummaryType combo-box}
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbSummaryTypeChange(Sender: TObject);
var
  i : integer;
  x : integer;
begin
  x := GetEnumValue(TypeInfo(TCrSummaryType), cbSummaryType.Text);
  Cr.RunningTotals.Item.SummaryType := TCrSummaryType(x);
  case Cr.RunningTotals.Item.SummaryType of
    stSum,
    stAverage,
    stSampleVariance,
    stSampleStdDev,
    stMaximum,
    stMinimum,
    stCount,
    stPopVariance,
    stPopStdDev,
    stDistinctCount,
    stMedian,
    stMode            :
      begin
        lblSummaryTypeN.Visible := False;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := False;
      end;
    {Use SummaryTypeField}
    stCorrelation,
    stCoVariance,
    stWeightedAvg     :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Cr.RunningTotals.Item.SummaryTypeField);
      end;
    {Use SummaryTypeN}
    stPercentile,
    stNthLargest,
    stNthSmallest,
    stNthMostFrequent :
      begin
        lblSummaryTypeN.Visible := True;
        cbSummaryTypeField.Visible := False;
        editSummaryTypeN.Visible := True;
        editSummaryTypeN.Text := IntToStr(Cr.RunningTotals.Item.SummaryTypeN);
      end;
    {Use SummaryTypeField with GrandTotal field}
    stPercentage      :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        i := cbSummaryTypeField.Items.IndexOf(Cr.RunningTotals.Item.SummaryTypeField);
        if i > -1 then
          cbSummaryTypeField.ItemIndex := i
        else
          cbSummaryTypeField.Text := Cr.RunningTotals.Item.SummaryTypeField;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ rbEvalNoConditionClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbEvalNoConditionClick(Sender: TObject);
begin
  Cr.RunningTotals.Item.EvalCondition := rtcNoCondition;
  rbEvalNoCondition.Checked := True;
  sbEvalFormula.Enabled := False;
end;
{------------------------------------------------------------------------------}
{ rbEvalOnChangeFieldClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbEvalOnChangeFieldClick(Sender: TObject);
begin
  rbEvalOnChangeField.Checked := True;
  sbEvalFormula.Enabled := False;
  cbEvalGroup.ItemIndex := -1;
  Cr.RunningTotals.Item.EvalCondition := rtcOnChangeField;
  cbEvalField.ItemIndex := cbEvalField.Items.IndexOf(Cr.RunningTotals.Item.EvalField);
  if cbEvalField.ItemIndex = -1 then
    cbEvalField.ItemIndex := 0;
end;
{------------------------------------------------------------------------------}
{ rbEvalOnChangeGroupClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbEvalOnChangeGroupClick(Sender: TObject);
begin
  if Cr.Groups.Count > 0 then
  begin
    rbEvalOnChangeGroup.Checked := True;
    sbEvalFormula.Enabled := False;
    cbEvalField.ItemIndex := -1;
    Cr.RunningTotals.Item.EvalCondition := rtcOnChangeGroup;
    cbEvalGroup.ItemIndex := Cr.RunningTotals.Item.EvalGroupN;
  end
  else
  begin
    rbEvalNoConditionClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ rbEvalOnFormulaClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbEvalOnFormulaClick(Sender: TObject);
begin
  Cr.RunningTotals.Item.EvalCondition := rtcOnFormula;
  rbEvalOnFormula.Checked := True;
  sbEvalFormula.Enabled := True;
  if not IsStringListEmpty(Cr.RunningTotals.Item.EvalFormula) then
  begin
    if sbEvalFormula.Glyph <> sbFormulaRed.Glyph then
      sbEvalFormula.Glyph := sbFormulaRed.Glyph;
  end
  else
  begin
    if sbEvalFormula.Glyph <> sbFormulaBlue.Glyph then
      sbEvalFormula.Glyph := sbFormulaBlue.Glyph
  end;
end;
{------------------------------------------------------------------------------}
{ rbResetNoConditionClick                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbResetNoConditionClick(Sender: TObject);
begin
  Cr.RunningTotals.Item.ResetCondition := rtcNoCondition;
  rbResetNoCondition.Checked := True;
  sbResetFormula.Enabled := False;
end;
{------------------------------------------------------------------------------}
{ rbResetOnChangeFieldClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbResetOnChangeFieldClick(Sender: TObject);
begin
  rbResetOnChangeField.Checked := True;
  sbResetFormula.Enabled := False;
  cbResetGroup.ItemIndex := -1;
  Cr.RunningTotals.Item.ResetCondition := rtcOnChangeField;
  cbResetField.ItemIndex := cbResetField.Items.IndexOf(Cr.RunningTotals.Item.ResetField);
  if cbResetField.ItemIndex = -1 then
    cbResetField.ItemIndex := 0;
end;
{------------------------------------------------------------------------------}
{ rbResetOnChangeGroupClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbResetOnChangeGroupClick(Sender: TObject);
begin
  if Cr.Groups.Count > 0 then
  begin
    Cr.RunningTotals.Item.ResetCondition := rtcOnChangeGroup;
    rbResetOnChangeGroup.Checked := True;
    sbResetFormula.Enabled := False;
    cbResetGroup.ItemIndex := Cr.RunningTotals.Item.ResetGroupN;
  end
  else
  begin
    rbResetNoConditionClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ rbResetOnFormulaClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rbResetOnFormulaClick(Sender: TObject);
begin
  Cr.RunningTotals.Item.ResetCondition := rtcOnFormula;
  rbResetOnFormula.Checked := True;
  sbResetFormula.Enabled := True;

  if not IsStringListEmpty(Cr.RunningTotals.Item.ResetFormula) then
  begin
    if sbResetFormula.Glyph <> sbFormulaRed.Glyph then
      sbResetFormula.Glyph := sbFormulaRed.Glyph;
  end
  else
  begin
    if sbResetFormula.Glyph <> sbFormulaBlue.Glyph then
      sbResetFormula.Glyph := sbFormulaBlue.Glyph
  end;
end;
{------------------------------------------------------------------------------}
{ editNameChange                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.editNameChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.Name := editName.Text;
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeFieldChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbSummaryTypeFieldChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.SummaryTypeField := cbSummaryTypeField.Text;
end;
{------------------------------------------------------------------------------}
{ editSummaryTypeNChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.editSummaryTypeNChange(Sender: TObject);
begin
  if IsNumeric(editSummaryTypeN.Text) then
    Cr.RunningTotals.Item.SummaryTypeN := StrToInt(editSummaryTypeN.Text);
end;
{------------------------------------------------------------------------------}
{ cbEvalFieldChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbEvalFieldChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.EvalField := cbEvalField.Text;
end;
{------------------------------------------------------------------------------}
{ cbEvalGroupChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbEvalGroupChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.EvalGroupN := cbEvalGroup.ItemIndex;
end;
{------------------------------------------------------------------------------}
{ sbEvalFormulaClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.sbEvalFormulaClick(Sender: TObject);
var
  xList : TStrings;
begin
  xList := Cr.RunningTotals.Item.EvalFormula;
  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;
  {Update the main form}
  lbNumbersClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbResetFieldChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbResetFieldChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.ResetField := cbResetField.Text;
end;
{------------------------------------------------------------------------------}
{ cbResetGroupChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbResetGroupChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.ResetGroupN := cbResetGroup.ItemIndex;
end;
{------------------------------------------------------------------------------}
{ sbResetFormulaClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.sbResetFormulaClick(Sender: TObject);
var
  xList : TStrings;
begin
  xList := Cr.RunningTotals.Item.ResetFormula;
  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;
  {Update the main form}
  lbNumbersClick(Self);
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.RunningTotals.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.RunningTotals.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.RunningTotals.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.RunningTotals.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.RunningTotals.Item.Top);
    editLeft.Text := IntToStr(Cr.RunningTotals.Item.Left);
    editWidth.Text := IntToStr(Cr.RunningTotals.Item.Width);
    editHeight.Text := IntToStr(Cr.RunningTotals.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ EditSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.EditSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ EditSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.EditSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.RunningTotals.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.RunningTotals.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.RunningTotals.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.RunningTotals.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateRunningTotals; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.RunningTotals.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.RunningTotals.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.RunningTotals.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.RunningTotals.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.RunningTotals.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.RunningTotals.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.RunningTotals.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.RunningTotals.Item.Font);
    if FontDialog1.Execute then
      Cr.RunningTotals.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.RunningTotals.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.RunningTotals.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnClearClick(Sender: TObject);
begin
  Cr.RunningTotals.Clear;
  UpdateRunningTotals;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateRunningTotals call}
  if (not IsStrEmpty(Cr.ReportName)) and (RTIndex > -1) then 
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
procedure TCrpeRunningTotalsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bRunningTotals := False;
  Release;
end;


end.
