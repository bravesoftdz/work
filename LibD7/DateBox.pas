{##
  DATEBOX v1.2 DateEdit-Dialog with enhanced capabilities (Data-aware)
  written 1996 by Markus Plesser (e9300600@stud1.tuwien.ac.at)
  modified by Eduardo Wendel Fevereiro 1998
  (c)1996 by MANAGERsoft
  (not an official company YET - so please don´t blame me ;-)

    You can now download the latest version (& other stuff) from
  "http://stud1.tuwien.ac.at/~e9300600"

  I used the existing component DateEdit (Sorry, but I don´t know who
  wrote it :-( but I guess it was FreeWare and this one contains nearly
  nothing from the original ...

  Added properties:
    Language ... The Dialog can be displayed in either English, German, French,
                 Spanish or Italian
                 ( If you want messages in other languages - feel free to
                   mail me:
                    - The name of the language
                    - The strings for "Invalid Date:", "Need a valid Date!",
                      "Month", "Year", "Accept", "Cancel" & "Today" )
    NeedDate ... Pops up a Message if no Date is entered
    EditMask ... Define your own look & feel
    FirstDayOfWeek ... Define the day that is leftmost diplayed in the calendar
    StartSize ... Pop up in either "small" or "normal" size

  v1.11 changes:
    Italian & French Language-support
    Bugfix with enabled-property
    "Today"-Button

  v1.12 changes:
    Portuguese Language-support

  v1.2 changes:
    Small/Normal-size of Form,
    Option to set the first day of the week,
    Spanish support


  The DateBox components now use the date-format supplied by Delphi and
  you can simply change it by modifying "ShortDateFormat" and "DateSeparator".
  e.g.: If you want to display a date like "07/28/1996" use the following code:
    ShortDateFormat := 'mm/dd/yyyy';
    DateSeparator   := '/';

  To use the Data-aware version simply use TDBEditBox ;-)

  If you like the source-code of this component, you'll have to
  pay me ...... NOTHING !!!
  But - as in real life - nothing is for free ;-) so if you you want me
  to mail you the password for the source-code you'll have to send me a component
  you've made on your own or a component you think that is worth looking
  at (pls. no components you can find everywhere and/or worthless comps. ).

  Please remember - I only accept components INCLUDING _FULL_ SOURCE-CODE !!!

  If you don´t have any good components, OR want to use this component in a
  COMMERCIAL Application I charge a fee of US$ 20,- (ATS 260,- / DM 38,-).
  Please send money/crossed cheque/money-orders to the following account:
       CREDITANSTALT
       Kto.: 12412420700
       BLZ.: 11000
  Please inform me via e-mail, if I should check my account ...
  You´ll get the password via e-mail.
  If you want me to send you the password by mail, add another 5 US$ for s&h.

  I´m very interested in components like editors (>64k, Fontsupport),
  "Time-line" components (like occupation of rooms in a hotel),
  Database-Comps (stuff like InfoPower or cbPlus, but freeware or reg. to me),
  network & winsock stuff, etc.

  If you have any suggestions, comments or bugs please mail me in english or
  german to the above adress.

  Why I wrote this stuff:
  There is no good DateEdit-Component available that works fine with
  Databases, TDateBox & TDBDateBox look the same for the user and can
  handle changing the year & month in the Dialog.

  By the way:
  For my previous comp´s I didn´t receive the amount of comp´s I expected -
  probably because you didn´t need the source (Versions for D1 & D2 working
  perfectly well) - To give you a little "kick" for sending me comp´s these
  fine DateBoxes run only while Delphi is RUNNING >;-]]] *** dark evil grin ***

  Revision history:
  =================
  ** 30.06.1996 - Created, Initial Release 1.0
  ** 07.07.1996 - Minor Bugfixes (for D2 & Button-drawing while designing) v1.01
  ** 10.08.1996 - Major Bugfixes, Redesigned TDBDatebox, inherited TDateBox from
                  MaskEdit and TDBDateBox  ->  v1.1
  ** 14.08.1996 - Italian & French support, "Today-Button",
                  "Enabled"-Bugfix   -> v1.11
  ** 20.08.1996 - Portuguese support -> v1.12
  ** 03.09.1996 - Small/Normal-size of Form,
                  Option to set the first day of the week,
                  Spanish support -> v1.2

  P.S.: I´m from Austria, so please accept my apologies for my bad English >8=)
  P.P.S.: I know that the French-support isn´t finished yet - will be completed in next Ver.

  If you want to send me a postcard etc. you can reach me at:
    Markus Plesser
    Waehringer Guertel 69/4
    A-1180 Wien
    Austria/Europe

  There are no Kangaroos in Austria !!!
}
unit DateBox;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Menus,
  Forms, StdCtrls, Buttons, Dialogs, DB, DBTables, DBCtrls, Mask, Grids,
  Calendar, ExtCtrls, SuperCalendar, ComCtrls;

