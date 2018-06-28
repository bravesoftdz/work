unit PaiPreSaleReceive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DateBox, DBCtrls, DB, DBTables, Grids, DBGrids,
  Buttons, DBCGrids, ComCtrls, ADODB, SuperComboADO, Variants, siComp,
  siLangRT, uParentAll, uFrmPayPartial, strUtils;

type
  TFrmPaiPreSaleReceive = class(TFrmParentAll)
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    spTestPayType: TADOStoredProc;
    spquPayTypeMin: TADOStoredProc;
    spquPayTypeMinDifDay: TIntegerField;
    spquPayTypeMinTotalSale: TFloatField;
    pgReceive: TPageControl;
    tbSingle: TTabSheet;
    tbMultiple: TTabSheet;
    Panel5: TPanel;
    Image2: TImage;
    Image8: TImage;
    Label5: TLabel;
    Label6: TLabel;
    pnlPaymentType: TPanel;
    Image1: TImage;
    Image3: TImage;
    spPayCash: TSpeedButton;
    spPayVisa: TSpeedButton;
    spPayMaster: TSpeedButton;
    spPayAmerican: TSpeedButton;
    Label4: TLabel;
    pnlPayTitle: TPanel;
    cmbPaymentType: TSuperComboADO;
    pnlDepositDate: TPanel;
    lblPreDate: TLabel;
    Image6: TImage;
    Image7: TImage;
    spDep30: TSpeedButton;
    spDep60: TSpeedButton;
    spDep90: TSpeedButton;
    pnlDateTitle: TPanel;
    EditDepositDate: TDateBox;
    Panel2: TPanel;
    Image10: TImage;
    Image11: TImage;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditTotalInvoice: TEdit;
    btMulti2: TSpeedButton;
    btMulti3: TSpeedButton;
    btMulti4: TSpeedButton;
    pnlShowCash: TPanel;
    lblCashTotal: TLabel;
    EditTotalCash: TEdit;
    lblPlus: TLabel;
    lblReceived: TLabel;
    EditReceived: TEdit;
    lblMinus: TLabel;
    spLine: TShape;
    lblChange: TLabel;
    EditChange: TEdit;
    lblEqual: TLabel;
    Label13: TLabel;
    EditReceiveDate: TDateBox;
    pnlShowAuthorization: TPanel;
    Label1: TLabel;
    EditAuthorization: TEdit;
    btMulti5: TSpeedButton;
    pnlMultiParcela: TPanel;
    pnlParc1: TPanel;
    lblParc1: TLabel;
    Label12: TLabel;
    cmbPayType1: TSuperComboADO;
    lblAuto1: TLabel;
    EditAuto1: TEdit;
    EditDep1: TDateBox;
    lblDep1: TLabel;
    Label16: TLabel;
    EditValue1: TEdit;
    pnlParc2: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    lblAuto2: TLabel;
    lblDep2: TLabel;
    Label22: TLabel;
    cmbPayType2: TSuperComboADO;
    EditAuto2: TEdit;
    EditDep2: TDateBox;
    EditValue2: TEdit;
    pnlParc3: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    lblAuto3: TLabel;
    lblDep3: TLabel;
    Label28: TLabel;
    cmbPayType3: TSuperComboADO;
    EditAuto3: TEdit;
    EditDep3: TDateBox;
    EditValue3: TEdit;
    pnlParc4: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    lblAuto4: TLabel;
    lblDep4: TLabel;
    Label33: TLabel;
    cmbPayType4: TSuperComboADO;
    EditAuto4: TEdit;
    EditDep4: TDateBox;
    EditValue4: TEdit;
    pnlParc5: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    lblAuto5: TLabel;
    lblDep5: TLabel;
    Label38: TLabel;
    cmbPayType5: TSuperComboADO;
    EditAuto5: TEdit;
    EditDep5: TDateBox;
    EditValue5: TEdit;
    quPaymentValue: TADOQuery;
    quPaymentValueTotal: TFloatField;
    cbxCloseLayaway: TCheckBox;
    Image4: TImage;
    Image5: TImage;
    pnlLayway: TPanel;
    lblPayment: TLabel;
    lblLayaway: TLabel;
    lbMenus: TLabel;
    Shape1: TShape;
    lbIqual: TLabel;
    lbBalance: TLabel;
    edPayment: TEdit;
    edLayaway: TEdit;
    edtBalance: TEdit;
    spHelp: TSpeedButton;
    btOK: TButton;
    btCancel: TButton;
    spPayCheck: TSpeedButton;
    lbPartialInfo: TLabel;
    btnPartialPayment: TSpeedButton;
    lbPartialInfo2: TLabel;
    btnPartialPayment2: TSpeedButton;
    spPreSaleDeleteDelayPayment: TADOStoredProc;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spPayCashClick(Sender: TObject);
    procedure spPayVisaClick(Sender: TObject);
    procedure cmbPaymentTypeSelectItem(Sender: TObject);
    procedure spDep30Click(Sender: TObject);
    procedure spPayMasterClick(Sender: TObject);
    procedure spPayAmericanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditReceivedChange(Sender: TObject);
    procedure SelecionaParcela(Sender: TObject);
    procedure cmbPayType1SelectItem(Sender: TObject);
    procedure cmbPayType2SelectItem(Sender: TObject);
    procedure cmbPayType3SelectItem(Sender: TObject);
    procedure cmbPayType4SelectItem(Sender: TObject);
    procedure cmbPayType5SelectItem(Sender: TObject);
    procedure pgReceiveChange(Sender: TObject);
    procedure RecalcTotals(Sender : TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditReceivedExit(Sender: TObject);
    procedure edPaymentChange(Sender: TObject);
    procedure edPaymentExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure edPaymentKeyPress(Sender: TObject; var Key: Char);
    procedure EditValue1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure spPayCheckClick(Sender: TObject);
    procedure btnPartialPaymentClick(Sender: TObject);
    procedure btnPartialPayment2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    MyIDPreSale,
    MyIDCliente,
    IDInvoice        : Integer;

    sRefound,
    sTotalRef,
    sReceive,
    sTotalRec,
    sSetDateTo       : String;

    MyTotInvoice,
    TotParcela,
    MyLayaway,
    MyTotCash,
    MyPayment        : Currency;

    MyquPreSaleInfo  : TADOQuery;
    MyquPreSaleItem  : TADOStoredProc;
    MyquPreSaleValue : TADOStoredProc;

    MyPaymentTypeID,
    MyOtherComID,
    MyIDTouristGroup : Integer;

    MyDepositDate,
    MyPreSaleDate    : TDateTime;
    MyIsLayaway      : Boolean;
    IsLayawayToClose : Boolean;
    MyIDCashRegMov   : Integer;
    OldTag           : Integer;
    nParcela         : Integer;
    IsOnRecalc       : Boolean;


    iSolicitacaoTEF : Integer;

    FrmPayPartial   : TFrmPayPartial;

    procedure PushError(ErrorType: Integer; sError: String);

    function ValidSinglePaymentType : Boolean;
    function ValidateMultiple(IsSaving : Boolean) : Boolean;

    function AddPayment:Boolean;
    function DoPay:Boolean;
    function PrintDocument:Boolean;

    procedure StartSingle;
    procedure StartMultiple;
    procedure PaintPanel(PanelTag : Integer; Color : Integer);
    procedure AtuDepositState(PaymentTypeID : Integer);
    procedure CreateParams( var Params: TCreateParams ); override;

    procedure PreencherCheck(PagTipo:String);
    procedure CancelPreDatar;

    function GetPayment:Double;
    function DeletePayment: Boolean;
  public
    { Public declarations }
    function Start(quPreSaleInfo:  TADOQuery;
                   quPreSaleValue: TADOStoredProc;
                   quPreSaleItem:  TADOStoredProc;
                   IDCashRegMov:   integer;
                   IsLayaway:      Boolean): Boolean;
  end;

implementation

uses uDM, xBase, uPassword, uPrintReceipt, uMsgBox, uMsgConstant, uHandleError,
     uNumericFunctions, uDateTimeFunctions, uCharFunctions, uDMGlobal,
     uSystemConst, EFiscal, uImpCheq, uFisPersistence;

{$R *.DFM}

procedure TFrmPaiPreSaleReceive.CancelPreDatar;
begin

  If FrmPayPartial <> nil then
     FrmPayPartial.ClearPaymentList;

  lbPartialInfo.Caption := '';
  lbPartialInfo2.Caption := '';

end;


procedure TFrmPaiPreSaleReceive.PushError(ErrorType: Integer; sError: String);
begin

   DM.SetError(ErrorType, Self.Name, sError);

end;

procedure TFrmPaiPreSaleReceive.PreencherCheck(PagTipo:String);
var
  BankCode : String;
begin

     if not (MyStrToInt(cmbPaymentType.LookUpValue) = PAY_TYPE_CHECK) then
        Exit;

     DM.IsCheck(PagTipo, BankCode);

    //MyquPreSaleInfo.FieldByName('FirstName').AsString;
    //MyquPreSaleInfo.FieldByName('LastName').AsString;

     if not DM.fPrintReceipt.PrintCheck then
        Exit;

     with TFrmImpCheq.Create(self) do
        begin
        Start(CHECK_VENDA);
        free;
        end;
end;


function TFrmPaiPreSaleReceive.GetPayment:Double;
begin

   if MyIsLayaway then
      Result := MyPayment
   else
      Result := MyTotInvoice;

end;

function TFrmPaiPreSaleReceive.DoPay:Boolean;
var
  cCash : Currency;
begin

 Try
     cCash  := 0;

     if pnlShowCash.Visible then
        cCash := MyStrToMoney(EditReceived.Text);

     DM.fPOS.PreSalePay(MyIDPreSale,
                        MyIDTouristGroup,
                        MyOtherComID,
                        MyIDCashRegMov,
                        DM.fStore.ID,
                        Now,
                        EditReceiveDate.Date,
                        cCash,
                        IDInvoice);

    Result := True;

 Except
    on E: Exception do
       begin
       PushError(CRITICAL_ERROR, 'PreSaleReceive.DoPay.Exception' + #13#10 + E.Message);
       Result := False;
       end;
 end;

end;

function TFrmPaiPreSaleReceive.PrintDocument:Boolean;
var
 iPrinType : Integer;
begin

      try

       if MyIsLayaway then
          iPrinType := RECEIPT_TYPE_LAYAWAY_RECEIVE
       else
          iPrinType := RECEIPT_TYPE_HOLD;


       if (DM.fPrintReceipt.PrintReceipt) then
          with TPrintReceipt.Create(Self) do
               Start(MyIDPreSale, iPrinType);

       Result := True;
      Except
        on E: Exception do
           begin
           PushError(CRITICAL_ERROR, 'PreSaleReceive.PrintDocument.Exception' + #13#10 + E.Message);
           Result := False;
           end;
      end;

end;

function TFrmPaiPreSaleReceive.AddPayment:Boolean;
  function GetAuthorization(sAuthorization: String): String;
  begin
    if sAuthorization = '' Then
      Result := Trim(EditAuthorization.Text)
    else
      Result := sAuthorization;
  end;
var
  Authorization : String;
  sValue : String;
  ExprireDate : TDateTime;
  i : Integer;
begin

      Authorization := '';
      DM.OpenCashRegister;

      try

        Result := True;

        btOK.Enabled := False;
        btCancel.Enabled := False;

        if MyStrToInt(cmbPaymentType.LookUpValue) = 1 then
           ExprireDate := Int(EditReceiveDate.Date)
        else
           ExprireDate := Int(EditDepositDate.Date);

        if pnlShowAuthorization.Visible then
           Authorization := EditAuthorization.Text;

        // Grava nova parcela
        if pgReceive.ActivePage = tbSingle then
           begin

           //Adicionar pagamento pre-datados caso tenha
           If (FrmPayPartial <> nil) and FrmPayPartial.HasDeposit then
               begin
               for i := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
                   begin
                   DM.fPOS.AddPayment(MyIDPreSale,
                                      DM.fStore.ID,
                                      DM.fUser.ID,
                                      MyIDCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDPaymentType,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDCashRegMov,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).PreSaleDate,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).ExpireDate,
                                      IntToStr(i+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count),
                                      GetAuthorization(TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Authorization),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Valor,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).NumeroDoc,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).DocCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).NomeCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Telefone,
                                      MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).Banco),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).OBS,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).PaymentPlace,
                                      True);
                   end;
               end
           else
               DM.fPOS.AddPayment(MyIDPreSale,
                                  DM.fStore.ID,
                                  DM.fUser.ID,
                                  MyIDCliente,
                                  MyStrToInt(cmbPaymentType.LookUpValue),
                                  MyIDCashRegMov,
                                  EditReceiveDate.Date,
                                  ExprireDate,
                                  '1/1',
                                  Authorization,
                                  GetPayment,
                                  '', '',  '',  '', 0, '',
                                  0,
                                  False);
           end
        else
           begin
           // Usa o validate para incluir
           Result := ValidateMultiple(True);
           end;

      except
          on E: Exception do
             begin
             PushError(CRITICAL_ERROR, 'PreSaleReceive.AddPayment.Exception' + #13#10 + E.Message);
             Result := False;
             end;
      end;

end;

procedure TFrmPaiPreSaleReceive.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  Params.Style := WS_THICKFRAME or WS_POPUP;
end;

function TFrmPaiPreSaleReceive.Start( quPreSaleInfo:  TADOQuery;
                                quPreSaleValue: TADOStoredProc;
                                quPreSaleItem:  TADOStoredProc;
                                IDCashRegMov:   integer;
                                IsLayaway:      Boolean): Boolean;
begin
  MyIDCashRegMov   := IDCashRegMov;

  MyIDPreSale      := quPreSaleInfo.FieldByName('IDPreSale').AsInteger;
  MyIDCliente      := quPreSaleInfo.FieldByName('IDCustomer').AsInteger;

  MyTotInvoice     := quPreSaleValue.FieldByName('TotalInvoice').AsFloat;

  MyPaymentTypeID  := quPreSaleInfo.FieldByName('IDMeioPag').AsInteger;
  MyDepositDate    := quPreSaleInfo.FieldByName('DepositDate').AsDateTime;
  MyPreSaleDate    := quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime;

  MyOtherComID     := quPreSaleInfo.FieldByName('OtherComissionID').AsInteger;
  MyIDTouristGroup := quPreSaleInfo.FieldByName('IDTouristGroup').AsInteger;

  MyquPreSaleInfo  := quPreSaleInfo;
  MyquPreSaleValue := quPreSaleValue;
  MyquPreSaleItem  := quPreSaleItem;
  MyIsLayaway      := IsLayaway;
  EditReceiveDate.Date := Now;

  tbMultiple.TabVisible := not MyIsLayaway;

  cbxCloseLayaway.Checked := True;
  cbxCloseLayaway.Visible := False;

  if MyIsLayaway then
    begin
      // Mostros os campos do Layaway
      lblPayment.Visible := True;
      edPayment.Visible  := True;
      lblLayaway.Visible := True;
      edPayment.Visible  := True;
      edLayaway.Visible  := True;
      lbMenus.Visible    := True;
      lbIqual.Visible    := True;
      lbBalance.Visible  := True;
      edtBalance.Visible := True;

      // Calculo o total de layaway
      with quPaymentValue do
        begin
          Close;
          Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
          Open;
          MyLayaway := quPaymentValueTotal.AsFloat;
          Close;
        end;

      // Sugiro o valor restante a pagar
      MyPayment       := MyTotInvoice - MyLayaway;
      edLayaway.text  := FloatToStrF(MyLayaway, ffCurrency, 20, 2);
      edtBalance.text := FloatToStrF(MyPayment, ffCurrency, 20, 2);


      IsLayawayToClose := MyPayment=0;

      //Verifico se e para fechar o Layaway
      if  IsLayawayToClose then
         begin
         pnlPaymentType.Visible  := False;
         pnlShowCash.Visible     := False;
         lblPayment.Visible      := False;
         edPayment.Visible       := False;
         lbIqual.Visible         := False;

         cbxCloseLayaway.Visible := True;
         cbxCloseLayaway.Enabled := False;
         end
      else
         begin
         cbxCloseLayaway.Visible := False;
         edPayment.Clear;
         end;
    end
  else
    begin
      // Sumo com os campos do layaway
      lblPayment.Visible := False;
      edPayment.Visible  := False;
      lblLayaway.Visible := False;
      edPayment.Visible  := False;
      edLayaway.Visible  := False;
      lbMenus.Visible    := False;
      lbIqual.Visible    := False;
      lbBalance.Visible  := False;
      edtBalance.Visible := False;
    end;

  // Numero de Parcelas
  nParcela  := 1;

  Left   := 0;
  Top    := 102;
  Height := Screen.Height - Top;

  Result := (ShowModal = mrOK );
end;

procedure TFrmPaiPreSaleReceive.btOKClick(Sender: TObject);
var
  bCanExec : Boolean;
  AC : Char;
  IniFech, CodFiscal : String;
  InvoiceDiscount,
  TotalReceived : Currency;
begin

  // Faz todas as validaçoes aqui e depois chama a rotina correta
  if not IsLayawayToClose then
     begin
      if pgReceive.ActivePage = tbSingle then
         begin
          if not ValidSinglePaymentType then
             Exit;
             //Verify the payment Type in Check
             PreencherCheck(cmbPaymentType.LookUpValue);

         if pnlShowAuthorization.Visible and (EditAuthorization.Text = '') then
            begin
             EditAuthorization.SetFocus;
             MsgBox(MSG_CRT_NO_AUTHORIZANUMBER, vbOKOnly + vbCritical);
             Exit;
            end;
         end
     else
         begin
          // Valida o recebimento Multiple
          if not ValidateMultiple(False) then
             Exit;
         end;

         if not TestDate(EditReceiveDate.Text) then
            begin
             MsgBox(MSG_CRT_INVAL_DATE_RECEIVE, vbCritical + vbOkOnly);
             EditReceiveDate.SetFocus;
             Exit;
            end;

         // Testa o troco dado
         // Teste se Received > Total PreSale
         if MyIsLayaway then
            begin
            if (spPayCash.Down and (MyRound(MyPayment-MyStrToMoney(EditReceived.Text), 2)>0)) then
                begin
                 EditReceived.SetFocus;
                 MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
                 Exit;
                end;

            //Payment cannot be zero
            if MyPayment = 0 then
               begin
                MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
                edPayment.SetFocus;
                exit;
               end;

            //Invalid Payment
            if MyPayment > (MyTotInvoice - MyLayaway) then
               begin
                MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
                edPayment.SetFocus;
                Exit;
               end;
         end
       else
         begin
         if ((MyTotCash > 0) and (MyRound(MyTotCash-MyStrToMoney(EditReceived.Text), 2)>0)) then
             begin
              EditReceived.SetFocus;
              MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
              Exit;
             end;
         end;
     end;

     //Impressora fiscal
     if DM.fCashRegister.Fiscal then
     begin

      if DM.fModuloFiscal.InvoiceDiscount then
         InvoiceDiscount := MyquPreSaleValue.FieldByName('ItemDiscount').AsCurrency
      else
         InvoiceDiscount := 0;

      if InvoiceDiscount < 0 then
         AC := 'A'
      else
         AC := 'D';

      if MyStrToInt(cmbPaymentType.LookUpValue) = PAY_TYPE_CASH then
         TotalReceived := MyStrToMoney(EditReceived.Text)
      else
         TotalReceived := MyTotInvoice;

      if cmbPaymentType.LookUpValue = '' then
        CodFiscal := ''
      else
        CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPaymentType.LookUpValue], 'MeioPag', 'CodFiscal');

      {pagamento em cinco(5) formas <> para recebimento}
      IniFech := FISCAL_FECHA_NOTA_ACRES_DESC       + AC + ';' +
                 FISCAL_FECHA_NOTA_TIPO_ACRES_DESC  + '$;' +
                 FISCAL_FECHA_NOTA_VALOR_ACRES_DESC + MyFormatCur(Abs(InvoiceDiscount),DM.fModuloFiscal.Decimal)+';'+
                 FISCAL_FECHA_NOTA_TIPO_PAGAMENTO   + cmbPaymentType.Text + ';' +
                 FISCAL_FECHA_NOTA_MSG              + MyquPreSaleInfo.FieldByName('Note').AsString + ';' +
                 FISCAL_FECHA_NOTA_VALOR_PAGO       + MyFormatCur(TotalReceived,DM.fModuloFiscal.Decimal) +';'+
                 FISCAL_ITEM_PONTO_DEC              + DM.fModuloFiscal.Decimal+';' +
                 FISCAL_FECHA_NOTA_IDX_PAGAMENTO    + CodFiscal+';';

      with DM.EFiscal1 do
         begin
         if pgReceive.ActivePage = tbSingle then
            begin
               bCanExec := FechaCupomFiscal(IniFech);
            end
         else if pgReceive.ActivePage = tbMultiple then
                begin
                bCanExec := IniFechCupfisc(IniFech);

                {if bCanExec then
                   bCanExec := FechaCupomFiscal(IniFech);}

                if cmbPayType1.Text<>'' then
                   begin
                   CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPayType1.LookUpValue], 'MeioPag', 'CodFiscal');
                   EfetuaFormaPagamento(cmbPayType1.Text, StrToCurr(EditValue1.Text), CodFiscal);
                   PreencherCheck(cmbPaymentType.LookUpValue);

                   if cmbPayType2.Text<>'' then
                      begin
                      CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPayType2.LookUpValue], 'MeioPag', 'CodFiscal');
                      EfetuaFormaPagamento(cmbPayType2.Text, StrToCurr(EditValue2.Text), CodFiscal);
                      PreencherCheck(cmbPaymentType.LookUpValue);

                      if cmbPayType3.Text<>'' then
                         begin
                         CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPayType3.LookUpValue], 'MeioPag', 'CodFiscal');
                         EfetuaFormaPagamento(cmbPayType3.Text, StrToCurr(EditValue3.Text), CodFiscal);
                         PreencherCheck(cmbPaymentType.LookUpValue);

                         if cmbPayType4.Text<>'' then
                            begin
                            CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPayType4.LookUpValue], 'MeioPag', 'CodFiscal');
                            EfetuaFormaPagamento(cmbPayType4.Text, StrToCurr(EditValue4.Text), CodFiscal);
                            PreencherCheck(cmbPaymentType.LookUpValue);

                            if cmbPayType5.Text<>'' then
                               begin
                               CodFiscal := DM.DescCodigo(['IDMeioPag'], [cmbPayType5.LookUpValue], 'MeioPag', 'CodFiscal');
                               EfetuaFormaPagamento(cmbPayType5.Text, StrToCurr(EditValue5.Text), CodFiscal);
                               PreencherCheck(cmbPaymentType.LookUpValue);
                               end;
                            end;
                         end;
                      end;
                    end;
                if bCanExec then
                   bCanExec := TermFechCupFisc(MyquPreSaleInfo.FieldByName('Note').AsString);
                end;
         end; //end With

     if not bCanExec then
        Exit;

     end; //end IF Fiscal


  try

     bCanExec := True;

     DM.ADODBConnect.BeginTrans;

     if not (MyIsLayaway) or (MyIsLayaway and (MyPayment <> 0)) then
     begin
        If MyIsLayaway Then
           bCanexec := DeletePayment;
        if bCanexec then
          bCanExec := AddPayment;
     end;

     //Close Payment
     if bCanExec then
        if not (MyIsLayaway) or ((MyRound(MyTotInvoice-(MyPayment + MyLayaway),2)=0) and (cbxCloseLayaway.Checked)) then
           bCanExec := DoPay;

     if DM.fCashRegister.Fiscal Then
     begin
      //Tipo60
      if bCanExec and AddTipo60ResumoDiario(Self, IDInvoice) then
        AddTipo60ResumoItem(Self, IDInvoice, DM.fPOS.InvoiceItem);
     end;

   Finally

     if bCanExec then
       begin
       DM.ADODBConnect.CommitTrans;

       //Imprime o pagamento
       bCanExec := PrintDocument;

       if not bCanExec then
          MsgBox(MSG_CRT_ERROR_PRINT, vbCritical + vbOkOnly);


       btCancel.Enabled := True;
       btOK.Enabled := True;
       ModalResult := mrOK;
       end
     else
       begin
       DM.ADODBConnect.RollbackTrans;
       btCancel.Enabled := True;
       btOK.Enabled := True;
       MsgBox(MSG_INF_NOT_RECEIVE_HOLD, vbInformation + vbOkOnly);
       ModalResult := mrNone;
       end;

   end;

  if DM.fCashRegister.Open then
     DM.EFiscal1.AbreGaveta;
