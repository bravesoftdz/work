unit uParentWizExp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizard, ImgList, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Grids,
  Provider, DBClient, ADODB, Registry;

const
  NAME_FILE_DAY   = '(DD)';
  NAME_FILE_MONTH = '(MM)';
  NAME_FILE_YEAR  = '(YY)';

  INDEX_NAME_FILE_DAY   = 0;
  INDEX_NAME_FILE_MONTH = 1;
  INDEX_NAME_FILE_YEAR  = 2;

  HEADER_CONFIG_ADDRESS = '(ADD)';
  HEADER_CONFIG_CITY    = '(CTY)';
  HEADER_CONFIG_CEP     = '(CEP)';

  INDEX_HEADER_CONFIG_ADDRESS = 0;
  INDEX_HEADER_CONFIG_CITY    = 1;
  INDEX_HEADER_CONFIG_CEP     = 2;
type
  TParentWizExp = class(TParentWizard)
    tsConfigFile: TTabSheet;
    tsSpecificConfig: TTabSheet;
    tsList: TTabSheet;
    tsExport: TTabSheet;
    OD: TOpenDialog;
    cbxBKPDevice: TGroupBox;
    sbOpenBKP: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtPath: TEdit;
    edtDelimiter: TEdit;
    edtDecimalDelimiter: TEdit;
    Panel2: TPanel;
    btColumn: TSpeedButton;
    cdsFile: TClientDataSet;
    dtsFile: TDataSource;
    grdFile: TcxGrid;
    grdFileTableView: TcxGridDBTableView;
    grdFileLevel: TcxGridLevel;
    tsFileFormat: TTabSheet;
    Label5: TLabel;
    cbxFileFormat: TComboBox;
    btnAddFormat: TBitBtn;
    edtFileFormat: TEdit;
    lbInfo: TLabel;
    GroupBox1: TGroupBox;
    cbxColumnsHeaderFile: TCheckBox;
    mHeaderConfig: TMemo;
    cbxHeaderConfig: TComboBox;
    btnAddHeaderConfig: TBitBtn;
    procedure sbOpenBKPClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDecimalDelimiterKeyPress(Sender: TObject; var Key: Char);
    procedure edtDelimiterKeyPress(Sender: TObject; var Key: Char);
    procedure BNextClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btnAddFormatClick(Sender: TObject);
    procedure cbxColumnsHeaderFileClick(Sender: TObject);
    procedure btnAddHeaderConfigClick(Sender: TObject);
  private
    Delimiter        : Char;
    DecimalDelimiter : Char;
    FSpecificConfig  : TStringList;
    HeaderFile       : Boolean;
    procedure GridCustomization(Status: Boolean);
    procedure CloseRegister(Way: String);
  protected
    AOptions : TcxGridStorageOptions;
    AView    : TcxCustomGridTableView;
    fRegistryPath : String;
    fFileName      : String;
    property SpecificConfig: TStringList read FSpecificConfig write FSpecificConfig;
    
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function DoFinish:Integer; override;
    procedure AddSpecificConfigList(pLabel, Value: String);
    procedure AddColumnsToListGrid;
    procedure RestoreFromRegistry;
    function SaveDataToFile: Boolean;
    function RegisterExists(Way: String): boolean;
    procedure ScreenStatusWait;
    procedure ScreenStatusOk;
    procedure AddtoFileName(OptionName: String);
    procedure SetFileName; virtual; abstract;
    procedure SetHeaderConfig; virtual; abstract;
    function GetExportFilePath: String; virtual; abstract;
    procedure SetExportFilePath(Value: String); virtual; abstract;
    procedure ConfigFileFormatScreen; virtual; abstract;
    procedure SaveFileName(Value: String); virtual; abstract;

    function RemoveInvalidCaracter(Value: String): String;
  public
    function Start: Boolean; override;
  end;

implementation

uses uMsgBox, uStringFunctions, uDMGlobalNTier, uCharFunctions, uNumericFunctions,
  uDMImportExport, uSystemConst, uFrmLog;

{$R *.dfm}

procedure TParentWizExp.AddColumnsToListGrid;
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
    end;
  end;
end;

function TParentWizExp.RegisterExists(Way: String): boolean;
Var
  Registro: TRegistry;
Begin
  Registro := TRegistry.Create;
  Try
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.CloseKey;
    Result := Registro.KeyExists(Way);
    Registro.CloseKey;
  finally
    FreeAndNil(Registro);
  end;
end;

procedure TParentWizExp.CloseRegister(Way: String);
Var
  Registro: TRegistry;
Begin
  Registro := TRegistry.Create;
  Try
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey(Way,false);
    Registro.CloseKey;
  finally
    FreeAndNil(Registro);
  end;
