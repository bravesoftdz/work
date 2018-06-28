unit uFchTranfModelItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichasBrowse, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, Grids, DBGrids, Mask, SuperComboADO,
  StdCtrls, DBCtrls, ADODB, FormConfig, PowerADOQuery, siComp, siLangRT,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, LblEffct, ExtCtrls, Buttons, SMDBGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu, SubListPanel, mrBarCodeEdit,
  uNumericFunctions, uFrmBarcodeSearch;

type
  TFchTranfModelItem = class(TbrwFrmParentBrw)
    tsItem: TTabSheet;
    Label2: TLabel;
    EditQty: TDBEdit;
    cmbModel: TDBSuperComboADO;
    Label4: TLabel;
    quFormIDModelTransfDet: TIntegerField;
    quFormIDModelTransf: TIntegerField;
    quFormIDModel: TIntegerField;
    quBrowseIDModelTransfDet: TIntegerField;
    quBrowseIDModelTransf: TIntegerField;
    quBrowseIDLojaOrigem: TIntegerField;
    quBrowseIDLojaDestino: TIntegerField;
    SubQty: TSubListPanel;
    quFormCostPrice: TBCDField;
    quFormTax: TBCDField;
    lbCost: TLabel;
    edtCostPrice: TDBEdit;
    lbTax: TLabel;
    DBEdit2: TDBEdit;
    quFormQty: TFloatField;
    lbBarcode: TLabel;
    edtBarcode: TmrBarCodeEdit;
    lbModel: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    quFormSellingPrice: TBCDField;
    lbSellingPrice: TLabel;
    DBEdit1: TDBEdit;
    btnSearchDesc: TBitBtn;
    quFormIDLote: TIntegerField;
    scLot: TDBSuperComboADO;
    lbLot: TLabel;
    quFormTaxCode: TStringField;
    edtTaxCode: TDBEdit;
    lbTaxCode: TLabel;
    procedure cmbModelSelectItem(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormAfterInsert(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure EditQtyKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure scLotEnter(Sender: TObject);
  private
    fScanBarcode : Boolean;
    fIDStoreDest,
    fIDStoreOrig : Integer;
    fOut : Boolean;
    fModelCaseQty: Double;
    fFrmBarcodeSearch : TFrmBarcodeSearch;
    bControlLot : Boolean;
    bUseLot : Boolean;
    procedure RefreshQty(IDModel : String);
    function HasSerial:Boolean;
    function ValidateQty: Boolean;
    procedure DisplayLot;
    procedure ReadLotInfo;
    procedure EnableLotControls;
  protected
    procedure OnAfterCommit; override;
    procedure GetModelInfo;
    procedure OnBeforeShow; override;
    procedure OnAfterStart; override;
    function OnValidadeField: boolean; override;
    procedure OnAfterUpdateNavegator; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uDMGlobal, uFrmSerialNumber, PaiDeTodos, uMsgBox, uMsgConstant,
     uSystemConst, uCharFunctions, PaiDeFichas, uPassword, uParamFunctions,
     uSystemTypes;

procedure TFchTranfModelItem.OnAfterCommit;
begin
  //Verifica se a categoria transfere os models
  if quFormQty.AsFloat <> 0 then
     if HasSerial then
        with TFrmSerialNumber.Create(Self) do
        begin
             StartOnTransfer(StrToInt(cmbModel.LookUpValue),
                             fIDStoreOrig,
                             fIDStoreDest,
                             quFormIDModelTransfDet.AsInteger,
                             quFormQty.AsFloat
                             );
        end;


    if quFormIDLote.AsInteger <> 0 then
      if fOut then //Saida = 7
      begin
        DM.FDMInventory.LotAdjust(quFormIDModel.AsInteger,
                               fIDStoreOrig,
                               quFormIDLote.AsInteger,
                               quFormQty.AsFloat,
                               3);
      end
      else
      begin
        DM.FDMInventory.LotAdjust(quFormIDModel.AsInteger,
                               fIDStoreDest,
                               quFormIDLote.AsInteger,
                               quFormQty.AsFloat,
                               2);
      end;

end;

function TFchTranfModelItem.HasSerial:Boolean;
begin

  if cmbModel.LookUpValue = '' then
     Exit;

  with DM.quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Clear;
     SQL.Text := 'SELECT TG.SerialNumber '+
                 'FROM TabGroup TG (NOLOCK) '+
                 'JOIN Model M (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
                 'WHERE M.IDModel = ' + cmbModel.LookUpValue;
     Open;
     Result := FieldByName('SerialNumber').AsBoolean;
     Close;
     end;
end;

procedure TFchTranfModelItem.RefreshQty(IDModel : String);
begin

  if IDModel <> '' then
    SubQty.Param := 'IDModel='+IDModel+';'
  else
    SubQty.Param := 'IDModel=-1;'

end;

procedure TFchTranfModelItem.cmbModelSelectItem(Sender: TObject);
begin
  inherited;

  if not(DM.ModelRestored(StrToInt(cmbModel.LookUpValue))) then
  begin
    edtBarcode.Text := '';
    cmbModel.LookUpValue := '';
    Exit;
  end;

  RefreshQty(cmbModel.LookUpValue);
  EditQty.SetFocus;
  GetModelInfo;
end;

procedure TFchTranfModelItem.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshQty(quFormIDModel.AsString);
end;

procedure TFchTranfModelItem.quFormAfterInsert(DataSet: TDataSet);
begin
  inherited;
  RefreshQty(quFormIDModel.AsString);
  if fScanBarcode then
    edtBarcode.SetFocus
  else
    cmbModel.SetFocus;
end;

procedure TFchTranfModelItem.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1820);
end;

procedure TFchTranfModelItem.btCloseClick(Sender: TObject);
begin
  inherited;
  //refresh o Browse anterior
  MybrwQuery.Close;
  MybrwQuery.Open;
  SubQty.Param := 'IDModel=0;';
end;

procedure TFchTranfModelItem.FormCreate(Sender: TObject);
begin
  inherited;
  SubQty.CreateSubList;
  fScanBarcode := False;
  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];
  fFrmBarcodeSearch            := TFrmBarcodeSearch.Create(Self);
  bControlLot                  := DM.fSystem.SrvParam[PARAM_USE_LOT_CONTROL];

  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);
