unit uFinEmprestimoFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Db,
  DBClient, Mask, SuperComboADO, DBCtrls, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, dxDBELib, ADODB;

type
  TFinEmprestimoFrm = class(TParentDialogFrm)
    dsEmprestimo: TDataSource;
    cdsEmprestimo: TClientDataSet;
    cdsEmprestimoIDUsuarioQuitacao: TIntegerField;
    Label1: TLabel;
    scUser: TDBSuperComboADO;
    Label6: TLabel;
    cdsEmprestimoIDEmpresa: TIntegerField;
    Label14: TLabel;
    scCompany: TDBSuperComboADO;
    Label15: TLabel;
    cdsEmprestimoIDCentroCusto: TIntegerField;
    dcCostCenter: TDBSuperComboADO;
    Label2: TLabel;
    cdsEmprestimoIDPessoa: TIntegerField;
    lblPessoa: TLabel;
    scPessoa: TDBSuperComboADO;
    Label9: TLabel;
    lblPessoaTipo: TLabel;
    scPessoaTipo: TDBSuperComboADO;
    Label7: TLabel;
    cdsEmprestimoValorEmprestimo: TCurrencyField;
    Label8: TLabel;
    edtAmount: TDBEdit;
    Label3: TLabel;
    cdsEmprestimoIDPessoaTipo: TIntegerField;
    cdsEmprestimoMemo: TStringField;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    GroupBox1: TGroupBox;
    cdsEmprestimoIDQuitacaoMeio: TIntegerField;
    cdsEmprestimoIDContaCorrente: TIntegerField;
    lblContaCorrente: TLabel;
    scContaCorrente: TDBSuperComboADO;
    Label5: TLabel;
    lblQuitacaoMeio: TLabel;
    scQuitacaoMeio: TDBSuperComboADO;
    lbQuitStart: TLabel;
    cdsEmprestimoIDLancamentoTipo: TIntegerField;
    lblLancamentoTipo: TLabel;
    scLancamentoTipo: TDBSuperComboADO;
    Label12: TLabel;
    lblNumDocQuitacao: TLabel;
    DocQuit: TDBEdit;
    cdsEmprestimoNumeroMeioQuit: TStringField;
    Label10: TLabel;
    edtDataQuitacao: TdxDBDateEdit;
    Label11: TLabel;
    cdsEmprestimoDataQuitacao: TDateTimeField;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    scLancaTipo: TDBSuperComboADO;
    Label16: TLabel;
    cdsEmprestimoIDLancamentoTipoPay: TIntegerField;
    cdsEmprestimoDataPay: TDateTimeField;
    Label17: TLabel;
    edtPayDate: TdxDBDateEdit;
    Label18: TLabel;
    cmdInsertLancamento: TADOCommand;
    cmdInsertQuitacao: TADOCommand;
    cmdInsertLancQuit: TADOCommand;
    cdsEmprestimoIDDocumentoTipo: TIntegerField;
    lblDocumentoTipo: TLabel;
    scDocumentoTipo: TDBSuperComboADO;
    procedure scPessoaTipoSelectItem(Sender: TObject);
    procedure cdsEmprestimoNewRecord(DataSet: TDataSet);
    procedure btOkClick(Sender: TObject);
  private
    CurrentIDPessoaTipo: String;

    procedure AddPessoaFilter;
    function ValidadeFields : Boolean;
    function InsertValues : Boolean;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uSisSenha, uMsgBox, uSystemTypes, uParamFunctions, uSystemConst,
  uMsgConstant, uDMGlobal, uComboFiltroFunctions;

{$R *.DFM}

{ TFinEmprestimoFrm }

function TFinEmprestimoFrm.Start: Boolean;
begin
  cdsEmprestimo.CreateDataSet;
  cdsEmprestimo.Append;
  CurrentIDPessoaTipo := '4';

  ShowModal;
  Result := True;
end;

procedure TFinEmprestimoFrm.scPessoaTipoSelectItem(Sender: TObject);
begin
  inherited;

  if CurrentIDPessoaTipo <> cdsEmprestimoIDPessoa.AsString then
  begin
    cdsEmprestimoIDPessoa.Clear;
    PessoaSetFilter(scPessoaTipo, scPessoa, cdsEmprestimoIDPessoa.AsString);
    AddPessoaFilter;
  end;

end;

