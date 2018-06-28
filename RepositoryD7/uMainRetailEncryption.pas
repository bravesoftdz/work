unit uMainRetailEncryption;

interface

uses IdCoder, IdCoder3to4, IdCoderUUE, IdBaseComponent, SysUtils,
IdCoderXXE, IdCoderMIME;

  function DecodeUU(AText : WideString) : WideString;
  function EncodeUU(AText : WideString) : WideString;

  function DecodeMIME64(AText : WideString) : WideString;
  function EncodeMIME64(AText : WideString) : WideString;

implementation

function DecodeUU(AText : WideString) : WideString;
var
  IdDecoderUUE : TIdDecoderUUE;
begin
  IdDecoderUUE := TIdDecoderUUE.Create(nil);
  try
    Result := IdDecoderUUE.DecodeString(AText)
  finally
    FreeAndNil(IdDecoderUUE);
  end;
end;

function EncodeUU(AText : WideString) : WideString;
var
  IdEncoderUUE : TIdEncoderUUE;
begin
  IdEncoderUUE := TIdEncoderUUE.Create(Nil);
  try
    Result := IdEncoderUUE.Encode(AText);
  finally
    FreeAndNil(IdEncoderUUE);
    end;
end;

function DecodeMIME64(AText : WideString) : WideString;
var
  IdDecoderMIME: TIdDecoderMIME;
begin
  IdDecoderMIME := TIdDecoderMIME.Create(nil);
  try
    Result := IdDecoderMIME.DecodeString(AText);
  finally
    FreeAndNil(IdDecoderMIME);
  end;
end;

function EncodeMIME64(AText : WideString) : WideString;
var
  IdEncoderMIME: TIdEncoderMIME;
begin
  IdEncoderMIME := TIdEncoderMIME.Create(nil);
  try
    Result := IdEncoderMIME.Encode(AText);
  finally
    FreeAndNil(IdEncoderMIME);
  end;
end;


end.
