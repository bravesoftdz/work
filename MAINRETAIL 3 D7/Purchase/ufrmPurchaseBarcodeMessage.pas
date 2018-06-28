unit ufrmPurchaseBarcodeMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeForms, StdCtrls, siComp, siLangRT;

type
  TfrmPurchaseBarcodeMessage = class(TFrmParentForms)
    Label1: TLabel;
    btnMerge: TButton;
    btnDelete: TButton;
    procedure btnMergeClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    chosen: Integer;
  public
    { Public declarations }
    function start: Integer;
  end;

implementation

{$R *.dfm}

{ TfrmPurchaseBarcodeMessage }

function TfrmPurchaseBarcodeMessage.start: Integer;
begin
  caption := 'Barcode Print Queue status.';
  showModal;
  result := chosen;

end;

procedure TfrmPurchaseBarcodeMessage.btnMergeClick(Sender: TObject);
begin
  inherited;
  chosen := btnMerge.Tag;
end;

procedure TfrmPurchaseBarcodeMessage.btnDeleteClick(Sender: TObject);
begin
  inherited;
  chosen := btnDelete.Tag;
end;

end.
