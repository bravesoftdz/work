unit uMainDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MPlayer, Buttons, IdBaseComponent,
  IdComponent, IdTCPServer, IdSocketHandle, OleCtrls, SHDocVw,
  IdTCPConnection, IdTCPClient, uInvoicePollDisplay, siComp;

type
  TFrmMainDisplay = class(TForm)
    pblTextBar: TPanel;
    pnlButton: TPanel;
    Image1: TImage;
    Image3: TImage;
    pnlMain: TPanel;
    pnlTicket: TPanel;
    Image5: TImage;
    pnlInvoiceHeader: TPanel;
    lbInvSaleCode: TLabel;
    Panel3: TPanel;
    lbStoreAddress1: TLabel;
    imgCompanyLog: TImage;
    lbStoreAddress2: TLabel;
    lbStoreAddress3: TLabel;
    lbInvDate: TLabel;
    lbDate: TLabel;
    lbSaleNumber: TLabel;
    lbInvDescrip: TLabel;
    lbInvItemTotal: TLabel;
    Shape1: TShape;
    pnlInvoiceDetail: TPanel;
    pnlInvoiceButton: TPanel;
    Image6: TImage;
    Image4: TImage;
    Image7: TImage;
    Image8: TImage;
    pnlInvoiceSubTotal: TPanel;
    pnlSubTotal: TPanel;
    lbSubTotal: TLabel;
    lbInvSubTotal: TStaticText;
    pnlInvDiscount: TPanel;
    lbDiscount: TLabel;
    lbInvDiscount: TStaticText;
    pnlInvTax: TPanel;
    lbTax: TLabel;
    lbInvTax: TStaticText;
    pnlTotalLine: TPanel;
    spLineTotal: TShape;
    pnlInvTotal: TPanel;
    lbTotal: TLabel;
    lbInvTotal: TStaticText;
    pnlInvAddExp: TPanel;
    lbAddExp: TLabel;
    lbInvAddExpenses: TStaticText;
    pnlPayments: TPanel;
    tmrMovText: TTimer;
    lbTextMove: TLabel;
    pnlAdvertising: TPanel;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    noteAdvertising: TNotebook;
    tmrAdvertising: TTimer;
    imgAdv: TImage;
    pnlVideo: TPanel;
    pnlControl: TPanel;
    mpVideo: TMediaPlayer;
    btnPlay: TSpeedButton;
    btnPause: TSpeedButton;
    btnStop: TSpeedButton;
    IdTCPServer: TIdTCPServer;
    lbConnected: TLabel;
    lbxItems: TListBox;
    lbxPayments: TListBox;
    Panel1: TPanel;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    pnlDescription: TPanel;
    Image2: TImage;
    Image15: TImage;
    lbAdvDescription: TLabel;
    WebBrowser: TWebBrowser;
    tmrCrossSale: TTimer;
    siLang: TsiLang;
    lbMainRetail: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tmrMovTextTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrAdvertisingTimer(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure IdTCPServerExecute(AThread: TIdPeerThread);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdTCPServerConnect(AThread: TIdPeerThread);
    function FillSpace(Left: Boolean; Text : String; Size : Integer) : String;
    procedure ClearSaleInfo;
    procedure IdTCPServerException(AThread: TIdPeerThread;
      AException: Exception);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrCrossSaleTimer(Sender: TObject);
    procedure IdTCPServerListenException(AThread: TIdListenerThread;
      AException: Exception);
    procedure IdTCPServerDisconnect(AThread: TIdPeerThread);
  private
    FCrossSaleItems : TStringList;
    iMoveTextPos : Integer;
    sMoveText : String;
    FState: Integer;
    FStreamSizeExpected: LongInt;
    FActualHeader: TInvoiceStreamHeader;
    FInvoiceInfo: TInvoiceInfo;
    procedure RefreshScreen;
    procedure EnableAdvertising;
    procedure DisableAdvertising;
    function ShowAdvertising(ADescription, AFile : String; AType : Integer; AVideoControl : Boolean): Boolean;
    function CallConfig : Boolean;
    function StartServer : Boolean;
    procedure StopServer;
    procedure DisplayCrossSale;
    procedure SaleComplete;

    procedure SaveScreenPos;
    procedure LoadScreenPos;
    procedure ProccessInvoiceInfo;
  public

  end;

var
  FrmMainDisplay: TFrmMainDisplay;

implementation

uses uFrmConfiguration, uDM, DB, uParamFunctions,
  uInvoicePollDisplayConst, uDMGlobal, uStringFunctions;

{$R *.dfm}

procedure TFrmMainDisplay.FormShow(Sender: TObject);
begin
  RefreshScreen;
  DM.RefreshAdvertising;
  DM.RefreshCrossSale;
  EnableAdvertising;
  ClearSaleInfo;
  LoadScreenPos;
  if not StartServer then
    ShowMessage('Please enable Poll Display in the Config Option!');
end;

procedure TFrmMainDisplay.RefreshScreen;
begin
  iMoveTextPos        := 1;
  sMoveText           := DM.FScreenConfig.FMovingText;
  tmrMovText.Interval := DM.FScreenConfig.FTextSpeed;
  lbTextMove.Caption  := '';
  tmrMovText.Enabled  := False;

  lbStoreAddress1.Caption := DM.FScreenConfig.FStoreAdd1;
  lbStoreAddress2.Caption := DM.FScreenConfig.FStoreAdd2;
  lbStoreAddress3.Caption := DM.FScreenConfig.FStoreAdd3;

  if (DM.FScreenConfig.FLogo <> '') and FileExists(DM.FScreenConfig.FLogo) then
    imgCompanyLog.Picture.LoadFromFile(DM.FScreenConfig.FLogo);

  if DM.FScreenConfig.FReceiptPos = 0 then
    pnlTicket.Align := alLeft
  else
    pnlTicket.Align := alRight;

  case DM.FScreenConfig.FTextSize of
    0 : begin
          pblTextBar.Height := 39;
          lbTextMove.Top := 9;
          lbTextMove.Height := 20;
          lbTextMove.Font.Size := 11;
          lbTextMove.Font.Style := [fsBold];
        end;
    1 : begin
          pblTextBar.Height := 62;
          lbTextMove.Top := 9;
          lbTextMove.Height := 43;
          lbTextMove.Font.Size := 26;
          lbTextMove.Font.Style := [];
        end;
  end;

  pnlTicket.Color := DM.FScreenConfig.FReceiptBackColor;
  lbTextMove.Font.Color := DM.FScreenConfig.FTextColor;

  lbInvDate.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbStoreAddress1.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbStoreAddress2.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbStoreAddress3.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvSaleCode.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvDescrip.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvItemTotal.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbSubTotal.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvSubTotal.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbAddExp.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvAddExpenses.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbDiscount.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvDiscount.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbTax.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvTax.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  spLineTotal.Brush.Color := DM.FScreenConfig.FReceiptTextColor;
  lbTotal.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbInvTotal.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbxPayments.Font.Color := DM.FScreenConfig.FReceiptTextColor;
  lbxItems.Font.Color := DM.FScreenConfig.FReceiptTextColor;

  if sMoveText <> '' then
    tmrMovText.Enabled := True;

  lbAdvDescription.Visible := False;
  
end;

procedure TFrmMainDisplay.tmrMovTextTimer(Sender: TObject);
begin
  if iMoveTextPos > Length(sMoveText) then
    iMoveTextPos := 0
  else
     Inc(iMoveTextPos);
  lbTextMove.Caption := Copy(sMoveText, iMoveTextPos, Length(sMoveText) - iMoveTextPos+1) + Copy(sMoveText, 1, iMoveTextPos);
end;

procedure TFrmMainDisplay.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  
  case Key of
    VK_ESCAPE : Close;
    VK_RETURN : begin
                  if (ssCtrl in shift)	then
                  begin
                  DisableAdvertising;
                  try
                    if CallConfig then
                    begin
                      RefreshScreen;
                      if not IdTCPServer.Active then
                        StartServer;
                    end;
                  finally
                    EnableAdvertising;
                    end;
                  end;
                end;
  end;

end;

function TFrmMainDisplay.CallConfig : Boolean;
begin
  with TFrmConfig.Create(Self) do
    Result := Start;
end;

procedure TFrmMainDisplay.DisableAdvertising;
begin
  noteAdvertising.Visible := False;
  tmrAdvertising.Enabled := False;
  DM.cdsAdvertising.Filtered := False;
  DM.cdsAdvertising.Filter := '';
end;

procedure TFrmMainDisplay.EnableAdvertising;
var
  AFilter : String;
  ADesc : String;
begin
  AFilter := 'StartDate <= ' + QuotedStr(FormatDateTime('ddddd', Now));
  AFilter := AFilter + ' AND EndDate > ' + QuotedStr(FormatDateTime('ddddd', Now));

  with DM.cdsAdvertising do
  begin
    Filter := AFilter;
    Filtered := True;
    if RecordCount > 1 then
    begin
      First;
      tmrAdvertising.Interval := FieldByName('Duration').AsInteger * 1000;

      ADesc := '';
      if FieldByName('DisplayDescription').AsBoolean then
        ADesc := FieldByName('Description').AsString;

      tmrAdvertising.Enabled  := ShowAdvertising(ADesc,
                                                 FieldByName('FileName').AsString,
                                                 FieldByName('Type').AsInteger,
                                                 FieldByName('VideoControl').AsBoolean);
    end;
  end;

end;

procedure TFrmMainDisplay.tmrAdvertisingTimer(Sender: TObject);
var
   ADesc : String;
begin

 tmrAdvertising.Enabled := False;

  with DM.cdsAdvertising do
  begin
    Next;
    if EOF then
    begin
      DisableAdvertising;
      DM.RefreshAdvertising;
      EnableAdvertising;
    end;

    if RecordCount > 1 then
    begin
      tmrAdvertising.Interval := FieldByName('Duration').AsInteger * 1000;
      ADesc := '';

      if FieldByName('DisplayDescription').AsBoolean then
        ADesc := FieldByName('Description').AsString;

      ShowAdvertising(ADesc,
                      FieldByName('FileName').AsString,
                      FieldByName('Type').AsInteger,
                      FieldByName('VideoControl').AsBoolean);
    end;

    tmrAdvertising.Enabled  := True;
  end;

end;

function TFrmMainDisplay.ShowAdvertising(ADescription, AFile : String;
  AType : Integer; AVideoControl : Boolean): Boolean;
var
  ws : WideString;
  Flags: OleVariant;
begin

  noteAdvertising.Visible := True;
  Flags := 2;
  WebBrowser.Navigate('', Flags);

  Result := True;
  try

    if ADescription <> '' then
    begin
      lbAdvDescription.Visible := True;
      lbAdvDescription.Caption := ADescription;
    end
    else
      lbAdvDescription.Visible := False;

    Case AType of
      ADV_BITMAP,
      ADV_JPG    : begin
                     imgAdv.Picture := nil;
                     if FileExists(AFile) then
                     begin
                       noteAdvertising.ActivePage := 'PG_Bitmap_JPG';
                       imgAdv.Picture.LoadFromFile(AFile);
                     end;
                   end;

      ADV_VIDEO : begin
                     if FileExists(AFile) then
                     begin
                       noteAdvertising.ActivePage := 'PG_Video';
                       pnlControl.Visible := AVideoControl;
                       mpVideo.FileName := AFile;
                       mpVideo.Open;
                       mpVideo.DisplayRect := Rect(DM.FScreenConfig.FVideoLeft,
                                                   DM.FScreenConfig.FVideoTop,
                                                   DM.FScreenConfig.FVideoRight,
                                                   DM.FScreenConfig.FVideoBottom);
                       mpVideo.Play;
                     end;
                  end;

      ADV_FLASH,
      ADV_WEB  : begin
                   noteAdvertising.ActivePage := 'PG_Web';
                   ws := AFile;
                   WebBrowser.Navigate(ws, Flags);
                 end;
    end;

    Application.ProcessMessages;
  except
    Result := False;
    end;
end;

procedure TFrmMainDisplay.btnPlayClick(Sender: TObject);
begin
  mpVideo.Play;
end;

procedure TFrmMainDisplay.btnPauseClick(Sender: TObject);
begin
  mpVideo.Pause;
end;

procedure TFrmMainDisplay.btnStopClick(Sender: TObject);
begin
  mpVideo.Stop;
end;

procedure TFrmMainDisplay.IdTCPServerExecute(AThread: TIdPeerThread);
var
  ReceivingStream : TMemoryStream;
  InvoiceItem: TInvoiceItems;
  Payment: TInvoicePayment;
  I: Integer;
begin

  if AThread.Connection.Connected then
  case FState of

    STATE_WAITING_HEADER:
    begin
      ReceivingStream := TMemoryStream.Create;
      try
        AThread.Connection.ReadStream(ReceivingStream, SizeOf(TInvoiceStreamHeader));
        ReceivingStream.Seek(0, soFromBeginning);
        FActualHeader := TInvoiceStreamHeader(ReceivingStream.Memory^);
      finally
        FreeAndNil(ReceivingStream);
      end;
      FStreamSizeExpected := FActualHeader.ByteCount;
      FState := STATE_WAITING_BODY;
    end;

    STATE_WAITING_BODY:
    begin
      ReceivingStream := TMemoryStream.Create;
      try
        AThread.Connection.ReadStream(ReceivingStream, FStreamSizeExpected);
        ReceivingStream.Seek(0, soFromBeginning);


        case FActualHeader.InvoiceComponentType of
          ictInvoice:
          begin
            FInvoiceInfo := TInvoiceInfo(ReceivingStream.ReadComponent(nil));
            FInvoiceInfo.Items := TStringList.Create;
            FInvoiceInfo.Payments := TStringList.Create;
          end;

          ictItem:
          begin
            FInvoiceInfo.FreeInvoiceItems;
            for i := 0 to FActualHeader.ComponentCount - 1 do
            begin
              InvoiceItem := TInvoiceItems(ReceivingStream.ReadComponent(nil));
              FInvoiceInfo.Items.AddObject(IntToStr(InvoiceItem.ID), InvoiceItem);
            end;
          end;

          ictPayment:
          begin
            FInvoiceInfo.FreePayments;
            for i := 0 to FActualHeader.ComponentCount - 1 do
            begin
              Payment := TInvoicePayment(ReceivingStream.ReadComponent(nil));
              FInvoiceInfo.Payments.AddObject(IntToStr(Payment.ID), Payment);
            end;
          end;

          ictFinalization:
          begin
            ProccessInvoiceInfo;
          end;
        end;
      finally
        FreeAndNil(ReceivingStream);
      end;
      FState := STATE_WAITING_HEADER;
    end;
    
  end;
  
end;

procedure TFrmMainDisplay.ProccessInvoiceInfo;
var
  sLine1, sLine2 : String;
  sCrossItems : String;
  Item: TInvoiceItems;
  Payment: TInvoicePayment;
  i: Integer;

begin

  ClearSaleInfo;

  if FInvoiceInfo.Items.Count > 0 then
  begin

    if not tmrCrossSale.Enabled then
      imgAdv.Proportional := DM.FScreenConfig.FAutoResizeAdv
    else
      imgAdv.Proportional := False;

    pnlTicket.Visible := True;
    pnlSubTotal.Visible := False;
    pnlInvAddExp.Visible := False;
    pnlInvDiscount.Visible := False;
    pnlInvTax.Visible := False;
    pnlTotalLine.Visible := False;
    pnlInvTotal.Visible := False;

    lbDate.Caption       := FormatDateTime('ddddd hh:nn am/pm', FInvoiceInfo.SaleDate);
    lbSaleNumber.Caption := FInvoiceInfo.SaleCode;

    pnlInvTotal.Visible := True;
    pnlTotalLine.Visible := True;
    lbInvTotal.Caption := FormatFloat('0.00', FInvoiceInfo.SubTotal + FInvoiceInfo.AddCostTotal + FInvoiceInfo.TaxTotal - FInvoiceInfo.DiscountTotal);

    if (FInvoiceInfo.TaxTotal  <> 0) then
    begin
      pnlInvTax.Visible := True;
      lbInvTax.Caption := FormatFloat('0.00', FInvoiceInfo.TaxTotal);
    end;

    if (FInvoiceInfo.DiscountTotal <> 0) then
    begin
      pnlInvDiscount.Visible := True;
      lbInvDiscount.Caption := FormatFloat('0.00', FInvoiceInfo.DiscountTotal);
    end;

    if (FInvoiceInfo.AddCostTotal <> 0) then
    begin
      pnlInvAddExp.Visible := True;
      lbInvAddExpenses.Caption := FormatFloat('0.00', FInvoiceInfo.AddCostTotal);
    end;

    pnlSubTotal.Visible := True;
    lbInvSubTotal.Caption := FormatFloat('0.00', FInvoiceInfo.SubTotal);

    for i := 0 to FInvoiceInfo.Items.Count - 1 do
    begin
      Item := TInvoiceItems(FInvoiceInfo.Items.Objects[i]);

      sLine1 := FillSpace(False, Item.Description, 32) +
                FillSpace(True, FormatFloat('0.00', Item.SalePrice * Item.Qty - Item.Discount), 8);
      lbxItems.Items.Add(sLine1);

      if (Item.Qty <> 1) then
      begin
        sLine2 := FillSpace(True, FormatFloat('0.##', Item.Qty) + ' * ' + FormatFloat('0.##', Item.SalePrice), 15);
        lbxItems.Items.Add(sLine2);
        sLine2 := '';
      end;

      if FCrossSaleItems.IndexOf(Item.Description) = -1 then
      begin
         FCrossSaleItems.Add(Item.Description);
         if DM.GetCrossSaleItems(Item.Model, DM.FScreenConfig.FStationName) then
           DisplayCrossSale;
      end;
      
    end;

    
    for i := 0 to FInvoiceInfo.Payments.Count - 1 do
    begin
      Payment := TInvoicePayment(FInvoiceInfo.Payments.Objects[i]);

      sLine1 := FillSpace(False, '       ' + Payment.Payment , 20) +
                FillSpace(True, FormatFloat('0.00', Payment.Amount), 20);
      lbxPayments.Items.Add(sLine1);
    end;

  end
  else
  begin
    imgAdv.Proportional := False;
    pnlTicket.Visible := False;
    SaleComplete;
  end;

end;

function TFrmMainDisplay.StartServer : Boolean;
var
  Binding : TIdSocketHandle;
begin

  Result := False;

  if DM.FScreenConfig.FComputerIP = '' then
    Exit;

  IdTCPServer.Bindings.Clear;
  try
    Binding := IdTCPServer.Bindings.Add;
    Binding.IP := DM.FScreenConfig.FComputerIP;
    Binding.Port := DM.FScreenConfig.FCompPort;
    IdTCPServer.Active := True;
    Result := True;
  except
    on E : Exception do
        begin
        Result := False;
        lbConnected.Visible := True;
        lbConnected.Caption := E.Message;
        end;
    end;

end;

procedure TFrmMainDisplay.StopServer;
var
  Binding : TIdSocketHandle;
  r : Integer;
begin

  if IdTCPServer.Threads <> nil then
  begin

    with IdTCPServer.Threads.LockList do
    try
      for r := 0 to Count - 1 do
        TIdPeerThread(Items[r]).Connection.DisconnectSocket;
    finally
      IdTCPServer.Threads.UnlockList;
      end;
  end;


  IdTCPServer.Active := False;
  while IdTCPServer.Bindings.Count > 0 do
  begin
    Binding := IdTCPServer.Bindings.Items[0];
    FreeAndNil(Binding);
  end;
  IdTCPServer.Bindings.Clear;

end;

procedure TFrmMainDisplay.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tmrAdvertising.Enabled := False;
  tmrMovText.Enabled := False;
  tmrCrossSale.Enabled := False;
  SaveScreenPos;
  StopServer;

end;

procedure TFrmMainDisplay.IdTCPServerConnect(AThread: TIdPeerThread);
begin
  lbConnected.Visible := False;
  FState := STATE_WAITING_HEADER;
  FStreamSizeExpected := 0;
end;


function TFrmMainDisplay.FillSpace(Left: Boolean; Text: String;
  Size: Integer): String;
begin
  Result := Text;

  if Length(Result) > Size then
    Result := Copy(Result, 0, Size)
  else
    while Length(Result) < Size do
    begin
      if Left then
        Result := ' ' + Result
      else
        Result := Result + ' ';
    end;
end;

procedure TFrmMainDisplay.ClearSaleInfo;
begin

  lbDate.Caption := '';
  lbSaleNumber.Caption := '';

  pnlSubTotal.Visible := False;
  pnlInvAddExp.Visible := False;
  pnlInvDiscount.Visible := False;
  pnlInvTax.Visible := False;
  pnlTotalLine.Visible := False;
  pnlInvTotal.Visible := False;

  try
    lbxItems.Visible := False;
    lbxItems.Items.Clear;
    lbxPayments.Visible := False;
    lbxPayments.Items.Clear;
  finally
    lbxItems.Visible := True;
    lbxPayments.Visible := True;
    end;

end;

procedure TFrmMainDisplay.IdTCPServerException(AThread: TIdPeerThread;
  AException: Exception);
begin
  if AException.Message = 'EIdConnClosedGracefully'  then
  begin
    //process some code here if you want.
  end;
end;

procedure TFrmMainDisplay.LoadScreenPos;
begin
  Self.Left         := DM.FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_LEFT, 30);
  Self.Top          := DM.FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_TOP, 90);
  Self.ClientHeight := DM.FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_HEIGHT, 549);
  Self.ClientWidth  := DM.FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_WIDTH, 800);
