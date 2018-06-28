program MRECommerceSync;

uses
  Forms,
  uXMLClasses in 'uXMLClasses.pas',
  uInvoiceClasses in 'uInvoiceClasses.pas',
  uEplataformaEntidadeClasses in 'uEplataformaEntidadeClasses.pas',
  uEplataformaSyncClasses in 'uEplataformaSyncClasses.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  ufrmMain in 'ufrmMain.pas' {FrmMain},
  uFrmConfig in 'uFrmConfig.pas' {FrmConfig},
  uFrmExport in 'uFrmExport.pas' {FrmExport},
  uFrmImport in 'uFrmImport.pas' {FrmImport},
  uFrmLog in 'uFrmLog.pas' {FrmLog};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MRE-commerce sync';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmImport, FrmImport);
  Application.CreateForm(TFrmExport, FrmExport);
  Application.CreateForm(TFrmLog, FrmLog);
  Application.Run;
end.
