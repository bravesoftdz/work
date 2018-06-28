unit uFchParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, Mask, DBCtrls, registry, Buttons, SuperComboADO,
  ComCtrls, ExtDlgs, dximctrl, uParentAll, siComp, siLangRT;

Const
  PARAM_OPEN_ALL       = -1;
  PARAM_OPEN_CASHREG   = 0;
  PARAM_OPEN_IDIOM     = 1;
  PARAM_OPEN_INVOICE   = 2;
  PARAM_OPEN_PRINTER   = 3;
  PARAM_OPEN_MENU      = 4;
  PARAM_OPEN_GRID      = 5;
  PARAM_OPEN_PDV_COLOR = 6;
  PARAM_OPEN_POLE_DISP = 7;

type

  TFchParameter = class(TFrmParentAll)
    pgParam: TPageControl;
    tsCashInfo: TTabSheet;
    tdIdiom: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditOpenCode: TEdit;
    cbOpenCashReg: TCheckBox;
    Label4: TLabel;
    cbxLanguage: TdxImageComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtDecimal: TEdit;
    edtThousand: TEdit;
    lbEx1: TLabel;
    lbEx2: TLabel;
    Label7: TLabel;
    cbxDateFormat: TComboBox;
    tsInvoice: TTabSheet;
    Label8: TLabel;
    cbxXpressType: TComboBox;
    pnlSuperMarketImg: TPanel;
    Label9: TLabel;
    edtXSaleImg: TEdit;
    SpeedButton1: TSpeedButton;
    OP: TOpenDialog;
    tsPrinterSetup: TTabSheet;
    tsMenuColor: TTabSheet;
    CD: TColorDialog;
    pnlMenuHighlight: TPanel;
    Label13: TLabel;
    pnlMenuTextHighlight: TPanel;
    Label14: TLabel;
    pnlMenuBackGround: TPanel;
    Label16: TLabel;
    pnlBackGroundColor: TPanel;
    Label17: TLabel;
    pnlSubMenuFontColor: TPanel;
    Label18: TLabel;
    pnlSMHighlightFontColor: TPanel;
    Label19: TLabel;
    Bevel1: TBevel;
    Label20: TLabel;
    Bevel2: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    edtBackGround: TEdit;
    sbBackGround: TSpeedButton;
    cbxColor: TComboBox;
    btnApplay: TButton;
    Label25: TLabel;
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    btCancel: TButton;
    btClose: TButton;
    tsFiscal: TTabSheet;
    pgPrinterOption: TPageControl;
    tsRegularPrinter: TTabSheet;
    tsPDVPrinter: TTabSheet;
    pnlFontSetup: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    lbFontExample: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtFontSize: TEdit;
    udFont: TUpDown;
    edtLinespace: TEdit;
    udSpaceLine: TUpDown;
    edtLineWidth: TEdit;
    upLineWidth: TUpDown;
    cbxFontName: TComboBox;
    cbPrintReceipt: TCheckBox;
    Label10: TLabel;
    cbxPrinterPort: TComboBox;
    cbxPrinterFiscalName: TComboBox;
    chkHasCheck: TCheckBox;
    lbImpFiscal: TLabel;
    Label29: TLabel;
    memOBSInv: TMemo;
    Button1: TButton;
    Button2: TButton;
    tsTEF: TTabSheet;
    lbTEFType: TLabel;
    cmbTEFType: TComboBox;
    lbLogOnSale: TLabel;
    SpeedButton3: TSpeedButton;
    edtImagePDV: TEdit;
    cmbCashReg: TDBLookupComboBox;
    cmbStore: TDBLookupComboBox;
    cmbMedia: TDBLookupComboBox;
    tsSetup: TTabSheet;
    chkShowShortCuts: TCheckBox;
    chkAskUser: TCheckBox;
    edtMainRetailpath: TEdit;
    lbMainRetail: TLabel;
    btnOpenMainRetail: TSpeedButton;
    lbDisplayType: TLabel;
    cbxDisplayType: TComboBox;
    tsPOSColor: TTabSheet;
    pnlPDVBackGround: TPanel;
    lbPOSBackground: TLabel;
    pnlPDVReturnBackGround: TPanel;
    lbPOSReturn: TLabel;
    pnlPOSValues: TPanel;
    lbPOSValues: TLabel;
    pnlPOSText: TPanel;
    lbPOSText: TLabel;
    btnPOSDefaultColors: TButton;
    pnlBarcodeText: TPanel;
    lbBarcodeText: TLabel;
    chkGeneratePAFSintegra: TCheckBox;
    lbCutCode: TLabel;
    edtAfterPrintCode: TEdit;
    btnTestCut: TSpeedButton;
    pnlTEFDed: TPanel;
    edtTEFCodLoja: TLabeledEdit;
    edtTEFIPServer: TLabeledEdit;
    edtTEFNumTerminal: TLabeledEdit;
    edtTEFMsg: TLabeledEdit;
    tsPollDisplay: TTabSheet;
    Label38: TLabel;
    Label39: TLabel;
    edtPollDisplayIP: TEdit;
    edtPollDisplayPort: TEdit;
    chkClearSale: TCheckBox;
    cbxSellDrawerClose: TCheckBox;
    spHelp: TSpeedButton;
    tsScaleSetup: TTabSheet;
    lblScaleModel: TLabel;
    lblScaleCommunication: TLabel;
    cbxScaleModel: TComboBox;
    cbxScaleCommunication: TComboBox;
    pnlSerial: TPanel;
    cbxSerialPort: TComboBox;
    lblSerialPort: TLabel;
    lblBaudRate: TLabel;
    cbxBaudRate: TComboBox;
    pnlEthernet: TPanel;
    edtIPEthernet: TEdit;
    lblIP: TLabel;
    lblPort: TLabel;
    edtPortEthernet: TEdit;
    chkPOSScale: TCheckBox;
    pnlPOSScaleInfot: TPanel;
    btnConfigScale: TBitBtn;
    edtScaleDecimal: TEdit;
    lblDecimalPlace: TLabel;
    udScaleDecimal: TUpDown;
    cbxPOSScaleType: TComboBox;
    lbMsgCaixa: TLabel;
    edtMsgCashClose: TEdit;
    chkCPF: TCheckBox;
    chkKeepSP: TCheckBox;
    taObs: TTabSheet;
    pnlFooter: TPanel;
    lbFooterInfo: TLabel;
    memCupom: TMemo;
    btnFooterCliente: TButton;
    btnFooterCPF: TButton;
    btnFooterMedia: TButton;
    btnFooterVendedor: TButton;
    btnFooterOBS: TButton;
    btnFooterEndereco: TButton;
    Button3: TButton;
    chkBlockNegativeSale: TCheckBox;
    chkValidateCPF: TCheckBox;
    chkHideStoreQty: TCheckBox;
    chkBarcodeScale: TCheckBox;
    cbxBarcodeScaleType: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure cbxDateFormatChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbxXpressTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxFontNameChange(Sender: TObject);
    procedure cbxPrinterPortChange(Sender: TObject);
    procedure pnlMenuHighlightClick(Sender: TObject);
    procedure cbxColorChange(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnOpenMainRetailClick(Sender: TObject);
    procedure btnPOSDefaultColorsClick(Sender: TObject);
    procedure btnFooterClienteClick(Sender: TObject);
    procedure btnFooterCPFClick(Sender: TObject);
    procedure cbxPrinterFiscalNameChange(Sender: TObject);
    procedure btnFooterMediaClick(Sender: TObject);
    procedure btnFooterVendedorClick(Sender: TObject);
    procedure btnFooterOBSClick(Sender: TObject);
    procedure btnFooterEnderecoClick(Sender: TObject);
    procedure btnTestCutClick(Sender: TObject);
    procedure cmbTEFTypeChange(Sender: TObject);
    procedure cbOpenCashRegExit(Sender: TObject);
    procedure cbxScaleCommunicationChange(Sender: TObject);
    procedure chkPOSScaleClick(Sender: TObject);
    procedure edtIPEthernetKeyPress(Sender: TObject; var Key: Char);
    procedure edtPortEthernetKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfigScaleClick(Sender: TObject);
    procedure cbxPOSScaleTypeChange(Sender: TObject);
    procedure cbxPOSScaleTypeKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure chkBarcodeScaleClick(Sender: TObject);
  private
    fMode : Integer;
    procedure RefreshCupomFooter;
    procedure RefreshExamples;
    procedure CalIndexConfig(Tab: Integer);
    procedure InsertHeader(text: String);
  public
    procedure Start(Mode:Integer);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst, Variants,
  VarConv, EFiscal, uFrmTaxPaymentConfig, uBalanca;

{$R *.DFM}

procedure TFchParameter.RefreshCupomFooter;
begin
  pnlFooter.Visible := (cbxPrinterFiscalName.ItemIndex in [20,21,23,24,25,26]);

  if not pnlFooter.Visible then
  begin
    memCupom.Clear;
    lbFooterInfo.Caption := '';
  end;

  Case cbxPrinterFiscalName.ItemIndex of
    20,21,24
          : begin
            memCupom.MaxLength := 380;
            lbFooterInfo.Caption := Format('%D linhas ou %D caracteres', [8,380]);
            end;
  end;

end;

procedure TFchParameter.Start(Mode:Integer);
var
  i : Integer;
begin
  fMode := Mode;

  if fMode <> PARAM_OPEN_ALL then
    begin
    For i:=PARAM_OPEN_CASHREG to PARAM_OPEN_POLE_DISP do
        pgParam.Pages[i].TabVisible := False;
    pgParam.Pages[fMode].TabVisible := True;
    if fMode = PARAM_OPEN_MENU then
       pgParam.Pages[PARAM_OPEN_GRID].TabVisible := True;
    end
  else
    fMode := PARAM_OPEN_CASHREG;

  ShowModal;
end;

procedure TFchParameter.FormShow(Sender: TObject);
begin
  inherited;

  if DM.PersistenceType = ptDB then
  begin
    cmbCashReg.ListSource.DataSet.Open;
    cmbMedia.ListSource.DataSet.Open;
  end;

  // Seta os parametros locais da maquina
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH, True);
    cmbCashReg.KeyValue            := IntToStr(ReadInteger('DefaultCashRegID'));
    EditOpenCode.Text              := ReadString('CashRegOpenCodeStr');
    cbxXpressType.ItemIndex        := ReadInteger('XPressSaleType');
    cmbStore.KeyValue              := IntToStr(ReadInteger('DefaultStoreID'));
    cmbMedia.KeyValue              := ReadInteger('DefaultMediaID');
    cbPrintReceipt.Checked         := ReadBool('PrintReceipt');
    cbOpenCashReg.Checked          := ReadBool('OpenCashReg');
    chkHasCheck.Checked            := ReadBool('PrintCheck');
    chkGeneratePAFSintegra.Checked := ReadBool('GeneratePAFSintegra');
    edtAfterPrintCode.Text         := ReadString('CashRegAfterPrintStr');

    cbxLanguage.ItemIndex         := (ReadInteger('DefaultLanguage')-1);
    edtDecimal.Text               := ReadString('DefaultDecimalSeparator');
    edtThousand.Text              := ReadString('DefaultThousandSeparator');
    cbxDateFormat.Text            := ReadString('DefaultDateFormat');
    edtXSaleImg.Text              := ReadString('XpressSaleImage');

    cbxPrinterPort.ItemIndex      := (ReadInteger('PrinterType')-1);

    cbxFontName.Text              := ReadString('PrinterFontName');
    udFont.Position               := ReadInteger('PrinterFontSize');
    udSpaceLine.Position          := ReadInteger('PrinterLineSpace');
    upLineWidth.Position          := ReadInteger('PrinterLineWidth');
    pnlMenuHighlight.Color        := StringToColor(ReadString('MenuHighlightColor'));
    pnlMenuTextHighlight.Color    := StringToColor(ReadString('MenuHighlightTextColor'));
    pnlMenuBackGround.Color       := StringToColor(ReadString('MenuBackgroundColor'));
    pnlBackGroundColor.Color      := StringToColor(ReadString('BackgroundColor'));
    pnlSubMenuFontColor.Color     := StringToColor(ReadString('SubMenuTextColor'));
    pnlSMHighlightFontColor.Color := StringToColor(ReadString('SubMenuHighlightColor'));
    memOBSInv.Text                := ReadString('InvObsText');
    edtPollDisplayIP.Text         := ReadString('PollDisplayIP');
    edtPollDisplayPort.Text       := IntToStr(ReadInteger('PollDisplayPort'));
    chkClearSale.Checked          := ReadBool('PollDisplayClearSale');

    cbxScaleModel.ItemIndex         := cbxScaleModel.Items.IndexOf(ReadString('ScaleModel'));
    cbxScaleCommunication.ItemIndex := ReadInteger('ScaleCommunicationType');
    cbxSerialPort.ItemIndex         := cbxSerialPort.Items.IndexOf(ReadString('ScaleSerialPort'));

    cbxBaudRate.ItemIndex          := ReadInteger('ScaleBaudRate');
    edtIPEthernet.Text             := ReadString('ScaleIPEthernet');
    edtPortEthernet.Text           := ReadString('ScalePortEthernet');
    chkBarcodeScale.Checked        := ReadBool('BarcodeScaleCheck');
    chkPOSScale.Checked            := ReadBool('POSScaleCheck');
    udScaleDecimal.Position        := ReadInteger('ScaleDecimal');
    cbxBarcodeScaleType.ItemIndex  := ReadInteger('BarcodeScaleType');
    cbxPOSScaleType.ItemIndex      := ReadInteger('POSScaleType');

    cbxBarcodeScaleType.Visible := chkBarcodeScale.Checked;
    cbxPOSScaleType.Visible     := chkPOSScale.Checked;
    pnlPOSScaleInfot.Visible    := (chkPOSScale.Checked) and (cbxPOSScaleType.ItemIndex = 0);

    CloseKey;
    OpenKey(REGISTRY_PATH_POS, True);
    edtImagePDV.Text              := ReadString('PDVImage');
    cbxPrinterFiscalName.ItemIndex:= cbxPrinterFiscalName.Items.IndexOf(ReadString('ECFPrinterName'));
    cmbTEFType.ItemIndex          := ReadInteger('UseTEF');
    chkAskUser.Checked            := ReadBool('AskSalesPerson');
    chkKeepSP.Checked             := ReadBool('KeepSalesPerson');
    chkShowShortCuts.Checked      := ReadBool('ShowShortCuts');
    edtMainRetailpath.Text        := ReadString('MainRetailPath');
    cbxDisplayType.ItemIndex      := ReadInteger('PDVDisplayType');
    memCupom.Text                 := ReadString('ECFRodape');
    edtMsgCashClose.Text          := ReadString('MsgCashAfterClose');

    if (not cbOpenCashReg.Checked) then
    begin
      cbxSellDrawerClose.Checked := False;
      cbxSellDrawerClose.Visible := False;
    end
    else
      cbxSellDrawerClose.Checked  := ReadBool('SellWithCashDrawClosed');

    edtTEFCodLoja.Text            := ReadString('TEFDedCodLoja');
    edtTEFIPServer.Text           := ReadString('TEFDedIPServer');
    edtTEFNumTerminal.Text        := ReadString('TEFDedNumTerminal');
    edtTEFMsg.Text                := ReadString('TEFDedMsgOp');

    RefreshCupomFooter;

    pnlPDVBackGround.Color        := StringToColor(ReadString('POSBackgroundColor'));
    pnlPDVReturnBackGround.Color  := StringToColor(ReadString('POSReturnBackgroundColor'));
    pnlPOSValues.Color            := StringToColor(ReadString('POSValuesColor'));
    pnlPOSText.Color              := StringToColor(ReadString('POSTextColor'));
    pnlBarcodeText.Color          := StringToColor(ReadString('POSBarcodeTextColor'));
    chkCPF.Checked                := ReadBool('AskCPF');
    chkValidateCPF.Checked        := ReadBool('ValidateCPF');
    chkBlockNegativeSale.Checked  := ReadBool('BlockNegativeSale');
    chkHideStoreQty.Checked       := ReadBool('HideOtherStoreQry');

    pnlTEFDed.Visible             := (cmbTEFType.ItemIndex = 2);
  finally
    Free;
  end;

  pnlSuperMarketImg.Visible   := (cbxXpressType.ItemIndex=1);
  pnlFontSetup.Visible        := (cbxPrinterPort.ItemIndex=2);
  pgParam.ActivePageIndex     := fMode;

  {ajustar a impressora escolhida}
  with DM.EFiscal1 do begin
  case cbxPrinterFiscalName.ItemIndex of
       0:Impressora:=None;
       1:Impressora:=Sweda03;
       2:Impressora:=Sweda10;
       3:Impressora:=NCR2x;
       4:Impressora:=NCR1x;
       5:Impressora:=NCR7141;
       6:Impressora:=Urano2EFE;
       7:Impressora:=Urano1EFC;
       8:Impressora:=Urano2EFC;
       9:Impressora:=Urano1FIT;
       10:Impressora:=Zanthus2e;
       11:Impressora:=ZanthusIZ20;
       12:Impressora:=ZanthusIZ21;
       13:Impressora:=ZanthusIZ41;
       14:Impressora:=ZanthusIZ11;
       15:Impressora:=ZanthusIZ10;
       16:Impressora:=Schalter3D;
       17:Impressora:=Schalter2S;
       18:Impressora:=Trends10E;
       19:Impressora:=Dataregis;
       20:Impressora:=BematechMP40;
       21:Impressora:=BematechMP20;
       22:Impressora:=Procomp_2011;
       23:Impressora:=AFRAC;
       end;
  end;

  RefreshExamples;

  //Homologacao BA
  //chkImpressoraFiscal.Checked := True;
  //tsRegularPrinter.TabVisible := False;

