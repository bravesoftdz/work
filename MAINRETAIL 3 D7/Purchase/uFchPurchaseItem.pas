unit uFchPurchaseItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichasBrowse, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBCtrls, Grids, DBGrids, ADODB, StdCtrls,
  Buttons, Mask, SuperComboADO, FormConfig, PowerADOQuery, siComp,
  siLangRT, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, LblEffct, ExtCtrls, SMDBGrid, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu,
  cxGridPopupMenu, CalcExpress, uFrmBarcodeSearch, uInventoryCalc,
  mrBarCodeEdit, uDMCalcTax, SuperEdit;

type
  TFchPurchaseItem = class(TbrwFrmParentBrw)
    tsItem: TTabSheet;
    Panel5: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    quHistory: TADOQuery;
    quHistoryIDInventoryMov: TIntegerField;
    quHistoryIDPessoa: TIntegerField;
    quHistoryVendor: TStringField;
    quHistoryMovDate: TDateTimeField;
    quHistoryCostPrice: TFloatField;
    quHistoryFreight: TFloatField;
    quHistoryOtherCost: TFloatField;
    dsHistory: TDataSource;
    dsPO: TDataSource;
    quPO: TADOQuery;
    quPOIDPreInventoryMov: TIntegerField;
    quPOModelID: TIntegerField;
    quPOMovDate: TDateTimeField;
    quPOCostPrice: TFloatField;
    quPOSalePrice: TFloatField;
    quPOIDPessoa: TIntegerField;
    quPODateEstimatedMov: TDateTimeField;
    quPOSuggRetail: TFloatField;
    quPOIDPO: TIntegerField;
    quModel: TADOQuery;
    quModelSellingPrice: TFloatField;
    quModelDescription: TStringField;
    quModelVendorCost: TFloatField;
    quModelSuggRetail: TFloatField;
    quModelGroupID: TIntegerField;
    quModelCategory: TStringField;
    quModelIDModel: TAutoIncField;
    quModelIDSize: TIntegerField;
    quModelIDColor: TIntegerField;
    quModelIDFabricante: TIntegerField;
    dsModel: TDataSource;
    quPurBarcode: TADOQuery;
    grdHistory: TSMDBGrid;
    quBrowseIDPurchaseItemSerial: TIntegerField;
    quBrowseIDPurchaseItem: TIntegerField;
    quBrowseSerialNumber: TStringField;
    quFormIDPurchaseItem: TIntegerField;
    quFormIDPurchase: TIntegerField;
    quFormIDModel: TIntegerField;
    quFormBarCode: TStringField;
    quFormIDGroup: TIntegerField;
    quFormNewCostPrice: TBCDField;
    quFormNewSalePrice: TBCDField;
    quFormNewSuggRetail: TBCDField;
    quFormIDFornecedor: TIntegerField;
    quFormIDPOItem: TIntegerField;
    quItemTax: TADOQuery;
    dsItemTax: TDataSource;
    quItemTaxIDPurchaseItemTax: TIntegerField;
    quItemTaxTaxValue: TBCDField;
    quItemTaxTaxPercentage: TBCDField;
    quItemTaxTaxCategory: TStringField;
    quFormCostPrice: TBCDField;
    pgPrices: TPageControl;
    tsQty: TTabSheet;
    tsCostTaxes: TTabSheet;
    pnlPOItem: TPanel;
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label29: TLabel;
    DBEdit6: TDBText;
    DBEdit7: TDBText;
    DBEdit8: TDBText;
    DBEdit9: TDBText;
    DBText1: TDBText;
    pnlNavigatorPo: TPanel;
    sbPrior: TSpeedButton;
    sbNext: TSpeedButton;
    Panel7: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    DBText2: TDBText;
    DBEdit13: TDBText;
    DBEdit12: TDBText;
    DBEdit11: TDBText;
    DBEdit10: TDBText;
    pnlPurchaseItem: TPanel;
    tsInfo: TTabSheet;
    pnlItemTax: TPanel;
    Panel9: TPanel;
    lbPOInfo: TLabel;
    lbPOQty: TLabel;
    lbPOCost: TLabel;
    lbPOOurPrice: TLabel;
    lbPOMSRP: TLabel;
    lbPONum: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    pnlNav1: TPanel;
    sbPrior1: TSpeedButton;
    sbNext1: TSpeedButton;
    Panel11: TPanel;
    lbInvInfo: TLabel;
    lbInvQty: TLabel;
    lbInvCost: TLabel;
    lbInvOurPrice: TLabel;
    lbInvMSRP: TLabel;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    quItemTaxDebit: TBooleanField;
    quFormFreightCost: TBCDField;
    quFormOtherCost: TBCDField;
    Panel12: TPanel;
    lbFinalPrices: TLabel;
    lbNewCost: TLabel;
    Label54: TLabel;
    DBEdit2: TDBEdit;
    Panel13: TPanel;
    lbTax: TLabel;
    grdSpecialPrice: TSMDBGrid;
    btnRemovTax: TSpeedButton;
    Bevel1: TBevel;
    chkInCost: TCheckBox;
    quItemTaxFormula: TStringField;
    btnUpdate: TBitBtn;
    Bevel2: TBevel;
    btnCalcNewCost: TBitBtn;
    tsReturn: TTabSheet;
    Panel10: TPanel;
    lbCostRet: TLabel;
    lbFreteRet: TLabel;
    lbOtherRet: TLabel;
    Label33: TLabel;
    lbQtyPriceRet: TLabel;
    lbQtyRet: TLabel;
    Label37: TLabel;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    Panel14: TPanel;
    lbTaxRet: TLabel;
    Bevel4: TBevel;
    sbGridItemTaxRet: TSMDBGrid;
    btnUpdateRet: TBitBtn;
    Panel15: TPanel;
    lbFinalPriceRet: TLabel;
    lbNewDevCost: TLabel;
    Label45: TLabel;
    DBEdit23: TDBEdit;
    btnCalcNewCostRet: TBitBtn;
    quItemTaxRet: TADOQuery;
    dsItemTaxRet: TDataSource;
    quItemTaxRetIDPurchaseItemTaxRet: TIntegerField;
    quItemTaxRetTaxValue: TBCDField;
    quItemTaxRetTaxPercentage: TBCDField;
    quItemTaxRetTaxCategory: TStringField;
    quItemTaxRetDebit: TBooleanField;
    quItemTaxRetFormula: TStringField;
    quFormCostPriceRet: TBCDField;
    quFormFreightCostRet: TBCDField;
    quFormOtherCostRet: TBCDField;
    quFormNewCostPriceRet: TBCDField;
    btnReturnItem: TSpeedButton;
    quVendorCode: TADOQuery;
    quVendorCodeIDVendorModelCode: TIntegerField;
    quVendorCodeIDPessoa: TIntegerField;
    quVendorCodeIDModel: TIntegerField;
    quVendorCodeVendorCode: TStringField;
    quFormQty: TFloatField;
    quFormQtyRet: TFloatField;
    quPOQty: TFloatField;
    quModelTotQtyOnHand: TFloatField;
    pnlQtyType: TPanel;
    lblQtyType: TLabel;
    cbxQtyType: TComboBox;
    pnlQty: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtQty: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    pnlCaseQty: TPanel;
    lbCCaseQty: TLabel;
    lbCUnitCost: TLabel;
    lbCNewPrice: TLabel;
    lbCNewMSRP: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    lbCCaseCost: TLabel;
    DBEdit28: TDBEdit;
    Label42: TLabel;
    lbCQty: TLabel;
    edtCaseQtyUS: TDBEdit;
    Label44: TLabel;
    quModelCaseQty: TFloatField;
    Label2: TLabel;
    quFormCaseQty: TFloatField;
    quFormCaseCost: TBCDField;
    lbQtyPrice: TLabel;
    pnlCastTypeTax: TPanel;
    lblTQtyType: TLabel;
    cbxTypeCostTax: TComboBox;
    pnlQtyCostTax: TPanel;
    lbOther: TLabel;
    edtOther: TDBEdit;
    lbFreight: TLabel;
    edtFreight: TDBEdit;
    lbCost: TLabel;
    edtCostTotalCost: TDBEdit;
    Label53: TLabel;
    Label35: TLabel;
    edtCostQty: TDBEdit;
    lbQty: TLabel;
    pnlCaseQtyCostTax: TPanel;
    lbTCaseQty: TLabel;
    lbTCaseCost: TLabel;
    Label46: TLabel;
    lbTQty: TLabel;
    Label48: TLabel;
    DBEdit30: TDBEdit;
    edtCaseCost: TDBEdit;
    edtCaseQty: TDBEdit;
    pnlMarginSale: TPanel;
    lbMSRP: TLabel;
    DBEdit16: TDBEdit;
    lbOurPrice: TLabel;
    DBEdit15: TDBEdit;
    quBarcode: TADOQuery;
    quBarcodeIDBarCode: TStringField;
    quBarcodeIDModel: TIntegerField;
    cbxDisplayPercent: TCheckBox;
    edtFreightPer: TEdit;
    edtOtherPerc: TEdit;
    lbNewMarkup: TLabel;
    edtMarkup: TStaticText;
    lbInvNewCost: TLabel;
    DBText13: TDBText;
    Bevel3: TBevel;
    quFormIDModelGroup: TIntegerField;
    quFormIDModelSubGroup: TIntegerField;
    pnlBarcode: TPanel;
    cbxAutoCreate: TCheckBox;
    edtBarCode: TmrBarCodeEdit;
    edtVendorCode: TEdit;
    lbVCode: TLabel;
    Label3: TLabel;
    btnSerialNumb: TBitBtn;
    pnlModelCat: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    scModel: TDBSuperComboADO;
    scCategory: TDBSuperComboADO;
    btnSearchDesc: TBitBtn;
    lbCaseBarcode: TLabel;
    edtCaseBarcode: TmrBarCodeEdit;
    quFormBarcodeCase: TStringField;
    quModelMarkup: TBCDField;
    quModelUseScale: TBooleanField;
    quFormIDLote: TIntegerField;
    quModelUseLot: TBooleanField;
    lbLot: TLabel;
    scLot: TDBSuperComboADO;
    lbUnitCost: TLabel;
    edtUnitCost: TSuperEdit;
    lbUnitCost1: TLabel;
    edtUnitCost1: TSuperEdit;
    quModelMVAInterno: TBCDField;
    quModelMVAInterestadual: TBCDField;
    quModelIncide: TBooleanField;
    pnlMVA: TPanel;
    lbMVA: TLabel;
    rbMVAIn: TRadioButton;
    rbMVAOut: TRadioButton;
    quFormDiscount: TBCDField;
    quFormDiscountRet: TBCDField;
    lbItemDiscount: TLabel;
    edtDiscount: TDBEdit;
    lbDiscountRet: TLabel;
    DBEdit1: TDBEdit;
    quModelUpdatePrice: TBooleanField;
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure scModelSelectItem(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quPOAfterOpen(DataSet: TDataSet);
    procedure sbNextClick(Sender: TObject);
    procedure sbPriorClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnSerialNumbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRemovTaxClick(Sender: TObject);
    procedure dsItemTaxStateChange(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCalcNewCostClick(Sender: TObject);
    procedure quItemTaxAfterEdit(DataSet: TDataSet);
    procedure btnCalcNewCostRetClick(Sender: TObject);
    procedure btnReturnItemClick(Sender: TObject);
    procedure btnUpdateRetClick(Sender: TObject);
    procedure edtVendorCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtVendorCodeEnter(Sender: TObject);
    procedure edtVendorCodeExit(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure cbxQtyTypeSelect(Sender: TObject);
    procedure edtCaseQtyUSExit(Sender: TObject);
    procedure DBEdit28Exit(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure edtCaseCostExit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure edtBarCodeEnter(Sender: TObject);
    procedure edtBarCodeExit(Sender: TObject);
    procedure edtBarCodeAfterSearchBarcode(Sender: TObject);
    procedure cbxDisplayPercentClick(Sender: TObject);
    procedure edtFreightPerKeyPress(Sender: TObject; var Key: Char);
    procedure edtFreightPerExit(Sender: TObject);
    procedure edtOtherPercExit(Sender: TObject);
    procedure edtCostTotalCostExit(Sender: TObject);
    procedure pgPricesChange(Sender: TObject);
    procedure cbxAutoCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFreightExit(Sender: TObject);
    procedure edtOtherExit(Sender: TObject);
    procedure DBEdit16Exit(Sender: TObject);
    procedure DBEdit15Exit(Sender: TObject);
    procedure edtCaseBarcodeAfterSearchBarcode(Sender: TObject);
    procedure edtCaseBarcodeExit(Sender: TObject);
    procedure scLotEnter(Sender: TObject);
    procedure quFormQtyChange(Sender: TField);
    procedure quFormCostPriceChange(Sender: TField);
    procedure scModelChange(Sender: TObject);
  private
    toClear: Boolean;
    //Barcode auto create
    fIDModel,
    fIDManufacture,
    fIDSize,
    fIDColor : Integer;
    fTaxCalcTax : Boolean;
    fModelCaseQty : Double;
    fModelMarkup : Currency;
    bUseMarkupOnCost : Boolean;
    bControlLot : Boolean;
    bUseScale : Boolean;
    bUseLot : Boolean;
    bAutoCalcMargin, bAutoRound : Boolean;
    bIsHistory,
    bPastMonth : Boolean;
    FMVA : Currency;
    FVendorState : String;

    fFrmBarcodeSearch : TFrmBarcodeSearch;

    DMCalcTax : TDMCalcTax;

    procedure ModelSet;
    procedure SetAutoBarcode;
    procedure UpdateIDPOItem;

    procedure ItemTaxOpen;
    procedure ItemTaxClose;
    procedure ItemTaxRefresh;
    procedure ItemTaxPost;

    procedure InsertVendorTaxRet;

    procedure ItemTaxRetClose;
    procedure ItemTaxRetRefresh;
    procedure ItemTaxRetOpen;
    procedure ItemTaxRetPost;

    procedure RefreshQtyControls;

    function SelectPurchaseBarcode(IDBarcode:String):Boolean;
    function SelectInventoryBarcode(var IDModel:Integer; IDBarcode:String):Boolean;

    function SaveVendorModelCode:Boolean;

    procedure RefreshPercent;
    procedure CalcFreight;
    procedure CalcOtherCost;
    function ExistsBarcode(Barcode :String): Boolean;
    procedure StartScreen;
    function VerifyItemReceived(IDPOItem: Integer):Boolean;

    function BarcodeExistsInPurchase(ABarcode: String):Boolean;

    procedure SetFocusQty;
    procedure RefreshUnitCost;

    procedure UpdateMVA;
  protected
    procedure NextAppend; override;
    function OnValidadeField: boolean; override;
    procedure OnBeforeStart; override;
    function OnAfterSaveChange(var iError:Integer):Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uFrmSerialNumber, uDM, uFchPurchaseItemNewBarCode, uMsgBox,
     uMsgConstant, uDMGlobal, uSystemTypes, uSystemConst, uNumericFunctions,
     PaiDeFichas, uCharFunctions, uDMCalcPrice, uFchPurchase, uParamFunctions;


procedure TFchPurchaseItem.SetAutoBarcode;
var
  MyModel   : Integer;
  MyBarcode : String;
begin

  //Create Default barcode
  if (cbxAutoCreate.Checked) and (frmCommand = btInc) and (Trim(edtBarCode.Text) = '') then
     begin

     (*
     if bUseScale then
     begin
       if (DM.fCashRegister.ScaleCheck) and ((DM.fCashRegister.ScaleType = 0) or (DM.fCashRegister.ScaleType = 1)) then
         MyBarcode := '2' + Copy(FormatDateTime('m', Now), 1, 1) +FormatDateTime('nnss', Now);
     end
     else
       MyBarcode := IntToStr(fIDModel) +
                    IntToStr(fIDManufacture) +
                    IntToStr(fIDSize) +
                    IntToStr(fIDColor);
      *)

     if ( trim(scModel.Text) = '' ) then begin
        if ( cbxAutoCreate.Checked ) then
           Application.MessageBox('Same as model is selected so, model must not be blank.', 'Model Error', mb_OK + mb_IconError);
           scModel.SetFocus;
           exit;
     end;

     myBarcode := scModel.Text;

     // Pesquisa pelo Barcode na Purchase
     if SelectPurchaseBarcode(MyBarcode) or SelectInventoryBarcode(MyModel, MyBarcode) then
        MyBarcode := '';

     if ( cbxAutoCreate.Checked ) then
        edtBarCode.Text := myBarcode;

     quForm.Edit;
     quFormBarCode.Value := MyBarcode;

     end;

end;

procedure TFchPurchaseItem.ModelSet;
var
   auxIdModelParam: Integer;
begin
  if quFormIDModel.AsString <> '' then begin
    if not(DM.ModelRestored(quFormIDModel.AsInteger)) then
      begin
        edtBarcode.Text := '';
        scModel.LookUpValue := '';
        edtCaseBarcode.Text := '';
        exit;
      end;

    // amfsouza 11.24.2011
    if ( toClear ) then
       auxIdModelParam := -1
    else
       auxIdModelParam := quFormIDModel.Value;

    with quModel do
    begin
      Close;
      Parameters.ParambyName('IDModel').Value := auxIdModelParam; //quFormIDModel.Value;
      Parameters.ParambyName('IDPessoa').Value := quFormIDFornecedor.Value;
      Open;

      fIDModel        := quModelIDModel.AsInteger;
      fIDManufacture  := quModelIDFabricante.AsInteger;
      fIDSize         := quModelIDSize.AsInteger;
      fIDColor        := quModelIDColor.AsInteger;
      fModelCaseQty   := quModelCaseQty.AsFloat;
      fModelMarkup    := quModelMarkup.AsCurrency;
      bUseScale       := quModelUseScale.AsBoolean;
      bUseLot         := quModelUseLot.AsBoolean;

      if quModelIncide.AsBoolean then
      begin
        pnlMVA.Visible := True;
        rbMVAIn.Caption := FormatFloat('0.00', quModelMVAInterno.AsCurrency);
        rbMVAOut.Caption := FormatFloat('0.00', quModelMVAInterestadual.AsCurrency);
        if DM.fStore.State = FVendorState then
          rbMVAIn.Checked := True
        else
          rbMVAOut.Checked := True;
        UpdateMVA;
      end
      else
      begin
        pnlMVA.Visible := False;
        FMVA := 0;
      end;

      RefreshQtyControls;

      if (pgPrices.Visible and (frmCommand = btInc))then
      begin
        if not (dsForm.State in dsEditModes) then
          quForm.Edit;
        quForm.FieldByName('NewCostPrice').Value  := FieldByName('VendorCost').Value;
        if (pnlMarginSale.Visible) or (pgPrices.ActivePage = tsQty) then
        begin
          quForm.FieldByName('NewSalePrice').Value  := FieldByName('SellingPrice').Value;
          quForm.FieldByName('NewSuggRetail').Value := FieldByName('SuggRetail').Value;
        end;
      end;

      (*
      //amfsouza 04.28.2011: NewSalePrice must to be the same in Inventory to model.
      else if ( pgPrices.Visible and (frmCommand = btAlt) )then begin
          if ( FieldByName('')
          if not (dsForm.State in dsEditModes) then
             quForm.Edit;

          quForm.FieldByName('NewSalePrice').Value  := FieldByName('SellingPrice').Value;
          quForm.FieldByName('NewSuggRetail').Value := FieldByName('SuggRetail').Value;
      end;
      *)

      if (quFormIDGroup.AsString = '') or (quFormIDGroup.Value <> quModelGroupID.Value) then
      begin
        if not (dsForm.State in dsEditModes) then
          quForm.Edit;
        quFormIDGroup.Value := quModelGroupID.Value;
      end;
    end;

    with quHistory do
    begin
      Close;
      Parameters.ParambyName('IDModel').Value := auxIdModelParam;//quFormIDModel.Value;
      Open;
    end;

    if VerifyItemReceived(quFormIDPOItem.AsInteger) then
    begin
      if quFormIDFornecedor.AsString <> '' then
      with quPO do
      begin
        Close;

        SQL.Text := 'SELECT ' +
                    ' PIM.IDPreInventoryMov, ' +
                    ' PIM.ModelID, ' +
                    ' PIM.MovDate, ' +
                    ' (PIM.Qty - PIM.QtyRealMov) as Qty, ' +
                    ' PIM.CostPrice, ' +
                    ' PIM.SalePrice, ' +
                    ' PIM.IDPessoa, ' +
                    ' PIM.DateEstimatedMov, ' +
                    ' PIM.SuggRetail, ' +
                    ' PIM.DocumentID as IDPO ' +
                    'FROM ' +
                    ' PreInventoryMov PIM ' +
                    'WHERE ' +
                    ' PIM.IDPessoa = ' + InttoStr(quFormIDFornecedor.Value) +
                    ' AND ' +
                    ' PIM.ModelID = ' + InttoStr(auxIdModelParam) + //+ InttoStr(quFormIDModel.Value) +
                    ' AND ' +
                    ' PIM.IDPreInventoryMov = ' + InttoStr(quFormIDPOItem.Value) +
                    ' ORDER BY ' +
                    ' PIM.MovDate ';
        Open;
      end;
    end
    else
    begin
      if quFormIDFornecedor.AsString <> '' then
      with quPO do
      begin
        Close;
        SQL.Text := 'SELECT TOP 10 ' +
                    ' PIM.IDPreInventoryMov, ' +
                    ' PIM.ModelID, ' +
                    ' PIM.MovDate, ' +
                    ' (PIM.Qty - PIM.QtyRealMov) as Qty, ' +
                    ' PIM.CostPrice, ' +
                    ' PIM.SalePrice, ' +
                    ' PIM.IDPessoa, ' +
                    ' PIM.DateEstimatedMov, ' +
                    ' PIM.SuggRetail, ' +
                    ' PIM.DocumentID as IDPO ' +
                    'FROM ' +
                    ' PreInventoryMov PIM ' +
                    'WHERE ' +
                    ' PIM.IDPessoa = ' + InttoStr(quFormIDFornecedor.Value) +
                    ' AND ' +
                    ' PIM.ModelID  = ' + InttoStr(auxIdModelParam) + //+ InttoStr(quFormIDModel.Value) +
                    ' AND ' +
                    ' PIM.Qty > PIM.QtyRealMov ' +
                    ' ORDER BY ' +
                    ' PIM.MovDate ';
        Open;
        if (RecordCount > 0) and (quFormIDPOItem.AsInteger <> 0) then
          Locate('IDPreInventoryMov', quFormIDPOItem.AsString, []);
      end;
    end;

    // amfsouza 11.25.2011 - SetAutoBarcode;
  end;

  if bUseLot and (scModel.LookUpValue <> '') then
  begin
    scLot.SpcWhereClause := 'IDModel = ' + scModel.LookUpValue;
    scLot.Visible := True;
    lbLot.Visible := True;
  end
  else
  begin
    DM.FFchParam  := '';
    scLot.Visible := False;
    lbLot.Visible := False;
  end;

  //amfsouza 11.25.2011
  if ( quFormIDModel.AsString <> '' ) then
     SetAutoBarcode;

end;

function TFchPurchaseItem.VerifyItemReceived(IDPOItem: Integer):Boolean;
var
  quVerifyItemReceived : TADOQuery;
begin
  quVerifyItemReceived := TADOQuery.Create(self);

  with quVerifyItemReceived do
    try
      Connection := DM.ADODBConnect;
      SQL.Text := 'SELECT '+
                  ' IDPreInventoryMov '+
                  'FROM '+
                  ' PreInventoryMov '+
                  'WHERE  '+
                  ' Qty > QtyRealMov '+
                  ' AND '+
                  ' IDPreinventoryMov = ' + InttoStr(IDPOItem);
      Open;

      Result := IsEmpty;
    finally
      Close;
     end;
end;

procedure TFchPurchaseItem.UpdateIDPOItem;
begin
  if quPO.Active then
     if (quPOIDPreInventoryMov.AsInteger <> 0) then
       begin
       if ((frmCommand = btAlt) and (quFormIDPOItem.AsInteger <> quPOIDPreInventoryMov.AsInteger)) then
           quFormIDPOItem.AsInteger := quPOIDPreInventoryMov.AsInteger
       else if (frmCommand = btInc) then
           quFormIDPOItem.AsInteger := quPOIDPreInventoryMov.AsInteger;
       end;
end;

function TFchPurchaseItem.SelectPurchaseBarcode(IDBarcode:String):Boolean;
var
   msgWarning: String;
   qry: TADOQuery;
   sqlCmd: String;
begin

  Result := False;

  if IDBarcode <> '' then begin
    // Pesquisa pelo Barcode na Purchase
    with quPurBarcode do begin
      if Active then
         Close;
      Parameters.ParambyName('BarCode').Value := IDBarcode;
      Parameters.ParambyName('IDModel').Value := quFormIDModel.AsInteger;
      Parameters.ParambyName('IDPurchase').Value := quFormIDPurchase.AsInteger;
      Open;

      (* if they say yes, remove the barcode from the other model and then create the new item and assign it the barcode.*)

      if not IsEmpty then begin
         Result := True;

         msgWarning := 'Model ' + scModel.Text + ' will have the barcode ' + quPurBarcode.fieldByName('barcode').asString +
                       ' removed from it. Do you wish to continue ?';
         if (  application.MessageBox(Pchar(msgWarning), 'Barcode in Purchase', mb_YESNO + mb_IconWarning) = idYes ) then begin
            try
               qry := TADOQuery.Create(nil);
               qry.Connection := dm.ADODBConnect;
               try
                  // amfsouza 11.25.2011 - delete barcode
                  sqlCmd := 'delete from Barcode where IdBarcode =:barcode and IDModel =:idmodel';
                  qry.SQL.Text   := sqlCmd;
                  qry.Parameters.ParamByName('barcode').Value := idBarcode;
                  qry.Parameters.ParamByName('idmodel').Value := quFormIdModel.asInteger;
                  qry.ExecSQL;

                  // amfsouza 11.25.2011
                  sqlCmd := 'insert into Barcode values (:idbarcode, :idmodel, :date, :order, :qty)';
                  qry.sql.Text := sqlCmd;
                  qry.FieldByName('IdBarcode').Value := idBarcode;
                  qry.FieldByName('IdModel').Value   := quFormIdModel.asInteger;
                  qry.FieldByName('data').Value      := now();
                  qry.FieldByName('BarcodeOrder').Value := NULL;
                  qry.FieldByName('Qty').value          := NULL;
                  qry.ExecSQL;
                  edtBarCode.Text := IDBarcode;
               except

               end;
            finally
               freeAndNil(qry);
            end;
         end
         else begin
             edtBarcode.Clear;
             edtCaseBarcode.Clear;
             MsgBox(MSG_EXC_BARCODE_EXIST_PO, vbExclamation + vbOkOnly);
         end;

         Close;
      end;
    end;
  end;
end;

function TFchPurchaseItem.SelectInventoryBarcode(var IDModel:Integer;
                                                 IDBarcode:String):Boolean;
var
   msgWarning: String;
   qry: TADOQuery;
   sqlCmd: String;
begin

    // Pesquisa pelo BarCode no Inventory
    with quBarCode do begin
          Parameters.ParambyName('BarCode').Value := IDBarcode;
          Open;
          Result  := Not IsEmpty;

          if ( result ) then begin
             msgWarning := 'Model ' + scModel.Text + ' will have the barcode ' + quBarcode.fieldByName('Idbarcode').asString +
                           ' removed from it. Do you wish to continue ?';
             if (  application.MessageBox(Pchar(msgWarning), 'Barcode in Inventory', mb_YESNO + mb_IconWarning) = idYes ) then begin
                try
                   qry := TADOQuery.Create(nil);
                   qry.Connection := dm.ADODBConnect;
                   try
                      // amfsouza 11.25.2011 - delete barcode
                      sqlCmd := 'delete from Barcode where IdBarcode =:barcode and IDModel =:idmodel ';
                      qry.SQL.Text   := sqlCmd;
                      qry.Parameters.ParamByName('barcode').Value := idBarcode;
                      qry.Parameters.ParamByName('idmodel').Value := quFormIdModel.asInteger;
                      qry.ExecSQL;

                      // amfsouza 11.25.2011
                      sqlCmd := 'insert into Barcode values (:idbarcode, :idmodel, :date, :order, :qty)';
                      qry.sql.Text := sqlCmd;
                      qry.Parameters.ParamByName('IdBarcode').Value := idBarcode;
                      qry.Parameters.ParamByName('IdModel').Value   := quFormIdModel.asInteger;
                      qry.Parameters.ParamByName('data').Value      := now();
                      qry.Parameters.ParamByName('BarcodeOrder').Value := NULL;
                      qry.Parameters.ParamByName('Qty').value          := NULL;
                      qry.ExecSQL;

                      edtBarCode.Text := idBarcode;

                   except
                      //
                   end;
                finally
                   freeAndNil(qry);
                end;
             end
          end;

          IDModel := quBarCodeIDModel.Value;
          Close;
         end;

end;

function TFchPurchaseItem.OnAfterSaveChange(var iError:Integer):Boolean;
begin

  Try
    if quFormIDPurchase.AsString <> '' then
       begin
       DM.RunSQL('EXEC sp_Purchase_AtuPurchaseSubTotal ' + quFormIDPurchase.AsString + ', ' + IntToStr(Byte(fTaxCalcTax)));
       end;
    Result := True;
  Except
    Result := False;
  end;

  SaveVendorModelCode;

  if (frmCommand = btInc) and (quFormIDLote.AsInteger <> 0) then
    Result := DM.FDMInventory.LotAdjust(FIDModel,
                                        DM.fStore.ID,
                                        quFormIDLote.AsInteger,
                                        quFormQty.AsFloat, 1);

end;


procedure TFchPurchaseItem.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  quBrowse.AddFilter(['IDPurchase'], [quFormIDPurchase.AsString]);
end;

procedure TFchPurchaseItem.scModelSelectItem(Sender: TObject);
begin
  inherited;
  ModelSet;
  SetFocusQty;
end;

procedure TFchPurchaseItem.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if (frmCommand = btAlt) and (quFormCaseQty.AsFloat = 0) then
  begin
    cbxQtyType.ItemIndex     := 1;
    cbxTypeCostTax.ItemIndex := 1;
  end
  else
  begin
    cbxQtyType.ItemIndex     := 0;
    cbxTypeCostTax.ItemIndex := 0;
  end;

  ModelSet;

  if fTaxCalcTax then
  begin
     ItemTaxRefresh;
     ItemTaxRetRefresh;
     RefreshUnitCost;
     if quFormIDFornecedor.AsString <> '' then
       FVendorState := Trim(DM.DescCodigo(['IDPessoa'], [quFormIDFornecedor.AsString], 'Pessoa', 'IDEstado'));
  end;
end;

procedure TFchPurchaseItem.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormQty.Clear;
  quFormNewCostPrice.Clear;
  quFormNewSalePrice.Clear;
  quFormNewSuggRetail.Clear;
  cbxAutoCreate.Visible := True;
  lbCaseBarcode.Visible  := False;
  edtCaseBarcode.Visible := False;
  edtVendorCode.Clear;
  pnlQtyType.Visible := False;
  cbxQtyType.ItemIndex     := 0;
  cbxTypeCostTax.ItemIndex := 0;
  quFormDiscountRet.Clear;
  quFormDiscount.Clear;

  fModelCaseQty := 0;
  RefreshQtyControls;

  if edtVendorCode.CanFocus then
    edtVendorCode.SetFocus;

  edtBarCode.Clear; 
end;

procedure TFchPurchaseItem.quPOAfterOpen(DataSet: TDataSet);
begin
  inherited;

  with quPO do
    begin

    pnlNavigatorPo.Visible := (RecordCount > 1);
    pnlNav1.Visible        := pnlNavigatorPo.Visible;

    if (not IsEmpty) and (not fTaxCalcTax) then
       begin
       if quFormNewCostPrice.IsNull then
          if quPOCostPrice.AsInteger <> 0 then
             quFormNewCostPrice.AsCurrency := quPOCostPrice.AsCurrency;

       if quFormNewSalePrice.IsNull then
          if quPOSalePrice.AsInteger <> 0 then
             quFormNewSalePrice.AsCurrency := quPOSalePrice.AsCurrency;

       if quFormNewSuggRetail.IsNull then
          if quPOSuggRetail.AsInteger <> 0 then
             quFormNewSuggRetail.AsCurrency := quPOSuggRetail.AsCurrency;
       end;
    end;

end;

procedure TFchPurchaseItem.sbNextClick(Sender: TObject);
begin
  inherited;
  quPo.Next;
  if quPo.Eof then
     begin
     sbNext.Enabled  := False;
     sbPrior.Enabled := True;
     end;
end;

procedure TFchPurchaseItem.sbPriorClick(Sender: TObject);
begin
  inherited;
  quPo.Prior;
  if quPo.Bof then
     begin
     sbNext.Enabled  := True;
     sbPrior.Enabled := False;
     end;
end;

procedure TFchPurchaseItem.btCloseClick(Sender: TObject);
begin

  if (Trim(edtBarCode.Text) <> '') then
  begin
    // to avoid SQL error that would occurs on ExistsBarcode() method.
    if (trim(scModel.LookUpValue) = '' ) then
    begin
      MsgBox(MSG_EXC_SELECT_A_MODEL, vbOKOnly + vbInformation);
      scModel.SetFocus;
      Exit;
    end;

    if ExistsBarcode(Trim(edtBarCode.Text)) then
    begin
      MsgBox(MSG_EXC_BARCODE_EXISTE, vbOKOnly + vbInformation);
      edtBarCode.SetFocus;
      Exit;
    end;
  end;

  if (Trim(edtBarCode.Text) <> '') then
    if BarcodeExistsInPurchase(Trim(edtBarCode.Text))then
    begin
      MsgBox(MSG_EXC_BARCODE_EXISTE_PURCHASE, vbCritical + vbOKOnly);
      edtBarCode.SetFocus;
      Exit;
    end;

  if (quFormQty.AsFloat = 0) then
  begin
    MsgBox(MSG_CRT_QTY_NO_ZERO, vbCritical + vbOKOnly);
    Exit;
  end;

  if quForm.State in dsEditModes then
     UpdateIDPOItem;

  ItemTaxPost;

  inherited;

  cbxAutoCreate.Checked := false;
  toClear := true;
end;

function TFchPurchaseItem.ExistsBarcode(Barcode :String): Boolean;
begin
  with DM.quFreeSQL do
    begin
    if Active then
       Close;

    SQL.Clear;
    SQL.Text := ' SELECT IDBarcode, IDModel FROM Barcode ' +
                ' WHERE IDBarcode = ' + QuotedStr(Trim(Barcode)) + ' AND IDModel <> ' + quFormIDModel.AsString;
    Open;

    Result := not(IsEmpty);

    Close;
    end;
end;

procedure TFchPurchaseItem.btnSerialNumbClick(Sender: TObject);
begin
  inherited;
  if Trim(scModel.LookUpValue) = '' then
     begin
     MsgBox(MSG_EXC_SELECT_A_MODEL, vbExclamation + vbOkOnly);
     Exit;
     end;

  if quFormQty.AsFloat = 0 then
     begin
     MsgBox(MSG_CRT_NO_QTY_EMPTY , vbOKOnly + vbCritical);
     Exit;
     end;

  with TFrmSerialNumber.Create(Self) do
     StartOnPurchase(quFormIDPurchaseItem.AsInteger,
                     quFormIDPurchase.AsInteger,
                     quFormIDModel.AsInteger,
                     StrToInt(ParseParam(sParam, 'IDStore')),
                     quFormQty.AsFloat);


end;

procedure TFchPurchaseItem.FormCreate(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
     begin
     btnSerialNumb.Visible := False;
     end;

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];
  bUseMarkupOnCost             := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];
  bAutoRound                   := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];
  bAutoCalcMargin              := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  bControlLot                  := DM.fSystem.SrvParam[PARAM_USE_LOT_CONTROL];

  edtCaseBarcode.CheckBarcodeDigit := edtBarcode.CheckBarcodeDigit;
  edtCaseBarcode.MinimalDigits     := edtBarcode.MinimalDigits;
  edtCaseBarcode.RunSecondSQL      := edtBarcode.RunSecondSQL;

  fTaxCalcTax := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];

  pnlMarginSale.Visible := bAutoCalcMargin;

  tsCostTaxes.TabVisible   := fTaxCalcTax;
  tsReturn.TabVisible      := False;
  tsInfo.TabVisible        := fTaxCalcTax;

  quFormQty.Required       := True;
  quFormCostPrice.Required := fTaxCalcTax;

  if fTaxCalcTax then
     begin
     tsQty.TabVisible             := False;
     quFormNewSalePrice.Required  := False;
     quFormNewSuggRetail.Required := False;
     end;

  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  DMCalcTax := TDMCalcTax.Create(Self);
  DMCalcTax.ADODBConnect := DM.ADODBConnect;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp := '';
      sUrlVideo:= '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp := 'http://www.mainretail.com.br/treinamento/Compras/Com_NovoRecebimento.htm';
      sUrlVideo:= 'http://www.mainretail.com.br/treinamento/video/OC_Criando_Novo_Recebimento/Criando_um_Novo_Recebimento.htm';
    end;

    LANG_SPANISH:
    begin
      sUrlHelp := '';
      sUrlVideo:= '';
    end;
  end;


end;

procedure TFchPurchaseItem.ItemTaxClose;
begin
  with quItemTax do
     if Active then
        Close;
end;

procedure TFchPurchaseItem.ItemTaxRetClose;
begin
  with quItemTaxRet do
     if Active then
        Close;
end;

procedure TFchPurchaseItem.ItemTaxOpen;
begin
  with quItemTax do
     if not Active then
        begin
        Parameters.ParamByName('IDPurchaseItem').Value := quFormIDPurchaseItem.AsInteger;
        Open;
        end;
end;

procedure TFchPurchaseItem.ItemTaxRetOpen;
begin
  with quItemTaxRet do
     if not Active then
        begin
        Parameters.ParamByName('IDPurchaseItem').Value := quFormIDPurchaseItem.AsInteger;
        Open;
        end;
end;

procedure TFchPurchaseItem.ItemTaxRefresh;
begin
   ItemTaxClose;
   ItemTaxOpen;
end;

procedure TFchPurchaseItem.ItemTaxRetRefresh;
begin
   ItemTaxRetClose;
   ItemTaxRetOpen;
   tsReturn.TabVisible := not quItemTaxRet.IsEmpty;
end;

procedure TFchPurchaseItem.NextAppend;
begin
  inherited;
  if fTaxCalcTax and (frmCommand = btInc) then
     begin
     DMCalcTax.CreateTax(quFormIDFornecedor.AsInteger,
                         quFormIDPurchase.AsInteger,
                         quFormIDPurchaseItem.AsInteger);
     ItemTaxRefresh;
     RefreshUnitCost;
     end;
end;

procedure TFchPurchaseItem.btnRemovTaxClick(Sender: TObject);
begin
  inherited;

  if quItemTaxIDPurchaseItemTax.IsNull then
     Exit;

  DM.RunSQL('DELETE Pur_PurchaseItemTax WHERE IDPurchaseItemTax = ' + quItemTaxIDPurchaseItemTax.AsString);
  ItemTaxRefresh;
  
end;

procedure TFchPurchaseItem.dsItemTaxStateChange(Sender: TObject);
begin
  inherited;

  with quItemTax do
    btnRemovTax.Enabled := not (EOF AND BOF);

end;

procedure TFchPurchaseItem.btnUpdateClick(Sender: TObject);
begin
  inherited;
  ItemTaxPost;
  UpdateMVA;
  DMCalcTax.CalculateTax(quForm.FieldByName('IDPurchaseItem').AsInteger,
                         quForm.FieldByName('CostPrice').AsCurrency,
                         quForm.FieldByName('FreightCost').AsCurrency,
                         quForm.FieldByName('OtherCost').AsCurrency,
                         FMVA,
                         quForm.FieldByName('Discount').AsCurrency,
                         quForm.FieldByName('Qty').AsFloat);
  ItemTaxRefresh;
end;

procedure TFchPurchaseItem.ItemTaxPost;
begin
  with quItemTax do
    if Active then
       if State in dsEditModes then
          Post;
end;

procedure TFchPurchaseItem.ItemTaxRetPost;
begin
  with quItemTaxRet do
    if Active then
       if State in dsEditModes then
          Post;
end;

procedure TFchPurchaseItem.btnCalcNewCostClick(Sender: TObject);
var
  NewCost : Currency;
  Qty : Double;
  NewSale, NewMSRPSale, cCostPrice : Currency;

begin
  inherited;

  NewCost := (quFormCostPrice.AsCurrency + quFormFreightCost.AsCurrency +
              quFormOtherCost.AsCurrency);

  ItemTaxPost;
  if not chkInCost.Checked then
     NewCost := NewCost - DMCalcTax.GetTaxesValueTotal(quFormIDPurchaseItem.AsInteger)
  else
     NewCost := NewCost + DMCalcTax.GetTaxesValueTotal(quFormIDPurchaseItem.AsInteger);

  //Aplicar o desconto apos calcular os impostos   
  NewCost := NewCost - quFormDiscount.AsCurrency;

  Qty := quFormQty.AsFloat;

  if Qty = 0 then
     Qty := 1;

  if not TestOnEditModes then
     quForm.Edit;

  quFormNewCostPrice.AsCurrency := NewCost/Qty;
  DBEdit2Exit(Self);

  btnReturnItem.Enabled := True;

  if pnlMarginSale.Visible then
  begin
    NewSale     := 0;
    NewMSRPSale := 0;
    cCostPrice  := NewCost/Qty;

    if (fModelMarkup = 0) then
    begin
      NewSale     := DM.FDMCalcPrice.CalcSalePrice(quFormIDModel.AsInteger,
                                                   quFormIDGroup.AsInteger,
                                                   quFormIDModelGroup.AsInteger,
                                                   quFormIDModelSubGroup.AsInteger,
                                                   cCostPrice);

      NewMSRPSale := DM.FDMCalcPrice.CalcMSRPPrice(quFormIDGroup.AsInteger,
                                                   quFormIDModelGroup.AsInteger,
                                                   quFormIDModelSubGroup.AsInteger,
                                                   cCostPrice);
    end
    else
    begin
      if bUseMarkupOnCost then
        NewSale := DM.FDMCalcPrice.GetMarkupPrice(cCostPrice, fModelMarkup)
      else if (fModelMarkup < 100) then
        NewSale := DM.FDMCalcPrice.GetMarginPrice(cCostPrice, fModelMarkup);

      if bAutoRound then
        NewSale := DM.FDMCalcPrice.CalcRounding(quFormIDGroup.AsInteger, NewSale);

    end;

    if (NewSale <> 0) and (NewSale <> cCostPrice) then
      begin
        if not (quForm.State in dsEditModes) then quForm.Edit;
        quFormNewSalePrice.AsFloat  := NewSale;
      end;

    if (NewMSRPSale <> cCostPrice) then
     begin
       if not (quForm.State in dsEditModes) then quForm.Edit;
       quFormNewSuggRetail.AsFloat := NewMSRPSale;
     end;
  end;


end;

procedure TFchPurchaseItem.quItemTaxAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchPurchaseItem.btnCalcNewCostRetClick(Sender: TObject);
var
  NewCost : Currency;
  Qty : Double;
begin
  inherited;

  NewCost := (quFormCostPriceRet.AsCurrency + quFormFreightCostRet.AsCurrency);

  ItemTaxRetPost;
  if not chkInCost.Checked then
     NewCost := NewCost - DMCalcTax.GetTaxesRetValueTotal(quFormIDPurchaseItem.AsInteger)
  else
     NewCost := NewCost + DMCalcTax.GetTaxesRetValueTotal(quFormIDPurchaseItem.AsInteger);

  NewCost := NewCost - quFormDiscountRet.AsCurrency;

  Qty := quFormQtyRet.AsFloat;

  if Qty = 0 then
     Qty := 1;

  if not TestOnEditModes then
     quForm.Edit;

  quFormNewCostPriceRet.AsCurrency := NewCost/Qty;

end;

procedure TFchPurchaseItem.btnReturnItemClick(Sender: TObject);
begin
    InsertVendorTaxRet;
end;

procedure TFchPurchaseItem.InsertVendorTaxRet;
begin
  quItemTaxRet.DisableControls;
  try
    DMCalcTax.CreateTaxRet(quFormIDPurchaseItem.AsInteger);
    ItemTaxRetRefresh;
  finally
    quItemTaxRet.EnableControls;
  end;
  tsReturn.TabVisible := True;
  pgPrices.ActivePage := tsReturn;
  if DBEdit22.CanFocus then
     DBEdit22.SetFocus;
end;

procedure TFchPurchaseItem.btnUpdateRetClick(Sender: TObject);
begin
  inherited;
  ItemTaxRetPost;
  DMCalcTax.CalculateTaxRet(quForm.FieldByName('IDPurchaseItem').AsInteger,
                            quForm.FieldByName('CostPriceRet').AsCurrency,
                            quForm.FieldByName('FreightCostRet').AsCurrency,
                            quForm.FieldByName('OtherCostRet').AsCurrency,
                            FMVA,
                            quForm.FieldByName('DiscountRet').AsCurrency);

  ItemTaxRetRefresh;
end;

procedure TFchPurchaseItem.edtVendorCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN) then
     begin
     if edtVendorCode.Text = '' then
        Exit;

     with quVendorCode do
       begin
       if Active then
          Close;
       Parameters.ParamByName('IDPessoa').Value := quFormIDFornecedor.AsInteger;
       Parameters.ParamByName('VendorCode').Value := edtVendorCode.Text;
       Try
         Open;
         if not IsEmpty then
            begin
              edtVendorCode.Clear;
              quForm.Edit;
              quFormIDModel.AsInteger := quVendorCodeIDModel.AsInteger;
              ModelSet;
              if pgPrices.ActivePage = tsQty then
              begin
                if pnlCaseQty.Visible then
                  quFormCaseQty.FocusControl
                else
                  quFormQty.FocusControl;
              end
              else if pgPrices.ActivePage = tsCostTaxes then
              begin
                if pnlCaseQtyCostTax.Visible then
                  quFormCaseQty.FocusControl
                else
                  quFormQty.FocusControl;
              end;
            end
         else
           edtBarCode.SetFocus; 
       finally
         Close;
         end;
       end;
     end;

end;

function TFchPurchaseItem.SaveVendorModelCode:Boolean;
var
  sSQL : String;
begin

  Result := True;

  if (edtVendorCode.Text <> '') and (frmCommand = btInc ) then
      begin
      sSQL := 'Insert VendorModelCode (IDVendorModelCode, IDPessoa, IDModel, VendorCode) VALUES '+
              '('+IntToStr(DM.GetNextID(MR_VENDOR_MODEL_CODE))+','+
               quFormIDFornecedor.AsString+' ,'+
               scModel.LookUpValue+' ,'+QuotedStr(edtVendorCode.Text)+' )';

      Result := DM.RunSQL(sSQL);
      edtVendorCode.Clear; 
      end;

end;

procedure TFchPurchaseItem.edtVendorCodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchPurchaseItem.edtVendorCodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TFchPurchaseItem.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
        begin
          quForm.Edit;
          quFormIDModel.AsInteger := R;
          ModelSet;
          SetFocusQty;
        end;
    end;

end;

procedure TFchPurchaseItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fFrmBarcodeSearch);
  FreeAndNil(DMCalcTax);
