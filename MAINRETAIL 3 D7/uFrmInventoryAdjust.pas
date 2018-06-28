(*
-----------------------------------------------------------------------------------------------------
Version : (288 - 279)
Date    : 01.17.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : ( Changes ) buttons add and remove are missing
Solution: redraw screen.
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------

Version : (287 - 275)
Date    : 11.24.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : ( Changes ) - To override description to Notes.
Solution: override to Notes.
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmInventoryAdjust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, DateBox, DB, ADODB, DBClient, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, mrBarCodeEdit;

const
  INV_TYPE_NONE       = 0;
  INV_TYPE_STORE_LOST = 1;
  INV_TYPE_STORE_USE  = 2;
  INV_TYPE_ADJUST_INV = 3;

type
  TFrmInventoryAdjust = class(TFrmParentAll)
    btnSave: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    scStore: TSuperComboADO;
    scUser: TSuperComboADO;
    btnSearchDesc: TBitBtn;
    dtMov: TDateBox;
    edtQty: TEdit;
    memOBS: TMemo;
    rgAdjustType: TRadioGroup;
    spAdjustInventory: TADOStoredProc;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    btnAdd: TBitBtn;
    dsItems: TDataSource;
    cdsItems: TClientDataSet;
    cdsItemsIDUser: TIntegerField;
    cdsItemsUser: TStringField;
    cdsItemsIDStore: TIntegerField;
    cdsItemsStore: TStringField;
    cdsItemsIDMovType: TIntegerField;
    cdsItemsIDModel: TIntegerField;
    cdsItemsModel: TStringField;
    cdsItemsMovDate: TDateTimeField;
    cdsItemsQty: TFloatField;
    cdsItemsOBS: TStringField;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    cdsItemsID: TIntegerField;
    grdItemsDBModel: TcxGridDBColumn;
    grdItemsDBMovDate: TcxGridDBColumn;
    grdItemsDBQty: TcxGridDBColumn;
    grdItemsDBOBS: TcxGridDBColumn;
    cdsItemsMovType: TStringField;
    grdItemsDBMovType: TcxGridDBColumn;
    quInventory: TADOQuery;
    quInventoryDataContagem: TDateTimeField;
    quInventoryCategory: TStringField;
    quInventoryQtyOnPreSale: TFloatField;
    quInventoryQtyOnHand: TFloatField;
    quInventoryQtyOnOrder: TFloatField;
    quInventoryQtyOnRepair: TFloatField;
    cdsItemsQtyOnHand: TFloatField;
    cdsItemsQtyReplace: TFloatField;
    Label11: TLabel;
    edtBarCode: TmrBarCodeEdit;
    Label10: TLabel;
    Label14: TLabel;
    edtQtyOnHand: TEdit;
    Label13: TLabel;
    scReason: TSuperComboADO;
    cdsItemsIDMovReason: TIntegerField;
    cdsItemsReason: TStringField;
    grdItemsDBReason: TcxGridDBColumn;
    scModel: TSuperComboADO;
    Label15: TLabel;
    rgMoveType: TRadioGroup;
    btnDel: TBitBtn;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure scModelSelectItem(Sender: TObject);
    procedure edtBarCodeAfterSearchBarcode(Sender: TObject);
    procedure quInventoryAfterOpen(DataSet: TDataSet);
    procedure edtBarCodeEnter(Sender: TObject);
    procedure edtBarCodeExit(Sender: TObject);
    procedure rgMoveTypeClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    FInc : Integer;
    FAdjustType : Integer;
    function ValidateItem : Boolean;
    procedure InsertItem;
    procedure SaveItems;
    procedure RefreshInventory;
    procedure OpenInventory;
    procedure CloseInventory;
  public
    function Start(AdjustType:Integer) : Boolean;
  end;

implementation

uses uMsgBox, uDM, uMsgConstant, uDMGlobal, uFrmBarcodeSearch, uCharFunctions,
  Math, uSystemConst, uNumericFunctions;

{$R *.dfm}

{ TFrmInventoryAdjust }

function TFrmInventoryAdjust.Start(AdjustType: Integer): Boolean;
begin
  FAdjustType         := AdjustType;
  scUser.LookUpValue  := IntToStr(DM.fUser.ID);
  scStore.LookUpValue := IntToStr(DM.fStore.ID);
  dtMov.Date          := Now;
  edtQty.Text         := '1';
  FInc                := 1;
  scReason.ShowBtnUpdate := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);
  scReason.ShowBtnAddNew := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);

  memOBS.Clear;
  cdsItems.Close;
  cdsItems.CreateDataSet;
  cdsItems.Open;
  Result := (ShowModal = mrOK);
