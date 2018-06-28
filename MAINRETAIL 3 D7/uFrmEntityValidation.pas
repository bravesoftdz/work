unit uFrmEntityValidation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  ADODB, DB;

type
  TFrmEntityValidation = class(TFrmParentAll)
    gbxPersonalDocument: TGroupBox;
    chkSocialSecurity: TCheckBox;
    chkBirthDate: TCheckBox;
    chkCustomerCard: TCheckBox;
    chkDriverLicence: TCheckBox;
    gbxContact: TGroupBox;
    chkPhone: TCheckBox;
    chkCellular: TCheckBox;
    chkEmail: TCheckBox;
    chkBeeper: TCheckBox;
    chkFax: TCheckBox;
    chkHomePage: TCheckBox;
    gbxAddress: TGroupBox;
    chkAddress: TCheckBox;
    chkNeighborhood: TCheckBox;
    chkCity: TCheckBox;
    chkZip: TCheckBox;
    chkCountry: TCheckBox;
    chkState: TCheckBox;
    chkContact: TCheckBox;
    quClearAndWrite: TADOCommand;
    Button1: TButton;
    quLoadSelected: TADOQuery;
    gbxBusinessDocument: TGroupBox;
    chkEmployeeID: TCheckBox;
    chkSalesTax: TCheckBox;
    chkFederalID: TCheckBox;
    chkDBA: TCheckBox;
    chkCityCode: TCheckBox;
  private
    FIDTipoPessoa: Integer;
    procedure ClearAndWrite;
    procedure InsertValidationField(AField: String);
    procedure ClearAllValidationFields;
    procedure FillFieldList(AList: TStringlist);
    procedure GetSelectedList(ALista: TStringList);
    procedure Load;
  public
    procedure Start(AIDTipoPessoa: Integer);
  end;

implementation

uses uDM, uMsgBox;

{$R *.dfm}

{ TfrmEntityValidation }

procedure TFrmEntityValidation.Start(AIDTipoPessoa: Integer);
begin
  FIDTipoPessoa := AIDTipoPessoa;
  Load;
  ShowModal;
  if ModalResult = mrOk then
     ClearAndWrite;
end;


procedure TFrmEntityValidation.Load;
var
  stlSelected: TStringList;
begin
  stlSelected := TStringList.Create;
  try
    GetSelectedList(stlSelected);
    chkPhone.Checked := (stlSelected.IndexOf('Telefone') > -1);
    chkCellular.Checked := (stlSelected.IndexOf('Cellular') > -1);
    chkEmail.Checked := (stlSelected.IndexOf('Email') > -1);
    chkBeeper.Checked := (stlSelected.IndexOf('Beeper') > -1);
    chkFax.Checked := (stlSelected.IndexOf('Fax') > -1);
    chkHomePage.Checked := (stlSelected.IndexOf('HomePage') > -1);
    chkContact.Checked := (stlSelected.IndexOf('Contatos') > -1);
    chkSocialSecurity.Checked := (stlSelected.IndexOf('Identidade') > -1);
    chkBirthDate.Checked := (stlSelected.IndexOf('Nascimento') > -1);
    chkDBA.Checked := (stlSelected.IndexOf('NomeJuridico') > -1);
    chkCustomerCard.Checked := (stlSelected.IndexOf('CustomerCard') > -1);
    chkDriverLicence.Checked := (stlSelected.IndexOf('CartMotorista') > -1);
    chkFederalID.Checked := (stlSelected.IndexOf('InscEstadual') > -1);
    chkSalesTax.Checked := (stlSelected.IndexOf('InscMunicipal') > -1);
    chkEmployeeID.Checked := (stlSelected.IndexOf('CPF') > -1);
    chkAddress.Checked := (stlSelected.IndexOf('Endereco') > -1);
    chkNeighborhood.Checked := (stlSelected.IndexOf('Bairro') > -1);
    chkCity.Checked := (stlSelected.IndexOf('Cidade') > -1);
    chkCityCode.Checked := (stlSelected.IndexOf('IDMunicipio') > -1);
    chkZip.Checked := (stlSelected.IndexOf('CEP') > -1);
    chkCountry.Checked := (stlSelected.IndexOf('IDPais') > -1);
    chkState.Checked := (stlSelected.IndexOf('IDEstado') > -1);
  finally
    stlSelected.Free;
  end;
