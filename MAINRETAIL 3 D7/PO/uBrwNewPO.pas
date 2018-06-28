unit uBrwNewPO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Db, DBTables, ExtCtrls, Grids, LblEffct, StdCtrls, ComCtrls,
  Mask, DBCtrls, uFrmNewPO, uFrmPO, ResizePanel, Buttons, uFchPessoa,
  MPlayer, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, uFrameSendContact,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, cxButtons,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxLookAndFeelPainters, Menus;

type
  TBrwNewPO = class(TFrmParent)
    quPO: TADOQuery;
    quPOItem: TPowerADOQuery;
    dsPO: TDataSource;
    dsPOItem: TDataSource;
    spRemovePOItem: TADOStoredProc;
    spRemovePO: TADOStoredProc;
    quPOIDPO: TIntegerField;
    quPOIDFornecedor: TIntegerField;
    quPODataPedido: TDateTimeField;
    quPOSubTotal: TFloatField;
    quPOIDStore: TIntegerField;
    quPOCharges: TFloatField;
    quPOFreight: TFloatField;
    quPOTotal: TCurrencyField;
    pnlPO: TPanel;
    pnlPOItem: TPanel;
    quPOFornecedor: TStringField;
    pnlPODetail: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    pnlPOToolBar: TPanel;
    Label12: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Panel5: TPanel;
    btPOItemAdd: TSpeedButton;
    btPOItemOpen: TSpeedButton;
    pnlEspaco: TPanel;
    btPOItemRemove: TSpeedButton;
    btPOItemPreview: TSpeedButton;
    Panel6: TPanel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label16: TLabel;
    quPOItemIDPreInventoryMov: TIntegerField;
    quPOItemDocumentID: TIntegerField;
    quPOItemIDModel: TIntegerField;
    quPOItemModel: TStringField;
    quPOItemDescription: TStringField;
    quPOItemCostPrice: TFloatField;
    quPOItemSalePrice: TFloatField;
    quPOItemSuggRetail: TFloatField;
    quPOItemSubTotal: TFloatField;
    quPOItemPessoa: TStringField;
    quPOItemMovDate: TDateTimeField;
    quPOItemDateEstimatedMov: TDateTimeField;
    btCustomizeColumns: TSpeedButton;
    btGroup: TSpeedButton;
    quPOItemCurrentSale: TFloatField;
    quPOItemCurrentCost: TFloatField;
    quPOItemCurrentSuggRetail: TFloatField;
    quPOItemCategory: TStringField;
    quPOItemSize: TStringField;
    quPOItemCodSize: TStringField;
    quPOItemColor: TStringField;
    quPOItemCodColor: TStringField;
    btDetailGrid: TSpeedButton;
    quPOStore: TStringField;
    quPOEstArrival: TDateTimeField;
    SendPO: TFrameSendContact;
    quPOItemModelType: TStringField;
    grdPOItem: TcxGrid;
    grdPOItemDB: TcxGridDBTableView;
    grdPOItemLevel: TcxGridLevel;
    grdPOItemDBModel: TcxGridDBColumn;
    grdPOItemDBDescription: TcxGridDBColumn;
    grdPOItemDBQty: TcxGridDBColumn;
    grdPOItemDBQtyRealMov: TcxGridDBColumn;
    grdPOItemDBCostPrice: TcxGridDBColumn;
    grdPOItemDBSalePrice: TcxGridDBColumn;
    grdPOItemDBSuggRetail: TcxGridDBColumn;
    grdPOItemDBSubTotal: TcxGridDBColumn;
    grdPOItemDBPessoa: TcxGridDBColumn;
    grdPOItemDBMovDate: TcxGridDBColumn;
    grdPOItemDBDateEstimatedMov: TcxGridDBColumn;
    grdPOItemDBCurrentSale: TcxGridDBColumn;
    grdPOItemDBCurrentCost: TcxGridDBColumn;
    grdPOItemDBCurrentSuggRetail: TcxGridDBColumn;
    grdPOItemDBCategory: TcxGridDBColumn;
    grdPOItemDBSize: TcxGridDBColumn;
    grdPOItemDBCodSize: TcxGridDBColumn;
    grdPOItemDBColor: TcxGridDBColumn;
    grdPOItemDBCodColor: TcxGridDBColumn;
    DBEdit5: TDBEdit;
    grdPO: TcxGrid;
    grdPODB: TcxGridDBTableView;
    grdPOLevel: TcxGridLevel;
    grdPODBIDPO: TcxGridDBColumn;
    grdPODBIDFornecedor: TcxGridDBColumn;
    grdPODBDataPedido: TcxGridDBColumn;
    grdPODBSubTotal: TcxGridDBColumn;
    grdPODBIDStore: TcxGridDBColumn;
    grdPODBCharges: TcxGridDBColumn;
    grdPODBFreight: TcxGridDBColumn;
    grdPODBTotal: TcxGridDBColumn;
    grdPODBFornecedor: TcxGridDBColumn;
    grdPODBStore: TcxGridDBColumn;
    grdPODBEstArrival: TcxGridDBColumn;
    grdPOItemDBIDPreInventoryMov: TcxGridDBColumn;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    GridPopupMenu: TcxGridPopupMenu;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    quPOPayDays: TIntegerField;
    quPOOBS: TStringField;
    quPOItemQty: TFloatField;
    quPOItemQtyRealMov: TFloatField;
    quPOItemCaseQty: TFloatField;
    quPOItemCaseCost: TBCDField;
    grdPOItemDBCaseQty: TcxGridDBColumn;
    grdPOItemDBCaseCost: TcxGridDBColumn;
    btNewPO: TcxButton;
    popPOOption: TPopupMenu;
    menAddPO: TMenuItem;
    menMultiplePO: TMenuItem;
    menAutogenerate: TMenuItem;
    btRemovePO: TcxButton;
    btVendorDetail: TcxButton;
    btnAddQuick: TSpeedButton;
    popNew: TPopupMenu;
    menAdd: TMenuItem;
    menQuickEntry: TMenuItem;
    N1: TMenuItem;
    menAutogenerateSingle: TMenuItem;
    quPOItemMarginPercent: TBCDField;
    quPOItemMarginValue: TBCDField;
    grdPOItemDBMarginPercent: TcxGridDBColumn;
    grdPOItemDBMarginValue: TcxGridDBColumn;
    quPOItemWeight: TBCDField;
    grdPOItemDBWeight: TcxGridDBColumn;
    quPOItemTotalWeight: TCurrencyField;
    grdPOItemDBTotalWeight: TcxGridDBColumn;
    menUpdatePO: TMenuItem;
    N2: TMenuItem;
    lblStatus: TLabel;
    lblStore: TLabel;
    cmbStore: TSuperComboADO;
    cbxStatus: TComboBox;
    btAreaTodas: TButton;
    Panel4: TPanel;
    btnCopyPO: TSpeedButton;
    quPOItemClosed: TPowerADOQuery;
    quPOItemClosedIDPreInventoryMov: TIntegerField;
    quPOItemClosedDocumentID: TIntegerField;
    quPOItemClosedQty: TBCDField;
    quPOItemClosedQtyRealMov: TBCDField;
    quPOItemClosedMovDate: TDateTimeField;
    quPOItemClosedModelType: TStringField;
    quPOItemClosedDateEstimatedMov: TDateTimeField;
    quPOItemClosedCostPrice: TBCDField;
    quPOItemClosedSalePrice: TBCDField;
    quPOItemClosedSuggRetail: TBCDField;
    quPOItemClosedSubTotal: TBCDField;
    quPOItemClosedIDModel: TIntegerField;
    quPOItemClosedModel: TStringField;
    quPOItemClosedCurrentSale: TBCDField;
    quPOItemClosedCurrentCost: TBCDField;
    quPOItemClosedCurrentSuggRetail: TBCDField;
    quPOItemClosedDescription: TStringField;
    quPOItemClosedWeight: TBCDField;
    quPOItemClosedMarginPercent: TBCDField;
    quPOItemClosedMarginValue: TBCDField;
    quPOItemClosedPessoa: TStringField;
    quPOItemClosedCategory: TStringField;
    quPOItemClosedSize: TStringField;
    quPOItemClosedCodSize: TStringField;
    quPOItemClosedColor: TStringField;
    quPOItemClosedCaseQty: TBCDField;
    quPOItemClosedCaseCost: TBCDField;
    quPOItemClosedCodColor: TStringField;
    quPOItemClosedTotalWeight: TCurrencyField;
    cmdInsClonePO: TADOCommand;
    cmdInsClonePoItems: TADOCommand;
    spAtuPOTotal: TADOStoredProc;
    btnMergePO: TSpeedButton;
    lbMinPO: TLabel;
    DBEdit7: TDBEdit;
    quPOLimite: TCurrencyField;
    quPOItemBarcode: TStringField;
    grdPOItemDBBarcode: TcxGridDBColumn;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    quPOItemQtyOnHand: TBCDField;
    grdPOItemDBOnHand: TcxGridDBColumn;
    quPOItemStoreID: TIntegerField;
    quPOItemIdPessoa: TIntegerField;
    quPOItemInventMovTypeID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btNewPOClick(Sender: TObject);
    procedure btRemovePOClick(Sender: TObject);
    procedure quPOCalcFields(DataSet: TDataSet);
    procedure btVendorDetailClick(Sender: TObject);
    procedure btPOItemPreviewClick(Sender: TObject);
    procedure btCustomizeColumnsClick(Sender: TObject);
    procedure quPOAfterScroll(DataSet: TDataSet);
    procedure btGroupClick(Sender: TObject);
    procedure btDetailGridClick(Sender: TObject);
    procedure quPOAfterOpen(DataSet: TDataSet);
    procedure quPOItemAfterOpen(DataSet: TDataSet);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure quPOBeforeOpen(DataSet: TDataSet);
    procedure SendPOsbEmailFileClick(Sender: TObject);
    procedure SendPObtPreviewVendorFaxClick(Sender: TObject);
    procedure grdPOItemDBDblClick(Sender: TObject);
    procedure menAutogenerateClick(Sender: TObject);
    procedure menMultiplePOClick(Sender: TObject);
    procedure menQuickEntryClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure menAutogenerateSingleClick(Sender: TObject);
    procedure quPOItemCalcFields(DataSet: TDataSet);
    procedure menUpdatePOClick(Sender: TObject);
    procedure grdPODBDblClick(Sender: TObject);
    procedure cbxStatusChange(Sender: TObject);
    procedure quPOItemClosedAfterOpen(DataSet: TDataSet);
    procedure quPOItemClosedCalcFields(DataSet: TDataSet);
    procedure btnCopyPOClick(Sender: TObject);
    procedure btnMergePOClick(Sender: TObject);
    procedure menAddPOClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    MyFrmNewPO: TFrmNewPO;
    MyFrmPO: TFrmPO;
    FchFornecedor: TFchPessoa;
    AView: TcxCustomGridTableView;
    iLastIDPO: Integer;
    sPOSQL: string;
    FRefreshCount: Integer;
    FAddPOType : Integer;

    procedure callNewPO(arg_oper: String = 'insert');
    procedure SetGridSizeColorMode;

    procedure RefreshAll;

    procedure POOpen;
    procedure POClose;
    procedure POSave;
    procedure PORequery;

    procedure POItemOpen;
    procedure POItemClose;
    procedure POItemRequery(bFull: boolean);

    procedure ReplicationControls;
    function POItemInReceiving: Boolean;

    procedure RemoveItem;
    function RemoveLeftItems : Boolean;

    function InsertClonePO: Integer;
    procedure InsertClonePOItems(AIDClonePO: Integer);
    procedure AtuPOTotal(AIDClonePO: Integer);

    procedure SelectAddInfo(AddOption : Integer);
  protected
    procedure LoadImages;
  public
    function Start: Boolean;
  end;

