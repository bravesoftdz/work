unit uParentWizImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizard, ImgList, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Grids,
  Provider, DBClient, Registry;

type
  TParentWizImp = class(TParentWizard)
    tsConfigFile: TTabSheet;
    cbxBKPDevice: TGroupBox;
    sbOpenBKP: TSpeedButton;
    Label1: TLabel;
    rbFile: TRadioButton;
    edtFilePath: TEdit;
    edtDelimiter: TEdit;
    OD: TOpenDialog;
    tsSpecificConfig: TTabSheet;
    tsDatabase: TTabSheet;
    tsCrossColumn: TTabSheet;
    grdFileTableView: TcxGridDBTableView;
    grdFileLevel: TcxGridLevel;
    grdFile: TcxGrid;
    cdsFile: TClientDataSet;
    dtsFile: TDataSource;
    lbRecords: TLabel;
    tsImport: TTabSheet;
    edtDecimalDelimiter: TEdit;
    lbDelimiter: TLabel;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    SD: TSaveDialog;
    btClean: TBitBtn;
    btSave: TBitBtn;
    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sbOpenBKPClick(Sender: TObject);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDelimiterKeyPress(Sender: TObject; var Key: Char);
    procedure BNextClick(Sender: TObject);
    procedure edtDecimalDelimiterKeyPress(Sender: TObject; var Key: Char);
    procedure btCleanClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
  private
    AOptions : TcxGridStorageOptions;
    AView    : TcxCustomGridTableView;
    fRegistryPath : String;
    
    Delimiter      : Char;
    FLogError      : TStringList;
    FLinkedColumns : TStringList;
    FFile           : TStringList;
    FSpecificConfig : TStringList;

    procedure AddLineToCDS(ALine: String);
    function AddFieldsToCDS: Boolean;
    procedure ClearCDS;
    procedure AddLinkedColumns;
    function PrepareValueOfField(Value: String): String;
    function PrepareField(Value: String): String;
    function ValidateLinkedColumns(var FieldError: String): Boolean;
    procedure CleanInventoryColumns;
  protected
    iDatabaseColumns,
    iValidateColumns : Integer;

    procedure MountFileonGrid;

    property LogError: TStringList read FLogError write FLogError;
    property LinkedColumns: TStringList read FLinkedColumns write FLinkedColumns;
    property SpecificConfig: TStringList read FSpecificConfig write FSpecificConfig;

    function AddColumnsToGrid: Boolean;
    procedure FillColumnsGrid; virtual; abstract;
    procedure AddColumnsToImport; virtual; abstract;
    procedure AddComboColumnsToImport;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function DoFinish:Integer; override;
    procedure OnBeforeBackClick; override;
    procedure ScreenStatusWait;
    procedure ScreenStatusOk;
    procedure AddSpecificConfigList(pLabel, Value: String);
    function AddSpecificFieldsToCDS(Position : Integer): Integer; virtual; abstract;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); virtual; abstract;
    function GetColumnWidth(MyType: TFieldType): Integer;
    procedure ShowError(Error: String);
    procedure ExportGridToExcel(MyGrid: TcxGrid);
    procedure SaveCrossColumn;
    procedure RestoreGridFromRegistry;
    procedure SaveGridToRegistry;
    procedure SetGridToRegistryValues(Path: String; Grid: TcxGrid);
    procedure CloseRegister(Path: String);
  public
    function Start: Boolean; override;
  end;

implementation

uses uMsgBox,    uStringFunctions, uDMGlobalNTier, uCharFunctions,
     uDMImportExport, uCDSFunctions, uSystemConst, uFrmLog, cxExportGrid4Link;

{$R *.dfm}

{ TParentWizImpExp }

function TParentWizImp.OnAfterChangePage: Boolean;
begin
  Result := True;

  if pgOption.ActivePage.Name = 'tsDatabase' then
    MountFileonGrid;

end;

function TParentWizImp.TestBeforeNavigate: Boolean;
var
  FieldError: String;
