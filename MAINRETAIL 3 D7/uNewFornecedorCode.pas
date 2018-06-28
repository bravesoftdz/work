unit uNewFornecedorCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, DB, ADODB;

type
  TNewFornecedorCode = class(TFrmParentAll)
    btOK: TButton;
    Label1: TLabel;
    cmbFornecedor: TSuperComboADO;
    Label2: TLabel;
    edtCode: TEdit;
    quVendorCode: TADOQuery;
    quVendorCodeIDVendorModelCode: TIntegerField;
    procedure btOKClick(Sender: TObject);
  private
    fIDModel : Integer;
    fIDVendor : Integer;
    fResultVendor : Boolean;
    function ValidadeVendorCode:Boolean;
    procedure InsertVendor;
  public
    function Start(IDModel, IDVendor:Integer):Boolean;
    function NewVendor : Integer;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst;

{$R *.dfm}

{ TNewFornecedorCode }

procedure TNewFornecedorCode.InsertVendor;
var
  sSQL: String;
begin
  sSQL := 'Insert VendorModelCode (IDVendorModelCode, IDPessoa, IDModel, VendorCode) VALUES ' +
          '(' + IntToStr(DM.GetNextID(MR_VENDOR_MODEL_CODE)) + ',' +
           cmbFornecedor.LookUpValue + ' ,' +
           IntToStr(fIDModel) + ' ,' + QuotedStr(edtCode.Text) + ' )';
  DM.RunSQL(sSQL);
end;

function TNewFornecedorCode.Start(IDModel, IDVendor:Integer): Boolean;
begin
  fIDModel := IDModel;
  fIDVendor := IDVendor;
  fResultVendor := False;

  if (fIDVendor <> -1) then
  begin
    cmbFornecedor.LookUpValue := IntToStr(fIDVendor);
    cmbFornecedor.ReadOnly    := True;
    cmbFornecedor.Enabled     := False;
  end;
  ShowModal;
  Result := (ModalResult = mrOK);
end;

function TNewFornecedorCode.ValidadeVendorCode: Boolean;
var
  HasCode: Boolean;
begin
  Result := True;

  if cmbFornecedor.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_VENDOR, vbInformation + vbOkOnly);
    cmbFornecedor.SetFocus;
    Result := False;
    Exit;
  end;

  if Trim(edtCode.Text) = '' then
  begin
    MsgBox(MSG_CRT_NO_VENDOR_CODE, vbInformation + vbOkOnly);
    edtCode.SetFocus;
    Result := False;
    Exit;
  end;

  with quVendorCode do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value   := StrToInt(cmbFornecedor.LookUpValue);
    Parameters.ParamByName('VendorCode').Value := edtCode.Text;
    Parameters.ParamByName('IDModel').Value    := fIDModel;
    Open;
    HasCode := (not IsEmpty);
    Close;
  end;

  if HasCode then
  begin
    MsgBox(MSG_CRT_NO_VENDOR_CODE_EXIST, vbInformation + vbOkOnly);
    Result := False;
  end;
end;

procedure TNewFornecedorCode.btOKClick(Sender: TObject);
begin
  inherited;
  if not fResultVendor then
    if ValidadeVendorCode then
      InsertVendor
    else
      ModalResult := mrNone;
end;

function TNewFornecedorCode.NewVendor: Integer;
begin
  fResultVendor := True;
  Label2.Visible := False;
  edtCode.Visible := False;
  ShowModal;
  if cmbFornecedor.LookUpValue <> '' then
    Result := StrToInt(cmbFornecedor.LookUpValue)
  else
    Result := 0;
end;

end.
