unit uFrmSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DateBox, IniFiles, ComCtrls,
  siComp;

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
    chkDisableSchedule: TCheckBox;
    siLang: TsiLang;
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
  end;


implementation

uses uMainConf, uDateTimeFunctions, DateUtils, uDMGlobal;

{$R *.dfm}

procedure TFrmSchedule.GetSchedule;
begin
   IniDate.Date               := FrmMain.fIniConfig.ReadDate('Tasks','StartDate', Now);
   rdOccurs.ItemIndex         := FrmMain.fIniConfig.ReadInteger('Tasks','Occurs',0);
   UpDownTime.Position        := FrmMain.fIniConfig.ReadInteger('Tasks','Interval',1);
   cbxTime.ItemIndex          := FrmMain.fIniConfig.ReadInteger('Tasks','Every',0);
   edtStartAt.Time            := FrmMain.fIniConfig.ReadTime('Tasks','StartAt',Time);
   udRefresh.Position         := FrmMain.fIniConfig.ReadInteger('Timer','CallJob',10);
   MyTime                     := FrmMain.fIniConfig.ReadDateTime('Tasks','NextSchedule', Now);
   chkDisableSchedule.Checked := FrmMain.fIniConfig.ReadBool('Tasks','DisableSchedule', False);
   chkUpdateQty.Checked       := FrmMain.fIniConfig.ReadBool('Setup','DisableUpdateQty', False);
end;

procedure TFrmSchedule.SetSchedule;
begin
  FrmMain.fIniConfig.WriteDate('Tasks','StartDate', IniDate.Date);
  FrmMain.fIniConfig.WriteInteger('Tasks','Occurs', rdOccurs.ItemIndex);
  FrmMain.fIniConfig.WriteInteger('Tasks','Interval', UpDownTime.Position);
  FrmMain.fIniConfig.WriteInteger('Tasks','Every', cbxTime.ItemIndex);
  FrmMain.fIniConfig.WriteTime('Tasks','StartAt', edtStartAt.Time);
  FrmMain.fIniConfig.WriteDateTime('Tasks','NextSchedule', MyTime);
  FrmMain.fIniConfig.WriteInteger('Timer','CallJob', udRefresh.Position);
  FrmMain.fIniConfig.WriteBool('Tasks','DisableSchedule', chkDisableSchedule.Checked);
  FrmMain.fIniConfig.WriteBool('Setup','DisableUpdateQty', chkUpdateQty.Checked);
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

       if edtStartAt.Time <> FrmMain.fIniConfig.ReadTime('Tasks','StartAt',Time) then
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

end.
