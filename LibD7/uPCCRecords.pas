unit uPCCRecords;

interface

uses Classes, SysUtils;

const

  PCC_REC_COUNT = 'RECORD_COUNT';
  PCC_TRANS_RECORD = 'TRANS_RECORD';
  PCC_TRAN_NUM  = 'Number';
  PCC_TRAN_TICKET  = 'Ticket';
  PCC_TRAN_DATE  = 'Date';
  PCC_TRAN_TIME  = 'Time';
  PCC_TRAN_STATION  = 'Station';
  PCC_TRAN_PROCESSOR = 'Processor';
  PCC_TRAN_TID  = 'TID';
  PCC_TRAN_ISSUER  = 'Issuer';
  PCC_TRAN_MEMBER  = 'Member';
  PCC_TRAN_EXPDATE  = 'ExpDate';
  PCC_TRAN_ACTION  = 'Action';
  PCC_TRAN_MANUAL  = 'Manual';
  PCC_TRAN_AMOUNT  = 'Amount';
  PCC_TRAN_REF  = 'Ref';
  PCC_TRAN_RESULT  = 'Result';
  PCC_TRAN_AUTH  = 'Auth';
  PCC_TRAN_TAX_AMOUNT  = 'Tax_Amount';
  PCC_TRAN_TOTAL_AUTH  = 'Total_Auth';
  PCC_TRAN_INDICATOR  = 'Trans_Indicator';
  PCC_TRAN_REQACI  = 'ReqACI';
  PCC_TRAN_RETACI  = 'RetACI';
  PCC_TRAN_TRANS_DATE  = 'TransDate';
  PCC_TRAN_TRAN_TIME  = 'TransTime';
  PCC_TRAN_CARD  = 'Card';
  PCC_TRAN_BATCH_NUM  = 'BatchNumber';
  PCC_TRAN_ITEM_NUM  = 'ItemNumber';
  PCC_TRAN_CVV2  = 'CVV2_Resp';
  PCC_TRAN_COMERCIAL_CARD  = 'Commercial_Card';
  PCC_TRAN_OFFLINE = 'Offline';
  PCC_TRAN_STATUS  = 'Status';
  PCC_TRAN_TROUTD  = 'TroutD';
  PCC_TRAN_CARD_PRESENT  = 'CardPresent';
  PCC_TRAN_BUSINESS_TYPE  = 'Business_Type';

type

  TPCCRecord = class
    public
      Number : String;
      Ticket : String;
      Date : String;
      Time : String;
      Station : String;
      Processor : String;
      TID : String;
      Issuer : String;
      Member : String;
      ExpDate : String;
      Action : String;
      Manual : String;
      Amount : String;
      Ref : String;
      Result : String;
      Auth : String;
      Result_Ref : String;
      Tax_Amount : String;
      Total_Auth : String;
      Trans_Indicator : String;
      ReqACI : String;
      RetACI : String;
      TransDate : String;
      TransTime : String;
      Card : String;
      PeriodicPayment : String;
      BatchNumber : String;
      ItemNumber : String;
      CVV2_Resp : String;
      Selected : String;
      Commercial_Card : String;
      Offline : String;
      Status : String;
      TroutD : String;
      CardPresent : String;
      Business_Type : String;
  end;

  TPCCRecordList = class
  private
    FList : TStringList;

    procedure FreeList;
    function StartXMLField(AField : String) : String;
    function EndXMLField(AField : String) : String;
    function HasField(AText, AField : String) : Boolean;
    function GetXMLField(AText, AField : String) : String;

    function ComperCCDate(ADate1, ADate2 : String) : Boolean;
    function ComperCCCard(ACCard1, ACCard2 : String) : Boolean;
    function ComperCCAmount(AAmount1, AAmount2 : String) : Boolean;
    function TestResult(AResult : String) : Boolean;
  public
    Constructor Create;
    Destructor Destroy; override;

    function BuildRecords(AResult : WideString) : Boolean;
    function FindRecord(ATicket, ADate, AStation, AAmount, ACard : String) : TPCCRecord;
  end;



implementation

{ TPCCRecordList }

function TPCCRecordList.BuildRecords(AResult: WideString): Boolean;
var
  FTempList : TStringList;
  FPCCRecord : TPCCRecord;
  i, iTotal : Integer;
