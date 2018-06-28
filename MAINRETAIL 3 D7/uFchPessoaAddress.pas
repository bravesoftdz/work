unit uFchPessoaAddress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls,
  SuperComboADO, uMsgBox;

type
  TFchPessoaAddress = class(TbrwFrmParent)
    edtName: TDBEdit;
    edtAddress: TDBEdit;
    edtCity: TDBEdit;
    edtZip: TDBEdit;
    lbName: TLabel;
    lbAddress: TLabel;
    lbCity: TLabel;
    lbZip: TLabel;
    lbState: TLabel;
    lbCountry: TLabel;
    lbTax: TLabel;
    scState: TDBSuperComboADO;
    scCountry: TDBSuperComboADO;
    scTax: TDBSuperComboADO;
    Label35: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbIsBillTo: TDBCheckBox;
    lblNaighborhood: TLabel;
    edtNeighborhood: TDBEdit;
    quFormIDPessoaAddress: TIntegerField;
    quFormIDPessoa: TIntegerField;
    quFormName: TStringField;
    quFormAddress: TStringField;
    quFormNeighborhood: TStringField;
    quFormCity: TStringField;
    quFormZIP: TStringField;
    quFormIDTaxCategory: TIntegerField;
    quFormIDPais: TIntegerField;
    quFormIDEstado: TStringField;
    quFormCompanyReg: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormIsBillTo: TBooleanField;
    lblCompanyReg: TLabel;
    edtCompanyReg: TDBEdit;
    quFormIDMunicipio: TIntegerField;
    lbMunicipio: TLabel;
    scMunicipio: TDBSuperComboADO;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    FIDPessoa: Integer;
  protected
    procedure OnBeforeStart; override;
    function BeforeChange: boolean; override;
  end;

implementation

uses uDM, uParamFunctions;

{$R *.dfm}

{ TFchPessoaAddress }

function TFchPessoaAddress.BeforeChange: boolean;
begin
  inherited BeforeChange;

  if cbIsBillTo.Checked then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text := 'SELECT ' +
                  '       PA.IDPessoaAddress, ' +
                  '       PA.IDPessoa, ' +
                  '       PA.IsBillto ' +
                  'FROM ' +
                  '       Mnt_PessoaAddress PA ' +
                  'WHERE ' +
                  '       PA.IDPessoa = ' + IntToStr(quFormIDPessoa.AsInteger) +
                  '       AND ' +
                  '       Pa.IsBillTo = 1';
      Open;

      Result := IsEmpty;

      if not IsEmpty then
        MsgBox('Ja tem endereço', vbCritical + vbOKOnly);
    end;
  end;
end;

procedure TFchPessoaAddress.OnBeforeStart;
begin
  inherited;
  FIDPessoa := StrToInt(ParseParam(sParam, 'IDPessoa'));
end;

procedure TFchPessoaAddress.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDPessoa.AsInteger := FIDPessoa;
  quFormIsBillTo.AsBoolean := False;
end;

end.
