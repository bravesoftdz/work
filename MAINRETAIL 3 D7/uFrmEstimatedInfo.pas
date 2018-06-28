unit uFrmEstimatedInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, PowerADOQuery, DBCtrls, DateBox, Mask, SuperComboADO, ComCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  SuperEdit, SuperEditCurrency;

type
  TFrmEstimatedInfo = class(TFrmParentAll)
    quUpEstimated: TPowerADOQuery;
    quUpEstimatedIDEstimated: TIntegerField;
    quUpEstimatedIDDeliverType: TIntegerField;
    quUpEstimatedDeliverDate: TDateTimeField;
    quUpEstimatedDeliverAddress: TStringField;
    quUpEstimatedDeliverOBS: TStringField;
    quUpEstimatedTotalDiscount: TBCDField;
    quUpEstimatedConfirmed: TBooleanField;
    pgInfo: TPageControl;
    tsDeliver: TTabSheet;
    Label4: TLabel;
    cmbDelType: TDBSuperComboADO;
    pnlConfirmDeliver: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    Label28: TLabel;
    EditDelDate: TDBDateBox;
    EditDelAddress: TDBEdit;
    edtDelOBS: TDBEdit;
    dsUpEstimated: TDataSource;
    btnSave: TButton;
    tsPayments: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    dsUpPayment: TDataSource;
    quUpPayment: TADODataSet;
    quUpPaymentIDPaymentCondition: TIntegerField;
    quUpPaymentIDMeioPag: TIntegerField;
    quUpPaymentMeioPag: TStringField;
    quUpPaymentImageIndex: TIntegerField;
    quUpPaymentAmount: TBCDField;
    quUpPaymentOBS: TStringField;
    grdBrowseDBMeioPag: TcxGridDBColumn;
    grdBrowseDBImageIndex: TcxGridDBColumn;
    grdBrowseDBAmount: TcxGridDBColumn;
    grdBrowseDBOBS: TcxGridDBColumn;
    Label12: TLabel;
    cmbPayType: TSuperComboADO;
    lbObs: TLabel;
    edtObs: TEdit;
    lbAmount: TLabel;
    btnAdd: TSpeedButton;
    EditSalePrice: TSuperEditCurrency;
    btnDell: TSpeedButton;
    cmdInsertPayment: TADOCommand;
    lbDate: TLabel;
    dtPayment: TDateBox;
    quUpPaymentEstimetedDate: TDateTimeField;
    grdBrowseDBEstimetedDate: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure EditSalePriceClick(Sender: TObject);
    procedure EditSalePriceEnter(Sender: TObject);
    procedure EditSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddClick(Sender: TObject);
    procedure btnDellClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FClose        : Boolean;
    FOpenSale     : Boolean;
    FIDEstimated  : Integer;
    FIDPreSale    : Integer;
    FBalance      : Currency;
    FInvoiceTotal : Currency;

    procedure OpenEstimated;
    procedure CloseEstimated;
    procedure SaveEstimated;

    procedure OpenEstimatedPayment;
    procedure CloseEstimatedPayment;
    procedure RefreshEstimatedPayment;

    function ValidadeInfo : Boolean;
    function ValidatePayment : Boolean;
    procedure CalculateBalance;
  public
    function Start(IDEstimated : Integer) : Boolean;
    function StartPreSale(IDPreSale : Integer; InvoiceTotal : Currency) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uCharFunctions, uNumericFunctions;

{$R *.dfm}

{ TFrmEstimatedInfo }

function TFrmEstimatedInfo.Start(IDEstimated: Integer): Boolean;
begin
  FIDEstimated := IDEstimated;
  FOpenSale    := False;
  OpenEstimated;
  RefreshEstimatedPayment;
  ShowModal;
  Result := FClose;
end;

procedure TFrmEstimatedInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  CloseEstimated;
  CloseEstimatedPayment;
end;

procedure TFrmEstimatedInfo.CloseEstimated;
begin
  with quUpEstimated do
    if Active then
      Close;