procedure Register;

type

  TLanguage  = (English,
                German,
                Italian,
                French,
                Spanish,
                Portuguese);  {## 6 right now ... }

  TStartDay  = (Sunday,
                Monday,
                Tuesday,
                Wednesday,
                Thursday,
                Friday,
                Saturday);  {## What day does the calendar begin with ? }

  TFormSize  = (Normal, Small); {## Size of the popup-Form }

  TFMGetDate = class(TForm)
    Shape1: TShape;
    MainCalender: TSuperCalendar;
    cmbMes: TComboBox;
    EditAno: TEdit;
    udYear: TUpDown;
    procedure MainCalenderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure MainCalenderClick(Sender: TObject);
    procedure MainCalenderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbMesChange(Sender: TObject);
    procedure EditAnoChange(Sender: TObject);
  private
    ctlParent: TComponent;
    procedure SetDate(SetDate: TDateTime);
    procedure SetClickDate;
    function GetDate: TDateTime;
  public
    property Date: TDateTime read GetDate write SetDate;
    constructor Create( AOwner: TComponent ); override;
  end;

  TDateButton = class( TBitBtn )
    protected
      procedure Click; override;
  end;

  TDateBox = class( TMaskEdit )
  private
     FInputTime : Boolean;
     FButton:  TDateButton; {## Something to push at }
     bmMemory: TBitmap;   {## For the dots }
     FDate:    TDateTime; {## Now, what could this be ??? }
     FNeedIt:  Boolean;   {## Do we need a Date to exit ? }
     FLang:    TLanguage; {## Language we are using }
     FEnab:    Boolean;   {## My Enabled-Property }
     FFirstDayOfWeek: TStartDay; {## The first day of the week }
     FFormSize: TFormSize; {## Size of the popup-Form }
     procedure MyTestDate(IsNeed : Boolean);
  protected
     procedure Change; override;
     procedure KeyDown(var Key: Word; Shift: TShiftState); override;
     procedure WMSize( var Message: TWMSize ); message WM_SIZE;
     function  GetDate: TDateTime; virtual;
     procedure SetDate( dtArg: TDateTime ); virtual;
     procedure SetEnabled(Value: Boolean);
     procedure DoExit; override;
  public
     DataAware: Boolean;
     constructor Create( AOwner: TComponent ); override;
     destructor  Destroy; override;
     procedure   CreateParams( var Params: TCreateParams ); override;
     procedure   Validate;
     property    Date: TDateTime read GetDate write SetDate;
  published
     property    InputTime : Boolean read FInputTime write FInputTime default True;
     property    NeedDate: Boolean read FNeedIt write FNeedIt default False;
     property    Language: TLanguage read FLang write FLang default English;
     property    Enabled:  Boolean read FEnab write SetEnabled default True;
     property    FirstDayOfWeek: TStartDay read FFirstDayOfWeek
                                           write FFirstDayOfWeek default Sunday;
     property    StartSize: TFormSize read FFormSize write FFormSize default Normal;
     // Herdados
{
     property AutoSelect;
     property AutoSize;
     property BorderStyle;
     property CharCase;
     property Color;
     property Ctl3D;
     property DragCursor;
     property DragMode;
     property Font;
     property MaxLength;
     property ParentColor;
     property ParentCtl3D;
     property ParentFont;
     property ParentShowHint;
     property PasswordChar;
     property Picture;
     property PopupMenu;
     property ShowVertScrollBar;
     property ShowHint;
     property TabOrder;
     property TabStop;
     property UsePictureMask;
     property Visible;
     property WantReturns;
     property WordWrap;

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
     property OnCheckValue;
}
  end;

  TDBDateBox = class( TDateBox )
  private
     FDataLink: TFieldDataLink;
     procedure DataChange(Sender: TObject);
     procedure EditingChange(Sender: TObject);
     function GetDataField: string;
     function GetDataSource: TDataSource;
     function GetField: TField;
     function GetReadOnly: Boolean;
     procedure SetDataField(const Value: string);
     procedure SetDataSource(Value: TDataSource);
     procedure SetFocused(Value: Boolean);
     procedure SetReadOnly(Value: Boolean);
     procedure UpdateData(Sender: TObject);
     procedure WMCut(var Message: TMessage); message WM_CUT;
     procedure WMPaste(var Message: TMessage); message WM_PASTE;
     procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
     procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
     procedure Change; override;
     function  EditCanModify: Boolean; override;
     procedure Reset; override;
     procedure KeyDown(var Key: Word; Shift: TShiftState); override;
     procedure KeyPress(var Key: Char); override;
     procedure Notification(AComponent: TComponent;
                 Operation: TOperation); override;
     function  GetDate: TDateTime; override;
     procedure SetDate( dtArg: TDateTime ); override;
  public
     constructor Create( AOwner: TComponent ); override;
     property    Field: TField read GetField;
     destructor  Destroy; override;
     property    Date: TDateTime read GetDate write SetDate;
     function    iGetDataField: String;
  published
     property DataField: string read GetDataField write SetDataField;
     property DataSource: TDataSource read GetDataSource write SetDataSource;
     property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  end;

var
  frmCalendar: TFMGetDate;

implementation

{$R *.DFM}

uses xBase, uDateTimeFunctions, uDataBaseFunctions;

{$DEFINE DBOXREG}

{$IFNDEF DBOXREG}
function DelphiRunning:Boolean; forward;
{$ENDIF}

constructor TFMGetDate.Create(AOwner: TComponent);
var
   i : integer;
   editOwner: TDateBox;
   rectPlace: TRect;
   ptUpper, ptLower: TPoint;
begin
  inherited Create(AOwner);

  {$IFNDEF DBOXREG}
   if not DelphiRunning then begin
      MessageDlg('UNREGISTERED DateBox !!! - Good Bye ;-)', mtError,[mbOK],0);
      Application.Terminate;
   end;
  {$ENDIF}

  { Tests to see if was called from a datebox }
  if (AOwner is TDateBox) then
   begin
    { Dynamically set the size and position }
    editOwner := TDateBox( AOwner );
    ctlParent := editOwner;
    rectPlace := editOwner.ClientRect;
    ptUpper.X := rectPlace.Left;
    ptUpper.Y := rectPlace.Top;
    ptUpper := editOwner.ClientToScreen( ptUpper );
    ptLower.X := rectPlace.Right;
    ptLower.Y := rectPlace.Bottom;
    ptLower := editOwner.ClientToScreen( ptLower );

    {  If too far down, pop the calendar above the control}
    if ptUpper.X + 1 + Width > Screen.Width then
       Left := Screen.Width - Width - 1
    else
       Left := ptUpper.X - 1;

    if ptLower.Y + 1 + Height > Screen.Height then
       Top := ptUpper.Y - Height
    else
       Top := ptLower.Y + 1;

    { define initial date }
    case TDateBox( ctlParent ).FirstDayOfWeek of
      Sunday    : MainCalender.StartOfWeek := 0;
      Monday    : MainCalender.StartOfWeek := 1;
      Tuesday   : MainCalender.StartOfWeek := 2;
      Wednesday : MainCalender.StartOfWeek := 3;
      Thursday  : MainCalender.StartOfWeek := 4;
      Friday    : MainCalender.StartOfWeek := 5;
      Saturday  : MainCalender.StartOfWeek := 6;
    end;

    // Carrega o list box dos meses
    cmbMes.Items.Clear;
    for i := 1 to 12 do
       cmbMes.Items.Add(LongMonthNames[i]);

    if not TDateBox( ctlParent ).DataAware then begin
      if TDateBox( ctlParent ).Text <> '' then
         SetDate(MyStrToDate( TDateBox( ctlParent ).Text ))
      else
         SetDate(Date);
    end else begin
      if TDBDateBox( ctlParent ).Text <> '' then
         SetDate(MyStrToDate( TDBDateBox( ctlParent ).Text ))
      else
         SetDate(Date);
    end;

   end
  else
   // It does not descend from a edit box
   begin
     MainCalender.StartOfWeek := 0;
   end;
end;


procedure TFMGetDate.SetDate(SetDate: TDateTime);
begin
  Try
    MainCalender.CalendarDate := SetDate;
  except
    MainCalender.CalendarDate := Date;
  end;
  MainCalenderChange(nil);
end;

function TFMGetDate.GetDate: TDateTime;
begin
  Result := MainCalender.CalendarDate;
end;

procedure TFMGetDate.MainCalenderChange(Sender: TObject);
var s : String;
begin
  cmbMes.ItemIndex := nMonth(MainCalender.CalendarDate)-1;
  udYear.Position  := nYear(MainCalender.CalendarDate);
end;

procedure TFMGetDate.SetClickDate;
begin
  if (ctlParent is TDateBox) then
   begin
     if TDateBox( ctlParent ).DataAware then
        TDBDateBox( ctlParent ).Date := GetDate
     else
        TDateBox( ctlParent ).Date := GetDate;
   end;
end;

{--- TDateButton ---}
procedure TDateButton.Click;
var
  editParent: TDateBox;
begin
  editParent  := TDateBox( Parent );
  frmCalendar := TFMGetDate.Create( editParent );
  frmCalendar.Show;
  inherited Click;
end;

{--- TDateBox ---}

constructor TDateBox.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  DataAware := False;
  bmMemory := TBitmap.Create;
  FButton := TDateButton.Create( self );
  FButton.TabStop := False;
  FButton.Width := 17;
  FButton.Height := 17;
  FButton.Visible := TRUE;
  FButton.Parent := self;
  FEnab := True;
  FInputTime := True;
  ControlStyle := ControlStyle - [csSetCaption];
//**  FLang := Portuguese;
  FLang := English;
end;

procedure TDateBox.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

destructor TDateBox.Destroy;
begin
  bmMemory.Free;
  FButton := nil;
  inherited Destroy;
end;

procedure TDateBox.WMSize( var Message: TWMSize );
var
  rectDraw: TRect;
  nHalfX, nHalfY: integer;
begin
  {$IFNDEF win32}
    FButton.Top    := 2;
    FButton.Height := Height - 4;
    FButton.Width  := Height - 2;
    FButton.Left   := Width - Height;
  {$ELSE}
    FButton.Top    := 1;
    FButton.Height := Height - 6;
    FButton.Width  := Height - 4;
    FButton.Left   := Width - Height;
  {$ENDIF}
  rectDraw := FButton.ClientRect;
  bmMemory.Width := rectDraw.Right - rectDraw.Left - 4;
  bmMemory.Height := rectDraw.Bottom - rectDraw.Top - 4;
  nHalfX := bmMemory.Width div 2;
  nHalfY := bmMemory.Height div 2;
  rectDraw.Left := 0;
  rectDraw.Top := 0;
  rectDraw.Right := bmMemory.Width;
  rectDraw.Bottom := bmMemory.Height;
  with bmMemory.Canvas do begin
    Brush.Color := clSilver;
    Brush.Style := bsSolid;
    FillRect( rectDraw );
    Pen.Width := 2;
    Pen.Style := psDot;
    Pen.Color := clBlack;
    MoveTo( nHalfX-4, nHalfY );
    LineTo( nHalfX-4, nHalfY );
    MoveTo( nHalfX, nHalfY );
    LineTo( nHalfX, nHalfY );
    MoveTo( nHalfX+4, nHalfY );
    LineTo( nHalfX+4, nHalfY );
  end;
  FButton.Glyph := bmMemory;
  FButton.Refresh;
end;

function TDateBox.GetDate: TDateTime;
begin
  if TestDate(Text) then
     FDate := StrToDate(Text);

  if FInputTime then
     FDate := Int(FDate) + Time;

  Result := FDate;
end;

procedure TDateBox.Change;
begin
  inherited;
{
  if TestDate(Text) then
     FDate := StrToDate(Text);
}
end;

procedure TDateBox.SetDate( dtArg: TDateTime );
var
  tmpDateFormat: String;
  Year,
  Dummy:         Word;

  function upString(const S: String): String;
  var
    i: Integer;
    r: String;
  begin
    r := S;
    for i := 1 to length(s) do
      r[i] := upcase(r[i]);
    result := r;
  end;

begin
  FDate := dtArg;
  Modified := TRUE;
  if FDate = 0 then
    Text := ''
  else begin
    {## if the year is > 2000 then display the year ALWAYS in 4 digits ! }
    DecodeDate(FDate, Year, Dummy, Dummy);
    Text := FormatDateTime( ShortDateFormat, FDate );
{
    if Year >= 2000 then begin
      tmpDateFormat := upString(ShortDateFormat);
      if(pos('YYYY', tmpDateFormat) = 0) and (pos('YY', tmpDateFormat) <> 0) then begin
        insert('YY', tmpDateFormat, pos('YY', tmpDateFormat));
        Text := FormatDateTime( tmpDateFormat, FDate );
      end else
        Text := FormatDateTime( ShortDateFormat, FDate );
    end else
      Text := FormatDateTime( ShortDateFormat, FDate );
}
  end;
end;

procedure TDateBox.SetEnabled(Value: Boolean);
begin
  FEnab := Value;
  inherited Enabled := FEnab;
  FButton.Enabled := FEnab;
end;

procedure TDateBox.Validate;
begin
  MyTestDate(True);
end;

procedure TDateBox.DoExit;
begin
  inherited DoExit;
//**  MyTestDate(FNeedIt);
  MyTestDate(True);
end;

procedure TDateBox.MyTestDate(IsNeed : Boolean);
var
  Msg: String;
begin
  try
     if Text <> '' then
        Date := StrToDate( Text );
  except
   if IsNeed then
    begin
      case FLang of
       English:    Msg := 'Invalid Date: ';
       German:     Msg := 'Ungültiges Datum: ';
       Italian:    Msg := 'Data in formato scorretto: ';
       French:     Msg := 'Date non valable: ';
       Spanish:    Msg := 'Fecha incorrecta: ';
       Portuguese: Msg := 'Data Inválida: ';
      end;
      SetFocus;
      raise Exception.Create(Msg + Text);
    end;
  end;
end;

procedure TDateBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_F2) then
     FButton.Click;
end;

{--- TDBDateBox ---}

constructor TDBDateBox.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;

  DataAware := True;
end;

{$ifndef DBOXREG}
function DelphiRunning : boolean;
var
  H1, H2, H3, H4 : Hwnd;
const
  A1 : array[0..12] of char = 'TApplication'#0;
  A2 : array[0..15] of char = 'TAlignPalette'#0;
  A3 : array[0..18] of char = 'TPropertyInspector'#0;
  A4 : array[0..11] of char = 'TAppBuilder'#0;
{$ifndef win32}
  T1 : array[0..6] of char = 'Delphi'#0;
{$endif}
begin
  {$ifndef win32}
    H1 := FindWindow(A1, T1);
  {$endif}
  H2 := FindWindow(A2, nil);
  H3 := FindWindow(A3, nil);
  H4 := FindWindow(A4, nil);
  {$ifdef win32}
    Result := (H2 <> 0) and
              (H3 <> 0) and (H4 <> 0);
  {$else}
    Result := (H1 <> 0) and (H2 <> 0) and
              (H3 <> 0) and (H4 <> 0);
  {$endif}
end;
{$endif}

destructor TDBDateBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TDBDateBox.GetDate: TDateTime;
begin
  inherited GetDate;
end;

procedure TDBDateBox.SetDate( dtArg: TDateTime );
begin
  inherited SetDate(dtArg);
  if FDate <> 0 then
    begin
     with FDataLink do
      begin
        Edit;
        if FInputTime then
           FDate := Int(FDate) + Time;
        Field.AsDateTime := FDate;
      end;
    end;
end;

function TDBDateBox.iGetDataField: String;
begin
  if FDate <> 0 then
    result := FormatDateTime(ShortDateFormat, FDate)
  else
    result := '';
end;

procedure TDBDateBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TDBDateBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
     FDataLink.Edit
  else if (Key = VK_F5) and (not FNeedIt) then
    begin
     EditMask := '';
     CheckEditState(FDataLink.DataSource.DataSet);
     Text := '';
     Modified := True;
    end;
end;

procedure TDBDateBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
      {
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      }
      end;
  end;
end;

function TDBDateBox.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDBDateBox.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TDBDateBox.SetFocused(Value: Boolean);
begin
  FDataLink.Reset;
end;

procedure TDBDateBox.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TDBDateBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateBox.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

function TDBDateBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBDateBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDBDateBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBDateBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  Enabled := not Value;
  FButton.Enabled := not Value;
end;

function TDBDateBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBDateBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then begin
    if FDataLink.Field.AsString = '' then
      Text := ''
    else
      Text := FormatDateTime(ShortDateFormat, FDataLink.Field.AsDateTime);
  end else begin
    MaxLength := 0;
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
  end;
end;

procedure TDBDateBox.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TDBDateBox.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TDBDateBox.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBDateBox.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBDateBox.CMEnter(var Message: TCMEnter);
begin
{  if Pos('/', Text) = 0 then }
  EditMask   := FDataLink.Field.EditMask;
  SetFocused(True);
  // FDataLink.Edit; Retirado !!!
  inherited;
end;

procedure TDBDateBox.CMExit(var Message: TCMExit);
begin
  try
    if FNeedIt or Modified then
       FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  SetCursor(0);
  if FNeedIt or Modified then
     DoExit;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TDateBox]);
  RegisterComponents('NewPower', [TDBDateBox]);
end;

procedure TFMGetDate.FormShow(Sender: TObject);
begin
   MainCalender.SetFocus;
end;

procedure TFMGetDate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFMGetDate.FormDeactivate(Sender: TObject);
begin
   Close;
end;

procedure TFMGetDate.MainCalenderClick(Sender: TObject);
begin
  SetClickDate;
end;

procedure TFMGetDate.MainCalenderMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Close;
end;


procedure TFMGetDate.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
       VK_RETURN,
       VK_ESCAPE  : Close;
       34         : MainCalender.NextMonth;  // Page Down
       33         : MainCalender.PrevMonth;  // Page Up
  end;
end;

procedure TFMGetDate.cmbMesChange(Sender: TObject);
const
  DiasPorMes : array [1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var
  DiaAnt, MesAnt : Word;
begin
  DiaAnt := MainCalender.Day;

  if (DiaAnt > DiasPorMes[cmbMes.ItemIndex + 1]) then
     begin
       MesAnt := cmbMes.ItemIndex + 1;
       MainCalender.Day := DiasPorMes[cmbMes.ItemIndex + 1];
       MainCalender.Month := MesAnt;
     end
  else
    MainCalender.Month := cmbMes.ItemIndex + 1
end;

procedure TFMGetDate.EditAnoChange(Sender: TObject);
begin
  MainCalender.Year := Round(StrToInt(EditAno.Text));
end;

end.
