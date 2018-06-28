unit dxDateEdit;

interface

uses
  Classes, Controls, StdCtrls, Messages, Windows, Mask, MaskUtils;

const
  dxCalenMaxWeekCount = 6;

type
  TCustomdxCalendar = class(TCustomControl)
  private
    FFlat: Boolean;
    FFirstDate: TDateTime;
    FSelStart: TDateTime;
    FSelFinish: TDateTime;

    FDragStartDate: TDateTime;
    FDragFinishDate: TDateTime;
    FFirstSelStart: TDateTime;

    FOnPeriodChanged: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;

    procedure SetFlat(Value: Boolean);

    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    function GetRealFirstDate: TDateTime; virtual;
    function GetRealLastDate: TDateTime; virtual;
    function GetRealSelFinish(Value: TDateTime): TDateTime; virtual;
    function GetLastDate: TDateTime; virtual; abstract;
    function GetSelStart: TDateTime; virtual;
    function GetSelFinish: TDateTime; virtual;
    procedure SetFirstDate(Value: TDateTime); virtual;
    procedure SetSelStart(Value: TDateTime); virtual;
    procedure SetSelFinish(Value: TDateTime); virtual;

    procedure CancelAll; dynamic;
    procedure CheckSelection; virtual; abstract;
    procedure DoInternalSelectPeriod(AStart, AFinish: TDateTime);
    procedure DoPeriodChanged; dynamic;
    procedure DoSelectionChanged; dynamic;
    function PosToDateTime(P: TPoint): TDateTime; virtual; abstract;
    function RealTimeToInternalTime(ATime: TDateTime): TDateTime; virtual;

    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    property RealFirstDate: TDateTime read GetRealFirstDate;
    property RealLastDate: TDateTime read GetRealLastDate;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoSelectPeriod(AStart, AFinish: TDateTime);
    procedure DoSelectRealPeriod(AStart, AFinish: TDateTime);

    property Font;
    property FirstDate: TDateTime read FFirstDate write SetFirstDate;
    property LastDate: TDateTime read GetLastDate;
    property OriginalSelStart: TDateTime read FSelStart;
    property OriginalSelFinish: TDateTime read FSelFinish;
    property SelStart: TDateTime read GetSelStart write SetSelStart;
    property SelFinish: TDateTime read GetSelFinish write SetSelFinish;

    property OnPeriodChanged: TNotifyEvent read FOnPeriodChanged write FOnPeriodChanged;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  published
    property Flat: Boolean read FFlat write SetFlat default True;
  end;

  TdxDateNavigator = class(TCustomdxCalendar)
  private
    FColWidth, FSideWidth, FRowHeight, FHeaderHeight, FDaysOfWeekHeight,
      FTodayButtonWidth, FClearButtonWidth, FButtonsOffset, FButtonsHeight,
      FButtonsRegionHeight: Integer;
    FListBox: TWinControl;
    FTimer: UINT;
    FTodayButtonActive, FTodayButtonPressed: Boolean;
    FClearButtonActive, FClearButtonPressed: Boolean;
    FSelectPeriod: Boolean;

    procedure CheckSelectionForMargin(MarginDate: TDateTime);
    function ColOfDate(ADate: TDateTime): Integer;
    function GetHeaderRect: TRect;
    function GetInternalRect: TRect;
    function GetLeftArrowRect: TRect;
    function GetRightArrowRect: TRect;
    function GetMonthNameRect: TRect;
    function GetTodayButtonRect: TRect;
    function GetClearButtonRect: TRect;
    procedure FreeTimer;
    procedure RepaintTodayButton;
    procedure RepaintClearButton;

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    function GetRealFirstDate: TDateTime; override;
    function GetRealLastDate: TDateTime; override;
    function GetLastDate: TDateTime; override;
    function GetSelStart: TDateTime; override;
    procedure SetFirstDate(Value: TDateTime); override;
    procedure SetSelFinish(Value: TDateTime); override;
    procedure StepToPast;
    procedure StepToFuture;
    procedure CancelAll; override;
    procedure CheckSelection; override;
    procedure DeactivateAll;
    function PosToDateTime(P: TPoint): TDateTime; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
  public
    ShowTodayButton, ShowClearButton: Boolean;
    OwnerEdit: HWND;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Hide;
    procedure Show;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure UpdateSize;

    property SelectPeriod: Boolean read FSelectPeriod write FSelectPeriod;
  end;

  TdxDateEditBeforeDateChangeEvent =
    procedure(Sender: TObject; Start, Finish: TDateTime) of object;

  TCustomdxDateEdit = class(TCustomMaskEdit)
  private
    ButtonIsTracking: Boolean;
    ButtonPushed: Boolean;
    FFlatPopup: Boolean;
    FSelectPeriod: Boolean;
    FShowTodayButton: Boolean;
    FShowClearButton: Boolean;
    FOnBeforeDateChange: TdxDateEditBeforeDateChangeEvent;
    FOnDateChanged: TNotifyEvent;

    function GetDate: TDateTime;
    procedure SetDate(Value: TDateTime);

    function ButtonR: TRect;
    procedure SelectionChanged(Sender: TObject);

    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDblClk(var Message: TWMNCLButtonDblClk); message WM_NCLBUTTONDBLCLK;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure CMEnableChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMWinIniChange(var Message: TWMWinIniChange); message CM_WININICHANGE;
  protected
    procedure DoDateChanged; dynamic;
    procedure DropDown;
    function GetDateEditMask: string;
    function GetDateText(ADate: TDateTime): string;
    function GetShowClearButton: Boolean; dynamic;
    function IsDroppedDown: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WndProc(var Message: TMessage); override;

    property SelectPeriod: Boolean read FSelectPeriod write FSelectPeriod default False;
    property OnBeforeDateChange: TdxDateEditBeforeDateChangeEvent read FOnBeforeDateChange
      write FOnBeforeDateChange;
    property OnDateChanged: TNotifyEvent read FOnDateChanged write FOnDateChanged;
  public
    constructor Create(AOwner: TComponent); override;

    property Date: TDateTime read GetDate write SetDate;
    property FlatPopup: Boolean read FFlatPopup write FFlatPopup default True;
    property ShowTodayButton: Boolean read FShowTodayButton write FShowTodayButton default True;
    property ShowClearButton: Boolean read FShowClearButton write FShowClearButton default True;
  end;

  TdxDateEdit = class(TCustomdxDateEdit)
  protected
    procedure Loaded; override;
  published
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property FlatPopup;
    property SelectPeriod;
    property ShowTodayButton;
    property ShowClearButton;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    property OnBeforeDateChange;
    property OnDateChanged;
  end;

const
  NullDate = -700000;

var
  StartOfWeek: Integer;

resourcestring
  sdxDateNavigatorToday = 'Today';
  sdxDateNavigatorClear = 'Clear';

function DateOf(ADateTime: TDateTime): Integer;
function TimeOf(ADateTime: TDateTime): TDateTime;

