unit uDMCalcTax;

interface

uses
  SysUtils, Classes, Db, ADODB, CalcExpress;

type
  TItemTax = class
  public
    IDPurchaseItemTax: Integer;
    IDPurchaseItem: Integer;
    IDTaxCategory: Integer;
    TaxPercentage: Double;
    TaxValue: Currency;
    MVA: Currency;
    Debit: Boolean;
    Formula: String;
    Cost: Currency;
    Freight: Currency;
    Other: Currency;
    Discount: Currency;
    Qty: Double;
  end;

  TDMCalcTax = class(TDataModule)
    CalcTaxFormula: TCalcExpress;
    quItemTax: TADOQuery;
    quItemTaxIDPurchaseItemTax: TIntegerField;
    quItemTaxTaxValue: TBCDField;
    quItemTaxTaxPercentage: TBCDField;
    quItemTaxTaxCategory: TStringField;
    quItemTaxDebit: TBooleanField;
    quItemTaxFormula: TStringField;
    spPurchaseItemTax: TADOStoredProc;
    quGetTaxValue: TADOQuery;
    quGetTaxValueIDPurchaseItemTax: TIntegerField;
    quGetTaxValueTaxValue: TBCDField;
    quGetTaxValueRet: TADOQuery;
    quGetTaxValueRetIDPurchaseItemTaxRet: TIntegerField;
    quGetTaxValueRetTaxValue: TBCDField;
    spPurchaseItemTaxRet: TADOStoredProc;
    quItemTaxRet: TADOQuery;
    quItemTaxRetIDPurchaseItemTaxRet: TIntegerField;
    quItemTaxRetTaxValue: TBCDField;
    quItemTaxRetTaxPercentage: TBCDField;
    quItemTaxRetTaxCategory: TStringField;
    quItemTaxRetDebit: TBooleanField;
    quItemTaxRetFormula: TStringField;
  private
    fADODBConnect: TADOConnection;
    procedure SetConection(ADOConnect: TADOConnection);
    function ReturnTaxValue(IDPurchaseItem: Integer; fIDTax: String): String;
    function ReturnTaxValueRet(IDPurchaseItem: Integer; fIDTax: String): String;
    function ReturnTaxValueByList(ATaxList: TList; AIDPurchaseItem, AIDTax: Integer): Currency;
    function GetTaxInFormula(IDPurchaseItem: Integer; Cost, Freight, Other,
      Percent, MVA, Discount: Currency; fFormula: String; bIsRet: Boolean): Currency;
    function GetTaxInFormulaByList(TaxList: TList; ItemTax: TItemTax): Currency;
  public
    procedure CreateTaxRet(IDPurchaseItem : Integer);
    procedure CreateTax(IDVendor, IDPurchase, IDPurchaseItem : Integer);
    procedure CalculateTax(IDPurchaseItem : Integer; Cost, Freight, Other, MVA, Discount : Currency; Qty : Double);
    procedure CalculateTaxRet(IDPurchaseItem : Integer; Cost, Freight, Other, MVA, Discount : Currency);
    procedure CalculateTaxList(var ATaxList: TList);
    function GetTaxesValueTotal(IDPurchaseItem : Integer) : Currency;
    function GetTaxesRetValueTotal(IDPurchaseItem : Integer): Currency;

    property ADODBConnect: TADOConnection read fADODBConnect write SetConection;
  end;

implementation

uses uSystemConst, uNumericFunctions;

{$R *.dfm}

{ TDMCalcTax }

procedure TDMCalcTax.CalculateTax(IDPurchaseItem: Integer;
  Cost, Freight, Other, MVA, Discount : Currency; Qty : Double);
var
  bReturn : Integer;
  OP : Integer;
begin

  if Cost <> 0 then
  begin
    with quItemTax do
    try
      if ((Qty < 0) and (Cost < 0)) then
         bReturn := -1
      else
         bReturn := 1;

      if not Active then
      begin
        Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
        Open;
      end;
      First;
      while not EOF do
      begin
        if not (State in dsEditModes) then
          Edit;
        if FieldByName('Debit').AsBoolean then
          OP := -1
        else
          OP := 1;

        if FieldByName('TaxPercentage').AsCurrency <> 0 then
        begin
          if FieldByName('Formula').AsString = '' then
            FieldByName('TaxValue').AsCurrency := ((Cost * (FieldByName('TaxPercentage').AsCurrency/100))*OP)
          else
            quItemTaxTaxValue.AsCurrency := ((GetTaxInFormula(IDPurchaseItem,
                                                              ABS(Cost),
                                                              ABS(Freight),
                                                              ABS(Other),
                                                              FieldByName('TaxPercentage').AsCurrency,
                                                              MVA,
                                                              Discount,
                                                              FieldByName('Formula').AsString,
                                                              False) * OP) * bReturn);
        end
        else
          FieldByName('TaxValue').AsCurrency := 0;
        Post;
        Next;
      end;

    finally
      Close;
      end;
  end;

end;

procedure TDMCalcTax.CalculateTaxList(var ATaxList: TList);
var
  i, OP: Integer;
  ItemTax: TItemTax;
