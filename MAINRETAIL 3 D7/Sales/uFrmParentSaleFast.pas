unit uFrmParentSaleFast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentSales, cxClasses, cxStyles, cxGridTableView, DB,
  ADODB, siComp, siLangRT, uSaleItem;

type
  TFrmParentSaleFast = class(TFrmParentSales)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    FSaleItem: TSaleItem;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmParentSaleFast.FormCreate(Sender: TObject);
begin
  inherited;
  FSaleItem := TSaleItem.Create;
end;

procedure TFrmParentSaleFast.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FSaleItem);
end;

end.
