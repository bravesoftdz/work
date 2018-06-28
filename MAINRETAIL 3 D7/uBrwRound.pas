unit uBrwRound;

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
  TbrwRound = class(TbrwParent)
    quBrowseRoundingTable: TStringField;
    grdBrowseDBIDRoundingTABLE: TcxGridDBColumn;
    grdBrowseDBRoundingTable: TcxGridDBColumn;
    quBrowseIDRoundingTable: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uFchRound;

{$R *.dfm}

procedure TbrwRound.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFchRound.Create(self);
end;

end.
