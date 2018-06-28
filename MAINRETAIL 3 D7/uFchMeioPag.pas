unit uFchMeioPag;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, LblEffct, ExtCtrls,
  FormConfig, Grids, Buttons, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO,
  Menus, LookUpADOQuery, siComp, siLangRT, DBGrids, SMDBGrid, dximctrl,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, cxDBEdit, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  SuperEdit, SuperEditCurrency, cxSpinEdit;

type
  TFchMeioPag = class(TbrwFrmParent)
    dsMinPayType: TDataSource;
    quMinPayType: TADOQuery;
    quFormIDMeioPag: TIntegerField;
    quFormMeioPag: TStringField;
    quFormTemDocumento: TBooleanField;
    quFormPrazoRecebimento: TIntegerField;
    quFormTaxaAdmin: TFloatField;
    quFormIDContaCorrente: TIntegerField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    quMinPayTypeIDMeioPag: TIntegerField;
    quMinPayTypeTotalSale: TFloatField;
    quMinPayTypeDifDay: TIntegerField;
    quStore: TADOQuery;
    dsStore: TDataSource;
    quFormTipo: TIntegerField;
    quStoreIDContaCorrente: TIntegerField;
    Label6: TLabel;
    cmbParentType: TDBComboBox;
    quFormIDMeioPagBatch: TIntegerField;
    quFormParentType: TStringField;
    Label38: TLabel;
    quFormIDLancamentoTipo: TIntegerField;
    quFormIDPessoa: TIntegerField;
    pnlBatch: TPanel;
    pnlDepAccount: TPanel;
    pnlSale: TPanel;
    dbrdgType: TDBRadioGroup;
    pnlMinPayType: TPanel;
    lbBatch: TLabel;
    scPayment: TDBSuperComboADO;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    pnlDiscountFee: TPanel;
    dbedtPrazoRec: TDBEdit;
    lbPayDays: TLabel;
    dbedtTaxaAdm: TDBEdit;
    lbDiscFee: TLabel;
    Label4: TLabel;
    scPessoa: TDBSuperComboADO;
    scLancTipo: TDBSuperComboADO;
    Label3: TLabel;
    Label9: TLabel;
    cbAutoDiscountFee: TDBCheckBox;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    quFormAutoDiscountFee: TBooleanField;
    quStoreIDStore: TIntegerField;
    quStoreIDMeioPag: TIntegerField;
    grdMinPayType: TSMDBGrid;
    quFormImageIndex: TIntegerField;
    spnImage: TdxSpinImage;
    lblPaymentDays: TLabel;
    DBEdit: TDBEdit;
    Label13: TLabel;
    chxPayOnCloseReg: TDBCheckBox;
    chxDrawerKick: TDBCheckBox;
    quFormPayOnCashRegClose: TBooleanField;
    quFormDrawerKickOnPay: TBooleanField;
    grdPayment: TcxGrid;
    grdPaymentDB: TcxGridDBTableView;
    grdPaymentLevel: TcxGridLevel;
    quStoreAdmTax: TBCDField;
    quStoreReceivingDay: TIntegerField;
    quStoreFlatFee: TBooleanField;
    grdPaymentDBIDStore: TcxGridDBColumn;
    grdPaymentDBIDContaCorrente: TcxGridDBColumn;
    grdPaymentDBAdmTax: TcxGridDBColumn;
    grdPaymentDBReceivingDay: TcxGridDBColumn;
    grdPaymentDBFlatFee: TcxGridDBColumn;
    quStores: TADOQuery;
    dsStores: TDataSource;
    quStoresIDStore: TIntegerField;
    quStoresName: TStringField;
    quBankAcc: TADOQuery;
    dsBankAcc: TDataSource;
    quBankAccNumero: TStringField;
    quBankAccTipo: TStringField;
    quBankAccIDContaCorrente: TIntegerField;
    chxRequireCustomer: TDBCheckBox;
    quFormRequireCustomer: TBooleanField;
    quFormPrintBankBillet: TBooleanField;
    quFormBankBilletInterest: TBCDField;
    chcPrintBankBillet: TDBCheckBox;
    lbBilletInterest: TLabel;
    edtBilletInterest: TDBEdit;
    Label5: TLabel;
    scRecordType: TDBSuperComboADO;
    Label18: TLabel;
    chkDelinquent: TDBCheckBox;
    quFormValidateNonpayer: TBooleanField;
    pnlJuros: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    quFormTaxMode: TIntegerField;
    quFormhidden: TBooleanField;
    quFormFlatPenalty: TBooleanField;
    quFormPenaltyValue: TBCDField;
    quFormDailtInterest: TBCDField;
    dbedtPenalty: TDBEdit;
    dbedtDailyInterest: TDBEdit;
    cbxType: TComboBox;
    procedure quMinPayTypeNewRecord(DataSet: TDataSet);
    procedure quMinPayTypeBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure cmbParentTypeChange(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure dsMinPayTypeStateChange(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure grdMinPayTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quMinPayTypeAfterEdit(DataSet: TDataSet);
    procedure quStoreAfterEdit(DataSet: TDataSet);
    procedure cbAutoDiscountFeeClick(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dsFormStateChange(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure dbrdgTypeChange(Sender: TObject);
    procedure chcPrintBankBilletClick(Sender: TObject);
    procedure scRecordTypeSelectItem(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    procedure SetHelpContext;

    procedure RefreshParanType;
    procedure AutoDiscountRefresh;
    procedure RefreshBankBillet;

    // Min Pag
    procedure MinPagRefresh;
    procedure MinPagPost;
    procedure MinPagCancel;
    procedure MinPagOpen;
    procedure MinPagClose;

    //Store
    procedure StoreOpen;
    procedure StoreClose;
    procedure StorePost;
  protected
    function BeforeChange: boolean; override;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst;

{$R *.DFM}

function TFchMeioPag.BeforeChange: boolean;
begin
  if cmbParentType.ItemIndex = 0 then
  begin
    Result := True;
    Exit;
  end;

  StorePost;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT MPS.IDStore ');
    SQL.Add('FROM MeioPagToStore MPS');
    SQL.Add('JOIN Store S ON (S.IDStore = MPS.IDStore)');
    SQL.Add('WHERE MPS.IDMeioPag = ' + quFormIDMeioPag.AsString);
    SQL.Add('AND MPS.IDContaCorrente IS NULL');
    SQL.Add('AND S.Hidden=0 AND S.Desativado=0');
    Open;
    Result := (RecordCount = 0);
    Close;
  end;

  if not Result then
    MsgBox(MSG_CRT_ERROR_DEPOSIT_ACC, vbCritical + vbOkOnly);
end;

procedure TFchMeioPag.StoreOpen;
begin
  with quStore do
  begin
    if not Active then
    begin
      Parameters.ParamByName('IDMeioPag').Value := quFormIDMeioPag.AsInteger;
      Open;
    end;
  end;
end;

procedure TFchMeioPag.StoreClose;
begin
  StorePost;
  quStore.Close;
end;

procedure TFchMeioPag.StorePost;
begin
  with quStore do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFchMeioPag.MinPagRefresh;
var
  iIDMeioPag: integer;
begin
  iIDMeioPag := quMinPayTypeIDMeioPag.AsInteger;
  MinPagClose;
  MinPagOpen;
  quMinPayType.Locate('IDMeioPag', IntToStr(iIDMeioPag), [] );
end;

procedure TFchMeioPag.MinPagOpen;
begin
  with quMinPayType do
  begin
    if not Active then
    begin
      Parameters.ParamByName('IDMeioPag').Value := quFormIDMeioPag.AsInteger;
      Open;
    end;
  end;
end;

procedure TFchMeioPag.MinPagClose;
begin
  MinPagPost;
  quMinPayType.Close;
end;

procedure TFchMeioPag.MinPagPost;
begin
  with quMinPayType do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TFchMeioPag.MinPagCancel;
begin
  with quMinPayType do
    if Active then
      if State in dsEditModes then
        Cancel;
end;

procedure TFchMeioPag.RefreshParanType;
begin
  if cmbParentType.ItemIndex = 1 then
  begin
    //Batch
    pnlBatch.Visible   := True;
    pnlSale.Visible    := False;
    spnImage.Visible   := False;

    StoreOpen;

    //Required fields
    quFormIDMeioPagBatch.Required   := False;

    quStores.Open;
    quBankAcc.Open;
  end
  else
  begin
    //Sale
    pnlBatch.Visible := False;
    pnlSale.Visible  := True;
    spnImage.Visible := True;

    MinPagOpen;

    //Required fields
    quFormIDMeioPagBatch.Required   := True;
  end;
end;

procedure TFchMeioPag.quMinPayTypeNewRecord(DataSet: TDataSet);
begin
  inherited;
  quMinPayTypeIDMeioPag.AsInteger := quFormIDMeioPag.AsInteger;
end;

procedure TFchMeioPag.quMinPayTypeBeforePost(DataSet: TDataSet);
begin
  inherited;
  // Testa se esta incluindo dia maior que zero para cash
  if (quMinPayTypeIDMeioPag.AsInteger = PAY_TYPE_CASH) and
     ( quMinPayTypeDifDay.AsInteger > 0 ) then
  begin
    quMinPayType.Cancel;
    raise exception.create('cash does not allow pre date payments');
  end;
end;

procedure TFchMeioPag.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  MinPagClose;
  StoreClose;
end;

procedure TFchMeioPag.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshParanType;
  AutoDiscountRefresh;
  RefreshBankBillet;

  if (quFormFlatPenalty.AsBoolean) then
    cbxtype.ItemIndex := 1
  else
    cbxtype.ItemIndex := 0
end;

procedure TFchMeioPag.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormParentType.AsString        := 'Sale';
  quFormAutoDiscountFee.AsBoolean  := False;
  quFormValidateNonpayer.AsBoolean := False;
  quFormImageIndex.AsInteger       := -1;
  quFormIDLancamentoTipo.AsInteger := 2;

  AutoDiscountRefresh;
end;

procedure TFchMeioPag.cmbParentTypeChange(Sender: TObject);
begin
  inherited;
  RefreshParanType;
end;

procedure TFchMeioPag.spHelpClick(Sender: TObject);
begin

  SetHelpContext;
  inherited;

end;

procedure TFchMeioPag.btNewClick(Sender: TObject);
begin
  inherited;
  MinPagRefresh;

  quMinPayType.Insert;
  if grdMinPayType.CanFocus then
    grdMinPayType.SetFocus;
  quMinPayTypeDifDay.FocusControl;
end;

procedure TFchMeioPag.btDeleteClick(Sender: TObject);
begin
  inherited;
  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
  begin
    quMinPayType.Delete;
    dsMinPayTypeStateChange(Nil);
  end;
end;

procedure TFchMeioPag.dsMinPayTypeStateChange(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
    Exit;

  btNew.Enabled := quMinPayType.Active;

  with quMinPayType do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quMinPayType.State in dsEditModes);
  btDelete.Visible := not (quMinPayType.State in dsEditModes);

  btPost.Visible := (quMinPayType.State in dsEditModes);
  btCancelPost.Visible := (quMinPayType.State in dsEditModes);
end;

procedure TFchMeioPag.btPostClick(Sender: TObject);
begin
  inherited;
  MinPagPost;
  MinPagRefresh;
end;

procedure TFchMeioPag.btCancelPostClick(Sender: TObject);
begin
  inherited;
  MinPagCancel;
end;

procedure TFchMeioPag.grdMinPayTypeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) {and (grdMinPayType.FocusedField = quMinPayTypeTotalSale)} then
    btPostClick(nil);
end;

procedure TFchMeioPag.quMinPayTypeAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchMeioPag.quStoreAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TFchMeioPag.cbAutoDiscountFeeClick(Sender: TObject);
begin
  inherited;
  AutoDiscountRefresh;
end;

procedure TFchMeioPag.AutoDiscountRefresh;
var
  i: integer;
  bEnabled: boolean;
begin
  bEnabled := cbAutoDiscountFee.Checked;

  // Primeiro os Controles da tela
  with pnlDiscountFee do
    for i := 0 to ControlCount-1 do
      if (Controls[i].Name <> 'cbAutoDiscountFee') and
         (Controls[i].Name <> 'lblDiscountfeeTitle') then
        Controls[i].Enabled := bEnabled;

  // Agora os fields
  quFormTaxaAdmin.Required        := bEnabled;
  quFormIDLancamentoTipo.Required := bEnabled;
  quFormIDPessoa.Required         := bEnabled;

  grdPaymentDBAdmTax.Visible       := bEnabled;
  grdPaymentDBReceivingDay.Visible := bEnabled;
  grdPaymentDBFlatFee.Visible      := bEnabled;

end;

procedure TFchMeioPag.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  MinPagClose;
  StoreClose;
  quStores.Close;
  quBankAcc.Close;
end;

procedure TFchMeioPag.FormCreate(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
  begin
    btNew.Visible        := False;
    btDelete.Visible     := False;
    btPost.Visible       := False;
    btCancelPost.Visible := False;
  end;
end;

procedure TFchMeioPag.dsFormStateChange(Sender: TObject);
begin
  inherited;
  spnImage.ItemIndex := quFormImageIndex.AsInteger; 
end;

procedure TFchMeioPag.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quFormImageIndex.AsInteger := spnImage.ItemIndex;
  quFormFlatPenalty.AsBoolean := (cbxtype.ItemIndex = 1)

end;

procedure TFchMeioPag.dbrdgTypeChange(Sender: TObject);
begin
  inherited;
  RefreshBankBillet;
end;

procedure TFchMeioPag.RefreshBankBillet;
begin
  if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
  begin
    chcPrintBankBillet.Visible := ((dbrdgType.ItemIndex+1) = PAYMENT_TYPE_OTHER);
    lbBilletInterest.Visible := (chcPrintBankBillet.Visible and chcPrintBankBillet.Checked);
    edtBilletInterest.Visible := lbBilletInterest.Visible;
  end;
end;

procedure TFchMeioPag.chcPrintBankBilletClick(Sender: TObject);
begin
  inherited;
  lbBilletInterest.Visible := (chcPrintBankBillet.Visible and chcPrintBankBillet.Checked);
  edtBilletInterest.Visible := lbBilletInterest.Visible;
end;

procedure TFchMeioPag.scRecordTypeSelectItem(Sender: TObject);
begin
  inherited;

  if scRecordType.GetFieldByName('Pagando') then
  begin
    MsgBox(MSG_CRT_NO_RECORD_TYPE, vbCritical + vbOkOnly);
    scRecordType.LookUpValue := '';
  end;

end;

procedure TFchMeioPag.SetHelpContext;
begin

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Pagamentos.htm';
      if cmbParentType.ItemIndex = 0 then
        sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Tipo_de_Pagamento_Sale/Adicionar_Tipo_de_Pagamento_Sale.html'
      else
        sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Tipo_de_Pagamento_Batch/Adicionar_Tipo_de_Pagamento_Batch.html';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;

end;

procedure TFchMeioPag.btnVideoClick(Sender: TObject);
begin
  SetHelpContext;
  inherited;
end;

end.

