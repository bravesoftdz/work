unit uPreSale;

interface

uses
  SysUtils, Classes, uMsgBox, uMsgConstant, uNumericFunctions, Math;

type
  TDiscountType = (tdtDesconto, tdtAcrescimo);
  TDiscountValueType = (dvtValor, dvtPerc);
  TDiscountKind = (dkNone, dkItem, dkInvoice);

  TPreSaleType = (tptInvoice, tptRefund, tptLayAway, tptExchange);

  TPreSaleItem = class;

  TBeforeAddPreSaleItem     = procedure(var PSI: TPreSaleItem; var Sucess: Boolean) of object;
  TAfterAddPreSaleItem      = procedure(PSI: TPreSaleItem; var Sucess: Boolean) of object;
  TBeforeDoInvoiceDiscount  = procedure(ADiscountPerc: Currency; var AAccept: Boolean) of object;
  TPreSaleItemRequestRight  = procedure(PSI: TPreSaleItem; var AAccept: Boolean) of object;

  TSellingItem = class
    IDModel:     Integer;
    Model:       String;
    CostPrice:   Currency;
    SalePrice:   Currency;
    Description: String;
  end;

  TSalesPersonInfo = class
    IDUser:           Integer;
    UserName:         String;
    IDCommission:     Integer;
    IDCommissionType: Integer;
  end;

  TMediaInfo = class
    IDMedia:   Integer;
    MediaName: String;
  end;

  TCustomerInfo = class
    IDCustomer:   Integer;
    FirstName:    String;
    LastName:     String;
    Endereco:     String;
    Cidade:       String;
    Bairro:       String;
    Zip:          String;
    CPF:          String;
    TelDDD:       String;
    Telefone:     String;
    Juridico:     Boolean;
    IsNew:        Boolean;
    Estado:       String;
    CelDDD:       String;
    Celelular:    String;
    Email:        String;
    WebSite:      String;
    Identidate:   String;
    OrgEmiss:     String;
    ExpDate:      TDateTime;
    BirthDate:    TDateTime;
    CustCard:     String;
    CMotorista:   String;
    NomeJuridico: String;
    InscEstadual: String;
    InscMunicipal:String;
    Contato:      String;
    OBS:          String;
    StoreAccountLimit: Currency;
    Nonpayer:     Boolean;
  end;

  TTouristGroup = class
    IDTouristGroup: Integer;
    TouristGroup:   String;
  end;

  TCommissionGroup = class
    IDCommisionGroup: Integer;
    CommisionGroup:   String;
  end;

  TPreSaleInfo = class
  private
    FCommissionGroup: TCommissionGroup;
    FCustomerInfo:    TCustomerInfo;
    FMediaInfo:       TMediaInfo;
    FTouristGroup:    TTouristGroup;
  public
    property MediaInfo:       TMediaInfo       read FMediaInfo       write FMediaInfo;
    property CustomerInfo:    TCustomerInfo    read FCustomerInfo    write FCustomerInfo;
    property TouristGroup:    TTouristGroup    read FTouristGroup    write FTouristGroup;
    property CommissionGroup: TCommissionGroup read FCommissionGroup write FCommissionGroup;

    constructor Create;
    destructor Destroy;override;

    procedure UnSet;
  end;

  TPreSaleItemSuggestion = class
    FModel:       String;
    FDescription: String;
    FSalePrice:   Currency;
    FOBS:         String;
  end;

  TPreSaleItemSerial = class
  private
    FSerialNumber: String;
    FIdentificationNumber: String;
  public
    property SerialNumber: String read FSerialNumber write FSerialNumber;
    property IdentificationNumber: String read FIdentificationNumber write FIdentificationNumber;
  end;

  TPreSaleItemPrice = class
  private
    FIDVendorPrice: Integer;
    FIDDescriptionPrice: Integer;
    FSuggPrice: Currency;
    FSalePrice: Currency;
  public
    property IDVendorPrice: Integer read FIDVendorPrice write FIDVendorPrice;
    property IDDescriptionPrice: Integer read FIDDescriptionPrice write FIDDescriptionPrice;
    property SuggPrice: Currency read FSuggPrice write FSuggPrice;
    property SalePrice: Currency read FSalePrice write FSalePrice;
  end;

  TPreSaleItem = class
  private
    FIDCustomer:      Integer;
    FIDModel:         Integer;
    FIDStore:         Integer;
    FQty:             Double;
    FDiscount:        Currency;
    FSale:            Currency;
    FCost:            Currency;
    FIDUser:          Integer;
    FIDCommis:        Integer;
    FMovDate:         TDateTime;
    FDate:            TDateTime;
    FManager:         Boolean;
    FIDPreInvMov:     Integer;
    FPercMaxDisc:     Currency;
    FTaxValue :       Currency;
    FDescription:     String;
    FECFTaxIndex:     String;
    FECFIndex:        Integer;
    FModel:           String;
    FImagePath:       String;
    FBarCode:         String;
    FRequestCustomer: Boolean;
    FPuppyTracker:    Boolean;
    FCaseQty:         Double;
    FPrinted:         Boolean;
    FIDDepartment:    Integer;
    FSerialNumbers:   TList;
    FSuggPrice:       Currency;
    FIDVendorPrice:   Integer;
    FIDDescriptionPrice: Integer;
    FIDDocumentType:  Integer;
    FDocumentNumber:  String;
    FTotalInformed:   Currency;
    FTotalizadorParcial: String;
    FUnidade: String;
    function GetSerialNumbers(Index: Integer): TPreSaleItemSerial;
    procedure SetSerialNumbers(Index: Integer; const Value: TPreSaleItemSerial);
    procedure ClearSerialItems;
  public
    property IDCustomer:         Integer   read FIDCustomer         write FIDCustomer;
    property IDModel:            Integer   read FIDModel            write FIDModel;
    property IDStore:            Integer   read FIDStore            write FIDStore;
    property Qty:                Double    read FQty                write FQty;
    property Discount:           Currency  read FDiscount           write FDiscount;
    property Sale:               Currency  read FSale               write FSale;
    property Cost:               Currency  read FCost               write FCost;
    property IDUser:             Integer   read FIDUser             write FIDUser;
    property IDCommis:           Integer   read FIDCommis           write FIDCommis;
    property MovDate:            TDateTime read FMovDate            write FMovDate;
    property Date:               TDateTime read FDate               write FDate;
    property Manager:            Boolean   read FManager            write FManager;
    property IDPreInvMov:        Integer   read FIDPreInvMov        write FIDPreInvMov;
    property PercMaxDisc:        Currency  read FPercMaxDisc        write FPercMaxDisc;
    property TaxValue:           Currency  read FTaxValue           write FTaxValue;
    property Description:        String    read FDescription        write FDescription;
    property ECFTaxIndex:        String    read FECFTaxIndex        write FECFTaxIndex;
    property ECFIndex:           Integer   read FECFIndex           write FECFIndex;
    property Model:              String    read FModel              write FModel;
    property ImagePath:          String    read FImagePath          write FImagePath;
    property BarCode:            String    read FBarCode            write FBarCode;
    property PuppyTracker:       Boolean   read FPuppyTracker       write FPuppyTracker;
    property RequestCustomer:    Boolean   read FRequestCustomer    write FRequestCustomer;
    property CaseQty:            Double    read FCaseQty            write FCaseQty;
    property Printed:            Boolean   read FPrinted            write FPrinted;
    property IDDepartment:       Integer   read FIDDepartment       write FIDDepartment;
    property IDDescriptionPrice: Integer   read FIDDescriptionPrice write FIDDescriptionPrice;
    property IDVendorPrice:      Integer   read FIDVendorPrice      write FIDVendorPrice;
    property SuggPrice:          Currency  read FSuggPrice          write FSuggPrice;
    property DocumentNumber:     String    read FDocumentNumber     write FDocumentNumber;
    property IDDocumentType:     Integer   read FIDDocumentType     write FIDDocumentType;
    property TotalInformed:      Currency  read FTotalInformed      write FTotalInformed;
    property TotalizadorParcial: String    read FTotalizadorParcial write FTotalizadorParcial;
    property Unidade:            String    read FUnidade            write FUnidade;
    property SerialNumbers[Index: Integer]: TPreSaleItemSerial read GetSerialNumbers write SetSerialNumbers;

    constructor Create;
    destructor Destroy; override;

    procedure AddSerialNumber(ASerialNumber, AIdentificationNumber: String); overload;
    procedure AddSerialNumber(APreSaleItemSerial: TPreSaleItemSerial); overload;
  end;

  TPreSale = class(TComponent)
    private
      FDeliverType:             Integer;
      FIsLayaway:               Boolean;
      FIDStore:                 Integer;
      FPreSaleDate:             TDateTime;
      FInvObs:                  String;
      FIDPreSale:               Integer;
      FPresaleMaxDisc:          Currency;
      FItems:                   TList;
      FItemsSugg:               TStringList;
      FSaleBelowCostPrice:      Boolean;
      FBeforeAddPreSaleItem:    TBeforeAddPreSaleItem;
      FAfterAddPreSaleItem:     TAfterAddPreSaleItem;
      FInvoiceDiscount:         Currency;
      FPreSaleInfo:             TPreSaleInfo;
      FECFAddedItems:           Integer;
      FIDOtherComiss:           Integer;
      FCOO:                     String;
      FTaxExempt:               Boolean;
      FPuppyTracker :           Boolean;
      FSaleCode:                String;
      FBeforeDoInvoiceDiscount: TBeforeDoInvoiceDiscount;
      FDiscountKind:            TDiscountKind;
      FSerialECF: String;
      FPreSaleType: TPreSaleType;
      FRoundDecimalTo: Integer;
      FOnItemDiscount: TPreSaleItemRequestRight;
      FCouponOpened: Boolean;
      FImported: Boolean;
      FCCF: String;

      function GetItems(Index: Integer): TPreSaleItem;
      procedure SetItems(Index: Integer; const Value: TPreSaleItem);
      function GetSuggestItems(Index: Integer): TPreSaleItemSuggestion;
      function GetCount: Integer;
      function GetSuggestCount : Integer;
      procedure RemovePreSaleItem(Index: Integer);
      procedure UpdateValues;
      function GetDiscountTotal: Currency;
      function GetCostTotal: Currency;
      function GetSaleTotal: Currency;
      function GetTaxTotal: Currency;
      function GetRefundTotal: Currency;
      function TestDiscountAdd(PSI: TPreSaleItem): Boolean;
      function GetScaleDifference: Currency;
    protected
      { Protected declarations }
    public
      { Public declarations }
      property Items[Index: Integer]: TPreSaleItem read GetItems write SetItems;
      property SuggestItems[Index: Integer]: TPreSaleItemSuggestion read GetSuggestItems;

      property COO:                String         read FCOO                write FCOO;
      property CCF:                String         read FCCF                write FCCF;
      property DeliverType:        Integer        read FDeliverType        write FDeliverType;
      property IsLayaway:          Boolean        read FIsLayaway          write FIsLayaway;
      property IDStore:            Integer        read FIDStore            write FIDStore;
      property PreSaleDate:        TDateTime      read FPreSaleDate        write FPreSaleDate;
      property InvObs:             String         read FInvObs             write FInvObs;
      property IDPreSale:          Integer        read FIDPreSale          write FIDPreSale;
      property IDOtherComiss:      Integer        read FIDOtherComiss      write FIDOtherComiss;

      property PresaleMaxDisc:     Currency       read FPresaleMaxDisc     write FPresaleMaxDisc;
      property DiscountKind:       TDiscountKind  read FDiscountKind       write FDiscountKind;

      property DiscountTotal:      Currency       read GetDiscountTotal;
      property SaleTotal:          Currency       read GetSaleTotal;
      property ScaleDifference:    Currency       read GetScaleDifference;
      property CostTotal:          Currency       read GetCostTotal;
      property RefundTotal:        Currency       read GetRefundTotal;
      property TaxTotal:           Currency       read GetTaxTotal;
      property TaxExempt:          Boolean        read FTaxExempt          write FTaxExempt;
      property PuppyTracker:       Boolean        read FPuppyTracker       write FPuppyTracker;
      property SaleBelowCostPrice: Boolean        read FSaleBelowCostPrice write FSaleBelowCostPrice;
      property SerialECF:          String         read FSerialECF          write FSerialECF;
      property RoundDecimalTo:     Integer        read FRoundDecimalTo     write FRoundDecimalTo;
      property PreSaleType:        TPreSaleType   read FPreSaleType        write FPreSaleType;
      property InvoiceDiscount:    Currency       read FInvoiceDiscount    write FInvoiceDiscount;
      property PreSaleInfo:        TPreSaleInfo   read FPreSaleInfo        write FPreSaleInfo;
      property Count:              Integer        read GetCount;
      property SuggestCount:       Integer        read GetSuggestCount;
      property ECFAddedItems:      Integer        read FECFAddedItems;
      property SaleCode:           String         read FSaleCode           write FSaleCode;
      property CouponOpened:       Boolean        read FCouponOpened       write FCouponOpened;
      property Imported:           Boolean        read FImported           write FImported;

      constructor Create(AOwner: TComponent);override;
      destructor Destroy;override;

      function AddPreSaleItem(AIDCustomer, AIDModel, AIDStore, AIDUser,
        AIDCommis: Integer; ADiscount, ASale, ACost: Currency; AQty : Double; ATaxValue,
        APercMaxDisc: Currency; AMovDate, ADate: TDateTime; AResetDisc,
        AManager: Boolean; ADescription, AECFTaxIndex, AModel,
        AImagePath: String; APuppyTracker, ARequestCustomer: Boolean;
        ACaseQty: Double; AIDDepartment, AIDVendorPrice, AIDDescriptionPrice: Integer;
        ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentType: Integer;
        ASerialNumber, AIdentificationNumber: String; ATotalInformed : Currency; ATotParcial, AUnidade: String): Boolean;

      function Add(PreSaleItem: TPreSaleItem): Integer;

      procedure Clear;
      procedure Delete(Index: Integer);

      procedure ResetDiscount;
      function DoDiscount(ADiscountType: TDiscountType; ADiscountValueType : TDiscountValueType; AValue: Currency): Boolean;
      function CalcDiscount(ADiscountType: TDiscountType; ADiscountValueType : TDiscountValueType; AValue: Currency): Currency;
      procedure ResetTax;
      function AddItemSuggestion(AModel, ADescription, AOBS : String; ASalePrice: Currency):Boolean;
      function PrintedCount: Integer;
    published
      property BeforeAddPreSaleItem: TBeforeAddPreSaleItem       read FBeforeAddPreSaleItem    write FBeforeAddPreSaleItem;
      property AfterAddPreSaleItem: TAfterAddPreSaleItem         read FAfterAddPreSaleItem     write FAfterAddPreSaleItem;
      property BeforeDoInvoiceDiscount: TBeforeDoInvoiceDiscount read FBeforeDoInvoiceDiscount write FBeforeDoInvoiceDiscount;
      property OnItemDiscount: TPreSaleItemRequestRight          read FOnItemDiscount          write FOnItemDiscount;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TPreSale]);
