unit SC550_TLB;

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
// File generated on 8/9/2007 1:47:21 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\kheira_m1\Desktop\libraries\SC550.tlb (1)
// LIBID: {CA0C5E93-23B9-499F-9B37-B5BB74CDB966}
// LCID: 0
// Helpfile: 
// HelpString: GO Software's SC550 ActiveX Control
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
  SC550MajorVersion = 1;
  SC550MinorVersion = 0;

  LIBID_SC550: TGUID = '{CA0C5E93-23B9-499F-9B37-B5BB74CDB966}';

  IID__PinSC550: TGUID = '{1E874A2E-08CE-467F-8FC6-C8120735FF4A}';
  DIID___PinSC550: TGUID = '{58DBA776-1B08-4BB5-87D9-8D630BEEE7B9}';
  IID__clsUtil: TGUID = '{6A4C29EB-849E-4CE9-9211-D76284A46A72}';
  CLASS_clsUtil: TGUID = '{BAB006C4-1810-4A37-AC21-33F356EBC637}';
  IID__clsInteracReq: TGUID = '{B5A69424-54DC-4002-90C0-EB8F828A9190}';
  CLASS_clsInteracReq: TGUID = '{70C43242-2010-4041-BD81-105E4860532D}';
  IID__clsGlobalAPi: TGUID = '{ADD6CF64-2100-4AF2-A208-A7F5182C11BA}';
  DIID___clsGlobalAPi: TGUID = '{67549F2B-0B9D-4FF7-AC48-31D806811FA3}';
  CLASS_PinSC550: TGUID = '{5A954CEA-9C40-4CEC-8137-695B12082038}';
  CLASS_clsGlobalAPi: TGUID = '{218AA635-031B-4A8F-9116-F066484663C0}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum GPSTransCode
type
  GPSTransCode = TOleEnum;
const
  ENUM_TCODE_PURCH_NORM = $00000000;
  ENUM_TCODE_REFUND = $00000004;

// Constants for enum GPSAccType
type
  GPSAccType = TOleEnum;
const
  ENUM_ACC_CHEQ = $00000001;
  ENUM_ACC_SAV = $00000002;

// Constants for enum GPSTransID
type
  GPSTransID = TOleEnum;
const
  ENUM_TID_PURCH = $00000000;
  ENUM_TID_REFUND = $00000001;

// Constants for enum GPSKeyManagementType
type
  GPSKeyManagementType = TOleEnum;
const
  ENUM_MASTERSESSION = $00000000;
  ENUM_DUKPT = $00000001;
  ENUM_MAC = $00000002;

// Constants for enum GPSPinPadAction
type
  GPSPinPadAction = TOleEnum;
const
  ENUM_ACTION_PORT_STATE_CHANGE = $00000001;
  ENUM_ACTION_INIT_PINPAD = $00000002;
  ENUM_ACTION_MSR_START = $00000003;
  ENUM_ACTION_MSR_STOP = $00000004;
  ENUM_ACTION_REQ_SERIAL = $00000005;
  ENUM_ACTION_DEVICE_STATE_CHANGE = $00000006;
  ENUM_ACTION_MSR_RECEIVED_DATA = $00000007;
  ENUM_ACTION_MSG_DISP_GEN = $00000008;
  ENUM_ACTION_MSG_DISP_OBTAIN = $00000009;
  ENUM_ACTION_MSG_DISP_BANKRESP = $0000000A;
  ENUM_ACTION_MSG_DISP_PRINTERDOWN = $0000000B;
  ENUM_ACTION_PTR_RECEIVED_DATA = $0000000C;
  ENUM_ACTION_DEVICE_ACTION_CHANGE = $0000000D;
  ENUM_ACTION_REQ_MAC = $0000000E;
  ENUM_ACTION_REQ_INTERAC = $0000000F;
  ENUM_ACTION_INTERAC_RECEIVED_DATA = $00000010;
  ENUM_ACTION_ANALYSIS_INTERAC = $00000011;
  ENUM_ACTION_KEY_LOAD = $00000012;
  ENUM_ACTION_AUTOPROCESS_CHANGE = $00000013;

// Constants for enum GPSActionPending
type
  GPSActionPending = TOleEnum;
const
  ENUM_ACTION_PENDING_NONE = $FFFFFFE2;
  ENUM_ACTION_PENDING_MSR = $FFFFFFE3;
  ENUM_ACTION_PENDING_PRINTER = $FFFFFFE4;
  ENUM_ACTION_PENDING_INTERAC = $FFFFFFE5;

// Constants for enum GPSRespStatus
type
  GPSRespStatus = TOleEnum;
const
  ENUM_STATUS_AUTOPROCESS_ON = $FFFFFFDD;
  ENUM_STATUS_AUTOPROCESS_OFF = $FFFFFFDE;
  ENUM_STATUS_PENDING_NONE = $FFFFFFE2;
  ENUM_STATUS_PENDING_MSR = $FFFFFFE3;
  ENUM_STATUS_PENDING_PRINTER = $FFFFFFE4;
  ENUM_STATUS_PENDING_INTERAC = $FFFFFFE5;
  ENUM_STATUS_DEVICE_IDLE = $FFFFFFEC;
  ENUM_STATUS_DEVICE_PROCESS = $FFFFFFED;
  ENUM_STATUS_DEVICE_CANCEL = $FFFFFFEE;
  ENUM_STATUS_DEVICE_WAITING = $FFFFFFEF;
  ENUM_STATUS_DEVICE_INPUT_PENDING = $FFFFFFF0;
  ENUM_STATUS_PORT_OPEN = $FFFFFFF6;
  ENUM_STATUS_PORT_CLOSED = $FFFFFFF7;
  ENUM_STATUS_OK = $00000000;
  ENUM_STATUS_INVALID_ACTION = $00000001;
  ENUM_STATUS_DEVICE_INPROCESS = $00000002;
  ENUM_STATUS_DEVICE_TIMEOUT = $00000003;
  ENUM_STATUS_UNKNW_ERROR = $00000004;

// Constants for enum GPSLangCode
type
  GPSLangCode = TOleEnum;
const
  ENUM_LANG_ENG = $00000000;
  ENUM_LANG_FRC = $00000001;

// Constants for enum GPSPinPadState
type
  GPSPinPadState = TOleEnum;
const
  ENUM_STATE_IDLE = $FFFFFFEC;
  ENUM_STATE_PROCESS = $FFFFFFED;
  ENUM_STATE_CANCEL = $FFFFFFEE;
  ENUM_STATE_WAITING = $FFFFFFEF;
  ENUM_STATE_INPUT_PENDING = $FFFFFFF0;

// Constants for enum GPSRespCode
type
  GPSRespCode = TOleEnum;
const
  ENUM_RCODE_CLEAR = $FFFFFFFF;
  ENUM_RCODE_SUCCESSFUL = $00000000;
  ENUM_RCODE_UNSUCCESSFUL = $00000001;
  ENUM_RCODE_TIMEOUT = $00000002;
  ENUM_RCODE_CANCELED = $00000003;
  ENUM_RCODE_CORRKEY = $00000004;
  ENUM_RCODE_INVALID_ACCTLEN = $00000006;
  ENUM_RCODE_MAC_NOVERIFY = $00000007;
  ENUM_RCODE_MAC_NOBLOCK = $00000009;
  ENUM_RCODE_KEY_DECRYPT_ERROR = $0000000B;
  ENUM_RCODE_KEY_LOCATION_ERROR = $0000000D;
  ENUM_RCODE_KEY_MTK_NOSELECT = $0000000E;
  ENUM_RCODE_KEY_LOAD_FAIL_REVERT = $00000010;
  ENUM_RCODE_KEY_LOAD_FAIL_NOREVERT = $00000062;

// Constants for enum GPSOmcCode
type
  GPSOmcCode = TOleEnum;
const
  ENUM_OMC_ERR_SERIAL = $FFFFFFFF;
  ENUM_OMC_ERR_TIMEOUT = $FFFFFFFE;
  ENUM_OMC_ERR_FILE = $FFFFFFFD;
  ENUM_OMC_ERR_COMMAND = $FFFFFFFC;
  ENUM_OMC_ERR_DATA = $FFFFFFFB;
  ENUM_OMC_ERR_BASE64 = $FFFFFFFA;
  ENUM_OMC_ERR_BUSY = $FFFFFFF9;
  ENUM_OMC_ERR_DEVICE = $FFFFFFF8;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _PinSC550 = interface;
  _PinSC550Disp = dispinterface;
  __PinSC550 = dispinterface;
  _clsUtil = interface;
  _clsUtilDisp = dispinterface;
  _clsInteracReq = interface;
  _clsInteracReqDisp = dispinterface;
  _clsGlobalAPi = interface;
  _clsGlobalAPiDisp = dispinterface;
  __clsGlobalAPi = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  clsUtil = _clsUtil;
  clsInteracReq = _clsInteracReq;
  PinSC550 = _PinSC550;
  clsGlobalAPi = _clsGlobalAPi;


