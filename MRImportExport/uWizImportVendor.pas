unit uWizImportVendor;

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

  TWizImportVendor = class(TParentWizExp)
    gbSupplier: TGroupBox;
    Label11: TLabel;
    edPONumber: TEdit;
    btnClearList: TBitBtn;
    Label4: TLabel;
    Label21: TLabel;
    procedure btnAddFormatClick(Sender: TObject);
    procedure btnAddHeaderConfigClick(Sender: TObject);
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
    function OnBeforeNextClick: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport, uSystemConst, uNumericFunctions,
  uParentWizard;

{$R *.dfm}

{==============================================================================}
{ Vendor controls                                                               
constructor TVendor.Create(IDPessoa : Variant);
begin
  IDVendor := IDPessoa;
end;

procedure TWizImportVendor.AddComboVendor;
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

procedure TWizImportVendor.ClearComboVendor;
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
{ TWizImportVendor                                                             }
function TWizImportVendor.DoFinish: Integer;
begin
  Result := inherited DoFinish;
end;

function TWizImportVendor.OnAfterChangePage: Boolean;
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

function TWizImportVendor.OnBeforeNextClick: Boolean;
begin

  if pgOption.ActivePage.Name = 'tsConfigFile' then
    SaveVendorValues;

  Result := True;
    
end;

procedure TWizImportVendor.RestoreFromRegistry;
begin

  inherited;
end;

function TWizImportVendor.TestBeforeNavigate: Boolean;
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

function TWizImportVendor.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if  (edPONumber.Text = '') then
    Result := False;
end;

procedure TWizImportVendor.btnAddFormatClick(Sender: TObject);
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

procedure TWizImportVendor.SetFileName;
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

procedure TWizImportVendor.btnAddHeaderConfigClick(Sender: TObject);
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

procedure TWizImportVendor.SetHeaderConfig;
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

procedure TWizImportVendor.ConfigFileFormatScreen;
begin
  inherited;
  lbInfo.Caption := 'Export Po File Format';
end;

procedure TWizImportVendor.SaveFileName(Value: String);
begin
  inherited;
  //
end;

procedure TWizImportVendor.AddDefaultColumnsToListGrid;
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

procedure TWizImportVendor.LoadVendorValues;
var
  sDelimiterSeparator, sDecimalSeparator, sHeaderConfig, sFileFormat, sError: String;
  sHeaderFile: WordBool;
begin
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

procedure TWizImportVendor.SaveVendorValues;
var
  sError : String;
begin

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

procedure TWizImportVendor.btnClearListClick(Sender: TObject);
begin
  inherited;
  mHeaderConfig.Clear;
end;

end.
