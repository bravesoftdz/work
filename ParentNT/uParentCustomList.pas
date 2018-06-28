unit uParentCustomList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, mrConfigList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, DBClient, Buttons, uNTDataSetControl,
  cxGridDBDataDefinitions, uNTTraceControl, uNTUpdateControl, StdCtrls,
  XiButton, ImgList, uUserObj, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk;

const

  BTN_LIST_ACTIVE   = 0;
  BTN_LIST_TRASH    = 1;
  BTN_LIST_REFRESH  = 2;
  BTN_LIST_COLUMN   = 3;
  BTN_LIST_DELETE   = 4;
  BTN_LIST_GROUP    = 5;
  BTN_LIST_OPEN     = 6;
  BTN_LIST_PRINT    = 7;
  BTN_LIST_RESTORE  = 8;
  BTN_LIST_SAVE     = 9;
  BTN_LIST_NEW      = 10;
  BTN_LIST_EXCEL    = 11;
  BTN_LIST_TEXT     = 12;
  BTN_LIST_XML      = 13;
  BTN_LIST_HTML     = 14;
  BTN_LIST_DETAIL   = 15;
  BTN_LIST_EXPORT   = 16;
  BTN_LIST_SALELIST = 17;

type
  TParentCustomList = class(TParentForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    pnlClient: TPanel;
    grdListDBTableView: TcxGridDBTableView;
    grdListLevel: TcxGridLevel;
    grdList: TcxGrid;
    dsList: TDataSource;
    pnlImage: TPanel;
    pnlFilter: TPanel;
    pnlRefresh: TPanel;
    tmList: TTimer;
    ConfigList: TmrConfigList;
    btnRefresh: TXiButton;
    imgBrowser: TImageList;
    SD: TSaveDialog;
    gridPrinter: TdxComponentPrinter;
    cxStyleRepository: TcxStyleRepository;
    styHeader: TcxStyle;
    styBackGround: TcxStyle;
    stySelection: TcxStyle;
    gridPrinterLink: TdxGridReportLink;
    procedure grdListDBTableViewDblClick(Sender: TObject);
    procedure ConfigListCanPriorRecord(Sender: TObject;
      var CanNavigate: Boolean);
    procedure ConfigListCanNextRecord(Sender: TObject;
      var CanNavigate: Boolean);
    procedure ConfigListPriorRecord(Sender: TObject);
    procedure ConfigListNextRecord(Sender: TObject);
    procedure ConfigListLastRecord(Sender: TObject);
    procedure ConfigListFirstRecord(Sender: TObject);
    procedure tmListTimer(Sender: TObject);
    procedure dsListStateChange(Sender: TObject);
    procedure OnInsertClick(Sender: TObject);
    procedure OnOpenClick(Sender: TObject);
    procedure OnDeleteClick(Sender: TObject);
    procedure OnRestoreClick(Sender: TObject);
    procedure OnGroupClick(Sender: TObject);
    procedure OnColumnClick(Sender: TObject);
    procedure OnPrintClick(Sender: TObject);
    procedure OnClassificationChange(Sender: TObject);
    procedure OnExportToTextClick(Sender: TObject);
    procedure OnExportToHTMLClick(Sender: TObject);
    procedure OnExportToExcelClick(Sender: TObject);
    procedure OnExportToXMLClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure ConfigListAfterStart(Sender: TObject);
    procedure grdListDBTableViewColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdListDBTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FFormFch: TForm;
    FParams: String;
    FOwnerSession: Boolean;
    FTraceControl: TmrTraceControl;
    FDataSetControl: TmrDataSetControl;
    FUpdateControl: TmrUpdateControl;
    FSession: TmrSession;
    FDataSet: TClientDataSet;
    FForeignField: String;
    FOnStateChange: TNotifyEvent;
    FFilterText: String;
    FColumnRegistryPath: String;
    FGridOptions: TcxGridStorageOptions;
    procedure SetGridColumns;
    procedure SetGridKeys;
    procedure SetTopLayout;
    procedure CreateFch;
    procedure AlertOff;
    procedure OnBeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure CreateGridItem(AGridView: TcxGridDBTableView; AField : TField; AHidden : Boolean);
    function GetProviderName: String;
    property FormFch: TForm read FFormFch write FFormFch;
    procedure RestoreGridColumns;
    procedure StoreGridColumns;
    function FormRestricted : Boolean;
  protected
    FTrash: Boolean;
    AView : TcxCustomGridTableView;
    FSystemUser : TUser;
    procedure AlertOn;
    procedure SetCommandOptionsVisibility; virtual; abstract;
    procedure DoShowList; virtual; abstract;
    procedure CreateCommandControls; virtual; abstract;
    procedure LoadImages; virtual;
    procedure AfterClassicationChange; virtual;
    procedure RestrictForm; virtual;
  public
    destructor Destroy; override;
    procedure Init(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser; AParams: String);
    procedure ShowList;
    procedure InsertRecord(AParams: String = '');
    procedure OpenRecord(AParams: String = '');
    procedure DeleteRecord(AParams: String = '');
    procedure RestoreRecord(AParams: String = '');
    procedure RefreshDataSet;
    property TraceControl: TmrTraceControl read FTraceControl;
    property DataSetControl: TmrDataSetControl read FDataSetControl;
    property UpdateControl: TmrUpdateControl read FUpdateControl;
    property Params: String read FParams write FParams;
    property OwnerSession: Boolean read FOwnerSession write FOwnerSession;
    property Session: TmrSession read FSession write FSession;
    property DataSet: TClientDataSet read FDataSet write FDataSet;
    property ForeignField: String read FForeignField write FForeignField;
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
    property FilterText: String read FFilterText write FFilterText;
  end;

implementation

uses uParentCustomFch, uClasseFunctions, mrMsgBox, uMRSQLParam, uMRParam, dxBar,
     uSystemConst, cxExportGrid4Link, uParamFunctions, Math;

{$R *.dfm}

procedure TParentCustomList.Init(ATraceControl: TmrTraceControl;
  ADataSetControl: TmrDataSetControl; AUpdateControl: TmrUpdateControl; ASession: TmrSession;
  ASystemUser : TUser; AParams: String);
begin

  FTraceControl := ATraceControl;
  FDataSetControl := ADataSetControl;
  FUpdateControl := AUpdateControl;
  FSystemUser := ASystemUser;

  LoadImages;

  try

    FTraceControl.TraceIn('TParentCustomList.Init');

    FTrash := False;
    FParams := AParams;

    Self.Caption := ParseParam(Params, 'MenuDisplay');

    //Criacao da sessinon caso necessario
    FOwnerSession := ASession = nil;
    if OwnerSession then
      Session := FDataSetControl.CreateSession
    else
      Session := ASession;

    //Seta o ClientDataSet
    DataSet := Session.CreateDataSet(ConfigList.Connection, GetProviderName);

    if Assigned(ConfigList.OnBeforeStart) then
      ConfigList.OnBeforeStart(Self);

    dsList.DataSet := DataSet;

    //Seto PacketRecords=0 para abrir o sem dar o fetch.
    //E preciso carregar os fields (MetaData) para configurar a grid.
    //Depois e preciso setar a PacketRecords=-1 para abrir dando o fetch.
    DataSet.PacketRecords := 0;
    try
      RefreshDataSet;
      if ConfigList.AutCreateGridColumns then
        SetGridColumns;

      SetGridKeys;
      SetTopLayout;
      CreateCommandControls;

      //Para ser herdado
      SetCommandOptionsVisibility;

      //Pontera o ClientDataSet para utilizar o filtro do list
      DataSet.BeforeGetRecords := OnBeforeGetRecords;
    finally
      DataSet.PacketRecords := -1;
    end;

    if FormRestricted then
      RestrictForm;

    if Assigned(ConfigList.OnAfterStart) then
      ConfigList.OnAfterStart(Self);

    FTraceControl.TraceOut;

  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

procedure TParentCustomList.btnRefreshClick(Sender: TObject);
var
  TestFilter: Boolean;
begin
  inherited;
  TestFilter := True;

  if Assigned(ConfigList.OnTestFilter) then
    ConfigList.OnTestFilter(Sender, TestFilter);

  if TestFilter then
  begin
    RefreshDataSet;
    if Assigned(ConfigList.OnGetFilterText) then
      FilterText := ConfigList.OnGetFilterText(Sender);
    AlertOff;
  end;
end;

procedure TParentCustomList.RefreshDataSet;
begin

  FTraceControl.TraceIn('TParentCustomList.RefreshDataSet');

  try
    with DataSet do
    begin
      if Active then
        Close;
      Open;
    end;

    if Assigned(ConfigList.OnAfterRefresh) then
      ConfigList.OnAfterRefresh(Self);

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomList.SetGridColumns;
var
  i: Integer;
  slHiddenFields : TStringList;
  bHidden : Boolean;
begin
  with DataSet do
  try
    slHiddenFields := TStringList.Create;
    slHiddenFields.Delimiter := ';';
    slHiddenFields.DelimitedText := GetOptionalParam('HiddenFields');
    for i := 0 to Fields.Count-1 do
      if Fields[i].Visible then
      begin
        bHidden := (slHiddenFields.IndexOf(Fields[i].FieldName) <> -1);
        CreateGridItem(grdListDBTableView, Fields[i], bHidden);
      end;
  finally
    FreeAndNil(slHiddenFields);
  end;
end;

procedure TParentCustomList.ShowList;
begin

  FTraceControl.TraceIn('TParentCustomList.ShowList');
  try
    if (DataSet.ChangeCount = 0) and (ConfigList.AutoOpen) then
      RefreshDataSet;

    DoShowList;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;

end;

procedure TParentCustomList.SetTopLayout;
var
  iImageHeight,
  iFilterHeight : Integer;
begin

  pnlFilter.Visible := pnlFilter.ControlCount > 1;
  pnlTop.Visible := pnlImage.Visible or pnlFilter.Visible;

  //Salvar o tamanho dos panels antes de setar o pnlTop para 0
  iImageHeight  := pnlImage.Height;
  iFilterHeight := pnlFilter.Height;
  pnlTop.Height := 0;

  if pnlImage.Visible then
    pnlTop.Height := iImageHeight;

  if pnlFilter.Visible then
    pnlTop.Height := pnlTop.Height + iFilterHeight;

end;

procedure TParentCustomList.OnBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Filter: TMRSQLParam;
begin
  FTraceControl.TraceIn('TParentCustomList.OnBeforeGetRecords');

  try
    Filter := TMRSQLParam.Create;

    if Assigned(ConfigList.OnGetFilter) then
      ConfigList.OnGetFilter(Self, Filter);

    OwnerData := Filter.ParamString;
  finally
    FreeAndNil(Filter);
  end;

  FTraceControl.TraceOut;
end;

destructor TParentCustomList.Destroy;
begin
  FTraceControl.TraceIn('TParentCustomList.Destroy');

  if FFormFch <> nil then
    FreeAndNil(FFormFch);
  if OwnerSession then
    Session.Terminate;
  inherited Destroy;

  FTraceControl.TraceOut;
end;

procedure TParentCustomList.CreateFch;
begin
  FTraceControl.TraceIn('TParentCustomList.CreateFch');

  FFormFch := CreateForm(Self, ConfigList.FchClassName);

  if FormFch = nil then
    raise Exception.Create('Error creating fch!');

  with TParentCustomFch(FFormFch) do
  begin
    Init(FTraceControl, FDataSetControl, FUpdateControl, Self.Session, Self.DataSet, Self.FSystemUser, Self.Params);
    OnFirstRecord := ConfigList.OnFirstRecord;
    OnPriorRecord := ConfigList.OnPriorRecord;
    OnNextRecord := ConfigList.OnNextRecord;
    OnLastRecord := ConfigList.OnLastRecord;
    OnCanPriorRecord := ConfigList.OnCanPriorRecord;
    OnCanNextRecord := ConfigList.OnCanNextRecord;
    OnGetForeignKeyValue := ConfigList.OnGetForeignKeyValue;
    OnGetTransaction := ConfigList.OnGetTransaction;
  end;

  FTraceControl.TraceOut;
end;

procedure TParentCustomList.OpenRecord(AParams: String);
begin

  FTraceControl.TraceIn('TParentCustomList.OpenRecord');

  try
    if FFormFch = nil then
      CreateFch;

    with TParentCustomFch(FFormFch) do
    begin
      Open(AParams);
      try
        grdListDBTableView.OptionsSelection.MultiSelect := False;
        ShowFch;
      finally
        grdListDBTableView.OptionsSelection.MultiSelect := True;
        end;
    end;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomList.DeleteRecord(AParams: String);
var
  I: Integer;
  Transaction: TmrTransaction;
  bCanDelete, OwnerTransaction: Boolean;
  LogicalDeleteField: String;
begin

  FTraceControl.TraceIn('TParentCustomList.DeleteRecord');

  try
    bCanDelete := True;
    LogicalDeleteField := DataSet.GetOptionalParam('LogicalDeleteField');

    if Assigned(ConfigList.OnBeforeDeleteRecord) then
      ConfigList.OnBeforeDeleteRecord(Self, bCanDelete);

    if bCanDelete then
      if MsgBox('Delete ' + IntToStr(grdListDBTableView.Controller.SelectedRowCount) + ' line(s)?',
           vbQuestion + vbYesNo) = vbYes then
      begin
        if Assigned(FOnStateChange) then
          OnStateChange(grdList);

        Transaction := nil;
        if Assigned(ConfigList.OnGetTransaction) then
          ConfigList.OnGetTransaction(Self, Transaction);
        OwnerTransaction := Transaction = nil;
        if OwnerTransaction then
          Transaction := FUpdateControl.CreateTransaction;


        for I := 0 to grdListDBTableView.Controller.SelectedRowCount-1 do
        begin
          //DataSet.Bookmark := grdListDBTableView.DataController.GetSelectedBookmark(I);
          DataSet.RecNo := grdListDBTableView.Controller.SelectedRecords[i].RecordIndex+1;
          //DataSet.Bookmark := TcxCustomGridTableView(grdList.FocusedView).Controller.SelectedRecords[].
          //DataSet.Bookmark := grdListDBTableView.Controller.SelectedRecords[i];

          if (LogicalDeleteField <> '') and (not FTrash) then
          begin
            DataSet.Edit;
            DataSet.FieldByName(LogicalDeleteField).AsBoolean := True;
            DataSet.Post;
          end
          else
            DataSet.Delete;
        end;

        Transaction.PostUpdate(DataSet);
        if OwnerTransaction then
          if Transaction.CommitTransaction then
          begin
            Transaction := nil;
            RefreshDataSet;
          end
          else
          begin
            Transaction.RollBackTransaction;
            Transaction := nil;
            RefreshDataSet;
          end;
      end;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomList.InsertRecord(AParams: String);
begin

  FTraceControl.TraceIn('TParentCustomList.InsertRecord');

  try
    if FFormFch = nil then
      CreateFch;

    with TParentCustomFch(FFormFch) do
    begin
      Append(AParams);
      ShowFch;
    end;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomList.RestoreRecord(AParams: String);
var
  I: Integer;
  Transaction: TmrTransaction;
  OwnerTransaction: Boolean;
  LogicalDeleteField: String;
begin

  FTraceControl.TraceIn('TParentCustomList.RestoreRecord');

  try
    LogicalDeleteField := DataSet.GetOptionalParam('LogicalDeleteField');

    if MsgBox('Restore ' + IntToStr(grdListDBTableView.Controller.SelectedRowCount) + ' lines(s)?',
         vbQuestion + vbYesNo) = vbYes then
    begin
      if Assigned(FOnStateChange) then
        OnStateChange(grdList);

      Transaction := nil;
      if Assigned(ConfigList.OnGetTransaction) then
        ConfigList.OnGetTransaction(Self, Transaction);
      OwnerTransaction := Transaction = nil;
      if OwnerTransaction then
        Transaction := FUpdateControl.CreateTransaction;

      for I := 0 to grdListDBTableView.Controller.SelectedRowCount-1 do
      begin
        DataSet.RecNo := grdListDBTableView.Controller.SelectedRecords[i].RecordIndex+1;

        DataSet.Edit;
        DataSet.FieldByName(LogicalDeleteField).AsBoolean := False;
        DataSet.Post;
      end;

      Transaction.PostUpdate(DataSet);
      if OwnerTransaction then
        if Transaction.CommitTransaction then
        begin
          Transaction := nil;
          RefreshDataSet;
        end
        else
        begin
          Transaction.RollBackTransaction;
          Transaction := nil;
          RefreshDataSet;
        end;
    end;

    FTraceControl.TraceOut;
  except
     on E: Exception do
       FTraceControl.SaveTrace(FSystemUser.ID, E.Message, Self.ClassName);
   end;
    
end;

procedure TParentCustomList.OnInsertClick(Sender: TObject);
var
  sParams: String;
begin
  if Assigned(ConfigList.OnGetParams) then
    ConfigList.OnGetParams(Self, sParams);

  if sParams = '' then
    sParams := Params;

  InsertRecord(sParams);
end;

procedure TParentCustomList.OnOpenClick(Sender: TObject);
var
  sParams: String;
begin
  if not DataSet.IsEmpty then
  begin
    if Assigned(ConfigList.OnGetParams) then
      ConfigList.OnGetParams(Self, sParams);

    if sParams = '' then
      sParams := Params;

    OpenRecord(sParams);
  end;
end;

procedure TParentCustomList.OnRestoreClick(Sender: TObject);
begin
  if not DataSet.IsEmpty then
    RestoreRecord;
end;

procedure TParentCustomList.OnDeleteClick(Sender: TObject);
begin
  if not DataSet.IsEmpty then
    DeleteRecord;
end;

procedure TParentCustomList.CreateGridItem(AGridView: TcxGridDBTableView;
  AField : TField; AHidden : Boolean);
var
  NewColumn: TcxGridColumn;
begin
  NewColumn := AGridView.CreateColumn;
  NewColumn.Visible := not AHidden;
  NewColumn.Caption := AField.DisplayLabel;
  NewColumn.Name := AGridView.Name + AField.FieldName;
  (NewColumn.DataBinding as TcxGridItemDBDataBinding).FieldName := AField.FieldName;

  if ConfigList.PreviewGridField = AField.FieldName then
    AGridView.Preview.Column := NewColumn;
end;

procedure TParentCustomList.OnExportToTextClick(Sender: TObject);
begin
  with SD do
  begin
    DefaultExt := 'txt';
    Filter     := 'Text document (*.txt)|*.txt';
    FileName   := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date)+'.txt';
    if Execute then
      ExportGrid4ToText(FileName, grdList, True, True, '','','');
  end;