procedure TFinEmprestimoFrm.AddPessoaFilter;
begin
  with DM.quPessoa do
  begin
    FilterFields.Clear;
    FilterValues.Clear;
    FilterFields.Add('IDTipoPessoa');
    FilterValues.Add(scPessoaTipo.LookUpvalue);
  end;
end;

procedure TFinEmprestimoFrm.cdsEmprestimoNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsEmprestimoIDEmpresa.AsInteger         := DM.IDDefaultCompany;
  cdsEmprestimoIDUsuarioQuitacao.AsInteger := SisSenha.IDUsuario;
  cdsEmprestimoDataQuitacao.AsDateTime     := Now;
  
end;

function TFinEmprestimoFrm.ValidadeFields: Boolean;
begin

  Result := False;

  if cdsEmprestimoIDUsuarioQuitacao.AsInteger = 0 then
  begin
    MsgBox(MSG_INF_SELECT_USER, vbCritical + vbOkOnly);
    scUser.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDEmpresa.AsInteger = 0 then
  begin
    MsgBox(MSG_CRT_NO_COMPANY_SELECTED, vbCritical + vbOkOnly);
    scCompany.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDPessoa.AsInteger = 0 then
  begin
    MsgBox(MSG_CRT_THERE_IS_NO_VENDOR, vbCritical + vbOkOnly);
    scPessoa.SetFocus;
    Exit;
  end;

  if cdsEmprestimoValorEmprestimo.AsCurrency = 0 then
  begin
    MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
    edtAmount.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDLancamentoTipo.AsInteger = 0 then
  begin
    MsgBox(MSG_CRT_NO_RECORD, vbCritical + vbOkOnly);
    scLancamentoTipo.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDContaCorrente.AsInteger = 0 then
  begin
    MsgBox(MSG_INF_CHOOSE_BANK, vbCritical + vbOkOnly);
    scContaCorrente.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDQuitacaoMeio.AsInteger = 0 then
  begin
    MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbCritical + vbOkOnly);
    scQuitacaoMeio.SetFocus;
    Exit;
  end;

  if cdsEmprestimoDataQuitacao.IsNull then
  begin
    MsgBox(MSG_CRT_NO_DATE, vbCritical + vbOkOnly);
    edtDataQuitacao.SetFocus;
    Exit;
  end;

  if cdsEmprestimoIDLancamentoTipoPay.AsInteger = 0 then
  begin
    MsgBox(MSG_CRT_NO_RECORD, vbCritical + vbOkOnly);
    scLancaTipo.SetFocus;
    Exit;
  end;

  if cdsEmprestimoDataPay.IsNull then
  begin
    MsgBox(MSG_CRT_NO_DATE, vbCritical + vbOkOnly);
    edtPayDate.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TFinEmprestimoFrm.btOkClick(Sender: TObject);
begin
  inherited;

  if cdsEmprestimo.State in dsEditModes then
    cdsEmprestimo.Post;

  if not ValidadeFields then
    ModalResult := mrNone
  else
    InsertValues;

end;

function TFinEmprestimoFrm.InsertValues: Boolean;
var
  IDLanc, IDQuit : Integer;
