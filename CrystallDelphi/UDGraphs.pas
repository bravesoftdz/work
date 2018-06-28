unit UDGraphs;

{$I UCRPEDEF.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ImgList, UCrpe32;

type
  TCrpeGraphsDlg = class(TForm)
    btnOk: TButton;
    btnClear: TButton;
    ilSmall: TImageList;
    FontDialog1: TFontDialog;
    ScrollBox1: TScrollBox;
    Bar1: TImage;
    Bar2: TImage;
    Bar3: TImage;
    Bar4: TImage;
    Bar5: TImage;
    Bar6: TImage;
    Line1: TImage;
    Line2: TImage;
    Line3: TImage;
    Line4: TImage;
    Line5: TImage;
    Line6: TImage;
    Area1: TImage;
    Area2: TImage;
    Area3: TImage;
    Area4: TImage;
    Area5: TImage;
    Area6: TImage;
    Pie1: TImage;
    Pie2: TImage;
    Pie3: TImage;
    Pie4: TImage;
    Doughnut1: TImage;
    Doughnut2: TImage;
    Doughnut3: TImage;
    ThreeDRiser1: TImage;
    ThreeDRiser2: TImage;
    ThreeDRiser3: TImage;
    ThreeDRiser4: TImage;
    ThreeDSurface1: TImage;
    ThreeDSurface2: TImage;
    ThreeDSurface3: TImage;
    XYScatter1: TImage;
    XYScatter2: TImage;
    XYScatter3: TImage;
    XYScatter4: TImage;
    Radar1: TImage;
    Radar2: TImage;
    Radar3: TImage;
    Bubble1: TImage;
    Bubble2: TImage;
    Stock1: TImage;
    Stock2: TImage;
    Stock3: TImage;
    Stock4: TImage;
    Stock5: TImage;
    Stock6: TImage;
    pnlGraphs: TPanel;
    pcGraphs: TPageControl;
    tsTypeX: TTabSheet;
    pnlTypeX: TPanel;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb4: TSpeedButton;
    sb5: TSpeedButton;
    sb3: TSpeedButton;
    sb6: TSpeedButton;
    sb7: TSpeedButton;
    tvTypes: TTreeView;
    tsText: TTabSheet;
    pnlText: TPanel;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    lblFootnote: TLabel;
    lblSeries: TLabel;
    lblGroupsTitle: TLabel;
    lblXAxisTitle: TLabel;
    lblAxisTitle: TLabel;
    lblZAxisTitle: TLabel;
    sbTitleFont: TSpeedButton;
    sbSubTitleFont: TSpeedButton;
    sbFootNoteFont: TSpeedButton;
    sbGroupsTitleFont: TSpeedButton;
    sbDataTitleFont: TSpeedButton;
    sbLegendFont: TSpeedButton;
    sbGroupLabelsFont: TSpeedButton;
    sbDataLabelsFont: TSpeedButton;
    editTitle: TEdit;
    editSubTitle: TEdit;
    editFootnote: TEdit;
    editSeriesTitle: TEdit;
    editGroupsTitle: TEdit;
    editXAxisTitle: TEdit;
    editYAxisTitle: TEdit;
    editZAxisTitle: TEdit;
    pnlTitleFont: TPanel;
    lblTitleFont: TLabel;
    pnlSubTitleFont: TPanel;
    lblSubTitleFont: TLabel;
    pnlFootNoteFont: TPanel;
    lblFootNoteFont: TLabel;
    pnlGroupsTitleFont: TPanel;
    lblGroupsTitleFont: TLabel;
    pnlDataTitleFont: TPanel;
    lblDataTitleFont: TLabel;
    pnlLegendFont: TPanel;
    lblLegendFont: TLabel;
    pnlGroupLabelsFont: TPanel;
    lblGroupLabelsFont: TLabel;
    pnlDataLabelsFont: TPanel;
    lblDataLabelsFont: TLabel;
    tsOptionInfo: TTabSheet;
    pnlOptionInfo: TPanel;
    lblColor: TLabel;
    lblLegend: TLabel;
    lblPieSize: TLabel;
    lblPieSlice: TLabel;
    lblBarSize: TLabel;
    lblBarDirection: TLabel;
    lblMarkerSize: TLabel;
    lblMarkerShape: TLabel;
    lblViewingAngle: TLabel;
    cbColor: TComboBox;
    cbLegend: TComboBox;
    cbPieSize: TComboBox;
    cbPieSlice: TComboBox;
    cbBarSize: TComboBox;
    cbBarDirection: TComboBox;
    cbMarkerSize: TComboBox;
    cbMarkerShape: TComboBox;
    gbDataPoints: TGroupBox;
    lblNumberFormat2: TLabel;
    rbNone: TRadioButton;
    rbShowLabel: TRadioButton;
    cbNumberFormat: TComboBox;
    rbShowValue: TRadioButton;
    cbViewingAngle: TComboBox;
    tsAxis: TTabSheet;
    pnlAxis: TPanel;
    gbGridLines: TGroupBox;
    lblGridLineX: TLabel;
    lblGridLineY: TLabel;
    lblMajor: TLabel;
    lblMinor: TLabel;
    lblGridLineY2: TLabel;
    lblGridLineZ: TLabel;
    cbMajorX: TCheckBox;
    cbMajorY: TCheckBox;
    cbMajorY2: TCheckBox;
    cbMajorZ: TCheckBox;
    cbMinorX: TCheckBox;
    cbMinorY: TCheckBox;
    cbMinorY2: TCheckBox;
    cbMinorZ: TCheckBox;
    gbDataValues: TGroupBox;
    lblDataValuesY: TLabel;
    lblDataValuesY2: TLabel;
    lblAutoRange: TLabel;
    lblDataValuesZ: TLabel;
    lblMin: TLabel;
    lblMax: TLabel;
    lblNumberFormat: TLabel;
    cbDataValuesY: TCheckBox;
    cbDataValuesY2: TCheckBox;
    cbDataValuesZ: TCheckBox;
    editMinY: TEdit;
    editMinY2: TEdit;
    editMinZ: TEdit;
    editMaxY: TEdit;
    editMaxY2: TEdit;
    editMaxZ: TEdit;
    cbNumberFormatY: TComboBox;
    cbNumberFormatY2: TComboBox;
    cbNumberFormatZ: TComboBox;
    gbDivisions: TGroupBox;
    lblY: TLabel;
    lblY2: TLabel;
    lblZ: TLabel;
    lblDivisions: TLabel;
    lblDivisionType: TLabel;
    editDivisionsY: TEdit;
    editDivisionsY2: TEdit;
    editDivisionsZ: TEdit;
    cbDivisionTypeY: TComboBox;
    cbDivisionTypeY2: TComboBox;
    cbDivisionTypeZ: TComboBox;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    lblCount: TLabel;
    editCount: TEdit;
    GroupBox1: TGroupBox;
    lblTop: TLabel;
    lblLeft: TLabel;
    Label1: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    btnBorder: TButton;
    btnFormat: TButton;
    editTop: TEdit;
    editLeft: TEdit;
    editWidth: TEdit;
    editHeight: TEdit;
    cbSection: TComboBox;
    rgUnits: TRadioGroup;
    lblLegendLayout: TLabel;
    cbLegendLayout: TComboBox;
    rbShowLabelValue: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClick(Sender: TObject);
    procedure sbGraphTypeClick(Sender: TObject);
    procedure tvTypesClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateGraphs;
    procedure sbFontClick(Sender: TObject);
    procedure editTitleChange(Sender: TObject);
    procedure editSubTitleChange(Sender: TObject);
    procedure editFootnoteChange(Sender: TObject);
    procedure editGroupsTitleChange(Sender: TObject);
    procedure editSeriesTitleChange(Sender: TObject);
    procedure editXAxisTitleChange(Sender: TObject);
    procedure editYAxisTitleChange(Sender: TObject);
    procedure editZAxisTitleChange(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
    procedure cbLegendChange(Sender: TObject);
    procedure cbPieSizeChange(Sender: TObject);
    procedure cbPieSliceChange(Sender: TObject);
    procedure cbBarSizeChange(Sender: TObject);
    procedure cbBarDirectionChange(Sender: TObject);
    procedure cbViewingAngleChange(Sender: TObject);
    procedure cbMarkerSizeChange(Sender: TObject);
    procedure cbMarkerShapeChange(Sender: TObject);
    procedure rbNoneClick(Sender: TObject);
    procedure rbShowLabelClick(Sender: TObject);
    procedure rbShowValueClick(Sender: TObject);
    procedure cbNumberFormatChange(Sender: TObject);
    procedure GraphAxisMajorGridLineClick(Sender: TObject);
    procedure GraphAxisMinorGridLineClick(Sender: TObject);
    procedure GraphAxisDivisionTypeChange(Sender: TObject);
    procedure editDivisionsEnter(Sender: TObject);
    procedure editDivisionsExit(Sender: TObject);
    procedure DataValuesAutoRangeClick(Sender: TObject);
    procedure MinEnter(Sender: TObject);
    procedure MinExit(Sender: TObject);
    procedure MaxEnter(Sender: TObject);
    procedure MaxExit(Sender: TObject);
    procedure NumberFormatChange(Sender: TObject);
    procedure editEditKeyPress(Sender: TObject; var Key: Char);
    procedure rgUnitsClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure cbLegendLayoutChange(Sender: TObject);
    procedure rbShowLabelValueClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    GIndex   : smallint;
    prevNum  : string;
    PrevSize : string;
  end;

var
  CrpeGraphsDlg: TCrpeGraphsDlg;
  bGraphs      : boolean;

implementation

{$R *.DFM}

uses Printers, UCrpeUtl, UDBorder, UDFormat;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  bGraphs := True;
  sb1.Tag := 1;
  sb2.Tag := 2;
  sb3.Tag := 3;
  sb4.Tag := 4;
  sb5.Tag := 5;
  sb6.Tag := 6;
  sb7.Tag := 7;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.FormShow(Sender: TObject);
begin
  pcGraphs.ActivePage := tsText;
  pcGraphs.ActivePage := tsTypeX;
  UpdateGraphs;
end;
{------------------------------------------------------------------------------}
{ UpdateGraphs procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.UpdateGraphs;
var
  OnOff : boolean;
  i     : integer;
begin
  GIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Graphs.Count > 0);
    {Get Graphs Index}
    if OnOff then
    begin
      if Cr.Graphs.ItemIndex > -1 then
        GIndex := Cr.Graphs.ItemIndex
      else
        GIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.Graphs.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Graphs.Count);
    lbNumbers.ItemIndex := GIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if (TComponent(Components[i]).Tag = 0) or (Components[i] is TSpeedButton) then
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
      if Components[i] is TTreeView then
      begin
        TTreeView(Components[i]).Color := ColorState(OnOff);
        TTreeView(Components[i]).Enabled := OnOff;
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
procedure TCrpeGraphsDlg.lbNumbersClick(Sender: TObject);
begin
  GIndex := lbNumbers.ItemIndex;
  {Style: Major}
  case Cr.Graphs[GIndex].Style of
    {Bar: 0..5}
    barSideBySide..bar3DPercent,
    unknownBar : tvTypes.Selected := tvTypes.Items[0];
    {Line: 6..11}
    lineRegular..linePercentWithMarkers,
    unknownLine : tvTypes.Selected := tvTypes.Items[1];
    {Area: 12..17}
    areaAbsolute..area3DPercent,
    unknownArea : tvTypes.Selected := tvTypes.Items[2];
    {Pie: 18..21}
    pieRegular..pieMultiProp,
    unknownPie : tvTypes.Selected := tvTypes.Items[3];
    {Doughnut: 22..24}
    doughnutRegular..doughnutMultiProp,
    unknownDoughnut : tvTypes.Selected := tvTypes.Items[4];
    {3D Riser: 25..28}
    ThreeDRegular..ThreeDCutCorners,
    unknown3DRiser : tvTypes.Selected := tvTypes.Items[5];
    {3D Surface: 29..31}
    ThreeDSurfaceRegular..ThreeDSurfaceHoneyComb,
    unknown3DSurface : tvTypes.Selected := tvTypes.Items[6];
    {XYScatter: 32..35}
    XYScatter..XYScatterDualAxisLabeled,
    unknownXYScatter : tvTypes.Selected := tvTypes.Items[7];
    {Radar: 36..38}
    radarRegular..radarDualAxis,
    unknownRadar : tvTypes.Selected := tvTypes.Items[8];
    {Bubble: 39,40}
    bubbleRegular..bubbleDualAxis,
    unknownBubble : tvTypes.Selected := tvTypes.Items[9];
    {StockHiLo: 41..46}
    stockHiLo..stockHiLoOpenCloseDualAxis,
    unknownStockHiLo : tvTypes.Selected := tvTypes.Items[10];
    {User Defined: 47}
    userDefinedGraph : tvTypes.Selected := tvTypes.Items[11];
    {Unknown: 59}
    unknownGraphType : tvTypes.Selected := tvTypes.Items[12];
  end;
  {Style: Minor}
  tvTypesClick(Self);

  {Text}
  {Turn off all events}
  editTitle.OnChange := nil;
  editSubTitle.OnChange := nil;
  editFootnote.OnChange := nil;
  editGroupsTitle.OnChange := nil;
  editSeriesTitle.OnChange := nil;
  editXAxisTitle.OnChange := nil;
  editYAxisTitle.OnChange := nil;
  editZAxisTitle.OnChange := nil;
  {Titles}
  editTitle.Text := Cr.Graphs.Item.Text.Title;
  editSubTitle.Text := Cr.Graphs.Item.Text.SubTitle;
  editFootnote.Text := Cr.Graphs.Item.Text.FootNote;
  editGroupsTitle.Text := Cr.Graphs.Item.Text.GroupsTitle;
  editSeriesTitle.Text := Cr.Graphs.Item.Text.SeriesTitle;
  editXAxisTitle.Text := Cr.Graphs.Item.Text.XAxisTitle;
  editYAxisTitle.Text := Cr.Graphs.Item.Text.YAxisTitle;
  editZAxisTitle.Text := Cr.Graphs.Item.Text.ZAxisTitle;
  {Fonts}
  lblTitleFont.Font.Assign(Cr.Graphs.Item.Text.TitleFont);
  lblSubTitleFont.Font.Assign(Cr.Graphs.Item.Text.SubTitleFont);
  lblFootNoteFont.Font.Assign(Cr.Graphs.Item.Text.FootNoteFont);
  lblGroupsTitleFont.Font.Assign(Cr.Graphs.Item.Text.GroupsTitleFont);
  lblDataTitleFont.Font.Assign(Cr.Graphs.Item.Text.DataTitleFont);
  lblLegendFont.Font.Assign(Cr.Graphs.Item.Text.LegendFont);
  lblGroupLabelsFont.Font.Assign(Cr.Graphs.Item.Text.GroupLabelsFont);
  lblDataLabelsFont.Font.Assign(Cr.Graphs.Item.Text.DataLabelsFont);
  {Turn on all events}
  editTitle.OnChange := editTitleChange;
  editSubTitle.OnChange := editSubTitleChange;
  editFootnote.OnChange := editFootnoteChange;
  editGroupsTitle.OnChange := editGroupsTitleChange;
  editSeriesTitle.OnChange := editSeriesTitleChange;
  editXAxisTitle.OnChange := editXAxisTitleChange;
  editYAxisTitle.OnChange := editYAxisTitleChange;
  editZAxisTitle.OnChange := editZAxisTitleChange;

  {OptionInfo}
  {Turn off all events}
  cbColor.OnChange := nil;
  cbLegend.OnChange := nil;
  cbLegendLayout.OnChange := nil;
  cbPieSize.OnChange := nil;
  cbPieSlice.OnChange := nil;
  cbBarSize.OnChange := nil;
  cbBarDirection.OnChange := nil;
  cbMarkerSize.OnChange := nil;
  cbMarkerShape.OnChange := nil;
  cbViewingAngle.OnChange := nil;
  rbNone.OnClick := nil;
  rbShowLabel.OnClick := nil;
  rbShowValue.OnClick := nil;
  cbNumberFormat.OnChange := nil;
  {Combo Boxes}
  cbColor.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.Color);
  cbLegend.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.Legend);
  cbLegendLayout.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.LegendLayout);
  cbPieSize.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.PieSize);
  cbPieSlice.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.PieSlice);
  cbBarSize.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.BarSize);
  cbBarDirection.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.BarDirection);
  cbMarkerSize.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.MarkerSize);
  cbMarkerShape.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.MarkerShape);
  cbViewingAngle.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.ViewingAngle);
  {DataPoints}
  rbNone.Checked := (Cr.Graphs.Item.OptionInfo.DataPoints = gdpNone);
  rbShowLabel.Checked := (Cr.Graphs.Item.OptionInfo.DataPoints = gdpShowLabel);
  rbShowValue.Checked := (Cr.Graphs.Item.OptionInfo.DataPoints = gdpShowValue);
  rbShowLabelValue.Checked := (Cr.Graphs.Item.OptionInfo.DataPoints = gdpShowLabelValue);
  cbNumberFormat.Enabled := (rbShowValue.Checked or rbShowLabelValue.Checked);
  cbNumberFormat.Color := ColorState(cbNumberFormat.Enabled);
  cbNumberFormat.ItemIndex := Ord(Cr.Graphs.Item.OptionInfo.NumberFormat);
  {Turn on all events}
  cbColor.OnChange := cbColorChange;
  cbLegend.OnChange := cbLegendChange;
  cbLegendLayout.OnChange := cbLegendLayoutChange;
  cbPieSize.OnChange := cbPieSizeChange;
  cbPieSlice.OnChange := cbPieSliceChange;
  cbBarSize.OnChange := cbBarSizeChange;
  cbBarDirection.OnChange := cbBarDirectionChange;
  cbMarkerSize.OnChange := cbMarkerSizeChange;
  cbMarkerShape.OnChange := cbMarkerShapeChange;
  cbViewingAngle.OnChange := cbViewingAngleChange;
  rbNone.OnClick := rbNoneClick;
  rbShowLabel.OnClick := rbShowLabelClick;
  rbShowValue.OnClick := rbShowValueClick;
  cbNumberFormat.OnChange := cbNumberFormatChange;

  {Axis}
  {Turn off all events}
  cbMajorX.OnClick := nil;
  cbMajorY.OnClick := nil;
  cbMajorY2.OnClick := nil;
  cbMajorZ.OnClick := nil;
  cbMinorX.OnClick := nil;
  cbMinorY.OnClick := nil;
  cbMinorY2.OnClick := nil;
  cbMinorZ.OnClick := nil;
  cbDivisionTypeY.OnChange := nil;
  cbDivisionTypeY2.OnChange := nil;
  cbDivisionTypeZ.OnChange := nil;
  editDivisionsY.OnChange := nil;
  editDivisionsY2.OnChange := nil;
  editDivisionsZ.OnChange := nil;
  editDivisionsY.OnEnter := nil;
  editDivisionsY2.OnEnter := nil;
  editDivisionsZ.OnEnter := nil;
  editDivisionsY.OnExit := nil;
  editDivisionsY2.OnExit := nil;
  editDivisionsZ.OnExit := nil;
  editDivisionsY.OnKeyPress := nil;
  editDivisionsY2.OnKeyPress := nil;
  editDivisionsZ.OnKeyPress := nil;
  cbDataValuesY.OnClick := nil;
  cbDataValuesY2.OnClick := nil;
  cbDataValuesZ.OnClick := nil;
  {editMin OnChange}
  editMinY.OnChange := nil;
  editMinY2.OnChange := nil;
  editMinZ.OnChange := nil;
  editMaxY.OnChange := nil;
  editMaxY2.OnChange := nil;
  editMaxZ.OnChange := nil;
  {editMin OnEnter}
  editMinY.OnEnter := nil;
  editMinY2.OnEnter := nil;
  editMinZ.OnEnter := nil;
  editMaxY.OnEnter := nil;
  editMaxY2.OnEnter := nil;
  editMaxZ.OnEnter := nil;
  {editMin OnExit}
  editMinY.OnExit := nil;
  editMinY2.OnExit := nil;
  editMinZ.OnExit := nil;
  editMaxY.OnExit := nil;
  editMaxY2.OnExit := nil;
  editMaxZ.OnExit := nil;
  {editMin OnKeyPress}
  editMinY.OnKeyPress := nil;
  editMinY2.OnKeyPress := nil;
  editMinZ.OnKeyPress := nil;
  editMaxY.OnKeyPress := nil;
  editMaxY2.OnKeyPress := nil;
  editMaxZ.OnKeyPress := nil;
  cbNumberFormatY.OnChange := nil;
  cbNumberFormatY2.OnChange := nil;
  cbNumberFormatZ.OnChange := nil;
  {GridLines - Major}
  cbMajorX.Checked := (Cr.Graphs.Item.Axis.GridLineX = gglMajor);
  cbMajorY.Checked := (Cr.Graphs.Item.Axis.GridLineY = gglMajor);
  cbMajorY2.Checked := (Cr.Graphs.Item.Axis.GridLineY2 = gglMajor);
  cbMajorZ.Checked := (Cr.Graphs.Item.Axis.GridLineZ = gglMajor);
  {GridLines - Minor}
  cbMinorX.Checked := (Cr.Graphs.Item.Axis.GridLineX = gglMinor);
  cbMinorY.Checked := (Cr.Graphs.Item.Axis.GridLineY = gglMinor);
  cbMinorY2.Checked := (Cr.Graphs.Item.Axis.GridLineY2 = gglMinor);
  cbMinorZ.Checked := (Cr.Graphs.Item.Axis.GridLineZ = gglMinor);
  {GridLines - MajorAndMinor}
  if Cr.Graphs.Item.Axis.GridLineX = gglMajorAndMinor then
  begin
    cbMajorX.Checked := True;
    cbMinorX.Checked := True;
  end;
  if Cr.Graphs.Item.Axis.GridLineY = gglMajorAndMinor then
  begin
    cbMajorY.Checked := True;
    cbMinorY.Checked := True;
  end;
  if Cr.Graphs.Item.Axis.GridLineY2 = gglMajorAndMinor then
  begin
    cbMajorY2.Checked := True;
    cbMinorY2.Checked := True;
  end;
  if Cr.Graphs.Item.Axis.GridLineZ = gglMajorAndMinor then
  begin
    cbMajorZ.Checked := True;
    cbMinorZ.Checked := True;
  end;
  {GridLines - None}
  if Cr.Graphs.Item.Axis.GridLineX = gglNone then
  begin
    cbMajorX.Checked := False;
    cbMinorX.Checked := False;
  end;
  if Cr.Graphs.Item.Axis.GridLineY = gglNone then
  begin
    cbMajorY.Checked := False;
    cbMinorY.Checked := False;
  end;
  if Cr.Graphs.Item.Axis.GridLineY2 = gglNone then
  begin
    cbMajorY2.Checked := False;
    cbMinorY2.Checked := False;
  end;
  if Cr.Graphs.Item.Axis.GridLineZ = gglNone then
  begin
    cbMajorZ.Checked := False;
    cbMinorZ.Checked := False;
  end;
  {Divisions}
  cbDivisionTypeY.ItemIndex := Ord(Cr.Graphs.Item.Axis.DivisionTypeY);
  cbDivisionTypeY2.ItemIndex := Ord(Cr.Graphs.Item.Axis.DivisionTypeY2);
  cbDivisionTypeZ.ItemIndex := Ord(Cr.Graphs.Item.Axis.DivisionTypeZ);
  editDivisionsY.Enabled := (Cr.Graphs.Item.Axis.DivisionTypeY = gdvManual);
  editDivisionsY2.Enabled := (Cr.Graphs.Item.Axis.DivisionTypeY2 = gdvManual);
  editDivisionsZ.Enabled := (Cr.Graphs.Item.Axis.DivisionTypeZ = gdvManual);
  editDivisionsY.Color :=  ColorState(editDivisionsY.Enabled);
  editDivisionsY2.Color := ColorState(editDivisionsY2.Enabled);
  editDivisionsZ.Color := ColorState(editDivisionsZ.Enabled);
  editDivisionsY.Text  := IntToStr(Cr.Graphs.Item.Axis.DivisionsY);
  editDivisionsY2.Text := IntToStr(Cr.Graphs.Item.Axis.DivisionsY2);
  editDivisionsZ.Text  := IntToStr(Cr.Graphs.Item.Axis.DivisionsZ);
  {DataValues}
  case Cr.Graphs.Item.Axis.DataValuesY of
    gdvAutomatic : cbDataValuesY.State := cbChecked;
    gdvManual    : cbDataValuesY.State := cbUnchecked;
  end;
  case Cr.Graphs.Item.Axis.DataValuesY2 of
    gdvAutomatic : cbDataValuesY2.State := cbChecked;
    gdvManual    : cbDataValuesY2.State := cbUnchecked;
  end;
  case Cr.Graphs.Item.Axis.DataValuesZ of
    gdvAutomatic : cbDataValuesZ.State := cbChecked;
    gdvManual    : cbDataValuesZ.State := cbUnchecked;
  end;
  {Enable/Disable Min/Max/NumberFormat}
  editMinY.Enabled := (cbDataValuesY.State = cbUnchecked);
  editMinY2.Enabled := (cbDataValuesY2.State = cbUnchecked);
  editMinZ.Enabled := (cbDataValuesZ.State = cbUnchecked);
  editMaxY.Enabled := (cbDataValuesY.State = cbUnchecked);
  editMaxY2.Enabled := (cbDataValuesY2.State = cbUnchecked);
  editMaxZ.Enabled := (cbDataValuesZ.State = cbUnchecked);
  cbNumberFormatY.Enabled := (cbDataValuesY.State = cbUnchecked);
  cbNumberFormatY2.Enabled := (cbDataValuesY2.State = cbUnchecked);
  cbNumberFormatZ.Enabled := (cbDataValuesZ.State = cbUnchecked);
  {Set color of controls}
  editMinY.Color := ColorState(editMinY.Enabled);
  editMinY2.Color := ColorState(editMinY2.Enabled);
  editMinZ.Color := ColorState(editMinZ.Enabled);
  editMaxY.Color := ColorState(editMaxY.Enabled);
  editMaxY2.Color := ColorState(editMaxY2.Enabled);
  editMaxZ.Color := ColorState(editMaxZ.Enabled);
  cbNumberFormatY.Color := ColorState(cbNumberFormatY.Enabled);
  cbNumberFormatY2.Color := ColorState(cbNumberFormatY2.Enabled);
  cbNumberFormatZ.Color := ColorState(cbNumberFormatZ.Enabled);
  {Load Min/Max/NumberFormat}
  editMinY.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MinY);
  editMinY2.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MinY2);
  editMinZ.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MinZ);
  editMaxY.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MaxY);
  editMaxY2.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MaxY2);
  editMaxZ.Text := CrFloatingToStr(Cr.Graphs.Item.Axis.MaxZ);
  cbNumberFormatY.ItemIndex := Ord(Cr.Graphs.Item.Axis.NumberFormatY);
  cbNumberFormatY2.ItemIndex := Ord(Cr.Graphs.Item.Axis.NumberFormatY2);
  cbNumberFormatZ.ItemIndex := Ord(Cr.Graphs.Item.Axis.NumberFormatZ);
  {Turn on all events}
  cbMajorX.OnClick := GraphAxisMajorGridLineClick;
  cbMajorY.OnClick := GraphAxisMajorGridLineClick;
  cbMajorY2.OnClick := GraphAxisMajorGridLineClick;
  cbMajorZ.OnClick := GraphAxisMajorGridLineClick;
  cbMinorX.OnClick := GraphAxisMinorGridLineClick;
  cbMinorY.OnClick := GraphAxisMinorGridLineClick;
  cbMinorY2.OnClick := GraphAxisMinorGridLineClick;
  cbMinorZ.OnClick := GraphAxisMinorGridLineClick;
  cbDivisionTypeY.OnChange := GraphAxisDivisionTypeChange;
  cbDivisionTypeY2.OnChange := GraphAxisDivisionTypeChange;
  cbDivisionTypeZ.OnChange := GraphAxisDivisionTypeChange;
  editDivisionsY.OnEnter := editDivisionsEnter;
  editDivisionsY2.OnEnter := editDivisionsEnter;
  editDivisionsZ.OnEnter := editDivisionsEnter;
  editDivisionsY.OnExit := editDivisionsExit;
  editDivisionsY2.OnExit := editDivisionsExit;
  editDivisionsZ.OnExit := editDivisionsExit;
  cbDataValuesY.OnClick := DataValuesAutoRangeClick;
  cbDataValuesY2.OnClick := DataValuesAutoRangeClick;
  cbDataValuesZ.OnClick := DataValuesAutoRangeClick;
  {editMin OnEnter}
  editMinY.OnEnter := MinEnter;
  editMinY2.OnEnter := MinEnter;
  editMinZ.OnEnter := MinEnter;
  editMaxY.OnEnter := MaxEnter;
  editMaxY2.OnEnter := MaxEnter;
  editMaxZ.OnEnter := MaxEnter;
  {editMin OnExit}
  editMinY.OnExit := MinExit;
  editMinY2.OnExit := MinExit;
  editMinZ.OnExit := MinExit;
  editMaxY.OnExit := MaxExit;
  editMaxY2.OnExit := MaxExit;
  editMaxZ.OnExit := MaxExit;
  {editMin OnChange}
  cbNumberFormatY.OnChange := NumberFormatChange;
  cbNumberFormatY2.OnChange := NumberFormatChange;
  cbNumberFormatZ.OnChange := NumberFormatChange;

  {Object properties}
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Graphs.Item.Section);
  rgUnitsClick(Self);