end;

procedure TFrmPaiPreSaleReceive.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
   CancelPreDatar;
end;

procedure TFrmPaiPreSaleReceive.FormShow(Sender: TObject);
begin
  WindowState := wsNormal;

  // Seta Panel so do Cash
//  pnlShowCash.Visible := False;
  pnlShowCash.Visible := not IsLayawayToClose;


  // Carrega valores iniciais do pagamento
  EditTotalInvoice.Text  := FloatToStrF(MyTotInvoice, ffCurrency, 20, 2);

  lblMinus.Visible   := MyTotInvoice > 0;
  EditChange.Visible := lblMinus.Visible;
  lblEqual.Visible   := lblMinus.Visible;
  lblChange.Visible  := lblMinus.Visible;
  spLine.Visible     := lblMinus.Visible;

  if MyTotInvoice < 0 then
    begin
     btOk.Caption := sRefound;
     lblCashTotal.Caption := sTotalRef;
    end
  else
    begin
     lblCashTotal.Caption := sTotalRec;
     btOk.Caption := sReceive;
    end;

  StartSingle;
end;

procedure TFrmPaiPreSaleReceive.spPayCashClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_CASH);
  cmbPaymentTypeSelectItem(nil);
  if MyIsLayaway then
     edPayment.SetFocus
  else
     begin
     if not pnlShowCash.Visible then
     pnlShowCash.Visible := True;
     EditReceived.SetFocus;
     end;
