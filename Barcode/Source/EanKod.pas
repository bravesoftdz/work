unit EanKod;

{$I ean.inc}

// OCR, UPC-D
// maxiCode, MSI
// QR Code
// Code 16K, Code 49, Code 1, PDF 417, Vericode, DataMatrix
// Australia Post 4-State, KIX 4-state, Royal Mail 4-state
// Codablock 256, Codablock A, Codablock N

// Centrovane kontrolne znaky - vertikalne
// offset medzi textom a kodom
// quiet zone - velkost, hranice
// popis - sablona
// Ean128A, Ean128B, Ean128C



// what's new :
// june 09. 2003
// - PostNet barcode with or without auto check digit - if property AutoCheckDigit is TRUE
//   check digit is added
// - ean6.res added - good for installation under Delphi 6
// - updated EanRead.pas - component TBarcodeReader - now works under Delphi 6 and Delphi 7 O.K.
// - Code 39 standard - removed char *, because * is START and STOP sequence.
//   Barcodes included * are not readable  
// - Correct print EAN128


interface

uses
     {$ifdef PSOFT_CLX}
        Types, Qt, QControls, QGraphics, QPrinters, QDialogs, QForms,
     {$else}
       {$ifdef PSOFT_D4}Windows,
       {$else}
                WinProcs,WinTypes,
       {$endif}
        Graphics, Messages, Controls, Printers, ClipBrd, Dialogs,
        {$ifdef PSOFT_D6}
                {$WARN UNIT_PLATFORM OFF}
        {$endif}
        FileCtrl,
        {$ifdef PSOFT_D6}
                {$WARN UNIT_PLATFORM ON}
        {$endif}

        Forms,
     {$endif}

     {$ifdef PSOFT_PDF417}
        EanPDF417,
     {$endif}
     Classes, SysUtils, EanSpecs;

const BarcodeLibraryVersion  = '4.5';
      BarcodeLibraryHomePage = 'http://barcode.psoft.sk';
      BarcodeLibraryEmail    = 'barcode@psoft.sk';
      BarcodeLibraryRegisterString = 'http://www.regsoft.net/purchase.php3?productid=7953';

type

 TBarCodePaintEvent = procedure (Sender: TObject; R:TRect; ABarCode:String) of object;

 TLastPaintError = (erOK, erMustBe, erErrorInBarCode, erCharOutOfSet,
                    erSmallPaintBox, erOutOfSecurityBox,
                    erBarcodeLengthInvalid,erFirstCharMustBeZero,
                    erCharMustBeSpace,
                    erCountCharMustBeEven,
                    erEmptyCode);


  TBarcodeListStyle = (btSymbol, btText);

  TCustomEAN = class;

  TBarcodeCaption = class(TPersistent)
  private
       FEan         : TCustomEAN;
       FVisible     : Boolean;
       FText        : String;
       FFont        : TFont;
       FAutoSize    : Boolean;
       FAlignment   : TAlignment;
       FAutoCaption : Boolean;
       procedure ChangeEAN;
       procedure FontChanged(Sender: TObject);
       procedure SetVisible(Value:Boolean);
       procedure SetText(Value:String);
       procedure SetFont(Value:TFont);
       procedure SetAutoSize(Value:Boolean);
       procedure SetAutoCaption(Value:Boolean);
       procedure SetAlignment(Value:TAlignment);
  protected
       procedure Paint(C:TCanvas; var R:TRect; RC:TPoint; Up:Boolean); virtual;
  public
       constructor CreateEAN(AOwner:TComponent);
       destructor  Destroy; override;
       procedure   Assign(Source:TPersistent); override;
       function    CalcFontRect(R:TRect):TRect;
       procedure   UpdateCaption;
  published
       property Visible  : Boolean    Read FVisible   Write SetVisible           Default False;
       property Text     : String     Read FText      Write SetText;
       property Font     : TFont      Read FFont      Write SetFont;
       property AutoSize : Boolean    Read FAutoSize  Write SetAutoSize          Default True;
       property Alignment: TAlignment Read FAlignment Write SetAlignment         Default taCenter;
       property AutoCaption : Boolean    Read FAutoCaption  Write SetAutoCaption Default False;
  end;

  TBarCodeHorzLines = class(TPen)
  private
      FLinesCount : Integer;
      procedure SetLinesCount(Value:Integer);
  published
      property LinesCount : Integer Read FLinesCount Write SetLinesCount;
  end;

  {$ifdef PSOFT_PDF417}
        TpsPDF417=class(TPersistent)
        private
                FMode:psPDF417Mode;
                FRows:Integer;
                FCols:Integer;
                FSecurityLevel:psPDF417ErrorCorrection;
                FTruncated:Boolean;
                FOnChange:TNotifyEvent;
                FPaintIfSmall:Boolean;
                procedure Invalidate;
                procedure SetMode(Value:psPDF417Mode);
                procedure SetSecurityLevel(Value:psPDF417ErrorCorrection);
                procedure SetRows(Value:Integer);
                procedure SetCols(Value:Integer);
                procedure SetTruncated(Value:Boolean);
                procedure SetPaintIfSmall(Value:Boolean);
        public
                Ean:TCustomEan;
                constructor CreateEan(AOwner:TComponent);
        published
                property Mode:psPDF417Mode Read FMode Write SetMode;
                property Rows:Integer Read FRows Write SetRows Default 0;
                property Cols:Integer Read FCols Write SetCols Default 10;
                property SecurityLevel: psPDF417ErrorCorrection Read FSecurityLevel Write SetSecurityLevel;
                property Truncated:Boolean Read FTruncated Write SetTruncated;
                property PaintIfSmall:Boolean Read FPaintIfSmall Write SetPaintIfSmall;
                property OnChange:TNotifyEvent Read FOnChange write FOnChange;
        end;
  {$endif}

  TCustomEan = class(TCustomControl)
  private
         FBarCode        : string;
         FShowLabels     : Boolean;
         FStartStopLines : Boolean;
         FTypBarCode     : TTypBarCode;
         FLinesColor     : TColor;
         FEan13AddUp     : Boolean;
         FFontAutoSize   : Boolean;
         FAutoInc        : Boolean;
         FAutoIncFrom    : Integer;
         FAutoIncTo      : Integer;
         FFirstCode      : String;
         FSecurity       : Boolean;
         FTransparent    : Boolean;
         FBackGroundColor: TColor;
         FLastPaintError : TLastPaintError;
         FLastErrorIndex : Integer;
         FLastErrorChar  : Char;
         FLabelMask      : String;
         FAngle          : Integer;
         FOnPaint        : TBarCodePaintEvent;
         FOnChangeTypCode: TNotifyEvent;
         FOnChangeBarCode: TNotifyEvent;
         FOnResize       : TNotifyEvent;
         FCaption        : TBarcodeCaption;
         FAutoSize       : Boolean;
         FDisableEditor  : Boolean;
         FCaptionBottom  : TbarcodeCaption;

         FBars           : String;
         FHorzLines      : TBarcodeHorzLines;

         FAutoCheckDigit : Boolean;

         {$ifdef PSOFT_PDF417}
                FPDF417:TpsPDF417;
         {$endif}
         procedure   SetBarCode(Value:String);
         procedure   SetLabelMask(Value:String);
         procedure   SetShowLabels(Value:Boolean);
         procedure   SetTransparent(Value:Boolean);
         procedure   SetStartStopLines(Value:Boolean);
         procedure   SetLinesColor(Value:TColor);
         procedure   SetBackgroundColor(Value:TColor);
         procedure   SetAddUp      (Value:Boolean);
         procedure   SetFontAuto(Value:Boolean);
         procedure   SetSecurity(Value:Boolean);
         procedure   SetAngle(Value:Integer);
         function    Codabar(ck:string):String;
         function    AbcCodabar(ck:string):string;
         function    Code39Standard(ck:string):string;
         function    Code39Full(ck:string):string;
         function    Code93Standard(ck:string):string;
         function    Code93Full(ck:string):string;
         function    Code128(ck:string; T:TTypBarCode):string;
         function    EanAddOn(ck:String; le:Integer):String;
         function    Ean8(ck:string):string;
         function    Ean13(ck:string):string;
         function    UPCA(ck:String):String;
         function    UPCE(ck:String):String;
         // function    ITF14(ck:string):string;
         function    Plessey(ck:String):String;
         function    Datalogic(ck:string):String;
         function    Matrix(ck:string):String;
         function    Industrial(ck:string):String;
         function    Interleaved(ck:string):String;
         function    IATA(ck:string):String;
         function    Invert(ck:string):string;
         function    Coop(ck:string):String;
         function    Code11(ck:string):String;
         function    PostNet(ck:string):string;
         function    PZN(ck:String):String;
         function    Zoom(ABarCode:string; AWidth:integer; ASecurity:Boolean):string;
         procedure   SaveAsWMFInt(M:TFileName);
         procedure   SetCaption(Value:TBarcodeCaption);
         procedure   SetCaptionBottom(Value:TBarcodeCaption);
         function    CheckEAN8 (var s:String):Boolean;
         function    CheckEAN13(var s:String):Boolean;
         function    CheckUPCA (var s:String):Boolean;
         function    TestCharsInSet(s:String):Boolean;
         procedure   SetSetOfChars(Value:String);
         procedure   HorzLinesChange(Sender:TObject);
         procedure   SetAutoCheckDigit(Value:Boolean);
  protected
         procedure   Paint; override;
         function    GetBarCodeLines(var BC:String):String;
         procedure   SetTypBarCode(Value:TTypBarCode);   virtual;
         procedure   MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
         procedure   SetAutoSize(Value:Boolean); {$ifdef PSOFT_D6} {$ifndef PSOFT_CLX} override; {$endif} {$endif}
  public
         constructor Create(AOwner:TComponent); override;
         destructor  Destroy;                   override;
         procedure   BarcodeComplete;
         procedure   DblClick;                  override;
         procedure   Next;


         procedure   Copyright;
         procedure   ActiveSetupWindow(Sheet:String);         virtual;

         procedure   PrintDialog;
         procedure   PrintBarcodes(w,h, margin_left, margin_top, margin_right, margin_bottom,
                                        space_x, space_y: Double; UseNext : Boolean; Count:Integer);

         procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

         function    MinWidth:Integer;
         function    GetSetOfChars:string;
         function    GetSetOfCharsVisible:String;
         function    CheckBarCode(S:String):Boolean;

         procedure   CopyToClipboard;
         procedure   SaveAsBitmap(M:TFileName);
         procedure   SaveToFile(M:TFileName);
         procedure   SaveToStreamBmp(Stream:TStream);

         {$ifndef PSOFT_CLX}
                procedure   CopyToClipboardWMF;
                procedure   SaveAsWMF(M:TFileName);
                procedure   SaveToStreamWmf(Stream:TStream);
                procedure   SaveAsEMF(M:TFileName);
         {$endif}

         procedure   SaveAsGIF(M:TFileName);
	{$IFDEF PSOFT_JPEG}
               procedure   SaveAsJPG(M:TFileName);
        {$ENDIF}


         procedure   Print(R:TRect);
         procedure   PrintToCanvas(C:TCanvas; R:TRect);
         function    LastPaintErrorText:String;
         function    DigitVisible(idx:integer):Boolean;
         procedure   AddTypesToList(L:TStrings; S:TBarcodeListStyle);
         function    GetBarcodeInfo:TBarCodeInfo;
         procedure   ExportToHTML(FileName:TFileName; gt:TGraphicsType);
         procedure   Assign(Value:TPersistent); override;
         function    BarcodeTypeName:String;
         property AutoInc           : Boolean        Read FAutoInc         Write FAutoInc;
         property AutoIncFrom       : Integer        Read FAutoIncFrom     Write FAutoIncFrom;
         property AutoIncTo         : Integer        Read FAutoIncTo       Write FAutoIncTo;
         property BackgroundColor   : TColor         Read FBackgroundColor Write SetBackgroundColor;
         property Transparent       : Boolean        Read FTransparent     Write SetTransparent;
         property ShowLabels        : Boolean        Read FShowLabels      Write SetShowLabels;
         property StartStopLines    : Boolean        Read FStartStopLines  Write SetStartStopLines;
         property TypBarCode        : TTypBarCode    Read FTypBarCode      Write SetTypBarCode;
         property LinesColor        : TColor         Read FLinesColor      Write SetLinesColor;
         property Ean13AddUp        : Boolean        Read FEan13AddUp      Write SetAddUp;
         property FontAutoSize      : Boolean        Read FFontAutoSize    Write SetFontAuto;
         property Security          : Boolean        Read FSecurity        Write SetSecurity;
         property Font;
         property LastPaintError:TLastPaintError Read FLastPaintError;
         property OnPaint:TBarCodePaintEvent Read FOnPaint Write FOnPaint;
         property OnChangeTypCode:TNotifyEvent Read FOnChangeTypCode Write FOnChangeTypCode;
         property OnChangeBarCode:TNotifyEvent Read FOnChangeBarCode Write FOnChangeBarCode;
         property BarCode           : string         Read FBarCode         Write SetBarCode;
         property LabelMask         : string         Read FLabelMask       Write SetLabelMask;
         property FirstBarCode      : string         Read FFirstCode       Write FFirstCode;
         property Angle             : Integer        Read FAngle           Write SetAngle             Default 0;
         property AutoSize          : Boolean         Read FAutoSize       Write SetAutoSize          Default True;
         property DisableEditor     : Boolean         Read FDisableEditor  Write FDisableEditor       Default False;
         property Caption           : TBarcodeCaption Read FCaption        Write SetCaption Stored True;
         property CaptionBottom     : TBarcodeCaption Read FCaptionBottom  Write SetCaptionBottom Stored True;
         property HorzLines         : TBarcodeHorzLines Read FHorzLines      Write FHorzLines;
         property SetOfChars        : String Read GetSetOfChars Write SetSetOfChars Stored False;
         property AutoCheckDigit    : Boolean Read FAutoCheckDigit write SetAutoCheckDigit;
         {$ifdef PSOFT_PDF417}
                property PDF417            : TpsPDF417 Read FPDF417 write FPDF417;
         {$endif}
  published
         property Align;
         property Visible;
         property OnClick;
         property OnDblClick;
         property OnDragDrop;
         property OnDragOver;
         property OnEndDrag;
         property OnMouseDown;
         property OnMouseMove;
         property OnMouseUp;
         property OnResize:TNotifyEvent Read FOnResize Write FOnResize;
         {$ifndef PSOFT_D1}
                  property OnStartDrag;
         {$endif}
  end;

  TEan   = class(TCustomEan)
     published
         property AutoInc;
         property AutoIncFrom;
         property AutoIncTo;
         property FirstBarCode;
         property BackgroundColor;
         property Transparent;
         property ShowLabels;
         property StartStopLines;
         property TypBarCode;
         property LinesColor;
         property Ean13AddUp;
         property FontAutoSize;
         property Security;
         property Font;
         property LastPaintError;
         property BarCode;
         property LabelMask;
         property OnPaint;
         property OnChangeTypCode;
         property OnChangeBarCode;
         property Angle;
         property Caption;
         property CaptionBottom;
         property AutoSize;
         property DisableEditor;
         property HorzLines;
         property SetOfChars;
         property AutoCheckDigit;
         {$ifdef PSOFT_PDF417}
                property PDF417; 
         {$endif}
  end;



  procedure PaintBarCode(C:TCanvas; R:TRect; E:TCustomEan);
  function  IsBookland(ISBN:String):Boolean;
  function  BooklandToEAN(s:String; T:TTypBarcode):String;
  function  CalcEan8CheckDigit(s:String):Char;
  function  CalcEan13CheckDigit(s:String):Char;
  function  CalcISBNCheckDigit(s:String):Char;
  function  RemoveControlChars(s:String):String;


implementation

uses TypInfo,  Math,
     {$ifdef PSOFT_CLX}
        EanKylixFmt
     {$else}
        EanFmt2
     {$endif}

     {$ifdef PSOFT_JPEG} , JPeg {$endif};
{$R eankod.res}

VAR H1,H2,H3,H4,H5,H6    : Integer;

