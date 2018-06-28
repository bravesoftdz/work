unit uFrmTeleMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ADODB, uFrmPessoaHistory, Mask, SuperComboADO, TeEngine, Series,
  TeeProcs, Chart, DbChart, DBClient, Provider;

const
  FILTERTYPE_CUSTOMER = 0;
  FILTERTYPE_PERSONALIZED = 1;

type
  TFrmTeleMarketing = class(TFrmParent)
    pnlCustomer: TPanel;
    pnlHistory: TPanel;
    Panel5: TPanel;
    pnlObs: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel7: TPanel;
    grdCustomer: TcxGrid;
    grdCustomerDB: TcxGridDBTableView;
    grdCustomerLevel: TcxGridLevel;
    pnlFilter: TPanel;
    shpItems: TShape;
    Shape2: TShape;
    quCustomer: TADODataSet;
    dsCustomer: TDataSource;
    quCustomerIDPessoa: TIntegerField;
    quCustomerFullName: TStringField;
    quCustomerIDTipoPessoa: TIntegerField;
    quCustomerIDStore: TIntegerField;
    quCustomerNomeJuridico: TStringField;
    quCustomerEndereco: TStringField;
    quCustomerCidade: TStringField;
    quCustomerCEP: TStringField;
    quCustomerPais: TStringField;
    quCustomerPhone: TStringField;
    quCustomerCell: TStringField;
    quCustomerPCode: TStringField;
    quCustomerCCode: TStringField;
    quCustomerFax: TStringField;
    quCustomerBeeper: TStringField;
    quCustomerContato: TStringField;
    quCustomerEmail: TStringField;
    quCustomerOBS: TStringField;
    quCustomerJuridico: TBooleanField;
    quCustomerTotalMovimentado: TBCDField;
    quCustomerLimite: TBCDField;
    quCustomerNascimento: TDateTimeField;
    quCustomerIDEstado: TStringField;
    quCustomerDiaQuitacao: TIntegerField;
    quCustomerIDPessoaBoss: TIntegerField;
    quCustomerIDTipoPessoaFilho: TIntegerField;
    quCustomerIDRamoAtividade: TIntegerField;
    quCustomerCPF: TStringField;
    quCustomerCGC: TStringField;
    quCustomerIdentidade: TStringField;
    quCustomerCartTrabalho: TStringField;
    quCustomerInscEstadual: TStringField;
    quCustomerInscMunicipal: TStringField;
    quCustomerContatos: TStringField;
    quCustomerNumAtrasos: TIntegerField;
    quCustomerDiasAtraso: TIntegerField;
    quCustomerNumTransacoes: TIntegerField;
    quCustomerHomePage: TStringField;
    quCustomerOrgaoEmissor: TStringField;
    quCustomerBairro: TStringField;
    quCustomerNumMovimentacoes: TIntegerField;
    quCustomerSystem: TBooleanField;
    quCustomerDesativado: TIntegerField;
    quCustomerHidden: TIntegerField;
    quCustomerComissaoSobreGuia: TBCDField;
    quCustomerDescontaCoordenacao: TBooleanField;
    quCustomerAjusteComiss: TBCDField;
    quCustomerIDUser: TIntegerField;
    quCustomerShortName: TStringField;
    quCustomerShort_Name: TStringField;
    quCustomerCode: TIntegerField;
    quCustomerIDTipoPessoaRoot: TIntegerField;
    quCustomerIDPais: TIntegerField;
    quCustomerPessoaLastName: TStringField;
    quCustomerCustomerCard: TStringField;
    quCustomerPessoaFirstName: TStringField;
    quCustomerUserCode: TStringField;
    quCustomerCartMotorista: TStringField;
    quCustomerDataExpedicao: TDateTimeField;
    grdCustomerDBFullName: TcxGridDBColumn;
    grdCustomerDBPhone: TcxGridDBColumn;
    grdCustomerDBCell: TcxGridDBColumn;
    grdCustomerDBEmail: TcxGridDBColumn;
    Panel6: TPanel;
    grdHistory: TcxGrid;
    grdHistoryDB: TcxGridDBTableView;
    grdHistoryDBSystemUser: TcxGridDBColumn;
    grdHistoryDBPessoaHistoryType: TcxGridDBColumn;
    grdHistoryDBPessoaHistoryResult: TcxGridDBColumn;
    grdHistoryDBMovDate: TcxGridDBColumn;
    grdHistoryDBObs: TcxGridDBColumn;
    grdHistoryLevel: TcxGridLevel;
    quCHistory: TADODataSet;
    quCHistoryIDPessoaHistory: TIntegerField;
    quCHistoryIDPessoa: TIntegerField;
    quCHistoryIDUser: TIntegerField;
    quCHistoryIDPessoaHistoryType: TIntegerField;
    quCHistoryIDPessoaHistoryResult: TIntegerField;
    quCHistoryMovDate: TDateTimeField;
    quCHistoryObs: TStringField;
    quCHistorySystemUser: TStringField;
    quCHistoryPessoaHistoryType: TStringField;
    quCHistoryPessoaHistoryResult: TStringField;
    dsCHistory: TDataSource;
    gridFilter: TcxGrid;
    gridFilterView: TcxGridDBTableView;
    gridFilterLevel: TcxGridLevel;
    dsFilter: TDataSource;
    quFilter: TADODataSet;
    quFilterIDTelemarketingFilter: TIntegerField;
    quFilterFilterName: TStringField;
    quFilterFilterValues: TMemoField;
    quFilterSQL: TMemoField;
    gridFilterViewFilterName: TcxGridDBColumn;
    quCustomerAPhone: TStringField;
    quCustomerACel: TStringField;
    Panel9: TPanel;
    btnAdd: TSpeedButton;
    btnOpenFilter: TSpeedButton;
    btDelFilter: TSpeedButton;
    btnExecute: TSpeedButton;
    btnEditCustomer: TSpeedButton;
    grdProducts: TcxGrid;
    grdProductsView: TcxGridDBTableView;
    grdProductsLevel: TcxGridLevel;
    quSaleItems: TADODataSet;
    dsSaleItems: TDataSource;
    quSaleItemsCostPrice: TBCDField;
    quSaleItemsSalePrice: TBCDField;
    quSaleItemsDiscount: TBCDField;
    quSaleItemsQty: TFloatField;
    quSaleItemsModel: TStringField;
    quSaleItemsDescription: TStringField;
    quSaleItemsSubCategory: TStringField;
    quSaleItemsMGroup: TStringField;
    quSaleItemsCategory: TStringField;
    quSaleItemsIDModel: TIntegerField;
    quSaleItemsExtSalePrice: TCurrencyField;
    grdProductsViewModel: TcxGridDBColumn;
    grdProductsViewDescription: TcxGridDBColumn;
    grdProductsViewCategory: TcxGridDBColumn;
    grdProductsViewSubCategory: TcxGridDBColumn;
    grdProductsViewMGroup: TcxGridDBColumn;
    grdProductsViewQty: TcxGridDBColumn;
    grdProductsViewSalePrice: TcxGridDBColumn;
    Panel8: TPanel;
    Panel10: TPanel;
    pnlItemFilter: TPanel;
    btnExec: TSpeedButton;
    Label4: TLabel;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    Label2: TLabel;
    scCategory: TSuperComboADO;
    btCategoryAll: TButton;
    lbSubCategory: TLabel;
    scSubCategory: TSuperComboADO;
    btnSubCateAll: TButton;
    lbGroup: TLabel;
    scGroup: TSuperComboADO;
    btnMGroupAll: TButton;
    Label1: TLabel;
    scVendor: TSuperComboADO;
    btnVendorAll: TButton;
    DBChart1: TDBChart;
    Series1: TPieSeries;
    quCategory: TADODataSet;
    dsCategory: TDataSource;
    quCategorySalePrice: TFloatField;
    quCategoryCategory: TStringField;
    Splitter3: TSplitter;
    grdSellItems: TcxGrid;
    grdSellItemsView: TcxGridDBTableView;
    grdSellItemsLevel: TcxGridLevel;
    quModelSell: TADODataSet;
    dsModelSell: TDataSource;
    quModelSellIDModel: TIntegerField;
    quModelSellModel: TStringField;
    quModelSellDescription: TStringField;
    quModelSellPromotionPrice: TBCDField;
    quModelSellModelPrice: TBCDField;
    quModelSellStoreSellingPrice: TBCDField;
    quModelSellQtyOnHand: TFloatField;
    quModelSellManufacture: TStringField;
    quModelSellCategory: TStringField;
    quModelSellCatSubGroup: TStringField;
    quModelSellVendor: TStringField;
    quModelSellFinalPrice: TCurrencyField;
    grdSellItemsViewModel: TcxGridDBColumn;
    grdSellItemsViewDescription: TcxGridDBColumn;
    grdSellItemsViewPromotionPrice: TcxGridDBColumn;
    grdSellItemsViewQtyOnHand: TcxGridDBColumn;
    grdSellItemsViewCategory: TcxGridDBColumn;
    grdSellItemsViewVendor: TcxGridDBColumn;
    grdSellItemsViewFinalPrice: TcxGridDBColumn;
    pnlCreateHold: TPanel;
    Label3: TLabel;
    scCustomer: TSuperComboADO;
    Label5: TLabel;
    scMedia: TSuperComboADO;
    cbxSaleHistory: TComboBox;
    cdsPreInvMov: TClientDataSet;
    dsPreInvMov: TDataSource;
    gridSaleItems: TcxGrid;
    gridSaleItemsView: TcxGridDBTableView;
    gridSaleItemsLevel: TcxGridLevel;
    cdsPreInvMovID: TIntegerField;
    cdsPreInvMovIDModel: TIntegerField;
    cdsPreInvMovIDStore: TIntegerField;
    cdsPreInvMovModel: TStringField;
    cdsPreInvMovDescription: TStringField;
    cdsPreInvMovQty: TFloatField;
    cdsPreInvMovSalePrice: TCurrencyField;
    cdsPreInvMovCostPrice: TCurrencyField;
    cdsPreInvMovIDUser: TIntegerField;
    cdsPreInvMovIDCustomer: TIntegerField;
    gridSaleItemsViewModel: TcxGridDBColumn;
    gridSaleItemsViewQty: TcxGridDBColumn;
    gridSaleItemsViewSalePrice: TcxGridDBColumn;
    gridSaleItemsViewDescription: TcxGridDBColumn;
    pnlCreateSale: TPanel;
    btnCreateHold: TSpeedButton;
    quModelSellStoreCostPrice: TBCDField;
    quModelSellModelCost: TBCDField;
    quModelSellFinalCost: TCurrencyField;
    Label6: TLabel;
    edtTotal: TEdit;
    cdsPreInvMovItemTotal: TCurrencyField;
    gridSaleItemsViewItemTotal: TcxGridDBColumn;
    btnNewHold: TSpeedButton;
    btnDeleteItem: TSpeedButton;
    quSaleItemDetail: TADODataSet;
    dsSaleItemDetail: TDataSource;
    quSaleItemDetailMovDate: TDateTimeField;
    quSaleItemDetailCostPrice: TBCDField;
    quSaleItemDetailSalePrice: TBCDField;
    quSaleItemDetailDiscount: TBCDField;
    quSaleItemDetailQty: TFloatField;
    quSaleItemDetailIDModel: TIntegerField;
    quSaleItemDetailModel: TStringField;
    quSaleItemDetailDescription: TStringField;
    quSaleItemDetailSubCategory: TStringField;
    quSaleItemDetailMGroup: TStringField;
    quSaleItemDetailCategory: TStringField;
    quSaleItemsMovDate: TDateTimeField;
    quSaleItemDetailExtSalePrice: TCurrencyField;
    grdProductsViewMovDate: TcxGridDBColumn;
    grdProductsViewExtSalePrice: TcxGridDBColumn;
    quSaleItemDetailIDInventoryMov: TIntegerField;
    cdsPreInvMovDiscount: TCurrencyField;
    chkLayaway: TCheckBox;
    cdsCustomer: TClientDataSet;
    dspCustomer: TDataSetProvider;
    btnStartCall: TSpeedButton;
    btnEndCall: TSpeedButton;
    grdCustomerDBPType: TcxGridDBColumn;
    grdCustomerDBPResult: TcxGridDBColumn;
    grdCustomerDBColor: TcxGridDBColumn;
    quCustomerIDPessoaHistory: TIntegerField;
    quCustomerPType: TStringField;
    quCustomerPResult: TStringField;
    quCustomerResultColor: TStringField;
    quCustomerIDPessoaHistoryType: TIntegerField;
    quCustomerIDPessoaHistoryResult: TIntegerField;
    quCustomerMovDate: TDateTimeField;
    grdCustomerDBMovDate: TcxGridDBColumn;
    Label7: TLabel;
    scCustomerList: TSuperComboADO;
    Label8: TLabel;
    btnClear: TSpeedButton;
    btnEmail: TSpeedButton;
    btnReport: TSpeedButton;
    btnMessage: TSpeedButton;
    btnConfigureLabel: TSpeedButton;
    btnSendEmail: TSpeedButton;
    quCustomerEstado: TStringField;
    procedure btAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnStartCallClick(Sender: TObject);
    procedure btnEndCallClick(Sender: TObject);
    procedure btOpenFilterClick(Sender: TObject);
    procedure quFilterAfterOpen(DataSet: TDataSet);
    procedure btnExecuteClick(Sender: TObject);
    procedure quCustomerCalcFields(DataSet: TDataSet);
    procedure quCustomerAfterOpen(DataSet: TDataSet);
    procedure btnEditCustomerClick(Sender: TObject);
    procedure quSaleItemsCalcFields(DataSet: TDataSet);
    procedure grdCustomerDBDblClick(Sender: TObject);
    procedure quModelSellCalcFields(DataSet: TDataSet);
    procedure btnExecClick(Sender: TObject);
    procedure btCategoryAllClick(Sender: TObject);
    procedure btnSubCateAllClick(Sender: TObject);
    procedure btnMGroupAllClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnVendorAllClick(Sender: TObject);
    procedure cbxSaleHistoryChange(Sender: TObject);
    procedure grdSellItemsViewDblClick(Sender: TObject);
    procedure cdsPreInvMovCalcFields(DataSet: TDataSet);
    procedure cdsPreInvMovAfterPost(DataSet: TDataSet);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure btnNewHoldClick(Sender: TObject);
    procedure quSaleItemDetailCalcFields(DataSet: TDataSet);
    procedure btnCreateHoldClick(Sender: TObject);
    procedure btDelFilterClick(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure grdCustomerDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure scCustomerListSelectItem(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfigureLabelClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure cdsCustomerAfterScroll(DataSet: TDataSet);
    procedure btnSendEmailClick(Sender: TObject);
  private
    FFirstName,
    FLastName,
    FZipCode: String;
    FCustomerSQL: String;
    FFilter: String;
    FIDHistory: Integer;
    FFilterType: Integer;
    FFrmPessoaHistory : TFrmPessoaHistory;

    procedure FilterCustomer(Filter:Boolean);

    function ValidateInvoice:Boolean;

    procedure FinalyzeHold;

    procedure SetInvoiceCustomer(IDCustomer:Integer; FName, LName, Zip : String);
    procedure CalcInvoiceTotal;
    procedure AddInvoiceItem;
    procedure NewHold;

    procedure CustomerRefresh(sFilter : String);
    procedure CustomerOpen(sFilter : String);
    procedure CustomerClose;

    procedure CustomerHistoryRefresh;
    procedure CustomerHistoryOpen;
    procedure CustomerHistoryClose;

    procedure SaleItemRefresh;
    procedure SaleItemClose;
    procedure SaleItemOpen;

    procedure FilterRefresh;
    procedure FilterOpen;
    procedure FilterClose;

    procedure ModelSellingRefresh;
    procedure ModelSellingOpen;
    procedure ModelSellingClose;

  public
    function Start:Boolean;
  end;

implementation

uses uDM, uFrmTelemarketingFilter, uSqlFunctions, uFchPessoa, uSystemTypes,
     uMsgBox, uMsgConstant, uSystemConst, uFrmUserMessager, uFrmEmailBuilder,
     uFrmPrintCustomerLabel;

{$R *.dfm}

{ TFrmTeleMarketing }

function TFrmTeleMarketing.Start: Boolean;
begin
  FilterRefresh;
  scMedia.LookUpValue := '9';
  cbxSaleHistory.ItemIndex := 0;
  cdsPreInvMov.CreateDataSet;
  chkLayaway.Checked := (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE);
  FIDHistory := -1;
  FCustomerSQL := quCustomer.CommandText;
  ShowModal;
  Result := (ModalResult = mrOK);
end;

procedure TFrmTeleMarketing.btAddClick(Sender: TObject);
begin
  inherited;
  with TFrmTelemarketingFilter.Create(Self) do
     if Start(-1) then
       FilterRefresh;
end;

procedure TFrmTeleMarketing.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if FIDHistory <> -1 then
  begin
    MsgBox(MSG_INF_END_CALL_BEFORE_CLOSE, vbOKOnly + vbCritical);
    Action := caNone;
  end
  else
  begin
    CustomerClose;
    FreeAndNil(FFrmPessoaHistory);
    Action := caFree;
  end;
end;

procedure TFrmTeleMarketing.CustomerClose;
begin
  with cdsCustomer do
    if Active then
      Close;
end;

procedure TFrmTeleMarketing.CustomerOpen(sFilter : String);
var
 sSQL : String;
begin

  sSQL := FCustomerSQL + ' WHERE ' + sFilter;

  with cdsCustomer do
    if not Active then
    begin
      quCustomer.CommandText := sSQL;
      Open;
    end;

end;

procedure TFrmTeleMarketing.CustomerRefresh(sFilter : String);
begin
  CustomerClose;
  CustomerOpen(sFilter);
end;

procedure TFrmTeleMarketing.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnNewHold.Glyph);

  DM.imgSmall.GetBitmap(BTN18_OPEN, btnOpenFilter.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnEditCustomer.Glyph);

  DM.imgSmall.GetBitmap(BTN18_DELETE, btDelFilter.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDeleteItem.Glyph);


  FFrmPessoaHistory := TFrmPessoaHistory.Create(Self);
  
end;

procedure TFrmTeleMarketing.CustomerHistoryClose;
begin
  with quCHistory do
    if Active then
      Close;
end;

procedure TFrmTeleMarketing.CustomerHistoryOpen;
begin
  with quCHistory do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := cdsCustomer.FieldByName('IDPessoa').AsInteger;
      Open;
      grdHistoryDB.DataController.Groups.FullExpand;  
    end;
end;

procedure TFrmTeleMarketing.CustomerHistoryRefresh;
begin
  CustomerHistoryClose;
  CustomerHistoryOpen;
end;

procedure TFrmTeleMarketing.btnStartCallClick(Sender: TObject);
begin
  inherited;
  if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
    if FFrmPessoaHistory.Start(cdsCustomer.FieldByName('IDPessoa').AsInteger, -1, FIDHistory) then
    begin
      CustomerHistoryRefresh;
      FilterCustomer(True);
      SetInvoiceCustomer(cdsCustomer.FieldByName('IDPessoa').AsInteger,
                         cdsCustomer.FieldByName('PessoaLastName').AsString,
                         cdsCustomer.FieldByName('PessoaFirstName').AsString,
                         cdsCustomer.FieldByName('CEP').AsString);

      if FFilterType = FILTERTYPE_CUSTOMER then
        CustomerRefresh('P.IDPessoa = ' + scCustomerList.LookUpValue)
      else
        CustomerRefresh(quFilterSQL.AsString);

      btnEditCustomer.Enabled := False;
    end;
end;

procedure TFrmTeleMarketing.btnEndCallClick(Sender: TObject);
begin
  inherited;
  if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
    if quCHistory.Active and (quCHistory.RecordCount > 0) then
      if FFrmPessoaHistory.Start(cdsCustomer.FieldByName('IDPessoa').AsInteger, FIDHistory, FIDHistory) then
      begin
        CustomerHistoryRefresh;
        FilterCustomer(False);

        if FFilterType = FILTERTYPE_CUSTOMER then
          CustomerRefresh('P.IDPessoa = ' + scCustomerList.LookUpValue)
        else
          CustomerRefresh(quFilterSQL.AsString);

        btnEditCustomer.Enabled := True;
      end;
end;

procedure TFrmTeleMarketing.FilterClose;
begin
  with quFilter do
    if Active then
      Close;
end;

procedure TFrmTeleMarketing.FilterOpen;
begin
  with quFilter do
    if not Active then
      Open;
end;

procedure TFrmTeleMarketing.FilterRefresh;
begin
  FilterClose;
  FilterOpen;
end;

procedure TFrmTeleMarketing.btOpenFilterClick(Sender: TObject);
var
 IDFilter : Integer;
begin
  inherited;

  IDFilter := quFilterIDTelemarketingFilter.AsInteger;

  with TFrmTelemarketingFilter.Create(Self) do
    if Start(IDFilter) then
      FilterRefresh;
end;

procedure TFrmTeleMarketing.quFilterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnOpenFilter.Enabled := (quFilter.RecordCount > 0);
  btDelFilter.Enabled  := (quFilter.RecordCount > 0);
end;

procedure TFrmTeleMarketing.btnExecuteClick(Sender: TObject);
begin
  inherited;
  if quFilter.Active and (quFilter.RecordCount > 0 ) and (FIDHistory = -1) then
  begin
    FFilterType := FILTERTYPE_PERSONALIZED;
    FFilter := quFilterSQL.AsString;
    CustomerRefresh(FFilter);
  end;
end;

procedure TFrmTeleMarketing.quCustomerCalcFields(DataSet: TDataSet);

begin
  inherited;
  quCustomerAPhone.AsString := quCustomerPCode.AsString + ' ' + quCustomerPhone.AsString;
  quCustomerACel.AsString   := quCustomerCCode.AsString + ' ' + quCustomerCell.AsString;
end;

procedure TFrmTeleMarketing.quCustomerAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnEditCustomer.Enabled := (DataSet.RecordCount > 0 );
end;

procedure TFrmTeleMarketing.btnEditCustomerClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;

  if (cdsCustomer.Active) or (not cdsCustomer.IsEmpty) then
    with TFchPessoa.Create(Self) do
      begin
      sParam := 'IDTipoPessoa=1;';
      if scCustomerList.LookUpValue = '' then
        PosID1 := cdsCustomer.FieldByName('IDPessoa').AsString
      else
        PosID1 := scCustomerList.LookUpValue;
      if Start(btAlt, nil, False, PosID1, PosID2, nil) then
        if quFilter.Active and (not quFilter.IsEmpty) then
          CustomerRefresh(quFilterSQL.AsString);
      Free;
      end;
end;

procedure TFrmTeleMarketing.quSaleItemsCalcFields(DataSet: TDataSet);
begin
  inherited;
  quSaleItemsExtSalePrice.AsCurrency := quSaleItemsSalePrice.AsCurrency -
                                        quSaleItemsDiscount.AsCurrency;
end;

procedure TFrmTeleMarketing.SaleItemClose;
begin

  with quSaleItems do
    if Active then
      Close;

  with quSaleItemDetail do
    if Active then
      Close;

  with quCategory do
    if Active then
      Close;

end;

procedure TFrmTeleMarketing.SaleItemOpen;
begin

  if cbxSaleHistory.ItemIndex = 1 then
  begin
    grdProductsView.DataController.DataSource    := dsSaleItems;
    grdProductsView.DataController.KeyFieldNames := 'IDModel';
    grdProductsViewMovDate.Visible               := False;
    grdProductsViewExtSalePrice.Visible          := False;
    grdProductsViewSalePrice.Visible             := True;

    with quSaleItems do
      if not Active then
        if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
        begin
          Parameters.ParamByName('IDPessoa').Value := cdsCustomer.FieldByName('IDPessoa').AsInteger;
          Parameters.ParamByName('IDStore').Value  := DM.fStore.ID;
          Open;
        end;
  end
  else
  begin
    grdProductsView.DataController.DataSource    := dsSaleItemDetail;
    grdProductsView.DataController.KeyFieldNames := 'IDInventoryMov';
    grdProductsViewMovDate.Visible               := True;
    grdProductsViewExtSalePrice.Visible          := True;
    grdProductsViewSalePrice.Visible             := False;

    with quSaleItemDetail do
      if not Active then
        if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
        begin
          Parameters.ParamByName('IDPessoa').Value := cdsCustomer.FieldByName('IDPessoa').AsInteger;
          Parameters.ParamByName('IDStore').Value  := DM.fStore.ID;
          Open;
        end;
  end;

  with quCategory do
    if not Active then
      if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
      begin
        Parameters.ParamByName('IDPessoa').Value := cdsCustomer.FieldByName('IDPessoa').AsInteger;
        Parameters.ParamByName('IDStore').Value  := DM.fStore.ID;
        Open;
      end;


end;

procedure TFrmTeleMarketing.SaleItemRefresh;
begin
  if pnlHistory.Visible then
  begin
    SaleItemClose;
    SaleItemOpen;
  end;
end;

procedure TFrmTeleMarketing.grdCustomerDBDblClick(Sender: TObject);
begin
  inherited;
  if (cdsCustomer.Active) and (cdsCustomer.RecordCount > 0) then
  begin
    SetInvoiceCustomer(cdsCustomer.FieldByName('IDPessoa').AsInteger,
                       cdsCustomer.FieldByName('PessoaLastName').AsString,
                       cdsCustomer.FieldByName('PessoaFirstName').AsString,
                       cdsCustomer.FieldByName('CEP').AsString);
    CustomerHistoryRefresh;
    SaleItemRefresh;
  end;
end;

procedure TFrmTeleMarketing.quModelSellCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quModelSellStoreSellingPrice.AsCurrency <> 0 then
    quModelSellFinalPrice.AsCurrency := quModelSellStoreSellingPrice.AsCurrency
  else
    quModelSellFinalPrice.AsCurrency := quModelSellModelPrice.AsCurrency;

  if quModelSellStoreCostPrice.AsCurrency <> 0 then
    quModelSellFinalCost.AsCurrency := quModelSellStoreCostPrice.AsCurrency
  else
    quModelSellFinalCost.AsCurrency := quModelSellModelCost.AsCurrency;
     
end;

procedure TFrmTeleMarketing.ModelSellingClose;
begin
  with quModelSell do
    if Active then
      Close;
end;

procedure TFrmTeleMarketing.ModelSellingOpen;
var
 sSQL, sFilter : String;
begin

  sFilter := ' I.StoreID = ' + IntToStr(DM.fStore.ID);

  if scCategory.LookUpValue <> '' then
   sFilter := sFilter + ' AND M.GroupID = ' + scCategory.LookUpValue;

  if scSubCategory.LookUpValue <> '' then
   sFilter := sFilter + ' AND M.IDModelGroup = ' + scSubCategory.LookUpValue;

  if scGroup.LookUpValue <> '' then
   sFilter := sFilter + ' AND M.IDModelSubGroup = ' + scGroup.LookUpValue;

  if scFabricante.LookUpValue <> '' then
   sFilter := sFilter + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

  if scVendor.LookUpValue <> '' then
   sFilter := sFilter + ' AND MV.IDPessoa = ' + scVendor.LookUpValue;

  with quModelSell do
    if not Active then
    begin
      sSQL        := ChangeWhereClause(CommandText, sFilter, True);
      CommandText := sSQL;
      Open;
    end;

end;

procedure TFrmTeleMarketing.ModelSellingRefresh;
begin
  ModelSellingClose;
  ModelSellingOpen;
end;

procedure TFrmTeleMarketing.btnExecClick(Sender: TObject);
begin
  inherited;
  ModelSellingRefresh;
end;

procedure TFrmTeleMarketing.btCategoryAllClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text        := '<->';
end;

procedure TFrmTeleMarketing.btnSubCateAllClick(Sender: TObject);
begin
  inherited;
  scSubCategory.LookUpValue := '';
  scSubCategory.Text        := '<->';
end;

procedure TFrmTeleMarketing.btnMGroupAllClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text        := '<->';
end;

procedure TFrmTeleMarketing.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text        := '<->';
end;

procedure TFrmTeleMarketing.btnVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text        := '<->';
end;

procedure TFrmTeleMarketing.SetInvoiceCustomer(IDCustomer: Integer;
   FName, LName, Zip : String);
begin

  with cdsPreInvMov do
    if Active then
      if (not IsEmpty) and (scCustomer.LookUpValue <> IntToStr(IDCustomer)) then
        if MsgBox(MSG_QST_CHANGE_CUSTOMER, vbQuestion + vbYesNo) = vbYes then
          NewHold
        else
          Exit;

  scCustomer.LookUpValue := IntToStr(IDCustomer);
  FFirstName             := FName;
  FLastName              := LName;
  FZipCode               := Zip;

end;

procedure TFrmTeleMarketing.cbxSaleHistoryChange(Sender: TObject);
begin
  inherited;

  if cbxSaleHistory.ItemIndex = 0 then
  begin
    shpItems.Visible   := False;
    pnlHistory.Visible := False;
    SaleItemClose;
  end
  else
  begin
    shpItems.Visible   := True;
    pnlHistory.Visible := True;
    if (cdsCustomer.Active) and (cdsCustomer.RecordCount > 0) then
    begin
      SetInvoiceCustomer(cdsCustomer.FieldByName('IDPessoa').AsInteger,
                       cdsCustomer.FieldByName('PessoaLastName').AsString,
                       cdsCustomer.FieldByName('PessoaFirstName').AsString,
                       cdsCustomer.FieldByName('CEP').AsString);
      SaleItemRefresh;
    end;
  end;
end;

procedure TFrmTeleMarketing.grdSellItemsViewDblClick(Sender: TObject);
begin
  inherited;
  AddInvoiceItem;
end;

procedure TFrmTeleMarketing.CalcInvoiceTotal;
var
  TotalAmount : Currency;
begin
  TotalAmount := 0;
  with cdsPreInvMov do
   if Active then
     try
       DisableControls;
       First;
       While not EOF do
       begin
         TotalAmount := TotalAmount + cdsPreInvMovItemTotal.AsCurrency;
         Next;
       end;
       finally
       EnableControls;
       end;

  edtTotal.Text := FormatFloat('#,##0.00', TotalAmount);
end;

procedure TFrmTeleMarketing.AddInvoiceItem;
begin

  if ValidateInvoice then
    with quModelSell do
    if Active and (not IsEmpty) then
      begin
      if not cdsPreInvMov.Active then
        cdsPreInvMov.Open;
      try
        cdsPreInvMov.Append;
        cdsPreInvMov.FieldByName('ID').AsInteger         := (cdsPreInvMov.RecordCount + 1);
        cdsPreInvMov.FieldByName('IDModel').AsInteger    := quModelSellIDModel.AsInteger;
        cdsPreInvMov.FieldByName('IDStore').AsInteger    := DM.fStore.ID;
        cdsPreInvMov.FieldByName('IDUser').AsInteger     := DM.fUser.ID;
        cdsPreInvMov.FieldByName('IDCustomer').AsInteger := StrToInt(scCustomer.LookUpValue);
        cdsPreInvMov.FieldByName('Model').AsString       := quModelSellModel.AsString;
        cdsPreInvMov.FieldByName('Description').AsString := quModelSellDescription.AsString;
        cdsPreInvMov.FieldByName('Qty').AsFloat          := 1;
        if quModelSellPromotionPrice.AsCurrency <> 0 then
          cdsPreInvMov.FieldByName('SalePrice').AsCurrency := quModelSellPromotionPrice.AsCurrency
        else
          cdsPreInvMov.FieldByName('SalePrice').AsCurrency := quModelSellFinalPrice.AsCurrency;
        cdsPreInvMov.FieldByName('CostPrice').AsCurrency := quModelSellFinalCost.AsCurrency;
        cdsPreInvMov.FieldByName('Discount').AsCurrency  := 0;
        cdsPreInvMov.Post;
      except
        cdsPreInvMov.Cancel;
        end;
      end;
end;

procedure TFrmTeleMarketing.cdsPreInvMovCalcFields(DataSet: TDataSet);
begin
  inherited;
  cdsPreInvMovItemTotal.AsCurrency := cdsPreInvMovQty.AsFloat *
                                      cdsPreInvMovSalePrice.AsCurrency;
end;

procedure TFrmTeleMarketing.cdsPreInvMovAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcInvoiceTotal;
end;

procedure TFrmTeleMarketing.btnDeleteItemClick(Sender: TObject);
begin
  inherited;
  with cdsPreInvMov do
    if Active and (not IsEmpty) then
    begin
       cdsPreInvMov.Edit;
       cdsPreInvMov.Delete;
       CalcInvoiceTotal;
    end;
end;

procedure TFrmTeleMarketing.btnNewHoldClick(Sender: TObject);
begin
  inherited;
  NewHold;
end;

function TFrmTeleMarketing.ValidateInvoice: Boolean;
begin
  Result := True;

  if scCustomer.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbCritical);
    Result := False;
  end;

  if scMedia.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_MEDIA, vbOKOnly + vbCritical);
    Result := False;
  end;