end;

procedure TFrmPaiPreSaleReceive.spPayVisaClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_VISA);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TFrmPaiPreSaleReceive.cmbPaymentTypeSelectItem(Sender: TObject);
begin

  MyTotCash := 0;

  case MyStrToInt(cmbPaymentType.LookUpValue) of
    PAY_TYPE_CASH     : begin
                         spPayCash.Down     := True;
                         MyTotCash          := MyTotInvoice;
                         if MyIsLayaway then
                           EditTotalCash.Text := FloatToStrF(MyPayment, ffCurrency, 20, 2)
                         else
                           EditTotalCash.Text := FloatToStrF(MyTotCash, ffCurrency, 20, 2);
                        end;

    PAY_TYPE_VISA     : spPayVisa.Down     := True;
    PAY_TYPE_AMERICAN : spPayAmerican.Down := True;
    PAY_TYPE_MASTER   : spPayMaster.Down   := True;
    PAY_TYPE_CHECK    : spPayCheck.Down    := True;
  else
    begin
      // nao seleciona
      spPayCash.Down     := False;
      spPayVisa.Down     := False;
      spPayAmerican.Down := False;
      spPayMaster.Down   := False;
      spPayCheck.Down    := False;
    end;
  end;

  // Atualiza estado do Deposit Date
  AtuDepositState(MyStrToInt(cmbPaymentType.LookUpValue));

  if (MyStrToInt(cmbPaymentType.LookUpValue) > 0) and not ValidSinglePaymentType then
     Exit;

  if MyStrToInt(cmbPaymentType.LookUpValue) > 1 then
    begin
      pnlShowAuthorization.Visible := True;
      EditAuthorization.Text       := '';
      EditAuthorization.SetFocus;
    end
  else
    pnlShowAuthorization.Visible := False;

  // Mostra o panel de Cash se pagamento for do tipo cash
  pnlShowCash.Visible := (MyTotCash > 0);

  if pnlShowCash.Visible then
     EditReceived.SetFocus;

  //Cancela Pre-Datado se trocar de tipo de pago   
  CancelPreDatar;

