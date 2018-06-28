unit uSubBestSeller;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, cxStyles, cxCustomData, 
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, ADODB, ExtCtrls,
  Buttons, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk;

const
  TempTableName  = '#Ret_ReportSource';
  TempTableName2 = '#Ret_ReportPurchase';

type
  TSubBestSeller = class(TParentSub)
    quBestSeller: TADODataSet;
    dsBestSeller: TDataSource;
    quTempTable: TADOCommand;
    quBestSellerModel: TStringField;
    quBestSellerDescription: TStringField;
    quBestSellerFreight: TBCDField;
    quBestSellerOtherCost: TBCDField;
    quBestSellerLastPurchaseDate: TDateTimeField;
    quBestSellerMarkUp: TBCDField;
    quBestSellerOurPrice: TBCDField;
    quBestSellerMSRP: TBCDField;
    quBestSellerLastMovDate: TDateTimeField;
    quBestSellerAvgCost: TBCDField;
    quBestSellerNetCost: TBCDField;
    quBestSellerLastSaleDate: TDateTimeField;
    quBestSellerCategory: TStringField;
    quBestSellerProfit: TBCDField;
    quBestSellerPercents: TBCDField;
    quBestSellerAccProfitPerc: TBCDField;
    Panel1: TPanel;
    grdBestSeller: TcxGrid;
    grdBestSellerDB: TcxGridDBTableView;
    grdBestSellerDBModel: TcxGridDBColumn;
    grdBestSellerDBDescription: TcxGridDBColumn;
    grdBestSellerDBCategory: TcxGridDBColumn;
    grdBestSellerDBQtySold: TcxGridDBColumn;
    grdBestSellerDBProfit: TcxGridDBColumn;
    grdBestSellerDBLastSaleDate: TcxGridDBColumn;
    grdBestSellerDBPercents: TcxGridDBColumn;
    grdBestSellerDBTotQtyOnHand: TcxGridDBColumn;
    grdBestSellerDBVendorCost: TcxGridDBColumn;
    grdBestSellerDBAvgCost: TcxGridDBColumn;
    grdBestSellerDBNetCost: TcxGridDBColumn;
    grdBestSellerDBOurPrice: TcxGridDBColumn;
    grdBestSellerDBAccProfitPerc: TcxGridDBColumn;
    grdBestSellerDBFreight: TcxGridDBColumn;
    grdBestSellerDBOtherCost: TcxGridDBColumn;
    grdBestSellerDBLastPurchaseDate: TcxGridDBColumn;
    grdBestSellerDBMarkUp: TcxGridDBColumn;
    grdBestSellerDBMSRP: TcxGridDBColumn;
    grdBestSellerDBLastMovDate: TcxGridDBColumn;
    grdBestSellerLevel: TcxGridLevel;
    btPrint: TSpeedButton;
    btExcel: TSpeedButton;
    pnlDivisoria2: TPanel;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    quTempPurchaseTime: TADOCommand;
    quBestSellerStokeTurnOver: TCurrencyField;
    grdBestSellerDBDBStokeTurnOver: TcxGridDBColumn;
    quBestSellerVendorCost: TCurrencyField;
    quBestSellerVCost: TBCDField;
    quBestSellerReplacementCost: TBCDField;
    quBestSellerClassification: TStringField;
    grdBestSellerDBClassification: TcxGridDBColumn;
    quBestSellerTotQtyOnHand: TFloatField;
    quBestSellerQtySold: TFloatField;
    quTotalSales: TADODataSet;
    quBestSellerVendor: TStringField;
    grdBestSellerDBVendor: TcxGridDBColumn;
    quBestSellerTotalSold: TBCDField;
    grdBestSellerDBTotalSold: TcxGridDBColumn;
    btnFilter: TSpeedButton;
    quBestSellerColor: TStringField;
    quBestSellerSizeName: TStringField;
    grdBestSellerDBColor: TcxGridDBColumn;
    grdBestSellerDBSizeName: TcxGridDBColumn;
    quBestSellerSubCategory: TStringField;
    quBestSellerMGroup: TStringField;
    grdBestSellerDBMGroup: TcxGridDBColumn;
    grdBestSellerDBSubCategory: TcxGridDBColumn;
    quBestSellerTotalCostSold: TBCDField;
    grdBestSellerDBTotalCostSold: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure grdBestSellerDBCustomization(Sender: TObject);
    procedure quBestSellerCalcFields(DataSet: TDataSet);
    procedure btnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fIDStore    : Integer;
    fIDCategory : Integer;
    fDateIni,
    fDateEnd    : TDateTime;
    fTotalSales : Currency;
    SaleWhere   : String;

    fRegistryPath : String;
    AView    : TcxCustomGridTableView;
    AOptions: TcxGridStorageOptions;

    function GetTotalSale : String;
    function DropTempTable(sTable:String):Boolean;
    function CreateTempTable:boolean;
  protected
    procedure AfterSetParam; override;
  public
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, uFrmExport, uMsgBox, uMsgConstant, DateUtils,
     uSystemConst, uNumericFunctions;

