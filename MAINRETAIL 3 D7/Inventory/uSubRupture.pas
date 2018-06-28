unit uSubRupture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, ADODB, Buttons,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Provider, DBClient, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, uSystemConst;

type
  TSubRupture = class(TParentSub)
    grdRupture: TcxGrid;
    grdRuptureDB: TcxGridDBTableView;
    grdRuptureLevel: TcxGridLevel;
    Panel1: TPanel;
    btPrint: TSpeedButton;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    pnlDivisoria2: TPanel;
    qryRuptura: TADODataSet;
    dsRupture: TDataSource;
    grdRuptureDBIDModel: TcxGridDBColumn;
    grdRuptureDBModel: TcxGridDBColumn;
    grdRuptureDBDescription: TcxGridDBColumn;
    grdRuptureDBInitialQty: TcxGridDBColumn;
    grdRuptureDBNumDaysZeroSupply: TcxGridDBColumn;
    grdRuptureDBGiro: TcxGridDBColumn;
    qryMovimento: TADODataSet;
    qryGiro: TADODataSet;
    qryGiroBalanceQty: TFloatField;
    qryMovimentoMovDate: TDateTimeField;
    qryMovimentoQty: TFloatField;
    cdsRuptura: TClientDataSet;
    dspRuptura: TDataSetProvider;
    grdRuptureDBLostRevenue: TcxGridDBColumn;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    grdRuptureDBVendor: TcxGridDBColumn;
    grdRuptureDBSalePrice: TcxGridDBColumn;
    grdRuptureDBVendorCost: TcxGridDBColumn;
    grdRuptureDBNetProfit: TcxGridDBColumn;
    grdRuptureDBFinalQty: TcxGridDBColumn;
    qryImposto: TADODataSet;
    qryEncargos: TADODataSet;
    qryImpostoTax: TBCDField;
    qryEncargosTax: TBCDField;
    qryRupturaIDModel: TIntegerField;
    qryRupturaSellingPrice: TBCDField;
    qryRupturaModel: TStringField;
    qryRupturaDescription: TStringField;
    qryRupturaVendorCost: TBCDField;
    qryRupturaIDGroup: TIntegerField;
    qryRupturaPessoa: TStringField;
    qryRupturaNumDiasRuptura: TIntegerField;
    qryRupturaGiro: TFloatField;
    qryRupturaRuptura: TBCDField;
    qryRupturaQtdFinal: TFloatField;
    qryRupturaLucro: TBCDField;
    qryRupturaTax: TBCDField;
    cdsRupturaIDModel: TIntegerField;
    cdsRupturaSellingPrice: TBCDField;
    cdsRupturaModel: TStringField;
    cdsRupturaDescription: TStringField;
    cdsRupturaVendorCost: TBCDField;
    cdsRupturaIDGroup: TIntegerField;
    cdsRupturaPessoa: TStringField;
    cdsRupturaNumDiasRuptura: TIntegerField;
    cdsRupturaGiro: TFloatField;
    cdsRupturaRuptura: TBCDField;
    cdsRupturaQtdFinal: TFloatField;
    cdsRupturaLucro: TBCDField;
    cdsRupturaTax: TBCDField;
    grdRuptureDBTax: TcxGridDBColumn;
    qtyBalance: TADODataSet;
    FloatField1: TFloatField;
    qryRupturaBalance: TFloatField;
    cdsRupturaBalance: TFloatField;
    procedure btPrintClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure grdRuptureDBCustomization(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDateIni: TDateTime;
    FDateEnd: TDateTime;
    FIDStore: Integer;
    AView : TcxCustomGridTableView;
    fRegistryPath : String;
    AOptions: TcxGridStorageOptions;

    procedure GetGiroAndBalance;
    procedure GetMovimento;

    function GetTax(AIDCategory, AIDStore: Integer):Double;
  protected
    procedure AfterSetParam; override;
  public
    procedure DataSetOpen; override;
    procedure DataSetClose; override;

    procedure Start;
  end;

implementation

uses uDM, uParamFunctions, DateUtils, uMsgBox, uMsgConstant, uFrmExport, cxExportGrid4Link;

{$R *.dfm}

{ TSubRupture }

procedure TSubRupture.AfterSetParam;
begin
  inherited;
  if FParam <> '' then
  begin
    FDateIni := StrToDateTime(ParseParam(FParam, 'DateIni'));
    FDateEnd := StrToDateTime(ParseParam(FParam, 'DateEnd'));
    FIDStore := StrToInt(ParseParam(FParam, 'IDStore'));

   //Open DataSet
   try
     Screen.Cursor := crHourGlass;
     DataSetOpen;
   finally
     Screen.Cursor := crDefault;
     end;
  end;
end;

procedure TSubRupture.DataSetClose;
begin
  inherited;
  with cdsRuptura do
    if Active then
      Close;
end;

procedure TSubRupture.DataSetOpen;
begin
  inherited;
  with cdsRuptura do
  try
    DisableControls;
    DataSetClose;

    Params.ParamByName('DataInicio').Value := FDateIni;
    Params.ParamByName('IDStore1').Value    := FIDStore;
    Params.ParamByName('IDStore2').Value    := FIDStore;
    Open;

    GetGiroAndBalance;
    GetMovimento;
  finally
    EnableControls;
  end;
end;

procedure TSubRupture.GetGiroAndBalance;
var
  dGiro, dBalance : Double;
begin
  with cdsRuptura do
  begin
    First;
    while not Eof do
    begin
      try
        if qryGiro.Active then
          qryGiro.Close;
        qryGiro.Parameters.ParamByName('IDModel').Value     := FieldByName('IDModel').Value;
        qryGiro.Parameters.ParamByName('DataInicial').Value := FDateIni;
        qryGiro.Parameters.ParamByName('DataFinal').Value   := FDateEnd;
        qryGiro.Parameters.ParamByName('IDStore1').Value    := FIDStore;
        qryGiro.Parameters.ParamByName('IDStore2').Value    := FIDStore;
        qryGiro.Open;
        dGiro := qryGiro.FieldByName('BalanceQty').AsFloat;
      finally
        qryGiro.Close;
      end;

      try
        if qtyBalance.Active then
          qtyBalance.Close;
        qtyBalance.Parameters.ParamByName('IDModel').Value     := FieldByName('IDModel').Value;
        qtyBalance.Parameters.ParamByName('DataInicial').Value := FDateIni;
        qtyBalance.Parameters.ParamByName('IDStore1').Value    := FIDStore;
        qtyBalance.Parameters.ParamByName('IDStore2').Value    := FIDStore;
        qtyBalance.Open;
        dBalance := qtyBalance.FieldByName('BalanceQty').AsFloat;
      finally
        qryGiro.Close;
      end;

      Edit;
      FieldByName('Giro').AsFloat    := (dGiro / DaysBetween(FDateIni, FDateEnd));
      FieldByName('Balance').AsFloat := dBalance;
      Post;
      Next;
    end;
  end;
end;

procedure TSubRupture.GetMovimento;
var
  LastDate: TDateTime;
  cValorPerdido : Currency;
begin
  with cdsRuptura do
  begin
    First;
    while not Eof do
    try
      if FieldByName('Giro').AsFloat > 0 then
      begin
        Edit;
        FieldByName('QtdFinal').AsFloat := FieldByName('Balance').AsFloat;

        if qryMovimento.Active then
          qryMovimento.Close;
        qryMovimento.Parameters.ParamByName('IDModel').Value     := FieldByName('IDModel').AsInteger;
        qryMovimento.Parameters.ParamByName('DataInicial').Value := FDateIni;
        qryMovimento.Parameters.ParamByName('DataFinal').Value   := FDateEnd;
        qryMovimento.Parameters.ParamByName('IDStore1').Value    := FIDStore;
        qryMovimento.Parameters.ParamByName('IDStore2').Value    := FIDStore;
        qryMovimento.Open;

        if not qryMovimento.IsEmpty then
        begin

          qryMovimento.First;
          LastDate := qryMovimento.FieldByName('MovDate').AsDateTime;
          while not qryMovimento.Eof do
          begin
            if FieldByName('QtdFinal').AsFloat <= 0 then
              FieldByName('NumDiasRuptura').AsInteger := FieldByName('NumDiasRuptura').AsInteger + DaysBetween(qryMovimento.FieldByName('MovDate').AsDateTime, LastDate);

            FieldByName('QtdFinal').AsFloat := FieldByName('QtdFinal').AsFloat + qryMovimento.FieldByName('Qty').AsFloat;
            LastDate := qryMovimento.FieldByName('MovDate').AsDateTime;
            qryMovimento.Next;
          end;
          FieldByName('Ruptura').AsCurrency :=  (FieldByName('SellingPrice').AsCurrency * FieldByName('Giro').AsFloat) * FieldByName('NumDiasRuptura').AsInteger;

          FieldByName('Tax').AsCurrency := (GetTax(FieldByName('IDGroup').AsInteger, FIDStore)/100) * FieldByName('SellingPrice').AsCurrency;

          if FieldByName('Ruptura').AsCurrency > 0 then
            if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
              FieldByName('Lucro').AsCurrency := (FieldByName('SellingPrice').AsCurrency - FieldByName('VendorCost').AsCurrency - FieldByName('Tax').AsCurrency) * (FieldByName('Giro').AsFloat * FieldByName('NumDiasRuptura').AsInteger)
            else
              FieldByName('Lucro').AsCurrency := (FieldByName('SellingPrice').AsCurrency - FieldByName('VendorCost').AsCurrency * FieldByName('Giro').AsFloat) * FieldByName('NumDiasRuptura').AsInteger;
          Post;
        end;

        if FieldByName('NumDiasRuptura').AsInteger > 0 then
          Next
        else
          Delete;
      end
      else
        Delete;
    except
      on E:Exception do
        MsgBox('Error: '+ E.Message, vbCritical + vbOKOnly);
    end;
  end;
end;

procedure TSubRupture.btPrintClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.Caption := '';
  gridPrinter.Preview(True, nil);
end;

procedure TSubRupture.btExcelClick(Sender: TObject);
begin
  inherited;
 If (not cdsRuptura.Active) or (cdsRuptura.RecordCount = 0) then
    begin
      MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
      Exit;
    end;

 with TFrmExport.Create(Self) do
    Start(grdRupture, ParseParam(FParam, 'Title'));
end;

procedure TSubRupture.btGroupClick(Sender: TObject);
begin
  inherited;
  if btGroup.Down then
  begin
    TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).OptionsView.GroupByBox := True;
  end
  else
  begin
    with grdRupture do
    begin
      // Retiro todos os grupos
      while TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).GroupedItemCount > 0 do
        TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).GroupedColumns[TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).GroupedItemCount-1].GroupIndex :=-1;
      TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).OptionsView.GroupByBox := False;
    end;
  end;
