unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

const
   REGISTRY_PATH_POS = 'SOFTWARE\Applenet\POS';
   POS_DIR      = 'POSSales\';
   SERVER_DIR   = 'PDVFiles\';
   MIRROR_DIR   = 'PDVFiles\';

type
  TFrmMain = class(TForm)
    pgMain: TPageControl;
    tsCashRegister: TTabSheet;
    Label1: TLabel;
    cmxPersistenceType: TComboBox;
    edtMD5: TLabeledEdit;
    udSalesFilesToExp: TUpDown;
    Label2: TLabel;
    edtSalesFilesToExp: TEdit;
    OP: TOpenDialog;
    edtMaxAmountAskPrice: TLabeledEdit;
    pnlTXT: TPanel;
    edtLocalWorkingDir: TLabeledEdit;
    edtRemoteWorkingDir: TLabeledEdit;
    edtServerFilesDir: TLabeledEdit;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmxPersistenceTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Registry;

{$R *.dfm}

procedure TFrmMain.FormShow(Sender: TObject);
begin


  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH_POS, True);

    if not ValueExists('PersistenceType') then
      WriteInteger('PersistenceType', 0);
    if not ValueExists('SalesFilesToExp') then
      WriteInteger('SalesFilesToExp', 3);
    if not ValueExists('LocalWorkingDir') then
      WriteString('LocalWorkingDir', ExtractFilePath(Application.ExeName) + POS_DIR);
    if not ValueExists('RemoteWorkingDir') then
      WriteString('RemoteWorkingDir', '');
    if not ValueExists('ServerFilesDir') then
      WriteString('ServerFilesDir', ExtractFilePath(Application.Exename) + SERVER_DIR);
    if not ValueExists('SrvRefreshInSecond') then
      WriteInteger('SrvRefreshInSecond', 60);

    if not ValueExists('TEFDedCodLoja') then
      WriteString('TEFDedCodLoja', '');
    if not ValueExists('TEFDedIPServer') then
      WriteString('TEFDedIPServer', '');
    if not ValueExists('TEFDedNumTerminal') then
      WriteString('TEFDedNumTerminal', '');
    if not ValueExists('TEFDedMsgOp') then
      WriteString('TEFDedMsgOp', 'MainRetail3');

    if not ValueExists('ECFPrinterName') then
      WriteString('ECFPrinterName', 'None');
    if not ValueExists('ECFRodape') then
      WriteString('ECFRodape', 'Volte Sempre!');
    if not ValueExists('UseTEF') then
      WriteInteger('UseTEF', 0);
    if not ValueExists('SalesFileName') then
      WriteString('SalesFileName', '');
    if not ValueExists('LastSalesFiles') then
      WriteString('LastSalesFiles', '');
    if not ValueExists('SaleCodeTXT') then
      WriteInteger('SaleCodeTXT', 1);
    if not ValueExists('AskSalesPerson') then
      WriteBool('AskSalesPerson', False);
    if not ValueExists('KeepSalesPerson') then
      WriteBool('KeepSalesPerson', False);
    if not ValueExists('PDVImage') then
      WriteString('PDVImage', ExtractFilePath(Application.ExeName)+'MRPDV.bmp');
    if not ValueExists('ShowShortCuts') then
      WriteBool('ShowShortCuts', False);
    if not ValueExists('MainRetailPath') then
      WriteString('MainRetailPath', '');
    if not ValueExists('RefreshGlobalTXT') then
      WriteInteger('RefreshGlobalTXT', 60);
    if not ValueExists('FiscalPrinter') then
      WriteBool('FiscalPrinter', false);
    if not ValueExists('SellWithCashDrawClosed') then
      WriteBool('SellWithCashDrawClosed', False);
    if not ValueExists('MsgCashAfterClose') then
      WriteString('MsgCashAfterClose', '');
    if not ValueExists('AskCPF') then
      WriteBool('AskCPF', False);
    if not ValueExists('BlockNegativeSale') then
      WriteBool('BlockNegativeSale', False);
    if not ValueExists('ValidateCPF') then
      WriteBool('ValidateCPF', False);
    if not ValueExists('HideOtherStoreQry') then
      WriteBool('HideOtherStoreQry', False);
    if not ValueExists('LeituraDataMFD') then
      WriteDate('LeituraDataMFD', Trunc(Now));
    if not ValueExists('MD5') then
      WriteString('MD5', '');
    if not ValueExists('MaxAmountAskPrice') then
      WriteCurrency('MaxAmountAskPrice', 100000);

    cmxPersistenceType.ItemIndex := ReadInteger('PersistenceType');
    udSalesFilesToExp.Position   := ReadInteger('SalesFilesToExp');

    edtLocalWorkingDir.Text   := ReadString('LocalWorkingDir');
    edtRemoteWorkingDir.Text  := ReadString('RemoteWorkingDir');
    edtServerFilesDir.Text    := ReadString('ServerFilesDir');
    edtMD5.Text               := ReadString('MD5');
    edtMaxAmountAskPrice.Text := FormatFloat('0.00', ReadCurrency('MaxAmountAskPrice'));

    if edtMD5.Text = '' then
      edtMD5.Text := '018ea99988230c796e0409cc85369f64';

    pnlTXT.Visible := (cmxPersistenceType.ItemIndex = 1);

