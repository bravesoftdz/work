unit ubrwModel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu, Variants,
  Provider, DBClient, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass,
  ppReport, ppBands, ppCache, ppStrtch, ppSubRpt, ppCtrls, ppPrnabl, ppVar,
  myChkBox;

type
  TbrwModel = class(TbrwParent)
    pnlQuantity: TPanel;
    Panel10: TPanel;
    btShowQuantity: TSpeedButton;
    quQuantity: TADOQuery;
    dsQuantity: TDataSource;
    quQuantityStore: TStringField;
    quQuantityLocation: TStringField;
    scGroup: TSuperComboADO;
    Label2: TLabel;
    Label4: TLabel;
    scFabricante: TSuperComboADO;
    cmbList: TComboBox;
    Label5: TLabel;
    btGroupAll: TButton;
    btFabricanteAll: TButton;
    quBrowseIDModel: TIntegerField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseColor: TStringField;
    quBrowseSizeName: TStringField;
    quBrowseCodColor: TStringField;
    quBrowseCodSize: TStringField;
    quBrowseLastMovDate: TDateTimeField;
    quBrowseDateLastCost: TDateTimeField;
    quBrowseVendorCost: TFloatField;
    quBrowseOtherCost: TFloatField;
    quBrowseFreightCost: TFloatField;
    quBrowseFinalCost: TFloatField;
    quBrowseSellingPrice: TFloatField;
    quBrowseRealMarkUpValue: TFloatField;
    quBrowseRealMarkUpPercent: TFloatField;
    quBrowseDateLastSellingPrice: TDateTimeField;
    quBrowseSuggRetail: TFloatField;
    quBrowseManufacturer: TStringField;
    quBrowseName: TStringField;
    quBrowseSubSellingPrice: TFloatField;
    quBrowseSubFinalCost: TFloatField;
    quBrowseSubVendorCost: TFloatField;
    quBrowseSubFreightCost: TFloatField;
    quBrowseSubOtherCost: TCurrencyField;
    quBrowseSubRealMarkUpValue: TCurrencyField;
    quBrowseSubSuggRetail: TCurrencyField;
    btDetailGrid: TSpeedButton;
    Panel4: TPanel;
    pnlNoQuantity: TPanel;
    btAdjustPrices: TSpeedButton;
    quBrowseAvgCost: TBCDField;
    grdQuantity: TcxGrid;
    grdQuantityDB: TcxGridDBTableView;
    grdQuantityLevel: TcxGridLevel;
    grdQuantityDBStore: TcxGridDBColumn;
    grdQuantityDBQtyOnPreSale: TcxGridDBColumn;
    grdQuantityDBQtyOnHand: TcxGridDBColumn;
    grdQuantityDBQtyOnOrder: TcxGridDBColumn;
    grdQuantityDBMaxQty: TcxGridDBColumn;
    grdQuantityDBMinQty: TcxGridDBColumn;
    grdQuantityDBLocation: TcxGridDBColumn;
    grdQuantityDBQtyOnRepair: TcxGridDBColumn;
    grdQuantityDBQtyOnPrePurchase: TcxGridDBColumn;
    grdBrowseDBIDModel: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBColor: TcxGridDBColumn;
    grdBrowseDBSizeName: TcxGridDBColumn;
    grdBrowseDBCodColor: TcxGridDBColumn;
    grdBrowseDBCodSize: TcxGridDBColumn;
    grdBrowseDBLastMovDate: TcxGridDBColumn;
    grdBrowseDBDateLastCost: TcxGridDBColumn;
    grdBrowseDBVendorCost: TcxGridDBColumn;
    grdBrowseDBOtherCost: TcxGridDBColumn;
    grdBrowseDBFreightCost: TcxGridDBColumn;
    grdBrowseDBFinalCost: TcxGridDBColumn;
    grdBrowseDBSellingPrice: TcxGridDBColumn;
    grdBrowseDBRealMarkUpValue: TcxGridDBColumn;
    grdBrowseDBRealMarkUpPercent: TcxGridDBColumn;
    grdBrowseDBDateLastSellingPrice: TcxGridDBColumn;
    grdBrowseDBSuggRetail: TcxGridDBColumn;
    grdBrowseDBTotQtyOnHand: TcxGridDBColumn;
    grdBrowseDBTotQtyOnRepair: TcxGridDBColumn;
    grdBrowseDBTotQtyOnPreSale: TcxGridDBColumn;
    grdBrowseDBTotQtyOnPrePurchase: TcxGridDBColumn;
    grdBrowseDBTotQtyOnOrder: TcxGridDBColumn;
    grdBrowseDBManufacturer: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBSubSellingPrice: TcxGridDBColumn;
    grdBrowseDBSubFinalCost: TcxGridDBColumn;
    grdBrowseDBSubVendorCost: TcxGridDBColumn;
    grdBrowseDBSubFreightCost: TcxGridDBColumn;
    grdBrowseDBSubOtherCost: TcxGridDBColumn;
    grdBrowseDBSubRealMarkUpValue: TcxGridDBColumn;
    grdBrowseDBSubSuggRetail: TcxGridDBColumn;
    grdBrowseDBPositiveQty: TcxGridDBColumn;
    grdBrowseDBAvgCost: TcxGridDBColumn;
    quQuantityModelID: TIntegerField;
    quQuantityStoreID: TIntegerField;
    btViewStore: TSpeedButton;
    quBrowseModelType: TStringField;
    quBrowseReplacementCost: TBCDField;
    grdBrowseDBReplacementCost: TcxGridDBColumn;
    quBrowsePromotionPrice: TBCDField;
    quBrowseDiscountPerc: TFloatField;
    grdBrowseDBDiscountPerc: TcxGridDBColumn;
    grdBrowseDBPromotionPrice: TcxGridDBColumn;
    lbVendorCode: TLabel;
    edtVendorCode: TEdit;
    quModelVendorCode: TADODataSet;
    quModelVendorCodeIDModel: TIntegerField;
    quBrowseClassification: TStringField;
    grdBrowseDBClassification: TcxGridDBColumn;
    quBrowseCaseQty: TFloatField;
    grdBrowseDBCaseQty: TcxGridDBColumn;
    quBrowseTotQtyOnHand: TFloatField;
    quBrowseTotQtyOnRepair: TFloatField;
    quBrowseTotQtyOnPreSale: TFloatField;
    quBrowseTotQtyOnPrePurchase: TFloatField;
    quBrowseTotQtyOnOrder: TFloatField;
    quBrowsePositiveQty: TFloatField;
    quQuantityQtyOnPreSale: TFloatField;
    quQuantityQtyOnHand: TFloatField;
    quQuantityQtyOnOrder: TFloatField;
    quQuantityQtyOnRepair: TFloatField;
    quQuantityQtyOnPrePurchase: TFloatField;
    quQuantityMaxQty: TFloatField;
    quQuantityMinQty: TFloatField;
    quBrowseSubCategory: TStringField;
    quBrowseMGroup: TStringField;
    grdBrowseDBGroup: TcxGridDBColumn;
    grdBrowseDBSubCategory: TcxGridDBColumn;
    lbSubCategory: TLabel;
    sbSubCategory: TSuperComboADO;
    btnSubCateAll: TButton;
    lbGroup: TLabel;
    scModelGroup: TSuperComboADO;
    btnGroupAll: TButton;
    btnAddQuick: TSpeedButton;
    popNew: TPopupMenu;
    menAdd: TMenuItem;
    menQuickEntry: TMenuItem;
    quBrowseMarginPercent: TBCDField;
    grdBrowseDBMarginPercent: TcxGridDBColumn;
    quBrowseMarginValue: TBCDField;
    grdBrowseDBMarginValue: TcxGridDBColumn;
    quBrowseVerify: TBooleanField;
    grdBrowseDBVerify: TcxGridDBColumn;
    menQuickEntryList: TMenuItem;
    grdBrowseDBUserLastSellingPrice: TcxGridDBColumn;
    quBrowseUserLastSellingPrice: TStringField;
    btnDetailQuick: TSpeedButton;
    popDetail: TPopupMenu;
    menDetail: TMenuItem;
    menQuickEntryListDetail: TMenuItem;
    quBrowseIDGroup: TIntegerField;
    quBrowseIDModelGroup: TIntegerField;
    quBrowseIDModelSubGroup: TIntegerField;
    quBrowseMarkup: TBCDField;
    cdsModelList: TClientDataSet;
    cdsModelListIDModel: TIntegerField;
    cdsModelListModel: TStringField;
    cdsModelListDescription: TStringField;
    cdsModelListVendorCost: TFloatField;
    cdsModelListSellingPrice: TFloatField;
    cdsModelListSuggRetail: TCurrencyField;
    cdsModelListCaseQty: TFloatField;
    cdsModelListIDGroup: TIntegerField;
    cdsModelListIDModelGroup: TIntegerField;
    cdsModelListIDModelSubGroup: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    cdsModelListUpdate: TBooleanField;
    cdsModelListIDUserLastSellingPrice: TIntegerField;
    cdsModelListDateLastCost: TDateTimeField;
    cdsModelListDateLastSellingPrice: TDateTimeField;
    quBrowseIDUserLastSellingPrice: TIntegerField;
    cdsModelListMarkup: TFloatField;
    cdsModelListWarning: TStringField;
    scVendor: TSuperComboADO;
    btVedorAll: TButton;
    lbVendor: TLabel;
    quModelVendorCodeIDPessoa: TIntegerField;
    quBrowseIDManufacturer: TIntegerField;
    cdsModelListIDManufacturer: TIntegerField;
    cdsModelListMinQty: TFloatField;
    cdsModelListMaxQty: TFloatField;
    quBrowseIDBarcode: TStringField;
    grdBrowseDBBarcode: TcxGridDBColumn;
    lbModel: TLabel;
    edtModel: TEdit;
    quBrowseVendor: TStringField;
    grdBrowseDBVendor: TcxGridDBColumn;
    quBrowsePeso: TFloatField;
    grdBrowseDBIDCategory: TcxGridDBColumn;
    grdBrowseDBIDSubCategory: TcxGridDBColumn;
    grdBrowseDBIDGroup: TcxGridDBColumn;
    grdBrowseDBWeight: TcxGridDBColumn;
    grdBrowseDBIDManufacturer: TcxGridDBColumn;
    quBrowseIDVendor: TIntegerField;
    grdBrowseDBIDVendor: TcxGridDBColumn;
    quBrowseTotQtyFloating: TFloatField;
    quBrowseFloatPercent: TIntegerField;
    grdBrowseDBTotQtyFloating: TcxGridDBColumn;
    btExportScale: TSpeedButton;
    quBrowseUseLot: TBooleanField;
    grdBrowseDBUseLot: TcxGridDBColumn;
    quBrowseUnidade: TStringField;
    grdBrowseDBUnit: TcxGridDBColumn;
    ppReportKits: TppReport;
    btnPrintKits: TButton;
    dsKit: TDataSource;
    ppHeaderBandKit: TppHeaderBand;
    ppFooterBandKitFooter: TppFooterBand;
    ppDBPipelineKitInfo: TppDBPipeline;
    ppDBTextModel: TppDBText;
    ppDBTextQty: TppDBText;
    ppDBTextSellingPrice: TppDBText;
    ppDBTextFinalCost: TppDBText;
    ppDBTextTotQtyOnHand: TppDBText;
    ppDetaillBandItems: TppDetailBand;
    ppGroupKit: TppGroup;
    ppGroupHeaderBand: TppGroupHeaderBand;
    ppGroupFooterBand: TppGroupFooterBand;
    ppDBText1: TppDBText;
    ppLine1: TppLine;
    ppLabel1: TppLabel;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppLine3: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppLabel7: TppLabel;
    myDBCheckBox1: TmyDBCheckBox;
    ppLabelTotal: TppLabel;
    ppSystemVariablePage: TppSystemVariable;
    PopupMultDelete: TPopupMenu;
    popmDelete: TMenuItem;
    popmDeleteAll: TMenuItem;
    btnRemove: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btShowQuantityClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure quQuantityAfterOpen(DataSet: TDataSet);
    procedure scGroupSelectItem(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cmbListChange(Sender: TObject);
    procedure scFabricanteSelectItem(Sender: TObject);
    procedure btGroupAllClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btDetailGridClick(Sender: TObject);
    procedure btAdjustPricesClick(Sender: TObject);
    procedure btViewStoreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSubCateAllClick(Sender: TObject);
    procedure btnGroupAllClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure menQuickEntryClick(Sender: TObject);
    procedure menQuickEntryListClick(Sender: TObject);
    procedure menQuickEntryListDetailClick(Sender: TObject);
    procedure btnDetailQuickClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btVedorAllClick(Sender: TObject);
    procedure ImgTrashClick(Sender: TObject);
    procedure imgFolderClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure imgFolderDblClick(Sender: TObject);
    procedure ImgTrashDblClick(Sender: TObject);
    procedure btExportScaleClick(Sender: TObject);
    procedure btnPrintKitsClick(Sender: TObject);
    procedure popmDeleteAllClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    sShowQty, sHideQty, sOrigSQL : String;

    // Antonio 03/23/2017 - MR-32
    cdsKitInfo: TClientDataset;   // to get kit information
    cdsKit: TClientDataset;       // to get kit header
    cdsKitItems: TClientDataset;  // to get items from kit

    procedure SetKitSearchToPrint(argSearchKit: String);
    procedure OpenKit();
    procedure OpenKitItems(argGroupId: String; argIdModels: String);
    procedure PrintKit();
    procedure LoadReport(argPathReport: String);

    procedure UpdateGridItems(Operation:Integer);
    procedure OnBeforeDeleteItem; Override;
    procedure OnBeforeDeleteItems();
    procedure OnBeforeRestoreItem; Override;
    function GetModelVendorCode(VCode:String):String;
    function ValidateQtyOnDelete : Boolean;
    procedure ClearCategory;
    procedure ClearFabricante;
  protected
    procedure ReplicationControls; override;
    procedure AfterSetBrowseState; override;
    procedure ExecBrowseSQLOnDelete; override;
    procedure ExecBrowseSQLOnRestore; override;
  end;

implementation

{$R *.DFM}

uses uFchModel, uDM, uPrintInventory, uMsgBox, uFchInventory,
     uMsgConstant, uSystemTypes, uDMGlobal, uSystemConst, uSQLFunctions,
     {uFrmModelQuickEntry,} ufrmModelAdd,  uContentClasses, uFrmQuickEntryListInsert,
     uFrmQuickEntryListUpdate, uFrmModelPriceAdj, uPassword, uFrmExportScaleItem;


procedure TbrwModel.ReplicationControls;
begin
  inherited;
  btAdjustPrices.Visible := not fIsRestricForm;
end;

procedure TbrwModel.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchModel.Create(Self);
  ClearFabricante;
  ClearCategory;
  cmbList.ItemIndex := 0;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sShowQty := 'Show &Qty';
      sHideQty := 'Hide &Qty';
      sUrlHelp := '';
      sUrlVideo:= '';
    end;

    LANG_PORTUGUESE:
    begin
      sShowQty := 'Mostrar &Qtd';
      sHideQty := 'Esconder &Qtd';
      sUrlHelp := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Produto_Comum.htm';
      sUrlVideo:= 'http://www.mainretail.com.br/treinamento/video/Adicionar_Produto_Cadastro_Completo/Adicionar_Produto_Cadastro_Completo.html';
    end;

    LANG_SPANISH:
    begin
      sShowQty := 'Mostrar &Ctd';
      sHideQty := 'Esconder &Ctd';
      sUrlHelp := '';
      sUrlVideo:= '';
    end;
  end;

  btShowQuantity.Caption := sShowQty;
end;

procedure TbrwModel.btShowQuantityClick(Sender: TObject);
begin
  inherited;
  with pnlQuantity do
  begin
    if Visible = True then
    begin
      Visible := False;
      btShowQuantity.Caption := sShowQty;
      quQuantity.Close;
      btViewStore.Visible := False;
    end
    else
    begin
      quQuantity.Open;
      Visible := True;
      btShowQuantity.Caption := sHideQty;
      btViewStore.Visible := True;
    end;
  end;

  grdBrowse.SetFocus;
end;

procedure TbrwModel.FormDestroy(Sender: TObject);
begin
  inherited;
  with quQuantity do
    if Active then
      Close;
end;

procedure TbrwModel.quQuantityAfterOpen(DataSet: TDataSet);
var
  Empty : Boolean;
begin
  inherited;
  // Teste se existem itens na quantidade para mostrar o grid ou
  // mostar mensagem dizendo quer mercadoria nao foi movimentada
  //Empty := (quQuantity.EOF and quQuantity.BOF);

  //pnlNoQuantity.Visible := Empty;
  //grdQuantity.Visible   := not Empty;
end;

procedure TbrwModel.scGroupSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModel.CommandClick(Sender: TObject);
begin
  try

    if TBtnCommandType(TComponent(Sender).Tag) = btExc then
    begin
     if not ValidateQtyOnDelete then
     begin
       MsgBox(MSG_INF_ITEM_HAS_POS_QTY, vbOkOnly + vbExclamation);
       Exit;
     end
     else
     begin

       UpdateGridItems(TComponent(Sender).Tag);
       inherited;
     end;
    end
    else if ( TBtnCommandType(TComponent(sender).Tag) = btInc ) then
    begin
      menQuickEntryClick(sender);
      //inherited;
    end
    else begin
      UpdateGridItems(TComponent(Sender).Tag);
      inherited;
    end;
  except
    on E: Exception do
      MsgBox(E.Message, vbOkOnly + vbExclamation);
  end;
end;

procedure TbrwModel.OnBeforeDeleteItem;
Var
  iID : Integer;
begin
  // Incluo o movimento de inventario registrando a delecao
  iID := DM.GetNextID(MR_INVENTORY_MOV_ID);
  DM.RunSQL( 'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty, IDUser) ' +
             'VALUES ('+intToStr(iID)+',18, 1,' + IntToStr(DM.fStore.ID) + ', ' + quBrowseIDModel.AsString + ', GetDate(), 0, ' + IntToStr(DM.fUser.ID) + ')');
end;

procedure TbrwModel.OnBeforeRestoreItem;
Var
  iID : Integer;
begin
  // Incluo o movimento de inventario registrando a delecao
  iID := DM.GetNextID(MR_INVENTORY_MOV_ID);
  DM.RunSQL( 'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty, IDUser) ' +
             'VALUES ('+intToStr(iID)+',19, 1, ' + IntToStr(DM.fStore.ID) + ', ' + quBrowseIDModel.AsString + ', GetDate(), 0, ' + IntToStr(DM.fUser.ID) + ')');
end;

procedure TbrwModel.btnExecClick(Sender: TObject);
var
  sModelVendorCode, sWhere, sJoin: String;
begin
  inherited;

  // MR-108
  quBrowse.Filtered := FALSE;

  if BrowseConfig.MostraDesativado = STD_NAODESATIVADO then
    sWhere := ' WHERE M.Desativado = 0'
  else if BrowseConfig.MostraDesativado = STD_DESATIVADO then
    sWhere := ' WHERE M.Desativado = 1';

  // Se mostra os sub models ou nao
  if btDetailGrid.Down then
    sWhere := sWhere + ' AND M.ModelType in ('+QuotedStr('S')+', '+QuotedStr('R')+', '+QuotedStr('K')+')'
  else
    sWhere := sWhere + ' AND M.ModelType in ('+QuotedStr('M')+', '+QuotedStr('R')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+')' ;

  // Primeiro o filtro por tipo de lista
  case cmbList.ItemIndex of
    0: // Todos
      sWhere := sWhere + '';
    1: // Quantidade positiva
      sWhere := sWhere + ' AND IsNull(M.TotQtyOnHand, 0) > 0';
    2: // Quantidade zerada
      sWhere := sWhere + ' AND IsNull(M.TotQtyOnHand, 0) = 0';
    3: // Quantidade negativa
      sWhere := sWhere + ' AND IsNull(M.TotQtyOnHand, 0) < 0';
  end;

  // MR-108
  // Will allow user select a single delete or mult delete just to totqtyOnHand = 0
  btnRemove.Visible := cmbList.ItemIndex = 2;

  // Agora o filtro por Category
  if scGroup.LookUpValue <> '' then begin
     sWhere := sWhere + '  AND M.GroupID = ' + scGroup.LookUpValue;
  end;

  // Antonio 03/22/2017 (MR-32)
  btnPrintKits.Visible := ( Pos('kit', LowerCase(scGroup.EditText)) > 0 ) or
                          ( Pos('kits', LowerCase(scGroup.EditText)) > 0 );

  // E finalmente o filtro por fabricante
  if scFabricante.LookUpValue <> '' then
    sWhere := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

  if edtVendorCode.Text <> '' then
  begin
    sModelVendorCode := GetModelVendorCode(edtVendorCode.Text);
    if sModelVendorCode <> '' then
      sWhere := sWhere + ' AND M.IDModel IN (' + sModelVendorCode + ')';
    end;

  // Subcategory
  if sbSubCategory.LookUpValue <> '' then
    sWhere := sWhere + ' AND M.IDModelGroup = ' + sbSubCategory.LookUpValue;

  // group
  if scModelGroup.LookUpValue <> '' then
    sWhere := sWhere + ' AND M.IDModelSubGroup = ' + scModelGroup.LookUpValue;

  // search by model or barcode
  if edtModel.Text <> '' then
    sWhere := sWhere + ' AND (lower(M.Model) like ' + QuotedStr('%' + lowercase(edtModel.Text) + '%') +
    						  ') or (B.IDBarcode like ' + quotedStr('%' + edtModel.Text + '%') + ')';

  // O filtro por fornecedor
  if scVendor.LookUpValue <> '' then
  begin
    sJoin := 'INNER JOIN Inv_ModelVendor IMV ON (M.IDModel = IMV.IDModel) ' +
             'INNER JOIN Pessoa V ON (IMV.IDPessoa = V.IDPessoa) ';
    sWhere := sWhere + 'AND IMV.IDPessoa = ' + scVendor.LookUpValue;
  end
  else
    sJoin := 'LEFT JOIN Inv_ModelVendor IMV ON (M.IDModel = IMV.IDModel AND IMV.VendorOrder = 1) ' +
             'LEFT JOIN Pessoa V ON (IMV.IDPessoa = V.IDPessoa) ';

  with quBrowse do
  begin
    Close;

    CommandText := sOrigSQL + sJoin + sWhere;


    SetKitSearchToPrint(CommandText);

    Open;
  end;



  DesativaAviso;
end;

procedure TbrwModel.cmbListChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModel.scFabricanteSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModel.btGroupAllClick(Sender: TObject);
begin
  inherited;
  ClearCategory;
  scGroup.SetFocus;
end;

procedure TbrwModel.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  ClearFabricante;
  scFabricante.SetFocus;
end;

procedure TbrwModel.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quBrowseTotQtyOnHand.AsFloat < 0 then
    quBrowsePositiveQty.AsFloat := 0
  else
    quBrowsePositiveQty.AsFloat := quBrowseTotQtyOnHand.AsFloat;

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

  //Calcular a quantidade Flutuante do Modelo
  if (not grdBrowseDBTotQtyFloating.Visible) or (quBrowseFloatPercent.AsFloat = 0) then
  begin
     quBrowseTotQtyFloating.AsFloat := (quBrowseTotQtyOnHand.AsFloat - quBrowseTotQtyOnPreSale.AsFloat);
     Exit;
  end;

  if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
    quBrowseTotQtyFloating.AsFloat := (quBrowseTotQtyOnHand.AsFloat - quBrowseTotQtyOnPreSale.AsFloat) +
                                     ((quBrowseTotQtyOnPreSale.AsFloat * quBrowseFloatPercent.AsFloat)) / 100
  else
    quBrowseTotQtyFloating.AsFloat := Trunc((quBrowseTotQtyOnHand.AsFloat - quBrowseTotQtyOnPreSale.AsFloat) +
                                     ((quBrowseTotQtyOnPreSale.AsFloat * quBrowseFloatPercent.AsFloat)) / 100);
end;

procedure TbrwModel.btDetailGridClick(Sender: TObject);
begin
  inherited;
  if quBrowse.Active then
    btnExecClick(nil);
end;

procedure TbrwModel.btAdjustPricesClick(Sender: TObject);
var
  sMenu: String;
begin
  if Password.Start(5, 15) then
  begin
    sMenu := DM.fMainMenu.SubMenuName;
    DM.fMainMenu.SubMenuName := btAdjustPrices.Caption;

    try
      with TfrmModelPriceAdj.Create(Self) do
         Start('', 'PriceAdjust=1');
    finally
      DM.fMainMenu.SubMenuName := sMenu;
    end;
  end;
end;

procedure TbrwModel.btViewStoreClick(Sender: TObject);
var
  PosID1, PosID2 : string;
begin
  inherited;

  if (quQuantityStoreID.AsInteger = 0) or
     (quQuantityModelID.AsInteger = 0) or
     (quBrowseModelType.AsString = 'M') then
     Exit;

  if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
    PosID1 := IntToStr(DM.fStore.ID)
  else
    PosID1 := quQuantityStoreID.AsString;

  PosID2 := quQuantityModelID.AsString;

  //Inventory view inventory
  with TFchInventory.Create(Self) do
     Start(btAlt, nil, False, PosID1, PosID2, nil);

end;

procedure TbrwModel.UpdateGridItems(Operation: Integer);
var
  fDesativo : String;
begin
  fDesativo := '';

  if TBtnCommandType(Operation) = btExc then
     fDesativo := 'Desativado=1'
  else if TBtnCommandType(Operation) = btRest then
     fDesativo := 'Desativado=0';

  if fDesativo <> '' then
     DM.RunSQL('Update Model Set ' +fDesativo+ ' Where IDModelParent = ' + quBrowseIDModel.AsString);

end;

function TbrwModel.GetModelVendorCode(VCode: String): String;
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

procedure TbrwModel.FormShow(Sender: TObject);
begin
  inherited;
  btnAddQuick.Enabled := btAdd.Enabled;
  btnDetailQuick.Enabled := btDetail.Enabled;
  btExportScale.Visible := (DM.fCashRegister.ScaleCheck) and
   ((DM.fCashRegister.ScaleType = 0) or (DM.fCashRegister.ScaleType = 1));

  if DM.fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
  begin
    btShowQuantityClick(Self);
    grdBrowseDBTotQtyOnHand.Hidden  := True;
    grdBrowseDBTotQtyOnHand.Visible := False;
  end;

  sOrigSQL := quBrowse.CommandText;

  if not Password.HasFuncRight(2) then
  begin
    grdBrowseDBVendorCost.Visible := False;
    grdBrowseDBFinalCost.Visible := False;
    grdBrowseDBSubFinalCost.Visible := False;
    grdBrowseDBSubVendorCost.Visible := False;

    grdBrowseDBVendorCost.Hidden := True;
    grdBrowseDBFinalCost.Hidden := True;
    grdBrowseDBSubFinalCost.Hidden := True;
    grdBrowseDBSubVendorCost.Hidden := True;
  end;
end;

procedure TbrwModel.btnSubCateAllClick(Sender: TObject);
begin
  inherited;
  sbSubCategory.LookUpValue := '';
  sbSubCategory.Text        := '';
  sbSubCategory.SetFocus;
  AtivaAviso;
end;

procedure TbrwModel.btnGroupAllClick(Sender: TObject);
begin
  inherited;
  scModelGroup.LookUpValue := '';
  scModelGroup.Text        := '';
  scModelGroup.SetFocus;
  AtivaAviso;
end;

procedure TbrwModel.AfterSetBrowseState;
begin
  inherited;
//  btnAddQuick.Visible   := btAdd.Visible;
  menAdd.Enabled        := btAdd.Visible;
  menQuickEntry.Enabled := btAdd.Visible;
{  if btnAddQuick.Visible then
     btnAddQuick.Enabled := btAdd.Enabled; } 
end;

procedure TbrwModel.btnAddQuickClick(Sender: TObject);
var
  P : TPoint;
begin
  inherited;
  GetCursorPos(P);
  popNew.Popup(P.X, P.Y);
end;

procedure TbrwModel.menQuickEntryClick(Sender: TObject);
var
  ABarcode: TBarcode;
//  FFrmModelQuickEntry : TFrmModelQuickEntry;
  FFrmModelAdd: TfrmModelAdd;
begin
  inherited;

  try
    FFrmModelAdd := TFrmModelAdd.Create(Self);

    ABarcode := FFrmModelAdd.Start(False, False, False, '');
    if ABarcode.Model.IDModel <> -1 then
      btnExecClick(Self);
  finally
    FreeAndNil(FFrmModelAdd);
    end;
end;

procedure TbrwModel.menQuickEntryListClick(Sender: TObject);
begin
  with TFrmQuickEntryListInsert.Create(Self) do
    try
      if Start(null) then
         btnExecClick(Self);
    finally
      Free;
    end;
end;

procedure TbrwModel.menQuickEntryListDetailClick(Sender: TObject);
begin
  with quBrowse do
    try
      DisableControls;
      First;

      cdsModelList.CreateDataSet;

      while not(Eof) do
      begin
        cdsModelList.Append;
        cdsModelList.FieldByName('IDModel').Value          := FieldByName('IDModel').Value;
        cdsModelList.FieldByName('Model').Value            := FieldByName('Model').Value;
        cdsModelList.FieldByName('Description').Value      := FieldByName('Description').Value;
        cdsModelList.FieldByName('VendorCost').Value       := FieldByName('VendorCost').Value;
        cdsModelList.FieldByName('SellingPrice').Value     := FieldByName('SellingPrice').Value;
        cdsModelList.FieldByName('SuggRetail').Value       := FieldByName('SuggRetail').Value;
        cdsModelList.FieldByName('CaseQty').Value          := FieldByName('CaseQty').Value;
        cdsModelList.FieldByName('IDGroup').Value          := FieldByName('IDGroup').Value;
        cdsModelList.FieldByName('IDModelGroup').Value     := FieldByName('IDModelGroup').Value;
        cdsModelList.FieldByName('IDModelSubGroup').Value  := FieldByName('IDModelSubGroup').Value;
        cdsModelList.FieldByName('Markup').Value           := FieldByName('Markup').Value;
        cdsModelList.FieldByName('DateLastCost').Value     := FieldByName('DateLastCost').Value;
        cdsModelList.FieldByName('IDManufacturer').Value   := FieldByName('IDManufacturer').Value;
        cdsModelList.FieldByName('IDUserLastSellingPrice').Value := FieldByName('IDUserLastSellingPrice').Value;
        cdsModelList.FieldByName('DateLastSellingPrice').Value   := FieldByName('DateLastSellingPrice').Value;
        cdsModelList.FieldByName('Update').Value           := True;
        cdsModelList.FieldByName('MarginInfo').Value       := 0.0;
        cdsModelList.FieldByName('MarkupInfo').Value       := 0.0;

        cdsModelList.Post;
        Next;
      end;

    with TFrmQuickEntryListUpdate.Create(Self) do
      try
        if Start(cdsModelList.Data) then
           btnExecClick(Self);

        while cdsModelList.Eof do
          cdsModelList.Delete;
      finally
        Free;
      end;
  finally
     EnableControls;
     cdsModelList.Close;
  end;
end;

procedure TbrwModel.btnDetailQuickClick(Sender: TObject);
var
  P : TPoint;
begin
  inherited;
  GetCursorPos(P);
  popDetail.Popup(P.X, P.Y);
end;

procedure TbrwModel.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  menDetail.Enabled := (not DataSet.IsEmpty);
  menQuickEntryListDetail.Enabled := menDetail.Enabled;
end;

procedure TbrwModel.btVedorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text        := '';
  scVendor.SetFocus;
  AtivaAviso;
end;

procedure TbrwModel.ImgTrashClick(Sender: TObject);
begin
  inherited;
  btnExecClick(Sender);
end;

procedure TbrwModel.imgFolderClick(Sender: TObject);
begin
  inherited;
  btnExecClick(Sender);
end;

procedure TbrwModel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F4 then
  begin
    if quBrowseTotQtyOnHand.AsFloat > 0 then
    begin
      MsgBox(MSG_INF_ITEM_HAS_POS_QTY, vbExclamation + vbOkOnly);
      Exit;
    end
    else
    begin
      inherited;
      btnExecClick(Self);
    end;
  end
  else if Key = VK_RETURN then
    btnExecClick(Self)
  else
    inherited;
    
end;

procedure TbrwModel.imgFolderDblClick(Sender: TObject);
begin
  //inherited;
  BrowseConfig.MostraDesativado := STD_DESATIVADO;
  SetBrowseState;
  btnExecClick(Self);
end;

procedure TbrwModel.ImgTrashDblClick(Sender: TObject);
begin
  //inherited;
  BrowseConfig.MostraDesativado := STD_NAODESATIVADO;
  SetBrowseState;
  btnExecClick(Self);
end;

procedure TbrwModel.ExecBrowseSQLOnDelete;
begin
  //inherited;
  btnExecClick(Self);
end;

procedure TbrwModel.ExecBrowseSQLOnRestore;
begin
  //inherited;
  btnExecClick(Self);
end;

procedure TbrwModel.btExportScaleClick(Sender: TObject);
begin
  inherited;
  with TFrmExportScaleItem.Create(Self) do
    Start;
end;

function TbrwModel.ValidateQtyOnDelete: Boolean;
begin

  Result := False;

  if quBrowse.Active then
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(ABS(QtyOnHand)) as TotQty');
      SQL.Add('FROM Inventory');
      SQL.Add('WHERE ModelId = ' + quBrowseIDModel.AsString);
      Open;
      Result := FieldByName('TotQty').AsFloat = 0;
    finally
      Close;
    end;
end;

procedure TbrwModel.ClearCategory;
begin
  scGroup.LookUpValue := '';
  scGroup.Text        := '';
  AtivaAviso;
end;

procedure TbrwModel.ClearFabricante;
begin
  scFabricante.LookUpValue := '';
  scFabricante.Text        := '';
  AtivaAviso;
end;

procedure TbrwModel.SetKitSearchToPrint(argSearchKit: String);
begin
  cdsKit := dm.GetKitCategory(argSearchKit);
end;

procedure TbrwModel.PrintKit();
begin
   // open records to call print
   // open kitInfo
   OpenKit();

   LoadReport(ppReportKits.Template.FileName);
   try
      ppReportKits.Print;

      if ( cdsKitItems <> nil ) then begin
          FreeAndNil(cdsKitItems);
      end;

   except
      on e: Exception do begin
         raise e.Create('Print Kits failed: ' + e.Message);
      end;
   end;

end;

procedure TbrwModel.OpenKit();
var
   loListModels: TStringList;
   liKitCounter: Integer;
   lsKitGroup: String;
begin
  try
      loListModels := TStringList.Create();

      if ( not cdsKit.Active ) then begin
         cdsKit.Open;
      end;

      cdsKit.Open();

      // get the group of category to kit
      lsKitGroup := cdsKit.fieldByName('idgroup').AsString;

      liKitCounter := 0;

      // get the list of models from search applied ( just in case of category similar to "kit"
      while ( not cdsKit.Eof ) do begin

          if ( liKitCounter > 0 ) then begin
             loListModels.add(', ' + cdsKit.fieldByName('idmodel').AsString);
          end else begin
                  loListModels.add(cdsKit.fieldByName('idmodel').AsString);
              end;

          inc(liKitCounter);
          cdsKit.Next();
      end;



      OpenKitItems(lsKitGroup, String(loListModels.Text));
  finally
     FreeAndNil(loListModels);
  end;
end;

procedure TbrwModel.OpenKitItems(argGroupId: String; argIdModels: String);
begin
  if ( cdsKitItems <> nil ) then begin
     cdsKitItems.Close();
     FreeAndNil(cdsKitItems);
  end;


  cdsKitItems := dm.GetKitItems( argGroupId, argIdModels );
  dsKit.DataSet := cdsKitItems;

end;

procedure TbrwModel.LoadReport(argPathReport: String);
var
  sMessage: String;
  saveDefaultTemplate: String;
begin

  if argPathReport <> '[SYSTEM]' then begin
    // Antonio M F Souza 10.03.2011 - begin
    saveDefaultTemplate := ppReportKits.Template.FileName;
    ppReportKits.Template.FileName := argPathReport;
 end;

 // Antonio M F Souza 10.03.2011 - end
 if FileExists(argPathReport) then
 begin
    // Antonio, August 13, 2013
    ppReportKits.Reset;

    ppReportKits.Template.FileName := argPathReport;
    ppReportKits.Template.LoadFromFile;
    ppReportKits.AllowPrintToArchive := True;
    ppReportKits.AllowPrintToFile    := True;
 end
  //Antonio M F Souza 10.20.2011 - begin
 else begin
    sMessage := 'Report to kits is not present. Default report will be used instead';
    application.MessageBox(Pchar(sMessage), 'File not found', mb_OK + mb_IconStop);
    ppReportKits.Template.Filename := saveDefaultTemplate;
 end;
  //Antonio M F Souza 10.20.2011 - end

end;

procedure TbrwModel.btnPrintKitsClick(Sender: TObject);
begin
  inherited;
  PrintKit();
end;

procedure TbrwModel.popmDeleteAllClick(Sender: TObject);
var
  idsSelected: TStringList;
  i: Integer;
  saveCmdText:String;
begin
  inherited;

  // MR-108 to call multi delete
  if (MsgBox(MSG_QST_CONFIRM, vbYesNo + vbQuestion) = vbYes) then begin
      try
          idsSelected := TStringlist.Create();

          try
             dm.ADODBConnect.BeginTrans();
             OnBeforeDeleteItems();

             quBrowse.DisableControls;
             quBrowse.First;

             while ( not quBrowse.Eof ) do begin
                   if ( quBrowse.RecNo = 1 ) then begin
                        idsSelected.add(quBrowse.fieldByName('IdModel').AsString);
                   end else begin
                           idsSelected.add(', ' + quBrowse.fieldByName('IdModel').AsString);
                       end;

                   quBrowse.Next();
             end;

             dm.DeactivateModel(idsSelected);

             dm.ADODBConnect.CommitTrans();
             saveCmdText := quBrowse.CommandText;
             quBrowse.Close();
             quBrowse.CommandText := saveCmdText;
             quBrowse.Open();
          except
             on e:Exception do begin
                dm.ADODBConnect.RollbackTrans();
                raise e.Create('I cannot do mult delete: ' + e.Message);
             end;
          end;
      finally
          FreeAndNil(idsSelected);
      end;
  end;



end;

procedure TbrwModel.btnRemoveClick(Sender: TObject);
var
   point: TPoint;
begin
  inherited;

  // MR-108
  GetCursorPos(point);
  PopupMultDelete.Popup(point.X, point.Y);
end;

procedure TbrwModel.OnBeforeDeleteItems();
begin
    while ( not quBrowse.Eof ) do begin
       OnBeforeDeleteItem();
       quBrowse.Next();
    end;
end;

end.
