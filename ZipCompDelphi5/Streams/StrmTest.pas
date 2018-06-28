unit StrmTest;

interface

uses
{$IFDEF WIN32}
  Windows, ComCtrls,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VCLUnZip, VCLZip, Menus;

type
  TForm1 = class(TForm)
    Zipper: TVCLZip;
    MainMenu1: TMainMenu;
    FileMnu: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    TextMemo: TMemo;
    OpenZip: TMenuItem;
    CloseZip: TMenuItem;
    br1: TMenuItem;
    OpenDialog1: TOpenDialog;
    ClearText: TMenuItem;
    UseMemBuffs: TMenuItem;
    N2: TMenuItem;
    procedure OnOpenClick(Sender: TObject);
    procedure OnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Exit1Click(Sender: TObject);
    procedure FileMnuClick(Sender: TObject);
    procedure OpenZipClick(Sender: TObject);
    procedure CloseZipClick(Sender: TObject);
    procedure ClearTextClick(Sender: TObject);
    procedure UseMemBuffsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  CurrentFile: String;
  zipfile: TFileStream;
  zipfilename: String;

implementation

uses FileDlg;

{$R *.DFM}

procedure TForm1.OnOpenClick(Sender: TObject);
var
  TxtStream: TMemoryStream;
  n: Integer;
  Buffer: String;
  BufPtr: PChar;
begin
  FileDialog.FileBox.Clear;
  For n := 0 to Zipper.Count-1 do
     FileDialog.FileBox.Items.Add( Zipper.Fullname[n] );
  FileDialog.SelectedFile.ReadOnly := True;
  FileDialog.ShowModal;
  With FileDialog do
  If (ModalResult = mrOK) and (SelectedFile.Text <> '') then
   begin
     CurrentFile := SelectedFile.Text;
     if (UseMemBuffs.Checked) then
      begin
        n := FileDialog.FileBox.ItemIndex;
        SetLength(Buffer, Zipper.UnCompressedSize[n]);
        BufPtr := @Buffer[1];
        Zipper.UnZipToBuffer(BufPtr, CurrentFile );
        TextMemo.Lines.Text := Buffer;
      end
     Else
      begin
        TxtStream := TMemoryStream.Create;
        n := Zipper.UnZipToStream( TxtStream, CurrentFile );
        If n > 0 then
         begin
           TxtStream.Position := 0;
           TextMemo.Lines.Clear;
           TextMemo.Lines.LoadFromStream( TxtStream );
         end;
        TxtStream.Free;
      end;
     Form1.Caption := CurrentFile;
   end;
end;

procedure TForm1.OnSaveClick(Sender: TObject);
var
  TxtStream: TMemoryStream;
  n: Integer;
begin
  If TextMemo.Modified then
  With FileDialog do
   begin
     FileBox.Clear;
     For n := 0 to Zipper.Count-1 do
        FileBox.Items.Add( Zipper.Fullname[n] );
     SelectedFile.ReadOnly := False;
     SelectedFile.Text := CurrentFile;
     ShowModal;
     If ModalResult = mrOK then
      begin
        CurrentFile := SelectedFile.Text;
        if (UseMemBuffs.Checked) then
         begin
           Zipper.ZipFromBuffer(PChar(TextMemo.Lines.Text), Length(TextMemo.Lines.Text), CurrentFile);
         end
        Else
         begin
           TxtStream := TMemoryStream.Create;
           TextMemo.Lines.SaveToStream(TxtStream);
           TxtStream.Position := 0;
           Zipper.ZipFromStream( TxtStream, CurrentFile );
           TxtStream.Free;
         end;
        TextMemo.Modified := False;
        Form1.Caption := CurrentFile;
      end;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Zipper.ArchiveStream := nil;
  Zipper.PackLevel := 9;
  TextMemo.Clear;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  If TextMemo.Modified then
   begin
     If MessageDlg('Save Modified File?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        OnSaveClick(Self);
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseZipClick(Self);
  Action := caFree
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FileMnuClick(Sender: TObject);
begin
  CloseZip.Enabled := Zipper.ArchiveStream <> nil;
  Open1.Enabled := Zipper.ArchiveStream <> nil;
  Save1.Enabled := (Zipper.ArchiveStream <> nil) and (TextMemo.Modified);
  Close1.Enabled := TextMemo.Text <> '';
  ClearText.Enabled := TextMemo.Text <> '';
end;

procedure TForm1.OpenZipClick(Sender: TObject);
begin
  If (OpenDialog1.Execute) then
   begin
     If (TextMemo.Modified) and (Zipper.ArchiveStream <> nil) then
        Close1Click(Self);
     zipfilename := OpenDialog1.FileName;
     If FileExists( zipfilename ) then
      begin
        zipfile := TFileStream.Create( zipfilename, fmOpenRead );
        Zipper.ArchiveStream := TMemoryStream.Create;
        Zipper.ArchiveStream.CopyFrom( zipfile, zipfile.Size );
        zipfile.Free;
        zipfile := nil;
        Zipper.ReadZip;
      end
     Else
      begin
        Zipper.ArchiveStream := TMemoryStream.Create;
      end;
   end;
end;

procedure TForm1.CloseZipClick(Sender: TObject);
begin
  If Zipper.ArchiveStream = nil then
     exit;
  If TextMemo.Modified then
     Close1Click(Self);
  zipfile := TFileStream.Create( zipfilename, fmCreate );
  Zipper.ArchiveStream.Position := 0;
  zipfile.CopyFrom( Zipper.ArchiveStream, Zipper.ArchiveStream.Size );
  Zipper.ClearZip;
  zipfile.Free;
  zipfile := nil;
end;

procedure TForm1.ClearTextClick(Sender: TObject);
begin
  TextMemo.Clear;
end;

procedure TForm1.UseMemBuffsClick(Sender: TObject);
begin
  UseMemBuffs.Checked := not UseMemBuffs.Checked;
end;

end.
