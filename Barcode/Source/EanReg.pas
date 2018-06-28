unit EanReg;

interface

{$I ean.inc}

{$ifdef PSOFT_ACE}
        {$R EanAce.res}
{$endif}

uses EanKod,{$ifdef PSOFT_BARCODE_DB} EanDB, {$endif}
        {$ifdef PSOFT_CLX}
        {$else}
            {$ifdef PSOFT_QREPORT}
                EanQR,
                {$ifdef PSOFT_BARCODE_DB}EanDBQr,{$endif}
            {$endif}

            {$ifdef PSOFT_PRAGNAAN}
                EanPragnaan,
            {$endif}

            {$ifdef PSOFT_ACE}
                EanAce,
                {$ifdef PSOFT_BARCODE_DB}EanAceDB,{$endif}
            {$endif}

            {$ifdef PSOFT_RB}
                    EanRB,
                    {$ifdef PSOFT_BARCODE_DB}EanRBDB,{$endif}
            {$endif}

            EanRead,
        {$endif}
        Classes;

procedure Register;


implementation


const PageEan = 'Barcode components';
procedure Register;
begin
     RegisterComponents(PageEan ,[TEan {$ifdef PSOFT_BARCODE_DB},TDBEan {$endif}]);
     {$ifdef PSOFT_CLX}
     {$else}
        RegisterComponents(PageEan ,[TBarcodeReader]);

        {$ifdef PSOFT_QREPORT}
                RegisterComponents(PageEan ,[TQREan{$ifdef PSOFT_BARCODE_DB}, TQRDBEan{$endif}]);
        {$endif}

        {$ifdef PSOFT_ACE}
                RegisterComponents(PageEan ,[TAceEan{$ifdef PSOFT_BARCODE_DB}, TAceDBEan{$endif}]);
        {$endif}

        {$ifdef PSOFT_RB}
                RegisterComponents(PageEan ,[TRBEan{$ifdef PSOFT_BARCODE_DB}, TRBDBEan{$endif}]);
        {$endif}

        {$ifdef PSOFT_PRAGNAAN}
                RegisterComponents(PageEan ,[TPsQREan{$ifdef PSOFT_BARCODE_DB}, TPsQRDBEan{$endif}]);
        {$endif}

     {$endif}
end;

end.