end;

procedure TParentCustomList.OnExportToExcelClick(Sender: TObject);
begin
  with SD do
  begin
    DefaultExt := 'xls';
    Filter     := 'Microsoft Excel (*.xls)|*.xls';
    FileName   := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date)+'.xls';
    if Execute then
      ExportGrid4ToExcel(FileName, grdList, True, True, true);
  end;
end;

procedure TParentCustomList.OnExportToHTMLClick(Sender: TObject);
begin
  with SD do
  begin
    DefaultExt := 'htm';
    Filter     := 'HTML File (*.htm; *.html)|*.htm';
    FileName   := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date)+'.htm';
    if Execute then
      ExportGrid4ToHTML(FileName, grdList, True, True);
  end;
end;

procedure TParentCustomList.OnExportToXMLClick(Sender: TObject);
begin
  with SD do
  begin
    DefaultExt := 'xml';
    Filter     := 'XML File (*.xml)|*.xml';
    FileName   := Self.Caption + ' in ' + FormatDateTime('dd-mm-yy', Date)+'.xml';
    if Execute then
      ExportGrid4ToXML(FileName, grdList, True, True);
  end;
end;

procedure TParentCustomList.dsListStateChange(Sender: TObject);
begin
  inherited;
  if dsList.State in dsEditModes then
    if Assigned(FOnStateChange) then
      OnStateChange(Sender);
