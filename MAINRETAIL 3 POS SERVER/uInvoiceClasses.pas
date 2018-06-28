unit uInvoiceClasses;

interface

uses SysUtils, Classes, ADODB, Variants;

type
  TInvoiceItemCommission = class
  private
    FSQLConnection: TADOConnection;
    FIDSaleItemCommission: Integer;
    FIDInventoryMov: Integer;
    FIDPreInventoryMov: Integer;
    FCommissionPercent: Double;
    FIDCommission: Integer;
  public
    constructor Create(ASQLConnection: TADOConnection);
    function CreateInvoiceItemCommission: Boolean;
    function CreateIDSaleItemCommission: Integer;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDSaleItemCommission: Integer read FIDSaleItemCommission write FIDSaleItemCommission;
    property IDPreInventoryMov: Integer read FIDPreInventoryMov write FIDPreInventoryMov;
    property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property IDCommission: Integer read FIDCommission write FIDCommission;
    property CommissionPercent: Double read FCommissionPercent write FCommissionPercent;
  end;

  TInvoiceItemSerial = class
  private
    FSQLConnection: TADOConnection;
    FIDInventoryMov: Integer;
    FSerialNumber: String;
    FIdentificationNumber: String;
    FIDModel: Integer;
    FIDStore: Integer;
    FGiftTotal: Currency;
    FGiftIDUser: Integer;
    FIDPreSale: Integer;
    FGiftCupom: String;
    function CreateIDAccountCard: Integer;
  public
    constructor Create(ASQLConnection: TADOConnection);
    function CreateInvoiceItemSerial: Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property SerialNumber: String read FSerialNumber write FSerialNumber;
    property IdentificationNumber: String read FIdentificationNumber write FIdentificationNumber;
    property IDModel : Integer read FIDModel write FIDModel;
    property IDStore : Integer read FIDStore write FIDStore;
    property IDPreSale : Integer read FIDPreSale write FIDPreSale;
    property GiftTotal : Currency read FGiftTotal write FGiftTotal;
    property GiftIDUser : Integer read FGiftIDUser write FGiftIDUser;
    property GiftCupom : String read FGiftCupom write FGiftCupom;
  end;

  TInvoiceItemPrice = class
  private
    FSQLConnection: TADOConnection;
    FIDMovPrice: Integer;
    FIDInventoryMov: Integer;
    FIDDescriptionPrice: Integer;
    FIDVendorPrice: Integer;
    FSuggPrice: Currency;
  public
    constructor Create(ASQLConnection: TADOConnection);
    function CreateInvoiceItemPrice: Boolean;
    function CreateIDMovPrice: Integer;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDMovPrice: Integer read FIDMovPrice write FIDMovPrice;
    property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property IDDescriptionPrice: Integer read FIDDescriptionPrice write FIDDescriptionPrice;
    property IDVendorPrice: Integer read FIDVendorPrice write FIDVendorPrice;
    property SuggPrice: Currency read FSuggPrice write FSuggPrice;
  end;

  TInvoiceItemDocument = class
  private
    FSQLConnection: TADOConnection;
    FIDMovDocument: Integer;
    FIDInventoryMov: Integer;
    FDocumentNumber: String;
    FIDDocumentType: Integer;
    FDocumentDate: TDateTime;
  public
    constructor Create(ASQLConnection: TADOConnection);
    function CreateInvoiceItemDocument: Boolean;
    function CreateIDMovDocument: Integer;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDMovDocument: Integer read FIDMovDocument write FIDMovDocument;
    property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property DocumentNumber: String read FDocumentNumber write FDocumentNumber;
    property IDDocumentType: Integer read FIDDocumentType write FIDDocumentType;
		property DocumentDate: TDateTime read FDocumentDate write FDocumentDate;
  end;

  TInvoiceItem = class
  private
    FCommssionList: TList;
    FSerialNumberList: TList;
    FSQLConnection: TADOConnection;
    FIsPromo: Boolean;
    FCostPrice: Currency;
    FSalePrice: Currency;
    FDiscount: Currency;
    FQty: Double;
    FIDComission: Integer;
    FIDCustomer: Integer;
    FIDModel: Integer;
    FIDDepartment: Integer;
    FIDPreSale: Integer;
    FIDPreInvMovExchange: Integer;
    FIDUser: Integer;
    FIDInventoryMov: Integer;
    FIDStore: Integer;
    FMovDate: TDateTime;
    FIDInvoice: Integer;
    FAvgCost: Currency;
    FDesiredMarkup: Double;
    FIDParentPack: Integer;
    FInvoiceCode: String;
    FItemDocument: TInvoiceItemDocument;
    FItemPrice: TInvoiceItemPrice;
    FSaleCode: String;
    FTotParcial: String;
    FItemIndex: Integer;
    FAcrescimo: Currency;
    FIDCashRegister: Integer;

    procedure SetValues;
    function CreateIDInventoryMov: Integer;
    function CreateTaxes: Boolean;
    function CreatePricePayment: Boolean;
    function GetAutoGeneratePrice: Boolean;
    function CreateIDLancamento: Integer;
  public
    constructor Create(ASQLConnection: TADOConnection);
    destructor Destroy; override;

    function CreateInvoiceItem: Boolean; virtual;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property CommssionList: TList read FCommssionList write FCommssionList;
    property SerialNumberList: TList read FSerialNumberList write FSerialNumberList;
		property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDInvoice: Integer read FIDInvoice write FIDInvoice;
    property InvoiceCode: String read FInvoiceCode write FInvoiceCode;
		property IDCustomer: Integer read FIDCustomer write FIDCustomer;
		property IDStore: Integer read FIDStore write FIDStore;
		property IDUser: Integer read FIDUser write FIDUser;
		property IDModel: Integer read FIDModel write FIDModel;
		property IDCashRegister: Integer read FIDCashRegister write FIDCashRegister;
		property IDComission: Integer read FIDComission write FIDComission;
		property Qty: Double read FQty write FQty;
 		property SalePrice: Currency read FSalePrice write FSalePrice;
		property CostPrice: Currency read FCostPrice write FCostPrice;
		property Discount: Currency read FDiscount write FDiscount;
		property Acrescimo: Currency read FAcrescimo write FAcrescimo;
		property MovDate: TDateTime read FMovDate write FMovDate;
		property IDPreInvMovExchange: Integer read FIDPreInvMovExchange write FIDPreInvMovExchange;
		property IDDepartment: Integer read FIDDepartment write FIDDepartment;
		property IsPromo: Boolean read FIsPromo write FIsPromo;
		property IDParentPack: Integer read FIDParentPack write FIDParentPack;
		property AvgCost: Currency read FAvgCost write FAvgCost;
		property DesiredMarkup: Double read FDesiredMarkup write FDesiredMarkup;
    property SaleCode: String read FSaleCode write FSaleCode;
    property ItemDocument: TInvoiceItemDocument read FItemDocument write FItemDocument;
    property ItemPrice: TInvoiceItemPrice read FItemPrice write FItemPrice;
    property TotParcial: String read FTotParcial write FTotParcial;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
  end;

  TInvoiceRemovedItem = class(TInvoiceItem)
  private
    function CreateIDRemovedItem: Integer;
  public
    function CreateInvoiceItem: Boolean; override;
  end;

  TInvoicePayment = class
  private
    FSQLConnection: TADOConnection;
    FIsPredatado: Boolean;
    FPaymentValue: Currency;
    FIDStore: Integer;
    FIDUser: Integer;
    FIDCustomer: Integer;
    FIDMeioPag: Integer;
    FIDCashRegMov: Integer;
    FIDBankCheck: Integer;
    FIDPreSale: Integer;
    FPaymentPlace: Integer;
    FCustomerPhone: String;
    FParcela: String;
    FAuthorization: String;
    FOBS: String;
    FCustomerName: String;
    FCheckNumber: String;
    FCustomerDocument: String;
    FPreSaleDate: TDateTime;
    FExpirationDate: TDateTime;
    FIDInvoice: Integer;
  public
    constructor Create(ASQLConnection: TADOConnection);

    function CreateInvoicePayment: Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDInvoice: Integer read FIDInvoice write FIDInvoice;
    property IDStore: Integer read FIDStore write FIDStore;
    property IDUser: Integer read FIDUser write FIDUser;
    property IDCustomer: Integer read FIDCustomer write FIDCustomer;
    property IDMeioPag: Integer read FIDMeioPag write FIDMeioPag;
    property IDCashRegMov: Integer read FIDCashRegMov write FIDCashRegMov;
    property PreSaleDate: TDateTime read FPreSaleDate write FPreSaleDate;
    property ExpirationDate: TDateTime read FExpirationDate write FExpirationDate;
    property Parcela: String read FParcela write FParcela;
    property Authorization: String read FAuthorization write FAuthorization;
    property PaymentValue: Currency read FPaymentValue write FPaymentValue;
    property CheckNumber: String read FCheckNumber write FCheckNumber;
    property CustomerDocument: String read FCustomerDocument write FCustomerDocument;
    property CustomerName: String read FCustomerName write FCustomerName;
    property CustomerPhone: String read FCustomerPhone write FCustomerPhone;
    property IDBankCheck: Integer read FIDBankCheck write FIDBankCheck;
    property OBS: String read FOBS write FOBS;
    property PaymentPlace: Integer read FPaymentPlace write FPaymentPlace;
    property IsPredatado: Boolean read FIsPredatado write FIsPredatado;
  end;

  TInvoice = class
  private
    FItemList: TList;
    FRemovedItemList: TList;
    FPaymentList: TList;
    FSQLConnection: TADOConnection;
    FIDPreSale: Integer;
    FPrintNotes: Boolean;
    FIsLayaway: Boolean;
    FIDStore: Integer;
    FIDTouristGroup: Integer;
    FIDCustomer: Integer;
    FIDMedia: Integer;
    FIDDeliverType: Integer;
    FIDOtherComission: Integer;
    FFirstName: String;
    FZip: String;
    FLastName: String;
    FNote: String;
    FPreSaleDate: TDateTime;
    FPuppyTracker: Boolean;
    FIDPreSaleParent: Integer;
    FSaleCode: String;
    FCOO: String;
    FECFSerial: String;
    FTaxExempt: Boolean;
    FIDInvoice: Integer;
    FInvoiceDate: TDateTime;
    FCupomFiscal: String;
    FInvoiceCode: String;
    FCashReceived: Currency;
    FIDCashRegMov: Integer;
    FSubTotal: Currency;
    FItemDiscount: Currency;
    FInvoiceDiscount: Currency;
    FScaleAdjust: Currency;
    FCPFCGC: String;

    procedure SetTotalValues;
    procedure SetIDParentPack(APackIndex: Integer);
    function ValidadePayment: Boolean;
    function GetNewID(ATabela: String): Integer;
    function GetNewInvoiceCode: String;
    function AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
    function TruncarDecimal(Valor: Real; Decimal: integer): Double;
  public
    constructor Create(ASQLConnection: TADOConnection);
    destructor Destroy; override;

    function CreateInvoice: Boolean;
    function AddInvoiceItem(AInvoiceItem: TInvoiceItem): Boolean;
    function AddInvoiceRemovedItem(AInvoiceRemovedItem: TInvoiceRemovedItem): Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property ItemList: TList read FItemList write FItemList;
    property RemovedItemList: TList read FRemovedItemList write FRemovedItemList;
    property PaymentList: TList read FPaymentList write FPaymentList;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDPreSaleParent: Integer read FIDPreSaleParent write FIDPreSaleParent;
    property PreSaleDate: TDateTime read FPreSaleDate write FPreSaleDate;
    property IDInvoice: Integer read FIDInvoice write FIDInvoice;
    property InvoiceDate: TDateTime read FInvoiceDate write FInvoiceDate;
    property IDCustomer: Integer read FIDCustomer write FIDCustomer;
    property IDTouristGroup: Integer read FIDTouristGroup write FIDTouristGroup;
    property IDMedia: Integer read FIDMedia write FIDMedia;
    property IDDeliverType: Integer read FIDDeliverType write FIDDeliverType;
    property IDOtherComission: Integer read FIDOtherComission write FIDOtherComission;
    property FirstName: String read FFirstName write FFirstName;
    property LastName: String read FLastName write FLastName;
    property IsLayaway: Boolean read FIsLayaway write FIsLayaway;
    property IDStore: Integer read FIDStore write FIDStore;
    property Zip: String read FZip write FZip;
    property Note: String read FNote write FNote;
    property PrintNotes: Boolean read FPrintNotes write FPrintNotes;
    property SaleCode: String read FSaleCode write FSaleCode;
    property InvoiceCode: String read FInvoiceCode write FInvoiceCode;
    property CupomFiscal: String read FCupomFiscal write FCupomFiscal;
    property COO: String read FCOO write FCOO;
    property PuppyTracker: Boolean read FPuppyTracker write FPuppyTracker;
    property ECFSerial: String read FECFSerial write FECFSerial;
    property TaxExempt: Boolean read FTaxExempt write FTaxExempt;
    property CashReceived: Currency read FCashReceived write FCashReceived;
    property IDCashRegMov: Integer read FIDCashRegMov write FIDCashRegMov;
    property InvoiceDiscount: Currency read FInvoiceDiscount write FInvoiceDiscount;
    property ItemDiscount: Currency read FItemDiscount write FItemDiscount;
    property SubTotal: Currency read FSubTotal write FSubTotal;
    property CPFCGC: String read FCPFCGC write FCPFCGC;
  end;

