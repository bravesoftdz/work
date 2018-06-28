unit uPayments;

interface

uses Classes, SysUtils, uTefDial, uTEFDedicado, uSystemConst, uMsgBox,
     uTefConsts, uTEFTypes, uTEFDedicadoInterface;


type
  TPayment = class;

  TPartialPay = class;

  TPartialPayEvent = procedure(Payment: TPayment; Lista: TList; var Sucess: Boolean) of object;

  TPayments = class(TComponent)
    private
      FItems: TList;
      FTEFDial: TTEFDial;
      FCOO: String;

      FInvoiceTotal:      Currency;
      FCashTotal:         Currency;
      FCashReceivedTotal: Currency;
      FChangeTotal:       Currency;
      FBalanceTotal:      Currency;
      FOnPartialPay: TPartialPayEvent;
      FIsRefund: Boolean;
      FTEFDedicado: TTEFDedicado;
      FTEFType: Integer;
      FTEFDedicadoInterface: TTEFDedicadoInterface;

      function ConfirmLastTEFs: Boolean;
      function GetItems(Index: Integer): TPayment;
      procedure SetItems(Index: Integer; const Value: TPayment);
      procedure InitValues;
      procedure UpdateValues;
      procedure SetInvoiceTotal(const Value: Currency);
      function GetCount: Integer;
      procedure RemovePayment(Index: Integer);
      function ParcelaDefault(AAutorization: String; AValue: Currency): TPartialPay;
      function CountPaymentsByType(iTipo: Integer): Integer;
      function HaveTEF: Boolean;
      function TefDedicadoRestricoes(Payment: TPayment): String;

    public
      property COO:                   String   read FCOO               write FCOO;
      property Count:                 Integer  read GetCount;

      property Items[Index: Integer]: TPayment read GetItems           write SetItems;


      property InvoiceTotal:          Currency   read FInvoiceTotal      write SetInvoiceTotal;
      property CashTotal:             Currency   read FCashTotal;
      property CashReceivedTotal:     Currency   read FCashReceivedTotal write FCashReceivedTotal;
      property ChangeTotal:           Currency   read FChangeTotal;
      property BalanceTotal:          Currency   read FBalanceTotal;
      property IsRefund:              Boolean    read FIsRefund          write FIsRefund;


      constructor Create(AOwner: TComponent);override;
      destructor Destroy;override;

      function Add(const Value: TPayment): Integer;

      function AddPayment(AIDMeioPag, ATipo: Integer; ACodFiscal,
                          ADescFiscal: String; AAmount: Currency;
                          ATEFCallInfo : TTEFCallInfo;
                          APaymentPlace: Integer = 0) : Boolean;

      procedure Clear;

      procedure Delete(Index: Integer);

      function GetPaymentsAmount(ATipo: Integer = -1): Currency;

      function LastPayment: TPayment;

      function Reset: Boolean;
    published
      property TEFDial:               TTEFDial         read FTEFDial           write FTEFDial;
      property TEFDedicado:           TTEFDedicado     read FTEFDedicado       write FTEFDedicado;
      property TEFDedicadoInterface:  TTEFDedicadoInterface     read FTEFDedicadoInterface       write FTEFDedicadoInterface;
      property TEFType:               Integer          read FTEFType           write FTEFType;
      property OnPartialPay:          TPartialPayEvent read FOnPartialPay      write FOnPartialPay;
  end;

  TTEFInfo = class
    private
      FNSU:            String;
      FAutorization:   String;
      FNomeRede:       String;
      FValorTotal:     Currency;
      FDataTransacao:  String;
      FHoraTransacao:  String;
      FConfirmed:      Boolean;
      FIDPreSale:      Integer;
    public
      property Autorization:   String    read FAutorization  write FAutorization;
      property NSU:            String    read FNSU           write FNSU;
      property NomeRede:       String    read FNomeRede      write FNomeRede;
      property ValorTotal:     Currency  read FValorTotal    write FValorTotal;
      property DataTransacao:  String    read FDataTransacao write FDataTransacao;
      property HoraTransacao:  String    read FHoraTransacao write FHoraTransacao;
      property Confirmed:      Boolean   read FConfirmed     write FConfirmed;
      property IDPreSale:      Integer   read FIDPreSale     write FIDPreSale;
  end;

  TPayment = class
    private
      FIDMeioPag:      Integer;
      FAmount:         Currency;
      FTipo:           Integer;
      FIDLancamento:   Integer;
      FTEFInfo:        TTEFInfo;
      FCodFiscal:      String;
      FDescFiscal:     String;
      FPartialPay: Boolean;
      FPaymentPlace: Integer;
      FItems: TList;
      FTEFCartaoMagnetico : Boolean;
      FTEFTipoParcelamento : Integer;
      FTEFPreDatada : TDateTime;
      FTEFPreDatadaComGarantia : Boolean;
      FTEFUsaCDC : Boolean;
      FTEFConsultaPreAuto : Boolean;
      FTEFBandeira: Integer;
      FTipoTEF: Integer;
      FIDPreSale: Integer;
      function GetItems(Index: Integer): TPartialPay;
      procedure SetItems(Index: Integer; const Value: TPartialPay);
    function GetCount: Integer;
    procedure SetIDPreSale(const Value: Integer);
    public
      constructor Create;
      destructor Destroy; override;

      property IDMeioPag:    Integer              read FIDMeioPag           write FIDMeioPag;
      property Amount:       Currency             read FAmount              write FAmount;
      property Tipo:         Integer              read FTipo                write FTipo;
      property IDLancamento: Integer              read FIDLancamento        write FIDLancamento;
      property TEFInfo:      TTEFInfo             read FTEFInfo             write FTEFInfo;
      property CodFiscal:    String               read FCodFiscal           write FCodFiscal;
      property DescFiscal:   String               read FDescFiscal          write FDescFiscal;
      property PaymentPlace: Integer              read FPaymentPlace        write FPaymentPlace default -1;
      property PartialPay:   Boolean              read FPartialPay          write FPartialPay;
      property Items[Index: Integer]: TPartialPay read GetItems             write SetItems;
      property TEFCartaoMagnetico : Boolean       read FTEFCartaoMagnetico  write FTEFCartaoMagnetico;
      property TEFTipoParcelamento : Integer      read FTEFTipoParcelamento write FTEFTipoParcelamento;
      property TEFPreDatada : TDateTime           read FTEFPreDatada        write FTEFPreDatada;
      property TEFPreDatadaComGarantia : Boolean  read FTEFPreDatadaComGarantia write FTEFPreDatadaComGarantia;
      property TEFUsaCDC : Boolean                read FTEFUsaCDC           write FTEFUsaCDC;
      property TEFConsultaPreAuto : Boolean       read FTEFConsultaPreAuto  write FTEFConsultaPreAuto;
      property TEFBandeira : Integer              read FTEFBandeira         write FTEFBandeira;
      property TipoTEF : Integer                  read FTipoTEF             write FTipoTEF;
      property Count:        Integer              read GetCount;
      property IDPreSale: Integer                 read FIDPreSale           write SetIDPreSale;

      function Add(const Value: TPartialPay): Integer;

  end;

  TPartialPay = class
  private
    FValue:        Currency;
    FIDBanco:      Integer;
    FNumeroDoc:    String;
    FTelefone:     String;
    FParcela:      String;
    FOBS:          String;
    FAutorization: String;
    FNomeCliente:  String;
    FDocCliente:   String;
    FBanco:        String;
    FExpireDate:   TDateTime;
  public
    property Autorization: String    read FAutorization  write FAutorization;
    property NomeCliente:  String    read FNomeCliente   write FNomeCliente;
    property Telefone:     String    read FTelefone      write FTelefone;
    property DocCliente:   String    read FDocCliente    write FDocCliente;
    property IDBanco:      Integer   read FIDBanco       write FIDBanco;
    property NumeroDoc:    String    read FNumeroDoc     write FNumeroDoc;
    property OBS:          String    read FOBS           write FOBS;
    property ExpireDate:   TDateTime read FExpireDate    write FExpireDate;
    property Parcela:      String    read FParcela       write FParcela;
    property Value:        Currency  read FValue         write FValue;
    property Banco:        String    read FBanco         write FBanco;
  end;

  procedure Register;

