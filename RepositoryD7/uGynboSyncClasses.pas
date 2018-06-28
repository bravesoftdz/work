unit uGynboSyncClasses;

interface

uses SysUtils, Classes, SOAPHTTPTrans, DateUtils;

const
  GC_TRANS_CREDIT = 1;
  GC_TRAN_DEBIT = 2;
  GC_TRAN_VOID = 3;

type
  TXMLContent = class
  private
    FXML: String;
    function GetTagValue(ATagName: String): String;
  public
    function GetTagInteger(ATagName: String): Integer;
    function GetTagBoolean(ATagName: String): Boolean;
    function GetTagDouble(ATagName: String): Double;
    function GetTagString(ATagName: String): String;
    function GetTagDateTime(ATagName: String): TDateTime;

    property XML: String read FXML write FXML;
  end;


  TgbParentSync = class
  protected
    FHTTPReqResp: THTTPReqResp;
    FURLSite: String;
    FPartnerEmail: String;
    FPartnerPW: String;
    FIDStore: Integer;
    FXMLContent: TXMLContent;
    FIDResult : Integer;
    FResultMessage : String;

    FXMLRequest : WideString;
    FSoapAction : String;

    function GetWebServiceURL: String;
    function GetSoapActionURL: String;
    function HasExecutionError: Boolean;

    function GetExecutionErrorMessage: String;
    function FormatarDataXML(AData: TDateTime): String;

    function ExecuteRequest: Boolean;
    procedure AfterExecuteResult; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(AHTTPReqResp: THTTPReqResp; AURLSite, AURLUser, AURLPW, APartnerEmail, APartnerPW: String; AIDStore : Integer);

    property XMLContent: TXMLContent read FXMLContent write FXMLContent;
    property IDResult : Integer read FIDResult write FIDResult;
    property ResultMessage : String read FResultMessage write FResultMessage;
  end;

  TbgBonusSync = class(TgbParentSync)
  private
    FBonusCode: String;
    FInvoiceNumber: String;
    FInvoiceDate: TDateTime;
    FMemberEmail: String;
    FBonusValue: Currency;
    FValidFrom: TDateTime;
    FExpirationDate: TDateTime;
    FNotes: String;
    FMemberCard : String;
  protected
    function GetXMLGenerateRequest: WideString;
    function GetXMLUseRequest: WideString;
    procedure AfterExecuteResult; override;
  public
    property BonusCode: String read FBonusCode write FBonusCode;
    property InvoiceNumber: String read FInvoiceNumber write FInvoiceNumber;
    property InvoiceDate: TDateTime read FInvoiceDate write FInvoiceDate;
    property MemberEmail: String read FMemberEmail write FMemberEmail;
    property BonusValue: Currency read FBonusValue write FBonusValue;
    property ValidFrom: TDateTime read FValidFrom write FValidFrom;
    property ExpirationDate: TDateTime read FExpirationDate write FExpirationDate;
    property Notes: String read FNotes write FNotes;
    property MemberCard: String read FMemberCard write FMemberCard;

    function Generate: Boolean;
    function Use: Boolean;
    function Void: Boolean;
    function UnUse: Boolean;
  end;

  TbgGiftCardSync = class(TgbParentSync)
  private
    FCardNumber : String;
    FCVV : String;
    FExpirationDate : TDateTime;
    FBalance : Currency;
    FNotes : string;
    FTransactionAmount : Currency;
    FUseType : Integer;
    procedure setTransactionAmount(const Value: Currency);
    procedure setCVV(const Value: String);
  protected
    function GetXMLGenerateRequest: WideString;
    function GetXMLUseRequest: WideString;
    function GetXMLVoidRequest: WideString;
    procedure AfterExecuteResult; override;
  public
    property CardNumber : String read FCardNumber write FCardNumber;
    property CVV : String read FCVV write setCVV;
    property ExpirationDate : TDateTime read FExpirationDate write FExpirationDate;
    property Balance : Currency read FBalance;
    property Notes : string read FNotes write FNotes;
    property TransactionAmount : Currency read FTransactionAmount write setTransactionAmount;

    function Generate: Boolean;
    function Use: Boolean;
    function Void: Boolean;
    function UnUse: Boolean;
  end;

implementation

{ TgbParentSync }

constructor TgbParentSync.Create;
begin
  try
    FXMLContent := TXMLContent.Create;
  except
    raise Exception.Create(self.ClassName + '.Create');
  end;
end;

