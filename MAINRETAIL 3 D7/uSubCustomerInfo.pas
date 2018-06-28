unit uSubCustomerInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, DB,
  ADODB, cxLookAndFeelPainters, cxButtons, Menus, uFrmSearchCustomer, uSystemTypes;

type
  TSubCustomerInfo = class(TParentSub)
    pnlPessoa: TPanel;
    lbCPhone: TLabel;
    lbCEmail: TLabel;
    lbCEmployID: TLabel;
    EditCustomer: TEdit;
    edtAddress: TEdit;
    edtComplement: TEdit;
    edtPhone: TEdit;
    edtEmpID: TEdit;
    edtEmail: TEdit;
    quCustomer: TADOQuery;
    quCustomerPessoaFirstName: TStringField;
    quCustomerPessoaLastName: TStringField;
    quCustomerEndereco: TStringField;
    quCustomerCidade: TStringField;
    quCustomerBairro: TStringField;
    quCustomerCEP: TStringField;
    quCustomerTelefone: TStringField;
    quCustomerCellular: TStringField;
    quCustomerEmail: TStringField;
    quCustomerNascimento: TDateTimeField;
    quCustomerCPF: TStringField;
    quCustomerCartTrabalho: TStringField;
    quCustomerInscEstadual: TStringField;
    quCustomerInscMunicipal: TStringField;
    quCustomerNomeJuridico: TStringField;
    quCustomerCodPais: TStringField;
    quCustomerPais: TStringField;
    quCustomerIDEstado: TStringField;
    quCustomerEstado: TStringField;
    quCustomerJuridico: TBooleanField;
    quCustomerPessoa: TStringField;
    quCustomerPhoneAreaCode: TStringField;
    quCustomerCellAreaCode: TStringField;
    pnlCustomerResumed: TPanel;
    memCustomer: TMemo;
    quCustomerIDPessoa: TIntegerField;
    btDetCliente: TcxButton;
    popupDetails: TPopupMenu;
    btnChangeCustomer: TMenuItem;
    quCustomerIDUser: TIntegerField;
    quCustomerComissionID: TIntegerField;
    quCustomerHasAddress: TIntegerField;
    procedure btDetClienteClick(Sender: TObject);
    procedure btnChangeCustomerClick(Sender: TObject);
  private
    FAllowCommand : TSetCommandType;
    fInfoType : Integer;
    fSelectCustomer : Boolean;
    fIDCustomer: Integer;
    FNumOfAddress : Integer;
    fFirstName,
    fLastName,
    fAddress,
    fTel,
    fCel,
    fEmail,
    fZip: String;
    procedure ClearFields;
  protected
    procedure AfterSetParam; override;
    procedure SetCustomer;
  public
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    function GiveInfo(InfoString: String): String; override;
    function getIdCustomer(): Integer;
  end;

implementation

{$R *.dfm}

uses uDM, uParamFunctions, uFchPessoa, uPassword, uMsgBox, uMsgConstant,
  uSystemConst;

{ TSubCustomerInfo }

procedure TSubCustomerInfo.AfterSetParam;
var
  fColor: String;
begin
  inherited;
  fIDCustomer := -1;
  fInfoType   := -1;

  if fParam = '' then
    Exit;

  fIDCustomer                := StrToIntDef(ParseParam(FParam, 'IDCustomer'), -1);
  fColor                     := ParseParam(FParam, 'BackColor');
  fSelectCustomer            := (ParseParam(FParam, 'SelectCustomer') = 'Y');

  if (ParseParam(FParam, 'DisplayType') = 'R') then
    fInfoType :=  0
  else if (ParseParam(FParam, 'DisplayType') = 'T') then
    fInfoType :=  1;
  pnlCustomerResumed.Visible := (fInfoType <> -1);
  pnlPessoa.Visible          := not pnlCustomerResumed.Visible;
  btnChangeCustomer.Visible  := ParseParam(FParam, 'ChangeCustomer') = '1';

  if fColor <> '' then
  begin
    Self.Color        := StringToColor(fColor);
    memCustomer.Color := Color;
    pnlPessoa.Color   := Color;
  end;

  DataSetRefresh;
end;

procedure TSubCustomerInfo.DataSetClose;
begin
  inherited;
  with quCustomer do
    if Active then
      Close;
end;

procedure TSubCustomerInfo.DataSetOpen;
begin
  inherited;
  if fIDCustomer = -1 then
    Exit;

  with quCustomer do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := fIDCustomer;
      Open;
    end;
end;

procedure TSubCustomerInfo.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
  SetCustomer;
end;

procedure TSubCustomerInfo.btDetClienteClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  inherited;
  if fIDCustomer in [0,1] then
  begin
    btnChangeCustomerClick(Self);
    Exit;
  end;

  with TFchPessoa.Create(Self) do
  begin
    ID1 := IntToStr(fIDCustomer);
    ID2 := '';
    try
      FAllowCommand := Password.GetAllowCommand(2, 6, DM.fUser.Password);
      if (TBtnCommandType(btAlt) in FAllowCommand) then
      begin
        if Start(btAlt, Nil, False, ID1, ID2, nil) then
        begin
          DataSetRefresh;
          NotifyChanges('CHANGED=TRUE;');
        end;
      end
      else
        MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
    finally
      Free;
    end;
  end;