end;

procedure TFchTranfModelItem.FormShow(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
  begin
    cmbModel.TabStop := False;
    EditQty.SetFocus;
  end;

  ReadLotInfo;
  DisplayLot;
  EnableLotControls;

end;

procedure TFchTranfModelItem.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  //Colocar o TranferData
end;

procedure TFchTranfModelItem.GetModelInfo;
begin
  if (cmbModel.LookUpValue = '') or (fIDStoreOrig = 0) then
    Exit;

  fModelCaseQty := cmbModel.GetFieldByName('CaseQty');

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT M.VendorCost, M.UseLot, M.AvgCost, M.SellingPrice, M.ReplacementCost, I.SellingPrice as StorePrice');
    SQL.Add('FROM Model M (NOLOCK)');
    SQL.Add('LEFT JOIN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID AND I.StoreID = '+ IntToStr(fIDStoreOrig) +')');
    SQL.Add('WHERE M.IDModel = ' + cmbModel.LookUpValue);
    Open;
    if FieldByName('StorePrice').AsCurrency = 0 then
      quFormSellingPrice.AsCurrency := FieldByName('SellingPrice').AsCurrency
    else
      quFormSellingPrice.AsCurrency := FieldByName('StorePrice').AsCurrency;
    quFormCostPrice.AsCurrency := FieldByName('VendorCost').AsCurrency;
    bUseLot                    := FieldByName('UseLot').AsBoolean;
    Close;
  end;

  DisplayLot;

end;

procedure TFchTranfModelItem.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchTranfModelItem.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TFchTranfModelItem.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel : Integer;
begin
  inherited;

  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      cmbModel.LookUpValue := IntToStr(IDModel);
      cmbModelSelectItem(nil);
      fScanBarcode := True;
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;

  edtBarcode.Clear;
end;

procedure TFchTranfModelItem.EditQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

function TFchTranfModelItem.ValidateQty: Boolean;
begin
  Result := False;

  if cmbModel.LookUpValue <> '' then
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text :=   'SELECT ' +
                           'StoreID, ' +
                           'ModelID, ' +
                           '(QtyOnHand) as Qty ' +
                    'FROM ' +
                           'Inventory (NOLOCK)' +
                    'WHERE ' +
                           'ModelID = ' + cmbModel.LookUpValue +
                           ' AND StoreID = ' + IntToStr(fIDStoreOrig);
      Open;

      if FieldByName('Qty').AsFloat >= quForm.FieldByName('Qty').AsFloat then
        Result := True;
      Close;
    end;
end;

function TFchTranfModelItem.OnValidadeField: boolean;
begin

  Result := inherited OnValidadeField;
  
  if cmbModel.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbCritical + vbOKOnly);
    Result := False;
    Exit;
  end;

  if (EditQty.Text = '') or (StrToFloat(EditQty.Text) <= 0) then
  begin
    MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbCritical + vbOKOnly);
    EditQty.SetFocus;
    EditQty.SelectAll;
    Result := False;
    Exit;
  end;

  if edtCostPrice.Visible then
    if (edtCostPrice.Text = '') then
    begin
      MsgBox(MSG_CRT_NO_EMPTY_COST, vbCritical + vbOKOnly);
      edtCostPrice.SetFocus;
      edtCostPrice.SelectAll;
      Result := False;
      Exit;
    end;

  if not ValidateQty then
  begin
    if (not Password.HasFuncRight(8)) then
    begin
      MsgBox(MSG_CRT_INVENTORY_WILL_BE_NEG, vbCritical);
      Result := False;
      Exit;
    end
    else if (MsgBox(MSG_QST_INV_WILL_BE_NEGATIVE, vbCritical + vbYesNo) = vbNo)then
    begin
      Result := False;
      Exit;
    end;
  end;

  if fModelCaseQty > 0 then
    if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
      if Frac(StrToFloat(EditQty.Text) / fModelCaseQty) <> 0 then
      begin
        MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbCritical + vbOKOnly);
        Result := False;
        Exit;
      end;

  if not bUseLot then
    quFormIDLote.Required := False
  else
    quFormIDLote.Required := bControlLot;
      
