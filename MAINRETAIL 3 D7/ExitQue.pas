unit ExitQue;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, LblEffct, siComp, siLangRT, PaiDeForms;

type
  TExitQuery = class(TFrmParentForms)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Image1: TImage;
    LabelTit: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExitQuery: TExitQuery;

implementation

{$R *.DFM}

end.

