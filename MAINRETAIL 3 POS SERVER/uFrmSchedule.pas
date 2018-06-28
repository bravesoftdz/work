unit uFrmSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DateBox, IniFiles, ComCtrls,
  siComp, uPOSServerConsts;

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
    cbxShcedule: TComboBox;
    chkDebug: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdOccursClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxShceduleChange(Sender: TObject);
  private
    { Private declarations }
    fSchedureType : String;
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
   IniDate.Date               := FrmMain.fIniConfig.ReadDate(fSchedureType,'StartDate', Now);
   rdOccurs.ItemIndex         := FrmMain.fIniConfig.ReadInteger(fSchedureType,'Occurs',0);
   UpDownTime.Position        := FrmMain.fIniConfig.ReadInteger(fSchedureType,'Interval',1);
   cbxTime.ItemIndex          := FrmMain.fIniConfig.ReadInteger(fSchedureType,'Every',0);
   edtStartAt.Time            := FrmMain.fIniConfig.ReadTime(fSchedureType,'StartAt',Time);
   if fSchedureType = SCH_SERVER then
      udRefresh.Position      := FrmMain.fIniConfig.ReadInteger('Timer','CallJobGlobal',15)
   else
      udRefresh.Position      := FrmMain.fIniConfig.ReadInteger('Timer','CallJobLog',10);
   MyTime                     := FrmMain.fIniConfig.ReadDateTime(fSchedureType,'NextSchedule', Now);
   chkDisableSchedule.Checked := FrmMain.fIniConfig.ReadBool(fSchedureType,'DisableSchedule', False);
end;

procedure TFrmSchedule.SetSchedule;
begin
  FrmMain.fIniConfig.WriteDate(fSchedureType,'StartDate', IniDate.Date);
  FrmMain.fIniConfig.WriteInteger(fSchedureType,'Occurs', rdOccurs.ItemIndex);
  FrmMain.fIniConfig.WriteInteger(fSchedureType,'Interval', UpDownTime.Position);
  FrmMain.fIniConfig.WriteInteger(fSchedureType,'Every', cbxTime.ItemIndex);
  FrmMain.fIniConfig.WriteTime(fSchedureType,'StartAt', edtStartAt.Time);
  FrmMain.fIniConfig.WriteDateTime(fSchedureType,'NextSchedule', MyTime);

  if fSchedureType = SCH_SERVER then
     FrmMain.fIniConfig.WriteInteger('Timer','CallJobGlobal', udRefresh.Position)
  else
     FrmMain.fIniConfig.WriteInteger('Timer','CallJobLog', udRefresh.Position);

  FrmMain.fIniConfig.WriteBool(fSchedureType,'DisableSchedule', chkDisableSchedule.Checked);
  FrmMain.LoadParamTask(fSchedureType);
end;

function TFrmSchedule.Start:Boolean;
begin

    fUpdate := False;

    fSchedureType := SCH_SERVER;
    GetSchedule;

    chkDebug.Checked := frmMain.fDebug;

    ShowModal;

    frmMain.fDebug := chkDebug.Checked;

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
       MyTime := IniDate.Date;

       if edtStartAt.Time <> FrmMain.fIniConfig.ReadTime(fSchedureType,'StartAt',Time) then
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

procedure TFrmSchedule.cbxShceduleChange(Sender: TObject);
begin
  case cbxShcedule.ItemIndex of
    0 : fSchedureType := SCH_SERVER;
    1 : fSchedureType := SCH_POS;
    end;
  GetSchedule;
end;

end.
