unit uSQLObj;

interface

type
  TSQL = Class
     private
     public
  end;

  TSQLConnection = Class(TSQL)
      private
      fPW        : String;
      fUserName  : String;
      fDBAlias   : String;
      fServer    : String;
      fWinLogin  : Boolean;
      fStatus    : String;
      fTime      : String;
      public
         function toString : String;
         property PW       : String  read fPW       write fPW;
         property UserName : String  read fUserName write fUserName;
         property DBAlias  : String  read fDBAlias  write fDBAlias;
         property Server   : String  read fServer   write fServer;
         property WinLogin : Boolean read fWinLogin write fWinLogin;
         property Status   : String  read fStatus   write fStatus;
         property Time     : String  read fTime     write fTime;
  end;


implementation

function TSQLConnection.toString : String;
var
  sAut : string;
begin

   if not fWinLogin then
      begin
      sAut := 'Authentication:SQL' + #13#10 +
              'User          :' + fUserName;
      end
   else
      sAut := 'Authentication:Windows';


   Result := 'Connection string' + #13#10   +
             'Server        :'   + fServer  + #13#10 +
             'Database      :'   + fDBAlias + #13#10 +
             sAut                           + #13#10 +
             'Status        :'   + fStatus  + #13#10 +
             'Since         :'   + fTime;

end;

end.
