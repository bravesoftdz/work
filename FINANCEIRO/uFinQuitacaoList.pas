unit uFinQuitacaoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus,
  DBTables, Grids, StdCtrls, ExtCtrls, Buttons, Mask,
  uFinLancamentoFch, dxBar, uParentList,
  dxDBGridPrint, dxBarExtItems, dxCntner, dxTL, dxDBGrid, dxGrClms,
  dxDBCGrid, dxDateEdit, ImgList, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery,
  SuperComboADO, dxEditor, dxExEdtr, dxEdLib, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinQuitacaoList = class(TParentList)
    dbInicio: TdxDateEdit;
    Label2: TLabel;
    dbFim: TdxDateEdit;
    pnlAviso: TPanel;
    btGo: TButton;
    scQuitacaoMeio: TSuperComboADO;
    Label3: TLabel;
    btTodasPessoas: TButton;
    Label1: TLabel;
    trmGO: TTimer;
    pnlLancamento: TPanel;
    Panel6: TPanel;
    pnlBrwQuitMulti: TPanel;
    Panel3: TPanel;
    lblLines: TLabel;
    wfsldkfiosdufciosuyixch: TPanel;
    Panel4: TPanel;
    btDetalhe: TSpeedButton;
    btMostra: TSpeedButton;
    dsLancamento: TDataSource;
    quLancamento: TPowerADOQuery;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoTotalQuitado: TFloatField;
    quLancamentoValorNominal: TFloatField;
    quLancamentoDataVencimento: TDateTimeField;
    quLancamentoLancamentoTipo: TStringField;
    quLancamentoCentroCusto: TStringField;
    quLancamentoPessoa: TStringField;
    quLancamentoDataEmissao: TDateTimeField;
    quLancamentoPagando: TBooleanField;
    lblTotal: TLabel;
    lblJuros: TLabel;
    bbImprimeCheque: TdxBarButton;
    bbImprimeCopia: TdxBarButton;
    bsImprime: TdxBarSubItem;
    dxDBCGrid1: TdxDBCGrid;
    dxDBCGrid1IDLancamento: TdxDBGridMaskColumn;
    dxDBCGrid1ValorNominal: TdxDBGridMaskColumn;
    dxDBCGrid1DataVencimento: TdxDBGridDateColumn;
    dxDBCGrid1LancamentoTipo: TdxDBGridMaskColumn;
    dxDBCGrid1Pessoa: TdxDBGridMaskColumn;
    brwGridIDQuitacao: TdxDBGridMaskColumn;
    brwGridDataQuitacao: TdxDBGridDateColumn;
    brwGridNumeroMeioQuit: TdxDBGridMaskColumn;
    brwGridValorQuitacao: TdxDBGridMaskColumn;
    brwGridValorJuros: TdxDBGridMaskColumn;
    brwGridNumero: TdxDBGridMaskColumn;
    brwGridQuitacaoMeio: TdxDBGridMaskColumn;
    brwGridUsuario: TdxDBGridMaskColumn;
    quBrowseIDQuitacao: TIntegerField;
    quBrowseDataQuitacao: TDateTimeField;
    quBrowseDataDesbloqueio: TDateTimeField;
    quBrowseNumeroMeioQuit: TStringField;
    quBrowseValorQuitacao: TFloatField;
    quBrowseValorJuros: TFloatField;
    quBrowseCodigoContaCorrente: TStringField;
    quBrowseNumero: TStringField;
    quBrowseCodigoQuitacaoMeio: TStringField;
    quBrowseQuitacaoMeio: TStringField;
    quBrowseIdentificadorDocumento: TStringField;
    quBrowseDiasRetencao: TIntegerField;
    quBrowseTaxaDesconto: TFloatField;
    quBrowseCodigoUsuario: TStringField;
    quBrowseUsuario: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure dbInicioChange(Sender: TObject);
    procedure dbFimChange(Sender: TObject);
    procedure scQuitacaoMeioSelectItem(Sender: TObject);
    procedure btTodasPessoasClick(Sender: TObject);
    procedure btGoClick(Sender: TObject);
    procedure trmGOTimer(Sender: TObject);
    procedure btMostraClick(Sender: TObject);
    procedure quLancamentoAfterOpen(DataSet: TDataSet);
    procedure dsLancamentoDataChange(Sender: TObject; Field: TField);
    procedure grdLancamentoDblClick(Sender: TObject);
    procedure btDetalheClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btChequeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbImprimeChequeClick(Sender: TObject);
    procedure bbImprimeCopiaClick(Sender: TObject);
    procedure dxDBCGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FinLancamentoFch: TFinLancamentoFch;

    procedure OnAfterStart; Override;
    procedure OnBeforeDeleteItem; Override;

  public
    { Public declarations }
    function  ListParamRefresh : integer; override;
  end;

