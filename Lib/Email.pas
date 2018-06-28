unit Email;

interface 
{ 
Changelog: 
13.04.2001 Fixed memory Leak and String problem in adresses (Sendmail - method) 
31.08.2000 Some Changes on the TStrings Objects, added SetXXAdr-Methods 
}
uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs; 

type 
  { Introducing a new Type of Event to get the Errorcode } 
  TMapiErrEvent = procedure(Sender: TObject; ErrCode: Integer) of object; 

  TEmail = class(TComponent)
    constructor Create(AOwner: TComponent); override; 
    destructor Destroy; override; 
  private 
    { Private-Deklarationen } 
    FSubject: string; 
    FMailtext: string; 
    FFromName: string; 
    FFromAdress: string; 
    FTOAdr: TStrings; 
    FCCAdr: TStrings; 
    FBCCAdr: TStrings; 
    FAttachedFileName: TStrings; 
    FDisplayFileName: TStrings; 
    FShowDialog: Boolean; 
    FUseAppHandle: Boolean; 
    { Error Events: } 
    FOnUserAbort: TNotifyEvent; 
    FOnMapiError: TMapiErrEvent; 
    FOnSuccess: TNotifyEvent; 
    { +> Changes by Eugene Mayevski [mailto:Mayevski@eldos.org]} 
    procedure SetToAddr(newValue: TStrings); 
    procedure SetCCAddr(newValue: TStrings); 
    procedure SetBCCAddr(newValue: TStrings); 
    procedure SetAttachedFileName(newValue: TStrings); 
    { +< Changes } 
  protected 
    { Protected-Deklarationen } 
  public 
    { Public-Deklarationen } 
    ApplicationHandle: THandle; 
    procedure Sendmail(); 
    procedure Reset(); 
  published 
    { Published-Deklarationen } 
    property Subject: string read FSubject write FSubject; 
    property Body: string read FMailText write FMailText; 
    property FromName: string read FFromName write FFromName; 
    property FromAdress: string read FFromAdress write FFromAdress; 
    property Recipients: TStrings read FTOAdr write SetTOAddr; 
    property CopyTo: TStrings read FCCAdr write SetCCAddr; 
    property BlindCopyTo: TStrings read FBCCAdr write SetBCCAddr; 
    property AttachedFiles: TStrings read FAttachedFileName write SetAttachedFileName; 
    property DisplayFileName: TStrings read FDisplayFileName; 
    property ShowDialog: Boolean read FShowDialog write FShowDialog; 
    property UseAppHandle: Boolean read FUseAppHandle write FUseAppHandle; 

    { Events: } 
    property OnUserAbort: TNotifyEvent read FOnUserAbort write FOnUserAbort; 
    property OnMapiError: TMapiErrEvent read FOnMapiError write FOnMapiError; 
    property OnSuccess: TNotifyEvent read FOnSuccess write FOnSuccess; 
  end; 

procedure Register; 

implementation 

uses Mapi; 

{ Register the component: } 

procedure Register; 
begin 
  RegisterComponents('NewPower', [TEmail]); 
end; 

{ TEmail } 

constructor TEmail.Create(AOwner: TComponent); 
begin 
  inherited Create(AOwner); 
  FOnUserAbort := nil; 
  FOnMapiError := nil; 
  FOnSuccess := nil; 
  FSubject := ''; 
  FMailtext := ''; 
  FFromName := ''; 
  FFromAdress := ''; 
  FTOAdr := TStringList.Create; 
  FCCAdr := TStringList.Create; 
  FBCCAdr := TStringList.Create; 
  FAttachedFileName := TStringList.Create; 
  FDisplayFileName := TStringList.Create; 
  FShowDialog := False; 
  ApplicationHandle := Application.Handle; 
end; 

{ +> Changes by Eugene Mayevski [mailto:Mayevski@eldos.org]} 

procedure TEmail.SetToAddr(newValue: TStrings);
begin 
  FToAdr.Assign(newValue); 
