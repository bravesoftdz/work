unit UDAbout;

{$I UCRPEDEF.INC}

interface

uses
  Windows, Classes, Forms, Controls, StdCtrls, ExtCtrls, Graphics;

type
{------------------------------------------------------------------------------}
{ Class TCrpeAboutBox                                                          }
{------------------------------------------------------------------------------}
  TCrpeAboutBox = class(TForm)
    pnlAbout: TPanel;
    lblCrystal: TLabel;
    lblFor: TLabel;
    lblVersion: TLabel;
    lblCopyright: TLabel;
    pnlInformation: TPanel;
    lblCompany: TLabel;
    lblAddress1: TLabel;
    lblAddress2: TLabel;
    lblVCLSales: TLabel;
    ProgramIcon: TImage;
    lblVCLWebSitePre: TLabel;
    lblVCLWebSite: TLabel;
    lblVCLEmailPre: TLabel;
    lblVCLEmail: TLabel;
    lblCRTechnicalSupport: TLabel;
    lblCRPhonePre: TLabel;
    lblCRPhone: TLabel;
    lblCREmailPre: TLabel;
    lblCREmail: TLabel;
    lblCRWebSitePre: TLabel;
    lblCRWebSite: TLabel;
    lblReports: TLabel;
    lblLanguage: TLabel;
    procedure pnlAboutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblCREmailMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblVCLWebSiteMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCRWebSiteMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlInformationMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblCREmailClick(Sender: TObject);
    procedure lblVCLWebSiteClick(Sender: TObject);
    procedure lblCRWebSiteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblVCLEmailClick(Sender: TObject);
    procedure lblVCLEmailMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    bVis : boolean;
  end;

var
  CrpeAboutBox: TCrpeAboutBox;

implementation

{$R *.DFM}

uses SysUtils, ShellApi, UCrpe32;

{******************************************************************************}
{ Class TCrpeAboutBox                                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.FormShow(Sender: TObject);
begin
end;
{------------------------------------------------------------------------------}
{ lblVCLEmailAddressClick                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblVCLEmailClick(Sender: TObject);
var
  sTmp: string;
  pTmp: PChar;
begin
  pTmp := nil;
  sTmp := 'mailto:' + TCRPE_VCL_EMAIL;
  try
    pTmp := StrAlloc(Length(sTmp) + 1);
    StrPCopy(pTmp, sTmp);
    ShellExecute(0, 'open', pTmp, nil, nil, SW_SHOWNORMAL);
    StrDispose(pTmp);
  except
    if pTmp <> nil then
      StrDispose(pTmp);
  end;
end;
{------------------------------------------------------------------------------}
{ lblVCLEmailAddressMouseMove                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblVCLEmailMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblVCLEmail.Font.Style := [fsUnderline];
  lblVCLEmail.Font.Color := clBlue;
  lblVCLWebSite.Font.Style := [];
  lblVCLWebSite.Font.Color := clBlack;
  lblCREmail.Font.Style := [];
  lblCREmail.Font.Color := clBlack;
  lblCRWebSite.Font.Style := [];
  lblCRWebSite.Font.Color := clBlack;
end;
{------------------------------------------------------------------------------}
{ lblVCLWebAddressClick                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblVCLWebSiteClick(Sender: TObject);
var
  sTmp: string;
  pTmp: PChar;
begin
  pTmp := nil;
  sTmp := TCRPE_VCL_WEBSITE;
  try
    pTmp := StrAlloc(Length(sTmp) + 1);
    StrPCopy(pTmp, sTmp);
    ShellExecute(0, 'open', pTmp, nil, nil, SW_SHOWNORMAL);
    StrDispose(pTmp);
  except
    if pTmp <> nil then
      StrDispose(pTmp);
  end;
end;
{------------------------------------------------------------------------------}
{ lblVCLWebAddressMouseMove                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblVCLWebSiteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblVCLEmail.Font.Style := [];
  lblVCLEmail.Font.Color := clBlack;
  lblVCLWebSite.Font.Style := [fsUnderline];
  lblVCLWebSite.Font.Color := clBlue;
  lblCREmail.Font.Style := [];
  lblCREmail.Font.Color := clBlack;
  lblCRWebSite.Font.Style := [];
  lblCRWebSite.Font.Color := clBlack;
end;
{------------------------------------------------------------------------------}
{ lblCREmailAddressClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblCREmailClick(Sender: TObject);
var
  sTmp: string;
  pTmp: PChar;
begin
  pTmp := nil;
  sTmp := TCRPE_CR_EMAIL;
  try
    pTmp := StrAlloc(Length(sTmp) + 1);
    StrPCopy(pTmp, sTmp);
    ShellExecute(0, 'open', pTmp, nil, nil, SW_SHOWNORMAL);
    StrDispose(pTmp);
  except
    if pTmp <> nil then
      StrDispose(pTmp);
  end;
end;
{------------------------------------------------------------------------------}
{ lblCREmailAddressMouseMove                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblCREmailMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblVCLEmail.Font.Style := [];
  lblVCLEmail.Font.Color := clBlack;
  lblVCLWebSite.Font.Style := [];
  lblVCLWebSite.Font.Color := clBlack;
  lblCREmail.Font.Style := [fsUnderline];
  lblCREmail.Font.Color := clBlue;
  lblCRWebSite.Font.Style := [];
  lblCRWebSite.Font.Color := clBlack;
end;
{------------------------------------------------------------------------------}
{ lblCRWebSiteAddressClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblCRWebSiteClick(Sender: TObject);
var
  sTmp: string;
  pTmp: PChar;
begin
  pTmp := nil;
  sTmp := TCRPE_CR_WEBSITE;
  try
    pTmp := StrAlloc(Length(sTmp) + 1);
    StrPCopy(pTmp, sTmp);
    ShellExecute(0, 'open', pTmp, nil, nil, SW_SHOWNORMAL);
    StrDispose(pTmp);
  except
    if pTmp <> nil then
      StrDispose(pTmp);
  end;
end;
{------------------------------------------------------------------------------}
{ lblCRWebSiteAddressMouseMove                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.lblCRWebSiteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblVCLEmail.Font.Style := [];
  lblVCLEmail.Font.Color := clBlack;
  lblVCLWebSite.Font.Style := [];
  lblVCLWebSite.Font.Color := clBlack;
  lblCREmail.Font.Style := [];
  lblCREmail.Font.Color := clBlack;
  lblCRWebSite.Font.Style := [fsUnderline];
  lblCRWebSite.Font.Color := clBlue;
end;
{------------------------------------------------------------------------------}
{ pnlInformationMouseMove                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.pnlInformationMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lblVCLEmail.Font.Style := [];
  lblVCLEmail.Font.Color := clBlack;
  lblVCLWebSite.Font.Style := [];
  lblVCLWebSite.Font.Color := clBlack;
  lblCREmail.Font.Style := [];
  lblCREmail.Font.Color := clBlack;
  lblCRWebSite.Font.Style := [];
  lblCRWebSite.Font.Color := clBlack;
end;
{------------------------------------------------------------------------------}
{ pnlAboutClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.pnlAboutClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeAboutBox.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
