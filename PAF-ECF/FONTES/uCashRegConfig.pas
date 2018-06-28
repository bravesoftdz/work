unit uCashRegConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, StdCtrls, Buttons, ExtCtrls, Menus, siComp, siLangRT;

const
  OPEN_TYPE_DESABLE = 1;
  OPEN_TYPE_ALTER   = 2;

type
  TFrmCashRegConfig = class(TFrmPai)
    btnPrinter: TBitBtn;
    btnCashConfig: TBitBtn;
    btnConfigPDV: TBitBtn;
    btnSintegra: TBitBtn;
    btnMenuFiscal: TBitBtn;
    procedure btnPrinterClick(Sender: TObject);
    procedure btnCashConfigClick(Sender: TObject);
    procedure NmerodeCuponsCancelados1Click(Sender: TObject);
    procedure NmerodeRedues1Click(Sender: TObject);
    procedure btnConfigPDVClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnSintegraClick(Sender: TObject);
    procedure btnMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(iType:Integer):Boolean;
  end;

implementation

uses uDM, uFchParam, uFrmTEFDialConfig, DB, uMRPDVConfigKey, uDMGlobal,
  uFrmSintegra, uFrmMenufiscal;

{$R *.dfm}

function TFrmCashRegConfig.Start(iType:Integer):Boolean;
begin

  btnMenuFiscal.Visible := ((DMGlobal.IDLanguage = LANG_PORTUGUESE));

  btnSintegra.Visible := ((DMGlobal.IDLanguage = LANG_PORTUGUESE)
                          and ((DM.fPrintReceipt.ECFPrinterName = 'BematechMP40')
                          or (DM.fPrintReceipt.ECFPrinterName = 'BematechMP20')
                          or (DM.fPrintReceipt.ECFPrinterName = 'BematechTermica')
                          or (DM.fPrintReceipt.ECFPrinterName = 'Daruma')
                          or (DM.fPrintReceipt.ECFPrinterName = 'DarumaTermica')
                          or  (DM.fPrintReceipt.ECFPrinterName = 'Elgin'))
                          );

  case iType of
  OPEN_TYPE_DESABLE : begin
                      btnPrinter.Enabled    := False;
                      btnCashConfig.Enabled := False;
                      end;

  OPEN_TYPE_ALTER   : begin
                      btnPrinter.Enabled    := True;
                      btnCashConfig.Enabled := True;
                      end;
  end;

  Result := (ShowModal<>0);

end;

procedure TFrmCashRegConfig.btnPrinterClick(Sender: TObject);
begin
  inherited;
  with TFchParameter.Create(Self) do
      Start(PARAM_OPEN_PRINTER);

end;

procedure TFrmCashRegConfig.btnCashConfigClick(Sender: TObject);
begin
  inherited;
  with TFchParameter.Create(Self) do
      //Start(PARAM_OPEN_CASHREG);
      Start(PARAM_OPEN_ALL);
end;

procedure TFrmCashRegConfig.NmerodeCuponsCancelados1Click(Sender: TObject);
var cCuponsCancelados : String;
    iConta            : Integer;
begin
  inherited;
     // reserva 4 bytes para a variável
     For iConta := 1 To 4 Do Begin cCuponsCancelados := cCuponsCancelados + ' ' End;
     // função que retorna o número de cupons cancelados
     DM.EFiscal1.NumeroCuponsCancelados( cCuponsCancelados );
     ShowMessage( 'Número de Cupons Cancelados:' + #13 + #13 + cCuponsCancelados );
end;

procedure TFrmCashRegConfig.NmerodeRedues1Click(Sender: TObject);
var CGC: String;
    iConta: integer;
begin
end;


procedure TFrmCashRegConfig.btnConfigPDVClick(Sender: TObject);
begin
  inherited;
  with TFrmMRDPVConfigKey.Create(Self) do
     Start;
end;

procedure TFrmCashRegConfig.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(20);
end;

procedure TFrmCashRegConfig.btnSintegraClick(Sender: TObject);
begin
  inherited;
  with TFrmSintegra.Create(Self) do
    Start;
end;

procedure TFrmCashRegConfig.btnMenuFiscalClick(Sender: TObject);
begin
  inherited;
  with TFrmMenufiscal.Create(Self) do
    Start;
end;

end.
