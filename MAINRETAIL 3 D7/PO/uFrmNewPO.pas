
unit uFrmNewPO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, ExtCtrls, Db, Mask, Grids, StdCtrls, DBCtrls, FormConfig, DBTables,
  LblEffct, XBase, DateBox, Buttons, Variants, ComCtrls,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  SubListPanel, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  uFrmBarcodeSearch, DBClient, cxLookAndFeelPainters, Menus, cxButtons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, ItemPurchaseModel;

const
    COL_SPACE = 10;

type
  TfrmNewPO = class(TbrwFrmParent)
    Label1: TLabel;
    pnlSizeAndColor: TPanel;
    Label7: TLabel;
    sgGrid: TStringGrid;
    btAddColor: TSpeedButton;
    btAddSize: TSpeedButton;
    quGrid: TADOQuery;
    quGridIDPreInventoryMov: TIntegerField;
    quGridIDColor: TIntegerField;
    quGridColor: TStringField;
    quGridCodColor: TStringField;
    quGridIDSize: TIntegerField;
    quGridSizeName: TStringField;
    quGridCodSize: TStringField;
    quCombo: TADOQuery;
    quComboModelType: TStringField;
    quComboSellingPrice: TFloatField;
    quComboSuggRetail: TFloatField;
    spIncluiSubModel: TADOStoredProc;
    quFormIDPreInventoryMov: TIntegerField;
    quFormDocumentID: TIntegerField;
    quFormModelID: TIntegerField;
    quFormMovDate: TDateTimeField;
    quFormSalePrice: TFloatField;
    quFormSuggRetail: TFloatField;
    quFormCostPrice: TFloatField;
    quFormIDPessoa: TIntegerField;
    quFormDateEstimatedMov: TDateTimeField;
    quFormStoreID: TIntegerField;
    quFormInventMovTypeID: TIntegerField;
    spDO: TADOStoredProc;
    spGetCurrentPO: TADOStoredProc;
    quFormUserID: TIntegerField;
    quPOTotal: TADOQuery;
    quPOTotalSubTotal: TFloatField;
    lbPOTotal: TLabel;
    pnlPOItem: TPanel;
    Label5: TLabel;
    Label8: TLabel;
    Label16: TLabel;
    Label11: TLabel;
    Label30: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    scModel: TDBSuperComboADO;
    quPOTotalEstArrival: TDateTimeField;
    Label17: TLabel;
    btnAddSizeColor: TSpeedButton;
    SubListModelDetail: TSubListPanel;
    SubListRequest: TSubListPanel;
    quGridQty: TFloatField;
    quFormCaseCost: TBCDField;
    pnlQtyControl: TPanel;
    pnlQty: TPanel;
    Label2: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    pnlCaseQty: TPanel;
    lblCaseQty: TLabel;
    pnlQtyType: TPanel;
    typeQty: TComboBox;
    lblQtyType: TLabel;
    cdsTransfer: TClientDataSet;
    cdsTransferIDLojaOrigem: TIntegerField;
    cdsTransferIDLojaDestino: TIntegerField;
    cdsTransferIDUser: TIntegerField;
    cdsTransferIDModel: TIntegerField;
    cdsTransferCostPrice: TCurrencyField;
    cdsTransferTax: TCurrencyField;
    cdsTransferQty: TFloatField;
    cdsTransferData: TDateTimeField;
    cdsTransferDescription: TStringField;
    cdsTransferNumber: TStringField;
    cdsTransferLojaOrigem: TStringField;
    cdsTransferLojaDestino: TStringField;
    cdsTransferModel: TStringField;
    cdsTransferSystemUser: TStringField;
    btnSearchDesc: TcxButton;
    popModel: TPopupMenu;
    btnFind: TMenuItem;
    btTransfer: TMenuItem;
    btConsultTransfer: TMenuItem;
    quFormQty: TFloatField;
    quFormCaseQty: TFloatField;
    store: TEdit;
    caseQuantity: TcxCurrencyEdit;
    quantity: TcxCurrencyEdit;
    vendor: TEdit;
    orderOn: TcxDateEdit;
    arrivalEstimateDate: TcxDateEdit;
    ourPrice: TcxCurrencyEdit;
    suggRetail: TcxCurrencyEdit;
    cancel: TButton;
    lblCaseCost: TLabel;
    caseCost: TcxCurrencyEdit;
    cost: TcxCurrencyEdit;
    procedure scModelSelectItem(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure sgGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure scVendorSelectItem(Sender: TObject);
    procedure sgGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure quGridAfterPost(DataSet: TDataSet);
    procedure btAddColorClick(Sender: TObject);
    procedure btAddSizeClick(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure editCostExit(Sender: TObject);
    procedure btnAddSizeColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure typeQtySelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SubListRequestSelectData(AParams: String);
    procedure btnSearchDescClick(Sender: TObject);
    procedure btTransferClick(Sender: TObject);
    procedure btConsultTransferClick(Sender: TObject);
    procedure DBEdit8Exit(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormStartDock(Sender: TObject;
      var DragObject: TDragDockObject);
    procedure btCancelClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
  private
    fItemPurchaseModel: TItemPurchaseModel;
    fAction: String;
    fPO: TDataset;
    fPOItem: TDataset;

    fMinQtyPO: Double;
    bNewOne: boolean;
    fVendorCost : Currency;
    fModelCaseQty : Double;
    sModelType : String;
    fRescueQtyOrder: Double;

    fFrmBarcodeSearch : TFrmBarcodeSearch;

    // Velharia sujeita a validacao
       IsRequestScroll, IsModelLocate : Boolean;
       POFromRequest : Boolean;
       reqRealClick  : Boolean;
       OldIDModel, NewIDModel, MyIDModel: Integer;
       OriginalItemValue: Currency;
    // Fim velharia

    procedure itemPurchaseAfterOpen(DataSet: TDataSet);
    function getCaseCost(pIdModel: Integer; pQty: Double ; pIdVendor: Integer = 0): extended;
    procedure RefreshQtyControls;


    function getSellingPriceChanged(idmodel: Integer): Currency;
    function OnValidadeField: boolean; override;

    function OnAfterSaveChange(var iError:Integer):Boolean; override;
    procedure OnAfterCommit; override;

    procedure SetModelProperties;

    procedure InsertSubModel;

    procedure FormRefresh;
    procedure ComboRefresh;

    procedure FramesRefresh;
    procedure SetModel;
    procedure SetVendor;

    procedure GridOpen;
    procedure GridClose;
    procedure GridRequery;
    procedure GridPaint;

    function GridCountQty:Double;

    procedure GetPOTotal;

    procedure RequestDblClick(Sender: TObject; iIDModel: integer);
    procedure ModelDblClick(Sender: TObject; iIDFornecedor: integer);

    function FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;
    function ValidatesQtyMin(IDVendor, IDModel: Integer; Qty, CaseQty: Double): Boolean;
    function GetIDModel(IDModel:Integer):Integer;

    //amfsouza 04.26.2012 - deal quantity on edit
    function getQuantityAccordingType(qty_type: Integer; qty_browse, case_qty: Double): Double;

    procedure setRescueQtyOrder(const Value: Double);
    procedure cleanUpScreen();
    procedure fillScreenItemPO(arg_po: TDataset);
    procedure callSpDO(arg_preinvmovID: Integer);
    function isNewOnePO(): Boolean;

    // Antonio 11/30/2015 - MR-260
    function validate(): Boolean;

    // Antonio 2014 May 13
    procedure enableDisableTransfer(arg_model: String);


  public
    dEstArrived : TDateTime;
    Acumulate, TotalItem : Real;
    sParam :  string;
    property RescueQtyOrder: Double write setRescueQtyOrder;
    procedure OnBeforeStart; override;
    function start(arg_po: TDataset; arg_poItem: TDataset; arg_action: String = 'insert'): Boolean;
    function TestOnEditModes: Boolean; override;

  end;

implementation

uses uDM, uMsgBox, uFrmModelAddColor, uFrmModelAddSize, uSystemConst,
     uMsgConstant, uNumericFunctions, uSystemTypes, uParamFunctions, uDMGlobal,
     uFrmModelAddSizeColor, PaiDeTodos, uFrmNewPOTransfer, uFrmNewPOTransferConsult;


{$R *.DFM}

procedure TfrmNewPO.OnBeforeStart;
begin
  inherited;
{
  sModelType             := '';
  scModel.TabStop        := True;
  scModel.ReadOnly       := False;
  scModel.SpcWhereClause := '';

  if frmCommand = btInc then
    Exit;

   sModelType := ParseParam(Self.sParam, 'ModelType');

   if sModelType = 'S' then
   begin
     scModel.LookUpSource   := DM.dsLookUpNewModel;
     scModel.SpcWhereClause := 'ModelType = ''S''';
     scModel.ReadOnly       := True;
     scModel.TabStop        := False;
   end
   else
   begin
     scModel.LookUpSource   := DM.dsLookUpModelMaster;
   end;
   }
end;

procedure TfrmNewPO.SetModelProperties;
var
  MinQtyPo: Double;
begin
  if scModel.LookUpValue <> EmptyStr then
    with DM.quFreeSQL do
    try
      SQL.Clear;
      //SQL.Add('SELECT (CASE IsNull(INV.VendorCost, M.VendorCost) WHEN 0 THEN M.FinalCost ELSE IsNull(M.VendorCost, 0) END) as FinalCost, ');

      // Antonio 12/02/2015, MR-148 ( see in Jira )
      SQL.Add('SELECT coalesce(Inv.VendorCost, M.VendorCost, M.VendorCost) as FinalCost, ');
      SQL.Add('M.SellingPrice, M.SuggRetail, INV.MinQtyPO, ');
      SQL.Add('CASE WHEN ISNULL(INV.CaseQty, 0) = 0 THEN 0 ELSE INV.CaseQty END as CaseQty ');
      SQL.Add('FROM Model M (NOLOCK) ');

      SQL.Add('LEFT JOIN Inv_ModelVendor INV (NOLOCK) ON (INV.IDModel = M.IDModel AND INV.IDPessoa = ' + fPo.fieldByName('IdFornecedor').asString + ' ) ' );
      SQL.Add('WHERE M.IDModel = ' + scModel.LookUpValue);

      if Active then
        Close;
      Open;

      cost.Value := FieldByName('FinalCost').AsCurrency;
      //showmessage(format('vendor = %s and cost = %.2f', [fPo.fieldByName('IdFornecedor').asString, cost.value]));

      caseCost.Value := cost.Value;
      caseQuantity.Value := FieldByName('CaseQty').AsFloat;
      ourPrice.value := FieldByName('SellingPrice').AsCurrency;
      suggRetail.Value := FieldByName('SuggRetail').AsCurrency;
      fMinQtyPo := FieldByName('MinQtyPO').AsFloat;
    finally
      Close;
    end;
end;

function TfrmNewPO.GridCountQty : Double;
var
  i, x: Integer;
  iTotalQty, iNewQty: Double;
begin
  iTotalQty := 0;
  iNewQty   := 0;

  with sgGrid do
  begin
    for i := 1 to RowCount do
      for x := 1 to ColCount do
      begin
        iNewQty := MyStrToDouble(Trim(Cells[i,x]));
        if iNewQty > 0 then
          iTotalQty := iTotalQty + iNewQty;
        end;
  end;

  Result := iTotalQty;
end;

procedure TfrmNewPO.GetPOTotal;
begin
  with quPOTotal do
  begin
    if Active then
       Close;
    Parameters.ParambyName('PONumber').Value := fpoItem.fieldbyname('DocumentID').AsInteger;
    Open;

    lbPOTotal.Caption := 'Total : ' + FormatFloat('#,##0.00', quPOTotalSubTotal.AsCurrency);
    Close;
  end;
end;

procedure TfrmNewPO.scModelSelectItem(Sender: TObject);
begin
//  inherited;
  SetModel;
  GridRequery;
  enableDisableTransfer(scModel.Text);
end;

procedure TfrmNewPO.quFormNewRecord(DataSet: TDataSet);
begin
(*
  quFormMovDate.AsDateTime          := Now;
  quFormUserID.AsInteger            := DM.fUser.ID;
  quFormInventMovTypeID.AsInteger   := 2; // Compra
  if dEstArrived = 0 then
    quFormDateEstimatedMov.AsDateTime := Trunc(now + 7)
  else
    quFormDateEstimatedMov.AsDateTime := Trunc(dEstArrived);
  scModel.LookUpSource              := DM.dsLookUpModelMaster;
  pnlQtyType.Visible                := False;
  typeQty.ItemIndex              := 0;
  fModelCaseQty                     := 0;
  scModel.SetFocus;

  RefreshQtyControls;
  *)
end;

procedure TfrmNewPO.SetModel;
var
  saveModelSelected: String;
begin
  if scModel.LookUpValue <> '' then
  begin
    // Tudo sempre começa com um combo refresh;
    ComboRefresh;

    // Testo se devo incluir os grid do model
    if (quComboModelType.AsString = 'M') and (fAction = 'insert') then
      InsertSubModel;

    // Rearumo a tela
    FormRefresh;
    FramesRefresh;

    //Get the Prices from Inventory
//    if ( not fPOItem.IsEmpty ) then begin
       SetModelProperties;
//    end;

    RefreshQtyControls;

    // Test to verify if model alread exists in some PO. If so, blow up a message to user knows.
    if ( fAction = 'insert' ) then
    begin
      with TADOQuery.Create(self) do
      begin
        Connection := DM.ADODBConnect;
        SQL.Add('SELECT ModelID');
        SQL.Add('FROM PreInventoryMov JOIN PO (NOLOCK) ON (DocumentID = IDPO)');
        SQL.Add('WHERE Qty > QtyRealMov ');
        SQL.Add('AND ModelID = ' + scModel.LookUpValue );

        SQL.Add('AND Aberto = 1');
        Open;

        if not IsEmpty then
        begin
          MsgBox(MSG_INF_MODEL_ORDERED, vbInformation + vbOkOnly);
        end;

        Close;
        Free;

      end;
    end;
  end;
end;

procedure TfrmNewPO.InsertSubModel;
begin
  // Garante que os campos necessário nao estao nulos
  if (quFormIDPreInventoryMov.AsString <> '') AND
     (quFormModelID.AsString <> '') then
  begin
  // Inclui os submodel do model no PO
    with spIncluiSubModel do
    begin
      Parameters.ParambyName('@IDPreInventoryMov').Value := quFormIDPreInventoryMov.AsInteger;
      Parameters.ParambyName('@IDModel').Value           := quFormModelID.AsInteger;
      Parameters.ParambyName('@IDStore').Value           := DM.fStore.ID;
      ExecProc;
    end;

    GridRequery;
  end;
end;

{
procedure TFrmNewPO.NextAppend;
begin
  inherited;
  // Seta o valor do proximo IDModel
  SetModel;
  SetFornecedor(True);

  if POFromRequest then
     // se PO anterior vei de um request deve passar para o proximo
     quRequest.Locate('IDModel', NewIDModel, [])
  else if OldIDModel <> 0 then
    begin
     // se PO anterior vei do Model deve passar para o Proximo Model
     IDModel.LookUpValue := IntToStr(OldIDModel);
     IDModel.GetNextValue;
     SetModel;
    end;

end;
}

procedure TfrmNewPO.itemPurchaseAfterOpen(DataSet: TDataSet);
var
  sellingPriceChanged: Double;
begin
  // Primeiro sempre é o combo refresh, já que ele é base para o resto
  ComboRefresh;
  FormRefresh;
  FramesRefresh;

  //amfsouza 04.19.2012 - begin
  if ( not dataset.fieldByName('modelID').IsNull ) then
     sellingPriceChanged := getSellingPriceChanged(dataset.fieldByName('modelID').Value);

  if ( sellingPriceChanged <> 0 ) then begin
     ourPrice.Value := sellingPriceChanged;
  end;
  //amfsouza 04.19.2012 - end

  GetPOTotal;

  if (fAction = 'update') and (dataset.FieldByName('caseQty').AsFloat = 0) then
    typeQty.ItemIndex := 1
  else
    typeQty.ItemIndex := 0;

  SetModelProperties;
  RefreshQtyControls;
end;

procedure TfrmNewPO.FramesRefresh;
var
  sIDStore : String;
begin
  SubListModelDetail.Param := 'IDModel='+scModel.LookUpValue+
                             ';IDStore='+IntToStr(DM.fStore.ID)+
                             ';IDVendor='+dsForm.dataset.fieldByName('idPessoa').asString+';';

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
    sIDStore := '0'
  else
    sIDStore := IntToStr(DM.fStore.ID);

  SubListRequest.Param := 'Lock=Y;'+
                          'IDStore='+sIDStore+';'+
                          'IDVendor='+dsform.dataset.fieldByName('idPessoa').asString+';'+
                          'MultPO=N;';

  {
  with FrameRequest do
    begin
      LockRefresh := True;
      IDVendor    := MyStrToInt(scVendor.LookUpValue);
      IDStore     := DM.fStore.ID;
      LockRefresh := False;
    end;
  }
end;

procedure TfrmNewPO.FormCreate(Sender: TObject);
begin
//  inherited;
  Screen.Cursor := crHourGlass;

  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

  //FrameModel.OnVendorDblClick := ModelDblClick;

  SubListModelDetail.CreateSubList;
  SubListRequest.CreateSubList;

  //FrameRequest.OnModelDblClick := RequestDblClick;

  //DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  Screen.Cursor := crDefault;

  cdsTransfer.CreateDataSet;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;

end;

procedure TfrmNewPO.GridOpen;
begin
  with quGrid do
    if not Active then
    begin
      Parameters.ParambyName('IDPreInventoryMovParent').Value := fpoItem.fieldByName('IDPreInventoryMov').AsInteger;
      Open;
      GridPaint;
    end;
end;

procedure TfrmNewPO.GridClose;
begin
  quGrid.Close;
end;

procedure TfrmNewPO.GridRequery;
begin
  GridClose;
  GridOpen;
end;

procedure TfrmNewPO.GridPaint;
var
  slColor,
  slSize: TStringList;
  sCurrentColor: String;
  iMaxSizeWidth, iMaxColorWidth: integer;
  i, j: integer;
  s: String;

// ----------------------
// Sub
// ----------------------
   function IndexOfColor(sColor: String): integer;
   begin
     Result := slColor.IndexOf(sColor);
     if Result = -1 then
     begin
       Result := slColor.Add(sColor);
       sgGrid.RowCount := slColor.Count + 1;
     end;
     Result := Result + 1;
   end;

   function IndexOfSize(sSize: String): integer;
   begin
     Result := slSize.IndexOf(sSize);
     if Result = -1 then
     begin
       Result := slSize.Add(sSize);
       sgGrid.ColCount := slSize.Count + 1;
     end;
     Result := Result + 1;
   end;
// ----------------------
// Main
// ----------------------
begin
  // Utilizo dois StringList para incluir e recuperar os Index
  slColor := TStringList.Create;
  slSize  := TStringList.Create;

  with sgGrid do
  begin
    ColCount := 0;
    RowCount := 0;

    while not quGrid.EOF do
    begin
      Cells[IndexOfSize(quGridSizeName.AsString),
            IndexOfColor(quGridColor.AsString) ] := quGridQty.AsString;
      quGrid.Next;
    end;

    // Ajusto as Larguras das cell
    for i := 0 to slColor.Count-1 do
    begin
      j := Canvas.TextWidth(slColor[i]);
      if iMaxColorWidth < j then
        iMaxColorWidth := j;
    end;
    ColWidths[0] := iMaxColorWidth + COL_SPACE;

    for i := 0 to slSize.Count-1 do
    begin
      j := Canvas.TextWidth(slSize[i]);
      if iMaxSizeWidth < j then
        iMaxSizeWidth := j;
    end;

    for i := 1 to ColCount-1 do
      ColWidths[i] := iMaxSizeWidth + COL_SPACE;

    // Pinto os titulos das colunas e das linhas
    if ColCount > 1 then
      FixedCols := 1;

    if RowCount > 1 then
      FixedRows := 1;

    for i := 0 to slColor.Count-1 do
      Cells[0, i+1] := slColor[i];

    for i := 0 to slSize.Count-1 do
      Cells[i+1, 0] := slSize[i];
  end;

  slColor.Free;
  slSize.Free;
end;

procedure TfrmNewPO.sgGridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var
  iNewQty: Double;
begin
//  inherited;
  //Quando o Model e Size&Color o quFormQty nao pode ser atualizado.
  //Porque o quGrid esta no PreInventoryMov e ele e que atualiza as Qty.
  //Se o quForm atualizar as qty elas vao ficar duplicadas no Model

  {quForm.Edit;
  quFormQty.AsInteger := GridCountQty;}

//  quForm.Edit;
  iNewQty := MyStrToDouble(Trim(Value));

  // Devo atualizar o valor no query
  with quGrid do
  begin
    // Posiciono na linha correta
    with sgGrid do
      if (Cells[0, Row] <> '') and (Cells[Col, 0] <> '') then
        quGrid.Locate('Color;SizeName', VarArrayOf([Cells[0, ARow], Cells[ACol, 0]]), [])
      else if Cells[0, Row] <> '' then
        quGrid.Locate('Color', Cells[0, Row], [])
      else if Cells[Col, 0] <> '' then
        quGrid.Locate('SizeName', Cells[Col, 0], []);

    Edit;
    quGridQty.AsFloat := iNewQty;
    Post;
  end;
end;

procedure TfrmNewPO.scVendorSelectItem(Sender: TObject);
begin
//  inherited;
  SetVendor;
end;

procedure TfrmNewPO.FormRefresh;
var
  bComGrid: boolean;
begin
  // No form refresh tudo é feito a partir do quForm, nada pelos controles
  bComGrid := (quComboModelType.AsString = 'M');

  // Ajusta se a quantidade vai ser editavel pelo usuario.
  quantity.Properties.ReadOnly := bComGrid;
  if bComGrid then
    quantity.ParentColor := True
  else
    quantity.Style.Color := clWindow;

  // Ajusta se o grid de color e size vai ser visivel
  pnlSizeAndColor.Visible := bComGrid;
  if pnlSizeAndColor.Visible then
    GridRequery;
end;

procedure TfrmNewPO.ComboRefresh;
begin
  // A logica do refresh do combo é: Compara os parametros com o valores atuais,
  // so se algum for diferente da o refresh.
  with quCombo.Parameters.ParambyName('IDModel') do
    if Value <> dsform.dataset.FieldByName('modelID').AsInteger then
    begin
      quCombo.Close;
      Value := dsform.dataset.FieldByName('modelID').AsInteger;
    end;

  with quCombo do
    if not Active then
      Open;
end;

function TfrmNewPO.OnValidadeField: boolean;
begin
(* Antonio 2014 May - validation must be reviewed
  Result := False;

  // testa validacao dos campos
  if not (quFormModelID.AsInteger > 0) then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbCritical);
    quFormModelID.FocusControl;
    Exit;
  end;

  if not (quFormIDPessoa.AsInteger > 0) then
  begin
    MsgBox(MSG_CRT_THERE_IS_NO_VENDOR, vbOkOnly + vbCritical);
    quFormIDPessoa.FocusControl;
    Exit;
  end;

  if (pnlQty.Visible) or ((pnlQtyType.Visible) and (typeQty.ItemIndex = 1)) then
  begin
    if not (quFormQty.AsFloat > 0) and not (quantity.Properties.ReadOnly) then
    begin
      MsgBox(MSG_CRT_QTY_POSITIVE, vbOkOnly + vbCritical);
      quFormQty.FocusControl;
      Exit;
    end;


    if fModelCaseQty > 1 then
      if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
        if Frac(StrToFloat(quantity.Text) / fModelCaseQty) <> 0 then
        begin
          MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbCritical + vbOKOnly);
          quFormQty.FocusControl;
          Exit;
        end;
  end
  else
  begin
    if not (quFormCaseQty.AsFloat > 0) and not (quFormCaseQty.ReadOnly) then
    begin
      MsgBox(MSG_CRT_QTY_POSITIVE, vbOkOnly + vbCritical);
      quFormCaseQty.FocusControl;
      Exit;
    end;

    if not (quFormCaseCost.AsFloat > 0) then
    begin
      MsgBox(MSG_CRT_COST_POSITIVE, vbOkOnly + vbCritical);
      quFormCaseCost.FocusControl;
      Exit;
    end;
  end;

  if not(ValidatesQtyMin(quFormIDPessoa.AsInteger, quFormModelID.AsInteger, quFormQty.AsFloat, quFormCaseQty.AsFloat)) then
   begin
      MsgBox(MSG_INF_LESSER_MINIM_VENDOR, vbOkOnly + vbCritical);
      quFormQty.FocusControl;
      Exit;
    end;

  if (quFormDateEstimatedMov.AsString = '') then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOkOnly + vbCritical);
    quFormDateEstimatedMov.FocusControl;
    Exit;
  end;

  Result := True;
  *)
