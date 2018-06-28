(*
-----------------------------------------------------------------------------------------------------

Version : (288 - 281)
Date    : 02.17.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : CaseQty clean it self.
Solution: I must clean itself if state in edit model and user typed value less
          less than 2.
Version : (288 - 282)
-----------------------------------------------------------------------------------------------------

Version : (287 - 275)
Date    : 12.02.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : After press update button, must be disabled barcode, remove button and itself.
Solution: Implemented function to verify if update button had been pressed.
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------
*)

unit ufrmModelAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  DBCtrls, Mask, SuperComboADO, ADODB, DB, DBClient, uInventoryCalc, uDMInventory,
  uContentClasses, uObjectServices, Buttons, PowerADOQuery, Provider,
  Grids, DBGrids;

type
  TfrmModelAdd = class(TFrmParent)
    lblPricing: TLabel;
    lblEstoque: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblModelInformation: TLabel;
    Panel4: TPanel;
    lblCategory: TLabel;
    lblDescription: TLabel;
    lblManufacturer: TLabel;
    lblGroup: TLabel;
    lblSubCategory: TLabel;
    lbCaseQty: TLabel;
    lblModel: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lblBarcode: TLabel;
    lbBarcodeCase: TLabel;
    edtDescription: TDBEdit;
    edtCaseQty: TDBEdit;
    edtModel: TDBEdit;
    edtBarcode: TDBEdit;
    scManufacturer: TDBSuperComboADO;
    scCategory: TDBSuperComboADO;
    scGroup: TDBSuperComboADO;
    scSubCategory: TDBSuperComboADO;
    edtBarcodeCase: TDBEdit;
    chkManualCalcPrice: TDBCheckBox;
    chbAskSPOnSale: TDBCheckBox;
    SpeedButton3: TSpeedButton;
    btnAdd: TButton;
    cdsVendorSuggestion: TClientDataSet;
    cdsVendorSuggestionIDVendor: TIntegerField;
    cdsVendorSuggestionVendor: TStringField;
    cdsVendorSuggestionVendorCode: TStringField;
    cdsVendorSuggestionMinQtyPO: TFloatField;
    cdsVendorSuggestionCaseQty: TFloatField;
    cdsVendorSuggestionVendorCost: TCurrencyField;
    dtsModel: TDataSource;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    dbckPrintLabel: TDBCheckBox;
    dspModel: TDataSetProvider;
    quModel: TADODataSet;
    cdsModel: TClientDataSet;
    lblUnitCost: TLabel;
    lblOurPrice: TLabel;
    Label8: TLabel;
    lblfactor: TLabel;
    lblfactordesire: TLabel;
    edtUnitCost: TDBEdit;
    edtSellingPrice: TDBEdit;
    dbckAdjustManually: TDBCheckBox;
    dbedMarkup: TDBEdit;
    dbckAskForSale: TDBCheckBox;
    edtMargin: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label16: TLabel;
    dbedMinQty: TDBEdit;
    dbedMaxQty: TDBEdit;
    dbedQtyOnHand: TDBEdit;
    dbckClassE: TDBCheckBox;
    dbckNotVerify: TDBCheckBox;
    Label10: TLabel;
    lblVendorPart: TLabel;
    lbMinQtyPO: TLabel;
    lblVendor: TLabel;
    lbQtyType: TLabel;
    btnVendorSuggestion: TSpeedButton;
    Label12: TLabel;
    edtVendorPart: TDBEdit;
    edMinQtyPO: TDBEdit;
    scVendor: TDBSuperComboADO;
    edCaseQtyPO: TDBEdit;
    DBEdit5: TDBEdit;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCaseQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoCalcPrices(Sender: TObject);
    procedure edtCasePriceKeyPress(Sender: TObject; var Key: Char);
    procedure edtCasePriceExit(Sender: TObject);
    procedure edtCaseQtyExit(Sender: TObject);
    procedure scCategorySelectItem(Sender: TObject);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtMSRPExit(Sender: TObject);
    procedure edtOurPriceExit(Sender: TObject);
    procedure btnVendorSuggestionClick(Sender: TObject);
    procedure cdsModelCaseQtyChange(Sender: TField);
    procedure edtModelExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure dbckAdjustManuallyClick(Sender: TObject);
    procedure edtUnitCostExit(Sender: TObject);
    procedure dbedMarkupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtUnitCostKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtUnitCostKeyPress(Sender: TObject; var Key: Char);
    procedure dbedMaxQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCaseQtyPOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure scSubCategorySelectItem(Sender: TObject);
    procedure scGroupSelectItem(Sender: TObject);
    procedure edtCaseQtyChange(Sender: TObject);
    procedure edtSellingPriceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSellingPriceExit(Sender: TObject);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure dbedMarkupChange(Sender: TObject);
    procedure edtUnitCostChange(Sender: TObject);
    procedure edtDescriptionChange(Sender: TObject);
    procedure edtModelChange(Sender: TObject);
    procedure edtModelKeyPress(Sender: TObject; var Key: Char);
  private
    isBarcodeVerified: boolean;
    isFromCatalog: boolean;
    cSalePrice: double;
    FSellingPriceBeforeDesiredMargin: double;
    FUseMarkUpOnCost: boolean;
    FUseMarginTable: boolean;
    FCalcRounding: boolean;

    FDMInventory: TDMInventory;
    FLogError: TStringList;
    FApplyOnClose: Boolean;
    FVerifyModel: Boolean;
    FCloseAfterInsert : Boolean;
    FUPC : String;
    FSalePriceMargem: TPriceMargem;
    FMSRPMargem: TPriceMargem;
    FBarcode : TBarcode;

    procedure SellingPriceByMarkupFromCatalog(ACostPrice: Double);
    procedure SellingPriceByMarginFromCatalog(ACostPrice: Double);
    procedure SellingPriceByMargin(ACostPrice: Double);
    procedure SellingPriceByMarkup(ACostPrice: Double);
    procedure SellingPriceManually;

    procedure NewModel;
    procedure ApplyQuickEntries;

    function isValidVendor(AIdVendor: Integer): boolean;

    function ValidateFields: Boolean;
    function ValidateModel: Boolean;
    function ValidateBarcode: Boolean;
    procedure VerifyModelCatalog;

    procedure CalcSellingPriceKeyDown(Sender: TObject; var Key: Word;
              Shift: TShiftState);
  public
    function Start(ApplyOnClose, CloseAfterInsert, VerifyModel : Boolean; Barcode: String): TBarcode;

    //NAC 20120428 To promote code reutilization
    function CalcActualMargin(aSellingPrice, aCostPrice: Real): string;
  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uCharFunctions, uMsgConstant, uSystemConst,
  uDMCalcPrice, uDMParent, uFrmListVendor, uWebFunctions, Math, uStringFunctions;

{$R *.dfm}

procedure TFrmModelAdd.FormCreate(Sender: TObject);
var
  Margin: Real; //YAA April 27, 2012: To be used below
