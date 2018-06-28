unit uWizImportPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, Provider, DBClient, ImgList, StdCtrls,
  ExtCtrls, Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ComCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Mask, DateBox;

type
  TVendor = class
    IDVendor:    Variant;
  public
    constructor Create(IDPessoa : Variant);
  end;

  TWizImportPO = class(TParentWizImp)
    gbSupplier: TGroupBox;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Freight: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    cbVendorList: TComboBox;
    edPONumber: TEdit;
    edPurchaseNumber: TEdit;
    dbRecordDate: TDateBox;
    dbDueDate: TDateBox;
    edFreight: TEdit;
    edOtherCost: TEdit;
    cbxStore: TcxLookupComboBox;
    cbxUser: TcxLookupComboBox;
    tsList: TTabSheet;
    grdListFile: TcxGrid;
    grdListFileTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Label2: TLabel;
    Label4: TLabel;
    tsValidModel: TTabSheet;
    grdValidateModelFile: TcxGrid;
    grdValidateModelFileTableView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    grdValidateModelFileTableViewDBCategory: TcxGridDBColumn;
    cbxCostIncCaseCost: TCheckBox;
    Panel2: TPanel;
    btnExport: TBitBtn;
    Panel3: TPanel;
    btnExport2: TBitBtn;
    grdValidateModelFileTableViewDBSubCategory: TcxGridDBColumn;
    grdValidateModelFileTableViewDBGroup: TcxGridDBColumn;
    procedure sgColumnsExit(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnExport2Click(Sender: TObject);
    procedure tsSpecificConfigShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btBackClick(Sender: TObject);
    procedure grdListFileTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    FIndiceColumnValidation : Integer;

    procedure AddComboVendor;
    procedure ClearComboVendor;
    procedure AddColumnsToListGrid;
    function SaveGridColumns: String;
    procedure GetGridColumn(ACrosColumn : String);
    procedure FilterCDSFileNewModel;
    procedure AddColumnsToValidateModelGrid;
    function ExistsEmptyModels: Boolean;
    function ExistsEmptyCategory: Boolean;
    function ExistsExactlyModel: Boolean;
    function ExistsExactlyBarcodes: Boolean;
    function ExistsEmptyDescriptions: Boolean;
    Procedure GetConfigImport;
  protected
    procedure AddColumnsToImport; override;
    procedure FillColumnsGrid; override;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function VerifyFieldsRequired: Boolean;
    function AddSpecificFieldsToCDS(Position : Integer): Integer; override;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;
    procedure OnBeforeBackClick; override;
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport, uNumericFunctions, uSystemConst,
  uParentWizard, uCDSFunctions, uDMGlobal;

{$R *.dfm}

{ TWizImportPO }

function TWizImportPO.OnAfterChangePage: Boolean;
var
  sError: String;
  Passed: Boolean;
  CrossColumns: String;
begin
  Result := inherited OnAfterChangePage;

  Passed := False;

  if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    cbColumns.Visible := False;
    FillColumnsGrid;

    GetConfigImport;
    //GetGridColumn;
    //cbxCostIncCaseCost.Checked := (DMImportExport.GetAppProperty('CaseCostOption', SpecificConfig.Values['Vendor']) = 'True');

  end
  else if pgOption.ActivePage.Name = 'tsSpecificConfig' then
  begin
    DMImportExport.ImportConn.Connected := True;
    DMImportExport.OpenStore;
    DMImportExport.OpenUser;
    DMImportExport.OpenVendor;
    dbRecordDate.Date := Now;
    dbDueDate.Date := Now + 7;

    AddComboVendor;
  end
  else if pgOption.ActivePage.Name = 'tsValidModel' then
  begin
    ScreenStatusWait;
    SetGridToRegistryValues(MR_BRW_REG_PATH + 'MRImportExport\ImpPO\Vendor_' + SpecificConfig.Values['Vendor']+ '_ValidateModel', grdValidateModelFile);
    DMImportExport.OpenCategory;
    DMImportExport.OpenSubCategory;
    DMImportExport.OpenGroup;

    cdsFile.Data := (DMImportExport.ImportConn.AppServer.ValidateModelsPOTextFile(cdsFile.Data,
      LinkedColumns.Text, SpecificConfig.Text, LogError.Text, Passed));

    grdValidateModelFileTableView.DataController.DataSource := dtsFile;

    AddColumnsToValidateModelGrid;

    FilterCDSFileNewModel;

    RestoreGridFromRegistry;

    ScreenStatusOk;

    //Salva as Confiurações de Importação do Fornecedor na tabela ConfigImport
    CrossColumns := SaveGridColumns;

    sError := DMImportExport.InsertConfigImport(
    TVendor(cbVendorList.Items.Objects[cbVendorList.Items.IndexOf(SpecificConfig.Values['Vendor'])]).IDVendor,
    IMPORT_TYPE_PO,
    CrossColumns,
    cbxCostIncCaseCost.Checked);
    LogError.Text := sError;

    if LogError.Text <> '' then
    begin
      MsgBox(LogError.Text, vbCritical + vbOkOnly);
    end;

    {
    if cbxCostIncCaseCost.Checked then
      DMImportExport.SetAppProperty('CaseCostOption', SpecificConfig.Values['Vendor'], 'True')
    else
      DMImportExport.SetAppProperty('CaseCostOption', SpecificConfig.Values['Vendor'], 'False');
    }
  end
  else if pgOption.ActivePage.Name = 'tsList' then
  begin
    ScreenStatusWait;
    SetGridToRegistryValues(MR_BRW_REG_PATH + 'MRImportExport\ImpPO\Vendor_' + SpecificConfig.Values['Vendor'] + '_List', grdListFile);

    cdsFile.Filtered := False;
    cdsFile.Filter := '';

    cdsFile.Data := (DMImportExport.ImportConn.AppServer.ValidatePOTextFile(cdsFile.Data,
      LinkedColumns.Text,SpecificConfig.Text,LogError.Text,Passed));

    grdListFileTableView.DataController.DataSource := dtsFile;
    
    AddColumnsToListGrid;

    RestoreGridFromRegistry;

    ScreenStatusOk;

  end
  else if pgOption.ActivePage.Name = 'tsImport' then
  begin
    ScreenStatusWait;
    DMImportExport.ImportConn.AppServer.ImportPOTextFile(cdsFile.Data,
      LinkedColumns.Text, SpecificConfig.Text, sError);
    LogError.Text := sError;

    if sError <> '' then
      ShowError(sError)
    else
      MsgBox('Import Success!', vbInformation + vbOKOnly);

    ScreenStatusOK;
  end;
end;

function TWizImportPO.TestBeforeNavigate: Boolean;
begin
  Result := inherited TestBeforeNavigate;
  if pgOption.ActivePage.Name = 'tsSpecificConfig' then
  begin
    if not(VerifyFieldsRequired) then
      begin
        MsgBox('Field Required!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    if (edPurchaseNumber.Text <> '') then
      if not(DMImportExport.ImportConn.AppServer.ValidatePurchaseNum(edPurchaseNumber.Text,cbVendorList.Text)) then
        begin
          MsgBox('Purchase number already exists!', vbInformation + vbOKOnly);
          Result := False;
          Exit;
        end;

    if (edPONumber.Text <> '') then
      if not(DMImportExport.ImportConn.AppServer.ExistsPONum(edPONumber.Text)) then
        begin
          MsgBox('PO does not exist!', vbInformation + vbOKOnly);
          Result := False;
          Exit;
        end;

    AddSpecificConfigList('PONumber',edPONumber.Text);
    AddSpecificConfigList('Store',cbxStore.EditValue);
    AddSpecificConfigList('User',cbxUser.EditValue);
    AddSpecificConfigList('Vendor',cbVendorList.Text);
    AddSpecificConfigList('Purchase_Number',edPurchaseNumber.Text);
    AddSpecificConfigList('Freight',edFreight.Text);
    AddSpecificConfigList('OtherCost',edOtherCost.Text);
    //AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));

    if dbRecordDate.Text = '' then
      AddSpecificConfigList('RecordDate','')
    else
      AddSpecificConfigList('RecordDate',DatetoStr(dbRecordDate.Date));

    if dbDueDate.Text = '' then
      AddSpecificConfigList('DueDate','')
    else
      AddSpecificConfigList('DueDate',DatetoStr(dbDueDate.Date));
  end
  else if pgOption.ActivePage.Name = 'tsValidModel' then
  begin
    grdValidateModelFileTableView.DataController.DataSource := nil;

    if ExistsEmptyModels then
      begin
        grdValidateModelFileTableView.DataController.DataSource := dtsFile;
        MsgBox('Model can not be empty!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    if ExistsEmptyDescriptions then
      begin
        grdValidateModelFileTableView.DataController.DataSource := dtsFile;
        MsgBox('Description can not be empty!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    if ExistsEmptyCategory then
      begin
        grdValidateModelFileTableView.DataController.DataSource := dtsFile;
        MsgBox('Category can not be empty!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    if ExistsExactlyBarcodes then
      begin
        grdValidateModelFileTableView.DataController.DataSource := dtsFile;
        MsgBox('Barcode already exists!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    if ExistsExactlyModel then
      begin
        grdValidateModelFileTableView.DataController.DataSource := dtsFile;
        MsgBox('Model already exists!', vbInformation + vbOKOnly);
        Result := False;
        Exit;
      end;

    grdValidateModelFileTableView.DataController.DataSource := dtsFile;

    SaveGridToRegistry;
  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    if (LinkedColumns.Values['Barcode'] = '') then
    begin
      MsgBox('Please select Barcode!_Required fields: Barcode, Qty, NewCostPrice.', vbInformation + vbOKOnly);
      Result := False;
      Exit;
    end;

    if (LinkedColumns.Values['Qty'] = '') then
    begin
      MsgBox('Please select Qty!_Required fields: Barcode, Qty, NewCostPrice.', vbInformation + vbOKOnly);
      Result := False;
      Exit;
    end;

    if (LinkedColumns.Values['NewCostPrice'] = '') then
    begin
      MsgBox('Please select New Cost Price!_Required fields: Barcode, Qty, NewCostPrice.', vbInformation + vbOKOnly);
      Result := False;
      Exit;
    end;

    if cbxCostIncCaseCost.Checked then
      AddSpecificConfigList('CostIsCaseCost','True')
    else
      AddSpecificConfigList('CostIsCaseCost','False');
  end
  else if pgOption.ActivePage.Name = 'tsList' then
    SaveGridToRegistry;
end;

function TWizImportPO.ExistsEmptyModels: Boolean;
begin
  Result := False;

  with cdsFile do
  begin
    First;
    while not Eof do
    begin
      if cdsFile.FieldByName('Model').AsString = '' then
      begin
        Result := True;
        break;
      end;
      Next;
    end;
  end;
end;

function TWizImportPO.ExistsEmptyDescriptions: Boolean;
begin
  Result := False;

  with cdsFile do
  begin
    First;
    while not Eof do
    begin
      if cdsFile.FieldByName('Description').AsString = '' then
      begin
        Result := True;
        break;
      end;
      Next;
    end;
  end;
end;

function TWizImportPO.ExistsExactlyBarcodes: Boolean;
var
  cdsSupport: TClientDataSet;
begin
  Result := False;

  cdsSupport := TClientDataSet.Create(self);
  try
    cdsSupport.CloneCursor(cdsFile,true);

    with cdsFile do
    begin
      First;
      while not Eof do
      begin
        cdsSupport.Filter := LinkedColumns.Values['Barcode'] + ' = ' + QuotedStr(cdsFile.FieldByName(LinkedColumns.Values['Barcode']).AsString);
        cdsSupport.Filtered := True;
        if cdsSupport.RecordCount > 1 then
        begin
          Result := True;
          break;
        end;
        cdsSupport.Filter := '';
        cdsSupport.Filtered := False;
        Next;
      end;
    end;
  finally
    FreeAndNil(cdsSupport);
    end;
end;

function TWizImportPO.ExistsExactlyModel: Boolean;
var
  cdsSupport: TClientDataSet;
begin
  Result := False;

  cdsSupport := TClientDataSet.Create(self);
  try
    cdsSupport.CloneCursor(cdsFile,true);

    with cdsFile do
    begin
      First;
      while not Eof do
      begin
        cdsSupport.Filter := 'Model = ' + QuotedStr(cdsFile.FieldByName('Model').AsString);
        cdsSupport.Filtered := True;
        if cdsSupport.RecordCount > 1 then
        begin
          Result := True;
          break;
        end;
        cdsSupport.Filter := '';
        cdsSupport.Filtered := False;
        Next;
      end;
    end;
  finally
    FreeAndNil(cdsSupport);
    end;
end;

function TWizImportPO.ExistsEmptyCategory: Boolean;
begin
  Result := False;

  with cdsFile do
  begin
    First;
    while not Eof do
    begin
      if (cdsFile.FieldByName('IDGroup').AsString = '') OR
         (cdsFile.FieldByName('IDGroup').AsInteger = 0) then
      begin
        Result := True;
        break;
      end;
      Next;
    end;
  end;
end;

function TWizImportPO.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if  (cbxStore.EditingText = '') or (cbxUser.EditingText  = '') or
      (cbVendorList.Text  = '') or
      (dbRecordDate.Text = '') or (dbDueDate.Text = '') then
      Result := False;
end;

procedure TWizImportPO.AddColumnsToImport;
begin
  sgColumns.Cells[0,1]  := 'BarCode';
  sgColumns.Cells[0,2]  := 'VendorCode';
  sgColumns.Cells[0,3]  := 'Qty';
  sgColumns.Cells[0,4]  := 'NewCostPrice';
  sgColumns.Cells[0,5]  := 'FreightCost';
  sgColumns.Cells[0,6]  := 'OtherCost';
  sgColumns.Cells[0,7]  := 'Description';
  sgColumns.Cells[0,8]  := 'CaseQty';
  sgColumns.Cells[0,9]  := 'CaseCost';
  sgColumns.Cells[0,10] := 'MinQty';
  sgColumns.Cells[0,11] := 'PromoFlag';

  sgColumns.RowCount := 12;
end;

procedure TWizImportPO.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'File PO';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

procedure TWizImportPO.AddComboVendor;
begin
  //Limpar os Obetos Tvendor da Combo
  ClearComboVendor;

  DMImportExport.cdsLookupVendor.First;
  while not DMImportExport.cdsLookupVendor.Eof do
    begin
      //cbVendorList.Items.Add(DMImportExport.cdsLookupVendor.Fields.FieldByName('Vendor').AsString);

      cbVendorList.Items.AddObject(DMImportExport.cdsLookupVendor.Fields.FieldByName('Vendor').AsString,
                                   TVendor.Create(DMImportExport.cdsLookupVendor.Fields.FieldByName('IDVendor').AsVariant));

      DMImportExport.cdsLookupVendor.Next;
    end;
end;

procedure TWizImportPO.AddColumnsToValidateModelGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
  FieldBarcode, FieldDescription: String;
begin
  if (LinkedColumns.Values['Barcode'] <> '') then
  begin
    FieldBarcode := cdsFile.FieldByName(LinkedColumns.Values['Barcode']).FieldName;
    cdsFile.FieldByName(FieldBarcode).ReadOnly := True;
  end;

  if (LinkedColumns.Values['Description'] <> '') then
  begin
    FieldDescription := cdsFile.FieldByName(LinkedColumns.Values['Description']).FieldName;
    cdsFile.FieldByName(FieldDescription).ReadOnly := False;
  end;

  i := 0;
  while grdValidateModelFileTableView.ColumnCount > 3 do
    if (grdValidateModelFileTableView.Columns[i].Caption <> 'Category') and
       (grdValidateModelFileTableView.Columns[i].Caption <> 'SubCategory') and
       (grdValidateModelFileTableView.Columns[i].Caption <> 'Group') then
    begin
      grdValidateModelFileTableView.Columns[i].DataBinding.FieldName := '';
      grdValidateModelFileTableView.Columns[i].Free;
    end
    else
      inc(i);

  for i := 0 to Pred(cdsFile.FieldDefs.Count) do
    if (cdsFile.FieldDefs[i].DisplayName = FieldBarcode) or
       (cdsFile.FieldDefs[i].DisplayName = FieldDescription) or
       (cdsFile.FieldDefs[i].DisplayName = 'Description') or
       (cdsFile.FieldDefs[i].DisplayName = 'Model') or
       (cdsFile.FieldDefs[i].DisplayName = 'Warning') or
       (cdsFile.FieldDefs[i].DisplayName = 'OldCostPrice') then
    begin
      NewColumn := grdValidateModelFileTableView.CreateColumn;
      with NewColumn do
        begin
         Caption := cdsFile.FieldDefs[i].DisplayName;

         Name    := 'grdValidateModelFileTableViewDB' + cdsFile.FieldDefs[i].DisplayName;
         DataBinding.FieldName := cdsFile.FieldDefs[i].Name;
        end;
    end;

  for i := 0 to grdValidateModelFileTableView.ColumnCount - 1 do
  begin
    if grdValidateModelFileTableView.Columns[i].Caption = FieldBarcode then
      grdValidateModelFileTableView.Columns[i].Index := 0;

    if grdValidateModelFileTableView.Columns[i].Caption = 'Model' then
      grdValidateModelFileTableView.Columns[i].Index := 1;

    if (grdValidateModelFileTableView.Columns[i].Caption = FieldDescription) or
       (grdValidateModelFileTableView.Columns[i].Caption = 'Description') then
      grdValidateModelFileTableView.Columns[i].Index := 2;

    if grdValidateModelFileTableView.Columns[i].Caption = 'Category' then
      grdValidateModelFileTableView.Columns[i].Index := 3;

    if grdValidateModelFileTableView.Columns[i].Caption = 'SubCategory' then
      grdValidateModelFileTableView.Columns[i].Index := 4;

    if grdValidateModelFileTableView.Columns[i].Caption = 'Group' then
      grdValidateModelFileTableView.Columns[i].Index := 5;

    if grdValidateModelFileTableView.Columns[i].Caption = 'OldCostPrice' then
    begin
      grdValidateModelFileTableView.Columns[i].Caption := 'CostPrice';
      grdValidateModelFileTableView.Columns[i].Index := 6;
    end;

    if grdValidateModelFileTableView.Columns[i].Caption = 'Warning' then
      grdValidateModelFileTableView.Columns[i].Index := 7;
  end;
end;

procedure TWizImportPO.AddColumnsToListGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
  sDisplayName: String;
begin
  grdListFileTableView.ClearItems;

  cdsFile.FieldByName('NewSalePrice').ReadOnly := False;

  for i := 0 to (iValidateColumns - 1)  do
  begin
    if (cdsFile.FieldDefs[i].DisplayName <> 'OldCostPrice') and
       (cdsFile.FieldDefs[i].DisplayName <> 'FieldCostCalc') then
    begin
      NewColumn := grdListFileTableView.CreateColumn;
      with NewColumn do
      begin

        sDisplayName := StringReplace(cdsFile.FieldDefs[i].DisplayName, '.', '', [rfReplaceAll]);
        sDisplayName := StringReplace(sDisplayName, ',', '', [rfReplaceAll]);
        sDisplayName := StringReplace(sDisplayName, ';', '', [rfReplaceAll]);

        Caption := sDisplayName;
        Name    := 'grdListFileTableView' + sDisplayName;
        DataBinding.FieldName := StringReplace(cdsFile.FieldDefs[i].Name, '.', '',[rfReplaceAll]);

        if NewColumn.Caption <> 'NewSalePrice' then
        begin
          NewColumn.Options.Editing := False;
          NewColumn.Editing := False;
          NewColumn.Width   := GetColumnWidth(cdsFile.FieldDefs[i].DataType);
        end;

        if cdsFile.FieldDefs[i].Name = 'Warning' then
        begin
          NewColumn.IsPreview := True;
          //NewColumn.Properties.
          grdListFileTableView.Preview.Column := NewColumn;
        end;

        if cdsFile.FieldDefs[i].Name = 'Validation' then
          FIndiceColumnValidation := NewColumn.Index;
      end;
    end;
  end;
end;

procedure TWizImportPO.sgColumnsExit(Sender: TObject);
begin
  inherited;
//  SaveGridColumns;
end;

function TWizImportPO.SaveGridColumns: String;
var
  sColumn : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[0,i]) <> '' then
         //if Pos(Trim(sgColumns.Cells[1,i]), sColumn) = 0 then
            sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  Result := sColumn;
//  if sColumn = '' then
//   Exit;

 //DMImportExport.SetAppProperty('ColumnImportPOSetup', SpecificConfig.Values['Vendor'], sColumn);
end;

procedure TWizImportPO.GetGridColumn(ACrosColumn : String);
var
  sColumn, sResult : String;
  i : integer;
begin

  //sColumn := DMImportExport.GetAppProperty('ColumnImportPOSetup', SpecificConfig.Values['Vendor']);
  sColumn := ACrosColumn;

  if sColumn = '' then
     Exit;

  for i:=1 to sgColumns.RowCount-1 do
  begin
    sResult := ParseParam(sColumn, Trim(sgColumns.Cells[0,i]));

    if sResult <> '' then
    begin
      if cbColumns.Items.IndexOf(sResult) >= 0 then
       sgColumns.Cells[1,i] := sResult;
    end;
    sColumn := DeleteParam(sColumn, Trim(sgColumns.Cells[0,i]));
  end;

end;

function TWizImportPO.AddSpecificFieldsToCDS(Position: Integer): Integer;
begin
  CreateCDSField(cdsFile, 'OldSalePrice', ftCurrency, Position+1, True);
  CreateCDSField(cdsFile, 'NewSalePrice', ftCurrency, Position+2, True);
  CreateCDSField(cdsFile, 'OldCostPrice', ftCurrency, Position+3, True);
  CreateCDSField(cdsFile, 'QtyType', ftString, Position+4, True);
  CreateCDSField(cdsFile, 'NewMSRP', ftCurrency, Position+5, True);
  CreateCDSField(cdsFile, 'FieldCostCalc', ftString, Position+6, True);


  Result := Position + 6;
end;

procedure TWizImportPO.AddSpecificFriendFieldsToCDS(Position: Integer);
begin
  CreateCDSField(cdsFile, 'IDGroup', ftInteger, Position+1, True);
  CreateCDSField(cdsFile, 'IDModel', ftInteger, Position+2, True);
  CreateCDSField(cdsFile, 'IDModelGroup', ftInteger, Position+3, True);
  CreateCDSField(cdsFile, 'IDModelSubGroup', ftInteger, Position+4, True);
  CreateCDSField(cdsFile, 'CaseQty', ftCurrency, Position+5, True);
  CreateCDSField(cdsFile, 'CaseCost', ftCurrency, Position+6, True);
  CreateCDSField(cdsFile, 'Model', ftString, Position+7, True);
  CreateCDSField(cdsFile, 'NewModel', ftBoolean, Position+8, True);
  CreateCDSField(cdsFile, 'Description', ftString, Position+9, True, 50);
  CreateCDSField(cdsFile, 'VendorModelCode', ftString, Position+10, True, 20);
  CreateCDSField(cdsFile, 'MinQtyPO', ftFloat, Position+11, True);
  CreateCDSField(cdsFile, 'VendorCaseQty', ftFloat, Position+12, True);
end;

procedure TWizImportPO.FilterCDSFileNewModel;
begin
  cdsFile.Filter := 'Validation = True and NewModel = True';
  cdsFile.Filtered := true;
end;

procedure TWizImportPO.OnBeforeBackClick;
begin
  inherited;
  if pgOption.ActivePage.Name = 'tsList' then
  begin
    ScreenStatusWait;
    grdValidateModelFileTableView.DataController.DataSource := nil;

    cdsFile.Filtered := false;
    cdsFile.Filter := 'NewModel = True and Model <> '''' ';
    cdsFile.Filtered := true;

    grdValidateModelFileTableView.DataController.DataSource := dtsFile;
    ScreenStatusOk;
  end
end;

procedure TWizImportPO.btnExportClick(Sender: TObject);
begin
  ExportGridToExcel(grdValidateModelFile);
end;

procedure TWizImportPO.btnExport2Click(Sender: TObject);
begin
  inherited;
  ExportGridToExcel(grdListFile);
end;

procedure TWizImportPO.tsSpecificConfigShow(Sender: TObject);
begin
  inherited;
  cbxUser.EditValue   := DMImportExport.FUser.ID;
  cbxStore.EditValue  := DMImportExport.IDDefaulStore;
end;

procedure TWizImportPO.ClearComboVendor;
var
  Vendor : TVendor;
begin
  while cbVendorList.Items.Count > 0 do
  begin
    Vendor := TVendor(cbVendorList.Items.Objects[0]);
    FreeAndNil(Vendor);
    cbVendorList.Items.Delete(0);
  end;
  cbVendorList.Clear;
end;


Procedure TWizImportPO.GetConfigImport;
var
  sCrossColumns, sError : String;
  sCaseCost : WordBool;
begin
    sError := DMImportExport.GetConfigImport(
      TVendor(cbVendorList.Items.Objects[cbVendorList.Items.IndexOf(SpecificConfig.Values['Vendor'])]).IDVendor,
      IMPORT_TYPE_PO,
      sCrossColumns,
      sCaseCost);
      LogError.Text := sError;

    if LogError.Text = '' then
    begin
      GetGridColumn(sCrossColumns);
      cbxCostIncCaseCost.Checked := sCaseCost;
    end
    else
    begin
      MsgBox(LogError.Text, vbCritical + vbOkOnly);
    end;
end;

{ TVendor }

constructor TVendor.Create(IDPessoa : Variant);
begin
  IDVendor := IDPessoa;
end;

procedure TWizImportPO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //Limpar os Obetos Tvendor da Combo
  ClearComboVendor;
end;

procedure TWizImportPO.btBackClick(Sender: TObject);
begin
  if pgOption.ActivePage.Name = 'tsValidModel' then
  begin
    if MsgBox('Warning: Going back to the configuration screen will result in the loss of changes made to this PO.', vbQuestion + vbOKCancel) = vbCancel then
      Exit;
  end;
  
  inherited;
end;

procedure TWizImportPO.grdListFileTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
 bValidation : Boolean;
begin
  inherited;

  if (AViewInfo.Item.Caption = 'Warning') then
  begin
    bValidation := VarAsType(AViewInfo.GridRecord.Values[FIndiceColumnValidation], varBoolean);
    if not bValidation then
      ACanvas.Font.Color := clRed;
  end;

end;

end.
