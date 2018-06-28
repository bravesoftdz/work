unit uFinLancamentoTipoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  ComCtrls, dxBar, ImgList, ADODB, PowerADOQuery, SuperComboADO, siComp,
  siLangRT;

type
  TFinLancamentoTipoFch = class(TParentFch)
    quFormIDLancamentoTipo: TIntegerField;
    quFormIDContaCorrenteDefault: TIntegerField;
    quFormPath: TStringField;
    quFormPathName: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormPagando: TBooleanField;
    quFormPermitePessoaNula: TBooleanField;
    quFormSugerePessoa: TBooleanField;
    quFormPessoaFixa: TBooleanField;
    quFormIDPessoa: TIntegerField;
    quFormSugereContaCorrente: TBooleanField;
    quFormContaCorrenteFixa: TBooleanField;
    quFormIDPessoaTipo: TIntegerField;
    PPageControl: TPageControl;
    tsCadastro: TTabSheet;
    tsLancamento: TTabSheet;
    GroupBox1: TGroupBox;
    cbSugerePessoa: TDBCheckBox;
    cbSugereCC: TDBCheckBox;
    scCC: TDBSuperComboADO;
    scPessoa: TDBSuperComboADO;
    Panel1: TPanel;
    scPessoaTipo: TDBSuperComboADO;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    rgTipo: TDBRadioGroup;
    DBRadioGroup1: TDBRadioGroup;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    quFormCodigoContabil: TStringField;
    quFormSintetico: TBooleanField;
    quFormLancamentoTipo: TStringField;
    Label7: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lbGroup: TLabel;
    DBEdit1: TDBEdit;
    Panel2: TPanel;
    cbSugereCentroCusto: TDBCheckBox;
    scCentroCusto: TDBSuperComboADO;
    quFormSugereCentroCusto: TBooleanField;
    quFormIDCentroCusto: TIntegerField;
    procedure rgTipoChange(Sender: TObject);
    procedure cbSugerePessoaClick(Sender: TObject);
    procedure cbSugereCCClick(Sender: TObject);
    procedure scPessoaTipoSelectItem(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSugereCentroCustoClick(Sender: TObject);
  private
    sCreditor,
    sDebitor,
    sOutFill,
    sCom: String;
  end;

var
  FinLancamentoTipoFch: TFinLancamentoTipoFch;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TFinLancamentoTipoFch.rgTipoChange(Sender: TObject);
var
   X: String;
begin
  inherited;
  // Ajusta os captions dos check box
  if rgTipo.ItemIndex = 0 then
    X := sCreditor
  else
    X := sDebitor;

  cbSugerePessoa.Caption := sOutFill + X + sCom;
end;

procedure TFinLancamentoTipoFch.cbSugerePessoaClick(Sender: TObject);
begin
  inherited;
  if not cbSugerePessoa.Checked then
  begin
    scPessoa.Enabled := False;
    scPessoa.ParentColor := True;
    scPessoaTipo.Enabled := False;
    scPessoaTipo.ParentColor := True;
  end
  else
  begin
    scPessoa.Enabled := True;
    scPessoa.Color := clWindow;
    scPessoaTipo.Enabled := True;
    scPessoaTipo.Color := clWindow;
  end;
end;

procedure TFinLancamentoTipoFch.cbSugereCCClick(Sender: TObject);
begin
  inherited;
  if not cbSugereCC.Checked then
  begin
    scCC.Enabled := False;
    scCC.ParentColor := True;
  end
  else
  begin
    scCC.Enabled := True;
    scCC.Color := clWindow;
  end;
end;

procedure TFinLancamentoTipoFch.scPessoaTipoSelectItem(Sender: TObject);
begin
  inherited;
  // filtra o cmb de pessoa pelo tipo selecionado
  with scPessoa do
  begin
    FilterFields.Clear;
    FilterValues.Clear;
    FilterFields.Add('IDTipoPessoa');
    FilterValues.Add(scPessoaTipo.LookUpValue);
  end;
end;

procedure TFinLancamentoTipoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cbSugerePessoaClick(nil);
  cbSugereCCClick(nil);
  cbSugereCentroCustoClick(nil);
end;

procedure TFinLancamentoTipoFch.FormShow(Sender: TObject);
begin
  inherited;
  PPageControl.ActivePage := tsCadastro;
end;

procedure TFinLancamentoTipoFch.FormCreate(Sender: TObject);
begin
  inherited;
  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sCreditor := 'Creditor';
      sDebitor  := 'Debtor';
      sOutFill  := 'Auto fill ';
      sCom      := ' with :';
    end;

    LANG_PORTUGUESE :
    begin
      sCreditor := 'Credor';
      sDebitor  := 'Devedor';
      sOutFill  := 'Preencher ';
      sCom      := ' com :';
    end;

    LANG_SPANISH :
    begin
      sCreditor := 'Credor';
      sDebitor  := 'Devedor';
      sOutFill  := 'Preencher ';
      sCom      := ' com :';
    end;
  end;
end;

procedure TFinLancamentoTipoFch.cbSugereCentroCustoClick(Sender: TObject);
begin
  inherited;
  if not cbSugereCentroCusto.Checked then
  begin
    scCentroCusto.Enabled := False;
    scCentroCusto.ParentColor := True;
  end
  else
  begin
    scCentroCusto.Enabled := True;
    scCentroCusto.Color := clWindow;
  end;
end;

Initialization
  RegisterClass(TFinLancamentoTipoFch);

end.
