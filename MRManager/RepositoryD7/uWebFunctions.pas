unit uWebFunctions;

interface

uses ShellAPI, Windows;

procedure OpenURL(sURL : String);

implementation

procedure OpenURL(sURL : String);
begin

   ShellExecute(0, 'Open', PChar(sURL), nil, nil, SW_SHOWNORMAL)

end;

end.
