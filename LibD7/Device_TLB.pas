unit Device_TLB;

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
// File generated on 8/9/2007 1:40:04 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\kheira_m1\Desktop\libraries\Device.tlb (1)
// LIBID: {D9AF7B96-B679-4A2E-A88A-7207C10D78EA}
// LCID: 0
// Helpfile: C:\WINDOWS\system32\PCCDevKit.hlp
// HelpString: Verifone's Device ActiveX Control
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
  DeviceMajorVersion = 1;
  DeviceMinorVersion = 0;

  LIBID_Device: TGUID = '{D9AF7B96-B679-4A2E-A88A-7207C10D78EA}';

  IID__OCXDevice: TGUID = '{2089F0BB-F70E-4134-8189-27B01775B145}';
  DIID___OCXDevice: TGUID = '{5FC99A66-6737-47D1-8817-3281B954227C}';
  CLASS_OCXDevice: TGUID = '{AA0CC293-B10A-48DD-881F-179E3FDABE44}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum DeviceType
type
  DeviceType = TOleEnum;
const
  ppdVerifone_101 = $00000000;
  ppdIVICheckMate_2100 = $00000001;
  ppdVerifone_2000 = $00000002;
  ppdVerifone_Everest = $00000003;
  ppdVerifone_SC5000 = $00000004;
  ppdVeriFone_3730 = $00000005;

// Constants for enum PinPadManagement
type
  PinPadManagement = TOleEnum;
const
  ppmMasterSession = $00000000;
  ppmDUKPT = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _OCXDevice = interface;
  _OCXDeviceDisp = dispinterface;
  __OCXDevice = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  OCXDevice = _OCXDevice;


