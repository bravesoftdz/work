unit uWizImportPet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ImgList, ExtCtrls, StdCtrls,
  Buttons, Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, uDMPuppyTracker;

type
  TWizImportPet = class(TParentWizImp)
    tsList: TTabSheet;
    grdListFile: TcxGrid;
    grdListFileTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    rgFileType: TGroupBox;
    rdHeaderFile: TRadioButton;
    rdPuppyFile: TRadioButton;
    cdsPetTreatment: TClientDataSet;
    cdsPetTreatmentSKU: TStringField;
    cdsPetTreatmentMicrochip: TStringField;
    cdsPetTreatmentCollar: TStringField;
    cdsPetTreatmentTreatment: TStringField;
    cdsPetTreatmentTreatmentType: TIntegerField;
    cdsPetTreatmentMfg: TStringField;
    cdsPetTreatmentTreatmentLotSize: TIntegerField;
    cdsPetTreatmentLotNumber: TStringField;
    cdsPetTreatmentLotExpirationDate: TDateTimeField;
    cdsPetTreatmentIDUser: TIntegerField;
    cdsPetTreatmentDosesUsed: TIntegerField;
    cdsPetTreatmentTreatExpirationDate: TDateTimeField;
    cdsPetTreatmentTreatmentDate: TDateTimeField;
    cdsPetTreatmentNotes: TStringField;
    cdsPetTreatmentSpecies: TStringField;
    procedure sgColumnsExit(Sender: TObject);
    procedure grdListFileTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsFileAfterOpen(DataSet: TDataSet);
  private
    FOption : String;
    FDMPuppyTracker : TDMPuppyTracker;
    procedure SaveGridColumns;
    procedure GetGridColumn;
    procedure AddColumnsToListGrid;
    procedure ImportPuppyTrackerFile;
    procedure InsertPuppyTrackerData;
    procedure InsertPuppyTrackerTreatmentData(ACollar, AMicrochip : String; PurchaseDate : TDateTime);
    procedure GetTreatmentDate(var AIniDate : TDateTime; var AEndDate : TDateTime; ADateRange : String);
    function GetFirstGivesDate(ADateRange : String) : TDateTime;
  protected
    procedure AddColumnsToImport; override;
    procedure FillColumnsGrid; override;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function VerifyFieldsRequired: Boolean;
    function DoFinish:Integer; override;
    function AddSpecificFieldsToCDS(Position : Integer): Integer; override;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;
    procedure OnBeforeBackClick; override;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport, uParentWizard,
     uSystemConst, StrUtils, uCDSFunctions;


{$R *.dfm}

{ TWizImportPet }

procedure TWizImportPet.AddColumnsToImport;
begin

  sgColumns.Cells[0,1]   := 'SKU';
  sgColumns.Cells[0,2]   := 'Species';
  sgColumns.Cells[0,3]   := 'Sex';
  sgColumns.Cells[0,4]   := 'Breed';
  sgColumns.Cells[0,5]   := 'Breeder';
  sgColumns.Cells[0,6]   := 'BreederAddress';
  sgColumns.Cells[0,7]   := 'BreederCity';
  sgColumns.Cells[0,8]   := 'BreederState';
  sgColumns.Cells[0,9]   := 'BreederZip';
  sgColumns.Cells[0,10]  := 'Microchip';
  sgColumns.Cells[0,11]  := 'MicrochipBrand';
  sgColumns.Cells[0,12]  := 'PenNumber';
  sgColumns.Cells[0,13]  := 'VendorCost';
  sgColumns.Cells[0,14]  := 'MSRP';
  sgColumns.Cells[0,15]  := 'SalePrice';
  sgColumns.Cells[0,16]  := 'PromoPrice';
  sgColumns.Cells[0,17]  := 'USDA';
  sgColumns.Cells[0,18]  := 'Collar';
  sgColumns.Cells[0,19]  := 'Sire';
  sgColumns.Cells[0,20]  := 'Dam';
  sgColumns.Cells[0,21]  := 'Whelpdate';
  sgColumns.Cells[0,22]  := 'Notes';
  sgColumns.Cells[0,23]  := 'Color';
  sgColumns.Cells[0,24]  := 'Status';
  sgColumns.Cells[0,25]  := 'PurchaseDate';
  sgColumns.Cells[0,26]  := 'Weight';
  sgColumns.Cells[0,27]  := 'WeightDate';
  sgColumns.Cells[0,28]  := 'Registry';
  sgColumns.Cells[0,29]  := 'RegistryNumber';

  sgColumns.RowCount := 30;

