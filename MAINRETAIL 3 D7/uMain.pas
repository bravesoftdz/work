unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxDBGrid, dxCntner, dxTL, Db, DBTables, StdCtrls, Mask, dxDateEdit,
  ExtCtrls;

type
  TMain = class(TForm)
    Database: TDatabase;
    DataCombo: TDatabase;
    Panel1: TPanel;
    dbInicio: TdxDateEdit;
    dbFim: TdxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    quComTot: TQuery;
    dsComTot: TDataSource;
    quComTotSalesPerson: TStringField;
    quComTotCommission: TFloatField;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1SalesPerson: TdxDBGridMaskColumn;
    dxDBGrid1Commission: TdxDBGridMaskColumn;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.DFM}

procedure TMain.Button1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  with quComTot do
    begin
      Close;
      ParamByName('Inicio').AsDateTime := dbInicio.Date;
      ParamByName('Fim').AsDateTime := dbFim.Date + 1;
      Open;
    end;
  Screen.Cursor := crDefault;
end;

end.