begin
  FTempList := TStringList.Create;
  try
    FTempList.Text := AResult;
    for i := 0 to FTempList.Count-1 do
    begin

     if HasField(FTempList.Strings[i], StartXMLField(PCC_REC_COUNT)) then
       iTotal := StrToInt(GetXMLField(FTempList.Strings[i], PCC_REC_COUNT))
     else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRANS_RECORD)) then
       FPCCRecord := TPCCRecord.Create
     else if (FPCCRecord <> nil) then
     begin
       if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_NUM)) then
         FPCCRecord.Number := GetXMLField(FTempList.Strings[i], PCC_TRAN_NUM)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TICKET)) then
         FPCCRecord.Ticket := GetXMLField(FTempList.Strings[i], PCC_TRAN_TICKET)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_DATE)) then
         FPCCRecord.Date := GetXmlField(FTempList.Strings[i], PCC_TRAN_DATE)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TIME)) then
         FPCCRecord.Time := GetXmlField(FTempList.Strings[i], PCC_TRAN_TIME)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_STATION)) then
         FPCCRecord.Station := GetXmlField(FTempList.Strings[i], PCC_TRAN_STATION)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_PROCESSOR)) then
         FPCCRecord.Processor := GetXmlField(FTempList.Strings[i], PCC_TRAN_PROCESSOR)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TID)) then
         FPCCRecord.TID := GetXmlField(FTempList.Strings[i], PCC_TRAN_TID)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_ISSUER)) then
         FPCCRecord.Issuer := GetXmlField(FTempList.Strings[i], PCC_TRAN_ISSUER)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_MEMBER)) then
         FPCCRecord.Member := GetXmlField(FTempList.Strings[i], PCC_TRAN_MEMBER)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_EXPDATE)) then
         FPCCRecord.ExpDate := GetXmlField(FTempList.Strings[i], PCC_TRAN_EXPDATE)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_ACTION)) then
         FPCCRecord.Action := GetXmlField(FTempList.Strings[i], PCC_TRAN_ACTION)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_MANUAL)) then
         FPCCRecord.Manual := GetXmlField(FTempList.Strings[i], PCC_TRAN_MANUAL)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_AMOUNT)) then
         FPCCRecord.Amount := GetXmlField(FTempList.Strings[i], PCC_TRAN_AMOUNT)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_REF)) then
         FPCCRecord.Ref := GetXmlField(FTempList.Strings[i], PCC_TRAN_REF)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_RESULT)) then
         FPCCRecord.Result := GetXmlField(FTempList.Strings[i], PCC_TRAN_RESULT)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_AUTH)) then
         FPCCRecord.Auth := GetXmlField(FTempList.Strings[i], PCC_TRAN_AUTH)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TAX_AMOUNT)) then
         FPCCRecord.Tax_Amount := GetXmlField(FTempList.Strings[i], PCC_TRAN_TAX_AMOUNT)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TOTAL_AUTH)) then
         FPCCRecord.Total_Auth := GetXmlField(FTempList.Strings[i], PCC_TRAN_TOTAL_AUTH)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_INDICATOR)) then
         FPCCRecord.Trans_Indicator := GetXmlField(FTempList.Strings[i], PCC_TRAN_INDICATOR)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_REQACI)) then
         FPCCRecord.ReqACI := GetXmlField(FTempList.Strings[i], PCC_TRAN_REQACI)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_RETACI)) then
         FPCCRecord.RetACI := GetXmlField(FTempList.Strings[i], PCC_TRAN_RETACI)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TRANS_DATE)) then
         FPCCRecord.TransDate := GetXmlField(FTempList.Strings[i], PCC_TRAN_TRANS_DATE)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TRAN_TIME)) then
         FPCCRecord.TransTime := GetXmlField(FTempList.Strings[i], PCC_TRAN_TRAN_TIME)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_CARD)) then
         FPCCRecord.Card := GetXmlField(FTempList.Strings[i], PCC_TRAN_CARD)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_BATCH_NUM)) then
         FPCCRecord.BatchNumber := GetXmlField(FTempList.Strings[i], PCC_TRAN_BATCH_NUM)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_ITEM_NUM)) then
         FPCCRecord.ItemNumber := GetXmlField(FTempList.Strings[i], PCC_TRAN_ITEM_NUM)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_CVV2)) then
         FPCCRecord.CVV2_Resp := GetXmlField(FTempList.Strings[i], PCC_TRAN_CVV2)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_COMERCIAL_CARD)) then
         FPCCRecord.Commercial_Card := GetXmlField(FTempList.Strings[i], PCC_TRAN_COMERCIAL_CARD)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_OFFLINE)) then
         FPCCRecord.Offline := GetXmlField(FTempList.Strings[i], PCC_TRAN_OFFLINE)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_STATUS)) then
         FPCCRecord.Status := GetXmlField(FTempList.Strings[i], PCC_TRAN_STATUS)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_TROUTD)) then
         FPCCRecord.TroutD := GetXmlField(FTempList.Strings[i], PCC_TRAN_TROUTD)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_CARD_PRESENT)) then
         FPCCRecord.CardPresent := GetXmlField(FTempList.Strings[i], PCC_TRAN_CARD_PRESENT)
       else if HasField(FTempList.Strings[i], StartXMLField(PCC_TRAN_BUSINESS_TYPE)) then
         FPCCRecord.Business_Type := GetXmlField(FTempList.Strings[i], PCC_TRAN_BUSINESS_TYPE)
       else if HasField(FTempList.Strings[i], EndXMLField(PCC_TRANS_RECORD)) then
         FList.AddObject('', FPCCRecord);
     end

    end;
  finally
    FreeAndNil(FTempList);
  end;
