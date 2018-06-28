unit uXMLClasses;

interface

uses SysUtils, Classes;

type
  TXMLContent = class
  private
    FXML: String;
    function GetTagValue(ATagName: String): String;
    function GetAttributeValue(AAttributeName: String): String;
    function GetAttributeValueByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): String;
  public
    function GetTagInteger(ATagName: String): Integer;
    function GetTagBoolean(ATagName: String): Boolean;
    function GetTagDouble(ATagName: String): Double;
    function GetTagString(ATagName: String): String;
    function GetTagDateTime(ATagName: String): TDateTime;

    function GetAttributeInteger(AAttributeName: String): Integer;
    function GetAttributeBoolean(AAttributeName: String): Boolean;
    function GetAttributeDouble(AAttributeName: String): Double;
    function GetAttributeString(AAttributeName: String): String;
    function GetAttributeDateTime(AAttributeName: String): TDateTime;

    function GetAttributeIntegerByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): Integer;
    function GetAttributeBooleanByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): Boolean;
    function GetAttributeDoubleByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): Double;
    function GetAttributeStringByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): String;
    function GetAttributeDateTimeByNodeIndex(ANodeName, AAttributeName: String; AIndex: Integer): TDateTime;

    function CutNode(ANodeName: String): String;
    function GetNode(ANodeName: String): String;
    function GetNodeByIndex(ANodeName: String; AIndex: Integer): String;
    function GetNodeCount(ANodeName: String): Integer;
    function GetNodeCountByNodeIndex(ANodeMasterName, ANodeName: String; AIndex: Integer): Integer;

    property XML: String read FXML write FXML;
  end;

  TXMLRequest = class
  private
    FUserName: String;
    FUserPassword: String;
    FURLSite: String;
    FActionName: String;
  public
    function GetXMLRequestByID(ID: Integer): String;

    property URLSite: String read FURLSite write FURLSite;
    property ActionName: String read FActionName write FActionName;
    property UserName: String read FUserName write FUserName;
    property UserPassword: String read FUserPassword write FUserPassword;
  end;

  TXMLResponse = class
  private
    FXMLContent: TXMLContent;
  public
    constructor Create;
    destructor Destroy; override;
    function GetXMLResponse(ContentStream: TStream): String;

    property XMLContent: TXMLContent read FXMLContent write FXMLContent;
  end;

implementation

uses DateUtils;

{ TXMLRequest }

function TXMLRequest.GetXMLRequestByID(ID: Integer): String;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">' +
            '  <soapenv:Header/>' +
            '  <soapenv:Body>' +
            '    <e:' + FActionName + '>' +
            '      <!--Optional:-->' +
            '      <e:Usuario>' + FUserName + '</e:Usuario>' +
            '      <!--Optional:-->' +
            '      <e:Senha>' + FUserPassword + '</e:Senha>' +
            '      <!--Optional:-->' +
            '      <e:UrlSite>' + FURLSite + '</e:UrlSite>' +
            '      <!--Optional:-->' +
            '      <e:Id>' + IntToStr(ID) + '</e:Id>' +
            '    </e:' + FActionName + '>' +
            '  </soapenv:Body>' +
            '</soapenv:Envelope>';
end;

{ TXMLResponse }

constructor TXMLResponse.Create;
begin
  FXMLContent := TXMLContent.Create;
end;

destructor TXMLResponse.Destroy;
begin
  FXMLContent.Free;
  inherited Destroy;
end;

function TXMLResponse.GetXMLResponse(ContentStream: TStream): String;
var
  ContentStringStream: TStringStream;
begin
  Result := '';
  ContentStringStream := TStringStream.Create('');
  try
    ContentStringStream.CopyFrom(ContentStream, 0);
    FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
    Result := FXMLContent.XML;
  finally
    ContentStringStream.Free;
  end;
end;

{ TXMLContent }

function TXMLContent.CutNode(ANodeName: String): String;
begin
  Result := GetNode(ANodeName);
  FXML := StringReplace(FXML, Result, '', [rfReplaceAll]);
end;

function TXMLContent.GetAttributeBoolean(AAttributeName: String): Boolean;
begin
  Result := StrToBool(GetAttributeValue(AAttributeName));
end;

