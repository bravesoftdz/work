unit uFrmFastSaleGroucery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uFrmFastSale, Db, ADODB, siComp, siLangRT, StdCtrls, Mask, SuperComboADO, DBCtrls,
  LblEffct, ExtCtrls, Buttons, Grids, DBGrids, SMDBGrid, SubListPanel,
  cxClasses, cxStyles, cxGridTableView;

type
  TFrmFastSaleGrocery = class(TFrmFastSale)
    Shape9: TShape;
    Shape2: TShape;
    SubListImage: TSubListPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btReceiveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  protected
    procedure OnAfterNewInvoiceOnHold; override;
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.DFM}

procedure TFrmFastSaleGrocery.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of

       VK_F10 : begin //Pay
                if btReceive.Enabled then
                   btReceiveClick(nil);
                end;

  end;

end;

procedure TFrmFastSaleGrocery.edtBarcodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  TestSelectedModel(Key, edtBarcode.Text);

end;

procedure TFrmFastSaleGrocery.btReceiveClick(Sender: TObject);
begin

  //First Show the payment type panel
  if not pnlPaymentType.Visible then
     begin
     pnlPaymentType.Visible := True;
     cmbPaymentType.SetFocus; 
     Exit;
     end;

  //Validate and receive the payment
  if ValidateReceive then
     begin
     ReceiveHold;
     //After payment, hide payment type
     pnlPaymentType.Visible := False;
     pnlShowCash.Visible    := False;
     end;

end;

procedure TFrmFastSaleGrocery.OnAfterNewInvoiceOnHold;
begin
  SubListImage.Param := 'IDModel=0;ShowOpen=0;BackColor=clWhite;StartImage='+DM.fInvoice.XpressSaleImage+';';
end;

procedure TFrmFastSaleGrocery.FormCreate(Sender: TObject);
begin
  inherited;

  SubListImage.CreateSubList;
  SubListImage.Param := 'IDModel=0;ShowOpen=0;BackColor=clWhite;StartImage='+DM.fInvoice.XpressSaleImage+';';

end;

procedure TFrmFastSaleGrocery.dsPreSaleItemDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if spquPreSaleItemModelID.AsString <> '' then
     SubListImage.Param := 'IDModel='+spquPreSaleItemModelID.AsString+';ShowOpen=0;BackColor=clWhite;StartImage=;';
end;

end.
