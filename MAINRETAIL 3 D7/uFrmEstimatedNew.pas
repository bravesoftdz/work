unit uFrmEstimatedNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DateBox, Mask, PowerADOQuery, ADODB, SuperComboADO, DB;

type
  TFrmEstimatedNew = class(TFrmParentAll)
    btOK: TButton;
    Label4: TLabel;
    scStore: TSuperComboADO;
    Label1: TLabel;
    scCustomer: TSuperComboADO;
    Label3: TLabel;
    memOBS: TMemo;
    Label2: TLabel;
    memOBS2: TMemo;
    Label5: TLabel;
    lbAgent: TLabel;
    edtAgent: TEdit;
    btnNewAgent: TSpeedButton;
    btnOpenAgent: TSpeedButton;
    btnDelAgent: TSpeedButton;
    quDescTourist: TADOQuery;
    quDescTouristTipTouristGroup: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOKClick(Sender: TObject);
    procedure btnNewAgentClick(Sender: TObject);
    procedure btnDelAgentClick(Sender: TObject);
    procedure btnOpenAgentClick(Sender: TObject);
  private
    FDataSet: TPowerADOQuery;
    FIsInc: Boolean;
    FIDTrourGroup : Integer;

    procedure SetCaptionForm;
    procedure LoadValues;
    procedure SetLockedFields;
    procedure CreateEstimated;
    procedure UpdateEstimated;

    procedure RefreshTourGroup;
  public
    function Start(ADataSet: TPowerADOQuery; AIsInc: Boolean): Boolean;
  end;

implementation

uses uDM, uSystemConst, uDMGlobal, uMsgBox, uMsgConstant, uFrmChangeTourGroup,
  uFchTouristGroup, uSystemTypes;

{$R *.dfm}

{ TFrmEstimatedNew }

function TFrmEstimatedNew.Start(ADataSet: TPowerADOQuery; AIsInc: Boolean): Boolean;
begin
  FDataSet := ADataSet;
  FIsInc := AIsInc;
  FIDTrourGroup := 0;

  SetCaptionForm;
  LoadValues;
  SetLockedFields;
  RefreshTourGroup;

  ShowModal;
  Result := (ModalResult = mrOK);
end;

procedure TFrmEstimatedNew.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmEstimatedNew.CreateEstimated;
var
  IDEstimated: Integer;
  sIDCustomer: String;
  sTourGroup : String;
begin
  inherited;

  if scCustomer.LookUpValue = '' then
    sIDCustomer := 'Null'
  else
    sIDCustomer := scCustomer.LookUpValue;

  if FIDTrourGroup = 0 then
    sTourGroup := 'Null'
  else
    sTourGroup := IntToStr(FIDTrourGroup);

  IDEstimated := DM.GetNextID(MR_INV_ESTIMATED_ID);

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Estimated (IDEstimated, IDPessoa, IDUser, IDStore, EstimatedDate, OBS, OBS2, IDTouristGroup)');
    SQL.Add('VALUES (' + IntToStr(IDEstimated) + ',' + sIDCustomer + ',' + IntTostr(DM.fUser.ID) + ',');
    SQL.Add(scStore.LookUpValue + ', GetDate(),' + QuotedStr(memOBS.Text) + ',' + QuotedStr(memOBS2.Text) + ',' + sTourGroup + ')');
    ExecSQL;
  end;
end;

procedure TFrmEstimatedNew.btOKClick(Sender: TObject);
begin
  if scStore.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_STORE_SELECTED, vbInformation + vbOKOnly);
    ModalResult := mrNone;
    Exit;
  end;

  if FIsInc then
    CreateEstimated
  else
    UpdateEstimated;

  inherited;
end;

procedure TFrmEstimatedNew.UpdateEstimated;
var
  sIDStore: String;
  sIDCustomer: String;
  sTourGroup : String;