implementation

uses uDM, xBase, uMsgBox, uMsgConstant, uSystemTypes, uSystemConst, uDMGlobal,
  uDateTimeFunctions, uFrmNewPOAuto, uFrmNewMultPO, uFrmPrintPO, uSQLFunctions,
  uFrmNewPOQuickEntry, uFrmMergePO, uWebFunctions;

{$R *.DFM}

procedure TBrwNewPO.LoadImages;
begin
  DM.imgSmall.GetBitmap(BTN18_NEW,btPOItemAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE,btPOItemRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN,btPOItemOpen.Glyph);
  DM.imgSmall.GetBitmap(BTN18_PREVIEW,btPOItemPreview.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btCustomizeColumns.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADDALL, btnCopyPO.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btnMergePO.Glyph);
end;

procedure TBrwNewPO.ReplicationControls;
begin
  btPOItemRemove.Visible := not fIsRestricForm;
  btNewPO.Visible        := btPOItemRemove.Visible;
  btRemovePO.Visible     := btPOItemRemove.Visible;

  if btPOItemAdd.Visible then
    btPOItemAdd.Visible := not fIsRestricForm;

  btnAddQuick.Visible := btPOItemAdd.Visible;
end;

procedure TBrwNewPO.POOpen;
begin
  with quPO do
  begin
    case cbxStatus.ItemIndex of
      0: Parameters.ParamByName('Aberto').Value := 1;
      1: Parameters.ParamByName('Aberto').Value := 0;
    end;

    if not Active then
      Open;
  end;
