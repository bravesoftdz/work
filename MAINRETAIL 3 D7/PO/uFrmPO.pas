unit uFrmPO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DateBox, Mask, Db, DBTables,
  ADODB, SuperComboADO, siComp, siLangRT, PaiDeForms;

type
  TFrmPO = class(TFrmParentForms)
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    scVendor: TSuperComboADO;
    OrderDate: TDateBox;
    Label1: TLabel;
    Label2: TLabel;
    quInsertPO: TADOQuery;
    Label3: TLabel;
    dtEstArriv: TDateBox;
    scStore: TSuperComboADO;
    Label4: TLabel;
    btOK: TButton;
    btCancel: TButton;
    Label5: TLabel;
    edtPayDays: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    memOBS: TMemo;
    cmdUpdatePO: TADOCommand;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPayDaysKeyPress(Sender: TObject; var Key: Char);
    procedure scVendorSelectItem(Sender: TObject);
  private
    FPODataSet: TADOQuery;
    FIsInc: Boolean;
    FIsOpened: Boolean;

    procedure SetCaptionForm;
    procedure SetDefaulfValues;
    procedure SetLockedFields;

    function ValidateFields: Boolean;
    procedure InsertPO;
    procedure UpdatePO;
  public
    function Start(ADataSet: TADOQuery; AIsInc, AIsOpened: Boolean): Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uCharFunctions;

{$R *.DFM}

function TFrmPO.Start(ADataSet: TADOQuery; AIsInc, AIsOpened: Boolean): Boolean;
begin
  FPODataSet := ADataSet;
  FIsInc := AIsInc;
  FIsOpened := AIsOpened;

  SetCaptionForm;
  SetDefaulfValues;
  SetLockedFields;

  Result := (ShowModal = mrOK);
end;

procedure TFrmPO.btOKClick(Sender: TObject);
begin
  if ValidateFields then
    try
      if FIsInc then
        InsertPO
      else
        UpdatePO;
    except
      MsgBox(MSG_CRT_ERROR_OCURRED, vbInformation + vbOKOnly);
      ModalResult := mrNone;
    end
  else
    ModalResult := mrNone;
end;

procedure TFrmPO.FormShow(Sender: TObject);
begin
   inherited;
   if FIsInc then
   begin
     scVendor.SetFocus;
     OrderDate.Text      := DateTimeToStr(Date());
     dtEstArriv.Date     := Now + 7;
     scStore.LookUpValue := IntToStr(DM.fStore.ID);
   end
   else
     edtPayDays.SetFocus;
end;

procedure TFrmPO.edtPayDaysKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateQty(Key);
end;

procedure TFrmPO.InsertPO;
var
  iIDPO: Integer;
begin
  iIDPO := DM.GetNextID('PO.IDPO');

  with quInsertPO do
  begin
    Parameters.ParambyName('IDPO').Value         := iIDPO;
    Parameters.ParambyName('IDFornecedor').Value := StrToInt(scVendor.LookUpValue);
    Parameters.ParambyName('IDStore').Value      := StrToIntDef(scStore.LookUpValue, DM.fStore.ID);
    Parameters.ParambyName('DataPedido').Value   := OrderDate.Date;
    Parameters.ParambyName('EstArriv').Value     := dtEstArriv.Date;
    Parameters.ParambyName('Aberto').Value       := True;
    Parameters.ParambyName('PayDays').Value      := StrToIntDef(edtPayDays.Text,0);
    Parameters.ParamByName('OBS').Value          := memOBS.Text;
    ExecSQL;
  end;
end;

procedure TFrmPO.UpdatePO;
begin
  with cmdUpdatePO do
  begin
    Parameters.ParamByName('IDPO').Value := FPODataSet.FieldByName('IDPO').AsInteger;
    Parameters.ParamByName('DataPedido').Value := OrderDate.Date;
    Parameters.ParamByName('EstArrival').Value := dtEstArriv.Date;
    Parameters.ParamByName('PayDays').Value := StrToIntDef(edtPayDays.Text,0);
    Parameters.ParamByName('OBS').Value := memOBS.Text;
    Execute;
  end;
end;

function TFrmPO.ValidateFields: Boolean;
begin
  Result := False;

  if Trim(scStore.LookUpValue) = '' then
  begin
    MsgBox(MSG_CRT_NO_STORE_SELECTED, vbCritical + vbOkOnly);
    Exit;
  end;

  if Trim(scVendor.LookUpValue) = '' then
  begin
    MsgBox(MSG_CRT_NO_VENDOR, vbCritical + vbOkOnly);
    Exit;
  end;

  Result := True;
end;

procedure TFrmPO.SetCaptionForm;
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
      if FIsInc then
        Self.Caption := 'New PO'
      else
        Self.Caption := 'Update PO';

    LANG_PORTUGUESE:
      if FIsInc then
        Self.Caption := 'Novo Pedido de Compra'
      else
        Self.Caption := 'Alterar Pedido de Compra';

    LANG_SPANISH:
      if FIsInc then
        Self.Caption := 'Nuevo Pedido Compra'
      else
        Self.Caption := 'Alterar Pedido Compra';
  end;
end;

procedure TFrmPO.SetDefaulfValues;
begin
  if FIsInc then
  begin
    scStore.LookUpValue := '';
    scStore.ReadOnly := False;
    scStore.Color := clWhite;

    scVendor.LookUpValue := '';
    scVendor.ReadOnly := False;
    scVendor.Color := clWhite;

    OrderDate.Text := '';
    dtEstArriv.Text := '';
    edtPayDays.Text := '';
    memOBS.Text := '';
  end
  else
  begin
    scStore.LookUpValue := FPODataSet.FieldByName('IDStore').AsString;
    scStore.ReadOnly := True;
    scStore.ParentColor := True;

    scVendor.LookUpValue := FPODataSet.FieldByName('IDFornecedor').AsString;
    scVendor.ReadOnly := True;
    scVendor.ParentColor := True;

    OrderDate.Date := FPODataSet.FieldByName('DataPedido').AsDateTime;
    dtEstArriv.Date := FPODataSet.FieldByName('EstArrival').AsDateTime;
    edtPayDays.Text := FPODataSet.FieldByName('PayDays').AsString;
    memOBS.Text := FPODataSet.FieldByName('OBS').AsString;
  end;
end;

procedure TFrmPO.SetLockedFields;
begin
  if FIsOpened then
  begin
    OrderDate.Enabled := True;
    OrderDate.ParentColor := False;

    dtEstArriv.Enabled := True;
    dtEstArriv.ParentColor := False;


    edtPayDays.ReadOnly := False;
    edtPayDays.ParentColor := False;

    memOBS.ReadOnly := False;
    memOBS.ParentColor := False;
  end
  else
  begin
    OrderDate.Enabled := False;
    OrderDate.ParentColor := True;

    dtEstArriv.Enabled := False;
    dtEstArriv.ParentColor := True;

    edtPayDays.ReadOnly := True;
    edtPayDays.ParentColor := True;

    memOBS.ReadOnly := True;
    memOBS.ParentColor := True;
  end;
end;

procedure TFrmPO.scVendorSelectItem(Sender: TObject);
begin
  inherited;
  edtPayDays.Text := IntToStr(dm.GetDayShiftVendorTerms(scVendor.LookUpFieldValue));
end;

end.