// *********************************************************************//
// Interface: _PinSC550
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1E874A2E-08CE-467F-8FC6-C8120735FF4A}
// *********************************************************************//
  _PinSC550 = interface(IDispatch)
    ['{1E874A2E-08CE-467F-8FC6-C8120735FF4A}']
    procedure GhostMethod__PinSC550_28_1; safecall;
    procedure GhostMethod__PinSC550_32_2; safecall;
    procedure GhostMethod__PinSC550_36_3; safecall;
    procedure GhostMethod__PinSC550_40_4; safecall;
    procedure GhostMethod__PinSC550_44_5; safecall;
    procedure GhostMethod__PinSC550_48_6; safecall;
    procedure GhostMethod__PinSC550_52_7; safecall;
    procedure GhostMethod__PinSC550_56_8; safecall;
    procedure GhostMethod__PinSC550_60_9; safecall;
    procedure GhostMethod__PinSC550_64_10; safecall;
    procedure GhostMethod__PinSC550_68_11; safecall;
    procedure GhostMethod__PinSC550_72_12; safecall;
    procedure GhostMethod__PinSC550_76_13; safecall;
    procedure GhostMethod__PinSC550_80_14; safecall;
    procedure GhostMethod__PinSC550_84_15; safecall;
    procedure GhostMethod__PinSC550_88_16; safecall;
    procedure GhostMethod__PinSC550_92_17; safecall;
    procedure GhostMethod__PinSC550_96_18; safecall;
    procedure GhostMethod__PinSC550_100_19; safecall;
    procedure GhostMethod__PinSC550_104_20; safecall;
    procedure GhostMethod__PinSC550_108_21; safecall;
    procedure GhostMethod__PinSC550_112_22; safecall;
    procedure GhostMethod__PinSC550_116_23; safecall;
    procedure GhostMethod__PinSC550_120_24; safecall;
    procedure GhostMethod__PinSC550_124_25; safecall;
    procedure GhostMethod__PinSC550_128_26; safecall;
    procedure GhostMethod__PinSC550_132_27; safecall;
    procedure GhostMethod__PinSC550_136_28; safecall;
    procedure GhostMethod__PinSC550_140_29; safecall;
    procedure GhostMethod__PinSC550_144_30; safecall;
    procedure GhostMethod__PinSC550_148_31; safecall;
    procedure GhostMethod__PinSC550_152_32; safecall;
    procedure GhostMethod__PinSC550_156_33; safecall;
    procedure GhostMethod__PinSC550_160_34; safecall;
    procedure GhostMethod__PinSC550_164_35; safecall;
    procedure GhostMethod__PinSC550_168_36; safecall;
    procedure GhostMethod__PinSC550_172_37; safecall;
    procedure GhostMethod__PinSC550_176_38; safecall;
    procedure GhostMethod__PinSC550_180_39; safecall;
    procedure GhostMethod__PinSC550_184_40; safecall;
    procedure GhostMethod__PinSC550_188_41; safecall;
    procedure GhostMethod__PinSC550_192_42; safecall;
    procedure GhostMethod__PinSC550_196_43; safecall;
    procedure GhostMethod__PinSC550_200_44; safecall;
    procedure GhostMethod__PinSC550_204_45; safecall;
    procedure GhostMethod__PinSC550_208_46; safecall;
    procedure GhostMethod__PinSC550_212_47; safecall;
    procedure GhostMethod__PinSC550_216_48; safecall;
    procedure GhostMethod__PinSC550_220_49; safecall;
    procedure GhostMethod__PinSC550_224_50; safecall;
    procedure GhostMethod__PinSC550_228_51; safecall;
    procedure GhostMethod__PinSC550_232_52; safecall;
    procedure GhostMethod__PinSC550_236_53; safecall;
    procedure GhostMethod__PinSC550_240_54; safecall;
    procedure GhostMethod__PinSC550_244_55; safecall;
    procedure GhostMethod__PinSC550_248_56; safecall;
    procedure GhostMethod__PinSC550_252_57; safecall;
    procedure GhostMethod__PinSC550_256_58; safecall;
    procedure GhostMethod__PinSC550_260_59; safecall;
    procedure GhostMethod__PinSC550_264_60; safecall;
    procedure GhostMethod__PinSC550_268_61; safecall;
    procedure GhostMethod__PinSC550_272_62; safecall;
    procedure GhostMethod__PinSC550_276_63; safecall;
    procedure GhostMethod__PinSC550_280_64; safecall;
    procedure GhostMethod__PinSC550_284_65; safecall;
    procedure GhostMethod__PinSC550_288_66; safecall;
    procedure GhostMethod__PinSC550_292_67; safecall;
    procedure GhostMethod__PinSC550_296_68; safecall;
    procedure GhostMethod__PinSC550_300_69; safecall;
    procedure GhostMethod__PinSC550_304_70; safecall;
    procedure GhostMethod__PinSC550_308_71; safecall;
    procedure GhostMethod__PinSC550_312_72; safecall;
    procedure GhostMethod__PinSC550_316_73; safecall;
    procedure GhostMethod__PinSC550_320_74; safecall;
    procedure GhostMethod__PinSC550_324_75; safecall;
    procedure GhostMethod__PinSC550_328_76; safecall;
    procedure GhostMethod__PinSC550_332_77; safecall;
    procedure GhostMethod__PinSC550_336_78; safecall;
    procedure GhostMethod__PinSC550_340_79; safecall;
    procedure GhostMethod__PinSC550_344_80; safecall;
    procedure GhostMethod__PinSC550_348_81; safecall;
    procedure GhostMethod__PinSC550_352_82; safecall;
    procedure GhostMethod__PinSC550_356_83; safecall;
    procedure GhostMethod__PinSC550_360_84; safecall;
    procedure GhostMethod__PinSC550_364_85; safecall;
    procedure GhostMethod__PinSC550_368_86; safecall;
    procedure GhostMethod__PinSC550_372_87; safecall;
    procedure GhostMethod__PinSC550_376_88; safecall;
    procedure GhostMethod__PinSC550_380_89; safecall;
    procedure GhostMethod__PinSC550_384_90; safecall;
    procedure GhostMethod__PinSC550_388_91; safecall;
    procedure GhostMethod__PinSC550_392_92; safecall;
    procedure GhostMethod__PinSC550_396_93; safecall;
    procedure GhostMethod__PinSC550_400_94; safecall;
    procedure GhostMethod__PinSC550_404_95; safecall;
    procedure GhostMethod__PinSC550_408_96; safecall;
    procedure GhostMethod__PinSC550_412_97; safecall;
    procedure GhostMethod__PinSC550_416_98; safecall;
    procedure GhostMethod__PinSC550_420_99; safecall;
    procedure GhostMethod__PinSC550_424_100; safecall;
    procedure GhostMethod__PinSC550_428_101; safecall;
    procedure GhostMethod__PinSC550_432_102; safecall;
    procedure GhostMethod__PinSC550_436_103; safecall;
    procedure GhostMethod__PinSC550_440_104; safecall;
    procedure GhostMethod__PinSC550_444_105; safecall;
    procedure GhostMethod__PinSC550_448_106; safecall;
    procedure GhostMethod__PinSC550_452_107; safecall;
    procedure GhostMethod__PinSC550_456_108; safecall;
    procedure GhostMethod__PinSC550_460_109; safecall;
    procedure GhostMethod__PinSC550_464_110; safecall;
    procedure GhostMethod__PinSC550_468_111; safecall;
    procedure GhostMethod__PinSC550_472_112; safecall;
    procedure GhostMethod__PinSC550_476_113; safecall;
    procedure GhostMethod__PinSC550_480_114; safecall;
    procedure GhostMethod__PinSC550_484_115; safecall;
    procedure GhostMethod__PinSC550_488_116; safecall;
    procedure GhostMethod__PinSC550_492_117; safecall;
    procedure GhostMethod__PinSC550_496_118; safecall;
    procedure GhostMethod__PinSC550_500_119; safecall;
    procedure GhostMethod__PinSC550_504_120; safecall;
    procedure GhostMethod__PinSC550_508_121; safecall;
    procedure GhostMethod__PinSC550_512_122; safecall;
    procedure GhostMethod__PinSC550_516_123; safecall;
    procedure GhostMethod__PinSC550_520_124; safecall;
    procedure GhostMethod__PinSC550_524_125; safecall;
    procedure GhostMethod__PinSC550_528_126; safecall;
    procedure GhostMethod__PinSC550_532_127; safecall;
    procedure GhostMethod__PinSC550_536_128; safecall;
    procedure GhostMethod__PinSC550_540_129; safecall;
    procedure GhostMethod__PinSC550_544_130; safecall;
    procedure GhostMethod__PinSC550_548_131; safecall;
    procedure GhostMethod__PinSC550_552_132; safecall;
    procedure GhostMethod__PinSC550_556_133; safecall;
    procedure GhostMethod__PinSC550_560_134; safecall;
    procedure GhostMethod__PinSC550_564_135; safecall;
    procedure GhostMethod__PinSC550_568_136; safecall;
    procedure GhostMethod__PinSC550_572_137; safecall;
    procedure GhostMethod__PinSC550_576_138; safecall;
    procedure GhostMethod__PinSC550_580_139; safecall;
    procedure GhostMethod__PinSC550_584_140; safecall;
    procedure GhostMethod__PinSC550_588_141; safecall;
    procedure GhostMethod__PinSC550_592_142; safecall;
    procedure GhostMethod__PinSC550_596_143; safecall;
    procedure GhostMethod__PinSC550_600_144; safecall;
    procedure GhostMethod__PinSC550_604_145; safecall;
    procedure GhostMethod__PinSC550_608_146; safecall;
    procedure GhostMethod__PinSC550_612_147; safecall;
    procedure GhostMethod__PinSC550_616_148; safecall;
    procedure GhostMethod__PinSC550_620_149; safecall;
    procedure GhostMethod__PinSC550_624_150; safecall;
    procedure GhostMethod__PinSC550_628_151; safecall;
    procedure GhostMethod__PinSC550_632_152; safecall;
    procedure GhostMethod__PinSC550_636_153; safecall;
    procedure GhostMethod__PinSC550_640_154; safecall;
    procedure GhostMethod__PinSC550_644_155; safecall;
    procedure GhostMethod__PinSC550_648_156; safecall;
    procedure GhostMethod__PinSC550_652_157; safecall;
    procedure GhostMethod__PinSC550_656_158; safecall;
    procedure GhostMethod__PinSC550_660_159; safecall;
    procedure GhostMethod__PinSC550_664_160; safecall;
    procedure GhostMethod__PinSC550_668_161; safecall;
    procedure GhostMethod__PinSC550_672_162; safecall;
    procedure GhostMethod__PinSC550_676_163; safecall;
    procedure GhostMethod__PinSC550_680_164; safecall;
    procedure GhostMethod__PinSC550_684_165; safecall;
    procedure GhostMethod__PinSC550_688_166; safecall;
    procedure GhostMethod__PinSC550_692_167; safecall;
    procedure GhostMethod__PinSC550_696_168; safecall;
    procedure GhostMethod__PinSC550_700_169; safecall;
    procedure GhostMethod__PinSC550_704_170; safecall;
    procedure GhostMethod__PinSC550_708_171; safecall;
    procedure GhostMethod__PinSC550_712_172; safecall;
    procedure GhostMethod__PinSC550_716_173; safecall;
    procedure GhostMethod__PinSC550_720_174; safecall;
    procedure GhostMethod__PinSC550_724_175; safecall;
    procedure GhostMethod__PinSC550_728_176; safecall;
    procedure GhostMethod__PinSC550_732_177; safecall;
    procedure GhostMethod__PinSC550_736_178; safecall;
    procedure GhostMethod__PinSC550_740_179; safecall;
    procedure GhostMethod__PinSC550_744_180; safecall;
    procedure GhostMethod__PinSC550_748_181; safecall;
    procedure GhostMethod__PinSC550_752_182; safecall;
    procedure GhostMethod__PinSC550_756_183; safecall;
    procedure GhostMethod__PinSC550_760_184; safecall;
    procedure GhostMethod__PinSC550_764_185; safecall;
    procedure GhostMethod__PinSC550_768_186; safecall;
    procedure GhostMethod__PinSC550_772_187; safecall;
    procedure GhostMethod__PinSC550_776_188; safecall;
    procedure GhostMethod__PinSC550_780_189; safecall;
    procedure GhostMethod__PinSC550_784_190; safecall;
    procedure GhostMethod__PinSC550_788_191; safecall;
    procedure GhostMethod__PinSC550_792_192; safecall;
    procedure GhostMethod__PinSC550_796_193; safecall;
    procedure GhostMethod__PinSC550_800_194; safecall;
    procedure GhostMethod__PinSC550_804_195; safecall;
    procedure GhostMethod__PinSC550_808_196; safecall;
    procedure GhostMethod__PinSC550_812_197; safecall;
    procedure GhostMethod__PinSC550_816_198; safecall;
    procedure GhostMethod__PinSC550_820_199; safecall;
    procedure GhostMethod__PinSC550_824_200; safecall;
    procedure GhostMethod__PinSC550_828_201; safecall;
    procedure GhostMethod__PinSC550_832_202; safecall;
    procedure GhostMethod__PinSC550_836_203; safecall;
    procedure GhostMethod__PinSC550_840_204; safecall;
    procedure GhostMethod__PinSC550_844_205; safecall;
    procedure GhostMethod__PinSC550_848_206; safecall;
    procedure GhostMethod__PinSC550_852_207; safecall;
    procedure GhostMethod__PinSC550_856_208; safecall;
    procedure GhostMethod__PinSC550_860_209; safecall;
    procedure GhostMethod__PinSC550_864_210; safecall;
    procedure GhostMethod__PinSC550_868_211; safecall;
    procedure GhostMethod__PinSC550_872_212; safecall;
    procedure GhostMethod__PinSC550_876_213; safecall;
    procedure GhostMethod__PinSC550_880_214; safecall;
    procedure GhostMethod__PinSC550_884_215; safecall;
    procedure GhostMethod__PinSC550_888_216; safecall;
    procedure GhostMethod__PinSC550_892_217; safecall;
    procedure GhostMethod__PinSC550_896_218; safecall;
    procedure GhostMethod__PinSC550_900_219; safecall;
    procedure GhostMethod__PinSC550_904_220; safecall;
    procedure GhostMethod__PinSC550_908_221; safecall;
    procedure GhostMethod__PinSC550_912_222; safecall;
    procedure GhostMethod__PinSC550_916_223; safecall;
    procedure GhostMethod__PinSC550_920_224; safecall;
    procedure GhostMethod__PinSC550_924_225; safecall;
    procedure GhostMethod__PinSC550_928_226; safecall;
    procedure GhostMethod__PinSC550_932_227; safecall;
    procedure GhostMethod__PinSC550_936_228; safecall;
    procedure GhostMethod__PinSC550_940_229; safecall;
    procedure GhostMethod__PinSC550_944_230; safecall;
    procedure GhostMethod__PinSC550_948_231; safecall;
    procedure GhostMethod__PinSC550_952_232; safecall;
    procedure GhostMethod__PinSC550_956_233; safecall;
    procedure GhostMethod__PinSC550_960_234; safecall;
    procedure GhostMethod__PinSC550_964_235; safecall;
    procedure GhostMethod__PinSC550_968_236; safecall;
    procedure GhostMethod__PinSC550_972_237; safecall;
    procedure GhostMethod__PinSC550_976_238; safecall;
    procedure GhostMethod__PinSC550_980_239; safecall;
    procedure GhostMethod__PinSC550_984_240; safecall;
    procedure GhostMethod__PinSC550_988_241; safecall;
    procedure GhostMethod__PinSC550_992_242; safecall;
    procedure GhostMethod__PinSC550_996_243; safecall;
    procedure GhostMethod__PinSC550_1000_244; safecall;
    procedure GhostMethod__PinSC550_1004_245; safecall;
    procedure GhostMethod__PinSC550_1008_246; safecall;
    procedure GhostMethod__PinSC550_1012_247; safecall;
    procedure GhostMethod__PinSC550_1016_248; safecall;
    procedure GhostMethod__PinSC550_1020_249; safecall;
    procedure GhostMethod__PinSC550_1024_250; safecall;
    procedure GhostMethod__PinSC550_1028_251; safecall;
    procedure GhostMethod__PinSC550_1032_252; safecall;
    procedure GhostMethod__PinSC550_1036_253; safecall;
    procedure GhostMethod__PinSC550_1040_254; safecall;
    procedure GhostMethod__PinSC550_1044_255; safecall;
    procedure GhostMethod__PinSC550_1048_256; safecall;
    procedure GhostMethod__PinSC550_1052_257; safecall;
    procedure GhostMethod__PinSC550_1056_258; safecall;
    procedure GhostMethod__PinSC550_1060_259; safecall;
    procedure GhostMethod__PinSC550_1064_260; safecall;
    procedure GhostMethod__PinSC550_1068_261; safecall;
    procedure GhostMethod__PinSC550_1072_262; safecall;
    procedure GhostMethod__PinSC550_1076_263; safecall;
    procedure GhostMethod__PinSC550_1080_264; safecall;
    procedure GhostMethod__PinSC550_1084_265; safecall;
    procedure GhostMethod__PinSC550_1088_266; safecall;
    procedure GhostMethod__PinSC550_1092_267; safecall;
    procedure GhostMethod__PinSC550_1096_268; safecall;
    procedure GhostMethod__PinSC550_1100_269; safecall;
    procedure GhostMethod__PinSC550_1104_270; safecall;
    procedure GhostMethod__PinSC550_1108_271; safecall;
    procedure GhostMethod__PinSC550_1112_272; safecall;
    procedure GhostMethod__PinSC550_1116_273; safecall;
    procedure GhostMethod__PinSC550_1120_274; safecall;
    procedure GhostMethod__PinSC550_1124_275; safecall;
    procedure GhostMethod__PinSC550_1128_276; safecall;
    procedure GhostMethod__PinSC550_1132_277; safecall;
    procedure GhostMethod__PinSC550_1136_278; safecall;
    procedure GhostMethod__PinSC550_1140_279; safecall;
    procedure GhostMethod__PinSC550_1144_280; safecall;
    procedure GhostMethod__PinSC550_1148_281; safecall;
    procedure GhostMethod__PinSC550_1152_282; safecall;
    procedure GhostMethod__PinSC550_1156_283; safecall;
    procedure GhostMethod__PinSC550_1160_284; safecall;
    procedure GhostMethod__PinSC550_1164_285; safecall;
    procedure GhostMethod__PinSC550_1168_286; safecall;
    procedure GhostMethod__PinSC550_1172_287; safecall;
    procedure GhostMethod__PinSC550_1176_288; safecall;
    procedure GhostMethod__PinSC550_1180_289; safecall;
    procedure GhostMethod__PinSC550_1184_290; safecall;
    procedure GhostMethod__PinSC550_1188_291; safecall;
    procedure GhostMethod__PinSC550_1192_292; safecall;
    procedure GhostMethod__PinSC550_1196_293; safecall;
    procedure GhostMethod__PinSC550_1200_294; safecall;
    procedure GhostMethod__PinSC550_1204_295; safecall;
    procedure GhostMethod__PinSC550_1208_296; safecall;
    procedure GhostMethod__PinSC550_1212_297; safecall;
    procedure GhostMethod__PinSC550_1216_298; safecall;
    procedure GhostMethod__PinSC550_1220_299; safecall;
    procedure GhostMethod__PinSC550_1224_300; safecall;
    procedure GhostMethod__PinSC550_1228_301; safecall;
    procedure GhostMethod__PinSC550_1232_302; safecall;
    procedure GhostMethod__PinSC550_1236_303; safecall;
    procedure GhostMethod__PinSC550_1240_304; safecall;
    procedure GhostMethod__PinSC550_1244_305; safecall;
    procedure GhostMethod__PinSC550_1248_306; safecall;
    procedure GhostMethod__PinSC550_1252_307; safecall;
    procedure GhostMethod__PinSC550_1256_308; safecall;
    procedure GhostMethod__PinSC550_1260_309; safecall;
    procedure GhostMethod__PinSC550_1264_310; safecall;
    procedure GhostMethod__PinSC550_1268_311; safecall;
    procedure GhostMethod__PinSC550_1272_312; safecall;
    procedure GhostMethod__PinSC550_1276_313; safecall;
    procedure GhostMethod__PinSC550_1280_314; safecall;
    procedure GhostMethod__PinSC550_1284_315; safecall;
    procedure GhostMethod__PinSC550_1288_316; safecall;
    procedure GhostMethod__PinSC550_1292_317; safecall;
    procedure GhostMethod__PinSC550_1296_318; safecall;
    procedure GhostMethod__PinSC550_1300_319; safecall;
    procedure GhostMethod__PinSC550_1304_320; safecall;
    procedure GhostMethod__PinSC550_1308_321; safecall;
    procedure GhostMethod__PinSC550_1312_322; safecall;
    procedure GhostMethod__PinSC550_1316_323; safecall;
    procedure GhostMethod__PinSC550_1320_324; safecall;
    procedure GhostMethod__PinSC550_1324_325; safecall;
    procedure GhostMethod__PinSC550_1328_326; safecall;
    procedure GhostMethod__PinSC550_1332_327; safecall;
    procedure GhostMethod__PinSC550_1336_328; safecall;
    procedure GhostMethod__PinSC550_1340_329; safecall;
    procedure GhostMethod__PinSC550_1344_330; safecall;
    procedure GhostMethod__PinSC550_1348_331; safecall;
    procedure GhostMethod__PinSC550_1352_332; safecall;
    procedure GhostMethod__PinSC550_1356_333; safecall;
    procedure GhostMethod__PinSC550_1360_334; safecall;
    procedure GhostMethod__PinSC550_1364_335; safecall;
    procedure GhostMethod__PinSC550_1368_336; safecall;
    procedure GhostMethod__PinSC550_1372_337; safecall;
    procedure GhostMethod__PinSC550_1376_338; safecall;
    procedure GhostMethod__PinSC550_1380_339; safecall;
    procedure GhostMethod__PinSC550_1384_340; safecall;
    procedure GhostMethod__PinSC550_1388_341; safecall;
    procedure GhostMethod__PinSC550_1392_342; safecall;
    procedure GhostMethod__PinSC550_1396_343; safecall;
    procedure GhostMethod__PinSC550_1400_344; safecall;
    procedure GhostMethod__PinSC550_1404_345; safecall;
    procedure GhostMethod__PinSC550_1408_346; safecall;
    procedure GhostMethod__PinSC550_1412_347; safecall;
    procedure GhostMethod__PinSC550_1416_348; safecall;
    procedure GhostMethod__PinSC550_1420_349; safecall;
    procedure GhostMethod__PinSC550_1424_350; safecall;
    procedure GhostMethod__PinSC550_1428_351; safecall;
    procedure GhostMethod__PinSC550_1432_352; safecall;
    procedure GhostMethod__PinSC550_1436_353; safecall;
    procedure GhostMethod__PinSC550_1440_354; safecall;
    procedure GhostMethod__PinSC550_1444_355; safecall;
    procedure GhostMethod__PinSC550_1448_356; safecall;
    procedure GhostMethod__PinSC550_1452_357; safecall;
    procedure GhostMethod__PinSC550_1456_358; safecall;
    procedure GhostMethod__PinSC550_1460_359; safecall;
    procedure GhostMethod__PinSC550_1464_360; safecall;
    procedure GhostMethod__PinSC550_1468_361; safecall;
    procedure GhostMethod__PinSC550_1472_362; safecall;
    procedure GhostMethod__PinSC550_1476_363; safecall;
    procedure GhostMethod__PinSC550_1480_364; safecall;
    procedure GhostMethod__PinSC550_1484_365; safecall;
    procedure GhostMethod__PinSC550_1488_366; safecall;
    procedure GhostMethod__PinSC550_1492_367; safecall;
    procedure GhostMethod__PinSC550_1496_368; safecall;
    procedure GhostMethod__PinSC550_1500_369; safecall;
    procedure GhostMethod__PinSC550_1504_370; safecall;
    procedure GhostMethod__PinSC550_1508_371; safecall;
    procedure GhostMethod__PinSC550_1512_372; safecall;
    procedure GhostMethod__PinSC550_1516_373; safecall;
    procedure GhostMethod__PinSC550_1520_374; safecall;
    procedure GhostMethod__PinSC550_1524_375; safecall;
    procedure GhostMethod__PinSC550_1528_376; safecall;
    procedure GhostMethod__PinSC550_1532_377; safecall;
    procedure GhostMethod__PinSC550_1536_378; safecall;
    procedure GhostMethod__PinSC550_1540_379; safecall;
    procedure GhostMethod__PinSC550_1544_380; safecall;
    procedure GhostMethod__PinSC550_1548_381; safecall;
    procedure GhostMethod__PinSC550_1552_382; safecall;
    procedure GhostMethod__PinSC550_1556_383; safecall;
    procedure GhostMethod__PinSC550_1560_384; safecall;
    procedure GhostMethod__PinSC550_1564_385; safecall;
    procedure GhostMethod__PinSC550_1568_386; safecall;
    procedure GhostMethod__PinSC550_1572_387; safecall;
    procedure GhostMethod__PinSC550_1576_388; safecall;
    procedure GhostMethod__PinSC550_1580_389; safecall;
    procedure GhostMethod__PinSC550_1584_390; safecall;
    procedure GhostMethod__PinSC550_1588_391; safecall;
    procedure GhostMethod__PinSC550_1592_392; safecall;
    procedure GhostMethod__PinSC550_1596_393; safecall;
    procedure GhostMethod__PinSC550_1600_394; safecall;
    procedure GhostMethod__PinSC550_1604_395; safecall;
    procedure GhostMethod__PinSC550_1608_396; safecall;
    procedure GhostMethod__PinSC550_1612_397; safecall;
    procedure GhostMethod__PinSC550_1616_398; safecall;
    procedure GhostMethod__PinSC550_1620_399; safecall;
    procedure GhostMethod__PinSC550_1624_400; safecall;
    procedure GhostMethod__PinSC550_1628_401; safecall;
    procedure GhostMethod__PinSC550_1632_402; safecall;
    procedure GhostMethod__PinSC550_1636_403; safecall;
    procedure GhostMethod__PinSC550_1640_404; safecall;
    procedure GhostMethod__PinSC550_1644_405; safecall;
    procedure GhostMethod__PinSC550_1648_406; safecall;
    procedure GhostMethod__PinSC550_1652_407; safecall;
    procedure GhostMethod__PinSC550_1656_408; safecall;
    procedure GhostMethod__PinSC550_1660_409; safecall;
    procedure GhostMethod__PinSC550_1664_410; safecall;
    procedure GhostMethod__PinSC550_1668_411; safecall;
    procedure GhostMethod__PinSC550_1672_412; safecall;
    procedure GhostMethod__PinSC550_1676_413; safecall;
    procedure GhostMethod__PinSC550_1680_414; safecall;
    procedure GhostMethod__PinSC550_1684_415; safecall;
    procedure GhostMethod__PinSC550_1688_416; safecall;
    procedure GhostMethod__PinSC550_1692_417; safecall;
    procedure GhostMethod__PinSC550_1696_418; safecall;
    procedure GhostMethod__PinSC550_1700_419; safecall;
    procedure GhostMethod__PinSC550_1704_420; safecall;
    procedure GhostMethod__PinSC550_1708_421; safecall;
    procedure GhostMethod__PinSC550_1712_422; safecall;
    procedure GhostMethod__PinSC550_1716_423; safecall;
    procedure GhostMethod__PinSC550_1720_424; safecall;
    procedure GhostMethod__PinSC550_1724_425; safecall;
    procedure GhostMethod__PinSC550_1728_426; safecall;
    procedure GhostMethod__PinSC550_1732_427; safecall;
    procedure GhostMethod__PinSC550_1736_428; safecall;
    procedure GhostMethod__PinSC550_1740_429; safecall;
    procedure GhostMethod__PinSC550_1744_430; safecall;
    procedure GhostMethod__PinSC550_1748_431; safecall;
    procedure GhostMethod__PinSC550_1752_432; safecall;
    procedure GhostMethod__PinSC550_1756_433; safecall;
    procedure GhostMethod__PinSC550_1760_434; safecall;
    procedure GhostMethod__PinSC550_1764_435; safecall;
    procedure GhostMethod__PinSC550_1768_436; safecall;
    procedure GhostMethod__PinSC550_1772_437; safecall;
    procedure GhostMethod__PinSC550_1776_438; safecall;
    procedure GhostMethod__PinSC550_1780_439; safecall;
    procedure GhostMethod__PinSC550_1784_440; safecall;
    procedure GhostMethod__PinSC550_1788_441; safecall;
    procedure GhostMethod__PinSC550_1792_442; safecall;
    procedure GhostMethod__PinSC550_1796_443; safecall;
    procedure GhostMethod__PinSC550_1800_444; safecall;
    procedure GhostMethod__PinSC550_1804_445; safecall;
    procedure GhostMethod__PinSC550_1808_446; safecall;
    procedure GhostMethod__PinSC550_1812_447; safecall;
    procedure GhostMethod__PinSC550_1816_448; safecall;
    procedure GhostMethod__PinSC550_1820_449; safecall;
    procedure GhostMethod__PinSC550_1824_450; safecall;
    procedure GhostMethod__PinSC550_1828_451; safecall;
    procedure GhostMethod__PinSC550_1832_452; safecall;
    procedure GhostMethod__PinSC550_1836_453; safecall;
    procedure GhostMethod__PinSC550_1840_454; safecall;
    procedure GhostMethod__PinSC550_1844_455; safecall;
    procedure GhostMethod__PinSC550_1848_456; safecall;
    procedure GhostMethod__PinSC550_1852_457; safecall;
    procedure GhostMethod__PinSC550_1856_458; safecall;
    procedure GhostMethod__PinSC550_1860_459; safecall;
    procedure GhostMethod__PinSC550_1864_460; safecall;
    procedure GhostMethod__PinSC550_1868_461; safecall;
    procedure GhostMethod__PinSC550_1872_462; safecall;
    procedure GhostMethod__PinSC550_1876_463; safecall;
    procedure GhostMethod__PinSC550_1880_464; safecall;
    procedure GhostMethod__PinSC550_1884_465; safecall;
    procedure GhostMethod__PinSC550_1888_466; safecall;
    procedure GhostMethod__PinSC550_1892_467; safecall;
    procedure GhostMethod__PinSC550_1896_468; safecall;
    procedure GhostMethod__PinSC550_1900_469; safecall;
    procedure GhostMethod__PinSC550_1904_470; safecall;
    procedure GhostMethod__PinSC550_1908_471; safecall;
    procedure GhostMethod__PinSC550_1912_472; safecall;
    procedure GhostMethod__PinSC550_1916_473; safecall;
    procedure GhostMethod__PinSC550_1920_474; safecall;
    procedure GhostMethod__PinSC550_1924_475; safecall;
    procedure GhostMethod__PinSC550_1928_476; safecall;
    procedure GhostMethod__PinSC550_1932_477; safecall;
    procedure GhostMethod__PinSC550_1936_478; safecall;
    procedure GhostMethod__PinSC550_1940_479; safecall;
    procedure GhostMethod__PinSC550_1944_480; safecall;
    procedure GhostMethod__PinSC550_1948_481; safecall;
    procedure GhostMethod__PinSC550_1952_482; safecall;
    function Get_KeyType: GPSKeyManagementType; safecall;
    function Get_PortState: GPSRespStatus; safecall;
    procedure Set_CommVisible(var Param1: WordBool); safecall;
    function Get_CommVisible: WordBool; safecall;
    procedure Set_TimeOut(var Param1: WideString); safecall;
    function Get_TimeOut: WideString; safecall;
    procedure Set_Baud(var Param1: WideString); safecall;
    function Get_Baud: WideString; safecall;
    procedure Set_Parity(var Param1: WideString); safecall;
    function Get_Parity: WideString; safecall;
    procedure Set_Port(var Param1: WideString); safecall;
    function Get_Port: WideString; safecall;
    procedure Set_DataBits(var Param1: WideString); safecall;
    function Get_DataBits: WideString; safecall;
    function Get_DeviceData: WideString; safecall;
    procedure Set_ServerPath(var Param1: WideString); safecall;
    function Get_ServerPath: WideString; safecall;
    function Get_AutoProcess: WordBool; safecall;
    procedure Set_AutoProcess(var Param1: WordBool); safecall;
    function Get_AutoInterval: WideString; safecall;
    procedure Set_AutoInterval(var Param1: WideString); safecall;
    procedure Set_DefaultLanguageCode(var Param1: WideString); safecall;
    function Get_DefaultLanguageCode: WideString; safecall;
    function Get_DeviceState: GPSRespStatus; safecall;
    function Get_ActionPending: GPSActionPending; safecall;
    function Get_ResponseCodeAsString(var eCode: GPSRespCode): WideString; safecall;
    function Get_ResponseAsString(var eCode: GPSRespStatus): WideString; safecall;
    procedure OpenPort; safecall;
    procedure ClosePort; safecall;
    procedure Initialize; safecall;
    procedure GetSerialBlock; safecall;
    procedure StartMSR; safecall;
    procedure Cancel; safecall;
    procedure DispGenMsg(var szIDUpper: WideString; var szIDLower: WideString; 
                         var eLangCode: GPSLangCode); safecall;
    procedure DispObtainCard(var eLangCode: GPSLangCode); safecall;
    procedure RequestMAC(var szData: WideString); safecall;
    procedure InteracAnalysis(var szData: WideString; var eLangCode: GPSLangCode); safecall;
    procedure LoadKey(var szData: WideString); safecall;
    procedure RequestInterac(var szData: WideString; var eLangCode: GPSLangCode); safecall;
    procedure DispPrinterDown(var eLangCode: GPSLangCode); safecall;
    procedure DispBankResponse(var szBankCode: WideString; var szISOCode: WideString; 
                               var eLangCode: GPSLangCode); safecall;
    function Get_LanguageCode: GPSLangCode; safecall;
    function Get_RespCode: GPSRespCode; safecall;
    function Get_BatchCode: WideString; safecall;
    function Get_TrackII: WideString; safecall;
    function Get_MacBlock: WideString; safecall;
    function Get_Account: WideString; safecall;
    function Get_PinBlock: WideString; safecall;
    function Get_VFIBlock: WideString; safecall;
    function Get_AppName: WideString; safecall;
    function Get_KernelID: WideString; safecall;
    function Get_ChipStatus: WideString; safecall;
    function Get_PinPadType: WideString; safecall;
    function Get_ROMVersion: WideString; safecall;
    function Get_ProdData: WideString; safecall;
    function Get_FacilityCode: WideString; safecall;
    function Get_ChipSN: WideString; safecall;
    function Get_FirmVersion: WideString; safecall;
    function Get_RequireReMac: WordBool; safecall;
    function Get_ReMacData: WideString; safecall;
    function Base64Encode(var szData: WideString): WideString; safecall;
    function Base64Decode(var szData: WideString): WideString; safecall;
    property KeyType: GPSKeyManagementType read Get_KeyType;
    property PortState: GPSRespStatus read Get_PortState;
    property CommVisible: WordBool read Get_CommVisible write Set_CommVisible;
    property TimeOut: WideString read Get_TimeOut write Set_TimeOut;
    property Baud: WideString read Get_Baud write Set_Baud;
    property Parity: WideString read Get_Parity write Set_Parity;
    property Port: WideString read Get_Port write Set_Port;
    property DataBits: WideString read Get_DataBits write Set_DataBits;
    property DeviceData: WideString read Get_DeviceData;
    property ServerPath: WideString read Get_ServerPath write Set_ServerPath;
    property AutoProcess: WordBool read Get_AutoProcess write Set_AutoProcess;
    property AutoInterval: WideString read Get_AutoInterval write Set_AutoInterval;
    property DefaultLanguageCode: WideString read Get_DefaultLanguageCode write Set_DefaultLanguageCode;
    property DeviceState: GPSRespStatus read Get_DeviceState;
    property ActionPending: GPSActionPending read Get_ActionPending;
    property ResponseCodeAsString[var eCode: GPSRespCode]: WideString read Get_ResponseCodeAsString;
    property ResponseAsString[var eCode: GPSRespStatus]: WideString read Get_ResponseAsString;
    property LanguageCode: GPSLangCode read Get_LanguageCode;
    property RespCode: GPSRespCode read Get_RespCode;
    property BatchCode: WideString read Get_BatchCode;
    property TrackII: WideString read Get_TrackII;
    property MacBlock: WideString read Get_MacBlock;
    property Account: WideString read Get_Account;
    property PinBlock: WideString read Get_PinBlock;
    property VFIBlock: WideString read Get_VFIBlock;
    property AppName: WideString read Get_AppName;
    property KernelID: WideString read Get_KernelID;
    property ChipStatus: WideString read Get_ChipStatus;
    property PinPadType: WideString read Get_PinPadType;
    property ROMVersion: WideString read Get_ROMVersion;
    property ProdData: WideString read Get_ProdData;
    property FacilityCode: WideString read Get_FacilityCode;
    property ChipSN: WideString read Get_ChipSN;
    property FirmVersion: WideString read Get_FirmVersion;
    property RequireReMac: WordBool read Get_RequireReMac;
    property ReMacData: WideString read Get_ReMacData;
  end;