end;

procedure TParentWizExp.AddSpecificConfigList(pLabel, Value: String);
begin
  if Value <> '' then
    SpecificConfig.Add(pLabel + '=' + Value);
end;

procedure TParentWizExp.GridCustomization(Status: Boolean);
begin
  TcxGridDBTableView(AView).Controller.Customization := Status;
end;

function TParentWizExp.OnAfterChangePage: Boolean;
begin
  Result := True;

  if pgOption.ActivePage.Name = 'tsExport' then
  begin
    try
      GridCustomization(False);

      ScreenStatusWait;

      grdFileTableView.DataController.DataSource := nil;

      SaveFileName(edtFileFormat.Text);

      SetFileName;

      SaveDataToFile;
      if LogError.Text <> '' then
      begin
        with TFrmLog.Create(Self) do
        try
          MsgLog.Text;// := sError;
          Start;
        finally
          Free;
        end;
      end
      else
        MsgBox('Export Success!', vbInformation + vbOKOnly);
      ScreenStatusOk;
    except
      ScreenStatusOk;
      MsgBox('Export Error!', vbInformation + vbOKOnly);
    end;
  end
  else if pgOption.ActivePage.Name = 'tsFileFormat' then
    begin
      if fRegistryPath <> '' then
        begin
          TcxGridDBTableView(AView).StoreToRegistry(fRegistryPath, True, AOptions);
          CloseRegister(fRegistryPath);
        end;
      ConfigFileFormatScreen;
    end;


end;

function TParentWizExp.SaveDataToFile: Boolean;
var
  i: integer;
  txt : String;
  FieldValue : String;
  FFile : TStringList;
begin

 FFile := TStringList.Create;
  try

    if mHeaderConfig.Lines.Count > 0 then
    begin
      SetHeaderConfig;
      for i := 0 to Pred(mHeaderConfig.Lines.Count) do
        FFile.add(mHeaderConfig.Lines[i]);
      FFile.add('');
    end;


    if HeaderFile then
    begin
      for i := 0 to Pred(cdsFile.FieldCount) do
      begin
        if grdFileTableView.Columns[i].Visible then
        begin
          FieldValue := grdFileTableView.Columns[i].Caption;
          txt := txt + FieldValue;

          if i <> Pred(cdsFile.FieldCount) then
            txt := txt + Delimiter;
        end;
      end;

      if txt <> '' then
        FFile.add(txt);

      txt := '';
    end;

    cdsFile.First;
    while not cdsFile.Eof do
    begin
      for i := 0 to Pred(cdsFile.FieldCount) do
      begin
        if grdFileTableView.Columns[i].Visible then
        begin
          if cdsFile.FieldByName(grdFileTableView.Columns[i].Caption).DataType in [ftFloat, ftCurrency, ftBCD] then
            FieldValue := FormatFloat('0.#####',MyStrToDouble(cdsFile.FieldByName(grdFileTableView.Columns[i].Caption).AsString, DecimalDelimiter))
          else
            FieldValue := cdsFile.FieldByName(grdFileTableView.Columns[i].Caption).AsString;

          txt := txt + FieldValue;

          if i <> Pred(cdsFile.FieldCount) then
            txt := txt + Delimiter;
        end;
      end;
      if txt <> '' then
        FFile.add(txt);
      cdsFile.Next;
      txt := '';
     end;


    FFile.SaveToFile(edtPath.Text + fFileName);
  finally
    FFile.Free;
    result := True;
  end;
end;

procedure TParentWizExp.sbOpenBKPClick(Sender: TObject);
var
  sFile : String;
begin
  if OD.Execute then
     begin
     sFile := LowerCase(OD.FileName);
     edtPath.Text := ExtractFileDir(sFile) + '\';
     end;
end;

procedure TParentWizExp.ScreenStatusOk;
begin
  Panel1.Visible := True;
  Screen.Cursor := crDefault;
end;

procedure TParentWizExp.ScreenStatusWait;
begin
  Panel1.Visible := False;
  Screen.Cursor := crHourGlass;
end;

function TParentWizExp.Start: Boolean;
begin
  FSpecificConfig := TStringList.Create;

  fRegistryPath := '';
  AView := TcxCustomGridTableView(grdFile.FocusedView);

  edtPath.Text := GetExportFilePath;

  if edtPath.Text = '' then
    edtPath.Text := ExtractFilePath(Application.ExeName);

  // DecimalDelimiter
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH, True);
    edtDecimalDelimiter.Text := ReadString('DefaultDecimalSeparator');
  finally
    Free;
  end;

  Result := inherited Start;
end;

