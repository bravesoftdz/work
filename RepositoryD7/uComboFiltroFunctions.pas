unit uComboFiltroFunctions;

interface

procedure PessoaSetFilter(scPessoaTipo, scPessoa: TObject; CurrentValue: String);
procedure EnderecoSetFilter(scPessoa, scEndereco: TObject; CurrentValue: String);
procedure CentroSetFilter(scPessoa, scCentro: TObject; CurrentValue: String);
procedure ObjetoSetFilter(scArea, scObjeto: TObject; CurrentValue, IDSite: String);
procedure AcaoSetFilter(scArea, scAcao: TObject; CurrentValue: String);


implementation

uses SuperComboADO;

procedure PessoaSetFilter(scPessoaTipo, scPessoa: TObject; CurrentValue: String);
var
  mscPessoa, mscPessoaTipo: TDBSuperComboADO;

begin
  // Faco o casting correto para os combos
  mscPessoaTipo := TDBSuperComboADO(scPessoaTipo);
  mscPessoa := TDBSuperComboADO(scPessoa);

  with mscPessoa do
    if mscPessoaTipo.LookUpValue <> '' then
      begin
        // Filtro pelo tipo de pessoa atual
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDTipoPessoa');
        FilterValues.Add(mscPessoaTipo.LookUpvalue);
        LookUpValue := CurrentValue;
      end
    else
      begin
        // Seto o filtro para nada
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDTipoPessoa');
        FilterValues.Add('-1');
      end;

end;

procedure EnderecoSetFilter(scPessoa, scEndereco: TObject; CurrentValue: String);
var
  mscPessoa, mscEndereco: TSuperComboADO;

begin
  // Faco o casting correto para os combos
  mscPessoa := TSuperComboADO(scPessoa);
  mscEndereco := TSuperComboADO(scEndereco);

  with mscEndereco do
    if mscPessoa.LookUpValue <> '' then
      begin
        // Filtro pelo tipo de pessoa atual
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDPessoa');
        FilterValues.Add(mscPessoa.LookUpvalue);
        LookUpValue := CurrentValue;
      end
    else
      begin
        // Seto o filtro para nada
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDPessoa');
        FilterValues.Add('-1');
      end;
end;

procedure CentroSetFilter(scPessoa, scCentro: TObject; CurrentValue: String);
var
  mscPessoa, mscCentro: TSuperComboADO;

begin
  // Faco o casting correto para os combos
  mscPessoa := TSuperComboADO(scPessoa);
  mscCentro := TSuperComboADO(scCentro);

  with mscCentro do
    if mscPessoa.LookUpValue <> '' then
      begin
        // Filtro pelo tipo de pessoa atual
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDPessoa');
        FilterValues.Add(mscPessoa.LookUpvalue);
        LookUpValue := CurrentValue;
      end
    else
      begin
        // Seto o filtro para nada
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDPessoa');
        FilterValues.Add('-1');
      end;
end;

procedure ObjetoSetFilter(scArea, scObjeto: TObject; CurrentValue, IDSite: String);
var
  mscArea, mscObjeto: TSuperComboADO;

begin
  // Faco o casting correto para os combos
  mscArea := TSuperComboADO(scArea);
  mscObjeto := TSuperComboADO(scObjeto);

  with mscObjeto do
    if mscArea.LookUpValue <> '' then
      begin
        // Filtro pelo tipo de pessoa atual
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDArea');
        FilterValues.Add(mscArea.LookUpvalue);
        FilterFields.Add('IDSite');
        FilterValues.Add(IDSite);
        LookUpValue := CurrentValue;
      end
    else
      begin
        // Seto o filtro para nada
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDArea');
        FilterValues.Add('-1');
      end;
end;

procedure AcaoSetFilter(scArea, scAcao: TObject; CurrentValue: String);
var
  mscArea, mscAcao: TSuperComboADO;

begin
  // Faco o casting correto para os combos
  mscArea := TSuperComboADO(scArea);
  mscAcao := TSuperComboADO(scAcao);

  with mscAcao do
    if mscArea.LookUpValue <> '' then
      begin
        // Filtro pelo tipo de pessoa atual
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDArea');
        FilterValues.Add(mscArea.LookUpvalue);
        LookUpValue := CurrentValue;
      end
    else
      begin
        // Seto o filtro para nada
        FilterFields.Clear;
        FilterValues.Clear;
        FilterFields.Add('IDArea');
        FilterValues.Add('-1');
      end;
end;


end.
