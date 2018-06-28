unit uBrwSaleRequest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables,  Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwSaleRequest = class(TbrwParent)
    quBrowseIDRequest: TIntegerField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseDateRequest: TDateTimeField;
    quBrowseSystemUser: TStringField;
    scParent: TSuperComboADO;
    quBrowseAutomaticRequest: TBooleanField;
    btAutoReq: TSpeedButton;
    quBrowseIDModel: TIntegerField;
    Label1: TLabel;
    cxbFilterReq: TComboBox;
    Label2: TLabel;
    quBrowseIDVendor: TIntegerField;
    quBrowseGroupID: TIntegerField;
    quBrowseModelLastMovDate: TDateTimeField;
    quBrowseCategory: TStringField;
    quBrowseStore: TStringField;
    btOnlyOpen: TSpeedButton;
    Label7: TLabel;
    cmbStore: TSuperComboADO;
    btAreaTodas: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBDateRequest: TcxGridDBColumn;
    grdBrowseDBQtyReq: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBAutomaticRequest: TcxGridDBColumn;
    grdBrowseDBIDModel: TcxGridDBColumn;
    grdBrowseDBIDVendor: TcxGridDBColumn;
    grdBrowseDBGroupID: TcxGridDBColumn;
    grdBrowseDBModelLastMovDate: TcxGridDBColumn;
    grdBrowseDBTotQtyOnHand: TcxGridDBColumn;
    grdBrowseDBCategory: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBQtyOrdered: TcxGridDBColumn;
    btnForceRequest: TSpeedButton;
    grdBrowseDBIDRequest: TcxGridDBColumn;
    quBrowseQtyReq: TFloatField;
    quBrowseTotQtyOnHand: TFloatField;
    quBrowseIDManufacturer: TIntegerField;
    quBrowseManufacturer: TStringField;
    quBrowseVendor: TStringField;
    quBrowseClasseABC: TStringField;
    grdBrowseDBIDManufacturer: TcxGridDBColumn;
    grdBrowseDBManufacturer: TcxGridDBColumn;
    grdBrowseDBVendor: TcxGridDBColumn;
    grdBrowseDBClassABC: TcxGridDBColumn;
    quBrowseQtyOrdered: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAutoReqClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cxbFilterReqChange(Sender: TObject);
    procedure btOnlyOpenClick(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure btnForceRequestClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    sReqWithPO,
    sReqWithoutPO : String;

    procedure DeleteRequest(ID:Integer);
    procedure OnBeforeDeleteItem; override;
    procedure RefreshCombo;
    function ValidaCombo:Boolean;
    procedure AtualizaHint;
  end;

implementation

{$R *.DFM}

uses uFrmSaleRequest, uDM, uPassword, uMsgBox, uMsgConstant, uDateTimeFunctions,
     uDMGlobal, PaiDeTodos;

function TbrwsaleRequest.ValidaCombo:Boolean;
begin
  Result := True;

  case cxbFilterReq.ItemIndex of
    1: if scParent.LookUpValue = '' then
       begin
         scParent.SetFocus;
         MsgBox(MSG_CRT_NOT_EMPTY_USER, vbCritical + vbOkOnly);
         result := False;
         Exit;
       end;
    2: if scParent.LookUpValue = '' then
       begin
         scParent.SetFocus;
         MsgBox(MSG_CRT_NOT_EMPTY_CATEGORY, vbCritical + vbOkOnly);
         Result := False;
         Exit;
       end;
    3: if scParent.LookUpValue = '' then
       begin
         scParent.SetFocus;
         MsgBox(MSG_CRT_NOT_EMPTY_MANUF, vbCritical + vbOkOnly);
         Result := False;
         Exit;
       end;
  end;
end;

procedure TbrwSaleRequest.RefreshCombo;
begin
  scParent.Visible := True;
  scParent.LookUpValue := '';

  case cxbFilterReq.ItemIndex of
    0,4,5: scParent.Visible := False;
    1:begin
        scParent.LookUpSource := DM.dsLookUpUser;
        scParent.LookUpValue := IntToStr(DM.fUser.ID);
      end;
    2: scParent.LookUpSource := DM.dsLookUpGroup;
    3: scParent.LookUpSource := DM.dsLookUpFabricante;
  end;
end;

procedure TbrwSaleRequest.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm     := TbrwFrmRequest.Create(Self);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sReqWithPO    := 'Requests with PO';
      sReqWithoutPO := 'Requests without PO';
    end;

    LANG_PORTUGUESE:
    begin
      sReqWithPO    := 'Requisição com OC';
      sReqWithoutPO := 'Requisição sem OC';
    end;

    LANG_SPANISH :
    begin
      sReqWithPO    := 'Requer. com OC';
      sReqWithoutPO := 'Requer. sin OC';
    end;
  end;

  if fIsRestricForm then
  begin
    btAutoReq.Visible       := False;
    btnForceRequest.Visible := False;
  end;
end;

procedure TbrwSaleRequest.FormShow(Sender: TObject);
begin
  inherited;
  cxbFilterReq.Enabled := Password.HasFuncRight(1);

  if Password.HasFuncRight(1) then
  begin
    scParent.Color         := clWindow;
    scParent.ReadOnly      := False;
    cxbFilterReq.ItemIndex := 1;
  end
  else
  begin
    scParent.ParentColor   := True;
    scParent.ReadOnly      := True;
    cxbFilterReq.ItemIndex := 0;
  end;

  RefreshCombo;
  AtualizaHint;
end;

procedure TbrwSaleRequest.btAutoReqClick(Sender: TObject);
var
  ID: String;
begin
  inherited;
  if quBrowseIDModel.AsString = '' then
    Exit;

  DM.RunSQL('UPDATE Model SET AutomaticRequest = CASE AutomaticRequest WHEN 1 THEN 0 ELSE 1 END WHERE IDModel = ' + quBrowseIDModel.AsString);
  ID := quBrowseIDRequest.AsString;
  btnExecClick(Sender);
  //ExecBrowseSQL(True);
  quBrowse.Locate('IDRequest', ID, []);
end;

procedure TbrwSaleRequest.btnExecClick(Sender: TObject);
var
  stest, sWhere: String;
begin
  inherited;
  // Testa o super combo foi preenchido
  // e aplica o filtro no browse
  if not ValidaCombo then
     Exit;

  if cmbStore.LookUpValue = '' then
     sWhere := ' WHERE R.StoreID IN ('+ DM.fStore.StoreList +')'
  else
     sWhere := ' WHERE R.StoreID = ' + cmbStore.LookUpValue;

  case cxbFilterReq.ItemIndex of
    1: sWhere := sWhere + ' AND R.UserID = ' + scParent.LookUpValue;
    2: sWhere := sWhere + ' AND TG.IDGroup = ' + scParent.LookUpValue;
    3: sWhere := sWhere + ' AND M.IDFabricante = ' + scParent.LookUpValue;
    4: sWhere := sWhere + ' AND R.Type = '+ QuotedStr('C');
    5: sWhere := sWhere + ' AND R.Type = '+ QuotedStr('H');
  end;

  sWhere := sWhere + ' AND R.DateRequest >= ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) ) + ' AND ' +
                     ' R.DateRequest < '+ QuotedStr( FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) );

  if not btOnlyOpen.Down then
    sWhere := sWhere + ' AND R.QtyOrdered > 0'
    //sWhere := sWhere + ' AND IsNull(R.QtyOrdered,0) > 0';
  else
    sWhere := sWhere + ' AND ((R.QtyOrdered is Null) or (R.QtyOrdered = 0)) ';


  with quBrowse do
  try
    Close;
    DisableControls;
    CommandText := 'SELECT '+
                        ' R.IDRequest, '+
                        ' R.DateRequest,'+
                        ' R.QtyReq, '+
                        ' IsNull(PO.QtyOnOrder,0) as QtyOrdered,  '+
                        ' R.Description, '+
                        ' U.SystemUser, '+
                        ' M.Model, '+
                        ' M.IDFabricante as IDManufacturer,  '+
                        ' F.Pessoa as Manufacturer, '+
                        ' MV.IDPessoa as IDVendor,'+
                        ' V.Pessoa as Vendor, '+
                        ' M.GroupID, '+
                        ' M.AutomaticRequest, '+
                        ' M.IDModel,'+
                        ' M.LastMovDate as ModelLastMovDate, '+
                        ' M.TotQtyOnHand, '+
                        ' M.ClasseABC, '+
                        ' TG.Name as Category,'+
                        ' S.Name as Store '+
                        'FROM '+
                        ' Request R  (NOLOCK) '+
                        ' JOIN SystemUser U (NOLOCK) ON (R.UserID = U.IDUser) '+
                        ' JOIN Store S (NOLOCK) ON (S.IDStore = R.StoreID) '+
                        ' LEFT OUTER JOIN Model M (NOLOCK) ON (R.ModelID = M.IDModel)'+
                        ' LEFT OUTER JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'+
                        ' LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa) '+
                        ' LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND MV.VendorOrder = 1) '+
                        ' LEFT OUTER JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa) '+
                        ' LEFT JOIN (SELECT '+
                        '	           PIM.ModelID, '+
                        '	           PIM.StoreID, '+
                        '	           SUM(PIM.Qty - QtyRealMov) as QtyOnOrder '+
                        '            FROM  '+
                        '	           PreInventoryMov PIM (NOLOCK) '+
                        '	           JOIN PO (NOLOCK) ON (PIM.DocumentID = PO.IDPO) '+
                        '            WHERE '+
                        '	           PIM.InventMovTypeID = 2 '+
                        '	           AND '+
                        '	           PO.Aberto = 1 '+
                        '            GROUP BY '+
                        '	           PIM.ModelID, '+
                        '	           PIM.StoreID '+
                        '            ) PO ON (PO.ModelID = M.IDModel AND PO.StoreID = R.StoreID) '+ sWhere;
    Open;
  finally;
    EnableControls;
    DesativaAviso;
  end;
