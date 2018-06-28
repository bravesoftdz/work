unit uDebugFunctions;

{ Alex - Created 30/03/2011 }

interface

Uses Graphics, SysUtils, Windows, ShellApi, Forms, Jpeg, Classes, Dialogs;

Procedure DebugToFile( psText : String );
Procedure clearDebugHere();

implementation

procedure clearDebugHere();
var
  sFileName: String;
  outputFile: TextFile;
begin
  sFileName := ExtractFilePath( ParamStr(0) ) +'DEBUG.LOG';

  AssignFile( OutPutFile, sFileName );
  if FileExists( sFileName ) Then begin
     append( OutPutFile )
  end else begin
         reWrite( OutPutFile )
      end;
      
end;

Procedure DebugToFile( psText : String  );
Var
  OutPutFile : TextFile;
  sFileName  : String;
  i: Integer;
  cmd: String;
  readyToDebug: Boolean;
Begin

  {$I-}

  cmd := cmdLine;
  //showMessage(cmd);

  readyToDebug := false;

  for i:= 0 to ParamCount do begin
     //showMessageFmt('Parameter %d = %s', [i, ParamStr(i)]);
     readytoDebug := ( paramStr(i) = '-d' );

     if ( readyToDebug ) then
        break;
  end;

  // Antonio 2014 Jan 8, parameter to debug "-d"
  if ( readyToDebug ) then begin
      sFileName := ExtractFilePath( ParamStr(0) ) +'DEBUG.LOG';

      AssignFile( OutPutFile, sFileName );
      If FileExists( sFileName )
      Then Append( OutPutFile )
      Else ReWrite( OutPutFile );

      Writeln( OutPutFile, psText );
      Close( OutPutFile );
  end;

  {$I+}

  Application.ProcessMessages;

End;


end.