end;

function TfrmNewPO.OnAfterSaveChange(var iError:Integer):Boolean;
begin
(*
  Result := True;

  with spDO do
  try
    Parameters.ParambyName('@IDPreInventoryMov').Value := quFormIDPreInventoryMov.AsInteger;
    Parameters.ParambyName('@IDPO').Value := quFormDocumentID.AsInteger;
    ExecProc;
  except
    Result := False;
  end;
  *)
end;

procedure TfrmNewPO.OnAfterCommit;
begin
  if bNewOne then
    MsgBox(MSG_INF_PO_CREATED_VENDOR + fpoItem.fieldByName('pessoa').value, vbInformation + vbOkOnly);
end;

procedure TfrmNewPO.sgGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: String);
begin
//  inherited;
  //Value := '!99999;0; ';
end;

procedure TfrmNewPO.quGridAfterPost(DataSet: TDataSet);
//var
//  iTotQtde: integer;
begin
//  inherited;
  //O Post nao pode ser feito aqui, pois quForm que da o post no PreInvMov

  // O usuario atualizou o o valor unitaro
  // Recalculo a Qtde total do item de PO
  {
  with quGrid do
  begin
    First;
    iTotQtde := 0;
    while not EOF do
    begin
      iTotQtde := iTotQtde + quGridQty.AsInteger;
      Next;
    end;
    First;
  end;

  quForm.Edit;
  quFormQty.AsInteger := iTotQtde;}
