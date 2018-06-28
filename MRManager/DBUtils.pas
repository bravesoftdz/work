{ *********************************************************************** }
{                                                                         }
{ Author: Yanniel Alvarez Alfonso                                         }
{ Description: Synchronization Classes                                    }
{ Copyright (c) ????-2012 Pinogy Corporation                              }
{                                                                         }
{ *********************************************************************** }

unit DBUtils;

interface

uses
  DB, ADODB, SysUtils, Dialogs, Variants,

  ZAbstractConnection,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

function InsertQuery(aQuery: TADOQuery; aSQL: string): boolean; overload;
function SelectSQL(aQuery: TADOQuery; aSQL: string) : Boolean; overload;

function InsertQuery(aQuery: TZQuery; aSQL: string; out aErrMessage: string): boolean; overload;
function SelectSQL(aQuery: TZQuery; aSQL: string; out aErrMessage: string) : Boolean; overload;
function SmartQuery(aQuery: TZQuery; aSQL: string; out aErrMessage: string) : Boolean;

function DataSet2TSV(aQuery: TDataSet; aFileName: String): Boolean;
function DatabaseExists(aQuery: TADOQuery; aDatabaseName: String): Boolean;
function CreateDatabase(aQuery: TADOQuery; aDatabaseName: String): Boolean;

implementation


function InsertQuery(aQuery: TADOQuery; aSQL: string): boolean;
begin
  Result:= True;
  try
    if aQuery.Active then aQuery.Close;
    aQuery.SQL.Clear;
    aQuery.SQL.Add(aSQL);
    aQuery.ExecSQL;
  except
    Result:= False;
  end;
end;

function SelectSQL(aQuery: TADOQuery; aSQL: string) : Boolean;
begin
  Result:= True;
  try
    if aQuery.Active then aQuery.Close;
    aQuery.SQL.Clear;
    aQuery.SQL.Add(aSQL);
    aQuery.Active:= True;
  except
    Result:= False;
  end;
end;

function InsertQuery(aQuery: TZQuery; aSQL: string; out aErrMessage: string): boolean;
begin
  Result:= True;
  try
    if aQuery.Active then aQuery.Close;
    aQuery.SQL.Clear;
    aQuery.SQL.Add(aSQL);
    aQuery.ExecSQL;
  except
    on E: Exception do
    begin
      aErrMessage:= E.Message;
      Result:= False;
    end;
  end;
end; 

function SelectSQL(aQuery: TZQuery; aSQL: string; out aErrMessage: string) : Boolean;
begin
  Result:= True;
  try
    if aQuery.Active then aQuery.Close;
    aQuery.SQL.Clear;
    aQuery.SQL.Add(aSQL);
    aQuery.Active:= True;
  except
    on E: Exception do
    begin
      aErrMessage:= E.Message;
      Result:= False;
    end;
  end;
end;

function SmartQuery(aQuery: TZQuery; aSQL: string; out aErrMessage: string) : Boolean;
var
  tempQry: string;
begin
  Result:= False;
  tempQry:= LowerCase(aSQL);
  if (Pos('update ', tempQry) > 0) or
     (Pos('update'#10, tempQry) > 0) or
     (Pos('update'#13#10, tempQry) > 0) or
     (Pos('insert ', tempQry) > 0) or
     (Pos('insert'#10, tempQry) > 0) or
     (Pos('insert'#13#10, tempQry) > 0) or
     (Pos('delete ', tempQry) > 0) or
     (Pos('delete'#10, tempQry) > 0)  or
     (Pos('delete'#13#10, tempQry) > 0) then
  begin
    Result:= InsertQuery(aQuery, aSQL, aErrMessage);
  end else if (Pos('select ', tempQry) > 0) or
              (Pos('select'#10, tempQry) > 0) or
              (Pos('select'#13#10, tempQry) > 0) then
  begin
    Result:= SelectSQL(aQuery, aSQL, aErrMessage);
  end;
end;

function DataSet2TSV(aQuery: TDataSet; aFileName: String): Boolean;
const
  BUFFER_SIZE = 10 * 1024; // 10 kb
var
  tsv_File: TextFile;
  i: Integer;
  Buffer: array[0.. BUFFER_SIZE - 1] of byte;
  ADOQuery: TADOQuery;
  key,
  value: string;
begin
  Result:= True;
  try
    AssignFile(tsv_File, aFileName);
    SetTextBuf(tsv_File, Buffer);
    Rewrite(tsv_File);

    aQuery.DisableControls;
    aQuery.Open;
    try
      if aQuery is TADOQuery then
      begin
        //*** Optimization just for TADOQuery. - BEGIN -          ***
        //*** It is much faster to use ADORecordset for this task ***
        ADOQuery:= TADOQuery(aQuery);
        for i:= 0 to  ADOQuery.FieldCount - 1 do // printout the columns header
        begin
          if i > 0 then Write(tsv_File, #9);
          Write(tsv_File, ADOQuery.Fields[i].FieldName);
        end;

        Writeln(tsv_File, '');

        while not ADOQuery.Recordset.EOF do
        begin
          for i:= 0 to ADOQuery.FieldCount - 1 do
          begin
            if i > 0 then Write(tsv_File, #9);
            begin
              key:= ADOQuery.Fields[i].FieldName;
              value:= VarToStr(ADOQuery.Recordset.Fields[key].Value);
              Write(tsv_File, value);
            end;
          end;

          Writeln(tsv_File, '');
          ADOQuery.Recordset.MoveNext;
        end;
        //*** Optimization just for TADOQuery. - END -            ***
      end
      else
      begin
        // *** Other type of DataSets - BEGIN- ***
        for i:= 0 to  aQuery.FieldCount - 1 do // printout the columns header
        begin
          if i > 0 then Write(tsv_File, #9);
          Write(tsv_File, aQuery.Fields[i].FieldName);
        end;

        Writeln(tsv_File, '');

        while not aQuery.EOF do
        begin
          for i:= 0 to aQuery.FieldCount - 1 do
          begin
            if i > 0 then Write(tsv_File, #9);
              Write(tsv_File, aQuery.Fields[i].AsString);
          end;

          Writeln(tsv_File, '');
          aQuery.Next;
        end;
        // *** Other type of DataSets - END- ***
      end;

    finally
      aQuery.Close;
      aQuery.EnableControls;
    end;

    CloseFile(tsv_File);
  except
    Result:= False;
  end;
end;

function DatabaseExists(aQuery: TADOQuery; aDatabaseName: String): Boolean;
begin
  Result:= False;
  if Trim(aDatabaseName) = '' then Exit;
  if not Assigned(aQuery) then Exit;
  if not Assigned(aQuery.Connection) then Exit;
  SelectSQL(aQuery, Format('select COUNT(*) from sys.databases where name=%s',[QuotedStr(aDatabaseName)]));
  if aQuery.RecNo > 0 then
    Result:= aQuery.Fields[0].AsInteger > 0;
end;

function CreateDatabase(aQuery: TADOQuery; aDatabaseName: String): Boolean;
begin
  Result:= False;
  if Trim(aDatabaseName) = '' then Exit;
  if not Assigned(aQuery) then Exit;
  if not Assigned(aQuery.Connection) then Exit;

  aQuery.Close;
  aQuery.SQL.Text:=Format('Create Database %s',[aDatabaseName]);
  aQuery.ExecSQL;
  aQuery.Close;
end;

end.
