unit uInvoicePollDisplay;

interface

uses
  SysUtils, Classes, IniFiles, ShellAPI, Windows, Dialogs, IdTCPConnection,
  IdTCPClient, uInvoicePollDisplayConst;

type
  TInvoiceComponentType = (ictInvoice, ictPayment, ictItem, ictFinalization);

  TMRPDSHeaderType = (pdsAdvertising, pdsCrossSaleItem ,pdsCrossSaleItemHistory);

  TMRPDSHeader = record
    ByteCount: Int64;
    BodyType: TMRPDSHeaderType;
  end;

  TInvoiceStreamHeader = record
    ByteCount: Int64;
    InvoiceComponentType: TInvoiceComponentType;
    ComponentCount: Integer;
  end;

  TInvoiceItems = class(TComponent)
  private
    FID : Integer;
    FIDModel : Integer;
    FModel : String;
    FDescription : String;
    FQty : Double;
    FSalePrice : Currency;
    FDiscount : Currency;
  published
    property ID: Integer read FID write FID;
    property IDModel: Integer read FIDModel write FIDModel;
    property Model: String read FModel write FModel;
    property Description: String read FDescription write FDescription;
    property Qty: Double read FQty write FQty;
    property SalePrice: Currency read FSalePrice write FSalePrice;
    property Discount: Currency read FDiscount write FDiscount;
  end;

  TInvoicePayment = class(TComponent)
  private
    FID: Integer;
    FPayment: String;
    FAmount: Currency;
  published
    property ID: Integer read FID write FID;
    property Payment: String read FPayment write FPayment;
    property Amount: Currency read FAmount write FAmount;

  end;

  TInvoiceInfo = class(TComponent)
    private
      FSaleCode: String;
      FSaleDate: TDatetime;
      FAddCostTotal: Currency;
      FDiscountTotal: Currency;
      FTaxTotal: Currency;
      FSubTotal: Currency;
      FPayments: TStringList;
      FItems: TStringList;
    public
    published
      property Items: TStringList read FItems write FItems;


      property SaleCode : String read FSaleCode write FSaleCode;
      property SaleDate : TDatetime read FSaleDate write FSaleDate;
      property AddCostTotal : Currency read FAddCostTotal write FAddCostTotal;
      property DiscountTotal : Currency read FDiscountTotal write FDiscountTotal;
      property SubTotal : Currency read FSubTotal write FSubTotal;
      property TaxTotal : Currency read FTaxTotal write FTaxTotal;
      property Payments: TStringList read FPayments write FPayments;

      procedure FreeInvoiceItems;
      procedure FreePayments;

      function DeleteItem(AID : Integer) : Boolean;
      function DeletePayment(AID : Integer) : Boolean;
      procedure ClearSale;

      constructor Create(AOwner: TComponent);override;
      destructor Destroy; override;
  end;

  TInvoice = class
    private
      IdTCPClient: TIdTCPClient;
      FInvoiceInfo: TInvoiceInfo;
      FServerPort: Integer;
      FServerIP: String;
      function CallPollDisplay : Boolean;
      function BuildImput(Campo, Valor : String): String;
      //procedure SendStringToServer(Text : String);
    public
      constructor Create;
      destructor Destroy; override;

      function AddItem(AID, AIDModel : Integer; AModel, ADescription : String; AQty : Double;
                       ASalePrice, ADiscount : Currency) : Boolean;
      function InvoiceInfo(ASaleCode: String; ASaleDate: TDatetime; AAddCostTotal,
                      ADiscountTotal, ATaxTotal, ASubTotal: Currency; UpdateFile : Boolean = False) : Boolean;
      function AddPayment(AID : Integer; APayment : String; AAMount : Currency) : Boolean;
      procedure CloseSale(ARefreshReceipt : Boolean = True);

      procedure SetServerInfo(AServerIP : String; AServerPort : Integer);
      function ConnectPole : Boolean;
      function ConnectedPole : Boolean;

      function DeletePayment(AID: Integer; UpdateFile: Boolean): Boolean;
      function DeleteItem(AID: Integer; UpdateFile: Boolean): Boolean;


  end;

implementation

uses IdComponent;

{ TInvoice }

function TInvoice.AddItem(AID, AIDModel: Integer; AModel,
  ADescription: String; AQty: Double; ASalePrice,
  ADiscount: Currency): Boolean;
var
  AInvoiceItems : TInvoiceItems;
