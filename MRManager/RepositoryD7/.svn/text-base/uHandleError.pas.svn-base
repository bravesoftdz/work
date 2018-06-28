unit uHandleError;

interface

uses ADOdb, classes, Sysutils;

const
   //Applications Error type
   CRITICAL_ERROR = 1;
   FAILURE_ERROR  = 2;
   WARNING_ERROR  = 3;

type
  THandleError = class
     private
        FConnection : TADOConnection;
        FID         : Integer;
        FType       : Integer;
        FSource     : String;
        FMsg        : String;
        FDate       : String;
        FIDUser     : Integer;
        function FlushError:boolean;
     public
        Constructor Create;
        Destructor Destroy; override;
        property Connection : TADOCOnnection read FConnection write FConnection;
        function ErrorDetected(iID, iType, iIDUser:Integer; sSource, sMsg, sDate : String):Boolean;
  end;


implementation

function THandleError.FlushError:boolean;
var
  MyQuery : TADOQuery;
  iID     : Integer;
begin

  Result := False;

  if not Assigned(FConnection) then
     Exit;

  Try
     MyQuery := TADOQuery.Create(nil);
     with MyQuery do
        begin
        Connection := FConnection;
        SQL.Add('INSERT Sis_AppHistory (IDHistory, ErrorLevel, FormSource, ErrorMessage, IDUsuario, HistoryDate)');
        SQL.Add('VALUES (' +IntToStr(FID) + ', ' +IntToStr(FType) + ', ' + QuotedStr(FSource) + ', '            );
        SQL.Add(QuotedStr(FMsg) + ', ' + IntToStr(FIDUser) + ', ' +QuotedStr(FDate) + ')' );
        ExecSQL;
        end;
  Finally
     MyQuery.Free;
  end;

  Result := True;

end;

function THandleError.ErrorDetected(iID, iType, iIDUser:Integer; sSource, sMsg, sDate : String):boolean;
begin

   FType   := iType;
   FSource := sSource;
   FMsg    := sMsg;
   FDate   := sDate;
   FIDUser := iIDUser;
   FID     := iID;

   Result := FlushError;

end;


Constructor THandleError.Create;
begin
   inherited Create;
end;

Destructor THandleError.Destroy;
begin
  inherited Destroy;
end;



end.
