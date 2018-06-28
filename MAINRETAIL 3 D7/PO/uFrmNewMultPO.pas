unit uFrmNewMultPO;

interface             

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, ExtCtrls, Db, Mask, Grids, StdCtrls, DBCtrls, FormConfig, DBTables,
  LblEffct, XBase, DateBox, Buttons, Variants, ComCtrls, 
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  SubListPanel, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  uFrmBarcodeSearch, DBClient, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxLookAndFeelPainters, cxButtons, Menus,
  PAIDETODOS;

const
    COL_SPACE = 10;

type
  TFrmNewMultPO = class(TFrmParent)
    pnlSizeAndColor: TPanel;
    quCombo: TADOQuery;
    quComboModelType: TStringField;
    quComboSellingPrice: TFloatField;
    quComboSuggRetail: TFloatField;
    spIncluiSubModel: TADOStoredProc;
    spDO: TADOStoredProc;
    spGetCurrentPO: TADOStoredProc;
    quPOTotal: TADOQuery;
    quPOTotalSubTotal: TFloatField;
    pnlPOItem: TPanel;
    lbModel: TLabel;
    lbVendor: TLabel;
    Label9: TLabel;
    scModel: TSuperComboADO;
    scVendor: TSuperComboADO;
    quPOTotalEstArrival: TDateTimeField;
    SubListModelDetail: TSubListPanel;
    SubListRequest: TSubListPanel;
    cdsNewMultPO: TClientDataSet;
    cdsNewMultPOIDStore: TIntegerField;
    cdsNewMultPOQty: TFloatField;
    cxInfoStoreDBTableView1: TcxGridDBTableView;
    cxInfoStoreLevel1: TcxGridLevel;
    cxInfoStore: TcxGrid;
    dsNewMultPO: TDataSource;
    lblCost: TLabel;
    lblSale: TLabel;
    lblSug: TLabel;
    lbRequest: TLabel;
    lbEstimated: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    cxInfoStoreDBTableView1Qty: TcxGridDBColumn;
    cxInfoStoreDBTableView1StoreName: TcxGridDBColumn;
    cdsTransfer: TClientDataSet;
    cdsTransferIDLojaOrigem: TIntegerField;
    cdsTransferIDLojaDestino: TIntegerField;
    cdsTransferData: TDateTimeField;
    cdsTransferIDUser: TIntegerField;
    cdsTransferIDModel: TIntegerField;
    cdsTransferCostPrice: TCurrencyField;
    cdsTransferTax: TCurrencyField;
    cdsTransferQty: TFloatField;
    cdsTransferDescription: TStringField;
    cdsTransferNumber: TStringField;
    cdsTransferLojaOrigem: TStringField;
    cdsTransferLojaDestino: TStringField;
    cdsTransferModel: TStringField;
    cdsTransferSystemUser: TStringField;
    dbCost: TEdit;
    dbSale: TEdit;
    dbSug: TEdit;
    qryInsertPreInvMov: TADOQuery;
    dbRequestDate: TDateBox;
    dbDateEstimated: TDateBox;
    pnlQtyType: TPanel;
    lblQtyType: TLabel;
    cbxQtyType: TComboBox;
    popModel: TPopupMenu;
    menFind: TMenuItem;
    menTransfer: TMenuItem;
    menConsult: TMenuItem;
    cxChoice: TcxButton;
    Label11: TLabel;
    lbPOTotal: TLabel;
    lbTitList: TLabel;
    Label12: TLabel;
    btSave: TButton;
    cdsNewFinalMultPO: TClientDataSet;
    cdsNewFinalMultPOCaseCost: TCurrencyField;
    cdsNewFinalMultPOCaseQty: TFloatField;
    cdsNewFinalMultPODateEstimatedMov: TDateTimeField;
    cdsNewFinalMultPOMovDate: TDateTimeField;
    cdsNewFinalMultPOStoreName: TStringField;
    cdsNewFinalMultPOQty: TFloatField;
    cdsNewFinalMultPOIDVendor: TIntegerField;
    cdsNewFinalMultPOIDModel: TIntegerField;
    cdsNewFinalMultPOIDStore: TIntegerField;
    cdsNewFinalMultPOCostPrice: TCurrencyField;
    cdsNewFinalMultPOSalePrice: TCurrencyField;
    cdsNewFinalMultPOSuggPrice: TCurrencyField;
    cdsNewMultPOStoreName: TStringField;
    cdsNewMultPOQtyOnHand: TFloatField;
    cdsNewMultPOAvgSale: TCurrencyField;
    cdsNewMultPOTotalSold: TCurrencyField;
    cxInfoStoreDBTableView1DBOnHand: TcxGridDBColumn;
    cxInfoStoreDBTableView1DBAvgSale: TcxGridDBColumn;
    lbSalePeriod: TLabel;
    dtSalePeriod: TDateBox;
    lbDay: TLabel;
    quSaleInfo: TADODataSet;
    quSaleInfoQtySold: TFloatField;
    quSaleInfoAvgSale: TFloatField;
    cxInfoStoreDBTableView1TotalSold: TcxGridDBColumn;
    edtCaseQty: TEdit;
    lblCase: TLabel;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    procedure scModelSelectItem(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure scVendorSelectItem(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxQtyTypeSelect(Sender: TObject);
    procedure btTransferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConsultTransferClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure SubListRequestSelectData(AParams: String);
    procedure dbCostKeyPress(Sender: TObject; var Key: Char);
    procedure dtSalePeriodChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quSaleInfoCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    bNewOne: boolean;
    fVendorCost: Currency;
    fModelCaseCost: Currency;
    fModelCaseQty: Double;
    iDaySales: Integer;
    sDay: String;

    fFrmBarcodeSearch : TFrmBarcodeSearch;

    procedure RefreshQtyControls;

    function OnValidadeField: boolean;

    procedure SetModelProperties;

    procedure FramesRefresh;
    procedure SetModel;

    procedure GetPOTotal;

    function FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;

    procedure StartMultPO;
    procedure RefreshQtyOnHand(IDModel : Integer);
    procedure RefreshSaleInt(IDModel : Integer; SaleSince : TDateTime);
    procedure ClearMultPOFields(ClearQty : Boolean);

    procedure AddFinalMultPO(IDStore: Integer; Qty: Double);
    procedure CreateMultPONumbers;
    function SavePOItens(cds: TClientDataSet; IDPO: Integer): Boolean;

    procedure RefreshScreen;
    procedure SetCDSIndex(AClientDataSet: TClientDataSet; AIndexField,
      AIndexField2: String);
    procedure StartGrid;
    function ValidateQty(IDVendor, IDModel : String): Boolean;
  public
    dEstArrived: TDateTime;
    Acumulate, TotalItem: Real;

    function Start: Boolean;
  end;

implementation

uses uDM, uMsgBox, uFrmModelAddColor, uFrmModelAddSize, uSystemConst,
     uMsgConstant, uNumericFunctions, uSystemTypes, uParamFunctions, uDMGlobal,
     uFrmModelAddSizeColor, uFrmNewPOTransfer, uFrmNewPOTransferConsult,
     uCharFunctions, uFrmPrintPO, uWebFunctions;

{$R *.DFM}

procedure TFrmNewMultPO.SetModelProperties;
begin
  if scModel.LookUpValue <> EmptyStr then
    with DM.quFreeSQL do
    try
      SQL.Clear;
      SQL.Add('SELECT M.FinalCost, M.SellingPrice, M.SuggRetail, (CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty END) as CaseQty');
      SQL.Add('FROM Model M (NOLOCK)');
      SQL.Add('LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDModel)');
      SQL.Add('WHERE M.IDModel = ' + scModel.LookUpValue);
      SQL.Add('AND MV.IDPessoa = ' + scVendor.LookUpValue);

      if Active then
        Close;
      Open;

      fVendorCost   := FieldByName('FinalCost').AsCurrency;
      fModelCaseQty := FieldByName('CaseQty').AsFloat;

      if fModelCaseQty <> 0 then
      begin
        fModelCaseCost := fVendorCost * fModelCaseQty;
        dbCost.Text    := FormatCurr('#,##0.00', fModelCaseCost);
      end
      else
      begin
        fModelCaseCost := 0;
        dbCost.Text    := FormatCurr('#,##0.00', fVendorCost);
      end;

      dbSale.Text          := FormatCurr('#,##0.00', FieldByName('SellingPrice').AsCurrency);
      dbSug.Text           := FormatCurr('#,##0.00', FieldByName('SuggRetail').AsCurrency);
    finally
      Close;
    end;
end;

procedure TFrmNewMultPO.GetPOTotal;
var
  SubTotal: Double;
  cds: TClientDataSet;
begin
  cds := TClientDataSet.Create(Self);
  cds.Data := cdsNewMultPO.Data;
  SubTotal := 0;

  with cds do
  begin
    First;
    while not Eof do
    begin
      SubTotal :=  SubTotal + FieldByName('CostPrice').AsCurrency;
      Next;
    end;

    lbPOTotal.Caption := 'Total : ' + FormatFloat('#,##0.00', SubTotal);
  end;
end;

procedure TFrmNewMultPO.scModelSelectItem(Sender: TObject);
begin
  inherited;
  SetModel;
end;

procedure TFrmNewMultPO.SetModel;
begin
  if (scModel.LookUpValue <> '') and (scVendor.LookUpValue <> '') then
  begin
    // Tudo sempre começa com um combo refresh;
    FramesRefresh;

    //Get the Prices from Inventory
    SetModelProperties;
    RefreshQtyControls;

    RefreshQtyOnHand(strToInt(scModel.LookUpValue));
    if dtSalePeriod.Text <> '' then
      RefreshSaleInt(StrToInt(scModel.LookUpValue), dtSalePeriod.Date);

    // Teste para ver se o modelo ja esta em algum PO, extiver aviso ao usuario
    with TADOQuery.Create(self) do
    begin
      Connection := DM.ADODBConnect;
      SQL.Add('SELECT ModelID');
      SQL.Add('FROM PreInventoryMov JOIN PO ON (DocumentID = IDPO)');
      SQL.Add('WHERE Qty > QtyRealMov ');
      SQL.Add('AND ModelID = ' + scModel.LookUpValue );
      SQL.Add('AND Aberto = 1');
      Open;

      if not IsEmpty then
        MsgBox(MSG_INF_MODEL_ORDERED, vbInformation + vbOkOnly);

      Close;
      Free;
    end;
  end;
end;

procedure TFrmNewMultPO.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // Primeiro sempre é o combo refresh, já que ele é base para o resto
  FramesRefresh;

  GetPOTotal;

  SetModelProperties;
  RefreshQtyControls;
end;

procedure TFrmNewMultPO.FramesRefresh;
begin
  SubListModelDetail.Param := 'IDModel='+scModel.LookUpValue+
                             ';IDStore='+IntToStr(DM.fStore.ID)+
                             ';IDVendor='+scVendor.LookUpValue+';'+
                             'ShowMinMax=Y;';
end;

procedure TFrmNewMultPO.scVendorSelectItem(Sender: TObject);
var
  sIDStore: String;
begin
  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
    sIDStore := '0'
  else
    sIDStore := IntToStr(DM.fStore.ID);

  SubListRequest.Param := 'Lock=Y;'+
                          'IDStore=0;'+
                          'IDVendor='+scVendor.LookUpValue+';'+
                          'MultPO=Y;';
end;

procedure TFrmNewMultPO.StartGrid;
begin
  SubListRequest.Param := 'Lock=Y;'+
                          'IDStore=0;'+
                          'IDVendor=0;'+
                          'MultPO=Y;';
end;

function TFrmNewMultPO.OnValidadeField: boolean;
begin
  Result := False;

  if scVendor.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_THERE_IS_NO_VENDOR, vbOkOnly + vbCritical);
    scVendor.SetFocus;
    Exit;
  end;

  if not(ValidateQty(scVendor.LookUpValue , scModel.LookUpValue)) then
    Exit;

  if scModel.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbCritical);
    scModel.SetFocus;
    Exit;
  end;

  if (dbRequestDate.Text = '') then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOkOnly + vbCritical);
    dbRequestDate.SetFocus;
    Exit;
  end;

  if (dbDateEstimated.Text = '') then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOkOnly + vbCritical);
    dbDateEstimated.SetFocus;
    Exit;
  end;

  if cdsNewFinalMultPO.Locate('IDVendor;IDModel', VarArrayOf([scVendor.LookUpValue, scModel.LookUpValue]), []) then
    MsgBox(MSG_INF_MODEL_ORDERED, vbInformation + vbOkOnly);

  Result := True;  
