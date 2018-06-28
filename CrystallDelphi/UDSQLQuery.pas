unit UDSQLQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSQLQueryDlg = class(TForm)
    pnlSQLQuery: TPanel;
    lblSQLQuery: TLabel;
    memoSQL: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
    btnConnect: TButton;
    btnClear: TButton;
    btnRetrieve: TButton;
    procedure memoSQLChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateQuery;
    procedure btnConnectClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure btnClearClick(Sender: TObject);
    procedure btnRetrieveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr     : TCrpe;
    rQuery : TStringList;
  end;

var
  CrpeSQLQueryDlg: TCrpeSQLQueryDlg;
  bSQLQuery      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDConnect;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.FormCreate(Sender: TObject);
begin
  bSQLQuery := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.FormShow(Sender: TObject);
begin
  rQuery := TStringList.Create;
  rQuery.Assign(Cr.SQL.Query);
  UpdateQuery;
end;
{------------------------------------------------------------------------------}
{ UpdateQuery                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.UpdateQuery;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    memoSQL.OnChange := nil;
    memoSQL.Lines.Assign(Cr.SQL.Query);
    memoSQL.OnChange := memoSQLChange;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ memoSQLChange                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.memoSQLChange(Sender: TObject);
begin
  Cr.SQL.Query.Assign(memoSQL.Lines);
end;
{------------------------------------------------------------------------------}
{ btnConnectClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.btnConnectClick(Sender: TObject);
begin
  CrpeConnectDlg := TCrpeConnectDlg.Create(Application);
  CrpeConnectDlg.Cr := Cr;
  CrpeConnectDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnRetrieveClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.btnRetrieveClick(Sender: TObject);
begin
  Cr.SQL.Retrieve;
  UpdateQuery;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.btnClearClick(Sender: TObject);
begin
  Cr.SQL.Clear;
  UpdateQuery;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSQLQueryDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {Restore Settings}
  if ModalResult = mrCancel then
    Cr.SQL.Query.Assign(rQuery);
  rQuery.Free;
  bSQLQuery := False;
  Release;
end;


end.
