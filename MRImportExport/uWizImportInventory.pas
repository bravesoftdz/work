unit uWizImportInventory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ImgList, StdCtrls, ExtCtrls,
  Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ComCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TWizImportInventory = class(TParentWizImp)
    gbConfigImportQty: TGroupBox;
    Label18: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    cbxStore: TcxLookupComboBox;
    rgQtyActionType: TRadioGroup;
    tsList: TTabSheet;
    grdListFile: TcxGrid;
    grdListFileTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    chkInventory: TCheckBox;
    lqQtyInfo: TLabel;
    procedure rgQtyActionTypeClick(Sender: TObject);
    procedure sgColumnsExit(Sender: TObject);
    procedure chkInventoryClick(Sender: TObject);
  private
    QtyActionType : Char;
    procedure SaveGridColumns;
    procedure GetGridColumn;
    procedure AddColumnsToListGrid;
  protected
    procedure AddColumnsToImport;
    procedure FillColumnsGrid;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function VerifyFieldsRequired: Boolean;
    function DoFinish:Integer; override;
    function AddSpecificFieldsToCDS(Position : Integer): Integer; override;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;
    procedure OnBeforeBackClick; override;
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport, uParentWizard, uSystemConst;

{$R *.dfm}

{ TWizImportInventory }

procedure TWizImportInventory.AddColumnsToImport;
begin
  sgColumns.Cells[0,1] := 'Model';
  sgColumns.Cells[0,2] := 'Barcode';
  sgColumns.Cells[0,3] := 'Category';
  sgColumns.Cells[0,4] := 'Sub-Category';
  sgColumns.Cells[0,5] := 'Group';
  sgColumns.Cells[0,6] := 'Manufacturer';
  sgColumns.Cells[0,7] := 'Vendor';
  sgColumns.Cells[0,8] := 'Qty';
  sgColumns.Cells[0,9] := 'CaseQty';
  sgColumns.Cells[0,10] := 'Description';
  sgColumns.Cells[0,11] := 'VendorCost';
  sgColumns.Cells[0,12] := 'MarkUp';
  sgColumns.Cells[0,13] := 'SellingPrice';
  sgColumns.Cells[0,14] := 'SuggRetail';
  sgColumns.Cells[0,15] := 'ClassABC';
  sgColumns.Cells[0,16] := 'DiscountPerc';
  sgColumns.Cells[0,17] := 'VendorModelCode';

  sgColumns.RowCount := 18;
end;

function TWizImportInventory.DoFinish: Integer;
begin
  Result := inherited DoFinish;
end;

procedure TWizImportInventory.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'Inventory File';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

function TWizImportInventory.OnAfterChangePage: Boolean;
var
  Passed : Boolean;
  sError: String;
begin
  Result := inherited OnAfterChangePage;
  Passed := False;

  if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    cbColumns.Visible := False;
    FillColumnsGrid;
    GetGridColumn;
  end
  else if pgOption.ActivePage.Name = 'tsSpecificConfig' then
  begin
    gbConfigImportQty.Visible := False;
    DMImportExport.ImportConn.Connected := True;
    DMImportExport.OpenStore;
  end
  else if pgOption.ActivePage.Name = 'tsList' then
  begin
    SaveGridColumns;
    
    ScreenStatusWait;
    SetGridToRegistryValues(MR_BRW_REG_PATH + 'MRImportExport\ImpPO\Vendor_' + SpecificConfig.Values['UseQty'] + '_List', grdListFile);

    cdsFile.Data := (DMImportExport.ImportConn.AppServer.ValidateInventoryTextFile(cdsFile.Data,
      LinkedColumns.Text,SpecificConfig.Text,LogError.Text, Passed));

    grdListFileTableView.DataController.DataSource := dtsFile;
    AddColumnsToListGrid;

    RestoreGridFromRegistry;

    ScreenStatusOk;
  end
  else if pgOption.ActivePage.Name = 'tsImport' then
  begin
    ScreenStatusWait;
    DMImportExport.ImportConn.AppServer.ImportInventoryTextFile(cdsFile.Data,
      LinkedColumns.Text, SpecificConfig.Text, sError);
    LogError.Text := sError;

    if sError <> '' then
      ShowError(sError)
    else
      MsgBox('Import Success!', vbInformation + vbOKOnly);

    ScreenStatusOk;
  end;
end;