end;

procedure TFchPurchaseItem.DBEdit3Exit(Sender: TObject);
var
  NewSale, NewMSRPSale, cCostPrice: Currency;
begin

  cCostPrice  := DM.FDMCalcPrice.FormatPrice(quFormNewCostPrice.AsCurrency);
  NewSale     := 0;
  NewMSRPSale := 0;

  //amfsouza 05.03.2011 - adjust price manually
  if ( quModel.FieldByName('UpdatePrice').AsBoolean = True ) then
     exit;

  if bAutoCalcMargin then
  begin
    NewSale     := DM.FDMCalcPrice.CalcSalePrice(quFormIDModel.AsInteger,
                                                 quFormIDGroup.AsInteger,
                                                 quFormIDModelGroup.AsInteger,
                                                 quFormIDModelSubGroup.AsInteger,
                                                 cCostPrice);

    NewMSRPSale := DM.FDMCalcPrice.CalcMSRPPrice(quFormIDGroup.AsInteger,
                                                 quFormIDModelGroup.AsInteger,
                                                 quFormIDModelSubGroup.AsInteger,
                                                 cCostPrice);
  end
  else
  begin
    if bUseMarkupOnCost then
      NewSale := DM.FDMCalcPrice.GetMarkupPrice(cCostPrice, fModelMarkup)
    else if (fModelMarkup < 100) then
      NewSale := DM.FDMCalcPrice.GetMarginPrice(cCostPrice, fModelMarkup);

    if bAutoRound then
      NewSale := DM.FDMCalcPrice.CalcRounding(quFormIDGroup.AsInteger, NewSale);

  end;

  if (NewSale <> 0) and (NewSale <> cCostPrice) then
    begin
      if not (quForm.State in dsEditModes) then quForm.Edit;
      quFormNewSalePrice.AsFloat  := NewSale;
    end;

  if (NewMSRPSale <> cCostPrice) then
   begin
     if not (quForm.State in dsEditModes) then quForm.Edit;
     quFormNewSuggRetail.AsFloat := NewMSRPSale;
   end;

