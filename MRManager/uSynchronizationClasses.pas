{ *********************************************************************** }
{                                                                         }
{ Author: Yanniel Alvarez Alfonso                                         }
{ Description: Synchronization Classes                                    }
{ Copyright (c) ????-2012 Pinogy Corporation                              }
{                                                                         }
{ *********************************************************************** }

unit uSynchronizationClasses;

interface

uses
  ADODB, IniFiles, DBUtils;

type
  TSynchronizationINIParams = class
  private
    FSynchronizationINIFile: TIniFile;
    FExportPath,
    FConnectionStr: string; //ConnectionString,

    //RsyncParams //TODO
  public
    constructor Create(aFileName: string);
    destructor Destroy; override;

    property ExportPath: string read FExportPath write FExportPath;
    property ConnectionStr: string read FConnectionStr write FConnectionStr;
  end;  

  //Serializes a table or view, in general a DataSet
  TDataSetSerializer = class
  private
    FConnection: TADOConnection;
  public
    constructor Create(aConnection: TADOConnection); //Inject the connection
    function SaveAsXML(aExportPath, aTable: string): Boolean;
    function SaveAsTSV(aExportPath, aTable: string): Boolean;

    property Connection: TADOConnection read  FConnection
                                        write FConnection;
  end;

implementation

uses
  uEncryptFunctions, uReplicationClasses,
  DB;

{ TDataSetSerializer }

//Inject the connection
constructor TDataSetSerializer.Create(aConnection: TADOConnection);
begin
  inherited Create;
  FConnection:= aConnection;
end;

function TDataSetSerializer.SaveAsXML(aExportPath,
  aTable: string): Boolean;
var
  TableToXML: TTableToXML;
begin
   Result := True;
   if (aTable = '') then Exit;

   TableToXML:= TTableToXML.Create(nil);
   try
     try
       TableToXML.Connection:= FConnection;
       TableToXML.ReplicateSince    := -1;
       TableToXML.SelectWhereClause := '';
       TableToXML.TableName         := aTable;
     except
       Result:= False;
     end;

     Result := TableToXML.SaveToXML(aExportPath + aTable) = '';
   finally
     TableToXML.UnloadData;
     TableToXML.Free;
   end;
end;

function TDataSetSerializer.SaveAsTSV(aExportPath,
  aTable: string): Boolean;
var
  ADOQuery: TADOQuery;
begin
  ADOQuery:= TADOQuery.Create(nil);
  ADOQuery.CommandTimeout:= 30;
  try
    ADOQuery.Connection:= FConnection;
    SelectSQL(ADOQuery, 'select * from ' + aTable + ';');
    Result:= DataSet2TSV(ADOQuery, aExportPath + aTable + '.tsv');
  finally
    ADOQuery.Free;
  end;
end;

{ TSynchronizationINIParams }

constructor TSynchronizationINIParams.Create(aFileName: string);
begin
  inherited Create;
  FSynchronizationINIFile:= TIniFile.Create(aFileName);

  with FSynchronizationINIFile do
  begin
    FExportPath := FSynchronizationINIFile.ReadString('TablesToXML',  'ExportPath',  '');
    FConnectionStr := FSynchronizationINIFile.ReadString('DBConnection', 'ConnectionString',  '');
    //Decoding the ConnectionString
    FConnectionStr:=  DecodeServerInfo(FConnectionStr, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  end; 
end;

destructor TSynchronizationINIParams.Destroy;
begin
  with FSynchronizationINIFile do
  begin
    FSynchronizationINIFile.WriteString('TablesToXML',  'ExportPath',  FExportPath);

    //Encoding the ConnectionString
    FConnectionStr:= EncodeServerInfo(FConnectionStr, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
    FSynchronizationINIFile.WriteString('DBConnection', 'ConnectionString',  FConnectionStr);
    
    Free;
  end;

  inherited;
end;

end.
