unit uFrmUnitilizaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmUnitilizaNota = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edtAno: TLabeledEdit;
    edtModelo: TLabeledEdit;
    edtSerie: TLabeledEdit;
    edtNumInicial: TLabeledEdit;
    edtNumFim: TLabeledEdit;
    edtJustificativa: TLabeledEdit;
    edtCNPJ: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FOK : Boolean;
  public
    function Start(var ACNPJ, AModelo, ASerie, AAno, ANumeroInicial,
        ANumeroFinal, AJustificativa : String):Boolean;
  end;

implementation

{$R *.dfm}

{ TFrmUnitilizaNota }

function TFrmUnitilizaNota.Start(var ACNPJ, AModelo, ASerie, AAno, ANumeroInicial,
  ANumeroFinal, AJustificativa: String): Boolean;
begin

  FOK := False;

  ShowModal;

  Result := FOK;

  if Result then
  begin
    ACNPJ          := edtCNPJ.Text;
    AAno           := edtAno.Text;
    AModelo        := edtModelo.Text;
    ASerie         := edtSerie.Text;
    ANumeroInicial := edtNumInicial.Text;
    ANumeroFinal   := edtNumFim.Text;
    AJustificativa := edtJustificativa.Text;
  end;

end;

procedure TFrmUnitilizaNota.Button1Click(Sender: TObject);
begin
  FOK := True;
  Close;
end;

procedure TFrmUnitilizaNota.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