end;

procedure TWizImportPet.AddColumnsToListGrid;
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

function TWizImportPet.AddSpecificFieldsToCDS(Position: Integer): Integer;
begin
  Result := Position;
end;

procedure TWizImportPet.AddSpecificFriendFieldsToCDS(Position: Integer);
begin
  inherited;

end;

function TWizImportPet.DoFinish: Integer;
var
  sError: String;
begin
  Result := inherited DoFinish;

  ScreenStatusWait;

  DMImportExport.PetCenterConn.AppServer.ImportPetTextFile(cdsFile.Data,
    cdsPetTreatment.Data, LinkedColumns.Text, SpecificConfig.Text, sError);
    
  LogError.Text := sError;

  if sError <> '' then
    ShowError(sError)
  else
    MsgBox('Import Success!_Changes will not take effect until you exit the system and restart the application.', vbInformation + vbOKOnly);

  ScreenStatusOk;

end;

procedure TWizImportPet.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'System Fields';
  sgColumns.Cells[1,0] := 'File Fields';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

procedure TWizImportPet.GetGridColumn;
var
  sColumn, sError, sResult : String;
  sCaseCost : WordBool;
  i : integer;
begin

  //sColumn := DMImportExport.GetAppProperty('ColumnImportPetSetup', 'Columns' + FOption);
  sError := DMImportExport.GetConfigImport(
      0,
      IMPORT_TYPE_PET,
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
  end
  else
  begin
    MsgBox(LogError.Text, vbCritical + vbOkOnly);
  end;
end;

function TWizImportPet.OnAfterChangePage: Boolean;
var
  Passed : Boolean;
begin

  Passed := False;

  Result := True;

  if pgOption.ActivePage.Name = 'tsDatabase' then
  begin
    cdsPetTreatment.Close;
    if rdHeaderFile.Checked then
    begin
      MountFileonGrid;
      FOption := '';
    end
    else
    begin
      ImportPuppyTrackerFile;
      FOption := '_Hunt';
    end
  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    cbColumns.Visible := False;
    FillColumnsGrid;
    GetGridColumn;
  end
  else if pgOption.ActivePage.Name = 'tsList' then
  begin
    SaveGridColumns;

    ScreenStatusWait;
    SetGridToRegistryValues(MR_BRW_REG_PATH + 'MRImportExport\ImpPet\Vendor_Column_List', grdListFile);

    cdsFile.Data := (DMImportExport.PetCenterConn.AppServer.ValidatePetTextFile(cdsFile.Data,
      LinkedColumns.Text, SpecificConfig.Text, LogError.Text, Passed));

    grdListFileTableView.DataController.DataSource := dtsFile;
    AddColumnsToListGrid;

    RestoreGridFromRegistry;

    ScreenStatusOk;
  end
  else if pgOption.ActivePage.Name = 'tsImport' then
  begin
  {
    ScreenStatusWait;
    DMImportExport.PetCenterConn.AppServer.ImportPetTextFile(cdsFile.Data,
      LinkedColumns.Text, SpecificConfig.Text, sError);
    LogError.Text := sError;

    if sError <> '' then
      ShowError(sError)
    else
      MsgBox('Import Success!', vbInformation + vbOKOnly);

    ScreenStatusOk;
    }
  end;
end;

procedure TWizImportPet.SaveGridColumns;
var
  sColumn, sError : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
    if Trim(sgColumns.Cells[0,i]) <> '' then
      sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
    Exit;

  //DMImportExport.SetAppProperty('ColumnImportPetSetup', 'Columns' + FOption, sColumn);

  sError := DMImportExport.InsertConfigImport(
  0,
  IMPORT_TYPE_PET,
  sColumn,
  False);
  LogError.Text := sError;

  if LogError.Text <> '' then
  begin
    MsgBox(LogError.Text, vbCritical + vbOkOnly);
  end;

end;

function TWizImportPet.TestBeforeNavigate: Boolean;
begin

  Result := inherited TestBeforeNavigate;

  if pgOption.ActivePage.Name = 'tsList' then
     SaveGridToRegistry;

end;

function TWizImportPet.VerifyFieldsRequired: Boolean;
begin
  Result := True;
end;

procedure TWizImportPet.sgColumnsExit(Sender: TObject);
begin
  inherited;
  //SaveGridColumns;
end;

procedure TWizImportPet.grdListFileTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  i : Integer;
begin
  inherited;

  {
  i := grdListFileTableView.DataController.GetItemByFieldName('Warning').Index;
  if AViewInfo.GridRecord.Values[i] <> '' then
    ACanvas.Font.Color := clRed
  else
    ACanvas.Font.Color := clBlack;
  }
  
end;

procedure TWizImportPet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if FDMPuppyTracker <> nil then
    FreeAndNil(FDMPuppyTracker);
end;

procedure TWizImportPet.ImportPuppyTrackerFile;
begin
  try
    ScreenStatusWait;
    FDMPuppyTracker := TDMPuppyTracker.Create(Self);
    if FDMPuppyTracker.LoadPuppyTrackerData(edtFilePath.Text) then
    begin

  sgColumns.Cells[0,12]  := '';
  sgColumns.Cells[0,13]  := '';
  sgColumns.Cells[0,15]  := '';
  sgColumns.Cells[0,16]  := '';
  sgColumns.Cells[0,21]  := '';
  sgColumns.Cells[0,22]  := '';
  sgColumns.Cells[0,24]  := '';
  sgColumns.Cells[0,29]  := '';


      CreateCDSField(cdsFile, 'SKU', ftString, 1, False, 50);
      CreateCDSField(cdsFile, 'Collar', ftString, 2, True, 50);
      CreateCDSField(cdsFile, 'Breed', ftString, 3, False, 50);
      CreateCDSField(cdsFile, 'Sex', ftString, 4, False, 15);
      CreateCDSField(cdsFile, 'Color', ftString, 5, False, 50);
      CreateCDSField(cdsFile, 'USDA', ftString, 6, False, 50);
      CreateCDSField(cdsFile, 'Microchip', ftString, 7, False, 50);
      CreateCDSField(cdsFile, 'Notes', ftString, 8, False, 255);
      CreateCDSField(cdsFile, 'Registry', ftString, 9, False, 50);
      CreateCDSField(cdsFile, 'RegistryNumber', ftString, 10, False, 50);
      CreateCDSField(cdsFile, 'Dam', ftString, 11, False, 255);
      CreateCDSField(cdsFile, 'Sire', ftString, 12, False, 255);
      CreateCDSField(cdsFile, 'Weight', ftFloat, 13);
      CreateCDSField(cdsFile, 'WeightDate', ftDateTime, 14); // = Date_Purchased - 5 dias
      CreateCDSField(cdsFile, 'VendorCost', ftCurrency, 15);
      CreateCDSField(cdsFile, 'SalePrice', ftCurrency, 16);
      CreateCDSField(cdsFile, 'Invoice_Date', ftDateTime, 17);
      CreateCDSField(cdsFile, 'Whelpdate', ftDateTime, 18);
      CreateCDSField(cdsFile, 'Species', ftString, 19, False, 10);
      CreateCDSField(cdsFile, 'Breeder', ftString, 20, False, 50); //First Name + Last Name
      CreateCDSField(cdsFile, 'BreederAddress', ftString, 21, False, 80);
      CreateCDSField(cdsFile, 'BreederCity', ftString, 22, False, 40);
      CreateCDSField(cdsFile, 'BreederState', ftString, 23, False, 50);
      CreateCDSField(cdsFile, 'BreederZip', ftString, 24, False, 12);

      // - Campo para validar o registro.
      CreateCDSField(cdsFile, 'Validation', ftBoolean, 25, True);

      // - Campo para registrar algum erro.
      CreateCDSField(cdsFile, 'Warning', ftString, 26, True, 50);

      iDatabaseColumns := 24;
      iValidateColumns := 26;

      if AddColumnsToGrid then
        InsertPuppyTrackerData;
    end;
  finally
    ScreenStatusOk;
  end;
end;

procedure TWizImportPet.InsertPuppyTrackerData;
var
  dPurchaseDate : TDateTime;
begin

  dPurchaseDate := 0;

  if FDMPuppyTracker <> nil then
    with FDMPuppyTracker do
    try

       grdFileTableView.DataController.DataSource := dtsFile;
       cdsFile.DisableControls;

       if not cdsFile.Active then
         cdsFile.CreateDataSet;

       cdsPup.First;
       while not cdsPup.Eof do
       begin
         cdsFile.Append;
         cdsFile.FieldByName('Collar').Value       := cdsPup.FieldByName('Puppy_No').AsString;
         cdsFile.FieldByName('Sex').Value          := cdsPup.FieldByName('Sex').AsString;
         cdsFile.FieldByName('Color').Value        := cdsPup.FieldByName('Color').AsString;
         cdsFile.FieldByName('USDA').Value         := cdsPup.FieldByName('USDA').AsString;
         cdsFile.FieldByName('Microchip').Value    := cdsPup.FieldByName('Chip_No').AsString;
         cdsFile.FieldByName('VendorCost').Value   := cdsPup.FieldByName('Sales_Price').AsCurrency;
         cdsFile.FieldByName('Weight').Value       := cdsPup.FieldByName('Weight').AsCurrency;
         cdsFile.FieldByName('Invoice_Date').Value := cdsPup.FieldByName('Invoice_Date').AsDateTime;
         cdsFile.FieldByName('WeightDate').Value   := cdsPup.FieldByName('Date_Purchased').AsDateTime;
         cdsFile.FieldByName('Notes').Value        := cdsPup.FieldByName('Inv_Comments').AsString;

         cdsLitters.First;
         if cdsLitters.Locate('Litter_No', cdsPup.FieldByName('Litter_No').AsString, []) then
         begin
           cdsFile.FieldByName('RegistryNumber').Value := cdsLitters.FieldByName('Registry_No').AsString;
           cdsFile.FieldByName('Whelpdate').Value      := cdsLitters.FieldByName('Whelp_Date').AsDateTime;
           cdsFile.FieldByName('Registry').Value       := cdsLitters.FieldByName('Registry').AsString;
           dPurchaseDate                               := cdsLitters.FieldByName('Litter_Pur_Date').AsDateTime;

           cdsBreeder.First;
           if cdsBreeder.Locate('Breeder', cdsLitters.FieldByName('Breeder').AsString, []) then
           begin
             cdsFile.FieldByName('BreederAddress').Value  := cdsBreeder.FieldByName('Address1').AsString;
             cdsFile.FieldByName('BreederCity').Value     := cdsBreeder.FieldByName('City').AsString;
             cdsFile.FieldByName('BreederState').Value    := cdsBreeder.FieldByName('State').AsString;
             cdsFile.FieldByName('BreederZip').Value      := cdsBreeder.FieldByName('Zip').AsString;
             cdsFile.FieldByName('Breeder').Value         := cdsBreeder.FieldByName('First_Name').AsString + ' ' + cdsBreeder.FieldByName('Last_Name').AsString;
           end;

           cdsPedigrees.First;
           if cdsPedigrees.Locate('akc_registry', cdsLitters.FieldByName('Dam').AsString, []) then
             cdsFile.FieldByName('Dam').Value := cdsPedigrees.FieldByName('dog_name').Value;

           cdsPedigrees.First;
           if cdsPedigrees.Locate('akc_registry', cdsLitters.FieldByName('Sire').AsString, []) then
             cdsFile.FieldByName('Sire').Value := cdsPedigrees.FieldByName('dog_name').Value;
         end;

         cdsBreed.First;
         if cdsBreed.Locate('Breed_Code', cdsPup.FieldByName('Breed').AsString, []) then
         begin
           cdsFile.FieldByName('Breed').Value   := cdsBreed.FieldByName('Breed_Name').AsString;
           cdsFile.FieldByName('Species').Value := cdsBreed.FieldByName('Species').AsString;
         end;

         cdsFile.FieldByName('Validation').AsBoolean := True;

         cdsFile.Post;

         InsertPuppyTrackerTreatmentData(cdsFile.FieldByName('Collar').Value,
                                         cdsFile.FieldByName('Microchip').Value,
                                         dPurchaseDate);

         cdsPup.Next;
       end;
    finally
      cdsFile.EnableControls;
    end;
end;

procedure TWizImportPet.InsertPuppyTrackerTreatmentData(ACollar,
  AMicrochip: String; PurchaseDate : TDateTime);
var
  TreatmentIniDate,
  TreatmentEndDate,
  TreatmentEndWeekDate : TDateTime;
begin
  if FDMPuppyTracker <> nil then
    with FDMPuppyTracker do
    begin
      //Houseshots
      cdsHouseShots.First;
      while not cdsHouseShots.Eof do
      begin
        GetTreatmentDate(TreatmentIniDate, TreatmentEndDate, cdsHouseShots.FieldByName('Dates_Given').AsString);
        TreatmentEndWeekDate := cdsHouseShots.FieldByName('Week_Ending_Date').AsDateTime;

        if (PurchaseDate < TreatmentEndWeekDate) then
        begin
          cdsPetTreatment.Append;

          cdsPetTreatment.FieldByName('Microchip').Value := AMicrochip;
          cdsPetTreatment.FieldByName('Collar').Value    := ACollar;
          cdsPetTreatment.FieldByName('IDUser').Value    := DMImportExport.FUser.ID;

          cdsVaccines.First;
          if cdsVaccines.Locate('Vaccine_Code', cdsHouseShots.FieldByName('Vaccine_Code').AsString, []) then
          begin
            cdsPetTreatment.FieldByName('Treatment').Value     := cdsVaccines.FieldByName('Vaccine_Name').AsString;
            cdsPetTreatment.FieldByName('TreatmentType').Value := cdsVaccines.FieldByName('Type').AsInteger;

            cdsVaccManu.First;
            if cdsVaccManu.Locate('Manu_Code', cdsHouseShots.FieldByName('Manu_Code').AsString, []) then
              cdsPetTreatment.FieldByName('Mfg').Value := cdsVaccManu.FieldByName('Manufacturer').AsString;
          end;

          cdsPetTreatment.FieldByName('LotNumber').Value           := cdsHouseShots.FieldByName('Lot').AsString;
          cdsPetTreatment.FieldByName('LotExpirationDate').Value   := cdsHouseShots.FieldByName('Expires').AsDateTime;
          cdsPetTreatment.FieldByName('Species').Value             := cdsHouseShots.FieldByName('Species').AsString;
          cdsPetTreatment.FieldByName('TreatExpirationDate').Value := cdsHouseShots.FieldByName('Expires').AsDateTime;
          cdsPetTreatment.FieldByName('Notes').Value               := cdsHouseShots.FieldByName('Dates_Given').AsString;
          cdsPetTreatment.FieldByName('TreatmentDate').Value       := TreatmentIniDate;
          cdsPetTreatment.Post;
        end;
        
        cdsHouseShots.Next;
      end;

      //Puppyshots
      cdsPuppyShots.Filtered := False;
      cdsPuppyShots.Filter := 'Puppy_No = ' + QuotedStr(ACollar);
      cdsPuppyShots.Filtered := True;
      cdsPuppyShots.First;
      while not cdsPuppyShots.Eof do
      begin
        cdsPetTreatment.Append;

        cdsPetTreatment.FieldByName('Microchip').Value := AMicrochip;
        cdsPetTreatment.FieldByName('Collar').Value    := ACollar;
        cdsPetTreatment.FieldByName('IDUser').Value    := DMImportExport.FUser.ID;

        cdsVaccines.First;
        if cdsVaccines.Locate('Vaccine_Code', cdsPuppyShots.FieldByName('Vaccine_Code').AsString, []) then
        begin
          cdsPetTreatment.FieldByName('Treatment').Value     := cdsVaccines.FieldByName('Vaccine_Name').AsString;
          cdsPetTreatment.FieldByName('TreatmentType').Value := cdsVaccines.FieldByName('Type').AsInteger;

          cdsVaccManu.First;
          if cdsVaccManu.Locate('Manu_Code', cdsPuppyShots.FieldByName('Manu_Code').AsString, []) then
            cdsPetTreatment.FieldByName('Mfg').Value := cdsVaccManu.FieldByName('Manufacturer').AsString;
        end;

        cdsPetTreatment.FieldByName('LotNumber').Value           := cdsPuppyShots.FieldByName('Lot').AsString;
        cdsPetTreatment.FieldByName('LotExpirationDate').Value   := cdsPuppyShots.FieldByName('Expires').AsDateTime;
        cdsPetTreatment.FieldByName('Species').Value             := FormatSpecies('D');
        cdsPetTreatment.FieldByName('TreatExpirationDate').Value := cdsPuppyShots.FieldByName('Expires').AsDateTime;
        cdsPetTreatment.FieldByName('Notes').Value               := cdsPuppyShots.FieldByName('Dates_Given').AsString;
        cdsPetTreatment.FieldByName('TreatmentDate').Value       := GetFirstGivesDate(cdsPuppyShots.FieldByName('Dates_Given').AsString);

        cdsPetTreatment.Post;
        cdsPuppyShots.Next;
      end;
    end;
end;

procedure TWizImportPet.cdsFileAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if not cdsPetTreatment.Active then
    cdsPetTreatment.CreateDataSet;
end;

procedure TWizImportPet.GetTreatmentDate(var AIniDate, AEndDate: TDateTime;
  ADateRange: String);
var
  sDate : String;
begin
  AIniDate := GetFirstGivesDate(ADateRange);

  if Pos('-', ADateRange) > 0 then
  begin
    sDate := Copy(ADateRange, Pos('-', ADateRange)+2, length(ADateRange)-2);
    sDate := Copy(sDate, 1, 10);
    AEndDate := StrToDateTimeDef(sDate, Trunc(Now));
  end
  else
    AEndDate := AIniDate;
end;

function TWizImportPet.GetFirstGivesDate(ADateRange: String): TDateTime;
var
  sDate : String;
begin
  sDate := Copy(ADateRange, 1, 10);
  Result := StrToDateTimeDef(sDate, Trunc(Now));
end;

procedure TWizImportPet.OnBeforeBackClick;
begin
  if pgOption.ActivePage.Name = 'tsCrossColumn' then
    SaveGridColumns;

  inherited;

end;

end.
