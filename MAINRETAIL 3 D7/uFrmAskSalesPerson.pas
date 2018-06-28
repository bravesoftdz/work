unit uFrmAskSalesPerson;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO;

type
  TFrmAskSalesPerson = class(TFrmParentAll)
    btnOk: TButton;
    lbUserCode: TLabel;
    edtCode: TEdit;
    lbPrice: TLabel;
    scUser: TSuperComboADO;
    Label2: TLabel;
    btnSearch: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtCodeExit(Sender: TObject);
    procedure scUserSelectItem(Sender: TObject);
    procedure edtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodeEnter(Sender: TObject);
  private
    FIDUser,
    FIDCommission : Integer;
    FResult : Boolean;
    function Validate : Boolean;
    function GetUserByCode(Code:String):Boolean;
  public
    function Start(var IDUser : Integer; var IDCommission : Integer) : Boolean;
  end;


implementation

uses uDM, DB, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmAskSalesPerson }

function TFrmAskSalesPerson.Start(var IDUser : Integer; var IDCommission : Integer) : Boolean;
begin
  FIDUser := IDUser;
  FIDCommission := IDCommission;
  scUser.LookUpValue := IntToStr(FIDUser);
  FResult := False;

  ShowModal;

  Result := FResult;
  IDUser := FIDUser;
  IDCommission := FIDCommission;
end;

procedure TFrmAskSalesPerson.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmAskSalesPerson.btCloseClick(Sender: TObject);
begin
  inherited;
  FResult := False;
  Close;
end;

procedure TFrmAskSalesPerson.btnOkClick(Sender: TObject);
begin
  inherited;
  if Validate then
  begin
    FResult := True;
    Close;
  end;
end;

function TFrmAskSalesPerson.Validate: Boolean;
begin

  Result := False;


  if (scUser.LookUpValue = '') then
  begin
    MsgBox(MSG_INF_USE_NOT_FOUND, vbInformation + vbOkOnly);
    Exit;
  end;

  if FIDCommission = 0 then
  begin
   MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbInformation + vbOkOnly);
   Exit;
  end;

  Result := True;


end;

function TFrmAskSalesPerson.GetUserByCode(Code: String): Boolean;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT ComissionID, IDUser');
    SQL.Add('FROM SystemUser');
    SQL.Add('WHERE CodSystemUser = ' + QuotedStr(Code));
    SQL.Add('AND Desativado = 0 ');
    Open;
    Result := not IsEmpty;
    if Result then
    begin
      FIDCommission := FieldByName('ComissionID').AsInteger;
      FIDUser := FieldByName('IDUser').AsInteger;
      scUser.LookUpValue := IntToStr(FIDUser);
    end;
  finally
    Close;
    end;
end;

procedure TFrmAskSalesPerson.edtCodeExit(Sender: TObject);
begin
  inherited;
  btnOk.Default := True;
  if edtCode.Text <> '' then
    if GetUserByCode(edtCode.Text) then
      edtCode.Text := ''
    else if FIDCommission = 0 then
      MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbInformation + vbOkOnly)
    else
      MsgBox(MSG_INF_USE_NOT_FOUND, vbCritical + vbOkOnly);
end;

procedure TFrmAskSalesPerson.scUserSelectItem(Sender: TObject);
begin
  inherited;
  if (scUser.LookUpValue <> '') then
  begin
   FIDUser       := StrToInt(scUser.LookUpValue);
   FIDCommission := StrToIntDef(DM.DescCodigo(['IDUser'], [QuotedStr(scUser.LookUpValue)], 'SystemUser', 'ComissionID'), 0);

   if FIDCommission = 0 then
      MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbInformation + vbOkOnly);
  end;


end;

procedure TFrmAskSalesPerson.edtCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtCodeExit(self);
end;

procedure TFrmAskSalesPerson.edtCodeEnter(Sender: TObject);
begin
  inherited;
  btnOk.Default := False;
end;

end.