end;

procedure TBrwNewPO.POSave;
begin
  with quPO do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TBrwNewPO.POClose;
begin
  POSave;

  with quPO do
    if Active then
      Close;
end;

procedure TBrwNewPO.PORequery;
var
  iCurrentIDPO: integer;
begin
  quPO.DisableControls;

  try
    if quPO.Active then
      iCurrentIDPO := quPOIDPO.AsInteger;

    POClose;
    POOpen;

    quPO.Locate('IDPO', IntToStr(iCurrentIDPO), []);
  finally
    quPO.EnableControls;
  end;

end;

procedure TBrwNewPO.POItemOpen;
begin
  if cbxStatus.ItemIndex = 0 then
    dsPOItem.DataSet := quPOItem
  else
    dsPOItem.DataSet := quPOItemClosed;

  // Alem de abrir a query devo setar a sugestao de fields para a ficha.
  with TPowerADOQuery(dsPOItem.DataSet) do
    if not Active then
    begin
      ClearFilters;
      AddFilter(['DocumentID','IDPessoa', 'StoreID'], [quPOIDPO.AsString, quPOIDFornecedor.AsString, IntToStr(DM.fStore.ID)]);

      Parameters.ParamByName('IDPO').Value := quPOIDPO.AsInteger;

      // Antonio Dec 05 2013, needed to be set gridmodel parameter
      parameters.paramByName('GridMode').Value := 'M';
      Open;
    end;