{$R *.dfm}

function TSubBestSeller.CreateTempTable: boolean;
var
  iRecordsAffected : Integer;
  sSQL             : String;
  GetWhereClause : String;
begin

  Result := True;

  DropTempTable(TempTableName);
  DropTempTable(TempTableName2);

  if TempTableName <> '' then
     try

       if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
          begin
          GetWhereClause := ' (C.PreSaleDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateIni)) +
                            ' AND C.PreSaleDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateEnd)) + ') ';

          if fIDStore <> 0 then
             GetWhereClause := GetWhereClause + ' AND I.IDStore = ' + IntToStr(fIDStore);

          SaleWhere  := GetWhereClause;

           sSQL := ' SELECT I.DocumentID, C.IDPreInventoryMov as IDInventoryMov, I.IDInvoice '+
                   ' INTO ' + TempTableName +
                   ' FROM vwInvoiceParents I (NOLOCK) ' +
                   ' JOIN Media ME (NOLOCK) ON (I.MediaID = ME.IDMedia) '+
                   ' JOIN vwSaleItem C (NOLOCK) ON (I.DocumentID = C.IDPreSale AND C.InventMovTypeID = 1 ) ' +
                   ' JOIN Pessoa P (NOLOCK) ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
                   ' JOIN Model M (NOLOCK) ON (C.ModelID = M.IDModel) ' +
                   ' JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) '+
                   ' WHERE ' + GetWhereClause +
                   ' GROUP BY I.DocumentID, C.IDPreInventoryMov, I.IDInvoice';

          end
       else
          begin
          GetWhereClause := ' I.IDInvoice IS NOT NULL ' +
                            ' AND (IMV.MovDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateIni)) +
                            ' AND IMV.MovDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateEnd)) + ') ';

          if fIDStore <> 0 then
             GetWhereClause := GetWhereClause + ' AND I.IDStore = ' + IntToStr(fIDStore);

          SaleWhere  := GetWhereClause;

           sSQL := ' SELECT I.IDPreSale, IMV.IDInventoryMov, I.IDInvoice '+
                   ' INTO ' + TempTableName +
                   ' FROM Invoice I (NOLOCK) ' +
                   ' LEFT OUTER JOIN Media ME (NOLOCK) ON (I.MediaID = ME.IDMedia) '+
                   ' LEFT OUTER JOIN InventoryMov IMV (NOLOCK) ON (I.IDInvoice = IMV.DocumentID AND IMV.InventMovTypeID=1) ' +
                   ' LEFT OUTER JOIN Model M (NOLOCK) ON (IMV.ModelID = M.IDModel) ' +
                   ' LEFT OUTER JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'+
                   ' WHERE ' + GetWhereClause +
                   ' GROUP BY I.IDPreSale, IMV.IDInventoryMov, I.IDInvoice';
          end;

     with quTempTable do
        begin
        CommandText := sSQL;
        //GetWhereClause := CommandText;
        Execute(iRecordsAffected,eoAsyncExecute);
        //if iRecordsAffected = 0 then
           //MsgBox(MSG_INF_NO_DATA_FOUND, vbOKOnly + vbInformation);
        end;

      except
          Result := False;
      end;

   if not Result then
      Exit;

  grdBestSellerDBDBStokeTurnOver.Visible := (not DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE]);

  //Purchase
  if (TempTableName2 <> '') then
     try
       GetWhereClause := ' IMV.InventMovTypeID = 2 ' +
                         ' AND (IMV.MovDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateIni)) +
                         ' AND IMV.MovDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateEnd)) + ') ';

       if fIDStore <> 0 then
          GetWhereClause := GetWhereClause + ' AND I.IDStore = ' + IntToStr(fIDStore);

       with quTempTable do
          begin
          CommandText := ' SELECT IMV.ModelID, '+
                         ' SUM((IMV.CostPrice+IMV.Freight+IMV.OtherCost)*IMV.Qty)/'+IntToStr(DaysBetween(fDateIni,fDateEnd))+' as MedCost' +
                         ' INTO ' + TempTableName2 +
                         ' FROM InventoryMov IMV (NOLOCK) ' +
                         ' LEFT OUTER JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IMV.DocumentID AND IMV.InventMovTypeID=1) ' +
                         ' WHERE ' + GetWhereClause +
                         ' GROUP BY IMV.ModelID';

          //GetWhereClause := CommandText;
          Execute(iRecordsAffected,eoAsyncExecute);
          //if iRecordsAffected = 0 then
             //MsgBox(MSG_INF_NO_DATA_FOUND, vbOKOnly + vbInformation);
          end;
      except
          Result := False;
      end;

