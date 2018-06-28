unit uTUnZipDownload;

interface

uses
  Classes, VCLUnZip, uFrmNewLoader;

type
  TFiles = record
    UnZipFile   : String;
    Path        : String;
    Description : String;
  end;


type
  TUnZipDownload = class(TThread)
  private
    { Private declarations }
    aFile : array[0..10] of TFiles;
    Counted : integer;

    MyUnZip : TVCLUnZip;
    MyDescription : String;

    procedure UpdateMainThread;

  public
    procedure SetUnZip(zUnZip : TVCLUnZip);
    procedure SetUnZipFiles(sZipFile, sLocalPath, sDescription : String);
    function ExtractFiles:Boolean;

  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TUnZipDownload.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TUnZipDownload }

procedure TUnZipDownload.SetUnZip(zUnZip : TVCLUnZip);
begin
   MyUnZip := TVCLUnZip.Create(nil);
   MyUnZip := zUnZip;
   Counted := 0;
end;

procedure TUnZipDownload.SetUnZipFiles(sZipFile, sLocalPath, sDescription : String);
begin

   aFile[Counted].UnZipFile   := sZipFile;
   aFile[Counted].Path        := sLocalPath;
   aFile[Counted].Description := sDescription;
   inc(Counted);

end;

function TUnZipDownload.ExtractFiles:Boolean;
var
 i : integer;
begin
  { Place thread code here }
  try

    for i:=0 to Counted-1 do
        begin
        MyDescription := aFile[i].Description;
        Synchronize(UpdateMainThread);

        MyUnZip.ZipName := '';
        MyUnZip.ZipName := aFile[i].Path+'\'+aFile[i].UnZipFile;

        MyUnzip.DestDir := '';
        MyUnzip.DestDir := aFile[i].Path;

        MyUnzip.UnZip;
        end;

    MyUnZip.Free;
    Result := true;
  except
    Result := false;
    MyUnZip.Free;
  end;
end;

procedure TUnZipDownload.UpdateMainThread;
begin
    with FrmNewLoader do
       UpdateUnZipInfo(MyDescription);
end;

procedure TUnZipDownload.Execute;
begin
  { Place thread code here }
end;

end.