implementation

{ TPayments }

function TPayments.Add(const Value: TPayment): Integer;
begin
  Result := FItems.Add(Value);
  UpdateValues;
end;

function TPayments.ConfirmLastTEFs: Boolean;
var
  I : Integer;
  ATEFInfo: TTEFInfo;
begin
  Result := True;

  for I := 0 to FItems.Count - 1 do
  begin
    ATEFInfo := GetItems(I).FTEFInfo;
    if ATEFInfo <> nil then
      if not ATEFInfo.Confirmed then
      begin
        case FTEFType of
          TEF_NONE:;
          TEF_DIAL:
            begin
              FTEFDial.CupomVinculado := FCOO;
              FTEFDial.NSU            := ATEFInfo.NSU;
              FTEFDial.NomeRede       := ATEFInfo.NomeRede;
              FTEFDial.ValorTotal     := ATEFInfo.ValorTotal;

              ATEFInfo.Confirmed      := FTEFDial.ConfirmacaoSimples;

              Result                  := Result and ATEFInfo.Confirmed;
            end;
          TEF_DEDICADO:
            begin
              ATEFInfo.Confirmed := True;
            end;
        end;

        if not Result then
          Break;
      end;
  end;
end;

constructor TPayments.Create(AOwner: TComponent);
begin
  if not (csDesigning in ComponentState) then
    FItems := TList.Create;
  //FCanDoTEF := True;
  InitValues;
  inherited Create(AOwner);