function TextToDate(AText: string): TDateTime;
function DateToText(ADate: TDateTime): string;

implementation

uses
  SysUtils, ActiveX;

const
  dxDateNavigatorTime = 170;
  clMaroon = $000080;

{ functions }

procedure RetrieveStartOfWeek;
begin
  GetLocaleInfo(GetUserDefaultLCID, LOCALE_IFIRSTDAYOFWEEK,
    @StartOfWeek, SizeOf(StartOfWeek));
  StartOfWeek := StrToInt(Chr(StartOfWeek));
  Inc(StartOfWeek);
  if StartOfWeek > 6 then StartOfWeek := 0;
end;

procedure RefreshDateInformation;
begin
  RetrieveStartOfWeek;
end;

procedure DecMonth(var AYear, AMonth: Word);
begin
  if AMonth = 1 then
  begin
    Dec(AYear);
    AMonth := 12;
  end
  else Dec(AMonth);
end;

procedure IncMonth(var AYear, AMonth: Word);
begin
  if AMonth = 12 then
  begin
    Inc(AYear);
    AMonth := 1;
  end
  else Inc(AMonth);
end;

procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
var
  Month: Integer;
begin
  Inc(AYear, Delta div 12);
  Month := AMonth;
  Inc(Month, Delta mod 12);
  if Month < 1 then
  begin
    Dec(AYear);
    Month := 12 + Month;
  end;  
  if Month > 12 then
  begin
    Inc(AYear);
    Month := Month - 12;
  end;
  AMonth := Month;
end;

function GetDateElement(ADate: TDateTime; Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result);
end;

function CheckDay(AYear, AMonth, ADay: Integer): Integer;
begin
  if ADay < 1 then Result := 1
  else
    if ADay > DaysPerMonth(AYear, AMonth) then
      Result := DaysPerMonth(AYear, AMonth)
    else Result := ADay;
end;

function DateOf(ADateTime: TDateTime): Integer;
begin
  Result := Trunc(ADateTime + (2 * Byte(ADateTime >= 0) - 1) * 1E-11);
end;

function TimeOf(ADateTime: TDateTime): TDateTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(ADateTime, Hour, Min, Sec, MSec);
  Result := EncodeTime(Hour, Min, Sec, MSec);
end;

function TextToDate(AText: string): TDateTime;
var
  I: Integer;
  V1, V2: OleVariant;
begin
  for I := 1 to Length(AText) do
    if AText[I] = '.' then AText[I] := ' ';
  V1 := AText;
  if VariantChangeType(V2, V1, 0, VT_DATE) = S_OK then
    Result := V2
  else
    Result := NullDate;
end;

function DateToText(ADate: TDateTime): string;
var
  SystemTime: TSystemTime;
  PS: PChar;
begin
  if ADate = NullDate then Result := ''
  else
  begin
    DateTimeToSystemTime(ADate, SystemTime);
    GetMem(PS, 100);
    GetDateFormat(0, 0, @SystemTime, nil, PS, 100);
    Result := PS;
    FreeMem(PS, 100);
  end;
end;

function GetParentFormHandle(Wnd: HWND): HWND;
begin  // Wnd must have a parent
  repeat
    Result := Wnd;
    Wnd := GetParent(Result);
  until Wnd = 0;
end;

{ TdxCalenMonthListBox }

type
  TdxCalenMonthListBox = class(TCustomControl)
  private
    FTopDate: TDateTime;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FTimer: UINT;
    FTimerId: UINT;

    procedure FreeTimer;

    function GetDate: TDateTime;
    procedure SetItemIndex(Value: Integer);
    procedure SetTopDate(Value: TDateTime);

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    property ItemHeight: Integer read FItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems;
    property TopDate: TDateTime read FTopDate write SetTopDate;
  public
    constructor Create(AOwner: TComponent); override;

    property Date: TDateTime read GetDate;
  end;

constructor TdxCalenMonthListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTopDate := NullDate;
end;

procedure TdxCalenMonthListBox.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimerId);
    FTimer := 0;
  end;
end;

function TdxCalenMonthListBox.GetDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  if ItemIndex = -1 then Result := NullDate
  else
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, ItemIndex);
    Result := EncodeDate(Year, Month, 1);
  end;
end;

procedure TdxCalenMonthListBox.SetItemIndex(Value: Integer);
var
  PrevItemIndex: Integer;

  procedure InvalidateItemRect(Index: Integer);
  var
    R: TRect;
  begin
    if Index = -1 then Exit;
    with R do
    begin
      Left := 0;
      Top := Index * ItemHeight;
      Right := ClientWidth;
      Bottom := Top + ItemHeight;
    end;
    InvalidateRect(Handle, @R, False);
  end;

begin
  if FItemIndex <> Value then
  begin
    PrevItemIndex := FItemIndex;
    FItemIndex := Value;
    InvalidateItemRect(PrevItemIndex);
    InvalidateItemRect(FItemIndex);
  end;
end;

procedure TdxCalenMonthListBox.SetTopDate(Value: TDateTime);
begin
  if FTopDate <> Value then
  begin
    FTopDate := Value;
    Invalidate;
  end;
end;

procedure TdxCalenMonthListBox.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TdxCalenMonthListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxCalenMonthListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  with TdxDateNavigator(Parent) do
  begin
    FItemHeight := FHeaderHeight - 2;
    Self.Width := 2 * GetSystemMetrics(SM_CXBORDER) + 6 * FColWidth;
    Self.Height := 2 * GetSystemMetrics(SM_CYBORDER) + 7 * ItemHeight;
  end;
end;

procedure TdxCalenMonthListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOPMOST;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure AMonthListBoxTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TdxCalenMonthListBox;
  Year, Month, Day: Word;
begin
  AControl := TdxCalenMonthListBox(FindControl(Wnd));
  with AControl do
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, 2 * Integer(idEvent > 5) - 1);
    TopDate := EncodeDate(Year, Month, 1);
  end;
end;

procedure TdxCalenMonthListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  Times: array[1..4] of UINT = (500, 250, 100, 50);
var
  Delta, Sign: Integer;
  NewTimerId: UINT;
begin
  if PtInRect(ClientRect, Point(X, Y)) then
  begin
    FreeTimer;
    ItemIndex := Y div ItemHeight;
  end
  else
  begin
    ItemIndex := -1;
    if Y < 0 then Delta := Y
    else
      if Y >= ClientHeight then
        Delta := 1 + Y - ClientHeight
      else Exit;
    Sign := Delta div Abs(Delta);
    NewTimerId := Sign + Delta div 12;
    if Abs(NewTimerId) > 4 then
      NewTimerId := Sign * 4;
    NewTimerId := NewTimerId + 5;
    if (FTimer = 0) or (NewTimerId <> FTimerId) then
    begin
      FreeTimer;
      FTimerId := NewTimerId;
      FTimer := SetTimer(Handle, FTimerId, Times[Abs(FTimerId - 5)],
        @AMonthListBoxTimerProc);
    end;
  end;
end;