end;

procedure TFrmPaiPreSaleReceive.spDep30Click(Sender: TObject);
begin
  EditDepositDate.Text := DateToStr(Int(EditReceiveDate.Date) +
                          MyStrToInt(RightStr(TSpeedButton(Sender).Caption, 1)));
end;

procedure TFrmPaiPreSaleReceive.spPayMasterClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_MASTER);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TFrmPaiPreSaleReceive.spPayAmericanClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_AMERICAN);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TFrmPaiPreSaleReceive.AtuDepositState(PaymentTypeID : Integer);
begin
  // Desabilita tudo
  spDep30.Down := False;
  spDep60.Down := False;
  spDep90.Down := False;

  spDep30.Visible    := False;
  spDep60.Visible    := False;
  spDep90.Visible    := False;
  lblPreDate.Visible := False;

  with spquPayTypeMin do
    begin
      if Active then Close;
      Parameters.ParambyName('@IDMeioPag').Value := PaymentTypeID;
      Open;
      First;
      while not Eof do
       begin
         if (spquPayTypeMinDifDay.AsInteger > 0) and
            (MyTotInvoice >= spquPayTypeMinTotalSale.AsFloat) then
           begin
             if not spDep30.Visible then
               begin
                spDep30.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
                spDep30.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
                spDep30.Visible := True;
               end
             else if not spDep60.Visible then
               begin
                spDep60.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
                spDep60.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
                spDep60.Visible := True;
               end
             else if not spDep90.Visible then
               begin
                spDep90.Caption := '+&' + Trim(spquPayTypeMinDifDay.AsString);
                spDep90.Hint    := sSetDateTo + DateToStr(Int(EditReceiveDate.Date) + spquPayTypeMinDifDay.AsInteger);
                spDep90.Visible := True;
               end;
           end;
         Next;
       end;

      Close;

      // testa se mostra o panel de deposit date
      pnlDepositDate.Visible := spDep30.Visible;

      lblPreDate.Visible := (not spDep30.Visible) and (not Password.HasFuncRight(17));

      if lblPreDate.Visible then
        begin
         EditDepositDate.Color    := clSilver;
         EditDepositDate.ReadOnly := True;
        end
      else
        begin
         EditDepositDate.Color    := clWhite;
         EditDepositDate.ReadOnly := False;
        end;

    end;