implementation

{$R *.DFM}

uses uFinChequeBradescoQrp, uFinChequeCopiaQrp, uFinQuitacaoFch, uMsgBox, uDM,
     uDateTimeFunctions, uSystemTypes, uMsgConstant;

function TFinQuitacaoList.ListParamRefresh : integer;
var
  InicioStr, FimStr: String;
begin

  // Testa se das datas de período são válidas
  if not TestDate(dbInicio.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_INIDATE, vbCritical + vbOkOnly);
      dbInicio.SetFocus;
      Exit;
    end;

  if not TestDate(dbFim.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbCritical + vbOkOnly);
      dbFim.SetFocus;
      Exit;
    end;

  // altera qual o filtro por data
  InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
  FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);

  WhereBasicFilter[4] := ' (DataQuitacao >= ' + InicioStr + ' AND DataQuitacao < ' + FimStr + ') ';

  // Altera o filtro por QuitacaoMeio
  if scQuitacaoMeio.LookUpValue = '' then
    WhereBasicFilter[5] := ''
  else
    WhereBasicFilter[5] := ' Q.IDQuitacaoMeio = ' + scQuitacaoMeio.LookUpValue;

  ListRefresh;
  trmGo.Enabled := False;
  pnlAviso.ParentColor := True;

end;

procedure TFinQuitacaoList.FormCreate(Sender: TObject);
begin
  inherited;
  dbInicio.Date := InicioMes(Date());
  dbFim.Date    := FimMes(Date());

end;

