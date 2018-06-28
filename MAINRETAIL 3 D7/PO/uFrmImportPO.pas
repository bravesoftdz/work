(*
-----------------------------------------------------------------------------------------------------
Version : (292 - 293)
Date    : 06.06.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : avoid decrease when parameter ( new parameter ) is set to true.
Solution: set up correct mask to display format properfield object.
Version : (293 - 294)
-----------------------------------------------------------------------------------------------------
Version : (292 - 293)
Date    : 06.06.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   :
Solution: keep sale price if update is true.
Version :
-----------------------------------------------------------------------------------------------------

*)

unit uFrmImportPO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, siComp, siLangRT, LblEffct, ExtCtrls, StdCtrls, Db, ADODB,
  Mask, DBCtrls, PowerADOQuery, Grids, DBGrids, SMDBGrid, Variants,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, uInventoryCalc, Buttons,
  Provider, DBClient, uDMCalcTax;

type
  TFrmImportPO = class(TFrmParent)
    pnlPO: TPanel;
    Label7: TLabel;
    pnlPODetail: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    pnlPOToolBar: TPanel;
    quPO: TADOQuery;
    quPOIDPO: TIntegerField;
    quPOIDFornecedor: TIntegerField;
    quPODataPedido: TDateTimeField;
    quPOSubTotal: TFloatField;
    quPOIDStore: TIntegerField;
    quPOCharges: TFloatField;
    quPOFreight: TFloatField;
    quPOTotal: TCurrencyField;
    quPOFornecedor: TStringField;
    quPOStore: TStringField;
    quPOEstArrival: TDateTimeField;
    dsPO: TDataSource;
    DBEdit5: TDBEdit;
    pnlPOItem: TPanel;
    Label1: TLabel;
    quPOItem: TPowerADOQuery;
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
    quPOItemCurrentSale: TFloatField;
    quPOItemCurrentCost: TFloatField;
    quPOItemCurrentSuggRetail: TFloatField;
    quPOItemCategory: TStringField;
    quPOItemSize: TStringField;
    quPOItemCodSize: TStringField;
    quPOItemColor: TStringField;
    quPOItemCodColor: TStringField;
    quPOItemModelType: TStringField;
    dsPOItem: TDataSource;
    quCreateOrder: TADOCommand;
    quPOItemGroupID: TIntegerField;
    DBEdit6: TDBEdit;
    grdPreSaleItem: TcxGrid;
    grdPreSaleItemDB: TcxGridDBTableView;
    grdPreSaleItemDBMarked: TcxGridDBColumn;
    grdPreSaleItemDBQty: TcxGridDBColumn;
    grdPreSaleItemDBModel: TcxGridDBColumn;
    grdPreSaleItemDBDescription: TcxGridDBColumn;
    grdPreSaleItemDBTotal: TcxGridDBColumn;
    grdPreSaleItemLevel1: TcxGridLevel;
    quPOItemMarked: TBooleanField;
    grdPreSaleItemDBQtyRealMov: TcxGridDBColumn;
    grdPreSaleItemDBSalePrice: TcxGridDBColumn;
    grdPreSaleItemDBSuggRetail: TcxGridDBColumn;
    quPOPayDays: TIntegerField;
    quPOItemQty: TFloatField;
    quPOItemQtyRealMov: TFloatField;
    quPOItemQtyTotal: TFloatField;
    quPOItemCaseQty: TFloatField;
    quPOItemCaseCost: TBCDField;
    Panel4: TPanel;
    btMarked: TSpeedButton;
    btUnMarked: TSpeedButton;
    cdsPOItem: TClientDataSet;
    dspPOItem: TDataSetProvider;
    grdPO: TcxGrid;
    grdPODB: TcxGridDBTableView;
    grdPOLevel: TcxGridLevel;
    grdPODBIDPO: TcxGridDBColumn;
    grdPODBDataPedido: TcxGridDBColumn;
    quPOItemIDModelGroup: TIntegerField;
    quPOItemIDModelSubGroup: TIntegerField;
    cdsPOItemIDPreInventoryMov: TIntegerField;
    cdsPOItemDocumentID: TIntegerField;
    cdsPOItemIDModel: TIntegerField;
    cdsPOItemModel: TStringField;
    cdsPOItemDescription: TStringField;
    cdsPOItemCostPrice: TFloatField;
    cdsPOItemSalePrice: TFloatField;
    cdsPOItemSuggRetail: TFloatField;
    cdsPOItemSubTotal: TFloatField;
    cdsPOItemPessoa: TStringField;
    cdsPOItemMovDate: TDateTimeField;
    cdsPOItemDateEstimatedMov: TDateTimeField;
    cdsPOItemCurrentSale: TFloatField;
    cdsPOItemCurrentCost: TFloatField;
    cdsPOItemCurrentSuggRetail: TFloatField;
    cdsPOItemCategory: TStringField;
    cdsPOItemSize: TStringField;
    cdsPOItemCodSize: TStringField;
    cdsPOItemColor: TStringField;
    cdsPOItemCodColor: TStringField;
    cdsPOItemModelType: TStringField;
    cdsPOItemGroupID: TIntegerField;
    cdsPOItemMarked: TBooleanField;
    cdsPOItemQty: TFloatField;
    cdsPOItemQtyRealMov: TFloatField;
    cdsPOItemQtyTotal: TFloatField;
    cdsPOItemCaseQty: TFloatField;
    cdsPOItemCaseCost: TBCDField;
    cdsPOItemIDModelGroup: TIntegerField;
    cdsPOItemIDModelSubGroup: TIntegerField;
    grdPreSaleItemDBNewSalePrice: TcxGridDBColumn;
    grdPreSaleItemDBNewSuggRetail: TcxGridDBColumn;
    quPOItemNewSalePrice: TBCDField;
    quPOItemNewSuggRetail: TBCDField;
    cdsPOItemNewSalePrice: TBCDField;
    cdsPOItemNewSuggRetail: TBCDField;
    cmdUpdateTaxCost: TADOCommand;
    pnlOption: TPanel;
    chkUpdateSalePrice: TCheckBox;
    chkCalcTax: TCheckBox;
    strepPredefined: TcxStyleRepository;
    cxHilight: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    cxValue: TcxStyle;
    grdPreSaleItemDBMarkup: TcxGridDBColumn;
    Panel9: TPanel;
    btPOColumn: TSpeedButton;
    Label2: TLabel;
    edtMarkup: TEdit;
    Panel5: TPanel;
    quPOItemMarkup: TBCDField;
    cdsPOItemMarkup: TBCDField;
    btnApply: TSpeedButton;
    Splitter1: TSplitter;
    quPOItemModelMarkup: TBCDField;
    cdsPOItemModelMarkup: TBCDField;
    quPOItemModelCaseQty: TBCDField;
    cdsPOItemModelCaseQty: TBCDField;
    grdPreSaleItemDBCaseCost: TcxGridDBColumn;
    quPOItemExtCaseCost: TBCDField;
    cdsPOItemExtCaseCost: TBCDField;
    grdPreSaleItemDBExtCaseCost: TcxGridDBColumn;
    quPOItemVendorCode: TStringField;
    cdsPOItemVendorCode: TStringField;
    grdPreSaleItemDBVendorCode: TcxGridDBColumn;
    lbDelItem: TLabel;
    quPOItemMVAInterno: TBCDField;
    quPOItemMVAInterestadual: TBCDField;
    quPOItemIncide: TBooleanField;
    cdsPOItemMVAInterno: TBCDField;
    cdsPOItemMVAInterestadual: TBCDField;
    cdsPOItemIncide: TBooleanField;
    quPOIDEstado: TStringField;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    btnSave: TBitBtn;
    quPOItemUpdatePrice: TBooleanField;
    cdsPOItemUpdatePrice: TBooleanField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure quPOCalcFields(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure btMarkedClick(Sender: TObject);
    procedure btUnMarkedClick(Sender: TObject);
    procedure cdsPOItemBeforePost(DataSet: TDataSet);
    procedure cdsPOItemCostPriceChange(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btPOColumnClick(Sender: TObject);
    procedure cdsPOItemNewSalePriceChange(Sender: TField);
    procedure btnApplyClick(Sender: TObject);
    procedure edtMarkupKeyPress(Sender: TObject; var Key: Char);
    procedure grdPreSaleItemDBTotalPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cdsPOItemCaseCostChange(Sender: TField);
    procedure cdsPOItemAfterOpen(DataSet: TDataSet);
    procedure grdPODBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    fIDVendor,
    fIDStore,
    fIDPurchase,
    fIDPurchaseItem,
    fPayDays,
    fIDPO : Integer;
    fTaxInCost  : Boolean;
    bUseMarkup  : Boolean;
    DMCalcTax : TDMCalcTax;
    bUseMarkupOnCost : Boolean;
    bAutoCalcMargin, bAutoRound : Boolean;
    bUpdateCase, bUpdateItem : Boolean;   
    bAfterShow : Boolean;
    bDelLeftPOItem : Boolean;

    procedure OpenPO;
    procedure ClosePO;
    procedure OpenPOItem;
    procedure ClosePOItem;
    procedure RefreshPOItem;
    procedure SavePurchase;
    procedure InsertVendorTax;

    procedure CheckAll(Value: Boolean);
    procedure SetNewSalesPrices;

    procedure ConfigColumns(AView: TcxCustomGridTableView);
    function CalcMarkupPercent(Cost, Sale: Currency) : Currency;
  public
    function Start(IDVendor, IDStore, IDPurchase: Integer; TaxInCost: Boolean;
      var PayDays, IDPO: Integer): Boolean;
  end;

implementation

uses uDM, uHandleError, uSystemConst, uCharFunctions, uDMCalcPrice, uMsgBox,
     uMsgConstant, uNumericFunctions, uWebFunctions, uDMGlobal;

{$R *.DFM}

procedure TFrmImportPO.SavePurchase;
var
  NewSalePrice, NewSuggRetail : Currency;
  bUpdatePO : Boolean;
begin

  bUpdatePO := False;

  try
    DM.ADODBConnect.BeginTrans;

    cdsPOItem.DisableControls;
    cdsPOItem.First;

    while not cdsPOItem.Eof do
    begin
      if (cdsPOItem.FieldByName('Marked').AsBoolean) and (cdsPOItem.FieldByName('QtyTotal').AsFloat > 0)
         and (cdsPOItem.FieldByName('CostPrice').AsFloat > 0) then
      begin
        fIDPurchaseItem := DM.GetNextID(MR_PURCHASE_ITEM_ID);

        with quCreateOrder do
        begin
          Parameters.ParamByName('IDPurchaseItem').Value    := fIDPurchaseItem;
          Parameters.ParamByName('IDPurchase').Value        := fIDPurchase;
          Parameters.ParamByName('IDModel').Value           := cdsPOItem.FieldByName('IDModel').AsInteger;
          Parameters.ParamByName('Qty').Value               := cdsPOItem.FieldByName('QtyTotal').AsFloat;
          Parameters.ParamByName('GroupID').Value           := cdsPOItem.FieldByName('GroupID').AsInteger;
          Parameters.ParamByName('IDVendor').Value          := fIDVendor;
          Parameters.ParamByName('IDPreInventoryMov').Value := cdsPOItem.FieldByName('IDPreInventoryMov').AsInteger;
          Parameters.ParamByName('CaseQty').Value           := cdsPOItem.FieldByName('CaseQty').AsFloat;
          Parameters.ParamByName('CaseCost').Value          := cdsPOItem.FieldByName('CaseCost').AsCurrency;

          if fTaxInCost then
          begin
            Parameters.ParamByName('CostWithTax').Value := (cdsPOItem.FieldByName('CostPrice').AsCurrency * cdsPOItem.FieldByName('QtyTotal').AsFloat);
            Parameters.ParamByName('CostPrice').Value   := Null;
            Parameters.ParamByName('SalePrice').Value   := Null;
            Parameters.ParamByName('SuggRetail').Value  := Null;
          end
          else
          begin
            NewSalePrice  := cdsPOItem.FieldByName('CostPrice').AsCurrency;
            NewSuggRetail := cdsPOItem.FieldByName('CostPrice').AsCurrency;

            Parameters.ParamByName('CostWithTax').Value    := Null;
            Parameters.ParamByName('CostPrice').Value      := cdsPOItem.FieldByName('CostPrice').AsCurrency;

            Parameters.ParamByName('SalePrice').Value := cdsPOItem.FieldByName('NewSalePrice').AsCurrency;
            Parameters.ParamByName('SuggRetail').Value := cdsPOItem.FieldByName('NewSuggRetail').AsCurrency;
          end;
          Execute;
        end;

        //Inserir as taxas caso tenha
        if fTaxInCost then
          InsertVendorTax;
      end;

      if bDelLeftPOItem and (not cdsPOItem.FieldByName('Marked').AsBoolean) and
         (cdsPOItem.FieldByName('IDPreInventoryMov').AsInteger <> 0) then
      begin
        DM.RunSQL('DELETE FROM vwPOItem WHERE vwPOItem.IDPOItem = ' + cdsPOItem.FieldByName('IDPreInventoryMov').AsString);
        bUpdatePO := True;
      end;

      cdsPOItem.Next;
    end;

    fPayDays := quPOPayDays.AsInteger;
    fIDPO    := quPOIDPO.AsInteger;

    DM.RunSQL('EXEC sp_Purchase_AtuPurchaseSubTotal ' + IntToStr(fIDPurchase) + ', ' + IntToStr(Byte(fTaxInCost)));

    if bUpdatePO then
    begin
      DM.RunSQL('EXEC sp_PO_AtuPOTotal ' + IntToStr(fIDPO));
      DM.RunSQL('EXEC sp_PO_CalcTotalQty ' + IntToStr(fIDPO));
    end;

    DM.ADODBConnect.CommitTrans;
    cdsPOItem.EnableControls;
  except
    on E: Exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      DM.SetError(CRITICAL_ERROR, Self.Name, 'ParentFch.NextAppend.quForm.Append.Exception' + #13#10 + E.Message);
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TFrmImportPO.RefreshPOItem;
begin
  try
    DM.WaitForm.Start(False);
    Application.ProcessMessages;
    ClosePOItem;
    OpenPOItem;
  finally
    DM.WaitForm.Hide;
  end;
end;

procedure TFrmImportPO.OpenPOItem;
begin
  with cdsPOItem do
    if not Active then
    begin
      Params.ParamByName('IDPO').Value := quPOIDPO.AsInteger;
      Open;
    end;
end;

procedure TFrmImportPO.ClosePOItem;
begin
  with cdsPOItem do
    if Active then
      Close;
end;

procedure TFrmImportPO.OpenPO;
begin
  with quPO do
    if not Active then
    begin
      Parameters.ParamByName('IDFornecedor').Value := fIDVendor;
      Parameters.ParamByName('IDStore').Value      := fIDStore;
      Open;
    end;
end;

procedure TFrmImportPO.ClosePO;
begin
  with quPO do
    if Active then
      Close;
end;

function TFrmImportPO.Start(IDVendor, IDStore, IDPurchase:Integer;
  TaxInCost:Boolean; var PayDays, IDPO : Integer):Boolean;
var
  gsoOptions: TcxGridStorageOptions;
  sSaveViewName : String;
begin

   gsoOptions := [gsoUseFilter, gsoUseSummary];
   sSaveViewName := MR_BRW_REG_PATH + Self.Caption;

   DM.LoadGridFromRegistry(TcxGridDBTableView(grdPreSaleItemDB), sSaveViewName, gsoOptions);

   bUseMarkupOnCost  := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];
   bAutoRound        := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];
   bAutoCalcMargin   := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
   bDelLeftPOItem    := DM.fSystem.SrvParam[PARAM_REMOVE_REMINDED_PO];
   lbDelItem.Visible := bDelLeftPOItem;

   fIDVendor   := IDVendor;
   fIDStore    := IDStore;
   fIDPurchase := IDPurchase;
   fTaxInCost  := TaxInCost;
   bUseMarkup  := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];

   bAfterShow := False;

   OpenPO;

   if quPo.RecordCount = 1 then
   begin
     RefreshPOItem;
     SetNewSalesPrices;
   end;

   bAfterShow := True;

   if ((not bAutoCalcMargin) and (fTaxInCost and bUseMarkup)) then
     pnlOption.Visible := True;

   Result := (ShowModal=mrOK);

   PayDays := fPayDays;
   IDPO    := fIDPO;

   DM.SaveGridToRegistry(TcxGridDBTableView(grdPreSaleItemDB), sSaveViewName, True, gsoOptions);

