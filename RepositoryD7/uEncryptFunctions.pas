unit uEncryptFunctions;

interface

uses SysUtils, DECUtil, Cipher, Hash;

const
  // ###### Chipher Mode = EncryptMode ############
  CIPHER_TEXT_STEALING  = 0;          // cmCTS=Cipher Text Stealing
  CIPHER_BLOCK_CHAINING = 1;          // cmCBC=Cipher Block Chaining
  CIPHER_FEEDBACK       = 2;          // cmCFB=Cipher Feedback
  OUTPUT_FEEDBACK       = 3;          // cmOFB=Output Feedback
  ELECTRONIC_CODE_BOOK  = 4;          // cmECB=Electronic Code Book

  // ###### encode\decode types ############
  FMT_DEFAULT           = fmtDEFAULT; // =    -1; use DefaultStringFormat
  FMT_NONE              = fmtnONE;    // =     0; allways an Empty String, nothing Action
  FMT_COPY              = fmtCOPY;    // =     1; One to One binary (input = output)
  FMT_HEX               = fmtHEX;     // =    16; Hexadecimal
  FMT_HEXL              = fmtHEXL;    // =  1016; Hexadecimal lowercase
  FMT_MIME64            = fmtMIME64;  // = $1064; MIME Base 64
  FMT_UU                = fmtUU;      // = $5555; UU Coding  $5555 = 'UU'
  FMT_XX                = fmtXX;      // = $5858; XX Coding  $5858 = 'XX'


  function DecodeServerInfo(sDataToDencode, sConst : String; EncryptMode, DecodeType:Integer):String;
  function EncodeServerInfo(sDataToEncode, sConst : String; EncryptMode, EncodeType:Integer):string;

implementation

function DecodeServerInfo(sDataToDencode, sConst : String; EncryptMode,DecodeType:Integer):String;
begin
  Result := '';
  with TCipher_Blowfish.Create(sConst, nil) do
     try
       Mode := TCipherMode(EncryptMode);
       Result := CodeString(sDataToDencode, paDecode, DecodeType);
     finally
       Free;
     end;
end;

function EncodeServerInfo(sDataToEncode, sConst : String; EncryptMode, EncodeType:Integer):string;
begin
  Result := '';
  with TCipher_Blowfish.Create(sConst, nil) do
     try
       Mode := TCipherMode(EncryptMode);
       Result := CodeString(sDataToEncode, paEncode, EncodeType);
     finally
       Free;
     end;
end;


end.