end;

procedure TFchParameter.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFchParameter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFchParameter.btCloseClick(Sender: TObject);

begin
  inherited;

  if (MsgBox(MSG_QST_CONFIRM_CHANGE_LOCAL, vbYesNo + vbQuestion) = vbYes) then
  begin
    // Teste de chash register ja sendo usado por outro usuario
    if fMode = PARAM_OPEN_CASHREG then
      if cmbCashReg.KeyValue <> NULL then
        case DM.PersistenceType of
          ptDB:
            if (UpperCase(DM.DescCodigo(['IDCashRegister'], [cmbCashReg.KeyValue],
                'dbo.CashRegister', 'IsAssociated')) = 'TRUE') and
               (MsgBox(MSG_QST_CASH_IS_IN_USER, vbYesNo + vbQuestion) = vbNo) then
              Exit;
        end;

    // Abre o registry
    with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey(REGISTRY_PATH, True);
      if Trim(cmbCashReg.KeyValue) <> '' then
        WriteInteger('DefaultCashRegID', StrToInt(cmbCashReg.KeyValue))
      else
        WriteInteger('DefaultCashRegID', 0);
      if cmbStore.KeyValue <> NULL then
        WriteInteger('DefaultStoreID', StrToInt(cmbStore.KeyValue));
      if cmbMedia.KeyValue <> NULL then
        WriteInteger('DefaultMediaID', cmbMedia.KeyValue);

      WriteString('CashRegOpenCodeStr', Trim(EditOpenCode.text));
      WriteString('CashRegAfterPrintStr', Trim(edtAfterPrintCode.text));

      WriteBool('PrintReceipt', cbPrintReceipt.Checked);
      WriteBool('OpenCashReg', cbOpenCashReg.Checked);

      WriteBool('PrintCheck', chkHasCheck.Checked);
      WriteBool('GeneratePAFSintegra', chkGeneratePAFSintegra.Checked);

      WriteInteger('DefaultLanguage', cbxLanguage.ItemIndex+1);
      WriteString('DefaultDecimalSeparator', edtDecimal.Text);
      WriteString('DefaultThousandSeparator', edtThousand.Text);
      WriteString('DefaultDateFormat', cbxDateFormat.Text);
      //Invoice Type
      WriteInteger('XPressSaleType', cbxXpressType.ItemIndex);
      DM.fInvoice.XpressSaleType := cbxXpressType.ItemIndex;
      WriteString('InvObsText', memOBSInv.Text);
      DM.fInvoice.OBSText := memOBSInv.Text;
      if (Trim(edtXSaleImg.Text)<>'') or (FileExists(edtXSaleImg.Text)) then
      begin
        WriteString('XpressSaleImage', edtXSaleImg.Text);
        DM.fInvoice.XpressSaleImage := edtXSaleImg.Text;
      end
      else
        WriteString('XpressSaleImage', '');

      //Printer
      WriteInteger('PrinterType', cbxPrinterPort.ItemIndex+1);
      WriteString('PrinterPort', Trim(cbxPrinterPort.Text));
      WriteString('PrinterFontName', Trim(cbxFontName.Text));
      WriteInteger('PrinterFontSize', StrToInt(edtFontSize.Text));
      WriteInteger('PrinterLineSpace', StrToInt(edtLinespace.Text));
      WriteInteger('PrinterLineWidth', StrToInt(edtLineWidth.Text));
      DM.fPrintReceipt.PrinterType      := cbxPrinterPort.ItemIndex+1;
      DM.fPrintReceipt.PrinterPort      := Trim(cbxPrinterPort.Text);
      DM.fPrintReceipt.PrinterFontName  := Trim(cbxFontName.Text);
      DM.fPrintReceipt.PrinterFontSize  := StrToInt(edtFontSize.Text);
      DM.fPrintReceipt.PrinterLineSpace := StrToInt(edtLinespace.Text);
      DM.fPrintReceipt.PrinterLineWidth := StrToInt(edtLineWidth.Text);

      //Menu
      WriteString('MenuHighlightColor', ColorToString(pnlMenuHighlight.Color));
      WriteString('MenuHighlightTextColor', ColorToString(pnlMenuTextHighlight.Color));
      WriteString('MenuBackgroundColor', ColorToString(pnlMenuBackGround.Color));
      WriteString('BackgroundColor', ColorToString(pnlBackGroundColor.Color));
      WriteString('SubMenuTextColor', ColorToString(pnlSubMenuFontColor.Color));
      WriteString('SubMenuHighlightColor', ColorToString(pnlSMHighlightFontColor.Color));
      //Poll Display
      WriteString('PollDisplayIP', edtPollDisplayIP.Text);
      WriteInteger('PollDisplayPort', StrToIntDef(edtPollDisplayPort.Text, 9091));
      WriteBool('PollDisplayClearSale', chkClearSale.Checked);

      //Scale

      WriteString('ScaleModel', Trim(cbxScaleModel.Text));
      WriteInteger('ScaleCommunicationType', cbxScaleCommunication.ItemIndex);
      WriteString('ScaleSerialPort', cbxSerialPort.Text);
      WriteInteger('ScaleBaudRate', cbxBaudRate.ItemIndex);
      WriteString('ScaleIPEthernet', edtIPEthernet.Text);
      WriteString('ScalePortEthernet', edtPortEthernet.Text);
      WriteBool('BarcodeScaleCheck', chkBarcodeScale.Checked);
      WriteBool('POSScaleCheck', chkPOSScale.Checked);
      WriteInteger('ScaleDecimal', udScaleDecimal.Position);
      WriteInteger('BarcodeScaleType', cbxBarcodeScaleType.ItemIndex);
      WriteInteger('POSScaleType', cbxPOSScaleType.ItemIndex);


      // -*-*-*-*-*-*- //
      // -*- P D V -*- //
      // -*-*-*-*-*-*- //
      CloseKey;
      OpenKey(REGISTRY_PATH_POS, True);
      WriteBool('AskSalesPerson', chkAskUser.Checked);
      WriteBool('KeepSalesPerson', chkKeepSP.Checked);
      WriteBool('ShowShortCuts', chkShowShortCuts.Checked);
      WriteString('MainRetailPath', edtMainRetailpath.Text);
      WriteInteger('PDVDisplayType', cbxDisplayType.ItemIndex);

      WriteString('POSBackgroundColor', ColorToString(pnlPDVBackGround.Color));
      WriteString('POSReturnBackgroundColor', ColorToString(pnlPDVReturnBackGround.Color));
      WriteString('POSValuesColor', ColorToString(pnlPOSValues.Color));
      WriteString('POSTextColor', ColorToString(pnlPOSText.Color));
      WriteString('POSBarcodeTextColor', ColorToString(pnlBarcodeText.Color));

      WriteString('MsgCashAfterClose', edtMsgCashClose.Text);

      if (Trim(edtImagePDV.Text) <> '') or (FileExists(edtImagePDV.Text)) then
        WriteString('PDVImage', edtImagePDV.Text)
      else
        WriteString('PDVImage', '');
      //Fiscal Printer
      WriteString('ECFPrinterName', Trim(cbxPrinterFiscalName.Text));
      DM.fPrintReceipt.ECFPrinterName   := Trim(cbxPrinterFiscalName.Text);

      WriteString('ECFRodape', Trim(memCupom.Text));
      //TEF
      WriteInteger('UseTEF', cmbTEFType.ItemIndex);

      WriteString('TEFDedCodLoja', edtTEFCodLoja.Text);
      WriteString('TEFDedIPServer', edtTEFIPServer.Text);
      WriteString('TEFDedNumTerminal', edtTEFNumTerminal.Text);
      WriteString('TEFDedMsgOp', edtTEFMsg.Text);

      if not cbOpenCashReg.Checked then
        cbxSellDrawerClose.Checked := False;

      WriteBool('SellWithCashDrawClosed', cbxSellDrawerClose.Checked);
      WriteBool('AskCPF', chkCPF.Checked);
      WriteBool('ValidateCPF', chkValidateCPF.Checked);
      WriteBool('BlockNegativeSale', chkBlockNegativeSale.Checked);
      WriteBool('HideOtherStoreQry', chkHideStoreQty.Checked);
    finally
      Free;
    end;

    btnApplay.Click;

    //Nao perguntar msg para esses parametros
    if not (pgParam.ActivePage.PageIndex in [PARAM_OPEN_PRINTER, PARAM_OPEN_INVOICE,
                                             PARAM_OPEN_MENU, PARAM_OPEN_GRID]) then
      MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly + vbInformation);

    Close;
  end;