end;

procedure TFrmNewMultPO.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;
  with fFrmBarcodeSearch do
  begin
    R := Start;
    if R <> -1 then
    begin
      scModel.LookUpValue := IntToStr(R);
      SetModel;
    end;
  end;
end;

procedure TFrmNewMultPO.FormDestroy(Sender: TObject);
begin
  cdsTransfer.Close;
  cdsNewMultPO.Close;
  cdsNewFinalMultPO.Close;
  FreeAndNil(fFrmBarcodeSearch);
  inherited;
end;

procedure TFrmNewMultPO.RefreshQtyControls;
begin
  pnlQtyType.Visible := fModelCaseQty > 0;
  edtCaseQty.Text := FloatToStr(fModelCaseQty);
end;

procedure TFrmNewMultPO.cbxQtyTypeSelect(Sender: TObject);
begin
  inherited;
  RefreshQtyControls;
end;

procedure TFrmNewMultPO.btTransferClick(Sender: TObject);
begin
  if scModel.LookUpValue = '' then
    Exit;

  cdsTransfer.Append;
  cdsTransferIDModel.Value      := StrToInt(scModel.LookUpValue);
  cdsTransferIDLojaOrigem.Value := DM.fStore.ID;
  cdsTransferData.Value         := NOW;
  cdsTransferDescription.Value  := scModel.Text;
  cdsTransferIDUser.Value       := DM.fUser.ID;
  cdsTransferQty.Value          := 1;
  cdsTransferTax.Value          := 0;
  cdsTransferCostPrice.Value    := MyStrToMoney(dbCost.Text);
  with TFrmNewPOTransfer.Create(Self) do
  begin
    Start(cdsTransfer, StrToInt(scModel.LookUpValue));
    Free;
  end;
