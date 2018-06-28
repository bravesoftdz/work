unit SendToVendorView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  dxExEdtr, dxEdLib, Buttons, dxCntner, dxEditor, StdCtrls, ExtCtrls,
  cxLookAndFeelPainters, cxButtons, DbClient;

type
  TfrmSendToVendorView = class(TForm)
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label19: TLabel;
    Label32: TLabel;
    noteLabel: TLabel;
    lbDefect: TLabel;
    serial: TdxEdit;
    sendToVendor: TSpeedButton;
    note: TdxMemo;
    itemModel: TdxEdit;
    dxEdit3: TdxEdit;
    Label3: TLabel;
    Label4: TLabel;
    cancel: TcxButton;
    defectTypeList: TcxComboBox;
    vendorList: TcxComboBox;
    Label6: TLabel;
    Label7: TLabel;
    procedure sendToVendorClick(Sender: TObject);
    procedure cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    itemRefund: TClientDataset;
    vendorCds: TClientDataset;
    defectTypeCds: TClientDataset;
    cdsToApply: TClientDataset;

    procedure showFormLikeModalForm();
    procedure PrepareData();
    procedure openModel(arg_idModel: Integer);
    procedure setModel(arg_model: String);
    function openVendorList(arg_idModel: Integer): Boolean;
    procedure loadVendorList();
    function openDefectTypeList(): Boolean;
    procedure loadDefectTypeList();
    procedure closeForm();
    procedure validateScreen();
    procedure setDataToApply();
    procedure applySendToVendor();

  public
    { Public declarations }
    function startView(arg_itemRefund: TClientDataset): Boolean;
  end;

var
  frmSendToVendorView: TfrmSendToVendorView;

implementation
uses uDM;

{$R *.dfm}

{ TfrmSendToVendorView }

procedure TfrmSendToVendorView.closeForm;
begin
   //close;
end;

procedure TfrmSendToVendorView.openModel(arg_idModel: Integer);
begin
   itemRefund := dm.searchModel(arg_idModel);
end;

procedure TfrmSendToVendorView.loadDefectTypeList;
begin
   defectTypeList.Clear();
   while ( not defectTypeCds.Eof ) do begin
       defectTypeList.Properties.Items.add(defectTypeCds.fieldByName('DefectType').AsString);
       defectTypeCds.Next;
   end;
end;

procedure TfrmSendToVendorView.loadVendorList;
begin
   vendorList.Clear;
   while ( not vendorCds.Eof ) do begin
      vendorlist.Properties.Items.Add(vendorCds.fieldByName('Fornecedor').AsString);
      vendorCds.Next;
   end;
end;

function TfrmSendToVendorView.openDefectTypeList: Boolean;
begin
   defectTypeCds := dm.searchDefectType();
end;

function TfrmSendToVendorView.openVendorList(
  arg_IdModel: Integer): Boolean;
begin
  vendorCds := dm.searchVendor();
end;


procedure TfrmSendToVendorView.showFormLikeModalForm;
begin
   showModal;
end;

function TfrmSendToVendorView.startView(arg_itemRefund: TClientDataset): Boolean;
begin
   // Antonio June 24, 2013
   itemRefund := arg_itemRefund;
   // Antonio June 21, 2013
   setModel(itemRefund.fieldByName('Model').value);
   openVendorList(itemRefund.fieldByName('ModelID').Value);
   loadVendorList();
   openDefectTypeList();
   loadDefectTypeList();
   showFormLikeModalForm();
end;

procedure TfrmSendToVendorView.sendToVendorClick(Sender: TObject);
begin
    validateScreen();
    PrepareData();
    applySendToVendor();
    close;
end;

procedure TfrmSendToVendorView.applySendToVendor;
begin
   try
     //dm.returnToVendor(cdsToApply); save to Sal_ItemRepair
     dm.insertRepair(cdsToApply); // save to Repair
     application.MessageBox('Sent to vendor successfull !', 'Send To Vendor', mb_OK + MB_ICONEXCLAMATION);
     sendToVendor.Enabled := false;
   except on e: Exception do
          raise Exception.Create('Error to apply to vendor: ' + e.message);
   end;
end;

procedure TfrmSendToVendorView.setModel(arg_model: String);
begin
  itemModel.Text := arg_model;
end;

procedure TfrmSendToVendorView.cancelClick(Sender: TObject);
begin
  closeForm;
end;

procedure TfrmSendToVendorView.FormShow(Sender: TObject);
begin
  vendorList.setfocus;
end;

procedure TfrmSendToVendorView.setDataToApply;
begin
   vendorCds.Locate('Fornecedor', vendorList.Text, []);
   cdsToApply.FieldByName('IDFornecedor').Value := vendorCds.fieldByName('IdFornecedor').Value;
   cdsToApply.fieldByname('Fase').Value := 'Send to Vendor';
   cdsToApply.fieldByName('SentDate').value := now;
   cdsToApply.fieldByName('IdModel').value := itemRefund.fieldByName('ModelID').Value;
   cdsToApply.fieldByName('IdStore').Value := itemRefund.fieldByName('StoreID').value;
   cdsToApply.fieldByname('qty').value := itemRefund.fieldByName('qty').value;
   cdsToApply.FieldByName('TipoRepair').Value := 0;
   cdsToApply.FieldByName('SerialNumber').Value := serial.Text;
   defectTypeCds.Locate('DefectType', defectTypeList.Text, []);
   cdsToApply.fieldByname('IdDefectType').Value := defectTypeCds.fieldByname('IdDefectType').Value;
   cdsToApply.fieldByName('IdUserSent').Value := dm.fUser.ID;
   cdsToApply.fieldByName('Tipo').value := 2;
end;

procedure TfrmSendToVendorView.validateScreen;
begin

    if ( trim(vendorList.Text) = '' ) then
        raise Exception.Create('Select a vendor.');

    if ( trim(defectTypeList.Text) = '' ) then
        raise Exception.Create('Select a defect type.');

end;

procedure TfrmSendToVendorView.PrepareData;
begin
  //cdsToApply := dm.getSaleItemRepair(cdsToApply);
  cdsToApply := dm.getRepairEmptyRecord;
  cdsToApply.Insert();
  setDataToApply();
end;

procedure TfrmSendToVendorView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 //  freeAndNil(itemRefund);
   freeAndNil(vendorCds);
   freeAndNil(defectTypeCds);
   freeAndNil(cdsToApply);
end;

end.
