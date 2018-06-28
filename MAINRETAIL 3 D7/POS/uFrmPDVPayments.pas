unit uFrmPDVPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, ComCtrls, ExtCtrls, siComp, siLangRT, uFormasPagamento,
  StdCtrls, uTEFTypes, uPreSale;

type
  TFrmPDVPayments = class(TFrmParentAll)
    pnlParent: TPanel;
    pnlOptions: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    pnlPayOption: TPanel;
    lbF2: TLabel;
    lbF3: TLabel;
    rbPayLater: TRadioButton;
    rbPayNow: TRadioButton;
    pnlKay1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Image2: TImage;
    Label2: TLabel;
    lvwPayType: TListView;
    pnlUsaCDC: TPanel;
    chcUsaCDC: TCheckBox;
    pnlTEFMagnetico: TPanel;
    rbMagnetico: TRadioButton;
    rbDigitado: TRadioButton;
    pnlTEFCredit: TPanel;
    chkPreAutorizacao: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvwPayTypeChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure chcUsaCDCClick(Sender: TObject);
    procedure chkPreAutorizacaoClick(Sender: TObject);
  private
    FPreSale         : TPreSale;
    bDisableControls : Boolean;
    bResult          : Boolean;
    bPostDate        : Boolean;
    MeioPagamento    : TMeioPagamento;
    cAmountToPay     : Currency;
    procedure RedrawList;
    function ValidateNonpayer : Boolean;
    function ValidatePayment : Boolean;
    function ValidateStoreAcc : Boolean;

  public
    { Public declarations }
    function Start(APreSale : TPreSale; AAmountToPay : Currency;
      var MP: TMeioPagamento; var ATEFCallInfo : TTEFCallInfo): Boolean;
  end;


implementation

uses uDMGlobal, uDMPDV, uSystemConst, uDM, uTEFConsts, uPassword, uMsgBox,
  uFrmStoreAccountBalance;

{$R *.dfm}

function TFrmPDVPayments.Start(APreSale : TPreSale; AAmountToPay : Currency;
  var MP: TMeioPagamento; var ATEFCallInfo : TTEFCallInfo): Boolean;
begin
  bResult                 := False;
  bPostDate               := False;
  MeioPagamento           := nil;
  lvwPayType.Tag          := 0;
  rbPayLater.Checked      := True;
  pnlPayOption.Visible    := False;
  pnlTEFMagnetico.Visible := False;
  pnlUsaCDC.Visible       := False;
  pnlTEFCredit.Visible    := False;
  chcUsaCDC.Checked       := False;
  FPreSale                := APreSale;
  cAmountToPay            := AAmountToPay;

  ShowModal;
  
  MP                             := MeioPagamento;
  ATEFCallInfo.IsMagnetico       := rbMagnetico.Checked;
  ATEFCallInfo.PostDate          := bPostDate;
  ATEFCallInfo.UsaCDC            := chcUsaCDC.Checked;
  ATEFCallInfo.UsaPreAutorizacao := chkPreAutorizacao.Checked;
  if MP <> nil then
  begin
    ATEFCallInfo.Bandeira        := DMPDV.GetBandeira(MP.IDMeioPag);
    ATEFCallInfo.TipoTEF         := DMPDV.GetTipoTEF(MP.IDMeioPag);
  end;
  Result                         := bResult;
end;

procedure TFrmPDVPayments.RedrawList;
var
  TP: TTipoPagamento;
  I: Integer;
begin

  try
    bDisableControls := True;
    case lvwPayType.Tag of
      0:
        begin
          lvwPayType.Items.Clear;
          lvwPayType.Items.BeginUpdate;
          try

            for I := 0 to DMPDV.FormasPagamento.Count - 1 do
            begin
              with lvwPayType.Items.Add do
              begin
                Caption := DMPDV.FormasPagamento.TiposPagamento[I].Descricao;
                Data    := DMPDV.FormasPagamento.TiposPagamento[I];
              end;
            end;
          finally
            lvwPayType.Items.EndUpdate;
          end;
        end;
      1:
        begin
          TP := TTipoPagamento(lvwPayType.Selected.Data);
          lvwPayType.Items.Clear;
          lvwPayType.Items.BeginUpdate;
          pnlPayOption.Visible := (TP.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT]);

          pnlUsaCDC.Visible := ((TP.Tipo = PAYMENT_TYPE_DEBIT) and (DM.fCashRegister.UseTef = TEF_DEDICADO));
          pnlTEFCredit.Visible := ((TP.Tipo in [PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CARD]) and (DM.fCashRegister.UseTef = TEF_DEDICADO));
          pnlTEFMagnetico.Visible := ((TP.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) AND (DM.fCashRegister.UseTef = TEF_DEDICADO));
          if pnlTEFMagnetico.Visible then
            rbMagnetico.Checked := True;
          try

            for I := 0 to TP.Count - 1 do
            begin
              with lvwPayType.Items.Add do
              begin
                Caption := TP.MeiosPagamento[I].MeioPag;
                Data    := TP.MeiosPagamento[I];
              end;

            end;
          finally
            lvwPayType.Items.EndUpdate;
          end;
        end;
    end;

    if lvwPayType.Items.Count > 0 then
       lvwPayType.Selected := lvwPayType.Items[0];
  finally
    bDisableControls := False;
    end;
    
end;

procedure TFrmPDVPayments.FormShow(Sender: TObject);
begin
  inherited;
  RedrawList;
  KeyPreview := True;
end;

