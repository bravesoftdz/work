unit uFrmAvgCostCalculation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DateBox, Buttons, ExtCtrls, ComCtrls, ADODB, DB,
  DBClient;

type
  TFrmAvgCostCalculation = class(TForm)
    dtStart: TDateBox;
    Label1: TLabel;
    btnStart: TBitBtn;
    btnClose: TBitBtn;
    pnlCalculation: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pbModel: TProgressBar;
    pbTrans: TProgressBar;
    cdsBalance: TClientDataSet;
    quMovHistory: TADODataSet;
    quModel: TADODataSet;
    quModelLastBalance: TADODataSet;
    cmdInsertBalance: TADOCommand;
    cmdUpdateBalance: TADOCommand;
    lbModelTotal: TLabel;
    quModelLastAvgCost: TADODataSet;
    procedure btnCloseClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure OpenModel(IDModel : variant);
    procedure CloseModel;
    procedure CalculateAvgCost;
    procedure CreateBalance(IDModel : Integer; Data : TDateTime);
    procedure UpdateBalance(IDModel : Integer; Data : TDateTime; AQty : Double; AAvgCost, ABalanceTotal : Currency);

    procedure StartCalculation;

    procedure GetModelLastBalance(AIDModel : Integer; var AQty : Double; var AAvgCost, ABalanceTotal : Currency);
    function GetModelLastAvgCostNonZero(AIDModel: Integer; ABalanceDate: TDateTime): Currency;
  public
    function Start(AExecucaoAutomatica : Boolean) : Boolean;
  end;

var
  FrmAvgCostCalculation: TFrmAvgCostCalculation;

implementation

uses uDM, uDateTimeFunctions;

{$R *.dfm}

{ TFrmAvgCostCalculation }

function TFrmAvgCostCalculation.Start(AExecucaoAutomatica : Boolean): Boolean;
begin
  dtStart.Date := Date;
  if not AExecucaoAutomatica then
  begin
    ShowModal;
    Result := True;
  end
  else
  begin
    Show;
    btnStartClick(Self);
    Close;
    Result := True;
  end;
end;

procedure TFrmAvgCostCalculation.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAvgCostCalculation.btnStartClick(Sender: TObject);
begin
   try
     pnlCalculation.Visible := True;
     btnClose.Enabled := False;
     btnStart.Visible := False;
     StartCalculation;
   finally
     btnClose.Enabled := True;
     btnStart.Visible := True;
     pnlCalculation.Visible:= False;
   end;
end;

procedure TFrmAvgCostCalculation.StartCalculation;
begin
  //Abrir os modelos ativos para fazer o calculo
  OpenModel(Null);
  //OpenModel(1932);
  //Percorrer os modelos calculando o custo medio
  CalculateAvgCost;
end;

procedure TFrmAvgCostCalculation.CloseModel;
begin
  with quModel do
    if Active then
      Close;
end;

procedure TFrmAvgCostCalculation.OpenModel(IDModel: variant);
begin
  with quModel do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := IDModel;
      Open;
      pbModel.Max := RecordCount;
      pbModel.Position := 0;
    end;
end;

procedure TFrmAvgCostCalculation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseModel;
end;

procedure TFrmAvgCostCalculation.FormShow(Sender: TObject);
begin
  //dtStart.Date := FirstDateMonth;
end;

procedure TFrmAvgCostCalculation.CalculateAvgCost;
var
	FModelQty, FMovQty : Double;
	FAvgCostOut,
	FModelBalanceTotal,
  FLastAvgCost,
  FMovCost,
  FNewAvgCost : Currency;