end;

procedure TSubRupture.btColumnClick(Sender: TObject);
begin
  inherited;
  // Mostra a coluna de customizing do grid
  if btColumn.Down then
  begin
    TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).Controller.Customization := True;
  end
  else
  begin
    TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).Controller.Customization := False;
  end;
end;

procedure TSubRupture.grdRuptureDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(TcxCustomGridTableView(grdRupture.FocusedView)).Controller.Customization;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

function TSubRupture.GetTax(AIDCategory, AIDStore: Integer): Double;
var
  iIDStore: Integer;
begin
  iIDStore := AIDStore;

  if iIDStore = 0 then
    iIDStore := DM.fStore.IDDefault;

  with qryImposto do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDStore').Value := iIDStore;
    Parameters.ParamByName('IDGroup').Value  := cdsRuptura.FieldByName('IDGroup').AsInteger;
    Open;

    Result := FieldByName('Tax').AsFloat;
    Close;
  end;

  with qryEncargos do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDStore').Value := iIDStore;
    Parameters.ParamByName('IDGroup').Value  := cdsRuptura.FieldByName('IDGroup').AsInteger;
    Open;

    Result := Result + FieldByName('Tax').AsFloat;
    Close;
  end;

end;

procedure TSubRupture.FormShow(Sender: TObject);
begin
  inherited;
  Start;
  grdRuptureDBTax.Visible := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
end;

procedure TSubRupture.Start;
var
  ASaveViewName: String;
begin
  AView := TcxCustomGridTableView(grdRupture.FocusedView);

  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);
end;

procedure TSubRupture.FormDestroy(Sender: TObject);
begin
  inherited;
  DataSetClose;
end;

initialization
   RegisterClass(TSubRupture);

end.