begin
  inherited;
  FDMInventory := TDMInventory.Create(Self);
  FLogError := TStringList.Create;
  FBarcode := TBarcode.Create;
  FBarcode.Model := TModel.Create;

  FUseMarkUpOnCost := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];

  if ( FUseMarkUpOnCost ) then begin
    lblfactor.Caption := 'Mark Up:';
    lblfactordesire.Caption   := 'Desired Mark Up:';
  end
  else begin
    lblfactor.Caption := 'Actual Margin:';
    lblfactordesire.Caption   := 'Desired Margin:';
  end;

  FUseMarginTable  := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  FCalcRounding    := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];


  Margin:= StrToFloatDef(dbedMarkup.Text, 0);

  //( dbckAdjustManually.Checked ) or
  ///                           ( not FUseMarginTable ); //YAA April 27, 2012 --> Added second condition

  //*** YAA April 27, 2012: Enabled as Margin Set to False ***

  //if (Margin > 0) and ()

  //if ( dbedMarkup.Text = '' ) and ( not FUseMarginTable ) then
  if ( dbckAdjustManually.Checked ) or ( not FUseMarginTable ) then
  begin
    edtSellingPrice.Enabled:= True;
    edtSellingPrice.Color := clWindow;
  end
  else
  begin
    edtSellingPrice.Enabled:= False;
    edtSellingPrice.Color := clBtnFace;
  end;

  ///**********************************************************

  lblSubMenu.Caption := 'Add Inventory';
end;

procedure TFrmModelAdd.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDMInventory);
  FreeAndNil(FLogError);
  FreeAndNil(FBarcode);
end;

procedure TFrmModelAdd.edtCaseQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmModelAdd.btAddClick(Sender: TObject);
begin
  inherited;

  if ValidateFields and ValidateBarcode and ValidateModel then
  begin
    if not FApplyOnClose then
      ApplyQuickEntries;

    if FCloseAfterInsert then
      Close;

    NewModel;
    edtBarcode.SetFocus;
  end
  else if FLogError.Text <> '' then
  begin
    MsgBox(FLogError.Text, vbInformation + vbOKOnly);
    FLogError.Clear;
  end;

end;

procedure TFrmModelAdd.DoCalcPrices(Sender: TObject);
var
  cSuggRetail : Currency;
  newMargin: double;
  desiredMargin: double;
  marginTableValue: double;
  vCategory: Integer;
  vSubCategory: Integer;
  vGroup: Integer;
  vcostPrice: Double;
begin
    //YAA April 27, 2012: Only recalculate price if
    //adjust manually is not checked or if use margin
    //table is true
    if (dbedMarkup.Text = '') then
    begin
      if (dbckAdjustManually.Checked) or
         (not FUseMarginTable) then
      Exit;
    end;

    if edtUnitCost.Modified then
    begin
       if ( isFromCatalog ) then begin
          if ( FUseMarkUpOnCost ) then
               // treat markup
          else begin
                  if ( FUseMarginTable ) then begin
                     // amfsouza 12.15.2011
                     edtMargin.Visible       := true;
                     lblFactor.Visible       := true;
                     dbckAdjustManuallyClick(self);

                     if ( trim(edtUnitCost.Text) <> '' ) then
                       // treat margin table
                       SellingPriceByMarginFromCatalog(strToFloat(edtUnitCost.Text))
                     else
                       SellingPriceByMarginFromCatalog(cdsModel.fieldByName('VendorCost').Value);
                  end
                  else begin
                      //amfsouza 12.15.2011

                      (* YAA April 28, 2012: Keep always visible
                      edtMargin.visible := false;
                      lblFactor.Visible := false; *)

                      //dbckAdjustManually.Checked := true; //YAA April 27, 2012: This should not be here
                      //dbckAdjustManuallyClick(self);      //YAA April 27, 2012: This should not be here

                      // NAC 20120429: Added to recalculate edtSellingPrice
                      SellingPriceByMarkup(strToFloat(edtUnitCost.Text));

                      //*** YAA April 27, 2012: Enabled as Margin Set to False ***
                      if ( dbedMarkup.Text = '' ) then
                      begin
                        edtSellingPrice.Enabled:= True;
                        edtSellingPrice.Color := clWindow;
                      end
                      else
                      begin
                        edtSellingPrice.Enabled:= False;
                        edtSellingPrice.Color := clBtnFace;
                      end;
                      //**********************************************************
                  end;
          end;

       end
       else begin
          if ( FUseMarkUpOnCost ) then
               // treat markup
          else begin
                  if ( FUseMarginTable ) then begin
                     // amfsouza 12.15.2011
                     edtMargin.Visible       := true;
                     lblFactor.Visible       := true;
                     dbckAdjustManuallyClick(self);

                     if ( trim(edtUnitCost.Text) <> '' ) then
                       // treat margin table
                       SellingPriceByMargin(strToFloat(edtUnitCost.Text))
                     else
                       SellingPriceByMargin(cdsModel.fieldByName('VendorCost').Value)

                  end
                  else begin
                      // not using margin table
                      //amfsouza 12.15.2011

                      (* YAA April 28, 2012: Keep always visible
                      edtMargin.visible := false;
                      lblFactor.Visible := false; *)

                      //dbckAdjustManually.Checked := true;
                      //under test - Antonio
                      SellingPriceByMarkup(strToFloat(edtUnitCost.Text));

                      //*** YAA April 27, 2012: Enabled as Margin Set to False ***
                      if ( dbedMarkup.Text = '' ) then
                      begin
                        edtSellingPrice.Enabled:= True;
                        edtSellingPrice.Color := clWindow;
                      end
                      else
                      begin
                        edtSellingPrice.Enabled:= False;
                        edtSellingPrice.Color := clBtnFace;
                      end;
                      //**********************************************************
                  end;
          end;
       end;

       //YAA April 28, 2012: Added "if" condition
       //to avoid error if category is blank
       if scCategory.Text <> '' then
       begin
         if DM.DescCodigo(['IDGroup'], [scCategory.LookUpValue], 'TabGroup', 'SizeAndColor') = 'True' then
             cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_MASTER
         else if DM.DescCodigo(['IDGroup'], [scCategory.LookUpValue], 'TabGroup', 'PackModel') = 'True' then
              cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_PACKAGE
         else if DM.DescCodigo(['IDGroup'], [scCategory.LookUpValue], 'TabGroup', 'Service') = 'True' then
              cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_SERVICE
         else if DM.DescCodigo(['IDGroup'], [scCategory.LookUpValue], 'TabGroup', 'Credit') = 'True' then
              cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_CREDIT
         else if DM.DescCodigo(['IDGroup'], [scCategory.LookUpValue], 'TabGroup', 'GiftCard') = 'True' then
              cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_GIFTCARD
         else
             cdsModel.FieldByName('ModelType').Value := MODEL_TYPE_REGULAR;
       end;
    end;

  //YAA April 28, 2012: Actual margin calculation
  //edtMargin.Text:= CalcActualMargin(StrToFloatDef(edtSellingPrice.Text, 0), StrToFloatDef(edtUnitCost.Text, 0));
