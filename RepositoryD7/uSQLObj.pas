unit uSQLObj;

interface

uses uParentClass;

type
  TSQL = Class(TParentClass)
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
      fConType   : String;
      fUseNetLib : Boolean;
      fExpiration: String;
      fSQLEdition: String;
      fSQLVersion: String;
      fSQLLevel  : String;
      public
         function toString  : String;
         property PW        : String  read fPW         write fPW;
         property UserName  : String  read fUserName   write fUserName;
         property DBAlias   : String  read fDBAlias    write fDBAlias;
         property Server    : String  read fServer     write fServer;
         property WinLogin  : Boolean read fWinLogin   write fWinLogin;
         property Status    : String  read fStatus     write fStatus;
         property Time      : String  read fTime       write fTime;
         property ConType   : String  read fConType    write fConType;
         property UseNetLib : Boolean read fUseNetLib  write fUseNetLib;
         property Expiration: String  read fExpiration write fExpiration;
         property SQLVersion: String  read fSQLVersion write fSQLVersion;
         property SQLLevel  : String  read fSQLLevel   write fSQLLevel;
         property SQLEdition: String  read fSQLEdition write fSQLEdition;
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
             'Since         :'   + fTime    + #13#10 +
             'Type          :'   + fConType + #13#10 +
             'Expiration    :'   + fExpiration + #13#10 +
             'MSSQL Edition :'   + SQLEdition  + #13#10 +
             'MSSQL Version :'   + SQLVersion  + #13#10 +
             'MSSQL Level   :'   + SQLLevel;

end;

end.
