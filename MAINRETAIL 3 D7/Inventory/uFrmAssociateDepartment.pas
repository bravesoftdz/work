unit uFrmAssociateDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, Buttons, StdCtrls, CheckLst, siComp, siLangRT,
  LblEffct, ExtCtrls, DB, ADODB, PowerADOQuery, ComCtrls;

type
  TFrmAssociateDepartment = class(TFrmParent)
    clbDepartment: TCheckListBox;
    btUnSelectAll: TSpeedButton;
    btSelectAll: TSpeedButton;
    quDepartment: TPowerADOQuery;
    btApply: TButton;
    pbProcess: TProgressBar;
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
  private
    FDataSetInventory: TPowerADOQuery;
    FIDDepartmentList: TStrings;

    procedure LoadDepartmentList;
    procedure DoAssociateDepartment(AIDStore, AIDModel: Integer; AIDDepartmentList: String);
    procedure DeleteModelDepartment(AIDStore, AIDModel: Integer; AIDDepartmentList: String);
    procedure InsertInventory(AIDStore, AIDModel: Integer);
    procedure InsertModelDepartment(AIDStore, AIDModel: Integer; AIDDepartmentList: String);
    function GetDepartmentList: String;
    function HasDepartmentSelected: Boolean;
  public
    procedure Start(ADataSetInventory: TPowerADOQuery);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFrmAssociateDepartment.btSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with clbDepartment do
    for I := 0 to Pred(Items.Count) do
      Checked[I] := True;
end;

procedure TFrmAssociateDepartment.btUnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with clbDepartment do
    for I := 0 to Pred(Items.Count) do
      Checked[I] := False;
end;

function TFrmAssociateDepartment.GetDepartmentList: String;
var
  i: Integer;
begin
  Result:= '';

  for i := 0 to clbDepartment.Items.Count - 1 do
    if clbDepartment.Checked[i] then
      if Result = '' then
        Result:= FIDDepartmentList[i]
      else
        Result:= Result + ', ' + FIDDepartmentList[i];
end;

function TFrmAssociateDepartment.HasDepartmentSelected: Boolean;
var
  i: Integer;
begin
  Result:= false;

  for i := 0 to clbDepartment.Items.Count - 1 do
    if clbDepartment.Checked[i] then
    begin
      Result:= true;
      break;
    end;
end;

procedure TFrmAssociateDepartment.LoadDepartmentList;
begin
  with quDepartment do
  begin
    First;
    FIDDepartmentList.Clear;
    clbDepartment.Clear;

    while not Eof do
    begin
      clbDepartment.Items.Add(FieldByName('Department').AsString);
      FIDDepartmentList.Add(FieldByName('IDDepartment').AsString);
      Next;
    end;
  end;
end;

procedure TFrmAssociateDepartment.FormCreate(Sender: TObject);
begin
  inherited;
  FIDDepartmentList := TStringList.Create;
end;

procedure TFrmAssociateDepartment.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FIDDepartmentList);
end;

procedure TFrmAssociateDepartment.Start(ADataSetInventory: TPowerADOQuery);
begin
  FDataSetInventory := ADataSetInventory;
  quDepartment.Open;
  LoadDepartmentList;
  ShowModal;
  quDepartment.Close;
end;

procedure TFrmAssociateDepartment.btApplyClick(Sender: TObject);
var
  sIDDepartmentList: String;
begin
  if not HasDepartmentSelected then
  begin
    MsgBox(MSG_INF_SELECT_DEPARTMENT, vbInformation + vbOKOnly);
    ModalResult := mrNone;
    Exit;
  end;

  sIDDepartmentList := GetDepartmentList;

  with FDataSetInventory do
  try
    DM.ADODBConnect.BeginTrans;
    Screen.Cursor := crHourGlass;
    DisableControls;
    pbProcess.Max := RecordCount;

    try
      First;
      pbProcess.Position := 0;
      while not Eof do
      begin
        DoAssociateDepartment(FieldByName('StoreID').AsInteger,
                              FieldByName('ModelID').AsInteger,
                              sIDDepartmentList);
        pbProcess.Position := pbProcess.Position + 1;
        Next;
      end;
      DM.ADODBConnect.CommitTrans;
      inherited;
    except
      DM.ADODBConnect.RollbackTrans;
      MsgBox(MSG_CRT_ASSOCIATING_DEPARTMENT, vbCritical + vbOKOnly);
      ModalResult := mrNone;
    end;
  finally
    EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmAssociateDepartment.DoAssociateDepartment(AIDStore,
  AIDModel: Integer; AIDDepartmentList: String);
begin
  DeleteModelDepartment(AIDStore, AIDModel, AIDDepartmentList);
  InsertInventory(AIDStore, AIDModel);
  InsertModelDepartment(AIDStore, AIDModel, AIDDepartmentList);
end;

procedure TFrmAssociateDepartment.DeleteModelDepartment(AIDStore,
  AIDModel: Integer; AIDDepartmentList: String);
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('DELETE Inv_ModelDepartment');
    SQL.Add('WHERE StoreID = ' + IntToStr(AIDStore));
    SQL.Add('AND ModelID = ' + IntToStr(AIDModel));
    SQL.Add('AND IDDepartment IN (' + AIDDepartmentList + ')');
    ExecSQL;
  finally
    Close;
  end;
end;

procedure TFrmAssociateDepartment.InsertInventory(AIDStore,
  AIDModel: Integer);
var
  iIDInventory: Integer;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT IDInventory');
    SQL.Add('FROM Inventory');
    SQL.Add('WHERE StoreID = ' + IntToStr(AIDStore));
    SQL.Add('AND ModelID = ' + IntToStr(AIDModel));
    Open;

    if IsEmpty then
    begin
      iIDInventory := DM.GetNextID('Inventory.IDInventory');

      SQL.Clear;
      SQL.Add('INSERT INTO Inventory (IDInventory, StoreID, ModelID, AvgCostTotal)');
      SQL.Add('VALUES (' + IntToStr(iIDInventory) + ', ' + IntToStr(AIDStore) + ', ' + IntToStr(AIDModel) + ', 0)');
      ExecSQL;
    end;
  finally
    Close;
  end;
end;

procedure TFrmAssociateDepartment.InsertModelDepartment(AIDStore,
  AIDModel: Integer; AIDDepartmentList: String);
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('INSERT INTO Inv_ModelDepartment (StoreID, ModelID, IDDepartment)');
    SQL.Add('(SELECT StoreID, ModelID, IDDepartment');
    SQL.Add('FROM Inv_Department, Inventory');
    SQL.Add('WHERE IDDepartment IN (' + AIDDepartmentList + ')');
    SQL.Add('AND StoreID = ' + IntToStr(AIDStore));
    SQL.Add('AND ModelID = ' + IntToStr(AIDModel) + ')');
    ExecSQL;
  finally
    Close;
  end;
end;

end.
