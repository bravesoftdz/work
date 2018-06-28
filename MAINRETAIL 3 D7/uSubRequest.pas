unit uSubRequest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Buttons, Grids, DBGrids, SMDBGrid,
  StdCtrls, Mask, SuperComboADO, DB, ADODB, uFrmSaleRequest, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, PowerADOQuery, LookUpADOQuery;

type
  TSubRequest = class(TParentSub)
    quRequest: TADOQuery;
    quRequestIDRequest: TIntegerField;
    quRequestIDModel: TIntegerField;
    quRequestModel: TStringField;
    quRequestDescription: TStringField;
    quRequestDateRequest: TDateTimeField;
    quRequestSystemUser: TStringField;
    quRequestNew: TADOQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    StringField3: TStringField;
    spRemoveRequest: TADOStoredProc;
    dsRequest: TDataSource;
    quMinQty: TADOQuery;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField2: TDateTimeField;
    StringField6: TStringField;
    quMaxQty: TADOQuery;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    StringField7: TStringField;
    StringField8: TStringField;
    DateTimeField3: TDateTimeField;
    StringField9: TStringField;
    quMinQtyQtyReq: TFloatField;
    quMinQtyQtyOrdered: TFloatField;
    quMaxQtyQtyReq: TFloatField;
    quMaxQtyQtyOrdered: TFloatField;
    quRequestNewQtyReq: TFloatField;
    quRequestNewQtyOrdered: TFloatField;
    quRequestQtyReq: TFloatField;
    quRequestQtyOrdered: TFloatField;
    pnlFilter: TPanel;
    cmbList: TComboBox;
    scGroup: TcxLookupComboBox;
    btGroupAll: TButton;
    pnlAdd: TPanel;
    lblFrameRequestCount: TLabel;
    btFrameRequestAddRequest: TSpeedButton;
    btFrameRequestRemoveRequest: TSpeedButton;
    btFabricanteAll: TButton;
    cbxEntiry: TComboBox;
    cbxEntity: TcxLookupComboBox;
    quEntity: TADODataSet;
    quEntityIDPessoa: TIntegerField;
    quEntityIDFornecedor: TIntegerField;
    quEntityPessoa: TStringField;
    quEntityCode: TIntegerField;
    quEntityUserCode: TStringField;
    dsEntity: TDataSource;
    Label17: TPanel;
    sbHideFilter: TSpeedButton;
    grdOrder: TcxGrid;
    grdOrderDB: TcxGridDBTableView;
    grdOrderLevel: TcxGridLevel;
    grdOrderDBModel: TcxGridDBColumn;
    grdOrderDBDescription: TcxGridDBColumn;
    grdOrderDBDateRequest: TcxGridDBColumn;
    grdOrderDBSystemUser: TcxGridDBColumn;
    grdOrderDBQtyReq: TcxGridDBColumn;
    grdOrderDBQtyOrdered: TcxGridDBColumn;
    quMinQtyStore: TStringField;
    quMaxQtyStore: TStringField;
    grdOrderDBStore: TcxGridDBColumn;
    btnColumn: TSpeedButton;
    btnGroup: TSpeedButton;
    quMinQtyCategory: TStringField;
    quMaxQtyCategory: TStringField;
    quRequestCategory: TStringField;
    grdOrderDBCategory: TcxGridDBColumn;
    quMinQtyClasseABC: TStringField;
    quMaxQtyClasseABC: TStringField;
    quRequestClasseABC: TStringField;
    grdOrderDBABC: TcxGridDBColumn;
    quLookUpGroup: TLookUpADOQuery;
    quLookUpGroupIDGroup: TIntegerField;
    quLookUpGroupName: TStringField;
    quLookUpGroupPathName: TStringField;
    quLookUpGroupUserCode: TStringField;
    dsLookUpGroup: TDataSource;
    quAllInventory: TADOQuery;
    quAllInventoryIDRequest: TIntegerField;
    quAllInventoryIDModel: TIntegerField;
    quAllInventoryClasseABC: TStringField;
    quAllInventoryModel: TStringField;
    quAllInventoryDescription: TStringField;
    quAllInventoryDateRequest: TDateTimeField;
    quAllInventoryStore: TStringField;
    quAllInventoryCategory: TStringField;
    quAllInventoryQtyReq: TIntegerField;
    quAllInventoryQtyOrdered: TIntegerField;
    quAllInventorySystemUser: TStringField;
    quRequestManufacture: TStringField;
    quMaxQtyManufacture: TStringField;
    quMinQtyManufacture: TStringField;
    quRequestNewManufacture: TStringField;
    grdOrderDBManufacture: TcxGridDBColumn;
    quAllInventoryManufacture: TStringField;
    quRequestNewCategory: TStringField;
    quRequestNewStore: TStringField;
    quRequestNewClasseABC: TStringField;
    quMinQtyIDModelParent: TIntegerField;
    quMaxQtyIDModelParent: TIntegerField;
    quRequestIDModelParent: TIntegerField;
    quRequestNewIDModelParent: TIntegerField;
    quAllInventoryIDModelParent: TIntegerField;
    quRequestStore: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmbListChange(Sender: TObject);
    procedure scGroupEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btFrameRequestAddRequestClick(Sender: TObject);
    procedure btFrameRequestRemoveRequestClick(Sender: TObject);
    procedure btGroupAllClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure cbxEntiryChange(Sender: TObject);
    procedure cbxEntityEnter(Sender: TObject);
    procedure cbxEntityPropertiesChange(Sender: TObject);
    procedure sbHideFilterClick(Sender: TObject);
    procedure grdOrderDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnColumnClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scGroupPropertiesEditValueChanged(Sender: TObject);
  private
    sAllReq, sSystemReq,
    sReqVendor, sReqNovo,
    sOnlyFor, sHideFilter, sShowFilter,
    sOnlyComp, sOnlySp,
    sLinhas, sMinQty, sMaxQty, sAllInventory: String;
    fIDVendor: Integer;
    fIDStore : Integer;
    fIDGroup : Integer;
    fIDEntity: Integer;
    fLockRefresh: boolean;
    AView  : TcxCustomGridTableView;
    
    brwFrmRequest: TbrwFrmRequest;
    fRegistryPath: String;
    AOptions: TcxGridStorageOptions;

    procedure SetLockRefresh(Value: boolean);
    procedure SetIDVendor(Value: integer);
    procedure SetIDStore(Value: integer);

    procedure UpdateListLabel;
    procedure RequestClose;
    procedure RequestOpen;
    procedure RequestRequery;

    procedure EntityOpen;
    procedure EntityClose;
    procedure EntityRefresh;

    procedure FrameRefresh;

    procedure RequestLoadFicha;
  protected
    procedure AfterSetParam; override;
  public
    procedure SetLayoutProperties; override;
    procedure GetLayoutProperties; override;
  end;

