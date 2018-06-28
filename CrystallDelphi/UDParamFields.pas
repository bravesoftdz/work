unit UDParamFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeParamFieldsDlg = class(TForm)
    pnlParamFields: TPanel;
    lblName: TLabel;
    lbNames: TListBox;
    btnOk: TButton;
    btnClear: TButton;
    btnRanges: TButton;
    lblPrompt: TLabel;
    lblPromptValue: TLabel;
    lblCurrentValue: TLabel;
    editPrompt: TEdit;
    cbShowDialog: TCheckBox;
    editPromptValue: TEdit;
    editCurrentValue: TEdit;
    lblValueMin: TLabel;
    lblValueMax: TLabel;
    cbValueLimit: TCheckBox;
    editValueMin: TEdit;
    editValueMax: TEdit;
    lblEditMask: TLabel;
    editEditMask: TEdit;
    gbInfo: TGroupBox;
    lblValueType: TLabel;
    lblGroupNum: TLabel;
    cbAllowNull: TCheckBox;
    cbAllowEditing: TCheckBox;
    cbAllowMultipleValues: TCheckBox;
    cbPartOfGroup: TCheckBox;
    cbMutuallyExclusiveGroup: TCheckBox;
    cbValueType: TComboBox;
    editGroupNum: TEdit;
    btnPromptValues: TButton;
    btnPromptValue: TButton;
    btnCurrentValue: TButton;
    btnCurrentValues: TButton;
    cbAllowDialog: TCheckBox;
    gbFormat: TGroupBox;
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
    FontDialog1: TFontDialog;
    cbNeedsCurrentValue: TCheckBox;
    editReportName: TEdit;
    lblReportName: TLabel;
    editParamSource: TEdit;
    lblParamSource: TLabel;
    editParamType: TEdit;
    lblParamType: TLabel;
    lblCount: TLabel;
    editCount: TEdit;
    rgUnits: TRadioGroup;
    btnHiliteConditions: TButton;
    editBrowseField: TEdit;
    lblBrowseField: TLabel;
    cbObjectPropertiesActive: TCheckBox;
    cbIsLinked: TCheckBox;
    procedure UpdateParamFields;
    procedure lbNamesClick(Sender: TObject);
    procedure editPromptChange(Sender: TObject);
    procedure editEditMaskChange(Sender: TObject);
    procedure cbShowDialogClick(Sender: TObject);
    procedure cbValueLimitClick(Sender: TObject);
    procedure editValueMinExit(Sender: TObject);
    procedure editValueMaxExit(Sender: TObject);
    procedure btnRangesClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure editGroupNumExit(Sender: TObject);
    procedure cbAllowNullClick(Sender: TObject);
    procedure cbAllowEditingClick(Sender: TObject);
    procedure cbAllowMultipleValuesClick(Sender: TObject);
    procedure cbPartOfGroupClick(Sender: TObject);
    procedure cbMutuallyExclusiveGroupClick(Sender: TObject);
    procedure cbValueTypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPromptValueClick(Sender: TObject);
    procedure btnCurrentValueClick(Sender: TObject);
    procedure btnCurrentValuesClick(Sender: TObject);
    procedure btnPromptValuesClick(Sender: TObject);
    procedure cbAllowDialogClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure EnableControl(Control: TComponent; Enable: boolean);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure InitializeFormatControls(OnOff: boolean);
    procedure editPromptValueExit(Sender: TObject);
    procedure editCurrentValueExit(Sender: TObject);
    procedure editBrowseFieldExit(Sender: TObject);
    procedure cbObjectPropertiesActiveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    PIndex   : smallint;
    PrevSize : string;
  end;

var
  CrpeParamFieldsDlg: TCrpeParamFieldsDlg;
  bParamFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDPFRanges, UDPFAsDate, UDFormulaEdit,
  UDPFPValues, UDPFCValues, UDBorder, UDFormat, UDHiliteConditions,
  UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.FormCreate(Sender: TObject);
