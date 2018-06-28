unit uDMValidatePOTextFile;

interface

uses
    Dialogs,  SysUtils, Classes, Variants, ADODB, DB, uDMCalcPrice,
    uDMImportTextFile, uDMValidateTextFile, DBClient;

type
  TDMValidatePOTextFile = class(TDMValidateTextFile)
    qryPoItemList: TADOQuery;
    quModelExist: TADODataSet;
    qryMaxBarcode: TADOQuery;
  private
    IsClientServer: Boolean;
    bUseMarkupOnCost : Boolean;
    FDMCalcPrice: TDMCalcPrice;
    procedure ValidatePOItem;
    procedure OpenPoItemList(PONumber : Integer);
    function GetIDVendor(Vendor: String): Integer;
    function FindModelWithVendorCode: Boolean;
    function FindModelWithBarcode: Boolean;
    procedure ClosePoItemList;
    procedure CalcSaleValues(CostPrice:Currency);
    function GetValidModelCode: String;
    procedure InvalidByQty(AField : String);
    procedure InvalidByBarcode;
    procedure InvalidByCostPrice(AField : String);
    function ExistsModelName(Model: String): Boolean;
    function GetModelMarkup(IDModel : Integer) : Double;
    procedure InvalidByModelName;
    procedure ValidByModelName;
    procedure FilterSameBarcode;
    procedure WarningDiferCost(OldCost: Currency);
    function GetMaxBarcodeOrder(IDModel: Integer): Integer;
    procedure FormatCost;

    procedure ImportFromMainRetail;
    procedure ImportFromFile;
    function ImportFromCatalog: Boolean;
    procedure UpdateModelWithCatalog;
    function CalcCostUnitValue(Cost, CaseCost: Currency; Qty, CaseQty: Double; QtyType: String; CostIsCaseCost: Boolean): Currency;
    function CalcCaseCost(Cost, CaseCost: Currency; CaseQty: Double; CostIsCaseCost: Boolean): Currency;
    procedure WarningPromoCost;
    procedure InvalidByClientServer;
    procedure SetDefaultValues;
    function getSellingPriceObeyIncreasyOnly(idmodel: integer; price: Currency): Currency; virtual;
    
  public
    function ValidateModels: Boolean;
    function Validate: Boolean; override;
    function NotExistsPurchaseNum(PurchaseNum,Vendor : String): Boolean;
    function ExistsPONum(PONum: String): Boolean;
    Function ValidateItem: Boolean;
  end;

implementation

uses uNumericFunctions, uDMGlobal, uSystemConst, uObjectServices,
  uContentClasses, uDebugFunctions;

{$R *.dfm}

{ TDMValidatePOTextFile }

procedure TDMValidatePOTextFile.OpenPoItemList(PONumber : Integer);
begin
  with qryPoItemList do
   begin
     if Active then
       Close;
     Connection := SQLConnection;
     Parameters.ParamByName('DocumentID').Value := PONumber;
     Open;
   end;
end;

function TDMValidatePOTextFile.Validate: Boolean;
var
  FileCaseQty: Double;
  bUseCatalog, CostIsCaseCost, PromoCost: Boolean;
  NewCostPrice, FileCaseCost, NewCaseCost: Currency;
