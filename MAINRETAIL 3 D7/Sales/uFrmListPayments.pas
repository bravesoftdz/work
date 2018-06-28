unit uFrmListPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, siComp, uFormasPagamento,
  StdCtrls, DB, ADODB, PaiDeForms, siLangRT, PaideTodosGeral, Buttons,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridTableView, cxGridCustomTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, Provider, DBClient;

const
  PAYMENT_TYPE_CASHBACK = -10;

type
  TFrmListPayments = class(TFrmParentAll)
    pnlOption: TPanel;
    pnlPayOption: TPanel;
    rbPayNow: TRadioButton;
    rbPayLater: TRadioButton;
    pnlKay1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    lbF2: TLabel;
    Panel2: TPanel;
    Image2: TImage;
    Label2: TLabel;
    lbF3: TLabel;
    Label3: TLabel;
    quPaymentType: TADODataSet;
    dsPaymentType: TDataSource;
    quPaymentTypeIDMeioPag: TIntegerField;
    quPaymentTypeMeioPag: TStringField;
    btnOK: TButton;
    grdPayments: TcxGrid;
    grdPaymentsDB: TcxGridDBTableView;
    grdPaymentsLevel: TcxGridLevel;
    grdPaymentsDBMeioPag: TcxGridDBColumn;
    strepPayments: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    csList: TcxStyle;
    dspPaymentType: TDataSetProvider;
    cdsPaymentType: TClientDataSet;
    quPaymentTypeTipo: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FIDMeioPag    : Integer;
    FIDMeioPagTipo: Integer;
    FPreDatado    : Boolean;
    FResult       : Boolean;
    procedure OpenPayment;
    procedure ClosePayment;
    procedure SetCashBack;
    procedure CreateCashBackPayment;
    procedure PaymentTypeFilter;
    function CheckOnePayment: Boolean;
  public
    function Start(var AIDMeioPagTipo: Integer; var AIDMeioPag: Integer;
      var APreDatado: Boolean; AllowSelectPaymentType : Boolean = True): Boolean;
  end;


implementation

uses uDM, uSystemConst, uMsgBox, uMsgConstant;

{$R *.dfm}

function TFrmListPayments.Start(var AIDMeioPagTipo: Integer; var AIDMeioPag: Integer;
  var APreDatado: Boolean; AllowSelectPaymentType : Boolean = True): Boolean;
begin
  FIDMeioPag     := -1;
  FIDMeioPagTipo := AIDMeioPagTipo;

  PaymentTypeFilter;
  // Alex 09/25/2015 - Removed arg_deviceProcess and added AllowSelectPaymentType
  //FResult := AllowSelectPaymentType;


  // Antonio 09/10/2016 if ( FResult  ) then begin
      if not CheckOnePayment then
        ShowModal;
  //end;

  if AIDMeioPagTipo = PAYMENT_TYPE_OTHER then
    SetCashBack;

  FPreDatado     := rbPayLater.Checked;
  AIDMeioPag     := FIDMeioPag;
  APreDatado     := FPreDatado;
  AIDMeioPagTipo := FIDMeioPagTipo;
  Result         := FResult;
end;

procedure TFrmListPayments.FormShow(Sender: TObject);
begin
  inherited;
  KeyPreview := True;
  grdPayments.SetFocus;
end;

procedure TFrmListPayments.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
      end;

    VK_ESCAPE:
      begin
        btCloseClick(Self);
      end;

    VK_F2 : begin
            if pnlPayOption.Visible then
               rbPayNow.Checked := True;
            end;
    VK_F3 : begin
            if pnlPayOption.Visible then
               rbPayLater.Checked := True;
            end;
  end;
end;

procedure TFrmListPayments.ClosePayment;
begin
  with quPaymentType do
    if Active then
      Close;
end;

procedure TFrmListPayments.OpenPayment;
begin
  with cdsPaymentType do
    if not Active then
    begin
      Open;
      CreateCashBackPayment;
    end;

end;

function TFrmListPayments.CheckOnePayment: Boolean;
begin
  Result := False;

  pnlOption.Visible := (DM.fSystem.SrvParam[PARAM_DISPLAY_PRE_DATADO]) and (FIDMeioPagTipo in [PAYMENT_TYPE_CHECK, PAYMENT_TYPE_CARD]);

  if (cdsPaymentType.RecordCount = 1) and (not pnlOption.Visible) then
  begin
    FIDMeioPag := cdsPaymentType.FieldByName('IDMeioPag').AsInteger;
    Result := True;
    FResult := True;
  end
  else if cdsPaymentType.RecordCount = 0 then
  begin
    MsgBox(MSG_CRT_PAYMENT_NOT_EXIST, vbCritical + vbOKOnly);
    Result := True;
    FResult := False;
  end;
end;

procedure TFrmListPayments.btCloseClick(Sender: TObject);
begin
  inherited;
  FResult    := False;
  FIDMeioPag := -1;
  Close;
end;

procedure TFrmListPayments.btnOKClick(Sender: TObject);
begin
  inherited;
  FResult := True;
  FIDMeioPag := cdsPaymentType.FieldByName('IDMeioPag').AsInteger;
end;

procedure TFrmListPayments.FormCreate(Sender: TObject);
begin
  inherited;
  OpenPayment;
end;

procedure TFrmListPayments.FormDestroy(Sender: TObject);
begin
  inherited;
  ClosePayment;
end;

procedure TFrmListPayments.PaymentTypeFilter;
begin

  with cdsPaymentType do
  begin
    Filtered := False;
    Filter := 'Tipo = ' + IntToStr(FIDMeioPagTipo);
    Filtered := True;
  end;

end;

procedure TFrmListPayments.SetCashBack;
begin
  if cdsPaymentType.FieldByName('IDMeioPag').AsInteger = PAYMENT_TYPE_CASHBACK then
  begin
    FIDMeioPagTipo := PAYMENT_TYPE_CASHBACK;
    FIDMeioPag     := PAY_TYPE_CASH;
  end;
end;

procedure TFrmListPayments.CreateCashBackPayment;
begin
  with cdsPaymentType do
    if Active then
    begin
      Append;
      FieldByName('IDMeioPag').AsInteger := PAYMENT_TYPE_CASHBACK;
    	FieldByName('Tipo').AsInteger      := PAYMENT_TYPE_OTHER;
      FieldByName('MeioPag').AsString    := 'Cash Back';
      Post;
    end;
end;

end.
