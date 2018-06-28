unit uFrmQuickEntryListInsert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentQuickEntryList, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridTableView,
  DBClient, siComp, siLangRT, StdCtrls, Buttons, PanelRights, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, LblEffct, ExtCtrls, cxCheckBox;

type
  TFrmQuickEntryListInsert = class(TFrmParentQuickEntryList)
    Label2: TLabel;
    cdsModelIDSize: TIntegerField;
    cdsModelIDColor: TIntegerField;
    cdsModelIDUnit: TIntegerField;
    cdsModelIDVendor: TIntegerField;
    cdsModelIDVendorModelCode: TIntegerField;
    cdsModelVendorCode: TStringField;
    cdsModelIDInventory: TIntegerField;
    cdsModelIDStore: TIntegerField;
    cdsModelQtyOnHand: TFloatField;
    cdsModelModelType: TStringField;
    cdsModelVerify: TBooleanField;
    btRemove: TSpeedButton;
    grdModelListDBIDManufacturer: TcxGridDBColumn;
    grdModelListDBIDBarcode: TcxGridDBColumn;
    grdModelListDBIDVendor: TcxGridDBColumn;
    grdModelListDBVendorCode: TcxGridDBColumn;
    grdModelListDBMarginInfo: TcxGridDBColumn;
    grdModelListDBMarkupInfo: TcxGridDBColumn;
    grdModelListDBQtyOnHand: TcxGridDBColumn;
    grdModelListDBMinQty: TcxGridDBColumn;
    cdsModelIDBarcode: TStringField;
    cdsModelID: TFloatField;
    cdsModelBarcodeCase: TStringField;
    grdModelListDBBarcodeCase: TcxGridDBColumn;
    cxBarcodeCase: TcxStyle;
    procedure cdsModelNewRecord(DataSet: TDataSet);
    procedure btSaveClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure cdsModelBeforePost(DataSet: TDataSet);
    procedure cdsModelAfterCancel(DataSet: TDataSet);
    procedure grdModelListDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsModelIDBarcodeValidate(Sender: TField);
    procedure grdModelListDBQtyOnHandPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    dMarkup : Double;
    procedure InsertModels;
    procedure LoadImage; override;
  public

  end;

var
  FrmQuickEntryListInsert: TFrmQuickEntryListInsert;

implementation

uses uDM, uSystemConst, uContentClasses, uObjectServices, uMsgBox, uMsgConstant,
  uWebFunctions;

{$R *.dfm}

procedure TFrmQuickEntryListInsert.cdsModelNewRecord(
  DataSet: TDataSet);
begin
  inherited;

  cdsModel.FieldByName('ModelType').Value   := MODEL_TYPE_REGULAR;
  cdsModel.FieldByName('ID').Value          := StrToFloat(FormatDateTime('yymmddhhmmsszzz' ,now));
  cdsModel.FieldByName('Verify').AsBoolean  := True;
  cdsModel.FieldByName('MinQty').AsInteger  := 1;
  if dMarkup <> 0 then
    cdsModel.FieldByName('Markup').AsFloat  := dMarkup;

  if (DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_MODEL]) then
    cdsModelModel.AsString := FDMInventory.GetValidModelCode;
end;

procedure TFrmQuickEntryListInsert.btSaveClick(Sender: TObject);
begin
  InsertModels;
end;

procedure TFrmQuickEntryListInsert.InsertModels;
var
  BarcodeService: TMRBarcodeService;
  Barcode: TBarcode;
  i: integer;
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

    grdModelListDB.Preview.Visible := False;

    with cdsModel do
    if not IsEmpty then
    try
      DisableControls;
      First;

      while not Eof do
      begin
        if ValidateFields then
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
          Barcode.Model.Markup                            := FieldByName('Markup').AsFloat;
          Barcode.Model.Verify                            := True;
          Barcode.Model.IDUserLastSellingPrice            := DM.fUser.ID;
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
          Barcode.Model.ModelVendor.MinQtyPO              := FieldByName('MinQty').AsFloat;
          Barcode.Model.ModelVendor.CaseQty               := FieldByName('CaseQty').AsFloat;
          //Inventory
          Barcode.Model.Inventory.IDInventory             := Null;
          Barcode.Model.Inventory.IDUser                  := DM.fUser.ID;
          Barcode.Model.Inventory.IDStore                 := DM.fStore.ID;
          Barcode.Model.Inventory.QtyOnHand               := FieldByName('QtyOnHand').AsFloat;
          Barcode.Model.Inventory.MinQty                  := FieldByName('MinQty').AsFloat;
          Barcode.Model.Inventory.MaxQty                  := FieldByName('MaxQty').AsFloat;
          //Import
          BarcodeService.Import(Barcode);
          //Deletar o registro
          Delete;
        end
      else
        Next;
      end;
    finally
      EnableControls;
    end;

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
      if grdModelListDB.Preview.Visible then
        ModalResult := mrNone
      else
        cdsModel.Close;
      end;

end;

procedure TFrmQuickEntryListInsert.btRemoveClick(Sender: TObject);
begin
  with cdsModel do
    if Active then
      if (not IsEmpty) and (RecordCount>1) then
      begin
        Edit;
        Delete;
      end;
end;

procedure TFrmQuickEntryListInsert.LoadImage;
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
end;

procedure TFrmQuickEntryListInsert.cdsModelBeforePost(DataSet: TDataSet);
begin
  inherited;
{  if cdsModel.RecordCount > 0 then
   if not (ValidateFields) then
    begin
    end

  if not(ValidateFields) then
  begin
    with cdsModel do
    begin
      cdsModelModel.FocusControl;
      {DisableControls;
      Cancel;
      grdModelListDB.DataController.Cancel;
      cdsModel.Prior;
      EnableControls;
    end;
  end;  }
end;

procedure TFrmQuickEntryListInsert.cdsModelAfterCancel(DataSet: TDataSet);
begin
  inherited;
  cdsModel.EnableConstraints;
end;

procedure TFrmQuickEntryListInsert.grdModelListDBKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if grdModelListDB.Focused and (cdsModel.RecordCount <= 1) and (Key in [VK_ESCAPE, VK_DELETE]) then
    Key := VK_CLEAR;
end;

procedure TFrmQuickEntryListInsert.cdsModelIDBarcodeValidate(
  Sender: TField);
begin
  inherited;

  if DM.fSystem.SrvParam[PARAM_USE_CATALOG] then
    if (TField(Sender).Text <> '') then
       CatalogSearch(TField(Sender).Text);

end;

procedure TFrmQuickEntryListInsert.grdModelListDBQtyOnHandPropertiesValidate(
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

procedure TFrmQuickEntryListInsert.spHelpClick(Sender: TObject);
begin
  inherited;
  OpenURL('http://www.mainretail.com.br/treinamento/Cadastro/Cad_Produto_Comum.htm');
end;

procedure TFrmQuickEntryListInsert.btnVideoClick(Sender: TObject);
begin
  inherited;
  OpenURL('http://www.mainretail.com.br/treinamento/video/Adicionar_Produto_Listagem/Adicionar_Produto_Listagem.html');
end;

end.
