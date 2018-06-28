unit uFrmModelDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, DB, ADODB;

type
  TFrmModelDepartment = class(TFrmParentAll)
    btOK: TButton;
    lblDepartment: TLabel;
    cmbDepartment: TSuperComboADO;
    lblDepartmentRequired: TLabel;
    quModelDepartment: TADOQuery;
    quModelDepartmentIDDepartment: TIntegerField;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIDModel: Integer;
    FIDStore: Integer;

    procedure InsertModelDepartment;
    function ValidadeModelDepartment: Boolean;
  public
    function Start(AIDModel, AIDStore: Integer): Boolean;
  end;

implementation

uses uDM, uMsgConstant, uMsgBox;

{$R *.dfm}

{ TFrmModelDepartment }

function TFrmModelDepartment.Start(AIDModel, AIDStore: Integer): Boolean;
begin
  FIDModel := AIDModel;
  FIDStore := AIDStore;

  Result := (ShowModal = mrOk);
end;

procedure TFrmModelDepartment.btOKClick(Sender: TObject);
begin
  inherited;
  if ValidadeModelDepartment then
    InsertModelDepartment
  else
    ModalResult := mrNone;
end;

procedure TFrmModelDepartment.InsertModelDepartment;
begin
  DM.RunSQL('INSERT Inv_ModelDepartment (ModelID, StoreID, IDDepartment) ' +
            'VALUES (' + IntToStr(FIDModel) + ', ' + IntToStr(FIDStore) + ', ' + cmbDepartment.LookUpValue + ')');
end;

function TFrmModelDepartment.ValidadeModelDepartment: Boolean;
begin
  if cmbDepartment.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_DEPARTMENT, vbInformation + vbOkOnly);
    cmbDepartment.SetFocus;
    Result := False;
    Exit;
  end;

  with quModelDepartment do
  try
    if Active then
      Close;

    Parameters.ParamByName('IDModel').Value := FIDModel;
    Parameters.ParamByName('IDStore').Value := FIDStore;
    Parameters.ParamByName('IDDepartment').Value := cmbDepartment.LookUpValue;
    Open;

    Result := IsEmpty;
  finally
    Close;
  end;

  if not Result then
    MsgBox(MSG_CRT_NO_DEPARTMENT_EXIST, vbInformation + vbOkOnly);
end;

procedure TFrmModelDepartment.FormShow(Sender: TObject);
begin
  inherited;
  cmbDepartment.LookUpValue := '';
end;

end.
