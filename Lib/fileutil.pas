unit fileutil;


interface
    procedure myCopyfile(_from, _to: String);
    procedure Deletefile(_from: String);
    procedure Renamefile(_from, _to: String);
    procedure Movefile(_from, _to: String);

implementation


uses Windows, shellapi, shlobj, forms, sysUtils, Messages, Dialogs;

procedure myCopyfile(_from, _to: String);
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
       for k:=0 to 255 do
       begin
         f_from[k]:=#0;
         f_to[k]:=#0;
       end;

         F.Wnd := application.handle;
         F.wFunc := FO_COPY;

         StrPcopy(f_from,_from);
         StrPcopy(f_to,_to);

	 F.pFrom := f_from;
	 F.pTo := f_to;
	 F.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR;
	 if ShFileOperation(F) <> 0 then ShowMessage('Erro na Cópia. Tente novamente.');
end;

procedure Deletefile(_from: String);
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
       for k:=0 to 255 do
       begin
         f_from[k]:=#0;
         f_to[k]:=#0;
       end;
         F.Wnd := application.handle;

         F.wFunc := FO_DELETE;


         strpcopy(f_from,_from);

	 F.pFrom := f_from;
	 F.pTo := f_from;

	 F.fFlags :=  FOF_NOCONFIRMATION;
	 if ShFileOperation(F) <> 0 then ShowMessage('Erro na exclusão.');


end;

procedure Renamefile(_from, _to: String);
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
       for k:=0 to 255 do
       begin
         f_from[k]:=#0;
         f_to[k]:=#0;
       end;
         F.Wnd := application.handle;
         F.wFunc := FO_RENAME;

         StrPcopy(f_from,_from);
         StrPcopy(f_to,_to);

	 F.pFrom := f_from;
	 F.pTo := f_to;

	 F.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR;
	 if ShFileOperation(F) <> 0 then ShowMessage('Erro ao renomear.');
end;

procedure Movefile(_from, _to: String);
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
       for k:=0 to 255 do
       begin
         f_from[k]:=#0;
         f_to[k]:=#0;
       end;
         F.Wnd := application.handle;
         F.wFunc := FO_move;

         StrPcopy(f_from,_from);
         StrPcopy(f_to,_to);

	 F.pFrom := f_from;
	 F.pTo := f_from;

	 F.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR;
	 if ShFileOperation(F) <> 0 then ShowMessage('Erro ao mover.');
end;
end.