end;

procedure TParentCustomList.OnGroupClick(Sender: TObject);
begin
  if not TcxGridDBTableView(AView).OptionsView.GroupByBox then
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True
  else
  begin
    with grdList do
    begin
      while TcxGridDBTableView(AView).GroupedItemCount > 0 do
        TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex := -1;
      TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
    end;
  end;
end;

procedure TParentCustomList.OnClassificationChange(Sender: TObject);
begin
  FTrash := not FTrash;
  AfterClassicationChange;
end;

procedure TParentCustomList.OnPrintClick(Sender: TObject);
begin
  gridPrinterLink.Caption := self.Caption;
  gridPrinter.Preview(True, nil);
end;

function TParentCustomList.GetProviderName: String;
begin
  if Assigned(ConfigList.OnGetProviderName) then
    Result := ConfigList.OnGetProviderName(Self)
  else
    Result := ConfigList.ProviderName;
end;

procedure TParentCustomList.tmListTimer(Sender: TObject);
begin
  inherited;
  if pnlRefresh.ParentColor then
    pnlRefresh.Color := clGreen
  else
    pnlRefresh.ParentColor := True;
end;

procedure TParentCustomList.AlertOff;
begin
  tmList.Enabled := False;
  pnlRefresh.ParentColor := True;
