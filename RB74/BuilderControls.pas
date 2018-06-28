{

Copyright (c) 1999 by Artem A. Berman

}

{$D+,L+,Y+}
unit BuilderControls;

{$R BuilderControls}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppCache, ppPrnabl, ppClass, ppCtrls, ppDevice, ppDB, ppDrwCmd,
  ppDsgnCt, ppUtils, ppPrintr, ppTypes, ppPrnDev, ppViewr, Math;

type
  {TDrawRotatedText}
  TDrawRotatedText = class(TppDrawText)
  private
    FAngle: Cardinal;
    FOrigin: TPoint;
    function CalcRect(ACanvas: TCanvas; MaxWidth: Integer; const AText: string): TRect;
    function CalcClientRect(Canvas: TCanvas; Angle: Integer; ARect: TRect; var APoint: TPoint): TRect;  public
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Draw(aDevice: TppDevice): Boolean; override;

    property Angle: Cardinal read FAngle write FAngle default 0;
    property Origin: TPoint read FOrigin write FOrigin;
  end;

  {TRotatedLabel}
  TRotatedLabel = class(TppCustomText)
  private
    FAngle: Cardinal;
    FOrigin: TPoint;
    procedure SetAngle(Value: Cardinal);
    function CalcRect(ACanvas: TCanvas; MaxWidth: Integer; const AText: string): TRect;
    function CalcClientRect(Canvas: TCanvas; Angle: Integer; ARect: TRect; var APoint: TPoint): TRect;
    procedure AngleMenuClick(Sender: TObject);
  protected
    property Alignment;
    property WordWrap;

    function GetDefaultPropHint: string; override;
    procedure SetUserName(const Value: TComponentName); override;
    procedure AdjustBounds; override;
    procedure BoundsChange; override;
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
    procedure PaintDesignControl(aCanvas: TCanvas); override;
    procedure Loaded; override;
    procedure CreatePopupMenu(aOwner: TComponent; var aPopupMenu: TppPopupMenu); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PopupMenuClick(Sender: TObject); override;
  published
    property Angle: Cardinal read FAngle write SetAngle default 0;

    property AutoSize;
    property Caption;
    property Color;
    property Font;
    property OnDrawCommandClick;
    property OnDrawCommandCreate;
    property Transparent;
    property UserName;
    property Visible;

    {these properties saved in 'fake' properties}
    property Height stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;
  end;

  {TDrawSimpleGrid}
  TDrawSimpleGrid = class(TppDrawCommand)
  private
    FColCount,
    FRowCount: Integer;
    FBrush: TBrush;
    FPen: TPen;
    FTransparent: Boolean;
    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Draw(aDevice: TppDevice): Boolean; override;

    property DataType default dtGraphic;
    property ColCount: Integer read FColCount write FColCount default 1;
    property RowCount: Integer read FRowCount write FRowCount default 1;
    property Brush: TBrush read FBrush write SetBrush;
    property Pen: TPen read FPen write SetPen;
    property Transparent: Boolean read FTransparent write FTransparent;
  end;

  {TSimpleGrid}
  TSimpleGrid = class(TppCustomGraphic)
  private
    FColCount,
    FRowCount: Integer;

    procedure CalcDimensions(var aLeft, aTop, aRight, aBottom: Longint);
    procedure SetColCount(Value: Integer);
    procedure SetRowCount(Value: Integer);
    procedure ColCountClick(Sender: TObject);
    procedure RowCountClick(Sender: TObject);
  protected
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
    procedure PaintDesignControl(aCanvas: TCanvas); override;
    procedure CreatePopupMenu(aOwner: TComponent; var aPopupMenu: TppPopupMenu); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PopupMenuClick(Sender: TObject); override;
  published
    property ColCount: Integer read FColCount write SetColCount default 1;
    property RowCount: Integer read FRowCount write SetRowCount default 1;

    property Brush;
    property Pen;
    property Transparent;
    property UserName;
    property Visible;

    {these properties saved in 'fake' properties}
    property Height stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;
  end;

implementation

function CheckTTFont(FontName: string): Boolean;
var
  DC: HDC;
  Font: TFont;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    Font := TFont.Create;
    try
      Font.Name := FontName;
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      Result := (Metrics.tmPitchandFamily and TMPF_TRUETYPE) <> 0;
    finally
      Font.Free;
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

