unit uTXTCashInfo;

interface

uses Classes, SysUtils, uFilePersistence;

type
  TOpenCash = class
    Rec: TRegOpenCash;
  end;

  TOpenSale = class
    Rec: TRegOpenSale;
  end;

  TAddCustomer = class
    Rec: TRegAddCustomer;
  end;

  TAddItem = class
    Rec: TRegAddItem;
  end;

  TAddPayment = class
    Rec: TRegAddPayment;
  end;

  TAddPC = class
    Rec: TRegAddPC;
  end;

  TAddWC = class
    Rec: TRegAddWC;
  end;

  TCloseSale = class
    Rec: TRegCloseSale;
  end;

  TCloseCash = class
    Rec: TRegCloseCash;
  end;

  TCancelSale = class
    Rec: TRegCancelSale;
  end;

  TLogHolder = class
    RegType: TSaleLineType;
    RegObject: TObject;
  end;

  TRemovedItem = class
    Rec: TRegRemovedItem;
  end;

  TCupomVinculado = class
    Rec: TRegCupomVinculado;
  end;

  TAddSerialNumber = class
    Rec: TRegSerialNumber;
  end;

  TOBS = class
    Rec: TRegOBS;
  end;

  TTXTCashInfo = class
  private
    FFileName: String;
    FLines: TStringList;
    FTempTotal: TStringList;
    FSaleLineParser: TSaleLineParser;
    FStatus: Integer;
    FOpenDate: TDateTime;
    FWidrawTotalCheck: Currency;
    FWidrawTotalOther: Currency;
    FWidrawTotalCard: Currency;
    FWidrawTotalDebit: Currency;
    FWidrawTotalCash: Currency;
    FWidrawTotalPreCard: Currency;
    FSaleTotalPreCard: Currency;
    FSaleTotalCard: Currency;
    FSaleTotalDebit: Currency;
    FSaleTotalCash: Currency;
    FSaleTotalCheck: Currency;
    FSaleTotalOther: Currency;
    FOpenTotalPreCard: Currency;
    FOpenTotalCard: Currency;
    FOpenTotalDebit: Currency;
    FOpenTotalCheck: Currency;
    FOpenTotalOther: Currency;
    FOpenTotalCount: Currency;
    FOpenTotalCash: Currency;
    FPettyCashTotal: Currency;
    FIDCashReg: Integer;
    FCOOCanceled: Boolean;
    FCOO: String;
    FIDOpenUser: Integer;
    FCloseBill100: Integer;
    FCloseCoin050: Integer;
    FCloseCoin005: Integer;
    FCloseCoin001: Integer;
    FOpenBill10: Integer;
    FCloseCoin025: Integer;
    FOpenBill2: Integer;
    FOpenBill1: Integer;
    FCloseBill10: Integer;
    FOpenBill5: Integer;
    FOpenBill50: Integer;
    FOpenCoin1: Integer;
    FCloseBill20: Integer;
    FCloseBill1: Integer;
    FCloseBill5: Integer;
    FOpenCoin010: Integer;
    FCloseBill2: Integer;
    FCloseBill50: Integer;
    FCloseCoin1: Integer;
    FOpenCoin001: Integer;
    FOpenCoin005: Integer;
    FOpenBill20: Integer;
    FCloseCoin010: Integer;
    FOpenCoin025: Integer;
    FOpenBill100: Integer;
    FOpenCoin050: Integer;
    FIDCloseUser: Integer;
    FResetAfterClose: Boolean;
    FCloseDate: TDateTime;
    FCloseTotalPreCard: Currency;
    FCloseTotalCard: Currency;
    FCloseTotalDebit: Currency;
    FCloseTotalCash: Currency;
    FCloseTotalCheck: Currency;
    FCloseTotalOther: Currency;
    FCurrFiscalTotalCard: Currency;
    FCurrFiscalTotalCheck: Currency;
    FCurrFiscalTotalPreCard: Currency;
    FCurrFiscalTotalOther: Currency;
    FCurrFiscalTotalDebit: Currency;
    FCurrFiscalTotalCash: Currency;
    FLastSaleIsFiscal: Boolean;
    FCancFiscalTotalPreCard: Currency;
    FCancFiscalTotalCard: Currency;
    FCancFiscalTotalCash: Currency;
    FCancFiscalTotalCheck: Currency;
    FCancFiscalTotalOther: Currency;
    FCancFiscalTotalDebit: Currency;
    FLastTotalPreCard: Currency;
    FLastTotalCard: Currency;
    FLastTotalCash: Currency;
    FLastTotalCheck: Currency;
    FLastTotalOther: Currency;
    FLastTotalDebit: Currency;
    FLogList: TList;
    function RegisterLine(ALine: String): Boolean;

    function ReadOpenCash(ALine: String): Boolean;
    function ReadOpenSale(ALine: String): Boolean;
    function ReadAddItem(ALine: String): Boolean;
    function ReadAddPayment(ALine: String): Boolean;
    function ReadCloseSale(ALine: String): Boolean;
    function ReadCloseCash(ALine: String): Boolean;
    function ReadAddCustomer(ALine: String): Boolean;
    function ReadWC(ALine: String): Boolean;
    function ReadPC(ALine: String): Boolean;
    function ReadCancelSale(ALine: String): Boolean;
    function ReadDeleteItem(ALine: String): Boolean;
    function ReadAbortedSale(Aline: String): Boolean;
    function ReadCancelItem(Aline: String):Boolean;
    function ReadAddSerialNumber(Aline: String):Boolean;
    function ReadOBS(Aline: String):Boolean;
    function ReadCupomVinculado(Aline: String):Boolean;
    function AddReducaoZ(ALine: String): Boolean;
    function AddTotParcial(ALine: String): Boolean;
    procedure ResetInfo;
    function GetSaleTotal: Currency;
    function GetWidrawTotal: Currency;
    function GetOpenTotal: Currency;
    function GetCancFiscalTotal: Currency;
    procedure LoadLinesFromFile(const FileName: string);
    procedure ResetCurrFiscal;
    procedure ResetCurrCancel;

    procedure AddRecHolder(ARegType: TSaleLineType; ARec: TObject);

    procedure AddTempTotal(ARAP: TAddPayment);
    procedure CancelTempTotal;
    procedure ClearTempTotal;
  public
    property FileName: String read FFileName write FFileName;
    property ResetAfterClose: Boolean read FResetAfterClose write FResetAfterClose;


    property Status:                      Integer   read FStatus;
    property IDOpenUser:                  Integer   read FIDOpenUser;
    property OpenTotalCount:              Currency  read FOpenTotalCount;
    property OpenTotalCash:               Currency  read FOpenTotalCash;
    property OpenTotalCard:               Currency  read FOpenTotalCard;
    property OpenTotalDebit:              Currency  read FOpenTotalDebit;
    property OpenTotalPreCard:            Currency  read FOpenTotalPreCard;
    property OpenTotalCheck:              Currency  read FOpenTotalCheck;
    property OpenTotalOther:              Currency  read FOpenTotalOther;
    property OpenDate:                    TDateTime read FOpenDate;

    property IDCashReg:                   Integer   read FIDCashReg;

    property WidrawTotalCash:             Currency  read FWidrawTotalCash;
    property WidrawTotalCard:             Currency  read FWidrawTotalCard;
    property WidrawTotalDebit:            Currency  read FWidrawTotalDebit;
    property WidrawTotalPreCard:          Currency  read FWidrawTotalPreCard;
    property WidrawTotalCheck:            Currency  read FWidrawTotalCheck;
    property WidrawTotalOther:            Currency  read FWidrawTotalOther;

    property SaleTotalCash:               Currency  read FSaleTotalCash;
    property SaleTotalCard:               Currency  read FSaleTotalCard;
    property SaleTotalDebit:              Currency  read FSaleTotalDebit;
    property SaleTotalPreCard:            Currency  read FSaleTotalPreCard;
    property SaleTotalCheck:              Currency  read FSaleTotalCheck;
    property SaleTotalOther:              Currency  read FSaleTotalOther;


    property CurrFiscalTotalCash:         Currency  read FCurrFiscalTotalCash;
    property CurrFiscalTotalCard:         Currency  read FCurrFiscalTotalCard;
    property CurrFiscalTotalPreCard:      Currency  read FCurrFiscalTotalPreCard;
    property CurrFiscalTotalCheck:        Currency  read FCurrFiscalTotalCheck;
    property CurrFiscalTotalOther:        Currency  read FCurrFiscalTotalOther;
    property CurrFiscalTotalDebit:        Currency  read FCurrFiscalTotalDebit;

    property OpenBill100:                 Integer   read FOpenBill100;
    property OpenBill50:                  Integer   read FOpenBill50;
    property OpenBill20:                  Integer   read FOpenBill20;
    property OpenBill10:                  Integer   read FOpenBill10;
    property OpenBill5:                   Integer   read FOpenBill5;
    property OpenBill2:                   Integer   read FOpenBill2;
    property OpenBill1:                   Integer   read FOpenBill1;
    property OpenCoin001:                 Integer   read FOpenCoin001;
    property OpenCoin005:                 Integer   read FOpenCoin005;
    property OpenCoin010:                 Integer   read FOpenCoin010;
    property OpenCoin025:                 Integer   read FOpenCoin025;
    property OpenCoin050:                 Integer   read FOpenCoin050;
    property OpenCoin1:                   Integer   read FOpenCoin1;

    property IDCloseUser:                 Integer   read FIDCloseUser;
    property CloseBill100:                Integer   read FCloseBill100;
    property CloseBill50:                 Integer   read FCloseBill50;
    property CloseBill20:                 Integer   read FCloseBill20;
    property CloseBill10:                 Integer   read FCloseBill10;
    property CloseBill5:                  Integer   read FCloseBill5;
    property CloseBill2:                  Integer   read FCloseBill2;
    property CloseBill1:                  Integer   read FCloseBill1;
    property CloseCoin001:                Integer   read FCloseCoin001;
    property CloseCoin005:                Integer   read FCloseCoin005;
    property CloseCoin010:                Integer   read FCloseCoin010;
    property CloseCoin025:                Integer   read FCloseCoin025;
    property CloseCoin050:                Integer   read FCloseCoin050;
    property CloseCoin1:                  Integer   read FCloseCoin1;

    property CloseTotalCash:              Currency  read FCloseTotalCash;
    property CloseTotalCard:              Currency  read FCloseTotalCard;
    property CloseTotalDebit:             Currency  read FCloseTotalDebit;
    property CloseTotalPreCard:           Currency  read FCloseTotalPreCard;
    property CloseTotalCheck:             Currency  read FCloseTotalCheck;
    property CloseTotalOther:             Currency  read FCloseTotalOther;

    property CancFiscalTotalCash:         Currency  read FCancFiscalTotalCash;
    property CancFiscalTotalCard:         Currency  read FCancFiscalTotalCard;
    property CancFiscalTotalPreCard:      Currency  read FCancFiscalTotalPreCard;
    property CancFiscalTotalCheck:        Currency  read FCancFiscalTotalCheck;
    property CancFiscalTotalOther:        Currency  read FCancFiscalTotalOther;
    property CancFiscalTotalDebit:        Currency  read FCancFiscalTotalDebit;


    property CloseDate:                   TDateTime read FCloseDate;

    property COO:                         String    read FCOO;
    property COOCanceled:                 Boolean   read FCOOCanceled;

    property SaleTotal:                   Currency  read GetSaleTotal;
    property WidrawTotal:                 Currency  read GetWidrawTotal;
    property OpenTotal:                   Currency  read GetOpenTotal;
    property CancFiscalTotal:             Currency  read GetCancFiscalTotal;
    property PettyCashTotal:              Currency  read FPettyCashTotal;

    property LastSaleIsFiscal:            Boolean   read FLastSaleIsFiscal;

    property LogList:                     TList     read FLogList;
    property Lines:                       TStringList read FLines write FLines;

    constructor Create;
    destructor Destroy;override;

    function Load: Boolean;
  end;