end;

procedure TfrmNewPO.btAddColorClick(Sender: TObject);
begin
//  inherited;

  if quFormModelID.AsString <> '' then
    with TFrmModelAddColor.Create(self) do
    begin
      Screen.Cursor := crHourGlass;

      if Start(quFormModelID.AsInteger) then
      begin
        InsertSubModel;
        GridRequery;

        quForm.Edit;
        quFormQty.AsFloat := 0;
      end;

      Screen.Cursor := crDefault;
    end;
end;

procedure TfrmNewPO.btAddSizeClick(Sender: TObject);
begin
//  inherited;
  if quFormModelID.AsString <> '' then
    with TFrmModelAddSize.Create(self) do
    begin
      Screen.Cursor := crHourGlass;

      if Start(quFormModelID.AsInteger) then
      begin
        InsertSubModel;
        GridRequery;

        quForm.Edit;
        quFormQty.AsFloat := 0;
      end;

      Screen.Cursor := crDefault;
    end;
end;

procedure TfrmNewPO.RequestDblClick(Sender: TObject; iIDModel: integer);
begin
//  quFormModelID.AsInteger := iIDModel;
  SetModel;
end;

procedure TfrmNewPO.ModelDblClick(Sender: TObject; iIDFornecedor: integer);
begin
  quFormIDPessoa.AsInteger := iIDFornecedor;
  SetVendor;