// *********************************************************************//
// DispIntf:  _PinSC550Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1E874A2E-08CE-467F-8FC6-C8120735FF4A}
// *********************************************************************//
  _PinSC550Disp = dispinterface
    ['{1E874A2E-08CE-467F-8FC6-C8120735FF4A}']
    procedure GhostMethod__PinSC550_28_1; dispid 1610743808;
    procedure GhostMethod__PinSC550_32_2; dispid 1610743809;
    procedure GhostMethod__PinSC550_36_3; dispid 1610743810;
    procedure GhostMethod__PinSC550_40_4; dispid 1610743811;
    procedure GhostMethod__PinSC550_44_5; dispid 1610743812;
    procedure GhostMethod__PinSC550_48_6; dispid 1610743813;
    procedure GhostMethod__PinSC550_52_7; dispid 1610743814;
    procedure GhostMethod__PinSC550_56_8; dispid 1610743815;
    procedure GhostMethod__PinSC550_60_9; dispid 1610743816;
    procedure GhostMethod__PinSC550_64_10; dispid 1610743817;
    procedure GhostMethod__PinSC550_68_11; dispid 1610743818;
    procedure GhostMethod__PinSC550_72_12; dispid 1610743819;
    procedure GhostMethod__PinSC550_76_13; dispid 1610743820;
    procedure GhostMethod__PinSC550_80_14; dispid 1610743821;
    procedure GhostMethod__PinSC550_84_15; dispid 1610743822;
    procedure GhostMethod__PinSC550_88_16; dispid 1610743823;
    procedure GhostMethod__PinSC550_92_17; dispid 1610743824;
    procedure GhostMethod__PinSC550_96_18; dispid 1610743825;
    procedure GhostMethod__PinSC550_100_19; dispid 1610743826;
    procedure GhostMethod__PinSC550_104_20; dispid 1610743827;
    procedure GhostMethod__PinSC550_108_21; dispid 1610743828;
    procedure GhostMethod__PinSC550_112_22; dispid 1610743829;
    procedure GhostMethod__PinSC550_116_23; dispid 1610743830;
    procedure GhostMethod__PinSC550_120_24; dispid 1610743831;
    procedure GhostMethod__PinSC550_124_25; dispid 1610743832;
    procedure GhostMethod__PinSC550_128_26; dispid 1610743833;
    procedure GhostMethod__PinSC550_132_27; dispid 1610743834;
    procedure GhostMethod__PinSC550_136_28; dispid 1610743835;
    procedure GhostMethod__PinSC550_140_29; dispid 1610743836;
    procedure GhostMethod__PinSC550_144_30; dispid 1610743837;
    procedure GhostMethod__PinSC550_148_31; dispid 1610743838;
    procedure GhostMethod__PinSC550_152_32; dispid 1610743839;
    procedure GhostMethod__PinSC550_156_33; dispid 1610743840;
    procedure GhostMethod__PinSC550_160_34; dispid 1610743841;
    procedure GhostMethod__PinSC550_164_35; dispid 1610743842;
    procedure GhostMethod__PinSC550_168_36; dispid 1610743843;
    procedure GhostMethod__PinSC550_172_37; dispid 1610743844;
    procedure GhostMethod__PinSC550_176_38; dispid 1610743845;
    procedure GhostMethod__PinSC550_180_39; dispid 1610743846;
    procedure GhostMethod__PinSC550_184_40; dispid 1610743847;
    procedure GhostMethod__PinSC550_188_41; dispid 1610743848;
    procedure GhostMethod__PinSC550_192_42; dispid 1610743849;
    procedure GhostMethod__PinSC550_196_43; dispid 1610743850;
    procedure GhostMethod__PinSC550_200_44; dispid 1610743851;
    procedure GhostMethod__PinSC550_204_45; dispid 1610743852;
    procedure GhostMethod__PinSC550_208_46; dispid 1610743853;
    procedure GhostMethod__PinSC550_212_47; dispid 1610743854;
    procedure GhostMethod__PinSC550_216_48; dispid 1610743855;
    procedure GhostMethod__PinSC550_220_49; dispid 1610743856;
    procedure GhostMethod__PinSC550_224_50; dispid 1610743857;
    procedure GhostMethod__PinSC550_228_51; dispid 1610743858;
    procedure GhostMethod__PinSC550_232_52; dispid 1610743859;
    procedure GhostMethod__PinSC550_236_53; dispid 1610743860;
    procedure GhostMethod__PinSC550_240_54; dispid 1610743861;
    procedure GhostMethod__PinSC550_244_55; dispid 1610743862;
    procedure GhostMethod__PinSC550_248_56; dispid 1610743863;
    procedure GhostMethod__PinSC550_252_57; dispid 1610743864;
    procedure GhostMethod__PinSC550_256_58; dispid 1610743865;
    procedure GhostMethod__PinSC550_260_59; dispid 1610743866;
    procedure GhostMethod__PinSC550_264_60; dispid 1610743867;
    procedure GhostMethod__PinSC550_268_61; dispid 1610743868;
    procedure GhostMethod__PinSC550_272_62; dispid 1610743869;
    procedure GhostMethod__PinSC550_276_63; dispid 1610743870;
    procedure GhostMethod__PinSC550_280_64; dispid 1610743871;
    procedure GhostMethod__PinSC550_284_65; dispid 1610743872;
    procedure GhostMethod__PinSC550_288_66; dispid 1610743873;
    procedure GhostMethod__PinSC550_292_67; dispid 1610743874;
    procedure GhostMethod__PinSC550_296_68; dispid 1610743875;
    procedure GhostMethod__PinSC550_300_69; dispid 1610743876;
    procedure GhostMethod__PinSC550_304_70; dispid 1610743877;
    procedure GhostMethod__PinSC550_308_71; dispid 1610743878;
    procedure GhostMethod__PinSC550_312_72; dispid 1610743879;
    procedure GhostMethod__PinSC550_316_73; dispid 1610743880;
    procedure GhostMethod__PinSC550_320_74; dispid 1610743881;
    procedure GhostMethod__PinSC550_324_75; dispid 1610743882;
    procedure GhostMethod__PinSC550_328_76; dispid 1610743883;
    procedure GhostMethod__PinSC550_332_77; dispid 1610743884;
    procedure GhostMethod__PinSC550_336_78; dispid 1610743885;
    procedure GhostMethod__PinSC550_340_79; dispid 1610743886;
    procedure GhostMethod__PinSC550_344_80; dispid 1610743887;
    procedure GhostMethod__PinSC550_348_81; dispid 1610743888;
    procedure GhostMethod__PinSC550_352_82; dispid 1610743889;
    procedure GhostMethod__PinSC550_356_83; dispid 1610743890;
    procedure GhostMethod__PinSC550_360_84; dispid 1610743891;
    procedure GhostMethod__PinSC550_364_85; dispid 1610743892;
    procedure GhostMethod__PinSC550_368_86; dispid 1610743893;
    procedure GhostMethod__PinSC550_372_87; dispid 1610743894;
    procedure GhostMethod__PinSC550_376_88; dispid 1610743895;
    procedure GhostMethod__PinSC550_380_89; dispid 1610743896;
    procedure GhostMethod__PinSC550_384_90; dispid 1610743897;
    procedure GhostMethod__PinSC550_388_91; dispid 1610743898;
    procedure GhostMethod__PinSC550_392_92; dispid 1610743899;
    procedure GhostMethod__PinSC550_396_93; dispid 1610743900;
    procedure GhostMethod__PinSC550_400_94; dispid 1610743901;
    procedure GhostMethod__PinSC550_404_95; dispid 1610743902;
    procedure GhostMethod__PinSC550_408_96; dispid 1610743903;
    procedure GhostMethod__PinSC550_412_97; dispid 1610743904;
    procedure GhostMethod__PinSC550_416_98; dispid 1610743905;
    procedure GhostMethod__PinSC550_420_99; dispid 1610743906;
    procedure GhostMethod__PinSC550_424_100; dispid 1610743907;
    procedure GhostMethod__PinSC550_428_101; dispid 1610743908;
    procedure GhostMethod__PinSC550_432_102; dispid 1610743909;
    procedure GhostMethod__PinSC550_436_103; dispid 1610743910;
    procedure GhostMethod__PinSC550_440_104; dispid 1610743911;
    procedure GhostMethod__PinSC550_444_105; dispid 1610743912;
    procedure GhostMethod__PinSC550_448_106; dispid 1610743913;
    procedure GhostMethod__PinSC550_452_107; dispid 1610743914;
    procedure GhostMethod__PinSC550_456_108; dispid 1610743915;
    procedure GhostMethod__PinSC550_460_109; dispid 1610743916;
    procedure GhostMethod__PinSC550_464_110; dispid 1610743917;
    procedure GhostMethod__PinSC550_468_111; dispid 1610743918;
    procedure GhostMethod__PinSC550_472_112; dispid 1610743919;
    procedure GhostMethod__PinSC550_476_113; dispid 1610743920;
    procedure GhostMethod__PinSC550_480_114; dispid 1610743921;
    procedure GhostMethod__PinSC550_484_115; dispid 1610743922;
    procedure GhostMethod__PinSC550_488_116; dispid 1610743923;
    procedure GhostMethod__PinSC550_492_117; dispid 1610743924;
    procedure GhostMethod__PinSC550_496_118; dispid 1610743925;
    procedure GhostMethod__PinSC550_500_119; dispid 1610743926;
    procedure GhostMethod__PinSC550_504_120; dispid 1610743927;
    procedure GhostMethod__PinSC550_508_121; dispid 1610743928;
    procedure GhostMethod__PinSC550_512_122; dispid 1610743929;
    procedure GhostMethod__PinSC550_516_123; dispid 1610743930;
    procedure GhostMethod__PinSC550_520_124; dispid 1610743931;
    procedure GhostMethod__PinSC550_524_125; dispid 1610743932;
    procedure GhostMethod__PinSC550_528_126; dispid 1610743933;
    procedure GhostMethod__PinSC550_532_127; dispid 1610743934;
    procedure GhostMethod__PinSC550_536_128; dispid 1610743935;
    procedure GhostMethod__PinSC550_540_129; dispid 1610743936;
    procedure GhostMethod__PinSC550_544_130; dispid 1610743937;
    procedure GhostMethod__PinSC550_548_131; dispid 1610743938;
    procedure GhostMethod__PinSC550_552_132; dispid 1610743939;
    procedure GhostMethod__PinSC550_556_133; dispid 1610743940;
    procedure GhostMethod__PinSC550_560_134; dispid 1610743941;
    procedure GhostMethod__PinSC550_564_135; dispid 1610743942;
    procedure GhostMethod__PinSC550_568_136; dispid 1610743943;
    procedure GhostMethod__PinSC550_572_137; dispid 1610743944;
    procedure GhostMethod__PinSC550_576_138; dispid 1610743945;
    procedure GhostMethod__PinSC550_580_139; dispid 1610743946;
    procedure GhostMethod__PinSC550_584_140; dispid 1610743947;
    procedure GhostMethod__PinSC550_588_141; dispid 1610743948;
    procedure GhostMethod__PinSC550_592_142; dispid 1610743949;
    procedure GhostMethod__PinSC550_596_143; dispid 1610743950;
    procedure GhostMethod__PinSC550_600_144; dispid 1610743951;
    procedure GhostMethod__PinSC550_604_145; dispid 1610743952;
    procedure GhostMethod__PinSC550_608_146; dispid 1610743953;
    procedure GhostMethod__PinSC550_612_147; dispid 1610743954;
    procedure GhostMethod__PinSC550_616_148; dispid 1610743955;
    procedure GhostMethod__PinSC550_620_149; dispid 1610743956;
    procedure GhostMethod__PinSC550_624_150; dispid 1610743957;
    procedure GhostMethod__PinSC550_628_151; dispid 1610743958;
    procedure GhostMethod__PinSC550_632_152; dispid 1610743959;
    procedure GhostMethod__PinSC550_636_153; dispid 1610743960;
    procedure GhostMethod__PinSC550_640_154; dispid 1610743961;
    procedure GhostMethod__PinSC550_644_155; dispid 1610743962;
    procedure GhostMethod__PinSC550_648_156; dispid 1610743963;
    procedure GhostMethod__PinSC550_652_157; dispid 1610743964;
    procedure GhostMethod__PinSC550_656_158; dispid 1610743965;
    procedure GhostMethod__PinSC550_660_159; dispid 1610743966;
    procedure GhostMethod__PinSC550_664_160; dispid 1610743967;
    procedure GhostMethod__PinSC550_668_161; dispid 1610743968;
    procedure GhostMethod__PinSC550_672_162; dispid 1610743969;
    procedure GhostMethod__PinSC550_676_163; dispid 1610743970;
    procedure GhostMethod__PinSC550_680_164; dispid 1610743971;
    procedure GhostMethod__PinSC550_684_165; dispid 1610743972;
    procedure GhostMethod__PinSC550_688_166; dispid 1610743973;
    procedure GhostMethod__PinSC550_692_167; dispid 1610743974;
    procedure GhostMethod__PinSC550_696_168; dispid 1610743975;
    procedure GhostMethod__PinSC550_700_169; dispid 1610743976;
    procedure GhostMethod__PinSC550_704_170; dispid 1610743977;
    procedure GhostMethod__PinSC550_708_171; dispid 1610743978;
    procedure GhostMethod__PinSC550_712_172; dispid 1610743979;
    procedure GhostMethod__PinSC550_716_173; dispid 1610743980;
    procedure GhostMethod__PinSC550_720_174; dispid 1610743981;
    procedure GhostMethod__PinSC550_724_175; dispid 1610743982;
    procedure GhostMethod__PinSC550_728_176; dispid 1610743983;
    procedure GhostMethod__PinSC550_732_177; dispid 1610743984;
    procedure GhostMethod__PinSC550_736_178; dispid 1610743985;
    procedure GhostMethod__PinSC550_740_179; dispid 1610743986;
    procedure GhostMethod__PinSC550_744_180; dispid 1610743987;
    procedure GhostMethod__PinSC550_748_181; dispid 1610743988;
    procedure GhostMethod__PinSC550_752_182; dispid 1610743989;
    procedure GhostMethod__PinSC550_756_183; dispid 1610743990;
    procedure GhostMethod__PinSC550_760_184; dispid 1610743991;
    procedure GhostMethod__PinSC550_764_185; dispid 1610743992;
    procedure GhostMethod__PinSC550_768_186; dispid 1610743993;
    procedure GhostMethod__PinSC550_772_187; dispid 1610743994;
    procedure GhostMethod__PinSC550_776_188; dispid 1610743995;
    procedure GhostMethod__PinSC550_780_189; dispid 1610743996;
    procedure GhostMethod__PinSC550_784_190; dispid 1610743997;
    procedure GhostMethod__PinSC550_788_191; dispid 1610743998;
    procedure GhostMethod__PinSC550_792_192; dispid 1610743999;
    procedure GhostMethod__PinSC550_796_193; dispid 1610744000;
    procedure GhostMethod__PinSC550_800_194; dispid 1610744001;
    procedure GhostMethod__PinSC550_804_195; dispid 1610744002;
    procedure GhostMethod__PinSC550_808_196; dispid 1610744003;
    procedure GhostMethod__PinSC550_812_197; dispid 1610744004;
    procedure GhostMethod__PinSC550_816_198; dispid 1610744005;
    procedure GhostMethod__PinSC550_820_199; dispid 1610744006;
    procedure GhostMethod__PinSC550_824_200; dispid 1610744007;
    procedure GhostMethod__PinSC550_828_201; dispid 1610744008;
    procedure GhostMethod__PinSC550_832_202; dispid 1610744009;
    procedure GhostMethod__PinSC550_836_203; dispid 1610744010;
    procedure GhostMethod__PinSC550_840_204; dispid 1610744011;
    procedure GhostMethod__PinSC550_844_205; dispid 1610744012;
    procedure GhostMethod__PinSC550_848_206; dispid 1610744013;
    procedure GhostMethod__PinSC550_852_207; dispid 1610744014;
    procedure GhostMethod__PinSC550_856_208; dispid 1610744015;
    procedure GhostMethod__PinSC550_860_209; dispid 1610744016;
    procedure GhostMethod__PinSC550_864_210; dispid 1610744017;
    procedure GhostMethod__PinSC550_868_211; dispid 1610744018;
    procedure GhostMethod__PinSC550_872_212; dispid 1610744019;
    procedure GhostMethod__PinSC550_876_213; dispid 1610744020;
    procedure GhostMethod__PinSC550_880_214; dispid 1610744021;
    procedure GhostMethod__PinSC550_884_215; dispid 1610744022;
    procedure GhostMethod__PinSC550_888_216; dispid 1610744023;
    procedure GhostMethod__PinSC550_892_217; dispid 1610744024;
    procedure GhostMethod__PinSC550_896_218; dispid 1610744025;
    procedure GhostMethod__PinSC550_900_219; dispid 1610744026;
    procedure GhostMethod__PinSC550_904_220; dispid 1610744027;
    procedure GhostMethod__PinSC550_908_221; dispid 1610744028;
    procedure GhostMethod__PinSC550_912_222; dispid 1610744029;
    procedure GhostMethod__PinSC550_916_223; dispid 1610744030;
    procedure GhostMethod__PinSC550_920_224; dispid 1610744031;
    procedure GhostMethod__PinSC550_924_225; dispid 1610744032;
    procedure GhostMethod__PinSC550_928_226; dispid 1610744033;
    procedure GhostMethod__PinSC550_932_227; dispid 1610744034;
    procedure GhostMethod__PinSC550_936_228; dispid 1610744035;
    procedure GhostMethod__PinSC550_940_229; dispid 1610744036;
    procedure GhostMethod__PinSC550_944_230; dispid 1610744037;
    procedure GhostMethod__PinSC550_948_231; dispid 1610744038;
    procedure GhostMethod__PinSC550_952_232; dispid 1610744039;
    procedure GhostMethod__PinSC550_956_233; dispid 1610744040;
    procedure GhostMethod__PinSC550_960_234; dispid 1610744041;
    procedure GhostMethod__PinSC550_964_235; dispid 1610744042;
    procedure GhostMethod__PinSC550_968_236; dispid 1610744043;
    procedure GhostMethod__PinSC550_972_237; dispid 1610744044;
    procedure GhostMethod__PinSC550_976_238; dispid 1610744045;
    procedure GhostMethod__PinSC550_980_239; dispid 1610744046;
    procedure GhostMethod__PinSC550_984_240; dispid 1610744047;
    procedure GhostMethod__PinSC550_988_241; dispid 1610744048;
    procedure GhostMethod__PinSC550_992_242; dispid 1610744049;
    procedure GhostMethod__PinSC550_996_243; dispid 1610744050;
    procedure GhostMethod__PinSC550_1000_244; dispid 1610744051;
    procedure GhostMethod__PinSC550_1004_245; dispid 1610744052;
    procedure GhostMethod__PinSC550_1008_246; dispid 1610744053;
    procedure GhostMethod__PinSC550_1012_247; dispid 1610744054;
    procedure GhostMethod__PinSC550_1016_248; dispid 1610744055;
    procedure GhostMethod__PinSC550_1020_249; dispid 1610744056;
    procedure GhostMethod__PinSC550_1024_250; dispid 1610744057;
    procedure GhostMethod__PinSC550_1028_251; dispid 1610744058;
    procedure GhostMethod__PinSC550_1032_252; dispid 1610744059;
    procedure GhostMethod__PinSC550_1036_253; dispid 1610744060;
    procedure GhostMethod__PinSC550_1040_254; dispid 1610744061;
    procedure GhostMethod__PinSC550_1044_255; dispid 1610744062;
    procedure GhostMethod__PinSC550_1048_256; dispid 1610744063;
    procedure GhostMethod__PinSC550_1052_257; dispid 1610744064;
    procedure GhostMethod__PinSC550_1056_258; dispid 1610744065;
    procedure GhostMethod__PinSC550_1060_259; dispid 1610744066;
    procedure GhostMethod__PinSC550_1064_260; dispid 1610744067;
    procedure GhostMethod__PinSC550_1068_261; dispid 1610744068;
    procedure GhostMethod__PinSC550_1072_262; dispid 1610744069;
    procedure GhostMethod__PinSC550_1076_263; dispid 1610744070;
    procedure GhostMethod__PinSC550_1080_264; dispid 1610744071;
    procedure GhostMethod__PinSC550_1084_265; dispid 1610744072;
    procedure GhostMethod__PinSC550_1088_266; dispid 1610744073;
    procedure GhostMethod__PinSC550_1092_267; dispid 1610744074;
    procedure GhostMethod__PinSC550_1096_268; dispid 1610744075;
    procedure GhostMethod__PinSC550_1100_269; dispid 1610744076;
    procedure GhostMethod__PinSC550_1104_270; dispid 1610744077;
    procedure GhostMethod__PinSC550_1108_271; dispid 1610744078;
    procedure GhostMethod__PinSC550_1112_272; dispid 1610744079;
    procedure GhostMethod__PinSC550_1116_273; dispid 1610744080;
    procedure GhostMethod__PinSC550_1120_274; dispid 1610744081;
    procedure GhostMethod__PinSC550_1124_275; dispid 1610744082;
    procedure GhostMethod__PinSC550_1128_276; dispid 1610744083;
    procedure GhostMethod__PinSC550_1132_277; dispid 1610744084;
    procedure GhostMethod__PinSC550_1136_278; dispid 1610744085;
    procedure GhostMethod__PinSC550_1140_279; dispid 1610744086;
    procedure GhostMethod__PinSC550_1144_280; dispid 1610744087;
    procedure GhostMethod__PinSC550_1148_281; dispid 1610744088;
    procedure GhostMethod__PinSC550_1152_282; dispid 1610744089;
    procedure GhostMethod__PinSC550_1156_283; dispid 1610744090;
    procedure GhostMethod__PinSC550_1160_284; dispid 1610744091;
    procedure GhostMethod__PinSC550_1164_285; dispid 1610744092;
    procedure GhostMethod__PinSC550_1168_286; dispid 1610744093;
    procedure GhostMethod__PinSC550_1172_287; dispid 1610744094;
    procedure GhostMethod__PinSC550_1176_288; dispid 1610744095;
    procedure GhostMethod__PinSC550_1180_289; dispid 1610744096;
    procedure GhostMethod__PinSC550_1184_290; dispid 1610744097;
    procedure GhostMethod__PinSC550_1188_291; dispid 1610744098;
    procedure GhostMethod__PinSC550_1192_292; dispid 1610744099;
    procedure GhostMethod__PinSC550_1196_293; dispid 1610744100;
    procedure GhostMethod__PinSC550_1200_294; dispid 1610744101;
    procedure GhostMethod__PinSC550_1204_295; dispid 1610744102;
    procedure GhostMethod__PinSC550_1208_296; dispid 1610744103;
    procedure GhostMethod__PinSC550_1212_297; dispid 1610744104;
    procedure GhostMethod__PinSC550_1216_298; dispid 1610744105;
    procedure GhostMethod__PinSC550_1220_299; dispid 1610744106;
    procedure GhostMethod__PinSC550_1224_300; dispid 1610744107;
    procedure GhostMethod__PinSC550_1228_301; dispid 1610744108;
    procedure GhostMethod__PinSC550_1232_302; dispid 1610744109;
    procedure GhostMethod__PinSC550_1236_303; dispid 1610744110;
    procedure GhostMethod__PinSC550_1240_304; dispid 1610744111;
    procedure GhostMethod__PinSC550_1244_305; dispid 1610744112;
    procedure GhostMethod__PinSC550_1248_306; dispid 1610744113;
    procedure GhostMethod__PinSC550_1252_307; dispid 1610744114;
    procedure GhostMethod__PinSC550_1256_308; dispid 1610744115;
    procedure GhostMethod__PinSC550_1260_309; dispid 1610744116;
    procedure GhostMethod__PinSC550_1264_310; dispid 1610744117;
    procedure GhostMethod__PinSC550_1268_311; dispid 1610744118;
    procedure GhostMethod__PinSC550_1272_312; dispid 1610744119;
    procedure GhostMethod__PinSC550_1276_313; dispid 1610744120;
    procedure GhostMethod__PinSC550_1280_314; dispid 1610744121;
    procedure GhostMethod__PinSC550_1284_315; dispid 1610744122;
    procedure GhostMethod__PinSC550_1288_316; dispid 1610744123;
    procedure GhostMethod__PinSC550_1292_317; dispid 1610744124;
    procedure GhostMethod__PinSC550_1296_318; dispid 1610744125;
    procedure GhostMethod__PinSC550_1300_319; dispid 1610744126;
    procedure GhostMethod__PinSC550_1304_320; dispid 1610744127;
    procedure GhostMethod__PinSC550_1308_321; dispid 1610744128;
    procedure GhostMethod__PinSC550_1312_322; dispid 1610744129;
    procedure GhostMethod__PinSC550_1316_323; dispid 1610744130;
    procedure GhostMethod__PinSC550_1320_324; dispid 1610744131;
    procedure GhostMethod__PinSC550_1324_325; dispid 1610744132;
    procedure GhostMethod__PinSC550_1328_326; dispid 1610744133;
    procedure GhostMethod__PinSC550_1332_327; dispid 1610744134;
    procedure GhostMethod__PinSC550_1336_328; dispid 1610744135;
    procedure GhostMethod__PinSC550_1340_329; dispid 1610744136;
    procedure GhostMethod__PinSC550_1344_330; dispid 1610744137;
    procedure GhostMethod__PinSC550_1348_331; dispid 1610744138;
    procedure GhostMethod__PinSC550_1352_332; dispid 1610744139;
    procedure GhostMethod__PinSC550_1356_333; dispid 1610744140;
    procedure GhostMethod__PinSC550_1360_334; dispid 1610744141;
    procedure GhostMethod__PinSC550_1364_335; dispid 1610744142;
    procedure GhostMethod__PinSC550_1368_336; dispid 1610744143;
    procedure GhostMethod__PinSC550_1372_337; dispid 1610744144;
    procedure GhostMethod__PinSC550_1376_338; dispid 1610744145;
    procedure GhostMethod__PinSC550_1380_339; dispid 1610744146;
    procedure GhostMethod__PinSC550_1384_340; dispid 1610744147;
    procedure GhostMethod__PinSC550_1388_341; dispid 1610744148;
    procedure GhostMethod__PinSC550_1392_342; dispid 1610744149;
    procedure GhostMethod__PinSC550_1396_343; dispid 1610744150;
    procedure GhostMethod__PinSC550_1400_344; dispid 1610744151;
    procedure GhostMethod__PinSC550_1404_345; dispid 1610744152;
    procedure GhostMethod__PinSC550_1408_346; dispid 1610744153;
    procedure GhostMethod__PinSC550_1412_347; dispid 1610744154;
    procedure GhostMethod__PinSC550_1416_348; dispid 1610744155;
    procedure GhostMethod__PinSC550_1420_349; dispid 1610744156;
    procedure GhostMethod__PinSC550_1424_350; dispid 1610744157;
    procedure GhostMethod__PinSC550_1428_351; dispid 1610744158;
    procedure GhostMethod__PinSC550_1432_352; dispid 1610744159;
    procedure GhostMethod__PinSC550_1436_353; dispid 1610744160;
    procedure GhostMethod__PinSC550_1440_354; dispid 1610744161;
    procedure GhostMethod__PinSC550_1444_355; dispid 1610744162;
    procedure GhostMethod__PinSC550_1448_356; dispid 1610744163;
    procedure GhostMethod__PinSC550_1452_357; dispid 1610744164;
    procedure GhostMethod__PinSC550_1456_358; dispid 1610744165;
    procedure GhostMethod__PinSC550_1460_359; dispid 1610744166;
    procedure GhostMethod__PinSC550_1464_360; dispid 1610744167;
    procedure GhostMethod__PinSC550_1468_361; dispid 1610744168;
    procedure GhostMethod__PinSC550_1472_362; dispid 1610744169;
    procedure GhostMethod__PinSC550_1476_363; dispid 1610744170;
    procedure GhostMethod__PinSC550_1480_364; dispid 1610744171;
    procedure GhostMethod__PinSC550_1484_365; dispid 1610744172;
    procedure GhostMethod__PinSC550_1488_366; dispid 1610744173;
    procedure GhostMethod__PinSC550_1492_367; dispid 1610744174;
    procedure GhostMethod__PinSC550_1496_368; dispid 1610744175;
    procedure GhostMethod__PinSC550_1500_369; dispid 1610744176;
    procedure GhostMethod__PinSC550_1504_370; dispid 1610744177;
    procedure GhostMethod__PinSC550_1508_371; dispid 1610744178;
    procedure GhostMethod__PinSC550_1512_372; dispid 1610744179;
    procedure GhostMethod__PinSC550_1516_373; dispid 1610744180;
    procedure GhostMethod__PinSC550_1520_374; dispid 1610744181;
    procedure GhostMethod__PinSC550_1524_375; dispid 1610744182;
    procedure GhostMethod__PinSC550_1528_376; dispid 1610744183;
    procedure GhostMethod__PinSC550_1532_377; dispid 1610744184;
    procedure GhostMethod__PinSC550_1536_378; dispid 1610744185;
    procedure GhostMethod__PinSC550_1540_379; dispid 1610744186;
    procedure GhostMethod__PinSC550_1544_380; dispid 1610744187;
    procedure GhostMethod__PinSC550_1548_381; dispid 1610744188;
    procedure GhostMethod__PinSC550_1552_382; dispid 1610744189;
    procedure GhostMethod__PinSC550_1556_383; dispid 1610744190;
    procedure GhostMethod__PinSC550_1560_384; dispid 1610744191;
    procedure GhostMethod__PinSC550_1564_385; dispid 1610744192;
    procedure GhostMethod__PinSC550_1568_386; dispid 1610744193;
    procedure GhostMethod__PinSC550_1572_387; dispid 1610744194;
    procedure GhostMethod__PinSC550_1576_388; dispid 1610744195;
    procedure GhostMethod__PinSC550_1580_389; dispid 1610744196;
    procedure GhostMethod__PinSC550_1584_390; dispid 1610744197;
    procedure GhostMethod__PinSC550_1588_391; dispid 1610744198;
    procedure GhostMethod__PinSC550_1592_392; dispid 1610744199;
    procedure GhostMethod__PinSC550_1596_393; dispid 1610744200;
    procedure GhostMethod__PinSC550_1600_394; dispid 1610744201;
    procedure GhostMethod__PinSC550_1604_395; dispid 1610744202;
    procedure GhostMethod__PinSC550_1608_396; dispid 1610744203;
    procedure GhostMethod__PinSC550_1612_397; dispid 1610744204;
    procedure GhostMethod__PinSC550_1616_398; dispid 1610744205;
    procedure GhostMethod__PinSC550_1620_399; dispid 1610744206;
    procedure GhostMethod__PinSC550_1624_400; dispid 1610744207;
    procedure GhostMethod__PinSC550_1628_401; dispid 1610744208;
    procedure GhostMethod__PinSC550_1632_402; dispid 1610744209;
    procedure GhostMethod__PinSC550_1636_403; dispid 1610744210;
    procedure GhostMethod__PinSC550_1640_404; dispid 1610744211;
    procedure GhostMethod__PinSC550_1644_405; dispid 1610744212;
    procedure GhostMethod__PinSC550_1648_406; dispid 1610744213;
    procedure GhostMethod__PinSC550_1652_407; dispid 1610744214;
    procedure GhostMethod__PinSC550_1656_408; dispid 1610744215;
    procedure GhostMethod__PinSC550_1660_409; dispid 1610744216;
    procedure GhostMethod__PinSC550_1664_410; dispid 1610744217;
    procedure GhostMethod__PinSC550_1668_411; dispid 1610744218;
    procedure GhostMethod__PinSC550_1672_412; dispid 1610744219;
    procedure GhostMethod__PinSC550_1676_413; dispid 1610744220;
    procedure GhostMethod__PinSC550_1680_414; dispid 1610744221;
    procedure GhostMethod__PinSC550_1684_415; dispid 1610744222;
    procedure GhostMethod__PinSC550_1688_416; dispid 1610744223;
    procedure GhostMethod__PinSC550_1692_417; dispid 1610744224;
    procedure GhostMethod__PinSC550_1696_418; dispid 1610744225;
    procedure GhostMethod__PinSC550_1700_419; dispid 1610744226;
    procedure GhostMethod__PinSC550_1704_420; dispid 1610744227;
    procedure GhostMethod__PinSC550_1708_421; dispid 1610744228;
    procedure GhostMethod__PinSC550_1712_422; dispid 1610744229;
    procedure GhostMethod__PinSC550_1716_423; dispid 1610744230;
    procedure GhostMethod__PinSC550_1720_424; dispid 1610744231;
    procedure GhostMethod__PinSC550_1724_425; dispid 1610744232;
    procedure GhostMethod__PinSC550_1728_426; dispid 1610744233;
    procedure GhostMethod__PinSC550_1732_427; dispid 1610744234;
    procedure GhostMethod__PinSC550_1736_428; dispid 1610744235;
    procedure GhostMethod__PinSC550_1740_429; dispid 1610744236;
    procedure GhostMethod__PinSC550_1744_430; dispid 1610744237;
    procedure GhostMethod__PinSC550_1748_431; dispid 1610744238;
    procedure GhostMethod__PinSC550_1752_432; dispid 1610744239;
    procedure GhostMethod__PinSC550_1756_433; dispid 1610744240;
    procedure GhostMethod__PinSC550_1760_434; dispid 1610744241;
    procedure GhostMethod__PinSC550_1764_435; dispid 1610744242;
    procedure GhostMethod__PinSC550_1768_436; dispid 1610744243;
    procedure GhostMethod__PinSC550_1772_437; dispid 1610744244;
    procedure GhostMethod__PinSC550_1776_438; dispid 1610744245;
    procedure GhostMethod__PinSC550_1780_439; dispid 1610744246;
    procedure GhostMethod__PinSC550_1784_440; dispid 1610744247;
    procedure GhostMethod__PinSC550_1788_441; dispid 1610744248;
    procedure GhostMethod__PinSC550_1792_442; dispid 1610744249;
    procedure GhostMethod__PinSC550_1796_443; dispid 1610744250;
    procedure GhostMethod__PinSC550_1800_444; dispid 1610744251;
    procedure GhostMethod__PinSC550_1804_445; dispid 1610744252;
    procedure GhostMethod__PinSC550_1808_446; dispid 1610744253;
    procedure GhostMethod__PinSC550_1812_447; dispid 1610744254;
    procedure GhostMethod__PinSC550_1816_448; dispid 1610744255;
    procedure GhostMethod__PinSC550_1820_449; dispid 1610744256;
    procedure GhostMethod__PinSC550_1824_450; dispid 1610744257;
    procedure GhostMethod__PinSC550_1828_451; dispid 1610744258;
    procedure GhostMethod__PinSC550_1832_452; dispid 1610744259;
    procedure GhostMethod__PinSC550_1836_453; dispid 1610744260;
    procedure GhostMethod__PinSC550_1840_454; dispid 1610744261;
    procedure GhostMethod__PinSC550_1844_455; dispid 1610744262;
    procedure GhostMethod__PinSC550_1848_456; dispid 1610744263;
    procedure GhostMethod__PinSC550_1852_457; dispid 1610744264;
    procedure GhostMethod__PinSC550_1856_458; dispid 1610744265;
    procedure GhostMethod__PinSC550_1860_459; dispid 1610744266;
    procedure GhostMethod__PinSC550_1864_460; dispid 1610744267;
    procedure GhostMethod__PinSC550_1868_461; dispid 1610744268;
    procedure GhostMethod__PinSC550_1872_462; dispid 1610744269;
    procedure GhostMethod__PinSC550_1876_463; dispid 1610744270;
    procedure GhostMethod__PinSC550_1880_464; dispid 1610744271;
    procedure GhostMethod__PinSC550_1884_465; dispid 1610744272;
    procedure GhostMethod__PinSC550_1888_466; dispid 1610744273;
    procedure GhostMethod__PinSC550_1892_467; dispid 1610744274;
    procedure GhostMethod__PinSC550_1896_468; dispid 1610744275;
    procedure GhostMethod__PinSC550_1900_469; dispid 1610744276;
    procedure GhostMethod__PinSC550_1904_470; dispid 1610744277;
    procedure GhostMethod__PinSC550_1908_471; dispid 1610744278;
    procedure GhostMethod__PinSC550_1912_472; dispid 1610744279;
    procedure GhostMethod__PinSC550_1916_473; dispid 1610744280;
    procedure GhostMethod__PinSC550_1920_474; dispid 1610744281;
    procedure GhostMethod__PinSC550_1924_475; dispid 1610744282;
    procedure GhostMethod__PinSC550_1928_476; dispid 1610744283;
    procedure GhostMethod__PinSC550_1932_477; dispid 1610744284;
    procedure GhostMethod__PinSC550_1936_478; dispid 1610744285;
    procedure GhostMethod__PinSC550_1940_479; dispid 1610744286;
    procedure GhostMethod__PinSC550_1944_480; dispid 1610744287;
    procedure GhostMethod__PinSC550_1948_481; dispid 1610744288;
    procedure GhostMethod__PinSC550_1952_482; dispid 1610744289;
    property KeyType: GPSKeyManagementType readonly dispid 1745027107;
    property PortState: GPSRespStatus readonly dispid 1745027106;
    property CommVisible: WordBool dispid 1745027105;
    property TimeOut: WideString dispid 1745027104;
    property Baud: WideString dispid 1745027103;
    property Parity: WideString dispid 1745027102;
    property Port: WideString dispid 1745027101;
    property DataBits: WideString dispid 1745027100;
    property DeviceData: WideString readonly dispid 1745027099;
    property ServerPath: WideString dispid 1745027098;
    property AutoProcess: WordBool dispid 1745027097;
    property AutoInterval: WideString dispid 1745027096;
    property DefaultLanguageCode: WideString dispid 1745027095;
    property DeviceState: GPSRespStatus readonly dispid 1745027094;
    property ActionPending: GPSActionPending readonly dispid 1745027093;
    property ResponseCodeAsString[var eCode: GPSRespCode]: WideString readonly dispid 1745027092;
    property ResponseAsString[var eCode: GPSRespStatus]: WideString readonly dispid 1745027091;
    procedure OpenPort; dispid 1610809386;
    procedure ClosePort; dispid 1610809387;
    procedure Initialize; dispid 1610809388;
    procedure GetSerialBlock; dispid 1610809389;
    procedure StartMSR; dispid 1610809390;
    procedure Cancel; dispid 1610809391;
    procedure DispGenMsg(var szIDUpper: WideString; var szIDLower: WideString; 
                         var eLangCode: GPSLangCode); dispid 1610809392;
    procedure DispObtainCard(var eLangCode: GPSLangCode); dispid 1610809393;
    procedure RequestMAC(var szData: WideString); dispid 1610809394;
    procedure InteracAnalysis(var szData: WideString; var eLangCode: GPSLangCode); dispid 1610809395;
    procedure LoadKey(var szData: WideString); dispid 1610809396;
    procedure RequestInterac(var szData: WideString; var eLangCode: GPSLangCode); dispid 1610809397;
    procedure DispPrinterDown(var eLangCode: GPSLangCode); dispid 1610809398;
    procedure DispBankResponse(var szBankCode: WideString; var szISOCode: WideString; 
                               var eLangCode: GPSLangCode); dispid 1610809399;
    property LanguageCode: GPSLangCode readonly dispid 1745027090;
    property RespCode: GPSRespCode readonly dispid 1745027089;
    property BatchCode: WideString readonly dispid 1745027088;
    property TrackII: WideString readonly dispid 1745027087;
    property MacBlock: WideString readonly dispid 1745027086;
    property Account: WideString readonly dispid 1745027085;
    property PinBlock: WideString readonly dispid 1745027084;
    property VFIBlock: WideString readonly dispid 1745027083;
    property AppName: WideString readonly dispid 1745027082;
    property KernelID: WideString readonly dispid 1745027081;
    property ChipStatus: WideString readonly dispid 1745027080;
    property PinPadType: WideString readonly dispid 1745027079;
    property ROMVersion: WideString readonly dispid 1745027078;
    property ProdData: WideString readonly dispid 1745027077;
    property FacilityCode: WideString readonly dispid 1745027076;
    property ChipSN: WideString readonly dispid 1745027075;
    property FirmVersion: WideString readonly dispid 1745027074;
    property RequireReMac: WordBool readonly dispid 1745027073;
    property ReMacData: WideString readonly dispid 1745027072;
    function Base64Encode(var szData: WideString): WideString; dispid 1610809400;
    function Base64Decode(var szData: WideString): WideString; dispid 1610809401;
  end;

