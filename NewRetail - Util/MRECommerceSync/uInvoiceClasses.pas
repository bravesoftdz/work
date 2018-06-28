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
  public
    constructor Create(ASQLConnection: TADOConnection);
    function CreateInvoiceItemSerial: Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDInventoryMov: Integer read FIDInventoryMov write FIDInventoryMov;
    property SerialNumber: String read FSerialNumber write FSerialNumber;
    property IdentificationNumber: String read FIdentificationNumber write FIdentificationNumber;
    property IDModel : Integer read FIDModel write FIDModel;
    property IDStore : Integer read FIDStore write FIDStore;
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

    procedure SetValues;
    function CreateIDInventoryMov: Integer;
    function CreateTaxes: Boolean;
    function CreatePricePayment: Boolean;
    function GetAutoGeneratePrice: Boolean;
    function CreateIDLancamento: Integer;
  public
    constructor Create(ASQLConnection: TADOConnection);
    destructor Destroy; override;

    function CreateInvoiceItem: Boolean;

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
		property IDComission: Integer read FIDComission write FIDComission;
		property Qty: Double read FQty write FQty;
 		property SalePrice: Currency read FSalePrice write FSalePrice;
		property CostPrice: Currency read FCostPrice write FCostPrice;
		property Discount: Currency read FDiscount write FDiscount;
		property MovDate: TDateTime read FMovDate write FMovDate;
		property IDPreInvMovExchange: Integer read FIDPreInvMovExchange write FIDPreInvMovExchange;
		property IDDepartment: Integer read FIDDepartment write FIDDepartment;
		property IsPromo: Boolean read FIsPromo write FIsPromo;
		property IDParentPack: Integer read FIDParentPack write FIDParentPack;
		property AvgCost: Currency read FAvgCost write FAvgCost;
		property DesiredMarkup: Double read FDesiredMarkup write FDesiredMarkup;
    property ItemDocument: TInvoiceItemDocument read FItemDocument write FItemDocument;
    property ItemPrice: TInvoiceItemPrice read FItemPrice write FItemPrice;
  end;

  TInvoiceOtherCost = class
  private
    FAmount: Currency;
    FIDInvoiceCost: Integer;
    FIDCostType: Integer;
    FIDPreSale: Integer;
    FSQLConnection: TADOConnection;
  public
    constructor Create(ASQLConnection: TADOConnection);

    function CreateInvoiceOtherCost: Boolean;
    function CreateIDInvoiceOtherCost: Integer;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property IDInvoiceCost: Integer read FIDInvoiceCost write FIDInvoiceCost;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDCostType: Integer read FIDCostType write FIDCostType;
    property Amount: Currency read FAmount write FAmount;
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
    FMeioPag: String;
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
    property MeioPag: String read FMeioPag write FMeioPag;
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
    FDeliverAddress: String;
    FDeliverDate: TDateTime;
    FInvoiceFrete: Currency;
    FOtherCostList: TList;

    procedure SetTotalValues;
    procedure SetIDParentPack(APackIndex: Integer);
    function ValidadePayment: Boolean;
    function GetNewInvoiceCode: String;
    function AddFrete(ATotal : Currency) : Boolean;
  public
    constructor Create(ASQLConnection: TADOConnection);
    destructor Destroy; override;

    function GetNewID(ATabela: String): Integer;
    function CreateInvoice: Boolean;
    function AddInvoiceItem(AInvoiceItem: TInvoiceItem): Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property ItemList: TList read FItemList write FItemList;
    property PaymentList: TList read FPaymentList write FPaymentList;
    property OtherCostList: TList read FOtherCostList write FOtherCostList;
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
    property InvoiceFrete: Currency read FInvoiceFrete write FInvoiceFrete;
    property ItemDiscount: Currency read FItemDiscount write FItemDiscount;
    property SubTotal: Currency read FSubTotal write FSubTotal;

    property DeliverDate: TDateTime read FDeliverDate write FDeliverDate;
    property DeliverAddress: String read FDeliverAddress write FDeliverAddress;

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
    CommandText := 'INSERT INTO SaleItemCommission (IDSaleItemCommission, IDPreInventoryMov, IDCommission, CommissionPercent) ' +
	                 'VALUES (:IDSaleItemCommission, :IDPreInventoryMov, :IDComission, :CommissionPercent)';
    Parameters.ParamByName('IDSaleItemCommission').Value := FIDSaleItemCommission;
    Parameters.ParamByName('IDPreInventoryMov').Value    := FIDInventoryMov;
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
  FSQLConnection := ASQLConnection;
  FItemList      := TList.Create;
  FPaymentList   := TList.Create;
  FOtherCostList := TList.Create;  
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
  cAditionalExpenses: Currency;
