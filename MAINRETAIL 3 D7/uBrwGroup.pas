unit ubrwGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, ImgList, ExtCtrls,
  BrowseConfig, Menus, Db, ADODB, RCADOQuery, PowerADOQuery, PanelRights,
  StdCtrls, Mask, DateBox, LblEffct, Buttons, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu, uBrwModelGroup;

type
  TbrwGroup = class(TbrwParent)
    quBrowseIDGroup: TAutoIncField;
    quBrowseName: TStringField;
    quBrowseSerialNumber: TBooleanField;
    quBrowseSizeAndColor: TBooleanField;
    grdBrowseDBIDGroup: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBSerialNumber: TcxGridDBColumn;
    grdBrowseDBSizeAndColor: TcxGridDBColumn;
    quBrowsePackModel: TBooleanField;
    grdBrowseDBPackModel: TcxGridDBColumn;
    quBrowseService: TBooleanField;
    quBrowseCredit: TBooleanField;
    grdBrowseDBService: TcxGridDBColumn;
    grdBrowseDBCredit: TcxGridDBColumn;
    quBrowseUserCode: TStringField;
    grdBrowseDBUserCode: TcxGridDBColumn;
    Panel4: TPanel;
    btnSubGroup: TSpeedButton;
    quBrowseTaxable: TBooleanField;
    quBrowsePuppyTracker: TBooleanField;
    quBrowseRequestCustomer: TBooleanField;
    grdBrowseDBPuppyTracker: TcxGridDBColumn;
    grdBrowseDBRequestCustomer: TcxGridDBColumn;
    quBrowseGiftCard: TBooleanField;
    grdBrowseDBGiftCard: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnSubGroupClick(Sender: TObject);
  private
    sSubGroup : String;
    function ValidateRestoreItem:Boolean;

  protected
    procedure LoadImages; override;
    procedure OnAfterDeleteItem; override;
    procedure OnAfterRestoreItem; override;
    
    function ValidateDeleteItem:Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmGroup, uDMGlobal, uDM, uSystemConst, uFrmMarginTable, uMsgBox, uMsgConstant;

procedure TbrwGroup.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TBrwFrmGroup.Create(self);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sSubGroup := 'Group';
           sUrlHelp  := '';
           sUrlVideo := '';
           end;

     LANG_PORTUGUESE :
           begin
           sSubGroup := 'Grupo';
           sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Categoria.htm';
           sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Categoria/Adicionar_Categoria.html';
           end;

     LANG_SPANISH :
           begin
           sSubGroup := 'Grupo';
           sUrlHelp  := '';
           sUrlVideo := '';
           end;
   end;

   grdBrowseDBPuppyTracker.Hidden := ((DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION]='') or
                                     (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION]=''));

end;

procedure TbrwGroup.btnSubGroupClick(Sender: TObject);
var
  sMenu : String;
begin
  inherited;

  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := sSubGroup + ' - ' + quBrowseName.AsString;
  try
     with TBrwModelGroup.Create(Self) do
        begin
        sParam := sParam + 'IDGroup='+quBrowseIDGroup.AsString+';';
        Start;
        end;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;

end;

procedure TbrwGroup.LoadImages;
begin
  inherited;
  DM.imgSubMenu.GetBitmap(29, btnSubGroup.Glyph);
end;

procedure TbrwGroup.OnAfterDeleteItem;
begin
  inherited;
  DM.ADODBConnect.Execute('UPDATE ModelGroup SET Desativado = 1 WHERE IDGroup = ' + quBrowseIDGroup.AsString);

  DM.ADODBConnect.Execute('UPDATE ' +
                                 'MSG ' +
                          'SET ' +
                                 'MSG.Desativado = 1 ' +
                          'FROM ' +
                                 'ModelSubGroup MSG ' +
                                 'JOIN ModelGroup MG ON (MSG.IDModelGroup = MG.IDModelGroup) ' +
                          'WHERE ' +
                                 'MG.IDGroup = ' + quBrowseIDGroup.AsString);

  DM.ADODBConnect.Execute('UPDATE ' +
                                 'M ' +
                          'SET ' +
                                 'M.Desativado = 1 ' +
                          'FROM ' +
                                 'Model M ' +
                                 'JOIN TabGroup TG ON (M.GroupID = TG.IDgroup) ' +
                          'WHERE ' +
                                 'M.GroupID = ' + quBrowseIDGroup.AsString);
end;

function TbrwGroup.ValidateDeleteItem: Boolean;
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
                       'JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) ' +
                 'WHERE ' +
                       'M.GroupID = ' + quBrowseIDGroup.AsString +
                       ' AND ' +
                       'M.TotQtyOnHand > 0';
    Open;

    if IsEmpty then
      Result := True
    else
    begin
      Result := False;
      MsgBox(MSQ_QST_DELETE_CAT_REL, vbCritical + vbOKOnly);
    end;
  end;

end;

procedure TbrwGroup.OnAfterRestoreItem;
begin
  inherited;
  DM.ADODBConnect.Execute('UPDATE ModelGroup SET Desativado = 0 WHERE IDGroup = ' + quBrowseIDGroup.AsString);

  DM.ADODBConnect.Execute('UPDATE ' +
                                 'MSG ' +
                          'SET ' +
                                 'MSG.Desativado = 0 ' +
                          'FROM ' +
                                 'ModelSubGroup MSG (NOLOCK) ' +
                                 'JOIN ModelGroup MG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGroup) ' +
                          'WHERE ' +
                                 'MG.IDGroup = ' + quBrowseIDGroup.AsString);

  if not ValidateRestoreItem then
    if MsgBox(MSQ_QST_RETORE_CAT_SUBCAT_GROUP, vbCritical + vbYesNo) = vbYes then
    begin
      DM.ADODBConnect.Execute('UPDATE ' +
                                     'M ' +
                              'SET ' +
                                     'M.Desativado = 0 ' +
                              'FROM ' +
                                     'Model M (NOLOCK) ' +
                                     'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDgroup) ' +
                              'WHERE ' +
                                     'M.GroupID = ' + quBrowseIDGroup.AsString);
    end;
    
end;

function TbrwGroup.ValidateRestoreItem: Boolean;
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
                       'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
                 'WHERE ' +
                       'M.GroupID = ' + quBrowseIDGroup.AsString;
    Open;

    Result := IsEmpty;
  end;

end;

end.
