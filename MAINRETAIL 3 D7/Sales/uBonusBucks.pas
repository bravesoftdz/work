unit uBonusBucks;

interface

uses ADOdb, DateUtils, uGynboSyncClasses;

const
  BONUS_BUCKS_PREFIX = 'BB';

type
  TDiscountPercList = array of Double;

  TBonusBucksControl = class
  private
    FADOConnection: TADOConnection;
    FIDModel: Integer;
    FIDStore: Integer;
    FDiscountValue: Currency;
    FSellingPrice: Currency;

    function GetModelDiscountPerc: Double;
    function GetCalendarDiscountPerc: TDiscountPercList;
    function GetBestDiscountPerc: Double;
    procedure SetDiscountValue;
  public
    function GetDiscountValue: Currency;

    property ADOConnection: TADOConnection read FADOConnection write FADOConnection;
    property IDStore: Integer read FIDStore write FIDStore;
    property IDModel: Integer read FIDModel write FIDModel;
    property SellingPrice: Currency read FSellingPrice write FSellingPrice;
  end;

  TBonusBucks = class
  private
    FADOConnection: TADOConnection;
    FIDPreSaleCreated: Integer;
    FIDPreSaleUsed: Integer;
    FDiscountValue: Currency;
    FCreatedDate: TDateTime;
    FBonusBucksControl: TBonusBucksControl;
    FValidFromDate: TDateTime;
    FExpirationDate: TDateTime;
    FBonusCode: String;
    FErrorMsg: String;
    FBonusSync : TbgBonusSync;

    function GetBonusBuckRedeemedPerc: Double;
    function GetDiscountValue: Currency;
    procedure CalcBonusBucks;
    function IsExpiredCupon: Boolean;
    function IsValidCupon: Boolean;

  public
    constructor Create(AADOConnection: TADOConnection; ABonusSync : TbgBonusSync);
    destructor Destroy; override;
    procedure LoadBySaleUsed(AIDPreSaleUsed: Integer);
    procedure LoadByCupom(ACupom: String);
    procedure SetUsed(AIDPreSaleUsed : Integer; ABonusCode: String);
    procedure UndoSetUsed(AIDPreSaleUsed: Integer);
    function ValidateCoupon: Boolean;
    function HasPayment: Boolean;

    property ADOConnection: TADOConnection read FADOConnection write FADOConnection;
    property IDPreSaleCreated: Integer read FIDPreSaleCreated write FIDPreSaleCreated;
    property IDPreSaleUsed: Integer read FIDPreSaleUsed write FIDPreSaleUsed;
    property DiscountValue: Currency read GetDiscountValue write FDiscountValue;
    property ValidCupon: Boolean read IsValidCupon;
    property ExpiredCupon: Boolean read IsExpiredCupon;
    property ErrorMsg: String read FErrorMsg write FErrorMsg;
    property BonusCode: String read FBonusCode write FBonusCode;
    property BonusSync : TbgBonusSync  read FBonusSync write FBonusSync;
  end;

implementation

uses DB, SysUtils, uMsgConstant, uNumericFunctions;

{ TBonusBucksControl }

function TBonusBucksControl.GetBestDiscountPerc: Double;
var
  i: Integer;
  aCalendarDiscountPerc: TDiscountPercList;
begin
  Result := GetModelDiscountPerc;
  aCalendarDiscountPerc := GetCalendarDiscountPerc;

  for i := 0 to Pred(Length(aCalendarDiscountPerc)) do
    if Result < aCalendarDiscountPerc[i] then
      Result := aCalendarDiscountPerc[i];
end;

function TBonusBucksControl.GetCalendarDiscountPerc: TDiscountPercList;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText :=  'SELECT RC.DiscountPerc ' +
                    'FROM	Sal_RebateItemCalendar RIC ' +
                    'JOIN Sal_RebateCalendar RC ON (RIC.IDRebateCalendar = RC.IDRebateCalendar) ' +
                    'JOIN Sal_RebateItem RI ON (RIC.IDRebateItem = RI.IDRebateItem) ' +
                    'WHERE ' +
                    '	RI.IDModel = :IDModel ' +
                    '	AND RI.IDStore = :IDStore ' +
                    '	AND IsNull(RC.IDStore, :IDStore2) = :IDStore3 ' +
                    '	AND RC.DaysOfWeek LIKE ' + QuotedStr('%') + ' + :DayOfWeek + ' + QuotedStr('%') +
                    ' AND RC.StartDate <= :StartDate AND RC.EndDate >= :EndDate';

    Parameters.ParamByName('IDModel').Value := FIDModel;
    Parameters.ParamByName('IDStore').Value := FIDStore;
    Parameters.ParamByName('IDStore2').Value := FIDStore;
    Parameters.ParamByName('IDStore3').Value := FIDStore;
    Parameters.ParamByName('DayOfWeek').Value := IntToStr(DayOfTheWeek(Now));
    Parameters.ParamByName('StartDate').Value := Now;
    Parameters.ParamByName('EndDate').Value := Now;
    Open;

    SetLength(Result, RecordCount);

    while not Eof do
    begin
      Result[Pred(RecNo)] := FieldByName('DiscountPerc').AsCurrency;
      Next;
    end;
  finally
    Free;
  end;
