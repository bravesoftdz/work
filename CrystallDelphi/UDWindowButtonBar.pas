unit UDWindowButtonBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UCrpe32;

type
  TCrpeWindowButtonBarDlg = class(TForm)
    pnlWindowButtonBar: TPanel;
    cbVisible: TCheckBox;
    cbCancelBtn: TCheckBox;
    cbCloseBtn: TCheckBox;
    cbRefreshBtn: TCheckBox;
    cbZoomCtl: TCheckBox;
    cbPrintBtn: TCheckBox;
    cbPrintSetupBtn: TCheckBox;
    cbExportBtn: TCheckBox;
    cbSearchBtn: TCheckBox;
    cbAllowDrillDown: TCheckBox;
    cbGroupTree: TCheckBox;
    cbNavigationCtls: TCheckBox;
    cbProgressCtls: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    cbDocumentTips: TCheckBox;
    cbToolbarTips: TCheckBox;
    btnActivateAll: TButton;
    cbLaunchBtn: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateWindowButtonBar;
    procedure cbVisibleClick(Sender: TObject);
    procedure cbCancelBtnClick(Sender: TObject);
    procedure cbCloseBtnClick(Sender: TObject);
    procedure cbRefreshBtnClick(Sender: TObject);
    procedure cbZoomCtlClick(Sender: TObject);
    procedure cbPrintBtnClick(Sender: TObject);
    procedure cbPrintSetupBtnClick(Sender: TObject);
    procedure cbExportBtnClick(Sender: TObject);
    procedure cbSearchBtnClick(Sender: TObject);
    procedure cbAllowDrillDownClick(Sender: TObject);
    procedure cbGroupTreeClick(Sender: TObject);
    procedure cbNavigationCtlsClick(Sender: TObject);
    procedure cbProgressCtlsClick(Sender: TObject);
    procedure cbToolbarTipsClick(Sender: TObject);
    procedure cbDocumentTipsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnActivateAllClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure cbLaunchBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr              : TCrpe;
    rVisible        : boolean;
    rCancel         : boolean;
    rClose          : boolean;
    rRefresh        : boolean;
    rZoom           : boolean;
    rPrint          : boolean;
    rPrintSetup     : boolean;
    rExport         : boolean;
    rLaunch         : boolean;
    rSearch         : boolean;
    rAllowDrillDown : boolean;
    rGroupTree      : boolean;
    rNavigation     : boolean;
    rProgress       : boolean;
    rToolbarTips    : boolean;
    rDocumentTips   : boolean;
  end;

var
  CrpeWindowButtonBarDlg: TCrpeWindowButtonBarDlg;
  bWindowButtonBar      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.FormCreate(Sender: TObject);
begin
  bWindowButtonBar := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.FormShow(Sender: TObject);
begin
  rVisible := Cr.WindowButtonBar.Visible;
  rCancel := Cr.WindowButtonBar.CancelBtn;
  rClose := Cr.WindowButtonBar.CloseBtn;
  rRefresh := Cr.WindowButtonBar.RefreshBtn;
  rZoom := Cr.WindowButtonBar.ZoomCtl;
  rPrint := Cr.WindowButtonBar.PrintBtn;
  rPrintSetup := Cr.WindowButtonBar.PrintSetupBtn;
  rExport := Cr.WindowButtonBar.ExportBtn;
  rLaunch := Cr.WindowButtonBar.LaunchBtn;
  rSearch := Cr.WindowButtonBar.SearchBtn;
  rAllowDrillDown := Cr.WindowButtonBar.AllowDrillDown;
  rGroupTree := Cr.WindowButtonBar.GroupTree;
  rNavigation := Cr.WindowButtonBar.NavigationCtls;
  rProgress := Cr.WindowButtonBar.ProgressCtls;
  rToolbarTips := Cr.WindowButtonBar.ToolbarTips;
  rDocumentTips := Cr.WindowButtonBar.DocumentTips;
  UpdateWindowButtonBar;
