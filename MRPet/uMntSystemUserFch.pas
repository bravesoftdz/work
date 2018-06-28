unit uMntSystemUserFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit;

type
  TMntSystemUserFch = class(TParentButtonFch)
    edtUser: TmrDBEdit;
    edtUserCode: TmrDBEdit;
    edtPw: TmrDBEdit;
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uParentCustomFch;

{$R *.dfm}

procedure TMntSystemUserFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  DataSet.FieldByName('UserTypeID').AsInteger := 4; //Vendedor
end;

initialization
  RegisterClass(TMntSystemUserFch);


end.
