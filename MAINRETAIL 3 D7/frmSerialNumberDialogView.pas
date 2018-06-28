unit frmSerialNumberDialogView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls;

type
  TfrmSerialDgView = class(TDialogParent)
    lblSerialType: TLabel;
    lblValue: TLabel;
    edtSerialNumber: TEdit;
    procedure AplicarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtSerialNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fIdInvoice: Integer;
    FSerialNumber: String;
    FInternal: Boolean;
    FIdModel: Integer;
    FIdStore: Integer;
    FIdItem: Integer;
    FMaxQty: Integer;
    FBalance: Double;
    FcountQty: Integer;
    FMsg: String;
    procedure setIdModel(const Value: Integer);
    procedure setIdMov(const Value: Integer);
    procedure setIdStore(const Value: Integer);
    procedure refreshLabel();
    procedure writeSerialNumber(serial_number: String);
  public
    { Public declarations }
     property IdModel: Integer write setIdModel;
     property IdStore: Integer write setIdStore;
     property IdMov: Integer write setIdMov;

     function Start(msg_gift: String; ini_qty, end_qty, idmodel, iditem: Integer;
                    balance: Double; arg_invoice: Integer = -1): Boolean;
  end;

implementation
uses uCreditCardFunction, SerialNumberCls, uDM, ufrmPCCSwipeCard;

{$R *.dfm}

{ TfrmSerialDgView }

function TfrmSerialDgView.Start(msg_gift: String; ini_qty, end_qty, idmodel, iditem: Integer;
balance: Double; arg_invoice: Integer): Boolean;
begin
    FMaxQty   := end_qty;
    FBalance  := balance;
    FcountQty := 0;
    FMsg      := msg_gift;
    FIdModel  := idmodel;
    FIdItem   := iditem;
    FIdStore  := dm.fStore.ID;
    fIdInvoice := arg_invoice;
    refreshLabel();
    result := (ShowModal = mrOk);
end;

procedure TfrmSerialDgView.AplicarClick(Sender: TObject);
begin
  FSerialNumber := edtSerialNumber.Text;
  WriteSerialNumber(FSerialNumber);
  refreshLabel();
end;

procedure TfrmSerialDgView.setIdModel(const Value: Integer);
begin
    FIdModel := Value;
end;

procedure TfrmSerialDgView.setIdMov(const Value: Integer);
begin
   FIdItem := Value;
end;

procedure TfrmSerialDgView.setIdStore(const Value: Integer);
begin
   FIdStore := Value;
end;

procedure TfrmSerialDgView.refreshLabel();
var
    msg: String;
begin
    inc(FCountQty);
    msg := format(FMsg + '%d of %d', [FcountQty, FMaxQty]);
    lblSerialType.Caption := msg;
    lblValue.Caption := '($' + formatFloat('#,##0.00', FBalance) + ')';
    edtSerialNumber.Clear;
    if ( FCountQty > FMaxQty ) then
       close();
end;


procedure TfrmSerialDgView.WriteSerialNumber(serial_number: String);
var
  objSerialNumber: TSerialNumberFromPreSale;
  serialNumber: String;
begin
   try
      try
         // Antonio 06/01/2016 - to protect this transaction and avoid orphan records
         dm.ADODBConnect.BeginTrans;
         objSerialNumber := TSerialNumberFromPreSale.Create(FIdModel, FIdStore, FIdItem, trunc(FMaxQty));
         objSerialNumber.Connection := dm.ADODBConnect;
         objSerialNumber.IdInvoice := fIdInvoice;
         if ( not objSerialNumber.isDuplicateSerial(serial_number) ) then begin

            if ( objSerialNumber.addAccountNumber(serial_number) ) then
               objSerialNumber.Add(FIdItem, serial_number, '', '0');

         end;

         dm.ADODBConnect.CommitTrans;

      except
         on e: Exception do begin
            dm.ADODBConnect.RollbackTrans;
            raise Exception.Create('Error found when tried add serial number: ' + e.Message);
         end;
      end;
   finally
      freeAndNil(objSerialNumber);
   end;
end;

procedure TfrmSerialDgView.CancelarClick(Sender: TObject);
begin
  inherited;
  if ( application.MessageBox('Cancel ALL serials numbers ?', 'Cancel', mb_YESNO + MB_ICONQUESTION) = idYes ) then begin
     dm.fMRMercury.QtyToRemove := FMaxQty;
     fCountQty := FMaxQty + 1;
     close();
  end
  else begin
      dm.fMRMercury.QtyToRemove := dm.fMRMercury.QtyToRemove + 1;
      refreshLabel();
  end;

end;

procedure TfrmSerialDgView.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  canClose := ( FcountQty > FMaxQty );
end;

procedure TfrmSerialDgView.edtSerialNumberKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if ( key = VK_RETURN ) then begin
     AplicarClick(sender);
  end;

end;

end.