end;

procedure TFrmModelAdd.ApplyQuickEntries;
var
  BarcodeService: TMRBarcodeService;
  Barcode: TBarcode;
begin
  try
    BarcodeService                := TMRBarcodeService.Create();
    Barcode                       := TBarcode.Create();
    Barcode.Model                 := TModel.Create();
    Barcode.Model.Category        := TCategory.Create;
    Barcode.Model.ModelGroup      := TModelGroup.Create;
    Barcode.Model.ModelSubGroup   := TModelSubGroup.Create;
    Barcode.Model.Vendor          := TVendor.Create;
    Barcode.Model.Manufacturer    := TManufacturer.Create;
    Barcode.Model.VendorModelCode := TVendorModelCode.Create;
    Barcode.Model.ModelVendor     := TModelVendor.Create;
    Barcode.Model.Inventory       := TInventory.Create;

    BarcodeService.SQLConnection := DM.ADODBConnect;

    with cdsModel do
    if not IsEmpty then
    try
      First;
      while not Eof do
      begin
        //Barcode
        Barcode.IDBarcode                               := FieldByName('IDBarcode').Value;
        Barcode.BarcodeCase                             := FieldByName('BarcodeCase').Value;

        //Model
        Barcode.Model.IDModel                           := Null;
        Barcode.Model.Model                             := FieldByName('Model').AsString;
        Barcode.Model.Description                       := FieldByName('Description').AsString;
        Barcode.Model.Qty                               := FieldByName('QtyOnHand').AsFloat;
        Barcode.Model.CaseQty                           := FieldByName('CaseQty').AsFloat;
        Barcode.Model.SellingPrice                      := FieldByName('SellingPrice').AsCurrency;
        Barcode.Model.SuggRetail                        := FieldByName('SuggRetail').AsCurrency;
        Barcode.Model.VendorCost                        := FieldByName('VendorCost').AsCurrency;
        Barcode.Model.ModelType                         := FDMInventory.GetModelType(FieldByName('IDGroup').AsInteger);
        Barcode.Model.Verify                            := True;
        Barcode.Model.IDUserLastSellingPrice            := DM.fUser.ID;
        Barcode.Model.IDSize                            := cdsModel.FieldByName('IDSize').Value;
        Barcode.Model.IDColor                           := cdsModel.FieldByName('IDColor').Value;
        Barcode.Model.IDUnit                            := cdsModel.FieldByName('IDUnit').Value;

        //amfsouza 11.17.2010 - new attribute members
        if ( cdsModel.fieldByName('Markup').isNull ) then
           barcode.Model.Markup                            := 0
        else
           barcode.Model.Markup                            := cdsModel.fieldByName('Markup').Value;

        barcode.Model.freightCost                       := cdsModel.fieldByname('FreightCost').Value;
        barcode.Model.otherCost                         := cdsModel.fieldByname('otherCost').Value;
        barcode.Model.weight                            := cdsModel.fieldByname('peso').Value;
        barcode.Model.system                            := ( cdsModel.FieldByName('system').Value = 0);
        barcode.Model.desativado                        := ( cdsModel.FieldByName('desativado').Value = 1 );
        barcode.Model.lastCost                          := cdsModel.fieldByname('lastCost').Value;

        if ( dbckNotVerify.Checked ) then
           barcode.Model.NotVerifyQty := true
        else
           barcode.Model.NotVerifyQty := false;

        if ( dbckClassE.Checked ) then
           barcode.Model.classABC := 'E'
        else
           barcode.Model.classABC := 'C';

        if ( dbckAdjustManually.Checked ) then
           barcode.Model.updatePrice := 1
        else
           barcode.Model.UpdatePrice := 0;

        //amf October 17, 2012 - fix mismatch fields
        if ( dbckAskForSale.Checked ) then
            barcode.Model.customSalePrice := true
        else
            barcode.Model.customSalePrice := false;

        if ( chbAskSPOnSale.Checked ) then
           barcode.Model.askUserOnSale := true
        else
           barcode.Model.askUserOnSale :=false;

        //amfsouza 11.17.2010 - new attribute members

        //Category
        Barcode.Model.Category.IDGroup                  := FieldByName('IDGroup').AsInteger;
        //SubCategory
        Barcode.Model.ModelGroup.IDModelGroup           := FieldByName('IDModelGroup').Value;
        //Group
        Barcode.Model.ModelSubGroup.IDModelSubGroup     := FieldByName('IDModelSubGroup').Value;
        //Vendor
        Barcode.Model.Vendor.IDVendor                   := FieldByName('IDVendor').Value;
        //Manufacture
        Barcode.Model.Manufacturer.IDManufacturer       := FieldByName('IDManufacturer').Value;
        //VendorModelCode
        Barcode.Model.VendorModelCode.IDVendorModelCode := Null;
        Barcode.Model.VendorModelCode.VendorCode        := FieldByName('VendorCode').AsString;
        //ModelVendor
        Barcode.Model.ModelVendor.IDModel               := Null;
        Barcode.Model.ModelVendor.IDVendor              := FieldByName('IDVendor').Value;
        Barcode.Model.ModelVendor.MinQtyPO              := FieldByName('VendorMinQtyPO').AsFloat;
        Barcode.Model.ModelVendor.CaseQty               := FieldByName('VendorCaseQty').AsFloat;
        Barcode.Model.ModelVendor.VendorCost            := FieldByName('VendorCost').AsCurrency;
        Barcode.Model.ModelVendor.LastCostChange        := now;

        //Inventory
        Barcode.Model.Inventory.IDInventory             := Null;
        Barcode.Model.Inventory.IDUser                  := DM.fUser.ID;
        Barcode.Model.Inventory.IDStore                 := DM.fStore.ID;
        Barcode.Model.Inventory.QtyOnHand               := FieldByName('QtyOnHand').AsFloat;
        Barcode.Model.Inventory.MinQty                  := FieldByName('MinQty').AsFloat;
        Barcode.Model.Inventory.MaxQty                  := FieldByName('MaxQty').AsFloat;
        //Import
        BarcodeService.Import(Barcode);

        FBarcode.Model.IDModel     := Barcode.Model.IDModel;
        FBarcode.Model.Model       := Barcode.Model.Model;
        FBarcode.Model.Description := Barcode.Model.Description;
        Next;
      end;

        First;
        while not Eof do
          Delete;

    finally
      FreeAndNil(Barcode.Model.VendorModelCode);
      FreeAndNil(Barcode.Model.ModelVendor);
      FreeAndNil(Barcode.Model.Inventory);
      FreeAndNil(Barcode.Model.Category);
      FreeAndNil(Barcode.Model.ModelGroup);
      FreeAndNil(Barcode.Model.ModelSubGroup);
      FreeAndNil(Barcode.Model.Vendor);
      FreeAndNil(Barcode.Model.Manufacturer);
      FreeAndNil(Barcode.Model);
      FreeAndNil(Barcode);
      FreeAndNil(BarcodeService);
      Close;
     end;
  except
   on E: Exception do
     raise e.Create('Cannot save the model ' + e.message);
     //MsgBox(E.Message, vbCritical + vbOKOnly);
  end;