end;

procedure TFrmImportPO.SetNewSalesPrices;
var
  NewSalePrice, cCostPrice: Currency;
  saveManualPrice: Currency;
  NewSuggRetail: Currency;
begin

  if bAutoCalcMargin or bAutoRound then
    with cdsPOItem do
    begin
      DisableControls;
      First;

      while not cdsPOItem.Eof do
      begin
        cCostPrice    := DM.FDMCalcPrice.FormatPrice(FieldByName('CostPrice').AsCurrency);
        NewSalePrice  := FieldByName('SalePrice').AsCurrency;
        saveManualPrice := newSalePrice;

        NewSuggRetail := cdsPOItem.FieldByName('NewSuggRetail').Value;

        if FieldByName('ModelMarkup').AsFloat <> 0 then
        begin
          if bUseMarkupOnCost then
            NewSalePrice  := DM.FDMCalcPrice.GetMarkupPrice(cCostPrice, FieldByName('ModelMarkup').AsFloat)
          else if (FieldByName('ModelMarkup').AsFloat < 100) then begin
            NewSalePrice := DM.FDMCalcPrice.GetMarginPrice(cCostPrice, FieldByName('ModelMarkup').AsFloat);

            if ( dm.FDMCalcPrice.IncreasePriceOnly ) then begin
               if ( NewSalePrice < SaveManualPrice ) then begin
                  NewSalePrice := SaveManualPrice;
               end;
            end;

          end;

          if bAutoRound then
            NewSalePrice := DM.FDMCalcPrice.CalcRounding(FieldByName('GroupID').AsInteger, NewSalePrice);

        end
        else
        begin
          NewSalePrice  := DM.FDMCalcPrice.CalcSalePrice(FieldByName('IDModel').AsInteger,
                                                       FieldByName('GroupID').AsInteger,
                                                       FieldByName('IDModelGroup').AsInteger,
                                                       FieldByName('IDModelSubGroup').AsInteger,
                                                       cCostPrice);

        end;
        NewSuggRetail := DM.FDMCalcPrice.CalcMSRPPrice(FieldByName('GroupID').AsInteger,
                                                      FieldByName('IDModelGroup').AsInteger,
                                                      FieldByName('IDModelSubGroup').AsInteger,
                                                      cCostPrice);


        //amfsouza 06.06.2011 - verify IncreaseOnly parameter again
        if ( dm.FDMCalcPrice.IncreasePriceOnly ) then begin
           if ( NewSalePrice < SaveManualPrice ) then begin
              NewSalePrice := SaveManualPrice;
           end;
        end;

        //amfsouza 03.23.2011 - keep sale price if updatePrice ("Adjust Manually") = 1
        if ( fieldByName('UpdatePrice').Value ) then
           newSalePrice := saveManualPrice;

        cdsPOItem.Edit;

        if (NewSalePrice <> 0 ) and (NewSalePrice <> cCostPrice) then
           FieldByName('NewSalePrice').AsCurrency := NewSalePrice;

        if (NewSuggRetail <> cCostPrice) then
          FieldByName('NewSuggRetail').AsCurrency := NewSuggRetail;

        if bUseMarkupOnCost and (NewSalePrice > 0) and (cCostPrice <> 0) Then
          FieldByName('Markup').AsCurrency := CalcMarkupPercent(cCostPrice, NewSalePrice);

        if FieldByName('NewSalePrice').AsCurrency =  0 then
          FieldByName('NewSalePrice').AsCurrency := FieldByName('CurrentSale').AsCurrency;

        if FieldByName('NewSuggRetail').AsCurrency =  0 then
          FieldByName('NewSuggRetail').AsCurrency := FieldByName('CurrentSuggRetail').AsCurrency;

        if State in [dsEdit, dsInsert] then
          cdsPOItem.Post;

        Next;
      end;

      EnableControls;
    end;
