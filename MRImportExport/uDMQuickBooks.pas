unit uDMQuickBooks;

interface

uses
  SysUtils, Classes, ibqcore, ibqcustomer, Dialogs, Windows, ibqobjsearch,
  ibqitem, Forms, Controls, ibqaccount, ibqinvoice, ibqsalesreceipt,
  ibqreceivepayment, ibqemployee, ibqtimetracking, ibqcreditmemo;

const
  CON_TYPE_DONT_CARE   = 0;
  CON_TYPE_SINGLE_USER = 1;
  CON_TYPE_MULTI_USER  = 2;

type
  TQBBasic = class
  end;


  TQBLoader = class(TQBBasic)
    private
      FibqObjSearch: TibqObjSearch;
    public
      constructor Create(Conn : String);
      destructor Destroy; override;

      function ResultItems : String;
      function ResultAccounts(AAccType : Integer) : String;
      function ResultPaymentMethod : String;
      function ResultPayroll : String;

      procedure SetConnectionStr(Conn : String);
  end;

  TQBItem = class(TQBBasic)
    private
      ibqItem       : TibqItem;
      FItemType     : TibqitemItemTypes;
      FItemName     : String;
      FDesc         : String;
      FPrice        : Currency;
      FAccount      : String;
      FSalesTaxCode : String;
      FQty          : Double;

      procedure SetItemType(const Value: TibqitemItemTypes);

    public
      constructor Create(con : String);
      destructor Destroy; override;

      property ItemName     : String            read FItemName     write FItemName;
      property Desc         : String            read FDesc         write FDesc;
      property ItemType     : TibqitemItemTypes read FItemType     write SetItemType;
      property SalesTaxCode : String            read FSalesTaxCode write FSalesTaxCode;
      property Price        : Currency          read FPrice        write FPrice;
      property Qty          : Double            read FQty          write FQty;
      property Account      : String            read FAccount      write FAccount;

      procedure SetConnectionStr(Conn : String);

      function InsertItem : Boolean;
      function AddItem : Boolean;
      function FindItem : Boolean;
  end;

  TQBCustomer = class(TQBBasic)
    private
      ibqCustomer: TibqCustomer;
      FCity: String;
      FCountry: String;
      FAddress: String;
      FContactName: String;
      FPhone: String;
      FFax: String;
      FEmail: String;
      FZip: String;
      FCustomerName: String;
      FState: String;
    public
      constructor Create(con : String);
      destructor Destroy; override;

      property CustomerName : String read FCustomerName write FCustomerName;
      property Address      : String read FAddress      write FAddress;
      property City         : String read FCity         write FCity;
      property State        : String read FState        write FState;
      property Zip          : String read FZip          write FZip;
      property Country      : String read FCountry      write FCountry;
      property ContactName  : String read FContactName  write FContactName;
      property Email        : String read FEmail        write FEmail;
      property Fax          : String read FFax          write FFax;
      property Phone        : String read FPhone        write FPhone;

      procedure SetConnectionStr(Conn : String);

      function AddCustomer : Boolean;
      function FindCustomer : Boolean;
  end;

  TQBEmployee = class(TQBBasic)
    private
      ibqEmployee : TibqEmployee;
      FEmployee : String;
      FPayroll: String;
    public
      constructor Create(con : String);
      destructor Destroy; override;

      property Employee : String read FEmployee write FEmployee;
      property Payroll  : String read FPayroll  write FPayroll;

      procedure SetConnectionStr(Conn : String);

      function AddEmployee : Boolean;
      function FindEmployee : Boolean;
  end;


  TQBPayment = class(TQBBasic)
    private
      ibqItem          : TibqItem;
      FAmount          : Currency;
      FRefNumber       : String;
      FTransactionDate : String;
      FCustomerName    : String;
      FPaymentMethod   : String;
      FDefaulPayment: String;
    public
      constructor Create(con : String);
      destructor Destroy; override;

      property CustomerName    : String    read FCustomerName    write FCustomerName;
      property Amount          : Currency  read FAmount          write FAmount;
      property PaymentMethod   : String    read FPaymentMethod   write FPaymentMethod;
      property TransactionDate : String    read FTransactionDate write FTransactionDate;
      property RefNumber       : String    read FRefNumber       write FRefNumber;
      property DefaulPayment   : String    read FDefaulPayment   write FDefaulPayment;

      function InsertPayment : Boolean;
      function AddPayment : Boolean;
      function FindPayment : Boolean;
  end;


  TQBTimeClock = class(TQBBasic)
    private
      FQBEmployee     : TQBEmployee;
      ibqTimeTracking : TibqTimeTracking;
      FEmployee       : String;
      FTransDate      : String;
      FDuration       : String;
      FPayroll        : String;
      FTransHour: String;
      procedure SetEmployee(const Value: String);
    procedure SetPayroll(const Value: String);
    public
      constructor Create(con : String);
      destructor Destroy; override;

      property Employee  : String read FEmployee  write SetEmployee;
      property Duration  : String read FDuration  write FDuration;
      property TransDate : String read FTransDate write FTransDate;
      property TransHour : String read FTransHour write FTransHour;
      property Payroll   : String read FPayroll   write SetPayroll;

      procedure SetConnectionStr(Conn : String);

      function AddTimeClock : Boolean;
      function FindTimeClock : Boolean;
  end;

  TQBInvoice = class(TQBBasic)
    private
      FQBCustomer      : TQBCustomer;
      FItems           : TStringList;
      FPayments        : TStringList;
      FQBItems         : TStringList;
      FQBPayments      : TStringList;
      FTransactionDate : String;
      FRefNumber       : String;
      FSalesTaxTotal: Currency;
      FRefund: Currency;
      FConn: String;

      procedure SetCustomerName(const Value: String);
      function GetCustomerName: String;
      function GetAddress: String;
      function GetCity: String;
      function GetContactName: String;
      function GetCountry: String;
      function GetEmail: String;
      function GetFax: String;
      function GetPhone: String;
      function GetState: String;
      function GetZip: String;
      procedure SetAddress(const Value: String);
      procedure SetCity(const Value: String);
      procedure SetContactName(const Value: String);
      procedure SetCountry(const Value: String);
      procedure SetEmail(const Value: String);
      procedure SetFax(const Value: String);
      procedure SetPhone(const Value: String);
      procedure SetState(const Value: String);
      procedure SetZip(const Value: String);

      procedure FreeItemList;
      procedure FreePaymentList;
      procedure LoadQBItems;
      procedure LoadQBPayments;
    public
      constructor Create(Con : String);
      destructor Destroy; override;

      property CustomerName    : String   read GetCustomerName  write SetCustomerName;
      property Address         : String   read GetAddress       write SetAddress;
      property City            : String   read GetCity          write SetCity;
      property State           : String   read GetState         write SetState;
      property Zip             : String   read GetZip           write SetZip;
      property Country         : String   read GetCountry       write SetCountry;
      property ContactName     : String   read GetContactName   write SetContactName;
      property Email           : String   read GetEmail         write SetEmail;
      property Fax             : String   read GetFax           write SetFax;
      property Phone           : String   read GetPhone         write SetPhone;

      property TransactionDate : String   read FTransactionDate write FTransactionDate;
      property RefNumber       : String   read FRefNumber       write FRefNumber;
      property SalesTaxTotal   : Currency read FSalesTaxTotal   write FSalesTaxTotal;

      property Conn            : String   read FConn            write FConn;
      property Refund          : Currency read FRefund          write FRefund;

      property SaleItems       : TStringList read FItems           write FItems;
      property Payments        : TStringList read FPayments        write FPayments;

      procedure SetConnectionStr(AConn : String); virtual;
  end;

  TQBSales = class(TQBInvoice)
    private
      ibqInvoice : TibqInvoice;
    protected
      function AddSaleItem(AQBItem : TQBItem; APos : Integer) : Boolean;
      function AddPayment(AQBPayment : TQBPayment): Boolean;
    public
      constructor Create(Con : String);
      destructor Destroy; override;

      procedure SetConnectionStr(Conn : String); override;
      procedure AppendPayment(AItemName, AAccount: String;
                   AAmount: Currency; AQty: Integer; AItemType : TibqitemItemTypes);
      procedure CreateItemAdjust(ADesc, AAccount : String);

      function Add : Boolean;
      function Find : Boolean;
  end;

  TQBCreditMemo = class(TQBInvoice)
    private
      ibqCreditMemo : TibqCreditMemo;
    protected
      function AddSaleItem(AQBItem : TQBItem; APos : Integer) : Boolean;
    public
      constructor Create(Con : String);
      destructor Destroy; override;

      procedure SetConnectionStr(Conn : String); override;

      procedure AppendCreditMemo(AItemName, AAccount: String;
                   AAmount: Currency; AQty: Integer; AItemType : TibqitemItemTypes);

      function Add : Boolean;
      function Find : Boolean;
  end;

  TDMQuickBooks = class(TDataModule)
    ibqCustomer  : TibqCustomer;
    ibqObjSearch : TibqObjSearch;
    ibqAccount   : TibqAccount;
    procedure DataModuleDestroy(Sender: TObject);
  private
    FConnectionMode  : Integer;
    FApplicationName : String;
    FCompanyFile     : String;
    function FormatAccountType(AAccType : TibqaccountAccountTypes) : String;
  public
    function GetConnectionString : String;
    function Connect : Boolean;

    function GetAccountByType(AAccType : Integer) : String;
    function GetPaymentMethod : String;
    function GetPayrollList : String;

    function AddHoursToDate(ADate : TDateTime; AHours : String) : TDateTime;

    property ConnectionMode : Integer read FConnectionMode write FConnectionMode;
    property ApplicationName : String read FApplicationName write FApplicationName;
    property CompanyFile : String read FCompanyFile write FCompanyFile;
  end;

