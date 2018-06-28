program GerenciaNotaFiscal;

uses
  Forms,
  udmSQL in 'udmSQL.pas' {dmSQL: TDataModule},
  udmNFe in 'udmNFe.pas' {dmNFe: TDataModule},
  ufrmGerenciaEnvioNF in 'ufrmGerenciaEnvioNF.pas' {frmGerenciaEnvioNF},
  uFrmProgresso in 'uFrmProgresso.pas' {FrmProgresso},
  ufrmConfiguracao in 'ufrmConfiguracao.pas' {frmConfiguracao},
  uFrmImportarNotas in 'uFrmImportarNotas.pas' {FrmImportarNotas},
  uFrmDetalheNota in 'uFrmDetalheNota.pas' {FrmDetalheNota},
  uFrmUnitilizaNota in 'uFrmUnitilizaNota.pas' {FrmUnitilizaNota};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MainRetail - NFe';
  Application.CreateForm(TdmSQL, dmSQL);
  Application.CreateForm(TdmNFe, dmNFe);
  Application.CreateForm(TfrmGerenciaEnvioNF, frmGerenciaEnvioNF);
  Application.Run;
end.
