program MRGarantias;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmPrincipal},
  uFrmConfig in 'uFrmConfig.pas' {FrmConfig},
  uFrmGeraArquivo in 'uFrmGeraArquivo.pas' {FrmGeraArquivo},
  uFrmImprimirRAEC in 'uFrmImprimirRAEC.pas' {FrmImprimirRAEC},
  uFrmReImprimirRAEC in 'uFrmReImprimirRAEC.pas' {FrmReImprimir},
  uImportXML in 'uImportXML.pas' {FrmImportXML};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MR Garantias';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
