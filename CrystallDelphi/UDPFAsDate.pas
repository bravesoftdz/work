unit UDPFAsDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Calendar, Buttons, ComCtrls, ExtCtrls, UCrpe32;

type
  TCrpePFAsDateDlg = class(TForm)
    pnlPValueEdit: TPanel;
    pcPValueEdit: TPageControl;
    tsDate: TTabSheet;
    pnlAsDate: TPanel;
    lblMonthYear1: TLabel;
    sbYearMinus1: TSpeedButton;
    sbYearPlus1: TSpeedButton;
    sbMonthPlus1: TSpeedButton;
    sbMonthMinus1: TSpeedButton;
    lblYear1: TLabel;
    lblMonth1: TLabel;
    lblDay1: TLabel;
    Calendar2: TCalendar;
    editDay1: TEdit;
    editMonth1: TEdit;
    editYear1: TEdit;
    cbToday1: TCheckBox;
    tsBoolean: TTabSheet;
    pnlAsBoolean: TPanel;
    tsNumber: TTabSheet;
    pnlAsNumber: TPanel;
    lblDot1: TLabel;
    tsCurrency: TTabSheet;
    pnlAsCurrency: TPanel;
    lblDollar: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    tsDateTime: TTabSheet;
    tsTime: TTabSheet;
    pnlAsTime: TPanel;
    pnlDateTime: TPanel;
    sbTrue: TSpeedButton;
    sbFalse: TSpeedButton;
    lblHourMinSep2: TLabel;
    lblMinSecSep2: TLabel;
    lblHours: TLabel;
    lblMinutes: TLabel;
    lblSeconds: TLabel;
    lblMonthYear2: TLabel;
    sbYearMinus2: TSpeedButton;
    sbYearPlus2: TSpeedButton;
    sbMonthPlus2: TSpeedButton;
    sbMonthMinus2: TSpeedButton;
    lblYear2: TLabel;
    lblMonth2: TLabel;
    lblDay2: TLabel;
    Calendar1: TCalendar;
    editDay2: TEdit;
    editMonth2: TEdit;
    editYear2: TEdit;
    cbToday2: TCheckBox;
    lblHourMinSep: TLabel;
    lblMinSecSep: TLabel;
    lblHours2: TLabel;
    lblMinutes2: TLabel;
    lblSeconds2: TLabel;
    lblYearMonthSep: TLabel;
    lblMonthDaySep: TLabel;
    editHours2: TEdit;
    editMinutes2: TEdit;
    editSeconds2: TEdit;
    editHour: TEdit;
    editMinutes: TEdit;
    editSeconds: TEdit;
    editNumber: TEdit;
    editDecimal1: TEdit;
    editDecimal2: TEdit;
    Label2: TLabel;
    editNumber2: TEdit;
    editDecimal3: TEdit;
    editDecimal4: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbTodayClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure editDayExit(Sender: TObject);
    procedure editMonthExit(Sender: TObject);
    procedure editYearExit(Sender: TObject);
    procedure editFieldKeyPress(Sender: TObject; var Key: Char);
    procedure editHours2Exit(Sender: TObject);
    procedure editMinutes2Exit(Sender: TObject);
    procedure editSeconds2Exit(Sender: TObject);
    procedure sbMonthMinusClick(Sender: TObject);
    procedure sbMonthPlusClick(Sender: TObject);
    procedure sbYearMinusClick(Sender: TObject);
    procedure sbYearPlusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Value     : string;
    ValueType : TCrParamFieldType;
  end;

var
  CrpePFAsDateDlg: TCrpePFAsDateDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.FormShow(Sender: TObject);
var
  nTmp  : double;
  iTmp  : integer;
  xDate : TDateTime;
