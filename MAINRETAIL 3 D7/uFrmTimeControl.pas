unit uFrmTimeControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, LblEffct, Db, DBTables, PaiDeForms,
  ADODB, PAIDETODOS, siComp, siLangRT, Grids, DBGrids, SMDBGrid;

type
  TFrmTimeControl = class(TFrmParentForms)
    Panel2: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    quTimeControl: TADOQuery;
    quTimeControlEnterDate: TDateTimeField;
    quTimeControlExitDate: TDateTimeField;
    lbUserName: TLabel;
    lbStore: TLabel;
    quTimeControlIDTime: TIntegerField;
    quCheckUser: TADOQuery;
    sbClockIN: TSpeedButton;
    sbClockOUT: TSpeedButton;
    quCheckUserExitDate: TDateTimeField;
    quCheckUserExpirationDate: TDateTimeField;
    quInsertAndUpDate: TADOQuery;
    quCheckUserEnterDate: TDateTimeField;
    quListTimeGrid: TADOQuery;
    dsListTimeGrid: TDataSource;
    btnPrint: TBitBtn;
    sbUpdateTime: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    lbDate: TLabel;
    grdObjeto: TSMDBGrid;
    spHelp: TSpeedButton;
    btReg: TButton;
    quListTimeGridenterDate: TDateTimeField;
    quListTimeGridExitDate: TDateTimeField;
    quListTimeGridIDPessoa: TIntegerField;
    quListTimeGridIDUser: TIntegerField;
    quListTimeGridIDTime: TIntegerField;
    quListTimeGridStore: TStringField;
    quListTimeGridUserName: TStringField;
    quListTimeGridEnterDateAMPM: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure sbClockOUTClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure sbUpdateTimeClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdObjetoDblClick(Sender: TObject);
  private
    { Private declarations }
    iIDPessoa, iIDTime : Integer;
    bIsUserIN : Boolean;
    function UserIN:Boolean;
    function TimeExpirate:Boolean;
    function CheckUser(IDTime:Integer):Boolean;

    procedure ListTimeGridOpen;
    procedure ListTimeGridClose;
    procedure ListTimeGridRefresh;

  public
    { Public declarations }
    procedure Start(IDPessoa:Integer);
  end;


implementation

uses uDM, uPassWord, uMsgBox, uFrmTimeControlPrint, uFrmTimeControlUpdate,
     uMsgConstant, uDMGlobal, uSystemConst, uFchParam;

{$R *.DFM}

procedure TFrmTimeControl.ListTimeGridOpen;
begin

  with quListTimeGrid do
     If not Active then
        Open;

end;

procedure TFrmTimeControl.ListTimeGridClose;
begin

  with quListtimeGrid do
     if Active then
        Close;

end;

procedure TFrmTimeControl.ListTimeGridRefresh;
var
 iIDTime : integer;
begin

   with quListTimeGrid do
       if Active then
          iIDTime := quListTimeGridIDTime.AsInteger;

   ListTimeGridClose;
   ListTimeGridOpen;

   quListTimeGrid.Locate('IDTime', IntToStr(iIDTime), [] );

end;


function TFrmTimeControl.TimeExpirate:Boolean;
var
iMaxHour, iWorkedHour : integer;
begin
Result := False;
//pega o numero max de horas por dia
iMaxHour := DM.fSystem.SrvParam[PARAM_MAX_WORKING_HOUR_PER_DAY];
with quCheckUser do
   begin
   If Active then
      Close;
   Parameters.ParamByName('IDTime').Value      := iIDTime;
   Parameters.ParamByName('MaxWorkHour').Value := iMaxHour;
   Open;
   If quCheckUserExpirationDate.AsDateTime < DM.GetServerDate then
      begin
      with quInsertAndUpDate do
         begin
         If Active then
            Close;

         SQL.Clear;
         SQL.Add('UPDATE TMC_TimeControl SET  ExitDate = :ExitDate');
         SQL.Add('WHERE IDTime = :IDTime');

         Parameters.ParamByName('ExitDate').Value := quCheckUserEnterDate.AsDateTime;
         Parameters.ParamByName('IDTime').Value   := iIDTime;

         ExecSQL;
         end;
      Result := True;
      end;
   Close;
   end;
end;

function TFrmTimeControl.CheckUser(IDTime:Integer):Boolean;
begin
 With quCheckUser do
    begin
    If Active then
       Close;
    Parameters.ParamByName('IDTime').Value := IDTime;
    Open;
    If RecordCount = 0 then
       Result := False
    else
       Result := True;
    end;

end;

function TFrmTimeControl.UserIN:Boolean;
begin
   with quTimeControl do
      begin
      If Active then
         Close;
      Parameters.ParamByName('IDStore').Value  := DM.fStore.ID;
      Parameters.ParamByName('IDUser').Value   := DM.fUser.ID;
      Parameters.ParamByName('IDPessoa').Value := iIDPessoa;
      open;
      If RecordCount = 0 then
         Result := False
      else
         begin
         iIDTime := quTimeControlIDTime.AsInteger;
         If TimeExpirate then
            begin
            MsgBox(MSG_INF_EXPIRED_TIME, vbOKOnly + vbInformation);
            Result := False;
            end
         else
            Result  := True;
         end;
      Close;
      end;
end;

