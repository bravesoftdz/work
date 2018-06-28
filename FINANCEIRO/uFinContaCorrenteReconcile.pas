unit uFinContaCorrenteReconcile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Buttons, ExtCtrls, Db, ADODB, siComp,
  siLangRT;

type
  TFinContaCorrenteReconcile = class(TParentDialogFrm)
    quContaCorrente: TADOQuery;
    quContaCorrenteUltimoSaldoBancario: TFloatField;
    quContaCorrenteUltimaReconciliacao: TDateTimeField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtOpenBal: TEdit;
    edtCloseBal: TEdit;
    lbReconcDate: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtOpenBalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sLatRecon : string;
    IDConta : Integer;
    procedure OpenContaCorrente;
    procedure CloseContaCorrente;
  public
    { Public declarations }
    function Start(var StartBalance, EndBalance : Currency; IDConta:Integer):Boolean;
  end;

implementation

uses uDM, uNumericFunctions, uDMGlobal;

{$R *.DFM}

procedure TFinContaCorrenteReconcile.OpenContaCorrente;
begin
  with quContaCorrente do
      begin
      Parameters.ParamByName('IDContaCorrente').Value := IDConta;
      Open;
      edtOpenBal.Text := FormatFloat('##0.00', quContaCorrenteUltimoSaldoBancario.AsCurrency);
      lbReconcDate.Caption := sLatRecon + quContaCorrenteUltimaReconciliacao.AsString;
      end;
end;

procedure TFinContaCorrenteReconcile.CloseContaCorrente;
begin
  with quContaCorrente do
      if Active then
         Close;
end;


function TFinContaCorrenteReconcile.Start(var StartBalance, EndBalance : Currency; IDConta:Integer):Boolean;
begin

    Self.IDConta := IDConta;

    ShowModal;

    if (ModalResult=mrOk) then
       begin
       StartBalance := MyStrToFloat(edtOpenBal.Text);
       EndBalance   := MyStrToFloat(edtCloseBal.Text);
       Result       := True;
       end;
end;

procedure TFinContaCorrenteReconcile.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseContaCorrente;
end;

procedure TFinContaCorrenteReconcile.FormShow(Sender: TObject);
begin
  inherited;
  OpenContaCorrente;
  CloseContaCorrente;
end;

procedure TFinContaCorrenteReconcile.edtOpenBalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloat(Key);
end;

procedure TFinContaCorrenteReconcile.FormCreate(Sender: TObject);
begin
  inherited;
    case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sLatRecon := 'This account was last reconciled ';
           end;
    LANG_PORTUGUESE :
           begin
           sLatRecon := 'Esta conta foi reconciliada ';
           end;
    LANG_SPANISH :
           begin
           sLatRecon := 'Esta coenta foi reconciliada ';
           end;
  end;

end;

end.
