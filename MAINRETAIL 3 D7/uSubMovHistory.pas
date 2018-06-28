unit uSubMovHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, StdCtrls, DateBox, Mask, uFrmMovNotes,
  SuperComboADO, Buttons, ExtCtrls, ADODB, Grids, DBGrids, SMDBGrid, DB,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid;

type
  TSubMovHistory = class(TParentSub)
    Panel1: TPanel;
    Label34: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    btnExec: TSpeedButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    btAreaTodas: TButton;
    quMovHistory: TADODataSet;
    dsMovHistory: TDataSource;
    cmbStoreMov: TcxLookupComboBox;
    grdMovHistDBTableView: TcxGridDBTableView;
    grdMovHistLevel: TcxGridLevel;
    grdMovHist: TcxGrid;
    grdMovHistDBTableViewName: TcxGridDBColumn;
    grdMovHistDBTableViewDocumentID: TcxGridDBColumn;
    grdMovHistDBTableViewMovDate: TcxGridDBColumn;
    grdMovHistDBTableViewSalePrice: TcxGridDBColumn;
    grdMovHistDBTableViewCostPrice: TcxGridDBColumn;
    grdMovHistDBTableViewSystemUser: TcxGridDBColumn;
    grdMovHistDBTableViewStore: TcxGridDBColumn;
    grdMovHistDBTableViewQty: TcxGridDBColumn;
    grdStyle: TcxStyleRepository;
    DefaultStyle: TcxStyle;
    grdMovHistDBTableViewAvgCostOut: TcxGridDBColumn;
    grdMovHistDBTableViewBalanceTotal: TcxGridDBColumn;
    quBalanceOpen: TADODataSet;
    quBalanceOpenValue: TFloatField;
    quMovHistoryName: TStringField;
    quMovHistoryDocumentID: TIntegerField;
    quMovHistoryMovDate: TDateTimeField;
    quMovHistoryQty: TFloatField;
    quMovHistorySalePrice: TFloatField;
    quMovHistoryIDInventoryMov: TIntegerField;
    quMovHistorySystem: TBooleanField;
    quMovHistoryCostPrice: TBCDField;
    quMovHistorySystemUser: TStringField;
    quMovHistoryStore: TStringField;
    quMovHistoryAvgCostOut: TBCDField;
    quMovHistoryBalanceQty: TFloatField;
    quMovHistoryBalanceTotal: TBCDField;
    quMovHistoryBalance: TFloatField;
    grdMovHistDBTableViewBalance: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure cmbStoreMovEnter(Sender: TObject);
    procedure cmbStoreMovPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMovHistDBTableViewDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quMovHistoryAfterOpen(DataSet: TDataSet);
    procedure quMovHistoryCalcFields(DataSet: TDataSet);
    procedure btnExecClick(Sender: TObject);
  private
    FIDModel: Integer;
    FIDStore: Integer;
    slIDInvMov: TStringList;
    slBalance: TStringList;
    FrmMovNotes: TFrmMovNotes;

    procedure NotesLoadFicha;
    procedure NotesFreeFicha;
    procedure HistoryRefresh;
  protected
    procedure AfterSetParam; override;
  end;

implementation

uses uDM, uParamFunctions, uNumericFunctions, uSystemConst, DateUtils, uSqlFunctions;

{$R *.dfm}

procedure TSubMovHistory.AfterSetParam;
begin
  FIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
  FIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
  HistoryRefresh;
end;

procedure TSubMovHistory.HistoryRefresh;
var
  sSQL : String;
begin
  if (FIDModel = 0) and (FIDStore = 0) then
    Exit;

  Screen.Cursor := crHourGlass;

  with quMovHistory do
  begin
    if Active then
      Close;

    sSQL := 'SELECT ' +
            '  MH.Name, ' +
            '  MH.DocumentID, ' +
            '  MH.MovDate, ' +
            '  MH.Qty, ' +
            '  MH.SalePrice, ' +
            '  MH.IDInventoryMov, ' +
            '  MH.System, ' +
            '  MH.CostPrice, ' +
            '  MH.AvgCost, ' +
            '  MH.SystemUser, ' +
            '  MH.Store, ' +
            '  MB.AvgCostOut, ' +
            '  MB.Qty as BalanceQty, ' +
            '  MB.BalanceTotal, ' +
            '  cast(0 as Float) Balance ' +
            'FROM ' +
            '  vwModelHistoryMov MH (NOLOCK) ' +
            '  LEFT JOIN Inv_ModelBalance MB (NOLOCK) ON (MH.ModelID = MB.IDModel AND dbo.fn_Sys_RemoveTime(MH.MovDate) = MB.BalanceDate) ' +
            'WHERE ' +
            '  ModelID = ' + InttoStr(fIDModel);

    //Store
    if fIDStore <> 0 then
    begin
      sSQL := sSQL + ' AND StoreID = ' + IntTostr(fIDStore);
    end
    else
      sSQL := sSQL + ' AND StoreID IN (' + DM.fStore.StoreList + ')';

      sSQL := sSQL + ' AND  MovDate >= ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(DateInicio.Date)) );
      sSQL := sSQL + ' AND  MovDate < '  + QuotedStr( FormatDateTime('mm/dd/yyyy',(DateFim.Date+1)) );

      sSQL := sSQL + ' ORDER BY MovDate DESC';

      CommandText := sSQL;

      Open;
      Requery;
    end;

  Screen.Cursor := crDefault;
