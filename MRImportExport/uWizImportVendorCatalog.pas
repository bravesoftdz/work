unit uWizImportVendorCatalog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ImgList, ExtCtrls, StdCtrls,
  Buttons, Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, cxCurrencyEdit;

type
  TVendor = class
    IDVendor:    Variant;
  public
    constructor Create(IDPessoa : Variant);
  end;

  TWizImportVendorCatalog = class(TParentWizImp)
    grdValidateModelFile: TcxGrid;
    grdValidateModelFileTableView: TcxGridDBTableView;
    cbxCostIncCaseCost: TCheckBox;
    GroupBox1: TGroupBox;
    cbVendorList: TComboBox;
    Label3: TLabel;
    Label21: TLabel;
    Update: TcxGridDBColumn;
    btnSelectAll: TBitBtn;
    CbCostChange: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    TbItemsOption: TTabControl;
    BtnConfirmCostChange: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure grdValidateModelFileTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnSelectAllClick(Sender: TObject);
    procedure CbCostChangeChange(Sender: TObject);
    procedure TbItemsOptionChange(Sender: TObject);
    procedure cdsFileBeforePost(DataSet: TDataSet);
    procedure grdValidateModelFileExit(Sender: TObject);
  private
    { Private declarations }
    FIndiceColumnValidation : Integer;

    function OnAfterChangePage:Boolean; override;
    function DoFinish:Integer; override;

    function AddSpecificFieldsToCDS(Position : Integer): Integer; override;

    function SaveGridColumns: String;

    function TestBeforeNavigate:Boolean; override;
    function VerifyFieldsRequired: Boolean;

    procedure GetConfigImport;
    procedure GetGridColumn(ACrosColumn : String);

    procedure AddComboVendor;
    procedure ClearComboVendor;

    procedure FillColumnsGrid; override;

    procedure AddColumnsToImport; override;
    procedure AddColumnsToValidateModelGrid;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;

    procedure FilterCdsFile;

    procedure CalculateCostChange( Sender: TObject );

  public
    { Public declarations }
  end;

var
  WizImportVendorCatalog: TWizImportVendorCatalog;

implementation

uses uMsgBox, uDMImportExport, uParamFunctions, uCDSFunctions, uSystemConst,
  uParentWizard;

{$R *.dfm}

{==============================================================================}
{ Vendor control                                                               }
constructor TVendor.Create(IDPessoa : Variant);
begin
  IDVendor := IDPessoa;
end;

procedure TWizImportVendorCatalog.AddComboVendor;
begin

  ClearComboVendor;

  DMImportExport.cdsLookupVendor.First;
  while not DMImportExport.cdsLookupVendor.Eof do
  begin
      cbVendorList.Items.AddObject(DMImportExport.cdsLookupVendor.Fields.FieldByName('Vendor').AsString,
                                   TVendor.Create(DMImportExport.cdsLookupVendor.Fields.FieldByName('IDVendor').AsVariant));

      DMImportExport.cdsLookupVendor.Next;
  end;

end;

procedure TWizImportVendorCatalog.ClearComboVendor;
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
{------------------------------------------------------------------------------}

{==============================================================================}
{ Cross column control                                                         }
procedure TWizImportVendorCatalog.AddColumnsToImport;
begin
  inherited;

  sgColumns.Cells[0,1]  := 'BarCode';
  sgColumns.Cells[0,2]  := 'VendorCode';
  sgColumns.Cells[0,3]  := 'Description';
  sgColumns.Cells[0,4]  := 'Cost';
  sgColumns.Cells[0,5]  := 'CaseCost';
  sgColumns.Cells[0,6]  := 'CaseQty';
  sgColumns.Cells[0,7]  := 'MinQty';

  sgColumns.RowCount := 08;

end;

procedure TWizImportVendorCatalog.FillColumnsGrid;
begin
  inherited;

  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'Vendor Catalog';

  AddColumnsToImport;

  { Adds the columns of the file to the cross column control }
  AddComboColumnsToImport;

end;

function TWizImportVendorCatalog.AddSpecificFieldsToCDS(Position: Integer): Integer;
begin

  CreateCDSField(cdsFile, 'Update',      ftString,   Position+1, True);

  CreateCDSField(cdsFile, 'OldCost',     ftFloat,  Position+2, True);
  CreateCDSField(cdsFile, 'OldCaseQty',  ftString, Position+3, True);
  CreateCDSField(cdsFile, 'OldMinQty',   ftString, Position+4, True);

  Result := Position + 5;