end;

function TSubCustomerInfo.GiveInfo(InfoString: String): String;
begin
  Result := Format('ZIP=%S;IDCUSTOMER=%D;FIRSTNAME=%S;LASTNAME=%S;ADDRESS=%S;NUMOFADDRESS=%D',
                   [fZip, fIDCustomer, fFirstName, fLastName, fAddress, fNumOfAddress]);
end;

procedure TSubCustomerInfo.ClearFields;
begin
  EditCustomer.Text  := '';
  fFirstName         := '';
  fLastName          := '';
  edtAddress.Text    := '';
  edtComplement.Text := '';
  edtPhone.Text      := '';
  edtEmpID.Text      := '';
  edtEmail.Text      := '';
  fTel               := '';
  fCel               := '';
  memCustomer.Clear;
end;

procedure TSubCustomerInfo.btnChangeCustomerClick(Sender: TObject);
begin
  inherited;
// amfsouza 02.07.2012   
//  if Password.HasFuncRight(72) then
//  begin
    with TFrmSearchCustomer.Create(Self) do
    try
      fIDCustomer := Start;
    finally
      Free;
    end;
    DataSetRefresh;
    NotifyChanges('CHANGED=TRUE;');
//  end;
end;

procedure TSubCustomerInfo.SetCustomer;
begin
  if not quCustomer.IsEmpty then
  begin
    ClearFields;

    if not quCustomerJuridico.AsBoolean then
      EditCustomer.Text := Trim(quCustomerPessoaFirstName.AsString) + ' ' +
                           Trim(quCustomerPessoaLastName.AsString)
    else
      EditCustomer.Text := Trim(quCustomerPessoa.AsString);

    fIDCustomer        := quCustomerIDPessoa.AsInteger;
    fFirstName         := quCustomerPessoaFirstName.AsString;
    fLastName          := quCustomerPessoaLastName.AsString;
    fAddress           := quCustomerEndereco.AsString;
    fZip               := quCustomerCEP.AsString;
    FNumOfAddress      := quCustomerHasAddress.AsInteger;
    if quCustomerTelefone.AsString <> '' then
      fTel             := '('+quCustomerPhoneAreaCode.AsString+') '+ Trim(quCustomerTelefone.AsString);
    if quCustomerCellular.AsString <> '' then
      fCel             := '('+quCustomerCellAreaCode.AsString+') '+ Trim(quCustomerCellular.AsString);
    fEmail             := Trim(quCustomerEmail.AsString);

    edtAddress.Text    := fAddress;
    edtComplement.Text := '';

    if quCustomerBairro.AsString <> '' then
      edtComplement.Text := quCustomerBairro.AsString;

    if (quCustomerCidade.AsString <> '') then
      if(edtComplement.Text = '') then
        edtComplement.Text := quCustomerCidade.AsString
      else
        edtComplement.Text := edtComplement.Text + ' - ' +quCustomerCidade.AsString;

    if (quCustomerIDEstado.AsString <> '') then
      if (edtComplement.Text = '') then
        edtComplement.Text := quCustomerIDEstado.AsString
      else
        edtComplement.Text := edtComplement.Text + ' - ' +quCustomerIDEstado.AsString;

    if (quCustomerCEP.AsString <> '') then
      if (edtComplement.Text = '') then
        edtComplement.Text := quCustomerCEP.AsString
      else
        edtComplement.Text := edtComplement.Text + ', ' +quCustomerCEP.AsString;

    edtPhone.Text      := fTel;
    edtEmail.Text      := fEmail;
    if quCustomerJuridico.AsBoolean then
      edtEmpID.Text := quCustomerInscEstadual.AsString
    else
      edtEmpID.Text := quCustomerCPF.AsString;

    if pnlCustomerResumed.Visible then
    begin
      memCustomer.Clear;
      if fInfoType = 0 then
      begin
        memCustomer.Lines.Add(EditCustomer.Text);
        memCustomer.Lines.Add(fAddress);
        memCustomer.Lines.Add(edtComplement.Text);
        if fEmail <> '' then
          memCustomer.Lines.Add(fEmail);
      end
      else
      begin
        memCustomer.Lines.Add(EditCustomer.Text);
        if fCel <> '' then
          memCustomer.Lines.Add(fTel + ' / ' + fCel)
        else
          memCustomer.Lines.Add(fTel);
        if fEmail <> '' then
          memCustomer.Lines.Add(fEmail);
        memCustomer.Lines.Add(fAddress);
        memCustomer.Lines.Add(edtComplement.Text);
      end;

      memCustomer.SelStart  := 0;
      memCustomer.SelLength := 0;
    end;

    if DM.fSystem.SrvParam[PARAM_SALE_REPEAT_CUSTOMER_SALESPERSON] then
    begin
      DM.fUser.IDUserCliente       := quCustomerIDUser.AsInteger;
      DM.fUser.IDCommissionCliente := quCustomerComissionID.AsInteger;
    end;

  end;

  if (Trim(EditCustomer.Text) = '') and fSelectCustomer then
    btnChangeCustomerClick(Self);
end;

function TSubCustomerInfo.getIdCustomer: Integer;
begin
  result := fIDCustomer;
end;

initialization
  RegisterClass(TSubCustomerInfo);

end.
