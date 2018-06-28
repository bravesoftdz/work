unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ComCtrls, Grids, DBGrids, ExtCtrls;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    quPessoaO: TADODataSet;
    Button1: TButton;
    StatusBar: TStatusBar;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    btnUpdate: TButton;
    Label3: TLabel;
    edtNome: TEdit;
    edtLastName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtCPF: TEdit;
    rdTipo: TRadioGroup;
    Button3: TButton;
    quPessoaD: TADODataSet;
    dsPessoaO: TDataSource;
    dsPessoaD: TDataSource;
    spExecute: TADOStoredProc;
    quPessoaOIDPessoa: TIntegerField;
    quPessoaONome: TStringField;
    quPessoaOSobrenome: TStringField;
    quPessoaONomeCompleto: TStringField;
    quPessoaOEndereco: TStringField;
    quPessoaOCidade: TStringField;
    quPessoaOCEP: TStringField;
    quPessoaOTelefone: TStringField;
    quPessoaOCPF: TStringField;
    quPessoaOCGC: TStringField;
    quPessoaDIDPessoa: TIntegerField;
    quPessoaDNome: TStringField;
    quPessoaDSobrenome: TStringField;
    quPessoaDNomeCompleto: TStringField;
    quPessoaDEndereco: TStringField;
    quPessoaDCidade: TStringField;
    quPessoaDCEP: TStringField;
    quPessoaDTelefone: TStringField;
    quPessoaDCPF: TStringField;
    quPessoaDCGC: TStringField;
    Label6: TLabel;
    cbxQuery: TComboBox;
    lbClienteSecundario: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbClientePrincipal: TLabel;
    edtPW: TLabeledEdit;
    edtUser: TLabeledEdit;
    edtDB: TLabeledEdit;
    edtServer: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure ADOConnection1AfterConnect(Sender: TObject);
    procedure ADOConnection1AfterDisconnect(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsPessoaODataChange(Sender: TObject; Field: TField);
    procedure dsPessoaDDataChange(Sender: TObject; Field: TField);
  private
    procedure RefreshDataset;
    procedure SetQuery1(SQL:String);
    procedure SetQuery2(SQL:String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Try
    ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password='+edtPW.Text+';Persist Security Info=True;User ID='+edtUser.Text+';Initial Catalog='+edtDB.Text+';Data Source='+edtServer.Text+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=DESENV001;Use Encryption for Data=False;Tag with column collation when possible=False';
    ADOConnection1.Open;
    StatusBar.Panels.Items[0].Text := 'Connected';
    btnUpdate.Visible := True;
  except
    StatusBar.Panels.Items[0].Text := 'Connection Erro!!';
    end;
end;

procedure TForm1.ADOConnection1AfterConnect(Sender: TObject);
begin
  Button1.Enabled := False;
end;

procedure TForm1.ADOConnection1AfterDisconnect(Sender: TObject);
begin
  Button1.Enabled := True;
end;

procedure TForm1.btnUpdateClick(Sender: TObject);
begin
  if ADOConnection1.Connected then
     begin

     if not quPessoaO.Active then
        Exit;

     if not quPessoaD.Active then
        Exit;

     if quPessoaOIDPessoa.AsInteger = quPessoaDIDPessoa.AsInteger then
        begin
        ShowMessage('Same customer was selected!');
        Exit;
        end;

     Try
       ADOConnection1.BeginTrans;

       with spExecute do
         begin
         Parameters.ParamByName('@IDPessoaEleita').Value := quPessoaOIDPessoa.AsInteger;
         Parameters.ParamByName('@IDPessoaDelete').Value := quPessoaDIDPessoa.AsInteger;
         ExecProc;
         end;

       ADOConnection1.CommitTrans;
     except
       ADOConnection1.RollbackTrans;
       end;

     RefreshDataset;
     end;
end;

procedure TForm1.RefreshDataset;
var
  sSQL : String;
  sWhere : String;
begin

  sWhere := 'Where TP.Path like ' + QuotedStr('.001%');

  if rdTipo.ItemIndex = 0 then
     sWhere := sWhere + ' AND P.Juridico = 0 '
  else
     sWhere := sWhere + ' AND P.Juridico = 1 ';


  if Trim(edtNome.Text) <> '' then
     if rdTipo.ItemIndex = 1 then
        sWhere := sWhere + ' AND P.Pessoa like ' + QuotedStr('%'+edtNome.Text+'% ')
     else
        begin
        sWhere := sWhere + ' AND P.PessoaFirstName like ' + QuotedStr('%'+edtNome.Text+'%');
        if Trim(edtLastName.Text) <> '' then
           sWhere := sWhere + ' AND P.PessoaLastName like ' + QuotedStr('%'+edtLastName.Text+'%');
        end;

  if Trim(edtCPF.Text) <> '' then
     sWhere := sWhere + ' AND P.CPF like ' + QuotedStr('%'+edtCPF.Text+'%');

  sSQL := 'Select P.IDPessoa, P.PessoaFirstName as Nome, P.PessoaLastName as Sobrenome, ' +
          'P.Pessoa as NomeCompleto, P.Endereco, P.Cidade, P.CEP, P.Telefone, P.CPF, P.CGC ' +
          'From Pessoa P JOIN TipoPessoa TP ON (P.IDTipoPessoa = TP.IDTipoPessoa )' + sWhere;

  case cbxQuery.ItemIndex of
    0 : SetQuery1(sSQL);
    1 : SetQuery2(sSQL);
    else
       begin
       SetQuery1(sSQL);
       SetQuery2(sSQL);
       end;
  end;


end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  RefreshDataset;
end;

procedure TForm1.SetQuery1(SQL:String);
begin
  with quPessoaO do
    begin
    if Active then
       Close;
    CommandText := SQL;
    Open;
    end;
end;

procedure TForm1.SetQuery2(SQL:String);
begin
  with quPessoaD do
    begin
    if Active then
       Close;
    CommandText := SQL;
    Open;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 quPessoaO.Close;
 quPessoaD.Close;
 ADOConnection1.Close; 
end;

procedure TForm1.dsPessoaODataChange(Sender: TObject; Field: TField);
begin
  lbClientePrincipal.Caption :=  quPessoaOIDPessoa.AsString + ' - ' +
                                 quPessoaONome.AsString + ' ' + quPessoaOSobrenome.AsString +
                                 ' ('+quPessoaONomeCompleto.AsString+')';
end;

procedure TForm1.dsPessoaDDataChange(Sender: TObject; Field: TField);
begin
  lbClienteSecundario.Caption := quPessoaDIDPessoa.AsString + ' - ' +
                                 quPessoaDNome.AsString + ' ' + quPessoaDSobrenome.AsString +
                                 ' ('+quPessoaDNomeCompleto.AsString+')';
end;


end.