function TWizImportInventory.TestBeforeNavigate: Boolean;
begin
  Result := inherited TestBeforeNavigate;

  if pgOption.ActivePage.Name = 'tsSpecificConfig' then
   begin
     if chkInventory.Checked then
     begin
       if not(VerifyFieldsRequired) then
       begin
         MsgBox('Field Required!', vbInformation + vbOKOnly);
         Result := False;
         Exit;
       end
       else
       begin
         AddSpecificConfigList('UseQty','Y');
         AddSpecificConfigList('QtyActionType', QtyActionType);
         AddSpecificConfigList('IDStore', cbxStore.EditValue);
         AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
       end;
     end
     else
       AddSpecificConfigList('UseQty','N');

     if DMImportExport.ActiveConnection.AppServer.IsClientServer then
      begin
        MsgBox('Inventory cannot be imported!_This is a Replication Database!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;
      
   end
  else if pgOption.ActivePage.Name = 'tsList' then
     SaveGridToRegistry;
end;

function TWizImportInventory.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if  (cbxStore.EditingText = '') or
      (rgQtyActionType.ItemIndex  = -1) then
      Result := False;
end;

procedure TWizImportInventory.rgQtyActionTypeClick(Sender: TObject);
begin
  if rgQtyActionType.ItemIndex = 0 then
    QtyActionType := 'R' //REPLACE
  else
    QtyActionType := 'A' //ADD
end;

procedure TWizImportInventory.GetGridColumn;
var
  sColumn, sError, sResult : String;
  sCaseCost : WordBool;
  i : integer;
begin

  //sColumn := DMImportExport.GetAppProperty('ColumnImportInventorySetup', SpecificConfig.Values['UseQty']);
  sError := DMImportExport.GetConfigImport(
    0,
    IMPORT_TYPE_INVENTORY,
    sColumn,
    sCaseCost);
    LogError.Text := sError;

  if LogError.Text = '' then
  begin
    if sColumn = '' then
       Exit;

    for i:=1 to sgColumns.RowCount-1 do
    begin
      sResult := ParseParam(sColumn, Trim(sgColumns.Cells[0,i]));
      if sResult <> '' then
        sgColumns.Cells[1,i] := sResult;
      sColumn := DeleteParam(sColumn, Trim(sgColumns.Cells[0,i]));
    end;
  end;
end;

procedure TWizImportInventory.SaveGridColumns;
var
  sColumn, sError : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[0,i]) <> '' then
         //if Pos(Trim(sgColumns.Cells[1,i]), sColumn) = 0 then
            sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
     Exit;

  //DMImportExport.SetAppProperty('ColumnImportInventorySetup', SpecificConfig.Values['UseQty'], sColumn);

  sError := DMImportExport.InsertConfigImport(
  0,
  IMPORT_TYPE_INVENTORY,
  sColumn,
  False);
  LogError.Text := sError;

  if LogError.Text <> '' then
  begin
    MsgBox(LogError.Text, vbCritical + vbOkOnly);
  end;

end;

procedure TWizImportInventory.sgColumnsExit(Sender: TObject);
begin
  //SaveGridColumns;
end;

procedure TWizImportInventory.AddColumnsToListGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
begin
  grdListFileTableView.ClearItems;
  for i := 0 to Pred(cdsFile.FieldDefs.Count) do
  begin
    NewColumn := grdListFileTableView.CreateColumn;
    with NewColumn do
    begin
      Caption := cdsFile.FieldDefs[i].DisplayName;
      Name    := 'grdListFileTableViewDB' + cdsFile.FieldDefs[i].DisplayName;
      DataBinding.FieldName := cdsFile.FieldDefs[i].Name;

      if cdsFile.FieldDefs[i].Name = 'Warning' then
      begin
        NewColumn.IsPreview := True;
        grdListFileTableView.Preview.Column := NewColumn;
      end;
    end;
  end;
end;

procedure TWizImportInventory.chkInventoryClick(Sender: TObject);
begin
  gbConfigImportQty.Visible := chkInventory.Checked; 
end;

function TWizImportInventory.AddSpecificFieldsToCDS(
  Position: Integer): Integer;
begin
  Result := Position;
end;

procedure TWizImportInventory.AddSpecificFriendFieldsToCDS(
  Position: Integer);
begin
  inherited;

end;

procedure TWizImportInventory.OnBeforeBackClick;
begin
  if pgOption.ActivePage.Name = 'tsCrossColumn' then
    SaveGridColumns;

  inherited;
end;

end.