end;

procedure TfrmNewPO.SetVendor;
begin
  quFormDocumentID.Clear;
  FramesRefresh;
end;

procedure TfrmNewPO.quFormBeforePost(DataSet: TDataSet);
begin
(*
  // Caso nao esteja setado, vou descobrir em qual PO que este item vai entrar
  // Se NewOne is true, devo avisar o usuario que foi criado um novo PO
  bNewOne := False;
  if quFormDocumentID.AsString = '' then
    with spGetCurrentPO do
    begin
      Parameters.ParambyName('@IDStore').Value  := DM.fStore.ID;
      Parameters.ParambyName('@IDPessoa').Value := quFormIDPessoa.AsInteger;
      Parameters.ParambyName('@Date').Value     := Trunc(Now);
      ExecProc;
      quFormDocumentID.AsInteger := Parameters.ParambyName('@IDPO').Value;
      bNewOne := Parameters.ParambyName('@NewOne').Value;
    end;
    *)
end;

procedure TfrmNewPO.editCostExit(Sender: TObject);
begin
 (* Antonio 2014 May
  if quForm.State = dsEdit then
    quFormCostPrice.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormCostPrice.AsCurrency);

  if not DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
    if ((quFormCostPrice.AsCurrency <> 0) and (fVendorCost <> 0)) AND
       (quFormCostPrice.AsCurrency <> fVendorCost) then
      if MsgBox(MSG_QST_CHANGE_PO_PRICE, vbYesNo + vbQuestion) = vbYes then
        quFormSalePrice.FocusControl;
  *)