begin
  Result := False;

  FIDPreSale := GetNewID('Invoice.IDPresale');
  if FIDPreSale = -1 then
    raise Exception.Create('Erro ao gerar IDPreSale.');

  {
  FIDInvoice := GetNewID('InvoiceGen.IDInvoice');
  if FIDInvoice = -1 then
    raise Exception.Create('Erro ao gerar IDInvoice.');
  }
  
  SetTotalValues;
  //if not ValidadePayment then
  //  raise Exception.Create('Valor da nota é diferente do total de pagamentos.');
  {
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
  }

  FSaleCode := FCOO;

  for i := 0 to Pred(FPaymentList.Count) do
  begin
    if StrToIntDef(TInvoicePayment(FPaymentList[i]).Parcela, 0) > 1 then
      FNote := FNote + TInvoicePayment(FPaymentList[i]).MeioPag + ' ' + FormatFloat('0.00', TInvoicePayment(FPaymentList[i]).PaymentValue) + ' '
    else
      FNote := FNote +
               TInvoicePayment(FPaymentList[i]).MeioPag + ' Nº' + TInvoicePayment(FPaymentList[i]).Parcela + ' ' +
               FormatFloat('0.00', TInvoicePayment(FPaymentList[i]).PaymentValue) + ' '
  end;

  cAditionalExpenses := 0;
  for i := 0 to Pred(FOtherCostList.Count) do
  begin
    cAditionalExpenses := cAditionalExpenses + TInvoiceOtherCost(FOtherCostList[i]).Amount;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT INTO Invoice (IDPreSale, IDInvoice, IDCustomer, IDTouristGroup, PreSaleDate, CupomFiscal, Tax, ItemDiscount, ' +
                   'InvoiceDate, MediaID, DeliverTypeID, OtherComissionID, FirstName, LastName, TaxIsent, CashReceived, CashRegMovID, ' +
                   'Layaway, IDStore, Zip, Note, PrintNotes, PuppyTracker, SaleCode, NumeroSeriePrinter, InvoiceCode, SubTotal, InvoiceDiscount, '+
                   'DeliverDate, DeliverAddress, AditionalExpenses) ' +
                   'VALUES (:IDPreSale, :IDInvoice, :IDCustomer, :IDTouristGroup, :PreSaleDate, :CupomFiscal, :Tax, :ItemDiscount, ' +
                   ':InvoiceDate, :MediaID, :DeliverTypeID, :IDOtherCommission, :FirstName, :LastName, :TaxIsent, :CashReceived, :CashRegMovID, ' +
                   ':Layaway, :IDStore, :Zip, :Note, :PrintNotes, :PuppyTracker, :SaleCode, :NumeroSeriePrinter, :InvoiceCode, :SubTotal, :InvoiceDiscount, '+
                   ':DeliverDate, :DeliverAddress, :AditionalExpenses)';
    Parameters.ParambyName('IDPreSale').Value          := FIDPreSale;
    Parameters.ParambyName('PreSaleDate').Value        := FPreSaleDate;
    Parameters.ParambyName('IDInvoice').Value          := NULL;
    Parameters.ParambyName('InvoiceDate').Value        := NULL;
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
		Parameters.ParambyName('CashRegMovID').Value       := NULL;
    Parameters.ParambyName('SubTotal').Value           := FSubTotal;
    Parameters.ParambyName('ItemDiscount').Value       := FItemDiscount;
    Parameters.ParambyName('InvoiceDiscount').Value    := FInvoiceDiscount;
    Parameters.ParambyName('DeliverAddress').Value     := Copy(FDeliverAddress, 1, 100);
    Parameters.ParambyName('CupomFiscal').Value        := NULL;
    Parameters.ParambyName('NumeroSeriePrinter').Value := NULL;
    Parameters.ParambyName('AditionalExpenses').Value  := cAditionalExpenses;

    if FDeliverDate <> 0 then
      Parameters.ParambyName('DeliverDate').Value := FDeliverDate
    else
      Parameters.ParambyName('DeliverDate').Value := NULL;

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
      Parameters.ParambyName('Note').Value       := Copy(FNote, 1, 150);
      Parameters.ParambyName('PrintNotes').Value := True;
    end;
    Execute;
  finally
    Free;
  end;

  for i := 0 to Pred(FOtherCostList.Count) do
  begin
    TInvoiceOtherCost(FOtherCostList[i]).IDPreSale := FIDPreSale;

    if not TInvoiceOtherCost(FOtherCostList[i]).CreateInvoiceOtherCost then
    begin
      Result := False;
      Exit;
    end;
  end;

  for i := 0 to Pred(FItemList.Count) do
  begin
    TInvoiceItem(FItemList[i]).IDPreSale := FIDPreSale;
    TInvoiceItem(FItemList[i]).IDInvoice := FIDInvoice;
    TInvoiceItem(FItemList[i]).InvoiceCode := FInvoiceCode;
    if not TInvoiceItem(FItemList[i]).CreateInvoiceItem then
    begin
      Result := False;
      Exit;
    end;

    SetIDParentPack(i);
  end;

  if FInvoiceFrete <> 0 then
    AddFrete(FInvoiceFrete);

  {
  for i := 0 to Pred(FPaymentList.Count) do
  begin
    TInvoicePayment(FPaymentList[i]).IDPreSale := FIDPreSale;
    TInvoicePayment(FPaymentList[i]).IDInvoice := FIDInvoice;
    if not TInvoicePayment(FPaymentList[i]).CreateInvoicePayment then
    begin
      Result := False;
      Exit;
    end;
  end;
  }
  Result := True;
end;

destructor TInvoice.Destroy;
begin
  FreeAndNil(FItemList);
  FreeAndNil(FPaymentList);
  FreeAndNil(FOtherCostList);
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
begin
  FItemDiscount := 0;
  FSubTotal := 0;

  for i := 0 to Pred(FItemList.Count) do
  begin
    FItemDiscount := FItemDiscount + TInvoiceItem(FItemList[i]).Discount;
    FSubTotal := FSubTotal + TruncMoney(TInvoiceItem(FItemList[i]).SalePrice * TInvoiceItem(FItemList[i]).Qty, 2);
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

  Result := (FSubTotal - FInvoiceDiscount - FItemDiscount + FInvoiceFrete) = dTotalPayment;
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

function TInvoice.AddFrete(ATotal: Currency): Boolean;
var
  ID : Integer;
begin

  ID := GetNewID('InvoiceToCostType.IDInvoiceCost');

  Result := False;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT INTO InvoiceToCostType (IDInvoiceCost, IDPreSale, IDCostType, Amount) ' +
	                 'VALUES (:IDInvoiceCost, :IDPreSale, :IDCostType, :Amount)';
    Parameters.ParamByName('IDInvoiceCost').Value := ID;;
    Parameters.ParamByName('IDPreSale').Value     := FIDPreSale;
    Parameters.ParamByName('IDCostType').Value    := 3;
    Parameters.ParamByName('Amount').Value        := ATotal;

    Execute;
    Result := True;
  finally
    Free;
  end;

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
    Parameters.ParamByName('@Tabela').Value := 'InventoryMov.IDPreInventoryMov';
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
    raise Exception.Create('Erro ao gerar IDPreInventoryMov.');

  SetValues;

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT PreInventoryMov (IDPreInventoryMov, InventMovTypeID, DocumentID, ' +
                   'IDPessoa, StoreID, ModelID, MovDate, Qty, CostPrice, SalePrice, ' +
                   'Discount, UserID, DesiredMarkup, IDDepartment, Promo) ' +
                   'VALUES (:IDPreInventoryMov, :InventMovTypeID, :DocumentID, :IDPessoa, :StoreID, ' +
                   ':ModelID, :MovDate, :Qty, :CostPrice, :SalePrice, :Discount, ' +
                   ':UserID, :DesiredMarkup, :IDDepartment, :Promo)';

    Parameters.ParamByName('IDPreInventoryMov').Value := FIDInventoryMov;
    Parameters.ParamByName('InventMovTypeID').Value := 1;
    Parameters.ParamByName('DocumentID').Value      := FIDPreSale;
    Parameters.ParamByName('IDPessoa').Value        := FIDCustomer;
    Parameters.ParamByName('StoreID').Value         := FIDStore;
    Parameters.ParamByName('ModelID').Value         := FIDModel;
    Parameters.ParamByName('MovDate').Value         := Trunc(FMovDate);
    Parameters.ParamByName('Qty').Value             := FQty;
    Parameters.ParamByName('CostPrice').Value       := FCostPrice;
    Parameters.ParamByName('SalePrice').Value       := FSalePrice;
    Parameters.ParamByName('Discount').Value        := FDiscount;
    Parameters.ParamByName('UserID').Value          := FIDUser;
    Parameters.ParamByName('IDDepartment').Value    := FIDDepartment;
    Parameters.ParamByName('Promo').Value           := FIsPromo;
    Parameters.ParamByName('DesiredMarkup').Value   := FDesiredMarkup;

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

  {
  for i := 0 to Pred(FSerialNumberList.Count) do
  begin
    TInvoiceItemSerial(FSerialNumberList[i]).IDInventoryMov := FIDInventoryMov;
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
  }

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
  {
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
  }

  Result := True;
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

function TInvoiceItemSerial.CreateInvoiceItemSerial: Boolean;
begin
  {
  Result := False;

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
  }

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
  {
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
  }
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
  {
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
  }
  Result := True;
end;

{ TInvoiceOtherCost }

constructor TInvoiceOtherCost.Create(ASQLConnection: TADOConnection);
begin
  FSQLConnection := ASQLConnection;
end;

function TInvoiceOtherCost.CreateIDInvoiceOtherCost: Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FSQLConnection;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'InvoiceToCostType.IDInvoiceCost';
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

function TInvoiceOtherCost.CreateInvoiceOtherCost: Boolean;
begin
  Result := False;

  FIDInvoiceCost := CreateIDInvoiceOtherCost;
  if FIDInvoiceCost = -1 then
    raise Exception.Create('Erro ao gerar IDInvoiceOtherCost.');

  with TADOCommand.Create(nil) do
  try
    Connection := FSQLConnection;
    CommandText := 'INSERT InvoiceToCostType (IDInvoiceCost, IDPreSale, IDCostType, Amount) ' +
                   'VALUES (:IDInvoiceCost, :IDPreSale, :IDCostType, :Amount)';

    Parameters.ParamByName('IDInvoiceCost').Value := FIDInvoiceCost;
    Parameters.ParamByName('IDPreSale').Value     := FIDPreSale;
    Parameters.ParamByName('IDCostType').Value    := FIDCostType;
    Parameters.ParamByName('Amount').Value        := FAmount;

    Execute;
  finally
    Free;
  end;

  Result := True;
end;

end.
