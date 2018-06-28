unit uFrmProgresso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmProgresso = class(TForm)
    pbProgresso: TProgressBar;
    lblMSG: TLabel;
    btCancelar: TButton;
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cancelar: Boolean;
    procedure Start(iCount: integer);
    procedure StepUp;
  end;

implementation

uses udmSQL, udmNFe;

{$R *.dfm}

{ TForm1 }

procedure TFrmProgresso.Start(iCount: integer);
begin
  pbProgresso.Max := iCount;
  pbProgresso.Position := 0;
  Cancelar := False;
  Show;
  Application.ProcessMessages;
end;

procedure TFrmProgresso.StepUp;
begin
  pbProgresso.StepBy(1);
  Application.ProcessMessages;
end;


procedure TFrmProgresso.btCancelarClick(Sender: TObject);
begin
  Cancelar := True;
end;

end.
