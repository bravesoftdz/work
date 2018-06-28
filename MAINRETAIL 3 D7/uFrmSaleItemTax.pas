unit uFrmSaleItemTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ADODB, PowerADOQuery, DateBox, Mask, SuperComboADO, Buttons;

type
  TFrmSaleItemTax = class(TFrmParent)
    pnlBasicFilter: TPanel;
    Label3: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    Label2: TLabel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    cmbStore: TSuperComboADO;
    Button2: TButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    chkInvCalceled: TCheckBox;
    edtHoldNumber: TEdit;
    dsInvoice: TDataSource;
    quInvoice: TPowerADOQuery;
    TimeAviso: TTimer;
    quInvoiceIDPreSale: TIntegerField;
    quInvoiceIDInvoice: TIntegerField;
    quInvoiceInvoiceDate: TDateTimeField;
    quInvoicePreSaleDate: TDateTimeField;
    quInvoiceSaleCode: TStringField;
    quInvoiceInvoiceCode: TStringField;
    quInvoiceIDStore: TIntegerField;
    quInvoiceName: TStringField;
    pnlProducts: TPanel;
    Shape1: TShape;
    Shape2: TShape;
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
    quPreSaleItemIsDelivered: TBooleanField;
    quPreSaleItemSerialNumber: TBooleanField;
    quPreSaleItemSaleCode: TStringField;
    quPreSaleItemInvoiceCode: TStringField;
    dsPreSaleItem: TDataSource;
    Panel4: TPanel;
    grdItem: TcxGrid;
    grdItemDB: TcxGridDBTableView;
    grdItemDBSaleCode: TcxGridDBColumn;
    grdItemDBInvoiceCode: TcxGridDBColumn;
    grdItemDBModel: TcxGridDBColumn;
    grdItemDBDescription: TcxGridDBColumn;
    grdItemDBIsDelivered: TcxGridDBColumn;
    grdItemDBQty: TcxGridDBColumn;
    grdItemDBTotalItem: TcxGridDBColumn;
    cxgrdItem: TcxGridLevel;
    Label1: TLabel;
    pnlInvoices: TPanel;
    Label4: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    Panel5: TPanel;
    grdInvoice: TcxGrid;
    grdInvoiceDB: TcxGridDBTableView;
    grdInvoiceDBName: TcxGridDBColumn;
    grdInvoiceDBInvoiceCode: TcxGridDBColumn;
    grdInvoiceDBInvoiceDate: TcxGridDBColumn;
    grdInvoiceLevel: TcxGridLevel;
    Panel6: TPanel;
    Shape5: TShape;
    Shape6: TShape;
    Label5: TLabel;
    Panel7: TPanel;
    dsTax: TDataSource;
    quTax: TADODataSet;
    quTaxIDInventoryMov: TIntegerField;
    quTaxTax: TBCDField;
    quTaxTaxValue: TBCDField;
    grdItemTax: TcxGrid;
    grdItemTaxDBTableView1: TcxGridDBTableView;
    grdItemTaxLevel1: TcxGridLevel;
    grdItemTaxDBTableView1IDInventoryMov: TcxGridDBColumn;
    grdItemTaxDBTableView1Tax: TcxGridDBColumn;
    grdItemTaxDBTableView1TaxValue: TcxGridDBColumn;
    quTaxIDTaxCategory: TIntegerField;
    btSaveTax: TSpeedButton;
    Panel8: TPanel;
    Shape7: TShape;
    Shape8: TShape;
    lbInvOBD: TLabel;
    Panel9: TPanel;
    gridObs: TcxGrid;
    gridObsDB: TcxGridDBTableView;
    gridObsLevel: TcxGridLevel;
    memObs: TMemo;
    dsInvObs: TDataSource;
    quInvOBS: TPowerADOQuery;
    quInvOBSIDInvoiceOBS: TIntegerField;
    quInvOBSIDPreSale: TIntegerField;
    quInvOBSObsDate: TDateTimeField;
    quInvOBSObs: TStringField;
    gridObsObsDate: TcxGridDBColumn;
    gridObsDBObs: TcxGridDBColumn;
    btnAddObs: TSpeedButton;
    quPreSaleItemQty: TFloatField;
    btDeleteObs: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure TimeAvisoTimer(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure edtHoldNumberChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure grdInvoiceDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure quInvoiceAfterOpen(DataSet: TDataSet);
    procedure grdItemDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure quPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure quPreSaleItemCalcFields(DataSet: TDataSet);
    procedure quTaxTaxValueValidate(Sender: TField);
    procedure quTaxTaxValidate(Sender: TField);
    procedure quTaxAfterPost(DataSet: TDataSet);
    procedure quTaxAfterEdit(DataSet: TDataSet);
    procedure btSaveTaxClick(Sender: TObject);
    procedure btnAddObsClick(Sender: TObject);
    procedure btDeleteObsClick(Sender: TObject);
  private
    isPercent : Boolean;
    procedure AtivaAviso;
    procedure DesativaAviso;

    procedure RefreshInvoiceInfo;

    procedure OpenInvoice;
    procedure CloseInvoice;
    procedure RefreshInvoice;

    procedure OpenObs;
    procedure CloseObs;
    procedure RefreshObs;

    procedure CloseItems;
    procedure OpenItems;
    procedure RefreshItem;

    procedure PostItemTax;
    procedure CloseItemTax;
    procedure OpenItemTax;
    procedure RefreshItemTax;

    function GetWhere : String;

    procedure UpdateTotalTax;
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDateTimeFunctions, uMsgBox, uMsgConstant, uSystemConst, uDMGlobal,
     uSQLFunctions, uNumericFunctions;

{$R *.dfm}

function TFrmSaleItemTax.Start: Boolean;
begin
   DateInicio.Date := Date;
   DateFim.Date := Date;
   cmbStore.LookUpValue := IntToStr(DM.fStore.ID);

   ShowModal;
   Result := True;
end;

procedure TFrmSaleItemTax.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSaleItemTax.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmSaleItemTax.TimeAvisoTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor = True then
     pnlAviso.Color := clNavy
  else
     pnlAviso.ParentColor := True;
end;

procedure TFrmSaleItemTax.AtivaAviso;
begin
  TimeAviso.Enabled := True;
end;

procedure TFrmSaleItemTax.DesativaAviso;
begin
  TimeAviso.Enabled := False;
  pnlAviso.Color := clGray;
end;

procedure TFrmSaleItemTax.btnExecClick(Sender: TObject);
begin
  inherited;
  DesativaAviso;
  RefreshInvoice;
end;

procedure TFrmSaleItemTax.CloseInvoice;
begin
  with quInvoice do
     if Active then
        Close;
end;

procedure TFrmSaleItemTax.OpenInvoice;
begin
  with quInvoice do
   if not Active then
      begin
      CommandText := ChangeWhereClause(CommandText, GetWhere, True);
      Open;
      end;
end;

procedure TFrmSaleItemTax.RefreshInvoice;
begin
  CloseInvoice;
  OpenInvoice;

  RefreshItem;

  grdInvoiceDB.DataController.Groups.FullExpand;
  grdInvoiceDB.DataController.GotoFirst;
end;

function TFrmSaleItemTax.GetWhere: String;
begin

   Result := 'I.IDInvoice Is NOT NULL ';

   if cmbStore.LookUpValue <> '' then
     Result := Result + ' AND I.IDStore = ' + cmbStore.LookUpValue
   else
     Result := Result + ' AND I.IDStore <> 0 ';


  if edtHoldNumber.Text <> '' then
     begin
     Result := Result + ' AND I.InvoiceCode Like ' + QuotedStr('%' + trim(edtHoldNumber.Text) + '%') +
                        ' AND (I.InvoiceDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                        ' I.InvoiceDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39) + ') ';
     end
  else
     begin
     if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
        begin
         Result := Result + ' AND (I.InvoiceDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            ' I.InvoiceDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39) + ') ';
        end
      else
        begin
          MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
          Exit;
        end;
     end;

  if chkInvCalceled.Checked then
     Result := Result + ' AND I.Canceled = 1 '
  else
     Result := Result + ' AND I.Canceled = 0';
     
