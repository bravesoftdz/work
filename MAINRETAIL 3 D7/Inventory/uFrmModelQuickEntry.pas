unit uFrmModelQuickEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  DBCtrls, Mask, SuperComboADO, ADODB, DB, DBClient, uInventoryCalc, uDMInventory,
  uContentClasses, uObjectServices, Buttons;

type
  TFrmModelQuickEntry = class(TFrmParent)
    lblCategory: TLabel;
    lblDescription: TLabel;
    lblManufacturer: TLabel;
    lblGroup: TLabel;
    lblSubCategory: TLabel;
    lblUnit: TLabel;
    lbCaseQty: TLabel;
    lblSize: TLabel;
    lblColor: TLabel;
    btAdd: TButton;
    lblModel: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lblModelInformation: TLabel;
    lblBarcode: TLabel;
    dtsModel: TDataSource;
    edtDescription: TDBEdit;
    edtCaseQty: TDBEdit;
    edtModel: TDBEdit;
    edtBarcode: TDBEdit;
    scManufacturer: TDBSuperComboADO;
    scCategory: TDBSuperComboADO;
    scGroup: TDBSuperComboADO;
    scSubCategory: TDBSuperComboADO;
    scUnit: TDBSuperComboADO;
    scColor: TDBSuperComboADO;
    scSize: TDBSuperComboADO;
    cdsModel: TClientDataSet;
    cdsModelIDModel: TIntegerField;
    cdsModelDescription: TStringField;
    cdsModelModel: TStringField;
    cdsModelIDGroup: TIntegerField;
    cdsModelIDManufacturer: TIntegerField;
    cdsModelIDModelGroup: TIntegerField;
    cdsModelIDModelSubGroup: TIntegerField;
    cdsModelIDSize: TIntegerField;
    cdsModelIDColor: TIntegerField;
    cdsModelCaseQty: TFloatField;
    cdsModelIDUnit: TIntegerField;
    cdsModelVendorCost: TFloatField;
    cdsModelSuggRetail: TFloatField;
    cdsModelSellingPrice: TFloatField;
    cdsModelIDBarcode: TStringField;
    cdsModelIDVendor: TIntegerField;
    cdsModelIDVendorModelCode: TIntegerField;
    cdsModelVendorCode: TStringField;
    cdsModelIDInventory: TIntegerField;
    cdsModelIDStore: TIntegerField;
    cdsModelQtyOnHand: TFloatField;
    cdsModelMaxQty: TFloatField;
    cdsModelMinQty: TFloatField;
    cdsModelModelType: TStringField;
    spAdjustInventory: TADOStoredProc;
    lbCasePrice: TLabel;
    edtCasePrice: TEdit;
    cdsModelVerify: TBooleanField;
    pnlDetail: TPanel;
    lblMinQty: TLabel;
    lblMaxQty: TLabel;
    lblUnitCost: TLabel;
    lblPricing: TLabel;
    lblOurPrice: TLabel;
    lblMSRP: TLabel;
    lblEstoque: TLabel;
    lblQtyOnHand: TLabel;
    edtMinQty: TDBEdit;
    edtMaxQty: TDBEdit;
    edtUnitCost: TDBEdit;
    edtOurPrice: TDBEdit;
    edtMSRP: TDBEdit;
    edtQtyOnHand: TDBEdit;
    Label3: TLabel;
    cdsModelVendorMinQtyPO: TFloatField;
    cdsModelVendorCaseQty: TFloatField;
    pnlVendor: TPanel;
    lblVendorInfo: TLabel;
    lblVendorPart: TLabel;
    edtVendorPart: TDBEdit;
    lbMinQtyPO: TLabel;
    edMinQtyPO: TDBEdit;
    lblVendor: TLabel;
    scVendor: TDBSuperComboADO;
    lbQtyType: TLabel;
    edCaseQtyPO: TDBEdit;
    cdsVendorSuggestion: TClientDataSet;
    cdsVendorSuggestionIDVendor: TIntegerField;
    cdsVendorSuggestionVendor: TStringField;
    cdsVendorSuggestionVendorCode: TStringField;
    cdsVendorSuggestionMinQtyPO: TFloatField;
    cdsVendorSuggestionCaseQty: TFloatField;
    cdsVendorSuggestionVendorCost: TCurrencyField;
    btnVendorSuggestion: TSpeedButton;
    lbBarcodeCase: TLabel;
    edtBarcodeCase: TDBEdit;
    cdsModelBarcodeCase: TStringField;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCaseQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btAddClick(Sender: TObject);
    procedure edtUnitCostKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoCalcPrices(Sender: TObject);
    procedure edtCasePriceKeyPress(Sender: TObject; var Key: Char);
    procedure edtCasePriceExit(Sender: TObject);
    procedure edtCaseQtyExit(Sender: TObject);
    procedure scCategorySelectItem(Sender: TObject);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtUnitCostExit(Sender: TObject);
    procedure edtMSRPExit(Sender: TObject);
    procedure edtOurPriceExit(Sender: TObject);
    procedure btnVendorSuggestionClick(Sender: TObject);
    procedure cdsModelCaseQtyChange(Sender: TField);
    procedure edtModelExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    FDMInventory: TDMInventory;
    FLogError: TStringList;
    FApplyOnClose: Boolean;
    FVerifyModel: Boolean;
    FCloseAfterInsert : Boolean;
    FUPC : String;
    FSalePriceMargem: TPriceMargem;
    FMSRPMargem: TPriceMargem;
    FBarcode : TBarcode;

    procedure NewModel;
    procedure ApplyQuickEntries;

    function ValidateFields: Boolean;
    function ValidateModel: Boolean;
    function ValidateBarcode: Boolean;
    procedure VerifyModelCatalog;
  public
    function Start(ApplyOnClose, CloseAfterInsert, VerifyModel : Boolean; Barcode: String): TBarcode;
  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uCharFunctions, uMsgConstant, uSystemConst,
  uDMCalcPrice, uDMParent, uFrmListVendor, uWebFunctions;