end;

{ TPreSale }

function TPreSale.Add(PreSaleItem: TPreSaleItem): Integer;
begin
  Result := FItems.Add(PreSaleItem);
  if PreSaleItem.Discount <> 0 then
    FDiscountKind := dkItem;
  UpdateValues;
end;


function TPreSale.AddPreSaleItem(AIDCustomer, AIDModel, AIDStore, AIDUser,
  AIDCommis: Integer; ADiscount, ASale, ACost: Currency; AQty : Double; ATaxValue,
  APercMaxDisc: Currency; AMovDate, ADate: TDateTime; AResetDisc, AManager: Boolean;
  ADescription, AECFTaxIndex, AModel, AImagePath: String; APuppyTracker, ARequestCustomer: Boolean;
  ACaseQty: Double; AIDDepartment, AIDVendorPrice, AIDDescriptionPrice: Integer;
  ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentType: Integer;
  ASerialNumber, AIdentificationNumber: String; ATotalInformed : Currency;
  ATotParcial, AUnidade: String): Boolean;
var
  PreSaleItem : TPreSaleItem;
begin
  Result := False;

  try
    PreSaleItem := TPreSaleItem.Create;
    with PreSaleItem do
    begin
      FIDCustomer         := AIDCustomer;
      FIDModel            := AIDModel;
      FIDStore            := AIDStore;
      FQty                := AQty;
      FDiscount           := ADiscount;
      FSale               := ASale;
      FCost               := ACost;
      FTotalInformed      := ATotalInformed;
      FIDUser             := AIDUser;
      FIDCommis           := AIDCommis;
      FMovDate            := AMovDate;
      FDate               := ADate;
      FManager            := AManager;
      FTaxValue           := ATaxValue;
      FPercMaxDisc        := APercMaxDisc;
      FDescription        := ADescription;
      FECFTaxIndex        := AECFTaxIndex;
      FModel              := AModel;
      FImagePath          := AImagePath;
      FPuppyTracker       := APuppyTracker;
      FRequestCustomer    := ARequestCustomer;
      FCaseQty            := ACaseQty;
      FPrinted            := False;
      FIDDepartment       := AIDDepartment;
      FIDVendorPrice      := AIDVendorPrice;
      FIDDescriptionPrice := AIDDescriptionPrice;
      FSuggPrice          := ASuggPrice;
      FDocumentNumber     := ADocumentNumber;
      FIDDocumentType     := AIDDocumentType;
      FTotalizadorParcial := ATotParcial;
      FUnidade            := AUnidade;

      if ASerialNumber <> '' then
        AddSerialNumber(ASerialNumber, AIdentificationNumber);
    end;

    if not TestDiscountAdd(PreSaleItem) then
      Exit;

    if AResetDisc then
      ResetDiscount;

    if Assigned(FBeforeAddPreSaleItem) then
      FBeforeAddPreSaleItem(PreSaleItem, Result);

    if Result then
      begin
        Add(PreSaleItem);
        Inc(FECFAddedItems);
        PreSaleItem.ECFIndex := FECFAddedItems;

        if Assigned(FAfterAddPreSaleItem) then
           FAfterAddPreSaleItem(PreSaleItem, Result);
      end
    else
      FreeAndNil(PreSaleItem);

  except
    Result := False;
  end;

  UpdateValues;