end;

function TBonusBucksControl.GetDiscountValue: Currency;
begin
  SetDiscountValue;
  Result := MyRound(FDiscountValue, 2);
end;

function TBonusBucksControl.GetModelDiscountPerc: Double;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT DiscountPerc ' +
                   'FROM Sal_RebateItem ' +
                   'WHERE IDModel = :IDModel AND IDStore = :IDStore';

    Parameters.ParamByName('IDModel').Value := FIDModel;
    Parameters.ParamByName('IDStore').Value := FIDStore;
    Open;

    Result := FieldByName('DiscountPerc').AsCurrency;
  finally
    Free;
  end;
end;

procedure TBonusBucksControl.SetDiscountValue;
begin
  FDiscountValue := FSellingPrice * (GetBestDiscountPerc / 100);
end;

{ TBonusBucks }

procedure TBonusBucks.CalcBonusBucks;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT IM.ModelID, IM.StoreID, ((IM.SalePrice * IM.Qty) - IM.Discount) as SalePrice ' +
                   'FROM PreInventoryMov IM JOIN Invoice I ON (IM.DocumentID = I.IDPreSale) ' +
                   'WHERE I.IDPreSale = :IDPreSale AND IM.Promo = 0';
    Parameters.ParamByName('IDPreSale').Value := FIDPreSaleCreated;
    Open;

    First;
    while not Eof do
    begin
      FBonusBucksControl.IDModel := FieldByName('ModelID').AsInteger;
      FBonusBucksControl.IDStore := FieldByName('StoreID').AsInteger;
      FBonusBucksControl.SellingPrice := FieldByName('SalePrice').AsCurrency;

      FDiscountValue := FDiscountValue + FBonusBucksControl.GetDiscountValue;

      Next;
    end;
  finally
    Free;
  end;
end;

constructor TBonusBucks.Create(AADOConnection: TADOConnection; ABonusSync : TbgBonusSync);
begin
  FADOConnection := AADOConnection;
  FBonusSync     := ABonusSync;
  FDiscountValue := 0;

  FBonusBucksControl := TBonusBucksControl.Create;
  FBonusBucksControl.ADOConnection := FADOConnection;
end;

destructor TBonusBucks.Destroy;
begin
  FreeAndNil(FBonusBucksControl);
  inherited;
end;

function TBonusBucks.GetBonusBuckRedeemedPerc: Double;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT PropertyValue FROM Sis_PropertyDomain WHERE Property = :Property';
    Parameters.ParamByName('Property').Value := 'BonusBuckRedeemedPerc';
    Open;
    Result := StrToFloat(FieldByName('PropertyValue').AsString);
  finally
    Free;
  end;
end;

function TBonusBucks.GetDiscountValue: Currency;
begin
  if FDiscountValue = 0 then
  begin
    CalcBonusBucks;
    FDiscountValue := MyRound(FDiscountValue - (FDiscountValue * (GetBonusBuckRedeemedPerc / 100)), 2);
  end;

  Result := FDiscountValue;
end;

function TBonusBucks.HasPayment: Boolean;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT IDLancamento ' +
                   'FROM	Fin_Lancamento L ' +
                   '      JOIN Fin_LancQuit LQ ON (L.IDLancamento = LQ.IDLancamento) ' +
                   '	    JOIN Fin_Quitacao Q ON (LQ.IDQuitacao = Q.IDQuitacao) ' +
                   '      JOIN MeioPag MP ON (Q.IDQuitacaoMeio = MP.IDMeioPag) ' +
                   'WHERE	L.IDPreSale = :IDPreSale AND MP.Tipo = 8';

    Parameters.ParamByName('IDPreSale').Value := FIDPreSaleUsed;
    Open;

    Result := not IsEmpty;
  finally
    Free;
  end;
end;

function TBonusBucks.IsExpiredCupon: Boolean;
begin
  Result := Int(IncDay(FExpirationDate)) <= Int(Now);
end;

function TBonusBucks.IsValidCupon: Boolean;
begin
  Result := FValidFromDate <= Now;
end;