begin
  Result := True;

  if pgOption.ActivePage.Name = 'tsConfigFile' then
  begin
    if edtFilePath.Text = '' then
    begin
      MsgBox('Select a file!', vbInformation + vbOKOnly);
      edtFilePath.SetFocus;
      Result := False;
      Exit;
    end;
    {
    if edtDelimiter.Text = '' then
       Delimiter := #9
    else
       Delimiter := edtDelimiter.Text[1];


    if edtDecimalDelimiter.Text = '' then
       AddSpecificConfigList('DecimalDelimiter', '.')
    else
       AddSpecificConfigList('DecimalDelimiter', edtDecimalDelimiter.Text);
     }
  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    AddLinkedColumns;

    if not(ValidateLinkedColumns(FieldError)) then
    begin
      MsgBox('Invalid Field ' + FieldError + ' !', vbInformation + vbOKOnly);
      FLinkedColumns.Clear;
      Result := False;
      Exit;
    end;
  end
  else if pgOption.ActivePage.Name = 'tsDatabase' then
  begin
    if not(cdsFile.Active) then
    begin
      MsgBox('File Error!', vbInformation + vbOKOnly);
      Result := False;
      Exit;
    end;
  end;

  if (SpecificConfig.Text = '') then
  begin
    if edtDelimiter.Text = '' then
       Delimiter := #9
    else
       Delimiter := edtDelimiter.Text[1];

    if edtDecimalDelimiter.Text = '' then
       AddSpecificConfigList('DecimalDelimiter', '.')
    else
       AddSpecificConfigList('DecimalDelimiter', edtDecimalDelimiter.Text);

    AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
  end;

end;

function TParentWizImp.ValidateLinkedColumns(var FieldError: String): Boolean;
var
  i, z: Integer;
  Find: Boolean;
begin
   Result := True;
   Find   := False;

   for i := 0 to Pred(FLinkedColumns.Count) do
   begin
     Find := False;
     for z := 0 to Pred(cbColumns.Items.Count) do
     begin
       if (FLinkedColumns.ValueFromIndex[i] = cbColumns.Items[z]) then
        Find := True;

       if (z = Pred(cbColumns.Items.Count)) and not(Find) then
       begin
         FieldError := FLinkedColumns.ValueFromIndex[i];
         Result := False;
       end;
     end
   end;
end;

procedure TParentWizImp.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  //Somente na Coluna desejada
  if ((ACol = 1) AND (ARow <> 0)) then
  begin
   {Size and position the combo box to fit the cell}
    R := sgColumns.CellRect(ACol, ARow);
    R.Left := R.Left + sgColumns.Left;
    R.Right := R.Right + sgColumns.Left;
    R.Top := R.Top + sgColumns.Top;
    R.Bottom := R.Bottom + sgColumns.Top;
    cbColumns.Left := R.Left + 1;
    cbColumns.Top := R.Top + 1;
    cbColumns.Width := (R.Right + 1) - R.Left;
    cbColumns.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbColumns.Text := sgColumns.Cells[ACol, ARow];
    cbColumns.Visible := True;
    cbColumns.SetFocus;
  end;                     
  CanSelect := True;
end;

procedure TParentWizImp.AddComboColumnsToImport;
var
  i: Integer;
begin
  for i := 0 to Pred(iDatabaseColumns) do
    cbColumns.Items.add(cdsFile.Fields[i].DisplayName);
end;

procedure TParentWizImp.MountFileonGrid;
var
  i: Integer;
begin
  FFile := TStringList.Create;
  try

    FFile.LoadFromFile(edtFilePath.Text);

    if AddFieldsToCDS and AddColumnsToGrid then
      try
        cdsFile.Close;
        grdFileTableView.DataController.DataSource := dtsFile;
        cdsFile.DisableControls;
        ScreenStatusWait;
        cdsFile.Open;
        for i := 1 to Pred(FFile.Count) do
          if FFile[i] <> '' then
            AddLineToCDS(WrapDelimitedText(FFile[i], Delimiter));
      finally
        ScreenStatusOk;
        cdsFile.EnableControls;
      end;

    lbRecords.Caption := IntTostr(FFile.Count-1) + ' line(s)';
  finally
    FreeAndNil(FFile);
    end;
end;

procedure TParentWizImp.AddLineToCDS(ALine: String);
var
  i: Integer;
  LineValues: TStringList;
begin

  LineValues := TStringList.Create;
  try
    with LineValues do
    begin
      LineValues.Text := ALine;
      cdsFile.Append;
      for i := 0 to Pred(Count) do
        cdsFile.Fields.Fields[i].AsString := PrepareValueOfField(Strings[i]);

      cdsFile.FieldByName('Validation').AsBoolean := True;
      cdsFile.Post;
     end;
   finally
     FreeAndNil(LineValues);
   end;
   
end;

function TParentWizImp.PrepareValueOfField(Value: String): String;
begin
  while Pos('$', Value) > 0 do
    Value :=  copy( Value,0,Pos('$', Value) - 1) +
              copy( Value,Pos('$', Value) + 1,length(Value));
              
  Result := Value;
end;

function TParentWizImp.PrepareField(Value: String): String;
var
 i, j : Integer;
 NameTest : String;

