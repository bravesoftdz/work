{===============================================================================
Projeto Sintegra
****************

Biblioteca de Componente para geração do arquivo Sintegra
Site: http://www.sultan.welter.pro.br

Direitos Autorais Reservados (c) 2004 Régys Borges da Silveira

Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la sob
os termos da Licença Pública Geral Menor do GNU conforme publicada pela Free
Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) qualquer
versão posterior.

Esta biblioteca é distribuído na expectativa de que seja útil, porém, SEM
NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU
ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor do
GNU para mais detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto com
esta biblioteca; se não, escreva para a Free Software Foundation, Inc., no
endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.
================================================================================
Contato:
          Autor...: Régys Borges da Silveira
          Email...: regyssilveira@hotmail.com
================================================================================
Colaboração:
          Marcelo Welter <marcelo@welter.pro.br>
===============================================================================}

unit Funcoes;

interface

uses
  SysUtils, Controls, Classes, Sintegra;

function LFIll(aString: string; aCaracter: Char; aTamanho: integer): string;
function RFill(aString: string; aCaracter: Char; aTamanho: integer): string;
function StrToNumero(aValor: string; aDecimais: Integer): Extended;
function RetornarCodPosse(TipoPosse: TTipoPosse): string;
function RetornarFinalidade(aFinalidade: TCodFinalidade): string;
function RetornarModDocumento(aTipoDocumento: TModDocumento): string;
function RetornarNatureza(aNaturezaOper: TCodIdentificaOper): string;
function RetornarSitNotafiscal(aSituacao: TSitNotaFiscal): string;
function RetornarTipoEmitente(aTipoEmitente: TTipoEmitente): string;
function RetornarTipoFrete(aTipoFrete: TModalidadeFrete): string;
function VerificarCEP(cCep, cEstado: string): Boolean;
function VerificarCFOP(aCFOP: string): Boolean;
function VerificarCPF_CNPJ(aCNPJ_CPF: string): Boolean;
function VerificarCST(aCST: string): Boolean;
function VerificarInscEstadual(aInscricao, aTipo: string): Boolean;
function VerificarSitTributaria(aSitTributaria: string): Boolean;
function VerificarUF(aUF: string): Boolean;
function VerificarSerieNF(aSerie: string): Boolean;

implementation

{
********** Preenche com caracteres a direita ***********************************
}

function RFill(aString: string; aCaracter: Char; aTamanho: integer): string;
var
  Dado: string;
begin
  if Length(aString) > aTamanho then
    Dado := Copy(aString, 0, aTamanho)
  else
    Dado := aString;

  Result := Dado + StringOfChar(aCaracter, aTamanho - length(Dado));
end;

{
********** Preenche com caracteres a esquerda **********************************
}

function LFIll(aString: string; aCaracter: Char; aTamanho: integer): string;
var
  Dado: string;
begin
  if Length(aString) > aTamanho then
    Dado := Copy(aString, 0, aTamanho)
  else
    Dado := aString;

  Result := StringOfChar(aCaracter, aTamanho - length(Dado)) + Dado;
end;

{
********** Retorna o codigo na natureza da operação ****************************
}

function RetornarNatureza(aNaturezaOper: TCodIdentificaOper): string;
begin
  case aNaturezaOper of
    opeInterestSubTributaria: Result := '1';
    opeInterestaduais: Result := '2';
    opeTotal: Result := '3';
  end;
end;

{
********** Retorna o codigo da finalidade **************************************
}

function RetornarFinalidade(aFinalidade: TCodFinalidade): string;
begin
  case aFinalidade of
    finNormal: Result := '1';
    finRetificacaoTotal: Result := '2';
    finRetificacaoAditiva: Result := '3';
    finDesfazimento: Result := '5';
  end;
end;

{
********** Retorna o Modelo do documento pra o registro 60 *********************
}

function RetornarModDocumento(aTipoDocumento: TModDocumento): string;
begin
  case aTipoDocumento of
    modMaqRegistradora: Result := '2B';
    modPDV: Result := '2C';
    modECF: Result := '2D';
  end;
end;

{
********** Retorna o tipo do emitente ******************************************
}

function RetornarTipoEmitente(aTipoEmitente: TTipoEmitente): string;
begin
  case aTipoEmitente of
    tpeProprio: Result := 'P';
    tpeTerceiros: Result := 'T';
  end;