end;

procedure TFrmImportPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ClosePO;
  Action := caFree;
end;

procedure TFrmImportPO.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmImportPO.quPOCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPOTotal.AsCurrency := quPOSubTotal.AsCurrency +
                          quPOFreight.AsCurrency +
                          quPOCharges.AsCurrency;
end;

procedure TFrmImportPO.btnSaveClick(Sender: TObject);
begin
  inherited;
  SavePurchase;
end;

procedure TFrmImportPO.InsertVendorTax;
var
  NewCostPrice, FMVA : Currency;
begin
  NewCostPrice  := DM.FDMCalcPrice.FormatPrice(cdsPOItem.FieldByName('CostPrice').AsCurrency);

  DMCalcTax.CreateTax(quPOIDFornecedor.AsInteger,
                      fIDPurchase,
                      fIDPurchaseItem);

  if (not pnlOption.Visible) or (pnlOption.Visible and chkCalcTax.Checked) then
  begin
    if cdsPOItemIncide.AsBoolean then
    begin
      if DM.fStore.State = Trim(quPOIDEstado.AsString) then
        FMVA := cdsPOItemMVAInterno.AsCurrency
      else
        FMVA := cdsPOItemMVAInterestadual.AsCurrency;
    end
    else
      FMVA := 0;


    DMCalcTax.CalculateTax(fIDPurchaseItem,
                           cdsPOItem.FieldByName('CostPrice').AsCurrency,
                           0,
                           0,
                           FMVA,
                           0,
                           cdsPOItem.FieldByName('QtyTotal').AsFloat);

    NewCostPrice := NewCostPrice + DMCalcTax.GetTaxesValueTotal(fIDPurchaseItem);
  end;

  with cmdUpdateTaxCost do
  begin
    Parameters.ParamByName('NewCostPrice').Value   := NewCostPrice;

    if (pnlOption.Visible and (chkUpdateSalePrice.Checked)) then
    begin
      Parameters.ParamByName('NewSalePrice').Value  := cdsPOItem.FieldByName('NewSalePrice').AsCurrency;
      Parameters.ParamByName('NewSuggRetail').Value := cdsPOItem.FieldByName('NewSuggRetail').AsCurrency;
    end
    else
    begin
      Parameters.ParamByName('NewSalePrice').Value  := NULL;
      Parameters.ParamByName('NewSuggRetail').Value := NULL;
    end;

    Parameters.ParamByName('IDPurchaseItem').Value := fIDPurchaseItem;
    Execute;
  end;