end;


procedure TFrmEntityValidation.GetSelectedList(ALista: TStringList);
begin
  ALista.Clear;
  quLoadSelected.Close;
  quLoadSelected.Parameters.ParamByName('IDTipoPessoa').Value := FIDTipoPessoa;
  quLoadSelected.Open;
  try
    while not quLoadSelected.Eof do
    begin
      ALista.Add(quLoadSelected.FieldByName('PessoaField').AsString);
      quLoadSelected.Next;
    end;
  finally
    quLoadSelected.Close;
  end;
end;


procedure TFrmEntityValidation.ClearAndWrite;
var
  stlCampos: TStringList;
  i: Integer;
begin
  DM.FTraceControl.TraceIn('TfrmEntityValidation.ClearAndWrite');
  DM.ADODBConnect.BeginTrans;
  try
    ClearAllValidationFields;

    stlCampos := TStringList.Create;
    try
      FillFieldList(stlCampos);
      for I := 0 to Pred(stlCampos.Count) do
        InsertValidationField(stlCampos[I]);
    finally
      stlCampos.Free;
    end;

    DM.ADODBConnect.CommitTrans;
    DM.RefreshEntityField;

  except
    on E: Exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      DM.FTraceControl.SetException(E.Message, 'TfrmEntityValidation');
    end;
  end;
  DM.FTraceControl.TraceOut;
end;

procedure TFrmEntityValidation.ClearAllValidationFields;
begin
  quClearAndWrite.CommandText := Format('DELETE FROM PessoaValidation WHERE IDTipoPessoa = %D', [FIDTipoPessoa]);
  quClearAndWrite.Execute;
end;


procedure TFrmEntityValidation.InsertValidationField(AField: String);
var
  ID: Integer;
begin
  ID := DM.GetNextID('PessoaValidation.IDPessoaValidation');
  quClearAndWrite.CommandText := 'INSERT INTO PessoaValidation (IDPessoaValidation, IDTipoPessoa, PessoaField) VALUES (:IDPessoaValidation, :IDTipoPessoa, :PessoaField) ';
  quClearAndWrite.Parameters.ParamByName('IDPessoaValidation').Value := ID;
  quClearAndWrite.Parameters.ParamByName('IDTipoPessoa').Value       := FIDTipoPessoa;
  quClearAndWrite.Parameters.ParamByName('PessoaField').Value        := AField;
  quClearAndWrite.Execute;
end;

procedure TFrmEntityValidation.FillFieldList(AList: TStringlist);
begin
  AList.Clear;

  if chkPhone.Checked then
  begin
    AList.Add('Telefone');
    AList.Add('PhoneAreaCode');
  end;

  if chkCellular.Checked then
  begin
    AList.Add('Cellular');
    AList.Add('CellAreaCode');
  end;

  if chkEmail.Checked then
    AList.Add('Email');

  if chkBeeper.Checked then
    AList.Add('Beeper');

  if chkFax.Checked then
    AList.Add('Fax');

  if chkHomePage.Checked then
    AList.Add('HomePage');

  if chkContact.Checked then
    AList.Add('Contatos');

  if chkSocialSecurity.Checked then
  begin
    AList.Add('Identidade');
    AList.Add('OrgaoEmissor');
    AList.Add('DataExpedicao');
  end;

  if chkBirthDate.Checked then
    AList.Add('Nascimento');

  if chkDBA.Checked then
    AList.Add('NomeJuridico');

  if chkCustomerCard.Checked then
    AList.Add('CustomerCard');

  if chkDriverLicence.Checked then
    AList.Add('CartMotorista');

  if chkFederalID.Checked then
    AList.Add('InscEstadual');

  if chkSalesTax.Checked then
    AList.Add('InscMunicipal');

  if chkEmployeeID.Checked then
    AList.Add('CPF');

  if chkAddress.Checked then
    AList.Add('Endereco');

  if chkNeighborhood.Checked then
    AList.Add('Bairro');

  if chkCity.Checked then
    AList.Add('Cidade');

  if chkCityCode.Checked then
    AList.Add('IDMunicipio');

  if chkZip.Checked then
    AList.Add('CEP');

  if chkCountry.Checked then
    AList.Add('IDPais');

  if chkState.Checked then
    AList.Add('IDEstado');

end;



end.
