unit uFchStoreVendorAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, Mask, SuperComboADO;

type
  TFchStoreVendorAccount = class(TFrmParentAll)
    lblAccount: TLabel;
    lblVendor: TLabel;
    cmbFornecedor: TSuperComboADO;
    edtAccount: TEdit;
    quStoreVendorAccount: TADOQuery;
    btOK: TButton;
    quStoreVendorAccountIDStoreVendorAccount: TIntegerField;
    procedure btOKClick(Sender: TObject);
  private
    FIDStore: Integer;

    procedure InsertAccount;
    function ValidadeAccount: Boolean;
  public
    function Start(AIDStore: Integer): Boolean;
  end;

implementation

uses uDM, uSystemConst, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFchStoreVendoAccount }

procedure TFchStoreVendorAccount.InsertAccount;
begin
  DM.RunSQL('INSERT Mnt_StoreVendorAccount (IDStoreVendorAccount, IDStore, IDPessoa, Account) VALUES (' +
            IntToStr(DM.GetNextID(MR_STORE_VENDOR_ACCOUNT)) + ', ' +
            IntToStr(FIDStore) + ', ' +
            cmbFornecedor.LookUpValue + ', ' +
            QuotedStr(edtAccount.Text) + ')');
end;

function TFchStoreVendorAccount.Start(AIDStore: Integer): Boolean;
begin
  FIDStore := AIDStore;
  Result := True;  
  ShowModal;
end;

function TFchStoreVendorAccount.ValidadeAccount: Boolean;
var
  HasAccount: Boolean;
begin
  Result := True;

  if cmbFornecedor.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_VENDOR, vbInformation + vbOkOnly);
    cmbFornecedor.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtAccount.Text) = '' then
  begin
    MsgBox(MSG_CRT_NO_VENDOR_ACCOUNT, vbInformation + vbOkOnly);
    edtAccount.SetFocus;
    Result := False;
    Exit;
  end;

  with quStoreVendorAccount do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := StrToInt(cmbFornecedor.LookUpValue);
    Parameters.ParamByName('Account').Value  := edtAccount.Text;
    Parameters.ParamByName('IDStore').Value  := FIDStore;
    Open;
    HasAccount := (not IsEmpty);
    Close;
  end;

  if HasAccount then
  begin
    MsgBox(MSG_CRT_NO_VENDOR_ACCOUNT_EXIST, vbInformation + vbOkOnly);
    Result := False;
  end;
end;

procedure TFchStoreVendorAccount.btOKClick(Sender: TObject);
begin
  inherited;
  if ValidadeAccount then
    InsertAccount
  else
    ModalResult := mrNone;
end;

end.