end;

procedure TFrmImportPO.CheckAll(Value: Boolean);
begin
  with cdsPOItem do
  begin
    First;
    while not Eof DO
     begin
       Edit;
       FieldByName('Marked').Value := Value;
       Post;
       Next;
     end;
  end;
end;

procedure TFrmImportPO.btMarkedClick(Sender: TObject);
begin
  CheckAll(True);
end;

procedure TFrmImportPO.btUnMarkedClick(Sender: TObject);
begin
  CheckAll(False);
end;

procedure TFrmImportPO.cdsPOItemBeforePost(DataSet: TDataSet);
begin
  inherited;
  if grdPreSaleItemDBQty.Focused then
    with cdsPOItem do
      FieldByName('Marked').AsBoolean := (FieldByName('QtyTotal').AsFloat > 0);
end;

procedure TFrmImportPO.cdsPOItemCostPriceChange(Sender: TField);
var
  NewSalePrice, NewSuggRetail, cCostPrice: Currency;
begin
  inherited;

  cCostPrice    := DM.FDMCalcPrice.FormatPrice(cdsPOItem.FieldByName('CostPrice').AsCurrency);
  NewSalePrice  := cdsPOItem.FieldByName('SalePrice').AsCurrency;
  NewSuggRetail := cdsPOItem.FieldByName('SuggRetail').AsCurrency;


  if cdsPOItem.FieldByName('ModelMarkup').AsFloat <> 0 then
  begin
    if bUseMarkupOnCost then
      NewSalePrice  := DM.FDMCalcPrice.GetMarkupPrice(cCostPrice, cdsPOItem.FieldByName('ModelMarkup').AsFloat)
    else if (cdsPOItem.FieldByName('ModelMarkup').AsFloat < 100) then
      NewSalePrice := DM.FDMCalcPrice.GetMarginPrice(cCostPrice, cdsPOItem.FieldByName('ModelMarkup').AsFloat);

    if bAutoRound then
      NewSalePrice := DM.FDMCalcPrice.CalcRounding(cdsPOItem.FieldByName('GroupID').AsInteger, NewSalePrice);
  end
  else
  begin
    NewSalePrice := DM.FDMCalcPrice.CalcSalePrice(cdsPOItem.FieldByName('IDModel').AsInteger,
                                                  cdsPOItem.FieldByName('GroupID').AsInteger,
                                                  cdsPOItem.FieldByName('IDModelGroup').AsInteger,
                                                  cdsPOItem.FieldByName('IDModelSubGroup').AsInteger,
                                                  cCostPrice);

  end;

  NewSuggRetail := DM.FDMCalcPrice.CalcMSRPPrice(cdsPOItem.FieldByName('GroupID').AsInteger,
                                                 cdsPOItem.FieldByName('IDModelGroup').AsInteger,
                                                 cdsPOItem.FieldByName('IDModelSubGroup').AsInteger,
                                                 cCostPrice);

  if (NewSalePrice <> 0 ) and (NewSalePrice <> cCostPrice) then
    cdsPOItem.FieldByName('NewSalePrice').AsCurrency := NewSalePrice;

  if (NewSuggRetail <> 0) and (NewSuggRetail <> cCostPrice) then
    cdsPOItem.FieldByName('NewSuggRetail').AsCurrency := NewSuggRetail;

  if (cdsPOItem.FieldByName('ModelCaseQty').AsCurrency > 1) and (not bUpdateItem) then
  begin
    bUpdateCase := True;

    cdsPOItem.FieldByName('CaseCost').AsCurrency := MyRound(cdsPOItem.FieldByName('ModelCaseQty').AsCurrency * cdsPOItem.FieldByName('CostPrice').AsCurrency, 2);
    bUpdateCase := False;

    cdsPOItem.FieldByName('ExtCaseCost').AsCurrency := (cdsPOItem.FieldByName('ModelCaseQty').AsCurrency *
                                                        cdsPOItem.FieldByName('CostPrice').AsCurrency *
                                                        cdsPOItem.FieldByName('CaseQty').AsFloat);
  end;