// *********************************************************************//
// DispIntf:  __PinSC550
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {58DBA776-1B08-4BB5-87D9-8D630BEEE7B9}
// *********************************************************************//
  __PinSC550 = dispinterface
    ['{58DBA776-1B08-4BB5-87D9-8D630BEEE7B9}']
    procedure ActionUpdate(var eAction: GPSPinPadAction; var eResp: GPSRespStatus); dispid 1;
  end;

// *********************************************************************//
// Interface: _clsUtil
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6A4C29EB-849E-4CE9-9211-D76284A46A72}
// *********************************************************************//
  _clsUtil = interface(IDispatch)
    ['{6A4C29EB-849E-4CE9-9211-D76284A46A72}']
  end;

// *********************************************************************//
// DispIntf:  _clsUtilDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6A4C29EB-849E-4CE9-9211-D76284A46A72}
// *********************************************************************//
  _clsUtilDisp = dispinterface
    ['{6A4C29EB-849E-4CE9-9211-D76284A46A72}']
  end;

// *********************************************************************//
// Interface: _clsInteracReq
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B5A69424-54DC-4002-90C0-EB8F828A9190}
// *********************************************************************//
  _clsInteracReq = interface(IDispatch)
    ['{B5A69424-54DC-4002-90C0-EB8F828A9190}']
    procedure Set_TipAmount(var Param1: WideString); safecall;
    function Get_TipAmount: WideString; safecall;
    procedure Set_VFISerial(var Param1: WideString); safecall;
    function Get_VFISerial: WideString; safecall;
    procedure Set_PinBlock(var Param1: WideString); safecall;
    function Get_PinBlock: WideString; safecall;
    procedure Set_Account(var Param1: WideString); safecall;
    function Get_Account: WideString; safecall;
    procedure Set_MacBlock(var Param1: WideString); safecall;
    function Get_MacBlock: WideString; safecall;
    procedure Set_AccType(var Param1: GPSAccType); safecall;
    function Get_AccType: GPSAccType; safecall;
    procedure Set_TransCode(var Param1: GPSTransCode); safecall;
    function Get_TransCode: GPSTransCode; safecall;
    procedure Set_TipType(var Param1: Smallint); safecall;
    function Get_TipType: Smallint; safecall;
    procedure Set_TrackII(var Param1: WideString); safecall;
    function Get_TrackII: WideString; safecall;
    procedure Set_SequenceNum(var Param1: WideString); safecall;
    function Get_SequenceNum: WideString; safecall;
    procedure Set_Amount(var Param1: WideString); safecall;
    function Get_Amount: WideString; safecall;
    procedure Set_TermID(var Param1: WideString); safecall;
    function Get_TermID: WideString; safecall;
    procedure Set_DisplayAmount(var Param1: WideString); safecall;
    function Get_DisplayAmount: WideString; safecall;
    procedure Set_TransNameID(var Param1: GPSTransID); safecall;
    function Get_TransNameID: GPSTransID; safecall;
    function ParseResponseData(var szData: WideString): WordBool; safecall;
    function BuildRemacData: WideString; safecall;
    function BuildInteracRequest: WideString; safecall;
    procedure ClearData; safecall;
    property TipAmount: WideString read Get_TipAmount write Set_TipAmount;
    property VFISerial: WideString read Get_VFISerial write Set_VFISerial;
    property PinBlock: WideString read Get_PinBlock write Set_PinBlock;
    property Account: WideString read Get_Account write Set_Account;
    property MacBlock: WideString read Get_MacBlock write Set_MacBlock;
    property AccType: GPSAccType read Get_AccType write Set_AccType;
    property TransCode: GPSTransCode read Get_TransCode write Set_TransCode;
    property TipType: Smallint read Get_TipType write Set_TipType;
    property TrackII: WideString read Get_TrackII write Set_TrackII;
    property SequenceNum: WideString read Get_SequenceNum write Set_SequenceNum;
    property Amount: WideString read Get_Amount write Set_Amount;
    property TermID: WideString read Get_TermID write Set_TermID;
    property DisplayAmount: WideString read Get_DisplayAmount write Set_DisplayAmount;
    property TransNameID: GPSTransID read Get_TransNameID write Set_TransNameID;
  end;

