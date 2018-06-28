unit uMntCountryFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit, StdCtrls;

type
  TMntCountryFch = class(TParentButtonFch)
    edtCode: TmrDBEdit;
    edtCoutry: TmrDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMMaintenance;

{$R *.dfm}

initialization
  RegisterClass(TMntCountryFch);


end.
