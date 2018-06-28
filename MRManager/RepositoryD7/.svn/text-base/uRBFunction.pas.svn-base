{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit uRBFunction;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, raFunc, ppRTTI, ppReport{, uRBInputBoxFch, uRBTestemunhaFch};

type

{ TSIGRBFunctionLowerCase class }
  TFormatFunction = class(TraSystemFunction)
  public
    class function Category: string; override;
    class function GetSignature: string; override;
    procedure ExecuteFunction(aParams: TraParamList); override;
  end;

{ TSIGRBFunctionExtenso class }
  TExtensoFunction = class(TraSystemFunction)
  public
    class function Category: string; override;
    class function GetSignature: string; override;
    procedure ExecuteFunction(aParams: TraParamList); override;
  end;

{ TSIGRBGetUsuarioFunction class }
  TGetUsuarioFunction = class(TraSystemFunction)
  public
    class function Category: string; override;
    class function GetSignature: string; override;
    procedure ExecuteFunction(aParams: TraParamList); override;
  end;

{ TSIGRBGetDefaultLanguageFunction class }
  TDefaultLanguageFunction = class(TraSystemFunction)
  public
    class function Category: string; override;
    class function GetSignature: string; override;
    procedure ExecuteFunction(aParams: TraParamList); override;
  end;

{ TSIGRBPrintCommandFunction class }
  TPrintCommandFunction = class(TraSystemFunction)
  public
    class function Category: string; override;
    class function GetSignature: string; override;
    procedure ExecuteFunction(aParams: TraParamList); override;
  end;

implementation

uses
  {uExtenso, } uDM, uDMGlobal, WinSpool, Printers;


{ TSIGRBFunctionLowerCase }

class function TFormatFunction.Category: string;
begin
  Result := 'MR';
end;

class function TFormatFunction.GetSignature: string;
begin
  result := 'function FormatName(var sInputString: string): string;';
end;

procedure TFormatFunction.ExecuteFunction(aParams: TraParamList);
var
  sTemp1, sTemp2, sTemp3, sTemp4: string;
  bChangeToUpper: Boolean;
  iX: integer;
  lsResult: string;
begin
  GetParamValue(0, sTemp4);
  try
    sTemp1 := LowerCase(sTemp4);
    bChangeToUpper := True;
    for iX := 1 to length(sTemp1) do
    begin
      if bChangeToUpper then
        sTemp2 := sTemp2 + UpperCase(sTemp1[iX])
      else
        sTemp2 := sTemp2 + sTemp1[iX];

      bChangeToUpper := (sTemp1[iX] = ' ');
      if bChangeToUpper then
      begin
        sTemp3 := copy(sTemp2, length(sTemp2) - 3, length(sTemp2));
        sTemp3 := Trim(sTemp3);
        if length(sTemp3) = 2 then
        begin
          sTemp3 := LowerCase(sTemp3);
          sTemp2 := copy(sTemp2, 1, length(sTemp2) - 3) + sTemp3 + ' ';
        end;
      end;
    end;
    sTemp4 := sTemp2;
  except
    sTemp4 := '';
  end;
  lsResult := sTemp4;
  SetParamValue(0, sTemp4);
  SetParamValue(1, lsResult);
end;

{ TExtensoFunction }

class function TExtensoFunction.Category: string;
begin
  Result := 'MR';
end;

procedure TExtensoFunction.ExecuteFunction(aParams: TraParamList);
var
  sTemp1: double;
  sTemp2, lsResult: string;
begin
  GetParamValue(0, sTemp1);

  //sTemp2 := Extenso(sTemp1);
  lsResult := STemp2;

  SetParamValue(0, sTemp1);
  SetParamValue(1, lsResult);
end;

class function TExtensoFunction.GetSignature: string;
begin
  result := 'Function Extenso(Valor: double):string;';
end;


{ TGetUsuarioFunction }
class function TGetUsuarioFunction.Category: string;
begin
  Result := 'MR';
end;

procedure TGetUsuarioFunction.ExecuteFunction(aParams: TraParamList);
var
  sUsuario : string;
  lbResult: Boolean;
begin
  GetParamValue(0, sUsuario);
  sUsuario := DM.fUser.UserName;
  lbResult := True;
  SetParamValue(0, sUsuario);
  SetParamValue(1, lbResult);
end;

class function TGetUsuarioFunction.GetSignature: string;
begin
  result := 'function GetUsuario(var sUsuario : String): Boolean;';
end;

{ TSIGRBGetDefaultLanguageFunction class }
class function TDefaultLanguageFunction.Category: string;
begin
  Result := 'MR';
end;

procedure TDefaultLanguageFunction.ExecuteFunction(aParams: TraParamList);
var
  iLang   : Integer;
  lbResult: Boolean;
begin
  lbResult := True;
  iLang    := DMGlobal.IDLanguage;
  SetParamValue(0, iLang);
  SetParamValue(1, lbResult);
end;

class function TDefaultLanguageFunction.GetSignature: string;
begin
  result := 'function GetIDLanguage(var IDLang: Integer):Boolean;';
end;
{
procedure TForm1.SendControlCode(S: string);
 end;
}

{ TPrintCommandFunction }

class function TPrintCommandFunction.Category: string;
begin
  Result := 'MR';
end;

procedure TPrintCommandFunction.ExecuteFunction(aParams: TraParamList);

type
  TppEscapeDataRec = packed record
    DataLen: Word;
    DataBuf: Array [0..128] of Char;
  end;

var
  lEscapeDataRec: TppEscapeDataRec;
  AReport: TppReport;
  aPrinterCommands : String;
  iResult : Integer;
begin

  GetParamValue(0, AReport);
  GetParamValue(1, aPrinterCommands);

  // setup the data
  lEscapeDataRec.DataLen := Length(aPrinterCommands);

  StrLCopy(lEscapeDataRec.DataBuf, PChar(aPrinterCommands), 128);

  // Windows API Escape call
  Escape(AReport.Printer.Canvas.Handle, PASSTHROUGH, 0, @lEscapeDataRec, nil);
  //iResult := Escape(AReport.Printer.Canvas.Handle, PASSTHROUGH, SizeOf(lEscapeDataRec), @lEscapeDataRec, nil);

  //SetParamValue(2, bResult);
end;

(*
var
  Handle, hDeviceMode: THandle;
  N: DWORD;
  DocInfo1: TDocInfo1;
  Device, Driver, Port: array[0..255] of char;
  PrinterName: string;
  buf:array[0..255] of char;
  lbuf:integer;
  s : String;
  lbResult : Boolean;
begin
  GetParamValue(0, s);
  lbResult := True;

  s := Chr(27)+Chr(12);

  //Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  PrinterName := DM.fPrintReceipt.InvoiceReportPrinter; //Format('%s', [Device]);
  if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    lbResult := False;
   //RaiseLastWin32Error;
  try
   with DocInfo1 do
   begin
    pDocName := 'Control';
    pOutputFile := nil;
    pDataType := 'RAW';
   end;
   StartDocPrinter(Handle, 1, @DocInfo1);
   try
    lbuf:=length(s);
    copymemory(@buf,Pchar(s),lbuf);
    if not WritePrinter(Handle, @buf, lbuf, N) then
      lbResult := False;
    // RaiseLastWin32Error;
   finally
    EndDocPrinter(Handle);
   end;
  finally
   ClosePrinter(Handle);
   SetParamValue(1, lbResult);
  end;

end;  *)

class function TPrintCommandFunction.GetSignature: string;
begin
  result := 'function PrintCommand(AReport: TppReport; Command: String):Boolean;';
end;

initialization
  raRegisterFunction('FormatName', TFormatFunction);
  raRegisterFunction('Extenso', TExtensoFunction);
  raRegisterFunction('GetUsuario', TGetUsuarioFunction);
  raRegisterFunction('GetIDLanguage', TDefaultLanguageFunction);
  raRegisterFunction('PrintCommand', TPrintCommandFunction);

finalization
  raUnRegisterFunction('FormatName');
  raUnRegisterFunction('Extenso');
  raUnRegisterFunction('GetUsuario');
  raUnRegisterFunction('GetIDLanguage');
  raUnRegisterFunction('PrintCommand');

end.
