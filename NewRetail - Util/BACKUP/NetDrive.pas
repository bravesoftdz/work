(*

  This component was downloaded from the
  About Delphi Programming site

  http://delphi.about.com

  TNetDrive is a non-visual component that connects a network path to a drive name.

  Find more: http://delphi.about.com/library/weekly/aa061506a.htm

*)


unit NetDrive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TNetDrive = class(TComponent)
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  private
    FErrorString: string;
    FDrive: string;
    FOnDisconnect: TNotifyEvent;
    FOnConnect: TNotifyEvent;
    procedure SetOnConnect(const Value: TNotifyEvent);
    procedure SetOnDisconnect(const Value: TNotifyEvent);
    function FreeDriveName:string;
    function DriveExists(ADrive:string):boolean;
    procedure Delay(Ams:integer);
  protected
  public

    //Yanniel: I refactored this method to avoid code duplication
    function Connect(AResource,AUser,APassword:string):string; overload;

    //Yanniel: I added this overloaded method
    function Connect(AResource, AUser, APassword: string; out AError: string): string; overload;

    //Yanniel: I refactored this method to avoid code duplication
    function Disconnect:boolean; overload;

    //Yanniel: I added this overloaded method
    function Disconnect(out AError: string):boolean; overload;

    property Drive:string read FDrive write FDrive;
    property ErrorString:string read FErrorString;
  published
    property OnConnect:TNotifyEvent read FOnConnect write SetOnConnect;
    property OnDisconnect:TNotifyEvent read FOnDisconnect write SetOnDisconnect;
  end;

procedure Register;

implementation
uses
  FileCtrl;

procedure Register;
begin
  RegisterComponents('delphi.about.com', [TNetDrive]);
end;

{ TNetDrive }

//Yanniel: I refactored this method to avoid code duplication
function TNetDrive.Connect(AResource, AUser, APassword: string): string;
var
  ErrorMsg: string;
begin
  Result:= Connect(AResource, AUser, APassword, ErrorMsg);
  if ErrorMsg <> '' then
    ShowMessage(ErrorMsg);
end;

//Yanniel: I added this overloaded method
function TNetDrive.Connect(AResource, AUser, APassword: string; out AError: string): string;
var
  n : NETRESOURCE;
  i : integer;
begin
FDrive:='';
n.dwScope:=RESOURCE_GLOBALNET;
n.dwType:=RESOURCETYPE_DISK;
n.dwDisplayType:=RESOURCEDISPLAYTYPE_GENERIC;
n.dwUsage:=RESOURCEUSAGE_CONNECTABLE;
n.lpLocalName:=PChar(FreeDriveName);
n.lpRemoteName:=PChar(AResource);
n.lpComment:='';
n.lpProvider:='';
i:=WNetAddConnection2(n,PChar(APassword),PChar(AUser),0);
case i of
  NO_ERROR                          : begin
                                      delay(500);
                                      FDrive:=n.lpLocalName;
                                      repeat until DriveExists(FDrive);
                                      end;
  ERROR_ACCESS_DENIED	              : AError:= 'Access to the network resource was denied.';
  ERROR_ALREADY_ASSIGNED	          : AError:= 'The local device specified by lpLocalName is already connected to a network resource.';
  ERROR_BAD_DEV_TYPE	              : AError:= 'The type of local device and the type of network resource do not match.';
  ERROR_BAD_DEVICE	                : AError:= 'The value specified by lpLocalName is invalid.';
  ERROR_BAD_NET_NAME	              : AError:= 'The value specified by lpRemoteName is not acceptable to any network resource provider. The resource name is invalid, or the named resource cannot be located.';
  ERROR_BAD_PROFILE	                : AError:= 'The user profile is in an incorrect format.';
  ERROR_BAD_PROVIDER	              : AError:= 'The value specified by lpProvider does not match any provider.';
  ERROR_BUSY	                      : AError:= 'The router or provider is busy, possibly initializing. The caller should retry.';
  ERROR_CANCELLED	                  : AError:= 'The attempt to make the connection was cancelled by the user through a dialog box from one of the network resource providers, or by a called resource.';
  ERROR_CANNOT_OPEN_PROFILE	        : AError:= 'The system is unable to open the user profile to process persistent connections.';
  ERROR_DEVICE_ALREADY_REMEMBERED	  : AError:= 'An entry for the device specified in lpLocalName is already in the user profile.';
  ERROR_EXTENDED_ERROR	            : AError:= 'A network-specific error occured. Call the WNetGetLastError function to get a description of the error.';
  ERROR_INVALID_PASSWORD	          : AError:= 'The specified password is invalid.';
  ERROR_NO_NET_OR_BAD_PATH	        : AError:= 'A network component has not started, or the specified name could not be handled.';
  ERROR_NO_NETWORK	                : AError:= 'There is no network present.';
  else                                AError:= 'An unknown error has occured attempting to connect to '+AResource+'.';
