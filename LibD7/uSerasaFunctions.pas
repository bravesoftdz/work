unit uSerasaFunctions;

interface

uses Windows, uSerasaConsts, uSerasaTypes, SysUtils;

function CompleteLeft(S: String; C: Char; Count: Longint): String;
function CompleteRight(S: String; C: Char; Count: Longint): String;
function ZeroNumberLeft(S: String; Count: Integer): String;
function ZeroNumberRight(S: String; Count: Integer): String;
function SpaceStringLeft(S: String; Count: Integer): String;
function SpaceStringRight(S: String; Count: Integer): String;

function GenerateTableHeader(ACaption: String; Titles: Array of String): String;
function GenerateTableRow(Data: array of string; Strong: Boolean): string;

function TrataDataSerasa(Data: String) : String;


function RegNadaConstaToHTML(sReg, Titulo: String) : String;

function Reg00ToHTML(sReg, sTipoDocumento: String;IsFirst: Boolean) : string;
function Reg02ToHTML(sReg: String) : String;
function Reg04ToHTML(sReg: String; IsFirst: Boolean) : String;
function Reg05ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg06ToHTML(sReg: String) : String;
function Reg08ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg10ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg12ToHTML(sReg: String) : String;
function Reg14ToHTML(sReg: String; IsFirst: Boolean): string;
function Reg16ToHTML(sReg: String) : String;
function Reg18ToHTML(sReg: String; IsFirst: Boolean) : String;
function Reg20ToHTML(sReg: String) : String;
function Reg22ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg24ToHTML(sReg: String) : String;
function Reg26ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg28ToHTML(sReg: String) : String;
function Reg30ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg32ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg34ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg36ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg38ToHTML(sReg: String) : String;
function Reg40ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg42ToHTML(sReg: String) : String;
function Reg44ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg46ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg48ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg50ToHTML(sReg: String) : String;
function Reg52ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg54ToHTML(sReg: String; IsFirst: Boolean): String;
function Reg90ToHTML(sReg: String; IsFirst: Boolean): String;

function SituacaoReg00(sSit: String): String;

function ExecCript(TP:String;BufEnv:String;BufOut:String):PCHAR;

function CriptografaSERASA(AText: String): String;
function DescriptografaSERASA(AText: String): String;


implementation



function CompleteLeft(S: String; C: Char; Count: Longint): String;
var
  I : Integer;
begin
  Result := S;
  while Length(Result) < Count do
    Result := C + Result;
end;

function CompleteRight(S: String; C: Char; Count: Longint): String;
var
  I : Integer;
begin
  Result := S;
  while Length(Result) < Count do
    Result := Result + C;
end;

function ZeroNumberLeft(S: String; Count: Integer): String;
begin
  Result := CompleteLeft(S, '0', Count);
end;

function ZeroNumberRight(S: String; Count: Integer): String;
begin
  Result := CompleteRight(S, '0', Count);
end;

function SpaceStringLeft(S: String; Count: Integer): String;
begin
  Result := CompleteLeft(S, ' ', Count);
end;

function SpaceStringRight(S: String; Count: Integer): String;
begin
  Result := CompleteRight(S, ' ', Count);
end;

function TrataDataSerasa(Data: String) : String;
begin
  if Trim(Data) = '' then
    Result := TXT_NAO_INFORMADO
  else
    Result := Copy(Data, 1, 2) + '/' + Copy(Data, 3, 2) + '/' + Copy(Data, 5, 4);
end;

function TrataMesAnoSerasa(Data: String) : String;
begin
  Result := Copy(Data, 1, 2) + '/' + Copy(Data, 3, 2);
end;

function TrataHoraSerasa(Hora: String): String;
begin
  Result := Copy(Hora, 1, 2) + ':' + Copy(Hora, 3, 2);
end;

function TrataTipoPessoa(TipoPessoa : String) : String;
begin
  if Trim(TipoPessoa) = '' then
    Result := TXT_NAO_INFORMADO
  else
    case StrToInt(TipoPessoa) of
      1 : Result := 'Jurídica';
      2 : Result := 'Física';
      3 : Result := 'Jurídica Isenta';
      4 : Result := 'Física Isenta';
      else  Result := TXT_NAO_INFORMADO;
    end;
end;

function TrataTipoDoc(TipoDoc : String) : String;
begin
  case StrToInt(TipoDoc) of
    0: Result    := 'RG';
    1 : Result   := 'Outros';
    else  Result := TXT_NAO_INFORMADO;
  end;
end;

function TratapartRechequeOnline(TipoPart : String) : String;
begin
  case StrToInt(TipoPart) of
    1: Result    := 'Banco participa do Recheque Online';
    2 : Result   := 'Banco não participa do Recheque Online';
    else  Result := TXT_NAO_INFORMADO;
  end;
end;

function TrataJuridicoFisico(Tipo: String): String;
var
  CH : Char;
