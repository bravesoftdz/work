unit uSisPessoaFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFchTab, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner,
  dxDateEdit, Db, dxDBDateEdit, StdCtrls, DBCtrls, MemoStr,
  ComCtrls, ExtCtrls, Mask, ImgList, dxBar,
  FormConfig, DBTables, Buttons, ADODB, PowerADOQuery,
  RCADOQuery, SuperComboADO, dxEdLib, dxEditor, dxExEdtr, dxDBELib, siComp,
  siLangRT, DateBox;

const
   PT_CUSTOMER    = 1;
   PT_VENDOR      = 2;
   PT_COMMISSION  = 3;
   PT_SALESPERSON = 4;
   PT_GUIDE       = 5;
   PT_AGENCY      = 6;
   PT_OTHER       = 9;

type
  TSisPessoaFch = class(TParentFchTab)
    lblCode: TLabel;
    DBEdit20: TDBEdit;
    scPessoaTipo: TDBSuperComboADO;
    TipoCli: TDBRadioGroup;
    cbDescontaCordenacao: TDBCheckBox;
    tsBasic: TTabSheet;
    Label3: TLabel;
    edtAddress: TDBEdit;
    MemoPhone: TDbMemoStr;
    DbEditCellular: TDBEdit;
    DBEditBeeper: TDBEdit;
    MemoFax: TDbMemoStr;
    Label4: TLabel;
    Label46: TLabel;
    Label45: TLabel;
    Label8: TLabel;
    edtZIP: TDBEdit;
    scCountry: TDBSuperComboADO;
    scState: TDBSuperComboADO;
    edtCity: TDBEdit;
    Label5: TLabel;
    Label7: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label22: TLabel;
    EditEMail: TDBEdit;
    Label23: TLabel;
    EditHomePage: TDBEdit;
    pnlJuridico: TPanel;
    Label2: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    EditDBA: TDBEdit;
    EditFederalID: TDBEdit;
    EditSalesTax: TDBEdit;
    EditContact: TDBEdit;
    pnlFisico: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label16: TLabel;
    Label32: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit1: TDBEdit;
    quInvoiceHistory: TADOQuery;
    quInvoiceHistoryHold: TIntegerField;
    quInvoiceHistoryIDInvoice: TIntegerField;
    quInvoiceHistoryInvoiceDate: TDateTimeField;
    quInvoiceHistoryStore: TStringField;
    quInvoiceHistoryValue: TFloatField;
    dsInvoiceHistory: TDataSource;
    dsAccount: TDataSource;
    quAccount: TRCADOQuery;
    quAccountIDLancamento: TIntegerField;
    quAccountDataVencimento: TDateTimeField;
    quAccountLancamentoTipo: TStringField;
    quAccountDataFimQuitacao: TDateTimeField;
    quAccountValorNominal: TFloatField;
    quAccountTotalQuitado: TFloatField;
    quAccountPagando: TBooleanField;
    quAccountHistorico: TMemoField;
    dsGroupHistory: TDataSource;
    quGroupHistory: TADOQuery;
    quGroupHistoryEnterDate: TDateTimeField;
    quGroupHistoryGuide: TStringField;
    quGroupHistoryNumTourist: TIntegerField;
    quGroupHistoryAgency: TStringField;
    quGroupHistoryQTYInvoice: TIntegerField;
    quGroupHistoryTotalInvoice: TFloatField;
    quGroupHistoryIDTouristGroup: TIntegerField;
    quPurchaseHistory: TADOQuery;
    quPurchaseHistoryIDPurchase: TIntegerField;
    quPurchaseHistoryModel: TStringField;
    quPurchaseHistoryMovDate: TDateTimeField;
    quPurchaseHistoryCostPrice: TFloatField;
    quPurchaseHistoryFreight: TFloatField;
    quPurchaseHistoryOtherCost: TFloatField;
    quPurchaseHistoryTotal: TFloatField;
    dsPurchaseHistory: TDataSource;
    tsPurchaseHistory: TTabSheet;
    tsGroupHistory: TTabSheet;
    tsAccounting: TTabSheet;
    pnlPurchaseHistoryFilter: TPanel;
    Label21312312: TLabel;
    Label48213: TLabel;
    btPHGo: TSpeedButton;
    dxDBGridPH: TdxDBGrid;
    dxDBGridPHModel: TdxDBGridMaskColumn;
    dxDBGridPHMovDate: TdxDBGridDateColumn;
    dxDBGridPHQty: TdxDBGridMaskColumn;
    dxDBGridPHCostPrice: TdxDBGridMaskColumn;
    dxDBGridPHFreight: TdxDBGridMaskColumn;
    dxDBGridPHOtherCost: TdxDBGridMaskColumn;
    dxDBGridPHTotal: TdxDBGridMaskColumn;
    grdGroupHistory: TdxDBGrid;
    pnlInvoiceHsitoryFilter: TPanel;
    Label26: TLabel;
    Label28: TLabel;
    btGHGo: TSpeedButton;
    grdObjeto: TdxDBGrid;
    grdObjetoLancamentoTipo: TdxDBGridMaskColumn;
    grdObjetoDataVencimento: TdxDBGridDateColumn;
    grdObjetoDataInicioQuitacao: TdxDBGridDateColumn;
    grdObjetoValorNominal: TdxDBGridMaskColumn;
    grdObjetoTotalQuitado: TdxDBGridMaskColumn;
    tsInvoiceHistory: TTabSheet;
    pnlAccountingFilter: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    btAGo: TSpeedButton;
    Panel6: TPanel;
    Label1: TLabel;
    Label13: TLabel;
    btIHGo: TSpeedButton;
    dxDBGrid1: TdxDBGrid;
    grdObjetoHold: TdxDBGridMaskColumn;
    grdObjetoIDInvoice: TdxDBGridMaskColumn;
    grdObjetoInvoiceDate: TdxDBGridDateColumn;
    grdObjetoStore: TdxDBGridMaskColumn;
    grdObjetoValue: TdxDBGridMaskColumn;
    quFormIDPessoa: TIntegerField;
    quFormPessoa: TStringField;
    quFormIDTipoPessoa: TIntegerField;
    quFormIDStore: TIntegerField;
    quFormNomeJuridico: TStringField;
    quFormEndereco: TStringField;
    quFormCidade: TStringField;
    quFormCEP: TStringField;
    quFormPais: TStringField;
    quFormTelefone: TStringField;
    quFormCellular: TStringField;
    quFormFax: TStringField;
    quFormBeeper: TStringField;
    quFormContato: TStringField;
    quFormEmail: TStringField;
    quFormOBS: TStringField;
    quFormJuridico: TBooleanField;
    quFormNascimento: TDateTimeField;
    quFormIDEstado: TStringField;
    quFormIDPessoaBoss: TIntegerField;
    quFormIDTipoPessoaFilho: TIntegerField;
    quFormCPF: TStringField;
    quFormCGC: TStringField;
    quFormIdentidade: TStringField;
    quFormCartTrabalho: TStringField;
    quFormInscEstadual: TStringField;
    quFormInscMunicipal: TStringField;
    quFormContatos: TStringField;
    quFormNumAtrasos: TIntegerField;
    quFormDiasAtraso: TIntegerField;
    quFormNumTransacoes: TIntegerField;
    quFormHomePage: TStringField;
    quFormOrgaoEmissor: TStringField;
    quFormBairro: TStringField;
    quFormNumMovimentacoes: TIntegerField;
    quFormSystem: TBooleanField;
    quFormDesativado: TIntegerField;
    quFormHidden: TIntegerField;
    quFormComissaoSobreGuia: TFloatField;
    quFormDescontaCoordenacao: TBooleanField;
    quFormAjusteComiss: TFloatField;
    quFormIDUser: TIntegerField;
    quFormShortName: TStringField;
    quFormShort_Name: TStringField;
    quFormCode: TIntegerField;
    quFormIDTipoPessoaRoot: TIntegerField;
    quFormIDPais: TIntegerField;
    quFormPessoaLastName: TStringField;
    quFormCustomerCard: TStringField;
    quFormPessoaFirstName: TStringField;
    pnlPersonal: TPanel;
    pnlBusiness: TPanel;
    edLastName: TDBEdit;
    Label33: TLabel;
    Label31: TLabel;
    Label21: TLabel;
    edFirstName: TDBEdit;
    lblPessoa: TLabel;
    Label34: TLabel;
    edPessoa: TDBEdit;
    Label35: TLabel;
    lblComissaoSobreGuia: TLabel;
    edComissaoSobreGuia: TDBEdit;
    Label15: TLabel;
    grdGroupHistoryEnterDate: TdxDBGridDateColumn;
    grdGroupHistoryGuide: TdxDBGridMaskColumn;
    grdGroupHistoryNumTourist: TdxDBGridMaskColumn;
    grdGroupHistoryAgency: TdxDBGridMaskColumn;
    grdGroupHistoryQTYInvoice: TdxDBGridMaskColumn;
    grdGroupHistoryTotalInvoice: TdxDBGridMaskColumn;
    grdGroupHistoryIDTouristGroup: TdxDBGridMaskColumn;
    Label36: TLabel;
    TabSheet1: TTabSheet;
    Label27: TLabel;
    Label41: TLabel;
    scStore: TDBSuperComboADO;
    scUser: TDBSuperComboADO;
    tsTerm: TTabSheet;
    Panel8: TPanel;
    grdTerm: TdxDBGrid;
    quTerm: TADOQuery;
    dsTerm: TDataSource;
    quTermDueDateShift: TIntegerField;
    Label14: TLabel;
    grdTermDueDateShift: TdxDBGridMaskColumn;
    grdTermDiscount: TdxDBGridMaskColumn;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btCancelPost: TSpeedButton;
    btPost: TSpeedButton;
    quTermIDPessoa: TIntegerField;
    quTermDiscount: TFloatField;
    Panel9: TPanel;
    sdfsdfsdafasdfasd: TLabel;
    wedwerwer: TLabel;
    dfsdfsdafsda: TLabel;
    lblPagarVencido: TLabel;
    lblPagarAVencer: TLabel;
    lblTotalPago: TLabel;
    Panel10: TPanel;
    werwqerwqerwq: TLabel;
    weqrqwerwqerwe: TLabel;
    sdfsadtvertvhjdytnuytr: TLabel;
    lblReceberVencido: TLabel;
    lblReceberAVencer: TLabel;
    lblTotalRecebido: TLabel;
    quFormHorasSemana: TIntegerField;
    quFormValorHora: TBCDField;
    quFormValorHoraExtra: TBCDField;
    quFormValorHoraExtraExtra: TBCDField;
    pnlWorkHour: TPanel;
    Label12: TLabel;
    Label19: TLabel;
    Label38: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    Label25: TLabel;
    DBEdit4: TDBEdit;
    quAccountNumDocumento: TStringField;
    grdObjetoNumDocumento: TdxDBGridMaskColumn;
    DBDateBox1: TDBDateBox;
    dtPHIni: TDateBox;
    dtPHFim: TDateBox;
    dtGHFim: TDateBox;
    dtGHIni: TDateBox;
    dtAIni: TDateBox;
    dtAFim: TDateBox;
    dtiHIni: TDateBox;
    dtIHFim: TDateBox;
    spGetPessoaRoot: TADOStoredProc;
    quFormCreationDate: TDateTimeField;
    quPurchaseHistoryQty: TBCDField;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure TipoCliChange(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btPHGoClick(Sender: TObject);
    procedure btGHGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAGoClick(Sender: TObject);
    procedure btIHGoClick(Sender: TObject);
    procedure scPessoaTipoSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure dsTermStateChange(Sender: TObject);
    procedure quTermNewRecord(DataSet: TDataSet);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure grdTermKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quAccountAfterOpen(DataSet: TDataSet);
    procedure dtPHIniChange(Sender: TObject);
    procedure dtPHFimChange(Sender: TObject);
    procedure EditFederalIDKeyPress(Sender: TObject; var Key: Char);
    procedure EditFederalIDExit(Sender: TObject);
    procedure DBEdit12KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit12Exit(Sender: TObject);
  private
    { Private declarations }
    IsSalesPerson, IsVendor,
    IsGuide, IsCustomer,
    IsAgency, IsCommission, IsManufMant : Boolean;

    PessoaLabel, sPessoaPath: String;
    sIDTipoPessoa : string;

    DataIni, DataFim : TDateTime;

    function GetJuridico: boolean;

    procedure RefreshJurFis;
    procedure RefreshTipoPessoa;

    procedure TermRefresh;
    procedure TermPost;
    procedure TermCancel;
    procedure TermOpen;
    procedure TermClose;

    function DocAlreadyExists(sDoc: string; IDPessoa, iDocType: Integer): Boolean;
  protected
    procedure OnAfterNewRecord; Override;
    function  TestOnBeforeSave : boolean; override;
  end;

implementation

uses uDM, uMsgbox, xBase, uSisSenha, uDateTimeFunctions, uParamFunctions,
     uSystemConst, uDMGlobal, uValidaDocs;

{$R *.DFM}

procedure TSisPessoaFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  sIDTipoPessoa := ParseParam(Self.Param, 'IDTipoPessoa');

  if sIDTipoPessoa <> '' then
  begin
    quFormIDTipoPessoa.AsString := sIDTipoPessoa;
    RefreshTipoPessoa;
    quFormJuridico.AsBoolean := GetJuridico;
  end;

  quFormIDUser.AsInteger := SisSenha.IDUsuario;
  quFormCreationDate.AsDateTime := Now;
end;

procedure TSisPessoaFch.RefreshJurFis;
begin
  inherited;
  case TipoCli.ItemIndex of
    0:
    begin
      // Cliente fisico
      FormConfig.UniqueFields.Text := 'IDTipoPessoaRoot, Desativado, PessoaFirstName, PessoaLastName';

      quFormPessoaFirstName.Required := True;
      quFormPessoaLastName.Required := True;
      quFormPessoa.Required := False;

      pnlJuridico.Visible   := False;
      pnlFisico.Visible     := True;
      pnlBusiness.Visible   := False;
      pnlPersonal.Visible   := True;
    end;
    1:
    begin
      // Cliente juridico
      FormConfig.UniqueFields.Text := 'IDTipoPessoaRoot, Desativado, Pessoa';

      quFormPessoaFirstName.Required := False;
      quFormPessoaLastName.Required := False;
      quFormPessoa.Required := True;

      pnlJuridico.Visible   := True;
      pnlFisico.Visible     := False;
      pnlBusiness.Visible   := True;
      pnlPersonal.Visible   := False;
    end;
  end;
end;

procedure TSisPessoaFch.TipoCliChange(Sender: TObject);
begin
  inherited;
  RefreshJurFis;
end;

procedure TSisPessoaFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshTipoPessoa;
  RefreshJurFis;
end;

procedure TSisPessoaFch.RefreshTipoPessoa;
var
  Path, s: String;
begin
  inherited;
  // Descubro qual o tipo da pessoa e guardo em uma variavel
  if quFormIDTipoPessoa.AsString = '' then
    exit;

  Path := DM.DescCodigo(['IDTipoPessoa'], [quFormIDTipoPessoa.AsString],
                         'TipoPessoa', 'Path');

  sPessoaPath := Path;
  
  //Verifico se e agencia, commission, Fornecedor
  IsSalesPerson := (LeftStr(Path, 8) = '.003.001');
  IsGuide       := (LeftStr(Path, 8) = '.003.002');
  IsAgency      := (LeftStr(Path, 8) = '.003.003');
  IsCommission  := (LeftStr(Path, 4) = '.003');
  IsManufMant   := (LeftStr(Path, 4) = '.004');
  IsCustomer    := (LeftStr(Path, 4) = '.001');
  IsVendor      := (LeftStr(Path, 4) = '.002');

  // Filtro por Tipo de Pessoa
  s := Copy(Path,1,8);
  if (s = '.003.001') or
     (s = '.003.002') or
     (s = '.003.003') or
     (s = '.003.004') then
    scPessoaTipo.SpcWhereClause := 'Path LIKE ' + #39 + LeftStr(Path, 8) + '%' + #39
  else
    scPessoaTipo.SpcWhereClause := 'Path LIKE ' + #39 + LeftStr(Path, 4) + '%' + #39;

  // Controle de comissao
  lblComissaoSobreGuia.Visible := IsAgency;
  edComissaoSobreGuia.Visible  := IsAgency;
  cbDescontaCordenacao.Visible := IsGuide;

  //Estes tabs sempre ficam visiveis
  tsBasic.TabVisible      := True;
  tsAccounting.TabVisible := True;

  // Estes dependem do tipo de pessoa
  tsPurchaseHistory.TabVisible := False;
  tsInvoiceHistory.TabVisible  := False;
  tsGroupHistory.TabVisible    := False;
  tsTerm.TabVisible            := False;

  //Exbir
  if IsCustomer then
  begin
    PessoaLabel := 'Customer :';
    tsInvoiceHistory.TabVisible  := True;
    HelpContext := 7;
  end
  else if IsVendor then
  begin
    PessoaLabel := 'Vendor :';
    tsTerm.TabVisible := True;
    tsPurchaseHistory.TabVisible := True;
    HelpContext := 9;
  end
  else if IsSalesPerson then
  begin
    PessoaLabel := 'Sales Person :';
    pnlWorkHour.Visible := True;
    HelpContext := 11;
  end
  else if IsGuide then
  begin
    PessoaLabel := 'Guide :';
    tsGroupHistory.TabVisible    := True;
    HelpContext := 11;
  end
  else if IsAgency then
  begin
    PessoaLabel := 'Agency :';
    tsGroupHistory.TabVisible    := True;
    HelpContext := 11;
  end
  else if IsCommission then
  begin
    PessoaLabel := 'Name :';
    HelpContext := 11;
  end
  else if IsManufMant then
  begin
    HelpContext := 13;
  end;

  Self.EntidadeNome := Trim(Copy(PessoaLabel, 1, Length(PessoaLabel)-1));
  Self.EntidadeNome := '';
end;

procedure TSisPessoaFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  //Devido a um bug do componentete tenho que colocar o valor nulo antes
  //de abrir a query, se nao ele traz o valor anterior do campo - Rodrigo
  scPessoaTipo.SpcWhereClause := '';

  with quPurchaseHistory do
    if Active then Close;

  with quInvoiceHistory do
    if Active then Close;

  with quGroupHistory do
    if Active then Close;

  with quAccount do
    if Active then Close;

  TermClose;
end;

procedure TSisPessoaFch.btPHGoClick(Sender: TObject);
begin
  inherited;
  if not ValidTwoDates(dtPHIni.Text, dtPHFim.Text) then
    Exit;

  with quPurchaseHistory do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDTipoPessoa').Value := quFormIDPessoa.AsInteger;
    Parameters.ParamByName('DataInicio').Value := dtPHIni.Date;
    Parameters.ParamByName('DataFim').Value := dtPHFim.Date;
    Open;
  end;
end;

procedure TSisPessoaFch.btGHGoClick(Sender: TObject);
begin
  inherited;
  if not ValidTwoDates(dtGHIni.Text, dtGHFim.Text) then
    Exit;

  with quGroupHistory do
  begin
    if Active then
      Close;

    if IsAgency then
    begin
      Parameters.ParamByName('IDAgency').Value := quFormIDPessoa.AsInteger;
      Parameters.ParamByName('IDGuide').Value := Null;
    end
    else if IsGuide then
    begin
      Parameters.ParamByName('IDAgency').Value := Null;
      Parameters.ParamByName('IDGuide').Value := quFormIDPessoa.AsInteger;
    end;

    Parameters.ParamByName('DataIni').Value := dtGHIni.Date;
    Parameters.ParamByName('DataFim').Value := dtGHFim.Date;
    Open;
  end;
end;

procedure TSisPessoaFch.FormCreate(Sender: TObject);
begin
  inherited;
  PPageControl.ActivePage := tsBasic;
  
  // Seta as datas default para os filtros
  dtPHIni.Date := FirstDateMonth;
  dtPHFim.Date := LastDateMonth;

  dtIHIni.Date := FirstDateMonth;
  dtIHFim.Date := LastDateMonth;

  dtGHIni.Date := FirstDateMonth;
  dtGHFim.Date := LastDateMonth;

  dtAIni.Date  := FirstDateMonth;
  dtAFim.Date  := LastDateMonth;
end;

procedure TSisPessoaFch.btAGoClick(Sender: TObject);
begin
  inherited;
  if not ValidTwoDates(dtAIni.Text, dtAFim.Text) then
    Exit;

  with quAccount do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
    Parameters.ParamByName('Inicio').Value := dtAIni.Date;
    Parameters.ParamByName('Fim').Value := dtAFim.Date + 1;
    Open;
  end;
end;

procedure TSisPessoaFch.btIHGoClick(Sender: TObject);
begin
  inherited;
  if not ValidTwoDates(dtIHIni.Text, dtIHFim.Text) then
    Exit;
  with quInvoiceHistory do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := quFormIDPessoa.AsInteger;
    Parameters.ParamByName('DataIni').Value := dtIHIni.Date;
    Parameters.ParamByName('DataFim').Value := dtIHFim.Date;
    Open;
  end;
end;

procedure TSisPessoaFch.scPessoaTipoSelectItem(Sender: TObject);
begin
  inherited;
  quFormJuridico.AsBoolean := GetJuridico;
end;

procedure TSisPessoaFch.FormShow(Sender: TObject);
begin
  inherited;
  if pnlPersonal.Visible then
    edFirstName.SetFocus
  else
    edPessoa.SetFocus;
end;

procedure TSisPessoaFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  if PPageControl.ActivePage = tsTerm then
    TermOpen;
end;

procedure TSisPessoaFch.TermRefresh;
var
  iDueDateShift: integer;
begin
  iDueDateShift := quTermDueDateShift.AsInteger;
  TermClose;
  TermOpen;
  quTerm.Locate('DueDateShift', IntToStr(iDueDateShift), [] );
end;

procedure TSisPessoaFch.TermOpen;
begin
  with quTerm do
    if not Active then
      Open;
end;

procedure TSisPessoaFch.TermClose;
begin
  TermPost;
  quTerm.Close;
end;

procedure TSisPessoaFch.TermPost;
begin
  with quTerm do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TSisPessoaFch.TermCancel;
begin
  with quTerm do
    if State in dsEditModes then
      Cancel;
end;

procedure TSisPessoaFch.btNewClick(Sender: TObject);
begin
  inherited;
  quTerm.Insert;
  grdTerm.SetFocus;
  grdTerm.FocusedField := quTermDueDateShift;
end;

procedure TSisPessoaFch.btDeleteClick(Sender: TObject);
begin
  inherited;
  quTerm.Delete;
  dsTermStateChange(Nil);
end;

procedure TSisPessoaFch.dsTermStateChange(Sender: TObject);
begin
  inherited;
  btNew.Enabled := quTerm.Active;

  with quTerm do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quTerm.State in dsEditModes);
  btDelete.Visible := not (quTerm.State in dsEditModes);

  btPost.Visible := (quTerm.State in dsEditModes);
  btCancelPost.Visible := (quTerm.State in dsEditModes);
