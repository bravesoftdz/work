(*
Version : (292 - 292)
Date    : 06.02.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : press save button and not happened
Solution: I was doing a wrong decision after function that verify Open Po's
Version : (296 - 293)
-----------------------------------------------------------------------------------------------------
*)

unit uFchPurchase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichasBrowse, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, StdCtrls, ExtCtrls, DBCtrls, Mask, SuperComboADO,
  FormConfig, ADODB, PowerADOQuery, siComp, siLangRT, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, ComCtrls, LblEffct,
  Buttons, Grids, DBGrids, DateBox, SMDBGrid, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu,
  cxGridPopupMenu, Menus, DBClient, Provider;

type
  TFchPurchase = class(TbrwFrmParentBrw)
    Label2: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label22: TLabel;
    Label18: TLabel;
    cmbVendor: TDBSuperComboADO;
    DBSuperCombo2: TDBSuperComboADO;
    DBSuperCombo1: TDBSuperComboADO;
    scStore: TDBSuperComboADO;
    Panel5: TPanel;
    Label6: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edTotal: TEdit;
    edPercOther: TEdit;
    edOther: TDBEdit;
    edSubTotal: TEdit;
    edFreight: TDBEdit;
    edPercFreight: TEdit;
    pgPurchase: TPageControl;
    tsPurchaseInfo: TTabSheet;
    pnlReceiveType: TPanel;
    Label19: TLabel;
    pnlInvoice: TPanel;
    Label10: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    dbedInvoice: TDBEdit;
    dbInvoiceTotal: TDBEdit;
    pnlCOD: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    pnlPackSl: TPanel;
    lblDocumentNumber: TLabel;
    lblDocumentNumberObri: TLabel;
    edDocumentNumber: TDBEdit;
    tsVendorTerm: TTabSheet;
    pnlTerms: TPanel;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    brImport: TSpeedButton;
    quBrowseIDPurchaseItem: TIntegerField;
    quBrowseIDPurchase: TIntegerField;
    quBrowseIDModel: TIntegerField;
    quBrowseBarCode: TStringField;
    quBrowseNewCostPrice: TBCDField;
    quBrowseNewSalePrice: TBCDField;
    quBrowseNewSuggRetail: TBCDField;
    quBrowseSubTotal: TBCDField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseCategory: TStringField;
    quBrowseManufacturer: TStringField;
    grdBrowseDBBarCode: TcxGridDBColumn;
    grdBrowseDBQty: TcxGridDBColumn;
    grdBrowseDBNewCostPrice: TcxGridDBColumn;
    grdBrowseDBNewSalePrice: TcxGridDBColumn;
    grdBrowseDBNewSuggRetail: TcxGridDBColumn;
    grdBrowseDBSubTotal: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBCategory: TcxGridDBColumn;
    grdBrowseDBManufacturer: TcxGridDBColumn;
    dxDBDateEdit3: TDBDateBox;
    quFormIDPurchase: TIntegerField;
    quFormPurchaseStatus: TStringField;
    quFormIDFornecedor: TIntegerField;
    quFormIDStore: TIntegerField;
    quFormIDUserPreReceiving: TIntegerField;
    quFormDatePreReceiving: TDateTimeField;
    quFormIDUserFinalReceiving: TIntegerField;
    quFormDateFinalReceiving: TDateTimeField;
    quFormFreight: TBCDField;
    quFormOtherCharges: TBCDField;
    quFormDocumentType: TStringField;
    quFormDocumentNumber: TStringField;
    quFormDocumentDate: TDateTimeField;
    quFormDocumentDueDate: TDateTimeField;
    quFormDocumentTotal: TBCDField;
    dxDBDateEdit4: TDBDateBox;
    grdTerm: TSMDBGrid;
    quTerm: TADOQuery;
    quTermIDPurchase: TIntegerField;
    quTermDueDateShift: TIntegerField;
    quTermDiscount: TBCDField;
    dsTerm: TDataSource;
    spPurchaseDo: TADOStoredProc;
    spRemoveItem: TADOStoredProc;
    Panel7: TPanel;
    btnPrintBarcode: TSpeedButton;
    sbAddPO: TSpeedButton;
    dxDBDateEdit6: TDBDateBox;
    dxInvoiceDate: TDBDateBox;
    grdBrowseDBIDPurchaseItem: TcxGridDBColumn;
    grdBrowseDBIDPurchase: TcxGridDBColumn;
    grdBrowseDBIDModel: TcxGridDBColumn;
    quBrowseCostPrice: TBCDField;
    quBrowseSubTotalTax: TBCDField;
    quBrowseFreightCost: TBCDField;
    quBrowseOtherCost: TBCDField;
    grdBrowseDBCostPrice: TcxGridDBColumn;
    grdBrowseDBSubTotalTax: TcxGridDBColumn;
    grdBrowseDBFreightCost: TcxGridDBColumn;
    grdBrowseDBOtherCost: TcxGridDBColumn;
    tsTax: TTabSheet;
    grdSpecialPrice: TSMDBGrid;
    dsTax: TDataSource;
    quTax: TADOQuery;
    quTaxTaxValue: TBCDField;
    quTaxTaxCategory: TStringField;
    quTaxDebit: TBooleanField;
    quFormPayDays: TIntegerField;
    quFormIDPO: TIntegerField;
    tsReturnInfo: TTabSheet;
    Panel9: TPanel;
    DBEdit8: TDBEdit;
    Label44: TLabel;
    quFormFreightRet: TBCDField;
    quFormOtherChargesRet: TBCDField;
    quFormDocumentNumberRet: TStringField;
    Label13: TLabel;
    Label34: TLabel;
    Label43: TLabel;
    Label35: TLabel;
    Shape2: TShape;
    Label12: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    edtOtherCostRet: TDBEdit;
    edtSubTotalRet: TEdit;
    edtTotalRet: TEdit;
    quBrowseCostPriceRet: TBCDField;
    quBrowseFreightCostRet: TBCDField;
    quBrowseOtherCostRet: TBCDField;
    quBrowseNewCostPriceRet: TBCDField;
    quBrowseSubTotalRet: TBCDField;
    quBrowseSubTotalTaxRet: TBCDField;
    grdBrowseDBSubTotalRet: TcxGridDBColumn;
    quTaxRet: TADOQuery;
    dsTaxRet: TDataSource;
    quTaxRetTaxValue: TBCDField;
    quTaxRetTaxCategory: TStringField;
    quTaxRetDebit: TBooleanField;
    Label42: TLabel;
    edtTaxRet: TEdit;
    Label45: TLabel;
    quFormDocumentDueDateRet: TDateTimeField;
    Label54: TLabel;
    DBDateBox1: TDBDateBox;
    Label55: TLabel;
    grdBrowseDBFreightCostRet: TcxGridDBColumn;
    edtFreightRet: TEdit;
    quBrowseQty: TFloatField;
    quBrowseQtyRet: TFloatField;
    quBrowseCaseQty: TFloatField;
    quBrowseCaseCost: TBCDField;
    grdBrowseDBCaseQty: TcxGridDBColumn;
    grdBrowseDBCaseCost: TcxGridDBColumn;
    btnAddQuick: TSpeedButton;
    popNew: TPopupMenu;
    menAdd: TMenuItem;
    menQuickEntry: TMenuItem;
    cdsDueDate: TClientDataSet;
    dsDueDate: TDataSource;
    quDueDate: TADOQuery;
    quDueDateIDPurchaseDueDate: TStringField;
    quDueDateIDPurchase: TIntegerField;
    quDueDateDate: TDateTimeField;
    quDueDateAmount: TBCDField;
    dspDueDate: TDataSetProvider;
    cbPurType: TComboBox;
    lbDocType: TLabel;
    grDueDateDBTableView1: TcxGridDBTableView;
    grDueDateLevel1: TcxGridLevel;
    grDueDate: TcxGrid;
    pnlTaxInCost: TPanel;
    Label46: TLabel;
    Label47: TLabel;
    Shape3: TShape;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    edtSubTotalInCost: TEdit;
    edtTotalTaxInCost: TEdit;
    edtFreightInCost: TEdit;
    edtTaxInCost: TEdit;
    grDueDateDBTableView1DBDate: TcxGridDBColumn;
    grDueDateDBTableView1DBAmount: TcxGridDBColumn;
    btnNewDueDate: TBitBtn;
    btnDelDueDate: TBitBtn;
    quBrowseVendorCode: TStringField;
    grdBrowseDBVendorCode: TcxGridDBColumn;
    quBrowseMarkUp: TBCDField;
    quBrowseMargin: TBCDField;
    grdBrowseDBMarkUp: TcxGridDBColumn;
    grdBrowseDBMargin: TcxGridDBColumn;
    lbOtherInCost: TLabel;
    edtOtherInCost: TEdit;
    Label27: TLabel;
    btnCalcFreight: TSpeedButton;
    btnCalcOther: TSpeedButton;
    btnPrint: TSpeedButton;
    popPrint: TPopupMenu;
    memBarcode: TMenuItem;
    memReceiving: TMenuItem;
    quBrowseSubTotalUnit: TBCDField;
    grdBrowseDBSubTotalUnit: TcxGridDBColumn;
    quBrowseActualSellingPrice: TBCDField;
    quBrowseActualCostPrice: TBCDField;
    grdBrowseDBActualCostPrice: TcxGridDBColumn;
    grdBrowseDBActualSellingPrice: TcxGridDBColumn;
    btnVerify: TSpeedButton;
    tsComplement: TTabSheet;
    scCFOP: TDBSuperComboADO;
    lblCFOP: TLabel;
    quFormIDCFOP: TIntegerField;
    quBrowseLot: TStringField;
    quBrowseUseLot: TBooleanField;
    grdBrowseDBUseLot: TcxGridDBColumn;
    grdBrowseDBLot: TcxGridDBColumn;
    quBrowseIDLote: TIntegerField;
    quBrowseUnitCostPrice: TCurrencyField;
    grdBrowseDBUnitCostPrice: TcxGridDBColumn;
    quTaxTaxExempt: TBooleanField;
    quTaxRetTaxExempt: TBooleanField;
    quBrowseDiscount: TCurrencyField;
    quBrowseDiscountRet: TCurrencyField;
    grdBrowseDBDiscount: TcxGridDBColumn;
    grdBrowseDBDiscountRet: TcxGridDBColumn;
    lbDiscount: TLabel;
    edtDiscount: TEdit;
    btnCalcDiscount: TSpeedButton;
    Label56: TLabel;
    quFormDiscount: TBCDField;
    lbDiscountRet: TLabel;
    Label57: TLabel;
    edtDiscountRet: TEdit;
    quListOpenPOs: TADODataSet;
    dspListOpenPOs: TDataSetProvider;
    cdsListOpenPOs: TClientDataSet;
    quListOpenPOsUpd: TIntegerField;
    quListOpenPOsIDPO: TIntegerField;
    quListOpenPOsmodel: TStringField;
    quListOpenPOsDescription: TStringField;
    quListOpenPOsCostPrice: TBCDField;
    quListOpenPOsNewPrice: TBCDField;
    quListOpenPOsOldPrice: TBCDField;
    quListOpenPOsIdPurchaseItem: TIntegerField;
    cdsListOpenPOsUpd: TIntegerField;
    cdsListOpenPOsIDPO: TIntegerField;
    cdsListOpenPOsmodel: TStringField;
    cdsListOpenPOsDescription: TStringField;
    cdsListOpenPOsCostPrice: TBCDField;
    cdsListOpenPOsNewPrice: TBCDField;
    cdsListOpenPOsOldPrice: TBCDField;
    cdsListOpenPOsIdPurchaseItem: TIntegerField;
    quBrowseOrdered: TBCDField;
    quBrowseCounted: TBCDField;
    grdBrowseDBCounted: TcxGridDBColumn;
    lbTotalCounted: TLabel;
    edtTotalCounted: TEdit;
    quBrowseSubTotalCounted: TBCDField;
    grdBrowseDBSubTotalCounted: TcxGridDBColumn;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure edFreightChange(Sender: TObject);
    procedure edOtherChange(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure cmbVendorSelectItem(Sender: TObject);
    procedure quFormBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quTermNewRecord(DataSet: TDataSet);
    procedure pgPurchaseChange(Sender: TObject);
    procedure grdTermKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure dsTermStateChange(Sender: TObject);
    procedure brImportClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure sbAddPOClick(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsBrowseStateChange(Sender: TObject);
    procedure menQuickEntryClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure cbPurTypeChange(Sender: TObject);
    procedure btnNewDueDateClick(Sender: TObject);
    procedure btnDelDueDateClick(Sender: TObject);
    procedure cdsDueDateNewRecord(DataSet: TDataSet);
    procedure btnCalcFreightClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure memReceivingClick(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure cbPurTypeCloseUp(Sender: TObject);
    procedure edtFreightInCostKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtOtherInCostKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbInvoiceTotalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    //Type of Purchae 1 - Pre, 2 - Final
    iPurType : Integer;
    fTaxInCost,
    fHasQuitacao : Boolean;
    fDisableFreight : Boolean;
    IsPost: Boolean;

    sQtyInfo,
    sQtyForm : string;
    FHasUpdate: Boolean;

    function IsNullToInteger(argValue: Variant): Integer;

    function OnAfterSaveChange(var iError:Integer):Boolean; override;

    function AllowUpdatePriceInOpenPOs(idmodel: Integer): boolean;
    function VerifyModelInPO: boolean;
    procedure OnCreateFicha; override;
    procedure SetSuggestFields;
    procedure RefreshForm;
    procedure DocumentSetup;
    procedure CalcTotal;
    procedure SetDocumentType;
    function ValidadeScanReceiving : Boolean;

    function GetTotalRet: Currency;
    function GetTotal: Currency;

    // Term
    procedure TermRefresh;
    procedure TermPost;
    procedure TermCancel;
    procedure TermOpen;
    procedure TermClose;

    //Tax
    procedure TaxOpen;
    procedure TaxClose;
    procedure TaxRefresh;

    procedure TaxOpenRet;
    procedure TaxCloseRet;
    procedure TaxRefreshRet;

    //DueDate
    procedure DueDateOpen;
    procedure DueDateClose;
    procedure DueDateRefresh;
    procedure GetNextDueDate(var Amount: Currency; var DueDate: TDateTime);
    function GetFirstDueDate : TDateTime;

    //Doc Type
    procedure DocTypeRefresh;

    procedure DelTerm(sIDPurchase: String);
    procedure InsTerm(sIDPurchase, sIDVendor: String);

    function CheckVendor: Boolean;
    function TestQuitacao: Boolean;

    function GetCreditTax: Currency;
    function GetCreditTaxRet: Currency;
    function CheckReturnExists: Boolean;

    function IsPastMonth: Boolean;
    procedure EnablePuchase;
    procedure UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);

    function ValidateLot : Boolean;
    function RemoveLot : Boolean;
  protected
    function OnValidadeField: boolean; override;
    procedure OnBeforeShow; override;
    procedure OnAfterUpdateNavegator; override;
    procedure OnAfterLoadFch; override;
    function OnSyncFichaToBrowseError: string; override;
  end;

implementation

{$R *.dfm}

uses uDM, uMsgBox, uFchPurchaseItem, uMsgConstant, uNumericFunctions, uSystemConst,
  uDMGlobal, uSystemTypes, uFrmImportPO, uFrmBarcodePrint, PaiDeTodos,
  uParamFunctions, uPassword, PaiDeFichas, DateUtils, uDateTimeFunctions,
  uFrmPurchaseItemQuickEntry, uContentClasses, uObjectServices,
  uFrmPurchaseCalcFreight, uFrmPrintReceiving, uFrmVerifyPO, uHandleError,
  ufrmListOPenPOs;

function TFchPurchase.OnAfterSaveChange(var iError:Integer):Boolean;
begin
  cdsDueDate.ApplyUpdates(0);

  try


    // Call Sp_PurchaseDO when Update is true meaning that Final Receiving was reached.
    if ( FHasUpdate ) then begin
        if quFormIDPurchase.AsString <> '' then
        begin
          with spPurchaseDo do
          begin
            Parameters.ParambyName('@IDPurchase').Value := quFormIDPurchase.AsString;
            Parameters.ParambyName('@Date').Value       := Now;
            Parameters.ParambyName('@TaxInCost').Value  := fTaxInCost;
            ExecProc;
            iError := Parameters.ParambyName('@RETURN_VALUE').Value;
            if iError <> 0 then
              raise Exception.Create('Stored Proc Error:'+ IntToStr(iError)+' in '+spPurchaseDO.ProcedureName);
          end;
        end;
    end;

    // Update KitModel
    if iPurType = 2 then
      with quBrowse do
      begin
        First;
        While not Eof do
        begin
          UpdateKitPromoPrice(quBrowseIDModel.AsInteger, quBrowseNewCostPrice.AsCurrency);
          Next;
        end;
      end;

    Result := True;
  Except
    on E: Exception do
    begin
      Result := False;
    end;
  end;

end;

procedure TFchPurchase.UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
var
  KitModelService: TMRKitModelService;
  KitModel: TKitModel;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := ' SELECT Qty, MarginPerc FROM KitModel WHERE IDModel = ' + IntToStr(IDModel) + ' AND ISNULL(MarginPerc, 0) <> 0 ';
    Open;

    if not(IsEmpty) then
    try
      KitModelService                  := TMRKitModelService.Create();
      KitModel                         := TKitModel.Create();

      KitModelService.SQLConnection := DM.quFreeSQL.Connection;

      First;
      While not Eof do
      begin
        // Campos necessários
        KitModel.IDModel         := IDModel;
        KitModel.Qty             := FieldByName('Qty').AsFloat;
        KitModel.SellingPrice    := DM.FDMCalcPrice.GetMarginPrice(CostPrice, FieldByName('MarginPerc').AsFloat);
        KitModel.MarginPerc      := FieldByName('MarginPerc').AsFloat;

        //Update
        KitModelService.Update(KitModel);

        Next;
      end;
    finally
     FreeAndNil(KitModel);
     FreeAndNil(KitModelService);
    end;
  finally
    Close;
  end;
end;

procedure TFchPurchase.OnCreateFicha;
begin
  brwForm := TFchPurchaseItem.Create(Self);
end;

procedure TFchPurchase.SetSuggestFields;
begin
  // Seto os filtros (suggest)
  quBrowse.AddSuggest('IDFornecedor', quFormIDFornecedor.AsString);
end;

procedure TFchPurchase.RefreshForm;
begin
  DocumentSetup;
  CalcTotal;
end;

procedure TFchPurchase.DocumentSetup;
begin
  // Coloco tudo como nao required
  quFormDocumentNumber.Required  := False;
  quFormDocumentDate.Required    := False;
  quFormDocumentDueDate.Required := False;
  quFormDocumentTotal.Required   := False;

  pnlInvoice.Visible := False;
  pnlPackSl.Visible  := False;
  pnlCOD.Visible     := False;

  case cbPurType.ItemIndex of
    0:
    begin // Invoice
      pnlInvoice.Visible := True;
      quFormDocumentNumber.Required  := True;
      quFormDocumentDate.Required    := True;
      quFormDocumentTotal.Required   := True;
    end;
    1:
    begin // Packing list
      pnlPackSl.Visible := True;
      quFormDocumentNumber.Required  := True;
    end;
    2:
    begin //C.O.D.
      pnlCOD.Visible := True;
      quFormDocumentNumber.Required  := True;
      quFormDocumentDate.Required    := True;
      quFormDocumentTotal.Required   := True;
    end;
  end;
end;

procedure TFchPurchase.CalcTotal;
var
  dSubTotal,
  dPercFreight,
  dPercOther,
  dTotal,
  dFreight,
  dOther,
  dFreightRet,
  dSubTotalRet,
  dTotalRet,
  dTotalTaxRet,
  dDiscount,
  dDiscountRet,
  dTotalTax: Currency;
  
  // Antonio 04/28/2017
  dTotalCounted, dSubTotalCounted: Currency;
begin
  dSubTotal      := 0;
  dPercOther     := 0;
  dFreight       := 0;
  dOther         := 0;
  dSubTotalRet   := 0;
  dDiscount      := 0;
  dDiscountRet   := 0;

  dSubTotalCounted := 0;

  if quForm.Active and quBrowse.Active then
  begin
    if not fTaxInCost then
    begin
      if grdBrowseDB.DataController.Summary.FooterSummaryValues[0] <> null then
        dSubTotal  := grdBrowseDB.DataController.Summary.FooterSummaryValues[0];

        dTotal := dSubTotal +
                  MyStrToFloat(edFreight.Text) +
                  MyStrToFloat(edOther.Text);

        // Antonio 04/28/2017
        if ( grdBrowseDB.DataController.Summary.FooterSummaryValues[8] <> null ) then begin
            dSubTotalCounted := grdBrowseDB.DataController.Summary.FooterSummaryValues[8];
            dTotalCounted := dSubTotalCounted + MyStrToFloat(edFreight.Text) + MyStrToFloat(edOther.Text);
        end;
    end
    else
    begin
      if grdBrowseDB.DataController.Summary.FooterSummaryValues[1] <> null then
        dSubTotal := grdBrowseDB.DataController.Summary.FooterSummaryValues[1];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[2] <> null then
        dFreight := grdBrowseDB.DataController.Summary.FooterSummaryValues[2];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[3] <> null then
        dOther := grdBrowseDB.DataController.Summary.FooterSummaryValues[3];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[4] <> null then
        dSubTotalRet := grdBrowseDB.DataController.Summary.FooterSummaryValues[4];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[5] <> null then
        dFreightRet := grdBrowseDB.DataController.Summary.FooterSummaryValues[5];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[6] <> null then
        dDiscount := grdBrowseDB.DataController.Summary.FooterSummaryValues[6];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[7] <> null then
        dDiscountRet := grdBrowseDB.DataController.Summary.FooterSummaryValues[7];




      dTotalTax := GetCreditTax;
      dTotal := dSubTotal +
                dFreight +
                dOther +
                dTotalTax -
                dDiscount;

      if Abs(dSubTotalRet) > 0 then
      begin
        TaxOpenRet;
        dTotalTaxRet := GetCreditTaxRet;
      end;

      dTotalRet := dSubTotalRet + dTotalTaxRet + dFreightRet - dDiscountRet;
    end;

    if dSubTotal <> 0 then
    begin
      dPercFreight := MyStrToFloat(edFreight.Text) / dSubTotal * 100;
      dPercOther   := MyStrToFloat(edOther.Text) / dSubTotal * 100;
    end
    else
    begin
      dPercFreight := 0;
      dPercOther   := 0;
    end;
  end
  else
  begin
    dSubTotal    := 0;
    dPercFreight := 0;
    dPercFreight := 0;
    dTotal	     := 0;
  end;

  if fTaxInCost then
  begin
    edSubTotal.Text        := FormatFloat('#,##0.00', dSubTotal);
    edtSubTotalInCost.Text := FormatFloat('#,##0.00', dSubTotal);
    edtFreightInCost.Text  := FormatFloat('#,##0.00', dFreight);
    edtTaxInCost.Text      := FormatFloat('#,##0.00', dTotalTax);
    edtTotalTaxInCost.text := FormatFloat('#,##0.00', dTotal);
    edtOtherInCost.text    := FormatFloat('#,##0.00', dOther);
    edtDiscount.Text       := FormatFloat('#,##0.00', dDiscount);

    edtFreightRet.Text     := FormatFloat('#,##0.00', dFreightRet);
    edtSubTotalRet.Text    := FormatFloat('#,##0.00', dSubTotalRet);
    edtTotalRet.Text       := FormatFloat('#,##0.00', dTotalRet);
    edtTaxRet.Text         := FormatFloat('#,##0.00', dTotalTaxRet);
    edtDiscountRet.Text    := FormatFloat('#,##0.00', dDiscountRet);
  end
  else
  begin
    edSubTotal.Text     := FormatFloat('#,##0.00', dSubTotal);
    edPercFreight.Text  := FormatFloat('#,##0.00%', dPercFreight);
    edPercOther.Text    := FormatFloat('#,##0.00%', dPercOther);
    edTotal.Text        := FormatFloat('#,##0.00', dTotal);
    edtTotalCounted.Text     := FormatFloat('#,##0.00', dTotalCounted);
  end;

  // Antonio 04/28/2017
  edtTotalCounted.Font.Color := clBlack;
  if ( (dTotal > dTotalCounted) or (dTotal < dTotalCounted) ) then begin
     edtTotalCounted.Font.Color := clRed;
  end;

end;

procedure TFchPurchase.TermRefresh;
var
  iDueDateShift: integer;
begin
  iDueDateShift := quTermDueDateShift.AsInteger;
  TermClose;
  TermOpen;
  quTerm.Locate('DueDateShift', IntToStr(iDueDateShift), [] );
  if Length(IntToStr(iDueDateShift)) > 2 then
  begin
     MsgBox(MSG_CRT_NO_VALID_DUE_DATE, vbOKOnly + vbCritical);
     grdTerm.Fields[0].FocusControl;
  end;
end;

procedure TFchPurchase.TermPost;
var
   discount: double;
   totalInvoice: double;
begin
  IsPost := False;
  with quTerm do
   if Active then
    if State in dsEditModes then
      try
        Post;
        IsPost := True;

        // Antonio 05/18/2017 - Move values to "Receiving Information" ( tab )
        dxInvoiceDate.Date := quTerm.FieldByName('DataPedido').Value;

        totalInvoice := StrToFloatDef(edTotal.Text, 0.00);
        totalInvoice := totalInvoice - ( 1 - (quTerm.FieldByName('discount').Value / 100));

        dbInvoiceTotal.Text := FormatFloat('#,##0.00', totalInvoice) ;

      except
        raise exception.Create(MSG_CRT_NO_VALID_DUE_DATE);
      end; 
end;

procedure TFchPurchase.TermCancel;
begin
  with quTerm do
    if Active then
      if State in dsEditModes then
        Cancel;
end;

procedure TFchPurchase.TermOpen;
begin
  with quTerm do
    if not Active then
      Open;
end;

procedure TFchPurchase.TermClose;
begin
  TermPost;
  quTerm.Close;
end;

procedure TFchPurchase.DelTerm(sIDPurchase:String);
begin
  try
    DM.ADODBConnect.BeginTrans;
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('DELETE Pur_PurchaseTerm');
      SQL.Add('WHERE IDPurchase = ' + sIDPurchase);
      ExecSQL;
    end;

    DM.ADODBConnect.CommitTrans;
  except
    DM.ADODBConnect.RollbackTrans;
  end;
end;

procedure TFchPurchase.InsTerm(sIDPurchase, sIDVendor:String);
begin
  try
    DM.ADODBConnect.BeginTrans;
    with DM.quFreeSQL do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('INSERT Pur_PurchaseTerm (IDPurchase, DueDateShift, Discount)');
      SQL.Add('SELECT '+sIDPurchase+', DueDateShift, Discount FROM PessoaTerm WHERE IDPessoa = ' +sIDVendor);
      ExecSQL;
    end;

    DM.ADODBConnect.CommitTrans;

  except
    DM.ADODBConnect.RollbackTrans;
  end;
end;

function TFchPurchase.CheckVendor:Boolean;
begin
  Result := True;

  with quFormIDFornecedor do
    if AsString = '' then
    begin
      MsgBox(MSG_CRT_CHOOSE_VENDOR_BEFORE, vbCritical + vbOkOnly);
      FocusControl;
      Result := False;
    end;
end;

procedure TFchPurchase.DocTypeRefresh;
begin
  if quFormDocumentType.AsString = PUR_TYPE_INVOICE then
    cbPurType.ItemIndex := 0
  else if quFormDocumentType.AsString = PUR_TYPE_PACKING_SLIP then
    cbPurType.ItemIndex := 1
  else if quFormDocumentType.AsString = PUR_TYPE_COD then
    cbPurType.ItemIndex := 2;
end;

procedure TFchPurchase.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DocTypeRefresh;
  RefreshForm;
  TermOpen;
  DueDateRefresh;
  tsReturnInfo.TabVisible := CheckReturnExists;
end;

procedure TFchPurchase.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SetSuggestFields;
  TaxRefresh;

  fHasQuitacao := (ParseParam(Self.sParam,'TemQuitacao')='1');

//  if iPurType <> PURCHASE_HISTORY then
//    btCancel.Enabled := (quBrowse.RecordCount = 0);

end;

procedure TFchPurchase.edFreightChange(Sender: TObject);
begin
  inherited;
  CalcTotal;
end;

procedure TFchPurchase.edOtherChange(Sender: TObject);
begin
  inherited;
  CalcTotal;
end;

procedure TFchPurchase.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  if quFormIDStore.AsString = '' then
    quFormIDStore.AsInteger := DM.fStore.IDStorePur;

  // Antonio 05/17/2017 - Just if "Update Button" was pressed on VerifyPO screen  
  if ( FHasUpdate ) then begin
      //Seto o User se for Final
      if (iPurType = PURCHASE_FINAL) and (quFormIDUserFinalReceiving.AsString = '') then
      begin
        quFormDateFinalReceiving.AsDateTime  := Now;
        quFormIDUserFinalReceiving.AsInteger := DM.fUser.ID;
      end;
  end;

  if not fTaxInCost then
  begin
    with quFormFreight do
      if AsString = '' then
        Value := 0;

    with quFormOtherCharges do
      if AsString = '' then
        Value := 0;
    end;
end;

procedure TFchPurchase.SetDocumentType;
begin
  with quForm do
    if Active then
      if not (State in dsEditModes) then
        Edit;

  //Os valores tem que ser colocado aqui, se nao o Office Manager nao atualiza
  case cbPurType.ItemIndex of
    0: begin // Invoice
       quFormDocumentType.AsString := PUR_TYPE_INVOICE;
       end;
    1: begin // Packing list
       quFormDocumentType.AsString := PUR_TYPE_PACKING_SLIP;
       end;
    2: begin //C.O.D.
       quFormDocumentType.AsString := PUR_TYPE_COD;
       end;
   end;
end;

procedure TFchPurchase.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  // Descobrir como saber qual browse chamou
  quFormIDUserPreReceiving.AsInteger := DM.fUser.ID;
  quFormDatePreReceiving.AsDateTime  := Now;

  quFormFreight.AsCurrency      := 0;
  quFormOtherCharges.AsCurrency := 0;
  quFormDiscount.AsCurrency     := 0;

  cbPurType.ItemIndex := -1;

  quFormDocumentNumberRet.Required  := False;
  quFormDocumentDueDateRet.Required := False;

  if (DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_PUR_DOC]) then
    quFormDocumentNumber.AsString := IntToStr(DM.GetNextID('Pur_Purchase.DocNum'));

  RefreshForm;
end;

procedure TFchPurchase.btAddClick(Sender: TObject);
begin

  if not CheckVendor then
    Exit;

  if TestQuitacao then
    Exit;

  inherited;

  quForm.Edit;
  //sbAddPO.Visible := quBrowse.IsEmpty;
  sbAddPO.Enabled := quBrowse.IsEmpty;
  tsReturnInfo.TabVisible := CheckReturnExists;

  CalcTotal;
  dsBrowseStateChange(Sender);
  
end;

procedure TFchPurchase.btRemoveClick(Sender: TObject);
begin
  if TestQuitacao then
    Exit;

  inherited;

  if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
  begin
    try
      with spRemoveItem do
      begin
        Parameters.ParambyName('@IDPurchase').Value     := quBrowseIDPurchase.AsInteger;
        Parameters.ParambyName('@IDPurchaseItem').Value := quBrowseIDPurchaseItem.AsInteger;
        Parameters.ParambyName('@TaxInCost').Value      := fTaxInCost;
        ExecProc;
      end;
      BrowseRefresh('');
      quForm.Edit;
    except
      MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbCritical + vbOkOnly);
    end;
  end;

  tsReturnInfo.TabVisible := CheckReturnExists;
  CalcTotal;
  dsBrowseStateChange(Sender);  