const
{$ifdef PSOFT_CLX}
        TA_LEFT    =0;
        TA_CENTER  =1;
        TRANSPARENT=1;
        OPAQUE = 1;
{$endif}

    Const_ActiveKey = '6709086450';

    // OEEOEO
    //           *0*     *1*     *2*     *3*     *4*    *5*     *6*      *7*     *8*      *9*
    ean_sa = '0001101 0011001 0010011 0111101 0100011 0110001 0101111 0111011 0110111 0001011';
    ean_sb = '0100111 0110011 0011011 0100001 0011101 0111001 0000101 0010001 0001001 0010111';
    ean_sc = '1110010 1100110 1101100 1000010 1011100 1001110 1010000 1000100 1001000 1110100';
    ean_sm = 'AAAAAA AABABB AABBAB AABBBA ABAABB ABBAAB ABBBAA ABABAB ABABBA ABBABA';

    c93_r_dolar='100100110';
    c93_r_perc ='111011010';
    c93_r_lom  ='111010110';
    c93_r_plus ='100110010';
    c93_start  ='202022220';
    c93_0      ='100010100';
    c93_1      ='101001000';
    c93_2      ='101000100';
    c93_3      ='101000010';
    c93_4      ='100101000';
    c93_5      ='100100100';
    c93_6      ='100100010';
    c93_7      ='101010000';
    c93_8      ='100010010';
    c93_9      ='100001010';
    c93_A      ='110101000';
    c93_B      ='110100100';
    c93_C      ='110100010';
    c93_D      ='110010100';
    c93_E      ='110010010';
    c93_F      ='110001010';
    c93_G      ='101101000';
    c93_H      ='101100100';
    c93_I      ='101100010';
    c93_J      ='100110100';
    c93_K      ='100011010';
    c93_L      ='101011000';
    c93_M      ='101001100';
    c93_N      ='101000110';
    c93_O      ='100101100';
    c93_P      ='100010110';
    c93_Q      ='110110100';
    c93_R      ='110110010';
    c93_S      ='110101100';
    c93_T      ='110100110';
    c93_U      ='110010110';
    c93_V      ='110011010';
    c93_W      ='101101100';
    c93_X      ='101100110';
    c93_Y      ='100110110';
    c93_Z      ='100111010';
    c93_minus  ='100101110';
    c93_bodka  ='111010100';
    c93_space  ='111010010';
    c93_dolar  ='111001010';
    c93_lom    ='101101110';
    c93_plus   ='101110110';
    c93_perc   ='110101110';
    c93_sp1    ='100100110';
    c93_sp2    ='111011010';
    c93_sp3    ='111010110';
    c93_sp4    ='100110010'; 
    c93_stop   ='2020222202';


    co_start ='20220020020';
    co_1     ='1010110010';
    co_2     ='1010010110';
    co_3     ='1100101010';
    co_4     ='1011010010';
    co_5     ='1101010010';
    co_6     ='1001010110';
    co_7     ='1001011010';
    co_8     ='1001101010';
    co_9     ='1101001010';
    co_0     ='1010100110';
    co_minus ='1010011010';
    co_dolar ='1011001010';
    co_dvojb ='11010110110';
    co_lom   ='11011010110';
    co_bodka ='11011011010';
    co_plus  ='10110110110';
    co_A     ='10110010010';
    co_B     ='10010010110';
    co_C     ='10100100110';
    co_D     ='10100110010';
    co_stop  ='2022002002';

    PrefixISSN = '977';
    PrefixISBN = '978';
    PrefixISMN = '979';

   resourcestring
    ErrOK                  = 'O.K';
    ErrMustBe              = '(must be %d)';
    ErrUnspecified         = 'Unspecified error.';
    ErrUnavailableChar     = 'Unvailable char for this type of barcode.';
    ErrSmallPaintBox       = 'Rectangle for painting is very small.';
    ErrOutOfSecurityBox    = 'Rectangle for secure painting is very small.';
    ErrLengthInvalid       = 'Invalid length of barcode.';
    ErrFirstCharZero       = 'ITF14 - first char must be 0.';
    ErrCharSpace           = '. char must be space.';
    ErrCountCharBeEven     = '2of5 Interleaved/ITF - count of digits must be even.';
    ErrEmptyCode           = 'Empty code.';

    const ErrorsText:array[TLastPaintError] of string =(
          ErrOK,ErrMustBe, ErrUnspecified,ErrUnavailableChar,ErrSmallPaintBox,
          ErrOutOfSecurityBox,ErrLengthInvalid,ErrFirstCharZero,
          ErrCharSpace,ErrCountCharBeEven,ErrEmptyCode);


type TEanRect = record
              Left, Top, Width, Height, Angle : Integer;
     end;