implementation

uses uStringFunctions, uDateTimeFunctions, DateUtils;

{$R *.dfm}

{ TDMQuickBooks }

function TDMQuickBooks.Connect: Boolean;
begin
  try
    ibqCustomer.QBConnectionString := '';

    ibqCustomer.QBConnectionString := GetConnectionString;

    {
    case ConnectionMode of
      CON_TYPE_DONT_CARE   : ibqCustomer.QBConnectionMode := cmDontCare;
      CON_TYPE_SINGLE_USER : ibqCustomer.QBConnectionMode := cmSingleUserMode;
      CON_TYPE_MULTI_USER  : ibqCustomer.QBConnectionMode := cmMultiUserMode;
    end;
    }

    ibqCustomer.OpenQBConnection;
    Result := True;

  except
    on E : EibqCustomer do
    begin
      MessageDlg('Exception ' + E.Message, mtInformation, [mbOk], 0);
      Result := False;
    end;
  end;
end;

function TDMQuickBooks.FormatAccountType(
  AAccType: TibqaccountAccountTypes): String;
begin
  case AAccType of
    atUnspecified           : Result := 'Unspecified';
    atAccountsPayable       : Result := 'Accounts Payable';
    atAccountsReceivable    : Result := 'Accounts Receivable';
    atBank                  : Result := 'Bank';
    atCostOfGoodsSold       : Result := 'Cost Of Goods Sold';
    atCreditCard            : Result := 'CreditCard';
    atEquity                : Result := 'Equity';
    atExpense               : Result := 'Expense';
    atFixedAsset            : Result := 'Fixed Asset';
    atIncome                : Result := 'Income';
    atLongTermLiability     : Result := 'Long Term Liability';
    atOtherAsset            : Result := 'Other Asset';
    atOtherCurrentAsset     : Result := 'Other Current Asset';
    atOtherCurrentLiability : Result := 'Other Current Liability';
    atOtherExpense          : Result := 'Other Expense';
    atOtherIncome           : Result := 'Other Income';
    atNonPosting            : Result := 'Non Posting';
  end;
