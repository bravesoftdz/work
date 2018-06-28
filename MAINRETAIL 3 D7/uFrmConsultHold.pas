unit uFrmConsultHold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DateBox, Mask, SuperComboADO, SubListPanel, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, ADODB, PowerADOQuery,
  ComCtrls, DBCtrls, MemoStr, LblEffct;

type
  TFrmConsultHold = class(TFrmParentAll)
    pnlBasicFilter: TPanel;
    Label3: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    cmbStore: TSuperComboADO;
    Button2: TButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    cbmDocs: TComboBox;
    edtDocs: TEdit;
    cbmName: TComboBox;
    edtNames: TEdit;
    pnlInvoices: TPanel;
    pnlDetail: TPanel;
    Label4: TLabel;
    edtHoldNumber: TEdit;
    quHolds: TPowerADOQuery;
    dsHolds: TDataSource;
    quHoldsIDPreSale: TIntegerField;
    quHoldsIDInvoice: TIntegerField;
    quHoldsInvoiceDate: TDateTimeField;
    quHoldsTotalInvoice: TBCDField;
    quHoldsSubTotal: TBCDField;
    quHoldsTax: TBCDField;
    quHoldsLayaway: TBooleanField;
    quHoldsAditionalExpenses: TBCDField;
    quHoldsIDStore: TIntegerField;
    quHoldsName: TStringField;
    grdHold: TcxGrid;
    grdHoldDB: TcxGridDBTableView;
    grdHoldLevel: TcxGridLevel;
    grdHoldDBName: TcxGridDBColumn;
    pnlBotton: TPanel;
    Splitter1: TSplitter;
    quHoldsIDPessoa: TIntegerField;
    quPreSaleItem: TADOStoredProc;
    quPreSaleItemModelID: TIntegerField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleItemSalePrice: TFloatField;
    quPreSaleItemDiscount: TFloatField;
    quPreSaleItemIDInventoryMov: TIntegerField;
    quPreSaleItemTotalItem: TFloatField;
    quPreSaleItemSalesPerson: TStringField;
    quPreSaleItemIDComission: TIntegerField;
    quPreSaleItemCostPrice: TFloatField;
    quPreSaleItemIDUser: TIntegerField;
    quPreSaleItemExchangeInvoice: TIntegerField;
    quPreSaleItemTax: TBCDField;
    quPreSaleItemUnitSalePrice: TCurrencyField;
    quPreSaleItemTaxValue: TFloatField;
    quPreSaleItemCodSize: TStringField;
    quPreSaleItemSizeName: TStringField;
    quPreSaleItemCodColor: TStringField;
    quPreSaleItemColor: TStringField;
    quPreSaleItemSuggRetail: TBCDField;
    quDeliveryInfo: TADOQuery;
    quDeliveryInfoIDPreSale: TIntegerField;
    quDeliveryInfoDeliverTypeID: TIntegerField;
    quDeliveryInfoDeliverDate: TDateTimeField;
    quDeliveryInfoDeliverAddress: TStringField;
    quDeliveryInfoDeliverOBS: TStringField;
    quDeliveryInfoDeliverConfirmation: TBooleanField;
    quDeliveryInfoIDFormOfPayment: TIntegerField;
    quDeliveryInfoDeliverType: TStringField;
    dsPreSaleItem: TDataSource;
    dsDeliveryInfo: TDataSource;
    pnlPaymentInfo: TPanel;
    Shape1: TShape;
    lbCustomer: TLabel;
    SubCustomer: TSubListPanel;
    Panel5: TPanel;
    Shape3: TShape;
    Label6: TLabel;
    Panel2: TPanel;
    Shape2: TShape;
    Label5: TLabel;
    quHoldsPreSaleDate: TDateTimeField;
    PageControl1: TPageControl;
    tsPayments: TTabSheet;
    SubPaymentType: TSubListPanel;
    tsDelivery: TTabSheet;
    grdDelivery: TcxGrid;
    grdDeliveryDB: TcxGridDBTableView;
    grdDeliveryDBDeliverType: TcxGridDBColumn;
    grdDeliveryDBDeliverDate: TcxGridDBColumn;
    grdDeliveryDBDeliverAddress: TcxGridDBColumn;
    grdDeliveryDBDeliverOBS: TcxGridDBColumn;
    cxgrdDelivery: TcxGridLevel;
    tsOtherCosts: TTabSheet;
    tsNotes: TTabSheet;
    quAddExpenses: TADODataSet;
    quAddExpensesCostType: TStringField;
    quAddExpensesIDInvoiceCost: TIntegerField;
    quAddExpensesIDCostType: TIntegerField;
    quAddExpensesAmount: TBCDField;
    dsAddExpenses: TDataSource;
    quHoldsNote: TStringField;
    EditNote: TDbMemoStr;
    grdInvExpenses: TcxGrid;
    grdInvExpensesDB: TcxGridDBTableView;
    grdLevelInvExpenses: TcxGridLevel;
    grdInvExpensesDBCostType: TcxGridDBColumn;
    grdInvExpensesDBAmount: TcxGridDBColumn;
    btnPayments: TSpeedButton;
    btnHistory: TSpeedButton;
    btnPrint: TSpeedButton;
    grdItem: TcxGrid;
    grdItemDB: TcxGridDBTableView;
    cxgrdItem: TcxGridLevel;
    grdItemDBModel: TcxGridDBColumn;
    grdItemDBDescription: TcxGridDBColumn;
    grdItemDBQty: TcxGridDBColumn;
    grdItemDBTotalItem: TcxGridDBColumn;
    quHoldsSaleCode: TStringField;
    grdHoldDBSaleCode: TcxGridDBColumn;
    quPreSaleItemIsDelivered: TBooleanField;
    grdItemDBIsDelivered: TcxGridDBColumn;
    TimeAviso: TTimer;
    quHoldsInvoiceCode: TStringField;
    quDeliveryInfoSaleCode: TStringField;
    quDeliveryInfoInvoiceCode: TStringField;
    grdDeliveryDBSaleCode: TcxGridDBColumn;
    grdDeliveryDBInvoiceCode: TcxGridDBColumn;
    btnUpdateHold: TSpeedButton;
    btnUpdateInv: TSpeedButton;
    Label7: TLabel;
    cbsStatus: TComboBox;
    grdHoldDBPreSaleDate: TcxGridDBColumn;
    quPreSaleItemSerialNumber: TBooleanField;
    grdItemDBSaleCode: TcxGridDBColumn;
    grdItemDBInvoiceCode: TcxGridDBColumn;
    quPreSaleItemSaleCode: TStringField;
    quPreSaleItemInvoiceCode: TStringField;
    grdItemDBSalesPerson: TcxGridDBColumn;
    quPreSaleItemAutoServiceNum: TIntegerField;
    quPreSaleItemItemNumber: TStringField;
    quPreSaleItemQty: TFloatField;
    quPreSaleItemPromo: TBooleanField;
    quPreSaleItemSellingPrice: TBCDField;
    quPreSaleItemCupomFiscal: TStringField;
    lblCanceledHold: TLabel;
    quHoldsCanceled: TBooleanField;
    quDeliveryInfoUserDeliver: TStringField;
    grdDeliveryDBUserDeliver: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure grdHoldDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure quHoldsAfterOpen(DataSet: TDataSet);
    procedure btnHistoryClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure quPreSaleItemCalcFields(DataSet: TDataSet);
    procedure TimeAvisoTimer(Sender: TObject);
    procedure edtHoldNumberChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnUpdateHoldClick(Sender: TObject);
    procedure btnUpdateInvClick(Sender: TObject);
    procedure quHoldsAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    sHoldHeader,
    sHoldNum,
    sInvHeader,
    sInvNum : String;

    function GetWhereClause:String;

    procedure CanHideHolds(Hide:Boolean);
    procedure AtivaAviso;
    procedure DesativaAviso;

    procedure OpenHold;
    procedure CloseHold;
    procedure RefreshHold;

    procedure DeliveryOpen;
    procedure DeliveryClose;
    procedure RefreshDelivery;

    procedure CloseAddExpenses;
    procedure OpenAddExpenses;
    procedure RefreshAddExpenses;

    procedure CloseItems;
    procedure OpenItems;
    procedure RefreshItem;

    procedure RefreshCustomer;
    procedure RefreshPayments;
    procedure RefreshHoldInfo;

  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uDM, uDateTimeFunctions, uMsgBox, uMsgConstant, uFrmHistoryManage,
     uPrintReceipt, uInvoicePayment, uSystemConst, uDMGlobal;

