unit uDMImportInventoryCatalog;

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, StdVcl, ADODB, DB, Provider, uDMCalcPrice;

type
  TDMImportInventoryCatalog = class(TDataModule)
    cmdUpdateModelPrice: TADOCommand;
    qryProducts: TADODataSet;
    qryProductsMark: TBooleanField;
    qryProductssku: TStringField;
    qryProductsupc: TStringField;
    qryProductsTitle: TStringField;
    qryProductsPriceInfo: TStringField;
    qryProductsVendorCost: TCurrencyField;
    qryProductswholesale: TBCDField;
    qryProductsVendor: TStringField;
    qryProductsCategory: TStringField;
    qryProductsSubCategory: TStringField;
    qryProductsCGroup: TStringField;
    qryProductsTax_Category: TStringField;
    qryProductsMfg: TStringField;
    qryProductsIDModel: TIntegerField;
    qryProductsModel: TStringField;
    qryProductsDescription: TStringField;
    qryProductsFinalCost: TBCDField;
    qryProductsSellingPrice: TBCDField;
    qryProductsSuggRetail: TBCDField;
    qryProductsManufacture: TStringField;
    qryProductsIDCategory: TIntegerField;
    qryProductsIDSubCategory: TIntegerField;
    qryProductsIDGroup: TIntegerField;
    qryProductsModelCategory: TStringField;
    qryProductsModelSubCategory: TStringField;
    qryProductsModelGroup: TStringField;
    qryProductsNewSalePrice: TBCDField;
    qryProductsNewMSRPPrice: TBCDField;
    dspProducts: TDataSetProvider;
    cdsProducts: TClientDataSet;
    cmdUpdateInventory: TADOCommand;
    procedure DataModuleDestroy(Sender: TObject);
    procedure qryProductsCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    FLog: TStringList;
    FDMCalcPrice : TDMCalcPrice;
    FSQLConnection: TADOConnection;

    procedure OpenProducts;
    procedure CloseProducts;
    procedure FilterProducts(sFilter: WideString);
    procedure CalcSalePrice;
    procedure UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
  public
    property Log: TStringList read FLog write FLog;

    function GetInventoryList(const AFilter: WideString): OleVariant;
    function GetModelPricesList(const AFilter: WideString): OleVariant;
    function UpdateMRPricesWithCatalog(ModelList: OleVariant): Boolean;
    function UpdateMRInventoryWithCatalog(ModelList: OleVariant): Boolean;
    procedure SetConnection(SQLConnection: TADOConnection);
    procedure ConfigureCalcPrice(SQLConnection: TADOConnection);
  end;

var
  DMImportInventoryCatalog: TDMImportInventoryCatalog;

implementation

uses uSqlFunctions, uMRSQLParam, uDMGlobal, uSystemConst, uObjectServices, uContentClasses;

{$R *.dfm}

procedure TDMImportInventoryCatalog.OpenProducts;
begin
  with cdsProducts do
    if not Active then
      Open;
end;

procedure TDMImportInventoryCatalog.CloseProducts;
begin
  with cdsProducts do
    if Active then
      Close;
end;

procedure TDMImportInventoryCatalog.FilterProducts(sFilter : WideString);
var
  MRSQLParam : TMRSQLParam;
  sWhere : String;
begin

  CloseProducts;

  sWhere := ' CP.Inactive = 0 ';

  if sFilter <> '' then
  begin
    MRSQLParam := TMRSQLParam.Create;
    try
      MRSQLParam.ParamString := sFilter;

      if MRSQLParam.KeyExists('ModelExist') then
      begin
      sWhere := sWhere + ' AND CP.upc = B.IDBarcode ';
      MRSQLParam.Delete(MRSQLParam.IndexOf(MRSQLParam.KeyByName('ModelExist')));
      end;

      if MRSQLParam.KeyExists('CostEqual') then
      begin
      sWhere := sWhere + ' AND PV.vCost <> M.FinalCost ';
      MRSQLParam.Delete(MRSQLParam.IndexOf(MRSQLParam.KeyByName('CostEqual')));
      end;

      if MRSQLParam.KeyExists('DescriptionEqual') then
      begin
      sWhere := sWhere + ' AND CP.Title <> M.Description ';
      MRSQLParam.Delete(MRSQLParam.IndexOf(MRSQLParam.KeyByName('DescriptionEqual')));
      end;

      if MRSQLParam.Count > 0 then
        sWhere := sWhere + ' AND ' + MRSQLParam.GetWhereSQL;

    finally
      FreeAndNil(MRSQLParam);
      end;
  end;

  with qryProducts do
    CommandText := ChangeWhereClause(CommandText, sWhere, True);
