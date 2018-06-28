unit uDMClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMRepl, ImgList, AbUnzper, AbBase, AbBrowse, AbZBrows,
  AbZipper, ADODB, DB;

const
  SUBDIR_LOCAL  = 'out\';
  SUBDIR_GLOBAL = 'global\';

  CI_NOMECLIENTE  = '#NOMECLIENTE#=';
  CI_NOMELOJA     = '#NOMELOJA#=';
  CI_VERSAO       = '#VERSAO#=';
  CI_PACKETSIZE   = '#PACKETSIZE#=';
  CI_SENHA        = '#SENHA#=';
  CI_HOST         = '#HOST#=';
  CI_PORT         = '#PORT#';
  

type
  TDMClient = class(TDMRepl)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetClientVersion:String;
    function ImportXMLFile(Table, FileName, Where : String; SQLBatchCount : Integer = 100):Boolean; override;
    function ExportXMLFile(ExportPath,Table:String;RepSince:Integer;Where:String):Boolean; override;
  end;

var
  DMClient: TDMClient;

implementation

{$R *.dfm}

uses URepSocketFunctions;


function TDMClient.ExportXMLFile(ExportPath,Table: String; RepSince:Integer; Where:String): Boolean;
var
  sErro : String;
begin
   Result := True;
   sErro := '';

   if (Table = '') then
      Exit;

   try
     try
       fTableToXML.ReplicateSince    := RepSince;
       fTableToXML.SelectWhereClause := Where;
       fTableToXML.TableName         := Table;
     except
       on E: Exception do
       begin
         ReportError(MR_HST_JOB_FAIL + E.Message);
         Result := False;
         Exit;
       end;
     end;

     sErro := fTableToXML.SaveToXML(ExportPath + Table);
     if sErro <> '' then
     begin
       ReportError(MR_HST_JOB_FAIL + sErro);
       Result := False;
     end;
   finally
     fTableToXML.UnloadData;
   end;
end;

function TDMClient.GetClientVersion: String;
begin
  Result := '';

  try
    if OpenConnection then
    begin
      with quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Clear;
        SQL.Add('SELECT VersionNo, BuildNo FROM sys_Module');
        try
          Open;
          Result := FieldByName('VersionNo').AsString +
                    FieldByName('BuildNo').AsString;
          Close;
        except
          raise;
        end;
      end;
    end;
  finally
    CloseConnection;
  end;
end;

function TDMClient.ImportXMLFile(Table, FileName, Where: String; SQLBatchCount : Integer): Boolean;
var
  sErro : String;
begin
  Result := True;
  sErro := '';

  if ((FileName = '') or (Table = '')) or
     (not FileExists(FileName)) then
     Exit;

  try
    fXMLToTable.SQLBatchCount     := SQLBatchCount;
    fXMLToTable.SelectWhereClause := Where;
    sErro := fXMLToTable.LoadDataFromXML(FileName);

    if sErro <> '' then
    begin
      ReportError(MR_HST_JOB_FAIL + sErro);
      Result := False;
      Exit;
    end;

   fXMLToTable.TableName := Table;

   sErro := fXMLToTable.SaveDataToTable(Table);
   if sErro <> '' then
    begin
      ReportError(MR_HST_JOB_FAIL + sErro);
      Result := False;
    end;
  finally
    fXMLToTable.UnloadData;
  end;

end;


end.
