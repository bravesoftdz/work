unit P2SMonDef;

interface

uses Windows, AdoInt;

function CreateFieldDefFile(var X: _Recordset;
  fieldDefFilePath: PChar; bOverWriteExistingFiles: bool): bool; stdcall;

implementation

function CreateFieldDefFile; external 'P2SMON';

end.