end;

procedure TSisPessoaFch.quTermNewRecord(DataSet: TDataSet);
begin
  inherited;
  quTermIDPessoa.AsInteger := quFormIDPessoa.AsInteger;
  quTermDiscount.AsInteger := 0;
end;

procedure TSisPessoaFch.btPostClick(Sender: TObject);
begin
  inherited;
  TermPost;
  TermRefresh;
end;

procedure TSisPessoaFch.btCancelPostClick(Sender: TObject);
begin
  inherited;
  TermCancel;
end;

procedure TSisPessoaFch.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (grdTerm.FocusedField = quTermDiscount) then
    btPostClick(nil);
end;

procedure TSisPessoaFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  if quFormJuridico.AsBoolean then
  begin
    quFormPessoaLastName.Clear;
    quFormPessoaFirstName.Clear;
  end
  else
    quFormPessoa.AsString := quFormPessoaLastName.AsString + ', ' + quFormPessoaFirstName.AsString;
end;

function TSisPessoaFch.GetJuridico: boolean;
begin
  result := not (IsCustomer or IsGuide or IsSalesPerson);
end;

procedure TSisPessoaFch.quAccountAfterOpen(DataSet: TDataSet);
var
  ReceberVencido,
  ReceberAVencer,
  TotalRecebido,
  PagarVencido,
  PagarAVencer,
  TotalPago:  Currency;
