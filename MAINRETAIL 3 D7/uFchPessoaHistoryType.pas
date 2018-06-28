unit uFchPessoaHistoryType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFchPessoaHistoryType = class(TbrwFrmParent)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    quFormIDPessoaHistoryType: TIntegerField;
    quFormPessoaHistoryType: TStringField;
    lbHasBairro: TLabel;
    pnlHistoryAdd: TPanel;
    btnHistoryAdd: TSpeedButton;
    btnResultDelete: TSpeedButton;
    grdTypeResult: TcxGrid;
    grdTypeResultDB: TcxGridDBTableView;
    grdTypeResultLevel: TcxGridLevel;
    dsTrypeResult: TDataSource;
    quTypeResult: TADODataSet;
    quTypeResultIDPessoaHistoryResult: TIntegerField;
    quTypeResultIDPessoaHistoryType: TIntegerField;
    quTypeResultPessoaHistoryResult: TStringField;
    quTypeResultResultColor: TStringField;
    grdTypeResultDBPessoaHistoryResult: TcxGridDBColumn;
    grdTypeResultDBResultColor: TcxGridDBColumn;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure btnResultDeleteClick(Sender: TObject);
    procedure btnHistoryAddClick(Sender: TObject);
    procedure grdTypeResultDBPessoaHistoryResultCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    procedure ResultRefresh;
    procedure ResultClose;
    procedure ResultOpen;
    procedure ResultDelete;

    function ValidateDeletion : boolean;
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal, uDM, uFrmPessoaHistoryTypeResult, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFchPessoaHistoryType }

procedure TFchPessoaHistoryType.ResultClose;
begin
  with quTypeResult do
    if Active then
      Close;
end;

procedure TFchPessoaHistoryType.ResultOpen;
begin
  with quTypeResult do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoaHistoryType').Value := quFormIDPessoaHistoryType.AsInteger;
      Open;
    end;
end;

procedure TFchPessoaHistoryType.ResultRefresh;
begin
  ResultClose;
  ResultOpen;
end;

procedure TFchPessoaHistoryType.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ResultRefresh;
end;

procedure TFchPessoaHistoryType.btnResultDeleteClick(Sender: TObject);
begin
  inherited;
  if ValidateDeletion then
    ResultDelete;
end;

procedure TFchPessoaHistoryType.ResultDelete;
begin

  with quTypeResult do
    if Active and (RecordCount > 0) then
    begin
    Edit;
    Delete;
    ResultRefresh;
    end;

end;

procedure TFchPessoaHistoryType.btnHistoryAddClick(Sender: TObject);
begin
  inherited;
  with TFrmPessoaHistoryTypeResult.Create(Self) do
    if Start(quFormIDPessoaHistoryType.AsInteger) then
      ResultRefresh;
end;

procedure TFchPessoaHistoryType.grdTypeResultDBPessoaHistoryResultCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  //ACanvas.Canvas.Brush.Color := StringToColor(quTypeResultResultColor.AsString);   
end;


function TFchPessoaHistoryType.ValidateDeletion: boolean;
begin

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('Select IDPessoaHistory from Mnt_PessoaHistory where IDPessoaHistoryResult = ' + quTypeResultIDPessoaHistoryResult.AsString);
    try
     Open;
     Result := IsEmpty;
     if not Result then
       MsgBox(MSG_CRT_NO_DEL_RECORD, vbOKOnly + vbCritical);
    finally
      Close;
    end;
  end;


end;

end.