begin
  bParamFields := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  PIndex := -1;
  cbObjectPropertiesActive.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ UpdateParamFields procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.UpdateParamFields;
var
  OnOff : boolean;
begin
  PIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.ParamFields.Count > 0);
    {Get ParamFields Index}
    if OnOff then
    begin
      if Cr.ParamFields.ItemIndex > -1 then
        PIndex := Cr.ParamFields.ItemIndex
      else
        PIndex := 0;
    end;
  end;
  cbObjectPropertiesActive.Checked := Cr.ParamFields.ObjectPropertiesActive;
  InitializeControls(OnOff);

  {Disable items if less than SCR 7+}
  if Cr.Version.Crpe.Major < 7 then
  begin
    btnRanges.Enabled := False;
    cbValueLimit.Enabled := False;
    editValueMin.Color := ColorState(False);
    editValueMax.Color := ColorState(False);
    editValueMin.Enabled := False;
    editValueMax.Enabled := False;
    editEditMask.Enabled := False;
    editBrowseField.Enabled := False;
    editBrowseField.Color := ColorState(False);
    {Info}
    cbAllowNull.Enabled := False;
    cbAllowEditing.Enabled := False;
    cbAllowMultipleValues.Enabled := False;
    cbValueType.Enabled := False;
    cbPartOfGroup.Enabled := False;
    cbMutuallyExclusiveGroup.Enabled := False;
    editGroupNum.Enabled := False;
  end;

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Names ListBox}
    lbNames.Clear;
    lbNames.Items.AddStrings(Cr.ParamFields.Names);
    editCount.Text := IntToStr(Cr.ParamFields.Count);
    lbNames.ItemIndex := PIndex;
    lbNamesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        if not OnOff then
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
procedure TCrpeParamFieldsDlg.InitializeFormatControls(OnOff: boolean);
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
{ lbNamesClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.lbNamesClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  PIndex := lbNames.ItemIndex;
  cbAllowDialog.Checked := (Cr.ParamFields.AllowDialog = True);
  {Set Events to nil}
  cbShowDialog.OnClick := nil;
  editPrompt.OnChange := nil;
  editPromptValue.OnChange := nil;
  editCurrentValue.OnChange := nil;
  editEditMask.OnChange := nil;
  cbValueLimit.OnClick := nil;
  {Update Controls from VCL values}
  Cr.ParamFields[PIndex];
  editPrompt.Text := Cr.ParamFields.Item.Prompt;
  cbShowDialog.Checked := Cr.ParamFields.Item.ShowDialog;

  {Values}
  editPromptValue.Text := Cr.ParamFields.Item.PromptValue;
  editCurrentValue.Text := Cr.ParamFields.Item.CurrentValue;
  EnableControl(editCurrentValue, (Cr.ParamFields.Item.Info.ValueType = vtDiscrete));
  btnPromptValue.Enabled := (Cr.ParamFields.Item.ParamType <> pfString);
  btnCurrentValue.Enabled := (Cr.ParamFields.Item.ParamType <> pfString);
  btnPromptValues.Enabled := (Cr.ParamFields.Item.ParamType <> pfBoolean);
  btnCurrentValues.Enabled := (Cr.ParamFields.Item.Info.ValueType <> vtRange)
     and (Cr.ParamFields.Item.ParamType <> pfBoolean);
  btnRanges.Enabled := (Cr.ParamFields.Item.Info.ValueType = vtRange)
     and (Cr.ParamFields.Item.ParamType <> pfBoolean);

  {Value Limits}
  editEditMask.Text := Cr.ParamFields.Item.EditMask;
  {Disable ValueLimits if boolean type}
  OnOff := (Cr.ParamFields.Item.ParamType <> pfBoolean);
  EnableControl(cbValueLimit, OnOff);
  EnableControl(editValueMin, OnOff);
  EnableControl(editValueMax, OnOff);
  editValueMin.Text := Cr.ParamFields.Item.ValueMin;
  editValueMax.Text := Cr.ParamFields.Item.ValueMax;
  cbValueLimit.Checked := Cr.ParamFields.Item.ValueLimit;
  {Disable ValueMin/Max if ValueLimit off}
  OnOff := Cr.ParamFields.Item.ValueLimit;
  EnableControl(editValueMin, OnOff);
  EnableControl(editValueMax, OnOff);

  {BrowseField}
  editBrowseField.Text := Cr.ParamFields.Item.BrowseField;

  {Parameter information - ReadOnly fields}
  editParamType.Text := GetEnumName(TypeInfo(TCrParamFieldType),
    Ord(Cr.ParamFields.Item.ParamType));
  editParamSource.Text := GetEnumName(TypeInfo(TCrParamFieldSource),
    Ord(Cr.ParamFields.Item.ParamSource));
  editReportName.Text := Cr.ParamFields.Item.ReportName;
  cbNeedsCurrentValue.Checked := Cr.ParamFields.Item.NeedsCurrentValue;
  cbIsLinked.Checked := Cr.ParamFields.Item.IsLinked;
  {Re-Activate Events}
  cbShowDialog.OnClick := cbShowDialogClick;
  editPrompt.OnChange := editPromptChange;
  editEditMask.OnChange := editEditMaskChange;
  editValueMin.OnExit := editValueMinExit;
  editValueMax.OnExit := editValueMaxExit;
  cbValueLimit.OnClick := cbValueLimitClick;

  {ParamFields.Item.Info}
  {Set Events to nil}
  cbAllowNull.OnClick := nil;
  cbAllowEditing.OnClick := nil;
  cbAllowMultipleValues.OnClick := nil;
  cbValueType.OnChange := nil;
  cbPartOfGroup.OnClick := nil;
  cbMutuallyExclusiveGroup.OnClick := nil;
  editGroupNum.OnExit := nil;
  case Ord(Cr.ParamFields.Item.Info.AllowNull) of
    0 : cbAllowNull.State := cbUnchecked;
    1 : cbAllowNull.State := cbChecked;
    2 : cbAllowNull.State := cbGrayed;
  end;
  cbAllowNull.Enabled := (Cr.ParamFields.Item.ParamType <> pfBoolean);
  case Ord(Cr.ParamFields.Item.Info.AllowEditing) of
    0 : cbAllowEditing.State := cbUnchecked;
    1 : cbAllowEditing.State := cbChecked;
    2 : cbAllowEditing.State := cbGrayed;
  end;
  cbAllowEditing.Enabled := (Cr.ParamFields.Item.ParamType <> pfBoolean);
  case Ord(Cr.ParamFields.Item.Info.AllowMultipleValues) of
    0 : cbAllowMultipleValues.State := cbUnchecked;
    1 : cbAllowMultipleValues.State := cbChecked;
    2 : cbAllowMultipleValues.State := cbGrayed;
  end;
  cbAllowMultipleValues.Enabled := (Cr.ParamFields.Item.ParamType <> pfBoolean);
  case Cr.ParamFields.Item.Info.ValueType of
    vtRange    : cbValueType.ItemIndex := 0;
    vtDiscrete : cbValueType.ItemIndex := 1;
    vtDiscreteAndRange : cbValueType.ItemIndex := 2;
  end;
  {Parameter Group properties}
  case Ord(Cr.ParamFields.Item.Info.PartOfGroup) of
    0 : cbPartOfGroup.State := cbUnchecked;
    1 : cbPartOfGroup.State := cbChecked;
    2 : cbPartOfGroup.State := cbGrayed;
  end;
  case Ord(Cr.ParamFields.Item.Info.MutuallyExclusiveGroup) of
    0 : cbMutuallyExclusiveGroup.State := cbUnchecked;
    1 : cbMutuallyExclusiveGroup.State := cbChecked;
    2 : cbMutuallyExclusiveGroup.State := cbGrayed;
  end;
  editGroupNum.Text := IntToStr(Cr.ParamFields.Item.Info.GroupNum);
  {Enable/Disable Group items}
  cbMutuallyExclusiveGroup.Enabled := (cbPartOfGroup.State = cbChecked);
  editGroupNum.Color := ColorState(cbPartOfGroup.State = cbChecked);
  editGroupNum.Enabled := (cbPartOfGroup.State = cbChecked);
  {Re-Activate Info Events}
  cbAllowNull.OnClick := cbAllowNullClick;
  cbAllowEditing.OnClick := cbAllowEditingClick;
  cbAllowMultipleValues.OnClick := cbAllowMultipleValuesClick;
  cbValueType.OnChange := cbValueTypeChange;
  cbPartOfGroup.OnClick := cbPartOfGroupClick;
  cbMutuallyExclusiveGroup.OnClick := cbMutuallyExclusiveGroupClick;
  editGroupNum.OnExit := editGroupNumExit;

  {Activate Format options}
  OnOff := Cr.ParamFields.Item.Handle > 0;
  InitializeFormatControls(OnOff);
  if OnOff then
  begin
    {Field Info}
    editFieldName.Text := Cr.ParamFields.Item.FieldName;
    editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
      Ord(Cr.ParamFields.Item.FieldType));
    editFieldLength.Text := IntToStr(Cr.ParamFields.Item.FieldLength);
    {Size and Position}
    cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.ParamFields.Item.Section);
    rgUnitsClick(Self);
  end;
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.ParamFields.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ EnableControl                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.EnableControl(Control: TComponent; Enable: boolean);
begin
  if Control is TButton then
    TButton(Control).Enabled := Enable;
  if Control is TRadioButton then
    TRadioButton(Control).Enabled := Enable;
  if Control is TCheckBox then
    TCheckBox(Control).Enabled := Enable;
  if Control is TRadioGroup then
    TRadioGroup(Control).Enabled := Enable;
  if Control is TComboBox then
  begin
    TComboBox(Control).Color := ColorState(Enable);
    TComboBox(Control).Enabled := Enable;
  end;
  if Control is TMemo then
  begin
    TMemo(Control).Color := ColorState(Enable);
    TMemo(Control).Enabled := Enable;
  end;
  if Control is TListBox then
  begin
    TListBox(Control).Color := ColorState(Enable);
    TListBox(Control).Enabled := Enable;
  end;
  if Control is TEdit then
  begin
    if TEdit(Control).ReadOnly = False then
      TEdit(Control).Color := ColorState(Enable);
    TEdit(Control).Enabled := Enable;
  end;
