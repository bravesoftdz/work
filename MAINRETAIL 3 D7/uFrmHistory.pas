unit uFrmHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SubListPanel, DB, ADODB, DateBox, Mask, SuperComboADO;

type
  TFrmHistory = class(TFrmParentAll)
    btOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label35: TLabel;
    Label5: TLabel;
    scoHistoryType: TSuperComboADO;
    scoUser: TSuperComboADO;
    edtData: TDateBox;
    memOBS: TMemo;
    pnlFinalize: TPanel;
    Label10: TLabel;
    edtInvoiceNumber: TEdit;
    Label8: TLabel;
    lblReceivedBy: TLabel;
    edtReceivedBy: TEdit;
    Label9: TLabel;
    cmdInsertHistory: TADOCommand;
    lbCFOP: TLabel;
    scCFOP: TSuperComboADO;
    gbxCarrier: TGroupBox;
    lbCarrier: TLabel;
    lbFilterCarrier: TLabel;
    lbFreightType: TLabel;
    scFilterCarrier: TSuperComboADO;
    cbxFreightType: TComboBox;
    scCarrier: TSuperComboADO;
    procedure btOkClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure scoHistoryTypeSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scFilterCarrierSelectItem(Sender: TObject);
  private
    { Private declarations }
    fIDUser,
    fIDPreSale,
    fIDServiceOrder,
    fIDHistoryType : Integer;
    fMovDate : TDateTime;
    fOBS : String;
    sHold : String;
    bOk : Boolean;
    procedure InsertHistory;
    function ValidateFields:Boolean;
  public
    function StartSO(AIDHistoryType, AIDServiceOrder, AIDUser: Integer; ADataMov: TDateTime;
                   ASaleCode : String; var AHistParam : String; var ADateInv : TDateTime): Boolean;
                   
    function Start(IDHistoryType, IDPreSale, IDUser: Integer;DataMov: TDateTime;
                   SaleCode : String; var sHistParam : String; var dDateInv : TDateTime): Boolean;

  end;

var
  FrmHistory: TFrmHistory;

implementation

uses uDM, uParamFunctions, uDMGlobal, uMsgBox, uMsgConstant, uDateTimeFunctions,
     uHandleError, uSystemConst, IniFiles;

{$R *.dfm}

{ TFrmParentAll1 }
function TFrmHistory.StartSO(AIDHistoryType, AIDServiceOrder, AIDUser: Integer; ADataMov: TDateTime;
                   ASaleCode : String; var AHistParam : String; var ADateInv : TDateTime): Boolean;
begin
  fIDServiceOrder := AIDServiceOrder;
  fIDPreSale := 0;
  Result := Start(AIDHistoryType, fIDPreSale, AIDUser, ADataMov, ASaleCode, AHistParam, ADateInv);
end;

function TFrmHistory.Start(IDHistoryType, IDPreSale, IDUser: Integer;DataMov: TDateTime;
      SaleCode : String; var sHistParam : String; var dDateInv : TDateTime): Boolean;
begin
  bOk := False;

  fIDUser        := IDUser;
  fIDPreSale     := IDPreSale;
  fMovDate       := DataMov;

  memOBS.Clear;
  edtInvoiceNumber.Clear;
  edtReceivedBy.Clear;

  edtData.Date := Now;

  edtData.ReadOnly             := (DM.fUser.IDUserType <> USER_TYPE_ADMINISTRATOR);
  scoHistoryType.ShowBtnUpdate := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  scoHistoryType.ShowBtnAddNew := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  scoUser.LookUpValue := IntToStr(fIDUser);

  if IDHistoryType <> -1 then
  begin
     scoHistoryType.ReadOnly    := True;
     scoHistoryType.Color       := clSilver;
     scoHistoryType.LookUpValue := IntToStr(IDHistoryType);
     scoHistoryTypeSelectItem(scoHistoryType);
     scoHistoryType.TabStop     := False;
  end;

  Self.Caption := sHold + SaleCode;

  if pnlFinalize.Visible then
  begin
    Height := 455;
    scFilterCarrier.LookUpValue := DM.FMainRetailConfig.ReadString('Sale', 'CarrierFilter', '');
    scCFOP.LookUpValue          := DM.FMainRetailConfig.ReadString('Sale', 'CFOP', '');
    scFilterCarrierSelectItem(Self);
  end
  else
    Height := 287;



  ShowModal;

  if pnlFinalize.Visible then
  begin
    DM.FMainRetailConfig.WriteString('Sale', 'CarrierFilter', scFilterCarrier.LookUpValue);
    DM.FMainRetailConfig.WriteString('Sale', 'CFOP', scCFOP.LookUpValue);
  end;

  if fIDPreSale <> 0 then
    sHistParam := 'INVCODE='+ edtInvoiceNumber.Text + ';' +
                  'CFOP=' + scCFOP.LookUpValue +';'+
                  'CARRIER=' + scCarrier.LookUpValue + ';'+
                  'FTYPE='+ intToStr((cbxFreightType.ItemIndex+1)) + ';';

  dDateInv   := fMovDate;
  Result := bOk;
