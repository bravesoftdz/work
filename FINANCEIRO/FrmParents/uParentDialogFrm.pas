unit uParentDialogFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentModal, StdCtrls, Buttons, ExtCtrls, siComp, siLangRT;

type
  TParentDialogFrm = class(TParentModalFrm)
    btCancel: TBitBtn;
    btOk: TBitBtn;
    pnlPBarra: TPanel;
    pnlPLinhaSuperior: TPanel;
    pnlPDAlignRight: TPanel;
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TParentDialogFrm.btOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOK;
end;

procedure TParentDialogFrm.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

end.
