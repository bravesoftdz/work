unit uDMImportInventory;

interface

uses
  SysUtils, Classes, uContentClasses, variants, ADODB, uDMCalcPrice;

type
  TDMImportInventory = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FLog: TStringList;
    FDMCalcPrice : TDMCalcPrice;
    function FindCategory(Category: TCategory): Boolean;
    function FindModelGroup(ModelGroup: TModelGroup): Boolean;
    function FindModelSubGroup(ModelSubGroup: TModelSubGroup): Boolean;
    function FindVendor(Vendor: TVendor): Boolean;
    function ImportCategory(Category: TCategory): Boolean;
    function ImportModelGroup(ModelGroup: TModelGroup): Boolean;
    function ImportModelSubGroup(ModelSubGroup: TModelSubGroup): Boolean;
    function ImportVendor(Vendor: TVendor): Boolean;
    function InsertCategory(Category: TCategory): Boolean;
    function InsertModelGroup(ModelGroup: TModelGroup): Boolean;
    function InsertModelSubGroup(ModelSubGroup: TModelSubGroup): Boolean;
    function InsertVendor(Vendor: TVendor): Boolean;
    function ImportBarcode(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean; IDStore: Variant): Boolean;
    function ImportModel(Model: TModel): Boolean;
    function InsertModel(Model: TModel): Boolean;
    function SetVendorPriority(Model: TModel; Vendor: TVendor): Boolean;
    function SetVendorModelCode(VendorModelCode: TVendorModelCode): Boolean;
    function ImportModelInventoryAdd(Model: TModel;
      IDStore: Integer): Boolean;
    function ImportModelInventoryUpd(Model: TModel;
      IDStore: Integer): Boolean;
    function DoInventoryMov(Model: TModel; IDStore: Integer;
      QtyMov: Double; Aumentar: Boolean): Boolean;
    function FindManufacturer(Manufacturer: TManufacturer): Boolean;
    function ImportManufacturer(Manufacturer: TManufacturer): Boolean;
    function InsertManufacturer(Manufacturer: TManufacturer): Boolean;
    function SetModelManufacturer(Model: TModel;
      Manufacturer: TManufacturer): Boolean;
    function UpdateModel(Model: TModel): Boolean;
    procedure UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
  public
    function FindModel(Model: TModel): Boolean;
    function FindBarcode(Barcode: TBarcode): Boolean;
    function InsertBarcode(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean): Boolean;

    function ImportBarcodes(lstBarcodes: TList; UseQty: Boolean; UpdateQty: Boolean; IDStore: Variant): Boolean;
    function PrepareModelList(lstBarcodes: TList): TList;
    property Log: TStringList read FLog write FLog;
    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
  end;

implementation

uses uDMGlobal, uNumericFunctions, uObjectServices, Math;

{$R *.dfm}

function TDMImportInventory.ImportBarcode(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean; IDStore: Variant): Boolean;
var
  Model : TModel;
  Category: TCategory;
  ModelGroup: TModelGroup;
  ModelSubGroup: TModelSubGroup;
  Vendor: TVendor;
  Manufacturer: TManufacturer;
  VendorModelCode: TVendorModelCode;
