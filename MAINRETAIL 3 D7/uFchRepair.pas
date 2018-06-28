unit uFchRepair;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, DateBox, MemoStr,
  Buttons, ComCtrls, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, siComp, siLangRT, mrBarCodeEdit;

type
  TFchRepair = class(TbrwFrmParent)
    Label2: TLabel;
    PPageControl: TPageControl;
    tsReceiveCustomer: TTabSheet;
    tsSentVendor: TTabSheet;
    tsReturnVendor: TTabSheet;
    tsBackCustomer: TTabSheet;
    Label8: TLabel;
    Label18: TLabel;
    scUser: TDBSuperComboADO;
    Label12: TLabel;
    dbCustomer: TDBSuperComboADO;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    Label21: TLabel;
    DBEdit1: TDBEdit;
    Label20: TLabel;
    Label10: TLabel;
    cmbVendor: TDBSuperComboADO;
    Label13: TLabel;
    rdgTipoRepairInv: TDBRadioGroup;
    Label22: TLabel;
    DBDateBox1: TDBDateBox;
    Label23: TLabel;
    Label24: TLabel;
    dbedtRA: TDBEdit;
    Label25: TLabel;
    DBEdit4: TDBEdit;
    Label26: TLabel;
    cbxUserBack: TDBSuperComboADO;
    Label27: TLabel;
    dbdtONBack: TDBDateBox;
    Label28: TLabel;
    Label3: TLabel;
    DBSuperCombo2: TDBSuperComboADO;
    Label29: TLabel;
    DBDateBox3: TDBDateBox;
    Label30: TLabel;
    Label4: TLabel;
    cmbSentBy: TDBSuperComboADO;
    Label9: TLabel;
    dbdtOn: TDBDateBox;
    Label11: TLabel;
    quFormIDRepair: TIntegerField;
    quFormIDModel: TIntegerField;
    quFormIDCliente: TIntegerField;
    quFormFase: TStringField;
    quFormIDFornecedor: TIntegerField;
    quFormIDUserReceive: TIntegerField;
    quFormReceiveDate: TDateTimeField;
    quFormSentDate: TDateTimeField;
    quFormOBSReceive: TStringField;
    quFormTipoRepair: TIntegerField;
    quFormIDUserSent: TIntegerField;
    quFormUPS: TStringField;
    quFormRA: TStringField;
    quFormDateLastCost: TDateTimeField;
    quFormSerialNumber: TStringField;
    quFormLastCost: TFloatField;
    quFormDesativado: TIntegerField;
    quFormIDUserReturn: TIntegerField;
    quFormReturnDate: TDateTimeField;
    quFormReturnStatus: TStringField;
    quFormOBSReturn: TStringField;
    quFormIDUserBack: TIntegerField;
    quFormBackDate: TDateTimeField;
    lblSend: TLabel;
    lblReturn: TLabel;
    quFormIDInvMovSend: TIntegerField;
    quFormIDInvMovReturn: TIntegerField;
    quFormTipo: TIntegerField;
    quFormIDStore: TIntegerField;
    Label16: TLabel;
    Label31: TLabel;
    btPrint: TSpeedButton;
    btSentToCustomer: TSpeedButton;
    Label33: TLabel;
    quFormOBSBack: TStringField;
    DbMemoStr3: TDbMemoStr;
    DbMemoStr4: TDbMemoStr;
    DbMemoStr5: TDbMemoStr;
    quFormDefect: TStringField;
    Label34: TLabel;
    Panel5: TPanel;
    Label14: TLabel;
    Label1: TLabel;
    Label19: TLabel;
    lbPutSerial: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label32: TLabel;
    Label17: TLabel;
    cmbModel: TDBSuperComboADO;
    dbSerialNumber: TDBEdit;
    dbQty: TDBEdit;
    DbMemoStr2: TDbMemoStr;
    spRepairDO: TADOStoredProc;
    sbSendToVendor: TSpeedButton;
    lbStatus: TLabel;
    btnBackVendor: TSpeedButton;
    btnSendToCustomer: TSpeedButton;
    btnInStore: TSpeedButton;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    quFormQty: TFloatField;
    lbBarcode: TLabel;
    edtBarcode: TmrBarCodeEdit;
    quFormIDDefectType: TIntegerField;
    lbDefect: TLabel;
    scDefectType: TDBSuperComboADO;
    rdgTipoRepairCli: TDBRadioGroup;
    quFormIDLote: TIntegerField;
    lbLot: TLabel;
    scLot: TDBSuperComboADO;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure btSentToCustomerClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure sbSendToVendorClick(Sender: TObject);
    procedure btnBackVendorClick(Sender: TObject);
    procedure btnSendToCustomerClick(Sender: TObject);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure quFormAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure quFormTipoRepairChange(Sender: TField);
    procedure btCloseClick(Sender: TObject);
    procedure quFormQtyChange(Sender: TField);
    procedure btNextRecClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btLastRecClick(Sender: TObject);
  private
    ModelAux : Integer;
    TipoAux  : Byte;
    bUseLot  : Boolean;
    bControlLot : Boolean;
    FFinalizeLot : Boolean;
    FSendLot     : Boolean;
    bValidateQty : Boolean;

    function OnAfterSaveChange(var iError:Integer):Boolean; override;
    procedure SetVendor(IDModel: Integer);

    procedure RefreshTab;

    procedure SetValidation(bReset:Boolean);

    procedure SetStatus(iStatus:Integer);
    procedure ValidRecCustomer;
    procedure ValidSentVendor;
    procedure ValidBackVendor;
    procedure ValidBackCustomer;
    procedure VerifyQty;

    procedure DisplayLot;
    procedure ReadLotInfo;
    procedure EnableLotControls;

    procedure SendLotToVendor;
    procedure ReturnLotFromVendor;

    function ValidateBeforeSentToVendor : boolean;
    function ValidateQty: Boolean;
    procedure EnableSelectModel();
  protected
    function OnValidadeField: boolean; override;
    procedure OnAfterStart; override;
    procedure OnAfterUpdateNavegator; override;
  public
    Tipo: Integer; // Qual o tipo do repair 1- cliente 2- inv
  end;