end;

procedure TFrmNewMultPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if not cdsTransfer.IsEmpty then
  begin
    with TFrmNewPOTransferConsult.Create(Self) do
    begin
      Start(cdsTransfer, SCREEN_POST);
      cdsTransfer.EmptyDataSet;
      Free;
    end;
  end;

  SubListRequest.SetSubListProperties;
end;

function TFrmNewMultPO.FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;
begin
  Result := TClientDataSet.Create(self);

  Result.Data := cds.Data;
  Result.EmptyDataSet;

  cds.First;
  while not cds.Eof do
  begin
    if not Result.Locate('IDLojaOrigem;IDLojaDestino', VarArrayOf([cds.FieldByName('IDLojaOrigem').Value,
                                                               cds.FieldByName('IDLojaDestino').Value]), []) then
    begin
      Result.Append;
      Result.FieldByName('IDLojaOrigem').Value  := cds.FieldByName('IDLojaOrigem').Value;
      Result.FieldByName('IDLojaDestino').Value := cds.FieldByName('IDLojaDestino').Value;
      Result.FieldByName('IDUser').Value        := cds.FieldByName('IDUser').Value;
      Result.FieldByName('Data').Value          := cds.FieldByName('Data').Value;
      Result.FieldByName('Number').Value        := cds.FieldByName('Number').Value;
      Result.Post;
    end;
    cds.Next;
  end;
  cds.First;
  Result.First;