end;


function TSubBestSeller.DropTempTable(sTable:String):Boolean;
begin

  if sTable <> '' then
    try
      with DM.quFreeSQL do
        begin
          Close;
          SQL.Text := 'DROP TABLE ' + sTable;
          ExecSQL;
        end;

      Result := True;
    except
      Result := False;
    end;

end;

procedure TSubBestSeller.DataSetRefresh;
begin
 DataSetClose;
 DataSetOpen;
end;

procedure TSubBestSeller.DataSetOpen;
var
  sSQL : String;
  sTotalSale : String;
  sWhere : String;
begin
  //Criar Query aqui

  sTotalSale := GetTotalSale;

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
  begin

   sWhere := ' (IM.PreSaleDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateIni)) +
             ' AND IM.PreSaleDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',fDateEnd)) + ') ';

   if fIDStore <> 0 then
     sWhere := sWhere + ' AND I.IDStore = ' + IntToStr(fIDStore);


   sSQL := 'SELECT M.Model,	M.Description, M.FreightCost as Freight, M.OtherCost, M.VendorCost as VCost, M.ReplacementCost,' +
           'M.DateLastCost as LastPurchaseDate, M.MarkUp, M.SellingPrice as OurPrice, ' +
           'M.SuggRetail as MSRP, M.TotQtyOnHand, M.LastMovDate, IsNull(M.AvgCost, M.FinalCost) as AvgCost, ' +
           'M.FinalCost as NetCost,	M.DateLastSellingPrice as LastSaleDate,	TG.Category, M.ClasseABC as Classification, V.Pessoa Vendor, ' +
           'C.Color, S.SizeName, MG.ModelGroup as SubCategory, MGS.ModelSubGroup as MGroup, ' +

           'SUM((IM.SalePrice * IM.Qty) - IM.Discount) TotalSold, SUM(IM.ItemCostTotal) as TotalCostSold, ' +
           'SUM(IM.Qty) as QtySold, SUM(IM.ItemNetValue) as Profit, ' +

           'CASE WHEN #Ret_ReportPurchase.MedCost=0 THEN 0 ELSE (SUM(IM.ItemCostTotal)/#Ret_ReportPurchase.MedCost) END as StokeTurnOver, '+

           'CASE WHEN SUM(IM.ItemCostTotal)=0 THEN 0 ' +
           '  ELSE SUM(IM.ItemNetValue)/SUM(IM.ItemCostTotal)*100 END as Percents, ' +

           'CASE '+sTotalSale+' WHEN 0 THEN 0 ELSE SUM(IM.ItemNetValue)/' + sTotalSale + ' * 100 END as AccProfitPerc ' +

           'FROM vwSaleItem IM (NOLOCK) ' +
           'JOIN vwInvoiceParents I (NOLOCK) ON (I.DocumentID = IM.IDPreSale) ' +
           'JOIN vw_Rep_Model M (NOLOCK) ON ( IM.ModelID = M.IDModel ) ' +
           'JOIN vw_Rep_Category TG (NOLOCK) ON ( M.GroupID = TG.IDCategory ) '+
           'LEFT JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
           'LEFT JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) ' +
           'LEFT JOIN #Ret_ReportSource (NOLOCK) ON (#Ret_ReportSource.IDInventoryMov = IM.IDPreInventoryMov) '+
           'LEFT OUTER JOIN #Ret_ReportPurchase ON (#Ret_ReportPurchase.ModelID = IM.ModelID) ' +
           'JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa) ' +
           'LEFT JOIN Inv_ModelVendor MD (NOLOCK) ON (M.IDModel = MD.IDModel AND VendorOrder = 1) ' +
           'LEFT JOIN Pessoa V (NOLOCK) ON (MD.IDPessoa = V.IDPessoa) ' +
           'LEFT JOIN InvColor C (NOLOCK) ON (M.IDColor = C.IDColor) ' + //   ike
	         'LEFT JOIN InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)' +     //   ike

           ' WHERE ' + sWhere +

           'GROUP BY M.Model, M.Description, M.FreightCost, M.OtherCost, '+
           'M.VendorCost, M.DateLastCost, M.MarkUp, M.SellingPrice, ' +
           'M.DateLastSellingPrice,	M.SuggRetail, M.TotQtyOnHand, M.LastMovDate, ' +
           'M.AvgCost, M.FinalCost, TG.Category, M.ClasseABC, #Ret_ReportPurchase.MedCost, ' +
           'C.Color, S.SizeName, ' + //ike
           'M.ReplacementCost, V.Pessoa, MG.ModelGroup, MGS.ModelSubGroup ';
   end
  else
   begin

   sSQL := 'SELECT M.Model,	M.Description, M.FreightCost as Freight, M.OtherCost, M.VendorCost as VCost, M.ReplacementCost, ' +
           'M.DateLastCost as LastPurchaseDate, M.MarkUp, M.SellingPrice as OurPrice, ' +
           'M.SuggRetail as MSRP, M.TotQtyOnHand, M.LastMovDate, IsNull(M.AvgCost, M.FinalCost) as AvgCost, ' +
           'M.FinalCost as NetCost,	M.DateLastSellingPrice as LastSaleDate,	TG.Category, M.ClasseABC as Classification, ' +
           'C.Color, S.SizeName, MG.ModelGroup as SubCategory, MGS.ModelSubGroup as MGroup, ' +
           'SUM(IM.Qty) as QtySold, SUM((IM.SalePrice * IM.Qty) - (IM.Discount + IVD.UnitDiscount)) TotalSold, SUM(IM.CostPrice * IM.Qty) TotalCostSold, '+
           'SUM((IM.SalePrice - IM.CostPrice) * IM.Qty - (IM.Discount + IVD.UnitDiscount)) as Profit, V.Pessoa Vendor, ' +

           'CASE WHEN #Ret_ReportPurchase.MedCost=0 THEN 0 ELSE (SUM(IM.CostPrice * IM.Qty)/#Ret_ReportPurchase.MedCost) END as StokeTurnOver, '+

           'CASE WHEN SUM(IM.CostPrice * IM.Qty)=0 THEN 0 ' +
           '  ELSE SUM(((IM.SalePrice - IM.CostPrice) * IM.Qty - (IM.Discount + IVD.UnitDiscount)))/SUM(IM.CostPrice * IM.Qty) * 100 END as Percents, ' +

           'CASE '+sTotalSale+' WHEN 0 THEN 0 ELSE SUM((IM.SalePrice - IM.CostPrice) * IM.Qty - (IM.Discount + IVD.UnitDiscount)) / ' +
           sTotalSale + ' * 100 END as AccProfitPerc ' +

           'FROM InventoryMov IM (NOLOCK) '+
           'JOIN vw_Rep_Model M (NOLOCK) ON ( IM.ModelID = M.IDModel ) ' +
           'JOIN vw_Rep_Category TG (NOLOCK) ON ( M.GroupID = TG.IDCategory ) '+
           'LEFT JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
           'LEFT JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) ' +
           'JOIN #Ret_ReportSource ON (#Ret_ReportSource.IDInventoryMov = IM.IDInventoryMov) ' +
           'LEFT JOIN #Ret_ReportPurchase ON (#Ret_ReportPurchase.ModelID = IM.ModelID) ' +
           'LEFT JOIN Inv_ModelVendor MD (NOLOCK) ON (M.IDModel = MD.IDModel AND VendorOrder = 1) ' +
           'LEFT JOIN Pessoa V (NOLOCK) ON (MD.IDPessoa = V.IDPessoa) ' +
           'LEFT JOIN InvColor C (NOLOCK) ON (M.IDColor = C.IDColor) ' +   //ike
           'LEFT JOIN InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)' +       //ike
           'JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = #Ret_ReportSource.IDInvoice AND IVD.Invoice = 1) ' +

           'GROUP BY M.Model, M.Description, M.FreightCost, M.OtherCost, '+
           'M.VendorCost, M.DateLastCost, M.MarkUp, M.SellingPrice, ' +
           'M.DateLastSellingPrice,	M.SuggRetail, M.TotQtyOnHand, M.LastMovDate, ' +
           'M.AvgCost, M.FinalCost, TG.Category, M.ClasseABC, #Ret_ReportPurchase.MedCost, ' +
           'C.Color, S.SizeName, ' + //ike
           'M.ReplacementCost, V.Pessoa, MG.ModelGroup, MGS.ModelSubGroup ';
   end;

  with quBestSeller do
    if not Active then
       begin
       CommandText := sSQL;
       Open;
       end;
