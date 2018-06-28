(*
-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/UCrpeClasses.pas $
 Version:            $Revision: #16 $
 Last Modified Date: $Date: 2004/01/27 $

 Copyright (c) 1995-2003 Crystal Decisions, Inc.
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

Crystal Reports VCL Component - Base Classes Unit
=================================================
Version  : 10
Purpose  : This is the base classes unit file of the Crystal Reports
           Delphi VCL Component.  It was split from the main UCrpe32
           unit to avoid a problem with Delphi's debugger not being
           able to trace into code units that were too large.
Supports : Delphi 7
*)

unit UCrpeClasses;

{$I UCRPEDEF.INC}

interface

uses Windows, Classes, Graphics, CRDynamic;

type
  TComponentX = class(TComponent);
  TCrFieldValueType = (fvUnknown, fvInt8s, fvInt8u, fvInt16s,
    fvInt16u, fvInt32s, fvInt32u, fvNumber, fvCurrency, fvBoolean,
    fvDate, fvTime, fvString, fvTransientMemo, fvPersistentMemo,
    fvBlob, fvDateTime, fvBitmap, fvIcon, fvPicture, fvOle, fvGraph);

  {Object Types}
  TCrObjectType = (otUnknown, otField, otText, otLine, otBox, otSubreport,
    otOle, otGraph, otCrossTab, otBlob, otMap, otOLAPCube);
  TCrFieldObjectType = (oftNone, oftDatabase, oftFormula, oftSummary,
    oftSpecialVar, oftGroupName, oftParameter, oftExpression, oftRunningTotal);

  {Objects}
  TCrLineStyle = (lsNone, lsSingle, lsDouble, lsDash, lsDot);

  {HiliteCondition}
  TCrHiliteRangeCondition = (hrcEqualTo, hrcNotEqualTo, hrcLessThan,
    hrcLessThanOrEqualTo, hrcGreaterThan, hrcGreaterThanOrEqualTo,
    hrcBetween, hrcNotBetween);
  TCrHiliteBorderStyle = (hbsDefault, hbsNone, hbsSingleBox, hbsDoubleBox,
    hbsSingleUnderline, hbsDoubleUnderline, hbsSingleOverline, hbsDoubleOverline,
    hbsSingleBoxWithDoubleUnderline);
  TCrHiliteFontStyle = (hfsDefault, hfsRegular, hfsItalic, hfsBold, hfsBoldItalic);

  {Lookup Property Types}
  TCrLookupString = string;
  TCrLookupNumber = integer;

  {Field Alignment}
  TCrHorizontalAlignment = (haDefault, haLeft, haCenter, haRight,
    haJustified, haDecimal);

  {Format Enumerated Types for the FieldFormat properties}
 {Number/Currency}
  {Signed/Unsigned}
  TCrNegativeFormat = (nfNone, nfLeading, nfTrailing, nfBracketed);
  {Rounding}
  TCrRoundingFormat = (rfTenBillionth, rfBillionth, rfHundredMillionth,
    rfTenMillionth, rfMillionth, rfHundredThousandth, rfTenThousandth,
    rfThousandth, rfHundredth, rfTenth, rfUnit, rfTen, rfHundred,
    rfThousand, rfTenThousand, rfHundredThousand, rfMillion);
  {Currency Symbol}
  TCrCurrencySymbolFormat = (csfNone, csfFixed, csfFloating);
  {Currency Symbol Placement}
  TCrCurrencySymbolPosition = (cspLeadingInside, cspLeadingOutside,
    cspTrailingInside, cspTrailingOutside);

 {Boolean}
  {Boolean Type}
  TCrBooleanType = (TrueFalse, TF, YesNo, YN, OneZero);

 {Date}
  {Date Type}
  TCrDateType = (dfWindowsLong, dfWindowsShort, dfUserDefined);
  {Calendar Type}
  TCrCalendarType = (ctGregorian, ctGregorianus, ctJapanese,
    ctTaiwanese, ctKorean, ctHijri, ctThai, ctHebrew, ctGregorianMEFrench,
    ctGregorianArabic, ctGregorianTransEnglish, ctGregorianTransFrench);
  {Date Order}
  TCrDateOrder = (doYMD, doDMY, doMDY);
  {Year Format}
  TCrYearFormat = (yfShort, yfLong, yfNone);
  {Month Format}
  TCrMonthFormat = (mfNumeric, mfLeadingZeroNumeric, mfShort,
    mfLong, mfNone);
  {Day Format}
  TCrDayFormat = (dfNumeric, dfLeadingZeroNumeric, dfNone);
  {Day of Week Typee}
  TCrDayOfWeekType = (dwfShort, dwfLong, dwfNone);
  {Day of Week Position}
  TCrDayOfWeekPosition = (dwpLeading, dwpTrailing);
  {Day of Week Enclosure}
  TCrDayOfWeekEnclosure = (dweNone, dweParentheses, dweFWParentheses,
    dweSquareBrackets, dweFWSquareBrackets);
  {Date Era}
  TCrDateEra = (deShort, deLong, deNone);

 {Time}
  {Time Base}
  TCrTimeBase = (tf12Hour, tf24Hour);
  {AM/PM Placement}
  TCrAmPmPosition = (ampmBefore, ampmAfter);
  {HourType, MinuteType, SecondType}
  TCrTimeFormat = (tfNumeric, tfNoLeadingZero, tfNone);

 {DateTime}
  {DateTime Order}
  TCrDateTimeOrder = (dtoDateTime, dtoTimeDate, dtoDate, dtoTime);

 {Text}
  {Text Interpretation}
  TCrTextInterpretation = (tiNone, tiRTF, tiHTML);
  {Line Spacing}
  TCrLineSpacingType = (lsMultiple, lsExact);
  {Text Rotation - in degrees}
  TCrTextRotation = (trZero, tr90, tr270);

  {FormatFormula Names}
  TCrFormatFormulaName = (
    {Number/Currency}
    ffnSuppressIfZero, ffnNegativeFormat, ffnUseThousandsSeparators,
    ffnUseLeadingZero, ffnDecimalPlaces, ffnRoundingFormat,
    ffnCurrencySymbolFormat, ffnOneCurrencySymbolPerPage,
    ffnCurrencySymbolPosition, ffnThousandSymbol, ffnDecimalSymbol,
    ffnCurrencySymbol, ffnReverseSignForDisplay,
    {FieldClipping}
    ffnAllowFieldClipping,
    {Boolean}
    ffnBooleanType,
    {Date}
    ffnDateType, ffnDateOrder, ffnYearFormat, ffnMonthFormat,
    ffnDayFormat, ffnFirstDateSeparator, ffnSecondDateSeparator, ffnDayOfWeekType,
    ffnDayOfWeekSeparator, ffnDayOfWeekPosition, ffnDateEraFormat, ffnCalendarType,
    ffnPrefixSeparator, ffnSuffixSeparator, ffnDayOfWeekEnclosure,
    {Time}
    ffnTimeBase, ffnAmPmPosition, ffnHourType, ffnMinuteType, ffnSecondType,
    ffnHourMinSeparator, ffnMinSecSeparator, ffnAMString, ffnPMString,
    {DateTime}
    ffnDateTimeOrder, ffnDateTimeSeparator,
    {Text - first 3 not used in 5.x}
    ffnFirstLineIndent, ffnLeftIndent, ffnRightIndent, ffnMaxNLines,
    ffnTextInterpretation {Text interpretation of string & memo database fields},
    {Font}
    ffnFontColor);

TCrpeBorder = class;
TCrpeFormatA = class;
TCrpeFormatC = class;
TCrpeFieldFormat = class;
TCrpeFieldObjectFormat = class;
TCrpeParagraphFormat = class;
TCrpeFormatFormulasA = class;
TCrpeFormatFormulasB = class;
TCrpeFont = class;
TCrpeHiliteConditions = class;


{------------------------------------------------------------------------------}
{ Class TCrpePersistent                                                        }
{  - same as TPersistent but with reference to TCrpe object                    }
{------------------------------------------------------------------------------}
   TCrpePersistent = class(TPersistent)
   private
   protected
     FSubClassList : TList;
   published
   public
     Cx      : TComponent;  {Reference pointer: for internal use}
     FIndex  : integer;
     Handle  : DWord;
     Parent  : TCrpePersistent;
     procedure PropagateCrpe (const Crpe: TComponent; const Par: TCrpePersistent);
     procedure PropagateHandle (const NewHandle: DWord);
     procedure PropagateIndex (const NewIndex: integer);
     constructor Create;
     destructor Destroy; override;
   end; { Class TCrpePersistent }

{------------------------------------------------------------------------------}
{ Class TCrpeItem                                                              }
{  - same as TPersistent but defines an item class that belongs to a container }
{------------------------------------------------------------------------------}
   TCrpeItem = class(TCrpePersistent)
   private
   protected
   published
   public
   end; { Class TCrpeItem }

{------------------------------------------------------------------------------}
{ Class TCrpeObjectItem                                                        }
{  - base class for ObjectItemA, ObjectItemB, FieldObjectItem                  }
{------------------------------------------------------------------------------}
  TCrpeObjectItem = class(TCrpeItem)
  private
  protected
    FTop     : LongInt;
    FLeft    : LongInt;
    FWidth   : LongInt;
    FHeight  : LongInt;
    FSection : string;
    FBorder  : TCrpeBorder;
    {Object specific}
    procedure SetTop (const Value: LongInt);
    procedure SetLeft (const Value: LongInt);
    procedure SetWidth (const Value: LongInt);
    procedure SetHeight (const Value: LongInt);
    procedure SetSection (const Value: string);
    {Border}
    function  GetBorder : TCrpeBorder;
    {Internal}
    function  StatusIsGo (nIndex: integer): Boolean;
  published
    property Top : LongInt
        read FTop
       write SetTop;
    property Left : LongInt
        read FLeft
       write SetLeft;
    property Width : LongInt
        read FWidth
       write SetWidth;
    property Height : LongInt
        read FHeight
       write SetHeight;
    property Section : string
        read FSection
       write SetSection;
    {Border}
    property Border : TCrpeBorder
        read GetBorder
       write FBorder;
  public
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeObjectItemA                                                       }
{  - base Item class for OleObjects, Graphs, CrossTabs, Pictures,              }
{     Maps, OLAPCubes, Subreports                                              }
{------------------------------------------------------------------------------}
  TCrpeObjectItemA = class(TCrpeObjectItem)
  private
  protected
    FFormat : TCrpeFormatA;
  published
    property Format : TCrpeFormatA
        read FFormat
       write FFormat;
  public
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeObjectItemB                                                       }
{  - base Item class for TextObjects                                           }
{------------------------------------------------------------------------------}
  TCrpeObjectItemB = class(TCrpeObjectItem)
  private
  protected
    FFormat : TCrpeFormatC;
    FFont   : TCrpeFont;
    function  GetFont : TCrpeFont;
    procedure OnChangeFont (Sender: TObject);
  published
    property Format : TCrpeFormatC
        read FFormat
       write FFormat;
    property Font : TCrpeFont
        read GetFont
       write FFont;
  public
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFieldObjectItem                                                   }
{  - derived from ObjectItem class for all Field objects                       }
{------------------------------------------------------------------------------}
  TCrpeFieldObjectItem = class(TCrpeObjectItem)
  private
  protected
    {Read only}
    FFieldName        : string;
    FFieldType        : TCrFieldValueType;
    FFieldLength      : Word;
    {Format & Font}
    FFormat           : TCrpeFieldObjectFormat;
    FFont             : TCrpeFont;
    {Hilite Conditions}
    FHiliteConditions : TCrpeHiliteConditions;
    function  GetFont : TCrpeFont;
    procedure OnChangeFont (Sender: TObject);
    {Dummy procedures so the property appears on the Object Inspector}
    procedure SetFName (const Value: string);
    procedure SetFType (const Value: TCrFieldValueType);
    procedure SetFLength (const Value: Word);
  published
    property FieldName : string
        read FFieldName
       write SetFName;
    property FieldType : TCrFieldValueType
        read FFieldType
       write SetFType
     default fvUnknown;
    property FieldLength : Word
        read FFieldLength
       write SetFLength
     default 0;
    property Format : TCrpeFieldObjectFormat
        read FFormat
       write FFormat;
    property Font : TCrpeFont
        read GetFont
       write FFont;
    property HiliteConditions : TCrpeHiliteConditions
        read FHiliteConditions
       write FHiliteConditions;
  public
    procedure SetFieldType(const FType: TCrFieldValueType);
    procedure Clear;
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFieldObjectItem}

{------------------------------------------------------------------------------}
{ Class TCrpeContainer                                                         }
{  - Used as a base for container classes                                      }
{------------------------------------------------------------------------------}
   TCrpeContainer = class(TCrpePersistent)
   private
   protected
   published
   public
     function  Count: integer; virtual; abstract;
   end; { Class TCrpeContainer }

{------------------------------------------------------------------------------}
{ Class TCrpeObjectContainer                                                   }
{  - Used as a base for Object container classes                               }
{------------------------------------------------------------------------------}
   TCrpeObjectContainer = class(TCrpeContainer)
   private
   protected
     FObjectType      : TCrObjectType;
     FFieldObjectType : TCrFieldObjectType;
   published
   public
   end; { Class TCrpeObjectContainer }

{------------------------------------------------------------------------------}
{ Class TCrpeObjectContainerA                                                  }
{  - base Container class for OleObjects, Graphs, CrossTabs, Pictures,         }
{    Maps, OLAPCubes, Subreports                                               }
{------------------------------------------------------------------------------}
  TCrpeObjectContainerA = class(TCrpeObjectContainer)
  private
  protected
    FItem : TCrpeObjectItemA;
    procedure SetIndex (nIndex: integer);
  published
  public
    function Count: integer; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeObjectContainerB                                                  }
{  - base Container class for TextObjects                                      }
{------------------------------------------------------------------------------}
  TCrpeObjectContainerB = class(TCrpeObjectContainer)
  private
  protected
    FItem : TCrpeObjectItemB;
    procedure SetIndex (nIndex: integer);
  published
  public
    function Count: integer; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFieldObjectContainer                                              }
{  - base class for Field Objects that contain multiple items                  }
{------------------------------------------------------------------------------}
  TCrpeFieldObjectContainer = class(TCrpeObjectContainer)
  private
  protected
    FItem  : TCrpeFieldObjectItem;
    procedure SetIndex (nIndex: integer);
  published
  public
    function Count: integer; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFormat                                                            }
{------------------------------------------------------------------------------}
  TCrpeFormat = class(TCrpePersistent)
  private
  protected
    {All Objects except Lines & Boxes}
    FSuppress     : Boolean;
    FKeepTogether : Boolean;
    FCloseBorder  : Boolean;
    FToolTip      : string;
    function  StatusIsGo : Boolean;
  published
    function  GetSuppress : Boolean; virtual; abstract;
    procedure SetSuppress (const Value: Boolean); virtual; abstract;
    function  GetKeepTogether : Boolean; virtual; abstract;
    procedure SetKeepTogether (const Value: Boolean); virtual; abstract;
    function  GetCloseBorder : Boolean; virtual; abstract;
    procedure SetCloseBorder (const Value: Boolean); virtual; abstract;
    function  GetToolTip : string; virtual; abstract;
    procedure SetToolTip (const Value: string); virtual; abstract;
    property Suppress : Boolean
        read GetSuppress
       write SetSuppress
     default False;
    property KeepTogether : Boolean
        read GetKeepTogether
       write SetKeepTogether
     default True;
    property CloseBorder : Boolean
        read GetCloseBorder
       write SetCloseBorder
     default True;
    property ToolTip : string
        read GetToolTip
       write SetToolTip;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFormatA                                                           }
{  - used by OleObjects, Graphs, CrossTabs, Pictures                           }
{------------------------------------------------------------------------------}
  TCrpeFormatA = class(TCrpeFormat)
  private
  protected
    FFormulas : TCrpeFormatFormulasA;
  published
    function  GetSuppress : Boolean; override;
    procedure SetSuppress (const Value: Boolean); override;
    function  GetKeepTogether : Boolean; override;
    procedure SetKeepTogether (const Value: Boolean); override;
    function  GetCloseBorder : Boolean; override;
    procedure SetCloseBorder (const Value: Boolean); override;
    function  GetToolTip : string; override;
    procedure SetToolTip (const Value: string); override;
    property Formulas : TCrpeFormatFormulasA
        read FFormulas
       write FFormulas;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetFormat;
    procedure Clear; override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFormatB                                                           }
{  - inherited by FormatC and FieldObjectFormat                                }
{------------------------------------------------------------------------------}
  TCrpeFormatB = class(TCrpeFormat)
  private
  protected
    {Internal}
    FFieldType            : TCrFieldValueType;
    FFieldN               : Smallint;
    {Fields, Text Objects, Subreports}
    FAlignment            : TCrHorizontalAlignment;
    FCanGrow              : Boolean; {only applies to string/text fields}
    FMaxNLines            : integer;
    FTextRotation         : TCrTextRotation;
    FSuppressIfDuplicated : Boolean;
    {Format Formulas}
    FFormulas             : TCrpeFormatFormulasB;
  published
    function  GetSuppress : Boolean; override;
    procedure SetSuppress (const Value: Boolean); override;
    function  GetKeepTogether : Boolean; override;
    procedure SetKeepTogether (const Value: Boolean); override;
    function  GetCloseBorder : Boolean; override;
    procedure SetCloseBorder (const Value: Boolean); override;
    function  GetToolTip : string; override;
    procedure SetToolTip (const Value: string); override;
    function  GetAlignment : TCrHorizontalAlignment;
    procedure SetAlignment (const Value: TCrHorizontalAlignment);
    function  GetCanGrow : Boolean;
    procedure SetCanGrow (const Value: Boolean);
    function  GetMaxNLines : integer;
    procedure SetMaxNLines (const Value: integer);
    function  GetTextRotation : TCrTextRotation;
    procedure SetTextRotation (const Value: TCrTextRotation);
    function  GetSuppressIfDuplicated : Boolean;
    procedure SetSuppressIfDuplicated (const Value: Boolean);
    property Alignment : TCrHorizontalAlignment
        read GetAlignment
       write SetAlignment;
    property SuppressIfDuplicated : Boolean
        read GetSuppressIfDuplicated
       write SetSuppressIfDuplicated;
    property CanGrow : Boolean
        read GetCanGrow
       write SetCanGrow;
    property MaxNLines : integer
        read GetMaxNLines
       write SetMaxNLines
     default 1;
    property TextRotation : TCrTextRotation
        read GetTextRotation
       write SetTextRotation
     default trZero;
    property Formulas : TCrpeFormatFormulasB
        read FFormulas
       write FFormulas;
  public
    procedure SetFieldType(FType: TCrFieldValueType);
    procedure Assign(Source: TPersistent); override;
    procedure GetFormat;
    procedure Clear; override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFormatC                                                           }
{  - used by TextObjects                                                       }
{------------------------------------------------------------------------------}
  TCrpeFormatC = class(TCrpeFormatB)
  private
  protected
    FParagraph : TCrpeParagraphFormat;
  published
    property Paragraph : TCrpeParagraphFormat
        read FParagraph
       write FParagraph;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFormatFormulas                                                    }
{------------------------------------------------------------------------------}
  TCrpeFormatFormulas = class(TCrpePersistent)
  private
    FSuppress     : TStrings;
    FKeepTogether : TStrings;
    FCloseBorder  : TStrings;
    FHyperLink    : TStrings;
    xFormula      : TStrings;
  protected
    function  StatusIsGo : Boolean;
    function  GetSuppress : TStrings; virtual; abstract;
    procedure SetSuppress (const Value: TStrings); virtual; abstract;
    function  GetKeepTogether : TStrings; virtual; abstract;
    procedure SetKeepTogether (const Value: TStrings); virtual; abstract;
    function  GetCloseBorder : TStrings; virtual; abstract;
    procedure SetCloseBorder (const Value: TStrings); virtual; abstract;
    function  GetHyperLink : TStrings; virtual; abstract;
    procedure SetHyperLink (const Value: TStrings); virtual; abstract;
  published
    property Suppress : TStrings
        read GetSuppress
       write SetSuppress;
    property KeepTogether : TStrings
        read GetKeepTogether
       write SetKeepTogether;
    property CloseBorder : TStrings
        read GetCloseBorder
       write SetCloseBorder;
    property HyperLink : TStrings
        read GetHyperLink
       write SetHyperLink;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFormatFormulas}

{------------------------------------------------------------------------------}
{ Class TCrpeFormatFormulasA                                                   }
{------------------------------------------------------------------------------}
  TCrpeFormatFormulasA = class(TCrpeFormatFormulas)
  private
  protected
    function  GetSuppress : TStrings; override;
    procedure SetSuppress (const Value: TStrings); override;
    function  GetKeepTogether : TStrings; override;
    procedure SetKeepTogether (const Value: TStrings); override;
    function  GetCloseBorder : TStrings; override;
    procedure SetCloseBorder (const Value: TStrings); override;
    function  GetHyperLink : TStrings; override;
    procedure SetHyperLink (const Value: TStrings); override;
    {OnChange StringList methods}
    procedure OnChangeSuppress (Sender: TObject);
    procedure OnChangeKeepTogether (Sender: TObject);
    procedure OnChangeCloseBorder (Sender: TObject);
    procedure OnChangeHyperLink (Sender: TObject);
  published
  public
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFormatFormulasA}

{------------------------------------------------------------------------------}
{ Class TCrpeFormatFormulasB                                                   }
{------------------------------------------------------------------------------}
  TCrpeFormatFormulasB = class(TCrpeFormatFormulas)
  private
  protected
    FFieldN               : Smallint;
    FAlignment            : TStrings;
    FCanGrow              : TStrings;
    FSuppressIfDuplicated : TStrings;
    function  GetSuppress : TStrings; override;
    procedure SetSuppress (const Value: TStrings); override;
    function  GetKeepTogether : TStrings; override;
    procedure SetKeepTogether (const Value: TStrings); override;
    function  GetCloseBorder : TStrings; override;
    procedure SetCloseBorder (const Value: TStrings); override;
    function  GetHyperLink : TStrings; override;
    procedure SetHyperLink (const Value: TStrings); override;
    function  GetAlignment : TStrings;
    procedure SetAlignment (const Value: TStrings);
    function  GetCanGrow : TStrings;
    procedure SetCanGrow (const Value: TStrings);
    function  GetSuppressIfDuplicated : TStrings;
    procedure SetSuppressIfDuplicated (const Value: TStrings);
    {OnChange StringList methods}
    procedure OnChangeSuppress (Sender: TObject);
    procedure OnChangeKeepTogether (Sender: TObject);
    procedure OnChangeCloseBorder (Sender: TObject);
    procedure OnChangeHyperLink (Sender: TObject);
    procedure OnChangeAlignment (Sender: TObject);
    procedure OnChangeCanGrow (Sender: TObject);
    procedure OnChangeSuppressIfDuplicated (Sender: TObject);
  published
    property Alignment : TStrings
        read GetAlignment
       write SetAlignment;
    property SuppressIfDuplicated : TStrings
        read GetSuppressIfDuplicated
       write SetSuppressIfDuplicated;
    property CanGrow : TStrings
        read GetCanGrow
       write SetCanGrow;
  public
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFormatFormulasB}