begin

  AInvoiceItems := TInvoiceItems.Create(nil);
  with AInvoiceItems do
  begin
    ID := AID;
    IDModel := AIDModel;
    Model := AModel;
    Description := ADescription;
    Qty := AQty;
    SalePrice := ASalePrice;
    Discount := ADiscount;
  end;
  FInvoiceInfo.FItems.AddObject(IntToStr(AID), AInvoiceItems);

  Result := CallPollDisplay;

end;

function TInvoice.AddPayment(AID: Integer; APayment: String;
  AAMount: Currency): Boolean;
var
  APaymentList : TInvoicePayment;
  idx : Integer;
begin

  idx := FInvoiceInfo.FPayments.IndexOf(IntToStr(AID));
  if idx = -1 then
  begin
    APaymentList := TInvoicePayment.Create(nil);
    with APaymentList do
    begin
      FID := AID;
      FPayment := APayment;
      FAMount := AAMount;
    end;
    FInvoiceInfo.FPayments.AddObject(IntToStr(AID), APaymentList);
  end
  else
  begin
    APaymentList := TInvoicePayment(FInvoiceInfo.FPayments.Objects[idx]);
    APaymentList.FAmount := APaymentList.FAmount + AAMount;
    FInvoiceInfo.FPayments.Objects[idx] := APaymentList;
  end;


  Result := CallPollDisplay;

end;

function TInvoice.BuildImput(Campo, Valor : String): String;
begin
  Result := Campo + '=' + Valor + ';';
end;

{
procedure TInvoice.SendStringToServer(Text: String);
var
  MyStream : TStream;
  StrLen : integer;
begin
  if FServerIP <> '' then
    with IdTCPClient do
      if Connected then
      begin
        StrLen := Length(Text);
        MyStream.Write(StrLen, SizeOf(Integer));
        if StrLen > 0 then
          MyStream.Write(Text[1], StrLen);

        OpenWriteBuffer;
        try
          WriteStream(MyStream);
          //Close the write buffer and have Indy now transmit it
          CloseWriteBuffer;
        except
          // Clear what we had buffered, and disable write buffering
          CancelWriteBuffer;
          // Re-raise the exception so it is not masked
          //raise;
          end;
      end;

end;
}

function TInvoice.CallPollDisplay: Boolean;
var
  i : Integer;
  sInput: String;
  Header: TInvoiceStreamHeader;
  HeaderStream, InvoiceStream: TMemoryStream;
