unit UDDesignControls;

interface

uses
  Windows, Forms, Controls, Buttons, Classes, ExtCtrls, UCrpe32;

type
  TCrpeDesignControlsDlg = class(TForm)
    pnlBBar: TPanel;
    pnlBBar2: TPanel;
    sbOpen: TSpeedButton;
    sbClose: TSpeedButton;
    sbDiscardSavedData: TSpeedButton;
    sbQuickPreview: TSpeedButton;
    sbPreview: TSpeedButton;
    sbPrint: TSpeedButton;
    sbExport: TSpeedButton;
    sbCloseWindow: TSpeedButton;
    sbFirst: TSpeedButton;
    sbPrevious: TSpeedButton;
    sbNext: TSpeedButton;
    sbLast: TSpeedButton;
    sbCancel: TSpeedButton;
    sbZoom: TSpeedButton;
    procedure sbOpenClick(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbDiscardSavedDataClick(Sender: TObject);
    procedure sbQuickPreviewClick(Sender: TObject);
    procedure sbPreviewClick(Sender: TObject);
    procedure sbPrintClick(Sender: TObject);
    procedure sbExportClick(Sender: TObject);
    procedure sbCloseWindowClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure sbPreviousClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbZoomClick(Sender: TObject);
    procedure SetButtonState(BtnSet: integer; OnOff: boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeDesignControlsDlg: TCrpeDesignControlsDlg;
  bDesignControls      : boolean;

implementation

uses SysUtils, Dialogs;

{$R *.DFM}

{******************************************************************************}
{ Class TCrpeDesignControlsDlg                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.FormCreate(Sender: TObject);
begin
  bDesignControls := True;
end;
{------------------------------------------------------------------------------}
{ sbOpenClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbOpenClick(Sender: TObject);
var
  dlgOpen : TOpenDialog;
  OnOff   : boolean;
begin
  {Redraw dialog}
  Refresh;
  {Create OpenFile dialog}
  dlgOpen := TOpenDialog.Create(Application);
  dlgOpen.FileName := '*.rpt';
  dlgOpen.Title := 'Choose a Crystal Report...';
  dlgOpen.Filter := 'Report Files (*.rpt) | *.rpt';
  dlgOpen.DefaultExt := 'rpt';
  dlgOpen.Options := dlgOpen.Options + [ofPathMustExist, ofFileMustExist];
  try
    if dlgOpen.Execute then
    begin
      Refresh;
      Cr.ReportName := dlgOpen.FileName;
      SetButtonState(1,True);
    end;
  finally
    dlgOpen.Free;
  end; { Protected Res Block }
  {Check ReportName}
  OnOff := Trim(Cr.ReportName) <> '';
  SetButtonState(1,OnOff);
end;
{------------------------------------------------------------------------------}
{ sbCloseClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbCloseClick(Sender: TObject);
begin
  Cr.CloseWindow;
  Cr.CloseJob;
  {Cr.ReportName := '';}
  SetButtonState(0,False);
end;
{------------------------------------------------------------------------------}
{ sbRetrieveClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbDiscardSavedDataClick(Sender: TObject);
begin
  Cr.DiscardSavedData;
end;
{------------------------------------------------------------------------------}
{ sbQuickPreviewClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbQuickPreviewClick(Sender: TObject);
var
  OnOff : boolean;
begin
  {Redraw dialog}
  Refresh;
  {Check ReportName}
  OnOff := Trim(Cr.ReportName) <> '';
  SetButtonState(1, OnOff);
  {Execute}
  if OnOff then
  begin
    {If a Window is open already, Refresh}
    if (Cr.ReportWindowHandle > 0) then
    begin
      Screen.Cursor := crHourglass;
      try
        Cr.Refresh;
      except
        Screen.Cursor := crDefault;
        raise;
      end;
      Screen.Cursor := crDefault;
    end
    {If a Window is not open, Preview}
    else
    begin
      Screen.Cursor := crHourglass;
      try
        Cr.Execute;
      except
        Screen.Cursor := crDefault;
        raise;
      end;
      Screen.Cursor := crDefault;
    end;
  end;
  {Check for Window}
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2, OnOff);
  {Check for PrintEnded}
  SetButtonState(3,(not Cr.PrintEnded));
end;
{------------------------------------------------------------------------------}
{ sbPreviewClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbPreviewClick(Sender: TObject);
var
  oTmp  : TCrOutput;
  OnOff : boolean;
begin
  {Store current values}
  oTmp := Cr.Output;
  {Set new values}
  Cr.Output := toWindow;
  {Redraw dialog}
  Refresh;
  {Check ReportName}
  OnOff := Trim(Cr.ReportName) <> '';
  SetButtonState(1, OnOff);
  {Execute}
  if OnOff then
  begin
    {If a Child Window is open already, close it}
    if (Cr.WindowParent <> nil) and (Cr.ReportWindowHandle > 0) then
      Cr.CloseWindow;
    Screen.Cursor := crHourglass;
    try
      Cr.Execute;
    except
      Screen.Cursor := crDefault;
      raise;
    end;
    Screen.Cursor := crDefault;
  end;
  {Reset values}
  Cr.Output := oTmp;
  {Check for Window}
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2, OnOff);
  {Check for PrintEnded}
  SetButtonState(3,(not Cr.PrintEnded));
end;
{------------------------------------------------------------------------------}
{ sbPrintClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbPrintClick(Sender: TObject);
var
  oTmp  : TCrOutput;
  OnOff : boolean;
begin
  {Store current values}
  oTmp := Cr.Output;
  {Set new values}
  Cr.Output := toPrinter;
  {Redraw dialog}
  Refresh;
  {Check ReportName}
  OnOff := Trim(Cr.ReportName) <> '';
  SetButtonState(1, OnOff);
  {Execute}
  if OnOff then
  begin
    Screen.Cursor := crHourglass;
    try
      Cr.Execute;
    except
      Screen.Cursor := crDefault;
      raise;
    end;
    Screen.Cursor := crDefault;
  end;
  {Reset values}
  Cr.Output := oTmp;
  {Check for Window}
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2, OnOff);
  {Check for PrintEnded}
  SetButtonState(3,(not Cr.PrintEnded));
end;
{------------------------------------------------------------------------------}
{ sbExportClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbExportClick(Sender: TObject);
var
  oTmp  : TCrOutput;
  bTmp  : boolean;
  OnOff : boolean;
begin
  {Store current values}
  oTmp := Cr.Output;
  bTmp := Cr.ExportOptions.PromptForOptions;
  {Set values}
  Cr.ExportOptions.PromptForOptions := True;
  Cr.Output := toExport;
  {Redraw dialog}
  Refresh;
  {Check ReportName}
  OnOff := Trim(Cr.ReportName) <> '';
  SetButtonState(1,OnOff);
  {Execute}
  if OnOff then
  begin
    Screen.Cursor := crHourglass;
    try
      Cr.Execute;
    except
      Screen.Cursor := crDefault;
      raise;
    end;
    Screen.Cursor := crDefault;
  end;
  {Reset values}
  Cr.Output := oTmp;
  Cr.ExportOptions.PromptForOptions := bTmp;
  {Check for Window}
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2,OnOff);
  {Check for PrintEnded}
  SetButtonState(3,(not Cr.PrintEnded));
end;
{------------------------------------------------------------------------------}
{ sbCloseWindowClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbCloseWindowClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
    Cr.CloseWindow;
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2,OnOff);
  SetButtonState(3,(not Cr.PrintEnded));
end;
{------------------------------------------------------------------------------}
{ sbStartPageClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbFirstClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
  begin
    Cr.Pages.First;
    SetButtonState(3,(not Cr.PrintEnded));
  end;
  SetButtonState(2,OnOff);
end;
{------------------------------------------------------------------------------}
{ sbPreviousPageClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbPreviousClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
  begin
    Cr.Pages.Previous;
    SetButtonState(3,(not Cr.PrintEnded));
  end;
  SetButtonState(2,OnOff);
end;
{------------------------------------------------------------------------------}
{ sbNextPageClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbNextClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
  begin
    Cr.Pages.Next;
    SetButtonState(3,(not Cr.PrintEnded));
  end;
  SetButtonState(2,OnOff);
end;
{------------------------------------------------------------------------------}
{ sbLastPageClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbLastClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
  begin
    Cr.Pages.Last;
    SetButtonState(3,(not Cr.PrintEnded));
  end;
  SetButtonState(2,OnOff);
end;
{------------------------------------------------------------------------------}
{ sbCancelClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbCancelClick(Sender: TObject);
var
  OnOff : boolean;
begin
  if Cr.PrintEnded = False then
    Cr.CancelJob;
  SetButtonState(3, False);
  OnOff := (Cr.ReportWindowHandle > 0);
  SetButtonState(2, OnOff);
end;
{------------------------------------------------------------------------------}
{ sbZoomClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.sbZoomClick(Sender: TObject);
var
  OnOff : boolean;
begin
  OnOff := (Cr.ReportWindowHandle > 0);
  if OnOff then
    Cr.WindowZoom.NextLevel;
  SetButtonState(2, OnOff);
end;
{------------------------------------------------------------------------------}
{ SetButtonState                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.SetButtonState(BtnSet: integer; OnOff: boolean);
var
  cnt : integer;
begin
  case BtnSet of
    {All buttons}
    0: begin
         for cnt := 0 to (ComponentCount - 1) do
         begin
           if (Components[cnt] is TSpeedButton) and
              (TSpeedButton(Components[cnt]).Name <> 'sbOpen') then
           begin
             if TSpeedButton(Components[cnt]).Enabled <> OnOff then
               TSpeedButton(Components[cnt]).Enabled := OnOff;
           end;
         end;
       end;
    {Top row only}
    1: begin
         for cnt := 0 to (ComponentCount - 1) do
         begin
           if (Components[cnt] is TSpeedButton) and
              (TSpeedButton(Components[cnt]).Parent = pnlBBar) and
              (TSpeedButton(Components[cnt]).Name <> 'sbOpen') then
           begin
             if TSpeedButton(Components[cnt]).Enabled <> OnOff then
               TSpeedButton(Components[cnt]).Enabled := OnOff;
           end;
         end;
       end;
    {Bottom row only: window/paging (not Cance)}
    2: begin
         for cnt := 0 to (ComponentCount - 1) do
         begin
           if (Components[cnt] is TSpeedButton) and
              (TSpeedButton(Components[cnt]).Parent = pnlBBar2) and
              (TSpeedButton(Components[cnt]).Name <> 'sbCancel') then
           begin
             if TSpeedButton(Components[cnt]).Enabled <> OnOff then
               TSpeedButton(Components[cnt]).Enabled := OnOff;
           end;
         end;
       end;
    {Cancel button}
    3: if sbCancel.Enabled <> OnOff then
         sbCancel.Enabled := OnOff;
  end;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bDesignControls := False;
  Release;
end;


end.
