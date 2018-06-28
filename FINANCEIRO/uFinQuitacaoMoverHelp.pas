unit uFinQuitacaoMoverHelp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, LblEffct, StdCtrls, ExtCtrls, Buttons, jpeg, siComp,
  siLangRT;

type
  TFinQuitacaoMoverHelp = class(TParentDialogFrm)
    Panel3: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    LabelEffect1: TLabelEffect;
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinQuitacaoMoverHelp: TFinQuitacaoMoverHelp;

implementation

{$R *.DFM}


procedure TFinQuitacaoMoverHelp.btOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

end.
