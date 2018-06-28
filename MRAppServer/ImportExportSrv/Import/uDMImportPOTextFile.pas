unit uDMImportPOTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, DB, ADODB, DBTables, uDMCalcPrice, uDebugFunctions;

type
  TDMImportPOTextFile = class(TDMImportTextFile)
    spPurchaseDo: TADOStoredProc;
    qryInsPurchase: TADOQuery;
    qryGetIDPreInventoryMov: TADOQuery;
    qryInsPurchaseItem: TADOQuery;
    qryInsModel: TADOQuery;
  private
    IsClientServer: Boolean;
    FDMCalcPrice: TDMCalcPrice;
    FIDVendor: Integer;
    FIDPurchase: Integer;
    FVendorCode: String;
    procedure InsertPurchaseItem(AIDPurchase,IDVendor, IDModel: Integer);
    function InsertPurchase(IDVendor :Integer): Integer;
    function GetIDVendor(Vendor :String): Integer;
    function GetNewIDVendor(Vendor :String): Integer;
    function GetTpPesLastCode: Integer;
    procedure RunPurchaseDo(AIDPurchase : Integer);
    procedure SetQueryConnections;
    function GetIDPOItem(PONumber :String; IDModel,AIDPurchase: Integer): Integer;
    function VerExistsPurchaseItem(IDPOItem,IDModel,IDPurchase : Integer): Boolean;
    procedure SetPurchaseSubTotal(AIDPurchase : Integer);
    function InsertModel: Integer;
    function CreateModel(IDVendor: Integer; Barcode, VendorCode: String; MinQtyPO, CaseQty: Double; VendorCost : Currency): Integer;
    procedure InsertModelBarcode(IDModel: Integer; Barcode : String);
    procedure InsertModelVendor(IDModel, IDVendor :Integer; MinQtyPO, CaseQty: Double; VendorCost : Currency);
    procedure InsertModelVendorCode(IDModel, IDVendor :Integer; VendorCode :String);
    procedure UpdateModel(IDModel, IDVendor: Integer; Description, VendorCode: String; CaseQty, Cost: Currency; MinQtyPO, VendorCaseQty: Double);
    procedure BeforeImport; override;
    procedure ImportLine; override;
    procedure AfterImport; override;
    procedure UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
    function getSellingPriceObeyIncreasyOnly_X(idmodel: integer; price: Currency): Currency;
  end;

implementation

uses uNumericFunctions, uDMGlobal, uSystemConst, uContentClasses, uObjectServices;

{$R *.dfm}

{ TDMImportPOFile }

procedure TDMImportPOTextFile.UpdateModel(IDModel, IDVendor: Integer; Description, VendorCode: String; CaseQty, Cost: Currency; MinQtyPO, VendorCaseQty: Double);
var
  sVendorUpdFields,
  sModelUpdFields : String;