begin
  {Enable/Disable applicable pages}
  tsDate.TabVisible := (ValueType = pfDate);
  tsDate.Visible := (ValueType = pfDate);
  tsDateTime.TabVisible := (ValueType = pfDateTime);
  tsDateTime.Visible := (ValueType = pfDateTime);
  tsTime.TabVisible := (ValueType = pfTime);
  tsTime.Visible := (ValueType = pfTime);
  tsBoolean.TabVisible := (ValueType = pfBoolean);
  tsBoolean.Visible := (ValueType = pfBoolean);
  tsCurrency.TabVisible := (ValueType = pfCurrency);
  tsCurrency.Visible := (ValueType = pfCurrency);
  tsNumber.TabVisible := (ValueType = pfNumber);
  tsNumber.Visible := (ValueType = pfNumber);

  {Set Value on applicable page}
  case ValueType of
    pfNumber : begin
        pcPValueEdit.ActivePage := tsNumber;
        Caption := 'Number - CrStrToFloating';
        nTmp := CrStrToFloating(Value);
        editNumber.Text := IntToStr(Trunc(nTmp));
        iTmp := Trunc(nTmp * 100) - (Trunc(nTmp) * 100);
        if iTmp < 10 then
        begin
          editDecimal1.Text := '0';
          editDecimal2.Text := IntToStr(iTmp);
        end
        else
        begin
          editDecimal1.Text := IntToStr(iTmp div 10);
          editDecimal2.Text := IntToStr(iTmp - ((iTmp div 10) * 10));
        end;
      end;
    pfCurrency : begin
        pcPValueEdit.ActivePage := tsCurrency;
        Caption := 'Currency - CrStrToFloating';
        nTmp := CrStrToFloating(Value);
        editNumber2.Text := IntToStr(Trunc(nTmp));
        iTmp := Trunc(nTmp * 100) - (Trunc(nTmp) * 100);
        if iTmp < 10 then
        begin
          editDecimal3.Text := '0';
          editDecimal4.Text := IntToStr(iTmp);
        end
        else
        begin
          editDecimal3.Text := IntToStr(iTmp div 10);
          editDecimal4.Text := IntToStr(iTmp - ((iTmp div 10) * 10));
        end;
      end;
    pfBoolean :
      begin
        pcPValueEdit.ActivePage := tsBoolean;
        Caption := 'Boolean - CrStrToBoolean';
        sbTrue.Down := (CrStrToBoolean(Value) = True)
      end;
    pfDate : begin
        pcPValueEdit.ActivePage := tsDate;
        Caption := 'Date - CrStrToDate';
        CrStrToDate(Value, xDate);
        Calendar1.CalendarDate := xDate;
        CalendarChange(Calendar1);
      end;
    pfDateTime : begin
        pcPValueEdit.ActivePage := tsDateTime;
        Caption := 'DateTime - CrStrToDateTime';
        CrStrToDateTime(Value, xDate);
        Calendar2.CalendarDate := xDate;
        editHours2.Text := FormatDateTime ('h', xDate);
        editMinutes2.Text := FormatDateTime('n', xDate);
        editSeconds2.Text := FormatDateTime('s', xDate);
        CalendarChange(Calendar2);
      end;
    pfTime : begin
        pcPValueEdit.ActivePage := tsTime;
        Caption := 'Time - CrStrToTime';
        CrStrToTime(Value, xDate);
        editHour.Text := FormatDateTime('h', xDate);
        editMinutes.Text := FormatDateTime('n', xDate);
        editSeconds.Text := FormatDateTime('s', xDate);
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbTodayClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.cbTodayClick(Sender: TObject);
var
  cnt1     : integer;
  Present  : TDateTime;
  Year,
  Month,
  Day      : Word;
  cbToday  : TCheckBox;
  Calendar : TCalendar;
  editYear,
  editMonth,
  editDay  : TEdit;
begin
  cbToday := TCheckBox(Sender);
  if cbToday.Name = 'cbToday1' then
  begin
    Calendar := Calendar1;
    editYear := editYear1;
    editMonth := editMonth1;
    editDay := editDay1;
  end
  else
  begin
    Calendar := Calendar2;
    editYear := editYear2;
    editMonth := editMonth2;
    editDay := editDay2;
  end;
  {Turn off CalendarChange event}
  Calendar.OnChange := nil;
  if not cbToday.Checked then
  begin
    {Set Calendar to a Month with 31 days, to
    prevent an error of changing to 31, while
    month is still on February, etc.}
    Calendar.Month := 1;
  end
  {Set Calendar to Todays Date}
  else
  begin
    {Get Todays Date from system}
    Present := Now;
    DecodeDate(Present, Year, Month, Day);
    Calendar.Month := 1;
    Calendar.Year := Year;
    Calendar.Day := Day;
    Calendar.Month := Month;
  end;
  {Update Edit Boxes}
  CalendarChange(Calendar);
  {Update EditBox colors}
  editYear.Color := ColorState(not cbToday.Checked);
  editMonth.Color := ColorState(not cbToday.Checked);
  editDay.Color := ColorState(not cbToday.Checked);
  {Enable/Disable Controls}
  for cnt1 := 0 to ComponentCount - 1 do
  begin
    if Components[cnt1] is TControl then
    begin
      if (TControl(Components[cnt1]).Parent = pnlAsDate) or
         (TControl(Components[cnt1]).Parent = pnlDateTime) then
      begin
        if TControl(Components[cnt1]).Tag = 2 then
          TControl(Components[cnt1]).Enabled := (not cbToday.Checked);
      end;
    end;
  end;
  {Turn on CalendarChange event}
  Calendar.OnChange := CalendarChange;