end;

procedure TFchPurchaseItem.RefreshQtyControls;
begin
  if pgPrices.ActivePage = tsQty then
  begin
    pnlQtyType.Visible := (fModelCaseQty > 1);
    pnlQty.Visible     := (fModelCaseQty <= 1) or (cbxQtyType.ItemIndex = 1);
    pnlCaseQty.Visible := not pnlQty.Visible;
    pnlQtyType.Top     := 0;
    
    if pnlQty.Visible then
    begin
      edtCaseBarcode.Clear;
      edtCaseBarcode.Visible := False;
      lbCaseBarcode.Visible  := False;
    end
    else
    begin
      edtCaseBarcode.Visible := True;
      lbCaseBarcode.Visible  := True;
    end;
  end
  else if pgPrices.ActivePage = tsCostTaxes then
  begin
    pnlCastTypeTax.Visible    := (fModelCaseQty > 1);
    pnlQtyCostTax.Visible     := (fModelCaseQty <= 1) or (cbxTypeCostTax.ItemIndex = 1);
    pnlCaseQtyCostTax.Visible := not pnlQtyCostTax.Visible;
    pnlCastTypeTax.Top        := 0;

    if pnlQtyCostTax.Visible then
    begin
      edtCaseBarcode.Clear;
      edtCaseBarcode.Visible := False;
      lbCaseBarcode.Visible  := False;
    end
    else
    begin
      edtCaseBarcode.Visible := True;
      lbCaseBarcode.Visible  := True;
    end;
  end;
