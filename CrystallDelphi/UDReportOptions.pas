unit UDReportOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeReportOptionsDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    gbROptions: TGroupBox;
    lblConvertDateTimeType: TLabel;
    lblZoomMode: TLabel;
    cbConvertDateTimeType: TComboBox;
    cbZoomMode: TComboBox;
    pnlROptions2: TPanel;
    cbConvertNullFieldToDefault: TCheckBox;
    cbSaveDataWithReport: TCheckBox;
    cbSaveSummariesWithReport: TCheckBox;
    cbUseIndexForSpeed: TCheckBox;
    cbUseDummyData: TCheckBox;
    cbCaseInsensitiveSQLData: TCheckBox;
    cbCreateGroupTree: TCheckBox;
    cbPerformGroupingOnServer: TCheckBox;
    cbNoDataForHiddenObjects: TCheckBox;
    cbVerifyOnEveryPrint: TCheckBox;
    cbAsyncQuery: TCheckBox;
    cbSelectDistinctRecords: TCheckBox;
    lblPromptMode: TLabel;
    cbPromptMode: TComboBox;
    cbAlwaysSortLocally: TCheckBox;
    cbCanSelectDistinctRecords: TCheckBox;
    cbIsReadOnly: TCheckBox;
    cbConvertOtherNullsToDefault: TCheckBox;
    cbVerifyStoredProcOnRefresh: TCheckBox;
    cbRetainImageColorDepth: TCheckBox;
    cbPrintEngineErrorMessages: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateReportOptions;
    procedure btnClearClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr                         : TCrpe;
    rConvertDateTimeType       : Smallint;
    rZoomMode                  : Smallint;
    rPromptMode                : Smallint;
    rConvertNullFieldToDefault : Boolean;
    rConvertOtherNullsToDefault : Boolean;
    rAlwaysSortLocally         : Boolean;
    rCaseInsensitiveSQLData    : Boolean;
    rPerformGroupingOnServer   : Boolean;
    rUseIndexForSpeed          : Boolean;
    rVerifyOnEveryPrint        : Boolean;
    rVerifyStoredProcOnRefresh : Boolean;
    rNoDataForHiddenObjects    : Boolean;
    rPrintEngineErrorMessages  : Boolean;
    rSaveDataWithReport        : Boolean;
    rSaveSummariesWithReport   : Boolean;
    rAsyncQuery                : Boolean;
    rCreateGroupTree           : Boolean;
    rIsReadOnly                : Boolean;
    rSelectDistinctRecords     : Boolean;
    rCanSelectDistinctRecords  : Boolean;
    rUseDummyData              : Boolean;
    rRetainImageColourDepth    : Boolean;
  end;

var
  CrpeReportOptionsDlg: TCrpeReportOptionsDlg;
  bReportOptions      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.FormCreate(Sender: TObject);
begin
  bReportOptions := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.FormShow(Sender: TObject);
begin
  {Store current VCL values}
  rSaveDataWithReport := Cr.ReportOptions.SaveDataWithReport;
  rSaveSummariesWithReport := Cr.ReportOptions.SaveSummariesWithReport;
  rUseIndexForSpeed := Cr.ReportOptions.UseIndexForSpeed;
  rConvertNullFieldToDefault := Cr.ReportOptions.ConvertNullFieldToDefault;
  rCaseInsensitiveSQLData := Cr.ReportOptions.CaseInsensitiveSQLData;
  rPrintEngineErrorMessages := Cr.ReportOptions.PrintEngineErrorMessages;
  rVerifyOnEveryPrint := Cr.ReportOptions.VerifyOnEveryPrint;
  rCreateGroupTree := Cr.ReportOptions.CreateGroupTree;
  rNoDataForHiddenObjects := Cr.ReportOptions.NoDataForHiddenObjects;
  rPerformGroupingOnServer := Cr.ReportOptions.PerformGroupingOnServer;
  rConvertDateTimeType := Ord(Cr.ReportOptions.ConvertDateTimeType);
  rZoomMode := Ord(Cr.ReportOptions.ZoomMode);
  rAsyncQuery := Cr.ReportOptions.AsyncQuery;
  rPromptMode := Ord(Cr.ReportOptions.PromptMode);
  rSelectDistinctRecords := Cr.ReportOptions.SelectDistinctRecords;
  rAlwaysSortLocally := Cr.ReportOptions.AlwaysSortLocally;
  rIsReadOnly := Cr.ReportOptions.IsReadOnly;
  rCanSelectDistinctRecords := Cr.ReportOptions.CanSelectDistinctRecords;
  rUseDummyData := Cr.ReportOptions.UseDummyData;
  rConvertOtherNullsToDefault := Cr.ReportOptions.ConvertOtherNullsToDefault;
  rVerifyStoredProcOnRefresh := Cr.ReportOptions.VerifyStoredProcOnRefresh;
  rRetainImageColourDepth := Cr.ReportOptions.RetainImageColourDepth;
  UpdateReportOptions;
