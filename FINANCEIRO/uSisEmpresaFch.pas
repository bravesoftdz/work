unit uSisEmpresaFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFchList, dxGrClms, dxDBGrid, Mask, StdCtrls, DBCtrls,
  Db, BrowseConfig, dxBar, FormConfig, DBTables,
  dxCntner, dxTL, ComCtrls, ExtCtrls, Buttons, ImgList, jpeg,
  dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery, RCADOQuery, siComp, siLangRT,
  SuperComboADO;

type
  TSisEmpresaFch = class(TParentFchList)
    tsCadastro: TTabSheet;
    tsTributos: TTabSheet;
    tsControleAcesso: TTabSheet;
    quFormIDEmpresa: TIntegerField;
    quFormCodigoEmpresa: TStringField;
    quFormEmpresa: TStringField;
    quFormRazaoSocial: TStringField;
    quFormCGC: TStringField;
    quFormInscricaoEstadual: TStringField;
    quFormInscricaoMunicipal: TStringField;
    quFormEndereco: TStringField;
    quFormCoplemento: TStringField;
    quFormBairro: TStringField;
    quFormCidade: TStringField;
    quFormCEP: TStringField;
    quFormPais: TStringField;
    quFormISS: TFloatField;
    quFormConfins: TFloatField;
    quFormPIS: TFloatField;
    quFormContribuicaoSocial: TFloatField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    quFormUltimaFatura: TIntegerField;
    quFormPercRetencaoINSS: TFloatField;
    Label15: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label14: TLabel;
    Label16: TLabel;
    quGrupo: TRCADOQuery;
    quGrupoIDEmpresa: TIntegerField;
    quGrupoIDGrupo: TIntegerField;
    quGrupoGrupo: TStringField;
    quGrupoPermissao: TBooleanField;
    dsGrupo: TDataSource;
    grdGrupo: TdxDBGrid;
    grdGrupoGrupo: TdxDBGridMaskColumn;
    grdGrupoPermissao: TdxDBGridCheckColumn;
    quFchBrwIDDepartamento: TIntegerField;
    quFchBrwIDEmpresa: TIntegerField;
    quFchBrwCodigoDepartamento: TStringField;
    quFchBrwDepartamento: TStringField;
    grbFchBrwCodigoDepartamento: TdxDBGridMaskColumn;
    grbFchBrwDepartamento: TdxDBGridMaskColumn;
    quFormUltimoNumeroFormulario: TIntegerField;
    quFormNFModeloFormulario: TStringField;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DBEdit15: TDBEdit;
    Label19: TLabel;
    Label18: TLabel;
    DBEdit14: TDBEdit;
    DBEdit16: TDBEdit;
    Label20: TLabel;
    DBEdit13: TDBEdit;
    Label17: TLabel;
    Label23: TLabel;
    DBEdit18: TDBEdit;
    Label27: TLabel;
    DBComboBox1: TDBComboBox;
    Label28: TLabel;
    DBComboBox2: TDBComboBox;
    DBEdit19: TDBEdit;
    Label25: TLabel;
    Label22: TLabel;
    DBEdit17: TDBEdit;
    Label21: TLabel;
    quFormPorta: TStringField;
    Label26: TLabel;
    DBComboBox3: TDBComboBox;
    quFormNFSModeloFormulario: TStringField;
    Label29: TLabel;
    DBComboBox4: TDBComboBox;
    quFormNFSPorta: TStringField;
    lbCNPJ: TLabel;
    DBEdit1: TDBEdit;
    lbIE: TLabel;
    DBEdit4: TDBEdit;
    lbIM: TLabel;
    DBEdit5: TDBEdit;
    lbAddress: TLabel;
    DBEdit6: TDBEdit;
    lbCompl: TLabel;
    DBEdit7: TDBEdit;
    lbLegalName: TLabel;
    DBEdit8: TDBEdit;
    quFormNumero: TIntegerField;
    quFormIDEstado: TStringField;
    quFormTelefone: TStringField;
    quFormFax: TStringField;
    quFormContato: TStringField;
    lbTel: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    lbContact: TLabel;
    DBEdit11: TDBEdit;
    lbState: TLabel;
    Label13: TLabel;
    DBEdit20: TDBEdit;
    lbCEP: TLabel;
    DBEdit21: TDBEdit;
    lbCountry: TLabel;
    DBEdit22: TDBEdit;
    lbNeig: TLabel;
    DBEdit23: TDBEdit;
    lbCity: TLabel;
    DBEdit24: TDBEdit;
    tsLogo: TTabSheet;
    quFormLogoEmpresa: TBlobField;
    btOpenLogo: TBitBtn;
    OpenDialog: TOpenDialog;
    imgLogo: TImage;
    quFormIDMunicipio: TIntegerField;
    quFormNomeFantasia: TStringField;
    lbDBA: TLabel;
    DBEdit25: TDBEdit;
    scEstado: TDBSuperComboADO;
    lbMunicipio: TLabel;
    scMunicipio: TDBSuperComboADO;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure quGrupoBeforeEdit(DataSet: TDataSet);
    procedure btOpenLogoClick(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormAfterScroll(DataSet: TDataSet);
  private
    procedure SaveLogoImage;
    procedure LoadLogoImage;    
  end;

implementation

uses uSisDepartamentoFch, uDM;

{$R *.DFM}

procedure TSisEmpresaFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadLogoImage;
end;

procedure TSisEmpresaFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  with quGrupo do
  begin
    if State in dsEditModes then
      Post;
    Close;
  end;
end;

procedure TSisEmpresaFch.FormCreate(Sender: TObject);
begin
  inherited;
  FchBrwForm := TSisDepartamentoFch.Create(self);
end;

procedure TSisEmpresaFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoEmpresa.AsString := '#Auto#';
end;

procedure TSisEmpresaFch.FormShow(Sender: TObject);
begin
  inherited;
  PPageControl.ActivePage := tsCadastro;
end;

procedure TSisEmpresaFch.quGrupoBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  with quForm do
    if not (State in dsEditModes) then
      Edit;
end;

procedure TSisEmpresaFch.btOpenLogoClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
  begin
    TocaFicha;
    imgLogo.Picture.LoadFromFile(OpenDialog.FileName);
  end;
end;

procedure TSisEmpresaFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  SaveLogoImage;
end;

procedure TSisEmpresaFch.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  inherited;
  with quGrupo do
    begin
      Parameters.ParamByName('IDEmpresa').Value := quFormIDEmpresa.AsInteger;
      Open;
    end;

  msLogo := TMemoryStream.Create;
  try
    if not quFormLogoEmpresa.IsNull then
    begin
      quFormLogoEmpresa.SaveToStream(msLogo);
      msLogo.Seek(0, soFromBeginning);
      img := TJPEGImage.Create;
      img.LoadFromStream(msLogo);
      imgLogo.Picture.Bitmap.Assign(img);
    end
    else
      imgLogo.Picture.Bitmap.Assign(nil);
  finally
    msLogo.Free;
    img.Free;
  end;
end;

procedure TSisEmpresaFch.SaveLogoImage;
var
  msLogo: TMemoryStream;
begin
  inherited;
  msLogo := TMemoryStream.Create;
  try
    TJPEGImage(imgLogo.Picture.Graphic).SaveToStream(msLogo);
    TBlobField(quFormLogoEmpresa).LoadFromStream(msLogo);
  finally
    msLogo.Free;
  end;
end;

procedure TSisEmpresaFch.quFormAfterScroll(DataSet: TDataSet);
begin
  inherited;
  LoadLogoImage;
end;

Initialization
  RegisterClass(TSisEmpresaFch);

end.
