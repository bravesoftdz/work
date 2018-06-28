unit uDMImportTextFile;

interface

uses
  SysUtils, Classes, DBClient, DB, ADODB, uDMGlobal, Variants;

type
  TDMImportTextFile = class(TDataModule)
    qryInsConfigImport: TADOQuery;
    qryUpdConfigImport: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FTextFile: TClientDataSet;
    FLinkedColumns: TStringList;
    FImpExpConfig : TStringList;
    FLog: TStringList;
    FSQLConnection : TADOConnection;

    function InsertConfigImport(AIDPessoa: Integer; ACaseCost : Boolean; AImportType: Smallint) : Boolean;
    function UpdadeConfigImport(AIDConfigImport: Integer; ACaseCost : Boolean) : Boolean;
  protected
    procedure BeforeImport; virtual;
    procedure ImportLine; virtual;
    procedure AfterImport; virtual;
    function GetParamValue(Value: String): Variant;
    function GetParamCurrency(Value: String) : Currency;
    function GetParamDateTime(Value: String) : TDateTime;
    function GetParamInteger(Value: String) : Integer;
  public
    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property TextFile: TClientDataSet read FTextFile write FTextFile;
    property LinkedColumns: TStringList read FLinkedColumns write FLinkedColumns;
    property ImpExpConfig: TStringList read FImpExpConfig write FImpExpConfig;
    property Log: TStringList read FLog write FLog;

    procedure Import;
    function CreateConfigImport(AIDPessoa: Integer; ACaseCost : Boolean;
      AImportType: Smallint) : Boolean;
    function GetConfigImport(AIDPessoa: Integer; AImportType: Smallint;
      var ACrossColumn : WideString; var ACaseCost : WordBool) : WordBool;
  end;

implementation
  uses uSystemConst, uDMCalcPrice, uDebugFunctions;
  
{$R *.dfm}

procedure TDMImportTextFile.AfterImport;
begin
  // para ser herdado
end;

procedure TDMImportTextFile.BeforeImport;
begin
  // para ser herdado
end;

procedure TDMImportTextFile.DataModuleCreate(Sender: TObject);
begin
  FTextFile := TClientDataSet.Create(nil);
  FLinkedColumns := TStringList.Create;
  FImpExpConfig  := TStringList.Create;
  FLog := TStringList.Create;
end;

procedure TDMImportTextFile.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FTextFile);
  FreeAndNil(FLinkedColumns);
  FreeAndNil(FImpExpConfig);
  FreeAndNil(FLog);
end;

function TDMImportTextFile.GetParamValue(Value: String): Variant;
begin
  if not(LinkedColumns.Values[Value] = '') then
    Result := TextFile.FieldByName(LinkedColumns.Values[Value]).AsString
  else
    Result := null;
end;

function TDMImportTextFile.GetParamCurrency(Value: String) : Currency;
begin
  if not(LinkedColumns.Values[Value] = '') then
    Result := StrToCurrDef(TextFile.FieldByName(LinkedColumns.Values[Value]).AsString, 0)
  else
    Result := 0;
end;

function TDMImportTextFile.GetParamDateTime(Value: String) : TDateTime;
begin
  if not(LinkedColumns.Values[Value] = '') then
    Result := StrToDateTimeDef(TextFile.FieldByName(LinkedColumns.Values[Value]).AsString, 0)
  else
    Result := 0;
end;

function TDMImportTextFile.GetParamInteger(Value: String) : Integer;
begin
  if not(LinkedColumns.Values[Value] = '') then
    Result := StrToIntDef(TextFile.FieldByName(LinkedColumns.Values[Value]).AsString, 0)
  else
    Result := 0;
end;

procedure TDMImportTextFile.Import;
var
  iLine: Integer;
begin

  iLine := 0;
  BeforeImport;
  TextFile.First;
  while not TextFile.Eof do
  begin
    try
      Inc(iLine);

      if TextFile.FieldByName('Validation').AsBoolean then
        ImportLine;
    except
      on E: Exception do
      begin
        Log.Add('Line #' + IntToStr(iLine) + ' not imported. Error: ' + E.Message);
      end;
    end;
    TextFile.Next;
  end;
 AfterImport;
end;

procedure TDMImportTextFile.ImportLine;
begin
  // para ser herdado
end;