end;

procedure TFrmTeleMarketing.quSaleItemDetailCalcFields(DataSet: TDataSet);
begin
  inherited;
  quSaleItemDetailExtSalePrice.AsCurrency := (quSaleItemDetailQty.AsFloat *
                                             quSaleItemDetailSalePrice.AsCurrency) -
                                             quSaleItemDetailDiscount.AsCurrency;
end;

procedure TFrmTeleMarketing.NewHold;
begin
  with cdsPreInvMov do
   if Active then
     try
       DisableControls;
       First;
       While not EOF do
       begin
         cdsPreInvMov.Edit;
         cdsPreInvMov.Delete;
       end;
       finally
         EnableControls;
         CalcInvoiceTotal
         end;
end;

procedure TFrmTeleMarketing.FinalyzeHold;
var
  IDPreSale,
  iError,
  IDPreInventMov : Integer;
  SaleCode  : String;
begin
   if ValidateInvoice and (cdsPreInvMov.Active and (not cdsPreInvMov.IsEmpty)) then
   begin

      DM.fPOS.CreateHold(DELIVER_TYPE_ONHAND,
                         chkLayaway.Checked,//Layaway
                         DM.fStore.ID,    //IDStore
                         '',              //FirstName
                         '',              //LastName
                         '',              //ZipCode
                         0,               //TrouFroup
                         Now,             //Date
                         StrToInt(scCustomer.LookUpValue),
                         StrToInt(scMedia.LookUpValue),
                         0,               //Other Commis
                         '',              //Obs
                         IDPreSale);

      if DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] then
        DM.fPOS.ExemptTax(IDPreSale, True);

      SaleCode := DM.fPOS.CreateSaleCode(IDPreSale, 0, DM.fStore.ID);

      with cdsPreInvMov do
      begin
        First;
        while not EOF do
          begin
            DM.fPOS.AddHoldItem(StrToInt(scCustomer.LookUpValue),
                                IDPreSale,
                                FieldByName('IDModel').AsInteger,
                                DM.fStore.IDStoreSale,
                                FieldByName('Qty').AsFloat,
                                FieldByName('Discount').AsCurrency,
                                FieldByName('SalePrice').AsCurrency,
                                FieldByName('CostPrice').AsCurrency,
                                DM.fUser.ID,
                                DM.fUser.IDCommission,
                                Now,
                                Now,
                                False,
                                True,
                                0,
                                0,
                                iError,
                                IDPreInventMov);
            Next;
          end;
        MsgBox(MSG_INF_PART_NEW_HOLD_NUMBER + ' ' + SaleCode, vbOKOnly + vbInformation);

        if FIDHistory <> -1 then
        begin
          btnEndCallClick(Self);
          scCustomer.LookUpValue := '';
          FFirstName             := '';
          FLastName              := '';
          FZipCode               := '';
        end;

      end;

      NewHold;
   end;