implementation

{$R *.dfm}

uses xBase, uMsgBox, uDM, uMsgConstant, uNumericFunctions, uSystemTypes,
     uDMGlobal, uParamFunctions, uSystemConst;

procedure TSubRequest.FrameRefresh;
begin
  // Acessivel pelo usuario, dou o requery sem levar em conta Lock
  RequestClose;
  RequestOpen;
end;

procedure TSubRequest.RequestLoadFicha;
begin
  if brwFrmRequest = nil then
    brwFrmRequest := TbrwFrmRequest.Create(Self);
end;

procedure TSubRequest.RequestRequery;
var
  sCurrentIDRequest,
  sNextIDRequest: string;
begin
  if not fLockRefresh then
  begin
    // Desligo o Grid
    //grdRequest.BeginUpdate;

    // Parte do Close
    sCurrentIDRequest := '';
    sNextIDRequest := '';
    with dsRequest.DataSet do
      if Active then
      begin
        sCurrentIDRequest := FieldByName('IDRequest').AsString;
        Next;
        sNextIDRequest := FieldByName('IDRequest').AsString;
      end;
    RequestClose;

    // Atenção: O RequestOpen pode mudar a query do dataSource

    // Parte do Open
    RequestOpen;
    with dsRequest.DataSet do
      if sCurrentIDRequest <> '' then
      begin
        if not Locate('IDRequest', sCurrentIDRequest, []) then
          Locate('IDRequest', sNextIDRequest, []);
      end;
  end;
end;

