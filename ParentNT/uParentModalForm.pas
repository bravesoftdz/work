unit uParentModalForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, XiButton, ExtCtrls;

type
  TParentModalForm = class(TParentForm)
    pnlBottom: TPanel;
    btnOk: TXiButton;
    btnCancel: TXiButton;
    procedure OnOkClick(Sender: TObject);
    procedure OnCancelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ConfirmFrm; virtual; abstract;
    procedure CancelFrm; virtual; abstract;
  public
    function ShowFrm : Boolean; virtual;
  end;

var
  ParentModalForm: TParentModalForm;

implementation

{$R *.dfm}

{ TParentModalForm }

procedure TParentModalForm.OnCancelClick(Sender: TObject);
begin
  CancelFrm;
end;

procedure TParentModalForm.OnOkClick(Sender: TObject);
begin
  ConfirmFrm;
end;

function TParentModalForm.ShowFrm: Boolean;
begin
  ShowModal;
  Result := (ModalResult = mrOK);
end;

end.