begin
  Result := True;
  try
    Model := Barcode.Model;

    if Model = nil then
    begin
      Category        := nil;
      ModelGroup      := nil;
      ModelSubGroup   := nil;
      Vendor          := nil;
      Manufacturer    := nil;
      VendorModelCode := nil;
    end
    else
    begin
      Category        := Model.Category;
      ModelGroup      := Model.ModelGroup;
      ModelSubGroup   := Model.ModelSubGroup;
      Vendor          := Model.Vendor;
      Manufacturer    := Model.Manufacturer;
      VendorModelCode := Model.VendorModelCode;
    end;

    if Category <> nil then
    begin
      ImportCategory(Category);

      if ModelGroup <> nil then
      begin
        ModelGroup.IDGroup := Category.IDGroup;
        ImportModelGroup(ModelGroup);

        if ModelSubGroup <> nil then
        begin
          ModelSubGroup.IDModelGroup := ModelGroup.IDModelGroup;
          ImportModelSubGroup(ModelSubGroup);
        end;
      end;
    end;

    if Model <> nil then
      ImportModel(Model);

    if Manufacturer <> nil then
      if ImportManufacturer(Manufacturer) then
        SetModelManufacturer(Model, Manufacturer);

    if Vendor <> nil then
      if ImportVendor(Vendor) then
      begin
        SetVendorPriority(Model, Vendor);

        if (VendorModelCode <> nil) and (Model.VendorModelCode.VendorCode <> '') then
        begin
          VendorModelCode.IDModel  := Model.IDModel;
          VendorModelCode.IDVendor := Model.Vendor.IDVendor;
          SetVendorModelCode(VendorModelCode);
        end;
      end;

    if (Vendor <> nil) and (VendorModelCode <> nil) and (Model.VendorModelCode.VendorCode <> '') then
    begin
      VendorModelCode.IDModel  := Model.IDModel;
      VendorModelCode.IDVendor := Model.Vendor.IDVendor;
      SetVendorModelCode(VendorModelCode);
    end;


    if Barcode.IDBarcode <> null then
      if FindBarcode(Barcode) then
        {}
      else
        Result := InsertBarcode(Barcode, UseQty, UpdateQty);
  except
    on E: Exception do
    begin
      Log.Add(E.Message);
      Result := False;
    end;
  end;
end;

