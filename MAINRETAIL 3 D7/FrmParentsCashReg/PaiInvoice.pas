unit PaiInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, DBTables,
  MemoStr, DateBox, uPreSaleItem,  ComCtrls, Buttons, uPrintReceipt,
  ADODB, SuperComboADO, SMDBGrid, Spin, uParentAll, siComp, siLangRT;

type
  TFrmPaiInvoice = class(TFrmParentAll)
    Panel4: TPanel;
    pnlPreSale: TPanel;
    btAddItem: TSpeedButton;
    btRemoveItem: TSpeedButton;
    lblSubTotal: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    dsPreSaleInfo: TDataSource;
    quPreSaleInfo: TADOQuery;
    EditSubTotal: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    btDiscountItem: TSpeedButton;
    dsPreSaleValue: TDataSource;
    Label19: TLabel;
    EditPreSaleDate: TDBEdit;
    lblInvoiceDate: TLabel;
    dsPreSaleItem: TDataSource;
    TmrRefreshItem: TTimer;
    spquPreSaleItem: TADOStoredProc;
    spquPreSaleItemDescription: TStringField;
    spquPreSaleItemQty: TIntegerField;
    spquPreSaleItemSalePrice: TFloatField;
    spquPreSaleItemDiscount: TFloatField;
    spquPreSaleItemIDInventoryMov: TIntegerField;
    spquPreSaleItemTotalItem: TFloatField;
    spquPreSaleValue: TADOStoredProc;
    spquPreSaleValueTaxIsent: TBooleanField;
    spquPreSaleValueSubTotal: TFloatField;
    spquPreSaleValueItemDiscount: TFloatField;
    spquPreSaleValueTax: TFloatField;
    spquPreSaleValueTaxPrc: TFloatField;
    spquPreSaleValueDiscountPrc: TFloatField;
    spquPreSaleValueTotalInvoice: TFloatField;
    spTestRefresh: TADOStoredProc;
    spquPreSaleValueSpecialPriceID: TIntegerField;
    spquPreSaleValueSpecialPrice: TStringField;
    quDiscRange: TADOQuery;
    dsDiscRange: TDataSource;
    quDiscRangeTotVendaMin: TFloatField;
    quDiscRangePercDiscMax: TFloatField;
    pnlUsers: TPanel;
    EditOpenUser: TDBEdit;
    Label9: TLabel;
    spquPreSaleValuenOpenUser: TIntegerField;
    spquPreSaleValueShowOpenUser: TIntegerField;
    spquPreSaleItemModelID: TIntegerField;
    spquPreSaleItemModel: TStringField;
    quPayMin: TADOQuery;
    dsPayMin: TDataSource;
    btSerial: TSpeedButton;
    spquPreSaleItemSalesPerson: TStringField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPayMinDifDay: TIntegerField;
    quPayMinTotalSale: TFloatField;
    quPayMinIDMeioPag: TIntegerField;
    pgInvoice: TPageControl;
    tbTourist: TTabSheet;
    tbDeliver: TTabSheet;
    tbDeposit: TTabSheet;
    tbNote: TTabSheet;
    tbDiscount: TTabSheet;
    EditNote: TDbMemoStr;
    cmbPayType: TDBSuperComboADO;
    Label17: TLabel;
    quDescTourist: TADOQuery;
    quDescCustomer: TADOQuery;
    quDescTouristTipTouristGroup: TStringField;
    Label20: TLabel;
    Label21: TLabel;
    Shape1: TShape;
    quPreSaleInfoIDPreSale: TIntegerField;
    pnlPessoa: TPanel;
    EditCustomer: TEdit;
    btDetCliente: TSpeedButton;
    pnlOther: TPanel;
    Label3: TLabel;
    cmbOther: TDBSuperComboADO;
    Panel5: TPanel;
    Label7: TLabel;
    dbSpecialPrice: TDBEdit;
    btMakeSpecialPrice: TSpeedButton;
    quPreSaleInfoMediaID: TIntegerField;
    Panel7: TPanel;
    btDetGroup: TSpeedButton;
    Panel8: TPanel;
    cmbDelType: TDBSuperComboADO;
    EditDelDate: TDBDateBox;
    EditDelAddress: TDBEdit;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Panel9: TPanel;
    Label11: TLabel;
    Label8: TLabel;
    EditAmountDisc: TEdit;
    Panel10: TPanel;
    btTaxIsent: TSpeedButton;
    spPayVisa: TSpeedButton;
    spPayMaster: TSpeedButton;
    spPayAmerican: TSpeedButton;
    Label10: TLabel;
    EditDepositDate: TDBDateBox;
    spquPreSaleItemIDComission: TIntegerField;
    spquPreSaleItemCostPrice: TFloatField;
    lblTourGroup: TLabel;
    pnlSpecialPrice: TPanel;
    Label2: TLabel;
    EditFullTotal: TEdit;
    tbPrint: TTabSheet;
    Panel12: TPanel;
    btImpHold: TBitBtn;
    Panel13: TPanel;
    btImpHoldHotel: TBitBtn;
    btChangeTourGuide: TSpeedButton;
    btUpHold: TSpeedButton;
    spUpHold: TADOStoredProc;
    Label23: TLabel;
    spquPreSaleItemExchangeInvoice: TIntegerField;
    spquPreSaleValueNewSubTotal: TFloatField;
    lblTotalLine: TLabel;
    btChangeUser: TSpeedButton;
    EditInvoiceDate: TDBEdit;
    pnlSpecialDiscount: TPanel;
    btSpecialPrice: TSpeedButton;
    Label1: TLabel;
    spnSpecialDiscount: TSpinEdit;
    btApplyPriceManager: TBitBtn;
    spquPreSaleItemSuggRetail: TFloatField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoIDStore: TIntegerField;
    spquPreSaleItemSerialNumber: TBooleanField;
    quPreSaleInfoAddress: TStringField;
    pnlTaxIsempt: TPanel;
    Label12: TLabel;
    pnlSubTotalTaxable: TPanel;
    DBEdit1: TDBEdit;
    Label14: TLabel;
    Label18: TLabel;
    spquPreSaleValueTaxIsemptValue: TFloatField;
    spquPreSaleValueSubTotalTaxable: TCurrencyField;
    DBEdit2: TDBEdit;
    Label22: TLabel;
    spquPreSaleValueTaxIsemptItemDiscount: TFloatField;
    spquPreSaleItemIDUser: TIntegerField;
    quPreSaleInfoLayaway: TBooleanField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoZip: TStringField;
    scMedia: TDBSuperComboADO;
    Label24: TLabel;
    Label25: TLabel;
    DBEdit3: TDBEdit;
    pnlInvoiceCustomer: TPanel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label26: TLabel;
    Label27: TLabel;
    spquPreSaleItemTax: TFloatField;
    quDescCustomerPessoaFirstName: TStringField;
    quDescCustomerPessoaLastName: TStringField;
    quVerifyOpenHold: TADOQuery;
    quVerifyOpenHoldnOpenUser: TIntegerField;
    quVerifyOpenHoldnOpenHoldCaixa: TIntegerField;
    quPreSaleInfoPrintNotes: TBooleanField;
    dbPrintNotes: TDBCheckBox;
    grdItems: TSMDBGrid;
    grdDiscRange: TSMDBGrid;
    grdPayMin: TSMDBGrid;
    Panel6: TPanel;
    lblSubMenu: TLabel;
    Panel1: TPanel;
    lblUserName: TLabel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btClose: TButton;
    btCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddItemClick(Sender: TObject);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
    procedure btDiscountItemClick(Sender: TObject);
    procedure btRemoveItemClick(Sender: TObject);
    procedure btMakeSpecialPriceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btTaxIsentClick(Sender: TObject);
    procedure cmbSpecialDiscSelectItem(Sender: TObject);
    procedure TmrRefreshItemTimer(Sender: TObject);
    procedure spquPreSaleItemCalcFields(DataSet: TDataSet);
    procedure spquPreSaleValueCalcFields(DataSet: TDataSet);
    procedure dsPreSaleValueDataChange(Sender: TObject; Field: TField);
    procedure btCancelClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure pgInvoiceChange(Sender: TObject);
    procedure btDetClienteClick(Sender: TObject);
    procedure btDetGroupClick(Sender: TObject);
    procedure quPreSaleInfoAfterOpen(DataSet: TDataSet);
    procedure quPreSaleInfoNewRecord(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spPayVisaClick(Sender: TObject);
    procedure spPayMasterClick(Sender: TObject);
    procedure spPayAmericanClick(Sender: TObject);
    procedure tbDepositExit(Sender: TObject);
    procedure btImpHoldClick(Sender: TObject);
    procedure btImpHoldHotelClick(Sender: TObject);
    procedure btChangeTourGuideClick(Sender: TObject);
    procedure scMediaSelectItem(Sender: TObject);
    procedure btUpHoldClick(Sender: TObject);
    procedure spquPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure btChangeUserClick(Sender: TObject);
    procedure btSpecialPriceClick(Sender: TObject);
    procedure spnSpecialDiscountChange(Sender: TObject);
    procedure btApplyPriceManagerClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdPayMinDblClick(Sender: TObject);
    procedure cmbPayTypeSelectItem(Sender: TObject);
    procedure grdDiscRangeDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdPayMinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdItemsDblClick(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sJoinHolds,
    sAddNumber,
    sChangePrice,
    sApplyPrice,
    sCopyHold,
    sCopyInvoice,
    sInvNum,
    sLayawayNum,
    sHoldNum,
    sHold,
    sReceive,
    sClose,
    sRestorTax,
    sExemptTax,
    sItems : String;

    IsFirst   : Boolean;
    IsInvoice : Boolean;
    IsLayaway  : Boolean;
    IsGenericIDPessoa : Boolean;
    StatusUser, HlpContext : Integer;
    IDPreSale    : Integer;
    OldMedia     : Integer;
    OldTag : Integer;
    FrmPreSaleItem : TFrmPreSaleItem;
    MyPreSaleType, MyIDCashRegMov  : Integer;
    OldRefreshInvoice : Integer;
    MaxVendaMin : Double;
    FechouCupom: Boolean;
    procedure AtuDescCustomer;
    procedure AtuDescTourist;
    procedure ShowDiscRanges;
    function  TestUserComission : Boolean;
    procedure AtuPreSaleControls;
    procedure RefreshInfo;
    procedure RefreshItem(PreInventMovID : Integer);
    procedure RefreshValue;
    procedure CreateParams( var Params: TCreateParams ); override;
    procedure SetTaxIsention(Force : Boolean);

    //Pay Min
    procedure OpenPayMin;
    procedure ClosePayMin;
    procedure RefreshPayMin;

  public
    { Public declarations }
    fCOO: String; // Numero do cupom fiscal
    procedure Start(PreSaleNumber, PreSaleType, IDCashRegMov : Integer);
  protected
    fIsNewInvoice : Boolean;
    procedure PrepareModuloFiscal;
    function CanOpenFiscalInvoice:Boolean;
  end;

var
  SpecialPrice : Integer;

implementation

uses uDM, uMakeSpcPrice, uTaxIsent, uPreSaleReceive, uPassword, uSystemConst,
     uFrmSerialNumber, {uFchTouristGroup, uFrmChangeTourGroup,}
     uAskManager, uFchPessoa, uMsgBox, uMsgConstant,
     uNumericFunctions, uSystemTypes, uDateTimeFunctions, uDMGlobal,
  uFrmReceivePayment;

{$R *.DFM}

procedure TFrmPaiInvoice.PrepareModuloFiscal;
begin
  //Butoes para ficar como enable false no modulo fiscal
  if DM.fCashRegister.Fiscal then
     begin
     btTaxIsent.Enabled          := False;
     btDiscountItem.Visible      := False;
     btMakeSpecialPrice.Enabled  := False;
     btImpHold.Enabled           := False;
     btImpHoldHotel.Enabled      := False;
     btUpHold.Visible            := False;
     btApplyPriceManager.Enabled := True;
     spnSpecialDiscount.ReadOnly := False;
     end;
end;


function TFrmPaiInvoice.CanOpenFiscalInvoice:Boolean;
begin

  Result := True;

  //Cria a nota se for o primeiro item inserido
  if DM.fCashRegister.Fiscal then
     if fIsNewInvoice then
        begin
        FechouCupom := False;
        if not DM.EFiscal1.AbreCupomFiscal(DM.fModuloFiscal.CGC) then
           Result := False;

        if Result Then
          Result := DM.EFiscal1.NumeroCupom(FCOO);

        if Result Then
          Result := DM.DynamicRunSQL(Self, Format('UPDATE Invoice SET CupomFiscal = %S WHERE IDPreSale = %D', [QuotedStr(FCOO), IDPreSale]));

        fIsNewInvoice := False;



        //Isentar a taxa do Main Retail, pois no Brazil a taxa ja vem no produto
        DM.fPOS.ExemptTax(IDPreSale, True);
        end;

end;


procedure TFrmPaiInvoice.ClosePayMin;
begin
  with quPayMin do
     if Active then
        Close;
end;

procedure TFrmPaiInvoice.RefreshPayMin;
begin
    ClosePayMin;

    if cmbPayType.LookUpValue <> '' then
       begin
       quPayMin.Parameters.ParambyName('IDMeioPag').Value := MyStrToInt(cmbPayType.LookUpValue);
       OpenPayMin;
       end;
end;


procedure TFrmPaiInvoice.OpenPayMin;
begin
  with quPayMin do
     if not Active then
        Open;
end;

procedure TFrmPaiInvoice.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  Params.Style := WS_THICKFRAME or WS_POPUP or WS_BORDER;
end;

procedure TFrmPaiInvoice.Start(PreSaleNumber, PreSaleType, IDCashRegMov : Integer);
var
   Action : TCloseAction;
   iOpenHoldCaixa, iOpenHold : integer; //OpenHolds
begin
  IDPreSale       := PreSaleNumber;
  MyPreSaleType   := PreSaleType;
  MyIDCashRegMov  := IDCashRegMov;

  IsFirst    := True;

  // Desabilita refresh do timer
  TmrRefreshItem.Enabled := False;

  OldRefreshInvoice := 0;

  //PreSale Estatico
  RefreshInfo;

  IsInvoice := (quPreSaleInfoIDInvoice.AsString <> '');
  IsLayaway  := quPreSaleInfoLayaway.AsBoolean;
  IsGenericIDPessoa := (quPreSaleInfoIDCustomer.AsInteger = 1);

  // PreSale Items
  RefreshItem(0);

  StatusUser := 0;

  // Teste se deve mostrar o combo de other cost
  pnlOther.Visible := (PreSaleType = SALE_CASHREG);

  if not IsInvoice then
    begin
     TmrRefreshItem.Enabled := True;

     //Testa se o Hold esta aberto
     with quVerifyOpenHold do
       begin
       if Active then
          Close;

       Parameters.ParambyName('IDPreSale').Value := IDPreSale;
       Open;

       iOpenHoldCaixa := quVerifyOpenHoldnOpenHoldCaixa.AsInteger;
       iOpenHold      := quVerifyOpenHoldnOpenUser.AsInteger;

       Close;
       end;

    //Atualiza o qty no OpenHold
    //Hold esta sendo aberto no Caixa
    Case MyPreSaleType of

    SALE_CASHREG : begin
                   try
                      DM.ADODBConnect.BeginTrans;

                      with DM.quFreeSQL do
                          begin
                          If Active then
                             Close;
                          SQL.Clear;
                          SQL.Add('UPDATE Invoice');
                          SQL.Add('SET nOpenHoldCaixa = ' + IntToStr(iOpenHoldCaixa+1) );
                          SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                          ExecSQL;
                          end;

                      DM.ADODBConnect.CommitTrans;

                  except
                      DM.ADODBConnect.RollbackTrans;
                      end;
                  end;

    //Hold esta sendo aberto in PreSale
    SALE_PreSale :  begin
                    try
                       DM.ADODBConnect.BeginTrans;

                       with DM.quFreeSQL do
                           begin
                           If Active then
                              Close;
                           SQL.Clear;
                           SQL.Add('UPDATE Invoice');
                           SQL.Add('SET nOpenUser = ' + IntToStr(iOpenHold+1) );
                           SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                           ExecSQL;
                           end;

                       DM.ADODBConnect.CommitTrans;

                    except
                        DM.ADODBConnect.RollbackTrans;
                        end;
                    end;
    end; //end Case


    //Se o hold estiver sendo usado, ele chama o evento onClose do form
    //OnClose - Fecha todas as Queries e atualza a qty OpenUser
    If iOpenHoldCaixa > 0 then
       begin
       MessageBeep(MB_ICONASTERISK);
       MsgBox(MSG_INF_HOLD_PAYING, vbOKOnly + vbInformation);
       FormClose(nil, Action);
       Exit;
       end;

    If iOpenHold > 0 then
       begin
       MessageBeep(MB_ICONASTERISK);
       if (PreSaleType = SALE_CASHREG) then //foi aberto pelo caixa
          begin
          MsgBox(MSG_INF_HOLD_IS_LOCK, vbOKOnly + vbInformation);
          FormClose(nil, Action);
          Exit;
          end
       else //foi aberto por outro hold
          MsgBox(MSG_INF_HOLD_IS_USING, vbOKOnly + vbInformation);
       MyPreSaleType := SALE_PreSale;
       end;

    end; //end else IsNotInvoice

  // Teste se venda e para Media que isenta taxa automatica
  SetTaxIsention(False);

  // Prepara Controles levando em conta se e master/slave ou Invoice
  AtuPreSaleControls;

  //Zerar a lista de item para impressora fiscal
  if DM.fCashRegister.Fiscal then
     DM.fPOS.InvoiceItem.Clear;

  //Para fazer a proxima nota fiscal - FISCAL
  fIsNewInvoice := True;

  //Butoes para ficar como enable false no modulo fiscal
  PrepareModuloFiscal;

  ShowModal;
  
end;

procedure TFrmPaiInvoice.FormShow(Sender: TObject);
begin
  inherited;
  OldTag      := 0;
  WindowState := wsNormal;
  OldMedia    := MyStrToInt(scMedia.LookUpValue);

  // Seta as coordenadas iniciais
  Height := Screen.Height;
  Width  := Screen.Width;
  Left   := 0;
  Top    := 0;
  btSpecialPrice.visible := Password.HasFuncRight(41);

  if not quPreSaleInfoNote.IsNull then
    pgInvoice.ActivePage := tbNote;

 //Refresh na pgControl
 pgInvoiceChange(Nil);

 //Display invoices info
  if IsInvoice then
     lblSubMenu.Caption := sInvNum + quPreSaleInfoIDInvoice.AsString
  else if IsLayaway then
       lblSubMenu.Caption := sLayawayNum + IntToStr(IDPreSale)
     else
       lblSubMenu.Caption := sHoldNum + IntToStr(IDPreSale);

  lblUserName.Caption := '';

end;

procedure TFrmPaiInvoice.btCloseClick(Sender: TObject);
var
   ID: String;
   Pagou : Boolean;
begin
  inherited;

  if (btClose.Tag = 1) and (spquPreSaleItem.IsEmpty) then
     begin
     MsgBox(MSG_CRT_NO_ITEM_PAY, vbOKOnly + vbInformation);
     Exit;
     end;

  // Teste se todos os serial numbers foram preenchidos
  // Rodrigo fazer o teste no hold e no Sales
  if (MyPreSaleType = SALE_PRESALE) or (MyPreSaleType = SALE_CASHREG) then
    begin
      with DM.quFreeSQL do
        begin
          if Active then
            Close;
          SQL.Clear;
          SQL.Add('SELECT IDPreInventoryMov ');
          SQL.Add('FROM	PreInventoryMov PIM ');
          SQL.Add('LEFT OUTER JOIN PreSerialMov PSM ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
          SQL.Add('JOIN Model M ON (PIM.ModelID = M.IDModel)');
          SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
          SQL.Add('WHERE TG.SerialNumber = 1');
          SQL.Add('AND PIM.UserID = ' + IntToStr(DM.fUser.ID));
          SQL.Add('AND  PIM.DocumentID = ' + quPreSaleInfoIDPreSale.AsString);
          SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
          SQL.Add('HAVING COUNT(PSM.SerialNumber) < ABS(PIM.Qty)');
          Open;
          if not IsEmpty then
            begin
              MsgBox(MSG_CRT_NO_SERIAL_NUMBER, vbCritical + vbOkOnly);
              Close;
              Exit;
            end;
          Close;
        end;
    end;

  // So atualiza se for Master
  if (StatusUser = 0) then
    begin

      if (quPreSaleInfo.State in dsEditModes) then
        begin
         quPreSaleInfo.UpdateRecord;
         quPreSaleInfo.Post;
        end;

      // Desliga o timer
      tmrRefreshItem.Enabled := False;

      btClose.visible   := False;
      btCancel.visible  := False;

      if MyPreSaleType = SALE_CASHREG then
         //with TPreSaleReceive.Create(Self) do
         with TFrmReceivePayment.Create(Self) do
         begin
           Pagou := Start(quPreSaleInfo, spquPreSaleValue, spquPreSaleItem, MyIDCashRegMov, IsLayaway);
           Self.FechouCupom := FechouCupom;
           if Pagou then
                Self.Close;

           Free;
         end;
      btClose.visible  := True;
      btCancel.visible := True;
    end;

  if MyPreSaleType <> SALE_CASHREG then
     Close;

end;

procedure TFrmPaiInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  TmrRefreshItem.Enabled  := False;
  TmrRefreshItem.Interval := DM.fSystem.SrvParam[PARAM_REFRESHINTERVAL];
  FrmPreSaleItem := TFrmPreSaleItem.Create(Self);

  SpecialPrice := 0;

  pgInvoice.ActivePage := tbDiscount;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sJoinHolds   := 'Join Holds';
           sAddNumber   := 'Add the new hold number to this one.';
           sChangePrice := '&Change Special Price';
           sApplyPrice  := 'A&pply Special Price';
           sCopyHold    := 'Copy of Hold';
           sCopyInvoice := 'Copy of Invoice';
           sInvNum      := 'Invoice # ';
           sLayawayNum  := 'Layaway hold # ';
           sHoldNum     := 'Hold # ';
           sHold        := '&Hold';
           sReceive     := '&Receive';
           sClose       := 'Close';
           sRestorTax   := 'Restore &Tax';
           sExemptTax   := '&Tax Exempt';
           sItems       := ' Items';
           end;

     LANG_PORTUGUESE :
           begin
           sJoinHolds   := 'Juntar Notas';
           sAddNumber   := 'Juntar Nota Pendente para a atual.';
           sChangePrice := 'Modar &Preço Especial';
           sApplyPrice  := 'A&plicar Preço Especial';
           sCopyHold    := 'Cópia da Nota Pendente';
           sCopyInvoice := 'Cópia da Nota';
           sInvNum      := 'Nº Nota ';
           sLayawayNum  := 'Nota Pend ';
           sHoldNum     := 'Nº Nota Pend ';
           sHold        := '&Reter';
           sReceive     := '&Receber';
           sClose       := 'Fechar';
           sRestorTax   := 'Restaurar &Taxa';
           sExemptTax   := 'Exentar &Taxa';
           sItems       := ' Itens';
           end;

     LANG_SPANISH :
           begin
           sJoinHolds   := 'Unir Boletas';
           sAddNumber   := 'Agregar Boleta Pendiente a la actual.';
           sChangePrice := 'Cambiar &Precio Especial';
           sApplyPrice  := 'A&plicar Precio Especial';
           sCopyHold    := 'Copia de Boleta Pendiente';
           sCopyInvoice := 'Copia de Boleta';
           sInvNum      := 'Boleta # ';
           sHoldNum     := 'Boleta Pend # ';
           sLayawayNum  := 'Crédito # ';
           sHold        := '&Retener';
           sReceive     := '&Recibir';
           sClose       := 'Cerrar';
           sRestorTax   := 'Res&tablecer Impuesto';
           sExemptTax   := 'Exen&tar Impuesto';
           sItems       := ' Items';
           end;
   end;

  if DM.fCashRegister.Fiscal then
     begin
     spnSpecialDiscount.MaxValue := 99;
     Label13.Visible             := False;
     DBEdit7.Visible             := False;
     Label20.Visible             := False;
     end;
     
end;

procedure TFrmPaiInvoice.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmPreSaleItem.Free;
end;

procedure TFrmPaiInvoice.FormClose(Sender: TObject; var Action: TCloseAction);
var
bEmpty : Boolean;
iOpenHoldCaixa, iOpenHold : integer; //Open Holds
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // Desabilita refresh do timer
  TmrRefreshItem.Enabled := False;

  with quPreSaleInfo do
    begin
      if Active and (State in dsEditModes) then
         Cancel;
      Close;
    end;

  spquPreSaleValue.Close;
  spquPreSaleItem.Close;

  // Fecha Query dos ranges
  with quDiscRange do
     if Active then Close;

  with quPayMin do
     if Active then Close;

  if (not IsInvoice) then
     begin
     with quVerifyOpenHold do
         begin
         if Active then
            Close;

         Parameters.ParambyName('IDPreSale').Value := IDPreSale;
         Open;

         iOpenHoldCaixa := quVerifyOpenHoldnOpenHoldCaixa.AsInteger;
         iOpenHold      := quVerifyOpenHoldnOpenUser.AsInteger;

         Close;
         end;


     //Atualiza o qty No Hold

     Case MyPreSaleType of
        SALE_CASHREG : begin //Hold esta sendo aberto no Caixa
                       try
                          DM.ADODBConnect.BeginTrans;

                          with DM.quFreeSQL do
                             begin
                             If Active then
                                Close;
                             SQL.Clear;
                             SQL.Add('UPDATE Invoice');
                             SQL.Add('SET nOpenHoldCaixa = ' + IntToStr(iOpenHoldCaixa-1) );
                             SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                             ExecSQL;
                             end;

                          DM.ADODBConnect.CommitTrans;

                       except
                          DM.ADODBConnect.RollbackTrans;
                          Exit;
                          end;
                        end;

     SALE_PreSale : begin //Hold esta sendo aberto in PreSale
                    try
                       DM.ADODBConnect.BeginTrans;

                       with DM.quFreeSQL do
                          begin
                          If Active then
                          Close;
                          SQL.Clear;
                          SQL.Add('UPDATE Invoice');
                          SQL.Add('SET nOpenUser = ' + IntToStr(iOpenHold-1) );
                          SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale) );
                          ExecSQL;
                          end;

                       DM.ADODBConnect.CommitTrans;

                       except
                          DM.ADODBConnect.RollbackTrans; 
                          Exit;
                          end;
                   end;
        end; //end Case
     end; //end if IsNotInvoice

  //Rodrigo somente se for Hold
  If MyPreSaleType = 0 then
     begin
     //Rodrigo - Verificar se o hold esta vazio
     with spquPreSaleItem do
        begin
        Close;
        Parameters.ParambyName('@DocumentID').Value := IDPreSale;
        Parameters.ParambyName('@IsPreSale').Value  := True;
        Parameters.ParambyName('@Date').Value       := Now;
        Open;
        end;

      bEmpty := spquPreSaleItem.IsEmpty;

     If bEmpty then
        DM.fPOS.DeleteHold(IDPreSale, DM.fUser.ID);

     end;

  Screen.Cursor := crDefault;
  
end;

procedure TFrmPaiInvoice.btAddItemClick(Sender: TObject);
var
   PreInventMovID : Integer;
begin
  inherited;

  if not CanOpenFiscalInvoice then
     Exit;

  if TestUserComission then
     FrmPreSaleItem.Start(IDPreSale, PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime, True,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem, spquPreSaleValue);

  grdItems.SetFocus;


  if DM.fCashRegister.Fiscal then
     if spquPreSaleValueItemDiscount.AsCurrency <> 0 then
        begin
        btApplyPriceManager.Enabled := False;
        spnSpecialDiscount.ReadOnly := True;
        btSpecialPrice.Enabled      := False;
        end;

end;

procedure TFrmPaiInvoice.dsPreSaleItemDataChange(Sender: TObject; Field: TField);
var
   IsEnabled : Boolean;
begin
  inherited;
  IsEnabled := not (spquPreSaleItem.Bof and spquPreSaleItem.Eof);
  btSerial.Enabled       := IsEnabled and spquPreSaleItemSerialNumber.AsBoolean;
  btRemoveItem.Enabled   := IsEnabled;
  btDiscountItem.Enabled := IsEnabled;
end;

procedure TFrmPaiInvoice.RefreshItem(PreInventMovID : Integer);
begin

  Screen.Cursor := crHourGlass;

  with spquPreSaleItem do
    begin
       Close;
       if IsInvoice then
          Parameters.ParambyName('@DocumentID').Value := quPreSaleInfoIDInvoice.AsInteger
       else
          Parameters.ParambyName('@DocumentID').Value := IDPreSale;
       Parameters.ParambyName('@IsPreSale').Value     := not IsInvoice;
       Parameters.ParambyName('@Date').Value          := Now;
       Open;
       if PreInventMovID <> 0 then
          Locate('IDInventoryMov', IntToStr(PreInventMovID), []);
    end;

  RefreshValue;

  Screen.Cursor := crDefault;
end;

procedure TFrmPaiInvoice.btDiscountItemClick(Sender: TObject);
Var
PreInventMovID : Integer;
begin
  inherited;

  if TestUserComission then
    begin
     if (spquPreSaleItemIDComission.AsInteger <> DM.fUser.IDCommission) then
      begin
        if not Password.HasFuncRight(14) then
          begin
            MsgBox(MSG_INF_NOT_CHANGE_ITEMS, vbOKOnly + vbInformation);
            Exit;
          end
      end;

     // Muda desconto novo item
     PreInventMovID := spquPreSaleItemIDInventoryMov.AsInteger;
     FrmPreSaleItem.QuSerialMov.Close;
     FrmPreSaleItem.QuSerialMov.Parameters.Items[0].Value := PreInventMovID;
     FrmPreSaleItem.QuSerialMov.Open;

     FrmPreSaleItem.Start(IDPreSale, PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime, False,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem, spquPreSaleValue);
    end;

  grdItems.SetFocus;

end;

procedure TFrmPaiInvoice.btRemoveItemClick(Sender: TObject);
var
  Msg : String;
  iError : Integer;
  itemPos : Integer;
begin
  inherited;
  //Verificar se pode deletar Lay away
  if quPreSaleInfoLayaway.AsBoolean then
     if not Password.HasFuncRight(42) then
       begin
       MsgBox(MSG_INF_NOT_DEL_ITEMS_LAYAWAY, vbOKOnly + vbInformation);
       Exit;
       end;

  if (spquPreSaleItemIDComission.AsInteger <> DM.fUser.IDCommission) then
    begin
     if not Password.HasFuncRight(15) then
       begin
       MsgBox(MSG_INF_NOT_DELETE_ITEMS, vbOKOnly + vbInformation);
       Exit;
       end
    end;

  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
    begin

    Screen.Cursor := crHourGlass;

    {/////////////////Marcos//////////////}
    {envia cancelamento (ou remove do cupom aberto), do item selecionado, para a impressora}
    if DM.fCashRegister.Fiscal then
       begin
       itemPos := (DM.fPOS.InvoiceItem.IndexOf(spquPreSaleItemIDInventoryMov.AsString)+1);
       if not DM.EFiscal1.cancelaItem(spquPreSaleItemModel.AsString, IntToStr(itemPos)) then
          Exit;
       end;
    {/////////////////////////////////////}


    DM.fPOS.DeleteHoldItem(IDPreSale,
                           spquPreSaleItemIDInventoryMov.AsInteger,
                           spquPreSaleItemModelID.AsInteger,
                           DM.fUser.ID,
                           spquPreSaleItemQty.AsInteger,
                           spquPreSaleItemDiscount.AsFloat,
                           spquPreSaleItemSalePrice.AsFloat,
                           False, False, Now, iError);

     if iError <> 0  then
        begin
        if (Password.HasFuncRight(9)) then
           Msg := MSG_QST_DISCOUNT_REACHED
        else
           Msg := MSG_QST_ERASE_ALL_DISCOUNT;

        if MsgBox(Msg, vbYesNo + vbQuestion) = vbYes then
           DM.fPOS.DeleteHoldItem(IDPreSale,
                                  spquPreSaleItemIDInventoryMov.AsInteger,
                                  spquPreSaleItemModelID.AsInteger,
                                  DM.fUser.ID,
                                  spquPreSaleItemQty.AsInteger,
                                  spquPreSaleItemDiscount.AsFloat,
                                  spquPreSaleItemSalePrice.AsFloat,
                                  (not Password.HasFuncRight(9)),
                                  Password.HasFuncRight(9), Now, iError);
        end;

     RefreshItem(0);

    Screen.Cursor := crDefault;

    end;

  grdItems.SetFocus;
end;

procedure TFrmPaiInvoice.btMakeSpecialPriceClick(Sender: TObject);
begin
  inherited;

  // ** remove o special price do manager
  btSpecialprice.Down := false;
  btSpecialPriceclick (nil);

  // Chama special Prices
  with TFrmMakeSpcPrice.Create(Self) do
     if Start(IDPreSale, spquPreSaleValueSpecialPriceID.AsInteger) then
        RefreshItem(0);

  grdItems.SetFocus;

end;

procedure TFrmPaiInvoice.FormActivate(Sender: TObject);
begin
  inherited;
  if IsFirst then
    begin
      IsFirst := False;

      case MyPreSaleType of

        SALE_PreSale : begin
                         // PreSale em modo PreSale
                         btClose.Caption  := sHold;
                         btCancel.Visible := False;
                         btClose.Tag      := 0;
                       end;

        SALE_CASHREG : begin
                         btCancel.Visible := True;
                         btCancel.Caption := sHold;
                         btClose.Tag      := 0;
                         if StatusUser = 1 then
                           begin
                            btClose.Caption  := sHold;
                            btCancel.Visible := False;
                            btClose.Tag      := 0;
                           end
                         else
                            begin
                            btClose.Caption := sReceive;
                            btClose.Tag     := 1;
                            end;
                       end;
        else
                       begin
                         btCancel.Visible := False;
                         btClose.Caption  := sClose;
                         btClose.Tag      := 0;
                       end;
      end;

      // Teste de AutoInclusao
      if spquPreSaleItem.IsEmpty then
         btAddItem.Click
      else
         grdItems.SetFocus;
    end;
end;

procedure TFrmPaiInvoice.btTaxIsentClick(Sender: TObject);
begin
  inherited;

  with TFrmTaxIsent.Create(Self) do
    if Start(IDPreSale, quPreSaleInfo, (spquPreSaleValueSpecialPriceID.AsInteger > 0),
             not spquPreSaleValueTaxIsent.AsBoolean) then
       RefreshValue;

  grdItems.SetFocus;
  
end;

procedure TFrmPaiInvoice.RefreshValue;
begin

  Screen.Cursor := crHourGlass;

  with spquPreSaleValue do
    begin
      if Active then Close;
      Parameters.ParambyName('@PreSaleID').Value := IDPreSale;
      Open;
      if spquPreSaleValueTaxIsent.AsBoolean then
         btTaxIsent.Caption := sRestorTax
      else
         btTaxIsent.Caption := sExemptTax;
    end;

  // Testa se deve mostrar o Panel de SpecialPrice
  if spquPreSaleValueSpecialPriceID.AsInteger > 0 then
     begin
     pnlSpecialPrice.Visible := True;
     EditFullTotal.Text := FloatToStrF(DM.fPOS.GetSpecialPriceTotal(IDPreSale)-
                                       spquPreSaleValueItemDiscount.AsFloat, ffCurrency, 20 , 2);
     end
  else
     pnlSpecialPrice.Visible := False;

  // Testa se deve mostrar o panel de TaxIsemptValue

  if spquPreSaleValueTaxIsemptValue.AsCurrency <> 0 then
    begin
      //Nao faz mais isso - TaxAble esta no TaxCategory
      //pnlTaxIsempt.Visible := True;
      //pnlSubTotalTaxable.Visible := True;
    end
  else
    begin
      pnlTaxIsempt.Visible := False;
      pnlSubTotalTaxable.Visible := False;
    end;

  Screen.Cursor := crDefault;

end;

procedure TFrmPaiInvoice.RefreshInfo;
begin
  with quPreSaleInfo do
    begin
      if Active then Close;
         Parameters.ParambyName('IDPreSale').Value := IDPreSale;
      Open;
    end;
end;

procedure TFrmPaiInvoice.cmbSpecialDiscSelectItem(Sender: TObject);
begin
  inherited;
  // Atualiza o special discount
end;

procedure TFrmPaiInvoice.TmrRefreshItemTimer(Sender: TObject);
var
  NewRefresh : Integer;
begin
  inherited;
  with spTestRefresh do
    begin
      Parameters.ParambyName('@IDPreSale').Value := IDPreSale;
      ExecProc;
      NewRefresh := Parameters.ParambyName('@RefreshInvoice').Value;
    end;

  if OldRefreshInvoice <> NewRefresh then
    begin
     OldRefreshInvoice := NewRefresh;
     RefreshItem(spquPreSaleItemIDInventoryMov.AsInteger);
     // Refresh do discount ranges
     if pgInvoice.ActivePage = tbDiscount then
        ShowDiscRanges;
    end;
end;

procedure TFrmPaiInvoice.AtuPreSaleControls;
var
  IsEnabled : Boolean;
  MyColor   : Integer;
begin

  IsEnabled := (StatusUser = 0) and not IsInvoice;
  if IsEnabled then
     MyColor := clWindow
  else
     MyColor := clBtnFace;

  pnlInvoiceCustomer.Visible := IsGenericIDPessoa;
  pnlPessoa.Visible := not IsGenericIDPessoa;

  cmbOther.ReadOnly        := not IsEnabled;
  cmbOther.Color           := MyColor;
  cmbDelType.ReadOnly      := not IsEnabled;
  cmbDelType.Color         := MyColor;
  EditDelDate.ReadOnly     := not IsEnabled;
  EditDelDate.Color        := MyColor;
  EditDelAddress.ReadOnly  := not IsEnabled;
  EditDelAddress.Color     := MyColor;
  EditNote.ReadOnly        := not IsEnabled;
  with EditNote do
       if IsEnabled then Color := clInfoBk else Color := MyColor;

  spPayVisa.Enabled        := IsEnabled;
  spPayMaster.Enabled      := IsEnabled;
  spPayAmerican.Enabled    := IsEnabled;
  cmbPayType.ReadOnly      := not IsEnabled;
  EditDepositDate.ReadOnly := not IsEnabled;

  btSpecialPrice.Enabled   := IsEnabled;

  //btTaxIsent.Enabled         := IsEnabled;
  //btMakeSpecialPrice.Enabled := IsEnabled;

  IsEnabled := not IsInvoice;

  if IsInvoice then
     btImpHold.Caption := sCopyInvoice
  else
     btImpHold.Caption := sCopyHold;

  pnlUsers.Visible         := not IsInvoice;

  btAddItem.Enabled        := IsEnabled;
  btRemoveItem.Enabled     := IsEnabled;
  //btDiscountItem.Enabled   := IsEnabled;

  btUpHold.Visible         := IsEnabled;

  btAddItem.Visible        := not IsInvoice;
  btRemoveItem.Visible     := not IsInvoice;
  //btDiscountItem.Visible   := not IsInvoice;
  btSerial.Visible         := not IsInvoice;
  btChangeUser.Visible     := not IsInvoice;

  // Mostra o PayDate
  EditInvoiceDate.Visible  := IsInvoice;
  lblInvoiceDate.Visible   := IsInvoice;

  // Setar o Help Context dependendo da tela origem (Cash Reg/Inv History)
  if IsInvoice then
    HlpContext:= 1130
  else
    HlpContext:= 1050;

  if not DM.fCashRegister.Fiscal then
     begin
     btTaxIsent.Enabled               := IsEnabled;
     btDiscountItem.Enabled           := IsEnabled;
     btDiscountItem.Visible           := not IsInvoice;
     btMakeSpecialPrice.Enabled       := IsEnabled;
     end
  else
     begin
     DM.fModuloFiscal.InvoiceDiscount := False;
     spnSpecialDiscount.Value         := 0;
     pnlSpecialDiscount.Visible       := False;
     btSpecialPrice.Down              := False;
     end;

end;

function TFrmPaiInvoice.TestUserComission : Boolean;
begin
  Result := (DM.fUser.IDCommission > 0);
  if not Result then
    begin
     MessageBeep(MB_ICONASTERISK);
     MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbOKOnly + vbInformation);
    end;
end;

procedure TFrmPaiInvoice.spquPreSaleItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  spquPreSaleItemTotalItem.AsFloat := (spquPreSaleItemQty.AsInteger*spquPreSaleItemSalePrice.AsFloat) - spquPreSaleItemDiscount.AsFloat;
end;

procedure TFrmPaiInvoice.spquPreSaleValueCalcFields(DataSet: TDataSet);
begin
  inherited;
  // aualiza open users
  spquPreSaleValueShowOpenUser.AsInteger := spquPreSaleValuenOpenUser.AsInteger -1;
  if spquPreSaleValueShowOpenUser.AsInteger < 0 then
     spquPreSaleValueShowOpenUser.AsInteger := 0;

  spquPreSaleValueTotalInvoice.AsFloat  := spquPreSaleValueSubTotal.AsFloat -
                                              spquPreSaleValueTaxIsemptItemDiscount.AsFloat -
                                              spquPreSaleValueItemDiscount.AsFloat +
                                              spquPreSaleValueTax.AsFloat;

  spquPreSaleValueNewSubTotal.AsFloat  := spquPreSaleValueSubTotal.AsFloat -
                                          spquPreSaleValueTaxIsemptItemDiscount.AsFloat -
                                          spquPreSaleValueItemDiscount.AsFloat;

  spquPreSaleValueSubTotalTaxable.AsFloat := spquPreSaleValueNewSubTotal.AsFloat
                                             - spquPreSaleValueTaxIsemptValue.AsFloat;


  if spquPreSaleValueSubTotal.AsFloat > 0 then
     spquPreSaleValueDiscountPrc.AsFloat := ((spquPreSaleValueTaxIsemptItemDiscount.AsFloat + spquPreSaleValueItemDiscount.AsFloat)/spquPreSaleValueSubTotal.AsFloat)*100
  else
     spquPreSaleValueDiscountPrc.AsFloat := 0;

  if (spquPreSaleValueSubTotalTaxable.AsFloat > 0) then
      spquPreSaleValueTaxPrc.AsFloat      := (spquPreSaleValueTax.AsFloat/(spquPreSaleValueSubTotalTaxable.AsFloat))*100
  else
      spquPreSaleValueTaxPrc.AsFloat      := 0;
end;

procedure TFrmPaiInvoice.ShowDiscRanges;
var
  MaxDiscount : Double;
  OldPage     : TTabSheet;
begin
  // Acha o max venda minimo
  DM.fPOS.GetMinSaleAndMaxDiscount(IDPreSale, DM.fUser.ID,
                                   MaxVendaMin, MaxDiscount);

  with quDiscRange do
     begin
     if Active then Close;
     Parameters.ParambyName('IDUser').Value := DM.fUser.ID;
     Open;
     if Locate('TotVendaMin', MaxVendaMin, []) then
        EditAmountDisc.Text := FormatFloat('#,###,##0.00',
                               MaxDiscount -
                               spquPreSaleValueItemDiscount.AsFloat)
     else
         EditAmountDisc.Text := FormatFloat('#,###,##0.00', 0);
     end;
end;

procedure TFrmPaiInvoice.dsPreSaleValueDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if spquPreSaleValueShowOpenUser.AsInteger > 0 then
     EditOpenUser.Font.Color := clBlack
  else
     EditOpenUser.Font.Color := clWhite;

  if spquPreSaleValueSpecialPriceID.AsInteger > 0 then
     btMakeSpecialPrice.Caption := sChangePrice
  else
     btMakeSpecialPrice.Caption := sApplyPrice;
end;

procedure TFrmPaiInvoice.btCancelClick(Sender: TObject);
var
 bIsEmpty : Boolean;
begin
  inherited;
  if (quPreSaleInfo.State in dsEditModes) then
    begin
      if MyPreSaleType = SALE_CASHREG then
        begin
          quPreSaleInfo.UpdateRecord;
          quPreSaleInfo.Post;
        end
       else
        quPreSaleInfo.Cancel;
    end;

  //Rodrigo - Verificar se o hold esta vazio e deletar
  with spquPreSaleItem do
    begin
      Close;
       if IsInvoice then
          Parameters.ParambyName('@DocumentID').Value := quPreSaleInfoIDInvoice.AsInteger
       else
          Parameters.ParambyName('@DocumentID').Value := IDPreSale;
       Parameters.ParambyName('@IsPreSale').Value  := not IsInvoice;
       Parameters.ParambyName('@Date').Value      := Now;
       Open;
    end;

  bIsEmpty := spquPreSaleItem.IsEmpty;

  if DM.fCashRegister.Fiscal then
  begin
     if not fIsNewInvoice and (not FechouCupom) then //Cancelar o nota fiscal se estiver aberta
        if DM.EFiscal1.CancelaCupomAtual then
           bIsEmpty := True;
     if FechouCupom then
        bIsEmpty := True;
  end;

  If bIsEmpty then
     DM.fPOS.DeleteHold(IDPreSale, DM.fUser.ID);

  Self.Close;

end;

procedure TFrmPaiInvoice.btSerialClick(Sender: TObject);
var
   T: Integer;

begin
  inherited;

  if IsInvoice then
    T := SERIAL_INVOICE
  else
    T := SERIAL_HOLD;

  with TFrmSerialNumber.Create(Self) do
     StartOnSales(T,
                  spquPreSaleItemModelID.AsInteger,
                  DM.fStore.ID,
                  spquPreSaleItemQty.AsInteger,
                  spquPreSaleItemIDInventoryMov.AsInteger)

end;

procedure TFrmPaiInvoice.pgInvoiceChange(Sender: TObject);
begin
  inherited;
  case pgInvoice.ActivePage.TabIndex of
       2 : begin
           if quPreSaleInfoIDMeioPag.AsInteger > 0 then
              begin
              // Desabilita o Deposit Date
              cmbPayType.LookUpvalue   := quPreSaleInfoIDMeioPag.AsString;
              end;

           cmbPayTypeSelectItem(nil);
           end;
       4 : ShowDiscRanges;
  end;

end;


procedure TFrmPaiInvoice.btDetClienteClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  inherited;

  with TFchPessoa.Create(Self) do
    begin
      ID1 := quPreSaleInfoIDCustomer.AsString;
      ID2 := '';
      if Start(btAlt, Nil, False, ID1, ID2) then
         begin

         with quDescCustomer do
            begin
            if Active then
               Close;

            Parameters.ParambyName('IDPessoa').Value := quPreSaleInfoIDCustomer.AsInteger;
            Open;

            EditCustomer.Text := Trim(quDescCustomerPessoaLastName.AsString) + ', '+
                                 Trim(quDescCustomerPessoaFirstName.AsString);

            if not (quPreSaleInfo.State in dsEditModes) then
               quPreSaleInfo.Edit;

            quPreSaleInfoFirstName.ASString := Trim(quDescCustomerPessoaFirstName.AsString);
            quPreSaleInfoLastName.ASString  := Trim(quDescCustomerPessoaLastName.AsString);
            Close;
            end;

         end;
      Free;

    end;
end;

procedure TFrmPaiInvoice.btDetGroupClick(Sender: TObject);
var
   PosID1, PosID2 : String;
begin
  inherited;

  {
  PosID1 := quPreSaleInfoIDTouristGroup.AsString;
  with TFchTouristGroup.Create(self) do
     begin
        ShowCusto := False;
        if Start(btAlt, nil, False, PosID1, PosID2, nil) then
          AtuDescTourist;

        Free;
     end;
  }
end;

procedure TFrmPaiInvoice.quPreSaleInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  AtuDescCustomer;
  AtuDescTourist;
end;

procedure TFrmPaiInvoice.AtuDescTourist;
begin
  // Da o refresh do descTourist
  with quDescTourist do
   begin
    if quPreSaleInfoIDTouristGroup.IsNull then
      begin
       lblTourGroup.Caption      := '';
       btDetGroup.Enabled        := False;
       btChangeTourGuide.Enabled := False;
      end
    else
      begin
       if Active then Close;
       Parameters.ParambyName('IDTouristGroup').Value := quPreSaleInfoIDTouristGroup.AsInteger;
       Open;
       lblTourGroup.Caption      := quDescTouristTipTouristGroup.AsString;
       btDetGroup.Enabled        := Password.HasFuncRight(16);
       btChangeTourGuide.Enabled := btDetGroup.Enabled;
       Close;
      end;
  end;
end;

procedure TFrmPaiInvoice.AtuDescCustomer;
begin
  // Da o refresh do Customer
  with quDescCustomer do
   begin
    if Active then Close;
    Parameters.ParambyName('IDPessoa').Value := quPreSaleInfoIDCustomer.AsInteger;
    Open;
    EditCustomer.Text := Trim(quDescCustomerPessoaLastName.AsString) + ', '+
                         Trim(quDescCustomerPessoaFirstName.AsString);
    Close;
  end;
end;

procedure TFrmPaiInvoice.quPreSaleInfoNewRecord(DataSet: TDataSet);
begin
  inherited;
  quPreSaleInfoDeliverTypeID.AsInteger := DELIVER_TYPE_ONHAND;
end;

procedure TFrmPaiInvoice.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of

       VK_F2  : begin //Add New Item
                if (btAddItem.Enabled and btAddItem.Visible) then
                   btAddItemClick(nil);
                end;

       VK_F3  : begin //Edit Item
                if (btDiscountItem.Enabled and btDiscountItem.Visible) then
                   btDiscountItemClick(nil);
                end;

       VK_F4  : begin //Remove Item
                if (btRemoveItem.Enabled and btRemoveItem.Visible)   then
                   btRemoveItemClick(nil);
                end;

       VK_F5  : begin //Enter Serial
                if btSerial.Enabled then
                   btSerialClick(nil);
                end;

       VK_F6  : begin //Chang User
                if btChangeUser.Enabled then
                   btChangeUserClick(nil);
                end;

       VK_F7  : begin
                 pgInvoice.ActivePage := tbTourist;
                 pgInvoiceChange(nil);
                end;

       VK_F8  : begin
                 pgInvoice.ActivePage := tbDeliver;
                 if cmbDelType.Enabled then cmbDelType.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F9 : begin
                 pgInvoice.ActivePage := tbDeposit;
                 if cmbPayType.Enabled then cmbPayType.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F10 : begin
                 pgInvoice.ActivePage := tbNote;
                 if EditNote.Enabled then EditNote.SetFocus;
                 pgInvoiceChange(nil);
                end;

       VK_F11 : begin
                 pgInvoice.ActivePage := tbDiscount;
                 pgInvoiceChange(nil);
                end;

       VK_F12 : begin
                 pgInvoice.ActivePage := tbPrint;
                 pgInvoiceChange(nil);
                end;
  end;
end;



procedure TFrmPaiInvoice.spPayVisaClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_VISA;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmPaiInvoice.spPayMasterClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_MASTER;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmPaiInvoice.spPayAmericanClick(Sender: TObject);
begin
  inherited;

  if not (quPreSaleInfo.State in dsEditModes) then
     quPreSaleInfo.Edit;

  quPreSaleInfoIDMeioPag.AsInteger := PAY_TYPE_AMERICAN;

  cmbPayTypeSelectItem(nil);
end;

procedure TFrmPaiInvoice.tbDepositExit(Sender: TObject);
var
  MyDifDay : integer;
  // Na saida do tab valido a data de deposit date
begin
  inherited;

  if not quPayMin.Active then
     Exit;

  // teste de data válida para o campo
  if TestDate(EditDepositDate.Text) then
    begin
      // testa se pode dar este deposit date para o minimo de venda
      MyDifDay := -1;
      with quPayMin do
        begin

          DisableControls;
          Last;
          while not Bof do
            begin
              if spquPreSaleValueTotalInvoice.AsFloat > quPayMinTotalSale.AsFloat then
                begin
                 MyDifDay := quPayMinDifDay.AsInteger;
                 Break;
                end;
              Prior;
            end;
          First;
          EnableControls;
        end;

      if (MyDifDay < 0) or ((quPreSaleInfoDepositDate.AsDateTime - Date) > MyDifDay) then
        begin
          MsgBox(MSG_INF_INVOICE_NOT_REACH, vbOKOnly + vbInformation);
          quPreSaleInfo.Edit;
          quPreSaleInfoDepositDate.Clear;
          quPreSaleInfoIDMeioPag.Clear;
          cmbPayTypeSelectItem(nil);

          if not (pgInvoice.ActivePage = tbDeposit) then
             begin
             pgInvoice.ActivePage := tbDeposit;
             cmbPayType.SetFocus;
             end
          else
             cmbPayType.SetFocus;

        end;
    end
  else
    begin
      quPreSaleInfo.Edit;
      quPreSaleInfoDepositDate.Clear;
      quPreSaleInfoIDMeioPag.Clear;
      cmbPayTypeSelectItem(nil);

      if not (pgInvoice.ActivePage = tbDeposit) then
         begin
         pgInvoice.ActivePage := tbDeposit;
         cmbPayType.SetFocus;
         end
      else
         cmbPayType.SetFocus;

    end;
end;

procedure TFrmPaiInvoice.btImpHoldClick(Sender: TObject);
begin
  inherited;

  with quPreSaleInfo do
    if State in dsEditModes  then
      begin
       UpdateRecord;
       Post;
      end;


  with TPrintReceipt.Create(Self) do
    Start(IDPreSale, RECEIPT_TYPE_HOLD);
  
end;

procedure TFrmPaiInvoice.btImpHoldHotelClick(Sender: TObject);
begin
  inherited;
  with quPreSaleInfo do
    if State in dsEditModes  then
      begin
       UpdateRecord;
       Post;
      end;


  with TPrintReceipt.Create(Self) do
    Start(IDPreSale, RECEIPT_TYPE_TICKET);
  
end;

procedure TFrmPaiInvoice.btChangeTourGuideClick(Sender: TObject);
var
   NewTourGroup: Integer;
begin
  inherited;

  {
  with TFrmChangeTourGroup.Create(Self) do
    NewTourGroup := Start;

  if NewTourGroup >= 0 then
    with quPreSaleInfo do
      begin
        if not (State in dsEditModes) then
           Edit;
        quPreSaleInfoIDTouristGroup.AsInteger := NewTourGroup;
      end;

  AtuDescTourist;
  }
  
end;

procedure TFrmPaiInvoice.scMediaSelectItem(Sender: TObject);
var
   NewTourGroup : integer;
begin
  inherited;
  {
  if MyStrToInt(scMedia.LookUpValue) = MEDIA_TYPE_TOURGROUP then
    begin
      btChangeTourGuide.Enabled := True;


      with TFrmChangeTourGroup.Create(Self) do
        NewTourGroup := Start;

      if NewTourGroup >= 0 then
        with quPreSaleInfo do
          begin
            if not (State in dsEditModes) then Edit;
            quPreSaleInfoIDTouristGroup.AsInteger := NewTourGroup;
          end
      else
        with quPreSaleInfo do
          begin
            btChangeTourGuide.Enabled := False;
            if not (State in dsEditModes) then Edit;
            quPreSaleInfoMediaID.AsInteger := OldMedia;
          end;

      AtuDescTourist;
    end
  else
    with quPreSaleInfo do
      begin
        btChangeTourGuide.Enabled := False;
        if not (State in dsEditModes) then Edit;
        quPreSaleInfoIDTouristGroup.Clear;
        AtuDescTourist;
      end;

  grdItems.SetFocus;

  if OldMedia <> quPreSaleInfoMediaID.AsInteger then
     SetTaxIsention(True);

  OldMedia := MyStrToInt(scMedia.LookUpValue);
  }
end;

procedure TFrmPaiInvoice.SetTaxIsention(Force : Boolean);
begin
  // Teste se vendapara para guia e isenta a taxa
  if (not IsInvoice) and (Force or (spquPreSaleItem.EOF and spquPreSaleItem.BOF)) then
     begin
     DM.fPOS.SetExemptTax(IDPreSale, quPreSaleInfoMediaID.AsInteger, Now);
     RefreshValue;
     end;
end;

procedure TFrmPaiInvoice.btUpHoldClick(Sender: TObject);
var
   Origem, Cliente : String;
   IDCliente, IDInvoice : Integer;

begin
  inherited;
  Origem := inputbox(sJoinHolds, sAddNumber,'');

  If trim(Origem) = '' then
     Exit;
  // digitou um numero valido?
  if MyStrToInt(Origem) > 0 then
    begin
      IDCliente := MyStrToInt(DM.DescCodigo(['IDPreSale'], [IntToStr(MyStrToInt(Origem))], 'Invoice', 'IDCustomer'));
      IDInvoice := MyStrToInt(DM.DescCodigo(['IDPreSale'], [IntToStr(MyStrToInt(Origem))], 'Invoice', 'IDInvoice'));
      // Existe um hold com este numero?
      if (IDCliente > 0) and (IDInvoice = 0) then
        begin
          Cliente := DM.DescCodigo(['IDPreSale'], [IntToStr(MyStrToInt(Origem))], 'Invoice', 'LastName');
          Cliente := Cliente + ', ' + DM.DescCodigo(['IDPreSale'], [IntToStr(MyStrToInt(Origem))], 'Invoice', 'FirstName');

          // O carinha tem certesa?
          if MsgBox(MSG_QST_PART1_MOVE_INVOICE_ITEM + Cliente + MSG_QST_PART2_MOVE_INVOICE_ITEM,
             vbYesNo + vbQuestion) = vbYes Then
            begin
              with spUpHold do
                begin
                  Parameters.ParambyName('@IDPreSaleOrigem').Value  := MyStrToInt(Origem);
                  Parameters.ParambyName('@IDPreSaleDestino').Value := IDPreSale;
                  Parameters.ParambyName('@Date').Value             := Now;
                  ExecProc;
                end;

              // Refresh Hold
              RefreshItem(0);

            end;
        end
      else
        begin
        MsgBox(MSG_EXC_PART1_NO_HOLD_NUMBER + Origem + MSG_EXC_PART2_NO_HOLD_NUMBER, vbOkOnly + vbExclamation)
        end
    end
  else
    begin
      MsgBox(Origem + MSG_EXC_INVALID_HOLD_NUMBER, vbOkOnly + vbExclamation )
    end;
end;

procedure TFrmPaiInvoice.spquPreSaleItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblTotalLine.Caption := IntToStr(spquPreSaleItem.RecordCount) + sItems;
end;



procedure TFrmPaiInvoice.btChangeUserClick(Sender: TObject);
begin

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     lblUserName.Caption := DM.fUser.UserName;

end;

procedure TFrmPaiInvoice.btSpecialPriceClick(Sender: TObject);
begin
  inherited;

  pnlSpecialDiscount.visible := btSpecialPrice.Down;
  if pnlSpecialDiscount.visible then
     spnSpecialDiscount.SetFocus;

end;

procedure TFrmPaiInvoice.spnSpecialDiscountChange(Sender: TObject);
begin
  btApplyPriceManager.enabled := (spnSpecialDiscount.Value >= 0) and
                                 (spnSpecialDiscount.Value <= 100);
end;

procedure TFrmPaiInvoice.btApplyPriceManagerClick(Sender: TObject);
begin

  DM.fPOS.ManageDiscount(IDPreSale, spnSpecialDiscount.Value, Now);

  if (pnlSpecialDiscount.visible) and (spnSpecialDiscount.value = 0) then
      SpecialPrice := 0 // ** estou no special price de manager/assist. manager e foi marcado discount=0
  else
      SpecialPrice := 999; // ** para forçar a mensagem de erro

  //Isentar a taxa do Main Retail, pois no Brazil a taxa ja vem no produto
  if DM.fCashRegister.Fiscal then
     DM.fPOS.ExemptTax(IDPreSale, True);


  RefreshItem(0);

  grdItems.SetFocus;
  SpecialPrice := 0;

  if DM.fCashRegister.Fiscal then
     begin
     btApplyPriceManager.Enabled := False;
     spnSpecialDiscount.ReadOnly := True;
     btAddItem.Visible           := False;
     btRemoveItem.Visible        := False;
     DM.fModuloFiscal.InvoiceDiscount := True;
     end;

end;

procedure TFrmPaiInvoice.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(HlpContext);
end;

procedure TFrmPaiInvoice.grdPayMinDblClick(Sender: TObject);
begin
  inherited;

  if not quPayMin.Active then
     Exit;

  if quPayMinTotalSale.AsFloat <= spquPreSaleValueTotalInvoice.AsFloat then
    begin
     quPreSaleInfo.Edit;
     quPreSaleInfoDepositDate.AsDateTime  := quPayMinDifDay.AsInteger + Date;
    end;

end;

procedure TFrmPaiInvoice.cmbPayTypeSelectItem(Sender: TObject);
begin
  inherited;

  // Atualiza o estado dos botoes
  case MyStrToInt(cmbPayType.LookUpValue) of
    PAY_TYPE_VISA     : spPayVisa.Down     := True;
    PAY_TYPE_AMERICAN : spPayAmerican.Down := True;
    PAY_TYPE_MASTER   : spPayMaster.Down   := True;
  else
    begin
      // nao seleciona
      spPayVisa.Down     := False;
      spPayAmerican.Down := False;
      spPayMaster.Down   := False;
    end;
  end;

  RefreshPayMin;
                                                
  if ((StatusUser = 0) and not IsInvoice) then
    begin
      if (cmbPayType.LookUpValue <> '') then
        begin
         EditDepositDate.ReadOnly := False;
         EditDepositDate.Color    := clWindow;
        end
      else
        begin
         EditDepositDate.ReadOnly := True;
         EditDepositDate.Color    := clBtnFace;
        end;
    end;
end;


procedure TFrmPaiInvoice.grdDiscRangeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
begin
  inherited;
  {
  i := TDBGrid(Sender).ColumnByFieldName('TotVendaMin').Index;

  i := 0;

  if Column = MaxVendaMin then
     begin
     AColor      := clYellow;
     AFont.Color := clBlack;
     end;
  }
end;

end;

procedure TFrmPaiInvoice.grdPayMinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  {
  i := TdxDBGrid(Sender).ColumnByFieldName('TotalSale').Index;
  i := 0;

  if Column[i] <= spquPreSaleValueTotalInvoice.AsFloat then
     begin
     AColor      := clYellow;
     AFont.Color := clBlack;
     end;
  }
end;

procedure TFrmPaiInvoice.grdItemsDblClick(Sender: TObject);
begin
  inherited;
  if IsInvoice then
     btSerialClick(nil)
  else
     btDiscountItemClick(nil);
end;

end.
