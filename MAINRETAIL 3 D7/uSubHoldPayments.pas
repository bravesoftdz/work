unit uSubHoldPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, ADODB, Mask, SuperComboADO,
  StdCtrls, DBCtrls, ExtCtrls, Menus;

type
  TSubHoldPayments = class(TParentSub)
    dsPayment: TDataSource;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseDBImageIndex: TcxGridDBColumn;
    grdBrowseDBMeioPag: TcxGridDBColumn;
    grdBrowseLevel: TcxGridLevel;
    grdBrowseDBValorNominal: TcxGridDBColumn;
    grdBrowseDBDataVencimento: TcxGridDBColumn;
    grdBrowseDBHistorico: TcxGridDBColumn;
    pnlPaymentDetail: TPanel;
    lbCheckNum: TLabel;
    lbBank: TLabel;
    lbHistory: TLabel;
    lbDoc: TLabel;
    lbPhone: TLabel;
    lbCustomer: TLabel;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    scBankEdit: TSuperComboADO;
    popBrowse: TPopupMenu;
    mnuDeletePayment: TMenuItem;
    spPreSaleDeleteSingleDelayPayment: TADOStoredProc;
    grdBrowseDBPayPlace: TcxGridDBColumn;
    quPayment: TADOQuery;
    quPaymentIDMeioPag: TIntegerField;
    quPaymentMeioPag: TStringField;
    quPaymentValorNominal: TFloatField;
    quPaymentDataVencimento: TDateTimeField;
    quPaymentIDQuitacaoMeioPrevisto: TIntegerField;
    quPaymentIDLancamentoTipo: TIntegerField;
    quPaymentIDDocumentoTipo: TIntegerField;
    quPaymentIDPreSale: TIntegerField;
    quPaymentCheckNumber: TStringField;
    quPaymentIDBankCheck: TIntegerField;
    quPaymentCustomerDocument: TStringField;
    quPaymentCustomerName: TStringField;
    quPaymentCustomerPhone: TStringField;
    quPaymentHistorico: TMemoField;
    quPaymentImageIndex: TIntegerField;
    quPaymentIDLancamento: TIntegerField;
    quPaymentIDCashRegMovClosed: TIntegerField;
    quPaymentPaymentPlace: TIntegerField;
    quPaymentPayPlace: TStringField;
    munPrintBillter: TMenuItem;
    quPaymentPrintBankBillet: TBooleanField;
    quEstimated: TADOQuery;
    quEstimatedIDMeioPag: TIntegerField;
    quEstimatedMeioPag: TStringField;
    quEstimatedImageIndex: TIntegerField;
    quEstimatedPrintBankBillet: TBooleanField;
    quEstimatedValorNominal: TBCDField;
    quEstimatedDataVencimento: TDateTimeField;
    quEstimatedIDQuitacaoMeioPrevisto: TIntegerField;
    quEstimatedIDLancamentoTipo: TIntegerField;
    quEstimatedIDDocumentoTipo: TIntegerField;
    quEstimatedIDPreSale: TIntegerField;
    quEstimatedCheckNumber: TStringField;
    quEstimatedIDBankCheck: TIntegerField;
    quEstimatedCustomerDocument: TStringField;
    quEstimatedCustomerName: TStringField;
    quEstimatedCustomerPhone: TStringField;
    quEstimatedHistorico: TMemoField;
    quEstimatedIDCashRegMovClosed: TIntegerField;
    quEstimatedPaymentPlace: TIntegerField;
    quEstimatedPayPlace: TStringField;
    quEstimatedIDLancamento: TIntegerField;
    procedure FormDestroy(Sender: TObject);
    procedure dsPaymentDataChange(Sender: TObject; Field: TField);
    procedure quPaymentAfterOpen(DataSet: TDataSet);
    procedure popBrowsePopup(Sender: TObject);
    procedure mnuDeletePaymentClick(Sender: TObject);
    procedure quPaymentCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure munPrintBillterClick(Sender: TObject);
    procedure quEstimatedCalcFields(DataSet: TDataSet);
    procedure quEstimatedAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    sStore,
    sOutStore,
    sOther : String;
    fIDPreSale  : Integer;
    fIDServiceOrder  : Integer;
    fShowDetail : Boolean;
    fMenuEnabled,
    fNewPreSale : Boolean;
    fEstimated : Boolean;
    procedure DisplayPanel(bShowDetail:Boolean);
    function HasCheckPayment:Boolean;
    function CanDeletePayment:Boolean;
    procedure DeletePayment;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    property  ShowDetail : Boolean read fShowDetail write DisplayPanel;
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uDMGlobal, uParamFunctions, uMsgBox, uMsgConstant, uPassword,
  uSqlFunctions, uFrmPrintBoleto, uSystemConst;

