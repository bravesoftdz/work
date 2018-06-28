unit uMntStateFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit, StdCtrls;

type
  TMntStateFch = class(TParentButtonFch)
    edtState: TmrDBEdit;
    edtCode: TmrDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMMaintenance;

{$R *.dfm}

initialization
  RegisterClass(TMntStateFch);


end.