end;
{------------------------------------------------------------------------------}
{ CalendarChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.CalendarChange(Sender: TObject);
const
  MonthArray: array[1..12] of string = ('January','February',
    'March','April','May','June','July','August','September',
    'October','November','December');
var
  lblMonthYear : TLabel;
  Calendar     : TCalendar;
  editYear,
  editMonth,
  editDay  : TEdit;
begin
  if TCalendar(Sender).Name = 'Calendar1' then
  begin
    lblMonthYear := lblMonthYear1;
    Calendar := Calendar1;
    editYear := editYear1;
    editMonth := editMonth1;
    editDay := editDay1;
  end
  else
  begin
    lblMonthYear := lblMonthYear2;
    Calendar := Calendar2;
    editYear := editYear2;
    editMonth := editMonth2;
    editDay := editDay2;
  end;
  {Update Calendar Title}
  lblMonthYear.Caption := MonthArray[Calendar.Month] +
    ' ' + IntToStr(Calendar.Year);
  {Disable Edit events}
  editYear.OnExit := nil;
  editMonth.OnExit := nil;
  editDay.OnExit := nil;
  {Update Edit boxes}
  editYear.Text := IntToStr(Calendar.Year);
  editMonth.Text := IntToStr(Calendar.Month);
  editDay.Text := IntToStr(Calendar.Day);
  {Update VCL}
  {Enable Edit events}
  editYear.OnExit := editYearExit;
  editMonth.OnExit := editMonthExit;
  editDay.OnExit := editDayExit;
end;
{------------------------------------------------------------------------------}
{ editDayExit procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editDayExit(Sender: TObject);
var
  editDay : TEdit;
  Calendar  : TCalendar;
begin
  editDay := TEdit(Sender);
  if editDay.Name = 'editDay1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  try
    if (StrToInt(editDay.Text) < 1) or (StrToInt(editDay.Text) > 31) then
    begin
      ShowMessage('Day must be between 1 and 31.');
      editDay.SetFocus;
      editDay.SelLength := Length(editDay.Text);
    end
    else
      Calendar.Day := StrToInt(editDay.Text);
  except
    ShowMessage('Day must be a number between 1 and 31.');
    editDay.SetFocus;
    editDay.SelLength := Length(editDay.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editMonthExit procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editMonthExit(Sender: TObject);
var
  editMonth : TEdit;
  Calendar  : TCalendar;
begin
  editMonth := TEdit(Sender);
  if editMonth.Name = 'editMonth1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  try
    if (StrToInt(editMonth.Text) < 1) or (StrToInt(editMonth.Text) > 12) then
    begin
      ShowMessage('Month must be between 1 and 12.');
      editMonth.SetFocus;
      editMonth.SelLength := Length(editMonth.Text);
    end
    else
      Calendar.Month := StrToInt(editMonth.Text);
  except
    ShowMessage('Month must be a number between 1 and 12.');
    editMonth.SetFocus;
    editMonth.SelLength := Length(editMonth.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editYearExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editYearExit(Sender: TObject);
var
  editYear : TEdit;
  Calendar  : TCalendar;
begin
  editYear := TEdit(Sender);
  if editYear.Name = 'editYear1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  try
    if (StrToInt(editYear.Text) < 0) then
    begin
      ShowMessage('Year must be greater than or equal to 0.');
      editYear.SetFocus;
      editYear.SelLength := Length(editYear.Text);
    end
    else
      Calendar.Year := StrToInt(editYear.Text);
  except
    ShowMessage('Year must be a number greater than or equal to 0.');
    editYear.SetFocus;
    editYear.SelLength := Length(editYear.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editHours2Exit procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editHours2Exit(Sender: TObject);
begin
  try
    if (StrToInt(editHours2.Text) < 0) or (StrToInt(editHours2.Text) > 23) then
    begin
      ShowMessage('Hours must be between 0 and 23.');
      editHours2.SetFocus;
      editHours2.SelLength := Length(editHours2.Text);
    end;
  except
    ShowMessage('Hours must be a number between 0 and 23.');
    editHours2.SetFocus;
    editHours2.SelLength := Length(editHours2.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editMinutes2Exit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editMinutes2Exit(Sender: TObject);
begin
  try
    if (StrToInt(editMinutes2.Text) < 0) or (StrToInt(editMinutes2.Text) > 59) then
    begin
      ShowMessage('Minutes must be between 0 and 59.');
      editMinutes2.SetFocus;
      editMinutes2.SelLength := Length(editMinutes2.Text);
    end;
  except
    ShowMessage('Minutes must be a number between 0 and 59.');
    editMinutes2.SetFocus;
    editMinutes2.SelLength := Length(editMinutes2.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editSeconds2Exit procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editSeconds2Exit(Sender: TObject);
begin
  try
    if (StrToInt(editSeconds2.Text) < 0) or (StrToInt(editSeconds2.Text) > 59) then
    begin
      ShowMessage('Seconds must be between 0 and 59.');
      editSeconds2.SetFocus;
      editSeconds2.SelLength := Length(editSeconds2.Text);
    end;
  except
    ShowMessage('Seconds must be a number between 0 and 59.');
    editSeconds2.SetFocus;
    editSeconds2.SelLength := Length(editSeconds2.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ editFieldKeyPress procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.editFieldKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(wm_NextDlgCtl,0,0);
  end;
end;
{------------------------------------------------------------------------------}
{ sbMonthMinusClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.sbMonthMinusClick(Sender: TObject);
var
  Calendar : TCalendar;
begin
  if TSpeedButton(Sender).Name = 'sbMonthMinus1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  if Calendar.Month > 1 then
  begin
    while True do
    begin
      {if the Day is 31, this might fail...}
      try
        Calendar.Month := Calendar.Month - 1;
        Break;
      {...so back up the day by one and try again}
      except
        Calendar.Day := Calendar.Day - 1;
      end;
    end;
  end
  else
  begin
    Calendar.Month := Calendar.Month + 11;
    Calendar.Year := Calendar.Year - 1;
  end;
end;
{------------------------------------------------------------------------------}
{ sbMonthPlusClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.sbMonthPlusClick(Sender: TObject);
var
  Calendar : TCalendar;
begin
  if TSpeedButton(Sender).Name = 'sbMonthPlus1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  if Calendar.Month < 12 then
  begin
    while True do
    begin
      {if the Day is 31, this might fail...}
      try
        Calendar.Month := Calendar.Month + 1;
        Break;
      {...so back up the day by one and try again}
      except
        Calendar.Day := Calendar.Day - 1;
      end;
    end;
  end
  else
  begin
    Calendar.Month := Calendar.Month - 11;
    Calendar.Year := Calendar.Year + 1;
  end;
end;
{------------------------------------------------------------------------------}
{ sbYearMinusClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.sbYearMinusClick(Sender: TObject);
var
  Calendar : TCalendar;
begin
  if TSpeedButton(Sender).Name = 'sbYearMinus1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  while True do
  begin
    {if the Day is 31, this might fail...}
    try
      Calendar.Year := Calendar.Year - 1;
      Break;
    {...so back up the day by one and try again}
    except
      Calendar.Day := Calendar.Day - 1;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ sbYearPlusClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.sbYearPlusClick(Sender: TObject);
var
  Calendar : TCalendar;
begin
  if TSpeedButton(Sender).Name = 'sbYearPlus1' then
    Calendar := Calendar1
  else
    Calendar := Calendar2;

  while True do
  begin
    {if the Day is 31, this might fail...}
    try
      Calendar.Year := Calendar.Year + 1;
      Break;
    {...so back up the day by one and try again}
    except
      Calendar.Day := Calendar.Day - 1;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnOKClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.btnOKClick(Sender: TObject);
var
  iTmp : integer;
begin
  SaveFormPos(Self);
  {Set Value}
  case ValueType of
    pfNumber : begin
        if IsNumeric(editNumber.Text) and IsNumeric(editDecimal1.Text) and
          IsNumeric(editDecimal2.Text) then
        begin
          iTmp := StrToInt(editDecimal1.Text) * 10 + StrToInt(editDecimal2.Text);
          iTmp := StrToInt(editNumber.Text) + (iTmp div 100);
          Value := IntToStr(iTmp);
        end;
      end;
    pfCurrency : begin
        if IsNumeric(editNumber2.Text) and IsNumeric(editDecimal3.Text) and
          IsNumeric(editDecimal4.Text) then
        begin
          iTmp := StrToInt(editDecimal3.Text) * 10 + StrToInt(editDecimal4.Text);
          Value := CrFloatingToStr(StrToInt(editNumber2.Text) + (iTmp / 100));
        end;
      end;
    pfBoolean : Value := CrBooleanToStr(sbTrue.Down, False);
    pfDate : Value := CrDateToStr(Calendar1.CalendarDate);
    pfDateTime :
      begin
        if IsNumeric(editYear2.Text) and IsNumeric(editMonth2.Text) and
           IsNumeric(editDay2.Text) and IsNumeric(editHours2.Text) and
           IsNumeric(editMinutes2.Text) and IsNumeric(editSeconds2.Text) then
        begin
          Value := editYear2.Text + ',' + editMonth2.Text +
            ',' + editDay2.Text + ' ' + editHours2.Text + ':' +
            editMinutes2.Text + ':' + editSeconds2.Text;
        end;
      end;
    pfTime :
      begin
        if IsNumeric(editHours2.Text) and IsNumeric(editMinutes2.Text) and
          IsNumeric(editSeconds2.Text) then
        begin
          Value := editHours2.Text + ':' + editMinutes2.Text + ':' + editSeconds2.Text;
        end;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePFAsDateDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
