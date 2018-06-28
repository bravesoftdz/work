unit UDSummaryInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSummaryInfoDlg = class(TForm)
    pnlSummaryInfo: TPanel;
    lblApplication: TLabel;
    lblAuthor: TLabel;
    lblKeywords: TLabel;
    lblComments: TLabel;
    lblSubject: TLabel;
    lblTitle: TLabel;
    lblTemplate: TLabel;
    lblAppName: TLabel;
    editAuthor: TEdit;
    editKeywords: TEdit;
    memoComments: TMemo;
    editTitle: TEdit;
    editSubject: TEdit;
    editTemplate: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    cbSavePreviewPicture: TCheckBox;
    procedure UpdateSummaryInfo;
    procedure btnOkClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr        : TCrpe;
    rAppName  : string;
    rAuthor   : string;
    rComments : TStringList;
    rKeywords : string;
    rTemplate : string;
    rSubject  : string;
    rTitle    : string;
    bSavePP   : boolean;
  end;

var
  CrpeSummaryInfoDlg: TCrpeSummaryInfoDlg;
  bSummaryInfo      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.FormCreate(Sender: TObject);
begin
  bSummaryInfo := True;
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.FormShow(Sender: TObject);
begin
  {Store current VCL settings}
  rAppName  := Cr.SummaryInfo.AppName;
  rAuthor   := Cr.SummaryInfo.Author;
  rComments := TStringList.Create;
  rComments.Assign(Cr.SummaryInfo.Comments);
  rKeywords := Cr.SummaryInfo.Keywords;
  rTemplate := Cr.SummaryInfo.Template;
  rSubject  := Cr.SummaryInfo.Subject;
  rTitle    := Cr.SummaryInfo.Title;
  bSavePP   := Cr.SummaryInfo.SavePreviewPicture;
  cbSavePreviewPicture.Enabled := (Cr.Version.Crpe.Major > 7);
  UpdateSummaryInfo;
end;
{------------------------------------------------------------------------------}
{ UpdateSummaryInfo                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.UpdateSummaryInfo;
var
  OnOff : Boolean;
begin
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    lblAppName.Caption := Cr.SummaryInfo.AppName;
    editAuthor.Text := Cr.SummaryInfo.Author;
    memoComments.Lines.Assign(Cr.SummaryInfo.Comments);
    editKeywords.Text := Cr.SummaryInfo.Keywords;
    editTemplate.Text := Cr.SummaryInfo.Template;
    editSubject.Text := Cr.SummaryInfo.Subject;
    editTitle.Text := Cr.SummaryInfo.Title;
    cbSavePreviewPicture.Checked := Cr.SummaryInfo.SavePreviewPicture;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
      end;
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
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.btnClearClick(Sender: TObject);
begin
  Cr.SummaryInfo.Clear;
  UpdateSummaryInfo;
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.btnOKClick(Sender: TObject);
begin
  Cr.SummaryInfo.Author := editAuthor.Text;
  Cr.SummaryInfo.Keywords := editKeywords.Text;
  Cr.SummaryInfo.Template := editTemplate.Text;
  Cr.SummaryInfo.Subject := editSubject.Text;
  Cr.SummaryInfo.Title := editTitle.Text;
  Cr.SummaryInfo.Comments := TStringList(memoComments.Lines);
  Cr.SummaryInfo.SavePreviewPicture := cbSavePreviewPicture.Checked;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    {Cr.SummaryInfo.AppName := rAppName;} {read only}
    Cr.SummaryInfo.Author := rAuthor;
    Cr.SummaryInfo.Comments.Assign(rComments);
    Cr.SummaryInfo.Keywords := rKeywords;
    Cr.SummaryInfo.Template := rTemplate;
    Cr.SummaryInfo.Subject := rSubject;
    Cr.SummaryInfo.Title := rTitle;
    Cr.SummaryInfo.SavePreviewPicture := bSavePP;
  end;
  rComments.Free;
  bSummaryInfo := False;
  Release;
end;


end.