end;
if Assigned(FOnConnect) then
  FOnConnect(self);
Result:=FDrive;

end;

constructor TNetDrive.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
FErrorString:='';
FDrive:='';
FOnDisconnect:=nil;
FOnConnect:=nil;
end;

procedure TNetDrive.Delay(Ams: integer);
var
  h,m,s,ms  : word;
  dt        : TDateTime;
begin
DecodeTime(Time,h,m,s,ms);
ms:=ms+Ams;
while ms>999 do
  begin
  inc(s,1);
  dec(ms,1000);
  end;
while s>59 do
  begin
  inc(m,1);
  dec(s,60);
  end;
while m>59 do
  begin
  inc(h,1);
  dec(m,60);
  end;

dt:=EncodeTime(h,m,s,ms);
repeat until Time>dt;
end;

destructor TNetDrive.Destroy;
begin
inherited Destroy;
end;

//Yanniel: I refactored this method to avoid code duplication
function TNetDrive.Disconnect: boolean;
var
  ErrorMsg: string;
begin
  Result:= Disconnect(ErrorMsg);
  if ErrorMsg <> '' then
    ShowMessage(ErrorMsg);
end;

//Yanniel: I added this overloaded method
function TNetDrive.Disconnect(out AError: string):boolean;
begin
  result:=false;
if FDrive<>'' then
  begin
  case WNetCancelConnection2(PChar(FDrive),0,true) of
    NO_ERROR                  : begin
                                FDrive:='';
                                Result:=true;
                                end;
    ERROR_BAD_PROFILE	        : AError:= 'The user profile is in an incorrect format.';
    ERROR_CANNOT_OPEN_PROFILE	: AError:= 'The system is unable to open the user profile to process persistent connections.';
    ERROR_DEVICE_IN_USE	      : AError:= 'The device is in use by an active process and cannot be disconnected.';
    ERROR_EXTENDED_ERROR	    : AError:= 'A network-specific error occurred. To get a description of the error, use the WNetGetLastError function.';
    ERROR_NOT_CONNECTED	      : AError:= 'The name specified by the lpName parameter is not a redirected device, or the system is not currently connected to the device specified by the parameter.';
    ERROR_OPEN_FILES	        : AError:= 'There are open files, and the fForce parameter is FALSE.';
  end;
  if Assigned(FOnDisconnect) then
    FOnDisconnect(self);
  end;
end;

function TNetDrive.DriveExists(ADrive: string): boolean;
var
  buf : string;
begin
GetDir(0,buf);
{$I-}
ChDir(ADrive);
{$I+}
Result:=(IOResult=0);
ChDir(buf);
end;

function TNetDrive.FreeDriveName: string;
var
  l : TStringList;
  d : TDriveComboBox;
  t : char;
  i : integer;
begin
l:=TStringList.Create;
d:=TDriveComboBox.Create(self);
d.Parent:=Application.MainForm;
d.Visible:=false;
l.Assign(d.Items);
d.Free;
for i:=0 to l.Count-1 do
  l[i]:=copy(l[i],1,1);
t:='d';
result:='';
while (t<='z') and (result='') do
  if l.IndexOf(t)=-1
    then  result:=t
    else  inc(t);
l.Free;
if result<>'' then
  result:=result+':';
end;

procedure TNetDrive.SetOnConnect(const Value: TNotifyEvent);
begin
FOnConnect := Value;
end;

procedure TNetDrive.SetOnDisconnect(const Value: TNotifyEvent);
begin
FOnDisconnect := Value;
end;

end.
