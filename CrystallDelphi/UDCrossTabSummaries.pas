unit UDCrossTabSummaries;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeCrossTabSummariesDlg = class(TForm)
    pnlCrossTabs: TPanel;
    lblNumber: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    btnOk: TButton;
    lblSummarizedField: TLabel;
    lblFieldType: TLabel;
    lblFieldLength: TLabel;
    editSummarizedField: TEdit;
    editFieldType: TEdit;
    editFieldLength: TEdit;
    lblSummaryType: TLabel;
    cbSummaryType: TComboBox;
    lblSummaryTypeN: TLabel;
    editSummaryTypeN: TEdit;
    cbSummaryTypeField: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateSummaries;
    procedure InitializeControls(OnOff: boolean);
    procedure btnOkClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure editSummarizedFieldChange(Sender: TObject);
    procedure cbSummaryTypeChange(Sender: TObject);
    procedure editSummaryTypeNChange(Sender: TObject);
    procedure cbSummaryTypeFieldChange(Sender: TObject);
  private
    { Private declarations }
  public
    Crs : TCrpeCrossTabSummaries;
    SummaryIndex : integer;
  end;

var
  CrpeCrossTabSummariesDlg: TCrpeCrossTabSummariesDlg;
  bCrossTabSummaries      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.FormCreate(Sender: TObject);
begin
  bCrossTabSummaries := True;
  LoadFormPos(Self);
  SummaryIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.FormShow(Sender: TObject);
begin
  UpdateSummaries;
end;
{------------------------------------------------------------------------------}
{ UpdateSummaries                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.UpdateSummaries;
var
  i : smallint;
  OnOff : boolean;
begin
  SummaryIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crs.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crs.Count > 0);
    {Get CrossTab Summaries Index}
    if OnOff then
    begin
      if Crs.ItemIndex > -1 then
        SummaryIndex := Crs.ItemIndex
      else
        SummaryIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill SummaryTypeField ComboBox}
    cbSummaryTypeField.Clear;
    cbSummaryTypeField.Items.AddStrings(Crs.Cr.Tables.FieldNames);
    {Fill Numbers ListBox}
    for i := 0 to Crs.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crs.Count);
    lbNumbers.ItemIndex := SummaryIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.InitializeControls(OnOff: boolean);
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
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.lbNumbersClick(Sender: TObject);
begin
  SummaryIndex := lbNumbers.ItemIndex;
  Crs[SummaryIndex];
  {CrossTab Summary options}
  editSummarizedField.Text := Crs.Item.SummarizedField;
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType), Ord(Crs.Item.FieldType));
  editFieldLength.Text := IntToStr(Crs.Item.FieldLength);
//  editSummaryTypeN.Text := IntToStr(Crs.Item.SummaryTypeN);
//  cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Crs.Item.SummaryTypeField);
  cbSummaryType.ItemIndex := Ord(Crs.Item.SummaryType);
  cbSummaryTypeChange(Self);
end;
{------------------------------------------------------------------------------}
{ editSummarizedFieldNameChange                                                }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.editSummarizedFieldChange(
  Sender: TObject);
begin
  Crs.Item.SummarizedField := editSummarizedField.Text;
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.cbSummaryTypeChange(Sender: TObject);
var
  i : integer;
begin
  Crs.Item.SummaryType := TCrSummaryType(cbSummaryType.ItemIndex);
  case Crs.Item.SummaryType of
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
        cbSummaryTypeField.ItemIndex := cbSummaryTypeField.Items.IndexOf(Crs.Item.SummaryTypeField);
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
        editSummaryTypeN.Text := IntToStr(Crs.Item.SummaryTypeN);
      end;
    {Use SummaryTypeField with GrandTotal field}
    stPercentage      :
      begin
        lblSummaryTypeN.Visible := True;
        editSummaryTypeN.Visible := False;
        cbSummaryTypeField.Visible := True;
        i := cbSummaryTypeField.Items.IndexOf(Crs.Item.SummaryTypeField);
        if i > -1 then
          cbSummaryTypeField.ItemIndex := i
        else
          cbSummaryTypeField.Text := Crs.Item.SummaryTypeField;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ editSummaryTypeNChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.editSummaryTypeNChange(
  Sender: TObject);
begin
  if IsNumeric(editSummaryTypeN.Text) then
    Crs.Item.SummaryTypeN := StrToInt(editSummaryTypeN.Text);
end;
{------------------------------------------------------------------------------}
{ cbSummaryTypeFieldChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.cbSummaryTypeFieldChange(
  Sender: TObject);
begin
  Crs.Item.SummaryTypeField := cbSummaryTypeField.Items[cbSummaryTypeField.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bCrossTabSummaries := False;
  Release;
end;


end.