end;

procedure TfrmNewPO.btnAddSizeColorClick(Sender: TObject);
begin
//  inherited;
  if quFormModelID.AsString <> '' then
    with TFrmModelAddSizeColor.Create(self) do
      if Start(quFormModelID.AsInteger) then
      begin
        InsertSubModel;
        GridRequery;

//        quForm.Edit;
//        quFormQty.AsFloat := 0;
      end;
end;

procedure TfrmNewPO.FormShow(Sender: TObject);
begin
//  inherited;
  quform := nil;

  if fIsRestricForm then
  begin
    scModel.TabStop         := False;
    btAddColor.Visible      := False;
    btAddSize.Visible       := False;
    btnAddSizeColor.Visible := False;
    quantity.SetFocus;
  end;

  SubListRequest.GetSubListProperties;

  if ( fAction = 'insert' ) then begin
     dsForm.DataSet := dm.getItemPurchaseToPO(-1);
     self.caption := 'Add Item';
     cleanUpScreen();
  end
  else if (fAction = 'update') then begin
     dsForm.DataSet := dm.getItemPurchaseToPO(fPOItem.fieldbyname('IDPreInventoryMov').Value);
     self.Caption := 'Edit Item';
     fillScreenItemPO(dsForm.DataSet);
     scModel.setfocus;
  end;

  itemPurchaseAfterOpen(dsForm.DataSet);
  enableDisableTransfer(scModel.Text);