begin
  with DMGlobal.qryFreeSQL do
  begin
    try
      if Active then
        Close;

      SQL.Text := ' SELECT Description, CaseQty FROM Model WHERE IDModel = ' + IntToStr(IDModel);
      Open;

      sModelUpdFields := '';

      if (Trim(Description) <> '') and (Trim(FieldByName('Description').AsString) <> Trim(Description)) then
        sModelUpdFields := ' Description = ' + QuotedStr(Description);

      if FieldByName('CaseQty').AsCurrency <> CaseQty then
        if sModelUpdFields = '' then
          sModelUpdFields := ' CaseQty = ' + CurrToStr(CaseQty)
        else
          sModelUpdFields := sModelUpdFields + ' , CaseQty = ' + CurrToStr(CaseQty);

      if sModelUpdFields <> '' then
      begin
        sModelUpdFields := sModelUpdFields + ', DateLastSellingPrice = GetDate()';
        DMGlobal.ExecuteSQL('UPDATE Model SET ' + sModelUpdFields + ' WHERE IDModel = ' + IntToStr(IDModel), SQLConnection);
      end;

    finally
     Close;
    end;

    if VendorCode <> '' then
     try
       if Active then
        Close;

       SQL.Text := ' SELECT VendorCode FROM VendorModelCode WHERE IDModel = ' + IntToStr(IDModel) + ' AND IDPessoa = ' + IntToStr(IDVendor);
       Open;

       if not(IsEmpty) and (FieldByName('VendorCode').AsString <> VendorCode) then
         DMGlobal.ExecuteSQL('UPDATE VendorModelCode SET VendorCode = ' + QuotedStr(VendorCode) + ' WHERE IDModel = ' +
                                IntToStr(IDModel) +  ' AND IDPessoa = ' + IntToStr(IDVendor) ,SQLConnection)
       else if IsEmpty then
         InsertModelVendorCode(IDModel,IDVendor,VendorCode);
     finally
       Close;
     end;

    if (MinQtyPO > 0) then
     try
       if Active then
        Close;

       SQL.Text := ' SELECT MinQtyPO, CaseQty FROM Inv_ModelVendor WHERE IDModel = ' + IntToStr(IDModel) + ' AND IDPessoa = ' + IntToStr(IDVendor);
       Open;

       if not(IsEmpty) then
       begin
         sVendorUpdFields := '';

         if (FieldByName('MinQtyPO').AsFloat <> MinQtyPO) then
           sVendorUpdFields := ' MinQtyPO = ' + FloatToStr(MinQtyPO);

         if (FieldByName('CaseQty').AsFloat <> CaseQty) then
           if sVendorUpdFields = '' then
             sVendorUpdFields := ' CaseQty = ' + FloatToStr(CaseQty)
           else
             sVendorUpdFields := sVendorUpdFields + ' , CaseQty = ' + FloatToStr(CaseQty);


         if (Cost <> 0) then
           if sVendorUpdFields = '' then
             sVendorUpdFields := ' VendorCost = ' + MyFormatCur(Cost, '.')
           else
             sVendorUpdFields := sVendorUpdFields + ' , VendorCost = ' + MyFormatCur(Cost, '.');


          if sVendorUpdFields <> '' then
            DMGlobal.ExecuteSQL('UPDATE Inv_ModelVendor SET ' + sVendorUpdFields + ' WHERE IDModel = ' +
                                 IntToStr(IDModel) +  ' AND IDPessoa = ' + IntToStr(IDVendor), SQLConnection);

       end
       else if IsEmpty then
         InsertModelVendor(IDModel, IDVendor, MinQtyPO, CaseQty, Cost);
     finally
       Close;
     end;

    // Update KitModel
    UpdateKitPromoPrice(IDModel, Cost);
  end;
end;

procedure TDMImportPOTextFile.UpdateKitPromoPrice(IDModel: Integer; CostPrice: Currency);
var
  KitModelService: TMRKitModelService;
  KitModel: TKitModel;
begin
  with DMGlobal.qryFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := ' SELECT Qty, MarginPerc FROM KitModel WHERE IDModel = ' + IntToStr(IDModel) + ' AND ISNULL(MarginPerc, 0) <> 0 ';
    Open;

    if not(IsEmpty) then
    try
      KitModelService                  := TMRKitModelService.Create();
      KitModel                         := TKitModel.Create();

      KitModelService.SQLConnection := DMGlobal.qryFreeSQL.Connection;

      First;
      While not Eof do
      begin
        // Campos necessários
        KitModel.IDModel         := IDModel;
        KitModel.Qty             := FieldByName('Qty').AsFloat;
        if not DMGlobal.IsClientServer(SQLConnection) then
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