{------------------------------------------------------------------------------}
{ Class TCrpeFieldObjectFormat                                                 }
{  - used by all Field Objects...adds Field Formatting                         }
{------------------------------------------------------------------------------}
  TCrpeFieldObjectFormat = class(TCrpeFormatB)
  private
  protected
    FField : TCrpeFieldFormat;
  published
    property Field : TCrpeFieldFormat
        read FField
       write FField;
  public
    procedure SetFieldType(FType: TCrFieldValueType);
    procedure SetFNum(nField: Smallint);
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeNumberFormat                                                      }
{  - holds properties for formatting number fields                             }
{------------------------------------------------------------------------------}
  TCrpeNumberFormat = class(TCrpePersistent)
  private
  protected
    FFieldType                : TCrFieldValueType;
    FFieldN                   : Smallint;
    FSuppressIfZero           : Boolean;
    FNegativeFormat           : TCrNegativeFormat;
    FUseThousandsSeparators   : Boolean;
    FUseLeadingZero           : Boolean;
    FDecimalPlaces            : integer;
    FRoundingFormat           : TCrRoundingFormat;
    FReverseSignForDisplay    : Boolean;
    FUseAccountingFormat      : Boolean;
    FCurrencySymbol           : string;
    FCurrencySymbolFormat     : TCrCurrencySymbolFormat;
    FOneCurrencySymbolPerPage : Boolean;
    FCurrencySymbolPosition   : TCrCurrencySymbolPosition;
    FThousandSymbol           : string;
    FDecimalSymbol            : string;
    FShowZeroValueAs          : string;
    FAllowFieldClipping       : Boolean;
    function  GetSuppressIfZero : Boolean;
    function  GetNegativeFormat : TCrNegativeFormat;
    function  GetUseThousandsSeparators : Boolean;
    function  GetUseLeadingZero : Boolean;
    function  GetDecimalPlaces : integer;
    function  GetRoundingFormat : TCrRoundingFormat;
    function  GetReverseSignForDisplay : Boolean;
    function  GetUseAccountingFormat : Boolean;
    function  GetCurrencySymbol : string;
    function  GetCurrencySymbolFormat : TCrCurrencySymbolFormat;
    function  GetOneCurrencySymbolPerPage : Boolean;
    function  GetCurrencySymbolPosition : TCrCurrencySymbolPosition;
    function  GetThousandSymbol : string;
    function  GetDecimalSymbol : string;
    function  GetShowZeroValueAs : string;
    function  GetAllowFieldClipping : boolean;
    procedure SetSuppressIfZero (const Value: Boolean);
    procedure SetNegativeFormat (const Value: TCrNegativeFormat);
    procedure SetUseThousandsSeparators (const Value: Boolean);
    procedure SetUseLeadingZero (const Value: Boolean);
    procedure SetDecimalPlaces (const Value: integer);
    procedure SetRoundingFormat (const Value: TCrRoundingFormat);
    procedure SetReverseSignForDisplay (const Value: Boolean);
    procedure SetUseAccountingFormat (const Value: Boolean);
    procedure SetCurrencySymbol (const Value: string);
    procedure SetCurrencySymbolFormat (const Value: TCrCurrencySymbolFormat);
    procedure SetOneCurrencySymbolPerPage (const Value: Boolean);
    procedure SetCurrencySymbolPosition (const Value: TCrCurrencySymbolPosition);
    procedure SetThousandSymbol (const Value: string);
    procedure SetDecimalSymbol (const Value: string);
    procedure SetShowZeroValueAs (const Value: string);
    procedure SetAllowFieldClipping (const Value: boolean);
    {Internal}
    function  StatusIsGo : Boolean;
  published
    property SuppressIfZero : Boolean
        read GetSuppressIfZero
       write SetSuppressIfZero
     default False;
    property NegativeFormat : TCrNegativeFormat
        read GetNegativeFormat
       write SetNegativeFormat
     default nfLeading;
    property UseThousandsSeparators : Boolean
        read GetUseThousandsSeparators
       write SetUseThousandsSeparators
     default True;
    property UseLeadingZero : Boolean
        read GetUseLeadingZero
       write SetUseLeadingZero
     default True;
    property DecimalPlaces : integer
        read GetDecimalPlaces
       write SetDecimalPlaces
     default 0;
    property RoundingFormat : TCrRoundingFormat
        read GetRoundingFormat
       write SetRoundingFormat
     default rfUnit;
    property ReverseSignForDisplay : Boolean  {SCR8}
        read GetReverseSignForDisplay
       write SetReverseSignForDisplay
     default False; {??}
    property UseAccountingFormat : Boolean    {SCR8}
        read GetUseAccountingFormat
       write SetUseAccountingFormat
     default False; {??}
    property CurrencySymbol : string
        read GetCurrencySymbol
       write SetCurrencySymbol; {default is '$'}
    property CurrencySymbolFormat : TCrCurrencySymbolFormat
        read GetCurrencySymbolFormat
       write SetCurrencySymbolFormat
     default csfFloating;
    property OneCurrencySymbolPerPage : Boolean
        read GetOneCurrencySymbolPerPage
       write SetOneCurrencySymbolPerPage
     default False;
    property CurrencySymbolPosition : TCrCurrencySymbolPosition
        read GetCurrencySymbolPosition
       write SetCurrencySymbolPosition
     default cspLeadingInside;
    property ThousandSymbol : string
        read GetThousandSymbol
       write SetThousandSymbol;  {default is ','}
    property DecimalSymbol : string
        read GetDecimalSymbol
       write SetDecimalSymbol;   {default is '.'}
    property ShowZeroValueAs : string  {SCR8}
        read GetShowZeroValueAs
       write SetShowZeroValueAs; {default is '0'?}
    property AllowFieldClipping : boolean
        read GetAllowFieldClipping
       write SetAllowFieldClipping
     default True;
  public
    procedure GetFormat;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeDateFormat                                                        }
{  - holds properties for formatting date fields                               }
{------------------------------------------------------------------------------}
  TCrpeDateFormat = class(TCrpePersistent)
  private
  protected
    FFieldType          : TCrFieldValueType;
    FFieldN             : Smallint;
    FDateType           : TCrDateType;
    FDateOrder          : TCrDateOrder;
    FYearFormat         : TCrYearFormat;
    FMonthFormat        : TCrMonthFormat;
    FDayFormat          : TCrDayFormat;
    FDayOfWeekType      : TCrDayOfWeekType;
    FFirstSeparator     : string;
    FSecondSeparator    : string;
    FDayOfWeekSeparator : string;
    FDayOfWeekPosition  : TCrDayOfWeekPosition;
    FDayOfWeekEnclosure : TCrDayOfWeekEnclosure;
    FDateEra            : TCrDateEra;
    FCalendarType       : TCrCalendarType;
    FPrefixSeparator    : string;
    FSuffixSeparator    : string;
    function  GetDateType : TCrDateType;
    function  GetDateOrder : TCrDateOrder;
    function  GetYearFormat : TCrYearFormat;
    function  GetMonthFormat : TCrMonthFormat;
    function  GetDayFormat : TCrDayFormat;
    function  GetDayOfWeekType : TCrDayOfWeekType;
    function  GetFirstSeparator : string;
    function  GetSecondSeparator : string;
    function  GetDayOfWeekSeparator : string;
    function  GetDayOfWeekPosition : TCrDayOfWeekPosition;
    function  GetDayOfWeekEnclosure : TCrDayOfWeekEnclosure;
    function  GetDateEra : TCrDateEra;
    function  GetCalendarType : TCrCalendarType;
    function  GetPrefixSeparator : string;
    function  GetSuffixSeparator : string;
    procedure SetDateType (const Value: TCrDateType);
    procedure SetDateOrder (const Value: TCrDateOrder);
    procedure SetYearFormat (const Value: TCrYearFormat);
    procedure SetMonthFormat (const Value: TCrMonthFormat);
    procedure SetDayFormat (const Value: TCrDayFormat);
    procedure SetDayOfWeekType (const Value: TCrDayOfWeekType);
    procedure SetFirstSeparator (const Value: string);
    procedure SetSecondSeparator (const Value: string);
    procedure SetDayOfWeekSeparator (const Value: string);
    procedure SetDayOfWeekPosition (const Value: TCrDayOfWeekPosition);
    procedure SetDayOfWeekEnclosure (const Value: TCrDayOfWeekEnclosure);
    procedure SetDateEra (const Value: TCrDateEra);
    procedure SetCalendarType (const Value: TCrCalendarType);
    procedure SetPrefixSeparator (const Value: string);
    procedure SetSuffixSeparator (const Value: string);
    {Internal}
    function  StatusIsGo : Boolean;
  published
    property DateType : TCrDateType
        read GetDateType
       write SetDateType
     default dfWindowsShort;
    property DateOrder : TCrDateOrder
        read GetDateOrder
       write SetDateOrder
     default doMDY;
    property YearFormat : TCrYearFormat
        read GetYearFormat
       write SetYearFormat
     default yfLong;
    property MonthFormat : TCrMonthFormat
        read GetMonthFormat
       write SetMonthFormat
     default mfLeadingZeroNumeric;
    property DayFormat : TCrDayFormat
        read GetDayFormat
       write SetDayFormat
     default dfLeadingZeroNumeric;
    property DayOfWeekType : TCrDayOfWeekType
        read GetDayOfWeekType
       write SetDayOfWeekType
     default dwfNone;
    property FirstSeparator : string
        read GetFirstSeparator
       write SetFirstSeparator;  {default is '/'}
    property SecondSeparator : string
        read GetSecondSeparator
       write SetSecondSeparator; {default is '/'}
    property DayOfWeekSeparator : string
        read GetDayOfWeekSeparator
       write SetDayOfWeekSeparator; {default is ''}
    property DayOfWeekPosition : TCrDayOfWeekPosition
        read GetDayOfWeekPosition
       write SetDayOfWeekPosition
     default dwpLeading;
    property DayOfWeekEnclosure : TCrDayOfWeekEnclosure  {SCR8}
        read GetDayOfWeekEnclosure
       write SetDayOfWeekEnclosure
     default dweNone; {??}
    property DateEra : TCrDateEra
        read GetDateEra
       write SetDateEra
     default deNone;
    property CalendarType : TCrCalendarType
        read GetCalendarType
       write SetCalendarType
     default ctGregorian;
    property PrefixSeparator : string
        read GetPrefixSeparator
       write SetPrefixSeparator; {default is ''}
    property SuffixSeparator : string
        read GetSuffixSeparator
       write SetSuffixSeparator; {default is ''}
  public
    procedure GetFormat;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeTimeFormat                                                        }
{  - holds properties for formatting time fields                               }
{------------------------------------------------------------------------------}
  TCrpeTimeFormat = class(TCrpePersistent)
  private
  protected
    FFieldType        : TCrFieldValueType;
    FFieldN           : Smallint;
    FTimeBase         : TCrTimeBase;
    FAmPmPosition     : TCrAmPmPosition;
    FHourType         : TCrTimeFormat;
    FMinuteType       : TCrTimeFormat;
    FSecondType       : TCrTimeFormat;
    FAMString         : string;
    FPMString         : string;
    FHourMinSeparator : string;
    FMinSecSeparator  : string;
    function  GetTimeBase : TCrTimeBase;
    function  GetAmPmPosition : TCrAmPmPosition;
    function  GetHourType : TCrTimeFormat;
    function  GetMinuteType : TCrTimeFormat;
    function  GetSecondType : TCrTimeFormat;
    function  GetAMString : string;
    function  GetPMString : string;
    function  GetHourMinSeparator : string;
    function  GetMinSecSeparator : string;
    procedure SetTimeBase (const Value: TCrTimeBase);
    procedure SetAmPmPosition (const Value: TCrAmPmPosition);
    procedure SetHourType (const Value: TCrTimeFormat);
    procedure SetMinuteType (const Value: TCrTimeFormat);
    procedure SetSecondType (const Value: TCrTimeFormat);
    procedure SetAMString (const Value: string);
    procedure SetPMString (const Value: string);
    procedure SetHourMinSeparator (const Value: string);
    procedure SetMinSecSeparator (const Value: string);
    {Internal}
    function  StatusIsGo : Boolean;
  published
    property TimeBase : TCrTimeBase
        read GetTimeBase
       write SetTimeBase
     default tf12Hour;
    property AmPmPosition : TCrAmPmPosition
        read GetAmPmPosition
       write SetAmPmPosition
     default ampmAfter;
    property HourType : TCrTimeFormat
        read GetHourType
       write SetHourType
     default tfNoLeadingZero;
    property MinuteType : TCrTimeFormat
        read GetMinuteType
       write SetMinuteType
     default tfNumeric;
    property SecondType : TCrTimeFormat
        read GetSecondType
       write SetSecondType
     default tfNumeric;
    property AMString : string
        read GetAMString
       write SetAMString; {default 'AM'}
    property PMString : string
        read GetPMString
       write SetPMString; {default 'PM'}
    property HourMinSeparator : string
        read GetHourMinSeparator
       write SetHourMinSeparator; {default is ':'}
    property MinSecSeparator : string
        read GetMinSecSeparator
       write SetMinSecSeparator; {default is ':'}
  public
    procedure GetFormat;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeDateTimeFormat                                                    }
{  - holds properties for formatting datetime fields                           }
{------------------------------------------------------------------------------}
  TCrpeDateTimeFormat = class(TCrpePersistent)
  private
  protected
    FFieldType : TCrFieldValueType;
    FFieldN    : Smallint;
    FOrder     : TCrDateTimeOrder;
    FSeparator : string;
    function  GetOrder : TCrDateTimeOrder;
    function  GetSeparator : string;
    procedure SetOrder (const Value: TCrDateTimeOrder);
    procedure SetSeparator (const Value: string);
    {Internal}
    function  StatusIsGo : Boolean;
  published
    property Order : TCrDateTimeOrder
        read GetOrder
       write SetOrder
     default dtoDateTime;
    property Separator : string
        read GetSeparator
       write SetSeparator; {default is ''}
  public
    procedure GetFormat;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeParagraphFormat                                                   }
{  - holds properties for formatting string fields                             }
{------------------------------------------------------------------------------}
  TCrpeParagraphFormat = class(TCrpePersistent)
  private
  protected
    FFieldType          : TCrFieldValueType;
    FFieldN             : Smallint;
    FIndentFirstLine    : integer; {twips}
    FIndentLeft         : integer;
    FIndentRight        : integer;
    FTextInterpretation : TCrTextInterpretation;
    FLineSpacingType    : TCrLineSpacingType;
    FLineSpacing        : double; {N lines, can be fraction - 1.5, etc.}
    FCharacterSpacing   : double; {in points}
    {Internal}
    function  StatusIsGo : Boolean;
  published
    function  GetIndentFirstLine : integer;
    function  GetIndentLeft : integer;
    function  GetIndentRight : integer;
    function  GetTextInterpretation : TCrTextInterpretation;
    function  GetLineSpacingType : TCrLineSpacingType;
    function  GetLineSpacing : double;
    function  GetCharacterSpacing : double;
    procedure SetIndentFirstLine (const Value: integer);
    procedure SetIndentLeft (const Value: integer);
    procedure SetIndentRight (const Value: integer);
    procedure SetTextInterpretation (const Value: TCrTextInterpretation);
    procedure SetLineSpacingType (const Value: TCrLineSpacingType);
    procedure SetLineSpacing (const Value: double);
    procedure SetCharacterSpacing (const Value: double);
    property IndentFirstLine : integer
        read GetIndentFirstLine
       write SetIndentFirstLine
     default 0;
    property IndentLeft : integer
        read GetIndentLeft
       write SetIndentLeft
     default 0;
    property IndentRight : integer
        read GetIndentRight
       write SetIndentRight
     default 0;
    property TextInterpretation : TCrTextInterpretation
        read GetTextInterpretation
       write SetTextInterpretation
     default tiNone;
    property LineSpacingType : TCrLineSpacingType
        read GetLineSpacingType
       write SetLineSpacingType
     default lsMultiple;
    property LineSpacing : double
        read GetLineSpacing
       write SetLineSpacing; {default = 1}
    property CharacterSpacing : double {in points}
        read GetCharacterSpacing
       write SetCharacterSpacing;
  public
    FForEmbeddedField : Boolean;
    FForTextObject    : Boolean;
    procedure GetFormat;
    procedure SetFieldType(FType: TCrFieldValueType);
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFieldFormatFormulas                                               }
{  - Formulas for the FieldFormat options                                      }
{------------------------------------------------------------------------------}
  TCrpeFieldFormatFormulas = class(TCrpePersistent)
  private
  protected
    FFieldType : TCrFieldValueType;
    FFieldN    : Smallint;
    FName      : TCrFormatFormulaName;
    FFormula   : TStrings;
    xFormula   : TStrings;
    function  StatusIsGo : Boolean;
    function  GetFormula : TStrings;
    procedure SetFormula (const Value: TStrings);
    procedure SetName (const Value: TCrFormatFormulaName);
    procedure OnChangeStrings (Sender: TObject);
  published
    property Name : TCrFormatFormulaName
        read FName
       write SetName
     default ffnFontColor;
    property Formula : TStrings
        read GetFormula
       write SetFormula;
  public
    property FieldType : TCrFieldValueType
        read FFieldType;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFieldFormatFormulas}

{------------------------------------------------------------------------------}
{ Class TCrpeFieldFormat                                                       }
{  - holds properties and sub-classes for formatting fields                    }
{------------------------------------------------------------------------------}
  TCrpeFieldFormat = class(TCrpePersistent)
  private
  protected
    FFieldType   : TCrFieldValueType;
    FFieldN      : Smallint;
    FUseSystemDefaultFormatting : Boolean;
    FBooleanType : TCrBooleanType;
    FNumber      : TCrpeNumberFormat;
    FDate        : TCrpeDateFormat;
    FTime        : TCrpeTimeFormat;
    FDateTime    : TCrpeDateTimeFormat;
    FParagraph   : TCrpeParagraphFormat;
    FFormulas    : TCrpeFieldFormatFormulas;
    function  GetUseSystemDefaultFormatting : Boolean;
    function  GetBooleanType : TCrBooleanType;
    procedure SetUseSystemDefaultFormatting (const Value: Boolean);
    procedure SetBooleanType (const Value: TCrBooleanType);
    {Internal}
    function  StatusIsGo : Boolean;
  published
    property UseSystemDefaultFormatting : Boolean
        read GetUseSystemDefaultFormatting
       write SetUseSystemDefaultFormatting
     default True;
    property BooleanType : TCrBooleanType
        read GetBooleanType
       write SetBooleanType
     default TrueFalse;
    property Number : TCrpeNumberFormat
        read FNumber
       write FNumber;
    property Date : TCrpeDateFormat
        read FDate
       write FDate;
    property Time : TCrpeTimeFormat
        read FTime
       write FTime;
    property DateTime : TCrpeDateTimeFormat
        read FDateTime
       write FDateTime;
    property Paragraph : TCrpeParagraphFormat
        read FParagraph
       write FParagraph;
    property Formulas : TCrpeFieldFormatFormulas
        read FFormulas
       write FFormulas;
  public
    property FieldType : TCrFieldValueType
        read FFieldType;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;  {TCrpeFieldFormat}

{------------------------------------------------------------------------------}
{ Class TCrpeBorderFormulas                                                    }
{------------------------------------------------------------------------------}
   TCrpeBorderFormulas = class(TCrpePersistent)
   private
   protected
     FFieldN          : Smallint;
     {Border properties}
     FLeft            : TStrings;
     FRight           : TStrings;
     FTop             : TStrings;
     FBottom          : TStrings;
     FTightHorizontal : TStrings;
     FDropShadow      : TStrings;
     FForeColor       : TStrings;
     FBackgroundColor : TStrings;
     xFormula         : TStrings;
     function  StatusIsGo : Boolean;
     function  GetLeft : TStrings;
     procedure SetLeft (const Value: TStrings);
     function  GetRight : TStrings;
     procedure SetRight (const Value: TStrings);
     function  GetTop : TStrings;
     procedure SetTop (const Value: TStrings);
     function  GetBottom : TStrings;
     procedure SetBottom (const Value: TStrings);
     function  GetTightHorizontal : TStrings;
     procedure SetTightHorizontal (const Value: TStrings);
     function  GetDropShadow : TStrings;
     procedure SetDropShadow (const Value: TStrings);
     function  GetForeColor : TStrings;
     procedure SetForeColor (const Value: TStrings);
     function  GetBackgroundColor : TStrings;
     procedure SetBackgroundColor (const Value: TStrings);
     {OnChange StringList methods}
     procedure OnChangeLeft (Sender: TObject);
     procedure OnChangeRight (Sender: TObject);
     procedure OnChangeTop (Sender: TObject);
     procedure OnChangeBottom (Sender: TObject);
     procedure OnChangeTightHorizontal (Sender: TObject);
     procedure OnChangeDropShadow (Sender: TObject);
     procedure OnChangeForeColor (Sender: TObject);
     procedure OnChangeBackgroundColor (Sender: TObject);
   published
     property Left : TStrings
         read GetLeft
        write SetLeft;
     property Right : TStrings
         read GetRight
        write SetRight;
     property Top : TStrings
         read GetTop
        write SetTop;
     property Bottom : TStrings
         read GetBottom
        write SetBottom;
     property TightHorizontal : TStrings
         read GetTightHorizontal
        write SetTightHorizontal;
     property DropShadow : TStrings
         read GetDropShadow
        write SetDropShadow;
     property ForeColor : TStrings
         read GetForeColor
        write SetForeColor;
     property BackgroundColor : TStrings
         read GetBackgroundColor
        write SetBackgroundColor;
   public
     procedure Assign(Source: TPersistent); override;
     procedure Clear;
     constructor Create;
     destructor Destroy; override;
   end; { Class TCrpeBorderFormulas }

{------------------------------------------------------------------------------}
{ Class TCrpeBorder                                                            }
{------------------------------------------------------------------------------}
  TCrpeBorder = class(TCrpePersistent)
  private
  protected
    FFieldN          : Smallint;
    {Border properties}
    FLeft            : TCrLineStyle;
    FRight           : TCrLineStyle;
    FTop             : TCrLineStyle;
    FBottom          : TCrLineStyle;
    FTightHorizontal : Boolean;
    FDropShadow      : Boolean;
    FForeColor       : TColor;
    FBackgroundColor : TColor;
    FFormulas        : TCrpeBorderFormulas;
    function  StatusIsGo : Boolean;
  published
    function  GetLeft : TCrLineStyle;
    procedure SetLeft (const Value: TCrLineStyle);
    function  GetRight : TCrLineStyle;
    procedure SetRight (const Value: TCrLineStyle);
    function  GetTop : TCrLineStyle;
    procedure SetTop (const Value: TCrLineStyle);
    function  GetBottom : TCrLineStyle;
    procedure SetBottom (const Value: TCrLineStyle);
    function  GetTightHorizontal : Boolean;
    procedure SetTightHorizontal (const Value: Boolean);
    function  GetDropShadow : Boolean;
    procedure SetDropShadow (const Value: Boolean);
    function  GetForeColor : TColor;
    procedure SetForeColor (const Value: TColor);
    function  GetBackgroundColor : TColor;
    procedure SetBackgroundColor (const Value: TColor);
    property Left : TCrLineStyle
        read GetLeft
       write SetLeft;
    property Right : TCrLineStyle
        read GetRight
       write SetRight;
    property Top : TCrLineStyle
        read GetTop
       write SetTop;
    property Bottom : TCrLineStyle
        read GetBottom
       write SetBottom;
    property TightHorizontal : Boolean
        read GetTightHorizontal
       write SetTightHorizontal;
    property DropShadow : Boolean
        read GetDropShadow
       write SetDropShadow;
    property ForeColor : TColor
        read GetForeColor
       write SetForeColor;
    property BackgroundColor : TColor
        read GetBackgroundColor
       write SetBackgroundColor;
    property Formulas : TCrpeBorderFormulas
        read FFormulas
       write FFormulas;
  public
    procedure SetFNum(nField: Smallint);
    procedure Assign(Source: TPersistent); override;
    procedure GetBorder;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeFont                                                              }
{------------------------------------------------------------------------------}
  TCrpeFont = class(TFont)
  private
  protected
    FIndex      : integer;
    FActualSize : double; {points, but supports fractions}
    function  GetActualSize: double;
    procedure SetActualSize (const Value: double);
    function  HasChanged(RptFontInfo: PEFontColorInfo): Boolean;
    procedure CopyFontInfo(var FontInfo: PEFontColorInfo; VCLFont: TCrpeFont);
  published
    property ActualSize : double
        read GetActualSize
       write SetActualSize;
  public
    Cx      : TComponent;
    Parent  : TCrpePersistent;
    Handle  : DWord;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure GetFont;
    procedure SetFont;
    constructor Create;
  end;

{------------------------------------------------------------------------------}
{ Class TCrpeHiliteConditionsItem                                              }
{------------------------------------------------------------------------------}
   TCrpeHiliteConditionsItem = class(TCrpeItem)
   private
   protected
     FRangeCondition : TCrHiliteRangeCondition;
     FStartValue     : Double;
     FEndValue       : Double;
     FFontColor      : TColor;
     FBackground     : TColor;
     FBorderStyle    : TCrHiliteBorderStyle;
     FFontStyle      : TCrHiliteFontStyle;
     function  StatusIsGo : Boolean;
     procedure SetRangeCondition (const Value: TCrHiliteRangeCondition);
     procedure SetStartValue (const Value: Double);
     procedure SetEndValue (const Value: Double);
     procedure SetFontColor (const Value: TColor);
     procedure SetBackground (const Value: TColor);
     procedure SetBorderStyle (const Value: TCrHiliteBorderStyle);
     procedure SetFontStyle (const Value: TCrHiliteFontStyle);
   published
      property RangeCondition : TCrHiliteRangeCondition
          read FRangeCondition
         write SetRangeCondition
       default hrcEqualTo;
      property StartValue : Double
          read FStartValue
         write SetStartValue;
      property EndValue : Double
          read FEndValue
         write SetEndValue;
      property FontColor : TColor
          read FFontColor
         write SetFontColor
       default clBlack;
      property Background : TColor
          read FBackground
         write SetBackground
       default clWhite;
      property BorderStyle : TCrHiliteBorderStyle
          read FBorderStyle
         write SetBorderStyle
       default hbsDefault;
      property FontStyle : TCrHiliteFontStyle
          read FFontStyle
         write SetFontStyle
       default hfsDefault;
   public
     procedure SetPriority (nIndex: Smallint);
     procedure Assign(Source: TPersistent); override;
     procedure Clear;
     constructor Create;
   end; { Class TCrpeHiliteConditionsItem }

{------------------------------------------------------------------------------}
{ Class TCrpeHiliteConditions                                                  }
{  - Hiliting only applies to numeric fields                                   }
{------------------------------------------------------------------------------}
   TCrpeHiliteConditions = class(TCrpeContainer)
   private
   protected
     FFieldType : TCrFieldValueType;  {holds parent fieldtype}
     FItem      : TCrpeHiliteConditionsItem;
     function  StatusIsGo : Boolean;
     function  GetItem (nIndex: integer) : TCrpeHiliteConditionsItem;
   published
     procedure SetIndex (nIndex: integer);
      property Number : TCrLookupNumber
          read FIndex
         write SetIndex
       default -1;
      property Item : TCrpeHiliteConditionsItem
          read FItem
         write FItem;
   public
     property ItemIndex : integer
         read FIndex
        write SetIndex;
     property Items[nIndex: integer]: TCrpeHiliteConditionsItem
         read GetItem; default;
     function  Count : integer; override;
     procedure Assign(Source: TPersistent); override;
     procedure Clear;
     function  Add : integer;
     procedure Delete (nIndex: integer);
     constructor Create;
     destructor Destroy; override;
   end; { Class TCrpeHiliteConditions }


implementation

uses SysUtils, TypInfo, UCrpe32, UCrpeUtl;

{******************************************************************************}
{ TCrpePersistent Class Definition                                             }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpePersistent.Create;
begin
  inherited Create;
  FIndex := -1;
  Cx     := nil;
  Handle :=  0;
  Parent := nil;
  FSubClassList := TList.Create;
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpePersistent.Destroy;
begin
  FSubClassList.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ PropagateCrpe                                                                }
{------------------------------------------------------------------------------}
procedure TCrpePersistent.PropagateCrpe (const Crpe: TComponent;
  const Par: TCrpePersistent);
var
  i : integer;
begin
  Cx := Crpe;
  Parent := Par;
  {Set the Cr member of any subclasses}
  for i := 0 to (FSubClassList.Count - 1) do
  begin
    if TObject(FSubClassList[i]) is TCrpePersistent then
      TCrpePersistent(FSubClassList[i]).PropagateCrpe(Crpe, Self);
    if TObject(FSubClassList[i]) is TCrpeFont then
    begin  
	  TCrpeFont(FSubClassList[i]).Cx := Crpe;
      TCrpeFont(FSubClassList[i]).Parent := Self;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ PropagateHandle                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePersistent.PropagateHandle (const NewHandle: DWord);
var
  i : integer;
begin
  Handle := NewHandle;
  {Set the Cr member of any subclasses}
  for i := 0 to (FSubClassList.Count - 1) do
  begin
    if TObject(FSubClassList[i]) is TCrpePersistent then
      TCrpePersistent(FSubClassList[i]).PropagateHandle(NewHandle);
    if TObject(FSubClassList[i]) is TCrpeFont then
      TCrpeFont(FSubClassList[i]).Handle := NewHandle;
  end;
