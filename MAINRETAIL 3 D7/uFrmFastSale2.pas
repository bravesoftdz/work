unit uFrmFastSale2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFastSale, siComp, siLangRT, DB, ADODB, StdCtrls, Grids,
  DBGrids, SMDBGrid, Mask, SuperComboADO, DBCtrls, LblEffct, ExtCtrls,
  Buttons, cxClasses, cxStyles, cxGridTableView;

type
  TFrmFastSale2 = class(TFrmFastSale)
    lbModel: TLabel;
    Edit1: TEdit;
    cmbModel: TSuperComboADO;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label5: TLabel;
    btHold: TButton;
    Shape2: TShape;
    Label9: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btHoldClick(Sender: TObject);
    procedure spquPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btReceiveClick(Sender: TObject);
    procedure grdItemsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    sPedidoCriado : String;
  protected
    procedure OnAfterNewInvoiceOnHold; override;
    procedure AfterCreateHoldNumber; override;
    procedure NextItem; override;
  public
    { Public declarations }
  end;

implementation

uses uQueryInventory, uFrmBarcodeSearch, uMsgBox, uDMGlobal,
  uFrmParentSales;

{$R *.dfm}

procedure TFrmFastSale2.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  fIDModel : Integer;
begin

  case Key of
       VK_F9  : begin
                with TFrmBarcodeSearch.Create(Self) do
                   begin
                   fIDModel := Start;
                   if fIDModel <> -1 then
                      begin
                      cmbModel.LookUpValue := IntToStr(fIDModel);
                      cmbModelSelectItem(self);
                      edtQty.SetFocus; 
                      end;
                   end;
                end;

       VK_F10 : begin
                with TQueryInventory.Create(Self) do
                     ShowModal;
                end;

       VK_F11  : begin
                 OnOpenHoldClick(Self);
                 end;

       VK_DELETE
               : begin
                 if (spquPreSaleItem.Active and (spquPreSaleItemModelID.AsInteger<>0)) then
                    OnRemoveClick(Self);
                 end;
  end;

end;

procedure TFrmFastSale2.cmbModelSelectItem(Sender: TObject);
begin
  inherited;
  if cmbModel.LookUpValue <> '' then
     SelectModel(StrToIntDef(cmbModel.LookUpValue,-1));
end;

procedure TFrmFastSale2.btCancelClick(Sender: TObject);
begin

  if (spquPreSaleItem.Active and (spquPreSaleItem.RecordCount=0)) then
     begin
     DeleteHold;
     Self.Close;
     Exit;
     end;

  if FInvoiceInfo.IsNewHold then
     begin
     DeleteHold;
     NewInvoiceOnHold;
     NextItem;
     end
  else
     CloseHold;

end;

procedure TFrmFastSale2.btHoldClick(Sender: TObject);
begin

  CloseHold;
  //Create a new Hold
  NewInvoiceOnHold;
  NextItem;

end;

procedure TFrmFastSale2.OnAfterNewInvoiceOnHold;
begin
  inherited;

  btHold.Enabled := False;
  pnlPaymentType.Visible := False;
  pnlShowCash.Visible    := False;
  
end;

procedure TFrmFastSale2.spquPreSaleItemAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  btHold.Enabled := (DataSet.RecordCount>0);
end;

procedure TFrmFastSale2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmFastSale2.edtQtyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) and (cmbModel.LookUpValue <> '') and ValidQty then
     AddSelectedModel(MyIDModel, MyDepartment, MyCost, MySelling);
end;

procedure TFrmFastSale2.NextItem;
begin
  inherited;
  cmbModel.LookUpValue := '';
  cmbModel.Text := '';
  cmbModel.SetFocus; 
end;

procedure TFrmFastSale2.btReceiveClick(Sender: TObject);
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

procedure TFrmFastSale2.grdItemsDblClick(Sender: TObject);
begin
  //inherited;

end;

procedure TFrmFastSale2.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sPedidoCriado := 'Hold # %S';
           end;

     LANG_PORTUGUESE :
           begin
           sPedidoCriado := 'Nº Pedido %S';
           end;

     LANG_SPANISH :
           begin
           sPedidoCriado := 'Nº Boleta %S';
           end;
   end;

end;

procedure TFrmFastSale2.AfterCreateHoldNumber;
begin
  inherited;
  MsgBox(Format(sPedidoCriado,[FInvoiceInfo.SaleCode]), vbOKOnly + vbInformation);
end;

procedure TFrmFastSale2.FormShow(Sender: TObject);
begin
  inherited;
  Width  := 800;
  Height := 600;
end;

end.
