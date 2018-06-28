unit uMRPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, ComCtrls, DB, ADODB, DBGrids,
  SuperEdit, uParentAll, siComp, siLangRT, SMDBGrid, uPayments, uPreSale,
  uFormasPagamento, uFrmPOSFunctions, StrUtils, Math, uTefConsts,
  uTefDedicadoInterface, uTEFTypes, uInvoicePollDisplay, uBalanca;

const
  SALE_TYPE_SQL = 1;
  SALE_TYPE_TXT = 2;
  SALE_TYPE_XML = 3;

  HOLD_CLEAR            = 0;
  HOLD_DISCOUNT_PERCENT = 1;
  HOLD_DISCOUNT_VALUE   = 2;
  HOLD_ADSITION_PERCENT = 3;
  HOLD_ADDITION_VALUE   = 4;

  PDV_CUSTOMER_DEFAULT = 1;

  PDV_PRICE_DECIMAL_LENGTH = 2;

  SLEEP_FECHAR_CUPOM = 0; //Foi homologado com 300

type
  TFrmMRPDV = class(TFrmParentAll)
    pnlItems: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    pnlCustomer: TPanel;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image14: TImage;
    Image16: TImage;
    Image18: TImage;
    Image19: TImage;
    lbCashReg: TLabel;
    lbItems: TLabel;
    imgPDV: TImage;
    lbDay: TLabel;
    pnlItemControl: TPanel;
    pnlPaymentList: TPanel;
    lbOperator: TLabel;
    Panel1: TPanel;
    Image13: TImage;
    Image15: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    lbProdInfo: TLabel;
    lbSalePrice: TLabel;
    pnlPayments: TPanel;
    pnlSaleInfo: TPanel;
    lbDescription: TLabel;
    lbSubtotal: TStaticText;
    TmHour: TTimer;
    pnlSubtotal: TPanel;
    Label1: TLabel;
    lbTotal: TStaticText;
    lblCustomerName: TLabel;
    lbAddress: TLabel;
    Label4: TLabel;
    lblMedia: TLabel;
    lvwPayments: TListView;
    edtPayValue: TSuperEdit;
    edtBarcode: TSuperEdit;
    lbPayment: TLabel;
    Label5: TLabel;
    Payments: TPayments;
    PreSale: TPreSale;
    lvwItems: TListView;
    pnlDiscount: TPanel;
    lbDiscount: TLabel;
    edtDiscountValue: TSuperEdit;
    lbPDVHint: TLabel;
    lbMRInfo: TLabel;
    pnlAccessory: TPanel;
    Image17: TImage;
    Image20: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    lbAccessory: TLabel;
    lsbSuggestion: TListBox;
    lbFInfo: TLabel;
    pnlShortCut: TPanel;
    Panel2: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Image41: TImage;
    lbSCSearch: TLabel;
    Shape8: TShape;
    Panel11: TPanel;
    Image42: TImage;
    lbSCAddCustomer: TLabel;
    Shape9: TShape;
    Panel12: TPanel;
    Image43: TImage;
    lbSCNewSale: TLabel;
    Shape10: TShape;
    Panel13: TPanel;
    Image44: TImage;
    lbSCInvDisc: TLabel;
    Shape11: TShape;
    Panel14: TPanel;
    Image45: TImage;
    lbSCAddPayment: TLabel;
    Shape12: TShape;
    Panel16: TPanel;
    Image46: TImage;
    lbSCViewInvent: TLabel;
    Shape13: TShape;
    Panel17: TPanel;
    Image47: TImage;
    lbSCChangeUser: TLabel;
    Shape14: TShape;
    Panel3: TPanel;
    Image34: TImage;
    lbSCInvAdjust: TLabel;
    Shape1: TShape;
    pnlLayaway: TPanel;
    Image40: TImage;
    lbSCLayaway: TLabel;
    Shape7: TShape;
    Panel5: TPanel;
    Image36: TImage;
    lbSCExit: TLabel;
    Shape3: TShape;
    lbDisplay: TLabel;
    imgServerOut: TImage;
    imgServerRun: TImage;
    pnlSubTotalDisc: TPanel;
    lbSubDe: TStaticText;
    lbSubPor: TStaticText;
    pblInvoiceDiscount: TPanel;
    Label2: TLabel;
    lbTotalDiscount: TStaticText;
    pnlItemDiscount: TPanel;
    lbItemDiscount: TLabel;
    edtItemDiscValue: TSuperEdit;
    TefDedicadoInterface1: TTefDedicadoInterface;
    lblCliente: TLabel;
    pnlTEFDed: TPanel;
    lblOperador: TLabel;
    imgPoleOff: TImage;
    lbGavetaAberta: TLabel;
    pnlHelp: TPanel;
    imgHelp: TImage;
    lblHelp: TLabel;
    shpHelp: TShape;
    lbWithdraw: TLabel;
    lbRefundInfo: TLabel;
    lbDevolucao: TLabel;
    Panel4: TPanel;
    Image35: TImage;
    lbMenuFiscal: TLabel;
    Shape2: TShape;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TmHourTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPayValuePressEnter(Sender: TObject);
    procedure edtBarcodePressEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDiscountValuePressEnter(Sender: TObject);
    procedure PaymentsPartialPay(Payment: TPayment; Lista: TList;
      var Sucess: Boolean);
    procedure edtPayValueChange(Sender: TObject);
    procedure lvwItemsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvwItemsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PreSaleAfterAddPreSaleItem(PSI: TPreSaleItem;
      var Sucess: Boolean);
    procedure edtPayValueKeyPress(Sender: TObject; var Key: Char);
    procedure lbSCSearchClick(Sender: TObject);
    procedure lbSCSearchMouseLeave(Sender: TObject);
    procedure lbSCSearchMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbSCLayawayClick(Sender: TObject);
    procedure lbSCInvAdjustClick(Sender: TObject);
    procedure PreSaleBeforeDoInvoiceDiscount(ADiscountPerc: Currency;
      var AAccept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure PreSaleBeforeAddPreSaleItem(var PSI: TPreSaleItem;
      var Sucess: Boolean);
    procedure edtDiscountValueKeyPress(Sender: TObject; var Key: Char);
    procedure PreSaleItemDiscount(PSI: TPreSaleItem; var AAccept: Boolean);
    procedure edtItemDiscValuePressEnter(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando1(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando2(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando3(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando11(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando12(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando13(Sender: TObject);
    procedure TefDedicadoInterface1LimpaMsg(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando22(Sender: TObject;
      Msg: String);
    procedure imgPoleOffClick(Sender: TObject);
    procedure lbSCNewSaleClick(Sender: TObject);
    procedure lbMenuFiscalClick(Sender: TObject);
  private
    sProducts:           String;
    sNexCustomer:        String;
    sQtyBarcode:         String;
    sQtyModel:           String;
    sDiscountPer:        String;
    sDiscountDollar:     String;
    sAdditionPer:        String;
    sAdditionDollar:     String;
    sChange:             String;
    sNotInformed:        String;
    sNoChangeFor:        String;
    sNeedCustomer:       String;
    sRefund:             String;
    sRest:               String;
    sDiscountItemPer:    String;
    sDiscountItemDollar: String;
    sDiscItemPerHint:    String;
    sDiscItemDollarHint: String;
    sTmpUserName:        String;


    SaleHeaderSaved: Boolean;
    ClientSaved: Boolean;

    fItemDiscount:   String;

    fIDCashRegMov : Integer;
    fSearchItemMode : Integer;

    MeioPagamento : TMeioPagamento;

    SalesPersonInfo: TSalesPersonInfo;
    SellingItem:    TSellingItem;

    ApplyAllItemsDiscount : Boolean;

    dValor, dValorTotal: Double;

    FBalanca : TBalanca;

    FTotalCashSale : Currency;
    FTotalCashAllowed : Currency;

    bHasStoreAccout : Boolean;

    procedure PrintItems;

    procedure LoadCashInfo;
    procedure LoadPOSColor;

    procedure NewHold(APreSaleType: TPreSaleType = tptInvoice);
    procedure ClearHold;
    procedure CancelHold;
    function PayHold: Boolean;
    function PrintReceipt:Boolean;
    function HandleTEF(Print: Boolean) : Boolean;
    procedure RefreshTotal;
    procedure ChangeSearchItemMode;
    procedure HandleStoreAccount;

    procedure AddPayment(ATEFCallInfo : TTEFCallInfo = nil);
    procedure CallPayments;
    procedure CallDiscount;
    procedure CallItemDiscount;
    procedure ClearItemDiscount;
    function ChangePayment(Var ATEFCallInfo : TTEFCallInfo):Boolean;
    procedure SetPayment;
    procedure SetMeioPag(MP: TMeioPagamento);

    procedure ClearItem;
    procedure ShowBarcodeOption;
    function AddItem: Boolean;
    function SubAddItem(AIDCustomer, AIDModel, AIDStore, AIDUser,
                        AIDCommis: Integer; ADiscount, ASale, ACost: Currency; AQty : Double; ATaxValue,
                        APercMaxDisc: Currency; AMovDate, ADate: TDateTime;
                        AResetDisc, AManager: Boolean; ADescription, AECFTaxIndex, AModel,
                        AImagePath: String; APuppyTracker, ARequestCustomer: Boolean;
                        ACaseQty: Double; AIDDepartment, AIDVendorPrice, AIDDescriptionPrice: Integer;
                        ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentType: Integer;
                        ASerialNumber, AIdentificationNumber: String; ATotalInformed : Currency;
                        ATotParcial, AUnidade: String): Boolean;
    procedure DeleteCupomItems(IDUserAuto:Integer);
    procedure DeleteItem(IDUserAuto:Integer);
    procedure SaveInvObs(AOBS : String);
    procedure RefreshItem;
    procedure RefreshItemInfo(Item : TListItem);
    function ValidadeItem(var Barcode, Qty : String):Boolean;
    procedure RefreshChange;

    procedure ExitPDV;

    procedure RefreshDateTime;
    function AbreCupom: String;
    function RemovePontoVirgula(S: String): String;
    function FechaFiscal(): Boolean;
    function ValidateDiscount(var Code: String; var Value: Currency;
      var cType, cOperat: Char): Boolean;
    function CalcDiscount(SaleValue, dDiscount: Currency; Qty: Double; cDiscOperat,
      cDiscType: char): Currency;
    procedure RefreshPreSaleInfo(AShow: Boolean);

    function SavePreSale: Boolean;
    function SavePreSaleItem(Item: TPreSaleItem): Boolean;
    function SavePreSaleItemSerial(Item: TPreSaleItem; ItemSerial: TPreSaleItemSerial): Boolean;
    function SavePreSalePayment(Payment: TPayment): Boolean;
    function SavePay: Boolean;
    function SaveDeletedItem(Position: Integer; Item: TPreSaleItem; IDUserAuto:Integer; iPos : Integer): Boolean;
    function SaveAbortaPreSale(Cupom : String): Boolean;
    function SaveClient: Boolean;

    procedure CreateDefaults;
    function CancelaCupom(Exibir: Boolean = False): Boolean;
    function TentaDeNovo: Boolean;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    procedure LoadPDVImage(ImagePath:String);

    procedure BuildSuggestItems;
    procedure ClearSuggestItems;

    procedure StartOptions(iFunction:Integer);
    function AddCustomer: Boolean;
    function AddCustomerIfNeeded(ACheckItem: Boolean = True): Boolean;
    function UsaECF: Boolean;
    procedure RefreshServerConnection;
    procedure RefreshPoleDisplayConnection;
    function OpenHold: Boolean;
    function PrintItem(var PSI: TPreSaleItem): Boolean;
    function HasCupom: Boolean;
    function TestFiscal: Boolean;
    procedure MsgInvalidOperation;
    function TestFiscalToogle: Boolean;
    function GetCupomMessage: String;
    function AddSerial(IDModel : Integer; Qty : Double) : Boolean;
    procedure GetChoosedPrice(IDStore, IDModel: Integer; var IDVendorPrice: Integer;
      var IDDescriptionPricecSuggPrice: Integer; var SuggPrice: Currency;
      var SellingPrice: Currency);
    function HasTablePrice(IDStore, IDModel: Integer): Boolean;
    procedure GetEnteredDocument(var ADocumentNumber: String; var AIDDocumentNumber: Integer);

    procedure RefreshDiscountItems;
    function VerificaGaveta : Boolean;
    function RebuildTextSale: Boolean;
    procedure AbrirBalanca;
    procedure FecharBalanca;
    function MontaValor(pValor:String): Double;
    procedure VerifyCashOverFlow;
    function VerificaBalanca: Boolean;
    function CorrigirQtyFracionaria(AQty : String) : Double;
    function ValidaDescricaoItemPDV(ADescricao : String) : Boolean;
  public
    CupomAberto: String;
    procedure AppMessage(var Msg: TMSG; var HAndled: Boolean);
    function Start(IDCashRegMov: Integer): Boolean;
  end;

implementation

uses uSystemConst, uDM, uMsgBox, uMsgConstant, uDMGlobal, uNumericFunctions,
     uMRPDVConfigKey, uDMPDV, uFrmPDVPayments, EFiscal, uFrmSearchOption,
     uUserObj, uFrmEnterPayments, uPassword, uPrintReceipt, UFrmAskPrice,
     uQueryInventory, uStringFunctions, uFrmInvoiceObs, uCharFunctions,
     uFrmImportPreSale, uFrmAskSalesPerson, uFileFunctions, uFrmTEFOptions,
     uFrmAskDocument, uFrmScaleInfo, DBClient, uValidaDocs, uTefDial,
     uFrmMenufiscal;

{$R *.dfm}

function TFrmMRPDV.UsaECF: Boolean;
begin
  Result := (DM.fCashRegister.Fiscal and (PreSale.PreSaleType = tptInvoice)) or HasCupom;
end;

procedure TFrmMRPDV.StartOptions(iFunction:Integer);
var
  oSearch: TObject;
  IsPreDatado, IsMagnetico, UsaCDC: Boolean;
  sModel : String;
  IDUserAuth: Integer;
  ATEFCallInfo : TTEFCallInfo;
begin

   case iFunction of
     FUNC_HELP:
     with TFrmMRDPVConfigKey.Create(Self) do
     begin
       StartHelp;
       Free;
     end;

     FUNC_OPEN_HOLD:
     begin
       OpenHold;
     end;

     FUNC_ADD_CUSTOMER:
     begin
       AddCustomer;
     end;

     FUNC_ADD_OBSERVATION:
     begin
       with TFrmInvoiceObs.Create(Self) do
           PreSale.InvObs := Start(PreSale.InvObs);

       SaveInvObs(PreSale.InvObs);
     end;

     FUNC_FINALIZE_SALE:
     begin
       if PreSale.Count = 0 then
         Exit;

       if (pnlPayments.Visible) and (Payments.Count = 0) then
       begin
         ClearItem;
         Exit;
       end;

       CallPayments;
     end;

     FUNC_ITEM_DISCOUNT:
     begin
      if (Payments.Count > 0) then
         Exit;

      if not pnlDiscount.Visible then
        if not Password.AquireAccess(83, 'Usuário não tem permissão para dar desconto no Item!_Ativar função 83 do Tipo de Usuário.', IDUserAuth) then
         Exit;

      CallItemDiscount;
     end;

     FUNC_CREATE_NEW_SALE:
     begin
       if not TestFiscalToogle then
         Exit;

       if PreSale.Count > 0 then
       begin

         if not Password.AquireAccess(88, 'Usuário não tem permissão para sair da venda!_Ativar função 88 do Tipo de Usuário.', IDUserAuth) then
           Exit;

          if (MsgBox(MSG_QST_CANCEL_HOLD, vbYesNo + vbQuestion) = vbNo) then
            Exit
          else
            DeleteCupomItems(SalesPersonInfo.IDUser);
            
       end;

       if (PreSale.IDPreSale <> -1) and (DM.PersistenceType = ptTXT) then
         if not DM.DatabaseOpenConnection then
           MsgBox(MSG_CRT_NO_CONNECT_SERVER, vbCritical + vbOkOnly)
         else
           DM.DecHold(PreSale.IDPreSale);

       NewHold;
       ClearItem;
     end;

     FUNC_DEL_ITEM:
     begin
       if not pnlPayments.Visible then
       begin
         if not TestFiscalToogle then
           Exit;
         if not Password.AquireAccess(66, 'Usuário não tem permissão para excluir item da nota!_Ativar função 66 do Tipo de Usuário.', IDUserAuth) then
           Exit;

         DeleteItem(IDUserAuth);
       end;
     end;

     FUNC_EXIT:
     begin
       if PreSale.Count > 0 then
       begin

         if not Password.AquireAccess(88, 'Usuário não tem permissão para sair da venda!_Ativar função 88 do Tipo de Usuário.', IDUserAuth) then
           Exit;

         if (MsgBox(MSG_QST_CANCEL_HOLD, vbYesNo + vbQuestion) = vbNo) then
           Exit
         else
           DeleteCupomItems(SalesPersonInfo.IDUser);
       end;

       ExitPDV;
     end;

     FUNC_CALL_PAYMENT_TYPES:
     begin
       try
         ATEFCallInfo := TTEFCallInfo.Create;
         if pnlPayments.Visible then
            if ChangePayment(ATEFCallInfo) then
               AddPayment(ATEFCallInfo);
       finally
         FreeAndNil(ATEFCallInfo);
       end;
     end;

     FUNC_SEARCH_OPTION:
     begin
       if pnlPayments.Visible then
          Exit;
       with TFrmSearchOption.Create(Self) do
       begin
         if Start(oSearch) and (oSearch <> nil) then
         with PreSale.PreSaleInfo do
         begin
           if oSearch is TCustomerInfo then
           begin
             CustomerInfo := TCustomerInfo(oSearch);
             SaveClient;
           end;

           if oSearch is TMediaInfo then
             MediaInfo := TMediaInfo(oSearch);

           if oSearch is TSalesPersonInfo then
              begin
              SalesPersonInfo            := TSalesPersonInfo(oSearch);
              DM.fUser.ID                := SalesPersonInfo.IDUser;
              DM.fUser.UserName          := SalesPersonInfo.UserName;
              DM.fUser.IDCommission      := SalesPersonInfo.IDCommission;
              DM.fUser.IDCommissionType  := SalesPersonInfo.IDCommissionType;
              LoadCashInfo;
              end;

           if oSearch is TSellingItem then
           begin
             fSearchItemMode := ITEM_MODE_QTY_MODEL;
             SellingItem.Model := TSellingItem(oSearch).Model;
             if (Trim(edtBarcode.Text) = sQtyBarcode) or
                (Trim(edtBarcode.Text) = sQtyModel) then
               edtBarcode.Text := '';
             edtBarcode.Text := edtBarcode.Text + SellingItem.Model;
             edtBarcodePressEnter(edtBarcode);
           end;

           RefreshPreSaleInfo((CustomerInfo <> nil) or (MediaInfo <> nil));
         end;
         Free;
       end;
     end;

    FUNC_APPLY_HOLD_DISCOUNT:
    begin
      if (Payments.Count > 0) then
         Exit;
      if (PreSale.Count = 0) then
         Exit;
      //if (PreSale.DiscountTotal > 0) and (PreSale.InvoiceDiscount = 0) then
      //   Exit;

      if not TestFiscalToogle then
        Exit;

      {
      if (UsaECF) and (PreSale.PrintedCount > 0) and (PreSale.DiscountTotal > 0) then
      begin
        MsgInvalidOperation;
        Exit;
      end;
      }
      
      if not pnlDiscount.Visible then
        if not Password.AquireAccess(41, 'Usuário não tem permissão para dar desconto!_Ativar função 41 do Tipo de Usuário.', IDUserAuth) then
         Exit;

      CallDiscount;
    end;

    FUNC_CHANGE_USER:
    begin
      if Password.PermanentLogOn then
         Password.PermanentLogOn := False;
      if Password.Start(1,1) then
         LoadCashInfo;
    end;

    FUNC_VIEW_INVENTORY:
    begin
      if pnlPayments.Visible then
         Exit;

      with TQueryInventory.Create(Self) do
         if Start(sModel) then
            begin
            fSearchItemMode := ITEM_MODE_QTY_MODEL;
            if (Trim(edtBarcode.Text) = sQtyBarcode) or
               (Trim(edtBarcode.Text) = sQtyModel) then
                 edtBarcode.Text := '';
            edtBarcode.Text := edtBarcode.Text + sModel;
            edtBarcodePressEnter(edtBarcode);
            end;
    end;

    FUNC_CREATE_NEW_REFUND:
    begin
      if Password.HasFuncRight(52) then
      begin
        if PreSale.Count > 0 then
        begin

          if not Password.AquireAccess(88, 'Usuário não tem permissão para sair da venda!_Ativar função 88 do Tipo de Usuário.', IDUserAuth) then
            Exit;

          if not TestFiscalToogle then
            Exit;

          if (MsgBox(MSG_QST_CANCEL_HOLD, vbYesNo + vbQuestion) = vbNo) then
            Exit
          else
            DeleteCupomItems(SalesPersonInfo.IDUser);

        end;
      NewHold(tptRefund);
      ClearItem;
      end
      else
        MsgBox('Usuário não tem permissão para fazer devolução!_Ativar função 52 do Tipo de Usuário.', vbOKOnly + vbInformation);
    end;

    FUNC_NO_SALE:
    begin
      if Password.HasFuncRight(65) then
        DM.EFiscal1.AbreGaveta
      else
        MsgBox('Usuário não tem permissão para abrir gaveta!_Ativar função 65 do Tipo de Usuário.', vbOKOnly + vbInformation);
        
      VerificaGaveta;
    end;


    FUNC_TEF:
    begin
      if (DM.fCashRegister.FiscalPrinter and (DM.fCashRegister.UseTef <> TEF_NONE)) then
        if (PreSale.Count = 0) and TestFiscalToogle then
          with TFrmTEFOptions.Create(Self) do
            Start;
    end;
    FUNC_SALE:
    begin
      Application.HelpContext(80);    
    end;
   end;
end;

function TFrmMRPDV.OpenHold: Boolean;
var
  sHoldNumber : String;
  iHoldOpen : Integer;
begin
  Result := False;
  if UsaECF then
    if not DM.fModuloFiscal.ValidateSystemDate then
      Exit;

  if PreSale.Count <> 0 then
    Exit;

  try
    with TFrmImportPreSale.Create(Self) do
        sHoldNumber := Start;

    if Trim(sHoldNumber) = '' then
       Exit;

    if not DM.DatabaseOpenConnection then
       begin
       MsgBox(MSG_CRT_NO_CONNECT_SERVER, vbCritical + vbOkOnly);
       Exit;
       end;

    // Validar qtd negativa
    if DM.fCashRegister.BlockNegativeSale then
      if (PreSale.PreSaleType in [tptInvoice, tptLayAway]) then
        if (not DMPDV.SellNegative) and (not Password.HasFuncRight(8)) then
          if DM.NegativeQty(sHoldNumber) then
          Begin
            MsgBox('Existem produtos com estoque negativo !', vbOKOnly + vbInformation);
            Exit;
          end;

    if not DM.OpenHold(sHoldNumber) then
       begin
       MsgBox('Pedido não encontrado ou inválido!_Verificar se tem pagamento ou item negativo.', vbCritical + vbOkOnly);
       Exit;
       end;

    //Verificar se esta eberto em outro caixa
    iHoldOpen := DM.fPOS.VerifyOpenHold(DM.quPreSaleIDPreSale.AsInteger);
    if iHoldOpen = 1 then
    begin
      MsgBox(MSG_INF_HOLD_IS_USING, vbOKOnly + vbInformation);
      Exit;
    end
    else if iHoldOpen = 2 then
    begin
      MsgBox(MSG_INF_HOLD_PAYING, vbOKOnly + vbInformation);
      Exit;
    end;

    if (Trunc(DM.quPreSalePreSaleDate.AsDateTime) > Trunc(Now)) then
    begin
      MsgBox('Data do pedido invalida!', vbOKOnly + vbInformation);
      Exit;
    end;

    //Marcar o Hold como sendo pago
    DM.IncHold(DM.quPreSaleIDPreSale.AsInteger);

    //Cria os valores default
    CreateDefaults;

    //Preencher o presala
    with PreSale do
    begin
      IDPreSale                               := DM.quPreSaleIDPreSale.AsInteger;
      PreSaleInfo.CustomerInfo.IDCustomer     := DM.quPreSaleIDCustomer.AsInteger;
      PreSaleInfo.CustomerInfo.FirstName      := DM.quPreSalePessoa.AsString;
      PreSaleInfo.CustomerInfo.Endereco       := DM.quPreSaleEndereco.AsString;
      PreSaleInfo.CustomerInfo.Bairro         := DM.quPreSaleBairro.AsString;
      PreSaleInfo.CustomerInfo.Cidade         := DM.quPreSaleCidade.AsString;
      PreSaleInfo.CustomerInfo.CPF            := DM.quPreSaleCPF.AsString;
      PreSaleInfo.CustomerInfo.Telefone       := DM.quPreSaleTelefone.AsString;
      SaleCode                                := DM.quPreSaleSaleCode.AsString;
      IDStore                                 := DM.fStore.ID;
      IDOtherComiss                           := DM.quPreSaleOtherComissionID.AsInteger;
      DeliverType                             := DM.quPreSaleDeliverTypeID.AsInteger;
      PreSaleInfo.MediaInfo.IDMedia           := DM.quPreSaleMediaID.AsInteger;
      PreSaleInfo.MediaInfo.MediaName         := DM.quPreSaleMedia.AsString;
      PreSaleInfo.TouristGroup.IDTouristGroup := DM.quPreSaleIDTouristGroup.AsInteger;
      TaxExempt                               := DM.quPreSaleTaxIsent.AsBoolean;
      IsLayaway                               := DM.quPreSaleLayaway.AsBoolean;
      PreSaleDate                             := DM.quPreSalePreSaleDate.AsDateTime;
      InvObs                                  := 'Nº pedido ' + DM.quPreSaleSaleCode.AsString + '. ' + DM.quPreSaleNote.AsString;
      InvoiceDiscount                         := DM.quPreSaleInvoiceDiscount.AsCurrency;
      Imported                                := True;
      Sleep(15);
    end;

    SaveInvObs(PreSale.InvObs);

    //Preencher os itens do PreSale
    with DM.quPreSaleItem do
    begin
      First;
      while not EOF do
      begin
        SubAddItem(1,
                   DM.quPreSaleItemModelID.AsInteger,
                   DM.fStore.ID,
                   DM.quPreSaleItemUserID.AsInteger,
                   DM.GetCommission(DM.quPreSaleItemIDPreInventoryMov.AsInteger),
                   DM.quPreSaleItemDiscount.AsCurrency,
                   DM.quPreSaleItemSalePrice.AsCurrency,
                   DM.quPreSaleItemCostPrice.AsCurrency,
                   DM.quPreSaleItemQty.AsFloat,
                   DM.quPreSaleItemTaxValue.AsCurrency,
                   DM.quPreSaleItemMaxDiscount.AsCurrency,
                   DM.quPreSaleItemMovDate.AsDateTime,
                   Now,
                   False,
                   True,
                   DM.quPreSaleItemDescription.AsString,
                   DMPDV.GetECFTaxIndex(DM.quPreSaleItemIDTaxCategory.AsInteger),
                   DM.quPreSaleItemModel.AsString,
                   DM.quPreSaleItemLargeImage.AsString,
                   DM.quPreSaleItemPuppyTracker.AsBoolean,
                   DM.quPreSaleItemRequestCustomer.AsBoolean,
                   DM.quPreSaleItemCaseQty.AsFloat,
                   DM.quPreSaleItemIDDepartment.AsInteger,
                   DM.quPreSaleItemIDVendor.AsInteger,
                   DM.quPreSaleItemIDDescriptionPrice.AsInteger,
                   DM.quPreSaleItemSuggPrice.AsCurrency,
                   DM.quPreSaleItemDocumentNumber.AsString,
                   DM.quPreSaleItemIDDocumentType.AsInteger,
                   DM.GetSerialNumber(DM.quPreSaleItemIDPreInventoryMov.AsInteger),
                   DM.GetIdentificationNumber(DM.quPreSaleItemIDPreInventoryMov.AsInteger),
                   0,
                   DMPDV.GetTotalizadorParcial(DM.quPreSaleItemIDTaxCategory.AsInteger),
                   DM.quPreSaleItemSigla.AsString);
        Next;
      end;
    end;

    Result := True;

    //Atualiza os itens
    RefreshItem();

    //Visualiza as informacoes
    RefreshPreSaleInfo(True);



  finally
    DM.CloseHold;
  end;
end;

function TFrmMRPDV.AddSerial(IDModel : Integer; Qty : Double): Boolean;
var
  oSearch: TObject;
  iNumberEntered : Double;
begin

  DMPDV.OpenInvSerial(IDModel);
  iNumberEntered := 0;

  with TFrmSearchOption.Create(Self) do
  try
     while iNumberEntered < Qty do
     begin
       if StartOption(OP_SERIAL, oSearch, DM.fSystem.SrvParam[PARAM_USE_IDENT_NUMBER_SERIAL]) and (oSearch <> nil) then
       begin
          with PreSale.Items[PreSale.Count-1] do
            if (oSearch is TPreSaleItemSerial) and (TPreSaleItemSerial(oSearch).SerialNumber <> '') then
            begin
              AddSerialNumber(TPreSaleItemSerial(oSearch));
              SavePreSaleItemSerial(PreSale.Items[PreSale.Count-1], TPreSaleItemSerial(oSearch));
              iNumberEntered := iNumberEntered + 1;
            end;
       end;
     end;
     Result := True;
  finally
    Free;
  end;

  DMPDV.CloseInvSerial;

end;


function TFrmMRPDV.AddCustomer: Boolean;
var
  oSearch: TObject;
begin
  Result := False;

  with TFrmSearchOption.Create(Self) do
  try
     if StartOption(OP_CUSTOMER, oSearch) and (oSearch <> nil) then
        with PreSale.PreSaleInfo do
           begin
           if oSearch is TCustomerInfo then
              CustomerInfo := TCustomerInfo(oSearch);
           RefreshPreSaleInfo((CustomerInfo<>nil));
           Result := PreSale.PreSaleInfo.CustomerInfo.FirstName <> '';
           SaveClient;
           end;
  finally
    Free;
  end;
end;

procedure TFrmMRPDV.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if (ssShift in Shift) then
      Exit;

   if key = VK_CONTROL then
   begin
     if fSearchItemMode = ITEM_MODE_QTY_BARCODE then
        fSearchItemMode := ITEM_MODE_QTY_MODEL
     else
        fSearchItemMode := ITEM_MODE_QTY_BARCODE;
     ChangeSearchItemMode;
     Exit;
   end;

   if key = 16 then //SHIFT
   begin
     if PreSale.PreSaleType = tptRefund then
     begin
       PreSale.PreSaleType  := tptExchange;
       lbRefundInfo.Caption := 'Aperte SHIFT - para Devolução';
       lbDevolucao.Caption  := 'Produtos Troca';
     end
     else if PreSale.PreSaleType = tptExchange then
     begin
       PreSale.PreSaleType  := tptRefund;
       lbRefundInfo.Caption := 'Aperte SHIFT - para Troca';
       lbDevolucao.Caption  := 'Produtos Devolução';
     end;
   end;

   //if (ssCtrl in Shift) then
   //   Exit;

   StartOptions(DM.GetFunction(Key));

end;

procedure TFrmMRPDV.RefreshPreSaleInfo(AShow: Boolean);
var
  sComplement : String;
begin
  with PreSale.PreSaleInfo do
  begin
    if CustomerInfo <> nil then
    begin
    with CustomerInfo do
      begin
      lbPDVHint.Caption       := '';
      lblCustomerName.Caption := FirstName + ' ' + LastName;
      sComplement             := '';
      if Endereco <> '' then
         sComplement := Endereco + ' - ' + Bairro + ' - ' + Cidade;

      if CPF <> '' then
         sComplement := sComplement + ' Doc.:' + CPF;

      if Telefone <> '' then
         sComplement := sComplement + ' Tel.: ' + Telefone;

      lbAddress.Caption := sComplement;

      if lblCustomerName.Caption = '' then
         lblCustomerName.Caption := sNotInformed;
      end;
    end
    else
    begin
      lblCustomerName.Caption := '';
      lbAddress.Caption       := '';
    end;


    if MediaInfo <> nil then
      begin
      lbPDVHint.Caption := '';
      with MediaInfo do
        lblMedia.Caption := MediaName;
      end
    else
      lblMedia.Caption := sNotInformed;

  end;

  pnlCustomer.Visible     := (lbPDVHint.Caption = '') or AShow;

  lblCustomerName.Visible := (lblCustomerName.Caption <> '');
  lbAddress.Visible       := (lbAddress.Caption <> '');
  lblMedia.Visible        := (lblMedia.Caption <> '')

end;

function TFrmMRPDV.SubAddItem(AIDCustomer, AIDModel, AIDStore, AIDUser,
  AIDCommis: Integer; ADiscount, ASale, ACost : Currency; AQty : Double; ATaxValue,
  APercMaxDisc: Currency; AMovDate, ADate: TDateTime;
  AResetDisc, AManager: Boolean; ADescription, AECFTaxIndex, AModel,
  AImagePath: String; APuppyTracker, ARequestCustomer: Boolean;
  ACaseQty: Double; AIDDepartment, AIDVendorPrice, AIDDescriptionPrice: Integer;
  ASuggPrice: Currency; ADocumentNumber: String; AIDDocumentType: Integer;
  ASerialNumber, AIdentificationNumber: String; ATotalInformed : Currency;
  ATotParcial, AUnidade: String): Boolean;
begin

  Result := False;
  DMPDV.CanTransferFile := False;

  try
    if (not UsaECF) then
      if not TestFiscal then
        Exit;

    if (CupomAberto = '') or ((PreSale.Count = 0) and not UsaECF) then
    begin
      CupomAberto := AbreCupom;
      if CupomAberto = '' then
        Exit;

      //PAF
      if DM.fCupomFiscal.DataHora = 0 then
        PreSale.PreSaleDate := Now
      else
        PreSale.PreSaleDate := DM.fCupomFiscal.DataHora;
      PreSale.CCF         := DM.fCupomFiscal.CCF;
      PreSale.COO         := CupomAberto;
    end;

    if not PreSale.CouponOpened then
    begin
      PreSale.CouponOpened := True;
      SavePreSale;
    end;

    Payments.COO := PreSale.COO;

    Result := PreSale.AddPreSaleItem(AIDCustomer,
                                     AIDModel,
                                     AIDStore,
                                     AIDUser,
                                     AIDCommis,
                                     ADiscount,
                                     ASale,
                                     ACost,
                                     AQty,
                                     ATaxValue,
                                     APercMaxDisc,
                                     AMovDate,
                                     ADate,
                                     AResetDisc,
                                     AManager,
                                     ADescription,
                                     AECFTaxIndex,
                                     AModel,
                                     AImagePath,
                                     APuppyTracker,
                                     ARequestCustomer,
                                     ACaseQty,
                                     AIDDepartment,
                                     AIDVendorPrice,
                                     AIDDescriptionPrice,
                                     ASuggPrice,
                                     ADocumentNumber,
                                     AIDDocumentType,
                                     ASerialNumber,
                                     AIdentificationNumber,
                                     ATotalInformed,
                                     ATotParcial,
                                     AUnidade);

     if Result then
     begin
       Result := SavePreSaleItem(PreSale.Items[PreSale.Count-1]);
       if not Result then
       begin
         PreSale.Delete(PreSale.Count-1);
         Exit;
       end;

       if ASerialNumber <> '' then
       begin
         Result := SavePreSaleItemSerial(PreSale.Items[PreSale.Count-1],
                                         PreSale.Items[PreSale.Count-1].SerialNumbers[0]);
         if not Result then
         begin
           PreSale.Delete(PreSale.Count-1);
           Exit;
         end;
       end;

       if ADiscount > 0 then
       begin
         lbSubDe.Caption         := FormatFloat('#,##0.00', ASale);
         lbSubPor.Caption        := FormatFloat('#,##0.00', ASale - (ADiscount/AQty));
         pnlSubTotalDisc.Visible := True;
       end
       else
         pnlSubTotalDisc.Visible := False;
       lbSubtotal.Caption    := FormatFloat('#,##0.00', ASale);
       lbDescription.Caption := ADescription;
       lbProdInfo.Visible    := True;
       lbSalePrice.Visible   := True;
       lbPDVHint.Caption     := '';

       //PoleDisplay
       if DM.fStartPoleDisplay then
       begin
         DM.PoleDisplayInvInfo(PreSale.SaleCode,
                               PreSale.PreSaleDate,
                               0,
                               PreSale.DiscountTotal,
                               0,
                               PreSale.SaleTotal);

         DM.PoleDisplayAddItem((PreSale.Count-1),
                               AIDModel,
                               AModel,
                               ADescription,
                               AQty,
                               ASale,
                               ADiscount);
       end;
     end;

  except
     Result := False;
  end;
end;


function TFrmMRPDV.AddItem: Boolean;
var
  sBarcode: String;
  sTotParcial : String;
  sUnidade : String;
  sQty: String;
  sDescription: String;
  sModel: String;
  sTax: String;
  sImagePath: String;
  iIDModel: Integer;
  iIDUser: Integer;
  iIDCommiss: Integer;
  iIDCommisType: Integer;
  iIDDepartment: Integer;
  iIDVendorPrice: Integer;
  iIDDescriptionPrice: Integer;
  iIDDocumentType: Integer;

  iTmpIDUser: Integer;
  iTmpIDCommiss: Integer;
  iTmpIDCommisType: Integer;

  iQty, iQtySold: Double;

  DiscountValue,
  cCostPrice,
  cSuggPrice,
  cSellingPrice,
  cStorePrice,
  cNewSellPrice,
  Discount,
  cPrcPartDiscount: Currency;

  dCaseQty: Double;

  bPuppyTracker,
  bRequestCustomer,
  bEmpty,
  bAskPrice,
  bAskUser,
  bHasSerialNum,
  bAskDocument,
  bUseScale,
  bHasScaleDigit: Boolean;

  cType,
  cOperat: Char;

  cQtyScale : Double;

  sDocumentNumber: String;
  sFilterQty : String;

  fOnHand : Double;

  bTotalInformed : Currency;

  iMsgResult : Integer;
begin
  Result := False;
  dValor := 0;

  try

    if not TestFiscalToogle then
      Exit;

    sBarcode := edtBarcode.Text;

    if (fItemDiscount <> '') and (Pos('%', sBarcode) = 0) and (Pos('$', sBarcode) = 0) then
      sBarcode := fItemDiscount + sBarcode;

    if not ValidateDiscount(sBarcode, Discount, cType, cOperat) then
    begin
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
      edtBarcode.Visible := True;
      if edtBarcode.CanFocus then
      begin
        edtBarcode.SelectAll;
        edtBarcode.SetFocus;
      end;
      Exit;
    end;

    if not ValidadeItem(sBarcode, sQty) then
    begin
      MsgBox(MSG_INF_WRONG_QTY, vbCritical + vbOKOnly);
      edtBarcode.Visible := True;
      if edtBarcode.CanFocus then
      begin
        edtBarcode.SelectAll;
        edtBarcode.SetFocus;
      end;
      Exit;
    end;

    if DM.fCashRegister.BarcodeScaleCheck and (fSearchItemMode = ITEM_MODE_QTY_BARCODE) then
    begin
      bHasScaleDigit := Copy(sBarcode, 1, 1) = '2';
      if bHasScaleDigit and (Length(sBarcode) = 13) then
      begin
        try
          dValor   := MontaValor(Copy(sBarcode, 8, 5));
          sBarcode := Copy(sBarcode, 2, 6);
        except
          MsgBox(MSG_CRT_NO_BARCODE_SCALE, vbCritical + vbOkOnly);
          Exit;
        end;
      end;
    end;

    if not DMPDV.ValidadeBarcode(fSearchItemMode, sBarcode, cCostPrice, cSellingPrice,
           cStorePrice, iIDModel, sDescription, sModel, sTax, sImagePath,
           bAskPrice, bPuppyTracker, bRequestCustomer,
           dCaseQty, cPrcPartDiscount, iIDDepartment, bAskUser, bHasSerialNum, bAskDocument, bUseScale,
           sTotParcial, sUnidade) then
    begin
      Repeat
        iMsgResult := MsgBox(sBarcode + ' - Código Inválido!', vbQuestion + vbRetryCancel);
      Until vbCancel = iMsgResult;
      edtBarcode.Visible := True;
      if edtBarcode.CanFocus then
      begin
        edtBarcode.SelectAll;
        edtBarcode.SetFocus;
      end;
      Exit;
    end;


    { Caso seja uma impressora fiscal. A descrição do item deve ser composta de
      pelo menos uma vogal ou uma consoante
    }
    if UsaECF then
    begin
      if not ValidaDescricaoItemPDV(sDescription) then
      begin
        MsgBox(MSG_CRT_INVALID_DESCRIPTION_PDV, vbCritical + vbOkOnly);
        edtBarcode.Visible := True;
        if edtBarcode.CanFocus then
        begin
          edtBarcode.SelectAll;
          edtBarcode.SetFocus;
        end;
        Exit;
      end
    end;


    if dCaseQty > 1 then
    begin
      //iQty := dCaseQty;
      sQty := FloatToStr(StrToFloat(sQty) * dCaseQty);
    end;

    LoadPDVImage(sImagePath);

    pnlSubtotal.Visible := True;

    if HasTablePrice(DM.fStore.ID, iIDModel) and not VerificaBalanca then
      GetChoosedPrice(DM.fStore.ID, iIDModel, iIDVendorPrice,
        iIDDescriptionPrice, cSuggPrice, cSellingPrice)
    else
    begin
      iIDVendorPrice := 0;
      iIDDescriptionPrice := 0;
      cSuggPrice := 0;

      cSellingPrice := DM.fPOS.GetKitPrice(iIDModel, StrToFloat(sQty), cSellingPrice, bEmpty);

      if (cStorePrice <> 0) and (DM.PersistenceType = ptDB) then
         cSellingPrice := cStorePrice;

      if bAskPrice then
         with TFrmAskPrice.Create(Self) do
            begin
            cNewSellPrice := Start('('+sModel+') ' + sDescription);
            if cNewSellPrice <> 0 then
               cSellingPrice := cNewSellPrice
            else
               Exit;
            end;
    end;

    if bAskDocument then
      GetEnteredDocument(sDocumentNumber, iIDDocumentType)
    else
    begin
      sDocumentNumber := '';
      iIDDocumentType := 0;
    end;

    //Tratar quantidade para 3 casas decimais
    if PreSale.PreSaleType = tptRefund then
      iQty := Abs(CorrigirQtyFracionaria(sQty)) * -1
    else
      iQty := Abs(CorrigirQtyFracionaria(sQty));

    (*  DESCONTO FRACIONARIO NAO PERMITIDO NESTA VERSAO - REMOVER - INICIO *)

    if (cOperat = '%') and (Frac(Discount) > 0) then
      raise exception.Create('Desconto percentual fracionário não permitido nessa versão.');

    (*  DESCONTO FRACIONARIO NAO PERMITIDO NESTA VERSAO - REMOVER - FIM *)

    DiscountValue := CalcDiscount(cSellingPrice, Discount, iQty, cOperat, cType);

    // Trunca as casas decimais
    DiscountValue := TruncMoney(DiscountValue, PDV_PRICE_DECIMAL_LENGTH);

    //Validar quantidade zerada ou a granel
    if iQty = 0 then
      raise Exception.Create('Qtd não pode ser zero ou ter mais de 3 casas decimais');

    if (PreSale.PreSaleType in [tptInvoice, tptLayAway]) then
      if ((iQty * cSellingPrice) - DiscountValue) <= 0 then
        raise Exception.Create('Desconto não pode ser aplicado');

    (*
    if cSellingPrice <= DiscountValue  then
      // Mudar MSG
      raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);


    if not Password.HasFuncRight(9) then
    begin
       if (((DiscountValue/iQty) / cSellingPrice * 100 ) > cPrcPartDiscount) then
         // Mudar MSG
         raise Exception.Create(MSG_INF_DISCOUNT_LIMT_REACHED);
    end;
    *)

    iTmpIDUser       := -1;
    iTmpIDCommiss    := -1;
    iTmpIDCommisType := -1;

    if (DM.fCashRegister.AskSalesPerson and (not ApplyAllItemsDiscount)) or
       ((not DM.fCashRegister.AskSalesPerson) and bAskUser) then
    begin
      iIDUser := DM.fUser.ID;
      with TFrmAskSalesPerson.Create(Self) do
         if Start(iIDUser, iIDCommiss, iIDCommisType, ApplyAllItemsDiscount, DM.fCashRegister.AskSalesPerson, DM.fCashRegister.KeepSalesPerson, sTmpUserName) then
            begin
            iTmpIDUser                       := SalesPersonInfo.IDUser;
            iTmpIDCommiss                    := SalesPersonInfo.IDCommission;
            iTmpIDCommisType                 := SalesPersonInfo.IDCommissionType;

            SalesPersonInfo.IDUser           := iIDUser;
            SalesPersonInfo.IDCommission     := iIDCommiss;
            SalesPersonInfo.IDCommissionType := iIDCommisType;
            PreSale.SaleBelowCostPrice       := Password.HasFuncRight(4);
            end;
    end;

    Result :=  DMPDV.SelectModelDepartment(iIDModel, iIDDepartment);

    if not Result then
      Exit;

    bTotalInformed := 0;

    //Testa da balanca *** Validar se o item e de balanca aqui ***
    if bUseScale then
      if DM.fCashRegister.BarcodeScaleCheck and bHasScaleDigit then
      begin
        if fSearchItemMode = ITEM_MODE_QTY_BARCODE then
        begin
          iQty := FloatToCurr(dValor / cSellingPrice);
          iQty := MyStrToFloat(FormatFloat('0000.000', iQty));
          dValor := DMPDV.AjustaPreco(iQty, dValor, cSellingPrice);
        end
        else
          iQty := 1;

        if PreSale.PreSaleType = tptRefund then
        begin
          iQty := iQty * -1;
        end;
      end
      else if DM.fCashRegister.POSScaleCheck then
      begin
        if DM.fCashRegister.POSScaleType = BAL_TIPO_POS_FILIZOLA then
        begin
          cQtyScale := 0;

          with TFrmScaleInfo.Create(Self) do
            cQtyScale := Start(FBalanca, sModel + ' - ' + sDescription, cSellingPrice);

          if cQtyScale = 0 then
          begin
            raise exception.Create('Quantidade inválida!');
            Exit;
          end
          else
          begin
            if PreSale.PreSaleType = tptRefund then
              iQty := cQtyScale * -1
            else
              iQty := cQtyScale;
          end
        end
      end;

   //Bloquear venda para deixar estoque negativo
   if DM.fCashRegister.BlockNegativeSale then
   begin

     if (PreSale.PreSaleType in [tptInvoice, tptLayAway]) then
       if (not DMPDV.SellNegative) and (not Password.HasFuncRight(8)) then
       begin
         try
           sFilterQty   := Format('StoreID = %D', [DM.fStore.ID]);
           DMPDV.OpenQuantity(iIDModel, sFilterQty);
           fOnHand := DMPDV.cdsQty.FieldByName('QtyOnHand').AsFloat;
           iQtySold := DMPDV.GetQtySold(iIDModel);
         finally
           with DMPDV.cdsQty do
           begin
             Filtered := False;
             Filter   := '';
           end;
           DMPDV.CloseQuantity;
         end;

         if (fOnHand - iQtySold - iQty) < 0 then
         begin
           MsgBox(MSG_CRT_INVENTORY_WILL_BE_NEG, vbCritical + vbOkOnly);
           Exit;
         end
         else
           DMPDV.AddQtySold(iIDModel, iQty);
       end
       else
         DMPDV.AddQtySold(iIDModel, iQty);

   end;

    if sUnidade = '' then
      sUnidade := 'un';

    Result :=  SubAddItem(1,
                          iIDModel,
                          DM.fStore.ID,
                          SalesPersonInfo.IDUser,
                          SalesPersonInfo.IDCommission,
                          DiscountValue,
                          cSellingPrice,
                          cCostPrice,
                          iQty,
                          0,
                          cPrcPartDiscount,
                          now,
                          Now,
                          False,
                          False,
                          sDescription,
                          sTax,
                          sModel,
                          sImagePath,
                          bPuppyTracker,
                          bRequestCustomer,
                          dCaseQty,
                          iIDDepartment,
                          iIDVendorPrice,
                          iIDDescriptionPrice,
                          cSuggPrice,
                          sDocumentNumber,
                          iIDDocumentType,
                          '',
                          '',
                          bTotalInformed,
                          sTotParcial,
                          sUnidade);


    if (not ApplyAllItemsDiscount) and (iTmpIDUser <> -1) then
    begin
      SalesPersonInfo.IDUser           := iTmpIDUser;
      SalesPersonInfo.IDCommission     := iTmpIDCommiss;
      SalesPersonInfo.IDCommissionType := iTmpIDCommisType;
    end;

    if Result and bHasSerialNum then
      AddSerial(iIDModel, iQty);

  except
    on E: Exception do
    begin
      Result := False;
      MsgBox(E.Message, vbCritical);
    end;
  end;
  RefreshItem();
end;


function TFrmMRPDV.CalcDiscount(SaleValue, dDiscount: Currency; Qty: Double;
   cDiscOperat, cDiscType: char): Currency;
var
  Fator : Integer;
begin
  Result := 0;

  if PreSale.PreSaleType = tptRefund then
    Fator := -1
  else
    Fator := 1;

  if dDiscount > 0 then
    if cDiscOperat = '$' then
      begin
         dDiscount := dDiscount * Qty;
         if cDiscType = 'D' then
            Result := dDiscount * fator
         else  if cDiscType = 'A' then
            Result := dDiscount * -1 * fator;
      end
    else
      if cDiscOperat = '%' then
      begin
         SaleValue := SaleValue * Qty;
         if cDiscType = 'D' then
            Result :=  (SaleValue * (dDiscount/100))
         else  if cDiscType = 'A' then
            Result :=  (SaleValue * (dDiscount/100)) * -1;
      end;
end;

procedure TFrmMRPDV.AddPayment(ATEFCallInfo : TTEFCallInfo = nil);
var
  Item  : TListItem;
  ValorAPagar: Currency;
begin
  if not TestFiscalToogle then
    Exit;

  ValorAPagar := ABS(MyStrToMoney(edtPayValue.Text));

  if PreSale.PreSaleType = tptRefund then
    ValorAPagar := ValorAPagar * -1;

  try
    if ValorAPagar = 0 then
    begin
      MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical);
      Exit;
    end;

    if not AddCustomerIfNeeded(False) then
    begin
      MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
      Exit;
    end;

    if (ValorAPagar > 0) and (not DMPDV.IsMinPayValue(MeioPagamento.IDMeioPag, ValorAPagar)) then
    begin
      MsgBox(MSG_INF_INVOICE_NOT_REACH, vbCritical);
      Exit;
    end;

    if (PreSale.PreSaleType = tptInvoice) and (not DMPDV.IsMinPayValue(MeioPagamento.IDMeioPag, ValorAPagar)) then
    begin
      MsgBox(MSG_INF_INVOICE_NOT_REACH, vbCritical);
      Exit;
    end;

    if (PreSale.PreSaleType in [tptRefund, tptExchange]) then
    begin
      if Payments.InvoiceTotal = 0 then
      begin
        MsgBox(MSG_INF_TOTAL_ZERO, vbCritical);
        Exit;
      end;

      if (PreSale.SaleTotal < 0) and (not Password.HasFuncRight(7)) then
      begin
        MsgBox(MSG_INF_MANAGER_TONEGATIVE_DISC, vbCritical);
        Exit;
      end;

      //Testa se e Refund ou Exchange
      Payments.IsRefund := (Payments.InvoiceTotal < 0);
    end;

    if DM.fCashRegister.UseTef = TEF_DEDICADO then
    begin
      if Frac(ValorAPagar * 100) > 0 then
        Exit;
    end;

    if (ValorAPagar > Payments.BalanceTotal) and
       (MeioPagamento.TipoPagamento.Tipo <> PAYMENT_TYPE_CASH)then
    begin
      MsgBox(sNoChangeFor + MeioPagamento.MeioPag, vbCritical);
      Exit;
    end;

    if (ValorAPagar > 1000000) then
    begin
      MsgBox(Format('Valor %S ultrapassou o valor permitido de 1.000.000,00', [edtPayValue.Text]), vbOKOnly + vbSuperCritical);
      Exit;
    end;

    if not Payments.AddPayment(MeioPagamento.IDMeioPag,
                              MeioPagamento.TipoPagamento.Tipo,
                              MeioPagamento.CodFiscal,
                              IfThen(Trim(MeioPagamento.CodFiscal) = '', MeioPagamento.MeioPag, MeioPagamento.CodFiscal),
                              ValorAPagar,
                              ATEFCallInfo) then
    Exit;

    if not SavePreSalePayment(Payments.Items[Payments.Count-1]) then
      Exit;

    case DM.PersistenceType of
      ptDB: if (Payments.TEFDial <> nil) and (Payments.TEFDial.PendingList.Count > 0) then
              TTEFPending(Payments.TEFDial.PendingList[Payments.TEFDial.PendingList.Count-1]).IDPreSale := PreSale.IDPreSale;
    end;

    pnlPaymentList.Visible := True;

    if (MeioPagamento.TipoPagamento.Tipo = PAYMENT_TYPE_CASH) then
    begin
      FTotalCashSale := FTotalCashSale + ValorAPagar;
      VerifyCashOverFlow;
    end;

    Application.ProcessMessages;

    Item := lvwPayments.Items.Add;
    with Item do
    begin
      ImageIndex     := MeioPagamento.Imagem;
      Caption        := MeioPagamento.MeioPag;
      SubItems.Add(MyFloatToStr(Payments.LastPayment.Amount));
    end;

    //Pole Display
    if DM.fStartPoleDisplay then
      DM.PoleDisplayAddPayment(MeioPagamento.IDMeioPag,
                               IfThen(Trim(MeioPagamento.CodFiscal) = '', MeioPagamento.MeioPag, MeioPagamento.CodFiscal),
                               ValorAPagar);


    if ((Payments.BalanceTotal <= 0) and (PreSale.PreSaleType <> tptRefund)) or
       ((Payments.BalanceTotal >= 0) and (PreSale.PreSaleType = tptRefund))then
    begin
      if Payments.ChangeTotal > 0 then
      begin
        if PreSale.PreSaleType = tptRefund then
          lbSubtotal.Caption    := MyFloatToStr(Payments.ChangeTotal * -1)
        else
          lbSubtotal.Caption    := MyFloatToStr(Payments.ChangeTotal);

        if PreSale.PreSaleType = tptRefund then
          lbDescription.Caption := sRest
        else
          lbDescription.Caption := sChange;
      end;
      Application.ProcessMessages;

      if not PayHold then
      begin
        if PreSale.CouponOpened then
        begin
          Sleep(1500);
          NewHold;
        end;
        Exit;
      end;

      PrintReceipt;

      Sleep(1500);
      NewHold;
    end;

  finally
    lbSubtotal.Caption    := '';
    lbDescription.Caption := '';
    pnlSubTotalDisc.Visible := False;
    SetPayment;
    SetMeioPag(DMPDV.DefaultMeioPag);
    pnlTEFDed.Visible := False;
    pnlSaleInfo.Visible := True;
  end;
end;


procedure TFrmMRPDV.SetMeioPag(MP: TMeioPagamento);
begin
  MeioPagamento     := MP;
  lbPayment.Caption := MeioPagamento.MeioPag;
end;

procedure TFrmMRPDV.CallPayments;
var
  ADiscountValue: Currency;
begin
  if not TestFiscalToogle then
      Exit;

  if UsaECF then
  begin
    if not HasCupom then
    begin
      ADiscountValue := PreSale.DiscountTotal;
      if ADiscountValue <> 0 then
        PreSale.ResetDiscount;

      PrintItems;

      if ADiscountValue > 0 then
        PreSale.DoDiscount(tdtDesconto, dvtValor, ADiscountValue)
      else
        if ADiscountValue < 0 then
          PreSale.DoDiscount(tdtAcrescimo, dvtValor, ADiscountValue)
    end;
  end;

  if not AddCustomerIfNeeded then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbInformation + vbOkOnly);
    Exit;
  end;

  edtBarcode.Visible      := False;
  pnlDiscount.Visible     := False;
  pnlItemDiscount.Visible := False;
  pnlPayments.Visible     := True;
  lbDescription.Caption   := '';
  lbSubtotal.Caption      := '';
  pnlSubTotalDisc.Visible := False;
  lbProdInfo.Visible      := False;
  lbSalePrice.Visible     := False;

  SetMeioPag(DMPDV.DefaultMeioPag);

  Payments.InvoiceTotal := PreSale.SaleTotal - PreSale.DiscountTotal - PreSale.InvoiceDiscount;
  edtPayValue.Text      := lbTotal.Caption;
  SetPayment;
  if edtPayValue.CanFocus then
     edtPayValue.SetFocus;

end;

procedure TFrmMRPDV.NewHold(APreSaleType: TPreSaleType = tptInvoice);
begin

   RefreshDateTime;
   ClearHold;

   PreSale.PreSaleType := APreSaleType;
   if UsaECF then
     PreSale.SerialECF := DM.fModuloFiscal.ECFSerial;

   Payments.IsRefund := PreSale.PreSaleType = tptRefund;
   lbRefundInfo.Visible := False;
   lbDevolucao.Visible := False;

   case PreSale.PreSaleType of
    tptInvoice: Color := DM.fMRPOSColor.POSBackgroundColor;
    tptRefund : begin
                Color                := DM.fMRPOSColor.POSReturnColor;
                lbPDVHint.Caption    := sRefund;
                lbRefundInfo.Visible := True;
                lbDevolucao.Visible  := True;
                end;
    tptLayAway: Color := $00804000;
   end;

   VerificaGaveta;

end;

procedure TFrmMRPDV.TmHourTimer(Sender: TObject);
begin
  RefreshDateTime;
  RefreshServerConnection;
  RefreshPoleDisplayConnection;
end;

procedure TFrmMRPDV.RefreshDateTime;
begin
  lbDay.Caption  := FormatDateTime('dddd, mmmm d, yyyy hh:mm AM/PM', Now);
end;

function TFrmMRPDV.Start(IDCashRegMov:Integer): Boolean;
begin

    if UsaECF then
    begin
      Payments.TEFType := DM.fCashRegister.UseTef;
      Result := False;

      if not DM.EFiscal1.VerificaImpressoraLigadaTEF then
         Exit;

      if DM.EFiscal1.TemCupom then
      begin
        MsgBox('O último cupom fiscal ficou aberto e sera cancelado!', vbCritical + vbOkOnly);
        DM.EFiscal1.CancelaCupomAtualSemErro((DM.fCashRegister.UseTef in [TEF_DIAL, TEF_DEDICADO]));
      end;

      DM.EFiscal1.FechaRelatorioGerencial;
      
    end
   else
      Payments.TEFType := TEF_NONE;

   FTotalCashSale := DMPDV.GetTotalCashSale(IDCashRegMov);
   FTotalCashAllowed := DMPDV.GetTotalCashInRegister;

   VerifyCashOverFlow;
   AbrirBalanca;
   LoadCashInfo;
   NewHold;
   TmHour.Enabled := True;
   fIDCashRegMov  := IDCashRegMov;
   ShowModal;
   Result := True;
end;

procedure TFrmMRPDV.FormCreate(Sender: TObject);
begin
  inherited;

  SalesPersonInfo     := TSalesPersonInfo.Create;
  SellingItem         := TSellingItem.Create;
  //Homologacao BA
  lbMRInfo.Caption    := 'MainRetail - CashRegister ' + CASH_HOMOLOG;
  lbMRInfo.Hint       := 'MainRetail - CashRegister ' + CASH_VERSION;
  pnlShortCut.Visible := DM.fCashRegister.ShowShortCut;

  case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sProducts       := 'Product(s)';
           sNexCustomer    := 'Next customer';
           sQtyBarcode     := 'Qty/Barcode';
           sQtyModel       := 'Qty/Model';
           sDiscountPer    := 'Discount (%)';
           sDiscountDollar := 'Discount ($)';
           sAdditionPer    := 'Addition (%)';
           sAdditionDollar := 'Addition ($)';
           sChange         := 'Change';
           sNotInformed    := 'Not informed';
           sNoChangeFor    := 'Cannot give change for ';
           sNeedCustomer   := 'Please inform a customer';
           sRefund         := 'Refund/Change';
           sRest           := 'Rest';
           sDiscountItemPer    := 'Item Discount (%)';
           sDiscountItemDollar := 'Item Discount ($)';
           sDiscItemPerHint    := 'Discount (%f %) on next item';
           sDiscItemDollarHint := 'Discount (%f $) on next item';
           end;

     LANG_PORTUGUESE :
           begin
           sProducts       := 'Produto(s)';
           sNexCustomer    := 'Próximo cliente';
           sQtyBarcode     := 'Quantidade/Código';
           sQtyModel       := 'Quantidade/Modelo';
           sDiscountPer    := 'Desconto (%)';
           sDiscountDollar := 'Desconto (R$)';
           sAdditionPer    := 'Acréscimo (%)';
           sAdditionDollar := 'Acréscimo (R$)';
           sChange         := 'Troco';
           sNotInformed    := 'Não informado(a)';
           sNoChangeFor    := 'Não pode dar troco para ';
           sNeedCustomer   := 'Por favor selecionar um cliente';
           sRefund         := 'Devolução/Troca';
           sRest           := 'Resta';
           sDiscountItemPer    := 'Desconto (%) no produto';
           sDiscountItemDollar := 'Desconto (R$) no produto';
           sDiscItemPerHint    := 'Desconto %f % no próximo produto';
           sDiscItemDollarHint := 'Desconto R$ %f no próximo produto';
           end;

     LANG_SPANISH :
           begin
           sProducts       := 'Producto(s)';
           sNexCustomer    := 'Próximo cliente';
           sQtyBarcode     := 'Ctd/Codigo';
           sQtyModel       := 'Ctd/Modelo';
           sDiscountPer    := 'Discount (%)';
           sDiscountDollar := 'Discount ($)';
           sAdditionPer    := 'Addition (%)';
           sAdditionDollar := 'Addition ($)';
           sChange         := 'Cambio';
           sNotInformed    := 'No informado(a)';
           sNoChangeFor    := 'No puede dar el cambio para ';
           sNeedCustomer   := 'Informe por favor a un cliente';
           sRefund         := 'Reembolso/Troca';
           sRest           := 'Carencia';
           sDiscountItemPer    := 'Discount item (%)';
           sDiscountItemDollar := 'Discount item ($)';
           sDiscItemPerHint    := 'Discount (%f %) próximo item';
           sDiscItemDollarHint := 'Discount (%f $) próximo item';
           end;
   end;

  //Desabilitar Alt + F4
  Application.OnMessage := AppMessage;

end;

procedure TFrmMRPDV.RefreshItem();
var
  I : Integer;
  lviItem: TListItem;
begin
  try
    lvwItems.Items.BeginUpdate;
    try
      lvwItems.Items.Clear;
      for I := 0 to PreSale.Count - 1 do
      begin
        lviItem := lvwItems.Items.Add;
        with lviItem do
        begin
          case DM.fCashRegister.DisplayType of
            DISPLAY_MODEL       : Caption := PreSale.Items[I].Model;
            DISPLAY_DESCRIPTION : Caption := PreSale.Items[I].Description;
            DISPLAY_MODEL_DESC  : Caption := PreSale.Items[I].Model + ' - ' +
                                             PreSale.Items[I].Description;
            else
             Caption := PreSale.Items[I].Description;
          end;

          SubItems.Add(FormatFloat('0.#####', PreSale.Items[I].Qty) + PreSale.Items[I].Unidade);
          SubItems.Add(FormatFloat('#,##0.00', PreSale.Items[I].Discount));

          if (PreSale.Items[I].TotalInformed <> 0) then
            SubItems.Add(FormatFloat('#,##0.00', TruncMoney(PreSale.Items[I].TotalInformed - PreSale.Items[I].Discount, 2)))
          else
            SubItems.Add(FormatFloat('#,##0.00', TruncMoney((PreSale.Items[I].Qty * PreSale.Items[I].Sale) - PreSale.Items[I].Discount, 2)));

          Data := PreSale.Items[I];
        end;
      end;

      if lvwItems.Items.Count > 0 then
      begin
        lvwItems.Selected := lvwItems.Items[lvwItems.Items.Count - 1];
        lvwItems.Selected.MakeVisible(False);
      end;

    finally
      lvwItems.Items.EndUpdate;
    end;

    Screen.Cursor := crHourGlass;

    lbItems.Caption := IntToStr(PreSale.Count) + ' ' + sProducts;

    RefreshTotal;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMRPDV.RefreshTotal;
begin
  lbTotal.Caption := FormatFloat('#,##0.00', PreSale.SaleTotal - PreSale.DiscountTotal - PreSale.InvoiceDiscount);
end;

procedure TFrmMRPDV.CancelHold;
begin

  try

    try
      if not TestFiscalToogle then
        Exit;

      CancelaCupom(False);

      if (PreSale.IDPreSale <> -1) and (DM.PersistenceType = ptDB) then
          DM.DecHold(PreSale.IDPreSale);

      SaveAbortaPreSale(PreSale.COO);
      SaleHeaderSaved := False;
      ClientSaved := False;

      DMPDV.CanTransferFile := True;

      //Pole Display
      if DM.fStartPoleDisplay then
        DM.PoleDisplayCloseSale;
    except
      on E: Exception do
        MsgBox(E.Message, vbCritical + vbOKOnly);
    end;
  finally
    if not Payments.Reset then
      MsgBox('Erro ao limpar pagamentos', vbCritical + vbOKOnly);
    PreSale.Clear;
  end;

end;


function TFrmMRPDV.CancelaCupom(Exibir: Boolean): Boolean;
begin

  Result := True;

  if not UsaECF then
     Exit;

  if UsaECF then
     Result := DM.EFiscal1.VerificaImpressoraLigadaTEF;

  if not Result then
    Exit;

  if UsaECF then
    if ((CupomAberto <> '') and (CupomAberto <> CUPOM_VAZIO)) or (DM.EFiscal1.TemCupom) then
    begin
      if Exibir then
         MsgBox('O último cupom fiscal ficou aberto e sera cancelado!', vbCritical + vbOkOnly);
       if not DM.EFiscal1.CancelaCupomAtual then
       begin
         Result := False;
         Exit;
       end;
      DM.EFiscal1.FechaRelatorioGerencial;

      if DM.fCashRegister.UseTef = TEF_DEDICADO then
        DM.TEFDedicado1.ResolvePendencias;

      CupomAberto := '';
      Payments.COO := CupomAberto;
    end;
end;

procedure TFrmMRPDV.DeleteCupomItems(IDUserAuto: Integer);
var
  I : Integer;
  sError : String;
begin

  if lvwItems.Selected = nil then
     Exit;

  if not TestFiscalToogle then
    Exit;

end;

procedure TFrmMRPDV.DeleteItem(IDUserAuto:Integer);
var
  Item : TListItem;
  sError : String;
  iItemIndex : Integer;
begin

  if lvwItems.Selected = nil then
     Exit;

  if not TestFiscalToogle then
    Exit;

  Item := lvwItems.Selected;

  if (MsgBox(format(MSG_QST_DELETE_ITEM, [TPreSaleItem(Item.Data).Description]), vbYesNo + vbQuestion) = vbYes) then
    begin
    if UsaECF then
       begin
       if not DM.EFiscal1.CancelaItem(TPreSaleItem(Item.Data).Model, IntToStr(TPreSaleItem(Item.Data).ECFIndex)) then
          Exit;
       end
    else
      if not TestFiscal then
        Exit;

    SaveDeletedItem(TPreSaleItem(Item.Data).ECFIndex, PreSale.Items[lvwItems.ItemIndex], IDUserAuto, 1);

    iItemIndex := Item.Index;
    PreSale.Delete(iItemIndex);
    lbDescription.Caption   := '';
    lbSubtotal.Caption      := '';
    pnlSubTotalDisc.Visible := False;
    RefreshItem;
    RefreshItemInfo(lvwItems.Selected);
    end;

  if PreSale.Count = 0 then
    ClearItem;

  Payments.InvoiceTotal := PreSale.SaleTotal - PreSale.DiscountTotal - PreSale.InvoiceDiscount;

  //Pole Display
  if DM.fStartPoleDisplay then
  begin
    DM.PoleDisplayInvInfo(PreSale.SaleCode,
                         PreSale.PreSaleDate,
                         0,
                         PreSale.DiscountTotal,
                         0,
                         PreSale.SaleTotal);

    DM.PoleDisplayDeleteItem(iItemIndex);
  end;

end;

procedure TFrmMRPDV.edtPayValuePressEnter(Sender: TObject);
begin
  AddPayment;
end;

procedure TFrmMRPDV.edtBarcodePressEnter(Sender: TObject);
begin
  AddItem;
  ClearItem;
end;

procedure TFrmMRPDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CancelHold;
  DMPDV.SaveFilesToServer(True);
  FecharBalanca;
  Action := caFree;
end;

procedure TFrmMRPDV.ExitPDV;
begin
  Close;
end;


procedure TFrmMRPDV.FormShow(Sender: TObject);
begin
   if edtBarcode.CanFocus then
      begin
        edtBarcode.SelectAll;
        edtBarcode.SetFocus;
      end;

  Left   := 0;
  Top    := 0;

  Height := Screen.Height;
  Width  := Screen.Width;


  pnlLayaway.Visible := (DMGlobal.IDLanguage=LANG_ENGLISH);

  //RefreshServerConnection;
  LoadPOSColor;
  
end;

procedure TFrmMRPDV.ShowBarcodeOption;
begin
   pnlDiscount.Visible     := False;
   pnlPayments.Visible     := False;
   pnlPaymentList.Visible  := False;
   pnlItemDiscount.Visible := False;

   edtDiscountValue.Clear;

   edtBarcode.Visible     := True;
   fSearchItemMode        := ITEM_MODE_QTY_BARCODE;
   ChangeSearchItemMode;

   if edtBarcode.CanFocus then
   begin
     edtBarcode.SelectAll;
     edtBarcode.SetFocus;
   end;

end;

procedure TFrmMRPDV.ClearItem;
begin
   ClearItemDiscount;
   ShowBarcodeOption;
end;


procedure TFrmMRPDV.ClearHold;
begin
   CancelHold;

   PreSale.Clear;
   PreSale.IDStore        := DM.fStore.ID;
   PreSale.TaxExempt      := DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE];
   PreSale.RoundDecimalTo := PDV_PRICE_DECIMAL_LENGTH;

   lbDisplay.Caption := '';
   lbDisplay.Visible := False;

   lvwItems.Clear;

   lbTotal.Caption := FormatFloat('0.00', 0);
   lbItems.Caption := sProducts;


   pnlSubtotal.Visible := False;

   lbPDVHint.Caption       := sNexCustomer;
   lbDescription.Caption   := '';
   lbSubtotal.Caption      := '';
   pnlSubTotalDisc.Visible := False;

   ClearItemDiscount;

   fSearchItemMode       := ITEM_MODE_QTY_BARCODE;
   ChangeSearchItemMode;

   lbTotalDiscount.Caption := FormatFloat('0.00', 0);
   pblInvoiceDiscount.Visible := False;

   lvwPayments.Clear;
   pnlPaymentList.Visible := False;
   panel1.Visible := True;

   RefreshPreSaleInfo(False);

   lbDiscount.Tag := HOLD_CLEAR;

   LoadPDVImage(DM.fModuloFiscal.PDVImage);

   ClearSuggestItems;

   lbFInfo.Visible := UsaECF;

   ApplyAllItemsDiscount := False;

   pnlTEFDed.Visible := False;
   pnlSaleInfo.Visible := True;

   sTmpUserName := SalesPersonInfo.UserName;

   DM.ClearCupomFiscal;

end;

procedure TFrmMRPDV.LoadCashInfo;
begin
  lbOperator.Caption := DM.fUser.UserName;
  lbCashReg.Caption  := DM.fCashRegister.Name;

  SalesPersonInfo.IDUser           := DM.fUser.ID;
  SalesPersonInfo.UserName         := DM.fUser.UserName;
  SalesPersonInfo.IDCommission     := DM.fUser.IDCommission;
  SalesPersonInfo.IDCommissionType := DM.fUser.IDCommissionType;
  PreSale.SaleBelowCostPrice       := Password.HasFuncRight(4);
end;

function TFrmMRPDV.PayHold: Boolean;
var
  sCupom: String;
begin
  try
    if (DM.fCashRegister.FiscalPrinter) then
      DM.OpenCashRegister;

    sCupom := CupomAberto;

    Result := FechaFiscal();

    if not Result then
      CancelaCupom
    else
      PreSale.CouponOpened := False;

    if Result then
    begin
      Result := SavePay;
    end;

    HandleTEF(Result);

    HandleStoreAccount;
    
    //Pole Display
    if DM.fStartPoleDisplay then
      DM.PoleDisplayCloseSale;

    //Salva as quantidades vendidas para xml  
    DMPDV.SaveQtySold;

  finally
    DMPDV.CanTransferFile := True;
    ClearItem;
  end;
end;

function TFrmMRPDV.HandleTEF(Print: Boolean): Boolean;
begin

  Result := True;

  case DM.fCashRegister.UseTef of
    TEF_DIAL:
      begin
        if DM.TEFDial1.TemPendencia then
          if Print then
          begin
            if Result then
              Result := DM.TEFDial1.ConfirmaTransacao
            else
              repeat
              until DM.TEFDial1.ResolvePendencias;
          end
          else
            repeat
            until DM.TEFDial1.ResolvePendencias;
      end;
    TEF_DEDICADO:
    begin
      if DM.TEFDedicado1.TemPendencia then
        if Print then
        begin
          if Result then
            Result := DM.TEFDedicado1.ConfirmaTransacao
          else
            repeat
            until DM.TEFDedicado1.ResolvePendencias;
        end
        else
          repeat
          until DM.TEFDedicado1.ResolvePendencias;
    end;
  end;

end;


procedure TFrmMRPDV.SetPayment;
begin
  edtPayValue.Text := MyFloatToStr(Payments.BalanceTotal);
  if edtPayValue.CanFocus then
  begin
    edtPayValue.SelectAll;
    edtPayValue.SetFocus;
  end;
end;

function TFrmMRPDV.ValidadeItem(var Barcode, Qty: String): Boolean;
var
  sBarcode : String;
begin
  sBarcode := Barcode;
  Result := True;

  if Pos('*', sBarcode) <> 0 then
    begin
    Qty     := Copy(sBarcode, 0, Pos('*', sBarcode)-1);
    { A Quantidade não pode ser maior que 3 dígitos(9999). Para evitar do usuário
      passar o código de barras duas vezes
      Qty recebe valor branco para que seja gerado uma exceção.
    }

    if Length((Copy(Qty, Pos(DecimalSeparator, Qty) + 1, Length(Qty)))) > 3 then
      Qty := '';

    Barcode := Copy(sBarcode,Pos('*', sBarcode)+1,Length(sBarcode));
    end
  else
    begin
    Qty     := '1';
    Barcode := sBarcode;
    end;

  try
    StrToFloat(Qty);
  Except
    Result := False;
    end;

end;

function TFrmMRPDV.ChangePayment(Var ATEFCallInfo : TTEFCallInfo):Boolean;
var
  FrmPDVPayments: TFrmPDVPayments;
  MP: TMeioPagamento;
  FIDCustomer : Integer;
begin

  {
  if (PreSale.PreSaleInfo.CustomerInfo <> nil) then
    FIDCustomer := PreSale.PreSaleInfo.CustomerInfo.IDCustomer
  else
    FIDCustomer := 1;
  }
  
   FrmPDVPayments := TFrmPDVPayments.Create(Self);
   try
     Result := FrmPDVPayments.Start(PreSale, MyStrToMoney(edtPayValue.Text), MP, ATEFCallInfo);
     if Result then
        begin
        SetMeioPag(MP);
        end;
   finally
     FrmPDVPayments.Free;
   end;
end;


function TFrmMRPDV.AbreCupom: String;
var
  sCPFCNPJ: String;
begin
  Result := '';
  if UsaECF then
     begin
     if DM.EFiscal1.TemCupom then
        DM.EFiscal1.CancelaCupomAtual;
     (*
     HOMOLOGAÇÃO DEDICADO

     !!! REVISAR !!!

     *)
     DM.EFiscal1.FechaCupomVinculadoSemErro('');
     DM.EFiscal1.FechaRelatorioGerencial;

     if not VerificaGaveta then
       Exit;

     if (PreSale.PreSaleInfo <> nil) and (PreSale.PreSaleInfo.CustomerInfo <> nil) then
       sCPFCNPJ := PreSale.PreSaleInfo.CustomerInfo.CPF
     else
       sCPFCNPJ := '';

     if DM.fCashRegister.AskCPF and (sCPFCNPJ = '') then
     begin
       sCPFCNPJ := InputBox('Informar o CPF', 'CPF :', '');
       sCPFCNPJ := ReturnNumber(sCPFCNPJ);
       if (sCPFCNPJ <> '') then
       begin

         if DM.fCashRegister.ValidateCPF then
         begin
           if (Length(sCPFCNPJ) <> 11) and (Length(sCPFCNPJ) <> 14) then
           begin
             MsgBox('Documento inválido!', vbOKOnly + vbInformation);
             Exit;
           end;

           if ((Length(sCPFCNPJ) = 11) and (not ValidaCPF(sCPFCNPJ))) or
              ((Length(sCPFCNPJ) = 14) and (not ValidaCNPJ(sCPFCNPJ))) then
             begin
             MsgBox(MSG_CRT_INVALID_DOCUMENT + '('+sCPFCNPJ+')', vbCritical + vbOkOnly);
             Exit;
             end;
         end;

         if (PreSale.PreSaleInfo.CustomerInfo = nil) then
           CreateDefaults;

         PreSale.PreSaleInfo.CustomerInfo.CPF := sCPFCNPJ;

       end;

     end;

     if not DM.EFiscal1.AbreCupomFiscal(sCPFCNPJ) then
        Exit;
     DM.EFiscal1.NumeroCupom(Result);
     end
  else
    Result := CUPOM_VAZIO;
end;

procedure TFrmMRPDV.PreSaleBeforeAddPreSaleItem(var PSI: TPreSaleItem;
  var Sucess: Boolean);
begin
  //Inserir item na impressora fiscal
  if UsaECF then
  begin
    PrintItems;
    Sucess := PrintItem(PSI);
  end
  else
     Sucess := True;
end;

function TFrmMRPDV.RemovePontoVirgula(S: String): String;
begin
  Result := StringReplace(StringReplace(S, ',', '', [rfReplaceAll]), '.', '', [rfReplaceAll]);
end;

function TFrmMRPDV.FechaFiscal(): Boolean;
var
  I: Integer;
  TryAgain: Boolean;
  PagTotal: Currency;
  strFecha, Note, AC: String;
begin
  if UsaECF then
    begin
      bHasStoreAccout := False;

      if PreSale.InvoiceDiscount < 0 then
        AC := 'A'
      else
        AC := 'D';

      Note := GetCupomMessage;

      strFecha := FISCAL_FECHA_NOTA_ACRES_DESC+ AC + ';' +
      FISCAL_FECHA_NOTA_TIPO_ACRES_DESC  + '$;' +
      FISCAL_FECHA_NOTA_VALOR_ACRES_DESC + MyFormatCur(Abs(PreSale.InvoiceDiscount), DM.fModuloFiscal.Decimal)+';'+
      FISCAL_FECHA_NOTA_TIPO_PAGAMENTO   + {cmbPaymentType.Text +} ';' +
      FISCAL_FECHA_NOTA_MSG              + 'Volte Sempre' + ';' +
      FISCAL_FECHA_NOTA_VALOR_PAGO       + MyFormatCur(PreSale.SaleTotal - PreSale.DiscountTotal - PreSale.InvoiceDiscount, DM.fModuloFiscal.Decimal) +';'+
      FISCAL_ITEM_PONTO_DEC              + DM.fModuloFiscal.Decimal+';' +
      FISCAL_FECHA_NOTA_IDX_PAGAMENTO    + {CodFiscal+}';';


      with DM.EFiscal1 do
      begin
        TryAgain := True;
        repeat
         Result := IniFechCupfisc(strFecha);
         Sleep(SLEEP_FECHAR_CUPOM);
         if not Result then
           TryAgain := TentaDeNovo;
        until Result or (not TryAgain);

        if Result Then
          for I := 0 to Payments.Count - 1 do
            with Payments.Items[I] do
            begin
              PagTotal := Amount;

              if (I = (Payments.Count - 1)) then
                PagTotal := PagTotal + Payments.ChangeTotal;

              TryAgain := True;

              repeat
                Result := EfetuaFormaPagamento(DescFiscal, PagTotal, CodFiscal);
                Sleep(SLEEP_FECHAR_CUPOM);
                if not Result then
                  TryAgain := TentaDeNovo;
              until Result or (not TryAgain);

              if not Result Then
                Break;

              if (CupomAberto <> '') and Result then
                CupomAberto := '';

              if Payments.Items[I].Tipo = PAYMENT_TYPE_STOREACCOUNT then
                bHasStoreAccout := True;

              //Result := PreencherCheck(IDMeioPag);}
              if not Result Then
                Break;
            end;

         if Result then
           repeat
              Result := TermFechCupFisc(Note);
              Sleep(SLEEP_FECHAR_CUPOM);
              if not Result then
               TryAgain := TentaDeNovo;
           until Result or (not TryAgain);

      end;
    end
  else
  begin
    Result := True;
    PreSale.InvObs := GetCupomMessage;
  end;

  if (CupomAberto <> '') and Result then
    CupomAberto := '';
end;

function TFrmMRPDV.TentaDeNovo: Boolean;
begin
  Result := (MsgBox('A Impressora não responde. Tentar novamente ?', vbYesNo + vbQuestion) = vbYes);
end;

function TFrmMRPDV.ValidateDiscount(var Code: String; var Value:Currency;
                                 var cType, cOperat : Char):Boolean;
var
  HasDisocunt,
  FoundType : Boolean;
  Disc, Temp : string;
  i : Integer;
begin
  Result   := True;
  Value    := 0;
  cType    := '0';
  cOperat  := '0';

  Temp := UpperCase(Code);

  HasDisocunt := ((Pos('D',Temp)>0) and (Pos('$',Temp)>0)) or
                 ((Pos('D',Temp)>0) and (Pos('%',Temp)>0));

  if HasDisocunt then
  begin
     if (Pos('$',Temp)>0) then
        cOperat := '$'
     else if (Pos('%',Temp)>0) then
        cOperat := '%';

     FoundType := False;

     for i := Pos(cOperat,Temp)-1 downto 0 do
     begin
       if Temp[i] in ['D'] then
       begin
          cType     := Temp[i];
          FoundType := True;
          Break;
       end;

       Disc := Temp[i] + Disc;
     end;

     if not FoundType then
     begin
       Result := True;
       Exit;
     end;

     try
       if cOperat = '$' then
          Value := StrToCurr(Disc)
       else
         if cOperat = '%' then
            Value := StrToFloat(Disc);
     except
        Result := False;
     end;


     for i := Pos(cOperat,Temp) downto 0 do
     begin
       if Temp[i] in ['D'] then
       begin
          Delete(Temp, i, 1);
          Break;
       end;
       Delete(Temp, i, 1);
     end;


     Code := Temp;

  end;

end;

procedure TFrmMRPDV.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SalesPersonInfo);
  FreeAndNil(SellingItem);
  inherited;
end;

function TFrmMRPDV.SaveAbortaPreSale(Cupom : String): Boolean;
var
  Error : String;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SaveAbortaPreSale');

  Result := True;
  Error  := '';

  try
    case DM.PersistenceType of
      ptDB: begin
              if (PreSale.IDPreSale <> -1) and (PreSale.CouponOpened) and (not PreSale.Imported) then
                DM.fPOS.DeleteHold(fIDCashRegMov, DM.fUser.ID, PreSale);
            end;


      ptTXT: begin
               if (PreSale.COO <> '') and (PreSale.CouponOpened) then
               begin
                 Error := DM.SaleWritter.AbortSale(Cupom);
                 Result := (Error = '');
               end;
             end;
    end;

    if not Result then
      Exception.Create('SaveAbortaPreSale');

    PreSale.CouponOpened := False;

  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

function TFrmMRPDV.SavePreSale: Boolean;
var
  FIDPreSale: Integer;
  Error: String;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SavePreSale');

  Result := True;
  Error  := '';
  try
    CreateDefaults;

    case DM.PersistenceType of
      ptDB:
      begin
        if (PreSale.IDPreSale <> -1) and DM.HoldExist(PreSale.IDPreSale) then
        begin
          Result := DM.DeleteHoldItens(PreSale.IDPreSale);
          if Result then
            Result := DM.fPOS.UpdateCupomFiscal(PreSale.IDPreSale, PreSale.COO);
        end
        else
        begin
          Result := DM.fPOS.CreateHold(DELIVER_TYPE_ONHAND,
                                      False,
                                      PreSale.IDStore,
                                      PreSale.PreSaleInfo.CustomerInfo.FirstName,
                                      PreSale.PreSaleInfo.CustomerInfo.LastName,
                                      PreSale.PreSaleInfo.CustomerInfo.Zip,
                                      0,
                                      PreSale.PreSaleDate,
                                      PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                      PreSale.PreSaleInfo.MediaInfo.IDMedia,
                                      0,
                                      PreSale.InvObs,
                                      PreSale.PreSaleInfo.CustomerInfo.CPF,
                                      FIDPreSale);

          PreSale.SaleCode := DM.fPOS.CreateSaleCode(FIDPreSale,
                                                     0,
                                                     PreSale.IDStore,
                                                     PreSale.COO,
                                                     PreSale.PuppyTracker,
                                                     Presale.SerialECF);

          if Result then
          begin
            PreSale.IDPreSale := FIDPreSale;
            //Isentar a taxa do Main Retail, pois no Brazil a taxa ja vem no produto
            if PreSale.TaxExempt then
              Result := DM.fPOS.ExemptTax(fIDPreSale, True);
          end;
        end;
      end;

      ptTXT:
      begin
        PreSale.SaleCode := DM.CreateSaleCodeTXT(PreSale.COO);
        Error := DM.SaleWritter.CreateHold(DELIVER_TYPE_ONHAND,
                                           False,
                                           PreSale.IDStore,
                                           PreSale.PreSaleInfo.CustomerInfo.FirstName,
                                           PreSale.PreSaleInfo.CustomerInfo.LastName,
                                           PreSale.PreSaleInfo.CustomerInfo.Zip,
                                           0,
                                           PreSale.PreSaleDate,
                                           PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                           PreSale.PreSaleInfo.MediaInfo.IDMedia,
                                           0,
                                           '',
                                           PreSale.SaleCode,
                                           PreSale.COO,
                                           PreSale.TaxExempt,
                                           PreSale.IDPreSale,
                                           PreSale.PuppyTracker,
                                           PreSale.SerialECF,
                                           PreSale.CCF);
        Result := (Error = '');
      end;
    end;

    SaleHeaderSaved := Result;

    if Result then
      PreSale.CouponOpened := True
    else
      Exception.Create('SavePreSale');

      
  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

function TFrmMRPDV.SaveClient: Boolean;
var
  Error : String;
begin

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SaveClient');

  if (CupomAberto = '') or ((PreSale.Count = 0) and not UsaECF) then
  begin
    CupomAberto := AbreCupom;
    if CupomAberto = '' then
      Exit;

    //PAF-ECF  
    if DM.fCupomFiscal.DataHora = 0 then
      PreSale.PreSaleDate := Now
    else
      PreSale.PreSaleDate := DM.fCupomFiscal.DataHora;

    PreSale.CCF         := DM.fCupomFiscal.CCF;
    PreSale.COO         := CupomAberto;
  end;

  if not PreSale.CouponOpened then
  begin
    PreSale.CouponOpened := True;
    SavePreSale;
  end;


  Result := True;
  try
      case DM.PersistenceType of
        ptDB :
        begin
          Result := DM.fPOS.AddCustomer(1, 1,
                                     DM.fStore.ID,
                                     PreSale.IDPreSale,
                                     PreSale.PreSaleInfo.CustomerInfo.FirstName,
                                     PreSale.PreSaleInfo.CustomerInfo.LastName,
                                     PreSale.PreSaleInfo.CustomerInfo.Endereco,
                                     PreSale.PreSaleInfo.CustomerInfo.Cidade,
                                     PreSale.PreSaleInfo.CustomerInfo.Bairro,
                                     PreSale.PreSaleInfo.CustomerInfo.Zip,
                                     PreSale.PreSaleInfo.CustomerInfo.CPF,
                                     PreSale.PreSaleInfo.CustomerInfo.Telefone,
                                     PreSale.PreSaleInfo.CustomerInfo.Estado,
                                     PreSale.PreSaleInfo.CustomerInfo.TelDDD,
                                     PreSale.PreSaleInfo.CustomerInfo.CelDDD,
                                     PreSale.PreSaleInfo.CustomerInfo.Celelular,
                                     PreSale.PreSaleInfo.CustomerInfo.Email,
                                     PreSale.PreSaleInfo.CustomerInfo.WebSite,
                                     PreSale.PreSaleInfo.CustomerInfo.CPF,
                                     PreSale.PreSaleInfo.CustomerInfo.Identidate,
                                     PreSale.PreSaleInfo.CustomerInfo.OrgEmiss,
                                     PreSale.PreSaleInfo.CustomerInfo.CustCard,
                                     PreSale.PreSaleInfo.CustomerInfo.CMotorista,
                                     PreSale.PreSaleInfo.CustomerInfo.NomeJuridico,
                                     PreSale.PreSaleInfo.CustomerInfo.InscEstadual,
                                     PreSale.PreSaleInfo.CustomerInfo.InscMunicipal,
                                     PreSale.PreSaleInfo.CustomerInfo.Contato,
                                     PreSale.PreSaleInfo.CustomerInfo.OBS,
                                     PreSale.PreSaleInfo.CustomerInfo.Juridico,
                                     PreSale.PreSaleInfo.CustomerInfo.ExpDate,
                                     PreSale.PreSaleInfo.CustomerInfo.BirthDate
                                     );
        end;

        ptTXT:
        begin
          Error := DM.SaleWritter.AddCustomer(1, 1,
                                     PreSale.PreSaleInfo.CustomerInfo.FirstName,
                                     PreSale.PreSaleInfo.CustomerInfo.LastName,
                                     PreSale.PreSaleInfo.CustomerInfo.Endereco,
                                     PreSale.PreSaleInfo.CustomerInfo.Cidade,
                                     PreSale.PreSaleInfo.CustomerInfo.Bairro,
                                     PreSale.PreSaleInfo.CustomerInfo.Zip,
                                     PreSale.PreSaleInfo.CustomerInfo.CPF,
                                     PreSale.PreSaleInfo.CustomerInfo.Telefone,
                                     PreSale.PreSaleInfo.CustomerInfo.Estado,
                                     PreSale.PreSaleInfo.CustomerInfo.TelDDD,
                                     PreSale.PreSaleInfo.CustomerInfo.CelDDD,
                                     PreSale.PreSaleInfo.CustomerInfo.Celelular,
                                     PreSale.PreSaleInfo.CustomerInfo.Email,
                                     PreSale.PreSaleInfo.CustomerInfo.WebSite,
                                     PreSale.PreSaleInfo.CustomerInfo.CPF,
                                     PreSale.PreSaleInfo.CustomerInfo.Identidate,
                                     PreSale.PreSaleInfo.CustomerInfo.OrgEmiss,
                                     PreSale.PreSaleInfo.CustomerInfo.CustCard,
                                     PreSale.PreSaleInfo.CustomerInfo.CMotorista,
                                     PreSale.PreSaleInfo.CustomerInfo.NomeJuridico,
                                     PreSale.PreSaleInfo.CustomerInfo.InscEstadual,
                                     PreSale.PreSaleInfo.CustomerInfo.InscMunicipal,
                                     PreSale.PreSaleInfo.CustomerInfo.Contato,
                                     PreSale.PreSaleInfo.CustomerInfo.OBS,
                                     PreSale.PreSaleInfo.CustomerInfo.Juridico,
                                     PreSale.PreSaleInfo.CustomerInfo.ExpDate,
                                     PreSale.PreSaleInfo.CustomerInfo.BirthDate
                                     );
          Result := (Error = '');

        end;
      end;

  ClientSaved := Result;

  if not Result then
    Exception.Create('SaveClient');

  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
    
end;

function TFrmMRPDV.SaveDeletedItem(Position: Integer; Item: TPreSaleItem;
   IDUserAuto: Integer; iPos : Integer): Boolean;
var
  Error: String;
  iEr : Integer;
begin
  Result := True;
  Error  := '';
  try
    with Item do
    begin

    case DM.PersistenceType of
      ptDB:
        begin
         Result := DM.fPOS.AddRemovedItem(DM.fCashRegister.IDDefault, Item.IDModel, Item.IDStore,
                                            Item.IDDepartment, Position, Item.Qty, Item.Discount,
                                            Item.Sale, Item.Cost, 0, Item.IDUser, IDUserAuto, Item.IDCommis,
                                            Now, PreSale.COO, Item.TotalizadorParcial, Null, PreSale.IDPreSale);

         Result := DM.fPOS.DeleteHoldItem(PreSale.IDPreSale, Item.IDPreInvMov,
                                          Item.IDModel, DM.fUser.ID,
                                          Item.Qty, Item.Discount, Item.Sale,
                                          True, True, now, iEr);
        end;

      ptTXT:
        begin
          Error := DM.SaleWritter.CancelItem(Position);
          Result := (Error = '');
        end;
      end;

    end;

  if not Result then
    Exception.Create('SaveDeletedItem');

  DMPDV.AddQtySold(Item.IDModel, (Item.Qty * -1));

  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;
end;

function TFrmMRPDV.SavePreSaleItemSerial(Item: TPreSaleItem;
  ItemSerial: TPreSaleItemSerial): Boolean;
var
  Error : String;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SavePreSaleItemSerial');

  Result := True;
  Error := '';
  try
    case DM.PersistenceType of
      ptDB:
      begin
        Result := DM.fPOS.AddItemSerial(Item.IDPreInvMov, ItemSerial.SerialNumber, ItemSerial.IdentificationNumber);
      end;

      ptTXT:
      begin
        Result := DM.SaleWritter.AddSerialNumber(PreSale.Count-1, ItemSerial.SerialNumber, ItemSerial.IdentificationNumber);
      end;
    end;

  if not Result then
    Exception.Create('SavePreSaleItemSerial');

  except
    on E: Exception do
    begin
      Result := False;
      Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

function TFrmMRPDV.SavePreSaleItem(Item: TPreSaleItem): Boolean;
var
  iError,
  iIDPreInventMov: Integer;
  Error: String;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SavePreSaleItem');

  Result := True;
  Error  := '';

  with Item do
    try
      case DM.PersistenceType of
        ptDB:
        begin
          Result := DM.fPOS.AddHoldItem(PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                        PreSale.IDPreSale,
                                        Item.IDModel,
                                        Item.IDStore,
                                        Item.Qty,
                                        Item.Discount,
                                        Item.Sale,
                                        Item.Cost,
                                        Item.IDUser,
                                        Item.IDCommis,
                                        0,
                                        PreSale.PreSaleDate,
                                        Now,
                                        False,
                                        True,
                                        iError,
                                        iIDPreInventMov,
                                        0,
                                        False,
                                        Item.IDDescriptionPrice,
                                        Item.IDVendorPrice,
                                        Item.SuggPrice,
                                        Item.DocumentNumber,
                                        Item.IDDocumentType,
                                        Item.ECFIndex,
                                        Item.TotalizadorParcial);
                                        
          Result := Result and (iError = 0);
          if Result then
            Item.IDPreInvMov := iIDPreInventMov;
        end;

        ptTXT:
        begin
          Error := DM.SaleWritter.AddHoldItem(PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                              PreSale.IDPreSale,
                                              Item.IDModel,
                                              Item.IDStore,
                                              Item.IDDepartment,
                                              Item.Qty,
                                              Item.Discount,
                                              Item.Sale,
                                              Item.Cost,
                                              Item.IDUser,
                                              Item.IDCommis,
                                              PreSale.PreSaleDate,
                                              Now,
                                              False,
                                              True,
                                              Item.IDDescriptionPrice,
                                              Item.IDVendorPrice,
                                              Item.SuggPrice,
                                              Item.DocumentNumber,
                                              Item.IDDocumentType,
                                              Item.TotalizadorParcial);
          Result := (Error = '');
        end;
      end;

      if not Result then
        Exception.Create('SavePreSaleItem');
    except
      on E: Exception do
      begin
        Result := False;
        if Error = '' then
          Error := E.Message;
        MsgBox(Error, vbCritical + vbOkOnly);
      end;
    end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

function TFrmMRPDV.SavePreSalePayment(Payment: TPayment): Boolean;
var
  I: Integer;
  Error: String;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SavePreSalePayment');

  Result := False;
  Error  := '';
  try
    case DM.PersistenceType of
      ptDB:
        begin
          for I := 0 to Payment.Count - 1 do
          begin
            Result := DM.fPOS.AddPayment(PreSale.IDPreSale,
                                         DM.fStore.ID,
                                         DM.fUser.ID ,
                                         PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                         Payment.IDMeioPag,
                                         fIDCashRegMov,
                                         PreSale.PreSaleDate,
                                         Payment.Items[I].ExpireDate,
                                         Payment.Items[I].Parcela,
                                         Payment.Items[I].Autorization,
                                         Payment.Items[I].Value,
                                         Payment.Items[I].NumeroDoc,
                                         Payment.Items[I].DocCliente,
                                         Payment.Items[I].NomeCliente,
                                         Payment.Items[I].Telefone,
                                         Payment.Items[I].IDBanco,
                                         Payment.Items[I].OBS,
                                         Payment.PaymentPlace,
                                         Payment.PartialPay);

            if not Result then
              Exit;
          end;
        end;

      ptTXT:
        begin
          for I := 0 to Payment.Count - 1 do
          begin
            Error := DM.SaleWritter.AddPayment(PreSale.IDPreSale,
                                         DM.fStore.ID,
                                         DM.fUser.ID ,
                                         PreSale.PreSaleInfo.CustomerInfo.IDCustomer,
                                         Payment.IDMeioPag,
                                         fIDCashRegMov,
                                         PreSale.PreSaleDate,
                                         Payment.Items[I].ExpireDate,
                                         Payment.Items[I].Parcela,
                                         Payment.Items[I].Autorization,
                                         Payment.Items[I].Value,
                                         Payment.Items[I].NumeroDoc,
                                         Payment.Items[I].DocCliente,
                                         Payment.Items[I].NomeCliente,
                                         Payment.Items[I].Telefone,
                                         Payment.Items[I].IDBanco,
                                         Payment.Items[I].OBS,
                                         Payment.PaymentPlace,
                                         Payment.PartialPay,
                                         Payment.Tipo);
            Result := Error = '';
            if not Result then
              Exit;
          end;
        end;
    end;

  if not Result then
    Exception.Create('SavePreSalePayment');

  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

function TFrmMRPDV.SavePay: Boolean;
var
  fIDInvoice: Integer;
  Error : String;
  ParamError: String;
  fScaleDifference, fDBPreSaleTotal, fPreSaleTotal : Currency;
begin
  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceIn('TFrmMRPDV.SavePay');

  fScaleDifference := 0;

  //Acerto de centavos para colocar a direfenca da balanca como desconto na nota
  if DM.fCashRegister.BarcodeScaleCheck then
    fScaleDifference := PreSale.ScaleDifference;
  
  Result := False;
  Error  := '';
  try
    case DM.PersistenceType of
      ptDB:
      begin

        fDBPreSaleTotal := DM.fPOS.GetPreSaleTotal(PreSale.IDPreSale);
        fPreSaleTotal   := PreSale.SaleTotal - PreSale.DiscountTotal - PreSale.InvoiceDiscount;

        if (fPreSaleTotal <> fDBPreSaleTotal) then
          fScaleDifference := (Abs(fDBPreSaleTotal - fPreSaleTotal) * -1);

        if (fScaleDifference <> 0) then
          Result := DM.fPOS.ManageDiscount(PreSale.IDPreSale, (PreSale.InvoiceDiscount + fScaleDifference))
        else
          Result := True;

        if Result then
          Result :=  DM.fPOS.PreSalePay(PreSale.IDPreSale,
                                        PreSale.PreSaleInfo.TouristGroup.IDTouristGroup,
                                        PreSale.IDOtherComiss,
                                        fIDCashRegMov,
                                        DM.fStore.ID,
                                        Now, Now,
                                        Payments.GetPaymentsAmount(PAYMENT_TYPE_CASH) + Payments.ChangeTotal,
                                        0,
                                        PreSale.CCF, //PAF
                                        fIDInvoice,
                                        ParamError);
      end;
      ptTXT:
      begin
        Error :=  DM.SaleWritter.PreSalePay(PreSale.IDPreSale,
                                      PreSale.PreSaleInfo.TouristGroup.IDTouristGroup,
                                      PreSale.IDOtherComiss,
                                      fIDCashRegMov,
                                      DM.fStore.ID,
                                      Now,
                                      DM.fCupomFiscal.DataHora,
                                      Payments.GetPaymentsAmount(PAYMENT_TYPE_CASH) + Payments.ChangeTotal,
                                      (PreSale.InvoiceDiscount + fScaleDifference));

        Result := (Error = '');
      end;
    end;

  if not Result then
    Exception.Create('SavePay');


  except
    on E: Exception do
    begin
      Result := False;
      if Error = '' then
        Error := E.Message;
      MsgBox(Error, vbCritical + vbOkOnly);
    end;
  end;

  if Assigned(DM.FTraceControl) then
    DM.FTraceControl.TraceOut;
end;

procedure TFrmMRPDV.CreateDefaults;
begin
  if PreSale.PreSaleInfo.CustomerInfo = nil then
  begin
    PreSale.PreSaleInfo.CustomerInfo := TCustomerInfo.Create;
    with PreSale.PreSaleInfo.CustomerInfo do
      IDCustomer := PDV_CUSTOMER_DEFAULT;
  end;

  if PreSale.PreSaleInfo.MediaInfo = nil then
  begin
    PreSale.PreSaleInfo.MediaInfo := TMediaInfo.Create;
    with PreSale.PreSaleInfo.MediaInfo do
    begin
      IDMedia := DM.fCashRegister.IDMedia;
    end;
  end;

  if PreSale.PreSaleInfo.TouristGroup = nil then
  begin
    PreSale.PreSaleInfo.TouristGroup := TTouristGroup.Create;
    with PreSale.PreSaleInfo.TouristGroup do
    begin
      IDTouristGroup := 0;
    end;
  end;

  if PreSale.PreSaleInfo.CommissionGroup = nil then
  begin
    PreSale.PreSaleInfo.CommissionGroup := TCommissionGroup.Create;
    with PreSale.PreSaleInfo.CommissionGroup do
    begin
      IDCommisionGroup := 0;
    end;
  end;
end;

procedure TFrmMRPDV.CallDiscount;
begin
  lbDescription.Caption   := '';
  lbSubtotal.Caption      := '';
  pnlSubTotalDisc.Visible := False;
  lbProdInfo.Visible      := False;
  lbSalePrice.Visible     := False;
  edtBarcode.Visible      := False;
  pnlPayments.Visible     := False;
  pnlItemDiscount.Visible := False;
  pnlDiscount.Visible     := True;

  ClearItemDiscount;

  lbDiscount.Tag := lbDiscount.Tag + 1;

  Case lbDiscount.Tag of
     HOLD_DISCOUNT_PERCENT: lbDiscount.Caption := sDiscountPer;
     HOLD_DISCOUNT_VALUE:   lbDiscount.Caption := sDiscountDollar;
     HOLD_ADSITION_PERCENT: lbDiscount.Caption := sAdditionPer;
     HOLD_ADDITION_VALUE:   lbDiscount.Caption := sAdditionDollar;
     else
       begin
         lbDiscount.Tag     := HOLD_DISCOUNT_PERCENT;
         lbDiscount.Caption := sDiscountPer;
       end;
  end;

  if edtDiscountValue.CanFocus then
     begin
     edtDiscountValue.SelectAll;
     edtDiscountValue.SetFocus;
     end;
end;

procedure TFrmMRPDV.edtDiscountValuePressEnter(Sender: TObject);
var
  DT: TDiscountType;
  DVT: TDiscountValueType;

  ADiscountValue: Currency;
begin
  Case lbDiscount.Tag of
     HOLD_DISCOUNT_PERCENT:
     begin
       DT  := tdtDesconto;
       DVT := dvtPerc;
     end;

     HOLD_DISCOUNT_VALUE:
     begin
       DT  := tdtDesconto;
       DVT := dvtValor;
     end;

     HOLD_ADSITION_PERCENT:
     begin
       DT  := tdtAcrescimo;
       DVT := dvtPerc;
     end;

     HOLD_ADDITION_VALUE:
     begin
       DT  := tdtAcrescimo;
       DVT := dvtValor;
     end

     else
     begin
       DT  := tdtDesconto;
       DVT := dvtPerc;
     end;
  end;


  ADiscountValue := ABS(MyStrToMoney(edtDiscountValue.Text));

  (*  DESCONTO FRACIONARIO NAO PERMITIDO NESTA VERSAO - REMOVER - INICIO *)

  if (DT  = tdtDesconto) and (DVT = dvtPerc) and (Frac(ADiscountValue) > 0) then
    raise exception.Create('Desconto percentual fracionário não permitido nessa versão.');

  (*  DESCONTO FRACIONARIO NAO PERMITIDO NESTA VERSAO - REMOVER - FIM *)



  PreSale.InvoiceDiscount := PreSale.CalcDiscount(DT, DVT, ADiscountValue);

  lbTotalDiscount.Caption := FormatFloat('#,##0.00', PreSale.InvoiceDiscount);
  pblInvoiceDiscount.Visible := (PreSale.InvoiceDiscount <> 0);

  if DM.PersistenceType = ptDB then
    DM.fPOS.ManageDiscount(PreSale.IDPreSale, PreSale.InvoiceDiscount);

  RefreshItem;
  ClearItem;
  CallPayments;

  if DM.fStartPoleDisplay then
    DM.PoleDisplayInvInfo(PreSale.SaleCode,
                          PreSale.PreSaleDate,
                          0,
                          PreSale.DiscountTotal,
                          0,
                          PreSale.SaleTotal,
                          True);


end;

procedure TFrmMRPDV.RefreshDiscountItems;
var
  i : Integer;
begin
  //for i := 0
  
end;

procedure TFrmMRPDV.PaymentsPartialPay(Payment: TPayment; Lista: TList;
  var Sucess: Boolean);
begin
  inherited;
  with TFrmEnterPayments.Create(Self) do
    Sucess := Start(Payment, PreSale.PreSaleInfo, Lista);
end;

procedure TFrmMRPDV.CommitTransaction;
begin
  case DM.PersistenceType of
    ptDB: DM.ADODBConnect.CommitTrans;
  end;
end;

procedure TFrmMRPDV.RollbackTransaction;
begin
  case DM.PersistenceType of
    ptDB: DM.ADODBConnect.RollbackTrans;
  end;
end;

procedure TFrmMRPDV.StartTransaction;
begin
  case DM.PersistenceType of
    ptDB: DM.ADODBConnect.BeginTrans;
  end;
end;


function TFrmMRPDV.PrintReceipt: Boolean;
begin

  Result := True;
  
  if (DM.fCashRegister.FiscalPrinter) then
  begin
    if UsaECF then
      Exit;
  end;

  if (not DM.fPrintReceipt.PrintReceipt) then
     Exit;

  try
    with TPrintReceipt.Create(Self) do
         Start(PreSale, Payments, PreSale.IDPreSale, RECEIPT_TYPE_INVOICE{RECEIPT_TYPE_HOLD}, fIDCashRegMov);
  Except
    on E: Exception do
       begin
       //PushError(CRITICAL_ERROR, 'FrmFastSale.PrintDocument.Exception' + #13#10 + E.Message);
       Result := False;
       end;
  end;

end;

procedure TFrmMRPDV.RefreshChange;
var
  fTotal : Currency;
  AAmountToPay: Currency;
begin
  AAmountToPay := ABS(MyStrToMoney(edtPayValue.Text));
  if PreSale.PreSaleType = tptRefund then
    AAmountToPay := AAmountToPay * -1;
  lbSubtotal.Caption      := '';
  lbDescription.Caption   := '';
  pnlSubTotalDisc.Visible := False;
  fTotal                := Payments.InvoiceTotal - AAmountToPay - Payments.GetPaymentsAmount();

  if (((fTotal < 0) and (PreSale.PreSaleType <> tptRefund)) or ((fTotal > 0) and (PreSale.PreSaleType = tptRefund))) and (Payments.InvoiceTotal <> 0) then
  begin
    lbSubtotal.Caption    := MyFloatToStr(fTotal * -1);

    if PreSale.PreSaleType = tptRefund then
      lbDescription.Caption := sRest
    else
      lbDescription.Caption := sChange;
  end;
end;

procedure TFrmMRPDV.edtPayValueChange(Sender: TObject);
begin
  inherited;
  RefreshChange;
end;

procedure TFrmMRPDV.lvwItemsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if lvwItems.Selected = nil then
     Exit;

  Case Key of
    VK_UP, VK_DOWN,
    VK_PRIOR,
    VK_NEXT : RefreshItemInfo(lvwItems.Selected);
   end;

end;

procedure TFrmMRPDV.lvwItemsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if lvwItems.Selected = nil then
     Exit;

  RefreshItemInfo(lvwItems.Selected);

end;

procedure TFrmMRPDV.RefreshItemInfo(Item: TListItem);
begin
  if Item = nil then
    LoadPDVImage('')
  else
     begin
     lbDescription.Caption := TPreSaleItem(Item.Data).Description;
     //lbSubtotal.Caption    := FormatFloat('#,##0.00', TPreSaleItem(Item.Data).Sale/TPreSaleItem(Item.Data).Qty);
     lbSubtotal.Caption    := FormatFloat('#,##0.00', TPreSaleItem(Item.Data).Sale);


     if TPreSaleItem(Item.Data).Discount > 0 then
     begin
       pnlSubTotalDisc.Visible := True;
       lbSubDe.Caption         := FormatFloat('#,##0.00', (TPreSaleItem(Item.Data).Sale));
       lbSubPor.Caption        := FormatFloat('#,##0.00', TPreSaleItem(Item.Data).Sale - (TPreSaleItem(Item.Data).Discount/TPreSaleItem(Item.Data).Qty));
     end else
       pnlSubTotalDisc.Visible := False;

     LoadPDVImage(TPreSaleItem(Item.Data).ImagePath);
     end
end;

procedure TFrmMRPDV.PreSaleAfterAddPreSaleItem(PSI: TPreSaleItem;
  var Sucess: Boolean);
begin
  inherited;

  if (PSI.RequestCustomer and (not lbDisplay.Visible) and
     (PreSale.PreSaleInfo.CustomerInfo = Nil)) then
     begin
     lbDisplay.Caption := sNeedCustomer;
     lbDisplay.Visible := True;
     end;

  Try
    DMPDV.OpenSuggestions(PreSale.Items[PreSale.Count-1].IDModel);

    with DMPDV.cdsModelAccessory do
      if RecordCount > 0 then
         begin
         First;
         While not EOF do
           begin
           PreSale.AddItemSuggestion(DMPDV.cdsModelAccessory.FieldByName('Model').AsString,
                                     DMPDV.cdsModelAccessory.FieldByName('Description').AsString,
                                     DMPDV.cdsModelAccessory.FieldByName('Hint').AsString,
                                     DMPDV.cdsModelAccessory.FieldByName('SellingPrice').AsCurrency);
           Next;
           end;
         end;
  finally
    DMPDV.CloseSuggestions;
    end;

  BuildSuggestItems;

end;

procedure TFrmMRPDV.LoadPDVImage(ImagePath:String);
begin
   if (ImagePath <> '') and (FileExists(ImagePath)) then
      imgPDV.Picture.LoadFromFile(ImagePath)
   else if FileExists(DM.fModuloFiscal.PDVImage) then
      imgPDV.Picture.LoadFromFile(DM.fModuloFiscal.PDVImage);
end;

procedure TFrmMRPDV.BuildSuggestItems;
var
  i        : integer;
  sDescrip,
  sHint    : String;
begin
  if PreSale.SuggestCount = 0 then
     Exit;

  lsbSuggestion.Items.Clear;

  for i:=0 to PreSale.SuggestCount-1 do
    begin
    sDescrip := IncSpaces(PreSale.SuggestItems[i].FModel, 30) + IncLeftSpaces(FormatFloat('#,##0.00', PreSale.SuggestItems[i].FSalePrice),10);
    sHint    := '  ' + PreSale.SuggestItems[i].FOBS;
    lsbSuggestion.Items.Add(sDescrip);
    lsbSuggestion.Items.Add(sHint);
    end;

  lsbSuggestion.Visible := True;

end;

procedure TFrmMRPDV.ClearSuggestItems;
begin
  lsbSuggestion.Visible := False;
end;

procedure TFrmMRPDV.edtPayValueKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if PreSale.PreSaleType = tptInvoice then
    Key := ValidatePositiveCurrency(Key)
  else
    Key := ValidateCurrency(Key);

  if Key = ThousandSeparator then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end;
end;

procedure TFrmMRPDV.lbSCSearchClick(Sender: TObject);
begin
  inherited;
  StartOptions(TLabel(Sender).Tag);
end;

procedure TFrmMRPDV.lbSCSearchMouseLeave(Sender: TObject);
begin
  inherited;
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TFrmMRPDV.lbSCSearchMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TFrmMRPDV.lbSCLayawayClick(Sender: TObject);
begin
  inherited;

  if FileExists(DM.fCashRegister.MainRetail) then
     ExecuteFile(Trim(DM.fCashRegister.MainRetail), PARAM_START_LAYAWAY, '', SW_SHOW);

end;

procedure TFrmMRPDV.lbSCInvAdjustClick(Sender: TObject);
begin
  inherited;

  if FileExists(DM.fCashRegister.MainRetail) then
     ExecuteFile(Trim(DM.fCashRegister.MainRetail), PARAM_START_INVENT_ADJST, '', SW_SHOW);

end;

function TFrmMRPDV.AddCustomerIfNeeded(ACheckItem: Boolean): Boolean;
var
  bNeedCustomer: Boolean;
  I : Integer;
begin
  Result := True;

  if (PreSale.PreSaleInfo.CustomerInfo <> nil) and (PreSale.PreSaleInfo.CustomerInfo.FirstName <> '') then
    Exit;

  bNeedCustomer := False;

  if ACheckItem then
  begin
    for I := 0 to PreSale.Count - 1 do
    begin
      bNeedCustomer := bNeedCustomer or PreSale.Items[I].RequestCustomer;
      if bNeedCustomer then
        Break;
    end;
  end
  else
    bNeedCustomer := MeioPagamento.RequireCustomer;

  if bNeedCustomer then
    Result := AddCustomer;

end;

procedure TFrmMRPDV.PreSaleBeforeDoInvoiceDiscount(ADiscountPerc: Currency;
  var AAccept: Boolean);
begin
  inherited;
  AAccept := True;
  if not Password.HasFuncRight(9) then
    AAccept := DMPDV.TestInvoiceDiscRange(SalesPersonInfo.IDCommissionType, PreSale.SaleTotal, ADiscountPerc);
end;

procedure TFrmMRPDV.RefreshServerConnection;
begin
  imgServerOut.Visible := not DMPDV.ServerActive;
  imgServerRun.Visible := not imgServerOut.Visible;
end;

procedure TFrmMRPDV.ChangeSearchItemMode;
begin
  if fSearchItemMode = ITEM_MODE_QTY_BARCODE then
  begin
    edtBarcode.Text := sQtyBarcode;
  end
  else
  begin
    edtBarcode.Text := sQtyModel;
  end;

  if Self.Visible and (edtBarcode.CanFocus) then
  begin
    edtBarcode.SelectAll;
    edtBarcode.SetFocus;
  end;

end;

procedure TFrmMRPDV.FormActivate(Sender: TObject);
begin
  inherited;
    Height := Screen.Height;
    Width  := Screen.Width;
end;

function TFrmMRPDV.PrintItem(var PSI: TPreSaleItem) : Boolean;
var
  sItem: String;
  dValorTeste: double;
begin
  Result := False;

  if not HasCupom then
  begin
    CupomAberto := AbreCupom;
    if CupomAberto = '' then
      Exit;
    PreSale.COO  := CupomAberto;
    Payments.COO := PreSale.COO;
    Payments.TEFType := DM.fCashRegister.UseTef;
    if UsaECF then
    begin
      if (SaleHeaderSaved) or (ClientSaved) then
        RebuildTextSale;
    end;
  end;

  //Inserir item na impressora fiscal
  if PSI.TotalInformed <> 0 then
     dValorTeste := PSI.TotalInformed
  else
     dValorTeste := (PSI.Qty * PSI.Sale);


  sItem :=  FISCAL_ITEM_COD         + PSI.Model                           + ';' + //Model
            FISCAL_ITEM_DESCRIP     + PSI.Description                     + ';' + //Descricao
            FISCAL_ITEM_ALIQ        + PSI.ECFTaxIndex                     + ';' + //Tributo - Nome da taxa
            FISCAL_ITEM_QTY         + RemovePontoVirgula(FormatFloat('0000.000', PSI.Qty))     + ';' + //Qty
            FISCAL_ITEM_VALOR_UNIT  + MyFormatCur(PSI.Sale, DM.fModuloFiscal.Decimal)    + ';' + //Valor
            FISCAL_ITEM_VALOR_DESC  + MyFormatCur(ABS(PSI.Discount), DM.fModuloFiscal.Decimal)     + ';' + //Desconto
            FISCAL_ITEM_VALOR_TOTAL + MyFormatCur(TruncMoney(dValorTeste, 2), DM.fModuloFiscal.Decimal)+ ';' + //Valor total
            FISCAL_ITEM_TIPO_QTY    + 'F;' + // 'I' para Inteira ou 'F' para Fracionária
            FISCAL_ITEM_CASA_DEC    + '2;' + // iDecimal := 2
            FISCAL_ITEM_TIPO_DESC   + '$;' + // % ou $
            FISCAL_ITEM_PONTO_DEC   +  DM.fModuloFiscal.Decimal + ';';

  PSI.Printed := DM.EFiscal1.VendeItem(sItem);
  Result := PSI.Printed;
end;

function TfrmMRPDV.HasCupom: Boolean;
begin
  Result := not ((CupomAberto = '') or (CupomAberto = CUPOM_VAZIO));
end;

function TfrmMRPDV.TestFiscal: Boolean;
begin
  Result := not HasCupom;
  if not Result then
    MsgInvalidOperation
end;

procedure TfrmMRPDV.MsgInvalidOperation;
begin
  MsgBox('Operação Inválida !!!', vbCritical + vbOkOnly);
end;

procedure TFrmMRPDV.LoadPOSColor;
begin

   lbTotal.Font.Color          := DM.fMRPOSColor.POSValuesColor;
   lbSubtotal.Font.Color       := DM.fMRPOSColor.POSValuesColor;
   edtPayValue.Font.Color      := DM.fMRPOSColor.POSValuesColor;
   edtDiscountValue.Font.Color := DM.fMRPOSColor.POSValuesColor;
   lbSubDe.Font.Color          := DM.fMRPOSColor.POSValuesColor;
   lbSubPor.Font.Color         := DM.fMRPOSColor.POSValuesColor;

   lsbSuggestion.Font.Color   := DM.fMRPOSColor.POSTextColor;
   Label4.Font.Color          := DM.fMRPOSColor.POSTextColor;
   lblMedia.Font.Color        := DM.fMRPOSColor.POSTextColor;
   lblCustomerName.Font.Color := DM.fMRPOSColor.POSTextColor;
   lbAddress.Font.Color       := DM.fMRPOSColor.POSTextColor;
   lbOperator.Font.Color      := DM.fMRPOSColor.POSTextColor;
   lbDay.Font.Color           := DM.fMRPOSColor.POSTextColor;
   lbRefundInfo.Font.Color    := DM.fMRPOSColor.POSTextColor;
   lbCashReg.Font.Color       := DM.fMRPOSColor.POSTextColor;
   lbFInfo.Font.Color         := DM.fMRPOSColor.POSTextColor;
   Label1.Font.Color          := DM.fMRPOSColor.POSTextColor;
   lbDescription.Font.Color   := DM.fMRPOSColor.POSTextColor;
   lbPDVHint.Font.Color       := DM.fMRPOSColor.POSTextColor;
   lbMRInfo.Font.Color        := DM.fMRPOSColor.POSTextColor;
   lblOperador.Font.Color     := DM.fMRPOSColor.POSTextColor;
   lblCliente.Font.Color      := DM.fMRPOSColor.POSTextColor;


   edtBarcode.Font.Color      := DM.fMRPOSColor.POSBarcodeTextColor;
   lbDiscount.Font.Color      := DM.fMRPOSColor.POSBarcodeTextColor;
   lbPayment.Font.Color       := DM.fMRPOSColor.POSBarcodeTextColor;
   lbWithdraw.Font.Color      := DM.fMRPOSColor.POSBarcodeTextColor;

end;


function TFrmMRPDV.TestFiscalToogle: Boolean;
begin
   if UsaECF then
       Result := DM.fModuloFiscal.ValidateSystemDate
   else
     begin
       Result := TestFiscal;
     end;
end;

procedure TFrmMRPDV.edtDiscountValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if PreSale.PreSaleType = tptInvoice then
    Key := ValidatePositiveCurrency(Key)
  else
    Key := ValidateCurrency(Key);

  if Key = ThousandSeparator then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end;
end;

procedure TFrmMRPDV.PreSaleItemDiscount(PSI: TPreSaleItem;
  var AAccept: Boolean);
var
  AIDUser: Integer;
begin
  inherited;
  AAccept := Password.AquireAccess(9, MSG_INF_DISCOUNT_LIMT_REACHED, AIDUser);
end;

procedure TFrmMRPDV.PrintItems;
var
  I: Integer;
  PSI: TPreSaleItem;
begin
  if not HasCupom then
    for I := 0 to PreSale.Count - 1 do
    begin
      PSI := PreSale.Items[I];
      if not PSI.Printed then
        PrintItem(PSI);
    end;
end;

function TFrmMRPDV.GetCupomMessage: String;
begin

  Result := DM.fPrintReceipt.ECFRodape;

  if (Result <> '') and (Pos(']', Result)>0) then
  begin
    if Assigned(PreSale.PreSaleInfo.CustomerInfo) then
    begin
      Result := StringReplace(Result, '[CLIENTE]', PreSale.PreSaleInfo.CustomerInfo.FirstName + ' ' + PreSale.PreSaleInfo.CustomerInfo.LastName, []);
      Result := StringReplace(Result, '[DOC]', PreSale.PreSaleInfo.CustomerInfo.CPF, []);

      if PreSale.PreSaleInfo.CustomerInfo.Endereco <> '' then
        Result := StringReplace(Result, '[ENDERECO]', PreSale.PreSaleInfo.CustomerInfo.Endereco + ' - ' +
                                                      PreSale.PreSaleInfo.CustomerInfo.Bairro + ' - ' +
                                                      PreSale.PreSaleInfo.CustomerInfo.Cidade, [])
      else
        Result := StringReplace(Result, '[ENDERECO]', '', []);

    end
    else
    begin
      Result := StringReplace(Result, '[CLIENTE]', '', []);
      Result := StringReplace(Result, '[DOC]', '', []);
      Result := StringReplace(Result, '[ENDERECO]', '', []);
    end;

    if Assigned(PreSale.PreSaleInfo.MediaInfo) then
      Result := StringReplace(Result, '[MIDIA]', PreSale.PreSaleInfo.MediaInfo.MediaName, [])
    else
      Result := StringReplace(Result, '[MIDIA]', '', []);

    Result := StringReplace(Result, '[VENDEDOR]', sTmpUserName, []);

    Result := StringReplace(Result, '[INVOBS]', PreSale.InvObs, []);

  end;

end;


procedure TFrmMRPDV.CallItemDiscount;
begin

  lbDescription.Caption   := '';
  lbSubtotal.Caption      := '';
  pnlSubTotalDisc.Visible := False;
  lbProdInfo.Visible      := False;
  lbSalePrice.Visible     := False;
  edtBarcode.Visible      := False;
  pnlPayments.Visible     := False;
  pnlDiscount.Visible     := False;
  pnlItemDiscount.Visible := True;

  lbItemDiscount.Tag := lbItemDiscount.Tag + 1;

  Case lbItemDiscount.Tag of
     HOLD_DISCOUNT_PERCENT: lbItemDiscount.Caption := sDiscountItemPer;
     HOLD_DISCOUNT_VALUE:   lbItemDiscount.Caption := sDiscountItemDollar;
     else
       begin
         lbItemDiscount.Tag     := HOLD_DISCOUNT_PERCENT;
         lbItemDiscount.Caption := sDiscountItemPer;
       end;
  end;

  if edtItemDiscValue.CanFocus then
     begin
     edtItemDiscValue.SelectAll;
     edtItemDiscValue.SetFocus;
     end;

end;

procedure TFrmMRPDV.edtItemDiscValuePressEnter(Sender: TObject);
var
  ADiscountValue: Currency;
begin
  inherited;

  ADiscountValue := ABS(MyStrToMoney(edtItemDiscValue.Text));

  if ADiscountValue = 0 then
  begin
    ClearItemDiscount;
  end
  else
  begin
    Case lbItemDiscount.Tag of
       HOLD_DISCOUNT_PERCENT:
       begin
         lbDescription.Caption := Replace(sDiscItemPerHint, '%f', edtItemDiscValue.Text);
         fItemDiscount         := 'd'+edtItemDiscValue.Text+'%';
       end;

       HOLD_DISCOUNT_VALUE:
       begin
         lbDescription.Caption := Replace(sDiscItemDollarHint, '%f', FormatFloat('0.00', ADiscountValue));
         fItemDiscount         := 'd'+edtItemDiscValue.Text+'$';
       end;
    end;
  end;

  edtItemDiscValue.Text := '0';
  ShowBarcodeOption;

end;

procedure TFrmMRPDV.ClearItemDiscount;
begin
  fItemDiscount := '';
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando1(Sender: TObject;
  Msg: String);
begin
  lblOperador.Caption := Msg;
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando2(Sender: TObject;
  Msg: String);
begin
  inherited;
  lblCliente.Caption := Msg;
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando3(Sender: TObject;
  Msg: String);
begin
  inherited;
  lblOperador.Caption := Msg;
  lblCliente.Caption := Msg;
  pnlTEFDed.Visible := True;
  pnlSaleInfo.Visible := False;
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando11(Sender: TObject);
begin
  lblOperador.Caption := '';
  Application.ProcessMessages;
  pnlTEFDed.Visible := True;
  pnlSaleInfo.Visible := False;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando12(Sender: TObject);
begin
  inherited;
  lblCliente.Caption := '';
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando13(Sender: TObject);
begin
  lblOperador.Caption := '';
  lblCliente.Caption := '';
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1LimpaMsg(Sender: TObject);
begin
  lblOperador.Caption := '';
  lblCliente.Caption := '';
  Application.ProcessMessages;
end;

procedure TFrmMRPDV.TefDedicadoInterface1ExecutaComando22(Sender: TObject; Msg: String);
begin
  inherited;

  if Length(Msg) < 50 then
    MsgBox(Msg, vbInformation + vbOKOnly)
  else
    DM.MsgBoxScroll(Msg);

end;

procedure TFrmMRPDV.RefreshPoleDisplayConnection;
begin
  if DM.fPoleDisplay.FIP = '' then
  begin
    imgPoleOff.Visible := False;
    lbOperator.Left    := 28;
  end
  else
  begin
    imgPoleOff.Visible := not DM.PoleDisplayStatus;
    if imgPoleOff.Visible then
      lbOperator.Left := 47
    else
      lbOperator.Left := 28;
  end;
end;

procedure TFrmMRPDV.imgPoleOffClick(Sender: TObject);
begin
  inherited;
  DM.RefreshPoleDisplay;
end;

procedure TFrmMRPDV.GetChoosedPrice(IDStore, IDModel: Integer; var IDVendorPrice: Integer;
  var IDDescriptionPricecSuggPrice: Integer; var SuggPrice: Currency;
  var SellingPrice: Currency);
var
  oSearch: TObject;
begin
  DMPDV.OpenTablePrice(IDStore, IDModel);

  with TFrmSearchOption.Create(Self) do
    try
       if StartOption(OP_TABLEPRICE, oSearch) and (oSearch <> nil) then
       begin
         IDVendorPrice := TPreSaleItemPrice(oSearch).IDVendorPrice;
         IDDescriptionPricecSuggPrice := TPreSaleItemPrice(oSearch).IDDescriptionPrice;
         SuggPrice := TPreSaleItemPrice(oSearch).SuggPrice;
         SellingPrice := TPreSaleItemPrice(oSearch).SalePrice;
       end;
  finally
    FreeAndNil(oSearch);
    Free;
  end;

  DMPDV.CloseTablePrice;
end;

function TFrmMRPDV.HasTablePrice(IDStore, IDModel: Integer): Boolean;
begin
  DMPDV.OpenTablePrice(IDStore, IDModel);
  Result := (not DMPDV.cdsStoreTablePrice.IsEmpty) or (not DMPDV.cdsModelTablePrice.IsEmpty);
  DMPDV.CloseTablePrice;
end;

procedure TFrmMRPDV.GetEnteredDocument(var ADocumentNumber: String;
  var AIDDocumentNumber: Integer);
begin
  with TFrmAskDocument.Create(Self) do
  try
    if Start then
    begin
      ADocumentNumber := DocumentNumber;
      AIDDocumentNumber := IDDocumentType;
    end;
  finally
    Free;
  end;
end;

function TFrmMRPDV.VerificaGaveta: Boolean;
var
  iEstado : Integer;
begin

  Result := True;

  if DM.fCashRegister.FiscalPrinter then
    if DM.fCashRegister.SellDrawerClosed then
    begin
      DM.EFiscal1.VerificaEstadoGaveta(iEstado);
      Result := (iEstado = 0);
      lbGavetaAberta.Visible := not Result;
      Application.ProcessMessages;
    end;

end;


function TFrmMRPDV.RebuildTextSale: Boolean;
var
  I: Integer;
begin
  Result := False;
  case DM.PersistenceType of
    ptTXT:
      begin
        SaveAbortaPreSale(CUPOM_VAZIO);
        SavePreSale;
        if ClientSaved then
          SaveClient;
        for I := 0 to PreSale.Count - 1 do
          SavePreSaleItem(PreSale.Items[I]);
      end;
  end;
end;

procedure TFrmMRPDV.AbrirBalanca;
begin
  if DM.fCashRegister.POSScaleCheck then
  begin
    if DM.fCashRegister.POSScaleType = BAL_TIPO_POS_FILIZOLA then
    begin
      FBalanca                        := TBalanca.Create(Self);
      FBalanca.ScaleModel             := DM.fCashRegister.ScaleModel;
      FBalanca.ScaleCommType          := DM.fCashRegister.ScaleCommunicationType;
      FBalanca.ScaleSerialPort        := DM.fCashRegister.ScaleSerialPort;
      FBalanca.ScalePortEthernet      := DM.fCashRegister.ScalePortEthernet;
      FBalanca.ScaleBaudRate          := DM.fCashRegister.ScaleBaudRate;
      FBalanca.ScaleDecimal           := DM.fCashRegister.ScaleDecimal;
      if not FBalanca.OpenScale then
        lblCliente.Caption := 'Balança não inicializada!'
      else
        lblCliente.Caption := '';
     end;
  end;
end;

procedure TFrmMRPDV.FecharBalanca;
begin
   if DM.fCashRegister.POSScaleCheck then
   begin
     if DM.fCashRegister.POSScaleType = BAL_TIPO_POS_FILIZOLA then
       FreeAndNil(FBalanca);
   end;
end;

function TFrmMRPDV.MontaValor(pValor: String): Double;   //Ike
begin
   try
    result := MyStrToMoney(Copy(pValor,1,3) + DecimalSeparator + Copy(pValor, 4, 2));
   except
    result := 0;
   end;
end;

procedure TFrmMRPDV.SaveInvObs(AOBS: String);
begin

  case DM.PersistenceType of
    ptDB:
      begin
       if PreSale.IDPreSale <> -1 then
         DM.fPOS.AddHoldObs(PreSale.IDPreSale, AOBS);
      end;

    ptTXT:
      begin
        DM.SaleWritter.SaveObs(AOBS);
      end;
    end;

end;

procedure TFrmMRPDV.VerifyCashOverFlow;
begin
  lbWithdraw.Visible := ((FTotalCashSale - FTotalCashAllowed) > 0);
end;

function TFrmMRPDV.VerificaBalanca: Boolean;
begin
  Result := DM.fCashRegister.BarcodeScaleCheck;
end;

function TFrmMRPDV.CorrigirQtyFracionaria(AQty: String): Double;
begin

  Result := MyStrToFloat(AQty);

  if HasDecimal(Result) then
    Result := DMPDV.TruncarDecimal(Result, 3);

end;

procedure TFrmMRPDV.AppMessage(var Msg: TMSG; var HAndled: Boolean);
begin

  // let your application handle all messages initially
  Handled := False;
  case Msg.Message of
    WM_SYSKEYDOWN:
      if Msg.wParam = VK_F4 then
        Handled := True; // don't allow ALT-F4
  end;

end;

procedure TFrmMRPDV.lbSCNewSaleClick(Sender: TObject);
begin
  inherited;
  StartOptions(TLabel(Sender).Tag);
end;

procedure TFrmMRPDV.lbMenuFiscalClick(Sender: TObject);
begin
  inherited;
  with TFrmMenufiscal.Create(Self) do
    Start;
end;

function TFrmMRPDV.ValidaDescricaoItemPDV(ADescricao: String): Boolean;
var
 j : Integer;
 DescTeste : String;

begin
  Result := False;
  DescTeste := ADescricao;

  for j := Length(DescTeste) downto 1 do
    begin
      if (DescTeste[j] in ['A'..'Z', 'a'..'z']) then
      begin
        Result := True;
        Break;
      end
    end;
end;

procedure TFrmMRPDV.HandleStoreAccount;
var
  I, J : Integer;
  sResult : String;
  bClosed, bResult : Boolean;
  FStoreAccList : TStringList;
  APayment : TPayment;
begin

    //Imprimir Para venda convenio.
  if UsaECF and bHasStoreAccout then
    with DM.EFiscal1 do
    try

        bClosed := False;

        FStoreAccList := TStringList.Create;

        for J := 0 to Payments.Count-1 do
          for I := 0 to TPayment(Payments.Items[J]).Count-1 do
            if (TPayment(Payments.Items[J]).Tipo = PAYMENT_TYPE_STOREACCOUNT) then
            begin
              APayment := TPayment(Payments.Items[J]);
              FStoreAccList.Add('Vencimento: ' + FormatDateTime('ddddd', TPartialPay(APayment.Items[I]).ExpireDate) +
                                '  Valor : ' + FormatFloat('#,##0.00', TPartialPay(APayment.Items[I]).Value));
            end;

        AbreRelatorioGerencial('0');

        RelatorioGerencial(' ***********  CREDITO DA LOJA ***********  ');
        RelatorioGerencial(' ');
        RelatorioGerencial('Vendedor  : ' + DM.fUser.UserName);
        RelatorioGerencial('Data      : ' + FormatDateTime('ddddd hh:mm', Now));
        RelatorioGerencial('COO       : ' + PreSale.SaleCode);
        RelatorioGerencial('Cliente   : ' + PreSale.PreSaleInfo.CustomerInfo.FirstName + ' ' + PreSale.PreSaleInfo.CustomerInfo.LastName);
        RelatorioGerencial('Parcela(s):');
        for i := 0 to FStoreAccList.Count-1 do
          RelatorioGerencial(FStoreAccList.Strings[i]);
        RelatorioGerencial(' ');
        RelatorioGerencial(' ');
        RelatorioGerencial(' ');
        RelatorioGerencial('Ass: ___________________________________');
        RelatorioGerencial('       ' + PreSale.PreSaleInfo.CustomerInfo.FirstName + ' ' + PreSale.PreSaleInfo.CustomerInfo.LastName);
        if (PreSale.PreSaleInfo.CustomerInfo.CPF <> '') then
          RelatorioGerencial('CPF: ' + PreSale.PreSaleInfo.CustomerInfo.CPF);
        if (PreSale.PreSaleInfo.CustomerInfo.Identidate <> '') then
          RelatorioGerencial('ID : ' + PreSale.PreSaleInfo.CustomerInfo.Identidate);
        RelatorioGerencial(' ');
        RelatorioGerencial('Reconheço e pagarei o valor acima. ');
        RelatorioGerencial(' ');
        RelatorioGerencial(' ');
        RelatorioGerencial(' ');
        RelatorioGerencial(' ');

        bClosed := True;

    finally

      if FStoreAccList <> nil then
        FreeAndNil(FStoreAccList);

      FechaRelatorioGerencial;

      if bClosed then
      begin
        DM.fCupomFiscal.DataHora := DataImpressora;

        case Impressora of
          BematechMP20, BematechMP40:
          begin
            DM.fCupomFiscal.COO := 0;
            DM.fCupomFiscal.GNF := 0;
            DM.fCupomFiscal.CDC := 0;
          end;

          BematechTermica:
          begin
            NumeroCupom(sResult);
            DM.fCupomFiscal.COO := StrToInt(sResult);

            NumeroOperacoesNaoFiscais(sResult);
            DM.fCupomFiscal.GNF := StrToInt(sResult);

            ContadorComprovantesCreditoMFD(sResult);
            DM.fCupomFiscal.CDC := StrToInt(sResult);
          end;

          DarumaTerm:
          begin
            RetornaInformacao('26', 6, sResult);
            DM.fCupomFiscal.COO := StrToInt(sResult);

            RetornaInformacao('28', 6, sResult);
            DM.fCupomFiscal.GNF := StrToInt(sResult);

            RetornaInformacao('45', 4, sResult);
            DM.fCupomFiscal.CDC := StrToInt(sResult);
          end;

          Elgin:
          begin
            NumeroCupom(sResult);
            DM.fCupomFiscal.COO := StrToInt(sResult);

            NumeroOperacoesNaoFiscais(sResult);
            DM.fCupomFiscal.GNF := StrToInt(sResult);

            ContadorComprovantesCreditoMFD(sResult);
            DM.fCupomFiscal.CDC := StrToInt(sResult);
          end;

        end;

        case DM.PersistenceType of
          ptDB: DM.fPOS.AddVinculadoInfo(PreSale.IDPreSale,
                                DM.fCupomFiscal.COO,
                                DM.fCupomFiscal.GNF,
                                DM.fCupomFiscal.CDC,
                                DM.fCupomFiscal.DataHora);

          ptTXT: DM.SaleWritter.AddVinculadoInfo(DM.fCupomFiscal.COO,
                                DM.fCupomFiscal.GNF,
                                DM.fCupomFiscal.CDC,
                                DM.fCupomFiscal.DataHora);
        end;
      end;
    end;

end;

end.
