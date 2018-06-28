unit uDMValidateVCTextFile;

interface

uses
Dialogs,  SysUtils, Classes, Variants, ADODB, DB, uDMCalcPrice,
  uDMImportTextFile, uDMValidateTextFile, DBClient;

type
  TDMValidateVCTextFile = class(TDMValidateTextFile)
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

    { Alex 05/04/2011 }
    function LeaveOnlyNumbers( psText : String ) : String;

    function FindModelWithBarcode( psBarCode : String ) : Integer;
    function FindModelWithVendorCode( piIdVendor : Integer; psVendorCode : String ) : Integer;

  public
    function ValidateModels: Boolean;
    function NotExistsPurchaseNum(PurchaseNum,Vendor : String): Boolean;
    function ExistsPONum(PONum: String): Boolean;
    Function ValidateItem: Boolean;

    function Validate: Boolean; override; { Use this function  }

  end;

implementation

uses uNumericFunctions, uDMGlobal, uSystemConst, uObjectServices,
     UDebugFunctions, uContentClasses, Math;

{$R *.dfm}

{ TDMValidatePOTextFile }

procedure TDMValidateVCTextFile.OpenPoItemList(PONumber : Integer);
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

function TDMValidateVCTextFile.Validate: Boolean;
Var
  sVendorCode, sBarCode : String;
  bModelFound : Boolean;

  iIdModelFound, iIdVendor : Integer;
  bUseCatalog, CostIsCaseCost, PromoCost: Boolean;
  NewCostPrice, FileCaseCost, NewCaseCost: Currency;

  Model : TModel;
  ModelService : TMRModelService;

  ModelVendor : TModelVendor;
  ModelVendorService : TMRModelVendorService;

  VendorModelCode : TVendorModelCode;
  VendorModelCodeService : TMRVendorModelCodeService;