function TDMImportTextFile.CreateConfigImport(AIDPessoa: Integer;
  ACaseCost: Boolean; AImportType: Smallint): Boolean;
begin
  DMGlobal.qryFreeSQL.Connection := SQLConnection;

   with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;



     if (AImportType = IMPORT_TYPE_PO) then begin
       debugtofile('ImportType = IMPORT_TYPE_PO');
       SQL.Text := 'SELECT IDConfigImport '+
                   '   FROM Sis_ConfigImport '+
                   '  WHERE ImportType = ' + InttoStr(AImportType)+
                   '        and IDPessoa = ' + InttoStr(AIDPessoa)
     end
     else
       SQL.Text := 'SELECT IDConfigImport '+
                   '   FROM Sis_ConfigImport '+
                   '  WHERE ImportType = ' + InttoStr(AImportType);

     try
       debugtofile('SQL.Text = ' + SQL.text);
       Open;
       debugtofile('Open with success');

       if IsEmpty then begin
         debugtofile('IsEmpty - InsertConfigImport');
         Result := InsertConfigImport(AIDPessoa, ACaseCost, AImportType);
         debugtofile('Insert success');
       end
       else begin
         debugtofile('IsEmpty - UpdateConfigImport');
         Result := UpdadeConfigImport(FieldByName('IDConfigImport').AsInteger, ACaseCost);
         debugtofile('Insert success');
       end;

     finally
       Close;
     end;
   end;
end;

function TDMImportTextFile.InsertConfigImport(AIDPessoa: Integer;
  ACaseCost: Boolean; AImportType: Smallint): Boolean;
var
  NewId : integer;
begin
  Result := True;
  qryInsConfigImport.Connection := SQLConnection;

  try
    NewId := DMGlobal.GetNextCode('Sis_ConfigImport', 'IDConfigImport',SQLConnection);

    with qryInsConfigImport do
    try
      Parameters.ParamByName('IDConfigImport').Value := NewId;
      if (AIDPessoa <> 0) then
        Parameters.ParamByName('IDPessoa').Value := AIDPessoa
      else
        Parameters.ParamByName('IDPessoa').Value := null;

      Parameters.ParamByName('ImportType').Value := AImportType;
      Parameters.ParamByName('CrossColumn').Value := LinkedColumns.Text;
      Parameters.ParamByName('CaseCost').Value := ACaseCost;

      ExecSQL;
    finally
      qryInsConfigImport.Close;
    end;
  except
    on E: Exception do
    begin
      Log.Add(Format('Error: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

function TDMImportTextFile.UpdadeConfigImport(AIDConfigImport: Integer;
  ACaseCost: Boolean): boolean;
begin
  Result := True;
  qryUpdConfigImport.Connection := SQLConnection;

  try
    with qryUpdConfigImport do
    try
      Parameters.ParamByName('CrossColumn').Value := LinkedColumns.Text;
      Parameters.ParamByName('CaseCost').Value := ACaseCost;
      Parameters.ParamByName('IDConfigImport').Value := AIDConfigImport;
      ExecSQL;
    finally
      qryUpdConfigImport.Close;
    end;
  except
    on E: Exception do
    begin
      Log.Add(Format('Error: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

function TDMImportTextFile.GetConfigImport(AIDPessoa: Integer;
  AImportType: Smallint; var ACrossColumn: WideString;
  var ACaseCost: WordBool): WordBool;
begin
  Result := False;
  DMGlobal.qryFreeSQL.Connection := SQLConnection;

   with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;

     if (AImportType = IMPORT_TYPE_PO) then
       SQL.Text := 'SELECT CaseCost, CrossColumn '+
                   '   FROM Sis_ConfigImport '+
                   '  WHERE ImportType = ' + InttoStr(AImportType)+
                   '        and IDPessoa = ' + InttoStr(AIDPessoa)
     else
       SQL.Text := 'SELECT CaseCost, CrossColumn '+
                   '   FROM Sis_ConfigImport '+
                   '  WHERE ImportType = ' + InttoStr(AImportType);

     try
       Open;

       ACaseCost := False;
       ACrossColumn := '';
       if not IsEmpty then
       begin
         ACaseCost := FieldByName('CaseCost').AsBoolean;
         ACrossColumn := FieldByName('CrossColumn').AsString;
         Result := True;
       end
     finally
       Close;
     end;
   end;
end;

end.
