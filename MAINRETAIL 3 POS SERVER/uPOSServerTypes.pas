unit uPOSServerTypes;

interface

type

  TServerConnection = class
     private
       fClientInfo        : String;
       fClientVersion     : String;
       fConnectionTimeOut : Integer;
       fConnectType       : Integer;
       fPort              : Integer;
       fPOSDir            : String;
       fUser              : String;
       fPW                : String;
       fGlobalDir         : String;
       fFTP               : String;
     public
       property ClientInfo        : String  read fClientInfo        write fClientInfo;
       property ClientVersion     : String  read fClientVersion     write fClientVersion;
       property ConnectionTimeOut : Integer read fConnectionTimeOut write fConnectionTimeOut;
       property ConnectType       : Integer read fConnectType       write fConnectType;
       property FTP               : String  read fFTP               write fFTP;
       property Port              : Integer read fPort              write fPort;
       property User              : String  read fUser              write fUser;
       property PW                : String  read fPW                write fPW;
       property GlobalDir         : String  read fGlobalDir         write fGlobalDir;
       property POSDir            : String  read fPOSDir            write fPOSDir;
  end;

  TLocalSetting = class
     private
       fIDStoreList   : String;
       fIDDefaulStore : String;
       fDeleteLog: TDateTime;
     public
       property IDDefaulStore : String    read fIDDefaulStore  write fIDDefaulStore;
       property IDStoreList   : String    read fIDStoreList    write fIDStoreList;
       property DeleteLog     : TDateTime read fDeleteLog      write fDeleteLog;
  end;

  TCashRegInfo = class
    public
      IDCashreg: Integer;
      CashRegName: String;
      LastImportDate: TDateTime;
      LastImportedFileName: String;
      LastImportedFileDate: String;
      IncludeSince: String;
  end;


  TOnNeedWriteIniBool     = procedure (ASection, AKey: String; AValue: Boolean) of object;
  TOnNeedWriteIniDateTime = procedure (ASection, AKey: String; AValue: TDateTime) of object;
  TOnNeedWriteIniString   = procedure (ASection, AKey: String; AValue: String) of object;
  TOnNeedWriteIniInteger  = procedure (ASection, AKey: String; AValue: Integer) of object;
  TSyncLogEvent           = procedure(Sender: TObject; const Text: string) of object;
  TPOSServerStatusEvent   = procedure (Msg: String; Count: Integer ) of Object;
  TPOSServerStepCompleted = procedure of Object;
  TPOSServerCompleted     = procedure of Object;

  TOnSaveNextSchedule     = procedure (sType:String) of object;

implementation


end.