begin
  if Trim(Tipo) = '' then
    CH := #0
  else
    CH := Tipo[1];

  case CH of
    'F': Result := 'Física';
    'J': Result := 'Jurídica';
    'I': Result := 'Indefinido';
    Else
      Result := TXT_NAO_INFORMADO;
  end;
end;

function TrataClasseAssinante(Tipo : String) : String;
begin
  case StrToInt(Tipo) of
    0: Result    := 'Não Definida';
    1: Result    := 'Residencial';
    2 : Result   := 'Comercial';
    else  Result := TXT_NAO_INFORMADO;
  end;
end;

function TrataIndPesqAssinante(Tipo : String) : String;
begin
  case StrToInt(Tipo) of
    1: Result    := 'DDD/Telefone não encontrado';
    2: Result    := 'Confirmação do telefone não disponível no momento';
    3 : Result   := 'Telefone público, celular ou outra concesionária';
    4 : Result   := 'Pesquisa do telefone não autorizada';
    5 : Result   := 'telefone não autorizado para divulgação';
    else  Result := TXT_NAO_INFORMADO;
  end;
end;

function TrataSimNao(S: String): String;
begin
  if S = 'S' then
    Result := 'Sim'
  else
    if S = 'N' then
      Result := 'Não'
    else
      Result := '';
end;


function SituacaoReg00(sSit: String): String;
begin
  if Trim(sSit) = '' then
    Result := 'Desconhecida'
  else
    case StrToInt(Trim(sSit)) of
      0: Result := 'Inapta';
      2: Result := 'Ativa';
      6: Result := 'Suspensa';
      9: Result := 'Cancelada';
      else Result := 'Desconhecida';
    end;
end;

function NoBreakSpace(S: String): string;
begin
  if Trim(S) = '' then
    Result := '&nbsp;'
  else
    Result := S;
end;

function GeraErroTamanho(sRegistro: String) : String;
begin
  Result := Format(MSG_ERRO_TAMANHO_INVALIDO, [sRegistro]);
end;

function Reg00ToHTML(sReg, sTipoDocumento: String;IsFirst: Boolean) : string;
var
  Reg00 : TReg00;
begin
  Reg00.Nome               := Trim(Copy(sReg, 3, TAM_NOME));
  Reg00.NascimentoFundacao := Copy(sReg, 71, TAM_DATA);
  Reg00.Situacao           := Copy(sReg, 79, 2);
  Reg00.DataSituacao       := Copy(sReg, 81, TAM_DATA);
  Reg00.Mensagem           := Trim(Copy(sReg, 89, 65));
  Reg00.NomeMae            := Trim(Copy(sReg, 154, 40));

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Confirmei', ['Nome',
                                                'Nascimento / Fundação',
                                                'Situação',
                                                'Data Situação',
                                                'Mensagem',
                                                'Nome Mãe'])
  else
    Result := '';
  Result := Result +
            GenerateTableRow([Reg00.Nome,
                              TrataDataSerasa(Reg00.NascimentoFundacao),
                              SituacaoReg00(Reg00.Situacao),
                              TrataDataSerasa(Reg00.DataSituacao),
                              Reg00.Mensagem,
                              Reg00.NomeMae], False) + #13#10;
end;

function RegNadaConstaToHTML(sReg, Titulo: String) : String;
begin
  Result := GenerateTableHeader(Titulo, ['Mensagem']);
  Result := Result +
            GenerateTableRow([Trim(Copy(sReg, 3, 40))], False) + #13#10;
end;

function Reg02ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Nada Consta');
end;
{
function Reg04ToHTML(sReg: String; IsFirst: Boolean) : String;
var
  Reg04 :TReg04;
begin
  if Length(sReg) <> TAM_REG04 then
    raise Exception.Create(GeraErroTamanho('04'));

  Reg04.QuantidadePendencias            := Copy(sReg, 3, 5);
  Reg04.DataOcorrenciaMaisAntiga        := Copy(sReg, 8, TAM_MES_ANO);
  Reg04.DataOcorrenciaMaisRecente       := Copy(sReg, 16, TAM_MES_ANO);
  Reg04.ModalidadeOcorrenciaMaisRecente := Trim(Copy(sReg, 20, 30));
  Reg04.TipoMoedaOcorrenciaMaisRecente  := Trim(Copy(sReg, 50, 3));
  Reg04.Valor                           := Copy(sReg, 53, 15);
  Reg04.OrigemOcorrenciaMaisRecente     := Trim(Copy(sReg, 68, 30));
  Reg04.NumeroLojaFilial                := Copy(sReg, 98, 4);


  if IsFirst then
    Result := Result +
              GenerateTableHeader('Pendências Internas',
                                                ['Quantidade',
                                                'Mais Antiga',
                                                'Mais Recente',
                                                'Modalidade Mais Recente',
                                                'Tipo Moeda Mais Recente',
                                                'Valor',
                                                'Origem Mais Recente',
                                                'Numero Loja / Filial'])
  else
    Result := '';
  Result := Result +
            GenerateTableRow([Reg04.QuantidadePendencias,
                              TrataMesAnoSerasa(Reg04.DataOcorrenciaMaisAntiga),
                              TrataMesAnoSerasa(Reg04.DataOcorrenciaMaisRecente),
                              Reg04.ModalidadeOcorrenciaMaisRecente,
                              Reg04.TipoMoedaOcorrenciaMaisRecente,
                              Reg04.Valor,
                              Reg04.OrigemOcorrenciaMaisRecente,
                              Reg04.NumeroLojaFilial], False) + #13#10;
end;}

