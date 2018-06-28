unit uFrmLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  DBClient, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, StdCtrls,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid,
  cxLookAndFeelPainters, cxButtons;

type
  TFrmLog = class(TForm)
    dsLog: TDataSource;
    grdLogDBTableView: TcxGridDBTableView;
    grdLogLevel: TcxGridLevel;
    grdLog: TcxGrid;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    cbxLogFile: TcxComboBox;
    cdsLogs: TClientDataSet;
    cdsLogsID: TIntegerField;
    cdsLogsMsgError: TStringField;
    cdsLogsDateTime: TDateTimeField;
    grdLogDBTableViewID: TcxGridDBColumn;
    grdLogDBTableViewMsgError: TcxGridDBColumn;
    grdLogDBTableViewDateTime: TcxGridDBColumn;
    lblLog: TLabel;
    btnClose: TcxButton;
    btnEmail: TcxButton;
    procedure cbxLogFilePropertiesChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    procedure LoadLogFile;
  public
    { Public declarations }
  end;

var
  FrmLog: TFrmLog;

implementation

uses uDM;

{$R *.dfm}

procedure TFrmLog.cbxLogFilePropertiesChange(Sender: TObject);
begin
  LoadLogFile;
end;

procedure TFrmLog.LoadLogFile;
begin
  if cdsLogs.Active then
    cdsLogs.Close;
  cdsLogs.LoadFromFile(Application.GetNamePath + cbxLogFile.Text);
end;

procedure TFrmLog.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLog.FormShow(Sender: TObject);
var
  iReturn: Integer;
  SearchRec: TSearchRec;
begin
  cbxLogFile.Properties.Items.Clear;

  iReturn := FindFirst(Application.GetNamePath + '*.xml', faAnyFile, SearchRec);
  try
    while iReturn = 0 do
    begin
      cbxLogFile.Properties.Items.Add(SearchRec.Name);
      iReturn := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;

  if DM.FLastLogFileName <> '' then
    cbxLogFile.Text := DM.FLastLogFileName;
end;

procedure TFrmLog.btnEmailClick(Sender: TObject);
begin
  if cbxLogFile.Text <> '' then
    DM.SendEmailLogText(DM.ECommerceInfo.FURL, 'Log de erro', Application.GetNamePath + cbxLogFile.Text);
end;

end.