function TXMLContent.GetAttributeBooleanByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): Boolean;
begin
  Result := StrToBool(GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex));
end;

function TXMLContent.GetAttributeDateTime(AAttributeName: String): TDateTime;
var
  sValue: String;
  Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetAttributeValue(AAttributeName);

  if sValue = '' then
    Result := Now
  else
  begin
    Year := StrToInt(Copy(sValue, 1, 4));
    Month := StrToInt(Copy(sValue, 6, 2));
    Day := StrToInt(Copy(sValue, 9, 2));
    Hour := StrToInt(Copy(sValue, 12, 2));
    Minute := StrToInt(Copy(sValue, 15, 2));
    Second := StrToInt(Copy(sValue, 18, 2));
    MilliSecond := StrToInt('00');

    Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, MilliSecond);
  end;
end;

function TXMLContent.GetAttributeDateTimeByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): TDateTime;
var
  sValue: String;
  Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex);

  if sValue = '' then
    Result := Now
  else
  begin
    Year := StrToInt(Copy(sValue, 1, 4));
    Month := StrToInt(Copy(sValue, 6, 2));
    Day := StrToInt(Copy(sValue, 9, 2));
    Hour := StrToInt(Copy(sValue, 12, 2));
    Minute := StrToInt(Copy(sValue, 15, 2));
    Second := StrToInt(Copy(sValue, 18, 2));
    MilliSecond := StrToInt('00');

    Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, MilliSecond);
  end;
end;

function TXMLContent.GetAttributeDouble(AAttributeName: String): Double;
var
  sValue: String;
begin
  sValue := GetAttributeValue(AAttributeName);
  sValue := StringReplace(sValue, '.', ',', [rfReplaceAll]);
  Result := StrToFloat(sValue);
end;

function TXMLContent.GetAttributeDoubleByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): Double;
var
  sValue: String;
begin
  sValue := GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex);
  sValue := StringReplace(sValue, '.', ',', [rfReplaceAll]);
  Result := StrToFloat(sValue);
end;

function TXMLContent.GetAttributeInteger(AAttributeName: String): Integer;
begin
  Result := StrToInt(GetAttributeValue(AAttributeName));
end;

function TXMLContent.GetAttributeIntegerByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): Integer;
var
  sAttributeValue: String;
begin
  sAttributeValue := GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex);

  if sAttributeValue = '' then
    Result := -1
  else
    Result := StrToInt(sAttributeValue);
end;

function TXMLContent.GetAttributeString(AAttributeName: String): String;
begin
  Result := GetAttributeValue(AAttributeName);
end;

function TXMLContent.GetAttributeStringByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): String;
begin
  Result := GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex);
end;

function TXMLContent.GetAttributeValue(AAttributeName: String): String;
var
  iBegin, iEnd, iSize: Integer;
begin
  iBegin := Pos('<a:' + AAttributeName + '>', XML);
  iEnd := Pos('</a:' + AAttributeName + '>', XML);
  iSize := Length('<a:' + AAttributeName + '>');

  Result := Copy(XML, iBegin + iSize, iEnd - (iBegin + iSize));
end;

function TXMLContent.GetAttributeValueByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): String;
var
  i, iNodeEndPos, iNodeEndLen: Integer;
  XMLNodeContent: TXMLContent;
begin
  Result := '';

  XMLNodeContent := TXMLContent.Create;
  try
    XMLNodeContent.XML := FXML;
    iNodeEndLen := Length('</a:'+ANodeName+'>');

    iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);
    for i := 0 to AIndex do
    begin
      if i <> AIndex then
      begin
        XMLNodeContent.XML := Copy(XMLNodeContent.XML, iNodeEndPos + iNodeEndLen, Length(XMLNodeContent.XML));
        iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);
      end;
    end;

    Result := XMLNodeContent.GetAttributeValue(AAttributeName);
  finally
    XMLNodeContent.Free;
  end;
end;

function TXMLContent.GetNode(ANodeName: String): String;
var
  i, iNodeBeginPos, iNodeEndPos, iNodeEndLen: Integer;
  XMLNodeContent: TXMLContent;
