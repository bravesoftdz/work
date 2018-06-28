unit Debit_TLB;

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
// File generated on 8/9/2007 1:44:35 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\kheira_m1\Desktop\libraries\Debit.tlb (1)
// LIBID: {6756AF20-B5ED-4667-B528-0CCA4BF1572A}
// LCID: 0
// Helpfile: C:\WINDOWS\system32\PCCDevKit.hlp
// HelpString: Verifone's Debit ActiveX Control
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DebitMajorVersion = 1;
  DebitMinorVersion = 0;

  LIBID_Debit: TGUID = '{6756AF20-B5ED-4667-B528-0CCA4BF1572A}';

  IID__PccResponse: TGUID = '{E0EDA6DB-39B2-402C-B4F9-BB7BA7313F08}';
  CLASS_PccResponse: TGUID = '{1E58A226-F764-49AA-8F64-F4114D2B1E14}';
  IID__OCXDebit: TGUID = '{D5479AA2-DEDA-4F5F-9FDA-AA5FB799AFDC}';
  DIID___OCXDebit: TGUID = '{C7F31DA7-4248-4DDC-B973-080F1B36B5A4}';
  IID__pccTran: TGUID = '{8EA63A04-3351-4CCA-A10B-4F2ECB69A765}';
  CLASS_pccTran: TGUID = '{5C4A84F8-7EB2-42D5-A6CF-FB15DAE320E9}';
  CLASS_OCXDebit: TGUID = '{A877620D-4B6C-4947-AFCB-DEFAF838097D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum RespFileType
type
  RespFileType = TOleEnum;
const
  TTYPE_CLR = $00000000;
  TTYPE_OUT = $00000001;
  TTYPE_OUX = $00000002;

// Constants for enum RespErrType
type
  RespErrType = TOleEnum;
const
  RESP_ERR_CLR = $00000000;
  RESP_ERR_FILE_NOTFOUND = $00000001;
  RESP_ERR_FILE_INVALID = $00000002;
  RESP_ERR_FILE_OPENFAIL = $00000003;
  RESP_ERR_FILE_WRITEFAIL = $00000004;
  RESP_ERR_XML_LOAD_INCPLT = $00000005;
  RESP_ERR_INVALID_USER = $00000006;
  RESP_ERR_INVALID_ACTION = $00000007;
  RESP_ERR_INVALID_RESPTYPE = $00000008;
  RESP_ERR_GENERAL_ERROR = $00000009;

// Constants for enum CommMethod
type
  CommMethod = TOleEnum;
const
  File_Transfer = $00000000;
  TCPIP = $00000001;

// Constants for enum FileType
type
  FileType = TOleEnum;
const
  TTYPE_CLR_ = $00000000;
  TTYPE_INP = $00000001;
  TTYPE_PRO = $00000002;
  TTYPE_XML = $00000003;
  TTYPE_INF = $00000004;
  TTYPE_BCH = $00000005;
  TTYPE_DUP = $00000006;

// Constants for enum TRespType
type
  TRespType = TOleEnum;
const
  TRESP_CLR = $00000000;
  TRESP_INP = $00000001;
  TRESP_XML = $00000003;

// Constants for enum TranErrType
type
  TranErrType = TOleEnum;
const
  TRAN_ERR_CLR = $00000000;
  TRAN_ERR_FILE_NOTFOUND = $00000001;
  TRAN_ERR_FILE_INVALID = $00000002;
  TRAN_ERR_FILE_OPENFAIL = $00000003;
  TRAN_ERR_FILE_WRITEFAIL = $00000004;
  TRAN_ERR_XML_LOAD_INCPLT = $00000005;
  TRAN_ERR_INVALID_USER = $00000006;
  TRAN_ERR_INVALID_ACTION = $00000007;
  TRAN_ERR_INVALID_RESPTYPE = $00000008;

// Constants for enum TxnMethodType
type
  TxnMethodType = TOleEnum;
const
  TM_OCX_FILE = $00000000;
  TM_COM = $00000001;
  TM_GUI = $00000002;
  TM_OCX_TCP = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _PccResponse = interface;
  _PccResponseDisp = dispinterface;
  _OCXDebit = interface;
  _OCXDebitDisp = dispinterface;
  __OCXDebit = dispinterface;
  _pccTran = interface;
  _pccTranDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PccResponse = _PccResponse;
  pccTran = _pccTran;
  OCXDebit = _OCXDebit;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  RespError = packed record
    type_: RespErrType;
    Reason: WideString;
    Line: WideString;
    Source: WideString;
  end;

  TranError = packed record
    type_: TranErrType;
    Reason: WideString;
    Line: WideString;
    Source: WideString;
  end;


// *********************************************************************//
// Interface: _PccResponse
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E0EDA6DB-39B2-402C-B4F9-BB7BA7313F08}
// *********************************************************************//
  _PccResponse = interface(IDispatch)
    ['{E0EDA6DB-39B2-402C-B4F9-BB7BA7313F08}']
    procedure Set_AuthDate(var Param1: WideString); safecall;
    function Get_AuthDate: WideString; safecall;
    procedure Set_CashBack(var Param1: WideString); safecall;
    function Get_CashBack: WideString; safecall;
    procedure Set_AmountDue(var Param1: WideString); safecall;
    function Get_AmountDue: WideString; safecall;
    procedure Set_AuthAmount(var Param1: WideString); safecall;
    function Get_AuthAmount: WideString; safecall;
    procedure Set_TransTime(var Param1: WideString); safecall;
    function Get_TransTime: WideString; safecall;
    procedure Set_TotTransTime(var Param1: WideString); safecall;
    function Get_TotTransTime: WideString; safecall;
    procedure Set_ConfigSize(var Param1: WideString); safecall;
    function Get_ConfigSize: WideString; safecall;
    procedure Set_CurrSize(var Param1: WideString); safecall;
    function Get_CurrSize: WideString; safecall;
    procedure Set_AuxRespCode(var Param1: WideString); safecall;
    function Get_AuxRespCode: WideString; safecall;
    procedure Set_VoidBalance(var Param1: WideString); safecall;
    function Get_VoidBalance: WideString; safecall;
    procedure Set_eCommIndicator(var Param1: WideString); safecall;
    function Get_eCommIndicator: WideString; safecall;
    procedure Set_CardholderId(var Param1: WideString); safecall;
    function Get_CardholderId: WideString; safecall;
    procedure Set_AccountDataSrc(var Param1: WideString); safecall;
    function Get_AccountDataSrc: WideString; safecall;
    function Get_GetAsString: WideString; safecall;
    procedure Set_GratuityAmntEst(var Param1: WideString); safecall;
    function Get_GratuityAmntEst: WideString; safecall;
    procedure Set_GratuityAmnt(var Param1: WideString); safecall;
    function Get_GratuityAmnt: WideString; safecall;
    procedure Set_ItemID(var Param1: WideString); safecall;
    function Get_ItemID: WideString; safecall;
    function Get_Result: WideString; safecall;
    procedure Set_Result(var Param1: WideString); safecall;
    function Get_ResultCode: WideString; safecall;
    procedure Set_ResultCode(var Param1: WideString); safecall;
    function Get_CmrclCardFlag: WideString; safecall;
    procedure Set_CmrclCardFlag(var Param1: WideString); safecall;
    function Get_NetID: WideString; safecall;
    procedure Set_NetID(var Param1: WideString); safecall;
    function Get_Auth: WideString; safecall;
    procedure Set_Auth(var Param1: WideString); safecall;
    function Get_Reference: WideString; safecall;
    procedure Set_Reference(var Param1: WideString); safecall;
    function Get_ADDRESVER: WideString; safecall;
    procedure Set_ADDRESVER(var Param1: WideString); safecall;
    function Get_TDate: WideString; safecall;
    procedure Set_TDate(var Param1: WideString); safecall;
    function Get_Ticket: WideString; safecall;
    procedure Set_Ticket(var Param1: WideString); safecall;
    function Get_TransNum: WideString; safecall;
    procedure Set_TransNum(var Param1: WideString); safecall;
    function Get_TItem: WideString; safecall;
    procedure Set_TItem(var Param1: WideString); safecall;
    function Get_TBATCH: WideString; safecall;
    procedure Set_TBATCH(var Param1: WideString); safecall;
    function Get_TI: WideString; safecall;
    procedure Set_TI(var Param1: WideString); safecall;
    function Get_TICODE: WideString; safecall;
    procedure Set_TICODE(var Param1: WideString); safecall;
    function Get_IND: WideString; safecall;
    procedure Set_IND(var Param1: WideString); safecall;
    function Get_MSI: WideString; safecall;
    procedure Set_MSI(var Param1: WideString); safecall;
    function Get_Ret: WideString; safecall;
    procedure Set_Ret(var Param1: WideString); safecall;
    function Get_PEM: WideString; safecall;
    procedure Set_PEM(var Param1: WideString); safecall;
    function Get_TIM: WideString; safecall;
    procedure Set_TIM(var Param1: WideString); safecall;
    function Get_ACI: WideString; safecall;
    procedure Set_ACI(var Param1: WideString); safecall;
    function Get_RespCode: WideString; safecall;
    procedure Set_RespCode(var Param1: WideString); safecall;
    function Get_RRec: WideString; safecall;
    procedure Set_RRec(var Param1: WideString); safecall;
    function Get_CCType: WideString; safecall;
    procedure Set_CCType(var Param1: WideString); safecall;
    function Get_CVV2Response: WideString; safecall;
    procedure Set_CVV2Response(var Param1: WideString); safecall;
    function Get_PurchaseCard: WideString; safecall;
    procedure Set_PurchaseCard(var Param1: WideString); safecall;
    procedure Set_RespType(var Param1: RespFileType); safecall;
    function Get_RespType: RespFileType; safecall;
    function Get_Error: RespError; safecall;
    procedure Set_FileName(var Param1: WideString); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_InpType(var Param1: RespFileType); safecall;
    function Get_InpType: RespFileType; safecall;
    procedure Set_XDRFile(var Param1: WideString); safecall;
    function Get_XDRFile: WideString; safecall;
    procedure Set_TroutD(var Param1: WideString); safecall;
    function Get_TroutD: WideString; safecall;
    procedure Set_Username(var Param1: WideString); safecall;
    function Get_Username: WideString; safecall;
    procedure Set_Auth_Src_Code(var Param1: WideString); safecall;
    function Get_Auth_Src_Code: WideString; safecall;
    procedure Set_SaleCount(var Param1: WideString); safecall;
    function Get_SaleCount: WideString; safecall;
    procedure Set_SaleTotalAmount(var Param1: WideString); safecall;
    function Get_SaleTotalAmount: WideString; safecall;
    procedure Set_ActivationCount(var Param1: WideString); safecall;
    function Get_ActivationCount: WideString; safecall;
    procedure Set_ActivationTotalAmount(var Param1: WideString); safecall;
    function Get_ActivationTotalAmount: WideString; safecall;
    procedure Set_CreditCount(var Param1: WideString); safecall;
    function Get_CreditCount: WideString; safecall;
    procedure Set_CreditTotalAmount(var Param1: WideString); safecall;
    function Get_CreditTotalAmount: WideString; safecall;
    procedure Set_VoidCount(var Param1: WideString); safecall;
    function Get_VoidCount: WideString; safecall;
    procedure Set_VoidTotalAmount(var Param1: WideString); safecall;
    function Get_VoidTotalAmount: WideString; safecall;
    procedure Set_AddValueCount(var Param1: WideString); safecall;
    function Get_AddValueCount: WideString; safecall;
    procedure Set_AddValueTotalAmount(var Param1: WideString); safecall;
    function Get_AddValueTotalAmount: WideString; safecall;
    procedure Set_TipCount(var Param1: WideString); safecall;
    function Get_TipCount: WideString; safecall;
    procedure Set_TipTotalAmount(var Param1: WideString); safecall;
    function Get_TipTotalAmount: WideString; safecall;
    procedure Set_BalanceTransferCount(var Param1: WideString); safecall;
    function Get_BalanceTransferCount: WideString; safecall;
    procedure Set_BalanceTransferTotalAmount(var Param1: WideString); safecall;
    function Get_BalanceTransferTotalAmount: WideString; safecall;
    procedure Set_PointsCount(var Param1: WideString); safecall;
    function Get_PointsCount: WideString; safecall;
    procedure Set_PointsTotalAmount(var Param1: WideString); safecall;
    function Get_PointsTotalAmount: WideString; safecall;
    procedure Set_AddPointsCount(var Param1: WideString); safecall;
    function Get_AddPointsCount: WideString; safecall;
    procedure Set_AddPointsTotalAmount(var Param1: WideString); safecall;
    function Get_AddPointsTotalAmount: WideString; safecall;
    procedure Set_MiscMessage(var Param1: WideString); safecall;
    function Get_MiscMessage: WideString; safecall;
    procedure Set_TransDateTime(var Param1: WideString); safecall;
    function Get_TransDateTime: WideString; safecall;
    procedure Set_GiftCardBalance(var Param1: WideString); safecall;
    function Get_GiftCardBalance: WideString; safecall;
    procedure Set_EBTFoodBalance(var Param1: WideString); safecall;
    function Get_EBTFoodBalance: WideString; safecall;
    procedure Set_EBTCashBalance(var Param1: WideString); safecall;
    function Get_EBTCashBalance: WideString; safecall;
    procedure Set_CCAvailBalance(var Param1: WideString); safecall;
    function Get_CCAvailBalance: WideString; safecall;
    procedure Set_TraceNumber(var Param1: WideString); safecall;
    function Get_TraceNumber: WideString; safecall;
    procedure Set_TransactionReferenceNumber(var Param1: WideString); safecall;
    function Get_TransactionReferenceNumber: WideString; safecall;
    procedure Set_DCAvailBalance(var Param1: WideString); safecall;
    function Get_DCAvailBalance: WideString; safecall;
    procedure Set_SurchargeAmount(var Param1: WideString); safecall;
    function Get_SurchargeAmount: WideString; safecall;
    function Load(var szFileName: OleVariant; var intRecNum: Smallint; var blnValidate: WordBool): RespErrType; safecall;
    function LoadOut(var szFileName: WideString; var intRecNum: Smallint): RespErrType; safecall;
    function LoadXML(var szFileName: WideString): RespErrType; safecall;
    function WriteFile(var eType: RespFileType; var szNewPrefix: OleVariant; 
                       var szNewPath: OleVariant; var intRecNum: Smallint; var blnAppend: WordBool; 
                       var BatchNum: Smallint; var blnLastRec: WordBool): RespErrType; safecall;
    function CleanString(var szStringIn: WideString; var szReplaceList: WideString; 
                         var blnCompact: WordBool; var blnTrim: WordBool; var blnRmvNP: WordBool): WideString; safecall;
    procedure Clear; safecall;
    procedure ClearErr; safecall;
    property AuthDate: WideString read Get_AuthDate write Set_AuthDate;
    property CashBack: WideString read Get_CashBack write Set_CashBack;
    property AmountDue: WideString read Get_AmountDue write Set_AmountDue;
    property AuthAmount: WideString read Get_AuthAmount write Set_AuthAmount;
    property TransTime: WideString read Get_TransTime write Set_TransTime;
    property TotTransTime: WideString read Get_TotTransTime write Set_TotTransTime;
    property ConfigSize: WideString read Get_ConfigSize write Set_ConfigSize;
    property CurrSize: WideString read Get_CurrSize write Set_CurrSize;
    property AuxRespCode: WideString read Get_AuxRespCode write Set_AuxRespCode;
    property VoidBalance: WideString read Get_VoidBalance write Set_VoidBalance;
    property eCommIndicator: WideString read Get_eCommIndicator write Set_eCommIndicator;
    property CardholderId: WideString read Get_CardholderId write Set_CardholderId;
    property AccountDataSrc: WideString read Get_AccountDataSrc write Set_AccountDataSrc;
    property GetAsString: WideString read Get_GetAsString;
    property GratuityAmntEst: WideString read Get_GratuityAmntEst write Set_GratuityAmntEst;
    property GratuityAmnt: WideString read Get_GratuityAmnt write Set_GratuityAmnt;
    property ItemID: WideString read Get_ItemID write Set_ItemID;
    property Result: WideString read Get_Result write Set_Result;
    property ResultCode: WideString read Get_ResultCode write Set_ResultCode;
    property CmrclCardFlag: WideString read Get_CmrclCardFlag write Set_CmrclCardFlag;
    property NetID: WideString read Get_NetID write Set_NetID;
    property Auth: WideString read Get_Auth write Set_Auth;
    property Reference: WideString read Get_Reference write Set_Reference;
    property ADDRESVER: WideString read Get_ADDRESVER write Set_ADDRESVER;
    property TDate: WideString read Get_TDate write Set_TDate;
    property Ticket: WideString read Get_Ticket write Set_Ticket;
    property TransNum: WideString read Get_TransNum write Set_TransNum;
    property TItem: WideString read Get_TItem write Set_TItem;
    property TBATCH: WideString read Get_TBATCH write Set_TBATCH;
    property TI: WideString read Get_TI write Set_TI;
    property TICODE: WideString read Get_TICODE write Set_TICODE;
    property IND: WideString read Get_IND write Set_IND;
    property MSI: WideString read Get_MSI write Set_MSI;
    property Ret: WideString read Get_Ret write Set_Ret;
    property PEM: WideString read Get_PEM write Set_PEM;
    property TIM: WideString read Get_TIM write Set_TIM;
    property ACI: WideString read Get_ACI write Set_ACI;
    property RespCode: WideString read Get_RespCode write Set_RespCode;
    property RRec: WideString read Get_RRec write Set_RRec;
    property CCType: WideString read Get_CCType write Set_CCType;
    property CVV2Response: WideString read Get_CVV2Response write Set_CVV2Response;
    property PurchaseCard: WideString read Get_PurchaseCard write Set_PurchaseCard;
    property RespType: RespFileType read Get_RespType write Set_RespType;
    property Error: RespError read Get_Error;
    property FileName: WideString read Get_FileName write Set_FileName;
    property InpType: RespFileType read Get_InpType write Set_InpType;
    property XDRFile: WideString read Get_XDRFile write Set_XDRFile;
    property TroutD: WideString read Get_TroutD write Set_TroutD;
    property Username: WideString read Get_Username write Set_Username;
    property Auth_Src_Code: WideString read Get_Auth_Src_Code write Set_Auth_Src_Code;
    property SaleCount: WideString read Get_SaleCount write Set_SaleCount;
    property SaleTotalAmount: WideString read Get_SaleTotalAmount write Set_SaleTotalAmount;
    property ActivationCount: WideString read Get_ActivationCount write Set_ActivationCount;
    property ActivationTotalAmount: WideString read Get_ActivationTotalAmount write Set_ActivationTotalAmount;
    property CreditCount: WideString read Get_CreditCount write Set_CreditCount;
    property CreditTotalAmount: WideString read Get_CreditTotalAmount write Set_CreditTotalAmount;
    property VoidCount: WideString read Get_VoidCount write Set_VoidCount;
    property VoidTotalAmount: WideString read Get_VoidTotalAmount write Set_VoidTotalAmount;
    property AddValueCount: WideString read Get_AddValueCount write Set_AddValueCount;
    property AddValueTotalAmount: WideString read Get_AddValueTotalAmount write Set_AddValueTotalAmount;
    property TipCount: WideString read Get_TipCount write Set_TipCount;
    property TipTotalAmount: WideString read Get_TipTotalAmount write Set_TipTotalAmount;
    property BalanceTransferCount: WideString read Get_BalanceTransferCount write Set_BalanceTransferCount;
    property BalanceTransferTotalAmount: WideString read Get_BalanceTransferTotalAmount write Set_BalanceTransferTotalAmount;
    property PointsCount: WideString read Get_PointsCount write Set_PointsCount;
    property PointsTotalAmount: WideString read Get_PointsTotalAmount write Set_PointsTotalAmount;
    property AddPointsCount: WideString read Get_AddPointsCount write Set_AddPointsCount;
    property AddPointsTotalAmount: WideString read Get_AddPointsTotalAmount write Set_AddPointsTotalAmount;
    property MiscMessage: WideString read Get_MiscMessage write Set_MiscMessage;
    property TransDateTime: WideString read Get_TransDateTime write Set_TransDateTime;
    property GiftCardBalance: WideString read Get_GiftCardBalance write Set_GiftCardBalance;
    property EBTFoodBalance: WideString read Get_EBTFoodBalance write Set_EBTFoodBalance;
    property EBTCashBalance: WideString read Get_EBTCashBalance write Set_EBTCashBalance;
    property CCAvailBalance: WideString read Get_CCAvailBalance write Set_CCAvailBalance;
    property TraceNumber: WideString read Get_TraceNumber write Set_TraceNumber;
    property TransactionReferenceNumber: WideString read Get_TransactionReferenceNumber write Set_TransactionReferenceNumber;
    property DCAvailBalance: WideString read Get_DCAvailBalance write Set_DCAvailBalance;
    property SurchargeAmount: WideString read Get_SurchargeAmount write Set_SurchargeAmount;
  end;