{$R *.dfm}

procedure TFrmConsultHold.FormCreate(Sender: TObject);
begin
  inherited;
  SubCustomer.CreateSubList;
  SubPaymentType.CreateSubList;
  CanHideHolds(False);

  DM.imgBTN.GetBitmap(BTN_HISTORY, btnHistory.Glyph);
  DM.imgBTN.GetBitmap(BTN_PRINT, btnPrint.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btnUpdateHold.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btnUpdateInv.Glyph);

  //btnUpdateHold.Visible := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  btnUpdateInv.Visible  := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sHoldHeader := 'Replace Hold # ';
           sHoldNum    := 'New Hold # :';
           sInvHeader  := 'Replace Invoice # ';
           sInvNum     := 'New Invoice # :';
           end;

     LANG_PORTUGUESE :
           begin
           sHoldHeader := 'Atualizar Nº Pedido ';
           sHoldNum    := 'Novo Nº Pedido :';
           sInvHeader  := 'Atualizar Nº Nota ';
           sInvNum     := 'Novo Nº Nota';
           end;

     LANG_SPANISH :
           begin
           sHoldHeader := 'Actualizar Nº Boleta';
           sHoldNum    := 'Nueva Nº Boleta :';
           sInvHeader  := 'Actualizar Nº Factura ';
           sInvNum     := 'Nueva Nº Factura :';
           end;
   end;


