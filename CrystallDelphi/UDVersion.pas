unit UDVersion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32, ComCtrls;

type
  TCrpeVersionDlg = class(TForm)
    btnOk: TButton;
    pnlVersion: TPanel;
    gbCrpe: TGroupBox;
    lblDLL: TLabel;
    lblEngine: TLabel;
    lblFileVersion: TLabel;
    lblMajor: TLabel;
    lblMid: TLabel;
    lblMinor: TLabel;
    editDLL: TEdit;
    editEngine: TEdit;
    editFileVersion: TEdit;
    editMajor: TEdit;
    editMinor: TEdit;
    editRelease: TEdit;
    gbReport: TGroupBox;
    lblRMajor: TLabel;
    lblRMinor: TLabel;
    lblLetter: TLabel;
    editRMajor: TEdit;
    editRMinor: TEdit;
    editLetter: TEdit;
    gbWindows: TGroupBox;
    lblPlatform: TLabel;
    lblWMajor: TLabel;
    lblWMinor: TLabel;
    lblWBuild: TLabel;
    editPlatform: TEdit;
    editWMajor: TEdit;
    editWMinor: TEdit;
    editWBuild: TEdit;
    lblBuild: TLabel;
    editBuild: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateVersion;
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeVersionDlg: TCrpeVersionDlg;
  bVersion      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.FormCreate(Sender: TObject);
begin
  bVersion := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.FormShow(Sender: TObject);
begin
  UpdateVersion;
end;
{------------------------------------------------------------------------------}
{ UpdateVersion                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.UpdateVersion;
var
  OnOff : Boolean;
begin
  OnOff := Cr.OpenEngine;
  InitializeControls(OnOff);

  if OnOff then
  begin
    {Crpe}
    editDLL.Text := Cr.Version.Crpe.DLL;
    editEngine.Text := Cr.Version.Crpe.Engine;
    editFileVersion.Text := Cr.Version.Crpe.FileVersion;
    editMajor.Text := IntToStr(Cr.Version.Crpe.Major);
    editMinor.Text := IntToStr(Cr.Version.Crpe.Minor);
    editRelease.Text := IntToStr(Cr.Version.Crpe.Release);
    editBuild.Text := IntToStr(Cr.Version.Crpe.Build);
    {Report}
    editRMajor.Text := IntToStr(Cr.Version.Report.Major);
    editRMinor.Text := IntToStr(Cr.Version.Report.Minor);
    editLetter.Text := Cr.Version.Report.Letter;
    {Windows}
    editPlatform.Text := Cr.Version.Windows.Platform;
    editWMajor.Text := IntToStr(Cr.Version.Windows.Major);
    editWMinor.Text := IntToStr(Cr.Version.Windows.Minor);
    editWBuild.Text := Cr.Version.Windows.Build;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeVersionDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bVersion := False;
  Release;
end;


end.
