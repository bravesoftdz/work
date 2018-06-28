unit URepSocketConsts;

interface
uses SysUtils;
const
  FMT_SERVER_RECEIVING_DIR = '%S%S\%S\';
  FMT_SERVER_OUTPUT_DIR = '%S%S\global\';

  FMT_CLIENT_RECEIVING_DIR = '%Sglobal\';
  FMT_CLIENT_OUTPUT_DIR = '%Sout\';

  SERVER_FILENAME = 'global.zip';
  CLIENT_FILENAME = 'local.zip';
  STORES_FILENAME = 'stores.zip';


  CI_NOMECLIENTE  = '#NOMECLIENTE#=';
  CI_NOMELOJA     = '#NOMELOJA#=';
  CI_VERSAO       = '#VERSAO#=';
  CI_PACKETSIZE   = '#PACKETSIZE#=';
  CI_SENHA        = '#SENHA#=';
  CI_HOST         = '#HOST#=';
  CI_PORT         = '#PORT#';
  



implementation

end.
