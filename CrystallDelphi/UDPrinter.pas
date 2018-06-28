unit UDPrinter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpePrinterDlg = class(TForm)
    pnlPrinter1: TPanel;
    lblPrinterNames: TLabel;
    lblPrinterDriver: TLabel;
    lblPrinterName: TLabel;
    lblPrinterPort: TLabel;
    lblPMode: TLabel;
    lblMode: TLabel;
    lbPrinterNames: TListBox;
    editPrinterName: TEdit;
    editPrinterDriver: TEdit;
    editPrinterPort: TEdit;
    editPrinterPMode: TEdit;
    btnPrompt: TButton;
    editPrinterMode: TEdit;
    rgOrientation: TRadioGroup;
    gbPreserveRpt: TGroupBox;
    cbOrientation: TCheckBox;
    cbPaperSize: TCheckBox;
    cbPaperSource: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnPrint: TButton;
    btnClear: TButton;
    btnRetrieve: TButton;
    btnSend: TButton;
    btnPrintOptions: TButton;
    btnFreeDevMode: TButton;
    cbProgressDialog: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbPrinterNamesClick(Sender: TObject);
    procedure editPrinterNameChange(Sender: TObject);
    procedure editPrinterDriverChange(Sender: TObject);
    procedure editPrinterPortChange(Sender: TObject);
    procedure btnPromptClick(Sender: TObject);
    procedure rgOrientationClick(Sender: TObject);
    procedure cbOrientationClick(Sender: TObject);
    procedure cbPaperSizeClick(Sender: TObject);
    procedure cbPaperSourceClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnRetrieveClick(Sender: TObject);
    procedure UpdatePrinter;
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnPrintOptionsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure btnFreeDevModeClick(Sender: TObject);
    procedure cbProgressDialogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr             : TCrpe;
    rName          : string;
    rDriver        : string;
    rPort          : string;
    rIsNil         : boolean;
    rDevMode       : TDevMode;
    rOrientation   : smallint;
    rPrOrientation : boolean;
    rPrPaperSize   : boolean;
    rPrPaperSource : boolean;
  end;

var
  CrpePrinterDlg: TCrpePrinterDlg;
  bPrinter      : boolean;

implementation

{$R *.DFM}

uses Printers, UCrpeUtl, UDPrintOptions;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.FormCreate(Sender: TObject);
begin
  bPrinter := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
  rName := '';
  rDriver := '';
  rPort := '';
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.FormShow(Sender: TObject);
begin
  {Store Original Settings}
  rName := Cr.Printer.Name;
  rDriver := Cr.Printer.Driver;
  rPort := Cr.Printer.Port;
  {DevMode}
  rIsNil := False;
  if Cr.Printer.PMode <> nil then
    CopyDevMode(Cr.Printer.PMode^, rDevMode)
  else
    rIsNil := True;
  rOrientation := Ord(Cr.Printer.Orientation);
  rPrOrientation := prOrientation in Cr.Printer.PreserveRptSettings;
  rPrPaperSize := prPaperSize in Cr.Printer.PreserveRptSettings;
  rPrPaperSource := prPaperSource in Cr.Printer.PreserveRptSettings;
  cbProgressDialog.Checked := Cr.ProgressDialog;
  UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ UpdatePrinter procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.UpdatePrinter;
var
  i     : integer;
  OnOff : Boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    {SetUp Printer list}
    Cr.Printer.GetPrinterNames(lbPrinterNames.Items);
    i := lbPrinterNames.Items.IndexOf(Cr.Printer.Name);
    if i > -1 then
      lbPrinterNames.ItemIndex := i;

    {Printer Name}
    editPrinterName.Text := Cr.Printer.Name;
    {Printer Driver}
    editPrinterDriver.Text := Cr.Printer.Driver;
    {Printer Port}
    editPrinterPort.Text := Cr.Printer.Port;
    {Printer PMode}
    editPrinterPMode.Text := IntToStr(Integer(Cr.Printer.PMode));
    {Printer Mode}
    editPrinterMode.Text := IntToStr(Cr.Printer.Mode);

    {Orientation}
    rgOrientation.ItemIndex := Integer(Ord(Cr.Printer.Orientation));
    {PreserveRptSettings}
    cbOrientation.Checked := (prOrientation in Cr.Printer.PreserveRptSettings);
    cbPaperSize.Checked := (prPaperSize in Cr.Printer.PreserveRptSettings);
    cbPaperSource.Checked := (prPaperSource in Cr.Printer.PreserveRptSettings);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbProgressDialogClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.cbProgressDialogClick(Sender: TObject);