begin

  IsClientServer := DMGlobal.IsClientServer(SQLConnection);

  FDMCalcPrice := TDMCalcPrice.Create(Self);
  try
    FDMCalcPrice.SetConnection(SQLConnection);
    FDMCalcPrice.UseMargin := DMGlobal.GetSvrParam(PARAM_CALC_MARGIN ,SQLConnection);
    FDMCalcPrice.UseRound  := DMGlobal.GetSvrParam(PARAM_CALC_ROUNDING, SQLConnection);
    bUseCatalog            := DMGlobal.GetSvrParam(PARAM_USE_CATALOG, SQLConnection);
    bUseMarkupOnCost       := DMGlobal.GetSvrParam(PARAM_TAX_COST_USE_MARKUP_ON_COST, SQLConnection);

    CostIsCaseCost         := (ImpExpConfig.Values['CostIsCaseCost'] = 'True');

    // - Cacula o valor de venda e msrp
    TextFile.First;
    while not TextFile.Eof do
    begin
      begin
        FileCaseQty    := 0;
        FileCaseCost   := 0;
        NewCostPrice   := 0;
        NewCaseCost    := 0;
        PromoCost      := False;

        TextFile.Edit;
        TextFile.FieldByName('Warning').AsString:= '';

        if LinkedColumns.Values['CaseCost'] <> '' then
        begin
          if TextFile.FieldByName('FieldCostCalc').AsString = '' then
            TextFile.FieldByName('FieldCostCalc').AsString := TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString
          else
            TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString := TextFile.FieldByName('FieldCostCalc').AsString;
        end;

        if (TextFile.FieldByName('QtyType').AsString <> 'EA') then
        begin

         FileCaseQty := MyStrToFloat(TextFile.FieldByName('CaseQty').AsString);

          if LinkedColumns.Values['CaseCost'] <> '' then
            FileCaseCost := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString)
          else
            FileCaseCost := MyStrToFloat(TextFile.FieldByName('CaseCost').AsString);
        end;

        if (LinkedColumns.Values['PromoFlat'] <> '') and
           ((TextFile.FieldByName(LinkedColumns.Values['PromoFlat']).AsString = 'Y') or
           (TextFile.FieldByName(LinkedColumns.Values['PromoFlat']).AsString = '1')) then
        begin
          PromoCost := True;
          WarningPromoCost;
        end;

        // VALIDATE MODEL
        if TextFile.FieldByName('NewModel').AsBoolean then
          if (TextFile.FieldByName('Model').AsString <> '') and (ExistsModelName(TextFile.FieldByName('Model').AsString)) then
            InvalidByModelName;

        // VALIDATE QTY
        if (TextFile.FieldByName(LinkedColumns.Values['Qty']).AsString = '') or
           (TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat = 0) then
          InvalidByQty('Qty');

        // VALIDATE COST PRICE
        if (TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsString = '') or
           (TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency = 0) then
          InvalidByCostPrice('NewCostPrice');

        if TextFile.FieldByName('Validation').AsBoolean then
        begin

          NewCostPrice := FDMCalcPrice.FormatPrice(CalcCostUnitValue(TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency,
                                                   FileCaseCost,
                                                   TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat,
                                                   FileCaseQty,
                                                   TextFile.FieldByName('QtyType').AsString,
                                                   CostIsCaseCost));

          NewCaseCost := FDMCalcPrice.FormatPrice(CalcCaseCost(NewCostPrice,FileCaseCost,FileCaseQty,CostIsCaseCost));

          if not(TextFile.State = (dsEdit)) then
            TextFile.Edit;
          TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency := NewCostPrice;
          TextFile.FieldByName('CaseCost').AsCurrency := NewCaseCost;

          FormatCost;

          // amfsouza
 //         showMessage('IdGroup = ' + TextFile.FieldByName('IDGroup').AsString);

          if (TextFile.FieldByName('IDGroup').AsInteger <> 0) then
            CalcSaleValues(TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency);

          if (bUseCatalog) and not(TextFile.FieldByName('NewModel').AsBoolean) then
           UpdateModelWithCatalog;

          if (TextFile.FieldByName('OldCostPrice').AsCurrency <> 0) and
             (TextFile.FieldByName('OldCostPrice').AsCurrency <> TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency) then
               WarningDiferCost(TextFile.FieldByName('OldCostPrice').AsCurrency);
        end;
      end;

      if TextFile.State = (dsEdit) then
        TextFile.Post;

      TextFile.Next;
    end;

    if not(ImpExpConfig.Values['PONumber'] = '') then
      begin
          OpenPoItemList(StrtoInt(ImpExpConfig.Values['PONumber']));
          TextFile.First;
          while not TextFile.Eof do
          begin
            if TextFile.FieldByName('Validation').AsBoolean then
              ValidatePOItem;
            TextFile.Next;
          end;
          ClosePoItemList;
      end;

    Result := True;

  finally
    FreeAndNil(FDMCalcPrice);
    end;

end;

function TDMValidatePOTextFile.CalcCaseCost(Cost, CaseCost: Currency; CaseQty: Double; CostIsCaseCost: Boolean): Currency;
begin
  Result := 0;
  
  if CaseQty <> 0 then
    if (CaseCost = 0) and CostIsCaseCost then
      Result := Cost
    else if (CaseCost = 0) then
      Result := (Cost * CaseQty)
    else
      Result := CaseCost;
end;

function TDMValidatePOTextFile.CalcCostUnitValue(Cost, CaseCost: Currency; Qty, CaseQty: Double; QtyType: String; CostIsCaseCost: Boolean): Currency;
begin

  Result := Cost;

  if (QtyType = 'EA') then
    Result := Cost
  else if (CaseQty <> 0) and (CaseCost <> 0) then
    Result := CaseCost / CaseQty
  else if (CaseQty <> 0) and (CaseCost = 0) and CostIsCaseCost then
    Result := Cost / CaseQty
  else if (CaseQty <> 0) and (CaseCost = 0) and not(CostIsCaseCost) then
    Result := Cost;

end;

procedure TDMValidatePOTextFile.FormatCost;
var
  DecimalPoint : string;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  DecimalPoint := ImpExpConfig.Values['DecimalDelimiter'];

  if (LinkedColumns.Values['NewCostPrice'] <> '') then
    TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).Value), DecimalPoint[1]));

  if (LinkedColumns.Values['OtherCost'] <> '') then
    TextFile.FieldByName(LinkedColumns.Values['OtherCost']).AsCurrency    := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(TextFile.FieldByName(LinkedColumns.Values['OtherCost']).Value), DecimalPoint[1]));

  if (LinkedColumns.Values['FreightCost'] <> '') then
    TextFile.FieldByName(LinkedColumns.Values['FreightCost']).AsCurrency  := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(TextFile.FieldByName(LinkedColumns.Values['FreightCost']).Value), DecimalPoint[1]));

  if (LinkedColumns.Values['CaseCost'] <> '') then
    TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsCurrency     := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(TextFile.FieldByName(LinkedColumns.Values['CaseCost']).Value), DecimalPoint[1]));

  TextFile.FieldByName('OldCostPrice').AsCurrency   :=  FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(TextFile.FieldByName('OldCostPrice').Value), DecimalPoint[1]));
end;