end;

procedure TFrmNewMultPO.btConsultTransferClick(Sender: TObject);
begin
  inherited;
  with TFrmNewPOTransferConsult.Create(Self) do
  begin
    cdsTransfer.Data := Start(cdsTransfer, SCREEN_CONSULT);
    Free;
  end;
end;

procedure TFrmNewMultPO.StartMultPO;
var
  qryInfoStore: TADOQuery;
  sStores, sSQL: string;
begin
  qryInfoStore := TADOQuery.Create(Self);

  try
    qryInfoStore.Connection := DM.ADODBConnect;

    qryInfoStore.Close;
    qryInfoStore.SQL.Text   := Format('SELECT StoresAccess FROM SystemUser WHERE IDUser = %D', [DM.fUser.ID]);
    qryInfoStore.Open;

    sStores := qryInfoStore.FieldByName('StoresAccess').AsString;

    sSQL := Format('SELECT IDStore, Name FROM Store WHERE IDStore IN ( %S )', [sStores]);

    qryInfoStore.Close;
    qryInfoStore.SQL.Text := sSQL;
    qryInfoStore.Open;

    while not qryInfoStore.Eof do
    begin
      cdsNewMultPO.Append;
      cdsNewMultPO.FieldByName('IDStore').Value := qryInfoStore.FieldByName('IDStore').Value;
      cdsNewMultPO.FieldByName('StoreName').Value := qryInfoStore.FieldByName('Name').Value;
      cdsNewMultPO.Post;
      qryInfoStore.Next;
    end;
  finally
    FreeAndNil(qryInfoStore);
  end;