begin
  Cr.ProgressDialog := cbProgressDialog.Checked;
end;
{------------------------------------------------------------------------------}
{ btnShowPrintDlgClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnPromptClick(Sender: TObject);
begin
  if Cr.Printer.Prompt then
    UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ btnPrintOptionsClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnPrintOptionsClick(Sender: TObject);
begin
  if not bPrintOptions then
  begin
    CrpePrintOptionsDlg := TCrpePrintOptionsDlg.Create(Application);
    CrpePrintOptionsDlg.Cr := Cr;
  end;
  CrpePrintOptionsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ lbPrinterNamesClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.lbPrinterNamesClick(Sender: TObject);
begin
  Printer.PrinterIndex := lbPrinterNames.ItemIndex;
  Cr.Printer.GetCurrent(False);
  UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ editPrinterNameChange procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.editPrinterNameChange(Sender: TObject);
begin
  Cr.Printer.Name := editPrinterName.Text;
end;
{------------------------------------------------------------------------------}
{ editPrinterDriverChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.editPrinterDriverChange(Sender: TObject);
begin
  Cr.Printer.Driver := editPrinterDriver.Text;
end;
{------------------------------------------------------------------------------}
{ editPrinterPortChange procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.editPrinterPortChange(Sender: TObject);
begin
  Cr.Printer.Port := editPrinterPort.Text;
end;
{------------------------------------------------------------------------------}
{ rgOrientationClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.rgOrientationClick(Sender: TObject);
begin
  Cr.Printer.Orientation := TCrOrientation(rgOrientation.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbOrientationClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.cbOrientationClick(Sender: TObject);
begin
  if cbOrientation.Checked then
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings + [prOrientation]
  else
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings - [prOrientation];
end;
{------------------------------------------------------------------------------}
{ cbPaperSizeClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.cbPaperSizeClick(Sender: TObject);
begin
  if cbPaperSize.Checked then
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings + [prPaperSize]
  else
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings - [prPaperSize];
end;
{------------------------------------------------------------------------------}
{ cbPaperSourceClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.cbPaperSourceClick(Sender: TObject);
begin
  if cbPaperSource.Checked then
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings + [prPaperSource]
  else
    Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings - [prPaperSource];
end;
{------------------------------------------------------------------------------}
{ btnRetrieveClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnRetrieveClick(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    Cr.Printer.Retrieve;
  finally
    Screen.Cursor := crDefault;
  end;
  UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ btnSendClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnSendClick(Sender: TObject);
begin
  Cr.Printer.Send;
end;
{------------------------------------------------------------------------------}
{ btnPrintClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnPrintClick(Sender: TObject);
var
  prevOut : TCrOutput;
begin
  {Preserve previous Output setting}
  prevOut := Cr.Output;
  try
    Screen.Cursor := crHourglass;
    Cr.Output := toPrinter;
    Cr.Execute;
  finally
    Screen.Cursor := crDefault;
    Cr.Output := prevOut;
  end;
end;
{------------------------------------------------------------------------------}
{ btnFreeDevModeClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnFreeDevModeClick(Sender: TObject);
begin
  Cr.Printer.FreeDevmode;
  UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnClearClick(Sender: TObject);
begin
  Cr.Printer.Clear;
  UpdatePrinter;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePrinterDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Original Settings}
    Cr.Printer.Name := rName;
    Cr.Printer.Driver := rDriver;
    Cr.Printer.Port := rPort;
    if not rIsNil then
      CopyDevMode(rDevMode, Cr.Printer.PMode^)
    else
      Cr.Printer.PMode := nil;
    Cr.Printer.Orientation := TCrOrientation(rOrientation);
    Cr.Printer.PreserveRptSettings := [];
    if rPrOrientation then
      Cr.Printer.PreserveRptSettings := [prOrientation];
    if rPrPaperSize then
      Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings + [prOrientation];
    if rPrPaperSource then
      Cr.Printer.PreserveRptSettings := Cr.Printer.PreserveRptSettings + [prPaperSource];
  end;
  bPrinter := False;
  Release;
end;




end.