procedure TDMValidatePOTextFile.WarningDiferCost(OldCost : Currency);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;

  if TextFile.FieldByName('Warning').AsString <> '' then
    TextFile.FieldByName('Warning').AsString := TextFile.FieldByName('Warning').AsString + '; Old Cost: ' + SysCurrToStr(OldCost)
  else
    TextFile.FieldByName('Warning').AsString := 'Old Cost: ' + SysCurrToStr(OldCost);
end;

procedure TDMValidatePOTextFile.WarningPromoCost;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;

  if TextFile.FieldByName('Warning').AsString <> '' then
    TextFile.FieldByName('Warning').AsString := TextFile.FieldByName('Warning').AsString + '; Promo Cost'
  else
    TextFile.FieldByName('Warning').AsString := 'Promo Cost';
end;

function TDMValidatePOTextFile.ExistsModelName(Model : String): Boolean;
begin
  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;

    SQL.Text := ' SELECT Model FROM Model WHERE Model = ' + QuotedStr(Model);
    Open;

    Result := not(IsEmpty);

    Close;
  end;
end;

procedure TDMValidatePOTextFile.InvalidByModelName;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Model Exists';
end;

procedure TDMValidatePOTextFile.ValidByModelName;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := True;
  TextFile.FieldByName('Warning').AsString := '';
end;

procedure TDMValidatePOTextFile.InvalidByQty(AField : String);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Invalid Item ' + AField;
end;

procedure TDMValidatePOTextFile.ValidatePOItem;
var
  PreInventoryQty, TextQty : Double;
  Friend : Variant;
begin
  PreInventoryQty := 0;

  if not(TextFile.FieldByName('IDModel').AsString = '') then
  begin
    Friend := qryPoItemList.Lookup('ModelID',TextFile.FieldByName('IDModel').AsString,'Qty');
    if Friend <> Null then
      PreInventoryQty := Friend;
  end;

  TextQty := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['Qty']).AsString);

  if PreInventoryQty = 0 then
  begin
    TextFile.Edit;

    if TextFile.FieldByName('Warning').AsString = '' then
      TextFile.FieldByName('Warning').AsString := 'Item not registered in PO'
    else 
      TextFile.FieldByName('Warning').AsString := TextFile.FieldByName('Warning').AsString + '; Item not registered in PO'
  end
  else if PreInventoryQty > TextQty then
  begin
    TextFile.Edit;
    TextFile.FieldByName('Warning').AsString := 'Amount in the MainRetail is greater then file';
  end
  else if PreInventoryQty < TextQty then
  begin
    TextFile.Edit;
    TextFile.FieldByName('Warning').AsString := 'Amount in the file is greater then MainRetail';
  end;
end;

function TDMValidatePOTextFile.GetIDVendor(Vendor: String): Integer;
begin
  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;

    Connection := SQLConnection;

    SQL.Text := 'SELECT IDPessoa from Pessoa '+
                ' WHERE Pessoa = ' + QuotedStr(Vendor) + ' AND IDTipoPessoa = 2 ';
    Open;
   end;

  if DMGlobal.qryFreeSQL.IsEmpty then
    Result := -1
  else
    Result := DMGlobal.qryFreeSQL.Fields.FieldByName('IDPessoa').AsInteger;
end;

function TDMValidatePOTextFile.FindModelWithBarcode: Boolean;
var
  Barcode, sNewBarcode, sSQL : String;
  iCheckBarcodeDigit, BarcodeOrder : Integer;
  SearchModel : Boolean;
begin
  Result := False;

  Barcode := TextFile.FieldByName(LinkedColumns.Values['Barcode']).AsString;

  sSQL := ' SELECT M.IDModel, M.GroupID, M.IDModelGroup, M.IDModelSubGroup, M.CaseQty, '+
          ' M.SellingPrice, M.SuggRetail, M.VendorCost ' +
          ' FROM Barcode B JOIN Model M ON (M.IDModel = B.IDModel) ' +
          ' WHERE B.IDBarcode = ' ;

  with DMGlobal.qryFreeSQL do
  try
    if Active then
      Close;

    Connection := SQLConnection;
    SQL.Text := sSQL + QuotedStr(Barcode);
    Open;

    SearchModel := DMGlobal.GetSvrParam(PARAM_SEARCH_MODEL_AFTER_BARCODE, SQLConnection);

    if IsEmpty and SearchModel then
    begin
      if Active then
        Close;
      Connection := SQLConnection;
      SQL.Text   := ' SELECT Model, IDModel, GroupID, IDModelGroup, IDModelSubGroup, CaseQty, '+
                    ' SellingPrice, SuggRetail, VendorCost ' +
                    ' FROM Model WHERE Model = ' + QuotedStr(Barcode);
      Open;
    end;

    iCheckBarcodeDigit := DMGlobal.GetSvrParam(PARAM_REMOVE_BARCODE_DIGIT, SQLConnection);

    if IsEmpty and (iCheckBarcodeDigit <> 0) and (Length(Barcode)>2) then
    begin
      if Active then
        Close;

      Case iCheckBarcodeDigit of
        1 : sNewBarcode := Copy(Barcode, 2, Length(Barcode));
        2 : sNewBarcode := Copy(Barcode, 1, Length(Barcode)-1);
        3 : sNewBarcode := Copy(Barcode, 2, Length(Barcode)-2)
        else sNewBarcode := Copy(Barcode, 2, Length(Barcode)-2);
      end;

      SQL.Text := sSQL + QuotedStr(sNewBarcode);
      Open;

      if not(IsEmpty) then
      begin
       BarcodeOrder := GetMaxBarcodeOrder(FieldByName('IDModel').AsInteger);

       DMGlobal.ExecuteSQL(
        ' IF NOT EXISTS (SELECT IDBarcode FROM Barcode WHERE IDBarcode = '+QuotedStr(Barcode)+')' +
        ' BEGIN ' +
        ' INSERT Barcode (IDBarcode, IDModel, Data, BarcodeOrder) ' +
        ' SELECT ' + QuotedStr(Barcode)+ ', M.IDModel, GetDate(), ' + InttoStr(BarcodeOrder + 1) +
        ' FROM Barcode B ' +
        ' JOIN Model M ON (M.IDModel = B.IDModel) ' +
        ' WHERE IDBarcode = ' + QuotedStr(sNewBarcode) +
        ' END ', SQLConnection);
      end;
    end;

    if not IsEmpty then
    begin
      ImportFromMainRetail;
      Result := True;
    end
    else
      Result := False;
  finally
    Close;
  end;
