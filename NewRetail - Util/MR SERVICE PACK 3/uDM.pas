unit uDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, Db, uSQLObj, uSystemObj;

type
  TSrvParam = Array of Variant;


    //Object instantiated from uSystemObj
  TMRSystem = Class(TSystem)
    private
      fLocalPath      : String;
      fVersionType    : String;
      fExpirationDate : Integer;
      fSystemDate     : Integer;
      //fSrvParam    : Variant;
      fSrvParam       : TSrvParam;
      fLogo           : TPicture;
      fWinDateFormat: String;
      fMRBuildValidate : Boolean;
      function ConvertParam(SrvValue, SrvType : String) : Variant;
    public
      property SrvParam       : TSrvParam read fSrvParam       write fSrvParam;
      property VersionType    : String    read fVersionType    write fVersionType;
      property LocalPath      : String    read fLocalPath      write fLocalPath;
      property ExpirationDate : Integer   read fExpirationDate write fExpirationDate;
      property SystemDate     : Integer   read fSystemDate     write fSystemDate;
      property WinDateFormat  : String    read fWinDateFormat  write fWinDateFormat;
      property Logo           : TPicture  read fLogo           write fLogo;
      property MRBuildValidate: Boolean   read fMRBuildValidate write fMRBuildValidate;

      Constructor Create;
      Destructor Destroy; override;
  end;

  TDM = class(TDataModule)
    ADOConnection: TADOConnection;
    cmdRumSql: TADOCommand;
    qryVersion: TADOQuery;
    qryVersionVersionNo: TIntegerField;
    qryVersionBuildNo: TIntegerField;
    cmdUpdateVersion: TADOCommand;
    quFreeSQL: TADODataSet;
    ADORestore: TADOConnection;
    qryVersionMRBuild: TIntegerField;
    cmdValidateColumnMRBuild: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    fClientVersion,
    fClientBuild    : Integer;
    FClientMRBuild: Integer;
    procedure GetClientBuild;
  public
    { Public declarations }
    fQtyDecimal: Integer;
    fSystem           : TMRSystem;      //System information
    fSQLConnection  : TSQLConnection;
    property ClientVersion : Integer read fClientVersion write fClientVersion;
    property ClientBuild   : Integer read fClientBuild   write fClientBuild;
    property ClientMRBuild : Integer read FClientMRBuild write FClientMRBuild;

    function ServerConnection : Boolean;
    function RunSQL(SQL:String; var Error : String):Boolean;
    function RunComd(SQL:String):Boolean;
  end;

var
  DM: TDM;

implementation

uses ufrmServerInfo, uParamFunctions, uMsgBox, uNumericFunctions;

{$R *.DFM}


function TDM.RunComd(SQL:String):Boolean;
begin
   Try
     Result := True;

     with cmdRumSql do
        begin
        CommandText := SQL;
        Execute;
        end;

   Except
      raise;
      Result := False;
      end;

end;

function TDM.RunSQL(SQL:String; var Error : String):Boolean;
begin

   Try
     Result := True;

     with cmdRumSql do
        begin
        CommandText := SQL;
//      showMessage('SQL ' + SQL);

        Execute;

//       showmessage('SQL applyed');

        end;

   Except
      on E: Exception do
         begin
         // Antonio 05/06/2016 - to get all detail from error
         Error := format('error: %s in sql: %s', [E.message, sql] );
         Result := False;
         end;
      end;

end;

function TDM.ServerConnection : Boolean;
var
  sResult, sSystem : String;
  FrmServrInfo : TFrmServerInfo;
  bAbort,
  ExitConnection       : Boolean;
begin

  FrmServrInfo := nil;

  FrmServrInfo := TFrmServerInfo.Create(self);

  Result := True;

  try

    sResult := FrmServrInfo.Start('5', False, '', bAbort);

    ExitConnection := bAbort;

    While not ExitConnection do
    try
      fSQLConnection.Server    := ParseParam(sResult, SV_SERVER);
      fSQLConnection.DBAlias   := ParseParam(sResult, SV_DATABASE);
      fSQLConnection.UserName  := ParseParam(sResult, SV_USER);
      fSQLConnection.PW        := ParseParam(sResult, SV_PASSWORD);
      fSQLConnection.WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
      fSQLConnection.UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

      if not fSQLConnection.WinLogin then
         if fSQLConnection.UseNetLib then
         begin
            sResult := SetConnectionStr(fSQLConnection.UserName,
                                        fSQLConnection.PW,
                                        fSQLConnection.DBAlias,
                                        fSQLConnection.Server);
         end
         else
            sResult := SetConnectionStrNoNETLIB(fSQLConnection.UserName,
                                                fSQLConnection.PW,
                                                fSQLConnection.DBAlias,
                                                fSQLConnection.Server)
      else
         if fSQLConnection.UseNetLib then
            sResult := SetWinConnectionStr(fSQLConnection.DBAlias,
                                           fSQLConnection.Server)
         else
            sResult := SetWinConnectionStrNoNETLIB(fSQLConnection.DBAlias,
                                                   fSQLConnection.Server);

      ADOConnection.ConnectionString := sResult;

      ADORestore.ConnectionString := StringReplace(sResult, fSQLConnection.DBAlias, 'master', []);

      ADOConnection.Open;
      ExitConnection := True;
      
   except
     on E: Exception do
        begin
        MsgBox('Connection Error: '+ E.Message, vbOKOnly + vbInformation);
        sResult := FrmServrInfo.Start('5', True, E.Message, bAbort);
        ExitConnection := bAbort;
        Result := ExitConnection;
        end;
   end;

   //Para criar a coluna MRBuild na tabela Sys_Module, caso não existe no BD.
   cmdValidateColumnMRBuild.Execute;

    //Get Version from the Client
    GetClientBuild;

  finally
    FreeAndNil(FrmServrInfo);
  end;


end;

procedure TDM.GetClientBuild;
begin
  try
    with qryVersion do
        begin
        if not Active then
           Open;

        fClientVersion := qryVersionVersionNo.AsInteger;
        fClientBuild   := qryVersionBuildNo.AsInteger;
        FClientMRBuild := qryVersionMRBuild.AsInteger;

        Close;
        end;
   except
      Raise;
      end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  fSQLConnection  := TSQLConnection.Create;
  fSystem          := TMRSystem.Create;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fSQLConnection);

  if Assigned(fSystem) then
     FreeAndNil(fSystem);

end;

{ TMRSystem }

function TMRSystem.ConvertParam(SrvValue, SrvType: String): Variant;
var
  MyType, MyValue : String;
begin

  MyType  := Trim(UpperCase(SrvType));
  MyValue := Trim(SrvValue);

  if MyType = 'STRING' then
    begin
     Result := MyValue;
    end
  else if MyType = 'BOOLEAN' then
    begin
     Result := (UpperCase(MyValue) = 'TRUE')
    end
  else if MyType = 'INTEGER' then
    begin
     Result := StrToIntDef(UpperCase(MyValue),0)
    end
  else if MyType = 'FLOAT' then
    begin
     Result := MyStrToMoney(UpperCase(MyValue))
    end;
end;

constructor TMRSystem.Create;
begin

end;

destructor TMRSystem.Destroy;
begin

  inherited;
end;

end.