end;

procedure TFrmPaiPreSaleReceive.PaintPanel(PanelTag : Integer; Color : Integer);
begin
  case PanelTag of
       1   :  pnlPayTitle.Color     := Color;
       2   :  pnlDateTitle.Color    := Color;
  end;
end;

procedure TFrmPaiPreSaleReceive.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmPaiPreSaleReceive.EditReceivedChange(Sender: TObject);
var
   Code  : Integer;
   Value : Real;
begin
  // Muda o change automatico
  if Trim(EditReceived.Text) = '' then
     EditChange.Text := FloatToStrF(0, ffCurrency, 20, 2);

   Val(EditReceived.Text, Value, Code);
   if Code = 0 then
     if MyIsLayaway then
        EditChange.Text := FloatToStrF(Value-MyPayment, ffCurrency, 20, 2)
     else
        EditChange.Text := FloatToStrF(Value-MyTotCash, ffCurrency, 20, 2);

end;

procedure TFrmPaiPreSaleReceive.SelecionaParcela(Sender: TObject);
var
  i, j : integer;
  MyPanel : TPanel;
begin
  // Numero de Parcelas
  nParcela := TSpeedButton(Sender).Tag;

  // Seleciona as parcelas que vao aparecer
  with pnlMultiParcela do
   begin
    for i := 0 to (ControlCount - 1) do
      begin
       if not (Controls[i] is TPanel) then Continue;
       // Mostra as parcelas dependendo do numero selecionado
       Controls[i].Visible := (Controls[i].Tag <= TSpeedButton(Sender).Tag);
       // Apaga todos os valores dos campos
       MyPanel := TPanel(Controls[i]);
       try
         IsOnRecalc := True;
         for j := 0 to (MyPanel.ControlCount - 1) do
           begin
             if MyPanel.Controls[j] is TSuperComboADO then
               begin
                 TSuperComboADO(MyPanel.Controls[j]).LookUpValue := '';
                 TSuperComboADO(MyPanel.Controls[j]).OnSelectItem(MyPanel.Controls[j]);
               end
             else if MyPanel.Controls[j] is TEdit then
               TEdit(MyPanel.Controls[j]).Text := ''
             else if MyPanel.Controls[j] is TDateBox then
               TDateBox(MyPanel.Controls[j]).Date := Int(EditReceiveDate.Date);
           end;
       finally
         IsOnRecalc := False;
       end;
      end;
   end;

  RecalcTotals(nil);
end;

procedure TFrmPaiPreSaleReceive.cmbPayType1SelectItem(Sender: TObject);
begin
   lblAuto1.Visible    := (MyStrToInt(cmbPayType1.LookUpValue) > 1);
   EditAuto1.Visible   := lblAuto1.Visible;

   EditDep1.Visible    := lblAuto1.Visible;
   lblDep1.Visible     := EditDep1.Visible;
   RecalcTotals(EditValue1);

   btnPartialPayment2.Visible := lblAuto1.Visible;

   //Cancela Pre-Datado se trocar de tipo de pago
   CancelPreDatar;
   
end;

procedure TFrmPaiPreSaleReceive.cmbPayType2SelectItem(Sender: TObject);
begin
   lblAuto2.Visible    := (MyStrToInt(cmbPayType2.LookUpValue) > 1);
   EditAuto2.Visible   := lblAuto2.Visible;

   EditDep2.Visible    := lblAuto2.Visible;
   lblDep2.Visible     := EditDep2.Visible;
   RecalcTotals(EditValue2);
end;

procedure TFrmPaiPreSaleReceive.cmbPayType3SelectItem(Sender: TObject);
begin
   lblAuto3.Visible  := (MyStrToInt(cmbPayType3.LookUpValue) > 1);
   EditAuto3.Visible := lblAuto3.Visible;

   EditDep3.Visible    := lblAuto3.Visible;
   lblDep3.Visible     := EditDep3.Visible;
   RecalcTotals(EditValue3);