// *********************************************************************//
// DispIntf:  _PccResponseDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E0EDA6DB-39B2-402C-B4F9-BB7BA7313F08}
// *********************************************************************//
  _PccResponseDisp = dispinterface
    ['{E0EDA6DB-39B2-402C-B4F9-BB7BA7313F08}']
    property AuthDate: WideString dispid 1745027149;
    property CashBack: WideString dispid 1745027148;
    property AmountDue: WideString dispid 1745027147;
    property AuthAmount: WideString dispid 1745027146;
    property TransTime: WideString dispid 1745027145;
    property TotTransTime: WideString dispid 1745027144;
    property ConfigSize: WideString dispid 1745027143;
    property CurrSize: WideString dispid 1745027142;
    property AuxRespCode: WideString dispid 1745027141;
    property VoidBalance: WideString dispid 1745027140;
    property eCommIndicator: WideString dispid 1745027139;
    property CardholderId: WideString dispid 1745027138;
    property AccountDataSrc: WideString dispid 1745027137;
    property GetAsString: WideString readonly dispid 1745027136;
    property GratuityAmntEst: WideString dispid 1745027135;
    property GratuityAmnt: WideString dispid 1745027134;
    property ItemID: WideString dispid 1745027133;
    property Result: WideString dispid 1745027132;
    property ResultCode: WideString dispid 1745027131;
    property CmrclCardFlag: WideString dispid 1745027130;
    property NetID: WideString dispid 1745027129;
    property Auth: WideString dispid 1745027128;
    property Reference: WideString dispid 1745027127;
    property ADDRESVER: WideString dispid 1745027126;
    property TDate: WideString dispid 1745027125;
    property Ticket: WideString dispid 1745027124;
    property TransNum: WideString dispid 1745027123;
    property TItem: WideString dispid 1745027122;
    property TBATCH: WideString dispid 1745027121;
    property TI: WideString dispid 1745027120;
    property TICODE: WideString dispid 1745027119;
    property IND: WideString dispid 1745027118;
    property MSI: WideString dispid 1745027117;
    property Ret: WideString dispid 1745027116;
    property PEM: WideString dispid 1745027115;
    property TIM: WideString dispid 1745027114;
    property ACI: WideString dispid 1745027113;
    property RespCode: WideString dispid 1745027112;
    property RRec: WideString dispid 1745027111;
    property CCType: WideString dispid 1745027110;
    property CVV2Response: WideString dispid 1745027109;
    property PurchaseCard: WideString dispid 1745027108;
    property RespType: RespFileType dispid 1745027107;
    property Error: {??RespError}OleVariant readonly dispid 1745027106;
    property FileName: WideString dispid 1745027105;
    property InpType: RespFileType dispid 1745027104;
    property XDRFile: WideString dispid 1745027103;
    property TroutD: WideString dispid 1745027102;
    property Username: WideString dispid 1745027101;
    property Auth_Src_Code: WideString dispid 1745027100;
    property SaleCount: WideString dispid 1745027099;
    property SaleTotalAmount: WideString dispid 1745027098;
    property ActivationCount: WideString dispid 1745027097;
    property ActivationTotalAmount: WideString dispid 1745027096;
    property CreditCount: WideString dispid 1745027095;
    property CreditTotalAmount: WideString dispid 1745027094;
    property VoidCount: WideString dispid 1745027093;
    property VoidTotalAmount: WideString dispid 1745027092;
    property AddValueCount: WideString dispid 1745027091;
    property AddValueTotalAmount: WideString dispid 1745027090;
    property TipCount: WideString dispid 1745027089;
    property TipTotalAmount: WideString dispid 1745027088;
    property BalanceTransferCount: WideString dispid 1745027087;
    property BalanceTransferTotalAmount: WideString dispid 1745027086;
    property PointsCount: WideString dispid 1745027085;
    property PointsTotalAmount: WideString dispid 1745027084;
    property AddPointsCount: WideString dispid 1745027083;
    property AddPointsTotalAmount: WideString dispid 1745027082;
    property MiscMessage: WideString dispid 1745027081;
    property TransDateTime: WideString dispid 1745027080;
    property GiftCardBalance: WideString dispid 1745027079;
    property EBTFoodBalance: WideString dispid 1745027078;
    property EBTCashBalance: WideString dispid 1745027077;
    property CCAvailBalance: WideString dispid 1745027076;
    property TraceNumber: WideString dispid 1745027075;
    property TransactionReferenceNumber: WideString dispid 1745027074;
    property DCAvailBalance: WideString dispid 1745027073;
    property SurchargeAmount: WideString dispid 1745027072;
    function Load(var szFileName: OleVariant; var intRecNum: Smallint; var blnValidate: WordBool): RespErrType; dispid 1610809422;
    function LoadOut(var szFileName: WideString; var intRecNum: Smallint): RespErrType; dispid 1610809423;
    function LoadXML(var szFileName: WideString): RespErrType; dispid 1610809424;
    function WriteFile(var eType: RespFileType; var szNewPrefix: OleVariant; 
                       var szNewPath: OleVariant; var intRecNum: Smallint; var blnAppend: WordBool; 
                       var BatchNum: Smallint; var blnLastRec: WordBool): RespErrType; dispid 1610809425;
    function CleanString(var szStringIn: WideString; var szReplaceList: WideString; 
                         var blnCompact: WordBool; var blnTrim: WordBool; var blnRmvNP: WordBool): WideString; dispid 1610809426;
    procedure Clear; dispid 1610809427;
    procedure ClearErr; dispid 1610809431;
  end;

