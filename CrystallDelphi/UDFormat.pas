unit UDFormat;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, UCrpe32, UCrpeClasses;

type
  TCrpeFormatDlg = class(TForm)
    pcFormat: TPageControl;
    tsCommon: TTabSheet;
    tsNumber: TTabSheet;
    tsCurrency: TTabSheet;
    tsDate: TTabSheet;
    tsTime: TTabSheet;
    tsDateTime: TTabSheet;
    gbCommon: TGroupBox;
    cbSuppress: TCheckBox;
    lblAlignment: TLabel;
    cbAlignment: TComboBox;
    cbKeepTogether: TCheckBox;
    cbCloseBorder: TCheckBox;
    cbCanGrow: TCheckBox;
    editMaxNLines: TEdit;
    lblMaxNLines: TLabel;
    lblToolTip: TLabel;
    lblTextRotation: TLabel;
    cbTextRotation: TComboBox;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    sbSuppress: TSpeedButton;
    sbAlignment: TSpeedButton;
    sbKeepTogether: TSpeedButton;
    sbCloseBorder: TSpeedButton;
    sbToolTip: TSpeedButton;
    tsParagraph: TTabSheet;
    lblHyperLink: TLabel;
    sbHyperLink: TSpeedButton;
    cbSuppressIfDuplicated: TCheckBox;
    sbSuppressIfDuplicated: TSpeedButton;
    pnlNumber1: TPanel;
    cbUseSystemDefaultFormatting: TCheckBox;
    pnlNumber2: TPanel;
    cbSuppressIfZero: TCheckBox;
    lblDecimalPlaces: TLabel;
    lblRoundingFormat: TLabel;
    cbRoundingFormat: TComboBox;
    lblNegativeFormat: TLabel;
    cbNegativeFormat: TComboBox;
    cbAllowFieldClipping: TCheckBox;
    editDecimalPlaces: TEdit;
    sbSuppressIfZero: TSpeedButton;
    sbDecimalPlaces: TSpeedButton;
    sbNegativeFormat: TSpeedButton;
    sbRoundingFormat: TSpeedButton;
    sbAllowFieldClipping: TSpeedButton;
    lblDecimalSymbol: TLabel;
    editDecimalSymbol: TEdit;
    sbDecimalSymbol: TSpeedButton;
    cbUseThousandsSeparators: TCheckBox;
    sbUseThousandsSeparators: TSpeedButton;
    lblThousandSymbol: TLabel;
    editThousandSymbol: TEdit;
    sbThousandSymbol: TSpeedButton;
    cbUseLeadingZero: TCheckBox;
    sbUseLeadingZero: TSpeedButton;
    cbUseAccountingFormat: TCheckBox;
    cbReverseSignForDisplay: TCheckBox;
    sbReverseSignForDisplay: TSpeedButton;
    lblShowZeroValueAs: TLabel;
    pnlCurrency: TPanel;
    sbCurrencySymbolFormat: TSpeedButton;
    lblCurrencySymbolFormat: TLabel;
    cbCurrencySymbolFormat: TComboBox;
    cbOneCurrencySymbolPerPage: TCheckBox;
    sbOneCurrencySymbolPerPage: TSpeedButton;
    lblCurrencySymbol: TLabel;
    editCurrencySymbol: TEdit;
    sbCurrencySymbol: TSpeedButton;
    lblCurrencySymbolPlacement: TLabel;
    cbCurrencySymbolPosition: TComboBox;
    sbCurrencySymbolPosition: TSpeedButton;
    lblDateType: TLabel;
    lblCalendarType: TLabel;
    sbCalendarType: TSpeedButton;
    sbDateType: TSpeedButton;
    cbDateType: TComboBox;
    cbCalendarType: TComboBox;
    gbFormat: TGroupBox;
    gbDateOrder: TGroupBox;
    gbDayOfWeek: TGroupBox;
    gbSeparators: TGroupBox;
    editPrefix: TEdit;
    sbPrefix: TSpeedButton;
    lblPrefix: TLabel;
    editFirst: TEdit;
    sbFirst: TSpeedButton;
    lblFirst: TLabel;
    editSecond: TEdit;
    sbSecond: TSpeedButton;
    lblSecond: TLabel;
    editSuffix: TEdit;
    sbSuffix: TSpeedButton;
    lblSuffix: TLabel;
    lblMonth: TLabel;
    lblDay: TLabel;
    sbDay: TSpeedButton;
    sbMonth: TSpeedButton;
    cbMonth: TComboBox;
    cbDay: TComboBox;
    lblYear: TLabel;
    sbYear: TSpeedButton;
    cbYear: TComboBox;
    lblDateOrder: TLabel;
    cbDateOrder: TComboBox;
    sbDateOrder: TSpeedButton;
    lblType: TLabel;
    cbType: TComboBox;
    sbType: TSpeedButton;
    lblSeparator: TLabel;
    editSeparator: TEdit;
    sbSeparator: TSpeedButton;
    lblEnclosure: TLabel;
    cbEnclosure: TComboBox;
    sbEnclosure: TSpeedButton;
    lblPosition: TLabel;
    cbPosition: TComboBox;
    sbPosition: TSpeedButton;
    lblDateEra: TLabel;
    cbDateEra: TComboBox;
    sbDateEra: TSpeedButton;
    pnlTime1: TPanel;
    pnlTime2: TPanel;
    lblTimeBase: TLabel;
    sbTimeBase: TSpeedButton;
    cbTimeBase: TComboBox;
    lblAMString: TLabel;
    editAMString: TEdit;
    sbAMString: TSpeedButton;
    lblPMString: TLabel;
    editPMString: TEdit;
    sbPMString: TSpeedButton;
    lblAmPmPosition: TLabel;
    cbAmPmPosition: TComboBox;
    sbAmPmPosition: TSpeedButton;
    lblHourType: TLabel;
    lblMinuteType: TLabel;
    sbMinuteType: TSpeedButton;
    sbHourType: TSpeedButton;
    cbHourType: TComboBox;
    cbMinuteType: TComboBox;
    lblSecondType: TLabel;
    sbSecondType: TSpeedButton;
    cbSecondType: TComboBox;
    lblHourMinSeparator: TLabel;
    editHourMinSeparator: TEdit;
    sbHourMinSeparator: TSpeedButton;
    lblMinSecSeparator: TLabel;
    editMinSecSeparator: TEdit;
    sbMinSecSeparator: TSpeedButton;
    pnlDateTime: TPanel;
    lblOrder: TLabel;
    cbOrder: TComboBox;
    sbOrder: TSpeedButton;
    lblDateTimeSeparator: TLabel;
    editDateTimeSeparator: TEdit;
    sbDateTimeSeparator: TSpeedButton;
    gbIndentations: TGroupBox;
    gbSpacing: TGroupBox;
    gbTextInterpretation: TGroupBox;
    lblIndentFirstLine: TLabel;
    editIndentFirstLine: TEdit;
    lblIndentLeft: TLabel;
    editIndentLeft: TEdit;
    lblIndentRight: TLabel;
    editIndentRight: TEdit;
    lblTextInterpretation: TLabel;
    sbTextInterpretation: TSpeedButton;
    cbTextInterpretation: TComboBox;
    lblLineSpacingType: TLabel;
    cbLineSpacingType: TComboBox;
    btnOk: TButton;
    btnClear: TButton;
    tsBoolean: TTabSheet;
    pnlBoolean: TPanel;
    lblBooleanType: TLabel;
    cbBooleanType: TComboBox;
    sbBooleanType: TSpeedButton;
    pnlTimeDefault: TPanel;
    cbUseSystemDefaultForDate: TCheckBox;
    cbUseSystemDefaultForTime: TCheckBox;
    editShowZeroValueAs: TEdit;
    sbCanGrow: TSpeedButton;
    lblLineSpacing: TLabel;
    editLineSpacing: TEdit;
    lblLineSpacingText: TLabel;
    lblCharacterSpacing: TLabel;
    editCharacterSpacing: TEdit;
    lblPoints: TLabel;
    rgUnits: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateFormat;
    procedure Initialize(OnOff: boolean);
    procedure cbSuppressClick(Sender: TObject);
    procedure cbAlignmentChange(Sender: TObject);
    procedure cbKeepTogetherClick(Sender: TObject);
    procedure cbCloseBorderClick(Sender: TObject);
    procedure cbCanGrowClick(Sender: TObject);
    procedure cbTextRotationChange(Sender: TObject);
    procedure editMaxNLinesChange(Sender: TObject);
    procedure cbSuppressIfDuplicatedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure sbSuppressClick(Sender: TObject);
    procedure sbAlignmentClick(Sender: TObject);
    procedure sbKeepTogetherClick(Sender: TObject);
    procedure sbCloseBorderClick(Sender: TObject);
    procedure sbToolTipClick(Sender: TObject);
    procedure sbHyperLinkClick(Sender: TObject);
    procedure sbSuppressIfDuplicatedClick(Sender: TObject);
    procedure cbUseSystemDefaultFormattingClick(Sender: TObject);
    procedure cbUseAccountingFormatClick(Sender: TObject);
    procedure cbSuppressIfZeroClick(Sender: TObject);
    procedure editDecimalPlacesChange(Sender: TObject);
    procedure cbRoundingFormatChange(Sender: TObject);
    procedure cbNegativeFormatChange(Sender: TObject);
    procedure cbReverseSignForDisplayClick(Sender: TObject);
    procedure cbAllowFieldClippingClick(Sender: TObject);
    procedure editDecimalSymbolChange(Sender: TObject);
    procedure cbUseThousandsSeparatorsClick(Sender: TObject);
    procedure editThousandSymbolChange(Sender: TObject);
    procedure cbUseLeadingZeroClick(Sender: TObject);
    procedure editShowZeroValueAsChange(Sender: TObject);
    procedure cbCurrencySymbolFormatChange(Sender: TObject);
    procedure cbOneCurrencySymbolPerPageClick(Sender: TObject);
    procedure cbCurrencySymbolPositionChange(Sender: TObject);
    procedure editCurrencySymbolChange(Sender: TObject);
    procedure sbCurrencySymbolFormatClick(Sender: TObject);
    procedure sbOneCurrencySymbolPerPageClick(Sender: TObject);
    procedure sbCurrencySymbolPositionClick(Sender: TObject);
    procedure sbCurrencySymbolClick(Sender: TObject);
    procedure cbDateTypeChange(Sender: TObject);
    procedure cbUseSystemDefaultForDateClick(Sender: TObject);
    procedure cbCalendarTypeChange(Sender: TObject);
    procedure cbMonthChange(Sender: TObject);
    procedure cbDayChange(Sender: TObject);
    procedure cbYearChange(Sender: TObject);
    procedure cbDateEraChange(Sender: TObject);
    procedure cbDateOrderChange(Sender: TObject);
    procedure cbTypeChange(Sender: TObject);
    procedure editSeparatorChange(Sender: TObject);
    procedure cbEnclosureChange(Sender: TObject);
    procedure cbPositionChange(Sender: TObject);
    procedure editPrefixChange(Sender: TObject);
    procedure editFirstChange(Sender: TObject);
    procedure editSecondChange(Sender: TObject);
    procedure editSuffixChange(Sender: TObject);
    procedure cbOrderChange(Sender: TObject);
    procedure editDateTimeSeparatorChange(Sender: TObject);
    procedure cbUseSystemDefaultForTimeClick(Sender: TObject);
    procedure cbTimeBaseChange(Sender: TObject);
    procedure editAMStringChange(Sender: TObject);
    procedure editPMStringChange(Sender: TObject);
    procedure cbAmPmPositionChange(Sender: TObject);
    procedure cbHourTypeChange(Sender: TObject);
    procedure cbMinuteTypeChange(Sender: TObject);
    procedure cbSecondTypeChange(Sender: TObject);
    procedure editHourMinSeparatorChange(Sender: TObject);
    procedure editMinSecSeparatorChange(Sender: TObject);
    procedure cbLineSpacingTypeChange(Sender: TObject);
    procedure cbTextInterpretationChange(Sender: TObject);
    procedure cbBooleanTypeChange(Sender: TObject);
    procedure sbBooleanTypeClick(Sender: TObject);
    procedure sbDateTypeClick(Sender: TObject);
    procedure sbCalendarTypeClick(Sender: TObject);
    procedure sbMonthClick(Sender: TObject);
    procedure sbDayClick(Sender: TObject);
    procedure sbYearClick(Sender: TObject);
    procedure sbDateEraClick(Sender: TObject);
    procedure sbDateOrderClick(Sender: TObject);
    procedure sbTypeClick(Sender: TObject);
    procedure sbSeparatorClick(Sender: TObject);
    procedure sbEnclosureClick(Sender: TObject);
    procedure sbPositionClick(Sender: TObject);
    procedure sbPrefixClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure sbSecondClick(Sender: TObject);
    procedure sbSuffixClick(Sender: TObject);
    procedure sbOrderClick(Sender: TObject);
    procedure sbDateTimeSeparatorClick(Sender: TObject);
    procedure sbTimeBaseClick(Sender: TObject);
    procedure sbAMStringClick(Sender: TObject);
    procedure sbPMStringClick(Sender: TObject);
    procedure sbAmPmPositionClick(Sender: TObject);
    procedure sbHourTypeClick(Sender: TObject);
    procedure sbMinuteTypeClick(Sender: TObject);
    procedure sbSecondTypeClick(Sender: TObject);
    procedure sbHourMinSeparatorClick(Sender: TObject);
    procedure sbMinSecSeparatorClick(Sender: TObject);
    procedure sbTextInterpretationClick(Sender: TObject);
    procedure sbCanGrowClick(Sender: TObject);
    procedure sbSuppressIfZeroClick(Sender: TObject);
    procedure sbDecimalPlacesClick(Sender: TObject);
    procedure sbRoundingFormatClick(Sender: TObject);
    procedure sbNegativeFormatClick(Sender: TObject);
    procedure sbReverseSignForDisplayClick(Sender: TObject);
    procedure sbAllowFieldClippingClick(Sender: TObject);
    procedure sbDecimalSymbolClick(Sender: TObject);
    procedure sbUseThousandsSeparatorsClick(Sender: TObject);
    procedure sbThousandSymbolClick(Sender: TObject);
    procedure sbUseLeadingZeroClick(Sender: TObject);
    procedure SetFormulaGlyph (fBtn: TSpeedButton; sList: TStrings);
    procedure SetFormulaGlyphEx (fBtn: TSpeedButton; fName: TCrFormatFormulaName);
    procedure editLineSpacingExit(Sender: TObject);
    procedure editLineSpacingEnter(Sender: TObject);
    procedure editCharacterSpacingEnter(Sender: TObject);
    procedure editCharacterSpacingExit(Sender: TObject);
    procedure editIndentEnter(Sender: TObject);
    procedure editIndentExit(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Format  : TCrpePersistent;
    Cfa     : TCrpeFormatA;
    Cfb     : TCrpeFormatC;
    Cff     : TCrpeFieldObjectFormat;
    prevStr : string;
    bClose  : Boolean;
  end;

var
  CrpeFormatDlg: TCrpeFormatDlg;
  bFormat      : boolean;

implementation

{$R *.DFM}

uses Dialogs, UCrpeUtl, UDFormulaEdit, UDToolTipEdit;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.FormCreate(Sender: TObject);
begin
  bFormat := True;
  bClose := False;
  LoadFormPos(Self);
  prevStr := '';
  Cfa := nil;
  Cfb := nil;
  Cff := nil;

  {Common Formatting}
  cbAlignment.Clear;
  with cbAlignment.Items do
  begin
    Add('haDefault');
    Add('haLeft');
    Add('haCenter');
    Add('haRight');
    Add('haJustified');
    Add('haDecimal');
  end;
  cbTextRotation.Clear;
  with cbTextRotation.Items do
  begin
    Add('trZero');
    Add('tr90');
    Add('tr270');
  end;

  {Boolean}
  cbBooleanType.Clear;
  with cbBooleanType.Items do
  begin
    Add('TrueFalse');
    Add('TF');
    Add('YesNo');
    Add('YN');
    Add('OneZero');
  end;

  {Paragraph}
  cbLineSpacingType.Clear;
  with cbLineSpacingType.Items do
  begin
    Add('lsMultiple');
    Add('lsExact');
  end;
  cbTextInterpretation.Clear;
  with cbTextInterpretation.Items do
  begin
    Add('tiNone');
    Add('tiRTF');
    Add('tiHTML');
  end;

  {DateTime}
  cbOrder.Clear;
  with cbOrder.Items do
  begin
    Add('dtoDateTime');
    Add('dtoTimeDate');
    Add('dtoDate');
    Add('dtoTime');
  end;

  {Time}
  cbTimeBase.Clear;
  with cbTimeBase.Items do
  begin
    Add('tf12Hour');
    Add('tf24Hour');
  end;
  cbAmPmPosition.Clear;
  with cbAmPmPosition.Items do
  begin
    Add('ampmBefore');
    Add('ampmAfter');
  end;
  cbHourType.Clear;
  with cbHourType.Items do
  begin
    Add('tfNumeric');
    Add('tfNoLeadingZero');
    Add('tfNone');
  end;
  cbMinuteType.Clear;
  with cbMinuteType.Items do
  begin
    Add('tfNumeric');
    Add('tfNoLeadingZero');
    Add('tfNone');
  end;
  cbSecondType.Clear;
  with cbSecondType.Items do
  begin
    Add('tfNumeric');
    Add('tfNoLeadingZero');
    Add('tfNone');
  end;

  {Date}
  cbDateType.Clear;
  with cbDateType.Items do
  begin
    Add('dfWindowsLong');
    Add('dfWindowsShort');
    Add('dfUserDefined');
  end;
  cbCalendarType.Clear;
  with cbCalendarType.Items do
  begin
    Add('ctGregorian');
    Add('ctGregorianus');
    Add('ctJapanese');
    Add('ctTaiwanese');
    Add('ctKorean');
    Add('ctHijri');
    Add('ctThai');
  end;
  cbMonth.Clear;
  with cbMonth.Items do
  begin
    Add('mfNumeric');
    Add('mfLeadingZeroNumeric');
    Add('mfShort');
    Add('mfLong');
    Add('mfNone');
  end;
  cbDay.Clear;
  with cbDay.Items do
  begin
    Add('dfNumeric');
    Add('dfLeadingZeroNumeric');
    Add('dfNone');
  end;
  cbYear.Clear;
  with cbYear.Items do
  begin
    Add('yfShort');
    Add('yfLong');
    Add('yfNone');
  end;
  cbDateEra.Clear;
  with cbDateEra.Items do
  begin
    Add('deShort');
    Add('deLong');
    Add('deNone');
  end;
  cbDateOrder.Clear;
  with cbDateOrder.Items do
  begin
    Add('doYMD');
    Add('doDMY');
    Add('doMDY');
  end;
  cbType.Clear;
  with cbType.Items do
  begin
    Add('dwfShort');
    Add('dwfLong');
    Add('dwfNone');
  end;
  cbEnclosure.Clear;
  with cbEnclosure.Items do
  begin
    Add('dweNone');
    Add('dweParentheses');
    Add('dweFWParentheses');
    Add('dweSquareBrackets');
    Add('dweFWSquareBrackets');
  end;
  cbPosition.Clear;
  with cbPosition.Items do
  begin
    Add('dwpLeading');
    Add('dwpTrailing');
  end;

  {Currency}
  cbCurrencySymbolFormat.Clear;
  with cbCurrencySymbolFormat.Items do
  begin
    Add('csfNone');
    Add('csfFixed');
    Add('csfFloating');
  end;
  cbCurrencySymbolPosition.Clear;
  with cbCurrencySymbolPosition.Items do
  begin
    Add('cspLeadingInside');
    Add('cspLeadingOutside');
    Add('cspTrailingInside');
    Add('cspTrailingOutside');
  end;

  {Number}
  cbRoundingFormat.Clear;
  with cbRoundingFormat.Items do
  begin
    Add('rfTenBillionth');
    Add('rfBillionth');
    Add('rfHundredMillionth');
    Add('rfTenMillionth');
    Add('rfMillionth');
    Add('rfHundredThousandth');
    Add('rfTenThousandth');
    Add('rfThousandth');
    Add('rfHundredth');
    Add('rfTenth');
    Add('rfUnit');
    Add('rfTen');
    Add('rfHundred');
    Add('rfThousand');
    Add('rfTenThousand');
    Add('rfHundredThousand');
    Add('rfMillion');
  end;
  cbNegativeFormat.Clear;
  with cbNegativeFormat.Items do
  begin
    Add('nfNone');
    Add('nfLeading');
    Add('nfTrailing');
    Add('nfBracketed');
  end;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.FormShow(Sender: TObject);
begin
  tsNumber.Visible := False;
  tsNumber.TabVisible := False;
  tsCurrency.Visible := False;
  tsCurrency.TabVisible := False;
  tsDate.Visible := False;
  tsDate.TabVisible := False;
  tsTime.Visible := False;
  tsTime.TabVisible := False;
  tsDateTime.Visible := False;
  tsDateTime.TabVisible := False;
  tsParagraph.Visible := False;
  tsParagraph.TabVisible := False;
  tsBoolean.Visible := False;
  tsBoolean.TabVisible := False;

  if Format is TCrpeFieldObjectFormat then
  begin
    Cff := TCrpeFieldObjectFormat(Format);
    {Enable pages based on FieldType}
    case Cff.Field.FieldType of
      fvUnknown                  : ;
      fvInt8s..fvCurrency        :
        begin
          tsNumber.TabVisible := True;
          tsNumber.Visible := True;
          tsCurrency.TabVisible := True;
          tsCurrency.Visible := True;
          pcFormat.ActivePage := tsNumber;
        end;
      fvBoolean                  :
        begin
          tsBoolean.TabVisible := True;
          tsBoolean.Visible := True;
          pcFormat.ActivePage := tsBoolean;
        end;
      fvDate                     :
        begin
          tsDate.TabVisible := True;
          tsDate.Visible := True;
          pcFormat.ActivePage := tsDate;
        end;
      fvTime                     :
        begin
          tsTime.TabVisible := True;
          tsTime.Visible := True;
          pcFormat.ActivePage := tsTime;
        end;
      fvString..fvPersistentMemo :
        begin
          tsParagraph.TabVisible := True;
          tsParagraph.Visible := True;
          pcFormat.ActivePage := tsParagraph;
        end;
      fvBlob                     : ;
      fvDateTime                 :
        begin
          tsDateTime.TabVisible := True;
          tsDate.TabVisible := True;
          tsTime.TabVisible := True;
          tsDateTime.Visible := True;
          tsDate.Visible := True;
          tsTime.Visible := True;
          pcFormat.ActivePage := tsDateTime;
        end;
    end;
    pcFormat.ActivePage := tsCommon;
    UpdateFormat;
    Exit;
  end;

  if Format is TCrpeFormatB then
  begin
    Cfb := TCrpeFormatC(Format);
    tsParagraph.TabVisible := True;
    tsParagraph.Visible := True;
    pcFormat.ActivePage := tsParagraph;
    pcFormat.ActivePage := tsCommon;
    UpdateFormat;
    Exit;
  end;

  if Format is TCrpeFormatA then
  begin
    Cfa := TCrpeFormatA(Format);
    pcFormat.ActivePage := tsNumber;
    pcFormat.ActivePage := tsCommon;
    UpdateFormat;
  end;
end;
{------------------------------------------------------------------------------}
{ SetFormulaGlyph                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.SetFormulaGlyph (fBtn: TSpeedButton; sList: TStrings);
begin
  if not IsStringListEmpty(sList) then
  begin
    if fBtn.Glyph <> sbFormulaRed.Glyph then
      fBtn.Glyph := sbFormulaRed.Glyph;
  end
  else
  begin
    if fBtn.Glyph <> sbFormulaBlue.Glyph then
      fBtn.Glyph := sbFormulaBlue.Glyph;
  end;
end;
{------------------------------------------------------------------------------}
{ SetFormulaGlyphEx                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.SetFormulaGlyphEx (fBtn: TSpeedButton; fName: TCrFormatFormulaName);
begin
  Cff.Field.Formulas.Name := fName;
  if not IsStringListEmpty(Cff.Field.Formulas.Formula) then
  begin
    if fBtn.Glyph <> sbFormulaRed.Glyph then
      fBtn.Glyph := sbFormulaRed.Glyph;
  end
  else
  begin
    if fBtn.Glyph <> sbFormulaBlue.Glyph then
      fBtn.Glyph := sbFormulaBlue.Glyph;
  end;
end;
{------------------------------------------------------------------------------}
{ UpdateFormat                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.UpdateFormat;
begin
  if bClose then Exit;
  {TCrpeFormatA - Applies to OleObjects, Graphs, CrossTabs, Pictures,
    Maps, OlapGrids, Subreports}
  if Cfa <> nil then
  begin
    {Disable Common Options that only apply to Fields/TextObj/SubRpt}
    cbAlignment.Enabled := False;
    cbAlignment.Color := ColorState(False);
    sbAlignment.Enabled := False;
    lblAlignment.Enabled := False;
    cbCanGrow.Enabled := False;
    sbCanGrow.Enabled := False;
    editMaxNLines.Enabled := False;
    editMaxNLines.Color := ColorState(False);
    lblMaxNLines.Enabled := False;
    cbTextRotation.Enabled := False;
    cbTextRotation.Color := ColorState(False);
    lblTextRotation.Enabled := False;
    cbSuppressIfDuplicated.Enabled := False;
    cbSuppressIfDuplicated.Color := ColorState(False);
    sbSuppressIfDuplicated.Enabled := False;
    {Suppress}
    cbSuppress.Checked := Cfa.Suppress;
    SetFormulaGlyph (sbSuppress, Cfa.Formulas.Suppress);
    {KeepTogether}
    cbKeepTogether.Checked := Cfa.KeepTogether;
    SetFormulaGlyph (sbKeepTogether, Cfa.Formulas.KeepTogether);
    {CloseBorder}
    cbCloseBorder.Checked := Cfa.CloseBorder;
    SetFormulaGlyph (sbCloseBorder, Cfa.Formulas.CloseBorder);
    {ToolTip}
    if not IsStrEmpty(Cfa.ToolTip) then
    begin
      if sbToolTip.Glyph <> sbFormulaRed.Glyph then
        sbToolTip.Glyph := sbFormulaRed.Glyph;
    end
    else
    begin
      if sbToolTip.Glyph <> sbFormulaBlue.Glyph then
        sbToolTip.Glyph := sbFormulaBlue.Glyph;
    end;
    {HyperLink}
    SetFormulaGlyph (sbHyperLink, Cfa.Formulas.HyperLink);
  end;

  {TCrpeFormatB - Applies to TextObjects}
  if Cfb <> nil then
  begin
    {Suppress}
    cbSuppress.Checked := Cfb.Suppress;
    SetFormulaGlyph (sbSuppress, Cfb.Formulas.Suppress);
    {KeepTogether}
    cbKeepTogether.Checked := Cfb.KeepTogether;
    SetFormulaGlyph (sbKeepTogether, Cfb.Formulas.KeepTogether);
    {CloseBorder}
    cbCloseBorder.Checked := Cfb.CloseBorder;
    SetFormulaGlyph (sbCloseBorder, Cfb.Formulas.CloseBorder);
    {ToolTip}
    if not IsStrEmpty(Cfb.ToolTip) then
    begin
      if sbToolTip.Glyph <> sbFormulaRed.Glyph then
        sbToolTip.Glyph := sbFormulaRed.Glyph;
    end
    else
    begin
      if sbToolTip.Glyph <> sbFormulaBlue.Glyph then
        sbToolTip.Glyph := sbFormulaBlue.Glyph;
    end;
    {HyperLink}
    SetFormulaGlyph (sbHyperLink, Cfb.Formulas.HyperLink);
    {Alignment}
    cbAlignment.ItemIndex := Ord(Cfb.Alignment);
    SetFormulaGlyph (sbAlignment, Cfb.Formulas.Alignment);
    {SuppressIfDuplicated}
    cbSuppressIfDuplicated.Checked := Cfb.SuppressIfDuplicated;
    sbSuppressIfDuplicated.Enabled := False; {can not be used with TextObjects/Subreports}
    {CanGrow}
    cbCanGrow.Checked := Cfb.CanGrow;
    editMaxNLines.Enabled := Cfb.CanGrow;
    editMaxNLines.Color := ColorState(Cfb.CanGrow);
    SetFormulaGlyph (sbCanGrow, Cfb.Formulas.CanGrow);
    {MaxNLines}
    if editMaxNLines.Enabled then
      editMaxNLines.Text := IntToStr(Cfb.MaxNLines);
    {TextRotation}
    cbTextRotation.ItemIndex := Ord(Cfb.TextRotation);
    {LineSpacing}
    cbLineSpacingType.ItemIndex := Ord(Cfb.Paragraph.LineSpacingType);
    case Cfb.Paragraph.LineSpacingType of
      lsExact    : lblLineSpacingText.Caption := 'points';
      lsMultiple : lblLineSpacingText.Caption := 'times normal';
    end;
    editLineSpacing.Text := FloatToStr(Cfb.Paragraph.LineSpacing);
    {CharacterSpacing}
    editCharacterSpacing.Text := FloatToStr(Cfb.Paragraph.CharacterSpacing);
    {Text Interpretation does not apply to Text Objects}
    cbTextInterpretation.Enabled := False;
    cbTextInterpretation.Color := ColorState(False);
    sbTextInterpretation.Enabled := False;
    {Paragraph options}
    rgUnitsClick(Self);
  end;

  {TCrpeFieldFormat - Applies to Field Objects and Embedded Fields}
  if Cff <> nil then
  begin
    {Disable Common options: these only apply to String Fields}
    cbCanGrow.Enabled := False;
    sbCanGrow.Enabled := False;
    editMaxNLines.Enabled := False;
    editMaxNLines.Color := ColorState(False);
    lblMaxNLines.Enabled := False;
    cbTextRotation.Enabled := False;
    cbTextRotation.Color := ColorState(False);
    lblTextRotation.Enabled := False;
    {Suppress}
    cbSuppress.Checked := Cff.Suppress;
    SetFormulaGlyph (sbSuppress, Cff.Formulas.Suppress);
    {KeepTogether}
    cbKeepTogether.Checked := Cff.KeepTogether;
    SetFormulaGlyph (sbKeepTogether, Cff.Formulas.KeepTogether);
    {CloseBorder}
    cbCloseBorder.Checked := Cff.CloseBorder;
    SetFormulaGlyph (sbCloseBorder, Cff.Formulas.CloseBorder);
    {ToolTip}
    if not IsStrEmpty(Cff.ToolTip) then
    begin
      if sbToolTip.Glyph <> sbFormulaRed.Glyph then
        sbToolTip.Glyph := sbFormulaRed.Glyph;
    end
    else
    begin
      if sbToolTip.Glyph <> sbFormulaBlue.Glyph then
        sbToolTip.Glyph := sbFormulaBlue.Glyph;
    end;
    {HyperLink}
    SetFormulaGlyph (sbHyperLink, Cff.Formulas.HyperLink);
    {Alignment}
    cbAlignment.ItemIndex := Ord(Cff.Alignment);
    SetFormulaGlyph (sbAlignment, Cff.Formulas.Alignment);
    {SuppressIfDuplicated}
    cbSuppressIfDuplicated.Checked := Cff.SuppressIfDuplicated;
    SetFormulaGlyph (sbSuppressIfDuplicated, Cff.Formulas.SuppressIfDuplicated);
    {CanGrow}
    cbCanGrow.Checked := Cff.CanGrow;
    editMaxNLines.Enabled := Cff.CanGrow;
    editMaxNLines.Color := ColorState(Cff.CanGrow);
    SetFormulaGlyph (sbCanGrow, Cff.Formulas.CanGrow);
    {MaxNLines}
    if editMaxNLines.Enabled then
      editMaxNLines.Text := IntToStr(Cff.MaxNLines);
    {TextRotation}
    cbTextRotation.ItemIndex := Ord(Cff.TextRotation);

    {Field-specific pages}
    case Cff.Field.FieldType of
      fvUnknown                  : ;
      fvInt8s..fvCurrency        :
        begin
          {Number}
          cbUseSystemDefaultFormatting.Checked := Cff.Field.UseSystemDefaultFormatting;
          cbUseAccountingFormat.Checked := Cff.Field.Number.UseAccountingFormat;
          cbSuppressIfZero.Checked := Cff.Field.Number.SuppressIfZero;
          SetFormulaGlyphEx (sbSuppressIfZero, ffnSuppressIfZero);
          editDecimalPlaces.Text := IntToStr(Cff.Field.Number.DecimalPlaces);
          SetFormulaGlyphEx (sbDecimalPlaces, ffnDecimalPlaces);
          cbRoundingFormat.ItemIndex := Ord(Cff.Field.Number.RoundingFormat);
          SetFormulaGlyphEx (sbRoundingFormat, ffnRoundingFormat);
          cbNegativeFormat.ItemIndex := Ord(Cff.Field.Number.NegativeFormat);
          SetFormulaGlyphEx (sbNegativeFormat, ffnNegativeFormat);
          cbReverseSignForDisplay.Checked := Cff.Field.Number.ReverseSignForDisplay;
          SetFormulaGlyphEx (sbReverseSignForDisplay, ffnReverseSignForDisplay);
          cbAllowFieldClipping.Checked := Cff.Field.Number.AllowFieldClipping;
          SetFormulaGlyphEx (sbAllowFieldClipping, ffnAllowFieldClipping);
          editDecimalSymbol.Text := Cff.Field.Number.DecimalSymbol;
          SetFormulaGlyphEx (sbDecimalSymbol, ffnDecimalSymbol);
          cbUseThousandsSeparators.Checked := Cff.Field.Number.UseThousandsSeparators;
          SetFormulaGlyphEx (sbUseThousandsSeparators, ffnUseThousandsSeparators);
          editThousandSymbol.Text := Cff.Field.Number.ThousandSymbol;
          SetFormulaGlyphEx (sbThousandSymbol, ffnThousandSymbol);
          cbUseLeadingZero.Checked := Cff.Field.Number.UseLeadingZero;
          SetFormulaGlyphEx (sbUseLeadingZero, ffnUseLeadingZero);
          editShowZeroValueAs.Text := Cff.Field.Number.ShowZeroValueAs;
          {Currency}
          cbCurrencySymbolFormat.ItemIndex := Ord(Cff.Field.Number.CurrencySymbolFormat);
          SetFormulaGlyphEx (sbCurrencySymbolFormat, ffnCurrencySymbolFormat);
          cbOneCurrencySymbolPerPage.Checked := Cff.Field.Number.OneCurrencySymbolPerPage;
          SetFormulaGlyphEx (sbOneCurrencySymbolPerPage, ffnOneCurrencySymbolPerPage);
          cbCurrencySymbolPosition.ItemIndex := Ord(Cff.Field.Number.CurrencySymbolPosition);
          SetFormulaGlyphEx (sbCurrencySymbolPosition, ffnCurrencySymbolPosition);
          editCurrencySymbol.Text := Cff.Field.Number.CurrencySymbol;
          SetFormulaGlyphEx (sbCurrencySymbol, ffnCurrencySymbol);
        end;
      fvBoolean                  :
        begin
          cbBooleanType.ItemIndex := Ord(Cff.Field.BooleanType);
          SetFormulaGlyphEx (sbBooleanType, ffnBooleanType);
          pcFormat.ActivePage := tsBoolean;
        end;
      fvDate, fvTime, fvDateTime :
        begin
          if Cff.Field.FieldType = fvDateTime then
          begin
            {DateTime}
            cbOrder.ItemIndex := Ord(Cff.Field.DateTime.Order);
            SetFormulaGlyphEx (sbOrder, ffnDateTimeOrder);
            editDateTimeSeparator.Text := Cff.Field.DateTime.Separator;
            SetFormulaGlyphEx (sbDateTimeSeparator, ffnDateTimeSeparator);
          end;
          if Cff.Field.FieldType in [fvDate, fvDateTime] then
          begin
            {Date}
            cbUseSystemDefaultFormatting.Checked := Cff.Field.UseSystemDefaultFormatting;
            cbDateType.ItemIndex := Ord(Cff.Field.Date.DateType);
            SetFormulaGlyphEx (sbDateType, ffnDateType);
            cbCalendarType.ItemIndex := Ord(Cff.Field.Date.CalendarType);
            SetFormulaGlyphEx (sbCalendarType, ffnCalendarType);
            cbMonth.ItemIndex := Ord(Cff.Field.Date.MonthFormat);
            SetFormulaGlyphEx (sbMonth, ffnMonthFormat);
            cbDay.ItemIndex := Ord(Cff.Field.Date.DayFormat);
            SetFormulaGlyphEx (sbDay, ffnDayFormat);
            cbYear.ItemIndex := Ord(Cff.Field.Date.YearFormat);
            SetFormulaGlyphEx (sbYear, ffnYearFormat);
            cbDateEra.ItemIndex := Ord(Cff.Field.Date.DateEra);
            SetFormulaGlyphEx (sbDateEra, ffnDateEraFormat);
            cbDateOrder.ItemIndex := Ord(Cff.Field.Date.DateOrder);
            SetFormulaGlyphEx (sbDateOrder, ffnDateOrder);
            cbType.ItemIndex := Ord(Cff.Field.Date.DayOfWeekType);
            SetFormulaGlyphEx (sbType, ffnDayOfWeekType);
            editSeparator.Text := Cff.Field.Date.DayOfWeekSeparator;
            SetFormulaGlyphEx (sbSeparator, ffnDayOfWeekSeparator);
            cbEnclosure.ItemIndex := Ord(Cff.Field.Date.DayOfWeekEnclosure);
            SetFormulaGlyphEx (sbEnclosure, ffnDayOfWeekEnclosure);
            cbPosition.ItemIndex := Ord(Cff.Field.Date.DayOfWeekPosition);
            SetFormulaGlyphEx (sbPosition, ffnDayOfWeekPosition);
            editPrefix.Text := Cff.Field.Date.PrefixSeparator;
            SetFormulaGlyphEx (sbPrefix, ffnPrefixSeparator);
            editFirst.Text := Cff.Field.Date.FirstSeparator;
            SetFormulaGlyphEx (sbFirst, ffnFirstDateSeparator);
            editSecond.Text := Cff.Field.Date.SecondSeparator;
            SetFormulaGlyphEx (sbSecond, ffnSecondDateSeparator);
            editSuffix.Text := Cff.Field.Date.SuffixSeparator;
            SetFormulaGlyphEx (sbSuffix, ffnSuffixSeparator);
          end;
          if Cff.Field.FieldType in [fvTime, fvDateTime] then
          begin
            {Time}
            cbUseSystemDefaultFormatting.Checked := Cff.Field.UseSystemDefaultFormatting;
            cbTimeBase.ItemIndex := Ord(Cff.Field.Time.TimeBase);
            SetFormulaGlyphEx (sbTimeBase, ffnTimeBase);
            editAMString.Text := Cff.Field.Time.AMString;
            SetFormulaGlyphEx (sbAMString, ffnAMString);
            editPMString.Text := Cff.Field.Time.PMString;
            SetFormulaGlyphEx (sbPMString, ffnPMString);
            cbAmPmPosition.ItemIndex := Ord(Cff.Field.Time.AmPmPosition);
            SetFormulaGlyphEx (sbAmPmPosition, ffnAmPmPosition);
            cbHourType.ItemIndex := Ord(Cff.Field.Time.HourType);
            SetFormulaGlyphEx (sbHourType, ffnHourType);
            cbMinuteType.ItemIndex := Ord(Cff.Field.Time.MinuteType);
            SetFormulaGlyphEx (sbMinuteType, ffnMinuteType);
            cbSecondType.ItemIndex := Ord(Cff.Field.Time.SecondType);
            SetFormulaGlyphEx (sbSecondType, ffnSecondType);
            editHourMinSeparator.Text := Cff.Field.Time.HourMinSeparator;
            SetFormulaGlyphEx (sbHourMinSeparator, ffnHourMinSeparator);
            editMinSecSeparator.Text := Cff.Field.Time.MinSecSeparator;
            SetFormulaGlyphEx (sbMinSecSeparator, ffnMinSecSeparator);
          end;
        end;
      fvString..fvPersistentMemo :
        begin
          {Enable Common options: these only apply to String Fields}
          cbCanGrow.Enabled := True;
          sbCanGrow.Enabled := True;
          editMaxNLines.Enabled := True;
          editMaxNLines.Color := ColorState(True);
          lblMaxNLines.Enabled := True;
          cbTextRotation.Enabled := True;
          cbTextRotation.Color := ColorState(True);
          lblTextRotation.Enabled := True;
          {LineSpacing}
          cbLineSpacingType.ItemIndex := Ord(Cff.Field.Paragraph.LineSpacingType);
          case Cff.Field.Paragraph.LineSpacingType of
            lsExact    : lblLineSpacingText.Caption := 'points';
            lsMultiple : lblLineSpacingText.Caption := 'times normal';
          end;
          editLineSpacing.Text := FloatToStr(Cff.Field.Paragraph.LineSpacing);
          {CharacterSpacing}
          editCharacterSpacing.Text := FloatToStr(Cff.Field.Paragraph.CharacterSpacing);
          cbTextInterpretation.ItemIndex := Ord(Cff.Field.Paragraph.TextInterpretation);
          SetFormulaGlyphEx (sbTextInterpretation, ffnTextInterpretation);
          {Paragraph options}
          rgUnitsClick(Self);
        end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ Initialize                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.Initialize(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
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
{ cbSuppressClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbSuppressClick(Sender: TObject);
begin
  if Cfa <> nil then
    Cfa.Suppress := cbSuppress.Checked;
  if Cfb <> nil then
    Cfb.Suppress := cbSuppress.Checked;
  if Cff <> nil then
    Cff.Suppress := cbSuppress.Checked;
end;
{------------------------------------------------------------------------------}
{ cbAlignmentChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbAlignmentChange(Sender: TObject);
begin
  if Cfb <> nil then
    Cfb.Alignment := TCrHorizontalAlignment(cbAlignment.ItemIndex);
  if Cff <> nil then
    Cff.Alignment := TCrHorizontalAlignment(cbAlignment.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbKeepTogetherClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbKeepTogetherClick(Sender: TObject);
begin
  if Cfa <> nil then
    Cfa.KeepTogether := cbKeepTogether.Checked;
  if Cfb <> nil then
    Cfb.KeepTogether := cbKeepTogether.Checked;
  if Cff <> nil then
    Cff.KeepTogether := cbKeepTogether.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCloseBorderClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbCloseBorderClick(Sender: TObject);
begin
  if Cfa <> nil then
    Cfa.CloseBorder := cbCloseBorder.Checked;
  if Cfb <> nil then
    Cfb.CloseBorder := cbCloseBorder.Checked;
  if Cff <> nil then
    Cff.CloseBorder := cbCloseBorder.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCanGrowClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbCanGrowClick(Sender: TObject);
begin
  if Cfb <> nil then
    Cfb.CanGrow := cbCanGrow.Checked;
  if Cff <> nil then
    Cff.CanGrow := cbCanGrow.Checked;
  editMaxNLines.Enabled := cbCanGrow.Checked;
  editMaxNLines.Color := ColorState(cbCanGrow.Checked);
  lblMaxNLines.Enabled := cbCanGrow.Checked;
end;
{------------------------------------------------------------------------------}
{ editMaxNLinesChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editMaxNLinesChange(Sender: TObject);
begin
  if IsNumeric(editMaxNLines.Text) then
  begin
    if Cfb <> nil then
      Cfb.MaxNLines := StrToInt(editMaxNLines.Text);
    if Cff <> nil then
      Cff.MaxNLines := StrToInt(editMaxNLines.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ cbTextRotationChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbTextRotationChange(Sender: TObject);
begin
  if Cfb <> nil then
    Cfb.TextRotation := TCrTextRotation(cbTextRotation.ItemIndex);
  if Cff <> nil then
    Cff.TextRotation := TCrTextRotation(cbTextRotation.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbSuppressIfDuplicatedClick                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbSuppressIfDuplicatedClick(Sender: TObject);
begin
  if Cfb <> nil then
    Cfb.SuppressIfDuplicated := cbSuppressIfDuplicated.Checked;
  if Cff <> nil then
    Cff.SuppressIfDuplicated := cbSuppressIfDuplicated.Checked;
end;


{******************************************************************************}
{ Common Page                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ sbSuppressClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSuppressClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfa = nil) and (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfa <> nil then
    xList := Cfa.Formulas.Suppress
  else if Cfb <> nil then
    xList := Cfb.Formulas.Suppress
  else if Cff <> nil then
    xList := Cff.Formulas.Suppress
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'Suppress';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton Glyph}
  SetFormulaGlyph (sbSuppress, xList);
end;
{------------------------------------------------------------------------------}
{ sbAlignmentClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbAlignmentClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfb <> nil then
    xList := Cfb.Formulas.Alignment
  else if Cff <> nil then
    xList := Cff.Formulas.Alignment
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'Alignment';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton Glyph}
  SetFormulaGlyph (sbAlignment, xList);
end;
{------------------------------------------------------------------------------}
{ sbKeepTogetherClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbKeepTogetherClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfa = nil) and (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfa <> nil then
    xList := Cfa.Formulas.KeepTogether
  else if Cfb <> nil then
    xList := Cfb.Formulas.KeepTogether
  else if Cff <> nil then
    xList := Cff.Formulas.KeepTogether
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'KeepTogether';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton glyph}
  SetFormulaGlyph (sbKeepTogether, xList);
end;
{------------------------------------------------------------------------------}
{ sbCloseBorderClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCloseBorderClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfa = nil) and (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfa <> nil then
    xList := Cfa.Formulas.CloseBorder
  else if Cfb <> nil then
    xList := Cfb.Formulas.CloseBorder
  else if Cff <> nil then
    xList := Cff.Formulas.CloseBorder
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'CloseBorder';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton glyph}
  SetFormulaGlyph (sbCloseBorder, xList);
end;
{------------------------------------------------------------------------------}
{ sbCanGrowClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCanGrowClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfb <> nil then
    xList := Cfb.Formulas.CanGrow
  else if Cff <> nil then
    xList := Cff.Formulas.CanGrow
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'CanGrow';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton glyph}
  SetFormulaGlyph (sbCanGrow, xList);
end;
{------------------------------------------------------------------------------}
{ sbToolTipClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbToolTipClick(Sender: TObject);
var
  s : string;
begin
  if (Cfa = nil) and (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeToolTipEditDlg := TCrpeToolTipEditDlg.Create(Application);
  {Copy the String}
  if Cfa <> nil then s := Cfa.ToolTip;
  if Cfb <> nil then s := Cfb.ToolTip;
  if Cff <> nil then s := Cff.ToolTip;
  {Display the edit dialog}
  CrpeToolTipEditDlg.pTip := Addr(s);
  CrpeToolTipEditDlg.Caption := 'ToolTip';
  CrpeToolTipEditDlg.ShowModal;
  if Cfa <> nil then Cfa.ToolTip := s;
  if Cfb <> nil then Cfb.ToolTip := s;
  if Cff <> nil then Cff.ToolTip := s;

  if IsStrEmpty(s) then
  begin
    if sbToolTip.Glyph <> sbFormulaBlue.Glyph then
      sbToolTip.Glyph := sbFormulaBlue.Glyph;
  end
  else
  begin
    if sbToolTip.Glyph <> sbFormulaRed.Glyph then
      sbToolTip.Glyph := sbFormulaRed.Glyph;
  end;
end;
{------------------------------------------------------------------------------}
{ sbHyperLinkClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbHyperLinkClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfa = nil) and (Cfb = nil) and (Cff = nil) then
    Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfa <> nil then
    xList := Cfa.Formulas.HyperLink
  else if Cfb <> nil then
    xList := Cfb.Formulas.HyperLink
  else if Cff <> nil then
    xList := Cff.Formulas.HyperLink
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'HyperLink';
  CrpeFormulaEditDlg.ShowModal;
  {Update Speedbutton glyph}
  SetFormulaGlyph (sbHyperLink, xList);
end;
{------------------------------------------------------------------------------}
{ sbSuppressIfDuplicatedClick                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSuppressIfDuplicatedClick(Sender: TObject);
var
  xList : TStrings;
begin
  if (Cfb = nil) and (Cff = nil) then Exit;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  if Cfb <> nil then
    xList := Cfb.Formulas.SuppressIfDuplicated
  else if Cff <> nil then
    xList := Cff.Formulas.SuppressIfDuplicated
  else
    Exit;
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := 'SuppressIfDuplicated';
  CrpeFormulaEditDlg.ShowModal;
  UpdateFormat;
  {Update Speedbutton glyph}
  SetFormulaGlyph (sbSuppressIfDuplicated, xList);
end;


{******************************************************************************}
{ Number Page                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbUseSystemDefaultFormattingClick                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseSystemDefaultFormattingClick(
  Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.UseSystemDefaultFormatting := cbUseSystemDefaultFormatting.Checked;
end;
{------------------------------------------------------------------------------}
{ cbUseAccountingFormatClick                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseAccountingFormatClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.UseAccountingFormat := cbUseAccountingFormat.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSuppressIfZeroClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbSuppressIfZeroClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.SuppressIfZero := cbSuppressIfZero.Checked;
end;
{------------------------------------------------------------------------------}
{ sbSuppressIfZeroClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSuppressIfZeroClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnSuppressIfZero;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'SuppressIfZero';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbSuppressIfZero, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ editDecimalPlacesChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editDecimalPlacesChange(Sender: TObject);
begin
  if Cff <> nil then
  begin
    if IsNumeric(editDecimalPlaces.Text) then
      Cff.Field.Number.DecimalPlaces := StrToInt(editDecimalPlaces.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ sbDecimalPlacesClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDecimalPlacesClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDecimalPlaces;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DecimalPlaces';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDecimalPlaces, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbRoundingFormatChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbRoundingFormatChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.RoundingFormat := TCrRoundingFormat(cbRoundingFormat.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ sbRoundingFormatClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbRoundingFormatClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnRoundingFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'RoundingFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbRoundingFormat, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbNegativeFormatChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbNegativeFormatChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.NegativeFormat := TCrNegativeFormat(cbNegativeFormat.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ sbNegativeFormatClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbNegativeFormatClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnNegativeFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'NegativeFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbNegativeFormat, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbReverseSignForDisplayClick                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbReverseSignForDisplayClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.ReverseSignForDisplay := cbReverseSignForDisplay.Checked;
end;
{------------------------------------------------------------------------------}
{ sbReverseSignForDisplayClick                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbReverseSignForDisplayClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnReverseSignForDisplay;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'ReverseSignForDisplay';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbReverseSignForDisplay, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbAllowFieldClippingClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbAllowFieldClippingClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.AllowFieldClipping := cbAllowFieldClipping.Checked;
end;
{------------------------------------------------------------------------------}
{ sbAllowFieldClippingClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbAllowFieldClippingClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnAllowFieldClipping;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'AllowFieldClipping';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbAllowFieldClipping, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ editDecimalSymbolChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editDecimalSymbolChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.DecimalSymbol := editDecimalSymbol.Text;
end;
{------------------------------------------------------------------------------}
{ sbDecimalSymbolClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDecimalSymbolClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDecimalSymbol;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DecimalSymbol';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDecimalSymbol, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbUseThousandsSeparatorsClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseThousandsSeparatorsClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.UseThousandsSeparators := cbUseThousandsSeparators.Checked;
end;
{------------------------------------------------------------------------------}
{ sbUseThousandsSeparatorsClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbUseThousandsSeparatorsClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnUseThousandsSeparators;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'UseThousandsSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbUseThousandsSeparators, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ editThousandSymbolChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editThousandSymbolChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.ThousandSymbol := editThousandSymbol.Text;
end;
{------------------------------------------------------------------------------}
{ sbThousandSymbolClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbThousandSymbolClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnThousandSymbol;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'ThousandSymbol';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbThousandSymbol, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ cbUseLeadZeroClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseLeadingZeroClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.UseLeadingZero := cbUseLeadingZero.Checked;
end;
{------------------------------------------------------------------------------}
{ sbUseLeadZeroClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbUseLeadingZeroClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnUseLeadingZero;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'UseLeadingZero';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbUseLeadingZero, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ editShowZeroValueAsChange                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editShowZeroValueAsChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.ShowZeroValueAs := editShowZeroValueAs.Text;
end;


{******************************************************************************}
{ Currency Page                                                                }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbCurrencySymbolFormatChange                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbCurrencySymbolFormatChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.CurrencySymbolFormat := TCrCurrencySymbolFormat(cbCurrencySymbolFormat.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbOneCurrencySymbolPerPageClick                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbOneCurrencySymbolPerPageClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.OneCurrencySymbolPerPage := cbOneCurrencySymbolPerPage.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCurrencySymbolPlacementChange                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbCurrencySymbolPositionChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.CurrencySymbolPosition := TCrCurrencySymbolPosition(cbCurrencySymbolPosition.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editCurrencySymbolChange                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editCurrencySymbolChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Number.CurrencySymbol := editCurrencySymbol.Text;
end;
{------------------------------------------------------------------------------}
{ sbCurrencySymbolFormatClick                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCurrencySymbolFormatClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnCurrencySymbolFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'CurrencySymbolFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbCurrencySymbolFormat, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbOneCurrencySymbolPerPageClick                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbOneCurrencySymbolPerPageClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnOneCurrencySymbolPerPage;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'OneCurrencySymbolPerPage';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbOneCurrencySymbolPerPage, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbCurrencySymbolPlacementClick                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCurrencySymbolPositionClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnCurrencySymbolPosition;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'CurrencySymbolPosition';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbCurrencySymbolPosition, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbCurrencySymbolClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCurrencySymbolClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnCurrencySymbol;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'CurrencySymbol';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbCurrencySymbol, Cff.Field.Formulas.Formula);
end;


{******************************************************************************}
{ Date Page                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbDateTypeChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbDateTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DateType := TCrDateType(cbDateType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbUseSystemDefaultForDateClick                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseSystemDefaultForDateClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.UseSystemDefaultFormatting := cbUseSystemDefaultForDate.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCalendarTypeChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbCalendarTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.CalendarType := TCrCalendarType(cbCalendarType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbMonthChange                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbMonthChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.MonthFormat := TCrMonthFormat(cbMonth.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbDayChange                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbDayChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DayFormat := TCrDayFormat(cbDay.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbYearChange                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbYearChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.YearFormat := TCrYearFormat(cbYear.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbDateEraChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbDateEraChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DateEra := TCrDateEra(cbDateEra.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbDateOrderChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbDateOrderChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DateOrder := TCrDateOrder(cbDateOrder.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbTypeChange                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DateType := TCrDateType(cbType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editSeparatorChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editSeparatorChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DayOfWeekSeparator := editSeparator.Text;
end;
{------------------------------------------------------------------------------}
{ cbEnclosureChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbEnclosureChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DayOfWeekEnclosure := TCrDayOfWeekEnclosure(cbEnclosure.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbPositionChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbPositionChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.DayOfWeekPosition := TCrDayOfWeekPosition(cbPosition.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editPrefixChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editPrefixChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.PrefixSeparator := editPrefix.Text;
end;
{------------------------------------------------------------------------------}
{ editFirstChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editFirstChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.FirstSeparator := editFirst.Text;
end;
{------------------------------------------------------------------------------}
{ editSecondChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editSecondChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.SecondSeparator := editSecond.Text;
end;
{------------------------------------------------------------------------------}
{ editSuffixChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editSuffixChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Date.SuffixSeparator := editSuffix.Text;
end;
{------------------------------------------------------------------------------}
{ sbDateTypeClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDateTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDateType ;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DateType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDateType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbCalendarTypeClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbCalendarTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnCalendarType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'CalendarType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbCalendarType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbMonthClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbMonthClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnMonthFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'MonthFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbMonth, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbDayClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDayClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDayFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DayFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDay, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbYearClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbYearClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnYearFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'YearFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbYear, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbDateEraClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDateEraClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDateEraFormat;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DateEraFormat';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDateEra, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbDateOrderClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDateOrderClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDateOrder;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DateOrder';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDateOrder, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbTypeClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDayOfWeekType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DayOfWeekType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbSeparatorClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSeparatorClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDayOfWeekSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DayOfWeekSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbSeparator, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbEnclosureClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbEnclosureClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDayOfWeekEnclosure;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DayOfWeekEnclosure';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbEnclosure, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbPositionClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbPositionClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDayOfWeekPosition;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DayOfWeekPosition';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbPosition, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbPrefixClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbPrefixClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnPrefixSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'PrefixSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbPrefix, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbFirstClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbFirstClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnFirstDateSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'FirstDateSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbFirst, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbSecondClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSecondClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnSecondDateSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'SecondDateSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbSecond, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbSuffixClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSuffixClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnSuffixSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'SuffixSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbSuffix, Cff.Field.Formulas.Formula);
end;


{******************************************************************************}
{ DateTime Page                                                                }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbOrderChange                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbOrderChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.DateTime.Order := TCrDateTimeOrder(cbOrder.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editDateTimeSeparatorChange                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editDateTimeSeparatorChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.DateTime.Separator := editSecond.Text;
end;
{------------------------------------------------------------------------------}
{ sbOrderClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbOrderClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDateTimeOrder;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DateTimeOrder';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbOrder, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbDateTimeSeparatorClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbDateTimeSeparatorClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnDateTimeSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'DateTimeSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbDateTimeSeparator, Cff.Field.Formulas.Formula);
end;


{******************************************************************************}
{ Time Page                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbUseSystemDefaultForTimeClick                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbUseSystemDefaultForTimeClick(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.UseSystemDefaultFormatting := cbUseSystemDefaultFormatting.Checked;
end;
{------------------------------------------------------------------------------}
{ cbTimeBaseChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbTimeBaseChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.TimeBase := TCrTimeBase(cbTimeBase.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editAMStringChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editAMStringChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.AMString := editAMString.Text;
end;
{------------------------------------------------------------------------------}
{ editPMStringChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editPMStringChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.PMString := editPMString.Text;
end;
{------------------------------------------------------------------------------}
{ cbAmPmPositionChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbAmPmPositionChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.AmPmPosition := TCrAmPmPosition(cbAmPmPosition.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbHourTypeChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbHourTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.HourType := TCrTimeFormat(cbHourType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbMinuteTypeChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbMinuteTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.MinuteType := TCrTimeFormat(cbMinuteType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbSecondTypeChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbSecondTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.SecondType := TCrTimeFormat(cbSecondType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editHourMinSeparatorChange                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editHourMinSeparatorChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.HourMinSeparator := editHourMinSeparator.Text;
end;
{------------------------------------------------------------------------------}
{ editMinSecSeparatorChange                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editMinSecSeparatorChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Time.MinSecSeparator := editMinSecSeparator.Text;
end;
{------------------------------------------------------------------------------}
{ sbTimeBaseClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbTimeBaseClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnTimeBase;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'TimeBase';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbTimeBase, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbAMStringClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbAMStringClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnAMString;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'AMString';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbAMString, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbPMStringClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbPMStringClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnPMString;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'PMString';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbPMString, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbAmPmPositionClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbAmPmPositionClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnAmPmPosition;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'AmPmPosition';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbAmPmPosition, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbHourTypeClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbHourTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnHourType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'HourType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbHourType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbMinuteTypeClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbMinuteTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnMinuteType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'MinuteType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbMinuteType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbSecondTypeClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbSecondTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnSecondType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'SecondType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbSecondType, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbHourMinSeparatorClick                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbHourMinSeparatorClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnHourMinSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'HourMinSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbHourMinSeparator, Cff.Field.Formulas.Formula);
end;
{------------------------------------------------------------------------------}
{ sbMinSecSeparatorClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbMinSecSeparatorClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnMinSecSeparator;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'MinSecSeparator';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbMinSecSeparator, Cff.Field.Formulas.Formula);
end;


{******************************************************************************}
{ Paragraph Page                                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.rgUnitsClick(Sender: TObject);
begin
  if (Cfb = nil) and (Cff = nil) then Exit;
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    if Cfb <> nil then
    begin
      editIndentFirstLine.Text := TwipsToInchesStr(Cfb.Paragraph.IndentFirstLine);
      editIndentLeft.Text := TwipsToInchesStr(Cfb.Paragraph.IndentLeft);
      editIndentRight.Text := TwipsToInchesStr(Cfb.Paragraph.IndentRight);
    end;
    if Cff <> nil then
    begin
      editIndentFirstLine.Text := TwipsToInchesStr(Cff.Field.Paragraph.IndentFirstLine);
      editIndentLeft.Text := TwipsToInchesStr(Cff.Field.Paragraph.IndentLeft);
      editIndentRight.Text := TwipsToInchesStr(Cff.Field.Paragraph.IndentRight);
    end;
  end
  else  {twips}
  begin
    if Cfb <> nil then
    begin
      editIndentFirstLine.Text := IntToStr(Cfb.Paragraph.IndentFirstLine);
      editIndentLeft.Text := IntToStr(Cfb.Paragraph.IndentLeft);
      editIndentRight.Text := IntToStr(Cfb.Paragraph.IndentRight);
    end;
    if Cff <> nil then
    begin
      editIndentFirstLine.Text := IntToStr(Cff.Field.Paragraph.IndentFirstLine);
      editIndentLeft.Text := IntToStr(Cff.Field.Paragraph.IndentLeft);
      editIndentRight.Text := IntToStr(Cff.Field.Paragraph.IndentRight);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ editIndentEnter                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editIndentEnter(Sender: TObject);
begin
  prevStr := editIndentFirstLine.Text;
end;
{------------------------------------------------------------------------------}
{ editIndentExit                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editIndentExit(Sender: TObject);
begin
  if (Cfb = nil) and (Cff = nil) then Exit;
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevStr
    else
    begin
      if Cfb <> nil then
      begin
        if IsStrEmpty(TCrpe(Cfb.Cx).ReportName) then Exit;
        if TEdit(Sender).Name = 'editIndentFirstLine' then
          Cfb.Paragraph.IndentFirstLine := InchesStrToTwips(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentLeft' then
          Cfb.Paragraph.IndentLeft := InchesStrToTwips(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentRight' then
          Cfb.Paragraph.IndentRight := InchesStrToTwips(TEdit(Sender).Text);
      end;
      if Cff <> nil then
      begin
        if IsStrEmpty(TCrpe(Cff.Cx).ReportName) then Exit;
        if TEdit(Sender).Name = 'editIndentFirstLine' then
          Cff.Field.Paragraph.IndentFirstLine := InchesStrToTwips(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentLeft' then
          Cff.Field.Paragraph.IndentLeft := InchesStrToTwips(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentRight' then
          Cff.Field.Paragraph.IndentRight := InchesStrToTwips(TEdit(Sender).Text);
      end;
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevStr
    else
    begin
      if Cfb <> nil then
      begin
        if TEdit(Sender).Name = 'editIndentFirstLine' then
          Cfb.Paragraph.IndentFirstLine := StrToInt(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentLeft' then
          Cfb.Paragraph.IndentLeft := StrToInt(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentRight' then
          Cfb.Paragraph.IndentRight := StrToInt(TEdit(Sender).Text);
      end;
      if Cff <> nil then
      begin
        if TEdit(Sender).Name = 'editIndentFirstLine' then
          Cff.Field.Paragraph.IndentFirstLine := StrToInt(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentLeft' then
          Cff.Field.Paragraph.IndentLeft := StrToInt(TEdit(Sender).Text);
        if TEdit(Sender).Name = 'editIndentRight' then
          Cff.Field.Paragraph.IndentRight := StrToInt(TEdit(Sender).Text);
      end;
    end;
  end;
  UpdateFormat; {this will truncate any decimals beyond 3 places}
end;
{------------------------------------------------------------------------------}
{ cbLineSpacingTypeChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbLineSpacingTypeChange(Sender: TObject);
begin
  if (Cfb = nil) and (Cff = nil) then
    Exit;
  if Cfb <> nil then
    Cfb.Paragraph.LineSpacingType := TCrLineSpacingType(cbLineSpacingType.ItemIndex);
  if Cff <> nil then
    Cff.Field.Paragraph.LineSpacingType := TCrLineSpacingType(cbLineSpacingType.ItemIndex);
  UpdateFormat;
end;
{------------------------------------------------------------------------------}
{ editLineSpacingEnter                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editLineSpacingEnter(Sender: TObject);
begin
  prevStr := editLineSpacing.Text;
end;
{------------------------------------------------------------------------------}
{ editLineSpacingExit                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editLineSpacingExit(Sender: TObject);
begin
  if (Cfb = nil) and (Cff = nil) then
    Exit;
  if Cfb <> nil then
  begin
    if IsStrEmpty(TCrpe(Cfb.Cx).ReportName) then Exit;
    if Cfb.Paragraph.LineSpacingType = lsExact then
    begin
      if isFloating(editLineSpacing.Text) then
        Cfb.Paragraph.LineSpacing := CrStrToFloating(editLineSpacing.Text)
      else
        editLineSpacing.Text := prevStr;
    end
    else
    begin
      if isNumeric(editLineSpacing.Text) then
        Cfb.Paragraph.LineSpacing := StrToInt(editLineSpacing.Text)
      else
        editLineSpacing.Text := prevStr;
    end;
  end;
  if Cff <> nil then
  begin
    if IsStrEmpty(TCrpe(Cff.Cx).ReportName) then Exit;
    if Cff.Field.Paragraph.LineSpacingType = lsExact then
    begin
      if isFloating(editLineSpacing.Text) then
        Cff.Field.Paragraph.LineSpacing := CrStrToFloating(editLineSpacing.Text)
      else
        editLineSpacing.Text := prevStr;
    end
    else
    begin
      if isNumeric(editLineSpacing.Text) then
        Cff.Field.Paragraph.LineSpacing := StrToInt(editLineSpacing.Text)
      else
        editLineSpacing.Text := prevStr;
    end;
  end;
  UpdateFormat;
end;
{------------------------------------------------------------------------------}
{ editCharacterSpacingEnter                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editCharacterSpacingEnter(Sender: TObject);
begin
  prevStr := editCharacterSpacing.Text;
end;
{------------------------------------------------------------------------------}
{ editCharacterSpacingExit                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.editCharacterSpacingExit(Sender: TObject);
begin
  if (Cfb = nil) and (Cff = nil) then
    Exit;
  if Cfb <> nil then
  begin
    if IsStrEmpty(TCrpe(Cfb.Cx).ReportName) then Exit;
    if isFloating(editCharacterSpacing.Text) then
      Cfb.Paragraph.CharacterSpacing := CrStrToFloating(editCharacterSpacing.Text)
    else
      editCharacterSpacing.Text := prevStr;
  end;
  if Cff <> nil then
  begin
    if IsStrEmpty(TCrpe(Cff.Cx).ReportName) then Exit;
    if isFloating(editCharacterSpacing.Text) then
      Cff.Field.Paragraph.CharacterSpacing := CrStrToFloating(editCharacterSpacing.Text)
    else
      editCharacterSpacing.Text := prevStr;
  end;
  UpdateFormat;
end;
{------------------------------------------------------------------------------}
{ cbTextInterpretationChange                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbTextInterpretationChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.Paragraph.TextInterpretation := TCrTextInterpretation(cbTextInterpretation.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ sbTextInterpretationClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbTextInterpretationClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  if IsStrEmpty(TCrpe(Cff.Cx).ReportName) then Exit;
  Cff.Field.Formulas.Name := ffnTextInterpretation;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'TextInterpretation';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbTextInterpretation, Cff.Field.Formulas.Formula);
end;


{******************************************************************************}
{ Boolean Page                                                                 }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ cbBooleanFormatChange                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.cbBooleanTypeChange(Sender: TObject);
begin
  if Cff <> nil then
    Cff.Field.BooleanType := TCrBooleanType(cbBooleanType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ sbBooleanFormatClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.sbBooleanTypeClick(Sender: TObject);
begin
  if (Cff = nil) then Exit;
  Cff.Field.Formulas.Name := ffnBooleanType;
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := Cff.Field.Formulas.Formula;
  CrpeFormulaEditDlg.Caption := 'BooleanType';
  CrpeFormulaEditDlg.ShowModal;
  SetFormulaGlyph (sbBooleanType, Cff.Field.Formulas.Formula);
end;

{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.btnClearClick(Sender: TObject);
begin
  if Cfa <> nil then
    Cfa.Clear;
  if Cfb <> nil then
    Cfb.Clear;
  if Cff <> nil then
    Cff.Clear;
  UpdateFormat;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.btnOkClick(Sender: TObject);
begin
  bClose := True;
  editIndentExit(Self);
  editLineSpacingExit(Self);
  editCharacterSpacingExit(Self);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bFormat := False;
  Release;
end;


end.