{$R *.dfm}

procedure TSubHoldPayments.DataSetRefresh;
begin
 DataSetClose;
 DataSetOpen;
end;


procedure TSubHoldPayments.AfterSetParam;
begin

  if FParam = '' then
    Exit;

  //Set parans
  fIDPreSale      := StrToIntDef(ParseParam(FParam, 'IDPreSale'), 0);
  ShowDetail      := StrToBool(ParseParam(FParam, 'ShowDetail')) = True;
  fMenuEnabled    := ParseParam(FParam, 'Enabled') <> '0';
  fNewPreSale     := ParseParam(FParam, 'IsNewInvoice') <> '0';
  fIDServiceOrder := StrToIntDef(ParseParam(FParam, 'IDServiceOrder'), 0);

  if Pos('Estimated', FParam) > 0 then
    fEstimated := (StrToBool(ParseParam(FParam, 'Estimated')) = True)
  else
    fEstimated := False;

  if fEstimated then
    dsPayment.DataSet := quEstimated
  else
    dsPayment.DataSet := quPayment;

  if (fIDPreSale = 0) and (fIDServiceOrder = 0) then
  begin
    DataSetClose;
    Exit;
  end;

  //Open DataSet
  DataSetRefresh;

end;


procedure TSubHoldPayments.DataSetClose;
begin

  with TDataSet(dsPayment.DataSet) do
    if Active then
       Close;

end;

procedure TSubHoldPayments.DataSetOpen;
begin

  if fEstimated then
  begin
    with quEstimated do
      if not Active then
      begin
        if fIDPreSale <> 0 then
          SQL.Text := ChangeWhereClause(SQL.Text, ' PC.IDPreSale = ' + IntToStr(fIDPreSale), True);
        Open;
      end;
  end
  else
  begin
    with quPayment do
      if not Active then
      begin
        if fIDPreSale <> 0 then
          SQL.Text := ChangeWhereClause(SQL.Text, ' L.IDPreSale = ' + IntToStr(fIDPreSale), True);

        if fIDServiceOrder <> 0 then
          SQL.Text := ChangeWhereClause(SQL.Text, ' L.IDServiceOrder = ' + IntToStr(fIDServiceOrder), True);

        Open;
      end;
  end;
end;

procedure TSubHoldPayments.FormDestroy(Sender: TObject);
begin
  inherited;
  DataSetClose;
end;

procedure TSubHoldPayments.DisplayPanel(bShowDetail:Boolean);
begin
  fShowDetail              := bShowDetail;
  pnlPaymentDetail.Visible := bShowDetail;
end;

procedure TSubHoldPayments.dsPaymentDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  
  if not fEstimated then
  begin
    lbBank.Visible         := (quPaymentIDBankCheck.AsString <> '');
    scBankEdit.Visible     := lbBank.Visible;
    if scBankEdit.Visible then
       scBankEdit.LookUpValue := quPaymentIDBankCheck.AsString;
  end;

end;