// *********************************************************************//
// DispIntf:  _clsInteracReqDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B5A69424-54DC-4002-90C0-EB8F828A9190}
// *********************************************************************//
  _clsInteracReqDisp = dispinterface
    ['{B5A69424-54DC-4002-90C0-EB8F828A9190}']
    property TipAmount: WideString dispid 1745027085;
    property VFISerial: WideString dispid 1745027084;
    property PinBlock: WideString dispid 1745027083;
    property Account: WideString dispid 1745027082;
    property MacBlock: WideString dispid 1745027081;
    property AccType: GPSAccType dispid 1745027080;
    property TransCode: GPSTransCode dispid 1745027079;
    property TipType: Smallint dispid 1745027078;
    property TrackII: WideString dispid 1745027077;
    property SequenceNum: WideString dispid 1745027076;
    property Amount: WideString dispid 1745027075;
    property TermID: WideString dispid 1745027074;
    property DisplayAmount: WideString dispid 1745027073;
    property TransNameID: GPSTransID dispid 1745027072;
    function ParseResponseData(var szData: WideString): WordBool; dispid 1610809358;
    function BuildRemacData: WideString; dispid 1610809359;
    function BuildInteracRequest: WideString; dispid 1610809360;
    procedure ClearData; dispid 1610809361;
  end;