implementation

uses uSystemConst, uFileFunctions;

{ TTXTCashInfo }


procedure TTXTCashInfo.AddRecHolder(ARegType: TSaleLineType; ARec: TObject);
var
  ALogHolder: TLogHolder;
begin
  ALogHolder := TLogHolder.Create;
  ALogHolder.RegType   := ARegType;
  ALogHolder.RegObject := ARec;
  FLogList.Add(ALogHolder);
end;


procedure TTXTCashInfo.ResetCurrCancel;
begin
  FLastTotalPreCard := 0;
  FLastTotalCard    := 0;
  FLastTotalCash    := 0;
  FLastTotalCheck   := 0;
  FLastTotalOther   := 0;
  FLastTotalDebit   := 0;
end;

procedure TTXTCashInfo.ResetCurrFiscal;
begin
  FCurrFiscalTotalCash    := 0;
  FCurrFiscalTotalCard    := 0;
  FCurrFiscalTotalPreCard := 0;
  FCurrFiscalTotalCheck   := 0;
  FCurrFiscalTotalOther   := 0;
  FCurrFiscalTotalDebit   := 0;
end;

procedure TTXTCashInfo.ResetInfo;
begin
  FStatus             := ST_CASHREG_CLOSE;
  ResetCurrFiscal;
  ResetCurrCancel;

  FOpenTotalOther     := 0;
  FOpenTotalCount     := 0;
  FOpenTotalCash      := 0;
  FOpenTotalCheck     := 0;
  FOpenTotalCard      := 0;
  FOpenTotalDebit     := 0;
  FOpenTotalPreCard   := 0;

  FCloseTotalOther     := 0;
  FCloseTotalCash      := 0;
  FCloseTotalCheck     := 0;
  FCloseTotalCard      := 0;
  FCloseTotalDebit     := 0;
  FCloseTotalPreCard   := 0;


  FWidrawTotalCash    := 0;
  FWidrawTotalCard    := 0;
  FWidrawTotalDebit   := 0;
  FWidrawTotalPreCard := 0;
  FWidrawTotalCheck   := 0;
  FWidrawTotalOther   := 0;

  FSaleTotalPreCard   := 0;
  FSaleTotalCard      := 0;
  FSaleTotalDebit     := 0;
  FSaleTotalCash      := 0;
  FSaleTotalCheck     := 0;
  FSaleTotalOther     := 0;


  FCancFiscalTotalCash    := 0;
  FCancFiscalTotalCard    := 0;
  FCancFiscalTotalPreCard := 0;
  FCancFiscalTotalCheck   := 0;
  FCancFiscalTotalOther   := 0;
  FCancFiscalTotalDebit   := 0;

  FPettyCashTotal     := 0;

  FCOO                := '';
  FCOOCanceled        := True;

  FOpenDate           := 0;
  FCloseDate          := 0;


  FIDOpenUser         := -1;
  FIDCloseUser        := -1;

  FLogList.Clear;
