unit Main;
                  
interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    StatusLine: TPanel;
    File1: TMenuItem;
    FileOpenItem: TMenuItem;
    Panel2: TPanel;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    Line3: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    WindowMinimizeItem: TMenuItem;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    CloseBtn: TSpeedButton;
    Line1: TMenuItem;
    FileExportReport: TMenuItem;
    Line2: TMenuItem;
    FilePrintReport: TMenuItem;
    PrintUsingDefault: TMenuItem;
    PrintSpecificPrinter: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure WindowCascadeItemClick(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure WindowTileItemClick(Sender: TObject);
    procedure WindowArrangeItemClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure WindowMinimizeItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure FileExportReportClick(Sender: TObject);
    procedure PrintUsingDefaultClick(Sender: TObject);
    procedure PrintSpecificPrinterClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
    procedure ShowHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses ChildWin, About, ExportTo, PrintTo;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  Screen.OnActiveFormChange := UpdateMenuItems;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.Caption := Application.Hint;
end;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
end;

procedure TMainForm.FileOpenItemClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Refresh;
    CreateMDIChild(OpenDialog.FileName);
  end;
end;

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    ActiveMDIChild.Close;
end;

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.WindowCascadeItemClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowTileItemClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowArrangeItemClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.WindowMinimizeItemClick(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
begin
  FileCloseItem.Enabled := MDIChildCount > 0;
  WindowCascadeItem.Enabled := MDIChildCount > 0;
  WindowTileItem.Enabled := MDIChildCount > 0;
  WindowArrangeItem.Enabled := MDIChildCount > 0;
  WindowMinimizeItem.Enabled := MDIChildCount > 0;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
end;

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
var
   About : TAboutBox;
begin
   About := TAboutBox.Create(Self);
   About.Show;
end;

procedure TMainForm.FileExportReportClick(Sender: TObject);
var
   ExportForm : TExportForm;
begin
   ExportForm := TExportForm.Create(Self);
   ExportForm.ShowModal;
end;

procedure TMainForm.PrintUsingDefaultClick(Sender: TObject);
var
   PrintForm : TPrinterForm;
begin
   PrintForm := TPrinterForm.Create(Self);
   PrintForm.Crpe1.Execute;
   while not PrintForm.Crpe1.PrintEnded do
      Application.ProcessMessages;
   PrintForm.Close;
end;

procedure TMainForm.PrintSpecificPrinterClick(Sender: TObject);
var
   PrintForm : TPrinterForm;
begin
   PrintForm := TPrinterForm.Create(Self);
   PrintForm.ShowModal;
end;

end.