end;

procedure TFrmTeleMarketing.btnCreateHoldClick(Sender: TObject);
begin
  inherited;
  FinalyzeHold;
end;

procedure TFrmTeleMarketing.btDelFilterClick(Sender: TObject);
begin
  inherited;
  if quFilter.Active and (not quFilter.IsEmpty) then
  begin
    DM.RunSQL('DELETE Sal_TelemarketingFilter WHERE IDTelemarketingFilter = ' + quFilterIDTelemarketingFilter.AsString);
    FilterRefresh;
    CustomerRefresh('P.IDPessoa = -1');
    CustomerHistoryRefresh;
  end;
end;

procedure TFrmTeleMarketing.FilterCustomer(Filter: Boolean);
begin
  if Filter then
  begin
    btnStartCall.Visible   := False;
    btnEndCall.Visible     := True;
    cdsCustomer.Filter     := 'IDPessoa = ' + cdsCustomer.FieldByName('IDPessoa').AsString;
    cdsCustomer.Filtered   := True;
    scCustomerList.ReadOnly:= True;
    btnClear.Enabled       := False;
    btnMessage.Enabled     := False;
    btnExecute.Enabled     := False;
  end
  else
  begin
    btnStartCall.Visible   := True;
    btnEndCall.Visible     := False;
    cdsCustomer.Filter     := '';
    cdsCustomer.Filtered   := False;
    FIDHistory             := -1;
    scCustomerList.ReadOnly:= False;
    btnClear.Enabled       := True;
    btnMessage.Enabled     := True;
    btnExecute.Enabled     := True;
  end;