end;

procedure TParentCustomList.AlertOn;
begin
  tmList.Enabled := True;
end;

procedure TParentCustomList.ConfigListFirstRecord(Sender: TObject);
begin
  inherited;
  grdListDBTableView.DataController.GotoFirst;
end;

procedure TParentCustomList.ConfigListLastRecord(Sender: TObject);
begin
  inherited;
  grdListDBTableView.DataController.GotoLast;
end;

procedure TParentCustomList.ConfigListNextRecord(Sender: TObject);
begin
  inherited;
  grdListDBTableView.DataController.GotoNext;
end;

procedure TParentCustomList.ConfigListPriorRecord(Sender: TObject);
begin
  inherited;
  grdListDBTableView.DataController.GotoPrev;
end;

procedure TParentCustomList.ConfigListCanNextRecord(Sender: TObject;
  var CanNavigate: Boolean);
begin
  inherited;
  try
    CanNavigate := not grdListDBTableView.Controller.FocusedRow.IsLast;
  except
    CanNavigate := False;
  end;
end;

procedure TParentCustomList.ConfigListCanPriorRecord(Sender: TObject;
  var CanNavigate: Boolean);
begin
  inherited;
  try
    CanNavigate := grdListDBTableView.Controller.FocusedRow.Index <> 0;
  except
    CanNavigate := False;
  end;