end;

procedure TFrmConsultHold.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DeliveryClose;
  CloseAddExpenses;
  CloseItems;
  CloseHold;

  Action := caFree;
end;

function TFrmConsultHold.Start: Boolean;
begin
   DateInicio.Date := Date;
   DateFim.Date := Date;
   cmbStore.LookUpValue := IntToStr(DM.fStore.ID);

   ShowModal;
   Result := True;
end;

procedure TFrmConsultHold.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmConsultHold.CloseHold;
begin
   with quHolds do
     if Active then
        Close;
end;

procedure TFrmConsultHold.OpenHold;
begin
   with quHolds do
     if not Active then
        begin
        CommandText := 'SELECT I.IDPreSale, I.IDInvoice, I.InvoiceDate, I.PreSaleDate, ' +
                       'I.SubTotal-I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0) as TotalInvoice, '+
                       'I.SubTotal-I.ItemDiscount as SubTotal, I.Note, I.Canceled, ' +
                       'I.Tax, I.Layaway, IsNull(I.AditionalExpenses, 0) AS AditionalExpenses, ' +
                       'S.IDStore, S.Name, P.IDPessoa, I.SaleCode, I.InvoiceCode ' +
                       'FROM Invoice I ' +
                       'LEFT OUTER JOIN Store S ON (I.IDStore = S.IDStore) ' +
                       'LEFT OUTER JOIN Pessoa P ON (I.IDCustomer = P.IDPessoa) ' +
                       GetWhereClause;
        Open;
        end;
end;

procedure TFrmConsultHold.RefreshHold;
begin
  CloseHold;
  OpenHold;

  grdHoldDB.DataController.Groups.FullExpand;
  grdHoldDB.DataController.GotoFirst;

end;

function TFrmConsultHold.GetWhereClause:String;
var
 sField, sField1 : String;
