unit UpdateNumCopyBarcode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, StdCtrls, Mask, DBCtrls, siComp, siLangRT,
  ExtCtrls, DB, dbClient;

type
  TfrmUpdateNumCopyBarcode = class(TDialogParent)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbedBarcode: TDBEdit;
    dbedDescription: TDBEdit;
    dbedPrice: TDBEdit;
    dsUpdateNumCopy: TDataSource;
    edtNumCopy: TEdit;
    procedure AplicarClick(Sender: TObject);
  private
    { Private declarations }
    FNumCopy: Integer;
    FBarcodeList: TDataSet;
  public
    { Public declarations }
    property BarcodeList: TDataSet read FBarcodeList;
    function Start(var barcode_list: TClientDataSet): Boolean;
  end;

implementation

{$R *.dfm}

{ TfrmUpdateNumCopyBarcode }

function TfrmUpdateNumCopyBarcode.Start(var barcode_list: TClientDataSet):Boolean;
begin
  FNumCopy := 0;
  dsUpdateNumCopy.DataSet := barcode_list;
  edtNumCopy.Text := dsUpdateNumCopy.DataSet.fieldByName('NumCopy').AsString;
  showModal;
end;

procedure TfrmUpdateNumCopyBarcode.AplicarClick(Sender: TObject);
begin
  inherited;
  if ( edtNumCopy.Text <> '' ) then
     FNumCopy := strToInt(edtNumCopy.Text);
     dsUpdateNumCopy.Edit;
     dsUpdateNumCopy.DataSet.FieldByName('NumCopy').AsInteger := FNumCopy;
     dsUpdateNumCopy.DataSet.Post;
     FBarcodeList := dsUpdateNumCopy.DataSet;
end;

end.