begin
  inherited;
  // calcula os totais da conta corrente
  with quAccount do
  begin
    DisableControls;

    ReceberVencido := 0;
    ReceberAVencer := 0;
    TotalRecebido  := 0;
    PagarVencido   := 0;
    PagarAVencer   := 0;
    TotalPago      := 0;

    First;
    while not EOF do
    begin
      if quAccountPagando.AsBoolean then
      begin
        // Pagando
        TotalPago := TotalPago + quAccountTotalQuitado.AsCurrency;

        if Trunc(quAccountDataVencimento.AsDateTime) > Date then
        begin
          // A Pagar A Vencer
          PagarAVencer := PagarAVencer +
                          quAccountValorNominal.AsCurrency -
                          quAccountTotalQuitado.AsCurrency;
        end
        else
        begin
          // A Pagar A Vencido
          PagarVencido := PagarVencido +
                          quAccountValorNominal.AsCurrency -
                          quAccountTotalQuitado.AsCurrency;
        end;
      end
      else
      begin
        // Recebendo
        TotalRecebido := TotalRecebido + quAccountTotalQuitado.AsCurrency;

        if Trunc(quAccountDataVencimento.AsDateTime) > Date then
        begin
          // A Receber A Vencer
          ReceberAVencer := ReceberAVencer +
                            quAccountValorNominal.AsCurrency -
                            quAccountTotalQuitado.AsCurrency;
        end
        else
        begin
          // A Receber A Vencido
          ReceberVencido := ReceberVencido +
                            quAccountValorNominal.AsCurrency -
                            quAccountTotalQuitado.AsCurrency;
        end;
      end;

      Next;
    end;

    First;
    EnableControls;
  end;

  lblReceberVencido.Caption := FormatFloat(ffValor, ReceberVencido);
  lblReceberAVencer.Caption := FormatFloat(ffValor, ReceberAVencer);
  lblTotalRecebido.Caption  := FormatFloat(ffValor, TotalRecebido);
  lblPagarVencido.Caption   := FormatFloat(ffValor, PagarVencido);
  lblPagarAVencer.Caption   := FormatFloat(ffValor, PagarAVencer);
  lblTotalPago.Caption      := FormatFloat(ffValor, TotalPago);
