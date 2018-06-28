unit uBrwSizeColorGroup;

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
  TbrwSizeColorGroup = class(TbrwParent)
    quBrowseIDSizeColorGroup: TIntegerField;
    quBrowseDescription: TStringField;
    quBrowseIsColor: TBooleanField;
    quBrowseSystem: TBooleanField;
    quBrowseHidden: TBooleanField;
    quBrowseDesativado: TBooleanField;
    grdBrowseDBIDSizeColorGroup: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure OnBeforeExecSQL; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
uses uDM, uSQLFunctions, uBrwFrmSizeColorGroup, uParamFunctions;

{ TbrwSizeColorGroup }

procedure TbrwSizeColorGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TBrwFrmSizeColorGroup.Create(Self);
end;

procedure TbrwSizeColorGroup.OnBeforeExecSQL;
begin
  inherited;

  aWhereBasicFilters[0] := 'IsColor = ' + IntToStr(Byte((ParseParam(Self.sParam, 'IsColor')='1')))+';';
  brwForm.sParam := Self.sParam;

end;

end.



