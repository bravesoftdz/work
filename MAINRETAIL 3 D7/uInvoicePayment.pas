unit uInvoicePayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Db,
  DBTables, Grids, DBCtrls, Buttons, ADODB, DBGrids, siComp, siLangRT,
  SMDBGrid, SuperComboADO, SubListPanel;

type
  TInvoicePayment = class(TFrmParentAll)
    quPayment: TADOQuery;
    dsPayment: TDataSource;
    quCashRegDetail: TADOQuery;
    dsCashRegDetail: TDataSource;
    quPaymentIDMeioPag: TIntegerField;
    quPaymentMeioPag: TStringField;
    quPaymentValorNominal: TFloatField;
    quPaymentDataVencimento: TDateTimeField;
    quPaymentIDQuitacaoMeioPrevisto: TIntegerField;
    quPaymentIDLancamentoTipo: TIntegerField;
    quPaymentIDDocumentoTipo: TIntegerField;
    quPaymentIDPreSale: TIntegerField;
    quCashRegDetailOpenUser: TStringField;
    quCashRegDetailOpenTime: TDateTimeField;
    quCashRegDetailCashRegister: TStringField;
    pnlInvoice: TPanel;
    quPaymentCheckNumber: TStringField;
    quPaymentIDBankCheck: TIntegerField;
    quPaymentCustomerDocument: TStringField;
    quPaymentCustomerName: TStringField;
    quPaymentCustomerPhone: TStringField;
    quPaymentHistorico: TMemoField;
    SubPaymentType: TSubListPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Bevel1: TBevel;
    procedure btCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure quPaymentAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fCaptionLayaway,
    fCaptionInvoice : String;
    fIsInvoice : Boolean;
  public
    function Start( IDPreSale : integer; IsLayaway, IsInvoice: Boolean) : Boolean;
    function StartServiceOrder(IDServiceOrder : integer): Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSqlFunctions, Variants;

{$R *.DFM}

function TInvoicePayment.StartServiceOrder(
  IDServiceOrder: integer): Boolean;
begin

  pnlInvoice.Visible := False;
  Self.Caption := fCaptionInvoice;

  with quPayment do
  begin
    Close;
    SQL.Text := ChangeWhereClause(SQL.Text, ' L.IDServiceOrder = ' + IntToStr(IDServiceOrder), True);
    Open;
  end;

  SubPaymentType.CreateSubList;
  SubPaymentType.Param := 'IDServiceOrder='+IntToStr(IDServiceOrder)+';'+
                          'ShowDetail=True;Enabled=0;'+
                          'IsNewInvoice=0;';

  Result := (ShowModal = mrOk);


  quPayment.Close;

end;


function TInvoicePayment.Start( IDPreSale : integer; IsLayaway, IsInvoice: Boolean) : Boolean;
begin

  // Acerta os captions
  pnlInvoice.Visible :=  not IsLayaway;
  fIsInvoice := IsInvoice;

  if IsLayaway then
    begin
    Self.Caption := fCaptionLayaway;
    end
  else
    begin
    Self.Caption := fCaptionInvoice;
    end;

  if not IsLayaway then
    with quCashRegDetail do
      begin
        Close;
        Parameters.ParambyName('IDPreSale').Value := IDPreSale;
        Open;
      end;

  with quPayment do
  begin
    Close;
    SQL.Text := ChangeWhereClause(SQL.Text, ' L.IDPreSale = ' + IntToStr(IDPreSale), True);
    Open;
  end;

  SubPaymentType.CreateSubList;
  SubPaymentType.Param := 'IDPreSale='+IntToStr(IDPreSale)+';'+
                          'ShowDetail=True;Enabled='+IntToStr(Byte(not fIsInvoice))+';'+
                          'IsNewInvoice=0;';

  Result := (ShowModal = mrOk);

  quCashRegDetail.Close;
  quPayment.Close;

end;

procedure TInvoicePayment.btCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOK;
end;

procedure TInvoicePayment.Button1Click(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TInvoicePayment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TInvoicePayment.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           fCaptionLayaway := 'Layaway - Payment(s)';
           fCaptionInvoice := 'Invoice - Payment(s)';
           end;

     LANG_PORTUGUESE :
           begin
           fCaptionLayaway := 'Pagamento(s) do Pedido';
           fCaptionInvoice := 'Pagamento(s) da Nota';
           end;

     LANG_SPANISH :
           begin
           fCaptionLayaway := 'Pago(s) do Pedido';
           fCaptionInvoice := 'Pago(s) da Factura';
           end;
   end;

end;

procedure TInvoicePayment.quPaymentAfterOpen(DataSet: TDataSet);
var
  bHasCheck : Boolean;
begin
  inherited;

  quPayment.DisableControls;
  bHasCheck := False;
  try
    quPayment.First;
    while not quPayment.Eof do
      begin
      bHasCheck := (quPaymentCustomerName.AsString <> '');
      if bHasCheck then
         Break;
      quPayment.Next;
      end;
  finally
    quPayment.First;
    quPayment.EnableControls;
    end;

  if bHasCheck then
     ClientHeight := 375
  else
     ClientHeight := 265;

end;


end.
