unit UDMaps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, UCrpe32;

type
  TCrpeMapsDlg = class(TForm)
    pnlMaps: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    GroupBox1: TGroupBox;
    btnBorder: TButton;
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
    pcMaps: TPageControl;
    tsLayout: TTabSheet;
    tsType: TTabSheet;
    tsText: TTabSheet;
    editTitle: TEdit;
    lblTitle: TLabel;
    sbDetail: TSpeedButton;
    sbGroup: TSpeedButton;
    sbCrossTab: TSpeedButton;
    sbOlap: TSpeedButton;
    cbDontSummarizeValues: TCheckBox;
    lblDetail: TLabel;
    lblGroup: TLabel;
    lblCrossTab: TLabel;
    lblOlap: TLabel;
    sbRanged: TSpeedButton;
    sbBarChart: TSpeedButton;
    sbPieChart: TSpeedButton;
    sbGraduated: TSpeedButton;
    lblRanged: TLabel;
    lblBarChart: TLabel;
    lblPieChart: TLabel;
    lblGraduated: TLabel;
    sbDotDensity: TSpeedButton;
    sbIndividualValue: TSpeedButton;
    lblDotDensity: TLabel;
    lblIndividualValue: TLabel;
    gbRanged: TGroupBox;
    lblNumberOfIntervals: TLabel;
    editNumberOfIntervals: TEdit;
    lblDistributionMethod: TLabel;
    cbDistributionMethod: TComboBox;
    lblColorHighestInterval: TLabel;
    lblColorLowestInterval: TLabel;
    cbAllowEmptyIntervals: TCheckBox;
    gbLegend: TGroupBox;
    gbLegendTitle: TGroupBox;
    lblLegendTitle: TLabel;
    lblLegendSubTitle: TLabel;
    rbAuto: TRadioButton;
    rbSpecific: TRadioButton;
    editLegendTitle: TEdit;
    editLegendSubTitle: TEdit;
    rbFull: TRadioButton;
    rbCompact: TRadioButton;
    rbNone: TRadioButton;
    gbPieChart: TGroupBox;
    cbPieProportional: TCheckBox;
    gbDotDensity: TGroupBox;
    lblDotSize: TLabel;
    editDotSize: TEdit;
    lblPieSize: TLabel;
    editPieSize: TEdit;
    rgUnits: TRadioGroup;
    ColorDialog1: TColorDialog;
    gbBarChart: TGroupBox;
    lblBarSize: TLabel;
    editBarSize: TEdit;
    gbConditions: TGroupBox;
    cbOrientation: TComboBox;
    lblOrientation: TLabel;
    cbGroupSelected: TCheckBox;
    btnSummaryFields: TButton;
    btnConditionFields: TButton;
    cbColorHighestInterval: TColorBox;
    cbColorLowestInterval: TColorBox;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateMaps;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rbFullClick(Sender: TObject);
    procedure rbCompactClick(Sender: TObject);
    procedure rbNoneClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure cbColorHighestIntervalChange(Sender: TObject);
    procedure rbAutoClick(Sender: TObject);
    procedure rbSpecificClick(Sender: TObject);
    procedure editLegendTitleChange(Sender: TObject);
    procedure editLegendSubTitleChange(Sender: TObject);
    procedure editTitleChange(Sender: TObject);
    procedure sbRangedClick(Sender: TObject);
    procedure sbDotDensityClick(Sender: TObject);
    procedure sbBarChartClick(Sender: TObject);
    procedure sbPieChartClick(Sender: TObject);
    procedure sbGraduatedClick(Sender: TObject);
    procedure sbIndividualValueClick(Sender: TObject);
    procedure editNumberOfIntervalsChange(Sender: TObject);
    procedure cbDistributionMethodChange(Sender: TObject);
    procedure cbAllowEmptyIntervalsClick(Sender: TObject);
    procedure editDotSizeChange(Sender: TObject);
    procedure editPieSizeChange(Sender: TObject);
    procedure cbPieProportionalClick(Sender: TObject);
    procedure sbDetailClick(Sender: TObject);
    procedure sbGroupClick(Sender: TObject);
    procedure sbCrossTabClick(Sender: TObject);
    procedure sbOlapClick(Sender: TObject);
    procedure cbDontSummarizeValuesClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure cbColorLowestIntervalChange(Sender: TObject);
    procedure editBarSizeChange(Sender: TObject);
    procedure btnSummaryFieldsClick(Sender: TObject);
    procedure btnConditionFieldsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    MapIndex : smallint;
    PrevSize : string;
    CustomHighestColor : TColor;
    CustomLowestColor  : TColor;
  end;

