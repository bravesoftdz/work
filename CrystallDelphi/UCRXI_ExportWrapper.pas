unit UCRXI_ExportWrapper;

interface
uses
  Windows, SysUtils;
type
	TExportExcelDataOnlyToApplication = function (job: SmallInt;
                                                AppFileName: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool; stdcall;

	TExportExcelDataOnlyToMAPI        = function (job: SmallInt;
                                                toList: PChar;
                                                ccList: PChar;
                                                subject: PChar;
                                                body: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool; stdcall;

		TExportExcelDataOnlyToDisk = function (job: SmallInt;
                                                DiskFileName: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool; stdcall;

	TExportExcelToApplication = function (job: SmallInt;
                                        AppFileName: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool; stdcall;

  TExportExcelToDisk =        function (job: SmallInt;
                                        DiskFileName: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool; stdcall;

  TExportExcelToMAPI =        function (job: SmallInt;
                                        toList: PChar;
                                        ccList: PChar;
                                        subject: PChar;
                                        body: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool; stdcall;


	TExportEditableRTFToApplication = function (job: SmallInt;
                                              AppFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool; stdcall;
	TExportEditableRTFToDisk =        function (job: SmallInt;
                                              DiskFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool; stdcall;

	TExportEditableRTFToMAPI =        function (job: SmallInt;
                                              toList  : PChar;
                                              ccList  : PChar;
                                              subject : PChar;
                                              body    : PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool; stdcall;
//hwndExportWrapper     : HWnd; {CRPE32.DLL Engine Handle}
type
   TXIExportWrapper = class
   public
      function ExportExcelDataOnlyToApplication (job: SmallInt;
                                                AppFileName: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool;

      function ExportExcelDataOnlyToMAPI       (job: SmallInt;
                                                toList: PChar;
                                                ccList: PChar;
                                                subject: PChar;
                                                body: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool;

	   function	ExportExcelDataOnlyToDisk        (job: SmallInt;
                                                DiskFileName: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool;

	   function ExportExcelToApplication    (job: SmallInt;
                                        AppFileName: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool;

      function ExportExcelToDisk       (job: SmallInt;
                                        DiskFileName: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool;

     function ExportExcelToMAPI        (job: SmallInt;
                                        toList: PChar;
                                        ccList: PChar;
                                        subject: PChar;
                                        body: PChar;
                                        UseConstantColumnWidth: Bool;
                                        ConstantColumnWidth: double;
                                        baseAreaType: PChar;
                                        createPageBreaks: Bool;
                                        convertDateToString: Bool;
                                        showGridlines: Bool;
                                        firstPageNumber: Cardinal;
                                        lastPageNumber: Cardinal;
                                        ExportPageHeadersAndFooters: SmallInt
                                        ): Bool;

    function ExportEditableRTFToApplication  (job: SmallInt;
                                              AppFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;

	  function ExportEditableRTFToDisk         (job: SmallInt;
                                              DiskFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;

    function ExportEditableRTFToMAPI         (job: SmallInt;
                                              toList: PChar;
                                              ccList: PChar;
                                              subject: PChar;
                                              body: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;
    public
      hwndExportWrapper     : HWnd; {CRXI_ExportWrapper.dll Handle}
    constructor Create ();
    destructor Destroy; override;
end;

implementation
constructor TXIExportWrapper.Create;
var
   s1, s2 : String;
begin
   inherited Create();
   hwndExportWrapper := 0;
   hwndExportWrapper := LoadLibrary('CRXI_ExportWrapper.dll');
   if (hwndExportWrapper < HINSTANCE_ERROR) then begin
    s2 := SysErrorMessage(GetLastError);
    if Trim(s2) = '' then
      s1 := 'Error loading CRXI_ExportWrapper.dll' + Chr(10) +
        'Windows Error Number: ' + IntToStr(GetLastError)
    else
      s1 := 'Error loading CRXI_ExportWrapper.dll' + Chr(10) +
        'Windows Error Number: ' + IntToStr(GetLastError) + ' - ' + Trim(s2);
    MessageBox(0,PChar(s1), '', 0);
    end;
end;

destructor TXIExportWrapper.Destroy;
begin
   if (hwndExportWrapper > 0) then
      FreeLibrary(hwndExportWrapper);
   inherited Destroy();
end;
function TXIExportWrapper.ExportExcelDataOnlyToApplication (job: SmallInt;
                                                AppFileName: PChar;
                                                UseConstantColumnWidth: Bool;
                                                ConstantColumnWidth: double;
                                                baseAreaType: PChar;
                                                UseWorksheetFunctions: Bool;
                                                SimplifyPageHeader: Bool;
                                                ExportImages: Bool;
                                                ExportObjectFormatting: Bool;
                                                MaintainColumnAlignment: Bool;
                                                MaintainRelativeObjectPosition: Bool;
                                                ExportPageHeaderAndFooter: Bool
                                                ): Bool;
var
   CrpeExportExcelDataOnlyToApplication : TFarProc;
begin
   CrpeExportExcelDataOnlyToApplication := GetProcAddress(hwndExportWrapper, 'crpeExportExcelDataOnlyToApplication');
   Result := TExportExcelDataOnlyToApplication(CrpeExportExcelDataOnlyToApplication)
                (job, AppFileName, UseConstantColumnWidth, ConstantColumnWidth, baseAreaType,
                 UseWorksheetFunctions, SimplifyPageHeader, ExportImages, ExportObjectFormatting,
                 MaintainColumnAlignment, MaintainRelativeObjectPosition, ExportPageHeaderAndFooter);
end;

function TXIExportWrapper.ExportExcelDataOnlyToMAPI (job: SmallInt;
                                    toList: PChar;
                                    ccList: PChar;
                                    subject: PChar;
                                    body: PChar;
                                    UseConstantColumnWidth: Bool;
                                    ConstantColumnWidth: double;
                                    baseAreaType: PChar;
                                    UseWorksheetFunctions: Bool;
                                    SimplifyPageHeader: Bool;
                                    ExportImages: Bool;
                                    ExportObjectFormatting: Bool;
                                    MaintainColumnAlignment: Bool;
                                    MaintainRelativeObjectPosition: Bool;
                                    ExportPageHeaderAndFooter: Bool
                                    ) : Bool;
var
   CrpeExportExcelDataOnlyToMAPI : TFarProc;
begin
   CrpeExportExcelDataOnlyToMAPI := GetProcAddress(hwndExportWrapper, 'crpeExportExcelDataOnlyToMAPI');
   Result := TExportExcelDataOnlyToMAPI(CrpeExportExcelDataOnlyToMAPI)
               (job, toList, ccList, subject, body, UseConstantColumnWidth,
                ConstantColumnWidth, baseAreaType, UseWorksheetFunctions, SimplifyPageHeader,
                ExportImages, ExportObjectFormatting, MaintainColumnAlignment,
                MaintainRelativeObjectPosition, ExportPageHeaderAndFooter);
end;

function TXIExportWrapper.ExportExcelDataOnlyToDisk( job: SmallInt;
                                    DiskFileName: PChar;
                                    UseConstantColumnWidth: Bool;
                                    ConstantColumnWidth: double;
                                    baseAreaType: PChar;
                                    UseWorksheetFunctions: Bool;
                                    SimplifyPageHeader: Bool;
                                    ExportImages: Bool;
                                    ExportObjectFormatting: Bool;
                                    MaintainColumnAlignment: Bool;
                                    MaintainRelativeObjectPosition: Bool;
                                    ExportPageHeaderAndFooter: Bool) : Bool;
var
   CrpeExportExcelDataOnlyToDisk : TFarProc;
begin
   CrpeExportExcelDataOnlyToDisk := GetProcAddress(hwndExportWrapper, 'crpeExportExcelDataOnlyToDisk');
   Result := TExportExcelDataOnlyToDisk(CrpeExportExcelDataOnlyToDisk)
               (job, DiskFileName, UseConstantColumnWidth,
                ConstantColumnWidth, baseAreaType, UseWorksheetFunctions, SimplifyPageHeader,
                ExportImages, ExportObjectFormatting, MaintainColumnAlignment,
                MaintainRelativeObjectPosition, ExportPageHeaderAndFooter);
end;

function TXIExportWrapper.ExportExcelToApplication (job: SmallInt;
                                   AppFileName: PChar;
                                   UseConstantColumnWidth: Bool;
                                   ConstantColumnWidth: double;
                                   baseAreaType: PChar;
                                   createPageBreaks: Bool;
                                   convertDateToString: Bool;
                                   showGridlines: Bool;
                                   firstPageNumber: Cardinal;
                                   lastPageNumber: Cardinal;
                                   ExportPageHeadersAndFooters: SmallInt
                                   ): Bool;
var
   CrpeExportExcelToApplication : TFarProc;
begin
   CrpeExportExcelToApplication := GetProcAddress(hwndExportWrapper, 'crpeExportExcelToApplication');
   Result := TExportExcelToApplication(CrpeExportExcelToApplication)
               (job,AppFileName,UseConstantColumnWidth,ConstantColumnWidth,baseAreaType,
               createPageBreaks,convertDateToString,showGridlines,firstPageNumber,
               lastPageNumber,ExportPageHeadersAndFooters);
end;
function TXIExportWrapper.ExportExcelToDisk (job: SmallInt;
                            DiskFileName: PChar;
                            UseConstantColumnWidth: Bool;
                            ConstantColumnWidth: double;
                            baseAreaType: PChar;
                            createPageBreaks: Bool;
                            convertDateToString: Bool;
                            showGridlines: Bool;
                            firstPageNumber: Cardinal;
                            lastPageNumber: Cardinal;
                            ExportPageHeadersAndFooters: SmallInt
                            ): Bool;
var
   CrpeExportExcelToDisk : TFarProc;
begin
   CrpeExportExcelToDisk := GetProcAddress(hwndExportWrapper, 'crpeExportExcelToDisk');
   Result := TExportExcelToDisk(CrpeExportExcelToDisk)
               (job,DiskFileName,UseConstantColumnWidth,ConstantColumnWidth,baseAreaType,
               createPageBreaks,convertDateToString,showGridlines,firstPageNumber,
               lastPageNumber,ExportPageHeadersAndFooters);
end;

function TXIExportWrapper.ExportExcelToMAPI (job: SmallInt;
                            toList: PChar;
                            ccList: PChar;
                            subject: PChar;
                            body: PChar;
                            UseConstantColumnWidth: Bool;
                            ConstantColumnWidth: double;
                            baseAreaType: PChar;
                            createPageBreaks: Bool;
                            convertDateToString: Bool;
                            showGridlines: Bool;
                            firstPageNumber: Cardinal;
                            lastPageNumber: Cardinal;
                            ExportPageHeadersAndFooters: SmallInt
                            ): Bool;
var
   CrpeExportExcelToMAPI : TFarProc;
begin
   CrpeExportExcelToMAPI := GetProcAddress(hwndExportWrapper, 'crpeExportExcelToMAPI');
   Result := TExportExcelToMAPI(CrpeExportExcelToMAPI)
               (job,toList,ccList,subject,body,UseConstantColumnWidth,
               ConstantColumnWidth,baseAreaType, createPageBreaks,
               convertDateToString,showGridlines,firstPageNumber,
               lastPageNumber,ExportPageHeadersAndFooters);
end;
function TXIExportWrapper.ExportEditableRTFToApplication (job: SmallInt;
                                              AppFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;
var
   CrpeExportEditableRTFToApplication : TFarProc;
begin
   CrpeExportEditableRTFToApplication := GetProcAddress(hwndExportWrapper, 'crpeExportEditableRTFToApplication');
   Result := TExportEditableRTFToApplication(CrpeExportEditableRTFToApplication)
        (job, AppFileName, firstPageNumber, lastPageNumber, createPageBreaks);
end;

function TXIExportWrapper.ExportEditableRTFToDisk (job: SmallInt;
                                              DiskFileName: PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;
var
   CrpeExportEditableRTFToDisk : TFarProc;
begin
   CrpeExportEditableRTFToDisk := GetProcAddress(hwndExportWrapper, 'crpeExportEditableRTFToDisk');
   Result := TExportEditableRTFToDisk(CrpeExportEditableRTFToDisk)
        (job, DiskFileName, firstPageNumber, lastPageNumber, createPageBreaks);

end;

function TXIExportWrapper.ExportEditableRTFToMAPI (job: SmallInt;
                                              toList : PChar;
                                              ccList : PChar;
                                              subject: PChar;
                                              body   : PChar;
                                              firstPageNumber: Cardinal;
                                              lastPageNumber: Cardinal;
                                              createPageBreaks: Bool): Bool;
var
   CrpeExportEditableRTFToMAPI : TFarProc;
begin
   CrpeExportEditableRTFToMAPI := GetProcAddress(hwndExportWrapper, 'crpeExportEditableRTFToMAPI');
   Result := TExportEditableRTFToMAPI(CrpeExportEditableRTFToMAPI)
        (job, toList, ccList, subject, body, firstPageNumber, lastPageNumber, createPageBreaks);
end;                                              
end.
