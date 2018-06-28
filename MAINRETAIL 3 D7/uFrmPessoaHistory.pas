unit uFrmPessoaHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls, DB,
  ADODB, DBCtrls, DateBox, Mask, SuperComboADO, DBClient, Provider,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalendar, cxDBEdit,
  cxSpinEdit, cxTimeEdit;

type
  TFrmPessoaHistory = class(TFrmParent)
    btnSave: TButton;
    quPessoaHistory: TADODataSet;
    dsPessoaHistory: TDataSource;
    lbUser: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    scUser: TDBSuperComboADO;
    scCustomer: TDBSuperComboADO;
    Label35: TLabel;
    Label6: TLabel;
    memOBS: TDBMemo;
    Label7: TLabel;
    dspPessoaHistory: TDataSetProvider;
    cdsPessoaHistory: TClientDataSet;
    scType: TDBSuperComboADO;
    Label8: TLabel;
    quTypeResult: TADODataSet;
    quTypeResultIDPessoaHistoryResult: TIntegerField;
    quTypeResultIDPessoaHistoryType: TIntegerField;
    quTypeResultPessoaHistoryResult: TStringField;
    quTypeResultResultColor: TStringField;
    dspResultType: TDataSetProvider;
    cdsResultType: TClientDataSet;
    dsResultType: TDataSource;
    cbxResult: TcxDBLookupComboBox;
    Label9: TLabel;
    quPessoaHistoryIDPessoaHistory: TIntegerField;
    quPessoaHistoryIDPessoa: TIntegerField;
    quPessoaHistoryIDUser: TIntegerField;
    quPessoaHistoryIDPessoaHistoryType: TIntegerField;
    quPessoaHistoryIDPessoaHistoryResult: TIntegerField;
    quPessoaHistoryMovDate: TDateTimeField;
    quPessoaHistoryObs: TStringField;
    dtDate: TcxDBDateEdit;
    dtTime: TcxDBTimeEdit;
    procedure btCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure scTypeSelectItem(Sender: TObject);
    procedure scTypeAfterAddUpdate(Sender: TObject);
  private
    FApply       : Boolean;
    FIDPessoa    : Integer;
    FIDHistory   : Integer;
    FIDNewHistory: Integer;

    procedure TypeResultRefresh;
    procedure TypeResultClose;
    procedure TypeResultOpen;

    procedure RefreshHistory;
    procedure SaveChanges;
    procedure CancelChanges;

    function ValidateFields: Boolean;
  public
    function Start(AIDPessoa, AIDPessoaHistory: Integer; var AIDHistory: Integer): Boolean;
  end;

implementation

uses uDM, Math, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmPessoaHistory }

procedure TFrmPessoaHistory.CancelChanges;
begin
  with cdsPessoaHistory do
    if Active then
      if State in dsEditModes then
         Cancel;
  if FIDHistory = -1 then
    FIDNewHistory := -1;
end;

procedure TFrmPessoaHistory.RefreshHistory;
begin
   if FIDHistory <> -1 then
   begin
     with cdsPessoaHistory do
     begin
       if Active then
         Close;
       Params.ParamByName('IDPessoaHistory').Value := FIDHistory;
       Open;
       scTypeSelectItem(Self);
     end;
   end
   else
   begin
     with cdsPessoaHistory do
     begin
       if not Active then
         Open;
       Append;
       FIDNewHistory                                  := DM.GetNextID('Mnt_PessoaHistory.IDPessoaHistory');
       FieldByName('IDPessoaHistory').AsInteger       := FIDNewHistory;
       FieldByName('IDPessoa').AsInteger              := FIDPessoa;
       FieldByName('IDUser').AsInteger                := DM.fUser.ID;
       FieldByName('IDPessoaHistoryType').AsInteger   := 0;
       FieldByName('IDPessoaHistoryResult').AsInteger := 0;
       FieldByName('MovDate').AsDateTime              := Now;
     end;
   end;
end;

procedure TFrmPessoaHistory.SaveChanges;
begin
  with cdsPessoaHistory do
    if Active then
      if State in dsEditModes then
         ApplyUpdates(-1);
end;

function TFrmPessoaHistory.Start(AIDPessoa, AIDPessoaHistory: Integer;
  var AIDHistory: Integer): Boolean;
begin
  FApply        := False;

  FIDPessoa     := AIDPessoa;
  FIDHistory    := AIDPessoaHistory;
  FIDNewHistory := AIDPessoaHistory;

  TypeResultRefresh;
  RefreshHistory;

  if AIDPessoaHistory = -1 then
  begin
    cdsResultType.Filtered := True;
    cdsResultType.Filter   := 'IDPessoaHistoryType = -1';
  end;

  ShowModal;

  if not FApply then
    CancelChanges;

  AIDHistory := FIDNewHistory;
  Result := FApply;
end;

procedure TFrmPessoaHistory.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPessoaHistory.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateFields then
  begin
    SaveChanges;
    FApply := True;
    Close;
  end;
end;

procedure TFrmPessoaHistory.TypeResultClose;
begin
  with cdsResultType do
    if Active then
    begin
      Filtered := False;
      Close;
    end;
end;

procedure TFrmPessoaHistory.TypeResultOpen;
begin
  with cdsResultType do
    if not Active then
      Open;
end;

procedure TFrmPessoaHistory.TypeResultRefresh;
begin
  TypeResultClose;
  TypeResultOpen;
end;

procedure TFrmPessoaHistory.scTypeSelectItem(Sender: TObject);
begin
  inherited;
  if scType.LookUpValue <> '' then
    with cdsResultType do
    begin
      Filtered := True;
      Filter   := 'IDPessoaHistoryType = ' + scType.LookUpValue;
    end;
end;

function TFrmPessoaHistory.ValidateFields: Boolean;
begin
  Result := True;

  if dtDate.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
    Result := False;
   Exit;
  end;

  if StrToIntDef(scType.LookUpValue,0) = 0 then
  begin
    MsgBox(MSG_CRT_NOT_HISTORY_TYPE, vbCritical + vbOkOnly);
    Result := False;
    Exit;
  end;

  if (cbxResult.EditValue = NULL) or (cbxResult.EditValue = 0) then
  begin
    MsgBox(MSG_CRT_NOT_RESULT_TYPE, vbCritical + vbOkOnly);
    Result := False;
    Exit;
  end;
end;

procedure TFrmPessoaHistory.scTypeAfterAddUpdate(Sender: TObject);
begin
  inherited;
  TypeResultRefresh;
end;

end.
