unit uParamFunctions;

interface

uses Sysutils, classes;

function ParseParam(Parametros, Parametro: String): String;
function DeleteParam(Parametros, Parametro: String): String;
function SetConnectionStr(sUser, sPw, sDB, sServer:String):String;
function SetConnectionStrNoNETLIB(sUser, sPw, sDB, sServer:String):String;
procedure ParseUserRights(UserRights: String; var UserRightsList: TStringList);

implementation

function DeleteParam(Parametros, Parametro: String): String;
var
  p, i, x: integer;
  Temp : String;
begin

  Temp := Parametros;
  p := Pos(UpperCase(Parametro), UpperCase(Temp));
  x := 0;

  if p = 0 then
    Result := Temp
  else
    begin
    For i:=p to Length(Temp) do
       begin
       inc(x);
       if Parametros[i] = ';' then
          Break;
       end;
    Delete(Temp, p, x);
    Result := Temp;
    end;

end;

function ParseParam(Parametros, Parametro: String): String;
var
  p: integer;
  Temp: String;

begin

  p := Pos(UpperCase(Parametro), UpperCase(Parametros));

  if p = 0 then
    Result := ''
  else
    begin
      // Achou, corto até antes do nome do parametro
      Temp := copy(Parametros, p, Length(Parametros)-p+1);

      // Procuro pelo igual e corto tb
      p := Pos('=', UpperCase(Temp)) + 1;
      Temp := copy(Temp, p, Length(Temp)-p+1);

      // Pego até o ponto e vígula
      p := Pos(';', UpperCase(Temp));
      if p <> 0 then
        Temp := copy(Temp, 1, p-1);

      Result := Trim(Temp);
    end;
end;

function SetConnectionStrNoNETLIB(sUser, sPw, sDB, sServer:String):String;
begin
  //Provider=SQLOLEDB.1 uses ADO
  if Trim(sPW) <> '' then
     sPW := 'Password='+sPW+';';
  Result := 'Provider=SQLOLEDB.1;Persist Security Info=True;'+
            sPW+'User ID='+sUser+';Initial Catalog='+sDB+';Data Source='+sServer+';'
end;


function SetConnectionStr(sUser, sPw, sDB, sServer:String):String;
begin
  //"Network Library=DBMSSOCN" tells OLE DB to use TCP/IP rather than Named Pipes
  //Provider=SQLOLEDB.1 uses ADO

  if Trim(sPW) <> '' then
     sPW := 'Password='+sPW+';';

  Result := 'Provider=SQLOLEDB.1;Persist Security Info=True;Network Library=DBMSSOCN;'+
            sPW+'User ID='+sUser+';Initial Catalog='+sDB+';Data Source='+sServer+';'

end;

procedure ParseUserRights(UserRights: String; var UserRightsList: TStringList);
var
  P: integer;
  NewOne: String;

begin
  UserRightsList.Clear;

  P := 1;

  while P <= Length(UserRights) do
    begin
      NewOne := '';

      // Procura pelo proximo separador
      while (P <= Length(UserRights)) and (UserRights[P] <> ';') do
        begin
          NewOne := NewOne + UserRights[P];
          P := P + 1;
        end;

      P := P + 1;

      UserRightsList.Add(Trim(NewOne));
    end;

end;


end.
