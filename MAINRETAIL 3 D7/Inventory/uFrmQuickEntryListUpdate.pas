unit uFrmQuickEntryListUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentQuickEntryList, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridTableView,
  DBClient, siComp, siLangRT, StdCtrls, Buttons, PanelRights, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, LblEffct, ExtCtrls;

type
  TFrmQuickEntryListUpdate = class(TFrmParentQuickEntryList)
    grdModelListDBUpdate: TcxGridDBColumn;
    btSelectAll: TSpeedButton;
    btUnSelectAll: TSpeedButton;
    cdsModelUpdate: TBooleanField;
    cdsModelDateLastCost: TDateTimeField;
    cdsModelIDUserLastSellingPrice: TIntegerField;
    cdsModelDateLastSellingPrice: TDateTimeField;
    procedure btSaveClick(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure cdsModelVendorCostChange(Sender: TField);
    procedure cdsModelSellingPriceChange(Sender: TField);
  private
    procedure UpdateModels;
    procedure SetSelectAll(Value: Boolean);
    procedure UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
  protected
    procedure RefreshInfo; override; 
  public

  end;

var
  FrmQuickEntryListUpdate: TFrmQuickEntryListUpdate;

implementation

uses uDM, uSystemConst, uContentClasses, uObjectServices, uMsgBox, uMsgConstant,
     uCDSFunctions;

{$R *.dfm}

{ TFrmQuickEntryListUpdate }

procedure TFrmQuickEntryListUpdate.UpdateModels;
var
  ModelService: TMRModelService;
  Model: TModel;
  i: integer;
begin

  try
    ModelService                  := TMRModelService.Create;
    Model                         := TModel.Create;
    Model.Category                := TCategory.Create;
    Model.ModelGroup              := TModelGroup.Create;
    Model.ModelSubGroup           := TModelSubGroup.Create;
    Model.Manufacturer            := TManufacturer.Create;

    ModelService.SQLConnection := DM.ADODBConnect;

    grdModelListDB.Preview.Visible := False;

    with cdsModel do
    if not IsEmpty then
    try
      DisableControls;

      Filter := 'Update = 1';
      Filtered := True;

      First;
      while not Eof do
      begin
        if ValidateFields then
        begin
          //Model
          Model.IDModel                           := FieldByName('IDModel').AsInteger;
          Model.Model                             := FieldByName('Model').AsString;
          Model.Description                       := FieldByName('Description').AsString;
          Model.CaseQty                           := FieldByName('CaseQty').AsFloat;
          Model.SellingPrice                      := FieldByName('SellingPrice').AsCurrency;
          Model.SuggRetail                        := FieldByName('SuggRetail').AsCurrency;
          Model.VendorCost                        := FieldByName('VendorCost').AsCurrency;
          Model.Markup                            := FieldByName('Markup').AsFloat;
          Model.IDUserLastSellingPrice            := FieldByName('IDUserLastSellingPrice').AsInteger;
          Model.DateLastCost                      := FieldByName('DateLastCost').AsDateTime;
          Model.DateLastSellingPrice              := FieldByName('DateLastSellingPrice').AsDateTime;
          Model.Category.IDGroup                  := FieldByName('IDGroup').AsInteger;
          Model.ModelGroup.IDModelGroup           := FieldByName('IDModelGroup').AsInteger;
          Model.ModelSubGroup.IDModelSubGroup     := FieldByName('IDModelSubGroup').AsInteger;
          Model.Manufacturer.IDManufacturer       := FieldByName('IDManufacturer').AsInteger;

          //Update
          ModelService.Update(Model);

          // Update KitModel
          UpdateKitPromoPrice(Model.IDModel, Model.VendorCost);

          //Deleta o registro do cds
          Delete;
        end
        else
          Next;
      end;
    finally
      Filter := '';
      Filtered := False;
      EnableControls;
    end;

  finally
    FreeAndNil(Model.Category);
    FreeAndNil(Model.ModelGroup);
    FreeAndNil(Model.ModelSubGroup);
    FreeAndNil(Model.Manufacturer);
    FreeAndNil(Model);
    FreeAndNil(ModelService);
    if grdModelListDB.Preview.Visible then
      ModalResult := mrNone
    else
      cdsModel.Close;
    end;

end;

procedure TFrmQuickEntryListUpdate.UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
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

procedure TFrmQuickEntryListUpdate.btSaveClick(Sender: TObject);
begin
  UpdateModels;
end;

procedure TFrmQuickEntryListUpdate.btSelectAllClick(Sender: TObject);
begin
  SetSelectAll(True);
end;

procedure TFrmQuickEntryListUpdate.SetSelectAll(Value: Boolean);
begin
  with cdsModel do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Update').AsBoolean := Value;
        Post;
        Next;
      end;
      First;
    end;
  finally
    EnableControls;
    Cursor := crDefault;
  end;
end;

procedure TFrmQuickEntryListUpdate.btUnSelectAllClick(Sender: TObject);
begin
  inherited;
  SetSelectAll(False);
end;

procedure TFrmQuickEntryListUpdate.cdsModelVendorCostChange(Sender: TField);
begin
  inherited;

  cdsModel.FieldByName('DateLastCost').Value := Now;
end;

procedure TFrmQuickEntryListUpdate.cdsModelSellingPriceChange(
  Sender: TField);
begin
  inherited;

  cdsModel.FieldByName('DateLastSellingPrice').Value := Now;
  cdsModel.FieldByName('IDUserLastSellingPrice').Value := DM.fUser.ID;
end;

procedure TFrmQuickEntryListUpdate.RefreshInfo;
begin
  inherited;

  cdsModel.FieldByName('DateLastSellingPrice').Value := Now;
  cdsModel.FieldByName('IDUserLastSellingPrice').Value := DM.fUser.ID;
end;

end.
