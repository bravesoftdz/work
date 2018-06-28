unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs, IniFiles, uDados, Forms, ufrmServerInfo;

const
  INI_FILE = 'Info.ini';

type
  TMRDatabase = class
    private
     fDatabaseName : String;
     fServer       : String;
     fUser         : String;
     fPW           : String;
    public
     property DatabaseName : String read fDatabaseName write fDatabaseName;
     property Server       : String read fServer       write fServer;
     property User         : String read fUser         write fUser;
     property PW           : String read fPW           write fPW;
  end;

  TCaixa = class
    private
      fNumSequencia: Integer;
    public
      property NumSequencia : Integer read fNumSequencia write fNumSequencia;
  end;

  TEmpresa = class
    private
     fRazaoSocial  : String;
     fCNPJ         : String;
     fInscEstadual : String;
     fEndereco     : String;
     fNumero       : String;
     fComplemento  : String;
     fBairro       : String;
     fMunicipio    : String;
     fCEP          : String;
     fUF           : String;
     fFax          : String;
     fFone         : String;
     fResponsavel  : String;
     fTributario   : String;
     fIPI          : String;
    public
     property RazaoSocial  : String read fRazaoSocial    write fRazaoSocial;
     property CNPJ         : String read fCNPJ           write fCNPJ;
     property InscEstadual : String read fInscEstadual   write fInscEstadual;
     property Endereco     : String read fEndereco       write fEndereco;
     property Numero       : String read fNumero         write fNumero ;
     property Complemento  : String read fComplemento    write fComplemento;
     property Bairro       : String read fBairro         write fBairro ;
     property Municipio    : String read fMunicipio      write fMunicipio;
     property CEP          : String read fCEP            write fCEP ;
     property UF           : String read fUF             write fUF ;
     property Fax          : String read fFax            write fFax ;
     property Fone         : String read fFone           write fFone ;
     property Responsavel  : String read fResponsavel    write fResponsavel ;
     property Tributario   : String read fTributario     write fTributario;
     property IPI          : String read fIPI            write fIPI  ;
  end;

  TDM = class(TDataModule)
    MRDBConnection: TADOConnection;
    quProduto: TADODataSet;
    quProdutoInvoiceDate: TDateTimeField;
    quProdutoQty: TIntegerField;
    quProdutoMovDate: TDateTimeField;
    quProdutoModelID: TIntegerField;
    quProdutoTaxValue: TBCDField;
    quProdutoExtSubTotal: TBCDField;
    quProdutoCupomFiscal: TStringField;
    quProdutoSituacaoTributaria: TIntegerField;
    quProdutoNumeroSeriePrinter: TStringField;
    quProdutoTax: TBCDField;
    quProdutoModel: TStringField;
    quProdutoDescription: TStringField;
    quImpSerial: TADODataSet;
    quImpSerialNumeroSeriePrinter: TStringField;
    quVendaBruta: TADODataSet;
    quHasSale: TADODataSet;
    quProdutoSalePrice: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
   fLocalPath    : String;
   fMRDatabase   : TMRDatabase;
   fEmpresa      : TEmpresa;
   fCaixa        : TCaixa;
   fInfo         : TInifile;
   Dados         : TDados;
   fFrmServrInfo : TFrmServerInfo;
   property LocalPath    : String  read fLocalPath;
   function MRConnectionOpen: Boolean;
   function MRConnectionClose:Boolean;
   procedure BuildConnection;
   procedure ReadCompany;
   procedure WriteCompany;
   function HasSale(fIni, fEnd : TDateTime):Boolean;
  end;

var
  DM: TDM;

implementation

uses uParamFunctions;

{$R *.dfm}

{ TDM }

function TDM.MRConnectionClose: Boolean;
begin
 with MRDBConnection do
     if Connected then
        try
          Close;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             //ShowMessage(E.Message);
             end;
          end;
end;

function TDM.MRConnectionOpen: Boolean;
begin
 with MRDBConnection do
     if not Connected then
        try
          ConnectionString := SetConnectionStr(fMRDatabase.User,
                                               fMRDatabase.PW,
                                               fMRDatabase.DatabaseName,
                                               fMRDatabase.Server);
          Open;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             //ShowMessage(E.Message);
             end;
          end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
 fMRDatabase   := TMRDatabase.Create;
 fEmpresa      := TEmpresa.Create;
 fCaixa        := TCaixa.Create;
 fLocalPath    := ExtractFilePath(Application.ExeName);
 fInfo         := TIniFile.Create(fLocalPath + INI_FILE);

 ShortDateFormat  := 'dd/mm/yyyy';

 fFrmServrInfo  := TFrmServerInfo.Create(self);

 ReadCompany;
 BuildConnection;
 MRConnectionOpen;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
 MRConnectionClose;
 FreeAndNil(fMRDatabase);
 FreeAndNil(fFrmServrInfo);
 FreeAndNil(fEmpresa);
 FreeAndNil(fCaixa);