end;

function TTXTCashInfo.ReadAddCustomer(ALine: String): Boolean;
var
  RAC: TRegAddCustomer;
  AAddCustomer: TAddCustomer;
begin
  Result := True;
  try
    FSaleLineParser.GetAddCustomer(ALine, RAC);

    AAddCustomer     := TAddCustomer.Create;
    AAddCustomer.Rec := RAC;
    AddRecHolder(sltAddCustomer, AAddCustomer);

  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadCancelItem(Aline: String):Boolean;
begin
  Result := True;
  try
    AddRecHolder(sltCancelItem, nil);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadAbortedSale(Aline: String): Boolean;
begin
  Result := True;
  try

    if FLastTotalCash <> 0 then
      FSaleTotalCash := FSaleTotalCash - FLastTotalCash;

    if FLastTotalPreCard <> 0 then
      FSaleTotalPreCard := FSaleTotalPreCard - FLastTotalPreCard;

    if FLastTotalCard <> 0 then
      FSaleTotalCard := FSaleTotalCard - FLastTotalCard;

    if FLastTotalCheck <> 0 then
      FSaleTotalCheck := FSaleTotalCheck - FLastTotalCheck;

    if FLastTotalOther <> 0 then
      FSaleTotalOther := FSaleTotalOther - FLastTotalOther;

    if FLastTotalDebit <> 0 then
      FSaleTotalDebit := FSaleTotalDebit - FLastTotalDebit;

    AddRecHolder(sltAbortSale, nil);

    if (FCOO <> '') then
    begin
      ResetCurrFiscal;
      FCOOCanceled := True;
      FCOO := '';
    end;

  except
    Result := False;
  end;