end;
{------------------------------------------------------------------------------}
{ SetIndex                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePersistent.PropagateIndex (const NewIndex: integer);
var
  i : integer;
begin
  FIndex := NewIndex;
  {Set the FIndex member of any subclasses that are not containers}
  for i := 0 to (FSubClassList.Count - 1) do
  begin
    if TObject(FSubClassList[i]) is TCrpeContainer then
      Continue;  {skip}
    if  TObject(FSubClassList[i]) is TCrpePersistent then
      TCrpePersistent(FSubClassList[i]).PropagateIndex(NewIndex);
    if TObject(FSubClassList[i]) is TCrpeFont then
      TCrpeFont(FSubClassList[i]).FIndex := NewIndex;
  end;
end;

{******************************************************************************}
{******************************************************************************}
{ Common Object Classes                                                        }
{******************************************************************************}
{******************************************************************************}

{******************************************************************************}
{ Class TCrpeObjectContainerA                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Count                                                                        }
{------------------------------------------------------------------------------}
function TCrpeObjectContainerA.Count : integer;
begin
  Result := 0;
  if not Assigned(Cx) then Exit;
  if not TCrpe(Cx).StatusIsGo(0) then Exit;
  Result := TCrpe(Cx).GetNObjects(FObjectType, FFieldObjectType);
end;
{------------------------------------------------------------------------------}
{ SetIndex                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeObjectContainerA.SetIndex (nIndex: integer);
var
  objectInfo : PEObjectInfo;
begin
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) or IsStrEmpty(TCrpe(Cx).ReportName) then
    Exit;
  if nIndex < 0 then
  begin
    PropagateIndex(-1);
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).OpenJob then Exit;

  Handle := TCrpe(Cx).GetObjectHandle(nIndex, FObjectType, FFieldObjectType);
  if Handle = 0 then
  begin
    case TCrpe(Cx).GetErrorMsg(0,errNoOption,errVCL,ECRPE_SUBSCRIPT,
       TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ')') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  PropagateHandle(Handle);
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(TCrpe(Cx).JobNumber, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ') <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  PropagateIndex(nIndex);
  FItem.FLeft := objectInfo.xOffset;
  FItem.FTop := objectInfo.yOffset;
  FItem.FWidth := objectInfo.width;
  FItem.FHeight := objectInfo.height;
  FItem.FSection := TCrpe(Cx).SectionCodeToStringEx(objectInfo.sectionCode, False);

  if csDesigning in TCrpe(Cx).ComponentState then
    FItem.FBorder.GetBorder;
end;


{******************************************************************************}
{ Class TCrpeObjectContainerB                                                  }
{  - used for TextObjects                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Count                                                                        }
{------------------------------------------------------------------------------}
function TCrpeObjectContainerB.Count : integer;
begin
  Result := 0;
  if not Assigned(Cx) then Exit;
  if not TCrpe(Cx).StatusIsGo(0) then Exit;
  Result := TCrpe(Cx).GetNObjects(FObjectType, FFieldObjectType);
end;
{------------------------------------------------------------------------------}
{ SetIndex                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeObjectContainerB.SetIndex (nIndex: integer);
var
  objectInfo : PEObjectInfo;
begin
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) or IsStrEmpty(TCrpe(Cx).ReportName) then
    Exit;
  if nIndex < 0 then
  begin
    PropagateIndex(-1);
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).OpenJob then Exit;

  Handle := TCrpe(Cx).GetObjectHandle(nIndex, FObjectType, FFieldObjectType);
  if Handle = 0 then
  begin
    case TCrpe(Cx).GetErrorMsg(0,errNoOption,errVCL,ECRPE_SUBSCRIPT,
       TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ')') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  PropagateHandle(Handle);
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(TCrpe(Cx).JobNumber, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ') <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  PropagateIndex(nIndex);
  FItem.FLeft := objectInfo.xOffset;
  FItem.FTop := objectInfo.yOffset;
  FItem.FWidth := objectInfo.width;
  FItem.FHeight := objectInfo.height;
  FItem.FSection := TCrpe(Cx).SectionCodeToStringEx(objectInfo.sectionCode, False);
  if csDesigning in TCrpe(Cx).ComponentState then
  begin
    FItem.FBorder.GetBorder;
    FItem.FFormat.GetFormat;
  end;
end;


{******************************************************************************}
{ Class TCrpeObjectItem                                                        }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeObjectItem.Create;
begin
  inherited Create;
  FTop     := -1;
  FLeft    := -1;
  FWidth   := -1;
  FHeight  := -1;
  FSection := '';
  {Sub Classes}
  FBorder := TCrpeBorder.Create;
  FSubClassList.Add(FBorder);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeObjectItem.Destroy;
begin
  FBorder.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.Assign (Source: TPersistent);
begin
  if Source is TCrpeObjectItem then
  begin
    Top := TCrpeObjectItem(Source).Top;
    Left := TCrpeObjectItem(Source).Left;
    Width := TCrpeObjectItem(Source).Width;
    Height := TCrpeObjectItem(Source).Height;
    Section := TCrpeObjectItem(Source).Section;
    Border.Assign(TCrpeObjectItem(Source).Border);
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) then
  begin
    FIndex   := -1;
    Handle   := 0;
    FTop     := -1;
    FLeft    := -1;
    FWidth   := -1;
    FHeight  := -1;
    FSection := '';
  end;
  FBorder.Clear;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeObjectItem.StatusIsGo (nIndex: integer): Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) then Exit;
  if nIndex < 0 then
  begin
    PropagateIndex(-1);
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).OpenJob then Exit;
  {Check Handle}
  if Handle = 0 then
    Handle := TCrpe(Cx).GetObjectHandle(nIndex, TCrpeObjectContainer(Parent).FObjectType,
      TCrpeObjectContainer(Parent).FFieldObjectType);
  if Handle = 0 then
  begin
    PropagateHandle(0);
    Exit;
  end;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetBorder                                                                    }
{------------------------------------------------------------------------------}
function TCrpeObjectItem.GetBorder : TCrpeBorder;
begin
  FBorder.GetLeft;
  FBorder.GetRight;
  FBorder.GetTop;
  FBorder.GetBottom;
  FBorder.GetTightHorizontal;
  FBorder.GetDropShadow;
  FBorder.GetForeColor;
  FBorder.GetBackgroundColor;
  Result := FBorder;