end;

constructor TPreSale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not (csDesigning in ComponentState) then
  begin
    FItems         := TList.Create;
    FPreSaleInfo   := TPreSaleInfo.Create;
    FItemsSugg     := TStringList.Create;
    FIDPreSale     := -1;
    FECFAddedItems := 0;
    FDiscountKind  := dkNone;
    FPreSaleType   := tptInvoice;
  end;
end;

procedure TPreSale.Delete(Index: Integer);
begin
  RemovePreSaleItem(Index);
  FItems.Delete(Index);
end;

destructor TPreSale.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    Clear;
    FreeAndNil(FItems);
    FreeAndNil(FPreSaleInfo);
  end;
  inherited Destroy;
end;

function TPreSale.GetCostTotal: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    Result := Result + TruncDecimal(TPreSaleItem(FItems[I]).Cost * TPreSaleItem(FItems[I]).Qty, FRoundDecimalTo);
end;

function TPreSale.GetSuggestCount : Integer;
begin
  Result := FItemsSugg.Count;
end;

function TPreSale.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TPreSale.GetDiscountTotal: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    Result := Result + TPreSaleItem(FItems[I]).Discount;
end;

function TPreSale.GetItems(Index: Integer): TPreSaleItem;
begin
  Result := FItems[Index];
end;

