unit tBarcodePrint;

interface

uses
  Classes, uFrmBarcodePrintSingle, SysUtils;

type
  TThreadBarcodePrint = class(TThread)
  private
    FFrmBarcodePrintSingle : TFrmBarcodePrintSingle;
  protected
    procedure Execute; override;
    procedure PrintBarcode;
  public
    // amfsouza 05.04.2012 - passing suggestion retail parameter
    procedure AddBarcode(AModel, ABarcode, ADescription: String;
         NumCopies: Integer; ASellingPrice, sugg_retail: Currency);
    procedure SetReport(AReport, APrinter : String);
  end;

implementation

uses Forms;

{ tBarcodePrint }

procedure TThreadBarcodePrint.AddBarcode(AModel, ABarcode, ADescription: String;
  NumCopies: Integer; ASellingPrice, sugg_retail: Currency);
begin

  if FFrmBarcodePrintSingle = nil then
    FFrmBarcodePrintSingle := TFrmBarcodePrintSingle.Create(nil);

  FFrmBarcodePrintSingle.AddBarcode(AModel, ABarcode, ADescription, NumCopies, ASellingPrice, sugg_retail);

end;

procedure TThreadBarcodePrint.Execute;
begin
  PrintBarcode;
end;

procedure TThreadBarcodePrint.PrintBarcode;
begin

  if FFrmBarcodePrintSingle <> nil then
  try
    FFrmBarcodePrintSingle.PrintBarcodes;
    FFrmBarcodePrintSingle.ClearBarcodes;
  finally
    FreeAndNil(FFrmBarcodePrintSingle);
  end;

end;

procedure TThreadBarcodePrint.SetReport(AReport, APrinter: String);
begin

  if FFrmBarcodePrintSingle = nil then
    FFrmBarcodePrintSingle := TFrmBarcodePrintSingle.Create(nil);

  FFrmBarcodePrintSingle.SetReport(AReport, APrinter);

end;

end.