begin
  with quModel do
  begin
    First;
    while not EOF do
    begin
      //Pegar o ultimo balance do modelo
      GetModelLastBalance(FieldByName('IDModel').AsInteger, FModelQty, FAvgCostOut, FModelBalanceTotal);

      //Calculo o custo médio da última data antes da data de processamento
      if FModelQty > 0 then
        FLastAvgCost := FModelBalanceTotal/FModelQty
      else
        FLastAvgCost := 0;

      //Abro o query de movimento dos produtos
      try
        if quMovHistory.Active then
          quMovHistory.Close;
        quMovHistory.Parameters.ParamByName('IDModel').Value := FieldByName('IDModel').AsInteger;
        quMovHistory.Parameters.ParamByName('Date').Value    := Trunc(dtStart.Date);
        quMovHistory.Open;
        quMovHistory.First;
        pbTrans.Max := quMovHistory.RecordCount;
        pbTrans.Position := 0;
        while not quMovHistory.Eof do
        begin
          //Cria a linha do balance
          CreateBalance(FieldByName('IDModel').AsInteger, Trunc(quMovHistory.FieldByName('MovDate').AsDateTime));

          FMovQty  := 0;
          FMovCost := 0;
          FNewAvgCost := 0;

          //Pego o total de quantidades de entrada, sem compras e importação. Esta quantidade será adicionada à
          //quantidade total de estoque, sem afetar o custo médio.
          if (quMovHistory.FieldByName('IDInventMovType').AsInteger in [4, 11, 19, 21]) and quMovHistory.FieldByName('UpdateOnHand').AsBoolean then
          begin
            FMovQty := quMovHistory.FieldByName('Qty').AsFloat;

            //Calculo a nova quantidade e valor total do estoque
            FModelQty := (FModelQty + FMovQty);

            if FModelQty > 0 then
            begin
              FModelBalanceTotal := FModelBalanceTotal + (FLastAvgCost * FMovQty);
              FAvgCostOut        := FModelBalanceTotal / FModelQty;
            end
            else
              FModelBalanceTotal := 0;
          end;

          //Pego a quantidade e o custo total comprado e importado
          if (quMovHistory.FieldByName('IDInventMovType').AsInteger in [2, 5]) and quMovHistory.FieldByName('UpdateOnHand').AsBoolean then
          begin
            FMovQty  := quMovHistory.FieldByName('Qty').AsFloat;
            FMovCost := Abs(quMovHistory.FieldByName('Cost').AsCurrency);

            //Calculo a nova quantidade e valor total do estoque. Se a quantidade em estoque antes das compras
            //for negativa, deve ser encontrado o custo médio das compras para achar o valor total de estoque
            //com a diferença entre a quantidade anterior e a comprada.
            if (FModelQty + FMovQty) > 0 then
            begin
              if FModelQty < 0 then
                FModelBalanceTotal := ((FMovQty * FMovCost) / FMovQty) * (FModelQty + FMovQty)
              else
                FModelBalanceTotal := FModelBalanceTotal + (FMovQty * FMovCost);

              FAvgCostOut := FModelBalanceTotal / (FModelQty + FMovQty);
            end
            else
            begin
              FModelBalanceTotal := 0;
              FAvgCostOut        := 0;
            end;

            FModelQty := FModelQty + FMovQty;
            FNewAvgCost := FAvgCostOut;
          end;

	        //Pego o total de quantidades de saída. Esta quantidade será removida da quantidade total de estoque,
	        //sem afetar o custo médio, desde que não zere a quantidade.
          if (quMovHistory.FieldByName('IDInventMovType').AsInteger in [1, 3, 12, 22]) and not quMovHistory.FieldByName('UpdateOnHand').AsBoolean then
          begin
            FMovQty := quMovHistory.FieldByName('Qty').AsFloat;

            if FModelQty > 0 then
            begin
            
              if FMovQty > 0 then
              begin
                FAvgCostOut := GetModelLastAvgCostNonZero(FieldByName('IDModel').AsInteger, quMovHistory.FieldByName('MovDate').AsDateTime);
                if FNewAvgCost = 0 then
                  FModelBalanceTotal := FModelBalanceTotal + (FMovQty * FAvgCostOut)
                else
                  FModelBalanceTotal := FModelBalanceTotal + (FMovQty * FNewAvgCost);
              end
              else
              begin
                FModelBalanceTotal := FModelBalanceTotal + (FMovQty * FAvgCostOut);
                if FModelBalanceTotal = 0 then
                  FAvgCostOut := 0;
              end


            end
            else
            begin
              if FMovQty > 0 then
              begin
                FAvgCostOut := GetModelLastAvgCostNonZero(FieldByName('IDModel').AsInteger, quMovHistory.FieldByName('MovDate').AsDateTime);
                if FNewAvgCost = 0 then
                  FModelBalanceTotal := (FMovQty * FAvgCostOut)
                else
                  FModelBalanceTotal := (FMovQty * FNewAvgCost);
              end
              else
              begin
                FAvgCostOut := 0;
                FModelBalanceTotal := 0;
              end
            end;

            FModelQty := FModelQty + FMovQty;
            FNewAvgCost := FAvgCostOut;
            if FModelQty = 0 then
              FModelBalanceTotal := 0;
          end;

          UpdateBalance(FieldByName('IDModel').AsInteger,
                        Trunc(quMovHistory.FieldByName('MovDate').AsDateTime),
                        FModelQty,
                        FAvgCostOut,
                        FModelBalanceTotal);

          Application.ProcessMessages;
          pbTrans.StepIt;
          quMovHistory.Next;
        end;

      finally
        quMovHistory.Close;
      end;

      pbModel.StepIt;
      lbModelTotal.Caption := 'Gerando (' + IntToStr(pbModel.Position) + ' de ' + IntToStr(pbModel.Max) + ')';
      Application.ProcessMessages;
      Next;
    end;

  end;
