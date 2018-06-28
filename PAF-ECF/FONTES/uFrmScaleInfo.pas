unit uFrmScaleInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, uBalanca;

type
  TFrmScaleInfo = class(TFrmPai)
    btnOK: TButton;
    tmrScale: TTimer;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblStatus: TLabel;
    pnlCodigo: TPanel;
    pnlValUnit: TPanel;
    pnlTara: TPanel;
    pnlCont: TPanel;
    pnlValTot: TPanel;
    pnlLiquido: TPanel;
    lbBruto: TLabel;
    lbProdutc: TLabel;
    Label1: TLabel;
    lbValorTotal: TLabel;
    procedure btCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tmrScaleTimer(Sender: TObject);
  private
    FResult : Double;
    FScaleStatus : Integer;
    FSellingPrice : Currency;
    FBalanca : TBalanca;
    function FormatScaleResult(AResult : Double): Double;
  public
    function Start(ABalanca : TBalanca; AProduct : String; ASellingPrice : Currency) : Double;
  end;

implementation

uses uNumericFunctions;

{$R *.dfm}

{ TFrmScaleInfo }

function TFrmScaleInfo.Start(ABalanca: TBalanca;
   AProduct : String; ASellingPrice : Currency): Double;
begin
  FBalanca := ABalanca;
  FResult := 0;
  lbProdutc.Caption := AProduct;
  FSellingPrice := ASellingPrice;

  if FBalanca.InitializeScale then
    tmrScale.Enabled := True;
  ShowModal;
  tmrScale.Enabled := False;
  FBalanca.FinalizeScale;
  Result := FResult;
end;

procedure TFrmScaleInfo.btCloseClick(Sender: TObject);
begin
  inherited;
  FResult := 0;
  Close;
end;

procedure TFrmScaleInfo.btnOKClick(Sender: TObject);
begin
  inherited;
  if FScaleStatus = BAL_PESO_ESTAVEL then
  begin
    FResult := FormatScaleResult(FBalanca.GetScaleModelValue);
    Close;
  end;
end;

procedure TFrmScaleInfo.tmrScaleTimer(Sender: TObject);
var
  sMSG, sMascara : String;
  dVaule : Double;
begin
  inherited;

  FScaleStatus := FBalanca.GetScaleStatus(sMSG);
  lblStatus.Caption := sMSG;

  if FScaleStatus in [BAL_PESO_VARIANDO, BAL_PESO_ESTAVEL] then
  begin
      dVaule          := FBalanca.GetScaleModelValue;
      lbBruto.Caption := FormatFloat('0.#####', FormatScaleResult(dVaule));
      if dVaule > 0 then
        lbValorTotal.Caption := FormatFloat('0.00', FormatScaleResult(dVaule) * FSellingPrice)
      else
        lbValorTotal.Caption := '';
      {
      pnlTara.Caption    := FormatFloat(sMascara, FBalanca.GetScaleValue(BAL_PESO_TARA));
      pnlLiquido.Caption := FormatFloat(sMascara, FBalanca.GetScaleValue(BAL_PESO_LIQ));
      pnlCont.Caption    := FloatToStr(FBalanca.GetScaleValue(BAL_COUN_PASS));
      pnlCodigo.Caption  := FloatToStr(FBalanca.GetScaleValue(BAL_COD_BAL));
      pnlValUnit.Caption := FloatToStr(FBalanca.GetScaleValue(BAL_VALOR_MONETARIO_KG));
      pnlValTot.Caption  := FloatToStr(FBalanca.GetScaleValue(BAL_VALOR_MONETARIO_TOTAL));
      }
  end
  else
  begin
      lbBruto.Caption    := '---------';
      pnlTara.Caption    := '---------';
      pnlLiquido.Caption := '---------';
      pnlCont.Caption    := '---------';
      pnlCodigo.Caption  := '---------';
      pnlValUnit.Caption := '---------';
      pnlValTot.Caption  := '---------';
  end;

end;

function TFrmScaleInfo.FormatScaleResult(AResult: Double): Double;
var
  sResult : String;
begin
  sResult  := FormatFloat('0.####', (AResult/FBalanca.GetDecimalValue));
  Result   := StrToFloat(sResult);
end;

end.