end;

function TDMValidatePOTextFile.GetMaxBarcodeOrder(IDModel: Integer): Integer;
begin
  with qryMaxBarcode do
    try
      if Active then
        Close;

      Connection := SQLConnection;
      Parameters.ParamByName('IDModel').Value := IDModel;
      Open;

      Result := FieldByName('BarcodeOrder').AsInteger
    finally
      Close;
      end;
end;


function TDMValidatePOTextFile.FindModelWithVendorCode: Boolean;
begin
  Result := False;

  TextFile.Edit;

  with DMGlobal.qryFreeSQL do
  begin
   try
    if Active then
      Close;

    Connection := SQLConnection;


    SQL.Text := ' SELECT M.IDModel, M.GroupID, M.IDModelGroup, M.IDModelSubGroup, V.VendorCode FROM VendorModelCode V JOIN Model M ON (M.IDModel = V.IDModel) ' +
                ' WHERE IDPessoa = ' + QuotedStr(InttoStr(GetIDVendor(ImpExpConfig.Values['Vendor']))) +
                ' AND VendorCode = ' + QuotedStr(LinkedColumns.Values['VendorCode']);
    Open;

    if not(IsEmpty) then
      begin
        TextFile.Edit;
        TextFile.FieldByName('IDGroup').AsInteger         := DMGlobal.qryFreeSQL.FieldByName('GroupID').AsInteger;
        TextFile.FieldByName('IDModelGroup').AsInteger    := DMGlobal.qryFreeSQL.FieldByName('IDModelGroup').AsInteger;
        TextFile.FieldByName('IDModelSubGroup').AsInteger := DMGlobal.qryFreeSQL.FieldByName('IDModelSubGroup').AsInteger;
        TextFile.FieldByName('IDModel').AsInteger         := DMGlobal.qryFreeSQL.FieldByName('IDModel').AsInteger;
        TextFile.FieldByName('VendorModelCode').AsString  := DMGlobal.qryFreeSQL.FieldByName('VendorCode').AsString;
        TextFile.Post;
        Result := True;
       end;

   finally
     Close;
   end;
  end;
end;

procedure TDMValidatePOTextFile.ClosePoItemList;
begin
  with qryPoItemList do
   begin
     if Active then
       Close;
   end;
end;

function TDMValidatePOTextFile.NotExistsPurchaseNum(
  PurchaseNum, Vendor: String): Boolean;
begin
  with DMGlobal.qryFreeSQL do
  begin
   try
    if Active then
      Close;

    Connection := SQLConnection;

    SQL.Text := ' SELECT DocumentNumber, IDStore FROM Pur_Purchase '+
                ' WHERE DocumentNumber = ' +  QuotedStr(PurchaseNum) +
                ' AND IDFornecedor = ' + InttoStr(GetIDVendor(Vendor));
    Open;

    if IsEmpty then
      Result := True
    else
      Result := False;
   finally
    Close;
   end;
  end;
end;

procedure TDMValidatePOTextFile.CalcSaleValues(CostPrice:Currency);
var
  fNewSale, fNewMSRP : Currency;
  fMakrup : Double;
begin

  if IsClientServer then
  begin
//    DebugToFile('begin - step 1');
    fNewSale := TextFile.FieldByName('OldSalePrice').AsCurrency;

    //amfsouza 11.11.2011
    fNewSale := getSellingPriceObeyIncreasyOnly(TextFile.FieldByName('IDModel').AsInteger,
                                                fNewSale);
    fNewMSRP := TextFile.FieldByName('NewMSRP').AsCurrency;
//    debugToFile('end - step 1');
  end
  else
  begin