end;

procedure TFrmTeleMarketing.btnMessageClick(Sender: TObject);
begin
  inherited;
  with TFrmUserMessager.Create(Self) do
     Start;
end;

procedure TFrmTeleMarketing.btCloseClick(Sender: TObject);
begin
  inherited;
  if FIDHistory = -1 then
    Close
  else
    MsgBox(MSG_INF_END_CALL_BEFORE_CLOSE, vbOKOnly + vbCritical);
end;

procedure TFrmTeleMarketing.grdCustomerDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.Item.Caption = ' ' then
  begin
    if (AViewInfo.Value <> NULL) and (AViewInfo.Value <> '') then
    begin
      ACanvas.Font.Color := StringToColor(AViewInfo.Value);
      ACanvas.Brush.Color := ACanvas.Font.Color;
    end
    else
      ACanvas.Font.Color := clBlack;
  end;
end;

procedure TFrmTeleMarketing.scCustomerListSelectItem(Sender: TObject);
begin
  inherited;
  if scCustomerList.LookUpValue <> '' then
  begin
    FFilterType := FILTERTYPE_CUSTOMER;
    CustomerRefresh('P.IDPessoa = ' + scCustomerList.LookUpValue);
  end;
end;

procedure TFrmTeleMarketing.btnClearClick(Sender: TObject);
begin
  inherited;
  scCustomerList.LookUpValue := '';
  scCustomerList.Text := '';
  
  if FFilter <> '' then
    CustomerRefresh(FFilter);