end;

procedure TFchPurchaseItem.cbxQtyTypeSelect(Sender: TObject);
begin
  inherited;
  RefreshQtyControls;
  quForm.Edit;
end;

procedure TFchPurchaseItem.edtCaseQtyUSExit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
  begin
    quFormQty.AsFloat := quFormCaseQty.AsFloat * fModelCaseQty;
    DBEdit28Exit(Self);
  end;
end;

procedure TFchPurchaseItem.DBEdit28Exit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
  begin
    quFormNewCostPrice.AsCurrency := quFormCaseCost.AsCurrency / fModelCaseQty;
    DBEdit3Exit(Self);
  end;
end;

procedure TFchPurchaseItem.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  if pgPrices.ActivePage = tsQty then
  begin
    if (pnlQtyType.Visible and (cbxQtyType.ItemIndex = 1 )) then
    begin
      quFormCaseQty.AsFloat  := 0;
      quFormCaseCost.AsFloat := 0;
    end;
  end
  else if pgPrices.ActivePage = tsCostTaxes then
  begin
    if (pnlQtyType.Visible and (cbxTypeCostTax.ItemIndex = 1 )) then
    begin
      quFormCaseQty.AsFloat  := 0;
      quFormCaseCost.AsFloat := 0;
    end;
  end;

