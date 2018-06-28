unit UDPrintDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Grids, Calendar, Buttons, ExtCtrls,
  UCrpe32;

type
  TCrpePrintDateDlg = class(TForm)
    pnlPrintDate: TPanel;
    lblMonthYear: TLabel;
    sbYearMinus: TSpeedButton;
    sbYearPlus: TSpeedButton;
    sbMonthPlus: TSpeedButton;
    sbMonthMinus: TSpeedButton;
    lblYear: TLabel;
    lblMonth: TLabel;
    lblDay: TLabel;
    Calendar1: TCalendar;
    editDay: TEdit;
    editMonth: TEdit;
    editYear: TEdit;
    cbToday: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure Calendar1Change(Sender: TObject);
    procedure sbMonthMinusClick(Sender: TObject);
    procedure sbMonthPlusClick(Sender: TObject);
    procedure sbYearMinusClick(Sender: TObject);
    procedure sbYearPlusClick(Sender: TObject);
    procedure editDayChange(Sender: TObject);
    procedure editMonthChange(Sender: TObject);
    procedure editYearChange(Sender: TObject);
    procedure editDayEnter(Sender: TObject);
    procedure editMonthEnter(Sender: TObject);
    procedure editYearEnter(Sender: TObject);
    procedure cbTodayClick(Sender: TObject);
    procedure UpdatePrintDate;
    procedure btnClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
    rptDay, rptMonth, rptYear    : Word;
    Year, Month, Day             : Word;
    prevYear, prevMonth, prevDay : string;
    Present                      : TDateTime;
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpePrintDateDlg: TCrpePrintDateDlg;
  bPrintDate      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.FormCreate(Sender: TObject);
begin
  bPrintDate := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.FormShow(Sender: TObject);
begin
  rptDay   := Cr.PrintDate.Day;
  rptMonth := Cr.PrintDate.Month;
  rptYear  := Cr.PrintDate.Year;
  UpdatePrintDate;