begin
 {
  while Pos(' ', Value) > 0 do
          Value := copy( Value,0,Pos(' ', Value) - 1) +
                                   copy( Value,Pos(' ', Value) + 1,length(Value));

  while Pos('#', Value) > 0 do
    Value := copy( Value,0,Pos('#', Value) - 1) +
                             copy( Value,Pos('#', Value) + 1,length(Value));
 }
   NameTest := UpperCase(value);

   for j := Length(NameTest) downto 1 do
     begin
       if not(NameTest[j] in ['0'..'9', 'A'..'Z']) then
         begin
           NameTest[j] := '_';
         end;
     end;

 //Para evitar que algum campo seja maior que 30 caracteres.
 //Limite máximo do ClienteDataSet
  if (Length(NameTest) > 30) then
    NameTest := Copy(NameTest, 1, 30);

  Result := NameTest;
end;

procedure TParentWizImp.sbOpenBKPClick(Sender: TObject);
begin
 if OD.Execute then
   edtFilePath.Text := OD.FileName;
end;

function TParentWizImp.AddFieldsToCDS: Boolean;
var
  i: Integer;
  HeaderLine: TStringList;
begin
  HeaderLine := TStringList.Create;
  Result := False;

  try
    try
    HeaderLine.Text := WrapDelimitedText(FFile.Strings[0], Delimiter);
    with cdsFile do
     begin

      for i := 0 to Pred(HeaderLine.Count) do
      begin
        HeaderLine.Strings[i] := PrepareField(HeaderLine.Strings[i]);
        CreateCDSField(cdsFile, HeaderLine.Strings[i], ftString, i, True, 50);
      end;

      iDatabaseColumns := i;
      i := AddSpecificFieldsToCDS(iDatabaseColumns);

      // - Campo para validar o registro.
      CreateCDSField(cdsFile, 'Validation', ftBoolean, i+1, True);

      // - Campo para registrar algum erro.
      CreateCDSField(cdsFile, 'Warning', ftString, i+2, True, 50);

      iValidateColumns := i + 2;
      AddSpecificFriendFieldsToCDS(iValidateColumns);
      CreateDataSet;
      Result := True;
     end;
    except
       on E: Exception do
       begin
         cdsFile.Close;
         MsgBox('Error loading from file._' + E.Message, vbCritical + vbOkOnly);
         //
       end;
     end;
  finally
    FreeAndNil(HeaderLine);
  end;
end;

function TParentWizImp.AddColumnsToGrid: Boolean;
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
begin
  Result := False;
  try
    grdFileTableView.ClearItems;
    for i := 0 to (iDatabaseColumns - 1) do
    begin
      NewColumn := grdFileTableView.CreateColumn;
      with NewColumn do
      begin
        Caption := cdsFile.FieldDefs[i].DisplayName;
        Name    := 'grdFileTableView' + cdsFile.FieldDefs[i].DisplayName;
        DataBinding.FieldName := cdsFile.FieldDefs[i].Name;
      end;
    end;
    Result := True;
  except
    on E: Exception do
      begin
        grdFileTableView.ClearItems;
        cdsFile.Close;
        MsgBox('Error loading from file._' + E.Message, vbCritical + vbOkOnly);
       end;
  end;
end;

procedure TParentWizImp.AddLinkedColumns;
var i: Integer;
begin
  FLinkedColumns.Clear;
  for i:= 1 to Pred(sgColumns.RowCount) do
    if not(sgColumns.Cells[1,i] = '')  then
      FLinkedColumns.Add(sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i]);
end;

procedure TParentWizImp.cbColumnsChange(Sender: TObject);
begin
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

  cbColumns.Visible := False;
  sgColumns.SetFocus;
end;

procedure TParentWizImp.cbColumnsExit(Sender: TObject);
begin
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
  cbColumns.Visible := False;
  sgColumns.SetFocus;
end;

procedure TParentWizImp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DMImportExport.ImportConn.Connected := False;
  FreeAndNil(FLogError);
  FreeAndNil(FSpecificConfig);
  FreeAndNil(FLinkedColumns);

  Action := caFree;
end;

function TParentWizImp.Start: Boolean;
begin
  SpecificConfig := TStringList.Create;
  LogError       := TStringList.Create;
  LinkedColumns  := TStringList.Create;

  // DecimalDelimiter
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH, True);
    //edtDecimalDelimiter.Text := ReadString('DefaultDecimalSeparator');
  finally
    Free;
  end;

  Result := inherited Start;
end;

function TParentWizImp.DoFinish: Integer;
begin

end;

procedure TParentWizImp.OnBeforeBackClick;
begin
  if pgOption.ActivePage.Name = 'tsDatabase' then
  begin
    ClearCDS;
    SpecificConfig.Clear;
  end
  else if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    sgColumns.Cols[0].Clear;
    sgColumns.Cols[1].Clear;
    cbColumns.Clear;

    cdsFile.Filter := '';
    cdsFile.Filtered := False;
  end;
end;