// *********************************************************************//
// Interface: _clsGlobalAPi
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {ADD6CF64-2100-4AF2-A208-A7F5182C11BA}
// *********************************************************************//
  _clsGlobalAPi = interface(IDispatch)
    ['{ADD6CF64-2100-4AF2-A208-A7F5182C11BA}']
    procedure Set_ReMac(var Param1: WordBool); safecall;
    function Get_ReMac: WordBool; safecall;
    procedure Set_ReMacData(var Param1: WideString); safecall;
    function Get_ReMacData: WideString; safecall;
    procedure Set_MacBlock(var Param1: WideString); safecall;
    function Get_MacBlock: WideString; safecall;
    procedure Set_BatchCode(var Param1: WideString); safecall;
    function Get_BatchCode: WideString; safecall;
    procedure Set_FirmVersion(var Param1: WideString); safecall;
    function Get_FirmVersion: WideString; safecall;
    procedure Set_ChipSN(var Param1: WideString); safecall;
    function Get_ChipSN: WideString; safecall;
    procedure Set_FacilityCode(var Param1: WideString); safecall;
    function Get_FacilityCode: WideString; safecall;
    procedure Set_ProdData(var Param1: WideString); safecall;
    function Get_ProdData: WideString; safecall;
    procedure Set_ROMVersion(var Param1: WideString); safecall;
    function Get_ROMVersion: WideString; safecall;
    procedure Set_PinPadType(var Param1: WideString); safecall;
    function Get_PinPadType: WideString; safecall;
    procedure Set_ChipStatus(var Param1: WideString); safecall;
    function Get_ChipStatus: WideString; safecall;
    procedure Set_KernelID(var Param1: WideString); safecall;
    function Get_KernelID: WideString; safecall;
    procedure Set_AppName(var Param1: WideString); safecall;
    function Get_AppName: WideString; safecall;
    procedure Set_VFIBlock(var Param1: WideString); safecall;
    function Get_VFIBlock: WideString; safecall;
    procedure Set_PinBlock(var Param1: WideString); safecall;
    function Get_PinBlock: WideString; safecall;
    procedure Set_Account(var Param1: WideString); safecall;
    function Get_Account: WideString; safecall;
    procedure Set_TrackII(var Param1: WideString); safecall;
    function Get_TrackII: WideString; safecall;
    procedure Set_RespCode(var Param1: GPSRespCode); safecall;
    function Get_RespCode: GPSRespCode; safecall;
    function Get_KeyType: GPSKeyManagementType; safecall;
    procedure Set_DeviceData(var Param1: WideString); safecall;
    function Get_DeviceData: WideString; safecall;
    procedure Set_TimeOut(var Param1: WideString); safecall;
    function Get_TimeOut: WideString; safecall;
    procedure Set_DataBits(var Param1: WideString); safecall;
    function Get_DataBits: WideString; safecall;
    procedure Set_Port(var Param1: WideString); safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Parity(var Param1: WideString); safecall;
    function Get_Parity: WideString; safecall;
    procedure Set_Baud(var Param1: WideString); safecall;
    function Get_Baud: WideString; safecall;
    procedure Set_DefaultLanguageCode(var Param1: GPSLangCode); safecall;
    function Get_DefaultLanguageCode: GPSLangCode; safecall;
    procedure Set_LanguageCode(var Param1: GPSLangCode); safecall;
    function Get_LanguageCode: GPSLangCode; safecall;
    function Get_PortState: GPSRespStatus; safecall;
    procedure Set_ServerPath(var Param1: WideString); safecall;
    function Get_ServerPath: WideString; safecall;
    function Get_DeviceState: GPSRespStatus; safecall;
    function Get_DeviceAction: GPSActionPending; safecall;
    procedure Set_Auto(var Param1: WordBool); safecall;
    function Get_Auto: WordBool; safecall;
    procedure Set_AutoInterval(var Param1: WideString); safecall;
    function Get_AutoInterval: WideString; safecall;
    function OpenPort: GPSRespStatus; safecall;
    function ClosePort: GPSRespStatus; safecall;
    property ReMac: WordBool read Get_ReMac write Set_ReMac;
    property ReMacData: WideString read Get_ReMacData write Set_ReMacData;
    property MacBlock: WideString read Get_MacBlock write Set_MacBlock;
    property BatchCode: WideString read Get_BatchCode write Set_BatchCode;
    property FirmVersion: WideString read Get_FirmVersion write Set_FirmVersion;
    property ChipSN: WideString read Get_ChipSN write Set_ChipSN;
    property FacilityCode: WideString read Get_FacilityCode write Set_FacilityCode;
    property ProdData: WideString read Get_ProdData write Set_ProdData;
    property ROMVersion: WideString read Get_ROMVersion write Set_ROMVersion;
    property PinPadType: WideString read Get_PinPadType write Set_PinPadType;
    property ChipStatus: WideString read Get_ChipStatus write Set_ChipStatus;
    property KernelID: WideString read Get_KernelID write Set_KernelID;
    property AppName: WideString read Get_AppName write Set_AppName;
    property VFIBlock: WideString read Get_VFIBlock write Set_VFIBlock;
    property PinBlock: WideString read Get_PinBlock write Set_PinBlock;
    property Account: WideString read Get_Account write Set_Account;
    property TrackII: WideString read Get_TrackII write Set_TrackII;
    property RespCode: GPSRespCode read Get_RespCode write Set_RespCode;
    property KeyType: GPSKeyManagementType read Get_KeyType;
    property DeviceData: WideString read Get_DeviceData write Set_DeviceData;
    property TimeOut: WideString read Get_TimeOut write Set_TimeOut;
    property DataBits: WideString read Get_DataBits write Set_DataBits;
    property Port: WideString read Get_Port write Set_Port;
    property Parity: WideString read Get_Parity write Set_Parity;
    property Baud: WideString read Get_Baud write Set_Baud;
    property DefaultLanguageCode: GPSLangCode read Get_DefaultLanguageCode write Set_DefaultLanguageCode;
    property LanguageCode: GPSLangCode read Get_LanguageCode write Set_LanguageCode;
    property PortState: GPSRespStatus read Get_PortState;
    property ServerPath: WideString read Get_ServerPath write Set_ServerPath;
    property DeviceState: GPSRespStatus read Get_DeviceState;
    property DeviceAction: GPSActionPending read Get_DeviceAction;
    property Auto: WordBool read Get_Auto write Set_Auto;
    property AutoInterval: WideString read Get_AutoInterval write Set_AutoInterval;
  end;

