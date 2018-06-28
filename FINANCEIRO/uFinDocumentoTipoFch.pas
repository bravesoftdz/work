unit uFinDocumentoTipoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, StdCtrls, Mask, DBCtrls, Db, FormConfig, DBTables,
  Buttons, ExtCtrls, dxBar, uParentFchList,
  dxDBGrid, BrowseConfig, dxCntner, dxTL, ComCtrls, ImgList,
  dxDBCtrl, ADODB, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TFinDocumentoTipoFch = class(TParentFchList)
    quFormIDDocumentoTipo: TIntegerField;
    quFormCodigoDocumentoTipo: TStringField;
    quFormDocumentoTipo: TStringField;
    quFormIdentificadorDocumento: TStringField;
    tsCadastro: TTabSheet;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label12: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    quFchBrwIDDesdobramentoTipo: TIntegerField;
    quFchBrwIDDocumentoTipo: TIntegerField;
    quFchBrwDesdobramentoTipo: TStringField;
    quFchBrwCodigoDesdobramentoTipo: TStringField;
    quFormPossuiDesdobramento: TBooleanField;
    quFormIDDesdobramentoTipoDefault: TIntegerField;
    grbFchBrwDesdobramentoTipo: TdxDBGridMaskColumn;
    grbFchBrwCodigoDesdobramentoTipo: TdxDBGridMaskColumn;
    quFormDataEmissaoObrigatoria: TBooleanField;
    quFormNumDocumentoObrigatorio: TBooleanField;
    quFormDesdobramentoObrigatorio: TBooleanField;
    DBCheckBox2: TDBCheckBox;
    GroupBox1: TGroupBox;
    cbPossuiDesdobramento: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    scDesdobramentoTipo: TDBSuperComboADO;
    Label8: TLabel;
    DBCheckBox3: TDBCheckBox;
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure cbPossuiDesdobramentoClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFinDesdobramentoTipoFch, uDM;

procedure TFinDocumentoTipoFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  with quFormIdentificadorDocumento do
    if AsString = '' then
      AsString := '# ' + quFormDocumentoTipo.AsString;

  if not quFormPossuiDesdobramento.AsBoolean then
    begin
      quFormDesdobramentoObrigatorio.AsBoolean := False;
      quFormIDDesdobramentoTipoDefault.Clear;
    end;

end;


procedure TFinDocumentoTipoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoDocumentoTipo.AsString := '#Auto#';
  quFormPossuiDesdobramento.AsBoolean := False;

end;

procedure TFinDocumentoTipoFch.FormCreate(Sender: TObject);
begin
  inherited;
  FchBrwForm := TFinDesdobramentoTipoFch.Create(Self);

end;

procedure TFinDocumentoTipoFch.cbPossuiDesdobramentoClick(Sender: TObject);
begin
  inherited;
  tsBrowse.TabVisible := cbPossuiDesdobramento.Checked;

end;

procedure TFinDocumentoTipoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cbPossuiDesdobramentoClick(nil);

  // Filtro o Tipo de Desdobramento
  with scDesdobramentoTipo do
    begin
      FilterFields.Clear;
      FilterValues.Clear;
      FilterFields.Add('IDDocumentoTipo');
      FilterValues.Add(quFormIDDocumentoTipo.AsString);
    end;

end;

Initialization
  RegisterClass(TFinDocumentoTipoFch);


end.
