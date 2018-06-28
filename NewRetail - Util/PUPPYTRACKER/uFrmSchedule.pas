unit uFrmSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DateBox, IniFiles, ComCtrls;

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
    Label5: TLabel;
    edtDelHist: TEdit;
    UpDownDelHist: TUpDown;
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

uses uDateTimeFunctions, DateUtils, uDM, uFrmMain;

{$R *.dfm}

procedure TFrmSchedule.GetSchedule;
begin
   IniDate.Date               := DM.fPetInfo.ReadDate('Schedule','StartDate', Now);
   rdOccurs.ItemIndex         := DM.fPetInfo.ReadInteger('Schedule','Occurs',0);
   UpDownTime.Position        := DM.fPetInfo.ReadInteger('Schedule','Interval',1);
   cbxTime.ItemIndex          := DM.fPetInfo.ReadInteger('Schedule','Every',0);
   edtStartAt.Time            := DM.fPetInfo.ReadTime('Schedule','StartAt',Time);
   udRefresh.Position         := DM.fPetInfo.ReadInteger('Timer','CallJob',10);
   MyTime                     := DM.fPetInfo.ReadDateTime('Schedule','NextSchedule', Now);
   chkDisableSchedule.Checked := DM.fPetInfo.ReadBool('Schedule','DisableSchedule', False);
   UpDownDelHist.Position     := DM.fPetInfo.ReadInteger('History','ClearDays',15);
end;

procedure TFrmSchedule.SetSchedule;
begin
  DM.fPetInfo.WriteDate('Schedule','StartDate', IniDate.Date);
  DM.fPetInfo.WriteInteger('Schedule','Occurs', rdOccurs.ItemIndex);
  DM.fPetInfo.WriteInteger('Schedule','Interval', UpDownTime.Position);
  DM.fPetInfo.WriteInteger('Schedule','Every', cbxTime.ItemIndex);
  DM.fPetInfo.WriteTime('Schedule','StartAt', edtStartAt.Time);
  DM.fPetInfo.WriteDateTime('Schedule','NextSchedule', MyTime);
  DM.fPetInfo.WriteInteger('Timer','CallJob', udRefresh.Position);
  DM.fPetInfo.WriteBool('Schedule','DisableSchedule', chkDisableSchedule.Checked);
  DM.fPetInfo.WriteInteger('History','ClearDays',UpDownDelHist.Position);

  FrmMain.LoadParamTask;
end;

function TFrmSchedule.Start:Boolean;
begin

    fUpdate := False;

    GetSchedule;

    ShowModal;

    Result := (ModalResult = mrOK);

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

       if edtStartAt.Time <> DM.fPetInfo.ReadTime('Schedule','StartAt',Time) then
          begin
          ReplaceTime(MyTime, edtStartAt.Time);
          lbStartat.Caption  := 'Start schedule: ' + DateTimeToStr(MyTime);
          end;

       Case cbxTime.ItemIndex of
         0 : MyTime := (AddHours(MyTime, UpDownTime.Position));
         1 : MyTime := (AddMinutes(MyTime, UpDownTime.Position));
       end;

       Case rdOccurs.ItemIndex of
         0 : MyTime := IncDay(MyTime, 0);
         1 : MyTime := IncDay(MyTime, 7);
         2 : MyTime := IncMonth(MyTime, 1);
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