//    debugtofile('begin - step 2 ');
    fMakrup := GetModelMarkup(TextFile.FieldByName('IDModel').AsInteger);

    if fMakrup <> 0 then
    begin
      if bUseMarkupOnCost then
        fNewSale := FDMCalcPrice.GetMarkupPrice(CostPrice, fMakrup)
      else if (fMakrup < 100) then
        fNewSale := FDMCalcPrice.GetMarginPrice(CostPrice, fMakrup);

      fNewSale := FDMCalcPrice.CalcRounding(TextFile.FieldByName('IDGroup').AsInteger, fNewSale);

      //amfsouza 11.11.2011
      fNewSale := getSellingPriceObeyIncreasyOnly(TextFile.FieldByName('IDModel').AsInteger,
                                                  fNewSale);
//      debugtofile('end- stop 2 ');
    end
    else
    begin
//      debugToFile('begin- step 3');
//      debugtofile('description = ' + TextFile.FieldByName('description').AsString);
      fNewSale := FDMCalcPrice.CalcSalePrice(TextFile.FieldByName('IDModel').AsInteger,
                  TextFile.FieldByName('IDGroup').AsInteger,
                  TextFile.FieldByName('IDModelGroup').AsInteger,
                  TextFile.FieldByName('IDModelSubGroup').AsInteger,
                  CostPrice);

//      debugtofile('new sale from calcprice = ' + floatTostr(fNewSale));
      //amfsouza 11.11.2011
      fNewSale := getSellingPriceObeyIncreasyOnly
                     (TextFile.FieldByName('IDModel').AsInteger,
                      fNewSale);
//      debugtofile('new sale from increay only = ' + floatTostr(fNewSale));


      fNewMSRP := FDMCalcPrice.CalcMSRPPrice(TextFile.FieldByName('IDGroup').AsInteger,
                  TextFile.FieldByName('IDModelGroup').AsInteger,
                  TextFile.FieldByName('IDModelSubGroup').AsInteger,
                  CostPrice);
//      debugtofile('new MSRP = ' + floatTostr(fNewMSRP));
//      debugtofile('end - step 3');
    end;
  end;

  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;


//  debugtofile('begin - step 4');
  if (fNewSale <> CostPrice) and (fNewSale <> 0) then begin
    TextFile.FieldByName('NewSalePrice').AsCurrency := fNewSale;
  end
  else  begin
    TextFile.FieldByName('NewSalePrice').AsCurrency := TextFile.FieldByName('OldSalePrice').AsCurrency;
  end;
//  debugtofile('end - step 4');


//  debugtofile('begin - step 5');
  if (fNewMSRP <> CostPrice) and (fNewMSRP <> 0) then
    TextFile.FieldByName('NewMSRP').AsCurrency := fNewMSRP
  else
    TextFile.FieldByName('NewMSRP').AsCurrency;
//  debugtofile('end - step 5');

end;

function TDMValidatePOTextFile.ValidateModels: Boolean;
begin
  IsClientServer := DMGlobal.IsClientServer(SQLConnection);

  TextFile.First;
    while not TextFile.Eof do
    begin
      if (LinkedColumns.Values['Barcode'] <> '') then
      begin
        if ((LinkedColumns.Values['VendorCode'] = '') or not(FindModelWithVendorCode)) then
        begin
          if ValidateItem then
          begin
            SetDefaultValues;
            if not FindModelWithBarcode then
              begin
                if IsClientServer then
                  InvalidByClientServer
                else
                  if not ImportFromCatalog then
                    ImportFromFile;
              end;
          end;
        end;
      end
      else
        InvalidByBarcode;

      if TextFile.State = (dsEdit) then
        TextFile.Post;

      TextFile.Next;
    end;

  FilterSameBarcode;
end;

procedure TDMValidatePOTextFile.SetDefaultValues;
begin
  TextFile.Edit;

  if (LinkedColumns.Values['VendorCode'] <> '') then
    TextFile.FieldByName('VendorModelCode').AsString := TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString;

  if (LinkedColumns.Values['MinQty'] <> '') then
    TextFile.FieldByName('MinQtyPO').AsFloat         := TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat;

  TextFile.Post;
end;

procedure TDMValidatePOTextFile.FilterSameBarcode;
var
  i : Integer;
  cdsSupport: TClientDataSet;
begin
  cdsSupport := TClientDataSet.Create(self);
  try
    cdsSupport.CloneCursor(TextFile,true);
    cdsSupport.Data := TextFile.Data;

    TextFile.First;
    while not TextFile.Eof do
      TextFile.Delete;

    with cdsSupport do
    begin
      //Filter := 'Validation = True';
      //Filtered := true;
      First;
      while not Eof do
      begin
        if TextFile.Locate(LinkedColumns.Values['Barcode'],FieldByName(LinkedColumns.Values['Barcode']).AsString, []) then
          begin
            TextFile.Edit;
            if(cdsSupport.FieldByName(LinkedColumns.Values['Qty']).AsString='') then
            begin
            cdsSupport.Edit;
            cdsSupport.FieldByName(LinkedColumns.Values['Qty']).AsString := '0';
            cdsSupport.Post;
            end;
            TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat := (TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat + FieldByName(LinkedColumns.Values['Qty']).AsFloat);
          end
        else
          begin
            TextFile.Append;

            for i:= 0 to Pred(TextFile.Fields.Count) do
              TextFile.Fields[i].Value := Fields[i].Value;

            TextFile.Post;
          end;
        Next;
      end;
    end;
  finally
    FreeAndNil(cdsSupport);
    end;
end;

