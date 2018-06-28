unit RefundByItemWithoutInvoiceView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxRadioGroup,
  cxLookAndFeelPainters, StdCtrls, cxButtons, DbClient;

type
  TfrmRefundByItemWithoutInvoiceView = class(TForm)
    selectAction: TcxRadioGroup;
    cancelAction: TcxButton;
    applyAction: TcxButton;
    itemMessage: TStaticText;
    procedure applyActionClick(Sender: TObject);
    procedure cancelActionClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FrefundComplete: Boolean;
    itemRefund: TClientDataSet;
    idPreInventoryMov: Integer;

    procedure openDatasetRefundByItem(arg_itemToRefund: String);
    procedure prepareItemMessage(arg_model: TclientDataset);
    procedure showFormLikeModalForm();
    procedure sendToShelf();
    procedure sendToVendor();
    procedure closeForm();
    procedure cancelForm();
    procedure setMessage(arg_message: String);
  public
    { Public declarations }
    function startView(arg_ItemRefund: Integer): Boolean;
    function isRefundComplete(): Boolean;
    procedure setRefundComplete(arg_isComplete: Boolean);
  end;

var
  frmRefundByItemWithoutInvoiceView: TfrmRefundByItemWithoutInvoiceView;

implementation
uses uDM, SendToVendorView;

{$R *.dfm}

{ TfrmRefundByItemWithoutInvoiceView }

function TfrmRefundByItemWithoutInvoiceView.startView(arg_ItemRefund: Integer): Boolean;
begin
   // Antonio June 20, 2013
   itemRefund := dm.getOnePreInventoryMov(arg_itemRefund);
   prepareItemMessage(itemRefund);
   showFormLikeModalForm();
end;

procedure TfrmRefundByItemWithoutInvoiceView.applyActionClick(
  Sender: TObject);
begin
  try
    if ( selectAction.ItemIndex = 0 ) then
        sendToShelf
    else
        sendToVendor;

    closeForm();

  except on e: Exception do
         raise Exception.Create('Error when tried apply selection: ' + e.Message);
  end;
end;

procedure TfrmRefundByItemWithoutInvoiceView.sendToShelf;
begin
(*
   try
     itemRefund.edit;
     itemRefund.fieldByname('TotqtyOnHand').value := itemRefund.fieldByname('TotqtyOnHand').value + 1;
     dm.updateModelAddQuantityOnHand(itemRefund);
     application.MessageBox('Sent to shelf successfully', 'Send to Shelf',  mb_ok + mb_IconExclamation);
   except on e: Exception do
       raise Exception.Create('Error to send to shelf: ' + e.Message);
   end;
   *)
   setRefundComplete(true);
end;

procedure TfrmRefundByItemWithoutInvoiceView.sendToVendor;
var
   view: TfrmSendToVendorView;
begin
   try
      view := TfrmSendToVendorView.Create(nil);
      // Antonio June 20, 2013 - fix send to vendor
      view.startView(itemRefund);
      close;
      setRefundComplete(true);
   finally
      freeAndNil(view);
   end;
end;

procedure TfrmRefundByItemWithoutInvoiceView.cancelActionClick(
  Sender: TObject);
begin
  setRefundComplete(false);
  cancelForm();
end;

procedure TfrmRefundByItemWithoutInvoiceView.cancelForm;
begin
  ModalResult := mrCancel;
end;

procedure TfrmRefundByItemWithoutInvoiceView.closeForm;
begin
  modalResult := mrOK;
  close;
end;

procedure TfrmRefundByItemWithoutInvoiceView.setMessage(
  arg_message: String);
begin
   itemMessage.Caption := arg_message;
end;

procedure TfrmRefundByItemWithoutInvoiceView.prepareItemMessage(arg_model: TClientDataset);
begin
   setMessage(arg_model.fieldByName('model').AsString + ' - ' + arg_model.fieldByName('description').AsString);
end;

procedure TfrmRefundByItemWithoutInvoiceView.showFormLikeModalForm;
begin
   showModal;
end;

procedure TfrmRefundByItemWithoutInvoiceView.openDatasetRefundByItem(arg_itemToRefund: String);
begin
   itemRefund := dm.searchModel(arg_itemToRefund);
end;

procedure TfrmRefundByItemWithoutInvoiceView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  freeAndNil(itemRefund);
end;

function TfrmRefundByItemWithoutInvoiceView.isRefundComplete: Boolean;
begin
  result := FRefundComplete;
end;

procedure TfrmRefundByItemWithoutInvoiceView.setRefundComplete(
  arg_isComplete: Boolean);
begin
  FRefundComplete := arg_isComplete;
end;

end.
