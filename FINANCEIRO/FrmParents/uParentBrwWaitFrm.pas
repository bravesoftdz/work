unit uParentBrwWaitFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, StdCtrls, ComCtrls, ExtCtrls;

type
  TParentBrwWaitFrm = class(TParentAllFrm)
    LogoMarca: TAnimate;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}



procedure TParentBrwWaitFrm.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := Application.Title; 
end;

end.