begin

  Result := False;

  ConnectPole;

  if FServerIP <> '' then
    with IdTCPClient do
    begin
      try
        try
          if Connected then
          begin
            InvoiceStream := TMemoryStream.Create;
            try
              HeaderStream := TMemoryStream.Create;
              try

                // Envia InvoiceInfo
                InvoiceStream.WriteComponent(FInvoiceInfo);
                InvoiceStream.Seek(0, soFromBeginning);

                Header.ByteCount := InvoiceStream.Size;
                Header.ComponentCount := 1;
                Header.InvoiceComponentType := ictInvoice;
                HeaderStream.WriteBuffer(Header, SizeOf(TInvoiceStreamHeader));
                HeaderStream.Seek(0, soFromBeginning);
                WriteStream(HeaderStream);
                WriteStream(InvoiceStream);

                // Envia Items
                InvoiceStream.Clear;
                InvoiceStream.Seek(0, soFromBeginning);
                for i := 0 to FInvoiceInfo.Items.Count - 1 do
                begin
                  InvoiceStream.WriteComponent(TInvoiceItems(FInvoiceInfo.Items.Objects[I]));
                end;

                if InvoiceStream.Size > 0 then
                begin
                  InvoiceStream.Seek(0, soFromBeginning);

                  Header.ByteCount := InvoiceStream.Size;
                  Header.ComponentCount := FInvoiceInfo.Items.Count;
                  Header.InvoiceComponentType := ictItem;
                  HeaderStream.Clear;
                  HeaderStream.WriteBuffer(Header, SizeOf(TInvoiceStreamHeader));
                  HeaderStream.Seek(0, soFromBeginning);
                  WriteStream(HeaderStream);
                  WriteStream(InvoiceStream);
                end;

                // Envia Pagamentos
                InvoiceStream.Clear;
                InvoiceStream.Seek(0, soFromBeginning);
                for i := 0 to FInvoiceInfo.Payments.Count - 1 do
                begin
                  InvoiceStream.WriteComponent(TInvoicePayment(FInvoiceInfo.Payments.Objects[I]));
                end;

                if InvoiceStream.Size > 0 then
                begin
                  InvoiceStream.Seek(0, soFromBeginning);

                  Header.ByteCount := InvoiceStream.Size;
                  Header.ComponentCount := FInvoiceInfo.Payments.Count;
                  Header.InvoiceComponentType := ictPayment;
                  HeaderStream.Clear;
                  HeaderStream.WriteBuffer(Header, SizeOf(TInvoiceStreamHeader));
                  HeaderStream.Seek(0, soFromBeginning);
                  WriteStream(HeaderStream);
                  WriteStream(InvoiceStream);
                end;


                // Finaliza envio
                InvoiceStream.Clear;
                InvoiceStream.Seek(0, soFromBeginning);
                Header.ByteCount := InvoiceStream.Size;

                Header.ComponentCount := 0;
                Header.InvoiceComponentType := ictFinalization;
                HeaderStream.Clear;
                HeaderStream.WriteBuffer(Header, SizeOf(TInvoiceStreamHeader));
                HeaderStream.Seek(0, soFromBeginning);
                WriteStream(HeaderStream);
                WriteStream(InvoiceStream);

              finally
                FreeAndNil(HeaderStream);
              end;


            finally
              FreeAndNil(InvoiceStream);
            end;


            //Clear
            //http://www.delphipages.com/threads/thread.cfm?ID=125185&G=125185
            //http://www.delphipages.com/threads/thread.cfm?ID=43111&G=43098
            {
            WriteLn(INV_CLEAR);
            //SendStringToServer(INV_CLEAR);
            //Send Header
            if FInvoiceInfo.FSaleDate <> 0 then
            begin
              sInput := INV_HEADER + ';';
              sInput := sInput + BuildImput(INV_SALE_CODE, FSaleCode) +
                                 BuildImput(INV_DATE, FormatDateTime('ddddd hh:nn am/pm', FSaleDate)) +
                                 BuildImput(INV_ADDEXPENSES, FormatFloat('0.00', FAddCostTotal)) +
                                 BuildImput(INV_SUBTOTAL, FormatFloat('0.00', FSubTotal)) +
                                 BuildImput(INV_TAXTOTAL, FormatFloat('0.00', FTaxTotal)) +
                                 BuildImput(INV_DISCOUNTTOTAL, FormatFloat('0.00', FDiscountTotal)) +
                                 BuildImput(INV_GRAND_TOTAL, FormatFloat('0.00', FSubTotal + FAddCostTotal + FTaxTotal - FDiscountTotal));

              //WriteLn(sInput);
            end;
            //Items
            for i := 0 to FItems.Count-1 do
            begin
              sInput := ITEM_HEADER + ';';
              sInput := sInput + BuildImput(ITEM_ID, IntToStr(TInvoiceItems(FItems.Objects[i]).FID)) +
                                 BuildImput(ITEM_IDMODEL, IntToStr(TInvoiceItems(FItems.Objects[i]).FIDModel)) +
                                 BuildImput(ITEM_MODEL, TInvoiceItems(FItems.Objects[i]).FModel) +
                                 BuildImput(ITEM_DESCRIPTION, TInvoiceItems(FItems.Objects[i]).FDescription) +
                                 BuildImput(ITEM_QTY, FormatFloat('0.##', TInvoiceItems(FItems.Objects[i]).FQty)) +
                                 BuildImput(ITEM_SALEPRICE, FormatFloat('0.00', TInvoiceItems(FItems.Objects[i]).FSalePrice)) +
                                 BuildImput(ITEM_DISCOUNT, FormatFloat('0.00', TInvoiceItems(FItems.Objects[i]).FDiscount)) +
                                 BuildImput(ITEM_TOTAL, FormatFloat('0.00', (TInvoiceItems(FItems.Objects[i]).FSalePrice * TInvoiceItems(FItems.Objects[i]).FQty) - TInvoiceItems(FItems.Objects[i]).FDiscount));
              //WriteLn(sInput);
            end;
            //Payments
            for i := 0 to FPayments.Count-1 do
            begin
              sInput := PAYMENT_HEADER + ';';
              sInput := sInput + BuildImput(PAYMENT_ID, IntToStr(TInvoicePayment(FPayments.Objects[i]).FID)) +
                                 BuildImput(PAYMENT_PAYMENT, TInvoicePayment(FPayments.Objects[i]).FPayment) +
                                 BuildImput(PAYMENT_AMOUNT, FormatFloat('0.00', TInvoicePayment(FPayments.Objects[i]).FAmount));
              //WriteLn(sInput);
            end;
            }
            {//Converter Objeto para Stream
            OpenWriteBuffer;
            try
              WriteStream(FInvoiceInfo);
              //Close the write buffer and have Indy now transmit it
              CloseWriteBuffer;
            except
              // Clear what we had buffered, and disable write buffering
              CancelWriteBuffer;
              // Re-raise the exception so it is not masked
              //raise;
              end;
            }
            Result := True;
          end;
        finally
          //DisconnectSocket;
          //Disconnect;
          end;
      except
        end;
    end;