begin
   Result := 'I.IDPreSaleParent IS NULL ';

  if (edtHoldNumber.Text <> '') then
     begin
     Result := Result + ' AND I.SaleCode Like ' + QuotedStr('%' + trim(edtHoldNumber.Text) + '%');
     end
  else
     begin
     // filtro por Store
     if cmbStore.LookUpValue <> '' then
       Result := Result + ' AND I.IDStore = ' + cmbStore.LookUpValue
     else
       Result := Result + ' AND I.IDStore IN ('+ DM.fStore.StoreList +') ';

     if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
        begin
         Result := Result + ' AND (I.PreSaleDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            ' I.PreSaleDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39) + ') ';
        end
      else
        begin
          MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
          Exit;
        end;
     end;

  //Customer Options
  Case cbmName.ItemIndex of
      0 : sField := '';
      1 : sField := ' P.PessoaFirstName';
      2 : sField := ' P.PessoaLastName';
      3 : sField := ' P.Pessoa';
   end;

   Case cbmDocs.ItemIndex of
      0 : sField1 := '';
      1 : sField1 := ' P.OrgaoEmissor';
      2 : sField1 := ' P.CartTrabalho';
      3 : sField1 := ' P.CustomerCard';
      4 : sField1 := ' P.CPF';
   end;

  case cbmName.ItemIndex of
    0:; //Todos
    else //Add like
      Result := Result + ' AND ' + sField+ ' Like ' + QuotedStr('%' + trim(edtNames.Text) + '%');
  end;

  case cbmDocs.ItemIndex of
    0: ;//Todos
    else //Add like
      Result := Result + ' AND ' + sField1+ ' Like ' + QuotedStr('%' + trim(edtDocs.Text) + '%');
  end;

  Case cbsStatus.ItemIndex of
    1 : Result := Result + ' AND I.IDInvoice IS NULL ';
    2 : Result := Result + ' AND I.IDInvoice IS NOT NULL ';
  end;

  if Result <> '' then
     Result := 'WHERE ' + Result;

end;

procedure TFrmConsultHold.btnExecClick(Sender: TObject);
begin
  inherited;
  RefreshHold;
  DesativaAviso;
end;

procedure TFrmConsultHold.RefreshCustomer;
begin
  SubCustomer.Param := Format('IDCUSTOMER=%S;ChangeCustomer=%S;', [quHoldsIDPessoa.AsString, '0']);
end;

procedure TFrmConsultHold.RefreshPayments;
begin
  SubPaymentType.Param := 'IDPreSale='+IntToStr(quHoldsIDPreSale.AsInteger)+';'+
                          'ShowDetail=False;Enabled=0;IsNewInvoice=0;';
end;

procedure TFrmConsultHold.RefreshHoldInfo;
begin
   RefreshCustomer;
   RefreshPayments;
   RefreshDelivery;
   RefreshAddExpenses;
   RefreshItem;

   btnUpdateInv.Enabled := ((DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR)
                            and (quHoldsInvoiceCode.AsString <> ''));

end;

procedure TFrmConsultHold.RefreshDelivery;
begin
  DeliveryClose;
  DeliveryOpen;

  grdDeliveryDB.DataController.Groups.FullExpand;
  grdDeliveryDB.DataController.GotoFirst;

end;

procedure TFrmConsultHold.DeliveryClose;
begin
  with quDeliveryInfo do
    if Active then
       Close;
end;

procedure TFrmConsultHold.DeliveryOpen;
begin
  with quDeliveryInfo do
    if not Active then
       begin
       Parameters.ParambyName('IDPreSale1').Value := quHoldsIDPreSale.AsInteger;
       Parameters.ParambyName('IDPreSale').Value  := quHoldsIDPreSale.AsInteger;
       Open;
       end;

end;

procedure TFrmConsultHold.grdHoldDBCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  RefreshHoldInfo;
end;

procedure TFrmConsultHold.quHoldsAfterOpen(DataSet: TDataSet);
var
  bResult : Boolean;
begin
  inherited;
  bResult := DataSet.RecordCount = 1;
  if bResult then
     RefreshHoldInfo;
  CanHideHolds(not bResult);

  btnPrint.Enabled      := (DataSet.RecordCount>0);
  btnHistory.Enabled    := btnPrint.Enabled;
  btnPayments.Enabled   := btnPrint.Enabled;
  //btnUpdateHold.Enabled := btnPrint.Enabled;
end;

procedure TFrmConsultHold.CloseAddExpenses;
begin
   with quAddExpenses do
      if Active then
         Close;
end;

procedure TFrmConsultHold.OpenAddExpenses;
begin
   with quAddExpenses do
      if not Active then
         begin
         Parameters.ParambyName('IDPreSale').Value  := quHoldsIDPreSale.AsInteger;
         Open;
         end;
end;

procedure TFrmConsultHold.RefreshAddExpenses;
begin
  CloseAddExpenses;
  OpenAddExpenses;
end;