end;

procedure TFchPurchaseItem.edtCaseCostExit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
    quFormCostPrice.AsCurrency := quFormCaseCost.AsCurrency;
end;

procedure TFchPurchaseItem.DBEdit2Exit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
  begin
    quFormNewCostPrice.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormNewCostPrice.AsCurrency);

    if pnlMarginSale.Visible then
      DBEdit3Exit(Self);
  end;
end;

procedure TFchPurchaseItem.edtBarCodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchPurchaseItem.edtBarCodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
  quForm.Edit;
  if Trim(edtBarCode.Text) <> '' then
  begin
    quFormBarCode.AsString := Trim(edtBarCode.Text);
    // to force search by Barcode even that user not press [ENTER] key.
    edtBarCode.SearchBarcode;
  end;
end;

procedure TFchPurchaseItem.edtBarCodeAfterSearchBarcode(
  Sender: TObject);
var
  iIDModel : integer;
begin
  inherited;

  with edtBarcode do
  begin
    if SearchResult then
      begin
        // Pesquisa pelo Barcode na Purchase
        if SelectPurchaseBarcode(Trim(edtBarcode.Text)) then
           Exit;

        iIDModel := GetFieldValue('IDModel');
        quForm.Edit;
        quFormIDModel.Value := iIDModel;
        edtBarcode.Clear;

        ModelSet;
      end
    else
      begin
        with TFchPurchaseItemNewBarCode.Create(Self) do
          iIDModel := Start(Trim(edtBarcode.Text));
        if iIDModel <> -1 then
          begin
            quForm.Edit;
            quFormIDModel.AsInteger := iIDModel;
            ModelSet;
          end
        else
          begin
            edtBarcode.Clear;
            if edtBarcode.CanFocus then
               edtBarcode.SetFocus;
            Exit;
          end;
      end;
  end;

  lbCaseBarcode.Visible  := (fModelCaseQty > 1) and (iIDModel <> -1);
  edtCaseBarcode.Visible := lbCaseBarcode.Visible;

  SetFocusQty;
  
