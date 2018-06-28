unit uTFTPDownload;

interface

uses
  Classes, NMFtp, uFrmNewLoader;

type
  TFiles = record
    LocalFile   : String;
    ServerFile  : String;
    Description : String;
  end;

type
  TFTPDownload = class(TThread)
  private
    { Private declarations }
    aFile : array[0..10] of TFiles;
    Counted : integer;

    MyFTP : TNMFtp;
    MyDescription : String;

    procedure UpdateMainThread;

  public
    procedure SetFTP(fFTP : TNMFTP);
    procedure SetDownloadFiles(sServerFile, sLocalFile, sDescription : String);
    function DownloadFiles:Boolean;

  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TFTPDownload.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TFTPDownload }


procedure TFTPDownload.UpdateMainThread;
begin
    with FrmNewLoader do
       UpdateFTPInfo(MyDescription);
end;


procedure TFTPDownload.SetFTP(fFTP : TNMFTP);
begin

   MyFTP   := TNMFtp.Create(nil);
   MyFTP   := fFTP;
   Counted := 0;

end;

function TFTPDownload.DownloadFiles:Boolean;
var
 i : integer;
begin
  { Place thread code here }

  try
    MyFTP.Connect;

    for i:=0 to Counted-1 do
        begin
        MyDescription := aFile[i].Description;
        Synchronize(UpdateMainThread);
        MyFTP.Download(aFile[i].ServerFile, aFile[i].LocalFile);
        end;

    MyFTP.Disconnect;
    MyFTP.Free;
    Result := true;
  except
    MyFTP.Disconnect;
    MyFTP.Free;
    Result := false;
  end;


end;

procedure TFTPDownload.SetDownloadFiles(sServerFile, sLocalFile, sDescription : String);
begin

  aFile[Counted].LocalFile   := sLocalFile;
  aFile[Counted].ServerFile  := sServerFile;
  aFile[Counted].Description := sDescription;

  inc(Counted);

end;

procedure TFTPDownload.Execute;
begin
  { Place thread code here }
end;

end.