end; 

procedure TEmail.SetCCAddr(newValue: TStrings); 
begin 
  FCCAdr.Assign(newValue); 
end; 

procedure TEmail.SetBCCAddr(newValue: TStrings); 
begin 
  FBCCAdr.Assign(newValue); 
end; 

procedure TEmail.SetAttachedFileName(newValue: TStrings); 
begin 
  FAttachedFileName.Assign(newValue); 
end; 
{ +< Changes } 

destructor TEmail.Destroy; 
begin 
  FTOAdr.Free; 
  FCCAdr.Free; 
  FBCCAdr.Free; 
  FAttachedFileName.Free; 
  FDisplayFileName.Free; 
  inherited destroy; 
end; 

{ Reset the fields for re-use} 

procedure TEmail.Reset; 
begin 
  FSubject := ''; 
  FMailtext := ''; 
  FFromName := ''; 
  FFromAdress := ''; 
  FTOAdr.Clear; 
  FCCAdr.Clear; 
  FBCCAdr.Clear; 
  FAttachedFileName.Clear; 
  FDisplayFileName.Clear; 
end; 

{ Send the Mail via the API, this procedure composes and sends 
  the Email } 

procedure TEmail.Sendmail; 
var 
  MapiMessage: TMapiMessage; 
  MError: Cardinal; 
  Sender: TMapiRecipDesc; 
  PRecip, Recipients: PMapiRecipDesc; 
  PFiles, Attachments: PMapiFileDesc; 
  i: Integer; 
  AppHandle: THandle; 