end;

procedure TFchPurchaseItem.RefreshPercent;
begin
  if cbxDisplayPercent.Checked then
  begin
    edtFreightPer.Visible := True;
    edtOtherPerc.Visible  := True;
    edtFreight.Left       := 118;
    edtOther.Left         := 118;
    edtFreight.Width      := 63;
    edtOther.Width        := 63;
  end
  else
  begin
    edtFreightPer.Visible := False;
    edtOtherPerc.Visible  := False;
    edtFreight.Left       := 72;
    edtOther.Left         := 72;
    edtFreight.Width      := 100;
    edtOther.Width        := 100;
  end;
end;

procedure TFchPurchaseItem.cbxDisplayPercentClick(Sender: TObject);
begin
  inherited;
  RefreshPercent;
end;

procedure TFchPurchaseItem.edtFreightPerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFchPurchaseItem.edtFreightPerExit(Sender: TObject);
begin
  inherited;
  CalcFreight;
end;

procedure TFchPurchaseItem.edtOtherPercExit(Sender: TObject);
begin
  inherited;
  CalcOtherCost;
end;

procedure TFchPurchaseItem.CalcFreight;
begin
  if (cbxDisplayPercent.Checked) and
     (quFormCostPrice.AsCurrency <> 0) and
     (MyStrToFloat(edtFreightPer.Text) <> 0) then
  begin
    quForm.Edit;
    quFormFreightCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormCostPrice.AsCurrency * (MyStrToFloat(edtFreightPer.Text)/100));
  end;