{$R *.dfm}

{ TFrmModelQuickEntry }

procedure TFrmModelQuickEntry.FormCreate(Sender: TObject);
begin
  inherited;
  FDMInventory := TDMInventory.Create(Self);
  FLogError := TStringList.Create;
  FBarcode := TBarcode.Create;
  FBarcode.Model := TModel.Create;
end;

procedure TFrmModelQuickEntry.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDMInventory);
  FreeAndNil(FLogError);
  FreeAndNil(FBarcode);
end;

procedure TFrmModelQuickEntry.edtCaseQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmModelQuickEntry.edtUnitCostKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmModelQuickEntry.btAddClick(Sender: TObject);
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

procedure TFrmModelQuickEntry.DoCalcPrices(Sender: TObject);
var
  cSalePrice,
  cSuggRetail : Currency;
begin
  if edtUnitCost.Modified then
  begin

    cdsModelVendorCost.AsCurrency := DM.FDMCalcPrice.FormatPrice(cdsModelVendorCost.AsCurrency);

    if not cdsModelIDGroup.IsNull then
    begin
      cSalePrice := DM.FDMCalcPrice.CalcSalePrice(cdsModelIDModel.AsInteger,
                                                  cdsModelIDGroup.AsInteger,
                                                  cdsModelIDModelGroup.AsInteger,
                                                  cdsModelIDModelSubGroup.AsInteger,
                                                  cdsModelVendorCost.AsCurrency);

      if (cSalePrice <> 0) and (cSalePrice <> cdsModelVendorCost.AsCurrency) then
        cdsModelSellingPrice.AsCurrency := cSalePrice;

      cSuggRetail := DM.FDMCalcPrice.CalcMSRPPrice(cdsModelIDGroup.AsInteger,
                                                   cdsModelIDModelGroup.AsInteger,
                                                   cdsModelIDModelSubGroup.AsInteger,
                                                   cdsModelVendorCost.AsCurrency);

      if (cSuggRetail <> 0) and (cSuggRetail <> cdsModelVendorCost.AsCurrency) then
        cdsModelSuggRetail.AsCurrency := cSuggRetail;


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
end;

procedure TFrmModelQuickEntry.ApplyQuickEntries;
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
     MsgBox(E.Message, vbCritical + vbOKOnly);
  end;
end;

function TFrmModelQuickEntry.Start(ApplyOnClose, CloseAfterInsert,
   VerifyModel : Boolean; Barcode: String): TBarcode;
begin
  FApplyOnClose := ApplyOnClose;
  FVerifyModel := VerifyModel;
  FCloseAfterInsert := CloseAfterInsert;
  FUPC := Barcode;
  FBarcode.Model.IDModel := -1;
  cdsModel.CreateDataSet;
  NewModel;
  ShowModal;
  Result := FBarcode;
end;

procedure TFrmModelQuickEntry.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if FApplyOnClose then
    ApplyQuickEntries;
  cdsModel.Close;
end;