end;

procedure TWizImportVendorCatalog.AddSpecificFriendFieldsToCDS(Position: Integer);
begin

  CreateCDSField(cdsFile, 'IdModel',    ftFloat,  Position+1, True);

  CreateCDSField(cdsFile, 'CostChange',    ftFloat,  Position+2, True);
  CreateCDSField(cdsFile, 'FieldCostCalc', ftFloat,  Position+3, True);
  CreateCDSField(cdsFile, 'AbsCostChange', ftFloat,  Position+4, True);
  CreateCDSField(cdsFile, 'ChangeType',    ftString, Position+5, True);

end;
{------------------------------------------------------------------------------}

{==============================================================================}
{ Form control                                                                 }
procedure TWizImportVendorCatalog.AddColumnsToValidateModelGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
  FieldBarcode,  FieldDescription, FieldNewCost,
  FieldCaseCost, FieldVendorCode,  FieldNewCaseQty,
  FieldNewMinQty  : String;
begin

  if (LinkedColumns.Values['Barcode'] <> '') then
  begin
    FieldBarcode := cdsFile.FieldByName(LinkedColumns.Values['Barcode']).FieldName;
    cdsFile.FieldByName(FieldBarcode).ReadOnly := True;
  end;

  if (LinkedColumns.Values['VendorCode'] <> '') then
  begin
    FieldVendorCode := cdsFile.FieldByName(LinkedColumns.Values['VendorCode']).FieldName;
    cdsFile.FieldByName(FieldVendorCode).ReadOnly := True;
  end;

  if (LinkedColumns.Values['Description'] <> '') then
  begin
    FieldDescription := cdsFile.FieldByName(LinkedColumns.Values['Description']).FieldName;
    cdsFile.FieldByName(FieldDescription).ReadOnly := True;
  end;

  if (LinkedColumns.Values['Cost'] <> '') then
  begin
    FieldNewCost := cdsFile.FieldByName(LinkedColumns.Values['Cost']).FieldName;
    cdsFile.FieldByName(FieldNewCost).ReadOnly := False;
  end;

  if (LinkedColumns.Values['CaseCost'] <> '') then
  begin
    FieldCaseCost := cdsFile.FieldByName(LinkedColumns.Values['CaseCost']).FieldName;
    cdsFile.FieldByName(FieldCaseCost).ReadOnly := False;
  end;

  if (LinkedColumns.Values['CaseQty'] <> '') then
  begin
    FieldNewCaseQty := cdsFile.FieldByName(LinkedColumns.Values['CaseQty']).FieldName;
    cdsFile.FieldByName(FieldNewCaseQty).ReadOnly := False;
  end;

  if (LinkedColumns.Values['MinQty'] <> '') then
  begin
    FieldNewMinQty := cdsFile.FieldByName(LinkedColumns.Values['MinQty']).FieldName;
    cdsFile.FieldByName(FieldNewMinQty).ReadOnly := False;
  end;

  i := 0;
  while grdValidateModelFileTableView.ColumnCount > 1 do
  begin
    if ( (grdValidateModelFileTableView.Columns[i].Caption = 'Update') )
    then begin
      inc(i);
    end else begin
      grdValidateModelFileTableView.Columns[i].DataBinding.FieldName := '';
      grdValidateModelFileTableView.Columns[i].Free;
    end;

  end;

  for i := 0 to Pred(cdsFile.FieldDefs.Count) do
  begin

    if  (cdsFile.FieldDefs[i].DisplayName = FieldBarcode)     or
        (cdsFile.FieldDefs[i].DisplayName = FieldVendorCode)  or
        (cdsFile.FieldDefs[i].DisplayName = FieldDescription) or
        (cdsFile.FieldDefs[i].DisplayName = FieldNewCost)     or
        (cdsFile.FieldDefs[i].DisplayName = FieldCaseCost)    or
        (cdsFile.FieldDefs[i].DisplayName = FieldNewCaseQty)  or
        (cdsFile.FieldDefs[i].DisplayName = FieldNewMinQty)   or
        (cdsFile.FieldDefs[i].DisplayName = 'OldCost')        or
        (cdsFile.FieldDefs[i].DisplayName = 'OldCaseQty')     or
        (cdsFile.FieldDefs[i].DisplayName = 'OldMinQty')      or
        (cdsFile.FieldDefs[i].DisplayName = 'CostChange')
        //or (cdsFile.FieldDefs[i].DisplayName = 'Warning')
    then begin

      NewColumn := grdValidateModelFileTableView.CreateColumn;

      with NewColumn do
      begin

         Caption := cdsFile.FieldDefs[i].DisplayName;

         Name    := 'grdValidateModelFileTableViewDB' + cdsFile.FieldDefs[i].DisplayName;
         DataBinding.FieldName := cdsFile.FieldDefs[i].Name;

      end;

    end;

    If ( Pos( UpperCase( cdsFile.FieldDefs[i].DisplayName ), 'DESCRIPTIONVENDORCODEBARCODE'+
                                                              FieldBarcode+FieldDescription+FieldVendorCode ) <= 0 )
    Then cdsFile.Fields[I].Alignment := taRightJustify;

    If ( Pos( UpperCase( cdsFile.FieldDefs[i].DisplayName ), 'OLDCOSTCOSTCHANGE'+
                                                             FieldNewCost+FieldCaseCost ) > 0 )
    Then Begin    

      NewColumn.PropertiesClassName := 'TcxCurrencyEditProperties';
      TcxCurrencyEditProperties( NewColumn.Properties).DisplayFormat := '0.00;0.00';

      If ( cdsFile.FieldDefs[i].DisplayName = 'CostChange' ) Then Begin

        NewColumn.Options.Editing := False;

      End;

    End;

    If ( cdsFile.FieldDefs[i].DisplayName = 'OldCost' )    Then  cdsFile.Fields[I].ReadOnly := True;
    If ( cdsFile.FieldDefs[i].DisplayName = 'OldCaseQty' ) Then  cdsFile.Fields[I].ReadOnly := True;
    If ( cdsFile.FieldDefs[i].DisplayName = 'OldMinQty' )  Then  cdsFile.Fields[I].ReadOnly := True;

  end;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldBarcode ).Index      := 1;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldBarcode ).Caption    := 'BarCode';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldBarcode ).Width      := 90;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldVendorCode ).Index   := 2;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldVendorCode ).Caption := 'VendorCode';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldVendorCode ).Width   := 90;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldDescription ).Index   := 3;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldDescription ).Caption := 'Description';

  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCost ).Index      := 4;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCost ).Caption    := 'New Cost';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCost ).Width      := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( 'OldCost' ).Index         := 5;
  grdValidateModelFileTableView.GetColumnByFieldName( 'OldCost' ).Width      := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( 'CostChange' ).Index      := 6;
  grdValidateModelFileTableView.GetColumnByFieldName( 'CostChange' ).Caption    := '% Change';
  grdValidateModelFileTableView.GetColumnByFieldName( 'CostChange' ).Width      := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldCaseCost ).Index     := 7;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldCaseCost ).Caption    := 'New Case Cost';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldCaseCost ).Width      := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCaseQty ).Index   := 8;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCaseQty ).Caption := 'New Case Qty';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewCaseQty ).Width   := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( 'OldCaseQty' ).Index      := 9;
  grdValidateModelFileTableView.GetColumnByFieldName( 'OldCaseQty' ).Caption    := 'Old Case Qty';
  grdValidateModelFileTableView.GetColumnByFieldName( 'OldCaseQty' ).Width      := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewMinQty ).Index   := 10;
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewMinQty ).Caption := 'New Min Qty';
  grdValidateModelFileTableView.GetColumnByFieldName( FieldNewMinQty ).Width   := 80;

  grdValidateModelFileTableView.GetColumnByFieldName( 'OldMinQty' ).Index      := 11;
  grdValidateModelFileTableView.GetColumnByFieldName( 'OldMinQty' ).Caption    := 'Old Min Qty';
  grdValidateModelFileTableView.GetColumnByFieldName( 'OldMinQty' ).Width      := 80;

  //grdValidateModelFileTableView.GetColumnByFieldName( 'Warning' ).Index         := 12;

