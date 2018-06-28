(*
-----------------------------------------------------------
  Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/SampleApp/UnitMain.pas $
 Version:            $Revision: #5 $
 Last Modified Date: $Date: 2004/01/27 $

 Copyright (c) 1995-2003 Crystal Decisions, Inc.
 895 Emerson St., Palo Alto, California, USA 94301.

 All rights reserved.

 This file contains confidential, proprietary information, trade secrets and copyrighted expressions
 that are the property of Crystal Decisions, Inc., 895 Emerson St., Palo Alto, California, USA 94301.

 Any disclosure, reproduction, sale or license of all or any part of the information or expression
 contained in this file is prohibited by California law and the United States copyright law, and may
 be subject to criminal penalties.

 If you are not an employee of Crystal Decisions or otherwise authorized in writing by Crystal Decisions
 to possess this file, please contact Crystal Decisions immediately at the address listed above.
-----------------------------------------------------------

Crystal VCL Sample Application
Main Unit
*)
unit UnitMain;

{$I UCRPEDEF.INC}

interface

uses
  Windows, Forms, Classes, ExtCtrls, Menus, Buttons, Dialogs,
  Messages, Printers, StdCtrls, Graphics, Controls, ComCtrls,
  UCrpe32, UCrpeClasses;

type
  TfrmMain = class(TForm)
    pnlBBar: TPanel;
    {SpeedButton}
    sbOpen: TSpeedButton;
    sbClose: TSpeedButton;
    sbSave: TSpeedButton;
    sbQuickPreview: TSpeedButton;
    sbPreview: TSpeedButton;
    sbPrint: TSpeedButton;
    sbExport: TSpeedButton;
    {Menu}
    MainMenu1: TMainMenu;
    menuFile: TMenuItem;
    miOpen: TMenuItem;
    miReopen: TMenuItem;
    miClose: TMenuItem;
    miSaveAs: TMenuItem;
    miPreview: TMenuItem;
    miPrint: TMenuItem;
    miWindow: TMenuItem;
    miPrinter: TMenuItem;
    miExport: TMenuItem;
    miPrinterSetup: TMenuItem;
    miPageMargins: TMenuItem;
    LineF1: TMenuItem;
    LineF2: TMenuItem;
    miLogOnServer: TMenuItem;
    miSummaryInfo: TMenuItem;
    miVersion: TMenuItem;
    miReportOptions: TMenuItem;
    LineF4: TMenuItem;
    miExit: TMenuItem;
    menuEdit: TMenuItem;
    miFormulaFields: TMenuItem;
    miParameterFields: TMenuItem;
    miSpecialFields: TMenuItem;
    LineE2: TMenuItem;
    miSectionFormat: TMenuItem;
    miAreaFormat: TMenuItem;
    miSectionFont: TMenuItem;
    miSectionSize: TMenuItem;
    miDetailCopies: TMenuItem;
    LineE5: TMenuItem;
    miGraphs: TMenuItem;
    menuView: TMenuItem;
    miToolbar: TMenuItem;
    miStatusBar: TMenuItem;
    menuDatabase: TMenuItem;
    miTables: TMenuItem;
    LineD1: TMenuItem;
    miLogOnServer2: TMenuItem;
    miLogOnInfo: TMenuItem;
    miConnect: TMenuItem;
    LineD4: TMenuItem;
    miSQLQuery: TMenuItem;
    miParams: TMenuItem;
    LineD2: TMenuItem;
    miVerifyDatabase: TMenuItem;
    miVerifyOnEveryPrint: TMenuItem;
    miSQLExpressions: TMenuItem;
    miSessionInfo: TMenuItem;
    menuReport: TMenuItem;
    miEditSelectionFormula: TMenuItem;
    miSelection: TMenuItem;
    miGroupSelection: TMenuItem;
    LineR1: TMenuItem;
    miGroupSortFields: TMenuItem;
    miSortFields: TMenuItem;
    LineR2: TMenuItem;
    miPrintDate2: TMenuItem;
    menuHelp: TMenuItem;
    miAboutVCL: TMenuItem;
    miAbout: TMenuItem;
    {StatusBar}
    StatusBar: TStatusBar;
    {Dialog}
    OpenDialog1: TOpenDialog;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    SaveDialog1: TSaveDialog;
    PrintDialog1: TPrintDialog;
    miCloseEngine: TMenuItem;
    pnlScrollBox: TPanel;
    ScrollBox1: TScrollBox;
    btnLogOnServer: TBitBtn;
    btnConnect: TBitBtn;
    btnLogOnInfo: TBitBtn;
    btnSessionInfo: TBitBtn;
    btnSQLQuery: TBitBtn;
    btnTables: TBitBtn;
    btnSelection: TBitBtn;
    btnGroupSelection: TBitBtn;
    btnParamFields: TBitBtn;
    btnPrintDate: TBitBtn;
    btnMargins: TBitBtn;
    miDiscardSavedData: TMenuItem;
    pnlSub: TPanel;
    pnlReports: TPanel;
    imgReport: TImage;
    lblOutput: TLabel;
    lblSection: TLabel;
    lblNLinks: TLabel;
    lbSubNames: TListBox;
    rbMain: TRadioButton;
    rbSub: TRadioButton;
    cbSubExecute: TCheckBox;
    cbOutput: TComboBox;
    cbLoadEngineOnUse: TCheckBox;
    editNLinks: TEdit;
    editSection: TEdit;
    pnlLeftTop: TPanel;
    pnlLeftRight: TPanel;
    pnlLeftBottom: TPanel;
    btnFormulas: TBitBtn;
    btnSectionFormat: TBitBtn;
    btnAreaFormat: TBitBtn;
    btnSortFields: TBitBtn;
    btnGroupSortFields: TBitBtn;
    btnSQLExpressions: TBitBtn;
    btnSectionFont: TBitBtn;
    btnSectionSize: TBitBtn;
    btnReportOptions: TBitBtn;
    btnPages: TBitBtn;
    btnVersion: TBitBtn;
    btnSummaryInfo: TBitBtn;
    btnGraphType: TBitBtn;
    btnDiscardSavedData: TButton;
    btnLines: TBitBtn;
    btnBoxes: TBitBtn;
    btnCrossTabs: TBitBtn;
    btnDatabaseFields: TBitBtn;
    btnGroupNameFields: TBitBtn;
    btnMaps: TBitBtn;
    btnOleObjects: TBitBtn;
    btnPictures: TBitBtn;
    btnRunningTotals: TBitBtn;
    btnSpecialFields: TBitBtn;
    btnSummaryFields: TBitBtn;
    btnSubreports: TBitBtn;
    btnTextObjects: TBitBtn;
    miSummaryFields: TMenuItem;
    miRunningTotals: TMenuItem;
    miMaps: TMenuItem;
    miDatabaseFields: TMenuItem;
    miTextObjects: TMenuItem;
    LineE1: TMenuItem;
    LineE3: TMenuItem;
    miGroupNameFields: TMenuItem;
    LineE4: TMenuItem;
    miCrossTabs: TMenuItem;
    miSubreports: TMenuItem;
    miGroups: TMenuItem;
    miSections: TMenuItem;
    miLines: TMenuItem;
    miBoxes: TMenuItem;
    miPictures: TMenuItem;
    miOleObjects: TMenuItem;
    ConvertDatabaseDriver1: TMenuItem;
    LineD3: TMenuItem;
    miNew: TMenuItem;
    miSave: TMenuItem;
    miReportTitle: TMenuItem;
    btnGroups: TBitBtn;
    btnOLAPCubes: TBitBtn;
    miOLAPCubes: TMenuItem;
    BitBtn1: TBitBtn;
    LineR3: TMenuItem;
    miPages: TMenuItem;
    LineH1: TMenuItem;
    miCloseAndSend: TMenuItem;
    miVCLHelp: TMenuItem;
    LineH2: TMenuItem;
    miVCLTechnicalSupport: TMenuItem;
    cbIgnoreKnownProblems: TCheckBox;
    Bevel1: TBevel;
    miDetailCopies2: TMenuItem;
    miReportStyle: TMenuItem;
    LineR4: TMenuItem;
    miCrpePath: TMenuItem;
    btnRecords: TBitBtn;
    sbCancel: TSpeedButton;
    sbHelp: TSpeedButton;
    sbModifyReport: TSpeedButton;
    sbFieldBrowser: TSpeedButton;
    Crpe1: TCrpe;
    ProgressDialog1: TMenuItem;
    LineF3: TMenuItem;
    miGlobalOptions: TMenuItem;

    {MainForm}
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateReopenList;
    procedure ReadIni(Section: string);
    procedure WriteIni(Section: string);
    procedure miToolbarClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    {Open}
    procedure miOpenClick(Sender: TObject);
    procedure ReopenMenuClick(Sender: TObject);
    procedure LoadReport;
    procedure InitializeControls(OnOff: boolean);
    {Close}
    procedure miCloseClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    {Save}
    procedure miSaveClick(Sender: TObject);
    {Preview}
    procedure cbSubExecuteClick(Sender: TObject);
    procedure cbOutputChange(Sender: TObject);
    {SubList}
    procedure rbMainClick(Sender: TObject);
    procedure rbSubClick(Sender: TObject);
    procedure lbSubNamesClick(Sender: TObject);
    {LogOnServer}
    procedure miLogOnServer2Click(Sender: TObject);
    {About}
    procedure miAboutVCLClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure ShowAboutBox;
    {Errors}
    procedure Crpe1Error(Sender: TObject; const ErrorNum: Smallint;
      const ErrorString: String; var IgnoreError: TCrErrorResult);

    procedure miFormulaFieldsClick(Sender: TObject);
    procedure miParameterFieldsClick(Sender: TObject);
    procedure miTablesClick(Sender: TObject);
    procedure miLogOnInfoClick(Sender: TObject);
    procedure miConnectClick(Sender: TObject);
    procedure miSQLQueryClick(Sender: TObject);
    procedure miSelectionClick(Sender: TObject);
    procedure miGroupSelectionClick(Sender: TObject);

    procedure miSectionFormatClick(Sender: TObject);
    procedure miAreaFormatClick(Sender: TObject);
    procedure miSectionFontClick(Sender: TObject);
    procedure miSectionSizeClick(Sender: TObject);
    procedure miSortFieldsClick(Sender: TObject);
    procedure miGroupSortFieldsClick(Sender: TObject);
    procedure miGroupsClick(Sender: TObject);
    procedure miSummaryInfoClick(Sender: TObject);
    procedure miPrintDateClick(Sender: TObject);
    procedure miReportTitleClick(Sender: TObject);
    procedure miPageMarginsClick(Sender: TObject);
    procedure miVersionClick(Sender: TObject);
    procedure miPrinterSetupClick(Sender: TObject);
    procedure DoUpdates;
    procedure RemoveObsoleteClick(Sender: TObject);
    procedure RemoveAllClick(Sender: TObject);

    procedure Crpe1wOnDrillDetail(WindowHandle: HWnd; NSelectedField,
      NFields: Smallint; FieldNames, FieldValues: TStringList;
      var Cancel: Boolean);
    procedure Crpe1wOnShowGroup(WindowHandle: HWnd; NGroupLevel: Word;
      GroupList: TStringList; var Cancel: Boolean);
    procedure Crpe1wOnDrillGroup(WindowHandle: HWnd; NGroupLevel: Word;
      DrillType: TCrDrillDownType; GroupList: TStringList;
      var Cancel: Boolean);
    procedure Crpe1wOnActivateWindow(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnCancelBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnCloseBtnClick(WindowHandle: HWnd;
      ViewIndex: Word; var Cancel: Boolean);
    procedure Crpe1wOnCloseWindow(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnDeActivateWindow(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnExportBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnFirstPageBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnGroupTreeBtnClick(WindowHandle: HWnd;
      Visible: Boolean; var Cancel: Boolean);
    procedure Crpe1wOnLastPageBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnNextPageBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnPreviousPageBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnPrintBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnPrintSetupBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnRefreshBtnClick(WindowHandle: HWnd;
      var Cancel: Boolean);
    procedure Crpe1wOnSearchBtnClick(WindowHandle: HWnd;
      SearchString: String; var Cancel: Boolean);
    procedure Crpe1wOnZoomLevelChange(WindowHandle: HWnd;
      ZoomLevel: Word; var Cancel: Boolean);
    procedure Crpe1wOnMouseClick(WindowHandle: Hwnd;
      MouseInfo: TCrMouseInfo; FieldValue: String; FieldType: TCrParamFieldType;
      Section: String; ObjectHandle: HWnd; var Cancel: Boolean);
    procedure Crpe1wOnDrillHyperLink(WindowHandle: HWND;
      HyperLinkText: String; var Cancel: Boolean);
    procedure Crpe1wOnLaunchSeagateAnalysis(WindowHandle: HWND;
      FilePath: String; var Cancel: Boolean);
    procedure Crpe1wOnReadingRecords(Cancelled: Boolean; RecordsRead,
      RecordsSelected: LongInt; Done: Boolean; var Cancel: Boolean);
    procedure Crpe1wOnStartEvent(Destination: TCrStartEventDestination;
      var Cancel: Boolean);
    procedure Crpe1wOnStopEvent(Destination: TCrStartEventDestination;
      JobStatus: TCrStopEventJobStatus; var Cancel: Boolean);
    procedure miReportOptionsClick(Sender: TObject);
    procedure cbLoadEngineOnUseClick(Sender: TObject);
    procedure miVerifyDatabaseClick(Sender: TObject);
    procedure miVerifyOnEveryPrintClick(Sender: TObject);
    procedure miSQLExpressionsClick(Sender: TObject);

    procedure Crpe1OnFieldMapping(var ReportFields, DatabaseFields: TList;
      var Cancel: Boolean);
    procedure miSessionInfoClick(Sender: TObject);
    procedure miCloseEngineClick(Sender: TObject);
    procedure miDiscardSavedDataClick(Sender: TObject);
    procedure btnDiscardSavedDataClick(Sender: TObject);
    procedure miSpecialFieldsClick(Sender: TObject);
    procedure miSummaryFieldsClick(Sender: TObject);
    procedure miRunningTotalsClick(Sender: TObject);
    procedure miNewClick(Sender: TObject);
    procedure miDatabaseFieldsClick(Sender: TObject);
    procedure miTextObjectsClick(Sender: TObject);
    procedure miGroupNameFieldsClick(Sender: TObject);
    procedure miOLAPCubesClick(Sender: TObject);
    procedure miCrossTabsClick(Sender: TObject);
    procedure miSubreportsClick(Sender: TObject);
    procedure miLinesClick(Sender: TObject);
    procedure miBoxesClick(Sender: TObject);
    procedure miPicturesClick(Sender: TObject);
    procedure miMapsClick(Sender: TObject);
    procedure miOleObjectsClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miPreviewClick(Sender: TObject);
    procedure miWindowClick(Sender: TObject);
    procedure miPrinterClick(Sender: TObject);
    procedure miExportClick(Sender: TObject);
    procedure miGraphsClick(Sender: TObject);
    procedure miCloseAndSendClick(Sender: TObject);
    procedure miVCLHelpClick(Sender: TObject);
    procedure miVCLTechnicalSupportClick(Sender: TObject);
    procedure cbIgnoreKnownProblemsClick(Sender: TObject);
    procedure miPagesClick(Sender: TObject);
    procedure btnRecordsClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure lbSubNamesDblClick(Sender: TObject);
    procedure sbFieldBrowserClick(Sender: TObject);
    procedure ProgressDialog1Click(Sender: TObject);
    procedure menuViewClick(Sender: TObject);
    procedure miGlobalOptionsClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMDROPFILES(var Message: TWMDROPFILES);
      message WM_DROPFILES;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
      message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

const
  {Maximum # of files listed in Reopen Submenu}
  MaxReopenFiles = 9;
  {Month array for PrintDate calendar}
  MonthArray: array[1..12] of string = ('January','February',
    'March','April','May','June','July','August','September',
    'October','November','December');

var
  frmMain      : TfrmMain;
  RptLoaded    : boolean;     {Report is Loaded}
  Report       : string;      {Report Name}
  ExeName      : string;      {EXE Name}
  AppDir       : string;      {Application directory}
  OpenDir      : string;      {Report Open directory}
  SaveDir      : string;      {Report Save directory}
  ExportPath   : string;      {Export Path}
  PrevFiles    : TStringList; {Previous Files stringlist}
  RptMenu      : TMenuItem;   {Previous Files submenu}
  SubNameIndex : smallint;    {Keeps track of selected item in Sub list}
  Present      : TDateTime;   {Date variables for PrintDate screen}
  Year,
  Month,
  Day          : Word;
  prevYear,
  prevMonth,
  prevDay      : string;
  prevDCopies  : string;
  strMain      : string;
  strSub       : string; {Store Checkbox state in Retrieve Options form}
  MX,MY        : integer;


implementation

{$R *.DFM}


uses
  ShellApi, TypInfo, SysUtils, Registry, UCrpeUtl,
  {Dialogs specific to Sample App}
  USError1, USError2, USAbout, USPreview, USWinEvents,
  {Dialogs shared between Sample App and VCL}
  UDAbout, UDAreaFormat, UDBoxes, UDConnect, UDCrossTabs,
  UDDatabaseFields, UDExportOptions, UDFieldMapping, UDFieldSelect,
  UDFormulas, UDGlobalOptions, UDGraphs, UDGroupNameFields, UDGroups,
  UDGroupSelection, UDGroupSortFields, UDLines, UDLogOnInfo,
  UDLogOnServer, UDMaps, UDMargins, UDMiscellaneous, UDOLAPCubes,
  UDOleObjects, UDPages, UDParamFields, UDPictures, UDPrintDate,
  UDPrinter, UDPrintOptions, UDRecords, UDRunningTotals,
  UDReportOptions, UDSectionFormat, UDSectionFont,
  UDSectionSize, UDSelection, UDSessionInfo, UDSortFields,
  UDSpecialFields, UDSubreports, UDSummaryInfo, UDSummaryFields,
  UDSQLExpressions, UDSQLQuery, UDTables, UDTextObjects, UDVersion,
  UDWindowButtonBar, UDWindowCursor, UDWindowSize, UDWindowStyle,
  UDWindowZoom, UDWindowParent;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.FormCreate(Sender: TObject);
var
  s1 : string;
begin
  ExeName := Application.ExeName;
  Application.HelpFile := 'Ucrpe32.hlp';
  if not FileExists(Application.HelpFile) then
  begin
    s1 := ExtractFilePath(ExeName);
    if s1[Length(s1)] = '\' then
      s1 := Copy(s1, 1, Length(s1)-1);
    s1 := s1 + '.EXE';
    s1 := ExtractFilePath(s1);
    s1 := AddBackSlash(s1);
    Application.HelpFile := s1 + 'UCrpe32.hlp';
  end;

  {Initialize the buttons & menu items}
  InitializeControls(False);
  RptLoaded := False;
  {Set up the PreviousFiles StringList}
  PrevFiles := TStringlist.Create;
  ReadIni('Reopen');
  DragAcceptFiles(Handle, True);
  {Set Width/Height}
  Width := (3437 * PixelsPerInch) div 1000;  {330}
  Height := (4625 * PixelsPerInch) div 1000; {444}
  {Set Position}
  LoadFormPos(Self);
  {Set Events}
  Crpe1.OnError := Crpe1Error;
  Crpe1.OnFieldMapping := Crpe1OnFieldMapping;
  {Set the WindowEvents}
  if Crpe1.WindowEvents then
  begin
    Crpe1.wOnCloseWindow := Crpe1wOnCloseWindow;
    Crpe1.wOnPrintBtnClick := Crpe1wOnPrintBtnClick;
    Crpe1.wOnExportBtnClick := Crpe1wOnExportBtnClick;
    Crpe1.wOnFirstPageBtnClick := Crpe1wOnFirstPageBtnClick;
    Crpe1.wOnPreviousPageBtnClick := Crpe1wOnPreviousPageBtnClick;
    Crpe1.wOnNextPageBtnClick := Crpe1wOnNextPageBtnClick;
    Crpe1.wOnLastPageBtnClick := Crpe1wOnLastPageBtnClick;
    Crpe1.wOnCancelBtnClick := Crpe1wOnCancelBtnClick;
    Crpe1.wOnActivateWindow := Crpe1wOnActivateWindow;
    Crpe1.wOnDeActivateWindow := Crpe1wOnDeActivateWindow;
    Crpe1.wOnPrintSetupBtnClick := Crpe1wOnPrintSetupBtnClick;
    Crpe1.wOnRefreshBtnClick := Crpe1wOnRefreshBtnClick;
    Crpe1.wOnZoomLevelChange := Crpe1wOnZoomLevelChange;
    Crpe1.wOnCloseBtnClick := Crpe1wOnCloseBtnClick;
    Crpe1.wOnSearchBtnClick := Crpe1wOnSearchBtnClick;
    Crpe1.wOnGroupTreeBtnClick := Crpe1wOnGroupTreeBtnClick;
    Crpe1.wOnReadingRecords := Crpe1wOnReadingRecords;
    Crpe1.wOnStartEvent := Crpe1wOnStartEvent;
    Crpe1.wOnStopEvent := Crpe1wOnStopEvent;
    Crpe1.wOnShowGroup := Crpe1wOnShowGroup;
    Crpe1.wOnDrillGroup := Crpe1wOnDrillGroup;
    Crpe1.wOnDrillDetail := Crpe1wOnDrillDetail;
    Crpe1.wOnMouseClick := Crpe1wOnMouseClick;
    Crpe1.wOnDrillHyperLink := Crpe1wOnDrillHyperLink;
    Crpe1.wOnLaunchSeagateAnalysis := Crpe1wOnLaunchSeagateAnalysis;
  end
  else
  begin
    Crpe1.wOnCloseWindow := nil;
    Crpe1.wOnPrintBtnClick := nil;
    Crpe1.wOnExportBtnClick := nil;
    Crpe1.wOnFirstPageBtnClick := nil;
    Crpe1.wOnPreviousPageBtnClick := nil;
    Crpe1.wOnNextPageBtnClick := nil;
    Crpe1.wOnLastPageBtnClick := nil;
    Crpe1.wOnCancelBtnClick := nil;
    Crpe1.wOnActivateWindow := nil;
    Crpe1.wOnDeActivateWindow := nil;
    Crpe1.wOnPrintSetupBtnClick := nil;
    Crpe1.wOnRefreshBtnClick := nil;
    Crpe1.wOnZoomLevelChange := nil;
    Crpe1.wOnCloseBtnClick := nil;
    Crpe1.wOnSearchBtnClick := nil;
    Crpe1.wOnGroupTreeBtnClick := nil;
    Crpe1.wOnReadingRecords := nil;
    Crpe1.wOnStartEvent := nil;
    Crpe1.wOnStopEvent := nil;
    Crpe1.wOnShowGroup := nil;
    Crpe1.wOnDrillGroup := nil;
    Crpe1.wOnDrillDetail := nil;
    Crpe1.wOnMouseClick := nil;
    Crpe1.wOnDrillHyperLink := nil;
    Crpe1.wOnLaunchSeagateAnalysis := nil;
  end;
  ScrollBox1.ScrollInView(btnLogOnServer);
end;

{------------------------------------------------------------------------------}
{ WMDROPFILES procedure                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.WMDROPFILES(var Message: TWMDROPFILES);
var
  Buffer: array[0..255] of char;
begin
  {If a file was dragged on the open Form, load it}
  DragQueryFile(Message.Drop, 0, Buffer, SizeOf(Buffer));
  Report := StrPas(Buffer);
  {Update the 'Reopen' menu and PrevFile stringlist}
  UpdateReopenList;
  {Load the Report}
  LoadReport;
end;

{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.FormShow(Sender: TObject);
begin
  {Get the app directory}
  AppDir := ExtractFilePath(Application.ExeName);
  OpenDir := AppDir;
  SaveDir := AppDir;
  {Change to application directory}
  ChDir(AppDir);
  if IOResult <> 0 then
    OpenDir := 'C:\';
  pnlBBar.SetFocus;
  {LoadEngineOnUse}
  cbLoadEngineOnUse.OnClick := nil;
  cbLoadEngineOnUse.Checked := Crpe1.LoadEngineOnUse;
  cbLoadEngineOnUse.OnClick := cbLoadEngineOnUseClick;
  {IgnoreKnownProblems}
  cbIgnoreKnownProblems.OnClick := nil;
  cbIgnoreKnownProblems.Checked := Crpe1.IgnoreKnownProblems;
  cbIgnoreKnownProblems.OnClick := cbIgnoreKnownProblemsClick;
  {ProgressDialog}
  ProgressDialog1.Checked := Crpe1.ProgressDialog;
  {Engine Status}
  miCloseEngine.Enabled := Crpe1.EngineOpen;
  {Check if a Reportname was passed on the commandline}
  if (ParamStr(1) <> '') and FileExists(ParamStr(1)) then
  begin
    Report := ParamStr(1);
    {Update the 'Reopen' menu and PrevFile stringlist}
    UpdateReopenList;
    {Load the Report}
    LoadReport;
  end;
end;

{------------------------------------------------------------------------------}
{ ReadIni procedure                                                            }
{  - Loads settings from the INI file                                          }
{------------------------------------------------------------------------------}
procedure TfrmMain.ReadIni(Section: string);
var
  str1   : string;
  i      : integer;
  RegIni : TRegIniFile; {INI file for Program settings}
begin
  {Open the INI file}
  RegIni := nil;
  try
    RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL');
  except
    if RegIni <> nil then
      RegIni.Free;
    Exit;
  end;

  {Read 'Reopen' section of the INI file}
  if Section = 'Reopen' then
  begin
    {Clear the PreviousFiles StringList}
    PrevFiles.Clear;
    {Read the INI file into the StringList}
    for i := 0 to MaxReopenFiles - 1 do
    begin
      str1 := RegIni.ReadString('Reopen', IntToStr(i + 1), '');
      if str1 <> '' then
        PrevFiles.Add(str1);
    end;
    {Clear the Reopen submenu}
    for i := miReopen.Count-1 downto 0 do
      miReopen.Delete(i);
    {Read the StringList into the Reopen submenu}
    for i := 0 to PrevFiles.Count - 1 do
    begin
      RptMenu := TMenuItem.Create(miReopen);
      RptMenu.Caption := '&' + IntToStr(i + 1) + ' ' + PrevFiles[i];
      RptMenu.OnClick := ReopenMenuClick;
      miReopen.Insert(i,RptMenu);
    end;
    {Line}
    RptMenu := TMenuItem.Create(miReopen);
    RptMenu.Caption := '-';
    miReopen.Insert(miReopen.Count,RptMenu);
    {Remove Obsolete}
    RptMenu := TMenuItem.Create(miReopen);
    RptMenu.Caption := 'Remove Obsolete';
    RptMenu.OnClick := RemoveObsoleteClick;
    miReopen.Insert(miReopen.Count,RptMenu);
    {Remove All}
    RptMenu := TMenuItem.Create(miReopen);
    RptMenu.Caption := 'Remove All';
    RptMenu.OnClick := RemoveAllClick;
    miReopen.Insert(miReopen.Count,RptMenu);
  end;
  RegIni.Free;
end;

{------------------------------------------------------------------------------}
{ WriteIni procedure                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.WriteIni(Section: string);
var
  cnt1   : integer;
  RegIni : TRegIniFile; {INI file for Program settings}
begin
  {Open the INI file}
  RegIni := nil;
  try
    RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL');
  except
    if RegIni <> nil then
      RegIni.Free;
    Exit;
  end;

  {Write 'Reopen' section of the INI file}
  if Section = 'Reopen' then
  begin
    {Erase the Reopen section of the INI file}
    RegIni.EraseSection('Reopen');
    {Write the INI file from the PrevFiles stringlist}
    for cnt1 := 0 to PrevFiles.Count - 1 do
    begin
      RegIni.WriteString('Reopen', IntToStr(cnt1 + 1), PrevFiles[cnt1]);
    end;
  end;
  RegIni.Free;
end;


{------------------------------------------------------------------------------}
{ UpdateReopenList procedure                                                   }
{------------------------------------------------------------------------------}
procedure TfrmMain.UpdateReopenList;
var
  cnt1: integer;
begin
 {Update the PrevFiles stringlist...}
  {Check to see if the file exists in the list}
  cnt1 := PrevFiles.IndexOf(Report);
  {If it exists, delete it}
  if cnt1 > -1 then PrevFiles.Delete(cnt1);
  {Add the new filename to the beginning of PrevList}
  PrevFiles.Insert(0, Report);
  {If there are more than 8 items, remove from end of list}
  if PrevFiles.Count > MaxReopenFiles then
  begin
    for cnt1 := MaxReopenFiles to PrevFiles.Count - 1 do
      PrevFiles.Delete(MaxReopenFiles);
  end;
  {Update the INI file and 'Reopen' Menu...}
  WriteIni('Reopen');
  ReadIni('Reopen');
end;
{------------------------------------------------------------------------------}
{ LoadReport procedure                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.LoadReport;
var
  cnt1 : integer;
  VerX : boolean;
begin
  {Cause Form to be redrawn after Open Dialog}
  Refresh;
  {Set Cursor to busy}
  Screen.Cursor := crHourGlass;
  {Store Paths}
  OpenDir := ExtractFilePath(Report);
  SaveDir := OpenDir;
  ExportPath := OpenDir;
  try
    {If a Report was previously loaded, close it}
    if RptLoaded = True then
      miCloseClick(self);
    {Get RPT Information}
    Crpe1.ReportName := Report;
    RptLoaded := True;
    StatusBar.Hint := Report;
    {Activate the controls}
    InitializeControls(True);
    miCloseEngine.Enabled := True;
    lbSubNames.Clear;
    for cnt1 := 1 to (Crpe1.Subreports.Count - 1) do
      lbSubNames.Items.Add(Crpe1.Subreports[cnt1].Name);
    Crpe1.Subreports[0];

    {Check for SCR 8+ features}
    {Check for SCR 7+ features}
    VerX := Crpe1.Version.Crpe.Major > 6;
    miSQLExpressions.Enabled := VerX;
    btnSQLExpressions.Enabled := VerX;
    miMaps.Enabled := VerX;
    btnMaps.Enabled := VerX;
    miOLAPCubes.Enabled := VerX;
    btnOLAPCubes.Enabled := VerX;
    miOleObjects.Enabled := VerX;
    btnOleObjects.Enabled := VerX;
    miSummaryInfo.Enabled := VerX;
    btnSummaryInfo.Enabled := VerX;
    miSummaryFields.Enabled := VerX;
    btnSummaryFields.Enabled := VerX;
    miVerifyOnEveryPrint.Enabled := VerX;
    miVerifyDatabase.Enabled := VerX;

    {Update the caption with the Report name & path}
    StatusBar.Panels[0].Text := Report + ' ';
    StatusBar.Panels[1].Text := 'JobNumber: ' + IntToStr(Crpe1.JobNumber);
    {Main/Sub radio buttons}
    rbMain.Checked := True;
    rbMainClick(Self);
    rbSub.Enabled := (Crpe1.Subreports.Count > 1);
    {Various Report property checkboxes}
    cbSubExecute.Checked := Crpe1.Subreports.SubExecute;
    {Output combobox}
    cbOutput.Clear;
    cbOutput.Items.Add('toWindow');
    cbOutput.Items.Add('toPrinter');
    cbOutput.Items.Add('toExport');
    cbOutput.ItemIndex := Ord(Crpe1.Output);
    {SavedData}
    btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
  finally
    Screen.Cursor := crDefault;
    pnlBBar.SetFocus;
  end;
end;

{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioButton then
        TRadioButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TMenuItem then
        TMenuItem(Components[i]).Visible := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
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
  miLogOnServer2.Visible := not OnOff;
  SubNameIndex := 0;
  lbSubNames.Clear;
  lbSubNames.Color := ColorState(False);
  lbSubNames.Enabled := False;
  rbSub.Enabled := False;
end;

{------------------------------------------------------------------------------}
{ cbOutputChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TfrmMain.cbOutputChange(Sender: TObject);
begin
  Crpe1.Output := TCrOutput(cbOutput.ItemIndex);
  pnlBBar.SetFocus;
end;

{------------------------------------------------------------------------------}
{ sbSubExecuteClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TfrmMain.cbSubExecuteClick(Sender: TObject);
begin
  Crpe1.Subreports.SubExecute := cbSubExecute.Checked;
  if cbSubExecute.Checked and rbSub.Checked then
    sbSave.Enabled := False;
end;

{------------------------------------------------------------------------------}
{ cbLoadEngineOnUseClick procedure                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.cbLoadEngineOnUseClick(Sender: TObject);
begin
  if (cbLoadEngineOnUse.Checked <> Crpe1.LoadEngineOnUse) then
  begin
    if (Crpe1.JobNumber > 0) then
      MessageDlg('Changes will take place when the current Report is closed.',
        mtInformation, [mbOk], 0)
    else
    begin
      Crpe1.LoadEngineOnUse := cbLoadEngineOnUse.Checked;
      Crpe1.CloseEngine;
      if cbLoadEngineOnUse.Checked = False then
        Crpe1.OpenEngine;
    end;
  end;
end;

{------------------------------------------------------------------------------}
{ cbIgnoreKnownProblemsClick procedure                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.cbIgnoreKnownProblemsClick(Sender: TObject);
begin
  Crpe1.IgnoreKnownProblems := cbIgnoreKnownProblems.Checked;
  if cbIgnoreKnownProblems.Checked then
  begin
    MessageDlg('Selecting this option will cause the Crystal VCL' + Chr(10) +
      'to ignore known problems with certain' + Chr(10) +
      'Crystal Reports Print Engine calls.', mtInformation, [mbOk], 0);
  end
  else
  begin
    MessageDlg('De-selecting this option will cause the Crystal VCL' + Chr(10) +
      'to report all error messages, even those dealing with' + Chr(10) +
      'known problems in certain Crystal Reports Print Engine calls.',
      mtInformation, [mbOk], 0);
  end;
end;

{------------------------------------------------------------------------------}
{ rbMainClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.rbMainClick(Sender: TObject);
begin
  rbSub.Checked := False;
  rbMain.Checked := True;
  lbSubNames.Enabled := False;
  lbSubNames.Color := ColorState(False);
  cbSubExecute.Enabled := False;
  editSection.Text := '';
  editNLinks.Text := '';
  Crpe1.Subreports[0];
  StatusBar.Panels[1].Text := 'JobNumber: ' + IntToStr(Crpe1.JobNumber);
  DoUpdates;
end;
{------------------------------------------------------------------------------}
{ rbSubClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.rbSubClick(Sender: TObject);
begin
  rbMain.Checked := False;
  rbSub.Checked := True;
  lbSubNames.Enabled := True;
  lbSubNames.Color := ColorState(True);
  cbSubExecute.Enabled := True;
  cbSubExecute.Checked := Crpe1.Subreports.SubExecute;
  {set the List Box to the first item}
  lbSubNames.SetFocus;
  lbSubNames.ItemIndex := SubNameIndex;
  lbSubNamesClick(Self);
end;
{------------------------------------------------------------------------------}
{ lbSubNamesClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TfrmMain.lbSubNamesClick(Sender: TObject);
begin
  rbSub.Checked := True;
  SubNameIndex := lbSubNames.ItemIndex;
  Crpe1.Subreports[SubNameIndex + 1];
  StatusBar.Panels[1].Text := 'JobNumber: ' + IntToStr(Crpe1.JobNumber);
  editSection.Text := Crpe1.Subreports.Item.Section;
  editNLinks.Text := IntToStr(Crpe1.Subreports.Item.NLinks);
  DoUpdates;
end;
{------------------------------------------------------------------------------}
{ lbSubNamesDblClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.lbSubNamesDblClick(Sender: TObject);
begin
  lbSubNamesClick(Self);
  miSubreportsClick(Self);
end;
{------------------------------------------------------------------------------}
{ btnDiscardSavedDataClick procedure                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.btnDiscardSavedDataClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;
  btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
end;
{------------------------------------------------------------------------------}
{ DoUpdates procedure                                                          }
{------------------------------------------------------------------------------}
procedure TfrmMain.DoUpdates;
begin
  if bAreaFormat then
    CrpeAreaFormatDlg.FormShow(Self);
  if bConnect then
    CrpeConnectDlg.FormShow(Self);
  if bExportOptions then
    CrpeExportOptionsDlg.FormShow(Self);
  if bGroups then
    CrpeGroupsDlg.FormShow(Self);
  if bGraphs then
    CrpeGraphsDlg.FormShow(Self);
  if bGroupSelection then
    CrpeGroupSelectionDlg.FormShow(Self);
  if bGroupSortFields then
    CrpeGroupSortFieldsDlg.FormShow(Self);
  if bLogOnInfo then
    CrpeLogOnInfoDlg.FormShow(Self);
  if bLogOnServer then
    CrpeLogOnServerDlg.FormShow(Self);
  if bMargins then
    CrpeMarginsDlg.FormShow(Self);
  if bPages then
    CrpePagesDlg.FormShow(Self);
  if bRecords then
    CrpeRecordsDlg.FormShow(Self);
  if bMiscellaneous then
    CrpeMiscellaneousDlg.FormShow(Self);
  if bPrintDate then
    CrpePrintDateDlg.FormShow(Self);
  if bPrinter then
    CrpePrinterDlg.FormShow(Self);
  if bPrintOptions then
    CrpePrintOptionsDlg.FormShow(Self);
  if bSQLQuery then
    CrpeSQLQueryDlg.FormShow(Self);
  if bReportOptions then
    CrpeReportOptionsDlg.FormShow(Self);
  if bGlobalOptions then
    CrpeGlobalOptionsDlg.FormShow(Self);
  if bSectionFormat then
    CrpeSectionFormatDlg.FormShow(Self);
  if bSectionFont then
    CrpeSectionFontDlg.FormShow(Self);
  if bSectionSize then
    CrpeSectionSizeDlg.FormShow(Self);
  if bSelection then
    CrpeSelectionDlg.FormShow(Self);
  if bSessionInfo then
    CrpeSessionInfoDlg.FormShow(Self);
  if bSortFields then
    CrpeSortFieldsDlg.FormShow(Self);
  if bSummaryInfo then
    CrpeSummaryInfoDlg.FormShow(Self);
  if bTables then
    CrpeTablesDlg.FormShow(Self);
  if bVersion then
    CrpeVersionDlg.FormShow(Self);
  if bWindowButtonBar then
    CrpeWindowButtonBarDlg.FormShow(Self);
  if bWindowCursor then
    CrpeWindowCursorDlg.FormShow(Self);
  if bWindowSize then
    CrpeWindowSizeDlg.FormShow(Self);
  if bWindowStyle then
    CrpeWindowStyleDlg.FormShow(Self);
  if bWindowZoom then
    CrpeWindowZoomDlg.FormShow(Self);
  if bPreview then
    CrpePreviewDlg.FormShow(Self);
  {Field Objects}
  if bDatabaseFields then
    CrpeDatabaseFieldsDlg.FormShow(Self);
  if bFormulas then
    CrpeFormulasDlg.FormShow(Self);
  if bSummaryFields then
    CrpeSummaryFieldsDlg.FormShow(Self);
  if bSpecialFields then
    CrpeSpecialFieldsDlg.FormShow(Self);
  if bGroupNameFields then
    CrpeGroupNameFieldsDlg.FormShow(Self);
  if bParamFields then
    CrpeParamFieldsDlg.FormShow(Self);
  if bSQLExpressions then
    CrpeSQLExpressionsDlg.FormShow(Self);
  if bRunningTotals then
    CrpeRunningTotalsDlg.FormShow(Self);
  {Objects}
  if bTextObjects then
    CrpeTextObjectsDlg.FormShow(Self);
  if bLines then
    CrpeLinesDlg.FormShow(Self);
  if bBoxes then
    CrpeBoxesDlg.FormShow(Self);
  if bSubreports then
    CrpeSubreportsDlg.FormShow(Self);
  if bOleObjects then
    CrpeOleObjectsDlg.FormShow(Self);
     {graphs...}
  if bCrossTabs then
    CrpeCrossTabsDlg.FormShow(Self);
  if bPictures then
    CrpePicturesDlg.FormShow(Self);
  if bMaps then
    CrpeMapsDlg.FormShow(Self);
  if bOLAPCubes then
    CrpeOLAPCubesDlg.FormShow(Self);
end;


{******************************************************************************}
{ MenuItem Clicks                                                              }
{******************************************************************************}
{******************************************************************************}
{ File Menu                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ miNewClick                                                                   }
{------------------------------------------------------------------------------}
procedure TfrmMain.miNewClick(Sender: TObject);
begin
  //
end;
{------------------------------------------------------------------------------}
{ miOpenClick                                                                  }
{------------------------------------------------------------------------------}
procedure TfrmMain.miOpenClick(Sender: TObject);
begin
  {Set the dialog default filename, filter and title}
  OpenDialog1.FileName := '*.rpt';
  OpenDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  OpenDialog1.Title := 'Load Report...';
  OpenDialog1.InitialDir := OpenDir;
  if OpenDialog1.Execute then
  begin
    Refresh;
    Report := OpenDialog1.FileName;
    {Update the 'Reopen' menu and PrevFile stringlist}
    UpdateReopenList;
    {Load the Report}
    LoadReport;
  end;
end;
{------------------------------------------------------------------------------}
{ ReopenMenuClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TfrmMain.ReopenMenuClick(Sender: TObject);
var
  str1 : string;
  i    : integer;
begin
  if Sender is TMenuItem then
  begin
    {Get the filename from the menu item}
    str1 := TMenuItem(Sender).Caption;
    i := Pos(' ', str1);
    str1 := Copy(str1, i+1, Length(str1));
    if str1 = 'Open' then
      Exit;
    {Check to make sure it exists}
    if FileExists(str1) then
    begin
      Report := str1;
      UpdateReopenList;
      LoadReport;
    end
    else
    begin
      i := PrevFiles.IndexOf(Str1);
      if i > -1 then
      begin
        miReopen.Delete(i);
        PrevFiles.Delete(i);
        UpdateReopenList;
      end;
      CrpeLoadErrorDlg := TCrpeLoadErrorDlg.Create(Application);
      CrpeLoadErrorDlg.ShowModal;
      if CrpeLoadErrorDlg.ModalResult = mrOk then
        miOpenClick(self);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ RemoveObsoleteClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.RemoveObsoleteClick(Sender: TObject);
var
  str1 : string;
  i,j  : integer;
begin
  {Clear the obsolete items in the Reopen submenu}
  for i := miReopen.Count-4 downto 0 do
  begin
    {Get the filename from the menu item}
    str1 := miReopen.Items[i].Caption;
    j := Pos(' ', str1);
    str1 := Copy(str1, j+1, Length(str1));
    {Check to make sure it exists}
    if not FileExists(str1) then
    begin
      miReopen.Delete(i);
      PrevFiles.Delete(i);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ RemoveAllClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TfrmMain.RemoveAllClick(Sender: TObject);
var
  i : integer;
begin
  {Clear the Reopen submenu}
  for i := miReopen.Count-4 downto 0 do
    miReopen.Delete(i);
  {Clear the Previous Files list}
  PrevFiles.Clear;
end;
{------------------------------------------------------------------------------}
{ miCloseClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.miCloseClick(Sender: TObject);
begin
  Crpe1.ReportName := '';
  StatusBar.Panels[0].Text := 'No Report Loaded ';
  StatusBar.Panels[1].Text := '';
  RptLoaded := False;
  miCloseEngine.Tag := 1;
  InitializeControls(False);
  if cbLoadEngineOnUse.Checked <> Crpe1.LoadEngineOnUse then
    Crpe1.LoadEngineOnUse := cbLoadEngineOnUse.Checked;
  miCloseEngine.Enabled := Crpe1.EngineOpen;
  DoUpdates;
end;
{------------------------------------------------------------------------------}
{ miSaveClick                                                                  }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSaveClick(Sender: TObject);
begin
  {Set the dialog default filename, filter and title}
  SaveDialog1.FileName := '*.rpt';
  SaveDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  SaveDialog1.Title := 'Save Report As...';
  SaveDialog1.InitialDir := OpenDir;
  if SaveDialog1.Execute then
  begin
    Refresh;
    Crpe1.Save(SaveDialog1.FileName);
    btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
  end;
end;
{------------------------------------------------------------------------------}
{ miSaveAsClick                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSaveAsClick(Sender: TObject);
begin
  {Set the dialog default filename, filter and title}
  SaveDialog1.FileName := '*.rpt';
  SaveDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  SaveDialog1.Title := 'Save Report As...';
  SaveDialog1.InitialDir := OpenDir;
  if SaveDialog1.Execute then
  begin
    Refresh;
    Crpe1.SaveAs(SaveDialog1.FileName);
    btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
  end;
end;
{------------------------------------------------------------------------------}
{ miDiscardDataClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miDiscardSavedDataClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;
  btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miPreviewClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPreviewClick(Sender: TObject);
begin
  if Crpe1.ReportWindowHandle > 0 then
  begin
    Crpe1.Refresh;
    btnDiscardSavedData.Enabled := True;
    Exit;
  end;

  if Crpe1.Output = toWindow then
  begin
    Crpe1.WindowStyle.BorderStyle := bsSizeable;
    Crpe1.WindowStyle.SystemMenu := True;
  end;

  {Run the Report}
  if Crpe1.Execute then
  begin
    {WindowEvents}
    if Crpe1.WindowEvents = True then
    begin
      if not bWindowEventsDlg then
        CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
      CrpeWindowEventsDlg.Show;
    end;
    btnDiscardSavedData.Enabled := Crpe1.HasSavedData;
  end;
end;
{------------------------------------------------------------------------------}
{ miWindowClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TfrmMain.miWindowClick(Sender: TObject);
begin
  if not bPreview then
  begin
    CrpePreviewDlg := TCrpePreviewDlg.Create(Application);
    CrpePreviewDlg.Cr := Crpe1;
  end;
  CrpePreviewDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miPrinterClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPrinterClick(Sender: TObject);
begin
  if not bPrinter then
  begin
    Application.CreateForm(TCrpePrinterDlg, CrpePrinterDlg);
    CrpePrinterDlg.Cr := Crpe1;
  end;
  CrpePrinterDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miExportClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TfrmMain.miExportClick(Sender: TObject);
begin
  if not bExportOptions then
  begin
    Application.CreateForm(TCrpeExportOptionsDlg, CrpeExportOptionsDlg);
    CrpeExportOptionsDlg.Cr := Crpe1;
  end;
  CrpeExportOptionsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miPrinterSetupClick                                                          }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPrinterSetupClick(Sender: TObject);
begin
  {This routine does the same thing as Printer.ShowPrintDlg}
  {Set the PrintDialog options from the PrinterOptions}
  PrintDialog1.Options := [poPageNums, poWarning];
  PrintDialog1.FromPage := Crpe1.PrintOptions.StartPage;
  {If you want "All" to be selected for PageRange, set StopPage to 65535}
  PrintDialog1.ToPage := Crpe1.PrintOptions.StopPage;
  PrintDialog1.Copies := Crpe1.PrintOptions.Copies;
  PrintDialog1.MaxPage := 65535; {PE_MAXPAGEN}
  PrintDialog1.Collate := Crpe1.PrintOptions.Collation;
  {Show the Print Dialog}
  if PrintDialog1.Execute then
  begin
    {Set the PrinterOptions from the PrintDialog}
    Crpe1.PrintOptions.StartPage := PrintDialog1.FromPage;
    Crpe1.PrintOptions.StopPage  := PrintDialog1.ToPage;
    Crpe1.PrintOptions.Copies  := PrintDialog1.Copies;
    Crpe1.PrintOptions.Collation := PrintDialog1.Collate;
    Crpe1.Printer.GetCurrent(True);
  end;
end;
{------------------------------------------------------------------------------}
{ miPageMarginsClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPageMarginsClick(Sender: TObject);
begin
  if not bMargins then
  begin
    Application.CreateForm(TCrpeMarginsDlg, CrpeMarginsDlg);
    CrpeMarginsDlg.Cr := Crpe1;
  end;
  CrpeMarginsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ ReportOptions1Click procedure                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miReportOptionsClick(Sender: TObject);
begin
  if not bReportOptions then
  begin
    Application.CreateForm(TCrpeReportOptionsDlg, CrpeReportOptionsDlg);
    CrpeReportOptionsDlg.Cr := Crpe1;
  end;
  CrpeReportOptionsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miGlobalOptionsClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGlobalOptionsClick(Sender: TObject);
begin
  if not bGlobalOptions then
  begin
    Application.CreateForm(TCrpeGlobalOptionsDlg, CrpeGlobalOptionsDlg);
    CrpeGlobalOptionsDlg.Cr := Crpe1;
  end;
  CrpeGlobalOptionsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ SummaryInfo1Click procedure                                                  }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSummaryInfoClick(Sender: TObject);
begin
  if not bSummaryInfo then
  begin
    Application.CreateForm(TCrpeSummaryInfoDlg, CrpeSummaryInfoDlg);
    CrpeSummaryInfoDlg.Cr := Crpe1;
  end;
  CrpeSummaryInfoDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miVersionClick                                                               }
{------------------------------------------------------------------------------}
procedure TfrmMain.miVersionClick(Sender: TObject);
begin
  if not bVersion then
  begin
    Application.CreateForm(TCrpeVersionDlg, CrpeVersionDlg);
    CrpeVersionDlg.Cr := Crpe1;
  end;
  CrpeVersionDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miCloseEngineClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.miCloseEngineClick(Sender: TObject);
begin
  miCloseClick(Self);
  Crpe1.CloseEngine;
  miCloseEngine.Enabled := False;
end;
{------------------------------------------------------------------------------}
{ miExitClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
{ Edit Menu                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ miDatabaseFieldsClick                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miDatabaseFieldsClick(Sender: TObject);
begin
  if not bDatabaseFields then
  begin
    Application.CreateForm(TCrpeDatabaseFieldsDlg, CrpeDatabaseFieldsDlg);
    CrpeDatabaseFieldsDlg.Cr := Crpe1;
  end;
  CrpeDatabaseFieldsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miTextObjectsClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miTextObjectsClick(Sender: TObject);
begin
  if not bTextObjects then
  begin
    Application.CreateForm(TCrpeTextObjectsDlg, CrpeTextObjectsDlg);
    CrpeTextObjectsDlg.Cr := Crpe1;
  end;
  CrpeTextObjectsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miFormulaFieldsClick                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miFormulaFieldsClick(Sender: TObject);
begin
  if not bFormulas then
  begin
    Application.CreateForm(TCrpeFormulasDlg, CrpeFormulasDlg);
    CrpeFormulasDlg.Cr := Crpe1;
  end;
  CrpeFormulasDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miParameterFieldsClick                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.miParameterFieldsClick(Sender: TObject);
begin
  if not bParamFields then
  begin
    Application.CreateForm(TCrpeParamFieldsDlg, CrpeParamFieldsDlg);
    CrpeParamFieldsDlg.Cr := Crpe1;
  end;
  CrpeParamFieldsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSpecialFieldsClick                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSpecialFieldsClick(Sender: TObject);
begin
  if not bSpecialFields then
  begin
    Application.CreateForm(TCrpeSpecialFieldsDlg, CrpeSpecialFieldsDlg);
    CrpeSpecialFieldsDlg.Cr := Crpe1;
  end;
  CrpeSpecialFieldsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miRunningTotalsClick                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miRunningTotalsClick(Sender: TObject);
begin
  if not bRunningTotals then
  begin
    Application.CreateForm(TCrpeRunningTotalsDlg, CrpeRunningTotalsDlg);
    CrpeRunningTotalsDlg.Cr := Crpe1;
  end;
  CrpeRunningTotalsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSQLExpressionsClick                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSQLExpressionsClick(Sender: TObject);
begin
  if not bSQLExpressions then
  begin
    Application.CreateForm(TCrpeSQLExpressionsDlg, CrpeSQLExpressionsDlg);
    CrpeSQLExpressionsDlg.Cr := Crpe1;
  end;
  CrpeSQLExpressionsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miSummaryFieldsClick                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSummaryFieldsClick(Sender: TObject);
begin
  if not bSummaryFields then
  begin
    Application.CreateForm(TCrpeSummaryFieldsDlg, CrpeSummaryFieldsDlg);
    CrpeSummaryFieldsDlg.Cr := Crpe1;
  end;
  CrpeSummaryFieldsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miSectionFormatClick                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSectionFormatClick(Sender: TObject);
begin
  if not bSectionFormat then
  begin
    Application.CreateForm(TCrpeSectionFormatDlg, CrpeSectionFormatDlg);
    CrpeSectionFormatDlg.Cr := Crpe1;
  end;
  CrpeSectionFormatDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miAreaFormatClick                                                            }
{------------------------------------------------------------------------------}
procedure TfrmMain.miAreaFormatClick(Sender: TObject);
begin
  if not bAreaFormat then
  begin
    Application.CreateForm(TCrpeAreaFormatDlg, CrpeAreaFormatDlg);
    CrpeAreaFormatDlg.Cr := Crpe1;
  end;
  CrpeAreaFormatDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSectionFontClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSectionFontClick(Sender: TObject);
begin
  if not bSectionFont then
  begin
    Application.CreateForm(TCrpeSectionFontDlg, CrpeSectionFontDlg);
    CrpeSectionFontDlg.Cr := Crpe1;
  end;
  CrpeSectionFontDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSectionSizeClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSectionSizeClick(Sender: TObject);
begin
  if not bSectionSize then
  begin
    Application.CreateForm(TCrpeSectionSizeDlg, CrpeSectionSizeDlg);
    CrpeSectionSizeDlg.Cr := Crpe1;
  end;
  CrpeSectionSizeDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miGroupNameFieldsClick                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGroupNameFieldsClick(Sender: TObject);
begin
  if not bGroupNameFields then
  begin
    Application.CreateForm(TCrpeGroupNameFieldsDlg, CrpeGroupNameFieldsDlg);
    CrpeGroupNameFieldsDlg.Cr := Crpe1;
  end;
  CrpeGroupNameFieldsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miOLAPCubesClick                                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.miOLAPCubesClick(Sender: TObject);
begin
  if not bOLAPCubes then
  begin
    Application.CreateForm(TCrpeOLAPCubesDlg, CrpeOLAPCubesDlg);
    CrpeOLAPCubesDlg.Cr := Crpe1;
  end;
  CrpeOLAPCubesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miCrossTabsClick                                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.miCrossTabsClick(Sender: TObject);
begin
  if not bCrossTabs then
  begin
    Application.CreateForm(TCrpeCrossTabsDlg, CrpeCrossTabsDlg);
    CrpeCrossTabsDlg.Cr := Crpe1;
  end;
  CrpeCrossTabsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSubreportsClick                                                            }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSubreportsClick(Sender: TObject);
begin
  Application.CreateForm(TCrpeSubreportsDlg, CrpeSubreportsDlg);
  CrpeSubreportsDlg.Cr := Crpe1;
  CrpeSubreportsDlg.ShowModal;
  {Update in case Subreport.Add was used...}
  if (Crpe1.Subreports.Count-1) > lbSubNames.Items.Count then
  begin
    lbSubNames.Clear;
    lbSubNames.Items.AddStrings(Crpe1.Subreports.Names);
  end;
  if Crpe1.Subreports.ItemIndex > 0 then
  begin
    SubNameIndex := Crpe1.Subreports.ItemIndex-1;
    rbSubClick(Self);
  end
  else
    rbMainClick(Self);
  CrpeSubreportsDlg.Release;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miLinesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.miLinesClick(Sender: TObject);
begin
  if not bLines then
  begin
    Application.CreateForm(TCrpeLinesDlg, CrpeLinesDlg);
    CrpeLinesDlg.Cr := Crpe1;
  end;
  CrpeLinesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miBoxesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.miBoxesClick(Sender: TObject);
begin
  if not bBoxes then
  begin
    Application.CreateForm(TCrpeBoxesDlg, CrpeBoxesDlg);
    CrpeBoxesDlg.Cr := Crpe1;
  end;
  CrpeBoxesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miPicturesClick                                                              }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPicturesClick(Sender: TObject);
begin
  if not bPictures then
  begin
    Application.CreateForm(TCrpePicturesDlg, CrpePicturesDlg);
    CrpePicturesDlg.Cr := Crpe1;
  end;
  CrpePicturesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miGraphsClick                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGraphsClick(Sender: TObject);
begin
  if not bGraphs then
  begin
    Application.CreateForm(TCrpeGraphsDlg, CrpeGraphsDlg);
    CrpeGraphsDlg.Cr := Crpe1;
  end;
  CrpeGraphsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miMapsClick                                                                  }
{------------------------------------------------------------------------------}
procedure TfrmMain.miMapsClick(Sender: TObject);
begin
  if not bMaps then
  begin
    Application.CreateForm(TCrpeMapsDlg, CrpeMapsDlg);
    CrpeMapsDlg.Cr := Crpe1;
  end;
  CrpeMapsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miOleObjectsClick                                                            }
{------------------------------------------------------------------------------}
procedure TfrmMain.miOleObjectsClick(Sender: TObject);
begin
  if not bOleObjects then
  begin
    Application.CreateForm(TCrpeOleObjectsDlg, CrpeOleObjectsDlg);
    CrpeOleObjectsDlg.Cr := Crpe1;
  end;
  CrpeOleObjectsDlg.Show;
end;

{******************************************************************************}
{ View Menu                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ menuViewClick                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.menuViewClick(Sender: TObject);
begin
  ProgressDialog1.Checked := Crpe1.ProgressDialog;
end;
{------------------------------------------------------------------------------}
{ Toolbar1Click                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miToolbarClick(Sender: TObject);
begin
  miToolbar.Checked := not miToolbar.Checked;
  pnlBBar.Visible := miToolbar.Checked;
  if pnlBBar.Visible then
    Height := Height + pnlBBar.Height
  else
    Height := Height - pnlBBar.Height;
end;
{------------------------------------------------------------------------------}
{ StatusBar1Click                                                              }
{------------------------------------------------------------------------------}
procedure TfrmMain.miStatusBarClick(Sender: TObject);
begin
  miStatusBar.Checked := not miStatusBar.Checked;
  StatusBar.Visible := miStatusBar.Checked;
  if StatusBar.Visible then
    Height := Height + StatusBar.Height
  else
    Height := Height - StatusBar.Height;
end;
{------------------------------------------------------------------------------}
{ ProgressDialog1Click                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.ProgressDialog1Click(Sender: TObject);
begin
  ProgressDialog1.Checked := not ProgressDialog1.Checked;
  Crpe1.ProgressDialog := ProgressDialog1.Checked;
end;

{******************************************************************************}
{ Database Menu                                                                }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ miTablesClick                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miTablesClick(Sender: TObject);
begin
  if not bTables then
  begin
    Application.CreateForm(TCrpeTablesDlg, CrpeTablesDlg);
    CrpeTablesDlg.Cr := Crpe1;
  end;
  CrpeTablesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSessionInfoClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSessionInfoClick(Sender: TObject);
begin
  if not bSessionInfo then
  begin
    Application.CreateForm(TCrpeSessionInfoDlg, CrpeSessionInfoDlg);
    CrpeSessionInfoDlg.Cr := Crpe1;
  end;
  CrpeSessionInfoDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miVerifyDatabaseClick                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miVerifyDatabaseClick(Sender: TObject);
begin
  if Crpe1.Tables.Verify then
    MessageDlg('The Database is up to date.', mtInformation, [mbOk], 0)
  else
    MessageDlg('An Error occured during Verify.', mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ miVerifyOnEveryPrintClick                                                    }
{------------------------------------------------------------------------------}
procedure TfrmMain.miVerifyOnEveryPrintClick(Sender: TObject);
begin
  miVerifyOnEveryPrint.Checked := not miVerifyOnEveryPrint.Checked;
  Crpe1.ReportOptions.VerifyOnEveryPrint := miVerifyOnEveryPrint.Checked;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miLogOnServer2Click                                                          }
{------------------------------------------------------------------------------}
procedure TfrmMain.miLogOnServer2Click(Sender: TObject);
begin
  if not bLogOnServer then
  begin
    Application.CreateForm(TCrpeLogOnServerDlg, CrpeLogOnServerDlg);
    CrpeLogOnServerDlg.Cr := Crpe1;
  end;
  CrpeLogOnServerDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miLogOnInfoClick                                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.miLogOnInfoClick(Sender: TObject);
begin
  if not bLogOnInfo then
  begin
    Application.CreateForm(TCrpeLogOnInfoDlg, CrpeLogOnInfoDlg);
    CrpeLogOnInfoDlg.Cr := Crpe1;
  end;
  CrpeLogOnInfoDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miConnectClick                                                               }
{------------------------------------------------------------------------------}
procedure TfrmMain.miConnectClick(Sender: TObject);
begin
  if not bConnect then
  begin
    Application.CreateForm(TCrpeConnectDlg, CrpeConnectDlg);
    CrpeConnectDlg.Cr := Crpe1;
  end;
  CrpeConnectDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSQLQueryClick                                                              }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSQLQueryClick(Sender: TObject);
begin
  if not bSQLQuery then
  begin
    Application.CreateForm(TCrpeSQLQueryDlg, CrpeSQLQueryDlg);
    CrpeSQLQueryDlg.Cr := Crpe1;
  end;
  CrpeSQLQueryDlg.Show;
end;

{******************************************************************************}
{ Report Menu                                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ miSelectionClick                                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSelectionClick(Sender: TObject);
begin
  if not bSelection then
  begin
    Application.CreateForm(TCrpeSelectionDlg, CrpeSelectionDlg);
    CrpeSelectionDlg.Cr := Crpe1;
  end;
  CrpeSelectionDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miGroupSelectionClick                                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGroupSelectionClick(Sender: TObject);
begin
  if not bGroupSelection then
  begin
    Application.CreateForm(TCrpeGroupSelectionDlg, CrpeGroupSelectionDlg);
    CrpeGroupSelectionDlg.Cr := Crpe1;
  end;
  CrpeGroupSelectionDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miGroupsClick                                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGroupsClick(Sender: TObject);
begin
  if not bGroups then
  begin
    Application.CreateForm(TCrpeGroupsDlg, CrpeGroupsDlg);
    CrpeGroupsDlg.Cr := Crpe1;
  end;
  CrpeGroupsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miGroupSortFieldsClick                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.miGroupSortFieldsClick(Sender: TObject);
begin
  if not bGroupSortFields then
  begin
    Application.CreateForm(TCrpeGroupSortFieldsDlg, CrpeGroupSortFieldsDlg);
    CrpeGroupSortFieldsDlg.Cr := Crpe1;
  end;
  CrpeGroupSortFieldsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miSortFieldsClick                                                            }
{------------------------------------------------------------------------------}
procedure TfrmMain.miSortFieldsClick(Sender: TObject);
begin
  if not bSortFields then
  begin
    Application.CreateForm(TCrpeSortFieldsDlg, CrpeSortFieldsDlg);
    CrpeSortFieldsDlg.Cr := Crpe1;
  end;
  CrpeSortFieldsDlg.Show;
end;
{ Line ************************************************************************}
{------------------------------------------------------------------------------}
{ miPrintDateClick                                                             }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPrintDateClick(Sender: TObject);
begin
  if not bPrintDate then
  begin
    Application.CreateForm(TCrpePrintDateDlg, CrpePrintDateDlg);
    CrpePrintDateDlg.Cr := Crpe1;
  end;
  CrpePrintDateDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miReportTitleClick                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.miReportTitleClick(Sender: TObject);
begin
  if not bMiscellaneous then
  begin
    Application.CreateForm(TCrpeMiscellaneousDlg, CrpeMiscellaneousDlg);
    CrpeMiscellaneousDlg.Cr := Crpe1;
  end;
  CrpeMiscellaneousDlg.Show;
end;
{------------------------------------------------------------------------------}
{ miPagesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.miPagesClick(Sender: TObject);
begin
  if not bPages then
  begin
    Application.CreateForm(TCrpePagesDlg, CrpePagesDlg);
    CrpePagesDlg.Cr := Crpe1;
  end;
  CrpePagesDlg.Show;
end;
{------------------------------------------------------------------------------}
{ btnRecordsClick                                                              }
{------------------------------------------------------------------------------}
procedure TfrmMain.btnRecordsClick(Sender: TObject);
begin
  if not bRecords then
  begin
    Application.CreateForm(TCrpeRecordsDlg, CrpeRecordsDlg);
    CrpeRecordsDlg.Cr := Crpe1;
  end;
  CrpeRecordsDlg.Show;
end;


{******************************************************************************}
{ Help Menu                                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ miVCLHelpClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TfrmMain.miVCLHelpClick(Sender: TObject);
begin
  Application.HelpContext(1);
end;
{------------------------------------------------------------------------------}
{ miVCLTechnicalSupportClick procedure                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.miVCLTechnicalSupportClick(Sender: TObject);
begin
  Application.HelpContext(20);
end;
{------------------------------------------------------------------------------}
{ miCloseAndSendClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.miCloseAndSendClick(Sender: TObject);
var
  RegIni      : TRegIniFile;
  sCRW        : string;
  CmdStr      : string;
  ShortPath   : array[0..255] of char;
  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;

  function GetCRWPath: string;
  var
    s1   : string;
    Reg1 : TRegistry;
  begin
    Result := '';
    Reg1 := TRegistry.Create;
    try
      Reg1.RootKey := HKEY_LOCAL_MACHINE;
      if not Reg1.OpenKey('\SOFTWARE\Business Objects\Suite 11.0\Crystal Reports', False) then
        Exit;
      s1 := Reg1.ReadString('Path');
      if not IsStrEmpty(s1) then
        Result := s1 + '\Crw32.exe';
    except
      Reg1.Free;
    end;
    Reg1.Free;
  end;

begin
  {Check that Report file is specified}
  if not FileExists(Report) then
  begin
    if MessageDlg('Cannot locate the Report.' + chr(13) +
       'Load another one now?', mtError, [mbOk, mbCancel], 0) = mrOk then
       miOpenClick(Self);
    if not FileExists(Report) then
      Exit;
  end;

  {Get CRW Path from Registry}
  sCRW := GetCRWPath;
  if IsStrEmpty(sCRW) then
  begin
    RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\');
    try
      {Read the CRWPath from CrystalVCL Registry entries}
      RegIni.ReadString('CrystalVCL','CRWPath',sCRW);
    except
      RegIni.Free;
    end;
    RegIni.Free;
  end;

  if not FileExists(sCRW) then
  begin
    if MessageDlg('Cannot locate Crystal Reports Designer.' + chr(13) +
       'Locate it now?', mtWarning, mbOkCancel, 0) = mrOk then
    begin
      OpenDialog1.FileName := '*.exe';
      OpenDialog1.Filter := 'Crystal Reports Designer (CRW32.EXE)|*.exe';
      OpenDialog1.Title := 'Locate Crystal Reports Designer...';
      OpenDialog1.InitialDir := OpenDir;
      if OpenDialog1.Execute then
      begin
        sCRW := OpenDialog1.FileName;
        {Update the Registry}
        RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\');
        try
          {Write the CRWPath into the Registry}
          RegIni.WriteString('CrystalVCL','CRWPath',sCRW);
        except
          RegIni.Free;
        end;
        RegIni.Free;
      end
      else
        Exit;
    end
    else
      Exit;
  end;

  {Close Report so CRW can open it for editing}
  miCloseClick(Self);

  {Setup the startup information for the application }
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb:= SizeOf(TStartupInfo);
    dwFlags:= STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow:= SW_SHOWNORMAL;
  end;
  GetShortPathName(PChar(Report), ShortPath, 255);
  CmdStr := sCRW + ' ' + string(ShortPath);
  CreateProcess(nil,PChar(CmdStr), nil, nil, False,
     NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
end;
{------------------------------------------------------------------------------}
{ ShowAboutBox procedure                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.ShowAboutBox;
var
  AboutBox : TCrpeAboutBox;
begin
  AboutBox := TCrpeAboutBox.Create(frmMain);
  AboutBox.Caption := 'VCL Version';
  AboutBox.lblLanguage.Caption := TCRPE_LANGUAGE;
  AboutBox.lblCopyright.Caption := TCRPE_COPYRIGHT;
  AboutBox.lblVersion.Caption := 'Version ' + TCRPE_VERSION;
  AboutBox.lblCompany.Caption := TCRPE_COMPANY_NAME;
  AboutBox.lblAddress1.Caption := TCRPE_COMPANY_ADDRESS1;
  AboutBox.lblAddress2.Caption := TCRPE_COMPANY_ADDRESS2;
  AboutBox.lblVCLEmail.Caption := TCRPE_VCL_EMAIL;
  AboutBox.lblVCLWebSite.Caption := TCRPE_VCL_WEBSITE;
  AboutBox.lblCRPhone.Caption := TCRPE_CR_PHONE;
  AboutBox.lblCREmail.Caption := TCRPE_CR_EMAIL;
  AboutBox.lblCRWebSite.Caption := TCRPE_CR_WEBSITE;
  AboutBox.ShowModal;
end;
{------------------------------------------------------------------------------}
{ AboutVCLComponent1Click procedure                                            }
{------------------------------------------------------------------------------}
procedure TfrmMain.miAboutVCLClick(Sender: TObject);
begin
  ShowAboutBox;
end;
{------------------------------------------------------------------------------}
{ AboutCrystalSampleApp1Click procedure                                        }
{------------------------------------------------------------------------------}
procedure TfrmMain.miAboutClick(Sender: TObject);
begin
  CrpeAboutBoxSA := TCrpeAboutBoxSA.Create(Application);
  CrpeAboutBoxSA.ShowModal;
end;
{------------------------------------------------------------------------------}
{ sbCancelClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TfrmMain.sbCancelClick(Sender: TObject);
begin
  Crpe1.CancelJob;
end;
{------------------------------------------------------------------------------}
{ sbFieldBrowserClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TfrmMain.sbFieldBrowserClick(Sender: TObject);
begin
  if not bFieldSelect then
  begin
    CrpeFieldSelectDlg := TCrpeFieldSelectDlg.Create(Self);
    CrpeFieldSelectDlg.Cr := Crpe1;
  end;
  CrpeFieldSelectDlg.Show;
end;
{------------------------------------------------------------------------------}
{ WMGetMinMaxInfo method                                                       }
{------------------------------------------------------------------------------}
procedure TfrmMain.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  MinMax : PMinMaxInfo;
  i1,i2  : integer;
begin
  inherited;
  MinMax := Message.MinMaxInfo;
  {Sizing Minimum}
  i1 := (3437 * PixelsPerInch) div 1000; {330}
  i2 := (4635 * PixelsPerInch) div 1000; {445}
  if MinMax^.ptMinTrackSize.X < i1 then
    MinMax^.ptMinTrackSize.X := i1;
  if MinMax^.ptMaxTrackSize.X > i1 then
    MinMax^.ptMaxTrackSize.X := i1;
  if MinMax^.ptMinTrackSize.Y < i2 then
    MinMax^.ptMinTrackSize.Y := i2;
end;


{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : integer;
begin
  SaveFormPos(Self);
  {If a Report is Loaded, clear it}
  if RptLoaded then
    miCloseClick(Self);
  {Free the Previous Reports stringlist}
  if PrevFiles <> nil then
    PrevFiles.Free;
  {Free the Load Previous Reports submenu}
  {Clear the Reopen submenu}
  for i := miReopen.Count-1 downto 0 do
    miReopen.Delete(i);
  {Release the Form memory}
  Release;
end;
{------------------------------------------------------------------------------}
{ Crpe1Error procedure                                                         }
{------------------------------------------------------------------------------}
procedure TfrmMain.Crpe1Error(Sender: TObject; const ErrorNum: Smallint;
  const ErrorString: String; var IgnoreError: TCrErrorResult);
begin
  CrpeErrorDlg := TCrpeErrorDlg.Create(Application);
  {Dialog Title}
  if ErrorNum < 500 then
    CrpeErrorDlg.lblTitle.Caption := 'Crystal Reports Component Error'
  else
    CrpeErrorDlg.lblTitle.Caption := 'Crystal Reports Engine Error';

  {Error Number}
  if ErrorNum > 0 then
    CrpeErrorDlg.lblErrorNumber.Caption := 'Error #: ' + IntToStr(ErrorNum)
  else
    CrpeErrorDlg.lblErrorNumber.Caption := 'Error Number Undefined';

  {Error String}
  CrpeErrorDlg.memoErrorString.Text := ErrorString;

  {Show Dialog}
  CrpeErrorDlg.ShowModal;
  case CrpeErrorDlg.ModalResult of
    mrIgnore : IgnoreError := errIgnore;
    mrAbort  : IgnoreError := errAbort;
    mrOk     : IgnoreError := errRaise;
    else IgnoreError := errAbort;
  end;
end;
{------------------------------------------------------------------------------}
{ FieldMapping Event                                                           }
{------------------------------------------------------------------------------}
procedure TfrmMain.Crpe1OnFieldMapping(var ReportFields,
  DatabaseFields: TList; var Cancel: Boolean);
begin
  CrpeFieldMappingDlg := TCrpeFieldMappingDlg.Create(Application);
  CrpeFieldMappingDlg.ReportFields1   := ReportFields;
  CrpeFieldMappingDlg.DataBaseFields1 := DatabaseFields;
  CrpeFieldMappingDlg.ShowModal;
  Cancel := (CrpeFieldMappingDlg.ModalResult = mrCancel);
end;


{------------------------------------------------------------------------------}
{ WindowEvents                                                                 }
{------------------------------------------------------------------------------}
procedure TfrmMain.Crpe1wOnActivateWindow(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnActivateWindow Event:');
    Add('  - Window was Activated ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnCancelBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnCancelBtnClick Event:');
    Add('  - Cancel Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnCloseBtnClick(WindowHandle: HWnd;
  ViewIndex: Word; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnCloseBtnClick Event:');
    Add('  - Close Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - ViewIndex: ' + IntToStr(ViewIndex));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnCloseWindow(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnCloseWindow Event:');
    Add('  - Window is being Closed ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnDeActivateWindow(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnDeActivateWindow Event:');
    Add('  - Window was DeActivated ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnDrillDetail(WindowHandle: HWnd;
  NSelectedField, NFields: Smallint; FieldNames,
  FieldValues: TStringList; var Cancel: Boolean);
var
  cnt : integer;
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnDrillDetail Event:');
    Add('  - Detail Section was drilled ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - Number of Fields in Details area: ' + IntToStr(NFields));
    Add('  - Number of Selected Field: ' + IntToStr(NSelectedField));
    Add('  - Field Names: ');
    for cnt := 0 to (FieldNames.Count - 1) do
      Add('      ' + IntToStr(cnt) + '. ' + FieldNames[cnt]);
    Add('  - Field Values: ');
    for cnt := 0 to (FieldValues.Count - 1) do
      Add('      ' + IntToStr(cnt) + '. ' + FieldValues[cnt]);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnDrillGroup(WindowHandle: HWnd;
  NGroupLevel: Word; DrillType: TCrDrillDownType; GroupList: TStringList;
  var Cancel: Boolean);
var
  cnt: integer;
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnDrillGroup Event:');
    Add('  - Group Section was drilled ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    case DrillType of
      ddOnGroup     : Add('  - DrillDown Type: OnGroup');
      ddOnGroupTree : Add('  - DrillDown Type: OnGroupTree');
      ddOnGraph     : Add('  - DrillDown Type: OnGraph');
      ddOnMap       : Add('  - DrillDown Type: OnMap');
      ddOnSubreport : Add('  - DrillDown Type: OnSubreport');
    end;
    Add('  - GroupLevel: ' + IntToStr(NGroupLevel));
    Add('  - GroupList: ');
    for cnt := 0 to (GroupList.Count - 1) do
      Add('      ' + IntToStr(cnt) + '. ' + GroupList[cnt]);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnExportBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnExportBtnClick Event:');
    Add('  - Export Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnFirstPageBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnFirstPageBtnClick Event:');
    Add('  - First Page Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnGroupTreeBtnClick(WindowHandle: HWnd;
  Visible: Boolean; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnGroupTreeBtnClick Event:');
    Add('  - GroupTree Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - GroupTree Visible: ' + BooleanToStr(Visible));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnLastPageBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnLastPageBtnClick Event:');
    Add('  - Last Page Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnNextPageBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnNextPageBtnClick Event:');
    Add('  - Next Page Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnPreviousPageBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnPreviousPageBtnClick Event:');
    Add('  - Previous Page Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnPrintBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnPrintBtnClick Event:');
    Add('  - Print Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnPrintSetupBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnPrintSetupBtnClick Event:');
    Add('  - Print Setup Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnReadingRecords(Cancelled: Boolean; RecordsRead,
  RecordsSelected: LongInt; Done: Boolean; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnReadingRecords Event:');
    Add('  - Reading Records Event triggered ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - Records Read: ' + IntToStr(RecordsRead));
    Add('  - Records Selected: ' + IntToStr(RecordsSelected));
    Add('  - Cancelled: ' + BooleanToStr(Cancelled));
    Add('  - Done: ' + BooleanToStr(Done));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnRefreshBtnClick(WindowHandle: HWnd;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnRefreshBtnClick Event:');
    Add('  - Refresh Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnSearchBtnClick(WindowHandle: HWnd;
  SearchString: String; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnSearchBtnClick Event:');
    Add('  - Search Button clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - Search String: ' + SearchString);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnShowGroup(WindowHandle: HWnd;
  NGroupLevel: Word; GroupList: TStringList; var Cancel: Boolean);
var
  cnt: integer;
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnShowGroup Event:');
    Add('  - Group Tree was clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - GroupLevel: ' + IntToStr(NGroupLevel));
    Add('  - GroupList: ');
    for cnt := 0 to (GroupList.Count - 1) do
      Add('      ' + IntToStr(cnt) + '. ' + GroupList[cnt]);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnStartEvent(Destination: TCrStartEventDestination;
  var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnStartEvent Event:');
    Add('  - An Event was Started ');
    case Destination of
      seNoWhere   : Add('  - Destination: seNoWhere');
      seToWindow  : Add('  - Destination: seToWindow');
      seToPrinter : Add('  - Destination: seToPrinter');
      seToExport  : Add('  - Destination: seToExport');
      seFromQuery : Add('  - Destination: seFromQuery');
    end;
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnStopEvent(Destination: TCrStartEventDestination;
  JobStatus: TCrStopEventJobStatus; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnStopEvent Event:');
    Add('  - An Event was Stopped ');
    case Destination of
      seNoWhere   : Add('  - Destination: seNoWhere');
      seToWindow  : Add('  - Destination: seToWindow');
      seToPrinter : Add('  - Destination: seToPrinter');
      seToExport  : Add('  - Destination: seToExport');
      seFromQuery : Add('  - Destination: seFromQuery');
    end;
    case JobStatus of
      seUndefined  : Add('  - JobStatus: seUndefined');
      seNotStarted : Add('  - JobStatus: seNotStarted');
      seInProgress : Add('  - JobStatus: seInProgress');
      seCompleted  : Add('  - JobStatus: seCompleted');
      seFailed     : Add('  - JobStatus: seFailed');
      seCancelled  : Add('  - JobStatus: seCancelled');
      seHalted     : Add('  - JobStatus: seHalted');
    end;
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnDrillHyperLink(WindowHandle: HWnd;
  HyperLinkText: String; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnDrillHyperLink Event:');
    Add('  - A HyperLink was Clicked ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - HyperLinkText: ' + HyperLinkText);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnLaunchSeagateAnalysis(WindowHandle: HWnd;
  FilePath: String; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnLaunchSeagateAnalysis Event:');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - FilePath: ' + FilePath);
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnZoomLevelChange(WindowHandle: HWnd;
  ZoomLevel: Word; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnZoomLevelChange Event:');
    Add('  - Zoom Level was changed ');
    Add('  - WindowHandle: ' + IntToStr(WindowHandle));
    Add('  - Zoom Level: ' + IntToStr(ZoomLevel));
    Add('');
  end;
end;

procedure TfrmMain.Crpe1wOnMouseClick(WindowHandle: HWnd;
  MouseInfo: TCrMouseInfo; FieldValue: String; FieldType: TCrParamFieldType;
  Section: String; ObjectHandle: HWnd; var Cancel: Boolean);
begin
  if not bWindowEventsDlg then
  begin
    CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;
  with CrpeWindowEventsDlg.memoWindowEvents.Lines do
  begin
    Add('wOnMouseClick Event:');
    case MouseInfo.Button of
      mcNone   : Add('  - Button: None');
      mcLeft   : Add('  - Button: Left Mouse Click');
      mcRight  : Add('  - Button: Right Mouse Click');
      mcMiddle : Add('  - Button: Middle Mouse Click');
    end;
    case MouseInfo.Action of
      mbNotSupported : Add('  - Action: Not Supported');
      mbDown         : Add('  - Action: Mouse Button Down');
      mbUp           : Add('  - Action: Mouse Button Up');
      mbDoubleClick  : Add('  - Action: Mouse Button Double Click');
    end;
    if MouseInfo.ShiftKey = True then
      Add('  - ShiftKey: True')
    else
      Add('  - ShiftKey: False');
    if MouseInfo.ControlKey = True then
      Add('  - ControlKey: True')
    else
      Add('  - ControlKey: False');
    Add('  - X Coordinate: ' + IntToStr(MouseInfo.x));
    Add('  - Y Coordinate: ' + IntToStr(MouseInfo.y));
    Add('  - FieldValue: ' + FieldValue);
    case Ord(FieldType) of
      0 {pfNumber}       : Add('  - FieldType: pfNumber');
      1 {pfCurrency}     : Add('  - FieldType: pfCurrency');
      2 {pfBoolean}      : Add('  - FieldType: pfBoolean');
      3 {pfDate}         : Add('  - FieldType: pfDate');
      4 {pfString}       : Add('  - FieldType: pfString');
      5 {pfDateTime}     : Add('  - FieldType: pfDateTime');
      6 {pfTime}         : Add('  - FieldType: pfTime');
      7 {pfInteger}      : Add('  - FieldType: pfInteger');
      8 {pfColor}        : Add('  - FieldType: pfColor');
      9 {pfChar}         : Add('  - FieldType: pfChar');
      10{pfLong}         : Add('  - FieldType: pfLong');
      11{pfStringHandle} : Add('  - FieldType: pfStringHandle');
      12{pfNoValue}      : Add('  - FieldType: pfNoValue');
      else
        Add('  - FieldType: Unrecognized: ' + IntToStr(Ord(FieldType)));
    end;
    Add('  - Section: ' + Section);
    Add('  - ObjectHandle: ' + IntToStr(ObjectHandle));
    Add('');
  end;
end;



end.