end;

procedure TFchPurchase.cmbVendorSelectItem(Sender: TObject);
begin
  inherited;
  SetSuggestFields;
end;

procedure TFchPurchase.quFormBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  //Pego o Purchase Type
  iPurType := StrToInt(ParseParam(Self.sParam,'PurType'));
end;

procedure TFchPurchase.FormShow(Sender: TObject);
begin
  inherited;
  //After Final Receive cannot update values
  //Should be a parameter
  //if iPurType = PURCHASE_HISTORY then
    // btClose.Enabled := False;

  //sbAddPO.Visible := ((iPurType <> PURCHASE_HISTORY) and (frmCommand = btInc));
  sbAddPO.Enabled := ((iPurType <> PURCHASE_HISTORY) and (frmCommand = btInc));
  tsTax.TabVisible := fTaxInCost;
  tsComplement.TabVisible := fTaxInCost and (DMGlobal.IDLanguage = LANG_PORTUGUESE);

  memReceiving.Enabled := (frmCommand <> btInc);

  if fDisableFreight then
  begin
    btnCalcFreight.Enabled      := True;
    btnCalcOther.Enabled        := False;
    quFormFreight.ReadOnly      := True;
    quFormOtherCharges.ReadOnly := True;
    edFreight.Color             := clSilver;
    edOther.Color               := clSilver;
  end;

  if fTaxInCost then
  begin
    edFreight.ReadOnly := True;
    edOther.ReadOnly   := True;
    edFreight.Color    := clSilver;
    edOther.Color      := clSilver;
  end;

  if fIsRestricForm then
  begin
    btNew.Visible        := False;
    btDelete.Visible     := False;
    btPost.Visible       := False;
    btCancelPost.Visible := False;
    brImport.Visible     := False;
    cmbVendor.TabStop    := False;
    sbAddPO.Enabled      := False;
    edSubTotal.SetFocus;
  end;

  // Set Packing Slip how a default identification to Pre-Receiving.
  if ( iPurType = PURCHASE_PRE ) then begin
     cbPurType.ItemIndex := cbPurType.Items.IndexOf('Packing Slip');
     cbPurTypeChange(self);
     pgPurchase.ActivePage := tsPurchaseInfo;
  end else if (iPurType = PURCHASE_FINAL ) then begin

          // Antonio 05/19/2017 - Fill Vendor Terms from Vendor Settings
          brImportClick(sender);
          TermRefresh;

          if ( not quForm.FieldByName('IDPO').IsNull ) then begin
             // Filter to select vendor terms, given a PO identification