end;
{------------------------------------------------------------------------------}
{ SetTop                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.SetTop (const Value: LongInt);
var
  objectInfo : PEObjectInfo;
  JobNum     : Smallint;
begin
  FTop := Value;
  if not StatusIsGo(FIndex) then Exit;

  if Parent is TCrpeSubreports then
    JobNum := TCrpe(Cx).PrintJobs(0)
  else
    JobNum := TCrpe(Cx).JobNumber;

  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(JobNum, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  if objectInfo.yOffset <> FTop then
  begin
    objectInfo.yOffset := FTop;
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectInfo(JobNum, Handle, objectInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PESetObjectInfo>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetLeft                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.SetLeft (const Value: LongInt);
var
  objectInfo : PEObjectInfo;
  JobNum     : Smallint;
begin
  FLeft := Value;
  if not StatusIsGo(FIndex) then Exit;

  if Parent is TCrpeSubreports then
    JobNum := TCrpe(Cx).PrintJobs(0)
  else
    JobNum := TCrpe(Cx).JobNumber;

  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(JobNum, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  if objectInfo.xOffset <> FLeft then
  begin
    objectInfo.xOffset := FLeft;
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectInfo(JobNum, Handle, objectInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PESetObjectInfo>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetWidth                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.SetWidth (const Value: LongInt);
var
  objectInfo : PEObjectInfo;
  JobNum     : Smallint;
begin
  FWidth := Value;
  if not StatusIsGo(FIndex) then Exit;

  if Parent is TCrpeSubreports then
    JobNum := TCrpe(Cx).PrintJobs(0)
  else
    JobNum := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(JobNum, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetWidth <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  if objectInfo.width <> FWidth then
  begin
    objectInfo.width := FWidth;
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectInfo(JobNum, Handle, objectInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetWidth <PESetObjectInfo>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetHeight                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.SetHeight (const Value: LongInt);
var
  objectInfo : PEObjectInfo;
  JobNum     : Smallint;
begin
  FHeight := Value;
  if not StatusIsGo(FIndex) then Exit;

  if Parent is TCrpeSubreports then
    JobNum := TCrpe(Cx).PrintJobs(0)
  else
    JobNum := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(JobNum, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetHeight <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  if objectInfo.height <> FHeight then
  begin
    objectInfo.height := FHeight;
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectInfo(JobNum, Handle, objectInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHeight <PESetObjectInfo>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetSection                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItem.SetSection (const Value: string);
var
  objectInfo  : PEObjectInfo;
  SectionCode : Smallint;
  JobNum      : Smallint;
begin
  FSection := Value;
  if not StatusIsGo(FIndex) then Exit;

  if Parent is TCrpeSubreports then
    JobNum := TCrpe(Cx).PrintJobs(0)
  else
    JobNum := TCrpe(Cx).JobNumber;

  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(JobNum, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetSection <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  {Convert Section name to code}
  if not StrToSectionCode(FSection, SectionCode) then
    Exit;

  if objectInfo.sectionCode <> SectionCode then
  begin
    objectInfo.sectionCode := SectionCode;
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectInfo(JobNum, Handle, objectInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(JobNum,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSection <PESetObjectInfo>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeObjectItemA                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeObjectItemA.Create;
begin
  inherited Create;
  FFormat := TCrpeFormatA.Create;
  FSubClassList.Add(FFormat);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeObjectItemA.Destroy;
begin
  FFormat.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItemA.Assign(Source: TPersistent);
begin
  if Source is TCrpeObjectItemA then
  begin
    Format.Assign(TCrpeObjectItemA(Source).Format);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItemA.Clear;
begin
  inherited Clear;
  FFormat.Clear;
end;


{******************************************************************************}
{ Class TCrpeObjectItemB                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeObjectItemB.Create;
begin
  inherited Create;
  {Format}
  FFormat := TCrpeFormatC.Create;
  FSubClassList.Add(FFormat);
  {Font}
  FFont := TCrpeFont.Create;
  FSubClassList.Add(FFont);
  FFont.OnChange := OnChangeFont;
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeObjectItemB.Destroy;
begin
  FFormat.Free;
  FFont.OnChange := nil;
  FFont.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItemB.Assign(Source: TPersistent);
begin
  if Source is TCrpeObjectItemB then
  begin
    Format.Assign(TCrpeObjectItemB(Source).Format);
    Font.Assign(TCrpeObjectItemB(Source).Font);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItemB.Clear;
begin
  inherited Clear;
  FFormat.Clear;
  FFont.Clear;
end;
{------------------------------------------------------------------------------}
{ GetFont                                                                      }
{------------------------------------------------------------------------------}
function TCrpeObjectItemB.GetFont : TCrpeFont;
begin
  FFont.GetFont;
  Result := FFont;
end;
{------------------------------------------------------------------------------}
{ OnChangeFont                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeObjectItemB.OnChangeFont (Sender: TObject);
begin
  if StatusIsGo(FIndex) then
    FFont.SetFont;
end;


{******************************************************************************}
{ Class TCrpeNumberFormat                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeNumberFormat.Create;
begin
  inherited Create;
  FSuppressIfZero           := False;
  FNegativeFormat           := nfLeading;
  FUseThousandsSeparators   := True;
  FUseLeadingZero           := True;
  FDecimalPlaces            := 0;
  FRoundingFormat           := rfUnit;
  FReverseSignForDisplay    := False;
  FUseAccountingFormat      := False;
  FCurrencySymbol           := '$';
  FCurrencySymbolFormat     := csfFloating;
  FOneCurrencySymbolPerPage := False;
  FCurrencySymbolPosition   := cspLeadingInside;
  FThousandSymbol           := ',';
  FDecimalSymbol            := '.';
  FShowZeroValueAs          := '0';
  FAllowFieldClipping       := True;
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex                    := -1;
    Handle                    := 0;
    FSuppressIfZero           := False;
    FNegativeFormat           := nfLeading;
    FUseThousandsSeparators   := True;
    FUseLeadingZero           := True;
    FDecimalPlaces            := 0;
    FRoundingFormat           := rfUnit;
    FReverseSignForDisplay    := False;
    FUseAccountingFormat      := False;
    FCurrencySymbol           := '$';
    FCurrencySymbolFormat     := csfFloating;
    FOneCurrencySymbolPerPage := False;
    FCurrencySymbolPosition   := cspLeadingInside;
    FThousandSymbol           := ',';
    FDecimalSymbol            := '.';
    FShowZeroValueAs          := '0';
    FAllowFieldClipping       := True;
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeNumberFormat then
  begin
    SuppressIfZero           := TCrpeNumberFormat(Source).SuppressIfZero;
    NegativeFormat           := TCrpeNumberFormat(Source).NegativeFormat;
    UseThousandsSeparators   := TCrpeNumberFormat(Source).UseThousandsSeparators;
    UseLeadingZero           := TCrpeNumberFormat(Source).UseLeadingZero;
    DecimalPlaces            := TCrpeNumberFormat(Source).DecimalPlaces;
    RoundingFormat           := TCrpeNumberFormat(Source).RoundingFormat;
    ReverseSignForDisplay    := TCrpeNumberFormat(Source).ReverseSignForDisplay;
    UseAccountingFormat      := TCrpeNumberFormat(Source).UseAccountingFormat;
    CurrencySymbol           := TCrpeNumberFormat(Source).CurrencySymbol;
    CurrencySymbolFormat     := TCrpeNumberFormat(Source).CurrencySymbolFormat;
    OneCurrencySymbolPerPage := TCrpeNumberFormat(Source).OneCurrencySymbolPerPage;
    CurrencySymbolPosition   := TCrpeNumberFormat(Source).CurrencySymbolPosition;
    ThousandSymbol           := TCrpeNumberFormat(Source).ThousandSymbol;
    DecimalSymbol            := TCrpeNumberFormat(Source).DecimalSymbol;
    ShowZeroValueAs          := TCrpeNumberFormat(Source).ShowZeroValueAs;
    AllowFieldClipping       := TCrpeNumberFormat(Source).AllowFieldClipping;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.GetFormat;
begin
  GetSuppressIfZero;
  GetNegativeFormat;
  GetUseThousandsSeparators;
  GetUseLeadingZero;
  GetDecimalPlaces;
  GetRoundingFormat;
  GetReverseSignForDisplay;
  GetUseAccountingFormat;
  GetCurrencySymbol;
  GetCurrencySymbolFormat;
  GetOneCurrencySymbolPerPage;
  GetCurrencySymbolPosition;
  GetThousandSymbol;
  GetDecimalSymbol;
  GetShowZeroValueAs;
  GetAllowFieldClipping;
end;
{------------------------------------------------------------------------------}
{ GetSuppressIfZero                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetSuppressIfZero : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FSuppressIfZero;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SUPPRESS_IF_ZERO, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfZero <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_ZERO,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfZero <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSuppressIfZero := ValueInfo.viBoolean;
  Result := FSuppressIfZero;
end;
{------------------------------------------------------------------------------}
{ SetSuppressIfZero                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetSuppressIfZero (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FSuppressIfZero := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SUPPRESS_IF_ZERO, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfZero <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FSuppressIfZero;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_ZERO,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfZero <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FSuppressIfZero;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FSuppressIfZero) then
  begin
    ValueInfo.viBoolean := Bool(FSuppressIfZero);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_SUPPRESS_IF_ZERO, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfZero <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_ZERO,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfZero <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetNegativeFormat                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetNegativeFormat : TCrNegativeFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FNegativeFormat;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_NEGATIVE_TYPE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetNegativeFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_NEGATIVE_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetNegativeFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_NNT_NOT_NEGATIVE   : FNegativeFormat := nfNone;
    PE_NNT_LEADING_MINUS  : FNegativeFormat := nfLeading;
    PE_NNT_TRAILING_MINUS : FNegativeFormat := nfTrailing;
    PE_NNT_BRACKETED      : FNegativeFormat := nfBracketed;
    else
      FNegativeFormat := nfLeading;
  end;
  Result := FNegativeFormat;
end;
{------------------------------------------------------------------------------}
{ SetNegativeFormat                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetNegativeFormat (const Value: TCrNegativeFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FNegativeFormat := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_NEGATIVE_TYPE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetNegativeFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_NEGATIVE_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetNegativeFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viInteger <> Ord(FNegativeFormat) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FNegativeFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_NEGATIVE_TYPE, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetNegativeFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_NEGATIVE_TYPE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetNegativeFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetUseThousandsSeparators                                                    }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetUseThousandsSeparators : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FUseThousandsSeparators;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_THOUSANDSSEPARATORS, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseThousandsSeparators <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_THOUSANDSSEPARATORS,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseThousandsSeparators <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FUseThousandsSeparators := ValueInfo.viBoolean;
  Result := FUseThousandsSeparators;
end;
{------------------------------------------------------------------------------}
{ SetUseThousandsSeparators                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetUseThousandsSeparators (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FUseThousandsSeparators := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_THOUSANDSSEPARATORS, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseThousandsSeparators <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseThousandsSeparators;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_THOUSANDSSEPARATORS,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseThousandsSeparators <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseThousandsSeparators;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FUseThousandsSeparators) then
  begin
    ValueInfo.viBoolean := Bool(FUseThousandsSeparators);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_USE_THOUSANDSSEPARATORS, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseThousandsSeparators <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_THOUSANDSSEPARATORS,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseThousandsSeparators <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetUseLeadingZero                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetUseLeadingZero : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FUseLeadingZero;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_LEAD_ZERO, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseLeadingZero <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_LEAD_ZERO,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseLeadingZero <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FUseLeadingZero := ValueInfo.viBoolean;
  Result := FUseLeadingZero;
end;
{------------------------------------------------------------------------------}
{ SetUseLeadingZero                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetUseLeadingZero (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FUseLeadingZero := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_LEAD_ZERO, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseLeadingZero <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseLeadingZero;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_LEAD_ZERO,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseLeadingZero <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseLeadingZero;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viBoolean <> Bool(FUseLeadingZero) then
  begin
    ValueInfo.viBoolean := Bool(FUseLeadingZero);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_USE_LEAD_ZERO, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseLeadingZero <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_LEAD_ZERO,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseLeadingZero <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDecimalPlaces                                                             }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetDecimalPlaces : integer;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDecimalPlaces;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_N_DECIMAL_PLACES, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDecimalPlaces <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_N_DECIMAL_PLACES,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDecimalPlaces <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FDecimalPlaces := ValueInfo.viInteger;
  Result := FDecimalPlaces;
end;
{------------------------------------------------------------------------------}
{ SetDecimalPlaces                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetDecimalPlaces (const Value: integer);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDecimalPlaces := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_N_DECIMAL_PLACES, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalPlaces <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_N_DECIMAL_PLACES,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalPlaces <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viInteger <> FDecimalPlaces then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := FDecimalPlaces;
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_N_DECIMAL_PLACES, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalPlaces <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_N_DECIMAL_PLACES,
        ValueInfo) then
      begin
          case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalPlaces <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetRoundingFormat                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetRoundingFormat : TCrRoundingFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FRoundingFormat;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_ROUNDING_TYPE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRoundingFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ROUNDING_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRoundingFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_NRT_ROUND_TO_TEN_BILLIONTH      : FRoundingFormat := rfTenBillionth;
    PE_NRT_ROUND_TO_BILLIONTH          : FRoundingFormat := rfBillionth;
    PE_NRT_ROUND_TO_HUNDRED_MILLIONTH  : FRoundingFormat := rfHundredMillionth;
    PE_NRT_ROUND_TO_TEN_MILLIONTH      : FRoundingFormat := rfTenMillionth;
    PE_NRT_ROUND_TO_MILLIONTH          : FRoundingFormat := rfMillionth;
    PE_NRT_ROUND_TO_HUNDRED_THOUSANDTH : FRoundingFormat := rfHundredThousandth;
    PE_NRT_ROUND_TO_TEN_THOUSANDTH     : FRoundingFormat := rfTenThousandth;
    PE_NRT_ROUND_TO_THOUSANDTH         : FRoundingFormat := rfThousandth;
    PE_NRT_ROUND_TO_HUNDREDTH          : FRoundingFormat := rfHundredth;
    PE_NRT_ROUND_TO_TENTH              : FRoundingFormat := rfTenth;
    PE_NRT_ROUND_TO_UNIT               : FRoundingFormat := rfUnit;
    PE_NRT_ROUND_TO_TEN                : FRoundingFormat := rfTen;
    PE_NRT_ROUND_TO_HUNDRED            : FRoundingFormat := rfHundred;
    PE_NRT_ROUND_TO_THOUSAND           : FRoundingFormat := rfThousand;
    PE_NRT_ROUND_TO_TENTHOUSAND        : FRoundingFormat := rfTenThousand;
    PE_NRT_ROUND_TO_HUNDREDTHOUSAND    : FRoundingFormat := rfHundredThousand;
    PE_NRT_ROUND_TO_MILLION            : FRoundingFormat := rfMillion;
    else
      FRoundingFormat := rfUnit;
  end;
  Result := FRoundingFormat;
end;
{------------------------------------------------------------------------------}
{ SetRoundingFormat                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetRoundingFormat (const Value: TCrRoundingFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FRoundingFormat := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_ROUNDING_TYPE, valueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRoundingFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ROUNDING_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRoundingFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viInteger <> (Ord(FRoundingFormat) + 1) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := (Ord(FRoundingFormat) + 1);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_ROUNDING_TYPE, valueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRoundingFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ROUNDING_TYPE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRoundingFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetReverseSignForDisplay                                                     }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetReverseSignForDisplay : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FReverseSignForDisplay;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_REVERSE_SIGN_FOR_DISPLAY, valueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetReverseSignForDisplay <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_REVERSE_SIGN_FOR_DISPLAY,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetReverseSignForDisplay <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FReverseSignForDisplay := ValueInfo.viBoolean;
  Result := FReverseSignForDisplay;
end;
{------------------------------------------------------------------------------}
{ SetReverseSignForDisplay                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetReverseSignForDisplay (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FReverseSignForDisplay := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_REVERSE_SIGN_FOR_DISPLAY, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetReverseSignForDisplay <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FReverseSignForDisplay;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_REVERSE_SIGN_FOR_DISPLAY,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetReverseSignForDisplay <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FReverseSignForDisplay;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FReverseSignForDisplay) then
  begin
    ValueInfo.viBoolean := Bool(FReverseSignForDisplay);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_REVERSE_SIGN_FOR_DISPLAY, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetReverseSignForDisplay <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_REVERSE_SIGN_FOR_DISPLAY,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetReverseSignForDisplay <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetUseAccountingFormat                                                       }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetUseAccountingFormat : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FUseAccountingFormat;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_ACCOUNTING_FORMAT, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseAccountingFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ACCOUNTING_FORMAT,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseAccountingFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FUseAccountingFormat := ValueInfo.viBoolean;
  Result := FUseAccountingFormat;
end;
{------------------------------------------------------------------------------}
{ SetUseAccountingFormat                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetUseAccountingFormat (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FUseAccountingFormat := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_ACCOUNTING_FORMAT, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseAccountingFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseAccountingFormat;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ACCOUNTING_FORMAT,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseAccountingFormat <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseAccountingFormat;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FUseAccountingFormat) then
  begin
    ValueInfo.viBoolean := Bool(FUseAccountingFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_USE_ACCOUNTING_FORMAT, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseAccountingFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ACCOUNTING_FORMAT,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseAccountingFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCurrencySymbol                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetCurrencySymbol : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FCurrencySymbol;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_SYMBOL, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbol <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end
  end;
  FCurrencySymbol := String(ValueInfo.viString);
  Result := FCurrencySymbol;
end;
{------------------------------------------------------------------------------}
{ SetCurrencySymbol                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetCurrencySymbol (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FCurrencySymbol := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_SYMBOL, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbol <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FCurrencySymbol) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FCurrencySymbol));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_CURRENCY_SYMBOL, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbol <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbol <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCurrencySymbolFormat                                                      }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetCurrencySymbolFormat : TCrCurrencySymbolFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FCurrencySymbolFormat;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_SYMBOL_TYPE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbolFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbolFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_CST_NO_SYMBOL       : FCurrencySymbolFormat := csfNone;
    PE_CST_FIXED_SYMBOL    : FCurrencySymbolFormat := csfFixed;
    PE_CST_FLOATING_SYMBOL : FCurrencySymbolFormat := csfFloating;
    else
      FCurrencySymbolFormat := csfFloating;
  end;
  Result := FCurrencySymbolFormat;
end;
{------------------------------------------------------------------------------}
{ SetCurrencySymbolFormat                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetCurrencySymbolFormat (const Value: TCrCurrencySymbolFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FCurrencySymbolFormat := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_SYMBOL_TYPE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viInteger <> Ord(FCurrencySymbolFormat) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FCurrencySymbolFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_CURRENCY_SYMBOL_TYPE, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_SYMBOL_TYPE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetOneCurrencySymbolPerPage                                                  }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetOneCurrencySymbolPerPage : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FOneCurrencySymbolPerPage;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetOneCurrencySymbolPerPage <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetOneCurrencySymbolPerPage <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FOneCurrencySymbolPerPage := ValueInfo.viBoolean;
  Result := FOneCurrencySymbolPerPage;
end;
{------------------------------------------------------------------------------}
{ SetOneCurrencySymbolPerPage                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetOneCurrencySymbolPerPage (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FOneCurrencySymbolPerPage := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetOneCurrencySymbolPerPage <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FOneCurrencySymbolPerPage;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetOneCurrencySymbolPerPage <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FOneCurrencySymbolPerPage;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FOneCurrencySymbolPerPage) then
  begin
    ValueInfo.viBoolean := Bool(FOneCurrencySymbolPerPage);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetOneCurrencySymbolPerPage <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_ONE_CURRENCY_SYMBOL_PER_PAGE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetOneCurrencySymbolPerPage <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCurrencySymbolPosition                                                    }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetCurrencySymbolPosition : TCrCurrencySymbolPosition;
var
  ValueInfo : PEValueInfo;
begin
  Result := FCurrencySymbolPosition;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_POSITION_TYPE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbolPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_POSITION_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCurrencySymbolPosition <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_CPT_LEADING_CURRENCY_INSIDE_NEGATIVE   : FCurrencySymbolPosition := cspLeadingInside;
    PE_CPT_LEADING_CURRENCY_OUTSIDE_NEGATIVE  : FCurrencySymbolPosition := cspLeadingOutside;
    PE_CPT_TRAILING_CURRENCY_INSIDE_NEGATIVE  : FCurrencySymbolPosition := cspTrailingInside;
    PE_CPT_TRAILING_CURRENCY_OUTSIDE_NEGATIVE : FCurrencySymbolPosition := cspTrailingOutside;
    else
      FCurrencySymbolPosition := cspLeadingInside;
  end;
  Result := FCurrencySymbolPosition;
end;
{------------------------------------------------------------------------------}
{ SetCurrencySymbolPosition                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetCurrencySymbolPosition (const Value: TCrCurrencySymbolPosition);
var
  ValueInfo : PEValueInfo;
  iPosition : Smallint;
  Changed   : Boolean;
begin
  FCurrencySymbolPosition := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CURRENCY_POSITION_TYPE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_POSITION_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolPosition <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  iPosition := PE_CPT_LEADING_CURRENCY_INSIDE_NEGATIVE;
  case FCurrencySymbolPosition of
    cspLeadingInside   : iPosition := PE_CPT_LEADING_CURRENCY_INSIDE_NEGATIVE;
    cspLeadingOutside  : iPosition := PE_CPT_LEADING_CURRENCY_OUTSIDE_NEGATIVE;
    cspTrailingInside  : iPosition := PE_CPT_TRAILING_CURRENCY_INSIDE_NEGATIVE;
    cspTrailingOutside : iPosition := PE_CPT_TRAILING_CURRENCY_OUTSIDE_NEGATIVE;
  end;
  if ValueInfo.viInteger <> iPosition then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := iPosition;
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_CURRENCY_POSITION_TYPE, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolPosition <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CURRENCY_POSITION_TYPE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCurrencySymbolPosition <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetThousandSymbol                                                            }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetThousandSymbol : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FThousandSymbol;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_THOUSAND_SYMBOL, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetThousandSymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_THOUSAND_SYMBOL,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetThousandSymbol <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FThousandSymbol := String(ValueInfo.viString);
  Result := FThousandSymbol;
end;
{------------------------------------------------------------------------------}
{ SetThousandSymbol                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetThousandSymbol (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FThousandSymbol := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_THOUSAND_SYMBOL, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetThousandSymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_THOUSAND_SYMBOL,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetThousandSymbol <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FThousandSymbol) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FThousandSymbol));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_THOUSAND_SYMBOL, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetThousandSymbol <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_THOUSAND_SYMBOL,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetThousandSymbol <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDecimalSymbol                                                             }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetDecimalSymbol : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDecimalSymbol;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DECIMAL_SYMBOL, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDecimalSymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DECIMAL_SYMBOL,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDecimalSymbol <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FDecimalSymbol := String(ValueInfo.viString);
  Result := FDecimalSymbol;
end;
{------------------------------------------------------------------------------}
{ SetDecimalSymbol                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetDecimalSymbol (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FDecimalSymbol := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DECIMAL_SYMBOL, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalSymbol <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DECIMAL_SYMBOL,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalSymbol <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FDecimalSymbol) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FDecimalSymbol));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DECIMAL_SYMBOL, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalSymbol <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DECIMAL_SYMBOL,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDecimalSymbol <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetShowZeroValueAs                                                           }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetShowZeroValueAs : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FShowZeroValueAs;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SHOW_ZERO_VALUE_AS, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetShowZeroValueAs <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SHOW_ZERO_VALUE_AS,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetShowZeroValueAs <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FShowZeroValueAs := String(ValueInfo.viString);
  Result := FShowZeroValueAs;
end;
{------------------------------------------------------------------------------}
{ SetShowZeroValueAs                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetShowZeroValueAs (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FShowZeroValueAs := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SHOW_ZERO_VALUE_AS, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetShowZeroValueAs <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SHOW_ZERO_VALUE_AS,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetShowZeroValueAs <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FShowZeroValueAs) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FShowZeroValueAs));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_SHOW_ZERO_VALUE_AS, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetShowZeroValueAs <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SHOW_ZERO_VALUE_AS,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetShowZeroValueAs <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetAllowFieldClipping                                                        }
{------------------------------------------------------------------------------}
function TCrpeNumberFormat.GetAllowFieldClipping : boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FAllowFieldClipping;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_ALLOW_FIELD_CLIPPING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAllowFieldClipping <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ALLOW_FIELD_CLIPPING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAllowFieldClipping <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FAllowFieldClipping := ValueInfo.viBoolean;
  Result := FAllowFieldClipping;
end;
{------------------------------------------------------------------------------}
{ SetAllowFieldClipping                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeNumberFormat.SetAllowFieldClipping (const Value: boolean);
var
  ValueInfo : PEValueInfo;
begin
  FAllowFieldClipping := Value;
  if not (FFieldType in [fvInt8s..fvCurrency]) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_ALLOW_FIELD_CLIPPING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAllowFieldClipping <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FAllowFieldClipping;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ALLOW_FIELD_CLIPPING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAllowFieldClipping <PEGetObjectFormat>') of
        errIgnore : ValueInfo.viBoolean := not FAllowFieldClipping;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viBoolean <> Bool(FAllowFieldClipping) then
  begin
    ValueInfo.viBoolean := Bool(FAllowFieldClipping);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_ALLOW_FIELD_CLIPPING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAllowFieldClipping <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_ALLOW_FIELD_CLIPPING,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAllowFieldClipping <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeDateFormat                                                        }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeDateFormat.Create;
begin
  inherited Create;
  FDateType           := dfWindowsShort;
  FDateOrder          := doMDY;
  FYearFormat         := yfLong;
  FMonthFormat        := mfLeadingZeroNumeric;
  FDayFormat          := dfLeadingZeroNumeric;
  FDayOfWeekType      := dwfNone;
  FFirstSeparator     := '/';
  FSecondSeparator    := '/';
  FDayOfWeekSeparator := '';
  FDayOfWeekPosition  := dwpLeading;
  FDayOfWeekEnclosure := dweNone;
  FDateEra            := deNone;
  FCalendarType       := ctGregorian;
  FPrefixSeparator    := '';
  FSuffixSeparator    := '';
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex               := -1;
    Handle               := 0;
    FDateType            := dfWindowsShort;
    FDateOrder           := doMDY;
    FYearFormat          := yfLong;
    FMonthFormat         := mfLeadingZeroNumeric;
    FDayFormat           := dfLeadingZeroNumeric;
    FDayOfWeekType       := dwfNone;
    FFirstSeparator      := '/';
    FSecondSeparator     := '/';
    FDayOfWeekSeparator  := '';
    FDayOfWeekPosition   := dwpLeading;
    FDayOfWeekEnclosure  := dweNone;
    FDateEra             := deNone;
    FCalendarType        := ctGregorian;
    FPrefixSeparator     := '';
    FSuffixSeparator     := '';
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeDateFormat then
  begin
    DateType           := TCrpeDateFormat(Source).DateType;
    DateOrder          := TCrpeDateFormat(Source).DateOrder;
    YearFormat         := TCrpeDateFormat(Source).YearFormat;
    MonthFormat        := TCrpeDateFormat(Source).MonthFormat;
    DayFormat          := TCrpeDateFormat(Source).DayFormat;
    DayOfWeekType      := TCrpeDateFormat(Source).DayOfWeekType;
    FirstSeparator     := TCrpeDateFormat(Source).FirstSeparator;
    SecondSeparator    := TCrpeDateFormat(Source).SecondSeparator;
    DayOfWeekSeparator := TCrpeDateFormat(Source).DayOfWeekSeparator;
    DayOfWeekPosition  := TCrpeDateFormat(Source).DayOfWeekPosition;
    DayOfWeekEnclosure := TCrpeDateFormat(Source).DayOfWeekEnclosure;
    DateEra            := TCrpeDateFormat(Source).DateEra;
    CalendarType       := TCrpeDateFormat(Source).CalendarType;
    PrefixSeparator    := TCrpeDateFormat(Source).PrefixSeparator;
    SuffixSeparator    := TCrpeDateFormat(Source).SuffixSeparator;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.GetFormat;
begin
  GetDateType;
  GetDateOrder;
  GetYearFormat;
  GetMonthFormat;
  GetDayFormat;
  GetDayOfWeekType;
  GetFirstSeparator;
  GetSecondSeparator;
  GetDayOfWeekSeparator;
  GetDayOfWeekPosition;
  GetDayOfWeekEnclosure;
  GetDateEra;
  GetCalendarType;
  GetPrefixSeparator;
  GetSuffixSeparator;
end;
{------------------------------------------------------------------------------}
{ GetDateType                                                                  }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDateType : TCrDateType;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDateType;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {Get DateType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DWDT_USE_WINDOWS_LONG_DATE      : FDateType := dfWindowsLong;
    PE_DWDT_USE_WINDOWS_SHORT_DATE     : FDateType := dfWindowsShort;
    PE_DWDT_NOT_USING_WINDOWS_DEFAULTS : FDateType := dfUserDefined;
    else
      FDateType := dfWindowsShort;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDateOrder                                                                 }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDateOrder : TCrDateOrder;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDateOrder;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DateOrder}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_ORDER, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateOrder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ORDER, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateOrder <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DO_YEAR_MONTH_DAY : FDateOrder := doYMD;
    PE_DO_DAY_MONTH_YEAR : FDateOrder := doDMY;
    PE_DO_MONTH_DAY_YEAR : FDateOrder := doMDY;
    else
      FDateOrder := doMDY;
  end;
end;
{------------------------------------------------------------------------------}
{ GetYearFormat                                                                }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetYearFormat : TCrYearFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FYearFormat;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {Year Format}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_YEAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetYearFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_YEAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetYearFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DYT_SHORT_YEAR : FYearFormat := yfShort;
    PE_DYT_LONG_YEAR  : FYearFormat := yfLong;
    PE_DYT_NO_YEAR    : FYearFormat := yfNone;
    else
      FYearFormat := yfLong;
  end;
end;
{------------------------------------------------------------------------------}
{ GetMonthFormat                                                               }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetMonthFormat : TCrMonthFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FMonthFormat;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {Month Format}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MONTH_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMonthFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MONTH_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMonthFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DMT_NUMERIC_MONTH              : FMonthFormat := mfNumeric;
    PE_DMT_LEADING_ZERO_NUMERIC_MONTH : FMonthFormat := mfLeadingZeroNumeric;
    PE_DMT_SHORT_MONTH                : FMonthFormat := mfShort;
    PE_DMT_LONG_MONTH                 : FMonthFormat := mfLong;
    PE_DMT_NO_MONTH                   : FMonthFormat := mfNone;
    else
      FMonthFormat := mfLeadingZeroNumeric;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDayFormat                                                                 }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDayFormat : TCrDayFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDayFormat;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {Day Format}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayFormat <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DDT_NUMERIC_DAY              : FDayFormat := dfNumeric;
    PE_DDT_LEADING_ZERO_NUMERIC_DAY : FDayFormat := dfLeadingZeroNumeric;
    PE_DDT_NO_DAY                   : FDayFormat := dfNone;
    else
      FDayFormat := dfLeadingZeroNumeric;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDayOfWeekType                                                             }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDayOfWeekType : TCrDayOfWeekType;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDayOfWeekType;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DayOfWeekType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DOWT_SHORT_DAY_OF_WEEK : FDayOfWeekType := dwfShort;
    PE_DOWT_LONG_DAY_OF_WEEK  : FDayOfWeekType := dwfLong;
    PE_DOWT_NO_DAY_OF_WEEK    : FDayOfWeekType := dwfNone;
    else
      FDayOfWeekType := dwfNone;
  end;
end;
{------------------------------------------------------------------------------}
{ GetFirstSeparator                                                            }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetFirstSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FFirstSeparator;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {FirstSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_FIRST_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetFirstSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_FIRST_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetFirstSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FFirstSeparator := String(ValueInfo.viString);
end;
{------------------------------------------------------------------------------}
{ GetSecondSeparator                                                           }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetSecondSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FSecondSeparator;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {SecondSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_SECOND_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSecondSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SECOND_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSecondSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSecondSeparator := String(ValueInfo.viString);
end;
{------------------------------------------------------------------------------}
{ GetDayOfWeekSeparator                                                        }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDayOfWeekSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDayOfWeekSeparator;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DayOfWeekSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FDayOfWeekSeparator := String(ValueInfo.viString);
end;
{------------------------------------------------------------------------------}
{ GetDayOfWeekPosition                                                         }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDayOfWeekPosition : TCrDayOfWeekPosition;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDayOfWeekPosition;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DayOfWeekPosition}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_POSITION, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_POSITION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekPosition <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DOWP_LEADING_DAY_OF_WEEK  : FDayOfWeekPosition := dwpLeading;
    PE_DOWP_TRAILING_DAY_OF_WEEK : FDayOfWeekPosition := dwpTrailing;
    else
      FDayOfWeekPosition := dwpLeading;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDayOfWeekEnclosure                                                        }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDayOfWeekEnclosure : TCrDayOfWeekEnclosure;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDayOfWeekEnclosure;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DayOfWeekEnclosure}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_ENCLOSURE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekEnclosure <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_ENCLOSURE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDayOfWeekEnclosure <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DOWE_NONE              : FDayOfWeekEnclosure := dweNone;
    PE_DOWE_PARENTHESES       : FDayOfWeekEnclosure := dweParentheses;
    PE_DOWE_FWPARENTHESES     : FDayOfWeekEnclosure := dweFWParentheses;
    PE_DOWE_SQUARE_BRACKETS   : FDayOfWeekEnclosure := dweSquareBrackets;
    PE_DOWE_FWSQUARE_BRACKETS : FDayOfWeekEnclosure := dweFWSquareBrackets;
    else
      FDayOfWeekEnclosure := dweNone;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDateEra                                                                   }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetDateEra : TCrDateEra;
var
  ValueInfo : PEValueInfo;
begin
  Result := FDateEra;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {DateEra}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateEra <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDateEra <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DET_SHORT_ERA : FDateEra := deShort;
    PE_DET_LONG_ERA  : FDateEra := deLong;
    PE_DET_NO_ERA    : FDateEra := deNone;
    else
      FDateEra := deNone;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCalendarType                                                              }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetCalendarType : TCrCalendarType;
var
  ValueInfo : PEValueInfo;
begin
  Result := FCalendarType;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {CalendarType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_CALENDAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCalendarType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_CALENDAR_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCalendarType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DCT_GREGORIANCALENDAR   : FCalendarType := ctGregorian;
    PE_DCT_GREGORIANUSCALENDAR : FCalendarType := ctGregorianus;
    PE_DCT_JAPANESECALENDAR    : FCalendarType := ctJapanese;
    PE_DCT_TAIWANESECALENDAR   : FCalendarType := ctTaiwanese;
    PE_DCT_KOREANCALENDAR      : FCalendarType := ctKorean;
    PE_DCT_HIJRICALENDAR       : FCalendarType := ctHijri;
    PE_DCT_THAICALENDAR        : FCalendarType := ctThai;
    {SCR8+}
    PE_DCT_HEBREWCALENDAR               : FCalendarType := ctHebrew;
    PE_DCT_GREGORIANMEFRENCHCALENDAR    : FCalendarType := ctGregorianMEFrench;
    PE_DCT_GREGORIANARABICCALENDAR      : FCalendarType := ctGregorianArabic;
    PE_DCT_GREGORIANXLITENGLISHCALENDAR : FCalendarType := ctGregorianTransEnglish;
    PE_DCT_GREGORIANXLITFRENCHCALENDAR  : FCalendarType := ctGregorianTransFrench;
    else
      FCalendarType := ctGregorian;
  end;
end;
{------------------------------------------------------------------------------}
{ GetPrefixSeparator                                                           }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetPrefixSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FPrefixSeparator;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {PrefixSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_PREFIX_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetPrefixSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_PREFIX_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetPrefixSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FPrefixSeparator := String(ValueInfo.viString);
end;
{------------------------------------------------------------------------------}
{ GetSuffixSeparator                                                           }
{------------------------------------------------------------------------------}
function TCrpeDateFormat.GetSuffixSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FSuffixSeparator;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;

  {SuffixSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_SUFFIX_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuffixSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SUFFIX_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuffixSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSuffixSeparator := String(ValueInfo.viString);
end;
{------------------------------------------------------------------------------}
{ SetDateType                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDateType (const Value: TCrDateType);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDateType := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDateType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDateType);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_WINDOWS_DEFAULT_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDateOrder                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDateOrder (const Value: TCrDateOrder);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDateOrder := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_ORDER, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateOrder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ORDER, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateOrder <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDateOrder) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDateOrder);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_ORDER, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateOrder <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ORDER, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateOrder <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetYearFormat                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetYearFormat (const Value: TCrYearFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FYearFormat := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_YEAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetYearFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_YEAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetYearFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FYearFormat) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FYearFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_YEAR_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetYearFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_YEAR_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetYearFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetMonthFormat                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetMonthFormat (const Value: TCrMonthFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FMonthFormat := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MONTH_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMonthFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MONTH_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMonthFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FMonthFormat) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FMonthFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_MONTH_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMonthFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MONTH_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMonthFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDayFormat                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDayFormat (const Value: TCrDayFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDayFormat := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayFormat <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayFormat <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDayFormat) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDayFormat);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DAY_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayFormat <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayFormat <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDayOfWeekType                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDayOfWeekType (const Value: TCrDayOfWeekType);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDayOfWeekType := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDayOfWeekType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDayOfWeekType);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetFirstSeparator                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetFirstSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FFirstSeparator := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_FIRST_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFirstSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_FIRST_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFirstSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FFirstSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FFirstSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_FIRST_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetFirstSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_FIRST_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetFirstSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetSecondSeparator                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetSecondSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FSecondSeparator := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_SECOND_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSecondSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SECOND_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSecondSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FSecondSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FSecondSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_SECOND_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSecondSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SECOND_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSecondSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDayOfWeekSeparator                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDayOfWeekSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FDayOfWeekSeparator := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FDayOfWeekSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FDayOfWeekSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DAY_OF_WEEK_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDayOfWeekPosition                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDayOfWeekPosition (const Value: TCrDayOfWeekPosition);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDayOfWeekPosition := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_POSITION, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_POSITION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekPosition <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDayOfWeekPosition) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDayOfWeekPosition);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DAY_OF_WEEK_POSITION, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekPosition <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_POSITION,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekPosition <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDayOfWeekEnclosure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDayOfWeekEnclosure (const Value: TCrDayOfWeekEnclosure);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDayOfWeekEnclosure := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DAY_OF_WEEK_ENCLOSURE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekEnclosure <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_ENCLOSURE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekEnclosure <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDayOfWeekEnclosure) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDayOfWeekEnclosure);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DAY_OF_WEEK_ENCLOSURE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekEnclosure <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DAY_OF_WEEK_ENCLOSURE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDayOfWeekEnclosure <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDateEra                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetDateEra (const Value: TCrDateEra);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FDateEra := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateEra <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDateEra <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FDateEra) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FDateEra);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateEra <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_ERA_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDateEra <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetCalendarType                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetCalendarType (const Value: TCrCalendarType);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FCalendarType := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_CALENDAR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCalendarType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_CALENDAR_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCalendarType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> (Ord(FCalendarType) + 1) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := (Ord(FCalendarType) + 1);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_CALENDAR_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCalendarType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_CALENDAR_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCalendarType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetPrefixSeparator                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetPrefixSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FPrefixSeparator := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_PREFIX_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetPrefixSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_PREFIX_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetPrefixSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FPrefixSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FPrefixSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_PREFIX_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetPrefixSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_PREFIX_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetPrefixSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetSuffixSeparator                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDateFormat.SetSuffixSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FSuffixSeparator := Value;
  if FFieldType <> fvDate then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_SUFFIX_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuffixSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SUFFIX_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuffixSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FSuffixSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FSuffixSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_SUFFIX_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuffixSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_SUFFIX_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuffixSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeTimeFormat                                                        }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeTimeFormat.Create;
begin
  inherited Create;
  FTimeBase              := tf12Hour;
  FAmPmPosition          := ampmAfter;
  FHourType              := tfNoLeadingZero;
  FMinuteType            := tfNumeric;
  FSecondType            := tfNumeric;
  FAMString              := 'AM';
  FPMString              := 'PM';
  FHourMinSeparator   := ':';
  FMinSecSeparator := ':';
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex                 := -1;
    Handle                 := 0;
    FTimeBase              := tf12Hour;
    FAmPmPosition          := ampmAfter;
    FHourType              := tfNoLeadingZero;
    FMinuteType            := tfNumeric;
    FSecondType            := tfNumeric;
    FAMString              := 'AM';
    FPMString              := 'PM';
    FHourMinSeparator   := ':';
    FMinSecSeparator := ':';
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeTimeFormat then
  begin
    TimeBase              := TCrpeTimeFormat(Source).TimeBase;
    AmPmPosition          := TCrpeTimeFormat(Source).AmPmPosition;
    HourType              := TCrpeTimeFormat(Source).HourType;
    MinuteType            := TCrpeTimeFormat(Source).MinuteType;
    SecondType            := TCrpeTimeFormat(Source).SecondType;
    AMString              := TCrpeTimeFormat(Source).AMString;
    PMString              := TCrpeTimeFormat(Source).PMString;
    HourMinSeparator   := TCrpeTimeFormat(Source).HourMinSeparator;
    MinSecSeparator := TCrpeTimeFormat(Source).MinSecSeparator;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.GetFormat;
begin
  GetTimeBase;
  GetAmPmPosition;
  GetHourType;
  GetMinuteType;
  GetSecondType;
  GetAMString;
  GetPMString;
  GetHourMinSeparator;
  GetMinSecSeparator;
end;
{------------------------------------------------------------------------------}
{ GetTimeBase                                                                  }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetTimeBase : TCrTimeBase;
var
  ValueInfo : PEValueInfo;
begin
  Result := FTimeBase;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {TimeBase}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TIME_BASE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTimeBase <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TIME_BASE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTimeBase <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_TB_12_HOUR : FTimeBase := tf12Hour;
    PE_TB_24_HOUR : FTimeBase := tf24Hour;
    else
      FTimeBase := tf12Hour;
  end;
  Result := FTimeBase;
end;
{------------------------------------------------------------------------------}
{ GetAmPmPosition                                                              }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetAmPmPosition : TCrAmPmPosition;
var
  ValueInfo : PEValueInfo;
begin
  Result := FAmPmPosition;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {AmPmPosition}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_AM_PM_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAmPmPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_PM_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAmPmPosition <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_TAPT_AM_PM_BEFORE : FAmPmPosition := ampmBefore;
    PE_TAPT_AM_PM_AFTER  : FAmPmPosition := ampmAfter;
    else
      FAmPmPosition := ampmAfter;
  end;
  Result := FAmPmPosition;
end;
{------------------------------------------------------------------------------}
{ GetHourType                                                                  }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetHourType : TCrTimeFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FHourType;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {HourType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HOUR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHourType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHourType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_THT_NUMERIC_HOUR                  : FHourType := tfNumeric;
    PE_THT_NUMBERIC_HOUR_NO_LEADING_ZERO : FHourType := tfNoLeadingZero;
    PE_THT_NO_HOUR                       : FHourType := tfNone;
    else
      FHourType := tfNoLeadingZero;
  end;
  Result := FHourType;
end;
{------------------------------------------------------------------------------}
{ GetMinuteType                                                                }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetMinuteType : TCrTimeFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FMinuteType;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {MinuteType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MINUTE_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMinuteType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMinuteType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_TMT_NUMERIC_MINUTE                 : FMinuteType := tfNumeric;
    PE_TMT_NUMERIC_MINUTE_NO_LEADING_ZERO : FMinuteType := tfNoLeadingZero;
    PE_TMT_NO_MINUTE                      : FMinuteType := tfNone;
    else
      FMinuteType := tfNumeric;
  end;
  Result := FMinuteType;
end;
{------------------------------------------------------------------------------}
{ GetSecondType                                                                }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetSecondType : TCrTimeFormat;
var
  ValueInfo : PEValueInfo;
begin
  Result := FSecondType;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {SecondType}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SECOND_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSecondType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SECOND_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSecondType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_TST_NUMERIC_SECOND                 : FSecondType := tfNumeric;
    PE_TST_NUMERIC_SECOND_NO_LEADING_ZERO : FSecondType := tfNoLeadingZero;
    PE_TST_NUMERIC_NO_SECOND              : FSecondType := tfNone;
    else
      FSecondType := tfNumeric;
  end;
  Result := FSecondType;
end;
{------------------------------------------------------------------------------}
{ GetAMString                                                                  }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetAMString : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FAmString;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {AMString}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_AM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAMString <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_STRING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAMString <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FAMString := String(ValueInfo.viString);
  Result := FAMString;
end;
{------------------------------------------------------------------------------}
{ GetPMString                                                                  }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetPMString : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FPMString;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {PMString}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_PM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetPMString <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_PM_STRING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetPMString <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FPMString := String(ValueInfo.viString);
  Result := FPMString;
end;
{------------------------------------------------------------------------------}
{ GetHourMinSeparator                                                          }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetHourMinSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FHourMinSeparator;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {HourMinSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HOUR_MINUTE_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHourMinSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_MINUTE_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHourMinSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FHourMinSeparator := String(ValueInfo.viString);
  Result := FHourMinSeparator;
end;
{------------------------------------------------------------------------------}
{ GetMinSecSeparator                                                           }
{------------------------------------------------------------------------------}
function TCrpeTimeFormat.GetMinSecSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FMinSecSeparator;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;

  {MinSecSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MINUTE_SECOND_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMinSecSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_SECOND_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetMinSecSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FMinSecSeparator := String(ValueInfo.viString);
  Result := FMinSecSeparator;
end;
{------------------------------------------------------------------------------}
{ SetTimeBase                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetTimeBase (const Value: TCrTimeBase);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FTimeBase := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TIME_BASE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTimeBase <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TIME_BASE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTimeBase <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FTimeBase) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FTimeBase);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_TIME_BASE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTimeBase <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TIME_BASE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTimeBase <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetAmPmPosition                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetAmPmPosition (const Value: TCrAmPmPosition);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FAmPmPosition := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_AM_PM_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAmPmPosition <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_PM_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAmPmPosition <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FAmPmPosition) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FAmPmPosition);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_AM_PM_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAmPmPosition <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_PM_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAmPmPosition <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetHourType                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetHourType (const Value: TCrTimeFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FHourType := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HOUR_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHourType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHourType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FHourType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FHourType);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_HOUR_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHourType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHourType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetMinuteType                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetMinuteType (const Value: TCrTimeFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FMinuteType := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MINUTE_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMinuteType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMinuteType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FMinuteType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FMinuteType);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_MINUTE_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMinuteType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMinuteType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetSecondType                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetSecondType (const Value: TCrTimeFormat);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FSecondType := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SECOND_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSecondType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SECOND_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSecondType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FSecondType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FSecondType);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_SECOND_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSecondType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SECOND_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSecondType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetAMString                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetAMString (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FAMString := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_AM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAMString <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAMString <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FAMString) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FAMString));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_AM_STRING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAMString <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_AM_STRING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAMString <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetPMString                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetPMString (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FPMString := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_PM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetPMString <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_PM_STRING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetPMString <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FPMString) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FPMString));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_PM_STRING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetPMString <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_PM_STRING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetPMString <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetHourMinSeparator                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetHourMinSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FHourMinSeparator := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HOUR_MINUTE_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHourMinSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_MINUTE_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHourMinSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FHourMinSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FHourMinSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_HOUR_MINUTE_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHourMinSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HOUR_MINUTE_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHourMinSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetMinSecSeparator                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTimeFormat.SetMinSecSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FMinSecSeparator := Value;
  if FFieldType <> fvTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MINUTE_SECOND_SEPARATOR, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMinSecSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_SECOND_SEPARATOR,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMinSecSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FMinSecSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FMinSecSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_MINUTE_SECOND_SEPARATOR, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMinSecSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MINUTE_SECOND_SEPARATOR,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetMinSecSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeDateTimeFormat                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeDateTimeFormat.Create;
begin
  inherited Create;
  FOrder     := dtoDateTime;
  FSeparator := '';
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeDateTimeFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex     := -1;
    Handle     := 0;
    FOrder     := dtoDateTime;
    FSeparator := '';
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeDateTimeFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeDateTimeFormat then
  begin
    Order     := TCrpeDateTimeFormat(Source).Order;
    Separator := TCrpeDateTimeFormat(Source).Separator;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeDateTimeFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeDateTimeFormat.GetFormat;
begin
  GetOrder;
  GetSeparator;
end;
{------------------------------------------------------------------------------}
{ GetOrder                                                                     }
{------------------------------------------------------------------------------}
function TCrpeDateTimeFormat.GetOrder : TCrDateTimeOrder;
var
  ValueInfo : PEValueInfo;