function TDMValidatePOTextFile.GetValidModelCode: String;
var
  bValidModel: Boolean;
begin
  bValidModel := False;

  while not bValidModel do
  try
    Result := IntToStr(DMGlobal.GetNextCode('Model','Model', SQLConnection));

    quModelExist.Connection := SQLConnection;
    quModelExist.Parameters.ParamByName('Model').Value := Result;
    quModelExist.Open;
    bValidModel := quModelExist.IsEmpty;
  finally
    quModelExist.Close;
  end;

end;

function TDMValidatePOTextFile.ImportFromCatalog: Boolean;
var
  FileCaseQty: Double;
  sBarcodeValue: String;
  Barcode: TBarcode;
  Model: TModel;
  Vendor: TVendor;
  BarcodeService: TCatalogBarcodeService;
  ModelService: TCatalogModelService;
begin
  Result := False;

  if DMGlobal.GetSvrParam(PARAM_USE_CATALOG, SQLConnection) then
  begin
    Barcode := TBarcode.Create;
    Model := TModel.Create;
    Vendor := TVendor.Create;
    BarcodeService := TCatalogBarcodeService.Create;
    BarcodeService.SQLConnection := Self.SQLConnection;

    if (LinkedColumns.Values['CaseQty'] <> '') then
      FileCaseQty := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString)
    else
      FileCaseQty := 0;

    try
      sBarcodeValue := TextFile.FieldByName(LinkedColumns.Values['Barcode']).Value;
      Barcode.IDBarcode := sBarcodeValue;
      Model.Model := sBarcodeValue;
      Barcode.Model := Model;

      if BarcodeService.Find(Barcode) or BarcodeService.FindByModel(Barcode) then
        with TextFile do
        begin
          Edit;

          FieldByName(LinkedColumns.Values['Barcode']).AsString := Barcode.IDBarcode;
          FieldByName('Model').AsString := Barcode.Model.Model;
          FieldByName('IDGroup').Value := Barcode.Model.Category.IDGroup;
          FieldByName('IDModelGroup').Value    := Barcode.Model.ModelGroup.IDModelGroup;
          FieldByName('IDModelSubGroup').Value := Barcode.Model.ModelSubGroup.IDModelSubGroup;
          FieldByName('Description').Value := Barcode.Model.Description;
          FieldByName('NewMSRP').AsCurrency := Barcode.Model.SuggRetail;
          FieldByName('NewModel').AsBoolean := True;
          FieldByName('Validation').AsBoolean := True;



          if FileCaseQty <> 0 then
          begin
            FieldByName('CaseQty').AsFloat  := FieldByName(LinkedColumns.Values['CaseQty']).AsFloat;
            FieldByName('QtyType').AsString := 'CS (' + FieldByName(LinkedColumns.Values['CaseQty']).AsString + ' un )';
          end
          else
          begin
            FieldByName('CaseQty').AsFloat  := 0;
            FieldByName('QtyType').AsString := 'EA';
          end;

          FieldByName('Warning').AsString := 'Imported from catalog database.';

          if (LinkedColumns.Values['PromoFlat'] <> '') then
            FieldByName(LinkedColumns.Values['PromoFlat']).AsString := 'N';

          FieldByName('OldSalePrice').AsCurrency := 0.0;
          FieldByName('NewSalePrice').AsCurrency := 0.0;

          // Procura Preço de Custo por Fornecedor.
          Barcode.Model.Vendor.Vendor := ImpExpConfig.Values['Vendor'];
          if BarcodeService.FindByVendor(Barcode) then
          begin
            FieldByName('VendorModelCode').AsString := Barcode.Model.VendorModelCode.VendorCode;
            FieldByName('MinQtyPO').AsFloat         := Barcode.Model.ModelVendor.MinQtyPO;
            FieldByName('VendorCaseQty').AsFloat    := Barcode.Model.ModelVendor.CaseQty;
            FieldByName('OldCostPrice').AsCurrency  := Barcode.Model.VendorCost;
          end
          else
            FieldByName('OldCostPrice').AsCurrency := 0.0;

          Post;
          Result := True;
        end;
    finally
      FreeAndNil(Model);
      FreeAndNil(BarcodeService);
    end;
  end;
end;

procedure TDMValidatePOTextFile.ImportFromFile;
var
  FileCaseQty: Double;
begin
  with TextFile do
  begin
    if (LinkedColumns.Values['CaseQty'] <> '') then
      FileCaseQty := MyStrToFloat(FieldByName(LinkedColumns.Values['CaseQty']).AsString)
    else
      FileCaseQty := 0;

    Edit;

    if (DMGlobal.GetSvrParam(PARAM_AUTO_GENERATE_MODEL, SQLConnection)) and (TextFile.FieldByName('Model').AsString = '') then
      FieldByName('Model').AsString := GetValidModelCode;

    FieldByName('NewModel').AsBoolean := True;
    FieldByName('Validation').AsBoolean := True;

    if FileCaseQty <> 0 then
    begin
      FieldByName('CaseQty').AsFloat := FieldByName(LinkedColumns.Values['CaseQty']).AsFloat;
      FieldByName('QtyType').AsString := 'CS (' + FieldByName(LinkedColumns.Values['CaseQty']).AsString + ' un )';
    end
    else
    begin
      FieldByName('CaseQty').AsFloat  := 0;
      FieldByName('QtyType').AsString := 'EA';
    end;

    FieldByName('Warning').AsString := 'Imported from file.';

    if (LinkedColumns.Values['PromoFlat'] <> '') then
      FieldByName(LinkedColumns.Values['PromoFlat']).AsString := 'N';

    if LinkedColumns.Values['Description'] <> '' then
      FieldByName('Description').AsString := FieldByName(LinkedColumns.Values['Description']).AsString;

    FieldByName('OldCostPrice').AsCurrency := 0.0;
    FieldByName('OldSalePrice').AsCurrency := 0.0;
    FieldByName('NewSalePrice').AsCurrency := 0.0;
    FieldByName('NewMSRP').AsCurrency := 0.0;

    FieldByName('IDGroup').Value    := 0;
    FieldByName('IDModelGroup').Value    := 0;
    FieldByName('IDModelSubGroup').Value := 0;

    Post;
  end;
