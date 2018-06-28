unit uFinFechCupFisc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmFinFechCupFisc = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFinFechCupFisc: TFrmFinFechCupFisc;

implementation

Uses uDM;

{$R *.DFM}

Procedure TFrmFinFechCupFisc.Button1Click(Sender: TObject);
begin
   with DM.EFiscal1 do begin
   if Caption = 'Finaliza o Fechamento do Cupom Fiscal' then begin
      TermFechCupFisc(Memo1.Text);
   end else begin
      FechaRecebimentoNaoFiscalMFD(Memo1.Text);
   end;
   end;
   Close;
End;

procedure TFrmFinFechCupFisc.Button2Click(Sender: TObject);
begin
Close;
end;

End.