end;

procedure TFchPurchaseItem.CalcOtherCost;
begin
  if (cbxDisplayPercent.Checked) and
     (quFormCostPrice.AsCurrency <> 0) and
     (MyStrToFloat(edtOtherPerc.Text) <> 0) then
  begin
    quForm.Edit;
    quFormOtherCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormCostPrice.AsCurrency * (MyStrToFloat(edtOtherPerc.Text)/100));
  end;
end;

procedure TFchPurchaseItem.edtCostTotalCostExit(Sender: TObject);
begin
  inherited;
  if quForm.State = dsEdit then
  begin
    quFormCostPrice.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormCostPrice.AsCurrency);

    CalcFreight;
    CalcOtherCost;
  end;
end;

procedure TFchPurchaseItem.pgPricesChange(Sender: TObject);
begin
  inherited;
  if pgPrices.ActivePage = tsInfo then
  begin
    edtMarkup.Caption := '0 %';
    if quModel.Active then
       if quFormNewCostPrice.AsCurrency > 0 then
         edtMarkup.Caption := FormatFloat('#,##0.00 %',(((quModelSellingPrice.AsCurrency - quFormNewCostPrice.AsCurrency)/quFormNewCostPrice.AsCurrency)*100))
  end;
end;

procedure TFchPurchaseItem.cbxAutoCreateClick(Sender: TObject);
begin
  if cbxAutoCreate.Checked then
    begin
      edtBarCode.Text := '';
      edtBarCode.Enabled := false;
      edtBarCode.ParentColor := true;
    end
  else
    begin
      edtBarCode.Enabled := true;
      edtBarcode.Color := $0080FFFF;
    end;