end;

procedure TFrmEstimatedInfo.OpenEstimated;
begin
  with quUpEstimated do
    if not Active then
    begin
      Parameters.ParamByName('IDEstimated').Value := FIDEstimated;
      Open;
    end;
end;

procedure TFrmEstimatedInfo.SaveEstimated;
begin
  with quUpEstimated do
    if Active then
    begin
      if not (State in dsEditModes) then
        Edit;
      quUpEstimatedConfirmed.AsBoolean := True;
      Post;
    end;
end;

procedure TFrmEstimatedInfo.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
  FClose := False;
end;

procedure TFrmEstimatedInfo.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidadeInfo then
  begin
    if not FOpenSale then
      SaveEstimated;
    FClose := True;
    Close;
  end;
end;

function TFrmEstimatedInfo.ValidadeInfo: Boolean;
begin
  Result := False;

  if not FOpenSale then
  begin
    if quUpEstimatedIDDeliverType.AsString  = '' then
    begin
      MsgBox(MSG_INF_DELIVER_TYPE_EMPTY, vbCritical + vbOkOnly);
      if cmbDelType.CanFocus then
        cmbDelType.SetFocus;
      Exit;
    end;

    {
    if quUpEstimatedDeliverDate.AsString  = '' then
    begin
      MsgBox(MSG_CRT_NO_DATE, vbCritical + vbOkOnly);
      if EditDelDate.CanFocus then
        EditDelDate.SetFocus;
      Exit;
    end;


    if quUpEstimatedDeliverDate.AsDateTime < Date then
    begin
      MsgBox(MSG_CRT_DELIVER_DATE_SMALER, vbCritical + vbOkOnly);
      if EditDelDate.CanFocus then
        EditDelDate.SetFocus;
      Exit;
    end;
    }

    if quUpEstimatedDeliverAddress.AsString = '' then
    begin
      MsgBox(MSG_INF_NOT_EMPTY_ADDRESS, vbCritical + vbOkOnly);
      if EditDelAddress.CanFocus then
        EditDelAddress.SetFocus;
      Exit;
    end;
  end;

  if (FBalance <> 0) then
  begin
    MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
    pgInfo.ActivePage := tsPayments;
    EditSalePrice.Text := FormatFloat(DM.FQtyDecimalFormat, FBalance);
    Exit;
  end;

  Result := True;
  
end;

procedure TFrmEstimatedInfo.CloseEstimatedPayment;
begin
  with quUpPayment do
    if Active then
      Close;
end;

procedure TFrmEstimatedInfo.OpenEstimatedPayment;
begin

  with quUpPayment do
    if not Active then
    begin
      Parameters.ParamByName('IDEstimated').Value := FIDEstimated;
      Parameters.ParamByName('IDPreSale').Value   := FIDPreSale;
      Open;
    end;

end;

procedure TFrmEstimatedInfo.EditSalePriceClick(Sender: TObject);
begin
  inherited;
  EditSalePrice.SelectAll;
end;

procedure TFrmEstimatedInfo.EditSalePriceEnter(Sender: TObject);
begin
  inherited;
  EditSalePrice.SelectAll;
end;

procedure TFrmEstimatedInfo.EditSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmEstimatedInfo.btnAddClick(Sender: TObject);
begin
  inherited;

  if ValidatePayment then
    with cmdInsertPayment do
    begin
      Parameters.ParamByName('IDPaymentCondition').Value := DM.GetNextID('Sal_PaymentCondition.IDPaymentCondition');

      if not FOpenSale then
      begin
        Parameters.ParamByName('IDEstimated').Value      := FIDEstimated;
        Parameters.ParamByName('IDPreSale').Value        := Null;
      end
      else
      begin
        Parameters.ParamByName('IDEstimated').Value      := Null;
        Parameters.ParamByName('IDPreSale').Value        := FIDPreSale;
      end;

      Parameters.ParamByName('IDMeioPag').Value          := StrToInt(cmbPayType.LookUpValue);
      Parameters.ParamByName('Amount').Value             := MyStrToMoney(EditSalePrice.Text);
      Parameters.ParamByName('OBS').Value                := edtObs.Text;
      Parameters.ParamByName('EstimetedDate').Value      := dtPayment.Date;

      Execute;

      RefreshEstimatedPayment;

      cmbPayType.Clear;
      cmbPayType.SetFocus;
      edtObs.Clear;
    end;

