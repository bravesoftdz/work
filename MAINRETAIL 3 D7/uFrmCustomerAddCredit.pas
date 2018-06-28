unit uFrmCustomerAddCredit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, DateBox;

type
  TFrmCustomerAddCredit = class(TFrmParentAll)
    btnSave: TButton;
    lblUser: TLabel;
    scUser: TSuperComboADO;
    lblStore: TLabel;
    scStore: TSuperComboADO;
    lblExpirationDate: TLabel;
    edtData: TDateBox;
    lblAmount: TLabel;
    edtAmount: TEdit;
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    fIDCustomer : Integer;
    function SaveCredit:Boolean;
  public
    { Public declarations }
    function Start(IDCustomer:Integer):Boolean;
  end;

implementation

uses uDM, uCharFunctions, uMsgBox, uMsgConstant, uNumericFunctions;

{$R *.dfm}

{ TFrmCustomerAddCredit }

function TFrmCustomerAddCredit.Start(IDCustomer:Integer): Boolean;
begin
  scStore.LookUpValue := IntToStr(DM.fStore.ID);
  scUser.LookUpValue  := IntToStr(DM.fUser.ID);
  fIDCustomer         := IDCustomer;

  ShowModal;
  Result := (ModalResult=mrOK);
end;

procedure TFrmCustomerAddCredit.edtAmountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

 Key := ValidateCurrency(Key);

end;

function TFrmCustomerAddCredit.SaveCredit:Boolean;
  function ValidateFields : Boolean;
  begin
  Result := True;
  if (MyStrToCurrency(edtAmount.Text) <= 0) then
     begin
     MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
     Result := False;
     end;
  end;
  var
  ID : Integer;
begin
  Result := False;

  if not ValidateFields then
     Exit;

  DM.fPOS.AddCustomerCredit(fIDCustomer,
                            DM.fUser.ID,
                            DM.fStore.ID,
                            0,
                            Now,
                            edtData.Date,
                            MyStrToCurrency(edtAmount.Text),
                            ID);

  Result := True;                          
end;

procedure TFrmCustomerAddCredit.btnSaveClick(Sender: TObject);
begin
  inherited;

  if not SaveCredit then
     ModalResult := mrNone;

end;

procedure TFrmCustomerAddCredit.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
