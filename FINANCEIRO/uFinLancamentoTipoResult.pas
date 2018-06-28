unit uFinLancamentoTipoResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk,
  ADODB, Menus, ExtCtrls, dxDBGridPrint, dxBar, BrowseConfig, Db,
  PowerADOQuery, ImgList, dxBarExtItems, siComp, siLangRT, dxCntner, dxTL,
  dxDBCtrl, dxDBGrid, StdCtrls, Provider, DBClient, dxDBTLCl, dxGrClms,
  Mask, DateBox, Buttons, ComCtrls;

type
  TFinLancamentoTipoResult = class(TParentList)
    cdsBrowser: TClientDataSet;
    dspBrowser: TDataSetProvider;
    brwGridAccountCode: TdxDBGridMaskColumn;
    brwGridRecordType: TdxDBGridMaskColumn;
    brwGridAmount: TdxDBGridCurrencyColumn;
    brwGridPreviousBalance: TdxDBGridCurrencyColumn;
    brwGridActualBalace: TdxDBGridCurrencyColumn;
    cmbData: TComboBox;
    dbInicio: TDateBox;
    dbFim: TDateBox;
    Label2: TLabel;
    pnlEmpresa: TPanel;
    lvEmpresa: TListView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Splitter2: TSplitter;
    btSelEmpresa: TSpeedButton;
    cdsBrowserIDLancamentoTipo: TIntegerField;
    cdsBrowserAccountCode: TStringField;
    cdsBrowserRecordType: TStringField;
    cdsBrowserIDLancamentoTipoParent: TIntegerField;
    brwGridIDLancamentoTipo: TdxDBGridColumn;
    quBrowseIDLancamentoTipo: TIntegerField;
    quBrowseAccountCode: TStringField;
    quBrowseRecordType: TStringField;
    quBrowseIDLancamentoTipoParent: TIntegerField;
    quSaldo: TPowerADOQuery;
    quSaldoIDLancamentoTipoParent: TIntegerField;
    quSaldoCodigoContabil: TStringField;
    quSaldoAnterior: TPowerADOQuery;
    quSaldoAnteriorIDLancamentoTipoParent: TIntegerField;
    quSaldoAnteriorCodigoContabil: TStringField;
    quSaldoIDLancamentoTipo: TIntegerField;
    quSaldoAnteriorIDLancamentoTipo: TIntegerField;
    quBrowseAmount: TBCDField;
    quBrowsePreviousBalance: TBCDField;
    quBrowseActualBalace: TBCDField;
    cdsBrowserAmount: TBCDField;
    cdsBrowserPreviousBalance: TBCDField;
    cdsBrowserActualBalace: TBCDField;
    quBrowsePagando: TBooleanField;
    cdsBrowserPagando: TBooleanField;
    quBrowseAccType: TStringField;
    cdsBrowserAccType: TStringField;
    brwGridAccType: TdxDBGridColumn;
    cbxHideZeros: TCheckBox;
    Label1: TLabel;
    cmbSituacao: TComboBox;
    lbStartBalance: TLabel;
    edtStartBalance: TDateBox;
    chkInterest: TCheckBox;
    quSaldoAnteriorValorNominal: TBCDField;
    quSaldoAnteriorJuros: TBCDField;
    quSaldoAnteriorAmount: TCurrencyField;
    quSaldoValorNominal: TBCDField;
    quSaldoJuros: TBCDField;
    quSaldoAmount: TCurrencyField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btSelEmpresaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure brwGridCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure brwGridSummaryGroups0SummaryItems1Summary(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure brwGridSummaryGroups0SummaryItems0Summary(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure brwGridSummaryGroups0SummaryItems2Summary(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure brwGridAmountSummaryFooter(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure brwGridPreviousBalanceSummaryFooter(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure brwGridActualBalaceSummaryFooter(Sender: TObject;
      DataSet: TDataSet; var Value: Extended);
    procedure quSaldoAnteriorCalcFields(DataSet: TDataSet);
    procedure quSaldoCalcFields(DataSet: TDataSet);
  private
    sReceive,
    sPay : String;

    AccRecPreview,
    AccRecAmount,
    AccPayPreview,
    AccPayAmount : Currency;

    procedure OpenList;
    procedure CloseList;
    procedure RefreshList;

    procedure OpenSaldos;
    procedure CloseSaldos;

    procedure FillValues;
    procedure UpdateTreeItem(IDLancamentoTipo : Integer; AAmount : Currency; AField : TBCDField);
  protected
    procedure OnAfterStart; override;
  public
    function  ListParamRefresh : integer; override;
  end;

implementation

uses uDM, uSystemTypes, uMsgBox, uMsgConstant, uDateTimeFunctions,
  uSQLFunctions, uDMGlobal;

{$R *.DFM}

procedure TFinLancamentoTipoResult.OnAfterStart;
begin
  inherited;

  dbInicio.Date             := InicioMes(Date());
  dbFim.Date                := FimMes(Date());
  edtStartBalance.Date      := EncodeDate(StrToInt(FormatDateTime('yyyy', Now)), 1, 1);;
  pnlEmpresa.Width          := 1;
  cmbData.ItemIndex         := 0;
  brwGrid.ShowRowFooter     := True;
  brwGrid.ShowSummaryFooter := True;
  cmbSituacao.ItemIndex     := 4;

end;

procedure TFinLancamentoTipoResult.FormCreate(Sender: TObject);
var
  ListItem: TListItem;
begin
  inherited;

  // Preenche o check list box de empresas
  with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text := 'SELECT E.IDEmpresa, E.Empresa FROM #Sis_EmpresaP EP JOIN Sis_Empresa E ON (EP.IDEmpresaP = E.IDEmpresa) WHERE E.Desativado = 0 AND E.Hidden = 0';
      Open;
      First;
      lvEmpresa.Items.Clear;
      while not EOF do
        begin
          ListItem := lvEmpresa.Items.Add;
          ListItem.Caption := Fields[1].AsString;
          ListItem.Checked := True;
          ListItem.SubItems.Add(Fields[0].AsString);
          Next;
        end;
      Close;
    end;


  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sReceive       := '0 - Acc. Receivable';
           sPay           := '1 - Acc. Payable';
           end;
    LANG_PORTUGUESE :
           begin
           sReceive       := '0 - Contas a receber';
           sPay           := '1 - Contas a pagar';
           end;

    LANG_SPANISH :
           begin
           sReceive       := '0 - Cuentas a receber';
           sPay           := '1 - Cuentas a pagar';
           end;
  end;

end;

procedure TFinLancamentoTipoResult.Button1Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  // Marca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := True;
end;

procedure TFinLancamentoTipoResult.Button2Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  // Desmarca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := False;
end;

procedure TFinLancamentoTipoResult.btSelEmpresaClick(Sender: TObject);
begin
  inherited;

  if btSelEmpresa.Down then
    pnlEmpresa.Width := 150
  else
    pnlEmpresa.Width := 1;

end;

function TFinLancamentoTipoResult.ListParamRefresh: integer;
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

  RefreshList;

  brwGrid.FullExpand;
  pnlExecutaAviso.ParentColor := True;
  DesligaAviso;
  
end;

procedure TFinLancamentoTipoResult.CloseList;
begin
  with cdsBrowser do
    if Active then
      Close;
end;

procedure TFinLancamentoTipoResult.OpenList;
begin

  CloseSaldos;
  OpenSaldos;

  with cdsBrowser do
  begin
    Filtered := False;
    Filter   := '';
    if not Active then
      Open;
  end;

  FillValues;

  cdsBrowser.First;

end;

procedure TFinLancamentoTipoResult.RefreshList;
begin
  CloseList;
  OpenList;
end;

procedure TFinLancamentoTipoResult.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseList;
  CloseSaldos;
end;

procedure TFinLancamentoTipoResult.CloseSaldos;
begin
  quSaldo.Close;
  quSaldoAnterior.Close;
end;

procedure TFinLancamentoTipoResult.OpenSaldos;
var
  sSQLWhere, InicioStr, FimStr, StartStr,
  DataField, sCompany, sSituacao : String;
  Todos : Boolean;
  i : Integer;
begin

  InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
  FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);
  StartStr  := Chr(39) + FormatDateTime('mm/dd/yyyy', edtStartBalance.Date) + Chr(39);
  sCompany  := '';

  case cmbData.ItemIndex of
  0 : DataField := 'DataVencimento';
  1 : DataField := 'DataFimQuitacao';
  end;

  // Filtro por situacao
  case cmbSituacao.ItemIndex of
    0:// Aberto
      sSituacao := ' AND (F.Situacao IN (1, 5))';
    1:// Parte Quitado
      sSituacao := ' AND (F.Situacao = 5)';
    2:// Quitado
      sSituacao := ' AND (F.Situacao = 2)';
    3:// Cancelados
      sSituacao := ' AND (F.Situacao = 4)';
    4:// Todos
      sSituacao := '';
  end;

  Todos := True;
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
    begin
      Todos := Todos AND Items[i].Checked;
      if Items[i].Checked then
      begin
        if sCompany <> '' then
          sCompany := sCompany + ' OR '
        else
          sCompany := sCompany + ' ( ';

        sCompany := sCompany + 'F.IDEmpresa = ' + Items[i].SubItems[0];
      end;
    end;

  if sCompany <> '' then
    sCompany := ' AND ' + sCompany + ' ) ';

  if Todos then
    sCompany := '';


  sSQLWhere := '((IsNull(F.LancamentoType,0) = 0) OR (F.LancamentoType = 2)) AND F.Hidden = 0 ' +
               'AND ' + DataField + ' > ' + InicioStr + ' AND ' + DataField + ' <= ' +  FimStr + sCompany + sSituacao;

  quSaldo.CommandText := ChangeWhereClause(quSaldo.CommandText, sSQLWhere, True);
  quSaldo.Open;

  sSQLWhere := '((IsNull(F.LancamentoType,0) = 0) OR (F.LancamentoType = 2)) AND F.Hidden = 0 ' +
               'AND ' + DataField + ' < ' + InicioStr + sCompany + sSituacao + ' AND ' + DataField + ' >= ' + StartStr;

  quSaldoAnterior.CommandText := ChangeWhereClause(quSaldoAnterior.CommandText, sSQLWhere, True);
  quSaldoAnterior.Open;


end;

procedure TFinLancamentoTipoResult.FillValues;
begin

  AccRecPreview := 0;
  AccRecAmount  := 0;
  AccPayPreview := 0;
  AccPayAmount  := 0;

  try
    dsBrowse.DataSet := nil;

    //Percorrer o saldo anterior
    with quSaldoAnterior do
    begin
      First;
      while not EOF do
      begin
        if cdsBrowser.Locate('IDLancamentoTipo', quSaldoAnteriorIDLancamentoTipo.AsInteger, []) then
        begin
          UpdateTreeItem(quSaldoAnteriorIDLancamentoTipo.AsInteger,
                         quSaldoAnteriorAmount.AsCurrency,
                         cdsBrowserPreviousBalance);
        end;
        if cdsBrowserPagando.AsBoolean then
          AccPayPreview := AccPayPreview + quSaldoAnteriorAmount.AsCurrency
        else
          AccRecPreview := AccRecPreview + quSaldoAnteriorAmount.AsCurrency;
        Next;
      end;
    end;

    //Percorrer o saldo Atual
    with quSaldo do
    begin
      First;
      while not EOF do
      begin
        if cdsBrowser.Locate('IDLancamentoTipo', quSaldoIDLancamentoTipo.AsInteger, []) then
        begin
          UpdateTreeItem(quSaldoIDLancamentoTipo.AsInteger,
                         quSaldoAmount.AsCurrency,
                         cdsBrowserAmount);
        end;
        if cdsBrowserPagando.AsBoolean then
          AccPayAmount := AccPayAmount + quSaldoAmount.AsCurrency
        else
          AccRecAmount := AccRecAmount + quSaldoAmount.AsCurrency;
        Next;
      end;
    end;

    //Calcula o Balance
    with cdsBrowser do
    begin

      if cbxHideZeros.Checked then
      begin
        Filtered := False;
        Filter := '(PreviousBalance <> 0) OR (Amount <> 0)';
        Filtered := True;
      end;

      First;
      while not EOF do
      begin
        cdsBrowser.Edit;
        cdsBrowserActualBalace.AsCurrency := cdsBrowserPreviousBalance.AsCurrency +
                                             cdsBrowserAmount.AsCurrency;
        cdsBrowser.Post;
        Next;
      end;
    end;


  finally
    dsBrowse.DataSet := cdsBrowser;
  end;
end;

procedure TFinLancamentoTipoResult.UpdateTreeItem(
  IDLancamentoTipo: Integer; AAmount: Currency; AField: TBCDField);
var
  iPrev : Integer;
begin

  if cdsBrowserPagando.AsBoolean then
    AAmount := AAmount * -1;

  cdsBrowser.Edit;
  AField.AsCurrency := AField.AsCurrency + AAmount;
  cdsBrowser.Post;


  while not cdsBrowserIDLancamentoTipoParent.IsNull do
  begin
    iPrev := cdsBrowserIDLancamentoTipoParent.AsInteger;
    if cdsBrowser.Locate('IDLancamentoTipo', iPrev, []) then
    begin
      cdsBrowser.Edit;
      AField.AsCurrency := AField.AsCurrency + AAmount;
      cdsBrowser.Post;
    end;
  end;

end;

procedure TFinLancamentoTipoResult.brwGridCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
begin
  inherited;

{
  if AColumn.Name = 'brwGridAmount' then
    if ANode.Values[AColumn.Index] < 0 then
      begin
        AColor := $00CDCCFF;
        AFont.Color := clWindowText;
      end
    else
      begin
        AColor := $00FFE0CC;
        AFont.Color := clWindowText;
      end;
}

end;

procedure TFinLancamentoTipoResult.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quBrowsePagando.AsBoolean then
    quBrowseAccType.AsString := sPay
  else
    quBrowseAccType.AsString := sReceive;

end;

procedure TFinLancamentoTipoResult.brwGridSummaryGroups0SummaryItems1Summary(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Amount
  if DataSet.FieldByName('Pagando').AsBoolean then
    Value := AccPayAmount * -1
  else
    Value := AccRecAmount;
end;

procedure TFinLancamentoTipoResult.brwGridSummaryGroups0SummaryItems0Summary(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Previews Balanca
  if DataSet.FieldByName('Pagando').AsBoolean then
    Value := AccPayPreview * -1
  else
    Value := AccRecPreview;
end;

procedure TFinLancamentoTipoResult.brwGridSummaryGroups0SummaryItems2Summary(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Final Balance
  if DataSet.FieldByName('Pagando').AsBoolean then
    Value := (AccPayAmount + AccPayPreview) * -1
  else
    Value := (AccRecAmount + AccRecPreview);
end;

procedure TFinLancamentoTipoResult.brwGridAmountSummaryFooter(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Amount
  Value := (AccRecAmount - AccPayAmount);
end;

procedure TFinLancamentoTipoResult.brwGridPreviousBalanceSummaryFooter(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Previews
  Value := (AccRecPreview - AccPayPreview);
end;

procedure TFinLancamentoTipoResult.brwGridActualBalaceSummaryFooter(
  Sender: TObject; DataSet: TDataSet; var Value: Extended);
begin
  inherited;
  //Actual
  Value := (AccRecAmount + AccRecPreview) - (AccPayAmount + AccPayPreview);
end;

procedure TFinLancamentoTipoResult.quSaldoAnteriorCalcFields(
  DataSet: TDataSet);
begin
  inherited;

  quSaldoAnteriorAmount.AsCurrency := quSaldoAnteriorValorNominal.AsCurrency;

  if chkInterest.Checked then
    quSaldoAnteriorAmount.AsCurrency := quSaldoAnteriorAmount.AsCurrency +
                                        quSaldoAnteriorJuros.AsCurrency;

end;

procedure TFinLancamentoTipoResult.quSaldoCalcFields(DataSet: TDataSet);
begin
  inherited;


  quSaldoAmount.AsCurrency := quSaldoValorNominal.AsCurrency;

  if chkInterest.Checked then
    quSaldoAmount.AsCurrency := quSaldoAmount.AsCurrency +
                                quSaldoJuros.AsCurrency;

end;

Initialization
  RegisterClass(TFinLancamentoTipoResult);


end.