end;
{------------------------------------------------------------------------------}
{ cbPShowDialogClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbShowDialogClick(Sender: TObject);
begin
  Cr.ParamFields.Item.ShowDialog := cbShowDialog.Checked;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ editPromptValueExit procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editPromptValueExit(Sender: TObject);
begin
  Cr.ParamFields.Item.PromptValue := editPromptValue.Text;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ editCurrentValueExit procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editCurrentValueExit(Sender: TObject);
begin
  Cr.ParamFields.Item.CurrentValue := editCurrentValue.Text;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ editPromptChange procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editPromptChange(Sender: TObject);
begin
  Cr.ParamFields.Item.Prompt := editPrompt.Text;
end;
{------------------------------------------------------------------------------}
{ btnPromptValueClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnPromptValueClick(Sender: TObject);
begin
  if Cr.ParamFields.Item.ParamType <> pfString then
  begin
    CrpePFAsDateDlg := TCrpePFAsDateDlg.Create(Application);
    CrpePFAsDateDlg.ValueType := Cr.ParamFields.Item.ParamType;
    CrpePFAsDateDlg.Value := Cr.ParamFields.Item.PromptValue;
    if CrpePFAsDateDlg.ShowModal = mrOk then
    begin
      Cr.ParamFields.Item.PromptValue := CrpePFAsDateDlg.Value;
      lbNamesClick(lbNames);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnCurrentValueClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnCurrentValueClick(Sender: TObject);
begin
  if Cr.ParamFields.Item.ParamType <> pfString then
  begin
    CrpePFAsDateDlg := TCrpePFAsDateDlg.Create(Application);
    CrpePFAsDateDlg.ValueType := Cr.ParamFields.Item.ParamType;
    CrpePFAsDateDlg.Value := Cr.ParamFields.Item.CurrentValue;
    if CrpePFAsDateDlg.ShowModal = mrOk then
    begin
      Cr.ParamFields.Item.CurrentValue := CrpePFAsDateDlg.Value;
      lbNamesClick(lbNames);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnCurrentValuesClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnCurrentValuesClick(Sender: TObject);
begin
  CrpePFCurrentValuesDlg := TCrpePFCurrentValuesDlg.Create(Application);
  CrpePFCurrentValuesDlg.Crv := Cr.ParamFields.Item.CurrentValues;
  CrpePFCurrentValuesDlg.ShowModal;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ btnPromptValuesClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnPromptValuesClick(Sender: TObject);
begin
  CrpePFPromptValuesDlg := TCrpePFPromptValuesDlg.Create(Application);
  CrpePFPromptValuesDlg.Crv := Cr.ParamFields.Item.PromptValues;;
  CrpePFPromptValuesDlg.ShowModal;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ btnRangesClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnRangesClick(Sender: TObject);
begin
  CrpeParamFieldRangesDlg := TCrpeParamFieldRangesDlg.Create(Application);
  CrpeParamFieldRangesDlg.Crr := Cr.ParamFields.Item.Ranges;
  CrpeParamFieldRangesDlg.ShowModal;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ editEditMaskChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editEditMaskChange(Sender: TObject);
begin
  Cr.ParamFields.Item.EditMask := editEditMask.Text;
end;
{------------------------------------------------------------------------------}
{ cbValueLimitClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbValueLimitClick(Sender: TObject);
begin
  {ValueMin}
  EnableControl(editValueMin, cbValueLimit.Checked);
  {ValueMax}
  EnableControl(editValueMax, cbValueLimit.Checked);

  if IsStrEmpty(editValueMax.Text) then
  begin
    case Cr.ParamFields.Item.ParamType of
      pfNumber,
      pfCurrency : editValueMax.Text := '0';
      pfDate     : editValueMax.Text := CrDateToStr(Now);
      pfDateTime : editValueMax.Text := CrDateTimeToStr(Now, False);
      pfTime     : editValueMax.Text := CrTimeToStr(Now);
    end;
  end;
  if IsStrEmpty(editValueMin.Text) then
  begin
    case Cr.ParamFields.Item.ParamType of
      pfNumber,
      pfCurrency : editValueMin.Text := '0';
      pfDate     : editValueMin.Text := CrDateToStr(Now);
      pfDateTime : editValueMin.Text := CrDateTimeToStr(Now, False);
      pfTime     : editValueMin.Text := CrTimeToStr(Now);
    end;
  end;
  Cr.ParamFields.Item.ValueLimit := cbValueLimit.Checked;
  if cbValueLimit.Checked then
    editValueMin.SetFocus;
end;
{------------------------------------------------------------------------------}
{ editValueMinExit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editValueMinExit(Sender: TObject);
var
  dtTmp : TDateTime;
begin
  case Cr.ParamFields.Item.ParamType of
    pfNumber,
    pfCurrency :
      begin
        try
          StrToFloat(editValueMin.Text);
          Cr.ParamFields.Item.ValueMin := editValueMin.Text;
        except
          MessageDlg('ValueMin value must be numeric!', mtError, [mbOk], 0);
          editValueMin.SetFocus;
          editValueMin.SelLength := Length(editValueMin.Text);
        end;
      end;
    pfBoolean  : ; {Value Limits don't apply to boolean parameters}
    pfDate     :
      begin
        if not CrStrToDate(editValueMin.Text, dtTmp) then
        begin
          MessageDlg('ValueMin value must be formatted as Date: YYYY,MM,DD', mtError, [mbOk], 0);
          editValueMin.SetFocus;
          editValueMin.SelLength := Length(editValueMin.Text);
        end
        else
          Cr.ParamFields.Item.ValueMin := editValueMin.Text;
      end;
    pfString   : Cr.ParamFields.Item.ValueMin := editValueMin.Text;
    pfDateTime :
      begin
        if not CrStrToDateTime(editValueMin.Text, dtTmp) then
        begin
          MessageDlg('ValueMin value must be formatted as DateTime: YYYY,MM,DD HH:MM:SS', mtError, [mbOk], 0);
          editValueMin.SetFocus;
          editValueMin.SelLength := Length(editValueMin.Text);
        end
        else
          Cr.ParamFields.Item.ValueMin := editValueMin.Text;
      end;
    pfTime     :
      begin
        if not CrStrToTime(editValueMin.Text, dtTmp) then
        begin
          MessageDlg('ValueMin value must be formatted as Time: HH:MM:SS', mtError, [mbOk], 0);
          editValueMin.SetFocus;
          editValueMin.SelLength := Length(editValueMin.Text);
        end
        else
          Cr.ParamFields.Item.ValueMin := editValueMin.Text;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ editValueMaxExit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editValueMaxExit(Sender: TObject);
var
  dtTmp : TDateTime;
begin
  case Cr.ParamFields.Item.ParamType of
    pfNumber,
    pfCurrency :
      begin
        if IsFloating(editValueMax.Text) then
          Cr.ParamFields.Item.ValueMax := editValueMax.Text
        else
        begin
          MessageDlg('ValueMax value must be numeric!', mtError, [mbOk], 0);
          editValueMax.SetFocus;
          editValueMax.SelLength := Length(editValueMax.Text);
        end;
      end;
    pfBoolean  : ; {Ranges don't apply to boolean parameters}
    pfDate     :
      begin
        if not CrStrToDate(editValueMax.Text, dtTmp) then
        begin
          MessageDlg('ValueMax value must be formatted as Date: YYYY,MM,DD', mtError, [mbOk], 0);
          editValueMax.SetFocus;
          editValueMax.SelLength := Length(editValueMax.Text);
        end
        else
          Cr.ParamFields.Item.ValueMax := editValueMax.Text;
      end;
    pfString   : Cr.ParamFields.Item.ValueMax := editValueMax.Text;
    pfDateTime :
      begin
        if not CrStrToDateTime(editValueMax.Text, dtTmp) then
        begin
          MessageDlg('ValueMax value must be formatted as DateTime: YYYY,MM,DD HH:MM:SS', mtError, [mbOk], 0);
          editValueMax.SetFocus;
          editValueMax.SelLength := Length(editValueMax.Text);
        end
        else
          Cr.ParamFields.Item.ValueMax := editValueMax.Text;
      end;
    pfTime     :
      begin
        if not CrStrToTime(editValueMax.Text, dtTmp) then
        begin
          MessageDlg('ValueMax value must be formatted as Time: HH:MM:SS', mtError, [mbOk], 0);
          editValueMax.SetFocus;
          editValueMax.SelLength := Length(editValueMax.Text);
        end
        else
          Cr.ParamFields.Item.ValueMax := editValueMax.Text;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ editBrowseFieldExit procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editBrowseFieldExit(Sender: TObject);
begin
  Cr.ParamFields.Item.BrowseField := editBrowseField.Text;
end;
{------------------------------------------------------------------------------}
{ editGroupNumExit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editGroupNumExit(Sender: TObject);
begin
  try
    StrToInt(editGroupNum.Text);
    Cr.ParamFields.Item.Info.GroupNum := StrToInt(editGroupNum.Text);
  except
    MessageDlg('GroupNum value must be numeric!', mtError, [mbOk], 0);
    editGroupNum.SetFocus;
    editGroupNum.SelLength := Length(editGroupNum.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ cbAllowNullClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbAllowNullClick(Sender: TObject);
begin
  Cr.ParamFields.Item.Info.AllowNull := Boolean(Ord(cbAllowNull.State));
end;
{------------------------------------------------------------------------------}
{ cbAllowEditingClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbAllowEditingClick(Sender: TObject);
begin
  Cr.ParamFields.Item.Info.AllowEditing := Boolean(Ord(cbAllowEditing.State));
end;
{------------------------------------------------------------------------------}
{ cbAllowMultipleValuesClick procedure                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbAllowMultipleValuesClick(Sender: TObject);
begin
  Cr.ParamFields.Item.Info.AllowMultipleValues := Boolean(Ord(cbAllowMultipleValues.State));
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ cbPartOfGroupClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbPartOfGroupClick(Sender: TObject);
begin
  Cr.ParamFields.Item.Info.PartOfGroup := Boolean(Ord(cbPartOfGroup.State));
  {Enable/Disable Group items}
  cbMutuallyExclusiveGroup.Enabled := (cbPartOfGroup.State = cbChecked);
  editGroupNum.Color := ColorState(cbPartOfGroup.State = cbChecked);
  editGroupNum.Enabled := (cbPartOfGroup.State = cbChecked);
end;
{------------------------------------------------------------------------------}
{ cbMutuallyExclusiveGroupClick procedure                                      }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbMutuallyExclusiveGroupClick(
  Sender: TObject);
begin
  Cr.ParamFields.Item.Info.MutuallyExclusiveGroup := Boolean(Ord(cbMutuallyExclusiveGroup.State));
end;
{------------------------------------------------------------------------------}
{ cbValueTypeChange procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbValueTypeChange(Sender: TObject);
begin
  Cr.ParamFields.Item.Info.ValueType := TCrParamInfoValueType(cbValueType.ItemIndex);
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ cbObjectPropertiesActiveClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbObjectPropertiesActiveClick(Sender: TObject);
begin
  Cr.ParamFields.ObjectPropertiesActive := cbObjectPropertiesActive.Checked;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.ParamFields.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.ParamFields.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.ParamFields.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.ParamFields.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.ParamFields.Item.Top);
    editLeft.Text := IntToStr(Cr.ParamFields.Item.Left);
    editWidth.Text := IntToStr(Cr.ParamFields.Item.Width);
    editHeight.Text := IntToStr(Cr.ParamFields.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.ParamFields.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.ParamFields.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.ParamFields.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.ParamFields.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateParamFields; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.ParamFields.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.ParamFields.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.ParamFields.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.ParamFields.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnBorderClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.ParamFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.ParamFields.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.ParamFields.Item.Font);
    if FontDialog1.Execute then
      Cr.ParamFields.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.ParamFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.ParamFields.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.ParamFields.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ cbAllowDialogClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.cbAllowDialogClick(Sender: TObject);
begin
  Cr.ParamFields.AllowDialog := cbAllowDialog.Checked;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.ParamFields.Item.Clear;
  UpdateParamFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateParamFields call}
  if (not IsStrEmpty(Cr.ReportName)) and (PIndex > -1) then
  begin
    editSizeExit(editTop);
    editSizeExit(editLeft);
    editSizeExit(editWidth);
    editSizeExit(editHeight);
    {Explanation: we don't want to accidentally add a Prompt or Current
     Value when there are none in the PromptValues/CurrentValues lists,
     so we check first before running the exit routines}
    if cbShowDialog.Checked then
    begin
      if (Cr.Version.Crpe.Major < 7) or (Cr.ParamFields.Item.PromptValues.Count > 0) then
        editPromptValueExit(Self);
    end
    else
    begin
      if (Cr.Version.Crpe.Major < 7) or (Cr.ParamFields.Item.CurrentValues.Count > 0) then
        editCurrentValueExit(Self);
    end;
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bParamFields := False;
  Release;
end;


end.