procedure TSubRequest.RequestOpen;
begin
  {
  0 All requests
  1 Only computer requests
  2 Only sales person requests
  3 Only for XXXXX
  4 Only computer for XXXX
  5 Only sales for XXXX
  6 All Inventory
  }

  // Dependendo do selecao de cmbList uso um ou outro TADOQuery
  case cmbList.ItemIndex of
    0, 1, 2: dsRequest.DataSet := quRequest;
    3:       dsRequest.DataSet := quRequestNew;
    4:       dsRequest.DataSet := quMinQty;
    5:       dsRequest.DataSet := quMaxQty;
    6:       dsRequest.DataSet := quAllInventory;
  end;

  // Again, dependendo o cmbList set os parametros para o dataset ativo
  with TADOQuery(dsRequest.DataSet) do
  begin
    if Active then
      Exit;

    // Filtro de loja
    case cmbList.ItemIndex of
      0, 1, 2, 4, 5:
      begin
        if FIDStore <> 0 then
          Parameters.ParambyName('IDStore').Value := FIDStore
        else
          Parameters.ParambyName('IDStore').Value := Null;
      end;
    end;

    // Filtro de Type
    case cmbList.ItemIndex of
      0, 3: Parameters.ParambyName('Type').Value := Null;            // All
      1: Parameters.ParambyName('Type').Value := 'C';  // Computer
      2: Parameters.ParambyName('Type').Value := 'P';  // Sales Person
    end;

    //Manufacture / Vendor
    case cmbList.ItemIndex of
      0, 1, 2, 4, 5, 6:
      begin
        if (fIDEntity <> 0) and (cbxEntiry.ItemIndex = 1) then
          Parameters.ParambyName('IDFabricante').Value := fIDEntity
        else
          Parameters.ParambyName('IDFabricante').Value := Null;

        if (fIDEntity <> 0) and (cbxEntiry.ItemIndex = 0) then
          Parameters.ParambyName('IDPessoa').Value := fIDEntity
        else
          Parameters.ParambyName('IDPessoa').Value := Null;
      end;
    end;

    // Filtro por Category
    if (cmbList.ItemIndex <> 3) then
    begin
      if fIDGroup <> 0 then
        Parameters.ParambyName('IDGroup').Value := fIDGroup
      else
        Parameters.ParambyName('IDGroup').Value := Null;
    end;

    try
      Screen.Cursor := crHourGlass;
      Open;
    finally
      Screen.Cursor := crDefault;
      grdOrderDB.DataController.Groups.FullExpand;
    end;

    // Coloco o numero de request no label apropriado
    lblFrameRequestCount.Caption := IntToStr(RecordCount) + sLinhas;
  end;
end;

procedure TSubRequest.RequestClose;
begin
  with quRequest do
    if Active then
      Close;

  with quRequestNew do
    if Active then
      Close;

  with quMinQty do
    if Active then
      Close;

  with quMaxQty do
    if Active then
      Close;

  with quAllInventory do
    if Active then
      Close;
end;

procedure TSubRequest.UpdateListLabel;
var
  iCurrentItemIndex: integer;
begin
  {
  0 All requests
  1 Only computer requests
  2 Only sales person requests
  3 Only for XXXXX
  4 Only computer for XXXX
  5 Only sales for XXXX
  }

  // Atualiza o nome do vendo na lista de filtros, ou seja troca o XXXX pelo Vendor.Name

  // Tomo o cuidado de guardar em que opcao o cmb está
  iCurrentItemIndex := cmbList.ItemIndex;

  // Atualizo na lista
  with cmbList do
    begin
      Items[0] := sAllReq;
      Items[1] := sSystemReq;
      Items[2] := sReqVendor;
      Items[3] := sReqNovo;
      Items[4] := sMinQty;
      Items[5] := sMaxQty;
      Items[6] := sAllInventory;
    end;

  // Volto a opcao
  cmbList.ItemIndex := iCurrentItemIndex;
end;

procedure TSubRequest.AfterSetParam;
var
  IDS, IDV: Integer;
  bLock: Boolean;
begin
   IDS   := StrToIntDef(ParseParam(FParam, 'IDStore'), 0);
   IDV   := StrToIntDef(ParseParam(FParam, 'IDVendor'), 0);
   bLock := (ParseParam(FParam, 'Lock') = 'Y');

   //btFabricanteAll.Enabled := not (IDV <> 0);
   grdOrderDB.DataController.KeyFieldNames := 'IDModel;Store';

   SetLockRefresh(bLock);
   SetIDVendor(IDV);
   SetIDStore(IDS);