//             quTerm.Filter := 'IdPurchase = ' + quForm.FieldByName('IdPurchase').AsString;
//             quTerm.Filtered := True;
             pgPurchase.ActivePage := tsPurchaseInfo;

          end else begin
                  quTerm.Filtered := False;
                  pgPurchase.ActivePage := tsVendorTerm;
              end;
      end;

end;

procedure TFchPurchase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: //Add New
    begin
      with quFormIDFornecedor do
        if AsString = '' then
        begin
          MsgBox(MSG_CRT_CHOOSE_VENDOR_BEFORE, vbCritical + vbOkOnly);
          FocusControl;
          Exit;
        end;
    end;

    VK_F4: //Del
    begin
      if btRemove.Enabled then
        btRemoveClick(nil);
    end;
  end;

  inherited;
end;

procedure TFchPurchase.quTermNewRecord(DataSet: TDataSet);
begin
  inherited;
  quTermIDPurchase.AsInteger := quFormIDPurchase.AsInteger;
  quTermDiscount.AsInteger   := 0;
end;

procedure TFchPurchase.pgPurchaseChange(Sender: TObject);
begin
  inherited;
  if pgPurchase.ActivePage = tsVendorTerm then
    TermOpen
  else if pgPurchase.ActivePage = tsTax then
    TaxRefresh;
