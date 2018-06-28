unit uFinContaCorrenteAjustaDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Mask, Buttons, ExtCtrls,
  Db, DBTables, dxDateEdit, ADODB, SuperComboADO, dxCntner, dxEditor,
  dxExEdtr, dxEdLib, siComp, siLangRT, DateBox;

type
  TFinContaCorrenteAjustaDlg = class(TParentDialogFrm)
    Label1: TLabel;
    scContaCorrente: TSuperComboADO;
    Label2: TLabel;
    eUsu: TEdit;
    eSaldo: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    eAjuste: TEdit;
    Label5: TLabel;
    quSaldo: TADOQuery;
    quSaldoSaldo: TFloatField;
    spAjusta: TADOStoredProc;
    dbData: TDateBox;
    procedure scContaCorrenteChange(Sender: TObject);
    procedure eUsuChange(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure eUsuKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Saldo: Currency;
    bMarkAsReconciled : Boolean;

    procedure CalcAjuste;
    procedure CalcSaldo;

  public
    { Public declarations }
    function Start(IDContaCorrente: integer; Data: TDateTime;
                   Valor:Currency; MarkAsReconciled : Boolean): boolean;
  end;

implementation

uses uDM, uMsgBox, uSisSenha, uNumericFunctions, uDateTimeFunctions,
     uMsgConstant;

{$R *.DFM}

function TFinContaCorrenteAjustaDlg.Start(IDContaCorrente: integer; Data: TDateTime;
                                          Valor:Currency; MarkAsReconciled : Boolean): boolean;
begin

  dbData.Clear;
  eUsu.Clear;
  eSaldo.Clear;
  eAjuste.Clear;
  scContaCorrente.LookUpValue := '';

  if (IDContaCorrente > 0) then
    scContaCorrente.LookUpValue := IntToStr(IDContaCorrente);

  if (Data <> 0) then
    dbData.Date := Date;

  bMarkAsReconciled := MarkAsReconciled;

  CalcSaldo;

  //Calcula o Saldo se necesssario
  if (Valor <> 0) then
     begin
     eUsu.Text := FormatFloat('#0.00', Valor);
     CalcAjuste;
     end;

  Result := (ShowModal = mrOk);

end;

procedure TFinContaCorrenteAjustaDlg.CalcSaldo;
begin

  if (scContaCorrente.LookUpValue <> '') and (TestDate(dbData.text)) then
    with quSaldo do     // Calculo o Saldo na data
      begin
        Parameters.ParamByName('Inicio').Value := dbData.Date + 1;
        Parameters.ParamByName('IDContaCorrente').Value := MyStrToInt(scContaCorrente.LookUpValue);
        Open;
        Saldo  := Fields[0].AsCurrency;
        eSaldo.Text := FloatToStrF(Saldo, ffCurrency, 20, 2);
        Close;
      end;

end;

procedure TFinContaCorrenteAjustaDlg.scContaCorrenteChange(
  Sender: TObject);
begin
  inherited;

   CalcSaldo;
   CalcAjuste;

end;

procedure TFinContaCorrenteAjustaDlg.CalcAjuste;
begin
  // Calcula qual o ajuste
  if eUsu.Text <> '' then
    try
      eAjuste.Text := FloatToStrF((StrToFloat(eUsu.Text) - Saldo), ffCurrency, 20, 2);
    except
      eAjuste.Text := '';
    end
  else
    eAjuste.Text := '';

end;

procedure TFinContaCorrenteAjustaDlg.eUsuChange(Sender: TObject);
begin
  inherited;
  CalcAjuste;
end;


procedure TFinContaCorrenteAjustaDlg.btOkClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrNone;

  // Inclui o Lancamento de Ajuste de Conta Corrente
  if MsgBox(MSG_QST_CONFIRM, vbQuestion + vbYesNo) = vbYes then
    begin
      try
        with spAjusta do
          begin
            Parameters.ParamByName('@IDContaCorrente').Value := StrToInt(scContaCorrente.LookUpValue);
            Parameters.ParamByName('@Data').Value            := dbData.Date;
            Parameters.ParamByName('@Valor').Value           := StrToFloat(eUsu.Text) - Saldo;
            Parameters.ParamByName('@IDUsuario').Value       := SisSenha.IDUsuario;
            ExecProc;
          end;
        ModalResult := mrOk;
      except
        MsgBox(MSG_CRT_ERROR_BALANCE_CHANGE, vbCritical + vbOkOnly);
      end;

    end;

end;


procedure TFinContaCorrenteAjustaDlg.eUsuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

Initialization
  RegisterClass(TFinContaCorrenteAjustaDlg);


end.
