{ ********************************************************************************************************* }
{                                                                                                           }
{ 	 COPYRIGHT 1995 Kevin Boylan                                                                           }
{     Source File: Extract.PAS  - For VCLZip                                                                }
{     Description: Extract Form for the VCLZip Example Program                                              }
{     Date:        Wed Nov 8 1995                                                                           }
{     Author:      Kevin Boylan, boylank@bigfoot.com                                                        }
{                                                                                                           }
{                                                                                                           }
{ ********************************************************************************************************* }

unit Extract;

{ $Log: }

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
  Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, FileCtrl;

type
  TExtractDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    SelectedFiles: TRadioButton;
    UseMask: TRadioButton;
    ExtractMask: TEdit;
    Destination: TGroupBox;
    DestDir: TEdit;
    DirBtn: TBitBtn;
    GroupBox2: TGroupBox;
    Overwrite: TComboBox;
    Password: TEdit;
    RecreateDir: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    AllFilesRBtn: TRadioButton;
    RetainAttributesChk: TCheckBox;
    RelDir: TEdit;
    Label3: TLabel;
    procedure DirBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExtractDlg: TExtractDlg;

implementation

{$R *.DFM}

procedure TExtractDlg.DirBtnClick(Sender: TObject);
var
  tmpDir: String;
begin
  tmpDir := DestDir.Text;
  If SelectDirectory(tmpDir, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
     DestDir.Text := tmpDir;
end;






end.