procedure TParentWizImp.ClearCDS;
begin
  if cdsFile.Active then
    cdsFile.Edit;

  cdsFile.Fields.Clear;
  cdsFile.IndexDefs.Clear;
  cdsFile.FieldDefs.Clear;
  cdsFile.Filter := '';
  cdsFile.Filtered := False;
  cdsFile.Close;
end;

procedure TParentWizImp.edtDelimiterKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = edtDecimalDelimiter.Text then
    begin
    Key := #0;
    MsgBox('Text Delimiter it is equal to Decimal Delimiter!', vbInformation + vbOKOnly);
    end
end;

procedure TParentWizImp.ScreenStatusOk;
begin
  Panel1.Visible := True;
  Screen.Cursor := crDefault;
end;

procedure TParentWizImp.ScreenStatusWait;
begin
  Panel1.Visible := False;
  Screen.Cursor := crHourGlass;
end;

procedure TParentWizImp.BNextClick(Sender: TObject);
var
  page : integer;
begin
  inherited;
  page := pgOption.ActivePageIndex;
  if (FTabList.IndexOf(IntToStr(page))+1) = FTabList.Count-1 then
     TButton(Sender).Caption := 'Import'
end;  

procedure TParentWizImp.edtDecimalDelimiterKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = edtDelimiter.Text then
    begin
    Key := #0;
    MsgBox('Decimal Delimiter it is equal to Text Delimiter!', vbInformation + vbOKOnly);
    end
end;

procedure TParentWizImp.AddSpecificConfigList(pLabel, Value: String);
begin
  if Value <> '' then
    SpecificConfig.Add(pLabel + '=' + Value);
end;

function TParentWizImp.GetColumnWidth(MyType: TFieldType): Integer;
begin
  if (MyType = ftString) then
    Result := 130
  else if (MyType = ftInteger) then
    Result := 5
  else if (MyType = ftCurrency) or (MyType = ftFloat) then
    Result := 20
  else 
    Result := 5;
end;

procedure TParentWizImp.ShowError(Error: String);
begin
  with TFrmLog.Create(Self) do
  try
    MsgLog.Text := Error;
    Start;
  finally
    Free;
  end;
end;

procedure TParentWizImp.ExportGridToExcel(MyGrid: TcxGrid);
begin
  with SD do
    begin

    if Execute then
      If FileName <> '' then
      begin
         if Pos('.xls', LowerCase(FileName)) = 0 then
            FileName := FileName + '.xls';
         ExportGrid4ToExcel(FileName, MyGrid, True, True, False);
      end;
    end;
end;

procedure TParentWizImp.SaveCrossColumn;
var
  sColumn: String;
  i       : integer;
  CrossColumnList: TStringList;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[0,i]) <> '' then
        sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
     Exit;

  with SD do
    try
      CrossColumnList := TStringList.Create();
      DefaultExt := 'txt';
      Filter     := '*.txt';

      CrossColumnList.Add(SpecificConfig.Values['Vendor'] + '=' + sColumn);

      if Execute then
       if FileName <> '' then
       begin
          if Pos('.txt', LowerCase(FileName)) = 0 then
             FileName := FileName + '.txt';
         CrossColumnList.SaveToFile(FileName);
       end;

    finally
      FreeAndNil(CrossColumnList);
      DefaultExt := 'xls';
      Filter     := 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls';
    end;
end;

procedure TParentWizImp.CleanInventoryColumns;
var
  i: integer;
begin
  for i:=1 to sgColumns.RowCount-1 do
    sgColumns.Cells[1,i] := '';
end;

procedure TParentWizImp.btCleanClick(Sender: TObject);
begin
  inherited;
  CleanInventoryColumns;
end;

procedure TParentWizImp.btSaveClick(Sender: TObject);
begin
  inherited;
  SaveCrossColumn;
end;

procedure TParentWizImp.RestoreGridFromRegistry;
begin
  AOptions := [gsoUseFilter, gsoUseSummary];
  TcxGridDBTableView(AView).RestoreFromRegistry(fRegistryPath, False, False, AOptions);
end;

procedure TParentWizImp.SaveGridToRegistry;
begin
  if fRegistryPath <> '' then
    begin
      TcxGridDBTableView(AView).StoreToRegistry(fRegistryPath, True, AOptions);
      CloseRegister(fRegistryPath);
    end;
end;

procedure TParentWizImp.SetGridToRegistryValues(Path: String; Grid: TcxGrid);
begin
  fRegistryPath := Path;
  AView := TcxCustomGridTableView(Grid.FocusedView);
end;

procedure TParentWizImp.CloseRegister(Path: String);
Var
  Registro: TRegistry;
Begin
  Registro := TRegistry.Create;
  Try
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey(Path,false);
    Registro.CloseKey;
  finally
    FreeAndNil(Registro);
  end;
end;


end.
