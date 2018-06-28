(*
-----------------------------------------------------------------------------------------------------
Version : (280 - 282)
Date    : 12.22.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Losting connection after to close Adjust screen.
Solution: Refresh removed.
Version : (288 - 283)
-----------------------------------------------------------------------------------------------------

Version : (28? - 27?)
Date    : 12.22.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : only store type 'SERVER' can be insert or update reasons.
Solution: now, there is a test to verify if store is a 'SERVER' type.
Version : (288 - 278)
-----------------------------------------------------------------------------------------------------
*)


unit uModelAdjustQty;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Db, DBTables,
  uFchModel, Buttons, ADODB, SuperComboADO, siComp, siLangRT;

type
  TModelAdjustQty = class(TFrmParentAll)
    Label2: TLabel;
    btCancel: TButton;
    EditActual: TEdit;
    Label1: TLabel;
    EditDifference: TEdit;
    EditAdjusted: TEdit;
    Label3: TLabel;
    Label32: TLabel;
    Shape2: TShape;
    Label27: TLabel;
    spModelAdjust: TADOStoredProc;
    Label4: TLabel;
    cmbStore: TSuperComboADO;
    EditQty: TEdit;
    Label5: TLabel;
    EditOrder: TEdit;
    EditRepair: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    pnlTitle3: TPanel;
    Label8: TLabel;
    MemReason: TMemo;
    lbReason: TLabel;
    scInventoryReason: TSuperComboADO;
    Label11: TLabel;
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditDifferenceChange(Sender: TObject);
    procedure EditAdjustedChange(Sender: TObject);
    procedure EditDifferenceKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    MyIDModel, MyIDStore : integer;
    MyQty, MyOrder, MyRepair, MyPurchase : Double;
    IsChangeDif, IsChangeAdj : Boolean;
  public
    { Public declarations }
    function Start(IDModel, IDStore : Integer; Qty, Repair, Order, Purchase : Double) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uCharFunctions,
     uDMGlobal, uSystemConst;

{$R *.DFM}

function TModelAdjustQty.Start(IDModel, IDStore : Integer; Qty, Repair, Order,
                Purchase : Double) : Boolean;
var
  module: TADOQuery;
  isServer: boolean;
  sql: String;
begin
  MyIDModel  := IDModel;
  MyIDStore  := IDStore;
  MyQty      := Qty;
  MyOrder    := Order;
  MyRepair   := Repair;
  MyPurchase := Purchase;
  scInventoryReason.ShowBtnUpdate := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);
  scInventoryReason.ShowBtnAddNew := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);

  try
     module := TADOQuery.Create(nil);
     module.Connection := dm.ADODBConnect;
     sql := 'select VersionType from SYS_MODULE';
     module.SQL.Text := sql;
     module.Open;
     isServer := ( module.FieldByName('VersionType').Value <> quotedStr('CLIENT') );
  finally
     freeAndNil(module);
  end;

  //amfsouza 12.22.2010 - only store type 'SERVER' can be insert or update reasons.
  scInventoryReason.ShowBtnAddNew := ( scInventoryReason.ShowBtnAddNew and isServer );
  scInventoryReason.ShowBtnUpdate := scInventoryReason.ShowBtnAddNew;

  Result     := (ShowModal = mrOK);
end;