// *********************************************************************//
// Interface: _OCXDevice
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2089F0BB-F70E-4134-8189-27B01775B145}
// *********************************************************************//
  _OCXDevice = interface(IDispatch)
    ['{2089F0BB-F70E-4134-8189-27B01775B145}']
    procedure GhostMethod__OCXDevice_28_1; safecall;
    procedure GhostMethod__OCXDevice_32_2; safecall;
    procedure GhostMethod__OCXDevice_36_3; safecall;
    procedure GhostMethod__OCXDevice_40_4; safecall;
    procedure GhostMethod__OCXDevice_44_5; safecall;
    procedure GhostMethod__OCXDevice_48_6; safecall;
    procedure GhostMethod__OCXDevice_52_7; safecall;
    procedure GhostMethod__OCXDevice_56_8; safecall;
    procedure GhostMethod__OCXDevice_60_9; safecall;
    procedure GhostMethod__OCXDevice_64_10; safecall;
    procedure GhostMethod__OCXDevice_68_11; safecall;
    procedure GhostMethod__OCXDevice_72_12; safecall;
    procedure GhostMethod__OCXDevice_76_13; safecall;
    procedure GhostMethod__OCXDevice_80_14; safecall;
    procedure GhostMethod__OCXDevice_84_15; safecall;
    procedure GhostMethod__OCXDevice_88_16; safecall;
    procedure GhostMethod__OCXDevice_92_17; safecall;
    procedure GhostMethod__OCXDevice_96_18; safecall;
    procedure GhostMethod__OCXDevice_100_19; safecall;
    procedure GhostMethod__OCXDevice_104_20; safecall;
    procedure GhostMethod__OCXDevice_108_21; safecall;
    procedure GhostMethod__OCXDevice_112_22; safecall;
    procedure GhostMethod__OCXDevice_116_23; safecall;
    procedure GhostMethod__OCXDevice_120_24; safecall;
    procedure GhostMethod__OCXDevice_124_25; safecall;
    procedure GhostMethod__OCXDevice_128_26; safecall;
    procedure GhostMethod__OCXDevice_132_27; safecall;
    procedure GhostMethod__OCXDevice_136_28; safecall;
    procedure GhostMethod__OCXDevice_140_29; safecall;
    procedure GhostMethod__OCXDevice_144_30; safecall;
    procedure GhostMethod__OCXDevice_148_31; safecall;
    procedure GhostMethod__OCXDevice_152_32; safecall;
    procedure GhostMethod__OCXDevice_156_33; safecall;
    procedure GhostMethod__OCXDevice_160_34; safecall;
    procedure GhostMethod__OCXDevice_164_35; safecall;
    procedure GhostMethod__OCXDevice_168_36; safecall;
    procedure GhostMethod__OCXDevice_172_37; safecall;
    procedure GhostMethod__OCXDevice_176_38; safecall;
    procedure GhostMethod__OCXDevice_180_39; safecall;
    procedure GhostMethod__OCXDevice_184_40; safecall;
    procedure GhostMethod__OCXDevice_188_41; safecall;
    procedure GhostMethod__OCXDevice_192_42; safecall;
    procedure GhostMethod__OCXDevice_196_43; safecall;
    procedure GhostMethod__OCXDevice_200_44; safecall;
    procedure GhostMethod__OCXDevice_204_45; safecall;
    procedure GhostMethod__OCXDevice_208_46; safecall;
    procedure GhostMethod__OCXDevice_212_47; safecall;
    procedure GhostMethod__OCXDevice_216_48; safecall;
    procedure GhostMethod__OCXDevice_220_49; safecall;
    procedure GhostMethod__OCXDevice_224_50; safecall;
    procedure GhostMethod__OCXDevice_228_51; safecall;
    procedure GhostMethod__OCXDevice_232_52; safecall;
    procedure GhostMethod__OCXDevice_236_53; safecall;
    procedure GhostMethod__OCXDevice_240_54; safecall;
    procedure GhostMethod__OCXDevice_244_55; safecall;
    procedure GhostMethod__OCXDevice_248_56; safecall;
    procedure GhostMethod__OCXDevice_252_57; safecall;
    procedure GhostMethod__OCXDevice_256_58; safecall;
    procedure GhostMethod__OCXDevice_260_59; safecall;
    procedure GhostMethod__OCXDevice_264_60; safecall;
    procedure GhostMethod__OCXDevice_268_61; safecall;
    procedure GhostMethod__OCXDevice_272_62; safecall;
    procedure GhostMethod__OCXDevice_276_63; safecall;
    procedure GhostMethod__OCXDevice_280_64; safecall;
    procedure GhostMethod__OCXDevice_284_65; safecall;
    procedure GhostMethod__OCXDevice_288_66; safecall;
    procedure GhostMethod__OCXDevice_292_67; safecall;
    procedure GhostMethod__OCXDevice_296_68; safecall;
    procedure GhostMethod__OCXDevice_300_69; safecall;
    procedure GhostMethod__OCXDevice_304_70; safecall;
    procedure GhostMethod__OCXDevice_308_71; safecall;
    procedure GhostMethod__OCXDevice_312_72; safecall;
    procedure GhostMethod__OCXDevice_316_73; safecall;
    procedure GhostMethod__OCXDevice_320_74; safecall;
    procedure GhostMethod__OCXDevice_324_75; safecall;
    procedure GhostMethod__OCXDevice_328_76; safecall;
    procedure GhostMethod__OCXDevice_332_77; safecall;
    procedure GhostMethod__OCXDevice_336_78; safecall;
    procedure GhostMethod__OCXDevice_340_79; safecall;
    procedure GhostMethod__OCXDevice_344_80; safecall;
    procedure GhostMethod__OCXDevice_348_81; safecall;
    procedure GhostMethod__OCXDevice_352_82; safecall;
    procedure GhostMethod__OCXDevice_356_83; safecall;
    procedure GhostMethod__OCXDevice_360_84; safecall;
    procedure GhostMethod__OCXDevice_364_85; safecall;
    procedure GhostMethod__OCXDevice_368_86; safecall;
    procedure GhostMethod__OCXDevice_372_87; safecall;
    procedure GhostMethod__OCXDevice_376_88; safecall;
    procedure GhostMethod__OCXDevice_380_89; safecall;
    procedure GhostMethod__OCXDevice_384_90; safecall;
    procedure GhostMethod__OCXDevice_388_91; safecall;
    procedure GhostMethod__OCXDevice_392_92; safecall;
    procedure GhostMethod__OCXDevice_396_93; safecall;
    procedure GhostMethod__OCXDevice_400_94; safecall;
    procedure GhostMethod__OCXDevice_404_95; safecall;
    procedure GhostMethod__OCXDevice_408_96; safecall;
    procedure GhostMethod__OCXDevice_412_97; safecall;
    procedure GhostMethod__OCXDevice_416_98; safecall;
    procedure GhostMethod__OCXDevice_420_99; safecall;
    procedure GhostMethod__OCXDevice_424_100; safecall;
    procedure GhostMethod__OCXDevice_428_101; safecall;
    procedure GhostMethod__OCXDevice_432_102; safecall;
    procedure GhostMethod__OCXDevice_436_103; safecall;
    procedure GhostMethod__OCXDevice_440_104; safecall;
    procedure GhostMethod__OCXDevice_444_105; safecall;
    procedure GhostMethod__OCXDevice_448_106; safecall;
    procedure GhostMethod__OCXDevice_452_107; safecall;
    procedure GhostMethod__OCXDevice_456_108; safecall;
    procedure GhostMethod__OCXDevice_460_109; safecall;
    procedure GhostMethod__OCXDevice_464_110; safecall;
    procedure GhostMethod__OCXDevice_468_111; safecall;
    procedure GhostMethod__OCXDevice_472_112; safecall;
    procedure GhostMethod__OCXDevice_476_113; safecall;
    procedure GhostMethod__OCXDevice_480_114; safecall;
    procedure GhostMethod__OCXDevice_484_115; safecall;
    procedure GhostMethod__OCXDevice_488_116; safecall;
    procedure GhostMethod__OCXDevice_492_117; safecall;
    procedure GhostMethod__OCXDevice_496_118; safecall;
    procedure GhostMethod__OCXDevice_500_119; safecall;
    procedure GhostMethod__OCXDevice_504_120; safecall;
    procedure GhostMethod__OCXDevice_508_121; safecall;
    procedure GhostMethod__OCXDevice_512_122; safecall;
    procedure GhostMethod__OCXDevice_516_123; safecall;
    procedure GhostMethod__OCXDevice_520_124; safecall;
    procedure GhostMethod__OCXDevice_524_125; safecall;
    procedure GhostMethod__OCXDevice_528_126; safecall;
    procedure GhostMethod__OCXDevice_532_127; safecall;
    procedure GhostMethod__OCXDevice_536_128; safecall;
    procedure GhostMethod__OCXDevice_540_129; safecall;
    procedure GhostMethod__OCXDevice_544_130; safecall;
    procedure GhostMethod__OCXDevice_548_131; safecall;
    procedure GhostMethod__OCXDevice_552_132; safecall;
    procedure GhostMethod__OCXDevice_556_133; safecall;
    procedure GhostMethod__OCXDevice_560_134; safecall;
    procedure GhostMethod__OCXDevice_564_135; safecall;
    procedure GhostMethod__OCXDevice_568_136; safecall;
    procedure GhostMethod__OCXDevice_572_137; safecall;
    procedure GhostMethod__OCXDevice_576_138; safecall;
    procedure GhostMethod__OCXDevice_580_139; safecall;
    procedure GhostMethod__OCXDevice_584_140; safecall;
    procedure GhostMethod__OCXDevice_588_141; safecall;
    procedure GhostMethod__OCXDevice_592_142; safecall;
    procedure GhostMethod__OCXDevice_596_143; safecall;
    procedure GhostMethod__OCXDevice_600_144; safecall;
    procedure GhostMethod__OCXDevice_604_145; safecall;
    procedure GhostMethod__OCXDevice_608_146; safecall;
    procedure GhostMethod__OCXDevice_612_147; safecall;
    procedure GhostMethod__OCXDevice_616_148; safecall;
    procedure GhostMethod__OCXDevice_620_149; safecall;
    procedure GhostMethod__OCXDevice_624_150; safecall;
    procedure GhostMethod__OCXDevice_628_151; safecall;
    procedure GhostMethod__OCXDevice_632_152; safecall;
    procedure GhostMethod__OCXDevice_636_153; safecall;
    procedure GhostMethod__OCXDevice_640_154; safecall;
    procedure GhostMethod__OCXDevice_644_155; safecall;
    procedure GhostMethod__OCXDevice_648_156; safecall;
    procedure GhostMethod__OCXDevice_652_157; safecall;
    procedure GhostMethod__OCXDevice_656_158; safecall;
    procedure GhostMethod__OCXDevice_660_159; safecall;
    procedure GhostMethod__OCXDevice_664_160; safecall;
    procedure GhostMethod__OCXDevice_668_161; safecall;
    procedure GhostMethod__OCXDevice_672_162; safecall;
    procedure GhostMethod__OCXDevice_676_163; safecall;
    procedure GhostMethod__OCXDevice_680_164; safecall;
    procedure GhostMethod__OCXDevice_684_165; safecall;
    procedure GhostMethod__OCXDevice_688_166; safecall;
    procedure GhostMethod__OCXDevice_692_167; safecall;
    procedure GhostMethod__OCXDevice_696_168; safecall;
    procedure GhostMethod__OCXDevice_700_169; safecall;
    procedure GhostMethod__OCXDevice_704_170; safecall;
    procedure GhostMethod__OCXDevice_708_171; safecall;
    procedure GhostMethod__OCXDevice_712_172; safecall;
    procedure GhostMethod__OCXDevice_716_173; safecall;
    procedure GhostMethod__OCXDevice_720_174; safecall;
    procedure GhostMethod__OCXDevice_724_175; safecall;
    procedure GhostMethod__OCXDevice_728_176; safecall;
    procedure GhostMethod__OCXDevice_732_177; safecall;
    procedure GhostMethod__OCXDevice_736_178; safecall;
    procedure GhostMethod__OCXDevice_740_179; safecall;
    procedure GhostMethod__OCXDevice_744_180; safecall;
    procedure GhostMethod__OCXDevice_748_181; safecall;
    procedure GhostMethod__OCXDevice_752_182; safecall;
    procedure GhostMethod__OCXDevice_756_183; safecall;
    procedure GhostMethod__OCXDevice_760_184; safecall;
    procedure GhostMethod__OCXDevice_764_185; safecall;
    procedure GhostMethod__OCXDevice_768_186; safecall;
    procedure GhostMethod__OCXDevice_772_187; safecall;
    procedure GhostMethod__OCXDevice_776_188; safecall;
    procedure GhostMethod__OCXDevice_780_189; safecall;
    procedure GhostMethod__OCXDevice_784_190; safecall;
    procedure GhostMethod__OCXDevice_788_191; safecall;
    procedure GhostMethod__OCXDevice_792_192; safecall;
    procedure GhostMethod__OCXDevice_796_193; safecall;
    procedure GhostMethod__OCXDevice_800_194; safecall;
    procedure GhostMethod__OCXDevice_804_195; safecall;
    procedure GhostMethod__OCXDevice_808_196; safecall;
    procedure GhostMethod__OCXDevice_812_197; safecall;
    procedure GhostMethod__OCXDevice_816_198; safecall;
    procedure GhostMethod__OCXDevice_820_199; safecall;
    procedure GhostMethod__OCXDevice_824_200; safecall;
    procedure GhostMethod__OCXDevice_828_201; safecall;
    procedure GhostMethod__OCXDevice_832_202; safecall;
    procedure GhostMethod__OCXDevice_836_203; safecall;
    procedure GhostMethod__OCXDevice_840_204; safecall;
    procedure GhostMethod__OCXDevice_844_205; safecall;
    procedure GhostMethod__OCXDevice_848_206; safecall;
    procedure GhostMethod__OCXDevice_852_207; safecall;
    procedure GhostMethod__OCXDevice_856_208; safecall;
    procedure GhostMethod__OCXDevice_860_209; safecall;
    procedure GhostMethod__OCXDevice_864_210; safecall;
    procedure GhostMethod__OCXDevice_868_211; safecall;
    procedure GhostMethod__OCXDevice_872_212; safecall;
    procedure GhostMethod__OCXDevice_876_213; safecall;
    procedure GhostMethod__OCXDevice_880_214; safecall;
    procedure GhostMethod__OCXDevice_884_215; safecall;
    procedure GhostMethod__OCXDevice_888_216; safecall;
    procedure GhostMethod__OCXDevice_892_217; safecall;
    procedure GhostMethod__OCXDevice_896_218; safecall;
    procedure GhostMethod__OCXDevice_900_219; safecall;
    procedure GhostMethod__OCXDevice_904_220; safecall;
    procedure GhostMethod__OCXDevice_908_221; safecall;
    procedure GhostMethod__OCXDevice_912_222; safecall;
    procedure GhostMethod__OCXDevice_916_223; safecall;
    procedure GhostMethod__OCXDevice_920_224; safecall;
    procedure GhostMethod__OCXDevice_924_225; safecall;
    procedure GhostMethod__OCXDevice_928_226; safecall;
    procedure GhostMethod__OCXDevice_932_227; safecall;
    procedure GhostMethod__OCXDevice_936_228; safecall;
    procedure GhostMethod__OCXDevice_940_229; safecall;
    procedure GhostMethod__OCXDevice_944_230; safecall;
    procedure GhostMethod__OCXDevice_948_231; safecall;
    procedure GhostMethod__OCXDevice_952_232; safecall;
    procedure GhostMethod__OCXDevice_956_233; safecall;
    procedure GhostMethod__OCXDevice_960_234; safecall;
    procedure GhostMethod__OCXDevice_964_235; safecall;
    procedure GhostMethod__OCXDevice_968_236; safecall;
    procedure GhostMethod__OCXDevice_972_237; safecall;
    procedure GhostMethod__OCXDevice_976_238; safecall;
    procedure GhostMethod__OCXDevice_980_239; safecall;
    procedure GhostMethod__OCXDevice_984_240; safecall;
    procedure GhostMethod__OCXDevice_988_241; safecall;
    procedure GhostMethod__OCXDevice_992_242; safecall;
    procedure GhostMethod__OCXDevice_996_243; safecall;
    procedure GhostMethod__OCXDevice_1000_244; safecall;
    procedure GhostMethod__OCXDevice_1004_245; safecall;
    procedure GhostMethod__OCXDevice_1008_246; safecall;
    procedure GhostMethod__OCXDevice_1012_247; safecall;
    procedure GhostMethod__OCXDevice_1016_248; safecall;
    procedure GhostMethod__OCXDevice_1020_249; safecall;
    procedure GhostMethod__OCXDevice_1024_250; safecall;
    procedure GhostMethod__OCXDevice_1028_251; safecall;
    procedure GhostMethod__OCXDevice_1032_252; safecall;
    procedure GhostMethod__OCXDevice_1036_253; safecall;
    procedure GhostMethod__OCXDevice_1040_254; safecall;
    procedure GhostMethod__OCXDevice_1044_255; safecall;
    procedure GhostMethod__OCXDevice_1048_256; safecall;
    procedure GhostMethod__OCXDevice_1052_257; safecall;
    procedure GhostMethod__OCXDevice_1056_258; safecall;
    procedure GhostMethod__OCXDevice_1060_259; safecall;
    procedure GhostMethod__OCXDevice_1064_260; safecall;
    procedure GhostMethod__OCXDevice_1068_261; safecall;
    procedure GhostMethod__OCXDevice_1072_262; safecall;
    procedure GhostMethod__OCXDevice_1076_263; safecall;
    procedure GhostMethod__OCXDevice_1080_264; safecall;
    procedure GhostMethod__OCXDevice_1084_265; safecall;
    procedure GhostMethod__OCXDevice_1088_266; safecall;
    procedure GhostMethod__OCXDevice_1092_267; safecall;
    procedure GhostMethod__OCXDevice_1096_268; safecall;
    procedure GhostMethod__OCXDevice_1100_269; safecall;
    procedure GhostMethod__OCXDevice_1104_270; safecall;
    procedure GhostMethod__OCXDevice_1108_271; safecall;
    procedure GhostMethod__OCXDevice_1112_272; safecall;
    procedure GhostMethod__OCXDevice_1116_273; safecall;
    procedure GhostMethod__OCXDevice_1120_274; safecall;
    procedure GhostMethod__OCXDevice_1124_275; safecall;
    procedure GhostMethod__OCXDevice_1128_276; safecall;
    procedure GhostMethod__OCXDevice_1132_277; safecall;
    procedure GhostMethod__OCXDevice_1136_278; safecall;
    procedure GhostMethod__OCXDevice_1140_279; safecall;
    procedure GhostMethod__OCXDevice_1144_280; safecall;
    procedure GhostMethod__OCXDevice_1148_281; safecall;
    procedure GhostMethod__OCXDevice_1152_282; safecall;
    procedure GhostMethod__OCXDevice_1156_283; safecall;
    procedure GhostMethod__OCXDevice_1160_284; safecall;
    procedure GhostMethod__OCXDevice_1164_285; safecall;
    procedure GhostMethod__OCXDevice_1168_286; safecall;
    procedure GhostMethod__OCXDevice_1172_287; safecall;
    procedure GhostMethod__OCXDevice_1176_288; safecall;
    procedure GhostMethod__OCXDevice_1180_289; safecall;
    procedure GhostMethod__OCXDevice_1184_290; safecall;
    procedure GhostMethod__OCXDevice_1188_291; safecall;
    procedure GhostMethod__OCXDevice_1192_292; safecall;
    procedure GhostMethod__OCXDevice_1196_293; safecall;
    procedure GhostMethod__OCXDevice_1200_294; safecall;
    procedure GhostMethod__OCXDevice_1204_295; safecall;
    procedure GhostMethod__OCXDevice_1208_296; safecall;
    procedure GhostMethod__OCXDevice_1212_297; safecall;
    procedure GhostMethod__OCXDevice_1216_298; safecall;
    procedure GhostMethod__OCXDevice_1220_299; safecall;
    procedure GhostMethod__OCXDevice_1224_300; safecall;
    procedure GhostMethod__OCXDevice_1228_301; safecall;
    procedure GhostMethod__OCXDevice_1232_302; safecall;
    procedure GhostMethod__OCXDevice_1236_303; safecall;
    procedure GhostMethod__OCXDevice_1240_304; safecall;
    procedure GhostMethod__OCXDevice_1244_305; safecall;
    procedure GhostMethod__OCXDevice_1248_306; safecall;
    procedure GhostMethod__OCXDevice_1252_307; safecall;
    procedure GhostMethod__OCXDevice_1256_308; safecall;
    procedure GhostMethod__OCXDevice_1260_309; safecall;
    procedure GhostMethod__OCXDevice_1264_310; safecall;
    procedure GhostMethod__OCXDevice_1268_311; safecall;
    procedure GhostMethod__OCXDevice_1272_312; safecall;
    procedure GhostMethod__OCXDevice_1276_313; safecall;
    procedure GhostMethod__OCXDevice_1280_314; safecall;
    procedure GhostMethod__OCXDevice_1284_315; safecall;
    procedure GhostMethod__OCXDevice_1288_316; safecall;
    procedure GhostMethod__OCXDevice_1292_317; safecall;
    procedure GhostMethod__OCXDevice_1296_318; safecall;
    procedure GhostMethod__OCXDevice_1300_319; safecall;
    procedure GhostMethod__OCXDevice_1304_320; safecall;
    procedure GhostMethod__OCXDevice_1308_321; safecall;
    procedure GhostMethod__OCXDevice_1312_322; safecall;
    procedure GhostMethod__OCXDevice_1316_323; safecall;
    procedure GhostMethod__OCXDevice_1320_324; safecall;
    procedure GhostMethod__OCXDevice_1324_325; safecall;
    procedure GhostMethod__OCXDevice_1328_326; safecall;
    procedure GhostMethod__OCXDevice_1332_327; safecall;
    procedure GhostMethod__OCXDevice_1336_328; safecall;
    procedure GhostMethod__OCXDevice_1340_329; safecall;
    procedure GhostMethod__OCXDevice_1344_330; safecall;
    procedure GhostMethod__OCXDevice_1348_331; safecall;
    procedure GhostMethod__OCXDevice_1352_332; safecall;
    procedure GhostMethod__OCXDevice_1356_333; safecall;
    procedure GhostMethod__OCXDevice_1360_334; safecall;
    procedure GhostMethod__OCXDevice_1364_335; safecall;
    procedure GhostMethod__OCXDevice_1368_336; safecall;
    procedure GhostMethod__OCXDevice_1372_337; safecall;
    procedure GhostMethod__OCXDevice_1376_338; safecall;
    procedure GhostMethod__OCXDevice_1380_339; safecall;
    procedure GhostMethod__OCXDevice_1384_340; safecall;
    procedure GhostMethod__OCXDevice_1388_341; safecall;
    procedure GhostMethod__OCXDevice_1392_342; safecall;
    procedure GhostMethod__OCXDevice_1396_343; safecall;
    procedure GhostMethod__OCXDevice_1400_344; safecall;
    procedure GhostMethod__OCXDevice_1404_345; safecall;
    procedure GhostMethod__OCXDevice_1408_346; safecall;
    procedure GhostMethod__OCXDevice_1412_347; safecall;
    procedure GhostMethod__OCXDevice_1416_348; safecall;
    procedure GhostMethod__OCXDevice_1420_349; safecall;
    procedure GhostMethod__OCXDevice_1424_350; safecall;
    procedure GhostMethod__OCXDevice_1428_351; safecall;
    procedure GhostMethod__OCXDevice_1432_352; safecall;
    procedure GhostMethod__OCXDevice_1436_353; safecall;
    procedure GhostMethod__OCXDevice_1440_354; safecall;
    procedure GhostMethod__OCXDevice_1444_355; safecall;
    procedure GhostMethod__OCXDevice_1448_356; safecall;
    procedure GhostMethod__OCXDevice_1452_357; safecall;
    procedure GhostMethod__OCXDevice_1456_358; safecall;
    procedure GhostMethod__OCXDevice_1460_359; safecall;
    procedure GhostMethod__OCXDevice_1464_360; safecall;
    procedure GhostMethod__OCXDevice_1468_361; safecall;
    procedure GhostMethod__OCXDevice_1472_362; safecall;
    procedure GhostMethod__OCXDevice_1476_363; safecall;
    procedure GhostMethod__OCXDevice_1480_364; safecall;
    procedure GhostMethod__OCXDevice_1484_365; safecall;
    procedure GhostMethod__OCXDevice_1488_366; safecall;
    procedure GhostMethod__OCXDevice_1492_367; safecall;
    procedure GhostMethod__OCXDevice_1496_368; safecall;
    procedure GhostMethod__OCXDevice_1500_369; safecall;
    procedure GhostMethod__OCXDevice_1504_370; safecall;
    procedure GhostMethod__OCXDevice_1508_371; safecall;
    procedure GhostMethod__OCXDevice_1512_372; safecall;
    procedure GhostMethod__OCXDevice_1516_373; safecall;
    procedure GhostMethod__OCXDevice_1520_374; safecall;
    procedure GhostMethod__OCXDevice_1524_375; safecall;
    procedure GhostMethod__OCXDevice_1528_376; safecall;
    procedure GhostMethod__OCXDevice_1532_377; safecall;
    procedure GhostMethod__OCXDevice_1536_378; safecall;
    procedure GhostMethod__OCXDevice_1540_379; safecall;
    procedure GhostMethod__OCXDevice_1544_380; safecall;
    procedure GhostMethod__OCXDevice_1548_381; safecall;
    procedure GhostMethod__OCXDevice_1552_382; safecall;
    procedure GhostMethod__OCXDevice_1556_383; safecall;
    procedure GhostMethod__OCXDevice_1560_384; safecall;
    procedure GhostMethod__OCXDevice_1564_385; safecall;
    procedure GhostMethod__OCXDevice_1568_386; safecall;
    procedure GhostMethod__OCXDevice_1572_387; safecall;
    procedure GhostMethod__OCXDevice_1576_388; safecall;
    procedure GhostMethod__OCXDevice_1580_389; safecall;
    procedure GhostMethod__OCXDevice_1584_390; safecall;
    procedure GhostMethod__OCXDevice_1588_391; safecall;
    procedure GhostMethod__OCXDevice_1592_392; safecall;
    procedure GhostMethod__OCXDevice_1596_393; safecall;
    procedure GhostMethod__OCXDevice_1600_394; safecall;
    procedure GhostMethod__OCXDevice_1604_395; safecall;
    procedure GhostMethod__OCXDevice_1608_396; safecall;
    procedure GhostMethod__OCXDevice_1612_397; safecall;
    procedure GhostMethod__OCXDevice_1616_398; safecall;
    procedure GhostMethod__OCXDevice_1620_399; safecall;
    procedure GhostMethod__OCXDevice_1624_400; safecall;
    procedure GhostMethod__OCXDevice_1628_401; safecall;
    procedure GhostMethod__OCXDevice_1632_402; safecall;
    procedure GhostMethod__OCXDevice_1636_403; safecall;
    procedure GhostMethod__OCXDevice_1640_404; safecall;
    procedure GhostMethod__OCXDevice_1644_405; safecall;
    procedure GhostMethod__OCXDevice_1648_406; safecall;
    procedure GhostMethod__OCXDevice_1652_407; safecall;
    procedure GhostMethod__OCXDevice_1656_408; safecall;
    procedure GhostMethod__OCXDevice_1660_409; safecall;
    procedure GhostMethod__OCXDevice_1664_410; safecall;
    procedure GhostMethod__OCXDevice_1668_411; safecall;
    procedure GhostMethod__OCXDevice_1672_412; safecall;
    procedure GhostMethod__OCXDevice_1676_413; safecall;
    procedure GhostMethod__OCXDevice_1680_414; safecall;
    procedure GhostMethod__OCXDevice_1684_415; safecall;
    procedure GhostMethod__OCXDevice_1688_416; safecall;
    procedure GhostMethod__OCXDevice_1692_417; safecall;
    procedure GhostMethod__OCXDevice_1696_418; safecall;
    procedure GhostMethod__OCXDevice_1700_419; safecall;
    procedure GhostMethod__OCXDevice_1704_420; safecall;
    procedure GhostMethod__OCXDevice_1708_421; safecall;
    procedure GhostMethod__OCXDevice_1712_422; safecall;
    procedure GhostMethod__OCXDevice_1716_423; safecall;
    procedure GhostMethod__OCXDevice_1720_424; safecall;
    procedure GhostMethod__OCXDevice_1724_425; safecall;
    procedure GhostMethod__OCXDevice_1728_426; safecall;
    procedure GhostMethod__OCXDevice_1732_427; safecall;
    procedure GhostMethod__OCXDevice_1736_428; safecall;
    procedure GhostMethod__OCXDevice_1740_429; safecall;
    procedure GhostMethod__OCXDevice_1744_430; safecall;
    procedure GhostMethod__OCXDevice_1748_431; safecall;
    procedure GhostMethod__OCXDevice_1752_432; safecall;
    procedure GhostMethod__OCXDevice_1756_433; safecall;
    procedure GhostMethod__OCXDevice_1760_434; safecall;
    procedure GhostMethod__OCXDevice_1764_435; safecall;
    procedure GhostMethod__OCXDevice_1768_436; safecall;
    procedure GhostMethod__OCXDevice_1772_437; safecall;
    procedure GhostMethod__OCXDevice_1776_438; safecall;
    procedure GhostMethod__OCXDevice_1780_439; safecall;
    procedure GhostMethod__OCXDevice_1784_440; safecall;
    procedure GhostMethod__OCXDevice_1788_441; safecall;
    procedure GhostMethod__OCXDevice_1792_442; safecall;
    procedure GhostMethod__OCXDevice_1796_443; safecall;
    procedure GhostMethod__OCXDevice_1800_444; safecall;
    procedure GhostMethod__OCXDevice_1804_445; safecall;
    procedure GhostMethod__OCXDevice_1808_446; safecall;
    procedure GhostMethod__OCXDevice_1812_447; safecall;
    procedure GhostMethod__OCXDevice_1816_448; safecall;
    procedure GhostMethod__OCXDevice_1820_449; safecall;
    procedure GhostMethod__OCXDevice_1824_450; safecall;
    procedure GhostMethod__OCXDevice_1828_451; safecall;
    procedure GhostMethod__OCXDevice_1832_452; safecall;
    procedure GhostMethod__OCXDevice_1836_453; safecall;
    procedure GhostMethod__OCXDevice_1840_454; safecall;
    procedure GhostMethod__OCXDevice_1844_455; safecall;
    procedure GhostMethod__OCXDevice_1848_456; safecall;
    procedure GhostMethod__OCXDevice_1852_457; safecall;
    procedure GhostMethod__OCXDevice_1856_458; safecall;
    procedure GhostMethod__OCXDevice_1860_459; safecall;
    procedure GhostMethod__OCXDevice_1864_460; safecall;
    procedure GhostMethod__OCXDevice_1868_461; safecall;
    procedure GhostMethod__OCXDevice_1872_462; safecall;
    procedure GhostMethod__OCXDevice_1876_463; safecall;
    procedure GhostMethod__OCXDevice_1880_464; safecall;
    procedure GhostMethod__OCXDevice_1884_465; safecall;
    procedure GhostMethod__OCXDevice_1888_466; safecall;
    procedure GhostMethod__OCXDevice_1892_467; safecall;
    procedure GhostMethod__OCXDevice_1896_468; safecall;
    procedure GhostMethod__OCXDevice_1900_469; safecall;
    procedure GhostMethod__OCXDevice_1904_470; safecall;
    procedure GhostMethod__OCXDevice_1908_471; safecall;
    procedure GhostMethod__OCXDevice_1912_472; safecall;
    procedure GhostMethod__OCXDevice_1916_473; safecall;
    procedure GhostMethod__OCXDevice_1920_474; safecall;
    procedure GhostMethod__OCXDevice_1924_475; safecall;
    procedure GhostMethod__OCXDevice_1928_476; safecall;
    procedure GhostMethod__OCXDevice_1932_477; safecall;
    procedure GhostMethod__OCXDevice_1936_478; safecall;
    procedure GhostMethod__OCXDevice_1940_479; safecall;
    procedure GhostMethod__OCXDevice_1944_480; safecall;
    procedure GhostMethod__OCXDevice_1948_481; safecall;
    procedure GhostMethod__OCXDevice_1952_482; safecall;
    function About: OleVariant; safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Param1: WideString); safecall;
    function Get_Baud: WideString; safecall;
    procedure Set_Baud(const Param1: WideString); safecall;
    function Get_Device: DeviceType; safecall;
    procedure Set_Device(Param1: DeviceType); safecall;
    function Get_Parity: WideString; safecall;
    procedure Set_Parity(const Param1: WideString); safecall;
    function Get_DataBits: WideString; safecall;
    procedure Set_DataBits(const Param1: WideString); safecall;
    function Get_DisplayString: WideString; safecall;
    procedure Set_DisplayString(const Param1: WideString); safecall;
    function Get_Card: WideString; safecall;
    procedure Set_Card(const Param1: WideString); safecall;
    function Get_Amount: WideString; safecall;
    procedure Set_Amount(const Param1: WideString); safecall;
    function Get_EncryptMethod: PinPadManagement; safecall;
    procedure Set_EncryptMethod(Param1: PinPadManagement); safecall;
    function Get_WorkingKey: WideString; safecall;
    procedure Set_WorkingKey(const Param1: WideString); safecall;
    function Get_MasterKey: Smallint; safecall;
    procedure Set_MasterKey(Param1: Smallint); safecall;
    function Get_Demo: WordBool; safecall;
    procedure Set_Demo(Param1: WordBool); safecall;
    function Get_TimeOut: Integer; safecall;
    procedure Set_TimeOut(Param1: Integer); safecall;
    function Get_DefaultMessage: WideString; safecall;
    procedure Set_DefaultMessage(const Param1: WideString); safecall;
    function Initialize(blnCheckPort: WordBool): WordBool; safecall;
    function GetPin: WideString; safecall;
    function Cancel: WordBool; safecall;
    function Clear: WordBool; safecall;
    function RefreshDisplay: WordBool; safecall;
    function GetCardSwipe: WordBool; safecall;
    function PrintReceipt(var strprint: WideString): WideString; safecall;
    function GetKeySerialNumber: WideString; safecall;
    function GetErrorCode: Integer; safecall;
    function GetErrorDesc: WideString; safecall;
    function GetCard: WideString; safecall;
    function GetMember: WideString; safecall;
    function GetExpDate: WideString; safecall;
    function GetTrack1: WideString; safecall;
    function GetTrack2: WideString; safecall;
    function GetTrack3: WideString; safecall;
    function StartMSR: OleVariant; safecall;
    function EnablePin: OleVariant; safecall;
    function ShutdownApp: OleVariant; safecall;
    property Port: WideString read Get_Port write Set_Port;
    property Baud: WideString read Get_Baud write Set_Baud;
    property Device: DeviceType read Get_Device write Set_Device;
    property Parity: WideString read Get_Parity write Set_Parity;
    property DataBits: WideString read Get_DataBits write Set_DataBits;
    property DisplayString: WideString read Get_DisplayString write Set_DisplayString;
    property Card: WideString read Get_Card write Set_Card;
    property Amount: WideString read Get_Amount write Set_Amount;
    property EncryptMethod: PinPadManagement read Get_EncryptMethod write Set_EncryptMethod;
    property WorkingKey: WideString read Get_WorkingKey write Set_WorkingKey;
    property MasterKey: Smallint read Get_MasterKey write Set_MasterKey;
    property Demo: WordBool read Get_Demo write Set_Demo;
    property TimeOut: Integer read Get_TimeOut write Set_TimeOut;
    property DefaultMessage: WideString read Get_DefaultMessage write Set_DefaultMessage;
  end;