procedure TBonusBucks.LoadByCupom(ACupom: String);
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT RD.IDPreSaleCreated, RD.DiscountValue, RD.ValidFromDate, RD.ExpirationDate, RD.IDPreSaleUsed, RD.BonusCode, I.InvoiceDate ' +
                   'FROM Sal_RebateDiscount RD JOIN Invoice I ON (RD.IDPreSaleCreated = I.IDPreSale)' +
                   'WHERE (IDPreSaleCreated = :IDPreSaleCreated OR RD.BonusCode = :BonusCode)';

    if (Length(ACupom) <> 34) then
    begin
      Parameters.ParamByName('IDPreSaleCreated').Value := StrToInt(StringReplace(Acupom, BONUS_BUCKS_PREFIX, '', [rfReplaceAll]));
      Parameters.ParamByName('BonusCode').Value := '';
    end
    else
    begin
      Parameters.ParamByName('IDPreSaleCreated').Value := 0;
      Parameters.ParamByName('BonusCode').Value := ACupom;
    end;

    Open;

    if IsEmpty then
      FIDPreSaleCreated := -1
    else
    begin
      FIDPreSaleCreated := FieldByName('IDPreSaleCreated').AsInteger;
      FIDPreSaleUsed := FieldByName('IDPreSaleUsed').AsInteger;
      FDiscountValue := FieldByName('DiscountValue').AsFloat;
      FValidFromDate := FieldByName('ValidFromDate').AsDateTime;
      FExpirationDate := FieldByName('ExpirationDate').AsDateTime;
      FCreatedDate := FieldByName('InvoiceDate').AsDateTime;
      FBonusCode := FieldByName('BonusCode').AsString;
    end;
  finally
    Free;
  end;
end;

procedure TBonusBucks.LoadBySaleUsed(AIDPreSaleUsed: Integer);
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT RD.IDPreSaleCreated, RD.DiscountValue, RD.ValidFromDate, RD.ExpirationDate, RD.IDPreSaleUsed, RD.BonusCode, I.InvoiceDate ' +
                   'FROM Sal_RebateDiscount RD JOIN Invoice I ON (RD.IDPreSaleCreated = I.IDPreSale)' +
                   'WHERE IDPreSaleUsed = :IDPreSaleUsed';
    Parameters.ParamByName('IDPreSaleUsed').Value := AIDPreSaleUsed;
    Open;

    if IsEmpty then
      FIDPreSaleCreated := -1
    else
    begin
      FIDPreSaleCreated := FieldByName('IDPreSaleCreated').AsInteger;
      FIDPreSaleUsed := FieldByName('IDPreSaleUsed').AsInteger;
      FDiscountValue := FieldByName('DiscountValue').AsFloat;
      FValidFromDate := FieldByName('ValidFromDate').AsDateTime;
      FExpirationDate := FieldByName('ExpirationDate').AsDateTime;
      FCreatedDate := FieldByName('InvoiceDate').AsDateTime;
      FBonusCode := FieldByName('BonusCode').AsString;
    end;
  finally
    Free;
  end;
end;

procedure TBonusBucks.SetUsed(AIDPreSaleUsed : Integer; ABonusCode: String);
begin
  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE Sal_RebateDiscount SET IDPreSaleUsed = :IDPreSaleUsed WHERE BonusCode = :BonusCode';
    Parameters.ParamByName('IDPreSaleUsed').Value := AIDPreSaleUsed;
    Parameters.ParamByName('BonusCode').Value := ABonusCode;
    Execute;
  finally
    Free;
  end;
end;

procedure TBonusBucks.UndoSetUsed(AIDPreSaleUsed: Integer);
var
  bError : Boolean;
begin

  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT BonusCode FROM Sal_RebateDiscount WHERE IDPreSaleUsed = :IDPreSaleUsed ';
    Parameters.ParamByName('IDPreSaleUsed').Value := FIDPreSaleUsed;
    Open;
    First;

    while not EOF do
    begin
      FBonusSync.BonusCode := FieldByName('BonusCode').AsString;
      if (FBonusSync.BonusCode <> '') then
      begin
          try
            bError := True;
            if FBonusSync.UnUse then
              bError := (FBonusSync.IDResult <> 0);
          except
          end;

          if bError then
          begin
            FErrorMsg := FBonusSync.ResultMessage;
            raise Exception.Create(FBonusSync.ResultMessage);
          end;
      end;
     Next;
    end;
  finally
    Free;
  end;
  
  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE Sal_RebateDiscount SET IDPreSaleUsed = NULL WHERE IDPreSaleUsed = :IDPreSaleUsed';
    Parameters.ParamByName('IDPreSaleUsed').Value := AIDPreSaleUsed;
    Execute;
  finally
    Free;
  end;
  
end;

function TBonusBucks.ValidateCoupon: Boolean;
begin
  Result := False;

  if FIDPreSaleCreated = -1 then
  begin
    FErrorMsg := MSG_CRT_BONUS_NOT_FOUND;
    Exit;
  end
  else if FIDPreSaleUsed = 0 then
  begin
    if not ValidCupon then
    begin
      FErrorMsg := MSG_CRT_BONUS_IS_NOT_VALID;
      Exit;
    end
    else if ExpiredCupon then
    begin
      FErrorMsg := MSG_CRT_BONUS_EXPIRED;
      Exit;
    end;
  end
  else
  begin
    FErrorMsg := MSG_CRT_BONUS_ALREADY_UTILIZED;
    Exit;
  end;

  Result := True;
end;

end.