function TDMImportPOTextFile.InsertPurchase(IDVendor :Integer): Integer;
begin
  Result := DMGlobal.GetNextCode('Pur_Purchase', 'IDPurchase',SQLConnection);
  with qryInsPurchase do
  try
    Parameters.ParamByName('IDPurchase').Value := Result;
    Parameters.ParamByName('DatePreReceiving').Value   := FormatDateTime('ddddd',Now);
    Parameters.ParamByName('DocumentType').Value       := 'Invoice';
    Parameters.ParamByName('OtherCharges').Value       := 0;
    Parameters.ParamByName('IDFornecedor').Value       := IDVendor;
    Parameters.ParamByName('IDStore').Value            := MyStrToInt(ImpExpConfig.Values['Store']);
    Parameters.ParamByName('IDUserPreReceiving').Value := MyStrToInt(ImpExpConfig.Values['User']);

    if not(ImpExpConfig.Values['Purchase_Number'] = '') then
      Parameters.ParamByName('DocumentNumber').Value  := MyStrToInt(ImpExpConfig.Values['Purchase_Number'])
    else
      Parameters.ParamByName('DocumentNumber').Value  := null;

    if not(ImpExpConfig.Values['Freight'] = '') then
      Parameters.ParamByName('Freight').Value := MyFormatCur(MyStrToCurrency(ImpExpConfig.Values['Freight']), ImpExpConfig.Values['DecimalDelimiter'][1])
    else
      Parameters.ParamByName('Freight').Value := 0;

    if not(ImpExpConfig.Values['RecordDate'] = '') then
      Parameters.ParamByName('DocumentDate').Value := FormatDateTime('ddddd',StrtoDateTime(ImpExpConfig.Values['RecordDate']))
    else
      Parameters.ParamByName('DocumentDate').Value := null;

    if not(ImpExpConfig.Values['DueDate'] = '') then
      Parameters.ParamByName('DocumentDueDate').Value := FormatDateTime('ddddd',StrtoDateTime(ImpExpConfig.Values['DueDate']))
    else
      Parameters.ParamByName('DocumentDueDate').Value := null;

    if not(ImpExpConfig.Values['PONumber'] = '') then
      Parameters.ParamByName('IDPO').Value := MyStrToInt(ImpExpConfig.Values['PONumber'])
    else
      Parameters.ParamByName('IDPO').Value := null;

    ExecSQL;
  finally
    qryInsPurchase.Close;
  end;
end;

procedure TDMImportPOTextFile.InsertPurchaseItem(AIDPurchase,IDVendor,IDModel: Integer);
var
  cDecimalDelimiter: Char;
  IDPurchaseItem: Integer;
  NewQty, NewCaseQty: Currency;
