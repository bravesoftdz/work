unit uMainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxBar, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMemo, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  Provider, DBClient, ComCtrls;

type
  TMainFrm = class(TForm)
    bmMain: TdxBarManager;
    bbRun: TdxBarButton;
    cdsResult: TClientDataSet;
    dsResult: TDataSource;
    dspResult: TDataSetProvider;
    ADOConn: TADOConnection;
    qryResult: TADODataSet;
    bbConfigConn: TdxBarButton;
    cmdScript: TADOCommand;
    pcMain: TPageControl;
    tsSelect: TTabSheet;
    grdResult: TcxGrid;
    grdResultDBTableView: TcxGridDBTableView;
    grdResultLevel: TcxGridLevel;
    spMain: TSplitter;
    mmQuery: TcxMemo;
    tsExecute: TTabSheet;
    mmExecute: TcxMemo;
    procedure bbRunClick(Sender: TObject);
    procedure bbConfigConnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AddColumnsToGrid;
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}

uses uStringFunctions, uConfigConnFrm;

procedure TMainFrm.bbRunClick(Sender: TObject);
begin
  if pcMain.ActivePage = tsSelect then
  begin
    qryResult.CommandText := mmQuery.Text;
    cdsResult.Close;
    cdsResult.Open;
    AddColumnsToGrid;
  end
  else if pcMain.ActivePage = tsExecute then
  begin
    cmdScript.CommandText := mmExecute.Text;
    cmdScript.Execute;
  end;
end;

procedure TMainFrm.AddColumnsToGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
begin
  grdResultDBTableView.ClearItems;
  for i := 0 to (cdsResult.Fields.Count - 1) do
  begin
    NewColumn := grdResultDBTableView.CreateColumn;
    with NewColumn do
    begin
      Caption := cdsResult.FieldDefs[i].DisplayName;
      DataBinding.FieldName := cdsResult.FieldDefs[i].Name;
    end;
  end;
end;

procedure TMainFrm.bbConfigConnClick(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  bbConfigConnClick(Sender);
end;

end.