end;


procedure TFchParameter.spHelpClick(Sender: TObject);
begin
  inherited;
  case pgParam.ActivePageIndex of
    0: Application.HelpContext(270);
    1: Application.HelpContext(280);
    3: case pgPrinterOption.ActivePageIndex of
         0: Application.HelpContext(290);
         1: Application.HelpContext(300);
         2: Application.HelpContext(330);
       end;
    6: Application.HelpContext(340);
    7: Application.HelpContext(350);
    8: Application.HelpContext(360);
  end;
end;

procedure TFchParameter.RefreshExamples;
begin
  lbEx1.Caption := '1'+edtThousand.Text+'000'+edtDecimal.Text+'00';
  lbEx2.Caption := FormatDateTime(cbxDateFormat.Text ,now);
end;

procedure TFchParameter.cbxDateFormatChange(Sender: TObject);
begin
  inherited;
  RefreshExamples;
end;

procedure TFchParameter.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OP.Execute then
     edtXSaleImg.Text := OP.FileName;
end;

procedure TFchParameter.cbxXpressTypeChange(Sender: TObject);
begin
  inherited;
  pnlSuperMarketImg.Visible  := (cbxXpressType.ItemIndex=1);
end;

procedure TFchParameter.FormCreate(Sender: TObject);
begin
  inherited;
  cbxFontName.Items           := Screen.Fonts;
  tsPDVPrinter.TabVisible     := True;
  tsTEF.TabVisible            := tsPDVPrinter.TabVisible;
