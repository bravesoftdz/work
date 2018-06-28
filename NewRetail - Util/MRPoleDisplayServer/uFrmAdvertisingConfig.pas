unit uFrmAdvertisingConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Menus, Mask, DBCtrls, cxDBEdit, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxSpinEdit,
  cxCalendar, CheckLst, cxCheckBox, siComp;

type
  TFrmAdvertisingConfig = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    pnlFilter: TPanel;
    grdAdvertisingDB: TcxGridDBTableView;
    grdAdvertisingLevel1: TcxGridLevel;
    grdAdvertising: TcxGrid;
    dsAdvertising: TDataSource;
    grdAdvertisingDBDescription: TcxGridDBColumn;
    grdAdvertisingDBFileName: TcxGridDBColumn;
    grdAdvertisingDBStartDate: TcxGridDBColumn;
    grdAdvertisingDBEndDate: TcxGridDBColumn;
    grdAdvertisingDBDaysOfWeekString: TcxGridDBColumn;
    grdAdvertisingDBDuration: TcxGridDBColumn;
    Button1: TButton;
    pnlNewAdveritising: TPanel;
    btnAddAdveritising: TButton;
    btnAbortAdv: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbxType: TcxDBImageComboBox;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    btnImgLogo: TSpeedButton;
    OP: TOpenDialog;
    Label4: TLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    Label5: TLabel;
    cxDBDateEdit2: TcxDBDateEdit;
    Label6: TLabel;
    Label8: TLabel;
    cxDBSpinEdit3: TcxDBSpinEdit;
    Label9: TLabel;
    chkDaysOfWeek: TCheckListBox;
    grdAdvertisingDBTypeString: TcxGridDBColumn;
    dtStart: TcxDateEdit;
    Label10: TLabel;
    Label11: TLabel;
    dtEnd: TcxDateEdit;
    cbxAdType: TcxComboBox;
    Label12: TLabel;
    cbxControlVideo: TcxDBCheckBox;
    chkDisplayDescrip: TcxDBCheckBox;
    grdAdvertisingDBDisplayDescription: TcxGridDBColumn;
    chkHours: TCheckListBox;
    siLang: TsiLang;
    pnlButtoms: TPanel;
    btnNew: TSpeedButton;
    btnEdit: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAbortAdvClick(Sender: TObject);
    procedure btnImgLogoClick(Sender: TObject);
    procedure btnAddAdveritisingClick(Sender: TObject);
    procedure cxDBImageComboBox1PropertiesChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dsAdvertisingDataChange(Sender: TObject; Field: TField);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    FResult : Boolean;
    function GetWeekDayList: String;
    procedure SetWeekDayList(WeekDays : String);

    function GetHourList: String;
    procedure SetHourList(Hours : String);

    procedure FillWeekDays;
    procedure FillHours;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, DBClient, uDMGlobal;

{$R *.dfm}

{ TFrmAdvertisingConfig }

function TFrmAdvertisingConfig.Start: Boolean;
begin
  FResult := False;
  ShowModal;
  Result := FResult;
end;

procedure TFrmAdvertisingConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.cdsAdvertising.State in [dsEdit, dsInsert] then
    DM.cdsAdvertising.Cancel;
  Action := caFree;
end;

procedure TFrmAdvertisingConfig.btnCloseClick(Sender: TObject);
begin
  FResult := False;
  Close;
end;

procedure TFrmAdvertisingConfig.btnSaveClick(Sender: TObject);
begin
  DM.SaveAdvertising;
  FResult := True;
  Close;
end;

procedure TFrmAdvertisingConfig.btnAbortAdvClick(Sender: TObject);
begin
  pnlFilter.Visible := True;
  pnlNewAdveritising.Visible := False;
  if DM.cdsAdvertising.State in [dsEdit, dsInsert] then
    DM.cdsAdvertising.Cancel;
end;

procedure TFrmAdvertisingConfig.btnImgLogoClick(Sender: TObject);
begin
  if OP.Execute then
   if DM.cdsAdvertising.State in [dsEdit, dsInsert] then
     DM.cdsAdvertising.FieldByName('FileName').AsString := OP.FileName;
end;


procedure TFrmAdvertisingConfig.btnAddAdveritisingClick(Sender: TObject);
begin
  with DM.cdsAdvertising do
    if State in [dsEdit, dsInsert] then
    begin
      FieldByName('DaysOfWeek').AsString := GetWeekDayList;
      FieldByName('Hours').AsString := GetHourList;

      DM.FLastDesc := DM.FLastDesc + 1;
      Post;
      if (btnAddAdveritising.Tag = 0) then
        Append;
    end;
end;

