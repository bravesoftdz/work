unit uBrwMargem;

interface
                   
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeBrowses, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSCore,
  dxPScxGridLnk, ExtCtrls, BrowseConfig, ADODB, PowerADOQuery, siComp,
  siLangRT, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  PanelRights, StdCtrls, Buttons, LblEffct;

type
  TbrwMargem = class(TbrwParent)
    quBrowseIDMargemTable: TIntegerField;
    quBrowseMargemTable: TStringField;
    grdBrowseDBIDMargemTable: TcxGridDBColumn;
    grdBrowseDBMargemTable: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  end;

var
  brwMargem: TbrwMargem;

implementation

uses uFchMargem;

{$R *.dfm}

procedure TbrwMargem.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFchMargem.Create(self);
end;

end.