end;

procedure TFrmInventoryAdjust.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInventoryAdjust.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseInventory;
  cdsItems.Close;
  Action := caFree;
end;

procedure TFrmInventoryAdjust.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with TFrmBarcodeSearch.Create(Self) do
    begin
      R := Start;
      if R <> -1 then
      begin
          scModel.LookUpValue := IntToStr(R);
          scModelSelectItem(Self);
      end;
    end;

end;

procedure TFrmInventoryAdjust.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);
end;

procedure TFrmInventoryAdjust.btnAddClick(Sender: TObject);
begin
  inherited;
  if ValidateItem then
    InsertItem;
end;

procedure TFrmInventoryAdjust.InsertItem;
var
  IDMovType : Integer;
  Qty, OnHand, QtyReplace : Double;
begin

  Qty        := StrToFloatDef(edtQty.Text,1);
  OnHand     := 0;
  QtyReplace := 0;

 case rgMoveType.ItemIndex of
   0 : IDMovType := 26; //Usado
   1 : IDMovType := 6; //Roubado
   2 : begin
         case rgAdjustType.ItemIndex of
         0 : begin
             IDMovType := INV_MOVTYPE_PHYSICALINCREASE;
             end;
         1 : begin
             IDMovType := INV_MOVTYPE_PHYSICALDECREASE;
             end;
         2 : begin
             OnHand := quInventoryQtyOnHand.AsFloat;
             if (Qty - OnHand) > 0 then
                IDMovType := INV_MOVTYPE_PHYSICALINCREASE
             else
                IDMovType := INV_MOVTYPE_PHYSICALDECREASE;
             QtyReplace := Abs(Qty - OnHand);
             end;
         end;
       end;
   else IDMovType := 26;
 end;

  with cdsItems do
   if Active then
   begin
     Append;
     FieldByName('ID').AsInteger          := FInc;
     FieldByName('IDUser').AsInteger      := DM.fUser.ID;
     FieldByName('IDStore').AsInteger     := DM.fStore.ID;
     FieldByName('IDMovType').AsInteger   := IDMovType;
     FieldByName('IDModel').AsInteger     := StrToInt(scModel.LookUpValue);
     FieldByName('User').AsString         := scUser.Text;
     FieldByName('Store').AsString        := scStore.Text;
     FieldByName('MovType').AsString      := rgMoveType.Items.Strings[rgMoveType.ItemIndex];
     FieldByName('Model').AsString        := scModel.Text;
     FieldByName('MovDate').AsDateTime    := dtMov.Date;
     FieldByName('Qty').AsFloat           := Qty;
     FieldByName('QtyReplace').AsFloat    := QtyReplace;
     FieldByName('QtyOnHand').AsFloat     := OnHand;
     FieldByName('Obs').AsString          := memOBS.Text;
     FieldByName('IDMovReason').AsInteger := StrToInt(scReason.LookUpValue);
     FieldByName('Reason').AsString       := scReason.Text;
     Post;
   end;

  Inc(FInc);

  memOBS.Clear;
  edtQtyOnHand.Clear;
  edtBarCode.Clear;

  scModel.Text := '';
  scModel.LookUpValue := '';
  edtQty.Text := '1';

  dtMov.Date := Now;
  edtBarCode.SetFocus;

end;

function TFrmInventoryAdjust.ValidateItem: Boolean;
begin

  Result := False;

  if (scModel.LookUpValue = '') then
  begin
    scModel.SetFocus;
    MsgBox(MSG_CRT_NO_MODEL, vbOKOnly + vbCritical);
    Exit;
  end;

  if Trim(dtMov.Text) = '' then
  begin
    dtMov.SetFocus;
    MsgBox(MSG_CRT_NO_DATE, vbOKOnly + vbCritical);
    Exit;
  end;

  if Trim(edtQty.Text) = '' then
  begin
    edtQty.SetFocus;
    MsgBox(MSG_CRT_QTY_POSITIVE, vbOKOnly + vbCritical);
    Exit;
  end;

  if (rgMoveType.ItemIndex = -1) then
  begin
    MsgBox(MSG_CRT_NO_EMPTY_REASON, vbOKOnly + vbCritical);
    Exit;
  end;

  if (rgMoveType.ItemIndex = 2) then
  begin
    if (cdsItems.Active) and (cdsItems.Locate('IDModel', scModel.LookUpValue, [])) then
    begin
      memOBS.SetFocus;
      MsgBox(MSG_CRT_NO_DUPLICATE_MODEL, vbOKOnly + vbCritical);
      Exit;
    end;
  end;

 if Trim(scReason.Text) = '' then
  begin
    scReason.SetFocus;
    MsgBox(MSG_CRT_NO_EMPTY_REASON, vbOKOnly + vbCritical);
    Exit;
  end;

  Result := True;

