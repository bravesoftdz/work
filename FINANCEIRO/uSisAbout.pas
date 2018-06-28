unit uSisAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, StdCtrls, ExtCtrls;

type
  TSisAbout = class(TParentAllFrm)
    Label1: TLabel;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SisAbout: TSisAbout;

implementation

{$R *.DFM}

end.
