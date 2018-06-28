unit uFrmSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DateBox, IniFiles, ComCtrls;

const
  SCHD_START_DATE   = 'STRDATE=';
  SCHD_NEX_SCHEDULE = 'NEXTSCHD=';
  SCHD_OCCURS       = 'OCCURS=';
  SCHD_INTERVAL     = 'INTERVAL=';
  SCHD_EVERY        = 'EVERY=';
  SCHD_CALLJOB      = 'CALLJOB=';
  SCHD_START_TIME   = 'STARTTM=';

type
  TFrmSchedule = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    rdOccurs: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    IniDate: TDateBox;
    Label2: TLabel;
    edtTime: TEdit;
    UpDownTime: TUpDown;
    cbxTime: TComboBox;
    lbSchedule: TLabel;
    Label3: TLabel;
    edtStartAt: TDateTimePicker;
    lbStartat: TLabel;
    Label4: TLabel;
    edtRefresh: TEdit;
    udRefresh: TUpDown;
    chkUpdateQty: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdOccursClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fUpdate : Boolean;
    MyTime : TDateTime;
    procedure GetSchedule;
    procedure SetSchedule;
    procedure UpdateNextSchedule;
  public
    { Public declarations }
    function Start:Boolean;
    function BuildSchedule(Schedule:String):String;
  end;


implementation

uses uMainConf, uDateTimeFunctions, DateUtils, uParamFunctions;

{$R *.dfm}

procedure TFrmSchedule.GetSchedule;
begin
   IniDate.Date         := FrmMain.fIniServerConfig.ReadDate('Tasks','StartDate', Now);
   rdOccurs.ItemIndex   := FrmMain.fIniServerConfig.ReadInteger('Tasks','Occurs',0);
   UpDownTime.Position  := FrmMain.fIniServerConfig.ReadInteger('Tasks','Interval',1);
   cbxTime.ItemIndex    := FrmMain.fIniServerConfig.ReadInteger('Tasks','Every',0);
   edtStartAt.Time      := FrmMain.fIniServerConfig.ReadTime('Tasks','StartAt',Time);
   udRefresh.Position   := FrmMain.fIniServerConfig.ReadInteger('Timer','CallJob',10);
   MyTime               := FrmMain.fIniServerConfig.ReadDateTime('Tasks','NextSchedule', Now);
   chkUpdateQty.Checked := FrmMain.fIniServerConfig.ReadBool('Setup','DisableUpdateQty', False);

end;

procedure TFrmSchedule.SetSchedule;
begin
  FrmMain.fIniServerConfig.WriteDate('Tasks','StartDate', IniDate.Date);
  FrmMain.fIniServerConfig.WriteInteger('Tasks','Occurs', rdOccurs.ItemIndex);
  FrmMain.fIniServerConfig.WriteInteger('Tasks','Interval', UpDownTime.Position);
  FrmMain.fIniServerConfig.WriteInteger('Tasks','Every', cbxTime.ItemIndex);
  FrmMain.fIniServerConfig.WriteTime('Tasks','StartAt', edtStartAt.Time);
  FrmMain.fIniServerConfig.WriteDateTime('Tasks','NextSchedule', MyTime);
  FrmMain.fIniServerConfig.WriteInteger('Timer','CallJob', udRefresh.Position);
  FrmMain.fIniServerConfig.WriteBool('Setup','DisableUpdateQty', chkUpdateQty.Checked);
  FrmMain.LoadParamTask;
end;

function TFrmSchedule.Start:Boolean;
begin

    fUpdate := False;

    GetSchedule;

    ShowModal;

    Result := (ModalResult=mrOK);

    If Result then
       SetSchedule;

end;

procedure TFrmSchedule.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmSchedule.UpdateNextSchedule;
begin

  if fUpdate then
     begin
       if IniDate.Date > now then
          MyTime := IniDate.Date
       else
          MyTime := now;

       if edtStartAt.Time <> FrmMain.fIniServerConfig.ReadTime('Tasks','StartAt',Time) then
          begin
          ReplaceTime(MyTime, edtStartAt.Time);
          lbStartat.Caption  := 'Start schedule: ' + DateTimeToStr(MyTime);
          end;

       Case cbxTime.ItemIndex of
         0 :MyTime := (AddHours(MyTime, UpDownTime.Position));
         1 :MyTime := (AddMinutes(MyTime, UpDownTime.Position));
       end;

       Case rdOccurs.ItemIndex of
         0: MyTime := IncDay(MyTime, 0);
         1: MyTime := IncDay(MyTime, 7);
         2: MyTime := IncMonth(MyTime, 1);
       end;
     end;

 lbSchedule.Caption := 'Next schedule: ' + DateTimeToStr(MyTime);

end;

procedure TFrmSchedule.rdOccursClick(Sender: TObject);
begin
   UpdateNextSchedule;
end;

procedure TFrmSchedule.FormShow(Sender: TObject);
begin
  fUpdate := True;
end;

function TFrmSchedule.BuildSchedule(Schedule: String): String;
var
  StartDate, NextSchedule : TDateTime;
  Occurs, Interval, Every, CallJob : Integer;
  StartAt : TTime;
begin

   StartDate    := Now;
   NextSchedule := Now;
   Occurs       := 0;
   Interval     := 1;
   Every        := 0;
   CallJob      := 10;
   StartAt      := Time;

   if Schedule <> '' then
      begin
      StartDate    := MyStrToDate(ParseParam(Schedule, SCHD_START_DATE));
      NextSchedule := MyStrToDate(ParseParam(Schedule, SCHD_NEX_SCHEDULE));
      Occurs       := StrToIntDef(ParseParam(Schedule, SCHD_OCCURS),0);
      Interval     := StrToIntDef(ParseParam(Schedule, SCHD_INTERVAL),1);
      Every        := StrToIntDef(ParseParam(Schedule, SCHD_EVERY),0);
      CallJob      := StrToIntDef(ParseParam(Schedule, SCHD_CALLJOB),10);
      StartAt      := StrToTimeDef(ParseParam(Schedule, SCHD_START_TIME),Time);
      end;

   IniDate.Date        := StartDate;
   rdOccurs.ItemIndex  := Occurs;
   UpDownTime.Position := Interval;
   cbxTime.ItemIndex   := Every;
   edtStartAt.Time     := StartAt;
   udRefresh.Position  := CallJob;
   MyTime              := NextSchedule;

   Result := Schedule;

   ShowModal;

   if (ModalResult = mrOK) then
      Result := SCHD_START_DATE   + DateTimeToStr(IniDate.Date)   + ';' +
                SCHD_NEX_SCHEDULE + DateTimeToStr(MyTime)         + ';' +
                SCHD_OCCURS       + IntToStr(rdOccurs.ItemIndex)  + ';' +
                SCHD_INTERVAL     + IntToStr(UpDownTime.Position) + ';' +
                SCHD_EVERY        + IntToStr(cbxTime.ItemIndex)   + ';' +
                SCHD_CALLJOB      + IntToStr(udRefresh.Position)  + ';' +
                SCHD_START_TIME   + TimeToStr(edtStartAt.Time)    + ';';

   Close;

end;

end.