function TPreSale.GetSaleTotal: Currency;
var
  I: Integer;
begin

  Result := 0;
  for I := 0 to FItems.Count - 1 do
    if (TPreSaleItem(FItems[I]).FTotalInformed <> 0) then
      Result := Result + TruncDecimal(TPreSaleItem(FItems[I]).TotalInformed, FRoundDecimalTo)
    else
      Result := Result + TruncDecimal(TPreSaleItem(FItems[I]).Sale * TPreSaleItem(FItems[I]).Qty, FRoundDecimalTo);

end;

function TPreSale.GetTaxTotal: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    Result := Result + (TPreSaleItem(FItems[I]).TaxValue);
end;

procedure TPreSale.RemovePreSaleItem(Index: Integer);
var
  PreSaleItem: TPreSaleItem;
begin
  PreSaleItem := FItems[Index];
  FreeAndNil(PreSaleItem);
end;

procedure TPreSale.SetItems(Index: Integer; const Value: TPreSaleItem);
begin
  FItems[Index] := Value;
end;

procedure TPreSale.UpdateValues;
begin
  // Esta é uma procedure legal. Não sei pra que ela serve
  // mas ainda vou descobrir :-)
end;

procedure TPreSale.ResetDiscount;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TPreSaleItem(FItems[I]).Discount := 0;
  FDiscountKind := dkNone;