begin
  Result := '';

  XMLNodeContent := TXMLContent.Create;
  try
    XMLNodeContent.XML := FXML;
    iNodeEndLen := Length('</a:'+ANodeName+'>');

    iNodeBeginPos := Pos('<a:'+ANodeName+'>', XMLNodeContent.XML);
    iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);
    XMLNodeContent.XML := Copy(XMLNodeContent.XML, iNodeBeginPos, (iNodeEndPos + iNodeEndLen) - iNodeBeginPos);
    iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);

    Result := XMLNodeContent.XML;
  finally
    XMLNodeContent.Free;
  end;
end;

function TXMLContent.GetNodeByIndex(ANodeName: String; AIndex: Integer): String;
var
  i, iNodeEndPos, iNodeEndLen: Integer;
  XMLNodeContent: TXMLContent;
begin
  Result := '';

  XMLNodeContent := TXMLContent.Create;
  try
    XMLNodeContent.XML := FXML;
    iNodeEndLen := Length('</a:'+ANodeName+'>');

    iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);
    for i := 0 to AIndex do
    begin
      if i <> AIndex then
      begin
        XMLNodeContent.XML := Copy(XMLNodeContent.XML, iNodeEndPos + iNodeEndLen, Length(XMLNodeContent.XML));
        iNodeEndPos := Pos('</a:'+ANodeName+'>', XMLNodeContent.XML);
      end;
    end;

    Result := XMLNodeContent.XML;
  finally
    XMLNodeContent.Free;
  end;
end;

function TXMLContent.GetNodeCount(ANodeName: String): Integer;
var
  iNodePos, iNodeLen: Integer;
  sTempXML: String;
begin
  Result := 0;
  sTempXML := FXML;
  iNodeLen := Length('<a:'+ANodeName+'>');

  iNodePos := Pos('<a:'+ANodeName+'>', sTempXML);
  while iNodePos <> 0 do
  begin
    sTempXML := Copy(sTempXML, iNodePos + iNodeLen, Length(sTempXML));
    iNodePos := Pos('<a:'+ANodeName+'>', sTempXML);
    Inc(Result);
  end;
end;

function TXMLContent.GetNodeCountByNodeIndex(ANodeMasterName,
  ANodeName: String; AIndex: Integer): Integer;
var
  i, iNodeMasterPos, iNodePos, iNodeMasterLen, iNodeLen: Integer;
  sTempXML: String;
begin
  Result := 0;
  sTempXML := FXML;
  iNodeMasterLen := Length('<a:'+ANodeMasterName+'>');

  for i := 0 to AIndex do
  begin
    iNodeMasterPos := Pos('<a:'+ANodeMasterName+'>', sTempXML);
    while iNodePos <> 0 do
    begin
      sTempXML := Copy(sTempXML, iNodeMasterPos + iNodeMasterLen, Length(sTempXML));
      iNodeMasterPos := Pos('<a:'+ANodeMasterName+'>', sTempXML);
      Inc(Result);
    end;
  end;

  iNodeLen := Length('<a:'+ANodeName+'>');

  iNodePos := Pos('<a:'+ANodeName+'>', sTempXML);
  while iNodePos <> 0 do
  begin
    sTempXML := Copy(sTempXML, iNodePos + iNodeLen, Length(sTempXML));
    iNodePos := Pos('<a:'+ANodeName+'>', sTempXML);
    Inc(Result);
  end;
end;

function TXMLContent.GetTagBoolean(ATagName: String): Boolean;
begin
  Result := StrToBool(GetTagValue(ATagName));
end;

function TXMLContent.GetTagDateTime(ATagName: String): TDateTime;
var
  sValue: String;
  //Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetTagValue(ATagName);

  //Year := Copy(sValue, 1, 4);
  //Month := Copy(sValue, 6, 2);
  //Day := Copy(sValue, 9, 2);
  //Hour := Copy(sValue, 12, 2);
  //Minute := Copy(sValue, 15, 2);
  //Second := Copy(sValue, 18, 2);
  //MilliSecond := '00';
  //Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, MilliSecond);

  Result := Now;
end;

function TXMLContent.GetTagDouble(ATagName: String): Double;
var
  sValue: String;
begin
  sValue := GetTagValue(ATagName);
  sValue := StringReplace(sValue, '.', ',', [rfReplaceAll]);
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
