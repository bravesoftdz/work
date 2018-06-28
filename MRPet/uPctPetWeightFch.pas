unit uPctPetWeightFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, mrDBDateEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  mrDBCurrencyEdit, StdCtrls;

type
  TPctPetWeightFch = class(TParentButtonFch)
    edtWeight: TmrDBCurrencyEdit;
    edtWhelpDate: TmrDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter;


{$R *.dfm}

initialization
  RegisterClass(TPctPetWeightFch);


end.
