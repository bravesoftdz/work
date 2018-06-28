unit uFrmNewCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, StdCtrls, uPreSale, uMRPDV,
  ExtCtrls, Mask, DateBox, DBCtrls, Buttons;

type
  TFrmNewCustomer = class(TFrmParentAll)
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtEndereco: TEdit;
    edtCidade: TEdit;
    edtBairro: TEdit;
    edtZip: TEdit;
    edtTelefone: TEdit;
    Label1: TLabel;
    lbLastName: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    rgType: TRadioGroup;
    Label9: TLabel;
    edtEstado: TEdit;
    edtTelDDD: TEdit;
    Label10: TLabel;
    edtCellPhone: TEdit;
    edtCelDDD: TEdit;
    Label11: TLabel;
    edtWebsite: TEdit;
    Label12: TLabel;
    edtEmail: TEdit;
    pnlFisico: TPanel;
    pnlJuridico: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label7: TLabel;
    edtCPF: TEdit;
    Label21: TLabel;
    edtIdentidate: TEdit;
    edtOrgaoEmissor: TEdit;
    dtExpDate: TDateBox;
    Label22: TLabel;
    dtBirthDay: TDateBox;
    Label23: TLabel;
    edtCustomerCard: TEdit;
    Label24: TLabel;
    etCartMotorista: TEdit;
    edtNomeJuridico: TEdit;
    edtInscEstatual: TEdit;
    edtInscMunicipal: TEdit;
    EditContact: TEdit;
    Image1: TImage;
    Bevel1: TBevel;
    Image2: TImage;
    Bevel2: TBevel;
    Image3: TImage;
    Bevel3: TBevel;
    Image4: TImage;
    Bevel4: TBevel;
    Image5: TImage;
    Bevel5: TBevel;
    Label13: TLabel;
    memOBS: TMemo;
    Image6: TImage;
    Bevel6: TBevel;
    lbFill1: TLabel;
    lbFill2: TLabel;
    spHelp: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgTypeExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
    FCustomerInfo: TCustomerInfo;
    FPersistenceType: Integer;
    procedure FillCustomerInfo;
    function ValidateFields:Boolean;
  public
    { Public declarations }
    function Start(PersistenceType: Integer): TCustomerInfo;
  end;

implementation

uses uMsgBox, uMsgConstant, uDM, uDMParent, uSystemConst, uDMPDV, uValidaDocs,
  uStringFunctions;

{$R *.dfm}

{ TFrmNewCustomer }

function TFrmNewCustomer.Start(PersistenceType: Integer): TCustomerInfo;
begin
  FCustomerInfo := nil;
  FPersistenceType := PersistenceType;
  ShowModal;
  Result := fCustomerInfo;
end;

procedure TFrmNewCustomer.FillCustomerInfo;
begin
  FCustomerInfo := TCustomerInfo.Create;
  try
    with FCustomerInfo do
    begin
      FirstName    := edtFirstName.Text;
      LastName     := edtLastName.Text;
      Endereco     := edtEndereco.Text;
      Cidade       := edtCidade.Text;
      Bairro       := edtBairro.Text;
      Zip          := edtZip.Text;
      Telefone     := edtTelefone.Text;
      IsNew        := True;
      Juridico     := (rgType.ItemIndex=1);
      Estado       := edtEstado.Text;
      TelDDD       := edtTelDDD.Text;
      CelDDD       := edtCelDDD.Text;
      Celelular    := edtCellPhone.Text;
      Email        := edtEmail.Text;
      WebSite      := edtWebsite.Text;
      if not Juridico then
        CPF := edtCPF.Text
      else
        CPF := edtInscEstatual.Text;
      Identidate   := edtIdentidate.Text;
      OrgEmiss     := edtOrgaoEmissor.Text;
      ExpDate      := Trunc(dtExpDate.Date);
      BirthDate    := Trunc(dtBirthDay.Date);
      CustCard     := edtCustomerCard.Text;
      CMotorista   := etCartMotorista.Text;
      NomeJuridico := edtNomeJuridico.Text;
      InscEstadual := edtInscEstatual.Text;
      InscMunicipal:= edtInscMunicipal.Text;
      Contato      := EditContact.Text;
      OBS          := memOBS.Lines.Text;
    end;
    FCustomerInfo.IDCustomer := DMPDV.AddCustomer(FCustomerInfo);

  except
    on E: Exception do
    begin
      FreeAndNil(FCustomerInfo);
      MsgBox(E.Message, vbOKOnly + vbCritical);
    end;
  end;
end;

procedure TFrmNewCustomer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN:
      begin
      if not ValidateFields then
         Exit;
         FillCustomerInfo;
      end;
    VK_ESCAPE:
      begin
      end;
  end;
  if Key in [VK_RETURN, VK_ESCAPE] then
    Close;
end;

procedure TFrmNewCustomer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TFrmNewCustomer.rgTypeExit(Sender: TObject);
begin
  inherited;
  pnlFisico.Visible   := (rgType.ItemIndex = 0);
  pnlJuridico.Visible := not pnlFisico.Visible;
  lbLastName.Visible  := pnlFisico.Visible;
  edtLastName.Visible := pnlFisico.Visible;
  lbFill2.Visible     := pnlFisico.Visible;
end;

function TFrmNewCustomer.ValidateFields: Boolean;
begin
  Result := False;

  if rgType.ItemIndex = 0 then
     begin
     if (Trim(edtFirstName.Text) = '') or (Trim(edtLastName.Text) = '') then
        begin
        MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOKOnly);
        Exit;
        end;
     end
  else
     begin
     if Trim(edtFirstName.Text) = '' then
        begin
        MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOKOnly);
        Exit;
        end;
     end;


  if DM.fCashRegister.AskCPF or DM.fCashRegister.ValidateCPF then
  begin

    edtCPF.Text          := ReturnNumber(edtCPF.Text);
    edtInscEstatual.Text := ReturnNumber(edtInscEstatual.Text);

    if rgType.ItemIndex = 0 then
    begin
      if (edtCPF.Text = '') then
      begin
        MsgBox('CPF deve ser preenchido', vbCritical + vbOKOnly);
        Exit;
      end;
    end
    else
    begin
      if (edtInscEstatual.Text = '') then
      begin
        MsgBox('CNPJ deve ser preenchido', vbCritical + vbOKOnly);
        Exit;
      end;
    end;

    if DM.fCashRegister.ValidateCPF then
    begin
      if rgType.ItemIndex = 0 then
      begin
        if (not ValidaCPF(edtCPF.Text)) then
        begin
          MsgBox('CPF inválido!', vbCritical + vbOKOnly);
          Exit;
        end;
      end
      else
      begin
        if (not ValidaCNPJ(edtInscEstatual.Text)) then
        begin
          MsgBox('CNPJ inválido!', vbCritical + vbOKOnly);
          Exit;
        end;
      end;
    end;
  end;



  Result := True;

end;

procedure TFrmNewCustomer.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(200);
end;

end.