end;


function TTXTCashInfo.ReadDeleteItem(ALine: String): Boolean;
var
  RRI: TRegRemovedItem;
  ARemovedItem : TRemovedItem;
begin
  Result := True;
  try

    FSaleLineParser.GetRemovedItem(Aline, RRI);

    ARemovedItem := TRemovedItem.Create;
    ARemovedItem.Rec := RRI;
    AddRecHolder(sltRemovedItem, ARemovedItem);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadOBS(Aline: String):Boolean;
var
  ROBS : TRegOBS;
  AOBS : TOBS;
begin
  Result := True;
  try
    FSaleLineParser.GetOBS(Aline, ROBS);
    AOBS := TOBS.Create;
    AOBS.Rec := ROBS;
    AddRecHolder(sltOBS, AOBS);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadAddSerialNumber(Aline: String):Boolean;
var
 RSN : TRegSerialNumber;
 AAddSerialNumber : TAddSerialNumber;
begin
  Result := True;
  try

    FSaleLineParser.GetAddSerialNumber(Aline, RSN);

    AAddSerialNumber := TAddSerialNumber.Create;
    AAddSerialNumber.Rec := RSN;
    AddRecHolder(sltAddSerialNumber, AAddSerialNumber);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadAddItem(ALine: String): Boolean;