end;

function TDMQuickBooks.GetAccountByType(AAccType: Integer): String;
var
  FList : TStringList;
  i : Integer;
begin

  ibqObjSearch.QueryType := qtAccountSearch;
  ibqObjSearch.QBConnectionString := GetConnectionString;

  FList := TStringList.Create;
  try
    Screen.Cursor := crHourGlass;
    ibqObjSearch.Search();

    for i := 0 to ibqObjSearch.ResultCount - 1 do
    begin
      ibqAccount.Reset();
      ibqAccount.QBResponseAggregate := ibqObjSearch.ResultAggregate[i];
      Flist.Add(IncSpaces(ibqAccount.AccountName, 35) + ' [' + FormatAccountType(ibqAccount.AccountType)  + ']');
    end;

    Result := FList.Text;
  finally
    FreeAndNil(FList);
    Screen.Cursor := crDefault;
  end;

end;

function TDMQuickBooks.GetConnectionString: String;
begin

  Result := '';

  if FApplicationName <> '' then
    Result := Result + 'ApplicationName= "' + FApplicationName + '"';

  if FCompanyFile <> '' then
    Result := Result + 'CompanyFile= "' + FCompanyFile + '"';

end;

function TDMQuickBooks.GetPaymentMethod: String;
var
  FQBLoader : TQBLoader;
begin

  FQBLoader := TQBLoader.Create(GetConnectionString);
  try
    Result := FQBLoader.ResultPaymentMethod;
  finally
    FreeAndNil(FQBLoader);
  end;

end;

function TDMQuickBooks.GetPayrollList: String;
var
  FQBLoader : TQBLoader;
begin

  FQBLoader := TQBLoader.Create(GetConnectionString);
  try
    Result := FQBLoader.ResultPayroll;
  finally
    FreeAndNil(FQBLoader);
  end;

end;

function TDMQuickBooks.AddHoursToDate(ADate: TDateTime;
  AHours: String): TDateTime;
var
  iHour, iMinute : Integer;
begin

  iHour   := StrToInt(Copy(AHours, 0, Pos(':',AHours)-1 ));
  iMinute := StrToInt(Copy(AHours, Pos(':',AHours)+1, length(AHours) ));

  ADate := AddHours(ADate, iHour);
  ADate := AddMinutes(ADate, iMinute);

  Result := ADate;

end;

{ TQBItem }

function TQBItem.AddItem: Boolean;
begin

  Result := True;

  if not FindItem then
    Result := InsertItem;

end;

function TQBItem.FindItem: Boolean;
begin

  try
    ibqItem.GetByName(FItemName);
    Result := True;
  except
    Result := False;
    end;

end;


constructor TQBItem.Create(con : String);
begin
  ibqItem := TibqItem.Create(nil);
  ibqItem.ItemType := itNonInventory;
  ibqItem.QBConnectionString := con;
end;

destructor TQBItem.Destroy;
begin
  FreeAndNil(ibqItem);
  inherited;
end;

procedure TQBItem.SetConnectionStr(Conn: String);
begin
  ibqItem.QBConnectionString := Conn;
