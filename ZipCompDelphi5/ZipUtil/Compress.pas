unit Compress;

{ $Log:  D:\Util\GP-Version\Archives\VCLZip Zip Utility\UNZIP\Compress.UFV 
{
{   Rev 1.2    Sun 10 May 1998   16:54:57  Supervisor    Version: 2.12
{ Version 2.12
}
{
{   Rev 1.1    Tue 24 Mar 1998   19:03:56  Supervisor
{ Modifications to allow storing filenames and paths in DOS 
{ 8.3 format
}


interface

uses
{$IFDEF WIN32}
	Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
	SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, FileCtrl, Spin;

type
  TCompressDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ZipFileGroup: TGroupBox;
    ZipFilename: TEdit;
    ZipFileBtn: TBitBtn;
    GroupBox1: TGroupBox;
    SelectFilesBtn: TBitBtn;
    SelectedFiles: TComboBox;
    GroupBox2: TGroupBox;
    RootDirBtn: TBitBtn;
    RootDir: TEdit;
    RecurseChk: TCheckBox;
    Label6: TLabel;
    Password: TEdit;
    Label1: TLabel;
    ZipAction: TComboBox;
    Label2: TLabel;
    SaveDirInfoChk: TCheckBox;
    ClearBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    GetZipFileDlg: TSaveDialog;
    Wildcards: TEdit;
    AddWildCardBtn: TBitBtn;
    SpinButton1: TSpinButton;
    CompLevel: TLabel;
    DisposeChk: TCheckBox;
    MultiMode: TComboBox;
    MultiModeLabel: TLabel;
    SaveVolumesChk: TCheckBox;
    FirstBlockSize: TEdit;
    BlockSize: TEdit;
    WriteDiskLabelsChk: TCheckBox;
    FirstDiskLabel: TLabel;
    Label4: TLabel;
    RelativeDir: TCheckBox;
    FileSelectDlg: TOpenDialog;
    Store83Format: TCheckBox;
    Label5: TLabel;
    SaveZipInfoChk: TCheckBox;
    procedure ZipFileBtnClick(Sender: TObject);
    procedure SelectFilesBtnClick(Sender: TObject);
    procedure RootDirBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure AddWildCardBtnClick(Sender: TObject);
    procedure WildcardsChange(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DeleteBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SaveDirInfoChkClick(Sender: TObject);
    procedure MultiModeChange(Sender: TObject);
    procedure RootDirChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompressDlg: TCompressDlg;
  saveFirstBlockSize: String;

implementation

{$R *.DFM}

procedure TCompressDlg.ZipFileBtnClick(Sender: TObject);
var
  tmpZipName: String;
begin
  If (GetZipFileDlg.Execute) then
   begin
     tmpZipName := GetZipFileDlg.Filename;
     If UpperCase(ExtractFileExt(tmpZipName)) <> '.ZIP' then
        ChangeFileExt( tmpZipName, '.zip' );
     ZipFilename.Text := tmpZipName;
   end;

end;

procedure TCompressDlg.SelectFilesBtnClick(Sender: TObject);
var
	i: Integer;
begin
  FileSelectDlg.Files.Clear;
  FileSelectDlg.Filename := '';
  {$IFNDEF WIN32}
  FileSelectDlg.Options := FileSelectDlg.Options - [ofNoValidate];
  FileSelectDlg.Title := 'Select File(s) to be compressed';
  {$ENDIF}
  If (FileSelectDlg.Execute) then
     For i := 0 to FileSelectDlg.Files.Count-1 do
			If SelectedFiles.Items.IndexOf(FileSelectDlg.Files[i]) = -1 then
				SelectedFiles.Items.Add( FileSelectDlg.Files[i] );
end;


procedure TCompressDlg.RootDirBtnClick(Sender: TObject);
var
  theDir: String;
begin
  theDir := 'C:\';
  If SelectDirectory(theDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
     RootDir.Text := theDir;
end;



procedure TCompressDlg.ClearBtnClick(Sender: TObject);
begin
  SelectedFiles.Clear;
end;

procedure TCompressDlg.AddWildCardBtnClick(Sender: TObject);
begin
  SelectedFiles.Items.Add(WildCards.Text);
  WildCards.Text := '';
  AddWildCardBtn.Enabled := False;
end;

procedure TCompressDlg.WildcardsChange(Sender: TObject);
begin
  AddWildCardBtn.Enabled := Length( Wildcards.Text ) > 0;
end;

procedure TCompressDlg.SpinButton1DownClick(Sender: TObject);
var
  Value: Integer;
begin
   Value := StrToInt(CompLevel.Caption) - 1;
   If (Value >= 0) and (Value < 10) then
     CompLevel.Caption := IntToStr(Value);
end;

procedure TCompressDlg.SpinButton1UpClick(Sender: TObject);
var
  Value: Integer;
begin
   Value := StrToInt(CompLevel.Caption) + 1;
   If (Value > 0) and (Value < 10) then
     CompLevel.Caption := IntToStr(Value);
end;

procedure TCompressDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (ModalResult = mrOK) and (SelectedFiles.Items.Count = 0) then
   begin
     ShowMessage('No files have been specified to be compressed');
     Action := caNone;
   end;
end;

procedure TCompressDlg.DeleteBtnClick(Sender: TObject);
begin
  SelectedFiles.Items.Delete( SelectedFiles.ItemIndex );
end;

procedure TCompressDlg.FormActivate(Sender: TObject);
begin
  AddWildCardBtn.Enabled := False;
  MultiMode.ItemIndex := 0;
  MultiModeChange( Self );
  saveFirstBlockSize := FirstBlockSize.Text;
end;


procedure TCompressDlg.SaveDirInfoChkClick(Sender: TObject);
begin
  If SaveDirInfoChk.Checked then
     SaveVolumesChk.Enabled := True
  Else
   begin
     SaveVolumesChk.Checked := False;
     SaveVolumesChk.Enabled := False;
   end;
  RelativeDir.Enabled := (RootDir.Text <> '') and (SaveDirInfoChk.Checked);
end;



procedure TCompressDlg.MultiModeChange(Sender: TObject);
begin
  Case MultiMode.ItemIndex of
          0:  begin   { mmNone }
                 BlockSize.Enabled := False;
                 FirstBlockSize.Enabled := False;
                 WriteDiskLabelsChk.Enabled := False;
              end;
          1:  begin   { mmSpan }
                 BlockSize.Enabled := False;
                 FirstBlockSize.Enabled := True;
                 FirstBlockSize.Text := '0';
                 FirstDiskLabel.Caption := 'Save Space on First Disk';
                 WriteDiskLabelsChk.Enabled := True;
              end;
          2:  begin   { mmBlocks }
                 BlockSize.Enabled := True;
                 FirstBlockSize.Enabled := True;
                 FirstBlockSize.Text := saveFirstBlockSize;
                 FirstDiskLabel.Caption := 'First Block Size';
                 WriteDiskLabelsChk.Enabled := False;
              end;
  end;
end;


procedure TCompressDlg.RootDirChange(Sender: TObject);
begin
  RelativeDir.Enabled := (RootDir.Text <> '') and (SaveDirInfoChk.Checked);
end;




end.