end;

procedure TPayments.Delete(Index: Integer);
begin
  RemovePayment(Index);
  FItems.Delete(Index);
  UpdateValues;
end;

procedure TPayments.RemovePayment(Index: Integer);
var
  TEFInfo: TTEFInfo;
  Payment: TPayment;
begin
  if FItems[Index] = nil then
    Exit;
  if TPayment(FItems[Index]).TEFInfo <> nil then
  begin
    TEFInfo := TPayment(FItems[Index]).TEFInfo;
    FreeAndNil(TEFInfo);
  end;
  Payment := TPayment(FItems[Index]);
  FreeAndNil(Payment);
end;

destructor TPayments.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    while FItems.Count > 0 do
      RemovePayment(0);
    FItems.Free;
  end;
  inherited Destroy;
end;

function TPayments.GetItems(Index: Integer): TPayment;
begin
  Result := FItems[Index];
end;

function TPayments.GetPaymentsAmount(ATipo: Integer): Currency;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    with GetItems(I) do
      if (ATipo = -1) or (ATipo = Tipo) then
        Result := Result + Amount;
end;

procedure TPayments.InitValues;
begin
  FInvoiceTotal      := 0;
  FCashTotal         := 0;
  FCashReceivedTotal := 0;
  FChangeTotal       := 0;
  FBalanceTotal      := 0;
end;

procedure TPayments.UpdateValues;
var
  Pagamentos: Currency;
begin
  Pagamentos := GetPaymentsAmount;
  FBalanceTotal    := FInvoiceTotal - Pagamentos;

  FCashTotal    := GetPaymentsAmount(1{PAYMENT_TYPE_CASH});

  if FCashReceivedTotal < FCashTotal then
    FCashReceivedTotal := FCashTotal;
  {
  if (FInvoiceTotal - Pagamentos) < 0 then
    FChangeTotal := ABS((FInvoiceTotal - Pagamentos))
  else
    FChangeTotal := 0;}
end;

procedure TPayments.SetItems(Index: Integer; const Value: TPayment);
begin
  FItems[Index] := Value;
  UpdateValues;
end;

function TPayments.Reset: Boolean;
begin

  Result := True;

  try

    if HaveTEF then
    repeat
      Result := TEFDial.ResolvePendencias;
    until Result;

  finally
    Clear;
    InitValues;
  end;
  
end;

function TPayments.HaveTEF: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FItems.Count - 1 do
  begin
    if TPayment(FItems[I]).FTEFInfo <> nil then
    begin
      Result := True;
      Break;
    end;
  end;

end;



procedure TPayments.Clear;
begin
  while FItems.Count > 0 do
    Delete(0);
end;

procedure TPayments.SetInvoiceTotal(const Value: Currency);
begin
  FInvoiceTotal := Value;
  UpdateValues;