end;

procedure TFrmImportPO.FormCreate(Sender: TObject);
begin
  inherited;
  DMCalcTax := TDMCalcTax.Create(Self);
  DMCalcTax.ADODBConnect := DM.ADODBConnect;
  DM.imgBTN.GetBitmap(BTN_COLUMN, btPOColumn.Glyph);
end;

procedure TFrmImportPO.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(DMCalcTax);
end;

procedure TFrmImportPO.ConfigColumns(AView: TcxCustomGridTableView);
begin
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmImportPO.btPOColumnClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdPreSaleItemDB);
end;

function TFrmImportPO.CalcMarkupPercent(Cost, Sale: Currency): Currency;
begin
  Result := ((Sale - Cost) / Cost) * 100;
end;

procedure TFrmImportPO.cdsPOItemNewSalePriceChange(Sender: TField);
begin
  inherited;
  if (cdsPOItem.FieldByName('CostPrice').AsCurrency <> 0) and (cdsPOItem.FieldByName('NewSalePrice').AsCurrency <> 0) then
    cdsPOItem.FieldByName('Markup').AsCurrency := CalcMarkupPercent(DM.FDMCalcPrice.FormatPrice(cdsPOItem.FieldByName('CostPrice').AsCurrency), cdsPOItem.FieldByName('NewSalePrice').AsCurrency);
