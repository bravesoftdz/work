unit uCalcCash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Buttons, DBCtrls, siComp,
  siLangRT;

type
  TCalcCash = class(TFrmParentAll)
    Panel10: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    grpCoin: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Edit0100: TEdit;
    Edit050: TEdit;
    Edit025: TEdit;
    Edit010: TEdit;
    Edit005: TEdit;
    Edit001: TEdit;
    EditTot001: TEdit;
    EditTot005: TEdit;
    EditTot010: TEdit;
    EditTot025: TEdit;
    EditTot050: TEdit;
    EditTot0100: TEdit;
    grpBill: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Edit100: TEdit;
    Edit50: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit10: TEdit;
    Edit20: TEdit;
    EditTot100: TEdit;
    EditTot50: TEdit;
    EditTot20: TEdit;
    EditTot10: TEdit;
    EditTot5: TEdit;
    EditTot2: TEdit;
    EditTot1: TEdit;
    EditTotCash: TEdit;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AtuTotals(Sender : TObject);
    procedure Edit100KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    TotCashGeral : Double;
  end;

implementation

uses uNumericFunctions, uDMGlobal;

{$R *.DFM}

procedure TCalcCash.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCalcCash.AtuTotals(Sender : TObject);
var
  Razao     : Double;
  EditValor : TEdit;
begin
  EditValor := TEdit(Sender);
  Razao     := (EditValor.Tag)/100;

  case EditValor.Tag of
    10000 : EditValor := EditTot100;
    5000  : EditValor := EditTot50;
    2000  : EditValor := EditTot20;
    1000  : EditValor := EditTot10;
     500  : EditValor := EditTot5;
     200  : EditValor := EditTot2;
     100  : if EditValor.Parent.tag = 0 then
              EditValor := EditTot1
            else
              EditValor := EditTot0100;
       1  : EditValor := EditTot001;
       5  : EditValor := EditTot005;
      10  : EditValor := EditTot010;
      25  : EditValor := EditTot025;
      50  : EditValor := EditTot050;
  end;

  EditValor.Text := FloatToStrF(MyStrToFloat(TEdit(Sender).Text)*Razao,
                    ffCurrency, 20, 2);

  // Atualiza o total geral
  TotCashGeral := MyStrToFloat(Edit100.Text)*100;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit50.Text)*50;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit20.Text)*20;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit10.Text)*10;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit5.Text)*5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit2.Text)*2;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit1.Text);
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit001.Text)*0.01;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit005.Text)*0.05;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit010.Text)*0.1;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit025.Text)*0.25;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit050.Text)*0.5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit0100.Text);

  EditTotCash.Text := FloatToStrF(TotCashGeral, ffCurrency, 20, 2);
end;

procedure TCalcCash.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8]) then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end;
end;

end.
