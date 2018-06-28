unit VER2000XLib_TLB;

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
// File generated on 05/28/2015 12:19:36 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\DatacapControls\Ver2000X.ocx (1)
// LIBID: {B6B212E3-C450-11D3-814A-0040339692E9}
// LCID: 0
// Helpfile: C:\Windows\DatacapControls\Ver2000X.hlp
// HelpString: Ver2000X ActiveX Control module
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
  VER2000XLibMajorVersion = 1;
  VER2000XLibMinorVersion = 2;

  LIBID_VER2000XLib: TGUID = '{B6B212E3-C450-11D3-814A-0040339692E9}';

  DIID__DVer2000X: TGUID = '{B6B212E4-C450-11D3-814A-0040339692E9}';
  DIID__DVer2000XEvents: TGUID = '{B6B212E5-C450-11D3-814A-0040339692E9}';
  CLASS_Ver2000X: TGUID = '{B6B212E6-C450-11D3-814A-0040339692E9}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DVer2000X = dispinterface;
  _DVer2000XEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Ver2000X = _DVer2000X;


// *********************************************************************//
// DispIntf:  _DVer2000X
// Flags:     (4112) Hidden Dispatchable
// GUID:      {B6B212E4-C450-11D3-814A-0040339692E9}
// *********************************************************************//
  _DVer2000X = dispinterface
    ['{B6B212E4-C450-11D3-814A-0040339692E9}']
    function SetupPinPad: Smallint; dispid 1;
    function CollectPin(const strAmount: WideString; const strAccountNo: WideString; 
                        PinTimeOut: Smallint): Smallint; dispid 2;
    function EnableCardReader: Smallint; dispid 3;
    function DisableCardReader: Smallint; dispid 4;
    function Initialize: Smallint; dispid 5;
    function CollectStripe(CardTimeOut: Smallint): Smallint; dispid 6;
    function ResetPinPad: Smallint; dispid 7;
    function GetLastPinBlock: WideString; dispid 8;
    function GetLastMagStripe: WideString; dispid 9;
    function DisplayMessageFrame(const Message: WideString): Smallint; dispid 10;
    function LookupError(ErrorNumber: Smallint): WideString; dispid 11;
    procedure CancelRequest; dispid 12;
    function CollectStripeAndPin(const strAmount: WideString; CardTimeOut: Smallint; 
                                 PinTimeOut: Smallint): Smallint; dispid 13;
    function GetKeyManagementType: Smallint; dispid 14;
    function GetLastMasterKeyIndex: Smallint; dispid 15;
    function GetLastKeySerialNo: WideString; dispid 16;
    function SetNewWorkingKey(const WorkingKey: WideString): Smallint; dispid 17;
    function CollectStripeAndPinNoScreen(const strAmount: WideString; CardTimeOut: Smallint; 
                                         PinTimeOut: Smallint): Smallint; dispid 18;
    function CollectStripeNoScreen(CardTimeOut: Smallint): Smallint; dispid 19;
    function CollectPinNoScreen(const strAmount: WideString; const strAccountNo: WideString; 
                                PinTimeOut: Smallint): Smallint; dispid 20;
    function SetupPinPadNoDialog(ComPortNumber: Smallint; KeyManagementType: Smallint; 
                                 MasterKeyIndex: Smallint; ShouldRotateIfMasterOnly: Smallint; 
                                 const strWorkingKey: WideString; const strIdlePrompt: WideString): Smallint; dispid 21;
  end;