end;

procedure TFchPurchase.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) {and (grdTerm.FocusedField = quTermDiscount)} then
    btPostClick(nil);
end;

procedure TFchPurchase.btNewClick(Sender: TObject);
begin
  inherited;
  quTerm.Insert;
  grdTerm.SetFocus;
  grdTerm.Fields[0].FocusControl;
end;

procedure TFchPurchase.btDeleteClick(Sender: TObject);
begin
  inherited;
  quTerm.Delete;
  dsTermStateChange(Nil);
end;

procedure TFchPurchase.btPostClick(Sender: TObject);
begin
  inherited;
  TermPost;
  if (IsPost) then begin
     TermRefresh;
     pgPurchase.ActivePage := tsPurchaseInfo;
  end;
end;

procedure TFchPurchase.dsTermStateChange(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
    Exit;

  btNew.Enabled := quTerm.Active;

  with quTerm do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quTerm.State in dsEditModes);
  btDelete.Visible := not (quTerm.State in dsEditModes);

  btPost.Visible := (quTerm.State in dsEditModes);
  btCancelPost.Visible := (quTerm.State in dsEditModes);
end;

procedure TFchPurchase.brImportClick(Sender: TObject);
begin
  inherited;
  //Deleta o termo do old vendor
  DelTerm(quFormIDPurchase.AsString);

  //Insert o termo do novo vendor
  InsTerm(quFormIDPurchase.AsString, cmbVendor.LookUpValue);

  //Atualizo o IDForn
  TermRefresh;