begin
  for i := 0 to Pred(ATaxList.Count) do
  begin
    ItemTax := TItemTax(ATaxList[i]);
    if ItemTax.Cost <> 0 then
    begin
      if ItemTax.Debit then
        OP := -1
      else
        OP := 1;
      if ItemTax.TaxPercentage <> 0 then
      begin
        if ItemTax.Formula = '' then
          ItemTax.TaxValue := ((ItemTax.Cost * (ItemTax.TaxPercentage/100)) * OP)
        else
          ItemTax.TaxValue := (GetTaxInFormulaByList(ATaxList, ItemTax)*OP);
      end;
    end;
  end;
end;

procedure TDMCalcTax.CalculateTaxRet(IDPurchaseItem: Integer; Cost,
  Freight, Other, MVA, Discount: Currency);
var
  OP : Integer;
begin
  if Cost <> 0 then
  begin
    with quItemTaxRet do
    try
      if not Active then
      begin
        Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
        Open;
      end;
      First;
      While not EOF do
      begin
        if not (State in dsEditModes) then
          Edit;
        if FieldByName('Debit').AsBoolean then
          OP := -1
        else
          OP := 1;
        if FieldByName('TaxPercentage').AsCurrency <> 0 then
          begin
          if FieldByName('Formula').AsString = '' then
             FieldByName('TaxValue').AsCurrency := ((Cost * (FieldByName('TaxPercentage').AsCurrency/100)) * OP)
          else
             quItemTaxRetTaxValue.AsCurrency := (GetTaxInFormula(IDPurchaseItem,
                                                             Cost,
                                                             Freight,
                                                             Other,
                                                             FieldByName('TaxPercentage').AsCurrency,
                                                             MVA,
                                                             Discount,
                                                             FieldByName('Formula').AsString,
                                                             True)*OP);
          end;
      Next;
      end;
    finally
      Close;
      end;
  end;
end;

procedure TDMCalcTax.CreateTax(IDVendor, IDPurchase,
  IDPurchaseItem: Integer);
begin
  with spPurchaseItemTax do
  begin
    Parameters.ParambyName('@IDVendor').Value       := IDVendor;
    Parameters.ParambyName('@IDPurchaseItem').Value := IDPurchaseItem;
    Parameters.ParambyName('@IDPurchase').Value     := IDPurchase;
    ExecProc;
  end;
end;

procedure TDMCalcTax.CreateTaxRet(IDPurchaseItem: Integer);
begin
  with spPurchaseItemTaxRet do
  begin
    Parameters.ParambyName('@IDPurchaseItem').Value := IDPurchaseItem;
    ExecProc;
  end;
end;

function TDMCalcTax.GetTaxesRetValueTotal(IDPurchaseItem : Integer): Currency;
begin

  Result := 0;

  with quItemTaxRet do
  try
    if not Active then
    begin
      Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
      Open;
    end;
    First;
    While not EOF do
    begin
      Result := Result + FieldByName('TaxValue').AsCurrency;
      Next;
    end;
  finally
    Close;
    end;
end;

function TDMCalcTax.GetTaxesValueTotal(IDPurchaseItem : Integer): Currency;
begin

  Result := 0;

  with quItemTax do
  try
    if not Active then
    begin
      Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
      Open;
    end;
    First;
    While not EOF do
    begin
      Result := Result + FieldByName('TaxValue').AsCurrency;
      Next;
    end;
  finally
    Close;
    end;
end;


function TDMCalcTax.GetTaxInFormula(IDPurchaseItem : Integer; Cost, Freight,
  Other, Percent, MVA, Discount: Currency; fFormula: String; bIsRet: Boolean): Currency;
var
  args : array [0..100] of extended; // array of arguments - variable values
  fConst : TStringList;
  Decim : Char;
  i : Integer;
  sTax, sIDTax : String;
begin
  Result := 0;

  if Trim(fFormula) <> '' then
  begin
    fConst           := TStringList.Create;
    Decim            := DecimalSeparator;
    DecimalSeparator := '.';
    try
      //Tratar a formula
      While Pos('[', fFormula) > 0 do
      begin
        sTax   := '';
        sIDTax := '';
        for i := Pos('[', fFormula) to length(fFormula) do
           begin
           sTax := sTax + Copy(fFormula, i, 1);
           //verificar se o final da formula
           if fFormula[i] = ']' then
              Break;
           //copiar o id do imposto
           if (fFormula[i] <> '[') then
              sIDTax := sIDTax + Copy(fFormula, i, 1);
           end;

        if not bIsRet then
           fFormula := StringReplace(fFormula, sTax, ReturnTaxValue(IDPurchaseItem, sIDTax), [rfReplaceAll])
        else
           fFormula := StringReplace(fFormula, sTax, ReturnTaxValueRet(IDPurchaseItem, sIDTax), [rfReplaceAll]);
      end;
      // set expression to calculate
      CalcTaxFormula.Formula := fFormula;
      // set used variables list
      fConst.Add(PUR_COST);
      fConst.Add(PUR_FREIGHT);
      fConst.Add(PUR_OTHER);
      fConst.Add(PUR_PERCENT);
      fConst.Add(PUR_MVA);
      fConst.Add(PUR_DISCOUNT);

      CalcTaxFormula.Variables := fConst;
      // prepare arguments
      // SetLength(args,Values.Lines.Count);
      args[0] := Cost; //Cost
      args[1] := Freight;  //Freigh
      args[2] := Other;   //Other
      args[3] := (Percent/100); //Percent
      args[4] := (MVA/100); //Percent
      args[5] := Discount; //Discount

      Result := CalcTaxFormula.calc(args);

    finally
      FreeAndNil(fConst);
      DecimalSeparator := Decim;
    end;
  end;

