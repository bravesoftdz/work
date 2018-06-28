unit DSIEMVXLib_TLB;

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
// File generated on 07/27/2015 6:28:43 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\DatacapControls\dsiEMVX.ocx (1)
// LIBID: {05240211-F067-44DB-B11D-C4F1E65FF9F7}
// LCID: 0
// Helpfile: C:\Windows\DatacapControls\dsiEMVX.hlp
// HelpString: dsiEMVX ActiveX Control module
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
  DSIEMVXLibMajorVersion = 1;
  DSIEMVXLibMinorVersion = 0;

  LIBID_DSIEMVXLib: TGUID = '{05240211-F067-44DB-B11D-C4F1E65FF9F7}';

  DIID__DDsiEMVX: TGUID = '{0CB3CD4D-FBFB-47C1-8BAC-70E2BC430C3F}';
  DIID__DDsiEMVXEvents: TGUID = '{7A8BCD36-2504-4895-8D32-AE034C1BAD88}';
  CLASS_DsiEMVX: TGUID = '{F17CF553-1802-4450-92E1-469A0544FD63}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DDsiEMVX = dispinterface;
  _DDsiEMVXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DsiEMVX = _DDsiEMVX;


// *********************************************************************//
// DispIntf:  _DDsiEMVX
// Flags:     (4112) Hidden Dispatchable
// GUID:      {0CB3CD4D-FBFB-47C1-8BAC-70E2BC430C3F}
// *********************************************************************//
  _DDsiEMVX = dispinterface
    ['{0CB3CD4D-FBFB-47C1-8BAC-70E2BC430C3F}']
    function ProcessTransaction(const XMLCommand: WideString): WideString; dispid 1;
    function GetDevicesInfo: WideString; dispid 2;
  end;

// *********************************************************************//
// DispIntf:  _DDsiEMVXEvents
// Flags:     (4096) Dispatchable
// GUID:      {7A8BCD36-2504-4895-8D32-AE034C1BAD88}
// *********************************************************************//
  _DDsiEMVXEvents = dispinterface
    ['{7A8BCD36-2504-4895-8D32-AE034C1BAD88}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDsiEMVX
// Help String      : DsiEMVX Control
// Default Interface: _DDsiEMVX
// Def. Intf. DISP? : Yes
// Event   Interface: _DDsiEMVXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDsiEMVX = class(TOleControl)
  private
    FIntf: _DDsiEMVX;
    function  GetControlInterface: _DDsiEMVX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function ProcessTransaction(const XMLCommand: WideString): WideString;
    function GetDevicesInfo: WideString;


    property  ControlInterface: _DDsiEMVX read GetControlInterface;
    property  DefaultInterface: _DDsiEMVX read GetControlInterface;
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

procedure TDsiEMVX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{F17CF553-1802-4450-92E1-469A0544FD63}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDsiEMVX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DDsiEMVX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDsiEMVX.GetControlInterface: _DDsiEMVX;
begin
  CreateControl;
  Result := FIntf;
end;

function TDsiEMVX.ProcessTransaction(const XMLCommand: WideString): WideString;
begin
  Result := DefaultInterface.ProcessTransaction(XMLCommand);
end;

function TDsiEMVX.GetDevicesInfo: WideString;
begin
  Result := DefaultInterface.GetDevicesInfo;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TDsiEMVX]);
end;



end.