end;

procedure TFchPurchase.btDetailClick(Sender: TObject);
var
  Qty : Double;
begin
  if TestQuitacao then
    Exit;

  //Insert qty only
  if (iPurType = PURCHASE_PRE) and (not Password.HasFuncRight(49)) then
     begin
     Qty := StrToFloatDef(InputBox(sQtyForm, sQtyInfo, '0.0'), 0);
     if Qty <= 0 then
        Exit;
     //Update Quantity
     DM.RunSQL('UPDATE Pur_PurchaseItem SET Qty = ' + FloatToStr(Qty)+ ' WHERE IDPurchaseItem = ' + quBrowseIDPurchaseItem.AsString);
     BrowseRefresh(quBrowseIDPurchaseItem.AsString);
     end
  else
  begin
    inherited;
    brwForm.quForm.Parameters.Items[0].Value := 0;
  end;

  quForm.Edit;
  tsReturnInfo.TabVisible := CheckReturnExists;
  CalcTotal;
end;

procedure TFchPurchase.sbAddPOClick(Sender: TObject);
var
  PayDays, IDPO : Integer;
begin
  inherited;
  if not CheckVendor then
    Exit;

  //Add Po Info
  with TFrmImportPO.Create(Self) do
    if Start(quFormIDFornecedor.AsInteger,
             quFormIDStore.AsInteger,
             quFormIDPurchase.AsInteger,
             fTaxInCost, PayDays, IDPO) then
    begin
      quForm.Edit;
      quFormPayDays.AsInteger := PayDays;
      quFormIDPO.AsInteger    := IDPO;
      BrowseRefresh('');
      dsBrowseStateChange(Self);
      CalcTotal;
      sbAddPO.Enabled := False;
    end;

end;

procedure TFchPurchase.btnPrintBarcodeClick(Sender: TObject);
begin
  inherited;   
  //Print Barcode
  with TFrmBarcodePrint.Create(Self) do
    StartPurchase(quFormIDPurchase.AsString);
end;

procedure TFchPurchase.TaxClose;
begin
  with quTax do
    if Active then
      Close;
end;

procedure TFchPurchase.TaxOpen;
begin
  with quTax do
    if not Active then
    begin
      Parameters.ParamByName('IDPurchase').Value := quFormIDPurchase.AsInteger;
      Open;
    end;
end;

procedure TFchPurchase.TaxRefresh;
begin
  TaxClose;
  TaxOpen;
end;

procedure TFchPurchase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TermClose;
  TaxClose;
end;

function TFchPurchase.TestQuitacao: Boolean;
begin
  if fHasQuitacao then
    MsgBox(MSG_CRT_PURCHASE_HAS_PAYMENT, vbCritical + vbOkOnly);
  Result := fHasQuitacao;
end;

function TFchPurchase.GetCreditTax:Currency;
begin
  Result := 0;

  with quTax do
    if Active then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if (not quTaxDebit.AsBoolean) and (not quTaxTaxExempt.AsBoolean) then
          Result := Result + quTaxTaxValue.AsCurrency;
        Next;
      end;
    finally
      EnableControls;
    end;
end;

procedure TFchPurchase.dsBrowseStateChange(Sender: TObject);
begin
  inherited;
  //can update price
  if (iPurType = PURCHASE_PRE) and (not Password.HasFuncRight(49)) then
  begin
    btAdd.Enabled := False;
    menAdd.Enabled := False;
    menQuickEntry.Enabled := False;
  end
  else if (iPurType = PURCHASE_HISTORY) then
    EnablePuchase;

end;

function TFchPurchase.OnValidadeField: boolean;
var
  bValue : Boolean;
  iDays : Integer;
  TotalAmount : Currency;
  NextDueDate : TDateTime;
  FirstDueDate : TDateTime;
begin
  bValue := False;

  Result := True;

  if (quFormPayDays.AsInteger <> 0) and (cbPurType.ItemIndex = 0) then
  begin
    FirstDueDate := GetFirstDueDate;

    if (quFormDocumentDate.AsString <> '') and (FirstDueDate <> 0) then
    begin
      iDays := (DaysBetween(quFormDocumentDate.AsDateTime, FirstDueDate)+1);

      if (iDays < quFormPayDays.AsInteger) then
        Result := (MsgBox(Format(MSG_QST_PAY_PURCHASE_DAYS, [quFormPayDays.AsInteger, iDays]), vbQuestion + vbYesNo) = vbYes);

      if not Result then
        Exit;

    end;
  end;

  GetNextDueDate(TotalAmount, NextDueDate);

  if cbPurType.ItemIndex = 0 then begin
    {
    if quFormDocumentTotal.AsCurrency <> GetTotal then
    begin
      MsgBox(MSG_INF_TOTAL_DIFFERENT_PUR, vbCritical + vbOkOnly);
      Result := False;
    end
    else

    if (quFormDocumentTotal.AsCurrency - GetTotalRet) <> TotalAmount then
    begin
      MsgBox(MSG_CRT_DUETOTAL_DIFFERENT_PUR, vbCritical + vbOkOnly);
      Result := False;
      Exit;
    end;
    }

    if (quFormDocumentNumber.AsString <> '') and (quFormIDFornecedor.AsString <> '') then
    begin
      with DM.quFreeSQL do
      begin
        SQL.Clear;
        SQL.Add('SELECT IDPurchase');
        SQL.Add('FROM Pur_Purchase');
        SQL.Add('WHERE IDFornecedor = ' + quFormIDFornecedor.AsString);
        SQL.Add('AND IDPurchase <> ' + quFormIDPurchase.AsString);
        SQL.Add('AND DocumentNumber = ' + QuotedStr(quFormDocumentNumber.AsString));
        try
          Open;
          bValue := not IsEmpty;
        finally
          Close;
        end;
      end;

      if bValue then
        if (MsgBox(MSG_CRT_EXIST_NUMBER, vbQuestion + vbYesNo) = vbNo) then
        begin
          Result := False;
          Exit;
        end;
    end;
  end;

  if not ValidateLot then
  begin
    Result := False;
    Exit;
  end;

end;