begin
  Result := FOrder;
  if FFieldType <> fvDateTime then Exit;
  if not StatusIsGo then Exit;

  {DateTimeOrder}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_TIME_ORDER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetOrder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_ORDER, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetOrder <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_DTO_DATE_THEN_TIME : FOrder := dtoDateTime;
    PE_DTO_TIME_THEN_DATE : FOrder := dtoTimeDate;
    PE_DTO_DATE_ONLY      : FOrder := dtoDate;
    PE_DTO_TIME_ONLY      : FOrder := dtoTime;
    else
      FOrder := dtoDateTime;
  end;
  Result := FOrder;
end;
{------------------------------------------------------------------------------}
{ GetSeparator                                                                 }
{------------------------------------------------------------------------------}
function TCrpeDateTimeFormat.GetSeparator : string;
var
  ValueInfo : PEValueInfo;
begin
  Result := FSeparator;
  if FFieldType <> fvDateTime then Exit;
  if not StatusIsGo then Exit;

  {DateTimeSeparator}
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_TIME_SEPARATOR_STRING, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_SEPARATOR_STRING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSeparator <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSeparator := String(ValueInfo.viString);
  Result := FSeparator;
end;
{------------------------------------------------------------------------------}
{ SetOrder                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeDateTimeFormat.SetOrder (const Value: TCrDateTimeOrder);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FOrder := Value;
  if FFieldType <> fvDateTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_TIME_ORDER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetOrder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_ORDER,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetOrder <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FOrder) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FOrder);
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_TIME_ORDER, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetOrder <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_ORDER,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetOrder <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDateTimeSeparator                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeDateTimeFormat.SetSeparator (const Value: string);
var
  ValueInfo : PEValueInfo;
  s1        : string;
  Changed   : Boolean;
begin
  FSeparator := Value;
  if FFieldType <> fvDateTime then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DATE_TIME_SEPARATOR_STRING, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSeparator <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_SEPARATOR_STRING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSeparator <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  s1 := String(ValueInfo.viString);
  if CompareStr(s1, FSeparator) <> 0 then
    Changed := True;

  if Changed then
  begin
    StrCopy(ValueInfo.viString, PChar(FSeparator));
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DATE_TIME_SEPARATOR_STRING, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSeparator <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_DATE_TIME_SEPARATOR_STRING,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSeparator <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeParagraphFormat                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeParagraphFormat.Create;
begin
  inherited Create;
  FIndentFirstLine    := 0;  {are these integer..or?}
  FIndentLeft         := 0;
  FIndentRight        := 0;
  FTextInterpretation := tiNone;
  FLineSpacingType    := lsMultiple;
  FLineSpacing        := 1;  {N lines, can be fraction - 1.5, etc.}
  FCharacterSpacing   := 0;  {in points}
  FForEmbeddedField   := False;
  FForTextObject      := False;
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex              := -1;
    Handle              := 0;
    FIndentFirstLine    := 0;  {are these integer..or?}
    FIndentLeft         := 0;
    FIndentRight        := 0;
    FTextInterpretation := tiNone;
    FLineSpacingType    := lsMultiple;
    FLineSpacing        := 1;  {N lines, can be fraction - 1.5, etc.}
    FCharacterSpacing   := 0;  {in points}
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeParagraphFormat then
  begin
    IndentFirstLine    := TCrpeParagraphFormat(Source).IndentFirstLine;
    IndentLeft         := TCrpeParagraphFormat(Source).IndentLeft;
    IndentRight        := TCrpeParagraphFormat(Source).IndentRight;
    TextInterpretation := TCrpeParagraphFormat(Source).TextInterpretation;
    LineSpacingType    := TCrpeParagraphFormat(Source).LineSpacingType;
    LineSpacing        := TCrpeParagraphFormat(Source).LineSpacing;
    CharacterSpacing   := TCrpeParagraphFormat(Source).CharacterSpacing;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ SetFieldType                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetFieldType(FType: TCrFieldValueType);
begin
  FFieldType := FType;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.GetFormat;
begin
  GetIndentFirstLine;
  GetIndentLeft;
  GetIndentRight;
  GetTextInterpretation;
  GetLineSpacingType;
  GetLineSpacing;
  GetCharacterSpacing;
end;
{------------------------------------------------------------------------------}
{ GetIndentFirstLine                                                           }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetIndentFirstLine : integer;
var
  ValueInfo : PEValueInfo;
  TObjItem  : TCrpeTextObjectsItem;
begin
  Result := FIndentFirstLine;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  ValueInfo.valueType := PE_PF_INTEGER;

{ShowMessage: Cannot be retrieved..Print Engine error/bug}
  {FirstLineIndent}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_FIRST_LINE_INDENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetFirstLineIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin  if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentFirstLine;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_FIRST_LINE_INDENT,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetFirstLineIndent <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
  FIndentFirstLine := ValueInfo.viInteger;
  Result := FIndentFirstLine;
end;
{------------------------------------------------------------------------------}
{ SetIndentFirstLine                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetIndentFirstLine (const Value: integer);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
  TObjItem  : TCrpeTextObjectsItem;
begin
  FIndentFirstLine := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  TObjItem := nil;
  Changed := False;
  ValueInfo.valueType := PE_PF_INTEGER;

{ Cannot be retrieved - Print Engine bug }
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_FIRST_LINE_INDENT, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFirstLineIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin  if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentFirstLine;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_FIRST_LINE_INDENT,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetFirstLineIndent <PEGetObjectFormat>') of
          errIgnore : Changed := True;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> FIndentFirstLine then
    Changed := True;
  if Changed then
  begin
    ValueInfo.viInteger := FIndentFirstLine;
    if FForEmbeddedField then
    begin
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_FIRST_LINE_INDENT, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetFirstLineIndent <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if FForTextObject then
        TObjItem.Paragraphs[0].SetIndentFirstLine(ValueInfo.viInteger)
      else
      begin
        if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_FIRST_LINE_INDENT,
          ValueInfo) then
        begin
          case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
              TCrpe(Cx).BuildErrorString(Self) + 'SetFirstLineIndent <PESetObjectFormat>') of
            errIgnore : Exit;
            errAbort  : Abort;
            errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
          end;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetIndentLeft                                                                }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetIndentLeft : integer;
var
  ValueInfo : PEValueInfo;
  TObjItem  : TCrpeTextObjectsItem;
begin
  Result := FIndentLeft;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  ValueInfo.valueType := PE_PF_INTEGER;

{ShowMessage: Cannot be retrieved..Print Engine error/bug}
  {LeftIndent}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LEFT_INDENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLeftIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin  if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentLeft;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LEFT_INDENT,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetLeftIndent <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
  FIndentLeft := ValueInfo.viInteger;
  Result := FIndentLeft;
end;
{------------------------------------------------------------------------------}
{ SetIndentLeft                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetIndentLeft (const Value: integer);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
  TObjItem  : TCrpeTextObjectsItem;
begin
  FIndentLeft := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  TObjItem := nil;
  Changed := False;
  ValueInfo.valueType := PE_PF_INTEGER;

{ Cannot be retrieved - Print Engine bug }
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LEFT_INDENT, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeftIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin
      if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentLeft;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LEFT_INDENT,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeftIndent <PEGetObjectFormat>') of
          errIgnore : Changed := True;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> FIndentLeft then
    Changed := True;
  if Changed then
  begin
    ValueInfo.viInteger := FIndentLeft;
    if FForEmbeddedField then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_LEFT_INDENT, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeftIndent <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if FForTextObject then
        TObjItem.Paragraphs[0].SetIndentLeft(ValueInfo.viInteger)
      else
      begin
        if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LEFT_INDENT,
          ValueInfo) then
        begin
          case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
              TCrpe(Cx).BuildErrorString(Self) + 'SetLeftIndent <PESetObjectFormat>') of
            errIgnore : Exit;
            errAbort  : Abort;
            errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
          end;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetIndentRight                                                               }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetIndentRight : integer;
var
  ValueInfo : PEValueInfo;
  TObjItem  : TCrpeTextObjectsItem;
begin
  Result := FIndentRight;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  ValueInfo.valueType := PE_PF_INTEGER;

{ShowMessage: Cannot be retrieved..Print Engine error/bug}
  {RightIndent}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_RIGHT_INDENT, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRightIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin
      if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentRight;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_RIGHT_INDENT,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetRightIndent <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
  FIndentRight := ValueInfo.viInteger;
  Result := FIndentRight;
end;
{------------------------------------------------------------------------------}
{ SetIndentRight                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetIndentRight (const Value: integer);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
  TObjItem  : TCrpeTextObjectsItem;
begin
  FIndentRight := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  TObjItem := nil;
  Changed := False;
  ValueInfo.valueType := PE_PF_INTEGER;

{ Cannot be retrieved - Print Engine bug }
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_RIGHT_INDENT, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRightIndent <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if FForTextObject then
    begin
      if not (Parent.Parent is TCrpeTextObjectsItem) then Exit;
      TObjItem := TCrpeTextObjectsItem(Parent.Parent);
      if TObjItem.Paragraphs.Count = 0 then Exit;
      ValueInfo.viInteger := TObjItem.Paragraphs[0].IndentRight;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_RIGHT_INDENT,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRightIndent <PEGetObjectFormat>') of
          errIgnore : Changed := True;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> FIndentRight then
    Changed := True;
  if Changed then
  begin
    ValueInfo.viInteger := FIndentRight;
    if FForEmbeddedField then
    begin
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_RIGHT_INDENT, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRightIndent <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if FForTextObject then
      begin
        TObjItem.Paragraphs[0].SetIndentRight(ValueInfo.viInteger);
      end
      else
      begin
        if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_RIGHT_INDENT,
          ValueInfo) then
        begin
          case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
              TCrpe(Cx).BuildErrorString(Self) + 'SetRightIndent <PESetObjectFormat>') of
            errIgnore : Exit;
            errAbort  : Abort;
            errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
          end;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetTextInterpretation                                                        }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetTextInterpretation : TCrTextInterpretation;
var
  ValueInfo : PEValueInfo;
begin
  Result := FTextInterpretation;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if FForTextObject = True then Exit;
  if not StatusIsGo then Exit;

  {TextInterpretation}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TEXT_INTERPRETATION, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTextInterpretation <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_INTERPRETATION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTextInterpretation <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_TI_NONE : FTextInterpretation := tiNone;
    PE_TI_RTF  : FTextInterpretation := tiRTF;
    PE_TI_HTML : FTextInterpretation := tiHTML;
    else
      FTextInterpretation := tiNone;
  end;
  Result := FTextInterpretation;
end;
{------------------------------------------------------------------------------}
{ SetTextInterpretation                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetTextInterpretation (const Value: TCrTextInterpretation);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FTextInterpretation := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if FForTextObject = True then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TEXT_INTERPRETATION, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTextInterpretation <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_INTERPRETATION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTextInterpretation <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if ValueInfo.viInteger <> Ord(FTextInterpretation) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FTextInterpretation);
    if FForEmbeddedField then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_TEXT_INTERPRETATION, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTextInterpretation <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_INTERPRETATION,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTextInterpretation <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetLineSpacingType                                                           }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetLineSpacingType : TCrLineSpacingType;
var
  ValueInfo : PEValueInfo;
begin
  Result := FLineSpacingType;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;

  {LineSpacingType}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LINE_SPACING_TYPE, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLineSpacingType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING_TYPE,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLineSpacingType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FLineSpacingType := lsMultiple;
  case ValueInfo.viInteger of
    PE_LSPC_EXACT    : FLineSpacingType := lsExact;
    PE_LSPC_MULTIPLE : FLineSpacingType := lsMultiple;
  end;
  Result := FLineSpacingType;
end;
{------------------------------------------------------------------------------}
{ SetLineSpacingType                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetLineSpacingType (const Value: TCrLineSpacingType);
var
  ValueInfo    : PEValueInfo;
  iLineSpacing : Smallint;
  Changed      : Boolean;
begin
  FLineSpacingType := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LINE_SPACING_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacingType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacingType <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  iLineSpacing := PE_LSPC_MULTIPLE;
  case FLineSpacingType of
    lsMultiple : iLineSpacing := PE_LSPC_MULTIPLE;
    lsExact    : iLineSpacing := PE_LSPC_EXACT;
  end;
  if ValueInfo.viInteger <> iLineSpacing then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := iLineSpacing;
    if FForEmbeddedField then
    begin
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_LINE_SPACING_TYPE, ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacingType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING_TYPE,
        ValueInfo) then
      begin
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacingType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetLineSpacing                                                               }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetLineSpacing : double;
var
  ValueInfo : PEValueInfo;
begin
  Result := FLineSpacing;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;

  {LineSpacing}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LINE_SPACING, ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLineSpacing <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING,
      ValueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLineSpacing <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
{ShowMessage: bug when LineSpacingType is Exact: 65536 * FLineSpacing!
  Cannot set LineSpacing when Type is Exact either.  Therefore leaving Type to
  Exact will cause Page Overflow error}
  FLineSpacing := ValueInfo.viNumber;
  Result := FLineSpacing;
end;
{------------------------------------------------------------------------------}
{ SetLineSpacing                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetLineSpacing (const Value: double);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FLineSpacing := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LINE_SPACING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacing <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacing <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viNumber <> FLineSpacing then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viNumber := FLineSpacing;
    if FForEmbeddedField then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_LINE_SPACING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacing <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_LINE_SPACING,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLineSpacing <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCharacterSpacing                                                          }
{------------------------------------------------------------------------------}
function TCrpeParagraphFormat.GetCharacterSpacing : double;
var
  ValueInfo : PEValueInfo;
begin
  Result := FCharacterSpacing;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;

  {CharacterSpacing}
  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CHARACTER_SPACING, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCharacterSpacing <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CHARACTER_SPACING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCharacterSpacing <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FCharacterSpacing := TwipsToPoints(ValueInfo.viLong);
  Result := FCharacterSpacing;
end;
{------------------------------------------------------------------------------}
{ SetCharacterSpacing                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphFormat.SetCharacterSpacing (const Value: double);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FCharacterSpacing := Value;
  if not (FFieldType in [fvString..fvPersistentMemo]) then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if FForEmbeddedField then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_CHARACTER_SPACING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCharacterSpacing <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CHARACTER_SPACING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCharacterSpacing <PEGetObjectFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Compare}
  if CompareTwipsToPoints(ValueInfo.viLong, FCharacterSpacing) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viLong := PointsToTwips(FCharacterSpacing);
    if FForEmbeddedField then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_CHARACTER_SPACING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCharacterSpacing <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_CHARACTER_SPACING,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCharacterSpacing <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFieldFormatFormulas                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeFieldFormatFormulas.Create;
begin
  inherited Create;
  FName    := ffnFontColor;  {Set it to something that applies to all field types}
  FFormula := TStringList.Create;
  xFormula := TStringList.Create;
  TStringList(FFormula).OnChange := OnChangeStrings;
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpeFieldFormatFormulas.Destroy;
begin
  TStringList(FFormula).OnChange := nil;
  FFormula.Free;
  xFormula.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormatFormulas.Assign(Source: TPersistent);
begin
  if Source is TCrpeFieldFormatFormulas then
  begin
    case FFieldType of
      fvInt8s..fvCurrency :
        begin      {SuppressIfZero}
          Name := ffnSuppressIfZero;
          TCrpeFieldFormatFormulas(Source).Name := ffnSuppressIfZero;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {NegativeFormat}
          Name := ffnNegativeFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnNegativeFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {UseThousandsSeparators}
          Name := ffnUseThousandsSeparators;
          TCrpeFieldFormatFormulas(Source).Name := ffnUseThousandsSeparators;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {UseLeadingZero}
          Name := ffnUseLeadingZero;
          TCrpeFieldFormatFormulas(Source).Name := ffnUseLeadingZero;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DecimalPlaces}
          Name := ffnDecimalPlaces;
          TCrpeFieldFormatFormulas(Source).Name := ffnDecimalPlaces;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {RoundingFormat}
          Name := ffnRoundingFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnRoundingFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {CurrencySymbolFormat}
          Name := ffnCurrencySymbolFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnCurrencySymbolFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {OneCurrencySymbolPerPage}
          Name := ffnOneCurrencySymbolPerPage;
          TCrpeFieldFormatFormulas(Source).Name := ffnOneCurrencySymbolPerPage;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {CurrencySymbolPosition}
          Name := ffnCurrencySymbolPosition;
          TCrpeFieldFormatFormulas(Source).Name := ffnCurrencySymbolPosition;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {ThousandSymbol}
          Name := ffnThousandSymbol;
          TCrpeFieldFormatFormulas(Source).Name := ffnThousandSymbol;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DecimalSymbol}
          Name := ffnDecimalSymbol;
          TCrpeFieldFormatFormulas(Source).Name := ffnDecimalSymbol;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {CurrencySymbol}
          Name := ffnCurrencySymbol;
          TCrpeFieldFormatFormulas(Source).Name := ffnCurrencySymbol;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {ReverseSignForDisplay}
          Name := ffnReverseSignForDisplay;
          TCrpeFieldFormatFormulas(Source).Name := ffnReverseSignForDisplay;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
      fvBoolean :
        begin      {BooleanType}
          Name := ffnBooleanType;
          TCrpeFieldFormatFormulas(Source).Name := ffnBooleanType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
      fvDate :
        begin      {DateType}
          Name := ffnDateType;
          TCrpeFieldFormatFormulas(Source).Name := ffnDateType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DateOrder}
          Name := ffnDateOrder;
          TCrpeFieldFormatFormulas(Source).Name := ffnDateOrder;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {YearFormat}
          Name := ffnYearFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnYearFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {MonthFormat}
          Name := ffnMonthFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnMonthFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DayFormat}
          Name := ffnDayFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnDayFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {FirstDateSeparator}
          Name := ffnFirstDateSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnFirstDateSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {SecondDateSeparator}
          Name := ffnSecondDateSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnSecondDateSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DayOfWeekType}
          Name := ffnDayOfWeekType;
          TCrpeFieldFormatFormulas(Source).Name := ffnDayOfWeekType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DayOfWeekSeparator}
          Name := ffnDayOfWeekSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnDayOfWeekSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DayOfWeekPosition}
          Name := ffnDayOfWeekPosition;
          TCrpeFieldFormatFormulas(Source).Name := ffnDayOfWeekPosition;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DateEraFormat}
          Name := ffnDateEraFormat;
          TCrpeFieldFormatFormulas(Source).Name := ffnDateEraFormat;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {CalendarType}
          Name := ffnCalendarType;
          TCrpeFieldFormatFormulas(Source).Name := ffnCalendarType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {PrefixSeparator}
          Name := ffnPrefixSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnPrefixSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {SuffixSeparator}
          Name := ffnSuffixSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnSuffixSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DayOfWeekEnclosure}
          Name := ffnDayOfWeekEnclosure;
          TCrpeFieldFormatFormulas(Source).Name := ffnDayOfWeekEnclosure;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
      fvTime :
        begin      {TimeBase}
          Name := ffnTimeBase;
          TCrpeFieldFormatFormulas(Source).Name := ffnTimeBase;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {AmPmPosition}
          Name := ffnAmPmPosition;
          TCrpeFieldFormatFormulas(Source).Name := ffnAmPmPosition;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {HourType}
          Name := ffnHourType;
          TCrpeFieldFormatFormulas(Source).Name := ffnHourType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {MinuteType}
          Name := ffnMinuteType;
          TCrpeFieldFormatFormulas(Source).Name := ffnMinuteType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {SecondType}
          Name := ffnSecondType;
          TCrpeFieldFormatFormulas(Source).Name := ffnSecondType;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {HourMinSeparator}
          Name := ffnHourMinSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnHourMinSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {MinSecSeparator}
          Name := ffnMinSecSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnMinSecSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {AMString}
          Name := ffnAMString;
          TCrpeFieldFormatFormulas(Source).Name := ffnAMString;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {PMString}
          Name := ffnPMString;
          TCrpeFieldFormatFormulas(Source).Name := ffnPMString;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
      fvString :
        begin      {FirstLineIndent}
          Name := ffnFirstLineIndent;
          TCrpeFieldFormatFormulas(Source).Name := ffnFirstLineIndent;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {LeftIndent}
          Name := ffnLeftIndent;
          TCrpeFieldFormatFormulas(Source).Name := ffnLeftIndent;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {RightIndent}
          Name := ffnRightIndent;
          TCrpeFieldFormatFormulas(Source).Name := ffnRightIndent;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {TextInterpretation}
          Name := ffnTextInterpretation;
          TCrpeFieldFormatFormulas(Source).Name := ffnTextInterpretation;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
      fvDateTime :
        begin      {DateTimeOrder}
          Name := ffnDateTimeOrder;
          TCrpeFieldFormatFormulas(Source).Name := ffnDateTimeOrder;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
          {DateTimeSeparator}
          Name := ffnDateTimeSeparator;
          TCrpeFieldFormatFormulas(Source).Name := ffnDateTimeSeparator;
          Formula.Assign(TCrpeFieldFormatFormulas(Source).Formula);
        end;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormatFormulas.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex := -1;
    Handle := 0;
    FName  := ffnFontColor;
    FFormula.Clear;
    xFormula.Clear;
  end
  else
  begin
    xFormula.Clear;
    SetFormula(xFormula);
  end;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFieldFormatFormulas.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ OnChangeStrings                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormatFormulas.OnChangeStrings(Sender: TObject);
begin
  TStringList(FFormula).OnChange := nil;
  xFormula.Assign(FFormula);
  SetFormula(xFormula);
  TStringList(FFormula).OnChange := OnChangeStrings;
end;
{------------------------------------------------------------------------------}
{ GetFormula                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFieldFormatFormulas.GetFormula : TStrings;
var
  iName : Smallint;
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FFormula;
  if not StatusIsGo then Exit;

  iName := TCrpe(Cx).ConvertFormulaName(FName);
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, iName, hText, iText) then
    begin  TStringList(FFormula).OnChange := OnChangeStrings;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetFormula - ' +
             GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
            ' <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, iName, hText, iText) then
    begin  TStringList(FFormula).OnChange := OnChangeStrings;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetFormula - ' +
           GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
          ' <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FFormula.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FFormula;
end;
{------------------------------------------------------------------------------}
{ SetFormula                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormatFormulas.SetFormula (const Value: TStrings);
var
  iName : Smallint;
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  sVCL  : string;
  sRPT  : string;
begin
  FFormula.Assign(Value);
  if not StatusIsGo then Exit;

  iName := TCrpe(Cx).ConvertFormulaName(FName);
  if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, iName, hText, iText) then
    begin  TStringList(FFormula).OnChange := OnChangeStrings;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFormula - ' +
             GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
            ' <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, iName, hText, iText) then
    begin  TStringList(FFormula).OnChange := OnChangeStrings;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFormula - ' +
             GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
            ' <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FFormula);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, iName, PChar(sVCL)) then
      begin    TStringList(FFormula).OnChange := OnChangeStrings;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFormula - ' +
             GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
            ' <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, iName, PChar(sVCL)) then
      begin    TStringList(FFormula).OnChange := OnChangeStrings;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetFormula - ' +
             GetEnumName(TypeInfo(TCrFormatFormulaName), Ord(FName)) +
            ' <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetName                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormatFormulas.SetName (const Value: TCrFormatFormulaName);
begin
  FName := Value;
  if not StatusIsGo then Exit;
  GetFormula;
end;


{******************************************************************************}
{ Class TCrpeFieldFormat                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeFieldFormat.Create;
begin
  inherited Create;
  FUseSystemDefaultFormatting := True;
  FBooleanType := TrueFalse;
  {Number}
  FNumber := TCrpeNumberFormat.Create;
  FSubClassList.Add(FNumber);
  {Date}
  FDate := TCrpeDateFormat.Create;
  FSubClassList.Add(FDate);
  {Time}
  FTime := TCrpeTimeFormat.Create;
  FSubClassList.Add(FTime);
  {DateTime}
  FDateTime := TCrpeDateTimeFormat.Create;
  FSubClassList.Add(FDateTime);
  {Paragraph}
  FParagraph := TCrpeParagraphFormat.Create;
  FSubClassList.Add(FParagraph);
  {Formulas}
  FFormulas := TCrpeFieldFormatFormulas.Create;
  FSubClassList.Add(FFormulas);
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpeFieldFormat.Destroy;
begin
  FNumber.Free;
  FDate.Free;
  FTime.Free;
  FDateTime.Free;
  FParagraph.Free;
  FFormulas.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeFieldFormat then
  begin
    UseSystemDefaultFormatting := TCrpeFieldFormat(Source).UseSystemDefaultFormatting;
    {Boolean}
    if (TCrpeFieldFormat(Source).FieldType = fvBoolean) and
       (FFieldType = fvBoolean) then
      BooleanType := TCrpeFieldFormat(Source).BooleanType;
    {Number}
    if (TCrpeFieldFormat(Source).FieldType in [fvInt8s..fvCurrency]) and
       (FFieldType in [fvInt8s..fvCurrency]) then
      Number.Assign(TCrpeFieldFormat(Source).Number);
    {Date}
    if (TCrpeFieldFormat(Source).FieldType = fvDate) and
       (FFieldType = fvDate) then
      Date.Assign(TCrpeFieldFormat(Source).Date);
    {Time}
    if (TCrpeFieldFormat(Source).FieldType = fvTime) and
       (FFieldType = fvTime) then
      Time.Assign(TCrpeFieldFormat(Source).Time);
    {DateTime}
    if (TCrpeFieldFormat(Source).FieldType = fvDateTime) and
       (FFieldType = fvDateTime) then
      DateTime.Assign(TCrpeFieldFormat(Source).DateTime);
    {Paragraph}
    if (TCrpeFieldFormat(Source).FieldType in [fvTransientMemo..fvPersistentMemo]) and
       (FFieldType in [fvTransientMemo..fvPersistentMemo]) then
      Paragraph.Assign(TCrpeFieldFormat(Source).Paragraph);
    {Formulas}
    Formulas.Assign(TCrpeFieldFormat(Source).Formulas);
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex                      := -1;
    Handle                      := 0;
    FUseSystemDefaultFormatting := True;
    FBooleanType                := TrueFalse;
  end;
  FNumber.Clear;
  FDate.Clear;
  FTime.Clear;
  FDateTime.Clear;
  FParagraph.Clear;
  FFormulas.Clear;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFieldFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then
  begin
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ GetUseSystemDefaultFormatting                                                }
{------------------------------------------------------------------------------}
function TCrpeFieldFormat.GetUseSystemDefaultFormatting : Boolean;
var
  ValueInfo : PEValueInfo;
begin
  Result := FUseSystemDefaultFormatting;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseSystemDefaultFormatting <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetUseSystemDefaultFormatting <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FUseSystemDefaultFormatting := ValueInfo.viBoolean;
  Result := FUseSystemDefaultFormatting;