implementation

uses DB, Math, uNumericFunctions;

{ TInvoiceItemCommission }

constructor TInvoiceItemCommission.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoiceItemCommission.CreateIDSaleItemCommission: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'SaleItemCommission.IDSaleItemCommission';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceItemCommission.CreateInvoiceItemCommission: Boolean;
begin
  Result := False;

  FIDSaleItemCommission := CreateIDSaleItemCommission;
  if FIDSaleItemCommission = -1 then
    raise Exception.Create('Erro ao gerar IDSaleItemCommission.');

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT INTO SaleItemCommission (IDSaleItemCommission, IDInventoryMov, IDCommission, CommissionPercent) ' +
	                 'VALUES (:IDSaleItemCommission, :IDInventoryMov, :IDComission, :CommissionPercent)';
    Parameters.ParamByName('IDSaleItemCommission').Value := FIDSaleItemCommission;
    Parameters.ParamByName('IDInventoryMov').Value       := FIDInventoryMov;
    Parameters.ParamByName('IDComission').Value          := FIDCommission;
    Parameters.ParamByName('CommissionPercent').Value    := FCommissionPercent;

    Execute;
    Result := True;
  finally
    Free;
  end;
end;

{ TInvoice }

constructor TInvoice.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection   := ASQLConnection;
  FItemList        := TList.Create;
  FPaymentList     := TList.Create;
  FRemovedItemList := TList.Create;