end;
{------------------------------------------------------------------------------}
{ UpdateWindowButtonBar                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.UpdateWindowButtonBar;
begin
  {Enable/Disable controls}
  cbCancelBtn.Checked := Cr.WindowButtonBar.CancelBtn;
  cbCloseBtn.Checked := Cr.WindowButtonBar.CloseBtn;
  cbRefreshBtn.Checked := Cr.WindowButtonBar.RefreshBtn;
  cbZoomCtl.Checked := Cr.WindowButtonBar.ZoomCtl;
  cbPrintBtn.Checked := Cr.WindowButtonBar.PrintBtn;
  cbPrintSetupBtn.Checked := Cr.WindowButtonBar.PrintSetupBtn;
  cbExportBtn.Checked := Cr.WindowButtonBar.ExportBtn;
  cbLaunchBtn.Checked := Cr.WindowButtonBar.LaunchBtn;
  cbSearchBtn.Checked := Cr.WindowButtonBar.SearchBtn;
  cbAllowDrillDown.Checked := Cr.WindowButtonBar.AllowDrillDown;
  cbGroupTree.Checked := Cr.WindowButtonBar.GroupTree;
  cbNavigationCtls.Checked := Cr.WindowButtonBar.NavigationCtls;
  cbProgressCtls.Checked := Cr.WindowButtonBar.ProgressCtls;
  cbVisible.Checked := Cr.WindowButtonBar.Visible;
  cbToolbarTips.Checked := Cr.WindowButtonBar.ToolbarTips;
  cbDocumentTips.Checked := Cr.WindowButtonBar.DocumentTips;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbVisibleClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbVisibleClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
    begin
      if TCheckBox(Components[i]).Parent = pnlWindowButtonBar then
        TCheckBox(Components[i]).Enabled := cbVisible.Checked;
    end;
  end;
  Cr.WindowButtonBar.Visible := cbVisible.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCancelBtnClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbCancelBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.CancelBtn := cbCancelBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCloseBtnClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbCloseBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.CloseBtn := cbCloseBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbRefreshBtnClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbRefreshBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.RefreshBtn := cbRefreshBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbZoomCtlClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbZoomCtlClick(Sender: TObject);
begin
  Cr.WindowButtonBar.ZoomCtl := cbZoomCtl.Checked;
end;
{------------------------------------------------------------------------------}
{ cbPrintBtnClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbPrintBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.PrintBtn := cbPrintBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbPrintSetupBtnClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbPrintSetupBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.PrintSetupBtn := cbPrintSetupBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbExportBtnClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbExportBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.ExportBtn := cbExportBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbLaunchBtnClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbLaunchBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.LaunchBtn := cbLaunchBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbSearchBtnClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbSearchBtnClick(Sender: TObject);
begin
  Cr.WindowButtonBar.SearchBtn := cbSearchBtn.Checked;
end;
{------------------------------------------------------------------------------}
{ cbAllowDrillDownClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbAllowDrillDownClick(Sender: TObject);
begin
  Cr.WindowButtonBar.AllowDrillDown := cbAllowDrillDown.Checked;
end;
{------------------------------------------------------------------------------}
{ cbGroupTreeClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbGroupTreeClick(Sender: TObject);
begin
  Cr.WindowButtonBar.GroupTree := cbGroupTree.Checked;
end;
{------------------------------------------------------------------------------}
{ cbNavigationCtlsClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbNavigationCtlsClick(Sender: TObject);
begin
  Cr.WindowButtonBar.NavigationCtls := cbNavigationCtls.Checked;
end;
{------------------------------------------------------------------------------}
{ cbProgressCtlsClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbProgressCtlsClick(Sender: TObject);
begin
  Cr.WindowButtonBar.ProgressCtls := cbProgressCtls.Checked;
end;
{------------------------------------------------------------------------------}
{ cbToolbarTipsClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbToolbarTipsClick(Sender: TObject);
begin
  Cr.WindowButtonBar.ToolbarTips := cbToolbarTips.Checked;
end;
{------------------------------------------------------------------------------}
{ cbDocumentTipsClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.cbDocumentTipsClick(Sender: TObject);
begin
  Cr.WindowButtonBar.DocumentTips := cbDocumentTips.Checked;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.btnClearClick(Sender: TObject);
begin
  Cr.WindowButtonBar.Clear;
  UpdateWindowButtonBar;
end;
{------------------------------------------------------------------------------}
{ btnActivateAllClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.btnActivateAllClick(Sender: TObject);
begin
  Cr.WindowButtonBar.ActivateAll;
  UpdateWindowButtonBar;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.WindowButtonBar.Visible := rVisible;
    Cr.WindowButtonBar.CancelBtn := rCancel;
    Cr.WindowButtonBar.CloseBtn := rClose;
    Cr.WindowButtonBar.RefreshBtn := rRefresh;
    Cr.WindowButtonBar.ZoomCtl := rZoom;
    Cr.WindowButtonBar.PrintBtn := rPrint;
    Cr.WindowButtonBar.PrintSetupBtn := rPrintSetup;
    Cr.WindowButtonBar.ExportBtn := rExport;
    Cr.WindowButtonBar.LaunchBtn := rLaunch;
    Cr.WindowButtonBar.SearchBtn := rSearch;
    Cr.WindowButtonBar.AllowDrillDown := rAllowDrillDown;
    Cr.WindowButtonBar.GroupTree := rGroupTree;
    Cr.WindowButtonBar.NavigationCtls := rNavigation;
    Cr.WindowButtonBar.ProgressCtls := rProgress;
    Cr.WindowButtonBar.ToolbarTips := rToolbarTips;
    Cr.WindowButtonBar.DocumentTips := rDocumentTips;
  end;
  bWindowButtonBar := False;
  Release;
end;


end.