end;

procedure TInvoice.CloseSale(ARefreshReceipt : Boolean = True);
begin
  FInvoiceInfo.ClearSale;
  if ARefreshReceipt then
    CallPollDisplay;
end;

function TInvoice.ConnectedPole: Boolean;
begin
  Result := IdTCPClient.Connected;
end;

function TInvoice.ConnectPole: Boolean;
begin
  Result := False;

  if FServerIP <> '' then
    with IdTCPClient do
      try
        if not Connected then
        begin
          Host := FServerIP;
          Port := FServerPort;
          Connect(5000);
        end;
        Result := True;
      except
        Result := False;
        end;

end;

constructor TInvoice.Create;
begin
  FInvoiceInfo := TInvoiceInfo.Create(nil);
  IdTCPClient  := TIdTCPClient.Create(nil);
end;

destructor TInvoice.Destroy;
begin
  FreeAndNil(FInvoiceInfo);
  if IdTCPClient.Connected then
  begin
    IdTCPClient.DisconnectSocket;
    IdTCPClient.Disconnect;
  end;
  FreeAndNil(IdTCPClient);
  inherited;
end;

function TInvoice.InvoiceInfo(ASaleCode: String; ASaleDate: TDatetime; AAddCostTotal,
  ADiscountTotal, ATaxTotal, ASubTotal: Currency; UpdateFile : Boolean = False): Boolean;
begin

  FInvoiceInfo.SaleCode := ASaleCode;
  FInvoiceInfo.SaleDate := ASaleDate;
  FInvoiceInfo.AddCostTotal := AAddCostTotal;
  FInvoiceInfo.DiscountTotal := ADiscountTotal;
  FInvoiceInfo.TaxTotal := ATaxTotal;
  FInvoiceInfo.SubTotal := ASubTotal;
  if UpdateFile then
    Result := CallPollDisplay
  else
    Result := True;

end;

procedure TInvoice.SetServerInfo(AServerIP: String; AServerPort: Integer);
begin
  FServerIP := AServerIP;
  FServerPort := AServerPort;
end;

function TInvoice.DeletePayment(AID: Integer;
  UpdateFile: Boolean): Boolean;
begin

  FInvoiceInfo.DeletePayment(AID);

  if UpdateFile then
   CallPollDisplay;

end;

function TInvoice.DeleteItem(AID: Integer; UpdateFile: Boolean): Boolean;
begin

  FInvoiceInfo.DeleteItem(AID);

  if UpdateFile then
   CallPollDisplay;

end;

{ TInvoiceInfo }

procedure TInvoiceInfo.ClearSale;
begin
  SaleCode := '';
  SaleDate := 0;
  AddCostTotal := 0;
  DiscountTotal := 0;
  TaxTotal := 0;
  SubTotal := 0;
  FreeInvoiceItems;
  FreePayments;
end;

constructor TInvoiceInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
  FPayments := TStringList.Create;
end;

function TInvoiceInfo.DeleteItem(AID: Integer): Boolean;
var
  AInvoiceItems : TInvoiceItems;
  i : Integer;
begin
  i := FItems.IndexOf(IntToStr(AID));
  if i <> -1 then
  begin
    AInvoiceItems := TInvoiceItems(FItems.Objects[i]);
    FreeAndNil(AInvoiceItems);
    FItems.Objects[i] := nil;
    FItems.Delete(i);
  end;

  Result := True;
end;

function TInvoiceInfo.DeletePayment(AID: Integer): Boolean;
var
  APaymentList : TInvoicePayment;
  i : Integer;
begin
  i := FPayments.IndexOf(IntToStr(AID));
  if i <> -1 then
  begin
    APaymentList := TInvoicePayment(FPayments.Objects[i]);
    FreeAndNil(APaymentList);
    FPayments.Objects[i] := nil;
    FPayments.Delete(i);
  end;

  Result := True;

end;

destructor TInvoiceInfo.Destroy;
begin
  FreeInvoiceItems;
  FreePayments;
  FreeAndNil(FItems);
  FreeAndNil(FPayments);

  inherited;
end;

procedure TInvoiceInfo.FreeInvoiceItems;
begin
  while FItems.Count > 0 do
    DeleteItem(StrToInt(FItems.Strings[0]));
end;

procedure TInvoiceInfo.FreePayments;
begin
  while FPayments.Count > 0 do
    DeletePayment(StrToInt(FPayments.Strings[0]));
end;

end.