// *********************************************************************//
// DispIntf:  _OCXDeviceDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2089F0BB-F70E-4134-8189-27B01775B145}
// *********************************************************************//
  _OCXDeviceDisp = dispinterface
    ['{2089F0BB-F70E-4134-8189-27B01775B145}']
    procedure GhostMethod__OCXDevice_28_1; dispid 1610743808;
    procedure GhostMethod__OCXDevice_32_2; dispid 1610743809;
    procedure GhostMethod__OCXDevice_36_3; dispid 1610743810;
    procedure GhostMethod__OCXDevice_40_4; dispid 1610743811;
    procedure GhostMethod__OCXDevice_44_5; dispid 1610743812;
    procedure GhostMethod__OCXDevice_48_6; dispid 1610743813;
    procedure GhostMethod__OCXDevice_52_7; dispid 1610743814;
    procedure GhostMethod__OCXDevice_56_8; dispid 1610743815;
    procedure GhostMethod__OCXDevice_60_9; dispid 1610743816;
    procedure GhostMethod__OCXDevice_64_10; dispid 1610743817;
    procedure GhostMethod__OCXDevice_68_11; dispid 1610743818;
    procedure GhostMethod__OCXDevice_72_12; dispid 1610743819;
    procedure GhostMethod__OCXDevice_76_13; dispid 1610743820;
    procedure GhostMethod__OCXDevice_80_14; dispid 1610743821;
    procedure GhostMethod__OCXDevice_84_15; dispid 1610743822;
    procedure GhostMethod__OCXDevice_88_16; dispid 1610743823;
    procedure GhostMethod__OCXDevice_92_17; dispid 1610743824;
    procedure GhostMethod__OCXDevice_96_18; dispid 1610743825;
    procedure GhostMethod__OCXDevice_100_19; dispid 1610743826;
    procedure GhostMethod__OCXDevice_104_20; dispid 1610743827;
    procedure GhostMethod__OCXDevice_108_21; dispid 1610743828;
    procedure GhostMethod__OCXDevice_112_22; dispid 1610743829;
    procedure GhostMethod__OCXDevice_116_23; dispid 1610743830;
    procedure GhostMethod__OCXDevice_120_24; dispid 1610743831;
    procedure GhostMethod__OCXDevice_124_25; dispid 1610743832;
    procedure GhostMethod__OCXDevice_128_26; dispid 1610743833;
    procedure GhostMethod__OCXDevice_132_27; dispid 1610743834;
    procedure GhostMethod__OCXDevice_136_28; dispid 1610743835;
    procedure GhostMethod__OCXDevice_140_29; dispid 1610743836;
    procedure GhostMethod__OCXDevice_144_30; dispid 1610743837;
    procedure GhostMethod__OCXDevice_148_31; dispid 1610743838;
    procedure GhostMethod__OCXDevice_152_32; dispid 1610743839;
    procedure GhostMethod__OCXDevice_156_33; dispid 1610743840;
    procedure GhostMethod__OCXDevice_160_34; dispid 1610743841;
    procedure GhostMethod__OCXDevice_164_35; dispid 1610743842;
    procedure GhostMethod__OCXDevice_168_36; dispid 1610743843;
    procedure GhostMethod__OCXDevice_172_37; dispid 1610743844;
    procedure GhostMethod__OCXDevice_176_38; dispid 1610743845;
    procedure GhostMethod__OCXDevice_180_39; dispid 1610743846;
    procedure GhostMethod__OCXDevice_184_40; dispid 1610743847;
    procedure GhostMethod__OCXDevice_188_41; dispid 1610743848;
    procedure GhostMethod__OCXDevice_192_42; dispid 1610743849;
    procedure GhostMethod__OCXDevice_196_43; dispid 1610743850;
    procedure GhostMethod__OCXDevice_200_44; dispid 1610743851;
    procedure GhostMethod__OCXDevice_204_45; dispid 1610743852;
    procedure GhostMethod__OCXDevice_208_46; dispid 1610743853;
    procedure GhostMethod__OCXDevice_212_47; dispid 1610743854;
    procedure GhostMethod__OCXDevice_216_48; dispid 1610743855;
    procedure GhostMethod__OCXDevice_220_49; dispid 1610743856;
    procedure GhostMethod__OCXDevice_224_50; dispid 1610743857;
    procedure GhostMethod__OCXDevice_228_51; dispid 1610743858;
    procedure GhostMethod__OCXDevice_232_52; dispid 1610743859;
    procedure GhostMethod__OCXDevice_236_53; dispid 1610743860;
    procedure GhostMethod__OCXDevice_240_54; dispid 1610743861;
    procedure GhostMethod__OCXDevice_244_55; dispid 1610743862;
    procedure GhostMethod__OCXDevice_248_56; dispid 1610743863;
    procedure GhostMethod__OCXDevice_252_57; dispid 1610743864;
    procedure GhostMethod__OCXDevice_256_58; dispid 1610743865;
    procedure GhostMethod__OCXDevice_260_59; dispid 1610743866;
    procedure GhostMethod__OCXDevice_264_60; dispid 1610743867;
    procedure GhostMethod__OCXDevice_268_61; dispid 1610743868;
    procedure GhostMethod__OCXDevice_272_62; dispid 1610743869;
    procedure GhostMethod__OCXDevice_276_63; dispid 1610743870;
    procedure GhostMethod__OCXDevice_280_64; dispid 1610743871;
    procedure GhostMethod__OCXDevice_284_65; dispid 1610743872;
    procedure GhostMethod__OCXDevice_288_66; dispid 1610743873;
    procedure GhostMethod__OCXDevice_292_67; dispid 1610743874;
    procedure GhostMethod__OCXDevice_296_68; dispid 1610743875;
    procedure GhostMethod__OCXDevice_300_69; dispid 1610743876;
    procedure GhostMethod__OCXDevice_304_70; dispid 1610743877;
    procedure GhostMethod__OCXDevice_308_71; dispid 1610743878;
    procedure GhostMethod__OCXDevice_312_72; dispid 1610743879;
    procedure GhostMethod__OCXDevice_316_73; dispid 1610743880;
    procedure GhostMethod__OCXDevice_320_74; dispid 1610743881;
    procedure GhostMethod__OCXDevice_324_75; dispid 1610743882;
    procedure GhostMethod__OCXDevice_328_76; dispid 1610743883;
    procedure GhostMethod__OCXDevice_332_77; dispid 1610743884;
    procedure GhostMethod__OCXDevice_336_78; dispid 1610743885;
    procedure GhostMethod__OCXDevice_340_79; dispid 1610743886;
    procedure GhostMethod__OCXDevice_344_80; dispid 1610743887;
    procedure GhostMethod__OCXDevice_348_81; dispid 1610743888;
    procedure GhostMethod__OCXDevice_352_82; dispid 1610743889;
    procedure GhostMethod__OCXDevice_356_83; dispid 1610743890;
    procedure GhostMethod__OCXDevice_360_84; dispid 1610743891;
    procedure GhostMethod__OCXDevice_364_85; dispid 1610743892;
    procedure GhostMethod__OCXDevice_368_86; dispid 1610743893;
    procedure GhostMethod__OCXDevice_372_87; dispid 1610743894;
    procedure GhostMethod__OCXDevice_376_88; dispid 1610743895;
    procedure GhostMethod__OCXDevice_380_89; dispid 1610743896;
    procedure GhostMethod__OCXDevice_384_90; dispid 1610743897;
    procedure GhostMethod__OCXDevice_388_91; dispid 1610743898;
    procedure GhostMethod__OCXDevice_392_92; dispid 1610743899;
    procedure GhostMethod__OCXDevice_396_93; dispid 1610743900;
    procedure GhostMethod__OCXDevice_400_94; dispid 1610743901;
    procedure GhostMethod__OCXDevice_404_95; dispid 1610743902;
    procedure GhostMethod__OCXDevice_408_96; dispid 1610743903;
    procedure GhostMethod__OCXDevice_412_97; dispid 1610743904;
    procedure GhostMethod__OCXDevice_416_98; dispid 1610743905;
    procedure GhostMethod__OCXDevice_420_99; dispid 1610743906;
    procedure GhostMethod__OCXDevice_424_100; dispid 1610743907;
    procedure GhostMethod__OCXDevice_428_101; dispid 1610743908;
    procedure GhostMethod__OCXDevice_432_102; dispid 1610743909;
    procedure GhostMethod__OCXDevice_436_103; dispid 1610743910;
    procedure GhostMethod__OCXDevice_440_104; dispid 1610743911;
    procedure GhostMethod__OCXDevice_444_105; dispid 1610743912;
    procedure GhostMethod__OCXDevice_448_106; dispid 1610743913;
    procedure GhostMethod__OCXDevice_452_107; dispid 1610743914;
    procedure GhostMethod__OCXDevice_456_108; dispid 1610743915;
    procedure GhostMethod__OCXDevice_460_109; dispid 1610743916;
    procedure GhostMethod__OCXDevice_464_110; dispid 1610743917;
    procedure GhostMethod__OCXDevice_468_111; dispid 1610743918;
    procedure GhostMethod__OCXDevice_472_112; dispid 1610743919;
    procedure GhostMethod__OCXDevice_476_113; dispid 1610743920;
    procedure GhostMethod__OCXDevice_480_114; dispid 1610743921;
    procedure GhostMethod__OCXDevice_484_115; dispid 1610743922;
    procedure GhostMethod__OCXDevice_488_116; dispid 1610743923;
    procedure GhostMethod__OCXDevice_492_117; dispid 1610743924;
    procedure GhostMethod__OCXDevice_496_118; dispid 1610743925;
    procedure GhostMethod__OCXDevice_500_119; dispid 1610743926;
    procedure GhostMethod__OCXDevice_504_120; dispid 1610743927;
    procedure GhostMethod__OCXDevice_508_121; dispid 1610743928;
    procedure GhostMethod__OCXDevice_512_122; dispid 1610743929;
    procedure GhostMethod__OCXDevice_516_123; dispid 1610743930;
    procedure GhostMethod__OCXDevice_520_124; dispid 1610743931;
    procedure GhostMethod__OCXDevice_524_125; dispid 1610743932;
    procedure GhostMethod__OCXDevice_528_126; dispid 1610743933;
    procedure GhostMethod__OCXDevice_532_127; dispid 1610743934;
    procedure GhostMethod__OCXDevice_536_128; dispid 1610743935;
    procedure GhostMethod__OCXDevice_540_129; dispid 1610743936;
    procedure GhostMethod__OCXDevice_544_130; dispid 1610743937;
    procedure GhostMethod__OCXDevice_548_131; dispid 1610743938;
    procedure GhostMethod__OCXDevice_552_132; dispid 1610743939;
    procedure GhostMethod__OCXDevice_556_133; dispid 1610743940;
    procedure GhostMethod__OCXDevice_560_134; dispid 1610743941;
    procedure GhostMethod__OCXDevice_564_135; dispid 1610743942;
    procedure GhostMethod__OCXDevice_568_136; dispid 1610743943;
    procedure GhostMethod__OCXDevice_572_137; dispid 1610743944;
    procedure GhostMethod__OCXDevice_576_138; dispid 1610743945;
    procedure GhostMethod__OCXDevice_580_139; dispid 1610743946;
    procedure GhostMethod__OCXDevice_584_140; dispid 1610743947;
    procedure GhostMethod__OCXDevice_588_141; dispid 1610743948;
    procedure GhostMethod__OCXDevice_592_142; dispid 1610743949;
    procedure GhostMethod__OCXDevice_596_143; dispid 1610743950;
    procedure GhostMethod__OCXDevice_600_144; dispid 1610743951;
    procedure GhostMethod__OCXDevice_604_145; dispid 1610743952;
    procedure GhostMethod__OCXDevice_608_146; dispid 1610743953;
    procedure GhostMethod__OCXDevice_612_147; dispid 1610743954;
    procedure GhostMethod__OCXDevice_616_148; dispid 1610743955;
    procedure GhostMethod__OCXDevice_620_149; dispid 1610743956;
    procedure GhostMethod__OCXDevice_624_150; dispid 1610743957;
    procedure GhostMethod__OCXDevice_628_151; dispid 1610743958;
    procedure GhostMethod__OCXDevice_632_152; dispid 1610743959;
    procedure GhostMethod__OCXDevice_636_153; dispid 1610743960;
    procedure GhostMethod__OCXDevice_640_154; dispid 1610743961;
    procedure GhostMethod__OCXDevice_644_155; dispid 1610743962;
    procedure GhostMethod__OCXDevice_648_156; dispid 1610743963;
    procedure GhostMethod__OCXDevice_652_157; dispid 1610743964;
    procedure GhostMethod__OCXDevice_656_158; dispid 1610743965;
    procedure GhostMethod__OCXDevice_660_159; dispid 1610743966;
    procedure GhostMethod__OCXDevice_664_160; dispid 1610743967;
    procedure GhostMethod__OCXDevice_668_161; dispid 1610743968;
    procedure GhostMethod__OCXDevice_672_162; dispid 1610743969;
    procedure GhostMethod__OCXDevice_676_163; dispid 1610743970;
    procedure GhostMethod__OCXDevice_680_164; dispid 1610743971;
    procedure GhostMethod__OCXDevice_684_165; dispid 1610743972;
    procedure GhostMethod__OCXDevice_688_166; dispid 1610743973;
    procedure GhostMethod__OCXDevice_692_167; dispid 1610743974;
    procedure GhostMethod__OCXDevice_696_168; dispid 1610743975;
    procedure GhostMethod__OCXDevice_700_169; dispid 1610743976;
    procedure GhostMethod__OCXDevice_704_170; dispid 1610743977;
    procedure GhostMethod__OCXDevice_708_171; dispid 1610743978;
    procedure GhostMethod__OCXDevice_712_172; dispid 1610743979;
    procedure GhostMethod__OCXDevice_716_173; dispid 1610743980;
    procedure GhostMethod__OCXDevice_720_174; dispid 1610743981;
    procedure GhostMethod__OCXDevice_724_175; dispid 1610743982;
    procedure GhostMethod__OCXDevice_728_176; dispid 1610743983;
    procedure GhostMethod__OCXDevice_732_177; dispid 1610743984;
    procedure GhostMethod__OCXDevice_736_178; dispid 1610743985;
    procedure GhostMethod__OCXDevice_740_179; dispid 1610743986;
    procedure GhostMethod__OCXDevice_744_180; dispid 1610743987;
    procedure GhostMethod__OCXDevice_748_181; dispid 1610743988;
    procedure GhostMethod__OCXDevice_752_182; dispid 1610743989;
    procedure GhostMethod__OCXDevice_756_183; dispid 1610743990;
    procedure GhostMethod__OCXDevice_760_184; dispid 1610743991;
    procedure GhostMethod__OCXDevice_764_185; dispid 1610743992;
    procedure GhostMethod__OCXDevice_768_186; dispid 1610743993;
    procedure GhostMethod__OCXDevice_772_187; dispid 1610743994;
    procedure GhostMethod__OCXDevice_776_188; dispid 1610743995;
    procedure GhostMethod__OCXDevice_780_189; dispid 1610743996;
    procedure GhostMethod__OCXDevice_784_190; dispid 1610743997;
    procedure GhostMethod__OCXDevice_788_191; dispid 1610743998;
    procedure GhostMethod__OCXDevice_792_192; dispid 1610743999;
    procedure GhostMethod__OCXDevice_796_193; dispid 1610744000;
    procedure GhostMethod__OCXDevice_800_194; dispid 1610744001;
    procedure GhostMethod__OCXDevice_804_195; dispid 1610744002;
    procedure GhostMethod__OCXDevice_808_196; dispid 1610744003;
    procedure GhostMethod__OCXDevice_812_197; dispid 1610744004;
    procedure GhostMethod__OCXDevice_816_198; dispid 1610744005;
    procedure GhostMethod__OCXDevice_820_199; dispid 1610744006;
    procedure GhostMethod__OCXDevice_824_200; dispid 1610744007;
    procedure GhostMethod__OCXDevice_828_201; dispid 1610744008;
    procedure GhostMethod__OCXDevice_832_202; dispid 1610744009;
    procedure GhostMethod__OCXDevice_836_203; dispid 1610744010;
    procedure GhostMethod__OCXDevice_840_204; dispid 1610744011;
    procedure GhostMethod__OCXDevice_844_205; dispid 1610744012;
    procedure GhostMethod__OCXDevice_848_206; dispid 1610744013;
    procedure GhostMethod__OCXDevice_852_207; dispid 1610744014;
    procedure GhostMethod__OCXDevice_856_208; dispid 1610744015;
    procedure GhostMethod__OCXDevice_860_209; dispid 1610744016;
    procedure GhostMethod__OCXDevice_864_210; dispid 1610744017;
    procedure GhostMethod__OCXDevice_868_211; dispid 1610744018;
    procedure GhostMethod__OCXDevice_872_212; dispid 1610744019;
    procedure GhostMethod__OCXDevice_876_213; dispid 1610744020;
    procedure GhostMethod__OCXDevice_880_214; dispid 1610744021;
    procedure GhostMethod__OCXDevice_884_215; dispid 1610744022;
    procedure GhostMethod__OCXDevice_888_216; dispid 1610744023;
    procedure GhostMethod__OCXDevice_892_217; dispid 1610744024;
    procedure GhostMethod__OCXDevice_896_218; dispid 1610744025;
    procedure GhostMethod__OCXDevice_900_219; dispid 1610744026;
    procedure GhostMethod__OCXDevice_904_220; dispid 1610744027;
    procedure GhostMethod__OCXDevice_908_221; dispid 1610744028;
    procedure GhostMethod__OCXDevice_912_222; dispid 1610744029;
    procedure GhostMethod__OCXDevice_916_223; dispid 1610744030;
    procedure GhostMethod__OCXDevice_920_224; dispid 1610744031;
    procedure GhostMethod__OCXDevice_924_225; dispid 1610744032;
    procedure GhostMethod__OCXDevice_928_226; dispid 1610744033;
    procedure GhostMethod__OCXDevice_932_227; dispid 1610744034;
    procedure GhostMethod__OCXDevice_936_228; dispid 1610744035;
    procedure GhostMethod__OCXDevice_940_229; dispid 1610744036;
    procedure GhostMethod__OCXDevice_944_230; dispid 1610744037;
    procedure GhostMethod__OCXDevice_948_231; dispid 1610744038;
    procedure GhostMethod__OCXDevice_952_232; dispid 1610744039;
    procedure GhostMethod__OCXDevice_956_233; dispid 1610744040;
    procedure GhostMethod__OCXDevice_960_234; dispid 1610744041;
    procedure GhostMethod__OCXDevice_964_235; dispid 1610744042;
    procedure GhostMethod__OCXDevice_968_236; dispid 1610744043;
    procedure GhostMethod__OCXDevice_972_237; dispid 1610744044;
    procedure GhostMethod__OCXDevice_976_238; dispid 1610744045;
    procedure GhostMethod__OCXDevice_980_239; dispid 1610744046;
    procedure GhostMethod__OCXDevice_984_240; dispid 1610744047;
    procedure GhostMethod__OCXDevice_988_241; dispid 1610744048;
    procedure GhostMethod__OCXDevice_992_242; dispid 1610744049;
    procedure GhostMethod__OCXDevice_996_243; dispid 1610744050;
    procedure GhostMethod__OCXDevice_1000_244; dispid 1610744051;
    procedure GhostMethod__OCXDevice_1004_245; dispid 1610744052;
    procedure GhostMethod__OCXDevice_1008_246; dispid 1610744053;
    procedure GhostMethod__OCXDevice_1012_247; dispid 1610744054;
    procedure GhostMethod__OCXDevice_1016_248; dispid 1610744055;
    procedure GhostMethod__OCXDevice_1020_249; dispid 1610744056;
    procedure GhostMethod__OCXDevice_1024_250; dispid 1610744057;
    procedure GhostMethod__OCXDevice_1028_251; dispid 1610744058;
    procedure GhostMethod__OCXDevice_1032_252; dispid 1610744059;
    procedure GhostMethod__OCXDevice_1036_253; dispid 1610744060;
    procedure GhostMethod__OCXDevice_1040_254; dispid 1610744061;
    procedure GhostMethod__OCXDevice_1044_255; dispid 1610744062;
    procedure GhostMethod__OCXDevice_1048_256; dispid 1610744063;
    procedure GhostMethod__OCXDevice_1052_257; dispid 1610744064;
    procedure GhostMethod__OCXDevice_1056_258; dispid 1610744065;
    procedure GhostMethod__OCXDevice_1060_259; dispid 1610744066;
    procedure GhostMethod__OCXDevice_1064_260; dispid 1610744067;
    procedure GhostMethod__OCXDevice_1068_261; dispid 1610744068;
    procedure GhostMethod__OCXDevice_1072_262; dispid 1610744069;
    procedure GhostMethod__OCXDevice_1076_263; dispid 1610744070;
    procedure GhostMethod__OCXDevice_1080_264; dispid 1610744071;
    procedure GhostMethod__OCXDevice_1084_265; dispid 1610744072;
    procedure GhostMethod__OCXDevice_1088_266; dispid 1610744073;
    procedure GhostMethod__OCXDevice_1092_267; dispid 1610744074;
    procedure GhostMethod__OCXDevice_1096_268; dispid 1610744075;
    procedure GhostMethod__OCXDevice_1100_269; dispid 1610744076;
    procedure GhostMethod__OCXDevice_1104_270; dispid 1610744077;
    procedure GhostMethod__OCXDevice_1108_271; dispid 1610744078;
    procedure GhostMethod__OCXDevice_1112_272; dispid 1610744079;
    procedure GhostMethod__OCXDevice_1116_273; dispid 1610744080;
    procedure GhostMethod__OCXDevice_1120_274; dispid 1610744081;
    procedure GhostMethod__OCXDevice_1124_275; dispid 1610744082;
    procedure GhostMethod__OCXDevice_1128_276; dispid 1610744083;
    procedure GhostMethod__OCXDevice_1132_277; dispid 1610744084;
    procedure GhostMethod__OCXDevice_1136_278; dispid 1610744085;
    procedure GhostMethod__OCXDevice_1140_279; dispid 1610744086;
    procedure GhostMethod__OCXDevice_1144_280; dispid 1610744087;
    procedure GhostMethod__OCXDevice_1148_281; dispid 1610744088;
    procedure GhostMethod__OCXDevice_1152_282; dispid 1610744089;
    procedure GhostMethod__OCXDevice_1156_283; dispid 1610744090;
    procedure GhostMethod__OCXDevice_1160_284; dispid 1610744091;
    procedure GhostMethod__OCXDevice_1164_285; dispid 1610744092;
    procedure GhostMethod__OCXDevice_1168_286; dispid 1610744093;
    procedure GhostMethod__OCXDevice_1172_287; dispid 1610744094;
    procedure GhostMethod__OCXDevice_1176_288; dispid 1610744095;
    procedure GhostMethod__OCXDevice_1180_289; dispid 1610744096;
    procedure GhostMethod__OCXDevice_1184_290; dispid 1610744097;
    procedure GhostMethod__OCXDevice_1188_291; dispid 1610744098;
    procedure GhostMethod__OCXDevice_1192_292; dispid 1610744099;
    procedure GhostMethod__OCXDevice_1196_293; dispid 1610744100;
    procedure GhostMethod__OCXDevice_1200_294; dispid 1610744101;
    procedure GhostMethod__OCXDevice_1204_295; dispid 1610744102;
    procedure GhostMethod__OCXDevice_1208_296; dispid 1610744103;
    procedure GhostMethod__OCXDevice_1212_297; dispid 1610744104;
    procedure GhostMethod__OCXDevice_1216_298; dispid 1610744105;
    procedure GhostMethod__OCXDevice_1220_299; dispid 1610744106;
    procedure GhostMethod__OCXDevice_1224_300; dispid 1610744107;
    procedure GhostMethod__OCXDevice_1228_301; dispid 1610744108;
    procedure GhostMethod__OCXDevice_1232_302; dispid 1610744109;
    procedure GhostMethod__OCXDevice_1236_303; dispid 1610744110;
    procedure GhostMethod__OCXDevice_1240_304; dispid 1610744111;
    procedure GhostMethod__OCXDevice_1244_305; dispid 1610744112;
    procedure GhostMethod__OCXDevice_1248_306; dispid 1610744113;
    procedure GhostMethod__OCXDevice_1252_307; dispid 1610744114;
    procedure GhostMethod__OCXDevice_1256_308; dispid 1610744115;
    procedure GhostMethod__OCXDevice_1260_309; dispid 1610744116;
    procedure GhostMethod__OCXDevice_1264_310; dispid 1610744117;
    procedure GhostMethod__OCXDevice_1268_311; dispid 1610744118;
    procedure GhostMethod__OCXDevice_1272_312; dispid 1610744119;
    procedure GhostMethod__OCXDevice_1276_313; dispid 1610744120;
    procedure GhostMethod__OCXDevice_1280_314; dispid 1610744121;
    procedure GhostMethod__OCXDevice_1284_315; dispid 1610744122;
    procedure GhostMethod__OCXDevice_1288_316; dispid 1610744123;
    procedure GhostMethod__OCXDevice_1292_317; dispid 1610744124;
    procedure GhostMethod__OCXDevice_1296_318; dispid 1610744125;
    procedure GhostMethod__OCXDevice_1300_319; dispid 1610744126;
    procedure GhostMethod__OCXDevice_1304_320; dispid 1610744127;
    procedure GhostMethod__OCXDevice_1308_321; dispid 1610744128;
    procedure GhostMethod__OCXDevice_1312_322; dispid 1610744129;
    procedure GhostMethod__OCXDevice_1316_323; dispid 1610744130;
    procedure GhostMethod__OCXDevice_1320_324; dispid 1610744131;
    procedure GhostMethod__OCXDevice_1324_325; dispid 1610744132;
    procedure GhostMethod__OCXDevice_1328_326; dispid 1610744133;
    procedure GhostMethod__OCXDevice_1332_327; dispid 1610744134;
    procedure GhostMethod__OCXDevice_1336_328; dispid 1610744135;
    procedure GhostMethod__OCXDevice_1340_329; dispid 1610744136;
    procedure GhostMethod__OCXDevice_1344_330; dispid 1610744137;
    procedure GhostMethod__OCXDevice_1348_331; dispid 1610744138;
    procedure GhostMethod__OCXDevice_1352_332; dispid 1610744139;
    procedure GhostMethod__OCXDevice_1356_333; dispid 1610744140;
    procedure GhostMethod__OCXDevice_1360_334; dispid 1610744141;
    procedure GhostMethod__OCXDevice_1364_335; dispid 1610744142;
    procedure GhostMethod__OCXDevice_1368_336; dispid 1610744143;
    procedure GhostMethod__OCXDevice_1372_337; dispid 1610744144;
    procedure GhostMethod__OCXDevice_1376_338; dispid 1610744145;
    procedure GhostMethod__OCXDevice_1380_339; dispid 1610744146;
    procedure GhostMethod__OCXDevice_1384_340; dispid 1610744147;
    procedure GhostMethod__OCXDevice_1388_341; dispid 1610744148;
    procedure GhostMethod__OCXDevice_1392_342; dispid 1610744149;
    procedure GhostMethod__OCXDevice_1396_343; dispid 1610744150;
    procedure GhostMethod__OCXDevice_1400_344; dispid 1610744151;
    procedure GhostMethod__OCXDevice_1404_345; dispid 1610744152;
    procedure GhostMethod__OCXDevice_1408_346; dispid 1610744153;
    procedure GhostMethod__OCXDevice_1412_347; dispid 1610744154;
    procedure GhostMethod__OCXDevice_1416_348; dispid 1610744155;
    procedure GhostMethod__OCXDevice_1420_349; dispid 1610744156;
    procedure GhostMethod__OCXDevice_1424_350; dispid 1610744157;
    procedure GhostMethod__OCXDevice_1428_351; dispid 1610744158;
    procedure GhostMethod__OCXDevice_1432_352; dispid 1610744159;
    procedure GhostMethod__OCXDevice_1436_353; dispid 1610744160;
    procedure GhostMethod__OCXDevice_1440_354; dispid 1610744161;
    procedure GhostMethod__OCXDevice_1444_355; dispid 1610744162;
    procedure GhostMethod__OCXDevice_1448_356; dispid 1610744163;
    procedure GhostMethod__OCXDevice_1452_357; dispid 1610744164;
    procedure GhostMethod__OCXDevice_1456_358; dispid 1610744165;
    procedure GhostMethod__OCXDevice_1460_359; dispid 1610744166;
    procedure GhostMethod__OCXDevice_1464_360; dispid 1610744167;
    procedure GhostMethod__OCXDevice_1468_361; dispid 1610744168;
    procedure GhostMethod__OCXDevice_1472_362; dispid 1610744169;
    procedure GhostMethod__OCXDevice_1476_363; dispid 1610744170;
    procedure GhostMethod__OCXDevice_1480_364; dispid 1610744171;
    procedure GhostMethod__OCXDevice_1484_365; dispid 1610744172;
    procedure GhostMethod__OCXDevice_1488_366; dispid 1610744173;
    procedure GhostMethod__OCXDevice_1492_367; dispid 1610744174;
    procedure GhostMethod__OCXDevice_1496_368; dispid 1610744175;
    procedure GhostMethod__OCXDevice_1500_369; dispid 1610744176;
    procedure GhostMethod__OCXDevice_1504_370; dispid 1610744177;
    procedure GhostMethod__OCXDevice_1508_371; dispid 1610744178;
    procedure GhostMethod__OCXDevice_1512_372; dispid 1610744179;
    procedure GhostMethod__OCXDevice_1516_373; dispid 1610744180;
    procedure GhostMethod__OCXDevice_1520_374; dispid 1610744181;
    procedure GhostMethod__OCXDevice_1524_375; dispid 1610744182;
    procedure GhostMethod__OCXDevice_1528_376; dispid 1610744183;
    procedure GhostMethod__OCXDevice_1532_377; dispid 1610744184;
    procedure GhostMethod__OCXDevice_1536_378; dispid 1610744185;
    procedure GhostMethod__OCXDevice_1540_379; dispid 1610744186;
    procedure GhostMethod__OCXDevice_1544_380; dispid 1610744187;
    procedure GhostMethod__OCXDevice_1548_381; dispid 1610744188;
    procedure GhostMethod__OCXDevice_1552_382; dispid 1610744189;
    procedure GhostMethod__OCXDevice_1556_383; dispid 1610744190;
    procedure GhostMethod__OCXDevice_1560_384; dispid 1610744191;
    procedure GhostMethod__OCXDevice_1564_385; dispid 1610744192;
    procedure GhostMethod__OCXDevice_1568_386; dispid 1610744193;
    procedure GhostMethod__OCXDevice_1572_387; dispid 1610744194;
    procedure GhostMethod__OCXDevice_1576_388; dispid 1610744195;
    procedure GhostMethod__OCXDevice_1580_389; dispid 1610744196;
    procedure GhostMethod__OCXDevice_1584_390; dispid 1610744197;
    procedure GhostMethod__OCXDevice_1588_391; dispid 1610744198;
    procedure GhostMethod__OCXDevice_1592_392; dispid 1610744199;
    procedure GhostMethod__OCXDevice_1596_393; dispid 1610744200;
    procedure GhostMethod__OCXDevice_1600_394; dispid 1610744201;
    procedure GhostMethod__OCXDevice_1604_395; dispid 1610744202;
    procedure GhostMethod__OCXDevice_1608_396; dispid 1610744203;
    procedure GhostMethod__OCXDevice_1612_397; dispid 1610744204;
    procedure GhostMethod__OCXDevice_1616_398; dispid 1610744205;
    procedure GhostMethod__OCXDevice_1620_399; dispid 1610744206;
    procedure GhostMethod__OCXDevice_1624_400; dispid 1610744207;
    procedure GhostMethod__OCXDevice_1628_401; dispid 1610744208;
    procedure GhostMethod__OCXDevice_1632_402; dispid 1610744209;
    procedure GhostMethod__OCXDevice_1636_403; dispid 1610744210;
    procedure GhostMethod__OCXDevice_1640_404; dispid 1610744211;
    procedure GhostMethod__OCXDevice_1644_405; dispid 1610744212;
    procedure GhostMethod__OCXDevice_1648_406; dispid 1610744213;
    procedure GhostMethod__OCXDevice_1652_407; dispid 1610744214;
    procedure GhostMethod__OCXDevice_1656_408; dispid 1610744215;
    procedure GhostMethod__OCXDevice_1660_409; dispid 1610744216;
    procedure GhostMethod__OCXDevice_1664_410; dispid 1610744217;
    procedure GhostMethod__OCXDevice_1668_411; dispid 1610744218;
    procedure GhostMethod__OCXDevice_1672_412; dispid 1610744219;
    procedure GhostMethod__OCXDevice_1676_413; dispid 1610744220;
    procedure GhostMethod__OCXDevice_1680_414; dispid 1610744221;
    procedure GhostMethod__OCXDevice_1684_415; dispid 1610744222;
    procedure GhostMethod__OCXDevice_1688_416; dispid 1610744223;
    procedure GhostMethod__OCXDevice_1692_417; dispid 1610744224;
    procedure GhostMethod__OCXDevice_1696_418; dispid 1610744225;
    procedure GhostMethod__OCXDevice_1700_419; dispid 1610744226;
    procedure GhostMethod__OCXDevice_1704_420; dispid 1610744227;
    procedure GhostMethod__OCXDevice_1708_421; dispid 1610744228;
    procedure GhostMethod__OCXDevice_1712_422; dispid 1610744229;
    procedure GhostMethod__OCXDevice_1716_423; dispid 1610744230;
    procedure GhostMethod__OCXDevice_1720_424; dispid 1610744231;
    procedure GhostMethod__OCXDevice_1724_425; dispid 1610744232;
    procedure GhostMethod__OCXDevice_1728_426; dispid 1610744233;
    procedure GhostMethod__OCXDevice_1732_427; dispid 1610744234;
    procedure GhostMethod__OCXDevice_1736_428; dispid 1610744235;
    procedure GhostMethod__OCXDevice_1740_429; dispid 1610744236;
    procedure GhostMethod__OCXDevice_1744_430; dispid 1610744237;
    procedure GhostMethod__OCXDevice_1748_431; dispid 1610744238;
    procedure GhostMethod__OCXDevice_1752_432; dispid 1610744239;
    procedure GhostMethod__OCXDevice_1756_433; dispid 1610744240;
    procedure GhostMethod__OCXDevice_1760_434; dispid 1610744241;
    procedure GhostMethod__OCXDevice_1764_435; dispid 1610744242;
    procedure GhostMethod__OCXDevice_1768_436; dispid 1610744243;
    procedure GhostMethod__OCXDevice_1772_437; dispid 1610744244;
    procedure GhostMethod__OCXDevice_1776_438; dispid 1610744245;
    procedure GhostMethod__OCXDevice_1780_439; dispid 1610744246;
    procedure GhostMethod__OCXDevice_1784_440; dispid 1610744247;
    procedure GhostMethod__OCXDevice_1788_441; dispid 1610744248;
    procedure GhostMethod__OCXDevice_1792_442; dispid 1610744249;
    procedure GhostMethod__OCXDevice_1796_443; dispid 1610744250;
    procedure GhostMethod__OCXDevice_1800_444; dispid 1610744251;
    procedure GhostMethod__OCXDevice_1804_445; dispid 1610744252;
    procedure GhostMethod__OCXDevice_1808_446; dispid 1610744253;
    procedure GhostMethod__OCXDevice_1812_447; dispid 1610744254;
    procedure GhostMethod__OCXDevice_1816_448; dispid 1610744255;
    procedure GhostMethod__OCXDevice_1820_449; dispid 1610744256;
    procedure GhostMethod__OCXDevice_1824_450; dispid 1610744257;
    procedure GhostMethod__OCXDevice_1828_451; dispid 1610744258;
    procedure GhostMethod__OCXDevice_1832_452; dispid 1610744259;
    procedure GhostMethod__OCXDevice_1836_453; dispid 1610744260;
    procedure GhostMethod__OCXDevice_1840_454; dispid 1610744261;
    procedure GhostMethod__OCXDevice_1844_455; dispid 1610744262;
    procedure GhostMethod__OCXDevice_1848_456; dispid 1610744263;
    procedure GhostMethod__OCXDevice_1852_457; dispid 1610744264;
    procedure GhostMethod__OCXDevice_1856_458; dispid 1610744265;
    procedure GhostMethod__OCXDevice_1860_459; dispid 1610744266;
    procedure GhostMethod__OCXDevice_1864_460; dispid 1610744267;
    procedure GhostMethod__OCXDevice_1868_461; dispid 1610744268;
    procedure GhostMethod__OCXDevice_1872_462; dispid 1610744269;
    procedure GhostMethod__OCXDevice_1876_463; dispid 1610744270;
    procedure GhostMethod__OCXDevice_1880_464; dispid 1610744271;
    procedure GhostMethod__OCXDevice_1884_465; dispid 1610744272;
    procedure GhostMethod__OCXDevice_1888_466; dispid 1610744273;
    procedure GhostMethod__OCXDevice_1892_467; dispid 1610744274;
    procedure GhostMethod__OCXDevice_1896_468; dispid 1610744275;
    procedure GhostMethod__OCXDevice_1900_469; dispid 1610744276;
    procedure GhostMethod__OCXDevice_1904_470; dispid 1610744277;
    procedure GhostMethod__OCXDevice_1908_471; dispid 1610744278;
    procedure GhostMethod__OCXDevice_1912_472; dispid 1610744279;
    procedure GhostMethod__OCXDevice_1916_473; dispid 1610744280;
    procedure GhostMethod__OCXDevice_1920_474; dispid 1610744281;
    procedure GhostMethod__OCXDevice_1924_475; dispid 1610744282;
    procedure GhostMethod__OCXDevice_1928_476; dispid 1610744283;
    procedure GhostMethod__OCXDevice_1932_477; dispid 1610744284;
    procedure GhostMethod__OCXDevice_1936_478; dispid 1610744285;
    procedure GhostMethod__OCXDevice_1940_479; dispid 1610744286;
    procedure GhostMethod__OCXDevice_1944_480; dispid 1610744287;
    procedure GhostMethod__OCXDevice_1948_481; dispid 1610744288;
    procedure GhostMethod__OCXDevice_1952_482; dispid 1610744289;
    function About: OleVariant; dispid 1610809368;
    property Port: WideString dispid 1745027085;
    property Baud: WideString dispid 1745027084;
    property Device: DeviceType dispid 1745027083;
    property Parity: WideString dispid 1745027082;
    property DataBits: WideString dispid 1745027081;
    property DisplayString: WideString dispid 1745027080;
    property Card: WideString dispid 1745027079;
    property Amount: WideString dispid 1745027078;
    property EncryptMethod: PinPadManagement dispid 1745027077;
    property WorkingKey: WideString dispid 1745027076;
    property MasterKey: Smallint dispid 1745027075;
    property Demo: WordBool dispid 1745027074;
    property TimeOut: Integer dispid 1745027073;
    property DefaultMessage: WideString dispid 1745027072;
    function Initialize(blnCheckPort: WordBool): WordBool; dispid 1610809369;
    function GetPin: WideString; dispid 1610809370;
    function Cancel: WordBool; dispid 1610809371;
    function Clear: WordBool; dispid 1610809372;
    function RefreshDisplay: WordBool; dispid 1610809373;
    function GetCardSwipe: WordBool; dispid 1610809374;
    function PrintReceipt(var strprint: WideString): WideString; dispid 1610809375;
    function GetKeySerialNumber: WideString; dispid 1610809376;
    function GetErrorCode: Integer; dispid 1610809377;
    function GetErrorDesc: WideString; dispid 1610809378;
    function GetCard: WideString; dispid 1610809379;
    function GetMember: WideString; dispid 1610809380;
    function GetExpDate: WideString; dispid 1610809381;
    function GetTrack1: WideString; dispid 1610809382;
    function GetTrack2: WideString; dispid 1610809383;
    function GetTrack3: WideString; dispid 1610809384;
    function StartMSR: OleVariant; dispid 1610809385;
    function EnablePin: OleVariant; dispid 1610809386;
    function ShutdownApp: OleVariant; dispid 1610809387;
  end;

