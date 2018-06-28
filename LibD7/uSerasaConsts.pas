unit uSerasaConsts;

interface

const

// Constantes do Header

  HEADER_COD_TRANS            = 'RE01';
  HEADER_COD_TRANS_CONTRATADA = 'RX21';
  HEADER_COD_RELEASE          = 'VERSAO-01.09';
  HEADER_CHR_ENCERRAMENTO     = 'X';
  HEADER_MEIO_ACESSO_STRING   = '1';

  TAM_NOME    = 68;
  TAM_DATA    = 8;
  TAM_MES_ANO = 6;


  TAM_REG_NADA_CONSTA = 42;
  TAM_REG00           = 193;
  //TAM_REG04           = 101;
  TAM_REG08           = 109;
  TAM_REG04           = TAM_REG08;
  TAM_REG10           = 19;
  TAM_REG05           = TAM_REG10;
  TAM_REG14           = 72;
  TAM_REG18           = 42;
  TAM_REG22           = 75;
  TAM_REG26           = 55;
  TAM_REG30           = 83;
  TAM_REG32           = 181;
  TAM_REG34           = 43;
  TAM_REG36           = 129;
  TAM_REG40           = 42;

  TAM_REG44           = 137;
  TAM_REG46           = 42;
  TAM_REG48           = 135;
  TAM_REG52           = 206;
  TAM_REG54           = 42;


  TAM_REG90           = 45;

  COD_FINALIZACAO     = '99';

  MSG_ERRO_TAMANHO_INVALIDO = 'Erro: Registro %S com tamanho inválido';
  MSG_ERRO_RETORNO90        = 'Erro: "%S" Mensagem: "%S"';
  MSG_ERRO_RETORNO_INVALIDO = 'Tipo de retorno inválido "%S"';

  TXT_NAO_INFORMADO = 'Não Informado';
implementation

end.
