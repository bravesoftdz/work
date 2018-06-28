unit uSubCalcPurchaseTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Grids, DBGrids, SMDBGrid,
  StdCtrls, DB, ADODB;

type
  TSubCalcPurchaseTax = class(TParentSub)
    quTaxCat: TADOQuery;
    quTaxCatIDTaxCategory: TIntegerField;
    quTaxCatTaxCategory: TStringField;
    quTaxCatTax: TBCDField;
    quTaxCatDebit: TBooleanField;
    dsTaxCat: TDataSource;
    quTaxCatFormula: TStringField;
  private
    { Private declarations }
    fIDTax    : Integer;
    fCost,
    fFreight,
    fOther,
    fTax    : Currency;
    procedure CalcFunction;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, CalcExpress;


{$R *.dfm}

{ TSubCalcPurchaseTax }

procedure TSubCalcPurchaseTax.AfterSetParam;
begin
  inherited;
  fIDTax   := StrToIntDef(ParseParam(FParam, 'IDTaxCategory'),0);
  fCost    := StrToCurrDef(ParseParam(FParam, 'Cost'),0);
  fFreight := StrToCurrDef(ParseParam(FParam, 'Freght'),0);
  fOther   := StrToCurrDef(ParseParam(FParam, 'Other'),0);

  if fIDTax = 0 then
     Exit;

  DataSetRefresh;
end;

procedure TSubCalcPurchaseTax.CalcFunction;
var args : array [0..100] of extended; // array of arguments - variable values
    i : integer;
begin
{  if (Vars.Lines.Count = Values.Lines.Count) then
   begin
    // set expression to calculate
    CalcExpress1.Formula := ExprEdt.Text;
    // set used variables list
    CalcExpress1.Variables:= Vars.Lines;
    // prepare arguments
//    SetLength(args,Values.Lines.Count);
    for i:=0 to Values.Lines.Count-1 do
     args[i] := StrToFloat(Values.Lines[i]);
    // calculate expression
    ShowMessage(CalcExpress1.Formula+'='+
                FloatToStr(CalcExpress1.calc(args)));
   end
  else
    MessageDlg('Variables and Variable values lists should have the same lines quantity.', mtInformation, [mbOk], 0);
    }
end;

procedure TSubCalcPurchaseTax.DataSetClose;
begin
  inherited;
  with quTaxCat do
     if Active then
        Close;
end;

procedure TSubCalcPurchaseTax.DataSetOpen;
begin
  inherited;
  with quTaxCat do
     if not Active then
        begin
        Parameters.ParamByName('IDTaxCategory').Value := fIDTax;
        Open;
        end;
end;

procedure TSubCalcPurchaseTax.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

initialization
   RegisterClass(TSubCalcPurchaseTax);


end.
