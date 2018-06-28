unit uFinLancamentoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFchTab, ComCtrls, FormConfig, Db, StdCtrls, Buttons, ExtCtrls,
  uFinLancamentoTrackDlg, BrowseConfig,
  uFinLancamentoProgramacaoDlg, dxBar, uSisPessoaProcuraFrm, DBTables,
  DBCtrls, Mask, uParentFchList, dxCntner, uSisPessoaFch,
  dxTL, dxDBGrid, dxGrClms, dxDateEdit, dxDBDateEdit, ImgList,
  dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery, RCADOQuery, SuperComboADO,
  dxEditor, dxExEdtr, dxEdLib, dxDBELib, uSystemTypes, siComp, siLangRT,
  DateBox;


type
  TFinLancamentoFch = class(TParentFchList)
    quTotal: TRCADOQuery;
    dsTotal: TDataSource;
    quMoeda: TRCADOQuery;
    quMoedaIDMoeda: TIntegerField;
    quMoedaCodigoMoeda: TStringField;
    quMoedaMoeda: TStringField;
    quMoedaMoedaPadrao: TBooleanField;
    quMoedaSigla: TStringField;
    quMoedaIDMoedaCotacao: TIntegerField;
    quMoedaValorMoedaPadrao: TFloatField;
    quMoedaDataCotacao: TDateTimeField;
    quMoedaDesativado: TBooleanField;
    quMoedaSystem: TBooleanField;
    quMoedaHidden: TBooleanField;
    quTotalIDLancamento: TIntegerField;
    quTotalDataInicioQuitacao: TDateTimeField;
    quTotalDataFimQuitacao: TDateTimeField;
    quTotalTotalJuros: TFloatField;
    quTotalTotalQuitado: TFloatField;
    quTotalSituacao: TIntegerField;
    quTotalFator: TFloatField;
    quTotalDataCotacao: TDateTimeField;
    tsLancamento: TTabSheet;
    CorConfirmado: TPanel;
    CorVencido: TPanel;
    CorQuitado: TPanel;
    CorCancelado: TPanel;
    CorJuridico: TPanel;
    NewQuery: TPowerADOQuery;
    tsDocumento: TTabSheet;
    btAprovar: TdxBarButton;
    btTracking: TdxBarButton;
    grbFchBrwIDQuitacao: TdxDBGridMaskColumn;
    grbFchBrwQuitadoPor: TdxDBGridMaskColumn;
    grbFchBrwDataQuitacao: TdxDBGridDateColumn;
    grbFchBrwValorQuitado: TdxDBGridMaskColumn;
    grbFchBrwValorJuros: TdxDBGridMaskColumn;
    grbFchBrwNumero: TdxDBGridMaskColumn;
    grbFchBrwQuitacaoMeio: TdxDBGridMaskColumn;
    quFchBrwIDQuitacao: TIntegerField;
    quFchBrwIDLancamento: TIntegerField;
    quFchBrwPagando: TBooleanField;
    quFchBrwDataQuitacao: TDateTimeField;
    quFchBrwValorQuitado: TFloatField;
    quFchBrwValorJuros: TFloatField;
    quFchBrwNumero: TStringField;
    quFchBrwQuitacaoMeio: TStringField;
    quFchBrwQuitadoPor: TStringField;
    tsTerm: TTabSheet;
    quTerm: TADOQuery;
    quTermDueDateShift: TIntegerField;
    dsTerm: TDataSource;
    btCancelPost: TSpeedButton;
    btPost: TSpeedButton;
    btDelete: TSpeedButton;
    btNew: TSpeedButton;
    grdTerm: TdxDBGrid;
    grdTermDiscount: TdxDBGridMaskColumn;
    Label1: TLabel;
    quTermIDLancamento: TIntegerField;
    quTermDiscount: TFloatField;
    btImportVendor: TSpeedButton;
    btDesaprovar: TdxBarButton;
    quFormIDLancamento: TAutoIncField;
    quFormIDEmpresa: TIntegerField;
    quFormPrevisao: TBooleanField;
    quFormIDDocumentoTipo: TIntegerField;
    quFormIDDesdobramentoTipo: TIntegerField;
    quFormNumeroRepeticoes: TIntegerField;
    quFormPeriodicidadeRepeticoes: TIntegerField;
    quFormDiaRepeticoes: TIntegerField;
    quFormDataPrimeiraRepeticao: TDateTimeField;
    quFormIDMoedaCotacao: TIntegerField;
    quFormIDMoeda: TIntegerField;
    quFormIDUsuarioAprovacao: TIntegerField;
    quFormDataAprovacao: TDateTimeField;
    quFormIDCentroCusto: TIntegerField;
    quFormIDPessoaTipo: TIntegerField;
    quFormSituacao: TIntegerField;
    quFormIDPessoa: TIntegerField;
    quFormDataLancamento: TDateTimeField;
    quFormIDLancamentoTipo: TIntegerField;
    quFormDataVencimento: TDateTimeField;
    quFormDataInicioQuitacao: TDateTimeField;
    quFormDataFimQuitacao: TDateTimeField;
    quFormDataProtesto: TDateTimeField;
    quFormPagando: TBooleanField;
    quFormValorNominal: TBCDField;
    quFormTotalQuitado: TBCDField;
    quFormTotalJuros: TBCDField;
    quFormNumDocumento: TStringField;
    quFormNumDesdobramento: TStringField;
    quFormNumMeioQuitPrevisto: TStringField;
    quFormIDQuitacaoMeioPrevisto: TIntegerField;
    quFormIDContaCorrentePrevista: TIntegerField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    quFormIDUsuarioLancamento: TIntegerField;
    quFormIDUsuarioProtesto: TIntegerField;
    quFormNumeroDuplicata: TStringField;
    quFormDataEmissao: TDateTimeField;
    quFormIDLancamentoOriginal: TIntegerField;
    quFormDataVencimentoOriginal: TDateTimeField;
    quFormHistorico: TMemoField;
    quFormFavorecidoPrevisto: TStringField;
    quFormIDPreSale: TIntegerField;
    Panel4: TPanel;
    gbPaySchedule: TGroupBox;
    rdbOnce: TRadioButton;
    rdbMore: TRadioButton;
    gbQuitacaoPrevista: TGroupBox;
    lblQuitacaoMeio: TLabel;
    lblNumQuitacaoMeio: TLabel;
    lblContaCorrente: TLabel;
    lblFavorecido: TLabel;
    scQuitacaoMeio: TDBSuperComboADO;
    editNumMeioQuitPrevisto: TDBEdit;
    DBSuperCombo5: TDBSuperComboADO;
    editFavorecido: TDBEdit;
    pnlPayMethod: TPanel;
    Label11: TLabel;
    Label6: TLabel;
    scPaymentMethod: TSuperComboADO;
    edtEstAmount: TEdit;
    cbxInterval: TComboBox;
    NewQueryIDLancamento: TAutoIncField;
    NewQueryIDEmpresa: TIntegerField;
    NewQueryPrevisao: TBooleanField;
    NewQueryIDDocumentoTipo: TIntegerField;
    NewQueryIDDesdobramentoTipo: TIntegerField;
    NewQueryNumeroRepeticoes: TIntegerField;
    NewQueryPeriodicidadeRepeticoes: TIntegerField;
    NewQueryDiaRepeticoes: TIntegerField;
    NewQueryDataPrimeiraRepeticao: TDateTimeField;
    NewQueryIDMoedaCotacao: TIntegerField;
    NewQueryIDMoeda: TIntegerField;
    NewQueryIDUsuarioAprovacao: TIntegerField;
    NewQueryDataAprovacao: TDateTimeField;
    NewQueryIDCentroCusto: TIntegerField;
    NewQueryIDPessoaTipo: TIntegerField;
    NewQuerySituacao: TIntegerField;
    NewQueryIDPessoa: TIntegerField;
    NewQueryDataLancamento: TDateTimeField;
    NewQueryIDLancamentoTipo: TIntegerField;
    NewQueryDataVencimento: TDateTimeField;
    NewQueryDataInicioQuitacao: TDateTimeField;
    NewQueryDataFimQuitacao: TDateTimeField;
    NewQueryDataProtesto: TDateTimeField;
    NewQueryPagando: TBooleanField;
    NewQueryValorNominal: TBCDField;
    NewQueryTotalQuitado: TBCDField;
    NewQueryTotalJuros: TBCDField;
    NewQueryNumDocumento: TStringField;
    NewQueryNumDesdobramento: TStringField;
    NewQueryNumMeioQuitPrevisto: TStringField;
    NewQueryIDQuitacaoMeioPrevisto: TIntegerField;
    NewQueryIDContaCorrentePrevista: TIntegerField;
    NewQueryDesativado: TBooleanField;
    NewQueryHidden: TBooleanField;
    NewQuerySystem: TBooleanField;
    NewQueryIDUsuarioLancamento: TIntegerField;
    NewQueryIDUsuarioProtesto: TIntegerField;
    NewQueryNumeroDuplicata: TStringField;
    NewQueryDataEmissao: TDateTimeField;
    NewQueryIDLancamentoOriginal: TIntegerField;
    NewQueryDataVencimentoOriginal: TDateTimeField;
    NewQueryHistorico: TMemoField;
    NewQueryFavorecidoPrevisto: TStringField;
    NewQueryIDPreSale: TIntegerField;
    Panel3: TPanel;
    quFormIDLancamentoParent: TIntegerField;
    quFormLancamentoType: TIntegerField;
    pnl1: TPanel;
    Shape1: TShape;
    StaticText1: TStaticText;
    Label14: TLabel;
    scCompany: TDBSuperComboADO;
    Label15: TLabel;
    Label2: TLabel;
    dcCostCenter: TDBSuperComboADO;
    lblPessoaTipo: TLabel;
    scPessoaTipo: TDBSuperComboADO;
    Label7: TLabel;
    lblPessoa: TLabel;
    scPessoa: TDBSuperComboADO;
    Label9: TLabel;
    btProcuraPessoa: TSpeedButton;
    pnl2: TPanel;
    Shape3: TShape;
    StaticText3: TStaticText;
    Label3: TLabel;
    Label10: TLabel;
    lblValorNominal: TLabel;
    deValorNominal: TDBEdit;
    Label13: TLabel;
    pnl3: TPanel;
    Shape4: TShape;
    StaticText4: TStaticText;
    gbDocumento: TGroupBox;
    btAbreDocumento: TSpeedButton;
    lblDocumentoEmissao: TLabel;
    lblNumDocumento: TLabel;
    lblDocumentoTipo: TLabel;
    scDocumentoTipo: TDBSuperComboADO;
    editNumDocumento: TDBEdit;
    pnlDesdobramento: TPanel;
    lblNumDesdobramento: TLabel;
    Label8: TLabel;
    editNumDesdobramento: TDBEdit;
    scDesdobramentoTipo: TDBSuperComboADO;
    Panel2: TPanel;
    Label4: TLabel;
    gbxMemo: TGroupBox;
    plnCategory: TPanel;
    lblLancamentoTipo: TLabel;
    scLancamentoTipo: TDBSuperComboADO;
    Label12: TLabel;
    Panel1: TPanel;
    lblQuitado: TPanel;
    lblVencido: TPanel;
    lblPrevisto: TPanel;
    tsDisbursement: TTabSheet;
    NewQueryIDLancamentoParent: TIntegerField;
    NewQueryLancamentoType: TIntegerField;
    quFchBrwNumeroMeioQuit: TStringField;
    grbFchBrwNumeroMeioQuit: TdxDBGridMaskColumn;
    Panel5: TPanel;
    btnAddDisb: TSpeedButton;
    btnOpenDisb: TSpeedButton;
    Panel6: TPanel;
    quLancDisbur: TPowerADOQuery;
    quLancDisburIDLancamento: TAutoIncField;
    quLancDisburLancamentoTipo: TStringField;
    quLancDisburValorNominal: TBCDField;
    quLancDisburTotalQuitado: TBCDField;
    quLancDisburHistorico: TStringField;
    quLancDisburAQuitar: TBCDField;
    dsLancDisbur: TDataSource;
    btnRemovDisb: TSpeedButton;
    gridDisbur: TdxDBGrid;
    gridDisburSac: TdxDBGridImageColumn;
    gridDisburIDLancamento: TdxDBGridMaskColumn;
    gridDisburLancamentoTipo: TdxDBGridMaskColumn;
    gridDisburValorNominal: TdxDBGridMaskColumn;
    gridDisburTotalQuitado: TdxDBGridMaskColumn;
    gridDisburHistorico: TdxDBGridMaskColumn;
    gridDisburAQuitar: TdxDBGridMaskColumn;
    quLancDisburSac: TIntegerField;
    quLancDisburSituacao: TIntegerField;
    quUpdateDisbursement: TADOCommand;
    quLancDisburDataVencimento: TDateTimeField;
    quLancDisburPrevisao: TBooleanField;
    quLancDisburIDLancamentoTipo: TIntegerField;
    Label5: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    pnlInfo: TPanel;
    pnlOBS: TPanel;
    DBMemo1: TDBMemo;
    quFormCheckNumber: TStringField;
    quFormCustomerDocument: TStringField;
    quFormCustomerName: TStringField;
    quFormCustomerPhone: TStringField;
    quFormIDBankCheck: TIntegerField;
    NewQueryCheckNumber: TStringField;
    NewQueryCustomerDocument: TStringField;
    NewQueryCustomerName: TStringField;
    NewQueryCustomerPhone: TStringField;
    NewQueryIDBankCheck: TIntegerField;
    pnlInfoGeneral: TPanel;
    Label20: TLabel;
    editCustomerName: TDBEdit;
    Label19: TLabel;
    editCustomerDocument: TDBEdit;
    pnlInfoCheck: TPanel;
    Label21: TLabel;
    editCustomerFone: TDBEdit;
    Label22: TLabel;
    scCheckBank: TDBSuperComboADO;
    Label18: TLabel;
    editCheckNumber: TDBEdit;
    dbDocumentoEmissao: TDBDateBox;
    DBDateBox4: TDBDateBox;
    grdTermDueDateShift: TdxDBGridSpinColumn;
    spTimes: TdxSpinEdit;
    lblTimes: TLabel;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure scPessoaTipoSelectItem(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btFchBrwNovoClick(Sender: TObject);
    procedure btAprovarClick(Sender: TObject);
    procedure dsFormDataChange(Sender: TObject; Field: TField);
    procedure btFchBrwDetalheClick(Sender: TObject);
    procedure btFchBrwRemoveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scLancamentoTipoSelectItem(Sender: TObject);
    procedure btTrackingClick(Sender: TObject);
    procedure btPeriodidoClick(Sender: TObject);
    procedure btProcuraPessoaClick(Sender: TObject);
    procedure scQuitacaoMeioSelectItem(Sender: TObject);
    procedure scDocumentoTipoSelectItem(Sender: TObject);
    procedure scDesdobramentoTipoSelectItem(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grbFchBrwDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PessoaCommand(Sender: TObject);
    procedure quTermNewRecord(DataSet: TDataSet);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure grdTermKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsTermStateChange(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure quTermBeforeOpen(DataSet: TDataSet);
    procedure btImportVendorClick(Sender: TObject);
    procedure quTermAfterOpen(DataSet: TDataSet);
    procedure quTotalBeforeOpen(DataSet: TDataSet);
    procedure btDesaprovarClick(Sender: TObject);
    procedure rdbOnceClick(Sender: TObject);
    procedure edtEstAmountKeyPress(Sender: TObject; var Key: Char);
    procedure cbxIntervalChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quLancDisburAfterOpen(DataSet: TDataSet);
    procedure quLancDisburCalcFields(DataSet: TDataSet);
    procedure btnAddDisbClick(Sender: TObject);
    procedure gridDisburDblClick(Sender: TObject);
    procedure btnRemovDisbClick(Sender: TObject);
    procedure scPessoaSelectItem(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btOKClick(Sender: TObject);
    procedure deValorNominalKeyPress(Sender: TObject; var Key: Char);
    procedure btLastRecClick(Sender: TObject);
    procedure btNextRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure quFormBeforeOpen(DataSet: TDataSet);
  private
    //Translation
    sAccPaid,
    sAccPayable,
    sRecordType,
    sPayInfo,
    sPayType,
    sDebitAcc,
    sPayments,
    sEntity,
    sEntityType,
    sEntityFind,
    sDocInfo,
    sAccRecv,
    sAccRecvble,
    sCreditAcc,
    sPendente,
    sConfirmed,
    sPasDue,
    sPaid,
    sPartialPaid,
    sJuridico,
    sCancelled: String;

    Pagando: Boolean;
    LancType: Integer;
    ValidaPessoa: Boolean;
    OldIDPessoaTipo: String;
    CurrentIDPessoaTipo: String;
    FAtualiza: Boolean;
    FTotalQuitadoAntigo: Currency;

    SisPessoaFch: TSisPessoaFch;
    FinLancamentoTrackDlg: TFinLancamentoTrackDlg;
    FinLancamentoProgramacaoDlg: TFinLancamentoProgramacaoDlg;

    // Term procedure
    procedure TermRefresh;
    procedure TermPost;
    procedure TermCancel;
    procedure TermOpen;
    procedure TermClose;

    procedure DisburOpen;
    procedure DisburClose;
    procedure DisburRefresh;

    procedure TotalClose;
    procedure TotalOpen;

    procedure RefreshTab;

    procedure SetupFicha;
    procedure RefreshDocumento;
    procedure RefreshDesdobramento;
    function RefreshLancamentoTipo: Boolean;
    procedure FillLastValues;
    procedure RefreshLancType;
    procedure OnAfterStart; override;
    procedure SaveData; override;
    function OnAfterSaveChange: Boolean; override;
    function OnBeforeDoCancel: Boolean; override;
    function TestOnBeforeSave: Boolean; override;

    procedure RefreshIndicadores;

    procedure RefreshPaymentSchedule;
    procedure SavePaymentSchedule;

    function CalcTotalDisbursement:Boolean;
    procedure UpdateDisbursement;
    procedure CallDisbursement(cmd: TBtnCommandType);

    procedure SaveParentTerm(IDLancamento:Integer);
    procedure RefreshInfoPanel;

    procedure AddPessoaFilter;
    procedure RemovePessoaFilter;

    procedure DisableEdit;

    function CalulaValorQuitado: Currency;
    function CalulaValorInicial: Currency;
    function CalculaTotalDesdob: Currency;
  public
    procedure setPagando(IsPagando: Boolean);
    procedure setLancType(iType: Integer);
  end;

implementation

{$R *.DFM}

uses
  uFinQuitacaoFch, uDM, uDMGlobal, uMsgBox, xBase, uSisSenha, uFinLancamentoList,
  uFinLancamentoDesdobramentoFch, uFinLancamentoCalc, uNumericFunctions,
  uStringFunctions, uComboFiltroFunctions, uSystemConst, uMsgConstant;

function TFinLancamentoFch.OnBeforeDoCancel: Boolean;
begin
  Result := True;

  // Deleta os termos que foi inclido nos Disbursement antes de deletalos
  if (frmCommand = btInc) and (quFormLancamentoType.AsInteger = FIN_LANCAMENTO_PARENT) then
    try
      with DM.quFreeSQL do
      begin
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('DELETE Fin_LancamentoTerm ');
        SQL.Add('WHERE IDLancamento in ');
        SQL.Add('(SELECT DISTINCT IDLancamento FROM Fin_Lancamento WHERE ');
        SQL.Add('IDLancamentoParent = '+quFormIDLancamento.AsString +')');
        ExecSQL;
        Close;
      end;
    except
      Result := False;
    end;
end;

procedure TFinLancamentoFch.SaveParentTerm(IDLancamento:Integer);
begin
  //Insere os termos do parent nos filhos
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('INSERT Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)');
    SQL.Add('SELECT '+IntToStr(IDLancamento)+', LT.DueDateShift, LT.Discount');
    SQL.Add('FROM Fin_LancamentoTerm LT');
    SQL.Add('WHERE LT.IDLancamento = ' + quFormIDLancamento.AsString);
    ExecSQL;
    Close;
  end;
end;

procedure TFinLancamentoFch.UpdateDisbursement;
begin
  //Inclu as alteracaoes no pai para os filhos
  if quFormLancamentoType.AsInteger = FIN_LANCAMENTO_PARENT then
  begin
    with quUpdateDisbursement do
    begin
      Parameters.ParamByName('IDEmpresa').Value               := quFormIDEmpresa.AsInteger;
      Parameters.ParamByName('IDCentroCusto').Value           := quFormIDCentroCusto.AsInteger;
      Parameters.ParamByName('IDTipoPessoa').Value            := quFormIDPessoaTipo.AsInteger;
      Parameters.ParamByName('IDPessoa').Value                := quFormIDPessoa.AsInteger;
      Parameters.ParamByName('IDDocumentoTipo').Value         := quFormIDDocumentoTipo.AsInteger;
      Parameters.ParamByName('IDDesdobramentoTipo').Value     := quFormIDDesdobramentoTipo.AsInteger;
      Parameters.ParamByName('IDQuitacaoMeioPrevisto').Value  := quFormIDQuitacaoMeioPrevisto.AsInteger;
      Parameters.ParamByName('IDContaCorrentePrevista').Value := quFormIDContaCorrentePrevista.AsInteger;
      Parameters.ParamByName('DataEmissao').Value             := quFormDataEmissao.AsDateTime;
      Parameters.ParamByName('DataVencimento').Value          := quFormDataVencimento.AsDateTime;
      Parameters.ParamByName('NumDesdobramento').Value        := quFormNumDesdobramento.AsString;
      Parameters.ParamByName('NumDocumento').Value            := quFormNumDocumento.AsString;
      Parameters.ParamByName('NumMeioQuitPrevisto').Value     := quFormNumMeioQuitPrevisto.AsString;
      Parameters.ParamByName('FavorecidoPrevisto').Value      := quFormFavorecidoPrevisto.AsString;
      Parameters.ParamByName('Desativado').Value              := quFormDesativado.AsBoolean;
      Parameters.ParamByName('Hidden').Value                  := quFormHidden.AsBoolean;
      Parameters.ParamByName('System').Value                  := quFormSystem.AsBoolean;
      Parameters.ParamByName('IDLancamento').Value            := quFormIDLancamento.AsInteger;

      Execute;
    end;
  end;
end;

function TFinLancamentoFch.CalcTotalDisbursement:Boolean;
begin
  //Recalculo o total do disbusement caso o usuario mude o
  //total do filho
  case quFormLancamentoType.AsInteger of
    FIN_LANCAMENTO_SINGLE : Exit;
    FIN_LANCAMENTO_PARENT : UpdateTotalDisbursement(quFormIDLancamento.AsString);
    FIN_LANCAMENTO_CHILD  : UpdateTotalDisbursement(quFormIDLancamentoParent.AsString);
  end;
end;

procedure TFinLancamentoFch.RefreshLancType;
begin

  case LancType of
     FIN_LANCAMENTO_SINGLE,
     FIN_LANCAMENTO_CHILD :
         begin
         tsDisbursement.TabVisible             := False;
         tsBrowse.TabVisible                   := True;
         tsDocumento.TabVisible                := True;
         tsTerm.TabVisible                     := True;
         plnCategory.Visible                   := True;
         quFormIDLancamentoTipo.Required       := True;
         bmMDI.BarByName('Accounting').Visible := True;
         end;

     FIN_LANCAMENTO_PARENT :
         begin
         tsDisbursement.TabVisible             := True;
         tsBrowse.TabVisible                   := False;
         plnCategory.Visible                   := False;
         quFormIDLancamentoTipo.Required       := False;
         bmMDI.BarByName('Accounting').Visible := False;

         if frmCommand = btInc then
            begin
            tsDocumento.TabVisible := True;
            tsTerm.TabVisible      := True;
            end
         else
            begin
            tsDocumento.TabVisible := False;
            tsTerm.TabVisible      := False;
            end;
         end;
  end;
end;

procedure TFinLancamentoFch.setLancType(iType:integer);
begin
  LancType := iType;
end;

procedure TFinLancamentoFch.setPagando(IsPagando:Boolean);
begin
   Pagando := IsPagando;
end;

procedure TFinLancamentoFch.RefreshPaymentSchedule;
begin
  scPaymentMethod.LookUpValue := scQuitacaoMeio.LookUpValue;
  edtEstAmount.Text := FormatFloat('#,##0.00', quFormValorNominal.AsCurrency);
end;

procedure TFinLancamentoFch.TotalClose;
begin
  with quTotal do
    if Active then
      Close;
end;

procedure TFinLancamentoFch.TotalOpen;
begin
  with quTotal do
    if not Active then
      Open;
end;

procedure TFinLancamentoFch.OnAfterStart;
begin
  if MybrwQuery = nil then
    Pagando := (MyParametro = 'Pagando');

  // Seta as opções de segurança
  btFchBrwNovo.Visible := HasRight(8);
  btFchBrwDetalhe.Visible := HasRight(9);
  btFchBrwRemove.Visible := HasRight(10);
end;

function TFinLancamentoFch.OnAfterSaveChange:Boolean;
begin
  Result := True;

  try
    //Recalculo o total do disbusement caso o usuario mude o
    //total do filho
    case quFormLancamentoType.AsInteger of
      FIN_LANCAMENTO_PARENT:
      begin
        //Atualizar os Lanc filhos
        //UpdateDisbursement;
        UpdateDisbursementsChildren(quFormIDLancamento.AsString);

        //Update the document total disbursement
        CalcTotalDisbursement;
      end;

      FIN_LANCAMENTO_CHILD:
      begin
        //Update the document total disbursement
        CalcTotalDisbursement;

        //Update o Lancamento master e filhos
        UpdateDisbursementFields(quFormIDLancamento.AsString,
                                 quFormIDLancamentoParent.AsString);
      end;
    end;
  except
    Result := False;
  end;
end;

function TFinLancamentoFch.TestOnBeforeSave: boolean;
var
  Total : Currency;
begin
  inherited TestOnBeforeSave;
  Result := False;

  if Int(quFormDataEmissao.AsDateTime) > Int(quFormDataVencimento.AsDateTime) then
  begin
    PPageControl.ActivePageIndex := 0;
    quFormDataVencimento.FocusControl;
    MsgBox(MSG_CRT_DUEDATE_SMALER_ISSUE, vbCritical + vbOkOnly);
    Exit;
  end;

  //Documento ja foi quitado e Amount e diferent de total parcelas.
  if (quFormSituacao.AsInteger = 2) then
  begin
    Total := GetTotalQuitado(quFormIDLancamento.AsInteger);

    if (Total <> 0) and (quFormValorNominal.AsCurrency <> Total) then
    begin
      PPageControl.ActivePageIndex := 3;
      MsgBox(MSG_CRT_NO_CHANGE_DOC_AMOUNT, vbCritical + vbOkOnly);
      Exit;
    end;
  end;

  //Tem que adicionar um disbursemente se for Parent
  if (quFormLancamentoType.AsInteger = FIN_LANCAMENTO_PARENT)
     and not (HasDisbursement(quFormIDLancamento.AsInteger))
     and not (ModalResult = MrCancel) then
  begin
    PPageControl.ActivePageIndex := 4;
    MsgBox(MSG_CRT_NO_DOC_DISBURSEMENT, vbCritical + vbOkOnly);
    Exit;
  end;

  Result := True;
end;

procedure TFinLancamentoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CurrentIDPessoaTipo := quFormIDPessoaTipo.AsString;

  RefreshTab;
  quTotal.Requery;

  if quFormPrevisao.AsBoolean then
  begin
    btAprovar.Enabled := True;
    btDesaprovar.Enabled := False;
  end
  else
  begin
    btAprovar.Enabled := False;
    if quFormSituacao.AsInteger = 2 then //Ja foi pago e aprovado
      btDesaprovar.Enabled := False
    else
      btDesaprovar.Enabled := True;
  end;

  // Indicadores
  RefreshIndicadores;

  // Refresh dos campos relativos ao documento originador do lançamento
  RefreshDocumento;

  editNumMeioQuitPrevisto.Visible     := False;
  lblNumQuitacaoMeio.Caption      := '';
  editFavorecido.Visible := False;
  lblFavorecido.Visible := False;

  // Tipo de meio de quitacao
  scQuitacaoMeioSelectItem(nil);

  //Refresh as campos do LancamentoType
  RefreshLancType;

  if quFormPagando.AsBoolean then
  begin
    // Titulo do Form
    if quTotalSituacao.AsInteger = DM.GetConst('LancamentoSituacao_Quitado') then
      EntidadeNome := sAccPaid + quFormIDLancamento.AsString
    else
      EntidadeNome := sAccPayable + quFormIDLancamento.AsString;

    // Tipo de lancamento
    lblLancamentoTipo.Caption := sRecordType + ' :';
    quFormIDLancamentoTipo.DisplayLabel := sRecordType;

    // Documentos prievistos de quitacao
    gbQuitacaoPrevista.Caption := sPayInfo;
    lblQuitacaoMeio.Caption    := sPayType;
    lblContaCorrente.Caption   := sDebitAcc;

    with scLancamentoTipo do
    begin
      FilterFields.Clear;
      FilterValues.Clear;
      FilterFields.Add('Pagando');
      FilterValues.Add('1');
    end;

    // Grid de quitacoes
    pnlBrwTitle.Caption := sPayments;
    tsBrowse.Caption := sPayments;

    // Pessoa
    lblPessoa.Caption := sEntity + ' :';
    quFormIDPessoa.DisplayLabel := sEntity;

    lblPessoaTipo.Caption := sEntityType + ' :';
    quFormIDPessoaTipo.DisplayLabel := sEntityType;

    btProcuraPessoa.Caption := sentityFind;

    // Documento associado ao Lancamento
    gbDocumento.Caption := sDocInfo;

    HelpContext := 15;
  end
  else
  begin
    // Titulo do Form
    if quTotalSituacao.AsInteger = DM.GetConst('LancamentoSituacao_Quitado') then
      EntidadeNome := sAccRecv + quFormIDLancamento.AsString
    else
      EntidadeNome := sAccRecvble + quFormIDLancamento.AsString;

    // Tipo de lancamento
    lblLancamentoTipo.Caption := sRecordType + ' :';
    quFormIDLancamentoTipo.DisplayLabel := sRecordType;

    with scLancamentoTipo do
    begin
      FilterFields.Clear;
      FilterValues.Clear;
      FilterFields.Add('Pagando');
      FilterValues.Add('0');
    end;

    // Documentos previstos de quitacao
    gbQuitacaoPrevista.Caption := sPayInfo;
    lblQuitacaoMeio.Caption    := sPayType;
    lblContaCorrente.Caption   := sCreditAcc;

    // Grid de quitacoes
    tsBrowse.Caption := sPayments;
    pnlBrwTitle.Caption := sPayments;

    // Pessoa
    lblPessoa.Caption := sEntity +' :';
    quFormIDPessoa.DisplayLabel := sEntity;

    lblPessoaTipo.Caption := sEntityType + ' :';
    quFormIDPessoaTipo.DisplayLabel := sEntityType;

    btProcuraPessoa.Caption := sEntityFind;

    // Documento associado ao Lancamento
    gbDocumento.Caption := sDocInfo;

    bmMDI.BarByName('Accounting').Visible := False;

    HelpContext := 18;
  end;

  RefreshLancamentoTipo;
end;

procedure TFinLancamentoFch.RefreshIndicadores;
var
  Venc, Prev, Quit : Boolean;
  Sac, PorraCase: Integer;
begin
  TotalOpen;

  // verifica o estado do lancamento e atualiza o indicador
  // Desliga todos
  lblPrevisto.ParentColor := True;
  lblVencido.ParentColor  := True;
  lblQuitado.ParentColor  := True;

  Prev := quFormPrevisao.AsBoolean;
  if Prev then
  begin
    lblPrevisto.Caption := sPendente;
    Sac := 0;
  end
  else
  begin
    lblPrevisto.Caption := sConfirmed;
    Sac := 1;
  end;

  Venc := (quFormDataVencimento.AsDateTime < Date());
  if Venc then
  begin
    lblVencido.Caption := sPasDue;
    Sac := 2;
  end
  else
  begin
    lblVencido.Caption := 'Ok';
  end;

  PorraCase := quTotalSituacao.AsInteger;

  if PorraCase = DM.GetConst('LancamentoSituacao_Juridico') then
  begin
    btFchBrwNovo.Enabled := False;
    lblQuitado.Caption := sJuridico;
    Sac := 4;
  end
  else if PorraCase = DM.GetConst('LancamentoSituacao_Cancelado') then
  begin
    btFchBrwNovo.Enabled := False;
    lblQuitado.Caption := sCancelled;
    Sac := 5;
  end
  else if (quTotalTotalQuitado.AsFloat >= quFormValorNominal.AsFloat) and
          (quFormValorNominal.AsFloat > 0) then
  begin
    btFchBrwNovo.Enabled := False;
    lblQuitado.Caption := sPaid;
    Sac := 3;
  end
  else if quTotalTotalQuitado.AsFloat = 0 then
  begin
    btFchBrwNovo.Enabled := True;
    lblQuitado.Caption := '';
  end
  else if quTotalTotalQuitado.AsFloat > 0 then
  begin
    btFchBrwNovo.Enabled := True;
    lblQuitado.Caption := sPartialPaid;
  end
  else
  begin
    btFchBrwNovo.Enabled := True;
    lblQuitado.Caption := '';
  end;

  case Sac of
    1: lblPrevisto.Color := CorConfirmado.Color;
    2: lblVencido.Color  := CorVencido.Color;
    3: lblQuitado.Color  := CorQuitado.Color;
    4: lblQuitado.Color  := CorJuridico.Color;
    5: lblQuitado.Color  := CorCancelado.Color;
  end;
end;

procedure TFinLancamentoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormSituacao.AsInteger                := DM.GetConst('LancamentoSituacao_Aberto');
  quFormPagando.AsBoolean                 := Pagando;
  quFormLancamentoType.AsInteger          := LancType;
  quFormIDUsuarioLancamento.AsInteger     := SisSenha.IDUsuario;
  quFormDataLancamento.AsDateTime         := Now;
  quFormValorNominal.AsInteger            := 0;
  quFormPeriodicidadeRepeticoes.AsInteger := DM.GetConst('LancamentoPeriodicidade_Unica');
  quFormIDMoeda.AsInteger                 := SIS_IDMOEDA_PADRAO;
  quFormIDMoedaCotacao.AsInteger          := SIS_IDMOEDACOTACAO_PADRAO;
  quFormIDEmpresa.AsInteger               := DM.IDDefaultCompany;
  quFormNumeroRepeticoes.AsInteger        := 0;
  gbPaySchedule.Visible                   := True;
end;

procedure TFinLancamentoFch.scPessoaTipoSelectItem(Sender: TObject);
begin
  inherited;
  if CurrentIDPessoaTipo <> quFormIDPessoaTipo.AsString then
  begin
    quFormIDPessoa.Clear;
    PessoaSetFilter(scPessoaTipo, scPessoa, quFormIDPessoa.AsString);
    AddPessoaFilter;
  end;
end;

procedure TFinLancamentoFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  TotalClose;
  TermClose;
end;

procedure TFinLancamentoFch.SetupFicha;
begin
  if FchBrwForm = nil then
    FchBrwForm := TFinQuitacaoFch.Create(self);

  // Seta o parametro que vai ser passado para a ficha
  if Self.Pagando then
    TFinQuitacaoFch(FchBrwForm).Param := 'Pagando=1'
  else
    TFinQuitacaoFch(FchBrwForm).Param := 'Pagando=0';
end;

procedure TFinLancamentoFch.btFchBrwNovoClick(Sender: TObject);
var
   ID1, ID2: String;
   Favorecido : String;
begin
  // Os lancamentos a serem quitados são passados para a ficha de quitacao
  // atraves da tabela temporaria #AQuitar.

  // Tenta criar a Tabela Temporária no Server
  // se não conseguir e porque ela já existe.
  try
    CreateAQuitar;
  except
    // Como existe esvazia a tabela temporaria, exvazia-a.
    DeleteAQuitar(-1);
  end;

  // Tomo o cuidado de atualizar o ValorNominal
  with quForm do
    if State in dsEditModes then
      UpdateRecord;

  if scPessoa.Text <> '' then
    Favorecido := scPessoa.Text
  else
    Favorecido := quFormFavorecidoPrevisto.AsString;

  // Inclui o registro selecionado na tabela temporária.
  with DM.quFreeSQL do
  begin
    SQL.Text := 'Insert #AQuitar (IDLancamento, ValorAQuitar, IDContaCorrente, Favorecido, IDQuitacaoMeio, NumeroMeioQuit) ' +
                'VALUES (' + quFormIDLancamento.AsString + ',' +
                MyFormatCur(quFormValorNominal.AsCurrency-quTotalTotalQuitado.AsCurrency,'.') + ',' +
                IsNull(quFormIDContaCorrentePrevista.AsString, '-1') + ',' +
                #39 + Favorecido + #39 + ',' +
                IsNull(quFormIDQuitacaoMeioPrevisto.AsString, '-1') + ',' +
                #39 + quFormNumMeioQuitPrevisto.AsString + #39 + ')';
    ExecSQL;
  end;

  SetupFicha;

  // Abre a ficha de pagamento.
  if FchBrwForm.Start(btInc, nil, False, ID1, ID2, '', MyUserRights, grbFchBrw) then
  begin
    quFchBrw.Requery;
    quTotal.Requery;
    RefreshIndicadores;
    TocaFicha;
  end;
end;

procedure TFinLancamentoFch.btAprovarClick(Sender: TObject);
var
  TemAcesso: Boolean;
begin
  inherited;
  // Valida a senha e o nivel do usuário
  if Pagando then
    TemAcesso := SisSenha.HasAccess(DM.GetConst('Acesso_FinAprovarLancamentoAPagar'))
  else
    TemAcesso := SisSenha.HasAccess(DM.GetConst('Acesso_FinAprovarLancamentoAReceber'));

  if not TemAcesso then
  begin
    MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOkOnly);
    Exit;
  end;

  with quForm do
    if NOT (State in dsEditModes) then Edit;

  quFormPrevisao.AsBoolean := False;
  quFormIDUsuarioAprovacao.AsInteger := SisSenha.IDUsuario;
  quFormDataAprovacao.AsDateTime := Now;

  RefreshIndicadores;

  btAprovar.Enabled := False;
  btDesaprovar.Enabled := True;
end;

procedure TFinLancamentoFch.dsFormDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  RefreshIndicadores;
  RefreshInfoPanel;
end;

procedure TFinLancamentoFch.btFchBrwDetalheClick(Sender: TObject);
begin
  SetupFicha;

  inherited;

  quTotal.Requery;
  RefreshIndicadores;
  TocaFicha;
end;

procedure TFinLancamentoFch.btFchBrwRemoveClick(Sender: TObject);
var
  NumLancamentos: Integer;
  bDelQuitPayments : Boolean;
  sSQL : String;
begin
  //inherited;
  // Deleção especial do quitação

  if MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbNo then
    Exit;

  bDelQuitPayments := False;

  // Testa se a quitacao quita somente este lançamento
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT COUNT(IDLancamento) FROM Fin_LancQuit WHERE IDQuitacao = ' + quFchBrwIDQuitacao.AsString;
    Open;
    NumLancamentos := Fields[0].AsInteger;
    Close;
  end;

  if (NumLancamentos > 1) then
    if (quFormIDLancamentoParent.AsInteger = 0) then
    begin
      MsgBox(MSG_CRT_PART1_ERROR_DEL_PAYMENT +
             IntToStr(NumLancamentos-1)      +
             MSG_CRT_PART2_ERROR_DEL_PAYMENT, vbCritical + vbOkOnly);
      Exit;
    end
    else
    begin
      if MsgBox(MSG_QST_DEL_OTHER_DOC_PAYMENT + #13#10 , vbQuestion + vbYesNo) = vbNo then
        Exit
      else
        bDelQuitPayments := True;
    end;

  with DM do
    try
      DBADOConnection.BeginTrans;

      // Deleta o relacionamento entre a Quitacao e o Lancamento
      if not bDelQuitPayments then
        sSQL := 'DELETE Fin_LancQuit ' +
                'WHERE IDLancamento = ' + quFormIDLancamento.AsString  +
                ' AND IDQuitacao = ' + quFchBrwIDQuitacao.AsString
      else
        sSQL := 'DELETE Fin_LancQuit ' +
                'WHERE IDQuitacao = ' + quFchBrwIDQuitacao.AsString;

      RunSQL(sSQL);

      // Deleta a quitação
      RunSQL( 'DELETE Fin_Quitacao WHERE IDQuitacao = ' + quFchBrwIDQuitacao.AsString );

      DBADOConnection.CommitTrans;
      Self.TocaFicha;
    except
      DBADOConnection.RollBackTrans;
      MsgBox(MSG_CRT_NO_DEL_PAYMENT, vbCritical + vbOkOnly);
    end;

  quFchBrw.Requery;
  quTotal.Requery;
  RefreshIndicadores;
end;

procedure TFinLancamentoFch.PessoaCommand(Sender: TObject);
var
  ID1, ID2: String;
  MyAction : TBtnCommandType;
begin
  // Dependendo de quem chamou, incluo ou altero
  if TControl(Sender).Tag = 1 then
  begin
    ID1 := '';
    MyAction := btInc;
    // Garanto que foi escolhido um tipo de pessoa
    if scPessoaTipo.LookUpValue = '' then
      exit;
  end
  else if TControl(Sender).Tag = 2 then
  begin
    ID1 := scPessoa.LookUpValue;
    MyAction := btAlt;
    // Garanto que foi escolhido uma pessoa
    if scPessoa.LookUpValue = '' then
      exit;
  end;

  // Caso necessário, carrego a ficha de pessoa na memória
  if SisPessoaFch = nil then
    SisPessoaFch := TSisPessoaFch.Create(self);

  // Seto o parametro que diz qual a tipo de pessoa
  if MyAction = btInc then
    SisPessoaFch.Param := 'IDPessoaTipo=' + scPessoaTipo.LookUpValue;

  if SisPessoaFch.Start(MyAction, nil, False, ID1, ID2, '', MyUserRights, nil) then
    scPessoa.LookUpValue := ID1;
end;

procedure TFinLancamentoFch.FormShow(Sender: TObject);
begin
  inherited;
  CalulaValorInicial;

  DisableEdit;

  PPageControl.ActivePage := tsLancamento;
  // Para garantir o direito correto sobre o botão novo
  btFchBrwNovo.Visible := btFchBrwNovo.Visible AND HasRight(8);

  if LancType in [FIN_LANCAMENTO_SINGLE, FIN_LANCAMENTO_CHILD] then
    scLancamentoTipo.SetFocus
  else
    scCompany.SetFocus;
end;

procedure TFinLancamentoFch.SaveData;
begin
  // o codigo herdado cuida da alteração normal
  inherited;
  SavePaymentSchedule;
end;

procedure TFinLancamentoFch.scLancamentoTipoSelectItem(Sender: TObject);
begin
  inherited;
  if not RefreshLancamentoTipo then
    FillLastValues;
end;

function TFinLancamentoFch.RefreshLancamentoTipo: Boolean;
begin
  Result := False;

  if scLancamentoTipo.LookUpValue = '' then
    exit;

  with TADOQuery.Create(Self) do
  try
    Connection := DM.DBADOConnection;
    SQL.Clear;
    SQL.Add('SELECT IDPessoa, IDPessoaTipo, SugerePessoa, PessoaFixa, PermitePessoaNula, SugereCentroCusto, IDCentroCusto ' +
            'FROM Fin_LancamentoTipo WHERE IDLancamentoTipo = ' + scLancamentoTipo.LookUpValue);
    Open;
    ValidaPessoa := not FieldByName('PermitePessoaNula').AsBoolean;

    if FieldByName('SugerePessoa').AsBoolean then
    begin
      if not (quForm.State in dsEditModes) then
        quForm.Edit;

      quFormIDPessoaTipo.AsInteger := FieldByName('IDPessoaTipo').AsInteger;
      scPessoaTipoSelectItem(nil);
      quFormIDPessoa.AsInteger := FieldByName('IDPessoa').AsInteger;
      Result := True;
    end;

    if FieldByName('SugereCentroCusto').AsBoolean then
    begin
      if not (quForm.State in dsEditModes) then
        quForm.Edit;
      quFormIDCentroCusto.AsInteger := FieldByName('IDCentroCusto').AsInteger;
      Result := True;
    end;

    if FieldByName('PessoaFixa').AsBoolean then
    begin
      scPessoa.ReadOnly := True;
      scPessoa.ParentColor := True;

      scPessoaTipo.ReadOnly := True;
      scPessoaTipo.ParentColor := True;
    end
    else
    begin
      scPessoa.ReadOnly := False;
      scPessoa.Color := clWindow;

      scPessoaTipo.ReadOnly := False;
      scPessoaTipo.Color := clWindow;
    end;
  finally
    Free;
  end;
end;

procedure TFinLancamentoFch.btTrackingClick(Sender: TObject);
begin
  inherited;
  if FinLancamentoTrackDlg = nil then
    FinLancamentoTrackDlg := TFinLancamentoTrackDlg.Create(self);

  FinLancamentoTrackDlg.ShowModal;
end;

procedure TFinLancamentoFch.btPeriodidoClick(Sender: TObject);
begin
  inherited;
  if FinLancamentoProgramacaoDlg = nil then
    FinLancamentoProgramacaoDlg := TFinLancamentoProgramacaoDlg.Create(self);

  if quFormPeriodicidadeRepeticoes.AsInteger = DM.GetConst('LancamentoPeriodicidade_Unica') then
    quFormPeriodicidadeRepeticoes.AsInteger := DM.GetConst('LancamentoPeriodicidade_Mensal');

  if FinLancamentoProgramacaoDlg.ShowModal = mrOk then
    TocaFicha;
end;

procedure TFinLancamentoFch.btProcuraPessoaClick(Sender: TObject);
var
  R: Integer;
begin
  inherited;
  if quFormIDPessoaTipo.AsString = '' then
    exit;

  with TSisPessoaProcuraFrm.Create(self) do
  try
    R := Start(quFormIDPessoaTipo.AsInteger);

    if R <> -1 then
    begin
      with quForm do
        if not (State in dsEditModes) then
          Edit;
        quFormIDPessoa.AsInteger := R;
    end;
  finally
    Free;
  end;
end;

procedure TFinLancamentoFch.scQuitacaoMeioSelectItem(Sender: TObject);
begin
  inherited;
  // Desligo tudo
  lblNumQuitacaoMeio.Visible := False;
  editNumMeioQuitPrevisto.Visible := False;

  lblFavorecido.Visible := False;
  editFavorecido.Visible := False;

  if scQuitacaoMeio.LookUpValue = '' then
    Exit;

  // Acerta o caption do numero do Meio de Quitacao
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT Tipo, IdentificadorDocumento FROM MeioPag WHERE IDMeioPag = ' + scQuitacaoMeio.LookUpValue;
    Open;

    case Fields[0].AsInteger of
      QuitacaoMeioTipo_Cheque:
      begin
        editNumMeioQuitPrevisto.Visible := True;
        lblNumQuitacaoMeio.Visible := True;
        lblNumQuitacaoMeio.Caption := Fields[1].AsString + ' :';
        editFavorecido.Visible := True;
        lblFavorecido.Visible := True;
      end;

      QuitacaoMeioTipo_Cartao,
      QuitacaoMeioTipo_Outros:
      begin
        editNumMeioQuitPrevisto.Visible := True;
        lblNumQuitacaoMeio.Visible := True;
        lblNumQuitacaoMeio.Caption := Fields[1].AsString + ' :';
      end;
    end;

    Close;
  end;
end;

procedure TFinLancamentoFch.RefreshDocumento;
begin
  if (scDocumentoTipo.LookUpValue = '') OR (scDocumentoTipo.LookUpValue = '0') then
  begin
    // Não tem nenhum tipo de documento selecionado, sumo com tudo relativo
    // a documento
    lblNumDocumento.Visible := False;
    editNumDocumento.Visible := False;
    btAbreDocumento.Visible := False;
    lblDocumentoEmissao.Visible := False;
    dbDocumentoEmissao.Visible := False;
    pnlDesdobramento.Visible := False;

    // POr compatilidade passada, dou o refresh no tipo de desdobramento.
    // Mesmo que não tenha documento caso tenha desdobramento mostra
    if not quFormIDDesdobramentoTipo.IsNull then
    begin
      pnlDesdobramento.Visible := True;
      RefreshDesdobramento;
    end;
  end
  else
  begin
    // Mostro os controles relativos ao documento
    lblNumDocumento.Visible := True;
    editNumDocumento.Visible := True;
    lblDocumentoEmissao.Visible := True;
    dbDocumentoEmissao.Visible := True;

    // Recupero as informacaoes do tipo de documento selecionado
    with DM.NewQuery do
    begin
      if Active then
        Close;

      SQL.Text := 'SELECT IdentificadorDocumento, PossuiDesdobramento, DocumentoTipo, IDDesdobramentoTipoDefault, ' +
                  ' NumDocumentoObrigatorio, DesdobramentoObrigatorio, DataEmissaoObrigatoria ' +
                  'FROM Fin_DocumentoTipo WHERE IDDocumentoTipo = ' + scDocumentoTipo.LookUpValue;
      Open;
      lblNumDocumento.Caption := FieldByName('IdentificadorDocumento').AsString + ' :';
      quFormNumDocumento.DisplayLabel := FieldByName('IdentificadorDocumento').AsString;
      quFormNumDocumento.Required := FieldByName('NumDocumentoObrigatorio').AsBoolean;
      quFormDataEmissao.Required := FieldByName('DataEmissaoObrigatoria').AsBoolean;
      quFormIDDesdobramentoTipo.Required := FieldByName('DesdobramentoObrigatorio').AsBoolean;

      pnlDesdobramento.Visible := FieldByName('PossuiDesdobramento').AsBoolean;
      btAbreDocumento.Caption := 'Abre ' + FieldByName('DocumentoTipo').AsString + '...';

      if (not FieldByName('IDDesdobramentoTipoDefault').IsNull) and (quFormIDDesdobramentoTipo.IsNull) then
      begin
        quForm.Edit;
        quFormIDDesdobramentoTipo.AsInteger := FieldByName('IDDesdobramentoTipoDefault').AsInteger;
      end;

      Close;
      Free;
    end;

    // O botao de Abre documento é baseado na coluna IDDocumento ou IDNotaFiscalServico
    // Quando uma das duas não forem nulas, ele fica ativo
    // Filtro o Tipo de Desdobramento
    with scDesdobramentoTipo do
    begin
      FilterFields.Clear;
      FilterValues.Clear;
      FilterFields.Add('IDDocumentoTipo');
      FilterValues.Add(scDocumentoTipo.LookUpValue);
    end;

    // Se o tipo de documento requer desdobramento tenho que da o refreh do tipo de desdobramento
    if pnlDesdobramento.Visible then
      RefreshDesdobramento;
  end;
end;

procedure TFinLancamentoFch.RefreshDesdobramento;
begin
  if (scDesdobramentoTipo.LookUpValue = '')
     OR
     (scDesdobramentoTipo.LookUpValue = '0') then
    begin
      // Não tem nenhum tipo de dedobramento selecionado, sumo com tudo relativo
      lblNumDesdobramento.Visible := False;
      editNumDesdobramento.Visible := False;
    end
  else
    begin
      // Mostro os controles relativos ao documento
      lblNumDesdobramento.Visible := True;
      editNumDesdobramento.Visible := True;

      // Recupero as informacaoes do tipo de documento selecionado
      with DM.NewQuery do
        begin
          SQL.Text := 'SELECT IdentificadorDesdobramento ' +
                      'FROM Fin_DesdobramentoTipo WHERE IDDesdobramentoTipo = ' + scDesdobramentoTipo.LookUpValue;
          Open;
          lblNumDesdobramento.Caption := Fields[0].AsString + ' :';
          Close;
          Free;
        end;
    end;
end;

procedure TFinLancamentoFch.scDocumentoTipoSelectItem(Sender: TObject);
begin
  inherited;
  RefreshDocumento;
end;

procedure TFinLancamentoFch.scDesdobramentoTipoSelectItem(Sender: TObject);
begin
  inherited;
  RefreshDesdobramento;
end;


procedure TFinLancamentoFch.FormCreate(Sender: TObject);
begin
  inherited;
  FchBrwForm := nil;
  SisPessoaFch := nil;


  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sAccPaid     := 'Account paid #';
           sAccPayable  := 'Account payable #';
           sRecordType  := 'Record type';
           sPayInfo     := ' Payment info ';
           sPayType     := 'Payment type :';
           sDebitAcc    := 'Debit account :';
           sPayments    := ' Payments';
           sEntity      := 'Entity';
           sEntityType  := 'Entity type';
           sEntityFind  := 'Entity finder ...';
           sDocInfo     := ' Document info : ';
           sAccRecv     := 'Account received #';
           sAccRecvble  := 'Account receivable #';
           sCreditAcc   := 'Credit account :';
           sPendente    := 'Pending';
           sConfirmed   := 'Confirmed';
           sPasDue      := 'Past due ';
           sPaid        := 'Paid';
           sPartialPaid := 'Partial payment';
           sJuridico    := 'Jurido';
           sCancelled   := 'Cancelled';
           end;
    LANG_PORTUGUESE :
           begin
           sAccPaid     := 'Conta a Paga Nº';
           sAccPayable  := 'Contas a Pagar Nº';
           sRecordType  := 'Tipo Registro';
           sPayInfo     := ' Informação do Pagamento ';
           sPayType     := 'Tipo Pagamento :';
           sDebitAcc    := 'Conta Debito :';
           sPayments    := ' Pagamentos';
           sEntity      := 'Nome';
           sEntityType  := 'Categoria';
           sEntityFind  := 'Localizar Nome ...';
           sDocInfo     := ' Informação do Documento ';
           sAccRecv     := 'Conta a Receber Nº';
           sAccRecvble  := 'Contas a Receber Nº';
           sCreditAcc   := 'Conta Credito :';
           sPendente    := 'Pendente';
           sConfirmed   := 'Confirmado';
           sPasDue      := 'Vencimento ';
           sPaid        := 'Pago';
           sPartialPaid := 'Pagamento Parcial';
           sJuridico    := 'Jurídico';
           sCancelled   := 'Cancelado';
           end;

    LANG_SPANISH :
           begin
           sAccPaid     := 'Cuentas a pagar Nº';
           sAccPayable  := 'Cuentas a pagar Nº';
           sRecordType  := 'Tipo Registro';
           sPayInfo     := ' Información de Pago ';
           sPayType     := 'Tipo de Pago :';
           sDebitAcc    := 'Cuenta de Debito :';
           sPayments    := ' Pagos';
           sEntity      := 'Entidad';
           sEntityType  := 'Tipo Entidad';
           sEntityFind  := 'Localizar Entidad ...';
           sDocInfo     := ' Información del Documento ';
           sAccRecv     := 'Cuentas a recibir Nº';
           sAccRecvble  := 'Cuentas a recibir Nº';
           sCreditAcc   := 'Cuenta de Credito :';
           sPendente    := 'Pendiente';
           sConfirmed   := 'Confirmado';
           sPasDue      := 'Vencimiento ';
           sPaid        := 'Pago';
           sPartialPaid := 'Pago Parcial';
           sJuridico    := 'Jurídico';
           sCancelled   := 'Cancelado';
           end;
  end;
end;

procedure TFinLancamentoFch.grbFchBrwDblClick(Sender: TObject);
begin
  SetupFicha;
  inherited;
end;

procedure TFinLancamentoFch.FormDestroy(Sender: TObject);
begin
  inherited;
  if SisPessoaFch <> nil then
    SisPessoaFch.Free;
    
  if FinLancamentoProgramacaoDlg <> nil then
    FinLancamentoProgramacaoDlg.Free;
end;

procedure TFinLancamentoFch.quTermNewRecord(DataSet: TDataSet);
begin
  inherited;
  quTermIDLancamento.AsInteger := quFormIDLancamento.AsInteger;
  quTermDiscount.AsInteger := 0;

end;

procedure TFinLancamentoFch.btNewClick(Sender: TObject);
begin
  inherited;
  quTerm.Insert;
  grdTerm.SetFocus;
  grdTerm.FocusedField := quTermDueDateShift;

end;

procedure TFinLancamentoFch.btDeleteClick(Sender: TObject);
begin
  inherited;
  quTerm.Delete;
  dsTermStateChange(Nil);

end;

procedure TFinLancamentoFch.btPostClick(Sender: TObject);
begin
  inherited;
  TermPost;
  TermRefresh;

end;

procedure TFinLancamentoFch.btCancelPostClick(Sender: TObject);
begin
  inherited;
  TermCancel;

end;

procedure TFinLancamentoFch.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (grdTerm.FocusedField = quTermDiscount) then
    btPostClick(nil);

end;

procedure TFinLancamentoFch.dsTermStateChange(Sender: TObject);
begin
  inherited;

  btNew.Enabled := quTerm.Active;

  if quTerm.Active then
    begin
      btDelete.Enabled := not quTerm.IsEmpty;

      btNew.Visible := not (quTerm.State in dsEditModes);
      btDelete.Visible := not (quTerm.State in dsEditModes);
      btImportVendor.Visible := not (quTerm.State in dsEditModes);

      btPost.Visible := (quTerm.State in dsEditModes);
      btCancelPost.Visible := (quTerm.State in dsEditModes);
    end;


end;

procedure TFinLancamentoFch.TermRefresh;
var
  iDueDateShift: integer;
begin
  iDueDateShift := quTermDueDateShift.AsInteger;
  TermClose;
  TermOpen;
  quTerm.Locate('DueDateShift', IntToStr(iDueDateShift), [] );
end;

procedure TFinLancamentoFch.TermOpen;
begin

  with quTerm do
    if not Active then
      Open;

end;

procedure TFinLancamentoFch.TermClose;
begin

  TermPost;

  quTerm.Close;

end;


procedure TFinLancamentoFch.TermPost;
begin

  with quTerm do
    if quTerm.Active then
      if State in dsEditModes then
        Post;

end;

procedure TFinLancamentoFch.TermCancel;
begin

  with quTerm do
    if State in dsEditModes then
      Cancel;

end;

procedure TFinLancamentoFch.DisburOpen;
begin

    with quLancDisbur do
       if not Active then
          Open;

end;

procedure TFinLancamentoFch.DisburClose;
begin

    with quLancDisbur do
       if Active then
          Close;

end;

procedure TFinLancamentoFch.DisburRefresh;
begin

  DisburClose;
  DisburOpen;

end;


procedure TFinLancamentoFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  RefreshTab;
  DisableEdit;
  CalulaValorInicial;
end;

procedure TFinLancamentoFch.RefreshTab;
begin
  if PPageControl.ActivePage = tsTerm then
    begin
      TermOpen;
      if quTerm.IsEmpty and (quFormIDPessoa.AsString <> '') then
        btImportVendorClick(Nil);
    end
  else if PPageControl.ActivePage = tsDisbursement then
    begin
       DisburOpen;
    end;

end;


procedure TFinLancamentoFch.quTermBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quTerm.Parameters.ParamByName('IDLancamento').Value := quFormIDLancamento.AsInteger;
end;

procedure TFinLancamentoFch.btImportVendorClick(Sender: TObject);
begin
  inherited;
  if quFormIDPessoa.AsString = '' then
    begin
      MsgBox(MSG_INF_SELECT_VENDOR_FOR_TERM, vbOkOnly + vbInformation);
      Exit;
    end;

  if not quTerm.IsEmpty then
    if MsgBox(MSG_QST_OVERRIDE_VENDOR_TERMS, vbOkCancel+ vbQuestion) = vbCancel then
      exit;

  with DM.quFreeSQL do
    begin
      Close;
      try
        DM.DBADOConnection.BeginTrans;

        SQL.Text := 'DELETE Fin_LancamentoTerm WHERE IDLancamento = ' + quFormIDLancamento.AsString;
        ExecSQL;

        SQL.Text := 'INSERT Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount) SELECT ' + quFormIDLancamento.AsString + ', DueDateShift, Discount FROM PessoaTerm WHERE IDPessoa = ' + quFormIDPessoa.AsString;
        ExecSQL;

        DM.DBADOConnection.CommitTrans;

        TermRefresh;

        dsTermStateChange(nil);

      except
        DM.DBADOConnection.RollBackTrans;
      end;

    end;
end;

procedure TFinLancamentoFch.quTermAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dsTermStateChange(nil);
end;

procedure TFinLancamentoFch.quTotalBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quTotal.Parameters.ParamByName('IDLancamento').Value := quFormIDLancamento.AsInteger;
end;

procedure TFinLancamentoFch.btDesaprovarClick(Sender: TObject);
var
   TemAcesso: Boolean;
begin
  inherited;

  // Valida a senha e o nivel do usuário
 if Pagando then
    TemAcesso := SisSenha.HasAccess(DM.GetConst('Acesso_FinDesaprovarLancamentoAPagar'))
  else
    TemAcesso := SisSenha.HasAccess(DM.GetConst('Acesso_FinDesaprovarLancamentoAReceber'));

  if not TemAcesso then
    begin
      MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOkOnly);
      Exit;
    end;

  with quForm do
    if not (State in dsEditModes) then
       Edit;

  quFormPrevisao.AsBoolean := True;
  quFormIDUsuarioAprovacao.Clear;
  quFormDataAprovacao.Clear;

  //RefreshIndicadores;

  btDesaprovar.Enabled := False;
  btAprovar.Enabled := True;
end;

procedure TFinLancamentoFch.rdbOnceClick(Sender: TObject);
begin
  inherited;
  if Sender = rdbOnce then
  begin
    pnlPayMethod.Visible := False;
    lblTimes.Enabled     := False;
    cbxInterval.Enabled  := False;
    spTimes.Enabled      := False;
  end
  else
  begin
    pnlPayMethod.Visible  := True;
    lbltimes.Enabled      := True;
    cbxInterval.Enabled   := True;
    cbxInterval.ItemIndex := 1; //Monthly
    spTimes.Enabled       := True;
    quFormNumeroRepeticoes.AsInteger := 2; //Months
    RefreshPaymentSchedule;
  end;
end;

procedure TFinLancamentoFch.SavePaymentSchedule;
var
  iRep, RealDay : integer;
  i, j, Salto: integer;
  Today, SaveDate : TDateTime;
  isLancParent, hasTerms : Boolean;
  ValorNominal : Currency;

  //Esta funcao cria as parcelas do Desbursement caso seja
  //recorrent
  procedure CreateLancamentoChild(IDLancamento:integer);
       var
        x : integer;
       begin

       //Loop nos Lancamento Filhos
       quLancDisbur.Open;
       quLancDisbur.First;

       while not quLancDisbur.Eof do
          begin

          NewQuery.Append;

          //Preencho com os memos vlores do quForm
          for x := 1 to (quForm.FieldCount-1) do
              if NewQuery.FindField(quForm.Fields[x].FieldName) <> nil then
                 NewQuery.FieldByName(quForm.Fields[x].FieldName).Value := quForm.Fields[x].AsVariant;

          NewQuery.FieldByName('IDLancamento').AsInteger
              := DM.GetNextID(OM_LANCAMENTO_ID);

          NewQuery.FieldByName('DataVencimento').AsString
              := FormatDateTime('ddddd',SaveDate);

          NewQuery.FieldByName('IDLancamentoOriginal').AsInteger
              := IDLancamento;

          NewQuery.FieldByName('IDLancamentoParent').AsInteger
              := IDLancamento;

          NewQuery.FieldByName('LancamentoType').AsInteger
              := FIN_LANCAMENTO_SINGLE;

          NewQuery.FieldByName('IDQuitacaoMeioPrevisto').AsInteger
              := MyStrToInt(scPaymentMethod.LookUpValue);

          NewQuery.FieldByName('ValorNominal').AsCurrency
              := quLancDisburValorNominal.AsCurrency;

          NewQuery.FieldByName('Historico').AsString
              := quLancDisburHistorico.AsString;

          NewQuery.FieldByName('IDLancamentoTipo').AsInteger
              := quLancDisburIDLancamentoTipo.AsInteger;

          NewQuery.FieldByName('NumDocumento').Clear;
          NewQuery.FieldByName('PeriodicidadeRepeticoes').Clear;
          NewQuery.FieldByName('DataPrimeiraRepeticao').Clear;
          NewQuery.FieldByName('DiaRepeticoes').Clear;

          NewQuery.Post;

          if hasTerms then
             SaveParentTerm(NewQuery.FieldByName('IDLancamento').AsInteger);

          quLancDisbur.Next;
          end;
       end;
begin

  if IsPost and
    (not rdbOnce.Checked) and
    (frmCommand = btInc)  then
    begin
    //Is Lanc parent
    isLancParent := (quFormLancamentoType.AsInteger = FIN_LANCAMENTO_PARENT);
    //Verifica se tem Term
    TermOpen;
    hasTerms     := not (quTerm.IsEmpty);
    TermClose;

    //Calula o valor nominal
    if isLancParent then
       ValorNominal := quFormValorNominal.AsCurrency
    else
       ValorNominal := MyStrToMoney(edtEstAmount.Text);

      with DM.DBADOConnection do
        begin
          try
            // Grava modificacoes
            BeginTrans;

            NewQuery.Open;

            //Today := Date();
            Today := StrToDate(DBDateBox4.Text);

            for i := 1 to spTimes.IntValue do
              begin

                Case cbxInterval.ItemIndex of
                  0 : SaveDate := Today + (7*i); //Weekely
                  1 : SaveDate := IncMonth(Today,i); //Monthly
                  2 : SaveDate := IncMonth(Today,(12*i)); //Yearly
                end;

                NewQuery.Append;

                for j := 1 to (quForm.FieldCount-1) do
                  if NewQuery.FindField(quForm.Fields[j].FieldName) <> nil then
                     NewQuery.FieldByName(quForm.Fields[j].FieldName).Value := quForm.Fields[j].AsVariant;

               NewQuery.FieldByName('IDLancamento').AsInteger
                     := DM.GetNextID(OM_LANCAMENTO_ID);

                NewQuery.FieldByName('DataVencimento').AsString
                    := FormatDateTime('ddddd',SaveDate);

                //Removido para evitar problema na delecao    
                //NewQuery.FieldByName('IDLancamentoOriginal').AsInteger
                //    := quFormIDLancamento.AsInteger;

                NewQuery.FieldByName('IDQuitacaoMeioPrevisto').AsInteger
                    := MyStrToInt(scPaymentMethod.LookUpValue);

                NewQuery.FieldByName('ValorNominal').AsCurrency
                    := ValorNominal;

                NewQuery.FieldByName('NumeroRepeticoes').AsInteger
                    := quFormNumeroRepeticoes.AsInteger;

                NewQuery.FieldByName('NumDocumento').Clear;
                NewQuery.FieldByName('PeriodicidadeRepeticoes').Clear;
                NewQuery.FieldByName('DataPrimeiraRepeticao').Clear;
                NewQuery.FieldByName('DiaRepeticoes').Clear;

                NewQuery.Post;

                //Soment se tiver Term
                if hasTerms then
                   SaveParentTerm(NewQuery.FieldByName('IDLancamento').AsInteger);

                //Se for Parent tenho que pegar o IDLanc para criar os filhos
                if isLancParent then
                   CreateLancamentoChild(NewQueryIDLancamento.AsInteger);

              end;

            NewQuery.Close;

            CommitTrans;
          except
            RollbackTrans;
            raise;
            Exit;
          end;
        end;
    end;
end;

procedure TFinLancamentoFch.edtEstAmountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if not (Key IN ['0'..'9',#8,',','.']) then
     begin
     Key:=#0;
     MessageBeep($FFFFFFFF);
     end;

end;


procedure TFinLancamentoFch.cbxIntervalChange(Sender: TObject);
begin
  inherited;

  Case cbxInterval.ItemIndex of
    0 : begin //Weekely
        quFormNumeroRepeticoes.AsInteger := 1;
        end;
    1 : begin //Monthly
        quFormNumeroRepeticoes.AsInteger := 2;
        end;
    2 : begin //Yearly
        quFormNumeroRepeticoes.AsInteger := 3;
        end;
  end;


end;

procedure TFinLancamentoFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  gbPaySchedule.Visible := False;
  //Set para true, pos quando o form for aberto
  //nao acrescentar pagamentos recorrentes
  rdbOnce.Checked       := True;
end;

procedure TFinLancamentoFch.quLancDisburAfterOpen(DataSet: TDataSet);
begin
  inherited;

  btnOpenDisb.Enabled  := not DataSet.IsEmpty;
  btnRemovDisb.Enabled := not DataSet.IsEmpty;

end;

procedure TFinLancamentoFch.quLancDisburCalcFields(DataSet: TDataSet);
var
   PorraCase: Integer;

begin
  inherited;

  if quLancDisburPrevisao.AsBoolean then
    begin
      quLancDisburSac.AsInteger := 0;  // Icone de documento
    end
  else
    begin
      quLancDisburSac.AsInteger := 1;  // Icone de confirmado
    end;

  if quLancDisburDataVencimento.AsDateTime < Date() then
    begin
      quLancDisburSac.AsInteger := 2;  // Icone de alerta
    end
  else
    begin
      // Mantem destaque anterior
    end;

  PorraCase := quLancDisburSituacao.AsInteger;

  if PorraCase = DM.SitAberto then
    begin
      // mantem o destaque anterior
    end
  else if PorraCase = DM.SitQuitado then
    begin
      quLancDisburSac.AsInteger := 3;  // Icone a quitacao verde
    end
  else if PorraCase = DM.SitParteQuitado then
    begin
      quLancDisburSac.AsInteger := 4;  // Icone a quitacao cinza
    end
  else if PorraCase = DM.SitJuridico then
    begin
      quLancDisburSac.AsInteger := 5;  // Icone juridico
    end
  else if PorraCase = DM.SitCancelado then
    begin
      quLancDisburSac.AsInteger := 6;  // Icone Cancelado
    end;

end;

procedure TFinLancamentoFch.CallDisbursement(cmd: TBtnCommandType);
var
  ID1, ID2, sParam: String;
begin
  if not OnBeforePay then
    Exit;

  if quFormValorNominal.AsCurrency = CalculaTotalDesdob then
  begin
    MsgBox(MSG_INF_TOTAL_VALUE_REACHED, vbInformation + vbOkOnly);
    Exit;
  end;

  with TFinLancamentoDesdobramentoFch.Create(self) do
  begin
    //set o quForm para copiar os campos
    setMyquTemp(self.quForm);

    sParam := 'IDLancamento='+Self.quFormIDLancamento.AsString+';' +
              'ValorNominal='+Self.quFormValorNominal.AsString+';';

    // Abre a ficha de pagamento.
    Start(cmd, quLancDisbur, True, ID1, ID2, sParam, MyUserRights, gridDisbur);

    //refresh o grid
    quLancDisbur.Close;
    quLancDisbur.Open;
  end;

  OnAfterPay;
end;

procedure TFinLancamentoFch.btnAddDisbClick(Sender: TObject);
var
  cmd: TBtnCommandType;
begin
  inherited;

  if Sender = btnAddDisb then
    cmd := btInc
  else
    cmd := btAlt;

  CallDisbursement(cmd);
end;

procedure TFinLancamentoFch.gridDisburDblClick(Sender: TObject);
begin
  inherited;
  CallDisbursement(btAlt);
end;

procedure TFinLancamentoFch.btnRemovDisbClick(Sender: TObject);
var
  NumLancamentos: Integer;
begin
  //inherited;
  //Remov disbursement

  if MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbNo then
    Exit;

  // Testa se tem lançamento pago
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT COUNT(IDLancamento) FROM Fin_LancQuit WHERE IDLancamento = ' + quLancDisburIDLancamento.AsString;
    Open;
    NumLancamentos := Fields[0].AsInteger;
    Close;
  end;

  if NumLancamentos >= 1 then
  begin
    MsgBox(MSG_CRT_PART1_ERROR_DEL_RECORD +
           IntToStr(NumLancamentos)       +
           MSG_CRT_PART2_ERROR_DEL_RECORD + #13#10 +
           MSG_CRT_PART3_ERROR_DEL_RECORD + #13#10, vbCritical + vbOkOnly);
    Exit;
  end;

  with DM do
    try
      DBADOConnection.BeginTrans;

      // Deleta o relacionamento entre o Termo e o Lancamento
      RunSQL('DELETE Fin_LancamentoTerm ' +
             'WHERE IDLancamento = ' + quLancDisburIDLancamento.AsString);

      // Deleta o Lancamento do Disbursement
      RunSQL('DELETE Fin_Lancamento ' +
             'WHERE IDLancamento = ' + quLancDisburIDLancamento.AsString);

      DBADOConnection.CommitTrans;
    except
      DBADOConnection.RollBackTrans;
      MsgBox(MSG_CRT_NO_DEL_RECORD, vbCritical + vbOkOnly);
    end;

  quLancDisbur.Close;
  quLancDisbur.Open;
end;

procedure TFinLancamentoFch.scPessoaSelectItem(Sender: TObject);
begin
  inherited;

  if (scPessoa.LookUpValue <> '') then
      begin

      if quFormFavorecidoPrevisto.AsString <> scPessoa.Text then
         quFormFavorecidoPrevisto.AsString := scPessoa.Text;

      if quFormDataEmissao.IsNull then
         quFormDataEmissao.AsString := FormatDateTime('ddddd', now);

      if (quFormIDDocumentoTipo.AsInteger = 0) then
         with DM.quFreeSQL do
             begin
             if Active then
                Close;
             SQL.Clear;
             SQL.Add('SELECT TOP 1 L.IDDocumentoTipo');
             SQL.Add('FROM Fin_Lancamento L');
             SQL.Add('WHERE L.IDPessoa = ' + scPessoa.LookUpValue);
             SQl.Add('ORDER BY L.DataLancamento DESC');
             Open;
             if not IsEmpty then
                begin
                quFormIDDocumentoTipo.AsInteger := FieldByName('IDDocumentoTipo').AsInteger;
                RefreshDocumento;
                end;
             Close;
             end;
      end;
end;

procedure TFinLancamentoFch.RefreshInfoPanel;
Var
  iPaymentType : Integer;
begin
  iPaymentType := DM.GetPaymentMediaType(quFormIDQuitacaoMeioPrevisto.AsInteger);
  pnlInfoGeneral.Visible := iPaymentType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_CHECK];
  pnlInfoCheck.Visible   := iPaymentType = PAYMENT_TYPE_CHECK;
  pnlInfo.Visible := (Not Pagando) and (iPaymentType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_CHECK])
end;

procedure TFinLancamentoFch.AddPessoaFilter;
begin
  with DM.quPessoa do
  begin
    FilterFields.Clear;
    FilterValues.Clear;
    FilterFields.Add('IDTipoPessoa');
    FilterValues.Add(scPessoaTipo.LookUpvalue);
  end;
end;

procedure TFinLancamentoFch.FillLastValues;
var
  fIDDocumentoTipo,
  fIDCentroCusto,
  fIDPessoaTipo,
  fIDPessoa: Integer;
begin
  if (frmCommand <> btInc) and (scPessoaTipo.LookUpValue <> '' ) then
    Exit;

  if scLancamentoTipo.LookUpValue = '' then
    Exit;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT TOP 1 IDCentroCusto, IDPessoaTipo, IDPessoa, IDDocumentoTipo ' +
                'FROM Fin_Lancamento WHERE IDLancamentoTipo = ' + scLancamentoTipo.LookUpValue + ' ' +
                'ORDER BY IDLancamento DESC';
    try
      Open;
      if RecordCount = 0 then
        Exit;

      fIDDocumentoTipo := FieldByName('IDDocumentoTipo').AsInteger;
      fIDCentroCusto   := FieldByName('IDCentroCusto').AsInteger;
      fIDPessoaTipo    := FieldByName('IDPessoaTipo').AsInteger;
      fIDPessoa        := FieldByName('IDPessoa').AsInteger;
    finally
      Close;
    end;

    quForm.Edit;
    quFormIDCentroCusto.AsInteger   := fIDCentroCusto;
    quFormIDPessoaTipo.AsInteger    := fIDPessoaTipo;
    scPessoaTipoSelectItem(nil);
    quFormIDPessoa.AsInteger        := fIDPessoa;
    quFormIDDocumentoTipo.AsInteger := fIDDocumentoTipo;
    RefreshDocumento;
    quFormDataVencimento.FocusControl;
  end;
end;

procedure TFinLancamentoFch.DisableEdit;
begin
  if quFchBrw.IsEmpty then
    deValorNominal.Enabled := True
  else
    deValorNominal.Enabled := False;
end;

procedure TFinLancamentoFch.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  if TestOnBeforeSave then
  begin
    if not FAtualiza then
    begin
      if (quFormSituacao.Value = 5) then
      begin
        if (FTotalQuitadoAntigo <> CalulaValorQuitado) then
          CanClose := False
      end
      else if (quFormSituacao.Value = 2) then
      begin
        if (quFormValorNominal.Value <> CalulaValorQuitado) then
          CanClose := False
        else if (quFchBrw.RecordCount = 0) then
      end
      else if (quFormSituacao.Value = 1) then
      begin
        if (quFormValorNominal.Value = 0) and (CalulaValorQuitado = 0) then
          CanClose := True
        else if (quFormValorNominal.Value = CalulaValorQuitado) then
          CanClose := False
        else if (quFchBrw.RecordCount <> 0) then
          CanClose := False
      end;
    end;

    if not CanClose then
      MsgBox(MSG_CRT_MUST_SAVE, vbOKOnly + vbInformation)
    else
      inherited;
  end
  else
    CanClose := False;
    FAtualiza := False;
end;

function TFinLancamentoFch.CalulaValorQuitado: Currency;
var
  FTotalQuitadoNovo : Currency;
begin
  FTotalQuitadoNovo := 0;
  with quFchBrw do
  begin
    First;
      while not Eof do
      begin
        FTotalQuitadoNovo := FTotalQuitadoNovo + quFchBrwValorQuitado.Value;
        Next;
      end;
  end;
  Result := FTotalQuitadoNovo;
end;

procedure TFinLancamentoFch.btOKClick(Sender: TObject);
begin
  FAtualiza := True;
  inherited;
end;

function TFinLancamentoFch.CalulaValorInicial: Currency;
begin
  FTotalQuitadoAntigo := 0;
  with quFchBrw do
  begin
    First;
      while not Eof do
      begin
        FTotalQuitadoAntigo := FTotalQuitadoAntigo + quFchBrwValorQuitado.Value;
        Next;
      end;
  end;
end;

procedure TFinLancamentoFch.deValorNominalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key IN ['0'..'9','-',',','.',#8]) then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end
  else
  begin
    if (Key = ',') and (Pos(',', deValorNominal.Text) > 0) then
      Key := #0
    else if (Key = '.') and (Pos('.', deValorNominal.Text) > 0) then
      Key := #0;
  end;
end;

procedure TFinLancamentoFch.btLastRecClick(Sender: TObject);
begin
  inherited;
  CalulaValorInicial;
end;

procedure TFinLancamentoFch.btNextRecClick(Sender: TObject);
begin
  inherited;
  CalulaValorInicial;
end;

procedure TFinLancamentoFch.btPriorRecClick(Sender: TObject);
begin
  inherited;
  CalulaValorInicial;
end;

procedure TFinLancamentoFch.btFirstRecClick(Sender: TObject);
begin
  inherited;
  CalulaValorInicial;
end;

function TFinLancamentoFch.CalculaTotalDesdob: Currency;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('select sum(IsNull(ValorNominal,0)) as Amount');
    SQL.Add('from Fin_Lancamento');
    SQl.Add('where IDLancamentoParent = ' + quFormIDLancamento.AsString);
    Open;

    if not IsEmpty then
      Result := FieldByName('Amount').AsCurrency;

    Close;
  end;
end;

procedure TFinLancamentoFch.RemovePessoaFilter;
begin
  with DM.quPessoa do
  begin
    FilterFields.Clear;
    FilterValues.Clear;
  end;

  with scPessoa do
  begin
    FilterFields.Clear;
    FilterValues.Clear;
  end;
end;

procedure TFinLancamentoFch.quFormBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  RemovePessoaFilter;
end;

initialization
  RegisterClass(TFinLancamentoFch);

end.