end;

procedure TQBItem.SetItemType(const Value: TibqitemItemTypes);
begin
  FItemType := Value;
  ibqItem.ItemType := FItemType;
end;

function TQBItem.InsertItem: Boolean;
begin

  Result := True;

  try
    ibqItem.ItemName       := FItemName;
    ibqItem.Description    := FDesc;
    ibqItem.SalesTaxCodeId := FSalesTaxCode;
    ibqItem.Price          := 0;
    ibqItem.AccountName    := FAccount;
    ibqItem.Add;

    Result := True;
  except
    Result := False;
    end;

end;

{ TQBCustomer }

function TQBCustomer.AddCustomer: Boolean;
begin

  Result := True;

  if (FCustomerName <> '') and (not FindCustomer) then
  try
    ibqCustomer.Reset;
    ibqCustomer.CustomerName   := FCustomerName;
    ibqCustomer.ContactName    := FContactName;
    ibqCustomer.Phone          := FPhone;
    ibqCustomer.Fax            := FFax;
    ibqCustomer.Email          := FEmail;
    ibqCustomer.BillingAddress := '<Addr1>'      + FAddress + '</Addr1>' +
                                  '<City>'       + FCity    + '</City>' +
                                  '<State>'      + FState   + '</State>' +
                                  '<PostalCode>' + FZip     + '</PostalCode>' +
                                  '<Country>'    + FCountry + '</Country>';
    ibqCustomer.Add;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TQBCustomer.Create(con : String);
begin
  ibqCustomer := TibqCustomer.Create(nil);
  ibqCustomer.QBConnectionString := con;
end;

destructor TQBCustomer.Destroy;
begin
  FreeAndNil(ibqCustomer);
  inherited;
end;

function TQBCustomer.FindCustomer: Boolean;
var
  ibqObjSearch: TibqObjSearch;
begin

  try

    ibqObjSearch := TibqObjSearch.Create(nil);

    try
      ibqObjSearch.QueryType := qtCustomerSearch;
      ibqObjSearch.NameStartsWith := FCustomerName;

      ibqObjSearch.QBConnectionString := ibqCustomer.QBConnectionString;
      ibqObjSearch.Search;

      Result := (ibqObjSearch.ResultCount > 0);
    finally
      FreeAndNil(ibqObjSearch);
    end;
  except
    Result := False;
  end;

end;


procedure TQBCustomer.SetConnectionStr(Conn: String);
begin
  ibqCustomer.QBConnectionString := Conn;
end;

{ TQBInvoice }

constructor TQBInvoice.Create(Con : String);
begin
  FConn := Con;
  FQBCustomer := TQBCustomer.Create(Con);
  FItems := TStringList.Create;
  FPayments := TStringList.Create;
  FQBItems := TStringList.Create;
  FQBPayments := TStringList.Create;
  LoadQBItems;
  LoadQBPayments;
end;

destructor TQBInvoice.Destroy;
begin
  FreeAndNil(FQBCustomer);
  FreeItemList;
  FreeAndNil(FItems);
  FreePaymentList;
  FreeAndNil(FPayments);
  FreeAndNil(FQBPayments);
  FreeAndNil(FQBItems);
  inherited;
end;

procedure TQBInvoice.FreeItemList;
var
  Obj : TObject;
begin

  while FItems.Count > 0 do
  begin
    Obj := FItems.Objects[0];
    if Obj <> nil then
    begin
      FreeAndNil(Obj);
      FItems.Objects[0] := nil;
    end;
    FItems.Delete(0);
  end;

  FItems.Clear;

end;

procedure TQBInvoice.FreePaymentList;
var
  Obj : TObject;
begin

  while FPayments.Count > 0 do
  begin
    Obj := FPayments.Objects[0];
    if Obj <> nil then
    begin
      FreeAndNil(Obj);
      FPayments.Objects[0] := nil;
    end;
    FPayments.Delete(0);
  end;

  FPayments.Clear;

end;

function TQBInvoice.GetAddress: String;
begin
  Result := FQBCustomer.Address;
end;

function TQBInvoice.GetCity: String;
begin
  Result := FQBCustomer.City;
end;

function TQBInvoice.GetContactName: String;
begin
  Result := FQBCustomer.ContactName;
end;

function TQBInvoice.GetCountry: String;
begin
  Result := FQBCustomer.Country;
end;

function TQBInvoice.GetCustomerName: String;
begin
  Result := FQBCustomer.CustomerName;
end;

function TQBInvoice.GetEmail: String;
begin
  Result := FQBCustomer.Email;
end;

function TQBInvoice.GetFax: String;
begin
  Result := FQBCustomer.Fax;
end;

function TQBInvoice.GetPhone: String;
begin
  Result := FQBCustomer.Phone;
end;

function TQBInvoice.GetState: String;
begin
  Result := FQBCustomer.State;
end;

function TQBInvoice.GetZip: String;
begin
  Result := FQBCustomer.Zip;
end;

procedure TQBInvoice.LoadQBItems;
var
  FQBLoader : TQBLoader;
