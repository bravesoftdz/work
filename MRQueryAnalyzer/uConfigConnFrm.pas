unit uConfigConnFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uMainFrm, uParamFunctions;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  MainFrm.ADOConn.Close;
  if not CheckBox1.Checked then
    MainFrm.ADOConn.ConnectionString := SetConnectionStrNoNETLIB(Edit3.Text, Edit4.Text, Edit2.Text, Edit1.Text)
  else
    MainFrm.ADOConn.ConnectionString := SetConnectionStr(Edit3.Text, Edit4.Text, Edit2.Text, Edit1.Text);

  Close;
end;

end.
