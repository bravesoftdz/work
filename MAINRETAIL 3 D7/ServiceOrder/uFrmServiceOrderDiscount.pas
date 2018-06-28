unit uFrmServiceOrderDiscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, ADODB,
  Mask, SuperComboADO, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TFrmServiceOrderDiscount = class(TFrmParentAll)
    pgDiscount: TPageControl;
    tsConfig: TTabSheet;
    tsApply: TTabSheet;
    btnApply: TButton;
    quPaymentDiscount: TADODataSet;
    dsPaymentDiscount: TDataSource;
    quPaymentDiscountIDPaymentDiscount: TIntegerField;
    quPaymentDiscountPayment: TStringField;
    quPaymentDiscountDiscountPercent: TBCDField;
    grdDiscount: TcxGrid;
    grdDiscountDBTableView: TcxGridDBTableView;
    grdDiscountLevel: TcxGridLevel;
    grdDiscountDBTableViewPayment: TcxGridDBColumn;
    grdDiscountDBTableViewDiscountPercent: TcxGridDBColumn;
    spnSpecialDiscount: TcxSpinEdit;
    cmbPaymentType: TSuperComboADO;
    lbPayment: TLabel;
    lbDiscount: TLabel;
    btnDelPet: TSpeedButton;
    btnAddPet: TSpeedButton;
    quPaymentDiscountIDMeioPag: TIntegerField;
    cxGridApplyDisc: TcxGrid;
    cxApplyDiscTableView: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxApplyDiscLevel: TcxGridLevel;
    Label1: TLabel;
    seApplyDiscount: TcxSpinEdit;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddPetClick(Sender: TObject);
    procedure btnDelPetClick(Sender: TObject);
    procedure dsPaymentDiscountDataChange(Sender: TObject; Field: TField);
    procedure btnApplyClick(Sender: TObject);
  private
    FIDSeviceOrder : Integer;
    function ValidateConfig : Boolean;

    procedure PaymentOpen;
    procedure PaymentClose;
    Procedure PaymentRefresh;
  public
    function Start(AType, AIDSeviceOrder : Integer):Boolean;
  end;

implementation

uses uDM, uDMServiceOrder, uMsgConstant, uMsgBox;

{$R *.dfm}

procedure TFrmServiceOrderDiscount.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmServiceOrderDiscount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmServiceOrderDiscount.btnAddPetClick(Sender: TObject);
var
  iID : Integer;
  sSQL : String;
begin
  inherited;
  if ValidateConfig then
  begin
  
    iID := DM.GetNextID('Sal_PaymentDiscount.IDPaymentDiscount');
    sSQL := 'INSERT Sal_PaymentDiscount (IDPaymentDiscount, IDMeioPag, DiscountPercent) ' +
             'VALUES ('+IntToStr(iID)+','+ cmbPaymentType.LookUpValue +',' + IntToStr(spnSpecialDiscount.Value) + ')';
    DM.RunSQL(sSQL);
    PaymentRefresh;

    cmbPaymentType.LookUpValue := '';
    spnSpecialDiscount.Value := 0;
    cmbPaymentType.SetFocus;
    
  end;
end;

procedure TFrmServiceOrderDiscount.btnDelPetClick(Sender: TObject);
var
  iID : Integer;
begin
  inherited;

  if quPaymentDiscount.Active and (not quPaymentDiscount.IsEmpty) then
  begin
    iID := quPaymentDiscountIDPaymentDiscount.AsInteger;
    DM.RunSQL('DELETE Sal_PaymentDiscount WHERE IDPaymentDiscount = ' + IntToStr(iID));
    PaymentRefresh;
  end;

end;

function TFrmServiceOrderDiscount.Start(AType, AIDSeviceOrder: Integer): Boolean;
begin

  tsConfig.TabVisible := False;
  tsApply.TabVisible  := False;
  FIDSeviceOrder      := AIDSeviceOrder;

  if (AType = 0) then
  begin
    tsConfig.TabVisible := True;
    btnApply.Visible    := False;
  end
  else
  begin
    tsApply.TabVisible := True;
    btnApply.Visible   := True;
  end;

  PaymentRefresh;

  ShowModal;
  Result := True;
  
end;

function TFrmServiceOrderDiscount.ValidateConfig: Boolean;
begin

  Result := False;

  if (cmbPaymentType.LookUpValue = '') then
  begin
    MsgBox(MSG_INF_CHOOSE_PAYTYPE, vbOkOnly + vbCritical);
    cmbPaymentType.SetFocus;
    Exit;
  end;

  if (spnSpecialDiscount.Value = 0) then
  begin
    MsgBox(MSG_INF_NUMBER_ZERO_INVALID, vbOkOnly + vbCritical);
    spnSpecialDiscount.SetFocus;
    Exit;
  end;

  if quPaymentDiscount.Active then
    if quPaymentDiscount.Locate('IDMeioPag', cmbPaymentType.LookUpValue, []) then
    begin
      MsgBox(MSG_INF_PAYTYPE_SELECTED, vbOkOnly + vbCritical);
      Exit;
    end;

  Result := True;

end;

procedure TFrmServiceOrderDiscount.PaymentClose;
begin
  with quPaymentDiscount do
    if Active then
      Close;
end;

procedure TFrmServiceOrderDiscount.PaymentOpen;
begin
  with quPaymentDiscount do
    if not Active then
      Open;
end;

procedure TFrmServiceOrderDiscount.PaymentRefresh;
begin
  PaymentClose;
  PaymentOpen;
end;

procedure TFrmServiceOrderDiscount.dsPaymentDiscountDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;

  if tsApply.TabVisible then
    seApplyDiscount.Value := quPaymentDiscountDiscountPercent.Value;

end;

procedure TFrmServiceOrderDiscount.btnApplyClick(Sender: TObject);
begin
  inherited;

  DMServiceOrder.ApplyPaymentDiscount(FIDSeviceOrder, seApplyDiscount.Value);
  Close;
  
end;

end.