{

    fModuloFiscal.PDVImage          := ReadString('PDVImage');
    fModuloFiscal.LeituraDataMFD    := ReadDate('LeituraDataMFD');
    fCashRegister.AskSalesPerson    := ReadBool('AskSalesPerson');
    fCashRegister.KeepSalesPerson   := ReadBool('KeepSalesPerson');
    fPrintReceipt.ECFPrinterName    := ReadString('ECFPrinterName');
    fPrintReceipt.ECFRodape         := ReadString('ECFRodape');
    fCashRegister.LastSalesFiles    := ReadString('LastSalesFiles');
    fCashRegister.SalesFileName     := ReadString('SalesFileName');
    fCashRegister.fUseTef           := ReadInteger('UseTEF');
    fCashRegister.fShowShortCut     := ReadBool('ShowShortCuts');
    fCashRegister.MainRetail        := ReadString('MainRetailPath');
    fCashRegister.RefreshGlobal     := ReadInteger('RefreshGlobalTXT');
    fCashRegister.DisplayType       := ReadInteger('PDVDisplayType');
    fCashRegister.FiscalPrinter     := ReadBool('FiscalPrinter');
    fCashRegister.FMsgAfterCloseReg := ReadString('MsgCashAfterClose');
    fCashRegister.AskCPF            := ReadBool('AskCPF');
    fCashRegister.ValidateCPF       := ReadBool('ValidateCPF');
    fCashRegister.BlockNegativeSale := ReadBool('BlockNegativeSale');
    fCashRegister.HideOtherStoreQry := ReadBool('HideOtherStoreQry');
    fCashRegister.TEFDedCodLoja     := ReadString('TEFDedCodLoja');
    fCashRegister.TEFDedIPServer    := ReadString('TEFDedIPServer');
    fCashRegister.TEFDedNumTerminal := ReadString('TEFDedNumTerminal');
    fCashRegister.TEFDedMsgOp       := ReadString('TEFDedMsgOp');
    fCashRegister.SellDrawerClosed  := ReadBool('SellWithCashDrawClosed');

}

  Finally
    Free;
  end;


end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  OP.InitialDir := edtLocalWorkingDir.Text;
  if OP.Execute then
    edtLocalWorkingDir.Text := ExtractFileDir(OP.FileName) + '\';
end;

procedure TFrmMain.SpeedButton2Click(Sender: TObject);
begin
  OP.InitialDir := edtRemoteWorkingDir.Text;
  if OP.Execute then
    edtRemoteWorkingDir.Text := ExtractFileDir(OP.FileName) + '\';
end;

procedure TFrmMain.SpeedButton3Click(Sender: TObject);
begin
  OP.InitialDir := edtServerFilesDir.Text;
  if OP.Execute then
    edtServerFilesDir.Text := ExtractFileDir(OP.FileName) + '\';
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH_POS, True);

    WriteCurrency('MaxAmountAskPrice', StrToCurrDef(edtMaxAmountAskPrice.Text, 7000));

    WriteInteger('PersistenceType', cmxPersistenceType.ItemIndex);
    WriteInteger('SalesFilesToExp', udSalesFilesToExp.Position);

    WriteString('MD5', edtMD5.Text);
    WriteString('LocalWorkingDir', edtLocalWorkingDir.Text);
    WriteString('RemoteWorkingDir', edtRemoteWorkingDir.Text);
    WriteString('ServerFilesDir', edtServerFilesDir.Text);

  Finally
    Free;
  end;

end;

procedure TFrmMain.cmxPersistenceTypeChange(Sender: TObject);
begin
  pnlTXT.Visible := (cmxPersistenceType.ItemIndex = 1);
end;

end.