end;

function TDMImportInventoryCatalog.UpdateMRPricesWithCatalog(ModelList: OleVariant): Boolean;
var
  cdsNewPrices : TClientDataSet;
  CostPrice: Currency;
begin
  cdsNewPrices := TClientDataSet.Create(nil);
  try
    cdsNewPrices.Data := ModelList;
    with cdsNewPrices do
    begin
      First;
      while not EOF do
      begin
        try
          CostPrice := FDMCalcPrice.FormatPrice(FieldByName('CostPrice').AsCurrency);

          cmdUpdateModelPrice.Parameters.ParamByName('IDModel').Value                := FieldByName('IDModel').AsInteger;
          cmdUpdateModelPrice.Parameters.ParamByName('NewCost').Value                := CostPrice;
          cmdUpdateModelPrice.Parameters.ParamByName('NewSalePrice').Value           := FieldByName('SalePrice').AsCurrency;
          cmdUpdateModelPrice.Parameters.ParamByName('NewMSRP').Value                := FieldByName('MSRP').AsCurrency;
          cmdUpdateModelPrice.Parameters.ParamByName('IDUserLastSellingPrice').Value := FieldByName('IDUserLastSellingPrice').AsInteger;
          cmdUpdateModelPrice.Parameters.ParamByName('ChangeDate').Value   := Now;
          cmdUpdateModelPrice.Execute;

          UpdateKitPromoPrice(FieldByName('IDModel').AsInteger, CostPrice);
        except
          on E: Exception do
            Log.Add('An error ocurred when update Model ' + FieldByName('Model').AsString + '. Error: ' + E.Message);
        end;
        Next;
      end;
    end;

  finally
    FreeAndNil(cdsNewPrices);
    end;
end;

procedure TDMImportInventoryCatalog.UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
var
  KitModelService: TMRKitModelService;
  KitModel: TKitModel;
begin
  with DMGlobal.qryFreeSQL do
  try
    if Active then
      Close;

    Connection := cmdUpdateModelPrice.Connection;
    SQL.Text   := ' SELECT Qty, MarginPerc FROM KitModel WHERE IDModel = ' + IntToStr(IDModel) + ' AND ISNULL(MarginPerc, 0) <> 0 ';
    Open;

    if not(IsEmpty) then
    try
      KitModelService                  := TMRKitModelService.Create();
      KitModel                         := TKitModel.Create();

      KitModelService.SQLConnection := cmdUpdateModelPrice.Connection;

      First;
      While not Eof do
      begin
        // Campos necessários
        KitModel.IDModel         := IDModel;
        KitModel.Qty             := FieldByName('Qty').AsFloat;
        if not DMGlobal.IsClientServer(FSQLConnection) then
          KitModel.SellingPrice    := FDMCalcPrice.GetMarginPrice(CostPrice, FieldByName('MarginPerc').AsFloat);
        KitModel.MarginPerc       := FieldByName('MarginPerc').AsFloat;

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

procedure TDMImportInventoryCatalog.CalcSalePrice;
var
  FNewSalePrice,
  FNewMSRPPrice, FCostPrice : Currency;