end;

{
********** Retorna a situação da nota fiscal ***********************************
}

function RetornarSitNotafiscal(aSituacao: TSitNotaFiscal): string;
begin
  case aSituacao of
    nfNormal: Result := 'N';
    nfCancelado: Result := 'S';
    nfExtNormal: Result := 'E';
    nfExtCancelado: Result := 'X';
  end;
end;

{
********** Retorna a modalidade do frete ***************************************
}

function RetornarTipoFrete(aTipoFrete: TModalidadeFrete): string;
begin
  case aTipoFrete of
    frCIF: Result := '1';
    frFOB: Result := '2';
    frOUTRO: Result := '0';
  end;
end;

{
********** Verifica se a UF digitada e valida **********************************
}

function VerificarUF(aUF: string): Boolean;
const
  ListaUF: array[0..26] of string = (
    'AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF',
    'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA',
    'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO',
    'RR', 'RS', 'SC', 'SE', 'SP', 'TO');
var
  i: integer;
  Encontrado: Boolean;
begin
  i := 0;
  Encontrado := False;
  
  while (not (Encontrado)) and (i <= 26) do
  begin
    Encontrado := ListaUF[i] = aUF;
    inc(i);
  end;

  Result := Encontrado;
end;

{
********** Verifica se o CEP e valido ******************************************
}

function VerificarCEP(cCep: string; cEstado: string): Boolean;
var
  cCEP1: Integer;
begin
  cCEP1 := StrToInt(copy(cCep, 1, 3));
  if Length(trim(cCep)) > 0 then
  begin
    if Length(trim(copy(cCep, 6, 3))) < 3 then
      Result := False
    else if (cEstado = 'SP') and (cCEP1 >= 10) and (cCEP1 <= 199) then
      Result := True
    else if (cEstado = 'RJ') and (cCEP1 >= 200) and (cCEP1 <= 289) then
      Result := True
    else if (cEstado = 'ES') and (cCEP1 >= 290) and (cCEP1 <= 299) then
      Result := True
    else if (cEstado = 'MG') and (cCEP1 >= 300) and (cCEP1 <= 399) then
      Result := True
    else if (cEstado = 'BA') and (cCEP1 >= 400) and (cCEP1 <= 489) then
      Result := True
    else if (cEstado = 'SE') and (cCEP1 >= 490) and (cCEP1 <= 499) then
      Result := True
    else if (cEstado = 'PE') and (cCEP1 >= 500) and (cCEP1 <= 569) then
      Result := True
    else if (cEstado = 'AL') and (cCEP1 >= 570) and (cCEP1 <= 579) then
      Result := True
    else if (cEstado = 'PB') and (cCEP1 >= 580) and (cCEP1 <= 589) then
      Result := True
    else if (cEstado = 'RN') and (cCEP1 >= 590) and (cCEP1 <= 599) then
      Result := True
    else if (cEstado = 'CE') and (cCEP1 >= 600) and (cCEP1 <= 639) then
      Result := True
    else if (cEstado = 'PI') and (cCEP1 >= 640) and (cCEP1 <= 649) then
      Result := True
    else if (cEstado = 'MA') and (cCEP1 >= 650) and (cCEP1 <= 659) then
      Result := True
    else if (cEstado = 'PA') and (cCEP1 >= 660) and (cCEP1 <= 688) then
      Result := True
    else if (cEstado = 'AM') and ((cCEP1 >= 690) and (cCEP1 <= 692) or (cCEP1 >= 694) and (cCEP1 <= 698)) then
      Result := True
    else if (cEstado = 'AP') and (cCEP1 = 689) then
      Result := True
    else if (cEstado = 'RR') and (cCEP1 = 693) then
      Result := True
    else if (cEstado = 'AC') and (cCEP1 = 699) then
      Result := True
    else if ((cEstado = 'DF') or (cEstado = 'GO')) and (cCEP1 >= 700) and (cCEP1 <= 769) then
      Result := True
    else if (cEstado = 'TO') and (cCEP1 >= 770) and (cCEP1 <= 779) then
      Result := True
    else if (cEstado = 'MT') and (cCEP1 >= 780) and (cCEP1 <= 788) then
      Result := True
    else if (cEstado = 'MS') and (cCEP1 >= 790) and (cCEP1 <= 799) then
      Result := True
    else if (cEstado = 'RO') and (cCEP1 = 789) then
      Result := True
    else if (cEstado = 'PR') and (cCEP1 >= 800) and (cCEP1 <= 879) then
      Result := True
    else if (cEstado = 'SC') and (cCEP1 >= 880) and (cCEP1 <= 899) then
      Result := True
    else if (cEstado = 'RS') and (cCEP1 >= 900) and (cCEP1 <= 999) then
      Result := True
    else
      Result := False
  end
  else
    Result := True;