function TFrmAdvertisingConfig.GetWeekDayList: String;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to chkDaysOfWeek.Items.Count-1 do
    if chkDaysOfWeek.Checked[i] then
      Result := Result + IntToStr(i+1) + ',';
end;

procedure TFrmAdvertisingConfig.SetWeekDayList(WeekDays: String);
var
  i : Integer;
begin
  for i := 0 to chkDaysOfWeek.Items.Count-1 do
    if Pos((IntToStr(i+1) + ','), WeekDays) > 0 then
      chkDaysOfWeek.Checked[i] := True;
end;

procedure TFrmAdvertisingConfig.FillWeekDays;
var
  i : Integer;
begin
  for i := 0 to chkDaysOfWeek.Items.Count-1 do
    chkDaysOfWeek.Checked[i] := True;
end;

procedure TFrmAdvertisingConfig.FillHours;
var
  i : Integer;
begin
  for i := 0 to chkHours.Items.Count-1 do
    chkHours.Checked[i] := True;
end;

procedure TFrmAdvertisingConfig.cxDBImageComboBox1PropertiesChange(
  Sender: TObject);
begin
  cbxControlVideo.Visible := False;

  if cbxType.ItemIndex = ADV_BITMAP then
    OP.Filter := ADV_BITMAP_EXT
  else if cbxType.ItemIndex = ADV_JPG then
    OP.Filter := ADV_JPG_EXT
  else if cbxType.ItemIndex = ADV_FLASH then
    OP.Filter := ADV_FLASH_EXT
  else if cbxType.ItemIndex = ADV_WEB then
    OP.Filter := ADV_WEB_EXT
  else if cbxType.ItemIndex = ADV_VIDEO then
  begin
    OP.Filter := ADV_VIDEO_EXT;
    cbxControlVideo.Visible := True;
  end;

end;

procedure TFrmAdvertisingConfig.Button1Click(Sender: TObject);
var
  AFilter : String;
begin

  if dtStart.Text <> '' then
    AFilter := 'StartDate <= ' + QuotedStr(FormatDateTime('ddddd', dtStart.Date));

  if dtEnd.Text <> '' then
    if AFilter = '' then
      AFilter := 'EndDate > ' + QuotedStr(FormatDateTime('ddddd', Now))
    else
      AFilter := AFilter + ' AND EndDate > ' + QuotedStr(FormatDateTime('ddddd', Now));

  if cbxAdType.Text <> '' then
    if AFilter = '' then
      AFilter := 'Type = ' + IntToStr(cbxAdType.ItemIndex)
    else
      AFilter := AFilter + ' AND Type = ' + IntToStr(cbxAdType.ItemIndex);

  with DM.cdsAdvertising do
  begin
    Filtered := False;
    Filter := AFilter;
    Filtered := True;
  end;

end;

procedure TFrmAdvertisingConfig.dsAdvertisingDataChange(Sender: TObject;
  Field: TField);
begin
  SetWeekDayList(DM.cdsAdvertising.FieldByName('DaysOfWeek').AsString);
  cbxControlVideo.Visible := DM.cdsAdvertising.FieldByName('VideoControl').AsBoolean;
end;

function TFrmAdvertisingConfig.GetHourList: String;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to chkHours.Items.Count-1 do
    if chkHours.Checked[i] then
      Result := Result + IntToStr(i+1) + ',';
end;

procedure TFrmAdvertisingConfig.SetHourList(Hours: String);
var
  i : Integer;
begin
  for i := 0 to chkHours.Items.Count-1 do
    if Pos((IntToStr(i+1) + ','), Hours) > 0 then
      chkHours.Checked[i] := True;
end;

procedure TFrmAdvertisingConfig.btnNewClick(Sender: TObject);
begin
  pnlFilter.Visible := False;
  pnlNewAdveritising.Visible := True;
  btnAddAdveritising.Caption := 'Add';
  btnAddAdveritising.Tag := 0;


  with DM.cdsAdvertising do
  begin
    Filtered := False;
    Filter := '';
  end;

  with DM.cdsAdvertising do
    if not (State in [dsEdit, dsInsert]) then
    begin
      Append;
      FillWeekDays;
      FillHours;
    end;

end;

procedure TFrmAdvertisingConfig.btnEditClick(Sender: TObject);
begin
  pnlFilter.Visible := False;
  pnlNewAdveritising.Visible := True;
  btnAddAdveritising.Caption := 'Save';
  btnAddAdveritising.Tag := 1;

  with DM.cdsAdvertising do
  begin
    Filtered := False;
    Filter := '';
  end;

  with DM.cdsAdvertising do
    if not (State in [dsEdit, dsInsert]) then
    begin
      Edit;
      SetWeekDayList(FieldByName('DaysOfWeek').AsString);
      SetHourList(FieldByName('Hours').AsString);
    end;

end;

end.