function Reg04ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg08 :TReg08;
begin
  if Length(sReg) <> TAM_REG08 then
    raise Exception.Create(GeraErroTamanho('08'));

  Reg08.DataOcorrencia  := Copy(sReg, 3, TAM_DATA);
  Reg08.Modalidade      := Trim(Copy(sReg, 11, 30));
  Reg08.Avalista        := Trim(Copy(sReg, 41, 1));
  Reg08.TipoMoeda       := Trim(Copy(sReg, 42, 3));
  Reg08.Valor           := Trim(Copy(sReg, 45, 15));
  Reg08.Contrato        := Trim(Copy(sReg, 60, 16));
  Reg08.Origem          := Trim(Copy(sReg, 76, 30));
  Reg08.PracaOcorrencia := Trim(Copy(sReg, 106, 4));

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Pendências Internas',
                                                ['Data Ocorrência',
                                                'Modalidade',
                                                'Avalista',
                                                'Tipo Moeda',
                                                'Valor',
                                                'Contrato',
                                                'Origem',
                                                'Cód. Praça Ocorrência'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([TrataDataSerasa(Reg08.DataOcorrencia),
                              Reg08.Modalidade,
                              Reg08.Avalista,
                              Reg08.TipoMoeda,
                              Reg08.Valor,
                              Reg08.Contrato,
                              Reg08.Origem,
                              Reg08.PracaOcorrencia], False) + #13#10;
end;

function Reg05ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg10: TReg10;
begin
  if Length(sReg) <> TAM_REG10 then
    raise Exception.Create(GeraErroTamanho('10'));

  Reg10.TotalOcorrencias          := Copy(sReg, 3, 5);
  Reg10.DataOcorrenciaMaisAntiga  := Copy(sReg, 8, TAM_MES_ANO);
  Reg10.DataOcorrenciaMaisRecente := Copy(sReg, 14, TAM_MES_ANO);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Pendências Internas',
                                                ['Total de Ocorrências',
                                                'Modalidade',
                                                'Ocorrência mais Antiga',
                                                'Ocorrência mais Recente'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg10.TotalOcorrencias,
                              TrataMesAnoSerasa(Reg10.DataOcorrenciaMaisAntiga),
                              TrataMesAnoSerasa(Reg10.DataOcorrenciaMaisRecente)], False) + #13#10;
end;

function Reg06ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Pendências Internas');
end;