var
  RAI: TRegAddItem;
  AAddItem : TAddItem;
begin
  Result := True;
  try

    FSaleLineParser.GetAddItem(Aline, RAI);

    AAddItem := TAddItem.Create;
    AAddItem.Rec := RAI;
    AddRecHolder(sltAddItem, AAddItem);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadAddPayment(ALine: String): Boolean;
var
  RAP: TRegAddPayment;
  AAddPayment: TAddPayment;
begin
  Result := True;
  try
    FSaleLineParser.GetAddPayment(ALine, RAP);

    AAddPayment := TAddPayment.Create;
    AAddPayment.Rec := RAP;
    AddRecHolder(sltAddPayment, AAddPayment);

    AddTempTotal(AAddPayment);

    case RAP.APayType of
      PAYMENT_TYPE_CASH:
        FLastTotalCash := FLastTotalCash + RAP.ATotalInvoice;

      PAYMENT_TYPE_CARD:
        if RAP.AIsPreDatado then
          FLastTotalPreCard := FLastTotalPreCard + RAP.ATotalInvoice
        else
          FLastTotalCard := FLastTotalCard + RAP.ATotalInvoice;

      PAYMENT_TYPE_OTHER,
      PAYMENT_TYPE_CREDIT:
        FLastTotalOther := FLastTotalOther + FLastTotalOther;

      PAYMENT_TYPE_CHECK:
        FLastTotalCheck := FLastTotalCheck + RAP.ATotalInvoice;

      PAYMENT_TYPE_DEBIT:
        FLastTotalDebit := FLastTotalDebit +  RAP.ATotalInvoice;
    end;

    //Revisar com o Carlos
    if FLastSaleIsFiscal then
    begin
      case RAP.APayType of

        PAYMENT_TYPE_CASH:
          FCurrFiscalTotalCash := FCurrFiscalTotalCash + RAP.ATotalInvoice;

        PAYMENT_TYPE_CARD:
          if RAP.AIsPreDatado then
            FCurrFiscalTotalPreCard := FCurrFiscalTotalPreCard + RAP.ATotalInvoice
          else
            FCurrFiscalTotalCard := FCurrFiscalTotalCard + RAP.ATotalInvoice;

        PAYMENT_TYPE_OTHER:
          FCurrFiscalTotalOther := FCurrFiscalTotalOther + RAP.ATotalInvoice;

        PAYMENT_TYPE_DEBIT:
          FCurrFiscalTotalDebit := FCurrFiscalTotalDebit + RAP.ATotalInvoice;

        PAYMENT_TYPE_CHECK:
          FCurrFiscalTotalCheck := FCurrFiscalTotalCheck + RAP.ATotalInvoice;
          
      end;
    end;

  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadCloseCash(ALine: String): Boolean;
var
  RCC: TRegCloseCash;
  ACloseCash: TCloseCash;
begin
  Result := True;
  try
    FSaleLineParser.GetCloseCash(ALine, RCC);

    ACloseCash := TCloseCash.Create;
    ACloseCash.Rec := RCC;
    AddRecHolder(sltCloseCash, ACloseCash);

    FCloseDate           := RCC.ADate;
    FIDCloseUser         := RCC.AIDUser;

    FCloseTotalOther     := RCC.ATotalOther;
    FCloseTotalCash      := RCC.ATotalCash;
    FCloseTotalCheck     := RCC.ATotalCheck;
    FCloseTotalCard      := RCC.ATotalCard;
    FCloseTotalDebit     := RCC.ATotalDebit;
    FCloseTotalPreCard   := RCC.ATotalPreCard;

    FCloseBill100        := RCC.A100;
    FCloseBill50         := RCC.A50;
    FCloseBill20         := RCC.A20;
    FCloseBill10         := RCC.A10;
    FCloseBill5          := RCC.A05;
    FCloseBill2          := RCC.A02;
    FCloseBill1          := RCC.A01;
    FCloseCoin001        := RCC.A001;
    FCloseCoin005        := RCC.A005;
    FCloseCoin010        := RCC.A010;
    FCloseCoin025        := RCC.A025;
    FCloseCoin050        := RCC.A050;
    FCloseCoin1          := RCC.A0100;



    FStatus := ST_CASHREG_CLOSE;
    if FResetAfterClose then
      ResetInfo;
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadCloseSale(ALine: String): Boolean;
var
  RCS: TRegCloseSale;
  ACloseSale: TCloseSale;