end;

procedure TFrmPaiPreSaleReceive.cmbPayType4SelectItem(Sender: TObject);
begin
   lblAuto4.Visible  := (MyStrToInt(cmbPayType4.LookUpValue) > 1);
   EditAuto4.Visible := lblAuto4.Visible;

   EditDep4.Visible    := lblAuto4.Visible;
   lblDep4.Visible     := EditDep4.Visible;
   RecalcTotals(EditValue4);
end;

procedure TFrmPaiPreSaleReceive.cmbPayType5SelectItem(Sender: TObject);
begin
   lblAuto5.Visible  := (MyStrToInt(cmbPayType5.LookUpValue) > 1);
   EditAuto5.Visible := lblAuto5.Visible;

   EditDep5.Visible    := lblAuto5.Visible;
   lblDep5.Visible     := EditDep5.Visible;
   RecalcTotals(EditValue5);
end;

procedure TFrmPaiPreSaleReceive.pgReceiveChange(Sender: TObject);
begin
   // Ajusta qual modo vai aparecer
   case pgReceive.ActivePage.TabIndex of
        0  :  StartSingle;

        1  :  StartMultiple;
   end;

  //Cancela Pre-Datado se trocar de tipo de pago   
  CancelPreDatar;
   
end;

procedure TFrmPaiPreSaleReceive.StartSingle;
begin
  pgReceive.ActivePage := tbSingle;

  spDep30.Down := False;
  spDep60.Down := False;
  spDep90.Down := False;

  cmbPaymentType.LookUpValue := '';
  cmbPaymentTypeSelectItem(nil);

  EditDepositDate.Date := Int(EditReceiveDate.Date);

  // Testa se vendedor fez algum Deposit Date pre setado
  if ( MyPaymentTypeID > 0 ) then
    begin
     // Seleciona a forma de pagamento escolhida pelo vendedor
     cmbPaymentType.LookUpValue := IntToStr(MyPaymentTypeID);
     cmbPaymentTypeSelectItem(nil);
     EditDepositDate.Date       := MyDepositDate;
     MsgBox(MSG_INF_INVOICE_HAS_SETUP, vbOKOnly + vbInformation);
    end;

  if not IsLayawayToClose then
     cmbPaymentType.SetFocus;
end;

procedure TFrmPaiPreSaleReceive.StartMultiple;
begin
  pgReceive.ActivePage := tbMultiple;
  IsOnRecalc           := False;

  pnlShowCash.Visible  := False;

  btMulti2.Down := True;
  SelecionaParcela(btMulti2);
end;

procedure TFrmPaiPreSaleReceive.RecalcTotals(Sender : TObject);
var
  SubTotal     : Double;
  MyEditValue  : TEdit;
  MycmbPayType : TSuperComboADO;
  i            : integer;
begin
  // Recalcula os totais para que sempre sobre a divisao do numero de parcelas
  if IsOnRecalc then Exit;

  MyTotCash := 0;
  SubTotal  := 0;

  // Desabilita o Loop do change to text do controle
  IsOnRecalc  := True;

  with pnlMultiParcela do
   begin
    for i := 0 to (ControlCount - 1) do
      begin
        if not (Controls[i] is TPanel) then Continue;

        if not Controls[i].Visible then Continue;

        MyEditValue  := TEdit(Self.FindComponent('EditValue' + Trim(IntToStr(Controls[i].Tag))));
        MycmbPayType := TSuperComboADO(Self.FindComponent('cmbPayType' + Trim(IntToStr(Controls[i].Tag))));

        if Sender = nil then
          begin
           // Entra quando for todas as parcelas
           MyEditValue.Text := MyFloatToStr(MyRound(MyTotInvoice/nParcela, 2));
          end
        else
          begin
           // Entra quando estiver editando um field
           if Controls[i].Tag > TSpeedButton(Sender).Tag then
             begin
               // Calcula dividido pelo resto dos outros campos
               MyEditValue.Text := MyFloatToStr(MyRound((MyTotInvoice-SubTotal)/(nParcela-TSpeedButton(Sender).Tag), 2));
               if MyStrToInt(MycmbPayType.LookUpValue) = 1 then
                  MyTotCash := MyTotCash + MyStrToMoney(MyEditValue.Text);
             end
           else
             begin
               SubTotal := SubTotal + MyStrToMoney(MyEditValue.Text);
               if MyStrToInt(MycmbPayType.LookUpValue) = 1 then
                  MyTotCash := MyTotCash + MyStrToMoney(MyEditValue.Text);
             end;
          end;
      end;
   end;

   if (MyTotCash > 0) then
     begin
     pnlShowCash.Visible := True;
     EditTotalCash.Text  := FloatToStrF(MyTotCash, ffCurrency, 20, 2);
     EditReceived.Text   := FormatFloat('###0.00', MyTotCash);
     EditChange.Text     := FloatToStrF(0, ffCurrency, 20, 2);
     end
   else
     pnlShowCash.Visible := False;

   IsOnRecalc  := False;
end;

procedure TFrmPaiPreSaleReceive.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssAlt] then
    begin
      if UpperCase(Chr(Key)) = 'S' then
         StartSingle
      else if UpperCase(Chr(Key)) = 'M' then
         StartMultiple;
    end;
end;

function TFrmPaiPreSaleReceive.ValidateMultiple(IsSaving : Boolean) : Boolean;
  function GetAuthorization(sAuthorization: String): String;
  begin
    if sAuthorization = '' Then
      Result := Trim(EditAuto1.Text)
    else
      Result := sAuthorization;
  end;
var
  MyEditValue   : TEdit;
  MycmbPayType  : TSuperComboADO;
  MyEditAuto    : TEdit;
  MyEditDep     : TDateBox;
  i,j           : integer;
  Authorization : String;
  ExprireDate   : TDateTime;