implementation

uses uDM, uPrintRepairCliReceipt, uSystemTypes, uMsgConstant,
     uPrintRepairStoreReceipt, uBrwRepairInv , uMsgBox, uDMGlobal,
     PaiDeTodos, uSystemConst, LookUpADOQuery, uPassword;

{$R *.DFM}

procedure TFchRepair.SetStatus(iStatus:Integer);
begin
  if not (quForm.State in dsEditModes) then
    quForm.Edit;

  case iStatus of
    1:
    begin
      if quFormIDUserSent.AsString = '' then
        quFormIDUserSent.AsInteger := DM.fUser.ID;

      if quFormSentDate.AsString = '' then
        quFormSentDate.AsDateTime := Now();

      quFormFase.AsString := 'Send to Vendor';
    end;

    2:
    begin
      if quFormIDUserReturn.AsString = '' then
        quFormIDUserReturn.AsInteger := DM.fUser.ID;

      if quFormReturnDate.AsString = '' then
        quFormReturnDate.AsDateTime := Now();

      quFormFase.AsString := 'Back from Vendor';
    end;

    3:
    begin
      if quFormIDUserBack.AsString = '' then
        quFormIDUserBack.AsInteger := DM.fUser.ID;

      if quFormBackDate.AsString = '' then
        quFormBackDate.AsDateTime := Now();

      quFormFase.AsString := 'Sent to Customer';
    end;
  end;
end;

procedure TFchRepair.ValidBackCustomer;
begin
   quFormIDUserBack.Required := True;
   quFormBackDate.Required   := True;
end;

procedure TFchRepair.ValidBackVendor;
begin
   quFormIDUserReturn.Required := True;
   quFormReturnDate.Required   := True;
   quFormTipoRepair.Required   := True;
end;

procedure TFchRepair.ValidSentVendor;
begin
  quFormIDFornecedor.Required := True;
  quFormIDUserSent.Required   := True;
  quFormSentDate.Required     := True;
  quFormRA.Required           := True;
end;

procedure TFchRepair.ValidRecCustomer;
begin
  quFormIDCliente.Required     := True;
  quFormReceiveDate.Required   := True;
  quFormIDUserReceive.Required := True;
end;

procedure TFchRepair.SetValidation(bReset:Boolean);
var
 i: integer;