// *********************************************************************//
// Interface: _OCXDebit
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D5479AA2-DEDA-4F5F-9FDA-AA5FB799AFDC}
// *********************************************************************//
  _OCXDebit = interface(IDispatch)
    ['{D5479AA2-DEDA-4F5F-9FDA-AA5FB799AFDC}']
    procedure GhostMethod__OCXDebit_28_1; safecall;
    procedure GhostMethod__OCXDebit_32_2; safecall;
    procedure GhostMethod__OCXDebit_36_3; safecall;
    procedure GhostMethod__OCXDebit_40_4; safecall;
    procedure GhostMethod__OCXDebit_44_5; safecall;
    procedure GhostMethod__OCXDebit_48_6; safecall;
    procedure GhostMethod__OCXDebit_52_7; safecall;
    procedure GhostMethod__OCXDebit_56_8; safecall;
    procedure GhostMethod__OCXDebit_60_9; safecall;
    procedure GhostMethod__OCXDebit_64_10; safecall;
    procedure GhostMethod__OCXDebit_68_11; safecall;
    procedure GhostMethod__OCXDebit_72_12; safecall;
    procedure GhostMethod__OCXDebit_76_13; safecall;
    procedure GhostMethod__OCXDebit_80_14; safecall;
    procedure GhostMethod__OCXDebit_84_15; safecall;
    procedure GhostMethod__OCXDebit_88_16; safecall;
    procedure GhostMethod__OCXDebit_92_17; safecall;
    procedure GhostMethod__OCXDebit_96_18; safecall;
    procedure GhostMethod__OCXDebit_100_19; safecall;
    procedure GhostMethod__OCXDebit_104_20; safecall;
    procedure GhostMethod__OCXDebit_108_21; safecall;
    procedure GhostMethod__OCXDebit_112_22; safecall;
    procedure GhostMethod__OCXDebit_116_23; safecall;
    procedure GhostMethod__OCXDebit_120_24; safecall;
    procedure GhostMethod__OCXDebit_124_25; safecall;
    procedure GhostMethod__OCXDebit_128_26; safecall;
    procedure GhostMethod__OCXDebit_132_27; safecall;
    procedure GhostMethod__OCXDebit_136_28; safecall;
    procedure GhostMethod__OCXDebit_140_29; safecall;
    procedure GhostMethod__OCXDebit_144_30; safecall;
    procedure GhostMethod__OCXDebit_148_31; safecall;
    procedure GhostMethod__OCXDebit_152_32; safecall;
    procedure GhostMethod__OCXDebit_156_33; safecall;
    procedure GhostMethod__OCXDebit_160_34; safecall;
    procedure GhostMethod__OCXDebit_164_35; safecall;
    procedure GhostMethod__OCXDebit_168_36; safecall;
    procedure GhostMethod__OCXDebit_172_37; safecall;
    procedure GhostMethod__OCXDebit_176_38; safecall;
    procedure GhostMethod__OCXDebit_180_39; safecall;
    procedure GhostMethod__OCXDebit_184_40; safecall;
    procedure GhostMethod__OCXDebit_188_41; safecall;
    procedure GhostMethod__OCXDebit_192_42; safecall;
    procedure GhostMethod__OCXDebit_196_43; safecall;
    procedure GhostMethod__OCXDebit_200_44; safecall;
    procedure GhostMethod__OCXDebit_204_45; safecall;
    procedure GhostMethod__OCXDebit_208_46; safecall;
    procedure GhostMethod__OCXDebit_212_47; safecall;
    procedure GhostMethod__OCXDebit_216_48; safecall;
    procedure GhostMethod__OCXDebit_220_49; safecall;
    procedure GhostMethod__OCXDebit_224_50; safecall;
    procedure GhostMethod__OCXDebit_228_51; safecall;
    procedure GhostMethod__OCXDebit_232_52; safecall;
    procedure GhostMethod__OCXDebit_236_53; safecall;
    procedure GhostMethod__OCXDebit_240_54; safecall;
    procedure GhostMethod__OCXDebit_244_55; safecall;
    procedure GhostMethod__OCXDebit_248_56; safecall;
    procedure GhostMethod__OCXDebit_252_57; safecall;
    procedure GhostMethod__OCXDebit_256_58; safecall;
    procedure GhostMethod__OCXDebit_260_59; safecall;
    procedure GhostMethod__OCXDebit_264_60; safecall;
    procedure GhostMethod__OCXDebit_268_61; safecall;
    procedure GhostMethod__OCXDebit_272_62; safecall;
    procedure GhostMethod__OCXDebit_276_63; safecall;
    procedure GhostMethod__OCXDebit_280_64; safecall;
    procedure GhostMethod__OCXDebit_284_65; safecall;
    procedure GhostMethod__OCXDebit_288_66; safecall;
    procedure GhostMethod__OCXDebit_292_67; safecall;
    procedure GhostMethod__OCXDebit_296_68; safecall;
    procedure GhostMethod__OCXDebit_300_69; safecall;
    procedure GhostMethod__OCXDebit_304_70; safecall;
    procedure GhostMethod__OCXDebit_308_71; safecall;
    procedure GhostMethod__OCXDebit_312_72; safecall;
    procedure GhostMethod__OCXDebit_316_73; safecall;
    procedure GhostMethod__OCXDebit_320_74; safecall;
    procedure GhostMethod__OCXDebit_324_75; safecall;
    procedure GhostMethod__OCXDebit_328_76; safecall;
    procedure GhostMethod__OCXDebit_332_77; safecall;
    procedure GhostMethod__OCXDebit_336_78; safecall;
    procedure GhostMethod__OCXDebit_340_79; safecall;
    procedure GhostMethod__OCXDebit_344_80; safecall;
    procedure GhostMethod__OCXDebit_348_81; safecall;
    procedure GhostMethod__OCXDebit_352_82; safecall;
    procedure GhostMethod__OCXDebit_356_83; safecall;
    procedure GhostMethod__OCXDebit_360_84; safecall;
    procedure GhostMethod__OCXDebit_364_85; safecall;
    procedure GhostMethod__OCXDebit_368_86; safecall;
    procedure GhostMethod__OCXDebit_372_87; safecall;
    procedure GhostMethod__OCXDebit_376_88; safecall;
    procedure GhostMethod__OCXDebit_380_89; safecall;
    procedure GhostMethod__OCXDebit_384_90; safecall;
    procedure GhostMethod__OCXDebit_388_91; safecall;
    procedure GhostMethod__OCXDebit_392_92; safecall;
    procedure GhostMethod__OCXDebit_396_93; safecall;
    procedure GhostMethod__OCXDebit_400_94; safecall;
    procedure GhostMethod__OCXDebit_404_95; safecall;
    procedure GhostMethod__OCXDebit_408_96; safecall;
    procedure GhostMethod__OCXDebit_412_97; safecall;
    procedure GhostMethod__OCXDebit_416_98; safecall;
    procedure GhostMethod__OCXDebit_420_99; safecall;
    procedure GhostMethod__OCXDebit_424_100; safecall;
    procedure GhostMethod__OCXDebit_428_101; safecall;
    procedure GhostMethod__OCXDebit_432_102; safecall;
    procedure GhostMethod__OCXDebit_436_103; safecall;
    procedure GhostMethod__OCXDebit_440_104; safecall;
    procedure GhostMethod__OCXDebit_444_105; safecall;
    procedure GhostMethod__OCXDebit_448_106; safecall;
    procedure GhostMethod__OCXDebit_452_107; safecall;
    procedure GhostMethod__OCXDebit_456_108; safecall;
    procedure GhostMethod__OCXDebit_460_109; safecall;
    procedure GhostMethod__OCXDebit_464_110; safecall;
    procedure GhostMethod__OCXDebit_468_111; safecall;
    procedure GhostMethod__OCXDebit_472_112; safecall;
    procedure GhostMethod__OCXDebit_476_113; safecall;
    procedure GhostMethod__OCXDebit_480_114; safecall;
    procedure GhostMethod__OCXDebit_484_115; safecall;
    procedure GhostMethod__OCXDebit_488_116; safecall;
    procedure GhostMethod__OCXDebit_492_117; safecall;
    procedure GhostMethod__OCXDebit_496_118; safecall;
    procedure GhostMethod__OCXDebit_500_119; safecall;
    procedure GhostMethod__OCXDebit_504_120; safecall;
    procedure GhostMethod__OCXDebit_508_121; safecall;
    procedure GhostMethod__OCXDebit_512_122; safecall;
    procedure GhostMethod__OCXDebit_516_123; safecall;
    procedure GhostMethod__OCXDebit_520_124; safecall;
    procedure GhostMethod__OCXDebit_524_125; safecall;
    procedure GhostMethod__OCXDebit_528_126; safecall;
    procedure GhostMethod__OCXDebit_532_127; safecall;
    procedure GhostMethod__OCXDebit_536_128; safecall;
    procedure GhostMethod__OCXDebit_540_129; safecall;
    procedure GhostMethod__OCXDebit_544_130; safecall;
    procedure GhostMethod__OCXDebit_548_131; safecall;
    procedure GhostMethod__OCXDebit_552_132; safecall;
    procedure GhostMethod__OCXDebit_556_133; safecall;
    procedure GhostMethod__OCXDebit_560_134; safecall;
    procedure GhostMethod__OCXDebit_564_135; safecall;
    procedure GhostMethod__OCXDebit_568_136; safecall;
    procedure GhostMethod__OCXDebit_572_137; safecall;
    procedure GhostMethod__OCXDebit_576_138; safecall;
    procedure GhostMethod__OCXDebit_580_139; safecall;
    procedure GhostMethod__OCXDebit_584_140; safecall;
    procedure GhostMethod__OCXDebit_588_141; safecall;
    procedure GhostMethod__OCXDebit_592_142; safecall;
    procedure GhostMethod__OCXDebit_596_143; safecall;
    procedure GhostMethod__OCXDebit_600_144; safecall;
    procedure GhostMethod__OCXDebit_604_145; safecall;
    procedure GhostMethod__OCXDebit_608_146; safecall;
    procedure GhostMethod__OCXDebit_612_147; safecall;
    procedure GhostMethod__OCXDebit_616_148; safecall;
    procedure GhostMethod__OCXDebit_620_149; safecall;
    procedure GhostMethod__OCXDebit_624_150; safecall;
    procedure GhostMethod__OCXDebit_628_151; safecall;
    procedure GhostMethod__OCXDebit_632_152; safecall;
    procedure GhostMethod__OCXDebit_636_153; safecall;
    procedure GhostMethod__OCXDebit_640_154; safecall;
    procedure GhostMethod__OCXDebit_644_155; safecall;
    procedure GhostMethod__OCXDebit_648_156; safecall;
    procedure GhostMethod__OCXDebit_652_157; safecall;
    procedure GhostMethod__OCXDebit_656_158; safecall;
    procedure GhostMethod__OCXDebit_660_159; safecall;
    procedure GhostMethod__OCXDebit_664_160; safecall;
    procedure GhostMethod__OCXDebit_668_161; safecall;
    procedure GhostMethod__OCXDebit_672_162; safecall;
    procedure GhostMethod__OCXDebit_676_163; safecall;
    procedure GhostMethod__OCXDebit_680_164; safecall;
    procedure GhostMethod__OCXDebit_684_165; safecall;
    procedure GhostMethod__OCXDebit_688_166; safecall;
    procedure GhostMethod__OCXDebit_692_167; safecall;
    procedure GhostMethod__OCXDebit_696_168; safecall;
    procedure GhostMethod__OCXDebit_700_169; safecall;
    procedure GhostMethod__OCXDebit_704_170; safecall;
    procedure GhostMethod__OCXDebit_708_171; safecall;
    procedure GhostMethod__OCXDebit_712_172; safecall;
    procedure GhostMethod__OCXDebit_716_173; safecall;
    procedure GhostMethod__OCXDebit_720_174; safecall;
    procedure GhostMethod__OCXDebit_724_175; safecall;
    procedure GhostMethod__OCXDebit_728_176; safecall;
    procedure GhostMethod__OCXDebit_732_177; safecall;
    procedure GhostMethod__OCXDebit_736_178; safecall;
    procedure GhostMethod__OCXDebit_740_179; safecall;
    procedure GhostMethod__OCXDebit_744_180; safecall;
    procedure GhostMethod__OCXDebit_748_181; safecall;
    procedure GhostMethod__OCXDebit_752_182; safecall;
    procedure GhostMethod__OCXDebit_756_183; safecall;
    procedure GhostMethod__OCXDebit_760_184; safecall;
    procedure GhostMethod__OCXDebit_764_185; safecall;
    procedure GhostMethod__OCXDebit_768_186; safecall;
    procedure GhostMethod__OCXDebit_772_187; safecall;
    procedure GhostMethod__OCXDebit_776_188; safecall;
    procedure GhostMethod__OCXDebit_780_189; safecall;
    procedure GhostMethod__OCXDebit_784_190; safecall;
    procedure GhostMethod__OCXDebit_788_191; safecall;
    procedure GhostMethod__OCXDebit_792_192; safecall;
    procedure GhostMethod__OCXDebit_796_193; safecall;
    procedure GhostMethod__OCXDebit_800_194; safecall;
    procedure GhostMethod__OCXDebit_804_195; safecall;
    procedure GhostMethod__OCXDebit_808_196; safecall;
    procedure GhostMethod__OCXDebit_812_197; safecall;
    procedure GhostMethod__OCXDebit_816_198; safecall;
    procedure GhostMethod__OCXDebit_820_199; safecall;
    procedure GhostMethod__OCXDebit_824_200; safecall;
    procedure GhostMethod__OCXDebit_828_201; safecall;
    procedure GhostMethod__OCXDebit_832_202; safecall;
    procedure GhostMethod__OCXDebit_836_203; safecall;
    procedure GhostMethod__OCXDebit_840_204; safecall;
    procedure GhostMethod__OCXDebit_844_205; safecall;
    procedure GhostMethod__OCXDebit_848_206; safecall;
    procedure GhostMethod__OCXDebit_852_207; safecall;
    procedure GhostMethod__OCXDebit_856_208; safecall;
    procedure GhostMethod__OCXDebit_860_209; safecall;
    procedure GhostMethod__OCXDebit_864_210; safecall;
    procedure GhostMethod__OCXDebit_868_211; safecall;
    procedure GhostMethod__OCXDebit_872_212; safecall;
    procedure GhostMethod__OCXDebit_876_213; safecall;
    procedure GhostMethod__OCXDebit_880_214; safecall;
    procedure GhostMethod__OCXDebit_884_215; safecall;
    procedure GhostMethod__OCXDebit_888_216; safecall;
    procedure GhostMethod__OCXDebit_892_217; safecall;
    procedure GhostMethod__OCXDebit_896_218; safecall;
    procedure GhostMethod__OCXDebit_900_219; safecall;
    procedure GhostMethod__OCXDebit_904_220; safecall;
    procedure GhostMethod__OCXDebit_908_221; safecall;
    procedure GhostMethod__OCXDebit_912_222; safecall;
    procedure GhostMethod__OCXDebit_916_223; safecall;
    procedure GhostMethod__OCXDebit_920_224; safecall;
    procedure GhostMethod__OCXDebit_924_225; safecall;
    procedure GhostMethod__OCXDebit_928_226; safecall;
    procedure GhostMethod__OCXDebit_932_227; safecall;
    procedure GhostMethod__OCXDebit_936_228; safecall;
    procedure GhostMethod__OCXDebit_940_229; safecall;
    procedure GhostMethod__OCXDebit_944_230; safecall;
    procedure GhostMethod__OCXDebit_948_231; safecall;
    procedure GhostMethod__OCXDebit_952_232; safecall;
    procedure GhostMethod__OCXDebit_956_233; safecall;
    procedure GhostMethod__OCXDebit_960_234; safecall;
    procedure GhostMethod__OCXDebit_964_235; safecall;
    procedure GhostMethod__OCXDebit_968_236; safecall;
    procedure GhostMethod__OCXDebit_972_237; safecall;
    procedure GhostMethod__OCXDebit_976_238; safecall;
    procedure GhostMethod__OCXDebit_980_239; safecall;
    procedure GhostMethod__OCXDebit_984_240; safecall;
    procedure GhostMethod__OCXDebit_988_241; safecall;
    procedure GhostMethod__OCXDebit_992_242; safecall;
    procedure GhostMethod__OCXDebit_996_243; safecall;
    procedure GhostMethod__OCXDebit_1000_244; safecall;
    procedure GhostMethod__OCXDebit_1004_245; safecall;
    procedure GhostMethod__OCXDebit_1008_246; safecall;
    procedure GhostMethod__OCXDebit_1012_247; safecall;
    procedure GhostMethod__OCXDebit_1016_248; safecall;
    procedure GhostMethod__OCXDebit_1020_249; safecall;
    procedure GhostMethod__OCXDebit_1024_250; safecall;
    procedure GhostMethod__OCXDebit_1028_251; safecall;
    procedure GhostMethod__OCXDebit_1032_252; safecall;
    procedure GhostMethod__OCXDebit_1036_253; safecall;
    procedure GhostMethod__OCXDebit_1040_254; safecall;
    procedure GhostMethod__OCXDebit_1044_255; safecall;
    procedure GhostMethod__OCXDebit_1048_256; safecall;
    procedure GhostMethod__OCXDebit_1052_257; safecall;
    procedure GhostMethod__OCXDebit_1056_258; safecall;
    procedure GhostMethod__OCXDebit_1060_259; safecall;
    procedure GhostMethod__OCXDebit_1064_260; safecall;
    procedure GhostMethod__OCXDebit_1068_261; safecall;
    procedure GhostMethod__OCXDebit_1072_262; safecall;
    procedure GhostMethod__OCXDebit_1076_263; safecall;
    procedure GhostMethod__OCXDebit_1080_264; safecall;
    procedure GhostMethod__OCXDebit_1084_265; safecall;
    procedure GhostMethod__OCXDebit_1088_266; safecall;
    procedure GhostMethod__OCXDebit_1092_267; safecall;
    procedure GhostMethod__OCXDebit_1096_268; safecall;
    procedure GhostMethod__OCXDebit_1100_269; safecall;
    procedure GhostMethod__OCXDebit_1104_270; safecall;
    procedure GhostMethod__OCXDebit_1108_271; safecall;
    procedure GhostMethod__OCXDebit_1112_272; safecall;
    procedure GhostMethod__OCXDebit_1116_273; safecall;
    procedure GhostMethod__OCXDebit_1120_274; safecall;
    procedure GhostMethod__OCXDebit_1124_275; safecall;
    procedure GhostMethod__OCXDebit_1128_276; safecall;
    procedure GhostMethod__OCXDebit_1132_277; safecall;
    procedure GhostMethod__OCXDebit_1136_278; safecall;
    procedure GhostMethod__OCXDebit_1140_279; safecall;
    procedure GhostMethod__OCXDebit_1144_280; safecall;
    procedure GhostMethod__OCXDebit_1148_281; safecall;
    procedure GhostMethod__OCXDebit_1152_282; safecall;
    procedure GhostMethod__OCXDebit_1156_283; safecall;
    procedure GhostMethod__OCXDebit_1160_284; safecall;
    procedure GhostMethod__OCXDebit_1164_285; safecall;
    procedure GhostMethod__OCXDebit_1168_286; safecall;
    procedure GhostMethod__OCXDebit_1172_287; safecall;
    procedure GhostMethod__OCXDebit_1176_288; safecall;
    procedure GhostMethod__OCXDebit_1180_289; safecall;
    procedure GhostMethod__OCXDebit_1184_290; safecall;
    procedure GhostMethod__OCXDebit_1188_291; safecall;
    procedure GhostMethod__OCXDebit_1192_292; safecall;
    procedure GhostMethod__OCXDebit_1196_293; safecall;
    procedure GhostMethod__OCXDebit_1200_294; safecall;
    procedure GhostMethod__OCXDebit_1204_295; safecall;
    procedure GhostMethod__OCXDebit_1208_296; safecall;
    procedure GhostMethod__OCXDebit_1212_297; safecall;
    procedure GhostMethod__OCXDebit_1216_298; safecall;
    procedure GhostMethod__OCXDebit_1220_299; safecall;
    procedure GhostMethod__OCXDebit_1224_300; safecall;
    procedure GhostMethod__OCXDebit_1228_301; safecall;
    procedure GhostMethod__OCXDebit_1232_302; safecall;
    procedure GhostMethod__OCXDebit_1236_303; safecall;
    procedure GhostMethod__OCXDebit_1240_304; safecall;
    procedure GhostMethod__OCXDebit_1244_305; safecall;
    procedure GhostMethod__OCXDebit_1248_306; safecall;
    procedure GhostMethod__OCXDebit_1252_307; safecall;
    procedure GhostMethod__OCXDebit_1256_308; safecall;
    procedure GhostMethod__OCXDebit_1260_309; safecall;
    procedure GhostMethod__OCXDebit_1264_310; safecall;
    procedure GhostMethod__OCXDebit_1268_311; safecall;
    procedure GhostMethod__OCXDebit_1272_312; safecall;
    procedure GhostMethod__OCXDebit_1276_313; safecall;
    procedure GhostMethod__OCXDebit_1280_314; safecall;
    procedure GhostMethod__OCXDebit_1284_315; safecall;
    procedure GhostMethod__OCXDebit_1288_316; safecall;
    procedure GhostMethod__OCXDebit_1292_317; safecall;
    procedure GhostMethod__OCXDebit_1296_318; safecall;
    procedure GhostMethod__OCXDebit_1300_319; safecall;
    procedure GhostMethod__OCXDebit_1304_320; safecall;
    procedure GhostMethod__OCXDebit_1308_321; safecall;
    procedure GhostMethod__OCXDebit_1312_322; safecall;
    procedure GhostMethod__OCXDebit_1316_323; safecall;
    procedure GhostMethod__OCXDebit_1320_324; safecall;
    procedure GhostMethod__OCXDebit_1324_325; safecall;
    procedure GhostMethod__OCXDebit_1328_326; safecall;
    procedure GhostMethod__OCXDebit_1332_327; safecall;
    procedure GhostMethod__OCXDebit_1336_328; safecall;
    procedure GhostMethod__OCXDebit_1340_329; safecall;
    procedure GhostMethod__OCXDebit_1344_330; safecall;
    procedure GhostMethod__OCXDebit_1348_331; safecall;
    procedure GhostMethod__OCXDebit_1352_332; safecall;
    procedure GhostMethod__OCXDebit_1356_333; safecall;
    procedure GhostMethod__OCXDebit_1360_334; safecall;
    procedure GhostMethod__OCXDebit_1364_335; safecall;
    procedure GhostMethod__OCXDebit_1368_336; safecall;
    procedure GhostMethod__OCXDebit_1372_337; safecall;
    procedure GhostMethod__OCXDebit_1376_338; safecall;
    procedure GhostMethod__OCXDebit_1380_339; safecall;
    procedure GhostMethod__OCXDebit_1384_340; safecall;
    procedure GhostMethod__OCXDebit_1388_341; safecall;
    procedure GhostMethod__OCXDebit_1392_342; safecall;
    procedure GhostMethod__OCXDebit_1396_343; safecall;
    procedure GhostMethod__OCXDebit_1400_344; safecall;
    procedure GhostMethod__OCXDebit_1404_345; safecall;
    procedure GhostMethod__OCXDebit_1408_346; safecall;
    procedure GhostMethod__OCXDebit_1412_347; safecall;
    procedure GhostMethod__OCXDebit_1416_348; safecall;
    procedure GhostMethod__OCXDebit_1420_349; safecall;
    procedure GhostMethod__OCXDebit_1424_350; safecall;
    procedure GhostMethod__OCXDebit_1428_351; safecall;
    procedure GhostMethod__OCXDebit_1432_352; safecall;
    procedure GhostMethod__OCXDebit_1436_353; safecall;
    procedure GhostMethod__OCXDebit_1440_354; safecall;
    procedure GhostMethod__OCXDebit_1444_355; safecall;
    procedure GhostMethod__OCXDebit_1448_356; safecall;
    procedure GhostMethod__OCXDebit_1452_357; safecall;
    procedure GhostMethod__OCXDebit_1456_358; safecall;
    procedure GhostMethod__OCXDebit_1460_359; safecall;
    procedure GhostMethod__OCXDebit_1464_360; safecall;
    procedure GhostMethod__OCXDebit_1468_361; safecall;
    procedure GhostMethod__OCXDebit_1472_362; safecall;
    procedure GhostMethod__OCXDebit_1476_363; safecall;
    procedure GhostMethod__OCXDebit_1480_364; safecall;
    procedure GhostMethod__OCXDebit_1484_365; safecall;
    procedure GhostMethod__OCXDebit_1488_366; safecall;
    procedure GhostMethod__OCXDebit_1492_367; safecall;
    procedure GhostMethod__OCXDebit_1496_368; safecall;
    procedure GhostMethod__OCXDebit_1500_369; safecall;
    procedure GhostMethod__OCXDebit_1504_370; safecall;
    procedure GhostMethod__OCXDebit_1508_371; safecall;
    procedure GhostMethod__OCXDebit_1512_372; safecall;
    procedure GhostMethod__OCXDebit_1516_373; safecall;
    procedure GhostMethod__OCXDebit_1520_374; safecall;
    procedure GhostMethod__OCXDebit_1524_375; safecall;
    procedure GhostMethod__OCXDebit_1528_376; safecall;
    procedure GhostMethod__OCXDebit_1532_377; safecall;
    procedure GhostMethod__OCXDebit_1536_378; safecall;
    procedure GhostMethod__OCXDebit_1540_379; safecall;
    procedure GhostMethod__OCXDebit_1544_380; safecall;
    procedure GhostMethod__OCXDebit_1548_381; safecall;
    procedure GhostMethod__OCXDebit_1552_382; safecall;
    procedure GhostMethod__OCXDebit_1556_383; safecall;
    procedure GhostMethod__OCXDebit_1560_384; safecall;
    procedure GhostMethod__OCXDebit_1564_385; safecall;
    procedure GhostMethod__OCXDebit_1568_386; safecall;
    procedure GhostMethod__OCXDebit_1572_387; safecall;
    procedure GhostMethod__OCXDebit_1576_388; safecall;
    procedure GhostMethod__OCXDebit_1580_389; safecall;
    procedure GhostMethod__OCXDebit_1584_390; safecall;
    procedure GhostMethod__OCXDebit_1588_391; safecall;
    procedure GhostMethod__OCXDebit_1592_392; safecall;
    procedure GhostMethod__OCXDebit_1596_393; safecall;
    procedure GhostMethod__OCXDebit_1600_394; safecall;
    procedure GhostMethod__OCXDebit_1604_395; safecall;
    procedure GhostMethod__OCXDebit_1608_396; safecall;
    procedure GhostMethod__OCXDebit_1612_397; safecall;
    procedure GhostMethod__OCXDebit_1616_398; safecall;
    procedure GhostMethod__OCXDebit_1620_399; safecall;
    procedure GhostMethod__OCXDebit_1624_400; safecall;
    procedure GhostMethod__OCXDebit_1628_401; safecall;
    procedure GhostMethod__OCXDebit_1632_402; safecall;
    procedure GhostMethod__OCXDebit_1636_403; safecall;
    procedure GhostMethod__OCXDebit_1640_404; safecall;
    procedure GhostMethod__OCXDebit_1644_405; safecall;
    procedure GhostMethod__OCXDebit_1648_406; safecall;
    procedure GhostMethod__OCXDebit_1652_407; safecall;
    procedure GhostMethod__OCXDebit_1656_408; safecall;
    procedure GhostMethod__OCXDebit_1660_409; safecall;
    procedure GhostMethod__OCXDebit_1664_410; safecall;
    procedure GhostMethod__OCXDebit_1668_411; safecall;
    procedure GhostMethod__OCXDebit_1672_412; safecall;
    procedure GhostMethod__OCXDebit_1676_413; safecall;
    procedure GhostMethod__OCXDebit_1680_414; safecall;
    procedure GhostMethod__OCXDebit_1684_415; safecall;
    procedure GhostMethod__OCXDebit_1688_416; safecall;
    procedure GhostMethod__OCXDebit_1692_417; safecall;
    procedure GhostMethod__OCXDebit_1696_418; safecall;
    procedure GhostMethod__OCXDebit_1700_419; safecall;
    procedure GhostMethod__OCXDebit_1704_420; safecall;
    procedure GhostMethod__OCXDebit_1708_421; safecall;
    procedure GhostMethod__OCXDebit_1712_422; safecall;
    procedure GhostMethod__OCXDebit_1716_423; safecall;
    procedure GhostMethod__OCXDebit_1720_424; safecall;
    procedure GhostMethod__OCXDebit_1724_425; safecall;
    procedure GhostMethod__OCXDebit_1728_426; safecall;
    procedure GhostMethod__OCXDebit_1732_427; safecall;
    procedure GhostMethod__OCXDebit_1736_428; safecall;
    procedure GhostMethod__OCXDebit_1740_429; safecall;
    procedure GhostMethod__OCXDebit_1744_430; safecall;
    procedure GhostMethod__OCXDebit_1748_431; safecall;
    procedure GhostMethod__OCXDebit_1752_432; safecall;
    procedure GhostMethod__OCXDebit_1756_433; safecall;
    procedure GhostMethod__OCXDebit_1760_434; safecall;
    procedure GhostMethod__OCXDebit_1764_435; safecall;
    procedure GhostMethod__OCXDebit_1768_436; safecall;
    procedure GhostMethod__OCXDebit_1772_437; safecall;
    procedure GhostMethod__OCXDebit_1776_438; safecall;
    procedure GhostMethod__OCXDebit_1780_439; safecall;
    procedure GhostMethod__OCXDebit_1784_440; safecall;
    procedure GhostMethod__OCXDebit_1788_441; safecall;
    procedure GhostMethod__OCXDebit_1792_442; safecall;
    procedure GhostMethod__OCXDebit_1796_443; safecall;
    procedure GhostMethod__OCXDebit_1800_444; safecall;
    procedure GhostMethod__OCXDebit_1804_445; safecall;
    procedure GhostMethod__OCXDebit_1808_446; safecall;
    procedure GhostMethod__OCXDebit_1812_447; safecall;
    procedure GhostMethod__OCXDebit_1816_448; safecall;
    procedure GhostMethod__OCXDebit_1820_449; safecall;
    procedure GhostMethod__OCXDebit_1824_450; safecall;
    procedure GhostMethod__OCXDebit_1828_451; safecall;
    procedure GhostMethod__OCXDebit_1832_452; safecall;
    procedure GhostMethod__OCXDebit_1836_453; safecall;
    procedure GhostMethod__OCXDebit_1840_454; safecall;
    procedure GhostMethod__OCXDebit_1844_455; safecall;
    procedure GhostMethod__OCXDebit_1848_456; safecall;
    procedure GhostMethod__OCXDebit_1852_457; safecall;
    procedure GhostMethod__OCXDebit_1856_458; safecall;
    procedure GhostMethod__OCXDebit_1860_459; safecall;
    procedure GhostMethod__OCXDebit_1864_460; safecall;
    procedure GhostMethod__OCXDebit_1868_461; safecall;
    procedure GhostMethod__OCXDebit_1872_462; safecall;
    procedure GhostMethod__OCXDebit_1876_463; safecall;
    procedure GhostMethod__OCXDebit_1880_464; safecall;
    procedure GhostMethod__OCXDebit_1884_465; safecall;
    procedure GhostMethod__OCXDebit_1888_466; safecall;
    procedure GhostMethod__OCXDebit_1892_467; safecall;
    procedure GhostMethod__OCXDebit_1896_468; safecall;
    procedure GhostMethod__OCXDebit_1900_469; safecall;
    procedure GhostMethod__OCXDebit_1904_470; safecall;
    procedure GhostMethod__OCXDebit_1908_471; safecall;
    procedure GhostMethod__OCXDebit_1912_472; safecall;
    procedure GhostMethod__OCXDebit_1916_473; safecall;
    procedure GhostMethod__OCXDebit_1920_474; safecall;
    procedure GhostMethod__OCXDebit_1924_475; safecall;
    procedure GhostMethod__OCXDebit_1928_476; safecall;
    procedure GhostMethod__OCXDebit_1932_477; safecall;
    procedure GhostMethod__OCXDebit_1936_478; safecall;
    procedure GhostMethod__OCXDebit_1940_479; safecall;
    procedure GhostMethod__OCXDebit_1944_480; safecall;
    procedure GhostMethod__OCXDebit_1948_481; safecall;
    procedure GhostMethod__OCXDebit_1952_482; safecall;
    function Get_Action: Integer; safecall;
    procedure Set_Action(Param1: Integer); safecall;
    function Get_Amount: WideString; safecall;
    procedure Set_Amount(const Param1: WideString); safecall;
    function Get_BillPay: WideString; safecall;
    procedure Set_BillPay(const Param1: WideString); safecall;
    function Get_Card: WideString; safecall;
    procedure Set_Card(const Param1: WideString); safecall;
    procedure Set_ExpDate(const Param1: WideString); safecall;
    function Get_ExpDate: WideString; safecall;
    function Get_Member: WideString; safecall;
    procedure Set_Member(const Param1: WideString); safecall;
    function Get_MerchantNumber: WideString; safecall;
    procedure Set_MerchantNumber(const Param1: WideString); safecall;
    function Get_Path: WideString; safecall;
    procedure Set_Path(const Param1: WideString); safecall;
    function Get_Processor: WideString; safecall;
    procedure Set_Processor(const Param1: WideString); safecall;
    function Get_TimeOut: Integer; safecall;
    procedure Set_TimeOut(Param1: Integer); safecall;
    function Get_Track: WideString; safecall;
    procedure Set_Track(const Param1: WideString); safecall;
    function Get_User: WideString; safecall;
    procedure Set_User(const Param1: WideString); safecall;
    function Get_Pin: WideString; safecall;
    procedure Set_Pin(const Param1: WideString); safecall;
    function Get_KeySerialNumber: WideString; safecall;
    procedure Set_KeySerialNumber(const Param1: WideString); safecall;
    function Get_Ticket: WideString; safecall;
    procedure Set_Ticket(const Param1: WideString); safecall;
    function Get_CashBack: WideString; safecall;
    procedure Set_CashBack(const Param1: WideString); safecall;
    function Get_Reference: WideString; safecall;
    procedure Set_Reference(const Param1: WideString); safecall;
    function Get_RFID: WideString; safecall;
    procedure Set_RFID(const Param1: WideString); safecall;
    procedure Set_BackColor(Param1: Integer); safecall;
    function Get_ForeColor: Integer; safecall;
    procedure Set_ForeColor(Param1: Integer); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Param1: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure _Set_Font(const Param1: IFontDisp); safecall;
    function Get_BackStyle: Smallint; safecall;
    procedure Set_BackStyle(Param1: Smallint); safecall;
    function Get_BorderStyle: Smallint; safecall;
    procedure Set_BorderStyle(Param1: Smallint); safecall;
    function Get_OutDelay: Single; safecall;
    procedure Set_OutDelay(Param1: Single); safecall;
    function Get_FoodStamp: WordBool; safecall;
    procedure Set_FoodStamp(Param1: WordBool); safecall;
    function Get_AuthCode: WideString; safecall;
    procedure Set_AuthCode(const Param1: WideString); safecall;
    function Get_Voucher: WideString; safecall;
    procedure Set_Voucher(const Param1: WideString); safecall;
    function Get_Gratuity: WideString; safecall;
    procedure Set_Gratuity(const Param1: WideString); safecall;
    function Get_XMLtran: WordBool; safecall;
    procedure Set_XMLtran(Param1: WordBool); safecall;
    function Get_Manual: WordBool; safecall;
    procedure Set_Manual(Param1: WordBool); safecall;
    function Get_TroutD: WideString; safecall;
    procedure Set_TroutD(const Param1: WideString); safecall;
    function Get_TransNum: WideString; safecall;
    procedure Set_TransNum(const Param1: WideString); safecall;
    procedure Set_IPAddress(const Param1: WideString); safecall;
    function Get_IPAddress: WideString; safecall;
    procedure Set_Port(Param1: Smallint); safecall;
    function Get_Port: Smallint; safecall;
    procedure Set_EnableSSL(Param1: WordBool); safecall;
    function Get_EnableSSL: WordBool; safecall;
    function Get_Command: WideString; safecall;
    procedure Set_Command(const Param1: WideString); safecall;
    function Get_CommMethod: CommMethod; safecall;
    procedure Set_CommMethod(Param1: CommMethod); safecall;
    function Get_ShiftID: WideString; safecall;
    procedure Set_ShiftID(const Param1: WideString); safecall;
    function Get_LanguageCode: WideString; safecall;
    procedure Set_LanguageCode(const Param1: WideString); safecall;
    function Get_MACData: WideString; safecall;
    procedure Set_MACData(const Param1: WideString); safecall;
    function Get_DebitType: WideString; safecall;
    procedure Set_DebitType(const Param1: WideString); safecall;
    function Get_OrigPurchData: WideString; safecall;
    procedure Set_OrigPurchData(const Param1: WideString); safecall;
    function Get_PumpNumber: WideString; safecall;
    procedure Set_PumpNumber(const Param1: WideString); safecall;
    function Get_SurchargeAmount: WideString; safecall;
    procedure Set_SurchargeAmount(const Param1: WideString); safecall;
    function GetCaptured: WordBool; safecall;
    function GetTroutD: WideString; safecall;
    function GetTransNum: WideString; safecall;
    function GetApproved: WordBool; safecall;
    function GetTI: WideString; safecall;
    function GetMSI: WideString; safecall;
    function GetAuth: OleVariant; safecall;
    function GetRefNumber: WideString; safecall;
    function GetResult: OleVariant; safecall;
    function GetTermFee: WideString; safecall;
    function GetTraceNum: WideString; safecall;
    function GetAvlBalance: WideString; safecall;
    function GetEBTFoodBalance: WideString; safecall;
    function GetEBTCashBalance: WideString; safecall;
    function GetAuthAmount: OleVariant; safecall;
    function GetAmountDue: OleVariant; safecall;
    function GetDCAvailBalance: OleVariant; safecall;
    function GetTraceNumber: OleVariant; safecall;
    function GetTransactionReferenceNumber: OleVariant; safecall;
    function GetSurchargeAmount: OleVariant; safecall;
    function GetErrorDesc: WideString; safecall;
    function GetErrorCode: Integer; safecall;
    function DeleteUserFiles: OleVariant; safecall;
    function PccSysExists: WordBool; safecall;
    function Get_BackColor: Integer; safecall;
    procedure Clear; safecall;
    function GetXMLResponse: WideString; safecall;
    function Send(var FileType: FileType): OleVariant; safecall;
    function VerifyAmount: WordBool; safecall;
    function Connect: WordBool; safecall;
    function Disconnect: OleVariant; safecall;
    function About: WordBool; safecall;
    function Cancel: OleVariant; safecall;
    function GetAuxRespCode: WideString; safecall;
    function GetPOSSequenceNumber(var compareCSN: WideString): WideString; safecall;
    function GetXMLRequest: WideString; safecall;
    property Action: Integer read Get_Action write Set_Action;
    property Amount: WideString read Get_Amount write Set_Amount;
    property BillPay: WideString read Get_BillPay write Set_BillPay;
    property Card: WideString read Get_Card write Set_Card;
    property ExpDate: WideString read Get_ExpDate write Set_ExpDate;
    property Member: WideString read Get_Member write Set_Member;
    property MerchantNumber: WideString read Get_MerchantNumber write Set_MerchantNumber;
    property Path: WideString read Get_Path write Set_Path;
    property Processor: WideString read Get_Processor write Set_Processor;
    property TimeOut: Integer read Get_TimeOut write Set_TimeOut;
    property Track: WideString read Get_Track write Set_Track;
    property User: WideString read Get_User write Set_User;
    property Pin: WideString read Get_Pin write Set_Pin;
    property KeySerialNumber: WideString read Get_KeySerialNumber write Set_KeySerialNumber;
    property Ticket: WideString read Get_Ticket write Set_Ticket;
    property CashBack: WideString read Get_CashBack write Set_CashBack;
    property Reference: WideString read Get_Reference write Set_Reference;
    property RFID: WideString read Get_RFID write Set_RFID;
    property BackColor: Integer read Get_BackColor write Set_BackColor;
    property ForeColor: Integer read Get_ForeColor write Set_ForeColor;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property BackStyle: Smallint read Get_BackStyle write Set_BackStyle;
    property BorderStyle: Smallint read Get_BorderStyle write Set_BorderStyle;
    property OutDelay: Single read Get_OutDelay write Set_OutDelay;
    property FoodStamp: WordBool read Get_FoodStamp write Set_FoodStamp;
    property AuthCode: WideString read Get_AuthCode write Set_AuthCode;
    property Voucher: WideString read Get_Voucher write Set_Voucher;
    property Gratuity: WideString read Get_Gratuity write Set_Gratuity;
    property XMLtran: WordBool read Get_XMLtran write Set_XMLtran;
    property Manual: WordBool read Get_Manual write Set_Manual;
    property TroutD: WideString read Get_TroutD write Set_TroutD;
    property TransNum: WideString read Get_TransNum write Set_TransNum;
    property IPAddress: WideString read Get_IPAddress write Set_IPAddress;
    property Port: Smallint read Get_Port write Set_Port;
    property EnableSSL: WordBool read Get_EnableSSL write Set_EnableSSL;
    property Command: WideString read Get_Command write Set_Command;
    property CommMethod: CommMethod read Get_CommMethod write Set_CommMethod;
    property ShiftID: WideString read Get_ShiftID write Set_ShiftID;
    property LanguageCode: WideString read Get_LanguageCode write Set_LanguageCode;
    property MACData: WideString read Get_MACData write Set_MACData;
    property DebitType: WideString read Get_DebitType write Set_DebitType;
    property OrigPurchData: WideString read Get_OrigPurchData write Set_OrigPurchData;
    property PumpNumber: WideString read Get_PumpNumber write Set_PumpNumber;
    property SurchargeAmount: WideString read Get_SurchargeAmount write Set_SurchargeAmount;
  end;