end;

procedure TfrmNewPO.FormDestroy(Sender: TObject);
begin
  cdsTransfer.Close;
//  inherited;
  FreeAndNil(fFrmBarcodeSearch);
end;

procedure TfrmNewPO.RefreshQtyControls;
begin
  pnlQtyType.Visible := caseQuantity.Value > 0;
  pnlQty.Visible     := (caseQuantity.Value = 0) or (typeQty.ItemIndex = 1);
  pnlCaseQty.Visible := not pnlQty.Visible;
  pnlQtyType.Top     := 0;

end;

procedure TfrmNewPO.typeQtySelect(Sender: TObject);
begin
//  inherited;
  RefreshQtyControls;
end;

procedure TfrmNewPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;

  freeAndnil(fItemPurchaseModel);

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

function TfrmNewPO.FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;
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

procedure TfrmNewPO.SubListRequestSelectData(AParams: String);
var
  IDModel, IDModelParent : Integer;
begin
(* Antonio 2014 May
  if ( fAction = 'insert' ) then
  begin
    IDModel       := StrToIntDef(ParseParam(AParams, 'IDModel'), -1);
    IDModelParent := StrToIntDef(ParseParam(AParams, 'IDModelParent'), 0);
    if (IDModelParent <> 0) then
      IDModel := IDModelParent;
    if (IDModel <> -1) and (IDModel <> StrToIntDef(scModel.LookUpValue, 0)) then
    begin
      quFormModelID.AsInteger := IDModel;
      scModel.LookUpValue     := quFormModelID.AsString;
      quFormQty.AsFloat       := StrToFloat(ParseParam(AParams, 'Qty'));
      SetModel;
      GridRequery;
    end;
  end;
*)
end;

function TfrmNewPO.GetIDModel(IDModel:Integer):Integer;
begin

    with DM.quFreeSQL do
    try
      SQL.Clear;
      SQL.Add('SELECT IsNull(IDModelParent, IDModel) as IDModel');
      SQL.Add('FROM Model (NOLOCK) ');
      SQL.Add('WHERE IDModel = ' + IntToStr(IDModel));
      Open;
      if IsEmpty then
        Result := IDModel
      else
        Result := FieldByName('IDModel').AsInteger;
    finally
      Close;
      end;

end;

procedure TfrmNewPO.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
// Antonio 2014 May 13
  if sModelType <> 'S' then
    with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
      begin
        //quForm.Edit;
        //quFormModelID.AsInteger := GetIDModel(R);
        fItemPurchaseModel.ModelID := getIDModel(R);
        scModel.LookUpValue := intToStr(fItemPurchaseModel.ModelID);   //quFormModelID.AsString;
        SetModel;
        GridRequery;
        if not pnlQtyType.Visible then
        begin
          if quantity.CanFocus then
            quantity.SetFocus;
        end
        else
        begin
          caseQuantity.SetFocus;
          //quFormCaseQty.FocusControl;
        end;
      end;
    end;
end;

