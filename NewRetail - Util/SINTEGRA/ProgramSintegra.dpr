program ProgramSintegra;

uses
  Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  Funcoes in 'Funcoes.pas',
  uGeraArquivo in 'uGeraArquivo.pas' {frmGeraArquivo},
  uDados in 'uDados.pas',
  uEmpresa in 'uEmpresa.pas' {frmEmpresa},
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDados, Dados);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