// *********************************************************************//
// DispIntf:  _clsGlobalAPiDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {ADD6CF64-2100-4AF2-A208-A7F5182C11BA}
// *********************************************************************//
  _clsGlobalAPiDisp = dispinterface
    ['{ADD6CF64-2100-4AF2-A208-A7F5182C11BA}']
    property ReMac: WordBool dispid 1745027104;
    property ReMacData: WideString dispid 1745027103;
    property MacBlock: WideString dispid 1745027102;
    property BatchCode: WideString dispid 1745027101;
    property FirmVersion: WideString dispid 1745027100;
    property ChipSN: WideString dispid 1745027099;
    property FacilityCode: WideString dispid 1745027098;
    property ProdData: WideString dispid 1745027097;
    property ROMVersion: WideString dispid 1745027096;
    property PinPadType: WideString dispid 1745027095;
    property ChipStatus: WideString dispid 1745027094;
    property KernelID: WideString dispid 1745027093;
    property AppName: WideString dispid 1745027092;
    property VFIBlock: WideString dispid 1745027091;
    property PinBlock: WideString dispid 1745027090;
    property Account: WideString dispid 1745027089;
    property TrackII: WideString dispid 1745027088;
    property RespCode: GPSRespCode dispid 1745027087;
    property KeyType: GPSKeyManagementType readonly dispid 1745027086;
    property DeviceData: WideString dispid 1745027085;
    property TimeOut: WideString dispid 1745027084;
    property DataBits: WideString dispid 1745027083;
    property Port: WideString dispid 1745027082;
    property Parity: WideString dispid 1745027081;
    property Baud: WideString dispid 1745027080;
    property DefaultLanguageCode: GPSLangCode dispid 1745027079;
    property LanguageCode: GPSLangCode dispid 1745027078;
    property PortState: GPSRespStatus readonly dispid 1745027077;
    property ServerPath: WideString dispid 1745027076;
    property DeviceState: GPSRespStatus readonly dispid 1745027075;
    property DeviceAction: GPSActionPending readonly dispid 1745027074;
    property Auto: WordBool dispid 1745027073;
    property AutoInterval: WideString dispid 1745027072;
    function OpenPort: GPSRespStatus; dispid 1610809379;
    function ClosePort: GPSRespStatus; dispid 1610809380;
  end;