end;

procedure TbrwSaleRequest.cxbFilterReqChange(Sender: TObject);
begin
  inherited;
  RefreshCombo;

  //Pisca btn GO
  AtivaAviso;
end;

procedure TbrwSaleRequest.btOnlyOpenClick(Sender: TObject);
begin
  inherited;
  if btOnlyOpen.Down then
    btOnlyOpen.Caption := sReqWithoutPO
  else
    btOnlyOpen.Caption := sReqWithPO;

  AtualizaHint;  
  AtivaAviso;
end;

procedure TbrwSaleRequest.OnBeforeDeleteItem;
begin
  DM.RunSQL('DELETE POItemRequest WHERE IDRequest = ' + quBrowseIDRequest.AsString);
end;

procedure TbrwSaleRequest.DateInicioChange(Sender: TObject);
begin
  inherited;
  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
    AtivaAviso;
end;

procedure TbrwSaleRequest.btAreaTodasClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;
end;

procedure TbrwSaleRequest.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwSaleRequest.btnForceRequestClick(Sender: TObject);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    DM.RunSQL('EXEC sp_PO_CalcOrderPointSimple');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TbrwSaleRequest.DeleteRequest(ID: Integer);
begin
  if ID <> 0 then
    DM.RunSQL('DELETE Request WHERE IDRequest = ' + IntToStr(ID));
