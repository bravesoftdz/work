unit uBrwModelGroup;

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
  PanelRights, StdCtrls, Buttons, LblEffct, uBrwModelSubGroup;

type
  TbrwModelGroup = class(TbrwParent)
    btnSubGroup: TSpeedButton;
    quBrowseIDModelGroup: TIntegerField;
    quBrowseModelGroup: TStringField;
    quBrowseSalePriceMargemPercent: TFloatField;
    quBrowseUseSalePricePercent: TBooleanField;
    quBrowseIDSalePriceMargemTable: TIntegerField;
    quBrowseIDMSRPMargemTable: TIntegerField;
    quBrowseMSRPMargemPercent: TFloatField;
    quBrowseUseMSRPPercent: TBooleanField;
    quBrowseName: TStringField;
    quBrowseUserCode: TStringField;
    grdBrowseDBIDModelGroup: TcxGridDBColumn;
    grdBrowseDBModelGroup: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBUserCode: TcxGridDBColumn;
    Panel4: TPanel;
    procedure btnSubGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    sModelSubGroup : String;
    fIDGroup : Integer;
    procedure OnBeforeExecSQL; override;
    procedure LoadImages; override;
    function ValidateRestoreItem:Boolean;

  protected
    procedure OnAfterDeleteItem; override;
    procedure OnAfterRestoreItem; override;

    function ValidateDeleteItem:Boolean; override;
  public
    { Public declarations }

  end;

implementation

uses uFrmModelGroup, uDMGlobal, uParamFunctions, uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TbrwModelGroup.btnSubGroupClick(Sender: TObject);
var
  sMenu : String;
begin
  inherited;

  if quBrowse.RecordCount = 0 then
     Exit;

  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := sModelSubGroup + ' - ' + quBrowseModelGroup.AsString;
  try
    with TBrwModelSubGroup.Create(Self) do
      begin
      sParam := sParam + 'IDModelGroup='+quBrowseIDModelGroup.AsString+';';
      Start;
      end;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;

end;

procedure TbrwModelGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TBrwFrmModelGroup.Create(self);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sModelSubGroup := 'Sub Group';
           end;

     LANG_PORTUGUESE :
           begin
           sModelSubGroup := 'Sub Grupo';
           end;

     LANG_SPANISH :
           begin
           sModelSubGroup := 'Sub Grupo';
           end;
   end;
end;

procedure TbrwModelGroup.LoadImages;
begin
  inherited;
  DM.imgSubMenu.GetBitmap(29, btnSubGroup.Glyph);
end;

procedure TbrwModelGroup.OnBeforeExecSQL;
begin
    fIDGroup := StrToInt(ParseParam(Self.sParam, 'IDGroup'));
    aWhereBasicFilters[0] := 'MG.IDGroup = ' + IntToStr(fIDGroup);
    brwForm.sParam := brwForm.sParam + 'IDGroup='+IntToStr(fIDGroup)+';';
end;

procedure TbrwModelGroup.OnAfterDeleteItem;
begin
  inherited;
  DM.ADODBConnect.Execute('UPDATE ' +
                                 'MSG ' +
                          'SET ' +
                                 'MSG.Desativado = 1 ' +
                          'FROM ' +
                                 'ModelSubGroup MSG ' +
                                 'JOIN ModelGroup MG ON (MSG.IDModelGroup = MG.IDModelGroup) ' +
                          'WHERE ' +
                                 'MG.IDModelGroup = ' + quBrowseIDModelGroup.AsString);

  DM.ADODBConnect.Execute('UPDATE ' +
                                 'M ' +
                          'SET ' +
                                 'M.Desativado = 1 ' +
                          'FROM ' +
                                 'Model M ' +
                                 'JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup) ' +
                          'WHERE ' +
                                 'M.IDModelGroup = ' + quBrowseIDModelGroup.AsString);
end;

function TbrwModelGroup.ValidateDeleteItem: Boolean;
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
                       'Model M ' +
                       'JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup) ' +
                 'WHERE ' +
                       'M.IDModelGroup = ' + quBrowseIDModelGroup.AsString +
                       ' AND ' +
                       'M.TotQtyOnHand > 0';
    Open;

    if IsEmpty then
      Result := True
    else
    begin
      Result := False;
      MsgBox(MSQ_QST_DELETE_GROUP_REL, vbCritical + vbOKOnly);
    end;
  end;

end;

procedure TbrwModelGroup.OnAfterRestoreItem;
begin
  inherited;
  DM.ADODBConnect.Execute('UPDATE ' +
                                 'MSG ' +
                          'SET ' +
                                 'MSG.Desativado = 0 ' +
                          'FROM ' +
                                 'ModelSubGroup MSG ' +
                                 'JOIN ModelGroup MG ON (MSG.IDModelGroup = MG.IDModelGroup) ' +
                          'WHERE ' +
                                 'MG.IDModelGroup = ' + quBrowseIDModelGroup.AsString);

  if not ValidateRestoreItem then
    if MsgBox(MSQ_QST_RETORE_CAT_SUBCAT_GROUP, vbCritical + vbYesNo) = vbYes then
    begin
      DM.ADODBConnect.Execute('UPDATE ' +
                                     'M ' +
                              'SET ' +
                                     'M.Desativado = 0 ' +
                              'FROM ' +
                                     'Model M ' +
                                     'JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup) ' +
                              'WHERE ' +
                                     'M.IDModelGroup = ' + quBrowseIDModelGroup.AsString);
    end;

end;

function TbrwModelGroup.ValidateRestoreItem: Boolean;
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
                       'Model M ' +
                       'JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup) ' +
                 'WHERE ' +
                       'M.IDModelGroup = ' + quBrowseIDModelGroup.AsString;
    Open;

    Result := IsEmpty;
  end;

end;

end.
