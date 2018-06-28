unit uXML;

interface

uses db;

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


end.