var
  CrpeMapsDlg: TCrpeMapsDlg;
  bMaps      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat, UDMapSumField, UDMapCondField;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.FormCreate(Sender: TObject);
begin
  bMaps := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  MapIndex := -1;
  cbColorHighestInterval.Selected := clNone;
  cbColorLowestInterval.Selected := clNone;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.FormShow(Sender: TObject);
begin
  pcMaps.ActivePage := tsType;
  pcMaps.ActivePage := tsLayout;
  UpdateMaps;
end;
{------------------------------------------------------------------------------}
{ UpdateMaps                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.UpdateMaps;
var
  i     : smallint;
  OnOff : boolean;
begin
  MapIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Maps.Count > 0);
    {Get Boxes Index}
    if OnOff then
    begin
      if Cr.Maps.ItemIndex > -1 then
        MapIndex := Cr.Maps.ItemIndex
      else
        MapIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    for i := 0 to Cr.Maps.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Maps.Count);
    lbNumbers.ItemIndex := MapIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  MapIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.Maps[MapIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  {Layout}
  case Cr.Maps.Item.Layout of
    mlDetail   : sbDetailClick(Self);
    mlGroup    : sbGroupClick(Self);
    mlCrossTab : sbCrossTabClick(Self);
    mlOlap     : sbOlapClick(Self);
  end;
  cbDontSummarizeValues.Checked := Cr.Maps.Item.DontSummarizeValues;
  {Type}
  case Cr.Maps.Item.MapType of
    mttRanged     : sbRangedClick(Self);
    mttBarChart   : sbBarChartClick(Self);
    mttPieChart   : sbPieChartClick(Self);
    mttGraduated  : sbGraduatedClick(Self);
    mttDotDensity : sbDotDensityClick(Self);
    mttIndividualValue : sbIndividualValueClick(Self);
  end;
  {Text}
  editTitle.Text := Cr.Maps.Item.Title;
  case Cr.Maps.Item.Legend of
    mlFull    : rbFullClick(Self);
    mlCompact : rbCompactClick(Self);
    mlNone    : rbNoneClick(Self);
  end;
  case Cr.Maps.Item.LegendTitleType of
    mltAuto     : rbAutoClick(Self);
    mltSpecific : rbSpecificClick(Self);
  end;
  {Formatting}
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Maps.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TColorBox then
        TColorBox(Components[i]).Enabled := OnOff;
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
{ sbDetailClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbDetailClick(Sender: TObject);
begin
  sbDetail.Down := True;
  gbConditions.Visible := False;
  Cr.Maps.Item.Layout := mlDetail;
end;
{------------------------------------------------------------------------------}
{ sbGroupClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbGroupClick(Sender: TObject);
begin
  sbGroup.Down := True;
  gbConditions.Visible := False;
  Cr.Maps.Item.Layout := mlGroup;
end;
{------------------------------------------------------------------------------}
{ sbCrossTabClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbCrossTabClick(Sender: TObject);
begin
  sbCrossTab.Down := True;
  Cr.Maps.Item.Layout := mlCrossTab;
  gbConditions.Visible := True;
  cbOrientation.ItemIndex := Ord(Cr.Maps.Item.Orientation);
  cbGroupSelected.Checked := Cr.Maps.Item.GroupSelected;
end;
{------------------------------------------------------------------------------}
{ sbOlapClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbOlapClick(Sender: TObject);
begin
  sbOlap.Down := True;
  Cr.Maps.Item.Layout := mlOlap;
  gbConditions.Visible := True;
  cbOrientation.ItemIndex := Ord(Cr.Maps.Item.Orientation);
  cbGroupSelected.Checked := Cr.Maps.Item.GroupSelected;
end;
{------------------------------------------------------------------------------}
{ editNumberOfIntervalsChange                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editNumberOfIntervalsChange(Sender: TObject);
begin
  if IsNumeric(editNumberOfIntervals.Text) then
    Cr.Maps.Item.NumberOfIntervals := StrToInt(editNumberOfIntervals.Text)
end;
{------------------------------------------------------------------------------}
{ cbDistributionMethodChange                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbDistributionMethodChange(Sender: TObject);
begin
  Cr.Maps.Item.DistributionMethod := TCrMapDistributionMethod(cbDistributionMethod.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbColorHighestIntervalChange                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbColorHighestIntervalChange(Sender: TObject);
begin
  Cr.Maps.Item.ColorHighestInterval := cbColorHighestInterval.Selected;
  UpdateMaps;
end;
{------------------------------------------------------------------------------}
{ cbColorLowestIntervalChange                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbColorLowestIntervalChange(Sender: TObject);
begin
  Cr.Maps.Item.ColorLowestInterval := cbColorLowestInterval.Selected;
  UpdateMaps;
end;
{------------------------------------------------------------------------------}
{ cbAllowEmptyIntervalsClick                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbAllowEmptyIntervalsClick(Sender: TObject);
begin
  Cr.Maps.Item.AllowEmptyIntervals := cbAllowEmptyIntervals.Checked;
end;
{------------------------------------------------------------------------------}
{ sbRangedClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbRangedClick(Sender: TObject);
begin
  sbRanged.Down := True;
  Cr.Maps.Item.MapType := mttRanged;
  gbPieChart.Visible := False;
  gbBarChart.Visible := False;
  gbDotDensity.Visible := False;
  gbRanged.Visible := True;
  editNumberOfIntervals.Text := IntToStr(Cr.Maps.Item.NumberOfIntervals);
  cbDistributionMethod.ItemIndex := Ord(Cr.Maps.Item.DistributionMethod);
  cbColorHighestInterval.Selected := Cr.Maps.Item.ColorHighestInterval;
  cbColorLowestInterval.Selected := Cr.Maps.Item.ColorLowestInterval;
  cbAllowEmptyIntervals.Checked := Cr.Maps.Item.AllowEmptyIntervals;
end;
{------------------------------------------------------------------------------}
{ sbDotDensityClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbDotDensityClick(Sender: TObject);
begin
  sbDotDensity.Down := True;
  Cr.Maps.Item.MapType := mttDotDensity;
  gbPieChart.Visible := False;
  gbBarChart.Visible := False;
  gbDotDensity.Visible := True;
  gbRanged.Visible := False;
  editDotSize.Text := IntToStr(Cr.Maps.Item.DotSize);
end;
{------------------------------------------------------------------------------}
{ sbBarChartClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbBarChartClick(Sender: TObject);
begin
  sbBarChart.Down := True;
  Cr.Maps.Item.MapType := mttBarChart;
  gbPieChart.Visible := False;
  gbBarChart.Visible := True;
  gbDotDensity.Visible := False;
  gbRanged.Visible := False;
  editBarSize.Text := IntToStr(Cr.Maps.Item.BarSize);
end;
{------------------------------------------------------------------------------}
{ sbPieChartClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbPieChartClick(Sender: TObject);
begin
  sbPieChart.Down := True;
  Cr.Maps.Item.MapType := mttPieChart;
  gbPieChart.Visible := True;
  gbBarChart.Visible := False;
  gbDotDensity.Visible := False;
  gbRanged.Visible := False;
  editPieSize.Text := IntToStr(Cr.Maps.Item.PieSize);
  cbPieProportional.Checked := Cr.Maps.Item.PieProportional;
end;
{------------------------------------------------------------------------------}
{ sbGraduatedClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbGraduatedClick(Sender: TObject);
begin
  sbGraduated.Down := True;
  Cr.Maps.Item.MapType := mttGraduated;
  gbPieChart.Visible := False;
  gbBarChart.Visible := False;
  gbDotDensity.Visible := False;
  gbRanged.Visible := False;
end;
{------------------------------------------------------------------------------}
{ sbIndividualValueClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.sbIndividualValueClick(Sender: TObject);
begin
  sbIndividualValue.Down := True;
  Cr.Maps.Item.MapType := mttIndividualValue;
  gbPieChart.Visible := False;
  gbBarChart.Visible := False;
  gbDotDensity.Visible := False;
  gbRanged.Visible := False;
end;
{------------------------------------------------------------------------------}
{ editDotSizeChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editDotSizeChange(Sender: TObject);
begin
  if IsNumeric(editDotSize.Text) then
    Cr.Maps.Item.DotSize := StrToInt(editDotSize.Text)
end;
{------------------------------------------------------------------------------}
{ editBarSizeChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editBarSizeChange(Sender: TObject);
begin
  if IsNumeric(editBarSize.Text) then
    Cr.Maps.Item.BarSize := StrToInt(editBarSize.Text)
end;
{------------------------------------------------------------------------------}
{ editPieSizeChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editPieSizeChange(Sender: TObject);
begin
  if IsNumeric(editPieSize.Text) then
    Cr.Maps.Item.PieSize := StrToInt(editPieSize.Text)
end;
{------------------------------------------------------------------------------}
{ cbPieProportionalClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbPieProportionalClick(Sender: TObject);
begin
  Cr.Maps.Item.PieProportional := cbPieProportional.Checked;
end;
{------------------------------------------------------------------------------}
{ cbDontSummarizeValuesClick                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbDontSummarizeValuesClick(Sender: TObject);
begin
  Cr.Maps.Item.DontSummarizeValues := cbDontSummarizeValues.Checked;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Maps.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Maps.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Maps.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Maps.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateMaps; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Maps.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Maps.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Maps.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Maps.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ editTitleChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editTitleChange(Sender: TObject);
begin
  Cr.Maps.Item.Title := editTitle.Text;
end;
{------------------------------------------------------------------------------}
{ rbFullClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rbFullClick(Sender: TObject);
begin
  rbAuto.Enabled := True;
  rbSpecific.Enabled := True;
  editLegendTitle.Enabled := rbSpecific.Checked;
  editLegendTitle.Color := ColorState(rbSpecific.Checked);
  editLegendSubTitle.Enabled := rbSpecific.Checked;
  editLegendSubTitle.Color := ColorState(rbSpecific.Checked);
  Cr.Maps.Item.Legend := mlFull;
end;
{------------------------------------------------------------------------------}
{ rbCompactClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rbCompactClick(Sender: TObject);
begin
  rbAuto.Enabled := False;
  rbSpecific.Enabled := False;
  editLegendTitle.Enabled := False;
  editLegendTitle.Color := ColorState(False);
  editLegendSubTitle.Enabled := False;
  editLegendSubTitle.Color := ColorState(False);
  Cr.Maps.Item.Legend := mlCompact;
end;
{------------------------------------------------------------------------------}
{ rbNoneClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rbNoneClick(Sender: TObject);
begin
  rbAuto.Enabled := False;
  rbSpecific.Enabled := False;
  editLegendTitle.Enabled := False;
  editLegendTitle.Color := ColorState(False);
  editLegendSubTitle.Enabled := False;
  editLegendSubTitle.Color := ColorState(False);
  Cr.Maps.Item.Legend := mlNone;
end;
{------------------------------------------------------------------------------}
{ rbAutoClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rbAutoClick(Sender: TObject);
begin
  Cr.Maps.Item.LegendTitleType := mltAuto;
  editLegendTitle.Color := ColorState(False);
  editLegendTitle.Enabled := False;
  editLegendSubTitle.Color := ColorState(False);
  editLegendSubTitle.Enabled := False;
end;
{------------------------------------------------------------------------------}
{ rbSpecificClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rbSpecificClick(Sender: TObject);
begin
  Cr.Maps.Item.LegendTitleType := mltSpecific;
  editLegendTitle.Color := ColorState(True);
  editLegendTitle.Enabled := True;
  editLegendSubTitle.Color := ColorState(True);
  editLegendSubTitle.Enabled := True;
end;
{------------------------------------------------------------------------------}
{ editLegendTitleChange                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editLegendTitleChange(Sender: TObject);
begin
  Cr.Maps.Item.LegendTitle := editLegendTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editLegendSubTitleChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.editLegendSubTitleChange(Sender: TObject);
begin
  Cr.Maps.Item.LegendSubTitle := editLegendSubTitle.Text;
end;
{------------------------------------------------------------------------------}
{ btnSummaryFieldsClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnSummaryFieldsClick(Sender: TObject);
begin
  CrpeMapSummaryFieldsDlg := TCrpeMapSummaryFieldsDlg.Create(Application);
  CrpeMapSummaryFieldsDlg.Crs := Cr.Maps.Item.SummaryFields;
  CrpeMapSummaryFieldsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnConditionFieldsClick                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnConditionFieldsClick(Sender: TObject);
begin
  CrpeMapConditionFieldsDlg := TCrpeMapConditionFieldsDlg.Create(Application);
  CrpeMapConditionFieldsDlg.Crs := Cr.Maps.Item.ConditionFields;
  CrpeMapConditionFieldsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Maps.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.Maps.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.Maps.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.Maps.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Maps.Item.Top);
    editLeft.Text := IntToStr(Cr.Maps.Item.Left);
    editWidth.Text := IntToStr(Cr.Maps.Item.Width);
    editHeight.Text := IntToStr(Cr.Maps.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.Maps.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.Maps.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.Maps.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnClearClick(Sender: TObject);
begin
  Cr.Maps.Clear;
  UpdateMaps;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateMaps call}
  if (not IsStrEmpty(Cr.ReportName)) and (MapIndex > -1) then
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
procedure TCrpeMapsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bMaps := False;
  Release;
end;



end.