end;

function TFrmNewMultPO.Start: Boolean;
begin
  Result := True;
  Screen.Cursor := crHourGlass;

  SubListModelDetail.CreateSubList;

  SubListRequest.CreateSubList;

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  Screen.Cursor := crDefault;

  cdsTransfer.CreateDataSet;
  cdsNewMultPO.CreateDataSet;
  cdsNewFinalMultPO.CreateDataSet;

  StartMultPO;

  dbRequestDate.Date   := NOW;
  dbDateEstimated.Date := NOW + 7;
  dtSalePeriod.Date    := NOW - 30;

  StartGrid;

  ShowModal;
end;

procedure TFrmNewMultPO.AddFinalMultPO(IDStore: Integer; Qty: Double);
begin
  cdsNewFinalMultPO.Append;
  cdsNewFinalMultPOIDStore.Value          := IDStore;
  cdsNewFinalMultPOQty.Value              := Qty;
  cdsNewFinalMultPOIDVendor.Value         := StrToInt(scVendor.LookUpValue);
  cdsNewFinalMultPOIDModel.Value          := StrToInt(scModel.LookUpValue);
  cdsNewFinalMultPOCostPrice.Value        := DM.FDMCalcPrice.FormatPrice(MyStrToMoney(dbCost.Text));
  cdsNewFinalMultPOSalePrice.Value        := DM.FDMCalcPrice.FormatPrice(MyStrToMoney(dbSale.Text));
  cdsNewFinalMultPOSuggPrice.Value        := DM.FDMCalcPrice.FormatPrice(MyStrToMoney(dbSug.Text));
  cdsNewFinalMultPOMovDate.Value          := dbRequestDate.Date;
  cdsNewFinalMultPODateEstimatedMov.Value := dbDateEstimated.Date;

  if (pnlQtyType.Visible and (cbxQtyType.ItemIndex = 1 )) then
  begin
    cdsNewFinalMultPOCaseQty.AsFloat      := 0;
    cdsNewFinalMultPOCaseCost.AsFloat     := 0;
  end
  else
  begin
    cdsNewFinalMultPOCaseQty.AsFloat      := fModelCaseQty;
    cdsNewFinalMultPOCaseCost.AsFloat     := fModelCaseCost;
  end;

  cdsNewFinalMultPO.Post;
end;

procedure TFrmNewMultPO.btCloseClick(Sender: TObject);
begin
  if not cdsNewFinalMultPO.IsEmpty then
    if MsgBox(MSG_QST_CONFIRM_CREATE_PO, vbYesNo + vbQuestion) = vbYes then
    begin
      CreateMultPONumbers;
      ModalResult := mrOk;
    end
    else
      ModalResult := mrCancel;
  Close;
end;

procedure TFrmNewMultPO.CreateMultPONumbers;
var
  IDPO : Integer;
  IDStore, IDVendor : Integer;
  sIDPOs : String;