end;
{------------------------------------------------------------------------------}
{ SetUseSystemDefaultFormatting                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormat.SetUseSystemDefaultFormatting (const Value: Boolean);
var
  ValueInfo : PEValueInfo;
begin
  FUseSystemDefaultFormatting := Value;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseSystemDefaultFormatting <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : ValueInfo.viBoolean := not FUseSystemDefaultFormatting;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetUseSystemDefaultFormatting <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viBoolean <> Bool(FUseSystemDefaultFormatting) then
  begin
    ValueInfo.viBoolean := Bool(FUseSystemDefaultFormatting);
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseSystemDefaultFormatting <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_USE_SYSTEM_DEFAULT_FORMATTING,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetUseSystemDefaultFormatting <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetBooleanType                                                               }
{------------------------------------------------------------------------------}
function TCrpeFieldFormat.GetBooleanType : TCrBooleanType;
var
  ValueInfo : PEValueInfo;
begin
  Result := FBooleanType;
  if FFieldType <> fvBoolean then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BOOLEAN_OUPUT_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBooleanType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_BOOLEAN_OUPUT_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBooleanType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case ValueInfo.viInteger of
    PE_BOT_TRUE_OR_FALSE : FBooleanType := TrueFalse;
    PE_BOT_T_OR_F        : FBooleanType := TF;
    PE_BOT_YES_OR_NO     : FBooleanType := YesNo;
    PE_BOT_Y_OR_N        : FBooleanType := YN;
    PE_BOT_ONE_OR_ZERO   : FBooleanType := OneZero;
    else
      FBooleanType := TrueFalse;
  end;
  Result := FBooleanType;
end;
{------------------------------------------------------------------------------}
{ SetBooleanType                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFieldFormat.SetBooleanType (const Value: TCrBooleanType);
var
  ValueInfo : PEValueInfo;
  Changed   : Boolean;
begin
  FBooleanType := Value;
  if FFieldType <> fvBoolean then Exit;
  if not StatusIsGo then Exit;
  Changed := False;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BOOLEAN_OUPUT_TYPE, ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBooleanType <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Changed := True;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_BOOLEAN_OUPUT_TYPE,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBooleanType <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Compare}
  if ValueInfo.viInteger <> Ord(FBooleanType) then
    Changed := True;

  if Changed then
  begin
    ValueInfo.viInteger := Ord(FBooleanType);
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_BOOLEAN_OUPUT_TYPE, ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBooleanType <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_BOOLEAN_OUPUT_TYPE,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBooleanType <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFieldObjectItem                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeFieldObjectItem.Create;
begin
  inherited Create;
  FFieldName        := '';
  FFieldLength           := 0;
  FFormat           := TCrpeFieldObjectFormat.Create;
  FFont             := TCrpeFont.Create;
  FFont.OnChange    := OnChangeFont;
  FHiliteConditions := TCrpeHiliteConditions.Create;
  FSubClassList.Add(FFormat);
  FSubClassList.Add(FFont);
  FSubClassList.Add(FHiliteConditions);
  SetFieldType(fvUnknown);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFieldObjectItem.Destroy;
begin
  FFormat.Free;
  FFont.OnChange := nil;
  FFont.Free;
  FHiliteConditions.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.Assign(Source: TPersistent);
begin
  if Source is TCrpeFieldObjectItem then
  begin
    Format.Assign(TCrpeFieldObjectItem(Source).Format);
    Font.Assign(TCrpeFieldObjectItem(Source).Font);
    HiliteConditions.Assign(TCrpeFieldObjectItem(Source).HiliteConditions);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.Clear;
begin
  inherited Clear;
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) then
  begin
    FIndex       := -1;
    Handle       := 0;
    FFieldName   := '';
    SetFieldType(fvUnknown);
    FFieldLength := 0;
  end;
  FFormat.Clear;
  FFont.Clear;
  FHiliteConditions.Clear;
end;
{------------------------------------------------------------------------------}
{ SetFName                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.SetFName (const Value: string);
begin
  {Read only}
end;
{------------------------------------------------------------------------------}
{ SetFType                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.SetFType (const Value: TCrFieldValueType);
begin
  {Read only}
end;
{------------------------------------------------------------------------------}
{ SetFLength                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.SetFLength (const Value: Word);
begin
  {Read only}
end;
{------------------------------------------------------------------------------}
{ SetFieldType                                                                 }
{  - propagates the FieldType to subclasses                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.SetFieldType(const FType: TCrFieldValueType);
begin
  FFieldType := FType;
  FFormat.FField.FFieldType := FType;
  FFormat.FField.FNumber.FFieldType := FType;
  FFormat.FField.FDate.FFieldType := FType;
  FFormat.FField.FDateTime.FFieldType := FType;
  FFormat.FField.FTime.FFieldType := FType;
  FFormat.FField.FParagraph.FFieldType := FType;
  FHiliteConditions.FFieldType := FType;
end;
{------------------------------------------------------------------------------}
{ GetFont                                                                      }
{------------------------------------------------------------------------------}
function TCrpeFieldObjectItem.GetFont : TCrpeFont;
begin
  FFont.GetFont;
  Result := FFont;
end;
{------------------------------------------------------------------------------}
{ OnChangeFont                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectItem.OnChangeFont (Sender: TObject);
begin
  if StatusIsGo(FIndex) then
    FFont.SetFont;
end;


{******************************************************************************}
{ Class TCrpeFieldObjectContainer                                              }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Count                                                                        }
{------------------------------------------------------------------------------}
function TCrpeFieldObjectContainer.Count : integer;
begin
  Result := 0;
  if not Assigned(Cx) then Exit;
  if not TCrpe(Cx).StatusIsGo(0) then Exit;
  Result := TCrpe(Cx).GetNObjects(FObjectType, FFieldObjectType);
end;
{------------------------------------------------------------------------------}
{ SetIndex                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectContainer.SetIndex (nIndex: integer);
var
  objectInfo      : PEObjectInfo;
  fieldObjectInfo : PEFieldObjectInfo;
begin
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) or IsStrEmpty(TCrpe(Cx).ReportName) then
    Exit;
  if nIndex < 0 then
  begin
    PropagateIndex(-1);
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).OpenJob then Exit;

  Handle := TCrpe(Cx).GetObjectHandle(nIndex, FObjectType, FFieldObjectType);
  if Handle = 0 then
  begin
    case TCrpe(Cx).GetErrorMsg(0,errNoOption,errVCL,ECRPE_SUBSCRIPT,
       TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ')') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  PropagateHandle(Handle);
  {Object Info}
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectInfo(TCrpe(Cx).JobNumber, Handle, objectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' + IntToStr(nIndex) + ') <PEGetObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  PropagateIndex(nIndex);
  FItem.FLeft := objectInfo.xOffset;
  FItem.FTop := objectInfo.yOffset;
  FItem.FWidth := objectInfo.width;
  FItem.FHeight := objectInfo.height;
  FItem.FSection := TCrpe(Cx).SectionCodeToStringEx(objectInfo.sectionCode, False);

  {Field Object Info}
  
  if not TCrpe(Cx).CrpeEngine.PEGetFieldObjectInfo(TCrpe(Cx).JobNumber, Handle, fieldObjectInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errFormula,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetIndex(' +
        IntToStr(nIndex) + ') <PEGetFieldObjectInfo>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  FItem.FFieldName := String(fieldObjectInfo.fieldName);
  if fieldObjectInfo.valueType = PE_FVT_UNKNOWNFIELD then
    FItem.SetFieldType(fvUnknown)
  else
    FItem.SetFieldType(TCrFieldValueType(fieldObjectInfo.valueType));
  FItem.FFieldLength := fieldObjectInfo.nBytes;

  if csDesigning in TCrpe(Cx).ComponentState then
  begin
    FItem.FBorder.GetBorder;
    FItem.FFormat.FFieldType := FItem.FFieldType;
    FItem.FFormat.GetFormat;
    FItem.FFont.GetFont;
  end;
  {HiliteConditions}
  if FItem.FHiliteConditions.FIndex > (FItem.FHiliteConditions.Count-1) then
    FItem.FHiliteConditions.SetIndex(-1);
end;


{******************************************************************************}
{ Class TCrpeHiliteConditionsItem                                              }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeHiliteConditionsItem.Create;
begin
  inherited Create;
  FRangeCondition := hrcEqualTo;
  FStartValue     := 0;
  FEndValue       := 0;
  FFontColor      := clNone;
  FBackground     := clNone;
  FBorderStyle    := hbsDefault;
  FFontStyle      := hfsDefault;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.Assign(Source: TPersistent);
begin
  if Source is TCrpeHiliteConditionsItem then
  begin
    RangeCondition := TCrpeHiliteConditionsItem(Source).RangeCondition;
    StartValue     := TCrpeHiliteConditionsItem(Source).StartValue;
    EndValue       := TCrpeHiliteConditionsItem(Source).EndValue;
    FontColor      := TCrpeHiliteConditionsItem(Source).FontColor;
    Background     := TCrpeHiliteConditionsItem(Source).Background;
    BorderStyle    := TCrpeHiliteConditionsItem(Source).BorderStyle;
    FontStyle      := TCrpeHiliteConditionsItem(Source).FontStyle;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) then
  begin
    FIndex          := -1;
    Handle          := 0;
    FRangeCondition := hrcEqualTo;
    FStartValue     :=  0;
    FEndValue       :=  0;
    FFontColor      := clNone;
    FBackground     := clNone;
    FBorderStyle    := hbsDefault;
    FFontStyle      := hfsDefault;
  end;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditionsItem.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if csLoading in TCrpe(Cx).ComponentState then Exit;
  if Handle = 0 then Exit;
  if FIndex < 0 then Exit;
  if not TCrpe(Cx).OpenJob then Exit;
  if not (TCrpeHiliteConditions(Parent).FFieldType in [fvInt8s..fvCurrency]) then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ SetPriority                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetPriority (nIndex: Smallint);
begin
  if not StatusIsGo then Exit;
  
  if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteConditionPriority(TCrpe(Cx).JobNumber, Handle,
    FIndex, nIndex) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetPriority <PESetObjectNthHiliteConditionPriority>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetRangeCondition                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetRangeCondition (const Value: TCrHiliteRangeCondition);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  FRangeCondition := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetRangeCondition <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {RangeCondition}
  if HiliteInfo.rangeCondition <> Ord(FRangeCondition) then
  begin
    HiliteInfo.rangeCondition := Ord(FRangeCondition);
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetRangeCondition <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetStartValue                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetStartValue (const Value: Double);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  FStartValue := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetStartValue <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  {StartValue}
  if HiliteInfo.leftEndpoint <> FStartValue then
  begin
    HiliteInfo.leftEndpoint := FStartValue;
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetStartValue <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetEndValue                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetEndValue (const Value: Double);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  FEndValue := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetEndValue <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {EndValue}
  if HiliteInfo.rightEndpoint <> FEndValue then
  begin
    HiliteInfo.rightEndpoint := FEndValue;
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetEndValue <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetFontColor                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetFontColor (const Value: TColor);
var
  HiliteInfo : PEObjectHiliteInfo;
  nColor1    : TColor;
  nColor2    : TColor;
begin
  FFontColor := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetFontColor <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {FontColor}
  if HiliteInfo.fontColor = PE_NO_COLOR then
    nColor1 := clNone
  else
    nColor1 := TColor(HiliteInfo.fontColor);
  nColor2 := FFontColor;
  if nColor1 <> nColor2 then
  begin
    if nColor2 = clNone then
      HiliteInfo.fontColor := PE_NO_COLOR
    else
      HiliteInfo.fontColor := ColorToRGB(nColor2);
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetFontColor <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetBackground                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetBackground (const Value: TColor);
var
  HiliteInfo : PEObjectHiliteInfo;
  nColor1    : TColor;
  nColor2    : TColor;
begin
  FBackground := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetBackgroundColor <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {BackgroundColor}
  if HiliteInfo.bkColor = PE_NO_COLOR then
    nColor1 := clNone
  else
    nColor1 := TColor(HiliteInfo.bkColor);
  nColor2 := FBackground;
  if nColor1 <> nColor2 then
  begin
    if nColor2 = clNone then
      HiliteInfo.bkColor := PE_NO_COLOR
    else
      HiliteInfo.bkColor := ColorToRGB(nColor2);
    {Send to Print Engine}
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetBackgroundColor <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetBorderStyle                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetBorderStyle (const Value: TCrHiliteBorderStyle);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  FBorderStyle := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetBorderStyle <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {RangeCondition}
  if HiliteInfo.borderStyle <> Ord(FBorderStyle) then
  begin
    HiliteInfo.borderStyle := Ord(FBorderStyle);
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetBorderStyle <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetFontStyle                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsItem.SetFontStyle (const Value: TCrHiliteFontStyle);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  FFontStyle := Value;
  if not StatusIsGo then Exit;

  {Get Current Condition Info}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + '.SetFontStyle <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {RangeCondition}
  if HiliteInfo.fontStyle <> Ord(FFontStyle) then
  begin
    HiliteInfo.fontStyle := Ord(FFontStyle);
    {Send to Print Engine}
    if not TCrpe(Cx).CrpeEngine.PESetObjectNthHiliteCondition (TCrpe(Cx).JobNumber, Handle, FIndex, HiliteInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + '.SetFontStyle <PESetObjectNthHiliteCondition>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeHiliteConditions                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeHiliteConditions.Create;
begin
  inherited Create;
  FFieldType   := fvUnknown;
  FItem        := TCrpeHiliteConditionsItem.Create;
  FSubClassList.Add(FItem);
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpeHiliteConditions.Destroy;
begin
  FItem.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditions.Assign(Source: TPersistent);
var
  i : integer;
begin
  if Source is TCrpeHiliteConditions then
  begin
    Clear;
    for i := 0 to TCrpeHiliteConditions(Source).Count-1 do
    begin  Add;
      Item.Assign(TCrpeHiliteConditions(Source).Items[i]);
    end;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditions.Clear;
begin
  if not Assigned(Cx) then Exit;

  if IsStrEmpty(TCrpe(Cx).ReportName) or (FIndex < 0) or (Handle = 0) then
  begin
    FIndex := -1;
    Handle :=  0;
  end
  else
  begin
    if Count = 0 then Exit;
    
    if not TCrpe(Cx).CrpeEngine.PEClearObjectHiliteConditions(TCrpe(Cx).JobNumber, Handle) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          'HiliteConditions.Clear <PEClearObjectHiliteConditions>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FItem.Clear;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditions.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if csLoading in TCrpe(Cx).ComponentState then Exit;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).OpenJob then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ Count                                                                        }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditions.Count;
var
  nConditions : integer;
begin
  Result := 0;
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) then Exit;
  if not StatusIsGo then Exit;

  {Get the # of Sections in the Report}
  nConditions := TCrpe(Cx).CrpeEngine.PEGetObjectNHiliteConditions(TCrpe(Cx).JobNumber, Handle);
  if (nConditions = -1) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        'HiliteConditions.Count <PEGetObjectNHiliteConditions>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  Result := nConditions;
end;
{------------------------------------------------------------------------------}
{ Add                                                                          }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditions.Add : integer;
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  Result := -1;
  if not StatusIsGo then Exit;

  HiliteInfo.rangeCondition := PE_HE_RC_EQUALTO;
  HiliteInfo.leftEndpoint := 0;
  HiliteInfo.rightEndpoint := 0;
  HiliteInfo.fontColor := ColorToRGB(clBlack);
  HiliteInfo.bkColor := ColorToRGB(clWhite);
  HiliteInfo.borderStyle := PE_HE_BORDER_DEFAULTBORDERSTYLE;
  HiliteInfo.fontStyle := PE_HE_FONTSTYLE_DEFAULTFONTSTYLE;
  {Add the Condition}
  
  if not TCrpe(Cx).CrpeEngine.PEAddObjectHiliteCondition(TCrpe(Cx).JobNumber, Handle, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        'HiliteConditions.Add <PEAddObjectHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  SetIndex(Count-1);
  Result := FIndex;
end;
{------------------------------------------------------------------------------}
{ Delete                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditions.Delete (nIndex: integer);
begin
  if not StatusIsGo then Exit;

  {Remove the Condition}
  if not TCrpe(Cx).CrpeEngine.PERemoveObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, nIndex) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        'HiliteConditions.Delete <PERemoveObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  {Decrement index if necessary}
  if FIndex = Count then
    SetIndex(FIndex-1);
end;
{------------------------------------------------------------------------------}
{ SetIndex                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditions.SetIndex (nIndex: integer);
var
  HiliteInfo : PEObjectHiliteInfo;
begin
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) or IsStrEmpty(TCrpe(Cx).ReportName) then
    Exit;
  if nIndex < 0 then
  begin
    PropagateIndex(-1);
    Clear;
    Exit;
  end;
  if Handle = 0 then Exit;
  if not TCrpe(Cx).OpenJob then Exit;

  {Get Hilite Condition}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectNthHiliteCondition(TCrpe(Cx).JobNumber, Handle, nIndex, HiliteInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        'HiliteConditions.SetIndex <PEGetObjectNthHiliteCondition>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  PropagateIndex(nIndex);
  FItem.FRangeCondition := TCrHiliteRangeCondition(HiliteInfo.rangeCondition);
  FItem.FStartValue := HiliteInfo.leftEndpoint;
  FItem.FEndValue := HiliteInfo.rightEndpoint;
  {FontColor}
  if HiliteInfo.fontColor = PE_NO_COLOR then
    FItem.FFontColor := clNone
  else
    FItem.FFontColor := TColor(HiliteInfo.fontColor);
  {BackgroundColor}
  if HiliteInfo.bkColor = PE_NO_COLOR then
    FItem.FBackground := clNone
  else
    FItem.FBackground := TColor(HiliteInfo.bkColor);
  FItem.FBorderStyle := TCrHiliteBorderStyle(HiliteInfo.borderStyle);
  FItem.FFontStyle := TCrHiliteFontStyle(HiliteInfo.fontStyle);
end;
{------------------------------------------------------------------------------}
{ GetItem                                                                      }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditions.GetItem(nIndex: integer) : TCrpeHiliteConditionsItem;
begin
  SetIndex(nIndex);
  Result := FItem;
end;


{******************************************************************************}
{ Class TCrpeFont                                                              }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFont.Create;
begin
  inherited Create;
  FActualSize := 0;
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFont.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) then
    Handle := 0;
  Charset     := DEFAULT_CHARSET;
  Color       := clWindowText;
  Height      := -11;
  Name        := 'MS Sans Serif';
  Pitch       := fpDefault;
  Size        := 8;
  Style       := [];
  FActualSize := 0;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFont.Assign(Source: TPersistent);
begin
  if Source is TCrpeFont then
  begin
    ActualSize := TCrpeFont(Source).ActualSize;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ CopyFontInfo                                                                 }
{  - Copies font information from VCL's TCrpeFont to PEFontColorInfo           }
{------------------------------------------------------------------------------}
procedure TCrpeFont.CopyFontInfo(var FontInfo: PEFontColorInfo;
  VCLFont: TCrpeFont);
begin
  {Name}
  StrPCopy(FontInfo.faceName, VCLFont.Name);
  {Family - No equivalent in TFont}
  FontInfo.fontFamily := FF_DONTCARE;
  {Pitch}
  FontInfo.fontPitch := Ord(VCLFont.Pitch);
  {Charset - only applies in Delphi 3 and higher}
  FontInfo.charSet := VCLFont.Charset;
  {Size}
  FontInfo.pointSize := VCLFont.Size;
  {Style: Italic, Underline, StrikeOut, Bold(weight)}
  if fsItalic in VCLFont.Style then
    FontInfo.isItalic := 1
  else
    FontInfo.isItalic := 0;
  if fsUnderline in VCLFont.Style then
    FontInfo.isUnderlined := 1
  else
    FontInfo.isUnderlined := 0;
  if fsStrikeOut in VCLFont.Style then
    FontInfo.isStruckOut := 1
  else
    FontInfo.isStruckOut := 0;
  if fsBold in VCLFont.Style then
    FontInfo.weight := FW_BOLD
  else
    FontInfo.weight := FW_NORMAL;
  {Font Color}
  if VCLFont.Color = clNone then
    FontInfo.color := PE_NO_COLOR
  else
    FontInfo.color := ColorToRGB(VCLFont.Color);
  {TwipSize}
  FontInfo.twipSize := PointsToTwips(VCLFont.ActualSize);
end;
{------------------------------------------------------------------------------}
{ GetFont                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFont.GetFont;
var
  FontColorInfo : PEFontColorInfo;
begin
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
        '].Font.GetFont <PEGetObjectFontColor>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  {Name}
  Name := String(FontColorInfo.faceName);
  {Charset}
  Charset := FontColorInfo.charSet;
  {Font Color}
  if FontColorInfo.color = PE_NO_COLOR then
    Color := clNone
  else
    Color := TColor(FontColorInfo.color);
  {Pitch}
  Pitch := TFontPitch(FontColorInfo.fontPitch);
  {Size}
  Size := FontColorInfo.pointSize;
  {Style}
  Style := [];
  if FontColorInfo.isItalic <> 0 then
    Style := Style + [fsItalic];
  if FontColorInfo.isStruckOut <> 0 then
    Style := Style + [fsStrikeOut];
  if FontColorInfo.isUnderlined <> 0 then
    Style := Style + [fsUnderline];
  if FontColorInfo.weight > FW_NORMAL then
    Style := Style + [fsBold];
  {We ignore FontFamily}
  FActualSize := TwipsToPoints(FontColorInfo.twipSize);
end;
{------------------------------------------------------------------------------}
{ SetFont                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFont.SetFont;
var
  FontColorInfo : PEFontColorInfo;
begin
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
        '].Font.SetFont <PEGetObjectFontColor>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  if HasChanged(FontColorInfo) then
  begin
    CopyFontInfo(FontColorInfo, Self);
    if not TCrpe(Cx).CrpeEngine.PESetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
          '].Font.SetFont <PESetObjectFontColor>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetActualSize                                                                }
{------------------------------------------------------------------------------}
function TCrpeFont.GetActualSize: double;
var
  FontColorInfo : PEFontColorInfo;
begin
  Result := FActualSize;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
        '].Font.GetFont <PEGetObjectFontColor>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  FActualSize := TwipsToPoints(FontColorInfo.twipSize);
  Result := FActualSize;
end;
{------------------------------------------------------------------------------}
{ SetActualSize                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFont.SetActualSize (const Value: double);
var
  FontColorInfo : PEFontColorInfo;
begin
  FActualSize := Value;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
        '].Font.SetFont <PEGetObjectFontColor>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  if FontColorInfo.twipSize <> PointsToTwips(FActualSize) then
  begin
    FontColorInfo.twipSize := PointsToTwips(FActualSize);
    if FActualSize <> 0 then
      FontColorInfo.pointSize := Round(FActualSize);
    
    if not TCrpe(Cx).CrpeEngine.PESetObjectFontColor(TCrpe(Cx).JobNumber, Handle, FontColorInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Parent) + '[' + IntToStr(FIndex) +
          '].Font.SetFont <PESetObjectFontColor>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ Changed                                                                      }
{  - Compares Font info from Report and VCL to see if changed                  }
{------------------------------------------------------------------------------}
function TCrpeFont.HasChanged(RptFontInfo: PEFontColorInfo): Boolean;
var
  xColor : TColor;
  xStyle : TFontStyles;
begin
  Result := False;
  {Compare VCL and Rpt settings}
  {Name}
  if CompareText(Name, String(RptFontInfo.faceName)) <> 0 then
    Result := True;
  {CharSet}
  if Charset <> RptFontInfo.charSet then
    Result := True;
  {Color}
  if RptFontInfo.color = PE_NO_COLOR then
    xColor := clNone
  else
    xColor := TColor(RptFontInfo.color);
  if Color <> xColor then
    Result := True;
  {Pitch}
  if Pitch <> TFontPitch(RptFontInfo.fontPitch) then
    Result := True;
  {Size}
  if Size <> RptFontInfo.pointSize then
    {  Bug : ADAPT00158354 : "DatabaseFields.item.Font.Size : Size of the font do not change"
     following statement is commented out and one statement is added below - Shashikant,DishaTech - 21/4/03}
     // Result := True;
    begin   Result := True;
       self.ActualSize := Size;
    end;
    { Above statement is added to solve Bug : ADAPT00158354. Since it is necessary to
      keep FontColorInfo.twipSize and FontColorInfo.Pointsize in sync.  while
      setting fontsize using "PESetObjectFontColor" function. - Shashikant,DishaTech - 21/4/03}
  {Style}
  xStyle := [];
  if RptFontInfo.isItalic <> 0 then
    xStyle := xStyle + [fsItalic];
  if RptFontInfo.isStruckOut <> 0 then
    xStyle := xStyle + [fsStrikeOut];
  if RptFontInfo.isUnderlined <> 0 then
    xStyle := xStyle + [fsUnderline];
  if RptFontInfo.weight > FW_NORMAL then
    xStyle := xStyle + [fsBold];
  if Style <> xStyle then
    Result := True;
  {ActualSize}
  if FActualSize <> TwipsToPoints(RptFontInfo.twipSize) then
    Result := True;
end;


{******************************************************************************}
{ Class TCrpeBorderFormulas                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Constructor Create                                                           }
{------------------------------------------------------------------------------}
constructor TCrpeBorderFormulas.Create;
begin
  inherited Create;
  FLeft            := TStringList.Create;
  FRight           := TStringList.Create;
  FTop             := TStringList.Create;
  FBottom          := TStringList.Create;
  FTightHorizontal := TStringList.Create;
  FDropShadow      := TStringList.Create;
  FForeColor       := TStringList.Create;
  FBackgroundColor := TStringList.Create;
  xFormula         := TStringList.Create;
  {Set up OnChange event}
  TStringList(FLeft).OnChange := OnChangeLeft;
  TStringList(FRight).OnChange := OnChangeRight;
  TStringList(FTop).OnChange := OnChangeTop;
  TStringList(FBottom).OnChange := OnChangeBottom;
  TStringList(FTightHorizontal).OnChange := OnChangeTightHorizontal;
  TStringList(FDropShadow).OnChange := OnChangeDropShadow;
  TStringList(FForeColor).OnChange := OnChangeForeColor;
  TStringList(FBackgroundColor).OnChange := OnChangeBackgroundColor;
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpeBorderFormulas.Destroy;
begin
  {Set up OnChange event}
  TStringList(FLeft).OnChange := nil;
  TStringList(FRight).OnChange := nil;
  TStringList(FTop).OnChange := nil;
  TStringList(FBottom).OnChange := nil;
  TStringList(FTightHorizontal).OnChange := nil;
  TStringList(FDropShadow).OnChange := nil;
  TStringList(FForeColor).OnChange := nil;
  TStringList(FBackgroundColor).OnChange := nil;
  FLeft.Free;
  FRight.Free;
  FTop.Free;
  FBottom.Free;
  FTightHorizontal.Free;
  FDropShadow.Free;
  FForeColor.Free;
  FBackgroundColor.Free;
  xFormula.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.Assign(Source: TPersistent);
begin
  if Source is TCrpeBorderFormulas then
  begin
    Left.Assign(TCrpeBorderFormulas(Source).Left);
    Right.Assign(TCrpeBorderFormulas(Source).Right);
    Top.Assign(TCrpeBorderFormulas(Source).Top);
    Bottom.Assign(TCrpeBorderFormulas(Source).Bottom);
    TightHorizontal.Assign(TCrpeBorderFormulas(Source).TightHorizontal);
    DropShadow.Assign(TCrpeBorderFormulas(Source).DropShadow);
    ForeColor.Assign(TCrpeBorderFormulas(Source).ForeColor);
    BackgroundColor.Assign(TCrpeBorderFormulas(Source).BackgroundColor);
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) or (FIndex < 0) then
  begin
    Handle := 0;
    FIndex := -1;
    FLeft.Clear;
    FRight.Clear;
    FTop.Clear;
    FBottom.Clear;
    FTightHorizontal.Clear;
    FDropShadow.Clear;
    FForeColor.Clear;
    FBackgroundColor.Clear;
    xFormula.Clear;
  end
  else
  begin
    xFormula.Clear;
    SetLeft(xFormula);
    SetRight(xFormula);
    SetTop(xFormula);
    SetBottom(xFormula);
    SetTightHorizontal(xFormula);
    SetDropShadow(xFormula);
    SetForeColor(xFormula);
    SetBackgroundColor(xFormula);
  end;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if Handle = 0 then Exit;
  if FIndex < 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ OnChangeLeft                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeLeft (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetLeft(xFormula);
    TStringList(Sender).OnChange := OnChangeLeft;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeRight                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeRight (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetRight(xFormula);
    TStringList(Sender).OnChange := OnChangeRight;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeTop                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeTop (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetTop(xFormula);
    TStringList(Sender).OnChange := OnChangeTop;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeBottom                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeBottom (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetBottom(xFormula);
    TStringList(Sender).OnChange := OnChangeBottom;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeTightHorizontal                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeTightHorizontal (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetTightHorizontal(xFormula);
    TStringList(Sender).OnChange := OnChangeTightHorizontal;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeDropShadow                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeDropShadow (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetDropShadow(xFormula);
    TStringList(Sender).OnChange := OnChangeDropShadow;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeForeColor                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeForeColor (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetForeColor(xFormula);
    TStringList(Sender).OnChange := OnChangeForeColor;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeBackgroundColor                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.OnChangeBackgroundColor (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetBackgroundColor(xFormula);
    TStringList(Sender).OnChange := OnChangeBackgroundColor;
  end;
end;
{------------------------------------------------------------------------------}
{ GetLeft                                                                      }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetLeft : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FLeft;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleLeft}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_LEFT_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLeft <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_LEFT_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLeft <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FLeft.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FLeft;
end;
{------------------------------------------------------------------------------}
{ GetRight                                                                     }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetRight : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FRight;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleRight}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_RIGHT_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRight <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_RIGHT_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRight <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FRight.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FRight;
end;
{------------------------------------------------------------------------------}
{ GetTop                                                                       }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetTop : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FTop;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleTop}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TOP_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTop <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_TOP_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTop <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FTop.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FTop;
end;
{------------------------------------------------------------------------------}
{ GetBottom                                                                    }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetBottom : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FBottom;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleBottom}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_BOTTOM_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBottom <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_BOTTOM_LINE_STYLE, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBottom <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FBottom.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FBottom;
end;
{------------------------------------------------------------------------------}
{ GetTightHorizontal                                                           }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetTightHorizontal : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FTightHorizontal;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {TightHorizontal}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TIGHT_HORIZONTAL, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTightHorizontal <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_TIGHT_HORIZONTAL, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTightHorizontal <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FTightHorizontal.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FTightHorizontal;
end;
{------------------------------------------------------------------------------}
{ GetDropShadow                                                                }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetDropShadow : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FDropShadow;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {DropShadow}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_DROP_SHADOW, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDropShadow <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_DROP_SHADOW, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDropShadow <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FDropShadow.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FDropShadow;
end;
{------------------------------------------------------------------------------}
{ GetForeColor                                                                 }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetForeColor : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FForeColor;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {ForeColor}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_FORE_COLOR, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetForeColor <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_FORE_COLOR, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetForeColor <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FForeColor.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FForeColor;
end;
{------------------------------------------------------------------------------}
{ GetBackgroundColor                                                           }
{------------------------------------------------------------------------------}
function TCrpeBorderFormulas.GetBackgroundColor : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FBackgroundColor;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {BackgroundColor}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_BACK_COLOR, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBackgroundColor <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_BACK_COLOR, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBackgroundColor <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FBackgroundColor.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FBackgroundColor;
end;
{------------------------------------------------------------------------------}
{ SetRight                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetRight (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FRight.Assign(Value);
  if not Assigned(Cx) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_RIGHT_LINE_STYLE, hText, iText) then
    begin  TStringList(FRight).OnChange := OnChangeRight;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_RIGHT_LINE_STYLE, hText, iText) then
    begin  TStringList(FRight).OnChange := OnChangeRight;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FRight);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_RIGHT_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FRight).OnChange := OnChangeRight;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_RIGHT_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FRight).OnChange := OnChangeRight;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetLeft                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetLeft (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FLeft.Assign(Value);
  if not StatusIsGo then Exit;

  if Self.Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_LEFT_LINE_STYLE, hText, iText) then
    begin  TStringList(FLeft).OnChange := OnChangeLeft;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_LEFT_LINE_STYLE, hText, iText) then
    begin  TStringList(FLeft).OnChange := OnChangeLeft;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FLeft);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_LEFT_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FLeft).OnChange := OnChangeLeft;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_LEFT_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FLeft).OnChange := OnChangeLeft;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetTop                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetTop (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FTop.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TOP_LINE_STYLE, hText, iText) then
    begin  TStringList(FTop).OnChange := OnChangeTop;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_TOP_LINE_STYLE, hText, iText) then
    begin  TStringList(FTop).OnChange := OnChangeTop;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FTop);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_TOP_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FTop).OnChange := OnChangeTop;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_TOP_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FTop).OnChange := OnChangeTop;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetBottom                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetBottom (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FBottom.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_BOTTOM_LINE_STYLE, hText, iText) then
    begin  TStringList(FBottom).OnChange := OnChangeBottom;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_BOTTOM_LINE_STYLE, hText, iText) then
    begin  TStringList(FBottom).OnChange := OnChangeBottom;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FBottom);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_BOTTOM_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FBottom).OnChange := OnChangeBottom;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_BOTTOM_LINE_STYLE, PChar(sVCL)) then
      begin    TStringList(FBottom).OnChange := OnChangeBottom;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetTightHorizontal                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetTightHorizontal (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FTightHorizontal.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TIGHT_HORIZONTAL, hText, iText) then
    begin  TStringList(FTightHorizontal).OnChange := OnChangeTightHorizontal;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_TIGHT_HORIZONTAL, hText, iText) then
    begin  TStringList(FTightHorizontal).OnChange := OnChangeTightHorizontal;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FTightHorizontal);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_TIGHT_HORIZONTAL, PChar(sVCL)) then
      begin    TStringList(FTightHorizontal).OnChange := OnChangeTightHorizontal;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_TIGHT_HORIZONTAL, PChar(sVCL)) then
      begin    TStringList(FTightHorizontal).OnChange := OnChangeTightHorizontal;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetDropShadow                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetDropShadow (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FDropShadow.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_DROP_SHADOW, hText, iText) then
    begin  TStringList(FDropShadow).OnChange := OnChangeDropShadow;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle, PE_FFN_DROP_SHADOW, hText, iText) then
    begin  TStringList(FDropShadow).OnChange := OnChangeDropShadow;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FDropShadow);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_DROP_SHADOW, PChar(sVCL)) then
      begin    TStringList(FDropShadow).OnChange := OnChangeDropShadow;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
        PE_FFN_DROP_SHADOW, PChar(sVCL)) then
      begin    TStringList(FDropShadow).OnChange := OnChangeDropShadow;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetForeColor                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetForeColor (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FForeColor.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_FORE_COLOR, hText, iText) then
    begin  TStringList(FForeColor).OnChange := OnChangeForeColor;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle, PE_FFN_FORE_COLOR, hText, iText) then
    begin  TStringList(FForeColor).OnChange := OnChangeForeColor;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FForeColor);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_FORE_COLOR, PChar(sVCL)) then
      begin    TStringList(FForeColor).OnChange := OnChangeForeColor;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle, PE_FFN_FORE_COLOR, PChar(sVCL)) then
      begin    TStringList(FForeColor).OnChange := OnChangeForeColor;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetBackgroundColor                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorderFormulas.SetBackgroundColor (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FBackgroundColor.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Get FormatFormula}
  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_BACK_COLOR, hText, iText) then
    begin  TStringList(FRight).OnChange := OnChangeRight;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
      PE_FFN_BACK_COLOR, hText, iText) then
    begin  TStringList(FBackgroundColor).OnChange := OnChangeBackgroundColor;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FBackgroundColor);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_BACK_COLOR, PChar(sVCL)) then
      begin    TStringList(FBackgroundColor).OnChange := OnChangeBackgroundColor;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle, PE_FFN_BACK_COLOR, PChar(sVCL)) then
      begin    TStringList(FBackgroundColor).OnChange := OnChangeBackgroundColor;
        case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeBorder                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeBorder.Create;
