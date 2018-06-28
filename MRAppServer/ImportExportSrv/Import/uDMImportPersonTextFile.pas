unit uDMImportPersonTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, DB, ADODB;

type
  TDMImportPersonTextFile = class(TDMImportTextFile)
    cmdInsPessoa: TADOCommand;
  private
    FIDTipoPessoa: Integer;
    FPath: String;
    procedure InsertPerson(IDTipoPessoa : Integer; Path :String);
    function GetParamValue(Value: String): Variant;
    function GetJuridico(TipoPessoa: Integer): Integer;
    function GetEstado(Value: String): Variant;
    function GetCode(IDTipoPessoa: Integer; Path: String): Integer;
    function GetTipoPessoa(var Path: String; TipoPessoa : String): Integer;
    function ExistsPersonName(Pessoa: String): Boolean;
    function ExistsPersonField(Field: String): Boolean;
    procedure SetQueryConnections;
  protected
    procedure BeforeImport; override;
    procedure ImportLine; override;
  end;

implementation

uses uNumericFunctions, uDMGlobal, uStringFunctions;

{$R *.dfm}

{ TDMImportPersonTextFile }

function TDMImportPersonTextFile.GetJuridico(TipoPessoa: Integer): Integer;
begin
  Result := 0;
  case TipoPessoa of
    2 : Result := 1;
  end;
end;

function TDMImportPersonTextFile.GetParamValue(Value: String): Variant;
begin
  if not(LinkedColumns.Values[Value] = '') then
    Result := TextFile.FieldByName(LinkedColumns.Values[Value]).AsString
  else
    Result := null;
end;


procedure TDMImportPersonTextFile.InsertPerson(IDTipoPessoa : Integer; Path :String);
var
  IDPessoa : Integer;
begin

  IDPessoa := DMGlobal.GetNextCode('Pessoa', 'IDPessoa', SQLConnection);
  with cmdInsPessoa do
  try
    Parameters.ParamByName('IDPessoa').Value        := IDPessoa;
    Parameters.ParamByName('IDTipoPessoa').Value    := IDTipoPessoa;
    Parameters.ParamByName('IDStore').Value         := MyStrToInt(ImpExpConfig.Values['Store']);
    Parameters.ParamByName('IDUSer').Value          := MyStrToInt(ImpExpConfig.Values['User']);
    Parameters.ParamByName('Juridico').Value        := GetJuridico(IDTipoPessoa);
    Parameters.ParamByName('IDEstado').Value        := GetEstado(GetParamValue('State'));
    Parameters.ParamByName('Code').Value            := GetCode(IDTipoPessoa,Path);
    Parameters.ParamByName('Pessoa').Value          := TruncString(GetParamValue('Name'), 50);
    Parameters.ParamByName('PessoaFirstName').Value := TruncString(GetParamValue('FirstName'), 30);
    Parameters.ParamByName('PessoaLastName').Value  := TruncString(GetParamValue('LastName'), 30);
    Parameters.ParamByName('ShortName').Value       := TruncString(GetParamValue('ShortName'), 15);
    Parameters.ParamByName('NomeJuridico').Value    := TruncString(GetParamValue('Legalname'), 50);
    Parameters.ParamByName('Endereco').Value        := TruncString(GetParamValue('Address'), 80);
    Parameters.ParamByName('Cidade').Value          := TruncString(GetParamValue('City'), 40);
    Parameters.ParamByName('Bairro').Value          := TruncString(GetParamValue('Neighborhood'), 50);
    Parameters.ParamByName('Pais').Value            := TruncString(GetParamValue('Country'), 21);
    Parameters.ParamByName('CEP').Value             := TruncString(GetParamValue('ZIP'), 12);
    Parameters.ParamByName('Telefone').Value        := TruncString(GetParamValue('Phone'), 40);
    Parameters.ParamByName('Fax').Value             := TruncString(GetParamValue('Fax'), 40);
    Parameters.ParamByName('Cellular').Value        := TruncString(GetParamValue('Cellular'), 18);
    Parameters.ParamByName('Contato').Value         := TruncString(GetParamValue('Contact'), 50);
    Parameters.ParamByName('Email').Value           := TruncString(GetParamValue('Email'), 50);
    Parameters.ParamByName('OBS').Value             := TruncString(GetParamValue('OBS'), 100);
    Parameters.ParamByName('CGC').Value             := TruncString(GetParamValue('TaxNumber'), 30);
    Parameters.ParamByName('Identidade').Value      := TruncString(GetParamValue('SocialSecurity#'), 30);
    Parameters.ParamByName('CartTrabalho').Value    := TruncString(GetParamValue('EmployeeID'), 30);
    Parameters.ParamByName('CartMotorista').Value   := TruncString(GetParamValue('DriverLicence'), 30);
    Parameters.ParamByName('Nascimento').Value      := GetParamValue('BirthDate');
    Parameters.ParamByName('PhoneAreaCode').Value   := TruncString(GetParamValue('PhoneAreaCode'), 5);
    Parameters.ParamByName('CellAreaCode').Value    := TruncString(GetParamValue('CellAreaCode'), 5);
    Parameters.ParamByName('CPF').Value             := TruncString(GetParamValue('EmployeeID'), 30);
    Parameters.ParamByName('InscEstadual').Value    := TruncString(GetParamValue('FederalID#'), 30);
    Parameters.ParamByName('InscMunicipal').Value   := TruncString(GetParamValue('SalesTax#'), 30);
    Parameters.ParamByName('CreationDate').Value    := GetParamValue('CreationDate');

    Execute;
  finally
  end;
  
