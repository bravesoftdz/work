unit DSICLIENTXLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 09/01/2015 11:00:30 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\DatacapControls\DSICLientX.ocx (1)
// LIBID: {E01EB3B2-F615-11D5-9EC5-0003B3008F24}
// LCID: 0
// Helpfile: C:\Windows\DatacapControls\DSICLientX.hlp
// HelpString: DSICLientX ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DSICLIENTXLibMajorVersion = 3;
  DSICLIENTXLibMinorVersion = 8;

  LIBID_DSICLIENTXLib: TGUID = '{E01EB3B2-F615-11D5-9EC5-0003B3008F24}';

  DIID__DDSICLientX: TGUID = '{E01EB3B3-F615-11D5-9EC5-0003B3008F24}';
  DIID__DDSICLientXEvents: TGUID = '{E01EB3B4-F615-11D5-9EC5-0003B3008F24}';
  CLASS_DSICLientX: TGUID = '{E01EB3B5-F615-11D5-9EC5-0003B3008F24}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DDSICLientX = dispinterface;
  _DDSICLientXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DSICLientX = _DDSICLientX;


// *********************************************************************//
// DispIntf:  _DDSICLientX
// Flags:     (4112) Hidden Dispatchable
// GUID:      {E01EB3B3-F615-11D5-9EC5-0003B3008F24}
// *********************************************************************//
  _DDSICLientX = dispinterface
    ['{E01EB3B3-F615-11D5-9EC5-0003B3008F24}']
    function ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                const ClientServerPassword: WideString; 
                                const UserTraceData: WideString): WideString; dispid 1;
    function ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString; dispid 2;
    function PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString; dispid 3;
    procedure CancelRequest; dispid 4;
    function GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString; dispid 5;
    function PingServer(const IpAddress: WideString; const IpPort: WideString; 
                        ProcessControl: Smallint): WideString; dispid 6;
    function SetConnectTimeout(Timeout: Smallint): Smallint; dispid 7;
    function SetResponseTimeout(Timeout: Smallint): Smallint; dispid 8;
    function ProcessCanadianTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                        const ClientServerPassword: WideString; 
                                        const UserTraceData: WideString): WideString; dispid 9;
  end;

// *********************************************************************//
// DispIntf:  _DDSICLientXEvents
// Flags:     (4096) Dispatchable
// GUID:      {E01EB3B4-F615-11D5-9EC5-0003B3008F24}
// *********************************************************************//
  _DDSICLientXEvents = dispinterface
    ['{E01EB3B4-F615-11D5-9EC5-0003B3008F24}']
    procedure EventResponse(const RStream: WideString); dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDSICLientX
// Help String      : DSICLientX Control
// Default Interface: _DDSICLientX
// Def. Intf. DISP? : Yes
// Event   Interface: _DDSICLientXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDSICLientXEventResponse = procedure(ASender: TObject; const RStream: WideString) of object;

  TDSICLientX = class(TOleControl)
  private
    FOnEventResponse: TDSICLientXEventResponse;
    FIntf: _DDSICLientX;
    function  GetControlInterface: _DDSICLientX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                const ClientServerPassword: WideString; 
                                const UserTraceData: WideString): WideString;
    function ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString;
    function PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString;
    procedure CancelRequest;
    function GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString;
    function PingServer(const IpAddress: WideString; const IpPort: WideString; 
                        ProcessControl: Smallint): WideString;
    function SetConnectTimeout(Timeout: Smallint): Smallint;
    function SetResponseTimeout(Timeout: Smallint): Smallint;
    function ProcessCanadianTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                        const ClientServerPassword: WideString; 
                                        const UserTraceData: WideString): WideString;
    property  ControlInterface: _DDSICLientX read GetControlInterface;
    property  DefaultInterface: _DDSICLientX read GetControlInterface;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property OnEventResponse: TDSICLientXEventResponse read FOnEventResponse write FOnEventResponse;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TDSICLientX.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CControlData: TControlData2 = (
    ClassID: '{E01EB3B5-F615-11D5-9EC5-0003B3008F24}';
    EventIID: '{E01EB3B4-F615-11D5-9EC5-0003B3008F24}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnEventResponse) - Cardinal(Self);
end;

procedure TDSICLientX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DDSICLientX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDSICLientX.GetControlInterface: _DDSICLientX;
begin
  CreateControl;
  Result := FIntf;
end;

function TDSICLientX.ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                        const ClientServerPassword: WideString; 
                                        const UserTraceData: WideString): WideString;
begin
  Result := DefaultInterface.ProcessTransaction(XMLCommand, ProcessControl, ClientServerPassword, 
                                                UserTraceData);
end;

function TDSICLientX.ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.ServerIPConfig(HostList, ProcessControl);
end;

function TDSICLientX.PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.PingStoredServerList(IpPort, ProcessControl);
end;

procedure TDSICLientX.CancelRequest;
begin
  DefaultInterface.CancelRequest;
end;

function TDSICLientX.GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.GetIPAddressFromHostName(HostName, ProcessControl);
end;

function TDSICLientX.PingServer(const IpAddress: WideString; const IpPort: WideString; 
                                ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.PingServer(IpAddress, IpPort, ProcessControl);
end;

function TDSICLientX.SetConnectTimeout(Timeout: Smallint): Smallint;
begin
  Result := DefaultInterface.SetConnectTimeout(Timeout);
end;

function TDSICLientX.SetResponseTimeout(Timeout: Smallint): Smallint;
begin
  Result := DefaultInterface.SetResponseTimeout(Timeout);
end;

function TDSICLientX.ProcessCanadianTransaction(const XMLCommand: WideString; 
                                                ProcessControl: Smallint; 
                                                const ClientServerPassword: WideString; 
                                                const UserTraceData: WideString): WideString;
begin
  Result := DefaultInterface.ProcessCanadianTransaction(XMLCommand, ProcessControl, 
                                                        ClientServerPassword, UserTraceData);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TDSICLientX]);
end;

end.