end;
{------------------------------------------------------------------------------}
{ UpdatePrintDate procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.UpdatePrintDate;
const
  MonthArray : array[1..12] of string = ('January','February',
    'March','April','May','June','July','August','September',
    'October','November','December');
var
  vYear,
  vMonth,
  vDay   : integer;
  OnOff  : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Default date}
    if (Cr.PrintDate.Year = 0) or (Cr.PrintDate.Month = 0) or
       (Cr.PrintDate.Day = 0) then
    begin
      {Turn off Today checkbox}
      cbToday.OnClick := nil;
      cbToday.Checked := False;
      cbToday.OnClick := cbTodayClick;
    end
    else
    begin
      {Get Todays Date from system}
      Present := Now;
      DecodeDate(Present, Year, Month, Day);
      vYear := Cr.PrintDate.Year;
      vMonth := Cr.PrintDate.Month;
      vDay := Cr.PrintDate.Day;
      {Today's date}
      if (vYear = Year) and
         (vMonth = Month) and
         (vDay = Day) then
      begin
        {Turn on Today checkbox}
        cbToday.OnClick := nil;
        cbToday.Checked := True;
        cbToday.OnClick := cbTodayClick;
        {Update Calendar}
        Calendar1.OnChange := nil;
        {Set Calendar to a Month with 31 days, to
         prevent an error of changing to 31, while
         month is still on February, etc.}
        Calendar1.Month := 1;
        Calendar1.Year := Cr.PrintDate.Year;
        Calendar1.Month := Cr.PrintDate.Month;
        Calendar1.Day := Cr.PrintDate.Day;
        Calendar1.OnChange := Calendar1Change;
        {Update Calendar Title}
        lblMonthYear.Caption := MonthArray[Calendar1.Month] +
          ' ' + IntToStr(Calendar1.Year);
      end
      {Other date}
      else
      begin
        {Turn off Today checkbox}
        cbToday.OnClick := nil;
        cbToday.Checked := False;
        cbToday.OnClick := cbTodayClick;
        {Update Calendar}
        Calendar1.OnChange := nil;
        Calendar1.Month := 1;
        Calendar1.Year := Cr.PrintDate.Year;
        Calendar1.Month := Cr.PrintDate.Month;
        Calendar1.Day := Cr.PrintDate.Day;
        Calendar1.OnChange := Calendar1Change;
        {Update Calendar Title}
        lblMonthYear.Caption := MonthArray[Calendar1.Month] +
          ' ' + IntToStr(Calendar1.Year);
      end;
    end;
    {Disable Edit events}
    editYear.OnChange := nil;
    editMonth.OnChange := nil;
    editDay.OnChange := nil;
    {Update Edit boxes}
    editYear.Text := IntToStr(Cr.PrintDate.Year);
    editMonth.Text := IntToStr(Cr.PrintDate.Month);
    editDay.Text := IntToStr(Cr.PrintDate.Day);
    {Enable Edit events}
    editYear.OnChange := editYearChange;
    editMonth.OnChange := editMonthChange;
    editDay.OnChange := editDayChange;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCalendar then
      begin
        TCalendar(Components[i]).Color := ColorState(OnOff);
        TCalendar(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbTodayClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.cbTodayClick(Sender: TObject);
begin
  {Set Calendar to Todays Date}
  if cbToday.Checked then
  begin
    {Get Todays Date from system}
    Present := Now;
    DecodeDate(Present, Year, Month, Day);
    Cr.PrintDate.Year := Year;
    Cr.PrintDate.Day := Day;
    Cr.PrintDate.Month := Month;
  end;
  UpdatePrintDate;
end;
{------------------------------------------------------------------------------}
{ Calendar1Change procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.Calendar1Change(Sender: TObject);
begin
  Cr.PrintDate.Year := Calendar1.Year;
  Cr.PrintDate.Month := Calendar1.Month;
  Cr.PrintDate.Day := Calendar1.Day;
  UpdatePrintDate;
end;
{------------------------------------------------------------------------------}
{ editDayChange procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editDayChange(Sender: TObject);
begin
  if IsNumeric(editDay.Text) then
  begin
    if (StrToInt(editDay.Text) < 1) or (StrToInt(editDay.Text) > 31) then
       editDay.Text := prevDay
    else
    begin
      Calendar1.Day := StrToInt(editDay.Text);
      prevDay := editDay.Text;
    end;
  end
  else
  begin
    editDay.Text := prevDay;
    editDay.SelText := editDay.Text;
  end;
end;
{------------------------------------------------------------------------------}
{ editMonthChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editMonthChange(Sender: TObject);
begin
  if IsNumeric(editMonth.Text) then
  begin
    if (StrToInt(editMonth.Text) < 1) or (StrToInt(editMonth.Text) > 12) then
      editMonth.Text := prevMonth
    else
    begin
      Calendar1.Month := StrToInt(editMonth.Text);
      prevMonth := editMonth.Text;
    end;
  end
  else
  begin
    editMonth.Text := prevMonth;
    editMonth.SelText := editMonth.Text;
  end;
end;
{------------------------------------------------------------------------------}
{ editYearChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editYearChange(Sender: TObject);
begin
  if IsNumeric(editYear.Text) then
  begin
    if (StrToInt(editYear.Text) < 0) then
      editYear.Text := PrevYear
    else
    begin
      Calendar1.Year := StrToInt(editYear.Text);
      prevYear := editYear.Text;
    end;
  end
  else
  begin
    editYear.Text := PrevYear;
    editYear.SelText := editYear.Text;
  end;
end;
{------------------------------------------------------------------------------}
{ editDayEnter procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editDayEnter(Sender: TObject);
begin
  prevDay := editDay.Text
end;
{------------------------------------------------------------------------------}
{ editMonthEnter procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editMonthEnter(Sender: TObject);
begin
  prevMonth := editMonth.Text
end;
{------------------------------------------------------------------------------}
{ editYearEnter procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.editYearEnter(Sender: TObject);
begin
  prevYear := editYear.Text;
end;
{------------------------------------------------------------------------------}
{ sbMonthMinusClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.sbMonthMinusClick(Sender: TObject);
begin
  if Calendar1.Month > 1 then
  begin
    while True do
    begin
      {if the Day is 31, this might fail...}
      try
        Calendar1.Month := Calendar1.Month - 1;
        Break;
      {...so back up the day by one and try again}
      except
        Calendar1.Day := Calendar1.Day - 1;
      end;
    end;
  end
  else
  begin
    Calendar1.Month := Calendar1.Month + 11;
    Calendar1.Year := Calendar1.Year - 1;
  end;
end;
{------------------------------------------------------------------------------}
{ sbMonthPlusClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.sbMonthPlusClick(Sender: TObject);
begin
  if Calendar1.Month < 12 then
  begin
    while True do
    begin
      {if the Day is 31, this might fail...}
      try
        Calendar1.Month := Calendar1.Month + 1;
        Break;
      {...so back up the day by one and try again}
      except
        Calendar1.Day := Calendar1.Day - 1;
      end;
    end;
  end
  else
  begin
    Calendar1.Month := Calendar1.Month - 11;
    Calendar1.Year := Calendar1.Year + 1;
  end;
end;
{------------------------------------------------------------------------------}
{ sbYearMinusClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.sbYearMinusClick(Sender: TObject);
begin
  while True do
  begin
    {if the Day is 31, this might fail...}
    try
      Calendar1.Year := Calendar1.Year - 1;
      Break;
    {...so back up the day by one and try again}
    except
      Calendar1.Day := Calendar1.Day - 1;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ sbYearPlusClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.sbYearPlusClick(Sender: TObject);
begin
  while True do
  begin
    {if the Day is 31, this might fail...}
    try
      Calendar1.Year := Calendar1.Year + 1;
      Break;
    {...so back up the day by one and try again}
    except
      Calendar1.Day := Calendar1.Day - 1;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.btnClearClick(Sender: TObject);
begin
  Cr.PrintDate.Clear;
  UpdatePrintDate;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.PrintDate.Year := rptYear;
    Cr.PrintDate.Month := rptMonth;
    Cr.PrintDate.Day := rptDay;
  end;
  bPrintDate := False;
  Release;
end;


end.
