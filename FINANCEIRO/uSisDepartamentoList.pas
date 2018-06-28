unit uSisDepartamentoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, ExtCtrls, dxDBGridPrint, dxBar, Db, BrowseConfig, 
  DBTables, E2Query, PowerQuery, dxBarExtItems, StdCtrls,
  dxCntner, dxTL, dxDBGrid, Buttons;

type
  TSisDepartamentoList = class(TParentList)
    quBrowseIDDepartamento: TIntegerField;
    quBrowseIDEmpresa: TIntegerField;
    quBrowseCodigoDepartamento: TStringField;
    quBrowseDepartamento: TStringField;
    quBrowseEmpresa: TStringField;
    brwGridCodigoDepartamento: TdxDBGridMaskColumn;
    brwGridDepartamento: TdxDBGridMaskColumn;
    brwGridEmpresa: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses uSisDepartamentoFch;

procedure TSisDepartamentoList.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TSisDepartamentoFch.Create(self);
end;

end.
