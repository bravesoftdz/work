unit uPctTreatmentLotFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, mrDBDateEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, mrDBEdit;

type
  TPctTreatmentLotFch = class(TParentButtonFch)
    edtMfg: TmrDBEdit;
    edtPurchaseDate: TmrDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TPctTreatmentLotFch);


end.