end;

procedure TSubRequest.SetLockRefresh(Value: boolean);
begin
  if Value <> FLockRefresh then
  begin
    FLockRefresh := Value;
    if Value = False then
      RequestRequery;
  end;

  fLockRefresh := False;
end;

procedure TSubRequest.SetIDVendor(Value: integer);
begin
  if (Value <> FIDVendor) AND (Value <> 0) then
  begin
    FIDEntity := Value;
    FIDVendor := Value;
    cbxEntity.EditValue := Value;
    RequestRequery;
  end;
end;

procedure TSubRequest.SetIDStore(Value: integer);
begin
  if (Value <> FIDStore) AND (Value <> 0) then
  begin
    FIDStore := Value;
    RequestRequery;
  end;
end;

procedure TSubRequest.FormCreate(Sender: TObject);
begin
  inherited;
  RequestClose;
  FLockRefresh := False;
  FIDVendor    := 0;
  FIDStore     := 0;
  fIDEntity    := 0;
  //Iniciar o Request com Sales Person, pois estava muito lento
  cmbList.ItemIndex := 2;

  //Setup Language
  if (DMGlobal.IDLanguage <> LANG_ENGLISH) and (siLang.StorageFile <> '') then
    if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
      siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True);

  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sAllReq       := 'All requests';
      sSystemReq    := 'System requests';
      sReqVendor    := 'Sales Person requests';
      sReqNovo      := 'Requests for New Models';
      sOnlyFor      := 'Only for ';
      sOnlyComp     := 'Only computer for ';
      sOnlySp       := 'Only sales for ';
      sLinhas       := ' Line(s)';
      sMinQty       := 'Minimum qty';
      sMaxQty       := 'Maximum qty';
      sAllInventory := 'All inventory';
      sHideFilter   := 'Hide Filters';
      sShowFilter   := 'Show Filters';
    end;

    LANG_PORTUGUESE :
    begin
      sAllReq       := 'Todas as Requisições';
      sSystemReq    := 'Requisições do Sistema';
      sReqVendor    := 'Requisições do Vendedor';
      sReqNovo      := 'Requisições para novos modelos';
      sOnlyFor      := 'Só por ';
      sOnlyComp     := 'Sistema por ';
      sOnlySp       := 'Vendas por ';
      sLinhas       := ' Linha(s)';
      sMinQty       := 'Qtd Mínima';
      sMaxQty       := 'Qtd Máxima';
      sAllInventory := 'Todo estoque';
      sHideFilter   := 'Ocultar Filtro';
      sShowFilter   := 'Mostrar Filtro';
    end;

    LANG_SPANISH :
    begin
      sAllReq       := 'Todas as Requisições';
      sSystemReq    := 'Requisições do Sistema';
      sReqVendor    := 'Requisições do Vendedor';
      sReqNovo      := 'Requisições para novos modelos';
      sOnlyFor      := 'Sólo por ';
      sOnlyComp     := 'Sistema por ';
      sOnlySp       := 'Ventas por ';
      sLinhas       := ' Lineas';
      sMinQty       := 'Ctd Mínima';
      sMaxQty       := 'Ctd Máxima';
      sAllInventory := 'Todo estoque';
      sHideFilter   := 'Ocultar Filtro';
      sShowFilter   := 'Mostrar Filtro';
    end;
  end;

  sbHideFilter.Caption := sHideFilter;
  UpdateListLabel;
  AView := TcxCustomGridTableView(grdOrder.FocusedView);
end;

procedure TSubRequest.cmbListChange(Sender: TObject);
begin
  inherited;
  RequestRequery;
end;

procedure TSubRequest.scGroupEnter(Sender: TObject);
begin
  inherited;
  with DM.quLookUpGroup do
    if not Active then
      Open;
end;

procedure TSubRequest.FormDestroy(Sender: TObject);
begin
  DM.quLookUpGroup.Close;
  EntityClose;
  inherited;
end;

procedure TSubRequest.btFrameRequestAddRequestClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  RequestLoadFicha;

  if brwFrmRequest.Start(btInc, nil, False, ID1, ID2, nil) then
  begin
    RequestRequery;
    quRequest.Locate('IDRequest', ID1, []);
  end;
end;