begin
  inherited;
  IDStore  := -1;
  IDVendor := -1;
  sIDPOs   := '';

  // Primeiro lembrar que estamos dentro de uma trasação.
  // NADA DE INTERACOES COM O USUARIO !

  // Caso nao esteja setado, vou descobrir em qual PO que este item vai entrar
  // Se NewOne is true, devo avisar o usuario que foi criado um novo PO

  bNewOne := False;
  with cdsNewFinalMultPO do
  begin
    SetCDSIndex(cdsNewFinalMultPO, 'IDVendor', 'IDStore');
    First;
    while not Eof do
    begin
      if ((FieldByName('IDVendor').AsInteger <> IDVendor) or (FieldByName('IDStore').AsInteger <> IDStore)) then
      begin
        IDStore  := cdsNewFinalMultPO.FieldByName('IDStore').AsInteger;
        IDVendor := cdsNewFinalMultPO.FieldByName('IDVendor').AsInteger;
        spGetCurrentPO.Parameters.ParambyName('@IDStore').Value  := cdsNewFinalMultPO.FieldByName('IDStore').AsInteger;
        spGetCurrentPO.Parameters.ParambyName('@IDPessoa').Value := cdsNewFinalMultPO.FieldByName('IDVendor').AsInteger;
        spGetCurrentPO.Parameters.ParambyName('@Date').Value     := cdsNewFinalMultPO.FieldByName('MovDate').AsDateTime;
        spGetCurrentPO.ExecProc;

        IDPO := spGetCurrentPO.Parameters.ParambyName('@IDPO').Value;
        bNewOne := spGetCurrentPO.Parameters.ParambyName('@NewOne').Value;

        SavePOItens(cdsNewFinalMultPO,IDPO);
        sIDPOs := sIDPOs + IntToStr(IDPO) + ',';
      end;
      Next;
    end;
  end;

  if Length(sIDPOs) > 0 then
    sIDPOs := sIDPOs + Copy(sIDPOs, 0, Length(sIDPOs)-1);

  if sIDPOs <> '' then
    with TFrmPrintPO.Create(Self) do
      Start(sIDPOs);
end;

procedure TFrmNewMultPO.SetCDSIndex(AClientDataSet: TClientDataSet; AIndexField,AIndexField2: String);
var
  sInidice,sInidice2 : string;
  stlIndexes: TStringList;
  I: Integer;
begin
  stlIndexes := TStringList.Create;
  try
    AClientDataSet.IndexName := '';
    AClientDataSet.GetIndexNames(stlIndexes);
    for I := 0 to stlIndexes.Count - 1 do
      if (stlIndexes[I] <> 'DEFAULT_ORDER') and (stlIndexes[I] <> 'CHANGEINDEX') then
        AClientDataSet.DeleteIndex(stlIndexes[I]);

    sInidice := Format('%S', [AIndexField]);
    sInidice2 := Format('%S', [AIndexField2]);

    AClientDataSet.AddIndex(sInidice, AIndexField, [ixCaseInsensitive]);
    AClientDataSet.IndexName := sInidice;

    AClientDataSet.AddIndex(sInidice2, AIndexField2, [ixCaseInsensitive]);
    AClientDataSet.IndexName := sInidice2;
  finally
    stlIndexes.Free;
  end;
end;

function TFrmNewMultPO.SavePOItens(cds : TClientDataSet; IDPO: Integer): Boolean;
var
  IDPreInventoryMov: Integer;
  cdsFriend: TClientDataSet;
begin
  Result := True;
  cdsFriend := TClientDataSet.Create(Self);

  try
    cdsFriend.Data := cds.Data;

    cdsFriend.Filtered := False;
    cdsFriend.Filter   := ' IDStore = ' + InttoStr(cds.FieldByName('IDStore').AsInteger) +
                          ' and IDVendor = ' + InttoStr(cds.FieldByName('IDVendor').AsInteger) ;
    cdsFriend.Filtered := True;

    cdsFriend.First;
    while not cdsFriend.Eof do
    begin
      IDPreInventoryMov := DM.GetNextID('PreInventoryMov.IDPreInventoryMov');

      with qryInsertPreInvMov do
      try
        Parameters.ParamByName('IDPreInventoryMov').Value := IDPreInventoryMov;
        Parameters.ParamByName('DocumentID').Value        := IDPO;
        Parameters.ParamByName('ModelID').Value           := cdsFriend.FieldByName('IDModel').AsInteger;
        Parameters.ParamByName('MovDate').Value           := cdsFriend.FieldByName('MovDate').AsDateTime;
        Parameters.ParamByName('Qty').Value               := cdsFriend.FieldByName('Qty').AsFloat;
        Parameters.ParamByName('SalePrice').Value         := cdsFriend.FieldByName('SalePrice').AsCurrency;
        Parameters.ParamByName('SuggRetail').Value        := cdsFriend.FieldByName('SuggPrice').AsCurrency;
        Parameters.ParamByName('CostPrice').Value         := cdsFriend.FieldByName('CostPrice').AsCurrency;
        Parameters.ParamByName('IDPessoa').Value          := cdsFriend.FieldByName('IDVendor').AsInteger;
        Parameters.ParamByName('DateEstimatedMov').Value  := cdsFriend.FieldByName('DateEstimatedMov').AsDateTime;
        Parameters.ParamByName('StoreID').Value           := cdsFriend.FieldByName('IDStore').AsInteger;
        Parameters.ParamByName('InventMovTypeID').Value   := 2;
        Parameters.ParamByName('UserID').Value            := DM.fUser.ID;
        Parameters.ParamByName('CaseQty').Value           := cdsFriend.FieldByName('CaseQty').AsFloat;
        Parameters.ParamByName('CaseCost').Value          := cdsFriend.FieldByName('CaseCost').AsCurrency;
        ExecSQL;
      except
        on E: Exception do
        begin
          MsgBox(E.Message, vbCritical);
          Result := False;
        end;
      end;

      try
        spDO.Parameters.ParambyName('@IDPreInventoryMov').Value := IDPreInventoryMov;
        spDO.Parameters.ParambyName('@IDPO').Value := IDPO;
        spDO.ExecProc;
      except
        on E: Exception do
        begin
          MsgBox(E.Message, vbCritical);
          Result := False;
        end;
      end;

      cdsFriend.Next;
    end;
  finally
    FreeAndNil(cdsFriend);
  end;