function Reg08ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg08 :TReg08;
begin
  if Length(sReg) <> TAM_REG08 then
    raise Exception.Create(GeraErroTamanho('08'));

  Reg08.DataOcorrencia  := Copy(sReg, 3, TAM_DATA);
  Reg08.Modalidade      := Trim(Copy(sReg, 11, 30));
  Reg08.Avalista        := Trim(Copy(sReg, 41, 1));
  Reg08.TipoMoeda       := Trim(Copy(sReg, 42, 3));
  Reg08.Valor           := Trim(Copy(sReg, 45, 15));
  Reg08.Contrato        := Trim(Copy(sReg, 60, 16));
  Reg08.Origem          := Trim(Copy(sReg, 76, 30));
  Reg08.PracaOcorrencia := Trim(Copy(sReg, 106, 4));

  if IsFirst then
    Result := Result +
              GenerateTableHeader('PEFIN - Pendências Financeiras',
                                                ['Data Ocorrência',
                                                'Modalidade',
                                                'Avalista',
                                                'Tipo Moeda',
                                                'Valor',
                                                'Contrato',
                                                'Origem',
                                                'Cód. Praça Ocorrência'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([TrataDataSerasa(Reg08.DataOcorrencia),
                              Reg08.Modalidade,
                              Reg08.Avalista,
                              Reg08.TipoMoeda,
                              Reg08.Valor,
                              Reg08.Contrato,
                              Reg08.Origem,
                              Reg08.PracaOcorrencia], False) + #13#10;
end;

function Reg10ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg10: TReg10;
begin
  if Length(sReg) <> TAM_REG10 then
    raise Exception.Create(GeraErroTamanho('10'));

  Reg10.TotalOcorrencias          := Copy(sReg, 3, 5);
  Reg10.DataOcorrenciaMaisAntiga  := Copy(sReg, 8, TAM_MES_ANO);
  Reg10.DataOcorrenciaMaisRecente := Copy(sReg, 14, TAM_MES_ANO);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('PEFIN - Pendências Financeiras (Resumo)',
                                                ['Total de Ocorrências',
                                                'Modalidade',
                                                'Ocorrência mais Antiga',
                                                'Ocorrência mais Recente'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg10.TotalOcorrencias,
                              TrataMesAnoSerasa(Reg10.DataOcorrenciaMaisAntiga),
                              TrataMesAnoSerasa(Reg10.DataOcorrenciaMaisRecente)], False) + #13#10;
end;


function Reg12ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'PEFIN - Pendências Financeiras');
end;

function Reg14ToHTML(sReg: String; IsFirst: Boolean): string;
var
  Reg14: TReg14;
begin
  if Length(sReg) <> TAM_REG14 then
    raise Exception.Create(GeraErroTamanho('14'));

  Reg14.QtdChequesSemFundosVarejo := Copy(sReg, 3, 5);
  Reg14.DataUltimaOcorrencia      := Copy(sReg, 8, TAM_DATA);
  Reg14.CodCompensacao            := Copy(sReg, 16, 3);
  Reg14.NomeFantasiaBanco         := Trim(Copy(sReg, 19, 12));
  Reg14.NumeroAgencia             := Copy(sReg, 31, 4);
  Reg14.Origem                    := Trim(Copy(sReg, 35, 30));
  Reg14.PracaOcorencia            := Trim(Copy(sReg, 65, 4));
  Reg14.NumeroLojaFilial          := Copy(sReg, 69, 4);


  if IsFirst then
    Result := Result +
              GenerateTableHeader('Cheques Sem Fundos no Varejo',
                                                ['Quantidade',
                                                'Data Ultima Ocorrência',
                                                'Codigo Compensação',
                                                'Nome Fantasia Banco',
                                                'Número Agência',
                                                'Origem',
                                                'Numero Loja / Filial'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg14.QtdChequesSemFundosVarejo,
                              TrataDataSerasa(Reg14.DataUltimaOcorrencia),
                              Reg14.CodCompensacao,
                              Reg14.NomeFantasiaBanco,
                              Reg14.NumeroAgencia,
                              Reg14.Origem,
                              Reg14.PracaOcorencia,
                              Reg14.NumeroLojaFilial], False) + #13#10;


end;


function Reg16ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Cheques Sem Fundos no Varejo');
end;

function Reg18ToHTML(sReg: String; IsFirst: Boolean) : String;
var
  Reg18: TReg18;
begin
  if Length(sReg) <> TAM_REG18 then
    raise Exception.Create(GeraErroTamanho('18'));

  Reg18.QtdChequesSemFundos       := Copy(sReg, 03, 5);
  Reg18.DataUltimaOcorrencia      := Copy(sReg, 08, TAM_DATA);
  Reg18.DataOcorrenciaMaisRecente := Copy(sReg, 16, TAM_DATA);
  Reg18.CodCompensacao            := Copy(sReg, 24, 3);

  Reg18.NumeroAgencia             := Copy(sReg, 27, 4);
  Reg18.NomeFantasiaBanco         := Trim(Copy(sReg, 31, 12));


  if IsFirst then
    Result := Result +
              GenerateTableHeader('Cheques Sem Fundos CCF/BACEN',
                                                ['Quantidade',
                                                'Data Ultima Ocorrência',
                                                'Data Ocorrência mais recente',
                                                'Codigo Compensação',
                                                'Número Agência',
                                                'Nome Fantasia do Banco'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg18.QtdChequesSemFundos,
                              TrataDataSerasa(Reg18.DataUltimaOcorrencia),
                              TrataDataSerasa(Reg18.DataOcorrenciaMaisRecente),
                              Reg18.CodCompensacao,
                              Reg18.NumeroAgencia,
                              Reg18.NomeFantasiaBanco], False) + #13#10;

end;


function Reg20ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Cheques Sem Fundos CCF/BACEN');
end;

function Reg22ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg22: TReg22;
begin
  if Length(sReg) <> TAM_REG22 then
    raise Exception.Create(GeraErroTamanho('22'));

  Reg22.CodCompensacao      := Copy(sReg, 3, 3);
  Reg22.NumeroAgencia       := Copy(sReg, 6, 4);
  Reg22.NumeroContaCorrente := Copy(sReg, 10, 10);
  Reg22.NumeroChequeInicial := Copy(sReg, 20, 6);
  Reg22.NumeroChequeFinal   := Copy(sReg, 26, 6);
  Reg22.Motivo              := Copy(sReg, 32, 12);
  Reg22.DataCadastramento   := Copy(sReg, 44, TAM_DATA);
  Reg22.HoraCadastramento   := Copy(sReg, 52, 4);
  Reg22.CodigoFonte         := Trim(Copy(sReg, 56, 4));
  Reg22.DocumentoOriginal   := Trim(Copy(sReg, 60, 15));
  Reg22.TipoPessoaDocumento := Trim(Copy(sReg, 75, 1));

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Recheque - Detalhes',
                                                ['Cod. Compensação',
                                                'Número Agência',
                                                'Conta Corrente',
                                                'Cheque Inicial',
                                                'Cheque Final',
                                                'Motivo',
                                                'Data Cadastramento',
                                                'Hora Cadastramento',
                                                'Codigo da Fonte',
                                                'Documento Original',
                                                'Tipo Pessoa Documento'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg22.CodCompensacao,
                              Reg22.NumeroAgencia,
                              Reg22.NumeroContaCorrente,
                              Reg22.NumeroChequeInicial,
                              Reg22.NumeroChequeFinal,
                              Reg22.Motivo,
                              TrataDataSerasa(Reg22.DataCadastramento),
                              TrataHoraSerasa(Reg22.HoraCadastramento),
                              Reg22.CodigoFonte,
                              Reg22.DocumentoOriginal,
                              TrataTipoPessoa(Reg22.TipoPessoaDocumento)], False) + #13#10;