end;

procedure TFchPurchaseItem.FormShow(Sender: TObject);
begin
  inherited;
  StartScreen;
end;

procedure TFchPurchaseItem.StartScreen;
begin
  cbxAutoCreate.Checked := false;
  edtBarCode.Enabled := true;
  edtBarcode.Color := $0080FFFF;
  edtBarcode.Text := quFormBarCode.AsString;
  edtCaseBarcode.Text := quFormBarcodeCase.AsString;

  bPastMonth := (ParseParam(sParam, 'disable') = '1');
  bIsHistory := (ParseParam(sParam, 'history') = '1');

  btClose.Enabled := not bPastMonth;
  btnUpdate.Enabled := not bPastMonth;
  btnReturnItem.Enabled := not bPastMonth;
  btnCalcNewCost.Enabled := not bPastMonth;
  btnUpdateRet.Enabled := not bPastMonth;
  btnCalcNewCostRet.Enabled := not bPastMonth;
  btnSerialNumb.Enabled := not bPastMonth;

  if bIsHistory and (quFormIDLote.AsInteger <> 0) then
  begin
    quFormQty.ReadOnly     := True;
    quFormCaseQty.ReadOnly := True;
  end
  else
  begin
    quFormQty.ReadOnly     := False;
    quFormCaseQty.ReadOnly := False;
  end;

end;

procedure TFchPurchaseItem.edtFreightExit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
    quFormFreightCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormFreightCost.AsCurrency);
end;

procedure TFchPurchaseItem.edtOtherExit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
    quFormOtherCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormOtherCost.AsCurrency);
end;

procedure TFchPurchaseItem.DBEdit16Exit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
    quFormNewSalePrice.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormNewSalePrice.AsCurrency);
end;

procedure TFchPurchaseItem.DBEdit15Exit(Sender: TObject);
begin
  inherited;
  if (quForm.State = dsEdit) then
    quFormNewSuggRetail.AsCurrency := DM.FDMCalcPrice.FormatPrice(quFormNewSuggRetail.AsCurrency);
end;

function TFchPurchaseItem.OnValidadeField: boolean;
var
  bUseCase : Boolean;
begin
  Result := inherited OnValidadeField;

  bUseCase := False;

  if tsQty.Visible then
    bUseCase := (cbxQtyType.ItemIndex = 0)
  else if tsCostTaxes.Visible then
    bUseCase := (cbxTypeCostTax.ItemIndex = 0);

  if (fModelCaseQty > 1) and bUseCase then
  begin
    quFormCaseCost.Required  := True;
    quFormCaseQty.Required   := True;
    quFormQty.Required       := False;
    quFormCostPrice.Required := False;
  end
  else
  begin
    quFormQty.Required       := True;
    quFormCostPrice.Required := fTaxCalcTax;
    quFormCaseCost.Required  := False;
    quFormCaseQty.Required   := False;
  end;

  if not bUseLot then
    quFormIDLote.Required := False
  else
    quFormIDLote.Required := bControlLot;

end;

procedure TFchPurchaseItem.edtCaseBarcodeAfterSearchBarcode(
  Sender: TObject);
begin
  inherited;

  with edtCaseBarcode do
    if SearchResult then
      if (GetFieldValue('IDModel') <> -1) or SelectPurchaseBarcode(Trim(edtCaseBarcode.Text)) then
      begin
        MsgBox(MSG_EXC_BARCODE_EXISTE, vbOKOnly + vbInformation);
        edtCaseBarcode.Clear;
      end;

end;

procedure TFchPurchaseItem.edtCaseBarcodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
  quForm.Edit;
  if (Trim(edtCaseBarcode.Text) <> '') then
    quFormBarcodeCase.AsString := Trim(edtCaseBarcode.Text);
end;

function TFchPurchaseItem.BarcodeExistsInPurchase(
  ABarcode: String): Boolean;
begin

  Result := True;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text :=   'SELECT ' +
                        'PI.BarCode ' +
                  'FROM ' +
	                      'Pur_PurchaseItem PI ' +
	                      'LEFT JOIN Model M ON (PI.IDModel  = M.IDModel) ' +
                  'WHERE ' +
                        'PI.BarCode = ' + QuotedStr(ABarcode);
    Open;

    if IsEmpty then
      Result := False;
  end;

end;

procedure TFchPurchaseItem.SetFocusQty;
begin
  if edtQty.CanFocus then
    edtQty.SetFocus
  else if edtCostQty.CanFocus then
    edtCostQty.SetFocus
  else if edtCaseQty.CanFocus then
    edtCaseQty.SetFocus
  else if edtCaseQtyUS.CanFocus then
    edtCaseQtyUS.SetFocus;
end;

procedure TFchPurchaseItem.OnBeforeStart;
begin
  inherited;
  edtVendorCode.Clear;
end;

procedure TFchPurchaseItem.scLotEnter(Sender: TObject);
begin
  inherited;
  if scModel.LookUpValue <> '' then
    DM.FFchParam := 'Qty='+FloatToStr(quFormQty.AsFloat)+';IDModel='+scModel.LookUpValue+';';
end;

procedure TFchPurchaseItem.quFormQtyChange(Sender: TField);
begin
  inherited;
  RefreshUnitCost;
end;

procedure TFchPurchaseItem.RefreshUnitCost;
var
  cResult : Currency;
begin
  if fTaxCalcTax then
  begin
    if (quFormQty.AsFloat <> 0) and (quFormCostPrice.AsCurrency <> 0) then
      cResult := (quFormCostPrice.AsCurrency / quFormQty.AsFloat)
    else
      cResult := 0;
    edtUnitCost.Text  := FormatFloat('0.00', cResult);
    edtUnitCost1.Text := FormatFloat('0.00', cResult);
  end;
end;

procedure TFchPurchaseItem.quFormCostPriceChange(Sender: TField);
begin
  inherited;
  RefreshUnitCost;
end;

procedure TFchPurchaseItem.UpdateMVA;
begin

  if pnlMVA.Visible then
    if rbMVAIn.Checked then
      FMVA := StrToCurr(rbMVAIn.Caption)
    else
      FMVA := StrToCurr(rbMVAOut.Caption);

end;

procedure TFchPurchaseItem.scModelChange(Sender: TObject);
begin
  inherited;
  toClear := ( trim(scModel.Text) = '' );
end;

end.
