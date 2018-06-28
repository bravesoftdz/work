unit Childwin;

interface

uses Windows, Classes, Graphics, Forms, Controls,Menus,
  ExtCtrls, Buttons, Dialogs, SysUtils, UCRPE32, UCrpeClasses;

type
  TMDIChild = class(TForm)
    SpeedPanel: TPanel;
    BtnShowFirst: TSpeedButton;
    BtnShowPrevious: TSpeedButton;
    BtnShowNext: TSpeedButton;
    BtnShowLast: TSpeedButton;
    BtnCloseWindow: TSpeedButton;
    BtnZoomMagnification: TSpeedButton;
    BtnPrintNow: TSpeedButton;
    BtnNumPages: TSpeedButton;
    BtnExportMail: TSpeedButton;
    BtnExportFile: TSpeedButton;
    PopupMenu1: TPopupMenu;
    FullSize1: TMenuItem;
    FitWidth1: TMenuItem;
    FullPage1: TMenuItem;
    ZoomLevels1: TMenuItem;
    Select1: TMenuItem;
    N1: TMenuItem;
    Crpe1: TCrpe;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ExportMailItemClick(Sender: TObject);
    procedure ExportFileItemClick(Sender: TObject);
    procedure PrintToPrinterClick(Sender: TObject);
    procedure BtnShowFirstClick(Sender: TObject);
    procedure BtnShowPreviousClick(Sender: TObject);
    procedure BtnShowNextClick(Sender: TObject);
    procedure BtnShowLastClick(Sender: TObject);
    procedure BtnCloseWindowClick(Sender: TObject);
    procedure BtnZoomMagnificationClick(Sender: TObject);
    procedure BtnPrintNowClick(Sender: TObject);
    procedure BtnNumPagesClick(Sender: TObject);
    procedure BtnExportMailClick(Sender: TObject);
    procedure BtnExportFileClick(Sender: TObject);
    procedure FullSize1Click(Sender: TObject);
    procedure FitWidth1Click(Sender: TObject);
    procedure FullPage1Click(Sender: TObject);
    procedure Select1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
   Main;

{$R *.DFM}

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChild.FormCreate(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   MainForm.File1.Enabled := False;
   MainForm.SpeedPanel.Enabled := False;
   try
      {Get the name of the report from Open Dialog on the Main form}
      Crpe1.ReportName := MainForm.OpenDialog.Filename;

      {Use the Window Parent Handle to make the owner of the Crystal Preview window
      the MDIChild form.  The preview window will then appear as part of the Child
      form.  This is what allows a true MDI Child behavior for a Crystal Report
      preview window}
      Crpe1.WindowParent := Self;

      {Configure the appearance of the preview window within the Child form}

      Crpe1.WindowSize.Top := SpeedPanel.Height;
      Crpe1.WindowSize.Left := 1;
      Crpe1.WindowSize.Height := Self.ClientHeight-SpeedPanel.Height;
      Crpe1.WindowSize.Width := Self.ClientWidth-1;
      Crpe1.WindowStyle.SystemMenu := False;  {Hides the close button on the preview}
      Crpe1.WindowStyle.BorderStyle := bsNone;
      Crpe1.WindowButtonBar.Visible := False;
      Crpe1.Execute;  {Run the report}

   finally
      Screen.Cursor := crDefault;
      MainForm.File1.Enabled := True;
      MainForm.SpeedPanel.Enabled := True;
   end;

end;

procedure TMDIChild.FormResize(Sender: TObject);
var
   MyWindow : hWnd;

begin
   MyWindow := Crpe1.ReportWindowHandle;
   SetWindowPos(MyWindow, HWND_TOP, 0, Self.SpeedPanel.Height, Self.ClientWidth-1,
      Self.ClientHeight-Self.SpeedPanel.Height, SWP_NOZORDER);
end;

procedure TMDIChild.ExportMailItemClick(Sender: TObject);
begin
   Crpe1.ExportWindow(True);
end;

procedure TMDIChild.ExportFileItemClick(Sender: TObject);
begin
   Crpe1.ExportWindow(False);
end;

procedure TMDIChild.PrintToPrinterClick(Sender: TObject);
begin
   Crpe1.PrintWindow;
end;

procedure TMDIChild.BtnShowFirstClick(Sender: TObject);
begin
   Crpe1.Pages.First;
end;

procedure TMDIChild.BtnShowPreviousClick(Sender: TObject);
begin
   Crpe1.Pages.Previous;
end;

procedure TMDIChild.BtnShowNextClick(Sender: TObject);
begin
   Crpe1.Pages.Next;
end;

procedure TMDIChild.BtnShowLastClick(Sender: TObject);
begin
   Crpe1.Pages.Last;
end;

procedure TMDIChild.BtnCloseWindowClick(Sender: TObject);
begin
   Crpe1.CloseWindow;
   Close;
end;

procedure TMDIChild.BtnZoomMagnificationClick(Sender: TObject);
var
   TempIn : Boolean;
   InValue: string;
begin
   InValue := '75';
   TempIn := True;
   while TempIn = True do
   begin
     If InputQuery('Input Zoom Level', 'Input a Zoom Level (25..400)', InValue) then
     begin
       If (StrToInt(InValue) >= 25) and (StrToInt(InValue) <= 400) then
       begin
          Crpe1.WindowZoom.Magnification := StrToInt(InValue);
          TempIn := False;
       end
       else
          MessageDlg('The Value Entered is Invalid', mtError, [mbOK], 0);
     end
     else
       TempIn := False;
   end;
end;

procedure TMDIChild.BtnPrintNowClick(Sender: TObject);
begin
  if Crpe1.PrintOptions.Prompt = True then
    Crpe1.PrintWindow;
end;

procedure TMDIChild.BtnNumPagesClick(Sender: TObject);
var
  Temp : Word;
begin
   Screen.Cursor := crHourGlass;
   Temp := Crpe1.Pages.Count;
   Screen.Cursor := crDefault;
   MessageDlg('There are ' + IntToStr(Temp) + ' pages in this report.', mtInformation, [mbOK], 0);
end;

procedure TMDIChild.BtnExportMailClick(Sender: TObject);
begin
   Crpe1.ExportWindow(True);
end;

procedure TMDIChild.BtnExportFileClick(Sender: TObject);
begin
   Crpe1.ExportWindow(False);
end;

procedure TMDIChild.FullSize1Click(Sender: TObject);
begin
  Crpe1.WindowZoom.Preview := pwNormal;
end;

procedure TMDIChild.FitWidth1Click(Sender: TObject);
begin
  Crpe1.WindowZoom.Preview := pwPageWidth;
end;

procedure TMDIChild.FullPage1Click(Sender: TObject);
begin
  Crpe1.WindowZoom.Preview := pwWholePage;
end;

procedure TMDIChild.Select1Click(Sender: TObject);
begin
   BtnZoomMagnificationClick(Self);
end;

end.
