unit uBrwSubGroup;

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
  TBrwSubGroup = class(TbrwParent)
    quBrowseIDSubGroup: TIntegerField;
    quBrowseSubGroup: TStringField;
    grdBrowseDBIDSubGroup: TcxGridDBColumn;
    grdBrowseDBSubGroup: TcxGridDBColumn;
    quBrowseUserCode: TStringField;
    grdBrowseDBUserCode: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uFchSubGroup, uDM, uDMGlobal;

{$R *.dfm}

procedure TBrwSubGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchSubGroup.Create(Self);
end;

end.