end;

procedure TPreSale.ResetTax;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TPreSaleItem(FItems[I]).TaxValue := 0;
end;


function TPreSale.TestDiscountAdd(PSI: TPreSaleItem): Boolean;
var
  LucroItem,
  PercAplicado: Currency;
begin
  case PreSaleType of
    tptInvoice, tptLayAway:
      begin
        if not FSaleBelowCostPrice then
        begin
          Result := not (PSI.Sale < PSI.Cost);
          if not Result then
          begin
            MsgBox(MSG_INF_NOT_SELL_BELLOW_COST, vbCritical + vbOKOnly);
            Exit;
          end;

          //Verificar mais tarde
          //LucroItem := TruncDecimal((PSI.Sale - PSI.Cost - (PSI.Sale * PSI.TaxValue / 100)) * PSI.Qty, FRoundDecimalTo) - PSI.Discount;
          //Result := (LucroItem >= 0);
          //if not Result then
          //  Exit;
        end;


        // Atriubui a uma variavel currency, para nao haver erro na comparacao
        PercAplicado := 0;
        if PSI.Sale <> 0 then
          PercAplicado := (PSI.Discount / PSI.Sale * 100);

        Result    := PSI.PercMaxDisc >= PercAplicado;
        if not Result then
          if Assigned(FOnItemDiscount) then
            FOnItemDiscount(PSI, Result);
      end;
    tptRefund, tptExchange:
      Result := True;
    else
      Result := False;
  end;