end;

procedure TFrmMainDisplay.SaveScreenPos;
begin
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_LEFT, Self.Left);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_TOP, Self.Top);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_HEIGHT, Self.ClientHeight);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_WIDTH, Self.ClientWidth);
end;

procedure TFrmMainDisplay.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCrossSaleItems);
end;

procedure TFrmMainDisplay.FormCreate(Sender: TObject);
begin
  FCrossSaleItems := TStringList.Create;
end;

procedure TFrmMainDisplay.DisplayCrossSale;
begin

  tmrAdvertising.Enabled := False;

  if DM.cdsSaleSuggestion.IsEmpty then
    DM.cdsSaleSuggestion.Last;

  tmrCrossSale.Enabled := True;
  
end;

procedure TFrmMainDisplay.tmrCrossSaleTimer(Sender: TObject);
begin
  tmrCrossSale.Enabled := False;

  DM.cdsSaleSuggestion.Next;
  if DM.cdsSaleSuggestion.Eof then
    DM.cdsSaleSuggestion.First;

  ShowAdvertising('',
                  DM.cdsSaleSuggestionFileName.AsString,
                  DM.cdsSaleSuggestionFileType.AsInteger,
                  False);

  tmrCrossSale.Interval := DM.cdsSaleSuggestionDuration.AsInteger * 1000;

  tmrCrossSale.Enabled := True;

end;

procedure TFrmMainDisplay.SaleComplete;
begin
  tmrCrossSale.Enabled := False;
  FCrossSaleItems.Clear;
  DM.ClearCrossSale;
  tmrAdvertising.Interval := 1000;
  tmrAdvertising.Enabled := True;
end;

procedure TFrmMainDisplay.IdTCPServerListenException(
  AThread: TIdListenerThread; AException: Exception);
begin
  lbConnected.Visible := True;
  lbConnected.Caption := AException.Message;
end;

procedure TFrmMainDisplay.IdTCPServerDisconnect(AThread: TIdPeerThread);
begin
  //AThread.Data := nil;
end;

initialization
  RegisterClass(TInvoiceInfo);
  RegisterClass(TInvoiceItems);
  RegisterClass(TInvoicePayment);
finalization
  UnRegisterClass(TInvoiceInfo);
  UnRegisterClass(TInvoiceItems);
  UnRegisterClass(TInvoicePayment);
end.