end;

procedure TFrmImportPO.btnApplyClick(Sender: TObject);
var
  fMarkUp : Currency;
begin
  inherited;

  fMarkUp := StrToCurrDef(edtMarkup.Text, 0);

  if (not bUseMarkupOnCost) and (fMarkUp >= 100) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbCritical + vbOKOnly);
    Exit;
  end;

  if (Trim(edtMarkup.Text) <> '') and (fMarkUp <> 0) then
  with cdsPOItem do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('CostPrice').AsCurrency <> 0 then
      begin
        Edit;

        if bUseMarkupOnCost then
          FieldByName('NewSalePrice').AsCurrency := DM.FDMCalcPrice.GetMarkupPrice(DM.FDMCalcPrice.FormatPrice(FieldByName('CostPrice').AsCurrency), fMarkUp)
        else if (fMarkUp < 100) then
          FieldByName('NewSalePrice').AsCurrency := DM.FDMCalcPrice.GetMarginPrice(DM.FDMCalcPrice.FormatPrice(FieldByName('CostPrice').AsCurrency), fMarkUp);


        if bAutoRound then
          FieldByName('NewSalePrice').AsCurrency := DM.FDMCalcPrice.CalcRounding(FieldByName('GroupID').AsInteger, FieldByName('NewSalePrice').AsCurrency);

        Post;
      end;
      Next;
    end;
    EnableControls;
  end;

