unit uWizExportPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, Provider, DBClient, ImgList, StdCtrls,
  ExtCtrls, Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ComCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Mask, DateBox,
  uParentWizExp, ADODB;

const
  NAME_FILE_PO   = '(PO)';
  NAME_FILE_VENDORCODE = '(VC)';
  NAME_FILE_ACCOUNT = '(ACC)';

  INDEX_NAME_FILE_PO         = 3;
  INDEX_NAME_FILE_VENDORCODE = 4;
  INDEX_NAME_FILE_ACCOUNT    = 5;

  HEADER_CONFIG_PO         = '(PO)';
  HEADER_CONFIG_VENDORNAME = '(VNA)';

  INDEX_HEADER_CONFIG_PO         = 3;
  INDEX_HEADER_CONFIG_VENDORCODE = 4;

type
  TWizExportPO = class(TParentWizExp)
    gbSupplier: TGroupBox;
    Label11: TLabel;
    edPONumber: TEdit;
    btnClearList: TBitBtn;
    procedure btnAddFormatClick(Sender: TObject);
    procedure btnAddHeaderConfigClick(Sender: TObject);
    procedure tsSpecificConfigShow(Sender: TObject);
    procedure edPONumberKeyPress(Sender: TObject; var Key: Char);
    procedure btnClearListClick(Sender: TObject);
   private
    IDFornecedor : Integer;
    procedure RestoreFromRegistry;
    procedure AddDefaultColumnsToListGrid;
    procedure LoadVendorValues;
    procedure SaveVendorValues;
   protected
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function DoFinish:Integer; override;
    function VerifyFieldsRequired: Boolean;
    procedure SetFileName; override;
    procedure SetHeaderConfig; override;
    procedure ConfigFileFormatScreen; override;
    procedure SaveFileName(Value: String); override;
    function GetExportFilePath: String; override;
    procedure SetExportFilePath(Value: String); override;
    function OnBeforeNextClick: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport, uSystemConst, uNumericFunctions,
  uParentWizard;

{$R *.dfm}

{ TWizExportPO }

function TWizExportPO.DoFinish: Integer;
begin
  Result := inherited DoFinish;
end;

function TWizExportPO.OnAfterChangePage: Boolean;
var
  sError : string;
begin
  Result := inherited OnAfterChangePage;

  if pgOption.ActivePage.Name = 'tsList' then
  begin
    ScreenStatusWait;

    grdFileTableView.DataController.DataSource := dtsFile;
    cdsFile.Data := DMImportExport.ExportConn.AppServer.ExportPO(cdsFile.Data, edPONumber.Text, sError);
    LogError.Text := sError;
    fRegistryPath := MR_BRW_REG_PATH + 'MRImportExport\ExpPO\Vendor_' + cdsFile.FieldByName('IDVendor').AsString;
    IDFornecedor := cdsFile.FieldByName('IDVendor').AsInteger;

    if RegisterExists(fRegistryPath) then
      begin
        AddColumnsToListGrid;

        if not (cdsFile.IsEmpty) then
          RestoreFromRegistry;
      end
    else
      AddDefaultColumnsToListGrid;

    LoadVendorValues;
    ScreenStatusOk;
  end;

end;

function TWizExportPO.OnBeforeNextClick: Boolean;
begin

  if pgOption.ActivePage.Name = 'tsConfigFile' then
    SaveVendorValues;

  Result := True;
    
end;

procedure TWizExportPO.RestoreFromRegistry;
begin

  inherited;
end;

function TWizExportPO.TestBeforeNavigate: Boolean;
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

    AddSpecificConfigList('PONumber',edPONumber.Text);
    AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
  end;

end;

function TWizExportPO.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if  (edPONumber.Text = '') then
    Result := False;
end;

procedure TWizExportPO.btnAddFormatClick(Sender: TObject);
var
  OptionName : String;
