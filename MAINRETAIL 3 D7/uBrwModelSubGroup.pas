unit uBrwModelSubGroup;

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
  TbrwModelSubGroup = class(TbrwParent)
    quBrowseIDModelSubGroup: TIntegerField;
    quBrowseModelSubGroup: TStringField;
    quBrowseSalePriceMargemPercent: TFloatField;
    quBrowseUseSalePricePercent: TBooleanField;
    quBrowseIDSalePriceMargemTable: TIntegerField;
    quBrowseIDMSRPMargemTable: TIntegerField;
    quBrowseMSRPMargemPercent: TFloatField;
    quBrowseUseMSRPPercent: TBooleanField;
    quBrowseModelGroup: TStringField;
    quBrowseName: TStringField;
    quBrowseUserCode: TStringField;
    grdBrowseDBIDModelSubGroup: TcxGridDBColumn;
    grdBrowseDBModelSubGroup: TcxGridDBColumn;
    grdBrowseDBModelGroup: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBUserCode: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    fIDModelGroup : Integer;
    procedure OnBeforeExecSQL; override;
    function ValidateRestoreItem:Boolean;
    
  protected
    procedure OnAfterDeleteItem; override;
    procedure OnAfterRestoreItem; override;

    function ValidateDeleteItem:Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uFrmModelSubGroup, uDMGlobal, uParamFunctions, uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TbrwModelSubGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TBrwFrmModelSubGroup.Create(self);
end;

procedure TbrwModelSubGroup.OnBeforeExecSQL;
begin
  fIDModelGroup := StrToInt(ParseParam(Self.sParam, 'IDModelGroup'));
  aWhereBasicFilters[0] := 'MS.IDModelGroup = ' + IntToStr(fIDModelGroup);
  brwForm.sParam := brwForm.sParam + 'IDModelGroup='+IntToStr(fIDModelGroup)+';';
end;

procedure TbrwModelSubGroup.OnAfterDeleteItem;
begin
  inherited;
  DM.ADODBConnect.Execute('UPDATE ' +
                               'M ' +
                        'SET ' +
                               'M.Desativado = 1 ' +
                        'FROM ' +
                               'Model M ' +
                               'JOIN ModelSubGroup MG ON (M.IDModelSubGroup = MG.IDModelSubGroup) ' +
                        'WHERE ' +
                               'M.IDModelSubGroup = ' + quBrowseIDModelSubGroup.AsString);
end;

function TbrwModelSubGroup.ValidateDeleteItem: Boolean;
begin
  inherited ValidateDeleteItem;
  //Verifico se os items que pertencem a essa categoria estão com estoque < ou igual a zero.
  //Caso o estoque seja < ou igual a zero, eu excluo a caterias e todos seus relacionamentos.
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT ' +
                       'M.Model, ' +
                       'M.GroupID, ' +
                       'M.TotQtyOnHand ' +
                 'FROM ' +
                       'Model M (NOLOCK) ' +
                       'JOIN ModelSubGroup MG (NOLOCK) ON (M.IDModelSubGroup = MG.IDModelSubGroup) ' +
                 'WHERE ' +
                       'M.IDModelSubGroup = ' + quBrowseIDModelSubGroup.AsString +
                       ' AND ' +
                       'M.TotQtyOnHand > 0';
    Open;

    if IsEmpty then
      Result := True
    else
    begin
      Result := False;
      MsgBox(MSQ_QST_DELETE_SUBGROUP_REL, vbCritical + vbOKOnly);
    end;
  end;
  
end;

procedure TbrwModelSubGroup.OnAfterRestoreItem;
begin
  inherited;
  if not ValidateRestoreItem then
    if MsgBox(MSQ_QST_RETORE_CAT_SUBCAT_GROUP, vbCritical + vbYesNo) = vbYes then
    begin
      DM.ADODBConnect.Execute('UPDATE ' +
                                   'M ' +
                            'SET ' +
                                   'M.Desativado = 0 ' +
                            'FROM ' +
                                   'Model M ' +
                                   'JOIN ModelSubGroup MG ON (M.IDModelSubGroup = MG.IDModelSubGroup) ' +
                            'WHERE ' +
                                   'M.IDModelSubGroup = ' + quBrowseIDModelSubGroup.AsString);
    end;
end;

function TbrwModelSubGroup.ValidateRestoreItem: Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT ' +
                       'M.Model, ' +
                       'M.GroupID, ' +
                       'M.TotQtyOnHand ' +
                 'FROM ' +
                       'Model M (NOLOCK) ' +
                       'JOIN ModelSubGroup MG (NOLOCK) ON (M.IDModelSubGroup = MG.IDModelSubGroup) ' +
                 'WHERE ' +
                       'M.IDModelSubGroup = ' + quBrowseIDModelSubGroup.AsString;
    Open;

    Result := IsEmpty;
  end;
end;

end.