procedure TdxCalenMonthListBox.Paint;
const
  Colors: array[Boolean] of COLORREF = (COLOR_WINDOW, COLOR_WINDOWTEXT);
var
  DC: HDC;
  I: Integer;
  Year, Month, Day: Word;
  Selected: Boolean;
  R: TRect;
  S: string;
  Size: TSize;
begin
  DecodeDate(TopDate, Year, Month, Day);
  with R do
  begin
    Left := 0;
    Top := 0;
    Right := ClientWidth;
    Bottom := ItemHeight;
  end;
  DC := Canvas.Handle;
  for I := 0 to 6 do
  begin
    Selected := I = ItemIndex;
    SetTextColor(DC, GetSysColor(Colors[not Selected]));
    SetBkColor(DC, GetSysColor(Colors[Selected]));
    S := GetLocaleStr(GetUserDefaultLCID, LOCALE_SMONTHNAME1 + Month - 1, '') +
      ' ' + IntToStr(Year);
    GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
    with R do
      ExtTextOut(DC, (Left + Right - Size.cX) div 2, (Top + Bottom - Size.cY) div 2,
        ETO_OPAQUE, @R, PChar(S), Length(S), nil);
    IncMonth(Year, Month);
    OffsetRect(R, 0, ItemHeight);
  end;
end;

{ TCustomdxCalendar }

constructor TCustomdxCalendar.Create(AOwner: TComponent);
begin
  RefreshDateInformation;
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDoubleClicks];
  FFlat := True;
  FFirstDate := Date;
  FSelStart := FFirstDate;
  FSelFinish := FSelStart;
end;

procedure TCustomdxCalendar.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxCalendar.WMCancelMode(var Message: TMessage);
begin
  inherited;
  CancelAll;
end;

procedure TCustomdxCalendar.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  with Message do
    if (lParam <> 0) and (HWND(lParam) <> Handle) then CancelAll;
end;

procedure TCustomdxCalendar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomdxCalendar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  with Message do
    Result := Result and not DLGC_WANTALLKEYS;
end;

procedure TCustomdxCalendar.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TCustomdxCalendar.CMWinIniChange(var Message: TWMWinIniChange);
begin
  inherited;
  Invalidate;
end;

function TCustomdxCalendar.GetRealFirstDate: TDateTime;
begin
  Result := FirstDate;
end;

function TCustomdxCalendar.GetRealLastDate: TDateTime;
begin
  Result := LastDate;
end;

function TCustomdxCalendar.GetRealSelFinish(Value: TDateTime): TDateTime;
begin
  Result := Value;
  if Result <> NullDate then Result := DateOf(Result);
end;

function TCustomdxCalendar.GetSelStart: TDateTime;
begin
  if (FSelStart < FSelFinish) or (FSelFinish = NullDate) then Result := FSelStart
  else Result := FSelFinish;
end;

function TCustomdxCalendar.GetSelFinish: TDateTime;
begin
  if FSelStart < FSelFinish then Result := FSelFinish
  else Result := FSelStart;
  Result := GetRealSelFinish(Result);
end;

procedure TCustomdxCalendar.SetFirstDate(Value: TDateTime);
begin
  if FFirstDate <> Value then
  begin
    FFirstDate := Value;
    Invalidate;
    if (SelStart <> NullDate) and (SelFinish <> NullDate) then
      DoPeriodChanged;
  end;
end;

procedure TCustomdxCalendar.SetSelStart(Value: TDateTime);
begin
  FSelStart := Value;
  FSelFinish := NullDate;
  SelFinish := Value;
end;

procedure TCustomdxCalendar.SetSelFinish(Value: TDateTime);
var
  OldSelFinish: TDateTime;
begin
  if FSelFinish <> Value then
  begin
    OldSelFinish := FSelFinish;
    FSelFinish := Value;
    if DateOf(SelFinish) - DateOf(SelStart) + 1 > dxCalenMaxWeekCount * 7 then
      if FSelFinish > FSelStart then
        FSelFinish := FSelStart + dxCalenMaxWeekCount * 7 - 1
      else FSelFinish := FSelStart - dxCalenMaxWeekCount * 7 + 1;
    if FSelFinish <> OldSelFinish then
    begin
      CheckSelection;
      Repaint;
    end;
  end;
end;

procedure TCustomdxCalendar.CancelAll;
begin
  if GetCapture = Handle then ReleaseCapture;
  SendMessage(Handle, WM_LBUTTONUP, 0, LParam(PointToSmallPoint(Point(-1, -1))));
  Update;
end;

procedure TCustomdxCalendar.DoInternalSelectPeriod(AStart, AFinish: TDateTime);
begin
  if (SelStart <> AStart) and (AStart <> NullDate) or
    (SelFinish <> GetRealSelFinish(AFinish)) and (AFinish <> NullDate) then
  begin
    FSelStart := AStart;
    FSelFinish := NullDate;
    SelFinish := AFinish;
  end;
end;

procedure TCustomdxCalendar.DoPeriodChanged;
begin
  if Assigned(FOnPeriodChanged) then FOnPeriodChanged(Self);
end;

procedure TCustomdxCalendar.DoSelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(Self);
end;

function TCustomdxCalendar.RealTimeToInternalTime(ATime: TDateTime): TDateTime;
begin
  Result := ATime - 1;
end;

procedure TCustomdxCalendar.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, CM_FONTCHANGED, 0, 0);
end;

procedure TCustomdxCalendar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if ssDouble in Shift then Exit;
  ADate := PosToDateTime(Point(X, Y));
  if Button = mbLeft then
  begin
    FDragStartDate := FSelStart;
    FDragFinishDate := FSelFinish;
  end;
  if (Button = mbLeft) and (ADate <> NullDate) then
  begin
    FFirstSelStart := ADate;
    SelStart := ADate;
  end;
end;

procedure TCustomdxCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  ADate := NullDate;
  if (ssLeft in Shift) and (GetCapture = Handle) then
    ADate := PosToDateTime(Point(X, Y));
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and (GetCapture = Handle) then
    if ADate <> NullDate then
    begin
      if not (Self is TdxDateNavigator and not TdxDateNavigator(Self).SelectPeriod) then
        FSelStart := FFirstSelStart;
      SelFinish := ADate;
    end
    else
      if not PtInRect(ClientRect, Point(X, Y)) then
        DoInternalSelectPeriod(FDragStartDate, FDragFinishDate);
  Update;
end;

procedure TCustomdxCalendar.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and not (ssDouble in Shift) then
    if PtInRect(ClientRect, Point(X, Y)) then
      DoSelectionChanged
    else
      DoInternalSelectPeriod(FDragStartDate, FDragFinishDate);
end;

procedure TCustomdxCalendar.DoSelectPeriod(AStart, AFinish: TDateTime);
begin
  if (SelStart <> AStart) and (AStart <> NullDate) or
    (SelFinish <> GetRealSelFinish(AFinish)) and (AFinish <> NullDate) then
  begin
    DoInternalSelectPeriod(AStart, AFinish);
    DoSelectionChanged;
  end;