begin 
  { First we store the Application Handle, if not 
    the Component might fail to send the Email or 
    your calling Program gets locked up. } 
  AppHandle := Application.Handle; 

  { Initialize the Attachment Pointer, to keep Delphi quiet } 
  PFiles := nil; 

  { We need all recipients to alloc the memory } 
  MapiMessage.nRecipCount := FTOAdr.Count + FCCAdr.Count + FBCCAdr.Count; 
  GetMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc)); 

  try 
    with MapiMessage do 
      begin 
        ulReserved := 0; 
        { Setting the Subject: } 
        lpszSubject := PChar(Self.FSubject); 

        { ... the Body: } 
        lpszNoteText := PChar(FMailText); 

        lpszMessageType := nil; 
        lpszDateReceived := nil; 
        lpszConversationID := nil; 
        flFlags := 0; 

        { and the sender: (MAPI_ORIG) } 
        Sender.ulReserved := 0; 
        Sender.ulRecipClass := MAPI_ORIG; 
        Sender.lpszName := PChar(FromName); 
        Sender.lpszAddress := PChar(FromAdress); 
        Sender.ulEIDSize := 0; 
        Sender.lpEntryID := nil; 
        lpOriginator := @Sender; 

        PRecip := Recipients; 

        { We have multiple recipients: (MAPI_TO) 
          and setting up each: } 
        if nRecipCount > 0 then 
          begin 
            for i := 1 to FTOAdr.Count do 
              begin 
                PRecip^.ulReserved := 0; 
                PRecip^.ulRecipClass := MAPI_TO; 
                { lpszName should carry the Name like in the 
                  contacts or the adress book, I will take the 
                  email adress to keep it short: } 
                PRecip^.lpszName := PChar(FTOAdr.Strings[i - 1]); 
                { If you use this component with Outlook97 or 2000 
                  and not some of Express versions you will have to set 
                  'SMTP:' in front of each (email-) adress. Otherwise 
                  Outlook/Mapi will try to handle the Email on itself. 
                  Sounds strange, just erease the 'SMTP:', compile, compose 
                  a mail and take a look at the resulting email adresses 
                  (right click). 
                } 
                { +> Changes by Andreas Hoerig [mailto:andreas.hoerig@sillner.com] } 
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FTOAdr.Strings[i - 1])); 
                { +< Changes  } 
                PRecip^.ulEIDSize := 0; 
                PRecip^.lpEntryID := nil; 
                Inc(PRecip); 
              end; 

            { Same with the carbon copy recipients: (CC, MAPI_CC) } 
            for i := 1 to FCCAdr.Count do 
              begin 
                PRecip^.ulReserved := 0; 
                PRecip^.ulRecipClass := MAPI_CC; 
                PRecip^.lpszName := PChar(FCCAdr.Strings[i - 1]); 
                { +> Changes by Andreas Hoerig [mailto:andreas.hoerig@sillner.com] } 
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FCCAdr.Strings[i - 1])); 
                { +< Changes  } 
                PRecip^.ulEIDSize := 0; 
                PRecip^.lpEntryID := nil; 
                Inc(PRecip); 
              end; 

            { ... and the blind copy recipients: (BCC, MAPI_BCC) } 
            for i := 1 to FBCCAdr.Count do 
              begin 
                PRecip^.ulReserved := 0; 
                PRecip^.ulRecipClass := MAPI_BCC; 
                PRecip^.lpszName := PChar(FBCCAdr.Strings[i - 1]); 
                { +> Changes by Andreas Hoerig [mailto:andreas.hoerig@sillner.com] } 
                PRecip^.lpszAddress := StrNew(PChar('SMTP:' + FBCCAdr.Strings[i - 1])); 
                { +< Changes  } 
                PRecip^.ulEIDSize := 0; 
                PRecip^.lpEntryID := nil; 
                Inc(PRecip); 
              end; 
          end; 
        lpRecips := Recipients; 

        { Now we process the attachments: } 
        nFileCount := FAttachedFileName.Count; 
        if nFileCount > 0 then 
          begin 
            GetMem(Attachments, nFileCount * sizeof(TMapiFileDesc)); 
            PFiles := Attachments; 

            { Fist setting up the display names (without path): } 
            FDisplayFileName.Clear; 
            for i := 1 to FAttachedFileName.Count do 
              FDisplayFileName.Add(ExtractFileName(FAttachedFileName[i - 1])); 

            if nFileCount > 0 then 
              begin 
                { Now we pass the attached file (their paths) to the 
                  structure: } 
                for i := 1 to FAttachedFileName.Count do 
                  begin 
                    { Setting the complete Path } 
                    Attachments^.lpszPathName := PChar(FAttachedFileName.Strings[i - 1]); 
                    { ... and the displayname: } 
                    Attachments^.lpszFileName := PChar(FDisplayFileName.Strings[i - 1]); 
                    Attachments^.ulReserved := 0; 
                    Attachments^.flFlags := 0; 
                    { Position has to be -1, please see the WinApi Help 
                      for details. } 
                    Attachments^.nPosition := Cardinal(-1); 
                    Attachments^.lpFileType := nil; 
                    Inc(Attachments); 
                  end; 
              end; 
            lpFiles := PFiles; 
          end 
        else 
          begin 
            nFileCount := 0; 
            lpFiles := nil; 
          end; 
      end; 

    { Send the Mail, silent or verbose: 
      Verbose means in Express a Mail is composed and shown as setup. 
      In non-Express versions we show the Login-Dialog for a new 
      session and after we have choosen the profile to use, the 
      composed email is shown before sending 

      Silent does currently not work for non-Express version. We have 
      no Session, no Login Dialog so the system refuses to compose a 
      new email. In Express Versions the email is sent in the 
      background. 

      Please Note: It seems that your success on the delivery depends 
      on a combination of MAPI-Flags (MAPI_DIALOG, MAPI_LOGON_UI, ...) 
      and your used OS and Office Version. I am currently using 
      Win2K SP1 and Office 2K SP2 with no problems at all. 
      If you experience problems on another versions, please try 
      a different combination of flags for each purpose (Dialog or not). 
      I would be glad to setup a table with working flags on 
      each OS/Office combination, just drop me a line. 

      Possible combinations are also (with Dialog): 
      1. MAPI_DIALOG or MAPI_LOGON_UI MAPI_NEW_SESSION or MAPI_USE_DEFAULT 
      2. MAPI_SIMPLE_DEFAULT 

      See MAPI.PAS or MAPI.H (SDK) for more... 
     } 
    if FShowDialog then 
      MError := MapiSendMail(0, AppHandle, MapiMessage, MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0) 
    else 
      MError := MapiSendMail(0, AppHandle, MapiMessage, 0, 0); 

    { Now we have to process the error messages. There are some 
      defined in the MAPI unit please take a look at the unit to get 
      familiar with it. 
      I decided to handle USER_ABORT and SUCCESS as special and leave 
      the rest to fire the "new" error event defined at the top (as 
      generic error) 

      Not treated as special (constants from mapi.pas): 

      MAPI_E_FAILURE = 2; 
      MAPI_E_LOGON_FAILURE = 3; 
      MAPI_E_LOGIN_FAILURE = MAPI_E_LOGON_FAILURE; 
      MAPI_E_DISK_FULL = 4; 
      MAPI_E_INSUFFICIENT_MEMORY = 5; 
      MAPI_E_ACCESS_DENIED = 6; 
      MAPI_E_TOO_MANY_SESSIONS = 8; 
      MAPI_E_TOO_MANY_FILES = 9; 
      MAPI_E_TOO_MANY_RECIPIENTS = 10; 
      MAPI_E_ATTACHMENT_NOT_FOUND = 11; 
      MAPI_E_ATTACHMENT_OPEN_FAILURE = 12; 
      MAPI_E_ATTACHMENT_WRITE_FAILURE = 13; 
      MAPI_E_UNKNOWN_RECIPIENT = 14; 
      MAPI_E_BAD_RECIPTYPE = 15; 
      MAPI_E_NO_MESSAGES = 16; 
      MAPI_E_INVALID_MESSAGE = 17; 
      MAPI_E_TEXT_TOO_LARGE = 18; 
      MAPI_E_INVALID_SESSION = 19; 
      MAPI_E_TYPE_NOT_SUPPORTED = 20; 
      MAPI_E_AMBIGUOUS_RECIPIENT = 21; 
      MAPI_E_AMBIG_RECIP = MAPI_E_AMBIGUOUS_RECIPIENT; 
      MAPI_E_MESSAGE_IN_USE = 22; 
      MAPI_E_NETWORK_FAILURE = 23; 
      MAPI_E_INVALID_EDITFIELDS = 24; 
      MAPI_E_INVALID_RECIPS = 25; 
      MAPI_E_NOT_SUPPORTED = 26; 
    } 

    case MError of 
      MAPI_E_USER_ABORT: 
        begin 
          if Assigned(FOnUserAbort) then 
            FOnUserAbort(Self); 
        end; 
      SUCCESS_SUCCESS: 
        begin 
          if Assigned(FOnSuccess) then 
            FOnSuccess(Self); 
        end 
      else 
        begin 
          if Assigned(FOnMapiError) then 
            FOnMapiError(Self, MError); 
        end; 

    end; 
  finally 
    { Finally we do the cleanups, the message should be on its way } 
    { +> Changes by Andreas Hoerig [mailto:andreas.hoerig@sillner.com] } 
    PRecip := Recipients; 
    for i := 1 to MapiMessage.nRecipCount do 
      begin 
        StrDispose(PRecip^.lpszAddress); 
        Inc(PRecip) 
      end; 
    { +< Changes } 
    FreeMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc)); 
    { +> Changes due to Ken Halliwell [mailto:kjhalliwell@aol.com] } 
    if Assigned(PFiles) then 
      FreeMem(PFiles, MapiMessage.nFileCount * sizeof(TMapiFileDesc)); 
    { +< Changes } 
  end; 
end; 

{ 
  Please treat this as free. If you improve the component 
  I would be glad to get a copy. 
} 

end. 