procedure TFrmTimeControl.Start(IDPessoa:Integer);
begin
  iIDPessoa := IDPessoa;
  ShowModal;
end;

procedure TFrmTimeControl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListTimeGridClose;
  //Clock.Active := False;
  Action := caFree;
end;

procedure TFrmTimeControl.FormShow(Sender: TObject);
begin
  inherited;

  DM.SetClientToServerDate;
  //Clock.Active   := True;
  lbDate.Caption := DateToStr(now);


  lbUserName.Caption := DM.fUser.UserName;
  lbStore.Caption    := DM.fStore.Name;

  If not UserIN then
     begin
     bIsUserIN             := True;
     lbUserName.Font.Color := clBlue;
     lbStore.Font.Color    := clBlue;
     sbClockIN.Enabled     := True;
     sbClockOUT.Enabled    := False;
     end
  else
     begin
     bIsUserIN             := False;
     sbClockIN.Enabled     := False;
     sbClockOUT.Enabled    := True;
     lbUserName.Font.Color := clGreen;
     lbStore.Font.Color    := clGreen;
     end;

  ListTimeGridRefresh;

  sbUpdateTime.Enabled := Password.HasFuncRight(40);

  if DM.IsFormsRestric(Self.Name) then
     begin
     sbClockIN.Visible    := False;
     sbClockOUT.Visible   := False;
     sbUpdateTime.Visible := False;
     end;

end;

procedure TFrmTimeControl.sbClockOUTClick(Sender: TObject);
var
sCompletSQL : String;
begin
//Verificar se ja foi colocado a hora exit
If not bIsUserIN then
   If not CheckUser(iIDTime) then
      begin
      with quInsertAndUpDate do
         begin
         If Active then
            Close;
         SQL.Clear;
         SQL.Add('UPDATE TMC_TimeControl SET  ExitDate = EnterDate');
         SQL.Add('WHERE IDTime = '+ IntToStr(iIDTime));
         ExecSQL;
         end;
      MsgBox(MSG_INF_TIME_ENTERED, vbOKOnly + vbInformation);
      sbClockIN.Enabled  := True;
      sbClockOUT.Enabled := False;
      ListTimeGridRefresh;
      bIsUserIN := True;
      Exit;
      end;

with quInsertAndUpDate do
   begin
   //Verifica se o User esta Clock In
   If not UserIN then
      begin
        try
         If Active then
            Close;
         SQL.Clear;
         SQL.Add('INSERT INTO TMC_TimeControl  (IDTime, IDStore, IDUser, IDPessoa, EnterDate)');
         SQL.Add('VALUES  (:IDTIme, :IDStore, :IDUser, :IDPessoa, :EnterDate)');

         Parameters.ParamByName('IDTime').Value     := DM.GetNextID(MR_TIME_CONTROL_ID);
         Parameters.ParamByName('IDStore').Value    := DM.fStore.ID;
         Parameters.ParamByName('IDUser').Value     := DM.fUser.ID;
         Parameters.ParamByName('IDPessoa').Value   := iIDPessoa;
         Parameters.ParamByName('EnterDate').Value  := DM.GetServerDate;
         ExecSQL;
         //Refresh User
         UserIN;
         bIsUserIN := False;
         MsgBox(MSG_INF_CLOCK_IN+'_'+DateTimeToStr(DM.GetServerDate), vbOKOnly + vbInformation);
        except
          MsgBox(MSG_CRT_NO_VALID_TIME, vbOKOnly + vbCritical);
        end;
      end
    else
      begin
        try
         If Active then
            Close;
         SQL.Clear;
         SQL.Add('UPDATE TMC_TimeControl SET  ExitDate = :ExitDate');
         SQL.Add('WHERE IDTime = :IDTime');

         Parameters.ParamByName('ExitDate').Value := DM.GetServerDate;
         Parameters.ParamByName('IDTime').Value   := iIDTime;
         ExecSQL;
         bIsUserIN := True;
         MsgBox(MSG_INF_CLOCK_OUT+'_'+DateTimeToStr(DM.GetServerDate), vbOKOnly + vbInformation);
         except
            MsgBox(MSG_CRT_NO_VALID_TIME, vbOKOnly + vbCritical);
          end;
      end;
   end;

   If Sender = sbClockIN then
      begin
      sbClockIN.Enabled  := False;
      sbClockOUT.Enabled := True;
      end
   else
      begin
      sbClockIN.Enabled  := True;
      sbClockOUT.Enabled := False;
      end;
      
   ListTimeGridRefresh;
end;

procedure TFrmTimeControl.btnPrintClick(Sender: TObject);
begin
  with TfrmTimeControlPrint.Create(Self) do
       Start(iIDPessoa, lbUserName.Caption);
end;

procedure TFrmTimeControl.sbUpdateTimeClick(Sender: TObject);
begin
  with TFrmTimeControlUpdate.Create(Self) do
       Start(-1);

  ListTimeGridRefresh;
end;

procedure TFrmTimeControl.spHelpClick(Sender: TObject);
begin
  Application.HelpContext(2120);
end;

procedure TFrmTimeControl.grdObjetoDblClick(Sender: TObject);
begin

   //Validar o accesso
   if sbUpdateTime.Enabled then
      begin
      with TFrmTimeControlUpdate.Create(Self) do
            Start(quListTimeGridIDPessoa.AsInteger);
      ListTimeGridRefresh;
      end;

end;

end.