begin
  Result := True;
  try
    //Colcado aqui para adicionar os pagamentos multiplos
    AddTempTotal(nil);
    FSaleLineParser.GetCloseSale(Aline, RCS);
    ACloseSale := TCloseSale.Create;
    ACloseSale.Rec := RCS;
    AddRecHolder(sltCloseSale, ACloseSale);

  except
    Result := False;
  end;
end;

constructor TTXTCashInfo.Create;
begin
  inherited Create;
  FLines           := TStringList.Create;
  FTempTotal       := TStringList.Create;
  FSaleLineParser  := TSaleLineParser.Create;
  FResetAfterClose := False;
  FLogList         := TList.Create;
end;

procedure TTXTCashInfo.AddTempTotal(ARAP: TAddPayment);
var
  TempRAP: TAddPayment;
  i : Integer;
begin

  for i := 0 to FTempTotal.Count-1 do
    case TAddPayment(FTempTotal.Objects[i]).Rec.APayType of
      PAYMENT_TYPE_CASH:
        FSaleTotalCash := FSaleTotalCash + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice;

      PAYMENT_TYPE_CARD:
        if TAddPayment(FTempTotal.Objects[i]).Rec.AIsPreDatado then
          FSaleTotalPreCard := FSaleTotalPreCard + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice
        else
          FSaleTotalCard := FSaleTotalCard + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice;

      PAYMENT_TYPE_DEBIT:
         FSaleTotalDebit := FSaleTotalDebit + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice;

      PAYMENT_TYPE_OTHER,
      PAYMENT_TYPE_CREDIT:
        FSaleTotalOther := FSaleTotalOther + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice;

      PAYMENT_TYPE_CHECK:
        FSaleTotalCheck := FSaleTotalCheck + TAddPayment(FTempTotal.Objects[i]).Rec.ATotalInvoice;
    end;

  ClearTempTotal;

  if Assigned(ARAP) then
  begin
    TempRAP     := TAddPayment.Create;
    TempRAP.Rec := ARAP.Rec;
    FTempTotal.AddObject('',TempRAP);
  end;
end;

procedure TTXTCashInfo.CancelTempTotal;
begin
  ClearTempTotal;
end;

procedure TTXTCashInfo.ClearTempTotal;
var
  ARAP: TAddPayment;
begin
  while FTempTotal.Count <> 0 do
  begin
    if FTempTotal.Objects[0] <> nil then
    begin
      ARAP := TAddPayment(FTempTotal.Objects[0]);
      FreeAndNil(ARAP);
    end;
    FTempTotal.Delete(0);
  end;
end;

destructor TTXTCashInfo.Destroy;
begin
  FLines.Free;
  ClearTempTotal;
  FTempTotal.Free;
  FSaleLineParser.Free;
  FLogList.Free;
  inherited Destroy;
end;

function TTXTCashInfo.Load: Boolean;
var
  I : Integer;
begin
  Result := True;
  try
    ResetInfo;
    if FileName = '' then
      Exit;
    LoadLinesFromFile(FFileName);
    for I := 0 to FLines.Count - 1 do
    begin
      Result := RegisterLine(FLines[I]);
      if not Result then
        Exit;
    end;
    AddTempTotal(nil);
  except
    Result := False;
  end;
end;

procedure TTXTCashInfo.LoadLinesFromFile(const FileName: string);
var
  Stream: TStream;
  //f:TextFile;
  //Linha:String;
begin
  {
  AssignFile(f, FileName);
  try
    Reset(f);
    While not Eof(f) do
    begin
      Readln(f, Linha);
      FLines.Add(Linha);
    end;
  finally
    CloseFile(f);
    end;
  }

  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    FLines.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
  
end;


function TTXTCashInfo.ReadCancelSale(ALine: String): Boolean;
var
  RCC: TRegCancelSale;
  ACancelSale: TCancelSale;