end;
{------------------------------------------------------------------------------}
{ UpdateReportOptions procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.UpdateReportOptions;
var
  OnOff : Boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    cbSaveDataWithReport.Checked := Cr.ReportOptions.SaveDataWithReport;
    cbSaveSummariesWithReport.Checked := Cr.ReportOptions.SaveSummariesWithReport;
    cbUseIndexForSpeed.Checked := Cr.ReportOptions.UseIndexForSpeed;
    cbConvertNullFieldToDefault.Checked := Cr.ReportOptions.ConvertNullFieldToDefault;
    cbCaseInsensitiveSQLData.Checked := Cr.ReportOptions.CaseInsensitiveSQLData;
    cbPrintEngineErrorMessages.Checked := Cr.ReportOptions.PrintEngineErrorMessages;
    cbVerifyOnEveryPrint.Checked := Cr.ReportOptions.VerifyOnEveryPrint;
    cbCreateGroupTree.Checked := Cr.ReportOptions.CreateGroupTree;
    cbNoDataForHiddenObjects.Checked := Cr.ReportOptions.NoDataForHiddenObjects;
    cbPerformGroupingOnServer.Checked := Cr.ReportOptions.PerformGroupingOnServer;
    cbConvertDateTimeType.ItemIndex := Ord(Cr.ReportOptions.ConvertDateTimeType);
    cbZoomMode.ItemIndex := Ord(Cr.ReportOptions.ZoomMode);
    cbAsyncQuery.Checked := Cr.ReportOptions.AsyncQuery;
    cbPromptMode.ItemIndex := Ord(Cr.ReportOptions.PromptMode);
    cbSelectDistinctRecords.Checked := Cr.ReportOptions.SelectDistinctRecords;
    cbAlwaysSortLocally.Checked := Cr.ReportOptions.AlwaysSortLocally;
    cbIsReadOnly.Checked := Cr.ReportOptions.IsReadOnly;
    cbCanSelectDistinctRecords.Checked := Cr.ReportOptions.CanSelectDistinctRecords;
    cbUseDummyData.Checked := Cr.ReportOptions.UseDummyData;
    cbConvertOtherNullsToDefault.Checked := Cr.ReportOptions.ConvertOtherNullsToDefault;
    cbVerifyStoredProcOnRefresh.Checked := Cr.ReportOptions.VerifyStoredProcOnRefresh;
    cbRetainImageColorDepth.Checked := Cr.ReportOptions.RetainImageColourDepth;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.InitializeControls(OnOff: boolean);
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
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.btnClearClick(Sender: TObject);
begin
  Cr.ReportOptions.Clear;
  UpdateReportOptions;
end;
{------------------------------------------------------------------------------}
{ btnOKClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ReportOptions.SaveDataWithReport := cbSaveDataWithReport.Checked;
  Cr.ReportOptions.SaveSummariesWithReport := cbSaveSummariesWithReport.Checked;
  Cr.ReportOptions.UseIndexForSpeed := cbUseIndexForSpeed.Checked;
  Cr.ReportOptions.ConvertNullFieldToDefault := cbConvertNullFieldToDefault.Checked;
  Cr.ReportOptions.CaseInsensitiveSQLData := cbCaseInsensitiveSQLData.Checked;
  Cr.ReportOptions.PrintEngineErrorMessages := cbPrintEngineErrorMessages.Checked;
  Cr.ReportOptions.VerifyOnEveryPrint := cbVerifyOnEveryPrint.Checked;
  Cr.ReportOptions.CreateGroupTree := cbCreateGroupTree.Checked;
  Cr.ReportOptions.NoDataForHiddenObjects := cbNoDataForHiddenObjects.Checked;
  Cr.ReportOptions.PerformGroupingOnServer := cbPerformGroupingOnServer.Checked;
  Cr.ReportOptions.ConvertDateTimeType := TCrDateTimeType(cbConvertDateTimeType.ItemIndex);
  Cr.ReportOptions.ZoomMode := TCrZoomPreview(cbZoomMode.ItemIndex);
  Cr.ReportOptions.AsyncQuery := cbAsyncQuery.Checked;
  Cr.ReportOptions.PromptMode := TCrPromptMode(cbPromptMode.ItemIndex);
  Cr.ReportOptions.SelectDistinctRecords := cbSelectDistinctRecords.Checked;
  Cr.ReportOptions.AlwaysSortLocally := cbAlwaysSortLocally.Checked;
  {IsReadOnly is Read-only!}
  {CanSelectDistinctRecords is Read-only}
  Cr.ReportOptions.UseDummyData := cbUseDummyData.Checked;
  Cr.ReportOptions.ConvertOtherNullsToDefault := cbConvertOtherNullsToDefault.Checked;
  Cr.ReportOptions.VerifyStoredProcOnRefresh := cbVerifyStoredProcOnRefresh.Checked;
  Cr.ReportOptions.RetainImageColourDepth := cbRetainImageColorDepth.Checked;
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.btnCancelClick(Sender: TObject);
begin
  {Restore Settings}
  Cr.ReportOptions.SaveDataWithReport := rSaveDataWithReport;
  Cr.ReportOptions.SaveSummariesWithReport := rSaveSummariesWithReport;
  Cr.ReportOptions.UseIndexForSpeed := rUseIndexForSpeed;
  Cr.ReportOptions.ConvertNullFieldToDefault := rConvertNullFieldToDefault;
  Cr.ReportOptions.CaseInsensitiveSQLData := rCaseInsensitiveSQLData;
  Cr.ReportOptions.PrintEngineErrorMessages := rPrintEngineErrorMessages;
  Cr.ReportOptions.VerifyOnEveryPrint := rVerifyOnEveryPrint;
  Cr.ReportOptions.CreateGroupTree := rCreateGroupTree;
  Cr.ReportOptions.NoDataForHiddenObjects := rNoDataForHiddenObjects;
  Cr.ReportOptions.PerformGroupingOnServer := rPerformGroupingOnServer;
  Cr.ReportOptions.ConvertDateTimeType := TCrDateTimeType(rConvertDateTimeType);
  Cr.ReportOptions.ZoomMode := TCrZoomPreview(rZoomMode);
  Cr.ReportOptions.AsyncQuery := rAsyncQuery;
  Cr.ReportOptions.PromptMode := TCrPromptMode(rPromptMode);
  Cr.ReportOptions.SelectDistinctRecords := rSelectDistinctRecords;
  Cr.ReportOptions.AlwaysSortLocally := rAlwaysSortLocally;
  {IsReadOnly is Read-only!}
  {CanSelectDistinctRecords is Read-only}
  Cr.ReportOptions.UseDummyData := rUseDummyData;
  Cr.ReportOptions.ConvertOtherNullsToDefault := rConvertOtherNullsToDefault;
  Cr.ReportOptions.VerifyStoredProcOnRefresh := rVerifyStoredProcOnRefresh;
  Cr.ReportOptions.RetainImageColourDepth := rRetainImageColourDepth;
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bReportOptions := False;
  Release;
end;


end.