end;

function TFrmModelAdd.Start(ApplyOnClose, CloseAfterInsert,
   VerifyModel : Boolean; Barcode: String): TBarcode;
begin
  FApplyOnClose := ApplyOnClose;
  FVerifyModel := VerifyModel;
  FCloseAfterInsert := CloseAfterInsert;
  FUPC := Barcode;
  FBarcode.Model.IDModel := -1;
  dbckAdjustManually.Checked   := true;
//  cdsModel.CreateDataSet;
  NewModel;
  ShowModal;
  Result := FBarcode;
end;

procedure TFrmModelAdd.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if FApplyOnClose then
    ApplyQuickEntries;
  cdsModel.Close;
end;

procedure TFrmModelAdd.NewModel;
begin
  with cdsModel do
  try
    if not(Active) then
      Open;

    Append;
    FieldByName('ModelType').Value    := MODEL_TYPE_REGULAR;
    FieldByName('IDBarcode').AsString := FUPC;
    FieldByName('Verify').AsBoolean   := FVerifyModel;
    FUPC := '';

    //amfsouza 11.22.2010 - new fields
    dbckAdjustManually.Checked := false;
    dbckNotVerify.Checked      := false;
    dbckAskForSale.Checked     := false;
    dbckClassE.Checked         := false;
    chbAskSPOnSale.Checked     := false;
    dbckPrintLabel.Checked     := false;

    cdsModel.fieldByName('freightCost').Value := 0;
    cdsModel.fieldByName('Markup').Value := 0;
    cdsModel.fieldByname('FreightCost').Value := 0;
    cdsModel.fieldByname('otherCost').Value := 0;
    cdsModel.fieldByname('peso').Value := 0;
    cdsModel.fieldByname('lastCost').Value := 0;
    cdsModel.FieldByName('IDManufacturer').Value := 0;

    if DM.fSystem.SrvParam[PARAM_USE_CATALOG] and (FieldByName('IDBarcode').AsString <> '') then begin
      VerifyModelCatalog;
    end else if (cdsModel.fieldbyname('Model').AsString = '') and DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL] then begin
          cdsModel.fieldbyname('Model').AsString := FDMInventory.GetValidModelCode();
        end;

  except
   on E: Exception do
     MsgBox(E.Message, vbCritical + vbOKOnly);
  end;
end;

procedure TFrmModelAdd.edtCasePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmModelAdd.edtCasePriceExit(Sender: TObject);
begin
  inherited;
//  edtCasePrice.Text := CurrToStr(DM.FDMCalcPrice.FormatPrice(MyStrToMoney(edtCasePrice.Text)));

{ amfsouza 11.16.2010
  if (MyStrToMoney(edtCasePrice.Text) <> 0) and
     (cdsModelCaseQty.AsFloat <> 0)  then
  begin
    cdsModelVendorCost.AsCurrency := MyStrToMoney(edtCasePrice.Text)/cdsModelCaseQty.AsFloat;
    cdsModelVendorCost.FocusControl;
  end;
  }
  
end;

procedure TFrmModelAdd.edtCaseQtyExit(Sender: TObject);
begin
  inherited;
{ amfsouza 11.16.2010
  lbCasePrice.Visible  := (cdsModelCaseQty.AsFloat > 1);
  edtCasePrice.Visible := lbCasePrice.Visible;
  if edtCasePrice.Visible then
    edtCasePrice.SetFocus;
}
end;

procedure TFrmModelAdd.scCategorySelectItem(Sender: TObject);
begin
  inherited;
  DoCalcPrices(Sender);
end;

function TFrmModelAdd.ValidateModel: Boolean;
begin

  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := 'SELECT IDModel FROM Model WHERE Model = ' + QuotedStr(edtModel.Text);
    Open;
    Result := IsEmpty;

    if not Result then
    begin
      FLogError.Add(MSG_EXC_MODEL_EXISTE);
    end;
  finally
    Close;
  end;
end;

function TFrmModelAdd.ValidateBarcode: Boolean;
begin
  if edtBarcode.Text = '' then
    Result := True
  else
    with DM.quFreeSQL do
    try
      if Active then
        Close;

      SQL.Text := 'SELECT IDBarcode FROM Barcode WHERE IDBarcode = ' + QuotedStr(edtBarcode.Text);
      Open;
      Result := IsEmpty;

      if not Result then
      begin
        FLogError.Add(MSG_EXC_BARCODE_EXISTE);
      end;
    finally
      Close;
    end;
end;

function TFrmModelAdd.ValidateFields: Boolean;
begin
  Result := False;

  if edtModel.Text = '' then
  begin
    FLogError.Add(MSG_CRT_NO_MODEL);
    edtModel.SetFocus;
    Exit;
  end;

  if edtDescription.Text = '' then
  begin
    FLogError.Add(MSG_INF_NOT_DESCRIPTION_EMPTY);
    edtDescription.SetFocus;
    Exit;
  end;

  if scCategory.LookUpValue = '' then
  begin
    FLogError.Add(MSG_CRT_NOT_EMPTY_CATEGORY);
    scCategory.SetFocus;
    Exit;
  end;

  if edtSellingPrice.Text = '' then
  begin
    FLogError.Add(MSG_CRT_NO_EMPTY_SELLING);
    Exit;
  end;

  if ( cdsModel.FieldByName('SellingPrice').IsNull ) then begin
    if (cSalePrice < cdsModel.fieldByName('VendorCost').AsCurrency) then begin
      FLogError.Add(MSG_INF_NOT_SELL_BELLOW_COST);

      if edtSellingPrice.CanFocus then
        edtSellingPrice.SetFocus;

      Exit;
    end;
  end
  else if (cdsModel.FieldByName('SellingPrice').AsCurrency < cdsModel.fieldByName('VendorCost').AsCurrency) then begin
       FLogError.Add(MSG_INF_NOT_SELL_BELLOW_COST);

      if edtSellingPrice.CanFocus then
        edtSellingPrice.SetFocus;

      Exit;

  end;

  Result := True;
end;

procedure TFrmModelAdd.edtBarcodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ( ((key = VK_RETURN) or (key = VK_TAB)) and (Trim(edtBarcode.Text) <> '') and (DM.fSystem.SrvParam[PARAM_USE_CATALOG]) ) then begin
    if not ValidateBarcode then begin
      if FLogError.Text <> '' then begin
        MsgBox(FLogError.Text, vbInformation + vbOKOnly);
        FLogError.Clear;
        isBarcodeVerified := true;
        Exit;
      end;
    end;

    FBarcode.IDBarcode := Null;

    VerifyModelCatalog;
  end;
end;