// *********************************************************************//
// DispIntf:  __OCXDevice
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {5FC99A66-6737-47D1-8817-3281B954227C}
// *********************************************************************//
  __OCXDevice = dispinterface
    ['{5FC99A66-6737-47D1-8817-3281B954227C}']
    procedure Error; dispid 1;
    procedure CardSwipe; dispid 2;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TOCXDevice
// Help String      : 
// Default Interface: _OCXDevice
// Def. Intf. DISP? : No
// Event   Interface: __OCXDevice
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TOCXDevice = class(TOleControl)
  private
    FOnError: TNotifyEvent;
    FOnCardSwipe: TNotifyEvent;
    FIntf: _OCXDevice;
    function  GetControlInterface: _OCXDevice;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function About: OleVariant;
    function Initialize(blnCheckPort: WordBool): WordBool;
    function GetPin: WideString;
    function Cancel: WordBool;
    function Clear: WordBool;
    function RefreshDisplay: WordBool;
    function GetCardSwipe: WordBool;
    function PrintReceipt(var strprint: WideString): WideString;
    function GetKeySerialNumber: WideString;
    function GetErrorCode: Integer;
    function GetErrorDesc: WideString;
    function GetCard: WideString;
    function GetMember: WideString;
    function GetExpDate: WideString;
    function GetTrack1: WideString;
    function GetTrack2: WideString;
    function GetTrack3: WideString;
    function StartMSR: OleVariant;
    function EnablePin: OleVariant;
    function ShutdownApp: OleVariant;
    property  ControlInterface: _OCXDevice read GetControlInterface;
    property  DefaultInterface: _OCXDevice read GetControlInterface;
  published
    property Anchors;
    property Port: WideString index 1745027085 read GetWideStringProp write SetWideStringProp stored False;
    property Baud: WideString index 1745027084 read GetWideStringProp write SetWideStringProp stored False;
    property Device: TOleEnum index 1745027083 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Parity: WideString index 1745027082 read GetWideStringProp write SetWideStringProp stored False;
    property DataBits: WideString index 1745027081 read GetWideStringProp write SetWideStringProp stored False;
    property DisplayString: WideString index 1745027080 read GetWideStringProp write SetWideStringProp stored False;
    property Card: WideString index 1745027079 read GetWideStringProp write SetWideStringProp stored False;
    property Amount: WideString index 1745027078 read GetWideStringProp write SetWideStringProp stored False;
    property EncryptMethod: TOleEnum index 1745027077 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property WorkingKey: WideString index 1745027076 read GetWideStringProp write SetWideStringProp stored False;
    property MasterKey: Smallint index 1745027075 read GetSmallintProp write SetSmallintProp stored False;
    property Demo: WordBool index 1745027074 read GetWordBoolProp write SetWordBoolProp stored False;
    property TimeOut: Integer index 1745027073 read GetIntegerProp write SetIntegerProp stored False;
    property DefaultMessage: WideString index 1745027072 read GetWideStringProp write SetWideStringProp stored False;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnCardSwipe: TNotifyEvent read FOnCardSwipe write FOnCardSwipe;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TOCXDevice.InitControlData;
