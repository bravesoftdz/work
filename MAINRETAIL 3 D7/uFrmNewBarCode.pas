unit uFrmNewBarCode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, siComp, siLangRT, PaiDeForms;

type
  TFrmNewBarcode = class(TFrmParentForms)
    EditBarcode: TEdit;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    btOK: TButton;
    btCancel: TButton;
    lbQty: TLabel;
    edtQty: TEdit;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditBarcodeKeyPress(Sender: TObject; var Key: Char);
  private
    BarCode : String;
  public
    function Start(var Barcode:String; var Qty: Double):Boolean;
  end;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant, uCharFunctions;

{$R *.DFM}

procedure TFrmNewBarcode.btOKClick(Sender: TObject);
begin

  if Trim(EditBarCode.Text) = '' then
   begin
    EditBarCode.SetFocus;
    raise exception.create('Barcode can not be empty');
   end;

  BarCode := Trim(EditBarCode.Text);
  ModalResult := mrOK;

end;

function TFrmNewBarcode.Start(var Barcode:String; var Qty: Double):Boolean;
begin
  EditBarCode.Text := '';
  edtQty.Text      := '';

  ShowModal;

  Result  := (ModalResult = mrOK);
  Barcode := EditBarCode.Text;
  Qty     := StrToFloatDef(edtQty.Text, 0);
end;

procedure TFrmNewBarcode.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFrmNewBarcode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmNewBarcode.EditBarcodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #32 then
    Key := #0;
end;

end.