end;

procedure TCustomdxCalendar.DoSelectRealPeriod(AStart, AFinish: TDateTime);
begin
  if AStart <> AFinish then
    if AStart < AFinish then AFinish := RealTimeToInternalTime(AFinish)
    else AStart := RealTimeToInternalTime(AStart);
  DoSelectPeriod(AStart, AFinish);
end;

{ TdxDateNavigator }

constructor TdxDateNavigator.Create(AOwner: TComponent);
var
  Year, Month, Day: Word;
begin
  inherited Create(AOwner);
  DecodeDate(FFirstDate, Year, Month, Day);
  FFirstDate := EncodeDate(Year, Month, 1);
  Width := 20;
  Height := 20;
end;

destructor TdxDateNavigator.Destroy;
begin
  Hide;
  inherited;
end;

procedure TdxDateNavigator.CheckSelectionForMargin(MarginDate: TDateTime);
begin
  Invalidate;
end;

function TdxDateNavigator.ColOfDate(ADate: TDateTime): Integer;
begin
  Result := DayOfWeek(ADate) - StartOfWeek - 1;
  if Result < 0 then Inc(Result, 7);
end;

function TdxDateNavigator.GetHeaderRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Right := ClientWidth;
    Top := 0;
    Bottom := FHeaderHeight;
  end;
end;

function TdxDateNavigator.GetInternalRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Right := ClientWidth;
    Top := FHeaderHeight + Byte(not FFlat);
    Bottom := Top + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  end;
end;

function TdxDateNavigator.GetLeftArrowRect: TRect;
begin
  SetRect(Result, 1, 1, FColWidth - 1, FHeaderHeight - 1);
end;

function TdxDateNavigator.GetRightArrowRect: TRect;
begin
  SetRect(Result, ClientWidth - FColWidth, 1,
    ClientWidth - 1 - Byte(not FFlat), FHeaderHeight - 1);
end;

function TdxDateNavigator.GetMonthNameRect: TRect;
begin
  Result := GetInternalRect;
  with Result do
  begin
    Inc(Left, FColWidth);
    Dec(Right, FColWidth + Byte(not FFlat));
    Bottom := Top - Byte(not FFlat) - 1;
    Top := Bottom - (FHeaderHeight - 2);
  end;
end;