begin
  with cdsProducts do
    if Active then
    begin
      First;
      While not EOF do
      begin
        if (FieldByName('IDModel').AsString <> '') and (FieldByName('VendorCost').AsCurrency <> 0) then
        begin
          FCostPrice := FDMCalcPrice.FormatPrice(FieldByName('VendorCost').AsCurrency);

          FNewSalePrice := FDMCalcPrice.CalcSalePrice(FieldByName('IDModel').AsInteger,
                                                      FieldByName('IDCategory').AsInteger,
                                                      FieldByName('IDSubCategory').AsInteger,
                                                      FieldByName('IDGroup').AsInteger,
                                                      FCostPrice);

          FNewMSRPPrice := FDMCalcPrice.CalcMSRPPrice(FieldByName('IDCategory').AsInteger,
                                                      FieldByName('IDSubCategory').AsInteger,
                                                      FieldByName('IDGroup').AsInteger,
                                                      FCostPrice);

          if FNewSalePrice <> FCostPrice then
          begin
            Edit;
            FieldByName('NewSalePrice').AsCurrency := FNewSalePrice;
          end;


          if FNewMSRPPrice <> FCostPrice then
          begin
            Edit;
            FieldByName('NewMSRPPrice').AsCurrency := FNewMSRPPrice;
          end;

          if State in [dsEdit, dsInsert] then
            Post;

        end;

        Next;
      end;
    end;
end;

function TDMImportInventoryCatalog.GetModelPricesList(const AFilter: WideString): OleVariant;
begin
  Result := '';
  FilterProducts(AFilter);
  OpenProducts;
  CalcSalePrice;
  Result := cdsProducts.Data;
end;

function TDMImportInventoryCatalog.GetInventoryList(const AFilter: WideString): OleVariant;
begin
  Result := '';
  FilterProducts(AFilter);
  OpenProducts;
  Result := cdsProducts.Data;
end;

function TDMImportInventoryCatalog.UpdateMRInventoryWithCatalog(
  ModelList: OleVariant): Boolean;
var
  cdsNewInventory : TClientDataSet;
begin
  Result := False;

  cdsNewInventory := TClientDataSet.Create(nil);
  try
    cdsNewInventory.Data := ModelList;
    with cdsNewInventory do
    begin
      First;
      while not EOF do
      begin
        try
          cmdUpdateInventory.Parameters.ParamByName('IDModel').Value      := FieldByName('IDModel').AsInteger;
          cmdUpdateInventory.Parameters.ParamByName('Description').Value  := FieldByName('Description').AsString;
          cmdUpdateInventory.Execute;
        except
          on E: Exception do
            Log.Add('An error ocurred when update Model ' + FieldByName('Model').AsString + '. Error: ' + E.Message);
        end;
        Next;
      end;
      Result := True;
    end;

  finally
    FreeAndNil(cmdUpdateInventory);
    end;
end;

procedure TDMImportInventoryCatalog.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDMCalcPrice) then
    FreeAndNil(FDMCalcPrice);

  FreeAndNil(FLog);
end;

procedure TDMImportInventoryCatalog.qryProductsCalcFields(
  DataSet: TDataSet);
begin
  if ((qryProductsVendorCost.AsCurrency + qryProductsFinalCost.AsCurrency)/2) <> 0 then
    qryProductsPriceInfo.AsString := FormatFloat('0.00 %',((qryProductsVendorCost.AsCurrency - qryProductsFinalCost.AsCurrency)
                                       /((qryProductsVendorCost.AsCurrency + qryProductsFinalCost.AsCurrency)/2)*100));
end;

procedure TDMImportInventoryCatalog.SetConnection(SQLConnection: TADOConnection);
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if (Components[i] is TADODataSet) then
      TADODataSet(Components[i]).Connection := SQLConnection
    else if (Components[i] is TADOCommand) then
      TADOCommand(Components[i]).Connection := SQLConnection;

  FSQLConnection := SQLConnection;
end;

procedure TDMImportInventoryCatalog.ConfigureCalcPrice(
  SQLConnection: TADOConnection);
begin
  if not Assigned(FDMCalcPrice) then
    FDMCalcPrice := TDMCalcPrice.Create(Self);

  FDMCalcPrice.SetConnection(SQLConnection);
  FDMCalcPrice.UseMargin := DMGlobal.GetSvrParam(PARAM_CALC_MARGIN ,SQLConnection);
  FDMCalcPrice.UseRound  := DMGlobal.GetSvrParam(PARAM_CALC_ROUNDING, SQLConnection);
end;

procedure TDMImportInventoryCatalog.DataModuleCreate(Sender: TObject);
begin
  FLog := TStringList.Create(); 
end;

end.
