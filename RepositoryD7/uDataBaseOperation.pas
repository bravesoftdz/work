unit uDataBaseOperation;

{*
   BACKUP RETORE MSSQL
   APPLICATION NETWORK INC.

   LOG ----------------------------
   Created by Rodrigo Costa
   05/17/02.

*}


interface

uses Db, ADODB;


const
  BKP_APPEND_INIT   = ' INIT ';
  BKP_APPEND_NOINIT = ' NOINIT ';

  RST_REPLACE_DB    = ' REPLACE, ';

  DEVICE_DISK       = ' DISK=';

type
   TDataBaseOperation = class
     private
       FADOConnection  : TADOConnection;  //Connection to the DB
       FSQLText        : String;          //SQL to be executed
       FDataBaseName   : String;          //DB name
       FDevice         : String;          //Device available Disk, Tape, or Pipe.
       function ExecOperarion  : Integer; //Run SQL
     public
       property DataBaseName   : String         read FDataBaseName  write FDataBaseName;
       property Device         : String         read FDevice        write FDevice;
       property Connection     : TADOConnection read FADOConnection write FADOConnection;
       function SetSQLExecute  : Integer; virtual; abstract; //Set SQL and execute
   end;



   TBackUpDataBase = class(TDataBaseOperation)
   private
      FFilePath       : String; //Physical location on the HD
      FAppendDataBase : String; //Append or Override backupfile
   public
      property AppendDB  : String read FAppendDataBase write FAppendDataBase;
      property FilePath  : String read FFilePath       write FFilePath;
      function SetSQLExecute : Integer; override;
   end;


   TRestoreDataBase = class(TDataBaseOperation)
   private
     FLogicalDataName : String; //Logical database data name
     FLogicalLogName  : String; //Logical database log name
     FNewDatePath     : String; //Physical location of the Database data file
     FNewLogPath      : String; //Physical location of the Database log file
     FForceRestore    : String; //Force restore over an existent DB
   public
     property LogicalDataName : String read FLogicalDataName write FLogicalDataName;
     property LogicalLogName  : String read FLogicalLogName  write FLogicalLogName;
     property NewDataPath     : String read FNewDatePath     write FNewDatePath;
     property NewLogPath      : String read FNewLogPath      write FNewLogPath;
     property ForceRestore    : String read FForceRestore    write FForceRestore;
     function SetSQLExecute   : Integer; override;
   end;



implementation

uses Sysutils;

{  TDataBaseOperation }

function TDataBaseOperation.ExecOperarion:integer;
var
  cmd : TADOCommand;
begin

  Result := -1;

  cmd := nil;

  try
     cmd                := TADOCommand.Create(nil);
     cmd.Connection     := FADOConnection;
     cmd.CommandTimeout := 5000000;
     cmd.CommandText    := FSQLText;
     try
       cmd.Execute;
     except
       raise;
       Result := 100; //Error
     end;
  finally
    FreeAndNil(cmd);
  end;

end;

{ TBackUpDataBase }

function TBackUpDataBase.SetSQLExecute:Integer;
begin

  { Alex 8/8/2011 - Mixed Backup Commands (LOG and DATABASE) causeinf error }
  {
  FSQLText := ' BACKUP TRANSACTION '+FDataBaseName+' WITH TRUNCATE_ONLY ' +
              ' BACKUP DATABASE '+FDataBaseName+' TO '+FDevice+' '+
              ' WITH ' + FAppendDataBase;

  Result := ExecOperarion;
  }

  //FSQLText := ' BACKUP LOG '+ FDataBaseName+' TO '+StringReplace( FDevice, '.Bak', '.Log', [rfIgnoreCase] );
  //Result := ExecOperarion;

  FSQLText := ' BACKUP DATABASE '+FDataBaseName+' TO '+FDevice+' '+
              ' WITH ' + FAppendDataBase;

  Result := ExecOperarion;

end;

{ TRestoreDataBase }

function TRestoreDataBase.SetSQLExecute:Integer;
begin

  FSQLText := ' RESTORE DATABASE '+ FDataBaseName +' FROM ' + FDevice +
              ' WITH '+ FForceRestore +
              ' MOVE '+ FLogicalDataName + ' TO ' + FNewDatePath + ', ' +
              ' MOVE '+ FLogicalLogName  + ' TO ' + FNewLogPath;

  Result := ExecOperarion;

end;



end.
