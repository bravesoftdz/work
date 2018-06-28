unit LblEffct;

{
  This unit implements a label component with 3D effects.
  Written by Keith Wood - 27 May 1995.

  The label has a highlight and a shadow.  The colours of these
  can be controlled through properties as can their distance
  from the label and their direction.  There are also preset
  combinations of direction/distance and colours.

  The label can be set to operate as a button, ie. initially
  raised it will depress when clicked.

  The label can be rotated to any angle.

  Version 2.0 - 1 Feb 1996
      Added extrusion, keep letters vertical, graduated face and version.
  Version 2.1 - 14 Jun 1996
      Update to work with Delphi 2.0, fix bug with Transparent property,
      fix bug with Alignment property, prepare label offscreen and then display.

  Thanks to Paradox Informant and their starter article on 3D labels.
  Thanks to Bill Murto and his RotateLabel.
  Thanks to Curtis Keisler and his TxtRotat example.
}

interface

uses
  SysUtils, WinTypes, WinProcs, Classes, Graphics, Controls, StdCtrls;

type
  { Range of offsets for the shadows }
  TEffectDepth = 0..10;

  { Directions in which the offsets can be positioned }
  TEffectDirection = (edNone, edUp, edUpRight, edRight, edDownRight, edDown,
      edDownLeft, edLeft, edUpLeft);

  { Constants for specifying direction component }
  TDirXY = (drX, drY);

  { The preset styles of label effects available }
  TEffectStyle = (esNone, esCustom, esRaised, esSunken, esShadow, esFlying);

  { The preset colour schemes available }
  TColourScheme = (csCustom, csText, csWindows, csEmbossed, csGold, csSteel);

  { Constants for specifying positions of colours }
  TColourPosition = (cpHighlight, cpShadow, cpFace);

  { Range for rotation }
  TAngleRange = 0..360;

  { Options for varying the shadow/highlight for the label }
  TEffectOption = (eoNormal, eoReal, eoExtrude, eoGraduated);

  { Options for varying the face of the label }
  TGraduateOption = (goNone, goVertical, goHorizontal);

const
  { Offsets for drawing in the nominated directions }
  IOffsets: array [TEffectDirection, TDirXY] of -1..1 =
      ((0,0),(0,-1),(+1,-1),(+1,0),(+1,+1),(0,+1),(-1,+1),(-1,0),(-1,-1));