begin
  inherited;
  case cbxFileFormat.ItemIndex of
    INDEX_NAME_FILE_PO         : OptionName := NAME_FILE_PO;
    INDEX_NAME_FILE_VENDORCODE : OptionName := NAME_FILE_VENDORCODE;
    INDEX_NAME_FILE_ACCOUNT    : OptionName := NAME_FILE_ACCOUNT;
  end;

  if OptionName <> '' then
    AddtoFileName(OptionName);
end;

procedure TWizExportPO.SetFileName;
var
  Year, Month, Day: String;
begin
  inherited;

  if edtFileFormat.text <> '' then
  begin
    Year := FormatDateTime('yyyy',Now);
    Month := FormatDateTime('mm',Now);
    Day := FormatDateTime('dd',Now);

    fFileName := edtFileFormat.Text;

    fFileName := StringReplace(fFileName, NAME_FILE_DAY, Day, [rfReplaceAll]);
    fFileName := StringReplace(fFileName, NAME_FILE_MONTH, Month, [rfReplaceAll]);
    fFileName := StringReplace(fFileName, NAME_FILE_YEAR, Year, [rfReplaceAll]);
    fFileName := StringReplace(fFileName, NAME_FILE_PO, SpecificConfig.Values['PONumber'], [rfReplaceAll]);
    fFileName := StringReplace(fFileName, NAME_FILE_VENDORCODE, cdsFile.FieldByName('Usercode').AsString, [rfReplaceAll]);
    fFileNAme := StringReplace(fFileName, NAME_FILE_ACCOUNT, cdsFile.FieldByName('VendorAccount').AsString, [rfReplaceAll]);
  end
  else
    fFileName := cdsFile.FieldByName('StoreName').AsString;

  fFileName := RemoveInvalidCaracter(fFileName) + '.txt';
end;

procedure TWizExportPO.btnAddHeaderConfigClick(Sender: TObject);
begin

  case cbxHeaderConfig.ItemIndex of
    INDEX_HEADER_CONFIG_ADDRESS    : mHeaderConfig.Lines.Add(HEADER_CONFIG_ADDRESS);
    INDEX_HEADER_CONFIG_CITY       : mHeaderConfig.Lines.Add(HEADER_CONFIG_CITY);
    INDEX_HEADER_CONFIG_CEP        : mHeaderConfig.Lines.Add('(ZIP)');
    INDEX_HEADER_CONFIG_PO         : mHeaderConfig.Lines.Add(HEADER_CONFIG_PO);
    INDEX_HEADER_CONFIG_VENDORCODE : mHeaderConfig.Lines.Add(HEADER_CONFIG_VENDORNAME);
    else mHeaderConfig.Lines.Add(cbxHeaderConfig.Text);
  end;
  
end;

procedure TWizExportPO.SetHeaderConfig;
var
  i : Integer;
  Line : String;
begin
  inherited;

  for i :=0 to Pred(mHeaderConfig.Lines.Count) do
  begin
    Line := mHeaderConfig.Lines[i];

    while Pos('(ADD)', Line) > 0 do
      Line := StringReplace(Line, '(ADD)', cdsFile.FieldByName('Vendor').AsString, [rfReplaceAll]);

    while Pos('(CTY)', Line) > 0 do
      Line := StringReplace(Line, '(CTY)', cdsFile.FieldByName('City').AsString, [rfReplaceAll]);

    while Pos('(ZIP)', Line) > 0 do
      Line := StringReplace(Line, '(ZIP)', cdsFile.FieldByName('ZIP').AsString, [rfReplaceAll]);

    while Pos('(PO)', Line) > 0 do
      Line := StringReplace(Line, '(PO)', SpecificConfig.Values['PONumber'], [rfReplaceAll]);

    while Pos('(VNA)', Line) > 0 do
      Line := StringReplace(Line, '(VNA)', cdsFile.FieldByName('Vendor').AsString, [rfReplaceAll]);

    mHeaderConfig.Lines[i] := Line;
  end;
end;

procedure TWizExportPO.ConfigFileFormatScreen;
begin
  inherited;
  lbInfo.Caption := 'Export Po File Format';
end;

procedure TWizExportPO.SaveFileName(Value: String);
begin
  inherited;
  //