end;

procedure TSisPessoaFch.dtPHIniChange(Sender: TObject);
begin
  inherited;
  DataIni := TdxDateEdit(Sender).Date;
end;

procedure TSisPessoaFch.dtPHFimChange(Sender: TObject);
begin
  inherited;
  DataFim := TdxDateEdit(Sender).Date;
end;

procedure TSisPessoaFch.OnAfterNewRecord;
begin
  inherited;
  with spGetPessoaRoot do
  begin
    Parameters.ParamByName('@IDTipoPessoa').Value := sIDTipoPessoa;
    Parameters.ParamByName('@IDPessoa').Value := quFormIDPessoa.AsInteger;
    ExecProc;
    quFormCode.AsString := Parameters.ParamByName('@Code').Value;
    quFormIDTipoPessoaRoot.AsInteger := Parameters.ParamByName('@IDTipoPessoaRoot').Value;
  end;
end;

function TSisPessoaFch.DocAlreadyExists(sDoc: string; IDPessoa,
  iDocType: Integer): Boolean;
var
  sField : String;
  sSQL : String;
begin
  Result := False;

  if iDocType = 1 then
    sField := ' P.CPF '
  else
    sField := ' P.InscEstadual ';

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    sSQL := Format('SELECT '+ sField +
                   ' FROM Pessoa P (NOLOCK) ' +
                   ' JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa) ' +
                   'WHERE '+ sField + ' = %S AND P.IDPessoa <> %D AND TP.Path Like %S', [QuotedStr(sDoc), IDPessoa, QuotedStr(sPessoaPath + '%')]);
    SQL.Add(sSQL);

    Open;
    Result := not IsEmpty;
  finally
    Close;
  end;
