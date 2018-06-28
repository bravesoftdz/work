unit uSplitPreSale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBTables, DB, Grids, LblEffct, ExtCtrls, StdCtrls, 
  ADODB, siComp, siLangRT, DBGrids, SMDBGrid, DateBox, Mask, SuperComboADO,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, Variants;

type
  TSplitPreSale = class(TFrmParent)
    dsPreSaleItem: TDataSource;
    quPreSaleItem: TADOQuery;
    btSplit: TButton;
    spSplit: TADOStoredProc;
    quUnMarkAll: TADOQuery;
    quPreSaleItemIDPreInventoryMov: TIntegerField;
    quPreSaleItemDocumentID: TIntegerField;
    quPreSaleItemMarked: TBooleanField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleItemSalesPerson: TStringField;
    quPreSaleItemMovDate: TDateTimeField;
    quPreSaleItemDiscount: TFloatField;
    quPreSaleItemTotal: TFloatField;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    EditCustomer: TEdit;
    pnlDeliver: TPanel;
    grdPreSaleItem: TcxGrid;
    grdPreSaleItemDBTableView1: TcxGridDBTableView;
    grdPreSaleItemLevel1: TcxGridLevel;
    grdPreSaleItemDBTableView1Marked: TcxGridDBColumn;
    grdPreSaleItemDBTableView1Description: TcxGridDBColumn;
    grdPreSaleItemDBTableView1Qty: TcxGridDBColumn;
    grdPreSaleItemDBTableView1Total: TcxGridDBColumn;
    grdPreSaleItemDBTableView1QtyRealMov: TcxGridDBColumn;
    quTotalToDivide: TADOQuery;
    grdPreSaleItemDBTableView1Model: TcxGridDBColumn;
    Panel9: TPanel;
    pnlTitle6: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label34: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    scoDeliverType: TSuperComboADO;
    edtDate: TDateBox;
    edtAddress: TEdit;
    memOBS: TMemo;
    quPreSaleItemIDModel: TIntegerField;
    quPreSaleItemNotVerifyQty: TBooleanField;
    quPreSaleItemQty: TFloatField;
    quPreSaleItemQtyRealMov: TFloatField;
    quTotalToDivideTotalRealMov: TFloatField;
    quTotalToDivideTotalQty: TFloatField;
    quPreSaleItemDepartment: TStringField;
    grdPreSaleItemDBTableView1DBColumn1: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSplitClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure quPreSaleItemQtyRealMovValidate(Sender: TField);
    procedure grdPreSaleItemDBTableView1MarkedPropertiesChange(
      Sender: TObject);
    procedure grdPreSaleItemDBTableView1FocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure quPreSaleItemQtyRealMovChange(Sender: TField);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
    procedure dsPreSaleItemStateChange(Sender: TObject);
    procedure grdPreSaleItemExit(Sender: TObject);
    procedure scoDeliverTypeChange(Sender: TObject);
    procedure edtDateChange(Sender: TObject);
    procedure edtAddressChange(Sender: TObject);
    procedure scoDeliverTypeSelectItem(Sender: TObject);
  private
    { Private declarations }
    MyIDCustomer: Integer;
    MyDocumentID: integer;
    bIsExchangeItem : Boolean;
    procedure PreSaleItemOpen;
    procedure PreSaleItemClose;
    procedure ConcileOption;
    procedure DoPost;
    function ValidateDivide: Boolean;
    function CanDivide: Boolean;
    function MovingAllItems: Boolean;
  public
    { Public declarations }
    procedure Start(DocumentID, IDCustomer: integer; Customer, Address: String);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst, uPassword, DateUtils,
     uNumericFunctions;

{$R *.DFM}

procedure TSplitPreSale.PreSaleItemOpen;
begin
  with quPreSaleItem do
  begin
    if Active then
      Close;
    Parameters.ParambyName('DocumentID').Value := MyDocumentID;
    Open;
  end;
end;

procedure TSplitPreSale.PreSaleItemClose;
begin
  quPreSaleItem.Close;
end;