end;

procedure TFchTranfModelItem.OnBeforeShow;
var
  bCanSeeCost: Boolean;
begin
  inherited;
  bCanSeeCost := Password.HasFuncRight(70);
  edtCostPrice.Visible := bCanSeeCost;
  lbCost.Visible := bCanSeeCost;
  Label6.Visible := bCanSeeCost;
  fIDStoreDest := StrToInt(ParseParam(Self.sParam, 'IDLojaDestino'));
  fIDStoreOrig := StrToInt(ParseParam(Self.sParam, 'IDLojaOriginal'));
  fOut         := (ParseParam(Self.sParam, 'Out') = '0');

end;

procedure TFchTranfModelItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fFrmBarcodeSearch);
end;

procedure TFchTranfModelItem.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
        begin
          cmbModel.LookUpValue := IntToStr(R);
          cmbModelSelectItem(Self);
        end;
    end;

end;

procedure TFchTranfModelItem.scLotEnter(Sender: TObject);
begin
  inherited;

  if cmbModel.LookUpValue <> '' then
    DM.FFchParam := 'Qty='+FloatToStr(quFormQty.AsFloat)+';IDModel='+cmbModel.LookUpValue+';';

end;

procedure TFchTranfModelItem.DisplayLot;
begin

  if bUseLot and (cmbModel.LookUpValue <> '') then
  begin
    scLot.SpcWhereClause := 'IDModel = ' + cmbModel.LookUpValue;
    scLot.Visible := True;
    lbLot.Visible := True;
  end
  else
  begin
    DM.FFchParam  := '';
    scLot.Visible := False;
    lbLot.Visible := False;
  end;

end;

procedure TFchTranfModelItem.ReadLotInfo;
begin
  bUseLot := (quFormIDLote.AsInteger <> 0);
end;

procedure TFchTranfModelItem.OnAfterStart;
begin
  inherited;

  quFormQty.ReadOnly := False;
  cmbModel.ReadOnly  := False;
  cmbModel.Enabled   := True;
  scLot.ReadOnly     := False;
  scLot.Enabled      := True;

end;

procedure TFchTranfModelItem.OnAfterUpdateNavegator;
begin
  inherited;

  ReadLotInfo;
  DisplayLot;
  EnableLotControls;
  
end;

procedure TFchTranfModelItem.EnableLotControls;
begin

  if (frmCommand = btAlt) and bUseLot then
  begin
    quFormQty.ReadOnly := True;
    cmbModel.ReadOnly  := True;
    cmbModel.Enabled   := False;
    scLot.ReadOnly     := True;
    scLot.Enabled      := False;
  end
  else
  begin
    quFormQty.ReadOnly := False;
    cmbModel.ReadOnly  := False;
    cmbModel.Enabled   := True;
    scLot.ReadOnly     := False;
    scLot.Enabled      := True;
  end;

end;

end.