end; { AddColumnsToValidateModelGrid }

function TWizImportVendorCatalog.SaveGridColumns: String;
var
  sColumn : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[0,i]) <> '' then
         sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  Result := sColumn;

end;

procedure TWizImportVendorCatalog.FilterCDSFile;
Var
  sFiltro : String;
begin

  If ( Trim( CbCostChange.Text ) <> '' ) Then Begin

    sFiltro := 'AbsCostChange > ' + CbCostChange.Text;

  End Else Begin

    sFiltro := '1 = 1 ';

  End;

  Case TbItemsOption.TabIndex Of

     0 : Begin

           sFiltro := sFiltro  + ' AND ChangeType = ''U''';

         End;

     1 : Begin

           sFiltro := sFiltro  + ' AND ChangeType = ''N''';

         End;

     2 : Begin

           sFiltro := sFiltro  + ' AND ChangeType = ''R''';

         End;

  End;

  If ( Trim( sFiltro ) <> '' ) Then Begin

    cdsFile.Filter   := sFiltro;
    cdsFile.Filtered := True;

  End Else Begin

    cdsFile.Filtered := False;

  End;

end;

function TWizImportVendorCatalog.TestBeforeNavigate: Boolean;
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

    AddSpecificConfigList('Vendor',cbVendorList.Text);

  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin

    if (LinkedColumns.Values['Barcode'] = '') then
    begin
      MsgBox('Please select Barcode!', vbInformation + vbOKOnly);
      Result := False;
      Exit;
    end;


    if cbxCostIncCaseCost.Checked then
      AddSpecificConfigList('CostIsCaseCost','True')
    else
      AddSpecificConfigList('CostIsCaseCost','False');

  end
  else if pgOption.ActivePage.Name = 'tsValidModel' then
  begin

    If ( cdsFile.State = dsEdit ) Then cdsFile.Post();

    grdValidateModelFileTableView.DataController.DataSource := nil;
    grdValidateModelFileTableView.DataController.DataSource := dtsFile;

    SaveGridToRegistry;

  end
  else if pgOption.ActivePage.Name = 'tsList' then begin


    SaveGridToRegistry;

  end;