end;

function TInvoice.GetNewID(ATabela: String): Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := ATabela;
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoice.CreateInvoice: Boolean;
var
  i: Integer;
begin
  Result := False;

  FIDPreSale := GetNewID('Invoice.IDPresale');
  if FIDPreSale = -1 then
    raise Exception.Create('Erro ao gerar IDPreSale.');

  FIDInvoice := GetNewID('InvoiceGen.IDInvoice');
  if FIDInvoice = -1 then
    raise Exception.Create('Erro ao gerar IDInvoice.');

  if FInvoiceCode = '' then
    FInvoiceCode := GetNewInvoiceCode;
    if FInvoiceCode = '-1' then
      raise Exception.Create('Erro ao gerar InvoiceCode.');

  SetTotalValues;
  if not ValidadePayment then
    raise Exception.Create('Valor da nota é diferente do total de pagamentos.');

  if (FCOO = '') or (FCOO = 'XXXXXX') then
  begin
    FCupomFiscal := '';
    FECFSerial := '';
  end
  else
  begin
    FSaleCode := FCOO;
    FCupomFiscal := FCOO;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT INTO Invoice (IDPreSale, IDInvoice, IDCustomer, IDTouristGroup, PreSaleDate, CupomFiscal, Tax, ItemDiscount, ' +
                   'InvoiceDate, MediaID, DeliverTypeID, OtherComissionID, FirstName, LastName, TaxIsent, CashReceived, CashRegMovID, ' +
                   'Layaway, IDStore, Zip, Note, PrintNotes, PuppyTracker, SaleCode, NumeroSeriePrinter, InvoiceCode, SubTotal, InvoiceDiscount) ' +
                   'VALUES (:IDPreSale, :IDInvoice, :IDCustomer, :IDTouristGroup, :PreSaleDate, :CupomFiscal, :Tax, :ItemDiscount, ' +
                   ':InvoiceDate, :MediaID, :DeliverTypeID, :IDOtherCommission, :FirstName, :LastName, :TaxIsent, :CashReceived, :CashRegMovID, ' +
                   ':Layaway, :IDStore, :Zip, :Note, :PrintNotes, :PuppyTracker, :SaleCode, :NumeroSeriePrinter, :InvoiceCode, :SubTotal, :InvoiceDiscount)';
    Parameters.ParambyName('IDPreSale').Value          := FIDPreSale;
    Parameters.ParambyName('PreSaleDate').Value        := FPreSaleDate;
    Parameters.ParambyName('IDInvoice').Value          := FIDInvoice;
    Parameters.ParambyName('InvoiceDate').Value        := FInvoiceDate;
    Parameters.ParambyName('DeliverTypeID').Value      := FIDDeliverType;
    Parameters.ParambyName('Layaway').Value            := FIsLayaway;
    Parameters.ParambyName('IDStore').Value            := FIDStore;
    Parameters.ParambyName('FirstName').Value          := Copy(FFirstName, 1, 20);
    Parameters.ParambyName('LastName').Value           := Copy(FLastName, 1, 20);
    Parameters.ParambyName('ZIP').Value                := FZip;
    Parameters.ParambyName('IDCustomer').Value         := FIDCustomer;
    Parameters.ParambyName('MediaID').Value            := FIDMedia;
    Parameters.ParambyName('SaleCode').Value           := FSaleCode;
    Parameters.ParambyName('InvoiceCode').Value        := FInvoiceCode;
    Parameters.ParambyName('PuppyTracker').Value       := FPuppyTracker;
    Parameters.ParambyName('Tax').Value                := 0;
    Parameters.ParambyName('TaxIsent').Value           := FTaxExempt;
    Parameters.ParambyName('CashReceived').Value       := FCashReceived;
		Parameters.ParambyName('CashRegMovID').Value       := FIDCashRegMov;
    Parameters.ParambyName('SubTotal').Value           := FSubTotal;
    Parameters.ParambyName('ItemDiscount').Value       := FItemDiscount;
    Parameters.ParambyName('InvoiceDiscount').Value    := FInvoiceDiscount;

    if FCupomFiscal = '' then
      Parameters.ParambyName('CupomFiscal').Value := NULL
    else
      Parameters.ParambyName('CupomFiscal').Value := FCupomFiscal;

    if FECFSerial = '' then
      Parameters.ParambyName('NumeroSeriePrinter').Value := NULL
    else
      Parameters.ParambyName('NumeroSeriePrinter').Value := FECFSerial;

    if FIDOtherComission = 0 then
      Parameters.ParambyName('IDOtherCommission').Value := Null
    else
      Parameters.ParambyName('IDOtherCommission').Value := FIDOtherComission;

    if FIDTouristGroup = 0 then
      Parameters.ParambyName('IDTouristGroup').Value := Null
    else
      Parameters.ParambyName('IDTouristGroup').Value := FIDTouristGroup;

    if FNote = '' then
    begin
      Parameters.ParambyName('Note').Value       := Null;
      Parameters.ParambyName('PrintNotes').Value := False;
    end
    else
    begin
      Parameters.ParambyName('Note').Value       := FNote;
      Parameters.ParambyName('PrintNotes').Value := True;
    end;
    Execute;
  finally
    Free;
  end;

  for i := 0 to Pred(FItemList.Count) do
  begin
    TInvoiceItem(FItemList[i]).IDPreSale   := FIDPreSale;
    TInvoiceItem(FItemList[i]).IDInvoice   := FIDInvoice;
    TInvoiceItem(FItemList[i]).InvoiceCode := FInvoiceCode;
    TInvoiceItem(FItemList[i]).SaleCode    := FSaleCode;
    TInvoiceItem(FItemList[i]).IDCustomer  := FIDCustomer;
    if not TInvoiceItem(FItemList[i]).CreateInvoiceItem then
    begin
      Result := False;
      Exit;
    end;

    SetIDParentPack(i);
  end;

  for i := 0 to Pred(FRemovedItemList.Count) do
  begin
    TInvoiceRemovedItem(FRemovedItemList[i]).IDPreSale   := FIDPreSale;
    TInvoiceRemovedItem(FRemovedItemList[i]).IDInvoice   := FIDInvoice;
    TInvoiceRemovedItem(FRemovedItemList[i]).InvoiceCode := FInvoiceCode;
    TInvoiceRemovedItem(FRemovedItemList[i]).SaleCode    := FSaleCode;
    TInvoiceRemovedItem(FRemovedItemList[i]).IDCustomer  := FIDCustomer;
    if not TInvoiceRemovedItem(FRemovedItemList[i]).CreateInvoiceItem then
    begin
      Result := False;
      Exit;
    end;
  end;

  for i := 0 to Pred(FPaymentList.Count) do
  begin
    TInvoicePayment(FPaymentList[i]).IDPreSale  := FIDPreSale;
    TInvoicePayment(FPaymentList[i]).IDInvoice  := FIDInvoice;
    TInvoicePayment(FPaymentList[i]).IDCustomer := FIDCustomer;
    if not TInvoicePayment(FPaymentList[i]).CreateInvoicePayment then
    begin
      Result := False;
      Exit;
    end;
  end;

  Result := True;
end;

destructor TInvoice.Destroy;
begin
  FreeAndNil(FItemList);
  FreeAndNil(FPaymentList);
  FreeAndNil(FRemovedItemList);
  inherited;
end;

function TInvoice.GetNewInvoiceCode: String;
begin
  Result := '-1';

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'SP_PreSale_GetNewInvoiceCode';
    Parameters.Refresh;
    Parameters.ParamByName('@IDStore').Value := FIDStore;
    Parameters.ParamByName('@InvoiceCode').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@InvoiceCode').Value;
  finally
    Free;
  end;
end;

procedure TInvoice.SetTotalValues;
var
  i: Integer;
  fPrice : Real;
begin
  FItemDiscount := 0;
  FSubTotal     := 0;
  FScaleAdjust  := 0;

  for i := 0 to Pred(FItemList.Count) do
  begin
    FItemDiscount := FItemDiscount + TInvoiceItem(FItemList[i]).Discount;
    fPrice := AjustaPreco(TInvoiceItem(FItemList[i]).Qty, (TInvoiceItem(FItemList[i]).SalePrice * TInvoiceItem(FItemList[i]).Qty), TInvoiceItem(FItemList[i]).SalePrice);
    FSubTotal := FSubTotal + fPrice;
    if fPrice > 0 then
      FScaleAdjust := FScaleAdjust + fPrice - (TruncMoney(TInvoiceItem(FItemList[i]).SalePrice * TInvoiceItem(FItemList[i]).Qty, 2));
  end;
end;

function TInvoice.ValidadePayment: Boolean;
var
  i: Integer;
  dTotalPayment: Currency;
begin
  dTotalPayment := 0;

  for i := 0 to Pred(FPaymentList.Count) do
    dTotalPayment := dTotalPayment + TInvoicePayment(FPaymentList[i]).PaymentValue;

  if (FInvoiceDiscount <> 0) and (FScaleAdjust <> 0) then
    FInvoiceDiscount := (FInvoiceDiscount - ABS(FScaleAdjust));

  Result := (FSubTotal - FInvoiceDiscount - FItemDiscount) = dTotalPayment;

  //Bacalhau para resolver proplemas de centavos das vendas granel
  if not Result then
    if ABS((FSubTotal - FInvoiceDiscount - FItemDiscount) - dTotalPayment) = 0.01 then
      Result := True;

end;

function TInvoice.AddInvoiceItem(AInvoiceItem: TInvoiceItem): Boolean;
var
  iPackIndex: Integer;
  InvoiceItemPack: TInvoiceItem;
  InvoiceItemPackCommission: TInvoiceItemCommission;
begin
  iPackIndex := FItemList.Add(AInvoiceItem);

  with TADODataSet.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'SELECT M.IDModel, P.Qty, M.FinalCost ' +
                   'FROM dbo.PackModel P JOIN dbo.Model M ON (P.IDModel= M.IDModel) ' +
 	                 'WHERE P.IDPackModel = :IDModel';
    Parameters.ParamByName('IDModel').Value := AInvoiceItem.IDModel;
    Open;

    while not Eof do
    begin
      InvoiceItemPack := TInvoiceItem.Create(FSQLConnection);
      InvoiceItemPackCommission := TInvoiceItemCommission.Create(FSQLConnection);

      InvoiceItemPack.IDCustomer   := AInvoiceItem.IDCustomer;
      InvoiceItemPack.IDPreSale    := AInvoiceItem.IDPreSale;
      InvoiceItemPack.IDModel      := FieldByName('IDModel').AsInteger;
      InvoiceItemPack.IDStore      := AInvoiceItem.IDStore;
      InvoiceItemPack.Qty          := AInvoiceItem.Qty * FieldByName('Qty').AsFloat;
      InvoiceItemPack.Discount     := 0;
      InvoiceItemPack.SalePrice    := 0;
      InvoiceItemPack.CostPrice    := FieldByName('FinalCost').AsCurrency;
      InvoiceItemPack.IDUser       := AInvoiceItem.IDUser;
      InvoiceItemPack.IDComission  := AInvoiceItem.IDComission;
      InvoiceItemPack.MovDate      := AInvoiceItem.MovDate;
      InvoiceItemPack.IsPromo      := AInvoiceItem.IsPromo;
      InvoiceItemPack.IDDepartment := AInvoiceItem.IDDepartment;
      InvoiceItemPack.IDParentPack := iPackIndex+1;

      InvoiceItemPackCommission.IDCommission      := AInvoiceItem.IDComission;
      InvoiceItemPackCommission.CommissionPercent := 100;

      InvoiceItemPack.CommssionList.Add(InvoiceItemPackCommission);
      FItemList.Add(InvoiceItemPack);

      Next;
    end;

    Close;
  finally
    Free;
  end;
end;

procedure TInvoice.SetIDParentPack(APackIndex: Integer);
var
  i: Integer;
begin
  for i := 0 to Pred(FItemList.Count) do
    if TInvoiceItem(FItemList[i]).IDParentPack = (APackIndex+1) then
      TInvoiceItem(FItemList[i]).IDParentPack := TInvoiceItem(FItemList[APackIndex]).IDInventoryMov;
end;

function TInvoice.AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
var
  PrecoECF, QtdeECF: real;
  sQTD: String;
begin
  sQTD := FormatFloat('0000.000', Qtde);

  if Qtde > 0 then
  begin
    QtdeECF := TruncarDecimal(StrToFloat(sQTD), 3);
    Qtde := TruncarDecimal(Qtde, 3);
  end
  else
    QtdeECF := Qtde;

  if QtdeECF <> Qtde then
    PrecoECF := QtdeECF * PrecoUnit
  else
    PrecoECF := Qtde * PrecoUnit;

  if Qtde > 0 then
    PrecoECF := TruncarDecimal(PrecoECF, 2)
  else
  begin
    PrecoECF := PrecoECF * -1;
    PrecoECF := TruncarDecimal(PrecoECF, 2);
    PrecoECF := PrecoECF * -1;
  end;

  if PrecoBalanca <> PrecoECF then
    Result := PrecoECF
    else
    Result := PrecoBalanca;
end;

function TInvoice.TruncarDecimal(Valor: Real; Decimal: integer): Double;
var
  aux: string;
begin

  valor := valor * 100000;
  aux := FormatFloat('00000000000000000000',valor);
  aux := copy( aux, 1, 15) + copy( aux, 16, Decimal);
  case Decimal of
    2: valor := strToFloat(aux) / 100;
    3: valor := strToFloat(aux) / 1000;
    4: valor := strToFloat(aux) / 10000;
    5: valor := strToFloat(aux) / 100000;
  end;

  result := Valor;

end;

function TInvoice.AddInvoiceRemovedItem(
  AInvoiceRemovedItem: TInvoiceRemovedItem): Boolean;
begin
  FRemovedItemList.Add(AInvoiceRemovedItem);
end;

{ TInvoiceItem }

constructor TInvoiceItem.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection    := ASQLConnection;
  FCommssionList    := TList.Create;
  FSerialNumberList := TList.Create;
end;

function TInvoiceItem.CreateIDInventoryMov: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'InventoryMov.IDInventoryMov';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceItem.CreateIDLancamento: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Fin_Lancamento.IDLancamento';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceItem.CreateInvoiceItem: Boolean;
var
  i: Integer;
begin
  Result := False;

  FIDInventoryMov := CreateIDInventoryMov;
  if FIDInventoryMov = -1 then
    raise Exception.Create('Erro ao gerar IDInventoryMov.');

  SetValues;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID, ' +
                   'IDPessoa, StoreID, ModelID, BarCodeID, MovDate, Qty, CostPrice, SalePrice, ' +
                   'Discount, IDUser, SalesTax, IDParentPack, QtyExchanged, ' +
                   'IDPreInvMovExchange, AvgCost, DesiredMarkup, IDDepartment, Promo, SequencyNum) ' +
                   'VALUES (:IDInventoryMov, :InventMovTypeID, :DocumentID, :IDPessoa, :StoreID, ' +
                   ':ModelID, :BarCodeID, :MovDate, :Qty, :CostPrice, :SalePrice, :Discount, ' +
                   ':IDUser, :SalesTax, :IDParentPack, :QtyExchanged, ' +
                   ':IDPreInvMovExchange, :AvgCost, :DesiredMarkup, :IDDepartment, :Promo, :SequencyNum)';

    Parameters.ParamByName('IDInventoryMov').Value  := FIDInventoryMov;
    Parameters.ParamByName('InventMovTypeID').Value := 1;
    Parameters.ParamByName('DocumentID').Value      := FIDInvoice;
    Parameters.ParamByName('IDPessoa').Value        := FIDCustomer;
    Parameters.ParamByName('StoreID').Value         := FIDStore;
    Parameters.ParamByName('ModelID').Value         := FIDModel;
    Parameters.ParamByName('MovDate').Value         := FMovDate;
    Parameters.ParamByName('Qty').Value             := FQty;
    Parameters.ParamByName('CostPrice').Value       := FCostPrice;
    Parameters.ParamByName('SalePrice').Value       := FSalePrice;
    Parameters.ParamByName('Discount').Value        := FDiscount;
    Parameters.ParamByName('IDUser').Value          := FIDUser;
    Parameters.ParamByName('IDDepartment').Value    := FIDDepartment;
    Parameters.ParamByName('Promo').Value           := FIsPromo;
    Parameters.ParamByName('DesiredMarkup').Value   := FDesiredMarkup;
    Parameters.ParamByName('AvgCost').Value         := FAvgCost;
    Parameters.ParamByName('SequencyNum').Value     := FItemIndex;

    if FIDParentPack = 0 then
      Parameters.ParamByName('IDParentPack').Value := NULL
    else
      Parameters.ParamByName('IDParentPack').Value := FIDParentPack;

    Execute;
  finally
    Free;
  end;

  if FTotParcial <> '' then
  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT Inv_MovComplement (IDInventoryMov, TotalizadorParcial, IDMovReason) ' +
                   'VALUES (:IDInventoryMov, :TotalizadorParcial, 1)';
    Parameters.ParamByName('IDInventoryMov').Value     := FIDInventoryMov;
    Parameters.ParamByName('TotalizadorParcial').Value := FTotParcial;
    Execute;
  finally
    Free;
  end;

  for i := 0 to Pred(FCommssionList.Count) do
  begin
    TInvoiceItemCommission(FCommssionList[i]).IDInventoryMov := FIDInventoryMov;
    if not TInvoiceItemCommission(FCommssionList[i]).CreateInvoiceItemCommission then
    begin
      Result := False;
      Exit;
    end;
  end;

  for i := 0 to Pred(FSerialNumberList.Count) do
  begin
    TInvoiceItemSerial(FSerialNumberList[i]).IDInventoryMov := FIDInventoryMov;
    TInvoiceItemSerial(FSerialNumberList[i]).IDPreSale      := FIDPreSale;
    TInvoiceItemSerial(FSerialNumberList[i]).GiftCupom      := FSaleCode;

    if not TInvoiceItemSerial(FSerialNumberList[i]).CreateInvoiceItemSerial then
    begin
      Result := False;
      Exit;
    end;
  end;

  if Assigned(FItemPrice) then
    if FItemPrice.IDDescriptionPrice <> 0 then
    begin
      FItemPrice.IDInventoryMov := FIDInventoryMov;
      if not FItemPrice.CreateInvoiceItemPrice then
      begin
        Result := False;
        Exit;
      end;

      if GetAutoGeneratePrice and ((FItemPrice.SuggPrice - FSalePrice) > 0) then
        if not CreatePricePayment then
          raise Exception.Create('Erro ao gerar contas a receber de PRICE.');
    end;

  if Assigned(FItemDocument) then
    if FItemDocument.DocumentNumber <> '' then
    begin
      FItemDocument.IDInventoryMov := FIDInventoryMov;
      FItemDocument.DocumentDate := FMovDate;      
      if not FItemDocument.CreateInvoiceItemDocument then
      begin
        Result := False;
        Exit;
      end;
    end;

  if not CreateTaxes then
    raise Exception.Create('Erro ao gerar encargos e impostos.');

  Result := True;
end;

function TInvoiceItem.CreatePricePayment: Boolean;
var
  iIDMovPrice,
  iIDLancamentoTipo,
  iIDDocumentoTipo,
  iIDPagamentoTipo,
  iDiasVencimento,
  iIDVendorType,
  iIDCentroCusto,
  iIDContaCorrente,
  iIDEmpresa,
  iIDLancamento: Integer;
begin
  with TADODataSet.Create(nil) do
    try
      Connection := FSQLConnection;

      CommandText := 'SELECT CAST(PropertyValue AS INT) IDLancamentoTipo FROM Sis_PropertyDomain WHERE Property = ' + QuotedStr('PriceRecordType');
      Open;
      iIDLancamentoTipo := FieldByName('IDLancamentoTipo').AsInteger;

      Close;
      CommandText := 'SELECT CAST(PropertyValue AS INT) IDDocumentoTipo FROM Sis_PropertyDomain WHERE Property = ' + QuotedStr('PriceDocumentType');
      Open;
      iIDDocumentoTipo := FieldByName('IDDocumentoTipo').AsInteger;

      Close;
      CommandText := 'SELECT CAST(PropertyValue AS INT) IDPagamentoTipo FROM Sis_PropertyDomain WHERE Property = ' + QuotedStr('PricePaymentType');
      Open;
      iIDPagamentoTipo := FieldByName('IDPagamentoTipo').AsInteger;

      Close;
      CommandText := 'SELECT CAST(PropertyValue AS INT) DiasVencimento FROM Sis_PropertyDomain WHERE Property = ' + QuotedStr('PriceDueDateDays');
      Open;
      iDiasVencimento := FieldByName('DiasVencimento').AsInteger;

      Close;
      CommandText := 'SELECT IDTipoPessoaRoot FROM Pessoa WHERE IDPessoa = ' + IntToStr(FItemPrice.FIDVendorPrice);
      Open;
      iIDVendorType := FieldByName('IDTipoPessoaRoot').AsInteger;

      Close;
      CommandText := 'SELECT S.IDCentroCusto, MPS.IDContaCorrente, S.IDEmpresa ' +
                               'FROM Store S JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore) ' +
                               'WHERE S.IDStore = ' + IntToStr(FIDStore) + ' AND MPS.IDMeioPag = ' + IntToStr(iIDPagamentoTipo);
      Open;
      iIDCentroCusto := FieldByName('IDCentroCusto').AsInteger;
      iIDContaCorrente := FieldByName('IDContaCorrente').AsInteger;
      iIDEmpresa := FieldByName('IDEmpresa').AsInteger;

      Close;
    finally
      Free;
    end;

  iIDLancamento := CreateIDLancamento;
  if iIDLancamento = -1 then
    raise Exception.Create('Erro ao gerar IDLancamento.');

  with TADOCommand.Create(nil) do
    try
      Connection := FSQLConnection;
      CommandText := 'INSERT INTO Fin_Lancamento (IDLancamento, IDPessoa, IDPessoaTipo, IDUsuarioLancamento, IDEmpresa, ' +
                               'DataLancamento, DataVencimento, ValorNominal, Pagando, NumDocumento, IDCentroCusto, ' +
                               'IDContaCorrentePrevista, IDQuitacaoMeioPrevisto, IDLancamentoTipo, IDDocumentoTipo, Situacao) ' +
                               'VALUES (:IDLancamento, :IDVendorPrice, :IDVendorType, :IDUser, :IDEmpresa, :MovDate, ' +
                               'DATEADD(DAY, :DiasVencimento, :MovDate2), :ValorNominal, 0, :InvoiceCode, ' +
                               ':IDCentroCusto, :IDContaCorrente, :IDPagamentoTipo, :IDLancamentoTipo, :IDDocumentoTipo, 1)';

      Parameters.ParamByName('IDLancamento').Value     := iIDLancamento;
      Parameters.ParamByName('IDVendorPrice').Value    := FItemPrice.FIDVendorPrice;
      Parameters.ParamByName('IDVendorType').Value     := iIDVendorType;
      Parameters.ParamByName('IDUser').Value           := FIDUser;
      Parameters.ParamByName('IDEmpresa').Value        := iIDEmpresa;
      Parameters.ParamByName('MovDate').Value          := FMovDate;
      Parameters.ParamByName('DiasVencimento').Value   := iDiasVencimento;
      Parameters.ParamByName('MovDate2').Value         := FMovDate;
      Parameters.ParamByName('ValorNominal').Value     := FItemPrice.FSuggPrice - FSalePrice;
      Parameters.ParamByName('InvoiceCode').Value      := FInvoiceCode;
      Parameters.ParamByName('IDCentroCusto').Value    := iIDCentroCusto;
      Parameters.ParamByName('IDContaCorrente').Value  := iIDContaCorrente;
      Parameters.ParamByName('IDPagamentoTipo').Value  := iIDPagamentoTipo;
      Parameters.ParamByName('IDLancamentoTipo').Value := iIDLancamentoTipo;
      Parameters.ParamByName('IDDocumentoTipo').Value  := iIDDocumentoTipo;
      Execute;
    finally
      Free;
    end;

  Result := True;
end;

function TInvoiceItem.CreateTaxes: Boolean;
begin
  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;

    //Insert Encargos de Venda na tabela de Taxas InventoryMovTax
    CommandText := 'INSERT INTO InventoryMovTax ( IDInventoryMov, IDTaxCategory, Tax, TaxValue) ' +
                   'SELECT ' +
                   '  IM.IDInventoryMov, ' +
                   '  ISNULL (TCC.IDTaxCategory,0) AS IDTaxCategory, ' +
                   '  ISNULL (TCC.Tax,0)/100 AS Tax, ' +
                   '  ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TCC.Tax,0)/100 AS TaxValue ' +
                   'FROM InventoryMov IM ' +
                   '  JOIN Model Mo ON (IM.ModelID = Mo.IDModel) ' +
                   '  JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID ) ' +
                   '  JOIN TaxCategory TCP ON (TCP.IDTaxCategory = SG.IDTaxCategory) ' +
                   '  JOIN TaxCategory TCC ON (SG.IDTaxCategory = TCC.IDTaxCategoryParent) ' +
                   'WHERE ' +
                   '  IM.IDInventoryMov = :IDInventoryMov';

    Parameters.ParamByName('IDInventoryMov').Value := FIDInventoryMov;
    Execute;

    //Insert Impostos de Venda na tabela de Taxas InventoryMovTax
    CommandText := 'INSERT INTO InventoryMovTax (IDInventoryMov, IDTaxCategory, Tax, TaxValue) ' +
                   'SELECT ' +
                   '  IM.IDInventoryMov, ' +
                   '  ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory, ' +
                   '  ISNULL (TC.Tax,0)/100 AS Tax, ' +
                   '  ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue ' +
                   'FROM InventoryMov IM ' +
                   '  JOIN Model Mo ON (IM.ModelID = Mo.IDModel) ' +
                   '  JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID ) ' +
                   '  JOIN TaxCategory TC ON (SG.IDSaleTax = TC.IDTaxCategory) ' +
                   'WHERE ' +
                   '  IM.IDInventoryMov = :IDInventoryMov';
    Parameters.ParamByName('IDInventoryMov').Value := FIDInventoryMov;
    Execute;

    Result := True;
  finally
    Free;
  end;
end;

destructor TInvoiceItem.Destroy;
var
  IIC : TInvoiceItemCommission;
  IIS : TInvoiceItemSerial;
begin
  while FCommssionList.Count <> 0 do
  begin
    if FCommssionList[0] <> nil then
    begin
      IIC := TInvoiceItemCommission(FCommssionList[0]);
      FreeAndNil(IIC);
    end;
    FCommssionList.Delete(0);
  end;

  while FSerialNumberList.Count <> 0 do
  begin
    if FSerialNumberList[0] <> nil then
    begin
      IIS := TInvoiceItemSerial(FSerialNumberList[0]);
      FreeAndNil(IIS);
    end;
    FSerialNumberList.Delete(0);
  end;

  FreeAndNil(FCommssionList);
  FreeAndNil(FSerialNumberList);

  if Assigned(FItemDocument) then
    FreeAndNil(FItemDocument);
  inherited;
end;

function TInvoiceItem.GetAutoGeneratePrice: Boolean;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'SELECT SrvValue ' +
                   'FROM Param ' +
                   'WHERE IDParam = 97';
    Open;

    Result := StrToBool(FieldByName('SrvValue').Value);
    Close
  finally
    Free;
  end;
end;

procedure TInvoiceItem.SetValues;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'SELECT M.AvgCost, TG.DesiredMarkup ' +
                   'FROM Model M JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) ' +
                   'WHERE M.IDModel = :IDModel';
    Parameters.ParamByName('IDModel').Value := FIDModel;
    Open;

    FDesiredMarkup := FieldByName('DesiredMarkup').AsFloat;
    FAvgCost := FieldByName('AvgCost').AsCurrency;
    Close
  finally
    Free;
  end;
end;

{ TInvoicePayment }

constructor TInvoicePayment.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoicePayment.CreateInvoicePayment: Boolean;
begin
  Result := False;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_PreSale_AddParcela';
    Parameters.Refresh;

    Parameters.ParambyName('@PreSaleID').Value      := FIDPreSale;
    Parameters.ParambyName('@IDStore').Value        := FIDStore;
    Parameters.ParambyName('@IDUser').Value         := FIDUser;
    Parameters.ParambyName('@IDCliente').Value      := FIDCustomer;
    Parameters.ParambyName('@IDMeioPag').Value      := FIDMeioPag;
    Parameters.ParambyName('@IDCashRegMov').Value   := FIDCashRegMov;
    Parameters.ParambyName('@PreSaleDate').Value    := FPreSaleDate;
    Parameters.ParambyName('@ExpirationDate').Value := FExpirationDate;
    Parameters.ParambyName('@Value').Value          := FPaymentValue;
    Parameters.ParambyName('@Parcela').Value        := FParcela;
    Parameters.ParambyName('@PaymentPlace').Value   := FPaymentPlace;
    Parameters.ParambyName('@IsPredatado').Value    := FIsPredatado;

    if FAuthorization <> '' then
      Parameters.ParambyName('@Authorization').Value := FAuthorization
    else
      Parameters.ParambyName('@Authorization').Value := Null;

    if FCheckNumber <> '' then
      Parameters.ParambyName('@CheckNumber').Value := FCheckNumber
    else
      Parameters.ParambyName('@CheckNumber').Value := Null;

    if FCustomerDocument <> '' then
      Parameters.ParambyName('@CustomerDocument').Value := FCustomerDocument
    else
      Parameters.ParambyName('@CustomerDocument').Value := Null;

    if FCustomerName <> '' then
      Parameters.ParambyName('@CustomerName').Value := FCustomerName
    else
      Parameters.ParambyName('@CustomerName').Value := Null;

    if FCustomerPhone <> '' then
      Parameters.ParambyName('@CustomerPhone').Value := FCustomerPhone
    else
      Parameters.ParambyName('@CustomerPhone').Value := Null;

    if FIDBankCheck <> 0 then
      Parameters.ParambyName('@IDBankCheck').Value := FIDBankCheck
    else
      Parameters.ParambyName('@IDBankCheck').Value := Null;

    if FOBS <> '' then
      Parameters.ParambyName('@OBS').Value := FOBS
    else
      Parameters.ParambyName('@OBS').Value := Null;

    ExecProc;

    if Parameters.ParamByName('@RETURN_VALUE').Value <> 0 then
      raise Exception.Create('SQL (POS) %S : ' + Format('Stored Procedure %S Error %S', [ProcedureName, VarToStr(Parameters.ParamByName('@RETURN_VALUE').Value)]));
  finally
    Free;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'UPDATE Fin_Lancamento SET NumDocumento = :NumDocumento, DataEmissao = :DataEmissao, Previsao = 0 WHERE IDPreSale = :IDPreSale';

    Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    Parameters.ParamByName('NumDocumento').Value := IntToStr(FIDInvoice);
	  Parameters.ParamByName('DataEmissao').Value := FPreSaleDate;
    Execute;
  finally
    Free;
  end;

  Result := True;
end;

{ TInvoiceItemSerial }

constructor TInvoiceItemSerial.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoiceItemSerial.CreateIDAccountCard: Integer;
begin

  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Sal_AccountCard.IDAccountCard';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;

end;

function TInvoiceItemSerial.CreateInvoiceItemSerial: Boolean;
begin
  Result := False;

  with TADODataSet.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'SELECT M.IDModel ' +
                   'FROM Model M ' +
 	                 'WHERE M.IDModel = :IDModel AND M.ModelType = :ModelType ';
    Parameters.ParamByName('IDModel').Value   := FIDModel;
    Parameters.ParamByName('ModelType').Value := 'G';
    Open;
    if (not IsEmpty) then
    begin

      with TADOCommand.Create(nil) do
      try
        Connection := FSQLConnection;
        CommandText := 'INSERT Sal_AccountCard (IDAccountCard, CardNumber, CardDate, IDPreInventoryMov, IDUser, Amount, ExpirationDate) ' +
                       ' VALUES (:IDAccountCard, :CardNumber, :CardDate, :IDPreInventoryMov, :IDUser, 0, :ExpirationDate)';

        Parameters.ParamByName('IDAccountCard').Value     := CreateIDAccountCard;
        Parameters.ParamByName('CardNumber').Value        := FSerialNumber;
        Parameters.ParamByName('CardDate').Value          := Now;
        Parameters.ParamByName('IDPreInventoryMov').Value := Null;
        Parameters.ParamByName('IDUser').Value            := FGiftIDUser;
        Parameters.ParamByName('ExpirationDate').Value    := Null;
        Execute;
      finally
        Free;
      end;


      with TADOStoredProc.Create(nil) do
      try
        Connection := FSQLConnection;
        ProcedureName := 'sp_Sal_AccountCard_AddAmount';
        Parameters.Refresh;
        Parameters.ParamByName('@CardNumber').Value   := FSerialNumber;
        Parameters.ParamByName('@Amount').Value       := FGiftTotal;
        Parameters.ParamByName('@IDPreSale').Value    := FIDPreSale;
        Parameters.ParamByName('@IDLancamento').Value := Null;
        Parameters.ParamByName('@IDUser').Value       := FGiftIDUser;
        Parameters.ParamByName('@Credit').Value       := True;
        Parameters.ParamByName('@OBS').Value          := 'Nº venda ' + FGiftCupom;
        ExecProc;
      finally
        Free;
      end;
    end;

    Close;
  finally
    Free;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT SerialMov (InventoryMovID, SerialNumber, IdentificationNumber) ' +
                   'VALUES (:InventoryMovID, :SerialNumber, :IdentificationNumber)';
    Parameters.ParamByName('InventoryMovID').Value := FIDInventoryMov;
    Parameters.ParamByName('SerialNumber').Value := FSerialNumber;
    Parameters.ParamByName('IdentificationNumber').Value := FIdentificationNumber;
    Execute;

    CommandText := 'DELETE InventorySerial WHERE Serial = :SerialNumber AND StoreID = :StoreID AND ModelID = :ModelID';
    Parameters.ParamByName('SerialNumber').Value := FSerialNumber;
    Parameters.ParamByName('StoreID').Value := FIDStore;
    Parameters.ParamByName('ModelID').Value := FIDModel;
    Execute;
  finally
    Free;
  end;

  Result := True;
end;

{ TInvoiceItemDocument }

constructor TInvoiceItemDocument.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoiceItemDocument.CreateIDMovDocument: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Inv_MovDocument.IDMovDocument';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceItemDocument.CreateInvoiceItemDocument: Boolean;
begin
  Result := False;

  FIDMovDocument := CreateIDMovDocument;
  if FIDMovDocument = -1 then
    raise Exception.Create('Erro ao gerar IDMovDocument.');

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT Inv_MovDocument (IDMovDocument, IDPreInventoryMov, IDInventoryMov, DocumentNumber, DocumentDate, DocumentStatus, IDDocumentType, OBS)' +
                   'VALUES (:IDMovDocument, NULL, :IDInventoryMov, :DocumentNumber, :DocumentDate, 1, :IDDocumentType, NULL)';
    Parameters.ParamByName('IDMovDocument').Value := FIDMovDocument;
    Parameters.ParamByName('IDInventoryMov').Value := FIDInventoryMov;
    Parameters.ParamByName('DocumentNumber').Value := FDocumentNumber;
    Parameters.ParamByName('DocumentDate').Value := FDocumentDate;
    Parameters.ParamByName('IDDocumentType').Value := FIDDocumentType;
    Execute;
  finally
    Free;
  end;

  Result := True;
end;

{ TInvoiceItemPrice }

constructor TInvoiceItemPrice.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoiceItemPrice.CreateIDMovPrice: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Inv_MovPrice.IDMovPrice';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceItemPrice.CreateInvoiceItemPrice: Boolean;
begin
  Result := False;

  FIDMovPrice := CreateIDMovPrice;
  if FIDMovPrice = -1 then
    raise Exception.Create('Erro ao gerar IDMovPrice.');

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT INTO Inv_MovPrice (IDMovPrice, IDPreInventoryMov, IDInventoryMov, IDDescriptionPrice, IDVendor, SuggPrice) ' +
                   'VALUES (:IDMovPrice, NULL, :IDInventoryMov, :IDDescriptionPrice, :IDVendor, :SuggPrice)';

    Parameters.ParamByName('IDMovPrice').Value         := FIDMovPrice;
    Parameters.ParamByName('IDInventoryMov').Value     := FIDInventoryMov;
    Parameters.ParamByName('IDDescriptionPrice').Value := FIDDescriptionPrice;
    Parameters.ParamByName('IDVendor').Value           := FIDVendorPrice;
    Parameters.ParamByName('SuggPrice').Value          := FSuggPrice;
    Execute;
  finally
    Free;
  end;

  Result := True;
end;

{ TInvoiceRemovedItem }

function TInvoiceRemovedItem.CreateIDRemovedItem: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Sal_RemovedItem.IDRemovedItem';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;

end;

function TInvoiceRemovedItem.CreateInvoiceItem: Boolean;
var
  FIDRemovedItem : Integer;
begin

  Result := False;

  FIDRemovedItem := CreateIDRemovedItem;
  if FIDRemovedItem = -1 then
    raise Exception.Create('Erro ao gerar IDRemovedItem.');

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;

    CommandText := 'INSERT Sal_RemovedItem(IDRemovedItem, IDCashRegister, IDModel, IDStore, ' +
                   'IDDepartment, IDUserAuto, IDPessoa, IDUser, MovDate, Qty, SalePrice, CostPrice, '+
                   'Discount, SaleCode, PosicaoItem, Acrescimo, TotalizadorParcial, IDNotasCanceladas, ' +
                   'IDPreSale) VALUES (:IDRemovedItem, :IDCashRegister, :IDModel, :IDStore, :IDDepartment, ' +
                   ':IDUserAuto, :IDPessoa, :IDUser, :MovDate, :Qty, :SalePrice, :CostPrice, :Discount, ' +
                   ':SaleCode, :PosicaoItem, :Acrescimo, :TotalizadorParcial, :IDNotasCanceladas, :IDPreSale)';

    Parameters.ParamByName('IDRemovedItem').Value      := FIDRemovedItem;
    Parameters.ParamByName('IDCashRegister').Value     := IDCashRegister;
    Parameters.ParamByName('IDModel').Value            := IDModel;
    Parameters.ParamByName('IDStore').Value            := IDStore;
    Parameters.ParamByName('IDDepartment').Value       := IDDepartment;
    Parameters.ParamByName('IDUserAuto').Value         := IDUser;
    Parameters.ParamByName('IDPessoa').Value           := IDComission;
    Parameters.ParamByName('IDUser').Value             := IDUser;
    Parameters.ParamByName('MovDate').Value            := MovDate;
    Parameters.ParamByName('Qty').Value                := Qty;
    Parameters.ParamByName('SalePrice').Value          := SalePrice;
    Parameters.ParamByName('CostPrice').Value          := CostPrice;
    Parameters.ParamByName('Discount').Value           := Discount;
    Parameters.ParamByName('SaleCode').Value           := SaleCode;
    Parameters.ParamByName('PosicaoItem').Value        := ItemIndex;
    Parameters.ParamByName('Acrescimo').Value          := Acrescimo;
    Parameters.ParamByName('TotalizadorParcial').Value := TotParcial;
    Parameters.ParamByName('IDNotasCanceladas').Value  := Null;
    Parameters.ParamByName('IDPreSale').Value          := IDPreSale;

    Execute;
  finally
    Free;
  end;

  Result := True;

end;

end.