end;

procedure TWizExportPO.AddDefaultColumnsToListGrid;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
begin
  grdFileTableView.ClearItems;
  for i := 0 to Pred(cdsFile.FieldDefs.Count) do
  begin
    NewColumn := grdFileTableView.CreateColumn;
    with NewColumn do
    begin
      Caption := cdsFile.FieldDefs[i].DisplayName;
      Name    := 'grdFileTableViewDB' + cdsFile.FieldDefs[i].DisplayName;
      DataBinding.FieldName := cdsFile.FieldDefs[i].Name;

      if (cdsFile.FieldDefs[i].DisplayName <> 'Barcode') and
         (cdsFile.FieldDefs[i].DisplayName <> 'Qty') and
         (cdsFile.FieldDefs[i].DisplayName <> 'CaseQty') and
         (cdsFile.FieldDefs[i].DisplayName <> 'VendorCode') and
         (cdsFile.FieldDefs[i].DisplayName <> 'Model') then
          Visible := False;
    end;
  end;
end;

procedure TWizExportPO.tsSpecificConfigShow(Sender: TObject);
begin
  inherited;
  edPONumber.SetFocus;
end;

procedure TWizExportPO.edPONumberKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btNextClick(Self);
end;

procedure TWizExportPO.LoadVendorValues;
var
  sDelimiterSeparator, sDecimalSeparator, sHeaderConfig, sFileFormat, sError: String;
  sHeaderFile: WordBool;
begin
  {
  edtDelimiter.Text             := DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Delimiter');
  edtDecimalDelimiter.Text      := DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Decimal');
  mHeaderConfig.Lines.CommaText := DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_HeaderConfig');
  edtFileFormat.Text            := DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_FileFormat');
  cbxColumnsHeaderFile.Checked  := (DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Headerfile') = 'Y');
   }
  sError := DMImportExport.GetConfigExport(
            IDFornecedor,
            EXPORT_TYPE_PO,
            sDelimiterSeparator,
            sDecimalSeparator,
            sHeaderConfig,
            sFileFormat,
            sHeaderFile);
  LogError.Text := sError;

  if LogError.Text = '' then
  begin
    edtPath.Text                  := DMImportExport.GetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_FilePath');
    edtDelimiter.Text             := sDelimiterSeparator;
    edtDecimalDelimiter.Text      := sDecimalSeparator;
    mHeaderConfig.Lines.CommaText := sHeaderConfig;
    edtFileFormat.Text            := sFileFormat;
    cbxColumnsHeaderFile.Checked  := sHeaderFile;
  end
end;

procedure TWizExportPO.SaveVendorValues;
var
  sError : String;
begin
 {
 DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Delimiter', edtDelimiter.Text);
 DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Decimal', edtDecimalDelimiter.Text);
 DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_HeaderConfig', mHeaderConfig.Lines.CommaText);
 DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_FileFormat', edtFileFormat.Text);

 if cbxColumnsHeaderFile.Checked then
   sColumnHeader := 'Y'
 else
   sColumnHeader := 'N';

 DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_Headerfile', sColumnHeader);
 }

  DMImportExport.SetAppProperty('ConfigExport_' + IntTostr(IDFornecedor), 'PO_FilePath', edtPath.Text);

  sError := DMImportExport.InsertConfigExport(
            IDFornecedor,
            edtDelimiter.Text,
            edtDecimalDelimiter.Text,
            mHeaderConfig.Lines.CommaText,
            edtFileFormat.Text,
            cbxColumnsHeaderFile.Checked,
            EXPORT_TYPE_PO);

  LogError.Text := sError;

  if LogError.Text <> '' then
  begin
    MsgBox(LogError.Text, vbCritical + vbOkOnly);
  end;


end;

function TWizExportPO.GetExportFilePath: String;
begin

end;

procedure TWizExportPO.SetExportFilePath(Value: String);
begin
  inherited;

end;

procedure TWizExportPO.btnClearListClick(Sender: TObject);
begin
  inherited;
  mHeaderConfig.Clear;
end;

end.