end;


function Reg24ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Recheque - Detalhes');
end;

function Reg26ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg26: TReg26;
begin
  if Length(sReg) <> TAM_REG26 then
    raise Exception.Create(GeraErroTamanho('26'));

  Reg26.CodCompensacao      := Copy(sReg, 3, 3);
  Reg26.NumeroAgencia       := Copy(sReg, 6, 4);
  Reg26.NumeroContaCorrente := Copy(sReg, 10, 10);
  Reg26.NumeroChequeInicial := Copy(sReg, 20, 6);
  Reg26.NumeroChequeFinal   := Copy(sReg, 26, 6);
  Reg26.Motivo              := Copy(sReg, 32, 12);
  Reg26.DataOcorrencia      := Copy(sReg, 44, TAM_DATA);
  Reg26.CodigoFonte         := Trim(Copy(sReg, 52, 4));

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Recheque - Outras Ocorrências',
                                                ['Cod. Compensação',
                                                'Número Agência',
                                                'Conta Corrente',
                                                'Cheque Inicial',
                                                'Cheque Final',
                                                'Motivo',
                                                'Data Ocorrência',
                                                'Codigo da Fonte'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg26.CodCompensacao,
                              Reg26.NumeroAgencia,
                              Reg26.NumeroContaCorrente,
                              Reg26.NumeroChequeInicial,
                              Reg26.NumeroChequeFinal,
                              Reg26.Motivo,
                              TrataDataSerasa(Reg26.DataOcorrencia),
                              Reg26.CodigoFonte], False) + #13#10;
end;


function Reg28ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Recheque - Outras Ocorrências');
end;