begin
  IDPurchaseItem := DMGlobal.GetNextCode('Pur_PurchaseItem', 'IDPurchaseItem',SQLConnection);
  cDecimalDelimiter := ImpExpConfig.Values['DecimalDelimiter'][1];

  with qryInsPurchaseItem do
  try
    Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
    Parameters.ParamByName('IDPurchase').Value     := AIDPurchase;
    Parameters.ParamByName('IDGroup').Value        := TextFile.FieldByName('IDGroup').AsInteger;
    Parameters.ParamByName('IDModel').Value        := IDModel;
    Parameters.ParamByName('IDFornecedor').Value   := IDVendor;
    Parameters.ParamByName('Barcode').Value        := null;//TextFile.FieldByName(LinkedColumns.Values['Barcode']).AsString;

    if not(ImpExpConfig.Values['PONumber'] = '') then
      Parameters.ParamByName('IDPOItem').Value := GetIDPOItem(ImpExpConfig.Values['PONumber'],TextFile.FieldByName('IDModel').AsInteger,AIDPurchase)
    else
      Parameters.ParamByName('IDPOItem').Value := null;

    if TextFile.FieldByName('NewSalePrice').AsCurrency <> 0 then begin
       Parameters.ParamByName('NewSalePrice').Value := getSellingPriceObeyIncreasyOnly_X(idmodel, TextFile.FieldByName('NewSalePrice').AsCurrency);
    end else
       Parameters.ParamByName('NewSalePrice').Value := TextFile.FieldByName('OldSalePrice').AsCurrency;

    if TextFile.FieldByName('NewMSRP').AsCurrency <> 0  then
      Parameters.ParamByName('NewSuggRetail').Value := TextFile.FieldByName('NewMSRP').AsCurrency
    else
      Parameters.ParamByName('NewSuggRetail').Value := TextFile.FieldByName('NewMSRP').AsCurrency;

    if not(LinkedColumns.Values['FreightCost'] = '') then
      Parameters.ParamByName('FreightCost').Value := MyFormatCur(MyStrToCurrency(TextFile.FieldByName(LinkedColumns.Values['FreightCost']).AsString), cDecimalDelimiter)
    else
      Parameters.ParamByName('FreightCost').Value := 0;

    if not(LinkedColumns.Values['OtherCost'] = '') then
      Parameters.ParamByName('OtherCost').Value := MyFormatCur(MyStrToCurrency(TextFile.FieldByName(LinkedColumns.Values['OtherCost']).AsString), cDecimalDelimiter)
    else
      Parameters.ParamByName('OtherCost').Value := 0;

    Parameters.ParamByName('CaseQty').Value      := TextFile.FieldByName('CaseQty').AsCurrency;
    Parameters.ParamByName('CaseCost').Value     := TextFile.FieldByName('CaseCost').AsCurrency;
    Parameters.ParamByName('Qty').Value          := TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat;
    Parameters.ParamByName('NewCostPrice').Value := TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency;
    Parameters.ParamByName('CostPrice').Value    := TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency;

    if (TextFile.FieldByName('QtyType').AsString = 'EA') then
      Parameters.ParamByName('Qty').Value          := TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat
    else
      begin
        NewQty := (TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat * TextFile.FieldByName('CaseQty').AsFloat);
        NewCaseQty := TextFile.FieldByName(LinkedColumns.Values['Qty']).AsFloat;

        Parameters.ParamByName('Qty').Value     := NewQty;
        Parameters.ParamByName('CaseQty').Value := NewCaseQty;
      end;

    if (LinkedColumns.Values['PromoFlat'] <> '') and
       ((TextFile.FieldByName(LinkedColumns.Values['PromoFlat']).AsString = 'Y') or
       (TextFile.FieldByName(LinkedColumns.Values['PromoFlat']).AsString = '1')) then
      Parameters.ParamByName('IsPromo').Value  := True
    else
      Parameters.ParamByName('IsPromo').Value  := False;

    ExecSQL;
  finally
    qryInsPurchaseItem.Close;
  end;
end;

function TDMImportPOTextFile.GetIDVendor(Vendor: String): Integer;
begin
  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;

    SQL.Text := 'SELECT IDPessoa from Pessoa '+
                ' WHERE Pessoa = ' + QuotedStr(Vendor) + ' AND IDTipoPessoa = 2 ';
    Open;

     if IsEmpty then
       Result := GetNewIDVendor(Vendor)
     else
       Result := FieldByName('IDPessoa').AsInteger;
   end;
end;

function TDMImportPOTextFile.GetNewIDVendor(Vendor: String): Integer;
var
  IDPessoa, Code : Integer;
begin
  Result := -1;

  try
    IDPessoa := DMGlobal.GetNextCode('Pessoa', 'IDPessoa',SQLConnection);
    DMGlobal.RunSQL(' UPDATE TipoPessoa SET LastCode = IsNull(LastCode,0) + 1 ' +
           ' Where IDTipoPessoa = 2 ',SQLConnection);


    Code := GetTpPesLastCode;


    DMGlobal.RunSQL('INSERT INTO Pessoa (IDPessoa,IDTipoPessoa,IDStore,IDTipoPessoaRoot,IDUSer,Pessoa,Juridico,Code) VALUES ' +
           ' (' + InttoStr(IDPessoa) + ' , 2 , ' + ImpExpConfig.Values['Store'] + ' , 2 , ' + ImpExpConfig.Values['User'] +
           ' , ' + QuotedStr(Vendor) + ' , 1 , ' + InttoStr(Code) + ' ) ' , SQLConnection);

    Result := IDPessoa;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

