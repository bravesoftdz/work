unit uNewPersonType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO;

type
  TNewPersonType = class(TFrmParentAll)
    cmbPersonType: TSuperComboADO;
    lblTypePerson: TLabel;
    btOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbPersonTypeSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(var IDTypePerson : Integer) : Boolean;
  end;

var
  NewPersonType: TNewPersonType;

implementation

uses uDM;

{$R *.dfm}

{ TNewPersonType }

function TNewPersonType.Start(var IDTypePerson: Integer): Boolean;
begin

  ShowModal;


  if (ModalResult = mrOk) then
     IDTypePerson := StrToInt(cmbPersonType.LookUpValue)
  else
     IDTypePerson := 0;
end;

procedure TNewPersonType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TNewPersonType.cmbPersonTypeSelectItem(Sender: TObject);
begin
  inherited;
  if cmbPersonType.Text <> '' then
     btOK.Enabled := True;
end;

procedure TNewPersonType.FormShow(Sender: TObject);
begin
  cmbPersonType.LookUpValue := '';
  cmbPersonType.SetFocus;
  btOK.Enabled := False;
end;

end.