procedure TFrmModelQuickEntry.NewModel;
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

    lbCasePrice.Visible  := False;
    edtCasePrice.Visible := False;
    pnlDetail.Visible    := False;

    if DM.fSystem.SrvParam[PARAM_USE_CATALOG] and (FieldByName('IDBarcode').AsString <> '') then
      VerifyModelCatalog;

    if (cdsModelModel.AsString = '') and DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL] then
      cdsModelModel.AsString := FDMInventory.GetValidModelCode;

  except
   on E: Exception do
     MsgBox(E.Message, vbCritical + vbOKOnly);
  end;
end;

procedure TFrmModelQuickEntry.edtCasePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmModelQuickEntry.edtCasePriceExit(Sender: TObject);
begin
  inherited;
  edtCasePrice.Text := CurrToStr(DM.FDMCalcPrice.FormatPrice(MyStrToMoney(edtCasePrice.Text)));

  if (MyStrToMoney(edtCasePrice.Text) <> 0) and
     (cdsModelCaseQty.AsFloat <> 0)  then
  begin
    cdsModelVendorCost.AsCurrency := MyStrToMoney(edtCasePrice.Text)/cdsModelCaseQty.AsFloat;
    cdsModelVendorCost.FocusControl;
  end;
end;

procedure TFrmModelQuickEntry.edtCaseQtyExit(Sender: TObject);
begin
  inherited;
  lbCasePrice.Visible  := (cdsModelCaseQty.AsFloat > 1);
  edtCasePrice.Visible := lbCasePrice.Visible;
  if edtCasePrice.Visible then
    edtCasePrice.SetFocus; 
end;

procedure TFrmModelQuickEntry.scCategorySelectItem(Sender: TObject);
begin
  inherited;
  pnlDetail.Visible := True;
  DoCalcPrices(Sender);
end;

function TFrmModelQuickEntry.ValidateModel: Boolean;
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

function TFrmModelQuickEntry.ValidateBarcode: Boolean;
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

function TFrmModelQuickEntry.ValidateFields: Boolean;
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

  if edtOurPrice.Text = '' then
  begin
    FLogError.Add(MSG_CRT_NO_EMPTY_SELLING);

    if edtOurPrice.CanFocus then
      edtOurPrice.SetFocus
    else if not(pnlDetail.Visible) then
    begin
      pnlDetail.Visible := True;
      edtOurPrice.SetFocus
    end;

    Exit;
  end;

  if (cdsModelSellingPrice.AsCurrency < cdsModelVendorCost.AsCurrency) then
  begin
    FLogError.Add(MSG_INF_NOT_SELL_BELLOW_COST);

    if edtOurPrice.CanFocus then
      edtOurPrice.SetFocus;

    Exit;
  end;

  Result := True;
end;

procedure TFrmModelQuickEntry.edtBarcodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) and (Trim(edtBarcode.Text) <> '') and (DM.fSystem.SrvParam[PARAM_USE_CATALOG]) then
    VerifyModelCatalog;
end;

procedure TFrmModelQuickEntry.VerifyModelCatalog;
var
  CatalogBarcodeService: TCatalogBarcodeService;
  Barcode: TBarcode;
  i : integer;
begin
  try
    CatalogBarcodeService := TCatalogBarcodeService.Create();
    Barcode               := TBarcode.Create();

    CatalogBarcodeService.SQLConnection := DM.ADODBConnect;

    Barcode.IDBarcode  := edtBarcode.Text;

    CatalogBarcodeService.Find(Barcode);

    if Assigned(Barcode.Model) then
    begin
      //if not DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL] then
      cdsModelModel.Value       := Barcode.Model.Model;
      cdsModelDescription.Value := Barcode.Model.Description;
      cdsModelCaseQty.Value     := Barcode.Model.CaseQty;
      cdsModelSuggRetail.Value  := Barcode.Model.SuggRetail;
      cdsModelVendorCost.Value  := 0;
      cdsModelBarcodeCase.Value := Barcode.BarcodeCase;

      if VarToStr(Barcode.Model.Category.IDGroup) <> '' then
      begin
        cdsModelIDGroup.Value := Barcode.Model.Category.IDGroup;
        pnlDetail.Visible     := True;
      end;

      if VarToStr(Barcode.Model.ModelGroup.IDModelGroup) <> '' then
        cdsModelIDModelGroup.Value    := Barcode.Model.ModelGroup.IDModelGroup;

      if VarToStr(Barcode.Model.ModelSubGroup.IDModelSubGroup) <> '' then
        cdsModelIDModelSubGroup.Value := Barcode.Model.ModelSubGroup.IDModelSubGroup;

      if Barcode.Model.Manufacturer.IDManufacturer <> 0 then
        cdsModelIDManufacturer.Value := Barcode.Model.Manufacturer.IDManufacturer;

      if Barcode.Model.Vendor.IDVendor <> 0 then
      begin
        cdsModelVendorCode.Value  := Barcode.Model.VendorModelCode.VendorCode;
        cdsModelIDVendor.Value    := Barcode.Model.Vendor.IDVendor;
        cdsModelVendorCost.Value  := Barcode.Model.VendorCost;

        if Barcode.Model.ModelVendor.IDVendor <> 0 then
        begin
          cdsModelVendorCaseQty.Value  := Barcode.Model.ModelVendor.CaseQty;
          cdsModelVendorMinQtyPO.Value := Barcode.Model.ModelVendor.MinQtyPO;
        end;
      end;

      Barcode.Model.Vendor.Vendor := scVendor.Text;

      if (Barcode.Model.VendorCost = 0) and CatalogBarcodeService.FindByVendor(Barcode) then
        cdsModelVendorCost.Value  := Barcode.Model.VendorCost;


      if Barcode.Model.Category.IDGroup <> 0 then
      begin
        DoCalcPrices(Self);
        if cdsModelVendorCost.Value = cdsModelSuggRetail.Value then
          cdsModelSuggRetail.Value := Barcode.Model.SuggRetail;
      end;

      btnVendorSuggestion.Visible := (Barcode.Model.FSuggestedVendor.Count > 1);

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
  finally
    if Assigned(CatalogBarcodeService) then
      FreeAndNil(CatalogBarcodeService);

    if Assigned(Barcode) then
      FreeAndNil(Barcode);
  end;