begin
  if bReset then
    with quForm do
      for i := 0 to FieldCount-1 do
        if Fields[i].Required then
          Fields[i].Required := False;

  //Campos obrigatorios
  quFormIDModel.Required := True;
  quFormQty.Required     := True;

  if quFormTipo.AsInteger = 1 then
    quFormSerialNumber.Required := True;

  if quFormFase.AsString = 'Recvd from Customer' then
    ValidRecCustomer
  else if quFormFase.AsString = 'Send to Vendor' then
    ValidSentVendor
  else if (quFormFase.AsString = 'Back from Vendor') or (quFormFase.AsString = 'Credit Issued') then
    ValidBackVendor
  else if quFormFase.AsString = 'Sent to Customer' then
    ValidBackCustomer;
end;

procedure TFchRepair.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormDesativado.Value  := 0; // ** Ativo
  quFormTipoRepair.value  := 0; // ** 0=Nao retornado
  quFormTipo.AsInteger    := Tipo;
  quFormIDStore.AsInteger := DM.fStore.ID;

  quFormQty.AsFloat       := 1;

  bValidateQty            := True;

  // Dependendo do tipo, preenche os campos default
  if quFormTipo.AsInteger = 1 then
  begin
    quFormReceiveDate.AsDateTime  := Now;
    quFormIDUserReceive.AsInteger := DM.fUser.ID;
    quFormFase.AsString := 'Recvd from Customer';
  end
  else if quFormTipo.AsInteger = 2 then
  begin
    quFormSentDate.AsDateTime  := Now;
    quFormIDUserSent.AsInteger := DM.fUser.ID;
    quFormFase.AsString        := 'In store';
    PPageControl.Visible       := False;
  end;

  //Se for AutoInc do um refresh na tela
  if btLoopInc.Down then
  begin
    RefreshTab;
    SetValidation(True);
  end;
end;

procedure TFchRepair.FormShow(Sender: TObject);
begin
  inherited;
  RefreshTab;
  SetValidation(True);

  rdgTipoRepairCli.Visible := quFormTipo.AsInteger = 1;
  rdgTipoRepairInv.Visible := not rdgTipoRepairCli.Visible;

  if fIsRestricForm then
  begin
    sbSendToVendor.Visible    := False;
    btnBackVendor.Visible     := False;
    btnSendToCustomer.Visible := False;
    btnInStore.Visible        := False;
    dbSerialNumber.SetFocus;
  end
  else
    edtBarcode.SetFocus;

  scDefectType.ShowBtnUpdate := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  scDefectType.ShowBtnAddNew := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  ReadLotInfo;
  DisplayLot;
  EnableLotControls;
  FFinalizeLot := False;
  FSendLot     := False;

  cmbModel.Color := clWindow;
  if ( frmCommand = btAlt ) then begin
     cmbModel.Color := clMenu;
  end;

  cmbModel.ReadOnly := ( frmCommand = btAlt );

end;

procedure TFchRepair.btPrintClick(Sender: TObject);
begin
  inherited;
  if quForm.State in dsEditModes then
  begin
    quForm.UpdateRecord; // Force pending updates
    SaveChange;
    RefreshBrowse;
  end;

  // teste se deve salvar
  with TPrintRepairCliReceipt.Create(self) do
    if frmCommand = btInc then
      Start(StrToInt(FieldKey1))
    else
      Start(quFormIDRepair.AsInteger);
end;

