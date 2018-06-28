program Mdiapp;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Childwin in 'CHILDWIN.PAS' {MDIChild},
  About in 'ABOUT.PAS' {AboutBox},
  Exportto in 'EXPORTTO.PAS' {ExportForm},
  Printto in 'PRINTTO.PAS' {PrinterForm};

{$R *.RES}

begin
  Application.Title := 'Sample MDI Application';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