end;

procedure TFrmModelQuickEntry.edtBarcodeExit(Sender: TObject);
begin

  if not ValidateBarcode then
  begin
    if FLogError.Text <> '' then
    begin
      MsgBox(FLogError.Text, vbInformation + vbOKOnly);
      FLogError.Clear;
      Exit;
    end;
  end;
  FBarcode.IDBarcode := Null;

  if (Trim(edtBarcode.Text) <> '') then
  begin
   FBarcode.IDBarcode := edtBarcode.Text;
   if (DM.fSystem.SrvParam[PARAM_USE_CATALOG]) then
     VerifyModelCatalog;
  end;

end;

procedure TFrmModelQuickEntry.edtUnitCostExit(Sender: TObject);
begin
  inherited;
  if (cdsModelCaseQty.AsFloat <> 0) then
    edtCasePrice.Text := FloatToStr(cdsModelVendorCost.AsFloat * cdsModelCaseQty.AsFloat);

  DoCalcPrices(Sender);
end;

procedure TFrmModelQuickEntry.edtMSRPExit(Sender: TObject);
begin
  inherited;
  cdsModelSuggRetail.AsCurrency := DM.FDMCalcPrice.FormatPrice(cdsModelSuggRetail.AsCurrency);
end;

procedure TFrmModelQuickEntry.edtOurPriceExit(Sender: TObject);
begin
  inherited;
  cdsModelSellingPrice.AsCurrency := DM.FDMCalcPrice.FormatPrice(cdsModelSellingPrice.AsCurrency);
end;

procedure TFrmModelQuickEntry.btnVendorSuggestionClick(Sender: TObject);
begin
  inherited;
  with TFrmListVendor.Create(Self) do
    if Start(cdsVendorSuggestion) <> -1 then
    begin
      cdsModelIDVendor.Value       := cdsVendorSuggestion.FieldByName('IDVendor').AsInteger;
      cdsModelVendorCode.Value     := cdsVendorSuggestion.FieldByName('VendorCode').AsString;
      cdsModelVendorCaseQty.Value  := cdsVendorSuggestion.FieldByName('CaseQty').AsFloat;
      cdsModelVendorMinQtyPO.Value := cdsVendorSuggestion.FieldByName('MinQtyPO').AsFloat;
      cdsModelVendorCost.Value     := cdsVendorSuggestion.FieldByName('VendorCost').AsCurrency;
      if pnlDetail.Visible then
        DoCalcPrices(Sender);
    end;
end;

procedure TFrmModelQuickEntry.cdsModelCaseQtyChange(Sender: TField);
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

procedure TFrmModelQuickEntry.edtModelExit(Sender: TObject);
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
procedure TFrmModelQuickEntry.spHelpClick(Sender: TObject);
begin
  inherited;
  OpenURL('http://www.mainretail.com.br/treinamento/Cadastro/Cad_Produto_Comum.htm');
end;

procedure TFrmModelQuickEntry.btnVideoClick(Sender: TObject);
begin
  inherited;
  OpenURL('http://www.mainretail.com.br/treinamento/video/Adicionar_Produto_Cadastro_Rapido/Adicionar_Produto_Cadastro_Rapido.html');
end;

end.
