unit EanRegEditors;

interface

{$I ean.inc}

uses
        {$ifdef PSOFT_CLX}
                DesignEditors,DesignIntf;
        {$else}
                Windows, ShellAPI,
                {$ifndef PSOFT_D6}DsgnIntf
                {$else}
                        DesignEditors, DesignIntf
                {$endif};

        {$endif}



type
   TEanEditor =class(TDefaultEditor)
   public
        procedure Edit; override;
   	procedure ExecuteVerb(Index: Integer); override;
   	function GetVerb(Index: Integer): string; override;
   	function GetVerbCount: Integer; override;
   end;

   {$ifdef PSOFT_PDF417}
   TPDF417PropertyEditor=class(TClassProperty)
   public
         function  GetAttributes:TPropertyAttributes; override;
         procedure Edit; override;
   end;
   {$endif}

   {$ifdef PSOFT_ACE}
   TAceEanEditor =class(TDefaultEditor)
   public
   	procedure ExecuteVerb(Index: Integer); override;
   	function GetVerb(Index: Integer): string; override;
   	function GetVerbCount: Integer; override;
   end;
   {$endif}



procedure Register;


implementation

uses EanKod,EanDB, 
     {$ifdef PSOFT_QREPORT} EanQR,EanDBQr, {$endif}
     {$ifdef PSOFT_ACE} EanAce, EanAceDB,  {$endif}
     Classes;

procedure TEanEditor.Edit;
begin
        ExecuteVerb(1);
end;

procedure TEanEditor.ExecuteVerb(Index: Integer);
var E:TCustomEan;
begin
   E:=nil;
   if Component is TCustomEan then E:=TCustomEan(Component);
   {$ifdef PSOFT_QREPORT}
    if Component is TQrCustomEan then E:=TQrCustomEan(Component).Ean;
   {$endif}

   if E<>nil then
	case Index of
		0 : E.Copyright;
                1 : E.ActiveSetupWindow('');
                2 : E.PrintDialog;
            {$ifndef PSOFT_CLX}
                3 : ShellExecute(0, 'open', PChar(BarcodeLibraryHomePage), nil, nil, SW_SHOWNORMAL);
                4 : ShellExecute(0, 'open', PChar('mailto:'+BarcodeLibraryEmail), nil, nil, SW_SHOWNORMAL);
                5 : ShellExecute(0, 'open', PChar(BarcodeLibraryRegisterString), nil, nil, SW_SHOWNORMAL);
            {$endif}
	end;
end;

function TEanEditor.GetVerb(Index: Integer): String;
begin
	case Index of
		0 : Result := 'Barcode library - PSOFT company ©1998-2002';
                1 : Result := 'Barcode properties editor';
                2 : Result := 'Barcode - Print';
            {$ifndef PSOFT_CLX}
                3 : Result := 'Barcode library homepage';
                4 : Result := 'Barcode library - send email to authors';
                5 : Result := 'Online registration of Barcode library';
            {$endif}
	end;
end;

function TEanEditor.GetVerbCount: Integer;
begin
     {$ifdef PSOFT_CLX}
	Result:= 3;
     {$else}
	Result:= 6;
     {$endif}
end;


{$ifdef PSOFT_PDF417}
function  TPDF417PropertyEditor.GetAttributes:TPropertyAttributes;
begin
     Result := [paDialog, paSubProperties];
end;


procedure TPDF417PropertyEditor.Edit;
var E:TCustomEan;
begin
     E:=TCustomEan(TpsPDF417(GetOrdValue).Ean);
     E.ActiveSetupWindow('SH_PDF417');
end;
{$endif}



{$ifdef PSOFT_ACE}
procedure TAceEanEditor.ExecuteVerb(Index: Integer);
var E:TCustomEan;
begin
   if Component is TAceCustomEan then E:=TAceCustomEan(Component).Ean
   else                               E:=nil;

   if E<>nil then
	case Index of
		0 : E.Copyright;
                1 : E.ActiveSetupWindow('');
                2 : E.PrintDialog;
            {$ifndef PSOFT_CLX}
                3 : ShellExecute(0, 'open', PChar(BarcodeLibraryHomePage), nil, nil, SW_SHOWNORMAL);
                4 : ShellExecute(0, 'open', PChar('mailto:'+BarcodeLibraryEmail), nil, nil, SW_SHOWNORMAL);
                5 : ShellExecute(0, 'open', PChar(BarcodeLibraryRegisterString), nil, nil, SW_SHOWNORMAL);
            {$endif}
	end;
end;

function TAceEanEditor.GetVerb(Index: Integer): String;
begin
	case Index of
		0 : Result := 'Barcode library - PSOFT company ©1998-2002';
                1 : Result := 'Barcode properties editor';
                2 : Result := 'Barcode print';
            {$ifndef PSOFT_CLX}
                3 : Result := 'Barcode library homepage';
                4 : Result := 'Barcode library - send email to authors';
                5 : Result := 'Online registration of Barcode library';
            {$endif}
	end;
end;

function TAceEanEditor.GetVerbCount: Integer;
begin
     {$ifdef PSOFT_CLX}
            Result := 3;
     {$else}
	    Result := 6;
     {$endif}
end;
{$endif}


procedure Register;
begin
     RegisterComponentEditor(TCustomEAN,   TEanEditor);
     {$ifdef PSOFT_QREPORT}
             RegisterComponentEditor(TQRCustomEAN, TEanEditor);
     {$endif}

     {$ifdef PSOFT_PDF417}
             RegisterPropertyEditor(TypeInfo(TpsPDF417), nil, '',TPDF417PropertyEditor);
     {$endif}

     {$ifdef PSOFT_ACE}
             RegisterComponentEditor(TAceEAN,        TAceEanEditor);
             RegisterComponentEditor(TAceDBEAN,      TAceEanEditor);
     {$endif}

end;

end.
