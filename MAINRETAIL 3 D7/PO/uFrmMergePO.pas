unit uFrmMergePO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, ADODB, PowerADOQuery, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

type
  TFrmMergePO = class(TFrmParentAll)
    btnMerge: TButton;
    grdPOSearch: TcxGrid;
    grdPOSearchDB: TcxGridDBTableView;
    grdPOSearchLevel: TcxGridLevel;
    quPOMerge: TPowerADOQuery;
    dsPOMerge: TDataSource;
    quPOMergeIDPO: TIntegerField;
    quPOMergeIDFornecedor: TIntegerField;
    quPOMergeVendor: TStringField;
    quPOMergeDataPedido: TDateTimeField;
    quPOMergeAberto: TBooleanField;
    quPOMergeSubTotal: TBCDField;
    quPOMergeStore: TStringField;
    grdPOSearchDBIDPO: TcxGridDBColumn;
    grdPOSearchDBVendor: TcxGridDBColumn;
    grdPOSearchDBDataPedido: TcxGridDBColumn;
    grdPOSearchDBSubTotal: TcxGridDBColumn;
    grdPOSearchDBStore: TcxGridDBColumn;
    pnlInfo: TPanel;
    lbPOMerge: TLabel;
    lbPOActual: TLabel;
    spRemoveOldPO: TADOStoredProc;
    cmdUpdatePO: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure quPOMergeAfterOpen(DataSet: TDataSet);
  private
    FIDVendor, FIDPOActual, FIDStore : Integer;
    FResult : Boolean;

    procedure OpenPO;
    procedure ClosePO;
    function MergePO : Boolean;

  public
    function Start(AIDVendor, AIDStore, AIDPOActual : Integer) : Boolean;
  end;

implementation

uses uDM;

{$R *.dfm}

{ TFrmMergePO }

function TFrmMergePO.Start(AIDVendor, AIDStore, AIDPOActual: Integer): Boolean;
begin
  FIDVendor := AIDVendor;
  FIDPOActual := AIDPOActual;
  FIDStore := AIDStore;
  FResult := False;
  OpenPO;
  lbPOActual.Caption := IntToStr(FIDPOActual);
  ShowModal;
  Result := FResult;
end;

procedure TFrmMergePO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ClosePO;
  Action := caFree;
end;

procedure TFrmMergePO.btCloseClick(Sender: TObject);
begin
  inherited;
  FResult := False;
  Close;
end;

procedure TFrmMergePO.btnMergeClick(Sender: TObject);
begin
  inherited;
  if MergePO then
  begin
    FResult := True;
    Close;
  end;
end;

procedure TFrmMergePO.ClosePO;
begin

  with quPOMerge do
   if Active then
     Close;

end;

procedure TFrmMergePO.OpenPO;
begin

  with quPOMerge do
   if not Active then
   begin
     Parameters.ParamByName('IDFornecedor').Value := FIDVendor;
     Parameters.ParamByName('IDPOActual').Value   := FIDPOActual;
     Parameters.ParamByName('IDStore').Value      := FIDStore;
     Open;
   end;

end;

procedure TFrmMergePO.quPOMergeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnMerge.Enabled := (not quPOMerge.IsEmpty);
end;

function TFrmMergePO.MergePO : Boolean;
begin

  if quPOMerge.Active and (quPOMergeIDPO.AsString <> '') then
  begin

    DM.ADODBConnect.BeginTrans;
    try
      with cmdUpdatePO do
      begin
        Parameters.ParamByName('IDPOActual').Value := FIDPOActual;
        Parameters.ParamByName('IDPOOld').Value    := quPOMergeIDPO.AsInteger;
        Execute;
      end;

      with spRemoveOldPO do
      begin
        Parameters.ParamByName('@IDPO').Value := quPOMergeIDPO.AsInteger;
        ExecProc;
      end;

      DM.ADODBConnect.CommitTrans;
      Result := True;
    except
      DM.ADODBConnect.RollbackTrans;
      Result := False;
      raise;
      end;

  end;

end;

end.