end;

procedure TFchParameter.cbxFontNameChange(Sender: TObject);
begin
  inherited;
  lbFontExample.Font.Name := cbxFontName.Text;
  lbFontExample.Font.Size := StrToInt(edtFontSize.Text);
end;

procedure TFchParameter.cbxPrinterPortChange(Sender: TObject);
begin
  inherited;
  pnlFontSetup.Visible := (cbxPrinterPort.ItemIndex=2);
end;

procedure TFchParameter.pnlMenuHighlightClick(Sender: TObject);
begin
  inherited;
  CD.Color := TPanel(Sender).Color;
  if CD.Execute then
     TPanel(Sender).Color := CD.Color;
end;

procedure TFchParameter.cbxColorChange(Sender: TObject);
begin
  inherited;
  Case cbxColor.ItemIndex of
    //Default
    0 : begin
        pnlMenuHighlight.Color        := clWhite;
        pnlMenuTextHighlight.Color    := clBlack;
        pnlMenuBackGround.Color       := clHighlight;
        pnlBackGroundColor.Color      := clWhite;
        pnlSubMenuFontColor.Color     := clBlue;
        pnlSMHighlightFontColor.Color := clGreen;
        end;
  end;
end;

procedure TFchParameter.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  OP.Filter := 'BMP (*.bmp)|*.bmp|JPG (*.jpg)|*.jpg';
  if OP.Execute then
     edtImagePDV.Text := OP.FileName;