begin
  sIDStore := scStore.LookUpValue;

  if scCustomer.LookUpValue = '' then
    sIDCustomer := 'Null'
  else
    sIDCustomer := scCustomer.LookUpValue;

  if FIDTrourGroup = 0 then
    sTourGroup := 'Null'
  else
    sTourGroup := IntToStr(FIDTrourGroup);

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('UPDATE Estimated');
    SQL.Add('SET IDStore = ' + sIDStore + ', IDPessoa = ' + sIDCustomer);
    SQL.Add(', OBS = ' + QuotedStr(memOBS.Text) + ', OBS2 = ' + QuotedStr(memOBS2.Text));
    SQL.Add(', IDTouristGroup = ' + sTourGroup);
    SQL.Add('WHERE IDEstimated = ' + FDataSet.FieldByName('IDEstimated').AsString);
    ExecSQL;
  end;
end;

procedure TFrmEstimatedNew.LoadValues;
begin
  if FIsInc then
    scStore.LookUpValue := IntToStr(DM.fStore.ID)
  else
  begin
    scStore.LookUpValue := FDataSet.FieldByName('IDStore').AsString;
    scCustomer.LookUpValue := FDataSet.FieldByName('IDPessoa').AsString;
    memOBS.Text := FDataSet.FieldByName('OBS').AsString;
    memOBS2.Text := FDataSet.FieldByName('OBS2').AsString;
    FIDTrourGroup := FDataSet.FieldByName('IDTouristGroup').AsInteger;
  end;
end;

procedure TFrmEstimatedNew.SetLockedFields;
begin
  if (not FIsInc) and (not FDataSet.FieldByName('IDPreSale').IsNull) then
  begin
    scStore.Enabled := False;
    scStore.ParentColor := True;

    scCustomer.Enabled := False;
    scCustomer.ParentColor := True;

    memOBS.Enabled := False;
    memOBS.ParentColor := True;

    memOBS2.Enabled := False;
    memOBS2.ParentColor := True;

    btnNewAgent.Enabled := False;
    btnOpenAgent.Enabled := False;
    btnDelAgent.Enabled := False;
  end;
end;

procedure TFrmEstimatedNew.SetCaptionForm;
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
      if FIsInc then
        Self.Caption := 'New Budget'
      else
        Self.Caption := 'Update Budget';

    LANG_PORTUGUESE:
      if FIsInc then
        Self.Caption := 'Novo Orçamento'
      else
        Self.Caption := 'Alterar Orçamento';

    LANG_SPANISH:
      if FIsInc then
        Self.Caption := 'Nuevo Presupuesto'
      else
        Self.Caption := 'Alterar Presupuesto';
  end;
end;

procedure TFrmEstimatedNew.RefreshTourGroup;
begin

  if FIDTrourGroup = 0 then
    edtAgent.Clear
  else
    with quDescTourist do
    try
      if Active then
        Close;
      Parameters.ParambyName('IDTouristGroup').Value := FIDTrourGroup;
      Open;
      edtAgent.Text := quDescTouristTipTouristGroup.AsString;
    finally
      Close;
    end;

end;

procedure TFrmEstimatedNew.btnNewAgentClick(Sender: TObject);
var
   NewTourGroup: Integer;
begin
  inherited;

  with TFrmChangeTourGroup.Create(Self) do
    NewTourGroup := Start;

  if NewTourGroup >= 0 then
    FIDTrourGroup := NewTourGroup;

  RefreshTourGroup;
  
end;

procedure TFrmEstimatedNew.btnDelAgentClick(Sender: TObject);
begin
  inherited;

  FIDTrourGroup := 0;
  RefreshTourGroup;

end;

procedure TFrmEstimatedNew.btnOpenAgentClick(Sender: TObject);
var
   PosID1, PosID2 : String;
begin
  inherited;

  PosID1 := IntToStr(FIDTrourGroup);
  with TFchTouristGroup.Create(self) do
  begin
    Start(btAlt, nil, False, PosID1, PosID2, nil);
    Free;
  end;
  RefreshTourGroup;
  
end;

end.