end;

procedure TPreSale.Clear;
var
  I : integer;
  ItemSugg : TPreSaleItemSuggestion;
begin
  while FItems.Count > 0 do
    Delete(0);
  for I := 0 to FItemsSugg.Count-1 do
  begin
    ItemSugg := TPreSaleItemSuggestion(FItemsSugg.Objects[I]);
    FreeAndNil(ItemSugg);
  end;
  FItemsSugg.Clear;
  FIDPreSale := -1;
  FPreSaleInfo.UnSet;
  FInvoiceDiscount := 0;
  FECFAddedItems   := 0;
  FIDOtherComiss   := 0;
  FCOO             := '';
  FCCF             := '';
  FInvObs          := '';
  FPuppyTracker    := False;
  FDiscountKind    := dkNone;
  FSerialECF       := '';
  FPreSaleType     := tptInvoice;
  FImported        := False;
end;

function TPreSale.CalcDiscount(ADiscountType: TDiscountType;
   ADiscountValueType : TDiscountValueType; AValue: Currency): Currency;
var
  Fator : Integer;
  Falta, PercDiscount: Currency;
  ASaleTotal : Currency;
  AAccept : Boolean;
begin

  Falta := 0;
  PercDiscount := 0;

  case ADiscountType of
    tdtDesconto:
      Fator := 1;
    tdtAcrescimo:
      Fator := -1;
  end;

  case ADiscountValueType of
    dvtPerc:
      begin
        PercDiscount := AValue;
        PercDiscount := (PercDiscount * Fator) / 100;
        Falta := (GetSaleTotal - DiscountTotal) * PercDiscount;
        if PercDiscount >= 1 then
          raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);
      end;
    dvtValor:
      begin
        if PreSaleType = tptRefund Then
          Fator := Fator * -1;

        PercDiscount := (AValue / (GetSaleTotal - DiscountTotal)){ * 100};
        Falta := AValue * Fator;

        ASaleTotal := (GetSaleTotal - DiscountTotal);

        if PreSaleType = tptRefund Then
           ASaleTotal := ABS(ASaleTotal);

        if Falta >= ASaleTotal then
          raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);

      end;
  end;

  if Assigned(FBeforeDoInvoiceDiscount) then
    FBeforeDoInvoiceDiscount(PercDiscount * 100, AAccept);

  if not AAccept then
    raise Exception.Create(MSG_INF_INV_DISCOUNT_LIMT);

  FDiscountKind := dkInvoice;

  Falta := TruncDecimal(Falta, FRoundDecimalTo);

  Result := Falta;