begin

  Result := True;

  try

    DM.DBADOConnection.BeginTrans;

    IDLanc := DM.GetNextID('Fin_Lancamento.IDLancamento');

    with cmdInsertLancamento do
    begin
      Parameters.ParamByName('IDLancamento').Value        := IDLanc;
      Parameters.ParamByName('IDPessoaTipo').Value        := cdsEmprestimoIDPessoaTipo.AsInteger;
      Parameters.ParamByName('IDEmpresa').Value           := cdsEmprestimoIDEmpresa.AsInteger;
      Parameters.ParamByName('IDPessoa').Value            := cdsEmprestimoIDPessoa.AsInteger;
      Parameters.ParamByName('IDUsuarioLancamento').Value := cdsEmprestimoIDUsuarioQuitacao.AsInteger;
      Parameters.ParamByName('IDCentroCusto').Value       := cdsEmprestimoIDCentroCusto.Value;
      Parameters.ParamByName('IDLancamentoTipo').Value    := cdsEmprestimoIDLancamentoTipo.AsInteger;
      Parameters.ParamByName('Situacao').Value            := 2;
      Parameters.ParamByName('DataLancamento').Value      := Now;
      Parameters.ParamByName('DataEmissao').Value         := Now;
      Parameters.ParamByName('DataVencimento').Value      := cdsEmprestimoDataQuitacao.AsDateTime;
      Parameters.ParamByName('Pagando').Value             := 0;
      Parameters.ParamByName('ValorNominal').Value        := cdsEmprestimoValorEmprestimo.AsCurrency;
      Parameters.ParamByName('Historico').Value           := cdsEmprestimoMemo.AsString;
      Parameters.ParamByName('IDDocumentoTipo').Value     := cdsEmprestimoIDDocumentoTipo.AsInteger;
      Execute;
    end;


    IDQuit := DM.GetNextID('Fin_Lancamento.IDLancamento');

    with cmdInsertQuitacao do
    begin
      Parameters.ParamByName('IDQuitacao').Value         := IDQuit;
      Parameters.ParamByName('IDQuitacaoMeio').Value     := cdsEmprestimoIDQuitacaoMeio.AsInteger;
      Parameters.ParamByName('IDContaCorrente').Value    := cdsEmprestimoIDContaCorrente.AsInteger;
      Parameters.ParamByName('IDUsuarioQuitacao').Value  := cdsEmprestimoIDUsuarioQuitacao.AsInteger;
      Parameters.ParamByName('Pagando').Value            := 0;
      Parameters.ParamByName('ValorQuitacao').Value      := cdsEmprestimoValorEmprestimo.AsCurrency;
      Parameters.ParamByName('DataQuitacao').Value       := cdsEmprestimoDataQuitacao.AsDateTime;
      Parameters.ParamByName('NumeroMeioQuit').Value     := cdsEmprestimoNumeroMeioQuit.AsString;
      Execute;
    end;


    with cmdInsertLancQuit do
    begin
      Parameters.ParamByName('IDQuitacao').Value        := IDQuit;
      Parameters.ParamByName('IDLancamento').Value      := IDLanc;
      Parameters.ParamByName('ValorQuitado').Value      := cdsEmprestimoValorEmprestimo.AsCurrency;
      Parameters.ParamByName('IDUsuarioQuitacao').Value := cdsEmprestimoIDUsuarioQuitacao.AsInteger;
      Parameters.ParamByName('DataQuitacao').Value      := cdsEmprestimoDataQuitacao.AsDateTime;
      Execute;
    end;

    //Contas a Pagar
    IDLanc := DM.GetNextID('Fin_Lancamento.IDLancamento');

    with cmdInsertLancamento do
    begin
      Parameters.ParamByName('IDLancamento').Value        := IDLanc;
      Parameters.ParamByName('IDPessoaTipo').Value        := cdsEmprestimoIDPessoaTipo.AsInteger;
      Parameters.ParamByName('IDEmpresa').Value           := cdsEmprestimoIDEmpresa.AsInteger;
      Parameters.ParamByName('IDPessoa').Value            := cdsEmprestimoIDPessoa.AsInteger;
      Parameters.ParamByName('IDUsuarioLancamento').Value := cdsEmprestimoIDUsuarioQuitacao.AsInteger;
      Parameters.ParamByName('IDCentroCusto').Value       := cdsEmprestimoIDCentroCusto.Value;
      Parameters.ParamByName('IDLancamentoTipo').Value    := cdsEmprestimoIDLancamentoTipoPay.AsInteger;
      Parameters.ParamByName('Situacao').Value            := 1;
      Parameters.ParamByName('DataLancamento').Value      := Now;
      Parameters.ParamByName('DataEmissao').Value         := Now;
      Parameters.ParamByName('DataVencimento').Value      := cdsEmprestimoDataPay.AsDateTime;
      Parameters.ParamByName('Pagando').Value             := 1;
      Parameters.ParamByName('ValorNominal').Value        := cdsEmprestimoValorEmprestimo.AsCurrency;
      Parameters.ParamByName('Historico').Value           := cdsEmprestimoMemo.AsString;
      Parameters.ParamByName('IDDocumentoTipo').Value     := cdsEmprestimoIDDocumentoTipo.AsInteger;
      Execute;
    end;

    DM.DBADOConnection.CommitTrans;

  except
    DM.DBADOConnection.RollBackTrans;
    Raise;
    Result := False;
  end;
end;

Initialization
  RegisterClass(TFinEmprestimoFrm);


end.
