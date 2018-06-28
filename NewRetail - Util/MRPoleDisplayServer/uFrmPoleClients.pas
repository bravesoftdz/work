unit uFrmPoleClients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, siComp;

type
  TFrmPoleClients = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    grdPoleClient: TcxGrid;
    grdPoleClientDB: TcxGridDBTableView;
    grdPoleClientLevel1: TcxGridLevel;
    dsPoleClient: TDataSource;
    grdPoleClientDBDescription: TcxGridDBColumn;
    grdPoleClientDBIPAddress: TcxGridDBColumn;
    grdPoleClientDBPort: TcxGridDBColumn;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Start : Boolean;
  end;

var
  FrmPoleClients: TFrmPoleClients;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

procedure TFrmPoleClients.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmPoleClients.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TFrmPoleClients.Start: Boolean;
begin
  ShowModal;
  Result := True;
end;

end.