end;

procedure TFchParameter.CalIndexConfig(Tab: Integer);
var
  FrmTaxPaymentConfig: TFrmTaxPaymentConfig;
begin
  FrmTaxPaymentConfig := TFrmTaxPaymentConfig.Create(Self);
  try
    FrmTaxPaymentConfig.Start(Tab);
  finally
    FrmTaxPaymentConfig.Free;
  end;
end;

procedure TFchParameter.Button2Click(Sender: TObject);
begin
  inherited;
  CalIndexConfig(TButton(Sender).Tag);
end;

procedure TFchParameter.btnOpenMainRetailClick(Sender: TObject);
begin
  inherited;
  OP.Filter := 'MainRetail |MainRetail.exe';
  if OP.Execute then
     edtMainRetailpath.Text := OP.FileName;
end;

procedure TFchParameter.btnPOSDefaultColorsClick(Sender: TObject);
begin
  inherited;
  pnlPDVBackGround.Color        := $00804000;
  pnlPDVReturnBackGround.Color  := $003E3E00;
  pnlPOSValues.Color            := clYellow;
  pnlPOSText.Color              := $00FFCE9D;
  pnlBarcodeText.Color          := $008080FF;
end;

procedure TFchParameter.InsertHeader(text:String);
var
 str: string;
 p: integer;
