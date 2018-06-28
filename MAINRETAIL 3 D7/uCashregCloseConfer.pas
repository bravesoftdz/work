unit uCashregCloseConfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  CheckLst;

type
  TCashregCloseConfer = class(TFrmParentAll)
    Button1: TButton;
    clbPayments: TCheckListBox;
    btUnSelectAll: TSpeedButton;
    btSelectAll: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    sLineInfo : String;
    bOK : Boolean;
    FLista : TList;
    procedure FillCheckListBox;
    procedure UpdatePaymentCheck;
  public
    function Start(Lista: TList): Boolean;
  end;

var
  CashregCloseConfer: TCashregCloseConfer;

implementation

uses uCashRegClose, uDMGlobal;

{$R *.dfm}

{ TCashregCloseConfer }

function TCashregCloseConfer.Start(Lista: TList): Boolean;
begin
  bOK := False;
  FLista := Lista;
  FillCheckListBox;
  ShowModal;
  Result := bOK;
end;

procedure TCashregCloseConfer.FillCheckListBox;
var
  I : Integer;
begin
  clbPayments.Clear;
  for I := 0 to FLista.Count-1 do
  begin
    clbPayments.AddItem(
      Format(
        sLineInfo,
        [PPayment(FLista[I])^.SaleCode,
         DateToStr(Trunc(PPayment(FLista[I])^.ExpireDate)),
         PPayment(FLista[I])^.MeioPag,
         PPayment(FLista[I])^.CheckNumber,
         FormatFloat(',##0.00', PPayment(FLista[I])^.ValorNominal)
        ]),
        TObject(PPayment(FLista[I]))
    );

    {
    if PPayment(FLista[I])^.Checked then
      clbPayments.Checked[clbPayments.Items.Count-1] := True
    else
      clbPayments.Checked[clbPayments.Items.Count-1] := False;
    }
    
    clbPayments.Checked[clbPayments.Items.Count-1] := False;
  end;
end;

procedure TCashregCloseConfer.Button1Click(Sender: TObject);
begin
  inherited;

  bOK := True;
  Close;
end;

procedure TCashregCloseConfer.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCashregCloseConfer.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sLineInfo := 'Hold # %S     Date %S   -   %S     # %S     Amount %S';
    end;

    LANG_PORTUGUESE:
    begin
      sLineInfo := 'Pedido %S     Data %S   -   %S     Nº %S     Valor %S';
    end;

    LANG_SPANISH :
    begin
      sLineInfo := 'Pedido %S     Fetcha %S   -   %S     Nº %S     Valor %S';
    end;
  end;

end;

procedure TCashregCloseConfer.btSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to Pred(clbPayments.Items.Count) do
    clbPayments.Checked[i] := True;
end;

procedure TCashregCloseConfer.btUnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to Pred(clbPayments.Items.Count) do
    clbPayments.Checked[i] := False;
end;

procedure TCashregCloseConfer.UpdatePaymentCheck;
var
  I : integer;
begin
  for I := 0 to FLista.Count-1 do
    PPayment(FLista[I])^.Checked := clbPayments.Checked[I];
end;

procedure TCashregCloseConfer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  UpdatePaymentCheck;
end;

end.