begin
  inherited Create;
  FLeft            := lsNone;
  FRight           := lsNone;
  FTop             := lsNone;
  FBottom          := lsNone;
  FTightHorizontal := False;
  FDropShadow      := False;
  FForeColor       := clNone;
  FBackgroundColor := clNone;
  FFormulas        := TCrpeBorderFormulas.Create;
  FSubClassList.Add(FFormulas);
  FFieldN          := -1;
end;
{------------------------------------------------------------------------------}
{ Destructor Destroy                                                           }
{------------------------------------------------------------------------------}
destructor TCrpeBorder.Destroy;
begin
  FFormulas.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.Assign(Source: TPersistent);
begin
  if Source is TCrpeBorder then
  begin
    Left            := TCrpeBorder(Source).Left;
    Right           := TCrpeBorder(Source).Right;
    Top             := TCrpeBorder(Source).Top;
    Bottom          := TCrpeBorder(Source).Bottom;
    TightHorizontal := TCrpeBorder(Source).TightHorizontal;
    DropShadow      := TCrpeBorder(Source).DropShadow;
    ForeColor       := TCrpeBorder(Source).ForeColor;
    BackgroundColor := TCrpeBorder(Source).BackgroundColor;
    Formulas.Assign(TCrpeBorder(Source).Formulas);
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) then
  begin
    Handle           := 0;
    FLeft            := lsNone;
    FRight           := lsNone;
    FTop             := lsNone;
    FBottom          := lsNone;
    FTightHorizontal := False;
    FDropShadow      := False;
    FForeColor       := clNone;
    FBackgroundColor := clNone;
  end
  else
  begin
    SetLeft(lsNone);
    SetRight(lsNone);
    SetTop(lsNone);
    SetBottom(lsNone);
    SetTightHorizontal(False);
    SetDropShadow(False);
    SetForeColor(clNone);
    SetBackgroundColor(clNone);
  end;
  FFormulas.Clear;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeBorder.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then
  begin
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ SetFNum                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetFNum(nField: Smallint);
begin
  FFieldN := nField;
  FFormulas.FFieldN := nField;
end;
{------------------------------------------------------------------------------}
{ GetBorder                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.GetBorder;
begin
  GetLeft;
  GetLeft;
  GetRight;
  GetTop;
  GetBottom;
  GetTightHorizontal;
  GetDropShadow;
  GetForeColor;
  GetBackgroundColor;
end;
{------------------------------------------------------------------------------}
{ GetLeft                                                                      }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetLeft : TCrLineStyle;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FLeft;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleLeft}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LEFT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLeft <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_LEFT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetLeft <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case valueInfo.viInteger of
    PE_LS_NO_LINE     : FLeft := lsNone;
    PE_LS_SINGLE_LINE : FLeft := lsSingle;
    PE_LS_DOUBLE_LINE : FLeft := lsDouble;
    PE_LS_DASH_LINE   : FLeft := lsDash;
    PE_LS_DOT_LINE    : FLeft := lsDot;
    else
      FLeft := lsNone;
  end;
end;
{------------------------------------------------------------------------------}
{ SetLeft                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetLeft (const Value: TCrLineStyle);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FLeft := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Left}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_LEFT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_LEFT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viInteger <> Ord(FLeft) then
  begin
    valueInfo.viInteger := Ord(FLeft);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_LEFT_LINE_STYLE, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_LEFT_LINE_STYLE,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetLeft <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetRight                                                                     }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetRight : TCrLineStyle;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FRight;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleRight}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_RIGHT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRight <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_RIGHT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetRight <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case valueInfo.viInteger of
    PE_LS_NO_LINE     : FRight := lsNone;
    PE_LS_SINGLE_LINE : FRight := lsSingle;
    PE_LS_DOUBLE_LINE : FRight := lsDouble;
    PE_LS_DASH_LINE   : FRight := lsDash;
    PE_LS_DOT_LINE    : FRight := lsDot;
    else
      FRight := lsNone;
  end;
end;
{------------------------------------------------------------------------------}
{ SetRight                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetRight (const Value: TCrLineStyle);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FRight := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Right}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_RIGHT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_RIGHT_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viInteger <> Ord(FRight) then
  begin
    valueInfo.viInteger := Ord(FRight);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_RIGHT_LINE_STYLE, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_RIGHT_LINE_STYLE,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetRight <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetTop                                                                       }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetTop : TCrLineStyle;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FTop;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleTop}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TOP_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTop <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_TOP_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTop <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case valueInfo.viInteger of
    PE_LS_NO_LINE     : FTop := lsNone;
    PE_LS_SINGLE_LINE : FTop := lsSingle;
    PE_LS_DOUBLE_LINE : FTop := lsDouble;
    PE_LS_DASH_LINE   : FTop := lsDash;
    PE_LS_DOT_LINE    : FTop := lsDot;
    else
      FTop := lsNone;
  end;
end;
{------------------------------------------------------------------------------}
{ SetTop                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetTop (const Value: TCrLineStyle);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FTop := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Top}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TOP_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_TOP_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viInteger <> Ord(FTop) then
  begin
    valueInfo.viInteger := Ord(FTop);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_TOP_LINE_STYLE, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_TOP_LINE_STYLE,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTop <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetBottom                                                                    }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetBottom : TCrLineStyle;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FBottom;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {LineStyleBottom}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BOTTOM_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBottom <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_BOTTOM_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBottom <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case valueInfo.viInteger of
    PE_LS_NO_LINE     : FBottom := lsNone;
    PE_LS_SINGLE_LINE : FBottom := lsSingle;
    PE_LS_DOUBLE_LINE : FBottom := lsDouble;
    PE_LS_DASH_LINE   : FBottom := lsDash;
    PE_LS_DOT_LINE    : FBottom := lsDot;
    else
      FBottom := lsNone;
  end;
end;
{------------------------------------------------------------------------------}
{ SetBottom                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetBottom (const Value: TCrLineStyle);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FBottom := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Bottom}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BOTTOM_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_BOTTOM_LINE_STYLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viInteger <> Ord(FBottom) then
  begin
    valueInfo.viInteger := Ord(FBottom);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_BOTTOM_LINE_STYLE, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_BOTTOM_LINE_STYLE,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBottom <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetTightHorizontal                                                           }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetTightHorizontal : Boolean;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FTightHorizontal;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {TightHorizontal}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TIGHT_HORIZONTAL, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTightHorizontal <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_TIGHT_HORIZONTAL, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTightHorizontal <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viBoolean = True then
    FTightHorizontal := True
  else
    FTightHorizontal := False;
end;
{------------------------------------------------------------------------------}
{ SetTightHorizontal                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetTightHorizontal (const Value: Boolean);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FTightHorizontal := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Tight Horizontal}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TIGHT_HORIZONTAL, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_TIGHT_HORIZONTAL, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viBoolean <> Bool(FTightHorizontal) then
  begin
    valueInfo.viBoolean := Bool(FTightHorizontal);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_TIGHT_HORIZONTAL, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_TIGHT_HORIZONTAL,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetTightHorizontal <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetDropShadow                                                                }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetDropShadow : Boolean;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FDropShadow;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {DropShadow}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DROP_SHADOW, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDropShadow <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_DROP_SHADOW, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetDropShadow <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viBoolean = True then
    FDropShadow := True
  else
    FDropShadow := False;
end;
{------------------------------------------------------------------------------}
{ SetDropShadow                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetDropShadow (const Value: Boolean);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FDropShadow := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Drop Shadow}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_DROP_SHADOW, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_DROP_SHADOW, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viBoolean <> Bool(FDropShadow) then
  begin
    valueInfo.viBoolean := Bool(FDropShadow);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_DROP_SHADOW, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetDropShadow <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_DROP_SHADOW, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self)  + 'SetDropShadow <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetForeColor                                                                 }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetForeColor : TColor;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FForeColor;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {ForeColor}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_FORE_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetForeColor <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_FORE_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetForeColor <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viColor = PE_NO_COLOR then
    FForeColor := clNone
  else
    FForeColor := TColor(ValueInfo.viColor);
end;
{------------------------------------------------------------------------------}
{ SetForeColor                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetForeColor (const Value: TColor);
var
  valueInfo : PEValueInfo;
  nColor1   : TColor;
  nColor2   : TColor;
  xJob      : Smallint;
begin
  FForeColor := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {ForeColor}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_FORE_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_FORE_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viColor = PE_NO_COLOR then
    nColor1 := clNone
  else
    nColor1 := TColor(ValueInfo.viColor);
  nColor2 := FForeColor;
  if nColor1 <> nColor2 then
  begin
    if nColor2 = clNone then
      valueInfo.viColor := PE_NO_COLOR
    else
      valueInfo.viColor := ColorToRGB(nColor2);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_FORE_COLOR, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_FORE_COLOR,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetForeColor <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetBackgroundColor                                                           }
{------------------------------------------------------------------------------}
function TCrpeBorder.GetBackgroundColor : TColor;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FBackgroundColor;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {BackgroundColor}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BACK_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBackgroundColor <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_BACK_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetBackgroundColor <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viColor = PE_NO_COLOR then
    FBackgroundColor := clNone
  else
    FBackgroundColor := TColor(ValueInfo.viColor);
end;
{------------------------------------------------------------------------------}
{ SetBackgroundColor                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorder.SetBackgroundColor (const Value: TColor);
var
  valueInfo : PEValueInfo;
  nColor1   : TColor;
  nColor2   : TColor;
  xJob      : Smallint;
begin
  FBackgroundColor := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Background Color}
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_BACK_COLOR, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_BACK_COLOR,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  if valueInfo.viColor = PE_NO_COLOR then
    nColor1 := clNone
  else
    nColor1 := TColor(valueInfo.viColor);
  nColor2 := FBackgroundColor;
  if nColor1 <> nColor2 then
  begin
    if nColor2 = clNone then
      valueInfo.viColor := PE_NO_COLOR
    else
      valueInfo.viColor := ColorToRGB(nColor2);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_BACK_COLOR, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_BACK_COLOR,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetBackgroundColor <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFormat                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormat.Create;
begin
  inherited Create;
  FSuppress     := False;
  FKeepTogether := True;
  FCloseBorder  := True;
  FToolTip      := '';
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormat then
  begin
    Suppress     := TCrpeFormat(Source).Suppress;
    KeepTogether := TCrpeFormat(Source).KeepTogether;
    CloseBorder  := TCrpeFormat(Source).CloseBorder;
    ToolTip      := TCrpeFormat(Source).ToolTip;
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormat.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) then
  begin
    Handle        := 0;
    FSuppress     := False;
    FKeepTogether := True;
    FCloseBorder  := True;
    FToolTip      := '';
  end
  else
  begin
    SetSuppress(False);
    SetKeepTogether(True);
    SetCloseBorder(True);
    SetToolTip('');
  end;
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormat.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if FIndex < 0 then Exit;
  if Handle = 0 then
  begin
    PropagateHandle(0);
    Exit;
  end;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;


{******************************************************************************}
{ Class TCrpeFormatA                                                           }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatA.Create;
begin
  inherited Create;
  FFormulas     := TCrpeFormatFormulasA.Create;
  FSubClassList.Add(FFormulas);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatA.Destroy;
begin
  FFormulas.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormatA then
  begin
    Formulas.Assign(TCrpeFormatA(Source).Formulas);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.Clear;
begin
  if not Assigned(Cx) then Exit;
  inherited Clear;
  FFormulas.Clear;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.GetFormat;
begin
  GetSuppress;
  GetKeepTogether;
  GetCloseBorder;
  GetToolTip;
end;
{------------------------------------------------------------------------------}
{ GetSuppress                                                                  }
{------------------------------------------------------------------------------}
function TCrpeFormatA.GetSuppress : Boolean;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FSuppress;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Suppress}
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_VISIBLE, valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  FSuppress := False;
  if valueInfo.viBoolean = False then
    FSuppress := True;
  Result := FSuppress;
end;
{------------------------------------------------------------------------------}
{ SetSuppress                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.SetSuppress (const Value: Boolean);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FSuppress := Value;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {Suppress}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_VISIBLE, valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  if FSuppress = True then
    valueInfo.viBoolean := False;
  if FSuppress = False then
    valueInfo.viBoolean := True;

  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_VISIBLE, valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetKeepTogether                                                              }
{------------------------------------------------------------------------------}
function TCrpeFormatA.GetKeepTogether : Boolean;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FKeepTogether;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {KeepTogether}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_KEEP_OBJECT_TOGETHER, valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  FKeepTogether := True;
  if valueInfo.viBoolean = False then
    FKeepTogether := False;
  Result := FKeepTogether;
end;
{------------------------------------------------------------------------------}
{ GetCloseBorder                                                               }
{------------------------------------------------------------------------------}
function TCrpeFormatA.GetCloseBorder : Boolean;
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  Result := FCloseBorder;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {CloseBorder}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_SPLIT_ADORNMENT, valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
  FCloseBorder := True;
  if valueInfo.viBoolean = True then
    FCloseBorder := False;
  Result := FCloseBorder;
