unit uFchRebateCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, cxSpinEdit, cxTimeEdit,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Mask, DBCtrls, CheckLst, uSystemTypes,
  SuperComboADO;

type
  TFchRebateCalendar = class(TbrwFrmParent)
    quFormIDRebateCalendar: TIntegerField;
    quFormDescription: TStringField;
    quFormDaysOfWeek: TStringField;
    quFormDiscountPerc: TFloatField;
    quFormStartDate: TDateTimeField;
    quFormEndDate: TDateTimeField;
    lblDescription: TLabel;
    edtDescription: TDBEdit;
    lblDaysOfWeek: TLabel;
    lblDiscountPerc: TLabel;
    edtDiscountPerc: TDBEdit;
    lblStartDate: TLabel;
    lblEndDate: TLabel;
    dbStartDate: TcxDBDateEdit;
    dbStartTime: TcxDBTimeEdit;
    dbEndTime: TcxDBTimeEdit;
    dbEndDate: TcxDBDateEdit;
    cbxDayOfWeek: TCheckListBox;
    lblStore: TLabel;
    scStore: TDBSuperComboADO;
    btStoreAll: TButton;
    quFormIDStore: TIntegerField;
    lbNeedX: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btStoreAllClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btNextRecClick(Sender: TObject);
    procedure btLastRecClick(Sender: TObject);
  private
    procedure SetDayOfWeek;
    procedure GetDayOfweek;
    function ValidateDaysOfWeek:Boolean;
  protected
    function OnValidadeField: boolean; override;
  end;

implementation

uses uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFchRebateCalendar.SetDayOfWeek;
var
  i : Integer;
  DayOfWeek: String;
begin
  for i := 0 to cbxDayOfWeek.Items.Count-1 do
    if cbxDayOfWeek.Checked[i] then
        DayOfWeek := DayOfWeek + InttoStr(i + 1) + ';';

  quForm.Edit;
  quFormDaysOfWeek.AsString := DayOfWeek;
end;

procedure TFchRebateCalendar.GetDayOfweek;
var
  i,value : Integer;
  DaysOfWeek : String;
begin

  for i := 0 to cbxDayOfWeek.Count-1 do
    cbxDayOfWeek.Checked[i] := (frmCommand = btInc);

  if (frmCommand <> btInc) then
  begin
    DaysOfWeek := StringReplace(quFormDaysOfWeek.AsString,';','',[rfReplaceAll]);

    for i := 1 to length(DaysOfWeek) do
    begin
      value := StrToInt(copy(DaysOfWeek,i,1)) -1;
      cbxDayOfWeek.Checked[value] := True;
    end;
  end;
end;
procedure TFchRebateCalendar.FormShow(Sender: TObject);
begin
  inherited;
  GetDayOfweek;
end;

procedure TFchRebateCalendar.btStoreAllClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<'+ btStoreAll.Caption +'>';
end;

function TFchRebateCalendar.ValidateDaysOfWeek: Boolean;
Var
  i: Integer;
begin
  Result := False;

  for i := 0 to Pred(cbxDayOfWeek.Count) do
  begin
    if cbxDayOfWeek.Checked[i] then
      Result := True;
  end;

  if not Result then
    MsgBox(MSG_INF_NOT_DAYSOFWEEK_EMPTY, vbOKOnly + vbCritical);
end;

procedure TFchRebateCalendar.btCloseClick(Sender: TObject);
begin
  SetDayOfWeek;
  if ValidateDaysOfWeek then
    inherited;
end;

procedure TFchRebateCalendar.btFirstRecClick(Sender: TObject);
begin
  inherited;
  GetDayOfweek;
end;

procedure TFchRebateCalendar.btPriorRecClick(Sender: TObject);
begin
  inherited;
  GetDayOfweek;
end;

procedure TFchRebateCalendar.btNextRecClick(Sender: TObject);
begin
  inherited;
  GetDayOfweek;
end;

procedure TFchRebateCalendar.btLastRecClick(Sender: TObject);
begin
  inherited;
  GetDayOfweek;
end;

function TFchRebateCalendar.OnValidadeField: boolean;
begin
  if (edtDescription.Text = '') then
  begin
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbCritical + vbOKOnly);
    edtDescription.SetFocus;
    Result := False;
    Exit;
  end;

  if (edtDiscountPerc.Text = '') then
  begin
    MsgBox(MSG_INF_NOT_DISCOUNT_EMPTY, vbCritical + vbOKOnly);
    edtDiscountPerc.SetFocus;
    Result := False;
    Exit;
  end;

  if (dbStartDate.Text = '') or (dbStartTime.Text = '') then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOKOnly);
    dbStartDate.SetFocus;
    Result := False;
    Exit;
  end;
end;

end.
