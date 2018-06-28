unit uFrmPCCEnterPin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmPCCEnterPin = class(TForm)
    Label1: TLabel;
  public
    function Start : Boolean;
  end;

implementation

{$R *.dfm}

{ TFrmPCCEnterPin }

function TFrmPCCEnterPin.Start: Boolean;
begin
  Show;
end;

end.