end;

constructor TPCCRecordList.Create;
begin
  FList := TStringList.Create;
end;

destructor TPCCRecordList.Destroy;
begin
  FreeList;
  FreeAndNil(FList);
  inherited;
end;

procedure TPCCRecordList.FreeList;
var
  PCCRecord : TPCCRecord;
begin
  while FList.Count > 0 do
  begin
    if FList.Objects[0] <> nil then
    begin
      PCCRecord := TPCCRecord(FList.Objects[0]);
      FreeAndNil(PCCRecord);
    end;
    FList.Delete(0);
  end;
end;

function TPCCRecordList.StartXMLField(AField: String): String;
begin
  Result := '<' + AField + '>';
end;

function TPCCRecordList.EndXMLField(AField: String): String;
begin
  Result := '</' + AField + '>';
end;

function TPCCRecordList.HasField(AText, AField: String): Boolean;
begin
  Result := (Pos(AField, AText) > 0);
end;

function TPCCRecordList.GetXMLField(AText, AField: String): String;
begin
  AText := Trim(AText);
  Result := Copy(AText, Pos(AText, StartXMLField(AField)) + 1 + length(StartXMLField(AField)), length(AText));
  Result := StringReplace(Result, EndXMLField(AField), '', []);
  Result := Trim(Result);
end;

function TPCCRecordList.FindRecord(ATicket, ADate, AStation, AAmount,
  ACard: String): TPCCRecord;
var
  i : integer;
  PCCRecord : TPCCRecord;
begin
  Result := nil;

  for i := 0 to FList.Count-1 do
  begin
    if FList.Objects[i] <> nil then
    begin
      PCCRecord := TPCCRecord(FList.Objects[i]);

      if (PCCRecord.Ticket = ATicket) and ComperCCDate(PCCRecord.Date, ADate) and
         (PCCRecord.Station = AStation) and ComperCCAmount(PCCRecord.Amount, AAmount) and
         ComperCCCard(PCCRecord.Card, ACard) and TestResult(PCCRecord.Result) then
      begin
        Result := PCCRecord;
        Break;
      end;

    end;
  end;
end;

function TPCCRecordList.ComperCCCard(ACCard1, ACCard2: String): Boolean;
var
  sCardTemp : string;
begin
  sCardTemp := Copy(ACCard2, 1, 4);
  sCardTemp := sCardTemp + '........' + Copy(ACCard2, Length(ACCard2)-3, Length(ACCard2));
  Result := (ACCard1 = sCardTemp);
end;

function TPCCRecordList.ComperCCDate(ADate1, ADate2: String): Boolean;
var
  FDate1, FDate2 : TDateTime;
begin

  try
    FDate1 := StrToDate(ADate1);
  except
  end;

  try
    FDate2 := StrToDate(ADate2);
  except
  end;

  Result := (FDate1 = FDate2);

end;

function TPCCRecordList.ComperCCAmount(AAmount1, AAmount2: String): Boolean;
begin
  Result := (StringReplace(AAmount1, '$', '', []) = AAmount2);
end;

function TPCCRecordList.TestResult(AResult: String): Boolean;
begin
  Result := (AResult = 'CAPTURED') or (AResult = 'APPROVED') or (AResult = 'VOIDED') or (AResult = 'PROCESSED');
end;

end.
