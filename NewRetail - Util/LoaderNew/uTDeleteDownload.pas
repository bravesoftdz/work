unit uTDeleteDownload;

interface

uses
  Windows, shellapi, shlobj, forms, sysUtils, Messages, Dialogs, Classes,
  uFrmNewLoader;

type
  TFiles = record
    ZipFile     : String;
    Description : String;
  end;

type
  TDeleteDownload = class(TThread)
  private
    { Private declarations }
    aFile : array[0..10] of TFiles;
    Counted : integer;

    MyDescription : String;

    procedure UpdateMainThread;
    procedure Deletefile(_from: String);

  public
    procedure SetCount;
    procedure SetDeleteFiles(sFile, sDescription : String);
    function DeleteFiles:Boolean;


  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TDeleteDownload.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TDeleteDownload }

procedure TDeleteDownload.Deletefile(_from: String);
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
	 if ShFileOperation(F) <> 0 then ShowMessage('Error deleting file '+MyDescription+'.');
end;


procedure TDeleteDownload.SetCount;
begin
  Counted := 0;
end;

procedure TDeleteDownload.SetDeleteFiles(sFile, sDescription : String);
begin

   aFile[Counted].ZipFile     := sFile;
   aFile[Counted].Description := sDescription;
   inc(Counted);

end;

function TDeleteDownload.DeleteFiles:Boolean;
var
 i : integer;
begin
  { Place thread code here }
  try
    for i:=0 to Counted-1 do
        begin
        MyDescription := aFile[i].Description;
        Synchronize(UpdateMainThread);
        Deletefile(aFile[i].ZipFile);
        end;

    Result := true;
  except
    Result := false;
  end;
end;

procedure TDeleteDownload.UpdateMainThread;
begin
    with FrmNewLoader do
        UpdateDeleteInfo(MyDescription);
end;

procedure TDeleteDownload.Execute;
begin
  { Place thread code here }
end;

end.