function  RemoveControlChars(s:String):String;
var i:Integer;
begin
     Result:='';
     for i:=1 to Length(s) do
         if not (s[i] in [#0..#31]) then
            Result:=Result+s[i];
end;

{$ifdef PSOFT_CLX}
        procedure SetTextAlign(H:QPainterH; al:Integer);
        begin
        end;

        procedure SetBkMode(H:QPainterH; al:Integer);
        begin
        end;

        procedure RotateFont(F:TFont; A:Integer);
        begin
        end;

        procedure KylixNotImplemented;
        begin
                ShowMessage('Sorry, in Kylix not implemented this feature.');
        end;
{$endif}

{$ifndef PSOFT_CLX}
procedure RotateFont(F:TFont; A:Integer);
var LogFont: TLogFont;
begin
    with LogFont do begin
      lfHeight      := F.Height;
      lfWidth       := 0;
      lfEscapement  := A*10;
      lfOrientation := 0;
      if fsBold in F.Style then      lfWeight := FW_BOLD
      else                           lfWeight := FW_NORMAL;
      if fsItalic in F.Style then    lfItalic:=1
      else                           lfItalic:= 0;
      if fsUnderline in F.Style then lfUnderline :=1
      else                           lfUnderline := 0;
      if fsStrikeOut in F.Style then lfStrikeOut :=1
      else                           lfStrikeOut := 0;
      lfCharSet := F.CharSet;                  { default }
      StrPCopy(lfFaceName, F.Name);            { font's name }
      lfQuality        := PROOF_QUALITY;       { Windows gets a better one if avail  }
      lfOutPrecision   := OUT_TT_ONLY_PRECIS;  { force True type fonts }
      lfClipPrecision  := CLIP_DEFAULT_PRECIS; { default }
      lfPitchAndFamily := Variable_Pitch;      { default }
    end;
  F.Handle := CreateFontIndirect(LogFont);
end;

{$endif}


function RotatePoint(RotPoint,CenterPoint:TPoint; Angle:Integer):TPoint;
var sin_angle, cos_angle : Extended;
begin
     sin_angle := Sin(2*PI*Angle/360);
     cos_angle := Cos(2*PI*Angle/360);
     Result.X := CenterPoint.X + Round( (RotPoint.X-CenterPoint.X)*cos_angle
                                       +(RotPoint.Y-CenterPoint.Y)*sin_angle);
     Result.Y := CenterPoint.Y + Round(-(RotPoint.X-CenterPoint.X)*sin_angle
                                       +(RotPoint.Y-CenterPoint.Y)*cos_angle);
end;

procedure DrawRotatedRect(C:TCanvas; rr:TRect; rc:TPoint; a:Integer);
var P1,P2,P3,P4 : TPoint;
begin
    P1 := RotatePoint( Point(rr.Left, rr.Top),    rc, a);
    P2 := RotatePoint( Point(rr.Right,rr.Top),    rc, a);
    P3 := RotatePoint( Point(rr.Right,rr.Bottom), rc, a);
    P4 := RotatePoint( Point(rr.Left, rr.Bottom), rc, a);

    C.Pen.Style := psClear;
    C.Polygon([P1,P2,P3,P4]);
end;

procedure DrawRotatedText(C:TCanvas; X,Y:Integer; rc:TPoint; A:Integer; T:String);
var rp:TPoint;
begin
     rp := RotatePoint( Point(X, Y), rc,A);
     SetTextAlign(C.Handle, TA_LEFT);
     SetBkMode(C.Handle,TRANSPARENT);
     C.TextOut(rp.X,rp.Y,T);
end;



procedure TBarcodeHorzLines.SetLinesCount(Value:Integer);
begin
     if Value<>FLinesCount then begin
        FLinesCount:=Value;
        if Assigned(OnChange) then OnChange(Self);
     end;
end;


constructor TBarcodeCaption.CreateEAN(AOwner:TComponent);
begin
     inherited Create;
     if AOwner is TCustomEAN then FEan := TCustomEAN(AOwner)
     else                         FEan := nil;

     FText          := '';
     FVisible       := True;
     FAutoSize      := True;
     FAutoCaption   := False;

     FFont          := TFont.Create;
     FFont.Name     := 'Arial';
     FFont.Size     := 10;
     FFont.OnChange := FontChanged;
end;


destructor TBarcodeCaption.Destroy;
begin
     FFont.Free;
     inherited Destroy;
end;

procedure   TBarcodeCaption.Assign(Source:TPersistent);
var s:TBarcodeCaption;
begin
  { inherited Assign(Source); }
  if Source is TBarcodeCaption then begin
     s            := TBarcodeCaption(Source);
     FVisible     := S.Visible;
     FText        := S.Text;
     FAutoSize    := S.AutoSize;
     FAutoCaption := S.AutoCaption;
     FAlignment   := S.Alignment;
     FFont.Assign(S.Font);
  end;
end;

procedure TBarcodeCaption.FontChanged(Sender: TObject);
begin
     ChangeEAN;
end;

procedure TBarcodeCaption.ChangeEAN;
begin
    if FEan<>nil then FEan.Invalidate;
end;

procedure TBarcodeCaption.SetVisible(Value:Boolean);
begin
     if FVisible<>Value then begin
        FVisible := Value;
        ChangeEAN;
     end;
end;

procedure TBarcodeCaption.SetText(Value:String);
begin
     if FText<>Value then begin
        FText := Value;
        ChangeEAN;
     end;
end;

procedure TBarcodeCaption.SetFont(Value:TFont);
begin
    FFont.Assign(Value);
    ChangeEAN;
end;

procedure TBarcodeCaption.SetAutoSize(Value:Boolean);
begin
     if Value<>FAutoSize then begin
        FAutoSize := Value;
        ChangeEAN;
     end;
end;

function TBarcodeCaption.CalcFontRect(R:TRect):TRect;
begin
     Result := R;
end;

procedure TBarcodeCaption.SetAlignment(Value:TAlignment);
begin
     if Value<>FAlignment then begin
        FAlignment:=Value;
        ChangeEAN;
     end;
end;

procedure   TBarcodeCaption.UpdateCaption;
begin
     if FAutoCaption then begin
        case FEan.TypBarcode of
            bcISSN : FText    := 'ISSN '+Copy(FEan.BarCode,1,13);
            bcISBN : FText    := 'ISBN '+Copy(FEan.BarCode,1,13);
            bcISMN : FText    := 'ISMN '+Copy(FEan.BarCode,1,13);
        end;
        FVisible := (Text<>'');
        ChangeEAN;
     end;
end;

procedure TBarcodeCaption.SetAutoCaption(Value:Boolean);
begin
     if Value<>FAutoCaption then begin
        FAutoCaption := Value;
        UpdateCaption;
     end;
end;


procedure TBarcodeCaption.Paint;
var R1  : TRect;
    i,j : Integer;
begin
     if Visible and (Text<>'') then begin
             C.Brush.Color := clWhite;
             R1       := R;
             R1.Right := R1.Left + Length(FEan.FBars);

             C.Font.Assign(Font);
             if AutoSize then begin
                i:=C.TextWidth(Text);
                if (i>0) then
                  C.Font.Size:=Round(Int(0.9*C.Font.Size*(R1.Right-R1.Left)/i));
             end;

             i:=C.TextWidth(Text);
             j:=R1.Left;
             case Alignment of
                  taLeftJustify   : j := R1.Left;
                  taCenter        : j := R1.Left  + (R1.Right-R1.Left-i) div 2;
                  taRightJustify  : j := R1.Right - i;
             end;

             RotateFont(C.Font,FEan.Angle);

             if Up then begin
                R1.Bottom := R1.Top  + Round(1.2*Abs(C.Font.Height));
                R.Top := R1.Bottom+1;
             end else begin
                R1.Top   := R1.Bottom - Round(1.2*Abs(C.Font.Height));
                R.Bottom := R1.Top-1;
             end;
             DrawRotatedText(C, j, R1.Top, rc, FEan.Angle, Text);
          end;
end;



{ ---------------------------------------------------------------------------}




function GetFileName(N1,N2:String):String;
var S:TSaveDialog;
begin
     Result:='';
     S:=TSaveDialog.Create(nil);
     try
           S.Filter:=N1;
           S.DefaultExt:=N2;
           S.Options := S.Options + [ofOverwritePrompt];
           if S.Execute then Result:=S.FileName;
     finally
           S.Free;
     end;
end;

function TCustomEan.TestCharsInSet(s:String):Boolean;
var i:Integer;
    mn:String;
begin
    Result:=True;
    mn:=GetSetOfChars;
    for i:=1 to Length(s) do
        if Pos(s[i],mn)<=0 then begin
           Result := False;
           FLastPaintError := erCharOutOfSet;
           FLastErrorIndex := i;
           FLastErrorChar  := s[i];
           Exit;
        end;
end;


function TCustomEan.CheckEAN13(var s:String):Boolean;
begin
     if Length(s) in [12,13,16,19] then begin
        if Length(s)=12 then s:=s+' ';
        S[13]  := CalcEan13CheckDigit(Copy(s,1,12));
        Result := TestCharsInSet(Copy(S,1,13)+Copy(S,15,5));

        if (Length(s)>13) and Result then begin
           Result:= s[14]=' ';
           if Not Result then begin
              FLastPaintError := erCharMustBeSpace;
              FLastErrorIndex := 14;
           end;
        end;
     end else begin
        Result          := False;
        FLastPaintError := erBarcodeLengthInvalid;
     end;
end;

function TCustomEAN.CheckEan8(var s:String):Boolean;
begin
     if Length(s) in [7,8,11,14] then begin
        if Length(s)=7 then s:=s+' ';
        S[8]  := CalcEan8CheckDigit(Copy(s,1,7));
        Result := TestCharsInSet(Copy(S,1,8)+Copy(S,10,5));
        if (Length(s)>8) and Result then begin
           Result:= s[9]=' ';
           if Not Result then begin
              FLastPaintError := erCharMustBeSpace;
              FLastErrorIndex := 9;
           end;
        end;
     end else begin
        Result          := False;
        FLastPaintError := erBarcodeLengthInvalid;
     end;
end;

function TCustomEAN.CheckUPCA(var s:String):Boolean;
begin
     if Length(s) in [11,12,15,18] then begin
        if Length(s)=11 then s:=s+' ';
        S[12]  := CalcEan13CheckDigit(Copy(s,1,11));
        Result := TestCharsInSet(Copy(S,1,12)+Copy(S,14,5));
        if (Length(s)>12) and Result then begin
           Result:= s[13]=' ';
           if Not Result then begin
              FLastPaintError := erCharMustBeSpace;
              FLastErrorIndex := 13;
           end;
        end;
     end else begin
        Result          := False;
        FLastPaintError := erBarcodeLengthInvalid;
     end;
end;

function TCustomEan.GetSetOfChars:string;
begin
     result:=BarcodeInfo(FTypBarCode).Chars;
end;

function    TCustomEan.GetSetOfCharsVisible:String;
var s:String;
    i:Integer;
begin
     s:=GetSetOfChars;
     Result:='';
     for i:=1 to Length(s) do
         if s[i]<' ' then Result:=Result+'^'+Char(Ord(s[i])+Ord('A'))+' '
         else             Result:=Result+s[i]+' ';
     s:=Result;
end;

function TCustomEan.CheckBarCode(S:String):Boolean;
var pom : string;
    i   : Integer;
begin
     result := (s<>'');
     if s='' then begin
        FLastPaintError:=erEmptyCode;
        Exit;
     end;

     FLastPaintError := erOK;

     case FTypBarCode of
          bcEan8,bcJAN8   : Result:=CheckEan8(s);
          bcEan13,bcJAN13 : Result:=CheckEan13(s);
          bcUPCA          : Result:=CheckUPCA(s);
          bcITF   : begin
                        Result := (Length(s) in [6,14,16]);
                        if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                        {if Result then begin
                              pom    := Copy(S,1,Length(S)-1);
                              Result := CheckEan13(pom);
                        end;}
                   end;
          bcISSN,bcISBN,bcISMN : begin
                        pom:='';
                        for i:=1 to Length(S) do
                              if S[i]<>'-' then pom:=pom+s[i];
                        if Length(pom)>10 then begin
                           Result:=(pom[11]=' ');
                           if Not Result then begin
                              FLastPaintError := erCharMustBeSpace;
                              FLastErrorIndex := 11;
                           end;
                        end;

                        if Result then begin
                           Result:= (Length(pom) in [10,13,16]);
                           if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                        end;

                        if Result then
                           Result:=TestCharsInSet(Copy(pom,1,9)+Copy(pom,12,5));
                   end;
           bc25Interleaved : begin
                 Result:= TestCharsInSet(s);
                 if Result then begin
                    Result := (Length(s) mod 2 = 0);
                    if Not Result then
                         FLastPaintError := erCountCharMustBeEven;
                 end;
             end;
           bcUpcE0,bcUpcE1 : begin
                        Result:= (Length(s) in [8,11,14]);
                        if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                        if Result then
                              Result := TestCharsInSet(Copy(s,1,8)+Copy(s,10,5));
                        if Result then begin
                           Result:=(s[1]='0');
                           if not Result then
                              FLastPaintError := erFirstCharMustBeZero;
                        end;
                  end;
           bcUPCShipping : begin
                        Result:= (Length(s) in [14,21]);
                        if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                        if Result then
                              Result := TestCharsInSet(Copy(s,1,14)+Copy(s,16,6));
                  end;
           bcPostNet : begin
                            Result:= (Length(s) in [5,9,11]);
                            if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                            if Result then
                              Result := TestCharsInSet(s);
                       end;
           bcOPC     : begin
                            Result:= (Length(s)=10);
                            if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                            if Result then
                              Result := TestCharsInSet(s);
                       end;
           { bcMSI     : Result := TestCharsInSet(s);}
           { bcPlessey, bcADSPlessey : ;}
           bcAbcCodabar    : begin
                               Result := TestCharsInSet(s);
                               if Result then
                                  Result := (UpCase(s[1]) in ['A'..'D']) and (UpCase(s[Length(s)]) in ['A'..'D']);
                          end;
           bcMSIPlessey : begin
                            Result:= (Length(s)<=13);
                            if not Result then
                              FLastPaintError := erBarcodeLengthInvalid;
                            if Result then
                              Result := TestCharsInSet(s);
                       end;
           bcPZN : begin
                        Result := TestCharsInSet(s);
                        if Result then
                           Result := Length(s) in [6,7];

              end
          else    Result := TestCharsInSet(s);
     end;
end;

function TCustomEan.EanAddOn(ck:String; le:Integer):String;
var i,j :Integer;
    s,sp:String;
begin
     // s     := '       ';
     s     := '000000000';
     H5    := Length(s)+le+1;
     s     := s+'X1011';

     { two characters additional code}
     if Length(ck)=2 then begin
        j:=StrToInt(ck);
        case j mod 4 of
             0 : sp:='AA';
             1 : sp:='AB';
             2 : sp:='BA';
             3 : sp:='BB';
        end;
        case sp[1] of
          'A': S:=S+Copy(ean_sa,8*(Ord(ck[1])-Ord('0'))+1,7);
          'B': S:=S+Copy(ean_sb,8*(Ord(ck[1])-Ord('0'))+1,7);
        end;
        s:=s+'01';
        case sp[2] of
          'A': S:=S+Copy(ean_sa,8*(Ord(ck[2])-Ord('0'))+1,7);
          'B': S:=S+Copy(ean_sb,8*(Ord(ck[2])-Ord('0'))+1,7);
        end;
     end;

     { five characters additional code}
     if Length(ck)=5 then begin
        j:=3*(Ord(ck[1])+Ord(ck[3])+Ord(ck[5]) - 3* Ord('0'))
          +9*(Ord(ck[2])+Ord(ck[4])            - 2* Ord('0'));
        j:=j mod 10;

        case j of
             0 : sp:='BBAAA';
             1 : sp:='BABAA';
             2 : sp:='BAABA';
             3 : sp:='BAAAB';
             4 : sp:='ABBAA';
             5 : sp:='AABBA';
             6 : sp:='AAABB';
             7 : sp:='ABABA';
             8 : sp:='ABAAB';
             9 : sp:='AABAB';
        end;

        for i:=1 to Length(ck) do begin
            if i>1 then s:=s+'01';
            case sp[i] of
                'A': S:=S+Copy(ean_sa,8*(Ord(ck[i])-Ord('0'))+1,7);
                'B': S:=S+Copy(ean_sb,8*(Ord(ck[i])-Ord('0'))+1,7);
                'C': S:=S+Copy(ean_sc,8*(Ord(ck[i])-Ord('0'))+1,7);
            end;
        end;
     end;

     Result := s;
end;

function TCustomEan.Ean8(ck:string):string;
var i,ma : integer;
    s    : string;
begin
   ma        := Length(ck);
   Result := '';
   if ma<8 then Exit;

   s:='202';
   H1:=Length(s)+1;
   for i:=1 to 4 do S:=S+Copy(ean_sa,8*(Ord(ck[i])-Ord('0'))+1,7);
   H2:=Length(s)-1;
   s:=s+'02020';
   H3:=Length(s)+1;
   for i:=5 to 8 do
         S:=S+Copy(ean_sc,8*(Ord(ck[i])-Ord('0'))+1,7);
   H4:=Length(s)-1;
   s:=s+'202';

   Result:=s;

   if length(ck)>8 then
      Result:=Result+EanAddOn(Copy(ck,10,5), Length(Result));
end;

function TCustomEan.Ean13(ck:string):String;
var i             : integer;
    s1            : char;
    s,sp          : string;
begin

   Result    := '';

   sp := ' '+Copy(ean_sm,7*(Ord(ck[1])-Ord('0'))+1,6);
   s:='202';
   H1:=Length(s)+1;
   for i:=2 to 7 do begin
       s1:=sp[i];
       case s1 of
         'A': S:=S+Copy(ean_sa,8*(Ord(ck[i])-Ord('0'))+1,7);
         'B': S:=S+Copy(ean_sb,8*(Ord(ck[i])-Ord('0'))+1,7);
         'C': S:=S+Copy(ean_sc,8*(Ord(ck[i])-Ord('0'))+1,7);
       end;
   end;

   H2:=Length(s)-1;
   s:=s+'02020';
   H3:=Length(s)+1;
   for i:=8 to 13 do S:=S+Copy(ean_sc,8*(Ord(ck[i])-Ord('0'))+1,7);
   H4:=Length(s)-1;
   s:=s+'202';

   Result:=s;
   if length(ck)>13 then
      Result:=Result+EanAddOn(Copy(ck,15,5), Length(Result));
end;

function TCustomEan.UPCA(ck:String):String;
var i:Integer;
    s:String;
begin
     { start sequence}
     s := '202';
     H1:=Length(s)+8;
     { left 6 digits  uses ean code table part A}
     for i:=1 to 6 do
         S:=S+Copy(ean_sa,8*(Ord(ck[i])-Ord('0'))+1,7);

     H2:=Length(s)-1;
     { middle sequence}
     s :=s+'02020';
     H3:=Length(s)+1;

     { right 6 digits uses ean code table part C}
     for i:=7 to 12 do
         S:=S+Copy(ean_sc,8*(Ord(ck[i])-Ord('0'))+1,7);

     { stop sequence }
     H4:=Length(s)-8;
     s :=s+'202';
     H6:=Length(s)+1;

     for i:=4 to 11 do if s[i]='1' then s[i]:='2';
     for i:=Length(s)-9  to Length(s)-2 do
         if s[i]='1' then s[i]:='2';
         
     If ShowLabels and (Length(ck)<=12) then s:=s+'         ';

     Result := s;

     { UPC with extension ?}
     if length(ck)>12 then
        Result:=Result+EanAddOn(Copy(ck,14,5), Length(Result));

end;

function TCustomEan.UPCE(ck:String):String;
const UpcESystem0 : array ['0'..'9'] of String[6]=
          ('EEEOOO',  'EEOEOO',  'EEOOEO',  'EEOOOE',  'EOEEOO',
           'EOOEEO',  'EOOOEE',  'EOEOEO',  'EOEOOE',  'EOOEOE');
      UpcESystem1 : array ['0'..'9'] of String[6]=
          ('OOOEEE',  'OOEOEE',  'OOEEOE',  'OOEEEO',  'OEOOEE',
           'OEEOOE',  'OEEEOO',  'OEOEOE',  'OEOEEO',  'OEEOEO');
var s:String;
    i :Integer;
    p,cd : Char;
begin
     cd := ck[8];
     { start sequence}
     s := '202';
     H1:=Length(s)+1;
     for i:=2 to 7 do begin
         If FTypBarCode=bcUPCE0 then P:=UpcESystem0[cd][i-1]
         else                        P:=UpcESystem1[cd][i-1];
         if P='O' then S:=S+Copy(ean_sa,8*(Ord(ck[i])-Ord('0'))+1,7)
         else          S:=S+Copy(ean_sb,8*(Ord(ck[i])-Ord('0'))+1,7);
     end;
     H2 := Length(s)-1;
     s  := s+'020202';
     H6 := Length(s)+1;

     If ShowLabels and (Length(ck)<=8) then s:=s+'     ';
     Result := s;
     { UPC with extension ?}
     if length(ck)>8 then
        Result:=Result+EanAddOn(Copy(ck,10,5), Length(Result));
end;

function    TCustomEan.Plessey(ck:String):String;
const _n:array['0'..'9'] of string[4]=(
             '0000', '1000', '0100', '1100',
             '0010', '1010', '0110', '1110',
             '0001', '1001');
      _c:Array['A'..'F'] of String[4]=(
             '0101', '1101', '0011', '1011', '0111', '1111');
var s,pom,pom1  : String;
    i,j,su      : Integer;
    function MSICheck(ck:String):Char;
    var su_e,i : Integer;
        pom    : String;
    begin
         su := 0;
         pom:='';
         su_e:=0;
         if Length(ck)>=2 then begin
            for i:=1 to Length(ck) do
                if i mod 2 =0 then pom:=pom+ck[i]
                else               Inc(su_e, Ord(ck[i])-Ord('0'));
            pom:=IntToStr(2*StrToInt(pom));
            for i:=1 to Length(pom) do
                Inc(su_e, Ord(pom[i])-Ord('0'));
            su_e := 10 - (su_e mod 10);
            if su_e=10 then su_e:=0;
            Result :=Char(Ord('0')+su_e);
         end
            else Result:=' ';
    end;
begin
     case FTypBarcode of
          { bcPlessey    : s      := '1101';}
          { bcMSI        : s      := '1';}
          { bcADSPlessey : s      := '22';}
          bcMSIPlessey : begin
                       s      := '1';
                       { adding MSI check char}
                       if Length(ck)>=2 then begin
                          ck := ck+MSICheck(ck);
                          if Length(ck)=14 then
                             ck := ck+MSICheck(ck);
                       end;
               end;
     end;


     for i:=1 to Length(ck) do begin
         if ck[i] in ['0'..'9'] then pom:=_n[ck[i]];
         if ck[i] in ['A'..'F'] then pom:=_c[ck[i]];
         if FTypBarcode in [{bcMSI,}bcMSIPlessey] then begin
              pom1:='';
              for j:=1 to Length(pom) do
                  pom1:=Pom[j]+Pom1;
              pom:=Pom1;
         end;
         s:=s+pom;
     end;

     case FTypBarcode of
          { bcPlessey    : s      := s+'110011';}
          { bcMSI        : s      := s+'00';}
          bcMSIPlessey : s      := s+'00';
          { bcADSPlessey : s      := s+'22';}
     end;

     pom:=s;
     s:='';
     for i:=1 to Length(pom) do begin
         case pom[i] of
              '0' : s:=s+'10000';
              '1' : s:=s+'11100';
              '2' : s:=s+'22200';
              '3' : s:=s+'20000';
         end;
     end;
     Result := s;
     H1     := Length(s) div 4;
     H2     := Length(s) - H1;
end;

function  TCustomEan.PostNet(ck:string):string;
const PostnetTable : Array ['0'..'9'] of String[5] = (
         '11000','00011','00101','00110','01001',
         '01010','01100','10001','10010','10100');
var s,p  : String;
    i    : Integer;
    cs   : Integer;
begin
     p :='1';
     cs:=0;
     for i:=1 to Length(ck) do begin
         p :=p+PostnetTable[ck[i]];
         cs:=cs+Ord(ck[i])-Ord('0');
     end;

     if AutoCheckDigit then begin
        cs:=10-(cs mod 10);
        if cs=10 then cs:=0;
        p :=p+PostnetTable[Char(cs+Ord('0'))]
     end;

     p :=p+'1';

     { insert spaces}
     for i:=1 to Length(p) do begin
         if p[i]='0' then s:=s+'M0'
         else             s:=s+'10';
     end;
     result:=Copy(s,1,Length(s)-1);
end;


function TCustomEan.Codabar(ck:string):String;
var s   :string;
    i   :integer;
    suma:integer;
    mn  :string;
begin
     mn:=GetSetOfChars;

     if AutoCheckDigit then begin
        suma:=0;
        for i:=1 to Length(ck) do
           suma:=suma+Pos(ck[i],mn)-1;
        ck:=ck+mn[(suma mod 16)+1];
     end;


     Result:=co_start;
     H1:=Length(result)+1;
     for i:=1 to Length(ck) do begin
         case ck[i] of
            '0': s:=co_0;
            '1': s:=co_1;
            '2': s:=co_2;
            '3': s:=co_3;
            '4': s:=co_4;
            '5': s:=co_5;
            '6': s:=co_6;
            '7': s:=co_7;
            '8': s:=co_8;
            '9': s:=co_9;
            '-': s:=co_minus;
            '$': s:=co_dolar;
            ':': s:=co_dvojb;
            '/': s:=co_lom;
            '.': s:=co_bodka;
            '+': s:=co_plus;
            'A': s:=co_A;
            'B': s:=co_B;
            'C': s:=co_C;
            'D': s:=co_D;
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+co_stop;
end;


function TCustomEan.Code39Standard(ck:string):string;
var s:string;
    i:integer;
begin
     Result:='2002022022020';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
             '0': s:='101001101101';
             '1': s:='110100101011';
             '2': s:='101100101011';
             '3': s:='110110010101';
             '4': s:='101001101011';
             '5': s:='110100110101';
             '6': s:='101100110101';
             '7': s:='101001011011';
             '8': s:='110100101101';
             '9': s:='101100101101';
             'A': s:='110101001011';
             'B': s:='101101001011';
             'C': s:='110110100101';
             'D': s:='101011001011';
             'E': s:='110101100101';
             'F': s:='101101100101';
             'G': s:='101010011011';
             'H': s:='110101001101';
             'I': s:='101101001101';
             'J': s:='101011001101';
             'K': s:='110101010011';
             'L': s:='101101010011';
             'M': s:='110110101001';
             'N': s:='101011010011';
             'O': s:='110101101001';
             'P': s:='101101101001';
             'Q': s:='101010110011';
             'R': s:='110101011001';
             'S': s:='101101011001';
             'T': s:='101011011001';
             'U': s:='110010101011';
             'V': s:='100110101011';
             'W': s:='110011010101';
             'X': s:='100101101011';
             'Y': s:='110010110101';
             'Z': s:='100110110101';
             '-': s:='100101011011';
             '.': s:='110010101101';
             ' ': s:='100110101101';
             '*': s:='100101101101';
             '$': s:='100100100101';
             '/': s:='100100101001';
             '+': s:='100101001001';
             '%': s:='101001001001';
         end;
         Result:=Result+s+'0';
     end;
     H2:=Length(result)-1;
     Result:=Result+'200202202202';
end;

function TCustomEan.Code39Full(ck:string):string;
var s:string;
    I:INTEGER;
begin
     s:='*+$*';
     for i:=1 to Length(ck) do
         case ck[i] of
              #0 : s:=s+'%U';
              #1 : s:=s+'$A';
              #2 : s:=s+'$B';
              #3 : s:=s+'$C';
              #4 : s:=s+'$D';
              #5 : s:=s+'$E';
              #6 : s:=s+'$F';
              #7 : s:=s+'$G';
              #8 : s:=s+'$H';
              #9 : s:=s+'$I';
              #10: s:=s+'$J';
              #11: s:=s+'$K';
              #12: s:=s+'$L';
              #13: s:=s+'$M';
              #14: s:=s+'$N';
              #15: s:=s+'$O';
              #16: s:=s+'$P';
              #17: s:=s+'$Q';
              #18: s:=s+'$R';
              #19: s:=s+'$S';
              #20: s:=s+'$T';
              #21: s:=s+'$U';
              #22: s:=s+'$V';
              #23: s:=s+'$W';
              #24: s:=s+'$X';
              #25: s:=s+'$Y';
              #26: s:=s+'$Z';
              #27: s:=s+'%A';
              #28: s:=s+'%B';
              #29: s:=s+'%C';
              #30: s:=s+'%D';
              #31: s:=s+'%E';
              ' ': s:=s+' ';
              '!': s:=s+'/A';
              '"': s:=s+'/B';
              '#': s:=s+'/C';
              '$': s:=s+'/D';
              '%': s:=s+'/E';
              '&': s:=s+'/F';
              '''': s:=s+'/G';
              '(': s:=s+'/H';
              ')': s:=s+'/I';
              '*': s:=s+'/J';
              '+': s:=s+'/K';
              ',': s:=s+'/L';
              '-': s:=s+'-';
              '.': s:=s+'.';
              '/': s:=s+'/O';
              '0': s:=s+'0';
              '1': s:=s+'1';
              '2': s:=s+'2';
              '3': s:=s+'3';
              '4': s:=s+'4';
              '5': s:=s+'5';
              '6': s:=s+'6';
              '7': s:=s+'7';
              '8': s:=s+'8';
              '9': s:=s+'9';
              ':': s:=s+'/';
              ';': s:=s+'%F';
              '<': s:=s+'%G';
              '=': s:=s+'%H';
              '>': s:=s+'%I';
              '?': s:=s+'%J';
              '@': s:=s+'%V';
              'A'..'Z' : S:=S+CK[I];
              '[': s:=s+'%K';
              '\': s:=s+'%L';
              ']': s:=s+'%M';
              '^': s:=s+'%N';
              '_': s:=s+'%O';
              '`': s:=s+'%W';
              'a'..'z': s:=s+ '+' +UpCase(ck[i]);
              '{': s:=s+'%P';
              '|': s:=s+'%Q';
              '}': s:=s+'%R';
              '~': s:=s+'%S';
              #128:s:=s+'%T';
         end;
     result:=Code39Standard(s);
end;






function TCustomEan.Datalogic(ck:string):String;
var s:string;
    i:integer;
begin
     Result:='2020';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
             '1': s:='11010110';
             '2': s:='10010110';
             '3': s:='11001010';
             '4': s:='10110110';
             '5': s:='11011010';
             '6': s:='10011010';
             '7': s:='10100110';
             '8': s:='11010010';
             '9': s:='10010010';
             '0': s:='10110010';
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+'2202';
end;

function TCustomEan.Matrix(ck:string):String;
var s:string;
    i:integer;
begin
     Result:='22202020';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
             '1': s:='11010110';
             '2': s:='10010110';
             '3': s:='11001010';
             '4': s:='10110110';
             '5': s:='11011010';
             '6': s:='10011010';
             '7': s:='10100110';
             '8': s:='11010010';
             '9': s:='10010010';
             '0': s:='10110010';
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+'2220202';;
end;

function TCustomEan.Coop(ck:string):String;
var s:string;
    i:integer;
begin
     Result:='220220';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
             '1': s:='10100110';
             '2': s:='10110110';
             '3': s:='10110010';
             '4': s:='10010110';
             '5': s:='10010010';
             '6': s:='10011010';
             '7': s:='11010110';
             '8': s:='11010010';
             '9': s:='11011010';
             '0': s:='11001010';
         end;
         Result:=Result+s;
     end;
     H2:=Length(Result)-1;
     Result:=Result+'20022';
end;

function TCustomEan.Code11(ck:string):String;
var s,m   : string;
    i,j,k : integer;
begin

     m:=GetSetOfChars;

     // first check digit
     s:=ck;
     j:=0;
     k:=Length(s);
     for i:=1 to k do
         Inc(j, (k-i+1)*(Pos(s[i],m)-1));
     s:=s+m[(j mod 11)+1];

     // second check digit
     k:=Length(s);
     j:=0;
     for i:=1 to k do
         Inc(j, (k-i+1)*(Pos(s[i],m)-1));
     s:=s+m[(j mod 11)+1];

     Result:='20220020';
     H1:=Length(result)+1;
     for i:=1 to Length(s) do begin
         case s[i] of
             '0': s:='1010110';
             '1': s:='11010110';
             '2': s:='10010110';
             '3': s:='11001010';
             '4': s:='10110110';
             '5': s:='11011010';
             '6': s:='10011010';
             '7': s:='10100110';
             '8': s:='11010010';
             '9': s:='1101010';
             '-': s:='1011010';
         end;
         Result:=Result+s;
     end;
     H2:=Length(Result)-1;
     Result:=Result+'2022002';
end;


function TCustomEan.Industrial(ck:string):String;
var s:string;
    i:integer;
begin
     Result:='22022020';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
           '0': s:='101011011010';
           '1': s:='110101010110';
           '2': s:='101101010110';
           '3': s:='110110101010';
           '4': s:='101011010110';
           '5': s:='110101101010';
           '6': s:='101101101010';
           '7': s:='101010110110';
           '8': s:='110101011010';
           '9': s:='101101011010';
           else   begin
                Result:='';
                Exit;
           end;
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+'2202022';
end;


function TCustomEan.Interleaved(ck:string):String;
const def   : string='00110 10001 01001 11000 00101 10100 01100 00011 10010 01010';
      _space: String='          ';
var s     : string;
    i,j   : integer;
    s1,s2 : Byte;
    n1,n2 : byte;
begin
     s      := '';
     result := '';
     for i:=1 to (Length(ck)div 2) do begin
       s1:=Ord(ck[2*i-1]);
       s2:=Ord(ck[2*i]);
       for j:=1 to 5 do begin
           n1:=1+Ord(def[6*(Ord(s1)-Ord('0'))+j])-Ord('0');
           n2:=1+Ord(def[6*(Ord(s2)-Ord('0'))+j])-Ord('0');

           if n1=1 then s:=s+'1'
           else         s:=s+'11';

           if n2=1 then s:=s+'0'
           else         s:=s+'00';
       end;
       Result:=_space+'1010';
       H1:=Length(result)+1;
       Result:=Result+s;
       H2:=Length(result)-1;
       Result:=Result+'1101'+_space;
    end;
end;


function TCustomEan.Code93Standard(ck:string):string;
var i,j,k : integer;
    s     : String;
    suma  : integer;
    mn    : string;
    procedure AddOneCheckDigit;
    begin
        i:=Length(ck);
        j:=1;
        suma:=0;
        while i>0 do begin
           k:=Pos(ck[i],mn)-1;
           suma:=suma+j*k;
           Inc(j);
           if j>20 then j:=1;
           Dec(i);
        end;
        ck:=ck+mn[(suma mod 47) +1];
    end;
begin
     Result:=c93_start;
     H1:=Length(result)+1;
     mn:=GetSetOfChars;

     if FAutoCheckDigit then begin
        AddOneCheckDigit;
     end;

     j:=1;
     i:=Length(ck);
     suma:=0;
     while i>0 do begin
           k:=Pos(ck[i],mn)-1;
           suma:=suma+j*k;
           Inc(j);
           if j>15 then j:=1;
           Dec(i);
     end;
     ck:=ck+mn[(suma mod 47)+1];

     for i:=1 to Length(ck) do begin
         case ck[i] of
             '0': s:=c93_0;
             '1': s:=c93_1;
             '2': s:=c93_2;
             '3': s:=c93_3;
             '4': s:=c93_4;
             '5': s:=c93_5;
             '6': s:=c93_6;
             '7': s:=c93_7;
             '8': s:=c93_8;
             '9': s:=c93_9;
             'A': s:=c93_A;
             'B': s:=c93_B;
             'C': s:=c93_C;
             'D': s:=c93_D;
             'E': s:=c93_E;
             'F': s:=c93_F;
             'G': s:=c93_G;
             'H': s:=c93_H;
             'I': s:=c93_I;
             'J': s:=c93_J;
             'K': s:=c93_K;
             'L': s:=c93_L;
             'M': s:=c93_M;
             'N': s:=c93_N;
             'O': s:=c93_O;
             'P': s:=c93_P;
             'Q': s:=c93_Q;
             'R': s:=c93_R;
             'S': s:=c93_S;
             'T': s:=c93_T;
             'U': s:=c93_U;
             'V': s:=c93_V;
             'W': s:=c93_W;
             'X': s:=c93_X;
             'Y': s:=c93_Y;
             'Z': s:=c93_Z;
             '-': s:=c93_minus;
             '.': s:=c93_Bodka;
             ' ': s:=c93_space;
             '$': s:=c93_dolar;
             '/': s:=c93_lom;
             '+': s:=c93_plus;
             '%': s:=c93_perc;
             '&': s:=c93_sp1;
             '"': s:=c93_sp2;
             '(': s:=c93_sp3;
             ')': s:=c93_sp4;
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+c93_stop;
end;

function TCustomEan.Code93Full(ck:string):string;
var i:integer;
    s:String;
begin
     Result:=c93_start;
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
             ' ': s:=c93_space;
             '!': s:=c93_r_lom+c93_A;
             '"': s:=c93_r_lom+c93_B;
             '#': s:=c93_r_lom+c93_C;
             '$': s:=c93_dolar;
             '%': s:=c93_perc;
             '&': s:=c93_r_lom+c93_F;
             '''': s:=c93_r_lom+c93_G;
             '(': s:=c93_r_lom+c93_H;
             ')': s:=c93_r_lom+c93_I;
             '*': s:=c93_r_lom+c93_J;
             '+': s:=c93_plus;
             ',': s:=c93_r_lom+c93_L;
             '-': s:=c93_minus;
             '.': s:=c93_Bodka;
             '/': s:=c93_lom;

             '0': s:=c93_0;
             '1': s:=c93_1;
             '2': s:=c93_2;
             '3': s:=c93_3;
             '4': s:=c93_4;
             '5': s:=c93_5;
             '6': s:=c93_6;
             '7': s:=c93_7;
             '8': s:=c93_8;
             '9': s:=c93_9;

             ':': s:=c93_r_lom +c93_Z;
             ';': s:=c93_r_perc+c93_F;
             '<': s:=c93_r_perc+c93_G;
             '=': s:=c93_r_perc+c93_H;
             '>': s:=c93_r_perc+c93_I;
             '?': s:=c93_r_perc+c93_J;
             '@': s:=c93_r_perc+c93_V;

             'A': s:=c93_A;
             'B': s:=c93_B;
             'C': s:=c93_C;
             'D': s:=c93_D;
             'E': s:=c93_E;
             'F': s:=c93_F;
             'G': s:=c93_G;
             'H': s:=c93_H;
             'I': s:=c93_I;
             'J': s:=c93_J;
             'K': s:=c93_K;
             'L': s:=c93_L;
             'M': s:=c93_M;
             'N': s:=c93_N;
             'O': s:=c93_O;
             'P': s:=c93_P;
             'Q': s:=c93_Q;
             'R': s:=c93_R;
             'S': s:=c93_S;
             'T': s:=c93_T;
             'U': s:=c93_U;
             'V': s:=c93_V;
             'W': s:=c93_W;
             'X': s:=c93_X;
             'Y': s:=c93_Y;
             'Z': s:=c93_Z;

             '[': s:=c93_r_perc+c93_K;
             '\': s:=c93_r_perc+c93_L;
             ']': s:=c93_r_perc+c93_M;
             '^': s:=c93_r_perc+c93_N;
             '_': s:=c93_r_perc+c93_O;
             '`': s:=c93_r_perc+c93_W;

             'a': s:=c93_r_plus+c93_A;
             'b': s:=c93_r_plus+c93_B;
             'c': s:=c93_r_plus+c93_C;
             'd': s:=c93_r_plus+c93_D;
             'e': s:=c93_r_plus+c93_E;
             'f': s:=c93_r_plus+c93_F;
             'g': s:=c93_r_plus+c93_G;
             'h': s:=c93_r_plus+c93_H;
             'i': s:=c93_r_plus+c93_I;
             'j': s:=c93_r_plus+c93_J;
             'k': s:=c93_r_plus+c93_K;
             'l': s:=c93_r_plus+c93_L;
             'm': s:=c93_r_plus+c93_M;
             'n': s:=c93_r_plus+c93_N;
             'o': s:=c93_r_plus+c93_O;
             'p': s:=c93_r_plus+c93_P;
             'q': s:=c93_r_plus+c93_Q;
             'r': s:=c93_r_plus+c93_R;
             's': s:=c93_r_plus+c93_S;
             't': s:=c93_r_plus+c93_T;
             'u': s:=c93_r_plus+c93_U;
             'v': s:=c93_r_plus+c93_V;
             'w': s:=c93_r_plus+c93_W;
             'x': s:=c93_r_plus+c93_X;
             'y': s:=c93_r_plus+c93_Y;
             'z': s:=c93_r_plus+c93_Z;

             '{': s:=c93_r_perc+c93_P;
             '|': s:=c93_r_perc+c93_Q;
             '}': s:=c93_r_perc+c93_R;
             '~': s:=c93_r_perc+c93_S;

         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+c93_stop;
end;


function TCustomEan.Code128(ck:string; T:TTypBarCode):string;
const CODE128_STOP_ALL = '2200022202022';
      Code128StartA    = #103;
      Code128StartB    = #104;
      Code128StartC    = #105;
      Code128CodeA     = #101;
      Code128CodeB     = #100;
      Code128CodeC     = #99;
      Code128Shift     = #98;
      Code128FNC1      = #102;

    Code128Table: array[0..105] of string[11] = (
        '1101100110', '1100110110', '1100110011', '1001001100',
        '1001000110', '1000100110', '1001100100', '1001100010',
        '1000110010', '1100100100', '1100100010', '1100010010',
        '1011001110', '1001101110', '1001100111', '1011100110',
        '1001110110', '1001110011', '1100111001', '1100101110',
        '1100100111', '1101110010', '1100111010', '1110110111',
        '1110100110', '1110010110', '1110010011', '1110110010',
        '1110011010', '1110011001', '1101101100', '1101100011',
        '1100011011', '1010001100', '1000101100', '1000100011',
        '1011000100', '1000110100', '1000110001', '1101000100',
        '1100010100', '1100010001', '1011011100', '1011000111',
        '1000110111', '1011101100', '1011100011', '1000111011',
        '1110111011', '1101000111', '1100010111', '1101110100',
        '1101110001', '1101110111', '1110101100', '1110100011',
        '1110001011', '1110110100', '1110110001', '1110001101',
        '1110111101', '1100100001', '1111000101', '1010011000',
        '1010000110', '1001011000', '1001000011', '1000010110',
        '1000010011', '1011001000', '1011000010', '1001101000',
        '1001100001', '1000011010', '1000011001', '1100001001',
        '1100101000', '1111011101', '1100001010', '1000111101',
        '1010011110', '1001011110', '1001001111', '1011110010',
        '1001111010', '1001111001', '1111010010', '1111001010',
        '1111001001', '1101101111', '1101111011', '1111011011',
        '1010111100', '1010001111', '1000101111', '1011110100',
        '1011110001', '1111010100', '1111010001', '1011101111',
        '1011110111', '1110101111', '1111010111',
          // START_A      START_B       START_C
        '2202000020', '2202002000', '2202002220');

        function IsControl(c:Char):Boolean;
        begin
             result := (c in [#0..#31]);
        end;

        function Have4OrMoreDigits(const s:string; index:integer):integer;
        var i:integer;
        begin
             result := 0;
             i      := index;
             while ((i<=Length(s)) and (s[i] in ['0'..'9'])) do begin
                   Inc(Result);
                   Inc(i);
             end;
             if result<4 then Result := 0;
        end;

        function LowerAfterControl(const s:String; index:integer):Boolean;
        begin
             Result:=False;
             if index<Length(s) then
                Result := ( (s[index] in [#0..#31]) and (s[index+1] in ['a'..'z']));
        end;

        function ControlLowerControl(const s:String; index:integer):Boolean;
        begin
             Result:=False;
             if index<=Length(s)-2 then
                Result := ( (s[index] in [#0..#31]) and (s[index+1] in ['a'..'z']) and (s[index+2] in [#0..#31]));
        end;


        function Compress128(s:String):string;
        var i,j:integer;
            AktTyp:Char;
            temp:String;

            function SwitchToCharSet(c:Char):string;
            begin
                 result:='';
                 case c of
                   #0..#31 : case AktTyp of
                                'A' : ;
                                'B' : result := Code128Shift;
                                'C' : begin
                                           result := Code128CodeB+Code128Shift;
                                           AktTyp := 'B';
                                      end;
                             end;
                   ' '..'_' : case AktTyp of
                                   'A' : ;
                                   'B' : ;
                                   'C' : begin
                                              AktTyp :='B';
                                              result   := Code128CodeB;
                                         end;
                             end;
                   '`' .. '~' : case AktTyp of
                                     'A','C' : begin
                                              AktTyp :='B';
                                              result := Code128CodeB;
                                           end;
                                     'B' : ;
                             end;
                 end;
            end;
            function ConvertChar(c:Char):Char;
            begin
                 if c in [#0..#31] then Result := Chr(64+Ord(c))
                 else                   Result := Chr(Ord(c)-32);
            end;
        begin
             Result:='';
             if s='' then Exit;
             i:=1;

             // step 1.
             j:=Have4OrMoreDigits(s,1);
             if j>=4 then begin
                  Result := Code128StartC;
                  AktTyp := 'C';

                  while j>1 do begin
                          Result:=result+Chr( StrToInt(Copy(s,i,2)) );
                          Inc(i,2);
                          Dec(j,2);
                  end;
                  if j=1 then begin
                     Result:=Result+SwitchToCharSet(s[i])+ConvertChar(s[i]);
                     Inc(i);
                  end;
             end else if LowerAfterControl(s,1) then begin
                  Result := Code128StartA+ConvertChar(s[1])+Code128CodeB+ConvertChar(s[2]);
                  AktTyp := 'B';
                  Inc(i,2);
             end else begin
                  Result := Code128StartB;
                  AktTyp := 'B';
             end;

             // main loop
             while i<=Length(s) do begin
                 j:=Have4OrMoreDigits(s,i);

                 // switch to code C and compress
                 if j>=4 then begin
                    // step 3.
                    if AktTyp<>'C' then begin
                       if (j mod 2)=0 then
                          Result:=Result+Code128CodeC
                       else begin
                          Result:=Result+SwitchToCharSet(s[i])+ConvertChar(s[i])+Code128CodeC;
                          Inc(i);
                          Dec(j);
                       end;
                       AktTyp:='C';
                    end;
                    while j>0 do begin
                          Result:=result+Chr( StrToInt(Copy(s,i,2)) );
                          Inc(i,2);
                          Dec(j,2);
                    end;
                 end

                 else

                 // step 4.
                 if (AktTyp='B') and (i<=Length(s)) and (IsControl(s[i]))  then begin
                        if ControlLowerControl(s,i) then begin
                           Result := Result + Code128Shift + ConvertChar(s[i])
                                            + ConvertChar(s[i+1])
                                            + Code128Shift + ConvertChar(s[i+2]);
                           Inc(i,3);
                        end else begin
                           Result := Result + Code128CodeA + ConvertChar(s[i]);
                           Inc(i,1);
                           AktTyp := 'A';
                        end;
                 end

                 else


                 // step 5.
                 if (AktTyp='A') and (i<=Length(s)) and (s[i] in ['a'..'z'])  then begin
                    if (i+2<=Length(s)) and (IsControl(s[i+1])) and (s[i+2] in ['a'..'z']) then begin
                           Result := Result + Code128Shift + ConvertChar(s[i])
                                            + ConvertChar(s[i+1])
                                            + Code128Shift + ConvertChar(s[i+2]);
                           Inc(i,3);
                    end else begin
                           Result := Result + Code128Shift + ConvertChar(s[i]);
                           Inc(i,1);
                    end;
                 end

                 else

                 // step 6.
                 if (AktTyp='C') and (i<=Length(s)) and (not (s[i] in ['0'..'9'])) then begin
                    if LowerAfterControl(s,i) then begin
                       AktTyp := 'A';
                       Result := Result+Code128CodeA+ConvertChar(s[i])+Code128Shift + ConvertChar(s[i]);
                    end else begin
                       AktTyp := 'B';
                       Result := Result+Code128CodeB;
                    end;
                 end

                 else begin
                      if i<=Length(s) then begin
                         Result:=Result+SwitchToCharSet(s[i])+ConvertChar(s[i]);
                         Inc(i);
                      end;
                 end;
             end;
        end;

var i,j : integer;
    tmp : string;
begin
     result := '';

     tmp    := Compress128(ck);
     if tmp ='' then Exit;

     if t=bcEan128 then
        tmp:=Copy(tmp,1,1)+Code128FNC1+Copy(tmp,2,Length(tmp)-1);

     // calculate checksum
     j:=0;
     if AutoCheckDigit then begin
        for i:=1 to Length(tmp) do
           if i=1 then Inc(j, Ord(tmp[i]))
           else        Inc(j, (i-1)*Ord(tmp[i]));
        tmp:=tmp+Chr(j mod 103);
     end;

     for i:=1 to Length(tmp) do
         result:=result+Code128Table[Ord(tmp[i])]+'0';
     result:=result+CODE128_STOP_ALL;
     H1:=12;
     H2:=11*Length(tmp)-1;
end;


function TCustomEan.AbcCodabar(ck:string):string;
var s:string;
    i:integer;
begin
     for i:=1 to Length(ck) do begin
         case ck[i] of
            ' ': s:='000000000000';
            '0': s:=co_0;
            '1': s:=co_1;
            '2': s:=co_2;
            '3': s:=co_3;
            '4': s:=co_4;
            '5': s:=co_5;
            '6': s:=co_6;
            '7': s:=co_7;
            '8': s:=co_8;
            '9': s:=co_9;
            '-': s:=co_minus;
            '$': s:=co_dolar;
            ':': s:=co_dvojb;
            '/': s:=co_lom;
            '.': s:=co_bodka;
            '+': s:=co_plus;
            'A': s:=co_A;
            'B': s:=co_B;
            'C': s:=co_C;
            'D': s:=co_D;
         end;
         H1:=1;
         Result:=Result+s;
         H2:=Length(result)-1;
     end;
end;

function TCustomEan.Iata(ck:string):string;
var s:string;
    i:integer;
begin
     Result:='2020';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
           '0': s:='10101110111010';
           '1': s:='11101010101110';
           '2': s:='10111010101110';
           '3': s:='11101110101010';
           '4': s:='10101110101110';
           '5': s:='11101011101010';
           '6': s:='10111011101010';
           '7': s:='10101011101110';
           '8': s:='11101010111010';
           '9': s:='10111010111010';
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+'22202';
end;


function TCustomEan.Invert(ck:string):string;
var s:string;
    i:integer;
begin
     Result:='20002000202';
     H1:=Length(result)+1;

     for i:=1 to Length(ck) do begin
         case ck[i] of
           '0': s:='01010001000101';
           '1': s:='00010101010001';
           '2': s:='01000101010001';
           '3': s:='00010001010101';
           '4': s:='01010001010001';
           '5': s:='00010100010101';
           '6': s:='01000100010101';
           '7': s:='01010100010001';
           '8': s:='00010101000101';
           '9': s:='01000101000101';
         end;
         Result:=Result+s;
     end;
     H2:=Length(result)-1;
     Result:=Result+'0002020002';
end;

function  TCustomEan.PZN(ck:String):String;
var s:String;
begin
    s:='-'+ck;
    Result := Code39Standard(s);
end;

function TCustomEan.GetBarCodeLines(var BC:String):String;
var s,pr : string;
    i    : Integer;
    procedure MoveRight;
    begin
         if ShowLabels then begin
            s:=pr+s;
            Inc(H1,Length(pr));
            Inc(H2,Length(pr));
            Inc(H3,Length(pr));
            Inc(H4,Length(pr));
            Inc(H5,Length(pr));
            Inc(H6,Length(pr));
         end;
    end;
begin
     s:='';
     pr:='        ';
     H1:=0;
     H2:=0;
     H3:=0;
     H4:=0;
     H5:=0;
     H6:=0;

     if not CheckBarCode(BC) then Exit;

     { FBarCode:=BC; }

     case FTypBarCode of
        bcEan8,bcJAN8      : s:=Ean8(BarCode);
        bcEan13,bcISBN, bcISSN, bcISMN, bcJAN13 : begin
                                 if FTypBarcode<>bcEAN13 then
                                    s:=Ean13(BooklandToEAN(BC,FTypBarCode))
                                 else
                                    s:=Ean13(BC);
                                 MoveRight;
                           end;
        bcCodabar        : s:=Codabar(BarCode);
        bcCode39Standard : s:=Code39Standard(BarCode);
        bcCode39Full     : s:=Code39Full(BarCode);
        bcCode93Standard : s:=Code93Standard(BarCode);
        bcCode93Full     : s:=Code93Full(BarCode);
        bcCode128        : s:=Code128(BarCode,bcCode128);
        bcAbcCodabar     : s:=AbcCodabar(BarCode);
        bc25Datalogic    : s:=Datalogic(BarCode);
        bc25Interleaved  : s:=Interleaved(BarCode);
        bc25Matrix       : s:=Matrix(BarCode);
        bc25Industrial   : s:=Industrial(BarCode);
        bc25Iata         : s:=Iata(BarCode);
        bc25Invert       : s:=Invert(BarCode);
        bcITF            : s:=Interleaved(BarCode);
        bcUPCA           : begin
                                s:=UPCA(BarCode);
                                MoveRight;
                           end;
        bcUPCE0,bcUPCE1  : begin
                                s:=UPCE(BarCode);
                                MoveRight;
                           end;
        bcUPCShipping    : begin
                         i := 0;
                         if Copy(Barcode,16,6)<>'' then begin
                            s := Interleaved(Copy(Barcode,16,6));
                            s[1]:='X';
                            for i:=1 to Length(s) do
                                if s[i]='2' then s[i]:='1';
                            i:=Length(s);
                            s:='         '+s;
                         end;

                         s  := Interleaved(Copy(Barcode,1,14)) + s;
                         H5 := Length(s) - i + 20;
                    end;
        {bcPlessey,bcMSI,bcADSPlessey,}
        bcMSIPlessey : s:=Plessey(BarCode);
        bcPostNet    : s:=PostNet(BarCode);
        bcOPC        : s:=Interleaved(Barcode);
        bcEan128     : s:=Code128(BarCode, bcEan128);
        bc25Coop     : s:=Coop(BarCode);
        bcCode11     : s:=Code11(BarCode);
        bcPZN        : s:=PZN(Barcode);
     end;
     result:=s;
end;


procedure TCustomEan.DblClick;
begin
     if Assigned(OnDblClick) or FDisableEditor then inherited DblClick
     else                                           ActiveSetupWindow('');
end;


procedure TCustomEan.Next;
var s   : string;
    mn  : string;
    i,j : integer;
    pz  : Char;
    ai_from,ai_to : Integer;
begin
    mn := GetSetOfChars;
    if mn='' then Exit;
    s  := BarCode;
    pz := mn[Length(mn)];

    ai_from:=FAutoIncFrom; if ai_from=0 then ai_from:=1;
    ai_to:=FAutoIncTo;
    if ai_to=0 then
       case TypBarCode of
         bcEan8  : ai_to:=7;
         bcEan13 : ai_to:=12;
         else      ai_to:=Length(BarCode);
       end;

    s:=Copy(s,ai_from,ai_to-ai_from+1);

    i:=Length(s);
    repeat
          if s[i]=pz then begin
             s[i]:=mn[1];
             Dec(i);
          end else begin
             j:=Pos(s[i],mn);
             if j>0 then
                s[i]:=mn[j+1];
             Break;
          end;
    until False;

    s:=Copy(BarCode,1,ai_from-1)
      +s
      +Copy(BarCode,ai_to+1,1000);

    case TypBarCode of
         bcEan8  : s:=Copy(s,1,7);
         bcEan13 : s:=Copy(s,1,12);
    end;

    if CheckBarCode(s) then BarCode:=s;
end;

procedure   TCustomEan.SetBarCode(Value:String);
begin
     if FBarCode<>Value then begin
        FBarCode:=Value;
        BarCodeComplete;
        FCaption.UpdateCaption;
        Invalidate;
        if Assigned(FOnChangeBarCode) then FOnChangeBarCode(Self);
     end;
end;

procedure   TCustomEan.SetLabelMask(Value:String);
begin
     if FLabelMask<>Value then begin
        FLabelMask:=Value;
        Invalidate;
     end;
end;

procedure   TCustomEan.SetShowLabels(Value:Boolean);
begin
     if FShowLabels<>Value then begin
        FShowLabels:=Value;
        Invalidate;
     end;
end;

procedure   TCustomEan.SetStartStopLines(Value:Boolean);
begin
     if FStartStopLines<>Value then begin
        FStartStopLines:=Value;
        Invalidate;
     end;
end;


procedure   TCustomEan.SetTypBarCode(Value:TTypBarCode);
var i:Integer;
    BI:TBarcodeInfo;
begin
     if FTypbarCode<>Value then begin
        FTypBarCode := Value;
        BI          := BarcodeInfo(FTypbarCode);
        BarCode     := BI.InitValue;
        Caption.FAutoCaption := BI.AutoCaption;

        i:=MinWidth;
        if Width<i then Width:=i;
        if Assigned(FOnChangeTypCode) then FOnChangeTypCode(Self);
        Invalidate;
     end;
end;


procedure   TCustomEan.SetLinesColor(Value:TColor);
begin
     if FLinesColor<>Value then begin
        FLinesColor:=Value;
        Invalidate;
     end;
end;

procedure   TCustomEan.SetBackgroundColor(Value:TColor);
begin
     if FBackgroundColor<>Value then begin
        FBackgroundColor:=Value;
        Invalidate;
     end;
end;

procedure   TCustomEan.SetAddUp(Value:Boolean);
begin
     if FEan13AddUp<>Value then begin
        FEan13AddUp:=Value;
        Invalidate;
     end;
end;

procedure   TCustomEan.SetFontAuto(Value:Boolean);
begin
     if FFontAutoSize<>Value then begin
        FFontAutoSize:=Value;
        Invalidate;
     end;
end;



constructor TCustomEan.Create(AOwner:TComponent);
var i:Integer;
begin
     if AOwner<>nil then begin
        for i:=0 to AOwner.ComponentCount-1 do
            if CompareText(AOwner.Components[i].ClassName,'TQuickRep')=0 then begin
               ShowMessage('Please, not place non Quick report components on the TQuick report.');
               { Result := nil;}
               Abort;
            end;
     end;

     inherited Create(AOwner);

     {$ifdef PSOFT_PDF417}
     FPDF417:=TpsPDF417.CreateEan(Self);
     {$endif}

     FCaption       := TBarcodeCaption.CreateEAN(Self);
     FCaptionBottom := TBarcodeCaption.CreateEAN(Self);

     FOnPaint         := nil;
     FOnChangeTypCode := nil;
     FOnChangeBarCode := nil;

     FbackGroundColor:= clWhite;
     FBarCode        := '9771210107001';
     FLabelMask      :='';
     FShowLabels     := True;
     FStartStopLines := True;
     FTypBarCode     := bcEan13;
     FLinesColor     := clBlack;
     FEan13AddUp     := True;
     FFontAutoSize   := True;
     FSecurity       := False;
     FAngle          := 0;

     FAutoCheckDigit := True;


     FDisableEditor  := False;
     FAutoSize       := True;

     Font.Name       := 'Arial';
     Font.Size       := 16;
     Height          := 80;
     Width           := Length(GetBarCodeLines(FBarCode))+20;
     FAngle          := 0;

     i:=MinWidth;
     if Width<i then Width:=i;

     FHorzLines          := TBarcodeHorzLines.Create;
     FHorzLines.OnChange := HorzLinesChange;
end;

destructor TCustomEan.Destroy;
begin
     {$ifdef PSOFT_PDF417}
        FPDF417.Free;
     {$endif}
     FHorzLines.Free;
     FCaption.Free;
     FCaptionBottom.Free;

     Inherited Destroy;
end;

procedure TCustomEan.HorzLinesChange(Sender:TObject);
begin
     Invalidate;
end;


function TCustomEan.Zoom(ABarCode:string; AWidth:integer; ASecurity:Boolean):string;
var WidthCount     : integer;
    LineWidth      : integer;
    i,j            : integer;
    x1,x2,x3,x4,x5,x6 : integer;
begin
      result      := '';
      if ABarCode  = '' then Exit;

      if ASecurity then begin
         result:='';
         LineWidth := AWidth div Length(ABarCode);
         if LineWidth=0 then begin
            FLastPaintError := erOutOfSecurityBox;
            Exit;
         end;
         for i:=1 to Length(ABarCode) do begin
            for j:=1 to LineWidth do
                result:=result+ABarCode[i];
         end;
         h1:=H1*LineWidth;
         h2:=H2*LineWidth;
         h3:=H3*LineWidth;
         h4:=H4*LineWidth;
         h5:=H5*LineWidth;
         h6:=H6*LineWidth;
      end else BEGIN
         WidthCount  := 0;
         LineWidth   := Length(ABarCode);
         x1:=H1; x2:=H2; x3:=H3; x4:=H4; x5:=H5; x6:=H6;

         for i:=1 to LineWidth   do begin
            Dec(WidthCount,AWidth);
            if i=x1 then H1:=Length(Result);
            if i=x2 then H2:=Length(Result);
            if i=x3 then H3:=Length(Result);
            if i=x4 then H4:=Length(Result);
            if i=x5 then H5:=Length(Result);
            if i=x6 then H6:=Length(Result);
            while(WidthCount<0) do begin
                Inc(WidthCount,LineWidth);
                result:=result+ABarCode[i];
            end;
         end;
      end;
end;


function TCustomEan.MinWidth:Integer;
var s:String;
begin
     s:=BarCode;

     {$ifdef PSOFT_PDF417}
            Result :=PDF417MinWidth(Barcode,Pdf417.cols, PDF417.rows, Pdf417.SecurityLevel,
                                   PDF417.Mode, PDF417.Truncated);
     {$else}
            Result:=Length(GetBarCodeLines(s))+1;
     {$endif}
end;


procedure DrawDemo(C:TCanvas; R:TRect; rc:TPoint; A:Integer; bg:TColor);
var rp:TPoint;
begin
    C.Font.Color := clRed;
    RotateFont(C.Font, A);
    C.Brush.Color := bg;
    C.Brush.Style := bsSolid;

    rp := RotatePoint( Point((R.Left+R.Right) div 2, (R.Top+R.Bottom) div 2), rc,A);
    SetTextAlign(C.Handle, TA_CENTER);
    SetBkMode(C.Handle,OPAQUE);
    C.TextOut(rp.X,rp.Y,'>>Demo version<<');
end;

procedure PaintBarCode1(C:TCanvas; R:TRect; E:TCustomEan; ABarCode:String; RC:TPoint;
        PaintCaption:Boolean);
var Y,i,j      : integer;
    S          : string;
    LinesCount : integer;
    dy1,dy2    : integer;
    FontHeight : integer;
    AAddUp     : Boolean;
    BarCodeLabel : String;
    W,_lc        : Integer;
    R1           : TRect;
    P            : TPen;
    procedure DrawEanText(T1,T2,T3:String);
    var i:Integer;
    begin
         C.Brush.Style:=bsClear;
         i:=H2-H1-C.TextWidth(T1);
         DrawRotatedText(C, R.Left+H1+ (i div 2), Y, rc,E.Angle, T1);
         i:=H4-H3-C.TextWidth(T2);
         DrawRotatedText(C, R.Left+H3+ (i div 2),Y, rc,E.Angle, T2);
         if Length(T3)>=0 then begin
            if E.Ean13AddUp then DrawRotatedText(C, R.Left+H5,R.Top, rc,E.Angle,T3)
            else                 DrawRotatedText(C, R.Left+H5,Y, rc,E.Angle, T3);
         end;
    end;
begin
     E.FLastPaintError:=erOK;

     s:=E.GetBarCodeLines(ABarCode);
     if E.TypBarCode in [bcISBN, bcISSN, bcISMN] then
        ABarCode:=BooklandToEAN(ABarCode,E.TypBarcode);
     W   := R.Right-R.Left;
     { H   := R.Bottom-R.Top;}
     _lc := 0;

     if Length(s)>W then begin
        s:='';
        E.FLastPaintError:=erSmallPaintBox;
     end;


     BarCodeLabel:=ABarcode;
     case E.TypBarcode of
           bcPZN : BarcodeLabel := 'PZN - '+BarcodeLabel;
     end;
     BarcodeLabel := RemoveControlChars(BarcodeLabel);

     { zoom to regular rectangle}
     if Length(s)>0 then begin
                s:=E.Zoom(s,W,E.Security);
                if E.FlastPaintError<>erOK then Exit;
     end;

     with C do begin
          Brush.Color := E.BackgroundColor;
          Brush.Style := bsSolid;
          Pen.Color   := Brush.Color;
          if Length(s)=0 then begin
              if C<>Printer.Canvas then begin
                 Brush.Style:=bsDiagCross;
                 Brush.Color:=clRed;
                 DrawRotatedRect(C,R, rc, E.Angle);
              end;
              Exit;
          end else begin
             if not E.Transparent then
                 DrawRotatedRect(C,R, rc, E.Angle);
          end;

          if E.Transparent then SetBkMode(C.Handle,TRANSPARENT)
          else                  SetBkMode(C.Handle,OPAQUE);

          i:=1;
          while s[i] in [' '] do begin
               Inc(R1.Left);
               Inc(i);
          end;

          { draw label top and bottom }
          E.FBars := s;
          if PaintCaption then begin
             E.Caption.Paint(c,R,RC,True);
             E.CaptionBottom.Paint(c,R,RC,False);
          end;

          C.Font.Assign(E.Font);
          Pen.Width   := 1;
          Pen.Color   := E.LinesColor;
          Brush.Color := Pen.Color;
          Brush.Style := bsSolid;

          { Change font size, if needed }
          if E.FontAutoSize then begin
             case E.TypBarCode of
                bcEan8,bcJAN8                   : i:=TextWidth(Copy(ABarCode,1,4));
                bcEan13, bcISBN, bcISSN, bcISMN,
                bcUpcE0,bcUpcE1,bcJAN13         : i:=TextWidth(Copy(ABarCode,2,6));
                bcUPCA                          : i:=TextWidth(Copy(ABarCode,2,5));
                bcUPCShipping                   : i:=TextWidth(ABarCode+'     ');
                bcOPC                           : i:=TextWidth(ABarCode+'--');
                bcPZN                           : i:=TextWidth(BarcodeLabel);
                else
                    i:=TextWidth(ABarCode);
             end;
             if (i>0) then
                  Font.Size:=Round(Int(0.9*Font.Size*(H2-H1)/i));
          end;
          FontHeight := TextHeight(ABarCode);

          Brush.Color := E.LinesColor;
          Brush.Style := bsSolid;

          AAddUp := False;


          dy2:=0;
          if Length(s)>0 then begin
             LinesCount:=0;
             s:=s+'0';
             for i:=1 to Length(s) do begin
                 if s[i]='X' then AAddUp:=True;

                 if (s[i] in ['X','0',' ']) AND (LinesCount>0) then begin
                      if AAddUp AND E.Ean13AddUp then dy1:=FontHeight
                      else                            dy1:=0;

                      if E.TypBarcode=bcPostnet then begin
                          dy2:=0;
                          if S[i-1]='M' then dy1:=(R.Bottom-R.Top) div 2
                          else               dy1:=0;
                      end else begin
                          if (S[i-1]='2') and E.StartStopLines then begin
                             if E.TypBarCode in [bcUPCA,bcUpcE0, bcUpcE1] then
                                             DY2:=FontHeight div 2
                             else            DY2:=0;
                          end else begin
                             DY2:=0;
                             if E.ShowLabels or (S[i-1]='3') then
                                DY2:=FontHeight;
                          end;
                      end;

                      DrawRotatedRect( C,
                                       Rect(R.Left+i-LinesCount-1,R.Top+dy1,R.Left+i-1,R.Bottom-dy2),
                                       RC,
                                       E.Angle);
                      if _lc=0 then _lc := LinesCount;
                      LinesCount:=0;
                 end;

                 if s[i] in ['1','2','3','M'] then
                    Inc(LinesCount);
             end;
          end;

          i:=Length(s);
          if E.TypBarCode in [bcITF] then begin
             DrawRotatedRect(C, Rect(R.Left,R.Top,       R.Left+i-1,R.Top+2*_lc),
                             RC,
                             E.Angle);
             DrawRotatedRect(C, Rect(R.Left,R.Bottom-dy2-2*_lc,R.Left+i-1,R.Bottom-dy2),
                             RC,
                             E.Angle);
          end;

          Brush.Color:=E.LinesColor;
          if E.ShowLabels then begin
             RotateFont(C.Font, E.Angle);

             { mask characters}

             s:=E.LabelMask;
             for i:=1 to Length(BarCodeLabel) do
                 if (Copy(s,i,1)='') or (Copy(s,i,1)='_') then begin end
                 else BarCodeLabel[i]:=s[i];


             Y:=R.Top+R.Bottom-R.Top-FontHeight;
             C.Brush.Style:=bsClear;

             case
                 E.TypBarCode of
                      bcEan8,bcJAN8  : DrawEanText(Copy(BarCodeLabel,1,4),
                                                   Copy(BarCodeLabel,5,4),
                                                   Copy(BarCodeLabel,10,5));
                      bcEan13,bcISBN, bcISSN, bcISMN,bcJAN13 : begin
                                     s:=BarCodeLabel;
                                     DrawRotatedText(C, R.Left, Y, rc,E.Angle, BarCodeLabel[1]);
                                     DrawEanText(Copy(BarCodeLabel,2,6),
                                                 Copy(BarCodeLabel,8,6),
                                                 Copy(BarCodeLabel,15,5));
                                end;
                      bcUPCA : begin
                                     s:=BarCodeLabel;
                                     DrawRotatedText(C, R.Left, Y, rc,E.Angle, BarCodeLabel[1]);
                                     DrawEanText(Copy(BarCodeLabel,2,5),
                                                 Copy(BarCodeLabel,7,5),
                                                 Copy(BarCodeLabel,14,5));
                                     DrawRotatedText(C, R.Left+H6, Y, rc,E.Angle, BarCodeLabel[12]);
                                end;
                      bcUPCE0,bcUPCE1 : begin
                                     s:=BarCodeLabel;
                                     DrawEanText(Copy(BarCodeLabel,2,6),
                                                 '',
                                                 Copy(BarCodeLabel,10,5));
                                     C.Font.Size := Round (C.Font.Size *0.75 );
                                     RotateFont(C.Font, E.Angle);
                                     DrawRotatedText(C, R.Left,    R.Bottom-C.TextHeight('1'), rc,E.Angle, BarCodeLabel[1]);
                                     DrawRotatedText(C, R.Left+H6, R.Bottom-C.TextHeight('1'), rc,E.Angle, BarCodeLabel[8]);
                                end;
                      bcUPCShipping : DrawEanText(Copy(ABarCode,1,1)
                                               +'  '+Copy(ABarCode, 2,2)
                                               +'  '+Copy(ABarCode, 4,5)
                                               +'  '+Copy(ABarCode, 9,5)
                                               +'  '+Copy(ABarCode,14,1),
                                               '',
                                               Copy(ABarCode,16,6));
                      bcPostNet : ;
                      bcOPC : begin
                                       s:=Copy(BarCodeLabel, 1,5)+'-'
                                         +Copy(BarCodeLabel, 6,4)+'-'
                                         +Copy(BarCodeLabel,10,1);
                                       i:=H2-H1-TextWidth(s);
                                       DrawRotatedText(C, R.Left+H1+(i div 2), Y, rc,E.Angle,s);
                                  end;
                      else      begin
                         i:=H2-H1-TextWidth(BarCodeLabel);
                         DrawRotatedText(C, R.Left+H1+(i div 2), Y, rc,E.Angle,BarcodeLabel);
                      end;
             end;
          end;

          // draw horizontal lines, if nedded
          if E.HorzLines.LinesCount>0 then begin
             P:=TPen.Create;
             try
                P.Assign(Pen);
                Pen.Color := E.HorzLines.Color;
                Pen.Style := E.HorzLines.Style;
                Pen.Mode  := E.HorzLines.Mode;
                Pen.Width := E.HorzLines.Width;

                j:=(R.Bottom-R.Top) div (E.HorzLines.LinesCount + 1);
                for i:=1 TO E.HorzLines.LinesCount do begin
                        MoveTo(R.Left,R.Top+i*j);
                        LineTo(R.Right,R.Top+i*j);
                end;
             finally
                Pen.Assign(P);
                P.Free;
             end;
          end;

     end;
     E.FLastPaintError := erOK;
end;

{$ifdef PSOFT_PDF417}

procedure DrawLines(C:TCanvas; R:TRect; const s:String);
var i,x1,x2:Integer;
begin
        i  := 1;
        x1 := R.Left;
        x2 := R.Left;
        while i<=Length(s) do begin
                while (s[i]<>'0') and (i<=Length(s)) do begin
                        Inc(x2);
                        Inc(i);
                end;
                C.Rectangle(x1, R.Top, x2, R.Bottom);

                x1:=x2;
                while (s[i]='0') and (i<=Length(s)) do begin
                        Inc(x1);
                        Inc(i);
                end;
                x2:=x1;
        end;
end;

procedure PaintPDF417(C:TCanvas; R:TRect; E:TCustomEan);
var L:TStringList;
    s:String;
    R1:TRect;
    i, cols, rows:Integer;
    w, counter,LastTop : Integer;
begin
    E.FlastPaintError:=erOK;
    L:=TStringList.Create;
    try
        rows := E.PDF417.rows;
        cols := E.PDF417.cols;


        GetCompletePDF417LinesBars(E.Barcode,cols, rows, E.Pdf417.SecurityLevel,
                                   E.PDF417.Mode, E.PDF417.Truncated, L);

        if L.Count>0 then
           if Length(L[0])>(R.Right-R.Left) then
              E.FlastPaintError := erSmallPaintBox;

        if ((E.FlastPaintError=erSmallPaintBox) and E.PDF417.PaintIfSmall) or (E.FlastPaintError=erOK) then begin

           C.Pen.Color := E.LinesColor;
           C.Pen.Width := 1;
           C.Pen.Mode  := pmCopy;
           C.pen.Style := psSolid;
           C.Brush.Style := bsSolid;
           C.Brush.Color := E.LinesColor;
           counter := 0;
           LastTop := R.Top;

           for i:=0 to L.Count-1 do begin
                // this is "height zoom" algorithm
                Dec(Counter, R.Bottom-R.Top);
                w:=0;
                while Counter<0 do begin
                      Inc(Counter, rows);
                      Inc(w);
                end;
                s:=E.Zoom(L[i], R.Right-R.Left, E.Security);
                R1.Left  := R.Left;
                R1.Right := R.Right;
                R1.Top   := LastTop;
                R1.Bottom:= LastTop+w;
                LastTop:=R1.Bottom;
                DrawLines(C,R1,s);
           end;
        end else begin
           C.Font.Name := 'Arial';
           C.Font.Size := 8;
           C.Font.Color := clBlack;
           C.Brush.Color := clWhite;
           C.Brush.Style := bsSolid;
           C.FillRect(R);
           // SetTextAlign(C.Handle, TA_CENTER);

           R1 := R;
           {$ifdef PSOFT_CLX}
                C.TextRect(R1, R1.Left, R1.Top, E.LastPaintErrorText);
           {$else}
                DrawText(C.Handle, PChar(E.LastPaintErrorText), Length(E.LastPaintErrorText), R1,
                        DT_CENTER+DT_WORDBREAK or DT_CALCRECT);
                OffsetRect(R, 0, (R.Bottom-R.Top - R1.Bottom) div 2);

                DrawText(C.Handle, PChar(E.LastPaintErrorText), Length(E.LastPaintErrorText), R,
                        DT_CENTER+DT_WORDBREAK);
           {$endif}
           // C.TextRect(R, R.Left, R.Top, E.LastPaintErrorText);
        end;
    finally
        L.Free;
    end;
end;
{$endif}

procedure PaintBarCode(C:TCanvas; R:TRect; E:TCustomEan);
var R1,R2: TRect;   { rotated rect - size}
    RC   : TPoint;  { Rotation center;}
    W,H  : Integer;
    A,B  : Integer;
    X1,X2,X3,X4,ta : Extended;
begin
     if E.Barcode='' then Exit;

     R2 := R;
     RC.X := (R.Left+R.Right)  div 2;
     RC.Y := (R.Top +R.Bottom) div 2;

     R1 := R;
     W  := R.Right  - R.Left;
     H  := R.Bottom - R.Top;
     ta := Tan(DegToRad(E.Angle));
     X2 := ( W-H*ta)/(1-sqr(ta));
     X4 :=  ta*X2;
     A  := Round(sqrt(sqr(X2)+sqr(X4)));
     X1 := W-X2;
     X3 := H-X4;
     B  := Round(sqrt(sqr(X1)+sqr(X3)));

     R1.Left   := RC.X - A div 2;
     R1.Right  := RC.X + A div 2;
     R1.Top    := RC.Y - B div 2;
     R1.Bottom := RC.Y + B div 2;

     {$ifdef PSOFT_PDF417}
         if E.TypBarcode=bcPDF417 then
                PaintPDF417(C,R1,E)
         else
     {$endif}
                PaintBarCode1(C,R1,E,E.BarCode, RC, True);

     if Assigned(E.FOnPaint) then E.OnPaint(E,R,E.BarCode);

     {$ifdef PSOFT_DEMO}
        C.Font.Assign(E.Font);
        DrawDemo(C,R2, RC, E.Angle, E.BackgroundColor);
     {$endif}
end;

procedure TCustomEan.Paint;
var R:TRect;
begin
     R:=ClientRect;
     PaintBarCode(Canvas, r, Self);
end;



procedure TCustomEan.SetSecurity(Value:boolean);
begin
     if FSecurity<>Value then begin
        FSecurity:=Value;
        Invalidate;
     end;
end;


procedure   TCustomEan.SetTransparent(Value:Boolean);
begin
     if Value<>FTransparent then begin
        FTransparent:=Value;
        Invalidate;
     end;
end;

procedure TCustomEan.Print(R:TRect);
begin
     PaintBarCode(Printer.Canvas,R,Self);
end;

procedure TCustomEan.PrintToCanvas(C:TCanvas; R:TRect);
begin
     PaintBarCode(C,R,Self);
end;


procedure TCustomEan.CopyToClipboard;
var MyFormat       : Word;
    Bitmap         : TBitMap;
    AData,APalette : Thandle;
begin
  {$ifdef PSOFT_CLX}
        KylixNotImplemented;
  {$else}
  Bitmap := TBitmap.Create;
  try
    Bitmap.Height := Height;
    Bitmap.Width  := Width;
    PaintBarCode(Bitmap.Canvas,Rect(0,0,Width,Height),Self);
    Bitmap.SaveToClipBoardFormat(MyFormat,AData,HPalette(APalette));
    ClipBoard.SetAsHandle(MyFormat,AData);
  finally
    Bitmap.Free;
  end;
  {$endif};
end;


procedure   TCustomEan.SaveAsBitmap(M:TFileName);
var Bitmap : TBitMap;
begin
     if M='' then M:=GetFileName('Bitmap file|*.bmp','bmp');

     if M<>'' then begin
        Bitmap := TBitmap.Create;
        try
           Bitmap.Height := Height;
           Bitmap.Width  := Width;
           PaintBarCode(Bitmap.Canvas,Rect(0,0,Width,Height),Self);
           Bitmap.SaveToFile(M);
        finally
           Bitmap.Free;
        end;
     end;
end;

procedure   TCustomEan.SaveAsGIF(M:TFileName);
type TGifHeader=packed record
        Signature     : Array [0..2] of Char;
        Version       : Array [0..2] of Char;
        ScreenWidth   : Word;
        ScreenHeight  : Word;
        PackedPalette : Byte;
        BgColor       : Byte;
        AspectRatio   : Byte;
     end;
     TGifImageDescriptor=packed record
        Separator     : Byte;
        Left          : Word;
        Top           : Word;
        Width         : Word;
        Height        : Word;
        PackedPalette : Byte;
     end;
     procedure WriteColorToStream(S:TStream; C:TColor);
     var i:Integer;
         R,G,B,N:Byte;
     begin
         i:=ColorToRgb(C);
         R:=Byte(i and $ff);
         G:=Byte((i div 256) and $ff);
         B:=Byte((i div 65536) and $ff);
         N:=0;
         S.Write(R,1);
         S.Write(G,1);
         S.Write(B,1);
         S.Write(N,1);
     end;
     procedure WriteOneLineToStream(S:TStream; Line:Integer);
     begin

     end;

var FBmp    : TBitmap;
    FStream : TFileStream;
    GH      : TGifHeader;
    ID      : TGifImageDescriptor;
    Trailer : Byte;
    i       : Integer;
begin
    ShowMessage('Sorry, not supported.');
    if M='' then M:=GetFileName('GIF file|*.gif','gif');
    if M='' then Exit;

    FBmp := TBitmap.Create;
    try
           FBmp.Height := Height;
           FBmp.Width  := Width;
           PaintBarCode(FBmp.Canvas,Rect(0,0,Width,Height),Self);
           FStream := TFileStream.Create(M,fmCreate);
           try
              GH.Signature       := 'GIF';
              GH.Version         := '87a';
              GH.ScreenWidth     := Self.Width;
              GH.ScreenHeight    := Self.Height;
              GH.PackedPalette   := $f3;
              GH.BgColor         := 0;
              GH.AspectRatio     := 0;

              FStream.Write(GH,SizeOf(GH));
              WriteColorToStream(FStream,BackGroundColor);
              WriteColorToStream(FStream,LinesColor);
              WriteColorToStream(FStream,Font.Color);
              WriteColorToStream(FStream,Font.Color);

              ID.Separator     := $2c;
              ID.Left          := 0;
              ID.Top           := 0;
              ID.Width         := Self.Width;
              ID.Height        := Self.Height;
              ID.PackedPalette := 0;

              FStream.Write(ID, SizeOf(ID));
              for i:=0 to Self.Height-1 do
                  WriteOneLineToStream(FStream,i);
              Trailer := $3B;
              FStream.Write(Trailer, SizeOf(Byte));
           finally
              FStream.Free;
           end;
    finally
           FBmp.Free;
    end;
end;

{$IFDEF PSOFT_JPEG}
procedure   TCustomEan.SaveAsJPG(M:TFileName);
var FBmp  : TBitmap;
    FJpeg : TJPegImage;
begin
    if M='' then M:=GetFileName('JPEG file|*.jpg','jpg');
    if M='' then Exit;

    FBmp := TBitmap.Create;
    try
           FBmp.Height := Height;
           FBmp.Width  := Width;
           PaintBarCode(FBmp.Canvas,Rect(0,0,Width,Height),Self);

           FJpeg := TJPegImage.Create;
           try
              FJPeg.Assign(FBmp);
              FJPeg.CompressionQuality := 100;
              FJPeg.SaveToFile(M);
           finally
              FJPeg.Free;
           end;

    finally
           FBmp.Free;
    end;
end;
{$ENDIF}

{$ifdef PSOFT_CLX}
procedure   TCustomEan.SaveAsWMFInt(M:TFileName);
begin
        KylixNotImplemented;
end;
{$else}
procedure   TCustomEan.SaveAsWMFInt(M:TFileName);
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := UpperCase(ExtractFileExt(M))='.EMF';
        WMF.Height   := Height;
        WMF.Width    := Width;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,Width,Height);
        try
             PaintBarCode(CAN,R,Self);
        finally
             CAN.Free;
        end;
        if M<>'' then WMF.SaveToFile(M)
        else          Clipboard.Assign(WMF);
    finally
        WMF.Free;
    end;
end;
{$endif}


{$ifndef PSOFT_CLX}
procedure   TCustomEan.CopyToClipboardWMF;
begin
     SaveAsWMFInt('');
end;

procedure   TCustomEan.SaveAsWMF(M:TFileName);
begin
    if M='' then
       M:=GetFileName('Windows metafile|*.wmf','wmf');
    if M<>'' then SaveAsWMFInt(M);
end;


procedure   TCustomEan.SaveAsEMF(M:TFileName);
begin
    if M='' then
       M:=GetFileName('Enhanced metafile|*.emf','emf');
    if M<>'' then SaveAsWMFInt(M);
end;

procedure   TCustomEan.SaveToStreamWmf(Stream:TStream);
var WMF:TMetaFile;
    CAN:TMetaFileCanvas;
    R  :TRect;
begin
    WMF:=TMetaFile.Create;
    TRY
        WMF.Enhanced := False;
        WMF.Height   := Height;
        WMF.Width    := Width;
        CAN          := TMetaFileCanvas.Create(WMF,0);
        R            := Rect(0,0,Width,Height);
        try
             PaintBarCode(CAN,R,Self);
        finally
             CAN.Free;
        end;
        WMF.SaveToStream(Stream);
    finally
        WMF.Free;
    end;
end;
{$endif}

procedure TCustomEan.SaveToFile(M:TFileName);
var EXT : String;
begin
    if M='' then begin
       M:=GetFileName('Bitmap file|*.bmp|'+
                      'Windows metafile|*.wmf|'+
                      'Enhanced metafile|*.emf|'+
                      'GIF file|*.gif|'
	    		{$IFDEF PSOFT_JPEG}
				+'JPEG file|*.jpg'
			{$endif}
                        ,'bmp'
			);
       if M='' then Exit;
    end;

    Ext := UpperCase(ExtractFileExt(M));
         if Ext='.BMP' then SaveAsBitmap(M)
    {$ifndef PSOFT_CLX}
        else if Ext='.WMF' then SaveAsWmf(M)
        else if Ext='.EMF' then SaveAsEmf(M)
        else if Ext='.GIF' then SaveAsGif(M)
    {$endif}
	{$IFDEF PSOFT_JPEG}
    		else if Ext='.JPG' then SaveAsJpg(M)
	{$ENDIF}
	;
end;

procedure   TCustomEan.SaveToStreamBmp(Stream:TStream);
var Bitmap : TBitMap;
begin
        Bitmap := TBitmap.Create;
        try
           Bitmap.Height := Height;
           Bitmap.Width  := Width;
           PaintBarCode(Bitmap.Canvas,Rect(0,0,Width,Height),Self);
           Bitmap.SaveToStream(Stream);
        finally
           Bitmap.Free;
        end;
end;



function    TCustomEan.LastPaintErrorText:String;
begin
     Result:=ErrorsText[FLastPaintError];
     if FLastPaintError=erCharOutOfSet then
        Result:=Result+Format('(%d.char - %s)',[FLastErrorIndex, FLastErrorChar]);
     if FLastPaintError=erCharMustBeSpace then
        Result:=IntToStr(FLastErrorIndex)+Result;
     {if FLastPaintError=erBarcodeLengthInvalid then
        Result:=Result + Format(ErrMustBe,[FLastErrorIndex]);}

end;

procedure TCustomEAN.SetAngle(Value:Integer);
begin
     if FAngle<>Value then begin
           FAngle := 90*(Value div 90) mod 360;
           Invalidate;
     end;
end;


procedure TCustomEAN.ActiveSetupWindow(Sheet:String);
var i:Integer;
begin
   if not (Parent is TEanSetupFmt) then
     with TEanSetupFmt.Create(Application) do
       Try
          if Sheet<>'' then
             for i:=0 to ZAL.PageCount-1 do
                 if CompareText(Sheet, ZAL.Pages[i].Name)=0 then begin
                    ZAL.ActivePage := ZAL.Pages[i];
                    Break;
                 end;
          SetParentEAN(Self);
          if ShowModal=mrOK then
             Self.Assign(EAN);
       Finally
          Free;
       End;
end;


procedure   TCustomEAN.PrintDialog;
begin
     ActiveSetupWindow('SHEET_PRINT');
end;


procedure   TCustomEan.PrintBarcodes(w,h, margin_left, margin_top, margin_right, margin_bottom,
                                        space_x, space_y: Double; UseNext : Boolean; Count:Integer);
var TempCode:String;
    dpi_x, dpi_y : Integer;
    SizeX, SizeY : Integer;
    PosX, PosY   : Double;
    TempCount    : Integer;
    R            : TRect;
    ofsX, ofsY   : Integer;
begin
   {$ifdef PSOFT_CLX}
        KylixNotImplemented;
   {$else}
     TempCode := Barcode;
     try
        Screen.Cursor := crHourGlass;
        Printer.Title := 'Barcode library - printing barcodes ...';
        Printer.BeginDoc;
        try
           dpi_x := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
           dpi_y := GetDeviceCaps(Printer.Handle, LOGPIXELSY);

           SizeX := GetDeviceCaps(Printer.Handle, HORZSIZE);
           SizeY := GetDeviceCaps(Printer.Handle, VERTSIZE);

           OfsX  := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
           OfsY  := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);

           PosX := margin_left;
           PosY := margin_top;

           TempCount := 0;
           while TempCount<Count do begin


                 R.Left   := Trunc(PosX*dpi_X/25.4)-OfsX;
                 R.Top    := Trunc(PosY*dpi_X/25.4)-OfsY;
                 R.Right  := Trunc((PosX+w)*dpi_X/25.4)-OfsX;
                 R.Bottom := Trunc((PosY+h)*dpi_Y/25.4)-OfsY;

                 Print(R);
                 if UseNext then
                    Next;

                 Inc(TempCount);

                 PosX := PosX + Space_X + w;
                 if PosX>SizeX-Margin_Right-w then begin
                    PosX := margin_left;
                    PosY := PosY + space_y + h;
                 end;

                 if PosY>SizeY-Margin_Bottom-h then begin
                    PosY := margin_top;

                    if TempCount<Count then Printer.NewPage;
                 end;
           end;

        finally
               Screen.Cursor := crDefault;
               Printer.EndDoc;
        end;
     finally
            if UseNext then
               Barcode := TempCode;
     end;
   {$endif}
end;



procedure  TCustomEAN.Copyright;
begin
     ActiveSetupWindow('SH_COPYRIGHT');
end;


function TCustomEAN.DigitVisible(idx:integer):Boolean;
begin
     Result := True;
     if Length(LabelMask)>=idx then
        if LabelMask[idx]<>'_' then
        Result:=False;
end;

procedure TCustomEAN.AddTypesToList(L:TStrings; S:TBarcodeListStyle);
var q        : Integer;
    PropInfo : PPropInfo;
    TD       : TTypeData;
begin
     PropInfo := GetPropInfo(Self.ClassInfo,'TypBarCode');
     TD       := GetTypeData(PropInfo.PropType^)^;
     L.BeginUpdate;
     try
        L.Clear;
        for q:=TD.MinValue to TD.MaxValue do begin
            if    S=btSymbol then L.Add(GetEnumName(PropInfo^.PropType^,q))
            else                  L.Add(BarcodeInfo(TTypBarCode(q)).Name);
        end;
     finally
          L.EndUpdate;
     end;
end;

procedure  TCustomEAN.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     inherited MouseDown(Button,Shift, X, Y);
end;

procedure   TCustomEAN.SetCaption(Value:TBarcodeCaption);
begin
     FCaption.Assign(Value);
end;

procedure   TCustomEAN.SetCaptionBottom(Value:TBarcodeCaption);
begin
     FCaptionBottom.Assign(Value);
end;

function    CalcEan13CheckDigit(s:String):Char;
var i,j,c:Integer;
begin
        j:=0;
        for i:=1 to Length(s) do begin
            c:=Ord(S[i])-Ord('0');
            if (i mod 2)=0 then j:=j+3*c
            else                j:=j+c;
        end;
        j:=j mod 10;
        if j>0 then j:=10-j;
        Result:=Char(j+Ord('0'));
end;

function    CalcEan8CheckDigit(s:String):Char;
var i,j,c:Integer;
begin
        j:=0;
        for i:=1 to Length(s) do begin
            c:=Ord(S[i])-Ord('0');
            if (i mod 2)=0 then j:=j+c
            else                j:=j+3*c;
        end;
        j:=j mod 10;
        if j>0 then j:=10-j;
        Result:=Char(j+Ord('0'));
end;

function    CalcISBNCheckDigit(s:String):Char;
var i,j:Integer;
    pom:String;
begin
    pom:='';
    for i:=1 to Length(s) do
        if s[i]<>'-' then pom:=pom+s[i];

    j:=0;
    for i:=1 to 9 do
         j:=j+i*(Ord(pom[i])-Ord('0'));

    j:=j mod 11;

    if j<10 then Result:=Char(j+Ord('0'))
    else         Result:='X';
end;

function    BooklandToEAN(s:String; T:TTypBarCode):String;
var i:Integer;
begin
     case T of
          bcISSN : Result := PrefixISSN;
          bcISBN : Result := PrefixISBN;
          bcISMN : Result := PrefixISMN;
     end;
     for i:=1 to Length(s) do
         if s[i]<>'-' then Result:=Result+s[i];

     if Length(Result)=12 then
        Result:=Result+' ';

     if Length(Result)>=13 then
        Result[13]:=CalcEan13CheckDigit(Copy(Result,1,12));
end;


function  CheckDigit212Mod10(s:String):Char;
var i,su,na :Integer;
begin
    su:=0;
    for i:=1 to Length(s) do begin
        na := Ord(s[i])-Ord('0');
        if (i mod 2)=1 then na:=2*na;
        if na<10 then Inc(su,na)
        else begin
             Inc(su,1);
             Inc(su,na-10);
        end;
    end;

    su:=10 - (su mod 10);
    if su=10 then su:=0;

    Result := Char(su+Ord('0'));
end;

procedure   TCustomEAN.BarcodeComplete;
var s,p:String;
    i,j:Integer;
begin
     s:=FBarCode;
     case FTypBarCode of
          bcEan8,bcJAN8  : begin
                         if FTypBarCode=bcJAN8 then
                            s:='49'+Copy(s,3,20);
                         if Length(s)=7 then s:=s+' ';
                         if Length(s)>=8 then
                            s[8] := CalcEan8CheckDigit(Copy(s,1,7));
                    end;
          bcEan13,bcJAN13 : begin
                         if FTypBarCode=bcJAN13 then
                            s:='49'+Copy(s,3,20);
                         if Length(s)=12 then s:=s+' ';
                         if Length(s)>=13 then
                            s[13] := CalcEan13CheckDigit(Copy(s,1,12));
                    end;
          bcUPCA : begin
                         if Length(s)=11 then s:=s+' ';
                         if Length(s)>=12 then
                            s[12] := CalcEan8CheckDigit(Copy(s,1,11));
                    end;
          bcITF  : begin
                         if Length(s) in [5,13,15] then s:=s+' ';
                         case Length(s) of
                              6  : s[ 6] := CalcEan8CheckDigit(Copy(s,1, 5));
                              14 : s[14] := CalcEan8CheckDigit(Copy(s,1,13));
                              16 : s[16] := CalcEan8CheckDigit(Copy(s,1,15));
                         end;
                    end;
          bcISBN, bcISSN, bcISMN  : begin
                         if Length(s)=11 then s:=s+'- ';
                         if Length(s)=12 then s:=s+' ';
                         if Length(s)>=13 then
                            s[13] := CalcISBNCheckDigit(Copy(s,1,12));
                    end;
          bcUPCE0,bcUPCE1 : begin
                         if Length(s)=6 then s:='0'+s;
                         if Length(s)=7 then s:=s+' ';
                         if Length(s)>=8 then begin
                            i:=Ord(s[7])-Ord('0');
                            case i of
                                 0,1,2 : p:=Copy(s,1,3)+s[7]+'0000'+Copy(s,4,3);
                                 3     : p:=Copy(s,1,4)+'00000'+Copy(s,5,2);
                                 4     : p:=Copy(s,1,5)+'00000'+Copy(s,6,1);
                                 5 ..9 : p:=Copy(s,1,6)+'0000' +s[7];
                            end;
                            s[8] := CalcEan8CheckDigit(p);
                         end;
                    end;
          bcUPCShipping : begin
                               if Length(s)=13 then s:=s+' ';
                               if Length(s)>=14 then
                                  s[14] := CalcEan8CheckDigit(Copy(s,1,13));
                          end;
          bcOPC         : begin
                               if Length(s)=9 then s:=s+' ';
                               if Length(s)>=10 then
                                  s[10] := CheckDigit212Mod10(Copy(s,1,9));
                          end;
          bcPZN        : begin
                               if Length(s) in [6,7] then begin
                                  if Length(s)=6 then s:=s+' ';
                                  j := 0;
                                  for i:=1 to 6 do
                                     j := j + (i+1)*(Ord(s[i])-Ord('0'));
                                  s[7] := Char(Ord('0') + j mod 11);
                               end;
                         end;
     end;
     if s<>FBarCode then FBarCode:=s;
end;

procedure   TCustomEAN.SetAutoSize(Value:Boolean);
var i:Integer;
begin
     if FAutoSize<>Value then begin
        FAutoSize:=Value;
        if FAutoSize then begin
           i:=MinWidth;
           if Width<i then
              Width  := i;
        end;
     end;
end;

function TCustomEAN.GetBarcodeInfo:TBarCodeInfo;
begin
     Result:=BarcodeInfo(FTypbarCode);
end;

procedure   TCustomEAN.ExportToHTML(FileName:TFileName; gt:TGraphicsType);
const td_im1 ='<TD align=center><IMG src="%s" width=%d height=%d></TD>';
      td_im3 ='<TR><TD colspan=3 align=center><BR><IMG src="%s" width=%d height=%d alt="%s" border=0></TD></TR>';
      td_de  ='<TR><TD><B>%s</B></TD><TD colspan=2>%s</TD></TR>';
      ca     ='List of barcode types supported by EAN library.';
var L:TStringList;
    i:TTypBarCode;
    E:TEAN;
    j:Integer;
    dir,fn,s,ext : String;
    BI       : TBarCodeInfo;
begin
     ext := GrExtensions[gt];

     L:=TStringList.Create;
     E:=TEan.Create(Self);
     try
        L.Add('<HTML>');
        L.Add('<HEAD>');
        s:='barcode,vcl,source,code,shareware,delphi,component,print,scanner,'
          +'software,2of5,two of five,UPC,EAN';
        for i:=Low(TTypBarCode) to High(TTypBarCode) do
            s:=s+','+BarcodeInfo(i).Name;
        for j:=1 to Length(s) do
            if s[j] in ['(',')'] then s[j]:=',';

        L.Add(Format('<META NAME=DESCRIPTION CONTENT="%s">',[ca]));
        L.Add(Format('<META NAME=KEYWORDS CONTENT="%s">',[s]));
        L.Add('<TITLE>'+ca+'</TITLE>');
        L.Add('</HEAD>');
        L.Add('<BODY><H2 align=center>'+ca+'</H2><HR><BR>');
        L.Add('<CENTER><A HREF="http://www.psoft.sk">PSOFT Homepage</A><BR></CENTER>');

        dir := ExtractFilePath(FileName);
        ForceDirectories(dir);
        for i:=Low(TTypBarCode) to High(TTypBarCode) do begin
            E.TypBarCode := i;
            BI := E.GetBarcodeInfo;
            E.Height     := 70;

            E.Width      := E.MinWidth;

            L.Add('<BR><BR><BR><BR><TABLE cols=3 rules=NONE border=0 width="100%"><TR><TH colspan=3 color=yellow><H3>'
               +BI.Name+'</H3></TD></TR>');

            { here include information about barcode.}
            if BI.LongName<>'' then
               L.Add(Format(td_de,['Description',BI.LongName]));
            if BI.EnabledAdd then
               L.Add(Format(td_de,['Supplement','2 or 5 digits']));
            L.Add(Format(td_de,['Charset',E.GetSetOfCharsVisible]));

            if Integer(BI.ParentCode)<>0 then
               L.Add(Format(td_de,['Barcode family',BarcodeInfo(BI.ParentCode).Name]));
            if BI.Country<>'' then
               L.Add(Format(td_de,['Country',BI.Country]));
            if BI.Year>0 then
               L.Add(Format(td_de,['Year',IntToStr(BI.Year)]));

            fn:=E.BarcodeTypeName+ext;
            E.SaveToFile(Dir+'\'+fn);

            if BI.EnabledAdd then begin
                L.Add('<TR>');
                L.Add(Format(td_im1,[fn,E.Width,E.Height,BI.LongName]));
                s:=E.barcode;

                fn:=E.BarcodeTypeName+'_2'+ext;
                E.Barcode := s+' 12';
                E.Width := E.MinWidth;
                E.SaveToFile(Dir+'\'+fn);
                L.Add(Format(td_im1,[fn,E.Width,E.Height,BI.LongName]));

                fn:=E.BarcodeTypeName+'_5'+ext;
                E.Barcode := s+' 12345';
                E.Width := E.MinWidth;
                E.SaveToFile(Dir+'\'+fn);
                L.Add(Format(td_im1,[fn,E.Width,E.Height,BI.LongName]));
                L.Add('</TR>')
            end else
                L.Add(Format(td_im3,[fn,E.Width,E.Height,BI.LongName]));

            L.Add('</TABLE>');
        end;

        L.Add('<HR>');
        L.Add('<CENTER>&copy; PSOFT 1999, ');
        L.Add('<A HREF="mailto:psoft@ke.telecom.sk">Send EMail</A>');
        L.Add('</CENTER>');
        L.Add('</BODY></HTML>');
        L.SaveToFile(FileName);
     finally
        E.Free;
        L.Free;
     end;
end;


procedure   TCustomEAN.Assign(Value:TPersistent);
var V:TCustomEAN;
begin
         // inherited Assign(Value);
         V:=TCustomEan(Value);

         FAutoInc           := V.AutoInc;
         FAutoIncFrom       := V.AutoIncFrom;
         FAutoIncTo         := V.AutoIncTo;
         FBackgroundColor   := V.BackgroundColor;
         FTransparent       := V.Transparent;
         FShowLabels        := V.ShowLabels;
         FStartStopLines    := V.StartStopLines;
         FTypBarCode        := V.TypBarcode;
         FLinesColor        := V.Linescolor;
         FEan13AddUp        := V.Ean13AddUp;
         FFontAutoSize      := V.FontAutoSize;
         FSecurity          := V.Security;
         OnPaint            := V.OnPaint;
         OnChangeTypCode    := V.OnChangeTypCode;
         OnChangeBarCode    := V.OnChangeBarCode;
         FBarCode           := V.Barcode;
         FLabelMask         := V.LabelMask;
         FFirstCode         := V.FirstBarCode;
         FAngle             := V.Angle;
         FCaption.Assign(V.Caption);
         FCaptionBottom.Assign(V.CaptionBottom);
         FAutoSize          := V.AutoSize;
         FDisableEditor     := V.DisableEditor;

         HorzLines.Assign(V.HorzLines);
         HorzLines.LinesCount    := V.HorzLines.LinesCount;
         Invalidate;

end;

procedure   TCustomEAN.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
     inherited SetBounds(ALeft, ATop, AWidth, AHeight);
     if Assigned(FOnResize) then FOnResize(Self);
end;

function    TCustomEAN.BarcodeTypeName:String;
var P:PPropInfo;
begin
     P:= GetPropInfo(Self.ClassInfo,'TypBarCode');
     Result := GetEnumName(P^.PropType^,Integer(TypBarcode));
end;





function IsBookland(ISBN: String): Boolean;
var Number, CheckDigit        : String;
    CheckValue, CheckSum, Err : Integer;
    i, Cnt                    : Word;
begin
  {Get check digit}
  CheckDigit := Copy(ISBN, Length(ISBN), 1);

  {Get rest of ISBN, minus check digit and its hyphen}
  Number := Copy(ISBN, 1, Length(ISBN) - 2);
  {Length of ISBN remainder must be 11 and check digit between 9 and 9 or
   X}
  if (Length(Number) = 11) and (Pos(CheckDigit, '0123456789X') > 0) then
    begin

    {Get numeric value for check digit}
    if (CheckDigit = 'X') then
      CheckSum := 10
    else
      Val(CheckDigit, CheckSum, Err);
    {Iterate through ISBN remainder, applying decode algorithm}
    Cnt := 1;
    for i := 1 to 12 do begin
      {Act only if current character is between "0" and "9" to exclude
       hyphens}
      if (Pos(Number[i], '0123456789') > 0) then begin
        Val(Number[i], CheckValue, Err);
        {Algorithm for each character in ISBN remainder, Cnt is the nth

        character so processed}
        CheckSum := CheckSum + CheckValue * (11 - Cnt);
        Inc(Cnt);
      end;
    end;
    {Verify final value is evenly divisible by 11}
    Result := (CheckSum MOD 11 = 0);
  end
  else
    Result := False;
end;

procedure   TCustomEan.SetAutoCheckDigit(Value:Boolean);
begin
     if Value<>FAutoCheckDigit then begin
        FAutoCheckDigit := Value;
        Invalidate;
     end;
end;


procedure   TCustomEan.SetSetOfChars(Value:String);
begin
end;

{$ifdef PSOFT_PDF417}
constructor TpsPDF417.CreateEan(AOwner:TComponent);
begin
        inherited Create;
        Ean := AOwner as TCustomEan;

        FRows := 0;
        FCols := 10;
        FPaintIfSmall := True;
end;

procedure TpsPDF417.Invalidate;
begin
        Ean.Invalidate;
        if Assigned(FOnChange) then
           FOnChange(Self);
end;

procedure TpsPDF417.SetMode(Value:psPDF417Mode);
begin
        if FMode<>Value then begin
                FMode:=Value;
                Invalidate;
        end;
end;

procedure TpsPDF417.SetSecurityLevel(Value:psPDF417ErrorCorrection);
begin
        if FSecurityLevel<>Value then begin
                FSecurityLevel:=Value;
                Invalidate;
        end;
end;

procedure TpsPDF417.SetRows(Value:Integer);
begin
        if FRows<>Value then begin
                FRows:=Value;
                Invalidate;
        end;
end;

procedure TpsPDF417.SetCols(Value:Integer);
begin
        if FCols<>Value then begin
                FCols:=Value;
                Invalidate;
        end;
end;

procedure TpsPDF417.SetTruncated(Value:Boolean);
begin
        if FTruncated<>Value then begin
                FTruncated:=Value;
                Invalidate;
        end;
end;

procedure TpsPDF417.SetPaintIfSmall(Value:Boolean);
begin
        if FPaintIfSmall<>Value then begin
                FPaintIfSmall:=Value;
                Invalidate;
        end;
end;


{$endif}


initialization


end.

