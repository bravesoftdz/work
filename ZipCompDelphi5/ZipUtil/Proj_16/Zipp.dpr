program zipp;

uses
  Forms,
  zip in '..\ZIP.PAS' {VCLZipForm},
  IncZip in '..\INCZIP.PAS' {IncompleteZipDlg},
  Ovrwrite in '..\OVRWRITE.PAS' {OverwriteDlg},
  Extract in '..\EXTRACT.PAS' {ExtractDlg},
  Compress in '..\COMPRESS.PAS' {CompressDlg},
  Config in '..\CONFIG.PAS' {ConfigDlg},
  Comment in '..\COMMENT.PAS' {CommentEditor},
  ModInfo in '..\MODINFO.PAS' {ModInfoForm},
  InvPwd in '..\INVPWD.PAS' {InvalidPwdDlg};

{$R *.RES}

begin
	{$IFDEF WIN32}
	Application.Initialize;
	{$ENDIF}
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