begin
  p := memCupom.SelStart + memCupom.SelLength + 1;
  str := memCupom.Text;
  Insert(text, str, p);
  memCupom.Text := str;
  memCupom.SelStart := p + Length(Text) - 1;
end;


procedure TFchParameter.btnFooterClienteClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[CLIENTE]');
end;

procedure TFchParameter.btnFooterCPFClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[DOC]');
end;

procedure TFchParameter.cbxPrinterFiscalNameChange(Sender: TObject);
begin
  inherited;
  RefreshCupomFooter;
end;

procedure TFchParameter.btnFooterMediaClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[MIDIA]');
end;

procedure TFchParameter.btnFooterVendedorClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[VENDEDOR]');
end;

procedure TFchParameter.btnFooterOBSClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[INVOBS]');
end;

procedure TFchParameter.btnFooterEnderecoClick(Sender: TObject);
begin
  inherited;
  InsertHeader('[ENDERECO]');
end;

procedure TFchParameter.btnTestCutClick(Sender: TObject);
begin
  inherited;
  if edtAfterPrintCode.Text <> '' then
    DM.SendCashCode(edtAfterPrintCode.Text, True);
end;

procedure TFchParameter.cmbTEFTypeChange(Sender: TObject);
begin
  inherited;
  pnlTEFDed.Visible := (cmbTEFType.ItemIndex = 2);