end;
{------------------------------------------------------------------------------}
{ GetToolTip                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormatA.GetToolTip : string;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FToolTip;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {FormatFormula: ToolTip}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_TOOL_TIP_TEXT, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetToolTip <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FToolTip := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FToolTip;
end;
{------------------------------------------------------------------------------}
{ SetKeepTogether                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.SetKeepTogether (const Value: Boolean);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FKeepTogether := Value;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {KeepTogether}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_KEEP_OBJECT_TOGETHER,
    valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  valueInfo.viBoolean := Bool(FKeepTogether);
  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_KEEP_OBJECT_TOGETHER,
    valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetCloseBorder                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.SetCloseBorder (const Value: Boolean);
var
  valueInfo : PEValueInfo;
  xJob      : Smallint;
begin
  FCloseBorder := Value;
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {CloseBorder}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(xJob, Handle, PE_OFN_SPLIT_ADORNMENT,
    valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {The VCL and Print Engine properties have opposite meaning...}
  valueInfo.viBoolean := not (Bool(FCloseBorder));

  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(xJob, Handle, PE_OFN_SPLIT_ADORNMENT,
    valueInfo) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetObjectFormat>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ SetToolTip                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatA.SetToolTip (const Value: string);
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  sText : String;
  xJob  : Smallint;
begin
  if IsQuoted(Value) then
    FToolTip := Value
  else
    FTooltip := QuotedStr(Value);
  if Handle = 0 then Exit;
  if not Assigned(Cx) then Exit;

  if Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  {FormatFormula: ToolTip}
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_TOOL_TIP_TEXT, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sText := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle, PE_FFN_TOOL_TIP_TEXT,
    PChar(FToolTip)) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PESetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFormatB                                                           }
{  - TextObjects, Subreports                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatB.Create;
begin
  inherited Create;
  {Internal}
  FFieldN               := -1;
  {Format}
  FAlignment            := haDefault;
  FCanGrow              := False;
  FMaxNLines            := 0;
  FTextRotation         := trZero;
  FSuppressIfDuplicated := False;
  FFormulas             := TCrpeFormatFormulasB.Create;
  FSubClassList.Add(FFormulas);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatB.Destroy;
begin
  FFormulas.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormatB then
  begin
    Alignment            := TCrpeFormatB(Source).Alignment;
    CanGrow              := TCrpeFormatB(Source).CanGrow;
    MaxNLines            := TCrpeFormatB(Source).MaxNLines;
    TextRotation         := TCrpeFormatB(Source).TextRotation;
    SuppressIfDuplicated := TCrpeFormatB(Source).SuppressIfDuplicated;
    Formulas.Assign(TCrpeFormatB(Source).Formulas);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.Clear;
begin
  if not Assigned(Cx) then Exit;
  inherited Clear;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) then
  begin
    FFieldN               := -1;
    FAlignment            := haDefault;
    FSuppressIfDuplicated := False;
    FCanGrow              := False;
    FMaxNLines            := 0;
    FTextRotation         := trZero;
  end
  else
  begin
    SetAlignment(haDefault);
    SetSuppressIfDuplicated(False);
    SetCanGrow(False);
    SetMaxNLines(0);
    SetTextRotation(trZero);
  end;
  FFormulas.Clear;
end;
{------------------------------------------------------------------------------}
{ SetFieldType                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetFieldType(FType: TCrFieldValueType);
begin
  FFieldType := FType;
end;
{------------------------------------------------------------------------------}
{ GetFormat                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.GetFormat;
begin
  GetSuppress;
  GetKeepTogether;
  GetCloseBorder;
  GetToolTip;
  GetAlignment;
  GetCanGrow;
  GetMaxNLines;
  GetTextRotation;
  GetSuppressIfDuplicated;
end;
{------------------------------------------------------------------------------}
{ GetSuppress                                                                  }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetSuppress : Boolean;
var
  valueInfo : PEValueInfo;
begin
  Result := FSuppress;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_VISIBLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_VISIBLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSuppress := False;
  if valueInfo.viBoolean = False then
    FSuppress := True;
  Result := FSuppress;
end;
{------------------------------------------------------------------------------}
{ SetSuppress                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetSuppress (const Value: Boolean);
var
  valueInfo : PEValueInfo;
begin
  FSuppress := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_VISIBLE, valueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_VISIBLE, valueInfo) then
    begin
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  if FSuppress = True then
    valueInfo.viBoolean := Bool(False)
  else
    valueInfo.viBoolean := Bool(True);

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_VISIBLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_VISIBLE, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetKeepTogether                                                              }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetKeepTogether : Boolean;
var
  valueInfo : PEValueInfo;
begin
  Result := FKeepTogether;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_KEEP_OBJECT_TOGETHER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetKeepTogether <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_KEEP_OBJECT_TOGETHER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetKeepTogether <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FKeepTogether := True;
  if valueInfo.viBoolean = False then
    FKeepTogether := False;
  Result := FKeepTogether;
end;
{------------------------------------------------------------------------------}
{ SetKeepTogether                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetKeepTogether (const Value: Boolean);
var
  valueInfo : PEValueInfo;
begin
  FKeepTogether := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_KEEP_OBJECT_TOGETHER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_KEEP_OBJECT_TOGETHER,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;


  valueInfo.viBoolean := Bool(FKeepTogether);
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_KEEP_OBJECT_TOGETHER, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_KEEP_OBJECT_TOGETHER,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCloseBorder                                                               }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetCloseBorder : Boolean;
var
  valueInfo : PEValueInfo;
begin
  Result := FCloseBorder;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SPLIT_ADORNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SPLIT_ADORNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FCloseBorder := True;
  {if Split Adornment is True, CloseBorder is False}
  if valueInfo.viBoolean = True then
    FCloseBorder := False;
  Result := FCloseBorder;
end;
{------------------------------------------------------------------------------}
{ SetCloseBorder                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetCloseBorder (const Value: Boolean);
var
  valueInfo : PEValueInfo;
begin
  FCloseBorder := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SPLIT_ADORNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SPLIT_ADORNMENT,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  valueInfo.viBoolean := not Bool(FCloseBorder);
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SPLIT_ADORNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SPLIT_ADORNMENT,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetToolTip                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetToolTip : string;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FToolTip;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TOOL_TIP_TEXT, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetToolTip <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_TOOL_TIP_TEXT, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetToolTip <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FToolTip := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FToolTip;
end;
{------------------------------------------------------------------------------}
{ SetToolTip                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetToolTip (const Value: string);
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  sText : String;
begin
  if IsQuoted(Value) then
    FToolTip := Value
  else
    FTooltip := QuotedStr(Value);
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TOOL_TIP_TEXT, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_TOOL_TIP_TEXT, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sText := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_TOOL_TIP_TEXT, PChar(FToolTip)) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PESetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, PE_FFN_TOOL_TIP_TEXT,
      PChar(FToolTip)) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetToolTip <PESetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetAlignment                                                                 }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetAlignment : TCrHorizontalAlignment;
var
  valueInfo : PEValueInfo;
begin
  Result := FAlignment;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HORALIGNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAlignment <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HORALIGNMENT,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAlignment <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FAlignment := TCrHorizontalAlignment(valueInfo.viInteger);
  Result := FAlignment;
end;
{------------------------------------------------------------------------------}
{ SetAlignment                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetAlignment (const Value: TCrHorizontalAlignment);
var
  valueInfo : PEValueInfo;
begin
  FAlignment := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HORALIGNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HORALIGNMENT,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  valueInfo.viInteger := Ord(FAlignment);
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_HORALIGNMENT, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_HORALIGNMENT,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetSuppressIfDuplicated                                                      }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetSuppressIfDuplicated : Boolean;
var
  valueInfo : PEValueInfo;
begin
  Result := FSuppressIfDuplicated;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SUPPRESS_IF_DUPLICATED, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfDuplicated <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_DUPLICATED,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfDuplicated <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  FSuppressIfDuplicated := True;
  if valueInfo.viBoolean = False then
    FSuppressIfDuplicated := False;
  Result := FSuppressIfDuplicated;
end;
{------------------------------------------------------------------------------}
{ SetSuppressIfDuplicated                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetSuppressIfDuplicated (const Value: Boolean);
var
  valueInfo : PEValueInfo;
begin
  FSuppressIfDuplicated := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SUPPRESS_IF_DUPLICATED, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_DUPLICATED,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  valueInfo.viBoolean := Bool(FSuppressIfDuplicated);
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_SUPPRESS_IF_DUPLICATED, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_SUPPRESS_IF_DUPLICATED,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCanGrow                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetCanGrow : Boolean;
var
  valueInfo : PEValueInfo;
begin
  Result := FCanGrow;
  if not StatusIsGo then Exit;

  if (FFieldType in [fvString..fvPersistentMemo]) then
  begin{CanGrow}
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_EXPAND, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetCanGrow <PEGetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_EXPAND, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetCanGrow <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
    FCanGrow := True;
    if valueInfo.viBoolean = False then
      FCanGrow := False;
    Result := FCanGrow;
  end;
end;
{------------------------------------------------------------------------------}
{ SetCanGrow                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetCanGrow (const Value: Boolean);
var
  valueInfo : PEValueInfo;
begin
  FCanGrow := Value;
  if not StatusIsGo then Exit;

  if (FFieldType in [fvString..fvPersistentMemo]) then
  begin
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_EXPAND, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PEGetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_EXPAND,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;

    valueInfo.viBoolean := Bool(FCanGrow);
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_EXPAND, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PESetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_EXPAND,
        valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PESetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetMaxNLines                                                                 }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetMaxNLines : integer;
var
  valueInfo : PEValueInfo;
begin
  Result := FMaxNLines;
  if not StatusIsGo then Exit;

  if (FFieldType in [fvString..fvPersistentMemo]) then
  begin{MaxNLines}
    if Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_OFN_MAX_N_LINES, valueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetMaxNLines <PEGetNthEmbeddedFieldFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MAX_N_LINES,
        ValueInfo) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'GetMaxNLines <PEGetObjectFormat>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
    FMaxNLines := ValueInfo.viInteger;
    Result := FMaxNLines;
  end;
end;
{------------------------------------------------------------------------------}
{ SetMaxNLines                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetMaxNLines (const Value: integer);
var
  valueInfo : PEValueInfo;
begin
  FMaxNLines := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MAX_N_LINES, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMaxNLines <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MAX_N_LINES,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMaxNLines <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  ValueInfo.viInteger := FMaxNLines;
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_MAX_N_LINES, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetMaxNLines <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_MAX_N_LINES,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetMaxNLines <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetTextRotation                                                              }
{------------------------------------------------------------------------------}
function TCrpeFormatB.GetTextRotation : TCrTextRotation;
var
  valueInfo : PEValueInfo;
begin
  Result := FTextRotation;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TEXT_ROTATION, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTextRotation <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_ROTATION,
      valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetTextRotation <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
  case valueInfo.viInteger of
    0   : FTextRotation := trZero;
    90  : FTextRotation := tr90;
    270 : FTextRotation := tr270;
    else
      FTextRotation := trZero;
  end;
  Result := FTextRotation;
end;
{------------------------------------------------------------------------------}
{ SetTextRotation                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatB.SetTextRotation (const Value: TCrTextRotation);
var
  valueInfo : PEValueInfo;
  i         : Smallint;
begin
  FTextRotation := Value;
  if not StatusIsGo then Exit;

  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormat (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TEXT_ROTATION, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTextRotation <PEGetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_ROTATION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTextRotation <PEGetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  case FTextRotation of
    trZero : i := 0;
    tr90   : i := 90;
    tr270  : i := 270;
    else
      i := 0;
  end;

  ValueInfo.viInteger := i;
  if Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormat(TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_OFN_TEXT_ROTATION, valueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetTextRotation <PESetNthEmbeddedFieldFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormat(TCrpe(Cx).JobNumber, Handle, PE_OFN_TEXT_ROTATION,
      ValueInfo) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetTextRotation <PESetObjectFormat>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFormatC                                                           }
{  - TextObjects                                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatC.Create;
begin
  inherited Create;
  {Field Formatting - Paragraph properties}
  FParagraph := TCrpeParagraphFormat.Create;
  FSubClassList.Add(FParagraph);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatC.Destroy;
begin
  FParagraph.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatC.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormatC then
  begin
    Paragraph.Assign(TCrpeFormatC(Source).Paragraph);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatC.Clear;
begin
  if not Assigned(Cx) then Exit;
  inherited Clear;
  FParagraph.Clear;
end;


{******************************************************************************}
{ Class TCrpeFormatFormulas                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatFormulas.Create;
begin
  inherited Create;
  FSuppress     := TStringList.Create;
  FKeepTogether := TStringList.Create;
  FCloseBorder  := TStringList.Create;
  FHyperLink    := TStringList.Create;
  xFormula      := TStringList.Create;
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatFormulas.Destroy;
begin
  FSuppress.Free;
  FKeepTogether.Free;
  FCloseBorder.Free;
  FHyperLink.Free;
  xFormula.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulas.Clear;
begin
  if not Assigned(Cx) then Exit;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) then
  begin
    FIndex := -1;
    Handle := 0;
    FSuppress.Clear;
    FKeepTogether.Clear;
    FCloseBorder.Clear;
    FHyperLink.Clear;
    xFormula.Clear;
  end
  else
  begin
    xFormula.Clear;
    SetSuppress(xFormula);
    SetKeepTogether(xFormula);
    SetCloseBorder(xFormula);
    SetHyperLink(xFormula);
  end;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulas.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormatFormulas then
  begin
    Suppress.Assign(TCrpeFormatFormulas(Source).Suppress);
    KeepTogether.Assign(TCrpeFormatFormulas(Source).KeepTogether);
    CloseBorder.Assign(TCrpeFormatFormulas(Source).CloseBorder);
    HyperLink.Assign(TCrpeFormatFormulas(Source).HyperLink);
    Exit;
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ StatusIsGo                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulas.StatusIsGo : Boolean;
begin
  Result := False;
  if not Assigned(Cx) then Exit;
  if (csLoading in TCrpe(Cx).ComponentState) then Exit;
  if Handle = 0 then Exit;
  if FIndex < 0 then Exit;
  if not TCrpe(Cx).JobIsOpen then Exit;
  Result := True;
end;


{******************************************************************************}
{ Class TCrpeFormatFormulasA                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatFormulasA.Create;
begin
  inherited Create;
  TStringList(FSuppress).OnChange := OnChangeSuppress;
  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
  TStringList(FHyperLink).OnChange := OnChangeHyperLink;
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatFormulasA.Destroy;
begin
  TStringList(FSuppress).OnChange := nil;
  TStringList(FKeepTogether).OnChange := nil;
  TStringList(FCloseBorder).OnChange := nil;
  TStringList(FHyperLink).OnChange := nil;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ GetSuppress                                                                  }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasA.GetSuppress : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FSuppress;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;


  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_OBJECT_VISIBILITY, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FSuppress.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FSuppress;
end;
{------------------------------------------------------------------------------}
{ SetSuppress                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.SetSuppress (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FSuppress.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_OBJECT_VISIBILITY, hText, iText) then
  begin
    TStringList(FSuppress).OnChange := OnChangeSuppress;
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FSuppress);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
      PE_FFN_OBJECT_VISIBILITY, PChar(sVCL)) then
    begin  TStringList(FSuppress).OnChange := OnChangeSuppress;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeSuppress                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.OnChangeSuppress (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetSuppress(xFormula);
    TStringList(Sender).OnChange := OnChangeSuppress;
  end;
end;
{------------------------------------------------------------------------------}
{ GetKeepTogether                                                              }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasA.GetKeepTogether : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FKeepTogether;
  if not StatusIsGo then
    Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetKeepTogether <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FKeepTogether.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FKeepTogether;
end;
{------------------------------------------------------------------------------}
{ SetKeepTogether                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.SetKeepTogether (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FKeepTogether.Assign(Value);
  if not StatusIsGo then
    Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
  begin
    TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FKeepTogether);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
      PE_FFN_KEEP_OBJECT_TOGETHER, PChar(sVCL)) then
    begin  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeKeepTogether                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.OnChangeKeepTogether (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetKeepTogether(xFormula);
    TStringList(Sender).OnChange := OnChangeKeepTogether;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCloseBorder                                                               }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasA.GetCloseBorder : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FCloseBorder;
  if not StatusIsGo then
    Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_SPLIT_ADORNMENT, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FCloseBorder.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FCloseBorder;
end;
{------------------------------------------------------------------------------}
{ SetCloseBorder                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.SetCloseBorder (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
  xJob       : Smallint;
begin
  FCloseBorder.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;

  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_SPLIT_ADORNMENT, hText, iText) then
  begin
    TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FCloseBorder);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle,
      PE_FFN_SPLIT_ADORNMENT, PChar(sVCL)) then
    begin  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
      case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeCloseBorder                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.OnChangeCloseBorder (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetCloseBorder(xFormula);
    TStringList(Sender).OnChange := OnChangeCloseBorder;
  end;
end;
{------------------------------------------------------------------------------}
{ GetHyperLink                                                                 }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasA.GetHyperLink : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
  xJob  : Smallint;
begin
  Result := FHyperLink;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_HYPERLINK, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'GetHyperLink <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FHyperLink.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FHyperLink;
end;
{------------------------------------------------------------------------------}
{ SetHyperLink                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.SetHyperLink (const Value: TStrings);
var
  hText     : HWnd;
  iText     : Smallint;
  pText     : PChar;
  sRPT,sVCL : string;
  xJob      : Smallint;
begin
  FHyperLink.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeSubreportsItem then
    xJob := TCrpe(Cx).PrintJobs(0)
  else
    xJob := TCrpe(Cx).JobNumber;
  
  if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(xJob, Handle,
    PE_FFN_HYPERLINK, hText, iText) then
  begin
    case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
        TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PEGetObjectFormatFormula>') of
      errIgnore : Exit;
      errAbort  : Abort;
      errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FHyperLink);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(xJob, Handle, PE_FFN_HYPERLINK, PChar(sVCL)) then
    begin  case TCrpe(Cx).GetErrorMsg(xJob,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PESetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeHyperLink                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasA.OnChangeHyperLink (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetHyperLink(xFormula);
    TStringList(Sender).OnChange := OnChangeHyperLink;
  end;
end;


{******************************************************************************}
{ Class TCrpeFormatFormulasB                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFormatFormulasB.Create;
begin
  inherited Create;
  FAlignment            := TStringList.Create;
  FCanGrow              := TStringList.Create;
  FSuppressIfDuplicated := TStringList.Create;
  {Set up OnChange event}
  TStringList(FSuppress).OnChange := OnChangeSuppress;
  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
  TStringList(FHyperLink).OnChange := OnChangeHyperLink;
  TStringList(FAlignment).OnChange := OnChangeAlignment;
  TStringList(FCanGrow).OnChange := OnChangeCanGrow;
  TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFormatFormulasB.Destroy;
begin
  TStringList(FSuppress).OnChange := nil;
  TStringList(FKeepTogether).OnChange := nil;
  TStringList(FCloseBorder).OnChange := nil;
  TStringList(FHyperLink).OnChange := nil;
  TStringList(FAlignment).OnChange := nil;
  TStringList(FCanGrow).OnChange := nil;
  TStringList(FSuppressIfDuplicated).OnChange := nil;
  FAlignment.Free;
  FCanGrow.Free;
  FSuppressIfDuplicated.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.Assign(Source: TPersistent);
begin
  if Source is TCrpeFormatFormulasB then
  begin
    Alignment.Assign(TCrpeFormatFormulasB(Source).Alignment);
    CanGrow.Assign(TCrpeFormatFormulasB(Source).CanGrow);
    SuppressIfDuplicated.Assign(TCrpeFormatFormulasB(Source).SuppressIfDuplicated);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.Clear;
begin
  if not Assigned(Cx) then Exit;
  inherited Clear;
  if IsStrEmpty(TCrpe(Cx).ReportName) or (Handle = 0) then
  begin
    FAlignment.Clear;
    FCanGrow.Clear;
    FSuppressIfDuplicated.Clear;
  end
  else
  begin
    SetAlignment(xFormula);
    SetCanGrow(xFormula);
    SetSuppressIfDuplicated(xFormula);
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeSuppress                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeSuppress (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetSuppress(xFormula);
    TStringList(Sender).OnChange := OnChangeSuppress;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeKeepTogether                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeKeepTogether (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetKeepTogether(xFormula);
    TStringList(Sender).OnChange := OnChangeKeepTogether;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeCloseBorder                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeCloseBorder (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetCloseBorder(xFormula);
    TStringList(Sender).OnChange := OnChangeCloseBorder;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeHyperLink                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeHyperLink (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetHyperLink(xFormula);
    TStringList(Sender).OnChange := OnChangeHyperLink;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeAlignment                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeAlignment (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetAlignment(xFormula);
    TStringList(Sender).OnChange := OnChangeAlignment;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeCanGrow                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeCanGrow (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetCanGrow(xFormula);
    TStringList(Sender).OnChange := OnChangeCanGrow;
  end;
end;
{------------------------------------------------------------------------------}
{ OnChangeSuppressIfDuplicated                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.OnChangeSuppressIfDuplicated (Sender: TObject);
begin
  if Sender is TStringList then
  begin
    TStringList(Sender).OnChange := nil;
    xFormula.Assign(TStringList(Sender));
    SetSuppressIfDuplicated(xFormula);
    TStringList(Sender).OnChange := OnChangeSuppressIfDuplicated;
  end;
end;
{------------------------------------------------------------------------------}
{ GetSuppress                                                                  }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetSuppress : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FSuppress;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_OBJECT_VISIBILITY, hText, iText) then
    begin  TStringList(FSuppress).OnChange := OnChangeSuppress;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_OBJECT_VISIBILITY, hText, iText) then
    begin  TStringList(FSuppress).OnChange := OnChangeSuppress;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppress <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FSuppress.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FSuppress;
end;
{------------------------------------------------------------------------------}
{ SetSuppress                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetSuppress (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FSuppress.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_OBJECT_VISIBILITY, hText, iText) then
    begin  TStringList(FSuppress).OnChange := OnChangeSuppress;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, PE_FFN_OBJECT_VISIBILITY,
      hText, iText) then
    begin  TStringList(FSuppress).OnChange := OnChangeSuppress;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FSuppress);
  {Compare Formula with Report Formula}
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_OBJECT_VISIBILITY, PChar(sVCL)) then
      begin    TStringList(FSuppress).OnChange := OnChangeSuppress;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_OBJECT_VISIBILITY, PChar(sVCL)) then
      begin    TStringList(FSuppress).OnChange := OnChangeSuppress;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppress <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetKeepTogether                                                              }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetKeepTogether : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FKeepTogether;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
    begin  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetKeepTogether <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
    begin  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetKeepTogether <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FKeepTogether.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FKeepTogether;
end;
{------------------------------------------------------------------------------}
{ SetKeepTogether                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetKeepTogether (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FKeepTogether.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
    begin  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_KEEP_OBJECT_TOGETHER, hText, iText) then
    begin  TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FKeepTogether);
  {Compare Formula with Report Formula}
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_KEEP_OBJECT_TOGETHER, PChar(sVCL)) then
      begin    TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_KEEP_OBJECT_TOGETHER, PChar(sVCL)) then
      begin    TStringList(FKeepTogether).OnChange := OnChangeKeepTogether;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetKeepTogether <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCloseBorder                                                               }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetCloseBorder : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FCloseBorder;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_SPLIT_ADORNMENT, hText, iText) then
    begin  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_SPLIT_ADORNMENT, hText, iText) then
    begin  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCloseBorder <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FCloseBorder.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FCloseBorder;
end;
{------------------------------------------------------------------------------}
{ SetCloseBorder                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetCloseBorder (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FCloseBorder.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_SPLIT_ADORNMENT, hText, iText) then
    begin  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_SPLIT_ADORNMENT, hText, iText) then
    begin  TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FCloseBorder);
  {Compare Formula with Report Formula}
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_SPLIT_ADORNMENT, PChar(sVCL)) then
      begin    TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_SPLIT_ADORNMENT, PChar(sVCL)) then
      begin    TStringList(FCloseBorder).OnChange := OnChangeCloseBorder;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCloseBorder <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetHyperLink                                                                 }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetHyperLink : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FHyperLink;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_HYPERLINK, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHyperLink <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_HYPERLINK, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetHyperLink <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FHyperLink.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FHyperLink;
end;
{------------------------------------------------------------------------------}
{ SetHyperLink                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetHyperLink (const Value: TStrings);
var
  hText     : HWnd;
  iText     : Smallint;
  pText     : PChar;
  sRPT,sVCL : string;
begin
  FHyperLink.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_HYPERLINK, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_HYPERLINK, hText, iText) then
    begin  case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FHyperLink);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_HYPERLINK, PChar(sVCL)) then
      begin    TStringList(FHyperLink).OnChange := OnChangeHyperLink;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle, PE_FFN_HYPERLINK, PChar(sVCL)) then
      begin    case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetHyperLink <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetAlignment                                                                 }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetAlignment : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FAlignment;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_HOR_ALIGNMENT, hText, iText) then
    begin  TStringList(FAlignment).OnChange := OnChangeAlignment;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAlignment <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_HOR_ALIGNMENT, hText, iText) then
    begin  TStringList(FAlignment).OnChange := OnChangeAlignment;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetAlignment <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FAlignment.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FAlignment;
end;
{------------------------------------------------------------------------------}
{ SetAlignment                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetAlignment (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FAlignment.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_HOR_ALIGNMENT, hText, iText) then
    begin  TStringList(FAlignment).OnChange := OnChangeAlignment;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_HOR_ALIGNMENT, hText, iText) then
    begin  TStringList(FAlignment).OnChange := OnChangeAlignment;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  sVCL := RTrimList(FAlignment);
  {Compare Formula with Report Formula}
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_HOR_ALIGNMENT, PChar(sVCL)) then
      begin    TStringList(FAlignment).OnChange := OnChangeAlignment;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_HOR_ALIGNMENT, PChar(sVCL)) then
      begin    TStringList(FAlignment).OnChange := OnChangeAlignment;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetAlignment <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCanGrow                                                                   }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetCanGrow : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FCanGrow;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_EXPAND, hText, iText) then
    begin  TStringList(FCanGrow).OnChange := OnChangeCanGrow;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCanGrow <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_EXPAND, hText, iText) then
    begin  TStringList(FCanGrow).OnChange := OnChangeCanGrow;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetCanGrow <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FCanGrow.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FCanGrow;
end;
{------------------------------------------------------------------------------}
{ SetCanGrow                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetCanGrow (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FCanGrow.Assign(Value);
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_EXPAND, hText, iText) then
    begin  TStringList(FCanGrow).OnChange := OnChangeCanGrow;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_EXPAND, hText, iText) then
    begin  TStringList(FCanGrow).OnChange := OnChangeCanGrow;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FCanGrow);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_EXPAND, PChar(sVCL)) then
      begin    TStringList(FCanGrow).OnChange := OnChangeCanGrow;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_EXPAND, PChar(sVCL)) then
      begin    TStringList(FCanGrow).OnChange := OnChangeCanGrow;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetCanGrow <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ GetSuppressIfDuplicated                                                      }
{------------------------------------------------------------------------------}
function TCrpeFormatFormulasB.GetSuppressIfDuplicated : TStrings;
var
  hText : HWnd;
  iText : Smallint;
  pText : PChar;
begin
  Result := FSuppressIfDuplicated;
  {SuppressIfDuplicated formula not applicable to TextObjects}
  if (Parent.Parent is TCrpeTextObjectsItem) then Exit;
  if not StatusIsGo then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_SUPPRESS_IF_DUPLICATE, hText, iText) then
    begin  TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfDuplicated <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_SUPPRESS_IF_DUPLICATE, hText, iText) then
    begin  TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'GetSuppressIfDuplicated <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  FSuppressIfDuplicated.Text := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);
  Result := FSuppressIfDuplicated;
end;
{------------------------------------------------------------------------------}
{ SetSuppressIfDuplicated                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFormatFormulasB.SetSuppressIfDuplicated (const Value: TStrings);
var
  hText      : HWnd;
  iText      : Smallint;
  pText      : PChar;
  sVCL, sRPT : string;
begin
  FSuppressIfDuplicated.Assign(Value);
  if not StatusIsGo then Exit;
  if (Parent.Parent is TCrpeTextObjectsItem) then Exit;

  if Parent.Parent is TCrpeEmbeddedFieldsItem then
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetNthEmbeddedFieldFormatFormula (TCrpe(Cx).JobNumber, Handle,
      FFieldN, PE_FFN_SUPPRESS_IF_DUPLICATE, hText, iText) then
    begin  TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PEGetNthEmbeddedFieldFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end
  else
  begin
    if not TCrpe(Cx).CrpeEngine.PEGetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
      PE_FFN_SUPPRESS_IF_DUPLICATE, hText, iText) then
    begin  TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
      case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
          TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PEGetObjectFormatFormula>') of
        errIgnore : Exit;
        errAbort  : Abort;
        errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
      end;
    end;
  end;

  {Get FormatFormula Text}
  pText := GlobalLock(hText);
  sRPT := WideCharToString(PWideChar(pText));
  GlobalUnlock(hText);
  GlobalFree(hText);

  {Compare Formula with Report Formula}
  sVCL := RTrimList(FSuppressIfDuplicated);
  if CompareStr(sVCL, sRPT) <> 0 then
  begin
    if Parent.Parent is TCrpeEmbeddedFieldsItem then
    begin  
      if not TCrpe(Cx).CrpeEngine.PESetNthEmbeddedFieldFormatFormula(TCrpe(Cx).JobNumber, Handle,
        FFieldN, PE_FFN_SUPPRESS_IF_DUPLICATE, PChar(sVCL)) then
      begin    TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errCRPEBugs,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PESetNthEmbeddedFieldFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end
    else
    begin  if not TCrpe(Cx).CrpeEngine.PESetObjectFormatFormula(TCrpe(Cx).JobNumber, Handle,
        PE_FFN_SUPPRESS_IF_DUPLICATE, PChar(sVCL)) then
      begin    TStringList(FSuppressIfDuplicated).OnChange := OnChangeSuppressIfDuplicated;
        case TCrpe(Cx).GetErrorMsg(TCrpe(Cx).JobNumber,errNoOption,errEngine,'',
            TCrpe(Cx).BuildErrorString(Self) + 'SetSuppressIfDuplicated <PESetObjectFormatFormula>') of
          errIgnore : Exit;
          errAbort  : Abort;
          errRaise  : raise ECrpeError.Create(TCrpe(Cx).LastErrorNumber, TCrpe(Cx).LastErrorString);
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
{ Class TCrpeFieldObjectFormat                                                 }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeFieldObjectFormat.Create;
begin
  inherited Create;
  FField := TCrpeFieldFormat.Create;
  FSubClassList.Add(FField);
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeFieldObjectFormat.Destroy;
begin
  FField.Free;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ Assign                                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectFormat.Assign(Source: TPersistent);
begin
  if Source is TCrpeFieldObjectFormat then
  begin
    Field.Assign(TCrpeFieldObjectFormat(Source).Field);
  end;
  inherited Assign(Source);
end;
{------------------------------------------------------------------------------}
{ Clear                                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectFormat.Clear;
begin
  inherited Clear;
  FField.Clear;
end;
{------------------------------------------------------------------------------}
{ SetFieldType                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectFormat.SetFieldType(FType: TCrFieldValueType);
begin
  FFieldType := FType;
  FField.FFieldType := FType;
  FField.FNumber.FFieldType := FType;
  FField.FDate.FFieldType := FType;
  FField.FDateTime.FFieldType := FType;
  FField.FTime.FFieldType := FType;
  FField.FParagraph.FFieldType := FType;
  FField.FFormulas.FFieldType := FType;
end;
{------------------------------------------------------------------------------}
{ SetFNum                                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeFieldObjectFormat.SetFNum(nField: Smallint);
begin
  FFieldN := nField;
  FField.FFieldN := nField;
  FField.FNumber.FFieldN := nField;
  FField.FDate.FFieldN := nField;
  FField.FDateTime.FFieldN := nField;
  FField.FTime.FFieldN := nField;
  FField.FParagraph.FFieldN := nField;
  FField.FFormulas.FFieldN := nField;
end;


end.