end;

procedure TFrmAvgCostCalculation.GetModelLastBalance(AIDModel: Integer;
  var AQty: Double; var AAvgCost, ABalanceTotal: Currency);
begin
  with quModelLastBalance do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDModel').Value  := AIDModel;
    Parameters.ParamByName('IDModel1').Value := AIDModel;
    Parameters.ParamByName('Date').Value     := Trunc(dtStart.Date);
    Open;
    AQty          := FieldByName('Qty').AsFloat;
    AAvgCost      := FieldByName('AvgCostOut').AsCurrency;
    ABalanceTotal := FieldByName('BalanceTotal').AsCurrency;
  finally
    Close;
  end;
end;

procedure TFrmAvgCostCalculation.CreateBalance(IDModel: Integer;
  Data: TDateTime);
begin
  with cmdInsertBalance do
  begin
    Parameters.ParamByName('IDModel1').Value     := IDModel;
    Parameters.ParamByName('Date').Value         := Data;
    Parameters.ParamByName('IDModel').Value      := IDModel;
    Parameters.ParamByName('BalanceDate').Value  := Data;
    Parameters.ParamByName('Qty').Value          := 0;
    Parameters.ParamByName('AvgCostOut').Value   := 0;
    Parameters.ParamByName('BalanceTotal').Value := 0;
    Execute;
  end;
end;

procedure TFrmAvgCostCalculation.UpdateBalance(IDModel: Integer;
  Data: TDateTime; AQty: Double; AAvgCost, ABalanceTotal: Currency);
begin
  with cmdUpdateBalance do
  begin
    Parameters.ParamByName('IDModel').Value      := IDModel;
    Parameters.ParamByName('BalanceDate').Value  := Data;
    Parameters.ParamByName('Qty').Value          := AQty;
    Parameters.ParamByName('AvgCostOut').Value   := AAvgCost;
    Parameters.ParamByName('BalanceTotal').Value := ABalanceTotal;
    Execute;
  end;
end;


function TFrmAvgCostCalculation.GetModelLastAvgCostNonZero(AIDModel: Integer; ABalanceDate: TDateTime): Currency;
begin
  with quModelLastAvgCost do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDModel').Value  := AIDModel;
    Parameters.ParamByName('IDModel1').Value := AIDModel;
    Parameters.ParamByName('Date').Value     := ABalanceDate;
    Open;
    Result := FieldByName('AvgCostOut').AsCurrency;
  finally
    Close;
  end;
end;

end.