end;

function TSisPessoaFch.TestOnBeforeSave: boolean;
begin

  Result := True;
  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) then
  begin

    if (Trim(DBEdit12.Text) <> '') and DocAlreadyExists(DBEdit12.Text, quFormIDPessoa.AsInteger, 1) then
    begin
      MsgBox('CPF já cadastrado!', vbCritical);
      Result := False;
    end;

    if (Trim(EditFederalID.Text) <> '') and DocAlreadyExists(EditFederalID.Text, quFormIDPessoa.AsInteger, 2) then
    begin
      MsgBox('CNPJ já cadastrado!', vbCritical);
      Result := False;
    end;

  end;

end;

procedure TSisPessoaFch.EditFederalIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if DMGlobal.IDLanguage = LANG_PORTUGUESE then
  begin
    if not (Key in ['0'..'9', #8]) then
    Key := #0;
  end;

end;

procedure TSisPessoaFch.EditFederalIDExit(Sender: TObject);
begin
  inherited;

  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) and
     (Length(EditFederalID.Text) > 0) and
     (TipoCli.ItemIndex = 1) then
     if not ValidaCNPJ(EditFederalID.Text) then
        begin
        MsgBox('Documento Invalido ' + ' ('+Label17.Caption+')', vbCritical + vbOkOnly);
        EditFederalID.SetFocus;
        end;
  
end;

procedure TSisPessoaFch.DBEdit12KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if DMGlobal.IDLanguage = LANG_PORTUGUESE then
  begin
    if not (Key in ['0'..'9', #8]) then
    Key := #0;
  end;
  
end;

procedure TSisPessoaFch.DBEdit12Exit(Sender: TObject);
begin
  inherited;

  if (DMGlobal.IDLanguage = LANG_PORTUGUESE) and
     (Length(DBEdit12.Text) > 0) and
     (TipoCli.ItemIndex = 0) then
  begin
     if not ValidaCPF(DBEdit12.Text) then
        begin
        MsgBox('Documento Invalido ' + '('+Label16.Caption+')', vbCritical + vbOkOnly);
        DBEdit12.SetFocus;
        end;
  end;

end;

initialization
  RegisterClass(TSisPessoaFch);

end.