destructor TgbParentSync.Destroy;
begin
  try
    FXMLContent.Free;
    inherited Destroy;
  except
    raise Exception.Create(self.ClassName + '.Destroy');
  end;
end;

function TgbParentSync.HasExecutionError: Boolean;
begin
  Result := (FXMLContent.GetTagString('faultcode') <> '');
end;

function TgbParentSync.FormatarDataXML(AData: TDateTime): String;
var
  sYear, sMonth, sDay: String;
  Year, Month, Day: Word;
begin
  DecodeDate(AData, Year, Month, Day);

  sYear := IntToStr(Year);
  if Length(sYear) = 2 then
    sYear := '20' + sYear;

  sMonth := IntToStr(Month);
  if Length(sMonth) = 1 then
    sMonth := '0' + sMonth;

  sDay := IntToStr(Day);
  if Length(sDay) = 1 then
    sDay := '0' + sDay;

  Result := sYear + '-' + sMonth + '-' + sDay + 'T00:00:00';
end;

function TgbParentSync.GetExecutionErrorMessage: String;
begin
    Result := FXMLContent.GetTagString('faultstring');
end;

procedure TgbParentSync.Init(AHTTPReqResp: THTTPReqResp; AURLSite, AURLUser, AURLPW, APartnerEmail,
  APartnerPW: String; AIDStore : Integer);
begin
  try
    FHTTPReqResp  := AHTTPReqResp;
    FPartnerEmail := APartnerEmail;
    FPartnerPW    := APartnerPW;
    FIDStore      := AIDStore;
    FURLSite      := AURLSite;

    FHTTPReqResp.URL             := GetWebServiceURL;
    FHTTPReqResp.UserName        := AURLUser;
    FHTTPReqResp.Password        := AURLPW;
    FHTTPReqResp.UseUTF8InHeader := True;
  except
    raise Exception.Create(self.ClassName + '.Init');
  end;
end;