procedure TSplitPreSale.Start(DocumentID, IDCustomer: integer; Customer, Address: String);
begin
  ConcileOption;
  editCustomer.Text  := Customer;
  MyIDCustomer       := IDCustomer;
  edtAddress.Text    := Address;
  MyDocumentID       := DocumentID;
  lblSubMenu.Caption := lblSubMenu.Caption + ' #' +IntToStr(DocumentID);
  ShowModal;
end;

procedure TSplitPreSale.FormShow(Sender: TObject);
begin
  inherited;
  PreSaleItemOpen;
  with quPreSaleItem do
  begin
    grdPreSaleItem.Enabled := not isEmpty;
    //btSplit.Enabled        := (not isEmpty) and CanDivide;

    {if not isEmpty then
      grdPreSaleItem. := clWindow
    else
      grdPreSaleItem.ParentColor := True;}
  end;
  bIsExchangeItem := False;
end;

procedure TSplitPreSale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PreSaleItemClose;
  Action := caFree;
end;

procedure TSplitPreSale.btSplitClick(Sender: TObject);
var
  nHold : Integer;
  sDelivers : String;
begin
  DoPost;
  nHold := 0;
  inherited;
  case DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] of
    1:
      begin
        with spSplit do
        begin
          Parameters.ParambyName('@IDPreSale').Value := MyDocumentID;
          ExecProc;
          nHold := Parameters.ParambyName('@NewIDPreSale').Value;
        end;
        FormShow(nil);
      end;
    2:
      begin

       if not ValidateDivide then
         Exit;
       DM.fPOS.DivideHold(MyDocumentID, StrToInt(scoDeliverType.LookUpValue),
                          edtDate.Date ,edtAddress.Text, memOBS.Text, nHold);

       sDelivers := DM.fPOS.GetCustomerDeliverOpenHold(MyIDCustomer, MyDocumentID);
       if sDelivers <> '' then
          MsgBox(Format(MSG_INF_INVOICE_NOT_DELEVERED,
                [EditCustomer.Text, sDelivers]), vbInformation + vbOkOnly);

      end;
  end;
  FormShow(nil);
  //if nHold <> 0 then
  //  MsgBox(MSG_INF_PART_NEW_HOLD_NUMBER +' '+ IntToStr(nHold), vbOkOnly + vbInformation);
end;

procedure TSplitPreSale.btCloseClick(Sender: TObject);
begin
  inherited;
  with quUnMarkAll do
  begin
    Parameters.ParambyName('DocumentID').Value := MyDocumentID;
    ExecSQL;
  end;
  Close;
end;

procedure TSplitPreSale.quPreSaleItemQtyRealMovValidate(Sender: TField);
begin
  inherited;
  if ((IsNegative(quPreSaleItemQtyRealMov.Value) <> IsNegative(quPreSaleItemQty.Value)) and
     (quPreSaleItemQtyRealMov.Value <> 0)) or
     (Abs(quPreSaleItemQtyRealMov.Value) > Abs(quPreSaleItemQty.Value)) then
    raise Exception.Create(MSG_INF_NOT_EQUAL_QTY);
end;

procedure TSplitPreSale.ConcileOption;
begin
  case DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] of
    1: begin
         pnlDeliver.Visible              := False;
         quPreSaleItemQtyRealMov.Visible := False;
       end;
    2: begin
         pnlDeliver.Visible              := True;
         quPreSaleItemQtyRealMov.Visible := True;
       end;
    else
       begin
         pnlDeliver.Visible              := False;
         quPreSaleItemQtyRealMov.Visible := False;
       end;
  end;
  grdPreSaleItemDBTableView1QtyRealMov.Visible         := quPreSaleItemQtyRealMov.Visible;
  grdPreSaleItemDBTableView1Marked.Options.Editing     := not quPreSaleItemQtyRealMov.Visible;
  grdPreSaleItemDBTableView1Marked.Properties.ReadOnly := quPreSaleItemQtyRealMov.Visible;
end;

procedure TSplitPreSale.grdPreSaleItemDBTableView1MarkedPropertiesChange(
  Sender: TObject);