end;

procedure TSubMovHistory.FormDestroy(Sender: TObject);
begin

  DM.SaveGridToRegistry(TcxGridDBTableView(grdMovHistDBTableView), MR_BRW_REG_PATH + 'Sub - Mov_History', True, []);
  NotesFreeFicha;
  DM.quLookUpStore.Close;
  quMovHistory.Close;

  if Assigned(slIDInvMov) then
    FreeAndNil(slIDInvMov);

  if Assigned(slBalance) then
    FreeAndNil(slBalance);

  inherited;
  
end;

procedure TSubMovHistory.NotesLoadFicha;
begin
  if FrmMovNotes = nil then
    FrmMovNotes := TFrmMovNotes.Create(self);
end;

procedure TSubMovHistory.NotesFreeFicha;
begin
  if FrmMovNotes <> nil then
    FrmMovNotes.Free;
end;

procedure TSubMovHistory.btAreaTodasClick(Sender: TObject);
begin
  inherited;
  DM.quLookUpStore.Close;
  fIDStore := 0;
  HistoryRefresh;
end;

procedure TSubMovHistory.cmbStoreMovEnter(Sender: TObject);
begin
  inherited;
  with DM.quLookUpStore do
    if not Active then
      Open;
end;

procedure TSubMovHistory.cmbStoreMovPropertiesChange(Sender: TObject);
begin
  inherited;
  with DM.quLookUpStore do
    if Active then
      if DM.quLookUpStore.Locate('Name', cmbStoreMov.Text, []) then
        fIDStore := DM.quLookUpStoreIDStore.AsInteger;

  HistoryRefresh;
end;

procedure TSubMovHistory.FormShow(Sender: TObject);
begin
  inherited;
  DateInicio.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  DateFim.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));
end;

procedure TSubMovHistory.grdMovHistDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  NotesLoadFicha;
  FrmMovNotes.Start(quMovHistoryIDInventoryMov.AsInteger);
end;

procedure TSubMovHistory.FormCreate(Sender: TObject);
var
  sSQL, sWhere : String;
begin
  inherited;
  //Set as datas para o Inv Mov.
  slIDInvMov := TStringList.Create;
  slBalance := TStringList.Create;

  DM.LoadGridFromRegistry(TcxGridDBTableView(grdMovHistDBTableView), MR_BRW_REG_PATH + 'Sub - Mov_History', []);

  DM.quLookUpStore.Close;
  sWhere := ' Desativado = 0 AND IDStore <> 0 ';
  if DM.fStore.StoreList <> '' then
    sWhere := sWhere + ' AND IDStore IN (' + DM.fStore.StoreList + ')';
  sSQL := ChangeWhereClause(DM.quLookUpStore.CommandText, sWhere, True);
  DM.quLookUpStore.CommandText := sSQL;

end;

procedure TSubMovHistory.quMovHistoryAfterOpen(DataSet: TDataSet);
var
  Bal: Double;
begin
  inherited;
  // Vou precorendo o dataset e calculando o balance

  slIDInvMov.Clear;
  slBalance.Clear;

  // Pego o saldo inicial
  with quBalanceOpen do
  begin
    Close;

    Parameters.ParamByName('IDModel').Value := fIDModel;

    if (fIDStore <> 0) then
      Parameters.ParamByName('IDStore').Value := fIDStore
    else
      Parameters.ParamByName('IDStore').Value := Null;

    Parameters.ParamByName('OpenDate').Value := DateInicio.Date;

    Open;
    Bal := FieldByName('Value').AsFloat;
    Close;
  end;

  with quMovHistory do
  begin
    try
      DisableControls;
      Last;

      while not BOF do
      begin
        Bal := Bal + quMovHistoryQty.AsFloat;

        slIDInvMov.Add( quMovHistoryIDInventoryMov.AsString );
        slBalance.Add( FormatFloat('0.#####',Bal) );

        Prior;
      end;
    finally
      First;
      EnableControls;
    end;
  end;
end;

procedure TSubMovHistory.quMovHistoryCalcFields(DataSet: TDataSet);
var
  i: integer;
begin
  inherited;
  i := slIDInvMov.IndexOf(quMovHistoryIDInventoryMov.AsString);
  if i <> -1 then
    quMovHistoryBalance.AsFloat := MyStrToFloat(slBalance.Strings[i]);
end;

procedure TSubMovHistory.btnExecClick(Sender: TObject);
begin
  inherited;
  HistoryRefresh;
end;

initialization
   RegisterClass(TSubMovHistory);

end.