end;

procedure TFchParameter.cbOpenCashRegExit(Sender: TObject);
begin
  inherited;

  if cbOpenCashReg.Checked then
    cbxSellDrawerClose.Visible := cbOpenCashReg.Checked
  else
  begin
    cbxSellDrawerClose.Visible := False;
    cbxSellDrawerClose.Checked := False;
  end;

end;

procedure TFchParameter.cbxScaleCommunicationChange(Sender: TObject);
begin
  inherited;
  {
  Case cbxScaleCommunication.ItemIndex of
        0   : begin
            pnlSerial.Visible := true;
            pnlSerial.Enabled := true;
            pnlEthernet.Visible := false;
            pnlEthernet.Enabled := false;
            end;
        1   : begin
            pnlSerial.Visible := false;
            pnlSerial.Enabled := false;
            pnlEthernet.Visible := true;
            pnlEthernet.Enabled := true;
            end;
  end;
  }
end;

procedure TFchParameter.chkPOSScaleClick(Sender: TObject);
begin
  inherited;
  cbxPOSScaleType.Visible  := chkPOSScale.Checked;
  pnlPOSScaleInfot.Visible := (chkPOSScale.Checked) and (cbxPOSScaleType.ItemIndex = 0);
end;

procedure TFchParameter.edtIPEthernetKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8), '.']) then Key:= #0;
end;