function TFchPurchase.CheckReturnExists: Boolean;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := DM.ADODBConnect;
    SQL.Clear;
    SQL.Add(Format('SELECT IDPurchase FROM Pur_PurchaseItem WHERE QtyRet <> 0 AND IDPurchase = %D', [quFormIDPurchase.AsInteger]));
    Open;
    Result := not (BOF and EOF);

    quFormDocumentNumberRet.Required  := Result;
    quFormDocumentDueDateRet.Required := Result;
  finally
    Close;
    Free;
  end;
end;

function TFchPurchase.GetCreditTaxRet: Currency;
begin
  Result := 0;

  with quTaxRet do
    if Active then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if (not quTaxRetDebit.AsBoolean) and (not quTaxRetTaxExempt.AsBoolean) then
          Result := Result + quTaxRetTaxValue.AsCurrency;
        Next;
      end;
    finally
      EnableControls;
    end;
end;

procedure TFchPurchase.TaxCloseRet;
begin
  with quTaxRet do
    if Active then
       Close;
end;

procedure TFchPurchase.TaxOpenRet;
begin
  with quTaxRet do
    if not Active then
       begin
       Parameters.ParamByName('IDPurchase').Value := quFormIDPurchase.AsInteger;
       Open;
       end;

end;

procedure TFchPurchase.TaxRefreshRet;
begin
   TaxCloseRet;
   TaxOpenRet;
end;

function TFchPurchase.IsPastMonth: Boolean;
var
  fAlterBackMonth : Integer;
  fDate : TDateTime;
begin

  fAlterBackMonth := DM.fSystem.SrvParam[PARAM_PURCHASE_HIST_BACK_MONTH];

  fDate := IncMonth(Now, - fAlterBackMonth);

  Result := InicioDoMes(Trunc(quFormDateFinalReceiving.AsDateTime)) < InicioDoMes(Trunc(fDate));
end;

procedure TFchPurchase.EnablePuchase;
begin
  if (iPurType = PURCHASE_HISTORY) and IsPastMonth then
  begin
    btClose.Enabled       := False;
    btAdd.Enabled         := False;
    btRemove.Enabled      := False;
    menAdd.Enabled        := False;
    menQuickEntry.Enabled := False;
  end
  else
  begin
   if not btAdd.Enabled then
   begin
      btAdd.Enabled         := True;
      menAdd.Enabled        := True;
      menQuickEntry.Enabled := True;
   end;
   if not btClose.Enabled then
      btClose.Enabled := True;
  end;

end;

procedure TFchPurchase.OnBeforeShow;
begin
  inherited;
  EnablePuchase;
  pnlTaxInCost.Visible := fTaxInCost;
end;

procedure TFchPurchase.menQuickEntryClick(Sender: TObject);
begin
  inherited;

  if not CheckVendor then
     Exit;

  if TestQuitacao then
     Exit;

  with TFrmPurchaseItemQuickEntry.Create(Self) do
  try
    Start(quForm.FieldByName('IDPurchase').AsInteger,
      quForm.FieldByName('IDFornecedor').AsInteger, cmbVendor.Text);
    BrowseRefresh('');
  finally
    Free;
  end;

end;

procedure TFchPurchase.btnAddQuickClick(Sender: TObject);
var
  P : TPoint;
begin
  inherited;
  GetCursorPos(P);
  popNew.Popup(P.X, P.Y);
end;

procedure TFchPurchase.cbPurTypeChange(Sender: TObject);
begin
  inherited;
  DocumentSetup;
  SetDocumentType;
end;

procedure TFchPurchase.DueDateClose;
begin
  with cdsDueDate do
    if Active then
      Close;
end;

procedure TFchPurchase.DueDateOpen;
begin
  with cdsDueDate do
    if not Active then
    begin
      FetchParams; 
      Params.ParamByName('IDPurchase').Value := quFormIDPurchase.AsInteger;
      Open;
    end;
end;

procedure TFchPurchase.DueDateRefresh;
begin
  DueDateClose;
  DueDateOpen;
end;

procedure TFchPurchase.btnNewDueDateClick(Sender: TObject);
var
  TotalAmount: Currency;
  NextDueDate: TDateTime;
begin
  inherited;
  if TestQuitacao then
     Exit;

  if (quFormDocumentTotal.AsCurrency = 0) then
  begin
    MsgBox(MSG_INF_TOTAL_ZERO, vbCritical + vbOkOnly);
    Exit;
  end;

  if cbPurType.ItemIndex = 0 then
  begin
    GetNextDueDate(TotalAmount, NextDueDate);

    with cdsDueDate do
    begin
      if not Active then
        Open;
      Append;
      FieldbyName('Amount').AsCurrency := (quFormDocumentTotal.AsCurrency - GetTotalRet) - TotalAmount;
      FieldbyName('Date').AsCurrency := NextDueDate;
    end;
  end;
end;

procedure TFchPurchase.btnDelDueDateClick(Sender: TObject);
begin
  inherited;

  if TestQuitacao then
     Exit;

  if cdsDueDate.RecNo <> 0 then
  begin
    cdsDueDate.Edit;
    cdsDueDate.Delete;
  end;

end;

procedure TFchPurchase.cdsDueDateNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsDueDate.FieldByName('IDPurchaseDueDate').AsInteger := DM.GetNextID('Pur_PurchaseDueDate.IDPurchaseDueDate');
  cdsDueDate.FieldByName('IDPurchase').AsInteger        := quFormIDPurchase.AsInteger;
end;

function TFchPurchase.GetFirstDueDate : TDateTime;
begin

  Result := 0;

  if cbPurType.ItemIndex = 0 then
  begin
    with cdsDueDate do
    try
      DisableControls;

      if not Active then
         Open;

      if not IsEmpty then
      begin
        First;
        Result := cdsDueDate.FieldbyName('Date').AsDateTime;
      end;
      
    finally
      EnableControls;
    end;
  end;

end;

procedure TFchPurchase.GetNextDueDate(var Amount:Currency; var DueDate: TDateTime);
begin
  Amount  := 0;
  DueDate := Now;

  if cbPurType.ItemIndex = 0 then
  begin
    with cdsDueDate do
    try
      DisableControls;

      if not Active then
         Open;
      First;
      while not EOF do
      begin
        Amount := Amount + cdsDueDate.FieldbyName('Amount').AsCurrency;
        Next;
        if EOF then
          DueDate := IncMonth(cdsDueDate.FieldbyName('Date').AsDateTime, 1);
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TFchPurchase.GetTotal: Currency;
var
  dPercOther,
  dPercFreight: Double;
  cFreight,
  cFreightRet,
  cOther,
  cSubTotalRet,
  cSubTotal,
  cTotalTax,
  cTotalTaxRet,
  cTotalRet,
  cTotal: Currency;
begin
  cSubTotal      := 0;
  dPercOther     := 0;
  cFreight       := 0;
  cOther         := 0;
  cSubTotalRet   := 0;

  if quForm.Active and quBrowse.Active then
  begin
    if not fTaxInCost then
    begin
      if grdBrowseDB.DataController.Summary.FooterSummaryValues[0] <> null then
        cSubTotal  := grdBrowseDB.DataController.Summary.FooterSummaryValues[0];

        cTotal := cSubTotal +
                  MyStrToFloat(edFreight.Text) +
                  MyStrToFloat(edOther.Text);
    end
    else
    begin
      if grdBrowseDB.DataController.Summary.FooterSummaryValues[1] <> null then
        cSubTotal := grdBrowseDB.DataController.Summary.FooterSummaryValues[1];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[2] <> null then
        cFreight := grdBrowseDB.DataController.Summary.FooterSummaryValues[2];

      if grdBrowseDB.DataController.Summary.FooterSummaryValues[3] <> null then
        cOther := grdBrowseDB.DataController.Summary.FooterSummaryValues[3];

      cTotalTax := GetCreditTax;
      cTotal := cSubTotal +
                cFreight +
                cOther +
                cTotalTax;

      cTotalRet := GetTotalRet;
    end;

    if cSubTotal <> 0 then
    begin
      dPercFreight := MyStrToFloat(edFreight.Text) / cSubTotal * 100;
      dPercOther   := MyStrToFloat(edOther.Text) / cSubTotal * 100;
    end
    else
    begin
      dPercFreight := 0;
      dPercOther   := 0;
    end;
  end
  else
  begin
    cSubTotal    := 0;
    dPercFreight := 0;
    dPercFreight := 0;
    cTotal	     := 0;
  end;

  Result := cTotal;
end;

function TFchPurchase.GetTotalRet: Currency;
var
  dFreightRet,
  dSubTotalRet,
  dTotalTaxRet: Double;