end;

function TDMCalcTax.GetTaxInFormulaByList(TaxList: TList; ItemTax: TItemTax): Currency;
var
  args : array [0..100] of extended; // array of arguments - variable values
  fConst : TStringList;
  Decim : Char;
  i : Integer;
  sTax, sIDTax : String;
begin
  Result := 0;

  if Trim(ItemTax.Formula) <> '' then
  begin
    fConst           := TStringList.Create;
    Decim            := DecimalSeparator;
    DecimalSeparator := '.';
    try
      //Tratar a formula
      While Pos('[', ItemTax.Formula) > 0 do
      begin
        sTax   := '';
        sIDTax := '';
        for i := Pos('[', ItemTax.Formula) to length(ItemTax.Formula) do
        begin
           sTax := sTax + Copy(ItemTax.Formula, i, 1);
           //verificar se o final da formula
           if ItemTax.Formula[i] = ']' then
              Break;
           //copiar o id do imposto
           if (ItemTax.Formula[i] <> '[') then
              sIDTax := sIDTax + Copy(ItemTax.Formula, i, 1);
        end;
        ItemTax.Formula := StringReplace(ItemTax.Formula, sTax, MyFormatCur(ReturnTaxValueByList(TaxList, ItemTax.IDPurchaseItem, StrToInt(sIDTax)), '.'), [rfReplaceAll]);
      end;

      // set expression to calculate
      CalcTaxFormula.Formula := ItemTax.Formula;
      // set used variables list
      fConst.Add(PUR_COST);
      fConst.Add(PUR_FREIGHT);
      fConst.Add(PUR_OTHER);
      fConst.Add(PUR_PERCENT);
      fConst.Add(PUR_MVA);
      fConst.Add(PUR_DISCOUNT);

      CalcTaxFormula.Variables := fConst;
      // prepare arguments
      // SetLength(args,Values.Lines.Count);
      args[0] := ItemTax.Cost; //Cost
      args[1] := ItemTax.Freight;  //Freigh
      args[2] := ItemTax.Other;   //Other
      args[3] := (ItemTax.TaxPercentage/100); //Percent
      args[4] := (ItemTax.MVA/100); //Percent
      args[5] := ItemTax.Discount; //Discount

      Result := CalcTaxFormula.calc(args);
    finally
      FreeAndNil(fConst);
      DecimalSeparator := Decim;
    end;
  end;
end;

function TDMCalcTax.ReturnTaxValue(IDPurchaseItem : Integer; fIDTax: String): String;
begin
  with quGetTaxValue do
  try
    If Active then
       Close;
    Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
    Parameters.ParamByName('IDTaxCategory').Value  := fIDTax;
    Open;
    if RecordCount > 0 then
       Result := FormatFloat('0.00', ABS(FieldByName('TaxValue').AsFloat))
    else
       Result := '0';
  finally
    Close;
    end;
end;

function TDMCalcTax.ReturnTaxValueByList(ATaxList: TList;
  AIDPurchaseItem, AIDTax: Integer): Currency;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(ATaxList.Count) do
  begin
    if (TItemTax(ATaxList[i]).IDPurchaseItem = AIDPurchaseItem) and
       (TItemTax(ATaxList[i]).IDTaxCategory = AIDTax) then
    begin
      Result := ABS(TItemTax(ATaxList[i]).TaxValue);
      Break;
    end;
  end;
end;

function TDMCalcTax.ReturnTaxValueRet(IDPurchaseItem: Integer; fIDTax: String): String;
begin
  with quGetTaxValueRet do
  try
    If Active then
       Close;
    Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
    Parameters.ParamByName('IDTaxCategory').Value  := fIDTax;
    Open;
    if RecordCount > 0 then
       Result := FormatFloat('0.00', ABS(FieldByName('TaxValue').AsFloat))
    else
       Result := '0';
  finally
    Close;
    end;
end;

procedure TDMCalcTax.SetConection(ADOConnect: TADOConnection);
begin
  fADODBConnect                   := ADOConnect;
  quItemTax.Connection            := fADODBConnect;
  quItemTaxRet.Connection         := fADODBConnect;
  spPurchaseItemTax.Connection    := fADODBConnect;
  quGetTaxValue.Connection        := fADODBConnect;
  quGetTaxValueRet.Connection     := fADODBConnect;
  spPurchaseItemTaxRet.Connection := fADODBConnect;
end;

end.