type

  TLabelEffect = class(TCustomLabel)
  private
    { Private declarations }
    FDepthHighlight,
    FDepthShadow: TEffectDepth;
    FDirectionHighlight,
    FDirectionShadow: TEffectDirection;
    FColourHighlight,
    FColourShadow: TColor;
    FGraduateFace: TGraduateOption;
    FGraduateFrom: TColor;
    FStyleHighlight,
    FStyleShadow: TEffectOption;
    FEffectStyle: TEffectStyle;
    FColourScheme: TColourScheme;
    FAsButton: Boolean;
    FAngle: TAngleRange;
    FKeepLettersVertical: Boolean;
    FVersion: String;
    BChangingStyle,                { Is preset style being invoked ? }
    BChangingScheme: Boolean;      { Is preset colour scheme being invoked ? }
    ClrSchemes: array [TColourScheme,TColourPosition] of TColor;
    DDegToRad, DCosAngle, DSinAngle, DCosSquared, DSinSquared: Double;
    procedure SetDepthHighlight(IDepth: TEffectDepth);
    procedure SetDepthShadow(IDepth: TEffectDepth);
    procedure SetDirectionHighlight(EdDirection: TEffectDirection);
    procedure SetDirectionShadow(EdDirection: TEffectDirection);
    procedure SetColourHighlight(ClrHighlight: TColor);
    procedure SetColourShadow(ClrShadow: TColor);
    procedure SetGraduateFace(GoGrad: TGraduateOption);
    procedure SetGraduateFrom(ClrGrad: TColor);
    procedure SetStyleHighlight(EoStyle: TEffectOption);
    procedure SetStyleShadow(EoStyle: TEffectOption);
    procedure SetEffectStyle(EsStyle: TEffectStyle);
    procedure SetColourScheme(CsScheme: TColourScheme);
    procedure SetAsButton(BBtn: Boolean);
    procedure SetAngle(AAngle: TAngleRange);
    procedure SetTextAngle(Cnv: TCanvas; AAngle: TAngleRange);
    procedure SetKeepLettersVertical(BKeep: Boolean);

  protected
    { Protected declarations }
    procedure Paint; override;
    procedure MouseDown(MbBtn: TMouseButton; SsShift: TShiftState;
        X, Y: Integer); override;
    procedure MouseMove(SsShift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(MbBtn: TMouseButton; SsShift: TShiftState;
        X, Y: Integer); override;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    property Version: String read FVersion;         { Read-only }

  published
    { Publish specialised properties }
    property DepthHighlight: TEffectDepth read FDepthHighlight
        write SetDepthHighlight default 1;
    property DepthShadow: TEffectDepth read FDepthShadow
        write SetDepthShadow default 1;
    property DirectionHighlight: TEffectDirection read FDirectionHighlight
        write SetDirectionHighlight default edUpLeft;
    property DirectionShadow: TEffectDirection read FDirectionShadow
        write SetDirectionShadow default edDownRight;
    property ColourHighlight: TColor read FColourHighlight
        write SetColourHighlight default clWhite;
    property ColourShadow: TColor read FColourShadow
        write SetColourShadow default clBlack;
    property GraduateFace: TGraduateOption read FGraduateFace
        write SetGraduateFace default goNone;
    property GraduateFrom: TColor read FGraduateFrom
        write SetGraduateFrom default clGray;
    property StyleHighlight: TEffectOption read FStyleHighlight
        write SetStyleHighlight default eoNormal;
    property StyleShadow: TEffectOption read FStyleShadow
        write SetStyleShadow default eoNormal;
    property EffectStyle: TEffectStyle read FEffectStyle
        write SetEffectStyle default esRaised;
    property ColourScheme: TColourScheme read FColourScheme
        write SetColourScheme default csWindows;
    property AsButton: Boolean read FAsButton write SetAsButton default False;
    property Angle: TAngleRange read FAngle write SetAngle default 0;
    property KeepLettersVertical: Boolean read FKeepLettersVertical
        write SetKeepLettersVertical default False;

    { Publish inherited properties }
    property Align;
    property Alignment;
    property Caption;
    property Color;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property ShowAccelChar;
    property ShowHint;
    property Transparent default True;
    property Visible;
    property WordWrap;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

const
  LabelEffectVersion = '2.1';

procedure Register;
begin
  RegisterComponents('NewPower', [TLabelEffect]);
end;

constructor TLabelEffect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  { Colour schemes cannot be constant since Custom version varies }
  ClrSchemes[csText,cpHighlight] := clWhite;
  ClrSchemes[csText,cpFace] := clBlack;
  ClrSchemes[csText,cpShadow] := clGray;

  ClrSchemes[csWindows,cpHighlight] := clWhite;
  ClrSchemes[csWindows,cpFace] := clGray;
  ClrSchemes[csWindows,cpShadow] := clBlack;

  ClrSchemes[csEmbossed,cpHighlight] := clWhite;
  ClrSchemes[csEmbossed,cpFace] := clSilver;
  ClrSchemes[csEmbossed,cpShadow] := clBlack;

  ClrSchemes[csGold,cpHighlight] := clYellow;
  ClrSchemes[csGold,cpFace] := clOlive;
  ClrSchemes[csGold,cpShadow] := clBlack;

  ClrSchemes[csSteel,cpHighlight] := clAqua;
  ClrSchemes[csSteel,cpFace] := clTeal;
  ClrSchemes[csSteel,cpShadow] := clNavy;

  ClrSchemes[csCustom,cpHighlight] := ClrSchemes[csWindows,cpHighlight];
  ClrSchemes[csCustom,cpFace] := ClrSchemes[csWindows,cpFace];
  ClrSchemes[csCustom,cpShadow] := ClrSchemes[csWindows,cpShadow];

  { Initialise default values for internal fields }
  FDepthHighlight := 1;
  FDepthShadow := 1;
  FDirectionHighlight := edUpLeft;
  FDirectionShadow := edDownRight;
  FStyleHighlight := eoNormal;
  FStyleShadow := eoNormal;
  FEffectStyle := esRaised;
  FColourScheme := csWindows;
  FColourHighlight := ClrSchemes[FColourScheme,cpHighlight];
  FColourShadow := ClrSchemes[FColourScheme,cpShadow];
  FGraduateFace := goNone;
  FGraduateFrom := Font.Color;
  FAsButton := False;
  FAngle := 0;
  FKeepLettersVertical := False;
  FVersion := LabelEffectVersion;

  BChangingStyle := False;
  BChangingScheme := False;
  DDegToRad := PI / 180;
  DCosAngle := 1;         { Cos(FAngle * DDegToRad) }
  DCosSquared := 1;
  DSinAngle := 0;         { Sin(FAngle * DDegToRad) }
  DSinSquared := 0;

  AutoSize := False;
  Height := 33;
  Width := 142;
  Transparent := True;
  Font.Color := ClrSchemes[FColourScheme,cpFace];
  Font.Name := 'Times New Roman';
  Font.Size := 20;
end;

procedure TLabelEffect.SetDepthHighlight(IDepth: TEffectDepth);
begin
  if FDepthHighlight <> IDepth then
  begin
    FDepthHighlight := IDepth;
    if not BChangingStyle then  { Default to custom style when changed }
      SetEffectStyle(esCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetDepthShadow(IDepth: TEffectDepth);
begin
  if FDepthShadow <> IDepth then
  begin
    FDepthShadow := IDepth;
    if not BChangingStyle then  { Default to custom style when changed }
      SetEffectStyle(esCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetDirectionHighlight(EdDirection: TEffectDirection);
begin
  if FDirectionHighlight <> EdDirection then
  begin
    FDirectionHighlight := EdDirection;
    if not BChangingStyle then  { Default to custom style when changed }
      SetEffectStyle(esCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetDirectionShadow(EdDirection: TEffectDirection);
begin
  if FDirectionShadow <> EdDirection then
  begin
    FDirectionShadow := EdDirection;
    if not BChangingStyle then  { Default to custom style when changed }
      SetEffectStyle(esCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetColourHighlight(ClrHighlight: TColor);
begin
  if FColourHighlight <> ClrHighlight then
  begin
    FColourHighlight := ClrHighlight;
    ClrSchemes[csCustom,cpHighlight] := ClrHighlight;
    if not BChangingScheme then  { Default to custom colour scheme when changed }
      SetColourScheme(csCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetColourShadow(ClrShadow: TColor);
begin
  if FColourShadow <> ClrShadow then
  begin
    FColourShadow := ClrShadow;
    ClrSchemes[csCustom,cpShadow] := ClrShadow;
    if not BChangingScheme then  { Default to custom colour scheme when changed }
      SetColourScheme(csCustom);
    Invalidate;
  end;
end;

procedure TLabelEffect.SetGraduateFace(GoGrad: TGraduateOption);
begin
  if FGraduateFace <> GoGrad then
  begin
    FGraduateFace := GoGrad;
    Invalidate;
  end;
end;

procedure TLabelEffect.SetGraduateFrom(ClrGrad: TColor);
begin
  if FGraduateFrom <> ClrGrad then
  begin
    FGraduateFrom := ClrGrad;
    if GraduateFace <> goNone then  { Only has effect if GraduateFace is not goNone }
      Invalidate;
  end;
end;

procedure TLabelEffect.SetStyleHighlight(EoStyle: TEffectOption);
begin
  if FStyleHighlight <> EoStyle then
  begin
    FStyleHighlight := EoStyle;
    Invalidate;
  end;
end;

procedure TLabelEffect.SetStyleShadow(EoStyle: TEffectOption);
begin
  if FStyleShadow <> EoStyle then
  begin
    FStyleShadow := EoStyle;
    Invalidate;
  end;
end;

procedure TLabelEffect.SetEffectStyle(EsStyle: TEffectStyle);
begin
  if FEffectStyle <> EsStyle then
  begin
    BChangingStyle := True;   { So it doesn't reset to custom }
    BChangingScheme := True;  {          "                    }
    FEffectStyle := EsStyle;
    SetColourHighlight(ClrSchemes[ColourScheme,cpHighlight]);
    case FEffectStyle of
    esRaised:
      begin
        SetDirectionHighlight(edUpLeft);
        SetDirectionShadow(edDownRight);
        SetDepthHighlight(1);
        SetDepthShadow(1);
      end;
    esSunken:
      begin
        SetDirectionHighlight(edDownRight);
        SetDirectionShadow(edUpLeft);
        SetDepthHighlight(1);
        SetDepthShadow(1);
      end;
    esShadow:
      begin
        SetDirectionHighlight(edNone);
        SetDirectionShadow(edDownRight);
        SetDepthHighlight(0);
        SetDepthShadow(2);
        SetAsButton(False);
      end;
    esFlying:
      begin
        SetDirectionHighlight(edDownRight);
        SetDirectionShadow(edDownRight);
        SetDepthHighlight(1);
        SetDepthShadow(5);
        SetColourHighlight(ClrSchemes[ColourScheme,cpShadow]);  { Flying has two shadows }
        SetAsButton(False);
      end;
    esNone:
      begin
        SetDirectionHighlight(edNone);
        SetDirectionShadow(edNone);
        SetDepthHighlight(0);
        SetDepthShadow(0);
        SetAsButton(False);
      end;
    else
      SetAsButton(False);
    end;
    BChangingStyle := False;   { So further changes set style to custom }
    BChangingScheme := False;  { So further changes set colour scheme to custom }
  end;
end;

procedure TLabelEffect.SetColourScheme(CsScheme: TColourScheme);
begin
  if FColourScheme <> CsScheme then
  begin
    BChangingScheme := True;  { So it doesn't reset to custom }
    FColourScheme := CsScheme;
    SetColourHighlight(ClrSchemes[FColourScheme,cpHighlight]);
    Font.Color := ClrSchemes[FColourScheme,cpFace];
    SetColourShadow(ClrSchemes[FColourScheme,cpShadow]);
    if FColourScheme <> csCustom then  { Save for future reference }
    begin
      ClrSchemes[csCustom,cpHighlight] := ClrSchemes[FColourScheme,cpHighlight];
      ClrSchemes[csCustom,cpFace] := ClrSchemes[FColourScheme,cpFace];
      ClrSchemes[csCustom,cpShadow] := ClrSchemes[FColourScheme,cpShadow];
    end;
    BChangingScheme := False;  { So further changes set colour scheme to custom }
  end;
end;

procedure TLabelEffect.SetAsButton(BBtn: Boolean);
begin
  if FAsButton <> BBtn then
  begin
    FAsButton := BBtn;
    if BBtn then    { If not already raised, raise it }
      SetEffectStyle(esRaised);
  end;
end;

procedure TLabelEffect.SetAngle(AAngle: TAngleRange);
begin
  if FAngle <> AAngle then
  begin
    FAngle := AAngle;
    DCosAngle := Cos(FAngle * DDegToRad);  { Calculate values for later use }
    DCosSquared := DCosAngle * DCosAngle;
    DSinAngle := Sin(FAngle * DDegToRad);
    DSinSquared := DSinAngle * DSinAngle;
    if FAngle <> 0 then Alignment := taLeftJustify;  { Cannot align when rotated }
    Invalidate;
  end;
end;

procedure TLabelEffect.SetKeepLettersVertical(BKeep: Boolean);
begin
  if FKeepLettersVertical <> BKeep then
  begin
    FKeepLettersVertical := BKeep;
    if Angle <> 0 then     { Only has effect if Angle is non-zero }
      Invalidate;
  end;
end;

function Min(I, J: Integer): Integer;
begin
  if I < J then Result := I else Result := J;
end;

function Max(I, J: Integer): Integer;
begin
  if I > J then Result := I else Result := J;
end;

procedure GetRGB(Clr: TColor; var IR, IG, IB: Byte);
begin
  IR := GetRValue(Clr);
  IG := GetGValue(Clr);
  IB := GetBValue(Clr);
end;

procedure TLabelEffect.SetTextAngle(Cnv: TCanvas; AAngle: TAngleRange);
var
  FntLogRec: TLogFont;    { Storage area for font information }
begin
  { Get the current font information. We only want to modify the angle }
  GetObject(Cnv.Font.Handle, SizeOf(FntLogRec), Addr(FntLogRec));

  { Modify the angle. "The angle, in tenths of a degrees, between the base
     line of a character and the x-axis." (Windows API Help file.)}
  FntLogRec.lfEscapement := AAngle * 10;
  FntLogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;  { Request TrueType precision }

  { Delphi will handle the deallocation of the old font handle }
  Cnv.Font.Handle := CreateFontIndirect(FntLogRec);
end;

procedure TLabelEffect.Paint;
const
  WAlignments: array [TAlignment] of word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  IMinOffset, IMaxOffset: Integer;
  RctTemp, RctFirst, RctLast: TRect;
  StrText: array [0..255] of char;
  I, IMid, IH, IW, IX, IY, IU, IV, ILimit, IL, ILen: Integer;
  I1, I2, I3, I4, IAdj: Integer;
  P1, P2, P3, P4, P5, P6, P7, P8: TPoint;
  IFromR, IFromG, IFromB, IToR, IToG, IToB: Byte;
  RAdjustR, RAdjustG, RAdjustB: Real;
  BmpTemp, BmpWork: TBitmap;
  CnvWork: TCanvas;
begin
  { Find minimum and maximum of all offsets (including font itself) }
  IMinOffset := Min(Min(Min(Min(IOffsets[DirectionHighlight, drX] * DepthHighlight,
                IOffsets[DirectionShadow, drX] * DepthShadow),
                IOffsets[DirectionHighlight, drY] * DepthHighlight),
                IOffsets[DirectionShadow, drY] * DepthShadow), 0);
  IMaxOffset := Max(Max(Max(Max(IOffsets[DirectionHighlight, drX] * DepthHighlight,
                IOffsets[DirectionShadow, drX] * DepthShadow),
                IOffsets[DirectionHighlight, drY] * DepthHighlight),
                IOffsets[DirectionShadow, drY] * DepthShadow), 0);
  ILen := Length(Caption);
  case Alignment of
    taLeftJustify:  IAdj := 0;
    taCenter:       IAdj := (IMaxOffset - IMinOffset) div 2;
    taRightJustify: IAdj := IMaxOffset - IMinOffset;
  end;

  { Create temporary drawing surfaces }
  BmpTemp := TBitmap.Create;
  BmpWork := TBitmap.Create;

  try
    BmpTemp.Height := Self.Height;                    { Same size as original }
    BmpTemp.Width := Self.Width;
    BmpTemp.Canvas.Font := Self.Font;                 { Ensure canvas font is set }
    BmpWork.Height := Self.Height;                    { Same size as original }
    BmpWork.Width := Self.Width;
    BmpWork.Canvas.Font := Self.Font;                 { Ensure canvas font is set }
    BmpWork.Canvas.CopyRect(Self.ClientRect, Self.Canvas, Self.ClientRect);
    if (Angle <> 0) and not KeepLettersVertical then  { Need to generate an angled font }
    begin
      SetTextAngle(BmpTemp.Canvas, Angle);
      SetTextAngle(BmpWork.Canvas, Angle);
    end;

    with BmpWork.Canvas do
    begin
      { Set starting point for text - IX, IY }
      if Angle = 0 then
      begin
        IX := 0; IY := 0;
      end
      else if KeepLettersVertical then
      begin
        IH := Round((TextHeight(Caption) * (ILen - 1) * DSinSquared) +
          (TextWidth(Copy(Caption, 1, ILen - 1)) * DCosSquared));
        IX := Max(0, - Round(IH * DCosAngle)) + 10;
        IY := Max(0, Round(IH * DSinAngle)) + 10;
        IL := IMaxOffset - IMinOffset + 4;
        { Find rectangles surrounding first and last characters }
        RctFirst := Bounds(IX - 2, IY - 2,
          TextWidth(Copy(Caption, 1, 1)) + IL, TextHeight(Caption) + IL);
        RctLast := Bounds(IX - 2 + Round(IH * DCosAngle), IY - 2 - Round(IH * DSinAngle),
          TextWidth(Copy(Caption, ILen, 1)) + IL, TextHeight(Caption) + IL);
      end
      else
      begin
        IW := TextWidth(Caption);
        IH := TextHeight(Caption);
        IMid := TextWidth(Caption+'   ') div 2;
        IX := IMid - Trunc(IW / 2 * DCosAngle) - Trunc(IH / 2 * DSinAngle);
        IY := IMid + Trunc(IW / 2 * DSinAngle) - Trunc(IH / 2 * DCosAngle);

        IMid := IMid + (IMaxOffset - IMinOffset + 4) div 2;
        IW := IW + IMaxOffset + IMinOffset + 4;
        IH := IH + IMaxOffset + IMinOffset + 4;
        I1 := Trunc(IW / 2 * DCosAngle);
        I2 := Trunc(IH / 2 * DSinAngle);
        I3 := Trunc(IW / 2 * DSinAngle);
        I4 := Trunc(IH / 2 * DCosAngle);
        P1 := Point(IMid - I1 - I2 + 2, IMid + I3 - I4 + 2);
        P2 := Point(IMid + I1 - I2 + 2, IMid - I3 - I4 + 2);
        P3 := Point(IMid + I1 + I2 + 2, IMid - I3 + I4 + 2);
        P4 := Point(IMid - I1 + I2 + 2, IMid + I3 + I4 + 2);
      end;

      if not Transparent then                { Fill in background }
      begin
        Brush.Color := Self.Color;
        Brush.Style := bsSolid;
        if Angle = 0 then
          FillRect(ClientRect)               { Original label canvas }
        else if KeepLettersVertical then
        begin                                { Calculate enclosing polygon }
          P1 := Point(RctFirst.Left, RctFirst.Top);
          P2 := Point(RctFirst.Left, RctFirst.Bottom);
          P3 := Point(RctFirst.Right, RctFirst.Top);
          P4 := Point(RctFirst.Right, RctFirst.Bottom);
          P5 := Point(RctLast.Left, RctLast.Top);
          P6 := Point(RctLast.Left, RctLast.Bottom);
          P7 := Point(RctLast.Right, RctLast.Top);
          P8 := Point(RctLast.Right, RctLast.Bottom);
          case Angle of
          1..90    : Polygon([P1, P5, P7, P8, P4, P2]);
          91..180  : Polygon([P3, P7, P5, P6, P2, P4]);
          181..270 : Polygon([P1, P5, P6, P8, P4, P3]);
          271..360 : Polygon([P3, P7, P8, P6, P2, P1]);
          end;
        end
        else
          Polygon([P1, P2, P3, P4]);
      end;
      Brush.Style := bsClear;         { Don't overwrite background above }
    end;

    GetTextBuf(StrText, SizeOf(StrText));  { Get label's caption }

    { Prepare for extruding shadow, if requested }
    GetRGB(ColourShadow, IFromR, IFromG, IFromB);
    RAdjustR := 0; RAdjustG := 0; RAdjustB := 0;
    ILimit := DepthShadow;
    if StyleShadow = eoReal then
      GetRGB(clBlack, IFromR, IFromG, IFromB)
    else if (StyleShadow <> eoNormal) and (DepthShadow > 1) then
    begin
      ILimit := 1;
      if StyleShadow = eoGraduated then  { Find changes in RGB colours }
      begin
        GetRGB(Font.Color, IToR, IToG, IToB);
        RAdjustR := (IToR - IFromR) / (DepthShadow - 1);
        RAdjustG := (IToG - IFromG) / (DepthShadow - 1);
        RAdjustB := (IToB - IFromB) / (DepthShadow - 1);
      end;
    end;

    if StyleShadow = eoReal then  { Work on copy then transfer }
      CnvWork := BmpTemp.Canvas
    else                           { Work directly on label's canvas }
      CnvWork := BmpWork.Canvas;

    { Process for each copy of the shadow - several if extruding }
    for I := DepthShadow downto ILimit do
    begin
      CnvWork.Font.Color :=
        RGB(IFromR + Round(RAdjustR * (DepthShadow - I)),
            IFromG + Round(RAdjustG * (DepthShadow - I)),
            IFromB + Round(RAdjustB * (DepthShadow - I)));
      if Angle = 0 then
      begin
        { Create a rect that is offset for the shadow }
        RctTemp:= Rect(
          Self.ClientRect.Left - IMinOffset -IAdj + IOffsets[DirectionShadow, drX] * I,
          Self.ClientRect.Top - IMinOffset + IOffsets[DirectionShadow, drY] * I,
          Self.ClientRect.Right - IMinOffset - IAdj + IOffsets[DirectionShadow, drX] * I,
          Self.ClientRect.Bottom - IMinOffset + IOffsets[DirectionShadow, drY] * I);
        { Draw shadow text with alignment }
        DrawText(CnvWork.Handle, StrText, StrLen(StrText), RctTemp,
            DT_EXPANDTABS or DT_WORDBREAK or WAlignments[Alignment]);
      end
      else if KeepLettersVertical then
        for IL := 1 to ILen do  { For each character }
        begin
          IW := 0; IH := 0;
          if IL > 1 then  { Position based on substring length and height }
          begin
            IH := Round((CnvWork.TextHeight(Caption) * (IL - 1) * DSinSquared) +
              (CnvWork.TextWidth(Copy(Caption, 1, IL - 1)) * DCosSquared));
            IW := Round(IH * DCosAngle);
            IH := Round(IH * DSinAngle);
          end;
          CnvWork.TextOut(IX - IMinOffset + IW + IOffsets[DirectionShadow, drX] * I,
            IY - IMinOffset - IH + IOffsets[DirectionShadow, drY] * I,
            Copy(Caption, IL, 1));
        end
      else
        { Draw angled shadow text without alignment }
        CnvWork.TextOut(IX - IMinOffset + IOffsets[DirectionShadow, drX] * I,
          IY - IMinOffset + IOffsets[DirectionShadow, drY] * I, Caption);
    end;

    if StyleShadow = eoReal then       { Real/transparent shadow }
    begin
      for IU := 0 to Width do
        for IV := 0 to Height do
          if BmpTemp.Canvas.Pixels[IU, IV] = clBlack then
          begin    { Make halfway to black }
            GetRGB(BmpWork.Canvas.Pixels[IU, IV], IToR, IToG, IToB);
            BmpWork.Canvas.Pixels[IU, IV] := RGB(IToR div 2, IToG div 2, IToB div 2);
          end;
    end;

    { Prepare for extruding highlight, if requested }
    GetRGB(ColourHighlight, IFromR, IFromG, IFromB);
    RAdjustR := 0; RAdjustG := 0; RAdjustB := 0;
    ILimit := DepthHighlight;
    if StyleHighlight = eoReal then
      GetRGB(clBlack, IFromR, IFromG, IFromB)
    else if (StyleHighlight <> eoNormal) and (DepthHighlight > 1) then
    begin
      ILimit := 1;
      if StyleHighlight = eoGraduated then  { Find changes in RGB colours }
      begin
        GetRGB(Font.Color, IToR, IToG, IToB);
        RAdjustR := (IToR - IFromR) / (DepthHighlight - 1);
        RAdjustG := (IToG - IFromG) / (DepthHighlight - 1);
        RAdjustB := (IToB - IFromB) / (DepthHighlight - 1);
      end;
    end;

    if StyleHighlight = eoReal then  { Work on copy then transfer }
    begin
      BmpTemp.Canvas.FillRect(ClientRect);
      CnvWork := BmpTemp.Canvas;
    end
    else                              { Work directly on label's canvas }
      CnvWork := BmpWork.Canvas;

    { Process for each copy of the highlight - several if extruding }
    for I := DepthHighlight downto ILimit do
    begin
      CnvWork.Font.Color :=
        RGB(IFromR + Round(RAdjustR * (DepthHighlight - I)),
            IFromG + Round(RAdjustG * (DepthHighlight - I)),
            IFromB + Round(RAdjustB * (DepthHighlight - I)));
      if Angle = 0 then
      begin
        { Create a rect that is offset for the highlight }
        RctTemp:= Rect(
          Self.ClientRect.Left - IMinOffset - IAdj + IOffsets[DirectionHighlight, drX] * I,
          Self.ClientRect.Top - IMinOffset + IOffsets[DirectionHighlight, drY] * I,
          Self.ClientRect.Right - IMinOffset - IAdj + IOffsets[DirectionHighlight, drX] * I,
          Self.ClientRect.Bottom - IMinOffset + IOffsets[DirectionHighlight, drY] * I);
        { Draw highlight text with alignment }
        DrawText(CnvWork.Handle, StrText, StrLen(StrText), RctTemp,
            DT_EXPANDTABS or DT_WORDBREAK or WAlignments[Alignment]);
      end
      else if KeepLettersVertical then
        for IL := 1 to ILen do  { For each character }
        begin
          IW := 0; IH := 0;
          if IL > 1 then  { Position based on substring length and height }
          begin
            IH := Round((CnvWork.TextHeight(Caption) * (IL - 1) * DSinSquared) +
              (CnvWork.TextWidth(Copy(Caption, 1, IL - 1)) * DCosSquared));
            IW := Round(IH * DCosAngle);
            IH := Round(IH * DSinAngle);
          end;
          CnvWork.TextOut(IX - IMinOffset + IW + IOffsets[DirectionHighlight, drX] * I,
            IY - IMinOffset - IH + IOffsets[DirectionHighlight, drY] * I,
            Copy(Caption, IL, 1));
        end
      else
        { Draw angled highlight text without alignment }
        CnvWork.TextOut(IX - IMinOffset + IOffsets[DirectionHighlight, drX] * I,
          IY - IMinOffset + IOffsets[DirectionHighlight, drY] * I, Caption);
    end;

    if StyleHighlight = eoReal then    { Real/transparent highlight }
    begin
      for IU := 0 to Width do
        for IV := 0 to Height do
          if BmpTemp.Canvas.Pixels[IU, IV] = clBlack then
          begin    { Make halfway to white }
            GetRGB(BmpWork.Canvas.Pixels[IU, IV], IToR, IToG, IToB);
            BmpWork.Canvas.Pixels[IU, IV] :=
              RGB((255 + IToR) div 2, (255 + IToG) div 2, (255 + IToB) div 2);
          end;
    end;

    if GraduateFace <> goNone then
    begin
      { Copy original canvas to work area }
      BmpTemp.Canvas.CopyRect(Self.ClientRect, BmpWork.Canvas, Self.ClientRect);
      { Choose an unusual colour }
      BmpTemp.Canvas.Font.Color := $00FE09F1;
      BmpTemp.Canvas.Brush.Style := bsClear;
      CnvWork := BmpTemp.Canvas;
    end
    else
    begin
      BmpWork.Canvas.Font.Color := Font.Color;  { Restore original font colour }
      CnvWork := BmpWork.Canvas;
    end;

    if Angle = 0 then
    begin
      { Create a rect that is offset for the original text }
      RctTemp:= Rect(Self.ClientRect.Left - IMinOffset - IAdj,
                     Self.ClientRect.Top - IMinOffset,
                     Self.ClientRect.Right - IMinOffset - IAdj,
                     Self.ClientRect.Bottom - IMinOffset);
      { Draw original text with alignment }
      DrawText(CnvWork.Handle, StrText, StrLen(StrText), RctTemp,
          DT_EXPANDTABS or DT_WORDBREAK or WAlignments[Alignment]);
    end
    else if KeepLettersVertical then
      for IL := 1 to ILen do  { For each character }
      begin
        IW := 0; IH := 0;
        if IL > 1 then  { Position based on substring length and height }
        begin
          IH := Round((CnvWork.TextHeight(Caption) * (IL - 1) * DSinSquared) +
            (CnvWork.TextWidth(Copy(Caption, 1, IL - 1)) * DCosSquared));
          IW := Round(IH * DCosAngle);
          IH := Round(IH * DSinAngle);
        end;
        CnvWork.TextOut(IX - IMinOffset + IW, IY - IMinOffset - IH, Copy(Caption, IL, 1));
      end
    else
      { Draw angled original text without alignment }
      CnvWork.TextOut(IX - IMinOffset, IY - IMinOffset, Caption);

    if GraduateFace <> goNone then    { Transfer graduations from temporary canvas }
    begin                             { Calculate start point and extent }
      if Angle = 0 then
      begin
        ILimit := BmpWork.Canvas.TextWidth(Caption);
        IV := IY - IMinOffset;
        case Alignment of
          taLeftJustify:  IU := IX - IMinOffset;
          taCenter:       IU := (Self.Width - ILimit) div 2 - IMinOffset - IAdj;
          taRightJustify: IU := Self.Width - IMaxOffset - ILimit;
        end;
        if GraduateFace = goVertical then
          ILimit := BmpWork.Canvas.TextHeight(Caption) - 1
        else
          ILimit := ILimit - 1;
      end
      else if KeepLettersVertical then
      begin
        IU := Min(RctFirst.Left, RctLast.Left);
        IV := Min(RctFirst.Top, RctLast.Top);
        if GraduateFace = goVertical then
          ILimit := Max(RctFirst.Bottom, RctLast.Bottom) - IV
        else
          ILimit := Max(RctFirst.Right, RctLast.Right) - IU;
      end
      else
      begin
        IU := Min(Min(Min(P1.X, P2.X), P3.X), P4.X);
        IV := Min(Min(Min(P1.Y, P2.Y), P3.Y), P4.Y);
        if GraduateFace = goVertical then
          ILimit := Max(Max(Max(P1.Y, P2.Y), P3.Y), P4.Y) - IV
        else
          ILimit := Max(Max(Max(P1.X, P2.X), P3.X), P4.X) - IU;
      end;

      { Calculate change in colour at each step }
      GetRGB(GraduateFrom, IFromR, IFromG, IFromB);
      GetRGB(Font.Color, IToR, IToG, IToB);
      RAdjustR := (IToR - IFromR) / ILimit;
      RAdjustG := (IToG - IFromG) / ILimit;
      RAdjustB := (IToB - IFromB) / ILimit;

      { And draw it onto the canvas }
      BmpWork.Canvas.Brush.Style := bsSolid;
      for I := 0 to ILimit do
      begin
        BmpWork.Canvas.Brush.Color := RGB(IFromR + Round(RAdjustR * I),
          IFromG + Round(RAdjustG * I), IFromB + Round(RAdjustB * I));
        if GraduateFace = goVertical then
          RctTemp := Rect(0, IV + I, Width, IV + I + 1)
        else
          RctTemp := Rect(IU + I, 0, IU + I + 1, Height);
        BmpWork.Canvas.BrushCopy(RctTemp, BmpTemp, RctTemp, BmpTemp.Canvas.Font.Color);
      end;
    end;

    Self.Canvas.CopyRect(Self.ClientRect, BmpWork.Canvas, Self.ClientRect);
  finally
    BmpTemp.Free;
    BmpWork.Free;
  end;
end;

procedure TLabelEffect.MouseDown(MbBtn: TMouseButton; SsShift: TShiftState;
    X, Y: Integer);
begin
  if AsButton then
  begin    { If left button and label isn't sunken }
    if (MbBtn = mbLeft) and (EffectStyle <> esSunken) and Enabled then
      SetEffectStyle(esSunken);
  end
  else
    inherited MouseDown(MbBtn, SsShift, X, Y);
end;

procedure TLabelEffect.MouseMove(SsShift: TShiftState; X, Y: Integer);
begin
  if AsButton then
  begin
    if SsShift = [ssLeft] then  { Left mouse button down }
    begin                       { If within label's client area }
      if  (X >= 0) and (X <= ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
        SetEffectStyle(esSunken)
      else
        SetEffectStyle(esRaised);
    end;
  end
  else
    inherited MouseMove(SsShift, X, Y);
end;

procedure TLabelEffect.MouseUp(MbBtn: TMouseButton; SsShift: TShiftState;
    X, Y: Integer);
begin
  if AsButton then
  begin    { If within label's client area }
    if (X >= 0) and (X <= ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      SetEffectStyle(esRaised);
  end
  else
    inherited MouseUp(MbBtn, SsShift, X, Y);
end;

end.