const
  CEventDispIDs: array [0..1] of DWORD = (
    $00000001, $00000002);
  CControlData: TControlData2 = (
    ClassID: '{AA0CC293-B10A-48DD-881F-179E3FDABE44}';
    EventIID: '{5FC99A66-6737-47D1-8817-3281B954227C}';
    EventCount: 2;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnError) - Cardinal(Self);
end;

procedure TOCXDevice.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _OCXDevice;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TOCXDevice.GetControlInterface: _OCXDevice;
begin
  CreateControl;
  Result := FIntf;
end;

function TOCXDevice.About: OleVariant;
begin
  Result := DefaultInterface.About;
end;

function TOCXDevice.Initialize(blnCheckPort: WordBool): WordBool;
begin
  Result := DefaultInterface.Initialize(blnCheckPort);
end;

function TOCXDevice.GetPin: WideString;
begin
  Result := DefaultInterface.GetPin;
end;

function TOCXDevice.Cancel: WordBool;
begin
  Result := DefaultInterface.Cancel;
end;

function TOCXDevice.Clear: WordBool;
begin
  Result := DefaultInterface.Clear;
end;

function TOCXDevice.RefreshDisplay: WordBool;
begin
  Result := DefaultInterface.RefreshDisplay;
end;

function TOCXDevice.GetCardSwipe: WordBool;
begin
  Result := DefaultInterface.GetCardSwipe;
