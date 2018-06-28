unit uSubCalcSaleTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, StdCtrls, ComCtrls;

type
  TSubCalcSaleTax = class(TParentSub)
    quGetSaleCharge: TADOQuery;
    quGetSaleChargeTax: TBCDField;
    quSaleTax: TADOQuery;
    quSaleTaxTax: TBCDField;
    quGetSaleChargeTaxCategory: TStringField;
    quSaleTaxTaxCategory: TStringField;
    quGetSaleChargeDebit: TBooleanField;
    quSaleTaxDebit: TBooleanField;
    TreeImpostos: TTreeView;
    quGetSaleChargeParentTaxCategory: TStringField;
    quGetSaleChargeParentTax: TBCDField;
  private
    { Private declarations }
    fIDGroup,
    fIDStore : Integer;
    fTotalPercent : Double;
    procedure CalcTotals;
  protected
    procedure AfterSetParam; override;
    function GiveInfo(InfoString: String): String; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, uStringFunctions;

{$R *.dfm}

{ TSubCalcSaleTax }

procedure TSubCalcSaleTax.AfterSetParam;
begin
  inherited;
  fIDStore  := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
  fIDGroup  := StrToIntDef(ParseParam(FParam, 'IDGroup'),0);

  if (fIDStore = 0) or (fIDGroup = 0) then
     Exit;

  DataSetRefresh;
end;

procedure TSubCalcSaleTax.CalcTotals;
var
  sText : String;
  NodeParent : TTreeNode;
begin

  fTotalPercent := 0;

  TreeImpostos.Items.Clear;

  with quGetSaleCharge do
    if Active then
       begin
       First;

       sText := IncSpaces(quGetSaleChargeParentTaxCategory.AsString,28) + IncLeftSpaces(FormatFloat('0.00%',quGetSaleChargeParentTax.AsFloat),7);
       NodeParent := TreeImpostos.Items.Add(nil,sText);

       While not EOF do
         begin
         if quSaleTaxDebit.AsBoolean then
            begin
            sText := ' (-)';
            fTotalPercent := fTotalPercent - quGetSaleChargeTax.AsFloat;
            end
         else
            begin
            sText := ' (+)';
            fTotalPercent := fTotalPercent + quGetSaleChargeTax.AsFloat;
            end;

         sText := IncSpaces(quGetSaleChargeTaxCategory.AsString,24) + IncLeftSpaces(FormatFloat('0.00%',quGetSaleChargeTax.AsFloat),7) + sText;
         TreeImpostos.Items.AddChild(NodeParent, sText);
         Next;
         end;
       end;

  with quSaleTax do
    if Active then
       begin
       First;
       While not EOF do
         begin
         if quSaleTaxDebit.AsBoolean then
            begin
            sText := ' (-)';
            fTotalPercent := fTotalPercent - quSaleTaxTax.AsFloat;
            end
         else
            begin
            sText := ' (+)';
            fTotalPercent := fTotalPercent + quSaleTaxTax.AsFloat;
            end;


         sText := IncSpaces(quSaleTaxTaxCategory.AsString,28) + IncLeftSpaces(FormatFloat('0.00%',quSaleTaxTax.AsFloat),7) + sText;
         TreeImpostos.Items.Add(nil, sText);
         Next;
         end;
       end;

  sText := IncSpaces('Total',28) + IncLeftSpaces(FormatFloat('0.00%',fTotalPercent),7) + ' (=)';
  TreeImpostos.Items.Add(nil, sText);

end;

procedure TSubCalcSaleTax.DataSetClose;
begin
  inherited;
  with quGetSaleCharge do
    if Active then
       Close;

  with quSaleTax do
    if Active then
       Close;
end;

procedure TSubCalcSaleTax.DataSetOpen;
begin
  inherited;

  with quGetSaleCharge do
    if not Active then
       begin
       Parameters.ParamByName('IDStore').Value := fIDStore;
       Parameters.ParamByName('IDgroup').Value := fIDGroup;
       Open;
       end;

  with quSaleTax do
    if not Active then
       begin
       Parameters.ParamByName('IDStore').Value := fIDStore;
       Parameters.ParamByName('IDgroup').Value := fIDGroup;
       Open;
       end;

  CalcTotals;

end;

procedure TSubCalcSaleTax.DataSetRefresh;
begin
   DataSetClose;
   DataSetOpen;
end;

function TSubCalcSaleTax.GiveInfo(InfoString: String): String;
begin
  Result := FloatToStr(fTotalPercent);
end;

initialization
   RegisterClass(TSubCalcSaleTax);


end.