end;

procedure TFrmTeleMarketing.btnEmailClick(Sender: TObject);
begin
  inherited;

  if cdsPreInvMov.Active and (not cdsPreInvMov.IsEmpty) then
    with TFrmEmailBuilder.Create(Self) do
      Start(StrToIntDef(scCustomer.LookUpValue,0), cdsCustomer, cdsPreInvMov);

end;

procedure TFrmTeleMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if ((ssAlt in Shift) and (Key = VK_F4)) then
  begin
    Key := 0;
    Exit;
  end;

end;

procedure TFrmTeleMarketing.btnConfigureLabelClick(Sender: TObject);
begin
  inherited;

  if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
    with TFrmPrintCustomerLabel.Create(Self) do
      Start(cdsCustomer);
      
end;

procedure TFrmTeleMarketing.btnReportClick(Sender: TObject);
begin
  inherited;

  if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
    with TFrmPrintCustomerLabel.Create(Self) do
      Print(cdsCustomer);

end;

procedure TFrmTeleMarketing.cdsCustomerAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SaleItemRefresh;
end;

procedure TFrmTeleMarketing.btnSendEmailClick(Sender: TObject);
begin
  inherited;

  if cdsCustomer.Active and (not cdsCustomer.IsEmpty) then
    with TFrmEmailBuilder.Create(Self) do
      Start(0, cdsCustomer, nil);

end;

end.