end;

procedure TBrwNewPO.POItemClose;
begin
  with quPOItem do
    if Active then
      Close;

  with quPOItemClosed do
    if Active then
      Close;
end;

procedure TBrwNewPO.POItemRequery(bFull: boolean);
begin
  if ((iLastIDPO <> quPOIDPO.AsInteger) or (quPO.RecordCount = 1) ) or bFull then
  begin
    POItemClose;
    POItemOpen;
    iLastIDPO := quPOIDPO.AsInteger;
  end;
end;

procedure TBrwNewPO.FormShow(Sender: TObject);
begin
  inherited;
  FRefreshCount := 0;

  Screen.Cursor := crHourGlass;

  //Variavel criada pq o dataset abria 5 vezes
  RefreshAll;

  grdPODB.Controller.GoToFirst;

  Screen.Cursor := crDefault;
end;

procedure TBrwNewPO.FormCreate(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  LoadImages;

//  MyFrmNewPO := TFrmNewPO.Create(Self);
  MyFrmPO := TFrmPO.Create(Self);

  SetGridSizeColorMode;

  Screen.Cursor := crDefault;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

  sPOSQL := quPO.SQL.Text;

  AView := TcxCustomGridTableView(grdPOItem.FocusedView);

  //PO
  SendPO.Init(2);

  SelectAddInfo(DM.FMainRetailConfig.ReadInteger('PO', 'AddPO', 1));

  case FAddPOType of
    1 : menAddPO.Checked              := True;
    2 : menMultiplePO.Checked         := True;
    3 : menAutogenerateSingle.Checked := True;
    4 : menAutogenerate.Checked       := True;
  end;

  //Verifica se o form e do tipo de replicagem
  fIsRestricForm := DM.IsFormsRestric(Self.Name);
  ReplicationControls;
end;

procedure TBrwNewPO.FormDestroy(Sender: TObject);
begin
  inherited;
  SendPO.UnInit;

//  MyFrmNewPO.Free;
  MyFrmPO.Free;

  if FchFornecedor <> nil then
    FchFornecedor.Free;
end;

procedure TBrwNewPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  POClose;
  POItemClose;

  Action := caFree;
end;

procedure TBrwNewPO.btAddClick(Sender: TObject);
var
  PosID1, PosID2: String;
  iCurrentIDPO: Integer;
begin
//  inherited;
  if quPO.Active then
    iCurrentIDPO := quPOIDPO.AsInteger;

  Screen.Cursor := crHourGlass;

  callNewPO();

  { # changing ad
  with MyFrmNewPO do
  begin
    dEstArrived := quPOEstArrival.AsDateTime;
    if Start(quPO, quPOItem) then
    begin
      RefreshAll;
      POItemRequery(True);
    end;
  end;
  }

  Screen.Cursor := crDefault;
end;

procedure TBrwNewPO.btDetailClick(Sender: TObject);
var
  PosID1, PosID2: String;
begin
  inherited;

  callNewPO('update');

  {# changing detail
  with MyFrmNewPO do
  begin
    sParam := 'ModelType=' + quPOItemModelType.AsString + ';';
    RescueQtyOrder := quPOItemQty.AsFloat;
    if Start(quPO, quPOItem, 'update') then
    begin
      RefreshAll;
      POItemRequery(True);
    end;
  end;
  }
end;

procedure TBrwNewPO.btRemoveClick(Sender: TObject);
begin
  inherited;

  try
    Screen.Cursor := crHourGlass;
    RemoveItem;
    RefreshAll;
    POItemRequery(True);
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TBrwNewPO.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TBrwNewPO.btNewPOClick(Sender: TObject);
begin
  inherited;

  case FAddPOType of
    1 : menAddPOClick(Self);
    2 : menMultiplePOClick(Self);
    3 : menAutogenerateSingleClick(Self);
    4 : menAutogenerateClick(Self);
  end;

end;

procedure TBrwNewPO.btRemovePOClick(Sender: TObject);
var
  iCount: Integer;
begin
  inherited;

  if POItemInReceiving then
  begin
    RemoveLeftItems;
    Exit;
  end;


  if MsgBox(MSG_QST_SURE, vbYesNo + vbQuestion) = vbYes then
  begin
    try
      with spRemovePO do
      begin
        Parameters.ParamByName('@IDPO').Value := quPOIDPO.AsInteger;
        ExecProc;
      end;

      RefreshAll;
      POItemRequery(True);
    except
      MsgBox(MSG_CRT_NOT_REMOV_PO , vbCritical + vbOkOnly);
    end;
  end;
end;

procedure TBrwNewPO.quPOCalcFields(DataSet: TDataSet);
var
  fTotal: Double;
begin
  inherited;
  quPOTotal.AsCurrency := quPOSubTotal.AsCurrency +
                          quPOFreight.AsCurrency +
                          quPOCharges.AsCurrency;
end;

procedure TBrwNewPO.btVendorDetailClick(Sender: TObject);
var
   ID1, ID2: String;
begin
  inherited;
  ID1 := quPOIDFornecedor.AsString;
  ID2 := '';

  if FchFornecedor = nil then
    FchFornecedor := TFchPessoa.Create(Self);

  if FchFornecedor.Start(btAlt, nil, False, ID1, ID2, nil) then
    PORequery;
end;

procedure TBrwNewPO.btPOItemPreviewClick(Sender: TObject);
begin
  inherited;
  //Print
  gridPrinterLink.Caption := lblSubMenu.Caption;
  gridPrinter.Preview(True, nil);
end;

procedure TBrwNewPO.btCustomizeColumnsClick(Sender: TObject);
begin
  inherited;
  // Mostra a coluna de customizing do grid
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TBrwNewPO.btGroupClick(Sender: TObject);
begin
  inherited;
  if btGroup.Down then
  begin
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
  end
  else
  begin
    with grdPOItemDB do
    begin
      // Retiro todos os grupos
      while TcxGridDBTableView(AView).GroupedItemCount > 0 do
        TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
      TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
    end;
  end;
end;

procedure TBrwNewPO.quPOAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if FRefreshCount = 0 then
    POItemRequery(False);
end;

procedure TBrwNewPO.btDetailGridClick(Sender: TObject);
begin
  inherited;
  // Seta se vai mostrar os subs ou nao
  SetGridSizeColorMode;
  POItemRequery(True);
end;

procedure TBrwNewPO.SetGridSizeColorMode;
begin
  if btDetailGrid.Down then
    quPOItem.Parameters.ParamByName('GridMode').Value := 'S'
  else
    quPOItem.Parameters.ParamByName('GridMode').Value := 'M';
end;

procedure TBrwNewPO.RefreshAll;
begin
  // Da um refresh completo na tela
  Inc(FRefreshCount);
  try
    PORequery;
  finally
    Dec(FRefreshCount);
  end;
  POItemRequery(False);
end;

procedure TBrwNewPO.quPOAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with quPO do
  begin
    btNewPO.Enabled        := cbxStatus.ItemIndex = 0;
    btRemovePO.Enabled     := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btVendorDetail.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btnAddQuick.Enabled    := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btPOItemAdd.Enabled    := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
  end;
end;

procedure TBrwNewPO.quPOItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with quPOItem do
  begin
    btPOItemOpen.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btPOItemRemove.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btPOItemPreview.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
  end;
end;

procedure TBrwNewPO.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;
  PORequery;
  grdPODB.Controller.GoToFirst;
end;

procedure TBrwNewPO.btAreaTodasClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue  := '';
  cmbStore.Text         := '<'+btAreaTodas.Caption+'>';
  PORequery;
end;

procedure TBrwNewPO.quPOBeforeOpen(DataSet: TDataSet);
var
  sIDStore: String;
begin
  inherited;
  //Ver o bug
  if cmbStore.LookUpValue = '' then
    sIDStore := DM.fStore.StoreList
  else
    sIDStore := cmbStore.LookUpValue;

  quPO.SQL.Text :=  StringReplace(sPOSQL, STORE_MARK, sIDStore, [rfReplaceAll]);
end;

procedure TBrwNewPO.SendPOsbEmailFileClick(Sender: TObject);
begin
  inherited;
  with SendPO do
  begin
    IDPO := quPOIDPO.AsInteger;

    if quPOPayDays.AsInteger > 0 then
      IDPayDay := quPOPayDays.AsInteger
    else
      IDPayDay := -1;

    SetModelDataSet(quPOItem);
    IDVendor   := quPOIDFornecedor.AsInteger;
    VendorName := Self.quPOFornecedor.AsString;
    IDStore    := quPOIDStore.AsInteger;
  end;

  SendPO.sbEmailFileClick(Sender);
end;

procedure TBrwNewPO.SendPObtPreviewVendorFaxClick(Sender: TObject);
var
  printPO: TfrmPrintPO;
begin
  if (quPO.Active) and (quPOIDPO.AsInteger <> 0) then begin
    try
      printPO := TfrmPrintPo.Create(nil);
      printPO.Start(IntToStr(quPOIDPO.AsInteger));
  //    with TFrmPrintPO.Create(Self) do
  //      Start(IntToStr(quPOIDPO.AsInteger));

    finally
         freeAndNil(printPO);
    end;
  end;
end;

procedure TBrwNewPO.grdPOItemDBDblClick(Sender: TObject);
begin
  inherited;
  POItemOpen;
  if btPOItemOpen.Enabled then
    btDetailClick(nil);
end;

function TBrwNewPO.Start: Boolean;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName,
  fRegistryPath: String;
begin
  fRegistryPath := MR_BRW_REG_PATH + lblSubMenu.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
    TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  ShowModal;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

procedure TBrwNewPO.menAutogenerateClick(Sender: TObject);
begin
  inherited;

  SelectAddInfo(4);

  with TFrmNewPOAuto.Create(Self) do
    if Start(PO_MULTI) then
      PORequery;
end;

procedure TBrwNewPO.menMultiplePOClick(Sender: TObject);
var
  bIsRefresh: Boolean;
begin

  SelectAddInfo(2);

  with TFrmNewMultPO.Create(Self) do
  begin
    bIsRefresh := Start;
    Free;
  end;
  if bIsRefresh then
    PORequery;
end;

procedure TBrwNewPO.menQuickEntryClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  with TFrmNewPOQuickEntry.Create(Self) do
  try
    Start(quPO.FieldByName('IDPO').AsInteger, quPO.FieldByName('IDStore').AsInteger,
      quPO.FieldByName('IDFornecedor').AsInteger, quPO.FieldByName('Fornecedor').AsString);
    RefreshAll;
    POItemRequery(True);
  finally
    Free;
  end;

  Screen.Cursor := crDefault;
end;

procedure TBrwNewPO.btnAddQuickClick(Sender: TObject);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  popNew.Popup(P.X, P.Y);
end;

procedure TBrwNewPO.menAutogenerateSingleClick(Sender: TObject);
begin
  inherited;

  SelectAddInfo(3);

  with TFrmNewPOAuto.Create(Self) do
    if Start(PO_SINGLE) then
      PORequery;
end;

function TBrwNewPO.POItemInReceiving: Boolean;
begin
  Result := False;

  if quPO.Active and (quPOIDPO.AsString <> '') then
  begin
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT PUI.IDPOItem');
      SQL.Add('FROM PO');
      SQL.Add('JOIN PreInventoryMov PIM (NOLOCK) ON (PIM.InventMovTypeID = 2 AND PIM.DocumentID = PO.IDPO)');
      SQL.Add('JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PIM.IDPreInventoryMov = PUI.IDPOItem)');
      SQL.Add('WHERE PO.IDPO = ' + quPOIDPO.AsString);
      Open;
      Result := (RecordCount > 0);
    finally
      Close;
    end;
  end;

end;

procedure TBrwNewPO.quPOItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPOItemTotalWeight.AsCurrency := quPOItemWeight.AsCurrency * (quPOItemQty.AsFloat - quPOItemQtyRealMov.AsFloat);
end;

procedure TBrwNewPO.menUpdatePOClick(Sender: TObject);
begin
  inherited;
  if MyFrmPO.Start(quPO, False, cbxStatus.ItemIndex = 0) then
  begin
    RefreshAll;
    Inc(FRefreshCount);

    try
      quPO.Last;
    finally
      Dec(FRefreshCount);
    end;

    POItemRequery(True);
  end;
end;

procedure TBrwNewPO.grdPODBDblClick(Sender: TObject);
begin
  inherited;
  menUpdatePOClick(Sender);
end;

procedure TBrwNewPO.cbxStatusChange(Sender: TObject);
begin
  inherited;
  PORequery;
  grdPODB.Controller.GoToFirst;
end;

procedure TBrwNewPO.quPOItemClosedAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with quPOItemClosed do
  begin
    btPOItemOpen.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btPOItemRemove.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
    btPOItemPreview.Enabled := (not IsEmpty) and (cbxStatus.ItemIndex = 0);
  end;
end;

procedure TBrwNewPO.quPOItemClosedCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPOItemClosedTotalWeight.AsCurrency := quPOItemClosedWeight.AsCurrency * (quPOItemClosedQty.AsFloat - quPOItemClosedQtyRealMov.AsFloat);
end;

procedure TBrwNewPO.btnCopyPOClick(Sender: TObject);
var
  iIDClonePO: Integer;
begin
  inherited;
  try
    DM.ADODBConnect.BeginTrans;

    iIDClonePO := InsertClonePO;
    InsertClonePOItems(iIDClonePO);
    AtuPOTotal(iIDClonePO);
    PORequery;

    DM.ADODBConnect.CommitTrans;
  except
    DM.ADODBConnect.RollbackTrans;
    MsgBox(MSG_CRT_COPYING_PO, vbCritical + vbOKOnly);
  end;
end;

function TBrwNewPO.InsertClonePO: Integer;
begin
  Result := DM.GetNextID('PO.IDPO');

  with cmdInsClonePO do
  begin
    Parameters.ParamByName('IDClonePO').Value := Result;
    Parameters.ParamByName('IDPO').Value := quPOIDPO.AsInteger;
    Execute;
  end;
end;

procedure TBrwNewPO.InsertClonePOItems(AIDClonePO: Integer);
var
  iIDClosePreInvMov: Integer;
begin
  with dsPOItem.DataSet do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      iIDClosePreInvMov := DM.GetNextID('PreInventoryMov.IDPreInventoryMov');
      cmdInsClonePoItems.Parameters.ParamByName('IDClonePreInventoryMov').Value := iIDClosePreInvMov;
      cmdInsClonePoItems.Parameters.ParamByName('IDPreInventoryMov').Value := FieldByName('IDPreInventoryMov').AsInteger;
      cmdInsClonePoItems.Parameters.ParamByName('DocumentID').Value := AIDClonePO;
      cmdInsClonePoItems.Execute;
      Next;
    end;
  finally
    First;
    EnableControls;
  end;
end;

procedure TBrwNewPO.AtuPOTotal(AIDClonePO: Integer);
begin
  with spAtuPOTotal do
  begin
    Parameters.ParamByName('@IDPO').Value := AIDClonePO;
    ExecProc;
  end;
end;

procedure TBrwNewPO.RemoveItem;
begin

  if (quPOItem.Active) and (not quPOItem.IsEmpty) then
    with spRemovePOItem do
    begin
      Parameters.ParamByName('@IDPO').Value := quPOIDPO.AsInteger;
      Parameters.ParamByName('@IDPreInventoryMov').Value := quPOItemIDPreInventoryMov.AsInteger;
      ExecProc;
    end;

end;

function TBrwNewPO.RemoveLeftItems: Boolean;
begin

  Result := (MsgBox(MSG_QST_PO_ITEM_IN_RECEIVING, vbYesNo + vbQuestion) = vbYes);

  if Result then
  begin
    try
      quPOItem.DisableControls;
      Screen.Cursor := crHourGlass;

      with quPOItem do
        if Active then
        begin
         First;
         while not EOF do
         begin
           RemoveItem;
           Next;
         end;
        end;
      RefreshAll;
      POItemRequery(True);
    finally
      quPOItem.EnableControls;
      Screen.Cursor := crDefault;
    end;
  end;

end;

procedure TBrwNewPO.btnMergePOClick(Sender: TObject);
begin
  inherited;

  if quPO.Active and (not quPO.IsEmpty) then
    with TFrmMergePO.Create(Self) do
      if Start(quPOIDFornecedor.AsInteger, quPOIDStore.AsInteger, quPOIDPO.AsInteger) then
      begin
        AtuPOTotal(quPOIDPO.AsInteger);
        RefreshAll;
        POItemRequery(True);
      end;

end;

procedure TBrwNewPO.menAddPOClick(Sender: TObject);
begin
  inherited;

  SelectAddInfo(1);

  if MyFrmPO.Start(quPO, True, cbxStatus.ItemIndex = 0) then
  begin
    RefreshAll;
    Inc(FRefreshCount);

    try
      quPO.Last;
    finally
      Dec(FRefreshCount);
    end;

    POItemRequery(True);
  end;
  
end;

procedure TBrwNewPO.SelectAddInfo(AddOption: Integer);
begin

  FAddPOType := AddOption;
  DM.FMainRetailConfig.WriteInteger('PO', 'AddPO', FAddPOType);

  menAddPO.Checked              := False;
  menMultiplePO.Checked         := False;
  menAutogenerateSingle.Checked := False;
  menAutogenerate.Checked       := False;

  case FAddPOType of
    1 : menAddPO.Checked              := True;
    2 : menMultiplePO.Checked         := True;
    3 : menAutogenerateSingle.Checked := True;
    4 : menAutogenerate.Checked       := True;
  end;

end;

procedure TBrwNewPO.spHelpClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      OpenURL('http://www.mainretail.com.br/treinamento/Compras/Com_NovaOC.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;


end;

procedure TBrwNewPO.btnVideoClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      case FAddPOType of
        1 : OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Nova_OC/Criando_uma_Nova_Ordem_de_Compras.htm');
        2 : OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Criando_Multiplas_OC/Criando_Multiplas_OC.htm');
        3 : OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Auto_Gerar_OC_Simples/Criando_uma_Auto_Gerar_OC_Simples.htm');
        4 : OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Auto_Gerar_OC_Multipla/Criando_uma_Auto_Gerar_OC_Multipla.htm');
      end;
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

procedure TBrwNewPO.callNewPO(arg_oper: String = 'insert');
begin
  try
    myFrmNewPO := TfrmNewPO.Create(nil);
    myfrmNewPo.dEstArrived := quPOEstArrival.AsDateTime;
    if ( myFrmNewPO.start(quPO, quPOItem, arg_oper) ) then begin
       RefreshAll();
       POItemRequery(true);
    end;
  finally
    freeAndNil(myFrmNewPO);
  end;
end;

end.