begin
  Result := 0;
  dSubTotalRet := 0;

  if quForm.Active and quBrowse.Active then
  begin
    if grdBrowseDB.DataController.Summary.FooterSummaryValues[4] <> null then
      dSubTotalRet := grdBrowseDB.DataController.Summary.FooterSummaryValues[4];

    if grdBrowseDB.DataController.Summary.FooterSummaryValues[5] <> null then
      dFreightRet := grdBrowseDB.DataController.Summary.FooterSummaryValues[5];

    if Abs(dSubTotalRet) > 0 then
    begin
      TaxOpenRet;
      dTotalTaxRet := GetCreditTaxRet;
    end;

    Result := dSubTotalRet + dTotalTaxRet + dFreightRet;
  end;
end;

procedure TFchPurchase.btnCalcFreightClick(Sender: TObject);
begin
  inherited;

  if not quBrowse.IsEmpty then
    with TFrmPurchaseCalcFreight.Create(Self) do
      if Start(quFormIDPurchase.AsInteger, MyStrToMoney(edSubTotal.Text)) then
      begin
        BrowseRefresh('');
        RefreshForm;
      end;
      
end;

procedure TFchPurchase.btnPrintClick(Sender: TObject);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  popPrint.Popup(P.X, P.Y);
end;

procedure TFchPurchase.memReceivingClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintReceiving.Create(Self) do
    Start(quFormIDPurchase.AsString);
end;

procedure TFchPurchase.scStoreSelectItem(Sender: TObject);
begin
  inherited;
  if quFormIDStore.AsInteger <> DM.fStore.IDStorePur then
    if not (MsgBox(MSG_QST_RECEIVING_OTHER_STORE, vbYesNo + vbSuperCritical) = vbYes) then
      scStore.LookUpValue := IntToStr(DM.fStore.IDStorePur);
end;

procedure TFchPurchase.grdBrowseDBDblClick(Sender: TObject);
begin

  btDetailClick(nil);

end;

procedure TFchPurchase.OnAfterUpdateNavegator;
begin
  inherited;

end;

procedure TFchPurchase.OnAfterLoadFch;
begin
  inherited;

  brwForm.sParam := 'IDStore=' + quFormIDStore.AsString +';';

  if (iPurType = PURCHASE_HISTORY) and IsPastMonth then
    brwForm.sParam := brwForm.sParam + 'disable=1;'
  else
    brwForm.sParam := brwForm.sParam + 'disable=0;';

  if (iPurType = PURCHASE_HISTORY) then
    brwForm.sParam := brwForm.sParam + 'history=1;'
  else
    brwForm.sParam := brwForm.sParam + 'history=0;';
end;

procedure TFchPurchase.btnVerifyClick(Sender: TObject);
var
  sID : String;
  iSPError : integer;
  RetornoProc : Boolean;

  _isInvoicePresent: Boolean;