procedure TFrmConsultHold.CanHideHolds(Hide: Boolean);
begin
   pnlInvoices.Visible := Hide;
   Splitter1.Visible   := Hide;
end;

procedure TFrmConsultHold.btnHistoryClick(Sender: TObject);
begin
  inherited;

  with TFrmHistoryManage.Create(Self) do
     Start(quHoldsIDPreSale.AsInteger);

end;

procedure TFrmConsultHold.btnPrintClick(Sender: TObject);
begin
  inherited;

  with TPrintReceipt.Create(Self) do
    Start(quHoldsIDPreSale.AsInteger, RECEIPT_TYPE_TICKET);

end;

procedure TFrmConsultHold.btnPaymentsClick(Sender: TObject);
var
  IsInvoice,
  IsLayaway : Boolean;
begin
  inherited;

  IsInvoice := quHoldsIDInvoice.IsNull;
  IsLayaway := quHoldsLayaway.AsBoolean;

  with TInvoicePayment.Create(Self) do
     Start(quHoldsIDPreSale.AsInteger, IsLayaway, IsInvoice);

end;

procedure TFrmConsultHold.CloseItems;
begin
  with quPreSaleItem do
     if Active then
        Close;
end;

procedure TFrmConsultHold.OpenItems;
begin

  with quPreSaleItem do
     if not Active then
        begin
        Parameters.ParambyName('@DocumentID').Value  := quHoldsIDPreSale.AsInteger;
        Parameters.ParambyName('@IsPreSale').Value   := False;
        Parameters.ParambyName('@Date').Value        := Now;
        Open;
        end;

end;

procedure TFrmConsultHold.RefreshItem;
begin
  CloseItems;
  OpenItems;

  grdItemDB.DataController.Groups.FullExpand;
  grdItemDB.DataController.GotoFirst;

end;

procedure TFrmConsultHold.quPreSaleItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPreSaleItemTotalItem.AsFloat := (quPreSaleItemQty.AsFloat*quPreSaleItemSalePrice.AsFloat) - quPreSaleItemDiscount.AsFloat;

  if (quPreSaleItemAutoServiceNum.AsInteger <> 0) then
     quPreSaleItemItemNumber.AsString := quPreSaleItemAutoServiceNum.AsString
  else
     if quPreSaleItemCupomFiscal.AsString = '' then
       quPreSaleItemItemNumber.AsString := quPreSaleItemInvoiceCode.AsString
     else
       quPreSaleItemItemNumber.AsString := quPreSaleItemCupomFiscal.AsString;
end;

procedure TFrmConsultHold.TimeAvisoTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor = True then
     pnlAviso.Color := clNavy
  else
     pnlAviso.ParentColor := True;
end;

procedure TFrmConsultHold.AtivaAviso;
begin
  TimeAviso.Enabled := True;
end;

procedure TFrmConsultHold.DesativaAviso;
begin
  TimeAviso.Enabled := False;
end;

procedure TFrmConsultHold.edtHoldNumberChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TFrmConsultHold.Button2Click(Sender: TObject);
begin
  inherited;
  AtivaAviso;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '<-->';
end;

procedure TFrmConsultHold.btnUpdateHoldClick(Sender: TObject);
var
  sNewNumber : String;
begin
  inherited;
  //Atualiza o Hold
  sNewNumber := InputBox(sHoldHeader + '('+quHoldsSaleCode.AsString+')', sHoldNum, '0');

  with quHolds do
    begin
    if not Active then
       Exit;
    Edit;
    quHoldsSaleCode.AsString := sNewNumber;
    Post;
    end;

end;

procedure TFrmConsultHold.btnUpdateInvClick(Sender: TObject);
var
  sNewNumber : String;
begin
  inherited;
  //Atualiza o Hold
  sNewNumber := InputBox(sInvHeader + '('+quHoldsInvoiceCode.AsString+')', sInvNum, '');

  if sNewNumber <> '' then
    with quHolds do
    begin
      if not Active then
         Exit;
      Edit;
      quHoldsInvoiceCode.AsString := sNewNumber;
      Post;
    end;

end;

procedure TFrmConsultHold.quHoldsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lblCanceledHold.Visible := quHoldsCanceled.AsBoolean;
end;

end.