procedure TFrmPDVPayments.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if (lvwPayType.Tag = 0) then
          begin
            if TTipoPagamento(lvwPayType.Selected.Data).Count = 1 then
              begin
                MeioPagamento := TTipoPagamento(lvwPayType.Selected.Data).MeiosPagamento[0];
                if not ValidatePayment then
                  Exit;
                bPostDate :=
                  (MeioPagamento.TipoPagamento.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT])
                  and (pnlPayOption.Visible and rbPayLater.Checked);
                bResult := True;
                Close;
              end
            else
              begin
                lvwPayType.Tag := 1;
                RedrawList;
              end;
          end
        else
          begin
            MeioPagamento := TMeioPagamento(lvwPayType.Selected.Data);
            if not ValidatePayment then
               Exit;
            bPostDate :=
              (MeioPagamento.TipoPagamento.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT])
              and (pnlPayOption.Visible and rbPayLater.Checked);
            bResult := True;
            Close;
          end;
      end;
    VK_ESCAPE:
      begin
        if (lvwPayType.Tag = 0) then
          begin
            MeioPagamento := nil;
            bResult       := False;
            Close;
          end
        else
          begin
            lvwPayType.Tag := 0;
            pnlPayOption.Visible    := False;
            pnlTEFMagnetico.Visible := False;
            pnlUsaCDC.Visible       := False;
            pnlTEFCredit.Visible    := False;
            RedrawList;
          end;
      end;
    VK_F1 : begin
              Application.HelpContext(170);
            end;
    VK_F2 : begin
            if pnlPayOption.Visible then
               rbPayNow.Checked := True;
            end;
    VK_F3 : begin
            if pnlPayOption.Visible then
               rbPayLater.Checked := True;
            end;
    VK_F4: begin
             if pnlTEFMagnetico.Visible then
               rbMagnetico.Checked := True;
           end;
    VK_F5: begin
             if pnlTEFMagnetico.Visible then
               rbDigitado.Checked := True;
           end;
    VK_F6: begin
             if pnlUsaCDC.Visible then
               chcUsaCDC.Checked := not chcUsaCDC.Checked;
             chkPreAutorizacao.Checked := False;
           end;
    VK_F7: begin
            if pnlTEFCredit.Visible then
              chkPreAutorizacao.Checked := not chkPreAutorizacao.Checked;
            chcUsaCDC.Checked := False;
          end;

  end;
end;

procedure TFrmPDVPayments.lvwPayTypeChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  ATipoPagamento: TTipoPagamento;
begin
  inherited;
  ATipoPagamento := TTipoPagamento(Item.Data);

  if (not bDisableControls) and (lvwPayType.Tag = 0) then
  begin
     pnlPayOption.Visible := ((ATipoPagamento.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT]) and
                             (ATipoPagamento.Count = 1));
     rbPayNow.Checked   := ATipoPagamento.Tipo <> PAYMENT_TYPE_CHECK;
     rbPayLater.Checked := ATipoPagamento.Tipo = PAYMENT_TYPE_CHECK;

     pnlUsaCDC.Visible := ((ATipoPagamento.Tipo = PAYMENT_TYPE_DEBIT)
                          and (DM.fCashRegister.UseTef = TEF_DEDICADO) and (ATipoPagamento.Count = 1));

     pnlTEFCredit.Visible := ((ATipoPagamento.Tipo in [PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CARD])
                          and (DM.fCashRegister.UseTef = TEF_DEDICADO) and (ATipoPagamento.Count = 1));

     pnlTEFMagnetico.Visible := ((ATipoPagamento.Tipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT])
                                and (DM.fCashRegister.UseTef = TEF_DEDICADO) and (ATipoPagamento.Count = 1));
     if pnlTEFMagnetico.Visible then
       rbMagnetico.Checked := True;
  end;
                             
end;

procedure TFrmPDVPayments.chcUsaCDCClick(Sender: TObject);
begin
  inherited;
  chkPreAutorizacao.Checked := False;
end;

procedure TFrmPDVPayments.chkPreAutorizacaoClick(Sender: TObject);
begin
  inherited;
  chcUsaCDC.Checked := false;
end;

function TFrmPDVPayments.ValidateNonpayer: Boolean;
begin

  if not Password.HasFuncRight(90) then
    if MeioPagamento.ValidateNonpayer then
    begin
      if (FPreSale.PreSaleInfo.CustomerInfo <> nil) and (FPreSale.PreSaleInfo.CustomerInfo.IDCustomer <= 1) then
      begin
        MsgBox('Esta forma de pagamento requer um cliente!', vbInformation + vbOkOnly);
        Result := False;
        Exit;
      end;

      if FPreSale.PreSaleInfo.CustomerInfo.Nonpayer then
      begin
        MsgBox('Cliente não pode pagar com essa forma de pagamento._Verificar com a administração da loja.', vbSuperCritical + vbOkOnly);
        Result := False;
        Exit;
      end;
    end;

  Result := True;

end;

function TFrmPDVPayments.ValidatePayment: Boolean;
begin
  //Validar Cliente Inadimplente
  Result := ValidateNonpayer;

  //Validar Venda Fiada
  if Result then
    Result := ValidateStoreAcc;
    
end;

function TFrmPDVPayments.ValidateStoreAcc: Boolean;
begin

  Result := True;

  if not Password.HasFuncRight(89) then
    if (MeioPagamento.TipoPagamento.Tipo = PAYMENT_TYPE_STOREACCOUNT) then
    begin
      if (FPreSale.PreSaleInfo.CustomerInfo <> nil) and (FPreSale.PreSaleInfo.CustomerInfo.IDCustomer <= 1) then
      begin
        MsgBox('Esta forma de pagamento requer um cliente!', vbInformation + vbOkOnly);
        Result := False;
        Exit;
      end;

      with TFrmStoreAccountBalance.Create(Self) do
        Result := Start(FPreSale.PreSaleInfo.CustomerInfo.IDCustomer, cAmountToPay);

    end;

end;

end.