procedure TFinQuitacaoList.dbInicioChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinQuitacaoList.dbFimChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinQuitacaoList.scQuitacaoMeioSelectItem(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinQuitacaoList.btTodasPessoasClick(Sender: TObject);
begin
  inherited;
  scQuitacaoMeio.LookUpValue := '';
  trmGo.Enabled := True;

end;

procedure TFinQuitacaoList.btGoClick(Sender: TObject);
begin
  inherited;

  ListParamRefresh;

end;


procedure TFinQuitacaoList.trmGOTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor then
    pnlAviso.Color := clMaroon
  else
    pnlAviso.ParentColor := True;

end;


procedure TFinQuitacaoList.OnAfterStart;
begin
  // Controla o modo de abertura do Browse

  if MyParametro =  'Pagamentos' then
    begin
      WhereBasicFilter[1] := 'Pagando = 1';
    end
  else if MyParametro = 'Recebimentos' then
    begin
      WhereBasicFilter[1] := 'Pagando = 0';
    end;

end;

procedure TFinQuitacaoList.btMostraClick(Sender: TObject);
begin
  inherited;
  pnlLancamento.Visible := btMostra.Down;

  if pnlLancamento.Visible then
    begin
      quLancamento.Open;
    end
  else
    begin
      quLancamento.Close;
    end;

end;



procedure TFinQuitacaoList.quLancamentoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblLines.Caption := IntToStr(quLancamento.RecordCount) + ' Linha(s).';
end;

procedure TFinQuitacaoList.dsLancamentoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with quLancamento do
    btDetalhe.Enabled := not (EOF AND BOF);

end;

procedure TFinQuitacaoList.grdLancamentoDblClick(Sender: TObject);
begin
  inherited;
  if btDetalhe.Enabled then
    btDetalheClick(nil);

end;

procedure TFinQuitacaoList.btDetalheClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  inherited;
  if FinLancamentoFch = nil then
    FinLancamentoFch := TFinLancamentoFch.Create(Self);

  ID1 := quLancamentoIDLancamento.AsString;

  if FinLancamentoFch.Start(btAlt, nil, False, ID1, ID2, '', MyUserRights, nil) then
    ListRefresh;

end;

procedure TFinQuitacaoList.quBrowseAfterOpen(DataSet: TDataSet);
var
  Tot,
  Juros : double;

begin
  inherited;
  with quBrowse do
    begin
      DisableControls;
      First;
      Tot := 0;
      Juros := 0;
      while not EOF do
        begin
          Tot   := Tot   + (quBrowseValorQuitacao.AsCurrency);
          Juros := Juros + (quBrowseValorJuros.AsCurrency);
          Next;
        end;
      First;
      EnableControls;
    end;

  if MyParametro = 'Pagamentos' then
    lblTotal.Caption := 'Total Pagamentos: ' + FloatToStrF(Tot, ffCurrency, 20, 2)
  else
    lblTotal.Caption := 'Total Recebimentos: ' + FloatToStrF(Tot, ffCurrency, 20, 2);

  lblJuros.Caption := 'Total Juros: ' + FloatToStrF(Juros, ffCurrency, 20, 2);

end;



procedure TFinQuitacaoList.OnBeforeDeleteItem;
begin
  // Delete as ligações entre as quitacaoes e os lancamentos
  DM.RunSQL('DELETE Fin_LancQuit WHERE IDQuitacao = ' + quBrowseIDQuitacao.AsString);
end;


procedure TFinQuitacaoList.btChequeClick(Sender: TObject);
var
  Where: String;
  i: integer;

begin
  inherited;

  if brwGrid.SelectedCount = 0 then
    begin
      MsgBox(MSG_CRT_NO_RECORD_TO_PRINT, vbCritical + vbOkOnly);
      Exit;
    end;

  // Monta a clausula where com as quitacaoes selecionadas
  try
    with quBrowse do
      begin
        DisableControls;
        if brwGrid.SelectedCount > 1 then
          begin
            for i := 0 to brwGrid.SelectedCount - 1 do
              begin
                Bookmark := brwGrid.SelectedRows[i];
                if Where <> '' then
                  Where := Where + ' OR '
                else
                  Where := 'WHERE ';
                Where := Where + '(IDQuitacao = ' + FieldByName('IDQuitacao').asString + ')';
              end;
          end
        else
          begin
            Where := 'WHERE IDQuitacao = ' + FieldByName('IDQuitacao').asString;
          end;

        with TFinChequeBradescoQrp.Create(self) do
          begin
            Start(Where);
            Free;
          end;
      end;
  finally
    quBrowse.EnableControls;
  end;


end;

procedure TFinQuitacaoList.FormShow(Sender: TObject);
begin
  inherited;
  //btCheque.Visible := (Application.Title = 'Suporte Informática');

end;

procedure TFinQuitacaoList.bbImprimeChequeClick(Sender: TObject);
var
  Where: String;
  i: integer;

begin
  inherited;

  if brwGrid.SelectedCount = 0 then
    begin
      MsgBox(MSG_CRT_NO_RECORD_TO_PRINT, vbCritical + vbOkOnly);
      Exit;
    end;

  // Monta a clausula where com as quitacaoes selecionadas
  try
    with quBrowse do
      begin
        DisableControls;
        if brwGrid.SelectedCount > 1 then
          begin
            for i := 0 to brwGrid.SelectedCount - 1 do
              begin
                Bookmark := brwGrid.SelectedRows[i];
                if Where <> '' then
                  Where := Where + ' OR '
                else
                  Where := 'WHERE ';
                Where := Where + '(IDQuitacao = ' + FieldByName('IDQuitacao').asString + ')';
              end;
          end
        else
          begin
            Where := 'WHERE IDQuitacao = ' + FieldByName('IDQuitacao').asString;
          end;

        with TFinChequeBradescoQrp.Create(self) do
          begin
            Start(Where);
            Free;
          end;
      end;
  finally
    quBrowse.EnableControls;
  end;
end;

procedure TFinQuitacaoList.bbImprimeCopiaClick(Sender: TObject);
var
  Where: String;
  i: integer;

begin
  inherited;

  if brwGrid.SelectedCount = 0 then
    begin
      MsgBox(MSG_CRT_NO_RECORD_TO_PRINT, vbCritical + vbOkOnly);
      Exit;
    end;

  // Monta a clausula where com as quitacaoes selecionadas
  with brwGrid,brwGrid.datasource.dataset do
    begin
      DisableControls;
      for i:= 0 to SelectedCount-1 do
        begin
       	  BookMark := SelectedRows[i];

          if Where <> '' then
            Where := Where + ' OR '
          else
            Where := 'WHERE ';


       	  Where := Where + '(IDQuitacao = ' + FieldByName('IDQuitacao').asString + ')';
        end;
      EnableControls;
    end;

  // Realiza a impressao dos cheques
  with TFinChequeCopiaQrp.Create(self) do
    begin
      Start(Where);
      Free;
    end;
end;

procedure TFinQuitacaoList.dxDBCGrid1DblClick(Sender: TObject);
begin
  inherited;
  if btDetalhe.Enabled then
    btDetalheClick(nil);

end;

Initialization
  RegisterClass(TFinQuitacaoList);


end.