function TDMImportPOTextFile.GetTpPesLastCode: Integer;
begin
  Try
   with DMGlobal.qryFreeSQL do
   begin
    if Active then
      Close;

    SQL.Text := ' SELECT LastCode from TipoPessoa WHERE IDTipoPessoa = 2 and Path = ''.002'' ';
    Open;

    Result := FieldByName('LastCode').AsInteger;
   end;
  finally
    DMGlobal.qryFreeSQL.Close;
  end;
end;

procedure TDMImportPOTextFile.RunPurchaseDo(AIDPurchase : Integer);
begin
  Try
    with spPurchaseDo do
      begin
      Parameters.ParamByName('@IDPurchase').Value := InttoStr(AIDPurchase);
      Parameters.ParamByName('@Date').Value       := Now;
      Parameters.ParamByName('@TaxInCost').Value  := False;
      ExecProc;
      end;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

procedure TDMImportPOTextFile.SetQueryConnections;
begin
  inherited;
  DMGlobal.qryFreeSQL.Connection := SQLConnection;
  qryInsPurchase.Connection := SQLConnection;
  qryGetIDPreInventoryMov.Connection := SQLConnection;
  qryInsPurchaseItem.Connection := SQLConnection;
  spPurchaseDo.Connection := SQLConnection;
end;

function TDMImportPOTextFile.GetIDPOItem(PONumber :String; IDModel,AIDPurchase: Integer): Integer;
begin
  Result := -1;

  Try
   with qryGetIDPreInventoryMov do
   begin
    if Active then
      Close;

    SQL.Text := ' SELECT IDPreInventoryMov FROM PreInventoryMov ' +
                ' WHERE DocumentID = ' + PONumber + ' AND ModelID = ' + InttoStr(IDModel) + ' AND InventMovTypeID = 2';
    Open;

    if qryGetIDPreInventoryMov.RecordCount > 1 then
    begin
      First;
      while not(Eof) and (Result = -1) do
      begin
        if VerExistsPurchaseItem(FieldByName('IDPreInventoryMov').AsInteger,IDModel,AIDPurchase) then
         Next
        else
          Result := FieldByName('IDPreInventoryMov').AsInteger;
      end;
    end
    else
      Result := FieldByName('IDPreInventoryMov').AsInteger;
   end;
  finally
    qryGetIDPreInventoryMov.Close;
  end;
end;

function TDMImportPOTextFile.VerExistsPurchaseItem(IDPOItem, IDModel,
  IDPurchase: Integer): Boolean;
begin
   with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;

     SQL.Text := 'SELECT IDPurchase FROM Pur_PurchaseItem '+
                ' WHERE IDPOItem = ' + InttoStr(IDPOItem) + ' AND IDModel = ' + InttoStr(IDModel) + ' AND IDPurchase = ' + InttoStr(IDPurchase);
     try
       Open;

      if IsEmpty then
        Result := False
      else
        Result := True;
     finally
       Close;
     end;
   end;
end;

procedure TDMImportPOTextFile.SetPurchaseSubTotal(AIDPurchase: Integer);
begin
  DMGlobal.ExecuteSQL('EXEC sp_Purchase_AtuPurchaseSubTotal ' + InttoStr(AIDPurchase) + ', 0', SQLConnection);
end;

function TDMImportPOTextFile.CreateModel(IDVendor: Integer; Barcode, VendorCode: String;
  MinQtyPO, CaseQty: Double; VendorCost : Currency): Integer;
begin
  FVendorCode := VendorCode;
  Result := InsertModel;
  InsertModelBarcode(Result, Barcode);
  InsertModelVendor(Result, IDVendor, MinQtyPO, CaseQty, VendorCost);
end;

