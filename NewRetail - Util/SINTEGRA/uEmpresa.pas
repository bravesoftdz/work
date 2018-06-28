unit uEmpresa;

interface

uses
  SysUtils, Types, Classes, Variants, Windows, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls;

type
  TfrmEmpresa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnCancela: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    RazaoSocial: TEdit;
    CNPJ: TEdit;
    InscEstadual: TEdit;
    Endereco: TEdit;
    Numero: TEdit;
    Complemento: TEdit;
    Bairro: TEdit;
    Municipio: TEdit;
    CEP: TEdit;
    UF: TEdit;
    Fax: TEdit;
    Fone: TEdit;
    Responsavel: TEdit;
    btOk: TBitBtn;
    rbTributario: TRadioGroup;
    rbIPI: TRadioGroup;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Start:Boolean;
    { Public declarations }
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

uses uDados, uDM;

{$R *.dfm}

procedure TfrmEmpresa.btnOKClick(Sender: TObject);
begin
  Close;
end;

function TfrmEmpresa.Start: Boolean;
begin
  RazaoSocial.Text   := DM.fEmpresa.RazaoSocial;
  CNPJ.Text          := DM.fEmpresa.CNPJ;
  InscEstadual.Text  := DM.fEmpresa.InscEstadual;
  Endereco.Text      := DM.fEmpresa.Endereco;
  Numero.Text        := DM.fEmpresa.Numero;
  Complemento.Text   := DM.fEmpresa.Complemento;
  Bairro.Text        := DM.fEmpresa.Bairro;
  Municipio.Text     := DM.fEmpresa.Municipio;
  CEP.Text           := DM.fEmpresa.CEP;
  UF.Text            := DM.fEmpresa.UF;
  Fax.Text           := DM.fEmpresa.Fax;
  Fone.Text          := DM.fEmpresa.Fone;
  Responsavel.Text   := DM.fEmpresa.Responsavel;

  {if DM.fEmpresa.Tributario='True' then
   rbTributario.ItemIndex := 0
  else
   rbTributario.ItemIndex := 1;

  if DM.fEmpresa.IPI='True' then
   rbIPI.ItemIndex := 0
  else
   rbIPI.ItemIndex := 1;}

  ShowModal;

  Result := (ModalResult = mrOK);

   If Result then
      begin
      DM.fEmpresa.RazaoSocial   := RazaoSocial.Text;
      DM.fEmpresa.CNPJ          := CNPJ.Text;
      DM.fEmpresa.InscEstadual  := InscEstadual.Text;
      DM.fEmpresa.Endereco      := Endereco.Text;
      DM.fEmpresa.Numero        := Numero.Text;
      DM.fEmpresa.Complemento   := Complemento.Text;
      DM.fEmpresa.Bairro        := Bairro.Text;
      DM.fEmpresa.Municipio     := Municipio.Text;
      DM.fEmpresa.CEP           := CEP.Text;
      DM.fEmpresa.UF            := UF.Text;
      DM.fEmpresa.Fax           := Fax.Text;
      DM.fEmpresa.Fone          := Fone.Text;
      DM.fEmpresa.Responsavel   := Responsavel.Text;

      if rbTributario.ItemIndex=0 then
       DM.fEmpresa.Tributario    := 'True'
      else
       DM.fEmpresa.Tributario    := 'False';

      if rbIPI.ItemIndex=0 then
       DM.fEmpresa.IPI     := 'True'
      else
       DM.fEmpresa.IPI     := 'False';

      DM.WriteCompany;
      end;
end;

end.