end;

procedure TDMValidatePOTextFile.ImportFromMainRetail;
var
  FileCaseQty: Double;
begin
  with TextFile do
  begin
    if (LinkedColumns.Values['CaseQty'] <> '') then
      FileCaseQty := MyStrToFloat(FieldByName(LinkedColumns.Values['CaseQty']).AsString)
    else
      FileCaseQty := 0;

    Edit;

    if (DMGlobal.qryFreeSQL.FieldByName('CaseQty').AsCurrency <> 0) and (FileCaseQty = 0) then
    begin
      FieldByName('CaseQty').AsFloat    := DMGlobal.qryFreeSQL.FieldByName('CaseQty').AsFloat;
      FieldByName('QtyType').AsString   := 'CS (' + DMGlobal.qryFreeSQL.FieldByName('CaseQty').AsString + ' un )';
    end
    else if (FileCaseQty <> 0) then
    begin
      FieldByName('CaseQty').AsFloat      := FieldByName(LinkedColumns.Values['CaseQty']).AsFloat;
      FieldByName('QtyType').AsString     := 'CS (' + FieldByName(LinkedColumns.Values['CaseQty']).AsString + ' un )';
    end
    else
    begin
      FieldByName('CaseQty').AsFloat      := 0;
      FieldByName('QtyType').AsString     := 'EA';
    end;

    FieldByName('IDGroup').AsInteger         := DMGlobal.qryFreeSQL.FieldByName('GroupID').AsInteger;
    FieldByName('IDModel').AsInteger         := DMGlobal.qryFreeSQL.FieldByName('IDModel').AsInteger;
    FieldByName('IDModelGroup').AsInteger    := DMGlobal.qryFreeSQL.FieldByName('IDModelGroup').AsInteger;
    FieldByName('IDModelSubGroup').AsInteger := DMGlobal.qryFreeSQL.FieldByName('IDModelSubGroup').AsInteger;
    FieldByName('NewModel').AsBoolean        := False;

    FieldByName('OldCostPrice').AsCurrency := DMGlobal.qryFreeSQL.FieldByName('VendorCost').AsCurrency;
    FieldByName('OldSalePrice').AsCurrency := DMGlobal.qryFreeSQL.FieldByName('SellingPrice').AsCurrency;
    if not IsClientServer then
      FieldByName('NewSalePrice').AsCurrency := DMGlobal.qryFreeSQL.FieldByName('SellingPrice').AsCurrency;
    FieldByName('NewMSRP').AsCurrency      := DMGlobal.qryFreeSQL.FieldByName('SuggRetail').AsCurrency;

    Post;
  end;
end;

procedure TDMValidatePOTextFile.UpdateModelWithCatalog;
var
  FileCaseQty: Double;
  sBarcodeValue: String;
  Barcode: TBarcode;
  Model: TModel;
  Vendor: TVendor;
  BarcodeService: TCatalogBarcodeService;
  ModelService: TCatalogModelService;
begin
  Barcode := TBarcode.Create;
  Model := TModel.Create;
  Vendor := TVendor.Create;
  BarcodeService := TCatalogBarcodeService.Create;
  BarcodeService.SQLConnection := Self.SQLConnection;

  try
    sBarcodeValue := TextFile.FieldByName(LinkedColumns.Values['Barcode']).Value;
    Barcode.IDBarcode := sBarcodeValue;
    Model.Model := sBarcodeValue;
    Vendor.Vendor := ImpExpConfig.Values['Vendor'];
    Barcode.Model := Model;
    Barcode.Model.Vendor := Vendor;

    if BarcodeService.Find(Barcode) or BarcodeService.FindByModel(Barcode) then
      with TextFile do
      begin
        if not (State = (dsEdit)) then
          Edit;

        if FieldByName('Warning').AsString <> '' then
          FieldByName('Warning').AsString := FieldByName('Warning').AsString + '; Update from Catalog'
        else
          FieldByName('Warning').AsString := 'Update from Catalog';

        FieldByName('Description').AsString := Barcode.Model.Description;
      end;
  finally
    FreeAndNil(Barcode);
    FreeAndNil(BarcodeService);
  end;
end;

procedure TDMValidatePOTextFile.InvalidByBarcode;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString     := 'Invalid Barcode';
end;

