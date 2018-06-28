unit PaiDeFichasBrowse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, ComCtrls, FormConfig, Db, DBTables, LblEffct, ExtCtrls,
  StdCtrls, Buttons, ADODB, RCADOQuery, PowerADOQuery,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwFrmParentBrw = class(TbrwFrmParent)
    quBrowse: TPowerADOQuery;
    dsBrowse: TDataSource;
    pnlPPageControl: TPanel;
    PPageControl: TPageControl;
    tsBrowse: TTabSheet;
    LabelName: TLabel;
    pnlComand: TPanel;
    btAdd: TSpeedButton;
    btDetail: TSpeedButton;
    btRemove: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    btPreview: TSpeedButton;
    btExcel: TSpeedButton;
    Panel8: TPanel;
    Panel6: TPanel;
    pnlsdjhfksdhfjksdhf: TPanel;
    SD: TSaveDialog;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    GridPopupMenu: TcxGridPopupMenu;
    procedure PPageControlChange(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure dsBrowseStateChange(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btRemoveClick(Sender: TObject);
    procedure grdBrowseDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdBrowseDBFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure btPreviewClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure grdBrowseDBCustomization(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure BrowseOpen;
    procedure BrowseClose;
    procedure LoadFicha;

  public
    { Public declarations }
    
  protected
    brwForm       : TbrwFrmParent;
    AView         : TcxCustomGridTableView;
    fRegistryPath : String;
    AOptions      : TcxGridStorageOptions;

    procedure OnCreateFicha; virtual;
    procedure OnAfterLoadFch; virtual;
    procedure OnAddCustomBrowseFilter; virtual;
    procedure BrowseRefresh(sID: String);

    procedure LoadImages;

    procedure LoadGridFields;
    procedure SaveGridFields;

    //Replication controls
    procedure ReplicationControls; virtual;
  end;

implementation

{$R *.DFM}

uses uMsgBox, uMsgConstant, uSystemTypes, uDMGlobal, uFrmExport, uDM,
     cxStyleSheetEditor, cxLookAndFeels, uSystemConst;

procedure TbrwFrmParentBrw.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDetail.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_PREVIEW, btPreview.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
end;

procedure TbrwFrmParentBrw.ReplicationControls;
begin
  btAdd.Visible := not fIsRestricForm;
  btRemove.Visible := not fIsRestricForm;
end;

procedure TbrwFrmParentBrw.PPageControlChange(Sender: TObject);
begin
  inherited;
  if PPageControl.ActivePage = tsBrowse then
    BrowseOpen;
end;

procedure TbrwFrmParentBrw.BrowseOpen;
var
  i: integer;
begin
  with quBrowse do
    if not Active then
      begin
        ClearSuggest;
        // Carrego os parametros e seto o filterFields
        for i := 0 to Parameters.Count-1 do
          if quForm.FindField(Parameters.Items[i].Name) <> nil then
            begin
              Parameters.Items[i].Value := quForm.FieldByName(Parameters.Items[i].Name).Value;
              AddSuggest(Parameters.Items[i].Name, Parameters.Items[i].Value);
            end;

        // Permito que o usuario adicione novos filtros
        OnAddCustomBrowseFilter;

        // Abro
        Open;
      end;
end;

procedure TbrwFrmParentBrw.BrowseClose;
begin
  quBrowse.Close;
end;

procedure TbrwFrmParentBrw.BrowseRefresh(sID: String);
var
  sCurrentID, sNextID: String;
  bFound: boolean;
begin
  with quBrowse do
    begin
      Try
        DisableControls;

        sCurrentID := quBrowse.FieldByName(grdBrowseDB.DataController.KeyFieldNames).AsString;
        Next;
        sNextID    := quBrowse.FieldByName(grdBrowseDB.DataController.KeyFieldNames).AsString;
        Previous;

        BrowseClose;
        BrowseOpen;

        if sID <> '' then
          bFound := Locate(grdBrowseDB.DataController.KeyFieldNames, sID, [])
        else
          bFound := False;

        if (not bFound) and (sCurrentID <> '') then
          bFound := Locate(grdBrowseDB.DataController.KeyFieldNames, sCurrentID, []);

        if (not bFound) and (sNextID <> '') then
          bFound := Locate(grdBrowseDB.DataController.KeyFieldNames, sNextID, []);

      finally
        EnableControls;
      end;
    end;

end;

procedure TbrwFrmParentBrw.dsBrowseStateChange(Sender: TObject);
begin
  inherited;

  with quBrowse do
    begin
      btDetail.Enabled  := not IsEmpty;
      btRemove.Enabled  := not IsEmpty;
      btPreview.Enabled := not IsEmpty;
      btExcel.Enabled   := not IsEmpty;
    end;

end;

procedure TbrwFrmParentBrw.btAddClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  inherited;
  LoadFicha;

  if brwForm.Start(btInc, quBrowse, True, ID1, ID2, grdBrowse) then
    begin
      BrowseRefresh(ID1);
    end;
end;

procedure TbrwFrmParentBrw.btDetailClick(Sender: TObject);
var
  ID1, ID2: String;
begin
  inherited;

  LoadFicha;

  if brwForm.Start(btAlt, quBrowse, False, ID1, ID2, grdBrowse) then
    BrowseRefresh(ID1);

end;

procedure TbrwFrmParentBrw.btGroupClick(Sender: TObject);
begin
  inherited;
  if btGroup.Down then
    begin
      grdBrowseDB.OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowse do
        begin
          grdBrowseDB.OptionsView.GroupByBox := False;
          // Retiro todos os grupos
          while grdBrowseDB.GroupedItemCount > 0 do
            grdBrowseDB.GroupedColumns[grdBrowseDB.GroupedItemCount-1].GroupIndex :=-1;
        end;
    end;

end;

procedure TbrwFrmParentBrw.btColumnClick(Sender: TObject);
begin
  inherited;

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    grdBrowseDB.Controller.Customization := True
  else
    grdBrowseDB.Controller.Customization := False;

end;

procedure TbrwFrmParentBrw.FormDestroy(Sender: TObject);
begin
  inherited;
  with PPageControl do
    if PageCount = 1 then
      Pages[0].Parent := PPageControl;
end;

procedure TbrwFrmParentBrw.FormCreate(Sender: TObject);
begin
  inherited;

  LoadImages;

  with PPageControl do
    if PageCount=1 then
      begin
        PPageControl.Visible := False;
        Pages[0].Parent := pnlPPageControl;
      end;

  if PPageControl.ActivePage = tsBrowse then
     begin
     Case DM.fGrid.Kind of
       0 : grdBrowse.LookAndFeel.Kind := lfStandard;
       1 : grdBrowse.LookAndFeel.Kind := lfFlat;
       2 : grdBrowse.LookAndFeel.Kind := lfUltraFlat;
       end;
     if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fGrid.Layout<>-1)  then
        TcxGridDBTableView(grdBrowse.FocusedView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

     //Pega o Browser atual
     AView := TcxCustomGridTableView(grdBrowse.FocusedView);
     end;

  //Enable replication buttons
  ReplicationControls;

  //Load Grid Options
  LoadGridFields;

end;

procedure TbrwFrmParentBrw.LoadFicha;
begin

  if brwForm = nil then
    OnCreateFicha;

  OnAfterLoadFch;

end;

procedure TbrwFrmParentBrw.OnAfterLoadFch;
begin
  // Para ser sobre escrito
end;

procedure TbrwFrmParentBrw.OnCreateFicha;
begin
  // Para ser sobre escrito
end;

procedure TbrwFrmParentBrw.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if PPageControl.PageCount = 1 then
    BrowseOpen;
end;

procedure TbrwFrmParentBrw.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  BrowseClose;
end;

procedure TbrwFrmParentBrw.OnAddCustomBrowseFilter;
begin
  // Para ser herdado

end;

procedure TbrwFrmParentBrw.btExcelClick(Sender: TObject);
begin
  inherited;
 If (not quBrowse.Active) or
    (quBrowse.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;

 with TFrmExport.Create(Self) do
    Start(grdBrowse, lblSubMenu.Caption);
    
end;

procedure TbrwFrmParentBrw.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  //Shor Cuts
  case Key of

    VK_F2 : begin //Add New
            if btAdd.Enabled then
               btAddClick(nil);
            end;

    VK_F3 : begin //Edit
            if btDetail.Enabled then
               btDetailClick(nil);
            end;

    VK_F4 : begin //Del
            if btRemove.Enabled then
               btRemoveClick(nil);
            end;

    VK_F5 : begin //Preview
            if btPreview.Enabled then
               btPreviewClick(nil);
            end;

    VK_F6 : begin //SpreeadSheet
            if btExcel.Enabled then
               btExcelClick(nil);
            end;

   end;


end;

procedure TbrwFrmParentBrw.btRemoveClick(Sender: TObject);
begin
  inherited;
  //Nada
end;

procedure TbrwFrmParentBrw.grdBrowseDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  //Coloca o header para search
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TbrwFrmParentBrw.grdBrowseDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  //Coloca o item para search
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TbrwFrmParentBrw.btPreviewClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.Caption := lblSubMenu.Caption;
  gridPrinter.Preview(True, nil);
end;

procedure TbrwFrmParentBrw.grdBrowseDBDblClick(Sender: TObject);
begin
  inherited;
  if btDetail.Enabled then
     btDetailClick(nil);
end;

procedure TbrwFrmParentBrw.grdBrowseDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TbrwFrmParentBrw.LoadGridFields;
begin

  if not tsBrowse.TabVisible then
     Exit;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + 'BrwFch_' + lblSubMenu.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

end;

procedure TbrwFrmParentBrw.SaveGridFields;
begin

  if not tsBrowse.TabVisible then
     Exit;

  //Saval para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

end;

procedure TbrwFrmParentBrw.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Salva os campos para o registry
  SaveGridFields;
  inherited;
end;

end.