end;

procedure TbrwSaleRequest.btRemoveClick(Sender: TObject);
begin
  inherited;
  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
    if quBrowse.Active and (not quBrowse.IsEmpty) then
    begin
      DeleteRequest(quBrowseIDRequest.AsInteger);
      btnExecClick(Sender);
    end;
end;

procedure TbrwSaleRequest.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_F4 then
    begin
      if not quBrowse.IsEmpty then
        if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
          if quBrowse.Active and (not quBrowse.IsEmpty) then
          begin
            DeleteRequest(quBrowseIDRequest.AsInteger);
            btnExecClick(Sender);
          end;
    end
    else
      inherited;
end;

procedure TbrwSaleRequest.AtualizaHint;
begin
  if btOnlyOpen.Down then
  begin
    Case DMGlobal.IDLanguage of
         LANG_ENGLISH :
               btOnlyOpen.Hint := ' Click here to filter request items not currently on PO ';

         LANG_PORTUGUESE :
               btOnlyOpen.Hint := ' Clique aqui para filtrar itens requeridos incluidos em pedidos';

         LANG_SPANISH :
               btOnlyOpen.Hint := ' Chascar aquí para filtrar artículos de la petición no no actualmente en el OC ';
    end;
  end
  else
  begin
    Case DMGlobal.IDLanguage of
         LANG_ENGLISH :
               btOnlyOpen.Hint := ' Click here to filter request items currently on PO ';

         LANG_PORTUGUESE :
               btOnlyOpen.Hint := ' Clique aqui para filtrar itens requeridos não incluidos em pedidos';

         LANG_SPANISH :
               btOnlyOpen.Hint := ' Chascar aquí para filtrar artículos de la petición actualmente en el PO ';
    end;
  end;
end;

end.