begin

  IsClientServer := DMGlobal.IsClientServer(SQLConnection);

  try

    CostIsCaseCost := (ImpExpConfig.Values['CostIsCaseCost'] = 'True');
    debugtofile('get CaseCost - ok');
    iIdVendor      := GetIDVendor( ImpExpConfig.Values['Vendor'] );
    debugtofile('get IdVendor - ok');

    TextFile.First;
    debugtofile('set first client record - ok');

    ModelVendor := TModelVendor.Create;
    debugtofile('model vendor created - ok');

    ModelVendorService := TMRModelVendorService.Create;
    debugtofile('model vendor service created - ok ');

    ModelVendorService.SQLConnection := Self.SQLConnection;
    debugtofile('connection to model vendor service - ok');

    VendorModelCode := TVendorModelCode.Create();
    debugtofile('vendor model code created - ok');

    VendorModelCodeService := TMRVendorModelCodeService.Create();
    debugtofile('vendor model code service created - ok');

    VendorModelCodeService.SQLConnection := Self.SQLConnection;
    debugtofile('connection to model code service - ok');

    debugtofile('starting to read cds client - ok');
    while not TextFile.Eof do
    begin

      iIdModelFound := -1;

      debugtofile('trying to find model by barcode...');
      { Find model with Bar Code }
      if ( LinkedColumns.Values['Barcode'] <> '') then
      begin

        sBarCode := TextFile.FieldByName( LinkedColumns.Values['BarCode'] ).AsString;
        debugtofile('barcode = '+ sBarcode);

        if ( Trim( sBarCode ) <> 'NO UPC' ) then
        begin
          debugtofile('barcode <> NO UPC');
          sBarCode := LeaveOnlyNumbers( sBarCode );

          if ( Length( sBarCode ) >= 12 ) then
          begin
              debugtofile('barcode length >= 12');
              iIdModelFound := FindModelWithBarcode( sBarCode );
              debugtofile('Idmodel = ' + intToStr(iIdmodelFound) + ' found to barcode '+ sBarcode);
          end;

        end;

      end;

      { If didnt find the model by the Bar Code try with Vendor ID and Vendor Code }
      if ( iIdModelFound = -1 ) then
      begin
        debugtofile('IdModel not found yet. Trying by vendorCode');
        if ( LinkedColumns.Values['VendorCode'] <> '') then
        begin

          sVendorCode := TextFile.FieldByName( LinkedColumns.Values['VendorCode'] ).AsString;
          debugtofile('Vendor code = '+ sVendorCode);
          iIdModelFound := FindModelWithVendorCode( iIdVendor, sVendorCode );
          debugtofile('IdModel = '+ intToStr(iIdModelFound) +' found by vendor');
        end;

      end;

      { If didnt find the model by the Bar Code nor by Vendor Code DELETE IT }
      if ( iIdModelFound = -1 ) then
      begin
       debugtofile('IdModel not found by barcode or vendor, will be deleted');
       TextFile.Delete;
       debugtofile('model deleted');
       Continue;

      End;

      { Model found, start updates }
      debugtofile('model found, start update in (TextFilecds)');
      if not(TextFile.State = (dsEdit))
      then TextFile.Edit;
      debugtofile('TextFileCds in edit state to IdModel ' + intToStr(iIdModelFound));

      If ( TextFile.FieldByName('OldCaseQty').AsString = 'N/A' ) Then  TextFile.FieldByName('OldCaseQty').AsString := '';
      debugtofile('dealt OldCaseQty');

      If ( TextFile.FieldByName('OldMinQty').AsString  = 'N/A' ) Then TextFile.FieldByName('OldMinQty').AsString   := '';
      debugtofile('dealt OldMinQty');

      If ( TextFile.FieldByName(LinkedColumns.Values['Cost']).AsString     = 'N/A' ) Then TextFile.FieldByName(LinkedColumns.Values['Cost']).AsString      := '';
      debugtofile('dealt Cost');
      If ( TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString = 'N/A' ) Then TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString  := '';
      debugtofile('dealt CaseCost');

      If ( TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString  = 'N/A' ) Then TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString   := '';
      debugtofile('dealt CaseQty');

      TextFile.FieldByName('Validation').AsBoolean := True;
      debugtofile('Validation = true');

      TextFile.FieldByName('Update').AsString      := '1';
      debugtofile('update = 1');

      TextFile.FieldByName('Warning').AsString     := '';
      debugtofile('no warnings');

      TextFile.FieldByName('IdModel').AsInteger    :=  iIdModelFound;
      debugtofile('Idmodel in TextCdsFile = ' + intToStr(iIdModelFound));


      ModelVendor.IDModel  := iIdModelFound;
      ModelVendor.IDVendor := iIdVendor;

      If ( ModelVendorService.Find( ModelVendor ) ) Then Begin
        debugtofile('modelVendorService.find(modelvendor)');
        TextFile.FieldByName('OldCost').AsFloat     := ModelVendor.VendorCost;
        debugtofile('oldcost = modelvendor.cost');

        TextFile.FieldByName('OldCaseQty').AsFloat  := ModelVendor.CaseQty;
        debugtofile('oldcaseqty = modelvendor.caseqty');

        TextFile.FieldByName('OldMinQty').AsFloat   := ModelVendor.MinQtyPO;
        debugtofile('oldMinQty = modelvendor.MinQtyPO');

      End Else Begin
        debugtofile('ModelVendor not found');

        Model := TModel.Create;
        Model.IDModel  := iIdModelFound;

        ModelService := TMRModelService.Create;
        ModelService.SQLConnection := Self.SQLConnection;

        If ( ModelService.FindById( Model ) ) Then Begin

          TextFile.FieldByName('OldCost').AsFloat     := Model.VendorCost;
          TextFile.FieldByName('OldCaseQty').AsString := 'N/A';
          TextFile.FieldByName('OldMinQty').AsString  := 'N/A';

        End;
        debugtofile('moved oldCost, OldCaseQty, OldMinQty to TextFileCds');

      End;

      { Calculations }
      debugtofile('cost from textfilecds = ' + floatToStr(TextFile.FieldByName( LinkedColumns.Values['Cost'] ).AsFloat));
      debugtofile('oldcost from textfilecds = ' + floatToStr(TextFile.FieldByName('OldCost').AsFloat));

      //amfsouza July 18, 2012 - fix catastrophic error.
      if ( TextFile.FieldByName('OldCost').AsFloat > 0 ) then begin

          TextFile.FieldByName('CostChange').AsFloat := ( ( ( TextFile.FieldByName( LinkedColumns.Values['Cost'] ).AsFloat -
                                                              TextFile.FieldByName('OldCost').AsFloat ) /
                                                            TextFile.FieldByName('OldCost').AsFloat ) * 100 );
      end
      else
        TextFile.FieldByName('CostChange').AsFloat := 0;

      TextFile.FieldByName('CostChange').AsString   := FloatToStrF( TextFile.FieldByName('CostChange').AsFloat, ffFixed, 15, 2 );
      debugtofile('costchange calculated');

      TextFile.FieldByName('AbsCostChange').AsFloat := Abs( TextFile.FieldByName('CostChange').AsFloat );

      VendorModelCode.IDVendor   := iIdVendor;
      VendorModelCode.IDModel    := iIdModelFound;
      VendorModelCode.VendorCode := TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString;
      debugtofile('filled vendorModelCode');

      If ( VendorModelCodeService.FindByVendorCode( VendorModelCode ) )
      Then TextFile.FieldByName('ChangeType').Asstring := 'U'
      Else TextFile.FieldByName('ChangeType').Asstring := 'N';

      If ( TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString = '')
      Then TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString := 'N/A';

      TextFile.Post();
      DebugToFile('cds textfile record updated');

      if TextFile.State = (dsEdit)
      then TextFile.Post;

      TextFile.Next;
      debugtofile('set next record');

    end; { while not TextFile.Eof do }

    { Removed models treatment }

    If DMGlobal.qryFreeSQL.Active then DMGlobal.qryFreeSQL.Close;

    DMGlobal.qryFreeSQL.Connection := SQLConnection;

    DMGlobal.qryFreeSQL.SQL.Text := 'SELECT M.IDModel, M.Description, V.VendorCode, B.Idbarcode, '+
                                    '       I.VendorCost, I.CaseQty, I.MinQtyPO '+
                                    'FROM VendorModelCode V '+
                                    '       JOIN Model M ON (M.IDModel = V.IDModel) ' +
                                    '       JOIN Inv_ModelVendor I On ( V.IDModel = I.IDModel and V.IDPESSOA = I.IDPESSOA ) '+
                                    '       LEFT JOIN Barcode B on ( M.IDModel = B.IDModel and B.BarcodeOrder = 1 ) '+
                                    'WHERE V.IDPessoa = ' + IntToStr( iIdVendor );
    DMGlobal.qryFreeSQL.Open();
    debugtofile('open VendorModelCode with sql = '+ dmglobal.qryFreeSQL.SQL.text);
    While ( Not DMGlobal.qryFreeSQL.Eof ) Do Begin
      debugtofile('try locate idmodel = '+ DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsString + ' in textfilecds');
      If ( Not TextFile.Locate('IDMODEL;'+LinkedColumns.Values['VendorCode'],
                               VarArrayOf([DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsInteger,
                                           DMGlobal.qryFreeSQL.FieldByName('VENDORCODE').AsString] ), [] ) )
      Then Begin
        debugtofile('IdModel not found, try insert');
        TextFile.Insert();

        TextFile.FieldByName('Validation').AsBoolean  := True;
        TextFile.FieldByName('Update').AsString       := '1';
        TextFile.FieldByName('Warning').AsString      := '';
        TextFile.FieldByName('ChangeType').Asstring   := 'R';

        TextFile.FieldByName('IdModel').AsInteger     := DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsInteger;
        TextFile.FieldByName('Description').AsString  := DMGlobal.qryFreeSQL.FieldByName('DESCRIPTION').AsString;

        TextFile.FieldByName(LinkedColumns.Values['BarCode']).AsString    := DMGlobal.qryFreeSQL.FieldByName('IDBARCODE').AsString;
        TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString := DMGlobal.qryFreeSQL.FieldByName('VENDORCODE').AsString;


        TextFile.FieldByName(LinkedColumns.Values['Cost']).AsString      := 'N/A';
        TextFile.FieldByName(LinkedColumns.Values['CaseCost']).AsString  := 'N/A';
        TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsString   := 'N/A';

        TextFile.FieldByName('OldCost').AsFloat       := DMGlobal.qryFreeSQL.FieldByName('VENDORCOST').AsFloat;
        TextFile.FieldByName('OldCaseQty').AsFloat    := DMGlobal.qryFreeSQL.FieldByName('CASEQTY').AsFloat;
        TextFile.FieldByName('OldMinQty').AsFloat     := DMGlobal.qryFreeSQL.FieldByName('MINQTYPO').AsFloat;

        TextFile.FieldByName('CostChange').AsFloat    := 100;
        TextFile.FieldByName('AbsCostChange').AsFloat := 100;

        TextFile.Post();
        debugtofile('model inserted = '+ DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsString);
       End;

      DMGlobal.qryFreeSQL.Next();

    End;

    Result := True;

  finally

    FreeAndNil( Model );
    FreeAndNil( ModelService );

    FreeAndNil( ModelVendor );
    FreeAndNil( ModelVendorService );

  end;