end;

function TPayments.LastPayment: TPayment;
begin
  Result := nil;
  if FItems.Count > 0 then
    Result := TPayment(FItems[FItems.Count - 1]);
end;

function TPayments.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TPayments.AddPayment(AIDMeioPag, ATipo: Integer; ACodFiscal,
  ADescFiscal: String; AAmount: Currency; ATEFCallInfo : TTEFCallInfo;
  APaymentPlace: Integer): Boolean;
var
  Payment: TPayment;
  ATEFInfo: TTEFInfo;
  CanAdd: Boolean;
  Valor, Troco: Currency;
  PartialList: TList;
  FezParcial: Boolean;
  AAutorization: String;
  I : Integer;
  NumeroCartoes: Integer;
  VinculadoInfo: TVinculadoInfo;
  APartialPay : Boolean;
begin
  Troco := 0;
  AAutorization := '000';
  Result   := False;
  CanAdd   := True;
  ATEFInfo := nil;
  Valor    := AAmount;

  NumeroCartoes := CountPaymentsByType(PAYMENT_TYPE_CARD) + CountPaymentsByType(PAYMENT_TYPE_DEBIT);

  // Trata o Troco
  if ((Valor > FBalanceTotal) and not IsRefund) or
     ((Valor <> FBalanceTotal) and IsRefund) then
  begin
    Troco := Valor - FBalanceTotal;
    Valor := FBalanceTotal;
  end;

  // Criacao do Pagamento
  Payment := TPayment.Create;
  with Payment do
  begin
    IDMeioPag          := AIDMeioPag;
    Amount             := Valor;
    Tipo               := ATipo;
    CodFiscal          := ACodFiscal;
    DescFiscal         := ADescFiscal;
    PaymentPlace       := APaymentPlace;
    if ATEFCallInfo <> nil then
    begin
      PartialPay          := ATEFCallInfo.PostDate;
      TEFCartaoMagnetico  := ATEFCallInfo.IsMagnetico;
      TEFUsaCDC           := ATEFCallInfo.UsaCDC;
      TEFConsultaPreAuto  := ATEFCallInfo.UsaPreAutorizacao;
      TEFBandeira         := ATEFCallInfo.Bandeira;
      TipoTEF             := ATEFCallInfo.TipoTEF;
      //FTEFType            := ATEFCallInfo.TipoTEF;
    end
    else
    begin
      PartialPay         := False;
      (*
       HOMOLOGACAO - Setar para FTEFType zero caso não seja TEF
      *)
      //FTEFType            := TEF_NONE;
    end;
  end;

  APartialPay := Payment.PartialPay;

  // Lista de parcelas para o evento
  PartialList := TList.Create;
  FezParcial  := False;
  try
    // Trata TEF
    if (FTEFType <> TEF_NONE) and (ATEFCallInfo <> nil) then
      begin

        (*
          HOMOLOGAÇÂO DO TEF - DISCADO - 4 CARTÕES
        *)

        if (ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) and (NumeroCartoes > 2) and (Valor < FBalanceTotal) then
        begin
          MsgBox('O valor do pagamento do segundo cartão deve completar o valor da nota..', vbCritical + vbOKOnly);
          if Payment <> nil then
            FreeAndNil(Payment);
          Exit;
        end;

        if (not (ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT])) and (NumeroCartoes > 0) and (FTEFType = TEF_DIAL) then
        begin
          MsgBox('As próximas formas de pagamento para esta venda deverão ser em CARTÃO DE CRÉDITO OU DÉBITO.', vbCritical+vbOKOnly);
          if Payment <> nil then
            FreeAndNil(Payment);
          Exit;
        end;

        (*TEF Dedicado
           Temos que preencher os dados antes de enviar para o TEF Dedicado. No caso
           do TEF Discado, essa opção e inversa ou seja o resultado vem do aplicativo do TEF
        *)
        if APartialPay then
          if ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK]) and ((FTEFType = TEF_DEDICADO))) then
            if Assigned(FOnPartialPay) then
            begin
              // Chamada do Evento se for TEF Dedicado
              FOnPartialPay(Payment, PartialList, FezParcial);
              if not FezParcial then
                Exit;
            end;

        if ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) AND ((FTEFType <> TEF_NONE) )) then
        //if ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK]) AND ((FTEFType <> TEF_NONE) )) then
        //if ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT]) or ((FTEFType = TEF_DEDICADO) )) then
        begin
          ConfirmLastTEFs;

          case FTEFType of
            TEF_DIAL:
              begin
                FTEFDial.CupomVinculado := Trim(FCOO);
                FTEFDial.FormaPagamento := ADescFiscal;
                FTEFDial.ValorTotal     := AAmount;
                FTEFDial.IDMeioPag      := AIDMeioPag;
                FTEFDial.TEFDIALType    := Payment.TipoTEF;
                if ATipo = PAYMENT_TYPE_CHECK then
                  CanAdd := FTEFDial.VendaCheque
                else
                  CanAdd := FTEFDial.VendaCartao;
              end;
            TEF_DEDICADO:
              begin
                // Aqui entra a merda do código do tef dedicado
                VinculadoInfo := TVinculadoInfo.Create;

                VinculadoInfo.CupomVinculado       := Trim(FCOO);
                VinculadoInfo.FormaPagamento       := ADescFiscal;
                VinculadoInfo.ValorAprovado        := AAmount;
                VinculadoInfo.IDMeioPag            := AIDMeioPag;
                VinculadoInfo.NumeroParcelas       := PartialList.Count;
                VinculadoInfo.PreDatado            := Payment.TEFPreDatada;
                VinculadoInfo.PreDatadoComGarantia := Payment.TEFPreDatadaComGarantia;

                CanAdd := FTEFDedicado.FazTransacao(FUNCAO_PAGAMENTO,
                                                    AAmount,
                                                    Trim(FCOO),
                                                    Now,
                                                    '',
                                                    TefDedicadoRestricoes(Payment),
                                                    '',
                                                    VinculadoInfo,
                                                    FTEFDedicadoInterface) = 0;
              end;

        end;

        if CanAdd then
        case FTEFType of
          TEF_DIAL:
            begin
              Valor   := FTEFDial.ValorAprovado;
              ATEFInfo := TTEFInfo.Create;
              with ATEFInfo do
              begin
                COO            := FCOO;
                NSU            := FTEFDial.NSU;
                Autorization   := FTEFDial.Autorizacao;
                NomeRede       := FTEFDial.NomeRede;
                ValorTotal     := FTEFDial.ValorTotal;
                DataTransacao  := FTEFDial.DataTransacao;
                HoraTransacao  := FTEFDial.HoraTransacao;
                Confirmed      := False;

                AAutorization  := Autorization;
              end;
            end;
          TEF_DEDICADO:
            begin
              ATEFInfo := TTEFInfo.Create;
              with ATEFInfo do
              begin
                COO       := FCOO;
                Confirmed := False;
               end;
            end;
        end;
      end;
     end;

    if CanAdd then
    begin
      Payment.TEFInfo := ATEFInfo;

      // Vai Parcelar
      if APartialPay then
        begin
          // Evento de Parcelamento
          if Assigned(FOnPartialPay) then
          begin
            try
              // Chamada do Evento se for TEF Discado ou none
              if ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT]) and (FTEFType <> TEF_DEDICADO)) then
                FOnPartialPay(Payment, PartialList, FezParcial);
              // Parcelou ?
              if (FezParcial) and (PartialList.Count <> 0) then
                begin
                  // Sim, adiciona cada parcela
                  for I := 0 to PartialList.Count - 1 do
                    Payment.Add(TPartialPay(PartialList[I]))
                end
              // Nao
              else
                begin
                  // Fez TEF ?
                  if (FTEFType <> TEF_NONE) and ((ATipo in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_STOREACCOUNT]) or ((FTEFType = TEF_DEDICADO) )) then
                    // Sim, Adiciona uma parcela
                    Payment.Add(ParcelaDefault(AAutorization, Valor))
                  else
                    // Nao. Rejeita pagamento
                    FreeAndNil(Payment);
                end;
            finally
            end;
          end;
        end
      else
        Payment.Add(ParcelaDefault(AAutorization, Valor));

      Result := Payment <> nil;
      if Result then
      begin
        FChangeTotal := FChangeTotal + Troco;
        Add(Payment);
      end;
    end;
  finally
    FreeAndNil(PartialList);
    end;