end;

procedure TWizImportVendorCatalog.FormCreate(Sender: TObject);
begin
  inherited;

  DMImportExport.ImportConn.Connected := True;

  DMImportExport.OpenUser;
  DMImportExport.OpenVendor;

  AddComboVendor;

end;

function TWizImportVendorCatalog.OnAfterChangePage: Boolean;
var
  sError: String;
  Passed: Boolean;
  CrossColumns: String;
  message: String;
begin
  Result := inherited OnAfterChangePage;

  Passed := False;

  lbEditDescription.Font.color := clWindowText;

  if pgOption.ActivePage.Name = 'tsDatabase' then
  begin

    cdsFile.First();

  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin

    cbColumns.Visible := False;
    FillColumnsGrid;

    GetConfigImport;

  end
  else if pgOption.ActivePage.Name = 'tsValidModel' then
  begin
    //amfsouza July 19, 2012
    self.Caption := pgOption.ActivePage.Hint;
    lbEditDescription.Font.color := clRed;
    lbEditDescription.Caption :=
        'The "Update Items" tab lists models already associated with this vendor. The "New Items" tab lists models that where not previously associated with this vendor.'+
        'The "Removed Items" tab lists models no longer available from this vendor.';

    ScreenStatusWait;

    SetGridToRegistryValues(MR_BRW_REG_PATH + 'MRImportExport\ImpPO\Vendor_' + SpecificConfig.Values['Vendor']+ '_ValidateModel', grdValidateModelFile);

    cdsFile.Data := (DMImportExport.ImportConn.AppServer.ValidateVCTextFile(cdsFile.Data,
                                                                            LinkedColumns.Text,
                                                                            SpecificConfig.Text,
                                                                            LogError.Text,
                                                                            Passed));

    grdValidateModelFileTableView.DataController.DataSource := dtsFile;

    AddColumnsToValidateModelGrid;

    FilterCDSFile;

    ScreenStatusOk;

    //Salva as Configurações de Importação do Fornecedor na tabela ConfigImport
    CrossColumns := SaveGridColumns;

    sError := DMImportExport.InsertConfigImport(TVendor(cbVendorList.Items.Objects[cbVendorList.Items.IndexOf(SpecificConfig.Values['Vendor'])]).IDVendor,
                                                IMPORT_TYPE_VC,
                                                CrossColumns,
                                                cbxCostIncCaseCost.Checked);
    LogError.Text := sError;

    if LogError.Text <> '' then
    begin
      MsgBox(LogError.Text, vbCritical + vbOkOnly);
    end;

  end;

