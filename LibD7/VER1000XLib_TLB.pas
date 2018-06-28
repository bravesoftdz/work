unit VER1000XLib_TLB;

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
// File generated on 7/29/2009 10:01:16 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\work\MercuryCreditCard\OCX\Ver1000X.ocx (1)
// LIBID: {1A542EAD-1285-457E-980F-67A27384CD0D}
// LCID: 0
// Helpfile: C:\work\MercuryCreditCard\OCX\Ver1000X.hlp
// HelpString: Ver1000X ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
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
  VER1000XLibMajorVersion = 1;
  VER1000XLibMinorVersion = 0;

  LIBID_VER1000XLib: TGUID = '{1A542EAD-1285-457E-980F-67A27384CD0D}';

  DIID__DVer1000X: TGUID = '{9600C8AB-3C16-4936-BCD4-8DC0E9F3B41C}';
  DIID__DVer1000XEvents: TGUID = '{A6537CB8-C2D8-4C35-8AD1-90765694D33F}';
  CLASS_Ver1000X: TGUID = '{CD6193CE-C543-4329-BAB1-C39E5F76CF86}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DVer1000X = dispinterface;
  _DVer1000XEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Ver1000X = _DVer1000X;


// *********************************************************************//
// DispIntf:  _DVer1000X
// Flags:     (4112) Hidden Dispatchable
// GUID:      {9600C8AB-3C16-4936-BCD4-8DC0E9F3B41C}
// *********************************************************************//
  _DVer1000X = dispinterface
    ['{9600C8AB-3C16-4936-BCD4-8DC0E9F3B41C}']
    function ProcessRequest(const XMLRequest: WideString; ProcessControl: Smallint): WideString; dispid 1;
    procedure CancelRequest; dispid 2;
  end;

// *********************************************************************//
// DispIntf:  _DVer1000XEvents
// Flags:     (4096) Dispatchable
// GUID:      {A6537CB8-C2D8-4C35-8AD1-90765694D33F}
// *********************************************************************//
  _DVer1000XEvents = dispinterface
    ['{A6537CB8-C2D8-4C35-8AD1-90765694D33F}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TVer1000X
// Help String      : Ver1000X Control
// Default Interface: _DVer1000X
// Def. Intf. DISP? : Yes
// Event   Interface: _DVer1000XEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TVer1000X = class(TOleControl)
  private
    FIntf: _DVer1000X;
    function  GetControlInterface: _DVer1000X;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function ProcessRequest(const XMLRequest: WideString; ProcessControl: Smallint): WideString;
    procedure CancelRequest;
    property  ControlInterface: _DVer1000X read GetControlInterface;
    property  DefaultInterface: _DVer1000X read GetControlInterface;
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

procedure TVer1000X.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{CD6193CE-C543-4329-BAB1-C39E5F76CF86}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TVer1000X.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DVer1000X;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TVer1000X.GetControlInterface: _DVer1000X;
begin
  CreateControl;
  Result := FIntf;
end;

function TVer1000X.ProcessRequest(const XMLRequest: WideString; ProcessControl: Smallint): WideString;
begin
  Result := DefaultInterface.ProcessRequest(XMLRequest, ProcessControl);
end;

procedure TVer1000X.CancelRequest;
begin
  DefaultInterface.CancelRequest;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TVer1000X]);
end;

end.
