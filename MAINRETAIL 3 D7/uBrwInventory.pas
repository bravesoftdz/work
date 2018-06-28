unit uBrwInventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask, PanelRights, Menus, BrowseConfig,
  DateBox, RadioButtonAll, 
  ImgList, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwInventory = class(TbrwParent)
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseModelID: TIntegerField;
    quBrowseGroupName: TStringField;
    btViewModel: TSpeedButton;
    btCount: TSpeedButton;
    pnlCategory: TPanel;
    lbCategory: TLabel;
    cmbGroup: TSuperComboADO;
    lbList: TLabel;
    cmbListField: TComboBox;
    pnlComplement: TPanel;
    lbWith: TLabel;
    cbxValues: TComboBox;
    quBrowseVendorCost: TFloatField;
    quBrowseDateLastCost: TDateTimeField;
    quBrowseSellingPrice: TFloatField;
    quBrowseSuggRetail: TFloatField;
    quBrowseLastCost: TFloatField;
    quBrowseDateLastSellingPrice: TDateTimeField;
    lbStore: TLabel;
    btnCategoryAll: TButton;
    quBrowseAvgCost: TBCDField;
    quBrowseSubSellingPrice: TCurrencyField;
    quBrowseSubFinalCost: TCurrencyField;
    quBrowseSubVendorCost: TCurrencyField;
    quBrowseSubFreightCost: TCurrencyField;
    quBrowseOtherCost: TBCDField;
    quBrowseFreightCost: TBCDField;
    quBrowseSubOtherCost: TCurrencyField;
    quBrowseRealMarkUpValue: TBCDField;
    quBrowseRealMarkUpPercent: TBCDField;
    quBrowseSubRealMarkUpValue: TCurrencyField;
    quBrowseSubSuggRetail: TCurrencyField;
    quBrowseFinalCost: TBCDField;
    btnViewReseted: TSpeedButton;
    quBrowseStoreID: TIntegerField;
    grdBrowseDBStoreID: TcxGridDBColumn;
    grdBrowseDBModelID: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBQtyOnHand: TcxGridDBColumn;
    grdBrowseDBQtyOnPreSale: TcxGridDBColumn;
    grdBrowseDBQtyOnOrder: TcxGridDBColumn;
    grdBrowseDBQtyOnRepair: TcxGridDBColumn;
    grdBrowseDBQtyOnPrePurchase: TcxGridDBColumn;
    grdBrowseDBGroupName: TcxGridDBColumn;
    grdBrowseDBVendorCost: TcxGridDBColumn;
    grdBrowseDBDateLastCost: TcxGridDBColumn;
    grdBrowseDBSellingPrice: TcxGridDBColumn;
    grdBrowseDBSuggRetail: TcxGridDBColumn;
    grdBrowseDBLastCost: TcxGridDBColumn;
    grdBrowseDBOtherCost: TcxGridDBColumn;
    grdBrowseDBFreightCost: TcxGridDBColumn;
    grdBrowseDBFinalCost: TcxGridDBColumn;
    grdBrowseDBRealMarkUpValue: TcxGridDBColumn;
    grdBrowseDBRealMarkUpPercent: TcxGridDBColumn;
    grdBrowseDBDateLastSellingPrice: TcxGridDBColumn;
    grdBrowseDBAvgCost: TcxGridDBColumn;
    grdBrowseDBSubSellingPrice: TcxGridDBColumn;
    grdBrowseDBSubFinalCost: TcxGridDBColumn;
    grdBrowseDBSubVendorCost: TcxGridDBColumn;
    grdBrowseDBSubFreightCost: TcxGridDBColumn;
    grdBrowseDBSubOtherCost: TcxGridDBColumn;
    grdBrowseDBSubSuggRetail: TcxGridDBColumn;
    Panel4: TPanel;
    quBrowseStoreSellingPrice: TCurrencyField;
    grdBrowseDBStoreSellingPrice: TcxGridDBColumn;
    quTestQty: TADODataSet;
    quTestQtyIDInventory: TIntegerField;
    quBrowseStoreCostPrice: TCurrencyField;
    quBrowseStoreAvgPrice: TCurrencyField;
    grdBrowseDBStoreAvgPrice: TcxGridDBColumn;
    grdBrowseDBStoreCostPrice: TcxGridDBColumn;
    quBrowseQtyOnHand: TFloatField;
    quBrowseQtyOnPreSale: TFloatField;
    quBrowseQtyOnOrder: TFloatField;
    quBrowseQtyOnRepair: TFloatField;
    quBrowseQtyOnPrePurchase: TFloatField;
    quBrowsePositiveQty: TFloatField;
    quBrowseMGroup: TStringField;
    quBrowseSubCategory: TStringField;
    grdBrowseDBMGroup: TcxGridDBColumn;
    grdBrowseDBSubCategory: TcxGridDBColumn;
    btnAdjustMinMax: TSpeedButton;
    quBrowseMinQty: TFloatField;
    quBrowseMaxQty: TFloatField;
    grdBrowseDBMinQty: TcxGridDBColumn;
    grdBrowseDBMaxQty: TcxGridDBColumn;
    quBrowseMarginPercent: TFloatField;
    quBrowseMarginValue: TFloatField;
    grdBrowseDBMarginPercent: TcxGridDBColumn;
    grdBrowseDBMarginValue: TcxGridDBColumn;
    quBrowseClasseABC: TStringField;
    grdBrowseDBClasseABC: TcxGridDBColumn;
    edtVendorCode: TEdit;
    lbVendorCode: TLabel;
    lbManufacturer: TLabel;
    scFabricante: TSuperComboADO;
    btnFabricanteAll: TButton;
    lbSubCategory: TLabel;
    sbSubCategory: TSuperComboADO;
    btnSubCateAll: TButton;
    btnMGroupAll: TButton;
    scModelGroup: TSuperComboADO;
    lbGroup: TLabel;
    quModelVendorCode: TADODataSet;
    quModelVendorCodeIDModel: TIntegerField;
    cmbStore: TSuperComboADO;
    btnStoreAll: TButton;
    btVendorAll: TButton;
    scVendor: TSuperComboADO;
    lbVendor: TLabel;
    quBrowseClassABCStore: TStringField;
    grdBrowseDBClassABCStore: TcxGridDBColumn;
    btnApplyDepartment: TSpeedButton;
    quBrowseFloatPercent: TIntegerField;
    quBrowseQtyFloating: TFloatField;
    grdBrowseDBQtyFloating: TcxGridDBColumn;
    quBrowseManufacturer: TStringField;
    quBrowseBarcode: TStringField;
    grdBrowseDBBarcode: TcxGridDBColumn;
    grdBrowseDBManufacturer: TcxGridDBColumn;
    chkBellowMin: TCheckBox;
    btnAdjustLot: TSpeedButton;
    quBrowseCaseQty: TBCDField;
    quBrowseUnidade: TStringField;
    grdBrowseDBCaseQty: TcxGridDBColumn;
    grdBrowseDBUnit: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbAllStoreClick(Sender: TObject);
    procedure cmbGroupSelectItem(Sender: TObject);
    procedure btViewModelClick(Sender: TObject);
    procedure btCountClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cmbListFieldChange(Sender: TObject);
    procedure cbxValuesChange(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btnCategoryAllClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btnViewResetedClick(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure btnAdjustMinMaxClick(Sender: TObject);
    procedure btnSubCateAllClick(Sender: TObject);
    procedure btnMGroupAllClick(Sender: TObject);
    procedure btnFabricanteAllClick(Sender: TObject);
    procedure btnStoreAllClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btVendorAllClick(Sender: TObject);
    procedure btnApplyDepartmentClick(Sender: TObject);
    procedure quBrowseAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdjustLotClick(Sender: TObject);
  private
    sOriginalSQL : String;

    function GetListWith:String;
    procedure TestQty;
    procedure SetFrachase;
    function GetModelVendorCode(VCode:String):String;
  end;

implementation

{$R *.DFM}

uses uFchInventory, uDM, uFchModel, uMsgBox, uFrmInvResetView, uMsgConstant,
  uSystemTypes, uNumericFunctions, uStringFunctions, uDMGlobal, uSystemConst,
  PaiDeTodos, uFrmAdjustMinMax, uSqlFunctions, uFrmAssociateDepartment,
  uFrmAdjustLot;

function TbrwInventory.GetListWith:String;
var
sWith : String;
begin
  Case cbxValues.ItemIndex of
     0 : sWith := ' > 0 ';
     1 : sWith := ' = 0 ';
     2 : sWith := ' < 0 ';
  end;

  Case cmbListField.ItemIndex of
     1 : Result := 'AND IsNull(I.QtyOnHand, 0) ' + sWith;
     2 : Result := 'AND IsNull(I.QtyOnPreSale, 0) ' + sWith;
     3 : Result := 'AND IsNull(I.QtyOnOrder, 0) ' + sWith;
     4 : Result := 'AND IsNull(I.QtyOnRepair, 0) ' + sWith;
     5 : Result := 'AND IsNull(I.QtyOnPrePurchase, 0) ' + sWith;
  end;

end;

procedure TbrwInventory.FormCreate(Sender: TObject);
begin
  inherited;

  brwForm := TFchInventory.Create(Self);
  sOriginalSQL := 'SELECT ' +
	                '  M.IDModel as ModelID, ' +
                  '  M.Model, ' +
                  '  M.Description, ' +
                  '  M.ClasseABC, ' +
                  '  M.VendorCost, ' +
                  '  M.FinalCost, ' +
                  '  M.DateLastCost, ' +
                  '  M.SellingPrice, ' +
                  '  CASE	WHEN M.AvgCost IS Null ' +
                  '    THEN M.VendorCost + M.OtherCost + M.FreightCost ' +
                  '    ELSE M.AvgCost END as AvgCost, ' +
                  '  M.SuggRetail, ' +
                  '  M.LastCost, ' +
                  '  M.DateLastSellingPrice, ' +
                  '  M.OtherCost, ' +
                  '  M.FreightCost, ' +
                  '  M.FloatPercent, ' +
                  '  M.CaseQty, ' +
                  '  CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost END as RealMarkUpValue, ' +
                  '  CASE WHEN M.SellingPrice > 0 AND M.FinalCost<>0 THEN (M.SellingPrice - M.FinalCost)/M.FinalCost*100 END as RealMarkUpPercent, ' +
                  '  I.QtyOnHand, ' +
                  '  I.QtyOnPreSale, ' +
                  '  I.QtyOnOrder, ' +
                  '  I.QtyOnRepair, ' +
                  '  I.QtyOnPrePurchase, ' +
                  '  I.SellingPrice as StoreSellingPrice, ' +
                  '  I.StoreCostPrice, ' +
                  '  I.StoreAvgPrice, ' +
                  '  I.MinQty, ' +
                  '  I.MaxQty, ' +
                  '  I.ClassABC as ClassABCStore, ' +
                  '  TG.Name as GroupName, ' +
                  '  MG.ModelGroup as SubCategory, ' +
                  '  MGS.ModelSubGroup as MGroup, ' +
                  '  F.Pessoa as Manufacturer, ' +
                  '  B.IDBarcode as Barcode, ' +
                  '  U.Unidade ' +
                  'FROM ' +
                  '  Model M (NOLOCK) ' +
                  '  JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup ) ' +
                  '  LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
                  '  LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) ' +
                  '  LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa) ' +
                  '  LEFT JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.BarcodeOrder = 1) ' +
                  '  LEFT JOIN Unidade U (NOLOCK) ON (M.IDUnidade = U.IDUnidade) ' +
                  '  LEFT OUTER JOIN ' +
                  '  ( ' +
                  '    SELECT ' +
                  '      I.ModelID, ' +
                  '      I.SellingPrice, ' +
                  '      I.StoreCostPrice, ' +
                  '      I.StoreAvgPrice, ' +
                  '      I.MinQty, ' +
                  '      I.MaxQty, ' +
                  '      I.ClassABC, ' +
                  '      SUM(I.QtyOnHand) as QtyOnHand, ' +
                  '      SUM(I.QtyOnPreSale) as QtyOnPreSale, ' +
                  '      SUM(I.QtyOnOrder) as QtyOnOrder, ' +
                  '      SUM(I.QtyOnRepair) as QtyOnRepair, ' +
                  '      SUM(I.QtyOnPrePurchase) as QtyOnPrePurchase ' +
                  '    FROM ' +
                  '      Inventory I (NOLOCK) ' +
                  '    WHERE ' +
                  '      #STORE_ACCESS_LIST# ' +
                  '    GROUP BY ' +
                  '      I.ModelID, ' +
                  '      I.SellingPrice, ' +
                  '      I.StoreCostPrice, ' +
                  '      I.StoreAvgPrice, ' +
                  '      I.MinQty, ' +
                  '      I.MaxQty, ' +
                  '      I.ClassABC ' +
                  '  ) I ON (I.ModelID = M.IDModel) ' +
                  '#Main_Where#';

  if fIsRestricForm then
     begin
     btnViewReseted.Enabled := False;
     end;

end;

procedure TbrwInventory.FormShow(Sender: TObject);
begin
  inherited;
  // Seta valores iniciais de seleção
  cmbListField.ItemIndex := 0;
  cbxValues.ItemIndex    := 0;
  scFabricante.Text      := '<-->';
  scVendor.Text          := '<-->';
  cmbGroup.Text          := '<-->';
  sbSubCategory.Text     := '<-->';
  scModelGroup.Text      := '<-->';
  cmbStore.LookUpValue   := IntToStr(DM.fStore.ID);
  btRemove.Visible       := False;
  btAdd.Visible          := False;
  SetFrachase;
end;

procedure TbrwInventory.rbAllStoreClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue  := '';
  aWhereBasicFilters[0] := '';
  quBrowse.ClearFilters;
  //ExecBrowseSQL(True);
  grdBrowse.SetFocus;
end;

procedure TbrwInventory.cmbGroupSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwInventory.btViewModelClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  PosID1 := quBrowseModelID.AsString;
  PosID2 := '';
  with TFchModel.Create(Self) do
  try
    if Start(btAlt, nil, False, PosID1, PosID2, nil) then
       btnExecClick(Self);
  finally
     Free;
     end;
end;

procedure TbrwInventory.btCountClick(Sender: TObject);
//var
//   MySqlStatement        : TSQlStatement;
//   DocumentID, InsertSQL, UpdateSQL, UpdateAuxSQL : String;
begin
  inherited;

  //Nao esta funcionando

{  if MsgBox('This operation will adjust the Store, of all items showed',
     vbYesNo + vbQuestion) = vbYes then
    begin
      DocumentID := InputBox('Adjustment Number', 'Number', '');
      if not IsStrNumber(DocumentID) then
        begin
         MsgBox('You must suply a valid number', vbOKOnly + vbInformation);
         Exit;
        end;

      // Descobre a clausula Where
      MySqlStatement := UnMountSQL(quBrowse.SQL.Text);

      // Colocar no auxcampo quantidades que foram alteradas depois da contagem
      UpdateAuxSQL   := 'UPDATE Inventory SET         ' +
                        '       AuxCalculo = vwTotInvMovContado.TotQty ' +
                        '                             ' +
                        ' FROM    Model M ,           ' +
                        ' dbo.Store S , dbo.TabGroup TG, vwTotInvMovContado' +
                        '       WHERE                 ' +
                                MySqlStatement[ST_WHERE];

      InsertSQL      := 'INSERT InventoryMov          ' +
                        '       (                     ' +
                        '       InventMovTypeID,      ' +
                        '       DocumentID,           ' +
                        '       StoreID,              ' +
                        '       ModelID,              ' +
                        '       MovDate,              ' +
                        '       Qty                   ' +
                        '       )                     ' +
                        '                             ' +
                        '       SELECT                ' +
                        '              (              ' +
			'	       CASE           ' +
			'		  WHEN ( I.QtyContada + IsNull(I.AuxCalculo, 0) )  > I.QtyOnHand  THEN 4 ' +
                        '                  ELSE 3     ' +
			'	       END            ' +
			'		),            ' +
                                DocumentID + ', ' +
                        '       S.IDStore,            ' +
                        '       ModelID,              ' +
                        '       '+DateToStr(Now)+',   ' +
                        '       ABS(( I.QtyContada + IsNull(I.AuxCalculo, 0) )-I.QtyOnHand) ' +
                        '                             ' +
                        ' FROM  dbo.Inventory I, dbo.Model M , ' +
                        ' dbo.Store S , dbo.TabGroup TG ' +
                        '       WHERE                 ' +
                                MySqlStatement[ST_WHERE] + ' ' +
                        ' AND I.DataContagem IS NOT NULL ' +
                        ' AND I.QtyContada <> I.QtyOnHand ';

      UpdateSQL      := 'UPDATE Inventory  SET        ' +
                        '       QtyContada = NULL,    ' +
                        '       DataContagem  = NULL, ' +
                        '       UltimaContagem = '+DateToStr(Now)+', ' +
                        '       AuxCalculo = 0        ' +
                        '                             ' +
                        ' FROM    dbo.Model M ,   ' +
                        ' dbo.Store S , dbo.TabGroup TG ' +
                        '       WHERE                 ' +
                                MySqlStatement[ST_WHERE] + ' ' +
                        ' AND DataContagem IS NOT NULL ';

      try
        DM.ADODBConnect.BeginTrans;

        with DM.quFreeSQL do
           begin

           if Active then
              Close;

           SQL.Text := UpdateAuxSQL;
           ExecSQL;

           if Active then
              Close;

           SQL.Text := InsertSQL;
           ExecSQL;

           if Active then
              Close;

           SQL.Text := UpdateSQL;
           ExecSQL;
           end;

        DM.ADODBConnect.CommitTrans;
      except
        DM.ADODBConnect.RollbackTrans;
      end;

      ExecBrowseSQL(False);

    end;      }
end;

procedure TbrwInventory.btnExecClick(Sender: TObject);
var
  sWhereClause, sStoreWhere, sModelVendorCode, sJoin : string;
begin
  inherited;

  Try

  Screen.Cursor := crHourGlass;
  sJoin := '';

  // filtro por Store
  if cmbStore.LookUpValue <> '' then
    sStoreWhere := ' StoreID = ' + cmbStore.LookUpValue
  else
    sStoreWhere := ' StoreID IN ('+ DM.fStore.StoreList +')';

  //Filtro do main Where Clause
  sWhereClause := ' WHERE M.Desativado = 0 AND M.ModelType IN ('+QuotedStr('R')+','+QuotedStr('S')+','+QuotedStr('V')+','+QuotedStr('C')+','+QuotedStr('G')+','+QuotedStr('K')+') ';

  // filtro por Group
  if cmbGroup.LookUpValue <> '' then
     sWhereClause := sWhereClause + ' AND TG.IDGroup = ' + cmbGroup.LookUpValue;

  // filtro Qty
  if cmbListField.ItemIndex <> 0 then
     sWhereClause := sWhereClause + GetListWith;

  // E finalmente o filtro por fabricante
  if scFabricante.LookUpValue <> '' then
    sWhereClause := sWhereClause + ' AND M.IDFabricante=' + scFabricante.LookUpValue;

  if edtVendorCode.Text <> '' then
     begin
     sModelVendorCode := GetModelVendorCode(edtVendorCode.Text);
     if sModelVendorCode <> '' then
        sWhereClause := sWhereClause + ' AND M.IDModel IN (' + sModelVendorCode + ')';
     end;

  // Agora o filtro por Sub Category
  if sbSubCategory.LookUpValue <> '' then
     sWhereClause := sWhereClause + ' AND M.IDModelGroup = ' + sbSubCategory.LookUpValue;

  // Agora o filtro por Group
  if scModelGroup.LookUpValue <> '' then
     sWhereClause := sWhereClause + ' AND M.IDModelSubGroup = ' + scModelGroup.LookUpValue;

  //Filtro aboixo da qtd min
  if chkBellowMin.Checked then
     sWhereClause := sWhereClause + ' AND I.QtyOnHand < I.MinQty ';

  // O filtro por fornecedor
  if scVendor.LookUpValue <> '' then
  begin
    sJoin := 'INNER JOIN Inv_ModelVendor IMV ON (M.IDModel = IMV.IDModel) ';
    sWhereClause := sWhereClause + ' AND IMV.IDPessoa=' + scVendor.LookUpValue;
  end;

  with quBrowse do
     begin
     if Active then
        Close;

     Commandtext := Replace(sOriginalSQL, STORE_MARK, sStoreWhere);

     Commandtext := Replace(CommandText, '#Main_Where#', sJoin + sWhereClause);

     Open;
     end;

  Finally
     Screen.Cursor := crDefault;
     grdBrowse.SetFocus;
     DesativaAviso;
  end;

end;

procedure TbrwInventory.cmbListFieldChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
  if cmbListField.ItemIndex = 0 then
     pnlComplement.Visible := False
  else
     pnlComplement.Visible := True;
end;

procedure TbrwInventory.cbxValuesChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwInventory.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btViewModel.Enabled:= not quBrowse.IsEmpty;
end;

procedure TbrwInventory.btnCategoryAllClick(Sender: TObject);
begin
  inherited;

  cmbGroup.LookUpValue := '';
  cmbGroup.Text        := '<'+BtnCategoryAll.Caption+'>';
  cmbGroup.SetFocus;
  AtivaAviso;

end;

procedure TbrwInventory.quBrowseCalcFields(DataSet: TDataSet);
var
  CostPrice,
  SalePrice : Currency;
begin
  inherited;

  if cmbStore.LookUpValue = '' then
     quBrowseStoreID.AsInteger := DM.fStore.ID
  else
     quBrowseStoreID.AsInteger := StrToIntDef(cmbStore.LookUpValue,DM.fStore.ID);

  if quBrowseQtyOnHand.AsFloat < 0 then
    quBrowsePositiveQty.AsFloat := 0
  else
    quBrowsePositiveQty.AsFloat := quBrowseQtyOnHand.AsFloat;


  quBrowseSubSellingPrice.AsCurrency
     := quBrowseSellingPrice.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubFinalCost.AsCurrency
     := quBrowseFinalCost.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubVendorCost.AsCurrency
     := quBrowseVendorCost.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubFreightCost.AsCurrency
     := quBrowseFreightCost.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubOtherCost.AsCurrency
    := quBrowseOtherCost.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubRealMarkUpValue.AsCurrency
    := quBrowseRealMarkUpValue.AsCurrency * quBrowsePositiveQty.AsFloat;

  quBrowseSubSuggRetail.AsCurrency
    := quBrowseSuggRetail.AsCurrency * quBrowsePositiveQty.AsFloat;

  if quBrowseStoreSellingPrice.AsCurrency = 0 then
    SalePrice := quBrowseSellingPrice.AsCurrency
  else
    SalePrice := quBrowseStoreSellingPrice.AsCurrency;

  if quBrowseStoreCostPrice.AsCurrency = 0 then
    CostPrice := quBrowseVendorCost.AsCurrency
  else
    CostPrice := quBrowseStoreCostPrice.AsCurrency;

  if SalePrice <> 0 then
  begin
    quBrowseMarginPercent.AsFloat := (1 - (CostPrice/SalePrice)) * 100;
    quBrowseMarginValue.AsFloat :=  (1 - (CostPrice/SalePrice)) * SalePrice;
  end;

  //Calcular a quantidade Flutuante do Modelo
  if (not grdBrowseDBQtyFloating.Visible) or (quBrowseFloatPercent.AsFloat = 0) then
  begin
     quBrowseQtyFloating.AsFloat := (quBrowseQtyOnHand.AsFloat - quBrowseQtyOnPreSale.AsFloat);
     Exit;
  end;

  if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
    quBrowseQtyFloating.AsFloat := (quBrowseQtyOnHand.AsFloat - quBrowseQtyOnPreSale.AsFloat) +
                                     ((quBrowseQtyOnPreSale.AsFloat * quBrowseFloatPercent.AsFloat)) / 100
  else
    quBrowseQtyFloating.AsFloat := Trunc((quBrowseQtyOnHand.AsFloat - quBrowseQtyOnPreSale.AsFloat) +
                                     ((quBrowseQtyOnPreSale.AsFloat * quBrowseFloatPercent.AsFloat)) / 100);
end;

procedure TbrwInventory.btnViewResetedClick(Sender: TObject);
begin
  inherited;
  //Coper Inv
  with TFrmInvResetView.Create(Self) do
    begin
    Start(MyStrToInt(Self.cmbStore.LookUpValue));
    end;
end;

procedure TbrwInventory.TestQty;
  procedure InsertQty;
  var
    sSQL  : String;
    IDMov : Integer;
  begin
    IDMov := DM.GetNextID(MR_INVENTORY_MOV_ID);
    sSQL := 'INSERT InventoryMov ' +
            '(IDInventoryMov, InventMovTypeID, DocumentID, ' +
            ' StoreID, ModelID, MovDate, Qty)  ' +
            'VALUES ('+IntToStr(IDMov)+ ',5,'+
            '0,'+quBrowseStoreID.AsString + ','+
            quBrowseModelID.AsString + ','+
            'GetDate(), 0)';
     DM.RunSQL(sSQL);
  end;
begin

  with quTestQty do
     begin
     If Active then
        Close;
     Parameters.ParamByName('IDStore').Value := quBrowseStoreID.AsInteger;
     Parameters.ParamByName('IDModel').Value := quBrowseModelID.AsInteger;
     Open;
     if IsEmpty then
        InsertQty;

     Close;
     end;
end;

procedure TbrwInventory.CommandClick(Sender: TObject);
begin

  TestQty;

  inherited;

end;

procedure TbrwInventory.grdBrowseDBDblClick(Sender: TObject);
begin

  TestQty;

  inherited;

end;

procedure TbrwInventory.SetFrachase;
var
  HiddenColumn : Boolean;
begin

   HiddenColumn := DM.fStore.Franchase;

   grdBrowseDBVendorCost.Hidden        := HiddenColumn;
   grdBrowseDBSellingPrice.Hidden      := HiddenColumn;
   grdBrowseDBSuggRetail.Hidden        := HiddenColumn;
   grdBrowseDBLastCost.Hidden          := HiddenColumn;
   grdBrowseDBOtherCost.Hidden         := HiddenColumn;
   grdBrowseDBFreightCost.Hidden       := HiddenColumn;
   grdBrowseDBFinalCost.Hidden         := HiddenColumn;
   grdBrowseDBAvgCost.Hidden           := HiddenColumn;
   grdBrowseDBSubSellingPrice.Hidden   := HiddenColumn;
   grdBrowseDBSubFinalCost.Hidden      := HiddenColumn;
   grdBrowseDBSubVendorCost.Hidden     := HiddenColumn;
   grdBrowseDBSubFreightCost.Hidden    := HiddenColumn;
   grdBrowseDBSubOtherCost.Hidden      := HiddenColumn;
   grdBrowseDBSubSuggRetail.Hidden     := HiddenColumn;

end;

procedure TbrwInventory.btnAdjustMinMaxClick(Sender: TObject);
begin
  inherited;
  if cmbStore.LookUpValue <> '' then
    with TFrmAdjustMinMax.Create(Self) do
       Start(StrToInt(cmbStore.LookUpValue));
end;

function TbrwInventory.GetModelVendorCode(VCode: String): String;
var
 sWhere : String;
begin

  Result := '';

  with quModelVendorCode do
    begin
    if Active then
       Close;
    sWhere := 'VendorCode like ' + QuotedStr(VCode+'%');
    quModelVendorCode.CommandText := ChangeWhereClause(quModelVendorCode.CommandText, sWhere, True);
    Open;
    First;
    if not IsEmpty then
       while not EOF do
       begin
       Result := Result + quModelVendorCodeIDModel.AsString;
       Next;
       if not EOF then
          Result := Result + ',';
       end;
    Close;
    end;

    if Result = '' then
       Result := '-1';
end;

procedure TbrwInventory.btnSubCateAllClick(Sender: TObject);
begin
  inherited;

  sbSubCategory.LookUpValue := '';
  sbSubCategory.Text        := '<'+btnSubCateAll.Caption+'>';
  sbSubCategory.SetFocus;
  AtivaAviso;
end;

procedure TbrwInventory.btnMGroupAllClick(Sender: TObject);
begin
  inherited;

  scModelGroup.LookUpValue := '';
  scModelGroup.Text        := '<'+btnMGroupAll.Caption+'>';
  scModelGroup.SetFocus;
  AtivaAviso;

end;

procedure TbrwInventory.btnFabricanteAllClick(Sender: TObject);
begin
  inherited;

  scFabricante.LookUpValue := '';
  scFabricante.Text        := '<'+btnFabricanteAll.Caption+'>';
  scFabricante.SetFocus;
  AtivaAviso;

end;

procedure TbrwInventory.btnStoreAllClick(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btnStoreAll.Caption+'>';

  AtivaAviso;

end;

procedure TbrwInventory.Button1Click(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btnStoreAll.Caption+'>';
  cmbStore.SetFocus;
  AtivaAviso;

end;

procedure TbrwInventory.btVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text        := '<'+ btVendorAll.Caption +'>';
  scVendor.SetFocus;
  AtivaAviso;
end;

procedure TbrwInventory.btnApplyDepartmentClick(Sender: TObject);
begin
  inherited;
  with TFrmAssociateDepartment.Create(Self) do
  try
    Start(quBrowse);
  finally
    Free;
  end;
end;

procedure TbrwInventory.quBrowseAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnApplyDepartment.Enabled := not quBrowse.IsEmpty;
end;

procedure TbrwInventory.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
    btnExecClick(Self)
  else
    inherited;

end;

procedure TbrwInventory.btnAdjustLotClick(Sender: TObject);
begin
  inherited;

  with TFrmAdjustLot.Create(Self) do
    Start(StrToInt(cmbStore.LookUpValue));

end;

end.