end;

function TDMValidateVCTextFile.CalcCaseCost(Cost, CaseCost: Currency; CaseQty: Double; CostIsCaseCost: Boolean): Currency;
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

function TDMValidateVCTextFile.CalcCostUnitValue(Cost, CaseCost: Currency; Qty, CaseQty: Double; QtyType: String; CostIsCaseCost: Boolean): Currency;
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

procedure TDMValidateVCTextFile.FormatCost;
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

procedure TDMValidateVCTextFile.WarningDiferCost(OldCost : Currency);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;

  if TextFile.FieldByName('Warning').AsString <> '' then
    TextFile.FieldByName('Warning').AsString := TextFile.FieldByName('Warning').AsString + '; Old Cost: ' + SysCurrToStr(OldCost)
  else
    TextFile.FieldByName('Warning').AsString := 'Old Cost: ' + SysCurrToStr(OldCost);
end;

procedure TDMValidateVCTextFile.WarningPromoCost;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;

  if TextFile.FieldByName('Warning').AsString <> '' then
    TextFile.FieldByName('Warning').AsString := TextFile.FieldByName('Warning').AsString + '; Promo Cost'
  else
    TextFile.FieldByName('Warning').AsString := 'Promo Cost';
end;

function TDMValidateVCTextFile.ExistsModelName(Model : String): Boolean;
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