end;

procedure TSubBestSeller.DataSetClose;
begin
  with quBestSeller do
    if Active then
       Close;
end;

procedure TSubBestSeller.AfterSetParam;
begin

 if FParam = '' then
    Exit;

 //Set parans
 fIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
 fDateIni := StrToDateTime(ParseParam(FParam, 'DateIni'));
 fDateEnd := StrToDateTime(ParseParam(FParam, 'DateEnd'));

 //Create Temp Table
 CreateTempTable;

 //Open DataSet
 try
   Screen.Cursor := crHourGlass;
   DataSetRefresh;
 finally
   Screen.Cursor := crDefault;
   end;

end;

procedure TSubBestSeller.FormDestroy(Sender: TObject);
begin

  //Saval para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

  inherited;
  DropTempTable(TempTableName);
  DropTempTable(TempTableName2);
  DataSetClose;
end;

procedure TSubBestSeller.btColumnClick(Sender: TObject);
begin
  inherited;

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;

end;

procedure TSubBestSeller.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBestSeller do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TSubBestSeller.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not quBestSeller.Active) or
    (quBestSeller.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;

 with TFrmExport.Create(Self) do
    Start(grdBestSeller, ParseParam(FParam, 'Title'));

end;

procedure TSubBestSeller.btPrintClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.Caption := '';
  gridPrinter.Preview(True, nil);
end;

procedure TSubBestSeller.grdBestSellerDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TSubBestSeller.quBestSellerCalcFields(DataSet: TDataSet);
begin
  inherited;

  if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
    quBestSellerVendorCost.AsCurrency := quBestSellerReplacementCost.AsCurrency
  else
    quBestSellerVendorCost.AsCurrency := quBestSellerVCost.AsCurrency +
                                         quBestSellerFreight.AsCurrency +
                                         quBestSellerOtherCost.AsCurrency;
end;

function TSubBestSeller.GetTotalSale: String;
var
  sSQL : String;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
    sSQL := 'SELECT  SUM(C.ItemNetValue) as TotalSales ' +
            'FROM vwSaleItem C (NOLOCK) ' +
            'JOIN Invoice I ON (C.IDPreSale = I.IDPreSale) ' +
            'JOIN Pessoa P ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
            'WHERE C.InventMovTypeID = 1 AND ' + SaleWhere
  else
    sSQL := 'SELECT SUM((IMV.SalePrice - IMV.CostPrice) * IMV.Qty - IMV.Discount)	as TotalSales '+
            'FROM Invoice I  (NOLOCK) ' +
            'JOIN InventoryMov IMV ON (IMV.DocumentID = I.IDInvoice AND IMV.InventMovTypeID = 1) ' +
            'WHERE IMV.InventMovTypeID = 1 AND ' + SaleWhere;

  with quTotalSales do
  try
    CommandText := sSQL;
    Open;
    Result := MyFormatDouble(FieldByName('TotalSales').AsFloat,'.');
  finally
   Close;
   end;

end;

procedure TSubBestSeller.btnFilterClick(Sender: TObject);
begin
  inherited;
  if not (TcxGridDBTableView(AView).Filtering.Visible = fvAlways) then
  begin
    TcxGridDBTableView(AView).Filtering.Visible := fvAlways;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := True;
  end
  else
  begin
    TcxGridDBTableView(AView).Filtering.Visible := fvNever;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := False;
  end;

end;

procedure TSubBestSeller.FormCreate(Sender: TObject);
begin
  inherited;

  AView := TcxCustomGridTableView(grdBestSeller.FocusedView);

end;

procedure TSubBestSeller.FormShow(Sender: TObject);
begin
  inherited;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

end;

initialization
   RegisterClass(TSubBestSeller);

end.