procedure TModelAdjustQty.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TModelAdjustQty.btCloseClick(Sender: TObject);
begin
  inherited;
  if cmbStore.LookUpValue = '' then
    begin
     MsgBox(MSG_CRT_NO_STORE_SELECTED, vbOKOnly + vbCritical);
     cmbStore.SetFocus;
     Exit;
    end;

  if EditOrder.Text = '' then
    begin
     MsgBox(MSG_CRT_NO_QTY_ORDER_EMPTY, vbOKOnly + vbInformation);
     EditOrder.SetFocus;
     Exit;
    end;

  if EditRepair.Text = '' then
    begin
     MsgBox(MSG_CRT_NO_QTY_REPAIR_EMPTY, vbOKOnly + vbInformation);
     EditRepair.SetFocus;
     Exit;
    end;

  if EditQty.Text = '' then
    begin
     MsgBox(MSG_CRT_NO_QTY_PERPUR_EMPTY,
                 vbOKOnly + vbInformation);
     EditQty.SetFocus;
     Exit;
    end;

  if EditDifference.Text = '' then
    begin
     MsgBox(MSG_CRT_NO_DIFFERRENCE_EMPTY, vbOKOnly + vbInformation);
     EditDifference.SetFocus;
     Exit;
    end;

  if (scInventoryReason.LookUpValue = '') then
    begin
     MsgBox(MSG_CRT_NO_EMPTY_REASON, vbOKOnly + vbCritical);
     scInventoryReason.SetFocus;
     Exit;
    end;

  if MsgBox(MSG_QST_CONFIRM_ADJUST_INV, vbYesNo + vbQuestion) = vbYes then
   begin
     with spModelAdjust do
       begin
         Parameters.ParambyName('@QtyOnOrder').Value        := MyStrToFloat(EditOrder.Text);
         Parameters.ParambyName('@QtyOnRepair').Value       := MyStrToFloat(EditRepair.Text);
         Parameters.ParambyName('@QtyOnPrePurchase').Value  := MyStrToFloat(EditQty.Text);
         Parameters.ParambyName('@IDModel').Value           := MyIDModel;
         Parameters.ParambyName('@IDStore').Value           := MyStrToInt(cmbStore.LookUpValue);
         Parameters.ParambyName('@Difference').Value        := MyStrToFloat(EditDifference.Text);
         Parameters.ParambyName('@IDUser').Value            := DM.fUser.ID;
         Parameters.ParambyName('@Date').Value              := Now;
         Parameters.ParamByName('@Notes').Value             := MemReason.Text;
         Parameters.ParamByName('@IDMovReason').Value       := MyStrToInt(scInventoryReason.LookUpValue);
         ExecProc;
       end;

     ModalResult := mrOK;
   end;

end;

procedure TModelAdjustQty.FormShow(Sender: TObject);
begin
  inherited;
  if MyIDStore <> 0 then
    cmbStore.LookUpValue := IntToStr(MyIDStore);

  IsChangeAdj         := False;
  IsChangeDif         := False;
  EditActual.Text     := FormatFloat('0.#####',MyQty);
  EditDifference.Text := '0';
  EditAdjusted.Text   := FormatFloat('0.#####',MyQty);
  IsChangeAdj         := True;
  IsChangeDif         := True;
  EditDifference.SetFocus;

  EditRepair.Text := FormatFloat('0.#####', MyRepair);
  EditOrder.Text  := FormatFloat('0.#####', MyOrder);
  EditQty.Text    := FormatFloat('0.#####', MyPurchase);
end;

procedure TModelAdjustQty.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 //amfsouza 02.22.2011 why this ? Action := caFree;
end;




procedure TModelAdjustQty.EditDifferenceChange(Sender: TObject);
begin
  inherited;
  if IsChangeDif then
    begin
     IsChangeAdj := False;
     EditAdjusted.Text := FormatFloat('0.#####', MyStrToFloat(EditActual.Text) + MyStrToFloat(EditDifference.Text));
     IsChangeAdj := True;
    end;
end;

procedure TModelAdjustQty.EditAdjustedChange(Sender: TObject);
begin
  inherited;
  if IsChangeAdj then
    begin
     IsChangeDif := False;
     EditDifference.Text := FormatFloat('0.#####',MyStrToFloat(EditAdjusted.Text) - MyStrToFloat(EditActual.Text));
     IsChangeDif := True;
    end;
end;


procedure TModelAdjustQty.EditDifferenceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Key := ValidateCurrency(Key);

end;

end.
