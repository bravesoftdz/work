unit SuperEditCurrency;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, SuperEdit, Messages, Windows;

type
  TSuperEditCurrency = class(TSuperEdit)
  private
    FCleanFormat: String;
    FDisplayFormat : string;
    FOnCurrChange: TNotifyEvent;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure CurrencyChange;
    procedure SetDisplayFormat(AValue: String);
  public
    constructor Create( AOwner: TComponent ); override;
  published
    property OnCurrChange: TNotifyEvent read FOnCurrChange write FOnCurrChange;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
  end;

procedure Register;

implementation
uses Math;

procedure Register;
begin
  RegisterComponents('NewPower', [TSuperEditCurrency]);
end;

{ TSuperEditCurrency }

procedure TSuperEditCurrency.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_CHANGE) then CurrencyChange;
end;

procedure TSuperEditCurrency.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not HandleAllocated or (GetWindowLong(Handle, GWL_STYLE) and
    ES_MULTILINE <> 0) then Change;
end;

procedure TSuperEditCurrency.CurrencyChange;
var sText, nText: string;
      Num: double;
      i, p: integer;
      bNegative: boolean;
      CleanFormat: String; // pega o formato do server parameter e obtem o tamanho.
begin
  inherited Changed;
  if Assigned(FOnCurrChange) then
    FOnCurrChange(Self);

  sText := Text;

  if Length(sText) <= 2 then
    p := Length(FCleanFormat)
  else
    p := SelStart;

  bNegative := (Pos('-', sText) > 0);

  nText := sText;

  sText := nText; nText := '';
  for i := 1 to Length(sText) do
    if sText[i] in ['0', '1'..'9'] then
      nText := nText + sText[i];

  try
    Num := StrToFloat(nText);
    if bNegative then
      Num := Num * -1;
    sText := FormatFloat(FDisplayFormat, (Num/(power(10, length(FCleanFormat)-1))) );
  except
    // nothing;
  end;

  Text := sText;
  SelStart := p + 1;

end;

constructor TSuperEditCurrency.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create( AOwner );
  FDisplayFormat := '0.00';
end;

procedure TSuperEditCurrency.SetDisplayFormat(AValue: String);
var
  i: integer;
begin
  FDisplayFormat := Avalue;
  FCleanFormat := '';

  for i := 1 to Length(FDisplayFormat) do
    if FDisplayFormat[i] in ['0', '1'..'9'] then
      FCleanFormat := FCleanFormat + FDisplayFormat[i];
end;

end.
