unit uFrmZipSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, DB, ADODB,
  Buttons, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

const
  FIELD_BAIRRO      = 'Bairro=';
  FIELD_LOCALIDADE  = 'Localidade=';
  FIELD_TITULO      = 'Titulo=';
  FIELD_LOGRADOURO  = 'Logradouro=';
  FIELD_COMPLEMENTO = 'Complemento=';
  FIELD_IDESTADO    = 'IDEstado=';
  FIELD_ZIPCODE     = 'CEP=';

type
  TFrmZipSearch = class(TDialogParent)
    quZipCode: TADODataSet;
    lbZip: TLabel;
    edtZip: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtBairro: TEdit;
    edtCity: TEdit;
    edtState: TEdit;
    quZipCodeTitulo: TStringField;
    quZipCodeCEP: TIntegerField;
    quZipCodeLocalidade: TStringField;
    quZipCodeIDBairro: TIntegerField;
    quZipCodeBairro: TStringField;
    quZipCodeLogradouro: TStringField;
    quZipCodeComplemento: TStringField;
    quZipCodeIDLocalidade: TIntegerField;
    quZipCodeIDEstado: TStringField;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    dsZipCode: TDataSource;
    quZipCodeEndereco: TStringField;
    grdBrowseDBCEP: TcxGridDBColumn;
    grdBrowseDBBairro: TcxGridDBColumn;
    grdBrowseDBIDEstado: TcxGridDBColumn;
    grdBrowseDBEndereco: TcxGridDBColumn;
    sbSearchZip: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure sbSearchZipClick(Sender: TObject);
    procedure edtZipKeyPress(Sender: TObject; var Key: Char);
    procedure quZipCodeCalcFields(DataSet: TDataSet);
    procedure quZipCodeAfterOpen(DataSet: TDataSet);
    procedure edtZipChange(Sender: TObject);
  private
    { Private declarations }
    fZipDB     : String;
    procedure OpenZip;
    procedure CloseZip;
    function GetZIP:String;
    function getCEPSQL: String;
  public
    { Public declarations }
    function Start:String;
  end;

implementation

{$R *.dfm}

uses uDM, uDMGlobal, uSystemConst, uMsgBox, uMsgConstant, uCharFunctions;

function TFrmZipSearch.Start:String;
begin
  ShowModal;
  if (ModalResult = mrOk) then
     Result := GetZIP;
  CloseZip;
end;

function TFrmZipSearch.getCEPSQL: String;
var
 sWhere : String;
begin

 sWhere := '';

 if Trim(edtBairro.Text) <> '' then
    sWhere := sWhere + ' AND B.Bairro LIKE ' + QuotedStr(edtBairro.Text + '%') + ' ';

 if Trim(edtCity.Text) <> '' then
    sWhere := sWhere + ' AND LC.Localidade LIKE ' + QuotedStr(edtCity.Text + '%') + ' ';

 if Trim(edtState.Text) <> '' then
    sWhere := sWhere + ' AND LC.IDEstado LIKE ' + QuotedStr(edtState.Text + '%') + ' ';

  Result :=
    'SELECT ' +
    'T.Titulo,' +
    'LG.CEP ,' +
    'LC.Localidade ,' +
    'B.IDBairro ,' +
    'B.Bairro ,' +
    'LG.Logradouro ,' +
    'LG.Complemento ,' +
    'LC.IDLocalidade ,' +
    'LC.IDEstado ' + //Cigla
    ' FROM '+fZipDB+'..Cep_Logradouro LG ' +
    ' JOIN '+fZipDB+'..Cep_Localidade LC ON ( LG.IDLocalidade = LC.IDLocalidade ) ' +
    ' JOIN '+fZipDB+'..Cep_Bairro B ON ( B.idBairro = LG.idBairro  AND LG.IDLocalidade = B.IDLocalidade ) ' +
    ' JOIN '+fZipDB+'..Cep_Titulo T ON ( T.idTitulo = LG.idTitulo )' +
    ' WHERE ' +
    ' LG.CEP LIKE ' + QuotedStr(edtZip.Text + '%') +
    sWhere +
    ' ORDER BY' +
    ' T.Titulo, ' +
    ' LG.Logradouro ,' +
    ' B.Bairro ';
end;

function TFrmZipSearch.GetZIP:String;
begin

   with quZipCode do
       if Active then
          begin
          Result :=
              FIELD_TITULO      + FieldByName('Titulo').AsString      + ';'+
              FIELD_LOCALIDADE  + FieldByName('Localidade').AsString  + ';'+
              FIELD_BAIRRO      + FieldByName('Bairro').AsString      + ';'+
              FIELD_LOGRADOURO  + FieldByName('Logradouro').AsString  + ';'+
              FIELD_COMPLEMENTO + FieldByName('Complemento').AsString + ';'+
              FIELD_IDESTADO    + FieldByName('IDEstado').AsString    + ';'+
              FIELD_ZIPCODE     + FieldByName('CEP').AsString         + ';';
          end;

end;


procedure TFrmZipSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmZipSearch.FormCreate(Sender: TObject);
begin
  inherited;

  fZipDB := DM.fSystem.SrvParam[PARAM_CONSULTA_ZIPCODE];

end;

procedure TFrmZipSearch.sbSearchZipClick(Sender: TObject);
begin
  inherited;
  CloseZip;
  OpenZip;
end;

procedure TFrmZipSearch.edtZipKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmZipSearch.quZipCodeCalcFields(DataSet: TDataSet);
begin
  inherited;
  quZipCodeEndereco.AsString := quZipCodeTitulo.AsString      + ' ' +
                                quZipCodeLogradouro.AsString  + ' ' +
                                quZipCodeComplemento.AsString;
end;

procedure TFrmZipSearch.CloseZip;
begin
   with quZipCode do
      if Active then
         Close;
end;

procedure TFrmZipSearch.OpenZip;
begin

  with quZipCode do
     if not Active then
        try
          DM.WaitForm.Start(False);
          CommandText := getCEPSQL;
          Open;
         finally
           DM.WaitForm.Hide;
         end;

end;

procedure TFrmZipSearch.quZipCodeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if quZipCode.RecordCount > 0 then
     begin
     sbSearchZip.Default := False;
     Aplicar.Default     := True;
     grdBrowse.SetFocus; 
     end;
end;

procedure TFrmZipSearch.edtZipChange(Sender: TObject);
begin
  inherited;
  sbSearchZip.Default := True;
  Aplicar.Default     := False;
end;

end.
