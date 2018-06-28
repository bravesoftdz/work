unit UDGlobalOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeGlobalOptionsDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    pnlGlobalOptions: TPanel;
    lblMorePrintEngineErrorMessages: TLabel;
    lblMatchLogOnInfo: TLabel;
    lblDisableThumbnailUpdates: TLabel;
    lblUse70TextCompatibility: TLabel;
    cbMorePrintEngineErrorMessages: TComboBox;
    cbMatchLogOnInfo: TComboBox;
    cbUse70TextCompatibility: TComboBox;
    cbDisableThumbnailUpdates: TComboBox;
    cbVerifyWhenDatabaseDriverUpgraded: TComboBox;
    lblVerifyWhenDatabaseDriverUpgraded: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateGlobalOptions;
    procedure btnClearClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeGlobalOptionsDlg : TCrpeGlobalOptionsDlg;
  bGlobalOptions       : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.FormCreate(Sender: TObject);
begin
  bGlobalOptions := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
  btnClear.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.FormShow(Sender: TObject);
begin
  UpdateGlobalOptions;
end;
{------------------------------------------------------------------------------}
{ UpdateGlobalOptions procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.UpdateGlobalOptions;
var
  OnOff : Boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    cbMorePrintEngineErrorMessages.ItemIndex := Ord(Cr.GlobalOptions.MorePrintEngineErrorMessages);
    cbMatchLogOnInfo.ItemIndex := Ord(Cr.GlobalOptions.MatchLogOnInfo);
    cbUse70TextCompatibility.ItemIndex := Ord(Cr.GlobalOptions.Use70TextCompatibility);
    cbDisableThumbnailUpdates.ItemIndex := Ord(Cr.GlobalOptions.DisableThumbnailUpdates);
    cbVerifyWhenDatabaseDriverUpgraded.ItemIndex := Ord(Cr.GlobalOptions.VerifyWhenDatabaseDriverUpgraded);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
        TComboBox(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.btnClearClick(Sender: TObject);
begin
  Cr.GlobalOptions.Clear;
  UpdateGlobalOptions;
end;
{------------------------------------------------------------------------------}
{ btnOKClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.GlobalOptions.MorePrintEngineErrorMessages := TCrBoolean(cbMorePrintEngineErrorMessages.ItemIndex);
  Cr.GlobalOptions.MatchLogOnInfo := TCrBoolean(cbMatchLogOnInfo.ItemIndex);
  Cr.GlobalOptions.Use70TextCompatibility := TCrBoolean(cbUse70TextCompatibility.ItemIndex);
  Cr.GlobalOptions.DisableThumbnailUpdates := TCrBoolean(cbDisableThumbnailUpdates.ItemIndex);
  Cr.GlobalOptions.VerifyWhenDatabaseDriverUpgraded := TCrBoolean(cbVerifyWhenDatabaseDriverUpgraded.ItemIndex);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeGlobalOptionsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bGlobalOptions := False;
  Release;
end;


end.