begin
  Result := True;
  try
    FSaleLineParser.GetCancelSale(ALine, RCC);

    // Estes campos não são preenchidos no
    // método TSaleLineParser.GetCancelSale
    RCC.ACash    := FCurrFiscalTotalCash;
    RCC.ACard    := FCurrFiscalTotalCard;
    RCC.APreCard := FCurrFiscalTotalPreCard;
    RCC.ACheck   := FCurrFiscalTotalCheck;
    RCC.AOther   := FCurrFiscalTotalOther + FCurrFiscalTotalDebit;

    //Adcionado para remover o saldo do fechamento do caixa 
    FSaleTotalCash    := FSaleTotalCash - FCurrFiscalTotalCash;
    FSaleTotalCard    := FSaleTotalCard - FCurrFiscalTotalCard;
    FSaleTotalPreCard := FSaleTotalPreCard - FCurrFiscalTotalPreCard;
    FSaleTotalCheck   := FSaleTotalCheck - FCurrFiscalTotalCheck;
    FSaleTotalOther   := FSaleTotalOther - FCurrFiscalTotalOther;
    FSaleTotalDebit   := FSaleTotalDebit - FCurrFiscalTotalDebit;

    ACancelSale := TCancelSale.Create;
    ACancelSale.Rec := RCC;

    AddRecHolder(sltCancelSale, ACancelSale);

    FCOOCanceled := True;

    CancelTempTotal;

    ResetCurrFiscal;

    FLastSaleIsFiscal :=  (FCOO <> '');
    if FLastSaleIsFiscal then
      ResetCurrFiscal;
  except
    Result := False;
  end;
end;


function TTXTCashInfo.ReadOpenCash(ALine: String): Boolean;
var
  ROC: TRegOpenCash;
  AOpenCash: TOpenCash;
begin
  Result := True;
  try
    FSaleLineParser.GetOpenCash(ALine, ROC);

    AOpenCash     := TOpenCash.Create;
    AOpenCash.Rec := ROC;
    AddRecHolder(sltOpenCash, AOpenCash);

    FStatus           := ST_CASHREG_OPEN;
    FOpenTotalOther   := ROC.ATotalOther;
    FOpenTotalCount   := ROC.ATotalCount;
    FOpenTotalCash    := ROC.ATotalCash;
    FOpenTotalCheck   := ROC.ATotalCheck;
    FOpenTotalCard    := ROC.ATotalCard;
    FOpenTotalDebit   := ROC.ATotalDebit;
    FOpenTotalPreCard := ROC.ATotalPreCard;
    FOpenDate         := ROC.ADate;
    FIDCashReg        := ROC.AIDCashReg;
    FIDOpenUser       := ROC.AIDUser;

    FOpenBill100      := ROC.A100;
    FOpenBill50       := ROC.A50;
    FOpenBill20       := ROC.A20;
    FOpenBill10       := ROC.A10;
    FOpenBill5        := ROC.A05;
    FOpenBill2        := ROC.A02;
    FOpenBill1        := ROC.A01;
    FOpenCoin001      := ROC.A001;
    FOpenCoin005      := ROC.A005;
    FOpenCoin010      := ROC.A010;
    FOpenCoin025      := ROC.A025;
    FOpenCoin050      := ROC.A050;
    FOpenCoin1        := ROC.A0100;
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadOpenSale(ALine: String): Boolean;
var
  ROS: TRegOpenSale;
  AOpenSale: TOpenSale;
begin
  Result := True;
  try
    FSaleLineParser.GetOpenSale(ALine, ROS);

    AOpenSale := TOpenSale.Create;
    AOpenSale.Rec := ROS;
    AddRecHolder(sltOpenSale, AOpenSale);

    FCOO         := ROS.ACOO;

    ResetCurrCancel;

    FLastSaleIsFiscal :=  (FCOO <> '');

    if FLastSaleIsFiscal then
    begin
      ResetCurrFiscal;
      FCOOCanceled := False;
    end;
    
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadPC(ALine: String): Boolean;
var
  RAPC: TRegAddPC;
  AAddPC: TAddPC;
begin
  Result := True;
  try
    FSaleLineParser.GetAddPC(ALine, RAPC);

    AAddPC := TAddPC.Create;
    AAddPC.Rec := RAPC;
    AddRecHolder(sltPC, AAddPC);

    FPettyCashTotal := FPettyCashTotal + RAPC.ACash;
  except
    Result := False;
  end;
end;

