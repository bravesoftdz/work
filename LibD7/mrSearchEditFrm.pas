unit mrSearchEditFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, XiButton;

type
  TSearchEditFrm = class(TForm)
    pnlTitulo: TPanel;
    pnlBottom: TPanel;
    grdSearchDBTableView: TcxGridDBTableView;
    grdSearchLevel: TcxGridLevel;
    grdSearch: TcxGrid;
    btnOk: TXiButton;
    btnCancel: TXiButton;
  private
    { Private declarations }
  public
    procedure Init;
    procedure ShowSearch;
  end;

var
  SearchEditFrm: TSearchEditFrm;

implementation

{$R *.dfm}

{ TSearchEditFrm }

procedure TSearchEditFrm.Init;
begin

end;

procedure TSearchEditFrm.ShowSearch;
begin
  ShowModal;
end;

end.