begin
  FQBLoader := TQBLoader.Create(FConn);
  try
    FQBItems.Clear;
    FQBLoader.SetConnectionStr(FConn);
    FQBItems.Text := FQBLoader.ResultItems;
  finally
    FreeAndNil(FQBLoader);
  end;
end;

procedure TQBInvoice.LoadQBPayments;
var
  FQBLoader : TQBLoader;
begin

  FQBLoader := TQBLoader.Create(FConn);
  try
    FQBPayments.Clear;
    FQBLoader.SetConnectionStr(FConn);
    FQBPayments.Text := FQBLoader.ResultPaymentMethod;
  finally
    FreeAndNil(FQBLoader);
  end;

end;

procedure TQBInvoice.SetAddress(const Value: String);
begin
  FQBCustomer.Address := Value;
end;

procedure TQBInvoice.SetCity(const Value: String);
begin
  FQBCustomer.City := Value;
end;

procedure TQBInvoice.SetConnectionStr(AConn: String);
begin
  FConn := AConn;
end;

procedure TQBInvoice.SetContactName(const Value: String);
begin
  FQBCustomer.ContactName := Value;
end;

procedure TQBInvoice.SetCountry(const Value: String);
begin
  FQBCustomer.Country := Value;
end;

procedure TQBInvoice.SetCustomerName(const Value: String);
begin
  FQBCustomer.CustomerName := Value;
end;

procedure TQBInvoice.SetEmail(const Value: String);
begin
  FQBCustomer.Email := Value;
end;

procedure TQBInvoice.SetFax(const Value: String);
begin
  FQBCustomer.Fax := Value;
end;

procedure TQBInvoice.SetPhone(const Value: String);
begin
  FQBCustomer.Phone := Value;
end;

procedure TQBInvoice.SetState(const Value: String);
begin
  FQBCustomer.State := Value;
end;

procedure TQBInvoice.SetZip(const Value: String);
begin
  FQBCustomer.Zip := Value;
end;

{ TQBLoader }

constructor TQBLoader.Create(Conn : String);
begin
  FibqObjSearch := TibqObjSearch.Create(nil);
  FibqObjSearch.QBConnectionString := Conn;
end;

destructor TQBLoader.Destroy;
begin
  FreeAndNil(FibqObjSearch);
  inherited;
end;

function TQBLoader.ResultAccounts(AAccType: Integer): String;
var
  ibqAccount : TibqAccount;
  FList : TStringList;
  i : Integer;
begin

  FibqObjSearch.QueryType := qtAccountSearch;

  ibqAccount := TibqAccount.Create(nil);
  try

    FList := TStringList.Create;
    try
      Screen.Cursor := crHourGlass;
      FibqObjSearch.Search();

      for i := 0 to FibqObjSearch.ResultCount - 1 do
      begin
        ibqAccount.Reset();
        ibqAccount.QBResponseAggregate := FibqObjSearch.ResultAggregate[i];
        Flist.Add(ibqAccount.AccountName);
      end;

      Result := FList.Text;
    finally
      FreeAndNil(FList);
    end;

  finally
    FreeAndNil(ibqAccount);
    Screen.Cursor := crDefault;
  end;

end;

function TQBLoader.ResultItems: String;
var
  ibqItem: TibqItem;
  FList : TStringList;
  i : Integer;
begin

  FibqObjSearch.QueryType := qtItemSearch;

  ibqItem := TibqItem.Create(nil);
  try
    FList := TStringList.Create;
    try
      Screen.Cursor := crHourGlass;
      FibqObjSearch.Search();

      for i := 0 to FibqObjSearch.ResultCount - 1 do
      begin
        ibqItem.Reset();
        ibqItem.QBResponseAggregate := FibqObjSearch.ResultAggregate[i];
        FList.Add(ibqItem.Description);
      end;

      Result := FList.Text;
    finally
      FreeAndNil(FList);
    end;
  finally
    FreeAndNil(ibqItem);
    Screen.Cursor := crDefault;
  end;

end;

function TQBLoader.ResultPaymentMethod: String;
var
  FList : TStringList;
  i : Integer;
  sPayment : String;
begin

  FibqObjSearch.QueryType := qtPaymentMethod;

  try
    FList := TStringList.Create;
    try
      Screen.Cursor := crHourGlass;
      FibqObjSearch.Search();

      for i := 0 to FibqObjSearch.ResultCount - 1 do
      begin
        sPayment := FibqObjSearch.ResultAggregate[i];
        sPayment := Copy(sPayment, Pos('<Name>', sPayment) + 6, Length(sPayment));
        sPayment := Copy(sPayment, 0, Pos('</Name>', sPayment)-1);

        FList.Add(sPayment);
      end;

      Result := FList.Text;
    finally
      FreeAndNil(FList);
    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

function TQBLoader.ResultPayroll: String;
var
  sResult : String;
  FList : TStringList;
  i : Integer;
