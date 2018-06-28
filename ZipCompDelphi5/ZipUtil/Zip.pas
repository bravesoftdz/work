{ ********************************************************************************** }
{                                                                                    }
{ 	 COPYRIGHT 1997 Kevin Boylan                                                    }
{     Source File: Unzip.pas                                                         }
{     Description: VCLUnZip component demo - native Delphi unzip component.          }
{     Date:        March 1997                                                        }
{     Author:      Kevin Boylan, CIS: boylank                                        }
{                                Internet: boylank@bigfoot.com                    }
{                                                                                    }
{ ********************************************************************************** }
unit zip;
{$P-}

{  Sun 29 Mar 1998   10:49:13    Version: 2.1
{ Version 2.1 additions
{
{ - Capability of 16bit VCLZip to store long filenames/paths
{ when running on 32 bit OS.
{ - New Store83Names property to force storing short
{ filenames and paths
{ - Better UNC path support.
{ - Fixed a bug to allow adding files to an empty archive.
}
{
{  Tue 24 Mar 1998   19:03:57
{ Modifications to allow storing filenames and paths in DOS
{ 8.3 format
}
{
{  Wed 11 Mar 1998   20:58:48  Version: 2.03
{ Version 2.03, Fixed several bugs.
}

interface

uses
   {$IFDEF WIN32}
   Windows, ComCtrls,
   {$ELSE}
   WinTypes, WinProcs,
   {$ENDIF}
   SysUtils, Messages, ShellAPI, Classes, Graphics, Controls,
   Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
   Menus, Gauges, IncZip, Tabnotbk, IniFiles, OvrWrite, KPLib,
   VCLZip, VCLUnZip, kpZipObj;

type
   TConfigInfo = record
      DefaultViewer: string;
      ForceDefaultViewer: Boolean;
      LowerCaseFiles: Boolean;
   end;

   TVCLZipForm = class(TForm)
      Panel1: TPanel;
      ExtractBtn: TSpeedButton;
      OpenZipBtn: TSpeedButton;
      StatusBar: TPanel;
      Header1: THeader;
      MainMenu1: TMainMenu;
      FileMenu: TMenuItem;
      Open1: TMenuItem;
      Close1: TMenuItem;
      N1: TMenuItem;
      Exit1: TMenuItem;
      Action1: TMenuItem;
      Unzip1: TMenuItem;
      Sort1: TMenuItem;
      None1: TMenuItem;
      FileName1: TMenuItem;
      Dircetory1: TMenuItem;
      Date1: TMenuItem;
      Size1: TMenuItem;
      Rate1: TMenuItem;
      NoOrder: TMenuItem;
      UncompressedSize1: TMenuItem;
      Gauge1: TGauge;
      CurrentFileLabel: TLabel;
      Infowin: TMemo;
      Gauge2: TGauge;
      Label2: TLabel;
      ZipCommentMnu: TMenuItem;
      ExitBtn: TSpeedButton;
      FilesList: TListBox;
      ClearLogWindow1: TMenuItem;
      FileSelectDlg: TOpenDialog;
      Help1: TMenuItem;
      About1: TMenuItem;
      RenameDlg: TSaveDialog;
      AddBtn: TSpeedButton;
      NewZipBtn: TSpeedButton;
      New1: TMenuItem;
      Add1: TMenuItem;
      Configure1: TMenuItem;
      N2: TMenuItem;
      ConfigBtn: TSpeedButton;
      DeleteBtn: TSpeedButton;
      AbortBtn: TSpeedButton;
      BackupBtn: TSpeedButton;
      ZipCommentBtn: TSpeedButton;
      FileCommentBtn: TSpeedButton;
      SaveMenuItem: TMenuItem;
      FixMenu: TMenuItem;
      Zipper: TVCLZip;
      N3: TMenuItem;
      MakeSFX32Mnu: TMenuItem;
      Make16bitSFXMnu: TMenuItem;
      ZipSizeLabel: TLabel;
      Label1: TLabel;
      DeleteFiles: TMenuItem;
      ModifyPath: TMenuItem;
      ModifyFilename1: TMenuItem;
      N4: TMenuItem;
      TestZipFile1: TMenuItem;
      N5: TMenuItem;
      SFXtoZipMnu: TMenuItem;
      procedure ExtractBtnClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure OpenZipBtnClick(Sender: TObject);
      procedure OnExitBtn(Sender: TObject);
      procedure Close1Click(Sender: TObject);
      procedure OnSort(Sender: TObject);
      procedure Header1Sized(Sender: TObject; ASection, AWidth: Integer);
      procedure ZipperStartUnZip(Sender: TObject; FileIndex: Integer;
         var FName: string; var Skip: Boolean);
      procedure ZipperBadPassword(Sender: TObject; FileIndex: Integer; var NewPassword:
         string);
      procedure ZipperFilePercentDone(Sender: TObject; Percent: Longint);
      procedure ZipperSkippingFile(Sender: TObject; Reason: TSkipReason; FName: string;
         FileIndex: Integer; var Retry: Boolean );
      procedure ZipperPromptForOverwrite(Sender: TObject; var OverWriteIt: Boolean;
         FileIndex: Integer; var FName: string);
      procedure ZipperBadCRC(Sender: TObject; CalcCRC, StoredCRC: LongInt; FileIndex: Integer);
      procedure ZipperTotalPercentDone(Sender: TObject; Percent: LongInt);
      procedure ZipCommentMnuClick(Sender: TObject);
      procedure ZipperStartUnzipInfo(Sender: TObject; NumFiles: Integer;
         TotalBytes: Comp; var StopNow: Boolean);
      procedure ZipperGetNextDisk(Sender: TObject; NextDisk: Integer; var FName: string);
      procedure FilesList1DrawItem(Control: TWinControl; Index: Integer;
         Rect: TRect; State: TOwnerDrawState);
      procedure FilesList1MeasureItem(Control: TWinControl; Index: Integer;
         var Height: Integer);
      procedure ZipperInCompleteZip(Sender: TObject;
         var IncompleteMode: TIncompleteZipMode);
      procedure ClearLogWindow1Click(Sender: TObject);
      procedure FilesListDblClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure About1Click(Sender: TObject);
      procedure NewZipBtnClick(Sender: TObject);
      procedure OnAddFiles(Sender: TObject);
      procedure FormKeyUp(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Configure1Click(Sender: TObject);
      procedure ZipperStartZip(Sender: TObject; FName: string;
         var ZipHeader: TZipHeaderInfo; var Skip: Boolean);
      procedure DeleteBtnClick(Sender: TObject);
      procedure AbortBtnClick(Sender: TObject);
      procedure BackupBtnClick(Sender: TObject);
      procedure SaveMenuItemClick(Sender: TObject);
      procedure FileCommentBtnClick(Sender: TObject);
      procedure FileMenuClick(Sender: TObject);
      procedure FixMenuClick(Sender: TObject);
      procedure MakeSFX32MnuClick(Sender: TObject);
      procedure Make16bitSFXMnuClick(Sender: TObject);
      procedure ZipperEndZip(Sender: TObject; FName: string;
         UncompressedSize, CompressedSize, CurrentZipSize: LongInt);
      procedure ZipperStartZipInfo(Sender: TObject; NumFiles: Integer;
         TotalBytes: Comp; var EndCentralRecord: TEndCentral; var StopNow: Boolean);
      procedure ZipperDeleteEntry(Sender: TObject; FName: string;
         var Skip: Boolean);
      procedure ZipperDisposeFile(Sender: TObject; FName: string;
         var Skip: Boolean);
      procedure ModifyPathClick(Sender: TObject);
      procedure ModifyFilename1Click(Sender: TObject);
      procedure TestZipFile1Click(Sender: TObject);
      procedure SFXtoZipMnuClick(Sender: TObject);
      procedure ZipperUnZipComplete(sender: TObject; FileCount: Integer);
    procedure ZipperUpdate(Sender: TObject; UDAction: TUpdateAction;
      FileIndex: Integer);
   PRIVATE
      { Private declarations }
      procedure OpenTheZip;
      procedure InitHeaderWidths;
      procedure CleanupViewList;
      procedure ReadIni;
      procedure WriteIni;
      procedure AddFiles;
      procedure MakeFilesListFromListBox;
      procedure DeleteFromZip;
      procedure SetLogging;
      procedure UpdateExtractDlg;
      procedure GetExtractDlgInfo;
      procedure UpdateCompressDlg;
      procedure GetCompressDlgInfo;
      procedure UpdateConfigDlg;
      procedure GetConfigDlgInfo;
      procedure MakeSFX(Stub: string);
   PROTECTED
      procedure Loaded; OVERRIDE;

   PUBLIC
      { Public declarations }
   end;

var
   VCLZipForm                 : TVCLZipForm;
   CheckedSortItem            : TMenuItem;
   ViewFilesList              : TStringList;
   ZipFromDir                 : string;
   ConfigInfo                 : TConfigInfo;
   sfx16, sfx32               : string;
   Testing                    : Boolean;

implementation

uses Extract, Compress, Config, Comment, ModInfo, InvPwd;

{$R *.DFM}

procedure TVCLZipForm.FormCreate(Sender: TObject);
var
   CommandLine                : string;
   ArgPos                     : Integer;
begin
   {  ReadIni;   }
   InitHeaderWidths;
   CheckedSortItem := NoOrder;
   CheckedSortItem.Checked := True;
   ViewFilesList := TStringList.Create;
   { WIN32 includes module path\filename in cmdline }
   CommandLine := PCharToStr(CmdLine);
   {$IFDEF WIN32}
   ArgPos := Pos(' ', CommandLine);
   if (ArgPos = 0) or (ArgPos = Length(CommandLine)) then
      CommandLine := ''
   else
      CommandLine := Copy(CommandLine, ArgPos + 1, Length(CommandLine));
   {$ENDIF}
   if (CommandLine = '') or (not (File_Exists(CommandLine))) then
      Zipper.ZipName := '' { just to seed the initial directory for }
   else { the open zip dialog box                }
   begin
      Zipper.ZipName := CommandLine;
      OpenTheZip;
   end;
   Zipper.PreserveStubs := True;
   Testing := False;
end;

procedure TVCLZipForm.Loaded;
begin
   inherited Loaded;
   ReadIni;
end;

procedure TVCLZipForm.MakeFilesListFromListBox;
var
   i                          : Integer;
begin
   Zipper.FilesList.Clear;
   for i := 0 to VCLZipForm.FilesList.Items.Count - 1 do
      if VCLZipForm.FilesList.Selected[i] then
         Zipper.Selected[i] := True;
         {Zipper.FilesList.Add(Zipper.FullName[i]);}
end;

procedure TVCLZipForm.UpdateExtractDlg;
begin
   Zipper.FilesList.Clear;                              {added 10/15/97 KLB}
   with ExtractDlg do
   begin
      if FilesList.SelCount > 0 then
         SelectedFiles.Checked := True
      else
         AllFilesRBtn.Checked := True;
      DestDir.Text := Zipper.DestDir;
      RelDir.Text := '';
      Overwrite.ItemIndex := Ord(Zipper.OverwriteMode);
      RecreateDir.Checked := Zipper.RecreateDirs;
      RetainAttributesChk.Checked := Zipper.RetainAttributes;
      Password.Text := Zipper.Password;
   end;
end;

procedure TVCLZipForm.GetExtractDlgInfo;
begin
   with ExtractDlg do
   begin
      Zipper.DoAll := AllFilesRBtn.Checked;
      Zipper.DestDir := DestDir.Text;
      Zipper.RootDir := RelDir.Text;
      Zipper.OverwriteMode := TUZOverwriteMode(Overwrite.ItemIndex);
      Zipper.RecreateDirs := RecreateDir.Checked;
      Zipper.RetainAttributes := RetainAttributesChk.Checked;
      Zipper.Password := Password.Text;
   end;
end;

procedure TVCLZipForm.ExtractBtnClick(Sender: TObject);
var
   NumUnZipped                : Integer;
begin
   NumUnZipped := 0;
   try
      if Zipper.Count = 0 then
      begin
         MessageBeep(0);
         exit;
      end;
      with Zipper do
      begin
         UpdateExtractDlg;
         if ExtractDlg.ShowModal <> mrOK then
            exit;
         GetExtractDlgInfo;
         if DoAll then
         begin
            Screen.Cursor := crHourGlass;
            NumUnZipped := UnZip;
         end
         else
         begin
            if ExtractDlg.UseMask.Checked then
             begin
               Zipper.FilesList.Add(ExtractDlg.ExtractMask.Text);
               Screen.Cursor := crHourGlass;
               NumUnZipped := UnZip;
             end
            else
             begin
               MakeFilesListFromListBox;
               Screen.Cursor := crHourGlass;
               NumUnZipped := UnZipSelected;
             end;
         end;
      end;
   finally
      Gauge1.Progress := 0;
      Gauge2.Progress := 0;
      CurrentFileLabel.Caption := '';
      Screen.Cursor := crDefault;
      MessageBeep(0);
      if NumUnZipped > 0 then
         InfoWin.Lines.Add(IntToStr(NumUnZipped) + ' Files Unzipped!')
      else
         if Zipper.Count > 0 then
            InfoWin.Lines.Add('No Files Unzipped!')
   end;
end;

procedure TVCLZipForm.OpenZipBtnClick(Sender: TObject);
begin
   try
      Zipper.ZipName := ZipFromDir + '\?';
   except
      on EUserCanceled do
      begin
         Screen.Cursor := crDefault;
         exit;
      end
   else
      raise; { If not EUserCanceled then re-raise the exception }
   end;
   OpenTheZip;
end;

procedure TVCLZipForm.OpenTheZip;
var
   TryAgain                   : Boolean;
   tmpName                    : string;
begin
   with Zipper do
      if (ZipName <> '') and (ZipName[Length(ZipName)] <> '?') then
      begin
         CleanupViewList;
         tmpName := ZipName;
         repeat
            TryAgain := False;
            try
               ReadZip;
            except
               on EincompleteZip do
               begin
                 if
                     MessageDlg('Enter Last Disk of Disk Set. Press Yes to continue or No to abort',
                     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                   begin
                     tryagain := True;
                     ZipName := tmpName;
                   end
                  else
                     tryagain := False;
               end;
            end;
         until (TryAgain = False);

         if ZipName = '' then
         begin
            Close1Click(self);
            exit;
         end;

         { The following not needed since I fixed VCLUnZip 3/10/98 2.03}
         if (NumDisks > 1) then                         { 3/7/98 2.03 }
         begin
            if ((AnsiCompareStr(ZipName[1], 'A') = 0) or (AnsiCompareStr(ZipName[1], 'A') = 0))
               then
               MultiMode := mmSpan
            else
               MultiMode := mmBlocks;
         end;
         Self.FilesList.Items.BeginUpdate;
         FillList(Self.FilesList.Items);
         Self.FilesList.Items.EndUpdate;
         Self.FilesList.Update;
         StatusBar.Caption := IntToStr(Zipper.Count) + ' Files';
         ZipCommentMnu.Checked := Zipper.ZipHasComment;
         Caption := ZipName;
         ZipFromDir := ExtractFileDir(ZipName);
         ZipSizeLabel.Caption := IntToStr(Zipper.ZipSize);
      end;
end;

procedure TVCLZipForm.InitHeaderWidths;
begin
   with Header1 do
   begin
      SectionWidth[0] := Canvas.TextWidth('XXXXXXXX.XXXX'); { File }
      SectionWidth[1] := Canvas.TextWidth('XXXX/XX/XXX'); { Date }
      SectionWidth[2] := Canvas.TextWidth('99:99PMX');  { Time }
      SectionWidth[3] := Canvas.TextWidth('99999999');  { Size }
      SectionWidth[4] := Canvas.TextWidth('99999999');  { Packed }
      SectionWidth[5] := Canvas.TextWidth('XXXXx');     { Rate }
      SectionWidth[6] := Canvas.TextWidth('XXXXXX');    { Method }
      SectionWidth[7] := Canvas.TextWidth('XXXXXXXXXXXXXX'); { Path }
   end;
end;

procedure TVCLZipForm.OnExitBtn(Sender: TObject);
begin
   Close;
end;

procedure TVCLZipForm.ReadIni;
var
   IniFile                    : TIniFile;
begin
   IniFile := TIniFile.Create('VCLZip.Ini');
   with ConfigInfo, IniFile, Zipper do
   begin
      DefaultViewer := ReadString('Viewer', 'Default', 'NOTEPAD');
      ForceDefaultViewer := ReadBool('Viewer', 'Force', False);
      LowerCaseFiles := ReadBool('Viewer', 'Lowecase', True);
      if not ReadBool('Logging', 'OnStartUnZipInfo', True) then
         OnStartUnZipInfo := nil;
      if not ReadBool('Logging', 'OnStartUnZip', True) then
         OnStartUnZip := nil;
      if not ReadBool('Logging', 'OnBadCRC', True) then
         OnBadCRC := nil;
      if not ReadBool('Logging', 'OnBadPassword', True) then
         OnBadPassword := nil;
      if not ReadBool('Logging', 'OnSkippingFile', True) then
         OnSkippingFile := nil;
      if not ReadBool('Logging', 'OnStartZipInfo', True) then
         OnStartZipInfo := nil;
      if not ReadBool('Logging', 'OnStartZip', True) then
         OnStartZip := nil;
      if not ReadBool('Logging', 'OnEndZip', True) then
         OnEndZip := nil;
      DestDir := ReadString('Paths', 'DestDir', 'c:\');
      sfx16 := ReadString('SFX', '16Bit', '');
      sfx32 := ReadString('SFX', '32Bit', '');
      if sfx16 = '' then
         sfx16 := ExtractFilePath(Application.EXEName) + 'zipsfx16.bin';
      if sfx32 = '' then
         sfx32 := ExtractFilePath(Application.EXEName) + 'zipsfx32.bin';
      ZipFromDir := ReadString('Paths', 'FromDir', 'c:\');
      if (Length(ZipFromDir) > 0) and (ZipFromDir[Length(ZipFromDir)] = '\') then
         SetLength(ZipFromDir, Length(ZipFromDir) - 1);
      IniFile.Free;
   end;
end;

procedure TVCLZipForm.WriteIni;
var
   IniFile                    : TIniFile;
begin
   IniFile := TIniFile.Create('VCLZip.Ini');
   with IniFile, Zipper do
   begin
      WriteString('Viewer', 'Default', ConfigInfo.DefaultViewer);
      WriteBool('Viewer', 'Force', ConfigInfo.ForceDefaultViewer);
      WriteBool('Viewer', 'Lowercase', ConfigInfo.LowercaseFiles);
      {$IFDEF WIN32}
      WriteBool('Logging', 'OnStartUnZipInfo', Assigned(OnStartUnZipInfo));
      WriteBool('Logging', 'OnStartUnZip', Assigned(OnStartUnZip));
      WriteBool('Logging', 'OnBadCRC', Assigned(OnBadCRC));
      WriteBool('Logging', 'OnBadPassword', Assigned(OnBadPassword));
      WriteBool('Logging', 'OnSkippingFile', Assigned(OnSkippingFile));
      WriteBool('Logging', 'OnStartZipInfo', Assigned(OnStartZipInfo));
      WriteBool('Logging', 'OnStartZip', Assigned(OnStartZip));
      WriteBool('Logging', 'OnEndZip', Assigned(OnEndZip));
      {$ENDIF}
      { Just to be sure, we don't want dialog boxes to come up if user has this app
      associated with zip files and double clicks on a zip file in File Manager or
      Explorer }
      if Zipper.DestDir = '?' then
         Zipper.DestDir := 'C:\';
      if (ZipFromDir = '?') or (ZipFromDir = '') then
         ZipFromDir := 'C:';
      if ZipFromDir[Length(ZipFromDir)] = '\' then
         SetLength(ZipFromDir, Length(ZipFromDir) - 1);
      WriteString('Paths', 'DestDir', Zipper.DestDir);
      WriteString('Paths', 'FromDir', ZipFromDir);
      WriteString('SFX', '16Bit', sfx16);
      WriteString('SFX', '32bit', sfx32);
   end;
   IniFile.Free;
end;

procedure TVCLZipForm.CleanupViewList;
var
   i                          : Integer;
begin
   if ViewFilesList.Count > 0 then
   begin
      for i := 0 to ViewFilesList.Count - 1 do
         SysUtils.DeleteFile(ViewFilesList[i]);
      ViewFilesList.Clear;
   end;
end;

procedure TVCLZipForm.Close1Click(Sender: TObject);
begin
   FilesList.Clear;
   Zipper.ClearZip;
   CleanupViewList;
   ZipSizeLabel.Caption := '0';
   Caption := 'VCLUnZip Utility';
end;

procedure TVCLZipForm.OnSort(Sender: TObject);
begin
   with Sender as TMenuItem do
   begin
      Zipper.Sort(TZipSortMode(Tag));
      Zipper.FillList(FilesList.Items);
      Checked := True;
      CheckedSortItem.Checked := False;
   end;
   CheckedSortItem := TMenuItem(Sender);
end;

procedure TVCLZipForm.Header1Sized(Sender: TObject; ASection,
   AWidth: Integer);
begin
   FilesList.Refresh;
end;

procedure TVCLZipForm.ZipperStartUnZip(Sender: TObject; FileIndex: Integer;
   var FName: string; var Skip: Boolean);
begin
      If (Testing) then
        Infowin.Lines.Add('Testing ' + TVCLUnZip(Sender).FullName[FileIndex])
      Else
        Infowin.Lines.Add('Unzipping ' + FName + '. Method -> ' +
           TVCLUnZip(Sender).CompressMethodStr[FileIndex]);
      CurrentFileLabel.Caption := TVCLUnZip(Sender).Filename[FileIndex];
      CurrentFileLabel.Repaint;
end;

procedure TVCLZipForm.ZipperBadPassword(Sender: TObject; FileIndex: Integer; var NewPassword:
   string);
var
   MsgArray                   : array[0..255] of char;
begin
   If Testing then
      InfoWin.Lines.Add('...Invalid password or possible corruption for file '
                        + TVCLZip(Sender).Filename[FileIndex])
   else with Zipper do
   begin
      InvalidPwdDlg.PasswordEdit.Text := NewPassword;
      InvalidPwdDlg.Filename.Caption := Filename[FileIndex];
      MessageBeep(0);
      InvalidPwdDlg.ShowModal;
      if InvalidPwdDlg.ModalResult = mrOK then
         NewPassword := InvalidPwdDlg.PasswordEdit.Text
      else
      begin
         StrPCopy(MsgArray, 'Invalid Password for file ' + Filename[FileIndex]);
         Application.MessageBox(MsgArray, 'Password Error', mb_OK);
         InfoWin.Lines.Add('...Invalid password for file ' + Filename[FileIndex]);
      end;
   end;
end;

procedure TVCLZipForm.ZipperFilePercentDone(Sender: TObject;
   Percent: Longint);
begin
   Gauge1.Progress := Percent;
end;

procedure TVCLZipForm.ZipperSkippingFile(Sender: TObject; Reason: TSkipReason; FName: string;
   FileIndex: Integer; var Retry: Boolean );
var
   theReason                  : string;
begin
   if Reason = srBadPassword then
      theReason := 'Bad Password'
   else
      if Reason = srNoOverwrite then
      begin
         if FileIndex = -1 then
            theReason := 'Avoid duplicate entry'
         else
            theReason := 'Avoid Overwrite';
      end
      else
         theReason := 'Error Opening File';

   with Zipper do
      InfoWin.Lines.Add('...Skipping file ' + FName + '. Reason: ' + theReason);
end;

procedure TVCLZipForm.ZipperPromptForOverwrite(Sender: TObject;
   var OverWriteIt: Boolean; FileIndex: Integer; var FName: string);
var
   AllDone                    : Boolean;
begin
   AllDone := True;
   with Zipper do
      repeat
         OverwriteDlg.FName.Caption := FName;
         Screen.Cursor := crDefault;
         OverwriteDlg.ShowModal;
         Screen.Cursor := crHourGlass;
         if OverwriteDlg.Action = oaOverwrite then
            OverwriteIt := True
         else
            if OverwriteDlg.Action = oaSkip then
               OverwriteIt := False;
         if OverwriteDlg.Action = oaRename then
            with RenameDlg do
            begin
               AllDone := False;
               InitialDir := ExtractFilePath(FName);
               FileName := ExtractFilename(FName);
               if RenameDlg.Execute then
               begin
                  FName := FileName;
                  OverWriteIt := True;
                  AllDone := True;
               end;
            end;
      until AllDone;
end;

procedure TVCLZipForm.ZipperBadCRC(Sender: TObject;
   CalcCRC, StoredCRC: LongInt; FileIndex: Integer);
var
   MsgArray                   : array[0..255] of char;
begin
   If Testing then
      InfoWin.Lines.Add('...' + TVCLZip(Sender).Filename[FileIndex] + ' may be corrupt.')
   else with Zipper do
   begin
      StrPCopy(MsgArray, 'Bad CRC for file ' + Filename[FileIndex]);
      Application.MessageBox(MsgArray, 'CRC Error', mb_OK);
      InfoWin.Lines.Add('...Bad CRC for file ' + Filename[FileIndex]);
      InfoWin.Lines.Add('......Stored CRC is     ' + IntToStr(StoredCRC));
      InfoWin.Lines.Add('......Calculated CRC is ' + IntToStr(CalcCRC));
   end;
end;

procedure TVCLZipForm.ZipperTotalPercentDone(Sender: TObject;
   Percent: Longint);
begin
   Gauge2.Progress := Percent;
end;

procedure TVCLZipForm.ZipCommentMnuClick(Sender: TObject);
begin
   if Zipper.ZipName <> '' then
      with CommentEditor do
      begin
         CommentMemo.Clear;
         CommentEditor.Caption := 'Editing Zip Comment for ' + ExtractFilename(Zipper.ZipName);
         if Zipper.ZipHasComment then
            CommentMemo.Text := Zipper.ZipComment;
         ShowModal;
         if ModalResult = mrOK then
            if CommentMemo.Text <> Zipper.ZipComment then
               Zipper.ZipComment := CommentMemo.Text;
      end;
end;

procedure TVCLZipForm.ZipperStartUnzipInfo(Sender: TObject;
   NumFiles: Integer; TotalBytes: Comp; var StopNow: Boolean);
begin
   InfoWin.Lines.Add(' ');
   InfoWin.Lines.Add('Number of files to be unzipped: ' + IntToStr(NumFiles));
   InfoWin.Lines.Add('Total bytes to process: ' + FloatToStr(TotalBytes));
   InfoWin.Lines.Add('Files unzipping to: ' + Zipper.DestDir);
end;

procedure TVCLZipForm.SetLogging;
begin
   with Zipper, ConfigDlg do
   begin
      if OnStartUnZipInfoChk.Checked then
         OnStartUnZipInfo := ZipperStartUnzipInfo
      else
         OnStartUnZipInfo := nil;
      if OnStartUnZipChk.Checked then
         OnStartUnZip := ZipperStartUnZip
      else
         OnStartUnZip := nil;
      if OnBadCRCChk.Checked then
         OnBadCRC := ZipperBadCRC
      else
         OnBadCRC := nil;
      if OnBadPasswordChk.Checked then
         OnBadPassword := ZipperBadPassword
      else
         OnBadPassword := nil;
      if OnSkippingFileChk.Checked then
         OnSkippingFile := ZipperSkippingFile
      else
         OnSkippingFile := nil;
      if OnStartZipInfoChk.Checked then
         OnStartZipInfo := ZipperStartZipInfo
      else
         OnStartZipInfo := nil;
      if OnStartZipChk.Checked then
         OnStartZip := ZipperStartZip
      else
         OnStartZip := nil;
      if OnEndZipChk.Checked then
         OnEndZip := ZipperEndZip
      else
         OnEndZip := nil;
   end;
end;

procedure TVCLZipForm.ZipperGetNextDisk(Sender: TObject;
   NextDisk: Integer; var FName: string);
var
   {$IFDEF WIN32}
   MsgArray                   : array[0..255] of Char;
   {$ELSE}
   MsgArray                   : string;
   {$ENDIF}
begin
   if Zipper.MultiZipInfo.MultiMode = mmSpan then
   begin
      Screen.Cursor := crDefault;
      {$IFDEF WIN32}
      StrPCopy(MsgArray, 'Please insert disk ' + IntToStr(NextDisk) +
         ' of the multi-disk set.');
      {$ELSE}
      MsgArray := 'Please insert disk ' + IntToStr(NextDisk) + ' of the multi-disk set.';
      {$ENDIF}
      if MessageDlg(MsgArray, mtConfirmation, [mbOK, mbCancel], 0) = mrCancel then
         FName := '';
      Screen.Cursor := crHourGlass;
   end
   else
   begin
      FName := ChangeFileExt(FName, '.' + Format('%3.3d', [NextDisk]));
      {$IFDEF SKIPCODE}
      FileSelectDlg.InitialDir := ExtractFilePath(FName);
      FileSelectDlg.Title := 'Select Multi-Part Zip File Number ' + IntToStr(NextDisk);
      FileSelectDlg.Filter := 'Zip Files (*.ZIP)|*.zip' + '|All Files (*.*)|*.*';
      if FileSelectDlg.Execute then
         FName := FileSelectDlg.Filename
      else
         FName := '';
      {$ENDIF}
   end;
end;

procedure TVCLZipForm.FilesList1DrawItem(Control: TWinControl; Index: Integer;
   Rect: TRect; State: TOwnerDrawState);
var
   r                          : TRect;
   x                          : Integer;
   FName                      : string;
   ZipTimeStr                 : string;
   ZipDateStr                 : string;
   zSize, zPacked, zRate      : string;
const
   M                          = 4;                      { Margin }
begin
   if Index > Zipper.Count - 1 then
      exit;
   with (Control as TListBox) do
      with Zipper do
      begin
         r := Rect;

         { Filename }
         FName := Filename[Index];
         if ConfigInfo.LowerCaseFiles then
            FName := LowerCase(FName);
         if IsEncrypted[Index] then
            FName := FName + '#';
         if FileHasComment[Index] then
            FName := FName + '$';
         r.Right := r.Left + Header1.SectionWidth[0];
         x := r.Left + M;
         Canvas.TextRect(r, x, r.Top, FName);

         { Date and Time }
         ZipDateStr := Format('%8s', [FormatDateTime('yyyy/mm/dd', DateTime[Index])]);
         ZipTimeStr := Format('%7s', [FormatDateTime('hh:mmam/pm', DateTime[Index])]);

         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[1];
         x := r.Left + (r.Right - r.Left) - Canvas.TextWidth(ZipDateStr) - M;
         Canvas.TextRect(r, x, r.Top, ZipDateStr);

         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[2];
         x := r.Left + (r.Right - r.Left) - Canvas.TextWidth(ZipTimeStr) - M;
         Canvas.TextRect(r, x, r.Top, ZipTimeStr);

         { Size }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[3];
         zSize := Format('%8d', [UnCompressedSize[Index]]);
         x := r.Left + (r.Right - r.Left) - Canvas.TextWidth(zSize) - M;
         Canvas.TextRect(r, x, r.Top, zSize);

         { Packed }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[4];
         zPacked := Format('%8d', [CompressedSize[Index]]);
         x := r.Left + (r.Right - r.Left) - Canvas.TextWidth(zPacked) - M;
         Canvas.TextRect(r, x, r.Top, zPacked);

         { Rate }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[5];
         zRate := Format('%3d%s', [100 - CRate(UnCompressedSize[Index], CompressedSize[Index]),
            '%']);
         x := r.Left + (r.Right - r.Left) - Canvas.TextWidth(zRate) - M;
         Canvas.TextRect(r, x, r.Top, zRate);

         { Method }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[6];
         x := r.Left + M;
         Canvas.TextRect(r, x, r.Top, CompressMethodStr[Index]);

         { Path }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[7];
         x := r.Left + M;
         Canvas.TextRect(r, x, r.Top, Pathname[Index]);

         { Disk # }
         r.Left := r.Right;
         r.Right := r.Left + Header1.SectionWidth[8];
         x := r.Left + M;
         Canvas.TextRect(r, x, r.Top, IntToStr(DiskNo[Index]));

      end;
end;

procedure TVCLZipForm.FilesList1MeasureItem(Control: TWinControl;
   Index: Integer; var Height: Integer);
begin
   Height := (Control as TListBox).Canvas.TextHeight('W');
end;

procedure TVCLZipForm.ZipperInCompleteZip(Sender: TObject;
   var IncompleteMode: TIncompleteZipMode);
var
   IncZipDlg                  : TIncompleteZipDlg;
   mResult                    : Integer;
begin
   IncZipDlg := TIncompleteZipDlg.Create(Self);
   mResult := IncZipDlg.ShowModal;
   if ( mResult = mrOK) then
      IncompleteMode := izAssumeMulti
   else if (mResult = mrRetry) then
      IncompleteMode := izAssumeBad
   else
      IncompleteMode := izAssumeNotAZip;
   IncZipDlg.Release;
end;

procedure TVCLZipForm.ClearLogWindow1Click(Sender: TObject);
begin
   InfoWin.Clear;
end;

procedure TVCLZipForm.FilesListDblClick(Sender: TObject);
var
   ViewFilePStr               : array[0..PATH_LEN] of char;
   ViewFile                   : string;
   tempPathPStr               : array[0..PATH_LEN] of char;
   tempPath                   : string;
   savePath                   : string;
   saveRecreateDirs           : Boolean;
   ExecStat                   : Integer;
   Msg                        : array[0..255] of char;
begin
   GetTempPath(SizeOf(tempPathPStr), @tempPathPStr[0]);
   tempPath := PCharToStr(tempPathPStr);
   ViewFile := Zipper.Filename[FilesList.ItemIndex];
   StrPCopy(PChar(@ViewFilePStr[0]), ViewFile);
   Zipper.FilesList.Clear;
   Zipper.FilesList.Add(Zipper.Fullname[FilesList.ItemIndex]);
   saveRecreateDirs := Zipper.RecreateDirs;
   Zipper.RecreateDirs := False;
   savePath := Zipper.DestDir;
   Zipper.DestDir := tempPath;
   Zipper.Password := CompressDlg.Password.Text;
   if ViewFilesList.IndexOf(tempPath + ViewFile) = -1 then
      if (Zipper.UnZip > 0) then
         ViewFilesList.Add(tempPath + ViewFile);
   Zipper.DestDir := savePath;
   Zipper.RecreateDirs := saveRecreateDirs;
   if File_Exists(tempPath + ViewFile) then
   begin
      ExecStat := 32;
      if not ConfigInfo.ForceDefaultViewer then
         THandle(ExecStat) := ShellExecute(Handle, nil, ViewFilePStr, nil, tempPathPStr,
            SW_SHOWNORMAL);
      if (ExecStat < 32) or (ConfigInfo.ForceDefaultViewer) then
      begin
         StrPCopy(Msg, ConfigInfo.DefaultViewer + ' ' + tempPath + ViewFile);
         ExecStat := WinExec(Msg, SW_SHOWNORMAL);
      end;
      if ExecStat < 32 then
         ShowMessage('Couldn''t view file');
      Gauge1.Progress := 0;
      Gauge2.Progress := 0;
      CurrentFileLabel.Caption := '';
   end
   else
      ShowMessage('Couldn''t UnZip the file');
   Screen.Cursor := crDefault;
end;

procedure TVCLZipForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
   MsgBoxResult               : WORD;
begin
   if Zipper.IsModified then
   begin
      MsgBoxResult :=
         MessageDlg('This zip file has been modified.  Would you ' + #13 + #10 +
         'like to save your changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      if MsgBoxResult = mrYes then
      begin
         Screen.Cursor := crHourGlass;
         Zipper.SaveModifiedZipFile;
         Screen.Cursor := crDefault;
      end
      else
         if MsgBoxResult = mrCancel then
            Action := caNone;
   end;
   if Action <> caNone then
   begin
      WriteIni;
      CleanupViewList;
      ViewFilesList.Free;
   end;
end;

procedure TVCLZipForm.About1Click(Sender: TObject);
begin
   ShowMessage('KpGb Zip Utility, Based on VCLZip Delphi Component' + #13 + #10 +
      ' Copyright 1997 Kevin L. Boylan, KpGb Software');
end;

procedure TVCLZipForm.NewZipBtnClick(Sender: TObject);
begin
   CompressDlg.SelectedFiles.Clear;
   CompressDlg.ZipFilename.Enabled := True;
   AddFiles;
   OpenTheZip;
end;

procedure TVCLZipForm.UpdateCompressDlg;
begin
   with CompressDlg do
   begin
      {$IFNDEF WIN32}
      SelectFilesBtn.Hint := 'Add files to list for zipping.  You may repeat this.';
      {$ENDIF}
      ZipFilename.Text := Zipper.ZipName;
      RootDir.Text := Zipper.RootDir;
      RelativeDir.Checked := Zipper.RelativePaths;
      RelativeDir.Enabled := (RootDir.Text <> '') and (Zipper.StorePaths);
      RecurseChk.Checked := Zipper.Recurse;
      SaveDirInfoChk.Checked := Zipper.StorePaths;
      SaveVolumesChk.Enabled := Zipper.StorePaths = True;
      SaveVolumesChk.Checked := (SaveVolumesChk.Enabled) and (Zipper.StoreVolumes);
      CompLevel.Caption := IntToStr(Zipper.PackLevel);
      Password.Text := Zipper.Password;
      MultiMode.ItemIndex := Ord(Zipper.MultiZipInfo.Multimode);
      SaveZipInfoChk.Checked := Zipper.MultiZipInfo.SaveZipInfoOnFirstDisk;
      ZipAction.ItemIndex := Ord(Zipper.ZipAction);
      WriteDiskLabelsChk.Checked := Zipper.MultiZipInfo.WriteDiskLabels;
      FirstBlockSize.Text := IntToStr(Zipper.MultiZipInfo.FirstBlockSize);
      BlockSize.Text := IntToStr(Zipper.MultiZipInfo.BlockSize);
   end;
end;

procedure TVCLZipForm.GetCompressDlgInfo;
begin
   with CompressDlg do
   begin
      Zipper.FilesList.Assign(CompressDlg.SelectedFiles.Items);
      Zipper.ZipName := ZipFilename.Text;
      Zipper.RootDir := RootDir.Text;
      Zipper.Recurse := RecurseChk.Checked;
      Zipper.StorePaths := SaveDirInfoChk.Checked;
      Zipper.StoreVolumes := SaveVolumesChk.Checked;
      Zipper.RelativePaths := RelativeDir.Checked;
      Zipper.PackLevel := StrToInt(CompLevel.Caption);
      Zipper.Dispose := DisposeChk.Checked;
      Zipper.Password := Password.Text;
      Zipper.MultiZipInfo.MultiMode := TMultiMode(MultiMode.ItemIndex);
      Zipper.ZipAction := TZipAction(ZipAction.ItemIndex);
      Zipper.MultiZipInfo.WriteDiskLabels := WriteDiskLabelsChk.Checked;
      If Zipper.MultiZipInfo.MultiMode = mmBlocks then
       begin
        Zipper.MultiZipInfo.FirstBlockSize := StrToInt(FirstBlockSize.Text);
        Zipper.MultiZipInfo.BlockSize := StrToInt(BlockSize.Text);
        Zipper.MultiZipInfo.SaveZipInfoOnFirstDisk := SaveZipInfoChk.Checked;
       end
      Else If Zipper.MultiZipInfo.MultiMode = mmSpan then
       begin
        Zipper.MultiZipInfo.SaveOnFirstDisk := StrToInt(FirstBlockSize.Text);
        Zipper.MultiZipInfo.SaveZipInfoOnFirstDisk := SaveZipInfoChk.Checked;
       end;
      Zipper.Store83Names := Store83Format.Checked;
   end;
end;

procedure TVCLZipForm.AddFiles;

   function IsANewZip: Boolean;
   begin
      Result := CompressDlg.ZipFilename.Enabled;
   end;

var
   NumZipped                  : Integer;
begin
   NumZipped := 0;
   Zipper.FilesList.Clear;
   UpdateCompressDlg;
   with CompressDlg do
   begin
      if IsANewZip then
      begin                                             { new zip file }
         GetZipFileDlg.Filename := '';
         if GetZipFileDlg.Execute then
         begin
            ZipFilename.Text := GetZipFileDlg.FileName;
            if UpperCase(ExtractFileExt(ZipFilename.Text)) <> '.ZIP' then
               ChangeFileExt(ZipFilename.Text, '.zip');
         end
         else
            exit;
      end;
   end;
   try
      if (CompressDlg.ShowModal = mrOK) and (CompressDlg.SelectedFiles.Items.Count > 0) then
      begin
         GetCompressDlgInfo;
         Application.ProcessMessages;
         Screen.Cursor := crHourGlass;
         if (IsANewZip) and (FileExists(Zipper.ZipName)) then
            SysUtils.DeleteFile(Zipper.ZipName);
         NumZipped := Zipper.Zip;
         If (Zipper.MultiZipInfo.MultiMode = mmSpan) and (Zipper.MultiZipInfo.SaveZipInfoOnFirstDisk) then
           ShowMessage('Archive Configuration File has been saved');
         MessageBeep(0);
         OpenTheZip;
      end;
   finally
      Screen.Cursor := crDefault;
      Gauge1.Progress := 0;
      Gauge2.Progress := 0;
      CurrentFileLabel.Caption := '';
      if NumZipped > 0 then
         InfoWin.Lines.Add(IntToStr(NumZipped) + ' Files Zipped!')
      else
         InfoWin.Lines.Add('No files were Zipped!');
   end;
end;

procedure TVCLZipForm.OnAddFiles(Sender: TObject);
begin
   if Zipper.ZipName <> '' then
   begin
      CompressDlg.SelectedFiles.Clear;
      CompressDlg.ZipFilename.Enabled := False;
      CompressDlg.ZipFileBtn.Enabled := False;
      AddFiles;
      CompressDlg.ZipFilename.Enabled := True;
      CompressDlg.ZipFileBtn.Enabled := True;
      OpenTheZip;
   end;
end;

procedure TVCLZipForm.DeleteFromZip;
var
  i:    Integer;
begin
   {MakeFilesListFromListBox;}
   Zipper.FilesList.Clear;
   for i := 0 to VCLZipForm.FilesList.Items.Count - 1 do
      if VCLZipForm.FilesList.Selected[i] then
         {Zipper.FilesList.Add(Zipper.FullName[i]);}
        Zipper.Selected[i] := True;
   Zipper.DeleteEntries;
   OpenTheZip;
end;

procedure TVCLZipForm.FormKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if (Key = 46) and (FilesList.SelCount > 0) then
      DeleteFromZip;
end;

procedure TVCLZipForm.UpdateConfigDlg;
begin
   with ConfigInfo, Zipper do
   begin
      ConfigDlg.DefaultViewer.Text := DefaultViewer;
      ConfigDlg.ForceDefaultViewer.Checked := ForceDefaultViewer;
      ConfigDlg.LowerCaseFiles.Checked := LowerCaseFiles;
      ConfigDlg.ProcessMessagesChk.Checked := DoProcessMessages;
      {$IFDEF WIN32}
      ConfigDlg.OnStartUnZipInfoChk.Checked := Assigned(OnStartUnZipInfo);
      ConfigDlg.OnStartUnZipChk.Checked := Assigned(OnStartUnZip);
      ConfigDlg.OnBadCRCChk.Checked := Assigned(OnBadCRC);
      ConfigDlg.OnBadPasswordChk.Checked := Assigned(OnBadPassword);
      ConfigDlg.OnSkippingFileChk.Checked := Assigned(OnSkippingFile);
      ConfigDlg.OnStartZipInfoChk.Checked := Assigned(OnStartUnZipInfo);
      ConfigDlg.OnStartZipChk.Checked := Assigned(OnStartZip);
      ConfigDlg.OnEndZipChk.Checked := Assigned(OnEndZip);
      {$ENDIF}
      ConfigDlg.sfx16.Text := sfx16;
      ConfigDlg.sfx32.Text := sfx32;
   end;
end;

procedure TVCLZipForm.GetConfigDlgInfo;
begin
   with ConfigInfo do
   begin
      DefaultViewer := ConfigDlg.DefaultViewer.Text;
      ForceDefaultViewer := ConfigDlg.ForceDefaultViewer.Checked;
      LowerCaseFiles := ConfigDlg.LowerCaseFiles.Checked;
      Zipper.DoProcessMessages := ConfigDlg.ProcessMessagesChk.Checked;
      sfx16 := ConfigDlg.sfx16.Text;
      sfx32 := ConfigDlg.sfx32.Text;
      SetLogging;
   end;
end;

procedure TVCLZipForm.Configure1Click(Sender: TObject);
begin
   UpdateConfigDlg;
   ConfigDlg.ShowModal;
   if ConfigDlg.ModalResult = mrOK then
      GetConfigDlgInfo;
end;

procedure TVCLZipForm.ZipperStartZip(Sender: TObject; FName: string;
   var ZipHeader: TZipHeaderInfo; var Skip: Boolean);
begin
   InfoWin.Lines.Add('Zipping ' + FName);
   CurrentFileLabel.Caption := ExtractFilename(FName);
   CurrentFileLabel.Repaint;
end;



procedure TVCLZipForm.DeleteBtnClick(Sender: TObject);
begin
   if FilesList.SelCount > 0 then
      DeleteFromZip;
end;

procedure TVCLZipForm.AbortBtnClick(Sender: TObject);
begin
   MessageBeep(0);
   Zipper.CancelTheOperation;
end;

procedure TVCLZipForm.BackupBtnClick(Sender: TObject);
var
   tmpFilesList               : TStrings;
   i                          : Integer;
begin
   if Zipper.Count > 0 then
   begin
      tmpFilesList := TStringList.Create;
      try
         for i := 0 to Zipper.Count - 1 do
            if Pos(':', Zipper.Pathname[i]) > 0 then
               tmpFilesList.Add(Zipper.FullName[i]);
         if tmpFilesList.Count > 0 then
         begin
            if tmpFilesList.Count < Zipper.Count then
               if (MessageDlg('There are some entries that do not have'
                  + #13 + #10 + 'volume information.  These files will not be '
                  + #13 + #10 + 'backed up.', mtWarning, [mbOK, mbCancel], 0)
                  = mrCancel) then exit;

            Zipper.StorePaths := True;
            Zipper.StoreVolumes := True;
            Zipper.PackLevel := 9;
            CompressDlg.SelectedFiles.Items.Assign(tmpFilesList);
            CompressDlg.ZipFilename.Enabled := True;
            AddFiles;
         end
         else
            MessageDlg('None of this zips entries have volume information.'
               + #13 + #10 + 'Volume information is required for backups.', mtWarning, [mbOK],
                  0);
      finally
         tmpFilesList.Free;
      end;
   end;
end;

procedure TVCLZipForm.SaveMenuItemClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   Zipper.SaveModifiedZipFile;
   OpenTheZip;
   Screen.Cursor := crDefault;
end;

procedure TVCLZipForm.FileCommentBtnClick(Sender: TObject);
var
   Idx                        : Integer;
begin
   if FilesList.SelCount > 1 then
      ShowMessage('You must select only one entry.')
   else
      if FilesList.SelCount = 0 then
         ShowMessage('Please select an entry first.')
      else
      begin
         with CommentEditor do
         begin
            Idx := FilesList.ItemIndex;
            CommentMemo.Clear;
            CommentEditor.Caption := 'Editing Zip Comment for ' + Zipper.Filename[Idx];
            if Zipper.FileHasComment[Idx] then
               CommentMemo.Text := Zipper.FileComment[Idx];
            ShowModal;
            if ModalResult = mrOK then
               if CommentMemo.Text <> Zipper.FileComment[Idx] then
                  Zipper.FileComment[Idx] := CommentMemo.Text;
         end;
      end;
end;

procedure TVCLZipForm.FileMenuClick(Sender: TObject);
begin
   SaveMenuItem.Enabled := Zipper.IsModified;
   SFXToZipMnu.Enabled := (Zipper.ZipName <> '') and
      (LowerCase(ExtractFileExt(Zipper.ZipName)) = '.exe');
end;

procedure TVCLZipForm.FixMenuClick(Sender: TObject);
begin
   Zipper.FixZip('', '');
   OpenTheZip;
end;

procedure TVCLZipForm.MakeSFX32MnuClick(Sender: TObject);
begin
   MakeSFX(sfx32);
   MessageBeep(0);
   OpenTheZip;
end;

procedure TVCLZipForm.MakeSFX(Stub: string);
begin
   if Zipper.ZipName = '' then
   begin
      ShowMessage('No zip to process');
      exit;
   end;
   Zipper.FilesList.Clear;
   Screen.Cursor := crHourGlass;
   try
      Zipper.MakeSFX(Stub, False);
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TVCLZipForm.Make16bitSFXMnuClick(Sender: TObject);
begin
   MakeSFX(sfx16);
   MessageBeep(0);
   OpenTheZip;
end;

procedure TVCLZipForm.ZipperEndZip(Sender: TObject; FName: string;
   UncompressedSize, CompressedSize, CurrentZipSize: LongInt);
begin
   InfoWin.Lines.Add(' ' + ExtractFilename(FName) + ' zipped. ' + IntToStr(UnCompressedSize) +
      ' ' + IntToStr(CompressedSize) + ' ' +
      IntToStr(100-crate(UncompressedSize, CompressedSize)) + '%');
   ZipSizeLabel.Caption := IntToStr(CurrentZipSize);
end;

procedure TVCLZipForm.ZipperStartZipInfo(Sender: TObject;
   NumFiles: Integer; TotalBytes: Comp; var EndCentralRecord: TEndCentral; var StopNow:
      Boolean);
begin
   InfoWin.Lines.Add(' ');
   InfoWin.Lines.Add('Number of files to be zipped: ' + IntToStr(NumFiles));
   InfoWin.Lines.Add('Total bytes to process: ' + FloatToStr(TotalBytes));
end;

procedure TVCLZipForm.ZipperDeleteEntry(Sender: TObject; FName: string;
   var Skip: Boolean);
begin
   if MessageDlg('Delete File ' + FName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      InfoWin.Lines.Add('Deleting entry for ' + FName)
   else
      Skip := True;
end;

procedure TVCLZipForm.ZipperDisposeFile(Sender: TObject; FName: string;
   var Skip: Boolean);
begin
   InfoWin.Lines.Add('Removing: ' + FName);
end;

procedure TVCLZipForm.ModifyPathClick(Sender: TObject);
var
   i                          : Integer;
begin
   if FilesList.SelCount > 0 then
   begin
      ModInfoForm.NewInfoEdit.Text := '';
      ModInfoForm.ShowModal;
      if ModInfoForm.ModalResult = mrOK then
         for i := 0 to VCLZipForm.FilesList.Items.Count - 1 do
            if VCLZipForm.FilesList.Selected[i] then
               Zipper.Pathname[i] := ModInfoForm.NewInfoEdit.Text;
      SaveMenuItemClick(Self);
   end;
end;

procedure TVCLZipForm.ModifyFilename1Click(Sender: TObject);
begin
   if FilesList.SelCount = 1 then
   begin
      ModInfoForm.NewInfoEdit.Text := Zipper.Filename[FilesList.ItemIndex];
      ModInfoForm.ShowModal;
      if ModInfoForm.ModalResult = mrOK then
         Zipper.Filename[FilesList.ItemIndex] := ModInfoForm.NewInfoEdit.Text;
   end;
end;

procedure TVCLZipForm.TestZipFile1Click(Sender: TObject);
var
   tmpZipper                  : TVCLUnZip;
begin
   { A separate VCLZip object is used to test the integrity of the zip file so that we can
     have control over the events that get called }
   Testing := True;
   tmpZipper := TVCLUnZip.Create(Application);
   tmpZipper.ZipName := Zipper.ZipName;
   tmpZipper.Password := Zipper.Password;
   tmpZipper.OnFilePercentDone := Zipper.OnFilePercentDone;
   tmpZipper.OnTotalPercentDone := Zipper.OnTotalPercentDone;
   tmpZipper.OnBadCRC := Zipper.OnBadCRC;
   tmpZipper.OnBadPassword := Zipper.OnBadPassword;
   tmpZipper.OnStartUnZip := Zipper.OnStartUnZip;
   tmpZipper.ReadZip;
   InfoWin.Lines.Add('Beginning integrity test for ' + IntToStr(Zipper.Count) + ' files for ' +
      tmpZipper.ZipName);
   if (tmpZipper.CheckArchive) then
     InfoWin.Lines.Add('All Files OK')
   else
     InfoWin.Lines.Add('File(s) may be corrupted');
   tmpZipper.Free;
   Gauge1.Progress := 0;
   Gauge2.Progress := 0;
   Testing := False;
end;

procedure TVCLZipForm.SFXtoZipMnuClick(Sender: TObject);
begin
   if (Zipper.ZipName <> '') and (Zipper.Count > 0) then
      Zipper.SFXToZip(True);
   SFXToZipMnu.Enabled := False;
   Caption := Zipper.ZipName;
end;

procedure TVCLZipForm.ZipperUnZipComplete(sender: TObject;
   FileCount: Integer);
begin
   {ShowMessage('Got Here');}
end;

procedure TVCLZipForm.ZipperUpdate(Sender: TObject;
  UDAction: TUpdateAction; FileIndex: Integer);
begin
  Case UDAction of
     uaReplacing: InfoWin.Lines.Add( 'Replacing ' + TVCLZip(Sender).FullName[FileIndex] );
     uaKeeping:   InfoWin.Lines.Add( 'Keeping ' + TVCLZip(Sender).FullName[FileIndex]   );
  end;
end;

end.