end;

procedure TDM.BuildConnection;
var
  sUser, sPW, sDB, sServer, sResult : string;
  cStartType : Char;
  bAbort : Boolean;
begin
  cStartType := '4';
  sResult := fFrmServrInfo.Start(cStartType, False, '', bAbort);
  fMRDatabase.Server        := ParseParam(sResult, '#SRV#');
  fMRDatabase.User          := ParseParam(sResult, '#USER#');
  fMRDatabase.PW            := ParseParam(sResult, '#PW#');
  fMRDatabase.DatabaseName  := ParseParam(sResult, '#DB#');
end;


procedure TDM.ReadCompany;
begin
 fEmpresa.RazaoSocial   := fInfo.ReadString('Empresa', 'RazaoSocial', '');
 fEmpresa.CNPJ          := fInfo.ReadString('Empresa', 'CNPJ', '');
 fEmpresa.InscEstadual  := fInfo.ReadString('Empresa', 'InscEstadual', '');
 fEmpresa.Endereco      := fInfo.ReadString('Empresa', 'Endereco', '');
 fEmpresa.Numero        := fInfo.ReadString('Empresa', 'Numero', '');
 fEmpresa.Complemento   := fInfo.ReadString('Empresa', 'Complemento', '');
 fEmpresa.Bairro        := fInfo.ReadString('Empresa', 'Bairro', '');
 fEmpresa.Municipio     := fInfo.ReadString('Empresa', 'Municipio', '');
 fEmpresa.CEP           := fInfo.ReadString('Empresa', 'CEP', '');
 fEmpresa.UF            := fInfo.ReadString('Empresa', 'UF', '');
 fEmpresa.Fax           := fInfo.ReadString('Empresa', 'Fax', '');
 fEmpresa.Fone          := fInfo.ReadString('Empresa', 'Fone', '');
 fEmpresa.Responsavel   := fInfo.ReadString('Empresa', 'Responsavel', '');
 fEmpresa.Tributario    := fInfo.ReadString('Empresa', 'Tributario', '');
 fEmpresa.IPI           := fInfo.ReadString('Empresa', 'IPI', '');
end;

procedure TDM.WriteCompany;
begin
 fInfo.WriteString('Empresa', 'RazaoSocial', fEmpresa.RazaoSocial);
 fInfo.WriteString('Empresa', 'CNPJ', fEmpresa.CNPJ);
 fInfo.WriteString('Empresa', 'InscEstadual', fEmpresa.InscEstadual);
 fInfo.WriteString('Empresa', 'Endereco', fEmpresa.Endereco);
 fInfo.WriteString('Empresa', 'Numero', fEmpresa.Numero);
 fInfo.WriteString('Empresa', 'Complemento', fEmpresa.Complemento);
 fInfo.WriteString('Empresa', 'Bairro', fEmpresa.Bairro);
 fInfo.WriteString('Empresa', 'Municipio', fEmpresa.Municipio);
 fInfo.WriteString('Empresa', 'CEP', fEmpresa.CEP);
 fInfo.WriteString('Empresa', 'UF', fEmpresa.UF);
 fInfo.WriteString('Empresa', 'Fax', fEmpresa.Fax );
 fInfo.WriteString('Empresa', 'Fone', fEmpresa.Fone);
 fInfo.WriteString('Empresa', 'Responsavel', fEmpresa.Responsavel);
 fInfo.WriteString('Empresa', 'Tributario', fEmpresa.Tributario);
 fInfo.WriteString('Empresa', 'IPI', fEmpresa.IPI);
end;

function TDM.HasSale(fIni, fEnd: TDateTime): Boolean;
begin
  with quHasSale do
    try
      Parameters.ParamByName('Data_Inicial').Value := fIni;
      Parameters.ParamByName('Data_Final').Value := fEnd;
      Open;
      Result := (RecordCount>0);
    finally
      Close;
      end;
end;

end.
