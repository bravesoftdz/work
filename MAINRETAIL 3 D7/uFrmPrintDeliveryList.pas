unit uFrmPrintDeliveryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, DateBox;

type
  TFrmPrintDeliveryList = class(TFrmParentAll)
    btnPrint: TButton;
    Label1: TLabel;
    dtDelivery: TDateBox;
    procedure btnPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start:Boolean;
  end;


implementation

uses uFrmPrintDelivery;

{$R *.dfm}

{ TFrmPrintDeliveryList }

function TFrmPrintDeliveryList.Start: Boolean;
begin
   dtDelivery.Date := Now;
   ShowModal;
   Result := True;
end;

procedure TFrmPrintDeliveryList.btnPrintClick(Sender: TObject);
begin
  inherited;
  //Print Delivery
  with TFrmPrintDelivery.Create(Self) do
     Start(dtDelivery.Date);
  Close;   
end;

procedure TFrmPrintDeliveryList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPrintDeliveryList.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
