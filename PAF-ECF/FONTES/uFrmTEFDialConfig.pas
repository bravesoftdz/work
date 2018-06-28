unit uFrmTEFDialConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  Mask, DateBox, uNumericFunctions;

type
  TfrmTEFDialConfig = class(TFrmPai)
    Label1: TLabel;
    cmbRede: TComboBox;
    Label2: TLabel;
    edtDoc: TEdit;
    edtValor: TEdit;
    Label4: TLabel;
    edtData: TDateBox;
    Label3: TLabel;
    Button1: TButton;
    procedure btCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
    procedure Start(ATEFDialTipo: Integer);
  end;

implementation
uses uDM, uTEFConsts;
{$R *.dfm}

procedure TfrmTEFDialConfig.Start(ATEFDialTipo: Integer);
begin
  cmbRede.Enabled := True;
  cmbRede.Clear;
  case ATEFDialTipo of
    TEF_DIAL_XPRESS:
      begin
        cmbRede.Items.Add('RedeCard');
        cmbRede.Items.Add('Visanet');
        cmbRede.Items.Add('AMEX');
      end;
    TEF_DIAL_HIPER:
      begin
        cmbRede.Items.Add('HCARD');
      end;
  end;

  cmbRede.Enabled := ATEFDialTipo = TEF_DIAL_XPRESS;

  cmbRede.ItemIndex := 0;

  ShowModal;
end;


procedure TfrmTEFDialConfig.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmTEFDialConfig.Button1Click(Sender: TObject);
begin
  inherited;
  DM.TEFDial1.NomeRede      := cmbRede.Items[cmbRede.ItemIndex];
  DM.TEFDial1.NSU           := Trim(edtDoc.Text);
  DM.TEFDial1.ValorAprovado := MyStrToMoney(edtValor.Text);
  DM.TEFDial1.DataTransacao := FormatDateTime('DDMMYYYY', edtData.Date);
  DM.TEFDial1.Cancelamento;
end;

end.