end;

function TPayments.ParcelaDefault(AAutorization: String; AValue: Currency): TPartialPay;
begin
  Result := TPartialPay.Create;
  with Result do
  begin
    ExpireDate   := NOW;
    Autorization := AAutorization;
    Value        := AValue;
    Parcela      := '1/1';
  end;
end;


function TPayments.CountPaymentsByType(iTipo: Integer): Integer;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    if TPayment(FItems[I]).Tipo = iTipo then
      Inc(result);
end;

function TPayments.TefDedicadoRestricoes(Payment: TPayment): String;
var
  RestrictionSet, OutOfRestrictionSet: set of Byte;
  i: Byte;
begin
  OutOfRestrictionSet := [];

  if Payment.TEFBandeira = TEF_BANDEIRA_FININVEST then
  begin
    OutOfRestrictionSet := [TEF_BANDEIRA_FININVEST];
  end
  else
    case Payment.Tipo of
      PAYMENT_TYPE_CARD: begin
                           if Payment.PartialPay then
                           begin
                             if Payment.TEFTipoParcelamento = TEF_PARCELAMENTO_LOJA then
                               OutOfRestrictionSet := [25,27]
                             else if Payment.TEFTipoParcelamento = TEF_PARCELAMENTO_ADM then
                               OutOfRestrictionSet := [25,28];
                           end
                           else
                             OutOfRestrictionSet := [25,26];

                           if Payment.TEFCartaoMagnetico then
                             OutOfRestrictionSet := OutOfRestrictionSet + [30]
                           else
                             OutOfRestrictionSet := OutOfRestrictionSet + [29];
                         end;
      PAYMENT_TYPE_DEBIT: begin
                            if Payment.PartialPay then
                            begin
                              if Payment.TEFTipoParcelamento = TEF_PARCELAMENTO_LOJA then
                                OutOfRestrictionSet := [15,17]
                              else if Payment.TEFTipoParcelamento = TEF_PARCELAMENTO_ADM then
                                OutOfRestrictionSet := [15,18];
                            end
                            else
                            begin
                              OutOfRestrictionSet := [15];

                              if not Payment.TEFUsaCDC then
                                OutOfRestrictionSet := OutOfRestrictionSet + [16] //A Vista
                              else
                                OutOfRestrictionSet := OutOfRestrictionSet + [19]; //Opcao de CDC
                            end;

                           if Payment.TEFCartaoMagnetico then
                             OutOfRestrictionSet := OutOfRestrictionSet + [43]
                           else
                             OutOfRestrictionSet := OutOfRestrictionSet + [42];

                          end;
      PAYMENT_TYPE_CHECK: OutOfRestrictionSet := [10..14];
    end;

  if Payment.TEFConsultaPreAuto then
    OutOfRestrictionSet := OutOfRestrictionSet + [31];

  RestrictionSet := TEF_PAYMENTS - OutOfRestrictionSet;

  for I := 0 to High(Byte) do
  begin
    if I in RestrictionSet then
      Result := Result + IntToStr(I) + ';';
  end;

  //Result := '[' + Result + '];';
  Result := '';
end;

{ TPayment }

function TPayment.Add(const Value: TPartialPay): Integer;
begin
  Result := FItems.Add(Value);
end;

constructor TPayment.Create;
begin
  inherited Create;
  FItems := TList.Create;
  FTEFInfo := nil;
  FPaymentPlace := -1;
  FTEFTipoParcelamento := TEF_PARCELAMENTO_LOJA;
  FTEFCartaoMagnetico := True;
end;

destructor TPayment.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TPayments]);
end;

function TPayment.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TPayment.GetItems(Index: Integer): TPartialPay;
begin
  Result := FItems[Index];
end;

procedure TPayment.SetIDPreSale(const Value: Integer);
begin
  FIDPreSale := Value;
  if Assigned(FTEFInfo) then
    FTEFInfo.FIDPreSale := Value;
end;

procedure TPayment.SetItems(Index: Integer; const Value: TPartialPay);
begin
  FItems[Index] := Value;
end;

end.