function TTXTCashInfo.RegisterLine(ALine: String): Boolean;
begin
  Result := True;
  try
    case FSaleLineParser.LineType(ALine) of
      sltUnknow:
        Result := False;
      sltOpenCash:        Result := ReadOpenCash(ALine);
      sltOpenSale:        Result := ReadOpenSale(ALine);
      sltAddItem:         Result := ReadAddItem(ALine);
      sltAddPayment:      Result := ReadAddPayment(ALine);
      sltCloseSale:       Result := ReadCloseSale(ALine);
      sltCloseCash:       Result := ReadCloseCash(ALine);
      sltAddCustomer:     Result := ReadAddCustomer(ALine);
      sltCancelSale:      Result := ReadCancelSale(ALine);
      sltWC:              Result := ReadWC(ALine);
      sltPC:              Result := ReadPC(ALine);
      sltRemovedItem:     Result := ReadDeleteItem(ALine);
      sltAbortSale:       Result := ReadAbortedSale(ALine);
      sltCancelItem:      Result := ReadCancelItem(ALine);
      sltAddSerialNumber: Result := ReadAddSerialNumber(ALine);
      sltOBS:             Result := ReadOBS(ALine);
      sltReducaoZ:        Result := AddReducaoZ(ALine);
      sltCupomVinculado:  Result := ReadCupomVinculado(ALine);
      sltTotParcial:      Result := AddTotParcial(ALine);
    end;
  except
    Result := False;
  end;
end;


function TTXTCashInfo.ReadWC(ALine: String): Boolean;
var
  RAWC: TRegAddWC;
  AAddWC: TAddWC;
begin
  Result := True;
  try
    FSaleLineParser.GetAddWC(ALine, RAWC);
    AAddWC := TAddWC.Create;
    AAddWC.Rec := RAWC;
    AddRecHolder(sltWC, AAddWC);


    FWidrawTotalCash    := FWidrawTotalCash    + RAWC.ATotalCash;
    FWidrawTotalCard    := FWidrawTotalCard    + RAWC.ATotalCard;
    FWidrawTotalPreCard := FWidrawTotalPreCard + RAWC.ATotalPreCard;
    FWidrawTotalCheck   := FWidrawTotalCheck   + RAWC.ATotalCheck;
    FWidrawTotalOther   := FWidrawTotalOther   + RAWC.ATotalOther;
    FWidrawTotalDebit   := FWidrawTotalDebit   + RAWC.ATotalDebit;
  except
    Result := False;
  end;
end;

function TTXTCashInfo.GetSaleTotal: Currency;
begin
  Result :=
    FSaleTotalCash +
    FSaleTotalCard +
    FSaleTotalPreCard +
    FSaleTotalCheck +
    FSaleTotalOther +
    FSaleTotalDebit;
end;

function TTXTCashInfo.GetWidrawTotal: Currency;
begin
  Result :=
    FWidrawTotalCash +
    FWidrawTotalCard +
    FWidrawTotalDebit +
    FWidrawTotalPreCard +
    FWidrawTotalCheck +
    FWidrawTotalOther;
end;

function TTXTCashInfo.GetOpenTotal: Currency;
begin
  Result :=
    FOpenTotalOther +
    FOpenTotalCash  +
    FOpenTotalCheck +
    FOpenTotalCard  +
    FOpenTotalDebit +
    FOpenTotalPreCard;
end;

function TTXTCashInfo.GetCancFiscalTotal: Currency;
begin
  Result :=
    FCancFiscalTotalCash     +
    FCancFiscalTotalCard     +
    FCancFiscalTotalPreCard  +
    FCancFiscalTotalCheck    +
    FCancFiscalTotalDebit    +
    FCancFiscalTotalOther;
end;

function TTXTCashInfo.AddReducaoZ(ALine: String): Boolean;
begin
  Result := True;
  try
    AddRecHolder(sltReducaoZ, nil);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.ReadCupomVinculado(Aline: String): Boolean;
var
  RCVinc : TRegCupomVinculado;
  ACVinc : TCupomVinculado;
begin
  Result := True;
  try
    FSaleLineParser.GetCupomVinculado(Aline, RCVinc);
    ACVinc := TCupomVinculado.Create;
    ACVinc.Rec := RCVinc;
    AddRecHolder(sltCupomVinculado, ACVinc);
  except
    Result := False;
  end;
end;

function TTXTCashInfo.AddTotParcial(ALine: String): Boolean;
begin
  Result := True;
  try
    AddRecHolder(sltTotParcial, nil);
  except
    Result := False;
  end;
end;

end.
