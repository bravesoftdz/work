(*
-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/CRDynamic.pas $
 Version:            $Revision: #13 $
  Last Modified Date: $Date: 2005/01/14 $

 Copyright (c) 2002-2003 Crystal Decisions, Inc.
 895 Emerson St., Palo Alto, California, USA 94301.

 All rights reserved.

 This file contains confidential, proprietary information, trade secrets and copyrighted expressions
 that are the property of Crystal Decisions, Inc., 895 Emerson St., Palo Alto, California, USA 94301.

 Any disclosure, reproduction, sale or license of all or any part of the information or expression
 contained in this file is prohibited by California law and the United States copyright law, and may
 be subject to criminal penalties.

 If you are not an employee of Crystal Decisions or otherwise authorized in writing by Crystal Decisions
 to possess this file, please contact Crystal Decisions immediately at the address listed above.
-----------------------------------------------------------

Delphi Dynamic Declarations for CRPE32.DLL
============================================

Purpose  : This file presents a Dynamic API to the Crystal Reports
           Print Engine DLL.  This file will compile and execute in
           Delphi 7.
Language : Delphi 7.
Notes    : This file will create a CRDynamic.dcu when you use compile
           and build. To use the CRDynamic.dcu, you will need to add
           the following line of code to your 'uses' section of your
           Delphi application, eg.

           uses
             Classes, CRDynamic, ...;
*)

unit CRDynamic;

{$X+}  {Extended Syntax on}
{$A-}  {Word Align Data off}

{******************************************************************************}
{*** Interface Section ********************************************************}
{******************************************************************************}
interface

uses
  Classes, Windows;

const
  { Sizes for Variables }
  PE_BYTE_LEN      =  1;
  PE_CHAR_LEN      =  1;
  PE_WORD_LEN      =  2;
  PE_DWORD_LEN     =  4;
  PE_SMALLINT_LEN  =  2;
  PE_BOOL_LEN	   =  2;
  PE_LONGINT_LEN   =  8; {4 in 16 bit?}
  PE_LONGPTR_LEN   =  4;

  { Unchanged constants }
  PE_UNCHANGED       = -1;
  PE_UNCHANGED_COLOR = -2;
  PE_NO_COLOR        = $FFFFFFFF; { unsigned long }

{******************************************************************************}
{ Error Codes returned by the CRPE.DLL                                         }
{******************************************************************************}
  PE_ERR_NOERROR                     = 0;
  PE_ERR_NOTENOUGHMEMORY             = 500;
  PE_ERR_INVALIDJOBNO                = 501;
  PE_ERR_INVALIDHANDLE               = 502;
  PE_ERR_STRINGTOOLONG               = 503;
  PE_ERR_NOSUCHREPORT                = 504;
  PE_ERR_NODESTINATION               = 505;
  PE_ERR_BADFILENUMBER               = 506;
  PE_ERR_BADFILENAME                 = 507;
  PE_ERR_BADFIELDNUMBER              = 508;
  PE_ERR_BADFIELDNAME                = 509;
  PE_ERR_BADFORMULANAME              = 510;
  PE_ERR_BADSORTDIRECTION            = 511;
  PE_ERR_ENGINENOTOPEN               = 512;
  PE_ERR_INVALIDPRINTER              = 513;
  PE_ERR_PRINTFILEEXISTS             = 514;
  PE_ERR_BADFORMULATEXT              = 515;
  PE_ERR_BADGROUPSECTION             = 516;
  PE_ERR_ENGINEBUSY                  = 517;
  PE_ERR_BADSECTION                  = 518;
  PE_ERR_NOPRINTWINDOW               = 519;
  PE_ERR_JOBALREADYSTARTED           = 520;
  PE_ERR_BADSUMMARYFIELD             = 521;
  PE_ERR_NOTENOUGHSYSRES             = 522;
  PE_ERR_BADGROUPCONDITION           = 523;
  PE_ERR_JOBBUSY                     = 524;
  PE_ERR_BADREPORTFILE               = 525;
  PE_ERR_NODEFAULTPRINTER            = 526;
  PE_ERR_SQLSERVERERROR              = 527;
  PE_ERR_BADLINENUMBER               = 528;
  PE_ERR_DISKFULL                    = 529;
  PE_ERR_FILEERROR                   = 530;
  PE_ERR_INCORRECTPASSWORD           = 531;
  PE_ERR_BADDATABASEDLL              = 532;
  PE_ERR_BADDATABASEFILE             = 533;
  PE_ERR_ERRORINDATABASEDLL          = 534;
  PE_ERR_DATABASESESSION             = 535;
  PE_ERR_DATABASELOGON               = 536;
  PE_ERR_DATABASELOCATION            = 537;
  PE_ERR_BADSTRUCTSIZE               = 538;
  PE_ERR_BADDATE                     = 539;
  PE_ERR_BADEXPORTDLL                = 540;
  PE_ERR_ERRORINEXPORTDLL            = 541;
  PE_ERR_PREVATFIRSTPAGE             = 542;
  PE_ERR_NEXTATLASTPAGE              = 543;
  PE_ERR_CANNOTACCESSREPORT          = 544;
  PE_ERR_USERCANCELLED               = 545;
  PE_ERR_OLE2NOTLOADED               = 546;
  PE_ERR_BADCROSSTABGROUP            = 547;
  PE_ERR_NOCTSUMMARIZEDFIELD         = 548;
  PE_ERR_DESTINATIONNOTEXPORT        = 549;
  PE_ERR_INVALIDPAGENUMBER           = 550;
  PE_ERR_BADLABELNUMBER              = 551;
  PE_ERR_NOTSTOREDPROCEDURE          = 552;
  PE_ERR_INVALIDPARAMETER            = 553;
  PE_ERR_GRAPHNOTFOUND               = 554;
  PE_ERR_INVALIDGRAPHTYPE            = 555;
  PE_ERR_INVALIDGRAPHDATA            = 556;
  PE_ERR_CANNOTMOVEGRAPH             = 557;
  PE_ERR_INVALIDGRAPHTEXT            = 558;
  PE_ERR_INVALIDGRAPHOPT             = 559;
  PE_ERR_BADSECTIONHEIGHT            = 560;
  PE_ERR_BADVALUETYPE                = 561;
  PE_ERR_INVALIDSUBREPORTNAME        = 562;
  PE_ERR_FIELDEXIST                  = 563;
  PE_ERR_NOPARENTWINDOW              = 564; {dialog parent window}
  PE_ERR_INVALIDZOOMFACTOR           = 565; {zoom factor}
  PE_ERR_INVALIDLABELINFO            = 566;
  PE_ERR_PAGESIZEOVERFLOW            = 567;
  PE_ERR_LOWSYSTEMRESOURCES          = 568;
  PE_ERR_NOTUSINGDICTIONARY          = 569; {not using Crystal Dictionary/Query}
  PE_ERR_BADGROUPNUMBER              = 570;
  PE_ERR_INVALIDOBJECTFORMATNAME     = 571;
  PE_ERR_INVALIDNEGATIVEVALUE        = 572;
  PE_ERR_INVALIDMEMORYPOINTER        = 573;
  PE_ERR_INVALIDOBJECTTYPE           = 574;
  PE_ERR_INVALIDLINESTYLE            = 575;
  PE_ERR_INVALIDCROSSTABROWORCOL     = 576;
  PE_ERR_INVALIDGRAPHDATATYPE        = 577;
  PE_ERR_INVALIDPARAGRAPHNUMBER      = 578;
  PE_ERR_INVALIDALIGNMENT            = 579;
  PE_ERR_INVALIDTABSTOPNUMBER        = 580;
  PE_ERR_INVALIDEMBEDDEDFIELDNUMBER  = 581;
  PE_ERR_INVALIDSUBREPORTLINKNUMBER  = 582;
  PE_ERR_SUBREPORTLINKEXIST          = 583;
  PE_ERR_BADROWCOLVALUE              = 584;
  PE_ERR_INVALIDSUMMARYNUMBER        = 585;
  PE_ERR_INVALIDGRAPHDATAFIELDNUMBER = 586;
  PE_ERR_INVALIDSUBREPORTNUMBER      = 587;
  PE_ERR_INVALIDFIELDSCOPE           = 588;
  PE_ERR_INVALIDREPORTTYPE           = 589;
  PE_ERR_FIELDINUSE                  = 590;
  PE_ERR_INVALIDFILETYPE             = 591;
  PE_ERR_INVALIDTABLEALIASNAME       = 592;
  PE_ERR_INVALIDSPECIALVARTYPE       = 593;
  PE_ERR_INVALIDPARAMETERNUMBER      = 594;
  PE_ERR_INVALIDPAGEMARGINS          = 595;
  PE_ERR_REPORTONSECUREQUERY         = 596;
  PE_ERR_CANNOTOPENSECUREQUERY       = 597;
  PE_ERR_INVALIDSECTIONNUMBER        = 598;
  PE_ERR_SQLSERVERNOTOPENED          = 599;
  PE_ERR_INVALIDSUMMARYTYPE          = 603;
  PE_ERR_INVALIDDATABASELINKNUMBER   = 604;
  PE_ERR_NOTTOPLEVELJOB              = 605;
  PE_ERR_TABLENAMEEXIST              = 606;
  PE_ERR_INVALIDCURSOR               = 607;
  PE_ERR_FIRSTPASSNOTFINISHED        = 608;
  PE_ERR_CREATEDATASOURCE            = 609;
  PE_ERR_CREATEDRILLDOWNPARAMETERS   = 610;
  PE_ERR_ENCAPSULATINGPAGE           = 611;
  PE_ERR_ENCAPSULATINGTOTALLER       = 612;
  PE_ERR_CHECKFORDATASOURCECHANGES   = 613;
  PE_ERR_STARTBACKGROUNDPROCESSING   = 614;
  PE_ERR_DRILLONGRAPH                = 615;
  PE_ERR_GETLASTPAGEN                = 616;
  PE_ERR_GETPAGENFORGROUP            = 617;
  PE_ERR_GETACTUALPAGENUMBER         = 618;
  PE_ERR_SQLSERVERINUSE              = 619;
  PE_ERR_GROUPSORTFIELDNOTSET        = 620;
  PE_ERR_CANNOTSETSAVESUMMARIES      = 621;
  PE_ERR_LOADOLAPDATABASEMANAGER     = 622;
  PE_ERR_OPENOLAPCUBE                = 623;
  PE_ERR_READOLAPCUBEDATA            = 624;
  PE_ERR_CANNOTSAVEQUERY             = 626;
  PE_ERR_CANNOTREADQUERYDATA         = 627;
  PE_ERR_NDAYSOUTOFRANGE             = 628;
  PE_ERR_MAINREPORTFIELDLINKED       = 629;
  PE_ERR_INVALIDMAPPINGTYPEVALUE     = 630;
  PE_ERR_HITTESTFAILED               = 636;
  PE_ERR_BADSQLEXPRESSIONNAME        = 637; { no SQL expression by the specified *name* exists in this report. }
  PE_ERR_BADSQLEXPRESSIONNUMBER      = 638; { no SQL expression by the specified *number* exists in this report. }
  PE_ERR_BADSQLEXPRESSIONTEXT        = 639; { not a valid SQL expression }
  PE_ERR_INVALIDDEFAULTVALUEINDEX    = 641; { invalid index for default value of a parameter. }
  PE_ERR_NOMINMAXVALUE               = 642; { the specified PE_PF_* type does not have min/max values. }
  PE_ERR_INCONSISTANTTYPES           = 643; { if both min and max values are specified in PESetParameterMinMaxValue, }
                                            { the value types for the min and max must be the same. }
  PE_ERR_HASNOBROWSEFIELD            = 644; { the named parameter has no browse field defined. }
  PE_ERR_CANNOTLINKTABLES            = 645;
  PE_ERR_CREATEROUTER                = 646;
  PE_ERR_INVALIDFIELDINDEX           = 647;
  PE_ERR_INVALIDGRAPHTITLETYPE       = 648;
  PE_ERR_INVALIDGRAPHTITLEFONTTYPE   = 649;
  PE_ERR_PARAMTYPEDIFFERENT          = 650; { the type used in a add/set value API for a }
                                            { parameter differs with it's existing type. }
  PE_ERR_INCONSISTANTRANGETYPES      = 651; { the value type for both start & end range }
                                            { values must be the same. }
  PE_ERR_RANGEORDISCRETE             = 652; { an operation was attempted on a discrete parameter that is }
                                            { only legal for range parameters or vice versa. }
  PE_ERR_NOTMAINREPORT               = 654; { an operation was attempted that is disallowed for subreports. }
  PE_ERR_INVALIDCURRENTVALUEINDEX    = 655; { invalid index for current value of a parameter. }
  PE_ERR_LINKEDPARAMVALUE            = 656; { operation illegal on linked parameter. }
  PE_ERR_PROCESSINGLIMITREACHED      = 657; { Report processing time/recors limit reached. CIPE Only. }

  PE_ERR_INVALIDHILITEINDEX          = 658;
  PE_ERR_INVALIDHILITERANGECONDITION = 659; { invalid highlight range condition (PE_HE_RC_*). }
  PE_ERR_INVALIDHILITEBORDERSTYLE    = 660; { invalid highlight border style (PE_HE_BORDER_*). }
  PE_ERR_INVALIDRUNNINGTOTALINDEX    = 661; { invalid running total index }
  PE_ERR_INVALIDRUNNINGTOTALNAME     = 662; { a running total by the specified name does not exist. }
  PE_ERR_INVALIDRUNNINGTOTALCOND     = 663; { invalid running total evaluate or reset condition (PE_RT_TOTAL_*). }
  PE_ERR_RUNNINGTOTALCONDMISMATCH    = 664; { The condition type (evaluate or reset) does not match }
                                            {  the condition being set. }
  PE_ERR_INVALIDSUMMARYPARAMETER     = 665; { Parameter to summary operation must be unsigned integer or PE_UNCHANGED }
  PE_ERR_INVALIDMAPTHEMETYPE         = 666; { themeType is not PE_MAP_TT_* or PE_UNCHANGED. }
  PE_ERR_INVALIDMAPTHEMESIZE         = 667; { themeSize is not >= 0 or PE_UNCHANGED. }
  PE_ERR_INVALIDMAPDISTRIBUTIONMETHOD= 668; { distributionMethod is not PE_MAP_DM_* or PE_UNCHANGED. }
  PE_ERR_INVALIDMAPLEGENDTYPE        = 669; { legendType is not PE_MAP_LEGENDTYPE_* or PE_UNCHANGED. }
  PE_ERR_INVALIDMAPLEGENDTITLETYPE   = 670; { legendTitleType is PE_MAP_LTT_* or PE_UNCHANGED. }
  PE_ERR_INVALIDMAPTYPE              = 671; { The operation in not defined for the specified map. }
  PE_ERR_INVALIDPARAMETERRANGEINFO   = 672; { Invalid PE_RI_* combination. }
  PE_ERR_INVALIDOLAPCUBEINDEX        = 673;
  PE_ERR_INVALIDSORTMETHODINDEX      = 674; { Invalid sort method index. }
  PE_ERR_INVALIDGRAPHSUBTYPE         = 675; { Invalid PE_GST_* or }
                                            { PE_GST_* does not match PE_GT_* or }
                                            { PE_GST_* current graph type. }
  PE_ERR_BADGRAPHOPTIONINFO          = 676; { one of them members of PEGraphOptionInfo is out of range. }
  PE_ERR_BADGRAPHAXISINFO            = 677; { one of them members of PEGraphAxisInfo is out of range. }
  PE_ERR_INVALIDMAPORIENT            = 678; { Invalid PE_MAP_ORIENT_*. }
  PE_ERR_INVALIDSPPARAMETEROPERATION = 679; { An operation was attempted on a stored procedure parameter that is only legal for a report parameter. }
  PE_ERR_NOTEXTERNALSUBREPORT        = 680; { the subreport is not imported. }
  PE_ERR_BADFIELDINDEXNUMBER         = 681;
  PE_ERR_BACKGROUNDPROCESSINGERROR   = 685; { failed to submit the request for background processing }
  PE_ERR_MOREBACKGROUNDPROCESSINGREQUIRED = 686; { more background processing is needed before this request can be processed }
  PE_ERR_INVALIDPARAMETERVALUE       = 687;
  PE_ERR_INVALIDFORMULASYNTAXTYPE    = 688; { specified formula syntax not in PE_FST_* }
  PE_ERR_INVALIDCROPVALUE            = 689;
  PE_ERR_INVALIDCOLLATIONVALUE       = 690;
  PE_ERR_STARTPAGEGREATERSTOPPAGE    = 691;
  PE_ERR_INVALIDEXPORTFORMAT	     = 692;
  PE_ERR_BADALERTINGFIELDNUMBER      = 695; { Invalid number of Alerting Field, i.e. <0 or > the list size }
  PE_ERR_NORANGEFORPASSWORDPARAMETER = 696; { If the parameter is in password mode, only single discrete option is allowed. }
  PE_ERR_NOMUTEXGROUPBOOLWITHALLFALSE = 698; { Can't have mutually exclusive group with all FALSE boolean. }
  PE_ERR_CANTCHANGEALLOWEDITINGOPTION = 699; { Can't disallow editing if the parameter doesn't cotain at least one default value }
  PE_ERR_READONLYPARAMETEROPTION     = 700; { This parameter option is read only and cannot be changed }
  PE_ERR_MINGREATERTHANMAX           = 702; { The minimum cannot be greater than the maximum. }
  PE_ERR_INVALIDSTARTPAGE            = 703; { Specified start page is greater than the last page on the report }
  PE_ERR_INVALIDHILITEFONTSTYLE      = 704; { invalid highlight font style (PE_HE_FONTSTYLE_*)}
  PE_ERR_HIERARCHICALSUMMARYTYPE     = 705; {invalid Hierarchical Summary Type (PE_HST_*)}
  // Query Engine errors
  PE_ERR_UNKNOWNQUERYENGINEERROR     = 706;
  PE_ERR_QUERYENGINEERROR            = 707; {query engine error}
  PE_ERR_DATABASEFIELDNOTEXIST       = 708; // database field not exist
  PE_ERR_TABLENOTEXIST               = 709;
  PE_ERR_PARAMETERDOESNOTEXIST       = 710; // Not used anymore - it is replaced by PE_ERR_INVALIDPARAMETER
  PE_ERR_ALIASEXIST                  = 711; // Not used anymore - it is replaced by PE_ERR_TABLENAMEEXIST
  PE_ERR_SQLEXPRESSIONSNOTSUPPORTED  = 712;
  PE_ERR_LOGONFAILED                 = 713; // Not used anymore - it is replaced by PE_ERR_DATABASELOGON
  PE_ERR_TABLEINUSE                  = 714;
  PE_ERR_SAVEDATABASE                = 715;
  PE_ERR_SAVEQESESSION               = 716;
  PE_ERR_LOADDATABASE                = 717;
  PE_ERR_LOADQESESSION               = 718;
  PE_ERR_PROCESSINGLIMIT             = 719; // Not used anymore - it is replaced by PE_ERR_PROCESSINGLIMITREACHED
  PE_ERR_QEINITIALIZE                = 720;
  PE_ERR_SMARTLINKING                = 721;
  PE_ERR_ROWSETCOLUMNNOTFOUND        = 722;
  PE_ERR_OPENROWSET                  = 723;
  PE_ERR_CONNECTIONNOTFOUND          = 724;
  PE_ERR_CREATELINK                  = 725; // Not used anymore - it is replaced by PE_ERR_CANNOTLINKTABLES
  PE_ERR_DICTIONARYINTEGRITY         = 726; // Not used anymore - it is replaced by PE_ERR_BADREPORTFILE
  PE_ERR_DICTIONARYINTEGRITY2        = 727; // Not used anymore - it is replaced by PE_ERR_BADREPORTFILE
  PE_ERR_CREATEQUERYENGINE           = 728;
  PE_ERR_CANTCHANGEBOOLEANDEFAULT    = 729;
  PE_ERR_CANTTAKELIMITWITHBOOL       = 730;
  PE_ERR_CANTTAKELIMITWITHMASK       = 731;
  PE_ERR_NONZEROMINMAXWITHLIMIT      = 732;
  PE_ERR_CANTSHOWDESCRIPTIONWITHMASK = 733;
  PE_ERR_INVALIDVALUEOPTIONSFORBOOLEAN = 734;
  PE_ERR_INVALIDVALUEOPTIONSFORNONBOOLEAN = 735;
  PE_ERR_INVALIDMULTIPLEVALUE        = 736;
  PE_ERR_SAVEASLATESTVERSION         = 737;
  PE_ERR_DBDLLNOTSUPPORTED           = 738;
  PE_ERR_NOPASSWORDFORNONREPORTPARAM = 739;
  PE_ERR_REPORTPARTNOTFOUND          = 740;
  PE_ERR_MODIFYTEXT                  = 741;
  PE_ERR_INVALIDQEPROPERTY           = 742;     //Query Engine property not one of PE_QEP_*.
  PE_ERR_QEPROEPRTYCANNOTBECHANGED   = 743;     //Query Engine property cannot be changed
  PE_ERR_INVALIDREPORTPARTDATACONTEXT = 744;
  PE_ERR_REPORTPARTINFONOTMATCH		   = 745;
  PE_ERR_PRINTJOBLIMITEXCEED         = 746;     //Maximum # of print jobs has been exceeded
  PE_ERR_MISSUFMANGERDLL             = 747;     // ufmanager.dll is missing
  PE_ERR_DATACONTEXTNOTFOUND         = 748;
  PE_ERR_INVALIDREADINGORDER         = 749;
  PE_ERR_INVALIDLINESPACINGTYPE      = 750;
  PE_ERR_OBJECTNAME                  = 751; // PESetObjectName, PESetAreaName or PESetSectionName failed.
                                          // This is usually because there is already an object/section/area
                                          // on the report with the same name.
  PE_ERR_REPOSITORYNOTFOUND          = 752; //The named Report Object Repository could not be located.
  PE_ERR_REPOSITORYLOGONFAILED       = 753; //Failed to logon to the named Report Object Repository.
  PE_ERR_OTHERREPOSITORYERRROR       = 754; //Unnknown Report Object Repository error.
  PE_ERR_MBCS2UNICODE                = 994; // error converting from MBCS to UNICODE
  PE_ERR_UNICODE2MBCS                = 995; // error converting from UNICODE to MBCS
  PE_ERR_INVALID_PEENUM              = 996; // some PE_xx_yyyy is not in the specified allowable range.
  PE_ERR_OTHERERROR                  = 997;
  PE_ERR_INTERNALERROR               = 998; { programming error }
  PE_ERR_NOTIMPLEMENTED              = 999;


{******************************************************************************}
{ Open and Close Print Engine                                                  }
{******************************************************************************}
type
  TPEOpenEngine = function : Bool;  stdcall;
  TPECloseEngine = procedure;  stdcall;
  TPECanCloseEngine = function : Bool;  stdcall;

{ Set openEngineType to PE_OE_MULTI_THREADED if user calls CRPE from  }
{ a multi-threaded application. Once CRPE starts up in multi-threaded }
{ mode with PEOpenEngineEx, user should call PEOpenEngine or          }
{ PEOpenEngineEx to initialize CRPE for every thread that makes CRPE  }
{ API calls.                                                          }
{                                                                     }
{ Using PEOpenEngine () to start up CRPE, by default CRPE is in       }
{ single-threaded mode.                                               }
const
  PE_OE_SINGLE_THREADED            = $0000;
  PE_OE_MULTI_THREADED             = $0001;
  PE_OE_USE_BACKGROUND_THREADS     = $4000;
  PE_OE_LIMITED_FREE_THREADED_MODE = $8000;
  PE_OE_RESERVED                   = $8000;

type
  PEEngineOptions = record
    structSize     : Word;
    openEngineType : Word; {PE_OE_* type}
    multiThreadedClonedJobs: Bool;
    skipPerTaskInit: Bool;
    skipOleInit : Bool;
    maxNBackgroundThreads : Word;
  end;

  TPEOpenEngineEx = function (var EngineOptions: PEEngineOptions): Bool;  stdcall;

{******************************************************************************}
{ Open and Close Print Job (i.e. Report)                                       }
{******************************************************************************}
type
  TPEOpenPrintJob = function (reportFilePath: PChar): SmallInt;  stdcall;
  TPEClosePrintJob = function (printJob : Smallint): Bool;  stdcall;

const
  PE_DLLNAME_LEN      = 128;
  PE_SERVERNAME_LEN   = 128;
  PE_DATABASENAME_LEN = 128;
  PE_USERID_LEN       = 128;
  PE_PASSWORD_LEN     = 128;
  PE_SERVERTYPE_LEN   = 128;

type
  PEDllNameType = array[0..(PE_DLLNAME_LEN-1)] of Char;
  PEServerNameType = array[0..(PE_SERVERNAME_LEN-1)] of Char;
  PEDatabaseNameType = array[0..(PE_DATABASENAME_LEN-1)] of Char;
  PEUserIDType = array[0..(PE_USERID_LEN-1)] of Char;
  PEPasswordType = array[0..(PE_PASSWORD_LEN-1)] of Char;
  PEServerType = array[0..(PE_SERVERTYPE_LEN-1)] of Char;

  crBytePointer = ^Byte;
  PETablePrivateInfo = record
    structSize : Word;    { initialize to PE_SIZEOF_TABLE_PRIVATE_INFO }
    nBytes     : Smallint;
    tag        : DWord;
    dataPtr    : Pointer; {crBytePointer}
  end;

const
  PE_SIZEOF_TABLE_PRIVATE_INFO = SizeOf(PETablePrivateInfo);
  PE_TABLE_LOCATION_LEN    = 256;
  PE_CONNECTION_BUFFER_LEN = 512;

type
  PETableLocationType = array [0..PE_TABLE_LOCATION_LEN-1] of Char;
  PEConnectBufferType = array [0..PE_CONNECTION_BUFFER_LEN-1] of Char;
  PETableInfo = record
    StructSize    : Word;
    FileType      : Smallint; {a PE_FILT_ constant, ignored if serverInfo is NULL.}
    Location      : PETableLocationType;
    SubLocation   : PETableLocationType;
    ConnectBuffer : PEConnectBufferType; {Connection Info for attached tables}
  end;

const
  PE_SIZEOF_TABLE_INFO = SizeOf(PETableInfo);
  PE_FILE_PATH_LEN = 512;

type
  TPESavePrintJob = function (
    printJob       : Smallint;
    reportFilePath : PChar): Bool;  stdcall;

const
  { report save formats }
  PE_SAVEAS_FORMAT_SCRDEFAULT = LongInt(0); { Crystal Reports default report format }
  PE_SAVEAS_FORMAT_VSNet      = LongInt($1000); { VS Net file format, the latest format }

type
  TPESavePrintJobAs = function (
    printJob       : Smallint;
    reportFilePath : PChar;
    saveAsFormat   : LongInt; { a PE_SAVEAS_FORMAT_* }
    reserved       : Pointer  { ignored }
    ): Bool;  stdcall;

{******************************************************************************}
{ Start and Cancel Print Job                                                   }
{  - i.e. print the Report, usually after changing report                      }
{******************************************************************************}
type
  TPEStartPrintJob = function (
    printJob      : Smallint;
    waitUntilDone : Bool): Bool;  stdcall;

  TPECancelPrintJob = procedure(printJob: Smallint);  stdcall;
  TPESetRefreshData = procedure(printJob : Smallint; bUnknown: Bool);  stdcall;

{******************************************************************************}
{ Print Job Status                                                             }
{******************************************************************************}
type
  TPEIsPrintJobFinished = function (printJob: Smallint): Bool;  stdcall;

{ Status returns for PEGetJobStatus }
const
  PE_JOBNOTSTARTED = 1;
  PE_JOBINPROGRESS = 2;
  PE_JOBCOMPLETED  = 3;
  PE_JOBFAILED     = 4; {an error occurred}
  PE_JOBCANCELLED  = 5; {by User}
  PE_JOBHALTED     = 6; {too many records or too much time}

type
  PEJobInfo = record
    structSize         : Word;  {initialize to SizeOf(PEJobInfo)}
    NumRecordsRead     : DWord;
    NumRecordsSelected : DWord;
    NumRecordsPrinted  : DWord;
    DisplayPageN       : Word;  {the page being displayed in window}
    LatestPageN        : Word;  {the page being generated}
    StartPageN         : Word;  {user opted, default to 1}
    PrintEnded         : Bool;  {full report print completed?}
  end;

const
  PE_SIZEOF_JOB_INFO = SizeOf(PEJobInfo);

type
  TPEGetJobStatus = function (
    printJob    : Smallint;
    var jobInfo : PEJobInfo): SmallInt;  stdcall;

  TPESetTimeLimit = function (
    printJob  : Smallint;
    timeLimit : LongInt  {in Seconds}
  ): Bool;  stdcall;

  TPEGetPercentCompleted = function (printJob : Smallint): LongInt;  stdcall;

  TPESetReadRecordLimit = function (
    printJob     : Smallint;
    recordsLimit : Longint): Bool;  stdcall;

  TPEGetReadPercentCompleted = function (printJob: Smallint): LongInt;  stdcall;
  TPEIsJobPremature = function (printJob: Smallint): Bool;  stdcall;

{******************************************************************************}
{  Getting and setting Start Page number for                                   }
{  Page Number special var field definition                                    }
{******************************************************************************}
type
  TPEGetStartPageNumber = function (
    printJob  : Smallint;
    var pageN : Longint): Bool;  stdcall;

  TPESetStartPageNumber = function (
    printJob : Smallint;
    pageN    : Longint): Bool;  stdcall;

{******************************************************************************}
{ Get Version Info                                                             }
{******************************************************************************}
const
  PE_GV_DLL    = 100;
  PE_GV_ENGINE = 200;

type
  TPEGetVersion = function (versionRequested : Smallint) : SmallInt;  stdcall;

{******************************************************************************}
{ Print Job Error Codes and Messages                                           }
{******************************************************************************}
type
  TPEGetErrorCode = function (printJob : Smallint): SmallInt;  stdcall;

  TPEGetErrorText = function (
    printJob       : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPEGetHandleString = function (
    textHandle   : HWnd;
    buffer       : PChar;
    bufferLength : Smallint): Bool;  stdcall;

  TPEGetStringHandle = function (
    inStr        : PChar;
    var outStrHandle : HWnd;
    var outStrLength : DWord): Bool;  stdcall;

  TPEGetStringHandleExW = function (
    const inStr        : PWChar;
    var outStrHandle : HWnd;
    var outStrLength : DWord): Bool;  stdcall;

{******************************************************************************}
{ Open, Print and Close Report                                                 }
{  - used when no changes needed to report - Complete Default                  }
{******************************************************************************}
type
  TPEPrintReport = function (
    reportFilePath    : PChar;
    toDefaultPrinter,
    toWindow          : Bool;
    title             : PChar;
    left,
    top,
    width,
    height            : integer;
    style             : DWord;
    parentWindow      : Hwnd): Smallint;  stdcall;

{******************************************************************************}
{ Report Version                                                               }
{******************************************************************************}
type
  PEVersionInfo = record
    StructSize : Word;  {initialize to PE_SIZEOF_VERSION_INFO}
    major      : Word;
    minor      : Word;
    letter     : Char;
  end;

const
  PE_SIZEOF_VERSION_INFO = SizeOf(PEVersionInfo);

type
  TPEGetReportVersion = function (
    printJob        : Smallint;
    var VersionInfo : PEVersionInfo): Bool; stdcall;

{******************************************************************************}
{ Report Options                                                               }
{******************************************************************************}
const
  PE_RPTOPT_CVTDATETIMETOSTR  = 0;
  PE_RPTOPT_CVTDATETIMETODATE = 1;
  PE_RPTOPT_KEEPDATETIMETYPE  = 2;
  {Following are the valid values for promptMode}
  PE_RPTOPT_PROMPT_NONE   = 0;
  PE_RPTOPT_PROMPT_NORMAL = 1;
  PE_RPTOPT_PROMPT_ALWAYS = 2;

type
  PEReportOptions = record
    structSize                       : Word;  	  {initialize to PE_SIZEOF_REPORT_OPTIONS}
    saveDataWithReport               : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    saveSummariesWithReport          : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    useIndexForSpeed                 : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    translateDOSStrings              : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    translateDOSMemos                : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    convertDateTimeType              : Smallint;  {a PE_RPTOPT_ value, except use PE_UNCHANGED for no change}
    convertNullFieldToDefault        : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    morePrintEngineErrorMessages     : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    caseInsensitiveSQLData           : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    verifyOnEveryPrint               : Smallint;  {BOOL value, except use PE_UNCHAGED for no change}
    zoomMode                         : Smallint;  {a PE_ZOOM_ constant, except use PE_UNCHANGED for no change}
    hasGroupTree                     : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    dontGenerateDataForHiddenObjects : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    performGroupingOnServer          : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    doAsyncQuery                     : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    promptMode                       : Smallint;  {PE_RPTOPT_PROMPT_NONE, PE_RPTOPT_PROMPT_NORMAL, PE_RPTOPT_PROMPT_ALWAYS, use PE_UNCHANGED for no change}
    selectDistinctRecords            : Smallint;  {BOOL value, except use PE_UNCHANGED for no change}
    alwaysSortLocally                : Smallint;  {BOOL value, use PE_UNCHANGED for no change}
    isReadOnly                       : Smallint;  {BOOL value,  a read-only attribute}
    canSelectDistinctRecords         : Smallint;  {BOOL value,  a read-only attribute}
    useDummyData                     : Smallint; // PEBOOL value, except use PE_UNCHANGED for no change
    convertOtherNullsToDefault       : Smallint; //  PEBOOL value, except use PE_UNCHANGED for no change
    verifyStoredProceduresOnFirstRefresh : Smallint; // PEBOOL value, except use PE_UNCHANGED for no change
    keepImageColourDepth             : Smallint; // PEBOOL value, except use PE_UNCHANGED for no change
  end;

const
  PE_SIZEOF_REPORT_OPTIONS = SizeOf(PEReportOptions);

type
  TPEGetReportOptions = function (
    printJob          : Smallint;
    var ReportOptions : PEReportOptions): Bool;  stdcall;

  TPESetReportOptions = function (
    printJob          : Smallint;
    var ReportOptions : PEReportOptions): Bool;  stdcall;

{******************************************************************************}
{ Global Options                                                               }
{******************************************************************************}
type
  PEGlobalOptions = record
    StructSize                   : Word;
    morePrintEngineErrorMessages : Smallint; {BOOL value, PE_UNCHANGED for no change}
    matchLogOnInfo               : Smallint; {BOOL value, PE_UNCHANGED for no change}
    use70TextCompatibility       : Smallint; {BOOL value, PE_UNCHANGED for no change}
    disableThumbnailUpdates      : Smallint; {PEBOOL value, PE_UNCHANGED for no change}
  	verifyWhenDatabaseDriverUpgraded : Smallint; {PEBOOL value, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_GLOBAL_OPTIONS = SizeOf(PEGlobalOptions);

type
  TPESetGlobalOptions = function (var globalOptions: PEGlobalOptions): Bool;  stdcall;

{******************************************************************************}
{ Open and Close Subreport                                                     }
{******************************************************************************}
type
  TPEOpenSubreport = function (
    printJob      : Smallint;
    ReportName    : PChar): Smallint;  stdcall;

  TPECloseSubreport = function(printJob: Smallint): Bool;  stdcall;

{******************************************************************************}
{ Subreports                                                                   }
{******************************************************************************}
type
  TPEGetNSubreportsInSection = function (
    printJob    : Smallint;
    sectionCode : Smallint): Smallint;  stdcall;

  TPEGetNthSubreportInSection = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    subreportN  : Smallint): DWord;  stdcall;

const
  PE_SUBREPORT_NAME_LEN = 128;

type
  PESubreportNameType = array [0..PE_SUBREPORT_NAME_LEN-1] of Char;

  PESubreportInfo = record
    StructSize     : Word;     {Initialize to PE_SIZEOF_SUBREPORT_INFO}
    subreportName  : PESubreportNameType;
    NLinks         : Smallint; {number of links}
    {subreport placement}
    IsOnDemand     : Smallint; {TRUE if the subreport is on demand subreport}
    IsExternal     : Smallint; {1: the subreport is imported; 0: otherwise}
    reimportOption : Smallint; {PE_SRI_ONOPENJOB or PE_SRI_ONFUNCTIONCALL}
  end;

const
  PE_SIZEOF_SUBREPORT_INFO = SizeOf(PESubreportInfo);

type
  TPEGetSubreportInfo = function (
    printJob          : Smallint;
    subreportHandle   : DWord;
    var subreportInfo : PESubreportInfo): Bool;  stdcall;

{******************************************************************************}
{ Controlling Dialogs                                                          }
{******************************************************************************}
type
  TPESetDialogParentWindow = function (
    printJob     : Smallint;
    parentWindow : HWnd): Bool;  stdcall;

  TPEEnableProgressDialog = function (
    printJob : Smallint;
    enable   : Bool): Bool;  stdcall;

{******************************************************************************}
{ Controlling Parameter Field Prompting Dialog                                 }
{   Set boolean to indicate whether CRPE is allowed to prompt                  }
{   for parameter values during printing.                                      }
{******************************************************************************}
type
  TPEGetAllowPromptDialog = function (printJob: Smallint): Bool;  stdcall;

  TPESetAllowPromptDialog = function (
    printJob         : Smallint;
    showPromptDialog : Bool): Bool;  stdcall;

{******************************************************************************}
{ Print Date                                                                   }
{******************************************************************************}
type
  TPEGetPrintDate = function (
    printJob  : Smallint;
    var year  : Smallint;
    var month : Smallint;
    var day   : Smallint): Bool;  stdcall;

  TPESetPrintDate = function (
    printJob : Smallint;
    year     : Smallint;
    month    : Smallint;
    day      : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Encoding and Decoding Section Codes                                          }
{******************************************************************************}
{ Section constants }
{ For use with PE_SECTION_CODE, PE_SECTION_TYPE,
  PE_GROUP_N and PE_SECTION_N functions }
const
  PE_SECT_REPORT_HEADER = 1;
  PE_SECT_PAGE_HEADER   = 2;
  PE_SECT_GROUP_HEADER  = 3;
  PE_SECT_DETAIL        = 4;
  PE_SECT_GROUP_FOOTER  = 5;
  PE_SECT_PAGE_FOOTER   = 7;
  PE_SECT_REPORT_FOOTER = 8;
  PE_SECT_WHOLE_REPORT  = 255;

{ The old section constants with comment showing them in terms of the new: }
{ Note that PE_GRANDTOTALSECTION and PE_SUMMARYSECTION both map }
{ to PE_SECT_REPORT_FOOTER. }
  PE_ALLSECTIONS       =    0;
  PE_HEADERSECTION     = 2000;  {PE_SECTION_CODE (PE_SECT_PAGE_HEADER, 0, 0)}
  PE_FOOTERSECTION     = 7000;  {PE_SECTION_CODE (PE_SECT_PAGE_FOOTER, 0, 0)}
  PE_TITLESECTION      = 1000;  {PE_SECTION_CODE (PE_SECT_REPORT_HEADER, 0, 0)}
  PE_SUMMARYSECTION    = 8000;  {PE_SECTION_CODE (PE_SECT_REPORT_FOOTER, 0, 0)}
  PE_GROUPHEADER       = 3000;  {PE_SECTION_CODE (PE_SECT_GROUP_HEADER, 0, 0)}
  PE_GROUPFOOTER       = 5000;  {PE_SECTION_CODE (PE_SECT_GROUP_FOOTER, 0, 0)}
  PE_DETAILSECTION     = 4000;  {PE_SECTION_CODE (PE_SECT_DETAIL, 0, 0)}
  PE_GRANDTOTALSECTION = PE_SUMMARYSECTION;

  { A function to create section codes: }
  { This representation allows up to 25 groups and 40 sections of a given }
  { type, although Crystal Reports itself has no such limitations. }
  function PE_SECTION_CODE (sectionType, groupN, sectionN : Smallint): Smallint;
  { Functions to decode section and area codes: }
  function PE_SECTION_TYPE (sectionCode : Smallint): Smallint;
  function PE_GROUP_N (sectionCode : Smallint): Smallint;
  function PE_SECTION_N (sectionCode : Smallint): Smallint;
  function PE_AREA_CODE (sectionType, groupN : Smallint): Smallint;

{******************************************************************************}
{ Group Conditions (i.e. group breaks)                                         }
{******************************************************************************}
const
  PE_SF_MAX_NAME_LENGTH = 50;

  {Sort Direction}
  PE_SF_DESCENDING   = 0;
  PE_SF_ASCENDING    = 1;
  PE_SF_ORIGINAL     = 2;  {only for group condition}
  PE_SF_SPECIFIED    = 3;  {only for group condition}

{ for PEGetGroupCondition, condition encodes both }
{ the condition and the type of the condition field }
  PE_GC_CONDITIONMASK = $00FF;
  PE_GC_TYPEMASK      = $0F00;
  {Condition Type}
  PE_GC_TYPEOTHER     = $0000;
  PE_GC_TYPEDATE      = $0200;
  PE_GC_TYPEBOOLEAN   = $0400;
  PE_GC_TYPETIME      = $0800;
  PE_GC_TYPEDATETIME  = $0A00;

  { use PE_ANYCHANGE for all field types except Date }
  PE_GC_ANYCHANGE    = 0;
  { use these constants for Date fields }
  PE_GC_DAILY        = 0;
  PE_GC_WEEKLY       = 1;
  PE_GC_BIWEEKLY     = 2;
  PE_GC_SEMIMONTHLY  = 3;
  PE_GC_MONTHLY      = 4;
  PE_GC_QUARTERLY    = 5;
  PE_GC_SEMIANNUALLY = 6;
  PE_GC_ANNUALLY     = 7;
  { use these constants for Time  and DateTime fields }
  PE_GC_BYSECOND     =  8;
  PE_GC_BYMINUTE     =  9;
  PE_GC_BYHOUR       = 10;
  PE_GC_BYAMPM       = 11;
  { use these constants for Boolean fields }
  PE_GC_TOYES        = 1;
  PE_GC_TONO         = 2;
  PE_GC_EVERYYES     = 3;
  PE_GC_EVERYNO      = 4;
  PE_GC_NEXTISYES    = 5;
  PE_GC_NEXTISNO     = 6;

type
  TPEGetNGroups = function (printJob : Smallint) : Smallint;  stdcall;

  TPEGetGroupCondition = function (
    printJob                 : Smallint;
    sectionCode              : Smallint;
    var conditionFieldHandle : Hwnd;
    var conditionFieldLength : Smallint;
    var condition            : Smallint;
    var sortDirection        : Smallint): Bool;  stdcall;

  TPESetGroupCondition = function (
    printJob       : Smallint;
    sectionCode    : Smallint;
    conditionField : PChar;
    condition      : Smallint; {a PE_GC_ constant}
    sortDirection  : Smallint  {a PE_SF_ constant}): Bool;  stdcall;

  TPESwapGroups = function (
    printJob     : Smallint;
    sourceGroupN : Smallint;
    targetGroupN : Smallint): Bool;  stdcall;

const
  PE_FIELD_NAME_LEN             = 512;

  {TopN/BottomN Groups}
  PE_GO_TBN_ALL_GROUPS_UNSORTED = 0;
  PE_GO_TBN_ALL_GROUPS_SORTED   = 1;
  PE_GO_TBN_TOP_N_GROUPS        = 2;
  PE_GO_TBN_BOTTOM_N_GROUPS     = 3;

type
  PEFieldNameType = array[0..(PE_FIELD_NAME_LEN-1)] of Char;

  PEGroupOptions = record
    structSize                : Word;
    { When setting, pass a PE_GC_ constant, or PE_UNCHANGED for no change. }
    { When getting, use PE_GC_TYPEMASK and PE_GC_CONDITIONMASK to }
    {   decode the condition. }
    condition                 : Smallint;  {a PE_GC_ constant, or PE_UNCHANGED for no change.}
    FieldName                 : PEFieldNameType; { formula form, or empty for no change.}
    sortDirection             : Smallint;  { a PE_SF_ const, or PE_UNCHANGED for no change.}
    repeatGroupHeader         : Smallint;  { BOOL value, or PE_UNCHANGED for no change.}
    keepGroupTogether         : Smallint;  { BOOL value, or PE_UNCHANGED for no change.}
    topOrBottomNGroups        : Smallint;  { a PE_GO_TBN_ constant, or PE_UNCHANGED for no change.}
    topOrBottomNSortFieldName : PEFieldNameType; { formula form, or empty for no change.}
    nTopOrBottomGroups        : Smallint;  { the number of groups to keep,
                                             0 for all, or PE_UNCHANGED for no change.}
    discardOtherGroups        : Smallint;  { BOOL value, or PE_UNCHANGED for no change.}
    ignored                   : Smallint;  {for 4 byte alignment.}
    hierarchicalSorting       : Smallint;  { Boolean or PE_UNCHANGED }
    instanceIDField           : PEFieldNameType; { for hierarchical grouping }
    parentIDField             : PEFieldNameType; { for hierarchical grouping }
    groupIndent               : LongInt;   { twips }
    customizeGroupName        : Smallint;  {BOOL or PE_UNCHANGED}
    notInTopOrBottomNName     : PEFieldNameType; {empty for no change}
  end;

const
  PE_SIZEOF_GROUP_OPTIONS = SizeOf(PEGroupOptions);

type
  TPEGetGroupOptions = function (
    printJob         : Smallint;
    groupN           : Smallint;
    var groupOptions : PEGroupOptions): Bool;  stdcall;

  TPESetGroupOptions = function (
    printJob         : Smallint;
    groupN           : Smallint;
    var groupOptions : PEGroupOptions): Bool;  stdcall;

{******************************************************************************}
{ Getting Number of Sections and Section Code                                  }
{******************************************************************************}
type
  TPEGetNSections = function (printJob: Smallint): Smallint;  stdcall;

  TPEGetNSectionsInArea = function (
    printJob : Smallint;
    areaCode : Smallint): Smallint;  stdcall;

  TPEGetSectionCode = function (
    printJob : Smallint;
    nSection : Smallint): Smallint;  stdcall;

{******************************************************************************}
{ Section Height                                                               }
{   The PEGetMinimumSectionHeight/PESetMinimumSectionHeight API Calls          }
{   are obsolete (7.0+), please use PEGetSectionHeight/PESetSectionHeight      }
{   instead. The obsolete API calls will still work in older applications      }
{   but please use the NEW calls for all new Development.                      }
{   NOTE: Height or minimumHeight are in twips                                 }
{******************************************************************************}
type
  TPEGetMinimumSectionHeight = function (
    printJob          : Smallint;
    sectionCode       : Smallint;
    var minimumHeight : Smallint): Bool;  stdcall;

  TPESetMinimumSectionHeight = function (
    printJob : Smallint;
    sectionCode : smallint;
    minimumHeight : smallint) : Bool;  stdcall;

  TPEGetSectionHeight = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    var Height  : Smallint): Bool;  stdcall;

  TPESetSectionHeight = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    Height      : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Section Width                                                                }
{******************************************************************************}
type
  TPEGetSectionWidth = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    var width   : Smallint {twips}
  ): Bool;  stdcall;

{******************************************************************************}
{ Section or Area Format                                                       }
{******************************************************************************}
type
  PESectionOptions = record
    (*Initialize to PE_SIZEOF_SECTION_OPTIONS*)
    structSize           : Word;
    Visible              : Smallint; { BOOLEAN values, except use PE_UNCHANGED }
    newPageBefore        : Smallint; {  to preserve the existing settings      }
    newPageAfter         : Smallint;
    keepTogether         : Smallint;
    suppressBlankSection : Smallint;
    resetPageNAfter      : Smallint;
    printAtBottomOfPage  : Smallint;
    backgroundColor      : DWord;    { Use PE_UNCHANGED_COLOR to keep existing color }
                                     {  - also could be defined as COLORREF    }
    underlaySection      : Smallint; { BOOLEAN values, except use PE_UNCHANGED }
    showArea             : Smallint; {  to preserve the existing settings      }
    freeFormPlacement    : Smallint;
    reserveMinimumPageFooter : Smallint; { choose the maximum visible }
                                        { page footer section as reserve.}
    hCssClass            : HWnd;       // handle to styleclass contents (string).
    cssClassLen          : Smallint;   // length in bytes of hStyleClass,
  end;

const
  PE_SIZEOF_SECTION_OPTIONS = SizeOf(PESectionOptions);

type
  TPEGetSectionFormat = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    var options : PESectionOptions): Bool;  stdcall;

  TPESetSectionFormat = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    var options : PESectionOptions): Bool;  stdcall;

  TPEGetAreaFormat = function (
    printJob    : Smallint;
    areaCode    : Smallint;
    var options : PESectionOptions): Bool;  stdcall;

  TPESetAreaFormat = function (
    printJob    : Smallint;
    areaCode    : Smallint;
    var options : PESectionOptions): Bool;  stdcall;

{******************************************************************************}
{ Setting Font info                                                            }
{******************************************************************************}
const
  PE_FIELDS : Smallint = $0001;
  PE_TEXT   : Smallint = $0002;

type
  TPESetFont = function (
    printJob     : Smallint;
    sectionCode  : Smallint;
    scopeCode    : smallint;
    faceName     : PChar;
    fontFamily   : Smallint;
    fontPitch    : Smallint;
    charSet      : Smallint;
    pointSize    : Smallint;
    isItalic     : Smallint;
    isUnderlined : Smallint;
    isStruckOut  : Smallint;
    weight       : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Graphing                                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Graph Type                                                                   }
{------------------------------------------------------------------------------}
const
  PE_GT_BARCHART           =   0;
  PE_GT_LINECHART          =   1;
  PE_GT_AREACHART          =   2;
  PE_GT_PIECHART           =   3;
  PE_GT_DOUGHNUTCHART      =   4;
  PE_GT_THREEDRISERCHART   =   5;
  PE_GT_THREEDSURFACECHART =   6;
  PE_GT_SCATTERCHART       =   7;
  PE_GT_RADARCHART         =   8;
  PE_GT_BUBBLECHART        =   9;
  PE_GT_STOCKCHART         =  10;
  { These next two are for PEGetGraphTypeInfo only }
  { Do not use in PESetGraphTypeInfo }
  PE_GT_USERDEFINEDCHART   =  50;
  PE_GT_UNKNOWNTYPECHART   = 100;

  { Graph Subtype }
  { Bar charts }
  PE_GST_SIDEBYSIDEBARCHART                =    0;
  PE_GST_STACKEDBARCHART                   =    1;
  PE_GST_PERCENTBARCHART                   =    2;
  PE_GST_FAKED3DSIDEBYSIDEBARCHART         =    3;
  PE_GST_FAKED3DSTACKEDBARCHART            =    4;
  PE_GST_FAKED3DPERCENTBARCHART            =    5;

  { Line charts }
  PE_GST_REGULARLINECHART                  =   10;
  PE_GST_STACKEDLINECHART                  =   11;
  PE_GST_PERCENTAGELINECHART               =   12;
  PE_GST_LINECHARTWITHMARKERS              =   13;
  PE_GST_STACKEDLINECHARTWITHMARKERS       =   14;
  PE_GST_PERCENTAGELINECHARTWITHMARKERS    =   15;

  { Area charts }
  PE_GST_ABSOLUTEAREACHART                 =   20;
  PE_GST_STACKEDAREACHART                  =   21;
  PE_GST_PERCENTAREACHART                  =   22;
  PE_GST_FAKED3DABSOLUTEAREACHART          =   23;
  PE_GST_FAKED3DSTACKEDAREACHART           =   24;
  PE_GST_FAKED3DPERCENTAREACHART           =   25;

  { Pie charts }
  PE_GST_REGULARPIECHART                   =   30;
  PE_GST_FAKED3DREGULARPIECHART            =   31;
  PE_GST_MULTIPLEPIECHART                  =   32;
  PE_GST_MULTIPLEPROPORTIONALPIECHART      =   33;

  { Doughnut charts }
  PE_GST_REGULARDOUGHNUTCHART              =   40;
  PE_GST_MULTIPLEDOUGHNUTCHART             =   41;
  PE_GST_MULTIPLEPROPORTIONALDOUGHNUTCHART =   42;

  { 3D Riser charts }
  PE_GST_THREEDREGULARCHART                =   50;
  PE_GST_THREEDPYRAMIDCHART                =   51;
  PE_GST_THREEDOCTAGONCHART                =   52;
  PE_GST_THREEDCUTCORNERSCHART             =   53;

  { 3D surface charts }
  PE_GST_THREEDSURFACEREGULARCHART         =   60;
  PE_GST_THREEDSURFACEWITHSIDESCHART       =   61;
  PE_GST_THREEDSURFACEHONEYCOMBCHART       =   62;

  { Scatter charts }
  PE_GST_XYSCATTERCHART                    =   70;
  PE_GST_XYSCATTERDUALAXISCHART            =   71;
  PE_GST_XYSCATTERWITHLABELSCHART          =   72;
  PE_GST_XYSCATTERDUALAXISWITHLABELSCHART  =   73;

  { Radar charts }
  PE_GST_REGULARRADARCHART                 =   80;
  PE_GST_STACKEDRADARCHART                 =   81;
  PE_GST_RADARDUALAXISCHART                =   82;

  { Bubble charts }
  PE_GST_REGULARBUBBLECHART                =   90;
  PE_GST_DUALAXISBUBBLECHART               =   91;

  { Stocked charts }
  PE_GST_HIGHLOWCHART                      =  100;
  PE_GST_HIGHLOWDUALAXISCHART              =  101;
  PE_GST_HIGHLOWOPENCHART                  =  102;
  PE_GST_HIGHLOWOPENDUALAXISCHART          =  103;
  PE_GST_HIGHLOWOPENCLOSECHART             =  104;
  PE_GST_HIGHLOWOPENCLOSEDUALAXISCHART     =  105;

  PE_GST_UNKNOWNSUBTYPECHART               = 1000;

type
  PEGraphTypeInfo = record
    structSize   : Word;
    graphType    : Smallint; { PE_GT_*, PE_UNCHANGED for no change }
    graphSubtype : Smallint; { PE_GST_*, PE_UNCHANGED for no change }
  end;

const
 PE_SIZEOF_GRAPH_TYPE_INFO = SizeOf(PEGraphTypeInfo);

type
  TPEGetGraphTypeInfo = function (
    printJob          : Smallint;
    sectionN          : Smallint;
    graphN            : Smallint;
    var graphTypeInfo : PEGraphTypeInfo): Bool;  stdcall;

  TPESetGraphTypeInfo = function (
    printJob          : Smallint;
    sectionN          : Smallint;
    graphN            : Smallint;
    var graphTypeInfo : PEGraphTypeInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Text                                                                   }
{------------------------------------------------------------------------------}
const
  PE_GTT_TITLE           = 0;
  PE_GTT_SUBTITLE        = 1;
  PE_GTT_FOOTNOTE        = 2;
  PE_GTT_SERIESTITLE     = 3;
  PE_GTT_GROUPSTITLE     = 4;
  PE_GTT_XAXISTITLE      = 5;
  PE_GTT_YAXISTITLE      = 6;
  PE_GTT_ZAXISTITLE      = 7;

type
  TPEGetGraphTextInfo = function (
    printJob        : Smallint;
    sectionN        : Smallint;
    graphN          : Smallint;
    titleType       : Word;     { PE_GTT_ constant }
    var title       : Hwnd;
    var titleLength : Smallint): Bool;  stdcall;

  TPESetGraphTextInfo = function(
    printJob  : Smallint;
    sectionN  : Smallint;
    graphN    : Smallint;
    titleType : Word;     { PE_GTT_ constant }
    title     : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Font                                                                   }
{------------------------------------------------------------------------------}
const
  PE_GTF_TITLEFONT       = 0;
  PE_GTF_SUBTITLEFONT    = 1;
  PE_GTF_FOOTNOTEFONT    = 2;
  PE_GTF_GROUPSTITLEFONT = 3;
  PE_GTF_DATATITLEFONT   = 4;
  PE_GTF_LEGENDFONT      = 5;
  PE_GTF_GROUPLABELSFONT = 6;
  PE_GTF_DATALABELSFONT  = 7;

  PE_FACE_NAME_LEN       = 64;

type
  PEFaceNameType = array [0..PE_FACE_NAME_LEN-1] of Char;
  PEFontColorInfo = record
    structSize   : Word;
    faceName     : PEFaceNameType; { empty string for no change }
    fontFamily   : Smallint; { FF_DONTCARE for no change }
    fontPitch    : Smallint; { DEFAULT_PITCH for no change }
    charSet      : Smallint; { DEFAULT_CHARSET for no change }
    pointSize    : Smallint; { 0 for no change }
    isItalic     : Smallint; { BOOL value, except use PE_UNCHANGED for no change }
    isUnderlined : Smallint; { BOOL value, except use PE_UNCHANGED for no change }
    isStruckOut  : Smallint; { BOOL value, except use PE_UNCHANGED for no change }
    weight       : Smallint; { 0 for no change }
    color        : COLORREF; { PE_UNCHANGED_COLOR for no change }
    twipSize     : Smallint; { Font size in twips, 0 for no change.        }
      { Use one of pointSize or twipSize. If both pointSize and twipSize   }
      { are non-zero, twipSize will be used and pointSize will be ignored. }
  end;

const
  PE_SIZEOF_FONT_COLOR_INFO = SizeOf(PEFontColorInfo);

type
  TPEGetGraphFontInfo = function (
    printJob           : Smallint;
    sectionN           : Smallint;
    graphN             : Smallint;
    titleFontType      : Word;  { PE_GTF_ constant }
    var fontColorInfo  : PEFontColorInfo): Bool;  stdcall;

  TPESetGraphFontInfo = function (
    printJob           : Smallint;
    sectionN           : Smallint;
    graphN             : Smallint;
    titleFontType      : Word; { PE_GTF_ constant }
    var fontColorInfo  : PEFontColorInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Options                                                                }
{------------------------------------------------------------------------------}
const
  PE_GLP_PLACEUPPERRIGHT    =  0;
  PE_GLP_PLACEBOTTOMCENTER  =  1;
  PE_GLP_PLACETOPCENTER     =  2;
  PE_GLP_PLACERIGHT         =  3;
  PE_GLP_PLACELEFT          =  4;

  { Legend Layout }
  PE_GLL_PERCENTAGE         = 0;
  PE_GLL_AMOUNT             = 1;
  PE_GLL_CUSTOM             = 2; {for PEGetGraphOptionInfo, do not use}
                                 {in PESetGraphOptionInfo.}
  { Bar Sizes }
  PE_GBS_MINIMUMBARSIZE     =  0;
  PE_GBS_SMALLBARSIZE       =  1;
  PE_GBS_AVERAGEBARSIZE     =  2;
  PE_GBS_LARGEBARSIZE       =  3;
  PE_GBS_MAXIMUMBARSIZE     =  4;

  { Pie Sizes }
  PE_GPS_MINIMUMPIESIZE     = 64;
  PE_GPS_SMALLPIESIZE       = 48;
  PE_GPS_AVERAGEPIESIZE     = 32;
  PE_GPS_LARGEPIESIZE       = 16;
  PE_GPS_MAXIMUMPIESIZE     =  0;

  { Detached Pie Slice }
  PE_GDPS_NODETACHMENT      =  0;
  PE_GDPS_SMALLESTSLICE     =  1;
  PE_GDPS_LARGESTSLICE      =  2;

  { Marker Sizes }
  PE_GMS_SMALLMARKERS       =  0;
  PE_GMS_MEDIUMSMALLMARKERS =  1;
  PE_GMS_MEDIUMMARKERS      =  2;
  PE_GMS_MEDIUMLARGEMARKERS =  3;
  PE_GMS_LARGEMARKERS       =  4;

  { Marker shapes }
  PE_GMSP_RECTANGLESHAPE    =  1;
  PE_GMSP_CIRCLESHAPE       =  4;
  PE_GMSP_DIAMONDSHAPE      =  5;
  PE_GMSP_TRIANGLESHAPE     =  8;

  { Chart Color }
  PE_GCR_COLORCHART         =  0;
  PE_GCR_BLACKANDWHITECHART =  1;

  { Chart Data points }
  PE_GDP_NONE               =  0;
  PE_GDP_SHOWLABEL          =  1;
  PE_GDP_SHOWVALUE          =  2;
  PE_GDP_SHOWLABELVALUE     =  3;

  { Number formats }
  PE_GNF_NODECIMAL          =  0;
  PE_GNF_ONEDECIMAL         =  1;
  PE_GNF_TWODECIMAL         =  2;
//  PE_GNF_CURRENCYNODECIMAL  =  3;
  PE_GNF_UNKNOWNTYPE        =  3;
  PE_GNF_CURRENCYTWODECIMAL =  4;
  PE_GNF_PERCENTNODECIMAL   =  5;
  PE_GNF_PERCENTONEDECIMAL  =  6;
  PE_GNF_PERCENTTWODECIMAL  =  7;
  PE_GNF_OTHER              =  8;

  { Viewing Angles }
  PE_GVA_STANDARDVIEW       =  1;
  PE_GVA_TALLVIEW           =  2;
  PE_GVA_TOPVIEW            =  3;
  PE_GVA_DISTORTEDVIEW      =  4;
  PE_GVA_SHORTVIEW          =  5;
  PE_GVA_GROUPEYEVIEW       =  6;
  PE_GVA_GROUPEMPHASISVIEW  =  7;
  PE_GVA_FEWSERIESVIEW      =  8;
  PE_GVA_FEWGROUPSVIEW      =  9;
  PE_GVA_DISTORTEDSTDVIEW   = 10;
  PE_GVA_THICKGROUPSVIEW    = 11;
  PE_GVA_SHORTERVIEW        = 12;
  PE_GVA_THICKSERIESVIEW    = 13;
  PE_GVA_THICKSTDVIEW       = 14;
  PE_GVA_BIRDSEYEVIEW       = 15;
  PE_GVA_MAXVIEW            = 16;

type
  PEGraphOptionInfo = record
    structSize       : Word;
    graphColor       : Smallint; { PE_GCR_*, PE_UNCHANGED for no change }
    showLegend       : Smallint; { BOOL, PE_UNCHANGED for no change }
    legendPosition   : Smallint; { PE_GLP_*, if showLegend == 0, means no legend }
    { Pie Charts and Doughut Charts }
    pieSize          : Smallint; { PE_GPS_*, PE_UNCHANGED for no change }
    detachedPieSlice : Smallint; { PE_GDPS_*, PE_UNCHANGED for no change }
    { Bar Chart }
    barSize          : Smallint; { PE_GBS_*, PE_UNCHANGED for no change }
    verticalBars     : Smallint; { BOOL, PE_UNCHANGED for no change }
    { Markers (used for line and bar charts) }
    markerSize       : Smallint; { PE_GMS_*, PE_UNCHANGED for no change }
    markerShape      : Smallint; { PE_GMSP_*, PE_UNCHANGED for no change }
    { Data Points }
    dataPoints       : Smallint; { PE_GDP_*, PE_UNCHANGED for no change }
    dataValueNumberFormat : Smallint; { PE_GNF_*, PE_UNCHANGED for no change }
    { 3D }
    viewingAngle     : Smallint; { PE_GVA_*, PE_UNCHANGED for no change }
    legendLayout     : Smallint; { PE_GLL_* }
  end;

const
  PE_SIZEOF_GRAPH_OPTION_INFO = SizeOf(PEGraphOptionInfo);

type
  TPEGetGraphOptionInfo = function (
    printJob            : Smallint;
    sectionN            : Smallint;
    graphN              : Smallint;
    var graphOptionInfo : PEGraphOptionInfo): Bool;  stdcall;

  TPESetGraphOptionInfo = function (
    printJob            : Smallint;
    sectionN            : Smallint;
    graphN              : Smallint;
    var graphOptionInfo : PEGraphOptionInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Axes                                                                   }
{------------------------------------------------------------------------------}
const
  PE_GGT_NOGRIDLINES            =  0;
  PE_GGT_MINORGRIDLINES         =  1;
  PE_GGT_MAJORGRIDLINES         =  2;
  PE_GGT_MAJORANDMINORGRIDLINES =  3;
  PE_ADM_AUTOMATIC              =  0;
  PE_ADM_MANUAL                 =  1;

type
  PEGraphAxisInfo = record
    structSize         : Word;
    { Grid Lines }
    groupAxisGridLine  : Smallint; { PE_GGT_*, PE_UNCHANGED for no change }
    dataAxisYGridLine  : Smallint; { PE_GGT_*, PE_UNCHANGED for no change }
    dataAxisY2GridLine : Smallint; { PE_GGT_*, PE_UNCHANGED for no change }
    seriesAxisGridline : Smallint; { PE_GGT_*, PE_UNCHANGED for no change }
    { Min/Max Values }
    dataAxisYMinValue  : double;
    dataAxisYMaxValue  : double;
    dataAxisY2MinValue : double;
    dataAxisY2MaxValue : double;
    seriesAxisMinValue : double;
    seriesAxisMaxValue : double;
    { Number Format }
    dataAxisYNumberFormat  : Smallint; { PE_GNF_*, PE_UNCHANGED for no change }
    dataAxisY2NumberFormat : Smallint; { PE_GNF_*, PE_UNCHANGED for no change }
    seriesAxisNumberFormat : Smallint; { PE_GNF_*, PE_UNCHANGED for no change }
    { Auto Range }
    dataAxisYAutoRange  : Smallint; { BOOL, PE_UNCHANGED for no change }
    dataAxisY2AutoRange : Smallint; { BOOL, PE_UNCHANGED for no change }
    seriesAxisAutoRange : Smallint; { BOOL, PE_UNCHANGED for no change }
    { Automatic Division }
    dataAxisYAutomaticDivision  : Smallint; { PE_ADM_*, PE_UNCHANGED for no change }
    dataAxisY2AutomaticDivision : Smallint; { PE_ADM_*, PE_UNCHANED for no change }
    seriesAxisAutomaticDivision : Smallint; { PE_ADM_*, PE_UNCHANED for no change }
    { Manual Division }
    dataAxisYManualDivision  : Longint; { if dataAxisYAutomaticDivision is PE_ADM_AUTOMATIC, this field is ignored }
    dataAxisY2ManualDivision : Longint; { if dataAxisY2AutomaticDivision is PE_ADM_AUTOMATIC, this field is ignored }
    seriesAxisManualDivision : LongInt; { if seriesAxisAutomaticDivision is PE_ADM_AUTOMATIC, this field is ignored }
    { Auto Scale }
    dataAxisYAutoScale  : Smallint; {BOOL, PE_UNCHANGED for no change}
    dataAxisY2AutoScale : Smallint; {BOOL, PE_UNCHANGED for no change}
    seriesAxisAutoScale : Smallint; {BOOL, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_GRAPH_AXIS_INFO = SizeOf(PEGraphAxisInfo);

type
  TPEGetGraphAxisInfo = function (
    printJob          : Smallint;
    sectionN          : Smallint;
    graphN            : Smallint;
    var graphAxisInfo : PEGraphAxisInfo): Bool;  stdcall;

  TPESetGraphAxisInfo = function (
    printJob          : Smallint;
    sectionN          : Smallint;
    graphN            : Smallint;
    var graphAxisInfo : PEGraphAxisInfo): Bool; stdcall;

{******************************************************************************}
{  Formulas, Selection Formulas and Group Selection Formulas                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Formulas                                                                     }
{------------------------------------------------------------------------------}
type
  TPEGetNFormulas = function (printJob : Smallint) : Smallint;  stdcall; 

  TPEGetNthFormula = function (
    printJob       : Smallint;
    formulaN       : Smallint;
    var nameHandle : Hwnd;
    var nameLength : Smallint;
    var textHandle : Hwnd;
    var textLength : Smallint): Bool;  stdcall; 

  TPEGetFormula = function (
    printJob       : Smallint;
    formulaName    : PChar;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetFormula = function (
    printJob      : Smallint;
    formulaName   : PChar;
    formulaString : PChar): Bool;  stdcall;

  TPECheckFormula = function (
    printJob    : Smallint;
    formulaName : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Selection Formula                                                            }
{------------------------------------------------------------------------------}
type
  TPEGetSelectionFormula = function (
    printJob       : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall; 

  TPESetSelectionFormula = function (
    printJob      : Smallint;
    formulaString : PChar): Bool;  stdcall;

  TPECheckSelectionFormula = function (printJob : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Group Selection Formula                                                      }
{------------------------------------------------------------------------------}
type
  TPEGetGroupSelectionFormula = function (
    printJob       : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetGroupSelectionFormula = function (
    printJob      : Smallint;
    formulaString : PChar): Bool;  stdcall;

  TPECheckGroupSelectionFormula = function (printJob : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Section Format Formulas                                                      }
{------------------------------------------------------------------------------}
const
  { Format formula name : Old naming convention }
  SECTION_VISIBILITY      = 58;
  NEW_PAGE_BEFORE         = 60;
  NEW_PAGE_AFTER          = 61;
  KEEP_SECTION_TOGETHER   = 62;
  SUPPRESS_BLANK_SECTION  = 63;
  RESET_PAGE_N_AFTER      = 64;
  PRINT_AT_BOTTOM_OF_PAGE = 65;
  UNDERLAY_SECTION        = 66;
  SECTION_BACK_COLOUR     = 67;
  { Format formula name : New naming convention}
  PE_FFN_AREASECTION_VISIBILITY  = 58;
  PE_FFN_SECTION_VISIBILITY      = 58;
  PE_FFN_SHOW_AREA               = 59;
  PE_FFN_NEW_PAGE_BEFORE         = 60;
  PE_FFN_NEW_PAGE_AFTER          = 61;
  PE_FFN_KEEP_SECTION_TOGETHER   = 62;
  PE_FFN_SUPPRESS_BLANK_SECTION  = 63;
  PE_FFN_RESET_PAGE_N_AFTER      = 64;
  PE_FFN_PRINT_AT_BOTTOM_OF_PAGE = 65;
  PE_FFN_UNDERLAY_SECTION        = 66;
  PE_FFN_SECTION_BACK_COLOUR     = 67;

type
  TPEGetSectionFormatFormula = function (
    printJob       : Smallint;
    sectionCode    : Smallint;
    formulaName    : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetSectionFormatFormula = function (
    printJob      : Smallint;
    sectionCode   : Smallint;
    formulaName   : Smallint;
    formulaString : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Area Format Formulas                                                         }
{------------------------------------------------------------------------------}
type
  TPEGetAreaFormatFormula = function (
    printJob       : Smallint;
    areaCode       : Smallint;
    formulaName    : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetAreaFormatFormula = function (
    printJob      : Smallint;
    areaCode      : Smallint;
    formulaName   : Smallint;
    formulaString : PChar): Bool;  stdcall;

{******************************************************************************}
{ SQL Expressions                                                              }
{******************************************************************************}
type
  TPEGetNSQLExpressions = function (printJob: Smallint): Smallint;  stdcall;

type
  TPEGetNthSQLExpression = function (
    printJob       : Smallint;
    expressionN    : Smallint;
    var nameHandle : Hwnd;
    var nameLength : Smallint;
    var textHandle : Hwnd;
    var textLength : Smallint): Bool;  stdcall;

  TPEGetSQLExpression = function (
    printJob             : Smallint;
    const expressionName : PChar;
    var textHandle       : Hwnd;
    var textLength       : Smallint): Bool;  stdcall;

type
  TPESetSQLExpression = function (
    printJob               : Smallint;
    const expressionName   : PChar;
    const expressionString : PChar): Bool;  stdcall;

  TPECheckSQLExpression = function (
    printJob             : Smallint;
    const expressionName : PChar): Bool;  stdcall;

(********************************************************************************/
** NOTE : Stored Procedures
**   The previous Stored Procedure API Calls PEGetNParams, PEGetNthParam,
** PEGetNthParamInfo and PESetNthParam have been made obsolete.  Older
** applications that used these API Calls will still work as before, but for new
** development please use the new Parameter API calls below,
**   The Stored Procedure Parameters have now been unified with the Parameter
** Fields.
**
** The replacements for these calls are as follows :
**		PEGetNParams	  = PEGetNParameterFields
**		PEGetNthParam	  = PEGetNthParameterField
**		PEGetNthParamInfo = PEGetParameterValueInfo
**		PESetNthParam	  = PESetNthParameterField
**
** NOTE : To tell if a Parameter Field is a Stored Procedure, use the
**	  PEGetNthParameterType or PEGetNthParameterField API Calls
**
** If you wish to SET a parameter to NULL then set the CurrentValue to CRWNULL.
** The CRWNULL is of Type String and is independant of the datatype of the
** parameter.
*******************************************************************************)
const
  PE_PARAMETER_NAME_LEN  = 128;
  PE_PT_LONGVARCHAR      = -1;
  PE_PT_BINARY           = -2;
  PE_PT_VARBINARY        = -3;
  PE_PT_LONGVARBINARY    = -4;
  PE_PT_BIGINT           = -5;
  PE_PT_TINYINT          = -6;
  PE_PT_BIT              = -7;
  PE_PT_CHAR             = 1;
  PE_PT_NUMERIC          = 2;
  PE_PT_DECIMAL          = 3;
  PE_PT_INTEGER          = 4;
  PE_PT_SMALLINT         = 5;
  PE_PT_FLOAT            = 6;
  PE_PT_REAL             = 7;
  PE_PT_DOUBLE           = 8;
  PE_PT_DATE             = 9;
  PE_PT_TIME             = 10;
  PE_PT_TIMESTAMP        = 11;
  PE_PT_VARCHAR          = 12;

type
  PEProcParamNameType = array [0..PE_PARAMETER_NAME_LEN-1] of Char;
  PEParameterInfo = record
    structSize : Word;
    paramType  : smallint; {PE_PT constant}
    Name       : PEProcParamNameType;
  end;

{******************************************************************************}
{ Parameter Fields                                                             }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Getting/Setting Parameter Fields                                             }
{------------------------------------------------------------------------------}
const
  PE_PF_REPORT_NAME_LEN = 128;
  PE_PF_NAME_LEN        = 256;
  PE_PF_PROMPT_LEN      = 256;
  PE_PF_VALUE_LEN       = 256;
  PE_PF_EDITMASK_LEN    = 256;

  PE_PF_NUMBER     = 0;
  PE_PF_CURRENCY   = 1;
  PE_PF_BOOLEAN    = 2;
  PE_PF_DATE       = 3;
  PE_PF_STRING     = 4;
  PE_PF_DATETIME   = 5;
  PE_PF_TIME       = 6;
  PE_PF_INTEGER    = 7;
  PE_PF_COLOR      = 8;
  PE_PF_CHAR       = 9;
  PE_PF_LONG       = 10;
  PE_PF_STRINGHANDLE =  11; { use PF_LONG as text length and then call PEGetHandleString }
  PE_PF_NOVALUE    = 100;

type
  PEPFReportNameType   = array [0..PE_PF_REPORT_NAME_LEN-1] of Char;
  PEPFNameType         = array [0..PE_PF_NAME_LEN-1] of Char;
  PEPFPromptType       = array [0..PE_PF_PROMPT_LEN-1] of Char;
  PEPFValueType        = array [0..PE_PF_VALUE_LEN-1] of Char;
  PEPFEditMaskType     = array [0..PE_PF_EDITMASK_LEN-1] of Char;

  PEParameterFieldInfo = record
    structSize        : Word; { Initialize to PE_SIZEOF_PARAMETER_FIELD_INFO }
    ValueType         : Word; { PE_PF_ constant }
    DefaultValueSet   : Word; { Indicate the default value is set in PEParameterFieldInfo }
    CurrentValueSet   : Word; { Indicate the current value is set in PEParameterFieldInfo }
    Name              : PEPFNameType;
    Prompt            : PEPFPromptType;
    { Next 2 Could be Number, Date, DateTime, Time, Boolean, or String }
    DefaultValue      : PEPFValueType;
    CurrentValue      : PEPFValueType;
    { Name of report where the field belongs, only used in PEGetNthParameterField }
    ReportName        : PEPFReportNameType;
    { Returns false (0) if parameter is linked, not in use, or has current value set }
    needsCurrentValue : Word;
    { For String values this will be TRUE if the string is limited on length, for }
    { other types it will be TRUE if the parameter is limited by a range }
    isLimited         : Word;
    { For string fields, these are the minimum/maximum length of the string }
    { For numeric fields, they are the minimum/maximum numeric value }
    { For other fields, use PEGetParameterMinMaxValue }
    MinSize           : Double;
    MaxSize           : Double;
    { An edit mask that restricts what may be entered for string parameters }
    EditMask          : PEPFEditMaskType;
    { Returns True if it is essbase sub var }
    isHidden          : Word;
    // Indicate if this parameter is linked to a subreport. Readonly. Set will ignore it.
    isLinked          : Word;
  end;

const
  PE_SIZEOF_PARAMETER_FIELD_INFO = SizeOf(PEParameterFieldInfo);
  PE_SIZEOF_VARINFO_TYPE = SizeOf(PEParameterFieldInfo);

type
  TPEGetNParameterFields = function (printJob : Smallint): SmallInt;  stdcall; 

  TPEGetNthParameterField = function (
    printJob          : Smallint;
    parameterN        : Smallint;
    var parameterInfo : PEParameterFieldInfo): Bool;  stdcall;

  TPESetNthParameterField = function (
    printJob          : Smallint;
    parameterN        : Smallint;
    var parameterInfo : PEParameterFieldInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Converting Default/Current Value via PEValueInfo                             }
{------------------------------------------------------------------------------}
const
  { ValueInfo types }
  PE_VI_NUMBER       =   0;
  PE_VI_CURRENCY     =   1;
  PE_VI_BOOLEAN      =   2;
  PE_VI_DATE         =   3;
  PE_VI_STRING       =   4;
  PE_VI_DATETIME     =   5;
  PE_VI_TIME         =   6;
  PE_VI_INTEGER      =   7;
  PE_VI_COLOR        =   8;
  PE_VI_CHAR         =   9;
  PE_VI_LONG         =  10;
  PE_VI_STRINGHANDLE =  11; { 32 kb use VI_LONG as Text Length and then call PEGetHandleString }
  PE_VI_HANDLE       =  12; { use viLong as generic handle }
  PE_VI_LONGSTRINGHANDLE = 13; { > 32 kb use viHandle as handle then call PEGetHandleString }
  PE_VI_NOVALUE      = 100;

  PE_VI_STRING_LEN        = 256;
  PE_VI_DATE_OR_TIME_LEN  =   3;
  PE_VI_DATETIME_LEN      =   6;

type
  PEVIStringType     = array[0..PE_VI_STRING_LEN-1] of Char;
  PEVIDateOrTimeType = array[0..PE_VI_DATE_OR_TIME_LEN-1] of Smallint;
  PEVIDateTimeType   = array[0..PE_VI_DATETIME_LEN-1] of Smallint;

  PEValueInfo = record
    structSize : Word;
    valueType  : Word;   {a PE_VI_ constant}
    viNumber   : Double;
    viCurrency : Double;
    viBoolean  : Bool;
    viString   : PEVIStringType;
    viDate     : PEVIDateOrTimeType; {year, month, day}
    viDateTime : PEVIDateTimeType;   {year, month, day, hour, minute, second}
    viTime     : PEVIDateOrTimeType; {hour, minute, second}
    viColor    : DWord;
    viInteger  : Smallint;
    viC        : Char;
    ignored    : Char; {for 4 byte alignment. ignored.}
    viLong     : DWord;
  end;

const
  PE_SIZEOF_VALUE_INFO = SizeOf(PEValueInfo);

type
  PEVIStringWType     = array[0..PE_VI_STRING_LEN-1] of WideChar;
  PEValueInfoW = record
    structSize : Word;
    valueType  : Word;   {a PE_VI_ constant}
    viNumber   : Double;
    viCurrency : Double;
    viBoolean  : Bool;
    viString   : PEVIStringWType;
    viDate     : PEVIDateOrTimeType; {year, month, day}
    viDateTime : PEVIDateTimeType;   {year, month, day, hour, minute, second}
    viTime     : PEVIDateOrTimeType; {hour, minute, second}
    viColor    : DWord;
    viInteger  : Smallint;
    viC        : Char;
    ignored    : Char; {for 4 byte alignment. ignored.}
    viLong     : DWord;
    viHandle   : HWnd;
  end;
const
  PE_SIZEOF_VALUE_INFOW = SizeOf(PEValueInfoW);

type
  TPEConvertPFInfoToVInfo = function (
    value         : PChar;
    valueType     : Smallint;
    var valueInfo : PEValueInfo): Bool;  stdcall;

  TPEConvertVInfoToPFInfo = function (
    var valueInfo : PEValueInfo;
    var valueType : Word;
    value         : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Getting/Setting multiple Default Values                                      }
{------------------------------------------------------------------------------}
type
  TPEGetNParameterDefaultValues = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar): Smallint;  stdcall;

  TPEGetNthParameterDefaultValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    index                    : Smallint;
    var valueInfo            : PEValueInfo): Bool;  stdcall;

  TPESetNthParameterDefaultValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    index                    : Smallint;
    var valueInfo            : PEValueInfo): Bool;  stdcall;

  TPEAddParameterDefaultValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var valueInfo            : PEValueInfo): Bool;  stdcall;

  TPEDeleteNthParameterDefaultValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    index                    : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Min/Max Values for Parameter Fields                                          }
{------------------------------------------------------------------------------}
type
  TPEGetParameterMinMaxValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var valueMin             : PEValueInfo;
    var valueMax             : PEValueInfo): Bool;  stdcall; 

  TPESetParameterMinMaxValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var valueMin             : PEValueInfo;
    { Set to NULL to retrieve MAX only; must be non-NULL if valueMax is NULL }
    var valueMax             : PEValueInfo): Bool;  stdcall;
    { Set to NULL to retrieve MIN only; must be non-NULL if valueMin is NULL }
    { If both valueInfo and valueMax are non-NULL then }
    { valueMin.valueType MUST BE THE SAME AS valueMax.valueType. }
    { If different, PE_ERR_INCONSISTANTTYPES is returned. }

{------------------------------------------------------------------------------}
{ Pick List Options in Parameter Fields                                        }
{------------------------------------------------------------------------------}
type
  TPEGetNthParameterValueDescription = function (
    printJob            : Smallint;
    parameterFieldName  : PChar;
    reportName          : PChar;
    index               : Smallint;
    var valueDesc       : HWnd;
    var valueDescLength : Smallint): Bool;  stdcall; 

  TPESetNthParameterValueDescription = function (
    printJob            : Smallint;
    parameterFieldName  : PChar;
    reportName          : PChar;
    index               : Smallint;
    valueDesc           : PChar): Bool;  stdcall;

{ Constants for sortMethod in PEParameterPickListOption }
const
  PE_OR_NO_SORT                 = 0;
  PE_OR_ALPHANUMERIC_ASCENDING  = 1;
  PE_OR_ALPHANUMERIC_DESCENDING = 2;
  PE_OR_NUMERIC_ASCENDING       = 3;
  PE_OR_NUMERIC_DESCENDING      = 4;

type
  PEParameterPickListOption = record
    structSize      : Word;      { initialize to PE_SIZEOF_PICK_LIST_OPTION }
    showDescOnly    : Smallint;  { boolean value or PE_UNCHANGED }
    sortMethod      : Smallint;  { PE_OR value or PE_UNCHANGED }
    sortBasedOnDesc : Smallint;  { boolean value or PE_UNCHANGED }
  end;

const
  PE_SIZEOF_PICK_LIST_OPTION = SizeOf(PEParameterPickListOption);

type
  TPEGetParameterPickListOption = function (
    printJob           : Smallint;
    parameterFieldName : PChar;
    reportName         : PChar;
    var pickListOption : PEParameterPickListOption): Bool;  stdcall;

  TPESetParameterPickListOption = function (
    printJob           : Smallint;
    parameterFieldName : PChar;
    reportName         : PChar;
    var pickListOption : PEParameterPickListOption): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Parameter Value Info - extra options for Parameter Fields                    }
{------------------------------------------------------------------------------}
type
  PEParameterValueInfo = record
    structSize             : Word;
    isNullable             : Smallint; {Boolean value or PE_UNCHANGED for no change.}
    disallowEditing        : Smallint; {Boolean value or PE_UNCHANGED for no change.}
    allowMultipleValues    : Smallint; {Boolean value or PE_UNCHANGED for no change.}
    hasDiscreteValues      : Smallint; {Boolean value or PE_UNCHANGED for no change.}
                                       {True: has discrete values, False: has ranges}
    partOfGroup            : Smallint; {Boolean value or PE_UNCHANGED for no change.}
    groupNum               : Smallint; {a group number or PE_UNCHANGED for no change.}
    mutuallyExclusiveGroup : Smallint; {Boolean value or PE_UNCHANGED for no change.}
  end;

const
  PE_SIZEOF_PARAMETER_VALUE_INFO = SizeOf(PEParameterValueInfo);

type
  TPEGetParameterValueInfo = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var valueInfo            : PEParameterValueInfo): Bool;  stdcall;

  TPESetParameterValueInfo = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var valueInfo            : PEParameterValueInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Getting/Setting multiple Current Values and Ranges                           }
{------------------------------------------------------------------------------}
const
  { Range Info }
  PE_RI_INCLUDEUPPERBOUND = 1;
  PE_RI_INCLUDELOWERBOUND = 2;
  PE_RI_NOUPPERBOUND      = 4;
  PE_RI_NOLOWERBOUND      = 8;

  PE_DR_HASRANGE            = 0;
  PE_DR_HASDISCRETE         = 1;
  PE_DR_HASDISCRETEANDRANGE = 2;

type
  TPEGetNParameterCurrentValues = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar): Smallint;  stdcall;

  TPEGetNthParameterCurrentValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    index                    : Smallint;
    var currentValue         : PEValueInfo): Bool;  stdcall;

  TPEAddParameterCurrentValue = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var currentValue         : PEValueInfo): Bool;  stdcall;

  TPEAddParameterCurrentValueW = function (
    printJob                 : Smallint;
    const parameterFieldName : PWChar;
    const reportName         : PWChar;
    var currentValue         : PEValueInfoW): Bool;  stdcall;

  {Ranges for Parameter Fields}
type
  TPEGetNParameterCurrentRanges = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar): Smallint;  stdcall;

  TPEGetNthParameterCurrentRange = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    index                    : Smallint;
    var rangeStart           : PEValueInfo;
    var rangeEnd             : PEValueInfo;
    var rangeInfo            : Smallint): Bool;  stdcall;

  TPEAddParameterCurrentRange = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar;
    var rangeStart           : PEValueInfo;
    var rangeEnd             : PEValueInfo;
    rangeInfo                : Smallint): Bool;  stdcall;

  TPEAddParameterCurrentRangeW = function (
    printJob                 : Smallint;
    const parameterFieldName : PWChar;
    const reportName         : PWChar;
    var rangeStart           : PEValueInfoW;
    var rangeEnd             : PEValueInfoW;
    rangeInfo                : Smallint): Bool;  stdcall;

  TPEClearParameterCurrentValuesAndRanges = function (
    printJob                 : Smallint;
    const parameterFieldName : PChar;
    const reportName         : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Parameter Field Type                                                         }
{------------------------------------------------------------------------------}
const
  { Parameter Field origin }
  PE_PO_REPORT     = 0;
  PE_PO_STOREDPROC = 1;
  PE_PO_QUERY      = 2;

type
  {returns PE_PO_* or -1 if index is invalid.}
  TPEGetNthParameterType = function (
    printJob : Smallint;
    index    : Smallint): Smallint;  stdcall;

{******************************************************************************}
{ Record and Group SortFields                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ SortFields                                                                   }
{------------------------------------------------------------------------------}
type
  TPEGetNSortFields = function(printJob: Smallint): Smallint;  stdcall;

  TPEGetNthSortField = function(
    printJob       : Smallint;
    sortFieldN     : Smallint;
    var nameHandle : HWnd;
    var nameLength : Smallint;
    var direction  : Smallint): Bool;  stdcall;

  TPESetNthSortField = function (
    printJob   : Smallint;
    sortFieldN : Smallint;
    Name       : PChar;
    direction  : Smallint): Bool;  stdcall;

  TPEDeleteNthSortField = function (
    printJob   : Smallint;
    sortFieldN : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ GroupSortFields                                                              }
{------------------------------------------------------------------------------}
type
  TPEGetNGroupSortFields = function (printJob : Smallint): Smallint;  stdcall;

  TPEGetNthGroupSortField = function(
    printJob       : Smallint;
    sortFieldN     : Smallint;
    var nameHandle : HWnd;
    var nameLength : Smallint;
    var direction  : Smallint): Bool;  stdcall;

  TPESetNthGroupSortField = function (
    printJob   : Smallint;
    sortFieldN : Smallint;
    Name       : PChar;
    direction  : Smallint): Bool;  stdcall;

  TPEDeleteNthGroupSortField = function (
    printJob   : Smallint;
    sortFieldN : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Controlling Databases                                                        }
{   The following functions allow retrieving and updating database info        }
{   in an opened report, so that a report can be printed using different       }
{   session, server, database, user and/or table location settings.  Any       }
{   changes made to the report via these functions are not permanent, and      }
{   only last as long as the report is open.                                   }
{                                                                              }
{   The following database functions (except for PELogOnServer and             }
{   PELogOffServer) must be called after PEOpenPrintJob and before             }
{   PEStartPrintJob.                                                           }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Getting Number of Tables                                                     }
{   The function PEGetNTables is called to fetch the number of tables in       }
{   the report.  This includes all PC databases (e.g. Paradox, xBase)          }
{   as well as SQL databases (e.g. SQL Server, Oracle, Netware).               }
{------------------------------------------------------------------------------}
type
  TPEGetNTables = function (printJob: Smallint): Smallint;  stdcall;

{------------------------------------------------------------------------------}
{ Getting Table Type                                                           }
{   The function PEGetNthTableType allows the application to determine the     }
{   type of each table.  The application can test DBType (equal to             }
{   PE_DT_STANDARD or PE_DT_SQL), or test the database DLL name used to        }
{   create the report.  DLL names have the following naming convention:        }
{       - PDB*.DLL for standard (non-SQL) databases,                           }
{       - PDS*.DLL for SQL databases.                                          }
{                                                                              }
{   In the case of ODBC (PDSODBC.DLL) the DescriptiveName includes the         }
{   ODBC data source name.                                                     }
{------------------------------------------------------------------------------}
const
  PE_DLL_NAME_LEN  =  64;
  PE_FULL_NAME_LEN = 256;
  { DBType constants }
  PE_DT_STANDARD             = 1;
  PE_DT_SQL                  = 2;
  PE_DT_SQL_STORED_PROCEDURE = 3;

type
  PEDllNameType2 = array [0..PE_DLL_NAME_LEN - 1] of Char;
  PEDllNameTypeW = array [0..PE_DLL_NAME_LEN - 1] of WideChar;
  PEFullNameType = array [0..PE_FULL_NAME_LEN - 1] of Char;
  PETableType = record
    structSize      : Word; { Initialize to PE_SIZEOF_TABLE_TYPE }
    DLLName         : PEDllNameType2;
    DescriptiveName : PEFullNameType;
    DBType          : Word;
    notUsed         : Bool;//NOT SUPPORTED in Crystal Reports 9.0 and beyond.
    // TRUE if table is not used in the report either directly or for linking
	  // ALSO NOT SUPPORTED IN UNICODE PETABLETYPEW IT IS HERE MERELY FOR BACKWARD COMPATABILITY
  end;

const
  PE_SIZEOF_TABLE_TYPE = SizeOf(PETableType);

type
  TPEGetNthTableType = function (
    printJob      : Smallint;
    tableN        : Smallint;
    var tableType : PETableType): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Getting Table Session Info                                                   }
{   The functions PEGetNthTableSessionInfo and PESetNthTableSessionInfo        }
{   are only used when connecting to MS Access databases (which require a      }
{   session to be opened first)                                                }
{------------------------------------------------------------------------------}
const
  PE_SESS_USERID_LEN   = 128;
  PE_SESS_PASSWORD_LEN = 128;

type
  PESesPassType = array [0..PE_SESS_PASSWORD_LEN - 1] of Char;
  PESessionInfo = record
    structSize    : Word; { Initialize to PE_SIZEOF_SESSION_INFO }
    UserID        : PESesPassType;
    { Password is undefined when getting information from report. }
    Password      : PESesPassType;
    { SessionHandle is undefined when getting information from report. }
    { When setting information, if it is = 0 the UserID and Password }
    { settings are used, otherwise the SessionHandle is used. }
    SessionHandle : DWord;
  end;

const
  PE_SIZEOF_SESSION_INFO = SizeOf(PESessionInfo);

type
  TPEGetNthTableSessionInfo = function (
    printJob        : Smallint;
    tableN          : Smallint;
    var sessionInfo : PESessionInfo): Bool;  stdcall;

  TPESetNthTableSessionInfo = function (
    printJob              : Smallint;
    tableN                : Smallint;
    var sessionInfo       : PESessionInfo;
    propagateAcrossTables : Bool): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Table LogOn/LogOff                                                           }
{   Logging on is performed when printing the report, but the correct          }
{   log on information must first be set using PESetNthTableLogOnInfo.         }
{   Only the password is required, but the server, database, and               }
{   user names may optionally be overriden as well.                            }
{                                                                              }
{   If the parameter propagateAcrossTables is TRUE, the new log on info        }
{   is also applied to any other tables in this report that had the            }
{   same original server and database names as this table.  If FALSE           }
{   only this table is updated.                                                }
{                                                                              }
{   Logging off is performed automatically when the print job is closed.       }
{------------------------------------------------------------------------------}
type
  PELogonServerType = array [0..PE_SERVERNAME_LEN-1] of Char;
  PELogonDbType     = array [0..PE_DATABASENAME_LEN-1] of Char;
  PELogonUserType   = array [0..PE_USERID_LEN-1] of Char;
  PELogonPassType   = array [0..PE_PASSWORD_LEN-1] of Char;
  PELogOnInfo = record
    structSize   : Word; { Initialize to PE_SIZEOF_LOGON_INFO }
    (* For any of the following values an empty string ("") means to use
    ** the value already set in the report.  To override a value in the
    ** report use a non-empty string (e.g. "Server A").  All strings are
    ** null-terminated.
    **
    ** For Netware SQL, pass the dictionary path name in ServerName and
    ** data path name in DatabaseName. *)
    ServerName   : PELogonServerType;
    DatabaseName : PELogonDbType;
    UserId       : PELogonUserType;
    (* Password is undefined when getting information from report. *)
    Password     : PELogonPassType;
  end;

const
  PE_SIZEOF_LOGON_INFO = SizeOf(PELogOnInfo);

type
  TPEGetNthTableLogOnInfo = function (
    printJob      : Smallint;
    tableN        : Smallint;
    var logOnInfo : PELogOnInfo): Bool;  stdcall;

  TPESetNthTableLogOnInfo = function (
    printJob              : Smallint;
    tableN                : Smallint;
    var logOnInfo         : PELogOnInfo;
    propagateAcrossTables : Bool): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Table Location                                                               }
{   A table's location is fetched and set using PEGetNthTableLocation and      }
{   PESetNthTableLocation.  This name is database-dependent, and must be       }
{   formatted correctly for the expected database.  For example:               }
{       - Paradox: "c:\crw\ORDERS.DB"                                          }
{       - SQL Server: "publications.dbo.authors"                               }
{------------------------------------------------------------------------------}
type
  PETableLocation = record
    structSize    : Word; { Initialize to PE_SIZEOF_TABLE_LOCATION }
    Location      : PETableLocationType;
    SubLocation   : PETableLocationType; { For MS Access Table Names }
    ConnectBuffer : PEConnectBufferType;
  end;

const
  PE_SIZEOF_TABLE_LOCATION = SizeOf(PETableLocation);

type
  TPEGetNthTableLocation = function (
    printJob     : Smallint;
    tableN       : Smallint;
    var location : PETableLocation): Bool;  stdcall;

  TPESetNthTableLocation = function (
    printJob     : Smallint;
    tableN       : Smallint;
    var location : PETableLocation): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Table Private Info - for CDO, ADO, etc.                                      }
{------------------------------------------------------------------------------}
type
  TPEGetNthTablePrivateInfo = function (
    printJob        : Smallint;
    tableN          : Smallint;
    var privateInfo : PETablePrivateInfo): Bool;  stdcall;

  TPESetNthTablePrivateInfo = function (
    printJob        : Smallint;
    tableN          : Smallint;
    var privateInfo : PETablePrivateInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Test Connectivity                                                            }
{   The function PETestNthTableConnectivity tests whether a database           }
{   table's settings are valid and ready to be reported on.  It returns        }
{   true if the database session, log on, and location info is all             }
{   correct.                                                                   }
{                                                                              }
{   This is useful, for example, in prompting the user and testing a           }
{   server password before printing begins.                                    }
{                                                                              }
{   This function may require a significant amount of time to complete,        }
{   since it will first open a user session (if required), then log onto       }
{   the database server (if required), and then open the appropriate           }
{   database table (to test that it exists).  It does not read any data,       }
{   and closes the table immediately once successful.  Logging off is          }
{   performed when the print job is closed.                                    }
{                                                                              }
{   If it fails in any of these steps, the error code set indicates            }
{   which database info needs to be updated using functions above:             }
{      - If it is unable to begin a session, PE_ERR_DATABASESESSION is set,    }
{        and the application should update with PESetNthTableSessionInfo.      }
{      - If it is unable to log onto a server, PE_ERR_DATABASELOGON is set,    }
{        and the application should update with PESetNthTableLogOnInfo.        }
{      - If it is unable open the table, PE_ERR_DATABASELOCATION is set,       }
{        and the application should update with PESetNthTableLocation.         }
{------------------------------------------------------------------------------}
type
  TPETestNthTableConnectivity = function (
    printJob : Smallint;
    tableN   : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Logging On/Off Server                                                        }
{   PELogOnServer and PELogOffServer can be called at any time to log on       }
{   and off of a database server.  These functions are not required if         }
{   function PESetNthTableLogOnInfo above was already used to set the          }
{   password for a table.                                                      }
{                                                                              }
{   These functions require a database DLL name, which can be retrieved        }
{   using PEGetNthTableType above.                                             }
{                                                                              }
{   This function can also be used for non-SQL tables, such as password-       }
{   protected Paradox tables.  Call this function to set the password          }
{   for the Paradox DLL before beginning printing.                             }
{                                                                              }
{   Note: When printing using PEStartPrintJob the ServerName passed in         }
{   PELogOnServer must agree exactly with the server name stored in the        }
{   report.  If this is not true use PESetNthTableLogOnInfo to perform         }
{   logging on instead.                                                        }
{------------------------------------------------------------------------------}
type
  TPELogOnServer = function (
    dllName       : PChar;
    var logOnInfo : PELogOnInfo): Bool;  stdcall;

  TPELogOffServer = function (
    dllName       : PChar;
    var logOnInfo : PELogOnInfo): Bool;  stdcall;

  TPELogOnSQLServerWithPrivateInfo = function (
    dllName     : PChar;
    privateInfo : Pointer): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Verify Database                                                              }
{------------------------------------------------------------------------------}
type
  TPEVerifyDatabase = function (printJob: Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Check Table Differences                                                      }
{   - Not implemented for Reports based on Dictionaries:                       }
{     returns PE_ERR_NOTIMPLEMENTED                                            }
{------------------------------------------------------------------------------}
const
  { Constants returned from PECheckNthTableDifferences, }
  { can be any combination of the following: }
  PE_TCD_OKAY                     = $00000000;
  PE_TCD_DATABASENOTFOUND         = $00000001;
  PE_TCD_SERVERNOTFOUND           = $00000002;
  PE_TCD_SERVERNOTOPENED          = $00000004;
  PE_TCD_ALIASCHANGED             = $00000008;
  PE_TCD_INDEXESCHANGED           = $00000010;
  PE_TCD_DRIVERCHANGED            = $00000020;
  PE_TCD_DICTIONARYCHANGED        = $00000040;
  PE_TCD_FILETYPECHANGED          = $00000080;
  PE_TCD_RECORDSIZECHANGED        = $00000100;
  PE_TCD_ACCESSCHANGED            = $00000200;
  PE_TCD_PARAMETERSCHANGED        = $00000400;
  PE_TCD_LOCATIONCHANGED          = $00000800;
  PE_TCD_DATABASEOTHER            = $00001000;
  PE_TCD_NUMFIELDSCHANGED         = $00010000;
  PE_TCD_FIELDOTHER               = $00020000;
  PE_TCD_FIELDNAMECHANGED         = $00040000;
  PE_TCD_FIELDDESCCHANGED         = $00080000;
  PE_TCD_FIELDTYPECHANGED         = $00100000;
  PE_TCD_FIELDSIZECHANGED         = $00200000;
  PE_TCD_NATIVEFIELDTYPECHANGED   = $00400000;
  PE_TCD_NATIVEFIELDOFFSETCHANGED = $00800000;
  PE_TCD_NATIVEFIELDSIZECHANGED   = $01000000;
  PE_TCD_FIELDDECPLACESCHANGED    = $02000000;

type
  PETableDifferenceInfo = record
    structSize       : Word;
    tableDifferences : DWord; { any combination of PE_TCD_* }
    reserved1        : DWord; { reserved - do not use }
    reserved2        : DWord; { reserved - do not use }
  end;

const
  PE_SIZEOF_TABLE_DIFFERENCE_INFO = SizeOf(PETableDifferenceInfo);

type
  TPECheckNthTableDifferences = function (
    printJob                : Smallint;
    tableN                  : Smallint;
    var tableDifferenceInfo : PETableDifferenceInfo): Bool;  stdcall;

{******************************************************************************}
{ Overriding SQL Query in Report                                               }
{   PEGetSQLQuery () returns the same query as appears in the Show SQL Query   }
{   dialog in CRW, in syntax specific to the database driver you are using.    }
{                                                                              }
{   PESetSQLQuery () is mostly useful for reports with SQL queries that        }
{   were explicitly edited in the Show SQL Query dialog in CRW, i.e. those     }
{   reports that needed database-specific selection criteria or joins.         }
{   (Otherwise it is usually best to continue using function calls such as     }
{   PESetSelectionFormula () and let CRW build the SQL query automatically.    }
{                                                                              }
{   PESetSQLQuery () has the same restrictions as editing in the Show SQL      }
{   Query dialog; in particular that changes are accepted in the FROM and      }
{   WHERE clauses but ignored in the SELECT list of fields.                    }
{******************************************************************************}
type
  TPEGetSQLQuery = function (
    printJob       : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall; 

  TPESetSQLQuery = function (
    printJob    : Smallint;
    queryString : PChar): Bool;  stdcall;

{******************************************************************************}
{ Saved Data                                                                   }
{   Use PEHasSavedData() to find out if a report currently has saved data      }
{   associated with it.  This may or may not be TRUE when a print job is       }
{   first opened from a report file.  Since data is saved during a print,      }
{   this will always be TRUE immediately after a report is printed.            }
{                                                                              }
{   Use PEDiscardSavedData() to release the saved data associated with a       }
{   report.  The next time the report is printed, it will get current data     }
{   from the database.                                                         }
{                                                                              }
{   The default behavior is for a report to use its saved data, rather than    }
{   refresh its data from the database when printing a report.                 }
{******************************************************************************}
type
  TPEHasSavedData = function (
    printJob         : Smallint;
    var hasSavedData : Bool): Bool;  stdcall; 

  TPEDiscardSavedData = function (printJob : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Report Title                                                                 }
{******************************************************************************}
type
  TPEGetReportTitle = function (
    printJob        : Smallint;
    var titleHandle : HWnd;
    var titleLength : Smallint): Bool;  stdcall;

  TPESetReportTitle = function (
    printJob : Smallint;
    title    : PChar): Bool;  stdcall;

{******************************************************************************}
{ Output to Window                                                             }
{******************************************************************************}
type
  TPEOutputToWindow = function (
    printJob     : Smallint;
    title        : PChar;
    left         : DWord;
    top          : DWord;
    width        : DWord;
    height       : DWord;
    style        : DWord;
    parentWindow : HWnd): Bool;  stdcall;

  TPEGetWindowHandle = function (printJob: Smallint): HWnd;  stdcall;
  TPECloseWindow = procedure(printJob: Smallint);  stdcall;

{------------------------------------------------------------------------------}
{ Window Options/Print Controls                                                }
{------------------------------------------------------------------------------}
type
  PEWindowOptions = record
    structSize            : Word;     { initialize to PE_SIZEOF_WINDOW_OPTIONS}
    hasGroupTree          : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    canDrillDown          : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasNavigationControls : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasCancelButton       : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasPrintButton        : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasExportButton       : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasZoomControl        : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasCloseButton        : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasProgressControls   : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasSearchButton       : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasPrintSetupButton   : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    hasRefreshButton      : Smallint; { 0 or 1 except use PE_UNCHANGED for no change}
    showToolbarTips       : Smallint; { BOOL value, except use PE_UNCHANGED for no change}
                                      { default is TRUE (*Show* tooltips on toolbar)}
    showDocumentTips      : Smallint; { BOOL value, except use PE_UNCHANGED for no change}
                                      { default is FALSE (*Hide* tooltips on document)}
    hasLaunchButton       : Smallint; {Launch Crystal Analysis button on toolbar.}
                                      {BOOL value, except use PE_UNCHANGED for no change}
                                      {default is FALSE}
  end;

const
  PE_SIZEOF_WINDOW_OPTIONS = SizeOf(PEWindowOptions);

type
  TPEGetWindowOptions = function (
    printJob    : Smallint;
    var options : PEWindowOptions): Bool;  stdcall;

  TPESetWindowOptions = function (
    printJob    : Smallint;
    var options : PEWindowOptions): Bool;  stdcall;

  TPEShowPrintControls = function (
    printJob          : Smallint;
    showPrintControls : Bool): Bool;  stdcall;

  TPEPrintControlsShowing = function (
    printJob            : Smallint;
    var controlsShowing : Bool): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Paging                                                                       }
{------------------------------------------------------------------------------}
type
  TPEShowFirstPage = function (printJob : Smallint): Bool;  stdcall;
  TPEShowNextPage = function (printJob : Smallint): Bool;  stdcall;
  TPEShowPreviousPage = function (printJob : Smallint): Bool;  stdcall;
  TPEShowLastPage = function (printJob : Smallint): Bool;  stdcall;
  TPEGetNPages = function (printJob: Smallint): Smallint;  stdcall;
  TPEShowNthPage = function (
    printJob : Smallint;
    pageN    : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Window Zoom                                                                  }
{------------------------------------------------------------------------------}
const
  PE_ZOOM_FULL_SIZE           = 0;
  PE_ZOOM_SIZE_FIT_ONE_SIDE   = 1;
  PE_ZOOM_SIZE_FIT_BOTH_SIDES = 2;

type
  TPEZoomPreviewWindow = function (
    printJob : Smallint;
    level    : Smallint): Bool;  stdcall;

  TPENextPrintWindowMagnification = function (printJob: Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Print/Export Preview Window                                                  }
{------------------------------------------------------------------------------}
type
  TPEPrintWindow = function (
    printJob      : Smallint;
    waitUntilDone : Bool): Bool;  stdcall;

  TPEExportPrintWindow = function (
    printJob      : Smallint;
    toMail        : Bool;
    waitUntilDone : Bool): Bool;  stdcall;

{******************************************************************************}
{ Output to Printer                                                            }
{******************************************************************************}
type
  TPEOutputToPrinter = function (
    printJob : Smallint;
    nCopies  : Smallint): Bool;  stdcall; 

  TPESelectPrinter = function (
    printJob    : Smallint;
    driverName  : PChar;
    printerName : PChar;
    portName    : PChar;
    mode        : PDevMode): Bool;  stdcall;

  TPESelectPrinterW = function (
    printJob    : Smallint;
    driverName  : PWChar;
    printerName : PWChar;
    portName    : PWChar;
    mode        : PDeviceModeW): Bool;  stdcall;

  TPEGetSelectedPrinter = function (
    printJob          : Smallint;
    var driverHandle  : Hwnd;
    var driverLength  : Smallint;
    var printerHandle : Hwnd;
    var printerLength : Smallint;
    var portHandle    : Hwnd;
    var portLength    : Smallint;
    var mode          : PDevMode): Bool;  stdcall;

{******************************************************************************}
{ Detail Copies                                                                }
{   Commonly used for label-style Reports                                      }
{******************************************************************************}
type
  TPEGetNDetailCopies = function (
    printJob     : Smallint;
    var nCopies  : Smallint): Bool;  stdcall;

  TPESetNDetailCopies = function (
    printJob     : Smallint;
    nCopies      : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Print Options                                                                }
{   Extension to PESetPrintOptions function: If the 2nd parameter              }
{   (pointer to PEPrintOptions) is set to 0 (null) the function prompts        }
{   the user for these options.                                                }
{                                                                              }
{   With this change, you can get the behaviour of the print-to-printer        }
{   button in the print window by calling PESetPrintOptions with a             }
{   null pointer and then calling PEPrintWindow.                               }
{******************************************************************************}
const
  {Start/Stop Page}
  PE_MAXPAGEN          = 65535;
  {Collation}
  PE_UNCOLLATED        = 0;
  PE_COLLATED          = 1;
  PE_DEFAULTCOLLATION  = 2;

type
  PEOutputFileNameType = array [0..PE_FILE_PATH_LEN-1] of Char;

  PEPrintOptions  = record
    structSize     : Word; { initialize to SizeOf(PEPrintOptions) }
    { page and copy numbers are 1-origin }
    { use 0 to preserve the existing Strings }
    StartPageN     : Word;
    StopPageN      : Word;
    nReportCopies  : Word;
    Collation      : Word;
    outputFileName : PEOutputFileNameType;
  end;

  TPEGetPrintOptions = function (
    printJob    : Smallint;
    var options : PEPrintOptions):Bool;  stdcall;

  TPESetPrintOptions = function (
    printJob    : Smallint;
    var options : PEPrintOptions): Bool;  stdcall;

{******************************************************************************}
{ Exporting                                                                    }
{******************************************************************************}
const
  UXFCrystalReportType    = 0;
  UXFReportDefinitionType = 0;

type
  PEExportOptions  = record
    { Initialize to SizeOfPEExportOptions }
    structSize               : Word;
    formatDLLName            : PEDllNameType2;
    formatType               : DWord;
    formatOptions            : Pointer;
    destinationDLLName       : PEDllNameType2;
    destinationType          : DWord;
    destinationOptions       : Pointer;
    nFormatOptionsBytes      : Word; { Set by PEExportOptions }
                                     { Ignored by PEExportTo  }
    nDestinationOptionsBytes : Word; { Set by PEExportOptions }
                                     { Ignored by PEExportTo  }
    unicodeFormatOptions  : Bool;
    unicodeDestinationOptions : Bool;
  end;

const
  PE_SIZEOF_EXPORT_OPTIONS = SizeOf(PEExportOptions);

type
  PEExportOptionsW  = record
    { Initialize to SizeOfPEExportOptions }
    structSize               : Word;
    formatDLLName            : PEDllNameTypeW;
    formatType               : Cardinal;
    formatOptions            : Pointer;
    destinationDLLName       : PEDllNameTypeW;
    destinationType          : Cardinal;
    destinationOptions       : Pointer;
    nFormatOptionsBytes      : LongWord; { Set by PEGetExportOptions }
                                         { Ignored by PEExportTo  }
    nDestinationOptionsBytes  : LongWord; { Set by PEGetExportOptions }
                                          { Ignored by PEExportTo  }
    unicodeFormatOptions      : Bool;
    unicodeDestinationOptions : Bool;
  end;

const
  PE_SIZEOF_EXPORT_OPTIONSW = SizeOf(PEExportOptionsW);

type
  TPEGetExportOptions = function (
    printJob    : Smallint;
    var options : PEExportOptions): Bool;  stdcall;

  TPEGetExportOptionsW = function (
    printJob    : Smallint;
    var options : PEExportOptionsW): Bool;  stdcall;

  TPEExportTo = function (
    printJob    : Smallint;
    var options : PEExportOptions): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Export to Lotus Notes Database                                               }
{------------------------------------------------------------------------------}
const
  UXDNotesType = 3;

type
  UXDNotesOptions = record
    structSize : Word;
    szDBName   : PChar;
    szFormName : PChar;  { should be "Report Form" }
    szComments : PChar;
  end;

const
  UXDNotesOptionsSize = SizeOf(UXDNotesOptions);

{------------------------------------------------------------------------------}
{ Export to MAPI                                                               }
{------------------------------------------------------------------------------}
const
  UXDMAPIType = 0;

type
  UXDMAPIOptions = record
    {Initialize to UXDMAPIOptionsSize}
    structSize  : Word;
    toList      : PChar;
    ccList      : PChar;
    subject     : PChar;
    mailmessage : PChar;
    nRecipients : Word;
    {'nRecipients' must be 0 if specifying}
    { To and CC lists above.}
    recipients  : Pointer; //lpMapiRecipDescA;
    userName    : PChar;
    password    : PChar;
    nEncodedBytes : Word;
  end;

const
  UXDMAPIOptionsSize = SizeOf(UXDMAPIOptions);

{------------------------------------------------------------------------------}
{ Export to VIM                                                                }
{------------------------------------------------------------------------------}
const
  UXDVIMType = 0;

type
  UXDVIMOptions = record
    {Initialize to UXDVIMOptionsSize}
    structSize  : Word;
    toList      : PChar;
    ccList      : PChar;
    bccList     : PChar;
    subject     : PChar;
    mailmessage : PChar;
    username    : PChar;
    password    : PChar;
    nEncodedBytes : Word;
  end;

const
  UXDVIMOptionsSize = SizeOf(UXDVIMOptions);

{------------------------------------------------------------------------------}
{ Export to Exchange                                                           }
{------------------------------------------------------------------------------}
const
  UXDExchFolderType = 0;
  UXDPostDocMessage = 1011; {wDestType for folder messages}

type
  UXDPostFolderOptions = record
    structSize    : Word;
    pszProfile    : PChar;
    pszPassword   : PChar;
    wDestType     : Word;
    pszFolderPath : PChar;
    nEncodedBytes : Word;
  end;

  { pszFolderPath has to be in the following format:
     <Message Store Name>@<Folder Name>@<Folder Name> }

const
  UXDPostFolderOptionsSize = SizeOf(UXDPostFolderOptions);

{------------------------------------------------------------------------------}
{ Export to Application                                                        }
{------------------------------------------------------------------------------}
const
  UXDApplicationType = 0;

type
  UXDApplicationOptions = record
    structSize : Word;
    fileName   : PChar;
  end;

const
  UXDApplicationOptionsSize = SizeOf(UXDApplicationOptions);

{------------------------------------------------------------------------------}
{ Export to Disk                                                               }
{------------------------------------------------------------------------------}
const
  UXDDiskType = 0;
  UXDCurVersion = $0100;

type
  UXDDiskOptions = record
    structSize : Word;
    fileName   : PChar;
  end;

const
  UXDDiskOptionsSize = SizeOf(UXDDiskOptions);

{------------------------------------------------------------------------------}
{ Export to Excel                                                              }
{------------------------------------------------------------------------------}
const
  DEFAULT_COLUMN_WIDTH          = 9; {in characters}
  DEFAULT_COLUMN_WIDTH_IN_TWIPS = 720;
  MIN_CONST_COL_WIDTH_IN_TWIPS  = 200;  {minimum 200 twips = 10 points of column width.}
  MAX_CONST_COL_WIDTH_IN_TWIPS  = 5760; {maximum 5760 twips = 288pts = 4"}
  UXFXl97Type      = 9;   //This is newly added for CR(ver 9). EPF based export.
                          //This format is also called page based format.
  UXFXlRecDumpType = 10;  //Just a plain record dump. Record based export.
                          //This format is also called as "Excel(Data Only)" format.

type
  UXFXlsOptions = record
    structSize         : Word;
    bColumnHeadings    : Bool; {In the CR(ver 9) export DLL, this flag is ignored.}
    bUseConstColWidth  : Bool;
    {TRUE -- use constant column width}
    {FALSE -- set column width based on an area}
    {The default value is FALSE.}
    fConstColWidth     : Double;
    {the value in this field is in twips and is used only}
    {when bUseConstColWidth is TRUE.}
    {The default value is DEFAULT_COLUMN_WIDTH_IN_TWIPS.}
    {(MIN_CONST_COL_WIDTH_IN_TWIPS <= fConstColWidth <= MAX_CONST_COL_WIDTH_IN_TWIPS)}
    bTabularFormat     : Bool;  //Ignored by the CR(ver 9) export DLL.
    baseAreaType       : Word;
    {One of the 7 section types defined above.}
    {The default value is PE_SECT_WHOLE_REPORT (255)}
    baseAreaGroupNum   : Word;
    {If baseAreaType is either GroupHeader or GroupFooter,
    { and there are more than one group, we need to give the group number.}
    {The default value is 1.}
    bUseWorksheetFunc  : Bool;
    {If TRUE, use Excel worksheet functions to represent}
    {subtotal fields in crw.}
    {Only Data Only format uses this option}
    {and default value is FALSE.}
//#if defined (MAINWIN) || defined (PLAT_GENERIC_UNIX) || defined (CRPE_UNIX)
//    dwPadding1         : DWord;
    {padding for Solaris and other Unix platforms, do we need it?}
    bExportPageBreaks  : Bool;         //UXFXl97Type only
    {This flag indicates whether to create a page break for each page.}
    {A page break is created in the Excel worksheet for each page in the report}
    {Default value is TRUE.}
    bCnvrtDateValToStr : Bool;
    {This flag indicates whether to convert date values to strings. When}
    {this is TRUE, all the date & date/time fields are NOT exported as numeric}
    {values with a date format. Instead a formatted string value is exported.}
    {When this is FALSE, date & date/time fields are numeric. This flag is}
    {introduced to work around the fact that Excel doesn't recognise dates}
    {before Jan 1, 1900. When such dates are exported, a negative number shows}
    {up in the file. However, this is useful, if you are reporting off from}
    {exported Excel file.}
    {Default value is FALSE.}
    bExportAllPages    : Bool;            //UXFXl97Type only
    {When this flag is set to TRUE, all the pages in the report are exported.}
    {If this flag is set to TRUE, the dwStartPageNumber32 and}
    {dwEndPageNumber32 are ignored.}
    {This flag is applicable only to page based export.}
    {Record based export ignores this flag.}
    {Default value is TRUE.}
    wReserved1         : Word;
    wReserved2         : Word;
    bExportPageHeaders : Bool;
    {Obsolete with introduction of wExportPageAreaPair}
    {TRUE - page header and footer area are exported.}
    {FALSE - page header and footer are not exported.}
    {default is TRUE.}
//#if defined (MAINWIN) || defined (PLAT_GENERIC_UNIX) || defined (CRPE_UNIX)
//    dwPadding2         : DWord; {do we need it?}
    dwStartPageNumber32 : DWord;                 //UXFXl97Type only
    {first page to be exported(1-based number). If this is > the}
    {total number of pages in the report, none of the pages are exported.}
    dwEndPageNumber32   : DWord;                 //UXFXl97Type only
    {last page to be exported(1-based number). If this is > the number}
    {of pages in the report all the pages from the dwStartPageNumber32 and onwards,}
    {are exported.}
    bChopPageHeader     : Bool;
    {if set to TRUE this exports the bottom most line of objects in the page header area.}
    {Otherwise, all objects in page header are exported. This is used in Data Only export only.}
    {default is TRUE.}
    bExportImagesInDataOnly : Bool;
    {TRUE - Enables exporting images in data only export.}
    {default is FALSE}
    bUseFormatInDataOnly : Bool;
    {TRUE - enables exporting of object formats and fonts in data only export.}
    {default is FALSE}
    bMaintainColumnAlignment : Bool;
    {This option indicates teh algorithm to be used to map objects to columns.}
    {when set to TRUE the output will be similar to tabular format export from CR8.5}
    {when set to FALSE each object in a section will go into a single cell and columns}
    {will be the same width}
    bMaintainRelativeObjectPosition : Bool;
    {When this option is turned off, section objects are packed into one row in processing order}
    {When turned on, section objects are placed according to their relative positions in the rpt}
    bShowGridlines : Bool;
    {for data only format, when true gridlines appear in the exported worksheet}
    wExportPageAreaPair :  Word;
    {0=None, ph and pf are not exported}
    {1=Once per report ph and pf are exported once per report}
    {2=OnEachPage ph and pf are exported for each page }
  end;

const
  UXFXlsOptionsSize = SizeOf(UXFXlsOptions);

{------------------------------------------------------------------------------}
{ Export to Text                                                               }
{------------------------------------------------------------------------------}
const
  UXFTextType          = 0;
  UXFTabbedTextType    = 1;
  UXFPaginatedTextType = 2;

type
  UXFPaginatedTextOptions = record
    structSize     : Word;
    nLinesPerPage  : Word;
    useDefaultCPI  : Bool;
    {added to provide CPI to CRPE.}
    {TRUE if system default CPI is to be used.}
    userDefinedCPI : DWord;
    {If useDefaultCPI is FALSE, this member indicates}
    {the user defined CPI. Otherwise it is ignored.}
   end;

const
  UXFPaginatedTextOptionsSize = SizeOf(UXFPaginatedTextOptions);

{------------------------------------------------------------------------------}
{ Export to RecordStyle                                                        }
{------------------------------------------------------------------------------}
const
  UXFRecordType  = 0;
  UXFRecord6Type = 1;
  UXFCurVersion  = $0100;

type
  UXFRecordStyleOptions = record
    structSize            : Word;
    useReportNumberFormat : Bool;
    useReportDateFormat   : Bool;
  end;

const
  UXFRecordStyleOptionsSize = SizeOf(UXFRecordStyleOptions);

{------------------------------------------------------------------------------}
{ Export to Char/Comma/Tab Separated                                           }
{------------------------------------------------------------------------------}
const
  UXFCommaSeparatedType  = 0;
  UXFTabSeparatedType    = 1;
  UXFCharSeparatedType   = 2;
  UXFSeparatedValuesType = 3;

type
  UXFCharCommaTabSeparatedOptions = record
    structSize            : Word;
    useReportNumberFormat : Bool;
    useReportDateFormat   : Bool;
    stringDelimiter       : Char;
    fieldDelimiter        : PChar;
    nEncodedBytes         : Word;
  end;

const
  UXFCharCommaTabSeparatedOptionsSize = SizeOf(UXFCharCommaTabSeparatedOptions);

{------------------------------------------------------------------------------}
{ Export to ODBC                                                               }
{------------------------------------------------------------------------------}
const
  MAX_ODBC_SOURCES  = 100; {Max. # of ODBC data sources}
  UXFODBCType       = MAX_ODBC_SOURCES + 1;

type
  UXFODBCOptions = record
    structSize         : Word;
    dataSourceName     : PChar;
    dataSourceUserID   : PChar;
    dataSourcePassword : PChar;
    exportTableName    : PChar;
    nEncodedBytes      : Word;
  end;

const
  UXFODBCOptionsSize = SizeOf(UXFODBCOptions);

{------------------------------------------------------------------------------}
{ Export to HTML                                                               }
{------------------------------------------------------------------------------}
const
  UXFHTML32StdType     = 2;  {HTML 3.2 tags}
  UXFHTML40Type        = 3;  {DHTML tags}
  UXFDHTMLType         = 3;  {DHTML tags}
  UXFJPGExtensionStyle = 0;  {default .jpg extension for images}

type
  PEDWordArray = array[0..2] of DWord;
  PPEDWordArray = ^PEDWordArray;

  UXFHTML3Options = record
    structSize       : Word;
    fileName         : PChar;  {ptr to full Windows filepath of HTML output file}
                               {e.g. "C:\pub\docs\boxoffic\default.htm"}
                               {NOTE: any exported GIF files will be}
                               {located in the same directory as this file}
    pageNavigator    : Bool;
    separatePages    : Bool;
    imageExtStyle    : Word;   {reserved, must be set to UXFJPGExtensionStyle (= 0)}
    {new in version 8.5 - currently only 1 page range is supported}
    nPageRanges      : Word;  {must be set to 0 (exporting all pages) or 1 (1 page range)}
    pfirstPageNo     : PPEDWordArray;  {points to DWORD[], where pfirstPageNo[0] = page# of the first page in the range}
    plastPageNo      : PPEDWordArray;  {points to DWORD[], where plastPageNo[0] = page# of the last page in the range}
  end;

const
  UXFHTML3OptionsSize = SizeOf(UXFHTML3Options);
  EncodedOptionsMask  = $8000;

{------------------------------------------------------------------------------}
{ Export to Adobe Acrobat PDF                                                  }
{------------------------------------------------------------------------------}
const
  UXFPortableDocumentFormat = 0;

type
  UXFPDFFormatOptions = record
    structSize      : LongWord;
    exportPageRange : Bool;
    reserved1       : Word;
    reserved2       : Word;
    reserved3       : Word;
    reserved4       : Word;        {in crxf_pdf.h this is a WORD}
    firstPageNo     : Cardinal;    {in crxf_pdf.h this is a WORD}
    lastPageNo      : Cardinal;    {in crxf_pdf.h this is a WORD}
  end;

const
  UXFPDFFormatOptionsSize = SizeOf(UXFPDFFormatOptions);

{------------------------------------------------------------------------------}
{ Export to RTF                                                                }
{------------------------------------------------------------------------------}
const
  UXFExactRichTextFormatType = 0;

type
  UXFERTFFormatOptions = record
    structSize      : LongWord; {in crxf_rtf.h this is an unsigned short}
    exportPageRange : Bool;     {in crxf_rtf.h this is an int}
    reserved1       : Word;     {in crxf_rtf.h this is an unsigned short}
    reserved2       : Word;     {in crxf_rtf.h this is an unsigned short}
    reserved3       : Word;     {in crxf_rtf.h this is an unsigned short}
    reserved4       : Word;     {in crxf_rtf.h this is an unsigned short}
    firstPageNo     : Cardinal; {in crxf_rtf.h this is a DWORD}
    lastPageNo      : Cardinal; {in crxf_rtf.h this is a DWORD}
  end;

const
  UXFERTFFormatOptionsSize = SizeOf(UXFERTFFormatOptions);

{------------------------------------------------------------------------------}
{ Export to Editable RTF                                                       }
{------------------------------------------------------------------------------}

const
  UFXEditableRTFFormatType = 1;

type
  UXFEditableRTFFormatOptions = record
    structSize      : LongWord;    {in crxf_rtf.h this is an unsigned short}
    exportPageRange : Bool;        {in crxf_rtf.h this is an int}
    firstPageNo     : Cardinal;    {in crxf_rtf.h this is a unsigned long}
    lastPageNo      : Cardinal;    {in crxf_rtf.h this is a unsigned long}
    exportPageBreaks: Bool;        {in crxf_rtf.h this is an int}
  end;

const
  UXFEditableRTFFormatOptionsSize = SizeOf(UXFEditableRTFFormatOptions);

{------------------------------------------------------------------------------}
{ Export to XML                                                                }
{------------------------------------------------------------------------------}
const
  UXFXMLType = 0;

type
  UXFXMLOptions = record
    structSize         : Word;
    fileName           : PChar;
    allowMultipleFiles : Smallint;
  end;

const
  UXFXmlOptionsSize = SizeOf(UXFXmlOptions);

{------------------------------------------------------------------------------}
{ Export to Word Doc                                                           }
{------------------------------------------------------------------------------}
const
  UXFExactDocFormatType = 0;
  UXFWordWinType = 0;

type
  UXFEDOCFormatOptions = record
    structSize      : LongWord; {in crxf_wordw.h this is a WORD}
    exportPageRange : Bool;
    reserved1       : Word;
    reserved2       : Word;
    reserved3       : Word;
    reserved4       : Word;     {in crxf_wordw.h this is a WORD}
    firstPageNo     : Cardinal; {in crxf_wordw.h this is a DWORD}
    lastPageNo      : Cardinal; {in crxf_wordw.h this is a DWORD}
  end;

const
  UXFEDOCFormatOptionsSize = SizeOf(UXFEDOCFormatOptions);


{******************************************************************************}
{ Setting Page Margins                                                         }
{******************************************************************************}
const
  PE_SM_DEFAULT = $8000; {32768 in decimal}

type
  TPEGetMargins = function (
    printJob   : Smallint;
    var left   : Word;
    var right  : Word;
    var top    : Word;
    var bottom : Word): Bool;  stdcall;

  TPESetMargins = function (
    printJob : Smallint;
    left     : Word;
    right    : Word;
    top      : Word;
    bottom   : Word): Bool;  stdcall;

{******************************************************************************}
{ Report Summary Info                                                          }
{******************************************************************************}
const
  PE_SI_APPLICATION_NAME_LEN  = 128;
  PE_SI_TITLE_LEN             = 128;
  PE_SI_SUBJECT_LEN           = 128;
  PE_SI_AUTHOR_LEN            = 128;
  PE_SI_KEYWORDS_LEN          = 128;
  PE_SI_COMMENTS_LEN          = 512;
  PE_SI_REPORT_TEMPLATE_LEN   = 128;

type
  PEApplicationNameType = array [0..PE_SI_APPLICATION_NAME_LEN-1] of char;
  PETitleType           = array [0..PE_SI_TITLE_LEN-1] of char;
  PESubjectType         = array [0..PE_SI_SUBJECT_LEN-1] of char;
  PEAuthorType          = array [0..PE_SI_AUTHOR_LEN-1] of char;
  PEKeywordsType        = array [0..PE_SI_KEYWORDS_LEN-1] of char;
  PECommentsType        = array [0..PE_SI_COMMENTS_LEN-1] of char;
  PEReportTemplateType  = array [0..PE_SI_REPORT_TEMPLATE_LEN-1] of char;

  PEReportSummaryInfo = record
    structSize      : Word;
    applicationName : PEApplicationNameType; { read only.}
    title           : PETitleType;
    subject         : PESubjectType;
    author          : PEAuthorType;
    keywords        : PEKeywordsType;
    comments        : PECommentsType;
    reportTemplate  : PEReportTemplateType;
    savePreviewPicture : Smallint; {BOOL or PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_REPORT_SUMMARY_INFO = SizeOf(PEReportSummaryInfo);

type
  TPEGetReportSummaryInfo = function (
    printJob        : Smallint;
    var summaryInfo : PEReportSummaryInfo): Bool;  stdcall;

  TPESetReportSummaryInfo = function (
    printJob        : Smallint;
    var summaryInfo : PEReportSummaryInfo): Bool;  stdcall;

{******************************************************************************}
{ Callback Events                                                              }
{******************************************************************************}
const
  { event ID }
  PE_CLOSE_PRINT_WINDOW_EVENT           = 1;
  PE_ACTIVATE_PRINT_WINDOW_EVENT        = 2;
  PE_DEACTIVATE_PRINT_WINDOW_EVENT      = 3;
  PE_PRINT_BUTTON_CLICKED_EVENT         = 4;
  PE_EXPORT_BUTTON_CLICKED_EVENT        = 5;
  PE_ZOOM_CONTROL_SELECTED_EVENT        = 6;
  PE_FIRST_PAGE_BUTTON_CLICKED_EVENT    = 7;
  PE_PREVIOUS_PAGE_BUTTON_CLICKED_EVENT = 8;
  PE_NEXT_PAGE_BUTTON_CLICKED_EVENT     = 9;
  PE_LAST_PAGE_BUTTON_CLICKED_EVENT     = 10;
  PE_CANCEL_BUTTON_CLICKED_EVENT        = 11;
  PE_CLOSE_BUTTON_CLICKED_EVENT         = 12;
  PE_SEARCH_BUTTON_CLICKED_EVENT        = 13;
  PE_GROUPTREE_BUTTON_CLICKED_EVENT     = 14;
  PE_PRINT_SETUP_BUTTON_CLICKED_EVENT   = 15;
  PE_REFRESH_BUTTON_CLICKED_EVENT       = 16;
  PE_SHOW_GROUP_EVENT                   = 17;
  PE_DRILL_ON_GROUP_EVENT	        = 18; { include drill on graph }
  PE_DRILL_ON_DETAIL_EVENT              = 19;
  PE_READING_RECORDS_EVENT              = 20;
  PE_START_EVENT                        = 21;
  PE_STOP_EVENT                         = 22;
  PE_MAPPING_FIELD_EVENT                = 23;
  PE_RIGHT_CLICK_EVENT                  = 24; { right mouse click  }
  PE_LEFT_CLICK_EVENT                   = 25; { left mouse click   }
  PE_MIDDLE_CLICK_EVENT                 = 26; { middle mouse click }
  PE_DRILL_ON_HYPERLINK_EVENT           = 27;
  PE_LAUNCH_SEAGATE_ANALYSIS_EVENT      = 28;

{ All Events are disabled by default; use PEEnableEvent to enable events }
type
  PEEnableEventInfo = record
    structSize                 : Word;
    startStopEvent             : Smallint; {0 or 1, PE_UNCHANGED for no change}
    readingRecordEvent         : Smallint; {0 or 1, PE_UNCHANGED for no change}
    printWindowButtonEvent     : Smallint; {0 or 1, PE_UNCHANGED for no change}
    drillEvent                 : Smallint; {0 or 1, PE_UNCHANGED for no change}
    closePrintWindowEvent      : Smallint; {0 or 1, PE_UNCHANGED for no change}
    activatePrintWindowEvent   : Smallint; {0 or 1, PE_UNCHANGED for no change}
    fieldMappingEvent          : Smallint; {Bool value, PE_UNCHANGED for no change}
    mouseClickEvent            : Smallint; {Bool value, PE_UNCHANGED for no change}
    hyperlinkEvent             : Smallint; {BOOL value, PE_UNCHANGED for no change.}
    launchSeagateAnalysisEvent : Smallint; {BOOL value, PE_UNCHANGED for no change.}
    formattingEvent            : Smallint; {PEBOOL value, PE_UNCHANGED for no change.}
  end;

const
  PE_SIZEOF_ENABLE_EVENT_INFO = SizeOf(PEEnableEventInfo);

type
  TPEEnableEvent = function (
    printJob            : Smallint;
    var enableEventInfo : PEEnableEventInfo): Bool;  stdcall;

  TPEGetEnableEventInfo = function (
    printJob            : Smallint;
    var enableEventInfo : PEEnableEventInfo): Bool;  stdcall;

  TPESetEventCallback = function (
    printJob     : Smallint;
    callbackProc : Pointer;
    userData     : Pointer): Bool;  stdcall;
    (*
    callbackProc function should be of form:
      function callbackProc (
        eventID : Smallint;  {event ID constant}
        param2  : Pointer;   {pointer to Event structure for event ID}
        param3  : Pointer    {user-defined pointer}
        ): Bool stdcall;
    *)
{should have "export" function keyword in 16-bit callback?}

{------------------------------------------------------------------------------}
{ General PrintWindow Event                                                    }
{------------------------------------------------------------------------------}
{ use this structure for
  PE_CLOSE_PRINT_WINDOW_EVENT
  PE_ACTIVATE_PRINT_WINDOW_EVENT
  PE_DEACTIVATE_PRINT_WINDOW_EVENT
  PE_PRINT_BUTTON_CLICKED_EVENT
  PE_EXPORT_BUTTON_CLICKED_EVENT
  PE_FIRST_PAGE_BUTTON_CLICKED_EVENT
  PE_PREVIOUS_PAGE_BUTTON_CLICKED_EVENT
  PE_NEXT_PAGE_BUTTON_CLICKED_EVENT
  PE_LAST_PAGE_BUTTON_CLICKED_EVENT
  PE_CANCEL_BUTTON_CLICKED_EVENT
  PE_PRINT_SETUP_BUTTON_CLICKED_EVENT
  PE_REFRESH_BUTTON_CLICKED_EVENT }
type
  PEGeneralPrintWindowEventInfo = record
    structSize   : Word;
    ignored      : Word; {for 4 byte alignment. ignore.}
    windowHandle : HWnd;
  end;

const
  PE_SIZEOF_GENERAL_PRINT_WINDOW_EVENT_INFO = SizeOf(PEGeneralPrintWindowEventInfo);

{------------------------------------------------------------------------------}
{ Start/Stop Event                                                             }
{------------------------------------------------------------------------------}
{ use this structure for
  PE_START_EVENT
  PE_STOP_EVENT }
const
  { job destination }
  PE_TO_NOWHERE = 0;
  PE_TO_WINDOW  = 1;
  PE_TO_PRINTER = 2;
  PE_TO_EXPORT  = 3;
  PE_FROM_QUERY = 4;
  PE_TO_FAX     = 5;

{ for PE_START_EVENT}
type
  PEStartEventInfo = record
    structSize  : Word;
    destination : Word;
  end;

const
  PE_SIZEOF_START_EVENT_INFO = SizeOf(PEStartEventInfo);

{ for PE_STOP_EVENT}
type
  PEStopEventInfo = record
    structSize  : Word;
    destination : Word;
    jobStatus   : Word; {a PE_JOB constant}
  end;

const
  PE_SIZEOF_STOP_EVENT_INFO = SizeOf(PEStopEventInfo);

{------------------------------------------------------------------------------}
{ Reading Records Event                                                        }
{------------------------------------------------------------------------------}
{ for PE_READING_RECORDS_EVENT }
type
  PEReadingRecordsEventInfo = record
    structSize      : Word;
    cancelled       : Smallint; {0 or 1.}
    recordsRead     : DWord;
    recordsSelected : DWord;
    done            : Smallint; {0 or 1}
  end;

const
  PE_SIZEOF_READING_RECORDS_EVENT_INFO = SizeOf(PEReadingRecordsEventInfo);

{------------------------------------------------------------------------------}
{ Zoom Control Event                                                           }
{------------------------------------------------------------------------------}
{ for PE_ZOOM_CONTROL_SELECTED_EVENT }
type
  PEZoomLevelChangingEventInfo = record
    structSize   : Word;
    zoomLevel    : Word;
    windowHandle : HWnd;
 end;

const
  PE_SIZEOF_ZOOM_LEVEL_CHANGING_EVENT_INFO = SizeOf(PEZoomLevelChangingEventInfo);

{------------------------------------------------------------------------------}
{ Close Button Clicked Event                                                   }
{------------------------------------------------------------------------------}
{ for PE_CLOSE_BUTTON_CLICKED_EVENT}
type
  PECloseButtonClickedEventInfo = record
    structSize   : Word;
    viewIndex    : Word; {which view is going to be closed. start from zero.}
    windowHandle : HWnd; {frame window handle the button is on.}
  end;

const
  PE_SIZEOF_CLOSE_BUTTON_CLICKED_EVENT_INFO = SizeOf(PECloseButtonClickedEventInfo);

{------------------------------------------------------------------------------}
{ Search Button Clicked Event                                                  }
{------------------------------------------------------------------------------}
{for PE_SEARCH_BUTTON_CLICKED_EVENT}
const
  PE_SEARCH_STRING_LEN = 128;

type
  PESearchStringType = array [0..PE_SEARCH_STRING_LEN-1] of WideChar;

  PESearchButtonClickedEventInfo = record
    windowHandle : HWnd;
    searchString : PESearchStringType;
    structSize   : Word;
  end;

const
  PE_SIZEOF_SEARCH_BUTTON_CLICKED_EVENT_INFO = SizeOf(PESearchButtonClickedEventInfo);

{------------------------------------------------------------------------------}
{ GroupTree Button Clicked Event                                               }
{------------------------------------------------------------------------------}
{for PE_GROUPTREE_BUTTON_CLICKED_EVENT}
type
  PEGroupTreeButtonClickedEventInfo = record
    structSize   : Word;
    Visible      : Smallint; {0 or 1. Current state of the group tree button}
    windowHandle : HWnd;
  end;

const
  PE_SIZEOF_GROUP_TREE_BUTTON_CLICKED_EVENT_INFO = SizeOf(PEGroupTreeButtonClickedEventInfo);

{------------------------------------------------------------------------------}
{ Show Group Event                                                             }
{------------------------------------------------------------------------------}
{for PE_SHOW_GROUP_EVENT}
type
  PEGroupArray = array[0..0] of PWideChar;
  PPEGroupArray = ^PEGroupArray;

  PEShowGroupEventInfo = record
    structSize   : Word;
    groupLevel   : Word;
    windowHandle : HWnd;
    groupList    : PPEGroupArray;
    { points to an array of group name PChars }
    { PChar memory is freed after calling the call back function }
  end;

const
  PE_SIZEOF_SHOW_GROUP_EVENT_INFO = SizeOf(PEShowGroupEventInfo);

(******************************************************************************
** An example of using the PEGroupArray (array of pointers)
**   - because the array is defined with zero elements,
**     we turn range-checking off in code.
*******************************************************************************
  {Local procedure WindowCallback}
  function WindowCallback(eventID: Smallint; pEvent: pointer; nil): LongBool stdcall;
  var
    ShowGroupInfo : PEShowGroupEventInfo;
    slGroups      : TStringList;
    cnt           : integer;
  begin
    case eventID of
      PE_SHOW_GROUP_EVENT :
        begin
          ShowGroupInfo := PEShowGroupEventInfo(pEvent^);
          if (ShowGroupInfo.structSize = SizeOf(PEShowGroupEventInfo)) then
          begin
            slGroups := TStringList.Create;
            {If Range Checking is on, turn it off}
            {$IFOPT R+}
              {$DEFINE CKRANGE}
              {$R-}
            {$ENDIF}
            for cnt := 0 to ShowGroupInfo.groupLevel - 1 do
              slGroups.Add(WideCharToString(ShowGroupInfo.groupList^[cnt]));
            {$IFDEF CKRANGE}
              {$UNDEF CKRANGE}
              {$R+}
            {$ENDIF}
            {...do something...}
            slGroups.Free;
            Result := True; //to continue processing
          end;
        end;
    end;
  end;
*)

{------------------------------------------------------------------------------}
{ Drill On Group Event                                                         }
{------------------------------------------------------------------------------}
{For PE_DRILL_ON_GROUP_EVENT}
const
  PE_DE_ON_GROUP     = 0;
  PE_DE_ON_GROUPTREE = 1;
  PE_DE_ON_GRAPH     = 2;
  PE_DE_ON_MAP       = 3;
  PE_DE_ON_SUBREPORT = 4;

type
  PEDrillOnGroupEventInfo = record
    structSize   : Word;
    drillType    : Word; { a PE_DE_ constant}
    windowHandle : HWnd;
    { Points to an array of group name. Memory pointed by group list
    { is freed after calling the callback function }
    groupList    : PPEGroupArray;
    groupLevel   : Word;
  end;
  PPEDrillOnGroupEventInfo = ^PEDrillOnGroupEventInfo;

const
  PE_SIZEOF_DRILL_ON_GROUP_EVENT_INFO = SizeOf(PEDrillOnGroupEventInfo);

{------------------------------------------------------------------------------}
{ Drill On Detail Event                                                        }
{------------------------------------------------------------------------------}
{ for PE_DRILL_ON_DETAIL_EVENT }
type
  PEDrillVIStringType = array[0..PE_VI_STRING_LEN-1] of WideChar;

  PEDrillValueInfo = record
    structSize : Word;
    valueType  : Word;   {a PE_VI_ constant}
    viNumber   : Double;
    viCurrency : Double;
    viBoolean  : Bool;
    viString   : PEDrillVIStringType;
    viDate     : PEVIDateOrTimeType; {year, month, day}
    viDateTime : PEVIDateTimeType;   {year, month, day, hour, minute, second}
    viTime     : PEVIDateOrTimeType; {hour, minute, second}
    viColor    : DWord;
    viInteger  : Smallint;
    viC        : Char;
    ignored    : Char; {for 4 byte alignment. ignored.}
    viLong     : DWord;
  end;

  PEDrillDetailFieldNameType = array[0..(PE_FIELD_NAME_LEN-1)] of WideChar;

  PEFieldValueInfo = record
    structSize : Word;
    ignored    : Word;       {for 4 byte alignment. ignore.}
    fieldName  : PEDrillDetailFieldNameType;
    fieldValue : PEDrillValueInfo;
    reserved1    : Word;      //Added padding to have DrillDetailInfo structSize
    reserved2    : Word;      //match structSize of PEFieldValueInfo
  end;
  PPEFieldValueInfo      = ^PEFieldValueInfo;
  PEFieldValueInfoArray  = array [0..0] of PPEFieldValueInfo;
  PPEFieldValueInfoArray = ^PEFieldValueInfoArray;

const
  PE_SIZEOF_FIELD_VALUE_INFO = SizeOf(PEFieldValueInfo);

type
  PEDrillOnDetailEventInfo = record
    structSize         : Word;
    selectedFieldIndex : Smallint; {-1 if no field selected}
    windowHandle       : HWnd;
    { points to an array of PEFieldValue. memory
      pointed by fieldValueList is freed after
      calling the call back function }
    fieldValueList     : PPEFieldValueInfoArray;
    nFieldValue        : Smallint; {number of field value in fieldValueList}
  end;

const
  PE_SIZEOF_DRILL_ON_DETAIL_EVENT_INFO = SizeOf(PEDrillOnDetailEventInfo);

{------------------------------------------------------------------------------}
{ Mouse Click Event                                                            }
{------------------------------------------------------------------------------}
{ use this structure for
  PE_RIGHT_CLICK_EVENT
  PE_LEFT_CLICK_EVENT
  PE_MIDDLE_CLICK_EVENT }
const
  { mouse click action }
  PE_MOUSE_NOTSUPPORTED = 0;
  PE_MOUSE_DOWN         = 1;
  PE_MOUSE_UP           = 2;
  PE_MOUSE_DOUBLE_CLICK = 3;

  { mouse click flags (virtual key state-masks) }
  PE_CF_NONE       = $0000;
  PE_CF_LBUTTON    = $0001;
  PE_CF_RBUTTON    = $0002;
  PE_CF_SHIFTKEY   = $0004;
  PE_CF_CONTROLKEY = $0008;
  PE_CF_MBUTTON    = $0010;

{for PE_RIGHT_CLICK_EVENT}
type
  PEMouseClickEventInfo = record
    structSize   : Word;
    windowHandle : HWnd;
    clickAction  : integer;     {PE_MOUSE constants: mouse button down or up}
    clickFlags   : integer;     {any combination of PE_CF_*}
    xOffset      : integer;     {x-coordinate of mouse click in pixels}
    yOffset      : integer;     {y-coordinate of mouse click in pixels}
    fieldValue   : PEDrillValueInfo;	{value of object at click point if it is a field}
                                {object, excluding MEMO and BLOB fields,}
                                {else valueType element = PE_VI_NOVALUE.}
    reserved1 : Word; // padding so structSize comparison succeeds in ucrpe32.pas line 9560
    objectHandle : DWord;	{the design view object}
    reserved2 : Word; // padding so structSize comparison succeeds in ucrpe32.pas line 9560
    sectionCode  : Smallint;	{section in which click occurred.}
  end;

const
  PE_SIZEOF_MOUSE_CLICK_EVENT_INFO = SizeOf(PEMouseClickEventInfo);

{------------------------------------------------------------------------------}
{ Field Mapping Event                                                          }
{------------------------------------------------------------------------------}
const
  PE_TABLE_NAME_LEN          = 128;
  PE_DATABASE_FIELD_NAME_LEN = 128;
  PE_FIELD_DESCRIPTION_LEN   = 128;

  { Field value type }
  PE_FVT_INT8SFIELD           = 1;
  PE_FVT_INT8UFIELD           = 2;
  PE_FVT_INT16SFIELD          = 3;
  PE_FVT_INT16UFIELD          = 4;
  PE_FVT_INT32SFIELD          = 5;
  PE_FVT_INT32UFIELD          = 6;
  PE_FVT_NUMBERFIELD          = 7;
  PE_FVT_CURRENCYFIELD        = 8;
  PE_FVT_BOOLEANFIELD         = 9;
  PE_FVT_DATEFIELD            = 10;
  PE_FVT_TIMEFIELD            = 11;
  PE_FVT_STRINGFIELD          = 12;
  PE_FVT_TRANSIENTMEMOFIELD   = 13;
  PE_FVT_PERSISTENTMEMOFIELD  = 14;
  PE_FVT_BLOBFIELD            = 15;
  PE_FVT_DATETIMEFIELD        = 16;
  PE_FVT_BITMAPFIELD          = 17;
  PE_FVT_ICONFIELD            = 18;
  PE_FVT_PICTUREFIELD         = 19;
  PE_FVT_OLEFIELD             = 20;
  PE_FVT_GRAPHFIELD           = 21;
  PE_FVT_UNKNOWNFIELD         = 22;

  { Field mapping types }
  PE_FM_AUTO_FLD_MAP          = 0;
  { Auto field name mapping }
  { Unmapped Report fields will be removed }

  PE_FM_CRPE_PROMPT_FLD_MAP   = 1;
  { CRPE provides dialog box to map field manually }

  PE_FM_EVENT_DEFINED_FLD_MAP = 2;
  { CRPE provides list of field in report and new database }
  { User needs to activate the PE_MAPPING_FIELD_EVENT }
  { and define a callback function }

type
  TPEGetFieldMappingType = function (
    printJob        : Smallint;
    var mappingType : Word): Bool;  stdcall; 

  TPESetFieldMappingType = function (
    printJob    : Smallint;
    mappingType : Word): Bool;  stdcall;

  PETableAliasNameType     = array [0..PE_TABLE_NAME_LEN -1] of Char;
  PEDatabaseFieldNameType  = array [0..PE_DATABASE_FIELD_NAME_LEN -1] of Char;

  PEReportFieldMappingInfo = record
    structSize        : Word;
    valueType         : Word; { a PE_FVT_constant }
    tableAliasName    : PETableAliasNameType;
    databaseFieldName : PEDatabaseFieldNameType;
    mappingTo         : integer;
    { Mapped fields are assigned to the index of a field }
    { in array PEFieldMappingEventInfo->databaseFields. }
    { Unmapped fields are assigned to -1 }
  end;

  PPEReportFieldMappingInfo = ^PEReportFieldMappingInfo;
  PEMappingInfoArray = array[0..0] of PPEReportFieldMappingInfo;
  PPEMappingInfoArray = ^PEMappingInfoArray;

const
  PE_SIZEOF_REPORT_FIELDMAPPING_INFO = SizeOf(PEReportFieldMappingInfo);

type
  PEFieldMappingEventInfo = record
    structSize      : Word;
    reportFields    : PPEMappingInfoArray;
    { An array of pointers to the fields in the report }
    { User need to modify the 'mappingTo' of each new mapped field
    { by assigning the value of the index of a field in the array of databaseFields }
    nReportFields   : Word; { Size of array reportFields }
    databaseFields  : PPEMappingInfoArray;
    { An array of pointers to the fields in the new database file }
    nDatabaseFields : Word; { Size of array databaseField }
  end;

const
  PE_SIZEOF_FIELDMAPPING_EVENT_INFO = SizeOf(PEFieldMappingEventInfo);

{------------------------------------------------------------------------------}
{ Hyperlink Event                                                              }
{------------------------------------------------------------------------------}
type
  PEHyperlinkEventInfo = record
    StructSize    : Word;
    ignored       : Word;  {for 4 byte alignment - ignore}
    windowHandle  : HWnd;
    hyperlinkText : PWideChar; {points to the hyperlink text associated with the object.}
          {memory pointed by hyperlinkText is freed after calling the callback function.}
  end;

const
  PE_SIZEOF_HYPERLINK_EVENT_INFO = SizeOf(PEHyperlinkEventInfo);

{------------------------------------------------------------------------------}
{ Launch Crystal Analysis Event                                                }
{------------------------------------------------------------------------------}
type
  PELaunchSeagateAnalysisEventInfo = record
    StructSize   : Word;
    ignored      : Word;  {for 4 byte alignment - ignore}
    windowHandle : HWnd;
    pathFile     : PWideChar; {points to the path and filename of the temporary report.}
                          {memory pointed by pathFile is freed after calling the callback function.}
  end;

const
  PE_SIZEOF_LAUNCH_SEAGATE_ANALYSIS_EVENT_INFO = SizeOf(PELaunchSeagateAnalysisEventInfo);

{******************************************************************************}
{ Window Cursor                                                                }
{******************************************************************************}
{ All are window standard cursors except PE_TC_MAGNIFY_CURSOR.
  PE_TC_SIZEALL_CURSOR, PE_TC_NO_CURSOR, PE_TC_APPSTARTING_CURSOR
  and PE_TC_HELP_CURSOR are  not supported in 16-bit.
  PE_TC_SIZE_CURSOR and PE_TC_ICON_CURSOR are obsolete for 32-bit;
  use PE_TC_SIZEALL_CURSOR and PE_TC_ARROW_CURSOR instead. }
const
  PE_TC_DEFAULT_CURSOR     = 0; {CRPE set default cursor to be PE_TC_ARRAOW_CURSOR}
  PE_TC_ARROW_CURSOR       = 1;
  PE_TC_CROSS_CURSOR       = 2;
  PE_TC_IBEAM_CURSOR       = 3;
  PE_TC_UPARROW_CURSOR     = 4;
  PE_TC_SIZEALL_CURSOR     = 5;  {32-bit}
  PE_TC_SIZENWSE_CURSOR    = 6;
  PE_TC_SIZENESW_CURSOR    = 7;
  PE_TC_SIZEWE_CURSOR      = 8;
  PE_TC_SIZENS_CURSOR      = 9;
  PE_TC_NO_CURSOR          = 10; {32-bit}
  PE_TC_WAIT_CURSOR        = 11;
  PE_TC_APPSTARTING_CURSOR = 12; {32-bit}
  PE_TC_HELP_CURSOR	   = 13; {32-bit}
  PE_TC_SIZE_CURSOR        = 14; {16-bit}
  PE_TC_ICON_CURSOR        = 15; {16-bit}

  {CRPE specific cursors: 32-bit}
  PE_TC_BACKGROUND_PROCESS_CURSOR = 94;
  PE_TC_GRAB_HAND_CURSOR          = 95;
  PE_TC_ZOOM_IN_CURSOR            = 96;
  PE_TC_REPORT_SECTION_CURSOR     = 97;
  PE_TC_HAND_CURSOR               = 98;
  PE_TC_MAGNIFY_CURSOR            = 99;

type
  PETrackCursorInfo = record
    structSize                  : Word;
    groupAreaCursor             : Smallint; {a PE_TC constant. PE_UNCHANGED for no change}
    groupAreaFieldCursor        : Smallint; {a PE_TC constant. PE_UNCHAGNED for no change}
    detailAreaCursor            : Smallint; {a PE_TC constant. PE_UNCHANGED for no change}
    detailAreaFieldCursor       : Smallint; {a PE_TC constant. PE_UNCHANGED for no change}
    graphCursor                 : Smallint; {a PE_TC constant. PE_UNCHANGED for no change}
    groupAreaCursorHandle       : DWord;    {reserved}
    groupAreaFieldCursorHandle  : DWord;    {reserved}
    detailAreaCursorHandle      : DWord;    {reserved}
    detailAreaFieldCursorHandle : DWord;    {reserved}
    graphCursorHandle           : DWord;    {reserved}
    ondemandSubreportCursor     : Smallint; {Cursor to show over on-demand subreports when}
                                            {drilldown for the window is enabled;}
                                            {default is PE_TC_MAGNIFY_CURSOR.}
    hyperlinkCursor             : Smallint; {Cursor to show over report object that has hyperlink text;}
                                            {default is PE_TC_HAND_CURSOR.}
  end;

const
  PE_SIZEOF_TRACK_CURSOR_INFO = SizeOf(PETrackCursorInfo);

type
  TPEGetTrackCursorInfo = function (
    printJob       : Smallint;
    var cursorInfo : PETrackCursorInfo): Bool;  stdcall;

  TPESetTrackCursorInfo = function (
    printJob       : Smallint;
    var cursorInfo : PETrackCursorInfo): Bool;  stdcall;

{******************************************************************************}
{ Object Operations                                                            }
{******************************************************************************}
type
  TPEGetNObjectsInSection = function (
    printJob    : Smallint;
    sectionCode : Smallint): Smallint;  stdcall;

  TPEGetNthObjectInSection = function (
    printJob    : Smallint;
    sectionCode : Smallint;
    objectN     : Smallint): DWord;  stdcall;

{------------------------------------------------------------------------------}
{ General Object Formatting                                                    }
{  - These options are in the Format dialog in Crystal Reports                 }
{------------------------------------------------------------------------------}
const
  {Alignment - Horizontal}
  PE_AL_DEFAULT_ALIGN = 0;
  PE_AL_LEFT_ALIGN    = 1;
  PE_AL_CENTER_ALIGN  = 2;
  PE_AL_RIGHT_ALIGN   = 3;
  PE_AL_JUSTIFIED     = 4;
  PE_AL_DECIMAL       = 5;
  {Alignment - Vertical}
  PE_AL_TOP_ALIGN     = 6;
  PE_AL_BOTTOM_ALIGN  = 7;
  PE_AL_VCENTER_ALIGN = 8;
  {Border}
  PE_LS_NO_LINE     = 0;
  PE_LS_SINGLE_LINE = 1;
  PE_LS_DOUBLE_LINE = 2;
  PE_LS_DASH_LINE   = 3;
  PE_LS_DOT_LINE    = 4;
  {Negative Format}
  PE_NNT_NOT_NEGATIVE   = 0;
  PE_NNT_LEADING_MINUS  = 1;
  PE_NNT_TRAILING_MINUS = 2;
  PE_NNT_BRACKETED      = 3;
  {Rounding}
  PE_NRT_ROUND_TO_TEN_BILLIONTH      =  1;
  PE_NRT_ROUND_TO_BILLIONTH          =  2;
  PE_NRT_ROUND_TO_HUNDRED_MILLIONTH  =  3;
  PE_NRT_ROUND_TO_TEN_MILLIONTH      =  4;
  PE_NRT_ROUND_TO_MILLIONTH          =  5;
  PE_NRT_ROUND_TO_HUNDRED_THOUSANDTH =  6;
  PE_NRT_ROUND_TO_TEN_THOUSANDTH     =  7;
  PE_NRT_ROUND_TO_THOUSANDTH         =  8;
  PE_NRT_ROUND_TO_HUNDREDTH          =  9;
  PE_NRT_ROUND_TO_TENTH              = 10;
  PE_NRT_ROUND_TO_UNIT               = 11;
  PE_NRT_ROUND_TO_TEN                = 12;
  PE_NRT_ROUND_TO_HUNDRED            = 13;
  PE_NRT_ROUND_TO_THOUSAND           = 14;
  PE_NRT_ROUND_TO_TENTHOUSAND        = 15;
  PE_NRT_ROUND_TO_HUNDREDTHOUSAND    = 16;
  PE_NRT_ROUND_TO_MILLION            = 17;
  {Currency Symbol}
  PE_CST_NO_SYMBOL       = 0;
  PE_CST_FIXED_SYMBOL    = 1;
  PE_CST_FLOATING_SYMBOL = 2;
  {Currency Symbol Placement}
{ShowMessage: I've swapped these values to get what I think is correct...}
  PE_CPT_LEADING_CURRENCY_INSIDE_NEGATIVE   = 1; {0}
  PE_CPT_LEADING_CURRENCY_OUTSIDE_NEGATIVE  = 0; {1}
  PE_CPT_TRAILING_CURRENCY_INSIDE_NEGATIVE  = 3; {2}
  PE_CPT_TRAILING_CURRENCY_OUTSIDE_NEGATIVE = 2; {3}
  {Boolean Type}
  PE_BOT_TRUE_OR_FALSE = 0;
  PE_BOT_T_OR_F        = 1;
  PE_BOT_YES_OR_NO     = 2;
  PE_BOT_Y_OR_N        = 3;
  PE_BOT_ONE_OR_ZERO   = 4;

  {Date Format}
  PE_DWDT_USE_WINDOWS_LONG_DATE      = 0;
  PE_DWDT_USE_WINDOWS_SHORT_DATE     = 1;
  PE_DWDT_NOT_USING_WINDOWS_DEFAULTS = 2;
  {Date Order}
  PE_DO_YEAR_MONTH_DAY = 0;
  PE_DO_DAY_MONTH_YEAR = 1;
  PE_DO_MONTH_DAY_YEAR = 2;
  {Year Format}
  PE_DYT_SHORT_YEAR = 0;
  PE_DYT_LONG_YEAR  = 1;
  PE_DYT_NO_YEAR    = 2;
  {Month Format}
  PE_DMT_NUMERIC_MONTH              = 0;
  PE_DMT_LEADING_ZERO_NUMERIC_MONTH = 1;
  PE_DMT_SHORT_MONTH                = 2;
  PE_DMT_LONG_MONTH                 = 3;
  PE_DMT_NO_MONTH                   = 4;
  {Day Format}
  PE_DDT_NUMERIC_DAY              = 0;
  PE_DDT_LEADING_ZERO_NUMERIC_DAY = 1;
  PE_DDT_NO_DAY                   = 2;
  {Day of Week Format}
  PE_DOWT_SHORT_DAY_OF_WEEK = 0;
  PE_DOWT_LONG_DAY_OF_WEEK  = 1;
  PE_DOWT_NO_DAY_OF_WEEK    = 2;
  {Day of Week Position}
  PE_DOWP_LEADING_DAY_OF_WEEK  = 0;
  PE_DOWP_TRAILING_DAY_OF_WEEK = 1;
  {Day of Week Enclosure}
  PE_DOWE_NONE              = 0;
  PE_DOWE_PARENTHESES       = 1;
  PE_DOWE_FWPARENTHESES     = 2;
  PE_DOWE_SQUARE_BRACKETS   = 3;
  PE_DOWE_FWSQUARE_BRACKETS = 4;
  {Date Era Type}
  PE_DET_SHORT_ERA = 0;
  PE_DET_LONG_ERA  = 1;
  PE_DET_NO_ERA	   = 2;
  {Date Calendar Type}
  PE_DCT_GREGORIANCALENDAR            =  1;
  PE_DCT_GREGORIANUSCALENDAR          =  2;
  PE_DCT_JAPANESECALENDAR             =  3;
  PE_DCT_TAIWANESECALENDAR            =  4;
  PE_DCT_KOREANCALENDAR               =  5;
  PE_DCT_HIJRICALENDAR                =  6;
  PE_DCT_THAICALENDAR                 =  7;
  PE_DCT_HEBREWCALENDAR               =  8;
  PE_DCT_GREGORIANMEFRENCHCALENDAR    =  9; {Gregorian (ME French)}
  PE_DCT_GREGORIANARABICCALENDAR      = 10; {Gregorian (Arabic)}
  PE_DCT_GREGORIANXLITENGLISHCALENDAR = 11; {Gregorian (Transliterated English)}
  PE_DCT_GREGORIANXLITFRENCHCALENDAR  = 12; {Gregorian (Transliterated French)}

  {Time Base}
  PE_TB_12_HOUR = 0;
  PE_TB_24_HOUR = 1;
  {AM/PM Placement}
  PE_TAPT_AM_PM_BEFORE = 0;
  PE_TAPT_AM_PM_AFTER  = 1;
  {Hour Format}
  PE_THT_NUMERIC_HOUR                  = 0;
  PE_THT_NUMBERIC_HOUR_NO_LEADING_ZERO = 1;
  PE_THT_NO_HOUR                       = 2;
  {Minute Format}
  PE_TMT_NUMERIC_MINUTE                 = 0;
  PE_TMT_NUMERIC_MINUTE_NO_LEADING_ZERO = 1;
  PE_TMT_NO_MINUTE                      = 2;
  {Second Format}
  PE_TST_NUMERIC_SECOND                 = 0;
  PE_TST_NUMERIC_SECOND_NO_LEADING_ZERO = 1;
  PE_TST_NUMERIC_NO_SECOND              = 2;
  {Date/Time Order}
  PE_DTO_DATE_THEN_TIME = 0;
  PE_DTO_TIME_THEN_DATE = 1;
  PE_DTO_DATE_ONLY      = 2;
  PE_DTO_TIME_ONLY      = 3;

  {Line Width (Twips)}
  PE_NO_LINE_WIDTH     =  0;
  PE_SINGLE_LINE_WIDTH = 20;
  PE_DOUBLE_LINE_WIDTH = 60;
  PE_DASH_LINE_WIDTH   = 20;
  PE_DOT_LINE_WIDTH    = 20;
  PE_DROP_SHADOW_WIDTH = 60;
  {Text Interpretation}
  PE_TI_NONE = 0;
  PE_TI_RTF  = 1;
  PE_TI_HTML = 2;
  {Line Spacing}
{ShowMessage: reversed these to get proper values}
  PE_LSPC_MULTIPLE = 0; {1}
  PE_LSPC_EXACT    = 1; {0}

{ Getting and Setting common Object formatting }
{ Some Format Options are only for certain Object types }
  {Suppress}
  PE_OFN_VISIBLE                          =  1; { boolean }
  {Alignment}
  PE_OFN_HORALIGNMENT                     =  2; { a PE_AL_ constant (integer) }
  PE_OFN_VERALIGNMENT                     =  3; { a PE_AL_ constant (integer), not used in 5.x }
  {KeepTogether}
  PE_OFN_KEEP_OBJECT_TOGETHER             =  4; { boolean }
  {Close Border on Page Break}
  PE_OFN_SPLIT_ADORNMENT                  =  5; { boolean }
  {Can Grow?}
  PE_OFN_EXPAND                           =  6; { boolean }
  {Border}
  PE_OFN_LEFT_LINE_STYLE                  =  7; { a PE_LS_ constant (integer) }
  PE_OFN_RIGHT_LINE_STYLE                 =  8; { a PE_LS_ constant (integer) }
  PE_OFN_TOP_LINE_STYLE                   =  9; { a PE_LS_ constant (integer) }
  PE_OFN_BOTTOM_LINE_STYLE                = 10; { a PE_LS_ constant (integer) }
  PE_OFN_TIGHT_HORIZONTAL                 = 11; { boolean }
  PE_OFN_TIGHT_VERTICAL                   = 12; { boolean, not used in 5.x }
  PE_OFN_DROP_SHADOW                      = 13; { boolean }
  PE_OFN_FORE_COLOR                       = 14; { COLORREF }
  PE_OFN_BACK_COLOR                       = 15; { COLORREF }
  {Suppress if Duplicated}
  PE_OFN_SUPPRESS_IF_DUPLICATED           = 16; { boolean }
  {System Default Formatting}
  PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING    = 17; { boolean }
  {Currency/Number}
  PE_OFN_SUPPRESS_IF_ZERO                 = 18; { boolean }
  PE_OFN_NEGATIVE_TYPE                    = 19; { a PE_NNT_ constant,(integer) }
  PE_OFN_USE_THOUSANDSSEPARATORS          = 20; { boolean }
  PE_OFN_USE_LEAD_ZERO                    = 21; { boolean }
  PE_OFN_N_DECIMAL_PLACES                 = 22; { integer }
  PE_OFN_ROUNDING_TYPE                    = 23; { a PE_NRT_ constant (integer) }
  PE_OFN_REVERSE_SIGN_FOR_DISPLAY         = 63; { reverse sign for number/currency display }
  PE_OFN_USE_ACCOUNTING_FORMAT            = 64; { use accounting format for number/currency }
  PE_OFN_CURRENCY_SYMBOL                  = 29; { string }
  PE_OFN_CURRENCY_SYMBOL_TYPE             = 24; { a PE_CST_ constant (integer) }
  PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE = 25; { boolean }
  PE_OFN_CURRENCY_POSITION_TYPE           = 26; { a PE_CPT_ constant (integer) }
  PE_OFN_THOUSAND_SYMBOL                  = 27; { string }
  PE_OFN_DECIMAL_SYMBOL                   = 28; { string }
  PE_OFN_SHOW_ZERO_VALUE_AS               = 65; { string to use as replacement for ZERO values }
  {Field Clipping}
  PE_OFN_ALLOW_FIELD_CLIPPING             = 30; { boolean }
  {Boolean Type: True/1/Yes}
  PE_OFN_BOOLEAN_OUPUT_TYPE               = 31; { a PE_BOT_ constant (integer) }
  {Date}
  PE_OFN_DATE_WINDOWS_DEFAULT_TYPE        = 32; { a PE_DWDT_ constant (integer) }
  PE_OFN_DATE_ORDER                       = 33; { a PE_DO_ constant  (integer) }
  PE_OFN_YEAR_TYPE                        = 34; { a PE_DYT_ constant (integer) }
  PE_OFN_MONTH_TYPE                       = 35; { a PE_DMT_ constant (integer) }
  PE_OFN_DAY_TYPE                         = 36; { a PE_DDT_ constant (integer) }
  PE_OFN_DAY_OF_WEEK_TYPE                 = 37; { a PE_DOWT_ constant (integer) }
  PE_OFN_DATE_FIRST_SEPARATOR             = 38; { string }
  PE_OFN_DATE_SECOND_SEPARATOR            = 39; { string }
  PE_OFN_DAY_OF_WEEK_SEPARATOR            = 40; { string }
  PE_OFN_DAY_OF_WEEK_POSITION             = 57; { PE_DOWP_ const (integer) }
  PE_OFN_DATE_ERA_TYPE			  = 58; { PE_DET_ const (integer) }
  PE_OFN_DATE_CALENDAR_TYPE		  = 59; { PE_DCT_ const (integer) }
  PE_OFN_DATE_PREFIX_SEPARATOR		  = 60; { string }
  PE_OFN_DATE_SUFFIX_SEPARATOR		  = 61; { string }
  PE_OFN_DAY_OF_WEEK_ENCLOSURE            = 62; { PE_DOWE_ constant (integer) }
  {Time}
  PE_OFN_TIME_BASE                        = 41; { a PE_TB_ constant (integer) }
  PE_OFN_AM_PM_TYPE                       = 42; { a PE_TAPT_ constant (integer) }
  PE_OFN_HOUR_TYPE                        = 43; { a PE_THT_ constant  (integer) }
  PE_OFN_MINUTE_TYPE                      = 44; { a PE_TMT_ constant (integer) }
  PE_OFN_SECOND_TYPE                      = 45; { a PE_TST_ constant (integer) }
  PE_OFN_PM_STRING                        = 46; { string }
  PE_OFN_AM_STRING                        = 47; { string }
  PE_OFN_MINUTE_SECOND_SEPARATOR          = 48; { string }
  PE_OFN_HOUR_MINUTE_SEPARATOR            = 49; { string }
  {DateTime}
  PE_OFN_DATE_TIME_ORDER                  = 50; { a PE_DTO_ constant (integer) }
  PE_OFN_DATE_TIME_SEPARATOR_STRING       = 51; { string }
  {Text Formatting}
  PE_OFN_WORD_WRAP                        = 52; { not used in 5.x }
  PE_OFN_FIRST_LINE_INDENT                = 53; { not used in 5.x }
  PE_OFN_LEFT_INDENT                      = 54; { not used in 5.x }
  PE_OFN_RIGHT_INDENT                     = 55; { not used in 5.x }
  PE_OFN_MAX_N_LINES                      = 56; { integer }
  PE_OFN_TEXT_INTERPRETATION              = 66; { a PE_TI_* const }
  PE_OFN_LINE_SPACING_TYPE                = 67; { a PE_LSPC_* const }
  PE_OFN_LINE_SPACING                     = 68; { N lines, can be fraction }
  PE_OFN_CHARACTER_SPACING                = 69; { N twips }
  PE_OFN_TEXT_ROTATION                    = 70; { rotation angle in degrees }
                                                { only 0, 90 and 270 are valid currently supported. }
type
  TPEGetObjectFormat = function (
    printJob         : Smallint;
    objectHandle     : DWord;
    objectFormatName : Smallint;  {a PE_OFN constant}
    var valueInfo    : PEValueInfo): Bool;  stdcall;

  TPESetObjectFormat = function (
    printJob         : Smallint;
    objectHandle     : DWord;
    objectFormatName : Smallint;  {a PE_OFN constant}
    var valueInfo    : PEValueInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Getting/setting Object Info                                                  }
{   - These options control width/height and x,y placement                     }
{------------------------------------------------------------------------------}
const
  { object type }
  PE_OI_FIELDOBJECT     =  1;
  PE_OI_TEXTOBJECT      =  2;
  PE_OI_LINEOBJECT      =  3;
  PE_OI_BOXOBJECT       =  4;
  PE_OI_SUBREPORTOBJECT =  5;
  PE_OI_OLEOBJECT       =  6;
  PE_OI_GRAPHOBJECT     =  7;
  PE_OI_CROSSTABOBJECT  =  8;
  PE_OI_BLOBFIELDOBJECT =  9;
  PE_OI_MAPOBJECT       = 10;
  PE_OI_OLAPGRIDOBJECT  = 11;

type
  PEObjectInfo = record
    StructSize  : Word;
    objectType  : Word;     {a PE_OI_ constant}
    xOffset     : LongInt;  {twips, object x,y offset in section, PE_UNCHANGED for no change}
    yOffset     : LongInt;
    width       : LongInt;  {twips, object width and height, PE_UNCHANGED for no change}
    height      : LongInt;
    sectionCode : Smallint; {PE_UNCHANGED for no changing section.}
    repositoryURILength : Smallint;
    hRepositoryURI : HWnd;
  end;

const
  PE_SIZEOF_OBJECT_INFO = SizeOf(PEObjectInfo);

type
  TPEGetObjectInfo = function (
    printJob       : Smallint;
    objectHandle   : DWord;
    var objectInfo : PEObjectInfo): Bool;  stdcall;

  TPESetObjectInfo = function (
    printJob       : Smallint;
    objectHandle   : DWord;
    var objectInfo : PEObjectInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Ole Objects                                                                  }
{------------------------------------------------------------------------------}
const
  {OleObjectType}
  PE_OOI_LINKEDOBJECT   =   1;
  PE_OOI_EMBEDDEDOBJECT =   2;
  PE_OOI_STATICOBJECT   =   3;
  {UpdateType}
  PE_OOI_AUTOUPDATE     =   1;
  PE_OOI_MANUALUPDATE   =   3;
  {Path String Length}
  PE_OOI_PATHLEN        = 256;

type
  PEOleObjectPathType = array[0..(PE_OOI_PATHLEN-1)] of Char;
  PEOleObjectInfo = record
    StructSize    : Word;
    oleObjectType : Word; { a PE_OOI_*OBJECT constant }
    linkSource    : PEOleObjectPathType; { valid only for linked objects }
    updateType    : Word; { a PE_OOI_*UPDATE constant }
  end;

const
  PE_SIZEOF_OLE_OBJECT_INFO = SizeOf(PEOleObjectInfo);

type
  TPEGetOleObjectInfo = function (
    printJob          : Smallint;
    objectHandle      : DWord;
    var oleObjectInfo : PEOleObjectInfo): Bool;  stdcall; 

{------------------------------------------------------------------------------}
{ Object Font Color - for Field and Text objects                               }
{------------------------------------------------------------------------------}
type
  TPEGetObjectFontColor = function (
    printJob          : Smallint;
    objectHandle      : DWord;
    var fontColorInfo : PEFontColorInfo): Bool;  stdcall;

  TPESetObjectFontColor = function (
    printJob          : Smallint;
    objectHandle      : DWord;
    var fontColorInfo : PEFontColorInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Summary Field Object                                                         }
{------------------------------------------------------------------------------}
const
  PE_ST_SUM             =  0;
  PE_ST_AVERAGE         =  1;
  PE_ST_SAMPLEVARIANCE  =  2;
  PE_ST_SAMPLESTDDEV    =  3;
  PE_ST_MAXIMUM         =  4;
  PE_ST_MINIMUM         =  5;
  PE_ST_COUNT           =  6;
  PE_ST_POPVARIANCE     =  7;
  PE_ST_POPSTDDEV       =  8;
  PE_ST_DISTINCTCOUNT   =  9;
  PE_ST_CORRELATION     = 10;
  PE_ST_COVARIANCE      = 11;
  PE_ST_WEIGHTEDAVG     = 12;
  PE_ST_MEDIAN          = 13;
  PE_ST_PERCENTILE      = 14;
  PE_ST_NTHLARGEST      = 15;
  PE_ST_NTHSMALLEST     = 16;
  PE_ST_MODE            = 17;
  PE_ST_NTHMOSTFREQUENT = 18;
  PE_ST_PERCENTAGE      = 19;

type
  TPEChangeSummaryType = function (
    printJob            : Smallint;
    summarizedFieldName : PChar;
    groupN              : Smallint; {-1 for Grand Total}
    oldSummaryType      : Smallint; {PE_ST Constant}
    newSummaryType      : Smallint  {PE_ST Constant}
  ): DWord;  stdcall; 

{------------------------------------------------------------------------------}
{ Special Var Field Object                                                     }
{------------------------------------------------------------------------------}
const
  PE_SVT_PRINTDATE        =  0;
  PE_SVT_PRINTTIME        =  1;
  PE_SVT_MODIFICATIONDATE =  2;
  PE_SVT_MODIFICATIONTIME =  3;
  PE_SVT_DATADATE         =  4;
  PE_SVT_DATATIME         =  5;
  PE_SVT_RECORDNUMBER     =  6;
  PE_SVT_PAGENUMBER       =  7;
  PE_SVT_GROUPNUMBER      =  8;
  PE_SVT_TOTALPAGECOUNT   =  9;
  PE_SVT_REPORTTITLE      = 10;
  PE_SVT_REPORTCOMMENTS   = 11;
  PE_SVT_RECORDSELECTION  = 12;
  PE_SVT_GROUPSELECTION   = 13;
  PE_SVT_FILENAME	  = 14;
  PE_SVT_FILEAUTHOR	  = 15;
  PE_SVT_FILECREATIONDATE = 16;
  PE_SVT_PAGENOFM	  = 17;

{------------------------------------------------------------------------------}
{ General Field Object Info                                                    }
{------------------------------------------------------------------------------}
const
  {Field type}
  PE_FIET_DATABASE      = 1;
  PE_FIET_FORMULA       = 2;
  PE_FIET_SUMMARY       = 3;
  PE_FIET_SPECIALVAR    = 4;
  PE_FIET_GROUPNAME     = 5;
  PE_FIET_PARAMETER     = 6;
  PE_FIET_SQLEXPRESSION = 7;
  PE_FIET_RUNNINGTOTAL  = 8;

type
  PEFieldObjectInfo = record
    StructSize : Word;
    fieldType  : Smallint; {a PE_FIET_ constant}
    valueType  : Word;     {a PE_FVT_ constant}
    nBytes     : Word;     {number of bytes}
    fieldName  : PEFieldNameType {name of the field or formula form}
                                 {ie., database field name, formula name}
  end;

const
  PE_SIZEOF_FIELD_OBJECT_INFO = SizeOf(PEFieldObjectInfo);

type
  TPEGetFieldObjectInfo = function (
    printJob            : Smallint;
    fieldObjectHandle   : DWord;
    var fieldObjectInfo : PEFieldObjectInfo): Bool;  stdcall; 

{------------------------------------------------------------------------------}
{ Text Objects                                                                 }
{------------------------------------------------------------------------------}
type
  TPEGetNParagraphs = function (
    printJob         : Smallint;
    textObjectHandle : DWord): Smallint;  stdcall;

  PEParagraphInfo = record
    StructSize      : Word;
    alignment       : Smallint; {a PE_AL_ const, PE_UNCHANGED for no change}
    firstLineIndent : LongInt;  {twips, PE_UNCHANGED for no change}
    leftIndent      : LongInt;  {twips, PE_UNCHANGED for no change}
    rightIndent     : LongInt;  {twips,  PE_UNCHANGED for no change}
    startText       : LongInt;  {start text position. read only}
    endText         : LongInt;  {end text position. read only}
  end;

const
  PE_SIZEOF_PARAGRAPH_INFO = SizeOf(PEParagraphInfo);

type
  TPEGetNthParagraphInfo = function (
    printJob          : Smallint;
    textObjectHandle  : DWord;
    paragraphN        : Smallint;
    var paragraphInfo : PEParagraphInfo): Bool;  stdcall;

  TPESetNthParagraphInfo = function (
    printJob          : Smallint;
    textObjectHandle  : DWord;
    paragraphN        : Smallint;
    var paragraphInfo : PEParagraphInfo): Bool;  stdcall;

  TPEGetNTabStopsInParagraph = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    paragraphN       : Smallint): Smallint;  stdcall;

  PETabStopInfo = record
    StructSize : Word;
    alignment  : Smallint; {a PE_AL_ constant, PE_UNCHANGED for no change}
    xOffset    : LongInt;  {twips, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_TABSTOP_INFO = SizeOf(PETabStopInfo);

type
  TPEGetNthTabStopInfo = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    paragraphN       : Smallint;
    tabStopN         : Smallint; {start from 0}
    var tabStopInfo  : PETabStopInfo): Bool;  stdcall;

  TPESetNthTabStopInfo = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    paragraphN       : Smallint;
    tabStopN         : Smallint; {start from 0}
    var tabStopInfo  : PETabStopInfo): Bool;  stdcall;

  TPEAddTabStop = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    paragraphN       : Smallint;
    var tabStopInfo  : PETabStopInfo): Bool;  stdcall;

  TPEDeleteNthTabStop = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    paragraphN       : Smallint;
    tabStopN         : Smallint): Bool;  stdcall;

  TPEGetNEmbeddedFields = function (
    printJob         : Smallint;
    textObjectHandle : DWord): Smallint;  stdcall;

  PEEmbeddedFieldInfo = record
    StructSize : Word;
    fieldType  : Word;    {a PE_FIET_ constant}
    fieldName  : PEFieldNameType; {formula form}
    startText  : LongInt	;	{text start position}
    endText    : LongInt	; {text end position}
  end;

const
  PE_SIZEOF_EMBEDDED_FIELD_INFO = SizeOf(PEEmbeddedFieldInfo);

type
  {an embedded field occupies two character position}
  TPEGetNthEmbeddedFieldInfo = function (
    printJob              : Smallint;
    textObjectHandle      : DWord;
    embeddedFieldN        : Smallint;
    var embeddedFieldInfo : PEEmbeddedFieldInfo): Bool;  stdcall;

  TPEGetNthEmbeddedFieldFormat = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    embeddedFieldN   : Smallint;
    objectFormatName : Smallint; {a PE_OFN_ constant}
    var valueInfo    : PEValueInfo): Bool;  stdcall;

  TPESetNthEmbeddedFieldFormat = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    embeddedFieldN   : Smallint;
    objectFormatName : Smallint; {a PE_OFN_ constant}
    var valueInfo    : PEValueInfo): Bool;  stdcall;

  TPEGetNthEmbeddedFieldFormatFormula = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    embeddedFieldN   : Smallint;
    formulaName      : Smallint; {a field PE_FFN_ constant}
    var textHandle   : HWnd;
    var textLength   : Smallint): Bool;  stdcall;

  TPESetNthEmbeddedFieldFormatFormula = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    embeddedFieldN   : Smallint;
    formulaName      : Smallint; {a field PE_FFN_ constant}
    formulaString    : PChar): Bool;  stdcall;

  TPEDeleteNthEmbeddedField = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    embeddedFieldN   : Smallint): Bool;  stdcall;

  TPEInsertEmbeddedField = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    position         : LongInt;
    fieldName        : PChar {formula form}
  ): Bool;  stdcall;

  TPEGetTextFontColor = function (
    printJob          : Smallint;
    textObjectHandle  : DWord;
    position          : LongInt;
    var fontColorInfo : PEFontColorInfo): Bool;  stdcall;

  TPESetTextFontColor = function (
    printJob          : Smallint;
    textObjectHandle  : DWord;
    startPosition     : LongInt;
    endPosition       : LongInt;
    var fontColorInfo : PEFontColorInfo): Bool;  stdcall;

  TPEGetTextSize = function (
    printJob          : Smallint;
    textObjectHandle  : DWord): LongInt;  stdcall;

  TPEGetTextHeight = function (
    printJob         : Smallint;
    textObjectHandle : DWord ): LongInt;  stdcall;
  {return in Twips}

  {Returned text include return and tab key. embedded fields are replaced by [].}
  TPEGetText = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    var textHandle   : HWnd;
    var textLength   : Smallint): Bool;  stdcall;

  TPEInsertText = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    position         : LongInt;
    text             : PChar): Bool;  stdcall;

  TPEDeleteText = function (
    printJob         : Smallint;
    textObjectHandle : DWord;
    startText        : LongInt;
    endText          : LongInt): Bool;  stdcall;

  PEFilePathType = array[0..PE_FILE_PATH_LEN-1] of Char;
  { Insert into text object from memory or a file.}
  PEInsertTextInfo = record
    structSize       : Word;
    textObjectHandle : DWord;
    position         : LongInt;  {Insertion point}
    reserved1        : DWord;    {reserved; set to 0}
    reserved2        : DWord;    {reserved; set to 0}
    memoryHandle     : HWnd;     {handle to global memory; if NULL then pathFile must not be empty}
    pathFile         : PEFilePathType; {source file.path; if empty then memoryHandle must not be NULL}
  end;

const
  PE_SIZEOF_INSERT_TEXT_INFO = SizeOf(PEInsertTextInfo);

type
  {This API can be used to instead of PEInsertText.}
  {For plain ascii in memory, PEInsertText is more efficient.}
  TPEInsertTextEx = function (
    printJob           : Smallint;
    var insertTextInfo : PEInsertTextInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Subreport Objects                                                            }
{------------------------------------------------------------------------------}
type
  PESubreportLinkInfo = record
    StructSize : Word;
    mainReportFieldName : PEFieldNameType; {formula form: PE_FIELD_NAME_LEN 512}
    subreportFieldName  : PEFieldNameType; {formula form: PE_FIELD_NAME_LEN 512}
    promptVarFieldName  : PEFieldNameType;
  end;

const
  PE_SIZEOF_SUBREPORT_LINK_INFO = SizeOf(PESubreportLinkInfo);

type
  TPEGetNthSubreportLink = function (
    printJob                  : Smallint;
    subreportHandle           : DWord;
    subreportLinkN            : Smallint; {start from 0}
    mainReportFieldNameHandle : HWnd;     {formula form}
    mainReportFieldNameLength : Smallint;
    promptVarFieldNameHandle  : HWnd;     {formula form}
    promptVarFieldNameLength  : Smallint): Bool;  stdcall;

  TPEGetNthSubreportLinkEx = function (
    printJob              : Smallint;
    subreportHandle       : DWord;
    subreportLinkN        : Smallint; {start from 0}
    var subreportLinkInfo : PESubreportLinkInfo): Bool;  stdcall;

const
  PE_SRI_UNDEFINED      =  -1;
  PE_SRI_ONOPENJOB      =   0; {Reimport the subreport when opening the main report}
  PE_SRI_ONFUNCTIONCALL =   1; {Reimport the subreport when the api is called}

type
  TPEReimportSubreport = function (
    printJob        : Smallint;
    subreportHandle : DWord;
    var linkChanged : Bool;
    var reimported  : Bool): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Line Objects                                                                 }
{------------------------------------------------------------------------------}
type
  PELineObjectInfo = record
    StructSize : Word;
    startSectionCode    : Smallint; {PE_UNCHANGED for no change}
    endSectionCode      : Smallint; {PE_UNCHANGED for no change}
    lineStyle           : Smallint; {a PE_LS_ constant}
    leftXOffset         : LongInt;  {twips, PE_UNCHANGED for no change}
    topYOffset          : LongInt;  {twips, PE_UNCHANGED for no change}
    lineWidth           : LongInt;  {twips, PE_UNCHANGED for no change}
    rightXOffset        : LongInt;  {twips, PE_UNCHAGED for no change}
    bottomYOffset       : LongInt;  {twips, PE_UNCHANGED for no change}
    lineColor           : COLORREF; {PE_UNCHANGED_COLOR for no change}
    expandToNextSection : Smallint; {BOOL value except using PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_LINE_OBJECT_INFO = SizeOf(PELineObjectInfo);

type
  TPEGetLineObjectInfo = function (
    printJob           : Smallint;
    lineObjectHandle   : DWord;
    var lineObjectInfo : PELineObjectInfo): Bool;  stdcall;

  TPESetLineObjectInfo = function (
    printJob           : Smallint;
    lineObjectHandle   : DWord;
    var lineObjectInfo : PELineObjectInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Box Objects                                                                  }
{------------------------------------------------------------------------------}
type
  PEBoxObjectInfo = record
    StructSize             : Word;
    topLeftSectionCode     : Smallint; {PE_UNCHANGED for no change}
    leftXOffset            : LongInt;  {twips, PE_UNCHANGED for no change}
    topYOffset             : LongInt;  {twips, PE_UNCHANGED for no change}
    bottomRightSectionCode : Smallint; {PE_UNCHANGED for no change}
    lineStyle              : Smallint; {a PE_LS_ constant, PE_UNCHANGED for no change}
    rightXOffset           : LongInt;  {twips, PE_UNCHANGED for no change}
    bottomYOffset          : LongInt;  {twips, PE_UNCHANGED for no change}
    lineWidth              : LongInt;  {PE_UNCHANGED for no change}
    lineColor              : COLORREF; {PE_UNCHANGED_COLOR for no change}
    fillColor              : COLORREF; {PE_UNCHANGED_COLOR for no change, PE_NO_COLOR for no filling color}
    dropShadow             : Smallint; {BOOL value except using PE_UNCHANGED for no change}
    topBottomClose         : Smallint; {BOOL value except using PE_UNCHANGED for no change}
    expandToNextSection    : Smallint; {BOOL value except using PE_UNCHANGED for no change}
    cornerEllipseHeight    : LongInt;  {Twips or PE_UNCHANGED}
    cornerEllipseWidth     : LongInt;  {Twips or PE_UNCHANGED}
  end;

const
  PE_SIZEOF_BOX_OBJECT_INFO = SizeOf(PEBoxObjectInfo);

type
  TPEGetBoxObjectInfo = function (
    printJob          : Smallint;
    boxObjectHandle   : DWord;
    var boxObjectInfo : PEBoxObjectInfo): Bool;  stdcall;

  TPESetBoxObjectInfo = function (
    printJob          : Smallint;
    boxObjectHandle   : DWord;
    var boxObjectInfo : PEBoxObjectInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Picture Objects (Blob fields...and Ole pictures?)                            }
{------------------------------------------------------------------------------}
type
  PEPictureFormatInfo = record
    StructSize     : Word;
    ignored        : Word;    {for 4 byte alignment - ignore}
    leftCropping   : LongInt; {twips, PE_UNCHANGED for no change}
    rightCropping  : LongInt; {twips, PE_UNCHANGED for no change}
    topCropping    : LongInt; {twips, PE_UNCHANGED for no change}
    bottomCropping : LongInt; {twips, PE_UNCHANGED for no change}
    xScaling       : Double;  {0 for no change}
    yScaling       : Double;  {0 for no change}
  end;

const
  PE_SIZEOF_PICTURE_FORMAT_INFO = SizeOf(PEPictureFormatInfo);

type
  TPEGetPictureFormatInfo = function (
    printJob              : Smallint;
    objectHandle          : DWord; {picture or blob field object}
    var pictureFormatInfo : PEPictureFormatInfo): Bool;  stdcall;

  TPESetPictureFormatInfo = function (
    printJob              : Smallint;
    objectHandle          : DWord; {picture or blob field object}
    var pictureFormatInfo : PEPictureFormatInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ CrossTab Objects                                                             }
{------------------------------------------------------------------------------}
type
  {CrossTab General Options}
  PECrossTabOptions = record
    StructSize             : Word;
    showCellMargins        : Smallint; {BOOL value, PE_UNCHANGED for no change}
    suppressEmptyRows      : Smallint; {BOOL value, PE_UNCHANGED for no change}
    suppressEmptyCols      : Smallint; {BOOL value, PE_UNCHANGED for no change}
    keepColsTogether       : Smallint; {BOOL value, PE_UNCHANGED for no change}
    repeatRowLabels        : Smallint; {BOOL value, PE_UNCHANGED for no change}
    suppressRowGrandTotals : Smallint; {BOOL value, PE_UNCHANGED for no change}
    suppressColGrandTotals : Smallint; {BOOL value, PE_UNCHANGED for no change}
    colorRowGrandTotals    : COLORREF; {use PE_UNCHANGED_COLOR for no change}
    colorColGrandTotals    : COLORREF; {use PE_UNCHANGED_COLOR for no change}
    showGrid               : Smallint; {BOOL value, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_CROSSTABOPTIONS = SizeOf(PECrossTabOptions);

type
  TPEGetCrossTabOptions = function (
    printJob            : Smallint;
    hObject             : DWord;
    var crossTabOptions : PECrossTabOptions): Bool;  stdcall;

  TPEGetNSummariesInCrossTabObject = function (
    printJob             : Smallint;
    crossTabObjectHandle : DWord): Smallint;  stdcall;

  PECrossTabSummaryFieldInfo = record
    StructSize                : Word;
    summaryType               : Smallint; {a PE_ST_ constant}
    valueType                 : Word;     {a PE_FVT_ constant}
    nBytes                    : Word;
    summarizedFieldName       : PEFieldNameType;
    crossTabObjectHandle      : DWord;
    secondSummarizedFieldName : PEFieldNameType;
    summaryParameter          : Smallint;
    hierarchicalSummaryType   : Smallint;    { a PE_HST_* constant }
  end;

const
  PE_SIZEOF_CROSSTAB_SUMMARY_FIELD_INFO = SizeOf(PECrossTabSummaryFieldInfo);

type
  TPEGetNthSummaryInfoInCrossTabObject = function (
    printJob             : Smallint;
    crossTabObjectHandle : DWord;
    summaryN             : Smallint;
    var summaryInfo      : PECrossTabSummaryFieldInfo): Bool;  stdcall;

  PECrossTabGroupOptions = record
    StructSize       : Word;
    condition        : Smallint; {a PE_GC_ constant, PE_UNCHANGED for no change}
    sortDirection    : Smallint; {a PE_SF_ const, PE_UNCHANGED for no change}
    showGrid         : Smallint; {obselete, please use PECrossTabOptions.showGrid}
    fieldName        : PEFieldNameType; {formula form}
    backColor        : COLORREF; {PE_UNCHANGED_COLOR for no change}
    suppressSubtotal : Smallint; {BOOL value, PE_UNCHANGED for no change}
    suppressLabel    : Smallint; {BOOL value, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_CROSS_TAB_GROUP_OPTIONS = SizeOf(PECrossTabGroupOptions);

const
  PE_CTRC_ROW = 0;
  PE_CTRC_COL = 1;

type
  TPEGetNGroupsInCrossTabObject = function (
    printJob             : Smallint;
    crossTabObjectHandle : DWord;
    rowCol               : Smallint {a PE_CTRC_ constant}
  ): Smallint;  stdcall;

  TPEGetNthCrossTabGroupOptions = function (
    printJob                  : Smallint;
    crossTabObjectHandle      : DWord;
    rowCol                    : Smallint; {a PE_CTRC_ constant}
    rowColN                   : Smallint;
    var crossTabGroupOptions  : PECrossTabGroupOptions): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Objects                                                                }
{------------------------------------------------------------------------------}
const
  {Graph data types}
  PE_GDT_GROUP_GRAPH    = 0;
  PE_GDT_DETAIL_GRAPH   = 1;
  PE_GDT_CROSSTAB_GRAPH = 2;
  PE_GDT_OLAPGRIDGRAPH  = 3;

type
  {convert graph object handle to graph number}
  TPEGetGraphNumber = function (
    printJob          : Smallint;
    graphObjectHandle : DWord;
    var sectionCode   : Smallint;
    var graphN        : Smallint): Bool;  stdcall;

  PEGraphDataTypeInfo = record
    StructSize           : Word;
    graphDataType        : Smallint; {a PE_GDT_ constant}
    crossTabObjectHandle : DWord;    {if not PE_GDT_CROSSTAB_GRAPH, is NULL}
  end;

const
  PE_SIZEOF_GRAPH_DATA_TYPE_INFO = SizeOf(PEGraphDataTypeInfo);

type
  TPEGetGraphDataType = function (
    printJob              : Smallint;
    sectionCode           : Smallint;
    graphN                : Smallint;
    var graphDataTypeInfo : PEGraphDataTypeInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Object Format Formulas                                                       }
{------------------------------------------------------------------------------}
const
 {Format Formula Name - Object Format}
  {General}
  PE_FFN_OBJECT_VISIBILITY                = 52;  // Suppress
  PE_FFN_HOR_ALIGNMENT                    = 53;  // Alignment
  PE_FFN_KEEP_OBJECT_TOGETHER             = 55;  // Keep Together
  PE_FFN_SPLIT_ADORNMENT                  = 56;  // Close Border
  PE_FFN_EXPAND                           = 57;  // Can Grow
  PE_FFN_KEEP_TOGETHER                    = 62;  // Keep Together
  PE_FFN_SUPPRESS_IF_DUPLICATE            =  1;  // Suppress If Duplicated
  {Number/Currency}
  PE_FFN_SUPPRESS_IF_ZERO                 =  2;
  PE_FFN_NEGATIVE_TYPE                    =  3;
  PE_FFN_USE_THOUSANDS_SEPARATORS         =  4;
  PE_FFN_USE_LEADING_ZERO                 =  5;
  PE_FFN_N_DECIMAL_PLACES                 =  6;
  PE_FFN_ROUNDING_TYPE                    =  7;
  PE_FFN_CURRENCY_SYMBOL_TYPE             =  8;
  PE_FFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE =  9;
  PE_FFN_CURRENCY_POSITION_TYPE           = 10;
  PE_FFN_THOUSAND_SYMBOL                  = 11;
  PE_FFN_DECIMAL_SYMBOL                   = 12;
  PE_FFN_CURRENCY_SYMBOL                  = 13;
  PE_FFN_REVERSE_SIGN_FOR_DISPLAY         = 79; {reverse sign for number/currency display}
  {Field Clipping}
  PE_FFN_ALLOW_FIELD_CLIPPING             = 14;
  {Boolean}
  PE_FFN_BOOLEAN_OUTPUT_TYPE              = 15;
  {Date}
  PE_FFN_DATE_WINDOWS_DEFAULT_TYPE        = 16;
  PE_FFN_DATE_ORDER                       = 17;
  PE_FFN_YEAR_TYPE                        = 18;
  PE_FFN_MONTH_TYPE                       = 19;
  PE_FFN_DAY_TYPE                         = 20;
  PE_FFN_DATE_FIRST_SEPARATOR             = 21;
  PE_FFN_DATE_SECOND_SEPARATOR            = 22;
  PE_FFN_DAY_OF_WEEK_TYPE                 = 23;
  PE_FFN_DAY_OF_WEEK_SEPARATOR            = 24;
  PE_FFN_DAY_OF_WEEK_POSITION             = 69;
  PE_FFN_DATE_ERA_TYPE                    = 70;
  PE_FFN_DATE_CALENDAR_TYPE               = 71;
  PE_FFN_DATE_PREFIX_SEPARATOR            = 72;
  PE_FFN_DATE_SUFFIX_SEPARATOR            = 73;
  PE_FFN_DAY_OF_WEEK_ENCLOSURE            = 78;
  {Time}
  PE_FFN_TIME_BASE                        = 25;
  PE_FFN_AM_PM_TYPE                       = 26;
  PE_FFN_HOUR_TYPE                        = 27;
  PE_FFN_MINUTE_TYPE                      = 28;
  PE_FFN_SECOND_TYPE                      = 29;
  PE_FFN_HOUR_MINUTE_SEPARATOR            = 30;
  PE_FFN_MINUTE_SECOND_SEPARATOR          = 31;
  PE_FFN_AM_STRING                        = 32;
  PE_FFN_PM_STRING                        = 33;
  {DateTime}
  PE_FFN_DATE_TIME_ORDER                  = 34;
  PE_FFN_DATE_TIME_SEPARATOR_STRING       = 35;
  {Text}
  PE_FFN_FIRST_LINE_INDENT                = 37;  {not used in 5.x}
  PE_FFN_LEFT_INDENT                      = 38;  {not used in 5.x}
  PE_FFN_RIGHT_INDENT                     = 39;  {not used in 5.x}
  PE_FFN_MAX_N_LINES                      = 40;
  PE_FFN_FONT_COLOR                       = 68;
  PE_FFN_TEXT_INTERPRETATION              = 80; {Text interpretation of string & memo database fields}
  {Border}
  PE_FFN_LEFT_LINE_STYLE                  = 41;
  PE_FFN_RIGHT_LINE_STYLE                 = 42;
  PE_FFN_TOP_LINE_STYLE                   = 43;
  PE_FFN_BOTTOM_LINE_STYLE                = 44;
  PE_FFN_TIGHT_HORIZONTAL                 = 45;
  PE_FFN_DROP_SHADOW                      = 47;
  PE_FFN_FORE_COLOR                       = 48;
  PE_FFN_BACK_COLOR                       = 49;
  {ToolTip}
  PE_FFN_TOOL_TIP_TEXT                    = 74;
  {Subreport}
  PE_FFN_CAPTION_ODS                      = 75; {on demand subreport caption}
  PE_FFN_CAPTION_PREVIEWTAB               = 76; {on demand subreport preview tab text}
  {HyperLink}
  PE_FFN_HYPERLINK                        = 77; {object hyperlink formula}

type
  TPEGetObjectFormatFormula = function (
    printJob       : Smallint;
    objectHandle   : DWord;
    formulaName    : Smallint; {a object PE_FFN_ constant}
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetObjectFormatFormula = function (
    printJob       : Smallint;
    objectHandle   : DWord;
    formulaName    : Smallint; {a object PE_FFN_ constant}
    formulaString  : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Parameter Field Objects                                                      }
{------------------------------------------------------------------------------}
type
  {Parameter Browse Fields}
  TPEGetParameterBrowseField = function (
    printJob           : Smallint;
    parameterFieldName : PChar;
    reportName         : PChar;
    var textHandle     : HWnd;     {Destination to hold result in}
    var textLength     : Smallint  {formula form Tablename.Fieldname}
  ): Bool;  stdcall;

  TPESetParameterBrowseField = function (
    printJob           : Smallint;
    parameterFieldName : PChar;
    reportName         : PChar;
    browseTableField   : PChar {Source fieldname. Must be in formula format or Table.FieldName}
  ): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ SortFields                                                                   }
{------------------------------------------------------------------------------}
type
  TPEInsertSortField = function (
    printJob   : Smallint;
    sortFieldN : Smallint;
    name       : PChar;    {formula form}
    direction  : Smallint  {a PE_SF_ constant}
  ): Bool;  stdcall; 

  TPESwapSortFields = function (
    printJob    : Smallint;
    sourceSortN : Smallint;
    targetSortN : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Database Tables                                                              }
{------------------------------------------------------------------------------}
{PEGetNTables returned number of physical tables. In Dictionary}
{or Query case, we need to get PEGetNLogicalTables to get the}
{logical tables.  For direct database connection case, this fucntion}
{would be the same as PEGetNTables ();}
type
  TPEGetNLogicalTables = function(printJob : Smallint): Smallint;  stdcall;

type
  TPEGetNthTableAliasName = function (
    printJob       : Smallint;
    tableN         : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

  TPESetNthTableAliasName = function (
    printJob       : Smallint;
    tableN         : Smallint;
    tableAliasName : PChar): Bool;  stdcall;

  PEServerTypeInfo = record
    StructSize : Word;
    { For any of the following values an empty string ("") means to use }
    { the value already set in the report.  To override a value in the  }
    { report use a non-empty string (e.g. "Server A").  All strings are }
    { null-terminated.                                                  }
    DBType     : Word;  {a PE_DT_ constant}
    ServerType : PEServerType;
  end;

const
  PE_SIZEOF_SERVER_TYPE_INFO = SizeOf(PEServerTypeInfo);

type
  TPESetNthTableServerType = function (
    printJob              : Smallint;
    tableN                : Smallint;
    var serverType        : PEServerTypeInfo;
    propagateAcrossTables : Bool): Bool;  stdcall;

  {Controling database field and links}
  {Database Field}
  TPEGetNDatabaseFields = function (
    printJob : Smallint;
    tableN   : Smallint): Smallint;  stdcall;

  PETableNameType = array[0..(PE_TABLE_NAME_LEN-1)] of Char;
  PEField_DescriptionType = array[0..(PE_FIELD_DESCRIPTION_LEN-1)] of Char;

  PEDatabaseFieldInfo = record
    StructSize        : Word;
    valueType         : Word; {a PE_FVT_constant}
    tableAliasName    : PETableNameType;
    databaseFieldName : PEDatabaseFieldNameType;
    nBytes            : Word;
    fieldDescription  : PEField_DescriptionType;
  end;

const
  PE_SIZEOF_DATABASE_FIELD_INFO = SizeOf(PEDatabaseFieldInfo);

type
  TPEGetNthDatabaseFieldInfo = function (
    printJob      : Smallint;
    tableN        : Smallint;
    fieldN        : Smallint;
    var fieldInfo : PEDatabaseFieldInfo): Bool;  stdcall;

const
  PE_JT_EQUAL            =  4;
  PE_JT_LEFT_OUTER       =  5;
  PE_JT_RIGHT_OUTER      =  6;
  PE_JT_OUTER            =  7;
  PE_JT_GREATER_THAN     =  8;
  PE_JT_LESS_THAN        =  9;
  PE_JT_GREATER_OR_EQUAL = 10;
  PE_JT_LESS_OR_EQUAL    = 11;
  PE_JT_NOT_EQUAL        = 12;

  PE_LT_LOOKUP_PARALLEL  =  1;
  PE_LT_LOOKUP_PRODUCT   =  2;
  PE_LT_LOOKUP_SERIES    =  3;

  {database link}
  PE_FI_FIELD_INDEX_ARRAY_LEN = 32;

type
  PEFieldIndexArrayType = array[0..(PE_FI_FIELD_INDEX_ARRAY_LEN-1)] of Smallint;
  PEDatabaseLinkInfo = record
    StructSize       : Word;
    srcTableN        : Smallint;
    destTableN       : Smallint;
    joinType         : Smallint; {PE_JT_ constant}
    lookUpType       : Smallint; {PE_LT_ constant}
    indexInUse       : Smallint; {only for pc database with expression field. Default is -1;}
    srcFieldsIndex   : PEFieldIndexArrayType;
    destFieldsIndex  : PEFieldIndexArrayType;
    nIndexSrcFields  : Smallint;
    nIndexDestFields : Smallint;
    partialMatch     : Smallint; {BOOL value}
  end;

const
  PE_SIZEOF_DATABASE_LINK_INFO = SizeOf(PEDatabaseLinkInfo);

type
  TPEGetNDatabaseLinks = function(printJob : Smallint): Smallint;  stdcall;

  TPEGetNthDatabaseLinkInfo = function (
    printJob             : Smallint;
    databaseLinkN        : Smallint;
    var databaseLinkInfo : PEDatabaseLinkInfo): Bool;  stdcall;

  TPESetDatabaseLinkInfo = function (
    printJob             : Smallint;
    var databaseLinkInfo : PEDatabaseLinkInfo): Bool;  stdcall;

  {convert database driver on next fresh}
  TPEConvertDatabaseDriver = function (
    printJob  : Smallint;
    toDllName : PChar;
    doConvert : Bool): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Printer DevMode                                                              }
{------------------------------------------------------------------------------}
type
  TPEFreeDevMode = function (
    printJob : Smallint;
    pMode    : PDevMode): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Crystal Dictionary                                                           }
{------------------------------------------------------------------------------}
const
  PE_DICT_TYPE_DCT     =  1; {Crystal Dictionary}
  PE_DICT_TYPE_DC5     =  2; {Crystal Dictionary for CRW5.x}
  PE_DICT_TYPE_QRY     =  3; {Crystal Query}
  PE_DICT_TYPE_CIV     =  4; {Crystal Info Views}
  PE_DICT_TYPE_UNKNOWN = 99;

type
  {get the information of Crystal Dictionary or Crystal Query}
  PEDictionaryInfo = record
    StructSize         : Word; {initialize to PE_SIZE_DICTIONARYINFO}
    DictType           : Word;
    FromInfoView       : Word;
    HasRowRestrictions : Word;
  end;

const
  PE_SIZEOF_DICTIONARY_INFO = SizeOf(PEDictionaryInfo);

type
  TPEGetDictionaryInfo = function (
    printJob     : Smallint;
    var dictInfo : PEDictionaryInfo): Bool;  stdcall;

  TPEGetDictionaryLocation = function (
    printJob         : Smallint;
    var dictLocation : PETableLocation): Bool;  stdcall;

  TPEGetDirectoryUserId = function (
    printJob       : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Field Definition Info                                                        }
{------------------------------------------------------------------------------}
const
  PE_FORMULA_NAME_LEN       =  128;
  PE_FORMULA_TEXT_LEN       = 1024;
  PE_SQLEXPRESSION_NAME_LEN =  128;
  PE_SQLEXPRESSION_TEXT_LEN = 1024;

type
  PEFormulaNameType = array[0..(PE_FORMULA_NAME_LEN-1)] of Char;
  PEFormulaTextType = array[0..(PE_FORMULA_TEXT_LEN-1)] of Char;
  PESQLExpressionNameType = array[0..(PE_SQLEXPRESSION_NAME_LEN-1)] of Char;
  PESQLExpressionTextType = array[0..(PE_SQLEXPRESSION_TEXT_LEN-1)] of Char;
  PEFieldDefinitionInfo = record
    StructSize             : Word;
    {Field common properties}
    fieldType              : Word; {a PE_FIET_ constant}
    fieldName              : PEFieldNameType; {formula form}
    valueType              : Word; {a PE_FVT_ constant}
    nBytes                 : Word;
    {Database Field info}
    tableAliasName         : PETableNameType;
    databaseFieldName      : PEDatabaseFieldNameType;
    {Formula Field info}
    formulaFieldName       : PEFormulaNameType; {formula name}
    formulaText            : PEFormulaTextType;
    {Summary Field info}
    summarizedFieldName    : PEFieldNameType; {formula form}
    summaryType            : Word; {a PE_ST_ constant}
    headerAreaCode         : Smallint;
    footerAreaCode         : Smallint;
    {Group Name field info}
    groupN                 : Smallint; {start from 0}
    {Special Var field info}
    specialVarType         : Word; {a PE_SVT_ constant}
    {SQL Expression info}
    SQLExpressionFieldName : PESQLExpressionNameType;
    SQLExpressionText      : PESQLExpressionTextType;
    {field use count}
    useCount               : Smallint; {field use count}
    {more Summary Field info}
    secondSummarizedFieldName : PEFieldNameType; {formula form}
    summaryParameter       : Smallint;
    hierarchicalSummaryType : Smallint;
  end;

const
  PE_SIZEOF_FIELD_DEFINITION_INFO = SizeOf(PEFieldDefinitionInfo);

type
  TPEGetFieldDefinitionInfo = function (
    printJob                : Smallint;
    fieldName               : PChar; {formula form}
    var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;  stdcall; 

  TPEGetFormulaFieldInfo = function (
    printJob                : Smallint;
    formula                 : PChar;
    var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;  stdcall;

  TPEGetSQLExpressionFieldInfo = function (
    printJob                : Smallint;
    expression              : PChar;
    var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Summary Field Info                                                           }
{------------------------------------------------------------------------------}
type
  TPEGetNSummaryFields = function(printJob : Smallint): Smallint;  stdcall;

  PESummaryFieldInfo = record
    StructSize          : Word;
    summaryType         : Smallint; {a PE_ST_ constant}
    fieldName           : PEFieldNameType;
    summarizedFieldName : PEFieldNameType;
    headerAreaCode      : Smallint; {the header area of the area pair the summary is in; ReadOnly for PESetSummaryFieldInfo}
    footerAreaCode      : Smallint; {the footer area of the area pair the summary is in; ReadOnly for PESetSummaryFieldInfo}
    secondSummarizedFieldName : PEFieldNameType;
    summaryParameter          : Smallint; {If summaryType is PE_ST_PERCENTAGE then summaryParameter specifies the}
                                          {group level of the denominator.}
    hierarchicalSummaryType: Smallint;    {a PE_HST_* constant}
  end;

const
  PE_SIZEOF_SUMMARY_FIELD_INFO = SizeOf(PESummaryFieldInfo);

type
  TPEGetNthSummaryFieldInfo = function (
    printJob             : Smallint;
    summaryN             : Smallint;
    var summaryFieldInfo : PESummaryFieldInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Report Style                                                                 }
{------------------------------------------------------------------------------}
const
  {Set Report Style}
  PE_STYLE_STANDARD1 = 0;
  PE_STYLE_STANDARD2 = 1;
  PE_STYLE_STANDARD3 = 2;
  PE_STYLE_TABLE1    = 3;
  PE_STYLE_TABLE2    = 4;
  PE_STYLE_EXECUTIVE = 5;
  PE_STYLE_SHADOWED  = 6;
  PE_STYLE_GRAY      = 7;
  PE_STYLE_COLOR1    = 8;
  PE_STYLE_COLOR2    = 9;

type
  TPEGetReportStyle = function(printJob : Smallint): Word;  stdcall; 

  TPESetReportStyle = function (
    printJob : Smallint;
    style    : Word): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Olap Cubes                                                                   }
{------------------------------------------------------------------------------}
const
  {Get/Set Logon Info for OLAP Datasource used by OLAP Grid Objects}
  PE_OLAP_CONNECTION_STRING_LEN = 1024;
  PE_OLAP_CUBENAME_LEN          =  128;

type
  PEOlapConnectionStringType = array[0..(PE_OLAP_CONNECTION_STRING_LEN-1)] of Char;
  PEOlapCubeNameType = array[0..(PE_OLAP_CUBENAME_LEN-1)] of Char;
  PEOLAPLogOnInfo = record
    StructSize       : Word; {Initialize to PE_SIZEOF_OLAP_LOGON_INFO}
    ServerName       : PEServerNameType;
    DatabaseName     : PEDatabaseNameType;
    ConnectionString : PEOlapConnectionStringType;
    CubeName         : PEOlapCubeNameType;
    {User ID and password used to logo to the OLAP datasource}
    UserID           : PEUserIDType;
    Password         : PEPasswordType;
  end;

const
  PE_SIZEOF_OLAP_LOGON_INFO = SizeOf(PEOLAPLogOnInfo);

type
  {return number of OLAP Cubes used in the reports}
  {return -1 if an error occurs.}
  TPEGetNOLAPCubes = function(printJob: Smallint): Smallint;  stdcall; 

type
  {return TRUE if function succeedes and OLAP logon Info returned}
  {return FALSE if an error occurs}
  TPEGetNthOLAPCubeLogOnInfo = function (
    printJob      : Smallint;
    cubeN         : Smallint;
    var logOnInfo : PEOLAPLogOnInfo): Bool;  stdcall;

  {return TRUE if function succeedes and OLAP logon Info is set}
  {return FALSE if an error occurs}
  TPESetNthOLAPCubeLogOnInfo = function (
    printJob      : Smallint;
    cubeN         : Smallint;
    var logOnInfo : PEOLAPLogOnInfo): Bool;  stdcall;

  TPETestNthOlapCubeConnectivity = function (
    printJob : Smallint;
    cubeN    : Smallint): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Data Info                                                              }
{------------------------------------------------------------------------------}
type
  PENewGraphDataInfo = record
    StructSize          : Word;
    graphDataType       : Word;     {PE_GDT_*, cannot be changed for now}
    {PE_GDT_DETAIL_GRAPH data options}
    forEachRecord       : Smallint; {BOOL, PE_UNCHANGED for no change}
    dontSummarizeValues : Smallint; {BOOL, PE_UNCHANGED for no change}
    {PE_GDT_DETAIL_GRAPH or PE_GDT_GROUP_GRAPH}
    sectionCode         : Smallint; {chart placement, PE_UNCHANGED for no change}
  end;

const
  PE_SIZEOF_NEW_GRAPH_DATA_INFO = SizeOf(PENewGraphDataInfo);

type
  TPEGetGraphDataInfo = function (
    printJob          : Smallint;
    sectionN          : Smallint;
    graphN            : Smallint;
    var graphDataInfo : PENewGraphDataInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Condition Fields                                                       }
{------------------------------------------------------------------------------}
type
  {Graph Condition Fields, detail chart}
  TPEGetNGraphConditionFields = function (
    printJob : Smallint;
    sectionN : Smallint;
    graphN   : Smallint): Smallint;  stdcall;

  TPEGetNthGraphConditionField = function (
    printJob            : Smallint;
    sectionN            : Smallint;
    graphN              : Smallint;
    condFieldN          : Smallint;
    var fieldNameHandle : HWnd;
    var fieldNameLength : Smallint): Bool;  stdcall;

  {If condFieldN is -1, the condition field will be added to the end of the list}
  TPESetNthGraphConditionField = function (
    printJob   : Smallint;
    graphN     : Smallint;
    condFieldN : Smallint;
    fieldName  : PChar): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Data Fields                                                            }
{------------------------------------------------------------------------------}
{note: for cross tab chart, the field name Handle will return an empty string,}
{because current print engine does not assign an unique name to a summary field}
{in cross tab. In the future, print engine is going to add name to a cross tab}
{summary field.}
type
  TPEGetNGraphSummaryFields = function (
    printJob : Smallint;
    sectionN : Smallint;
    graphN   : Smallint): Smallint;  stdcall;

  TPEGetNthGraphSummaryFieldInfo = function (
    printJob             : Smallint;
    graphN               : Smallint;
    fieldN               : Smallint;
    var summaryFieldInfo : PEFieldDefinitionInfo): Bool;  stdcall;

{------------------------------------------------------------------------------}
{ Graph Text - Default Option                                                  }
{------------------------------------------------------------------------------}
type
  TPEGetGraphTextDefaultOption = function (
    printJob   : Smallint;
    sectionN   : Smallint;
    graphN     : Smallint;
    titleType  : Word; {a PE_GTT_ constant}
    var useDefault : Bool): Bool;  stdcall;

  {enable/disable graph default titles}
  TPESetGraphTextDefaultOption = function (
    printJob   : Smallint;
    sectionN   : Smallint;
    graphN     : Smallint;
    titleType  : Word; {a PE_GTT_ constant}
    useDefault : Bool): Bool;  stdcall;

{******************************************************************************}
{ Highlighting Expert                                                          }
{******************************************************************************}
const
  {range condition}
  PE_HE_RC_EQUALTO              = 0;
  PE_HE_RC_NOTEQUALTO           = 1;
  PE_HE_RC_LESSTHAN             = 2;
  PE_HE_RC_LESSTHANOREQUALTO    = 3;
  PE_HE_RC_GREATERTHAN          = 4;
  PE_HE_RC_GREATERTHANOREQUALTO = 5;
  PE_HE_RC_BETWEEN              = 6;
  PE_HE_RC_NOTBETWEEN           = 7;
  {border style}
  PE_HE_BORDER_DEFAULTBORDERSTYLE           = 0;
  PE_HE_BORDER_NONE                         = 1;
  PE_HE_BORDER_SINGLEBOX                    = 2;
  PE_HE_BORDER_DOUBLEBOX                    = 3;
  PE_HE_BORDER_SINGLEUNDERLINE              = 4;
  PE_HE_BORDER_DOUBLEUNDERLINE              = 5;
  PE_HE_BORDER_SINGLEOVERLINE               = 6;
  PE_HE_BORDER_DOUBLEOVERLINE               = 7;
  PE_HE_BORDER_SINGLEBOXWITHDOUBLEUNDERLINE = 8;
  {font Style}
  PE_HE_FONTSTYLE_DEFAULTFONTSTYLE = 0;
  PE_HE_FONTSTYLE_REGULAR          = 1;
  PE_HE_FONTSTYLE_ITALIC           = 2;
  PE_HE_FONTSTYLE_BOLD             = 3;
  PE_HE_FONTSTYLE_BOLDITALIC       = 4;

type
  PEObjectHiliteInfo = record
    StructSize     : Word;
    rangeCondition : Smallint; {PE_UNCHANGED or a PE_HE_RC_*.}
    leftEndpoint   : Double;   {Can be empty to preserve existing value.}
    rightEndpoint  : Double;   {Can be empty to preserve existing value or if}
                               {rangeCondition is not a range.}
    fontColor      : COLORREF; {rgb or PE_UNCHANGED_COLOR.}
    bkColor        : COLORREF; {background color; rgb or PE_UNCHANGED_COLOR.}
    borderStyle    : Smallint; {PE_UNCHANGED or a PE_HE_BORDER_*.}
    fontStyle      : Smallint; {PE_UNCHANGED or a PE_HE_FONTSTYLE_*}
  end;

const
  PE_SIZEOF_OBJECTHILITEINFO = SizeOf(PEObjectHiliteInfo);

type
  TPEGetObjectNHiliteConditions = function (
    printJob : Smallint;
    hObject  : DWord): Smallint;  stdcall;

  TPESetObjectNthHiliteCondition = function (
    printJob : Smallint;
    hObject  : DWord;
    nHilite  : Smallint;
    var hiliteInfo : PEObjectHiliteInfo): Bool;  stdcall;

  TPEGetObjectNthHiliteCondition = function (
    printJob : Smallint;
    hObject  : DWord;
    nHilite  : Smallint;
    var hiliteInfo : PEObjectHiliteInfo): Bool;  stdcall;

  TPEAddObjectHiliteCondition = function (
    printJob       : Smallint;
    hObject        : DWord;
    var hiliteInfo : PEObjectHiliteInfo): Bool;  stdcall;

  TPERemoveObjectNthHiliteCondition = function (
    printJob : Smallint;
    hObject  : DWord;
    nHilite  : Smallint): Bool;  stdcall;

  TPEClearObjectHiliteConditions = function (
    printJob : Smallint;
    hObject  : DWord): Bool;  stdcall;

  TPESetObjectNthHiliteConditionPriority = function (
    printJob    : Smallint;
    hObject     : DWord;
    nHilite     : Smallint;
    newPriority : Smallint): Bool;  stdcall;
   {[0 <= newPriority < PEGetObjectNHiliteConditions ()]}

{******************************************************************************}
{ Running Totals                                                               }
{******************************************************************************}
const
  {total conditions (evaluate & reset)}
  PE_RT_TOTAL_NOCONDITION     = 0;
  PE_RT_TOTAL_ONCHANGEOFFIELD = 1;
  PE_RT_TOTAL_ONCHANGEOFGROUP = 2;
  PE_RT_TOTAL_ONFORMULA       = 3;

type
  PERunningTotalInfo = record
    StructSize                : Word;
    summaryOperation          : Smallint; {PE_UNCHANGED or a PE_ST_*}
    summaryOperationParameter : Smallint; {Used when a summary involves a parameter}
                                          {e.g. the value of P in Pth Percentile}
                                          {unsigned integer or PE_UNCHANGED.}
    evalCondition             : Smallint; {PE_UNCHANGED or a PE_RT_TOTAL_*}
    evalGroupN                : Smallint; {PE_UNCHANGED or a group level - MUST be set to PE_UNCHANGED}
               {when calling PESetRunningTotalInfo and evalCondition is}
               {not PE_RT_TOTAL_ONCHANGEOFGROUP else PE_ERR_RUNNINGTOTALCONDMISMATCH}
               {will be returned.}
               {PEGetRunningTotalInfo with set this to PE_UNCHANGED when evalCondition}
               {is not PE_RT_TOTAL_ONCHANGEOFGROUP.}
    resetCondition            : Smallint; {PE_UNCHANGED or a PE_RT_TOTAL_*}
    resetGroupN               : Smallint; {PE_UNCHANGED or a group level - MUST be set to PE_UNCHANGED}
               {when calling PESetRunningTotalInfo and resetCondition is}
               {not PE_RT_TOTAL_ONCHANGEOFGROUP else PE_ERR_RUNNINGTOTALCONDMISMATCH}
               {will be returned.}
               {PEGetRunningTotalInfo will set this to PE_UNCHANGED when resetCondition}
               {is not PE_RT_TOTAL_ONCHANGEOFGROUP.}
  end;

const
  PE_SIZEOF_RUNNINGTOTALINFO = SizeOf(PERunningTotalInfo);

type
  TPEGetNRunningTotals = function(printJob: Smallint): Smallint;  stdcall; 
  {returns -1 if error}

  TPEGetNthRunningTotalName = function (
    printJob       : Smallint;
    runningtotalN  : Smallint;
    var nameHandle : HWnd;   {handle to string in formula form}
    var nameLength : Smallint): Bool;  stdcall;

  TPEGetRunningTotalInfo = function (
    printJob   : Smallint;
    rtName     : PChar;
    var rtInfo : PERunningTotalInfo): Bool;  stdcall;

  {If the Condition is not PE_RT_TOTAL_ONCHANGEOFFIELD,
   this function returns a handle to an empty string}
  TPEGetRunningTotalConditionField = function (
    printJob        : Smallint;
    rtName          : PChar;
    var hEvalField  : HWnd;
    var evalLength  : Smallint;
    var hResetField : HWnd;
    var resetLength : Smallint): Bool;  stdcall;

  {If the Condition is not PE_RT_TOTAL_ONFORMULA,
   this function returns a handle to an empty string}
  TPEGetRunningTotalConditionFormula = function (
    printJob          : Smallint;
    rtName            : PChar;
    var hEvalFormula  : HWnd;
    var evalLength    : Smallint;
    var hResetFormula : HWnd;
    var resetLength   : Smallint): Bool;  stdcall;

  {For summaries involving 2 fields (such as correlation),
   secondFieldName is the second summarised fieldname, else it is empty.}
  TPEGetRunningTotalSummaryField = function (
    printJob             : Smallint;
    rtName               : PChar;
    var summaryFieldName : HWnd;
    var summaryLength    : Smallint;
    var secondFieldName  : HWnd;
    var secondLength     : Smallint): Bool;  stdcall;

{******************************************************************************}
{ Mapping                                                                      }
{******************************************************************************}
const
  {layout}
  PE_MAP_LAYOUT_DETAIL   = 0;
  PE_MAP_LAYOUT_GROUP    = 1;
  PE_MAP_LAYOUT_CROSSTAB = 2;
  PE_MAP_LAYOUT_OLAP     = 3;

type
  PEMapDataInfo = record
    StructSize          : Word;
    sectionCode         : Smallint; {Value returned by PE_SECTION_CODE(sectionType,groupN,sectionN) where}
                          {sectionType must be one of PE_SECT_REPORT_HEADER, PE_SECT_REPORT_FOOTER}
                          {PE_SECT_GROUP_HEADER, PE_SECT_GROUP_FOOTER.}
    layout              : Smallint; {a PE_MAP_LAYOUT_*}
    dontSummarizeValues : Smallint; {boolean or PE_UNCHANGED}
  end;

const
  PE_SIZEOF_MAPDATAINFO = SizeOf(PEMapDataInfo);

 {Map Style}
  {theme type}
{ShowMessage: I've swapped these values to get what I think is correct...}
  PE_MAP_TT_RANGED          = 0;//0;
  PE_MAP_TT_DOTDENSITY      = 1;//4;
  PE_MAP_TT_GRADUATED       = 2;//3;
  PE_MAP_TT_PIECHART        = 3;//2;
  PE_MAP_TT_BARCHART        = 4;//1;
  PE_MAP_TT_INDIVIDUALVALUE = 5;//5;
  {distribution method}
  PE_MAP_DM_EQUALCOUNT      = 0;   //  Changed from 1 to 0
  PE_MAP_DM_EQUALRANGES     = 1;   //  Changed from 2 to 1
  PE_MAP_DM_NATURALBREAK    = 2;   //  Changed from 3 to 2
  PE_MAP_DM_STDDEV          = 3;   //  Changed from 4 to 3
  {legend}
  PE_MAP_LEGENDTYPE_FULL    = 0;
  PE_MAP_LEGENDTYPE_COMPACT = 1;
  PE_MAP_LEGENDTYPE_NONE    = 2;
  {legend title type}
  PE_MAP_LTT_AUTO           = 0; {made by map}
  PE_MAP_LTT_SPECIFIC       = 1; {specified in PEMapTextInfo->legendTitle &}
                                 {PEMapTextInfo->legendSubtitle.}
type
  PEMapStyle = record
    StructSize : Word;
    ignored    : Word;    {for 4 byte alignment - ignore}
    themeType  : Smallint; {PE_MAP_TT_* or PE_UNCHANGED.}
    themeSize  : Smallint; {unsigned value or PE_UNCHANGED, for themeType of:}
                           {     PE_MAP_TT_RANGED --> numberOfIntervals}
                           {     PE_MAP_TT_DOTDENSITY --> dotSizeType, 0 for small,}
                           {                              or > 0 for large.}
                           {     PE_MAP_TT_PIECHART --> pieSize}
                           {     PE_MAP_TT_BARCHART --> barSize}
    themeStyle : Smallint; {boolean value or PE_UNCHANGED, for themeType of:}
                           {     PE_TT_RANGED        --> allowEmptyIntervals}
                           {     PE_MAP_TT_PIECHART  --> isPieRelative}
    {for themeType of PE_TT_RANGED only}
    distributionMethod   : Smallint; {PE_MAP_DM_* or PE_UNCHANGED.}
    colorLowestInterval  : COLORREF;
    colorHighestInterval : COLORREF;
    {legend info}
    legendType           : Smallint; {PE_MAP_LEGENDTYPE_*}
    legendTitleType      : Smallint; {PE_MAP_LTT_*}
  end;

const
  PE_SIZEOF_MAPSTYLE = SizeOf(PEMapStyle);

type
  TPEGetMapDataInfo = function (
    printJob    : Smallint;
    hObject     : DWord;
    var mapInfo : PEMapDataInfo): Bool;  stdcall; 

  TPESetMapDataInfo = function (
    printJob    : Smallint;
    hObject     : DWord;
    var mapInfo : PEMapDataInfo): Bool;  stdcall;

  TPEGetMapStyle = function (
    printJob     : Smallint;
    hObject      : DWord;
    var mapStyle : PEMapStyle): Bool;  stdcall;

  TPESetMapStyle = function (
    printJob     : Smallint;
    hObject      : DWord;
    var mapStyle : PEMapStyle): Bool;  stdcall;

  TPEGetNMapSummaryFields = function (
    printJob : Smallint;
    hObject  : DWord): Smallint;  stdcall;

  TPEGetNthMapSummaryField = function (
    printJob          : Smallint;
    hObject           : DWord;
    nSummaryField     : Smallint;
    var summaryField  : HWnd;
    var summaryLength : Smallint): Bool;  stdcall;

  TPESetNthMapSummaryField = function (
    printJob      : Smallint;
    hObject       : DWord;
    nSummaryField : Smallint;
    {for PE_MAP_LAYOUT_DETAIL only, set to PE_UNCHANGED to add.}
    {for other types must be in (0...(PEGetNMapSummaryFields - 1)).}
    summaryField  : PChar): Bool;  stdcall;

   TPEGetNMapConditionFields = function (
     printJob : Smallint;
     hObject  : DWord): Smallint;  stdcall;

  {Use PE(Get)(Set)NthMapConditionField for Detail & Group Maps}
  {For Crosstab and OLAP maps use PE(Get)(Set)MapConditions}
  TPEGetNthMapConditionField = function (
    printJob            : Smallint;
    hObject             : DWord;
    condFieldN          : Smallint;
    var conditionField  : HWnd;
    var conditionLength : Smallint): Bool;  stdcall;

  TPESetNthMapConditionField = function (
    printJob   : Smallint;
    hObject    : DWord;
    condFieldN : Smallint;
    fieldName  : PChar): Bool;  stdcall;

const
  {Condition settings for Crosstab & OLAP maps}
  {crosstab/OLAP map orientation}
  PE_MAP_ORIENT_ROWSONLY    = 0;
  PE_MAP_ORIENT_COLSONLY    = 1;
  PE_MAP_ORIENT_MIXEDROWCOL = 2;
  PE_MAP_ORIENT_MIXEDCOLROW = 3;

type
  PEMapCondition = record
    StructSize    : Word;
    orientation   : Smallint; {a PE_MAP_* constant or PE_UNCHANGED}
    groupSelected : Smallint; {Boolean value or PE_UNCHANGED}
  end;

const
  PE_SIZEOF_MAPCONDITION = SizeOf(PEMapCondition);

type
  TPEGetMapConditions = function (
    printJob         : Smallint;
    hObject          : DWord;
    var mapCondition : PEMapCondition): Bool;  stdcall;

  TPESetMapConditions = function (
    printJob         : Smallint;
    hObject          : DWord;
    var mapCondition : PEMapCondition): Bool;  stdcall;

  TPEGetMapTitle = function (
    printJob        : Smallint;
    hObject         : DWord;
    var mapTitle    : HWnd;
    var titleLength : Smallint): Bool;  stdcall;

  TPESetMapTitle = function (
    printJob : Smallint;
    hObject  : DWord;
    mapTitle : PChar): Bool;  stdcall;

  TPEGetMapLegendTitle = function (
    printJob         : Smallint;
    hObject          : DWord;
    var legendTitle  : HWnd;
    var legendLength : Smallint): Bool;  stdcall;

  TPESetMapLegendTitle = function (
    printJob    : Smallint;
    hObject     : DWord;
    legendTitle : PChar): Bool;  stdcall;

  TPEGetMapLegendSubtitle = function (
    printJob           : Smallint;
    hObject            : DWord;
    var legendSubtitle : HWnd;
    var legendLength   : Smallint): Bool;  stdcall;

  TPESetMapLegendSubtitle = function (
    printJob       : Smallint;
    hObject        : DWord;
    legendSubtitle : PChar): Bool;  stdcall;

{******************************************************************************}
{ Formula Syntax                                                               }
{******************************************************************************}
const
  PE_FST_CRYSTAL = 0;
  PE_FST_BASIC   = 1;
  {Size of array}
  PE_FST_SIZE    = 2;

type
  PEFormulaSyntaxType = array[0..(PE_FST_SIZE-1)] of Smallint;
  PEFormulaSyntax = record
    StructSize    : Word;
    formulaSyntax : PEFormulaSyntaxType; {PE_FST_* or PE_UNCHANGED}
  end;

const
  PE_SIZEOF_FORMULA_SYNTAX = SizeOf(PEFormulaSyntax);

{PEGetFormulaSyntax}
{Indicates the syntax used by the formula addressed in the last formula API call.}
{For running total condition formula,                     }
{  formulaSyntax[0] is the syntax for the evalFormula and }
{  formulaSyntax[1] is the syntax for the reset formula.  }
{***Default Behaviour: If this API is called before any Formula API is called}
{                      then the values returned will be PE_UNCHANGED.}
type
  TPEGetFormulaSyntax = function (
    printJob          : Smallint;
    var formulaSyntax : PEFormulaSyntax): Bool;  stdcall;

{Use this API to set the syntax to use in the next (and all successive)}
{formula API call(s).}
{For running total condition formula,                    }
{ formulaSyntax[0] is the syntax for the evalFormula and }
{ formulaSyntax[1] is the syntax for the reset formula.  }
{***Default Behaviour: If any Formula API is called before calling}
{                      PESetFormulaSyntax then PE_FST_CRYSTAL is assumed.}
  TPESetFormulaSyntax = function (
    printJob          : Smallint;
    var formulaSyntax : PEFormulaSyntax): Bool;  stdcall;

{******************************************************************************}
{ Report Alerts                                                                }
{******************************************************************************}
type
  PEReportAlertInfo = record
    StructSize                : Word;  	  {initialize to PE_SIZEOF_REPORT_ALERT_INFO}
    nameLength                : Smallint;
    name                      : HWND;     {Must Release HANDLES even if not using them}
    isEnabled                 : Smallint; {True if alert is enabled, else false}
    alertConditionLength      : Smallint;
    alertConditionFormula     : HWND;
    nTriggeredInstances       : DWord;
    alertMessageLength        : SmallInt; {for alertMessageFormula}
    defaultAlertMessageLength : SmallInt;
    alertMessageFormula       : HWND;
    defaultAlertMessage       : HWND;
   	alertConditionFormulaSyntax : SmallInt; {PE_FST_}
  	alertMessageFormulaSyntax   : SmallInt; {PE_FST_}
    fromMainDocument            : SmallInt;
    alertReportNameLength       : SmallInt;
    alertReportName             : HWND;
  end;

const
  PE_SIZEOF_REPORT_ALERT_INFO = SizeOf (PEReportAlertInfo);

type
  PEAlertInstanceInfo = record
    StructSize         : Word;  {initialize to PE_SIZEOF_ALERT_INSTANCE_INFO}
    alertMessageLength : Smallint;
    alertMessage       : HWND;
  end;

const
  PE_SIZEOF_ALERT_INSTANCE_INFO = SizeOf (PEAlertInstanceInfo);

type
  TPEGetNReportAlerts = function (printJob: Smallint): Smallint; stdcall;

  TPEGetNthReportAlert = function (
    printJob            : Smallint;
    alertN              : Smallint;
    var reportAlertInfo : PEReportAlertInfo): Bool; stdcall;

  TPEGetNthAlertInstanceInfo = function (
    printJob              : Smallint;
    alertN                : Smallint;
    instanceN             : DWord;
    var alertInstanceInfo : PEAlertInstanceInfo): Bool; stdcall;

  TPESetNthAlertConditionFormula = function (
    printJob    : Smallint;
    alertN      : Smallint;
    var formula : PChar): Bool; stdcall;

  TPESetNthAlertMessageFormula = function (
    printJob    : Smallint;
    alertN      : Smallint;
    var formula : PChar): Bool; stdcall;

  TPESetNthAlertDefaultMessage = function (
    printJob : Smallint;
    alertN   : Smallint;
    var text : PChar): Bool; stdcall;

  TPEEnableNthAlert = function (
    printJob : Smallint;
    alertN   : Smallint;
    enabled  : Bool): Bool; stdcall;

{******************************************************************************}
{ ByName functions                                                             }
{  - Getting report object, section and area by object name                    }
{******************************************************************************}
type
  TPEGetObjectByName = function (
    printJob : Smallint;
    name     : PChar): DWORD; stdcall;

  TPEGetObjectName = function (
    printJob             : Smallint;
    objectHandle         : DWord;
    var objectNameHandle : HWnd;
    var objectNameLength : Smallint): Bool; stdcall;

  TPEGetSectionByName = function (
    printJob : Smallint;
    name     : PChar): Smallint; stdcall;

  TPEGetAreaByName = function (
    printJob : Smallint;
    name     : PChar): Smallint; stdcall;

  TPEGetAreaName = function (
    printJob       : Smallint;
    areaCode       : Smallint;
    var nameHandle : HWnd;
    var nameLength : Smallint): Bool; stdcall;

{******************************************************************************}
{ SetTempFilePath                                                              }
{******************************************************************************}
type
  TPESetTempFilePath = procedure (Path : PChar); stdcall;

{******************************************************************************}
{ GroupName Formula                                                            }
{******************************************************************************}
type
  TPEGetNthGroupNameFormula = function (
    printJob       : Smallint;
    groupN         : Smallint;
    var textHandle : HWnd;
    var textLength : Smallint): Bool; stdcall;

  TPESetNthGroupNameFormula = function (
    printJob       : Smallint;
    groupN         : Smallint;
    fString        : PChar): Bool; stdcall;

{******************************************************************************}

const
  CRD_ERROR_LOADING     = 'Error loading library: CRPE32.DLL';
  CRD_ERROR_FREEING     = 'Error freeing library: CRPE32.DLL';
  CRD_ENGINE_NOT_LOADED = 'CRPE32.DLL is not loaded';
  CRD_ERROR_LOADING_FUNCTION = 'Error loading function: ';

type
  TCrpeEngine = class
  private
    procedure CRDEngineError(const sMessage: string);
  public
    function PELoadCrpeDll(const CrpeLocation: string) : Bool;
    function PEUnloadCrpeDll : Bool;
    function PEOpenEngine : Bool;
    function PEOpenEngineEx (var EngineOptions: PEEngineOptions): Bool;
    procedure PECloseEngine;
    function PECanCloseEngine : Bool;
    function PEOpenPrintJob (reportFilePath : PChar): Smallint;
    function PEClosePrintJob (printJob : Smallint): Bool;
    function PESavePrintJob (
      printJob       : Smallint;
      reportFilePath : PChar): Bool;
    function PESavePrintJobAs (
      printJob       : Smallint;
      reportFilePath : PChar;
      saveAsFormat   : LongInt; { a PE_SAVEAS_FORMAT_* }
      reserved       : Pointer  { ignored }
      ): Bool;
    function PEStartPrintJob (
      printJob      : Smallint;
      waitUntilDone : Bool): Bool;
    procedure PECancelPrintJob (printJob : Smallint);
    procedure PESetRefreshData (printJob : Smallint; bUnknown: Bool);
    function PEIsPrintJobFinished (printJob : Smallint): Bool;
    function PEGetJobStatus (
      printJob    : Smallint;
      var jobInfo : PEJobInfo): Smallint;
    function PESetTimeLimit (
      printJob  : Smallint;
      timeLimit : LongInt  {in Seconds}
    ): Bool;
    function PEGetPercentCompleted (printJob : Smallint): LongInt;
    function PESetReadRecordLimit (
      printJob     : Smallint;
      recordsLimit : Longint): Bool;
    function PEGetReadPercentCompleted (printJob: Smallint): LongInt;
    function PEIsJobPremature (printJob: Smallint): Bool;
    function PEGetStartPageNumber (
      printJob  : Smallint;
      var pageN : Longint): Bool;
    function PESetStartPageNumber (
      printJob : Smallint;
      pageN    : Longint): Bool;
    function PEGetVersion (versionRequested : Smallint): Smallint;
    function PEGetErrorCode (printJob : Smallint): Smallint;
    function PEGetErrorText (
      printJob       : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PEGetHandleString (
      textHandle   : HWnd;
      buffer       : PChar;
      bufferLength : Smallint): Bool;

    function PEGetStringHandle (
      const inStr      : PChar;
      var outStrHandle : HWnd;
      var outStrLength : DWord): Bool;

    function PEGetStringHandleExW (
      const inStr      : PWChar;
      var outStrHandle : HWnd;
      var outStrLength : DWord): Bool;
    function PEPrintReport (
      reportFilePath    : PChar;
      toDefaultPrinter,
      toWindow          : Bool;
      title             : PChar;
      left,
      top,
      width,
      height            : integer;
      style             : DWord;
      parentWindow      : Hwnd): Smallint;
    function PEGetReportVersion (
      printJob          : Smallint;
      var VersionInfo : PEVersionInfo): Bool;
    function PEGetReportOptions (
      printJob          : Smallint;
      var reportOptions : PEReportOptions): Bool;
    function PESetReportOptions (
      printJob          : Smallint;
      var reportOptions : PEReportOptions): Bool;
    function PESetGlobalOptions (var globalOptions: PEGlobalOptions): Bool;
    function PEOpenSubreport (
      parentJob     : Smallint;
      subreportName : PChar): Smallint;
    function PECloseSubreport (printJob : Smallint): Bool;
    function PEGetNSubreportsInSection (
      printJob    : Smallint;
      sectionCode : Smallint): Smallint;
    function PEGetNthSubreportInSection (
      printJob    : Smallint;
      sectionCode : Smallint;
      subreportN  : Smallint): DWord;
    function PEGetSubreportInfo (
      printJob          : Smallint;
      subreportHandle   : DWord;
      var subreportInfo : PESubreportInfo): Bool;
    function PESetDialogParentWindow (
      printJob     : Smallint;
      parentWindow : HWnd): Bool;
    function PEEnableProgressDialog (
      printJob : Smallint;
      enable   : Bool): Bool;
    function PEGetAllowPromptDialog (printJob : Smallint): Bool;
    function PESetAllowPromptDialog (
      printJob         : Smallint;
      showPromptDialog : Bool): Bool;
    function PEGetPrintDate (
      printJob  : Smallint;
      var year  : Smallint;
      var month : Smallint;
      var day   : Smallint): Bool;
    function PESetPrintDate (
      printJob : Smallint;
      year     : Smallint;
      month    : Smallint;
      day      : Smallint): Bool;
    function PEGetNGroups (printJob : Smallint): Smallint;
    function PEGetGroupCondition (
      printJob                 : Smallint;
      sectionCode              : Smallint;
      var conditionFieldHandle : Hwnd;
      var conditionFieldLength : Smallint;
      var condition            : Smallint;
      var sortDirection        : Smallint): Bool;
    function PESetGroupCondition (
      printJob       : Smallint;
      sectionCode    : Smallint;
      conditionField : PChar;
      condition      : Smallint; {a PE_GC_ constant}
      sortDirection  : Smallint  {a PE_SF_ constant}): Bool;
    function PESwapGroups (
      printJob     : Smallint;
      sourceGroupN : Smallint;
      targetGroupN : Smallint): Bool;
    function PEGetGroupOptions (
      printJob         : Smallint;
      groupN           : Smallint;
      var groupOptions : PEGroupOptions): Bool;
    function PESetGroupOptions (
      printJob         : Smallint;
      groupN           : Smallint;
      var groupOptions : PEGroupOptions): Bool;
    function PEGetNSections (printJob: Smallint): Smallint;
    function PEGetNSectionsInArea (
      printJob : Smallint;
      areaCode : Smallint): Smallint;
    function PEGetSectionCode (
      printJob : Smallint;
      sectionN : Smallint): Smallint;
    function PEGetMinimumSectionHeight (
      printJob          : Smallint;
      sectionCode       : Smallint;
      var minimumHeight : Smallint): Bool;
    function PESetMinimumSectionHeight (
      printJob : Smallint;
      sectionCode : smallint;
      minimumHeight : smallint) : Bool;
    function PEGetSectionHeight (
      printJob :		Smallint;
      sectionCode : 	Smallint;
      var Height :	Smallint): Bool;
    function PESetSectionHeight (
      printJob    : Smallint;
      sectionCode : Smallint;
      Height      : Smallint): Bool;
    function PEGetSectionWidth (
      printJob    : Smallint;
      sectionCode : Smallint;
      var width   : Smallint {twips}): Bool;
    function PEGetSectionFormat (
      printJob    : Smallint;
      sectionCode : Smallint;
      var options : PESectionOptions): Bool;
    function PESetSectionFormat (
      printJob    : Smallint;
      sectionCode : Smallint;
      var options : PESectionOptions): Bool;
    function PEGetAreaFormat (
      printJob    : Smallint;
      areaCode    : Smallint;
      var options : PESectionOptions): Bool;
    function PESetAreaFormat (
      printJob    : Smallint;
      areaCode    : Smallint;
      var options : PESectionOptions): Bool;
    function PESetFont (
      printJob     : Smallint;
      sectionCode  : Smallint;
      scopeCode    : smallint;
      faceName     : PChar;    { 0 for no change               }
      fontFamily   : Smallint; { FF_DONTCARE for no change     }
      fontPitch    : Smallint; { DEFAULT_PITCH for no change   }
      charSet      : Smallint; { DEFAULT_CHARSET for no change }
      pointSize    : Smallint; { 0 for no change               }
      isItalic     : Smallint; { PE_UNCHANGED for no change    }
      isUnderlined : Smallint; { PE_UNCHANGED for no change    }
      isStruckOut  : Smallint; { PE_UNCHANGED for no change    }
      weight       : Smallint  { 0 for no change }): Bool;
    function PEGetGraphTypeInfo (
      printJob          : Smallint;
      sectionN          : Smallint;
      graphN            : Smallint;
      var graphTypeInfo : PEGraphTypeInfo): Bool;
    function PESetGraphTypeInfo (
      printJob          : Smallint;
      sectionN          : Smallint;
      graphN            : Smallint;
      var graphTypeInfo : PEGraphTypeInfo): Bool;
    function PEGetGraphTextInfo (
      printJob        : Smallint;
      sectionN        : Smallint;
      graphN          : Smallint;
      titleType       : Word;     { PE_GTT_ constant }
      var title       : Hwnd;
      var titleLength : Smallint): Bool;
    function PESetGraphTextInfo (
      printJob  : Smallint;
      sectionN  : Smallint;
      graphN    : Smallint;
      titleType : Word;     { PE_GTT_ constant }
      title     : PChar): Bool;
    function PEGetGraphFontInfo (
      printJob           : Smallint;
      sectionN           : Smallint;
      graphN             : Smallint;
      titleFontType      : Word;  { PE_GTF_ constant }
      var fontColorInfo  : PEFontColorInfo): Bool;
    function PESetGraphFontInfo (
      printJob           : Smallint;
      sectionN           : Smallint;
      graphN             : Smallint;
      titleFontType      : Word; { PE_GTF_ constant }
      var fontColorInfo  : PEFontColorInfo): Bool;
    function PEGetGraphOptionInfo (
      printJob            : Smallint;
      sectionN            : Smallint;
      graphN              : Smallint;
      var graphOptionInfo : PEGraphOptionInfo): Bool;
    function PESetGraphOptionInfo (
      printJob            : Smallint;
      sectionN            : Smallint;
      graphN              : Smallint;
      var graphOptionInfo : PEGraphOptionInfo): Bool;
    function PEGetGraphAxisInfo (
      printJob          : Smallint;
      sectionN          : Smallint;
      graphN            : Smallint;
      var graphAxisInfo : PEGraphAxisInfo): Bool;
    function PESetGraphAxisInfo (
      printJob          : Smallint;
      sectionN          : Smallint;
      graphN            : Smallint;
      var graphAxisInfo : PEGraphAxisInfo): Bool;
    function PEGetNFormulas (printJob : Smallint): Smallint;
    function PEGetNthFormula (
      printJob       : Smallint;
      formulaN       : Smallint;
      var nameHandle : Hwnd;
      var nameLength : Smallint;
      var textHandle : Hwnd;
      var textLength : Smallint): Bool;
    function PEGetFormula (
      printJob       : Smallint;
      formulaName    : PChar;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetFormula (
      printJob      : Smallint;
      formulaName   : PChar;
      formulaString : PChar): Bool;
    function PECheckFormula (
      printJob    : Smallint;
      formulaName : PChar): Bool;
    function PEGetSelectionFormula (
      printJob       : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetSelectionFormula (
      printJob      : Smallint;
      formulaString : PChar): Bool;
    function PECheckSelectionFormula (printJob : Smallint): Bool;
    function PEGetGroupSelectionFormula (
      printJob       : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetGroupSelectionFormula (
      printJob      : Smallint;
      formulaString : PChar): Bool;
    function PECheckGroupSelectionFormula (printJob : Smallint): Bool;
    function PEGetSectionFormatFormula (
      printJob       : Smallint;
      sectionCode    : Smallint;
      formulaName    : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetSectionFormatFormula (
      printJob      : Smallint;
      sectionCode   : Smallint;
      formulaName   : Smallint;
      formulaString : PChar): Bool;
    function PEGetAreaFormatFormula (
      printJob       : Smallint;
      areaCode       : Smallint;
      formulaName    : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetAreaFormatFormula (
      printJob      : Smallint;
      areaCode      : Smallint;
      formulaName   : Smallint;
      formulaString : PChar): Bool;
    function PEGetNSQLExpressions (printJob: Smallint): Smallint;
    function PEGetNthSQLExpression (
      printJob       : Smallint;
      expressionN    : Smallint;
      var nameHandle : Hwnd;
      var nameLength : Smallint;
      var textHandle : Hwnd;
      var textLength : Smallint): Bool;
    function PEGetSQLExpression (
      printJob             : Smallint;
      const expressionName : PChar;
      var textHandle       : Hwnd;
      var textLength       : Smallint): Bool;
    function PESetSQLExpression (
      printJob               : Smallint;
      const expressionName   : PChar;
      const expressionString : PChar): Bool;
    function PECheckSQLExpression (
      printJob             : Smallint;
      const expressionName : PChar): Bool;
    function PEGetNParameterFields (printJob: Smallint): Smallint;
    function PEGetNthParameterField (
      printJob          : Smallint;
      parameterN        : Smallint;
      var parameterInfo : PEParameterFieldInfo): Bool;
    function PESetNthParameterField (
      printJob          : Smallint;
      parameterN        : Smallint;
      var parameterInfo : PEParameterFieldInfo): Bool;
    function PEConvertPFInfoToVInfo (
      value         : PChar;
      valueType     : Smallint;
      var valueInfo : PEValueInfo): Bool;
    function PEConvertVInfoToPFInfo (
      var valueInfo : PEValueInfo;
      var valueType : Word;
      value         : PChar): Bool;
    function PEGetNParameterDefaultValues (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar): Smallint;
    function PEGetNthParameterDefaultValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      index                    : Smallint;
      var valueInfo            : PEValueInfo): Bool;
    function PESetNthParameterDefaultValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      index                    : Smallint;
      var valueInfo            : PEValueInfo): Bool;
    function PEAddParameterDefaultValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var valueInfo            : PEValueInfo): Bool;
    function PEDeleteNthParameterDefaultValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      index                    : Smallint): Bool;
    function PEGetParameterMinMaxValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var valueMin             : PEValueInfo;
      { Set to NULL to retrieve MAX only; must be non-NULL if valueMax is NULL }
      var valueMax             : PEValueInfo): Bool;
      { Set to NULL to retrieve MIN only; must be non-NULL if valueMin is NULL }
    function PESetParameterMinMaxValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var valueMin             : PEValueInfo;
      { Set to NULL to retrieve MAX only; must be non-NULL if valueMax is NULL }
      var valueMax             : PEValueInfo): Bool;
      { Set to NULL to retrieve MIN only; must be non-NULL if valueMin is NULL }
      { If both valueInfo and valueMax are non-NULL then }
      { valueMin.valueType MUST BE THE SAME AS valueMax.valueType. }
      { If different, PE_ERR_INCONSISTANTTYPES is returned. }
    function PEGetNthParameterValueDescription (
      printJob            : Smallint;
      parameterFieldName  : PChar;
      reportName          : PChar;
      index               : Smallint;
      var valueDesc       : HWnd;
      var valueDescLength : Smallint): Bool;
    function PESetNthParameterValueDescription (
      printJob            : Smallint;
      parameterFieldName  : PChar;
      reportName          : PChar;
      index               : Smallint;
      valueDesc           : PChar): Bool;
    function PEGetParameterPickListOption (
      printJob           : Smallint;
      parameterFieldName : PChar;
      reportName         : PChar;
      var pickListOption : PEParameterPickListOption): Bool;
    function PESetParameterPickListOption (
      printJob           : Smallint;
      parameterFieldName : PChar;
      reportName         : PChar;
      var pickListOption : PEParameterPickListOption): Bool;
    function PEGetParameterValueInfo (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var valueInfo            : PEParameterValueInfo): Bool;
    function PESetParameterValueInfo (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var valueInfo            : PEParameterValueInfo): Bool;
    function PEGetNParameterCurrentValues (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar): Smallint;
    function PEGetNthParameterCurrentValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      index                    : Smallint;
      var currentValue         : PEValueInfo): Bool;
    function PEAddParameterCurrentValue (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var currentValue         : PEValueInfo): Bool;

    function PEAddParameterCurrentValueW (
      printJob                 : Smallint;
      const parameterFieldName : PWChar;
      const reportName         : PWChar;
      var currentValue         : PEValueInfoW): Bool;

    function PEGetNParameterCurrentRanges (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar): Smallint;
    function PEGetNthParameterCurrentRange (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      index                    : Smallint;
      var rangeStart           : PEValueInfo;
      var rangeEnd             : PEValueInfo;
      var rangeInfo            : Smallint): Bool;
    function PEAddParameterCurrentRange (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar;
      var rangeStart           : PEValueInfo;
      var rangeEnd             : PEValueInfo;
      rangeInfo                : Smallint): Bool;
    function PEAddParameterCurrentRangeW (
      printJob                 : Smallint;
      const parameterFieldName : PWChar;
      const reportName         : PWChar;
      var rangeStart           : PEValueInfoW;
      var rangeEnd             : PEValueInfoW;
      rangeInfo                : Smallint): Bool;
    function PEClearParameterCurrentValuesAndRanges (
      printJob                 : Smallint;
      const parameterFieldName : PChar;
      const reportName         : PChar): Bool;
    function PEGetNthParameterType (
      printJob : Smallint;
      index    : Smallint): Smallint;
    function PEGetNSortFields (printJob: Smallint): Smallint;
    function PEGetNthSortField (
      printJob       : Smallint;
      sortFieldN     : Smallint;
      var nameHandle : HWnd;
      var nameLength : Smallint;
      var direction  : Smallint): Bool;
    function PESetNthSortField (
      printJob   : Smallint;
      sortFieldN : Smallint;
      Name       : PChar;
      direction  : Smallint): Bool;
    function PEDeleteNthSortField (
      printJob   : Smallint;
      sortFieldN : Smallint): Bool;
    function PEGetNGroupSortFields (printJob : Smallint): Smallint;
    function PEGetNthGroupSortField (
      printJob       : Smallint;
      sortFieldN     : Smallint;
      var nameHandle : HWnd;
      var nameLength : Smallint;
      var direction  : Smallint): Bool;
    function PESetNthGroupSortField (
      printJob   : Smallint;
      sortFieldN : Smallint;
      Name       : PChar;
      direction  : Smallint): Bool;
    function PEDeleteNthGroupSortField (
      printJob   : Smallint;
      sortFieldN : Smallint): Bool;
    function PEGetNTables (printJob: Smallint): Smallint;
    function PEGetNthTableType (
      printJob      : Smallint;
      tableN        : Smallint;
      var tableType : PETableType): Bool;
    function PEGetNthTableSessionInfo (
      printJob        : Smallint;
      tableN          : Smallint;
      var sessionInfo : PESessionInfo): Bool;
    function PESetNthTableSessionInfo (
      printJob              : Smallint;
      tableN                : Smallint;
      var sessionInfo       : PESessionInfo;
      propagateAcrossTables : Bool): Bool;
    function PEGetNthTableLogOnInfo (
      printJob      : Smallint;
      tableN        : Smallint;
      var logOnInfo : PELogOnInfo): Bool;
    function PESetNthTableLogOnInfo (
      printJob              : Smallint;
      tableN                : Smallint;
      var logOnInfo         : PELogOnInfo;
      propagateAcrossTables : Bool): Bool;
    function PEGetNthTableLocation (
      printJob     : Smallint;
      tableN       : Smallint;
      var location : PETableLocation): Bool;
    function PESetNthTableLocation (
      printJob     : Smallint;
      tableN       : Smallint;
      var location : PETableLocation): Bool;
    function PEGetNthTablePrivateInfo (
      printJob        : Smallint;
      tableN          : Smallint;
      var privateInfo : PETablePrivateInfo): Bool;
    function PESetNthTablePrivateInfo (
      printJob        : Smallint;
      tableN          : Smallint;
      var privateInfo : PETablePrivateInfo): Bool;
    function PETestNthTableConnectivity (
      printJob : Smallint;
      tableN   : Smallint): Bool;
    function PELogOnServer (
      dllName       : PChar;
      var logOnInfo : PELogOnInfo): Bool;
    function PELogOffServer (
      dllName       : PChar;
      var logOnInfo : PELogOnInfo): Bool;
    function PELogOnSQLServerWithPrivateInfo (
      dllName     : PChar;
      privateInfo : Pointer): Bool;
    function PEVerifyDatabase (printJob : Smallint): Bool;
    function PECheckNthTableDifferences (
      printJob                : Smallint;
      tableN                  : Smallint;
      var tableDifferenceInfo : PETableDifferenceInfo): Bool;
    function PEGetSQLQuery (
      printJob       : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetSQLQuery (
      printJob    : Smallint;
      queryString : PChar): Bool;
    function PEDiscardSavedData (printJob : Smallint): Bool;
    function PEHasSavedData (
      printJob         : Smallint;
      var hasSavedData : Bool): Bool;
    function PEGetReportTitle (
      printJob        : Smallint;
      var titleHandle : HWnd;
      var titleLength : Smallint): Bool;
    function PESetReportTitle (
      printJob : Smallint;
      title    : PChar): Bool;
    function PEOutputToWindow (
      printJob     : Smallint;
      title        : PChar;
      left         : DWord;
      top          : DWord;
      width        : DWord;
      height       : DWord;
      style        : DWord;
      parentWindow : HWnd): Bool;
    function PEGetWindowHandle (printJob: Smallint): HWnd;
    procedure PECloseWindow (printJob: Smallint);
    function PEGetWindowOptions (
      printJob    : Smallint;
      var options : PEWindowOptions): Bool;
    function PESetWindowOptions (
      printJob    : Smallint;
      var options : PEWindowOptions): Bool;
    function PEShowPrintControls (
      printJob          : Smallint;
      showPrintControls : Bool): Bool;
    function PEPrintControlsShowing (
      printJob            : Smallint;
      var controlsShowing : Bool): Bool;
    function PEShowFirstPage (printJob: Smallint): Bool;
    function PEShowNextPage (printJob: Smallint): Bool;
    function PEShowPreviousPage (printJob: Smallint): Bool;
    function PEShowLastPage (printJob: Smallint): Bool;
    function PEGetNPages (printJob: Smallint): Smallint;
    function PEShowNthPage (
      printJob : Smallint;
      pageN    : Smallint): Bool;
    function PEZoomPreviewWindow (
      printJob : Smallint;
      level    : Smallint): Bool;
      {level: a percent from 25 to 400 or a PE_ZOOM_ constant}
    function PENextPrintWindowMagnification (printJob:  Smallint): Bool;
    function PEPrintWindow (
      printJob      : Smallint;
      waitUntilDone : Bool): Bool;
    function PEExportPrintWindow (
      printJob      : Smallint;
      toMail        : Bool;
      waitUntilDone : Bool): Bool;
    function PEOutputToPrinter (
      printJob : Smallint;
      nCopies  : Smallint): Bool;
    function PESelectPrinter (
      printJob    : Smallint;
      driverName  : PChar;
      printerName : PChar;
      portName    : PChar;
      mode        : PDevMode): Bool;
    function PESelectPrinterW (
      printJob    : Smallint;
      driverName  : PWChar;
      printerName : PWChar;
      portName    : PWChar;
      mode        : PDeviceModeW): Bool;
    function PEGetSelectedPrinter (
      printJob          : Smallint;
      var driverHandle  : Hwnd;
      var driverLength  : Smallint;
      var printerHandle : Hwnd;
      var printerLength : Smallint;
      var portHandle    : Hwnd;
      var portLength    : Smallint;
      var mode          : PDevMode): Bool;
    function PEGetNDetailCopies (
      printJob     : Smallint;
      var nCopies  : Smallint): Bool;
    function PESetNDetailCopies (
      printJob     : Smallint;
      nCopies      : Smallint): Bool;
    function PEGetPrintOptions (
      printJob    : Smallint;
      var options : PEPrintOptions):Bool;
    function PESetPrintOptions (
      printJob    : Smallint;
      var options : PEPrintOptions): Bool;
    function PEGetExportOptions (
      printJob    : Smallint;
      var options : PEExportOptions): Bool;
    function PEGetExportOptionsW (
      printJob    : Smallint;
      var options : PEExportOptionsW): Bool;
    function PEExportTo (
      printJob    : Smallint;
      var options : PEExportOptions): Bool;
    function PEGetMargins (
      printJob   : Smallint;
      var left   : Word;
      var right  : Word;
      var top    : Word;
      var bottom : Word): Bool;
    function PESetMargins (
      printJob : Smallint;
      left     : Word;
      right    : Word;
      top      : Word;
      bottom   : Word): Bool;
    function PEGetReportSummaryInfo (
      printJob        : Smallint;
      var summaryInfo : PEReportSummaryInfo): Bool;
    function PESetReportSummaryInfo (
      printJob        : Smallint;
      var summaryInfo : PEReportSummaryInfo): Bool;
    function PEEnableEvent (
      printJob            : Smallint;
      var enableEventInfo : PEEnableEventInfo): Bool;
    function PEGetEnableEventInfo (
      printJob            : Smallint;
      var enableEventInfo : PEEnableEventInfo): Bool;
    function PESetEventCallback (
      printJob     : Smallint;
      callbackProc : Pointer;
      userData     : Pointer): Bool;
    function PEGetFieldMappingType (
      printJob        : Smallint;
      var mappingType : Word): Bool;
    function PESetFieldMappingType (
      printJob    : Smallint;
      mappingType : Word): Bool;
    function PEGetTrackCursorInfo (
      printJob       : Smallint;
      var cursorInfo : PETrackCursorInfo): Bool;
    function PESetTrackCursorInfo (
      printJob       : Smallint;
      var cursorInfo : PETrackCursorInfo): Bool;
    function PEGetNObjectsInSection (
      printJob    : Smallint;
      sectionCode : Smallint): Smallint;
    function PEGetNthObjectInSection (
      printJob    : Smallint;
      sectionCode : Smallint;
      objectN     : Smallint): DWord;
    function PEGetObjectFormat (
      printJob         : Smallint;
      objectHandle     : DWord;
      objectFormatName : Smallint;  {a PE_OFN constant}
      var valueInfo    : PEValueInfo): Bool;
    function PESetObjectFormat (
      printJob         : Smallint;
      objectHandle     : DWord;
      objectFormatName : Smallint;  {a PE_OFN constant}
      var valueInfo    : PEValueInfo): Bool;
    function PEGetObjectInfo (
      printJob       : Smallint;
      objectHandle   : DWord;
      var objectInfo : PEObjectInfo): Bool;
    function PESetObjectInfo (
      printJob       : Smallint;
      objectHandle   : DWord;
      var objectInfo : PEObjectInfo): Bool;
    function PEGetOleObjectInfo (
      printJob          : Smallint;
      objectHandle      : DWord;
      var oleObjectInfo : PEOleObjectInfo): Bool;
    function PEGetObjectFontColor (
      printJob          : Smallint;
      objectHandle      : DWord;
      var fontColorInfo : PEFontColorInfo): Bool;
    function PESetObjectFontColor (
      printJob          : Smallint;
      objectHandle      : DWord;
      var fontColorInfo : PEFontColorInfo): Bool;
    function PEChangeSummaryType (
      printJob            : Smallint;
      summarizedFieldName : PChar;
      groupN              : Smallint; {-1 for Grand Total}
      oldSummaryType      : Smallint; {PE_ST Constant}
      newSummaryType      : Smallint  {PE_ST Constant}
    ): DWord;
    function PEGetFieldObjectInfo (
      printJob            : Smallint;
      fieldObjectHandle   : DWord;
      var fieldObjectInfo : PEFieldObjectInfo): Bool;
    function PEGetNParagraphs (
      printJob         : Smallint;
      textObjectHandle : DWord): Smallint; {returns -1 if failed}
    function PEGetNthParagraphInfo (
      printJob          : Smallint;
      textObjectHandle  : DWord;
      paragraphN        : Smallint;
      var paragraphInfo : PEParagraphInfo): Bool;
    function PESetNthParagraphInfo (
      printJob          : Smallint;
      textObjectHandle  : DWord;
      paragraphN        : Smallint;
      var paragraphInfo : PEParagraphInfo): Bool;
    function PEGetNTabStopsInParagraph (
      printJob         : Smallint;
      textObjectHandle : DWord;
      paragraphN       : Smallint): Smallint;
    function PEGetNthTabStopInfo (
      printJob         : Smallint;
      textObjectHandle : DWord;
      paragraphN       : Smallint;
      tabStopN         : Smallint; {start from 0}
      var tabStopInfo  : PETabStopInfo): Bool;
    function PESetNthTabStopInfo (
      printJob         : Smallint;
      textObjectHandle : DWord;
      paragraphN       : Smallint;
      tabStopN         : Smallint; {start from 0}
      var tabStopInfo  : PETabStopInfo): Bool;
    function PEAddTabStop (
      printJob         : Smallint;
      textObjectHandle : DWord;
      paragraphN       : Smallint;
      var tabStopInfo  : PETabStopInfo): Bool;
    function PEDeleteNthTabStop (
      printJob         : Smallint;
      textObjectHandle : DWord;
      paragraphN       : Smallint;
      tabStopN         : Smallint): Bool;
    function PEGetNEmbeddedFields (
      printJob         : Smallint;
      textObjectHandle : DWord): Smallint;
    function PEGetNthEmbeddedFieldInfo (
      printJob              : Smallint;
      textObjectHandle      : DWord;
      embeddedFieldN        : Smallint;
      var embeddedFieldInfo : PEEmbeddedFieldInfo): Bool;
    function PEGetNthEmbeddedFieldFormat (
      printJob         : Smallint;
      textObjectHandle : DWord;
      embeddedFieldN   : Smallint;
      objectFormatName : Smallint; {a PE_OFN_ constant}
      var valueInfo    : PEValueInfo): Bool;
    function PESetNthEmbeddedFieldFormat (
      printJob         : Smallint;
      textObjectHandle : DWord;
      embeddedFieldN   : Smallint;
      objectFormatName : Smallint; {a PE_OFN_ constant}
      var valueInfo    : PEValueInfo): Bool;
    function PEGetNthEmbeddedFieldFormatFormula (
      printJob         : Smallint;
      textObjectHandle : DWord;
      embeddedFieldN   : Smallint;
      formulaName      : Smallint; {a field PE_FFN_ constant}
      var textHandle   : HWnd;
      var textLength   : Smallint): Bool;
    function PESetNthEmbeddedFieldFormatFormula (
      printJob         : Smallint;
      textObjectHandle : DWord;
      embeddedFieldN   : Smallint;
      formulaName      : Smallint; {a field PE_FFN_ constant}
      formulaString    : PChar): Bool;
    function PEDeleteNthEmbeddedField (
      printJob         : Smallint;
      textObjectHandle : DWord;
      embeddedFieldN   : Smallint): Bool;
    function PEInsertEmbeddedField (
      printJob         : Smallint;
      textObjectHandle : DWord;
      position         : LongInt;
      fieldName        : PChar {formula form}
    ): Bool;
    function PEGetTextFontColor (
      printJob          : Smallint;
      textObjectHandle  : DWord;
      position          : LongInt;
      var fontColorInfo : PEFontColorInfo): Bool;
    function PESetTextFontColor (
      printJob          : Smallint;
      textObjectHandle  : DWord;
      startPosition     : LongInt;
      endPosition       : LongInt;
      var fontColorInfo : PEFontColorInfo): Bool;
    function PEGetTextSize (
      printJob          : Smallint;
      textObjectHandle  : DWord): LongInt;
    function PEGetTextHeight (
      printJob         : Smallint;
      textObjectHandle : DWord): LongInt;
    {return in Twips}
    function PEGetText (
      printJob         : Smallint;
      textObjectHandle : DWord;
      var textHandle   : HWnd;
      var textLength   : Smallint): Bool;
    function PEInsertText (
      printJob         : Smallint;
      textObjectHandle : DWord;
      position         : LongInt;
      text             : PChar): Bool;
    function PEDeleteText (
      printJob         : Smallint;
      textObjectHandle : DWord;
      startText        : LongInt;
      endText          : LongInt): Bool;
    function PEInsertTextEx (
      printJob           : Smallint;
      var insertTextInfo : PEInsertTextInfo): Bool;
    function PEGetNthSubreportLink (
      printJob                  : Smallint;
      subreportHandle           : DWord;
      subreportLinkN            : Smallint; {start from 0}
      mainReportFieldNameHandle : HWnd;     {formula form}
      mainReportFieldNameLength : Smallint;
      promptVarFieldNameHandle  : HWnd;     {formula form}
      promptVarFieldNameLength  : Smallint): Bool;
    function PEGetNthSubreportLinkEx (
      printJob              : Smallint;
      subreportHandle       : DWord;
      subreportLinkN        : Smallint; {start from 0}
      var subreportLinkInfo : PESubreportLinkInfo): Bool;
    function PEReimportSubreport (
      printJob        : Smallint;
      subreportHandle : DWord;
      var linkChanged : Bool;
      var reimported  : Bool): Bool;
    function PEGetLineObjectInfo (
      printJob           : Smallint;
      lineObjectHandle   : DWord;
      var lineObjectInfo : PELineObjectInfo): Bool;
    function PESetLineObjectInfo (
      printJob           : Smallint;
      lineObjectHandle   : DWord;
      var lineObjectInfo : PELineObjectInfo): Bool;
    function PEGetBoxObjectInfo (
      printJob          : Smallint;
      boxObjectHandle   : DWord;
      var boxObjectInfo : PEBoxObjectInfo): Bool;
    function PESetBoxObjectInfo (
      printJob          : Smallint;
      boxObjectHandle   : DWord;
      var boxObjectInfo : PEBoxObjectInfo): Bool;
    function PEGetPictureFormatInfo (
      printJob              : Smallint;
      objectHandle          : DWord; {picture or blob field object}
      var pictureFormatInfo : PEPictureFormatInfo): Bool;
    function PESetPictureFormatInfo (
      printJob              : Smallint;
      objectHandle          : DWord; {picture or blob field object}
      var pictureFormatInfo : PEPictureFormatInfo): Bool;
    function PEGetCrossTabOptions (
      printJob            : Smallint;
      hObject             : DWord;
      var crossTabOptions : PECrossTabOptions): Bool;
    function PEGetNSummariesInCrossTabObject (
      printJob             : Smallint;
      crossTabObjectHandle : DWord): Smallint;
    function PEGetNthSummaryInfoInCrossTabObject (
      printJob             : Smallint;
      crossTabObjectHandle : DWord;
      summaryN             : Smallint;
      var summaryInfo      : PECrossTabSummaryFieldInfo): Bool;
    function PEGetNGroupsInCrossTabObject (
      printJob             : Smallint;
      crossTabObjectHandle : DWord;
      rowCol               : Smallint {a PE_CTRC_ constant}
    ): Smallint;
    function PEGetNthCrossTabGroupOptions (
      printJob                  : Smallint;
      crossTabObjectHandle      : DWord;
      rowCol                    : Smallint; {a PE_CTRC_ constant}
      rowColN                   : Smallint;
      var crossTabGroupOptions  : PECrossTabGroupOptions): Bool;
    function PEGetGraphNumber (
      printJob          : Smallint;
      graphObjectHandle : DWord;
      var sectionCode   : Smallint;
      var graphN        : Smallint): Bool;
    function PEGetGraphDataType (
      printJob              : Smallint;
      sectionCode           : Smallint;
      graphN                : Smallint;
      var graphDataTypeInfo : PEGraphDataTypeInfo): Bool;
    function PEGetObjectFormatFormula (
      printJob       : Smallint;
      objectHandle   : DWord;
      formulaName    : Smallint; {a object PE_FFN_ constant}
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetObjectFormatFormula (
      printJob       : Smallint;
      objectHandle   : DWord;
      formulaName    : Smallint; {a object PE_FFN_ constant}
      formulaString  : PChar): Bool;
    function PEGetParameterBrowseField (
      printJob           : Smallint;
      parameterFieldName : PChar;
      reportName         : PChar;
      var textHandle     : HWnd;     {Destination to hold result in}
      var textLength     : Smallint  {formula form Tablename.Fieldname}
    ): Bool;
    function PESetParameterBrowseField (
      printJob           : Smallint;
      parameterFieldName : PChar;
      reportName         : PChar;
      browseTableField   : PChar {Source fieldname. Must be in formula format or Table.FieldName}
    ): Bool;
    function PEGetNLogicalTables(printJob : Smallint): Smallint;
    function PEInsertSortField (
      printJob   : Smallint;
      sortFieldN : Smallint;
      name       : PChar;    {formula form}
      direction  : Smallint  {a PE_SF_ constant}
    ): Bool;
    function PESwapSortFields (
      printJob    : Smallint;
      sourceSortN : Smallint;
      targetSortN : Smallint): Bool;
    function PEGetNthTableAliasName (
      printJob       : Smallint;
      tableN         : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetNthTableAliasName (
      printJob       : Smallint;
      tableN         : Smallint;
      tableAliasName : PChar): Bool;
    function PESetNthTableServerType (
      printJob              : Smallint;
      tableN                : Smallint;
      var serverType        : PEServerTypeInfo;
      propagateAcrossTables : Bool): Bool;
    function PEGetNDatabaseFields (
      printJob : Smallint;
      tableN   : Smallint): Smallint;
    function PEGetNthDatabaseFieldInfo (
      printJob      : Smallint;
      tableN        : Smallint;
      fieldN        : Smallint;
      var fieldInfo : PEDatabaseFieldInfo): Bool;
    function PEGetNDatabaseLinks(printJob : Smallint): Smallint;
    function PEGetNthDatabaseLinkInfo (
      printJob             : Smallint;
      databaseLinkN        : Smallint;
      var databaseLinkInfo : PEDatabaseLinkInfo): Bool;
    function PESetDatabaseLinkInfo (
      printJob             : Smallint;
      var databaseLinkInfo : PEDatabaseLinkInfo): Bool;
    function PEConvertDatabaseDriver (
      printJob  : Smallint;
      toDllName : PChar;
      doConvert : Bool): Bool;
    function PEFreeDevMode (
      printJob : Smallint;
      pMode    : PDevMode): Bool;
    function PEGetDictionaryInfo (
      printJob     : Smallint;
      var dictInfo : PEDictionaryInfo): Bool;
    function PEGetDictionaryLocation (
      printJob         : Smallint;
      var dictLocation : PETableLocation): Bool;
    function PEGetDirectoryUserId (
      printJob       : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PEGetFieldDefinitionInfo (
      printJob                : Smallint;
      fieldName               : PChar; {formula form}
      var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;
    function PEGetFormulaFieldInfo (
      printJob                : Smallint;
      formula                 : PChar;
      var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;
    function PEGetSQLExpressionFieldInfo (
      printJob                : Smallint;
      expression              : PChar;
      var fieldDefinitionInfo : PEFieldDefinitionInfo): Bool;
    function PEGetNSummaryFields(printJob : Smallint): Smallint;
    function PEGetNthSummaryFieldInfo (
      printJob             : Smallint;
      summaryN             : Smallint;
      var summaryFieldInfo : PESummaryFieldInfo): Bool;
    function PEGetReportStyle(printJob : Smallint): Word;
    function PESetReportStyle (
      printJob : Smallint;
      style    : Word): Bool;
    function PEGetNOLAPCubes(printJob: Smallint): Smallint;
    function PEGetNthOLAPCubeLogOnInfo (
      printJob      : Smallint;
      cubeN         : Smallint;
      var logOnInfo : PEOLAPLogOnInfo): Bool;
    function PESetNthOLAPCubeLogOnInfo (
      printJob      : Smallint;
      cubeN         : Smallint;
      var logOnInfo : PEOLAPLogOnInfo): Bool;
    function PETestNthOlapCubeConnectivity (
      printJob : Smallint;
      cubeN    : Smallint): Bool;
    function PEGetGraphDataInfo (
      printJob          : Smallint;
      sectionN          : Smallint;
      graphN            : Smallint;
      var graphDataInfo : PENewGraphDataInfo): Bool;
    function PEGetNGraphConditionFields (
      printJob : Smallint;
      sectionN : Smallint;
      graphN   : Smallint): Smallint;
    function PEGetNthGraphConditionField (
      printJob            : Smallint;
      sectionN            : Smallint;
      graphN              : Smallint;
      condFieldN          : Smallint;
      var fieldNameHandle : HWnd;
      var fieldNameLength : Smallint): Bool;
    function PESetNthGraphConditionField (
      printJob   : Smallint;
      graphN     : Smallint;
      condFieldN : Smallint;
      fieldName  : PChar): Bool;
    function PEGetNGraphSummaryFields (
      printJob : Smallint;
      sectionN : Smallint;
      graphN   : Smallint): Smallint;
    function PEGetNthGraphSummaryFieldInfo (
      printJob             : Smallint;
      graphN               : Smallint;
      fieldN               : Smallint;
      var summaryFieldInfo : PEFieldDefinitionInfo): Bool;
    function PEGetGraphTextDefaultOption (
      printJob   : Smallint;
      sectionN   : Smallint;
      graphN     : Smallint;
      titleType  : Word; {a PE_GTT_ constant}
      var useDefault : Bool): Bool;
    function PESetGraphTextDefaultOption (
      printJob   : Smallint;
      sectionN   : Smallint;
      graphN     : Smallint;
      titleType  : Word; {a PE_GTT_ constant}
      useDefault : Bool): Bool;
    function PEGetObjectNHiliteConditions (
      printJob : Smallint;
      hObject  : DWord): Smallint;
    function PESetObjectNthHiliteCondition (
      printJob : Smallint;
      hObject  : DWord;
      nHilite  : Smallint;
      var hiliteInfo : PEObjectHiliteInfo): Bool;
    function PEGetObjectNthHiliteCondition (
      printJob : Smallint;
      hObject  : DWord;
      nHilite  : Smallint;
      var hiliteInfo : PEObjectHiliteInfo): Bool;
    function PEAddObjectHiliteCondition (
      printJob       : Smallint;
      hObject        : DWord;
      var hiliteInfo : PEObjectHiliteInfo): Bool;
    function PERemoveObjectNthHiliteCondition (
      printJob : Smallint;
      hObject  : DWord;
      nHilite  : Smallint): Bool;
    function PEClearObjectHiliteConditions (
      printJob : Smallint;
      hObject  : DWord): Bool;
    function PESetObjectNthHiliteConditionPriority (
      printJob    : Smallint;
      hObject     : DWord;
      nHilite     : Smallint;
      newPriority : Smallint): Bool;
    function PEGetNRunningTotals(printJob: Smallint): Smallint;
    {returns -1 if error}
    function PEGetNthRunningTotalName (
      printJob       : Smallint;
      runningtotalN  : Smallint;
      var nameHandle : HWnd;   {handle to string in formula form}
      var nameLength : Smallint): Bool;
    function PEGetRunningTotalInfo (
      printJob   : Smallint;
      rtName     : PChar;
      var rtInfo : PERunningTotalInfo): Bool;
    function PEGetRunningTotalConditionField (
      printJob        : Smallint;
      rtName          : PChar;
      var hEvalField  : HWnd;
      var evalLength  : Smallint;
      var hResetField : HWnd;
      var resetLength : Smallint): Bool;
    function PEGetRunningTotalConditionFormula (
      printJob          : Smallint;
      rtName            : PChar;
      var hEvalFormula  : HWnd;
      var evalLength    : Smallint;
      var hResetFormula : HWnd;
      var resetLength   : Smallint): Bool;
    function PEGetRunningTotalSummaryField (
      printJob             : Smallint;
      rtName               : PChar;
      var summaryFieldName : HWnd;
      var summaryLength    : Smallint;
      var secondFieldName  : HWnd;
      var secondLength     : Smallint): Bool;
    function PEGetMapDataInfo (
      printJob    : Smallint;
      hObject     : DWord;
      var mapInfo : PEMapDataInfo): Bool;
    function PESetMapDataInfo (
      printJob    : Smallint;
      hObject     : DWord;
      var mapInfo : PEMapDataInfo): Bool;
    function PEGetMapStyle (
      printJob     : Smallint;
      hObject      : DWord;
      var mapStyle : PEMapStyle): Bool;
    function PESetMapStyle (
      printJob     : Smallint;
      hObject      : DWord;
      var mapStyle : PEMapStyle): Bool;
    function PEGetNMapSummaryFields (
      printJob : Smallint;
      hObject  : DWord): Smallint;
    function PEGetNthMapSummaryField (
      printJob          : Smallint;
      hObject           : DWord;
      nSummaryField     : Smallint;
      var summaryField  : HWnd;
      var summaryLength : Smallint): Bool;
    function PESetNthMapSummaryField (
      printJob      : Smallint;
      hObject       : DWord;
      nSummaryField : Smallint;
      {for PE_MAP_LAYOUT_DETAIL only, set to PE_UNCHANGED to add.}
      {for other types must be in (0...(PEGetNMapSummaryFields - 1)).}
      summaryField  : PChar): Bool;
    function PEGetNMapConditionFields (
       printJob : Smallint;
       hObject  : DWord): Smallint;
    function PEGetNthMapConditionField (
      printJob            : Smallint;
      hObject             : DWord;
      condFieldN          : Smallint;
      var conditionField  : HWnd;
      var conditionLength : Smallint): Bool;
    function PESetNthMapConditionField (
      printJob   : Smallint;
      hObject    : DWord;
      condFieldN : Smallint;
      fieldName  : PChar): Bool;
    function PEGetMapConditions (
      printJob         : Smallint;
      hObject          : DWord;
      var mapCondition : PEMapCondition): Bool;
      function PESetMapConditions (
      printJob         : Smallint;
      hObject          : DWord;
      var mapCondition : PEMapCondition): Bool;
    function PEGetMapTitle (
      printJob        : Smallint;
      hObject         : DWord;
      var mapTitle    : HWnd;
      var titleLength : Smallint): Bool;
    function PESetMapTitle (
      printJob : Smallint;
      hObject  : DWord;
      mapTitle : PChar): Bool;
    function PEGetMapLegendTitle (
      printJob         : Smallint;
      hObject          : DWord;
      var legendTitle  : HWnd;
      var legendLength : Smallint): Bool;
    function PESetMapLegendTitle (
      printJob    : Smallint;
      hObject     : DWord;
      legendTitle : PChar): Bool;
    function PEGetMapLegendSubtitle (
      printJob           : Smallint;
      hObject            : DWord;
      var legendSubtitle : HWnd;
      var legendLength   : Smallint): Bool;
    function PESetMapLegendSubtitle (
      printJob       : Smallint;
      hObject        : DWord;
      legendSubtitle : PChar): Bool;
    function PEGetFormulaSyntax (
      printJob          : Smallint;
      var formulaSyntax : PEFormulaSyntax): Bool;
    function PESetFormulaSyntax (
      printJob          : Smallint;
      var formulaSyntax : PEFormulaSyntax): Bool;
    function PEGetNReportAlerts (printJob: Smallint): Smallint;
    function PEGetNthReportAlert (
      printJob            : Smallint;
      alertN              : Smallint;
      var reportAlertInfo : PEReportAlertInfo): Bool;
    function PEGetNthAlertInstanceInfo (
      printJob              : Smallint;
      alertN                : Smallint;
      instanceN             : DWord;
      var alertInstanceInfo : PEAlertInstanceInfo): Bool;
    function PESetNthAlertConditionFormula (
      printJob    : Smallint;
      alertN      : Smallint;
      var formula : PChar): Bool;
    function PESetNthAlertMessageFormula (
      printJob    : Smallint;
      alertN      : Smallint;
      var formula : PChar): Bool;
    function PESetNthAlertDefaultMessage(
      printJob : Smallint;
      alertN   : Smallint;
      var text : PChar): Bool;
    function PEEnableNthAlert (
      printJob : Smallint;
      alertN   : Smallint;
      enabled  : Bool): Bool;
    function PEGetObjectByName (
      printJob : Smallint;
      name     : PChar): DWORD;
    function PEGetObjectName (
      printJob             : Smallint;
      objectHandle         : DWord;
      var objectNameHandle : HWnd;
      var objectNameLength : Smallint): Bool;
    function PEGetSectionByName (
      printJob : Smallint;
      name     : PChar): Smallint;
    function PEGetAreaByName (
      printJob : Smallint;
      name     : PChar): Smallint;
    function PEGetAreaName (
      printJob       : Smallint;
      areaCode       : Smallint;
      var nameHandle : HWnd;
      var nameLength : Smallint): Bool;
    procedure PESetTempFilePath (Path : PChar);
    function PEGetNthGroupNameFormula (
      printJob       : Smallint;
      groupN         : Smallint;
      var textHandle : HWnd;
      var textLength : Smallint): Bool;
    function PESetNthGroupNameFormula (
      printJob       : Smallint;
      groupN         : Smallint;
      fString        : PChar): Bool;
  public
    CRDEngine     : HWnd; {CRPE32.DLL Engine Handle}
    CRDErrorStr   : string;  {Contains the last error string}
    CRDVerMajor   : integer; {Major release number}
    CRDVerMinor   : integer; {For N.5 releases, ie. 8.5}
    CRDVerRelease : integer; {Used for 7.0 maintenance: 7.x.100.15}
    CRDVerBuild   : integer; {if an earlier version than Crystal 7 is being used}
    CRDShowErrors : Boolean; {Use built-in Error Message routine}
  end;

{******************************************************************************}
{*** Implementation Section ***************************************************}
{******************************************************************************}
implementation

uses SysUtils;

{******************************************************************************}
{ Section Macros                                                               }
{******************************************************************************}
function PE_SECTION_CODE(sectionType, groupN, sectionN : Smallint): Smallint;
begin
  Result := (sectionType * 1000) + (groupN mod 25) + ((sectionN mod 40) * 25);
end;
function PE_AREA_CODE(sectionType, groupN: Smallint): Smallint;
begin
  Result := PE_SECTION_CODE(sectionType, groupN, 0);
end;
function PE_SECTION_TYPE(sectionCode: Smallint): Smallint;
begin
  Result := sectionCode div 1000;
end;
function PE_GROUP_N(sectionCode: Smallint): Smallint;
begin
  Result := sectionCode mod 25;
end;
function PE_SECTION_N(sectionCode: Smallint): Smallint;
begin
  Result := (sectionCode div 25) mod 40;
end;

{------------------------------------------------------------------------------}
{ CRDEngineError procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.CRDEngineError (const sMessage: string);
var
  s1 : string;
begin
  s1 := sMessage;
  CRDErrorStr := s1;
  if Length(sMessage) > 1 then
  begin
    s1 := Copy(sMessage, 1, 2);
    if UpperCase(s1) = 'PE' then
      s1 := CRD_ERROR_LOADING_FUNCTION + sMessage
    else
      s1 := sMessage;

    CRDErrorStr := s1;

    if CRDShowErrors then
    begin
      if Windows.MessageBox(0, PChar(s1 + chr(10) + 'Continue anyway?'),
         'Print Engine Error', MB_ICONSTOP + MB_OKCANCEL) = IDCANCEL then
        Abort;
    end;
  end;
end;

{------------------------------------------------------------------------------}
{ PELoadCrpeDll function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PELoadCrpeDll(const CrpeLocation: string) : Bool;
var
  s1,s2 : string;
begin
  Result := False;
  s1 := Trim(CrpeLocation);
  CRDEngine := LoadLibrary(PChar(s1));
  {If an error occured, set the flag}
  if (CRDEngine < HINSTANCE_ERROR) then
  begin
    CRDEngine := 0;
    s2 := SysErrorMessage(GetLastError);
    if Trim(s2) = '' then
      s1 := CRD_ERROR_LOADING + Chr(10) + 'Windows Error Number: ' + IntToStr(GetLastError)
    else
      s1 := CRD_ERROR_LOADING + Chr(10) +
        'Windows Error Number: ' + IntToStr(GetLastError) + ' - ' + Trim(s2);
    CRDEngineError(s1);
  end
  else
    Result := True;
end;

{------------------------------------------------------------------------------}
{ PEUnloadCrpeDll function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEUnloadCrpeDll : Bool;
var
  s1 : string;
begin
  CRDEngineError('');
  Result := True;
  {Check if Engine is not loaded, exit}
  if CRDEngine = 0 then Exit;
  Result := FreeLibrary(CRDEngine);
  CRDEngine := 0;
  if Result = False then
  begin
    s1 := SysErrorMessage(GetLastError);
    if Trim(s1) = '' then
      CRDEngineError(CRD_ERROR_FREEING + Chr(10) +
        'Windows Error Number: ' + IntToStr(GetLastError))
    else
      CRDEngineError(CRD_ERROR_FREEING + Chr(10) +
        'Windows Error Number: ' + IntToStr(GetLastError) + ' - ' + Trim(s1));
  end;
end;

{------------------------------------------------------------------------------}
{ PEOpenEngine function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOpenEngine: Bool;
var
  CrpeOpenEngine : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  if CRDEngine = 0 then
  begin
    if not PELoadCrpeDll('') then
      Exit;
  end;
  CrpeOpenEngine := GetProcAddress(CRDEngine, 'PEOpenEngine');
  if CrpeOpenEngine = nil then
    CRDEngineError('PEOpenEngine')
  else
    Result := TPEOpenEngine(CrpeOpenEngine);
end;

{------------------------------------------------------------------------------}
{ PECloseEngine procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.PECloseEngine;
var
  CrpeCloseEngine : TFarProc;
begin
  CRDEngineError('');
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    {CRDEngineError(CRD_ENGINE_NOT_LOADED);}
    Exit;
  end;
  CrpeCloseEngine := GetProcAddress(CRDEngine, 'PECloseEngine');
  if CrpeCloseEngine = nil then
    CRDEngineError('PECloseEngine')
  else
    TPECloseEngine(CrpeCloseEngine);
end;

{------------------------------------------------------------------------------}
{ PECanCloseEngine function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECanCloseEngine: Bool;
var
  CrpeCanCloseEngine : TFarProc;
begin
  CRDEngineError('');
  Result := True;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    {CRDEngineError(CRD_ENGINE_NOT_LOADED);}
    Exit;
  end;
  CrpeCanCloseEngine := GetProcAddress(CRDEngine, 'PECanCloseEngine');
  if CrpeCanCloseEngine = nil then
    CRDEngineError('PECanCloseEngine')
  else
    Result := TPECanCloseEngine(CrpeCanCloseEngine);
end;

{------------------------------------------------------------------------------}
{ PEOpenEngineEx function                                                      }
{  - Not fully implemented in CRPE yet...                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOpenEngineEx (var EngineOptions: PEEngineOptions): Bool;
var
  CrpeOpenEngineEx : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    if not PELoadCrpeDll('') then
      Exit;
  end;
  CrpeOpenEngineEx := GetProcAddress(CRDEngine, 'PEOpenEngineEx');
  if CrpeOpenEngineEx = nil then
    CRDEngineError('PEOpenEngineEx')
  else
  begin
    EngineOptions.structSize := SizeOf(PEEngineOptions);
    Result := TPEOpenEngineEx(CrpeOpenEngineEx)(EngineOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PEOpenPrintJob function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOpenPrintJob (reportFilePath : PChar): Smallint;
var
  CrpeOpenPrintJob : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeOpenPrintJob := GetProcAddress(CRDEngine, 'PEOpenPrintJob');
  if CrpeOpenPrintJob = nil then
    CRDEngineError('PEOpenPrintJob')
  else
    Result := TPEOpenPrintJob(CrpeOpenPrintJob)(reportFilePath);
end;

{------------------------------------------------------------------------------}
{ PEClosePrintJob function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEClosePrintJob (printJob : Smallint): Bool;
var
  CrpeClosePrintJob : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    {CRDEngineError(CRD_ENGINE_NOT_LOADED);}
    Exit;
  end;
  CrpeClosePrintJob := GetProcAddress(CRDEngine, 'PEClosePrintJob');
  if CrpeClosePrintJob = nil then
    CRDEngineError('PEClosePrintJob')
  else
    Result := TPEClosePrintJob(CrpeClosePrintJob)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEStartPrintJob function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEStartPrintJob (printJob: Smallint; waitUntilDone: Bool): Bool;
var
  CrpeStartPrintJob : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeStartPrintJob := GetProcAddress(CRDEngine, 'PEStartPrintJob');
  if CrpeStartPrintJob = nil then
    CRDEngineError('PEStartPrintJob')
  else
    Result := TPEStartPrintJob(CrpeStartPrintJob)(printJob, waitUntilDone);
end;

{------------------------------------------------------------------------------}
{ PECancelPrintJob procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.PECancelPrintJob (printJob : Smallint);
var
  CrpeCancelPrintJob : TFarProc;
begin
  CRDEngineError('');
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCancelPrintJob := GetProcAddress(CRDEngine, 'PECancelPrintJob');
  if CrpeCancelPrintJob = nil then
    CRDEngineError('PECancelPrintJob')
  else
    TPECancelPrintJob(CrpeCancelPrintJob)(printJob);
end;

{------------------------------------------------------------------------------}
{ PESetRefreshData procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.PESetRefreshData (printJob : Smallint; bUnknown: Bool);
var
  CrpeSetRefreshData : TFarProc;
begin
  CRDEngineError('');
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetRefreshData := GetProcAddress(CRDEngine, 'PESetRefreshData');
  if CrpeSetRefreshData = nil then
    CRDEngineError('PESetRefreshData')
  else
    TPESetRefreshData(CrpeSetRefreshData)(printJob, bUnknown);
end;

{------------------------------------------------------------------------------}
{ PEIsPrintJobFinished function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEIsPrintJobFinished (printJob : Smallint): Bool;
var
  CrpeIsPrintJobFinished : TFarProc;
begin
  CRDEngineError('');
  Result := True;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeIsPrintJobFinished := GetProcAddress(CRDEngine, 'PEIsPrintJobFinished');
  if CrpeIsPrintJobFinished = nil then
    CRDEngineError('PEIsPrintJobFinished')
  else
    Result := TPEIsPrintJobFinished(CrpeIsPrintJobFinished)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetJobStatus function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetJobStatus (printJob: Smallint; var jobInfo: PEJobInfo): Smallint;
var
  CrpeGetJobStatus : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetJobStatus := GetProcAddress(CRDEngine, 'PEGetJobStatus');
  if CrpeGetJobStatus = nil then
    CRDEngineError('PEGetJobStatus')
  else
  begin
    jobInfo.StructSize := SizeOf(PEJobInfo);
    Result := TPEGetJobStatus(CrpeGetJobStatus)(printJob, jobInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetVersion function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetVersion (versionRequested : Smallint): Smallint;
var
  CrpeGetVersion : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetVersion := GetProcAddress(CRDEngine, 'PEGetVersion');
  if CrpeGetVersion = nil then
    CRDEngineError('CrpeGetVersion')
  else
    Result := TPEGetVersion(CrpeGetVersion)(versionRequested);
end;

{------------------------------------------------------------------------------}
{ PEGetErrorCode function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetErrorCode (printJob : Smallint): Smallint;
var
  CrpeGetErrorCode : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetErrorCode := GetProcAddress(CRDEngine, 'PEGetErrorCode');
  if CrpeGetErrorCode = nil then
    CRDEngineError('PEGetErrorCode')
  else
    Result := TPEGetErrorCode(CrpeGetErrorCode)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetErrorText function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetErrorText (printJob: Smallint; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetErrorText : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetErrorText := GetProcAddress(CRDEngine, 'PEGetErrorText');
  if CrpeGetErrorText = nil then
    CRDEngineError('PEGetErrorText')
  else
    Result := TPEGetErrorText(CrpeGetErrorText)(printJob, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PEGetHandleString function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetHandleString (textHandle: HWnd; buffer: PChar;
  bufferLength: Smallint): Bool;
var
  CrpeGetHandleString : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetHandleString := GetProcAddress(CRDEngine, 'PEGetHandleString');
  if CrpeGetHandleString = nil then
    CRDEngineError('PEGetHandleString')
  else
    Result := TPEGetHandleString(CrpeGetHandleString)(textHandle,
      buffer, bufferLength);
end;

{------------------------------------------------------------------------------}
{ PEGetStringHandle function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetStringHandle (const inStr: PChar; var outStrHandle: HWnd;
  var outStrLength: DWord): Bool;
var
  CrpeGetStringHandle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetStringHandle := GetProcAddress(CRDEngine, 'PEGetStringHandle');
  if CrpeGetStringHandle = nil then
    CRDEngineError('PEGetStringHandle')
  else
    Result := TPEGetStringHandle(CrpeGetStringHandle)(inStr,
      outStrHandle, outStrLength);
end;

{------------------------------------------------------------------------------}
{ PEGetStringHandleExW function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetStringHandleExW (const inStr: PWChar; var outStrHandle: HWnd;
  var outStrLength: DWord): Bool;
var
  CrpeGetStringHandleExW : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetStringHandleExW := GetProcAddress(CRDEngine, 'PEGetStringHandleExW');
  if CrpeGetStringHandleExW = nil then
    CRDEngineError('PEGetStringHandleExW')
  else
    Result := TPEGetStringHandleExW(CrpeGetStringHandleExW)(inStr,
      outStrHandle, outStrLength);
end;

{------------------------------------------------------------------------------}
{ PEPrintReport function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEPrintReport (reportFilePath: PChar; toDefaultPrinter, toWindow: Bool;
  title: PChar; left, top, width, height: integer; style: DWord;
  parentWindow: Hwnd): Smallint;
var
  CrpePrintReport : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpePrintReport := GetProcAddress(CRDEngine, 'PEPrintReport');
  if CrpePrintReport = nil then
    CRDEngineError('PEPrintReport')
  else
    Result := TPEPrintReport(CrpePrintReport)(reportFilePath,
      toDefaultPrinter, toWindow, title, left, top, width,
      height, style, parentWindow);
end;

{------------------------------------------------------------------------------}
{ PEGetReportVersion function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReportVersion (printJob: Smallint;
  var VersionInfo : PEVersionInfo): Bool;
var
  CrpeGetReportVersion : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReportVersion := GetProcAddress(CRDEngine, 'PEGetReportVersion');
  if CrpeGetReportVersion = nil then
    CRDEngineError('PEGetReportVersion')
  else
  begin
    VersionInfo.structSize := SizeOf(PEVersionInfo);
    Result := TPEGetReportVersion(CrpeGetReportVersion)(printJob, VersionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetReportOptions function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReportOptions (printJob: Smallint;
  var reportOptions: PEReportOptions): Bool;
var
  CrpeGetReportOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReportOptions := GetProcAddress(CRDEngine, 'PEGetReportOptions');
  if CrpeGetReportOptions = nil then
    CRDEngineError('PEGetReportOptions')
  else
  begin
    reportOptions.structSize := SizeOf(PEReportOptions);
    Result := TPEGetReportOptions(CrpeGetReportOptions)(printJob,
      reportOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetReportOptions function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetReportOptions (printJob: Smallint;
  var ReportOptions: PEReportOptions): Bool;
var
  CrpeSetReportOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetReportOptions := GetProcAddress(CRDEngine, 'PESetReportOptions');
  if CrpeSetReportOptions = nil then
    CRDEngineError('PESetReportOptions')
  else
  begin
    reportOptions.structSize := SizeOf(PEReportOptions);
    Result := TPESetReportOptions(CrpeSetReportOptions)(printJob,
      reportOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PEOpenSubreport function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOpenSubreport (parentJob: Smallint; subreportName: PChar): Smallint;
var
  CrpeOpenSubreport : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeOpenSubreport := GetProcAddress(CRDEngine, 'PEOpenSubreport');
  if CrpeOpenSubreport = nil then
    CRDEngineError('PEOpenSubreport')
  else
    Result := TPEOpenSubreport(CrpeOpenSubreport)(parentJob, subreportName);
end;

{------------------------------------------------------------------------------}
{ PECloseSubreport function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECloseSubreport (printJob: Smallint): Bool;
var
  CrpeCloseSubreport : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    {CRDEngineError(CRD_ENGINE_NOT_LOADED);}
    Exit;
  end;
  CrpeCloseSubreport := GetProcAddress(CRDEngine, 'PECloseSubreport');
  if CrpeCloseSubreport = nil then
    CRDEngineError('PECloseSubreport')
  else
    Result := TPECloseSubreport(CrpeCloseSubreport)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNSubreportsInSection function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSubreportsInSection (printJob: Smallint;
  sectionCode: Smallint): Smallint;
var
  CrpeGetNSubreportsInSection : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSubreportsInSection := GetProcAddress(CRDEngine, 'PEGetNSubreportsInSection');
  if CrpeGetNSubreportsInSection = nil then
    CRDEngineError('PEGetNSubreportsInSection')
  else
    Result := TPEGetNSubreportsInSection(CrpeGetNSubreportsInSection)
      (printJob, sectionCode);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSubreportInSection function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSubreportInSection (printJob: Smallint; sectionCode: Smallint;
  subreportN: Smallint): DWord;
var
  CrpeGetNthSubreportInSection : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSubreportInSection := GetProcAddress(CRDEngine, 'PEGetNthSubreportInSection');
  if CrpeGetNthSubreportInSection = nil then
    CRDEngineError('PEGetNthSubreportInSection')
  else
    Result := TPEGetNthSubreportInSection(CrpeGetNthSubreportInSection)
      (printJob, sectionCode, subreportN);
end;

{------------------------------------------------------------------------------}
{ PEGetSubreportInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSubreportInfo (printJob: Smallint; subreportHandle: DWord;
  var subreportInfo: PESubreportInfo): Bool;
var
  CrpeGetSubreportInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSubreportInfo := GetProcAddress(CRDEngine, 'PEGetSubreportInfo');
  if CrpeGetSubreportInfo = nil then
    CRDEngineError('PEGetSubreportInfo')
  else
  begin
    subreportInfo.Structsize := SizeOf(PESubreportInfo);
    Result := TPEGetSubreportInfo(CrpeGetSubreportInfo)
      (printJob, subreportHandle, subreportInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetDialogParentWindow function                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetDialogParentWindow (printJob: Smallint; parentWindow: HWnd): Bool;
var
  CrpeSetDialogParentWindow : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetDialogParentWindow := GetProcAddress(CRDEngine, 'PESetDialogParentWindow');
  if CrpeSetDialogParentWindow = nil then
    CRDEngineError('PESetDialogParentWindow')
  else
    Result := TPESetDialogParentWindow(CrpeSetDialogParentWindow)
      (printJob, parentWindow);
end;

{------------------------------------------------------------------------------}
{ PEEnableProgressDialog function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEEnableProgressDialog (printJob: Smallint; enable: Bool): Bool;
var
  CrpeEnableProgressDialog : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeEnableProgressDialog := GetProcAddress(CRDEngine, 'PEEnableProgressDialog');
  if CrpeEnableProgressDialog = nil then
    CRDEngineError('PEEnableProgressDialog')
  else
    Result := TPEEnableProgressDialog(CrpeEnableProgressDialog)(printJob, enable);
end;

{------------------------------------------------------------------------------}
{ PEGetAllowPromptDialog function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetAllowPromptDialog (printJob: Smallint): Bool;
var
  CrpeGetAllowPromptDialog : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetAllowPromptDialog := GetProcAddress(CRDEngine, 'PEGetAllowPromptDialog');
  if CrpeGetAllowPromptDialog = nil then
    CRDEngineError('PEGetAllowPromptDialog')
  else
    Result := TPEGetAllowPromptDialog(CrpeGetAllowPromptDialog)(printJob);
end;

{------------------------------------------------------------------------------}
{ PESetAllowPromptDialog function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetAllowPromptDialog (printJob: Smallint; showPromptDialog: Bool): Bool;
var
  CrpeSetAllowPromptDialog : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetAllowPromptDialog := GetProcAddress(CRDEngine, 'PESetAllowPromptDialog');
  if CrpeSetAllowPromptDialog = nil then
    CRDEngineError('PESetAllowPromptDialog')
  else
    Result := TPESetAllowPromptDialog(CrpeSetAllowPromptDialog)
      (printJob, showPromptDialog);
end;

{------------------------------------------------------------------------------}
{ PEGetPrintDate function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetPrintDate (printJob: Smallint; var year: Smallint;
  var month: Smallint; var day: Smallint): Bool;
var
  CrpeGetPrintDate : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetPrintDate := GetProcAddress(CRDEngine, 'PEGetPrintDate');
  if CrpeGetPrintDate = nil then
    CRDEngineError('PEGetPrintDate')
  else
    Result := TPEGetPrintDate(CrpeGetPrintDate)(printJob, year, month, day);
end;

{------------------------------------------------------------------------------}
{ PESetPrintDate function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetPrintDate (printJob: Smallint; year: Smallint;
  month: Smallint; day: Smallint): Bool;
var
  CrpeSetPrintDate : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetPrintDate := GetProcAddress(CRDEngine, 'PESetPrintDate');
  if CrpeSetPrintDate = nil then
    CRDEngineError('PESetPrintDate')
  else
    Result := TPESetPrintDate(CrpeSetPrintDate)(printJob, year, month, day);
end;

{------------------------------------------------------------------------------}
{ PEGetNGroups function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNGroups (printJob: Smallint): Smallint;
var
  CrpeGetNGroups : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNGroups := GetProcAddress(CRDEngine, 'PEGetNGroups');
  if CrpeGetNGroups = nil then
    CRDEngineError('PEGetNGroups')
  else
    Result := TPEGetNGroups(CrpeGetNGroups)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetGroupCondition function                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGroupCondition (printJob: Smallint; sectionCode: Smallint;
  var conditionFieldHandle: Hwnd; var conditionFieldLength: Smallint;
  var condition: Smallint; var sortDirection: Smallint): Bool;
var
  CrpeGetGroupCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGroupCondition := GetProcAddress(CRDEngine, 'PEGetGroupCondition');
  if CrpeGetGroupCondition = nil then
    CRDEngineError('PEGetGroupCondition')
  else
    Result := TPEGetGroupCondition(CrpeGetGroupCondition)(printJob,
      sectionCode, conditionFieldHandle, conditionFieldLength,
      condition, sortDirection);
end;

{------------------------------------------------------------------------------}
{ PESetGroupCondition function                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGroupCondition (printJob: Smallint; sectionCode: Smallint;
  conditionField: PChar; condition: Smallint; sortDirection: Smallint): Bool;
var
  CrpeSetGroupCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGroupCondition := GetProcAddress(CRDEngine, 'PESetGroupCondition');
  if CrpeSetGroupCondition = nil then
    CRDEngineError('PESetGroupCondition')
  else
    Result := TPESetGroupCondition(CrpeSetGroupCondition)(printJob,
      sectionCode, conditionField, condition, sortDirection);
end;

{------------------------------------------------------------------------------}
{ PEGetGroupOptions function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGroupOptions (printJob: Smallint; groupN: Smallint;
  var groupOptions: PEGroupOptions): Bool;
var
  CrpeGetGroupOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGroupOptions := GetProcAddress(CRDEngine, 'PEGetGroupOptions');
  if CrpeGetGroupOptions = nil then
    CRDEngineError('PEGetGroupOptions')
  else
  begin
    groupOptions.structSize := SizeOf(PEGroupOptions);
    Result := TPEGetGroupOptions(CrpeGetGroupOptions)(printJob,
      groupN, groupOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGroupOptions function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGroupOptions (printJob: Smallint; groupN: Smallint;
  var groupOptions: PEGroupOptions): Bool;
var
  CrpeSetGroupOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGroupOptions := GetProcAddress(CRDEngine, 'PESetGroupOptions');
  if CrpeSetGroupOptions = nil then
    CRDEngineError('PESetGroupOptions')
  else
  begin
    groupOptions.structSize := SizeOf(PEGroupOptions);
    Result := TPESetGroupOptions(CrpeSetGroupOptions)(printJob,
      groupN, groupOptions);
  end;
end;

{Stopped logging here!}

{------------------------------------------------------------------------------}
{ PEGetNSections function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSections (printJob: Smallint): Smallint;
var
  CrpeGetNSections : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSections := GetProcAddress(CRDEngine, 'PEGetNSections');
  if CrpeGetNSections = nil then
    CRDEngineError('PEGetNSections')
  else
    Result := TPEGetNSections(CrpeGetNSections)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetSectionCode function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionCode (printJob: Smallint; sectionN: Smallint): Smallint;
var
  CrpeGetSectionCode : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionCode := GetProcAddress(CRDEngine, 'PEGetSectionCode');
  if CrpeGetSectionCode = nil then
    CRDEngineError('PEGetSectionCode')
  else
    Result := TPEGetSectionCode(CrpeGetSectionCode)(printJob, sectionN);
end;

{------------------------------------------------------------------------------}
{ PEGetMinimumSectionHeight function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMinimumSectionHeight (printJob: Smallint; sectionCode: Smallint;
  var minimumHeight: Smallint): Bool;
var
  CrpeGetMinimumSectionHeight : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMinimumSectionHeight := GetProcAddress(CRDEngine, 'PEGetMinimumSectionHeight');
  if CrpeGetMinimumSectionHeight = nil then
    CRDEngineError('PEGetMinimumSectionHeight')
  else
    Result := TPEGetMinimumSectionHeight(CrpeGetMinimumSectionHeight)
      (printJob, sectionCode, minimumHeight);
end;

{------------------------------------------------------------------------------}
{ PESetMinimumSectionHeight function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMinimumSectionHeight (printJob: Smallint; sectionCode: Smallint;
  minimumHeight: Smallint): Bool;
var
  CrpeSetMinimumSectionHeight : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMinimumSectionHeight := GetProcAddress(CRDEngine, 'PESetMinimumSectionHeight');
  if CrpeSetMinimumSectionHeight = nil then
    CRDEngineError('PESetMinimumSectionHeight')
  else
  begin
    Result := TPESetMinimumSectionHeight(CrpeSetMinimumSectionHeight)
      (printJob, sectionCode, minimumHeight);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetSectionHeight function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionHeight (printJob: Smallint; sectionCode: Smallint;
  var Height: Smallint): Bool;
var
  CrpeGetSectionHeight : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionHeight := GetProcAddress(CRDEngine, 'PEGetSectionHeight');
  if CrpeGetSectionHeight = nil then
    CRDEngineError('PEGetSectionHeight')
  else
    Result := TPEGetSectionHeight(CrpeGetSectionHeight)
      (printJob, sectionCode, Height);
end;

{------------------------------------------------------------------------------}
{ PESetSectionHeight function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSectionHeight (printJob: Smallint; sectionCode: Smallint;
  Height: Smallint): Bool;
var
  CrpeSetSectionHeight : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSectionHeight := GetProcAddress(CRDEngine, 'PESetSectionHeight');
  if CrpeSetSectionHeight = nil then
    CRDEngineError('PESetSectionHeight')
  else
  begin
    Result := TPESetSectionHeight(CrpeSetSectionHeight)
      (printJob, sectionCode, Height);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetSectionFormat function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionFormat (printJob: Smallint; sectionCode: Smallint;
  var options: PESectionOptions): Bool;
var
  CrpeGetSectionFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionFormat := GetProcAddress(CRDEngine, 'PEGetSectionFormat');
  if CrpeGetSectionFormat = nil then
    CRDEngineError('PEGetSectionFormat')
  else
  begin
    options.structSize := SizeOf(PESectionOptions);
    Result := TPEGetSectionFormat(CrpeGetSectionFormat)
      (printJob, sectionCode, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetSectionFormat function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSectionFormat (printJob: Smallint; sectionCode: Smallint;
  var options: PESectionOptions): Bool;
var
  CrpeSetSectionFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSectionFormat := GetProcAddress(CRDEngine, 'PESetSectionFormat');
  if CrpeSetSectionFormat = nil then
    CRDEngineError('PESetSectionFormat')
  else
  begin
    options.structSize := SizeOf(PESectionOptions);
    Result := TPESetSectionFormat(CrpeSetSectionFormat)
      (printJob, sectionCode, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetAreaFormat function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetAreaFormat (printJob: Smallint; areaCode: Smallint;
  var options: PESectionOptions): Bool;
var
  CrpeGetAreaFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetAreaFormat := GetProcAddress(CRDEngine, 'PEGetAreaFormat');
  if CrpeGetAreaFormat = nil then
    CRDEngineError('PEGetAreaFormat')
  else
  begin
    options.structSize := SizeOf(PESectionOptions);
    Result := TPEGetAreaFormat(CrpeGetAreaFormat)
      (printJob, areaCode, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetAreaFormat function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetAreaFormat (printJob: Smallint; areaCode: Smallint;
  var options: PESectionOptions): Bool;
var
  CrpeSetAreaFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetAreaFormat := GetProcAddress(CRDEngine, 'PESetAreaFormat');
  if CrpeSetAreaFormat = nil then
    CRDEngineError('PESetAreaFormat')
  else
  begin
    options.structSize := SizeOf(PESectionOptions);
    Result := TPESetAreaFormat(CrpeSetAreaFormat)
      (printJob, areaCode, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetFont function                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetFont (printJob: Smallint; sectionCode: Smallint;
  scopeCode: Smallint; faceName: PChar; fontFamily: Smallint;
  fontPitch: Smallint; charSet: Smallint; pointSize: Smallint;
  isItalic: Smallint; isUnderlined: Smallint; isStruckOut: Smallint;
  weight: Smallint): Bool;
var
  CrpeSetFont : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetFont := GetProcAddress(CRDEngine, 'PESetFont');
  if CrpeSetFont = nil then
    CRDEngineError('PESetFont')
  else
  begin
    Result := TPESetFont(CrpeSetFont)(printJob, sectionCode, scopeCode,
      faceName, fontFamily, fontPitch, charSet, pointSize, isItalic,
      isUnderlined, isStruckOut, weight);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetGraphTypeInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphTypeInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphTypeInfo: PEGraphTypeInfo): Bool;
var
  CrpeGetGraphTypeInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphTypeInfo := GetProcAddress(CRDEngine, 'PEGetGraphTypeInfo');
  if CrpeGetGraphTypeInfo = nil then
    CRDEngineError('PEGetGraphTypeInfo')
  else
  begin
    graphTypeInfo.structSize := SizeOf(PEGraphTypeInfo);
    Result := TPEGetGraphTypeInfo(CrpeGetGraphTypeInfo)(printJob,
      sectionN, graphN, graphTypeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphTypeInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphTypeInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphTypeInfo: PEGraphTypeInfo): Bool;
var
  CrpeSetGraphTypeInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphTypeInfo := GetProcAddress(CRDEngine, 'PESetGraphTypeInfo');
  if CrpeSetGraphTypeInfo = nil then
    CRDEngineError('PESetGraphTypeInfo')
  else
  begin
    graphTypeInfo.structSize := SizeOf(PEGraphTypeInfo);
    Result := TPESetGraphTypeInfo(CrpeSetGraphTypeInfo)(printJob,
      sectionN, graphN, graphTypeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetGraphTextInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphTextInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleType: Word; var title: Hwnd;
  var titleLength: Smallint): Bool;
var
  CrpeGetGraphTextInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphTextInfo := GetProcAddress(CRDEngine, 'PEGetGraphTextInfo');
  if CrpeGetGraphTextInfo = nil then
    CRDEngineError('PEGetGraphTextInfo')
  else
  begin
    Result := TPEGetGraphTextInfo(CrpeGetGraphTextInfo)(printJob,
      sectionN, graphN, titleType, title, titleLength);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphTextInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphTextInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleType: Word; title: PChar): Bool;
var
  CrpeSetGraphTextInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphTextInfo := GetProcAddress(CRDEngine, 'PESetGraphTextInfo');
  if CrpeSetGraphTextInfo = nil then
    CRDEngineError('PESetGraphTextInfo')
  else
    Result := TPESetGraphTextInfo(CrpeSetGraphTextInfo)(printJob,
      sectionN, graphN, titleType, title);
end;

{------------------------------------------------------------------------------}
{ PEGetGraphFontInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphFontInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleFontType: Word; var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeGetGraphFontInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphFontInfo := GetProcAddress(CRDEngine, 'PEGetGraphFontInfo');
  if CrpeGetGraphFontInfo = nil then
    CRDEngineError('PEGetGraphFontInfo')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPEGetGraphFontInfo(CrpeGetGraphFontInfo)(printJob,
      sectionN, graphN, titleFontType, fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphFontInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphFontInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleFontType: Word; var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeSetGraphFontInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphFontInfo := GetProcAddress(CRDEngine, 'PESetGraphFontInfo');
  if CrpeSetGraphFontInfo = nil then
    CRDEngineError('PESetGraphFontInfo')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPESetGraphFontInfo(CrpeSetGraphFontInfo)(printJob,
      sectionN, graphN, titleFontType, fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetGraphOptionInfo function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphOptionInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphOptionInfo: PEGraphOptionInfo): Bool;
var
  CrpeGetGraphOptionInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphOptionInfo := GetProcAddress(CRDEngine, 'PEGetGraphOptionInfo');
  if CrpeGetGraphOptionInfo = nil then
    CRDEngineError('PEGetGraphOptionInfo')
  else
  begin
    graphOptionInfo.structSize := SizeOf(PEGraphOptionInfo);
    Result := TPEGetGraphOptionInfo(CrpeGetGraphOptionInfo)(printJob,
      sectionN, graphN, graphOptionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphOptionInfo function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphOptionInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphOptionInfo: PEGraphOptionInfo): Bool;
var
  CrpeSetGraphOptionInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphOptionInfo := GetProcAddress(CRDEngine, 'PESetGraphOptionInfo');
  if CrpeSetGraphOptionInfo = nil then
    CRDEngineError('PESetGraphOptionInfo')
  else
  begin
    graphOptionInfo.structSize := SizeOf(PEGraphOptionInfo);
    Result := TPESetGraphOptionInfo(CrpeSetGraphOptionInfo)(printJob,
      sectionN, graphN, graphOptionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetGraphAxisInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphAxisInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphAxisInfo: PEGraphAxisInfo): Bool;
var
  CrpeGetGraphAxisInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphAxisInfo := GetProcAddress(CRDEngine, 'PEGetGraphAxisInfo');
  if CrpeGetGraphAxisInfo = nil then
    CRDEngineError('PEGetGraphAxisInfo')
  else
  begin
    graphAxisInfo.structSize := SizeOf(PEGraphAxisInfo);
    Result := TPEGetGraphAxisInfo(CrpeGetGraphAxisInfo)(printJob, sectionN,
      graphN, graphAxisInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphAxisInfo function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphAxisInfo (printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphAxisInfo: PEGraphAxisInfo): Bool;
var
  CrpeSetGraphAxisInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphAxisInfo := GetProcAddress(CRDEngine, 'PESetGraphAxisInfo');
  if CrpeSetGraphAxisInfo = nil then
    CRDEngineError('PESetGraphAxisInfo')
  else
  begin
    graphAxisInfo.structSize := SizeOf(PEGraphAxisInfo);
    Result := TPESetGraphAxisInfo(CrpeSetGraphAxisInfo)(printJob, sectionN,
      graphN, graphAxisInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNFormulas function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNFormulas (printJob: Smallint): Smallint;
var
  CrpeGetNFormulas : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNFormulas := GetProcAddress(CRDEngine, 'PEGetNFormulas');
  if CrpeGetNFormulas = nil then
    CRDEngineError('PEGetNFormulas')
  else
    Result := TPEGetNFormulas(CrpeGetNFormulas)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthFormula function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthFormula (printJob: Smallint; formulaN: Smallint;
  var nameHandle: Hwnd; var nameLength: Smallint; var textHandle: Hwnd;
  var textLength: Smallint): Bool;
var
  CrpeGetNthFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthFormula := GetProcAddress(CRDEngine, 'PEGetNthFormula');
  if CrpeGetNthFormula = nil then
    CRDEngineError('PEGetNthFormula')
  else
    Result := TPEGetNthFormula(CrpeGetNthFormula)(printJob, formulaN,
      nameHandle, nameLength, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PEGetFormula function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFormula (printJob: Smallint; formulaName: PChar;
  var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFormula := GetProcAddress(CRDEngine, 'PEGetFormula');
  if CrpeGetFormula = nil then
    CRDEngineError('PEGetFormula')
  else
    Result := TPEGetFormula(CrpeGetFormula)(printJob, formulaName,
      textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetFormula function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetFormula (printJob: Smallint; formulaName: PChar;
  formulaString: PChar): Bool;
var
  CrpeSetFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetFormula := GetProcAddress(CRDEngine, 'PESetFormula');
  if CrpeSetFormula = nil then
    CRDEngineError('PESetFormula')
  else
    Result := TPESetFormula(CrpeSetFormula)(printJob, formulaName,
      formulaString);
end;

{------------------------------------------------------------------------------}
{ PECheckFormula function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECheckFormula (printJob: Smallint; formulaName: PChar): Bool;
var
  CrpeCheckFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCheckFormula := GetProcAddress(CRDEngine, 'PECheckFormula');
  if CrpeCheckFormula = nil then
    CRDEngineError('PECheckFormula')
  else
    Result := TPECheckFormula(CrpeCheckFormula)(printJob, formulaName);
end;

{------------------------------------------------------------------------------}
{ PEGetSelectionFormula function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSelectionFormula (printJob: Smallint; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSelectionFormula := GetProcAddress(CRDEngine, 'PEGetSelectionFormula');
  if CrpeGetSelectionFormula = nil then
    CRDEngineError('PEGetSelectionFormula')
  else
    Result := TPEGetSelectionFormula(CrpeGetSelectionFormula)(printJob,
      textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetSelectionFormula function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSelectionFormula (printJob: Smallint; formulaString: PChar): Bool;
var
  CrpeSetSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSelectionFormula := GetProcAddress(CRDEngine, 'PESetSelectionFormula');
  if CrpeSetSelectionFormula = nil then
    CRDEngineError('PESetSelectionFormula')
  else
    Result := TPESetSelectionFormula(CrpeSetSelectionFormula)(printJob,
      formulaString);
end;

{------------------------------------------------------------------------------}
{ PECheckSelectionFormula function                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECheckSelectionFormula (printJob: Smallint): Bool;
var
  CrpeCheckSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCheckSelectionFormula := GetProcAddress(CRDEngine, 'PECheckSelectionFormula');
  if CrpeCheckSelectionFormula = nil then
    CRDEngineError('PECheckSelectionFormula')
  else
    Result := TPECheckSelectionFormula(CrpeCheckSelectionFormula)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetGroupSelectionFormula function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGroupSelectionFormula (printJob: Smallint; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetGroupSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGroupSelectionFormula := GetProcAddress(CRDEngine, 'PEGetGroupSelectionFormula');
  if CrpeGetGroupSelectionFormula = nil then
    CRDEngineError('PEGetGroupSelectionFormula')
  else
    Result := TPEGetGroupSelectionFormula(CrpeGetGroupSelectionFormula)
      (printJob, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetGroupSelectionFormula function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGroupSelectionFormula (printJob: Smallint; formulaString: PChar): Bool;
var
  CrpeSetGroupSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGroupSelectionFormula := GetProcAddress(CRDEngine, 'PESetGroupSelectionFormula');
  if CrpeSetGroupSelectionFormula = nil then
    CRDEngineError('PESetGroupSelectionFormula')
  else
    Result := TPESetGroupSelectionFormula(CrpeSetGroupSelectionFormula)
      (printJob, formulaString);
end;

{------------------------------------------------------------------------------}
{ PECheckGroupSelectionFormula function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECheckGroupSelectionFormula (printJob: Smallint): Bool;
var
  CrpeCheckGroupSelectionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCheckGroupSelectionFormula := GetProcAddress(CRDEngine, 'PECheckGroupSelectionFormula');
  if CrpeCheckGroupSelectionFormula = nil then
    CRDEngineError('PECheckGroupSelectionFormula')
  else
    Result := TPECheckGroupSelectionFormula(CrpeCheckGroupSelectionFormula)
      (printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetSectionFormatFormula function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionFormatFormula (printJob: Smallint; sectionCode: Smallint;
  formulaName: Smallint; var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetSectionFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionFormatFormula := GetProcAddress(CRDEngine, 'PEGetSectionFormatFormula');
  if CrpeGetSectionFormatFormula = nil then
    CRDEngineError('PEGetSectionFormatFormula')
  else
    Result := TPEGetSectionFormatFormula(CrpeGetSectionFormatFormula)
      (printJob, sectionCode, formulaName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetSectionFormatFormula function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSectionFormatFormula (printJob: Smallint; sectionCode: Smallint;
  formulaName: Smallint; formulaString: PChar): Bool;
var
  CrpeSetSectionFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSectionFormatFormula := GetProcAddress(CRDEngine, 'PESetSectionFormatFormula');
  if CrpeSetSectionFormatFormula = nil then
    CRDEngineError('PEGetSectionFormatFormula')
  else
    Result := TPESetSectionFormatFormula(CrpeSetSectionFormatFormula)
      (printJob, sectionCode, formulaName, formulaString);
end;

{------------------------------------------------------------------------------}
{ PEGetAreaFormatFormula function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetAreaFormatFormula (printJob: Smallint; areaCode: Smallint;
  formulaName: Smallint; var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetAreaFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetAreaFormatFormula := GetProcAddress(CRDEngine, 'PEGetAreaFormatFormula');
  if CrpeGetAreaFormatFormula = nil then
    CRDEngineError('PEGetAreaFormatFormula')
  else
    Result := TPEGetAreaFormatFormula(CrpeGetAreaFormatFormula)
      (printJob, areaCode, formulaName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetAreaFormatFormula function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetAreaFormatFormula (printJob: Smallint; areaCode: Smallint;
  formulaName: Smallint; formulaString: PChar): Bool;
var
  CrpeSetAreaFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetAreaFormatFormula := GetProcAddress(CRDEngine, 'PESetAreaFormatFormula');
  if CrpeSetAreaFormatFormula = nil then
    CRDEngineError('PESetAreaFormatFormula')
  else
    Result := TPESetAreaFormatFormula(CrpeSetAreaFormatFormula)
      (printJob, areaCode, formulaName, formulaString);
end;

{------------------------------------------------------------------------------}
{ PEGetNSQLExpressions function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSQLExpressions (printJob: Smallint): Smallint;
var
  CrpeGetNSQLExpressions : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSQLExpressions := GetProcAddress(CRDEngine, 'PEGetNSQLExpressions');
  if CrpeGetNSQLExpressions = nil then
    CRDEngineError('PEGetNSQLExpressions')
  else
    Result := TPEGetNSQLExpressions(CrpeGetNSQLExpressions)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSQLExpression function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSQLExpression (printJob: Smallint; expressionN: Smallint;
  var nameHandle: Hwnd; var nameLength: Smallint; var textHandle: Hwnd;
  var textLength: Smallint): Bool;
var
  CrpeGetNthSQLExpression : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSQLExpression := GetProcAddress(CRDEngine, 'PEGetNthSQLExpression');
  if CrpeGetNthSQLExpression = nil then
    CRDEngineError('PEGetNthSQLExpression')
  else
    Result := TPEGetNthSQLExpression(CrpeGetNthSQLExpression)(printJob,
      expressionN, nameHandle, nameLength, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PEGetSQLExpression function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSQLExpression (printJob: Smallint; const expressionName: PChar;
  var textHandle: Hwnd; var textLength: Smallint): Bool;
var
  CrpeGetSQLExpression : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSQLExpression := GetProcAddress(CRDEngine, 'PEGetSQLExpression');
  if CrpeGetSQLExpression = nil then
    CRDEngineError('PEGetSQLExpression')
  else
    Result := TPEGetSQLExpression(CrpeGetSQLExpression)(printJob,
      expressionName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetSQLExpression function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSQLExpression (printJob: Smallint; const expressionName: PChar;
  const expressionString: PChar): Bool;
var
  CrpeSetSQLExpression : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSQLExpression := GetProcAddress(CRDEngine, 'PESetSQLExpression');
  if CrpeSetSQLExpression = nil then
    CRDEngineError('PESetSQLExpression')
  else
    Result := TPESetSQLExpression(CrpeSetSQLExpression)(printJob,
      expressionName, expressionString);
end;

{------------------------------------------------------------------------------}
{ PECheckSQLExpression function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECheckSQLExpression (printJob: Smallint; const expressionName: PChar): Bool;
var
  CrpeCheckSQLExpression : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCheckSQLExpression := GetProcAddress(CRDEngine, 'PECheckSQLExpression');
  if CrpeCheckSQLExpression = nil then
    CRDEngineError('PECheckSQLExpression')
  else
    Result := TPECheckSQLExpression(CrpeCheckSQLExpression)(printJob,
      expressionName);
end;

{------------------------------------------------------------------------------}
{ PEGetNParameterFields function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNParameterFields (printJob: Smallint): Smallint;
var
  CrpeGetNParameterFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNParameterFields := GetProcAddress(CRDEngine, 'PEGetNParameterFields');
  if CrpeGetNParameterFields = nil then
    CRDEngineError('PEGetNParameterFields')
  else
    Result := TPEGetNParameterFields(CrpeGetNParameterFields)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterField function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterField (printJob: Smallint; parameterN: Smallint;
  var parameterInfo: PEParameterFieldInfo): Bool;
var
  CrpeGetNthParameterField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterField := GetProcAddress(CRDEngine, 'PEGetNthParameterField');
  if CrpeGetNthParameterField = nil then
    CRDEngineError('PEGetNthParameterField')
  else
  begin
    parameterInfo.structSize := SizeOf(PEParameterFieldInfo);
    Result := TPEGetNthParameterField(CrpeGetNthParameterField)(printJob,
      parameterN, parameterInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthParameterField function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthParameterField (printJob: Smallint; parameterN: Smallint;
  var parameterInfo: PEParameterFieldInfo): Bool;
var
  CrpeSetNthParameterField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthParameterField := GetProcAddress(CRDEngine, 'PESetNthParameterField');
  if CrpeSetNthParameterField = nil then
    CRDEngineError('PESetNthParameterField')
  else
  begin
    parameterInfo.structSize := SizeOf(PEParameterFieldInfo);
    Result := TPESetNthParameterField(CrpeSetNthParameterField)(printJob,
      parameterN, parameterInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEConvertPFInfoToVInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEConvertPFInfoToVInfo (value: PChar; valueType: Smallint;
  var valueInfo: PEValueInfo): Bool;
var
  CrpeConvertPFInfoToVInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeConvertPFInfoToVInfo := GetProcAddress(CRDEngine, 'PEConvertPFInfoToVInfo');
  if CrpeConvertPFInfoToVInfo = nil then
    CRDEngineError('PEConvertPFInfoToVInfo')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEConvertPFInfoToVInfo(CrpeConvertPFInfoToVInfo)(value,
      valueType, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEConvertVInfoToPFInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEConvertVInfoToPFInfo (var valueInfo: PEValueInfo;
  var valueType: Word; value: PChar): Bool;
var
  CrpeConvertVInfoToPFInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeConvertVInfoToPFInfo := GetProcAddress(CRDEngine, 'PEConvertVInfoToPFInfo');
  if CrpeConvertVInfoToPFInfo = nil then
    CRDEngineError('PEConvertVInfoToPFInfo')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEConvertVInfoToPFInfo(CrpeConvertVInfoToPFInfo)(valueInfo,
      valueType, value);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNParameterDefaultValues function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNParameterDefaultValues (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar): Smallint;
var
  CrpeGetNParameterDefaultValues : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNParameterDefaultValues := GetProcAddress(CRDEngine, 'PEGetNParameterDefaultValues');
  if CrpeGetNParameterDefaultValues = nil then
    CRDEngineError('PEGetNParameterDefaultValues')
  else
    Result := TPEGetNParameterDefaultValues(CrpeGetNParameterDefaultValues)
      (printJob, parameterFieldName, reportName);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterDefaultValue function                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterDefaultValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  index: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeGetNthParameterDefaultValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterDefaultValue := GetProcAddress(CRDEngine, 'PEGetNthParameterDefaultValue');
  if CrpeGetNthParameterDefaultValue = nil then
    CRDEngineError('PEGetNthParameterDefaultValue')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEGetNthParameterDefaultValue(CrpeGetNthParameterDefaultValue)
      (printJob, parameterFieldName, reportName, index, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthParameterDefaultValue function                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthParameterDefaultValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  index: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeSetNthParameterDefaultValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthParameterDefaultValue := GetProcAddress(CRDEngine, 'PESetNthParameterDefaultValue');
  if CrpeSetNthParameterDefaultValue = nil then
    CRDEngineError('PESetNthParameterDefaultValue')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPESetNthParameterDefaultValue(CrpeSetNthParameterDefaultValue)
      (printJob, parameterFieldName, reportName, index, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddParameterDefaultValue function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddParameterDefaultValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var valueInfo: PEValueInfo): Bool;
var
  CrpeAddParameterDefaultValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddParameterDefaultValue := GetProcAddress(CRDEngine, 'PEAddParameterDefaultValue');
  if CrpeAddParameterDefaultValue = nil then
    CRDEngineError('PEAddParameterDefaultValue')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEAddParameterDefaultValue(CrpeAddParameterDefaultValue)
      (printJob, parameterFieldName, reportName, valueInfo);
  end;
end;
{------------------------------------------------------------------------------}
{ PEDeleteNthParameterDefaultValue function                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteNthParameterDefaultValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  index: Smallint): Bool;
var
  CrpeDeleteNthParameterDefaultValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteNthParameterDefaultValue := GetProcAddress(CRDEngine, 'PEDeleteNthParameterDefaultValue');
  if CrpeDeleteNthParameterDefaultValue = nil then
    CRDEngineError('PEDeleteNthParameterDefaultValue')
  else
    Result := TPEDeleteNthParameterDefaultValue(CrpeDeleteNthParameterDefaultValue)
      (printJob, parameterFieldName, reportName, index);
end;

{------------------------------------------------------------------------------}
{ PEGetParameterMinMaxValue function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetParameterMinMaxValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var valueMin: PEValueInfo; var valueMax: PEValueInfo): Bool;
var
  CrpeGetParameterMinMaxValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetParameterMinMaxValue := GetProcAddress(CRDEngine, 'PEGetParameterMinMaxValue');
  if CrpeGetParameterMinMaxValue = nil then
    CRDEngineError('PEGetParameterMinMaxValue')
  else
  begin
    valueMin.structSize := SizeOf(PEValueInfo);
    valueMax.structSize := SizeOf(PEValueInfo);
    Result := TPEGetParameterMinMaxValue(CrpeGetParameterMinMaxValue)
      (printJob, parameterFieldName, reportName, valueMin, valueMax);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetParameterMinMaxValue function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetParameterMinMaxValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var valueMin: PEValueInfo; var valueMax: PEValueInfo): Bool;
var
  CrpeSetParameterMinMaxValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetParameterMinMaxValue := GetProcAddress(CRDEngine, 'PESetParameterMinMaxValue');
  if CrpeSetParameterMinMaxValue = nil then
    CRDEngineError('PESetParameterMinMaxValue')
  else
  begin
    valueMin.structSize := SizeOf(PEValueInfo);
    valueMax.structSize := SizeOf(PEValueInfo);
    Result := TPESetParameterMinMaxValue(CrpeSetParameterMinMaxValue)
      (printJob, parameterFieldName, reportName, valueMin, valueMax);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterValueDescription function                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterValueDescription (printJob: Smallint;
  parameterFieldName: PChar; reportName: PChar; index: Smallint;
  var valueDesc: HWnd; var valueDescLength: Smallint): Bool;
var
  CrpeGetNthParameterValueDescription : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterValueDescription := GetProcAddress(CRDEngine, 'PEGetNthParameterValueDescription');
  if CrpeGetNthParameterValueDescription = nil then
    CRDEngineError('PEGetNthParameterValueDescription')
  else
    Result := TPEGetNthParameterValueDescription(CrpeGetNthParameterValueDescription)
      (printJob, parameterFieldName, reportName, index, valueDesc, valueDescLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthParameterValueDescription function                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthParameterValueDescription (printJob: Smallint;
  parameterFieldName: PChar; reportName: PChar; index: Smallint;
  valueDesc: PChar): Bool;
var
  CrpeSetNthParameterValueDescription : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthParameterValueDescription := GetProcAddress(CRDEngine, 'PESetNthParameterValueDescription');
  if CrpeSetNthParameterValueDescription = nil then
    CRDEngineError('PESetNthParameterValueDescription')
  else
    Result := TPESetNthParameterValueDescription(CrpeSetNthParameterValueDescription)
      (printJob, parameterFieldName, reportName, index, valueDesc);
end;

{------------------------------------------------------------------------------}
{ PEGetParameterPickListOption function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetParameterPickListOption (printJob: Smallint;
  parameterFieldName: PChar; reportName: PChar;
  var pickListOption: PEParameterPickListOption): Bool;
var
  CrpeGetParameterPickListOption : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetParameterPickListOption := GetProcAddress(CRDEngine, 'PEGetParameterPickListOption');
  if CrpeGetParameterPickListOption = nil then
    CRDEngineError('PEGetParameterPickListOption')
  else
  begin
    pickListOption.structSize := SizeOf(PEParameterPickListOption);
    Result := TPEGetParameterPickListOption(CrpeGetParameterPickListOption)
      (printJob, parameterFieldName, reportName, pickListOption);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetParameterPickListOption function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetParameterPickListOption (printJob: Smallint;
  parameterFieldName: PChar; reportName: PChar;
  var pickListOption: PEParameterPickListOption): Bool;
var
  CrpeSetParameterPickListOption : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetParameterPickListOption := GetProcAddress(CRDEngine, 'PESetParameterPickListOption');
  if CrpeSetParameterPickListOption = nil then
    CRDEngineError('PESetParameterPickListOption')
  else
  begin
    pickListOption.structSize := SizeOf(PEParameterPickListOption);
    Result := TPESetParameterPickListOption(CrpeSetParameterPickListOption)
      (printJob, parameterFieldName, reportName, pickListOption);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetParameterValueInfo function                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetParameterValueInfo (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var valueInfo: PEParameterValueInfo): Bool;
var
  CrpeGetParameterValueInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetParameterValueInfo := GetProcAddress(CRDEngine, 'PEGetParameterValueInfo');
  if CrpeGetParameterValueInfo = nil then
    CRDEngineError('PEGetParameterValueInfo')
  else
  begin
    valueInfo.structSize := SizeOf(PEParameterValueInfo);
    Result := TPEGetParameterValueInfo(CrpeGetParameterValueInfo)
      (printJob, parameterFieldName, reportName, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetParameterValueInfo function                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetParameterValueInfo (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var valueInfo: PEParameterValueInfo): Bool;
var
  CrpeSetParameterValueInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetParameterValueInfo := GetProcAddress(CRDEngine, 'PESetParameterValueInfo');
  if CrpeSetParameterValueInfo = nil then
    CRDEngineError('PESetParameterValueInfo')
  else
  begin
    valueInfo.structSize := SizeOf(PEParameterValueInfo);
    Result := TPESetParameterValueInfo(CrpeSetParameterValueInfo)
      (printJob, parameterFieldName, reportName, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNParameterCurrentValues function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNParameterCurrentValues (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar): Smallint;
var
  CrpeGetNParameterCurrentValues : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNParameterCurrentValues := GetProcAddress(CRDEngine, 'PEGetNParameterCurrentValues');
  if CrpeGetNParameterCurrentValues = nil then
    CRDEngineError('PEGetNParameterCurrentValues')
  else
    Result := TPEGetNParameterCurrentValues(CrpeGetNParameterCurrentValues)
      (printJob, parameterFieldName, reportName);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterCurrentValue function                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterCurrentValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  index: Smallint; var currentValue: PEValueInfo): Bool;
var
  CrpeGetNthParameterCurrentValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterCurrentValue := GetProcAddress(CRDEngine, 'PEGetNthParameterCurrentValue');
  if CrpeGetNthParameterCurrentValue = nil then
    CRDEngineError('PEGetNthParameterCurrentValue')
  else
  begin
    currentValue.structSize := SizeOf(PEValueInfo);
    Result := TPEGetNthParameterCurrentValue(CrpeGetNthParameterCurrentValue)
      (printJob, parameterFieldName, reportName, index, currentValue);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddParameterCurrentValue function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddParameterCurrentValue (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var currentValue: PEValueInfo): Bool;
var
  CrpeAddParameterCurrentValue : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddParameterCurrentValue := GetProcAddress(CRDEngine, 'PEAddParameterCurrentValue');
  if CrpeAddParameterCurrentValue = nil then
    CRDEngineError('PEAddParameterCurrentValue')
  else
  begin
    currentValue.structSize := SizeOf(PEValueInfo);
    Result := TPEAddParameterCurrentValue(CrpeAddParameterCurrentValue)
      (printJob, parameterFieldName, reportName, currentValue);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddParameterCurrentValueW function                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddParameterCurrentValueW (printJob: Smallint;
  const parameterFieldName: PWChar; const reportName: PWChar;
  var currentValue: PEValueInfoW): Bool;
var
  CrpeAddParameterCurrentValueW : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddParameterCurrentValueW := GetProcAddress(CRDEngine, 'PEAddParameterCurrentValueW');
  if CrpeAddParameterCurrentValueW = nil then
    CRDEngineError('PEAddParameterCurrentValueW')
  else
  begin
    currentValue.structSize := SizeOf(PEValueInfoW);
    Result := TPEAddParameterCurrentValueW(CrpeAddParameterCurrentValueW)
      (printJob, parameterFieldName, reportName, currentValue);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNParameterCurrentRanges function                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNParameterCurrentRanges (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar): Smallint;
var
  CrpeGetNParameterCurrentRanges : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNParameterCurrentRanges := GetProcAddress(CRDEngine, 'PEGetNParameterCurrentRanges');
  if CrpeGetNParameterCurrentRanges = nil then
    CRDEngineError('PEGetNParameterCurrentRanges')
  else
    Result := TPEGetNParameterCurrentRanges(CrpeGetNParameterCurrentRanges)
      (printJob, parameterFieldName, reportName);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterCurrentRange function                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterCurrentRange (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  index: Smallint; var rangeStart: PEValueInfo;
  var rangeEnd: PEValueInfo; var rangeInfo: Smallint): Bool;
var
  CrpeGetNthParameterCurrentRange : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterCurrentRange := GetProcAddress(CRDEngine, 'PEGetNthParameterCurrentRange');
  if CrpeGetNthParameterCurrentRange = nil then
    CRDEngineError('PEGetNthParameterCurrentRange')
  else
  begin
    rangeStart.structSize := SizeOf(PEValueInfo);
    rangeEnd.structSize := SizeOf(PEValueInfo);
    Result := TPEGetNthParameterCurrentRange(CrpeGetNthParameterCurrentRange)
      (printJob, parameterFieldName, reportName, index, rangeStart,
       rangeEnd, rangeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddParameterCurrentRange function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddParameterCurrentRange (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar;
  var rangeStart: PEValueInfo; var rangeEnd: PEValueInfo;
  rangeInfo: Smallint): Bool;
var
  CrpeAddParameterCurrentRange : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddParameterCurrentRange := GetProcAddress(CRDEngine, 'PEAddParameterCurrentRange');
  if CrpeAddParameterCurrentRange = nil then
    CRDEngineError('PEAddParameterCurrentRange')
  else
  begin
    rangeStart.structSize := SizeOf(PEValueInfo);
    rangeEnd.structSize := SizeOf(PEValueInfo);
    Result := TPEAddParameterCurrentRange(CrpeAddParameterCurrentRange)
      (printJob, parameterFieldName, reportName, rangeStart,
       rangeEnd, rangeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddParameterCurrentRange function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddParameterCurrentRangeW (printJob: Smallint;
  const parameterFieldName: PWChar; const reportName: PWChar;
  var rangeStart: PEValueInfoW; var rangeEnd: PEValueInfoW;
  rangeInfo: Smallint): Bool;
var
  CrpeAddParameterCurrentRangeW : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddParameterCurrentRangeW := GetProcAddress(CRDEngine, 'PEAddParameterCurrentRangeW');
  if CrpeAddParameterCurrentRangeW = nil then
    CRDEngineError('PEAddParameterCurrentRangeW')
  else
  begin
    rangeStart.structSize := SizeOf(PEValueInfoW);
    rangeEnd.structSize := SizeOf(PEValueInfoW);
    Result := TPEAddParameterCurrentRangeW(CrpeAddParameterCurrentRangeW)
      (printJob, parameterFieldName, reportName, rangeStart,
       rangeEnd, rangeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEClearParameterCurrentValuesAndRanges function                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEClearParameterCurrentValuesAndRanges (printJob: Smallint;
  const parameterFieldName: PChar; const reportName: PChar): Bool;
var
  CrpeClearParameterCurrentValuesAndRanges : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeClearParameterCurrentValuesAndRanges := GetProcAddress(CRDEngine, 'PEClearParameterCurrentValuesAndRanges');
  if CrpeClearParameterCurrentValuesAndRanges = nil then
    CRDEngineError('PEClearParameterCurrentValuesAndRanges')
  else
    Result := TPEClearParameterCurrentValuesAndRanges(CrpeClearParameterCurrentValuesAndRanges)
      (printJob, parameterFieldName, reportName);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParameterType function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParameterType (printJob: Smallint; index: Smallint): Smallint;
var
  CrpeGetNthParameterType : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParameterType := GetProcAddress(CRDEngine, 'PEGetNthParameterType');
  if CrpeGetNthParameterType = nil then
    CRDEngineError('PEGetNthParameterType')
  else
    Result := TPEGetNthParameterType(CrpeGetNthParameterType)(printJob, index);
end;

{------------------------------------------------------------------------------}
{ PEGetNSortFields function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSortFields (printJob: Smallint): Smallint;
var
  CrpeGetNSortFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSortFields := GetProcAddress(CRDEngine, 'PEGetNSortFields');
  if CrpeGetNSortFields = nil then
    CRDEngineError('PEGetNSortFields')
  else
    Result := TPEGetNSortFields(CrpeGetNSortFields)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSortField function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSortField (printJob: Smallint; sortFieldN: Smallint;
  var nameHandle: HWnd; var nameLength : Smallint; var direction: Smallint): Bool;
var
  CrpeGetNthSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSortField := GetProcAddress(CRDEngine, 'PEGetNthSortField');
  if CrpeGetNthSortField = nil then
    CRDEngineError('PEGetNthSortField')
  else
    Result := TPEGetNthSortField(CrpeGetNthSortField)(printJob,
      sortFieldN, nameHandle, nameLength, direction);
end;

{------------------------------------------------------------------------------}
{ PESetNthSortField function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthSortField (printJob: Smallint; sortFieldN: Smallint;
  Name: PChar; direction: Smallint): Bool;
var
  CrpeSetNthSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthSortField := GetProcAddress(CRDEngine, 'PESetNthSortField');
  if CrpeSetNthSortField = nil then
    CRDEngineError('PESetNthSortField')
  else
    Result := TPESetNthSortField(CrpeSetNthSortField)(printJob,
      sortFieldN, Name, direction);
end;

{------------------------------------------------------------------------------}
{ PEDeleteNthSortField function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteNthSortField (printJob: Smallint; sortFieldN: Smallint): Bool;
var
  CrpeDeleteNthSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteNthSortField := GetProcAddress(CRDEngine, 'PEDeleteNthSortField');
  if CrpeDeleteNthSortField = nil then
    CRDEngineError('PEDeleteNthSortField')
  else
    Result := TPEDeleteNthSortField(CrpeDeleteNthSortField)(printJob, sortFieldN);
end;

{------------------------------------------------------------------------------}
{ PEGetNGroupSortFields function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNGroupSortFields (printJob : Smallint): Smallint;
var
  CrpeGetNGroupSortFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNGroupSortFields := GetProcAddress(CRDEngine, 'PEGetNGroupSortFields');
  if CrpeGetNGroupSortFields = nil then
    CRDEngineError('PEGetNGroupSortFields')
  else
    Result := TPEGetNGroupSortFields(CrpeGetNGroupSortFields)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthGroupSortField function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthGroupSortField (printJob: Smallint; sortFieldN: Smallint;
  var nameHandle: HWnd; var nameLength: Smallint; var direction: Smallint): Bool;
var
  CrpeGetNthGroupSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthGroupSortField := GetProcAddress(CRDEngine, 'PEGetNthGroupSortField');
  if CrpeGetNthGroupSortField = nil then
    CRDEngineError('PEGetNthGroupSortField')
  else
    Result := TPEGetNthGroupSortField(CrpeGetNthGroupSortField)(printJob,
      sortFieldN, nameHandle, nameLength, direction);
end;

{------------------------------------------------------------------------------}
{ PESetNthGroupSortField function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthGroupSortField (printJob: Smallint; sortFieldN: Smallint;
  Name: PChar; direction: Smallint): Bool;
var
  CrpeSetNthGroupSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthGroupSortField := GetProcAddress(CRDEngine, 'PESetNthGroupSortField');
  if CrpeSetNthGroupSortField = nil then
    CRDEngineError('PESetNthGroupSortField')
  else
    Result := TPESetNthGroupSortField(CrpeSetNthGroupSortField)(printJob,
      sortFieldN, Name, direction);
end;

{------------------------------------------------------------------------------}
{ PEDeleteNthGroupSortField function                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteNthGroupSortField (printJob: Smallint; sortFieldN: Smallint): Bool;
var
  CrpeDeleteNthGroupSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteNthGroupSortField := GetProcAddress(CRDEngine, 'PEDeleteNthGroupSortField');
  if CrpeDeleteNthGroupSortField = nil then
    CRDEngineError('PEDeleteNthGroupSortField')
  else
    Result := TPEDeleteNthGroupSortField(CrpeDeleteNthGroupSortField)
      (printJob, sortFieldN);
end;

{------------------------------------------------------------------------------}
{ PEGetNTables function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNTables (printJob: Smallint): Smallint;
var
  CrpeGetNTables : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNTables := GetProcAddress(CRDEngine, 'PEGetNTables');
  if CrpeGetNTables = nil then
    CRDEngineError('PEGetNTables')
  else
    Result := TPEGetNTables(CrpeGetNTables)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthTableType function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTableType (printJob: Smallint; tableN: Smallint;
  var tableType: PETableType): Bool;
var
  CrpeGetNthTableType : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTableType := GetProcAddress(CRDEngine, 'PEGetNthTableType');
  if CrpeGetNthTableType = nil then
    CRDEngineError('PEGetNthTableType')
  else
  begin
    tableType.structSize := SizeOf(PETableType);
    Result := TPEGetNthTableType(CrpeGetNthTableType)(printJob,
      tableN, tableType);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthTableSessionInfo function                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTableSessionInfo (printJob: Smallint;
  tableN: Smallint; var sessionInfo: PESessionInfo): Bool;
var
  CrpeGetNthTableSessionInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTableSessionInfo := GetProcAddress(CRDEngine, 'PEGetNthTableSessionInfo');
  if CrpeGetNthTableSessionInfo = nil then
    CRDEngineError('PEGetNthTableSessionInfo')
  else
  begin
    sessionInfo.structSize := SizeOf(PESessionInfo);
    Result := TPEGetNthTableSessionInfo(CrpeGetNthTableSessionInfo)(printJob,
      tableN, sessionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthTableSessionInfo function                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTableSessionInfo (printJob: Smallint;
  tableN: Smallint; var sessionInfo: PESessionInfo;
  propagateAcrossTables : Bool): Bool;
var
  CrpeSetNthTableSessionInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTableSessionInfo := GetProcAddress(CRDEngine, 'PESetNthTableSessionInfo');
  if CrpeSetNthTableSessionInfo = nil then
    CRDEngineError('PESetNthTableSessionInfo')
  else
  begin
    sessionInfo.structSize := SizeOf(PESessionInfo);
    Result := TPESetNthTableSessionInfo(CrpeSetNthTableSessionInfo)
      (printJob, tableN, sessionInfo, propagateAcrossTables);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthTableLogOnInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTableLogOnInfo (printJob: Smallint;
  tableN: Smallint; var logOnInfo: PELogOnInfo): Bool;
var
  CrpeGetNthTableLogOnInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTableLogOnInfo := GetProcAddress(CRDEngine, 'PEGetNthTableLogOnInfo');
  if CrpeGetNthTableLogOnInfo = nil then
    CRDEngineError('PEGetNthTableLogOnInfo')
  else
  begin
    logOnInfo.structSize := SizeOf(PELogOnInfo);
    Result := TPEGetNthTableLogOnInfo(CrpeGetNthTableLogOnInfo)
      (printJob, tableN, logOnInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthTableLogOnInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTableLogOnInfo (printJob: Smallint; tableN: Smallint;
  var logOnInfo: PELogOnInfo; propagateAcrossTables: Bool): Bool;
var
  CrpeSetNthTableLogOnInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTableLogOnInfo := GetProcAddress(CRDEngine, 'PESetNthTableLogOnInfo');
  if CrpeSetNthTableLogOnInfo = nil then
    CRDEngineError('PESetNthTableLogOnInfo')
  else
  begin
    logOnInfo.structSize := SizeOf(PELogOnInfo);
    Result := TPESetNthTableLogOnInfo(CrpeSetNthTableLogOnInfo)
      (printJob, tableN, logOnInfo, propagateAcrossTables);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthTableLocation function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTableLocation (printJob: Smallint; tableN: Smallint;
  var location: PETableLocation): Bool;
var
  CrpeGetNthTableLocation : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTableLocation := GetProcAddress(CRDEngine, 'PEGetNthTableLocation');
  if CrpeGetNthTableLocation = nil then
    CRDEngineError('PEGetNthTableLocation')
  else
  begin
    location.StructSize := SizeOf(PETableLocation);
    Result := TPEGetNthTableLocation(CrpeGetNthTableLocation)
      (printJob, tableN, location);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthTableLocation function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTableLocation (printJob: Smallint; tableN: Smallint;
  var location: PETableLocation): Bool;
var
  CrpeSetNthTableLocation : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTableLocation := GetProcAddress(CRDEngine, 'PESetNthTableLocation');
  if CrpeSetNthTableLocation = nil then
    CRDEngineError('PESetNthTableLocation')
  else
  begin
    location.StructSize := SizeOf(PETableLocation);
    Result := TPESetNthTableLocation(CrpeSetNthTableLocation)
      (printJob, tableN, location);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthTablePrivateInfo function                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTablePrivateInfo (printJob: Smallint;
  tableN: Smallint; var privateInfo: PETablePrivateInfo): Bool;
var
  CrpeGetNthTablePrivateInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTablePrivateInfo := GetProcAddress(CRDEngine, 'PEGetNthTablePrivateInfo');
  if CrpeGetNthTablePrivateInfo = nil then
    CRDEngineError('PEGetNthTablePrivateInfo')
  else
  begin
    privateInfo.structSize := SizeOf(PETablePrivateInfo);
    Result := TPEGetNthTablePrivateInfo(CrpeGetNthTablePrivateInfo)
      (printJob, tableN, privateInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthTablePrivateInfo function                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTablePrivateInfo (printJob: Smallint;
  tableN: Smallint; var privateInfo: PETablePrivateInfo): Bool;
var
  CrpeSetNthTablePrivateInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTablePrivateInfo := GetProcAddress(CRDEngine, 'PESetNthTablePrivateInfo');
  if CrpeSetNthTablePrivateInfo = nil then
    CRDEngineError('PESetNthTablePrivateInfo')
  else
  begin
    privateInfo.structSize := SizeOf(PETablePrivateInfo);
    Result := TPESetNthTablePrivateInfo(CrpeSetNthTablePrivateInfo)
      (printJob, tableN, privateInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PETestNthTableConnectivity function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PETestNthTableConnectivity (printJob: Smallint; tableN: Smallint): Bool;
var
  CrpeTestNthTableConnectivity : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeTestNthTableConnectivity := GetProcAddress(CRDEngine, 'PETestNthTableConnectivity');
  if CrpeTestNthTableConnectivity = nil then
    CRDEngineError('PETestNthTableConnectivity')
  else
    Result := TPETestNthTableConnectivity(CrpeTestNthTableConnectivity)
      (printJob, tableN);
end;

{------------------------------------------------------------------------------}
{ PELogOnServer function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PELogOnServer (dllName: PChar; var logOnInfo: PELogOnInfo): Bool;
var
  CrpeLogOnServer : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeLogOnServer := GetProcAddress(CRDEngine, 'PELogOnServer');
  if CrpeLogOnServer = nil then
    CRDEngineError('PELogOnServer')
  else
  begin
    logOnInfo.structSize := SizeOf(PELogOnInfo);
    Result := TPELogOnServer(CrpeLogOnServer)(dllName, logOnInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PELogOffServer function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PELogOffServer (dllName: PChar; var logOnInfo: PELogOnInfo): Bool;
var
  CrpeLogOffServer : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeLogOffServer := GetProcAddress(CRDEngine, 'PELogOffServer');
  if CrpeLogOffServer = nil then
    CRDEngineError('PELogOffServer')
  else
  begin
    logOnInfo.structSize := SizeOf(PELogOnInfo);
    Result := TPELogOffServer(CrpeLogOffServer)(dllName, logOnInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PELogOnSQLServerWithPrivateInfo function                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PELogOnSQLServerWithPrivateInfo (dllName: PChar;
  privateInfo: Pointer): Bool;
var
  CrpeLogOnSQLServerWithPrivateInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeLogOnSQLServerWithPrivateInfo := GetProcAddress(CRDEngine, 'PELogOnSQLServerWithPrivateInfo');
  if CrpeLogOnSQLServerWithPrivateInfo = nil then
    CRDEngineError('PELogOnSQLServerWithPrivateInfo')
  else
    Result := TPELogOnSQLServerWithPrivateInfo(CrpeLogOnSQLServerWithPrivateInfo)(dllName, privateInfo);
end;

{------------------------------------------------------------------------------}
{ PEVerifyDatabase function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEVerifyDatabase (printJob : Smallint): Bool;
var
  CrpeVerifyDatabase : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeVerifyDatabase := GetProcAddress(CRDEngine, 'PEVerifyDatabase');
  if CrpeVerifyDatabase = nil then
    CRDEngineError('PEVerifyDatabase')
  else
    Result := TPEVerifyDatabase(CrpeVerifyDatabase)(printJob);
end;

{------------------------------------------------------------------------------}
{ PECheckNthTableDifferences function                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PECheckNthTableDifferences (printJob: Smallint;
  tableN: Smallint; var tableDifferenceInfo: PETableDifferenceInfo): Bool;
var
  CrpeCheckNthTableDifferences : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCheckNthTableDifferences := GetProcAddress(CRDEngine, 'PECheckNthTableDifferences');
  if CrpeCheckNthTableDifferences = nil then
    CRDEngineError('PECheckNthTableDifferences')
  else
  begin
    tableDifferenceInfo.StructSize := SizeOf(PETableDifferenceInfo);
    Result := TPECheckNthTableDifferences(CrpeCheckNthTableDifferences)
      (printJob, tableN, tableDifferenceInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetSQLQuery function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSQLQuery (printJob: Smallint; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetSQLQuery : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSQLQuery := GetProcAddress(CRDEngine, 'PEGetSQLQuery');
  if CrpeGetSQLQuery = nil then
    CRDEngineError('PEGetSQLQuery')
  else
    Result := TPEGetSQLQuery(CrpeGetSQLQuery)(printJob, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetSQLQuery function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetSQLQuery (printJob: Smallint; queryString: PChar): Bool;
var
  CrpeSetSQLQuery : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetSQLQuery := GetProcAddress(CRDEngine, 'PESetSQLQuery');
  if CrpeSetSQLQuery = nil then
    CRDEngineError('PESetSQLQuery')
  else
    Result := TPESetSQLQuery(CrpeSetSQLQuery)(printJob, queryString);
end;

{------------------------------------------------------------------------------}
{ PEHasSavedData function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEHasSavedData (printJob: Smallint; var hasSavedData: Bool): Bool;
var
  CrpeHasSavedData : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeHasSavedData := GetProcAddress(CRDEngine, 'PEHasSavedData');
  if CrpeHasSavedData = nil then
    CRDEngineError('PEHasSavedData')
  else
    Result := TPEHasSavedData(CrpeHasSavedData)(printJob, hasSavedData);
end;

{------------------------------------------------------------------------------}
{ PEDiscardSavedData function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDiscardSavedData (printJob : Smallint): Bool;
var
  CrpeDiscardSavedData : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDiscardSavedData := GetProcAddress(CRDEngine, 'PEDiscardSavedData');
  if CrpeDiscardSavedData = nil then
    CRDEngineError('PEDiscardSavedData')
  else
    Result := TPEDiscardSavedData(CrpeDiscardSavedData)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetReportTitle function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReportTitle (printJob: Smallint; var titleHandle: HWnd;
  var titleLength: Smallint): Bool;
var
  CrpeGetReportTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReportTitle := GetProcAddress(CRDEngine, 'PEGetReportTitle');
  if CrpeGetReportTitle = nil then
    CRDEngineError('PEGetReportTitle')
  else
    Result := TPEGetReportTitle(CrpeGetReportTitle)(printJob,
      titleHandle, titleLength);
end;

{------------------------------------------------------------------------------}
{ PESetReportTitle function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetReportTitle (printJob: Smallint; title: PChar): Bool;
var
  CrpeSetReportTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetReportTitle := GetProcAddress(CRDEngine, 'PESetReportTitle');
  if CrpeSetReportTitle = nil then
    CRDEngineError('PESetReportTitle')
  else
    Result := TPESetReportTitle(CrpeSetReportTitle)(printJob, title);
end;

{------------------------------------------------------------------------------}
{ PEOutputToWindow function                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOutputToWindow (printJob: Smallint; title: PChar; left: DWord;
  top: DWord; width: DWord; height: DWord; style: DWord; parentWindow: HWnd): Bool;
var
  CrpeOutputToWindow : TFarProc;
  WinHandle          : HWnd;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeOutputToWindow := GetProcAddress(CRDEngine, 'PEOutputToWindow');
  if CrpeOutputToWindow = nil then
    CRDEngineError('PEOutputToWindow')
  else
  begin
    WinHandle := parentWindow;
    Result := TPEOutputToWindow(CrpeOutputToWindow)(printJob, title,
      left, top, width, height, style, WinHandle);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetWindowHandle function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetWindowHandle (printJob: Smallint): HWnd;
var
  CrpeGetWindowHandle : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetWindowHandle := GetProcAddress(CRDEngine, 'PEGetWindowHandle');
  if CrpeGetWindowHandle = nil then
    CRDEngineError('PEGetWindowHandle')
  else
    Result := TPEGetWindowHandle(CrpeGetWindowHandle)(printJob);
end;

{------------------------------------------------------------------------------}
{ PECloseWindow procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.PECloseWindow (printJob: Smallint);
var
  CrpeCloseWindow : TFarProc;
begin
  CRDEngineError('');
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeCloseWindow := GetProcAddress(CRDEngine, 'PECloseWindow');
  if CrpeCloseWindow = nil then
    CRDEngineError('PECloseWindow')
  else
    TPECloseWindow(CrpeCloseWindow)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetWindowOptions function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetWindowOptions (printJob: Smallint; var options: PEWindowOptions): Bool;
var
  CrpeGetWindowOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetWindowOptions := GetProcAddress(CRDEngine, 'PEGetWindowOptions');
  if CrpeGetWindowOptions = nil then
    CRDEngineError('PEGetWindowOptions')
  else
  begin
    options.structSize := SizeOf(PEWindowOptions);
    Result := TPEGetWindowOptions(CrpeGetWindowOptions)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetWindowOptions function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetWindowOptions (printJob: Smallint; var options: PEWindowOptions): Bool;
var
  CrpeSetWindowOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetWindowOptions := GetProcAddress(CRDEngine, 'PESetWindowOptions');
  if CrpeSetWindowOptions = nil then
    CRDEngineError('PESetWindowOptions')
  else
  begin
    options.structSize := SizeOf(PEWindowOptions);
    Result := TPESetWindowOptions(CrpeSetWindowOptions)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEShowPrintControls function                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowPrintControls (printJob: Smallint; showPrintControls: Bool): Bool;
var
  CrpeShowPrintControls : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowPrintControls := GetProcAddress(CRDEngine, 'PEShowPrintControls');
  if CrpeShowPrintControls = nil then
    CRDEngineError('PEShowPrintControls')
  else
    Result := TPEShowPrintControls(CrpeShowPrintControls)
      (printJob, showPrintControls);
end;

{------------------------------------------------------------------------------}
{ PEPrintControlsShowing function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEPrintControlsShowing (printJob: Smallint; var controlsShowing: Bool): Bool;
var
  CrpePrintControlsShowing : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpePrintControlsShowing := GetProcAddress(CRDEngine, 'PEPrintControlsShowing');
  if CrpePrintControlsShowing = nil then
    CRDEngineError('PEPrintControlsShowing')
  else
    Result := TPEPrintControlsShowing(CrpePrintControlsShowing)
      (printJob, controlsShowing);
end;

{------------------------------------------------------------------------------}
{ PEShowFirstPage function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowFirstPage (printJob: Smallint): Bool;
var
  CrpeShowFirstPage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowFirstPage := GetProcAddress(CRDEngine, 'PEShowFirstPage');
  if CrpeShowFirstPage = nil then
    CRDEngineError('PEShowFirstPage')
  else
    Result := TPEShowFirstPage(CrpeShowFirstPage)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEShowNextPage function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowNextPage (printJob: Smallint): Bool;
var
  CrpeShowNextPage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowNextPage := GetProcAddress(CRDEngine, 'PEShowNextPage');
  if CrpeShowNextPage = nil then
    CRDEngineError('PEShowNextPage')
  else
    Result := TPEShowNextPage(CrpeShowNextPage)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEShowPreviousPage function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowPreviousPage (printJob: Smallint): Bool;
var
  CrpeShowPreviousPage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowPreviousPage := GetProcAddress(CRDEngine, 'PEShowPreviousPage');
  if CrpeShowPreviousPage = nil then
    CRDEngineError('PEShowPreviousPage')
  else
    Result := TPEShowPreviousPage(CrpeShowPreviousPage)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEShowLastPage function                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowLastPage (printJob: Smallint): Bool;
var
  CrpeShowLastPage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowLastPage := GetProcAddress(CRDEngine, 'PEShowLastPage');
  if CrpeShowLastPage = nil then
    CRDEngineError('PEShowLastPage')
  else
    Result := TPEShowLastPage(CrpeShowLastPage)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNPages function                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNPages (printJob: Smallint): Smallint;
var
  CrpeGetNPages : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNPages := GetProcAddress(CRDEngine, 'PEGetNPages');
  if CrpeGetNPages = nil then
    CRDEngineError('PEGetNPages')
  else
    Result := TPEGetNPages(CrpeGetNPages)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEShowNthPage function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEShowNthPage (printJob: Smallint; pageN: Smallint): Bool;
var
  CrpeShowNthPage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeShowNthPage := GetProcAddress(CRDEngine, 'PEShowNthPage');
  if CrpeShowNthPage = nil then
    CRDEngineError('PEShowNthPage')
  else
    Result := TPEShowNthPage(CrpeShowNthPage)(printJob, pageN);
end;

{------------------------------------------------------------------------------}
{ PEZoomPreviewWindow function                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEZoomPreviewWindow (printJob: Smallint; level: Smallint): Bool;
var
  CrpeZoomPreviewWindow : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeZoomPreviewWindow := GetProcAddress(CRDEngine, 'PEZoomPreviewWindow');
  if CrpeZoomPreviewWindow = nil then
    CRDEngineError('PEZoomPreviewWindow')
  else
    Result := TPEZoomPreviewWindow(CrpeZoomPreviewWindow)(printJob, level);
end;

{------------------------------------------------------------------------------}
{ PENextPrintWindowMagnification function                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PENextPrintWindowMagnification (printJob:  Smallint): Bool;
var
  CrpeNextPrintWindowMagnification : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeNextPrintWindowMagnification := GetProcAddress(CRDEngine, 'PENextPrintWindowMagnification');
  if CrpeNextPrintWindowMagnification = nil then
    CRDEngineError('PENextPrintWindowMagnification')
  else
    Result := TPENextPrintWindowMagnification(CrpeNextPrintWindowMagnification)
      (printJob);
end;

{------------------------------------------------------------------------------}
{ PEPrintWindow function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEPrintWindow (printJob: Smallint; waitUntilDone: Bool): Bool;
var
  CrpePrintWindow : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpePrintWindow := GetProcAddress(CRDEngine, 'PEPrintWindow');
  if CrpePrintWindow = nil then
    CRDEngineError('PEPrintWindow')
  else
    Result := TPEPrintWindow(CrpePrintWindow)(printJob, waitUntilDone);
end;

{------------------------------------------------------------------------------}
{ PEExportPrintWindow function                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEExportPrintWindow (printJob: Smallint; toMail: Bool;
  waitUntilDone: Bool): Bool;
var
  CrpeExportPrintWindow : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeExportPrintWindow := GetProcAddress(CRDEngine, 'PEExportPrintWindow');
  if CrpeExportPrintWindow = nil then
    CRDEngineError('PEExportPrintWindow')
  else
    Result := TPEExportPrintWindow(CrpeExportPrintWindow)
      (printJob, toMail, waitUntilDone);
end;

{------------------------------------------------------------------------------}
{ PEOutputToPrinter function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEOutputToPrinter (printJob: Smallint; nCopies: Smallint): Bool;
var
  CrpeOutputToPrinter : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeOutputToPrinter := GetProcAddress(CRDEngine, 'PEOutputToPrinter');
  if CrpeOutputToPrinter = nil then
    CRDEngineError('PEOutputToPrinter')
  else
    Result := TPEOutputToPrinter(CrpeOutputToPrinter)(printJob, nCopies);
end;

{------------------------------------------------------------------------------}
{ PESelectPrinter function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESelectPrinter (printJob: Smallint; driverName: PChar;
  printerName: PChar; portName: PChar; mode: PDevMode): Bool;
var
  CrpeSelectPrinter : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSelectPrinter := GetProcAddress(CRDEngine, 'PESelectPrinter');
  if CrpeSelectPrinter = nil then
    CRDEngineError('PESelectPrinter')
  else
    Result := TPESelectPrinter(CrpeSelectPrinter)(printJob, driverName,
      printerName, portName, mode);
end;

{------------------------------------------------------------------------------}
{ PESelectPrinterW function                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESelectPrinterW (printJob: Smallint; driverName: PWChar;
  printerName: PWChar; portName: PWChar; mode: PDeviceModeW): Bool;
var
  CrpeSelectPrinterW : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSelectPrinterW := GetProcAddress(CRDEngine, 'PESelectPrinterW');
  if CrpeSelectPrinterW = nil then
    CRDEngineError('PESelectPrinterW')
  else
    Result := TPESelectPrinterW(CrpeSelectPrinterW)(printJob, driverName,
      printerName, portName, mode);
end;

{------------------------------------------------------------------------------}
{ PEGetSelectedPrinter function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSelectedPrinter (printJob: Smallint; var driverHandle: Hwnd;
  var driverLength: Smallint; var printerHandle: Hwnd; var printerLength: Smallint;
  var portHandle: Hwnd; var portLength: Smallint; var mode: PDevMode): Bool;
var
  CrpeGetSelectedPrinter : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSelectedPrinter := GetProcAddress(CRDEngine, 'PEGetSelectedPrinter');
  if CrpeGetSelectedPrinter = nil then
    CRDEngineError('PEGetSelectedPrinter')
  else
    Result := TPEGetSelectedPrinter(CrpeGetSelectedPrinter)(printJob,
      driverHandle, driverLength, printerHandle, printerLength,
      portHandle, portLength, mode);
end;

{------------------------------------------------------------------------------}
{ PEGetNDetailCopies function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNDetailCopies (printJob: Smallint; var nCopies: Smallint): Bool;
var
  CrpeGetNDetailCopies : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNDetailCopies := GetProcAddress(CRDEngine, 'PEGetNDetailCopies');
  if CrpeGetNDetailCopies = nil then
    CRDEngineError('PEGetNDetailCopies')
  else
    Result := TPEGetNDetailCopies(CrpeGetNDetailCopies)(printJob, nCopies);
end;

{------------------------------------------------------------------------------}
{ PESetNDetailCopies function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNDetailCopies (printJob: Smallint; nCopies: Smallint): Bool;
var
  CrpeSetNDetailCopies : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNDetailCopies := GetProcAddress(CRDEngine, 'PESetNDetailCopies');
  if CrpeSetNDetailCopies = nil then
    CRDEngineError('PESetNDetailCopies')
  else
    Result := TPESetNDetailCopies(CrpeSetNDetailCopies)(printJob, nCopies);
end;

{------------------------------------------------------------------------------}
{ PEGetPrintOptions function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetPrintOptions (printJob: Smallint; var options: PEPrintOptions): Bool;
var
  CrpeGetPrintOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetPrintOptions := GetProcAddress(CRDEngine, 'PEGetPrintOptions');
  if CrpeGetPrintOptions = nil then
    CRDEngineError('PEGetPrintOptions')
  else
  begin
    options.StructSize := SizeOf(PEPrintOptions);
    Result := TPEGetPrintOptions(CrpeGetPrintOptions)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetPrintOptions function                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetPrintOptions (printJob: Smallint; var options: PEPrintOptions): Bool;
var
  CrpeSetPrintOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetPrintOptions := GetProcAddress(CRDEngine, 'PESetPrintOptions');
  if CrpeSetPrintOptions = nil then
    CRDEngineError('PESetPrintOptions')
  else
  begin
    if Addr(options) <> nil then
    begin
      options.StructSize := SizeOf(PEPrintOptions);
    end;
    Result := TPESetPrintOptions(CrpeSetPrintOptions)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetExportOptions function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetExportOptions (printJob: Smallint; var options: PEExportOptions): Bool;
var
  CrpeGetExportOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetExportOptions := GetProcAddress(CRDEngine, 'PEGetExportOptions');
  if CrpeGetExportOptions = nil then
    CRDEngineError('PEGetExportOptions')
  else
  begin
    options.structSize := SizeOf(PEExportOptions);
    Result := TPEGetExportOptions(CrpeGetExportOptions)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetExportOptionsW function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetExportOptionsW (printJob: Smallint; var options: PEExportOptionsW): Bool;
var
  CrpeGetExportOptionsW : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetExportOptionsW := GetProcAddress(CRDEngine, 'PEGetExportOptionsW');
  if CrpeGetExportOptionsW = nil then
    CRDEngineError('PEGetExportOptionsW')
  else
  begin
    options.structSize := SizeOf(PEExportOptionsW);
    Result := TPEGetExportOptionsW(CrpeGetExportOptionsW)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEExportTo function                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEExportTo (printJob: Smallint; var options: PEExportOptions): Bool;
var
  CrpeExportTo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeExportTo := GetProcAddress(CRDEngine, 'PEExportTo');
  if CrpeExportTo = nil then
    CRDEngineError('PEExportTo')
  else
  begin
    options.structSize := SizeOf(PEExportOptions);
    Result := TPEExportTo(CrpeExportTo)(printJob, options);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetMargins function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMargins (printJob: Smallint; var left: Word;
  var right: Word; var top: Word; var bottom: Word): Bool;
var
  CrpeGetMargins : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMargins := GetProcAddress(CRDEngine, 'PEGetMargins');
  if CrpeGetMargins = nil then
    CRDEngineError('PEGetMargins')
  else
    Result := TPEGetMargins(CrpeGetMargins)(printJob, left, right,
      top, bottom);
end;

{------------------------------------------------------------------------------}
{ PESetMargins function                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMargins (printJob: Smallint; left: Word; right: Word;
  top: Word; bottom: Word): Bool;
var
  CrpeSetMargins : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMargins := GetProcAddress(CRDEngine, 'PESetMargins');
  if CrpeSetMargins = nil then
    CRDEngineError('PESetMargins')
  else
    Result := TPESetMargins(CrpeSetMargins)(printJob, left, right,
      top, bottom);
end;

{------------------------------------------------------------------------------}
{ PEGetReportSummaryInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReportSummaryInfo (printJob: Smallint;
  var summaryInfo: PEReportSummaryInfo): Bool;
var
  CrpeGetReportSummaryInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReportSummaryInfo := GetProcAddress(CRDEngine, 'PEGetReportSummaryInfo');
  if CrpeGetReportSummaryInfo = nil then
    CRDEngineError('PEGetReportSummaryInfo')
  else
  begin
    summaryInfo.structSize := SizeOf(PEReportSummaryInfo);
    Result := TPEGetReportSummaryInfo(CrpeGetReportSummaryInfo)
      (printJob, summaryInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetReportSummaryInfo function                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetReportSummaryInfo (printJob: Smallint;
  var summaryInfo: PEReportSummaryInfo): Bool;
var
  CrpeSetReportSummaryInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetReportSummaryInfo := GetProcAddress(CRDEngine, 'PESetReportSummaryInfo');
  if CrpeSetReportSummaryInfo = nil then
    CRDEngineError('PESetReportSummaryInfo')
  else
  begin
    summaryInfo.structSize := SizeOf(PEReportSummaryInfo);
    Result := TPESetReportSummaryInfo(CrpeSetReportSummaryInfo)
      (printJob, summaryInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEEnableEvent function                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEEnableEvent (printJob: Smallint; var enableEventInfo: PEEnableEventInfo): Bool;
var
  CrpeEnableEvent : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeEnableEvent := GetProcAddress(CRDEngine, 'PEEnableEvent');
  if CrpeEnableEvent = nil then
    CRDEngineError('PEEnableEvent')
  else
  begin
    enableEventInfo.structSize := SizeOf(PEEnableEventInfo);
    Result := TPEEnableEvent(CrpeEnableEvent)(printJob, enableEventInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetEnableEventInfo function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetEnableEventInfo (printJob: Smallint;
  var enableEventInfo: PEEnableEventInfo): Bool;
var
  CrpeGetEnableEventInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetEnableEventInfo := GetProcAddress(CRDEngine, 'PEGetEnableEventInfo');
  if CrpeGetEnableEventInfo = nil then
    CRDEngineError('PEGetEnableEventInfo')
  else
  begin
    enableEventInfo.structSize := SizeOf(PEEnableEventInfo);
    Result := TPEGetEnableEventInfo(CrpeGetEnableEventInfo)
      (printJob, enableEventInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetEventCallback function                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetEventCallback (printJob: Smallint; callbackProc: Pointer;
  userData: Pointer): Bool;
var
  CrpeSetEventCallback : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetEventCallback := GetProcAddress(CRDEngine, 'PESetEventCallback');
  if CrpeSetEventCallback = nil then
    CRDEngineError('PESetEventCallback')
  else
    Result := TPESetEventCallback(CrpeSetEventCallback)
      (printJob, callbackProc, userData);
end;

{------------------------------------------------------------------------------}
{ PEGetFieldMappingType function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFieldMappingType (printJob: Smallint; var mappingType: Word): Bool;
var
  CrpeGetFieldMappingType : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFieldMappingType := GetProcAddress(CRDEngine, 'PEGetFieldMappingType');
  if CrpeGetFieldMappingType = nil then
    CRDEngineError('PEGetFieldMappingType')
  else
    Result := TPEGetFieldMappingType(CrpeGetFieldMappingType)
      (printJob, mappingType);
end;

{------------------------------------------------------------------------------}
{ PESetFieldMappingType function                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetFieldMappingType (printJob: Smallint; mappingType: Word): Bool;
var
  CrpeSetFieldMappingType : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetFieldMappingType := GetProcAddress(CRDEngine, 'PESetFieldMappingType');
  if CrpeSetFieldMappingType = nil then
    CRDEngineError('PESetFieldMappingType')
  else
    Result := TPESetFieldMappingType(CrpeSetFieldMappingType)
      (printJob, mappingType);
end;

{------------------------------------------------------------------------------}
{ PEGetTrackCursorInfo function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetTrackCursorInfo (printJob: Smallint; var cursorInfo: PETrackCursorInfo): Bool;
var
  CrpeGetTrackCursorInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetTrackCursorInfo := GetProcAddress(CRDEngine, 'PEGetTrackCursorInfo');
  if CrpeGetTrackCursorInfo = nil then
    CRDEngineError('PEGetTrackCursorInfo')
  else
  begin
    cursorInfo.structSize := SizeOf(PETrackCursorInfo);
    Result := TPEGetTrackCursorInfo(CrpeGetTrackCursorInfo)
      (printJob, cursorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetTrackCursorInfo function                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetTrackCursorInfo (printJob: Smallint; var cursorInfo: PETrackCursorInfo): Bool;
var
  CrpeSetTrackCursorInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetTrackCursorInfo := GetProcAddress(CRDEngine, 'PESetTrackCursorInfo');
  if CrpeSetTrackCursorInfo = nil then
    CRDEngineError('PESetTrackCursorInfo')
  else
  begin
    cursorInfo.structSize := SizeOf(PETrackCursorInfo);
    Result := TPESetTrackCursorInfo(CrpeSetTrackCursorInfo)
      (printJob, cursorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetObjectFormat                                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectFormat(printJob: Smallint; objectHandle: DWord;
  objectFormatName: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeGetObjectFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectFormat := GetProcAddress(CRDEngine, 'PEGetObjectFormat');
  if CrpeGetObjectFormat = nil then
    CRDEngineError('PEGetObjectFormat')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEGetObjectFormat(CrpeGetObjectFormat)(printJob, objectHandle,
      objectFormatName, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetObjectFormat                                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectFormat(printJob: Smallint; objectHandle: DWord;
  objectFormatName: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeSetObjectFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectFormat := GetProcAddress(CRDEngine, 'PESetObjectFormat');
  if CrpeSetObjectFormat = nil then
    CRDEngineError('PESetObjectFormat')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPESetObjectFormat(CrpeSetObjectFormat)(printJob, objectHandle,
      objectFormatName, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNObjectsInSection                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNObjectsInSection(printJob: Smallint; sectionCode: Smallint): Smallint;
var
  CrpeGetNObjectsInSection : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNObjectsInSection := GetProcAddress(CRDEngine, 'PEGetNObjectsInSection');
  if CrpeGetNObjectsInSection = nil then
    CRDEngineError('PEGetNObjectsInSection')
  else
    Result := TPEGetNObjectsInSection(CrpeGetNObjectsInSection)(printJob, sectionCode);
end;

{------------------------------------------------------------------------------}
{ PEGetNthObjectInSection                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthObjectInSection(printJob: Smallint; sectionCode: Smallint;
  objectN: Smallint): DWord;
var
  CrpeGetNthObjectInSection : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthObjectInSection := GetProcAddress(CRDEngine, 'PEGetNthObjectInSection');
  if CrpeGetNthObjectInSection = nil then
    CRDEngineError('PEGetNthObjectInSection')
  else
    Result := TPEGetNthObjectInSection(CrpeGetNthObjectInSection)(printJob,
      sectionCode, objectN);
end;

{------------------------------------------------------------------------------}
{ PEGetObjectInfo                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectInfo(printJob: Smallint; objectHandle: DWord;
  var objectInfo: PEObjectInfo): Bool;
var
  CrpeGetObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectInfo := GetProcAddress(CRDEngine, 'PEGetObjectInfo');
  if CrpeGetObjectInfo = nil then
    CRDEngineError('PEGetObjectInfo')
  else
  begin
    objectInfo.StructSize := SizeOf(PEObjectInfo);
    Result := TPEGetObjectInfo(CrpeGetObjectInfo)(printJob, objectHandle,
      objectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetObjectInfo                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectInfo(printJob: Smallint; objectHandle: DWord;
  var objectInfo: PEObjectInfo): Bool;
var
  CrpeSetObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectInfo := GetProcAddress(CRDEngine, 'PESetObjectInfo');
  if CrpeSetObjectInfo = nil then
    CRDEngineError('PESetObjectInfo')
  else
  begin
    objectInfo.StructSize := SizeOf(PEObjectInfo);
    Result := TPESetObjectInfo(CrpeSetObjectInfo)(printJob, objectHandle,
      objectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetOleObjectInfo                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetOleObjectInfo(printJob: Smallint; objectHandle: DWord;
  var oleObjectInfo: PEOleObjectInfo): Bool;
var
  CrpeGetOleObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetOleObjectInfo := GetProcAddress(CRDEngine, 'PEGetOleObjectInfo');
  if CrpeGetOleObjectInfo = nil then
    CRDEngineError('PEGetOleObjectInfo')
  else
  begin
    oleObjectInfo.StructSize := SizeOf(PEOleObjectInfo);
    Result := TPEGetOleObjectInfo(CrpeGetOleObjectInfo)(printJob, objectHandle,
      oleObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetObjectFontColor                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectFontColor(printJob: Smallint; objectHandle: DWord;
  var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeGetObjectFontColor : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectFontColor := GetProcAddress(CRDEngine, 'PEGetObjectFontColor');
  if CrpeGetObjectFontColor = nil then
    CRDEngineError('PEGetObjectFontColor')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPEGetObjectFontColor(CrpeGetObjectFontColor)(printJob, objectHandle,
      fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetObjectFontColor                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectFontColor(printJob: Smallint; objectHandle: DWord;
  var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeSetObjectFontColor : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectFontColor := GetProcAddress(CRDEngine, 'PESetObjectFontColor');
  if CrpeSetObjectFontColor = nil then
    CRDEngineError('PESetObjectFontColor')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPESetObjectFontColor(CrpeSetObjectFontColor)(printJob, objectHandle,
      fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEChangeSummaryType                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEChangeSummaryType(printJob: Smallint; summarizedFieldName: PChar;
  groupN: Smallint; oldSummaryType: Smallint; newSummaryType: Smallint): DWord;
var
  CrpeChangeSummaryType : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeChangeSummaryType := GetProcAddress(CRDEngine, 'PEChangeSummaryType');
  if CrpeChangeSummaryType = nil then
    CRDEngineError('PEChangeSummaryType')
  else
    Result := TPEChangeSummaryType(CrpeChangeSummaryType)(printJob,
      summarizedFieldName, groupN, oldSummaryType, newSummaryType);
end;

{------------------------------------------------------------------------------}
{ PEGetFieldObjectInfo                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFieldObjectInfo(printJob: Smallint; fieldObjectHandle: DWord;
  var fieldObjectInfo: PEFieldObjectInfo): Bool;
var
  CrpeGetFieldObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFieldObjectInfo := GetProcAddress(CRDEngine, 'PEGetFieldObjectInfo');
  if CrpeGetFieldObjectInfo = nil then
    CRDEngineError('PEGetFieldObjectInfo')
  else
  begin
    fieldObjectInfo.StructSize := SizeOf(PEFieldObjectInfo);
    Result := TPEGetFieldObjectInfo(CrpeGetFieldObjectInfo)(printJob,
      fieldObjectHandle, fieldObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNParagraphs                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNParagraphs(printJob: Smallint; textObjectHandle: DWord): Smallint;
var
  CrpeGetNParagraphs : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNParagraphs := GetProcAddress(CRDEngine, 'PEGetNParagraphs');
  if CrpeGetNParagraphs = nil then
    CRDEngineError('PEGetNParagraphs')
  else
    Result := TPEGetNParagraphs(CrpeGetNParagraphs)(printJob, textObjectHandle);
end;

{------------------------------------------------------------------------------}
{ PEGetNthParagraphInfo                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthParagraphInfo(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; var paragraphInfo: PEParagraphInfo): Bool;
var
  CrpeGetNthParagraphInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthParagraphInfo := GetProcAddress(CRDEngine, 'PEGetNthParagraphInfo');
  if CrpeGetNthParagraphInfo = nil then
    CRDEngineError('PEGetNthParagraphInfo')
  else
  begin
    paragraphInfo.StructSize := SizeOf(PEParagraphInfo);
    Result := TPEGetNthParagraphInfo(CrpeGetNthParagraphInfo)(printJob,
      textObjectHandle, paragraphN, paragraphInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthParagraphInfo                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthParagraphInfo(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; var paragraphInfo: PEParagraphInfo): Bool;
var
  CrpeSetNthParagraphInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthParagraphInfo := GetProcAddress(CRDEngine, 'PESetNthParagraphInfo');
  if CrpeSetNthParagraphInfo = nil then
    CRDEngineError('PESetNthParagraphInfo')
  else
  begin
    paragraphInfo.StructSize := SizeOf(PEParagraphInfo);
    Result := TPESetNthParagraphInfo(CrpeSetNthParagraphInfo)(printJob,
      textObjectHandle, paragraphN, paragraphInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNTabStopsInParagraph                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNTabStopsInParagraph(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint): Smallint;
var
  CrpeGetNTabStopsInParagraph : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNTabStopsInParagraph := GetProcAddress(CRDEngine, 'PEGetNTabStopsInParagraph');
  if CrpeGetNTabStopsInParagraph = nil then
    CRDEngineError('PEGetNTabStopsInParagraph')
  else
    Result := TPEGetNTabStopsInParagraph(CrpeGetNTabStopsInParagraph)(printJob,
      textObjectHandle, paragraphN);
end;

{------------------------------------------------------------------------------}
{ PEGetNthTabStopInfo                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTabStopInfo(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; tabStopN: Smallint; var tabStopInfo: PETabStopInfo): Bool;
var
  CrpeGetNthTabStopInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTabStopInfo := GetProcAddress(CRDEngine, 'PEGetNthTabStopInfo');
  if CrpeGetNthTabStopInfo = nil then
    CRDEngineError('PEGetNthTabStopInfo')
  else
  begin
    tabStopInfo.StructSize := SizeOf(PETabStopInfo);
    Result := TPEGetNthTabStopInfo(CrpeGetNthTabStopInfo)(printJob,
      textObjectHandle, paragraphN, tabStopN, tabStopInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthTabStopInfo                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTabStopInfo(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; tabStopN: Smallint; var tabStopInfo: PETabStopInfo): Bool;
var
  CrpeSetNthTabStopInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTabStopInfo := GetProcAddress(CRDEngine, 'PESetNthTabStopInfo');
  if CrpeSetNthTabStopInfo = nil then
    CRDEngineError('PESetNthTabStopInfo')
  else
  begin
    tabStopInfo.StructSize := SizeOf(PETabStopInfo);
    Result := TPESetNthTabStopInfo(CrpeSetNthTabStopInfo)(printJob,
      textObjectHandle, paragraphN, tabStopN, tabStopInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddTabStop                                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddTabStop(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; var tabStopInfo: PETabStopInfo): Bool;
var
  CrpeAddTabStop : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddTabStop := GetProcAddress(CRDEngine, 'PEAddTabStop');
  if CrpeAddTabStop = nil then
    CRDEngineError('PEAddTabStop')
  else
  begin
    tabStopInfo.StructSize := SizeOf(PETabStopInfo);
    Result := TPEAddTabStop(CrpeAddTabStop)(printJob, textObjectHandle,
      paragraphN, tabStopInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEDeleteNthTabStop                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteNthTabStop(printJob: Smallint; textObjectHandle: DWord;
  paragraphN: Smallint; tabStopN: Smallint): Bool;
var
  CrpeDeleteNthTabStop : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteNthTabStop := GetProcAddress(CRDEngine, 'PEDeleteNthTabStop');
  if CrpeDeleteNthTabStop = nil then
    CRDEngineError('PEDeleteNthTabStop')
  else
    Result := TPEDeleteNthTabStop(CrpeDeleteNthTabStop)(printJob,
      textObjectHandle, paragraphN, tabStopN);
end;

{------------------------------------------------------------------------------}
{ PEGetNEmbeddedFields                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNEmbeddedFields(printJob: Smallint; textObjectHandle: DWord): Smallint;
var
  CrpeGetNEmbeddedFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNEmbeddedFields := GetProcAddress(CRDEngine, 'PEGetNEmbeddedFields');
  if CrpeGetNEmbeddedFields = nil then
    CRDEngineError('PEGetNEmbeddedFields')
  else
    Result := TPEGetNEmbeddedFields(CrpeGetNEmbeddedFields)(printJob,
      textObjectHandle);
end;

{------------------------------------------------------------------------------}
{ PEGetNthEmbeddedFieldInfo                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthEmbeddedFieldInfo(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint; var embeddedFieldInfo: PEEmbeddedFieldInfo): Bool;
var
  CrpeGetNthEmbeddedFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthEmbeddedFieldInfo := GetProcAddress(CRDEngine, 'PEGetNthEmbeddedFieldInfo');
  if CrpeGetNthEmbeddedFieldInfo = nil then
    CRDEngineError('PEGetNthEmbeddedFieldInfo')
  else
  begin
    embeddedFieldInfo.StructSize := SizeOf(PEEmbeddedFieldInfo);
    Result := TPEGetNthEmbeddedFieldInfo(CrpeGetNthEmbeddedFieldInfo)(printJob,
      textObjectHandle, embeddedFieldN, embeddedFieldInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthEmbeddedFieldFormat                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthEmbeddedFieldFormat(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint; objectFormatName: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeGetNthEmbeddedFieldFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthEmbeddedFieldFormat := GetProcAddress(CRDEngine, 'PEGetNthEmbeddedFieldFormat');
  if CrpeGetNthEmbeddedFieldFormat = nil then
    CRDEngineError('PEGetNthEmbeddedFieldFormat')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPEGetNthEmbeddedFieldFormat(CrpeGetNthEmbeddedFieldFormat)(printJob,
      textObjectHandle, embeddedFieldN, objectFormatName, valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthEmbeddedFieldFormat                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthEmbeddedFieldFormat(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint; objectFormatName: Smallint; var valueInfo: PEValueInfo): Bool;
var
  CrpeSetNthEmbeddedFieldFormat : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthEmbeddedFieldFormat := GetProcAddress(CRDEngine, 'PESetNthEmbeddedFieldFormat');
  if CrpeSetNthEmbeddedFieldFormat = nil then
    CRDEngineError('PESetNthEmbeddedFieldFormat')
  else
  begin
    valueInfo.structSize := SizeOf(PEValueInfo);
    Result := TPESetNthEmbeddedFieldFormat(CrpeSetNthEmbeddedFieldFormat)
      (printJob, textObjectHandle, embeddedFieldN, objectFormatName,
       valueInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthEmbeddedFieldFormatFormula                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthEmbeddedFieldFormatFormula(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint; formulaName: Smallint; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetNthEmbeddedFieldFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthEmbeddedFieldFormatFormula := GetProcAddress(CRDEngine, 'PEGetNthEmbeddedFieldFormatFormula');
  if CrpeGetNthEmbeddedFieldFormatFormula = nil then
    CRDEngineError('PEGetNthEmbeddedFieldFormatFormula')
  else
    Result := TPEGetNthEmbeddedFieldFormatFormula(CrpeGetNthEmbeddedFieldFormatFormula)(printJob,
      textObjectHandle, embeddedFieldN, formulaName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthEmbeddedFieldFormatFormula                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthEmbeddedFieldFormatFormula(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint; formulaName: Smallint; formulaString: PChar): Bool;
var
  CrpeSetNthEmbeddedFieldFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthEmbeddedFieldFormatFormula := GetProcAddress(CRDEngine, 'PESetNthEmbeddedFieldFormatFormula');
  if CrpeSetNthEmbeddedFieldFormatFormula = nil then
    CRDEngineError('PESetNthEmbeddedFieldFormatFormula')
  else
    Result := TPESetNthEmbeddedFieldFormatFormula(CrpeSetNthEmbeddedFieldFormatFormula)
      (printJob, textObjectHandle, embeddedFieldN, formulaName, formulaString);
end;

{------------------------------------------------------------------------------}
{ PEDeleteNthEmbeddedField                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteNthEmbeddedField(printJob: Smallint; textObjectHandle: DWord;
  embeddedFieldN: Smallint): Bool;
var
  CrpeDeleteNthEmbeddedField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteNthEmbeddedField := GetProcAddress(CRDEngine, 'PEDeleteNthEmbeddedField');
  if CrpeDeleteNthEmbeddedField = nil then
    CRDEngineError('PEDeleteNthEmbeddedField')
  else
    Result := TPEDeleteNthEmbeddedField(CrpeDeleteNthEmbeddedField)
      (printJob, textObjectHandle, embeddedFieldN);
end;

{------------------------------------------------------------------------------}
{ PEInsertEmbeddedField                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEInsertEmbeddedField(printJob: Smallint; textObjectHandle: DWord;
  position: LongInt; fieldName: PChar): Bool;
var
  CrpeInsertEmbeddedField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeInsertEmbeddedField := GetProcAddress(CRDEngine, 'PEInsertEmbeddedField');
  if CrpeInsertEmbeddedField = nil then
    CRDEngineError('PEInsertEmbeddedField')
  else
    Result := TPEInsertEmbeddedField(CrpeInsertEmbeddedField)(printJob,
      textObjectHandle, position, fieldName);
end;

{------------------------------------------------------------------------------}
{ PEGetTextFontColor                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetTextFontColor(printJob: Smallint; textObjectHandle: DWord;
  position: LongInt; var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeGetTextFontColor : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetTextFontColor := GetProcAddress(CRDEngine, 'PEGetTextFontColor');
  if CrpeGetTextFontColor = nil then
    CRDEngineError('PEGetTextFontColor')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPEGetTextFontColor(CrpeGetTextFontColor)(printJob,
      textObjectHandle, position, fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetTextFontColor                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetTextFontColor(printJob: Smallint; textObjectHandle: DWord;
  startPosition: LongInt; endPosition: LongInt; var fontColorInfo: PEFontColorInfo): Bool;
var
  CrpeSetTextFontColor : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetTextFontColor := GetProcAddress(CRDEngine, 'PESetTextFontColor');
  if CrpeSetTextFontColor = nil then
    CRDEngineError('PESetTextFontColor')
  else
  begin
    fontColorInfo.structSize := SizeOf(PEFontColorInfo);
    Result := TPESetTextFontColor(CrpeSetTextFontColor)(printJob,
      textObjectHandle, startPosition, endPosition, fontColorInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetTextSize                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetTextSize(printJob: Smallint; textObjectHandle: DWord): LongInt;
var
  CrpeGetTextSize : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetTextSize := GetProcAddress(CRDEngine, 'PEGetTextSize');
  if CrpeGetTextSize = nil then
    CRDEngineError('PEGetTextSize')
  else
    Result := TPEGetTextSize(CrpeGetTextSize)(printJob, textObjectHandle);
end;

{------------------------------------------------------------------------------}
{ PEGetTextHeight                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetTextHeight(printJob: Smallint; textObjectHandle: DWord): LongInt;
var
  CrpeGetTextHeight : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetTextHeight := GetProcAddress(CRDEngine, 'PEGetTextHeight');
  if CrpeGetTextHeight = nil then
    CRDEngineError('PEGetTextHeight')
  else
    Result := TPEGetTextHeight(CrpeGetTextHeight)(printJob, textObjectHandle);
end;

{------------------------------------------------------------------------------}
{ PEGetText                                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetText(printJob: Smallint; textObjectHandle: DWord; var textHandle: HWnd;
  var textLength: Smallint): Bool;
var
  CrpeGetText : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetText := GetProcAddress(CRDEngine, 'PEGetText');
  if CrpeGetText = nil then
    CRDEngineError('PEGetText')
  else
    Result := TPEGetText(CrpeGetText)(printJob, textObjectHandle,
      textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PEInsertText                                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEInsertText(printJob: Smallint; textObjectHandle: DWord; position: LongInt;
  text: PChar): Bool;
var
  CrpeInsertText : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeInsertText := GetProcAddress(CRDEngine, 'PEInsertText');
  if CrpeInsertText = nil then
    CRDEngineError('PEInsertText')
  else
    Result := TPEInsertText(CrpeInsertText)(printJob, textObjectHandle,
      position, text);
end;

{------------------------------------------------------------------------------}
{ PEDeleteText                                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEDeleteText(printJob: Smallint; textObjectHandle: DWord;
  startText: LongInt; endText: LongInt): Bool;
var
  CrpeDeleteText : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeDeleteText := GetProcAddress(CRDEngine, 'PEDeleteText');
  if CrpeDeleteText = nil then
    CRDEngineError('PEDeleteText')
  else
    Result := TPEDeleteText(CrpeDeleteText)(printJob, textObjectHandle,
      startText, endText);
end;

{------------------------------------------------------------------------------}
{ PEInsertTextEx                                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEInsertTextEx(printJob: Smallint; var insertTextInfo: PEInsertTextInfo): Bool;
var
  CrpeInsertTextEx : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeInsertTextEx := GetProcAddress(CRDEngine, 'PEInsertTextEx');
  if CrpeInsertTextEx = nil then
    CRDEngineError('PEInsertTextEx')
  else
    Result := TPEInsertTextEx(CrpeInsertTextEx)(printJob, insertTextInfo);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSubreportLink                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSubreportLink(printJob: Smallint; subreportHandle: DWord;
  subreportLinkN: Smallint; mainReportFieldNameHandle: HWnd;
  mainReportFieldNameLength: Smallint; promptVarFieldNameHandle: HWnd;
  promptVarFieldNameLength: Smallint): Bool;
var
  CrpeGetNthSubreportLink : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSubreportLink := GetProcAddress(CRDEngine, 'PEGetNthSubreportLink');
  if CrpeGetNthSubreportLink = nil then
    CRDEngineError('PEGetNthSubreportLink')
  else
    Result := TPEGetNthSubreportLink(CrpeGetNthSubreportLink)(printJob,
      subreportHandle, subreportLinkN, mainReportFieldNameHandle,
      mainReportFieldNameLength, promptVarFieldNameHandle, promptVarFieldNameLength);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSubreportLinkEx                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSubreportLinkEx(printJob: Smallint; subreportHandle: DWord;
  subreportLinkN: Smallint; var subreportLinkInfo : PESubreportLinkInfo): Bool;
var
  CrpeGetNthSubreportLinkEx : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSubreportLinkEx := GetProcAddress(CRDEngine, 'PEGetNthSubreportLinkEx');
  if CrpeGetNthSubreportLinkEx = nil then
    CRDEngineError('PEGetNthSubreportLinkEx')
  else
  begin
    subreportLinkInfo.StructSize := SizeOf(PESubreportLinkInfo);
    Result := TPEGetNthSubreportLinkEx(CrpeGetNthSubreportLinkEx)(printJob,
      subreportHandle, subreportLinkN, subreportLinkInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEReimportSubreport                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEReimportSubreport(printJob: Smallint; subreportHandle: DWord;
  var linkChanged: Bool; var reimported: Bool): Bool;
var
  CrpeReimportSubreport : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeReimportSubreport := GetProcAddress(CRDEngine, 'PEReimportSubreport');
  if CrpeReimportSubreport = nil then
    CRDEngineError('PEReimportSubreport')
  else
    Result := TPEReimportSubreport(CrpeReimportSubreport)(printJob,
      subreportHandle, linkChanged, reimported);
end;

{------------------------------------------------------------------------------}
{ PEGetLineObjectInfo                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetLineObjectInfo(printJob: Smallint; lineObjectHandle: DWord;
  var lineObjectInfo: PELineObjectInfo): Bool;
var
  CrpeGetLineObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetLineObjectInfo := GetProcAddress(CRDEngine, 'PEGetLineObjectInfo');
  if CrpeGetLineObjectInfo = nil then
    CRDEngineError('PEGetLineObjectInfo')
  else
  begin
    lineObjectInfo.StructSize := SizeOf(PELineObjectInfo);
    Result := TPEGetLineObjectInfo(CrpeGetLineObjectInfo)(printJob,
      lineObjectHandle, lineObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetLineObjectInfo                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetLineObjectInfo(printJob: Smallint; lineObjectHandle: DWord;
  var lineObjectInfo: PELineObjectInfo): Bool;
var
  CrpeSetLineObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetLineObjectInfo := GetProcAddress(CRDEngine, 'PESetLineObjectInfo');
  if CrpeSetLineObjectInfo = nil then
    CRDEngineError('PESetLineObjectInfo')
  else
  begin
    lineObjectInfo.StructSize := SizeOf(PELineObjectInfo);
    Result := TPESetLineObjectInfo(CrpeSetLineObjectInfo)(printJob,
      lineObjectHandle, lineObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetBoxObjectInfo                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetBoxObjectInfo(printJob: Smallint; boxObjectHandle: DWord;
  var boxObjectInfo: PEBoxObjectInfo): Bool;
var
  CrpeGetBoxObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetBoxObjectInfo := GetProcAddress(CRDEngine, 'PEGetBoxObjectInfo');
  if CrpeGetBoxObjectInfo = nil then
    CRDEngineError('PEGetBoxObjectInfo')
  else
  begin
    boxObjectInfo.StructSize := SizeOf(PEBoxObjectInfo);
    Result := TPEGetBoxObjectInfo(CrpeGetBoxObjectInfo)(printJob,
      boxObjectHandle, boxObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetBoxObjectInfo                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetBoxObjectInfo(printJob: Smallint; boxObjectHandle: DWord;
  var boxObjectInfo: PEBoxObjectInfo): Bool;
var
  CrpeSetBoxObjectInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetBoxObjectInfo := GetProcAddress(CRDEngine, 'PESetBoxObjectInfo');
  if CrpeSetBoxObjectInfo = nil then
    CRDEngineError('PESetBoxObjectInfo')
  else
  begin
    boxObjectInfo.StructSize := SizeOf(PEBoxObjectInfo);
    Result := TPESetBoxObjectInfo(CrpeSetBoxObjectInfo)(printJob,
      boxObjectHandle, boxObjectInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetPictureFormatInfo                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetPictureFormatInfo(printJob: Smallint; objectHandle: DWord;
  var pictureFormatInfo: PEPictureFormatInfo): Bool;
var
  CrpeGetPictureFormatInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetPictureFormatInfo := GetProcAddress(CRDEngine, 'PEGetPictureFormatInfo');
  if CrpeGetPictureFormatInfo = nil then
    CRDEngineError('PEGetPictureFormatInfo')
  else
  begin
    pictureFormatInfo.StructSize := SizeOf(PEPictureFormatInfo);
    Result := TPEGetPictureFormatInfo(CrpeGetPictureFormatInfo)(printJob,
      objectHandle, pictureFormatInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetPictureFormatInfo                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetPictureFormatInfo(printJob: Smallint; objectHandle: DWord;
  var pictureFormatInfo: PEPictureFormatInfo): Bool;
var
  CrpeSetPictureFormatInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetPictureFormatInfo := GetProcAddress(CRDEngine, 'PESetPictureFormatInfo');
  if CrpeSetPictureFormatInfo = nil then
    CRDEngineError('PESetPictureFormatInfo')
  else
  begin
    pictureFormatInfo.StructSize := SizeOf(PEPictureFormatInfo);
    Result := TPESetPictureFormatInfo(CrpeSetPictureFormatInfo)(printJob,
      objectHandle, pictureFormatInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNSummariesInCrossTabObject                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSummariesInCrossTabObject(printJob: Smallint; crossTabObjectHandle: DWord): Smallint;
var
  CrpeGetNSummariesInCrossTabObject : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSummariesInCrossTabObject := GetProcAddress(CRDEngine, 'PEGetNSummariesInCrossTabObject');
  if CrpeGetNSummariesInCrossTabObject = nil then
    CRDEngineError('PEGetNSummariesInCrossTabObject')
  else
    Result := TPEGetNSummariesInCrossTabObject(CrpeGetNSummariesInCrossTabObject)(printJob,
      crossTabObjectHandle);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSummaryInfoInCrossTabObject                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSummaryInfoInCrossTabObject(printJob: Smallint; crossTabObjectHandle: DWord;
  summaryN: Smallint; var summaryInfo: PECrossTabSummaryFieldInfo): Bool;
var
  CrpeGetNthSummaryInfoInCrossTabObject : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSummaryInfoInCrossTabObject := GetProcAddress(CRDEngine, 'PEGetNthSummaryInfoInCrossTabObject');
  if CrpeGetNthSummaryInfoInCrossTabObject = nil then
    CRDEngineError('PEGetNthSummaryInfoInCrossTabObject')
  else
  begin
    summaryInfo.StructSize := SizeOf(PECrossTabSummaryFieldInfo);
    Result := TPEGetNthSummaryInfoInCrossTabObject(CrpeGetNthSummaryInfoInCrossTabObject)(printJob,
      crossTabObjectHandle, summaryN, summaryInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNGroupsInCrossTabObject                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNGroupsInCrossTabObject(printJob: Smallint;
  crossTabObjectHandle: DWord; rowCol: Smallint): Smallint;
var
  CrpeGetNGroupsInCrossTabObject : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNGroupsInCrossTabObject := GetProcAddress(CRDEngine, 'PEGetNGroupsInCrossTabObject');
  if CrpeGetNGroupsInCrossTabObject = nil then
    CRDEngineError('PEGetNGroupsInCrossTabObject')
  else
    Result := TPEGetNGroupsInCrossTabObject(CrpeGetNGroupsInCrossTabObject)(printJob,
      crossTabObjectHandle, rowCol);
end;

{------------------------------------------------------------------------------}
{ PEGetNthCrossTabGroupOptions                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthCrossTabGroupOptions(printJob: Smallint; crossTabObjectHandle: DWord;
  rowCol: Smallint; rowColN: Smallint; var crossTabGroupOptions: PECrossTabGroupOptions): Bool;
var
  CrpeGetNthCrossTabGroupOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthCrossTabGroupOptions := GetProcAddress(CRDEngine, 'PEGetNthCrossTabGroupOptions');
  if CrpeGetNthCrossTabGroupOptions = nil then
    CRDEngineError('PEGetNthCrossTabGroupOptions')
  else
  begin
    crossTabGroupOptions.StructSize := SizeOf(PECrossTabGroupOptions);
    Result := TPEGetNthCrossTabGroupOptions(CrpeGetNthCrossTabGroupOptions)(printJob,
      crossTabObjectHandle, rowCol, rowColN, crossTabGroupOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetCrossTabOptions                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetCrossTabOptions(printJob: Smallint; hObject: DWord;
  var crossTabOptions: PECrossTabOptions): Bool;
var
  CrpeGetCrossTabOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetCrossTabOptions := GetProcAddress(CRDEngine, 'PEGetCrossTabOptions');
  if CrpeGetCrossTabOptions = nil then
    CRDEngineError('PEGetCrossTabOptions')
  else
  begin
    crossTabOptions.StructSize := SizeOf(PECrossTabOptions);
    Result := TPEGetCrossTabOptions(CrpeGetCrossTabOptions)(printJob,
      hObject, crossTabOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetGraphNumber                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphNumber(printJob: Smallint; graphObjectHandle: DWord;
  var sectionCode: Smallint; var graphN: Smallint): Bool;
var
  CrpeGetGraphNumber : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphNumber := GetProcAddress(CRDEngine, 'PEGetGraphNumber');
  if CrpeGetGraphNumber = nil then
    CRDEngineError('PEGetGraphNumber')
  else
    Result := TPEGetGraphNumber(CrpeGetGraphNumber)(printJob,
      graphObjectHandle, sectionCode, graphN);
end;

{------------------------------------------------------------------------------}
{ PEGetGraphDataType                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphDataType(printJob: Smallint; sectionCode: Smallint;
  graphN: Smallint; var graphDataTypeInfo: PEGraphDataTypeInfo): Bool;
var
  CrpeGetGraphDataType : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphDataType := GetProcAddress(CRDEngine, 'PEGetGraphDataType');
  if CrpeGetGraphDataType = nil then
    CRDEngineError('PEGetGraphDataType')
  else
  begin
    graphDataTypeInfo.StructSize := SizeOf(PEGraphDataTypeInfo);
    Result := TPEGetGraphDataType(CrpeGetGraphDataType)(printJob,
      sectionCode, graphN, graphDataTypeInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetObjectFormatFormula                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectFormatFormula(printJob: Smallint; objectHandle: DWord;
  formulaName: Smallint; var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetObjectFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectFormatFormula := GetProcAddress(CRDEngine, 'PEGetObjectFormatFormula');
  if CrpeGetObjectFormatFormula = nil then
    CRDEngineError('PEGetObjectFormatFormula')
  else
    Result := TPEGetObjectFormatFormula(CrpeGetObjectFormatFormula)
      (printJob, objectHandle, formulaName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetObjectFormatFormula                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectFormatFormula(printJob: Smallint; objectHandle: DWord;
  formulaName: Smallint; formulaString: PChar): Bool;
var
  CrpeSetObjectFormatFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectFormatFormula := GetProcAddress(CRDEngine, 'PESetObjectFormatFormula');

  if CrpeSetObjectFormatFormula = nil then
    CRDEngineError('PESetObjectFormatFormula')
  else
    Result := TPESetObjectFormatFormula(CrpeSetObjectFormatFormula)
      (printJob, objectHandle, formulaName,  formulaString);


end;

{------------------------------------------------------------------------------}
{ PEGetParameterBrowseField                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetParameterBrowseField(printJob: Smallint; parameterFieldName: PChar;
  reportName: PChar; var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetParameterBrowseField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetParameterBrowseField := GetProcAddress(CRDEngine, 'PEGetParameterBrowseField');
  if CrpeGetParameterBrowseField = nil then
    CRDEngineError('PEGetParameterBrowseField')
  else
    Result := TPEGetParameterBrowseField(CrpeGetParameterBrowseField)(printJob,
      parameterFieldName, reportName, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetParameterBrowseField                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetParameterBrowseField(printJob: Smallint; parameterFieldName: PChar;
  reportName: PChar; browseTableField: PChar): Bool;
var
  CrpeSetParameterBrowseField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetParameterBrowseField := GetProcAddress(CRDEngine, 'PESetParameterBrowseField');
  if CrpeSetParameterBrowseField = nil then
    CRDEngineError('PESetParameterBrowseField')
  else
    Result := TPESetParameterBrowseField(CrpeSetParameterBrowseField)(printJob,
      parameterFieldName, reportName, browseTableField);
end;

{------------------------------------------------------------------------------}
{ PEInsertSortField                                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEInsertSortField(printJob: Smallint; sortFieldN: Smallint;
  name: PChar; direction: Smallint): Bool;
var
  CrpeInsertSortField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeInsertSortField := GetProcAddress(CRDEngine, 'PEInsertSortField');
  if CrpeInsertSortField = nil then
    CRDEngineError('PEInsertSortField')
  else
    Result := TPEInsertSortField(CrpeInsertSortField)(printJob, sortFieldN,
      name, direction);
end;

{------------------------------------------------------------------------------}
{ PESwapSortFields                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESwapSortFields(printJob: Smallint; sourceSortN: Smallint;
  targetSortN: Smallint): Bool;
var
  CrpeSwapSortFields : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSwapSortFields := GetProcAddress(CRDEngine, 'PESwapSortFields');
  if CrpeSwapSortFields = nil then
    CRDEngineError('PESwapSortFields')
  else
    Result := TPESwapSortFields(CrpeSwapSortFields)(printJob, sourceSortN,
      targetSortN);
end;

{------------------------------------------------------------------------------}
{ PEGetNLogicalTables                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNLogicalTables(printJob: Smallint): Smallint;
var
  CrpeGetNLogicalTables : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNLogicalTables := GetProcAddress(CRDEngine, 'PEGetNLogicalTables');
  if CrpeGetNLogicalTables = nil then
    CRDEngineError('PEGetNLogicalTables')
  else
    Result := TPEGetNLogicalTables(CrpeGetNLogicalTables)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthTableAliasName                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthTableAliasName(printJob: Smallint; tableN: Smallint;
  var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetNthTableAliasName : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthTableAliasName := GetProcAddress(CRDEngine, 'PEGetNthTableAliasName');
  if CrpeGetNthTableAliasName = nil then
    CRDEngineError('PEGetNthTableAliasName')
  else
    Result := TPEGetNthTableAliasName(CrpeGetNthTableAliasName)(printJob,
      tableN, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthTableAliasName                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTableAliasName(printJob: Smallint; tableN: Smallint;
  tableAliasName: PChar): Bool;
var
  CrpeSetNthTableAliasName : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTableAliasName := GetProcAddress(CRDEngine, 'PESetNthTableAliasName');
  if CrpeSetNthTableAliasName = nil then
    CRDEngineError('PESetNthTableAliasName')
  else
    Result := TPESetNthTableAliasName(CrpeSetNthTableAliasName)(printJob,
      tableN, tableAliasName);
end;

{------------------------------------------------------------------------------}
{ PESetNthTableServerType                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthTableServerType(printJob: Smallint; tableN: Smallint;
  var serverType: PEServerTypeInfo; propagateAcrossTables: Bool): Bool;
var
  CrpeSetNthTableServerType : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthTableServerType := GetProcAddress(CRDEngine, 'PESetNthTableServerType');
  if CrpeSetNthTableServerType = nil then
    CRDEngineError('PESetNthTableServerType')
  else
  begin
    serverType.StructSize := SizeOf(PEServerTypeInfo);
    Result := TPESetNthTableServerType(CrpeSetNthTableServerType)(printJob,
      tableN, serverType, propagateAcrossTables);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNDatabaseFields                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNDatabaseFields(printJob: Smallint; tableN: Smallint): Smallint;
var
  CrpeGetNDatabaseFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNDatabaseFields := GetProcAddress(CRDEngine, 'PEGetNDatabaseFields');
  if CrpeGetNDatabaseFields = nil then
    CRDEngineError('PEGetNDatabaseFields')
  else
    Result := TPEGetNDatabaseFields(CrpeGetNDatabaseFields)(printJob, tableN);
end;

{------------------------------------------------------------------------------}
{ PEGetNthDatabaseFieldInfo                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthDatabaseFieldInfo(printJob: Smallint; tableN: Smallint;
  fieldN: Smallint; var fieldInfo: PEDatabaseFieldInfo): Bool;
var
  CrpeGetNthDatabaseFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthDatabaseFieldInfo := GetProcAddress(CRDEngine, 'PEGetNthDatabaseFieldInfo');
  if CrpeGetNthDatabaseFieldInfo = nil then
    CRDEngineError('PEGetNthDatabaseFieldInfo')
  else
  begin
    fieldInfo.StructSize := SizeOf(PEDatabaseFieldInfo);
    Result := TPEGetNthDatabaseFieldInfo(CrpeGetNthDatabaseFieldInfo)(printJob,
      tableN, fieldN, fieldInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNDatabaseLinks                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNDatabaseLinks(printJob : Smallint): Smallint;
var
  CrpeGetNDatabaseLinks : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNDatabaseLinks := GetProcAddress(CRDEngine, 'PEGetNDatabaseLinks');
  if CrpeGetNDatabaseLinks = nil then
   CRDEngineError('PEGetNDatabaseLinks')
  else
    Result := TPEGetNDatabaseLinks(CrpeGetNDatabaseLinks)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthDatabaseLinkInfo                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthDatabaseLinkInfo (printJob: Smallint;
  databaseLinkN: Smallint; var databaseLinkInfo: PEDatabaseLinkInfo): Bool;
var
  CrpeGetNthDatabaseLinkInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthDatabaseLinkInfo := GetProcAddress(CRDEngine, 'PEGetNthDatabaseLinkInfo');
  if CrpeGetNthDatabaseLinkInfo = nil then
    CRDEngineError('PEGetNthDatabaseLinkInfo')
  else
  begin
    databaseLinkInfo.StructSize := SizeOf(PEDatabaseLinkInfo);
    Result := TPEGetNthDatabaseLinkInfo(CrpeGetNthDatabaseLinkInfo)(printJob,
      databaseLinkN, databaseLinkInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetDatabaseLinkInfo                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetDatabaseLinkInfo(printJob: Smallint;
  var databaseLinkInfo: PEDatabaseLinkInfo): Bool;
var
  CrpeSetDatabaseLinkInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetDatabaseLinkInfo := GetProcAddress(CRDEngine, 'PESetDatabaseLinkInfo');
  if CrpeSetDatabaseLinkInfo = nil then
    CRDEngineError('PESetDatabaseLinkInfo')
  else
  begin
    databaseLinkInfo.StructSize := SizeOf(PEDatabaseLinkInfo);
    Result := TPESetDatabaseLinkInfo(CrpeSetDatabaseLinkInfo)(printJob,
      databaseLinkInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEConvertDatabaseDriver                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEConvertDatabaseDriver(printJob: Smallint; toDllName: PChar;
  doConvert: Bool): Bool;
var
  CrpeConvertDatabaseDriver : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeConvertDatabaseDriver := GetProcAddress(CRDEngine, 'PEConvertDatabaseDriver');
  if CrpeConvertDatabaseDriver = nil then
    CRDEngineError('PEConvertDatabaseDriver')
  else
    Result := TPEConvertDatabaseDriver(CrpeConvertDatabaseDriver)(printJob,
      toDllName, doConvert);
end;

{------------------------------------------------------------------------------}
{ PEFreeDevMode                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEFreeDevMode(printJob: Smallint; pMode: PDevMode): Bool;
var
  CrpeFreeDevMode : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeFreeDevMode := GetProcAddress(CRDEngine, 'PEFreeDevMode');
  if CrpeFreeDevMode = nil then
    CRDEngineError('PEFreeDevMode')
  else
    Result := TPEFreeDevMode(CrpeFreeDevMode)(printJob, pMode);
end;

{------------------------------------------------------------------------------}
{ PEGetDictionaryInfo                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetDictionaryInfo(printJob: Smallint; var dictInfo: PEDictionaryInfo): Bool;
var
  CrpeGetDictionaryInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetDictionaryInfo := GetProcAddress(CRDEngine, 'PEGetDictionaryInfo');
  if CrpeGetDictionaryInfo = nil then
    CRDEngineError('PEGetDictionaryInfo')
  else
  begin
    dictInfo.StructSize := SizeOf(PEDictionaryInfo);
    Result := TPEGetDictionaryInfo(CrpeGetDictionaryInfo)(printJob,
      dictInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetDictionaryLocation                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetDictionaryLocation(printJob: Smallint;
  var dictLocation: PETableLocation): Bool;
var
  CrpeGetDictionaryLocation : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetDictionaryLocation := GetProcAddress(CRDEngine, 'PEGetDictionaryLocation');
  if CrpeGetDictionaryLocation = nil then
    CRDEngineError('PEGetDictionaryLocation')
  else
  begin
    dictLocation.structSize := SizeOf(PETableLocation);
    Result := TPEGetDictionaryLocation(CrpeGetDictionaryLocation)(printJob,
      dictLocation);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetDirectoryUserId                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetDirectoryUserId(printJob: Smallint; var textHandle: HWnd;
  var textLength : Smallint): Bool;
var
  CrpeGetDirectoryUserId : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetDirectoryUserId := GetProcAddress(CRDEngine, 'PEGetDirectoryUserId');
  if CrpeGetDirectoryUserId = nil then
    CRDEngineError('PEGetDirectoryUserId')
  else
    Result := TPEGetDirectoryUserId(CrpeGetDirectoryUserId)(printJob,
      textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PEGetFieldDefinitionInfo                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFieldDefinitionInfo(printJob: Smallint; fieldName: PChar;
  var fieldDefinitionInfo: PEFieldDefinitionInfo): Bool;
var
  CrpeGetFieldDefinitionInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFieldDefinitionInfo := GetProcAddress(CRDEngine, 'PEGetFieldDefinitionInfo');
  if CrpeGetFieldDefinitionInfo = nil then
    CRDEngineError('PEGetFieldDefinitionInfo')
  else
  begin
    fieldDefinitionInfo.StructSize := SizeOf(PEFieldDefinitionInfo);
    Result := TPEGetFieldDefinitionInfo(CrpeGetFieldDefinitionInfo)(printJob,
      fieldName, fieldDefinitionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetFormulaFieldInfo                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFormulaFieldInfo(printJob: Smallint; formula: PChar;
  var fieldDefinitionInfo: PEFieldDefinitionInfo): Bool;
var
  CrpeGetFormulaFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFormulaFieldInfo := GetProcAddress(CRDEngine, 'PEGetFormulaFieldInfo');
  if CrpeGetFormulaFieldInfo = nil then
    CRDEngineError('PEGetFormulaFieldInfo')
  else
  begin
    fieldDefinitionInfo.StructSize := SizeOf(PEFieldDefinitionInfo);
    Result := TPEGetFormulaFieldInfo(CrpeGetFormulaFieldInfo)(printJob,
      formula, fieldDefinitionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetSQLExpressionFieldInfo                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSQLExpressionFieldInfo(printJob: Smallint; expression: PChar;
  var fieldDefinitionInfo: PEFieldDefinitionInfo): Bool;
var
  CrpeGetSQLExpressionFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSQLExpressionFieldInfo := GetProcAddress(CRDEngine, 'PEGetSQLExpressionFieldInfo');
  if CrpeGetSQLExpressionFieldInfo = nil then
    CRDEngineError('PEGetSQLExpressionFieldInfo')
  else
  begin
    fieldDefinitionInfo.StructSize := SizeOf(PEFieldDefinitionInfo);
    Result := TPEGetSQLExpressionFieldInfo(CrpeGetSQLExpressionFieldInfo)(printJob,
      expression, fieldDefinitionInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNSummaryFields                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSummaryFields(printJob: Smallint): Smallint;
var
  CrpeGetNSummaryFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSummaryFields := GetProcAddress(CRDEngine, 'PEGetNSummaryFields');
  if CrpeGetNSummaryFields = nil then
    CRDEngineError('PEGetNSummaryFields')
  else
    Result := TPEGetNSummaryFields(CrpeGetNSummaryFields)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthSummaryFieldInfo                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthSummaryFieldInfo(printJob: Smallint; summaryN: Smallint;
  var summaryFieldInfo: PESummaryFieldInfo): Bool;
var
  CrpeGetNthSummaryFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthSummaryFieldInfo := GetProcAddress(CRDEngine, 'PEGetNthSummaryFieldInfo');
  if CrpeGetNthSummaryFieldInfo = nil then
    CRDEngineError('PEGetNthSummaryFieldInfo')
  else
  begin
    summaryFieldInfo.StructSize := SizeOf(PESummaryFieldInfo);
    Result := TPEGetNthSummaryFieldInfo(CrpeGetNthSummaryFieldInfo)(printJob,
      summaryN, summaryFieldInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetReportStyle                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReportStyle(printJob: Smallint): Word;
var
  CrpeGetReportStyle : TFarProc;
begin
  CRDEngineError('');
  Result := 99;    {arbitrary number chosen for fail}
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReportStyle := GetProcAddress(CRDEngine, 'PEGetReportStyle');
  if CrpeGetReportStyle = nil then
    CRDEngineError('PEGetReportStyle')
  else
    Result := TPEGetReportStyle(CrpeGetReportStyle)(printJob);
end;

{------------------------------------------------------------------------------}
{ PESetReportStyle                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetReportStyle(printJob : Smallint; style: Word): Bool;
var
  CrpeSetReportStyle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetReportStyle := GetProcAddress(CRDEngine, 'PESetReportStyle');
  if CrpeSetReportStyle = nil then
    CRDEngineError('PESetReportStyle')
  else
    Result := TPESetReportStyle(CrpeSetReportStyle)(printJob, style);
end;

{------------------------------------------------------------------------------}
{ PEGetNOLAPCubes                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNOLAPCubes(printJob: Smallint): Smallint;
var
  CrpeGetNOLAPCubes : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNOLAPCubes := GetProcAddress(CRDEngine, 'PEGetNOLAPCubes');
  if CrpeGetNOLAPCubes = nil then
    CRDEngineError('PEGetNOLAPCubes')
  else
    Result := TPEGetNOLAPCubes(CrpeGetNOLAPCubes)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthOLAPCubeLogOnInfo                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthOLAPCubeLogOnInfo(printJob: Smallint;
  cubeN: Smallint; var logOnInfo: PEOLAPLogOnInfo): Bool;
var
  CrpeGetNthOLAPCubeLogOnInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthOLAPCubeLogOnInfo := GetProcAddress(CRDEngine, 'PEGetNthOLAPCubeLogOnInfo');
  if CrpeGetNthOLAPCubeLogOnInfo = nil then
    CRDEngineError('PEGetNthOLAPCubeLogOnInfo')
  else
  begin
    logOnInfo.StructSize := SizeOf(PEOLAPLogOnInfo);
    Result := TPEGetNthOLAPCubeLogOnInfo(CrpeGetNthOLAPCubeLogOnInfo)(printJob,
      cubeN, logOnInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthOLAPCubeLogOnInfo                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthOLAPCubeLogOnInfo(printJob: Smallint; cubeN: Smallint;
  var logOnInfo: PEOLAPLogOnInfo): Bool;
var
  CrpeSetNthOLAPCubeLogOnInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthOLAPCubeLogOnInfo := GetProcAddress(CRDEngine, 'PESetNthOLAPCubeLogOnInfo');
  if CrpeSetNthOLAPCubeLogOnInfo = nil then
    CRDEngineError('PESetNthOLAPCubeLogOnInfo')
  else
  begin
    logOnInfo.StructSize := SizeOf(PEOLAPLogOnInfo);
    Result := TPESetNthOLAPCubeLogOnInfo(CrpeSetNthOLAPCubeLogOnInfo)(printJob,
      cubeN, logOnInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PETestNthOlapCubeConnectivity                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PETestNthOlapCubeConnectivity(printJob: Smallint;
  cubeN: Smallint): Bool;
var
  CrpeTestNthOlapCubeConnectivity : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeTestNthOlapCubeConnectivity := GetProcAddress(CRDEngine, 'PETestNthOlapCubeConnectivity');
  if CrpeTestNthOlapCubeConnectivity = nil then
    CRDEngineError('PETestNthOlapCubeConnectivity')
  else
    Result := TPETestNthOlapCubeConnectivity(CrpeTestNthOlapCubeConnectivity)
      (printJob, cubeN);
end;

{------------------------------------------------------------------------------}
{ PEGetGraphDataInfo                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphDataInfo(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; var graphDataInfo: PENewGraphDataInfo): Bool;
var
  CrpeGetGraphDataInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphDataInfo := GetProcAddress(CRDEngine, 'PEGetGraphDataInfo');
  if CrpeGetGraphDataInfo = nil then
    CRDEngineError('PEGetGraphDataInfo')
  else
  begin
    graphDataInfo.StructSize := SizeOf(PENewGraphDataInfo);
    Result := TPEGetGraphDataInfo(CrpeGetGraphDataInfo)(printJob,
      sectionN, graphN, graphDataInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNGraphConditionFields                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNGraphConditionFields(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint): Smallint;
var
  CrpeGetNGraphConditionFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNGraphConditionFields := GetProcAddress(CRDEngine, 'PEGetNGraphConditionFields');
  if CrpeGetNGraphConditionFields = nil then
    CRDEngineError('PEGetNGraphConditionFields')
  else
    Result := TPEGetNGraphConditionFields(CrpeGetNGraphConditionFields)
      (printJob, sectionN, graphN);
end;

{------------------------------------------------------------------------------}
{ PEGetNthGraphConditionField                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthGraphConditionField(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; condFieldN: Smallint; var fieldNameHandle: HWnd;
  var fieldNameLength: Smallint): Bool;
var
  CrpeGetNthGraphConditionField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthGraphConditionField := GetProcAddress(CRDEngine, 'PEGetNthGraphConditionField');
  if CrpeGetNthGraphConditionField = nil then
    CRDEngineError('PEGetNthGraphConditionField')
  else
    Result := TPEGetNthGraphConditionField(CrpeGetNthGraphConditionField)(printJob,
      sectionN, graphN, condFieldN, fieldNameHandle, fieldNameLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthGraphConditionField                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthGraphConditionField(printJob: Smallint; graphN: Smallint;
  condFieldN: Smallint; fieldName: PChar): Bool;
var
  CrpeSetNthGraphConditionField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthGraphConditionField := GetProcAddress(CRDEngine, 'PESetNthGraphConditionField');
  if CrpeSetNthGraphConditionField = nil then
    CRDEngineError('PESetNthGraphConditionField')
  else
    Result := TPESetNthGraphConditionField(CrpeSetNthGraphConditionField)
      (printJob, graphN, condFieldN, fieldName);
end;

{------------------------------------------------------------------------------}
{ PEGetNGraphSummaryFields                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNGraphSummaryFields(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint): Smallint;
var
  CrpeGetNGraphSummaryFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNGraphSummaryFields := GetProcAddress(CRDEngine, 'PEGetNGraphSummaryFields');
  if CrpeGetNGraphSummaryFields = nil then
    CRDEngineError('PEGetNGraphSummaryFields')
  else
    Result := TPEGetNGraphSummaryFields(CrpeGetNGraphSummaryFields)(printJob,
      sectionN, graphN);
end;

{------------------------------------------------------------------------------}
{ PEGetNthGraphSummaryFieldInfo                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthGraphSummaryFieldInfo(printJob: Smallint; graphN: Smallint;
  fieldN: Smallint; var summaryFieldInfo: PEFieldDefinitionInfo): Bool;
var
  CrpeGetNthGraphSummaryFieldInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthGraphSummaryFieldInfo := GetProcAddress(CRDEngine, 'PEGetNthGraphSummaryFieldInfo');
  if CrpeGetNthGraphSummaryFieldInfo = nil then
    CRDEngineError('PEGetNthGraphSummaryFieldInfo')
  else
  begin
    summaryFieldInfo.StructSize := SizeOf(PEFieldDefinitionInfo);
    Result := TPEGetNthGraphSummaryFieldInfo(CrpeGetNthGraphSummaryFieldInfo)(printJob,
      graphN, fieldN, summaryFieldInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetGraphTextDefaultOption                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGraphTextDefaultOption(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleType: Word; useDefault: Bool): Bool;
var
  CrpeSetGraphTextDefaultOption : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGraphTextDefaultOption := GetProcAddress(CRDEngine, 'PESetGraphTextDefaultOption');
  if CrpeSetGraphTextDefaultOption = nil then
    CRDEngineError('PESetGraphTextDefaultOption')
  else
    Result := TPESetGraphTextDefaultOption(CrpeSetGraphTextDefaultOption)
      (printJob, sectionN, graphN, titleType, useDefault);
end;

{------------------------------------------------------------------------------}
{ PEGetGraphTextDefaultOption                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetGraphTextDefaultOption(printJob: Smallint; sectionN: Smallint;
  graphN: Smallint; titleType: Word; var useDefault: Bool): Bool;
var
  CrpeGetGraphTextDefaultOption : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetGraphTextDefaultOption := GetProcAddress(CRDEngine, 'PEGetGraphTextDefaultOption');
  if CrpeGetGraphTextDefaultOption = nil then
    CRDEngineError('PEGetGraphTextDefaultOption')
  else
    Result := TPEGetGraphTextDefaultOption(CrpeGetGraphTextDefaultOption)
      (printJob, sectionN, graphN, titleType, useDefault);
end;

{------------------------------------------------------------------------------}
{ PEGetObjectNHiliteConditions                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectNHiliteConditions(printJob: Smallint; hObject: DWord): Smallint;
var
  CrpeGetObjectNHiliteConditions : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectNHiliteConditions := GetProcAddress(CRDEngine, 'PEGetObjectNHiliteConditions');
  if CrpeGetObjectNHiliteConditions = nil then
    CRDEngineError('PEGetObjectNHiliteConditions')
  else
    Result := TPEGetObjectNHiliteConditions(CrpeGetObjectNHiliteConditions)
      (printJob, hObject);
end;

{------------------------------------------------------------------------------}
{ PESetObjectNthHiliteCondition                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectNthHiliteCondition(printJob: Smallint; hObject: DWord;
  nHilite: Smallint; var hiliteInfo: PEObjectHiliteInfo): Bool;
var
  CrpeSetObjectNthHiliteCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectNthHiliteCondition := GetProcAddress(CRDEngine, 'PESetObjectNthHiliteCondition');
  if CrpeSetObjectNthHiliteCondition = nil then
    CRDEngineError('PESetObjectNthHiliteCondition')
  else
  begin
    hiliteInfo.StructSize := SizeOf(PEObjectHiliteInfo);
    Result := TPESetObjectNthHiliteCondition(CrpeSetObjectNthHiliteCondition)
      (printJob, hObject, nHilite, hiliteInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetObjectNthHiliteCondition                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectNthHiliteCondition(printJob: Smallint; hObject: DWord;
  nHilite: Smallint; var hiliteInfo: PEObjectHiliteInfo): Bool;
var
  CrpeGetObjectNthHiliteCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectNthHiliteCondition := GetProcAddress(CRDEngine, 'PEGetObjectNthHiliteCondition');
  if CrpeGetObjectNthHiliteCondition = nil then
    CRDEngineError('PEGetObjectNthHiliteCondition')
  else
  begin
    hiliteInfo.StructSize := SizeOf(PEObjectHiliteInfo);
    Result := TPEGetObjectNthHiliteCondition(CrpeGetObjectNthHiliteCondition)
      (printJob, hObject, nHilite, hiliteInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEAddObjectHiliteCondition                                                   }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEAddObjectHiliteCondition(printJob: Smallint; hObject: DWord;
  var hiliteInfo: PEObjectHiliteInfo): Bool;
var
  CrpeAddObjectHiliteCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeAddObjectHiliteCondition := GetProcAddress(CRDEngine, 'PEAddObjectHiliteCondition');
  if CrpeAddObjectHiliteCondition = nil then
    CRDEngineError('PEAddObjectHiliteCondition')
  else
  begin
    hiliteInfo.StructSize := SizeOf(PEObjectHiliteInfo);
    Result := TPEAddObjectHiliteCondition(CrpeAddObjectHiliteCondition)
      (printJob, hObject, hiliteInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PERemoveObjectNthHiliteCondition                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PERemoveObjectNthHiliteCondition(printJob: Smallint; hObject: DWord;
  nHilite: Smallint): Bool;
var
  CrpeRemoveObjectNthHiliteCondition : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeRemoveObjectNthHiliteCondition := GetProcAddress(CRDEngine, 'PERemoveObjectNthHiliteCondition');
  if CrpeRemoveObjectNthHiliteCondition = nil then
    CRDEngineError('PERemoveObjectNthHiliteCondition')
  else
    Result := TPERemoveObjectNthHiliteCondition(CrpeRemoveObjectNthHiliteCondition)
      (printJob, hObject, nHilite);
end;

{------------------------------------------------------------------------------}
{ PEClearObjectHiliteConditions                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEClearObjectHiliteConditions(printJob: Smallint; hObject: DWord): Bool;
var
  CrpeClearObjectHiliteConditions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeClearObjectHiliteConditions := GetProcAddress(CRDEngine, 'PEClearObjectHiliteConditions');
  if CrpeClearObjectHiliteConditions = nil then
    CRDEngineError('PEClearObjectHiliteConditions')
  else
    Result := TPEClearObjectHiliteConditions(CrpeClearObjectHiliteConditions)
      (printJob, hObject);
end;

{------------------------------------------------------------------------------}
{ PESetObjectNthHiliteConditionPriority                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetObjectNthHiliteConditionPriority(printJob: Smallint; hObject: DWord;
  nHilite: Smallint; newPriority: Smallint): Bool;
var
  CrpeSetObjectNthHiliteConditionPriority : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetObjectNthHiliteConditionPriority := GetProcAddress(CRDEngine, 'PESetObjectNthHiliteConditionPriority');
  if CrpeSetObjectNthHiliteConditionPriority = nil then
    CRDEngineError('PESetObjectNthHiliteConditionPriority')
  else
    Result := TPESetObjectNthHiliteConditionPriority(CrpeSetObjectNthHiliteConditionPriority)
      (printJob, hObject, nHilite, newPriority);
end;

{------------------------------------------------------------------------------}
{ PEGetNRunningTotals                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNRunningTotals(printJob: Smallint): Smallint;
var
  CrpeGetNRunningTotals : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNRunningTotals := GetProcAddress(CRDEngine, 'PEGetNRunningTotals');
  if CrpeGetNRunningTotals = nil then
    CRDEngineError('PEGetNRunningTotals')
  else
    Result := TPEGetNRunningTotals(CrpeGetNRunningTotals)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthRunningTotalName                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthRunningTotalName(printJob: Smallint; runningtotalN: Smallint;
  var nameHandle: HWnd; var nameLength: Smallint): Bool;
var
  CrpeGetNthRunningTotalName : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthRunningTotalName := GetProcAddress(CRDEngine, 'PEGetNthRunningTotalName');
  if CrpeGetNthRunningTotalName = nil then
    CRDEngineError('PEGetNthRunningTotalName')
  else
    Result := TPEGetNthRunningTotalName(CrpeGetNthRunningTotalName)(printJob,
      runningtotalN, nameHandle, nameLength);
end;

{------------------------------------------------------------------------------}
{ PEGetRunningTotalInfo                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetRunningTotalInfo(printJob: Smallint; rtName: PChar;
  var rtInfo: PERunningTotalInfo): Bool;
var
  CrpeGetRunningTotalInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetRunningTotalInfo := GetProcAddress(CRDEngine, 'PEGetRunningTotalInfo');
  if CrpeGetRunningTotalInfo = nil then
    CRDEngineError('PEGetRunningTotalInfo')
  else
  begin
    rtInfo.StructSize := SizeOf(PERunningTotalInfo);
    Result := TPEGetRunningTotalInfo(CrpeGetRunningTotalInfo)(printJob,
      rtName, rtInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetRunningTotalConditionField                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetRunningTotalConditionField(printJob: Smallint; rtName: PChar;
  var hEvalField: HWnd; var evalLength: Smallint; var hResetField: HWnd;
  var resetLength: Smallint): Bool;
var
  CrpeGetRunningTotalConditionField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetRunningTotalConditionField := GetProcAddress(CRDEngine, 'PEGetRunningTotalConditionField');
  if CrpeGetRunningTotalConditionField = nil then
    CRDEngineError('PEGetRunningTotalConditionField')
  else
    Result := TPEGetRunningTotalConditionField(CrpeGetRunningTotalConditionField)
      (printJob, rtName, hEvalField, evalLength, hResetField, resetLength);
end;

{------------------------------------------------------------------------------}
{ PEGetRunningTotalConditionFormula                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetRunningTotalConditionFormula(printJob: Smallint; rtName: PChar;
  var hEvalFormula: HWnd; var evalLength: Smallint; var hResetFormula: HWnd;
  var resetLength: Smallint): Bool;
var
  CrpeGetRunningTotalConditionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetRunningTotalConditionFormula := GetProcAddress(CRDEngine, 'PEGetRunningTotalConditionFormula');
  if CrpeGetRunningTotalConditionFormula = nil then
    CRDEngineError('PEGetRunningTotalConditionFormula')
  else
    Result := TPEGetRunningTotalConditionFormula(CrpeGetRunningTotalConditionFormula)
      (printJob, rtName, hEvalFormula, evalLength, hResetFormula, resetLength);
end;

{------------------------------------------------------------------------------}
{ PEGetRunningTotalSummaryField                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetRunningTotalSummaryField(printJob: Smallint; rtName: PChar;
  var summaryFieldName: HWnd; var summaryLength: Smallint;
  var secondFieldName: HWnd; var secondLength: Smallint): Bool;
var
  CrpeGetRunningTotalSummaryField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetRunningTotalSummaryField := GetProcAddress(CRDEngine, 'PEGetRunningTotalSummaryField');
  if CrpeGetRunningTotalSummaryField = nil then
    CRDEngineError('PEGetRunningTotalSummaryField')
  else
    Result := TPEGetRunningTotalSummaryField(CrpeGetRunningTotalSummaryField)
      (printJob, rtName, summaryFieldName, summaryLength, secondFieldName,
       secondLength);
end;

{------------------------------------------------------------------------------}
{ PEGetMapDataInfo                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapDataInfo(printJob: Smallint; hObject: DWord;
  var mapInfo: PEMapDataInfo): Bool;
var
  CrpeGetMapDataInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapDataInfo := GetProcAddress(CRDEngine, 'PEGetMapDataInfo');
  if CrpeGetMapDataInfo = nil then
    CRDEngineError('PEGetMapDataInfo')
  else
  begin
    mapInfo.StructSize := SizeOf(PEMapDataInfo);
    Result := TPEGetMapDataInfo(CrpeGetMapDataInfo)(printJob, hObject,
      mapInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetMapDataInfo                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapDataInfo(printJob: Smallint; hObject: DWord;
  var mapInfo: PEMapDataInfo): Bool;
var
  CrpeSetMapDataInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapDataInfo := GetProcAddress(CRDEngine, 'PESetMapDataInfo');
  if CrpeSetMapDataInfo = nil then
    CRDEngineError('PESetMapDataInfo')
  else
  begin
    mapInfo.StructSize := SizeOf(PEMapDataInfo);
    Result := TPESetMapDataInfo(CrpeSetMapDataInfo)(printJob,
      hObject, mapInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetMapStyle                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapStyle(printJob: Smallint; hObject: DWord;
  var mapStyle: PEMapStyle): Bool;
var
  CrpeGetMapStyle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapStyle := GetProcAddress(CRDEngine, 'PEGetMapStyle');
  if CrpeGetMapStyle = nil then
    CRDEngineError('PEGetMapStyle')
  else
  begin
    mapStyle.StructSize := SizeOf(PEMapStyle);
    Result := TPEGetMapStyle(CrpeGetMapStyle)(printJob,
      hObject, mapStyle);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetMapStyle                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapStyle(printJob: Smallint; hObject: DWord;
  var mapStyle: PEMapStyle): Bool;
var
  CrpeSetMapStyle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapStyle := GetProcAddress(CRDEngine, 'PESetMapStyle');
  if CrpeSetMapStyle = nil then
    CRDEngineError('PESetMapStyle')
  else
  begin
    mapStyle.StructSize := SizeOf(PEMapStyle);
    Result := TPESetMapStyle(CrpeSetMapStyle)(printJob, hObject,
      mapStyle);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNMapSummaryFields                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNMapSummaryFields(printJob : Smallint; hObject: DWord): Smallint;
var
  CrpeGetNMapSummaryFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNMapSummaryFields := GetProcAddress(CRDEngine, 'PEGetNMapSummaryFields');
  if CrpeGetNMapSummaryFields = nil then
    CRDEngineError('PEGetNMapSummaryFields')
  else
    Result := TPEGetNMapSummaryFields(CrpeGetNMapSummaryFields)(printJob,
      hObject)
end;

{------------------------------------------------------------------------------}
{ PEGetNthMapSummaryField                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthMapSummaryField(printJob: Smallint; hObject: DWord;
  nSummaryField: Smallint; var summaryField: HWnd; var summaryLength: Smallint): Bool;
var
  CrpeGetNthMapSummaryField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthMapSummaryField := GetProcAddress(CRDEngine, 'PEGetNthMapSummaryField');
  if CrpeGetNthMapSummaryField = nil then
    CRDEngineError('PEGetNthMapSummaryField')
  else
    Result := TPEGetNthMapSummaryField(CrpeGetNthMapSummaryField)(printJob,
      hObject, nSummaryField, summaryField, summaryLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthMapSummaryField                                                      }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthMapSummaryField(printJob: Smallint; hObject: DWord;
  nSummaryField: Smallint; summaryField: PChar): Bool;
var
  CrpeSetNthMapSummaryField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthMapSummaryField := GetProcAddress(CRDEngine, 'PESetNthMapSummaryField');
  if CrpeSetNthMapSummaryField = nil then
    CRDEngineError('PESetNthMapSummaryField')
  else
    Result := TPESetNthMapSummaryField(CrpeSetNthMapSummaryField)(printJob,
      hObject, nSummaryField, summaryField);
end;

{------------------------------------------------------------------------------}
{ PEGetNMapConditionFields                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNMapConditionFields(printJob: Smallint; hObject: DWord): Smallint;
var
  CrpeGetNMapConditionFields : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNMapConditionFields := GetProcAddress(CRDEngine, 'PEGetNMapConditionFields');
  if CrpeGetNMapConditionFields = nil then
    CRDEngineError('PEGetNMapConditionFields')
  else
    Result := TPEGetNMapConditionFields(CrpeGetNMapConditionFields)(printJob,
      hObject);
end;

{------------------------------------------------------------------------------}
{ PEGetNthMapConditionField                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthMapConditionField(printJob: Smallint; hObject: DWord;
  condFieldN: Smallint; var conditionField: HWnd; var conditionLength: Smallint): Bool;
var
  CrpeGetNthMapConditionField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthMapConditionField := GetProcAddress(CRDEngine, 'PEGetNthMapConditionField');
  if CrpeGetNthMapConditionField = nil then
    CRDEngineError('PEGetNthMapConditionField')
  else
    Result := TPEGetNthMapConditionField(CrpeGetNthMapConditionField)(printJob,
      hObject, condFieldN, conditionField, conditionLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthMapConditionField                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthMapConditionField(printJob: Smallint; hObject: DWord;
  condFieldN: Smallint; fieldName: PChar): Bool;
var
  CrpeSetNthMapConditionField : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthMapConditionField := GetProcAddress(CRDEngine, 'PESetNthMapConditionField');
  if CrpeSetNthMapConditionField = nil then
    CRDEngineError('PESetNthMapConditionField')
  else
    Result := TPESetNthMapConditionField(CrpeSetNthMapConditionField)
      (printJob, hObject, condFieldN, fieldName);
end;

{------------------------------------------------------------------------------}
{ PESetMapConditions                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapConditions(printJob: Smallint; hObject: DWord;
  var mapCondition: PEMapCondition): Bool;
var
  CrpeSetMapConditions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapConditions := GetProcAddress(CRDEngine, 'PESetMapConditions');
  if CrpeSetMapConditions = nil then
    CRDEngineError('PESetMapConditions')
  else
  begin
    mapCondition.StructSize := SizeOf(PEMapCondition);
    Result := TPESetMapConditions(CrpeSetMapConditions)(printJob,
      hObject, mapCondition);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetMapConditions                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapConditions(printJob: Smallint; hObject: DWord;
  var mapCondition: PEMapCondition): Bool;
var
  CrpeGetMapConditions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapConditions := GetProcAddress(CRDEngine, 'PEGetMapConditions');
  if CrpeGetMapConditions = nil then
    CRDEngineError('PEGetMapConditions')
  else
  begin
    mapCondition.StructSize := SizeOf(PEMapCondition);
    Result := TPEGetMapConditions(CrpeGetMapConditions)(printJob,
      hObject, mapCondition);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetMapTitle                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapTitle(printJob: Smallint; hObject: DWord;
  mapTitle: PChar): Bool;
var
  CrpeSetMapTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapTitle := GetProcAddress(CRDEngine, 'PESetMapTitle');
  if CrpeSetMapTitle = nil then
    CRDEngineError('PESetMapTitle')
  else
  begin
    Result := TPESetMapTitle(CrpeSetMapTitle)(printJob, hObject,
      mapTitle);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetMapTitle                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapTitle(printJob: Smallint; hObject: DWord;
  var mapTitle: HWnd; var titleLength: Smallint): Bool;
var
  CrpeGetMapTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapTitle := GetProcAddress(CRDEngine, 'PEGetMapTitle');
  if CrpeGetMapTitle = nil then
    CRDEngineError('PEGetMapTitle')
  else
    Result := TPEGetMapTitle(CrpeGetMapTitle)(printJob, hObject,
      mapTitle, titleLength);
end;

{------------------------------------------------------------------------------}
{ PESetMapLegendTitle                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapLegendTitle(printJob: Smallint; hObject: DWord;
  legendTitle: PChar): Bool;
var
  CrpeSetMapLegendTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapLegendTitle := GetProcAddress(CRDEngine, 'PESetMapLegendTitle');
  if CrpeSetMapLegendTitle = nil then
    CRDEngineError('PESetMapLegendTitle')
  else
    Result := TPESetMapLegendTitle(CrpeSetMapLegendTitle)(printJob,
      hObject, legendTitle);
end;

{------------------------------------------------------------------------------}
{ PEGetMapLegendTitle                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapLegendTitle(printJob: Smallint; hObject: DWord;
  var legendTitle: HWnd; var legendLength: Smallint): Bool;
var
  CrpeGetMapLegendTitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapLegendTitle := GetProcAddress(CRDEngine, 'PEGetMapLegendTitle');
  if CrpeGetMapLegendTitle = nil then
    CRDEngineError('PEGetMapLegendTitle')
  else
    Result := TPEGetMapLegendTitle(CrpeGetMapLegendTitle)(printJob,
      hObject, legendTitle, legendLength);
end;

{------------------------------------------------------------------------------}
{ PESetMapLegendSubtitle                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetMapLegendSubtitle(printJob: Smallint; hObject: DWord;
  legendSubtitle: PChar): Bool;
var
  CrpeSetMapLegendSubtitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetMapLegendSubtitle := GetProcAddress(CRDEngine, 'PESetMapLegendSubtitle');
  if CrpeSetMapLegendSubtitle = nil then
    CRDEngineError('PESetMapLegendSubtitle')
  else
    Result := TPESetMapLegendSubtitle(CrpeSetMapLegendSubtitle)(printJob,
      hObject, legendSubtitle);
end;

{------------------------------------------------------------------------------}
{ PEGetMapLegendSubtitle                                                       }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetMapLegendSubtitle(printJob: Smallint; hObject: DWord;
  var legendSubtitle: HWnd; var legendLength: Smallint): Bool;
var
  CrpeGetMapLegendSubtitle : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetMapLegendSubtitle := GetProcAddress(CRDEngine, 'PEGetMapLegendSubtitle');
  if CrpeGetMapLegendSubtitle = nil then
    CRDEngineError('PEGetMapLegendSubtitle')
  else
    Result := TPEGetMapLegendSubtitle(CrpeGetMapLegendSubtitle)(printJob,
      hObject, legendSubtitle, legendLength);
end;

{------------------------------------------------------------------------------}
{ PESetFormulaSyntax                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetFormulaSyntax(printJob: Smallint; var formulaSyntax: PEFormulaSyntax): Bool;
var
  CrpeSetFormulaSyntax : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetFormulaSyntax := GetProcAddress(CRDEngine, 'PESetFormulaSyntax');
  if CrpeSetFormulaSyntax = nil then
    CRDEngineError('PESetFormulaSyntax')
  else
  begin
    formulaSyntax.StructSize := SizeOf(PEFormulaSyntax);
    Result := TPESetFormulaSyntax(CrpeSetFormulaSyntax)(printJob, formulaSyntax);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetFormulaSyntax                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetFormulaSyntax(printJob: Smallint; var formulaSyntax: PEFormulaSyntax): Bool;
var
  CrpeGetFormulaSyntax : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetFormulaSyntax := GetProcAddress(CRDEngine, 'PEGetFormulaSyntax');
  if CrpeGetFormulaSyntax = nil then
    CRDEngineError('PEGetFormulaSyntax')
  else
  begin
    formulaSyntax.StructSize := SizeOf(PEFormulaSyntax);
    Result := TPEGetFormulaSyntax(CrpeGetFormulaSyntax)(printJob, formulaSyntax);
  end;
end;

{------------------------------------------------------------------------------}
{ PESavePrintJob                                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESavePrintJob(printJob: Smallint; reportFilePath: PChar): Bool;
var
  CrpeSavePrintJob : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSavePrintJob := GetProcAddress(CRDEngine, 'PESavePrintJob');
  if CrpeSavePrintJob = nil then
    CRDEngineError('PESavePrintJob')
  else
    Result := TPESavePrintJob(CrpeSavePrintJob)(printJob, reportFilePath);
end;

{------------------------------------------------------------------------------}
{ PESavePrintJobAs                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESavePrintJobAs(printJob: Smallint; reportFilePath: PChar;
  saveAsFormat: LongInt; reserved: Pointer): Bool;
var
  CrpeSavePrintJobAs : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSavePrintJobAs := GetProcAddress(CRDEngine, 'PESavePrintJobAs');
  if CrpeSavePrintJobAs = nil then
    CRDEngineError('PESavePrintJobAs')
  else
    Result := TPESavePrintJobAs(CrpeSavePrintJobAs)(printJob,
      reportFilePath, saveAsFormat, reserved);
end;

{------------------------------------------------------------------------------}
{ PESetTimeLimit                                                               }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetTimeLimit(printJob: Smallint; timeLimit: LongInt): Bool;
var
  CrpeSetTimeLimit : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetTimeLimit := GetProcAddress(CRDEngine, 'PESetTimeLimit');
  if CrpeSetTimeLimit = nil then
    CRDEngineError('PESetTimeLimit')
  else
    Result := TPESetTimeLimit(CrpeSetTimeLimit)(printJob, timeLimit);
end;

{------------------------------------------------------------------------------}
{ PEGetPercentCompleted                                                        }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetPercentCompleted(printJob: Smallint): LongInt;
var
  CrpeGetPercentCompleted : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetPercentCompleted := GetProcAddress(CRDEngine, 'PEGetPercentCompleted');
  if CrpeGetPercentCompleted = nil then
    CRDEngineError('PEGetPercentCompleted')
  else
    Result := TPEGetPercentCompleted(CrpeGetPercentCompleted)(printJob);
end;

{------------------------------------------------------------------------------}
{ PESetReadRecordLimit                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetReadRecordLimit(printJob: Smallint; recordsLimit: Longint): Bool;
var
  CrpeSetReadRecordLimit : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetReadRecordLimit := GetProcAddress(CRDEngine, 'PESetReadRecordLimit');
  if CrpeSetReadRecordLimit = nil then
    CRDEngineError('PESetReadRecordLimit')
  else
    Result := TPESetReadRecordLimit(CrpeSetReadRecordLimit)(printJob,
      recordsLimit);
end;

{------------------------------------------------------------------------------}
{ PEGetReadPercentCompleted                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetReadPercentCompleted(printJob: Smallint): LongInt;
var
  CrpeGetReadPercentCompleted : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetReadPercentCompleted := GetProcAddress(CRDEngine, 'PEGetReadPercentCompleted');
  if CrpeGetReadPercentCompleted = nil then
    CRDEngineError('PEGetReadPercentCompleted')
  else
    Result := TPEGetReadPercentCompleted(CrpeGetReadPercentCompleted)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEIsJobPremature                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEIsJobPremature(printJob: Smallint): Bool;
var
  CrpeIsJobPremature : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeIsJobPremature := GetProcAddress(CRDEngine, 'PEIsJobPremature');
  if CrpeIsJobPremature = nil then
    CRDEngineError('PEIsJobPremature')
  else
    Result := TPEIsJobPremature(CrpeIsJobPremature)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetStartPageNumber                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetStartPageNumber(printJob: Smallint; var pageN: Longint): Bool;
var
  CrpeGetStartPageNumber : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetStartPageNumber := GetProcAddress(CRDEngine, 'PEGetStartPageNumber');
  if CrpeGetStartPageNumber = nil then
    CRDEngineError('PEGetStartPageNumber')
  else
    Result := TPEGetStartPageNumber(CrpeGetStartPageNumber)(printJob, pageN);
end;

{------------------------------------------------------------------------------}
{ PESetStartPageNumber                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetStartPageNumber(printJob: Smallint; pageN: Longint): Bool;
var
  CrpeSetStartPageNumber : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetStartPageNumber := GetProcAddress(CRDEngine, 'PESetStartPageNumber');
  if CrpeSetStartPageNumber = nil then
    CRDEngineError('PESetStartPageNumber')
  else
    Result := TPESetStartPageNumber(CrpeSetStartPageNumber)(printJob, pageN);
end;

{------------------------------------------------------------------------------}
{ PESetGlobalOptions                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetGlobalOptions(var globalOptions: PEGlobalOptions): Bool;
var
  CrpeSetGlobalOptions : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetGlobalOptions := GetProcAddress(CRDEngine, 'PESetGlobalOptions');
  if CrpeSetGlobalOptions = nil then
    CRDEngineError('PESetGlobalOptions')
  else
  begin
    globalOptions.structSize := SizeOf(PEGlobalOptions);
    Result := TPESetGlobalOptions(CrpeSetGlobalOptions)(globalOptions);
  end;
end;

{------------------------------------------------------------------------------}
{ PESwapGroups                                                                 }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESwapGroups(printJob: Smallint; sourceGroupN: Smallint;
  targetGroupN: Smallint): Bool;
var
  CrpeSwapGroups : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSwapGroups := GetProcAddress(CRDEngine, 'PESwapGroups');
  if CrpeSwapGroups = nil then
    CRDEngineError('PESwapGroups')
  else
    Result := TPESwapGroups(CrpeSwapGroups)(printJob, sourceGroupN, targetGroupN);
end;

{------------------------------------------------------------------------------}
{ PEGetNSectionsInArea                                                         }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNSectionsInArea(printJob: Smallint; areaCode: Smallint): Smallint;
var
  CrpeGetNSectionsInArea : TFarProc;
begin
  CRDEngineError('');
  Result := -1;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNSectionsInArea := GetProcAddress(CRDEngine, 'PEGetNSectionsInArea');
  if CrpeGetNSectionsInArea = nil then
    CRDEngineError('PEGetNSectionsInArea')
  else
    Result := TPEGetNSectionsInArea(CrpeGetNSectionsInArea)(printJob,
      areaCode);
end;

{------------------------------------------------------------------------------}
{ PEGetSectionWidth                                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionWidth(printJob: Smallint; sectionCode: Smallint;
  var width: Smallint): Bool;
var
  CrpeGetSectionWidth : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionWidth := GetProcAddress(CRDEngine, 'PEGetSectionWidth');
  if CrpeGetSectionWidth = nil then
    CRDEngineError('PEGetSectionWidth')
  else
    Result := TPEGetSectionWidth(CrpeGetSectionWidth)(printJob,
      sectionCode, width);
end;

{------------------------------------------------------------------------------}
{ PEGetNReportAlerts                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNReportAlerts(printJob: Smallint): Smallint;
var
  CrpeGetNReportAlerts : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNReportAlerts := GetProcAddress(CRDEngine, 'PEGetNReportAlerts');
  if CrpeGetNReportAlerts = nil then
    CRDEngineError('PEGetNReportAlerts')
  else
    Result := TPEGetNReportAlerts(CrpeGetNReportAlerts)(printJob);
end;

{------------------------------------------------------------------------------}
{ PEGetNthReportAlert                                                          }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthReportAlert(printJob: Smallint; alertN: Smallint;
  var reportAlertInfo: PEReportAlertInfo): Bool;
var
  CrpeGetNthReportAlert : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthReportAlert := GetProcAddress(CRDEngine, 'PEGetNthReportAlert');
  if CrpeGetNthReportAlert = nil then
    CRDEngineError('PEGetNthReportAlert')
  else
  begin
    reportAlertInfo.StructSize := SizeOf(PEReportAlertInfo);
    Result := TPEGetNthReportAlert(CrpeGetNthReportAlert)(printJob,
      alertN, reportAlertInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetNthAlertInstanceInfo                                                    }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthAlertInstanceInfo(printJob: Smallint; alertN: Smallint;
  instanceN: DWord; var alertInstanceInfo: PEAlertInstanceInfo): Bool;
var
  CrpeGetNthAlertInstanceInfo : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthAlertInstanceInfo := GetProcAddress(CRDEngine, 'PEGetNthAlertInstanceInfo');
  if CrpeGetNthAlertInstanceInfo = nil then
    CRDEngineError('PEGetNthAlertInstanceInfo')
  else
  begin
    alertInstanceInfo.StructSize := SizeOf(PEAlertInstanceInfo);
    Result := TPEGetNthAlertInstanceInfo(CrpeGetNthAlertInstanceInfo)(printJob,
      alertN, instanceN, alertInstanceInfo);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthAlertConditionFormula                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthAlertConditionFormula(printJob: Smallint;
  alertN: Smallint; var formula: PChar): Bool;
var
  CrpeSetNthAlertConditionFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthAlertConditionFormula := GetProcAddress(CRDEngine, 'PESetNthAlertConditionFormula');
  if CrpeSetNthAlertConditionFormula = nil then
    CRDEngineError('PESetNthAlertConditionFormula')
  else
  begin
    Result := TPESetNthAlertConditionFormula(CrpeSetNthAlertConditionFormula)
      (printJob, alertN, formula);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthAlertMessageFormula                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthAlertMessageFormula(printJob: Smallint; alertN: Smallint;
  var formula: PChar): Bool;
var
  CrpeSetNthAlertMessageFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthAlertMessageFormula := GetProcAddress(CRDEngine, 'PESetNthAlertMessageFormula');
  if CrpeSetNthAlertMessageFormula = nil then
    CRDEngineError('PESetNthAlertMessageFormula')
  else
  begin
    Result := TPESetNthAlertMessageFormula(CrpeSetNthAlertMessageFormula)
      (printJob, alertN, formula);
  end;
end;

{------------------------------------------------------------------------------}
{ PESetNthAlertDefaultMessage                                                  }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthAlertDefaultMessage(printJob: Smallint; alertN: Smallint;
  var text: PChar): Bool;
var
  CrpeSetNthAlertDefaultMessage : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthAlertDefaultMessage := GetProcAddress(CRDEngine, 'PESetNthAlertDefaultMessage');
  if CrpeSetNthAlertDefaultMessage = nil then
    CRDEngineError('PESetNthAlertDefaultMessage')
  else
  begin
    Result := TPESetNthAlertDefaultMessage(CrpeSetNthAlertDefaultMessage)
      (printJob, alertN, text);
  end;
end;

{------------------------------------------------------------------------------}
{ PEEnableNthAlert                                                             }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEEnableNthAlert(printJob: Smallint; alertN: Smallint;
  enabled: Bool): Bool;
var
  CrpeEnableNthAlert : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeEnableNthAlert := GetProcAddress(CRDEngine, 'PEEnableNthAlert');
  if CrpeEnableNthAlert = nil then
    CRDEngineError('PEEnableNthAlert')
  else
  begin
    Result := TPEEnableNthAlert(CrpeEnableNthAlert)(printJob,
      alertN, enabled);
  end;
end;

{------------------------------------------------------------------------------}
{ PEGetObjectByName                                                            }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectByName(printJob : Smallint; name: PChar): DWORD;
var
  CrpeGetObjectByName : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectByName := GetProcAddress(CRDEngine, 'PEGetObjectByName');
  if CrpeGetObjectByName = nil then
    CRDEngineError('PEGetObjectByName')
  else
    Result := TPEGetObjectByName(CrpeGetObjectByName)(printJob, name);
end;

{------------------------------------------------------------------------------}
{ PEGetObjectName                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetObjectName (printJob: Smallint; objectHandle: DWord;
  var objectNameHandle: HWnd; var objectNameLength: Smallint): Bool;
var
  CrpeGetObjectName : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetObjectName := GetProcAddress(CRDEngine, 'PEGetObjectName');
  if CrpeGetObjectName = nil then
    CRDEngineError('PEGetObjectName')
  else
    Result := TPEGetObjectName(CrpeGetObjectName)(printJob, objectHandle,
      objectNameHandle, objectNameLength);
end;

{------------------------------------------------------------------------------}
{ PEGetSectionByName                                                           }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetSectionByName(printJob: Smallint; name: PChar): Smallint;
var
  CrpeGetSectionByName : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetSectionByName := GetProcAddress(CRDEngine, 'PEGetSectionByName');
  if CrpeGetSectionByName = nil then
    CRDEngineError('PEGetSectionByName')
  else
    Result := TPEGetSectionByName(CrpeGetSectionByName)(printJob, name);
end;

{------------------------------------------------------------------------------}
{ PEGetAreaByName                                                              }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetAreaByName(printJob: Smallint; name: PChar): Smallint;
var
  CrpeGetAreaByName : TFarProc;
begin
  CRDEngineError('');
  Result := 0;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetAreaByName := GetProcAddress(CRDEngine, 'PEGetAreaByName');
  if CrpeGetAreaByName = nil then
    CRDEngineError('PEGetAreaByName')
  else
    Result := TPEGetAreaByName(CrpeGetAreaByName)(printJob, name);
end;

{------------------------------------------------------------------------------}
{ PEGetAreaName                                                                }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetAreaName (printJob: Smallint; areaCode: Smallint;
  var nameHandle: HWnd; var nameLength: Smallint): Bool;
var
  CrpeGetAreaName : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetAreaName := GetProcAddress(CRDEngine, 'PEGetAreaName');
  if CrpeGetAreaName = nil then
    CRDEngineError('PEGetAreaName')
  else
    Result := TPEGetAreaName(CrpeGetAreaName)(printJob, areaCode,
      nameHandle, nameLength);
end;

{------------------------------------------------------------------------------}
{ PEGetNthGroupNameFormula                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PEGetNthGroupNameFormula(printJob: Smallint; groupN: Smallint;
  var textHandle: HWnd; var textLength: Smallint): Bool;
var
  CrpeGetNthGroupNameFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeGetNthGroupNameFormula := GetProcAddress(CRDEngine, 'PEGetNthGroupNameFormula');
  if CrpeGetNthGroupNameFormula = nil then
    CRDEngineError('PEGetNthGroupNameFormula')
  else
    Result := TPEGetNthGroupNameFormula(CrpeGetNthGroupNameFormula)(printJob,
      groupN, textHandle, textLength);
end;

{------------------------------------------------------------------------------}
{ PESetNthGroupNameFormula                                                     }
{------------------------------------------------------------------------------}
function TCrpeEngine.PESetNthGroupNameFormula(printJob: Smallint; groupN: Smallint;
  fString: PChar): Bool;
var
  CrpeSetNthGroupNameFormula : TFarProc;
begin
  CRDEngineError('');
  Result := False;
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetNthGroupNameFormula := GetProcAddress(CRDEngine, 'PESetNthGroupNameFormula');
  if CrpeSetNthGroupNameFormula = nil then
    CRDEngineError('PESetNthGroupNameFormula')
  else
    Result := TPESetNthGroupNameFormula(CrpeSetNthGroupNameFormula)(printJob,
      groupN, fString);
end;

{------------------------------------------------------------------------------}
{ PESetTempFilePath                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeEngine.PESetTempFilePath (Path: PChar);
var
  CrpeSetTempFilePath : TFarProc;
begin
  CRDEngineError('');
  {Check if Engine is loaded}
  if CRDEngine = 0 then
  begin
    CRDEngineError(CRD_ENGINE_NOT_LOADED);
    Exit;
  end;
  CrpeSetTempFilePath := GetProcAddress(CRDEngine, 'PESetTempFilePath');
  if CrpeSetTempFilePath = nil then
    CRDEngineError('PESetTempFilePath')
  else
    TPESetTempFilePath(CrpeSetTempFilePath)(Path);
end;


end.

