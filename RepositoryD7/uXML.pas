unit uXML;

interface

uses db, SysUtils, Classes;

type
  TXMLContent = class
  private
    FXML: String;
    FTagPrefix: String;
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

    function GetNodeCount(ANodeName: String): Integer;

    property XML: String read FXML write FXML;
    property TagPrefix: String read FTagPrefix write FTagPrefix;
  end;


function MakeTag( TagName, Value : String ) : string;
function MakeXML( Dataset : TDataset ) : string;

implementation

function MakeTag( TagName, Value : String ) : string;
begin
  Result := '<' + TagName + '>' + Value + '</' + TagName + '>';
end;

function MakeXML( Dataset : TDataset ) : string;
var
  i : integer;
begin

   Result := '';

   if (not Dataset.Active) or (Dataset.IsEmpty) then
      Exit;

   Result := Result + '<' + Dataset.Name + '>';
   Dataset.First;

   while not Dataset.EOF do
     begin
     Result := Result + '<RECORD>';

     for i := 0 to Dataset.Fields.Count-1 do
         Result := Result + MakeTag(Dataset.Fields[i].Name, Dataset.Fields[i].Text);

     Result := Result + '</RECORD>';
     Dataset.Next;
     end;

   Result := Result + '</' + Dataset.Name + '>';

end;


{ TXMLContent }

function TXMLContent.GetAttributeBoolean(AAttributeName: String): Boolean;
begin
  Result := StrToBool(GetAttributeValue(AAttributeName));
end;

function TXMLContent.GetAttributeBooleanByNodeIndex(ANodeName,
  AAttributeName: String; AIndex: Integer): Boolean;
begin
  Result := StrToBool(GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex));
end;

function TXMLContent.GetAttributeDateTime(AAttributeName: String): TDateTime;
var
  sValue: String;
  //Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetAttributeValue(AAttributeName);

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

function TXMLContent.GetAttributeDateTimeByNodeIndex(ANodeName, AAttributeName: String;
  AIndex: Integer): TDateTime;
var
  sValue: String;
  //Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
  sValue := GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex);

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

function TXMLContent.GetAttributeDouble(AAttributeName: String): Double;
var
  sValue: String;
  value: Double;
begin
  sValue := GetAttributeValue(AAttributeName);
  // sValue := StringReplace(sValue, '.', ',', [rfReplaceAll]);
  try
    value := strToFloat(sValue);
    result := value;
  except
    result := 0;
  end;

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
begin
  Result := StrToInt(GetAttributeValueByNodeIndex(ANodeName, AAttributeName, AIndex));
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
  iBegin := Pos('<' + FTagPrefix + AAttributeName + '>', XML);
  iEnd := Pos('</' + FTagPrefix + AAttributeName + '>', XML);
  iSize := Length('<' + FTagPrefix + AAttributeName + '>');

  Result := Copy(XML, iBegin + iSize, iEnd - (iBegin + iSize));
end;

function TXMLContent.GetAttributeValueByNodeIndex(ANodeName,
  AAttributeName: String; AIndex: Integer): String;
var
  i, iNodeEndPos, iNodeEndLen: Integer;
  XMLNodeContent: TXMLContent;
begin
  Result := '';

  XMLNodeContent := TXMLContent.Create;
  try
    XMLNodeContent.XML := FXML;
    iNodeEndLen := Length('</' + FTagPrefix+ ANodeName+'>');

    iNodeEndPos := Pos('</' + FTagPrefix + ANodeName+'>', XMLNodeContent.XML);
    for i := 0 to AIndex do
    begin
      if i <> AIndex then
      begin
        XMLNodeContent.XML := Copy(XMLNodeContent.XML, iNodeEndPos + iNodeEndLen, Length(XMLNodeContent.XML));
        iNodeEndPos := Pos('</' + FTagPrefix + ANodeName+'>', XMLNodeContent.XML);
      end;
    end;

    Result := XMLNodeContent.GetAttributeValue(AAttributeName);
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
  iNodeLen := Length('<' + FTagPrefix + ANodeName+'>');

  iNodePos := Pos('<' + FTagPrefix + ANodeName+'>', sTempXML);
  while iNodePos <> 0 do
  begin
    sTempXML := Copy(sTempXML, iNodePos + iNodeLen, Length(sTempXML));
    iNodePos := Pos('<' + FTagPrefix + ANodeName+'>', sTempXML);
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
begin
  Result := StrToInt(GetTagValue(ATagName));
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