end;
{******************************************************************************}
{ Graphs.Type                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ tvTypesClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.tvTypesClick(Sender: TObject);
var
  i  : integer;
begin
  sb1.Down := False;
  sb2.Down := False;
  sb3.Down := False;
  sb4.Down := False;
  sb5.Down := False;
  sb6.Down := False;
  sb7.Down := False;
  i := tvTypes.Selected.Index;
  case i of
    {Bar}
    0: begin
         sb1.Visible := True;
         sb1.Glyph := Bar1.Picture.Bitmap;
         sb1.Hint := 'barSideBySide';
         sb2.Visible := True;
         sb2.Glyph := Bar2.Picture.Bitmap;
         sb2.Hint := 'barStacked';
         sb3.Visible := True;
         sb3.Glyph := Bar3.Picture.Bitmap;
         sb3.Hint := 'barPercent';
         sb4.Visible := True;
         sb4.Glyph := Bar4.Picture.Bitmap;
         sb4.Hint := 'bar3DSideBySide';
         sb5.Visible := True;
         sb5.Glyph := Bar5.Picture.Bitmap;
         sb5.Hint := 'bar3DStacked';
         sb6.Visible := True;
         sb6.Glyph := Bar6.Picture.Bitmap;
         sb6.Hint := 'bar3DPercent';
         sb7.Visible := True;
         sb7.Caption := 'unknownBar';
         case Cr.Graphs.Item.Style of
           barSideBySide   : sb1.Down := True;
           barStacked      : sb2.Down := True;
           barPercent      : sb3.Down := True;
           bar3DSideBySide : sb4.Down := True;
           bar3DStacked    : sb5.Down := True;
           bar3DPercent    : sb6.Down := True;
           unknownBar      : sb7.Down := True;
         end;
       end;
    {Line}
    1: begin
         sb1.Visible := True;
         sb1.Glyph := Line1.Picture.Bitmap;
         sb1.Hint := 'lineRegular';
         sb2.Visible := True;
         sb2.Glyph := Line2.Picture.Bitmap;
         sb2.Hint := 'lineStacked';
         sb3.Visible := True;
         sb3.Glyph := Line3.Picture.Bitmap;
         sb3.Hint := 'linePercent';
         sb4.Visible := True;
         sb4.Glyph := Line4.Picture.Bitmap;
         sb4.Hint := 'lineWithMarkers';
         sb5.Visible := True;
         sb5.Glyph := Line5.Picture.Bitmap;
         sb5.Hint := 'lineStackedWithMarkers';
         sb6.Visible := True;
         sb6.Glyph := Line6.Picture.Bitmap;
         sb6.Hint := 'linePercentWithMarkers';
         sb7.Visible := True;
         sb7.Caption := 'unknownLine';
         case Cr.Graphs.Item.Style of
           lineRegular            : sb1.Down := True;
           lineStacked            : sb2.Down := True;
           linePercent            : sb3.Down := True;
           lineWithMarkers        : sb4.Down := True;
           lineStackedWithMarkers : sb5.Down := True;
           linePercentWithMarkers : sb6.Down := True;
           unknownLine            : sb7.Down := True;
         end;
       end;
    {Area}
    2: begin
         sb1.Visible := True;
         sb1.Glyph := Area1.Picture.Bitmap;
         sb1.Hint := 'areaAbsolute';
         sb2.Visible := True;
         sb2.Glyph := Area2.Picture.Bitmap;
         sb2.Hint := 'areaStacked';
         sb3.Visible := True;
         sb3.Glyph := Area3.Picture.Bitmap;
         sb3.Hint := 'areaPercent';
         sb4.Visible := True;
         sb4.Glyph := Area4.Picture.Bitmap;
         sb4.Hint := 'area3DAbsolute';
         sb5.Visible := True;
         sb5.Glyph := Area5.Picture.Bitmap;
         sb5.Hint := 'area3DStacked';
         sb6.Visible := True;
         sb6.Glyph := Area6.Picture.Bitmap;
         sb6.Hint := 'area3DPercent';
         sb7.Visible := True;
         sb7.Caption := 'unknownArea';
         case Cr.Graphs.Item.Style of
           areaAbsolute   : sb1.Down := True;
           areaStacked    : sb2.Down := True;
           areaPercent    : sb3.Down := True;
           area3DAbsolute : sb4.Down := True;
           area3DStacked  : sb5.Down := True;
           area3DPercent  : sb6.Down := True;
           unknownArea    : sb7.Down := True;
         end;
       end;
    {Pie}
    3: begin
         sb1.Visible := True;
         sb1.Glyph := Pie1.Picture.Bitmap;
         sb1.Hint := 'pieRegular';
         sb2.Visible := True;
         sb2.Glyph := Pie2.Picture.Bitmap;
         sb2.Hint := 'pie3DRegular';
         sb3.Visible := True;
         sb3.Glyph := Pie3.Picture.Bitmap;
         sb3.Hint := 'pieMultiple';
         sb4.Visible := True;
         sb4.Glyph := Pie4.Picture.Bitmap;
         sb4.Hint := 'pieMultiProp';
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknownPie';
         case Cr.Graphs.Item.Style of
           pieRegular   : sb1.Down := True;
           pie3DRegular : sb2.Down := True;
           pieMultiple  : sb3.Down := True;
           pieMultiProp : sb4.Down := True;
           unknownPie   : sb7.Down := True;
         end;
       end;
    {Doughnut}
    4: begin
         sb1.Visible := True;
         sb1.Glyph := Doughnut1.Picture.Bitmap;
         sb1.Hint := 'doughnutRegular';
         sb2.Visible := True;
         sb2.Glyph := Doughnut2.Picture.Bitmap;
         sb2.Hint := 'doughnutMultiple';
         sb3.Visible := True;
         sb3.Glyph := Doughnut3.Picture.Bitmap;
         sb3.Hint := 'doughnutMultiProp';
         sb4.Visible := False;
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknownDoughnut';
         case Cr.Graphs.Item.Style of
           doughnutRegular   : sb1.Down := True;
           doughnutMultiple  : sb2.Down := True;
           doughnutMultiProp : sb3.Down := True;
           unknownDoughnut   : sb7.Down := True;
         end;
       end;
    {3DRiser}
    5: begin
         sb1.Visible := True;
         sb1.Glyph := ThreeDRiser1.Picture.Bitmap;
         sb1.Hint := 'ThreeDRegular';
         sb2.Visible := True;
         sb2.Glyph := ThreeDRiser2.Picture.Bitmap;
         sb2.Hint := 'ThreeDPyramid';
         sb3.Visible := True;
         sb3.Glyph := ThreeDRiser3.Picture.Bitmap;
         sb3.Hint := 'ThreeDOctagon';
         sb4.Visible := True;
         sb4.Glyph := ThreeDRiser4.Picture.Bitmap;
         sb4.Hint := 'ThreeDCutCorners';
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknown3DRiser';
         case Cr.Graphs.Item.Style of
           ThreeDRegular    : sb1.Down := True;
           ThreeDPyramid    : sb2.Down := True;
           ThreeDOctagon    : sb3.Down := True;
           ThreeDCutCorners : sb4.Down := True;
           unknown3DRiser   : sb7.Down := True;
         end;
       end;
    {3DSurface}
    6: begin
         sb1.Visible := True;
         sb1.Glyph := ThreeDSurface1.Picture.Bitmap;
         sb1.Hint := 'ThreeDSurfaceRegular';
         sb2.Visible := True;
         sb2.Glyph := ThreeDSurface2.Picture.Bitmap;
         sb2.Hint := 'ThreeDSurfaceWithSides';
         sb3.Visible := True;
         sb3.Glyph := ThreeDSurface3.Picture.Bitmap;
         sb3.Hint := 'ThreeDSurfaceHoneyComb';
         sb4.Visible := False;
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknown3DSurface';
         case Cr.Graphs.Item.Style of
           ThreeDSurfaceRegular   : sb1.Down := True;
           ThreeDSurfaceWithSides : sb2.Down := True;
           ThreeDSurfaceHoneyComb : sb3.Down := True;
           unknown3DSurface       : sb7.Down := True;
         end;
       end;
    {XYScatter}
    7: begin
         sb1.Visible := True;
         sb1.Glyph := XYScatter1.Picture.Bitmap;
         sb1.Hint := 'XYScatter';
         sb2.Visible := True;
         sb2.Glyph := XYScatter2.Picture.Bitmap;
         sb2.Hint := 'XYScatterDualAxis';
         sb3.Visible := True;
         sb3.Glyph := XYScatter3.Picture.Bitmap;
         sb3.Hint := 'XYScatterLabeled';
         sb4.Visible := True;
         sb4.Glyph := XYScatter4.Picture.Bitmap;
         sb4.Hint := 'XYScatterDualAxisLabeled';
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknownXYScatter';
         case Cr.Graphs.Item.Style of
           XYScatter                : sb1.Down := True;
           XYScatterDualAxis        : sb2.Down := True;
           XYScatterLabeled         : sb3.Down := True;
           XYScatterDualAxisLabeled : sb4.Down := True;
           unknownXYScatter         : sb7.Down := True;
         end;
       end;
    {Radar}
    8: begin
         sb1.Visible := True;
         sb1.Glyph := Radar1.Picture.Bitmap;
         sb1.Hint := 'radarRegular';
         sb2.Visible := True;
         sb2.Glyph := Radar2.Picture.Bitmap;
         sb2.Hint := 'radarStacked';
         sb3.Visible := True;
         sb3.Glyph := Radar3.Picture.Bitmap;
         sb3.Hint := 'radarDualAxis';
         sb4.Visible := False;
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknownRadar';
         case Cr.Graphs.Item.Style of
           radarRegular  : sb1.Down := True;
           radarStacked  : sb2.Down := True;
           radarDualAxis : sb3.Down := True;
           unknownRadar  : sb7.Down := True;
         end;
       end;
    {Bubble}
    9: begin
         sb1.Visible := True;
         sb1.Glyph := Bubble1.Picture.Bitmap;
         sb1.Hint := 'bubbleRegular';
         sb2.Visible := True;
         sb2.Glyph := Bubble2.Picture.Bitmap;
         sb2.Hint := 'bubbleDualAxis';
         sb3.Visible := False;
         sb4.Visible := False;
         sb5.Visible := False;
         sb6.Visible := False;
         sb7.Visible := True;
         sb7.Caption := 'unknownBubble';
         case Cr.Graphs.Item.Style of
           bubbleRegular  : sb1.Down := True;
           bubbleDualAxis : sb2.Down := True;
           unknownBubble  : sb7.Down := True;
         end;
       end;
    {Stock}
    10: begin
         sb1.Visible := True;
         sb1.Glyph := Stock1.Picture.Bitmap;
         sb1.Hint := 'stockHiLo';
         sb2.Visible := True;
         sb2.Glyph := Stock2.Picture.Bitmap;
         sb2.Hint := 'stockHiLoDualAxis';
         sb3.Visible := True;
         sb3.Glyph := Stock3.Picture.Bitmap;
         sb3.Hint := 'stockHiLoOpen';
         sb4.Visible := True;
         sb4.Glyph := Stock4.Picture.Bitmap;
         sb4.Hint := 'stockHiLoOpenDualAxis';
         sb5.Visible := True;
         sb5.Glyph := Stock5.Picture.Bitmap;
         sb5.Hint := 'stockHiLoOpenClose';
         sb6.Visible := True;
         sb6.Glyph := Stock6.Picture.Bitmap;
         sb6.Hint := 'stockHiLoOpenCloseDualAxis';
         sb7.Visible := True;
         sb7.Caption := 'unknownStockHiLo';
         case Cr.Graphs.Item.Style of
           stockHiLo                  : sb1.Down := True;
           stockHiLoDualAxis          : sb2.Down := True;
           stockHiLoOpen              : sb3.Down := True;
           stockHiLoOpenDualAxis      : sb4.Down := True;
           stockHiLoOpenClose         : sb5.Down := True;
           stockHiLoOpenCloseDualAxis : sb6.Down := True;
           unknownStockHiLo           : sb7.Down := True;
         end;
       end;
    {UserDefined}
    11: begin
          sb1.Visible := False;
          sb2.Visible := False;
          sb3.Visible := False;
          sb4.Visible := False;
          sb5.Visible := False;
          sb6.Visible := False;
          sb7.Caption := 'userDefinedGraph';
          sb7.Visible := True;
          if Cr.Graphs.Item.Style = userDefinedGraph then
            sb7.Down := True;
        end;
    {Unknown}
    12: begin
          sb1.Visible := False;
          sb2.Visible := False;
          sb3.Visible := False;
          sb4.Visible := False;
          sb5.Visible := False;
          sb6.Visible := False;
          sb7.Caption := 'unknownGraphType';
          sb7.Visible := True;
          if Cr.Graphs.Item.Style = unknownGraphType then
            sb7.Down := True;
       end;
  end;
end;
{------------------------------------------------------------------------------}
{ sbGraphTypeClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.sbGraphTypeClick(Sender: TObject);
var
  i,j : integer;
begin
  i := tvTypes.Selected.Index;
  {Button Tag numbers are 1 to 7}
  j := 0;
  case i of
    {Bar}
    0: begin
         j := TSpeedButton(Sender).Tag - 1;
         if j = 6 then j := Ord(unknownBar);
       end;
    {Line}
    1: begin
         j := TSpeedButton(Sender).Tag + 5;
         if j = 12 then j := Ord(unknownLine);
       end;
    {Area}
    2: begin
         j := TSpeedButton(Sender).Tag + 11;
         if j = 18 then j := Ord(unknownArea);
       end;
    {Pie}
    3: begin
         j := TSpeedButton(Sender).Tag + 17;
         if j = 24 then j := Ord(unknownPie);
       end;
    {Doughnut}
    4: begin
         j := TSpeedButton(Sender).Tag + 21;
         if j = 28 then j := Ord(unknownDoughnut);
       end;
    {3DRiser}
    5: begin
         j := TSpeedButton(Sender).Tag + 24;
         if j = 31 then j := Ord(unknown3DRiser);
       end;
    {3DSurface}
    6: begin
         j := TSpeedButton(Sender).Tag + 28;
         if j = 35 then j := Ord(unknown3DSurface);
       end;
    {XYScatter}
    7: begin
         j := TSpeedButton(Sender).Tag + 31;
         if j = 38 then j := Ord(unknownXYScatter);
       end;
    {Radar}
    8: begin
         j := TSpeedButton(Sender).Tag + 35;
         if j = 42 then j := Ord(unknownRadar);
       end;
    {Bubble}
    9: begin
         j := TSpeedButton(Sender).Tag + 38;
         if j = 45 then j := Ord(unknownBubble);
       end;
    {StockHiLo}
   10: begin
         j := TSpeedButton(Sender).Tag + 40;
         if j = 47 then j := Ord(unknownStockHiLo);
       end;
    {UserDefined}
   11: j := Ord(userDefinedGraph);
    {UnknownGraphType}
   12: j := Ord(unknownGraphType);
  end;
  Cr.Graphs.Item.Style := TCrGraphType(j);
end;
{******************************************************************************}
{ Graphs.Text                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ sbFontClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.sbFontClick(Sender: TObject);
begin
  case TSpeedButton(Sender).Tag of
    0: FontDialog1.Font.Assign(lblTitleFont.Font);
    1: FontDialog1.Font.Assign(lblSubTitleFont.Font);
    2: FontDialog1.Font.Assign(lblFootNoteFont.Font);
    3: FontDialog1.Font.Assign(lblGroupsTitleFont.Font);
    4: FontDialog1.Font.Assign(lblDataTitleFont.Font);
    5: FontDialog1.Font.Assign(lblLegendFont.Font);
    6: FontDialog1.Font.Assign(lblGroupLabelsFont.Font);
    7: FontDialog1.Font.Assign(lblDataLabelsFont.Font);
  end;
  if FontDialog1.Execute then
  begin
    case TSpeedButton(Sender).Tag of
      0: begin
           lblTitleFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.TitleFont.Assign(FontDialog1.Font);
         end;
      1: begin
           lblSubTitleFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.SubTitleFont.Assign(FontDialog1.Font);
         end;
      2: begin
           lblFootNoteFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.FootNoteFont.Assign(FontDialog1.Font);
         end;
      3: begin
           lblGroupsTitleFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.GroupsTitleFont.Assign(FontDialog1.Font);
         end;
      4: begin
           lblDataTitleFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.DataTitleFont.Assign(FontDialog1.Font);
         end;
      5: begin
           lblLegendFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.LegendFont.Assign(FontDialog1.Font);
         end;
      6: begin
           lblGroupLabelsFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.GroupLabelsFont.Assign(FontDialog1.Font);
         end;
      7: begin
           lblDataLabelsFont.Font.Assign(FontDialog1.Font);
           Cr.Graphs.Item.Text.DataLabelsFont.Assign(FontDialog1.Font);
         end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ editTitleChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.Title := editTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editSubTitleChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editSubTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.SubTitle := editSubTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editFootnoteChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editFootnoteChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.FootNote := editFootnote.Text;
end;
{------------------------------------------------------------------------------}
{ editGroupsTitleChange procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editGroupsTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.GroupsTitle := editGroupsTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editSeriesTitleChange procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editSeriesTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.SeriesTitle := editSeriesTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editXAxisTitleChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editXAxisTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.XAxisTitle := editXAxisTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editYAxisTitleChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editYAxisTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.YAxisTitle := editYAxisTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editZAxisTitleChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editZAxisTitleChange(Sender: TObject);
begin
  Cr.Graphs.Item.Text.ZAxisTitle := editZAxisTitle.Text;
end;
{******************************************************************************}
{ Graphs.OptionInfo                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbColorChange procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbColorChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.Color := TCrGraphColor(cbColor.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbLegendChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbLegendChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.Legend := TCrGraphLegend(cbLegend.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbLegendLayoutChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbLegendLayoutChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.LegendLayout := TCrGraphLegendLayout(cbLegendLayout.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbPieSizeChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbPieSizeChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.PieSize := TCrGraphPieSize(cbPieSize.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbPieSliceChange procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbPieSliceChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.PieSlice := TCrGraphPieSlice(cbPieSlice.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbBarSizeChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbBarSizeChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.BarSize := TCrGraphBarSize(cbBarSize.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbBarDirectionChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbBarDirectionChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.BarDirection := TCrGraphBarDirection(cbBarDirection.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbViewingAngleChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbViewingAngleChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.ViewingAngle := TCrGraphViewingAngle(cbViewingAngle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbMarkerSizeChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbMarkerSizeChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.MarkerSize := TCrGraphMarkerSize(cbMarkerSize.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbMarkerShapeChange procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbMarkerShapeChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.MarkerShape := TCrGraphMarkerShape(cbMarkerShape.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ rbNoneClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.rbNoneClick(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.DataPoints := gdpNone;
  cbNumberFormat.Enabled := rbShowValue.Checked;
  cbNumberFormat.Color := ColorState(cbNumberFormat.Enabled);
end;
{------------------------------------------------------------------------------}
{ rbShowLabelClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.rbShowLabelClick(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.DataPoints := gdpShowLabel;
  cbNumberFormat.Enabled := rbShowValue.Checked;
  cbNumberFormat.Color := ColorState(cbNumberFormat.Enabled);
end;
{------------------------------------------------------------------------------}
{ rbShowValueClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.rbShowValueClick(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.DataPoints := gdpShowValue;
  cbNumberFormat.Enabled := rbShowValue.Checked;
  cbNumberFormat.Color := ColorState(cbNumberFormat.Enabled);
end;
{------------------------------------------------------------------------------}
{ rbShowLabelValueClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.rbShowLabelValueClick(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.DataPoints := gdpShowLabelValue;
  cbNumberFormat.Enabled := rbShowLabelValue.Checked;
  cbNumberFormat.Color := ColorState(cbNumberFormat.Enabled);
end;
{------------------------------------------------------------------------------}
{ cbNumberFormatChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbNumberFormatChange(Sender: TObject);
begin
  Cr.Graphs.Item.OptionInfo.NumberFormat := TCrGraphNumberFormat(cbNumberFormat.ItemIndex);
end;
{******************************************************************************}
{ Graphs.Axis                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GraphAxisMajorGridLineClick procedure                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.GraphAxisMajorGridLineClick(Sender: TObject);

  function GridLineClick(GLMajor, GLMinor: TCheckbox): TCrGraphGridLines;
  begin
    if GLMajor.Checked and GLMinor.Checked then
      Result := gglMajorAndMinor
    else if GLMajor.Checked then
      Result := gglMajor
    else if GLMinor.Checked then
      Result := gglMinor
    else
      Result := gglNone;
  end;

begin
  if not (Sender is TCheckBox) then
    Exit;
  if TCheckBox(Sender).Name = 'cbMajorX' then
    Cr.Graphs.Item.Axis.GridLineX := GridLineClick(cbMajorX, cbMinorX);
  if TCheckBox(Sender).Name = 'cbMajorY' then
    Cr.Graphs.Item.Axis.GridLineY := GridLineClick(cbMajorY, cbMinorY);
  if TCheckBox(Sender).Name = 'cbMajorY2' then
    Cr.Graphs.Item.Axis.GridLineY2 := GridLineClick(cbMajorY2, cbMinorY2);
  if TCheckBox(Sender).Name = 'cbMajorZ' then
    Cr.Graphs.Item.Axis.GridLineZ := GridLineClick(cbMajorZ, cbMinorZ);
end;
{------------------------------------------------------------------------------}
{ GraphAxisMinorGridLineClick procedure                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.GraphAxisMinorGridLineClick(Sender: TObject);

  function GridLineClick(GLMajor, GLMinor: TCheckbox): TCrGraphGridLines;
  begin
    if GLMajor.Checked and GLMinor.Checked then
      Result := gglMajorAndMinor
    else if GLMajor.Checked then
      Result := gglMajor
    else if GLMinor.Checked then
      Result := gglMinor
    else
      Result := gglNone;
  end;

begin
  if not (Sender is TCheckBox) then
    Exit;
  if TCheckBox(Sender).Name = 'cbMinorX' then
    Cr.Graphs.Item.Axis.GridLineX := GridLineClick(cbMajorX, cbMinorX);
  if TCheckBox(Sender).Name = 'cbMinorY' then
    Cr.Graphs.Item.Axis.GridLineY := GridLineClick(cbMajorY, cbMinorY);
  if TCheckBox(Sender).Name = 'cbMinorY2' then
    Cr.Graphs.Item.Axis.GridLineY2 := GridLineClick(cbMajorY2, cbMinorY2);
  if TCheckBox(Sender).Name = 'cbMinorZ' then
    Cr.Graphs.Item.Axis.GridLineZ := GridLineClick(cbMajorZ, cbMinorZ);
end;
{------------------------------------------------------------------------------}
{ GraphAxisDivisionTypeChange procedure                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.GraphAxisDivisionTypeChange(Sender: TObject);

  function GetDivisionType(DTCombo: TComboBox; DivEdit: TEdit): TCrGraphDVType;
  begin
    DivEdit.Enabled := (DTCombo.ItemIndex = 2); {gdvManual}
    DivEdit.Color := ColorState(DivEdit.Enabled);
    Result := TCrGraphDVType(DTCombo.ItemIndex);
  end;

begin
  if not (Sender is TComboBox) then
    Exit;
  if TComboBox(Sender).Name = 'cbDivisionTypeY' then
  begin
    Cr.Graphs.Item.Axis.DivisionTypeY := GetDivisionType(cbDivisionTypeY, editDivisionsY);
    editDivisionsY.Enabled := (cbDivisionTypeY.ItemIndex = 1);
    editDivisionsY.Color := ColorState(cbDivisionTypeY.ItemIndex = 1);
  end;
  if TComboBox(Sender).Name = 'cbDivisionTypeY2' then
  begin
    Cr.Graphs.Item.Axis.DivisionTypeY2 := GetDivisionType(cbDivisionTypeY2, editDivisionsY2);
    editDivisionsY2.Enabled := (cbDivisionTypeY2.ItemIndex = 1);
    editDivisionsY2.Color := ColorState(cbDivisionTypeY2.ItemIndex = 1);
  end;
  if TComboBox(Sender).Name = 'cbDivisionTypeZ' then
  begin
    Cr.Graphs.Item.Axis.DivisionTypeZ := GetDivisionType(cbDivisionTypeZ, editDivisionsZ);
    editDivisionsZ.Enabled := (cbDivisionTypeZ.ItemIndex = 1);
    editDivisionsZ.Color := ColorState(cbDivisionTypeZ.ItemIndex = 1);
  end;
end;
{------------------------------------------------------------------------------}
{ editDivisionsEnter procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editDivisionsEnter(Sender: TObject);
begin
  prevNum := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editDivisionsExit procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editDivisionsExit(Sender: TObject);
begin
  if not IsNumeric(TEdit(Sender).Text) then
    TEdit(Sender).Text := prevNum
  else
  begin
    if TEdit(Sender).Name = 'editDivisionsY' then
      Cr.Graphs.Item.Axis.DivisionsY := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editDivisionsY2' then
      Cr.Graphs.Item.Axis.DivisionsY2 := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editDivisionsZ' then
      Cr.Graphs.Item.Axis.DivisionsZ := StrToInt(TEdit(Sender).Text);
  end;
end;
{------------------------------------------------------------------------------}
{ DataValuesAutoRangeClick procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.DataValuesAutoRangeClick(Sender: TObject);

  function AutoRangeClick(cbAuto: TCheckBox; editMin, editMax: TEdit;
    cbNum: TComboBox): TCrGraphDVType;
  var
    bSet: boolean;
  begin
    if cbAuto.Checked then
    begin
      bSet := True;
      Result := gdvAutomatic;
    end
    else
    begin
      bSet := False;
      Result := gdvManual;
    end;
    editMin.Enabled := not bSet;
    editMin.Color := ColorState(editMin.Enabled);
    editMax.Enabled := not bSet;
    editMax.Color := ColorState(editMax.Enabled);
    cbNum.Enabled := not bSet;
    cbNum.Color := ColorState(cbNum.Enabled);
  end;

begin
  if not (Sender is TCheckBox) then
    Exit;
  if TCheckBox(Sender).Name = 'cbDataValuesY' then
    Cr.Graphs.Item.Axis.DataValuesY := AutoRangeClick(cbDataValuesY,
      editMinY, editMaxY, cbNumberFormatY);
  if TCheckBox(Sender).Name = 'cbDataValuesY2' then
    Cr.Graphs.Item.Axis.DataValuesY2 := AutoRangeClick(cbDataValuesY2,
      editMinY2, editMaxY2, cbNumberFormatY2);
  if TCheckBox(Sender).Name = 'cbDataValuesZ' then
    Cr.Graphs.Item.Axis.DataValuesZ := AutoRangeClick(cbDataValuesZ,
      editMinZ, editMaxZ, cbNumberFormatZ);
end;
{------------------------------------------------------------------------------}
{ MinEnter procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.MinEnter(Sender: TObject);
begin
  prevNum := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ MinExit procedure                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.MinExit(Sender: TObject);
begin
  if not IsNumeric(TEdit(Sender).Text) then
    TEdit(Sender).Text := prevNum
  else
  begin
    if TEdit(Sender).Name = 'editMinY' then
      Cr.Graphs.Item.Axis.MinY := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editMinY2' then
      Cr.Graphs.Item.Axis.MinY2 := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editMinZ' then
      Cr.Graphs.Item.Axis.MinZ := StrToInt(TEdit(Sender).Text);
  end;
end;
{------------------------------------------------------------------------------}
{ MaxEnter procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.MaxEnter(Sender: TObject);
begin
  prevNum := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ MaxExit procedure                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.MaxExit(Sender: TObject);
begin
  if not IsNumeric(TEdit(Sender).Text) then
    TEdit(Sender).Text := prevNum
  else
  begin
    if TEdit(Sender).Name = 'editMaxY' then
      Cr.Graphs.Item.Axis.MaxY := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editMaxY2' then
      Cr.Graphs.Item.Axis.MaxY2 := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editMaxZ' then
      Cr.Graphs.Item.Axis.MaxZ := StrToInt(TEdit(Sender).Text);
  end;
end;
{------------------------------------------------------------------------------}
{ NumberFormatChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.NumberFormatChange(Sender: TObject);
begin
  if TEdit(Sender).Name = 'cbNumberFormatY' then
    Cr.Graphs.Item.Axis.NumberFormatY := TCrGraphNumberFormat(cbNumberFormatY.ItemIndex);
  if TEdit(Sender).Name = 'cbNumberFormatY2' then
    Cr.Graphs.Item.Axis.NumberFormatY2 := TCrGraphNumberFormat(cbNumberFormatY2.ItemIndex);
  if TEdit(Sender).Name = 'cbNumberFormatZ' then
    Cr.Graphs.Item.Axis.NumberFormatZ := TCrGraphNumberFormat(cbNumberFormatZ.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editEditKeyPress procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(wm_NextDlgCtl,0,0);
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Graphs.Item.Top);
    editWidth.Text := TwipsToInchesStr(Cr.Graphs.Item.Width);
    editLeft.Text := TwipsToInchesStr(Cr.Graphs.Item.Left);
    editHeight.Text := TwipsToInchesStr(Cr.Graphs.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Graphs.Item.Top);
    editWidth.Text := IntToStr(Cr.Graphs.Item.Width);
    editLeft.Text := IntToStr(Cr.Graphs.Item.Left);
    editHeight.Text := IntToStr(Cr.Graphs.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Graphs.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Graphs.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Graphs.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Graphs.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateGraphs; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Graphs.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Graphs.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Graphs.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Graphs.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.Graphs.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.Graphs.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.Graphs.Item.Format;
  CrpeFormatDlg.ShowModal;
end;


{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.btnClearClick(Sender: TObject);
begin
  Cr.Graphs.Clear;
  UpdateGraphs;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateFormulas call}
  if (not IsStrEmpty(Cr.ReportName)) and (GIndex > -1) then 
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
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bGraphs := False;
  Release;
end;


end.





