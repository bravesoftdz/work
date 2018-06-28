unit uCashRegManager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, ExtCtrls, DB, DBTables, Grids, DBGrids, StdCtrls, LblEffct,
  Buttons, uInvoice, uNewPreSales, ComCtrls, Mask, DateBox, ADODB, siComp,
  siLangRT, uFrmFastSale, uFrmFastSaleGroucery, Variants, SMDBGrid,
  SubListPanel, uFrmHistory, uFrmSaleConsult, ImgList, uFrmFastSale2,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TCashRegManager = class(TFrmParent)
    dsPreSale: TDataSource;
    tmrRefresh: TTimer;
    quPreSale: TADOQuery;
    quPreSaleIDPreSale: TIntegerField;
    quPreSalePreSaleDate: TDateTimeField;
    quPreSaleTotInvoice: TFloatField;
    tmrOverLoad: TTimer;
    PPC: TPageControl;
    tsNormal: TTabSheet;
    tsFast: TTabSheet;
    edFastPay: TEdit;
    Label1: TLabel;
    btFastPay: TButton;
    Label2: TLabel;
    dbPaymentDate: TDateBox;
    quPreSaleFirstName: TStringField;
    quPreSaleLastName: TStringField;
    spHelp: TSpeedButton;
    pnlHoldDisplay: TPanel;
    rgFaixa: TRadioGroup;
    pnlOverLoad: TPanel;
    lblOverLoad: TLabel;
    lblCashOverLoad: TLabel;
    lbCRInfo: TLabel;
    Panel6: TPanel;
    Shape3: TShape;
    Label7: TLabel;
    pnlSetup: TPanel;
    Panel8: TPanel;
    Shape4: TShape;
    Label8: TLabel;
    sbSetupCashReg: TSpeedButton;
    btnSetupPrinter: TSpeedButton;
    btnSetupInv: TSpeedButton;
    btnSetupTicket: TSpeedButton;
    Panel9: TPanel;
    BtnCloseCash: TSpeedButton;
    BtnDeposit: TSpeedButton;
    BtnPettyCash: TSpeedButton;
    BtnInvoice: TSpeedButton;
    BtnXSale: TSpeedButton;
    BtnOpenHold: TSpeedButton;
    BtnUnlockHold: TSpeedButton;
    btnLayaway: TSpeedButton;
    btnOutAgnt: TSpeedButton;
    Panel5: TPanel;
    Shape2: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Label9: TLabel;
    Bevel2: TBevel;
    btnShowConfig: TSpeedButton;
    tsInvoice: TTabSheet;
    pnlInvoiceFluxo: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    imgOpenHold: TImage;
    Shape5: TShape;
    lbOpenHold: TLabel;
    imgSearchHold: TImage;
    lbSearchHold: TLabel;
    lbBudget: TLabel;
    imgBudget: TImage;
    lbCloseDay: TLabel;
    imgCloseDay: TImage;
    lbFinalizeHold: TLabel;
    imgFinalizeHold: TImage;
    imgSeta1: TImage;
    imgSeta2: TImage;
    pnlShorCuts: TPanel;
    Panel12: TPanel;
    Shape6: TShape;
    Label12: TLabel;
    pnlShortCutInv: TPanel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    btnCancelHold: TSpeedButton;
    sbShowShotCuts: TSpeedButton;
    Shape7: TShape;
    imgConsultHold: TImage;
    lbConsultHold: TLabel;
    Label13: TLabel;
    quCommand: TADOQuery;
    quCommandName: TStringField;
    quCommandCmdLine: TStringField;
    quPreSaleSaleCode: TStringField;
    quUpdateInvoice: TADOQuery;
    imgPrintDelivery: TImage;
    lbPrintDelivery: TLabel;
    imgSeta3: TImage;
    btnCustomerRepair: TSpeedButton;
    btnStoreAcc: TSpeedButton;
    pnlImage: TPanel;
    imgClientLogo: TImage;
    imgLogOut: TImage;
    btnComission: TSpeedButton;
    btnPrintInv: TSpeedButton;
    Panel10: TPanel;
    BtnInventory: TSpeedButton;
    btnSalesRequest: TSpeedButton;
    btnTimeClock: TSpeedButton;
    btnCustomer: TSpeedButton;
    btnInvoices: TSpeedButton;
    Label5: TLabel;
    btnFullInv: TSpeedButton;
    btnPO: TSpeedButton;
    Panel7: TPanel;
    Shape1: TShape;
    Label6: TLabel;
    btnMessage: TSpeedButton;
    grdCashDBTableView1: TcxGridDBTableView;
    grdCashLevel1: TcxGridLevel;
    grdCash: TcxGrid;
    grdCashDBTableView1PreSaleDate: TcxGridDBColumn;
    grdCashDBTableView1TotInvoice: TcxGridDBColumn;
    grdCashDBTableView1FirstName: TcxGridDBColumn;
    grdCashDBTableView1LastName: TcxGridDBColumn;
    grdCashDBTableView1SaleCode: TcxGridDBColumn;
    lbOpenPOSHold: TLabel;
    imgOpenPOSHold: TImage;
    tsShippingDist: TTabSheet;
    pnlShipping: TPanel;
    Shape8: TShape;
    Label14: TLabel;
    lbCustomerPO: TLabel;
    imgCustomerPO: TImage;
    lbShippingClose: TLabel;
    imgShippingClose: TImage;
    imbShippingInvoice: TImage;
    lbShippingInvoice: TLabel;
    Bevel3: TBevel;
    pnlImgShipLog: TPanel;
    imgCompanyLog: TImage;
    imgTrackPackage: TImage;
    lbTrackPackage: TLabel;
    btnAddCash: TSpeedButton;
    btnBudget: TSpeedButton;
    grdCashDBTableView1Pessoa: TcxGridDBColumn;
    quPreSaleCustomer: TStringField;
    quPreSaleIDPessoa: TIntegerField;
    quPreSalePessoa: TStringField;
    btnStoreAccount: TSpeedButton;
    quInvoiceOBS: TADODataSet;
    quInvoiceOBSIDInvoiceOBS: TIntegerField;
    quInvoiceOBSIDPreSale: TIntegerField;
    quInvoiceOBSIDCFOP: TIntegerField;
    quInvoiceOBSIDPessoaTax: TIntegerField;
    quInvoiceOBSIDCarrier: TIntegerField;
    quInvoiceOBSFreightType: TIntegerField;
    quInvoiceOBSIDUserDeliver: TIntegerField;
    quInvoiceOBSIDPessoaAddress: TIntegerField;
    procedure tmrRefreshTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure dsPreSaleDataChange(Sender: TObject; Field: TField);
    procedure rgFaixaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrOverLoadTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btFastPayClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure BtnInvoiceClick(Sender: TObject);
    procedure BtnXSaleClick(Sender: TObject);
    procedure BtnOpenHoldClick(Sender: TObject);
    procedure BtnDepositClick(Sender: TObject);
    procedure BtnPettyCashClick(Sender: TObject);
    procedure BtnCloseCashClick(Sender: TObject);
    procedure BtnUnlockHoldClick(Sender: TObject);
    procedure BtnInventoryClick(Sender: TObject);
    procedure btnSalesRequestClick(Sender: TObject);
    procedure btnTimeClockClick(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
    procedure btnInvoicesClick(Sender: TObject);
    procedure sbSetupCashRegClick(Sender: TObject);
    procedure btnSetupTicketClick(Sender: TObject);
    procedure btnFullInvClick(Sender: TObject);
    procedure btnPOClick(Sender: TObject);
    procedure btnShowConfigClick(Sender: TObject);
    procedure imgOpenHoldClick(Sender: TObject);
    procedure imgSearchHoldClick(Sender: TObject);
    procedure imgFinalizeHoldClick(Sender: TObject);
    procedure imgCloseDayClick(Sender: TObject);
    procedure sbShowShotCutsClick(Sender: TObject);
    procedure imgConsultHoldClick(Sender: TObject);
    procedure CallShellAPI(Sender: TObject);
    procedure imgBudgetClick(Sender: TObject);
    procedure imgPrintDeliveryClick(Sender: TObject);
    procedure btnCustomerRepairClick(Sender: TObject);
    procedure btnCancelHoldClick(Sender: TObject);
    procedure imgLogOutClick(Sender: TObject);
    procedure btnComissionClick(Sender: TObject);
    procedure btnPrintInvClick(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure grdCashEnter(Sender: TObject);
    procedure grdCashDBTableView1DblClick(Sender: TObject);
    procedure imgOpenPOSHoldClick(Sender: TObject);
    procedure imbShippingInvoiceClick(Sender: TObject);
    procedure imgTrackPackageClick(Sender: TObject);
    procedure btnAddCashClick(Sender: TObject);
    procedure btnBudgetClick(Sender: TObject);
    procedure quPreSaleCalcFields(DataSet: TDataSet);
    procedure btnStoreAccountClick(Sender: TObject);
  private
    { Private declarations }
    fImgOld : Integer;
    fsMenu,
    fsSubMenu : String;
    sOpen,
    sShowConfig,
    sHideConfig,
    sAt   : String;
    OldCountInvoice  : Integer;
    MyIDCashRegMov   : Integer;
    MyIDCashReg      : Integer;
    MyPreSaleType    : Integer;
    iParamScreenType : Integer;
    IsOverLoad       : Boolean;
    FrmInvoice       : TFrmInvoice;
    FrmNewPreSales   : TFrmNewPreSales;
    FrmXPressSale    : TFrmFastSale;
    FrmHistory       : TFrmHistory;
    FrmSaleConsult   : TFrmSaleConsult;
    procedure SelectHold;
    procedure UnSelectHold;
    procedure OnAfterShortClick;
    procedure CallShortCut(IDMenu, IDSubMenu : Integer);
    procedure OpenHold(OpenIDPreSale: Integer);
    procedure InvoiceOptions;
    function NewHistory(IDHistoryType, IDPreSale: Integer; SaleCode:String;
             var sHistParam : String; var dInvDate : TDateTime): Boolean;
    function SaleConsult(IsClosedLayAway: Boolean): String;
    procedure CreateOfficeShortCuts;
    function UpdateInvoiceCode(fInvoiceCode : String; fIDPreSale, fCFOP, fCarrier, fFreightType : Integer):Boolean;

    function ProcessInvoiceBonus(iIDPreSale : Integer; sInvoiceNum : String; cTotalInvoice: Currency) : Boolean;
  public
    procedure Start(IDCashRegMov, IDCashReg : integer; ScreenType : Integer; IsCaixaMode : Boolean);
  end;

implementation

uses uDM, uCashRegClose, uCashRegWidraw, uMsgBox, uSubTicketInfo, uSystemConst,
     uPassword, uQueryInventory, uCashRegPetty, uEditPreSale, MenuPrincipal,
     uMsgConstant, uNumericFunctions, uDateTimeFunctions, uDMGlobal, uParamFunctions,
     uPrintReceipt, uFrmConsultHold, uFileFunctions, uFrmEstimated, uHandleError,
     uFrmPrintDeliveryList, uFrmInventoryList, DateUtils, uFrmUserMessager,
     uBonusBucks, uFrmShippingDistrubSale, uFrmTrackPackage, uFrmStoreAccount;

{$R *.DFM}

procedure TCashRegManager.Start(IDCashRegMov, IDCashReg : integer;
      ScreenType : Integer; IsCaixaMode : Boolean);
var
  fCashRegName,
  fOpenUser    : String;
  fStatus      : Integer;
  fOpenDate    : TDateTime;
begin
  iParamScreenType := ScreenType;

  case iParamScreenType of
    CASHREG_TYPE_POS    : PPC.ActivePage := tsNormal;
    CASHREG_TYPE_OFFICE : begin
                          PPC.ActivePage := tsInvoice;
                          InvoiceOptions;
                          CreateOfficeShortCuts;
                          end;
    CASHREG_TYPE_SHIPPING : PPC.ActivePage := tsShippingDist;
    else PPC.ActivePage := tsNormal;
  end;

  MyIDCashRegMov := IDCashRegMov;
  MyIDCashReg    := IDCashReg;

  // Mostra a caixa que esta sendo usada
  DM.fPOS.GetCashRegisterInfo(IDCashRegMov, fCashRegName, fOpenUser, fStatus, fOpenDate);

  lbCRInfo.Caption   := Trim(fCashRegName) + sOpen + Trim(fOpenUser) + sAt +
                            DateTimeToStr(fOpenDate);
  // Testa o status da caixa para ver se pode Fazer depositos, pettycash ou fecha-la
  BtnDeposit.Enabled  := (fStatus = ST_CASHREG_OPEN);
  BtnPettyCash.Enabled := BtnDeposit.Enabled;
  // So deixa dar Close se estiver no modo caixa
  BtnCloseCash.Enabled := BtnDeposit.Enabled and IsCaixaMode;

  if fIsRestricForm then
     begin
     BtnCloseCash.Enabled := False;
     BtnDeposit.Enabled   := False;
     BtnPettyCash.Enabled := False;
     BtnInvoice.Enabled   := False;
     btnLayaway.Enabled   := False;
     btnOutAgnt.Enabled   := False;
     BtnXSale.Enabled     := False;
     BtnOpenHold.Enabled  := False;
     BtnUnlockHold.Enabled := False;
     btnShowConfig.Visible := False;
     end;

  DM.fMainMenu.SubMenuName := DM.fMainMenu.SubMenuName + ' - ' + fCashRegName;

  ShowModal;

end;

procedure TCashRegManager.rgFaixaClick(Sender: TObject);
var
  MyFaixa, OldID : integer;
  NumHold : String;
begin
  inherited;

  OldID := 0;

  with TADOQuery(dsPreSale.DataSet) do
  begin
    if Active then
      OldID := FieldByName('IDPreSale').AsInteger;

    Close;
    Parameters.ParamByName('DataSel').Value  := Date;
    Parameters.ParamByName('Layaway').Value  := False;
    Parameters.ParambyName('Layaway2').Value := False;
    Parameters.ParamByName('IDStore').Value  := DM.fStore.ID;

    case rgFaixa.ItemIndex of
      0 : Parameters.ParamByName('Faixa').Value := 0;   //Today
      1 : begin //All Holds
            Parameters.ParamByName('DataSel').Value := null;
            Parameters.ParamByName('Faixa').Value   := -1;
          end;
      2 : begin  //Layaway
            Parameters.ParambyName('Layaway').Value  := True;
            Parameters.ParamByName('Layaway2').Value := True;
          end;
    end;
    Open;

    try
      Locate('IDPreSale', OldID, []);
    except
    end;

  end;
end;

procedure TCashRegManager.dsPreSaleDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  {
  if (TADOQuery(dsPreSale.DataSet).Eof and
      TADOQuery(dsPreSale.DataSet).Bof) then
  begin
    grdPreSales.Color   := clBtnFace;
    grdPreSales.Enabled := False;
    BtnOpenHold.Enabled := False;
  end
  else
  begin
    grdPreSales.Color   := clWindow;
    grdPreSales.Enabled := True;
  end;
  }
end;

procedure TCashRegManager.btCloseClick(Sender: TObject);
begin
  inherited;

  Close;

//  MainMenu.tmrCashierTimer (nil);

  if DM.fStartOption = START_LAYAWAY then
     begin
     Application.Terminate;
     end;

  if DM.fSystem.SrvParam[PARAM_ASK_PASSWORD_BEFORE_OPEN_SOFTWARE] and
     Password.HasFuncRight(58) then
     begin
     Application.Terminate;
     end;


end;

procedure TCashRegManager.FormShow(Sender: TObject);
begin
  inherited;

  OldCountInvoice := DM.fPOS.TestRefresh;

  tmrRefresh.Enabled := True;

  tmrRefreshTimer(nil);

  rgFaixa.ItemIndex := 0;

  rgFaixaClick(Nil);

  BtnXSale.Visible     := not (DM.fStartOption = START_LAYAWAY);
  BtnCloseCash.Visible := not (DM.fStartOption = START_LAYAWAY);
  
end;

procedure TCashRegManager.FormCreate(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled        := False;
  FrmInvoice                := TFrmInvoice.Create(Self);
  FrmNewPreSales            := TFrmNewPreSales.Create(Self);
  FrmNewPreSales.FrmInvoice := FrmInvoice;
  FrmHistory                := Nil;
  FrmSaleConsult            := Nil;
  imgFinalizeHold.Visible   := DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE];
  lbFinalizeHold.Visible    := imgFinalizeHold.Visible;
  imgSeta3.Visible          := imgFinalizeHold.Visible;
  imgPrintDelivery.Visible  := imgFinalizeHold.Visible;
  lbPrintDelivery.Visible   := imgFinalizeHold.Visible;

  if (DM.fMainMenu.Logo <> DM.LocalPath+'logo.JPG') and FileExists(DM.fMainMenu.Logo) then
  begin
    imgClientLogo.Picture.LoadFromFile(DM.fMainMenu.Logo);
    pnlImage.Visible := True;
    imgCompanyLog.Picture.LoadFromFile(DM.fMainMenu.Logo);
    pnlImgShipLog.Visible := True;
  end
  else
    pnlShorCuts.Top := 25;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sOpen       := ', opened by ';
           sAt         := ' at ';
           sShowConfig := '&Show configuration';
           sHideConfig := '&Hide configuration';
           end;

     LANG_PORTUGUESE :
           begin
           sOpen       := ', aberta por ';
           sAt         := ' em ';
           sShowConfig := 'Mo&strar configuração';
           sHideConfig := 'Ocultar configuração';
           end;

     LANG_SPANISH :
           begin
           sOpen       := ', abrió por ';
           sAt         := ' en ';
           sShowConfig := 'Mue&stre configuración';
           sHideConfig := 'E&sconda configuration';
           end;
   end;
end;

procedure TCashRegManager.FormDestroy(Sender: TObject);
begin
  inherited;
  TADOQuery(dsPreSale.DataSet).Close;
  FrmInvoice.Free;
  FrmNewPreSales.Free;
end;

procedure TCashRegManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tmrRefresh.Enabled := False;

  Screen.Cursor := crDefault;
  Action := caFree;
end;

procedure TCashRegManager.tmrRefreshTimer(Sender: TObject);
var
  iCountInv : Integer;
  dCountCash : Double;
begin
  inherited;

  if iParamScreenType <> CASHREG_TYPE_OFFICE then
     begin
     dCountCash := DM.fPOS.GetTotalCashReceived(MyIDCashRegMov);
     IsOverLoad := (dCountCash > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);
     tmrOverLoadTimer(nil);

     iCountInv := DM.fPOS.TestRefresh;

     if iCountInv <> OldCountInvoice then
         begin
         MessageBeep(0);
         OldCountInvoice := iCountInv;
         rgFaixaClick(nil);
         end;
     end;

  imgLogOut.Visible := Password.PermanentLogOn;
      
end;

procedure TCashRegManager.SelectHold;
begin
  BtnOpenHold.Enabled := True;
end;

procedure TCashRegManager.UnSelectHold;
begin
  BtnOpenHold.Enabled := False;
end;

procedure TCashRegManager.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of

    VK_F2 : begin //Add New
            if PPC.ActivePage = tsNormal then
               if BtnInvoice.Enabled then
                  BtnInvoiceClick(BtnInvoice);
            end;

    VK_F3 : begin //Layaway
            if PPC.ActivePage = tsNormal then
               if btnLayaway.Enabled then
                  BtnInvoiceClick(btnLayaway);
            end;

    VK_F4 : begin //Outside Agent
            if PPC.ActivePage = tsNormal then
               if btnOutAgnt.Enabled then
                  BtnInvoiceClick(btnOutAgnt);
            end;

    VK_F5 : begin //Fast Sale
            if PPC.ActivePage = tsNormal then
               if BtnXSale.Enabled then
                  BtnXSaleClick(BtnXSale);
            end;

    VK_F6 : begin //Pay
            if PPC.ActivePage = tsNormal then
               if BtnOpenHold.Enabled then
                  BtnOpenHoldClick(BtnOpenHold);
            end;

    VK_F7 : begin //Unlock Hold
            if PPC.ActivePage = tsNormal then
               if BtnUnlockHold.Enabled then
                  BtnUnlockHoldClick(BtnUnlockHold);
            end;

    VK_F9 : begin //Close Register
            if PPC.ActivePage = tsNormal then
               if BtnCloseCash.Enabled then
                  BtnCloseCashClick(BtnCloseCash);
            end;

    VK_F10 : begin //Deposit
            if PPC.ActivePage = tsNormal then
               if BtnDeposit.Enabled then
                  BtnDepositClick(BtnDeposit);
            end;

    VK_F11 : begin //Petty Cash
            if PPC.ActivePage = tsNormal then
               if BtnPettyCash.Enabled then
                  BtnPettyCashClick(BtnPettyCash);
            end;

    VK_F12 : begin //Add Cash
            if PPC.ActivePage = tsNormal then
               if btnAddCash.Enabled then
                  btnAddCashClick(btnAddCash);
            end;

  end;

end;


procedure TCashRegManager.tmrOverLoadTimer(Sender: TObject);
begin
  inherited;
  pnlOverLoad.Visible := IsOverLoad;

  if IsOverLoad then
  begin
    MessageBeep(0);
    if lblCashOverLoad.Font.Color = clMaroon then
    begin
      lblCashOverLoad.Font.Color := clRed;
      lblOverLoad.Font.Color     := clRed;
      pnlOverLoad.Color          := clMaroon;
    end
    else
    begin
      lblCashOverLoad.Font.Color := clMaroon;
      lblOverLoad.Font.Color     := clMaroon;
      pnlOverLoad.Color          := clBlack;
    end;
  end;
end;

procedure TCashRegManager.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  // ** Zera a contagem do timer do caixa com o mov. do mouse
//  MainMenu.tmrCashier.Enabled := False;
//  MainMenu.tmrCashier.Enabled := True;
end;

procedure TCashRegManager.btFastPayClick(Sender: TObject);
var
  iInvoice: Integer;
begin
  inherited;

  if MyStrToInt(edFastPay.text) = 0 then
  begin
    MsgBox(MSG_CRT_NO_VALID_HOLD, vbCritical + vbOkOnly);
    Exit;
  end;

  if not TestDate(dbPaymentDate.text) then
  begin
    MsgBox(MSG_CRT_NO_PAY_DATE, vbCritical + vbOkOnly);
    Exit;
  end;

  with DM.quFreeSQL do
  begin
    CLose;
    SQL.Text := 'SELECT IDInvoice, IDPreSale, IDTouristGroup, ' +
                'OtherComissionID, (SubTotal + Tax - InvoiceDiscount - ItemDiscount) as Total ' +
                'FROM Invoice (NOLOCK) where IDPreSale = '+ edFastPay.text;
    Open;
    if IsEmpty then
    begin
      MsgBox(MSG_CRT_NO_FOUND_HOLD, vbCritical + vbOkOnly);
      Close;
      Exit;
    end;
    if NOT FieldByName('IDInvoice').IsNull then
    begin
      MsgBox(MSG_CRT_HOLD_PAID, vbCritical + vbOkOnly);
      Close;
      Exit;
    end;

    // Começo o pagamento
    try
      DM.ADODBConnect.BeginTrans;
      try
        DM.fPOS.PreSalePay(DM.quFreeSQL.FieldByName('IDPreSale').AsInteger,
                           DM.quFreeSQL.FieldByName('IDTouristGroup').AsInteger,
                           DM.quFreeSQL.FieldByName('OtherComissionID').AsInteger,
                           MyIDCashRegMov,
                           DM.fStore.ID,
                           Now,
                           dbPaymentDate.Date,
                           DM.quFreeSQL.FieldByName('Total').AsFloat,
                           0,
                           '',
                           iInvoice);
      finally
      end;

        DM.quFreeSQl.Close;
        DM.ADODBConnect.CommitTrans;
        edFastPay.Clear;
        edFastPay.SetFocus;
      except
        DM.ADODBConnect.RollbackTrans;
        MsgBox(MSG_INF_ERROR, vbInformation + vbOkOnly);
        DM.quFreeSQl.Close;
      end;
  end;
{
  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
    begin
     FrmInvoice.Start(MyStrToInt(edFastPay.text), SALE_CASHREG, MyIDCashRegMov);
     edFastPay.Clear;
     edFastPay.SetFocus;
    end;
}
end;

procedure TCashRegManager.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1010);
end;

procedure TCashRegManager.BtnInvoiceClick(Sender: TObject);
var
  InvoiceType : Integer;
begin
  inherited;

  //Display invoice type
  InvoiceType := TSpeedButton(Sender).Tag;

  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if DM.fCashRegister.AskSalesPerson then
     Password.PermanentLogOn := False;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     begin
     with FrmNewPreSales do
          Start(Self.MyIDCashRegMov, InvoiceType, True);
     rgFaixaClick(nil);
     end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;

end;

procedure TCashRegManager.BtnXSaleClick(Sender: TObject);
begin
  inherited;

  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin

    FrmXPressSale := nil;

    //DM.fInvoice.XpressSaleType := XPRESS_SALE_RETAIL2;

    Case DM.fInvoice.XpressSaleType of
       XPRESS_SALE_RETAIL      : FrmXPressSale := TFrmFastSale.Create(Self);
       XPRESS_SALE_SUPERMARKET : FrmXPressSale := TFrmFastSaleGrocery.Create(Self);
       XPRESS_SALE_RETAIL2     : FrmXPressSale := TFrmFastSale2.Create(Self);
       else FrmXPressSale := TFrmFastSale.Create(Self); //XPress Sale default
    end;

    with FrmXPressSale do
    begin
      Start(SALE_CASHREG, MyIDCashRegMov);
      rgFaixaClick(nil);
    end;
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;

end;

procedure TCashRegManager.BtnOpenHoldClick(Sender: TObject);
begin
  inherited;
  OpenHold(quPreSaleIDPreSale.AsInteger);
end;

procedure TCashRegManager.OpenHold(OpenIDPreSale : Integer);
begin
  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    FrmInvoice.Start(OpenIDPreSale, SALE_CASHREG, MyIDCashRegMov, False);
    rgFaixaClick(nil);
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;
end;

procedure TCashRegManager.BtnDepositClick(Sender: TObject);
begin
  inherited;

  if not Password.HasFuncRight(60) then
     begin
     MsgBox(MSG_CRT_NO_MAKE_DEPOSIT, vbCritical + vbOkOnly);
     Exit;
     end;

  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    with TCashRegWidraw.Create(Self) do
      Start(MyIDCashRegMov);
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;

  tmrRefreshTimer(nil);

end;

procedure TCashRegManager.BtnPettyCashClick(Sender: TObject);
begin
  inherited;

  if not Password.HasFuncRight(61) then
     begin
     MsgBox(MSG_CRT_NO_MAKE_PETTY_CASH, vbCritical + vbOkOnly);
     Exit;
     end;

  // Troca de Petty Cash
  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    with TCashRegPetty.Create(Self) do
      Start(MyIDCashRegMov, OP_PETTY_CASH);
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;

end;

procedure TCashRegManager.BtnCloseCashClick(Sender: TObject);
var
  IDCashReg : integer;
begin
  inherited;

  if not Password.HasFuncRight(59) then
     begin
     MsgBox(MSG_CRT_NO_CLOSE_CASH_REGISTER, vbCritical + vbOkOnly);
     Exit;
     end;


  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    with TCashRegClose.Create(Self) do
    begin
      Start(MyIDCashRegMov, iParamScreenType);
      if (DM.CheckCashRegState(MyIDCashReg, IDCashReg) = CASHREG_CLOSE) then
        Self.Close;
    end;
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;
end;

procedure TCashRegManager.BtnUnlockHoldClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // chama unlock
  with TFrmEditPreSale.Create(Self) do
    Start(SALE_UNLOCK_PRESALE);

  Screen.Cursor := crDefault;

end;

procedure TCashRegManager.BtnInventoryClick(Sender: TObject);
begin
  inherited;

  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    with TQueryInventory.Create(Self) do
      ShowModal;
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;

end;

procedure TCashRegManager.CallShortCut(IDMenu, IDSubMenu : Integer);
begin
  try
    fImgOld   := DM.fMainMenu.Image;
    fsMenu    := DM.fMainMenu.MenuName;
    fsSubMenu := DM.fMainMenu.SubMenuName;

    MainMenu.IDMenu    := IDMenu;
    MainMenu.IDSubMenu := IDSubMenu;
    MainMenu.SubMenuClick(nil);
  finally
    OnAfterShortClick;
    end;
end;


procedure TCashRegManager.btnSalesRequestClick(Sender: TObject);
begin
  inherited;
  CallShortCut(2,3);
end;

procedure TCashRegManager.btnTimeClockClick(Sender: TObject);
begin
  inherited;
  CallShortCut(9,2);
end;

procedure TCashRegManager.btnCustomerClick(Sender: TObject);
begin
  inherited;
  CallShortCut(2,6);
end;

procedure TCashRegManager.btnInvoicesClick(Sender: TObject);
begin
  inherited;
  CallShortCut(1,3);
end;

procedure TCashRegManager.sbSetupCashRegClick(Sender: TObject);
begin
  inherited;
  try
    fImgOld   := DM.fMainMenu.Image;
    fsMenu    := DM.fMainMenu.MenuName;
    fsSubMenu := DM.fMainMenu.SubMenuName;

    MainMenu.IDMenu       := 8;
    MainMenu.IDSubMenu    := 6;
    MainMenu.FchParamType := TSpeedButton(Sender).Tag;
    MainMenu.SubMenuClick(nil);
  finally
    OnAfterShortClick;
    end;

end;

procedure TCashRegManager.OnAfterShortClick;
begin
  MainMenu.IDMenu         := 1;
  MainMenu.IDSubMenu      := 1;
  DM.fMainMenu.Image      := fImgOld;
  DM.fMainMenu.MenuName   := fsMenu;
  DM.fMainMenu.SubMenuName:= fsSubMenu;
end;


procedure TCashRegManager.btnSetupTicketClick(Sender: TObject);
begin
  inherited;
  //Store
  if not Password.CanAccessMenu(8, 1, DM.fUser.Password) then
     begin
     MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
     Exit;
     end;

  //Show ticket info
  with TSubTicketInfo.Create(Self) do
     begin
     Param := 'IDStore='+IntToStr(DM.fStore.ID)+';';
     ShowModal;
     Free;
     end;
end;

procedure TCashRegManager.btnFullInvClick(Sender: TObject);
begin
  inherited;
  CallShortCut(5,1);
end;

procedure TCashRegManager.btnPOClick(Sender: TObject);
begin
  inherited;
  CallShortCut(4,2);
end;

procedure TCashRegManager.btnShowConfigClick(Sender: TObject);
begin
  inherited;
  if btnShowConfig.Tag = 1 then
  begin
    btnShowConfig.Caption := sShowConfig;
    pnlHoldDisplay.Height := PPC.Height - 20;
    btnShowConfig.Tag := 0;
  end
  else
  begin
    btnShowConfig.Caption := sHideConfig;
    pnlHoldDisplay.Height := pnlSetup.Top;
    btnShowConfig.Tag := 1;
  end
end;

function TCashRegManager.NewHistory(IDHistoryType, IDPreSale: Integer;
     SaleCode:String; var sHistParam: String; var dInvDate : TDateTime): Boolean;
begin
  if FrmHistory = nil then
    FrmHistory := TFrmHistory.Create(Self);

  Result := FrmHistory.Start(IDHistoryType, IDPreSale, DM.fUser.ID, Date, SaleCode, sHistParam, dInvDate);
end;

function TCashRegManager.SaleConsult(IsClosedLayAway: Boolean): String;
begin
  if FrmSaleConsult = nil then
    FrmSaleConsult := TFrmSaleConsult.Create(Self);

  Result := FrmSaleConsult.Start(IsClosedLayAway);
end;

procedure TCashRegManager.imgOpenHoldClick(Sender: TObject);
begin
  inherited;
  BtnInvoiceClick(btnLayaway);
end;

procedure TCashRegManager.imgSearchHoldClick(Sender: TObject);
var
  sParametros: String;
  iPreSaleToOpen: Integer;
begin
  inherited;
  sParametros := SaleConsult(False);
  if sParametros <> '' then
  begin
  iPreSaleToOpen := StrToInt(ParseParam(sParametros, 'IDPRESALE'));
  Screen.Cursor := crHourGlass;

  OpenHold(iPreSaleToOpen);

  Screen.Cursor := crDefault;
  end;
end;

procedure TCashRegManager.imgFinalizeHoldClick(Sender: TObject);
var
  sParametros: String;
  bCanExec: Boolean;
  IDInvoice, IDPreSale: Integer;
  sHistParam, InvoiceCode: String;
  dInvoiceDate: TDateTime;
  iCFOP, iCarrier, iFreightType : Integer;
  cInvoiceTotal : Currency;
  IDError : Integer;
  ErrorMsg : String;
  sSaleCode : String;
begin
  sParametros := SaleConsult(True);

  if sParametros <> '' then
  begin
    try
      IDPreSale     := StrToInt(ParseParam(sParametros, 'IDPRESALE'));
      sSaleCode     := ParseParam(sParametros, 'SALECODE');
      cInvoiceTotal := StrToFloat(ParseParam(sParametros, 'TOTALINVOICE'));

      bCanExec := NewHistory(1, IDPreSale, sSaleCode, sHistParam, dInvoiceDate);
      dInvoiceDate := Trunc(dInvoiceDate) + Frac(Now);

      if bCanExec then
      begin
        InvoiceCode  := Trim(ParseParam(sHistParam, 'INVCODE'));
        iCFOP        := StrToIntDef(ParseParam(sHistParam, 'CFOP'), 0);
        iCarrier     := StrToIntDef(ParseParam(sHistParam, 'CARRIER'), 0);
        iFreightType := StrToIntDef(ParseParam(sHistParam, 'FTYPE'), 1);


        if not ProcessInvoiceBonus(IDPreSale, sSaleCode, cInvoiceTotal) then
          Exit;

        DM.ADODBConnect.BeginTrans;

        bCanExec := DM.fPOS.PreSalePay(IDPreSale,
                                      StrToInt(ParseParam(sParametros, 'IDTOURISTGROUP')),
                                      StrToInt(ParseParam(sParametros, 'OTHERCOMISSIONID')),
                                      MyIDCashRegMov,
                                      DM.fStore.ID,
                                      Now,
                                      dInvoiceDate, //DueDate
                                      0, //CashReceived
                                      DM.FBonusSync.BonusValue,
                                      DM.FBonusSync.BonusCode,
                                      IDInvoice);

        //Atualizo o novo numero do invoice informado pelo cliente
        if bCanExec then
        begin
          bCanExec := UpdateInvoiceCode(InvoiceCode, IDPreSale, iCFOP, iCarrier, iFreightType);

          if bCanExec then
           DM.ADODBConnect.CommitTrans
          else
           DM.ADODBConnect.RollbackTrans;
        end;
       end;

      if not bCanExec then
      begin
        if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
        begin
          ErrorMsg := '';
          IDError := 0;
          DM.BonusVoid(DM.FBonusSync.BonusCode, IDError, ErrorMsg);
        end;
      end
      else if (DM.fPrintReceipt.PrintReceipt) then
       with TPrintReceipt.Create(Self) do
          Start(IDPreSale, RECEIPT_TYPE_LAYAWAY_RECEIVE);

    except
       on E: exception do
       begin
         DM.SetError(CRITICAL_ERROR, 'CashRegister.FinalizeHold', E.Message);
         MsgBox(MSG_CRT_ERROR_OCURRED, vbOkOnly+vbCritical);
       end;
    end;
  end;
end;

procedure TCashRegManager.imgCloseDayClick(Sender: TObject);
begin
  inherited;
  BtnCloseCashClick(BtnCloseCash);
end;

procedure TCashRegManager.InvoiceOptions;
begin
  //Budget
  imgBudget.Visible       := DM.fInvoice.DisplayBudget;
  lbBudget.Visible        := imgBudget.Visible;
  imgSeta1.Visible        := imgBudget.Visible;
  //Create Hold
  imgOpenHold.Visible     := DM.fInvoice.DisplayHold;
  lbOpenHold.Visible      := imgOpenHold.Visible;
  //Search Hold
  imgSearchHold.Visible   := DM.fInvoice.DisplaySearch;
  lbSearchHold.Visible    := imgSearchHold.Visible;
  imgSeta2.Visible        := lbSearchHold.Visible;
  //Close Day
  imgCloseDay.Visible     := DM.fInvoice.DisplayHold;
  lbCloseDay.Visible      := imgCloseDay.Visible;
  //Create Hold POS
  imgOpenPOSHold.Visible  := DM.fInvoice.DisplayPOSHold;
  lbOpenPOSHold.Visible   := imgOpenPOSHold.Visible;
  //Finalize
  if imgFinalizeHold.Visible then
     begin
     imgFinalizeHold.Visible  := DM.fInvoice.DisplayFinalize;
     lbFinalizeHold.Visible   := imgFinalizeHold.Visible;
     imgSeta3.Visible         := imgFinalizeHold.Visible;
     imgPrintDelivery.Visible := imgFinalizeHold.Visible;
     lbPrintDelivery.Visible  := imgFinalizeHold.Visible;
     end;

end;

procedure TCashRegManager.sbShowShotCutsClick(Sender: TObject);
begin
  inherited;
  pnlShortCutInv.Visible := not pnlShortCutInv.Visible;
  if pnlShortCutInv.Visible then
     sbShowShotCuts.Caption := '-'
  else
     sbShowShotCuts.Caption := '+';
end;

procedure TCashRegManager.imgConsultHoldClick(Sender: TObject);
begin
  inherited;
  //Display consult Hold
  with TFrmConsultHold.Create(Self) do
      Start;
end;

procedure TCashRegManager.CreateOfficeShortCuts;
var
  iCount, LastTop : Integer;
  NamePrefix : String;
begin

 with quCommand do
   begin
   try
     If Active then
        Close;
     Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
     Open;
     pnlShorCuts.Height := 231;

     If not IsEmpty then
        begin
        Label13.Visible    := True;
        First;
        iCount  := 1;
        LastTop := Label13.Top;
        While not EOF do
          begin
          NamePrefix := 'btnSystem';
          TSpeedButton.Create(Self).Name := NamePrefix + IntToStr(iCount);
          with TSpeedButton(Self.FindComponent(NamePrefix+IntToStr(iCount))) do
             begin
             Parent     := pnlShortCutInv;
             Left       := 1;
             Top        := LastTop+18;
             LastTop    := Top;
             Flat       := True;
             Width      := 155;
             Height     := 18;
             Margin     := 2;
             Font.Color := clWhite;
             Font.Name  := 'Tahoma';
             Font.Size  := 8;
             Caption    := quCommandName.AsString;
             Hint       := quCommandCmdLine.AsString;
             OnClick    := CallShellAPI;
             end;
          Inc(iCount);
          Next;
          end;
        pnlShorCuts.Height := pnlShorCuts.Height+(19*(iCount-1));
        end;
   finally
     Close;
     end;
   end;

end;

procedure TCashRegManager.CallShellAPI(Sender: TObject);
begin
  ExecuteFile(Trim(TSpeedButton(Sender).Hint), '', '', SW_SHOW);
end;

procedure TCashRegManager.imgBudgetClick(Sender: TObject);
begin
  inherited;
  with TFrmEstimated.Create(Self) do
    StartImport(FrmInvoice, MyIDCashRegMov);
end;

function TCashRegManager.UpdateInvoiceCode(fInvoiceCode : String;
  fIDPreSale, fCFOP, fCarrier, fFreightType: Integer): Boolean;
begin

  Result := True;

  try
  
    if (fInvoiceCode <> '') then
      with quUpdateInvoice do
      begin
        Parameters.ParamByName('InvoiceCode').Value := fInvoiceCode;
        Parameters.ParamByName('IDPreSale').Value   := fIDPreSale;
        ExecSQL;
      end;

    if (fCFOP <> 0) or (fCarrier <> 0) then
    with quInvoiceOBS do
    try
      if not Active then
      begin
        Parameters.ParamByName('IDPreSale').Value := fIDPreSale;
        Open;
      end;

      if IsEmpty then
      begin
        Append;
        FieldByName('IDInvoiceOBS').AsInteger := DM.GetNextID('InvoiceOBS.IDInvoiceOBS');
        FieldByName('IDPreSale').AsInteger    := fIDPreSale;
      end
      else
        Edit;

      FieldByName('IDCFOP').AsInteger      := fCFOP;
      FieldByName('FreightType').AsInteger := fFreightType;
      FieldByName('IDCarrier').AsInteger   := fCarrier;
      Post;

    finally
      Close;
    end;

  except
    raise;
    Result := False;
  end;

end;

procedure TCashRegManager.imgPrintDeliveryClick(Sender: TObject);
begin
  inherited;
  //Print Delivery
  with TFrmPrintDeliveryList.Create(Self) do
     Start;
end;

procedure TCashRegManager.btnCustomerRepairClick(Sender: TObject);
begin
  inherited;
  CallShortCut(2,5);
end;

procedure TCashRegManager.btnCancelHoldClick(Sender: TObject);
begin
  inherited;
  CallShortCut(2,4);
end;

procedure TCashRegManager.imgLogOutClick(Sender: TObject);
begin
  inherited;
  MainMenu.lblOdblClickClick(Self);
  imgLogOut.Visible := False;
end;

procedure TCashRegManager.btnComissionClick(Sender: TObject);
begin
  inherited;
  CallShortCut(6,1);
end;

procedure TCashRegManager.btnPrintInvClick(Sender: TObject);
begin
  inherited;
  with TFrmInventoryList.Create(Self) do
     Start; 
end;

procedure TCashRegManager.btnMessageClick(Sender: TObject);
begin
  inherited;

  if DM.fUser.ID <> -1 then
     with TFrmUserMessager.Create(Self) do
         Start;

end;

procedure TCashRegManager.grdCashEnter(Sender: TObject);
begin
  inherited;
  SelectHold;
end;

procedure TCashRegManager.grdCashDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  if BtnOpenHold.Enabled then
    BtnOpenHoldClick(nil);

  Screen.Cursor := crDefault;
end;

procedure TCashRegManager.imgOpenPOSHoldClick(Sender: TObject);
var
  InvoiceType : Integer;
begin
  inherited;
  InvoiceType := TSpeedButton(Sender).Tag;

  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     begin
     with FrmNewPreSales do
          Start(0, InvoiceType, False);
     rgFaixaClick(nil);
     end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;
end;

procedure TCashRegManager.imbShippingInvoiceClick(Sender: TObject);
begin
  inherited;
  with TFrmShippingDistrubSale.Create(Self) do
    Start(SALE_CASHREG, MyIDCashRegMov);
end;

procedure TCashRegManager.imgTrackPackageClick(Sender: TObject);
begin
  inherited;
  with TFrmTrackPackage.Create(Self) do
    Start;
end;

procedure TCashRegManager.btnAddCashClick(Sender: TObject);
begin
  inherited;

  if not Password.HasFuncRight(61) then
     begin
     MsgBox(MSG_CRT_NO_MAKE_PETTY_CASH, vbCritical + vbOkOnly);
     Exit;
     end;

  // Troca de Petty Cash
  tmrRefresh.Enabled := False;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    with TCashRegPetty.Create(Self) do
      Start(MyIDCashRegMov, OP_ADD_CASH);
  end;

  Screen.Cursor := crDefault;

  tmrRefresh.Enabled := True;
end;

procedure TCashRegManager.btnBudgetClick(Sender: TObject);
begin
  inherited;
  with TFrmEstimated.Create(Self) do
    Start;
end;

procedure TCashRegManager.quPreSaleCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quPreSaleIDPessoa.AsInteger in [0,1] then
  begin
    if quPreSaleFirstName.AsString <> '' then
      quPreSalePessoa.AsString := quPreSaleFirstName.AsString + ' ' + quPreSaleLastName.AsString
    else
      quPreSalePessoa.AsString := '';
  end
  else
    quPreSalePessoa.AsString := quPreSaleCustomer.AsString;
end;

procedure TCashRegManager.btnStoreAccountClick(Sender: TObject);
begin
  inherited;
  with TFrmStoreAccount.Create(Self) do
    Start(MyIDCashRegMov, 0);
end;

function TCashRegManager.ProcessInvoiceBonus(iIDPreSale : Integer; sInvoiceNum :
  String; cTotalInvoice: Currency): Boolean;
var
  BonusBucks: TBonusBucks;
  cDiscountValue: Currency;
  BonusCode : String;
  IDError : Integer;
  ErrorMsg : String;
begin
  DM.FTraceControl.TraceIn('TCashRegManager.ProcessInvoiceBonus');

  Result := True;
  try
      BonusCode := '';
      DM.FBonusSync.BonusCode := '';
      DM.FBonusSync.BonusValue := 0;

      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      try
        BonusBucks                  := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
        BonusBucks.IDPreSaleCreated := iIDPreSale;
        cDiscountValue              := BonusBucks.DiscountValue;
        sInvoiceNum                 := sInvoiceNum;

        if cDiscountValue > 0 then
          if not DM.BonusGenerate(cTotalInvoice, cDiscountValue, sInvoiceNum, Trunc(Now), BonusCode, IDError, ErrorMsg) then
          begin
            DM.FBonusSync.BonusValue := 0;
            if (MsgBox(MSG_QST_PROCESS_BONUS + ErrorMsg, vbYesNo + vbQuestion) = vbNo) then
            begin
              Result := False;
              Exit;
            end;
          end;

      finally
        FreeAndNil(BonusBucks);
      end;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'ProcessInvoiceBonus');
      Result := False;
    end;
  end;

  DM.FTraceControl.TraceOut;
  
end;

end.
