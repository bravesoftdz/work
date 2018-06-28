unit uRDMMaintenance;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigTable;

type
  TRDMMaintenance = class(TRemoteDataModule, IRDMMaintenance)
    ADOConnection: TADOConnection;
    ctEstado: TmrConfigTable;
    qryEstado: TADOQuery;
    dspEstado: TDataSetProvider;
    qryEstadoIDEstado: TStringField;
    qryEstadoEstado: TStringField;
    qryEstadoHidden: TBooleanField;
    qryEstadoDesativado: TBooleanField;
    ctPais: TmrConfigTable;
    qryPais: TADOQuery;
    dspPais: TDataSetProvider;
    qryPaisIDPais: TIntegerField;
    qryPaisCodPais: TStringField;
    qryPaisPais: TStringField;
    qryPaisSystem: TBooleanField;
    qryPaisHidden: TBooleanField;
    qryPaisDesativado: TBooleanField;
    ctTipoPessoa: TmrConfigTable;
    qryTipoPessoa: TADOQuery;
    dspTipoPessoa: TDataSetProvider;
    qryTipoPessoaIDTipoPessoa: TIntegerField;
    qryTipoPessoaPath: TStringField;
    qryTipoPessoaTipoPessoa: TStringField;
    qryTipoPessoaPathName: TStringField;
    qryTipoPessoaLastCode: TIntegerField;
    qryTipoPessoaComissionOnProfit: TBooleanField;
    qryTipoPessoaDefaultDiaPag: TIntegerField;
    qryTipoPessoaSystem: TBooleanField;
    qryTipoPessoaHidden: TBooleanField;
    qryTipoPessoaDesativado: TBooleanField;
    ctPessoa: TmrConfigTable;
    qryPessoa: TADOQuery;
    dspPessoa: TDataSetProvider;
    qryPessoaIDEstado: TStringField;
    qryPessoaIDPais: TIntegerField;
    qryPessoaIDPessoa: TIntegerField;
    qryPessoaIDTipoPessoa: TIntegerField;
    qryPessoaIDStore: TIntegerField;
    qryPessoaIDUser: TIntegerField;
    qryPessoaCode: TIntegerField;
    qryPessoaUserCode: TStringField;
    qryPessoaPessoa: TStringField;
    qryPessoaPessoaLastName: TStringField;
    qryPessoaPessoaFirstName: TStringField;
    qryPessoaEndereco: TStringField;
    qryPessoaBairro: TStringField;
    qryPessoaCidade: TStringField;
    qryPessoaCEP: TStringField;
    qryPessoaSalesTaxExempt: TBooleanField;
    qryPessoaPhoneAreaCode: TStringField;
    qryPessoaTelefone: TStringField;
    qryPessoaCellAreaCode: TStringField;
    qryPessoaCellular: TStringField;
    qryPessoaFax: TStringField;
    qryPessoaEmail: TStringField;
    qryPessoaBeeper: TStringField;
    qryPessoaHomePage: TStringField;
    qryPessoaIdentidade: TStringField;
    qryPessoaOrgaoEmissor: TStringField;
    qryPessoaDataExpedicao: TDateTimeField;
    qryPessoaNascimento: TDateTimeField;
    qryPessoaCPF: TStringField;
    qryPessoaCustomerCard: TStringField;
    qryPessoaCartMotorista: TStringField;
    qryPessoaNomeJuridico: TStringField;
    qryPessoaInscEstadual: TStringField;
    qryPessoaInscMunicipal: TStringField;
    qryPessoaContato: TStringField;
    qryPessoaCartTrabalho: TStringField;
    qryPessoaJuridico: TBooleanField;
    qryPessoaSystem: TBooleanField;
    qryPessoaDesativado: TIntegerField;
    qryPessoaHidden: TIntegerField;
    qryPessoaTipoPessoa: TStringField;
    qryPessoaPath: TStringField;
    ctPropertDomain: TmrConfigTable;
    qryPropertDomain: TADOQuery;
    dspPropertDomain: TDataSetProvider;
    qryPropertDomainProperty: TStringField;
    qryPropertDomainPropertyValue: TStringField;
    ctSystemUser: TmrConfigTable;
    qrySystemUser: TADOQuery;
    dspSystemUser: TDataSetProvider;
    qrySystemUserIDUser: TIntegerField;
    qrySystemUserUserTypeID: TIntegerField;
    qrySystemUserCodSystemUser: TStringField;
    qrySystemUserComissionID: TIntegerField;
    qrySystemUserSystemUser: TStringField;
    qrySystemUserPW: TStringField;
    qrySystemUserDesativado: TBooleanField;
    qrySystemUserHidden: TBooleanField;
    qrySystemUserSystem: TBooleanField;
    ctSysModule: TmrConfigTable;
    qrySysModule: TADOQuery;
    dspSysModule: TDataSetProvider;
    qrySysModuleModuleInfo: TStringField;
    qrySysModuleVersionNo: TIntegerField;
    qrySysModuleBuildNo: TIntegerField;
    qrySysModuleSeats: TStringField;
    qrySysModuleVersionType: TStringField;
    qrySysModuleRestricForms: TMemoField;
    dspParam: TDataSetProvider;
    ctParam: TmrConfigTable;
    qryParam: TADOQuery;
    qryParamIDParam: TIntegerField;
    qryParamSrvParameter: TStringField;
    qryParamSrvValue: TStringField;
    qryParamSrvType: TStringField;
    qryParamIDMenu: TIntegerField;
    ctPayment: TmrConfigTable;
    qryPayment: TADOQuery;
    dspPayment: TDataSetProvider;
    qryPaymentIDMeioPag: TIntegerField;
    qryPaymentIDLancamentoTipo: TIntegerField;
    qryPaymentMeioPag: TStringField;
    qryPaymentTipo: TIntegerField;
    procedure ctPessoaBeforeUpdateRecords(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure ctPessoaNewRecord(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
  public
    { Public declarations }
  end;

var
  RDMMaintenance: TRDMMaintenance;
  RDMMaintenanceFactory: TComponentFactory;

implementation

uses Variants;

{$R *.DFM}

class procedure TRDMMaintenance.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TRDMMaintenance.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMMaintenance.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMMaintenance.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

procedure TRDMMaintenance.ctPessoaBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  sFirstName,
  sLastName : String;
begin

  if not DeltaDS.FieldByName('Juridico').AsBoolean then
  begin
    sFirstName := DeltaDS.FieldByName('PessoaFirstName').NewValue;
    sLastName  := DeltaDS.FieldByName('PessoaLastName').NewValue;

    if (sFirstName = '') and (DeltaDS.FieldByName('PessoaFirstName').OldValue <> Null) then
      sFirstName := DeltaDS.FieldByName('PessoaFirstName').OldValue;
    if (sLastName = '') and (DeltaDS.FieldByName('PessoaLastName').OldValue <> Null) then
      sLastName := DeltaDS.FieldByName('PessoaLastName').OldValue;

    if (sFirstName <> '') and (sLastName <> '') then
      DeltaDS.FieldByName('Pessoa').NewValue := sFirstName + ' ' + sLastName;
  end;
  
end;

procedure TRDMMaintenance.ctPessoaNewRecord(Sender: TObject;
  var OwnerData: OleVariant);
begin
  OwnerData := 'Juridico=0;';
end;

initialization
  RDMMaintenanceFactory := TComponentFactory.Create(ComServer, TRDMMaintenance,
    Class_RDMMaintenance, ciInternal, tmApartment);

end.