function TdxDateNavigator.GetTodayButtonRect: TRect;
begin
  Result :=
    Bounds(
      (ClientWidth - FTodayButtonWidth - Byte(ShowClearButton) * FClearButtonWidth) div
       (3 - Byte(not ShowClearButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FTodayButtonWidth, FButtonsHeight);
end;

function TdxDateNavigator.GetClearButtonRect: TRect;
begin
  Result :=
    Bounds(ClientWidth - FClearButtonWidth -
      (ClientWidth - Byte(ShowTodayButton) * FTodayButtonWidth - FClearButtonWidth) div
       (3 - Byte(not ShowTodayButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FClearButtonWidth, FButtonsHeight);
end;

procedure TdxDateNavigator.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimer);
    FTimer := 0;
  end;
end;

procedure TdxDateNavigator.RepaintTodayButton;
var
  R: TRect;
begin
  R := GetTodayButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxDateNavigator.RepaintClearButton;
var
  R: TRect;
begin
  R := GetClearButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxDateNavigator.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TdxDateNavigator.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if FFlat then
    InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TdxDateNavigator.WMNCPaint(var Message: TWMNCPaint);
var
  R, CR: TRect;
  Delta: Integer;
  DC: HDC;
begin
  inherited;
  if FFlat then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    Windows.GetClientRect(Handle, CR);
    Delta := (R.Right - CR.Right) div 2 - 1;
    InflateRect(R, -Delta, -Delta);
    DC := GetWindowDC(Handle);
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
    ReleaseDC(handle, DC);
  end;
end;

procedure TdxDateNavigator.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  Message.Result := MA_NOACTIVATE;
end;

procedure TdxDateNavigator.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateSize;
end;

procedure TdxDateNavigator.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  FColWidth := 3 * Canvas.TextWidth('0');
  FSideWidth := 2 * Canvas.TextWidth('0');
  FRowHeight := Canvas.TextHeight('0') + 2;
  FHeaderHeight := FRowHeight + 2 + Byte(FFlat);
  FDaysOfWeekHeight := FRowHeight + 1;
  FTodayButtonWidth := Canvas.TextWidth(sdxDateNavigatorToday) + FColWidth;
  FClearButtonWidth := Canvas.TextWidth(sdxDateNavigatorClear) + FColWidth;
  FButtonsOffset := Font.Size div 2;
  FButtonsHeight := MulDiv(Font.Size, 5, 2);
  FButtonsRegionHeight := FButtonsOffset + FButtonsHeight + Font.Size * 3 div 4;
  UpdateSize;
end;

function TdxDateNavigator.GetRealFirstDate: TDateTime;
var
  ACol: Integer;
begin
  Result := FirstDate;
  ACol := ColOfDate(FirstDate);
  if ACol = 0 then
    Result := Result - 7
  else
    Result := Result - ACol;
end;

function TdxDateNavigator.GetRealLastDate: TDateTime;
var
  Year, Month, Day: Word;
  ACol: Integer;
begin
  Result := LastDate;
  DecodeDate(Result, Year, Month, Day);
  ACol := ColOfDate(EncodeDate(Year, Month, 1));
  Result := Result + 6 * 7 - DaysPerMonth(Year, Month) - ACol;
  if ACol = 0 then Result := Result - 7;
end;

function TdxDateNavigator.GetLastDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  Result := EncodeDate(Year, Month, DaysPerMonth(Year, Month));
end;

function TdxDateNavigator.GetSelStart: TDateTime;
begin
  Result := inherited GetSelStart;
  if Result <> NullDate then Result := DateOf(Result);
end;

procedure TdxDateNavigator.SetFirstDate(Value: TDateTime);
begin
  Value := DateOf(Value) - (GetDateElement(Value, 3) - 1);
  inherited SetFirstDate(Value);
end;

procedure TdxDateNavigator.SetSelFinish(Value: TDateTime);
begin
  if FSelFinish <> Value then
  begin
    if not SelectPeriod then FSelStart := Value;
    inherited SetSelFinish(Value);
  end;
end;

procedure TdxDateNavigator.StepToPast;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  DecMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart > LastDate then CheckSelectionForMargin(LastDate)
  else Invalidate;
end;

procedure TdxDateNavigator.StepToFuture;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  IncMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart < FirstDate then CheckSelectionForMargin(FirstDate)
  else Invalidate;
end;

procedure TdxDateNavigator.CancelAll;
begin
  inherited;
  DeactivateAll;
end;

procedure TdxDateNavigator.CheckSelection;
var
  Year, Month, Day: Word;
begin
  if FSelStart < RealFirstDate then
  begin
    DecodeDate(FSelStart, Year, Month, Day);
    ChangeMonth(Year, Month, -1);
    FirstDate := EncodeDate(Year, Month, CheckDay(Year, Month, Day));
  end;
  if FSelStart > RealLastDate then FirstDate := DateOf(FSelStart);
end;

procedure TdxDateNavigator.DeactivateAll;
begin
  FreeTimer;
  if FListBox <> nil then
  begin
    FListBox.Free;
    FListBox := nil;
  end;
  FTodayButtonActive := False;
  FClearButtonActive := False;
end;

function TdxDateNavigator.PosToDateTime(P: TPoint): TDateTime;
var
  X, Y: Integer;
  R: TRect;
  Year, Month, Day, AYear, AMonth: Word;
  ADate: TDateTime;
begin
  if PtInRect(ClientRect, P) then
  begin
    R := GetInternalRect;
    with R do
    begin
      Inc(Top, FDaysOfWeekHeight);
      Inc(Left, FSideWidth);
      Dec(Right, FSideWidth);
      Bottom := Top + 6 * FRowHeight;
      if PtInRect(R, P) then
      begin
        Dec(P.X, Left);
        Dec(P.Y, Top);
        X := P.X div FColWidth;
        Y := P.Y div FRowHeight;
        DecodeDate(FirstDate, Year, Month, Day);
        ADate := EncodeDate(Year, Month, 1);
        Result := ADate - ColOfDate(ADate) + Y * 7 + X;
        if ColOfDate(FirstDate) = 0 then Result := Result - 7;
        DecodeDate(Result, AYear, AMonth, Day);
      end
      else Result := NullDate;
    end;
  end
  else Result := NullDate;  
end;

procedure TdxDateNavigator.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_DLGFRAME or WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    WndParent := GetParentFormHandle(OwnerEdit);
    if not FFlat then
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

procedure TdxDateNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  AYear, AMonth, ADay: Word;

  procedure MoveByMonth(AForward: Boolean);
  begin
    DecodeDate(SelStart, AYear, AMonth, ADay);
    if AForward then
      IncMonth(AYear, AMonth)
    else
      DecMonth(AYear, AMonth);
    ADay := CheckDay(AYear, AMonth, ADay);
    SelStart := EncodeDate(AYear, AMonth, ADay);
  end;

begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_RETURN:
      if FListBox = nil then
      begin
        Hide;
        if Key = VK_RETURN then DoSelectionChanged;
      end;
    VK_LEFT: SelStart := SelStart - 1;
    VK_RIGHT: SelStart := SelStart + 1;
    VK_UP:
      if Shift = [ssAlt] then Hide
      else SelStart := SelStart - 7;
    VK_DOWN:
      if Shift = [ssAlt] then Hide
      else SelStart := SelStart + 7;
    VK_HOME:
      if Shift = [ssCtrl] then
        SelStart := SelStart - (GetDateElement(SelStart, 3) - 1)
      else
        SelStart := SelStart - ColOfDate(SelStart);
    VK_END:
      if Shift = [ssCtrl] then
      begin
        DecodeDate(SelStart, AYear, AMonth, ADay);
        SelStart := SelStart + (DaysPerMonth(AYear, AMonth) - ADay)
      end
      else SelStart := SelStart + (6 - ColOfDate(SelStart));
    VK_PRIOR: MoveByMonth(False);
    VK_NEXT: MoveByMonth(True);
    VK_F4: if Shift = [] then Hide;
  end;
end;

procedure TdxDateNavigator.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if Key = #27 then Hide;
end;

procedure ADateNavigatorTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TdxDateNavigator;
  P: TPoint;
begin
  AControl := TdxDateNavigator(FindControl(Wnd));
  GetCursorPos(P);
  P := AControl.ScreenToClient(P);
  with AControl do
    case idEvent of
      1: if PtInRect(GetLeftArrowRect, P) then StepToPast;
      2: if PtInRect(GetRightArrowRect, P) then StepToFuture;
    end;
end;

procedure TdxDateNavigator.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Year, Month, Day: Word;
  R: TRect;
begin
  if Button = mbLeft then
    if ShowTodayButton and PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonActive := True;
      FTodayButtonPressed := True;
      RepaintTodayButton;
      Exit;
    end
    else
      if ShowClearButton and PtInRect(GetClearButtonRect, Point(X, Y)) then
      begin
        FClearButtonActive := True;
        FClearButtonPressed := True;
        RepaintClearButton;
        Exit;
      end
      else
        if Y >= ClientHeight - FButtonsRegionHeight then Exit;
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    if PtInRect(GetMonthNameRect, Point(X, Y)) then
    begin  // show month's list box
      FListBox := TdxCalenMonthListBox.Create(Self);
      FListBox.Visible := False;
      FListBox.Parent := Self;
      DecodeDate(FirstDate, Year, Month, Day);
      ChangeMonth(Year, Month, -3);
      R := GetMonthNameRect;
      MapWindowPoints(Handle, 0, R, 2);
      with TdxCalenMonthListBox(FListBox) do
      begin
        Font.Assign(Self.Font);
        SendMessage(Handle, CM_FONTCHANGED, 0, 0);
        TopDate := EncodeDate(Year, Month, 1);
        Left := (R.Left + R.Right - Width) div 2;
        Top := (R.Top + R.Bottom) div 2 - Height div 2;
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
      end;
    end
    else
      if PtInRect(GetLeftArrowRect, Point(X, Y)) then
      begin  // shift by month to past
        StepToPast;
        if FTimer = 0 then
          FTimer := SetTimer(Handle, 1, dxDateNavigatorTime,
            @ADateNavigatorTimerProc);
      end
      else
        if PtInRect(GetRightArrowRect, Point(X, Y)) then
        begin  // shift by month to future
          StepToFuture;
          if FTimer = 0 then
            FTimer := SetTimer(Handle, 2, dxDateNavigatorTime,
              @ADateNavigatorTimerProc);
        end;
  end;
end;

procedure TdxDateNavigator.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if FTimer > 0 then Exit;
  if FListBox <> nil then
  begin
    P := Point(X, Y);
    MapWindowPoints(Handle, FListBox.Handle, P, 1);
    TdxCalenMonthListBox(FListBox).MouseMove(Shift, P.X, P.Y);
    Exit;
  end;
  if FTodayButtonActive then
  begin
    if FTodayButtonPressed <> PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonPressed := not FTodayButtonPressed;
      RepaintTodayButton;
    end;
    Exit;
  end;
  if FClearButtonActive then
  begin
    if FClearButtonPressed <> PtInRect(GetClearButtonRect, Point(X, Y)) then
    begin
      FClearButtonPressed := not FClearButtonPressed;
      RepaintClearButton;
    end;
    Exit;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxDateNavigator.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  ADate: TDateTime;
  Year, Month, Day: Word;
begin
  if FTimer > 0 then
  begin
    FreeTimer;
    Exit;
  end;
  if FListBox <> nil then
  begin
    ADate := TdxCalenMonthListBox(FListBox).Date;
    FListBox.Free;
    FListBox := nil;
    if ADate <> NullDate then
    begin
      DecodeDate(ADate, Year, Month, Day);
      FirstDate := EncodeDate(Year, Month, 1);
      if SelStart < FirstDate then CheckSelectionForMargin(FirstDate)
      else
        if SelStart > LastDate then CheckSelectionForMargin(LastDate);
    end;
    Exit;
  end;
  if FTodayButtonActive then
  begin
    FTodayButtonActive := False;
    if FTodayButtonPressed then SelStart := Date
    else Exit;
  end;
  if FClearButtonActive then
  begin
    FClearButtonActive := False;
    if FClearButtonPressed then SelStart := NullDate
    else Exit;
  end;
  if HandleAllocated and PtInRect(ClientRect, Point(X, Y)) then Hide;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TdxDateNavigator.Paint;
const
  FontColors: array[Boolean] of Integer = (COLOR_WINDOWTEXT, COLOR_HIGHLIGHTTEXT);
  BrushColors: array[Boolean, Boolean] of COLORREF =
    ((COLOR_WINDOW, COLOR_HIGHLIGHT), (COLOR_WINDOW, COLOR_BTNFACE));
var
  CurDate, ALastDate: TDateTime;
  BtnShadowBrush, BtnTextBrush, WindowBrush, ABrush: HBRUSH;
  Region, Rgn: HRGN;
  DC: HDC;
  ArrowHeight: Integer;
  R: TRect;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(Region, Region, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

  procedure DrawArrow(const R: TRect; LeftArrow: Boolean);
  var
    X, Sign: Integer;
    P: array[1..3] of TPoint;
  begin
    with R do
    begin
      if LeftArrow then X := Left
      else X := Right;
      Sign := 2 * Byte(LeftArrow) - 1;
      P[1] := Point(X + Sign * (FSideWidth - 1), (Top + Bottom - ArrowHeight) div 2 - 1);
      P[2] := Point(P[1].X, P[1].Y + ArrowHeight + 1);
      P[3] := Point(P[1].X - Sign * (ArrowHeight div 2 + 1), P[1].Y + ArrowHeight div 2 + 1);
      Rgn := CreatePolygonRgn(P, 3, WINDING);
      FillRgn(DC, Rgn, BtnTextBrush);
      ExtSelectClipRgn(DC, Rgn, RGN_DIFF);
      DeleteObject(Rgn);
    end;
  end;

  procedure DrawMonth;
  var
    Size: TSize;
    R, TextR, SideR: TRect;
    I, J, DayBase, CurDay: Integer;
    Year, Month, Day: Word;
    ADate, DateBase: TDateTime;
    S: string;
    Selected: Boolean;
  begin
    DecodeDate(FirstDate, Year, Month, Day);

    R := GetInternalRect;
    with R do
      ExcludeRect(Rect(Left + FSideWidth, Top, Right - FSideWidth, Bottom - 1));

    // draw header's frame
    TextR := GetHeaderRect;
    with TextR do ArrowHeight := (Bottom - Top) div 2;
    if not Odd(ArrowHeight) then Inc(ArrowHeight);
    if not FFlat then InflateRect(TextR, 0, 1);
    ExcludeRect(TextR);
    if not FFlat then InflateRect(TextR, 0, -1);
    if not FFlat then
      with TextR do
      begin
        FillRect(DC, Rect(Left, Bottom, Right, Bottom + 1), BtnTextBrush);
        FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnTextBrush);
        Dec(TextR.Right);
      end;
    DrawEdge(DC, TextR, BDR_RAISEDINNER, BF_RECT);
    InflateRect(TextR, -1, -1);
    // draw arrows
    DrawArrow(TextR, True);
    DrawArrow(TextR, False);
    // write month's and year's names
    S := GetLocaleStr(GetUserDefaultLCID, LOCALE_SMONTHNAME1 + Month - 1, '') +
      ' ' + IntToStr(Year);
    GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
    SetTextColor(DC, GetSysColor(COLOR_BTNTEXT));
    SetBkColor(DC, GetSysColor(COLOR_BTNFACE));
    with TextR do
      ExtTextOut(DC, (Left + Right - Size.cX) div 2, (Top + Bottom - Size.cY) div 2,
        ETO_CLIPPED or ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);

    // write first letters of day's names
    with TextR do
    begin
      Left := R.Left + FSideWidth;
      Right := R.Right - FSideWidth;
      Top := R.Top;
      Bottom := Top + FDaysOfWeekHeight - 2;
      FillRect(DC, Rect(Left - 8, Top, Left, Bottom + 2), WindowBrush);
      FillRect(DC, Rect(Right, Top, Right + 8, Bottom + 2), WindowBrush);
      FillRect(DC, Rect(Left, Bottom, Right, Bottom + 1), BtnShadowBrush);
      FillRect(DC, Rect(Left, Bottom + 1, Right, Bottom + 2), WindowBrush);
      Right := Left;
    end;
    SetBkColor(DC, GetSysColor(COLOR_WINDOW));
    for I := 0 to 6 do
    begin
      with TextR do
      begin
        Left := Right;
        Right := Left + FColWidth;
      end;
      J := (StartOfWeek + I + 6) mod 7;
      S := WideString(GetLocaleStr(GetUserDefaultLCID, LOCALE_SABBREVDAYNAME1 + J, ''))[1];
      GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
      with TextR do
        ExtTextOut(DC, Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
          ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
    end;

    // write numbers of days
    DateBase := EncodeDate(Year, Month, 1) - 1;
    DayBase := 1 - ColOfDate(DateBase + 1);
    if DayBase = 1 then Dec(DayBase, 7);
    for I := 0 to 6 do
      for J := 0 to 5 do
      begin
        with TextR do
        begin
          Left := R.Left + FSideWidth + I * FColWidth;
          Top := R.Top + FDaysOfWeekHeight + J * FRowHeight;
          Right := Left + FColWidth;
          Bottom := Top + FRowHeight;
        end;

        CurDay := DayBase + J * 7 + I;
        ADate := DateBase + CurDay;
        Selected := (ADate >= SelStart) and (ADate <= SelFinish);

        SideR := TextR;
        // draw frame around current date
        if ADate = CurDate then
        begin
          ABrush := CreateSolidBrush(clMaroon);
          FrameRect(DC, TextR, ABrush);
          DeleteObject(ABrush);
          InflateRect(TextR, -1, -1);
        end;
        // draw text of day's number
        if not Selected and ((ADate < FirstDate) or (ADate > ALastDate)) then
          SetTextColor(DC, GetSysColor(COLOR_GRAYTEXT))
        else
          SetTextColor(DC, GetSysColor(FontColors[Selected]));
        SetBkColor(DC, GetSysColor(BrushColors[FFlat, Selected]));
        S := IntToStr(GetDateElement(ADate, 3));
        GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
        with SideR do
          ExtTextOut(DC,
            Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
            ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
      end;
  end;

  procedure DrawButton(R: TRect; ACaption: string; Pressed: Boolean);
  var
    Size: TSize;
  begin
    ExcludeRect(R);
    with R do
    begin
      if Pressed then
      begin
        DrawEdge(DC, R, BDR_SUNKENINNER, BF_TOPLEFT);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
        InflateRect(R, -1, -1);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_TOPLEFT);
        DrawEdge(DC, R, BDR_SUNKENINNER, BF_BOTTOMRIGHT);
        InflateRect(R, -1, -1);
      end
      else
      begin
        DrawEdge(DC, R, EDGE_RAISED, BF_RECT);
        InflateRect(R, -2, -2);
      end;
      // draw button's caption
      GetTextExtentPoint32(DC, PChar(ACaption), Length(ACaption), Size);
      SetTextColor(DC, GetSysColor(COLOR_BTNTEXT));
      SetBkColor(DC, GetSysColor(COLOR_BTNFACE));
      ExtTextOut(DC, (Left + Right - Size.cX) div 2 + Byte(Pressed),
        (Top + Bottom - Size.cY) div 2 + Byte(Pressed), ETO_CLIPPED or ETO_OPAQUE, @R,
        PChar(ACaption), Length(ACaption), nil);
    end;
  end;

begin
  CurDate := Date;
  ALastDate := LastDate;
  Region := CreateRectRgnIndirect(ClientRect);
  BtnShadowBrush := GetSysColorBrush(COLOR_BTNSHADOW);
  BtnTextBrush := GetSysColorBrush(COLOR_BTNTEXT);
  WindowBrush := GetSysColorBrush(COLOR_WINDOW);
  DC := Canvas.Handle;

  DrawMonth;
  if ShowTodayButton or ShowClearButton then
  begin
    with R do
    begin
      Left := FSideWidth;
      Top := ClientHeight - FButtonsRegionHeight - 1;
      Right := ClientWidth - FSideWidth;
      Bottom := Top + 1;
    end;
    FillRect(DC, R, BtnShadowBrush);
    ExcludeRect(R);
    // draw today and clear buttons
    if ShowTodayButton then
      DrawButton(GetTodayButtonRect, sdxDateNavigatorToday,
        FTodayButtonActive and FTodayButtonPressed);
    if ShowClearButton then
      DrawButton(GetClearButtonRect, sdxDateNavigatorClear,
        FClearButtonActive and FClearButtonPressed);
  end;

  FillRgn(DC, Region, WindowBrush);
  DeleteObject(Region);
end;

var
  MouseHookHandle: HHOOK;
  DateNavigator: TdxDateNavigator;

procedure TdxDateNavigator.Hide;
begin
  if HandleAllocated and (GetCapture = Handle) then ReleaseCapture;
  DeactivateAll;
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    SetWindowPos(Handle, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
    UnhookWindowsHookEx(MouseHookHandle);
    MouseHookHandle := 0;
  end;
  if HandleAllocated then DestroyWnd;
end;

function dxDateNavigatorMouseHook(Code: Integer; wParam: WParam; lParam: LParam): LRESULT; stdcall;
var
  R, CR: TRect;
begin
  if (Code >= 0) and
    ((wParam = WM_LBUTTONDOWN) or (wParam = WM_RBUTTONDOWN) or (wParam = WM_MBUTTONDOWN) or
     (wParam = WM_NCLBUTTONDOWN) or (wParam = WM_NCRBUTTONDOWN) or (wParam = WM_NCMBUTTONDOWN) or
     (wParam = WM_LBUTTONDBLCLK) or (wParam = WM_RBUTTONDBLCLK) or (wParam = WM_MBUTTONDBLCLK) or
     (wParam = WM_NCLBUTTONDBLCLK) or (wParam = WM_NCRBUTTONDBLCLK) or (wParam = WM_NCMBUTTONDBLCLK)) then
  begin
    GetWindowRect(DateNavigator.Handle, R);
    if not PtInRect(R, PMouseHookStruct(lParam)^.pt) then
      with DateNavigator, PMouseHookStruct(lParam)^ do
      begin
        Windows.GetWindowRect(OwnerEdit, R);
        Windows.GetClientRect(OwnerEdit, CR);
        MapWindowPoints(OwnerEdit, 0, CR, 2);
        Hide;
        if PtInRect(R, pt) and not PtInRect(CR, pt) then
        begin
          Result := 1;
          Exit;
        end;
      end;
{    begin
      DateNavigator.Hide;
      Result := 1;
      Exit;
    end;}
  end;
  Result := CallNextHookEx(MouseHookHandle, Code, wParam, lParam);
end;

procedure TdxDateNavigator.Show;
begin
  MouseHookHandle :=
    SetWindowsHookEx(WH_MOUSE, dxDateNavigatorMouseHook, 0, GetCurrentThreadId);
  SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  SetWindowPos(Handle, 0, 0, 0, 0, 0,
    SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

function TdxDateNavigator.GetWidth: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Right - CR.Right + 2 * FSideWidth + 7 * FColWidth;
end;

function TdxDateNavigator.GetHeight: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Bottom - CR.Bottom +
    FHeaderHeight + Byte(not FFlat) + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  if ShowTodayButton or ShowClearButton then
    Inc(Result, FButtonsRegionHeight);
end;

procedure TdxDateNavigator.UpdateSize;
begin
  Width := GetWidth;
  Height := GetHeight;
end;

{ TCustomdxDateEdit }

constructor TCustomdxDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not (csDesigning in ComponentState) then EditMask := GetDateEditMask;
  FFlatPopup := True;
  FShowTodayButton := True;
  FShowClearButton := True;
end;

function TCustomdxDateEdit.GetDate: TDateTime;
begin
  Result := TextToDate(Text);
end;

procedure TCustomdxDateEdit.SetDate(Value: TDateTime);
var
  ADate: TDateTime;
  AText: string;
begin
  ADate := Date;
  AText := GetDateText(Value);
  if Text <> AText then Text := AText;
  if ADate <> Value then DoDateChanged;
end;

function TCustomdxDateEdit.ButtonR: TRect;
var
  R, CR: TRect;
begin
  GetWindowRect(Handle, R);
  Result := R;
  OffsetRect(R, -R.Left, -R.Top);
  Windows.GetClientRect(Handle, CR);
  InflateRect(R,
    -(R.Right - CR.Right - GetSystemMetrics(SM_CXVSCROLL)) div 2,
    -(R.Bottom - CR.Bottom) div 2);
  R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
  OffsetRect(R, Result.Left, Result.Top);
  Result := R;
end;

procedure TCustomdxDateEdit.SelectionChanged(Sender: TObject);
begin
  if not SelectPeriod then
    Date := DateNavigator.SelStart
  else
    if Assigned(FOnBeforeDateChange) then
      FOnBeforeDateChange(Self, DateNavigator.SelStart, DateNavigator.SelFinish);
end;

procedure TCustomdxDateEdit.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if ButtonIsTracking then
  begin
    ButtonIsTracking := False;
    ButtonPushed := False;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TCustomdxDateEdit.WMEnable(var Message: TWMEnable);
begin
  inherited;
  if HandleAllocated then SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TCustomdxDateEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  with Message do
  begin
    Result := DLGC_WANTARROWS;
    if IsDroppedDown then Result := Result or DLGC_WANTALLKEYS;
  end;
end;

procedure TCustomdxDateEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if DateNavigator <> nil then DateNavigator.Hide;
  Date := GetDate;
end;

procedure TCustomdxDateEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if ButtonIsTracking then ReleaseCapture;
end;

procedure TCustomdxDateEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  Dec(Message.CalcSize_Params^.rgrc[0].Right, GetSystemMetrics(SM_CXVSCROLL));
end;

procedure TCustomdxDateEdit.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if PtInRect(ButtonR, SmallPointToPoint(Message.Pos)) then
    Message.Result := HTBORDER;
end;

procedure TCustomdxDateEdit.WMNCLButtonDblClk(var Message: TWMNCLButtonDblClk);
begin
  with Message do
    Result := SendMessage(Handle, WM_NCLBUTTONDOWN, 0, MakeLParam(XCursor, YCursor));
end;

procedure TCustomdxDateEdit.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if csDesigning in ComponentState then Exit;
  Windows.SetFocus(Handle);
  with Message do
    if not ReadOnly and PtInRect(ButtonR, Point(XCursor, YCursor)) then
    begin
      DropDown;
      SetCapture(Handle);
      ButtonIsTracking := True;
      ButtonPushed := True;
      SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TCustomdxDateEdit.WMNCPaint(var Message: TWMNCPaint);
const
  Pushes: array[Boolean] of Longint = (0, DFCS_PUSHED or DFCS_FLAT);
  Enables: array[Boolean] of Longint = (DFCS_INACTIVE, 0);
var
  R, CR: TRect;
  DC: HDC;
begin
  inherited;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  Windows.GetClientRect(Handle, CR);
  InflateRect(R,
    -(R.Right - CR.Right - GetSystemMetrics(SM_CXVSCROLL)) div 2,
    -(R.Bottom - CR.Bottom) div 2);
  R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);

  DC := GetWindowDC(Handle);
  DrawFrameControl(DC, R, DFC_SCROLL,
    DFCS_SCROLLCOMBOBOX or Pushes[ButtonPushed] or Enables[Enabled]);
  ReleaseDC(Handle, DC);
end;

procedure TCustomdxDateEdit.CMEnableChanged(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) and HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TCustomdxDateEdit.CMExit(var Message: TCMExit);
begin
  try
    inherited;
  except
    Date := NullDate;
  end;
  Date := GetDate;
end;

procedure TCustomdxDateEdit.CMWinIniChange(var Message: TWMWinIniChange);
var
  ADate: TDateTime;
begin
  inherited;
  RefreshDateInformation;
  if not (csDesigning in ComponentState) then
  begin
    ADate := Date;
    EditMask := '';
    Text := '';
    DateSeparator := GetLocaleChar(GetUserDefaultLCID, LOCALE_SDATE, '/');
    EditMask := GetDateEditMask;
    Text := GetDateText(ADate);
  end;  
end;

procedure TCustomdxDateEdit.DoDateChanged;
begin
  if Assigned(FOnDateChanged) then FOnDateChanged(Self);
end;

procedure TCustomdxDateEdit.DropDown;
var
  P: TPoint;
  R: TRect;
  ADate: TDateTime;
begin
  if ReadOnly then Exit;

  P := Point(Left, Top + Height);
  Windows.ClientToScreen(GetParent(Handle), P);

  if DateNavigator = nil then
    DateNavigator := TdxDateNavigator.Create(nil);
  DateNavigator.OwnerEdit := Handle;
  DateNavigator.Flat := FlatPopup;
  DateNavigator.SelectPeriod := SelectPeriod;
  DateNavigator.ShowTodayButton := ShowTodayButton;
  DateNavigator.ShowClearButton := GetShowClearButton;
  DateNavigator.Font := Font;
  with DateNavigator do
  begin
    Left := P.X;
    Top := P.Y;
    ADate := Date;
    if ADate = NullDate then ADate := SysUtils.Date;
    FirstDate := ADate;
    SelStart := ADate;
    OnSelectionChanged := SelectionChanged;
    UpdateSize;
    SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    if Left < R.Left then Left := R.Left;
    if Left + Width > R.Right then
      Left := R.Right - Width;
    if Top + Height > R.Bottom then
      Top := Top - (Self.Height + Height);
    Show;
  end;
end;

function TCustomdxDateEdit.GetDateEditMask: string;
var
  Format, S: string;
  I, J: Integer;
begin
  Result := '!';
  Format := GetLocaleStr(GetUserDefaultLCID, LOCALE_SSHORTDATE, '');
  I := 1;
  while I <= Length(Format) do
  begin
    if Format[I] in ['d', 'M', 'y'] then
    begin
      for J := I to Length(Format) do
        if Format[J] <> Format[I] then Break;
      if J - I < 3 then S := '99'
      else
        if Format[I] = 'y' then S := '9999'
        else S := 'lll';
      I := J - 1;
    end
    else S := Format[I];
    Result := Result + S;
    Inc(I);
  end;
  Result := Result + ';1; ';
end;

function TCustomdxDateEdit.GetDateText(ADate: TDateTime): string;
begin
  if ADate = NullDate then
    Result := FormatMaskText(EditMask, '')
  else
    Result := DateToText(ADate);
end;

function TCustomdxDateEdit.GetShowClearButton: Boolean;
begin
  Result := ShowClearButton;
end;

function TCustomdxDateEdit.IsDroppedDown: Boolean;
begin
  Result := (DateNavigator <> nil) and DateNavigator.HandleAllocated and
    IsWindowVisible(DateNavigator.Handle);
end;

procedure TCustomdxDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssAlt]) and ((Key = VK_UP) or (Key = VK_DOWN)) or
    (Shift = []) and (Key = VK_F4) then
    DropDown;
end;

procedure TCustomdxDateEdit.WndProc(var Message: TMessage);
var
  P: TPoint;
  PrevButtonPushed: Boolean;
begin
  with Message do
    if (WM_KEYFIRST <= Msg) and (Msg <= WM_KEYLAST) and IsDroppedDown then
    begin
      DateNavigator.WndProc(Message);
      Exit;
    end;
  inherited;
  with Message do
    if ButtonIsTracking and ((Msg = WM_MOUSEMOVE) or (Msg = WM_NCMOUSEMOVE)) then
    begin
      P := SmallPointToPoint(TSmallPoint(lParam));
      if Msg = WM_MOUSEMOVE then Windows.ClientToScreen(Handle, P);
      PrevButtonPushed := ButtonPushed;
      ButtonPushed := PtInRect(ButtonR, P);
      if PrevButtonPushed <> ButtonPushed then
        SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

{ TdxDateEdit }

procedure TdxDateEdit.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then Text := Name;
end;

initialization
  RetrieveStartOfWeek;

finalization
  if DateNavigator <> nil then DateNavigator.Free;

end.
