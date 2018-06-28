unit uFrmBarcodeSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uDialogParent, StdCtrls, Grids, Db, DBTables, ExtCtrls, Buttons, ADODB, siComp, siLangRT,
  DBGrids, SMDBGrid, Mask, SuperComboADO, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid;

type
  TFrmBarcodeSearch = class(TDialogParent)
    quBarcode: TADOQuery;
    dsBarcode: TDataSource;
    edBarcode: TEdit;
    btSearch: TBitBtn;
    quBarcodeIDModel: TIntegerField;
    quBarcodeIDBarcode: TStringField;
    quBarcodeModel: TStringField;
    quBarcodeDescription: TStringField;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    quBarcodeHasInStock: TStringField;
    quBarcodeManufacture: TStringField;
    lbManufect: TLabel;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    lbVerti: TLabel;
    scColor: TSuperComboADO;
    lbHoriz: TLabel;
    scSize: TSuperComboADO;
    btnSizeClear: TButton;
    btnColorClear: TButton;
    lbCategory: TLabel;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    lbGroup: TLabel;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    lbStore: TLabel;
    scStore: TSuperComboADO;
    btnStoreAll: TButton;
    quBarcodeSellingPrice: TCurrencyField;
    quBarcodeStoreSellingPrice: TBCDField;
    quBarcodeModelPrice: TBCDField;
    lbSubGroup: TLabel;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    Panel3: TPanel;
    pnlButtons: TPanel;
    grdBrowseSearch: TcxGrid;
    grdBrowseSearchDB: TcxGridDBTableView;
    grdBrowseSearchDBIDBarcode: TcxGridDBColumn;
    grdBrowseSearchDBModel: TcxGridDBColumn;
    grdBrowseSearchDBDescription: TcxGridDBColumn;
    grdBrowseSearchDBHasInStock: TcxGridDBColumn;
    grdBrowseSearchDBManufacture: TcxGridDBColumn;
    grdBrowseSearchDBSellingPrice: TcxGridDBColumn;
    grdBrowseSearchDBStoreSellingPrice: TcxGridDBColumn;
    grdBrowseSearchDBModelPrice: TcxGridDBColumn;
    grdBrowseSearchDBQtyOnHand: TcxGridDBColumn;
    grdBrowseSearchLevel: TcxGridLevel;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    btFilter: TSpeedButton;
    pnlDivisoria2: TPanel;
    quBarcodeCategory: TStringField;
    grdBrowseSearchDBCategory: TcxGridDBColumn;
    grdBrowseSearchDBCatSubGroup: TcxGridDBColumn;
    lbVendor: TLabel;
    scVendor: TSuperComboADO;
    btnVendorAll: TButton;
    quBarcodeVendor: TStringField;
    grdBrowseSearchDBVendor: TcxGridDBColumn;
    cbxPrimaryBarcode: TCheckBox;
    cbxPrimVendor: TCheckBox;
    quBarcodeIDVendor: TIntegerField;
    quBarcodeModelCost: TBCDField;
    quBarcodeStoreCostPrice: TBCDField;
    quBarcodeModelMarkUpPercent: TBCDField;
    grdBrowseSearchDBStoreCostPrice: TcxGridDBColumn;
    grdBrowseSearchDBModelCost: TcxGridDBColumn;
    grdBrowseSearchDBModelMarkUpPercent: TcxGridDBColumn;
    quBarcodeQtyOnPreSale: TBCDField;
    quBarcodeQtyOnHand: TFloatField;
    quBarcodeQtyInStock: TBCDField;
    procedure btSearchClick(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsBarcodeDataChange(Sender: TObject; Field: TField);
    procedure DbPowerGrid1DblClick(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quBarcodeCalcFields(DataSet: TDataSet);
    procedure edBarcodeEnter(Sender: TObject);
    procedure edBarcodeExit(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnSizeClearClick(Sender: TObject);
    procedure btnColorClearClick(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnStoreAllClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure scCategorySelectItem(Sender: TObject);
    procedure scGroupSelectItem(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure grdBrowseSearchDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdBrowseSearchDBCustomization(Sender: TObject);
    procedure grdBrowseSearchDBDblClick(Sender: TObject);
    procedure grdBrowseSearchDBFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btnVendorAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FShowInStoke : Boolean;
    FMovType: Integer;
    sYes,
    sNo  :String;
    AView  : TcxCustomGridTableView;
    AOptions : TcxGridStorageOptions;
    ASaveViewName : String;
    fRegistryPath : String;
    procedure StartOptions;
  public
    function Start(AMovType: Integer = 0): integer;
    function StartModel(AMovType: Integer = 0): String;
  end;

implementation

{$R *.DFM}

uses xBase, uDM, uDMGlobal, uPassword, uFrmExport, uMsgBox, uMsgConstant,
     uSystemConst, uFrmNewPO;


function TFrmBarcodeSearch.StartModel(AMovType: Integer = 0): String;
begin
  FMovType := AMovType;

  StartOptions;
  ShowModal;
  Result := '';

  if (ModalResult = mrOk) then
    if quBarcode.Active and (quBarcode.RecordCount > 0) and (quBarcodeIDModel.AsInteger <> 0) then
      Result := quBarcodeModel.AsString;

  quBarcode.Close;

end;

procedure TFrmBarcodeSearch.StartOptions;
begin

  FShowInStoke := Password.HasFuncRight(45);
  grdBrowseSearchDBQtyOnHand.Hidden := not FShowInStoke;
  grdBrowseSearchDBHasInStock.Hidden := not Password.HasFuncRight(56);

  scStore.LookUpValue := IntToStr(DM.fStore.ID);

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  grdBrowseSearchDBModelMarkUpPercent.Hidden  := not Password.HasFuncRight(2);
  grdBrowseSearchDBModelCost.Hidden           := grdBrowseSearchDBModelMarkUpPercent.Hidden;
  grdBrowseSearchDBStoreCostPrice.Hidden      := grdBrowseSearchDBModelMarkUpPercent.Hidden;

  if grdBrowseSearchDBModelMarkUpPercent.Hidden then
  begin
    grdBrowseSearchDBModelMarkUpPercent.Visible := False;
    grdBrowseSearchDBModelCost.Visible          := False;
    grdBrowseSearchDBStoreCostPrice.Visible     := False;
  end;

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

end;

function TFrmBarcodeSearch.Start(AMovType: Integer = 0): Integer;
begin
  FMovType := AMovType;

  StartOptions;

  Result := -1;

  if (ShowModal = mrOk) then
    if quBarcode.Active and (quBarcode.RecordCount > 0) and (quBarcodeIDModel.AsInteger <> 0) then
      Result := quBarcodeIDModel.AsInteger;

  quBarcode.Close;



end;

procedure TFrmBarcodeSearch.btSearchClick(Sender: TObject);
var
 sSQL, sWhere, sCampo, sVendorJoin, sVendorOrder, sWhereInventory : String;
begin
  inherited;

  Screen.Cursor := crHourGlass;
  try
    sVendorJoin     := '';
    sVendorOrder    := '';
    sWhereInventory := '';
    sWhere          := ' M.Desativado = 0 ';

    if FMovType = MOV_TYPE_SALE then
      sWhere := sWhere + ' AND M.Hidden = 0 ';

    if cbxPrimaryBarcode.Checked then
      sVendorJoin := ' LEFT JOIN Barcode B ON (M.IDModel = B.IDModel and B.BarcodeOrder = 1) '
    else
      sVendorJoin := ' LEFT OUTER JOIN Barcode B ON (B.IDModel = M.IDModel) ';

    If Trim(edBarcode.Text) <> '' then
       begin
       Case cbxType.ItemIndex of
         0 : sCampo := 'B.IDBarcode %S ';
         1 : sCampo := 'M.Model %S ';
         2 : sCampo := 'M.Description %S ';
         3 : begin
             sVendorJoin := sVendorJoin + ' LEFT OUTER JOIN VendorModelCode VMC (NOLOCK) ON (M.IDModel = VMC.IDModel) ';
             sCampo      := ' M.IDModel IN (SELECT IDModel FROM VendorModelCode WHERE VendorCode %S )';
             end;
       end;

       Case cbxMethod.ItemIndex of
         0 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
         1 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
         2 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
       end;
       end;

       if scFabricante.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

       if scSize.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.IDSize = ' + scSize.LookUpValue;

       if scColor.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.IDColor = ' + scColor.LookUpValue;

       if scCategory.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;

       if scGroup.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;

       if scSubGroup.LookUpValue <> '' then
          sWhere := sWhere + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;

       if scStore.LookUpValue <> '' then
          sWhereInventory := ' AND I.StoreID = ' + scStore.LookUpValue;

       if scVendor.LookUpValue <> '' then
          sWhere := sWhere + ' AND V.IDPessoa = ' + scVendor.LookUpValue;

       if cbxPrimVendor.Checked then
          sVendorOrder := ' AND (VendorOrder = 1) ';

       sSQL := 'SELECT DISTINCT M.IDModel, B.IDBarcode, V.IDPessoa as IDVendor, M.Model, M.Description, M.SellingPrice as ModelPrice, ' +
               'I.SellingPrice as StoreSellingPrice, TG.Name as Category, ' +
               'P.Pessoa as Manufacture, I.QtyOnHand as QtyInStock, I.QtyOnPreSale, V.Pessoa as Vendor, M.FinalCost as ModelCost, I.StoreCostPrice, ' +
               'CASE WHEN (M.SellingPrice > 0 AND M.FinalCost <> 0) THEN (M.SellingPrice - M.FinalCost)/M.FinalCost * 100 ELSE 0 END as ModelMarkUpPercent ' +
               'FROM Model M (NOLOCK) ' +
               'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
               'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante) ' +
               'LEFT OUTER JOIN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID '+sWhereInventory+' ) ' +
               'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel '+sVendorOrder+' ) ' +
               'LEFT JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV.IDPessoa) ' +
               ' ' + sVendorJoin +
               'WHERE M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ' +
               'AND ' + sWhere +
               ' ORDER BY M.Model, B.IDBarcode';

       With quBarcode do
          begin
          Close;
          SQL.Text := sSQL;
          Open;
          if RecordCount > 0 then
             begin
             //grdBarcode.SetFocus;
             btSearch.Default := False;
             Aplicar.Default  := True;
             end;
          end;
  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TFrmBarcodeSearch.edBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Return then
    begin
      btSearchClick(nil);
    end;

end;

procedure TFrmBarcodeSearch.dsBarcodeDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  Aplicar.Enabled := NOT quBarcode.IsEmpty;

end;

procedure TFrmBarcodeSearch.DbPowerGrid1DblClick(Sender: TObject);
begin
  inherited;
  if Aplicar.Enabled then
    AplicarClick(nil);
end;

procedure TFrmBarcodeSearch.AplicarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmBarcodeSearch.FormShow(Sender: TObject);
begin
  inherited;

  //amfsouza 01.31.2011 - cbxPrimaryBarcode.Checked := False;
  cbxPrimaryBarCode.Checked := true;
  cbxPrimVendor.Checked     := true;
  
  cbxMethod.ItemIndex := 2;
  cbxType.ItemIndex   := 2;
  if edBarcode.CanFocus then
     edBarcode.SetFocus;
end;

procedure TFrmBarcodeSearch.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sYes := 'Yes';
           sNo  := 'No';
           end;

     LANG_PORTUGUESE :
           begin
           sYes := 'Sim';
           sNo  := 'Não';
           end;

     LANG_SPANISH :
           begin
           sYes := 'Sí';
           sNo  := 'No';
           end;
   end;


  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_FILTER, btFilter.Glyph);

  AView := TcxCustomGridTableView(grdBrowseSearch.FocusedView);

end;

procedure TFrmBarcodeSearch.quBarcodeCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quBarcodeQtyInStock.AsFloat > 0 then
     quBarcodeHasInStock.AsString := sYes
  else
     quBarcodeHasInStock.AsString := sNo;

  if FShowInStoke then
    quBarcodeQtyOnHand.AsFloat := quBarcodeQtyInStock.AsFloat
  else
    quBarcodeQtyOnHand.AsFloat := (quBarcodeQtyInStock.AsFloat - quBarcodeQtyOnPreSale.AsFloat);


  if DM.fStore.Franchase then
     quBarcodeSellingPrice.AsCurrency := quBarcodeStoreSellingPrice.AsCurrency
  else
     begin
     if quBarcodeStoreSellingPrice.AsCurrency <> 0 then
        quBarcodeSellingPrice.AsCurrency := quBarcodeStoreSellingPrice.AsCurrency
     else
        quBarcodeSellingPrice.AsCurrency := quBarcodeModelPrice.AsCurrency;
     end;

end;

procedure TFrmBarcodeSearch.edBarcodeEnter(Sender: TObject);
begin
  inherited;
  btSearch.Default := True;
  Aplicar.Default  := False;
end;

procedure TFrmBarcodeSearch.edBarcodeExit(Sender: TObject);
begin
  inherited;
  btSearch.Default := False;
  Aplicar.Default  := True;
end;

procedure TFrmBarcodeSearch.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<'+btFabricanteAll.Caption+'>';
end;

procedure TFrmBarcodeSearch.btnSizeClearClick(Sender: TObject);
begin
  inherited;
  scSize.LookUpValue := '';
  scSize.Text := '<'+btnSizeClear.Caption+'>';

end;

procedure TFrmBarcodeSearch.btnColorClearClick(Sender: TObject);
begin
  inherited;
  scColor.LookUpValue := '';
  scColor.Text := '<'+btnColorClear.Caption+'>';
end;

procedure TFrmBarcodeSearch.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<' + btnCategClear.Caption + '>';
end;

procedure TFrmBarcodeSearch.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<' + btnGroupClear.Caption + '>';
end;

procedure TFrmBarcodeSearch.btnStoreAllClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<' + btnStoreAll.Caption + '>';
end;

procedure TFrmBarcodeSearch.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<' + btnSubGroupClear.Caption + '>';
end;

procedure TFrmBarcodeSearch.scCategorySelectItem(Sender: TObject);
begin
  inherited;
  if scCategory.LookUpValue <> '' then
     scGroup.SpcWhereClause := 'IDGroup = '+scCategory.LookUpValue;
end;

procedure TFrmBarcodeSearch.scGroupSelectItem(Sender: TObject);
begin
  inherited;

  if scGroup.LookUpValue <> '' then
     scSubGroup.SpcWhereClause := 'IDModelGroup = ' + scGroup.LookUpValue;

end;

procedure TFrmBarcodeSearch.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not quBarcode.Active) or
    (quBarcode.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdBrowseSearch, Self.Caption);

end;

procedure TFrmBarcodeSearch.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowseSearch do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TFrmBarcodeSearch.btColumnClick(Sender: TObject);
begin
  inherited;

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;

end;

procedure TFrmBarcodeSearch.btFilterClick(Sender: TObject);
begin
  inherited;

  if btFilter.Down then
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

procedure TFrmBarcodeSearch.grdBrowseSearchDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TFrmBarcodeSearch.grdBrowseSearchDBCustomization(
  Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmBarcodeSearch.grdBrowseSearchDBDblClick(Sender: TObject);
begin
  inherited;

  AplicarClick(Aplicar);
  
end;

procedure TFrmBarcodeSearch.grdBrowseSearchDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TFrmBarcodeSearch.btnVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<'+btnVendorAll.Caption+'>';
end;


procedure TFrmBarcodeSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

end.
