unit Config;

{ $Log: }


interface

uses
{$IFDEF WIN32}
	Windows, ComCtrls,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
	SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
	Buttons, ExtCtrls, Tabnotbk, Dialogs;

type
  TConfigDlg = class(TForm)
    Options: TTabbedNotebook;
    OnStartUnZipInfoChk: TCheckBox;
    OnStartUnZipChk: TCheckBox;
    OnBadCRCChk: TCheckBox;
    OnBadPasswordChk: TCheckBox;
    OnSkippingFileChk: TCheckBox;
    Label5: TLabel;
    DefaultViewer: TEdit;
    ForceDefaultViewer: TCheckBox;
    LowerCaseFiles: TCheckBox;
    DirBtn: TBitBtn;
    OKBtn: TButton;
    CancelBtn: TButton;
    GetViewerDlg: TOpenDialog;
    ProcessMessagesChk: TCheckBox;
    OnStartZipInfoChk: TCheckBox;
    OnStartZipChk: TCheckBox;
    OnEndZipChk: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    sfx16: TEdit;
    sfx16dirbtn: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    sfx32: TEdit;
    sfx32dirbtn: TBitBtn;
    procedure DirBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigDlg: TConfigDlg;

implementation

{$R *.DFM}

procedure TConfigDlg.DirBtnClick(Sender: TObject);
begin
  If TBitBtn(Sender).Name = 'DirBtn' then
     GetViewerDlg.InitialDir := ExtractFilePath(DefaultViewer.Text)
  Else If TBitBtn(Sender).Name = 'sfx16dirbtn' then
     GetViewerDlg.InitialDir := ExtractFilePath(sfx16.Text)
  Else If TBitBtn(Sender).Name = 'sfx32dirbtn' then
     GetViewerDlg.InitialDir := ExtractFilePath(sfx32.Text);

  If GetViewerDlg.Execute then
   begin
     If TBitBtn(Sender).Name = 'DirBtn' then
        DefaultViewer.Text := GetViewerDlg.Filename
     Else If TBitBtn(Sender).Name = 'sfx16dirbtn' then
        sfx16.Text := GetViewerDlg.Filename
     Else If TBitBtn(Sender).Name = 'sfx32dirbtn' then
        sfx32.Text := GetViewerDlg.Filename;
   end;
end;

procedure TConfigDlg.Button1Click(Sender: TObject);
begin
  OnStartUnZipInfoChk.Checked := True;
  OnStartUnZipChk.Checked := True;
  OnBadCRCChk.Checked := True;
  OnBadPasswordChk.Checked := True;
  OnSkippingFileChk.Checked := True;
  OnStartZipInfoChk.Checked := True;
  OnStartZipChk.Checked := True;
  OnEndZipChk.Checked := True;
end;

procedure TConfigDlg.Button2Click(Sender: TObject);
begin
  OnStartUnZipInfoChk.Checked := False;
  OnStartUnZipChk.Checked := False;
  OnBadCRCChk.Checked := False;
  OnBadPasswordChk.Checked := False;
  OnSkippingFileChk.Checked := False;
  OnStartZipInfoChk.Checked := False;
  OnStartZipChk.Checked := False;
  OnEndZipChk.Checked := False;
end;







end.
