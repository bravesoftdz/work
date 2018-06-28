unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmMain = class(TForm)
    frmCalcAvgCost: TBitBtn;
    lbversao: TLabel;
    procedure frmCalcAvgCostClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFrmAvgCostCalculation;

{$R *.dfm}

procedure TFrmMain.frmCalcAvgCostClick(Sender: TObject);
begin
  with TFrmAvgCostCalculation.Create(Self) do
  try
    Start(False);
  finally
    Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  i : integer;
  bExecucaoAutomatica : Boolean;
begin
  bExecucaoAutomatica := false;
  for i := 1 to ParamCount do
  begin
    if ParamStr(i) = 'auto' then
      bExecucaoAutomatica := true;
  end;

  if bExecucaoAutomatica then
  begin
    with TFrmAvgCostCalculation.Create(Self) do
    try
      Start(bExecucaoAutomatica);
    finally
      Free;
      Application.Terminate;
    end;
  end;
end;

end.