function TgbParentSync.ExecuteRequest: Boolean;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  Result := False;

  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + FSoapAction;
      FHTTPReqResp.Execute(UTF8Encode(FXMLRequest), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      AfterExecuteResult;
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
      Result := True;
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.'+FSoapAction+'. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;


function TgbParentSync.GetSoapActionURL: String;
begin
  Result := 'gynbowebservice/';
end;

function TgbParentSync.GetWebServiceURL: String;
begin
  Result := '';
  if FURLSite <> '' then
    Result := FURLSite + 'webservice/GynboWebService.asmx?wsdl';
end;

procedure TgbParentSync.AfterExecuteResult;
begin
  FIDResult := FXMLContent.GetTagInteger('idresult');
  FResultMessage := FXMLContent.GetTagString('resultmessage');
end;

{ TbgBonusSync }

procedure TbgBonusSync.AfterExecuteResult;
begin
  inherited;
  FBonusCode := FXMLContent.GetTagString('bonuscode');
  FBonusValue := FXMLContent.GetTagDouble('bonusvalue');
end;

function TbgBonusSync.Generate: Boolean;
begin
    FXMLRequest := GetXMLGenerateRequest;
    FSoapAction := 'GenerateBonus';
    Result := ExecuteRequest;
end;

function TbgBonusSync.Use: Boolean;
begin
    FXMLRequest := GetXMLUseRequest;
    FSoapAction := 'UseBonus';
    Result := ExecuteRequest;
end;

function TbgBonusSync.GetXMLGenerateRequest: WideString;
begin

  Result := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:gyn="gynbowebservice"> ' +
            '  <soap:Header/> ' +
            '  <soap:Body> ' +
            '     <gyn:GenerateBonus> ' +
            '        <!--Optional:--> ' +
            '        <gyn:PartnerEmail>'+ FPartnerEmail + '</gyn:PartnerEmail> ' +
            '        <!--Optional:--> ' +
            '        <gyn:PartnerPW>'+ FPartnerPW + '</gyn:PartnerPW> ' +
            '        <!--Optional:--> ' +
            '        <gyn:InvoiceNumber>'+ FInvoiceNumber +'</gyn:InvoiceNumber> ' +
            '        <gyn:InvoiceDate>'+ FormatarDataXML(FInvoiceDate) +'</gyn:InvoiceDate> ' +
            '        <gyn:IDStore>' + IntToStr(FIDStore) + '</gyn:IDStore> ' +
            '        <!--Optional:--> ' +
            '        <gyn:MemberEmail>' + FMemberEmail + '</gyn:MemberEmail> ' +
            '        <gyn:BonusValue>' + FloatToStr(FBonusValue) + '</gyn:BonusValue> ' +
            '        <gyn:ValidFrom>' + FormatarDataXML(FValidFrom) + '</gyn:ValidFrom> ' +
            '        <gyn:ExpirationDate>' + FormatarDataXML(FExpirationDate) + '</gyn:ExpirationDate> ' +
            '        <!--Optional:--> ' +
            '        <gyn:Notes>' + FNotes + '</gyn:Notes> ' +
            '     </gyn:GenerateBonus> ' +
            '  </soap:Body> ' +
            '</soap:Envelope> ';
end;

function TbgBonusSync.GetXMLUseRequest: WideString;
begin

  Result := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:gyn="gynbowebservice"> ' +
            '   <soap:Header/> ' +
            '   <soap:Body> ' +
            '      <gyn:UseBonus> ' +
            '         <!--Optional:--> ' +
            '         <gyn:PartnerEmail>' + FPartnerEmail + '</gyn:PartnerEmail> ' +
            '         <!--Optional:--> ' +
            '         <gyn:PartnerPW>' + FPartnerPW + '</gyn:PartnerPW> ' +
            '         <gyn:IDStore>' + IntToStr(FIDStore) + '</gyn:IDStore> ' +
            '         <!--Optional:--> ' +
            '         <gyn:BonusCode>' + FBonusCode + '</gyn:BonusCode> ' +
            '        <!--Optional:--> ' +
            '        <gyn:Notes>' + FNotes + '</gyn:Notes> ' +
            '      </gyn:UseBonus> ' +
            '   </soap:Body> ' +
            '</soap:Envelope> ';

end;


function TbgBonusSync.UnUse: Boolean;
begin
  Result := False;
end;

function TbgBonusSync.Void: Boolean;
begin
  Result := False;
end;

{ TbgGiftCardSync }

function TbgGiftCardSync.Generate: Boolean;
begin
  FXMLRequest := GetXMLGenerateRequest;
  FSoapAction := 'GenerateGiftCard';
  Result := ExecuteRequest;
end;

function TbgGiftCardSync.Use: Boolean;
begin
  FXMLRequest := GetXMLUseRequest;
  FSoapAction := 'UseGiftCard';
  Result := ExecuteRequest;
end;

function TbgGiftCardSync.Void: Boolean;
begin
  FXMLRequest := GetXMLVoidRequest;
  FSoapAction := 'VoidGiftCard';
  Result := ExecuteRequest;
end;


function TbgGiftCardSync.GetXMLGenerateRequest: WideString;
begin
  Result := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:gyn="gynbowebservice"> ' +
            '   <soap:Header/> ' +
            '   <soap:Body> ' +
            '      <gyn:GenerateGiftCard> ' +
            '         <!--Optional:--> ' +
            '        <gyn:PartnerEmail>'+ FPartnerEmail + '</gyn:PartnerEmail> ' +
            '        <!--Optional:--> ' +
            '        <gyn:PartnerPW>'+ FPartnerPW + '</gyn:PartnerPW> ' +
            '         <gyn:IDStore>' + IntToStr(FIDStore) + '</gyn:IDStore> ' +
            '         <!--Optional:--> ' +
            '         <gyn:CardNumber>'+ FCardNumber +'</gyn:CardNumber> ' +
            '         <gyn:CVV>'+ FCVV +'</gyn:CVV> ' +
            '         <gyn:ExpirationDate>'+ FormatarDataXML(FExpirationDate) +'</gyn:ExpirationDate> ' +
            '         <gyn:Balance>' + FloatToStr(FTransactionAmount) + '</gyn:Balance> ' +
            '         <!--Optional:--> ' +
            '         <gyn:Notes>' + FNotes + '</gyn:Notes> ' +
            '      </gyn:GenerateGiftCard> ' +
            '   </soap:Body> ' +
            '</soap:Envelope> ';

end;

function TbgGiftCardSync.GetXMLUseRequest: WideString;
begin

  Result := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:gyn="gynbowebservice"> ' +
            '   <soap:Header/> ' +
            '   <soap:Body> ' +
            '      <gyn:UseGiftCard> ' +
            '         <!--Optional:--> ' +
            '        <gyn:PartnerEmail>'+ FPartnerEmail + '</gyn:PartnerEmail> ' +
            '        <!--Optional:--> ' +
            '        <gyn:PartnerPW>'+ FPartnerPW + '</gyn:PartnerPW> ' +
            '         <gyn:IDStore>' + IntToStr(FIDStore) + '</gyn:IDStore> ' +
            '         <!--Optional:--> ' +
            '         <gyn:CardNumber>'+ FCardNumber +'</gyn:CardNumber> ' +
            '         <gyn:CVV>'+ FCVV +'</gyn:CVV> ' +
            '         <gyn:Amount>' + FloatToStr(FTransactionAmount) + '</gyn:Amount> ' +
            '         <gyn:UseType>' + IntToStr(FUseType) + '</gyn:UseType> ' +
            '         <!--Optional:--> ' +
            '         <gyn:Notes>' + FNotes + '</gyn:Notes> ' +
            '      </gyn:UseGiftCard> ' +
            '   </soap:Body> ' +
            '</soap:Envelope> ';

end;

function TbgGiftCardSync.GetXMLVoidRequest: WideString;
begin

  Result := '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:gyn="gynbowebservice"> ' +
            '   <soap:Header/> ' +
            '   <soap:Body> ' +
            '      <gyn:VoidGiftCard> ' +
            '         <!--Optional:--> ' +
            '        <gyn:PartnerEmail>'+ FPartnerEmail + '</gyn:PartnerEmail> ' +
            '        <!--Optional:--> ' +
            '        <gyn:PartnerPW>'+ FPartnerPW + '</gyn:PartnerPW> ' +
            '         <gyn:IDStore>' + IntToStr(FIDStore) + '</gyn:IDStore> ' +
            '         <!--Optional:--> ' +
            '         <gyn:CardNumber>'+ FCardNumber +'</gyn:CardNumber> ' +
            '         <gyn:CVV>'+ FCVV +'</gyn:CVV> ' +
            '         <!--Optional:--> ' +
            '         <gyn:Notes>' + FNotes + '</gyn:Notes> ' +
            '      </gyn:VoidGiftCard> ' +
            '   </soap:Body> ' +
            '</soap:Envelope> ';
            
end;

procedure TbgGiftCardSync.setCVV(const Value: String);
begin
  FCVV := Value;
  if FCVV = '' then
    FCVV := '0';
end;

procedure TbgGiftCardSync.setTransactionAmount(const Value: Currency);
begin
  FTransactionAmount := Value;
  if FTransactionAmount > 0 then
    FUseType := GC_TRANS_CREDIT
  else
    FUseType := GC_TRAN_DEBIT;
end;



procedure TbgGiftCardSync.AfterExecuteResult;
begin
  inherited;
  FBalance := FXMLContent.GetTagDouble('balance');
end;

function TbgGiftCardSync.UnUse: Boolean;
begin
  Result := False;
end;

{ TXMLContent }

function TXMLContent.GetTagBoolean(ATagName: String): Boolean;
begin
  Result := StrToBool(GetTagValue(ATagName));
end;

function TXMLContent.GetTagDateTime(ATagName: String): TDateTime;
var
  sValue: String;
  Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetTagValue(ATagName);

  Year := StrToInt(Copy(sValue, 1, 4));
  Month := StrToInt(Copy(sValue, 6, 2));
  Day := StrToInt(Copy(sValue, 9, 2));
  Hour := StrToInt(Copy(sValue, 12, 2));
  Minute := StrToInt(Copy(sValue, 15, 2));
  Second := StrToInt(Copy(sValue, 18, 2));
  MilliSecond := 0;
  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, MilliSecond);

  //Result := Now;
end;

function TXMLContent.GetTagDouble(ATagName: String): Double;
var
  sValue: String;
begin
  sValue := GetTagValue(ATagName);
  Result := StrToFloat(sValue);
end;

function TXMLContent.GetTagInteger(ATagName: String): Integer;
var
  sTagValue: String;
begin
  sTagValue := GetTagValue(ATagName);

  if sTagValue = '' then
    Result := -1
  else
    Result := StrToInt(sTagValue);
end;

function TXMLContent.GetTagString(ATagName: String): String;
begin
  Result := GetTagValue(ATagName);
end;

function TXMLContent.GetTagValue(ATagName: String): String;
var
  iBegin, iEnd, iSize: Integer;
begin
  iBegin := Pos('<' + ATagName + '>', XML);
  iEnd := Pos('</' + ATagName + '>', XML);
  iSize := Length('<' + ATagName + '>');

  Result := Copy(XML, iBegin + iSize, iEnd - (iBegin + iSize));
end;

end.