procedure TFrmModelAdd.VerifyModelCatalog;
var
  CatalogBarcodeService: TCatalogBarcodeService;
  Barcode: TBarcode;
  i : integer;
  vVendorCaseQty: Double;
  vVendorMinQtyPO: Double;
begin
  try
    isFromCatalog := false;
    CatalogBarcodeService := TCatalogBarcodeService.Create();
    Barcode               := TBarcode.Create();

    CatalogBarcodeService.SQLConnection := DM.ADODBConnect;

    Barcode.IDBarcode  := edtBarcode.Text;

    CatalogBarcodeService.Find(Barcode);

    cdsModel.fieldByName('Markup').value := NULL;

    if Assigned(Barcode.Model) then
    begin
      isFromCatalog := true;
      //if not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL] then
      // Antonio, Nov 6 2017
      cdsModel.fieldByName('IdModel').Value := Barcode.Model.IDModel;
      cdsModel.fieldByName('Model').Value       := Barcode.Model.Model;
      cdsModel.fieldByname('Description').Value := Barcode.Model.Description;
      cdsModel.FieldByName('CaseQty').Value     := Barcode.Model.CaseQty;
      cdsModel.fieldByName('SuggRetail').Value  := Barcode.Model.SuggRetail;
      cdsModel.FieldByName('VendorCost').Value  := 0;
      cdsModel.FieldByName('BarcodeCase').Value := Barcode.BarcodeCase;

      if VarToStr(Barcode.Model.Category.IDGroup) <> '' then
      begin
        cdsModel.FieldByName('IDGroup').Value := Barcode.Model.Category.IDGroup;
      end;

      if VarToStr(Barcode.Model.ModelGroup.IDModelGroup) <> '' then
        cdsModel.FieldByName('IDModelGroup').Value    := Barcode.Model.ModelGroup.IDModelGroup;

      if VarToStr(Barcode.Model.ModelSubGroup.IDModelSubGroup) <> '' then
        cdsModel.FieldByName('IDModelSubGroup').Value := Barcode.Model.ModelSubGroup.IDModelSubGroup;

      if Barcode.Model.Manufacturer.IDManufacturer <> 0 then
        cdsModel.fieldByname('IDManufacturer').Value := Barcode.Model.Manufacturer.IDManufacturer;

      if ( isValidVendor(Barcode.Model.Vendor.IDVendor ) ) then begin
          if Barcode.Model.Vendor.IDVendor <> 0 then
          begin
            cdsModel.FieldByName('VendorCode').Value  := Barcode.Model.VendorModelCode.VendorCode;
            cdsModel.FieldByName('IDVendor').Value    := Barcode.Model.Vendor.IDVendor;
            cdsModel.FieldByName('VendorCost').Value  := Barcode.Model.VendorCost;

            if Barcode.Model.ModelVendor.IDVendor <> 0 then
            begin
              if ( (Barcode.Model.ModelVendor.MinQtyPO > 0) and
                 (Barcode.Model.ModelVendor.CaseQty > 0) ) then begin
                 Barcode.Model.ModelVendor.CaseQty :=
                    Barcode.Model.ModelVendor.CaseQty / Barcode.Model.ModelVendor.MinQtyPO;

                   cdsModel.FieldByName('VendorCaseQty').Value  := Barcode.Model.ModelVendor.CaseQty;
                   cdsModel.FieldByName('VendorMinQtyPO').Value := Barcode.Model.ModelVendor.MinQtyPO;
              end;

            end;
          end;

          Barcode.Model.Vendor.Vendor := scVendor.Text;

          if (Barcode.Model.VendorCost = 0) and CatalogBarcodeService.FindByVendor(Barcode) then
            cdsModel.FieldByName('VendorCost').Value  := Barcode.Model.VendorCost;


          if Barcode.Model.Category.IDGroup <> 0 then
          begin
            DoCalcPrices(Self);
            if cdsModel.FieldByName('VendorCost').Value = cdsModel.FieldByName('SuggRetail').Value then
              cdsModel.fieldByName('SuggRetail').Value := Barcode.Model.SuggRetail;
          end;

    //      btnVendorSuggestion.Visible := (Barcode.Model.FSuggestedVendor.Count > 1);

          if btnVendorSuggestion.Visible then
          with cdsVendorSuggestion do
          begin
            if Active then
              Close;
            CreateDataSet;
            for i := 0 to Barcode.Model.FSuggestedVendor.Count-1 do
            begin
              Append;
              FieldByName('IDVendor').AsInteger    := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).IDVendor;
              FieldByName('Vendor').AsString       := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).Vendor;
              FieldByName('VendorCode').AsString   := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).VendorCode;
              FieldByName('MinQtyPO').AsFloat      := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).MinQtyPO;
              FieldByName('CaseQty').AsFloat       := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).CaseQty;
              FieldByName('VendorCost').AsCurrency := TVendorSuggestedList(Barcode.Model.FSuggestedVendor.Objects[i]).VendorCost;
              Post;
            end;
          end;
      end;
    end
    else begin
       cdsModel.FieldByName('vendorcost').Value := 0;
       cdsModel.FieldByName('sellingprice').Value := 0;
       edtSellingPrice.Enabled := true;
       edtUnitCost.Enabled     := true;
    end;
  finally
    if Assigned(CatalogBarcodeService) then
      FreeAndNil(CatalogBarcodeService);

    if Assigned(Barcode) then
      FreeAndNil(Barcode);
  end;
end;

procedure TFrmModelAdd.edtBarcodeExit(Sender: TObject);
begin
  if ( not isBarcodeVerified ) then begin
    if ( (Trim(edtBarcode.Text) <> '') and (DM.fSystem.SrvParam[PARAM_USE_CATALOG]) ) then begin
      if not ValidateBarcode then begin
        if FLogError.Text <> '' then begin
          MsgBox(FLogError.Text, vbInformation + vbOKOnly);
          FLogError.Clear;
          Exit;
        end;
      end;

      FBarcode.IDBarcode := Null;

      VerifyModelCatalog;
    end;
  end;
end;

procedure TFrmModelAdd.edtMSRPExit(Sender: TObject);
begin
  inherited;
  cdsModel.FieldByName('SuggRetail').AsCurrency := DM.FDMCalcPrice.FormatPrice(cdsModel.fieldByName('SuggRetail').AsCurrency);
end;

procedure TFrmModelAdd.edtOurPriceExit(Sender: TObject);
begin
  inherited;
  cdsModel.FieldByName('SellingPrice').AsCurrency := DM.FDMCalcPrice.FormatPrice(cdsModel.fieldByName('SellingPrice').AsCurrency);
end;