procedure TDMValidateVCTextFile.InvalidByModelName;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Model Exists';
end;

procedure TDMValidateVCTextFile.ValidByModelName;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := True;
  TextFile.FieldByName('Warning').AsString := '';
end;

procedure TDMValidateVCTextFile.InvalidByQty(AField : String);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Invalid Item ' + AField;
end;

procedure TDMValidateVCTextFile.ValidatePOItem;
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

function TDMValidateVCTextFile.GetIDVendor(Vendor: String): Integer;
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

function TDMValidateVCTextFile.FindModelWithBarcode( psBarCode : String ) : Integer;
var
  sSQL : String;
  iCheckBarcodeDigit, BarcodeOrder : Integer;
  SearchModel : Boolean;
begin

  Result := -1;

  psBarCode := Trim( psBarCode ) + StringOfChar( ' ', (20-Length( Trim( psBarCode )  ) ) );

  sSQL := ' SELECT M.IDModel, M.GroupID, M.IDModelGroup, M.IDModelSubGroup, M.CaseQty, '+
          ' M.SellingPrice, M.SuggRetail, M.VendorCost ' +
          ' FROM Barcode B JOIN Model M ON (M.IDModel = B.IDModel) ' +
          ' WHERE B.IDBarcode = '  + QuotedStr( psBarCode ) ;

  with DMGlobal.qryFreeSQL do begin

    try

      if Active then Close;

      Connection := SQLConnection;
      SQL.Text := sSQL;

      Open;


      if not IsEmpty then begin
        Result := DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsInteger;
       end;

    finally
      Close;
    end;

  end;

end;

function TDMValidateVCTextFile.GetMaxBarcodeOrder(IDModel: Integer): Integer;
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


function TDMValidateVCTextFile.FindModelWithVendorCode( piIdVendor : Integer; psVendorCode : String ) : Integer;
begin

  Result := -1;

  with DMGlobal.qryFreeSQL do
  begin

    try

      if Active then
        Close;

      Connection := SQLConnection;

      SQL.Text := 'SELECT M.IDModel, M.GroupID, M.IDModelGroup, M.IDModelSubGroup, V.VendorCode '+
                  'FROM VendorModelCode V JOIN Model M ON (M.IDModel = V.IDModel) ' +
                  ' WHERE IDPessoa = ' + IntToStr( piIdVendor ) +
                  ' AND VendorCode = ' + QuotedStr( psVendorCode );

      Open;

      if not IsEmpty then begin
        Result := DMGlobal.qryFreeSQL.FieldByName('IDMODEL').AsInteger;
      end;
    finally
      Close;
    end;

  end;

end;

procedure TDMValidateVCTextFile.ClosePoItemList;
begin
  with qryPoItemList do
   begin
     if Active then
       Close;
   end;
end;