end;

procedure TFrmSaleItemTax.edtHoldNumberChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TFrmSaleItemTax.Button2Click(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '<-->';
  AtivaAviso;
end;

procedure TFrmSaleItemTax.CloseItems;
begin
  with quPreSaleItem do
     if Active then
        Close;
end;

procedure TFrmSaleItemTax.OpenItems;
begin
  with quPreSaleItem do
     if not Active then
        begin
        Parameters.ParambyName('@DocumentID').Value  := quInvoiceIDPreSale.AsInteger;
        Parameters.ParambyName('@IsPreSale').Value   := False;
        Parameters.ParambyName('@Date').Value        := Now;
        Open;
        end;
end;

procedure TFrmSaleItemTax.RefreshItem;
begin
  CloseItems;
  OpenItems;
end;

procedure TFrmSaleItemTax.grdInvoiceDBCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  RefreshInvoiceInfo;
end;

procedure TFrmSaleItemTax.RefreshInvoiceInfo;
begin
  RefreshItem;
  RefreshObs;
end;

procedure TFrmSaleItemTax.quInvoiceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.RecordCount=1) then
     RefreshInvoiceInfo;
end;

procedure TFrmSaleItemTax.CloseItemTax;
begin
  with quTax do
     if Active then
        Close;
end;

procedure TFrmSaleItemTax.OpenItemTax;
begin
  with quTax do
     if not Active then
        begin
        Parameters.ParamByName('IDInventoryMov').Value := quPreSaleItemIDInventoryMov.AsInteger;
        Open;
        end;