procedure TfrmNewPO.btTransferClick(Sender: TObject);
begin
  // Antonio 2014 May 13
  if scModel.LookUpValue = '' then
     Exit;

  cdsTransfer.Append;
  cdsTransferIDModel.Value      := dsForm.dataset.fieldbyname('ModelID').Value;
  cdsTransferIDLojaOrigem.Value := dsForm.dataset.fieldbyname('StoreID').Value;
  cdsTransferData.Value         := NOW;
  cdsTransferDescription.Value  := scModel.Text;
  cdsTransferIDUser.Value       := DM.fUser.ID;
  cdsTransferQty.Value          := quantity.Value;
  cdsTransferTax.Value          := 0;
  cdsTransferCostPrice.Value    := caseCost.Value;
  with TFrmNewPOTransfer.Create(Self) do
  begin
    Start(cdsTransfer, StrToInt(scModel.LookUpValue));
    Free;
  end;

end;

procedure TfrmNewPO.btConsultTransferClick(Sender: TObject);
begin
//  inherited;
  with TFrmNewPOTransferConsult.Create(Self) do
  begin
    cdsTransfer.Data := Start(cdsTransfer, SCREEN_CONSULT);
    Free;
  end;
end;

function TfrmNewPO.ValidatesQtyMin(IDVendor, IDModel: Integer; Qty, CaseQty: Double): Boolean;
var
  qryQtyMin : TADOQuery;
begin
  qryQtyMin := TADOQuery.Create(self);

  try
    with qryQtyMin do
    begin
      qryQtyMin.Connection := DM.ADODBConnect;

      SQL.Text := 'SELECT '+
                  ' MinQtyPO, '+
                  ' CaseQty '+
                  'FROM '+
                  ' Inv_ModelVendor (NOLOCK) '+
                  'WHERE '+
                  ' IDPessoa = ' + InttoStr(IDVendor) +
                  '	AND '+
                  ' IDModel = ' + InttoStr(IDModel);
      Open;

      if pnlQtyType.Visible then
      begin
        if typeQty.ItemIndex = 0 then
          Result := FieldByName('MinQtyPO').AsFloat <= CaseQty
        else
          Result := (FieldByName('MinQtyPO').AsFloat * fModelCaseQty) <= Qty;
      end else
        Result := (FieldByName('MinQtyPO').AsFloat <= Qty);
    end;
  finally
    FreeAndNil(qryQtyMin);
  end;
end;


procedure TfrmNewPO.DBEdit8Exit(Sender: TObject);
begin
//  inherited;
//  quFormSuggRetail.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormSuggRetail.AsCurrency);
end;

function TfrmNewPO.getSellingPriceChanged(idmodel: Integer): Currency;
var
  qry: TADOQuery;
begin
  try
     qry := TADOQuery.Create(nil);
     qry.Connection := dm.ADODBConnect;

     qry.SQL.Add('select SellingPrice from Model where IdModel =:idmodel');
     qry.Parameters.ParamByName('idmodel').Value := idmodel;
     qry.Open;

     if ( not qry.FieldByName('SellingPrice').IsNull ) then
        result := qry.fieldByname('SellingPrice').Value
     else
        result := 0;

  finally
     freeAndNil(qry);
  end;
end;

procedure TfrmNewPO.setRescueQtyOrder(const Value: Double);
begin
   fRescueQtyOrder := value;
end;

function TfrmNewPO.getQuantityAccordingType(qty_type: Integer; qty_browse, case_qty: Double): Double;
begin
   try
   result := 0;

   if ( qty_browse = 0 ) then
        qty_browse := 1;

   // Antonio 2013 Dec 05, MR-127
   if ( (qty_type = 0) and (case_qty > 1) ) then  // case type
      result := ( qty_browse / case_qty );
   except
      on E: Exception do begin
         if (case_qty > 0 ) then
            result := 2;
         raise Exception.Create('Exception found to define quantity ' + e.Message);
      end;
   end;
end;

function TfrmNewPO.getCaseCost(pIdModel: Integer; pQty: Double; pIdVendor: Integer = 0): Extended;
begin
  result := dm.getCostToPO(pidModel, pidVendor);
  quFormCaseCost.value := result;
end;

procedure TfrmNewPO.btCloseClick(Sender: TObject);
var
  preInvMovID: Integer;
begin
//  inherited;

   validate();

//   if ( isNewOnePO() ) then begin
//      OnAfterCommit();
//   end;

   if ( fAction = 'insert') then begin
      preInvMovID := dm.insertItemPurchaseToPO(fItemPurchaseModel);
      cleanUpScreen();
      caseQuantity.Value := 0;
      caseCost.Value := 0;
      quantity.Value := 0;
      cost.Value := 0;
      ourPrice.Value   := 0;
      suggRetail.value := 0;
      scModel.LookUpValue := '';
   end
   else if ( fAction = 'update') then begin
      dm.updateItemPurchaseToPO(fItemPurchaseModel);
      preInvMovID := fItemPurchaseModel.IdPreInventoryMov;
   end;

   callSpDo(preInvMovID);
end;

function TfrmNewPO.start(arg_po: TDataset; arg_poItem: TDataset; arg_action: String): Boolean;
begin
  fAction := arg_action;
  fpo := arg_po;
  fpoItem := arg_poItem;
  fItemPurchaseModel := TItemPurchaseModel.Create();
  result := ( showModal = mrOK );
end;