end;

function TFrmEstimatedInfo.ValidatePayment: Boolean;
begin

  Result := False;

  if cmbPayType.LookUpValue = '' then
  begin
    cmbPayType.SetFocus;
    MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbCritical);
    Exit;
  end;

  if (MyStrToMoney(EditSalePrice.Text) = 0) then
  begin
    MsgBox(MSG_CRT_NO_PAYMENT_ZERO, vbCritical + vbOkOnly);
    if EditSalePrice.CanFocus then
      EditSalePrice.SetFocus;
    Exit;
  end;

  if MyStrToMoney(EditSalePrice.Text) > FBalance then
  begin
    MsgBox(MSG_CRT_NO_VALID_AMOUNT, vbCritical + vbOkOnly);
    EditSalePrice.Text := FormatFloat(DM.FQtyDecimalFormat, FBalance);
    if EditSalePrice.CanFocus then
      EditSalePrice.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TFrmEstimatedInfo.CalculateBalance;
var
  dTotalItem,
  dTotalPayment : Currency;
begin

  if FOpenSale then
    dTotalItem := FInvoiceTotal
  else
  begin
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(Round(SalePrice * Qty, 2, 1)) as Amount FROM EstimatedItem');
      SQL.Add('WHERE IDEstimated = :IDEstimated');
      Parameters.ParamByName('IDEstimated').Value := FIDEstimated;
      Open;
      dTotalItem := FieldByName('Amount').AsCurrency;
    finally
      Close;
    end;
  end;


  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(Amount) as Amount FROM Sal_PaymentCondition');

    if not FOpenSale then
    begin
      SQL.Add('WHERE IDEstimated = :IDEstimated');
      Parameters.ParamByName('IDEstimated').Value := FIDEstimated;
    end
    else
    begin
      SQL.Add('WHERE IDPreSale = :IDPreSale');
      Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    end;
    
    Open;
    dTotalPayment := FieldByName('Amount').AsCurrency;

  finally
    Close;
  end;

  FBalance := dTotalItem - dTotalPayment;
  EditSalePrice.Text := FormatFloat(DM.FQtyDecimalFormat, FBalance);
  
end;

procedure TFrmEstimatedInfo.btnDellClick(Sender: TObject);
var
  ID : Integer;
begin
  inherited;

  if quUpPayment.Active and (not quUpPayment.IsEmpty) then
  begin
    ID := quUpPaymentIDPaymentCondition.AsInteger;
    DM.RunSQL('DELETE Sal_PaymentCondition WHERE IDPaymentCondition = ' + IntToStr(ID));
    RefreshEstimatedPayment;
  end;

end;

procedure TFrmEstimatedInfo.RefreshEstimatedPayment;
begin
  CloseEstimatedPayment;
  OpenEstimatedPayment;
  CalculateBalance;
end;

function TFrmEstimatedInfo.StartPreSale(IDPreSale: Integer;
  InvoiceTotal : Currency): Boolean;
begin

  FIDPreSale           := IDPreSale;
  FInvoiceTotal        := InvoiceTotal;
  tsDeliver.TabVisible := False;
  FOpenSale            := True;

  OpenEstimated;
  RefreshEstimatedPayment;

  ShowModal;
  Result := FClose;

end;

procedure TFrmEstimatedInfo.FormShow(Sender: TObject);
begin
  inherited;
  dtPayment.Date := Now;
end;

procedure TFrmEstimatedInfo.FormCreate(Sender: TObject);
begin
  inherited;
  EditSalePrice.DisplayFormat := DM.FQtyDecimalFormat;
end;

end.