function TDMImportPOTextFile.InsertModel: Integer;
var
  cDecimalDelimiter : Char;
  sDescription: String;
begin
  Result := DMGlobal.GetNextCode('Model', 'IDModel',SQLConnection);
  cDecimalDelimiter := ImpExpConfig.Values['DecimalDelimiter'][1];
  qryInsModel.Connection := SQLConnection;

  if LinkedColumns.Values['Description'] <> '' then
    sDescription := TextFile.FieldByName(LinkedColumns.Values['Description']).AsString
  else
    sDescription := TextFile.FieldByName('Description').AsString;

  with qryInsModel do
  try
    Parameters.ParamByName('IDModel').Value     := Result;
    Parameters.ParamByName('GroupID').Value     := TextFile.FieldByName('IDGroup').AsString;

    if (TextFile.FieldByName('IDModelGroup').AsString <> '') and (TextFile.FieldByName('IDModelGroup').AsInteger <> 0) then
      Parameters.ParamByName('IDModelGroup').Value     := TextFile.FieldByName('IDModelGroup').AsString
    else
      Parameters.ParamByName('IDModelGroup').Value     := null;

    if (TextFile.FieldByName('IDModelSubGroup').AsString <> '') and (TextFile.FieldByName('IDModelSubGroup').AsInteger <> 0) then
      Parameters.ParamByName('IDModelSubGroup').Value     := TextFile.FieldByName('IDModelSubGroup').AsString
    else
      Parameters.ParamByName('IDModelSubGroup').Value     := null;

    Parameters.ParamByName('Model').Value       := TextFile.FieldByName('Model').AsString;
    Parameters.ParamByName('Description').Value := sDescription;
    Parameters.ParamByName('ModelType').Value   := MODEL_TYPE_REGULAR;
    Parameters.ParamByName('VendorCost').Value  := TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency;
    Parameters.ParamByName('SuggRetail').Value  := TextFile.FieldByName('NewMSRP').AsFloat;
    Parameters.ParamByName('Verify').Value      := True;
    Parameters.ParamByName('CaseQty').Value     := TextFile.FieldByName('CaseQty').AsString;
    Parameters.ParamByName('DateLastSellingPrice').Value  := Now;

    ExecSQL;

    InsertModelVendorCode(Result, FIDVendor, FVendorCode);
  finally
    Close;
   end;
end;

procedure TDMImportPOTextFile.InsertModelBarcode(IDModel :Integer; Barcode : String);
begin
  DMGlobal.ExecuteSQL('INSERT INTO Barcode (IDBarcode, IDModel, Data, BarcodeOrder) VALUES ( ' + QuotedStr(Barcode) + ' , ' + InttoStr(IDModel) + ' , GetDate() , 1) ', SQLConnection);
end;

procedure TDMImportPOTextFile.InsertModelVendor(IDModel, IDVendor :Integer; MinQtyPO, CaseQty: Double; VendorCost : Currency);
begin
  DMGlobal.ExecuteSQL('INSERT INTO Inv_ModelVendor (IDPessoa, IDModel, VendorOrder, MinQtyPO, CaseQty, VendorCost) (SELECT ' + InttoStr(IDVendor) + ' , ' +  InttoStr(IDModel) + ' , IsNull(MAX(VendorOrder), 0)+1 , ' + FloatToStr(MinQtyPO) + ' , ' + FloatToStr(CaseQty) + ' ,' + MyFormatCur(VendorCost, '.') + ' FROM Inv_ModelVendor WHERE IDModel = ' + InttoStr(IDModel) + ' )', SQLConnection);
end;

procedure TDMImportPOTextFile.InsertModelVendorCode(IDModel, IDVendor :Integer; VendorCode :String);
var
  IDVendorModelCode: integer;