// *********************************************************************//
// DispIntf:  _OCXDebitDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D5479AA2-DEDA-4F5F-9FDA-AA5FB799AFDC}
// *********************************************************************//
  _OCXDebitDisp = dispinterface
    ['{D5479AA2-DEDA-4F5F-9FDA-AA5FB799AFDC}']
    procedure GhostMethod__OCXDebit_28_1; dispid 1610743808;
    procedure GhostMethod__OCXDebit_32_2; dispid 1610743809;
    procedure GhostMethod__OCXDebit_36_3; dispid 1610743810;
    procedure GhostMethod__OCXDebit_40_4; dispid 1610743811;
    procedure GhostMethod__OCXDebit_44_5; dispid 1610743812;
    procedure GhostMethod__OCXDebit_48_6; dispid 1610743813;
    procedure GhostMethod__OCXDebit_52_7; dispid 1610743814;
    procedure GhostMethod__OCXDebit_56_8; dispid 1610743815;
    procedure GhostMethod__OCXDebit_60_9; dispid 1610743816;
    procedure GhostMethod__OCXDebit_64_10; dispid 1610743817;
    procedure GhostMethod__OCXDebit_68_11; dispid 1610743818;
    procedure GhostMethod__OCXDebit_72_12; dispid 1610743819;
    procedure GhostMethod__OCXDebit_76_13; dispid 1610743820;
    procedure GhostMethod__OCXDebit_80_14; dispid 1610743821;
    procedure GhostMethod__OCXDebit_84_15; dispid 1610743822;
    procedure GhostMethod__OCXDebit_88_16; dispid 1610743823;
    procedure GhostMethod__OCXDebit_92_17; dispid 1610743824;
    procedure GhostMethod__OCXDebit_96_18; dispid 1610743825;
    procedure GhostMethod__OCXDebit_100_19; dispid 1610743826;
    procedure GhostMethod__OCXDebit_104_20; dispid 1610743827;
    procedure GhostMethod__OCXDebit_108_21; dispid 1610743828;
    procedure GhostMethod__OCXDebit_112_22; dispid 1610743829;
    procedure GhostMethod__OCXDebit_116_23; dispid 1610743830;
    procedure GhostMethod__OCXDebit_120_24; dispid 1610743831;
    procedure GhostMethod__OCXDebit_124_25; dispid 1610743832;
    procedure GhostMethod__OCXDebit_128_26; dispid 1610743833;
    procedure GhostMethod__OCXDebit_132_27; dispid 1610743834;
    procedure GhostMethod__OCXDebit_136_28; dispid 1610743835;
    procedure GhostMethod__OCXDebit_140_29; dispid 1610743836;
    procedure GhostMethod__OCXDebit_144_30; dispid 1610743837;
    procedure GhostMethod__OCXDebit_148_31; dispid 1610743838;
    procedure GhostMethod__OCXDebit_152_32; dispid 1610743839;
    procedure GhostMethod__OCXDebit_156_33; dispid 1610743840;
    procedure GhostMethod__OCXDebit_160_34; dispid 1610743841;
    procedure GhostMethod__OCXDebit_164_35; dispid 1610743842;
    procedure GhostMethod__OCXDebit_168_36; dispid 1610743843;
    procedure GhostMethod__OCXDebit_172_37; dispid 1610743844;
    procedure GhostMethod__OCXDebit_176_38; dispid 1610743845;
    procedure GhostMethod__OCXDebit_180_39; dispid 1610743846;
    procedure GhostMethod__OCXDebit_184_40; dispid 1610743847;
    procedure GhostMethod__OCXDebit_188_41; dispid 1610743848;
    procedure GhostMethod__OCXDebit_192_42; dispid 1610743849;
    procedure GhostMethod__OCXDebit_196_43; dispid 1610743850;
    procedure GhostMethod__OCXDebit_200_44; dispid 1610743851;
    procedure GhostMethod__OCXDebit_204_45; dispid 1610743852;
    procedure GhostMethod__OCXDebit_208_46; dispid 1610743853;
    procedure GhostMethod__OCXDebit_212_47; dispid 1610743854;
    procedure GhostMethod__OCXDebit_216_48; dispid 1610743855;
    procedure GhostMethod__OCXDebit_220_49; dispid 1610743856;
    procedure GhostMethod__OCXDebit_224_50; dispid 1610743857;
    procedure GhostMethod__OCXDebit_228_51; dispid 1610743858;
    procedure GhostMethod__OCXDebit_232_52; dispid 1610743859;
    procedure GhostMethod__OCXDebit_236_53; dispid 1610743860;
    procedure GhostMethod__OCXDebit_240_54; dispid 1610743861;
    procedure GhostMethod__OCXDebit_244_55; dispid 1610743862;
    procedure GhostMethod__OCXDebit_248_56; dispid 1610743863;
    procedure GhostMethod__OCXDebit_252_57; dispid 1610743864;
    procedure GhostMethod__OCXDebit_256_58; dispid 1610743865;
    procedure GhostMethod__OCXDebit_260_59; dispid 1610743866;
    procedure GhostMethod__OCXDebit_264_60; dispid 1610743867;
    procedure GhostMethod__OCXDebit_268_61; dispid 1610743868;
    procedure GhostMethod__OCXDebit_272_62; dispid 1610743869;
    procedure GhostMethod__OCXDebit_276_63; dispid 1610743870;
    procedure GhostMethod__OCXDebit_280_64; dispid 1610743871;
    procedure GhostMethod__OCXDebit_284_65; dispid 1610743872;
    procedure GhostMethod__OCXDebit_288_66; dispid 1610743873;
    procedure GhostMethod__OCXDebit_292_67; dispid 1610743874;
    procedure GhostMethod__OCXDebit_296_68; dispid 1610743875;
    procedure GhostMethod__OCXDebit_300_69; dispid 1610743876;
    procedure GhostMethod__OCXDebit_304_70; dispid 1610743877;
    procedure GhostMethod__OCXDebit_308_71; dispid 1610743878;
    procedure GhostMethod__OCXDebit_312_72; dispid 1610743879;
    procedure GhostMethod__OCXDebit_316_73; dispid 1610743880;
    procedure GhostMethod__OCXDebit_320_74; dispid 1610743881;
    procedure GhostMethod__OCXDebit_324_75; dispid 1610743882;
    procedure GhostMethod__OCXDebit_328_76; dispid 1610743883;
    procedure GhostMethod__OCXDebit_332_77; dispid 1610743884;
    procedure GhostMethod__OCXDebit_336_78; dispid 1610743885;
    procedure GhostMethod__OCXDebit_340_79; dispid 1610743886;
    procedure GhostMethod__OCXDebit_344_80; dispid 1610743887;
    procedure GhostMethod__OCXDebit_348_81; dispid 1610743888;
    procedure GhostMethod__OCXDebit_352_82; dispid 1610743889;
    procedure GhostMethod__OCXDebit_356_83; dispid 1610743890;
    procedure GhostMethod__OCXDebit_360_84; dispid 1610743891;
    procedure GhostMethod__OCXDebit_364_85; dispid 1610743892;
    procedure GhostMethod__OCXDebit_368_86; dispid 1610743893;
    procedure GhostMethod__OCXDebit_372_87; dispid 1610743894;
    procedure GhostMethod__OCXDebit_376_88; dispid 1610743895;
    procedure GhostMethod__OCXDebit_380_89; dispid 1610743896;
    procedure GhostMethod__OCXDebit_384_90; dispid 1610743897;
    procedure GhostMethod__OCXDebit_388_91; dispid 1610743898;
    procedure GhostMethod__OCXDebit_392_92; dispid 1610743899;
    procedure GhostMethod__OCXDebit_396_93; dispid 1610743900;
    procedure GhostMethod__OCXDebit_400_94; dispid 1610743901;
    procedure GhostMethod__OCXDebit_404_95; dispid 1610743902;
    procedure GhostMethod__OCXDebit_408_96; dispid 1610743903;
    procedure GhostMethod__OCXDebit_412_97; dispid 1610743904;
    procedure GhostMethod__OCXDebit_416_98; dispid 1610743905;
    procedure GhostMethod__OCXDebit_420_99; dispid 1610743906;
    procedure GhostMethod__OCXDebit_424_100; dispid 1610743907;
    procedure GhostMethod__OCXDebit_428_101; dispid 1610743908;
    procedure GhostMethod__OCXDebit_432_102; dispid 1610743909;
    procedure GhostMethod__OCXDebit_436_103; dispid 1610743910;
    procedure GhostMethod__OCXDebit_440_104; dispid 1610743911;
    procedure GhostMethod__OCXDebit_444_105; dispid 1610743912;
    procedure GhostMethod__OCXDebit_448_106; dispid 1610743913;
    procedure GhostMethod__OCXDebit_452_107; dispid 1610743914;
    procedure GhostMethod__OCXDebit_456_108; dispid 1610743915;
    procedure GhostMethod__OCXDebit_460_109; dispid 1610743916;
    procedure GhostMethod__OCXDebit_464_110; dispid 1610743917;
    procedure GhostMethod__OCXDebit_468_111; dispid 1610743918;
    procedure GhostMethod__OCXDebit_472_112; dispid 1610743919;
    procedure GhostMethod__OCXDebit_476_113; dispid 1610743920;
    procedure GhostMethod__OCXDebit_480_114; dispid 1610743921;
    procedure GhostMethod__OCXDebit_484_115; dispid 1610743922;
    procedure GhostMethod__OCXDebit_488_116; dispid 1610743923;
    procedure GhostMethod__OCXDebit_492_117; dispid 1610743924;
    procedure GhostMethod__OCXDebit_496_118; dispid 1610743925;
    procedure GhostMethod__OCXDebit_500_119; dispid 1610743926;
    procedure GhostMethod__OCXDebit_504_120; dispid 1610743927;
    procedure GhostMethod__OCXDebit_508_121; dispid 1610743928;
    procedure GhostMethod__OCXDebit_512_122; dispid 1610743929;
    procedure GhostMethod__OCXDebit_516_123; dispid 1610743930;
    procedure GhostMethod__OCXDebit_520_124; dispid 1610743931;
    procedure GhostMethod__OCXDebit_524_125; dispid 1610743932;
    procedure GhostMethod__OCXDebit_528_126; dispid 1610743933;
    procedure GhostMethod__OCXDebit_532_127; dispid 1610743934;
    procedure GhostMethod__OCXDebit_536_128; dispid 1610743935;
    procedure GhostMethod__OCXDebit_540_129; dispid 1610743936;
    procedure GhostMethod__OCXDebit_544_130; dispid 1610743937;
    procedure GhostMethod__OCXDebit_548_131; dispid 1610743938;
    procedure GhostMethod__OCXDebit_552_132; dispid 1610743939;
    procedure GhostMethod__OCXDebit_556_133; dispid 1610743940;
    procedure GhostMethod__OCXDebit_560_134; dispid 1610743941;
    procedure GhostMethod__OCXDebit_564_135; dispid 1610743942;
    procedure GhostMethod__OCXDebit_568_136; dispid 1610743943;
    procedure GhostMethod__OCXDebit_572_137; dispid 1610743944;
    procedure GhostMethod__OCXDebit_576_138; dispid 1610743945;
    procedure GhostMethod__OCXDebit_580_139; dispid 1610743946;
    procedure GhostMethod__OCXDebit_584_140; dispid 1610743947;
    procedure GhostMethod__OCXDebit_588_141; dispid 1610743948;
    procedure GhostMethod__OCXDebit_592_142; dispid 1610743949;
    procedure GhostMethod__OCXDebit_596_143; dispid 1610743950;
    procedure GhostMethod__OCXDebit_600_144; dispid 1610743951;
    procedure GhostMethod__OCXDebit_604_145; dispid 1610743952;
    procedure GhostMethod__OCXDebit_608_146; dispid 1610743953;
    procedure GhostMethod__OCXDebit_612_147; dispid 1610743954;
    procedure GhostMethod__OCXDebit_616_148; dispid 1610743955;
    procedure GhostMethod__OCXDebit_620_149; dispid 1610743956;
    procedure GhostMethod__OCXDebit_624_150; dispid 1610743957;
    procedure GhostMethod__OCXDebit_628_151; dispid 1610743958;
    procedure GhostMethod__OCXDebit_632_152; dispid 1610743959;
    procedure GhostMethod__OCXDebit_636_153; dispid 1610743960;
    procedure GhostMethod__OCXDebit_640_154; dispid 1610743961;
    procedure GhostMethod__OCXDebit_644_155; dispid 1610743962;
    procedure GhostMethod__OCXDebit_648_156; dispid 1610743963;
    procedure GhostMethod__OCXDebit_652_157; dispid 1610743964;
    procedure GhostMethod__OCXDebit_656_158; dispid 1610743965;
    procedure GhostMethod__OCXDebit_660_159; dispid 1610743966;
    procedure GhostMethod__OCXDebit_664_160; dispid 1610743967;
    procedure GhostMethod__OCXDebit_668_161; dispid 1610743968;
    procedure GhostMethod__OCXDebit_672_162; dispid 1610743969;
    procedure GhostMethod__OCXDebit_676_163; dispid 1610743970;
    procedure GhostMethod__OCXDebit_680_164; dispid 1610743971;
    procedure GhostMethod__OCXDebit_684_165; dispid 1610743972;
    procedure GhostMethod__OCXDebit_688_166; dispid 1610743973;
    procedure GhostMethod__OCXDebit_692_167; dispid 1610743974;
    procedure GhostMethod__OCXDebit_696_168; dispid 1610743975;
    procedure GhostMethod__OCXDebit_700_169; dispid 1610743976;
    procedure GhostMethod__OCXDebit_704_170; dispid 1610743977;
    procedure GhostMethod__OCXDebit_708_171; dispid 1610743978;
    procedure GhostMethod__OCXDebit_712_172; dispid 1610743979;
    procedure GhostMethod__OCXDebit_716_173; dispid 1610743980;
    procedure GhostMethod__OCXDebit_720_174; dispid 1610743981;
    procedure GhostMethod__OCXDebit_724_175; dispid 1610743982;
    procedure GhostMethod__OCXDebit_728_176; dispid 1610743983;
    procedure GhostMethod__OCXDebit_732_177; dispid 1610743984;
    procedure GhostMethod__OCXDebit_736_178; dispid 1610743985;
    procedure GhostMethod__OCXDebit_740_179; dispid 1610743986;
    procedure GhostMethod__OCXDebit_744_180; dispid 1610743987;
    procedure GhostMethod__OCXDebit_748_181; dispid 1610743988;
    procedure GhostMethod__OCXDebit_752_182; dispid 1610743989;
    procedure GhostMethod__OCXDebit_756_183; dispid 1610743990;
    procedure GhostMethod__OCXDebit_760_184; dispid 1610743991;
    procedure GhostMethod__OCXDebit_764_185; dispid 1610743992;
    procedure GhostMethod__OCXDebit_768_186; dispid 1610743993;
    procedure GhostMethod__OCXDebit_772_187; dispid 1610743994;
    procedure GhostMethod__OCXDebit_776_188; dispid 1610743995;
    procedure GhostMethod__OCXDebit_780_189; dispid 1610743996;
    procedure GhostMethod__OCXDebit_784_190; dispid 1610743997;
    procedure GhostMethod__OCXDebit_788_191; dispid 1610743998;
    procedure GhostMethod__OCXDebit_792_192; dispid 1610743999;
    procedure GhostMethod__OCXDebit_796_193; dispid 1610744000;
    procedure GhostMethod__OCXDebit_800_194; dispid 1610744001;
    procedure GhostMethod__OCXDebit_804_195; dispid 1610744002;
    procedure GhostMethod__OCXDebit_808_196; dispid 1610744003;
    procedure GhostMethod__OCXDebit_812_197; dispid 1610744004;
    procedure GhostMethod__OCXDebit_816_198; dispid 1610744005;
    procedure GhostMethod__OCXDebit_820_199; dispid 1610744006;
    procedure GhostMethod__OCXDebit_824_200; dispid 1610744007;
    procedure GhostMethod__OCXDebit_828_201; dispid 1610744008;
    procedure GhostMethod__OCXDebit_832_202; dispid 1610744009;
    procedure GhostMethod__OCXDebit_836_203; dispid 1610744010;
    procedure GhostMethod__OCXDebit_840_204; dispid 1610744011;
    procedure GhostMethod__OCXDebit_844_205; dispid 1610744012;
    procedure GhostMethod__OCXDebit_848_206; dispid 1610744013;
    procedure GhostMethod__OCXDebit_852_207; dispid 1610744014;
    procedure GhostMethod__OCXDebit_856_208; dispid 1610744015;
    procedure GhostMethod__OCXDebit_860_209; dispid 1610744016;
    procedure GhostMethod__OCXDebit_864_210; dispid 1610744017;
    procedure GhostMethod__OCXDebit_868_211; dispid 1610744018;
    procedure GhostMethod__OCXDebit_872_212; dispid 1610744019;
    procedure GhostMethod__OCXDebit_876_213; dispid 1610744020;
    procedure GhostMethod__OCXDebit_880_214; dispid 1610744021;
    procedure GhostMethod__OCXDebit_884_215; dispid 1610744022;
    procedure GhostMethod__OCXDebit_888_216; dispid 1610744023;
    procedure GhostMethod__OCXDebit_892_217; dispid 1610744024;
    procedure GhostMethod__OCXDebit_896_218; dispid 1610744025;
    procedure GhostMethod__OCXDebit_900_219; dispid 1610744026;
    procedure GhostMethod__OCXDebit_904_220; dispid 1610744027;
    procedure GhostMethod__OCXDebit_908_221; dispid 1610744028;
    procedure GhostMethod__OCXDebit_912_222; dispid 1610744029;
    procedure GhostMethod__OCXDebit_916_223; dispid 1610744030;
    procedure GhostMethod__OCXDebit_920_224; dispid 1610744031;
    procedure GhostMethod__OCXDebit_924_225; dispid 1610744032;
    procedure GhostMethod__OCXDebit_928_226; dispid 1610744033;
    procedure GhostMethod__OCXDebit_932_227; dispid 1610744034;
    procedure GhostMethod__OCXDebit_936_228; dispid 1610744035;
    procedure GhostMethod__OCXDebit_940_229; dispid 1610744036;
    procedure GhostMethod__OCXDebit_944_230; dispid 1610744037;
    procedure GhostMethod__OCXDebit_948_231; dispid 1610744038;
    procedure GhostMethod__OCXDebit_952_232; dispid 1610744039;
    procedure GhostMethod__OCXDebit_956_233; dispid 1610744040;
    procedure GhostMethod__OCXDebit_960_234; dispid 1610744041;
    procedure GhostMethod__OCXDebit_964_235; dispid 1610744042;
    procedure GhostMethod__OCXDebit_968_236; dispid 1610744043;
    procedure GhostMethod__OCXDebit_972_237; dispid 1610744044;
    procedure GhostMethod__OCXDebit_976_238; dispid 1610744045;
    procedure GhostMethod__OCXDebit_980_239; dispid 1610744046;
    procedure GhostMethod__OCXDebit_984_240; dispid 1610744047;
    procedure GhostMethod__OCXDebit_988_241; dispid 1610744048;
    procedure GhostMethod__OCXDebit_992_242; dispid 1610744049;
    procedure GhostMethod__OCXDebit_996_243; dispid 1610744050;
    procedure GhostMethod__OCXDebit_1000_244; dispid 1610744051;
    procedure GhostMethod__OCXDebit_1004_245; dispid 1610744052;
    procedure GhostMethod__OCXDebit_1008_246; dispid 1610744053;
    procedure GhostMethod__OCXDebit_1012_247; dispid 1610744054;
    procedure GhostMethod__OCXDebit_1016_248; dispid 1610744055;
    procedure GhostMethod__OCXDebit_1020_249; dispid 1610744056;
    procedure GhostMethod__OCXDebit_1024_250; dispid 1610744057;
    procedure GhostMethod__OCXDebit_1028_251; dispid 1610744058;
    procedure GhostMethod__OCXDebit_1032_252; dispid 1610744059;
    procedure GhostMethod__OCXDebit_1036_253; dispid 1610744060;
    procedure GhostMethod__OCXDebit_1040_254; dispid 1610744061;
    procedure GhostMethod__OCXDebit_1044_255; dispid 1610744062;
    procedure GhostMethod__OCXDebit_1048_256; dispid 1610744063;
    procedure GhostMethod__OCXDebit_1052_257; dispid 1610744064;
    procedure GhostMethod__OCXDebit_1056_258; dispid 1610744065;
    procedure GhostMethod__OCXDebit_1060_259; dispid 1610744066;
    procedure GhostMethod__OCXDebit_1064_260; dispid 1610744067;
    procedure GhostMethod__OCXDebit_1068_261; dispid 1610744068;
    procedure GhostMethod__OCXDebit_1072_262; dispid 1610744069;
    procedure GhostMethod__OCXDebit_1076_263; dispid 1610744070;
    procedure GhostMethod__OCXDebit_1080_264; dispid 1610744071;
    procedure GhostMethod__OCXDebit_1084_265; dispid 1610744072;
    procedure GhostMethod__OCXDebit_1088_266; dispid 1610744073;
    procedure GhostMethod__OCXDebit_1092_267; dispid 1610744074;
    procedure GhostMethod__OCXDebit_1096_268; dispid 1610744075;
    procedure GhostMethod__OCXDebit_1100_269; dispid 1610744076;
    procedure GhostMethod__OCXDebit_1104_270; dispid 1610744077;
    procedure GhostMethod__OCXDebit_1108_271; dispid 1610744078;
    procedure GhostMethod__OCXDebit_1112_272; dispid 1610744079;
    procedure GhostMethod__OCXDebit_1116_273; dispid 1610744080;
    procedure GhostMethod__OCXDebit_1120_274; dispid 1610744081;
    procedure GhostMethod__OCXDebit_1124_275; dispid 1610744082;
    procedure GhostMethod__OCXDebit_1128_276; dispid 1610744083;
    procedure GhostMethod__OCXDebit_1132_277; dispid 1610744084;
    procedure GhostMethod__OCXDebit_1136_278; dispid 1610744085;
    procedure GhostMethod__OCXDebit_1140_279; dispid 1610744086;
    procedure GhostMethod__OCXDebit_1144_280; dispid 1610744087;
    procedure GhostMethod__OCXDebit_1148_281; dispid 1610744088;
    procedure GhostMethod__OCXDebit_1152_282; dispid 1610744089;
    procedure GhostMethod__OCXDebit_1156_283; dispid 1610744090;
    procedure GhostMethod__OCXDebit_1160_284; dispid 1610744091;
    procedure GhostMethod__OCXDebit_1164_285; dispid 1610744092;
    procedure GhostMethod__OCXDebit_1168_286; dispid 1610744093;
    procedure GhostMethod__OCXDebit_1172_287; dispid 1610744094;
    procedure GhostMethod__OCXDebit_1176_288; dispid 1610744095;
    procedure GhostMethod__OCXDebit_1180_289; dispid 1610744096;
    procedure GhostMethod__OCXDebit_1184_290; dispid 1610744097;
    procedure GhostMethod__OCXDebit_1188_291; dispid 1610744098;
    procedure GhostMethod__OCXDebit_1192_292; dispid 1610744099;
    procedure GhostMethod__OCXDebit_1196_293; dispid 1610744100;
    procedure GhostMethod__OCXDebit_1200_294; dispid 1610744101;
    procedure GhostMethod__OCXDebit_1204_295; dispid 1610744102;
    procedure GhostMethod__OCXDebit_1208_296; dispid 1610744103;
    procedure GhostMethod__OCXDebit_1212_297; dispid 1610744104;
    procedure GhostMethod__OCXDebit_1216_298; dispid 1610744105;
    procedure GhostMethod__OCXDebit_1220_299; dispid 1610744106;
    procedure GhostMethod__OCXDebit_1224_300; dispid 1610744107;
    procedure GhostMethod__OCXDebit_1228_301; dispid 1610744108;
    procedure GhostMethod__OCXDebit_1232_302; dispid 1610744109;
    procedure GhostMethod__OCXDebit_1236_303; dispid 1610744110;
    procedure GhostMethod__OCXDebit_1240_304; dispid 1610744111;
    procedure GhostMethod__OCXDebit_1244_305; dispid 1610744112;
    procedure GhostMethod__OCXDebit_1248_306; dispid 1610744113;
    procedure GhostMethod__OCXDebit_1252_307; dispid 1610744114;
    procedure GhostMethod__OCXDebit_1256_308; dispid 1610744115;
    procedure GhostMethod__OCXDebit_1260_309; dispid 1610744116;
    procedure GhostMethod__OCXDebit_1264_310; dispid 1610744117;
    procedure GhostMethod__OCXDebit_1268_311; dispid 1610744118;
    procedure GhostMethod__OCXDebit_1272_312; dispid 1610744119;
    procedure GhostMethod__OCXDebit_1276_313; dispid 1610744120;
    procedure GhostMethod__OCXDebit_1280_314; dispid 1610744121;
    procedure GhostMethod__OCXDebit_1284_315; dispid 1610744122;
    procedure GhostMethod__OCXDebit_1288_316; dispid 1610744123;
    procedure GhostMethod__OCXDebit_1292_317; dispid 1610744124;
    procedure GhostMethod__OCXDebit_1296_318; dispid 1610744125;
    procedure GhostMethod__OCXDebit_1300_319; dispid 1610744126;
    procedure GhostMethod__OCXDebit_1304_320; dispid 1610744127;
    procedure GhostMethod__OCXDebit_1308_321; dispid 1610744128;
    procedure GhostMethod__OCXDebit_1312_322; dispid 1610744129;
    procedure GhostMethod__OCXDebit_1316_323; dispid 1610744130;
    procedure GhostMethod__OCXDebit_1320_324; dispid 1610744131;
    procedure GhostMethod__OCXDebit_1324_325; dispid 1610744132;
    procedure GhostMethod__OCXDebit_1328_326; dispid 1610744133;
    procedure GhostMethod__OCXDebit_1332_327; dispid 1610744134;
    procedure GhostMethod__OCXDebit_1336_328; dispid 1610744135;
    procedure GhostMethod__OCXDebit_1340_329; dispid 1610744136;
    procedure GhostMethod__OCXDebit_1344_330; dispid 1610744137;
    procedure GhostMethod__OCXDebit_1348_331; dispid 1610744138;
    procedure GhostMethod__OCXDebit_1352_332; dispid 1610744139;
    procedure GhostMethod__OCXDebit_1356_333; dispid 1610744140;
    procedure GhostMethod__OCXDebit_1360_334; dispid 1610744141;
    procedure GhostMethod__OCXDebit_1364_335; dispid 1610744142;
    procedure GhostMethod__OCXDebit_1368_336; dispid 1610744143;
    procedure GhostMethod__OCXDebit_1372_337; dispid 1610744144;
    procedure GhostMethod__OCXDebit_1376_338; dispid 1610744145;
    procedure GhostMethod__OCXDebit_1380_339; dispid 1610744146;
    procedure GhostMethod__OCXDebit_1384_340; dispid 1610744147;
    procedure GhostMethod__OCXDebit_1388_341; dispid 1610744148;
    procedure GhostMethod__OCXDebit_1392_342; dispid 1610744149;
    procedure GhostMethod__OCXDebit_1396_343; dispid 1610744150;
    procedure GhostMethod__OCXDebit_1400_344; dispid 1610744151;
    procedure GhostMethod__OCXDebit_1404_345; dispid 1610744152;
    procedure GhostMethod__OCXDebit_1408_346; dispid 1610744153;
    procedure GhostMethod__OCXDebit_1412_347; dispid 1610744154;
    procedure GhostMethod__OCXDebit_1416_348; dispid 1610744155;
    procedure GhostMethod__OCXDebit_1420_349; dispid 1610744156;
    procedure GhostMethod__OCXDebit_1424_350; dispid 1610744157;
    procedure GhostMethod__OCXDebit_1428_351; dispid 1610744158;
    procedure GhostMethod__OCXDebit_1432_352; dispid 1610744159;
    procedure GhostMethod__OCXDebit_1436_353; dispid 1610744160;
    procedure GhostMethod__OCXDebit_1440_354; dispid 1610744161;
    procedure GhostMethod__OCXDebit_1444_355; dispid 1610744162;
    procedure GhostMethod__OCXDebit_1448_356; dispid 1610744163;
    procedure GhostMethod__OCXDebit_1452_357; dispid 1610744164;
    procedure GhostMethod__OCXDebit_1456_358; dispid 1610744165;
    procedure GhostMethod__OCXDebit_1460_359; dispid 1610744166;
    procedure GhostMethod__OCXDebit_1464_360; dispid 1610744167;
    procedure GhostMethod__OCXDebit_1468_361; dispid 1610744168;
    procedure GhostMethod__OCXDebit_1472_362; dispid 1610744169;
    procedure GhostMethod__OCXDebit_1476_363; dispid 1610744170;
    procedure GhostMethod__OCXDebit_1480_364; dispid 1610744171;
    procedure GhostMethod__OCXDebit_1484_365; dispid 1610744172;
    procedure GhostMethod__OCXDebit_1488_366; dispid 1610744173;
    procedure GhostMethod__OCXDebit_1492_367; dispid 1610744174;
    procedure GhostMethod__OCXDebit_1496_368; dispid 1610744175;
    procedure GhostMethod__OCXDebit_1500_369; dispid 1610744176;
    procedure GhostMethod__OCXDebit_1504_370; dispid 1610744177;
    procedure GhostMethod__OCXDebit_1508_371; dispid 1610744178;
    procedure GhostMethod__OCXDebit_1512_372; dispid 1610744179;
    procedure GhostMethod__OCXDebit_1516_373; dispid 1610744180;
    procedure GhostMethod__OCXDebit_1520_374; dispid 1610744181;
    procedure GhostMethod__OCXDebit_1524_375; dispid 1610744182;
    procedure GhostMethod__OCXDebit_1528_376; dispid 1610744183;
    procedure GhostMethod__OCXDebit_1532_377; dispid 1610744184;
    procedure GhostMethod__OCXDebit_1536_378; dispid 1610744185;
    procedure GhostMethod__OCXDebit_1540_379; dispid 1610744186;
    procedure GhostMethod__OCXDebit_1544_380; dispid 1610744187;
    procedure GhostMethod__OCXDebit_1548_381; dispid 1610744188;
    procedure GhostMethod__OCXDebit_1552_382; dispid 1610744189;
    procedure GhostMethod__OCXDebit_1556_383; dispid 1610744190;
    procedure GhostMethod__OCXDebit_1560_384; dispid 1610744191;
    procedure GhostMethod__OCXDebit_1564_385; dispid 1610744192;
    procedure GhostMethod__OCXDebit_1568_386; dispid 1610744193;
    procedure GhostMethod__OCXDebit_1572_387; dispid 1610744194;
    procedure GhostMethod__OCXDebit_1576_388; dispid 1610744195;
    procedure GhostMethod__OCXDebit_1580_389; dispid 1610744196;
    procedure GhostMethod__OCXDebit_1584_390; dispid 1610744197;
    procedure GhostMethod__OCXDebit_1588_391; dispid 1610744198;
    procedure GhostMethod__OCXDebit_1592_392; dispid 1610744199;
    procedure GhostMethod__OCXDebit_1596_393; dispid 1610744200;
    procedure GhostMethod__OCXDebit_1600_394; dispid 1610744201;
    procedure GhostMethod__OCXDebit_1604_395; dispid 1610744202;
    procedure GhostMethod__OCXDebit_1608_396; dispid 1610744203;
    procedure GhostMethod__OCXDebit_1612_397; dispid 1610744204;
    procedure GhostMethod__OCXDebit_1616_398; dispid 1610744205;
    procedure GhostMethod__OCXDebit_1620_399; dispid 1610744206;
    procedure GhostMethod__OCXDebit_1624_400; dispid 1610744207;
    procedure GhostMethod__OCXDebit_1628_401; dispid 1610744208;
    procedure GhostMethod__OCXDebit_1632_402; dispid 1610744209;
    procedure GhostMethod__OCXDebit_1636_403; dispid 1610744210;
    procedure GhostMethod__OCXDebit_1640_404; dispid 1610744211;
    procedure GhostMethod__OCXDebit_1644_405; dispid 1610744212;
    procedure GhostMethod__OCXDebit_1648_406; dispid 1610744213;
    procedure GhostMethod__OCXDebit_1652_407; dispid 1610744214;
    procedure GhostMethod__OCXDebit_1656_408; dispid 1610744215;
    procedure GhostMethod__OCXDebit_1660_409; dispid 1610744216;
    procedure GhostMethod__OCXDebit_1664_410; dispid 1610744217;
    procedure GhostMethod__OCXDebit_1668_411; dispid 1610744218;
    procedure GhostMethod__OCXDebit_1672_412; dispid 1610744219;
    procedure GhostMethod__OCXDebit_1676_413; dispid 1610744220;
    procedure GhostMethod__OCXDebit_1680_414; dispid 1610744221;
    procedure GhostMethod__OCXDebit_1684_415; dispid 1610744222;
    procedure GhostMethod__OCXDebit_1688_416; dispid 1610744223;
    procedure GhostMethod__OCXDebit_1692_417; dispid 1610744224;
    procedure GhostMethod__OCXDebit_1696_418; dispid 1610744225;
    procedure GhostMethod__OCXDebit_1700_419; dispid 1610744226;
    procedure GhostMethod__OCXDebit_1704_420; dispid 1610744227;
    procedure GhostMethod__OCXDebit_1708_421; dispid 1610744228;
    procedure GhostMethod__OCXDebit_1712_422; dispid 1610744229;
    procedure GhostMethod__OCXDebit_1716_423; dispid 1610744230;
    procedure GhostMethod__OCXDebit_1720_424; dispid 1610744231;
    procedure GhostMethod__OCXDebit_1724_425; dispid 1610744232;
    procedure GhostMethod__OCXDebit_1728_426; dispid 1610744233;
    procedure GhostMethod__OCXDebit_1732_427; dispid 1610744234;
    procedure GhostMethod__OCXDebit_1736_428; dispid 1610744235;
    procedure GhostMethod__OCXDebit_1740_429; dispid 1610744236;
    procedure GhostMethod__OCXDebit_1744_430; dispid 1610744237;
    procedure GhostMethod__OCXDebit_1748_431; dispid 1610744238;
    procedure GhostMethod__OCXDebit_1752_432; dispid 1610744239;
    procedure GhostMethod__OCXDebit_1756_433; dispid 1610744240;
    procedure GhostMethod__OCXDebit_1760_434; dispid 1610744241;
    procedure GhostMethod__OCXDebit_1764_435; dispid 1610744242;
    procedure GhostMethod__OCXDebit_1768_436; dispid 1610744243;
    procedure GhostMethod__OCXDebit_1772_437; dispid 1610744244;
    procedure GhostMethod__OCXDebit_1776_438; dispid 1610744245;
    procedure GhostMethod__OCXDebit_1780_439; dispid 1610744246;
    procedure GhostMethod__OCXDebit_1784_440; dispid 1610744247;
    procedure GhostMethod__OCXDebit_1788_441; dispid 1610744248;
    procedure GhostMethod__OCXDebit_1792_442; dispid 1610744249;
    procedure GhostMethod__OCXDebit_1796_443; dispid 1610744250;
    procedure GhostMethod__OCXDebit_1800_444; dispid 1610744251;
    procedure GhostMethod__OCXDebit_1804_445; dispid 1610744252;
    procedure GhostMethod__OCXDebit_1808_446; dispid 1610744253;
    procedure GhostMethod__OCXDebit_1812_447; dispid 1610744254;
    procedure GhostMethod__OCXDebit_1816_448; dispid 1610744255;
    procedure GhostMethod__OCXDebit_1820_449; dispid 1610744256;
    procedure GhostMethod__OCXDebit_1824_450; dispid 1610744257;
    procedure GhostMethod__OCXDebit_1828_451; dispid 1610744258;
    procedure GhostMethod__OCXDebit_1832_452; dispid 1610744259;
    procedure GhostMethod__OCXDebit_1836_453; dispid 1610744260;
    procedure GhostMethod__OCXDebit_1840_454; dispid 1610744261;
    procedure GhostMethod__OCXDebit_1844_455; dispid 1610744262;
    procedure GhostMethod__OCXDebit_1848_456; dispid 1610744263;
    procedure GhostMethod__OCXDebit_1852_457; dispid 1610744264;
    procedure GhostMethod__OCXDebit_1856_458; dispid 1610744265;
    procedure GhostMethod__OCXDebit_1860_459; dispid 1610744266;
    procedure GhostMethod__OCXDebit_1864_460; dispid 1610744267;
    procedure GhostMethod__OCXDebit_1868_461; dispid 1610744268;
    procedure GhostMethod__OCXDebit_1872_462; dispid 1610744269;
    procedure GhostMethod__OCXDebit_1876_463; dispid 1610744270;
    procedure GhostMethod__OCXDebit_1880_464; dispid 1610744271;
    procedure GhostMethod__OCXDebit_1884_465; dispid 1610744272;
    procedure GhostMethod__OCXDebit_1888_466; dispid 1610744273;
    procedure GhostMethod__OCXDebit_1892_467; dispid 1610744274;
    procedure GhostMethod__OCXDebit_1896_468; dispid 1610744275;
    procedure GhostMethod__OCXDebit_1900_469; dispid 1610744276;
    procedure GhostMethod__OCXDebit_1904_470; dispid 1610744277;
    procedure GhostMethod__OCXDebit_1908_471; dispid 1610744278;
    procedure GhostMethod__OCXDebit_1912_472; dispid 1610744279;
    procedure GhostMethod__OCXDebit_1916_473; dispid 1610744280;
    procedure GhostMethod__OCXDebit_1920_474; dispid 1610744281;
    procedure GhostMethod__OCXDebit_1924_475; dispid 1610744282;
    procedure GhostMethod__OCXDebit_1928_476; dispid 1610744283;
    procedure GhostMethod__OCXDebit_1932_477; dispid 1610744284;
    procedure GhostMethod__OCXDebit_1936_478; dispid 1610744285;
    procedure GhostMethod__OCXDebit_1940_479; dispid 1610744286;
    procedure GhostMethod__OCXDebit_1944_480; dispid 1610744287;
    procedure GhostMethod__OCXDebit_1948_481; dispid 1610744288;
    procedure GhostMethod__OCXDebit_1952_482; dispid 1610744289;
    property Action: Integer dispid 1745027116;
    property Amount: WideString dispid 1745027115;
    property BillPay: WideString dispid 1745027114;
    property Card: WideString dispid 1745027113;
    property ExpDate: WideString dispid 1745027112;
    property Member: WideString dispid 1745027111;
    property MerchantNumber: WideString dispid 1745027110;
    property Path: WideString dispid 1745027109;
    property Processor: WideString dispid 1745027108;
    property TimeOut: Integer dispid 1745027107;
    property Track: WideString dispid 1745027106;
    property User: WideString dispid 1745027105;
    property Pin: WideString dispid 1745027104;
    property KeySerialNumber: WideString dispid 1745027103;
    property Ticket: WideString dispid 1745027102;
    property CashBack: WideString dispid 1745027101;
    property Reference: WideString dispid 1745027100;
    property RFID: WideString dispid 1745027099;
    property BackColor: Integer dispid 1745027098;
    property ForeColor: Integer dispid 1745027097;
    property Enabled: WordBool dispid 1745027096;
    property Font: IFontDisp dispid 1745027095;
    property BackStyle: Smallint dispid 1745027094;
    property BorderStyle: Smallint dispid 1745027093;
    property OutDelay: Single dispid 1745027092;
    property FoodStamp: WordBool dispid 1745027091;
    property AuthCode: WideString dispid 1745027090;
    property Voucher: WideString dispid 1745027089;
    property Gratuity: WideString dispid 1745027088;
    property XMLtran: WordBool dispid 1745027087;
    property Manual: WordBool dispid 1745027086;
    property TroutD: WideString dispid 1745027085;
    property TransNum: WideString dispid 1745027084;
    property IPAddress: WideString dispid 1745027083;
    property Port: Smallint dispid 1745027082;
    property EnableSSL: WordBool dispid 1745027081;
    property Command: WideString dispid 1745027080;
    property CommMethod: CommMethod dispid 1745027079;
    property ShiftID: WideString dispid 1745027078;
    property LanguageCode: WideString dispid 1745027077;
    property MACData: WideString dispid 1745027076;
    property DebitType: WideString dispid 1745027075;
    property OrigPurchData: WideString dispid 1745027074;
    property PumpNumber: WideString dispid 1745027073;
    property SurchargeAmount: WideString dispid 1745027072;
    function GetCaptured: WordBool; dispid 1610809389;
    function GetTroutD: WideString; dispid 1610809390;
    function GetTransNum: WideString; dispid 1610809391;
    function GetApproved: WordBool; dispid 1610809392;
    function GetTI: WideString; dispid 1610809393;
    function GetMSI: WideString; dispid 1610809394;
    function GetAuth: OleVariant; dispid 1610809395;
    function GetRefNumber: WideString; dispid 1610809396;
    function GetResult: OleVariant; dispid 1610809397;
    function GetTermFee: WideString; dispid 1610809398;
    function GetTraceNum: WideString; dispid 1610809399;
    function GetAvlBalance: WideString; dispid 1610809400;
    function GetEBTFoodBalance: WideString; dispid 1610809401;
    function GetEBTCashBalance: WideString; dispid 1610809402;
    function GetAuthAmount: OleVariant; dispid 1610809403;
    function GetAmountDue: OleVariant; dispid 1610809404;
    function GetDCAvailBalance: OleVariant; dispid 1610809405;
    function GetTraceNumber: OleVariant; dispid 1610809406;
    function GetTransactionReferenceNumber: OleVariant; dispid 1610809407;
    function GetSurchargeAmount: OleVariant; dispid 1610809408;
    function GetErrorDesc: WideString; dispid 1610809409;
    function GetErrorCode: Integer; dispid 1610809410;
    function DeleteUserFiles: OleVariant; dispid 1610809411;
    function PccSysExists: WordBool; dispid 1610809413;
    procedure Clear; dispid 1610809417;
    function GetXMLResponse: WideString; dispid 1610809418;
    function Send(var FileType: FileType): OleVariant; dispid 1610809419;
    function VerifyAmount: WordBool; dispid 1610809420;
    function Connect: WordBool; dispid 1610809425;
    function Disconnect: OleVariant; dispid 1610809426;
    function About: WordBool; dispid -552;
    function Cancel: OleVariant; dispid 1610809427;
    function GetAuxRespCode: WideString; dispid 1610809428;
    function GetPOSSequenceNumber(var compareCSN: WideString): WideString; dispid 1610809429;
    function GetXMLRequest: WideString; dispid 1610809431;
  end;

