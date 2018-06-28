unit uFrmEmailBuilder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Email, Buttons, DB, DBClient, Contnrs;

type
  TFrmEmailBuilder = class(TFrmParent)
    Label1: TLabel;
    edtSubject: TEdit;
    mmReceivers: TMemo;
    Label2: TLabel;
    btnSend: TButton;
    Label3: TLabel;
    memBody: TMemo;
    Emails: TEmail;
    Label5: TLabel;
    edtAttached: TEdit;
    btnOpenFile: TSpeedButton;
    rbEmailTo: TRadioGroup;
    OP: TOpenDialog;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
    procedure rbEmailToClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    sAll            : String;
    FEmailList,
    FCustomerEmail  : String;
    FIDCustomer : Integer;
    FCustomerList : TClientDataSet;
    FProductsList : TClientDataSet;
    Customers: TObjectList;
    Products: TObjectList;

    procedure BuildEmailList; overload;
    procedure BuildEmailList(argCustomers: TObjectList); overload;
    procedure BuildBody; overload;
    procedure BuildBody(argProducts: TObjectList); overload;

    procedure RefreshSendList;
  public
    procedure Start(IDCustomer : Integer; Customer, Products : TClientDataSet); overload;
    procedure Start(argIdCustomer: Integer; argCustomerList, argProductList: TObjectList); overload;
  end;

implementation

uses uDM, uDMGlobal, ufrmStoreAccount;

{$R *.dfm}

procedure TFrmEmailBuilder.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmEmailBuilder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmEmailBuilder.btnSendClick(Sender: TObject);
begin
  inherited;

  with Emails do
  begin
    BlindCopyTo.Text   := mmReceivers.Text;
    FromName           := DM.fUser.UserName;
    Subject            := edtSubject.Text;
    Body               := memBody.Text;
    AttachedFiles.Text := edtAttached.Text;

    //Mostra o Email
    ShowDialog := True;
    SendMail;
  end;

end;

procedure TFrmEmailBuilder.Start(IDCustomer : Integer; Customer, Products : TClientDataSet);
begin
  FCustomerList := Customer;
  FProductsList := Products;

  FIDCustomer   := IDCustomer;

  if FCustomerList <> nil then
  begin
    BuildEmailList;
    if FIDCustomer = 0 then
      rbEmailTo.ItemIndex := 1;
  end;

  if FProductsList <> nil then
    BuildBody;

  ShowModal;
  
end;

procedure TFrmEmailBuilder.BuildEmailList;
begin
  with FCustomerList do
  begin
   First;
   FEmailList := '';
   rbEmailTo.Items.Strings[0] := 'No Customer';
   rbEmailTo.Items.Strings[1] := sAll;
   while not EOF do
   begin
     if FieldByName('email').AsString <> '' then
       FEmailList := FEmailList + FieldByName('email').AsString + '; ';

     if FIDCustomer = FieldByName('IDPessoa').AsInteger then
     begin
       FCustomerEmail := FieldByName('email').AsString;
       rbEmailTo.Items.Strings[0] := FieldByName('FullName').AsString;
     end;
     
     Next;
   end;
  end;

end;

procedure TFrmEmailBuilder.RefreshSendList;
begin
  case rbEmailTo.ItemIndex of
    0 : begin
        mmReceivers.Text := FCustomerEmail;
        end;
    1 : begin
        mmReceivers.Text := FEmailList;
        end;
  end;

end;

procedure TFrmEmailBuilder.rbEmailToClick(Sender: TObject);
begin
  inherited;
  RefreshSendList;
end;

procedure TFrmEmailBuilder.btnOpenFileClick(Sender: TObject);
begin
  inherited;
  if OP.Execute then
    edtAttached.Text := OP.FileName;
end;

procedure TFrmEmailBuilder.BuildBody;
begin
  with FProductsList do
  begin
    First;
    while not EOF do
    begin
      memBody.Lines.Add(FieldByName('Model').AsString + ' - ' + FieldByName('Description').AsString);
      memBody.Lines.Add('  ' + FormatFloat('#,##0.00', FieldByName('SalePrice').AsCurrency));
      memBody.Lines.Add('');
      Next;
    end;
  end;
end;

procedure TFrmEmailBuilder.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sAll := 'All';
    end;

    LANG_PORTUGUESE:
    begin
      sAll := 'Todos';
    end;

    LANG_SPANISH :
    begin
      sAll := 'Todos';
    end;
  end;

end;

procedure TFrmEmailBuilder.Start(argIdCustomer: Integer; argCustomerList,
  argProductList: TObjectList);
begin
  self.Customers := argCustomerList;
  self.Products  := argProductList;

  FIDCustomer   := argIdCustomer;

  if ( self.Customers.Count > 0 ) then begin
     BuildEmailList(argCustomerList);
     if ( FIDCustomer = 0 ) then begin
         rbEmailTo.ItemIndex := 1;
     end;

  end;

  if ( self.Products.Count > 0 ) then begin
     BuildBody(self.Products);
  end;

  ShowModal;
end;

procedure TFrmEmailBuilder.BuildBody(argProducts: TObjectList);
var
   i: Integer;
   holdDate,
   holdDueDate,
   holdStore,
   holdNumber,
   holdInvoiceNumber,
   holdTotal: String;

begin

  for i := 0 to argProducts.Count - 1 do begin
      holdDate := THold(argProducts[i]).HoldDate;
      holdDueDate := THold(argProducts[i]).HoldDueDate;
      holdStore := THold(argProducts[i]).HoldStore;
      holdNumber := THold(argProducts[i]).HoldNumber;
      holdInvoiceNumber := THold(argProducts[i]).HoldInvoiceNumber;
      holdTotal := THold(argProducts[i]).HoldTotal;

      memBody.lines.add('Transaction Date: ' + holdDate);
      memBody.lines.Add('Due Date: ' + holdDueDate);
      memBody.lines.Add('Store: ' + holdStore);
      memBody.Lines.Add('Hold: ' +  holdNumber);
      memBody.lines.Add('Invoice ' + holdInvoiceNumber);
      memBody.lines.add('Total Invoice: ' + holdTotal);
      memBody.lines.add(' ');
      memBody.lines.add(' ');
      
  end;

end;

procedure TFrmEmailBuilder.BuildEmailList(argCustomers: TObjectList);
var
   i: Integer;
begin
   fEmailList := '';
   rbEmailTo.items.Strings[0] := 'No Customer';
   rbEmailTo.Items.Strings[1] := sAll;

   for i := 0 to argCustomers.Count - 1 do begin
       FEmailList := FEmailList + TCustomerStoreAccount(argCustomers[i]).CustomerEmail;

       if ( IntToStr(FIDCustomer) = TCustomerStoreAccount(argCustomers[i]).CustomerId ) then begin
           rbEmailTo.Items.Strings[0] := TCustomerStoreAccount(argCustomers[i]).CustomerName;
           FCustomerEmail := TCustomerStoreAccount(argCustomers[i]).CustomerEmail;
       end;
   end;

   memBody.Lines.Add('Total ( All Holds ): ' + TCustomerStoreAccount(argCustomers[0]).CustomerTotalAmount);

end;

end.