end;

function TOCXDevice.PrintReceipt(var strprint: WideString): WideString;
begin
  Result := DefaultInterface.PrintReceipt(strprint);
end;

function TOCXDevice.GetKeySerialNumber: WideString;
begin
  Result := DefaultInterface.GetKeySerialNumber;
end;

function TOCXDevice.GetErrorCode: Integer;
begin
  Result := DefaultInterface.GetErrorCode;
end;

function TOCXDevice.GetErrorDesc: WideString;
begin
  Result := DefaultInterface.GetErrorDesc;
end;

function TOCXDevice.GetCard: WideString;
begin
  Result := DefaultInterface.GetCard;
end;

function TOCXDevice.GetMember: WideString;
begin
  Result := DefaultInterface.GetMember;
end;

function TOCXDevice.GetExpDate: WideString;
begin
  Result := DefaultInterface.GetExpDate;
end;

function TOCXDevice.GetTrack1: WideString;
begin
  Result := DefaultInterface.GetTrack1;
end;

function TOCXDevice.GetTrack2: WideString;
begin
  Result := DefaultInterface.GetTrack2;
end;

function TOCXDevice.GetTrack3: WideString;
begin
  Result := DefaultInterface.GetTrack3;
end;

function TOCXDevice.StartMSR: OleVariant;
begin
  Result := DefaultInterface.StartMSR;
end;

function TOCXDevice.EnablePin: OleVariant;
begin
  Result := DefaultInterface.EnablePin;
end;

function TOCXDevice.ShutdownApp: OleVariant;
begin
  Result := DefaultInterface.ShutdownApp;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TOCXDevice]);
end;

end.
