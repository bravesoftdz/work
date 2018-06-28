unit uDMExportTextFile;

interface

uses
  SysUtils, Classes, ADODB, DBClient, DB, uDMGlobal, Variants;

type
  TDMExportTextFile = class(TDataModule)
    qryInsConfigExport: TADOQuery;
    qryUpdConfigExport: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FTextFile: TClientDataSet;
    FLog: TStringList;

    function InsertConfigExport(AIDPessoa: Integer; ADelimiterSeparator,
      ADecimalSeparator, AHeaderConfig, AFileFormat: String;
      AHeaderFile : Boolean; AExportType: Smallint) : Boolean;
    function UpdadeConfigExport(IDConfigExport: Integer; ADelimiterSeparator,
      ADecimalSeparator, AHeaderConfig, AFileFormat: String;
      AHeaderFile : Boolean) : Boolean;
  public
    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property TextFile: TClientDataSet read FTextFile write FTextFile;
    property Log: TStringList read FLog write FLog;

    procedure ExportFile; virtual;

    function CreateConfigExport(AIDPessoa: Integer; ADelimiterSeparator,
      ADecimalSeparator, AHeaderConfig, AFileFormat: String;
      AHeaderFile : Boolean; AExportType: Smallint) : Boolean;
    function GetConfigExport(AIDPessoa: Integer; AExportType: Smallint;
      var ADelimiterSeparator, ADecimalSeparator, AHeaderConfig, AFileFormat: String;
      var AHeaderFile : WordBool) : Boolean;
  end;

implementation

uses
  Dialogs, uSystemConst;

{$R *.dfm}

{ TDMExportTextFile }

procedure TDMExportTextFile.ExportFile;
begin

end;

procedure TDMExportTextFile.DataModuleCreate(Sender: TObject);
begin
  FTextFile := TClientDataSet.Create(nil);
  FLog := TStringList.Create;
end;

procedure TDMExportTextFile.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FTextFile);
  FreeAndNil(FLog);
end;

function TDMExportTextFile.InsertConfigExport(AIDPessoa: Integer;
  ADelimiterSeparator, ADecimalSeparator, AHeaderConfig,
  AFileFormat: String; AHeaderFile: Boolean;
  AExportType: Smallint): Boolean;
var
  NewId : integer;
begin
  Result := True;
  qryInsConfigExport.Connection := SQLConnection;

  try
    NewId := DMGlobal.GetNextCode('Sis_ConfigExport', 'IDConfigExport', SQLConnection);

    with qryInsConfigExport do
    try
      Parameters.ParamByName('IDConfigExport').Value := NewId;
      if (AIDPessoa <> 0) then
        Parameters.ParamByName('IDPessoa').Value := AIDPessoa
      else
        Parameters.ParamByName('IDPessoa').Value := null;

      Parameters.ParamByName('DelimiterSeparator').Value := ADelimiterSeparator;
      Parameters.ParamByName('DecimalSeparator').Value := ADecimalSeparator;
      Parameters.ParamByName('HeaderConfig').Value := AHeaderConfig;
      Parameters.ParamByName('FileFormat').Value := AFileFormat;
      Parameters.ParamByName('HeaderFile').Value := AHeaderFile;
      Parameters.ParamByName('ExportType').Value := AExportType;

      ExecSQL;
    finally
      qryInsConfigExport.Close;
    end;
  except
    on E: Exception do
    begin
      Log.Add(Format('Error: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

function TDMExportTextFile.UpdadeConfigExport(IDConfigExport: Integer;
  ADelimiterSeparator, ADecimalSeparator, AHeaderConfig,
  AFileFormat: String; AHeaderFile: Boolean): Boolean;
begin
  Result := True;
  qryUpdConfigExport.Connection := SQLConnection;

  try
    with qryUpdConfigExport do
    try
      Parameters.ParamByName('DelimiterSeparator').Value := ADelimiterSeparator;
      Parameters.ParamByName('DecimalSeparator').Value := ADecimalSeparator;
      Parameters.ParamByName('HeaderConfig').Value := AHeaderConfig;
      Parameters.ParamByName('FileFormat').Value := AFileFormat;
      Parameters.ParamByName('HeaderFile').Value := AHeaderFile;
      Parameters.ParamByName('IDConfigExport').Value := IDConfigExport;
      ExecSQL;
    finally
      qryUpdConfigExport.Close;
    end;
  except
    on E: Exception do
    begin
      Log.Add(Format('Error: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

function TDMExportTextFile.CreateConfigExport(AIDPessoa: Integer;
  ADelimiterSeparator, ADecimalSeparator, AHeaderConfig,
  AFileFormat: String; AHeaderFile: Boolean;
  AExportType: Smallint): Boolean;
begin
  DMGlobal.qryFreeSQL.Connection := SQLConnection;

   with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;


     if (AExportType = EXPORT_TYPE_PO) then
       SQL.Text := 'SELECT IDConfigExport '+
                   '   FROM Sis_ConfigExport '+
                   '  WHERE ExportType = ' + InttoStr(AExportType)+
                   '        and IDPessoa = ' + InttoStr(AIDPessoa)
     else
       SQL.Text := 'SELECT IDConfigExport '+
                   '   FROM Sis_ConfigExport '+
                   '  WHERE ExportType = ' + InttoStr(AExportType);

     try
       Open;

       if IsEmpty then
         Result := InsertConfigExport(AIDPessoa, ADelimiterSeparator,
                                      ADecimalSeparator, AHeaderConfig,
                                      AFileFormat, AHeaderFile, AExportType)
       else
         Result := UpdadeConfigExport(FieldByName('IDConfigExport').AsInteger,
                                      ADelimiterSeparator, ADecimalSeparator,
                                      AHeaderConfig, AFileFormat, AHeaderFile);
     finally
       Close;
     end;
   end;
end;

function TDMExportTextFile.GetConfigExport(AIDPessoa: Integer;
  AExportType: Smallint; var ADelimiterSeparator, ADecimalSeparator,
  AHeaderConfig, AFileFormat: String; var AHeaderFile: WordBool): Boolean;
begin
  Result := False;
  DMGlobal.qryFreeSQL.Connection := SQLConnection;

   with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;

     if (AExportType = EXPORT_TYPE_PO) then
       SQL.Text := 'SELECT DelimiterSeparator, DecimalSeparator,  '+
                   '       HeaderConfig, FileFormat, HeaderFile '+
                   '   FROM Sis_ConfigExport '+
                   '  WHERE ExportType = ' + InttoStr(AExportType)+
                   '        and IDPessoa = ' + InttoStr(AIDPessoa)
     else
       SQL.Text := 'SELECT DelimiterSeparator, DecimalSeparator,  '+
                   '       HeaderConfig, FileFormat, HeaderFile '+
                   '   FROM Sis_ConfigExport '+
                   '  WHERE ExportType = ' + InttoStr(AExportType);
     try
       Open;

       ADelimiterSeparator := '';
       ADecimalSeparator := '';
       AHeaderConfig := '';
       AFileFormat := '';
       AHeaderFile := false;
       if not IsEmpty then
       begin
         ADelimiterSeparator := FieldByName('DelimiterSeparator').AsString;
         ADecimalSeparator := FieldByName('DecimalSeparator').AsString;
         AHeaderConfig := FieldByName('HeaderConfig').AsString;
         AFileFormat := FieldByName('FileFormat').AsString;
         AHeaderFile := FieldByName('HeaderFile').AsBoolean;
         Result := True;
       end
     finally
       Close;
     end;
   end;
end;

end.