begin
  // Valida multiplas parcelas
  Result := False;

  Authorization := '';

  with pnlMultiParcela do
   begin
    for i := 0 to (ControlCount - 1) do
      begin
        if not (Controls[i] is TPanel) then Continue;
        if not Controls[i].Visible then Continue;

        MyEditValue  := TEdit(Self.FindComponent('EditValue' + Trim(IntToStr(Controls[i].Tag))));
        MycmbPayType := TSuperComboADO(Self.FindComponent('cmbPayType' + Trim(IntToStr(Controls[i].Tag))));
        MyEditAuto   := TEdit(Self.FindComponent('EditAuto' + Trim(IntToStr(Controls[i].Tag))));
        MyEditDep    := TDateBox(Self.FindComponent('EditDep' + Trim(IntToStr(Controls[i].Tag))));

        if IsSaving then
           begin
           if MyStrToInt(cmbPaymentType.LookUpValue) = 1 then
              ExprireDate := EditReceiveDate.Date
           else
              ExprireDate := MyEditDep.Date;

           if MyEditAuto.Visible then
              Authorization := MyEditAuto.Text;

           If (FrmPayPartial <> nil) and FrmPayPartial.HasDeposit then
               begin
               for j := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
                   begin
                   DM.fPOS.AddPayment(MyIDPreSale,
                                      DM.fStore.ID,
                                      DM.fUser.ID,
                                      MyIDCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).IDPaymentType,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).IDCashRegMov,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).PreSaleDate,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).ExpireDate,
                                      IntToStr(i+1)+'/'+IntToStr(ControlCount-3) + ' - ' +IntToStr(j+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count),
                                      GetAuthorization(TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Authorization),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Valor,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).NumeroDoc,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).DocCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).NomeCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Telefone,
                                      MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).Banco),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).OBS,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[J].Data).PaymentPlace,
                                      True);

                   end;
                //Depois que efetuar o Pre-Datado tenho que limpar os valores
                CancelPreDatar;
                end
           else
               begin
               DM.fPOS.AddPayment(MyIDPreSale,
                                  DM.fStore.ID,
                                  DM.fUser.ID,
                                  MyIDCliente,
                                  MyStrToInt(MycmbPayType.LookUpValue),
                                  MyIDCashRegMov,
                                  EditReceiveDate.Date,
                                  ExprireDate,
                                  IntToStr(i+1)+'/'+IntToStr(ControlCount-3),
                                  Authorization,
                                  MyStrToMoney(MyEditValue.Text),
                                  '', '',  '',  '', 0, '',
                                  0, False);
               end;
               
           Continue;  // Passa para o proximo campo
           end;

        // Testa se authorization e valida
        if MycmbPayType.LookUpValue = '' then
          begin
            MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbInformation);
            if MyEditAuto.Visible then
               MyEditAuto.SetFocus;
            Exit;
          end;

        // Testa se valor e branco
        if MyEditValue.Text = '' then
          begin
            MsgBox(MSG_CRT_NO_AMOUNT, vbOKOnly + vbInformation);
            if MyEditValue.Visible then
               MyEditValue.SetFocus;
            Exit;
          end;

        // Testa se authorization e valida
        if MyEditAuto.Visible and (MyEditAuto.Text = '') then
          begin
            MsgBox(MSG_CRT_NO_AUTHORIZANUMBER, vbOKOnly + vbInformation);
            if MyEditAuto.Visible then
               MyEditAuto.SetFocus;
            Exit;
          end;

        // Teste de Invoice com Special Price com Payment Type diferente de Cash
        if (MyquPreSaleInfo.FieldByName('MediaID').AsInteger = MEDIA_TYPE_GUIDE) and
            MyquPreSaleValue.FieldByName('TaxIsent').AsBoolean and
           (MyStrToInt(MycmbPayType.LookUpValue) <> PAY_TYPE_CASH) then
          begin
            if Password.HasFuncRight(18) then
              begin
               if MsgBox(MSG_QST_INVOICE_ONLY_CASH, vbYesNo + vbQuestion) = vbNo then
                  Exit;
              end
            else
              begin
                  MycmbPayType.SetFocus;
                  MsgBox(MSG_INF_INVOICE_REC_ONLY_CASH, vbOKOnly + vbInformation);
                  Exit;
              end;
          end;

        // teste de data valida
        if MyEditDep.visible and not TestDate(MyEditDep.Text) then
          begin
           if MyEditDep.Visible then
              MyEditDep.SetFocus;
           MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbInformation);
           Exit;
          end;

        // Teste de pre date valido
        // testa valor minimo para pagamento em cada tipo
        if (MyEditDep.Visible) and (MyTotInvoice > 0) then
           with spTestpayType do
             begin
               Parameters.ParambyName('@IDMeioPag').Value  := MyStrToInt(MycmbPayType.LookUpValue);
               //#Rod - Round
               Parameters.ParambyName('@DifDay').Value     := Int(MyEditDep.Date-Int(EditReceiveDate.Date));
               Parameters.ParambyName('@Value').Value      := MyTotInvoice;
               ExecProc;

               case Parameters.ParambyName('RETURN_VALUE').Value of
                    1           : begin
                                    if Password.HasFuncRight(17) then
                                      begin
                                       if MsgBox(MSG_QST_AMOUN_NOT_REACH_MIN, vbYesNo + vbQuestion) = vbNo then
                                         begin
                                          MyEditValue.SetFocus;
                                          Exit;
                                         end;
                                      end
                                    else
                                      begin
                                        MyEditDep.SetFocus;
                                        MsgBox(MSG_INF_INVOICE_NOT_REACH_DATE, vbOKOnly + vbInformation);
                                        Exit;
                                      end;
                                  end;
                   -1           : begin
                                    if Password.HasFuncRIght(17) then
                                      begin
                                       if MsgBox(MSG_QST_PAYTYPE_NOT_ALLOW_DATE, vbYesNo + vbQuestion) = vbNo then
                                         begin
                                          MyEditValue.SetFocus;
                                          Exit;
                                         end;
                                      end
                                    else
                                      begin
                                        MyEditDep.SetFocus;
                                        MsgBox(MSG_INF_PAYTYPE_NOT_THIS_DATE, vbOKOnly + vbInformation);
                                        Exit;
                                      end;
                                  end;
               end;
             end;
      end;
   end;

  Result := True;

end;

procedure TFrmPaiPreSaleReceive.EditReceivedExit(Sender: TObject);
begin
   EditReceived.Text := FormatFloat('###0.00', MyStrToMoney(EditReceived.Text));
end;

function TFrmPaiPreSaleReceive.ValidSinglePaymentType : Boolean;
begin
   Result := False;

   // Valida o recebimento single
   if cmbPaymentType.LookUpValue = '' then
     begin
      cmbPaymentType.SetFocus;
      MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbCritical);
      Exit;
     end;

   if not TestDate(EditDepositDate.Text) and pnlDepositDate.Visible then
     begin
      EditDepositdate.SetFocus;
      MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
      Exit;
     end;

   // Teste de Invoice com Special Price com Payment Type diferente de Cash
   if (MyquPreSaleInfo.FieldByName('MediaID').AsInteger = MEDIA_TYPE_GUIDE) and
       MyquPreSaleValue.FieldByName('TaxIsent').AsBoolean and
      (MyStrToInt(cmbPaymentType.LookUpValue) <> PAY_TYPE_CASH) then
     begin
       if Password.HasFuncRight(18) then
         begin
          if MsgBox(MSG_QST_INVOICE_ONLY_CASH, vbYesNo + vbQuestion) = vbNo then
             Exit;
         end
       else
         begin
             cmbPaymentType.SetFocus;
             MsgBox(MSG_INF_INVOICE_REC_ONLY_CASH, vbOKOnly + vbInformation);
             Exit;
         end;
     end;

   if MyTotInvoice > 0 then
     begin
      // testa valor minimo para pagamento em cada tipo
      with spTestpayType do
        begin
          Parameters.ParambyName('@IDMeioPag').Value := MyStrToInt(cmbPaymentType.LookUpValue);
          Parameters.ParambyName('@DifDay').Value    := Int(EditDepositDate.Date-Int(EditReceiveDate.Date));
          Parameters.ParambyName('@Value').Value     := MyTotInvoice;
          ExecProc;

          case Parameters.ParambyName('RETURN_VALUE').Value of
               1           : begin
                               if Password.HasFuncRight(17) then
                                 begin
                                  if MsgBox(MSG_QST_AMOUN_NOT_REACH_MIN, vbYesNo + vbQuestion) = vbNo then
                                     Exit;
                                 end
                               else
                                 begin
                                   if pnlDepositDate.Visible then
                                      EditDepositDate.SetFocus;
                                   MsgBox(MSG_INF_INVOICE_NOT_REACH_DATE, vbOKOnly + vbInformation);
                                   Exit;
                                 end;
                             end;
              -1           : begin
                               if Password.HasFuncRight(17) then
                                 begin
                                  if MsgBox(MSG_QST_PAYTYPE_NOT_ALLOW_DATE, vbYesNo + vbQuestion) = vbNo then
                                     Exit;
                                 end
                               else
                                 begin
                                   if pnlDepositDate.Visible then
                                      EditDepositDate.SetFocus;
                                   MsgBox(MSG_INF_PAYTYPE_NOT_THIS_DATE, vbOKOnly + vbInformation);
                                   Exit;
                                 end;
                             end;
          end;
        end;
     end;

   Result := True;