{TDrawRotatedText}
constructor TDrawRotatedText.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FAngle := 0;
  FOrigin := Point(0, 0);
end;

destructor TDrawRotatedText.Destroy;
begin
  inherited Destroy;
end;

function TDrawRotatedText.CalcRect(ACanvas: TCanvas; MaxWidth: Integer; const AText: string): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(ACanvas.Handle, PChar(AText), -1, Result, DT_EXPANDTABS or DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
end;

function TDrawRotatedText.CalcClientRect(Canvas: TCanvas; Angle: Integer; ARect: TRect; var APoint: TPoint): TRect;
type
  TVector = record
    x: Real;
    y: Real;
  end;

var
  cur: TVector;

  procedure GetBounds(const V: TVector);
  begin
    if V.x > Result.Right then
      Result.Right := Trunc(V.x)+1 else
        if V.x < Result.Left then
          Result.Left := Trunc(V.x);

    if V.y > Result.Bottom then
      Result.Bottom := Trunc(V.y)+1 else
        if V.y < Result.Top then
          Result.Top := Trunc(V.y);
  end;

  function ExtendedNeg(const V: TVector): TVector;
  begin
    Result.x := -V.x;
    Result.y := -V.y;
  end;

  function CalcVector(V: TVector): TPoint;
  begin
    cur.x := cur.x + V.x;
    cur.y := cur.y + V.y;

    GetBounds(cur);

    Result.x := Trunc(cur.x);
    Result.y := Trunc(cur.y);
  end;

var
  ver, hor: TVector;
  RadAngle: Real;
  Displacement: TPoint;
  VectList: array[0..3] of TPoint;
begin
  cur.x := ARect.Left;
  cur.y := ARect.Top;

  Result := Rect(ARect.Left, ARect.Top, ARect.Left, ARect.Top);
  RadAngle := DegToRad(Angle);

  ver.x := Sin(RadAngle) * (ARect.Bottom - ARect.Top);
  ver.y := Cos(RadAngle) * (ARect.Bottom - ARect.Top);

  hor.x := Cos(RadAngle) * (ARect.Right - ARect.Left);
  hor.y := -Sin(RadAngle) * (ARect.Right - ARect.Left);

  VectList[0] := CalcVector(Ver);
  VectList[1] := CalcVector(Hor);
  VectList[2] := CalcVector(ExtendedNeg(Ver));
  VectList[3] := CalcVector(ExtendedNeg(Hor));

  Displacement.x := ARect.Left - Result.Left;
  Displacement.y := ARect.Top  - Result.Top;

  APoint := Point(ARect.Left + Displacement.x,
                  ARect.Top + Displacement.y);

  Inc(Result.Left, Displacement.x);
  Inc(Result.Right, Displacement.x);
  Inc(Result.Top, Displacement.y);
  Inc(Result.Bottom, Displacement.y);
end;

procedure TDrawRotatedText.Assign(Source: TPersistent);
var
  lDrawCommand: TDrawRotatedText;
begin
  inherited Assign(Source);

  if (Source is TDrawRotatedText) then
  begin
    lDrawCommand := TDrawRotatedText(Source);

    Alignment    := lDrawCommand.Alignment;
    AutoSize     := lDrawCommand.AutoSize;
    Color        := lDrawCommand.Color;
    IsMemo       := lDrawCommand.IsMemo;
    Leading      := lDrawCommand.Leading;
    Text         := lDrawCommand.Text;
    Transparent  := lDrawCommand.Transparent;
    WordWrap     := lDrawCommand.WordWrap;

    {object assigns}
    Font.Assign(lDrawCommand.Font);
    TabStopPositions.Assign(lDrawCommand.TabStopPositions);
    WrappedText.Assign(lDrawCommand.WrappedText);

    {print to file properties}
    BandSave        := lDrawCommand.BandSave;
    BandSaveNo      := lDrawCommand.BandSaveNo;
    Component       := lDrawCommand.Component;
    ComponentSave   := lDrawCommand.ComponentSave;
    ComponentSaveNo := lDrawCommand.ComponentSaveNo;
    SaveLength      := lDrawCommand.SaveLength;

    Angle           := lDrawCommand.Angle;
    Origin          := lDrawCommand.Origin;
  end;
end;

function TDrawRotatedText.Draw(aDevice: TppDevice): Boolean;
var
  lScreenDevice: TppScreenDevice;
  lTopIncrement,
  lLeftIncrement: Integer;
  lClientRect: TRect;
  lClientOrigin: TPoint;
  lPrinterDevice: TppPrinterDevice;
  lPrinter: TppPrinter;
begin
  Result := True;

  if (aDevice is TppPrinterDevice) then
  begin
    lPrinterDevice := TppPrinterDevice(aDevice);
    lPrinter := lPrinterDevice.Printer;

    lPrinterDevice.CalcDrawPosition(Self);

    if CheckTTFont(Font.Name) then
    begin
      lPrinter.Canvas.Font := Font;
      lPrinter.Canvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(Font.Name);

      lClientRect := CalcRect(lPrinter.Canvas, Screen.Width, Text);
      lClientRect := CalcClientRect(lPrinter.Canvas, FAngle, lClientRect, lClientOrigin);

      DrawTop := DrawTop + lClientOrigin.Y;
      DrawLeft := DrawLeft + lClientOrigin.X;

      if Transparent then
        lPrinter.Canvas.CopyMode := cmSrcAnd  else
          begin
            OffsetRect(lClientRect, DrawLeft - lClientOrigin.X, DrawTop - lClientOrigin.Y);

            lPrinter.Canvas.Brush.Style := bsSolid;
            lPrinter.Canvas.Brush.Color := Color;
            lPrinter.Canvas.FillRect(lClientRect);
          end;

      SetBkMode(lPrinter.Canvas.Handle, Windows.Transparent);
      ppTextOutRotate(lPrinter.Canvas, lPrinter.Canvas.Font, DrawLeft, DrawTop, FAngle, Text);
    end;
  end else
  if (aDevice is TppScreenDevice) then
  begin
    lScreenDevice := TppScreenDevice(aDevice);
    lScreenDevice.ScaleVertices(Self);

    if CheckTTFont(Font.Name) then
    begin
      lScreenDevice.Canvas.Font := Font;
      lScreenDevice.Canvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(Font.Name);
      lScreenDevice.Canvas.Font.Height := Round(Font.Height * lScreenDevice.ScaleY);

      lTopIncrement := Round(FOrigin.Y * lScreenDevice.ScaleY);
      lLeftIncrement := Round(FOrigin.X * lScreenDevice.ScaleX);

      DrawTop := DrawTop + lTopIncrement;
      DrawLeft := DrawLeft + lLeftIncrement;

      if not Transparent then
      begin
        lClientRect := CalcRect(lScreenDevice.Canvas, Screen.Width, Text);
        lClientRect := CalcClientRect(lScreenDevice.Canvas, FAngle, lClientRect, lClientOrigin);
        OffsetRect(lClientRect, DrawLeft - lClientOrigin.X, DrawTop - lClientOrigin.Y);

        lScreenDevice.Canvas.Brush.Style := bsSolid;
        lScreenDevice.Canvas.Brush.Color := Color;
        lScreenDevice.Canvas.FillRect(lClientRect);
      end;

      SetBkMode(lScreenDevice.Canvas.Handle, Windows.Transparent);
      ppTextOutRotate(lScreenDevice.Canvas, lScreenDevice.Canvas.Font, DrawLeft, DrawTop, FAngle, Text);
    end;
  end;
end;

{TRotatedLabel}
constructor TRotatedLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DefaultPropName := 'Caption';
  DefaultPropEditType := etAutoEdit;

  FAngle := 0;
  FOrigin := Point(0, 0);

  DrawCommandClass := TDrawRotatedText;

  Font.Name := 'Arial';
end;

procedure TRotatedLabel.SetAngle(Value: Cardinal);
begin
  if FAngle <> Value then
  begin
    FAngle := Value;
    AdjustBounds;
  end;
end;

function TRotatedLabel.CalcRect(ACanvas: TCanvas; MaxWidth: Integer; const AText: string): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(ACanvas.Handle, PChar(AText), -1, Result, DT_EXPANDTABS or DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
end;

function TRotatedLabel.CalcClientRect(Canvas: TCanvas; Angle: Integer; ARect: TRect; var APoint: TPoint): TRect;
type
  TVector = record
    x: Real;
    y: Real;
  end;

var
  cur: TVector;

  procedure GetBounds(const V: TVector);
  begin
    if V.x > Result.Right then
      Result.Right := Trunc(V.x)+1 else
        if V.x < Result.Left then
          Result.Left := Trunc(V.x);

    if V.y > Result.Bottom then
      Result.Bottom := Trunc(V.y)+1 else
        if V.y < Result.Top then
          Result.Top := Trunc(V.y);
  end;

  function ExtendedNeg(const V: TVector): TVector;
  begin
    Result.x := -V.x;
    Result.y := -V.y;
  end;

  function CalcVector(V: TVector): TPoint;
  begin
    cur.x := cur.x + V.x;
    cur.y := cur.y + V.y;

    GetBounds(cur);

    Result.x := Trunc(cur.x);
    Result.y := Trunc(cur.y);
  end;

var
  ver, hor: TVector;
  RadAngle: Real;
  Displacement: TPoint;
  VectList: array[0..3] of TPoint;
begin
  cur.x := ARect.Left;
  cur.y := ARect.Top;

  Result := Rect(ARect.Left, ARect.Top, ARect.Left, ARect.Top);
  RadAngle := DegToRad(Angle);

  ver.x := Sin(RadAngle) * (ARect.Bottom - ARect.Top);
  ver.y := Cos(RadAngle) * (ARect.Bottom - ARect.Top);

  hor.x := Cos(RadAngle) * (ARect.Right - ARect.Left);
  hor.y := -Sin(RadAngle) * (ARect.Right - ARect.Left);

  VectList[0] := CalcVector(Ver);
  VectList[1] := CalcVector(Hor);
  VectList[2] := CalcVector(ExtendedNeg(Ver));
  VectList[3] := CalcVector(ExtendedNeg(Hor));

  Displacement.x := ARect.Left - Result.Left;
  Displacement.y := ARect.Top  - Result.Top;

  APoint := Point(ARect.Left + Displacement.x,
                  ARect.Top + Displacement.y);

  Inc(Result.Left, Displacement.x);
  Inc(Result.Right, Displacement.x);
  Inc(Result.Top, Displacement.y);
  Inc(Result.Bottom, Displacement.y);
end;

procedure TRotatedLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TRotatedLabel.AdjustBounds;
var
  R: TRect;
begin
  if not ((csReading in ComponentState) or (csLoading in ComponentState)) then
  begin
    with TBitmap.Create do
    try
      Canvas.Font := Font;

      R := CalcRect(Canvas, Screen.Width, Caption);
      R := CalcClientRect(Canvas, FAngle, R, FOrigin);

      if AutoSize then
        spSetBounds(spLeft, spTop, R.Right, R.Bottom) else
          spSetBounds(spLeft, spTop, spWidth, spHeight);

    finally
      Free;
    end;
    InvalidateDesignControl;
  end;
end;

procedure TRotatedLabel.BoundsChange;
begin
  inherited BoundsChange;
end;

procedure TRotatedLabel.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawText: TDrawRotatedText;
begin
  inherited PropertiesToDrawCommand(aDrawCommand);

  if (aDrawCommand is TDrawRotatedText) then
  begin
    lDrawText := TDrawRotatedText(aDrawCommand);

    {new properties}
    lDrawText.Origin       := FOrigin;
    lDrawText.Angle        := FAngle;

    {create print object}
    lDrawText.Alignment    := Alignment;
    lDrawText.AutoSize     := AutoSize;
    lDrawText.Color        := Color;
    lDrawText.Left         := PrintPosRect.Left;
    lDrawText.Top          := PrintPosRect.Top;
    lDrawText.Height       := PrintPosRect.Bottom - PrintPosRect.Top;
    lDrawText.Width        := PrintPosRect.Right - PrintPosRect.Left;
    lDrawText.Text         := Text;
    lDrawText.Transparent  := Transparent;
    lDrawText.WordWrap     := WordWrap;
    lDrawText.Font         := Font;

    {assign print to file properties}
    lDrawText.BandSave        := Band.Save;
    lDrawText.BandSaveNo      := Band.Report.ReportBandCount;
    lDrawText.Component       := Self;
    lDrawText.ComponentSave   := Save;
    lDrawText.ComponentSaveNo := SaveOrder;
    lDrawText.SaveLength      := SaveLength;
  end;
end;

procedure TRotatedLabel.PaintDesignControl(aCanvas: TCanvas);
begin 
  if (pppcDesigning in DesignState) then
  begin
    if not Transparent then
    begin
      aCanvas.Brush.Style := bsSolid;
      aCanvas.Brush.Color := Color;
      aCanvas.FillRect(Rect(0, 0, spWidth, spHeight));
    end;
    aCanvas.Pen.Style   := psSolid;
    aCanvas.Brush.Style := bsClear;
    aCanvas.Rectangle(0, 0, spWidth, spHeight);
  end;

  if CheckTTFont(Font.Name) then
  begin
    aCanvas.Font := Font;
    SetTextColor(aCanvas.Handle, ColorToRgb(aCanvas.Font.Color));
    ppTextOutRotate(aCanvas, aCanvas.Font, FOrigin.X, FOrigin.Y, FAngle, Caption);
  end;
end;

function TRotatedLabel.GetDefaultPropHint: string;
begin
  Result := ppLoadStr(ppMsgSetValue);
end;

procedure TRotatedLabel.SetUserName(const Value: TComponentName);
var
  lsOldName: string;
begin
  lsOldName := UserName;
  inherited SetUserName(Value);

  if (UserName = lsOldName) then
    Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) and not (pppcPasting in DesignState) then
    Exit;

  if (Caption = lsOldName) then
    Caption := Value;
end;

procedure TRotatedLabel.CreatePopupMenu(aOwner: TComponent; var aPopupMenu: TppPopupMenu);
begin
  inherited CreatePopupMenu(aOwner, aPopupMenu);

  aPopupMenu.Items.Remove(aPopupMenu.ItemByName('WordWrap'));
  aPopupMenu.AddItem(30, 'Angle', 'Angle...',  0);
end;

procedure TRotatedLabel.PopupMenuClick(Sender: TObject);
begin
  inherited PopupMenuClick(Sender);
  TppPopupMenu(Sender).ItemByName('Angle').OnClick := AngleMenuClick;
end;

procedure TRotatedLabel.AngleMenuClick(Sender: TObject);
var
  StrAngle: string;
begin
  StrAngle := IntToStr(FAngle);
  
  if InputQuery('Angle', 'Rotate at:', StrAngle) then
    Angle := StrToInt(StrAngle);
end;

{TDrawSimpleGrid}
constructor TDrawSimpleGrid.Create(aOwner: TComponent);
begin
  inherited Create(AOwner);
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FColCount := 1;
  FRowCount := 1;
  FTransparent := False;
  DataType := dtGraphic;
end;

destructor TDrawSimpleGrid.Destroy;
begin
  FBrush.Free;
  FPen.Free;
  inherited Destroy;
end;

procedure TDrawSimpleGrid.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TDrawSimpleGrid.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TDrawSimpleGrid.Assign(Source: TPersistent);
var
  lDrawCommand: TDrawSimpleGrid;
begin
  inherited Assign(Source);

  if (Source is TDrawSimpleGrid) then
  begin
    lDrawCommand := TDrawSimpleGrid(Source);

    FRowCount     := lDrawCommand.RowCount;
    FColCount     := lDrawCommand.ColCount;
    FTransparent  := lDrawCommand.Transparent;

    {object assigns}
    FBrush.Assign(lDrawCommand.Brush);
    FPen.Assign(lDrawCommand.Pen);
  end;
end;

function TDrawSimpleGrid.Draw(aDevice: TppDevice): Boolean;
var
  lScreenDevice: TppScreenDevice;
  lPrinterDevice: TppPrinterDevice;
  lPrinter: TppPrinter;

  I: Integer;
  VOffset, HOffset: Integer;
  DrawWidth,  DrawHeight: Integer;
begin
  Result := True;

  if (aDevice is TppPrinterDevice) then
  begin
    lPrinterDevice := TppPrinterDevice(aDevice);
    lPrinter := lPrinterDevice.Printer;
    lPrinterDevice.CalcDrawPosition(Self);

    with lPrinter.Canvas do
    begin
      DrawWidth := DrawRight - DrawLeft;
      while Frac(DrawWidth / FColCount) <> 0 do
      begin
        DrawRight := DrawRight - 1;
        DrawWidth := DrawRight - DrawLeft;
      end;

      DrawHeight :=  DrawBottom - DrawTop;
      while Frac(DrawHeight / FRowCount) <> 0 do
      begin
        DrawBottom := DrawBottom - 1;
        DrawHeight :=  DrawBottom - DrawTop;
      end;

      VOffset := DrawWidth div FColCount;
      HOffset := DrawHeight div FRowCount;

      if VOffSet = 0 then
        VOffset := 1;

      if HOffSet = 0 then
        HOffset := 1;


      Brush.Assign(FBrush);
      Pen.Assign(FPen);

      if not Transparent then
        FillRect(Rect(DrawLeft, DrawTop, DrawRight, DrawBottom));

      I := DrawLeft;
      while I <= DrawRight do
      begin
        MoveTo(I, DrawTop);
        LineTo(I, DrawBottom);
        Inc(I, VOffset);
      end;

      I := DrawTop;
      while I <= DrawBottom do
      begin
        MoveTo(DrawLeft, I);
        LineTo(DrawRight, I);
        Inc(I, HOffset);
      end;
    end;

  end else
  if (aDevice is TppScreenDevice) then
  begin
    lScreenDevice := TppScreenDevice(aDevice);
    lScreenDevice.ScaleVertices(Self);

    with lScreenDevice.Canvas do
    begin
      DrawWidth := DrawRight - DrawLeft;
      while Frac(DrawWidth / FColCount) <> 0 do
      begin
        DrawRight := DrawRight - 1;
        DrawWidth := DrawRight - DrawLeft;
      end;

      DrawHeight :=  DrawBottom - DrawTop;
      while Frac(DrawHeight / FRowCount) <> 0 do
      begin
        DrawBottom := DrawBottom - 1;
        DrawHeight :=  DrawBottom - DrawTop;
      end;

      VOffset := DrawWidth div FColCount;
      HOffset := DrawHeight div FRowCount;

      if VOffSet = 0 then
        VOffset := 1;

      if HOffSet = 0 then
        HOffset := 1;


      Brush.Assign(FBrush);
      Pen.Assign(FPen);

      if not Transparent then
        FillRect(Rect(DrawLeft, DrawTop, DrawRight, DrawBottom));

      I := DrawLeft;
      while I <= DrawRight do
      begin
        MoveTo(I, DrawTop);
        LineTo(I, DrawBottom);
        Inc(I, VOffset);
      end;

      I := DrawTop;
      while I <= DrawBottom do
      begin
        MoveTo(DrawLeft, I);
        LineTo(DrawRight, I);
        Inc(I, HOffset);
      end;
    end;

  end;
end;

{TSimpleGrid}
constructor TSimpleGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  DrawCommandClass := TDrawSimpleGrid;

  FColCount := 1;
  FRowCount := 1;

  spWidth := 100;
  spHeight := 100;
end;

procedure TSimpleGrid.CalcDimensions(var aLeft, aTop, aRight, aBottom: Longint);
var
  liWidth: Integer;
  liHeight: Integer;
begin
  aLeft := Pen.Width div 2;
  aTop  := aLeft;

  if Printing then
  begin
    liWidth  := ppToScreenPixels(PrintPosRect.Right - PrintPosRect.Left, utMMThousandths, pprtHorizontal, nil);
    liHeight := ppToScreenPixels(PrintPosRect.Bottom - PrintPosRect.Top, utMMThousandths, pprtVertical, nil);
  end else
  begin
    liWidth  := spWidth;
    liHeight := spHeight;
  end;

  aRight  := Pred(aLeft + liWidth)  - ((Pen.Width div 2) * 2);
  aBottom := Pred(aTop  + liHeight) - ((Pen.Width div 2) * 2);
end;

procedure TSimpleGrid.SetColCount(Value: Integer);
begin
  if Value < 1 then
    Value := 1;

  if FColCount <> Value then
  begin
    FColCount := Value;
    InvalidateDesignControl;
    PropertyChange;
  end;
end;

procedure TSimpleGrid.SetRowCount(Value: Integer);
begin
  if Value < 1 then
    Value := 1;

  if FRowCount <> Value then
  begin
    FRowCount := Value;
    InvalidateDesignControl;
    PropertyChange;
  end;
end;

procedure TSimpleGrid.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawTable: TDrawSimpleGrid;

  llLeft: Longint;
  llTop: Longint;
  llRight: Longint;
  llBottom: Longint;
begin
  inherited PropertiesToDrawCommand(aDrawCommand);
  if (aDrawCommand is TDrawSimpleGrid) then
  begin
    lDrawTable := TDrawSimpleGrid(aDrawCommand);
    lDrawTable.ColCount := FColCount;
    lDrawTable.RowCount := FRowCount;
    lDrawTable.Brush := Brush;
    lDrawTable.Pen := Pen;
    lDrawTable.Transparent := Transparent;

    CalcDimensions(llLeft, llTop, llRight, llBottom);

    llLeft := PrintPosRect.Left + ppToMMThousandths(llLeft, utScreenPixels, pprtVertical, nil);
    llTop := PrintPosRect.Top + ppToMMThousandths(llTop, utScreenPixels, pprtVertical, nil);
    llRight := PrintPosRect.Left + ppToMMThousandths(llRight, utScreenPixels, pprtVertical, nil);
    llBottom := PrintPosRect.Top + ppToMMThousandths(llBottom, utScreenPixels, pprtVertical, nil);

    lDrawTable.Left         := llLeft;
    lDrawTable.Top          := llTop;
    lDrawTable.Height       := llBottom - llTop;
    lDrawTable.Width        := llRight - llLeft;
  end;
end;

procedure TSimpleGrid.PaintDesignControl(aCanvas: TCanvas);
var
  I: Integer;
  VOffset, HOffset: Integer;

  llLeft: Longint;
  llTop: Longint;
  llRight: Longint;
  llBottom: Longint;

  llWidth: LongInt;
  llHeight: LongInt;
begin
  aCanvas.Brush := Brush;
  aCanvas.Pen := Pen;

  CalcDimensions(llLeft, llTop, llRight, llBottom);

  if (pppcDesigning in DesignState) then
  begin
    with aCanvas do
    begin
      llWidth := llRight - llLeft;
      while Frac(llWidth / FColCount) <> 0 do
      begin
        llRight := llRight - 1;
        llWidth := llRight - llLeft;
      end;

      llHeight := llBottom - llTop;
      while Frac(llHeight / FRowCount) <> 0 do
      begin
        llBottom := llBottom - 1;
        llHeight := llBottom - llTop;
      end;

      VOffset := llWidth div FColCount;
      HOffset := llHeight div FRowCount;

      Brush.Assign(Self.Brush);
      Pen.Assign(Self.Pen);

      if not Transparent then
        FillRect(Rect(llLeft, llTop, llRight, llBottom));

      I := llLeft;
      while I <= llRight do
      begin
        MoveTo(I, llTop);
        LineTo(I, llBottom);
        Inc(I, VOffset);
      end;

      I := llTop;
      while I <= llBottom do
      begin
        MoveTo(llLeft, I);
        LineTo(llRight, I);
        Inc(I, HOffset);
      end;
    end;

  end;
end;

procedure TSimpleGrid.CreatePopupMenu(aOwner: TComponent; var aPopupMenu: TppPopupMenu);
begin
  inherited CreatePopupMenu(aOwner, aPopupMenu);

  aPopupMenu.AddItem(30, 'ColCount', 'ColCount...', 0);
  aPopupMenu.AddItem(30, 'RowCount', 'RowCount...', 0);
end;

procedure TSimpleGrid.PopupMenuClick(Sender: TObject);
begin
  inherited PopupMenuClick(Sender);
  TppPopupMenu(Sender).ItemByName('ColCount').OnClick := ColCountClick;
  TppPopupMenu(Sender).ItemByName('RowCount').OnClick := RowCountClick;
end;

procedure TSimpleGrid.ColCountClick(Sender: TObject);
var
  StrColCount: string;
begin
  StrColCount := IntToStr(FColCount);
  
  if InputQuery('ColCount', 'Number of cols:', StrColCount) then
  try
    ColCount := StrToInt(StrColCount);
  except
  end;
end;

procedure TSimpleGrid.RowCountClick(Sender: TObject);
var
  StrRowCount: string;
begin
  StrRowCount := IntToStr(FRowCount);
  
  if InputQuery('RowCount', 'Number of rows:', StrRowCount) then
  try
    RowCount := StrToInt(StrRowCount);
  except
  end;
end;

initialization
  ppRegisterComponent(TRotatedLabel, 'Standard Components', 11, 0, 'RotatedLabel', HInstance);
  ppRegisterComponent(TSimpleGrid, 'Standard Components', 12, 0, 'SimpleGrid', HInstance);
  RegisterClasses([TDrawRotatedText, TDrawSimpleGrid]);
finalization
  ppUnRegisterComponent(TRotatedLabel);
  ppUnRegisterComponent(TSimpleGrid);
  UnRegisterClasses([TDrawRotatedText, TDrawSimpleGrid]);
end.
