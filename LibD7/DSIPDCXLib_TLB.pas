unit DSIPDCXLib_TLB;

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
// File generated on 05/28/2015 10:10:35 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\DatacapControls\dsiPDCX.ocx (1)
// LIBID: {2A0267E0-74D0-44B1-B2DD-7C0672D512F4}
// LCID: 0
// Helpfile: C:\Windows\DatacapControls\dsiPDCX.hlp
// HelpString: dsiPDCX ActiveX Control module
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
  DSIPDCXLibMajorVersion = 1;
  DSIPDCXLibMinorVersion = 2;

  LIBID_DSIPDCXLib: TGUID = '{2A0267E0-74D0-44B1-B2DD-7C0672D512F4}';

  DIID__DDsiPDCX: TGUID = '{B3C014C5-FE89-4459-858E-4CF19A4A489B}';
  DIID__DDsiPDCXEvents: TGUID = '{FECA6DE2-9E95-4826-A4B1-428C96CDF61F}';
  CLASS_DsiPDCX: TGUID = '{FE259019-004C-41BE-9697-66BDF3FF27A8}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  _DDsiPDCX = dispinterface;
  _DDsiPDCXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DsiPDCX = _DDsiPDCX;


// *********************************************************************//
// DispIntf:  _DDsiPDCX
// Flags:     (4112) Hidden Dispatchable
// GUID:      {B3C014C5-FE89-4459-858E-4CF19A4A489B}
// *********************************************************************//
  _DDsiPDCX = dispinterface
    ['{B3C014C5-FE89-4459-858E-4CF19A4A489B}']
    function SetConnectTimeout(Timeout: Smallint): Smallint; dispid 1;
    function SetResponseTimeout(Timeout: Smallint): Smallint; dispid 2;
    function PingServer(const IpAddress: WideString; const IpPort: WideString; 
                        ProcessControl: Smallint): WideString; dispid 3;
    function GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString; dispid 4;
    procedure CancelRequest; dispid 5;
    function PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString; dispid 6;
    function ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString; dispid 7;
    function ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                const ClientServerPassword: WideString; 
                                const UserTraceData: WideString): WideString; dispid 8;
    function GetDevicesInfo: WideString; dispid 9;
  end;

// *********************************************************************//
// DispIntf:  _DDsiPDCXEvents
// Flags:     (4096) Dispatchable
// GUID:      {FECA6DE2-9E95-4826-A4B1-428C96CDF61F}
// *********************************************************************//
  _DDsiPDCXEvents = dispinterface
    ['{FECA6DE2-9E95-4826-A4B1-428C96CDF61F}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDsiPDCX
// Help String      : DsiPDCX Control
// Default Interface: _DDsiPDCX
// Def. Intf. DISP? : Yes
// Event   Interface: _DDsiPDCXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDsiPDCX = class(TOleControl)
  private
    FIntf: _DDsiPDCX;
    function  GetControlInterface: _DDsiPDCX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function SetConnectTimeout(Timeout: Smallint): Smallint;
    function SetResponseTimeout(Timeout: Smallint): Smallint;
    function PingServer(const IpAddress: WideString; const IpPort: WideString;
                        ProcessControl: Smallint): WideString;
    function GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString;
    procedure CancelRequest;
    function PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString;
    function ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString;
    function ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint;
                                const ClientServerPassword: WideString;
                                const UserTraceData: WideString): WideString; overload;
    function GetDevicesInfo: WideString;

    property  ControlInterface: _DDsiPDCX read GetControlInterface;
    property  DefaultInterface: _DDsiPDCX read GetControlInterface;
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
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TDsiPDCX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{FE259019-004C-41BE-9697-66BDF3FF27A8}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDsiPDCX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DDsiPDCX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDsiPDCX.GetControlInterface: _DDsiPDCX;
begin
  CreateControl;
  Result := FIntf;
end;

function TDsiPDCX.SetConnectTimeout(Timeout: Smallint): Smallint;
begin
  Result := DefaultInterface.SetConnectTimeout(Timeout);
end;

function TDsiPDCX.SetResponseTimeout(Timeout: Smallint): Smallint;
begin
  Result := DefaultInterface.SetResponseTimeout(Timeout);
end;

function TDsiPDCX.PingServer(const IpAddress: WideString; const IpPort: WideString; 
                             ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.PingServer(IpAddress, IpPort, ProcessControl);
end;

function TDsiPDCX.GetIPAddressFromHostName(const HostName: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.GetIPAddressFromHostName(HostName, ProcessControl);
end;

procedure TDsiPDCX.CancelRequest;
begin
  DefaultInterface.CancelRequest;
end;

function TDsiPDCX.PingStoredServerList(const IpPort: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.PingStoredServerList(IpPort, ProcessControl);
end;

function TDsiPDCX.ServerIPConfig(const HostList: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.ServerIPConfig(HostList, ProcessControl);
end;

function TDsiPDCX.ProcessTransaction(const XMLCommand: WideString; ProcessControl: Smallint; 
                                     const ClientServerPassword: WideString; 
                                     const UserTraceData: WideString): WideString;
begin
  Result := DefaultInterface.ProcessTransaction(XMLCommand, ProcessControl, ClientServerPassword,
                                                UserTraceData);
end;

function TDsiPDCX.GetDevicesInfo: WideString;
begin
  Result := DefaultInterface.GetDevicesInfo;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TDsiPDCX]);
end;



end.