begin
  IDVendorModelCode := DMGlobal.GetNextCode('VendorModelCode', 'IDVendorModelCode',SQLConnection);
  DMGlobal.ExecuteSQL('INSERT INTO VendorModelCode (IDVendorModelCode, IDPessoa, IDModel, VendorCode) VALUES ( ' + InttoStr(IDVendorModelCode) + ' , ' + InttoStr(IDVendor) + ' , ' + InttoStr(IDModel) + ' , ' + QuotedStr(VendorCode) + ' ) ',SQLConnection);
end;

procedure TDMImportPOTextFile.BeforeImport;
begin
  inherited;
  SetQueryConnections;
  FIDVendor := GetIDVendor(ImpExpConfig.Values['Vendor']);
  FIDPurchase := InsertPurchase(FIDVendor);
  IsClientServer := DMGlobal.IsClientServer(SQLConnection);
end;

procedure TDMImportPOTextFile.ImportLine;
var
  iIDModel : Integer;
  sDescription : String;
begin
  inherited;

  if not(IsClientServer) and TextFile.FieldByName('NewModel').AsBoolean then
  begin
    iIDModel := CreateModel(FIDVendor,
                            TextFile.FieldByName(LinkedColumns.Values['Barcode']).AsString,
                            TextFile.FieldByName('VendorModelCode').AsString,
                            TextFile.FieldByName('MinQtyPO').AsFloat,
                            TextFile.FieldByName('CaseQty').AsFloat,
                            TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency);
  end
  else
  begin
    iIDModel := TextFile.FieldByName('IDModel').AsInteger;

    if not(IsClientServer) then
    begin
      if LinkedColumns.Values['Description'] <> '' then
        sDescription := TextFile.FieldByName(LinkedColumns.Values['Description']).AsString
      else
        sDescription := TextFile.FieldByName('Description').AsString;

      if (TextFile.FieldByName('QtyType').AsString = 'EA') then
        UpdateModel(iIDModel,
                    FIDVendor,
                    sDescription,
                    TextFile.FieldByName('VendorModelCode').AsString,
                    0,
                    TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency,
                    TextFile.FieldByName('MinQtyPO').AsFloat,
                    TextFile.FieldByName('CaseQty').AsFloat)
      else
        UpdateModel(iIDModel,
                    FIDVendor,
                    sDescription,
                    TextFile.FieldByName('VendorModelCode').AsString,
                    TextFile.FieldByName('CaseQty').AsCurrency,
                    TextFile.FieldByName(LinkedColumns.Values['NewCostPrice']).AsCurrency,
                    TextFile.FieldByName('MinQtyPO').AsFloat,
                    TextFile.FieldByName('CaseQty').AsFloat);
    end;
  end;

  InsertPurchaseItem(FIDPurchase, FIDVendor, iIDModel);
end;

procedure TDMImportPOTextFile.AfterImport;
begin
  inherited;
  SetPurchaseSubTotal(FIDPurchase);
  RunPurchaseDo(FIDPurchase);
end;

function TDMImportPOTextFile.getSellingPriceObeyIncreasyOnly_X(
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

     debugtofile('param IdModel = '+ intToStr(idmodel));
     debugtofile('sql = ' + qry.SQL.GetText);

     qry.Open;

     debugtofile('qry.open = ok ');

     MRsellingPrice := qry.fieldByName('SellingPrice').Value;



     { Alex 11/18/2011 - DMCalcPrice.IncreasePriceOnly was not being initiated }
     { as a quick fix had to go direct to DB.                                  }
     Qry.Close();
     Qry.SQL.Clear();
     Qry.SQL.Add('SELECT SRVVALUE FROM PARAM WHERE IDPARAM = 117 ');
     Qry.Open();
     bLocalIncreasePriceOnly := qry.fieldByName('SRVVALUE').AsBoolean;

     result := price;

     If ( price < MRsellingPrice ) then begin

        if ( bLocalIncreasePriceOnly = True )
        Then  result := MRsellingPrice
        else  result := price;

     End;

   finally
     qry.Close;
     freeAndNil(qry);
   end;

end;

end.