procedure TDMValidatePOTextFile.InvalidByCostPrice(AField : String);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Invalid Item ' + AField;
end;

function TDMValidatePOTextFile.ExistsPONum(PONum: String): Boolean;
begin
  with DMGlobal.qryFreeSQL do
  begin
   try
    if Active then
      Close;

    Connection := SQLConnection;

    SQL.Text := ' SELECT IDPO FROM PO '+
                ' WHERE IDPO = ' +  Trim(PONum);
    Open;

    Result := not(IsEmpty);
   finally
    Close;
   end;
  end;
end;

procedure TDMValidatePOTextFile.InvalidByClientServer;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString     := 'New items can not be created; Replication database.';
end;

function TDMValidatePOTextFile.GetModelMarkup(IDModel: Integer): Double;
begin

  Result := 0;

  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := ' SELECT MarkUp FROM Model WHERE IDModel = ' + IntToStr(IDModel);
    Open;
    Result := FieldByName('MarkUp').AsFloat;
    Close;
  end;
end;

function TDMValidatePOTextFile.ValidateItem: Boolean;
begin
  Result := True;

  TextFile.Edit;
  TextFile.FieldByName('Warning').AsString := '';

  if (TextFile.FieldByName(LinkedColumns.Values['Barcode']).AsString = '') then
  begin
    InvalidByBarcode;
    Result := False;
    Exit;
  end;

  try
    StrToFloat(TextFile.FieldByName(LinkedColumns.Values['Qty']).AsString);
  except
    InvalidByQty('Qty');
    Result := False;
  end;

  if (LinkedColumns.Values['CaseQty'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString <> '') then
    try
      StrToFloat(TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString);
    except
      InvalidByQty('CaseQty');
      Result := False;
    end;

  if (LinkedColumns.Values['MinQty'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsString <> '') then
    try
      StrToFloat(TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsString);
    except
     InvalidByQty('MinQty');
      Result := False;
    end;

  if (LinkedColumns.Values['NewCostPrice'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsString <> '') then
    try
      StrToCurr(TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsString);
    except
      InvalidByCostPrice('NewCostPrice');
      Result := False;
    end;

  if (LinkedColumns.Values['FreightCost'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['FreightCost']).AsString <> '') then
    try
      StrToCurr(TextFile.FieldByName(LinkedColumns.Values['FreightCost']).AsString);
    except
      InvalidByCostPrice('FreightCost');
      Result := False;
    end;

  if (LinkedColumns.Values['OtherCost'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['OtherCost']).AsString <> '') then
    try
      StrToCurr(TextFile.FieldByName(LinkedColumns.Values['OtherCost']).AsString);
    except
      InvalidByCostPrice('OtherCost');
      Result := False;
    end;

  if (LinkedColumns.Values['CaseCost'] <> '') and (TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString <> '') then
    try
      StrToCurr(TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString);
    except
      InvalidByCostPrice('CaseCost');
      Result := False;
    end;

end;


function TDMValidatePOTextFile.getSellingPriceObeyIncreasyOnly(
  idmodel: integer; price: Currency): Currency;
var
  MRsellingPrice: Currency;
  qry: TADOQuery;
  messageToDebug: String;
  savePrice: Currency;
  bLocalIncreasePriceOnly : Boolean;
begin
   try
     qry := TADOQuery.Create(nil);
     qry.Connection := SQLConnection;
     qry.SQL.Add('select m.IdModel');
     qry.SQL.Add(',IsNull(m.SellingPrice, 0) as ModelSellingPrice ');
     qry.SQL.add(',Isnull(i.SellingPrice,0) as InvSellingPrice');
     qry.SQL.Add(',i.IdInventory');
     qry.SQL.Add(',IsNull(m.SellingPrice, 0) as SellingPrice');
     qry.SQL.Add(' from Model m');
     qry.SQL.Add(' left outer join Inventory i on m.IdModel = i.ModelID');
     qry.SQL.Add(' where m.IdModel =:idmodel');

     qry.Parameters.ParamByName('idmodel').Value := idmodel;

     debugtofile('sql = ' + qry.SQL.GetText);

     qry.Open;

     debugtofile('qry - open = k');
//     debugtofile('before fix MRSellingPrice = '+ qry.fieldByName('SellingPrice').AsString);

     if ( not qry.FieldByName('SellingPrice').IsNull ) then
        MRsellingPrice := qry.fieldByName('SellingPrice').Value
     else
        MRsellingPrice := 0;

     { Alex 11/18/2011 - DMCalcPrice.IncreasePriceOnly was not being initiated }
     { as a quick fix had to go direct to DB.                                  }
     Qry.Close();
     Qry.SQL.Clear();
     Qry.SQL.Add('SELECT SRVVALUE FROM PARAM WHERE IDPARAM = 117 ');
     Qry.Open();
     bLocalIncreasePriceOnly := qry.fieldByName('SRVVALUE').AsBoolean;

     result := price;

     If ( price < MRsellingPrice ) then begin

        if ( DMCalcPrice = nil ) then begin
           exit;
        end;

        if ( bLocalIncreasePriceOnly = True )
        Then  result := MRsellingPrice
        else  result := price;

     End;
//     debugtofile('Result = '+ FloatToStr(result));
   finally
     qry.Close;
     freeAndNil(qry);
   end;

end;

end.
