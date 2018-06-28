unit uFrmAddGift;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, LblEffct, ExtCtrls, StdCtrls, Db, DBTables, 
  DateBox, Mask, Buttons, ADODB, SuperComboADO, siComp, siLangRT;

type
  TFrmAddGift = class(TFrmParent)
    scModel: TSuperComboADO;
    scUser: TSuperComboADO;
    dbGift: TDateBox;
    edQty: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    spAddGift: TADOStoredProc;
    scStore: TSuperComboADO;
    Label5: TLabel;
    quInventory: TADOQuery;
    Label21: TLabel;
    Label6: TLabel;
    btOk: TButton;
    spHelp: TSpeedButton;
    quInventoryTotQtyOnHand: TFloatField;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scModelExit(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    QtyOnHand : Double;
  public
    { Public declarations }
    MyIDTouristGroup: Integer;

    function Start(IDTouristGroup: integer): Boolean;
  end;

implementation

uses uDM, uMsgBox, uAskManager, uNumericFunctions, uMsgConstant,
     uDMGlobal;

{$R *.DFM}

function TFrmAddGift.Start(IDTouristGroup: integer): Boolean;
begin
   MyIDTouristGroup := IDTouristGroup;
   Result := (ShowModal = mrOk);
end;


procedure TFrmAddGift.btOkClick(Sender: TObject);
begin
  inherited;
  if scModel.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_MODEL_SELECTED, vbOkOnly + vbCritical);
    scModel.SetFocus;
    Exit;
  end;

  if MyStrToDouble(edQty.text) = 0 then
  begin
    MsgBox(MSG_CRT_QTY_BIGGER_0, vbOkOnly + vbCritical);
    edQty.SetFocus;
    Exit;
  end;

  if QtyOnHand <= 0 then
  begin
    MsgBox(MSG_CRT_INVENTORY_WILL_BE_NEG, vbOkOnly + vbCritical);
    edQty.SetFocus;
    Exit;
  end;

  with spAddGift do
  begin
    Parameters.ParambyName('@IDTouristGroup').Value := MyIDTouristGroup;
    Parameters.ParambyName('@IDModel').Value        := MyStrToInt(scModel.LookUpValue);
    Parameters.ParambyName('@IDUser').Value         := MyStrToInt(scUser.LookUpValue);
    Parameters.ParambyName('@IDStore').Value        := MyStrToInt(scStore.LookUpValue);
    Parameters.ParambyName('@Qty').Value            := MyStrToDouble(edQty.Text);
    Parameters.ParambyName('@DataGift').Value       := FormatDateTime('mm/dd/yyyy', dbGift.Date);
    ExecProc;
  end;

  MsgBox(MSG_INF_GIFT_REGIST, vbOkOnly + vbInformation);

  ModalResult := mrOk;
end;

procedure TFrmAddGift.FormShow(Sender: TObject);
begin
  inherited;
  edQty.text := '0';
  scModel.LookUpValue := ''; // **
  scUser.LookUpValue  := IntToStr(DM.fUser.ID);
  scStore.LookUpValue := IntToStr(DM.fStore.ID);
  dbGift.Date := now;

  if DM.fUser.IsManager then
  begin
    scUser.Enabled := True;
    scUser.Color := clWindow;

    scStore.Enabled := True;
    scStore.Color := clWindow;
  end
  else
  begin
    scUser.Enabled := False;
    scUser.ParentColor := True;

    scStore.Enabled := False;
    scStore.ParentColor := True;
  end;

  SelectFirst // **
end;


procedure TFrmAddGift.scModelExit(Sender: TObject);
begin
  // ** Crítica para não permitir dar gift com qtyOnHand <= 0, salvo por autorização do manager
  if scModel.LookUpValue <> '' then
  begin
    quInventory.close;
    quInventory.Parameters.ParambyName('ModelGift').Value := StrToInt (scModel.LookUpValue);
    quInventory.open;

    QtyOnHand := quInventoryTotQtyOnHand.Value;
    if QtyOnHand <= 0 then
    begin
      if MsgBox(MSG_CRT_INVENTORY_WILL_BE_NEG, vbYesNo + vbQuestion) = vbNo then
        Exit;

//**            if not Password.HasFuncRight(8) then
//**               begin
      with TFrmAskManager.Create(Self) do
        if not Start('The Inventory is about to become negative. In order to complete this operation you must have the Manager Authorization') then
        begin
          scModel.LookUpValue := '';
          scModel.SetFocus;
        end
        else
          QtyOnHand := 1; // ** Só para deixar dar gift negativo, pois o
                                     // ** manager permitiu
        end;
//**          end;

    quInventory.close;
  end;
end;

procedure TFrmAddGift.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(308);
end;

procedure TFrmAddGift.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