procedure TFrmModelAdd.btnVendorSuggestionClick(Sender: TObject);
begin
  inherited;
  with TFrmListVendor.Create(Self) do
    if Start(cdsVendorSuggestion) <> -1 then
    begin
      cdsModel.FieldByName('IDVendor').Value       := cdsVendorSuggestion.FieldByName('IDVendor').AsInteger;
      cdsModel.FieldByName('VendorCode').Value     := cdsVendorSuggestion.FieldByName('VendorCode').AsString;
      cdsModel.FieldByName('VendorCaseQty').Value  := cdsVendorSuggestion.FieldByName('CaseQty').AsFloat;
      cdsModel.FieldByName('VendorMinQtyPO').Value := cdsVendorSuggestion.FieldByName('MinQtyPO').AsFloat;
      cdsModel.FieldByName('VendorCost').Value     := cdsVendorSuggestion.FieldByName('VendorCost').AsCurrency;
      DoCalcPrices(Sender);
    end;
end;

procedure TFrmModelAdd.cdsModelCaseQtyChange(Sender: TField);
begin
  inherited;
  if cdsModel.FieldByName('CaseQty').NewValue > 1 then
  begin
    lbBarcodeCase.Visible  := True;
    edtBarcodeCase.Visible := True;
  end
  else
  begin
    lbBarcodeCase.Visible  := False;
    edtBarcodeCase.Visible := False;
    edtBarcodeCase.Clear;
  end;
end;

procedure TFrmModelAdd.edtModelExit(Sender: TObject);
begin
  inherited;

  if not ValidateModel then
  begin
    if FLogError.Text <> '' then
    begin
      MsgBox(FLogError.Text, vbInformation + vbOKOnly);
      FLogError.Clear;
      Exit;
    end;
  end;

end;
procedure TFrmModelAdd.spHelpClick(Sender: TObject);
begin
  inherited;
  //OpenURL('http://www.mainretail.com.br/treinamento/Cadastro/Cad_Produto_Comum.htm');
end;

procedure TFrmModelAdd.btnVideoClick(Sender: TObject);
begin
  inherited;
  //OpenURL('http://www.mainretail.com.br/treinamento/video/Adicionar_Produto_Cadastro_Rapido/Adicionar_Produto_Cadastro_Rapido.html');
end;


procedure TfrmModelAdd.btnAddClick(Sender: TObject);
begin
  inherited;

  if ValidateFields and ValidateBarcode and ValidateModel then
  begin
    if not FApplyOnClose then
      ApplyQuickEntries;

    if FCloseAfterInsert then
      Close;

    NewModel;
    edtBarcode.SetFocus;
  end
  else if FLogError.Text <> '' then
  begin
    MsgBox(FLogError.Text, vbInformation + vbOKOnly);
    FLogError.Clear;
  end;

end;

procedure TfrmModelAdd.btCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmModelAdd.dbckAdjustManuallyClick(Sender: TObject);
begin
  inherited;
  edtSellingPrice.Enabled := ( dbckAdjustManually.Checked ) or
                             ( not FUseMarginTable ); //YAA April 27, 2012 --> Added second condition

  dbedMarkup.Enabled := ( not dbckAdjustManually.Checked );

  if ( edtSellingPrice.Enabled ) then
      edtSellingPrice.Color := clWindow
  else
      edtSellingPrice.Color := clBtnFace;

  if ( dbedMarkup.enabled ) then begin
    {amfsouza June 26, 2012
    if ( trim(dbedMarkup.Text) <> '' ) then
        dbedMarkup.Text := '';
    }
    dbedMarkup.Color := clWindow;
  end
  else
    dbedMarkup.Color := clBtnFace;

end;

procedure TfrmModelAdd.edtUnitCostExit(Sender: TObject);
begin
  inherited;
  DoCalcPrices(self);
end;

procedure TfrmModelAdd.dbedMarkupKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  //amfsouza June 26, 2012 - back space 
  if ( key = VK_BACK ) and (length(dbedMarkup.Text) = 1) then begin
     dbedMarkup.Text := '';
     DoCalcPrices(self);
     dbedQtyOnHand.SetFocus;
  end;

  if ( (key = VK_RETURN) or (key = VK_TAB) ) then begin
     DoCalcPrices(self);
     dbedQtyOnHand.SetFocus;
  end;
end;

procedure TfrmModelAdd.edtUnitCostKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if ( (key = VK_RETURN) or ( key = VK_TAB) ) then
     DoCalcPrices(sender);

end;

procedure TfrmModelAdd.edtUnitCostKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  key := ValidatePositiveCurrency(key);
end;

procedure TfrmModelAdd.CalcSellingPriceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

   if ( (key = VK_RETURN) or ( key = VK_TAB) ) then
      DoCalcPrices(self);

end;

procedure TfrmModelAdd.dbedMaxQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ( (key = VK_RETURN) or (key = VK_TAB) ) then
     scVendor.SetFocus;

end;

procedure TfrmModelAdd.edCaseQtyPOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ( (key = VK_RETURN) or (key = VK_TAB) ) then
     btnAdd.SetFocus;

end;

procedure TfrmModelAdd.scSubCategorySelectItem(Sender: TObject);
begin
  inherited;
  DoCalcPrices(self);
end;

procedure TfrmModelAdd.scGroupSelectItem(Sender: TObject);
begin
  inherited;
  DoCalcPrices(self);
end;

procedure TfrmModelAdd.edtCaseQtyChange(Sender: TObject);
begin
  inherited;
  //amfsouza 02.17.2011 -right now, I test to verify if in insert or edit mode.
  if ( cdsModel.State = dsEdit ) then begin
    if ( cdsModel.FieldByName('caseQty').Value <= 1 ) then
         edtCaseQty.Text := '';
  end;
end;

procedure TfrmModelAdd.edtSellingPriceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ( key = VK_RETURN ) then
     DoCalcPrices(sender);
end;

procedure TfrmModelAdd.edtSellingPriceExit(Sender: TObject);
begin
  inherited;
  doCalcPrices(self);
end;

procedure TfrmModelAdd.SellingPriceByMargin(ACostPrice: Double);
var
  vCategory: Integer;
  vCostPrice: Double;
  vSubCategory: Integer;
  vGroup: Integer;
  marginTableValue: Double;
  desiredMargin: Double;
  newMargin:Double;
  toCompareDesireMargin, toCompareMargin: String;
begin
  if ( cdsModel.FieldByName('IDGroup').IsNull ) then
     vCategory := 0
  else
     vCategory := cdsModel.FieldByName('IDGroup').Value;

  if ( cdsModel.FieldByName('IDModelGroup').IsNull ) then
     vSubCategory := 0
  else
     vSubCategory := cdsModel.FieldByName('IDModelGroup').Value;

  if ( cdsModel.FieldByName('IDModelSubGroup').IsNull ) then
     vGroup := 0
  else
     vGroup := cdsModel.FieldByName('IDModelSubGroup').Value;

  if ( ACostPrice > 0 ) then
     vCostPrice := ACostPrice;

  if ( vCostPrice = 0 ) then
     exit;

  if ( not dbckAdjustManually.Checked ) then begin
      // calculate SellingPrice
      cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcSalePrice(0,
                                                    vCategory,
                                                    vSubCategory,
                                                    vGroup,
                                                    vCostprice);
      if ( cdsModel.fieldByName('SellingPrice').Value = 0 ) then begin
           dbckAdjustManuallyClick(self);
           exit;
      end;
  end
  else begin
     if ( trim(edtSellingPrice.Text) <> '' ) then begin
        cSalePrice := strToFloat(edtSellingPrice.Text);
        cdsModel.fieldByName('SellingPrice').value := cSalePrice;
        if ( cSalePrice = 0 ) then begin
           dbckAdjustManuallyClick(self);
           exit;
        end;
     end;
  end;

  //marginTableValue := ( cdsModel.fieldByName('SellingPrice').value - vCostPrice ) / (cdsModel.fieldByName('SellingPrice').value);
  //edtMargin.Text := floatToStrF(marginTableValue * 100, ffNumber, 15, 2) + '%'; //YAA April 28, 2012: Making this text a percentage
  edtMargin.Text := CalcActualMargin(cdsModel.fieldByName('SellingPrice').value, vCostPrice); //YAA April 28, 2012: Replace above