end;

function TDMImportPersonTextFile.GetCode(IDTipoPessoa: Integer; Path: String): Integer;
begin
  Result := -1;

  try
    DMGlobal.RunSQL(' UPDATE TipoPessoa SET LastCode = IsNull(LastCode,0) + 1 ' +
           ' Where IDTipoPessoa = ' + InttoStr(IDTipoPessoa) , SQLConnection);

    Try
      with DMGlobal.qryFreeSQL do
      begin
        if Active then
          Close;

        SQL.Text := ' SELECT LastCode from TipoPessoa WHERE IDTipoPessoa = ' + InttoStr(IDTipoPessoa) +
                    ' AND Path = ' + QuotedStr(Path);
        Open;

        Result := FieldByName('LastCode').AsInteger;
      end;
    finally
      DMGlobal.qryFreeSQL.Close;
    end;

  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

function TDMImportPersonTextFile.ExistsPersonField(Field: String): Boolean;
begin
  Try
    with DMGlobal.qryFreeSQL do
    begin
      if Active then
        Close;

      if Field <> '' then
      begin
        if Field = 'IDNumber' then
          SQL.Text := ' SELECT Identidade FROM Pessoa WHERE Identidade = ' + QuotedStr(GetParamValue('SocialSecurity#'))
        else if Field = 'TaxNumber' then
          SQL.Text := ' SELECT CGC FROM Pessoa WHERE CGC = ' + QuotedStr(GetParamValue('TaxNumber'))
        else if Field = 'Phone' then
          SQL.Text := ' SELECT Telefone FROM Pessoa WHERE Telefone = ' + QuotedStr(GetParamValue('Phone'));

        Open;

        if DMGlobal.qryFreeSQL.IsEmpty then
          Result := False
        else
          Result := True;

      end
      else
        Result := False;
    end;
  finally
    DMGlobal.qryFreeSQL.Close;
  end;
end;

function TDMImportPersonTextFile.ExistsPersonName(Pessoa: String): Boolean;
begin
  Try
    with DMGlobal.qryFreeSQL do
    begin
      if Active then
        Close;

      SQL.Text := ' SELECT IDPessoa FROM Pessoa WHERE Pessoa = ' + QuotedStr(Pessoa);
      Open;

      if IsEmpty then
        Result := False
      else
        Result := True;
    end;
  finally
    DMGlobal.qryFreeSQL.Close;
  end;
end;

function TDMImportPersonTextFile.GetTipoPessoa(var Path: String; TipoPessoa : String): Integer;
begin
  Try
    with DMGlobal.qryFreeSQL do
    begin
      if Active then
        Close;

      SQL.Text := ' SELECT IDTipoPessoa, Path from TipoPessoa WHERE Path = ' + QuotedStr(TipoPessoa);
      Open;

      Path := FieldByName('Path').AsString;
      Result := FieldByName('IDTipoPessoa').AsInteger;
    end;
  finally
    DMGlobal.qryFreeSQL.Close;
  end;
end;

procedure TDMImportPersonTextFile.SetQueryConnections;
begin
  DMGlobal.qryFreeSQL.Connection := SQLConnection;
  cmdInsPessoa.Connection := SQLConnection;
end;

procedure TDMImportPersonTextFile.BeforeImport;
begin
  inherited;
  SetQueryConnections;
  FIDTipoPessoa := GetTipoPessoa(FPath, ImpExpConfig.Values['PersonType']);
end;

procedure TDMImportPersonTextFile.ImportLine;
begin
  inherited;
  if not(ExistsPersonName(GetParamValue('Name'))) and not(ExistsPersonField(ImpExpConfig.Values['Verify'])) then
    InsertPerson(FIDTipoPessoa, FPath);
end;

function TDMImportPersonTextFile.GetEstado(Value: String): Variant;
var
  sIDEstado : String;
  sSQLInsert : String;
begin

  if Trim(Value) <> '' then
  begin
    try
      with DMGlobal.qryFreeSQL do
      begin
        if Active then
          Close;

        SQL.Text := 'SELECT IDEstado from Estado WHERE (Estado = ' + QuotedStr(Copy(Value, 1, 50)) + ' OR IDEstado = ' + QuotedStr(Copy(Value, 1, 3)) + ')';
        Open;
        sIDEstado := FieldByName('IDEstado').AsString;
      end;
    finally
      DMGlobal.qryFreeSQL.Close;
    end;

    if sIDEstado = '' then
    begin
      sSQLInsert := 'INSERT Estado (IDEstado, Estado) VALUES (' + QuotedStr(Copy(Value, 1, 3)) + ', ' + QuotedStr(Copy(Value, 1, 50)) + ')';
      DMGlobal.RunSQL(sSQLInsert, SQLConnection);
      Result := Copy(Value, 1, 3);
    end
    else
      Result := Copy(sIDEstado, 1, 3);
  end
  else
    Result := Null;
end;

end.
