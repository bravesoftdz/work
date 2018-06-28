unit uInvoiceChangeSalesPerson;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Db, DBTables,
  SuperComboADO, Buttons, ADODB;

type
  TInvoiceChangeSalesPerson = class(TFrmParentAll)
    Label1: TLabel;
    Label2: TLabel;
    btCancel: TButton;
    spChangeSalesPerson: TADOStoredProc;
    cmbOldPerson: TSuperComboADO;
    cmbNewPerson: TSuperComboADO;
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    MyIsInvoice : Boolean;
    MyIDInventoryMov, MyIDOldSalesPerson : integer;
  public
    { Public declarations }
    function Start(IsInvoice : Boolean;IDInventoryMov, IDOldSalesPerson : integer) : Boolean;
  end;

implementation

uses uDM;

{$R *.DFM}

function TInvoiceChangeSalesPerson.Start(IsInvoice : Boolean;IDInventoryMov, IDOldSalesPerson : integer) : Boolean;
begin
   MyIsInvoice      := IsInvoice;
   MyIDInventoryMov := IDInventoryMov;
   MyIDOldSalesPerson := IDOldSalesPerson;

   Result      := (ShowModal = mrOK);
end;

procedure TInvoiceChangeSalesPerson.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TInvoiceChangeSalesPerson.btCloseClick(Sender: TObject);
begin
  inherited;
  if cmbNewPerson.LookUpValue = '' then
    begin
     MessageDlg('You must choose a Sales Person', mtInformation, [mbok], 0);
     Exit;
    end;

  if cmbNewPerson.LookUpValue = cmbOldPerson.LookUpValue then
    begin
     MessageDlg('New Sales Person can not be the same as the old one', mtInformation, [mbok], 0);
     Exit;
    end;

  if MessageDlg('Confirm changing Sales Person ?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     with spChangeSalesPerson do
       begin
         ParamByName('@IsInvoice').AsBoolean      := MyIsInvoice;
         ParamByName('@IDInventoryMov').AsInteger := MyIDInventoryMov;
         ParamByName('@IDNewComission').AsInteger := StrToInt(cmbNewPerson.LookUpValue);
         ExecProc;
       end;

     ModalResult := mrOK;
   end;

end;

procedure TInvoiceChangeSalesPerson.FormShow(Sender: TObject);
begin
  inherited;
  cmbOldPerson.LookUpValue := IntToStr(MyIDOldSalesPerson);
  cmbNewPerson.LookUpValue := '';
  cmbNewPerson.SetFocus;
end;

procedure TInvoiceChangeSalesPerson.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree; 
end;

end.