begin
  inherited;
  DoPost;
end;

procedure TSplitPreSale.grdPreSaleItemDBTableView1FocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  DoPost;
end;

procedure TSplitPreSale.DoPost;
begin
  if quPreSaleItem.State = dsEdit then
    quPreSaleItem.Post;
end;

procedure TSplitPreSale.quPreSaleItemQtyRealMovChange(Sender: TField);
begin
  inherited;
  if Abs(quPreSaleItemQtyRealMov.NewValue) > 0 then
    begin
      if not quPreSaleItemMarked.AsBoolean then
        quPreSaleItemMarked.AsBoolean := True;
    end
  else
    quPreSaleItemMarked.AsBoolean := False;
end;

function TSplitPreSale.ValidateDivide : Boolean;
var
  i : Integer;
  fQtyDelivered : Double;
  bHasDelivery : Boolean;
  AQtyAvaiable: Double;
begin
  Result := False;

  if MovingAllItems then
    Exit;

  if scoDeliverType.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_DELIVER_TYPE_EMPTY, vbCritical + vbOKOnly);
    scoDeliverType.SetFocus;
    Exit;
  end;

  if Trim(edtDate.Text) = '' then
  begin
    MsgBox(MSG_CRT_NO_DATE, vbCritical + vbOKOnly);
    edtDate.SetFocus;
    Exit;
  end;

  if edtDate.Date < Date then
     begin
     MsgBox(MSG_CRT_DELIVER_DATE_SMALER, vbCritical + vbOkOnly);
     edtDate.SetFocus;
     Exit;
     end;

  if Trim(edtAddress.Text) = '' then
  begin
    MsgBox(MSG_INF_NOT_EMPTY_ADDRESS, vbCritical + vbOKOnly);
    edtAddress.SetFocus;
    Exit;
  end;

  //Horas para entregar
  if (DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR] <> -1) and (not Password.HasFuncRight(55)) then
      if CompareDate(edtDate.Date, (Now+1)) = 0 then
         if (HourOf(Now) > DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR]) then
            begin
            i :=  DM.fSystem.SrvParam[PARAM_MARK_DELIVERY_HOUR];
            MsgBox(Format(MSG_CRT_MARK_DELIVERY_NEXTDAY, [i]), vbCritical + vbOkOnly);
            Exit;
            end;

   //Verifica pgto antes de entregar
   if (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE) and
      (DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE] = True) and
      (not bIsExchangeItem) and
      DM.fSystem.SrvParam[PARAM_VERIFY_PGTO_BEFORE_DELIVERY] = True then
      begin
      if DM.fPOS.HasPaymentPending(MyDocumentID) then
         begin
         MsgBox(MSG_INF_PAYMENT_NOT_RECEIVE, vbCritical + vbOkOnly);
         Exit;
         end;
      end;


 if (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = 2) and
    (DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE] = True) and
     (not bIsExchangeItem) then
     begin
     quPreSaleItem.DisableControls;
     quPreSaleItem.First;
     try
       while not quPreSaleItem.Eof do
          begin
          if quPreSaleItemMarked.AsBoolean and (not quPreSaleItemNotVerifyQty.AsBoolean) then
            if (quPreSaleItemQty.AsFloat >= 0) then
            begin
            
              //Verificar estoque
              if DM.fPOS.IsNegativeStoreDelivery(MyDocumentID, DM.fStore.IDStoreSale, quPreSaleItemIDModel.AsInteger, AQtyAvaiable ) then
              begin
                MsgBox(Format(MSG_CRT_INVENTORY_NEGATIVE, [quPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;

              if (AQtyAvaiable - quPreSaleItemQtyRealMov.AsFloat) < 0 then
              begin
                MsgBox(Format(MSG_CRT_UNAVAIlABLE_INVENTORY, [quPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;

              //Verificar entrega
              fQtyDelivered := DM.fPOS.QtyInDelivered(quPreSaleItemIDModel.AsInteger, DM.fStore.IDStoreSale, bHasDelivery);
              if (bHasDelivery) and (fQtyDelivered < quPreSaleItemQtyRealMov.AsFloat) then
              begin
                MsgBox(Format(MSG_CRT_MODEL_IS_IN_DELIVER, [quPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                Exit;
              end;


              //Validade last delivery
              if Password.HasFuncRight(87) then
                if not DM.fPOS.CanMarkDelivery(quPreSaleItemDocumentID.AsInteger, quPreSaleItemIDModel.AsInteger,
                                               quPreSaleItemMovDate.AsDateTime,
                                               AQtyAvaiable, quPreSaleItemQtyRealMov.AsFloat) then
                 begin
                   MsgBox(Format(MSG_CRT_CANNOT_MARK_DELIVER, [quPreSaleItemModel.AsString]), vbCritical + vbOkOnly);
                   Exit;
                 end;

             end;

          quPreSaleItem.Next;
          end;
     finally
       quPreSaleItem.EnableControls;
       end;
     end;

  Result := True

end;

function TSplitPreSale.CanDivide : Boolean;
var
  sMaxDays : String;
begin

  if (scoDeliverType.LookUpValue <> '') and (edtDate.Date <> null) then
  begin
    sMaxDays := DM.DescCodigo(['IDDeliverType'], [scoDeliverType.LookUpValue], 'DeliverType', 'MaxDeliverDelay');
    if sMaxDays <> '' then
    begin
      if Trunc(edtDate.Date) > (Date + StrToInt(sMaxDays)) then
      begin
        MsgBox(MSG_INF_MAX_DELIVERY_DAYS1 + sMaxDays + MSG_INF_MAX_DELIVERY_DAYS2, vbCritical + vbOKOnly);
        Result := False;
        Exit;
      end;
    end;
 end;

 if DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE then
    begin
      Result := (scoDeliverType.LookUpValue <> '') and
          (Trim(edtDate.Text) <> '') and
          (Trim(edtAddress.Text) <> '');

      if not Result then Exit;

      quTotalToDivide.Close;
      quTotalToDivide.Parameters.ParamByName('DocumentID').Value := MyDocumentID;
      try
        quTotalToDivide.Open;
        Result := (quTotalToDivideTotalRealMov.Value <> 0);
      finally
        quTotalToDivide.Close;
      end;
    end
  else
    begin
      Result := True;
    end;
end;


function TSplitPreSale.MovingAllItems : Boolean;
begin
  Result := True;
  quTotalToDivide.Close;
  quTotalToDivide.Parameters.ParamByName('DocumentID').Value := MyDocumentID;
  try
    quTotalToDivide.Open;
    Result := (quTotalToDivideTotalRealMov.Value >= quTotalToDivideTotalQty.Value);
    if Result then
      MsgBox(MSG_INF_NOT_SPLIT_ALL_ITEMS, vbCritical + vbOKOnly);
  finally
    quTotalToDivide.Close;
  end;
end;

procedure TSplitPreSale.dsPreSaleItemDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btSplit.Enabled := CanDivide;
end;

procedure TSplitPreSale.dsPreSaleItemStateChange(Sender: TObject);
begin
  inherited;
  btSplit.Enabled := CanDivide;
end;

procedure TSplitPreSale.grdPreSaleItemExit(Sender: TObject);
begin
  inherited;
  DoPost;
end;

procedure TSplitPreSale.scoDeliverTypeChange(Sender: TObject);
begin
  inherited;
  btSplit.Enabled := CanDivide;
end;

procedure TSplitPreSale.edtDateChange(Sender: TObject);
begin
  inherited;
  btSplit.Enabled := CanDivide;
end;

procedure TSplitPreSale.edtAddressChange(Sender: TObject);
begin
  inherited;
  btSplit.Enabled := CanDivide;
end;

procedure TSplitPreSale.scoDeliverTypeSelectItem(Sender: TObject);
var
 fIsExchange : Variant;
begin
  inherited;
  fIsExchange := scoDeliverType.GetFieldByName('CanExchangeItem');
  if fIsExchange <> Null then
     bIsExchangeItem := StrToBoolDef(fIsExchange, False)
  else
     bIsExchangeItem := False;
end;

end.











