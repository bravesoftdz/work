unit uFrmTimeControlUpdate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, LblEffct, Buttons, RadioButtonAll, Mask, PaiDeForms,
  Db, DBTables, DateBox, ADODB, SuperComboADO, siComp, siLangRT, Grids, DBGrids,
  SMDBGrid, PowerADOQuery, LookUpADOQuery, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ComCtrls, CommCtrl;

type
  TFrmTimeControlUpdate = class(TFrmParentForms)
    Panel2: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    pnlAdmUser: TPanel;
    scUserUpdate: TSuperComboADO;
    quListTimeGrid: TADOQuery;
    quListTimeGridEnterDate: TDateTimeField;
    quListTimeGridExitDate: TDateTimeField;
    dsListTimeGrid: TDataSource;
    Label2: TLabel;
    edtDateIniUp: TDateBox;
    Label3: TLabel;
    edtDateFimUp: TDateBox;
    btRefresh: TSpeedButton;
    quListTimeGridIDTime: TIntegerField;
    pnlUpdateHour: TPanel;
    Label1: TLabel;
    sbInsert: TSpeedButton;
    sbDelete: TSpeedButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel5: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    grdObjeto: TSMDBGrid;
    spHelp: TSpeedButton;
    btClose: TButton;
    btCancel: TButton;
    dsLookUpPerson: TDataSource;
    LookUpPerson: TLookUpADOQuery;
    LookUpPersonIDPessoa: TIntegerField;
    LookUpPersonIDComissionado: TIntegerField;
    LookUpPersonPessoa: TStringField;
    LookUpPersonCode: TIntegerField;
    beginTime: TDateTimePicker;
    endTime: TDateTimePicker;
    beginDate: TDateTimePicker;
    endDate: TDateTimePicker;
    procedure btRefreshClick(Sender: TObject);
    procedure sbInsertClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsListTimeGridStateChange(Sender: TObject);
    procedure quListTimeGridAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure dtpBeginDateExit(Sender: TObject);
    procedure dtpEndDateExit(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    buttonInsertPressed: Boolean;
    function CheckFields:Boolean;

    procedure ListTimeGridOpen;
    procedure ListTimeGridClose;
    procedure ListTimeGridCancel;
    procedure ListTimeGridSave;
    procedure ListTimeGridEdit;
    procedure ListTimeGridRefresh;

    // Antonio Marcos:  MR-234
    procedure clearFields;

  public
    { Public declarations }
    function Start(IDUser:Integer):Boolean;

  end;

implementation

uses uMsgBox, uDM, uDateTimeFunctions, uMsgConstant,
     uNumericFunctions, uDMGlobal, uSystemConst;

{$R *.DFM}

procedure TFrmTimeControlUpdate.ListTimeGridCancel;
begin
  with quListTimeGrid do
    if Active then
      if State in dsEditModes then
        Cancel;
end;

procedure TFrmTimeControlUpdate.ListTimeGridEdit;
begin
  ListTimeGridOpen;

  with quListTimeGrid do
    if Active then
      if not (State in dsEditModes) then
        Edit;
end;

procedure TFrmTimeControlUpdate.ListTimeGridOpen;
begin
  with quListTimeGrid do
    if not Active then
    begin
      Parameters.ParambyName('IDUser').Value    := MyStrToInt(scUserUpdate.LookUpValue);
      Parameters.ParambyName('IniDate').Value   := (edtDateIniUp.Date);
      Parameters.ParambyName('FimDate').Value   := (edtDateFimUp.Date+1);
      Open;

      sbDelete.Enabled := not quListTimeGrid.IsEmpty;
      pnlUpdateHour.Enabled := not quListTimeGrid.IsEmpty;
    end;
end;

procedure TFrmTimeControlUpdate.ListTimeGridClose;
begin
  ListTimeGridSave;

  with quListTimeGrid do
    if Active then
      Close;
end;

procedure TFrmTimeControlUpdate.ListTimeGridSave;
begin
  with quListTimeGrid do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFrmTimeControlUpdate.ListTimeGridRefresh;
begin
  ListTimeGridClose;
  ListTimegridOpen;
end;

function TFrmTimeControlUpdate.Start(IDUser:Integer):Boolean;
begin
  edtDateIniUp.Date := Date-7;
  edtDateFimUp.Date := Date;

  if IDUser <> -1 then
  begin
    scUserUpdate.LookUpValue := IntToStr(IDUser);
    ListTimeGridRefresh;
  end;
  buttonInsertPressed := false;
  ShowModal;
end;

function TFrmTimeControlUpdate.CheckFields:Boolean;
begin
  Result := False;

  if trim(scUserUpdate.Text) = '' then
  begin
    MsgBox(MSG_INF_SELECT_USER, vbOKOnly + vbInformation);
    scUserUpdate.SetFocus;
    Exit;
  end;

  if not TestDate(edtDateIniUp.text) Then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
    edtDateIniUp.SetFocus;
    Exit;
  end;

  if not TestDate(edtDateFimUp.Text) Then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
    edtDateFimUp.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmTimeControlUpdate.btRefreshClick(Sender: TObject);
begin
  if not CheckFields then
    Exit;

  //Atualizar a grid
  ListTimeGridRefresh;
end;

procedure TFrmTimeControlUpdate.sbInsertClick(Sender: TObject);
Var
   iIDUser : Integer;
begin
  clearFields;
  buttonInsertPressed := true;
  sbInsert.Enabled := false;
  pnlUpdateHour.Enabled := true;
end;

procedure TFrmTimeControlUpdate.sbDeleteClick(Sender: TObject);
begin
  if not CheckFields then
    Exit;

   //Deleta o registro
   try
     quListTimeGrid.Delete;
   except
     MsgBox(MSG_CRT_ERROR_OCURRED, vbOKOnly + vbCritical);
   end;

   //REfresh a query
   ListTimeGridRefresh;
end;

procedure TFrmTimeControlUpdate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if LookUpPerson.Active then
    LookUpPerson.Close;

  if ModalResult = mrCancel then
    ListTimeGridCancel;
  ListTimeGridClose;
  Action := caFree;
end;

procedure TFrmTimeControlUpdate.dsListTimeGridStateChange(Sender: TObject);
begin
  with quListTimeGrid do
    if Active then
      sbDelete.Enabled := not (EOF AND BOF)
    else
      sbDelete.Enabled := False;
end;

procedure TFrmTimeControlUpdate.quListTimeGridAfterScroll(
  DataSet: TDataSet);
begin

  // Antonio Marcos:  MR-234
  if quListTimeGrid.Active then
  begin
    if quListTimeGridEnterDate.IsNull then
    begin
      //mskDateIn.Clear;
      //beginTime.
    end
    else
    begin
      beginDate.Date  := quListTimeGridEnterDate.AsDateTime;
      beginTime.Time  := quListTimeGridEnterDate.AsDateTime;
    end;

    if quListTimeGridExitDate.IsNull then
    begin
      //mskDateOut.Clear;
      //endTime.CleanupInstance;
    end
    else
    begin
      endDate.date  := quListTimeGridExitDate.AsDateTime;
      endTime.time  := quListTimeGridExitDate.AsDateTime;
    end;
  end;

end;

procedure TFrmTimeControlUpdate.FormShow(Sender: TObject);
begin
  inherited;
  if not LookUpPerson.Active then
    LookUpPerson.Open;


  pnlUpdateHour.Enabled := ( scUserUpdate.LookUpValue <> '') and ( buttonInsertPressed );

  // move default date as from as today
  beginDate.Date := now;
  endDate.Date := beginDate.Date;

end;

procedure TFrmTimeControlUpdate.dtpBeginDateExit(Sender: TObject);
begin
  inherited;
  ListTimeGridEdit;

  // Antonio Marcos:  MR-234
  quListTimeGridEnterDate.AsDateTime := beginDate.date + beginTime.time;
end;

procedure TFrmTimeControlUpdate.dtpEndDateExit(Sender: TObject);
begin
  inherited;
  ListTimeGridEdit;
  // Antonio Marcos:  MR-234
  quListTimeGridExitDate.AsDateTime := endDate.Date + endTime.time;
end;

procedure TFrmTimeControlUpdate.clearFields;
begin
  // to clean up datetimepicker

  beginDate.Date := now;
  endDate.date := now;

  beginTime.Time := now;
  endTime.Time := now;
(*
  dateTime_setFormat(beginDate.Handle, ' ' );
  dateTime_setFormat(beginTime.Handle, ' ');
  dateTime_setFormat(endDate.Handle, ' ');
  dateTime_setFormat(endTime.Handle, ' ');
*)
end;

procedure TFrmTimeControlUpdate.btCloseClick(Sender: TObject);
var
  iIdUser: Integer;
  strDate, strTime: String;
  strBeginDateTime: String;
  strEndDateTime: String;
begin
  if not CheckFields then
    Exit;

//Pegar o IDUser da pessoa a ser alterada
  With DM.quFreeSQL do
  begin
    If Active then
      Close;
    SQL.Clear;
    SQL.Add('Select IDUser from SystemUser');
    SQL.Add('Where ComissionID = '+scUserUpdate.LookUpValue);
    Open;
    iIDUser := FieldByName('IDUser').AsInteger;
    Close;

    // update employee selected by grid.
    if ( not quListTimeGrid.IsEmpty and sbInsert.enabled) then begin

        With DM.quFreeSQL do
        begin
          If Active then
            Close;
          SQL.Clear;
          SQL.Add('UPDATE TMC_TimeControl SET IDStore = :IDStore, IDUser = :IDUser, IDPessoa = :IDPessoa, EnterDate = :DateIni, ExitDate = :DateEnd');
          SQL.Add('WHERE  IDTime = :IDTime');

          Parameters.ParambyName('IDTime').Value     := quListTimeGridIDTime.Value;
          Parameters.ParambyName('IDStore').Value    := DM.fStore.ID;
          Parameters.ParambyName('IDUser').Value     := iIDUser;
          Parameters.ParambyName('IDPessoa').Value   := scUserUpdate.LookUpValue;

          strDate := formatDateTime('mm/dd/yyyy', beginDate.Date);
          strTime := FormatDateTime('tt', beginTime.Date);
          strBeginDateTime := strDate + ' ' + strTime;
          Parameters.ParambyName('DateIni').Value    := strToDateTime(strBeginDateTime);

          strDate := formatDateTime('mm/dd/yyyy', endDate.Date);
          strTime := FormatDateTime('tt', endTime.Date);
          strEndDateTime := strDate + ' ' + strTime;
          Parameters.ParambyName('DateEnd').Value  := strToDateTime(strEndDateTime);
          ExecSQL;

       end;

    end;

  end;

  // addding a new time control to employee selected
  if (not sbInsert.Enabled ) then begin

      With DM.quFreeSQL do
      begin
        If Active then
          Close;
        SQL.Clear;
        SQL.Add('INSERT INTO TMC_TimeControl  (IDTime, IDStore, IDUser, IDPessoa, EnterDate, ExitDate)');
        SQL.Add('VALUES  (:IDTime, :IDStore, :IDUser, :IDPessoa, :DateIni, :DateEnd)');

        Parameters.ParambyName('IDTime').Value     := DM.GetNextID(MR_TIME_CONTROL_ID);
        Parameters.ParambyName('IDStore').Value    := DM.fStore.ID;
        Parameters.ParambyName('IDUser').Value     := iIDUser;
        Parameters.ParambyName('IDPessoa').Value   := scUserUpdate.LookUpValue;

        // Antonio Marcos:  MR-234 / MR-261
        strDate := formatDateTime('mm/dd/yyyy', beginDate.Date);
        strTime := FormatDateTime('tt', beginTime.Date);
        strBeginDateTime := strDate + ' ' + strTime;
        Parameters.ParambyName('DateIni').Value    := strToDateTime(strBeginDateTime);

        strDate := formatDateTime('mm/dd/yyyy', endDate.Date);
        strTime := FormatDateTime('tt', endTime.Date);
        strEndDateTime := strDate + ' ' + strTime;

        Parameters.ParambyName('DateEnd').Value  := strToDateTime(strEndDateTime);

        ExecSQL;
       end;

   end;

   //Atualiza o grid
   ListTimeGridRefresh;

   sbInsert.Enabled := true;
   buttonInsertPressed := false;

end;

end.