end;

procedure TFrmImportPO.edtMarkupKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmImportPO.grdPreSaleItemDBTotalPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  try
    if DisplayValue <> 0 then
      StrToCurr(DisplayValue);
  except
    MsgBox(MSG_CRT_INVALID_AMOUNT, vbOKOnly + vbExclamation);
    DisplayValue := 0;
    end;

end;

procedure TFrmImportPO.cdsPOItemCaseCostChange(Sender: TField);
begin
  inherited;

  if (not bUpdateCase) and (cdsPOItem.FieldByName('ModelCaseQty').AsCurrency > 1) then
  begin
    bUpdateItem := True;
    cdsPOItem.FieldByName('CostPrice').AsCurrency := MyRound(cdsPOItem.FieldByName('CaseCost').AsCurrency / cdsPOItem.FieldByName('ModelCaseQty').AsCurrency, 2);
    bUpdateItem := False;

    cdsPOItem.FieldByName('ExtCaseCost').AsCurrency := (cdsPOItem.FieldByName('ModelCaseQty').AsCurrency *
                                                        cdsPOItem.FieldByName('CostPrice').AsCurrency *
                                                        cdsPOItem.FieldByName('CaseQty').AsFloat);
  end;

end;

procedure TFrmImportPO.cdsPOItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btMarked.Enabled   := (cdsPOItem.Active and (not(cdsPOItem.IsEmpty)));
  btUnMarked.Enabled := btMarked.Enabled;
  btnApply.Enabled   := btMarked.Enabled;
  btnSave.Enabled    := btMarked.Enabled;
end;

procedure TFrmImportPO.grdPODBCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  if bAfterShow then
  begin
    RefreshPOItem;
    SetNewSalesPrices;
  end;

end;


procedure TFrmImportPO.spHelpClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      OpenURL('http://www.mainretail.com.br/treinamento/Compras/Com_ImporandoOC.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

procedure TFrmImportPO.btnVideoClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Importando_uma_OC/Importando_uma_Ordem_de_Compras.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

end.