end;

function TPreSale.DoDiscount(ADiscountType: TDiscountType;
  ADiscountValueType: TDiscountValueType; AValue: Currency): Boolean;
var
  I, Fator : Integer;
  Falta, PercDiscount: Currency;
  AItem: TPreSaleItem;
  FaltaTotal: Currency;
  AAccept : Boolean;
  ASaleTotal, Retirar, DescontoMaximo: Currency;
begin
  Result := True;
  try
    Falta := 0;

    PercDiscount := 0;
    Fator := 0;

    case ADiscountType of
      tdtDesconto:
        Fator := 1;
      tdtAcrescimo:
        Fator := -1;
    end;

    case ADiscountValueType of
      dvtPerc:
        begin
          PercDiscount := AValue;
          PercDiscount := (PercDiscount * Fator) / 100;
          Falta := GetSaleTotal * PercDiscount;
          if PercDiscount >= 1 then
            raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);
        end;
      dvtValor:
        begin
          if PreSaleType = tptRefund Then
            Fator := Fator * -1;

          PercDiscount := (AValue / GetSaleTotal){ * 100};
          Falta := AValue * Fator;

          ASaleTotal := GetSaleTotal;

          if PreSaleType = tptRefund Then
             ASaleTotal := ABS(ASaleTotal);

          if Falta >= ASaleTotal then
            raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);

        end;
    end;

    AAccept := False;
    if Assigned(FBeforeDoInvoiceDiscount) then
      FBeforeDoInvoiceDiscount(PercDiscount * 100, AAccept);

    if not AAccept then
      raise Exception.Create(MSG_INF_INV_DISCOUNT_LIMT);

    Falta := TruncDecimal(Falta, FRoundDecimalTo);

    FaltaTotal := Falta;

    for I := 0 to GetCount - 1 do
    begin
      AItem := FItems[I];
      if I = (GetCount - 1) then
        begin
          Retirar := Falta;
          if (ADiscountType = tdtAcrescimo) then
            DescontoMaximo := (AItem.Sale * AItem.Qty) * Fator 
          else
            DescontoMaximo := (AItem.Sale * AItem.Qty) * AItem.PercMaxDisc * Fator / 100;
          DescontoMaximo :=  TruncDecimal(DescontoMaximo, FRoundDecimalTo);
          if Abs(Retirar) > Abs(DescontoMaximo) then
            AItem.Discount := DescontoMaximo
          else
            AItem.Discount := Retirar;
        end
      else
        begin
          Retirar := (AItem.Sale * AItem.Qty) * PercDiscount * Fator;
          Retirar :=  TruncDecimal(Retirar, FRoundDecimalTo);

          DescontoMaximo := (AItem.Sale * AItem.Qty) * AItem.PercMaxDisc * Fator / 100;
          DescontoMaximo :=  TruncDecimal(DescontoMaximo, FRoundDecimalTo);

          if Abs(Retirar) > Abs(DescontoMaximo) then
            AItem.Discount := DescontoMaximo
          else
            AItem.Discount := Retirar;
        end;

      Falta := Falta - Retirar;
    end;

    if AValue = 0 then
      FDiscountKind := dkNone
    else
      FDiscountKind := dkInvoice;

    case ADiscountValueType of
      dvtPerc:
        FInvoiceDiscount := GetSaleTotal * PercDiscount;
      dvtValor:
        FInvoiceDiscount := FaltaTotal;
    end;

  except
    on E: Exception do
    begin
      MsgBox(E.Message, vbCritical+vbOKOnly);
      Result := False;
    end;
  end;
end;

function TPreSale.AddItemSuggestion(AModel, ADescription, AOBS: String;
  ASalePrice: Currency): Boolean;
var
  ItemSugg : TPreSaleItemSuggestion;
begin
 Result := FItemsSugg.IndexOf(AModel)=-1;

 if Result then
    begin
    ItemSugg := TPreSaleItemSuggestion.Create;
    with ItemSugg do
      begin
      FModel       := AModel;
      FDescription := ADescription;
      FOBS         := AOBS;
      FSalePrice   := ASalePrice;
      end;
    FItemsSugg.AddObject(AModel,ItemSugg);
    end;