end;

procedure TFrmInventoryAdjust.edtQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateDouble(Key);
end;

procedure TFrmInventoryAdjust.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not cdsItems.IsEmpty then
  begin
   SaveItems;
   Close;
  end;
end;

procedure TFrmInventoryAdjust.SaveItems;
var
  Qty : Double;
begin
  with cdsItems do
  try
    DisableControls;
    First;
    while not EOF do
    begin
      if FieldByName('QtyReplace').AsFloat = 0 then
        Qty := FieldByName('Qty').AsFloat
      else
        Qty := FieldByName('QtyReplace').AsFloat;

      spAdjustInventory.Parameters.ParamByName('@IDMovType').Value   := FieldByName('IDMovType').AsInteger;
      spAdjustInventory.Parameters.ParamByName('@IDModel').Value     := FieldByName('IDModel').AsInteger;
      spAdjustInventory.Parameters.ParamByName('@IDStore').Value     := FieldByName('IDStore').AsInteger;
      spAdjustInventory.Parameters.ParamByName('@Qty').Value         := Qty;
      spAdjustInventory.Parameters.ParamByName('@IDUser').Value      := FieldByName('IDUser').AsInteger;
      spAdjustInventory.Parameters.ParamByName('@Date').Value        := FieldByName('MovDate').AsDateTime;
      spAdjustInventory.Parameters.ParamByName('@Notes').Value       := FieldByName('Obs').AsString;
      spAdjustInventory.Parameters.ParamByName('@IDMovReason').Value := FieldByName('IDMovReason').AsInteger;
      spAdjustInventory.ExecProc;
      Next;
    end;
  finally
   EnableControls;
   end;

end;

procedure TFrmInventoryAdjust.scModelSelectItem(Sender: TObject);
begin
  inherited;
  //if rgMoveType.ItemIndex = 2 then
    RefreshInventory;
end;

procedure TFrmInventoryAdjust.CloseInventory;
begin
  with quInventory do
    if Active then
      Close;
end;

procedure TFrmInventoryAdjust.OpenInventory;
begin
  with quInventory do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := StrToInt(scModel.LookUpValue);
      Parameters.ParamByName('IDStore').Value := StrToInt(scStore.LookUpValue);
      Open;
    end;
end;

procedure TFrmInventoryAdjust.RefreshInventory;
begin
  CloseInventory;
  OpenInventory;
end;

procedure TFrmInventoryAdjust.edtBarCodeAfterSearchBarcode(
  Sender: TObject);
var
  iIDModel : integer;
begin
  inherited;
  with edtBarcode do
  begin
    if SearchResult then
      begin
        iIDModel := GetFieldValue('IDModel');
        scModel.LookUpValue := IntToStr(iIDModel);
        scModelSelectItem(Self);
        edtQty.SetFocus; 
      end
  end;
end;

procedure TFrmInventoryAdjust.quInventoryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtQtyOnHand.Text := quInventoryQtyOnHand.AsString;
end;

procedure TFrmInventoryAdjust.edtBarCodeEnter(Sender: TObject);
begin
  inherited;
  btnAdd.Default := False;
end;

procedure TFrmInventoryAdjust.edtBarCodeExit(Sender: TObject);
begin
  inherited;
  btnAdd.Default := True;
end;

procedure TFrmInventoryAdjust.rgMoveTypeClick(Sender: TObject);
begin
  inherited;

  rgAdjustType.Visible := (rgMoveType.ItemIndex = 2);
  if rgAdjustType.Visible then
    begin
      if scModel.LookUpValue <> '' then
        RefreshInventory;
    end
  else
    CloseInventory;

end;

procedure TFrmInventoryAdjust.btnDelClick(Sender: TObject);
begin
  inherited;
  with cdsItems do
    if Active and (not IsEmpty) then
    begin
      Edit;
      Delete;
    end;

end;

end.
