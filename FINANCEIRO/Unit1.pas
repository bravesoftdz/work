unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, dxBar, FormConfig, Db, DBTables, E2Query, PowerQuery,
  ExtCtrls, StdCtrls, Buttons;

type
  TParentFch1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParentFch1: TParentFch1;

implementation

{$R *.DFM}

end.
