Unit uDownloadFunctions;

Interface

Uses
  Windows,     Messages, SysUtils,        Variants,    Classes,  Graphics, Controls,
  IdComponent, idFTP,    IdTCPConnection, IdTCPClient,
  StdCtrls,    UrlMon,   Forms,           ComCtrls,    ShellApi, ActiveX;

Type

  { Types }
  EServerType = ( stNone, stFTP, stHTTP );

  { Exceções }
  EServerTypeNotSet = class( Exception );
  EDirectoryDoesNotExist = class( Exception );

  { Fazer interface de callback para o download }
  TDownloadInterface = class(TInterfacedObject, IBindStatusCallback)
  private

  Public

    FCallBackProgressBar : TProgressBar;
    FCallBackLabel: TLabel;

    Function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    Function GetPriority(out nPriority): HResult; stdcall;
    Function OnLowResource(reserved: DWORD): HResult; stdcall;
    Function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;szStatusText: LPCWSTR): HResult; stdcall;
    Function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
    Function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
    Function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
    Function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;

  End;

  TDownloadFile = class( TObject )
  Private
    FCallBackProgressBar : TProgressBar;
    FCallBackLabel: TLabel;

    FSource: String;
    FDestination: String;
    FServerType: EServerType;
    FUserName: String;
    FHost: String;
    FPassword: String;

    procedure SetCallBackProgressBar( const Value : TProgressBar );
    procedure SetCallBackLabel(const Value: TLabel);

    procedure SetSource(const Value: String);
    procedure SetDestination(const Value: String);
    procedure SetServerType(const Value: EServerType);

    Procedure OnFTPClientWorkBegin( Sender : TObject; AWorkMode : TWorkMode; Const AWorkCountMax : Integer );
    Procedure OnFTPClientWork( ASender: TObject; AWorkMode: TWorkMode; Const AWorkCount : Integer );

    Procedure Validate();

    Function  DownloadFileFromFTP() : Boolean;
    procedure SetHost(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetUserName(const Value: String);


  Public

    Property ServerType : EServerType read FServerType write SetServerType;

    Property Source : String read FSource write SetSource;
    Property Destination : String read FDestination write SetDestination;

    Property Host     : String read FHost write SetHost;
    Property UserName : String read FUserName write SetUserName;
    Property Password : String read FPassword write SetPassword;

    Property CallBackLabel       : TLabel read FCallBackLabel write SetCallBackLabel;
    Property CallBackProgressBar : TProgressBar read FCallBackProgressBar write SetCallBackProgressBar;

    Constructor Create(); OverLoad;
    Destructor Destroy(); OverLoad;

    Function Start() : Boolean;

  End;

Implementation

{==============================================================================}
{ TDownloadInterface                                                           }
Function TDownloadInterface.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult;
Begin

End;

Function TDownloadInterface.GetPriority(out nPriority): HResult;
Begin

End;

Function TDownloadInterface.OnDataAvailable(grfBSCF, dwSize: DWORD; formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
Begin

End;

Function TDownloadInterface.OnLowResource(reserved: DWORD): HResult;
Begin

End;

Function TDownloadInterface.OnObjectAvailable(const iid: TGUID; punk: IInterface): HResult;
Begin

End;

Function TDownloadInterface.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult;
Begin

  If ( Assigned( FCallBackProgressBar ) ) Then Begin

    Application.ProcessMessages;

    Case ulStatusCode Of

      // 1: FrPrincipal.StaticText1.Caption := 'Conectando em: ' + szStatusText;

      // 2: FrPrincipal.StaticText1.Caption := 'Conectado em: ' + szStatusText;

      // 3: FrPrincipal.StaticText1.Caption := 'Redirecionando para: ' + szStatusText;

      4: Begin
           //FrPrincipal.StaticText1.Caption := 'Fazendo Download: ' + szStatusText;
           //FrPrincipal.barra.MaxValue := ulProgressMax;
           //FrPrincipal.barra.Progress := ulProgressMax - ulProgress;

           FCallBackProgressBar.Max  := ulProgressMax;


         End;

      5: Begin

           FCallBackProgressBar.Position := ulProgress;

          //FrPrincipal.StaticText2.Caption := 'Baixando: ' + FormatFloat('#.#,', ulProgress div 1024) + ' de ' +
          //                                                  FormatFloat('#.#,', ulProgressMax div 1024) + 'Kb';
          //FrPrincipal.barra.MaxValue := ulProgressMax;
          //// FrPrincipal.barra.Progress := ulProgressMax - ulProgress; // descomente este para fazer decrecente
          //FrPrincipal.barra.Progress := ulProgress;

         End;

      6: Begin

           FCallBackProgressBar.Position := 0;

           //FrPrincipal.StaticText1.Caption := 'Final de Download: ' + szStatusText;
           //
           //FrPrincipal.StaticText2.Caption := 'Baixando: ' +
           //  FormatFloat('#.#,', ulProgressMax div 1024) + ' de ' +
           //  FormatFloat('#.#,', ulProgressMax div 1024) + 'Kb';

         End;

    End; { Case }

  End; { If ( Assigned( FCallBackProgressBar ) ) Then Begin }

End; { TDownloadInterface.OnProgress }

Function TDownloadInterface.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
Begin

End;

Function TDownloadInterface.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult;
Begin

End;

{==============================================================================}
{ TDownloadFile                                                                }
Constructor TDownloadFile.Create();
Begin
  Inherited;

  FServerType := stNone;

End; { Create }


Destructor TDownloadFile.Destroy;
Begin

  Inherited;

End; { Destroy }


Procedure TDownloadFile.SetCallBackLabel(const Value: TLabel);
Begin
  FCallBackLabel := Value;
End;


Procedure TDownloadFile.SetCallBackProgressBar( const Value: TProgressBar );
Begin
  FCallBackProgressBar := Value;
End;


Procedure TDownloadFile.SetSource(const Value: String);
Begin
  FSource := Value;
End;


Procedure TDownloadFile.SetServerType(const Value: EServerType);
Begin
  FServerType := Value;
End;


Procedure TDownloadFile.SetDestination(const Value: String);
Begin
  FDestination := Value;
End;


Procedure TDownloadFile.SetHost(const Value: String);
Begin
  FHost := Value;
End;


Procedure TDownloadFile.SetPassword(const Value: String);
Begin
  FPassword := Value;
End;


Procedure TDownloadFile.SetUserName(const Value: String);
Begin
  FUserName := Value;
End;


Procedure TDownloadFile.OnFTPClientWorkBegin( Sender : TObject; AWorkMode : TWorkMode; Const AWorkCountMax : Integer );
Begin

  If ( Assigned( FCallBackProgressBar ) ) Then FCallBackProgressBar.Max := AWorkCountMax;

End; { OnFTPClientWorkBegin }


Procedure TDownloadFile.OnFTPClientWork( ASender: TObject; AWorkMode : TWorkMode; Const AWorkCount : Integer );
Begin

  If ( Assigned( FCallBackProgressBar ) ) Then Begin

    Application.ProcessMessages;

    FCallBackProgressBar.Position := AWorkCount;

  End; { If ( Assigned( FCallBackProgressBar ) ) Then Begin }

End; { OnFTPClientWork(  }



Procedure TDownloadFile.Validate;
Begin

  If ( ServerType = stNone ) Then Raise EServerTypeNotSet.Create( 'Server type not set' );
  If ( Not DirectoryExists( ExtractFilePath( FDestination )  ) ) Then Raise EDirectoryDoesNotExist.Create( 'Destination folder does not exist' );

End; { Validate }


Function TDownloadFile.Start() : Boolean;
Var
  DownloadInterface : TDownloadInterface;
  lpszFile : Array [0..MAX_PATH] of Char;
Begin

  //If Pos('MANIF', FSource ) <= 0 Then Begin
  // Result := True;
  // Exit;
  //End;

  Result := False;

  DownloadInterface := TDownloadInterface.Create();
  DownloadInterface.FCallBackProgressBar := Self.FCallBackProgressBar;

  Validate();

  If ( FServerType = stHTTP ) Then Begin

    { Use URLDownloadToCacheFile function to ignore the cache with BINDF_GETNEWESTVERSION option }

    //Result := UrlDownloadToFile( Nil, PChar( FSource ), PChar( FDestination ), 0, DownloadInterface ) = 0

    If ( URLDownloadToCacheFile( Nil, PChar( FSource ), @lpszFile, MAX_PATH, BINDF_GETNEWESTVERSION, DownloadInterface ) = S_OK )
    Then Result := CopyFile( @lpszFile, PChar( FDestination ), False )

  End Else Begin

    Result := DownloadFileFromFTP();

  End;

  DownloadInterface.FCallBackLabel       := Nil;
  DownloadInterface.FCallBackProgressBar := Nil;

  Try If ( DownloadInterface <> Nil ) Then FreeAndNil( DownloadInterface ) Except End;

End;


Function TDownloadFile.DownloadFileFromFTP : Boolean;
Var
  idFTPClient : TIdFTP;
Begin

  idFTPClient := TIdFTP.Create( TComponent( Self ) );

  idFTPClient.OnWorkBegin := OnFTPClientWorkBegin;
  idFTPClient.OnWork      := OnFTPClientWork;

  idFTPClient.Disconnect();

  idFTPClient.Host           := FHost;
  idFTPClient.Port           := 21;
  idFTPClient.Username       := FUserName;
  idFTPClient.Password       := FPassword;
  idFTPClient.Passive        := false; { usa modo ativo }

  idFTPClient.Connect();

  idFTPClient.ChangeDir( ExtractFilePath( FSource ) );
  idFTPClient.Get( FSource, FDestination, True);

  idFTPClient.Disconnect();

  FreeAndNil( idFTPClient );

  Result := True;

End; { DownloadFileFromFTP }


End.