procedure TfrmNewPO.cleanUpScreen();
begin
   vendor.Text := fpo.fieldbyname('fornecedor').asString;
   store.Text  := fpo.fieldByName('store').AsString;   //dm.getNameStore(fpo.fieldbyname('StoreID').Value);

   // default values according to PO settings.  -> Antonio 05/18/2017
   orderOn.Date := fpo.fieldByName('DataPedido').Value;
   arrivalEstimateDate.Date := fpo.fieldByName('EstArrival').Value;

   // Antonio 10/15/2015
   if ( not fPOItem.IsEmpty ) then begin

       if ( not fpoItem.FieldByName('movdate').IsNull ) then begin
          orderOn.Date := fpoItem.fieldbyName('movdate').value;
       end;

       if ( not fpoItem.fieldByName('dateEstimatedMov').IsNull ) then begin
          arrivalEstimateDate.Date := fpoItem.fieldByName('dateEstimatedMov').Value;
       end;

   end;

   // Antonio 04/27/2017
   if ( self.fAction = 'insert' ) then begin
      caseQuantity.Value := 0;
      caseCost.Value := 0;
      quantity.Value := 0;
      cost.Value := 0;
      ourPrice.Value   := 0;
      suggRetail.value := 0;
      scModel.LookUpValue := '';
   end;

   (*
   // Antonio 04/27/2017
   if ( not dsform.dataset.fieldByName('caseQty').isNull ) then begin
       caseQuantity.Value := dsform.dataset.fieldByName('caseQty').Value;
   end;

   ourPrice.Value   := 0.00;
   suggRetail.value := 0.00;
   quantity.Value   := 0.00 ;
   *)

end;

procedure TfrmNewPO.fillScreenItemPO(arg_po: TDataset);
begin
   vendor.Text := fPO.fieldByName('fornecedor').asString;
   store.Text := fpo.fieldByName('store').asString;
   orderOn.Date := dsform.dataset.fieldbyName('movdate').value;
   arrivalEstimateDate.Date := dsform.dataset.fieldByName('dateEstimatedMov').Value;
   ourPrice.Value := dsform.dataset.fieldByName('salePrice').Value;
   suggRetail.value := dsform.dataset.fieldByName('suggRetail').Value;;
   cost.Value := dsform.dataset.fieldByName('caseCost').Value;
   scModel.LookUpValue := dsform.dataset.fieldByName('modelID').Value;
   typeQty.Text := '';
   caseQuantity.Text := dsform.dataset.fieldByName('caseQty').asString;
   quantity.Text := dsform.dataset.fieldByName('qty').asString;
end;

function TfrmNewPO.validate: Boolean;
begin
   if ( not fPOItem.fieldByName('IDPreinventoryMov').IsNull ) then begin
      fItemPurchaseModel.IdPreInventoryMov := fPOItem.fieldByName('IDPreinventoryMov').Value;
   end;

   fItemPurchaseModel.DocumentID := fpo.FieldByName('IDPO').Value;
   fItemPurchaseModel.IdPessoa := fPO.fieldByName('IDFornecedor').Value;
   fItemPurchaseModel.StoreID := fPO.fieldByName('IDStore').Value;
   fItemPurchaseModel.InventoryMovTypeID := 2;//fPOItem.fieldByName('InventMovTypeID').Value;
   fItemPurchaseModel.ModelID := scModel.LookUpFieldValue;
   fItemPurchaseModel.SalePrice := ourPrice.Value;
   fItemPurchaseModel.SuggRetail := suggRetail.Value;

   if ( orderOn.date < 0 ) then begin
      fItemPurchaseModel.MovDate := now;
   end else begin
            fItemPurchaseModel.MovDate := orderOn.date;
       end;

   if ( arrivalEstimateDate.Date < 0 ) then begin
      fItemPurchaseModel.DateEstimatedMov := now;
   end else begin
            fItemPurchaseModel.DateEstimatedMov := arrivalEstimateDate.Date
       end;

   fItemPurchaseModel.UserID := dm.fUser.ID;
   fItemPurchaseModel.CostPrice := cost.Value;
   fItemPurchaseModel.CaseCost := caseCost.Value;
   fItemPurchaseModel.CaseQty := caseQuantity.Value;
   fItemPurchaseModel.Qty := quantity.Value;

end;

procedure TfrmNewPO.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  inherited;

end;

procedure TfrmNewPO.FormStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
//  inherited;

end;

procedure TfrmNewPO.callSpDO(arg_preinvmovID: Integer);
begin
  with spDO do
  try
    Parameters.ParambyName('@IDPreInventoryMov').Value := arg_preinvmovID; //dsform.dataset.fieldByName('IDPreInventoryMov').AsInteger;
    Parameters.ParambyName('@IDPO').Value := fItemPurchaseModel.DocumentID; //dsform.dataset.fieldByName('DocumentID').AsInteger;
    ExecProc;
  except
    on e: Exception do begin
       raise Exception.Create(format('SpDO stored procedure error : %s', [e.message]));
    end;
  end;
end;

function TfrmNewPO.TestOnEditModes: Boolean;
begin
//   inherited;
end;

procedure TfrmNewPO.btCancelClick(Sender: TObject);
begin
//  inherited;
   ModalResult := mrOK;
end;

procedure TfrmNewPO.cancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOK
end;

function TfrmNewPO.isNewOnePO: Boolean;
begin
  result := false;
  if fPOItem.FieldByName('DocumentID').AsString = '' then
    with spGetCurrentPO do
    begin
      Parameters.ParambyName('@IDStore').Value  := DM.fStore.ID;
      Parameters.ParambyName('@IDPessoa').Value := fPOItem.fieldByName('IDPessoa').AsInteger;
      Parameters.ParambyName('@Date').Value     := Trunc(Now);
      ExecProc;
      fItemPurchaseModel.DocumentID := Parameters.ParambyName('@IDPO').Value;
      result := Parameters.ParambyName('@NewOne').Value;
    end;
end;

procedure TfrmNewPO.enableDisableTransfer(arg_model: String);
var
  popItem: TMenuItem;
begin
  popItem := popModel.Items.Find('Transfer');
  popItem.Enabled := trim(arg_model) <> ''
end;

end.