procedure TFchParameter.edtPortEthernetKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TFchParameter.btnConfigScaleClick(Sender: TObject);
var
  FBalanca : TBalanca;
begin
  inherited;

  FBalanca := TBalanca.Create(Self);
  try
    FBalanca.ConfigScale;
  finally
    FreeAndNil(FBalanca);
  end;

end;

procedure TFchParameter.cbxPOSScaleTypeChange(Sender: TObject);
begin
  inherited;
  pnlPOSScaleInfot.Visible := (chkPOSScale.Checked) and (cbxPOSScaleType.ItemIndex = 0);
end;

procedure TFchParameter.cbxPOSScaleTypeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['O', 'P', Chr(8)]) then Key:= #0;
end;

procedure TFchParameter.Button3Click(Sender: TObject);
begin
  inherited;
  if DM.FMD5 <> '' then
    DM.EFiscal1.ProgramaIdAplicativo('MainRetail - Cash Register 1.6', 'MD5: ' + DM.FMD5)
  else
    ShowMessage('MD5 não registrado!');

  {
  DM.EFiscal1.AbreRelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('TESTE DE CARTAO CONVENIO');
  DM.EFiscal1.RelatorioGerencial('Cliente: Rodrigo Torrentes');
  DM.EFiscal1.RelatorioGerencial('Valor: 100,00');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('Ass. _________________________');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('');
  DM.EFiscal1.FechaRelatorioGerencial;
  }

end;

procedure TFchParameter.chkBarcodeScaleClick(Sender: TObject);
begin
  inherited;
  cbxBarcodeScaleType.Visible  := chkBarcodeScale.Checked;
end;

end.



