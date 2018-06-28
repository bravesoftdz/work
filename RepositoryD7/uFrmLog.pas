unit uFrmLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,
  siComp, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  DBClient, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ImgList, Buttons;

type
  TFrmLog = class(TFrmParent)
    pnlBottom: TPanel;
    btClose: TcxButton;
    pnlClient: TPanel;
    grdLog: TcxGrid;
    grdLogDBTableView: TcxGridDBTableView;
    grdLogLevel: TcxGridLevel;
    dsLog: TDataSource;
    cdsLog: TClientDataSet;
    cdsLogType: TIntegerField;
    cdsLogMessage: TStringField;
    grdLogDBTableViewType: TcxGridDBColumn;
    grdLogDBTableViewMessage: TcxGridDBColumn;
    imgSmall: TImageList;
    SD: TSaveDialog;
    Panel2: TPanel;
    btnExport: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    FMsgLog: TStringList;
    procedure ClearLog;
    procedure LoadLog;
    procedure ExportGridToExcel;
  public
    procedure Start;
    property MsgLog: TStringList read FMsgLog write FMsgLog;
  end;

implementation

uses cxExportGrid4Link;

{$R *.dfm}

{ TFrmLog }

procedure TFrmLog.Start;
begin
  LoadLog;
  ShowModal;
  ClearLog;
end;

procedure TFrmLog.FormCreate(Sender: TObject);
begin
  inherited;
  FMsgLog := TStringList.Create;
end;

procedure TFrmLog.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FMsgLog);
end;

procedure TFrmLog.ClearLog;
begin
  cdsLog.Close;
end;

procedure TFrmLog.LoadLog;
var
  iIndexLog: Integer;
begin
  cdsLog.CreateDataSet;

  for iIndexLog := 0 to Pred(FMsgLog.Count) do
  begin
    cdsLog.Append;
    cdsLog.FieldByName('Type').Value := 0;
    cdsLog.FieldByName('Message').Value := FMsgLog[iIndexLog];
    cdsLog.Post;
  end;
end;

procedure TFrmLog.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmLog.ExportGridToExcel;
begin
  with SD do
    begin
    
    if Execute then
      If FileName <> '' then
      begin
         if Pos('.xls', LowerCase(FileName)) = 0 then
            FileName := FileName + '.xls';
         ExportGrid4ToExcel(FileName, grdLog, True, True, False);
      end;
    end;
end;

procedure TFrmLog.btnExportClick(Sender: TObject);
begin
  inherited;
  ExportGridToExcel;
end;

end.