end;

procedure TParentCustomList.grdListDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  OnOpenClick(Sender);
end;

procedure TParentCustomList.OnColumnClick(Sender: TObject);
begin
  TcxGridDBTableView(AView).Controller.Customization := not
      TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TParentCustomList.LoadImages;
begin
  imgBrowser.GetBitmap(BTN_LIST_REFRESH, btnRefresh.Glyph);
end;

procedure TParentCustomList.RestoreGridColumns;
begin
  TcxGridDBTableView(AView).RestoreFromRegistry(FColumnRegistryPath, False, False, FGridOptions);
end;

procedure TParentCustomList.StoreGridColumns;
begin
  TcxGridDBTableView(AView).StoreToRegistry(FColumnRegistryPath, True, FGridOptions);
end;

procedure TParentCustomList.ConfigListAfterStart(Sender: TObject);
begin
  inherited;
  AView := TcxCustomGridTableView(grdList.FocusedView);
  if Assigned(Parent) then
    FColumnRegistryPath := PET_BRW_REG_PATH + Parent.Owner.Name + ' ' + Self.Caption
  else
    FColumnRegistryPath := PET_BRW_REG_PATH + Self.Caption;
  FGridOptions := [gsoUseFilter, gsoUseSummary];
  RestoreGridColumns;
end;

procedure TParentCustomList.SetGridKeys;
var
  i: Integer;
begin
  with DataSet do
    for i := 0 to Fields.Count-1 do
      if (pfInKey in Fields[i].ProviderFlags) then
      begin
        if grdListDBTableView.DataController.KeyFieldNames <> '' then
          grdListDBTableView.DataController.KeyFieldNames := grdListDBTableView.DataController.KeyFieldNames + ';';
        grdListDBTableView.DataController.KeyFieldNames := grdListDBTableView.DataController.KeyFieldNames + Fields[i].FieldName;
      end;
end;

procedure TParentCustomList.AfterClassicationChange;
begin
 //
end;

procedure TParentCustomList.grdListDBTableViewColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TParentCustomList.grdListDBTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TParentCustomList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  StoreGridColumns;
end;

procedure TParentCustomList.RestrictForm;
begin
  //Herdado
end;

function TParentCustomList.FormRestricted: Boolean;
begin

  Result := False;

  if Assigned(FDataSetControl) then
  begin
    if (Pos(Self.Name, FDataSetControl.RestrictForms) > 0) then
      Result := True;

    if not Result then
      Result := FDataSetControl.SoftwareExpired;
  end;


end;

end.
