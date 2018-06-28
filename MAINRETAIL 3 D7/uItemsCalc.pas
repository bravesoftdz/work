unit uItemsCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, siComp, siLangRT, PaiDeForms;

type
  TfrmItemsCalc = class(TFrmParentForms)
    BoxValue: TListBox;
    Label1: TLabel;
    EditValue: TEdit;
    btAdd: TButton;
    Label2: TLabel;
    EditTotalValue: TEdit;
    btClear: TButton;
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    btOK: TButton;
    btCancel: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditValueKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    TotGeral : Double;
  end;

implementation

{$R *.DFM}

uses uNumericFunctions, uCharFunctions, uDMGlobal, uMsgBox, uMsgConstant;

procedure TfrmItemsCalc.btAddClick(Sender: TObject);
var
  Valor : Double;
begin
  if MyStrToFloat(EditValue.Text) = 0 then
  begin
    EditValue.SetFocus;
    MsgBox(MSG_CRT_NO_EMPTY_VALUE, vbOKOnly + vbCritical);
    Exit;
//    raise exception.create('Can not add empty values');
  end;

  Valor := MyStrToFloat(EditValue.Text);
  BoxValue.Items.Add(FloatToStrF(Valor, ffNumber, 14, 2) + ' (+)');
  TotGeral := TotGeral + Valor;
  EditTotalValue.Text := FloatToStrF(TotGeral, ffNumber, 14, 2);

  EditValue.Text := '';
  EditValue.SetFocus;
end;

procedure TfrmItemsCalc.btClearClick(Sender: TObject);
begin
  BoxValue.Items.Clear;
  TotGeral := 0;
  EditTotalValue.Text := FloatToStrF(TotGeral, ffNumber, 10, 2);
  EditValue.Text := '';
  EditValue.SetFocus;
end;

procedure TfrmItemsCalc.FormShow(Sender: TObject);
begin
  inherited;
  TotGeral := 0;
  EditTotalValue.Text := FloatToStrF(0, ffNumber, 10, 2);
  EditValue.SetFocus;
end;

procedure TfrmItemsCalc.EditValueKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = '+' then
    begin
    btAddClick(nil);
    Key := #0;
    Exit;
    end;

 Key := ValidateCurrency(Key);

end;

end.