end;

function TPreSale.GetSuggestItems(Index: Integer): TPreSaleItemSuggestion;
begin
  Result := TPreSaleItemSuggestion(FItemsSugg.Objects[Index]);
end;

function TPreSale.PrintedCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to GetCount - 1 do
  begin
    if GetItems(I).Printed then
      Inc(Result);
  end;
end;

function TPreSale.GetRefundTotal: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    if TPreSaleItem(FItems[I]).Qty < 0 then
      Result := Result + (TPreSaleItem(FItems[I]).Qty * TPreSaleItem(FItems[I]).FSale);
end;

function TPreSale.GetScaleDifference: Currency;
var
  I: Integer;
  cScaleTotal, cSaleTotal : Currency;
begin

  Result := 0;

  cScaleTotal := 0;
  cSaleTotal := 0;
  for I := 0 to FItems.Count - 1 do
    if (TPreSaleItem(FItems[I]).FTotalInformed <> 0) then
      cScaleTotal := cScaleTotal + TruncDecimal(TPreSaleItem(FItems[I]).TotalInformed, FRoundDecimalTo)
    else
      cScaleTotal := cScaleTotal + TruncDecimal(TPreSaleItem(FItems[I]).Sale * TPreSaleItem(FItems[I]).Qty, FRoundDecimalTo);

  for I := 0 to FItems.Count - 1 do
    cSaleTotal := cSaleTotal + TruncDecimal(TPreSaleItem(FItems[I]).Sale * TPreSaleItem(FItems[I]).Qty, FRoundDecimalTo);

  Result := (cSaleTotal - cScaleTotal);
  
end;

{ TPreSaleInfo }

constructor TPreSaleInfo.Create;
begin
  inherited Create;
  FCommissionGroup := nil;
  FCustomerInfo    := nil;
  FMediaInfo       := nil;
  FTouristGroup    := nil;
end;

destructor TPreSaleInfo.Destroy;
begin
  UnSet;
  inherited Destroy;
end;

procedure TPreSaleInfo.UnSet;
begin
  if FCommissionGroup <> nil then
    FreeAndNil(FCommissionGroup);

  if FCustomerInfo <> nil then
    FreeAndNil(FCustomerInfo);

  if FMediaInfo <> nil then
    FreeAndNil(FMediaInfo);

  if FTouristGroup <> nil then
    FreeAndNil(FTouristGroup);
end;

{ TPreSaleItem }

constructor TPreSaleItem.Create;
begin
  inherited Create;
  FSerialNumbers  := TList.Create;
end;

destructor TPreSaleItem.Destroy;
begin
  ClearSerialItems;
  FSerialNumbers.Free;
  inherited Destroy;
end;

procedure TPreSaleItem.ClearSerialItems;
var
  PIS: TPreSaleItemSerial;
  I : Integer;
begin
  for I := 0 to FSerialNumbers.Count - 1 do
  begin
    PIS := TPreSaleItemSerial(FSerialNumbers[I]);
    if PIS <> nil then
      FreeAndNil(PIS);
  end;
  FSerialNumbers.Clear;
end;

function TPreSaleItem.GetSerialNumbers(Index: Integer): TPreSaleItemSerial;
begin
  Result := TPreSaleItemSerial(FSerialNumbers[Index]);
end;

procedure TPreSaleItem.SetSerialNumbers(Index: Integer;
  const Value: TPreSaleItemSerial);
begin
  FSerialNumbers[Index] := Value;
end;

procedure TPreSaleItem.AddSerialNumber(ASerialNumber, AIdentificationNumber: String);
var
  PIS: TPreSaleItemSerial;
begin
  PIS := TPreSaleItemSerial.Create;
  PIS.SerialNumber := ASerialNumber;
  PIS.IdentificationNumber := AIdentificationNumber;
  AddSerialNumber(PIS);
end;

procedure TPreSaleItem.AddSerialNumber(APreSaleItemSerial: TPreSaleItemSerial);
begin
  FSerialNumbers.Add(APreSaleItemSerial);
end;


end.