procedure TFchRepair.RefreshTab;
begin
  // Tipo cliente - Hide the tabs
  tsReceiveCustomer.TabVisible := False;
  tsSentVendor.TabVisible      := False;
  tsReturnVendor.TabVisible    := False;
  tsBackCustomer.TabVisible    := False;

  lbPutSerial.Visible          := False;

  sbSendToVendor.Enabled       := False;
  btnBackVendor.Enabled        := False;
  btnSendToCustomer.Enabled    := False;

  btnSendToCustomer.Enabled    := False;
  btnInStore.Visible           := False;

  // Baseado no tipo da ficha mostra os tab's correspondentes
  if quFormTipo.AsInteger = 1 then
  begin
    lbPutSerial.Visible := True;

    if quFormFase.AsString = 'Recvd from Customer' then
    begin
      tsReceiveCustomer.TabVisible := True;
      sbSendToVendor.Enabled       := True;
      PPageControl.ActivePage      := tsReceiveCustomer;
    end;

    if quFormFase.AsString = 'Send to Vendor' then
    begin
      tsReceiveCustomer.TabVisible := True;
      tsSentVendor.TabVisible      := True;
      btnBackVendor.Enabled        := True;
      PPageControl.ActivePage      := tsSentVendor;
    end;

    if (quFormFase.AsString = 'Back from Vendor') or (quFormFase.AsString = 'Credit Issued') then
    begin
      tsReceiveCustomer.TabVisible := True;
      tsSentVendor.TabVisible      := True;
      tsReturnVendor.TabVisible    := True;
      btnSendToCustomer.Enabled    := True;
      PPageControl.ActivePage      := tsReturnVendor;
    end;

    if quFormFase.AsString = 'Sent to Customer' then
    begin
      tsReceiveCustomer.TabVisible := True;
      tsSentVendor.TabVisible      := True;
      tsReturnVendor.TabVisible    := True;
      tsBackCustomer.TabVisible    := True;
      PPageControl.ActivePage      := tsBackCustomer;
    end;

  end
  else if quFormTipo.AsInteger = 2 then
  begin
    if quFormFase.AsString = 'In store' then
    begin
      PPageControl.Visible := False;
      btnInStore.Visible   := True;
    end;

    if quFormFase.AsString = 'Send to Vendor' then
    begin
      if not PPageControl.Visible then
        PPageControl.Visible   := True;
      tsReturnVendor.TabVisible := False;
      tsSentVendor.TabVisible   := True;
      PPageControl.ActivePage   := tsSentVendor;
      btnBackVendor.Enabled     := True;
    end;

    if (quFormFase.AsString = 'Back from Vendor') or (quFormFase.AsString = 'Credit Issued') then
    begin
      tsSentVendor.TabVisible   := True;
      tsReturnVendor.TabVisible := True;
      PPageControl.ActivePage   := tsReturnVendor;
      btnSendToCustomer.Visible := False;
    end;
  end;
end;


procedure TFchRepair.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // Ajusta a visibilidade das msg de debito e credito
  lblSend.Visible := (quFormIDInvMovSend.AsString <> '');
  lblReturn.Visible := (quFormIDInvMovReturn.AsString <> '');
end;

function TFchRepair.OnAfterSaveChange(var iError:Integer):Boolean;
begin
  try
    if (quFormTipo.AsInteger = 2) then
      with spRepairDO do
      begin
        Parameters.ParamByName('@IDRepair').Value := quFormIDRepair.ASInteger;
        ExecProc;
      end;

      if FSendLot and bUseLot and (quFormTipo.AsInteger = 2) then
      begin
        SendLotToVendor;
        FSendLot := False;
      end;

      if FFinalizeLot and bUseLot and (quFormTipo.AsInteger = 2) then
      begin
        ReturnLotFromVendor;
        FFinalizeLot := False;
      end;

      Result := True;
  except
    Result := False;
  end;
end;

procedure TFchRepair.cmbModelSelectItem(Sender: TObject);
begin
  inherited;
  
  if not(DM.ModelRestored(StrToInt(cmbModel.LookUpValue))) then
  begin
    edtBarcode.Text := '';
    cmbModel.LookUpValue := '';
    exit;
  end;

  // Se já não estiver setado devo preecnher o custo do modelo
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT LastCost, DateLastCost, UseLot ' +
                'FROM Model ' +
                'WHERE IDModel = ' + cmbModel.LookUpValue;

    Open;

    if quFormDateLastCost.AsString = '' then
      quFormDateLastCost.AsDateTime := Fields[1].AsDateTime;

    if quFormLastCost.AsString = '' then
      quFormLastCost.AsCurrency := Fields[0].AsCurrency;

    bUseLot := Fields[2].AsBoolean;
    Close;
  end;

  if PPageControl.Visible then
    SetVendor(StrToInt(cmbModel.LookUpValue));

  //Somente Inventory
  if bUseLot and (cmbModel.LookUpValue <> '') and (quFormTipo.AsInteger = 2) then
  begin
    scLot.SpcWhereClause := 'IDModel = ' + cmbModel.LookUpValue;
    scLot.Visible := True;
    lbLot.Visible := True;
  end
  else
  begin
    DM.FFchParam  := '';
    scLot.Visible := False;
    lbLot.Visible := False;
  end;


end;

procedure TFchRepair.btSentToCustomerClick(Sender: TObject);
begin
  inherited;
  if quForm.State in dsEditModes then
  begin
    quForm.UpdateRecord; // Force pending updates
    SaveChange;
    RefreshBrowse;
  end;

  // teste se deve salvar
  with TPrintRepairStoreReceipt.Create(self) do
    if frmCommand = btInc then
      Start(StrToInt(FieldKey1))
    else
      Start(quFormIDRepair.AsInteger);