function TDMValidateVCTextFile.NotExistsPurchaseNum(
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

procedure TDMValidateVCTextFile.CalcSaleValues(CostPrice:Currency);
var
  fNewSale,
  fNewMSRP : Currency;
  fMakrup : Double;
begin

  if IsClientServer then
  begin
    fNewSale := TextFile.FieldByName('OldSalePrice').AsCurrency;
    fNewMSRP := TextFile.FieldByName('NewMSRP').AsCurrency;
  end
  else
  begin

    fMakrup := GetModelMarkup(TextFile.FieldByName('IDModel').AsInteger);

    if fMakrup <> 0 then
    begin
      if bUseMarkupOnCost then
        fNewSale := FDMCalcPrice.GetMarkupPrice(CostPrice, fMakrup)
      else if (fMakrup < 100) then
        fNewSale := FDMCalcPrice.GetMarginPrice(CostPrice, fMakrup);

      fNewSale := FDMCalcPrice.CalcRounding(TextFile.FieldByName('IDGroup').AsInteger, fNewSale);

    end
    else
    begin
      fNewSale := FDMCalcPrice.CalcSalePrice(TextFile.FieldByName('IDModel').AsInteger,
                  TextFile.FieldByName('IDGroup').AsInteger,
                  TextFile.FieldByName('IDModelGroup').AsInteger,
                  TextFile.FieldByName('IDModelSubGroup').AsInteger,
                  CostPrice);

      fNewMSRP := FDMCalcPrice.CalcMSRPPrice(TextFile.FieldByName('IDGroup').AsInteger,
                  TextFile.FieldByName('IDModelGroup').AsInteger,
                  TextFile.FieldByName('IDModelSubGroup').AsInteger,
                  CostPrice);
    end;
  end;

  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;

  if (fNewSale <> CostPrice) and (fNewSale <> 0) then
    TextFile.FieldByName('NewSalePrice').AsCurrency := fNewSale
  else
    TextFile.FieldByName('NewSalePrice').AsCurrency := TextFile.FieldByName('OldSalePrice').AsCurrency;

  if (fNewMSRP <> CostPrice) and (fNewMSRP <> 0) then
    TextFile.FieldByName('NewMSRP').AsCurrency := fNewMSRP
  else
    TextFile.FieldByName('NewMSRP').AsCurrency;

end;

function TDMValidateVCTextFile.ValidateModels: Boolean;
begin
 
end;

procedure TDMValidateVCTextFile.SetDefaultValues;
begin
  TextFile.Edit;

  if (LinkedColumns.Values['VendorCode'] <> '') then
    TextFile.FieldByName('VendorModelCode').AsString := TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString;

  if (LinkedColumns.Values['MinQty'] <> '') then
    TextFile.FieldByName('MinQtyPO').AsFloat         := TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat;

  TextFile.Post;
end;

procedure TDMValidateVCTextFile.FilterSameBarcode;
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

function TDMValidateVCTextFile.GetValidModelCode: String;
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

function TDMValidateVCTextFile.ImportFromCatalog: Boolean;
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

procedure TDMValidateVCTextFile.ImportFromFile;
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

procedure TDMValidateVCTextFile.ImportFromMainRetail;
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

procedure TDMValidateVCTextFile.UpdateModelWithCatalog;
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

procedure TDMValidateVCTextFile.InvalidByBarcode;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString     := 'Invalid Barcode';
end;

procedure TDMValidateVCTextFile.InvalidByCostPrice(AField : String);
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString := 'Invalid Item ' + AField;
end;

function TDMValidateVCTextFile.ExistsPONum(PONum: String): Boolean;
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

procedure TDMValidateVCTextFile.InvalidByClientServer;
begin
  if not (TextFile.State = (dsEdit)) then
    TextFile.Edit;
  TextFile.FieldByName('Validation').AsBoolean := False;
  TextFile.FieldByName('Warning').AsString     := 'New items can not be created; Replication database.';
end;

function TDMValidateVCTextFile.GetModelMarkup(IDModel: Integer): Double;
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

function TDMValidateVCTextFile.ValidateItem: Boolean;
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

Function TDMValidateVCTextFile.LeaveOnlyNumbers( psText: String ) : String;
var
  I : Integer;
Begin

  Result := '';

  For I := 0 To Length( psText ) Do Begin

    If ( Pos( psText[I], '0123456789' ) > 0 ) Then Result := Result + psText[I];

  End;


End;

end.