function Reg30ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg30: TReg30;
begin
  if Length(sReg) <> TAM_REG30 then
    raise Exception.Create(GeraErroTamanho('30'));

    Reg30.DocAssinanteConfere   := Copy(sReg, 3, 1);
    Reg30.NomeAsinante          := Copy(sReg, 4, 70);
    Reg30.TipoDocAssinante      := Copy(sReg, 74, 1);
    Reg30.ClasseAssinante       := Copy(sReg, 75, 1);
    Reg30.InstalacaoLinha       := Copy(sReg, 76, TAM_DATA);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('TeleConfirma',
                                                ['Documento do Assinante Confere',
                                                 'Nome Assinante',
                                                 'Tipo Documento Assinante',
                                                 'Classe Assinante',
                                                 'Data Instalação Linha'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([TrataSimNao(Reg30.DocAssinanteConfere),
                              Reg30.NomeAsinante,
                              TrataJuridicoFisico(Reg30.TipoDocAssinante),
                              TrataClasseAssinante(Reg30.ClasseAssinante),
                              TrataDataSerasa(Reg30.InstalacaoLinha)], False) + #13#10;
end;

function Reg36ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg36: TReg36;
begin
  if Length(sReg) <> TAM_REG36 then
    raise Exception.Create(GeraErroTamanho('36'));

    Reg36.IntEmissPriCHVista      := Copy(sReg, 3, TAM_MES_ANO);
    Reg36.IntEmissUltCHVista      := Copy(sReg, 7,TAM_MES_ANO);
    Reg36.IntTotCHVista15         := Copy(sReg, 11, 3);
    Reg36.IntTotCHPrazo30         := Copy(sReg, 14, 2);
    Reg36.IntTotCHPrazo3160       := Copy(sReg, 16, 2);
    Reg36.IntTotCHPrazo6190       := Copy(sReg, 18, 2);
    Reg36.IntTotCHPrazo           := Copy(sReg, 20, 3);

    Reg36.MerEmissPriCHVista      := Copy(sReg, 23, TAM_MES_ANO);
    Reg36.MerEmissUltCHVista      := Copy(sReg, 27, TAM_MES_ANO);
    Reg36.MerTotCHVista15         := Copy(sReg, 31, 3);
    Reg36.MerTotCHPrazo30         := Copy(sReg, 34, 2);
    Reg36.MerTotCHPrazo3160       := Copy(sReg, 36, 2);
    Reg36.MerTotCHPrazo6190       := Copy(sReg, 38, 2);
    Reg36.MerTotCHPrazo           := Copy(sReg, 40, 3);

    Reg36.ConsPrazoNomeEmpresa1   := Copy(sReg, 43, 25);
    Reg36.ConsPrazoNomeData1      := Copy(sReg, 68, TAM_MES_ANO);

    Reg36.ConsPrazoNomeEmpresa2   := Copy(sReg, 72, 25);
    Reg36.ConsPrazoNomeData2      := Copy(sReg, 97, TAM_MES_ANO);

    Reg36.ConsPrazoNomeEmpresa3   := Copy(sReg, 101, 25);
    Reg36.ConsPrazoNomeData3      := Copy(sReg, 126, TAM_MES_ANO);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Registro de Consultas',
                                                ['Emissão do Primeiro Cheque a Vista (Interno)',
                                                'Emissão do Último Cheque a Vista (Interno)',
                                                'Cheques a Vista Emitidos nos Últimos 15 dias (Interno)',
                                                'Cheques a Prazo Emitidos nos Últimos 30 dias (Interno)',
                                                'Cheques a Prazo Emitidos entre 31 e 60 dias (Interno)',
                                                'Cheques a Prazo Emitidos entre 61 e 90 dias (Interno)',
                                                'Total de cheques a Prazo Emitidos (Interno)',

                                                'Emissão do Primeiro Cheque a Vista (Mercado)',
                                                'Emissão do Último Cheque a Vista (Mercado)',
                                                'Cheques a Vista Emitidos nos Últimos 15 dias (Mercado)',
                                                'Cheques a Prazo Emitidos nos Últimos 30 dias (Mercado)',
                                                'Cheques a Prazo Emitidos entre 31 e 60 dias (Mercado)',
                                                'Cheques a Prazo Emitidos entre 61 e 90 dias (Mercado)',
                                                'Total de cheques a Prazo Emitidos (Mercado)',

                                                'Consultante do 1º Cheque a Prazo Mais recente',
                                                'Data da Consulta',
                                                'Consultante do 2º Cheque a Prazo Mais recente',
                                                'Data da Consulta',
                                                'Consultante do 3º Cheque a Prazo Mais recente',
                                                'Data da Consulta'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg36.IntEmissPriCHVista,
                              Reg36.IntEmissUltCHVista,
                              Reg36.IntTotCHVista15,
                              Reg36.IntTotCHPrazo30,
                              Reg36.IntTotCHPrazo3160,
                              Reg36.IntTotCHPrazo6190,
                              Reg36.IntTotCHPrazo,

                              Reg36.MerEmissPriCHVista,
                              Reg36.MerEmissUltCHVista,
                              Reg36.MerTotCHVista15,
                              Reg36.MerTotCHPrazo30,
                              Reg36.MerTotCHPrazo3160,
                              Reg36.MerTotCHPrazo6190,
                              Reg36.MerTotCHPrazo,

                              Reg36.ConsPrazoNomeEmpresa1,
                              Reg36.ConsPrazoNomeData1,

                              Reg36.ConsPrazoNomeEmpresa2,
                              Reg36.ConsPrazoNomeData2,

                              Reg36.ConsPrazoNomeEmpresa3,
                              Reg36.ConsPrazoNomeData3], False) + #13#10;
end;

function Reg32ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg32: TReg32;
begin
  if Length(sReg) <> TAM_REG32 then
    raise Exception.Create(GeraErroTamanho('32'));

    Reg32.LogradouroAssinante  := Copy(sReg, 3, 70);
    Reg32.BairroAsinante := Copy(sReg, 73, 70);
    Reg32.CidadeAssinante := Copy(sReg, 143, 30);
    Reg32.CEPAssinante  := Copy(sReg, 173, 9);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('TeleConfirma',
                                                ['Logradouro Assinante',
                                                'Bairro',
                                                'Cidade',
                                                'CEP'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg32.LogradouroAssinante,
                              Reg32.BairroAsinante,
                              Reg32.CidadeAssinante,
                              Reg32.CEPAssinante], False) + #13#10;
end;

function Reg34ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg34: TReg34;
begin
  if Length(sReg) <> TAM_REG34 then
    raise Exception.Create(GeraErroTamanho('34'));

    Reg34.IndicadorPesquisa := Copy(sReg, 3, 1);
    Reg34.Mensagem          := Copy(sReg, 4, 40);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('TeleConfirma',
                                                ['Indicador de Pesquisa',
                                                'Mensagem'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([TrataIndPesqAssinante(Reg34.IndicadorPesquisa),
                              Reg34.Mensagem], False) + #13#10;
end;

function Reg38ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Registro de Consultas');
end;

function Reg40ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg40: TReg40;
begin
  if Length(sReg) <> TAM_REG40 then
    raise Exception.Create(GeraErroTamanho('40'));

    Reg40.MaisRecente1 := Copy(sReg, 3, 8);
    Reg40.MaisRecente2 := Copy(sReg, 11, 8);
    Reg40.MaisRecente3 := Copy(sReg, 19, 8);
    Reg40.MaisRecente4 := Copy(sReg, 27, 8);
    Reg40.MaisRecente5 := Copy(sReg, 35, 8);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Telefones Anteriores Consultados',
                                                ['1º Mais Recente',
                                                 '2º Mais Recente',
                                                 '3º Mais Recente',
                                                 '4º Mais Recente',
                                                 '5º Mais Recente'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg40.MaisRecente1,
                              Reg40.MaisRecente2,
                              Reg40.MaisRecente3,
                              Reg40.MaisRecente4,
                              Reg40.MaisRecente5], False) + #13#10;
end;

function Reg42ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Telefones Anteriores Consultados');
end;


function Reg44ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg44: TReg44;
begin
  if Length(sReg) <> TAM_REG44 then
    raise Exception.Create(GeraErroTamanho('44'));

    Reg44.MensagemSituacao     := Copy(sReg, 3, 40);
    Reg44.AberturaEncerramento := Copy(sReg, 43, 8);
    Reg44.TipoPessoaRegistrada := Copy(sReg, 51, 1);
    Reg44.Documentoregistrado  := Copy(sReg, 52, 15);
    Reg44.NomeRazaoSocial      := Copy(sReg, 67, 40);
    Reg44.TipoDocumento        := Copy(sReg, 107, 1);
    Reg44.NumeroDocumento      := Copy(sReg, 108, 15);
    Reg44.OrgaoEmissor         := Copy(sReg, 123, 5);
    Reg44.UF                   := Copy(sReg, 128, 2);
    Reg44.DataEmissao          := Copy(sReg, 130, TAM_DATA);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Recheque Online',
                                                ['Mensagem Banco / CC',
                                                'Abertura / Encerramento',
                                                'Tipo de Pessoa',
                                                'Documento Registrado',
                                                'Nome / Razão Social',
                                                'Tipo Documento',
                                                'Número Documento',
                                                'Orgão Emissor',
                                                'UF',
                                                'Data Emissão Documento'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg44.MensagemSituacao,
                              Reg44.AberturaEncerramento,
                              TrataTipoPessoa(Reg44.TipoPessoaRegistrada),
                              Reg44.Documentoregistrado,
                              Reg44.NomeRazaoSocial,
                              TrataTipoDoc(Reg44.TipoDocumento),
                              Reg44.NumeroDocumento,
                              Reg44.OrgaoEmissor,
                              Reg44.UF,
                              TrataDataSerasa(Reg44.DataEmissao)], False) + #13#10;
end;


function Reg46ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg46: TReg46;
begin
  if Length(sReg) <> TAM_REG46 then
    raise Exception.Create(GeraErroTamanho('46'));

    Reg46.CodigoBanco        := Copy(sReg, 3, 3);
    Reg46.IndicadorRecheque  := Copy(sReg, 6, 1);
    Reg46.Mensagem           := Copy(sReg, 7, 36);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Recheque Online',
                                                ['Código do Banco',
                                                'Participação no Recheque Online',
                                                'Mensagem'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg46.CodigoBanco,
                              TratapartRechequeOnline(Reg46.IndicadorRecheque),
                              Reg46.Mensagem], False) + #13#10;