function TSubHoldPayments.HasCheckPayment:Boolean;
begin

  quPayment.DisableControls;
  Result := False;
  try
    quPayment.First;
    while not quPayment.Eof do
      begin
      Result := (quPaymentCustomerName.AsString <> '');
      if Result then
         Break;
      quPayment.Next;
      end;
  finally
    quPayment.First;
    quPayment.EnableControls;
    end;

end;

procedure TSubHoldPayments.quPaymentAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pnlPaymentDetail.Visible := (fShowDetail and HasCheckPayment);
end;

procedure TSubHoldPayments.popBrowsePopup(Sender: TObject);
begin
  inherited;

  if not fEstimated then
  begin
    mnuDeletePayment.Enabled := (fMenuEnabled and Password.HasFuncRight(44)) or fNewPreSale;

    munPrintBillter.Visible := (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] and
                                quPaymentPrintBankBillet.AsBoolean);
  end
  else
  begin
    mnuDeletePayment.Enabled := False;
    munPrintBillter.Enabled  := False;
  end;


end;

procedure TSubHoldPayments.mnuDeletePaymentClick(Sender: TObject);
begin

  if CanDeletePayment then
  begin
    DeletePayment;
    NotifyChanges('DELETED=TRUE;');
  end;

end;

procedure TSubHoldPayments.DeletePayment;
begin

  if fEstimated then
  begin
    DM.RunSQL('DELETE IDPaymentCondition WHERE IDPaymentCondition = ' + IntToStr(quEstimatedIDLancamento.AsInteger));
  end
  else
  begin
    with spPreSaleDeleteSingleDelayPayment do
    begin
      Parameters.ParambyName('@IDLancamento').Value := quPaymentIDLancamento.Value;
      Parameters.ParambyName('@IDUser').Value       := DM.fUser.ID;
      ExecProc;
    end;
  end;

  DataSetRefresh;
  
end;

function TSubHoldPayments.CanDeletePayment: Boolean;
begin

 Result := False;

 if not fEstimated then
   if (quPaymentIDCashRegMovClosed.AsInteger <> 0) then
   begin
     MsgBox(MSG_CRT_NO_DEL_RECEIVED_PAYMENT, vbCritical + vbOkOnly);
     Exit;
   end;

 Result := True;
 
end;

procedure TSubHoldPayments.quPaymentCalcFields(DataSet: TDataSet);
begin
  inherited;
  case quPaymentPaymentPlace.AsInteger of
  0 : quPaymentPayPlace.AsString := sStore;
  1 : quPaymentPayPlace.AsString := sOutStore;
  2 : quPaymentPayPlace.AsString := sOther;
  end;
end;

procedure TSubHoldPayments.FormCreate(Sender: TObject);
begin
  inherited;
  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sStore    := 'Store';
           sOutStore := 'Out of Store';
           sOther    := 'Other';
           end;

     LANG_PORTUGUESE :
           begin
           sStore    := 'Loja';
           sOutStore := 'Contra-Entrega';
           sOther    := 'Outros';
           end;

     LANG_SPANISH :
           begin
           sStore    := 'Tienda';
           sOutStore := 'Contra-Entrega';
           sOther    := 'Otros';
           end;
   end;
end;

procedure TSubHoldPayments.munPrintBillterClick(Sender: TObject);
begin
  inherited;
  with TFrmPrintBoleto.Create(Self) do
    Start(quPaymentIDLancamento.AsInteger);
end;

procedure TSubHoldPayments.quEstimatedCalcFields(DataSet: TDataSet);
begin
  inherited;

  case quEstimatedPaymentPlace.AsInteger of
    0 : quEstimatedPayPlace.AsString := sStore;
    1 : quEstimatedPayPlace.AsString := sOutStore;
    2 : quEstimatedPayPlace.AsString := sOther;
  end;

end;

procedure TSubHoldPayments.quEstimatedAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pnlPaymentDetail.Visible := False;
end;

initialization
   RegisterClass(TSubHoldPayments);

end.