begin

  FibqObjSearch.QueryType := qtPayrollItemWage;

  try
    FList := TStringList.Create;
    try
      Screen.Cursor := crHourGlass;
      FibqObjSearch.Search();

      for i := 0 to FibqObjSearch.ResultCount - 1 do
      begin
        sResult := FibqObjSearch.ResultAggregate[i];
        FList.Add(sResult);
      end;

      Result := FList.Text;
    finally
      FreeAndNil(FList);
    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TQBLoader.SetConnectionStr(Conn: String);
begin
  FibqObjSearch.QBConnectionString := Conn;
end;

procedure TDMQuickBooks.DataModuleDestroy(Sender: TObject);
begin
  ibqCustomer.CloseQBConnection;
end;


{ TQBEmployee }

function TQBEmployee.AddEmployee: Boolean;
begin

  Result := True;

  if not FindEmployee then
  try
    ibqEmployee.Reset;
    ibqEmployee.EmployeeName := FEmployee;
    if FPayroll = '' then
    begin
      ibqEmployee.UseTimeDataToCreatePaychecks := tdDoNotUseTimeData;
    end
    else
    begin
      ibqEmployee.UseTimeDataToCreatePaychecks := tdUseTimeData;
      ibqEmployee.PayrollClassName             := FPayroll;
    end;

    ibqEmployee.Add;
    Result := True;
  except
    Result := False;
  end;

end;

constructor TQBEmployee.Create(con : String);
begin
  ibqEmployee := TibqEmployee.Create(nil);
  ibqEmployee.QBConnectionString := con;
end;

destructor TQBEmployee.Destroy;
begin
  FreeAndNil(ibqEmployee);
  inherited;
end;

function TQBEmployee.FindEmployee: Boolean;
var
  ibqObjSearch: TibqObjSearch;
begin

  try

    ibqObjSearch := TibqObjSearch.Create(nil);

    try
      ibqObjSearch.Reset;
      ibqObjSearch.QueryType      := qtEmployeeSearch;
      ibqObjSearch.NameStartsWith := FEmployee;
      ibqObjSearch.NameEndsWith   := FEmployee;

      ibqObjSearch.QBConnectionString := ibqEmployee.QBConnectionString;
      ibqObjSearch.Search;

      Result := (ibqObjSearch.ResultCount > 0);
    finally
      FreeAndNil(ibqObjSearch);
    end;
  except
    Result := False;
  end;
  
end;

procedure TQBEmployee.SetConnectionStr(Conn: String);
begin
  ibqEmployee.QBConnectionString := Conn;
end;

{ TQBTimeClock }

function TQBTimeClock.AddTimeClock: Boolean;
begin

  if FQBEmployee.AddEmployee then
    if not FindTimeClock then
      begin
      ibqTimeTracking.Reset;
      ibqTimeTracking.EmployeeName    := FEmployee;
      ibqTimeTracking.TransactionDate := FTransDate;
      ibqTimeTracking.Duration        := FDuration;
      ibqTimeTracking.IsBillable      := False;

      ibqTimeTracking.Add;
      end;

  Result := True;

end;

constructor TQBTimeClock.Create(con : String);
begin
  ibqTimeTracking := TibqTimeTracking.Create(nil);
  FQBEmployee     := TQBEmployee.Create(con);
  ibqTimeTracking.QBConnectionString := con;
end;

destructor TQBTimeClock.Destroy;
begin
  FreeAndNil(FQBEmployee);
  FreeAndNil(ibqTimeTracking);
  inherited;
end;

function TQBTimeClock.FindTimeClock: Boolean;
var
  ibqObjSearch: TibqObjSearch;
begin

  try

    ibqObjSearch := TibqObjSearch.Create(nil);

    try
      ibqObjSearch.Reset;
      ibqObjSearch.QueryType := qtTimeTrackingSearch;

      ibqObjSearch.TransactionDateStart := FTransDate;
      ibqObjSearch.EntityName           := FEmployee;

      ibqObjSearch.QBConnectionString := ibqTimeTracking.QBConnectionString;
      ibqObjSearch.Search;

      Result := (ibqObjSearch.ResultCount > 0);
    finally
      FreeAndNil(ibqObjSearch);
    end;
  except
    Result := False;
  end;

end;

procedure TQBTimeClock.SetConnectionStr(Conn: String);
begin
  ibqTimeTracking.QBConnectionString := Conn;
end;

procedure TQBTimeClock.SetEmployee(const Value: String);
begin
  FEmployee := Value;
  FQBEmployee.Employee := FEmployee;
end;

procedure TQBTimeClock.SetPayroll(const Value: String);
begin
  FPayroll := Value;
  FQBEmployee.Payroll := FPayroll;
end;

{ TQBPayment }

function TQBPayment.AddPayment: Boolean;
begin

  Result := True;

  if not FindPayment then
    Result := InsertPayment;

end;

constructor TQBPayment.Create(con: String);
begin
  ibqItem := TibqItem.Create(nil);
  ibqItem.QBConnectionString := con;
  ibqItem.ItemType := itPayment;
end;