end;

procedure TFrmSaleItemTax.RefreshItemTax;
begin
  CloseItemTax;
  OpenItemTax;
end;

procedure TFrmSaleItemTax.grdItemDBCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  RefreshItemTax;
end;

procedure TFrmSaleItemTax.quPreSaleItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.RecordCount=1) then
     RefreshItemTax;
end;

procedure TFrmSaleItemTax.quPreSaleItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPreSaleItemTotalItem.AsFloat := (quPreSaleItemQty.AsFloat * quPreSaleItemSalePrice.AsFloat) - quPreSaleItemDiscount.AsFloat;
end;

procedure TFrmSaleItemTax.PostItemTax;
begin
  with quTax do
     if Active then
        if State in dsEditModes then
           Post;
end;

procedure TFrmSaleItemTax.quTaxTaxValueValidate(Sender: TField);
begin
  inherited;
  isPercent := False;
end;

procedure TFrmSaleItemTax.quTaxTaxValidate(Sender: TField);
begin
  inherited;
  isPercent := True;
end;

procedure TFrmSaleItemTax.quTaxAfterPost(DataSet: TDataSet);
var
 f : Double;
 sSQL : String;
begin
  inherited;

  if isPercent then
     begin
     f := quTaxTax.NewValue*quPreSaleItemTotalItem.AsCurrency;
     sSQL := 'UPDATE InventoryMovTax SET TaxValue = ' +MyFormatTax(f,'.')+
             ' WHERE IDInventoryMov = ' + quTaxIDInventoryMov.AsString + ' AND '+
             ' IDTaxCategory = ' + quTaxIDTaxCategory.AsString;
     end
  else
    begin
    f := quTaxTaxValue.NewValue/quPreSaleItemTotalItem.AsCurrency;
    sSQL := 'UPDATE InventoryMovTax SET Tax = ' +MyFormatTax(f,'.')+
            ' WHERE IDInventoryMov = ' + quTaxIDInventoryMov.AsString + ' AND '+
            ' IDTaxCategory = ' + quTaxIDTaxCategory.AsString;
    end;
  DM.RunSQL(sSQL);

end;

procedure TFrmSaleItemTax.quTaxAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btSaveTax.Enabled := True;
end;

procedure TFrmSaleItemTax.btSaveTaxClick(Sender: TObject);
begin
  inherited;
  PostItemTax;
  btSaveTax.Enabled := False;
  RefreshItemTax;
  UpdateTotalTax;
end;

procedure TFrmSaleItemTax.UpdateTotalTax;
begin
  if not DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] then
     DM.RunSQL('EXEC sp_PreSale_SubCalcTax '+
                quInvoiceIDPreSale.AsString+', '+
                QuotedStr(FormatDateTime('mm/dd/yyyy',Now)));

end;

procedure TFrmSaleItemTax.CloseObs;
begin
  with quInvOBS do
    if Active then
       Close;
end;

procedure TFrmSaleItemTax.OpenObs;
begin

  with quInvOBS do
    if not Active then
       begin
       Parameters.ParamByName('IDPreSale').Value := quInvoiceIDPreSale.AsInteger;
       Open;
       end;

end;

procedure TFrmSaleItemTax.RefreshObs;
begin
   CloseObs;
   OpenObs;
end;

procedure TFrmSaleItemTax.btnAddObsClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;
  if (quInvoice.Active) and (quInvoiceIDPreSale.AsInteger <> 0) and
     (Trim(memObs.Text) <> '') then
     begin
     sSQL := 'INSERT InvoiceOBS (IDInvoiceOBS, IDPreSale, ObsDate, Obs) ' +
             'VALUES ('+IntToStr(DM.GetNextID(MR_INVOICE_OBS_ID))+','+
                       quInvoiceIDPreSale.AsString+','+
                       QuotedStr(FormatDateTime('mm/dd/yyyy',Now))+','+
                       QuotedStr(memObs.Text)+')';
     DM.RunSQL(sSQL);
     RefreshObs;
     memObs.Clear;
     end;
end;

procedure TFrmSaleItemTax.btDeleteObsClick(Sender: TObject);
Var
  eSql : String;
begin
  inherited;
  if gridObs.IsFocused then
  begin
    if not quInvOBS.IsEmpty then
      if MsgBox(MSG_QST_DELETE, vbYesNo + vbCritical) = vbYes then
      begin
        eSql := 'DELETE InvoiceOBS WHERE IDInvoiceOBS = ' +
                QuotedStr(quInvOBSIDInvoiceOBS.AsString) +
                ' AND (IDCFOP IS NOT NULL) AND (IDPessoaTax IS NOT NULL)';
        DM.RunSQL(eSql);
        RefreshObs;
      end;
    end
  else
    MsgBox(MSG_CRT_ERROR_DELETING, vbOKOnly + vbCritical)
end;

end.
