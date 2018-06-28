unit uPctBreedFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit, StdCtrls,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, mrSuperCombo;

type
  TPctBreedFch = class(TParentButtonFch)
    edtBreed: TmrDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter;

{$R *.dfm}

initialization
  RegisterClass(TPctBreedFch);


end.
