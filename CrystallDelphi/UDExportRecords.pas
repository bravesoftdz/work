unit UDExportRecords;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  ExtCtrls, UCrpe32;

type
  TCrpeExportRecordsDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlRecords: TPanel;
    cbUseRptNumberFmt: TCheckBox;
    cbUseRptDateFmt: TCheckBox;
    rgRecordsType: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeExportRecordsDlg: TCrpeExportRecordsDlg;

implementation

{$R *.dfm}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportRecordsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeExportRecordsDlg.FormShow(Sender: TObject);
begin
  rgRecordsType.ItemIndex := Ord(Cr.ExportOptions.Text.RecordsType);
  cbUseRptNumberFmt.Checked := Cr.ExportOptions.Text.UseRptNumberFmt;
  cbUseRptDateFmt.Checked := Cr.ExportOptions.Text.UseRptDateFmt;
end;
{------------------------------------------------------------------------------}
{ btnOKClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportRecordsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.Text.RecordsType := TCrRecordsType(rgRecordsType.ItemIndex);
  Cr.ExportOptions.Text.UseRptNumberFmt := cbUseRptNumberFmt.Checked;
  Cr.ExportOptions.Text.UseRptDateFmt := cbUseRptDateFmt.Checked;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeExportRecordsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeExportRecordsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
