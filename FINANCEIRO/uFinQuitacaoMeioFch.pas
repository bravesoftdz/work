unit uFinQuitacaoMeioFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, dxBar,
  dxCalc, uParentFchTab, dxGrClms, dxDBGrid, dxCntner, dxTL, ComCtrls,
  ImgList, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery, SuperComboADO, siComp,
  siLangRT;

type
  TFinQuitacaoMeioFch = class(TParentFchTab)
    tsCadastro: TTabSheet;
    Label7: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label12: TLabel;
    tsPostDate: TTabSheet;
    tsContaCorrente: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    grbFchBrw: TdxDBGrid;
    grdStore: TdxDBGrid;
    dsStore: TDataSource;
    grdStoreStore: TdxDBGridMaskColumn;
    dsContaCorrente: TDataSource;
    quMeioPag: TADOQuery;
    dsMeioPag: TDataSource;
    quMeioPagIDMeioPag: TIntegerField;
    quMeioPagTotalSale: TFloatField;
    quMeioPagDifDay: TIntegerField;
    quFormIDMeioPag: TIntegerField;
    quFormMeioPag: TStringField;
    quFormTemDocumento: TBooleanField;
    quFormPrazoRecebimento: TIntegerField;
    quFormTaxaAdmin: TFloatField;
    quFormIDContaCorrente: TIntegerField;
    quFormSystem: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormTaxMode: TIntegerField;
    quFormTipo: TIntegerField;
    quFormIdentificadorDocumento: TStringField;
    quFormCodigoMeioPag: TStringField;
    grbFchBrwTotalSale: TdxDBGridMaskColumn;
    grbFchBrwDifDay: TdxDBGridMaskColumn;
    btNovoPostDate: TSpeedButton;
    btRemovePostDate: TSpeedButton;
    tblContaCorrente: TADOTable;
    quContaCorrente: TADOQuery;
    quContaCorrenteIDContaCorrente: TIntegerField;
    quContaCorrenteNumero: TStringField;
    quStore: TADOQuery;
    quStoreIDStore: TIntegerField;
    quStoreName: TStringField;
    scContaCorrente: TDBSuperComboADO;
    grdStoreIDContaCorrente: TdxDBGridColumn;
    quStoreIDContaCorrente: TIntegerField;
    Label10: TLabel;
    cbxParentType: TDBComboBox;
    quFormParentType: TStringField;
    quFormIDMeioPagBatch: TIntegerField;
    pnlType: TPanel;
    pnlSale: TPanel;
    Label11: TLabel;
    rgTipo: TDBRadioGroup;
    DBSuperComboADO1: TDBSuperComboADO;
    pnlIdentificador: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    pnlCartao: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DiasRetencao: TDBEdit;
    TaxaDesconto: TDBEdit;
    quFormAutoDiscountFee: TBooleanField;
    cbxPayFee: TDBCheckBox;
    Label13: TLabel;
    quFormIDLancamentoTipo: TIntegerField;
    quFormIDPessoa: TIntegerField;
    scLancTipo: TDBSuperComboADO;
    Label14: TLabel;
    scVendor: TDBSuperComboADO;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure rgTipoChange(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btRemovePostDateClick(Sender: TObject);
    procedure btNovoPostDateClick(Sender: TObject);
    procedure quMeioPagBeforeEdit(DataSet: TDataSet);
    procedure quStoreBeforeEdit(DataSet: TDataSet);
    procedure quMeioPagNewRecord(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure cbxPayFeeClick(Sender: TObject);
    procedure cbxParentTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure Refreshtab;

    procedure StorePost;
    procedure MeioPagPost;

    procedure RefreshParamType;
    procedure RefreshAutoDiscFee;
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.DFM}

procedure TFinQuitacaoMeioFch.RefreshParamType;
begin

 //Sale
 if cbxParentType.ItemIndex = 0 then
    begin
    tsContaCorrente.TabVisible := False;
    tsPostDate.TabVisible      := True;
    pnlSale.Visible            := True;
    pnlCartao.Visible          := False;
    end
 else  //Batch
    begin
    tsContaCorrente.TabVisible := True;
    tsPostDate.TabVisible      := False;
    pnlSale.Visible            := False;
    pnlCartao.Visible          := True;
    end;

end;


procedure TFinQuitacaoMeioFch.RefreshAutoDiscFee;
var
  i : Integer;
  bEnabled : Boolean;
begin

 bEnabled := cbxPayFee.Checked; 


 with pnlCartao do
   for i := 0 to ControlCount-1 do
     if (Controls[i].Name <> 'cbxPayFee') then
        Controls[i].Enabled := bEnabled;

  quFormPrazoRecebimento.Required := bEnabled;
  quFormTaxaAdmin.Required        := bEnabled;
  quFormIDLancamentoTipo.Required := bEnabled;
  quFormIDPessoa.Required         := bEnabled;

end;

procedure TFinQuitacaoMeioFch.MeioPagPost;
begin
  with quMeioPag do
     if Active then
        if (State in dsEditModes) then
           if (quMeioPagDifDay.AsString<>'') then
              Post
           else
              Cancel;

end;

procedure TFinQuitacaoMeioFch.StorePost;
begin
  with quStore do
     if Active then
        if State in dsEditModes then
           Post;
end;

procedure TFinQuitacaoMeioFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  case rgTipo.ItemIndex of
    0: // Especie
      begin
        quFormIdentificadorDocumento.Clear;
      end;
    1: // Cartao
      begin
        if quFormIdentificadorDocumento.AsString = '' then
           quFormIdentificadorDocumento.AsString := 'Auto #';
      end;
    2: // Outros
      begin
        with quFormIdentificadorDocumento do
          if AsString = '' then
            AsString := '# ' + quFormMeioPag.AsString;
      end;
  end;
end;



procedure TFinQuitacaoMeioFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoMeioPag.AsString := '#Auto#';
  quFormParentType.AsString := 'Sale';
  quFormAutoDiscountFee.AsBoolean := False;

  quFormTipo.AsInteger := 1;
  rgTipoChange(nil);


  RefreshAutoDiscFee;

end;

procedure TFinQuitacaoMeioFch.rgTipoChange(Sender: TObject);
begin
  inherited;
  case rgTipo.ItemIndex of
    0: // Especie
      begin
        pnlIdentificador.Visible  := False;
      end;
    1: // Cartao
      begin
        pnlIdentificador.Visible  := True;
      end;
    2: // Outros
      begin
        pnlIdentificador.Visible  := True;
      end;
    3 : //Check
        begin
        pnlIdentificador.Visible  := True;
        end;
  end;
end;

procedure TFinQuitacaoMeioFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  RefreshTab;
end;

procedure TFinQuitacaoMeioFch.RefreshTab;
begin
  if PPageControl.ActivePage = tsCadastro then
    begin
      // Nada
    end
  else if PPageControl.ActivePage = tsPostDate then
    begin
      with quMeioPag do
        if not Active then
          begin
            Parameters.ParamByName('IDMeioPag').Value := quFormIDMeioPag.AsInteger;
            Open;
          end;
    end
  else if PPageControl.ActivePage = tsContaCorrente then
    begin
      with tblContaCorrente do
        if not Active then
          Open;
      with quStore do
        if not Active then
          begin
            Parameters.ParamByName('IDMeioPag').Value := quFormIDMeioPag.AsInteger;
            Open;
          end;
    end

end;

procedure TFinQuitacaoMeioFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  MeioPagPost;
  quMeioPag.Close;

  StorePost;
  quStore.Close;

  tblContaCorrente.Close;
end;

procedure TFinQuitacaoMeioFch.btRemovePostDateClick(Sender: TObject);
begin
  inherited;
  quMeioPag.Delete;
  TocaFicha;
end;

procedure TFinQuitacaoMeioFch.btNovoPostDateClick(Sender: TObject);
begin
  inherited;
  quMeioPag.Append;
  TocaFicha;
end;

procedure TFinQuitacaoMeioFch.quMeioPagBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  TocaFicha;
end;

procedure TFinQuitacaoMeioFch.quStoreBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  TocaFicha;
end;

procedure TFinQuitacaoMeioFch.quMeioPagNewRecord(DataSet: TDataSet);
begin
  inherited;
  quMeioPagIDMeioPag.AsInteger := quFormIDMeioPag.AsInteger;
end;

procedure TFinQuitacaoMeioFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshParamType;
  RefreshTab;
  RefreshAutoDiscFee;
end;

procedure TFinQuitacaoMeioFch.cbxPayFeeClick(Sender: TObject);
begin
  inherited;
  RefreshAutoDiscFee;
end;

procedure TFinQuitacaoMeioFch.cbxParentTypeChange(Sender: TObject);
begin
  inherited;
  RefreshParamType;
end;

Initialization
  RegisterClass(TFinQuitacaoMeioFch);


end.
