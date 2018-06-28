unit UDLogOnServerAdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TCrpeLogOnServerAddDlg = class(TForm)
    pnlLogOnServerAdd: TPanel;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    lblDLLName: TLabel;
    editServerName: TEdit;
    editDatabaseName: TEdit;
    editUserID: TEdit;
    editPassword: TEdit;
    editDLLName: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CrpeLogOnServerAddDlg: TCrpeLogOnServerAddDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

procedure TCrpeLogOnServerAddDlg.btnOkClick(Sender: TObject);
begin
  {Check to see if ServerName edit field is blank}
  if IsStrEmpty(editServerName.Text) then
  begin
    MessageDlg('Please fill in ServerName before Adding.', mtWarning, [mbOk], 0);
    ModalResult := mrNone;
  end;
end;


end.