end;

procedure TFrmHistory.btOkClick(Sender: TObject);
var
  sInfo : String;
begin
  inherited;

  if not ValidateFields then
     Exit;

  fMovDate       :=  edtData.Date;
  fOBS           :=  memOBS.Text;
  fIDHistoryType :=  StrToInt(scoHistoryType.LookUpValue);

  InsertHistory;
  bOk := True;
  Close;
end;

procedure TFrmHistory.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmHistory.InsertHistory;
begin

  if scoHistoryType.LookUpValue = '1' then
    fOBS := fOBS + #13#10 + lblReceivedBy.Caption + ' ' + edtReceivedBy.Text;

  DM.ADODBConnect.BeginTrans;
  try
  with cmdInsertHistory do
    begin
      Parameters.ParamByName('IDHistory').Value      :=  DM.GetNextID('History.IDHistory');
      Parameters.ParamByName('IDUser').Value         :=  fIDUser;
      Parameters.ParamByName('MovDate').Value        :=  fMovDate;
      Parameters.ParamByName('OBS').Value            :=  fOBS;
      Parameters.ParamByName('IDHistoryType').Value  :=  fIDHistoryType;
      if fIDPreSale <> 0 then
        Parameters.ParamByName('IDPreSale').Value :=  fIDPreSale
      else
        Parameters.ParamByName('IDPreSale').Value :=  Null;
      if fIDServiceOrder <> 0 then
        Parameters.ParamByName('IDServiceOrder').Value := fIDServiceOrder
      else
        Parameters.ParamByName('IDServiceOrder').Value := Null;
      Execute;
    end;

    DM.ADODBConnect.CommitTrans;
  except
    on E: exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      DM.SetError(CRITICAL_ERROR, 'FrmHistory.InsertHistory', E.Message);
      MsgBox(MSG_CRT_ERROR_OCURRED, vbOkOnly+vbCritical);
    end;
  end;
end;

function TFrmHistory.ValidateFields: Boolean;
begin
   Result := True;

   if scoHistoryType.LookUpValue = '' then
     begin
     MsgBox(MSG_CRT_NO_VALID_SELECTION, vbCritical + vbOkOnly);
     Result := False;
     Exit;
     end;

   if not TestDate(edtData.Text) then
     begin
     MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
     Result := False;
     Exit;
     end;

   if pnlFinalize.Visible then
   begin
     if Trim(edtReceivedBy.Text) = '' then
       begin
       MsgBox(MSG_CRT_RECEIVEDBY_ISEMPTY, vbCritical + vbOkOnly);
       Result := False;
       Exit;
       end;

     if Trim(edtInvoiceNumber.Text) = '' then
       begin
       MsgBox(MSG_CRT_INVOICE_NUMBER_EMPTY, vbCritical + vbOkOnly);
       Result := False;
       Exit;
       end;

   end;


end;

procedure TFrmHistory.scoHistoryTypeSelectItem(Sender: TObject);
begin
  inherited;
  
  pnlFinalize.Visible := (scoHistoryType.LookUpValue = '1');

end;

procedure TFrmHistory.FormShow(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           if fIDPreSale <> 0 then
             sHold  := 'Hold # '
           else
             sHold  := 'Service Order # '
           end;

     LANG_PORTUGUESE :
           begin
           if fIDPreSale <> 0 then
             sHold  := 'Nº Pedido '
           else
             sHold  := 'Nº OS '
           end;

     LANG_SPANISH :
           begin
           if fIDPreSale <> 0 then
             sHold  := 'Nº Factura '
           else
             sHold  := 'Nº OS '
           end;
   end;

end;

procedure TFrmHistory.scFilterCarrierSelectItem(Sender: TObject);
begin
  inherited;

  if scFilterCarrier.LookUpValue = '' then
    scCarrier.SpcWhereClause := ''
  else
    scCarrier.SpcWhereClause := 'IDTipoPessoa = ' + scFilterCarrier.LookUpValue;

end;

end.