end;

{
********** Valida a inscrição estadual *****************************************
}

function VerificarInscEstadual(aInscricao, aTipo: string): Boolean;
var
  Contador: ShortInt;
  Casos: ShortInt;
  Digitos: ShortInt;

  Tabela_1: string;
  Tabela_2: string;
  Tabela_3: string;

  Base_1: string;
  Base_2: string;
  Base_3: string;

  Valor_1: ShortInt;

  Soma_1: Integer;
  Soma_2: Integer;

  Erro_1: ShortInt;
  Erro_2: ShortInt;
  Erro_3: ShortInt;

  Posicao_1: string;
  Posicao_2: string;

  Tabela: string;
  Rotina: string;
  Modulo: ShortInt;
  Peso: string;

  Digito: ShortInt;

  Resultado: string;
  Retorno: Boolean;
begin
  try
    Tabela_1 := ' ';
    Tabela_2 := ' ';
    Tabela_3 := ' ';

    if aTipo = 'AC' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     01NNNNNNX.14.00';
    if aTipo = 'AC' then
      Tabela_2 := '2.13.0.E.11.02.E.11.01. 01NNNNNNNNNXY.13.14';
    if aTipo = 'AL' then
      Tabela_1 := '1.09.0.0.11.01. .  .  .     24BNNNNNX.14.00';
    if aTipo = 'AP' then
      Tabela_1 := '1.09.0.1.11.01. .  .  .     03NNNNNNX.14.00';
    if aTipo = 'AP' then
      Tabela_2 := '2.09.1.1.11.01. .  .  .     03NNNNNNX.14.00';
    if aTipo = 'AP' then
      Tabela_3 := '3.09.0.E.11.01. .  .  .     03NNNNNNX.14.00';
    if aTipo = 'AM' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0CNNNNNNX.14.00';
    if aTipo = 'BA' then
      Tabela_1 := '1.08.0.E.10.02.E.10.03.      NNNNNNYX.14.13';
    if aTipo = 'BA' then
      Tabela_2 := '2.08.0.E.11.02.E.11.03.      NNNNNNYX.14.13';
    if aTipo = 'CE' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0NNNNNNNX.14.13';
    if aTipo = 'DF' then
      Tabela_1 := '1.13.0.E.11.02.E.11.01. 07DNNNNNNNNXY.13.14';
    if aTipo = 'ES' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0ENNNNNNX.14.00';
    if aTipo = 'GO' then
      Tabela_1 := '1.09.1.E.11.01. .  .  .     1FNNNNNNX.14.00';
    if aTipo = 'GO' then
      Tabela_2 := '2.09.0.E.11.01. .  .  .     1FNNNNNNX.14.00';
    if aTipo = 'MA' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     12NNNNNNX.14.00';
    if aTipo = 'MT' then
      Tabela_1 := '1.11.0.E.11.01. .  .  .   NNNNNNNNNNX.14.00';
    if aTipo = 'MS' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     28NNNNNNX.14.00';
    if aTipo = 'MG' then
      Tabela_1 := '1.13.0.2.10.10.E.11.11. NNNNNNNNNNNXY.13.14';
    if aTipo = 'PA' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     15NNNNNNX.14.00';
    if aTipo = 'PB' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     16NNNNNNX.14.00';
    if aTipo = 'PR' then
      Tabela_1 := '1.10.0.E.11.09.E.11.08.    NNNNNNNNXY.13.14';
    if aTipo = 'PE' then
      Tabela_1 := '1.14.1.E.11.07. .  .  .18ANNNNNNNNNNX.14.00';
    if aTipo = 'PI' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     19NNNNNNX.14.00';
    if aTipo = 'RJ' then
      Tabela_1 := '1.08.0.E.11.08. .  .  .      GNNNNNNX.14.00';
    if aTipo = 'RN' then
      Tabela_1 := '1.09.0.0.11.01. .  .  .     20HNNNNNX.14.00';
    if aTipo = 'RS' then
      Tabela_1 := '1.10.0.E.11.01. .  .  .    INNNNNNNNX.14.00';
    if aTipo = 'RO' then
      Tabela_1 := '1.09.1.E.11.04. .  .  .     ANNNNNNNX.14.00';
    if aTipo = 'RO' then
      Tabela_2 := '2.14.0.E.11.01. .  .  .NNNNNNNNNNNNNX.14.00';
    if aTipo = 'RR' then
      Tabela_1 := '1.09.0.D.09.05. .  .  .     24NNNNNNX.14.00';
    if aTipo = 'SC' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
    if aTipo = 'SP' then
      Tabela_1 := '1.12.0.D.11.12.D.11.13.  NNNNNNNNXNNY.11.14';
    if aTipo = 'SP' then
      Tabela_2 := '2.12.0.D.11.12. .  .  .  NNNNNNNNXNNN.11.00';
    if aTipo = 'SE' then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
    if aTipo = 'TO' then
      Tabela_1 := '1.11.0.E.11.06. .  .  .   29JKNNNNNNX.14.00';
    if aTipo = 'CNPJ' then
      Tabela_1 := '1.14.0.E.11.21.E.11.22.NNNNNNNNNNNNXY.13.14';
    if aTipo = 'CPF' then
      Tabela_1 := '1.11.0.E.11.31.E.11.32.   NNNNNNNNNXY.13.14';

    { Deixa somente os numeros }

    Base_1 := '';

    for Contador := 1 to 30 do
      if Pos(Copy(aInscricao, Contador, 1), '0123456789') <> 0 then
        Base_1 := Base_1 + Copy(aInscricao, Contador, 1);

    { Repete 3x - 1 para cada caso possivel  }

    Casos := 0;

    Erro_1 := 0;
    Erro_2 := 0;
    Erro_3 := 0;

    while Casos < 3 do
    begin

      Casos := Casos + 1;

      if Casos = 1 then
        Tabela := Tabela_1;
      if Casos = 2 then
        Erro_1 := Erro_3;
      if Casos = 2 then
        Tabela := Tabela_2;
      if Casos = 3 then
        Erro_2 := Erro_3;
      if Casos = 3 then
        Tabela := Tabela_3;

      Erro_3 := 0;

      if Copy(Tabela, 1, 1) <> ' ' then
      begin

        { Verifica o Tamanho }

        if Length(Trim(Base_1)) <> (StrToInt(Copy(Tabela, 3, 2))) then
          Erro_3 := 1;

        if Erro_3 = 0 then
        begin

          { Ajusta o Tamanho }

          Base_2 := Copy('              ' + Base_1, Length('              ' + Base_1) - 13, 14);

          { Compara com valores possivel para cada uma da 14 posições }

          Contador := 0;

          while (Contador < 14) and (Erro_3 = 0) do
          begin

            Contador := Contador + 1;

            Posicao_1 := Copy(Copy(Tabela, 24, 14), Contador, 1);
            Posicao_2 := Copy(Base_2, Contador, 1);

            if (Posicao_1 = ' ') and (Posicao_2 <> ' ') then
              Erro_3 := 1;
            if (Posicao_1 = 'N') and (Pos(Posicao_2, '0123456789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'A') and (Pos(Posicao_2, '123456789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'B') and (Pos(Posicao_2, '03578') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'C') and (Pos(Posicao_2, '47') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'D') and (Pos(Posicao_2, '34') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'E') and (Pos(Posicao_2, '08') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'F') and (Pos(Posicao_2, '015') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'G') and (Pos(Posicao_2, '1789') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'H') and (Pos(Posicao_2, '0123') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'I') and (Pos(Posicao_2, '01234') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'J') and (Pos(Posicao_2, '09') = 0) then
              Erro_3 := 1;
            if (Posicao_1 = 'K') and (Pos(Posicao_2, '1239') = 0) then
              Erro_3 := 1;
            if (Posicao_1 <> Posicao_2) and (Pos(Posicao_1, '0123456789') > 0) then
              Erro_3 := 1;

          end;

          { Calcula os Digitos }

          Rotina := ' ';
          Digitos := 000;
          Digito := 000;

          while (Digitos < 2) and (Erro_3 = 0) do
          begin

            Digitos := Digitos + 1;

            { Carrega peso }

            Peso := Copy(Tabela, 5 + (Digitos * 8), 2);

            if Peso <> '  ' then
            begin

              Rotina := Copy(Tabela, 0 + (Digitos * 8), 1);
              Modulo := StrToInt(Copy(Tabela, 2 + (Digitos * 8), 2));

              if Peso = '01' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              if Peso = '02' then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              if Peso = '03' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.00.02';
              if Peso = '04' then
                Peso := '00.00.00.00.00.00.00.00.06.05.04.03.02.00';
              if Peso = '05' then
                Peso := '00.00.00.00.00.01.02.03.04.05.06.07.08.00';
              if Peso = '06' then
                Peso := '00.00.00.09.08.00.00.07.06.05.04.03.02.00';
              if Peso = '07' then
                Peso := '05.04.03.02.01.09.08.07.06.05.04.03.02.00';
              if Peso = '08' then
                Peso := '08.07.06.05.04.03.02.07.06.05.04.03.02.00';
              if Peso = '09' then
                Peso := '07.06.05.04.03.02.07.06.05.04.03.02.00.00';
              if Peso = '10' then
                Peso := '00.01.02.01.01.02.01.02.01.02.01.02.00.00';
              if Peso = '11' then
                Peso := '00.03.02.11.10.09.08.07.06.05.04.03.02.00';
              if Peso = '12' then
                Peso := '00.00.01.03.04.05.06.07.08.10.00.00.00.00';
              if Peso = '13' then
                Peso := '00.00.03.02.10.09.08.07.06.05.04.03.02.00';
              if Peso = '21' then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              if Peso = '22' then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              if Peso = '31' then
                Peso := '00.00.00.10.09.08.07.06.05.04.03.02.00.00';
              if Peso = '32' then
                Peso := '00.00.00.11.10.09.08.07.06.05.04.03.02.00';

              { Multiplica }

              Base_3 := Copy(('0000000000000000' + Trim(Base_2)), Length(('0000000000000000' + Trim(Base_2))) - 13, 14);

              Soma_1 := 0;
              Soma_2 := 0;

              for Contador := 1 to 14 do
              begin

                Valor_1 := (StrToInt(Copy(Base_3, Contador, 01)) * StrToInt(Copy(Peso, Contador * 3 - 2, 2)));

                Soma_1 := Soma_1 + Valor_1;

                if Valor_1 > 9 then
                  Valor_1 := Valor_1 - 9;

                Soma_2 := Soma_2 + Valor_1;

              end;

              { Ajusta valor da soma }
              if Pos(Rotina, 'A2') > 0 then
                Soma_1 := Soma_2;
              if Pos(Rotina, 'B0') > 0 then
                Soma_1 := Soma_1 * 10;
              if Pos(Rotina, 'C1') > 0 then
                Soma_1 := Soma_1 + (5 + 4 * StrToInt(Copy(Tabela, 6, 1)));

              { Calcula o Digito }
              if Pos(Rotina, 'D0') > 0 then
                Digito := Soma_1 mod Modulo;
              if Pos(Rotina, 'E12') > 0 then
                Digito := Modulo - (Soma_1 mod Modulo);

              if Digito < 10 then
                Resultado := IntToStr(Digito);
              if Digito = 10 then
                Resultado := '0';
              if Digito = 11 then
                Resultado := Copy(Tabela, 6, 1);

              { Verifica o Digito }
              if (Copy(Base_2, StrToInt(Copy(Tabela, 36 + (Digitos * 3), 2)), 1) <> Resultado) then
                Erro_3 := 1;
            end;
          end;
        end;
      end;
    end;

    { Retorna o resultado da Verificação }

    Retorno := FALSE;

    if (Trim(Tabela_1) <> '') and (ERRO_1 = 0) then
      Retorno := TRUE;
    if (Trim(Tabela_2) <> '') and (ERRO_2 = 0) then
      Retorno := TRUE;
    if (Trim(Tabela_3) <> '') and (ERRO_3 = 0) then
      Retorno := TRUE;

    if Trim(aInscricao) = 'ISENTO' then
      Retorno := TRUE;

    Result := Retorno;
  except
    Result := False;
  end;
end;

{
********** Verifica se o CPF/CNPJ e Valido *************************************
}

function VerificarCPF_CNPJ(aCNPJ_CPF: string): Boolean;
var
  iD1, iD2, i: integer;
  sNumero, sDigitado, sCalculado: string;
begin
  { Limpa a String deixando so os numeros }

  sNumero := '';

  for i := 0 to Length(aCNPJ_CPF) do
    if aCNPJ_CPF[i] in ['0'..'9'] then
      sNumero := sNumero + aCNPJ_CPF[i];

  { Efetua os calculos para a validacao }

  case Length(sNumero) of
    11: { CPF }
      begin
        { Calculo do primeiro digito }
        iD1 := 11 - (
          (
          (StrToInt(sNumero[9]) * 2) +
          (StrToInt(sNumero[8]) * 3) +
          (StrToInt(sNumero[7]) * 4) +
          (StrToInt(sNumero[6]) * 5) +
          (StrToInt(sNumero[5]) * 6) +
          (StrToInt(sNumero[4]) * 7) +
          (StrToInt(sNumero[3]) * 8) +
          (StrToInt(sNumero[2]) * 9) +
          (StrToInt(sNumero[1]) * 10)
          ) mod 11);

        if iD1 >= 10 then
          iD1 := 0;

        { Calculo do Segundo Digito }

        iD2 := 11 - (
          (
          (iD1 * 2) +
          (StrToInt(sNumero[9]) * 3) +
          (StrToInt(sNumero[8]) * 4) +
          (StrToInt(sNumero[7]) * 5) +
          (StrToInt(sNumero[6]) * 6) +
          (StrToInt(sNumero[5]) * 7) +
          (StrToInt(sNumero[4]) * 8) +
          (StrToInt(sNumero[3]) * 9) +
          (StrToInt(sNumero[2]) * 10) +
          (StrToInt(sNumero[1]) * 11)
          ) mod 11);

        if iD2 >= 10 then
          iD2 := 0;

        sCalculado := IntToStr(iD1) + IntToStr(iD2);
        sDigitado := sNumero[10] + sNumero[11];

        Result := sCalculado = sDigitado;
      end;

    14: { CNPJ }
      begin
        { Calculo do primeiro digito }
        iD1 := 11 - (
          (
          (StrToInt(sNumero[12]) * 2) +
          (StrToInt(sNumero[11]) * 3) +
          (StrToInt(sNumero[10]) * 4) +
          (StrToInt(sNumero[9]) * 5) +
          (StrToInt(sNumero[8]) * 6) +
          (StrToInt(sNumero[7]) * 7) +
          (StrToInt(sNumero[6]) * 8) +
          (StrToInt(sNumero[5]) * 9) +
          (StrToInt(sNumero[4]) * 2) +
          (StrToInt(sNumero[3]) * 3) +
          (StrToInt(sNumero[2]) * 4) +
          (StrToInt(sNumero[1]) * 5)
          ) mod 11);

        if iD1 >= 10 then
          iD1 := 0;

        { Calculo do Segundo Digito }

        iD2 := 11 - (
          (
          (iD1 * 2) +
          (StrToInt(sNumero[12]) * 3) +
          (StrToInt(sNumero[11]) * 4) +
          (StrToInt(sNumero[10]) * 5) +
          (StrToInt(sNumero[9]) * 6) +
          (StrToInt(sNumero[8]) * 7) +
          (StrToInt(sNumero[7]) * 8) +
          (StrToInt(sNumero[6]) * 9) +
          (StrToInt(sNumero[5]) * 2) +
          (StrToInt(sNumero[4]) * 3) +
          (StrToInt(sNumero[3]) * 4) +
          (StrToInt(sNumero[2]) * 5) +
          (StrToInt(sNumero[1]) * 6)
          ) mod 11);

        if iD2 >= 10 then
          iD2 := 0;

        sCalculado := IntToStr(iD1) + IntToStr(iD2);
        sDigitado := sNumero[13] + sNumero[14];

        Result := sCalculado = sDigitado;
      end;
  else
    Result := False;
  end;
end;

{
********** Passa uma string para numero ****************************************
}

function StrToNumero(aValor: string; aDecimais: Integer): Extended;
var
  i, iInicio, iFim: Integer;
  str: string;
begin
  str := '0';
  if Trim(aValor) <> '' then
  begin
    for i := 0 to Length(aValor) do
      if aValor[i] in ['0'..'9', '-'] then
        str := str + avalor[i];

    if (Trim(str) <> '') and (Trim(str) <> '-') then
    begin
      iInicio := Length(str) - aDecimais;
      iFim := Length(str);
      str := copy(str, 0, iInicio) + DecimalSeparator + Copy(str, iInicio + 1, iFim);
    end;
  end;

  Result := StrTofloat(str);
end;

{
********** Verifica se a Serie da NF e válida **********************************
}

function VerificarSerieNF(aSerie: string): Boolean;
var
  Serie: string;
begin
  if Length(aSerie) > 3 then
    Result := False
  else
  begin
    Serie := LFill(aSerie, ' ', 3);
    Result := (Serie[1] in [' ', 'B', 'C', 'E', 'U']) and
      (Serie[2] in [' ', 'U', '1'..'9']) and
      (Serie[3] in [' ', '1'..'9']) and
      (Serie <> 'UU');
  end;
end;

{
********** Verifica se a Situação Tributária e válida **************************
}

function VerificarSitTributaria(aSitTributaria: string): Boolean;
var
  aAliquota: Currency;
  aValida: Boolean;
begin
  aAliquota := StrToNumero(aSitTributaria, 2);
  
  if aAliquota = 0 then
  begin
    if aSitTributaria = 'F' then
      aValida := True
    else if aSitTributaria = 'I' then
      aValida := True
    else if aSitTributaria = 'N' then
      aValida := True
    else if aSitTributaria = 'CANC' then
      aValida := True
    else if aSitTributaria = 'DESC' then
      aValida := True
    else if aSitTributaria = 'ISS' then
      aValida := True
    else
      aValida := False;
  end
  else
    aValida := True;

  Result := aValida;
end;

{
********** Verifica se o CFOP e válido *****************************************
}

function VerificarCFOP(aCFOP: string): Boolean;
const
  ListaCFOP: array[0..522] of string = (
    '1101', '1102', '1111', '1113', '1116', '1117', '1118', '1120', '1121', '1122', '1124', '1125', '1126', '1151', '1152', '1153', '1154', '1201',
    '1202', '1203', '1204', '1205', '1206', '1207', '1208', '1209', '1251', '1252', '1253', '1254', '1255', '1256', '1257', '1301', '1302', '1303',
    '1304', '1305', '1306', '1351', '1352', '1353', '1354', '1355', '1356', '1401', '1403', '1406', '1407', '1408', '1409', '1410', '1411', '1414',
    '1415', '1451', '1452', '1501', '1503', '1504', '1551', '1552', '1553', '1554', '1555', '1556', '1557', '1601', '1602', '1603', '1604', '1650',
    '1651', '1652', '1653', '1658', '1659', '1660', '1661', '1662', '1663', '1664', '1901', '1902', '1903', '1904', '1905', '1906', '1907', '1908',
    '1909', '1910', '1911', '1912', '1913', '1914', '1915', '1916', '1917', '1918', '1919', '1920', '1921', '1922', '1923', '1924', '1925', '1926',
    '1949', '2101', '2102', '2111', '2113', '2116', '2117', '2118', '2120', '2121', '2122', '2124', '2125', '2126', '2151', '2152', '2153', '2154',
    '2201', '2202', '2203', '2204', '2205', '2206', '2207', '2208', '2209', '2251', '2252', '2253', '2254', '2255', '2256', '2257', '2301', '2302',
    '2303', '2304', '2305', '2306', '2351', '2352', '2353', '2354', '2355', '2356', '2401', '2403', '2406', '2407', '2408', '2409', '2410', '2411',
    '2414', '2415', '2501', '2503', '2504', '2551', '2552', '2553', '2554', '2555', '2556', '2557', '2603', '2651', '2652', '2653', '2658', '2659',
    '2660', '2661', '2662', '2663', '2664', '2901', '2902', '2903', '2904', '2905', '2906', '2907', '2908', '2909', '2910', '2911', '2912', '2913',
    '2914', '2915', '2916', '2917', '2918', '2919', '2920', '2921', '2922', '2923', '2924', '2925', '2949', '3101', '3102', '3126', '3127', '3201',
    '3202', '3205', '3206', '3207', '3211', '3251', '3301', '3351', '3352', '3353', '3354', '3355', '3356', '3503', '3551', '3553', '3556', '3650',
    '3651', '3652', '3653', '3930', '3949', '5101', '5102', '5103', '5104', '5105', '5106', '5109', '5110', '5111', '5112', '5113', '5114', '5115',
    '5116', '5117', '5118', '5119', '5120', '5122', '5123', '5124', '5125', '5151', '5152', '5153', '5155', '5156', '5201', '5202', '5205', '5206',
    '5207', '5208', '5209', '5210', '5251', '5252', '5253', '5254', '5255', '5256', '5257', '5258', '5301', '5302', '5303', '5304', '5305', '5306',
    '5307', '5351', '5352', '5353', '5354', '5355', '5356', '5357', '5401', '5402', '5403', '5405', '5408', '5409', '5410', '5411', '5412', '5413',
    '5414', '5415', '5451', '5501', '5502', '5503', '5551', '5552', '5553', '5554', '5555', '5556', '5557', '5601', '5602', '5603', '5650', '5651',
    '5652', '5653', '5654', '5655', '5656', '5657', '5658', '5659', '5660', '5661', '5662', '5663', '5664', '5665', '5666', '5901', '5902', '5903',
    '5904', '5905', '5906', '5907', '5908', '5909', '5910', '5911', '5912', '5913', '5914', '5915', '5916', '5917', '5918', '5919', '5920', '5921',
    '5922', '5923', '5924', '5925', '5926', '5927', '5928', '5929', '5931', '5932', '5949', '6101', '6102', '6103', '6104', '6105', '6106', '6107',
    '6108', '6109', '6110', '6111', '6112', '6113', '6114', '6115', '6116', '6117', '6118', '6119', '6120', '6122', '6123', '6124', '6125', '6151',
    '6152', '6153', '6155', '6156', '6201', '6202', '6205', '6206', '6207', '6208', '6209', '6210', '6251', '6252', '6253', '6254', '6255', '6256',
    '6257', '6258', '6301', '6302', '6303', '6304', '6305', '6306', '6307', '6351', '6352', '6353', '6354', '6355', '6356', '6357', '6401', '6402',
    '6403', '6404', '6408', '6409', '6410', '6411', '6412', '6413', '6414', '6415', '6501', '6502', '6503', '6551', '6552', '6553', '6554', '6555',
    '6556', '6557', '6603', '6650', '6651', '6652', '6653', '6654', '6655', '6656', '6657', '6658', '6659', '6660', '6661', '6662', '6663', '6664',
    '6665', '6666', '6901', '6902', '6903', '6904', '6905', '6906', '6907', '6908', '6909', '6910', '6911', '6912', '6913', '6914', '6915', '6916',
    '6917', '6918', '6919', '6920', '6921', '6922', '6923', '6924', '6925', '6929', '6931', '6932', '6949', '7101', '7102', '7105', '7106', '7127',
    '7201', '7202', '7205', '7206', '7207', '7210', '7211', '7251', '7301', '7358', '7501', '7551', '7553', '7556', '7650', '7651', '7654', '7930',
    '7949');
var
  i: Integer;
  Encontrado: Boolean;
begin
  i := 0;
  Encontrado := False;
  while (not (Encontrado)) and (i <= 522) do
  begin
    Encontrado := ListaCFOP[i] = aCFOP;
    inc(i);
  end;

  Result := Encontrado;
end;

{
********** Verifica se o Código de Situação Tributária esta correto ************
}

function VerificarCST(aCST: string): Boolean;
const
  ListaCST: array[0..32] of string = (
    '000', '010', '020', '030', '040', '041', '050', '051',
    '060', '070', '090', '100', '110', '120', '130', '140',
    '141', '150', '151', '160', '170', '190', '200', '210',
    '220', '230', '240', '241', '250', '251', '260', '270',
    '290');
var
  i: integer;
  Encontrado: Boolean;
begin
  i := 0;
  Encontrado := False;
  while (not (Encontrado)) and (i <= 32) do
  begin
    Encontrado := ListaCST[i] = aCST;
    inc(i);
  end;

  Result := Encontrado;
end;

{
********** Retorna o codigo do tipo de posse para a mercadoria no inventario ***
}

function RetornarCodPosse(TipoPosse: TTipoPosse): string;
begin
  case TipoPosse of
    tpo1: Result := '1';
    tpo2: Result := '2';
    tpo3: Result := '3';
  end;
end;

end.