// *********************************************************************//
// DispIntf:  __OCXDebit
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {C7F31DA7-4248-4DDC-B973-080F1B36B5A4}
// *********************************************************************//
  __OCXDebit = dispinterface
    ['{C7F31DA7-4248-4DDC-B973-080F1B36B5A4}']
    procedure Finish; dispid 1;
    procedure Error; dispid 2;
    procedure Click; dispid 3;
    procedure DblClick; dispid 4;
    procedure KeyDown(var KeyCode: Smallint; var Shift: Smallint); dispid 5;
    procedure KeyPress(var KeyAscii: Smallint); dispid 6;
    procedure KeyUp(var KeyCode: Smallint; var Shift: Smallint); dispid 7;
    procedure MouseDown(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 8;
    procedure MouseMove(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 9;
    procedure MouseUp(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 10;
  end;

// *********************************************************************//
// Interface: _pccTran
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8EA63A04-3351-4CCA-A10B-4F2ECB69A765}
// *********************************************************************//
  _pccTran = interface(IDispatch)
    ['{8EA63A04-3351-4CCA-A10B-4F2ECB69A765}']
    function Get_mszTransPacket: WideString; safecall;
    procedure Set_mszTransPacket(const mszTransPacket: WideString); safecall;
    procedure Set_TransPacket(var Param1: WideString); safecall;
    function Get_TransPacket: WideString; safecall;
    procedure Set_TaxExempt(var Param1: WordBool); safecall;
    function Get_TaxExempt: WordBool; safecall;
    procedure Set_Method(var Param1: TxnMethodType); safecall;
    function Get_Method: TxnMethodType; safecall;
    procedure Set_TransTime(var Param1: WideString); safecall;
    function Get_TransTime: WideString; safecall;
    procedure Set_TotTransTime(var Param1: WideString); safecall;
    function Get_TotTransTime: WideString; safecall;
    procedure Set_BillPay(var Param1: WideString); safecall;
    function Get_BillPay: WideString; safecall;
    procedure Set_AuthCode(var Param1: WideString); safecall;
    function Get_AuthCode: WideString; safecall;
    procedure Set_TxnTimeout(var Param1: WideString); safecall;
    function Get_TxnTimeout: WideString; safecall;
    procedure Set_CfgEnabled(var Param1: WordBool); safecall;
    function Get_CfgEnabled: WordBool; safecall;
    procedure Set_CfgType(var Param1: Byte); safecall;
    function Get_CfgType: Byte; safecall;
    procedure Set_CfgPath(var Param1: WideString); safecall;
    function Get_CfgPath: WideString; safecall;
    procedure Set_CfgSizeLimit(var Param1: WideString); safecall;
    function Get_CfgSizeLimit: WideString; safecall;
    procedure Set_CfgKeepDays(var Param1: WideString); safecall;
    function Get_CfgKeepDays: WideString; safecall;
    procedure Set_Partial(var Param1: WordBool); safecall;
    function Get_Partial: WordBool; safecall;
    procedure Set_FORCE(var Param1: WordBool); safecall;
    function Get_FORCE: WordBool; safecall;
    procedure Set_TotalNumCards(var Param1: WideString); safecall;
    function Get_TotalNumCards: WideString; safecall;
    procedure Set_GiftSeqNum(var Param1: WideString); safecall;
    function Get_GiftSeqNum: WideString; safecall;
    procedure Set_IndType(var Param1: WideString); safecall;
    function Get_IndType: WideString; safecall;
    procedure Set_SourceCard(var Param1: WideString); safecall;
    function Get_SourceCard: WideString; safecall;
    procedure Set_Loyalty(var Param1: WordBool); safecall;
    function Get_Loyalty: WordBool; safecall;
    procedure Set_GiftUnits(var Param1: WideString); safecall;
    function Get_GiftUnits: WideString; safecall;
    procedure Set_CashierNum(var Param1: WideString); safecall;
    function Get_CashierNum: WideString; safecall;
    procedure Set_ManagerNum(var Param1: WideString); safecall;
    function Get_ManagerNum: WideString; safecall;
    procedure Set_CheckNum(var Param1: WideString); safecall;
    function Get_CheckNum: WideString; safecall;
    procedure Set_Birth_Date(var Param1: WideString); safecall;
    function Get_Birth_Date: WideString; safecall;
    procedure Set_Phone_Number(var Param1: WideString); safecall;
    function Get_Phone_Number: WideString; safecall;
    procedure Set_RFID(var Param1: WideString); safecall;
    function Get_RFID: WideString; safecall;
    procedure Set_ABANum(var Param1: WideString); safecall;
    function Get_ABANum: WideString; safecall;
    procedure Set_License(var Param1: WideString); safecall;
    function Get_License: WideString; safecall;
    procedure Set_State(var Param1: WideString); safecall;
    function Get_State: WideString; safecall;
    procedure Set_MICR(var Param1: WideString); safecall;
    function Get_MICR: WideString; safecall;
    procedure Set_OrigPurchData(var Param1: WideString); safecall;
    function Get_OrigPurchData: WideString; safecall;
    procedure Set_VoucherNum(var Param1: WideString); safecall;
    function Get_VoucherNum: WideString; safecall;
    procedure Set_POSSeqNum(var Param1: WideString); safecall;
    function Get_POSSeqNum: WideString; safecall;
    procedure Set_DebitType(var Param1: WideString); safecall;
    function Get_DebitType: WideString; safecall;
    procedure Set_MACBlock(var Param1: WideString); safecall;
    function Get_MACBlock: WideString; safecall;
    procedure Set_PINBlock(var Param1: WideString); safecall;
    function Get_PINBlock: WideString; safecall;
    procedure Set_CashbackAmnt(var Param1: WideString); safecall;
    function Get_CashbackAmnt: WideString; safecall;
    procedure Set_KeySerialNum(var Param1: WideString); safecall;
    function Get_KeySerialNum: WideString; safecall;
    procedure Set_LanguageCode(var Param1: WideString); safecall;
    function Get_LanguageCode: WideString; safecall;
    procedure Set_ShiftID(var Param1: WideString); safecall;
    function Get_ShiftID: WideString; safecall;
    procedure Set_PromoCode(var Param1: WideString); safecall;
    function Get_PromoCode: WideString; safecall;
    function Get_TranCount: WideString; safecall;
    procedure Set_Store(var Param1: WideString); safecall;
    function Get_Store: WideString; safecall;
    procedure Set_EBTType(var Param1: WideString); safecall;
    function Get_EBTType: WideString; safecall;
    function Get_GetXML: WideString; safecall;
    procedure Set_AmxDescription_1(var Param1: WideString); safecall;
    function Get_AmxDescription_1: WideString; safecall;
    procedure Set_AmxDescription_2(var Param1: WideString); safecall;
    function Get_AmxDescription_2: WideString; safecall;
    procedure Set_AmxDescription_3(var Param1: WideString); safecall;
    function Get_AmxDescription_3: WideString; safecall;
    procedure Set_AmxDescription_4(var Param1: WideString); safecall;
    function Get_AmxDescription_4: WideString; safecall;
    procedure Set_AmxChargeDescription(var Param1: WideString); safecall;
    function Get_AmxChargeDescription: WideString; safecall;
    procedure Set_OriginalAmnt(var Param1: WideString); safecall;
    function Get_OriginalAmnt: WideString; safecall;
    procedure Set_TargetTransaction(var Param1: WideString); safecall;
    function Get_TargetTransaction: WideString; safecall;
    procedure Set_CmrclCardFlag(var Param1: WideString); safecall;
    function Get_CmrclCardFlag: WideString; safecall;
    procedure Set_ImpTransFlag(var Param1: WordBool); safecall;
    function Get_ImpTransFlag: WordBool; safecall;
    procedure Set_EnhancedTransFlag(var Param1: WordBool); safecall;
    function Get_EnhancedTransFlag: WordBool; safecall;
    procedure Set_GratuityAmntEst(var Param1: WideString); safecall;
    function Get_GratuityAmntEst: WideString; safecall;
    procedure Set_GratuityAmnt(var Param1: WideString); safecall;
    function Get_GratuityAmnt: WideString; safecall;
    procedure Set_ItemID(var Param1: WideString); safecall;
    function Get_ItemID: WideString; safecall;
    procedure Set_Processor(var Param1: WideString); safecall;
    function Get_Processor: WideString; safecall;
    procedure Set_TID(var Param1: WideString); safecall;
    function Get_TID: WideString; safecall;
    procedure Set_Card(var Param1: WideString); safecall;
    function Get_Card: WideString; safecall;
    procedure Set_ExpDate(var Param1: WideString); safecall;
    function Get_ExpDate: WideString; safecall;
    procedure Set_Action(var Param1: WideString); safecall;
    function Get_Action: WideString; safecall;
    procedure Set_Manual(var Param1: WideString); safecall;
    function Get_Manual: WideString; safecall;
    procedure Set_Amount(var Param1: WideString); safecall;
    function Get_Amount: WideString; safecall;
    procedure Set_Ref(var Param1: WideString); safecall;
    function Get_Ref: WideString; safecall;
    procedure Set_Track(var Param1: WideString); safecall;
    function Get_Track: WideString; safecall;
    procedure Set_CID(var Param1: WideString); safecall;
    function Get_CID: WideString; safecall;
    procedure Set_Tax(var Param1: WideString); safecall;
    function Get_Tax: WideString; safecall;
    procedure Set_ExtFile(var Param1: WideString); safecall;
    function Get_ExtFile: WideString; safecall;
    procedure Set_PrintReceipts(var Param1: WideString); safecall;
    function Get_PrintReceipts: WideString; safecall;
    procedure Set_PeriodicPayment(var Param1: WideString); safecall;
    function Get_PeriodicPayment: WideString; safecall;
    procedure Set_Offline(var Param1: WideString); safecall;
    function Get_Offline: WideString; safecall;
    procedure Set_VoidFlag(var Param1: WideString); safecall;
    function Get_VoidFlag: WideString; safecall;
    procedure Set_Zip(var Param1: WideString); safecall;
    function Get_Zip: WideString; safecall;
    procedure Set_Street(var Param1: WideString); safecall;
    function Get_Street: WideString; safecall;
    procedure Set_Ticket(var Param1: WideString); safecall;
    function Get_Ticket: WideString; safecall;
    procedure Set_Member(var Param1: WideString); safecall;
    function Get_Member: WideString; safecall;
    procedure Set_TI(var Param1: WideString); safecall;
    function Get_TI: WideString; safecall;
    procedure Set_TOTALAUTH(var Param1: WideString); safecall;
    function Get_TOTALAUTH: WideString; safecall;
    procedure Set_SplitProcessor(var Param1: WideString); safecall;
    function Get_SplitProcessor: WideString; safecall;
    procedure Set_MCSN(var Param1: WideString); safecall;
    function Get_MCSN: WideString; safecall;
    procedure Set_MCSC(var Param1: WideString); safecall;
    function Get_MCSC: WideString; safecall;
    procedure Set_Multi(var Param1: WideString); safecall;
    function Get_Multi: WideString; safecall;
    procedure Set_CVV2(var Param1: WideString); safecall;
    function Get_CVV2: WideString; safecall;
    procedure Set_CardPresent(var Param1: WideString); safecall;
    function Get_CardPresent: WideString; safecall;
    procedure Set_TroutD(var Param1: WideString); safecall;
    function Get_TroutD: WideString; safecall;
    procedure Set_SequenceNum(var Param1: WideString); safecall;
    function Get_SequenceNum: WideString; safecall;
    procedure Set_Username(var Param1: WideString); safecall;
    function Get_Username: WideString; safecall;
    procedure Set_Password(var Param1: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_InpType(var Param1: FileType); safecall;
    function Get_InpType: FileType; safecall;
    procedure Set_RespType(var Param1: TRespType); safecall;
    function Get_RespType: TRespType; safecall;
    function Get_Error: TranError; safecall;
    procedure Set_FileName(var Param1: WideString); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_XDRFile(var Param1: WideString); safecall;
    function Get_XDRFile: WideString; safecall;
    procedure Set_IsPurchaseCard(var Param1: WordBool); safecall;
    function Get_IsPurchaseCard: WordBool; safecall;
    procedure Set_DriverID(var Param1: WideString); safecall;
    function Get_DriverID: WideString; safecall;
    procedure Set_DriverPIN(var Param1: WideString); safecall;
    function Get_DriverPIN: WideString; safecall;
    procedure Set_IDNumber(var Param1: WideString); safecall;
    function Get_IDNumber: WideString; safecall;
    procedure Set_Odometer(var Param1: WideString); safecall;
    function Get_Odometer: WideString; safecall;
    procedure Set_RestrictionCode(var Param1: WideString); safecall;
    function Get_RestrictionCode: WideString; safecall;
    procedure Set_VehicleID(var Param1: WideString); safecall;
    function Get_VehicleID: WideString; safecall;
    procedure Set_ProductDetailCount(var Param1: WideString); safecall;
    function Get_ProductDetailCount: WideString; safecall;
    procedure Set_ProductDetailCode_1(var Param1: WideString); safecall;
    function Get_ProductDetailCode_1: WideString; safecall;
    procedure Set_ProductDetailCode_2(var Param1: WideString); safecall;
    function Get_ProductDetailCode_2: WideString; safecall;
    procedure Set_ProductDetailCode_3(var Param1: WideString); safecall;
    function Get_ProductDetailCode_3: WideString; safecall;
    procedure Set_ProductDetailCode_4(var Param1: WideString); safecall;
    function Get_ProductDetailCode_4: WideString; safecall;
    procedure Set_ProductDetailCode_5(var Param1: WideString); safecall;
    function Get_ProductDetailCode_5: WideString; safecall;
    procedure Set_ProductDetailCode_6(var Param1: WideString); safecall;
    function Get_ProductDetailCode_6: WideString; safecall;
    procedure Set_ProductDetailCode_7(var Param1: WideString); safecall;
    function Get_ProductDetailCode_7: WideString; safecall;
    procedure Set_ProductDetailCode_8(var Param1: WideString); safecall;
    function Get_ProductDetailCode_8: WideString; safecall;
    procedure Set_ProductDetailCode_9(var Param1: WideString); safecall;
    function Get_ProductDetailCode_9: WideString; safecall;
    procedure Set_ProductDetailCode_10(var Param1: WideString); safecall;
    function Get_ProductDetailCode_10: WideString; safecall;
    procedure Set_ProductDetailAmount_1(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_1: WideString; safecall;
    procedure Set_ProductDetailAmount_2(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_2: WideString; safecall;
    procedure Set_ProductDetailAmount_3(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_3: WideString; safecall;
    procedure Set_ProductDetailAmount_4(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_4: WideString; safecall;
    procedure Set_ProductDetailAmount_5(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_5: WideString; safecall;
    procedure Set_ProductDetailAmount_6(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_6: WideString; safecall;
    procedure Set_ProductDetailAmount_7(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_7: WideString; safecall;
    procedure Set_ProductDetailAmount_8(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_8: WideString; safecall;
    procedure Set_ProductDetailAmount_9(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_9: WideString; safecall;
    procedure Set_ProductDetailAmount_10(var Param1: WideString); safecall;
    function Get_ProductDetailAmount_10: WideString; safecall;
    procedure Set_ProductDetailQuantity_1(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_1: WideString; safecall;
    procedure Set_ProductDetailQuantity_2(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_2: WideString; safecall;
    procedure Set_ProductDetailQuantity_3(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_3: WideString; safecall;
    procedure Set_ProductDetailQuantity_4(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_4: WideString; safecall;
    procedure Set_ProductDetailQuantity_5(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_5: WideString; safecall;
    procedure Set_ProductDetailQuantity_6(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_6: WideString; safecall;
    procedure Set_ProductDetailQuantity_7(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_7: WideString; safecall;
    procedure Set_ProductDetailQuantity_8(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_8: WideString; safecall;
    procedure Set_ProductDetailQuantity_9(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_9: WideString; safecall;
    procedure Set_ProductDetailQuantity_10(var Param1: WideString); safecall;
    function Get_ProductDetailQuantity_10: WideString; safecall;
    procedure Set_StoreNum(var Param1: WideString); safecall;
    function Get_StoreNum: WideString; safecall;
    procedure Set_SSNum(var Param1: WideString); safecall;
    function Get_SSNum: WideString; safecall;
    procedure Set_CustomerHouseNum(var Param1: WideString); safecall;
    function Get_CustomerHouseNum: WideString; safecall;
    procedure Set_PumpNumber(var Param1: WideString); safecall;
    function Get_PumpNumber: WideString; safecall;
    procedure Set_SurchargeAmount(var Param1: WideString); safecall;
    function Get_SurchargeAmount: WideString; safecall;
    function Load(var szFileName: OleVariant; var intRecNum: Smallint; var blnValidate: WordBool): TranErrType; safecall;
    function WriteFile(var eType: FileType; var szNewPrefix: OleVariant; var szNewPath: OleVariant; 
                       var intRecNum: Smallint): TranErrType; safecall;
    function ValidateRequiredFields: TranErrType; safecall;
    function CleanString(var szStringIn: WideString; var szReplaceList: WideString; 
                         var blnCompact: WordBool; var blnTrim: WordBool; var blnRmvNP: WordBool): WideString; safecall;
    procedure Clear; safecall;
    procedure ClearTranData; safecall;
    procedure ClearErr; safecall;
    function TxnType: Smallint; safecall;
    function LoadTranData(var intNdx: Smallint): OleVariant; safecall;
    function WriteRawXML(var szOutString: WideString; var szFileName: WideString; 
                         var szPath: OleVariant): TranErrType; safecall;
    function PrepString(var szInData: WideString): WideString; safecall;
    property mszTransPacket: WideString read Get_mszTransPacket write Set_mszTransPacket;
    property TransPacket: WideString read Get_TransPacket write Set_TransPacket;
    property TaxExempt: WordBool read Get_TaxExempt write Set_TaxExempt;
    property Method: TxnMethodType read Get_Method write Set_Method;
    property TransTime: WideString read Get_TransTime write Set_TransTime;
    property TotTransTime: WideString read Get_TotTransTime write Set_TotTransTime;
    property BillPay: WideString read Get_BillPay write Set_BillPay;
    property AuthCode: WideString read Get_AuthCode write Set_AuthCode;
    property TxnTimeout: WideString read Get_TxnTimeout write Set_TxnTimeout;
    property CfgEnabled: WordBool read Get_CfgEnabled write Set_CfgEnabled;
    property CfgType: Byte read Get_CfgType write Set_CfgType;
    property CfgPath: WideString read Get_CfgPath write Set_CfgPath;
    property CfgSizeLimit: WideString read Get_CfgSizeLimit write Set_CfgSizeLimit;
    property CfgKeepDays: WideString read Get_CfgKeepDays write Set_CfgKeepDays;
    property Partial: WordBool read Get_Partial write Set_Partial;
    property FORCE: WordBool read Get_FORCE write Set_FORCE;
    property TotalNumCards: WideString read Get_TotalNumCards write Set_TotalNumCards;
    property GiftSeqNum: WideString read Get_GiftSeqNum write Set_GiftSeqNum;
    property IndType: WideString read Get_IndType write Set_IndType;
    property SourceCard: WideString read Get_SourceCard write Set_SourceCard;
    property Loyalty: WordBool read Get_Loyalty write Set_Loyalty;
    property GiftUnits: WideString read Get_GiftUnits write Set_GiftUnits;
    property CashierNum: WideString read Get_CashierNum write Set_CashierNum;
    property ManagerNum: WideString read Get_ManagerNum write Set_ManagerNum;
    property CheckNum: WideString read Get_CheckNum write Set_CheckNum;
    property Birth_Date: WideString read Get_Birth_Date write Set_Birth_Date;
    property Phone_Number: WideString read Get_Phone_Number write Set_Phone_Number;
    property RFID: WideString read Get_RFID write Set_RFID;
    property ABANum: WideString read Get_ABANum write Set_ABANum;
    property License: WideString read Get_License write Set_License;
    property State: WideString read Get_State write Set_State;
    property MICR: WideString read Get_MICR write Set_MICR;
    property OrigPurchData: WideString read Get_OrigPurchData write Set_OrigPurchData;
    property VoucherNum: WideString read Get_VoucherNum write Set_VoucherNum;
    property POSSeqNum: WideString read Get_POSSeqNum write Set_POSSeqNum;
    property DebitType: WideString read Get_DebitType write Set_DebitType;
    property MACBlock: WideString read Get_MACBlock write Set_MACBlock;
    property PINBlock: WideString read Get_PINBlock write Set_PINBlock;
    property CashbackAmnt: WideString read Get_CashbackAmnt write Set_CashbackAmnt;
    property KeySerialNum: WideString read Get_KeySerialNum write Set_KeySerialNum;
    property LanguageCode: WideString read Get_LanguageCode write Set_LanguageCode;
    property ShiftID: WideString read Get_ShiftID write Set_ShiftID;
    property PromoCode: WideString read Get_PromoCode write Set_PromoCode;
    property TranCount: WideString read Get_TranCount;
    property Store: WideString read Get_Store write Set_Store;
    property EBTType: WideString read Get_EBTType write Set_EBTType;
    property GetXML: WideString read Get_GetXML;
    property AmxDescription_1: WideString read Get_AmxDescription_1 write Set_AmxDescription_1;
    property AmxDescription_2: WideString read Get_AmxDescription_2 write Set_AmxDescription_2;
    property AmxDescription_3: WideString read Get_AmxDescription_3 write Set_AmxDescription_3;
    property AmxDescription_4: WideString read Get_AmxDescription_4 write Set_AmxDescription_4;
    property AmxChargeDescription: WideString read Get_AmxChargeDescription write Set_AmxChargeDescription;
    property OriginalAmnt: WideString read Get_OriginalAmnt write Set_OriginalAmnt;
    property TargetTransaction: WideString read Get_TargetTransaction write Set_TargetTransaction;
    property CmrclCardFlag: WideString read Get_CmrclCardFlag write Set_CmrclCardFlag;
    property ImpTransFlag: WordBool read Get_ImpTransFlag write Set_ImpTransFlag;
    property EnhancedTransFlag: WordBool read Get_EnhancedTransFlag write Set_EnhancedTransFlag;
    property GratuityAmntEst: WideString read Get_GratuityAmntEst write Set_GratuityAmntEst;
    property GratuityAmnt: WideString read Get_GratuityAmnt write Set_GratuityAmnt;
    property ItemID: WideString read Get_ItemID write Set_ItemID;
    property Processor: WideString read Get_Processor write Set_Processor;
    property TID: WideString read Get_TID write Set_TID;
    property Card: WideString read Get_Card write Set_Card;
    property ExpDate: WideString read Get_ExpDate write Set_ExpDate;
    property Action: WideString read Get_Action write Set_Action;
    property Manual: WideString read Get_Manual write Set_Manual;
    property Amount: WideString read Get_Amount write Set_Amount;
    property Ref: WideString read Get_Ref write Set_Ref;
    property Track: WideString read Get_Track write Set_Track;
    property CID: WideString read Get_CID write Set_CID;
    property Tax: WideString read Get_Tax write Set_Tax;
    property ExtFile: WideString read Get_ExtFile write Set_ExtFile;
    property PrintReceipts: WideString read Get_PrintReceipts write Set_PrintReceipts;
    property PeriodicPayment: WideString read Get_PeriodicPayment write Set_PeriodicPayment;
    property Offline: WideString read Get_Offline write Set_Offline;
    property VoidFlag: WideString read Get_VoidFlag write Set_VoidFlag;
    property Zip: WideString read Get_Zip write Set_Zip;
    property Street: WideString read Get_Street write Set_Street;
    property Ticket: WideString read Get_Ticket write Set_Ticket;
    property Member: WideString read Get_Member write Set_Member;
    property TI: WideString read Get_TI write Set_TI;
    property TOTALAUTH: WideString read Get_TOTALAUTH write Set_TOTALAUTH;
    property SplitProcessor: WideString read Get_SplitProcessor write Set_SplitProcessor;
    property MCSN: WideString read Get_MCSN write Set_MCSN;
    property MCSC: WideString read Get_MCSC write Set_MCSC;
    property Multi: WideString read Get_Multi write Set_Multi;
    property CVV2: WideString read Get_CVV2 write Set_CVV2;
    property CardPresent: WideString read Get_CardPresent write Set_CardPresent;
    property TroutD: WideString read Get_TroutD write Set_TroutD;
    property SequenceNum: WideString read Get_SequenceNum write Set_SequenceNum;
    property Username: WideString read Get_Username write Set_Username;
    property Password: WideString read Get_Password write Set_Password;
    property InpType: FileType read Get_InpType write Set_InpType;
    property RespType: TRespType read Get_RespType write Set_RespType;
    property Error: TranError read Get_Error;
    property FileName: WideString read Get_FileName write Set_FileName;
    property XDRFile: WideString read Get_XDRFile write Set_XDRFile;
    property IsPurchaseCard: WordBool read Get_IsPurchaseCard write Set_IsPurchaseCard;
    property DriverID: WideString read Get_DriverID write Set_DriverID;
    property DriverPIN: WideString read Get_DriverPIN write Set_DriverPIN;
    property IDNumber: WideString read Get_IDNumber write Set_IDNumber;
    property Odometer: WideString read Get_Odometer write Set_Odometer;
    property RestrictionCode: WideString read Get_RestrictionCode write Set_RestrictionCode;
    property VehicleID: WideString read Get_VehicleID write Set_VehicleID;
    property ProductDetailCount: WideString read Get_ProductDetailCount write Set_ProductDetailCount;
    property ProductDetailCode_1: WideString read Get_ProductDetailCode_1 write Set_ProductDetailCode_1;
    property ProductDetailCode_2: WideString read Get_ProductDetailCode_2 write Set_ProductDetailCode_2;
    property ProductDetailCode_3: WideString read Get_ProductDetailCode_3 write Set_ProductDetailCode_3;
    property ProductDetailCode_4: WideString read Get_ProductDetailCode_4 write Set_ProductDetailCode_4;
    property ProductDetailCode_5: WideString read Get_ProductDetailCode_5 write Set_ProductDetailCode_5;
    property ProductDetailCode_6: WideString read Get_ProductDetailCode_6 write Set_ProductDetailCode_6;
    property ProductDetailCode_7: WideString read Get_ProductDetailCode_7 write Set_ProductDetailCode_7;
    property ProductDetailCode_8: WideString read Get_ProductDetailCode_8 write Set_ProductDetailCode_8;
    property ProductDetailCode_9: WideString read Get_ProductDetailCode_9 write Set_ProductDetailCode_9;
    property ProductDetailCode_10: WideString read Get_ProductDetailCode_10 write Set_ProductDetailCode_10;
    property ProductDetailAmount_1: WideString read Get_ProductDetailAmount_1 write Set_ProductDetailAmount_1;
    property ProductDetailAmount_2: WideString read Get_ProductDetailAmount_2 write Set_ProductDetailAmount_2;
    property ProductDetailAmount_3: WideString read Get_ProductDetailAmount_3 write Set_ProductDetailAmount_3;
    property ProductDetailAmount_4: WideString read Get_ProductDetailAmount_4 write Set_ProductDetailAmount_4;
    property ProductDetailAmount_5: WideString read Get_ProductDetailAmount_5 write Set_ProductDetailAmount_5;
    property ProductDetailAmount_6: WideString read Get_ProductDetailAmount_6 write Set_ProductDetailAmount_6;
    property ProductDetailAmount_7: WideString read Get_ProductDetailAmount_7 write Set_ProductDetailAmount_7;
    property ProductDetailAmount_8: WideString read Get_ProductDetailAmount_8 write Set_ProductDetailAmount_8;
    property ProductDetailAmount_9: WideString read Get_ProductDetailAmount_9 write Set_ProductDetailAmount_9;
    property ProductDetailAmount_10: WideString read Get_ProductDetailAmount_10 write Set_ProductDetailAmount_10;
    property ProductDetailQuantity_1: WideString read Get_ProductDetailQuantity_1 write Set_ProductDetailQuantity_1;
    property ProductDetailQuantity_2: WideString read Get_ProductDetailQuantity_2 write Set_ProductDetailQuantity_2;
    property ProductDetailQuantity_3: WideString read Get_ProductDetailQuantity_3 write Set_ProductDetailQuantity_3;
    property ProductDetailQuantity_4: WideString read Get_ProductDetailQuantity_4 write Set_ProductDetailQuantity_4;
    property ProductDetailQuantity_5: WideString read Get_ProductDetailQuantity_5 write Set_ProductDetailQuantity_5;
    property ProductDetailQuantity_6: WideString read Get_ProductDetailQuantity_6 write Set_ProductDetailQuantity_6;
    property ProductDetailQuantity_7: WideString read Get_ProductDetailQuantity_7 write Set_ProductDetailQuantity_7;
    property ProductDetailQuantity_8: WideString read Get_ProductDetailQuantity_8 write Set_ProductDetailQuantity_8;
    property ProductDetailQuantity_9: WideString read Get_ProductDetailQuantity_9 write Set_ProductDetailQuantity_9;
    property ProductDetailQuantity_10: WideString read Get_ProductDetailQuantity_10 write Set_ProductDetailQuantity_10;
    property StoreNum: WideString read Get_StoreNum write Set_StoreNum;
    property SSNum: WideString read Get_SSNum write Set_SSNum;
    property CustomerHouseNum: WideString read Get_CustomerHouseNum write Set_CustomerHouseNum;
    property PumpNumber: WideString read Get_PumpNumber write Set_PumpNumber;
    property SurchargeAmount: WideString read Get_SurchargeAmount write Set_SurchargeAmount;
  end;

// *********************************************************************//
// DispIntf:  _pccTranDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8EA63A04-3351-4CCA-A10B-4F2ECB69A765}
// *********************************************************************//
  _pccTranDisp = dispinterface
    ['{8EA63A04-3351-4CCA-A10B-4F2ECB69A765}']
    property mszTransPacket: WideString dispid 1073938572;
    property TransPacket: WideString dispid 1745027210;
    property TaxExempt: WordBool dispid 1745027209;
    property Method: TxnMethodType dispid 1745027208;
    property TransTime: WideString dispid 1745027207;
    property TotTransTime: WideString dispid 1745027206;
    property BillPay: WideString dispid 1745027205;
    property AuthCode: WideString dispid 1745027204;
    property TxnTimeout: WideString dispid 1745027203;
    property CfgEnabled: WordBool dispid 1745027202;
    property CfgType: Byte dispid 1745027201;
    property CfgPath: WideString dispid 1745027200;
    property CfgSizeLimit: WideString dispid 1745027199;
    property CfgKeepDays: WideString dispid 1745027198;
    property Partial: WordBool dispid 1745027197;
    property FORCE: WordBool dispid 1745027196;
    property TotalNumCards: WideString dispid 1745027195;
    property GiftSeqNum: WideString dispid 1745027194;
    property IndType: WideString dispid 1745027193;
    property SourceCard: WideString dispid 1745027192;
    property Loyalty: WordBool dispid 1745027191;
    property GiftUnits: WideString dispid 1745027190;
    property CashierNum: WideString dispid 1745027189;
    property ManagerNum: WideString dispid 1745027188;
    property CheckNum: WideString dispid 1745027187;
    property Birth_Date: WideString dispid 1745027186;
    property Phone_Number: WideString dispid 1745027185;
    property RFID: WideString dispid 1745027184;
    property ABANum: WideString dispid 1745027183;
    property License: WideString dispid 1745027182;
    property State: WideString dispid 1745027181;
    property MICR: WideString dispid 1745027180;
    property OrigPurchData: WideString dispid 1745027179;
    property VoucherNum: WideString dispid 1745027178;
    property POSSeqNum: WideString dispid 1745027177;
    property DebitType: WideString dispid 1745027176;
    property MACBlock: WideString dispid 1745027175;
    property PINBlock: WideString dispid 1745027174;
    property CashbackAmnt: WideString dispid 1745027173;
    property KeySerialNum: WideString dispid 1745027172;
    property LanguageCode: WideString dispid 1745027171;
    property ShiftID: WideString dispid 1745027170;
    property PromoCode: WideString dispid 1745027169;
    property TranCount: WideString readonly dispid 1745027168;
    property Store: WideString dispid 1745027167;
    property EBTType: WideString dispid 1745027166;
    property GetXML: WideString readonly dispid 1745027165;
    property AmxDescription_1: WideString dispid 1745027164;
    property AmxDescription_2: WideString dispid 1745027163;
    property AmxDescription_3: WideString dispid 1745027162;
    property AmxDescription_4: WideString dispid 1745027161;
    property AmxChargeDescription: WideString dispid 1745027160;
    property OriginalAmnt: WideString dispid 1745027159;
    property TargetTransaction: WideString dispid 1745027158;
    property CmrclCardFlag: WideString dispid 1745027157;
    property ImpTransFlag: WordBool dispid 1745027156;
    property EnhancedTransFlag: WordBool dispid 1745027155;
    property GratuityAmntEst: WideString dispid 1745027154;
    property GratuityAmnt: WideString dispid 1745027153;
    property ItemID: WideString dispid 1745027152;
    property Processor: WideString dispid 1745027151;
    property TID: WideString dispid 1745027150;
    property Card: WideString dispid 1745027149;
    property ExpDate: WideString dispid 1745027148;
    property Action: WideString dispid 1745027147;
    property Manual: WideString dispid 1745027146;
    property Amount: WideString dispid 1745027145;
    property Ref: WideString dispid 1745027144;
    property Track: WideString dispid 1745027143;
    property CID: WideString dispid 1745027142;
    property Tax: WideString dispid 1745027141;
    property ExtFile: WideString dispid 1745027140;
    property PrintReceipts: WideString dispid 1745027139;
    property PeriodicPayment: WideString dispid 1745027138;
    property Offline: WideString dispid 1745027137;
    property VoidFlag: WideString dispid 1745027136;
    property Zip: WideString dispid 1745027135;
    property Street: WideString dispid 1745027134;
    property Ticket: WideString dispid 1745027133;
    property Member: WideString dispid 1745027132;
    property TI: WideString dispid 1745027131;
    property TOTALAUTH: WideString dispid 1745027130;
    property SplitProcessor: WideString dispid 1745027129;
    property MCSN: WideString dispid 1745027128;
    property MCSC: WideString dispid 1745027127;
    property Multi: WideString dispid 1745027126;
    property CVV2: WideString dispid 1745027125;
    property CardPresent: WideString dispid 1745027124;
    property TroutD: WideString dispid 1745027123;
    property SequenceNum: WideString dispid 1745027122;
    property Username: WideString dispid 1745027121;
    property Password: WideString dispid 1745027120;
    property InpType: FileType dispid 1745027119;
    property RespType: TRespType dispid 1745027118;
    property Error: {??TranError}OleVariant readonly dispid 1745027117;
    property FileName: WideString dispid 1745027116;
    property XDRFile: WideString dispid 1745027115;
    property IsPurchaseCard: WordBool dispid 1745027114;
    property DriverID: WideString dispid 1745027113;
    property DriverPIN: WideString dispid 1745027112;
    property IDNumber: WideString dispid 1745027111;
    property Odometer: WideString dispid 1745027110;
    property RestrictionCode: WideString dispid 1745027109;
    property VehicleID: WideString dispid 1745027108;
    property ProductDetailCount: WideString dispid 1745027107;
    property ProductDetailCode_1: WideString dispid 1745027106;
    property ProductDetailCode_2: WideString dispid 1745027105;
    property ProductDetailCode_3: WideString dispid 1745027104;
    property ProductDetailCode_4: WideString dispid 1745027103;
    property ProductDetailCode_5: WideString dispid 1745027102;
    property ProductDetailCode_6: WideString dispid 1745027101;
    property ProductDetailCode_7: WideString dispid 1745027100;
    property ProductDetailCode_8: WideString dispid 1745027099;
    property ProductDetailCode_9: WideString dispid 1745027098;
    property ProductDetailCode_10: WideString dispid 1745027097;
    property ProductDetailAmount_1: WideString dispid 1745027096;
    property ProductDetailAmount_2: WideString dispid 1745027095;
    property ProductDetailAmount_3: WideString dispid 1745027094;
    property ProductDetailAmount_4: WideString dispid 1745027093;
    property ProductDetailAmount_5: WideString dispid 1745027092;
    property ProductDetailAmount_6: WideString dispid 1745027091;
    property ProductDetailAmount_7: WideString dispid 1745027090;
    property ProductDetailAmount_8: WideString dispid 1745027089;
    property ProductDetailAmount_9: WideString dispid 1745027088;
    property ProductDetailAmount_10: WideString dispid 1745027087;
    property ProductDetailQuantity_1: WideString dispid 1745027086;
    property ProductDetailQuantity_2: WideString dispid 1745027085;
    property ProductDetailQuantity_3: WideString dispid 1745027084;
    property ProductDetailQuantity_4: WideString dispid 1745027083;
    property ProductDetailQuantity_5: WideString dispid 1745027082;
    property ProductDetailQuantity_6: WideString dispid 1745027081;
    property ProductDetailQuantity_7: WideString dispid 1745027080;
    property ProductDetailQuantity_8: WideString dispid 1745027079;
    property ProductDetailQuantity_9: WideString dispid 1745027078;
    property ProductDetailQuantity_10: WideString dispid 1745027077;
    property StoreNum: WideString dispid 1745027076;
    property SSNum: WideString dispid 1745027075;
    property CustomerHouseNum: WideString dispid 1745027074;
    property PumpNumber: WideString dispid 1745027073;
    property SurchargeAmount: WideString dispid 1745027072;
    function Load(var szFileName: OleVariant; var intRecNum: Smallint; var blnValidate: WordBool): TranErrType; dispid 1610809483;
    function WriteFile(var eType: FileType; var szNewPrefix: OleVariant; var szNewPath: OleVariant; 
                       var intRecNum: Smallint): TranErrType; dispid 1610809484;
    function ValidateRequiredFields: TranErrType; dispid 1610809485;
    function CleanString(var szStringIn: WideString; var szReplaceList: WideString; 
                         var blnCompact: WordBool; var blnTrim: WordBool; var blnRmvNP: WordBool): WideString; dispid 1610809486;
    procedure Clear; dispid 1610809487;
    procedure ClearTranData; dispid 1610809488;
    procedure ClearErr; dispid 1610809489;
    function TxnType: Smallint; dispid 1610809490;
    function LoadTranData(var intNdx: Smallint): OleVariant; dispid 1610809495;
    function WriteRawXML(var szOutString: WideString; var szFileName: WideString; 
                         var szPath: OleVariant): TranErrType; dispid 1610809498;
    function PrepString(var szInData: WideString): WideString; dispid 1610809500;
  end;

// *********************************************************************//
// The Class CoPccResponse provides a Create and CreateRemote method to          
// create instances of the default interface _PccResponse exposed by              
// the CoClass PccResponse. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPccResponse = class
    class function Create: _PccResponse;
    class function CreateRemote(const MachineName: string): _PccResponse;
  end;

// *********************************************************************//
// The Class CopccTran provides a Create and CreateRemote method to          
// create instances of the default interface _pccTran exposed by              
// the CoClass pccTran. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CopccTran = class
    class function Create: _pccTran;
    class function CreateRemote(const MachineName: string): _pccTran;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TOCXDebit
// Help String      : 
// Default Interface: _OCXDebit
// Def. Intf. DISP? : No
// Event   Interface: __OCXDebit
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TOCXDebitKeyDown = procedure(ASender: TObject; var KeyCode: Smallint; var Shift: Smallint) of object;
  TOCXDebitKeyPress = procedure(ASender: TObject; var KeyAscii: Smallint) of object;
  TOCXDebitKeyUp = procedure(ASender: TObject; var KeyCode: Smallint; var Shift: Smallint) of object;
  TOCXDebitMouseDown = procedure(ASender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                   var X: Single; var Y: Single) of object;
  TOCXDebitMouseMove = procedure(ASender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                   var X: Single; var Y: Single) of object;
  TOCXDebitMouseUp = procedure(ASender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                 var X: Single; var Y: Single) of object;

  TOCXDebit = class(TOleControl)
  private
    FOnFinish: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnKeyDown: TOCXDebitKeyDown;
    FOnKeyPress: TOCXDebitKeyPress;
    FOnKeyUp: TOCXDebitKeyUp;
    FOnMouseDown: TOCXDebitMouseDown;
    FOnMouseMove: TOCXDebitMouseMove;
    FOnMouseUp: TOCXDebitMouseUp;
    FIntf: _OCXDebit;
    function  GetControlInterface: _OCXDebit;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function GetCaptured: WordBool;
    function GetTroutD: WideString;
    function GetTransNum: WideString;
    function GetApproved: WordBool;
    function GetTI: WideString;
    function GetMSI: WideString;
    function GetAuth: OleVariant;
    function GetRefNumber: WideString;
    function GetResult: OleVariant;
    function GetTermFee: WideString;
    function GetTraceNum: WideString;
    function GetAvlBalance: WideString;
    function GetEBTFoodBalance: WideString;
    function GetEBTCashBalance: WideString;
    function GetAuthAmount: OleVariant;
    function GetAmountDue: OleVariant;
    function GetDCAvailBalance: OleVariant;
    function GetTraceNumber: OleVariant;
    function GetTransactionReferenceNumber: OleVariant;
    function GetSurchargeAmount: OleVariant;
    function GetErrorDesc: WideString;
    function GetErrorCode: Integer;
    function DeleteUserFiles: OleVariant;
    function PccSysExists: WordBool;
    procedure Clear;
    function GetXMLResponse: WideString;
    function Send(var FileType: FileType): OleVariant;
    function VerifyAmount: WordBool;
    function Connect: WordBool;
    function Disconnect: OleVariant;
    function About: WordBool;
    function Cancel: OleVariant;
    function GetAuxRespCode: WideString;
    function GetPOSSequenceNumber(var compareCSN: WideString): WideString;
    function GetXMLRequest: WideString;
    property  ControlInterface: _OCXDebit read GetControlInterface;
    property  DefaultInterface: _OCXDebit read GetControlInterface;
    property Font: TFont index 1745027095 read GetTFontProp write _SetTFontProp;
  published
    property Anchors;
    property Action: Integer index 1745027116 read GetIntegerProp write SetIntegerProp stored False;
    property Amount: WideString index 1745027115 read GetWideStringProp write SetWideStringProp stored False;
    property BillPay: WideString index 1745027114 read GetWideStringProp write SetWideStringProp stored False;
    property Card: WideString index 1745027113 read GetWideStringProp write SetWideStringProp stored False;
    property ExpDate: WideString index 1745027112 read GetWideStringProp write SetWideStringProp stored False;
    property Member: WideString index 1745027111 read GetWideStringProp write SetWideStringProp stored False;
    property MerchantNumber: WideString index 1745027110 read GetWideStringProp write SetWideStringProp stored False;
    property Path: WideString index 1745027109 read GetWideStringProp write SetWideStringProp stored False;
    property Processor: WideString index 1745027108 read GetWideStringProp write SetWideStringProp stored False;
    property TimeOut: Integer index 1745027107 read GetIntegerProp write SetIntegerProp stored False;
    property Track: WideString index 1745027106 read GetWideStringProp write SetWideStringProp stored False;
    property User: WideString index 1745027105 read GetWideStringProp write SetWideStringProp stored False;
    property Pin: WideString index 1745027104 read GetWideStringProp write SetWideStringProp stored False;
    property KeySerialNumber: WideString index 1745027103 read GetWideStringProp write SetWideStringProp stored False;
    property Ticket: WideString index 1745027102 read GetWideStringProp write SetWideStringProp stored False;
    property CashBack: WideString index 1745027101 read GetWideStringProp write SetWideStringProp stored False;
    property Reference: WideString index 1745027100 read GetWideStringProp write SetWideStringProp stored False;
    property RFID: WideString index 1745027099 read GetWideStringProp write SetWideStringProp stored False;
    property BackColor: Integer index 1745027098 read GetIntegerProp write SetIntegerProp stored False;
    property ForeColor: Integer index 1745027097 read GetIntegerProp write SetIntegerProp stored False;
    property Enabled: WordBool index 1745027096 read GetWordBoolProp write SetWordBoolProp stored False;
    property BackStyle: Smallint index 1745027094 read GetSmallintProp write SetSmallintProp stored False;
    property BorderStyle: Smallint index 1745027093 read GetSmallintProp write SetSmallintProp stored False;
    property OutDelay: Single index 1745027092 read GetSingleProp write SetSingleProp stored False;
    property FoodStamp: WordBool index 1745027091 read GetWordBoolProp write SetWordBoolProp stored False;
    property AuthCode: WideString index 1745027090 read GetWideStringProp write SetWideStringProp stored False;
    property Voucher: WideString index 1745027089 read GetWideStringProp write SetWideStringProp stored False;
    property Gratuity: WideString index 1745027088 read GetWideStringProp write SetWideStringProp stored False;
    property XMLtran: WordBool index 1745027087 read GetWordBoolProp write SetWordBoolProp stored False;
    property Manual: WordBool index 1745027086 read GetWordBoolProp write SetWordBoolProp stored False;
    property TroutD: WideString index 1745027085 read GetWideStringProp write SetWideStringProp stored False;
    property TransNum: WideString index 1745027084 read GetWideStringProp write SetWideStringProp stored False;
    property IPAddress: WideString index 1745027083 read GetWideStringProp write SetWideStringProp stored False;
    property Port: Smallint index 1745027082 read GetSmallintProp write SetSmallintProp stored False;
    property EnableSSL: WordBool index 1745027081 read GetWordBoolProp write SetWordBoolProp stored False;
    property Command: WideString index 1745027080 read GetWideStringProp write SetWideStringProp stored False;
    property CommMethod: TOleEnum index 1745027079 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ShiftID: WideString index 1745027078 read GetWideStringProp write SetWideStringProp stored False;
    property LanguageCode: WideString index 1745027077 read GetWideStringProp write SetWideStringProp stored False;
    property MACData: WideString index 1745027076 read GetWideStringProp write SetWideStringProp stored False;
    property DebitType: WideString index 1745027075 read GetWideStringProp write SetWideStringProp stored False;
    property OrigPurchData: WideString index 1745027074 read GetWideStringProp write SetWideStringProp stored False;
    property PumpNumber: WideString index 1745027073 read GetWideStringProp write SetWideStringProp stored False;
    property SurchargeAmount: WideString index 1745027072 read GetWideStringProp write SetWideStringProp stored False;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnKeyDown: TOCXDebitKeyDown read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TOCXDebitKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TOCXDebitKeyUp read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TOCXDebitMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TOCXDebitMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TOCXDebitMouseUp read FOnMouseUp write FOnMouseUp;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoPccResponse.Create: _PccResponse;
begin
  Result := CreateComObject(CLASS_PccResponse) as _PccResponse;
end;

class function CoPccResponse.CreateRemote(const MachineName: string): _PccResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PccResponse) as _PccResponse;
end;

class function CopccTran.Create: _pccTran;
begin
  Result := CreateComObject(CLASS_pccTran) as _pccTran;
end;

class function CopccTran.CreateRemote(const MachineName: string): _pccTran;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_pccTran) as _pccTran;
end;

procedure TOCXDebit.InitControlData;
const
  CEventDispIDs: array [0..9] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $00000007, $00000008, $00000009, $0000000A);
  CTFontIDs: array [0..0] of DWORD = (
    $68030017);
  CControlData: TControlData2 = (
    ClassID: '{A877620D-4B6C-4947-AFCB-DEFAF838097D}';
    EventIID: '{C7F31DA7-4248-4DDC-B973-080F1B36B5A4}';
    EventCount: 10;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnFinish) - Cardinal(Self);
end;

procedure TOCXDebit.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _OCXDebit;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TOCXDebit.GetControlInterface: _OCXDebit;
begin
  CreateControl;
  Result := FIntf;
end;

function TOCXDebit.GetCaptured: WordBool;
begin
  Result := DefaultInterface.GetCaptured;
end;

function TOCXDebit.GetTroutD: WideString;
begin
  Result := DefaultInterface.GetTroutD;
end;

function TOCXDebit.GetTransNum: WideString;
begin
  Result := DefaultInterface.GetTransNum;
end;

function TOCXDebit.GetApproved: WordBool;
begin
  Result := DefaultInterface.GetApproved;
end;

function TOCXDebit.GetTI: WideString;
begin
  Result := DefaultInterface.GetTI;
end;

function TOCXDebit.GetMSI: WideString;
begin
  Result := DefaultInterface.GetMSI;
end;

function TOCXDebit.GetAuth: OleVariant;
begin
  Result := DefaultInterface.GetAuth;
end;

function TOCXDebit.GetRefNumber: WideString;
begin
  Result := DefaultInterface.GetRefNumber;
end;

function TOCXDebit.GetResult: OleVariant;
begin
  Result := DefaultInterface.GetResult;
end;

function TOCXDebit.GetTermFee: WideString;
begin
  Result := DefaultInterface.GetTermFee;
end;

function TOCXDebit.GetTraceNum: WideString;
begin
  Result := DefaultInterface.GetTraceNum;
end;

function TOCXDebit.GetAvlBalance: WideString;
begin
  Result := DefaultInterface.GetAvlBalance;
end;

function TOCXDebit.GetEBTFoodBalance: WideString;
begin
  Result := DefaultInterface.GetEBTFoodBalance;
end;

function TOCXDebit.GetEBTCashBalance: WideString;
begin
  Result := DefaultInterface.GetEBTCashBalance;
end;

function TOCXDebit.GetAuthAmount: OleVariant;
begin
  Result := DefaultInterface.GetAuthAmount;
end;

function TOCXDebit.GetAmountDue: OleVariant;
begin
  Result := DefaultInterface.GetAmountDue;
end;

function TOCXDebit.GetDCAvailBalance: OleVariant;
begin
  Result := DefaultInterface.GetDCAvailBalance;
end;

function TOCXDebit.GetTraceNumber: OleVariant;
begin
  Result := DefaultInterface.GetTraceNumber;
end;

function TOCXDebit.GetTransactionReferenceNumber: OleVariant;
begin
  Result := DefaultInterface.GetTransactionReferenceNumber;
end;

function TOCXDebit.GetSurchargeAmount: OleVariant;
begin
  Result := DefaultInterface.GetSurchargeAmount;
end;

function TOCXDebit.GetErrorDesc: WideString;
begin
  Result := DefaultInterface.GetErrorDesc;
end;

function TOCXDebit.GetErrorCode: Integer;
begin
  Result := DefaultInterface.GetErrorCode;
end;

function TOCXDebit.DeleteUserFiles: OleVariant;
begin
  Result := DefaultInterface.DeleteUserFiles;
end;

function TOCXDebit.PccSysExists: WordBool;
begin
  Result := DefaultInterface.PccSysExists;
end;

procedure TOCXDebit.Clear;
begin
  DefaultInterface.Clear;
end;

function TOCXDebit.GetXMLResponse: WideString;
begin
  Result := DefaultInterface.GetXMLResponse;
end;

function TOCXDebit.Send(var FileType: FileType): OleVariant;
begin
  Result := DefaultInterface.Send(FileType);
end;

function TOCXDebit.VerifyAmount: WordBool;
begin
  Result := DefaultInterface.VerifyAmount;
end;

function TOCXDebit.Connect: WordBool;
begin
  Result := DefaultInterface.Connect;
end;

function TOCXDebit.Disconnect: OleVariant;
begin
  Result := DefaultInterface.Disconnect;
end;

function TOCXDebit.About: WordBool;
begin
  Result := DefaultInterface.About;
end;

function TOCXDebit.Cancel: OleVariant;
begin
  Result := DefaultInterface.Cancel;
end;

function TOCXDebit.GetAuxRespCode: WideString;
begin
  Result := DefaultInterface.GetAuxRespCode;
end;

function TOCXDebit.GetPOSSequenceNumber(var compareCSN: WideString): WideString;
begin
  Result := DefaultInterface.GetPOSSequenceNumber(compareCSN);
end;

function TOCXDebit.GetXMLRequest: WideString;
begin
  Result := DefaultInterface.GetXMLRequest;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TOCXDebit]);
end;

end.
