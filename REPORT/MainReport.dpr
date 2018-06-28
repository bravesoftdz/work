program MainReport;

uses
  Forms,
  Windows,
  uMainReport in 'uMainReport.pas' {FrmMainReport},
  uDMGlobal in '..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uMsgBox in '..\RepositoryD7\uMsgBox.pas' {FrmMsgBox},
  uDMParent in '..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uDM in 'uDM.pas' {DM: TDataModule},
  rbReportExplorerForm in 'rbReportExplorerForm.pas' {rbReportExplorerForm},
  uEditHintFch in 'uEditHintFch.pas' {EditHintFch},
  ppASDlg in '..\..\Program Files\Borland\Delphi7\RBuilder\Source\ppASDlg.pas' {ppAutoSearchDialog},
  mdRBASDlg in '..\RBuilderEvolution\mdRBASDlg.pas' {mdRBASDialog},
  uPassword in 'uPassword.pas' {Password},
  uMsgConstant in '..\RepositoryD7\uMsgConstant.pas' {FrmMsgConstant},
  uRBFunction in '..\RepositoryD7\uRBFunction.pas';

{$R *.res}

var
  MutexHandle: THandle;
  hwind:HWND;
begin

  MutexHandle := CreateMutex(nil, TRUE, 'MainReport');

  if MutexHandle <> 0 then
     if (GetLastError = ERROR_ALREADY_EXISTS) then
        begin
        // MessageBox(0, 'Instance of this application is already running.',
        // 'Application already running', mb_IconHand);
        CloseHandle(MutexHandle);
        hwind := 0;
        repeat
           //The string 'My app' must match your App Title (below)
           hwind:=Windows.FindWindowEx(0,hwind,'TApplication','Main Report');
        until (hwind<>Application.Handle);

        if (hwind<>0) then
           begin
           Windows.ShowWindow(hwind,SW_SHOWNORMAL);
           Windows.SetForegroundWindow(hwind);
           end;
        Halt;
        end;

  Application.Initialize;
  Application.Title := 'Main Report';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDMParent, DMParent);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMainReport, FrmMainReport);
  Application.CreateForm(TPassword, Password);
  Application.CreateForm(TEditHintFch, EditHintFch);
  Application.CreateForm(TFrmMsgConstant, FrmMsgConstant);
  Application.Run;

end.