destructor TQBPayment.Destroy;
begin
  FreeAndNil(ibqItem);
  inherited;
end;

function TQBPayment.FindPayment: Boolean;
begin
  try
    ibqItem.GetByName(FPaymentMethod);
    Result := True;
  except
    Result := False;
    end;
end;

function TQBPayment.InsertPayment: Boolean;
begin

  Result := True;

  try
    ibqItem.ItemName       := PaymentMethod;
    ibqItem.Description    := PaymentMethod;
    ibqItem.Price          := 0;
    ibqItem.Add;

    Result := True;
  except
    Result := False;
    end;

end;

{ TQBSales }

function TQBSales.Add: Boolean;
var
  i : Integer;
begin

  try
    if not Find then
      if FQBCustomer.AddCustomer then
      begin
        ibqInvoice.Reset;
        ibqInvoice.CustomerName    := FQBCustomer.CustomerName;
        ibqInvoice.TransactionDate := FTransactionDate;
        ibqInvoice.RefNumber       := FRefNumber;
        ibqInvoice.ItemCount       := FItems.Count;

        for i := 0 to FItems.Count-1 do
         if FItems.Objects[i] <> nil then
           AddSaleItem(TQBItem(FItems.Objects[i]), i);

        if (FItems.Count > 0) then
          ibqInvoice.Add;

        try
          for i := 0 to FPayments.Count-1 do
            if FPayments.Objects[i] <> nil then
              AddPayment(TQBPayment(FPayments.Objects[i]));

        finally
         FreePaymentList;
         end;
      end;
  finally
   FreeItemList;
   end;

  Result := True;

end;

function TQBSales.AddPayment(AQBPayment: TQBPayment): Boolean;
var
  Fibqreceivepayment : Tibqreceivepayment;
begin
  Result := True;

  try
  
    if FQBPayments.IndexOf(AQBPayment.FPaymentMethod) = -1 then
    begin
      AQBPayment.FPaymentMethod := AQBPayment.DefaulPayment;
      //AQBPayment.AddPayment;
      //FQBPayments.Add(AQBPayment.FPaymentMethod);
    end;

    Fibqreceivepayment := Tibqreceivepayment.Create(nil);
    try
      Fibqreceivepayment.QBConnectionString := ibqInvoice.QBConnectionString;
      Fibqreceivepayment.CustomerName       := AQBPayment.CustomerName;
      Fibqreceivepayment.RefNumber          := AQBPayment.RefNumber;
      Fibqreceivepayment.TransactionDate    := AQBPayment.TransactionDate;
      Fibqreceivepayment.PaymentMethodName  := AQBPayment.PaymentMethod;
      Fibqreceivepayment.Amount             := Trunc(100 * AQBPayment.Amount);

      Fibqreceivepayment.Add;
    finally
      FreeAndNil(Fibqreceivepayment);
    end;
  except
    result := False;
  end;

end;


function TQBSales.AddSaleItem(AQBItem: TQBItem; APos: Integer): Boolean;
begin

  Result := True;

  if (FQBItems.IndexOf(AQBItem.Desc) = -1) and (AQBItem.ItemType <> itPayment) then
  begin
    Result := AQBItem.AddItem;
    FQBItems.Add(AQBItem.Desc);
  end;

  if Result then
  begin
    ibqInvoice.ItemName[APos] := AQBItem.Desc;
    ibqInvoice.Config('Items['+IntToStr(APos)+'].Rate='+FormatFloat('0.00',AQBItem.Price));
    //ibqInvoice.Config('Items['+IntToStr(APos)+'].Amount='+FormatFloat('0.00',AQBItem.Price));
    //ibqInvoice.Config('Items['+IntToStr(APos)+'].Quantity='+FormatFloat('0.00',AQBItem.Qty));
  end;

end;

procedure TQBSales.AppendPayment(AItemName, AAccount: String;
  AAmount: Currency; AQty: Integer; AItemType : TibqitemItemTypes);
var
  FQBItem : TQBItem;
begin
  if SaleItems.IndexOf(AItemName) = -1 then
  begin
    FQBItem := TQBItem.Create(Conn);
    FQBItem.ItemName := AItemName;
    FQBItem.Desc     := AItemName;
    FQBItem.Price    := AAmount;
    FQBItem.Account  := AAccount;
    FQBItem.Qty      := AQty;
    FQBItem.ItemType := AItemType;
    SaleItems.AddObject(AItemName, FQBItem);
  end
  else
  begin
    FQbItem := TQBItem(SaleItems.Objects[SaleItems.IndexOf(AItemName)]);
    FQbItem.Price := FQbItem.Price + AAmount;
  end;
end;

constructor TQBSales.Create(Con: String);
begin
  inherited Create(Con);
  ibqInvoice := TibqInvoice.Create(nil);
  ibqInvoice.QBConnectionString := Con;
end;

procedure TQBSales.CreateItemAdjust(ADesc, AAccount : String);
var
  FQBItem : TQBItem;
  i : Integer;
  cItemTotal, cPaymentTotal, cBalance : Currency;
