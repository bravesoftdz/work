unit UDSummaryFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeSummaryFieldsDlg = class(TForm)
    pnlSummaryFields: TPanel;
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
    lblField: TLabel;
    lblSummarizedField: TLabel;
    lblSummaryType: TLabel;
    lblSummaryTypeN: TLabel;
    cbSummaryTypeField: TComboBox;
    editName: TEdit;
    cbSummaryType: TComboBox;
    editSummaryTypeN: TEdit;
    cbSummarizedField: TComboBox;
    lblHeaderAreaCode: TLabel;
    lblFooterAreaCode: TLabel;
    editHeaderAreaCode: TEdit;
    editFooterAreaCode: TEdit;
    rgUnits: TRadioGroup;
    btnHiliteConditions: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSummaryFields;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure EditSizeEnter(Sender: TObject);
    procedure EditSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure editNameChange(Sender: TObject);
    procedure cbSummarizedFieldChange(Sender: TObject);
    procedure cbSummaryTypeChange(Sender: TObject);
    procedure cbSummaryTypeFieldChange(Sender: TObject);
    procedure editSummaryTypeNChange(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    SFIndex  : smallint;
    PrevSize : string;
  end;

var
  CrpeSummaryFieldsDlg: TCrpeSummaryFieldsDlg;
  bSummaryFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions, UDFont,
  UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.FormCreate(Sender: TObject);
begin
  bSummaryFields := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  SFIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ UpdateSummaryFields                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.UpdateSummaryFields;
var
  OnOff : boolean;
  i     : integer;
begin
  SFIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.SummaryFields.Count > 0);
    {Get SummaryFields Index}
    if OnOff then
    begin
      if Cr.SummaryFields.ItemIndex > -1 then
        SFIndex := Cr.SummaryFields.ItemIndex
      else
        SFIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill SummarizedField ComboBox}
    cbSummarizedField.Clear;
    cbSummarizedField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill SummaryType ComboBox}
    cbSummaryType.Clear;
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
    {Fill SummaryTypeField ComboBox}
    cbSummaryTypeField.Clear;
    cbSummaryTypeField.Items.AddStrings(Cr.Tables.FieldNames);
    {Fill Numbers ListBox}
    for i := 0 to Cr.SummaryFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.SummaryFields.Count);
    lbNumbers.ItemIndex := SFIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.InitializeControls(OnOff: boolean);
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
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
  i     : integer;
begin
  SFIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.SummaryFields[SFIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFont.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  {Properties}
  editName.Text := Cr.SummaryFields.Item.Name;
  cbSummarizedField.ItemIndex := cbSummarizedField.Items.IndexOf(Cr.SummaryFields.Item.SummarizedField);
  cbSummaryType.ItemIndex := Ord(Cr.SummaryFields.Item.SummaryType);
  case Cr.SummaryFields.Item.SummaryType of
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
        cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Cr.SummaryFields.Item.SummaryTypeField);
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
        editSummaryTypeN.Text := IntToStr(Cr.SummaryFields.Item.SummaryTypeN);
      end;
    {Use SummaryTypeField with GrandTotal field}
    stPercentage      :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        i := cbSummaryTypeField.Items.IndexOf(Cr.SummaryFields.Item.SummaryTypeField);
        if i > -1 then
          cbSummaryTypeField.ItemIndex := i
        else
          cbSummaryTypeField.Text := Cr.SummaryFields.Item.SummaryTypeField;
      end;
  end;
  editHeaderAreaCode.Text := Cr.SummaryFields.Item.HeaderAreaCode;
  editFooterAreaCode.Text := Cr.SummaryFields.Item.FooterAreaCode;
  {Formatting}
  editFieldName.Text := Cr.SummaryFields.Item.FieldName;
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
    Ord(Cr.SummaryFields.Item.FieldType));
  editFieldLength.Text := IntToStr(Cr.SummaryFields.Item.FieldLength);
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.SummaryFields.Item.Section);
  rgUnitsClick(Self);
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.SummaryFields.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ editFieldChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.editNameChange(Sender: TObject);
begin
  Cr.SummaryFields.Item.Name := editName.Text;
end;
{------------------------------------------------------------------------------}
{ cbSummarizedFieldChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.cbSummarizedFieldChange(Sender: TObject);
begin
  Cr.SummaryFields.Item.SummarizedField := cbSummarizedField.Items[cbSummarizedField.ItemIndex];
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.cbSummaryTypeChange(Sender: TObject);
var
  i : integer;
begin
  Cr.SummaryFields.Item.SummaryType := TCrSummaryType(cbSummaryType.ItemIndex);
  case Cr.SummaryFields.Item.SummaryType of
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
        cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Cr.SummaryFields.Item.SummaryTypeField);
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
        editSummaryTypeN.Text := IntToStr(Cr.SummaryFields.Item.SummaryTypeN);
      end;
    {Use SummaryTypeField with GrandTotal field}
    stPercentage      :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        i := cbSummaryTypeField.Items.IndexOf(Cr.SummaryFields.Item.SummaryTypeField);
        if i > -1 then
          cbSummaryTypeField.ItemIndex := i
        else
          cbSummaryTypeField.Text := Cr.SummaryFields.Item.SummaryTypeField;
      end;
  end;
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeFieldChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.cbSummaryTypeFieldChange(Sender: TObject);
begin
  Cr.SummaryFields.Item.SummaryTypeField := cbSummaryTypeField.Items[cbSummaryTypeField.ItemIndex];
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ editSummaryTypeNChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.editSummaryTypeNChange(Sender: TObject);
begin
  if IsNumeric(editSummaryTypeN.Text) then
    Cr.SummaryFields.Item.SummaryTypeN := StrToInt(editSummaryTypeN.Text);
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.SummaryFields.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.SummaryFields.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.SummaryFields.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.SummaryFields.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.SummaryFields.Item.Top);
    editLeft.Text := IntToStr(Cr.SummaryFields.Item.Left);
    editWidth.Text := IntToStr(Cr.SummaryFields.Item.Width);
    editHeight.Text := IntToStr(Cr.SummaryFields.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ EditSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.EditSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ EditSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.EditSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SummaryFields.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SummaryFields.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SummaryFields.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SummaryFields.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateSummaryFields; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SummaryFields.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SummaryFields.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SummaryFields.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SummaryFields.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.SummaryFields.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.SummaryFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.SummaryFields.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.SummaryFields.Item.Font);
    if FontDialog1.Execute then
      Cr.SummaryFields.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.SummaryFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.SummaryFields.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.SummaryFields.Clear;
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateSummaryFields call}
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
procedure TCrpeSummaryFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSummaryFields := False;
  Release;
end;


end.
