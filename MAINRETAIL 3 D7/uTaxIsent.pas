unit uTaxIsent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DateBox, DBCtrls, DB, DBTables, ADODB, siComp,
  siLangRT, PaiDeForms, dbClient;

type
  TFrmTaxIsent = class(TFrmParentForms)
    Panel1: TPanel;
    //Panel9: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    dsTaxIsent: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    EditPassport: TDBEdit;
    DBDateBox1: TDBDateBox;
    Label2: TLabel;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    Label8: TLabel;
    Bevel1: TBevel;
    pnlPreSale: TPanel;
    btCancel: TButton;
    btOK: TButton;
    btnCustomrer: TButton;
    pnCustomer: TPanel;
    lblCustomer: TLabel;
    customerName: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCustomrerClick(Sender: TObject);
  private
    { Private declarations }
    fIdCustomer: Integer;
    MyIDPreSale, MyIDMedia : Integer;
    MyIsentTax : Boolean;
    MyIsSpecialPrice : Boolean;
  public
    { Public declarations }
    function Start(IDPreSale      : Integer;
                   quPreSaleInfo  : TADOQuery;
                   IsSpecialPrice, IsentTax : Boolean) : Boolean;
  end;

implementation

uses uInvoice, uDM, uPassword, uAskManager, uMsgBox, uMsgConstant,
     uNumericFunctions, uDMGlobal, uSystemConst, ufrmSearchCustomer;

{$R *.DFM}

function TFrmTaxIsent.Start(IDPreSale      : Integer;
                            quPreSaleInfo  : TADOQuery;
                            IsSpecialPrice, IsentTax : Boolean) : Boolean;
begin
  MyIDPreSale      := IDPreSale;
  MyIsentTax       := IsentTax;
  MyIsSpecialPrice := IsSpecialPrice;
  MyIDMedia        := quPreSaleInfo.FieldByName('MediaID').AsInteger;

  dsTaxIsent.DataSet := quPreSaleInfo;

  if not MyIsentTax then
    begin
     btOKClick(nil);
     Result := True;
    end
  else
    begin
     Result := (ShowModal = mrOK);
    end;
end;

procedure TFrmTaxIsent.btOKClick(Sender: TObject);
var
  Msg : String;
begin
  // Se nao tiver special price so pode isentar taxa se tiver todos itens
  with TADOQuery(dsTaxIsent.DataSet) do
    if State in dsEditModes then
      UpdateRecord;

  if (not MyIsSpecialPrice) and MyIsentTax then
    begin
     with TADOQuery(dsTaxIsent.DataSet) do
       begin

         if (FieldByName('Passport').AsString = '') and
            (FieldByName('CompanyCGC').AsString = '')  then
           begin
             MsgBox(MSG_CRT_NO_PP_LICENC_EMPTY, vbOKOnly + vbCritical);
             Exit;
           end;

         // testa se vendedor ou manager podem dar isencao de taxa
         if MyStrToInt(DM.DescCodigo(['IDMedia'], [IntToStr(MyIDMedia)], 'Media', 'TaxMode')) = TAX_MODE_MANAGER then
           begin
             // Testa se tem senha de Manager
             if (not Password.HasFuncRight(13)) then
               begin
                  with TFrmAskManager.Create(Self) do
                       if not Start('To Isent Tax to this Media you must have the Manager Authorization.') then
                          Exit;
               end;
           end;
       end;
    end;

  if not MyIsentTax then
     Msg := MSG_QST_RESTORE_TAX
  else begin
     Msg := MSG_QST_CONFIRM_TAX_ISENTION;
     // MR-23
     // I pick InvoiceObs to save tax of exemption to customer
     dm.insertCustomerTaxExemption(dsTaxIsent.dataset.fieldByName('IdPresale').AsInteger, fIdCustomer);
  end;

  if (MsgBox(Msg, vbYesNo + vbQuestion) = vbYes) then
    begin

    DM.fPOS.ExemptTax(MyIDPreSale, MyIsentTax);

     if not MyIsentTax then
        DM.fPOS.RecalcTax(MyIDPreSale, Now);

    ModalResult := mrOK;
  end;

end;

procedure TFrmTaxIsent.FormShow(Sender: TObject);
begin
   inherited;
   EditPassport.SetFocus;
end;

procedure TFrmTaxIsent.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFrmTaxIsent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmTaxIsent.btnCustomrerClick(Sender: TObject);
var
  iIDCustomer: Integer;
  customer: TClientDataset;
begin
  inherited;

  // MR-23
  with TFrmSearchCustomer.Create(Self) do begin
    iIDCustomer := Start;
    fIdCustomer := iIdCustomer;
  end;

  try
    customer := dm.getCustomerTaxExemption(iIdCustomer);
    customerName.caption := customer.fieldByName('pessoa').AsString;
  finally
    freeAndNil(customer);
  end;

end;

end.