end;

procedure TFchRepair.spHelpClick(Sender: TObject);
begin
  inherited;
  if Tipo = 2 then
    Application.HelpContext(1770) //Inventory
  else
    Application.HelpContext(1250); // Customer
end;

procedure TFchRepair.sbSendToVendorClick(Sender: TObject);
begin
  inherited;

  if ValidateBeforeSentToVendor then
  begin
    //Send to Vendor
    DbMemoStr2.SetFocus;
    VerifyQty;
    SetStatus(1);
    SetValidation(False);
    RefreshTab;
    SetVendor(StrToInt(cmbModel.LookUpValue));
    FSendLot := True;
  end;
end;

procedure TFchRepair.btnBackVendorClick(Sender: TObject);
begin
  inherited;
  //Back from vendor
  SetStatus(2);
  SetValidation(False);
  RefreshTab;
  FFinalizeLot := True;
end;

procedure TFchRepair.btnSendToCustomerClick(Sender: TObject);
begin
  inherited;
  //Send To customer
  SetStatus(3);
  SetValidation(False);
  RefreshTab;
end;

procedure TFchRepair.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchRepair.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TFchRepair.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel : Integer;
begin
  inherited;
  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      cmbModel.LookUpValue := IntToStr(IDModel);
      cmbModelSelectItem(nil);
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;

  edtBarcode.Clear;
  dbSerialNumber.SetFocus;
end;

procedure TFchRepair.quFormAfterInsert(DataSet: TDataSet);
begin
  inherited;
  edtBarcode.SetFocus;
end;

procedure TFchRepair.FormCreate(Sender: TObject);
begin
  inherited;
  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];
  bControlLot                  := DM.fSystem.SrvParam[PARAM_USE_LOT_CONTROL];
  bValidateQty                 := False;
end;

procedure TFchRepair.quFormTipoRepairChange(Sender: TField);
begin
  inherited;
  //if quFormTipoRepair.AsInteger <> 0 then
  //SetStatus(2);
end;

procedure TFchRepair.SetVendor(IDModel: Integer);
begin
  //Traz o fornecedor que está relacionado ao Model
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT IDPessoa ' +
                'FROM Inv_ModelVendor ' +
                'WHERE IDModel = ' + IntToStr(IDModel) +
                'AND VendorOrder = 1';
    Open;
  end;
  if not DM.quFreeSQL.IsEmpty then
    cmbVendor.LookUpValue := DM.quFreeSQL.FieldByName('IDPessoa').Value
  else
    cmbVendor.Clear;
end;

procedure TFchRepair.btCloseClick(Sender: TObject);
begin
  if quFormTipoRepair.AsInteger = 4 then
    quFormFase.AsString := 'Credit Issued';

  inherited;
end;

procedure TFchRepair.VerifyQty;
begin

  if quForm.FieldByName('Qty').AsFloat > 1 then
    MsgBox(MSG_INF_QTY_GREATER_ONE, vbInformation + vbOkOnly);
    
end;

function TFchRepair.OnValidadeField: boolean;
begin

  Result := inherited OnValidadeField;

  if Tipo = 2 then
  begin
    if bValidateQty then
    begin
      if not ValidateQty then
      begin
        if (not Password.HasFuncRight(8)) then
        begin
          MsgBox(MSG_CRT_INVENTORY_WILL_BE_NEG, vbCritical);
          Result := False;
          Exit;
        end
        else if (MsgBox(MSG_QST_INV_WILL_BE_NEGATIVE, vbCritical + vbYesNo) = vbNo)then
        begin
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

  if (quFormTipo.AsInteger = 2) then
    if not bUseLot then
      quFormIDLote.Required := False
    else
      quFormIDLote.Required := bControlLot;

end;

procedure TFchRepair.DisplayLot;
begin

  if bUseLot and (cmbModel.LookUpValue <> '') and (quFormTipo.AsInteger = 2) then
  begin
    scLot.SpcWhereClause := 'IDModel = ' + cmbModel.LookUpValue;
    scLot.Visible := True;
    lbLot.Visible := True;
  end
  else
  begin
    DM.FFchParam  := '';
    scLot.Visible := False;
    lbLot.Visible := False;
  end;

end;