// *********************************************************************//
// DispIntf:  _DVer2000XEvents
// Flags:     (4096) Dispatchable
// GUID:      {B6B212E5-C450-11D3-814A-0040339692E9}
// *********************************************************************//
  _DVer2000XEvents = dispinterface
    ['{B6B212E5-C450-11D3-814A-0040339692E9}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TVer2000X
// Help String      : Ver2000X Control
// Default Interface: _DVer2000X
// Def. Intf. DISP? : Yes
// Event   Interface: _DVer2000XEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TVer2000X = class(TOleControl)
  private
    FIntf: _DVer2000X;
    function  GetControlInterface: _DVer2000X;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function SetupPinPad: Smallint;
    function CollectPin(const strAmount: WideString; const strAccountNo: WideString; 
                        PinTimeOut: Smallint): Smallint;
    function EnableCardReader: Smallint;
    function DisableCardReader: Smallint;
    function Initialize: Smallint;
    function CollectStripe(CardTimeOut: Smallint): Smallint;
    function ResetPinPad: Smallint;
    function GetLastPinBlock: WideString;
    function GetLastMagStripe: WideString;
    function DisplayMessageFrame(const Message: WideString): Smallint;
    function LookupError(ErrorNumber: Smallint): WideString;
    procedure CancelRequest;
    function CollectStripeAndPin(const strAmount: WideString; CardTimeOut: Smallint; 
                                 PinTimeOut: Smallint): Smallint;
    function GetKeyManagementType: Smallint;
    function GetLastMasterKeyIndex: Smallint;
    function GetLastKeySerialNo: WideString;
    function SetNewWorkingKey(const WorkingKey: WideString): Smallint;
    function CollectStripeAndPinNoScreen(const strAmount: WideString; CardTimeOut: Smallint; 
                                         PinTimeOut: Smallint): Smallint;
    function CollectStripeNoScreen(CardTimeOut: Smallint): Smallint;
    function CollectPinNoScreen(const strAmount: WideString; const strAccountNo: WideString; 
                                PinTimeOut: Smallint): Smallint;
    function SetupPinPadNoDialog(ComPortNumber: Smallint; KeyManagementType: Smallint; 
                                 MasterKeyIndex: Smallint; ShouldRotateIfMasterOnly: Smallint; 
                                 const strWorkingKey: WideString; const strIdlePrompt: WideString): Smallint;
    property  ControlInterface: _DVer2000X read GetControlInterface;
    property  DefaultInterface: _DVer2000X read GetControlInterface;
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

procedure TVer2000X.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{B6B212E6-C450-11D3-814A-0040339692E9}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TVer2000X.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DVer2000X;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TVer2000X.GetControlInterface: _DVer2000X;
begin
  CreateControl;
  Result := FIntf;
end;

function TVer2000X.SetupPinPad: Smallint;
begin
  Result := DefaultInterface.SetupPinPad;
end;

function TVer2000X.CollectPin(const strAmount: WideString; const strAccountNo: WideString; 
                              PinTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectPin(strAmount, strAccountNo, PinTimeOut);
end;

function TVer2000X.EnableCardReader: Smallint;
begin
  Result := DefaultInterface.EnableCardReader;
end;

function TVer2000X.DisableCardReader: Smallint;
begin
  Result := DefaultInterface.DisableCardReader;
end;

function TVer2000X.Initialize: Smallint;
begin
  Result := DefaultInterface.Initialize;
end;

function TVer2000X.CollectStripe(CardTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectStripe(CardTimeOut);
end;

function TVer2000X.ResetPinPad: Smallint;
begin
  Result := DefaultInterface.ResetPinPad;
end;

function TVer2000X.GetLastPinBlock: WideString;
begin
  Result := DefaultInterface.GetLastPinBlock;
end;

function TVer2000X.GetLastMagStripe: WideString;
begin
  Result := DefaultInterface.GetLastMagStripe;
end;

function TVer2000X.DisplayMessageFrame(const Message: WideString): Smallint;
begin
  Result := DefaultInterface.DisplayMessageFrame(Message);
end;

function TVer2000X.LookupError(ErrorNumber: Smallint): WideString;
begin
  Result := DefaultInterface.LookupError(ErrorNumber);
end;

procedure TVer2000X.CancelRequest;
begin
  DefaultInterface.CancelRequest;
end;

function TVer2000X.CollectStripeAndPin(const strAmount: WideString; CardTimeOut: Smallint; 
                                       PinTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectStripeAndPin(strAmount, CardTimeOut, PinTimeOut);
end;

function TVer2000X.GetKeyManagementType: Smallint;
begin
  Result := DefaultInterface.GetKeyManagementType;
end;

function TVer2000X.GetLastMasterKeyIndex: Smallint;
begin
  Result := DefaultInterface.GetLastMasterKeyIndex;
end;

function TVer2000X.GetLastKeySerialNo: WideString;
begin
  Result := DefaultInterface.GetLastKeySerialNo;
end;

function TVer2000X.SetNewWorkingKey(const WorkingKey: WideString): Smallint;
begin
  Result := DefaultInterface.SetNewWorkingKey(WorkingKey);
end;

function TVer2000X.CollectStripeAndPinNoScreen(const strAmount: WideString; CardTimeOut: Smallint; 
                                               PinTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectStripeAndPinNoScreen(strAmount, CardTimeOut, PinTimeOut);
end;

function TVer2000X.CollectStripeNoScreen(CardTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectStripeNoScreen(CardTimeOut);
end;

function TVer2000X.CollectPinNoScreen(const strAmount: WideString; const strAccountNo: WideString; 
                                      PinTimeOut: Smallint): Smallint;
begin
  Result := DefaultInterface.CollectPinNoScreen(strAmount, strAccountNo, PinTimeOut);
end;

function TVer2000X.SetupPinPadNoDialog(ComPortNumber: Smallint; KeyManagementType: Smallint; 
                                       MasterKeyIndex: Smallint; 
                                       ShouldRotateIfMasterOnly: Smallint; 
                                       const strWorkingKey: WideString; 
                                       const strIdlePrompt: WideString): Smallint;
begin
  Result := DefaultInterface.SetupPinPadNoDialog(ComPortNumber, KeyManagementType, MasterKeyIndex, 
                                                 ShouldRotateIfMasterOnly, strWorkingKey, 
                                                 strIdlePrompt);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TVer2000X]);
end;

end.