end;

procedure TFrmNewMultPO.btSaveClick(Sender: TObject);
begin
  inherited;
  if OnValidadeField then
  begin
    cdsNewMultPO.First;
    while not cdsNewMultPO.Eof do
    begin
      if cdsNewMultPOQty.AsFloat > 0 then
        AddFinalMultPO(cdsNewMultPOIDStore.AsInteger, cdsNewMultPOQty.AsFloat);
      cdsNewMultPO.Next;
    end;
    RefreshScreen;
  end;
end;

procedure TFrmNewMultPO.SubListRequestSelectData(AParams: String);
var
  IDModel : Integer;
begin
  inherited;
  IDModel  := StrToIntDef(ParseParam(AParams, 'IDModel'), -1);
  
  if (IDModel <> -1) and (IDModel <> StrToIntDef(scModel.LookUpValue, 0)) then
  begin
    scModel.LookUpValue := IntToStr(IDModel);
    SetModel;
  end;
end;

procedure TFrmNewMultPO.dbCostKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmNewMultPO.RefreshScreen;
begin
  dbSug.Text  := '';
  dbSale.Text := '';
  dbCost.Text := '';
  scModel.LookUpValue := '';

  ClearMultPOFields(True);
end;

procedure TFrmNewMultPO.RefreshQtyOnHand(IDModel : Integer);
var
  qryQtyOnHand: TADOQuery;
begin
  if IDModel = 0 then
    Exit;

  ClearMultPOFields(False);

  qryQtyOnHand := TADOQuery.Create(Self);
  try
    qryQtyOnHand.Connection := DM.ADODBConnect;

    qryQtyOnHand.Close;
    qryQtyOnHand.SQL.Text := Format('SELECT QtyOnHand, StoreID FROM Inventory WHERE ModelID = %D', [IDModel]);
    qryQtyOnHand.Open;

    cdsNewMultPO.DisableControls;
    while not qryQtyOnHand.Eof do
    begin
      if cdsNewMultPO.Locate('IDStore', qryQtyOnHand.FieldByName('StoreID').Value, []) then
      begin
        cdsNewMultPO.Edit;
        cdsNewMultPO.FieldByName('QtyOnHand').Value := qryQtyOnHand.FieldByName('QtyOnHand').Value;
        cdsNewMultPO.Post;
      end;
      qryQtyOnHand.Next;
    end;

    //iDaySales
  finally
    cdsNewMultPO.EnableControls;
    FreeAndNil(qryQtyOnHand);
  end;
end;

procedure TFrmNewMultPO.ClearMultPOFields(ClearQty : Boolean);
begin
  with cdsNewMultPO do
  try
    DisableControls;
    First;
    while not EOF do
    begin
      Edit;
      FieldByName('QtyOnHand').Value := 0;
      FieldByName('AvgSale').Value   := 0;
      FieldByName('TotalSold').Value := 0;
      if ClearQty then
        FieldByName('Qty').Clear;
      Post;
      Next;
    end;

  finally
    EnableControls;
  end;