end;


function Reg48ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg48: TReg48;
begin
  if Length(sReg) <> TAM_REG48 then
    raise Exception.Create(GeraErroTamanho('48'));

    Reg48.EnderecoCEP := Copy(sReg, 3, 70);
    Reg48.Bairro      := Copy(sReg, 73, 30);
    Reg48.Ciadade     := Copy(sReg, 103, 30);
    Reg48.UF          := Copy(sReg, 133, 2);
    Reg48.Generico    := Copy(sReg, 135, 1);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Endereço do CEP',
                                                ['Endereço do CEP',
                                                'Bairro',
                                                'Cidade',
                                                'UF',
                                                'CEP Genérico'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg48.EnderecoCEP,
                              Reg48.Bairro,
                              Reg48.Ciadade,
                              Reg48.UF,
                              TrataSimNao(Reg48.Generico)], False) + #13#10;
end;


function Reg50ToHTML(sReg: String) : String;
begin
  Result := RegNadaConstaToHTML(sReg, 'Endereço do CEP');
end;

function Reg52ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg52: TReg52;
begin
  if Length(sReg) <> TAM_REG52 then
    raise Exception.Create(GeraErroTamanho('52'));

  Reg52.NomeAgenciaBancaria := Copy(sReg, 3, 70);
  Reg52.EnderecoAgencia     := Copy(sReg, 73, 70);
  Reg52.Cidade              := Copy(sReg, 143, 30);
  Reg52.UF                  := Copy(sReg, 173, 2);
  Reg52.UltimaAtualizacao   := Copy(sReg, 175, TAM_DATA);
  Reg52.DDDAgencia          := Copy(sReg, 183, 4);
  Reg52.TelAgencia          := Copy(sReg, 187, 8);
  Reg52.DDDFaxAgencia       := Copy(sReg, 195, 4);
  Reg52.FaxAgencia          := Copy(sReg, 197, 8);


  if IsFirst then
    Result := Result +
              GenerateTableHeader('Endereço da Agência Bancária',
                                                ['Nome Agência',
                                                'Endereço Agência',
                                                'Cidade',
                                                'UF',
                                                'Última Atualização',
                                                'Cód. DDD Tel. Agência',
                                                'Tel. Agência',
                                                'Cód. DDD Fax Agência',
                                                'Fax Agência'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg52.NomeAgenciaBancaria,
                              Reg52.EnderecoAgencia,
                              Reg52.Cidade,
                              Reg52.UF,
                              Reg52.UltimaAtualizacao,
                              Reg52.DDDAgencia,
                              Reg52.TelAgencia,
                              Reg52.DDDFaxAgencia,
                              Reg52.FaxAgencia], False) + #13#10;
