unit uItemsCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, uParentAll, siComp, siLangRT, PaideTodosGeral,
  Buttons;

type
  TFrmItemsCalc = class(TFrmParentAll)
    BoxValue: TListBox;
    Label1: TLabel;
    EditValue: TEdit;
    btAdd: TButton;
    Label2: TLabel;
    EditTotalValue: TEdit;
    btClear: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditValueKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure AddValue(AValue: String);
  private
    { Private declarations }
    sEmptyValue: String;

  public
    { Public declarations }
    TotGeral : Double;
  end;

implementation

{$R *.DFM}

uses uNumericFunctions, uCharFunctions, uDMGlobal, uMsgBox, uMsgConstant;

procedure TFrmItemsCalc.btAddClick(Sender: TObject);
begin
  if MyStrToFloat(EditValue.Text) = 0 then
  begin
    EditValue.SetFocus;
    raise exception.create(sEmptyValue);
  end;

  AddValue(EditValue.Text);

  EditValue.Text := '';
  EditValue.SetFocus;
end;


procedure TFrmItemsCalc.AddValue(AValue: String);
var
  Valor : Double;
begin
  if MyStrToFloat(AValue) = 0 then
  begin
    exit;
  end;

  Valor := MyStrToFloat(AValue);
  BoxValue.Items.Add(FloatToStrF(Valor, ffNumber, 14, 2) + ' (+)');
  TotGeral := TotGeral + Valor;
  EditTotalValue.Text := FloatToStrF(TotGeral, ffNumber, 14, 2);
end;

procedure TFrmItemsCalc.btClearClick(Sender: TObject);
begin
  BoxValue.Items.Clear;
  TotGeral := 0;
  EditTotalValue.Text := FloatToStrF(TotGeral, ffNumber, 10, 2);
  EditValue.Text := '';
  EditValue.SetFocus;
end;

procedure TFrmItemsCalc.FormShow(Sender: TObject);
begin
  EditTotalValue.Text := FloatToStrF(0, ffNumber, 10, 2);
  EditValue.SetFocus;
end;

procedure TFrmItemsCalc.EditValueKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = '+' then
    begin
    btAddClick(nil);
    Key := #0;
    Exit;
    end;

 Key := ValidateCurrency(Key);

end;

procedure TFrmItemsCalc.FormCreate(Sender: TObject);
begin
  inherited;
  TotGeral := 0;
  case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sEmptyValue       := 'Can not add empty values';
           end;

     LANG_PORTUGUESE :
           begin
           sEmptyValue       := 'Não é possível adicionar valores em branco';
           end;

     LANG_SPANISH :
           begin
           sEmptyValue       := 'No puede agregar valores vacíos';
           end;
   end;
end;

end.