function TParentWizExp.TestBeforeNavigate: Boolean;
begin
  Result := True;

 if pgOption.ActivePageIndex = 0 then
 begin
   DMImportExport.ExportConn.Connected := True;
 end
 else if pgOption.ActivePage.Name = 'tsConfigFile' then
  begin
    if edtPath.Text = '' then
      begin
        MsgBox('Select a folder!', vbInformation + vbOKOnly);
        edtPath.SetFocus;
        Result := False;
        Exit;
      end
    else
      begin
        if (not DirectoryExists(edtPath.Text)) then
          begin
            MsgBox('Export folder is missing!', vbInformation + vbOKOnly);
            edtPath.SetFocus;
            Result := False;
            Exit;
          end;
      end;

    if edtDelimiter.Text = '' then
       Delimiter := #9
    else
       Delimiter := edtDelimiter.Text[1];

    if edtDecimalDelimiter.Text = '' then
       DecimalDelimiter := '.'
    else
       DecimalDelimiter := edtDecimalDelimiter.Text[1];

    SetExportFilePath(edtPath.Text);
  end;

    AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
end;

procedure TParentWizExp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  DMImportExport.ExportConn.Connected := False;
  FreeAndNil(FSpecificConfig);
  cdsFile.Close;

  Action := caFree;
  
end;

procedure TParentWizExp.edtDecimalDelimiterKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = edtDelimiter.Text then
    begin
    Key := #0;
    MsgBox('Decimal Delimiter it is equal to Text Delimiter!', vbInformation + vbOKOnly);
    end
end;

procedure TParentWizExp.edtDelimiterKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = edtDecimalDelimiter.Text then
    begin
    Key := #0;
    MsgBox('Text Delimiter it is equal to Decimal Delimiter!', vbInformation + vbOKOnly);
    end
end;

procedure TParentWizExp.BNextClick(Sender: TObject);
var
  page : integer;
begin
  inherited;
  page := pgOption.ActivePageIndex;
  if (FTabList.IndexOf(IntToStr(page))+1) = FTabList.Count-1 then
     TButton(Sender).Caption := 'Export'
end;

procedure TParentWizExp.btColumnClick(Sender: TObject);
begin
  
  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    GridCustomization(True)
  else
    GridCustomization(False);
end;

procedure TParentWizExp.RestoreFromRegistry;
begin
  AOptions := [gsoUseFilter, gsoUseSummary];
  TcxGridDBTableView(AView).RestoreFromRegistry(fRegistryPath, False, False, AOptions);
end;

function TParentWizExp.DoFinish: Integer;
begin
  Result := -1;
end;

procedure TParentWizExp.btnAddFormatClick(Sender: TObject);
var
  OptionName : String;
begin
  inherited;
  case cbxFileFormat.ItemIndex of
    INDEX_NAME_FILE_DAY   : OptionName := NAME_FILE_DAY;
    INDEX_NAME_FILE_MONTH : OptionName := NAME_FILE_MONTH;
    INDEX_NAME_FILE_YEAR  : OptionName := NAME_FILE_YEAR;
  end;

  if OptionName <> '' then
    AddtoFileName(OptionName);
end;

procedure TParentWizExp.cbxColumnsHeaderFileClick(Sender: TObject);
begin
  HeaderFile := cbxColumnsHeaderFile.Checked;
end;

procedure TParentWizExp.AddtoFileName(OptionName : String);
begin
  if Pos(OptionName, edtFileFormat.Text) > 0 then
    MsgBox('Already it was added !', vbInformation + vbOKOnly)
  else
    edtFileFormat.Text := edtFileFormat.Text + OptionName;
end;

procedure TParentWizExp.btnAddHeaderConfigClick(Sender: TObject);
begin
  inherited;
  case cbxHeaderConfig.ItemIndex of
    INDEX_HEADER_CONFIG_ADDRESS : mHeaderConfig.Lines.Add(HEADER_CONFIG_ADDRESS);
    INDEX_HEADER_CONFIG_CITY    : mHeaderConfig.Lines.Add(HEADER_CONFIG_CITY);
    INDEX_HEADER_CONFIG_CEP     : mHeaderConfig.Lines.Add(HEADER_CONFIG_CEP);
  end;
end;

function TParentWizExp.RemoveInvalidCaracter(Value: String): String;
var
 j : Integer;
 NameTest : String;

begin
   NameTest := UpperCase(value);

   for j := Length(NameTest) downto 1 do
     begin
       { Alex 11/30/2011 - Included '-', '.' }
       if not(NameTest[j] in ['0'..'9', 'A'..'Z', '-', '.']) then
         begin
           NameTest[j] := '_';
         end;
     end;

  Result := NameTest;
end;

end.
