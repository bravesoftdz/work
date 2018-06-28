{  Sun 29 Mar 1998   10:49:13  Supervisor    Version: 2.1
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
{ Tue 24 Mar 1998   19:03:55  Supervisor
{ Modifications to allow storing filenames and paths in DOS 
{ 8.3 format
}
{
{ Wed 11 Mar 1998   20:58:48  Supervisor    Version: 2.03
{ Version 2.03, Fixed several bugs.
}

program zipp;

uses
  Forms,
  zip in '..\zip.pas' {VCLZipForm},
  IncZip in '..\IncZip.pas' {IncompleteZipDlg},
  Ovrwrite in '..\ovrwrite.pas' {OverwriteDlg},
  Extract in '..\Extract.pas' {ExtractDlg},
  Compress in '..\Compress.pas' {CompressDlg},
  Config in '..\Config.Pas' {ConfigDlg},
  Comment in '..\Comment.Pas' {CommentEditor},
  ModInfo in '..\ModInfo.pas' {ModInfoForm},
  InvPwd in '..\InvPwd.pas' {InvalidPwdDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'VCLZip Zip Utility';
  Application.CreateForm(TVCLZipForm, VCLZipForm);
  Application.CreateForm(TOverwriteDlg, OverwriteDlg);
  Application.CreateForm(TExtractDlg, ExtractDlg);
  Application.CreateForm(TCompressDlg, CompressDlg);
  Application.CreateForm(TConfigDlg, ConfigDlg);
  Application.CreateForm(TCommentEditor, CommentEditor);
  Application.CreateForm(TModInfoForm, ModInfoForm);
  Application.CreateForm(TInvalidPwdDlg, InvalidPwdDlg);
  Application.Run;
end.