end;

function TWizImportVendorCatalog.DoFinish: Integer;
var
  sError: String;
begin

  ScreenStatusWait;

  If ( cdsFile.State = dsEdit ) Then cdsFile.Post();

  DMImportExport.ImportConn.AppServer.ImportVCTextFile(cdsFile.Data, LinkedColumns.Text, SpecificConfig.Text, sError);

  LogError.Text := sError;

  if sError <> '' then
    ShowError(sError)
  else
    MsgBox('Import Success!', vbInformation + vbOKOnly);

  ScreenStatusOK;

  Result := inherited DoFinish();

end;



function TWizImportVendorCatalog.VerifyFieldsRequired: Boolean;
begin

  Result := True;

  if  (cbVendorList.Text  = '')
  then Result := False;

end;

procedure TWizImportVendorCatalog.GetConfigImport;
var
  sCrossColumns, sError : String;
  sCaseCost : WordBool;
begin

  sError := DMImportExport.GetConfigImport( TVendor(cbVendorList.Items.Objects[cbVendorList.Items.IndexOf(SpecificConfig.Values['Vendor'])]).IDVendor,
                                            IMPORT_TYPE_VC,
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

procedure TWizImportVendorCatalog.GetGridColumn(ACrosColumn: String);
var
  sColumn, sResult : String;
  i : integer;
begin

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

procedure TWizImportVendorCatalog.grdValidateModelFileTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
 bValidation : Boolean;
begin
  inherited;
  {
  if (AViewInfo.Item.Caption = 'Warning') then
  begin
    bValidation := VarAsType(AViewInfo.GridRecord.Values[FIndiceColumnValidation], varBoolean);
    if not bValidation then
      ACanvas.Font.Color := clRed;
  end;
  }
end;

procedure TWizImportVendorCatalog.btnSelectAllClick(Sender: TObject);
begin
  inherited;

  ScreenStatusWait;

  cdsFile.DisableControls();
  cdsFile.First();

  While ( Not cdsFile.Eof ) Do Begin

    CdsFile.Edit();
    CdsFile.FieldByName('UPDATE').AsInteger := btnSelectAll.Tag;

    cdsFile.Post();

    cdsFile.Next();
  End;


  If btnSelectAll.Tag = 0 Then Begin
    btnSelectAll.Caption := 'Select All';
    btnSelectAll.Tag     := 1
  End Else Begin
    btnSelectAll.Caption := 'Unselect All';
    btnSelectAll.Tag := 0;
  End;

  cdsFile.First();

  cdsFile.EnableControls();

  ScreenStatusOk;

end;

procedure TWizImportVendorCatalog.CbCostChangeChange(Sender: TObject);
begin
  inherited;

  FilterCdsFile();

end;

procedure TWizImportVendorCatalog.TbItemsOptionChange(Sender: TObject);
begin
  inherited;

  FilterCdsFile();

end;

procedure TWizImportVendorCatalog.CalculateCostChange(Sender: TObject);
begin

  cdsFile.FieldByname( 'CostChange' ).AsFloat  := cdsFile.FieldByname(LinkedColumns.Values['Cost']).AsFloat;

end;



procedure TWizImportVendorCatalog.cdsFileBeforePost(DataSet: TDataSet);
begin
  inherited;

  If ( ( pgOption.ActivePage.Name <> 'tsValidModel' ) And ( Trim( LinkedColumns.Values['Cost'] ) = '' ) )
  Then Exit;

  cdsFile.FieldByname( 'CostChange' ).AsFloat  := ( ( ( cdsFile.FieldByname(LinkedColumns.Values['Cost']).AsFloat -
                                                        cdsFile.FieldByName('OldCost').AsFloat ) /
                                                        cdsFile.FieldByName('OldCost').AsFloat ) * 100 );


end;

procedure TWizImportVendorCatalog.grdValidateModelFileExit(Sender: TObject);
begin
  inherited;

  If ( cdsFile.State = dsEdit ) Then cdsFile.Post();

end;

end.
