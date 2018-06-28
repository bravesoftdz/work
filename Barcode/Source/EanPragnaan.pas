unit EanPragnaan;

interface

uses Classes, Windows, Graphics, EanKod, EanQr, EanDBQR, PsQrExport, Qrctrls;
{$include ean.inc}

type
        TPsQrEan=class(TQrEan)
        protected
                procedure Print(OfsX, OfsY: Integer); override;
        end;

{$ifdef PSOFT_BARCODE_DB}
        TPsQrDBEan=class(TQrDBEan)
        protected
                procedure Print(OfsX, OfsY: Integer); override;
        end;
{$endif}

implementation

{ TPsQrEan }

procedure DoBeginImage(AControl: TQRCustomEan; OfsX, OfsY: Integer);
var B:TBitmap;
    R:TRect;
begin
    with AControl do
        if Enabled and (ParentReport <> nil) and
                ParentReport.Exporting and (ParentReport.ExportFilter is TPsQRDocumentFilter) then
                begin
                        R:=QrCalcRect(OfsX, OfsY);
                        B:=TBitmap.Create;
                        try
                                Dec(R.Right, R.Left);
                                R.Left := 0;
                                Dec(R.Bottom, R.Top);
                                R.Top:= 0;

                                B.Width  := R.Right -R.Left;
                                B.Height := R.Bottom-R.Top;
                                PaintBarCode(B.Canvas,R,AControl.Ean);

                                TPsQRDocumentFilter(ParentReport.ExportFilter).BitmapOut(AControl, B, OfsX+Size.Left, OfsY+Size.Top, False, False);
                        finally
                                B.Free;
                        end;
                end;
end;

procedure TPsQrEan.Print(OfsX, OfsY: Integer);
begin
        DoBeginImage(Self, OfsX, OfsY);
        inherited Print(OfsX, OfsY);
end;

{ TPsQrDBEan }

{$ifdef PSOFT_BARCODE_DB}
        procedure TPsQrDBEan.Print(OfsX, OfsY: Integer);
        begin
                DoBeginImage(Self, OfsX, OfsY);
                inherited Print(OfsX, OfsY);
        end;
{$endif}
end.
