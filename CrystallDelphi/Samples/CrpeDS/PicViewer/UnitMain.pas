unit UnitMain;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs, Graphics,
  StdCtrls, UCrpe32, UCrpeDS, Db, UCrpeClasses;

type
  TfrmMain = class(TForm)
    btnSelect: TButton;
    CrpeDS1: TCrpeDS;
    Crpe1: TCrpe;
    Memo1: TMemo;
    cbGrow: TCheckBox;
    procedure btnSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CrpeDS1GetRecordCount(Sender: TObject; DataSet: TDataSet;
      var RecordCount: Integer);
    procedure CrpeDS1GetFieldCount(Sender: TObject; DataSet: TDataSet;
      var FieldCount: Smallint);
    procedure CrpeDS1GetFieldName(Sender: TObject; DataSet: TDataSet;
      FieldIndex: Smallint; var FieldName: WideString);
    procedure CrpeDS1GetFieldType(Sender: TObject; DataSet: TDataSet;
      FieldIndex: Smallint; var FieldType: Smallint);
    procedure CrpeDS1GetBlobFieldValue(Sender: TObject; DataSet: TDataSet;
      FieldIndex: Smallint; var BlobFieldValue: TMemoryStream);
    procedure CrpeDS1MoveFirst(Sender: TObject; DataSet: TDataSet);
    procedure CrpeDS1MoveNext(Sender: TObject; DataSet: TDataSet);
    procedure CrpeDS1GetBookmark(Sender: TObject; DataSet: TDataSet;
      var Bookmark: OleVariant);
    procedure CrpeDS1SetBookmark(Sender: TObject; DataSet: TDataSet;
      var Bookmark: OleVariant);
    procedure CrpeDS1EOF(Sender: TObject; DataSet: TDataSet;
      var EndOfFile: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain  : TfrmMain;
  ExePath  : string;
  BmpPath  : string;
  BmpCount : integer;
  BmpItem  : integer;
  Bkmark   : string;

implementation

{$R *.DFM}

uses FileCtrl, UnitPath, Utilities;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ExePath := AddBackSlash(ExtractFileDir(Application.ExeName));
  BmpPath := ExePath;
end;

procedure TfrmMain.btnSelectClick(Sender: TObject);
var
  n : integer;
  
  function GetFileCount(SourceDir: string): integer;
  var
    fSearch : TSearchRec;
    i       : integer;
    s       : string;
  begin
    i := 0;
    s := AddBackSlash(SourceDir) + '*.bmp';
    if FindFirst(s, faAnyFile, fSearch) = 0 then
    begin
      {skip directories}
      if (fSearch.Name <> '.') and (fSearch.Name <> '..') and
         (fSearch.Attr and faDirectory = 0) then
        Inc(i);
      {Count the next files}
      while FindNext(fSearch) = 0 do
      begin
        {skip directories}
        if (fSearch.Name <> '.') and (fSearch.Name <> '..') and
           (fSearch.Attr and faDirectory = 0) then
          Inc(i);
      end;
      FindClose(fSearch);
    end;
    Result := i;
  end;

begin
  PathDlg := TPathDlg.Create(Self);
  PathDlg.Caption := 'Select a Bitmap Directory';
  PathDlg.rPath := BmpPath;
  PathDlg.ShowModal;
  if PathDlg.ModalResult = mrOk then
  begin
    if DirectoryExists(PathDlg.rPath) then
      BmpPath := PathDlg.rPath;
    BmpCount := GetFileCount(BmpPath);
    Memo1.Lines.Clear;
    Crpe1.ReportName := ExePath + 'PicViewer.rpt';
    Crpe1.DiscardSavedData;
    Crpe1.Tables[0].DataPointer := CrpeDS1.DataPointer;
    for n := 0 to Crpe1.Pictures.Count-1 do
      Crpe1.Pictures[n].CanGrow := cbGrow.Checked;
    Crpe1.ReportOptions.ZoomMode := pwPageWidth;
    Crpe1.WindowButtonBar.ToolbarTips := True;
    Crpe1.WindowButtonBar.CancelBtn := True;
    Crpe1.Show;
  end;
end;

procedure TfrmMain.CrpeDS1GetRecordCount(Sender: TObject;
  DataSet: TDataSet; var RecordCount: Integer);
begin
  RecordCount := BmpCount div 8;
  Memo1.Lines.Add('GetRecordCount: ' + IntToStr(RecordCount));
end;

procedure TfrmMain.CrpeDS1GetFieldCount(Sender: TObject; DataSet: TDataSet;
  var FieldCount: Smallint);
begin
  FieldCount := 8;
  Memo1.Lines.Add('GetFieldCount: ' + IntToStr(FieldCount));
end;

procedure TfrmMain.CrpeDS1GetFieldName(Sender: TObject; DataSet: TDataSet;
  FieldIndex: Smallint; var FieldName: WideString);
begin
  case FieldIndex of
    0: FieldName := 'Image1';
    1: FieldName := 'Image2';
    2: FieldName := 'Image3';
    3: FieldName := 'Image4';
    4: FieldName := 'Image5';
    5: FieldName := 'Image6';
    6: FieldName := 'Image7';
    7: FieldName := 'Image8';
  end;
  Memo1.Lines.Add('GetFieldName: ' + FieldName);
end;

procedure TfrmMain.CrpeDS1GetFieldType(Sender: TObject; DataSet: TDataSet;
  FieldIndex: Smallint; var FieldType: Smallint);
begin
  FieldType := varArray or varByte;
  Memo1.Lines.Add('GetFieldType: ' + IntToStr(FieldType));
end;

procedure TfrmMain.CrpeDS1GetBlobFieldValue(Sender: TObject;
  DataSet: TDataSet; FieldIndex: Smallint;
  var BlobFieldValue: TMemoryStream);
var
  bitmap: TBitmap;
  sFile : string;

  function GetBmpItem(index: integer): string;
  var
    fSearch : TSearchRec;
    i       : integer;
    s       : string;
  begin
    i := 0;
    Result := '';
    s := AddBackSlash(BmpPath) + '*.bmp';
    if FindFirst(s, faAnyFile, fSearch) = 0 then
    begin
      {skip directories}
      if (fSearch.Name <> '.') and (fSearch.Name <> '..') and
         (fSearch.Attr and faDirectory = 0) then
      begin
        Inc(i);
        if i = index then
        begin
          Result := fSearch.Name;
          Inc(BmpItem);
          Exit;
        end;
      end;
      {Count the next files}
      while FindNext(fSearch) = 0 do
      begin
        {skip directories}
        if (fSearch.Name <> '.') and (fSearch.Name <> '..') and
           (fSearch.Attr and faDirectory = 0) then
        begin
          Inc(i);
          if i = index then
          begin
            Result := fSearch.Name;
            Inc(BmpItem);
            Exit;
          end;
        end;
      end;
    end;
    FindClose(fSearch);
  end;

begin
  bitmap := TBitmap.Create;
  try
    sFile := GetBmpItem(BmpItem);
Memo1.Lines.Add('GetBlob: ' + AddBackSlash(BmpPath) + sFile);
    if FileExists(AddBackSlash(BmpPath) + sFile) then
    begin
      bitmap.LoadFromFile(AddBackSlash(BmpPath) + sFile);
      bitmap.SaveToStream(BlobFieldValue);
    end;
  finally
    bitmap.free;
  end;
end;

procedure TfrmMain.CrpeDS1MoveFirst(Sender: TObject; DataSet: TDataSet);
begin
  BmpItem := 1;
  Memo1.Lines.Add('MoveFirst');
end;

procedure TfrmMain.CrpeDS1MoveNext(Sender: TObject; DataSet: TDataSet);
begin
  Memo1.Lines.Add('MoveNext');
end;

procedure TfrmMain.CrpeDS1GetBookmark(Sender: TObject; DataSet: TDataSet;
  var Bookmark: OleVariant);
begin
  Bookmark := BkMark;
  Memo1.Lines.Add('GetBookmark: ' + Bookmark);
end;

procedure TfrmMain.CrpeDS1SetBookmark(Sender: TObject; DataSet: TDataSet;
  var Bookmark: OleVariant);
begin
  BkMark := Bookmark;
  Memo1.Lines.Add('SetBookmark: ' + Bookmark);
end;

procedure TfrmMain.CrpeDS1EOF(Sender: TObject; DataSet: TDataSet;
  var EndOfFile: Boolean);
begin
  EndOfFile := (BmpItem >= BmpCount) or (BmpCount = 0);
  Memo1.Lines.Add('EndOfFile: ' + CrBooleanToStr(EndOfFile, False));
end;


end.