end;

function Reg54ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg54: TReg54;
begin
  if Length(sReg) <> TAM_REG54 then
    raise Exception.Create(GeraErroTamanho('54'));

  Reg54.Mensagem           := Copy(sReg, 3, 32);
  Reg54.UltimaAtualizacao  := Copy(sReg, 73, TAM_DATA);

  if IsFirst then
    Result := Result +
              GenerateTableHeader('Endereço da Agência Bancária',
                                                ['Mensagem',
                                                'Data Ultima Atualizção da Base de Dados'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg54.Mensagem,
                              Reg54.UltimaAtualizacao],
                             False) + #13#10;
end;


function Reg90ToHTML(sReg: String; IsFirst: Boolean): String;
var
  Reg90: TReg90;
begin
  if Length(sReg) <> TAM_REG90 then
    raise Exception.Create(GeraErroTamanho('90'));
  Reg90.CodigoMensagem := Copy(sReg, 3, 3);
  Reg90.Mensagem       := Copy(sReg, 6, 40);
  if IsFirst then
    Result := Result +
              GenerateTableHeader('Mensagem do Serasa',
                                                ['Código',
                                                'Mensagem'])
  else
    Result := '';

  Result := Result +
            GenerateTableRow([Reg90.CodigoMensagem,
                              Reg90.Mensagem],
                             False) + #13#10;
end;


function ExecCript(TP:String;BufEnv:String;BufOut:String):PCHAR;
var
  HLib : Cardinal;
  CriptFunction: TCriptFunction;
begin
  HLib := LoadLibrary('dllcript.dll');
  try
    @CriptFunction := GetProcAddress(HLib, 'cript');
    try
      Result := CriptFunction(TP, BufEnv, BufOut);
    finally
      @CriptFunction := Nil;
    end;
  finally
    FreeLibrary(HLib);
  end;
end;

function CriptografaSERASA(AText: String): String;
var
  Ax :TyBuf;
  PResult: PChar;
begin
  Move(AText[1],Ax,Length(AText));
  Ax[Length(AText)+1] := Chr(0);
  PResult := ExecCript('0',AX,AX);
  Result := StrPas(PResult);
end;

function DescriptografaSERASA(AText: String): String;
var
  Ax, BX :TyBuf;
  PResult: PChar;
begin
  FillChar(AX, Length(AX), 0);
  FillChar(BX, Length(AX), 0);

  move(AText[1],Ax,Length(AText));

  Ax[Length(AText)+1] := Chr(0);
  BX[Length(AText)+1] := Chr(0);



  PResult := ExecCript('1',AText,BX);
  Result := StrPas(PResult);
end;


function GenerateTableHeader(ACaption: String; Titles: Array of String): String;
var
  I : Integer;
begin
  Result :=           '    <table width="98%" border="1">'#13#10;
  Result := Result +  '      <caption>'#13#10;
  Result := Result +  '        <strong>'+ACaption+'</strong>'#13#10;
  Result := Result +  '      <caption>'+#13#10;
  Result := Result + #13#10 + GenerateTableRow(Titles, True);
end;

function GenerateTableRow(Data: array of string; Strong: Boolean): string;
var
  I : Integer;
begin
  Result     :=           '      <tr>'+#13#10;
  for I := 0 to Length(Data) - 1 do
  begin

    if Strong then
      Result := Result +  '        <td><strong>'+NoBreakSpace(Data[I])+'</strong></td>'+#13#10
    else
      Result := Result +  '        <td>'+NoBreakSpace(Data[I])+'</td>'+#13#10;

  end;
  Result     := Result +  '      </tr>'+#13#10;
end;

end.