// *********************************************************************//
// DispIntf:  __clsGlobalAPi
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {67549F2B-0B9D-4FF7-AC48-31D806811FA3}
// *********************************************************************//
  __clsGlobalAPi = dispinterface
    ['{67549F2B-0B9D-4FF7-AC48-31D806811FA3}']
    procedure UpDate(var eAction: GPSPinPadAction; var eResp: GPSRespStatus); dispid 1;
  end;

// *********************************************************************//
// The Class CoclsUtil provides a Create and CreateRemote method to          
// create instances of the default interface _clsUtil exposed by              
// the CoClass clsUtil. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoclsUtil = class
    class function Create: _clsUtil;
    class function CreateRemote(const MachineName: string): _clsUtil;
  end;

// *********************************************************************//
// The Class CoclsInteracReq provides a Create and CreateRemote method to          
// create instances of the default interface _clsInteracReq exposed by              
// the CoClass clsInteracReq. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoclsInteracReq = class
    class function Create: _clsInteracReq;
    class function CreateRemote(const MachineName: string): _clsInteracReq;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TPinSC550
// Help String      : 
// Default Interface: _PinSC550
// Def. Intf. DISP? : No
// Event   Interface: __PinSC550
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TPinSC550ActionUpdate = procedure(ASender: TObject; var eAction: GPSPinPadAction; 
                                                      var eResp: GPSRespStatus) of object;

  TPinSC550 = class(TOleControl)
  private
    FOnActionUpdate: TPinSC550ActionUpdate;
    FIntf: _PinSC550;
    function  GetControlInterface: _PinSC550;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ResponseCodeAsString(var eCode: GPSRespCode): WideString;
    function Get_ResponseAsString(var eCode: GPSRespStatus): WideString;
  public
    procedure OpenPort;
    procedure ClosePort;
    procedure Initialize;
    procedure GetSerialBlock;
    procedure StartMSR;
    procedure Cancel;
    procedure DispGenMsg(var szIDUpper: WideString; var szIDLower: WideString; 
                         var eLangCode: GPSLangCode);
    procedure DispObtainCard(var eLangCode: GPSLangCode);
    procedure RequestMAC(var szData: WideString);
    procedure InteracAnalysis(var szData: WideString; var eLangCode: GPSLangCode);
    procedure LoadKey(var szData: WideString);
    procedure RequestInterac(var szData: WideString; var eLangCode: GPSLangCode);
    procedure DispPrinterDown(var eLangCode: GPSLangCode);
    procedure DispBankResponse(var szBankCode: WideString; var szISOCode: WideString; 
                               var eLangCode: GPSLangCode);
    function Base64Encode(var szData: WideString): WideString;
    function Base64Decode(var szData: WideString): WideString;
    property  ControlInterface: _PinSC550 read GetControlInterface;
    property  DefaultInterface: _PinSC550 read GetControlInterface;
    property KeyType: TOleEnum index 1745027107 read GetTOleEnumProp;
    property PortState: TOleEnum index 1745027106 read GetTOleEnumProp;
    property DeviceData: WideString index 1745027099 read GetWideStringProp;
    property DeviceState: TOleEnum index 1745027094 read GetTOleEnumProp;
    property ActionPending: TOleEnum index 1745027093 read GetTOleEnumProp;
    property ResponseCodeAsString[var eCode: GPSRespCode]: WideString read Get_ResponseCodeAsString;
    property ResponseAsString[var eCode: GPSRespStatus]: WideString read Get_ResponseAsString;
    property LanguageCode: TOleEnum index 1745027090 read GetTOleEnumProp;
    property RespCode: TOleEnum index 1745027089 read GetTOleEnumProp;
    property BatchCode: WideString index 1745027088 read GetWideStringProp;
    property TrackII: WideString index 1745027087 read GetWideStringProp;
    property MacBlock: WideString index 1745027086 read GetWideStringProp;
    property Account: WideString index 1745027085 read GetWideStringProp;
    property PinBlock: WideString index 1745027084 read GetWideStringProp;
    property VFIBlock: WideString index 1745027083 read GetWideStringProp;
    property AppName: WideString index 1745027082 read GetWideStringProp;
    property KernelID: WideString index 1745027081 read GetWideStringProp;
    property ChipStatus: WideString index 1745027080 read GetWideStringProp;
    property PinPadType: WideString index 1745027079 read GetWideStringProp;
    property ROMVersion: WideString index 1745027078 read GetWideStringProp;
    property ProdData: WideString index 1745027077 read GetWideStringProp;
    property FacilityCode: WideString index 1745027076 read GetWideStringProp;
    property ChipSN: WideString index 1745027075 read GetWideStringProp;
    property FirmVersion: WideString index 1745027074 read GetWideStringProp;
    property RequireReMac: WordBool index 1745027073 read GetWordBoolProp;
    property ReMacData: WideString index 1745027072 read GetWideStringProp;
  published
    property Anchors;
    property CommVisible: WordBool index 1745027105 read GetWordBoolProp write SetWordBoolProp stored False;
    property TimeOut: WideString index 1745027104 read GetWideStringProp write SetWideStringProp stored False;
    property Baud: WideString index 1745027103 read GetWideStringProp write SetWideStringProp stored False;
    property Parity: WideString index 1745027102 read GetWideStringProp write SetWideStringProp stored False;
    property Port: WideString index 1745027101 read GetWideStringProp write SetWideStringProp stored False;
    property DataBits: WideString index 1745027100 read GetWideStringProp write SetWideStringProp stored False;
    property ServerPath: WideString index 1745027098 read GetWideStringProp write SetWideStringProp stored False;
    property AutoProcess: WordBool index 1745027097 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutoInterval: WideString index 1745027096 read GetWideStringProp write SetWideStringProp stored False;
    property DefaultLanguageCode: WideString index 1745027095 read GetWideStringProp write SetWideStringProp stored False;
    property OnActionUpdate: TPinSC550ActionUpdate read FOnActionUpdate write FOnActionUpdate;
  end;

// *********************************************************************//
// The Class CoclsGlobalAPi provides a Create and CreateRemote method to          
// create instances of the default interface _clsGlobalAPi exposed by              
// the CoClass clsGlobalAPi. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoclsGlobalAPi = class
    class function Create: _clsGlobalAPi;
    class function CreateRemote(const MachineName: string): _clsGlobalAPi;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoclsUtil.Create: _clsUtil;
begin
  Result := CreateComObject(CLASS_clsUtil) as _clsUtil;
end;

class function CoclsUtil.CreateRemote(const MachineName: string): _clsUtil;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_clsUtil) as _clsUtil;
end;

class function CoclsInteracReq.Create: _clsInteracReq;
begin
  Result := CreateComObject(CLASS_clsInteracReq) as _clsInteracReq;
end;

class function CoclsInteracReq.CreateRemote(const MachineName: string): _clsInteracReq;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_clsInteracReq) as _clsInteracReq;
end;

procedure TPinSC550.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CControlData: TControlData2 = (
    ClassID: '{5A954CEA-9C40-4CEC-8137-695B12082038}';
    EventIID: '{58DBA776-1B08-4BB5-87D9-8D630BEEE7B9}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnActionUpdate) - Cardinal(Self);
end;

procedure TPinSC550.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _PinSC550;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TPinSC550.GetControlInterface: _PinSC550;
begin
  CreateControl;
  Result := FIntf;
end;

function TPinSC550.Get_ResponseCodeAsString(var eCode: GPSRespCode): WideString;
begin
    Result := DefaultInterface.ResponseCodeAsString[eCode];
end;

function TPinSC550.Get_ResponseAsString(var eCode: GPSRespStatus): WideString;
begin
    Result := DefaultInterface.ResponseAsString[eCode];
end;

procedure TPinSC550.OpenPort;
begin
  DefaultInterface.OpenPort;
end;

procedure TPinSC550.ClosePort;
begin
  DefaultInterface.ClosePort;
end;

procedure TPinSC550.Initialize;
begin
  DefaultInterface.Initialize;
end;

procedure TPinSC550.GetSerialBlock;
begin
  DefaultInterface.GetSerialBlock;
end;

procedure TPinSC550.StartMSR;
begin
  DefaultInterface.StartMSR;
end;

procedure TPinSC550.Cancel;
begin
  DefaultInterface.Cancel;
end;

procedure TPinSC550.DispGenMsg(var szIDUpper: WideString; var szIDLower: WideString; 
                               var eLangCode: GPSLangCode);
begin
  DefaultInterface.DispGenMsg(szIDUpper, szIDLower, eLangCode);
end;

procedure TPinSC550.DispObtainCard(var eLangCode: GPSLangCode);
begin
  DefaultInterface.DispObtainCard(eLangCode);
end;

procedure TPinSC550.RequestMAC(var szData: WideString);
begin
  DefaultInterface.RequestMAC(szData);
end;

procedure TPinSC550.InteracAnalysis(var szData: WideString; var eLangCode: GPSLangCode);
begin
  DefaultInterface.InteracAnalysis(szData, eLangCode);
end;

procedure TPinSC550.LoadKey(var szData: WideString);
begin
  DefaultInterface.LoadKey(szData);
end;

procedure TPinSC550.RequestInterac(var szData: WideString; var eLangCode: GPSLangCode);
begin
  DefaultInterface.RequestInterac(szData, eLangCode);
end;

procedure TPinSC550.DispPrinterDown(var eLangCode: GPSLangCode);
begin
  DefaultInterface.DispPrinterDown(eLangCode);
end;

procedure TPinSC550.DispBankResponse(var szBankCode: WideString; var szISOCode: WideString; 
                                     var eLangCode: GPSLangCode);
begin
  DefaultInterface.DispBankResponse(szBankCode, szISOCode, eLangCode);
end;

function TPinSC550.Base64Encode(var szData: WideString): WideString;
begin
  Result := DefaultInterface.Base64Encode(szData);
end;

function TPinSC550.Base64Decode(var szData: WideString): WideString;
begin
  Result := DefaultInterface.Base64Decode(szData);
end;

class function CoclsGlobalAPi.Create: _clsGlobalAPi;
begin
  Result := CreateComObject(CLASS_clsGlobalAPi) as _clsGlobalAPi;
end;

class function CoclsGlobalAPi.CreateRemote(const MachineName: string): _clsGlobalAPi;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_clsGlobalAPi) as _clsGlobalAPi;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TPinSC550]);
end;

end.