begin
    inherited;

    FHasUpdate := false;

    if ( TestOnEditModes ) then begin

        if ( quForm.State in dsEditModes ) then begin
          quForm.UpdateRecord; // Force pending updates
        end;

        if not (OnValidadeField and TestFieldFill and TestFieldUnique) then begin
          Exit;
        end;


        if not SaveChange then begin
          Exit
        end else begin
              Try
                RetornoProc := OnAfterSaveChange(iSPError);
              Finally
                if not RetornoProc then
                  begin
                    PushError(CRITICAL_ERROR, 'ParentFch.SaveChange.Exception' + #13#10 + 'Result False');
                    ShowMessage('Stored Proc error:'+ IntToStr(iSPError));
                  end;
              End;
            end;

    end;

    _isInvoicePresent:= ( (cbPurType.ItemIndex = 0) and (dbedInvoice.Text <> '' ) );

    if CheckVendor then begin
      if ValidadeScanReceiving then begin
        with TFrmVerifyPO.Create(Self) do begin
          SetcountModel(dsBrowse.DataSet.RecordCount);

          FHasUpdate := Start( quFormIDPurchase.AsInteger, quFormIDFornecedor.AsInteger, _isInvoicePresent, iPurtype );

          if ( FHasUpdate) then begin
            quForm.Edit;
            dsBrowseStateChange(Self);
            CalcTotal;
            BrowseRefresh('');
          end;

          BrowseRefresh('');
          CalcTotal();

        end;
      end; // end if ( validadeScanReceiving)
  end; // end if ( check vendor )

end;

function TFchPurchase.ValidadeScanReceiving: Boolean;
var
  sSQL, sModels : String;
begin
  Result := False;

  sSQL := ' SELECT	I1.IDModel, M.Model ' +
          ' FROM Pur_PurchaseItem I1 ' +
          ' JOIN Pur_PurchaseItem I2 ON (I1.IDModel = I2.IDModel) ' +
          ' JOIN Model M ON (I1.IDModel = M.IDModel) ' +
          ' WHERE I1.IDPurchase = ' + quFormIDPurchase.AsString + ' AND I2.IDPurchase = ' + quFormIDPurchase.AsString +
          ' GROUP BY I1.IDModel, M.Model ' +
          ' HAVING  Count(I1.IDModel) > 1 ';

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(sSQL);
    Open;
    Result := IsEmpty;
    if not Result then
    begin
      First;
      while not EOF do
      begin
        sModels := sModels + FieldByName('Model').AsString + '; ';
        Next;
      end;
      MsgBox(MSG_CRT_RECEIVING_VALIDATE + sModels, vbCritical + vbOkOnly);
    end;
  finally
    Close;
  end;

end;

procedure TFchPurchase.btCloseClick(Sender: TObject);
begin

  if (iPurType = PURCHASE_HISTORY) then
    if MsgBox(MSG_QST_RECEIVING_HISTORY, vbYesNo + vbSuperCritical) = vbNo then
      Exit;

  //amfsouza 02.06.2011 - verify open PO's to update price.
  if ( iPurType = PURCHASE_FINAL ) then
     if ( not VerifyModelInPO ) then
        exit;

(*  under test
  if ( FHasUpdate ) then begin
     inherited;
  end;
  *)
  inherited;

end;

procedure TFchPurchase.FormCreate(Sender: TObject);
begin
  inherited;

  fTaxInCost      := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
  fDisableFreight := DM.fSystem.SrvParam[PARAM_DISABLE_FREIGHT_OTHERCOST];
  fHasQuitacao    := False;

  //btnVerify.Visible := not fTaxInCost;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sQtyForm := 'Enter quantity';
      sQtyInfo := 'New qty :';
      sUrlHelp := '';
      sUrlVideo:= '';
    end;

    LANG_PORTUGUESE:
    begin
      sQtyForm := 'Informar a nova quantidate';
      sQtyInfo := 'Nova qtd :';
      sUrlHelp := 'http://www.mainretail.com.br/treinamento/Compras/Com_NovoRecebimento.htm';
      sUrlVideo:= 'http://www.mainretail.com.br/treinamento/video/OC_Criando_Novo_Recebimento/Criando_um_Novo_Recebimento.htm';
    end;

    LANG_SPANISH:
    begin
      sQtyForm := 'Informe la cantidad nueva';
      sQtyInfo := 'Nueva ctd :';
      sUrlHelp := '';
      sUrlVideo:= '';
    end;
  end;

end;

function TFchPurchase.ValidateLot: Boolean;
var
  bLotControl : Boolean;
  sModels : String;
begin

  Result := True;
  sModels := '';

  bLotControl := DM.fSystem.SrvParam[PARAM_USE_LOT_CONTROL];

  with DM.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT M.Model');
    SQL.Add('FROM Pur_PurchaseItem PUI');
    SQL.Add('JOIN Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)');
    SQL.Add('WHERE PUI.IDPurchase = ' + quFormIDPurchase.AsString);
    SQL.Add('AND M.UseLot = 1 AND PUI.IDLote IS NULL');
    try
      Open;
      if not IsEmpty then
      begin
        First;
        While not EOF do
        begin
          sModels := sModels + FieldByName('Model').AsString + '; ';
          Next;
        end;
      end;
    finally
      Close;
    end;
  end;

  if sModels <> '' then
    if bLotControl then
    begin
      MsgBox(Format(MSG_CRT_MODEL_WITHOUT_LOT, [sModels]), vbOKOnly + vbCritical);
      Result := False;
    end
    else
    begin
      if MsgBox(Format(MSG_QST_MODEL_LOT, [sModels]), vbYesNo + vbQuestion) = vbYes then
        Result := True
      else
        Result := False;
    end;

end;

procedure TFchPurchase.btCancelClick(Sender: TObject);
begin

  if (frmCommand <> btInc) and TestOnEditModes then
    if (MsgBox(MSG_QST_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbNo) then
      Exit;

  if (frmCommand = btInc) then
    RemoveLot;

  inherited;

end;

function TFchPurchase.RemoveLot: Boolean;
begin

  Result := False;

  try

    with quBrowse do
      if Active and (not IsEmpty) then
      Try
        DisableControls;
        First;
        while not Eof do
        begin
          if FieldByName('IDLote').AsInteger <> 0 then
            DM.FDMInventory.LotAdjust(FieldByName('IDModel').AsInteger,
                                      quFormIDStore.AsInteger,
                                      FieldByName('IDLote').AsInteger,
                                      FieldByName('Qty').AsFloat, 3);

          Next;
        end;
      finally
        EnableControls;
      end;

  Result := True;
  
  except
    on E : Exception do
    begin
      Result := False;
    end;
  end;

end;

procedure TFchPurchase.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  if fTaxInCost then
  begin
    if quBrowseQty.AsFloat <> 0 then
      quBrowseUnitCostPrice.AsCurrency := (quBrowseCostPrice.AsCurrency / quBrowseQty.AsFloat)
    else
      quBrowseUnitCostPrice.AsCurrency := 0;
  end
  else
    quBrowseUnitCostPrice.AsCurrency := quBrowseNewCostPrice.AsCurrency;
end;

function TFchPurchase.OnSyncFichaToBrowseError: string;
var
  Error : String;
  sSQL : String;
begin
   Error := inherited OnSyncFichaToBrowseError;

   if Error = 'Divide by zero error encountered' then
     if MsgBox('Fix issue?', vbYesNo + vbQuestion) = vbYes then
     begin
       sSQL := 'UPDATE Pur_PurchaseItem SET Qty = 1 ' +
               'WHERE IDPurchase = '+ IntToStr(quForm.Parameters[0].Value) +' and IsNull(Qty, 0) = 0';
       DM.RunSQL(sSQL);
       MsgBox('Issue fixed!_Please, re-open receiving again!', vbOKOnly + vbInformation);
     end;

end;


function TFchPurchase.AllowUpdatePriceInOpenPOs(idmodel: Integer): boolean;
var
   qUpdatePricePO: TADOQuery;
   sql: String;
   cdsVersionType: TClientDataset;
begin
   sql :=
         'select PO.Aberto, '+
         ' PO.DataPedido,   '+
         ' PO.IDPO,         '+
         ' m.IDModel,                     '+
         ' m.Model,         '+
         ' m.Description,    '+
         ' m.sellingPrice as NewPrice,    '+
         ' ppi.NewSalePrice as OldPrice,  '+
         ' ppi.NewCostPrice as CostPrice, '+
         ' ppi.IdPurchaseItem ' +
         'from   PO                          '+
         ' join Pur_Purchase pp on PO.IDPO = pp.IDPO and PO.IDFornecedor = pp.IDFornecedor '+
         ' join Pur_PurchaseItem ppi on pp.IDPurchase = ppi.IDPurchase and pp.IDFornecedor = ppi.IDFornecedor '+
         ' join Model m on ppi.IdModel = m.IdModel ' +
         'where  ppi.idmodel = :idmodel '+
         ' and   PO.Aberto = 1           ' +
         ' and m.SellingPrice <> ppi.NewSalePrice ';

   qUpdatePricePO := TADOQuery.create(nil);
   qUpdatePricePO.Connection := Dm.ADODBConnect;
   qUpdatePricePO.SQL.Text := sql;
   qUpdatePricePO.Parameters.ParamByName('idmodel').Value := IdModel;
   qUpdatePricePO.Open;

   cdsVersionType := dm.searchSysModule();

   if ( not qUpdatePricePO.IsEmpty ) then begin
       while ( not qUpdatePricePO.Eof ) do begin
          cdsListOpenPos.Insert;
          cdsListOpenPOs.FieldByName('Upd').Value            := 0;
          cdsListOPenPOs.FieldByName('IdPO').Value           := qUpdatePricePO.fieldbyname('IdPO').Value;
          cdsListOPenPOs.FieldByName('Model').Value          := qUpdatePricePO.fieldByName('Model').Value;
          cdsListOpenPOs.FieldByName('Description').Value    := qUpdatePricePO.fieldByName('Description').Value;
          cdsListOpenPOs.FieldByName('CostPrice').Value      := qUpdatePricePO.fieldByName('CostPrice').Value;
          cdsListOPenPOs.FieldByName('NewPrice').Value       := qUpdatePricePO.fieldByName('NewPrice').Value;
          cdsListOPenPOs.FieldByName('OldPrice').Value       := qUpdatePricePO.fieldByName('OldPrice').Value;
          cdsListOpenPOs.FieldByName('IdPurchaseItem').Value := qUpdatePricePO.fieldByName('IdPurchaseItem').Value;
          cdsListOPenPOs.Post;
          qUpdatePricePO.Next;
       end;
       result := true;
   end;
end;

function TFchPurchase.VerifyModelInPO: boolean;
var
   askToOpenPOs: boolean;
   frmListOpenPOs: TfrmListOpenPOs;
begin
   result := true;
   askToOPenPOs := true;
   dsBrowse.DataSet.DisableControls;
   cdsListOpenPOs.Open;

   while ( not dsBrowse.DataSet.Eof ) do begin
      if ( askToOpenPos ) then
         askToOpenPOs := AllowUpdatePriceInOpenPOs(dsBrowse.DataSet.fieldByname('IdModel').Value)
      else
         break;

      dsBrowse.DataSet.Next;
   end;

   if ( askToOpenPOs ) then begin
      frmListOpenPOs := TfrmListOpenPOs.Create(Self);
      frmListOPenPOs.cdsList := cdsListOpenPOs;
      if frmListOpenPOs.ShowModal = mrOK then
         result := true
      else
         result := false;
   end;

   dsBrowse.DataSet.First;
   dsBrowse.DataSet.EnableControls;
end;

procedure TFchPurchase.cbPurTypeCloseUp(Sender: TObject);
var
  _invoiceDate: TDateTime;
  _invoiceDueDate: TDateTime;
  _invoiceDueTotal: Currency;
  _invoiceTotal: Currency; 
begin
  inherited;
// Antonio 05/22/2017 - To auto-complete fields based on default settings

  if ( cbPurType.ItemIndex = cbPurType.Items.IndexOf('Invoice') ) then  begin
     dbedInvoice.Clear();

     // Antonio 05/19/2017: auto-complete Due Date and Total Invoice
     if ( not quForm.FieldByName('DateFinalReceiving').IsNull ) then begin
        _invoiceDate := quForm.FieldByName('DateFinalReceiving').Value;
        _invoiceDueDate := quForm.FieldByName('DateFinalReceiving').Value + IsNullToInteger(quTerm.FieldByName('DueDateShift').Value);
     end else begin
            _invoiceDate := now;
            _invoiceDueDate := now + IsNullToInteger(quTerm.FieldByName('DueDateShift').Value);
         end;


      if ( not quFormDocumentTotal.IsNull ) then begin
         _invoiceTotal := StrToFloat(quFormDocumentTotal.CurValue);
      end else begin
               _invoiceTotal := 0;
          end;

      if ( not (quForm.State in dsEditModes) ) then begin
          quForm.edit;
      end;

      quFormDocumentDate.Value := _invoiceDate;
      quFormDocumentTotal.Value := _invoiceTotal;

      _InvoiceDueTotal := (StrToFloatDef(dbInvoiceTotal.Text, 0.00) * ( 1 - (quTermDiscount.Value / 100)));

      if ( quDueDate.IsEmpty ) then begin
          //btnNewDueDateClick(sender);
          if TestQuitacao then
             Exit;

          if ( not cdsDueDate.Active ) then begin
             cdsDueDate.Open();
          end;

          cdsDueDate.Append;
          cdsDueDateNewRecord(cdsDueDate);

          cdsDueDate.FieldByName('Date').Value := _invoiceDueDate;
          cdsDueDate.FieldByName('Amount').Value := _invoiceDueTotal;

          cdsDueDate.Post;

          if (quFormDocumentTotal.AsCurrency = 0) then
          begin
            MsgBox(MSG_INF_TOTAL_ZERO, vbCritical + vbOkOnly);
            Exit;
          end;


      end;

  end;


end;

procedure TFchPurchase.edtFreightInCostKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if ( key = VK_RETURN ) then begin
     cbPurTypeCloseUp(sender);
  end;

end;

procedure TFchPurchase.edtOtherInCostKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if ( key = VK_RETURN ) then begin
     cbPurTypeCloseUp(sender);
  end;

end;

procedure TFchPurchase.dbInvoiceTotalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if ( key = VK_RETURN ) then begin
     cdsDueDate.Params.ParamByName('IDPurchase').AsInteger        := quFormIDPurchase.AsInteger;
     cdsDueDate.Open();
     cdsDueDate.First;
     cdsDueDate.Delete();
     cbPurTypeCloseUp(sender);
  end;

end;

function TFchPurchase.IsNullToInteger(argValue: Variant): Integer;
begin
   if ( argValue = NULL ) then begin
       result := 0
   end else begin
           result := argValue;
       end;

end;

end.