procedure TSubRequest.btFrameRequestRemoveRequestClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE_REQUEST, vbYesNo + vbQuestion) = vbYes then
  begin
    with spRemoveRequest do
    begin
      Parameters.ParambyName('@IDRequest').Value := quRequestIDRequest.AsInteger;
      ExecProc;
    end;
    
    RequestRequery;
  end;
end;

procedure TSubRequest.btGroupAllClick(Sender: TObject);
begin
  inherited;
  //DM.quLookUpGroup.Close;
  scGroup.EditValue := null;
  fIDGroup := 0;
  RequestRequery;
end;

procedure TSubRequest.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  EntityClose;
  fIDEntity := 0;
  RequestRequery;
end;

procedure TSubRequest.cbxEntiryChange(Sender: TObject);
begin
  inherited;
  fIDEntity := 0;
  EntityRefresh;
end;

procedure TSubRequest.cbxEntityEnter(Sender: TObject);
begin
  inherited;
  EntityOpen;
end;

procedure TSubRequest.cbxEntityPropertiesChange(Sender: TObject);
begin
  inherited;
  fIDEntity := cbxEntity.EditValue;
  RequestRequery;
end;

procedure TSubRequest.EntityClose;
begin
  with quEntity do
    if Active then
      Close;
end;

procedure TSubRequest.EntityOpen;
begin
  with quEntity do
    if not Active then
    begin
      case cbxEntiry.ItemIndex of
        0:
        begin
          Parameters.ParamByName('Path').Value     := '.002%';
          if fIDVendor = 0 then
            Parameters.ParamByName('IDPessoa').Value := Null
          else
            Parameters.ParamByName('IDPessoa').Value := fIDVendor;
        end;
        1:
        begin
          Parameters.ParamByName('Path').Value     := '.004%';
          Parameters.ParamByName('IDPessoa').Value := Null;
        end;
      end;
      Open;
    end;
end;

procedure TSubRequest.EntityRefresh;
begin
  EntityClose;
  EntityOpen;
end;

procedure TSubRequest.sbHideFilterClick(Sender: TObject);
begin
  inherited;
  pnlFilter.Visible := not pnlFilter.Visible;

  if pnlFilter.Visible then
    sbHideFilter.Caption := sHideFilter
  else
    sbHideFilter.Caption := sShowFilter;
end;

procedure TSubRequest.grdOrderDBCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  sParams: String;
begin
  inherited;
  if Assigned(OnSelectData) then
  begin
    sParams := 'IDModel=' + dsRequest.DataSet.Fields.FieldByName('IDModel').AsString + ';' +
               'Qty=' + FloatToStr(dsRequest.DataSet.Fields.FieldByName('QtyReq').AsFloat) + ';'+
               'IDModelParent=' + dsRequest.DataSet.Fields.FieldByName('IDModelParent').AsString +';';

    OnSelectData(sParams);
  end;
end;

procedure TSubRequest.btnColumnClick(Sender: TObject);
begin
  inherited;
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TSubRequest.btnGroupClick(Sender: TObject);
begin
  inherited;
  if not TcxGridDBTableView(AView).OptionsView.GroupByBox then
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True
  else
    with grdOrder do
    begin
      // Retiro todos os grupos
      while TcxGridDBTableView(AView).GroupedItemCount > 0 do
        TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
      TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
    end;
end;

procedure TSubRequest.FormShow(Sender: TObject);
begin
  inherited;
  with quLookUpGroup do
    if not Active then
      Open;
end;

procedure TSubRequest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  with quLookUpGroup do
    if Active then
      Close;
end;

procedure TSubRequest.SetLayoutProperties;
begin
  inherited;
  //Salva para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

procedure TSubRequest.GetLayoutProperties;
var
  MultPO: Boolean;
begin
  inherited;
  MultPO := (ParseParam(FParam, 'MultPO') = 'Y');

  if MultPO then
    fRegistryPath := MR_BRW_REG_PATH + 'Sub - Request_MultPO'
  else
    fRegistryPath := MR_BRW_REG_PATH + 'Sub - Request_SinglePO';

  AOptions := [gsoUseFilter, gsoUseSummary];
  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);
end;

procedure TSubRequest.scGroupPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if scGroup.EditValue <> null then
  begin
    fIDGroup := scGroup.EditValue;
    RequestRequery;
  end;
end;

initialization
   RegisterClass(TSubRequest);

end.