function TDMImportInventory.FindBarcode(Barcode: TBarcode): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(Format('SELECT IDBarcode FROM Barcode WHERE IDBarcode = %S', [QuotedStr(VarToStr(Barcode.IDBarcode))]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.InsertBarcode(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO Barcode');
      qryBusca.SQL.Add('  (IDModel, IDBarcode, BarcodeOrder)');
      qryBusca.SQL.Add('  (SELECT ' + VarToStr(Barcode.Model.IDModel) +
                       ' , ' + QuotedStr(Trim(VarToStr(Barcode.IDBarcode))) +
                       ' , IsNull(Max(BarcodeOrder),0) + 1 FROM Barcode WHERE IDMODEL = ' + VarToStr(Barcode.Model.IDModel) + ' )');
      qryBusca.ExecSQL;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.ImportModel(Model: TModel): Boolean;
begin
  if Model.IDModel = null then
    begin
      if FindModel(Model) then
      begin
        Result := UpdateModel(Model);
        UpdateKitPromoPrice(Model.IDModel, Model.VendorCost);
      end
      else
        Result := InsertModel(Model);
    end
  else
    Result := True;
end;

procedure TDMImportInventory.UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
var
  KitModelService: TMRKitModelService;
  KitModel: TKitModel;
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);

  with qryBusca do
  try
    if Active then
      Close;

    Connection := FSQLConnection;
    SQL.Text := ' SELECT Qty, MarginPerc FROM KitModel WHERE IDModel = ' + IntToStr(IDModel) + ' AND ISNULL(MarginPerc, 0) <> 0 ';
    Open;

    if not(IsEmpty) then
    try
      KitModelService         := TMRKitModelService.Create();
      KitModel                := TKitModel.Create();
      FDMCalcPrice            := TDMCalcPrice.Create(Self);

      KitModelService.SQLConnection := FSQLConnection;

      First;
      While not Eof do
      begin
        // Campos necessários
        KitModel.IDModel         := IDModel;
        KitModel.Qty             := FieldByName('Qty').AsFloat;
        if not DMGlobal.IsClientServer(FSQLConnection) then
          KitModel.SellingPrice  := FDMCalcPrice.GetMarginPrice(CostPrice, FieldByName('MarginPerc').AsFloat);
        KitModel.MarginPerc      := FieldByName('MarginPerc').AsFloat;

        //Update
        KitModelService.Update(KitModel);

        Next;
      end;
    finally
     FreeAndNil(KitModel);
     FreeAndNil(KitModelService);
     FreeAndNil(FDMCalcPrice);
    end;
  finally
    Close;
  end;
end;

function TDMImportInventory.FindModel(Model: TModel): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(Format('SELECT IDModel FROM Model WHERE Model = %S', [QuotedStr(Model.Model)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        Model.IDModel := qryBusca.FieldByName('IDModel').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.InsertModel(Model: TModel): Boolean;
var
  tmpID: Integer;
  qryBusca : TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      tmpID := DMGlobal.GetNextCode('Model', 'IDModel', FSQLConnection);
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO Model');
      qryBusca.SQL.Add('  (IDModel, Model, Description, GroupID, VendorCost, SellingPrice, DateLastCost, DateLastSellingPrice, IDUserLastSellingPrice, CaseQty, IDModelGroup, IDModelSubGroup) ');
      qryBusca.SQL.Add('VALUES (:IDModel, :Model, :Description, :GroupID, :VendorCost, :SellingPrice, GetDate(), GetDate(), :IDUserLastSellingPrice, :CaseQty, :IDModelGroup, :IDModelSubGroup) ');
      qryBusca.Parameters.ParamByName('IDModel').Value := tmpID;
      qryBusca.Parameters.ParamByName('Model').Value := Model.Model;
      qryBusca.Parameters.ParamByName('Description').Value := Model.Description;
      qryBusca.Parameters.ParamByName('GroupID').Value := Model.Category.IDGroup;

      if (Model.ModelGroup <> nil) then
        qryBusca.Parameters.ParamByName('IDModelGroup').Value := Model.ModelGroup.IDModelGroup
      else
        qryBusca.Parameters.ParamByName('IDModelGroup').Value := null;

      if (Model.ModelSubGroup <> nil) then
        qryBusca.Parameters.ParamByName('IDModelSubGroup').Value := Model.ModelSubGroup.IDModelSubGroup
      else
        qryBusca.Parameters.ParamByName('IDModelSubGroup').Value := null;

      qryBusca.Parameters.ParamByName('VendorCost').Value := Model.VendorCost;

      if not DMGlobal.IsClientServer(SQLConnection) then
        qryBusca.Parameters.ParamByName('SellingPrice').Value := Model.SellingPrice
      else
        qryBusca.Parameters.ParamByName('SellingPrice').Value := 0;

      qryBusca.Parameters.ParamByName('IDUserLastSellingPrice').Value := Model.IDUserLastSellingPrice;
      qryBusca.Parameters.ParamByName('CaseQty').Value := Model.CaseQty;

      qryBusca.ExecSQL;
      Model.IDModel := tmpID;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.UpdateModel(Model: TModel): Boolean;
var
  qryBusca : TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;

      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(' UPDATE Model');
      qryBusca.SQL.Add(' SET VendorCost = ' + MyFormatCur(Model.VendorCost, '.'));
      if not DMGlobal.IsClientServer(SQLConnection) then
        qryBusca.SQL.Add(' , SellingPrice = ' + MyFormatCur(Model.SellingPrice, '.'));
      qryBusca.SQL.Add(' , DateLastCost = GetDate(), DateLastSellingPrice = GetDate(), IDUserLastSellingPrice = ' + Model.IDUserLastSellingPrice + ', CaseQty = ' + MyFormatDouble(Model.CaseQty, '.'));
      qryBusca.SQL.Add(' WHERE IDModel = ' + VarToStr(Model.IDModel));
      qryBusca.ExecSQL;
     except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.ImportCategory(Category: TCategory): Boolean;
begin
  if Category.IDGroup = null then
    begin
      if FindCategory(Category) then
        Result := True
      else
        Result := InsertCategory(Category)
    end
  else
    Result := True;
end;

function TDMImportInventory.FindCategory(Category: TCategory): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(Format('SELECT IDGroup FROM TabGroup WHERE Name = %S', [QuotedStr(Category.TabGroup)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        Category.IDGroup := qryBusca.FieldByName('IDGroup').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;


function TDMImportInventory.InsertCategory(Category: TCategory): Boolean;
var
  tmpID: integer;
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      tmpID := DMGlobal.GetNextCode('TabGroup', 'IDGroup', FSQLConnection);
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO TabGroup');
      qryBusca.SQL.Add('  (IDGroup, Name)');
      qryBusca.SQL.Add('VALUES');
      qryBusca.SQL.Add(
               Format('  (%D, %S)',
                      [tmpID,
                      QuotedStr(Category.TabGroup)
                      ]
                     )
              );
      qryBusca.ExecSQL;
      Category.IDGroup := tmpID;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.ImportVendor(Vendor: TVendor): Boolean;
begin
  if Vendor.IDVendor = null then
    begin
      if FindVendor(Vendor) then
        Result := True
      else
        Result := InsertVendor(Vendor);
    end
  else
    Result := True;
end;

function TDMImportInventory.FindVendor(Vendor: TVendor): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT');
      qryBusca.SQL.Add('	IDPessoa');
      qryBusca.SQL.Add('FROM');
      qryBusca.SQL.Add('	Pessoa P INNER JOIN');
      qryBusca.SQL.Add('	TipoPessoa TP ON');
      qryBusca.SQL.Add('		(P.IDTipoPessoa = TP.IDTipoPessoa)');
      qryBusca.SQL.Add('WHERE');
      qryBusca.SQL.Add('	P.IDTipoPessoa = 2');
      qryBusca.SQL.Add('	AND');
      qryBusca.SQL.Add('	TP.Path LIKE ' + QuotedStr('.002%'));
      qryBusca.SQL.Add('	AND');
      qryBusca.SQL.Add(Format('	P.Pessoa = %S', [QuotedStr(Vendor.Vendor)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        Vendor.IDVendor := qryBusca.FieldByName('IDPessoa').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;


function TDMImportInventory.InsertVendor(Vendor: TVendor): Boolean;
var
  tmpID: Integer;
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      tmpID := DMGlobal.GetNextCode('Pessoa', 'IDPessoa', FSQLConnection);
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO Pessoa');
      qryBusca.SQL.Add('  (IDPessoa, IDTipoPessoa, Pessoa, IDTipoPessoaRoot)');
      qryBusca.SQL.Add('VALUES');
      qryBusca.SQL.Add(
               Format('  (%D, 2, %S, 2)',
                      [tmpID,
                      QuotedStr(Vendor.Vendor)
                      ]
                     )
              );
      qryBusca.ExecSQL;
      Vendor.IDVendor := tmpID;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.ImportManufacturer(Manufacturer: TManufacturer): Boolean;
begin
  if Manufacturer.IDManufacturer = null then
    begin
      if FindManufacturer(Manufacturer) then
        Result := True
      else
        Result := InsertManufacturer(Manufacturer);
    end
  else
    Result := True;
end;

function TDMImportInventory.FindManufacturer(Manufacturer: TManufacturer): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT');
      qryBusca.SQL.Add('	IDPessoa');
      qryBusca.SQL.Add('FROM');
      qryBusca.SQL.Add('	Pessoa P INNER JOIN');
      qryBusca.SQL.Add('	TipoPessoa TP ON');
      qryBusca.SQL.Add('		(P.IDTipoPessoa = TP.IDTipoPessoa)');
      qryBusca.SQL.Add('WHERE');
      qryBusca.SQL.Add('	P.IDTipoPessoa = 7');
      qryBusca.SQL.Add('	AND');
      qryBusca.SQL.Add('	TP.Path LIKE ' + QuotedStr('.004%'));
      qryBusca.SQL.Add('	AND');
      qryBusca.SQL.Add(Format('	P.Pessoa = %S', [QuotedStr(Manufacturer.Manufacturer)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        Manufacturer.IDManufacturer := qryBusca.FieldByName('IDPessoa').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;


function TDMImportInventory.InsertManufacturer(Manufacturer: TManufacturer): Boolean;
var
  tmpID: Integer;
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      tmpID := DMGlobal.GetNextCode('Pessoa', 'IDPessoa', FSQLConnection);
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO Pessoa');
      qryBusca.SQL.Add('  (IDPessoa, IDTipoPessoa, Pessoa, IDTipoPessoaRoot)');
      qryBusca.SQL.Add('VALUES');
      qryBusca.SQL.Add(
               Format('  (%D, 7, %S, 7)',
                      [tmpID,
                      QuotedStr(Manufacturer.Manufacturer)
                      ]
                     )
              );
      qryBusca.ExecSQL;
      Manufacturer.IDManufacturer := tmpID;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.SetModelManufacturer(Model: TModel; Manufacturer: TManufacturer): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('UPDATE MODEL');
      qryBusca.SQL.Add(Format('SET IDFabricante = %S', [VarToStr(Manufacturer.IDManufacturer)]));
      qryBusca.SQL.Add(Format('WHERE IDModel = %S', [VarToStr(Model.IDModel)]));
      qryBusca.ExecSQL;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;





function TDMImportInventory.SetVendorPriority(Model:TModel; Vendor: TVendor): Boolean;
var
  qryBusca : TADOQuery;
begin

  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT');
      qryBusca.SQL.Add('	IDModel');
      qryBusca.SQL.Add('FROM');
      qryBusca.SQL.Add('	Inv_ModelVendor');
      qryBusca.SQL.Add('WHERE');
      qryBusca.SQL.Add(Format('	IDModel = %S AND IDPessoa = %S', [VarToStr(Model.IDModel), VarToStr(Vendor.IDVendor)]));
      qryBusca.Open;
      if qryBusca.IsEmpty then
      begin
        qryBusca.Close;
        qryBusca.SQL.Clear;
        qryBusca.SQL.Add('INSERT');
        qryBusca.SQL.Add('   Inv_ModelVendor (IDModel, IDPessoa, VendorOrder)');
        qryBusca.SQL.Add('  SELECT');
        qryBusca.SQL.Add(Format('   %S,', [VarToStr(Model.IDModel)]));
        qryBusca.SQL.Add(Format('   %S,', [VarToStr(Vendor.IDVendor)]));
        qryBusca.SQL.Add('   IsNull(MAX(IMV.VendorOrder),0) + 1');
        qryBusca.SQL.Add('  FROM');
        qryBusca.SQL.Add('   Inv_ModelVendor IMV');
        qryBusca.SQL.Add('  WHERE');
        qryBusca.SQL.Add(Format('   IMV.IDModel = %S', [VarToStr(Model.IDModel)]));
        qryBusca.ExecSQL;
      end;
      Result := True;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.ImportBarcodes(lstBarcodes: TList; UseQty: Boolean; UpdateQty: Boolean; IDStore: Variant): Boolean;
var
  I: Integer;
  Barcode: TBarcode;
  lstModel: TList;
begin
  Result := False;
  for I := 0 to lstBarcodes.Count - 1 do
  begin
    Barcode := lstBarcodes[I];
    Result := ImportBarcode(Barcode, UseQty, UpdateQty, IDStore);
  end;

  lstModel := PrepareModelList(lstBarcodes);
  try
    if UseQty then
      if UpdateQty then
        for I := 0 to lstModel.Count - 1 do
        begin
          if TModel(lstModel[I]).Qty <> 0 then
            ImportModelInventoryUpd(lstModel[I], IDStore);
        end
      else
        for I := 0 to lstModel.Count - 1 do
        begin
          if TModel(lstModel[I]).Qty <> 0 then
            ImportModelInventoryAdd(lstModel[I], IDStore);
        end;
  finally
    FreeAndNil(lstModel);
  end;
end;

function TDMImportInventory.ImportModelInventoryAdd(Model: TModel; IDStore: Integer): Boolean;
var
  Qty: Double;
begin

  if Model.CaseQty <> 0 then
    Qty := (Model.Qty * Model.CaseQty)
  else
    Qty := Model.Qty;

  Result := DoInventoryMov(Model, IDStore, Abs(Qty), Qty >= 0);
end;

function TDMImportInventory.ImportModelInventoryUpd(Model: TModel; IDStore: Integer): Boolean;
var
  qryBusca: TADOQuery;
  QtyOnHand, QtyAtualizar, Qty: Double;

begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT');
      qryBusca.SQL.Add('	IsNull(QtyOnHand, 0) AS QtyOnHand');
      qryBusca.SQL.Add('FROM');
      qryBusca.SQL.Add('	Inventory');
      qryBusca.SQL.Add('WHERE');
      qryBusca.SQL.Add(Format('	ModelID = %S', [VarToStr(Model.IDModel)]));
      qryBusca.SQL.Add('	AND');
      qryBusca.SQL.Add(Format('	StoreID = %D', [IDStore]));
      qryBusca.Open;
      if qryBusca.IsEmpty then
        QtyOnHand := 0
      else
        QtyOnHand := qryBusca.FieldByName('QtyOnHand').AsFloat;

      if Model.CaseQty <> 0 then
        Qty := (Model.Qty * Model.CaseQty)
      else
        Qty := Model.Qty;

      QtyAtualizar := Qty - QtyOnHand;

      if QtyAtualizar = 0 then
        Result := True
      else
        Result := DoInventoryMov(Model, IDStore, ABS(Qty - QtyOnHand), ((Qty - QtyOnHand) >= 0));

    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.DoInventoryMov(Model: TModel; IDStore: Integer; QtyMov: Double; Aumentar: Boolean): Boolean;
var
  tmpID: Integer;
  qryBusca: TADOQuery;
  IDInventMovType: Integer;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    Result := True;
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      tmpID := DMGlobal.GetNextCode('InventoryMov', 'IDInventoryMov', FSQLConnection);

      if Aumentar then
        IDInventMovType := 21
      else
        IDInventMovType := 22;

      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('INSERT INTO InventoryMov');
      qryBusca.SQL.Add('	(IDInventoryMov, StoreID,');
      qryBusca.SQL.Add('   ModelID, InventMovTypeID,');
      qryBusca.SQL.Add('   DocumentID, IDUser, MovDate, Qty)');
      qryBusca.SQL.Add('VALUES');
      qryBusca.SQL.Add(Format('	(%D, %D, %S, %D, %D, 0, GetDate(), %S)',
                                [tmpID, IDStore, VarToStr(Model.IDModel), IDInventMovType, tmpID, FormatFloat('0.#####', QtyMov)]));
      qryBusca.ExecSQL;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Free;
  end;
end;

function TDMImportInventory.PrepareModelList(lstBarcodes: TList): TList;
var
  I : Integer;
  Model: TModel;
begin
  Result := TList.Create;
  for I := 0 to lstBarcodes.Count - 1 do
  begin
    Model := TBarcode(lstBarcodes[I]).Model;
    if Result.IndexOf(Model) = -1 then
      Result.Add(Model);
  end;
end;

function TDMImportInventory.SetVendorModelCode(VendorModelCode: TVendorModelCode): Boolean;
var
  qryBusca : TADOQuery;
  IDVendorModelCode: Integer;
begin

  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT');
      qryBusca.SQL.Add('	IDModel');
      qryBusca.SQL.Add('FROM');
      qryBusca.SQL.Add('	VendorModelCode');
      qryBusca.SQL.Add('WHERE');
      qryBusca.SQL.Add(Format('	IDModel = %S AND IDPessoa = %S', [VarToStr(VendorModelCode.IDModel), VarToStr(VendorModelCode.IDVendor)]));
      qryBusca.Open;
      if qryBusca.IsEmpty then
      begin
        IDVendorModelCode := DMGlobal.GetNextCode('VendorModelCode', 'IDVendorModelCode', FSQLConnection);

        qryBusca.Close;
        qryBusca.SQL.Clear;
        qryBusca.SQL.Text := 'INSERT INTO VendorModelCode (IDVendorModelCode, IDModel, IDPessoa, VendorCode) '+
                             ' VALUES (' + InttoStr(IDVendorModelCode) + ' , ' + Format(' %S,', [VarToStr(VendorModelCode.IDModel)]) +
                             Format(' %S,', [VarToStr(VendorModelCode.IDVendor)]) + QuotedStr(VarToStr(VendorModelCode.VendorCode)) + ' ) ';
        qryBusca.ExecSQL;
      end;
      Result := True;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;

end;

function TDMImportInventory.ImportModelGroup(
  ModelGroup: TModelGroup): Boolean;
begin
  if ModelGroup.IDModelGroup = null then
    begin
      if FindModelGroup(ModelGroup) then
        Result := True
      else
        Result := InsertModelGroup(ModelGroup)
    end
  else
    Result := True;
end;

function TDMImportInventory.FindModelGroup(
  ModelGroup: TModelGroup): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(Format('SELECT IDModelGroup FROM ModelGroup WHERE ModelGroup = %S', [QuotedStr(ModelGroup.ModelGroup)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        ModelGroup.IDModelGroup := qryBusca.FieldByName('IDModelGroup').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.FindModelSubGroup(
  ModelSubGroup: TModelSubGroup): Boolean;
var
  qryBusca: TADOQuery;
begin
  qryBusca := TADOQuery.Create(Self);
  try
    qryBusca.Connection := FSQLConnection;
    try
      if qryBusca.Active then
        qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(Format('SELECT IDModelSubGroup FROM ModelSubGroup WHERE ModelSubGroup = %S', [QuotedStr(ModelSubGroup.ModelSubGroup)]));
      qryBusca.Open;
      Result := not qryBusca.IsEmpty;
      if Result then
        ModelSubGroup.IDModelSubGroup := qryBusca.FieldByName('IDModelSubGroup').AsInteger;
    except
      on E: Exception do
      begin
        Log.Add(E.Message);
        Result := False;
      end;
    end;
  finally
    qryBusca.Close;
    qryBusca.Free;
  end;
end;

function TDMImportInventory.InsertModelGroup(
  ModelGroup: TModelGroup): Boolean;
var
  tmpID, CanCreate: integer;
  qryBusca: TADOQuery;
begin
  CanCreate := DMGlobal.GetSvrParam(93, FSQLConnection);

  if (CanCreate = 1) then
  begin
    qryBusca := TADOQuery.Create(Self);
    try
      Result := True;
      qryBusca.Connection := FSQLConnection;
      try
        if qryBusca.Active then
          qryBusca.Close;
        tmpID := DMGlobal.GetNextCode('ModelGroup', 'IDModelGroup', FSQLConnection);
        qryBusca.SQL.Clear;
        qryBusca.SQL.Add('INSERT INTO ModelGroup');
        qryBusca.SQL.Add('  (IDModelGroup, IDGroup, ModelGroup)');
        qryBusca.SQL.Add('VALUES');
        qryBusca.SQL.Add('  (:IDModelGroup, :IDGroup, :ModelGroup)');
        qryBusca.Parameters.ParamByName('IDModelGroup').Value := tmpID;
        qryBusca.Parameters.ParamByName('IDGroup').Value      := ModelGroup.IDGroup;
        qryBusca.Parameters.ParamByName('ModelGroup').Value   := ModelGroup.ModelGroup;
        qryBusca.ExecSQL;
        ModelGroup.IDModelGroup := tmpID;
      except
        on E: Exception do
        begin
          Log.Add(E.Message);
          Result := False;
        end;
      end;
    finally
      qryBusca.Free;
    end;
  end;
end;

function TDMImportInventory.ImportModelSubGroup(
  ModelSubGroup: TModelSubGroup): Boolean;
begin
    if ModelSubGroup.IDModelSubGroup = null then
    begin
      if FindModelSubGroup(ModelSubGroup) then
        Result := True
      else
        Result := InsertModelSubGroup(ModelSubGroup)
    end
  else
    Result := True;
end;

function TDMImportInventory.InsertModelSubGroup(
  ModelSubGroup: TModelSubGroup): Boolean;
var
  tmpID, CanCreate: integer;
  qryBusca: TADOQuery;
begin
  CanCreate := DMGlobal.GetSvrParam(93, FSQLConnection);

  if (CanCreate = 1) then
  begin
    qryBusca := TADOQuery.Create(Self);
    try
      Result := True;
      qryBusca.Connection := FSQLConnection;
      try
        if qryBusca.Active then
          qryBusca.Close;
        tmpID := DMGlobal.GetNextCode('ModelSubGroup', 'IDModelSubGroup', FSQLConnection);
        qryBusca.SQL.Clear;
        qryBusca.SQL.Add('INSERT INTO ModelSubGroup');
        qryBusca.SQL.Add('  (IDModelSubGroup, IDModelGroup, ModelSubGroup)');
        qryBusca.SQL.Add('VALUES');
        qryBusca.SQL.Add('  (:IDModelGroup, :IDGroup, :ModelGroup)');
        qryBusca.Parameters.ParamByName('IDModelGroup').Value  := tmpID;
        qryBusca.Parameters.ParamByName('IDGroup').Value       := ModelSubGroup.IDModelGroup;
        qryBusca.Parameters.ParamByName('ModelGroup').Value    := ModelSubGroup.ModelSubGroup;
        qryBusca.ExecSQL;
        ModelSubGroup.IDModelSubGroup := tmpID;
      except
        on E: Exception do
        begin
          Log.Add(E.Message);
          Result := False;
        end;
      end;
    finally
      qryBusca.Free;
    end;
  end;
end;

procedure TDMImportInventory.DataModuleCreate(Sender: TObject);
begin
  FLog := TStringList.Create;
end;

procedure TDMImportInventory.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLog);
end;

end.
