unit uParentButtonTabFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, cxControls, cxPC, DB, uConfigFch, StdCtrls,
  ExtCtrls;

type
  TParentButtonTabFch = class(TParentButtonFch)
    pcFch: TcxPageControl;
  protected
    procedure SetPageControl(PageIndex: Integer); override;
  end;

implementation

{$R *.dfm}

{ TParentButtonTabFch }

procedure TParentButtonTabFch.SetPageControl(PageIndex: Integer);
begin
  with pcFch do
    ActivePage := Pages[PageIndex];
end;

end.