//  edtSellingPrice.Enabled := false;
//  edtSellingPrice.Color   := clBtnFace;

  if ( not dbckAdjustManually.Checked ) then begin
      if ( trim(dbedMarkup.Text) <> '' ) then begin
         desiredMargin := strToFloat(dbedMarkup.Text);

         toCompareDesireMargin := floatToStrF((desiredMargin/100), ffNumber, 15, 2);
         toCompareMargin       := floatToStrF(marginTableValue, ffNumber, 15, 2);

         if ( toCompareDesireMargin  = toCompareMargin ) then
            exit;

         cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.GetMarginPrice(cdsModel.fieldByName('vendorCost').value, (desiredMargin) );

         //YAA April 27, 201 2: Adding "if" condition for safety
         if not VarIsEmpty(cdsModel.fieldByName('IDGroup').Value) and
            not VarIsNull(cdsModel.fieldByName('IDGroup').Value) then
         begin
           cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcRounding(cdsModel.fieldByName('IDGroup').Value, cdsModel.FieldByName('SellingPrice').Value);
         end;

         edtSellingPrice.Text := FloatToStrF(cdsModel.FieldByName('SellingPrice').Value, ffNumber, 15, 2);

         //newMargin := (cdsModel.FieldByName('SellingPrice').Value - cdsModel.fieldByName('vendorCost').Value) / (cdsModel.FieldByName('SellingPrice').Value);
         //edtMargin.Text := FloatToStrF(newMargin * 100, ffNumber, 15, 2) + '%';
         //YAA April 28, 2012: Replace above
         edtMargin.Text := CalcActualMargin(cdsModel.FieldByName('SellingPrice').Value, cdsModel.fieldByName('vendorCost').Value); //YAA April 28, 2012: Replace above
      end;
  end;
end;

procedure TfrmModelAdd.SellingPriceByMarkup(ACostPrice: Double);
var
  vCategory: Integer;
  vCostPrice: Double;
  vSubCategory: Integer;
  vGroup: Integer;
  marginTableValue: Double;
  desiredMargin: Double;
  newMargin:Double;
  toCompareDesireMargin, toCompareMargin: String;
begin     //YAA April 27, 2012 Review
  if ( cdsModel.FieldByName('IDGroup').IsNull ) then
     vCategory := 0
  else
     vCategory := cdsModel.FieldByName('IDGroup').Value;

  if ( cdsModel.FieldByName('IDModelGroup').IsNull ) then
     vSubCategory := 0
  else
     vSubCategory := cdsModel.FieldByName('IDModelGroup').Value;

  if ( cdsModel.FieldByName('IDModelSubGroup').IsNull ) then
     vGroup := 0
  else
     vGroup := cdsModel.FieldByName('IDModelSubGroup').Value;

  if ( ACostPrice > 0 ) then
     vCostPrice := ACostPrice;

  if ( vCostPrice = 0 ) then
     exit;

  if ( not dbckAdjustManually.Checked ) then begin
      // calculate SellingPrice
      cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcSalePrice(0,
                                                    vCategory,
                                                    vSubCategory,
                                                    vGroup,
                                                    vCostprice);
      //cSalePrice := cdsModel.fieldByName('SellingPrice').Value;
  end;
  (*
  else begin
     if ( trim(edtSellingPrice.Text) <> '' ) then begin
        edtSellingPrice.Enabled := dbckAdjustManually.Checked;
        cSalePrice := strToFloat(edtSellingPrice.Text);
        if ( cSalePrice = 0 ) then
           exit;
     end;
  end;
  *)

  //marginTableValue := ( cdsModel.fieldByName('SellingPrice').value - vCostPrice ) / (cdsModel.fieldByName('SellingPrice').value);
  //edtMargin.Text := floatToStrF(marginTableValue * 100, ffNumber, 15, 2) + '%';
  //YAA April 28, 2012: Replace above
  edtMargin.Text := CalcActualMargin(cdsModel.fieldByName('SellingPrice').value, vCostPrice); //YAA April 28, 2012: Replace above

  
//  edtSellingPrice.Enabled := false;
//  edtSellingPrice.Color   := clBtnFace;

  if ( not dbckAdjustManually.Checked ) then begin
      if ( trim(dbedMarkup.Text) <> '' ) then begin
         desiredMargin := strToFloat(dbedMarkup.Text);

         toCompareDesireMargin := floatToStrF((desiredMargin/100), ffNumber, 15, 2);
         toCompareMargin       := floatToStrF(marginTableValue, ffNumber, 15, 2);

         if ( toCompareDesireMargin  = toCompareMargin ) then
            exit;


         cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.GetMarginPrice(vCostPrice, desiredMargin );

         //YAA April 27, 2012: Adding "if" condition for safety
         if not VarIsEmpty(cdsModel.FieldByName('IDGroup').Value) and
            not VarIsNull(cdsModel.FieldByName('IDGroup').Value) then
         begin
           cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcRounding(cdsModel.fieldByName('IDGroup').Value, cdsModel.FieldByName('SellingPrice').Value);
         end;

         edtSellingPrice.Text := FloatToStrF(cdsModel.FieldByName('SellingPrice').Value, ffNumber, 15, 2);

         //newMargin := (cdsModel.FieldByName('SellingPrice').Value - cdsModel.fieldByName('vendorCost').Value) / (cdsModel.FieldByName('SellingPrice').Value);
         //edtMargin.Text := FloatToStrF(newMargin * 100, ffNumber, 15, 2) + '%';
         //YAA April 28, 2012: Replace above
         edtMargin.Text := CalcActualMargin(cdsModel.fieldByName('SellingPrice').value, cdsModel.fieldByName('vendorCost').Value);

      end;
  end;
end;

procedure TfrmModelAdd.SellingPriceByMarginFromCatalog(ACostPrice: Double);
var
  vCategory: Integer;
  vCostPrice: Double;
  vSubCategory: Integer;
  vGroup: Integer;
  marginTableValue: Double;
  desiredMargin: Double;
  newMargin:Double;
  toCompareDesireMargin, toCompareMargin: String;
