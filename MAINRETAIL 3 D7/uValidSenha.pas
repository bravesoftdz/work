unit uValidSenha;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, DB, DBTables, SysUtils, Dialogs, ExtCtrls, Mask, ADODB, siComp,
  siLangRT, PaiDeForms;

type
  TValidSenha = class(TFrmParentForms)
    Label1: TLabel;
    EditPassword: TEdit;
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    quSaveSenha: TADOQuery;
    Label2: TLabel;
    btOK: TButton;
    btCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    MyExpDate : TDateTime;
    function ValidateSenha(ExpDate : TDateTime; Password : String) : Boolean;
  public
    { Public declarations }
    IsSave    : Boolean;    
    function Start(ExpDate : TDateTime) : boolean;
  end;

implementation

uses uDM, uMsgBox, Math, uMsgConstant, uDMGlobal;

{$R *.DFM}

function TValidSenha.ValidateSenha(ExpDate : TDateTime; Password : String) : Boolean;
var
  Day, Month, Year : Word;
  AuxValue         : Double;
begin
  DecodeDate(ExpDate, Year, Month, Day);

  AuxValue := Ln(Year) + Power(LnXP1(Month), Ln(Day));

  Result := (Trim(Password) = FloatToStr(AuxValue));
end;

function TValidSenha.Start(ExpDate : TDateTime) : boolean;
begin
  MyExpDate := ExpDate;

  Result := (ShowModal = mrOk);
end;

procedure TValidSenha.FormShow(Sender: TObject);
begin
  EditPassword.SetFocus;
end;

procedure TValidSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TValidSenha.btOKClick(Sender: TObject);
begin
  if not ValidateSenha(MyExpDate, EditPassword.Text) then
    begin
      MsgBox(MSG_CRT_ERROR_STACK_SIZE, vbOkOnly + vbInformation);
      Exit;
    end;

  // Grava a Senha
  if IsSave then
    begin
      with quSaveSenha do
        begin
          Parameters.ParamByName('DataExp').Value   := MyExpDate;
          Parameters.ParamByName('Password').Value  := Trim(EditPassword.Text);
          ExecSQL;
        end;
    end;

  ModalResult := mrOK;
end;

procedure TValidSenha.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TValidSenha.FormCreate(Sender: TObject);
begin
   inherited;

   IsSave := False;

end;


end.