end;

procedure TFrmPaiPreSaleReceive.edPaymentChange(Sender: TObject);
var
   Code     : Integer;
   Value    : Real;
   cPayment : Currency;
begin
  // Muda o change automatico
  if Trim(edPayment.Text) = '' then
     MyPayment := 0
  else
     MyPayment := MyStrToMoney(edPayment.Text);

   //Val(edPayment.Text, Value, Code);
   //if Code = 0 then
   //  MyPayment := Value;

   EditReceived.Text := edPayment.Text;

   EditTotalCash.Text := FloatToStrF(MyPayment, ffCurrency, 20, 2);

   Try
     cPayment := MyStrToCurrency(edPayment.Text);
   Except
     cPayment := 0
   end;

   //cbxCloseLayaway.Visible := (MyRound(MyTotInvoice-(MyPayment + MyLayaway),2)=0);
   cbxCloseLayaway.Visible := (MyRound(MyTotInvoice-(cPayment + MyLayaway),2)=0);

   if cbxCloseLayaway.Visible then
      cbxCloseLayaway.Checked := (MsgBox(MSG_QST_CLOSE_LAYAWAY, vbYesNo + vbQuestion) = vbYes);

end;

procedure TFrmPaiPreSaleReceive.edPaymentExit(Sender: TObject);
begin

  if cmbPaymentType.Text = '' then
     Exit;

  edPayment.Text := FormatFloat('###0.00', MyPayment);

  if MyPayment = 0 then
    begin
      MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
      edPayment.SetFocus;
      exit;
    end;

  if MyPayment > (MyTotInvoice - MyLayaway) then
    begin
      MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
      edPayment.SetFocus;
      Exit;
    end;

end;

procedure TFrmPaiPreSaleReceive.spHelpClick(Sender: TObject);
begin
   Application.HelpContext(1060);
end;

procedure TFrmPaiPreSaleReceive.edPaymentKeyPress(Sender: TObject;
  var Key: Char);
begin

 Key := ValidatePositiveCurrency(Key);

end;

procedure TFrmPaiPreSaleReceive.EditValue1KeyPress(Sender: TObject;
  var Key: Char);
begin

  Key := ValidatePositiveCurrency(Key);

end;

procedure TFrmPaiPreSaleReceive.FormCreate(Sender: TObject);
begin
  inherited;
  iSolicitacaoTEF := 0;

  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

  //Load Translation
  if (not fLangLoaded) and (siLang.StorageFile <> '') then
      begin
      if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
         siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
         MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);

      fLangLoaded := True;
      end;
  
  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sRefound   := '&Refund';
           sTotalRef  := 'Total Refund :';
           sReceive   := '&Receive';
           sTotalRec  := 'Cash Total :';
           sSetDateTo := 'Set Date to ';
           end;

     LANG_PORTUGUESE :
           begin
           sRefound   := '&Reembolso';
           sTotalRef  := 'Total :';
           sReceive   := '&Receber';
           sTotalRec  := 'Total :';
           sSetDateTo := 'Colocar data para ';
           end;

     LANG_SPANISH :
           begin
           sRefound   := '&Reembolso';
           sTotalRef  := 'Total :';
           sReceive   := '&Reciber';
           sTotalRec  := 'Total :';
           sSetDateTo := 'Colocar fecha para ';
           end;
   end;

end;

procedure TFrmPaiPreSaleReceive.spPayCheckClick(Sender: TObject);
begin
  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_CHECK);
  cmbPaymentTypeSelectItem(nil);
end;

procedure TFrmPaiPreSaleReceive.btnPartialPaymentClick(Sender: TObject);
begin
  inherited;

  if MyTotInvoice <= 0 then
     Exit;

  If FrmPayPartial = nil then
     FrmPayPartial := TFrmPayPartial.Create(Self);

  lbPartialInfo.Caption :=
    FrmPayPartial.Start(StrToInt(cmbPaymentType.LookUpValue),
                        MyIDCliente,
                        MyIDPreSale,
                        MyIDCashRegMov,
                        MyTotInvoice,
                        EditReceiveDate.Date,
                        EditAuthorization.Text,
                        0,
                        0);
end;

procedure TFrmPaiPreSaleReceive.btnPartialPayment2Click(Sender: TObject);
begin
  inherited;

  if StrToCurr(EditValue1.Text) <= 0 then
     Exit;

  If FrmPayPartial = nil then
     FrmPayPartial := TFrmPayPartial.Create(Self);

    lbPartialInfo2.Caption :=
    FrmPayPartial.Start(StrToInt(cmbPayType1.LookUpValue),
                        MyIDCliente,
                        MyIDPreSale,
                        MyIDCashRegMov,
                        StrToCurr(EditValue1.Text),
                        EditReceiveDate.Date,
                        EditAuto1.Text,
                        0,
                        0);

end;

procedure TFrmPaiPreSaleReceive.FormDestroy(Sender: TObject);
begin
  inherited;

  If FrmPayPartial <> nil then
     FreeAndNil(FrmPayPartial);

end;

function TFrmPaiPreSaleReceive.DeletePayment: Boolean;
begin
  Result := True;
  If (FrmPayPartial <> nil) Then
    if (FrmPayPartial.tvPartialPay.Items.Count > 0) Then
      with spPreSaleDeleteDelayPayment do
      begin
        Parameters.ParamByName('@PreSaleID').Value := MyIDPreSale;
        Parameters.ParamByName('@IDUser').Value    := DM.fUser.ID;
        ExecProc;
      end;
end;

end.