end;

procedure TFrmNewMultPO.dtSalePeriodChange(Sender: TObject);
begin
  inherited;
  iDaySales := Trunc(Now - dtSalePeriod.Date);
  lbDay.Caption := IntToStr(iDaySales) + ' ' + sDay;
  if scModel.LookUpValue <> '' then
    RefreshSaleInt(StrToInt(scModel.LookUpValue), dtSalePeriod.Date);
end;

procedure TFrmNewMultPO.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sDay      := 'Day';
    end;

    LANG_PORTUGUESE :
    begin
      sDay      := 'Dia(s)';
    end;

    LANG_SPANISH :
    begin
      sDay      := 'Día(s)';
    end;
  end;
end;

procedure TFrmNewMultPO.RefreshSaleInt(IDModel : Integer; SaleSince : TDateTime);
begin
  try
    cdsNewMultPO.DisableControls;
    cdsNewMultPO.First;
    
    while not cdsNewMultPO.Eof do
    begin
      try
        quSaleInfo.Parameters.ParamByName('IDModel').Value := IDModel;
        quSaleInfo.Parameters.ParamByName('MovDate').Value := Trunc(SaleSince);
        quSaleInfo.Parameters.ParamByName('IDStore').Value := cdsNewMultPO.FieldByName('IDStore').AsInteger;
        quSaleInfo.Open;

        if not quSaleInfo.IsEmpty then
        begin
          cdsNewMultPO.Edit;
          cdsNewMultPO.FieldByName('AvgSale').Value   := quSaleInfo.FieldByName('AvgSale').AsFloat;
          cdsNewMultPO.FieldByName('TotalSold').Value := quSaleInfo.FieldByName('QtySold').AsFloat;
          cdsNewMultPO.Post;
        end;
        
        cdsNewMultPO.Next;
      finally
        quSaleInfo.Close;
      end;
    end;
  finally
    cdsNewMultPO.EnableControls;
  end;
end;

procedure TFrmNewMultPO.quSaleInfoCalcFields(DataSet: TDataSet);
begin
  inherited;
  if iDaySales >= 1 then
    quSaleInfo.FieldByName('AvgSale').AsFloat := (quSaleInfo.FieldByName('QtySold').AsCurrency / iDaySales);
end;

function TFrmNewMultPO.ValidateQty(IDVendor, IDModel : String): Boolean;
var
  qryQtyMin: TADOQuery;
begin
  Result := True;
  qryQtyMin := TADOQuery.Create(self);

  try
    with qryQtyMin do
    begin
      qryQtyMin.Connection := DM.ADODBConnect;
      SQL.Text := 'SELECT '+
                  ' MinQtyPO '+
                  'FROM '+
                  ' Inv_ModelVendor '+
                  'WHERE '+
                  ' IDPessoa = ' + IDVendor +
                  '	AND '+
                  ' IDModel = ' + IDModel;
      Open;
      cdsNewMultPO.First;

      while not cdsNewMultPO.Eof do
      begin
        if cdsNewMultPOQty.AsString <> '' then
        begin
          if cdsNewMultPOQty.AsFloat < FieldByName('MinQtyPO').AsFloat then
          begin
            MsgBox(MSG_INF_LESSER_MINIM_VENDOR, vbOkOnly + vbCritical);
            Result := False;
            break;
          end
          else if (cbxQtyType.ItemIndex <> 0) and (fModelCaseQty > 1) then
            if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
              if Frac(cdsNewMultPOQty.AsFloat / fModelCaseQty) <> 0 then
              begin
                MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbOkOnly + vbCritical);
                Result := False;
                break;
              end;
        end;
        cdsNewMultPO.Next;
      end;
    end;
  finally
    FreeAndNil(qryQtyMin);
  end;
end;

procedure TFrmNewMultPO.FormShow(Sender: TObject);
begin
  inherited;
  SubListRequest.GetSubListProperties;
end;

procedure TFrmNewMultPO.btnVideoClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Criando_Multiplas_OC/Criando_Multiplas_OC.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

procedure TFrmNewMultPO.spHelpClick(Sender: TObject);
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


end.
