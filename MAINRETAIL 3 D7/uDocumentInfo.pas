unit uDocumentInfo;

interface

type
  TDocumentType = (dtInvoice, dtServiceOrder);


  TDocumentInfo = class
  private
    FLayAway: Boolean;
    FDocumentTotal: Currency;
    FIDTouristGroup: Integer;
    FIDCustomer: Integer;
    FID: Integer;
    FOtherComissionID: Integer;
    FIDStore: Integer;
    FDocumentType: TDocumentType;
    FNonpayer: Boolean;
    FStoreAccountLimit: Currency;
    FCustomerEmail: string;
    FCustomerCard: string;
  public
    property ID: Integer read FID write FID;
    property DocumentType: TDocumentType read FDocumentType write FDocumentType;
    property LayAway: Boolean read FLayAway write FLayAway;
    property IDCustomer: Integer read FIDCustomer write FIDCustomer;
    property IDStore: Integer read FIDStore write FIDStore;
    property IDTouristGroup: Integer read FIDTouristGroup write FIDTouristGroup;
    property OtherComissionID: Integer read FOtherComissionID write FOtherComissionID;
    property DocumentTotal: Currency read FDocumentTotal write FDocumentTotal;
    property StoreAccountLimit: Currency read FStoreAccountLimit write FStoreAccountLimit;
    property Nonpayer: Boolean read FNonpayer write FNonpayer;
    property CustomerEmail: string read FCustomerEmail write FCustomerEmail;
    property CustomerCard: string read FCustomerCard write FCustomerCard;  
  end;

implementation

end.