procedure TFchRepair.EnableLotControls;
begin

  if (frmCommand = btAlt) and bUseLot then
  begin
    quFormQty.ReadOnly := True;
    cmbModel.ReadOnly  := True;
    cmbModel.Enabled   := False;
    scLot.ReadOnly     := True;
    scLot.Enabled      := False;
    if (quFormFase.AsString = 'Back from Vendor') then
      rdgTipoRepairInv.Enabled := False;
  end
  else
  begin
    quFormQty.ReadOnly        := False;
    cmbModel.ReadOnly         := False;
    cmbModel.Enabled          := True;
    scLot.ReadOnly            := False;
    scLot.Enabled             := True;
    rdgTipoRepairInv.Enabled  := True;
  end;

end;

procedure TFchRepair.ReadLotInfo;
begin
  bUseLot := (quFormIDLote.AsInteger <> 0) and (quFormTipo.AsInteger = 2);
end;

procedure TFchRepair.OnAfterStart;
begin
  inherited;

  if bUseLot then
  begin
    quFormQty.ReadOnly        := False;
    cmbModel.ReadOnly         := False;
    cmbModel.Enabled          := True;
    scLot.ReadOnly            := False;
    scLot.Enabled             := True;
    rdgTipoRepairInv.Enabled  := True;
  end;

end;

procedure TFchRepair.OnAfterUpdateNavegator;
begin
  inherited;
  
  RefreshTab;
  ReadLotInfo;
  DisplayLot;
  EnableLotControls;
  
end;

procedure TFchRepair.SendLotToVendor;
begin

  if bUseLot and (cmbModel.LookUpValue <> '') and (quFormTipo.AsInteger = 2) then
  begin
    DM.FDMInventory.LotAdjust(StrToInt(cmbModel.LookUpValue),
                              DM.fStore.ID,
                              strToInt(scLot.LookUpValue),
                              quFormQty.AsFloat,
                              3);

    quFormQty.ReadOnly := True;
    cmbModel.ReadOnly  := True;
    cmbModel.Enabled   := False;
    scLot.ReadOnly     := True;
    scLot.Enabled      := False;
  end;

end;

function TFchRepair.ValidateBeforeSentToVendor: boolean;
begin

  Result := True;

  if cmbModel.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbCritical + vbOKOnly);
    cmbModel.SetFocus;
    Result := False;
    Exit;
  end;

  if bUseLot and bControlLot and (quFormTipo.AsInteger = 2) and (scLot.LookUpValue = '') then
  begin
    MsgBox(MSG_INF_DEL_MODEL_LOT, vbOKOnly + vbInformation);
    Result := False;
    scLot.SetFocus;
    Exit;
  end;

end;

procedure TFchRepair.ReturnLotFromVendor;
begin

  if quFormTipoRepair.AsInteger in [1,2] then
    DM.FDMInventory.LotAdjust(StrToInt(cmbModel.LookUpValue),
                              DM.fStore.ID,
                              strToInt(scLot.LookUpValue),
                              quFormQty.AsFloat,
                              2);

end;

function TFchRepair.ValidateQty: Boolean;
begin
  Result := False;

  if cmbModel.LookUpValue <> '' then
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text :=   'SELECT ' +
                           'StoreID, ' +
                           'ModelID, ' +
                           '(QtyOnHand) as Qty ' +
                    'FROM ' +
                           'Inventory (NOLOCK)' +
                    'WHERE ' +
                           'ModelID = ' + cmbModel.LookUpValue +
                           ' AND StoreID = ' + IntToStr(DM.fStore.ID);
      Open;

      if FieldByName('Qty').AsFloat >= quForm.FieldByName('Qty').AsFloat then
        Result := True;
      Close;
    end;
end;

procedure TFchRepair.quFormQtyChange(Sender: TField);
begin
  inherited;
  bValidateQty := True;
end;

procedure TFchRepair.btNextRecClick(Sender: TObject);
begin
  inherited;
  EnableSelectModel();
end;

procedure TFchRepair.btFirstRecClick(Sender: TObject);
begin
  inherited;
  EnableSelectModel();
end;

procedure TFchRepair.EnableSelectModel;
begin
   cmbModel.ReadOnly := ( frmCommand = btAlt )
end;

procedure TFchRepair.btPriorRecClick(Sender: TObject);
begin
  inherited;
  EnableSelectModel();
end;

procedure TFchRepair.btLastRecClick(Sender: TObject);
begin
  inherited;
  EnableSelectModel();
end;

end.