begin

  cItemTotal := 0;
  cPaymentTotal := 0;

  for i := 0 to SaleItems.Count - 1 do
  begin
    FQbItem := TQBItem(SaleItems.Objects[i]);
    Case FQbItem.ItemType of
      itNonInventory : cItemTotal := cItemTotal + FQbItem.Price;
      itPayment : cPaymentTotal := cPaymentTotal + (FQbItem.Price * -1);
    end;
  end;

  if cPaymentTotal > cItemTotal then
    cBalance := ABS(cItemTotal - cPaymentTotal)
  else
    cBalance := ABS(cItemTotal - cPaymentTotal) * -1;

  if (cBalance <> 0) then
    AppendPayment(ADesc, AAccount, cBalance, 1, itNonInventory);

end;

destructor TQBSales.Destroy;
begin
  FreeAndNil(ibqInvoice);
  inherited;
end;

function TQBSales.Find: Boolean;
var
  ibqObjSearch: TibqObjSearch;
begin

  try

    ibqObjSearch := TibqObjSearch.Create(nil);

    try
      ibqObjSearch.QueryType := qtInvoiceSearch;
      ibqObjSearch.RefNumber := RefNumber;

      ibqObjSearch.QBConnectionString := Conn;
      ibqObjSearch.Search;

      Result := (ibqObjSearch.ResultCount > 0);
    finally
      FreeAndNil(ibqObjSearch);
    end;
  except
    Result := False;
  end;

end;

procedure TQBSales.SetConnectionStr(Conn: String);
begin
  inherited;
  ibqInvoice.QBConnectionString := Conn;
end;

{ TQBCreditMemo }

function TQBCreditMemo.Add: Boolean;
var
  i : Integer;
begin

  try
    if not Find then
      if FQBCustomer.AddCustomer then
      begin
        ibqCreditMemo.Reset;
        ibqCreditMemo.CustomerName    := FQBCustomer.CustomerName;
        ibqCreditMemo.TransactionDate := FTransactionDate;
        ibqCreditMemo.RefNumber       := FRefNumber;
        ibqCreditMemo.ItemCount       := FItems.Count;

        for i := 0 to FItems.Count-1 do
         if FItems.Objects[i] <> nil then
           AddSaleItem(TQBItem(FItems.Objects[i]), i);

        if FItems.Count > 0 then
          ibqCreditMemo.Add;

      end;
  finally
   FreeItemList;
   end;

  Result := True;

end;


function TQBCreditMemo.AddSaleItem(AQBItem: TQBItem;
  APos: Integer): Boolean;
begin

  Result := True;

  if FQBItems.IndexOf(AQBItem.Desc) = -1 then
  begin
    Result := AQBItem.AddItem;
    FQBItems.Add(AQBItem.Desc);
  end;

  if Result then
  begin
    ibqCreditMemo.ItemName[APos] := AQBItem.Desc;
    ibqCreditMemo.Config('Items['+IntToStr(APos)+'].Rate='+FormatFloat('0.00', AQBItem.Price));
  end;


end;

procedure TQBCreditMemo.AppendCreditMemo(AItemName, AAccount: String;
  AAmount: Currency; AQty: Integer; AItemType: TibqitemItemTypes);
var
  FQBItem : TQBItem;
begin
  if SaleItems.IndexOf(AItemName) = -1 then
  begin
    FQBItem := TQBItem.Create(Conn);
    FQBItem.ItemName := AItemName;
    FQBItem.Desc     := AItemName;
    FQBItem.Price    := AAmount;
    FQBItem.Account  := AAccount;
    FQBItem.Qty      := AQty;
    FQBItem.ItemType := AItemType;
    SaleItems.AddObject(AItemName, FQBItem);
  end
  else
  begin
    FQbItem := TQBItem(SaleItems.Objects[SaleItems.IndexOf(AItemName)]);
    FQbItem.Price := FQbItem.Price + AAmount;
  end;
end;

constructor TQBCreditMemo.Create(Con: String);
begin
  inherited Create(Con);
  ibqCreditMemo := TibqCreditMemo.Create(nil);
  ibqCreditMemo.QBConnectionString := Con;
end;

destructor TQBCreditMemo.Destroy;
begin
  FreeAndNil(ibqCreditMemo);
  inherited;
end;

function TQBCreditMemo.Find: Boolean;
var
  ibqObjSearch: TibqObjSearch;
begin

  try

    ibqObjSearch := TibqObjSearch.Create(nil);

    try
      ibqObjSearch.QueryType := qtCreditMemoSearch;
      ibqObjSearch.RefNumber := RefNumber;

      ibqObjSearch.QBConnectionString := Conn;
      ibqObjSearch.Search;

      Result := (ibqObjSearch.ResultCount > 0);
    finally
      FreeAndNil(ibqObjSearch);
    end;
  except
    Result := False;
  end;

end;

procedure TQBCreditMemo.SetConnectionStr(Conn: String);
begin
  inherited;
  ibqCreditMemo.QBConnectionString := Conn;
end;

end.