begin
  if ( cdsModel.FieldByName('IDGroup').IsNull ) then
     vCategory := 0
  else
     vCategory := cdsModel.FieldByName('IDGroup').Value;

  if ( cdsModel.FieldByName('IDModelGroup').IsNull ) then
     vSubCategory := 0
  else
     vSubCategory := cdsModel.FieldByName('IDModelGroup').Value;

  if ( cdsModel.FieldByName('IDModelSubGroup').IsNull ) then
     vGroup := 0
  else
     vGroup := cdsModel.FieldByName('IDModelSubGroup').Value;

  if ( ACostPrice > 0 ) then
     vCostPrice := ACostPrice;

  if ( vCostPrice = 0 ) then
     exit;

  if ( not dbckAdjustManually.Checked ) then begin
      // calculate SellingPrice
      cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcSalePrice(0,
                                                    vCategory,
                                                    vSubCategory,
                                                    vGroup,
                                                    vCostprice);
      //cSalePrice := cdsModel.fieldByName('SellingPrice').Value;
  end
  else begin
     if ( trim(edtSellingPrice.Text) <> '' ) then begin
        edtSellingPrice.Enabled := dbckAdjustManually.Checked;
        cSalePrice := strToFloat(edtSellingPrice.Text);
        if ( cSalePrice = 0 ) then
           exit;
     end;
  end;


  //marginTableValue := ( cdsModel.fieldByName('SellingPrice').value - vCostPrice ) / (cdsModel.fieldByName('SellingPrice').value);
  //edtMargin.Text := floatToStrF(marginTableValue * 100, ffNumber, 15, 2) + '%';
  //YAA April 28, 2012: Replace above
  edtMargin.Text := CalcActualMargin(cdsModel.fieldByName('SellingPrice').value, vCostPrice);


//  edtSellingPrice.Enabled := false;
//  edtSellingPrice.Color   := clBtnFace;

  if ( not dbckAdjustManually.Checked ) then begin
      if ( trim(dbedMarkup.Text) <> '' ) then begin
         desiredMargin := strToFloat(dbedMarkup.Text);

         toCompareDesireMargin := floatToStrF((desiredMargin/100), ffNumber, 15, 2);
         toCompareMargin       := floatToStrF(marginTableValue, ffNumber, 15, 2);

         if ( toCompareDesireMargin  = toCompareMargin ) then
            exit;

         cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.GetMarginPrice(vcostPrice ,desiredMargin);

         //YAA April 28, 201 2: Adding "if" condition for safety
         if not VarIsEmpty(cdsModel.fieldByName('IDGroup').Value) and
            not VarIsNull(cdsModel.fieldByName('IDGroup').Value) then
         begin
           cdsModel.FieldByName('SellingPrice').Value := dm.FDMCalcPrice.CalcRounding(cdsModel.fieldByName('IDGroup').Value, cdsModel.FieldByName('SellingPrice').Value);
         end;

         edtSellingPrice.Text := FloatToStrF(cdsModel.FieldByName('SellingPrice').Value, ffNumber, 15, 2);

         //newMargin := (cdsModel.FieldByName('SellingPrice').Value - cdsModel.fieldByName('vendorCost').Value) / (cdsModel.FieldByName('SellingPrice').Value);
         //edtMargin.Text := FloatToStrF(newMargin, ffNumber, 15, 2);
         //YAA April 28, 2012: Replace above
         edtMargin.Text := CalcActualMargin(cdsModel.fieldByName('SellingPrice').value, cdsModel.fieldByName('vendorCost').Value);
      end;
  end;
end;


procedure TfrmModelAdd.SellingPriceManually;
begin
;
end;

procedure TfrmModelAdd.SellingPriceByMarkupFromCatalog(ACostPrice: Double);
begin

end;

function TfrmModelAdd.isValidVendor(AIdVendor: Integer): boolean;
var
  dsValidVendor: TADOQuery;
  sql : String;
begin
  try
    sql := 'select IdFornecedor from VWFornecedor where IdFornecedor = :idvendor';
    dsValidVendor := TADOQuery.Create(nil);
    dsValidVendor.Connection := Dm.ADODBConnect;
    dsValidVendor.SQL.Text := sql;
    dsValidVendor.Parameters.ParamByName('idvendor').Value := AIdVendor;
    dsValidVendor.Open;

    result := ( not dsValidVendor.FieldByName('idfornecedor').IsNull );

  finally
    freeAndNil(dsValidVendor);
  end;
end;

procedure TfrmModelAdd.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  isBarcodeVerified := false;
end;

procedure TfrmModelAdd.dbedMarkupChange(Sender: TObject);
//*** YAA April 27, 2012: To be used below ***
var
  Margin: Real;
//********************************************
begin
  inherited;

  //*** YAA April 27, 2012: To make the colors of the  ***
  //*** "edtSellingPrice" TEdit consistent with if it  ***
  //*** is editable or not                             ***
  Margin:= StrToFloatDef(dbedMarkup.Text, 0);
  if (Margin > 0) and (Margin < 100) then
  begin
    edtSellingPrice.Enabled:= False;
    edtSellingPrice.Color := clBtnFace;
    DoCalcPrices(self);
  end
  else if (not FUseMarginTable) or
          (dbckAdjustManually.Checked) then
  begin
    edtSellingPrice.Enabled:= True;
    edtSellingPrice.Color := clWindow;

    //amfsouza June 26, 2012
    DoCalcPrices(self);
  end;
  //******************************************************
end;

//NAC 20120428 To promote code reutilization
function TfrmModelAdd.CalcActualMargin(aSellingPrice,
  aCostPrice: Real): string;
var
  marginTableValue: Real;
begin
  Result:= '';
  if aSellingPrice = 0 then Exit;
  marginTableValue := ( aSellingPrice - aCostPrice ) / aSellingPrice;
  Result := floatToStrF(marginTableValue * 100, ffNumber, 15, 2) + '%'; //YAA April 28, 2012: Making this text a percentage
end;

procedure TfrmModelAdd.edtUnitCostChange(Sender: TObject);
begin
  inherited;
  //YAA April 28, 2012: Actual margin calculation
  edtMargin.Text:= CalcActualMargin(StrToFloatDef(edtSellingPrice.Text, 0), StrToFloatDef(edtUnitCost.Text, 0));
end;

procedure TfrmModelAdd.edtDescriptionChange(Sender: TObject);
begin
  inherited;
{
  if ( isInvalidChar(edtDescription.Text) ) then begin
     edtDescription.SetFocus;
     exit;
  end;
 }
end;

procedure TfrmModelAdd.edtModelChange(Sender: TObject);
begin
  inherited;
{
  if ( isInvalidChar(edtModel.Text) ) then begin
     edtModel.SetFocus;
     exit;
  end;
 }

end;

procedure TfrmModelAdd.edtModelKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if ( isInvalidChar(key) ) then begin
     key := #0;
     edtModel.SetFocus;
  end;


end;

end.
