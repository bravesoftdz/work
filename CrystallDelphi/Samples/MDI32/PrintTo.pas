unit Printto;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Printers, UCRPE32, UCrpeClasses;

type
  TPrinterForm = class(TForm)
    BtnUseCrystal: TButton;
    BtnUseWindows: TButton;
    Crpe1: TCrpe;
    OpenDialog: TOpenDialog;
    PrintDialog: TPrintDialog;
    procedure FormCreate(Sender: TObject);
    procedure BtnUseCrystalClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnUseWindowsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrinterForm: TPrinterForm;

implementation

{$R *.DFM}
uses main;

procedure TPrinterForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  MainForm.File1.Enabled := False;
  MainForm.SpeedPanel.Enabled := False;
  if OpenDialog.Execute then
  begin
    Refresh;
    {Get the name of the report from Open Dialog on the Main form}
    Crpe1.ReportName := OpenDialog.Filename;
    Crpe1.Output := toPrinter;
  end;
  Screen.Cursor := crDefault;
  MainForm.File1.Enabled := True;
  MainForm.SpeedPanel.Enabled := True;
end;

procedure TPrinterForm.BtnUseCrystalClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  MainForm.File1.Enabled := False;
  MainForm.SpeedPanel.Enabled := False;
  Crpe1.Printer.PreserveRptSettings := [prOrientation];
  if not Crpe1.Printer.Prompt then
    Exit;
  Crpe1.Execute;
  while not Crpe1.PrintEnded do
    Application.ProcessMessages;
  Screen.Cursor := crDefault;
  MainForm.File1.Enabled := True;
  MainForm.SpeedPanel.Enabled := True;
  Close;
end;

procedure TPrinterForm.BtnUseWindowsClick(Sender: TObject);
var
  lpPrinter, lpDriver, lpPort : PChar;
  pdevmode :  THandle;
begin
  if PrintDialog.Execute then
  begin
    Refresh;
    Screen.Cursor := crHourGlass;
    MainForm.File1.Enabled := False;
    MainForm.SpeedPanel.Enabled := False;
    lpPrinter := StrAlloc(255);
    try
      lpDriver := StrAlloc(255);
      try
        lpPort := StrAlloc(255);
        try
          Printer.GetPrinter(lpPrinter, lpDriver, lpPort, pdevmode);
          Crpe1.Printer.Name := StrPas(lpPrinter);
          Crpe1.Printer.Driver := StrPas(lpDriver);
          Crpe1.Printer.Port := StrPas(lpPort);
          Crpe1.Printer.Mode := pdevmode;
          Crpe1.Execute;
          while not Crpe1.PrintEnded do
            Application.ProcessMessages;
        finally
          StrDispose(lpPort);
        end; { Protected Block }
      finally
        StrDispose(lpDriver);
      end; { Protected Block }
    finally
      StrDispose(lpPrinter);
    end; { Protected Block }
    Screen.Cursor := crDefault;
    MainForm.File1.Enabled := True;
    MainForm.SpeedPanel.Enabled := True;
    Close;
  end;
end;

procedure TPrinterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;

end.
