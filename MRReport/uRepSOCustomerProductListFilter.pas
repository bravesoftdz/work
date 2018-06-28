unit uRepSOCustomerProductListFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentListFilter, DB, DBClient, siComp, cxListBox,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, StdCtrls, Buttons;

type
  TRepSOCustomerProductListFilter = class(TRepParentListFilter)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMReport;

{$R *.dfm}

initialization
  RegisterClass(TRepSOCustomerProductListFilter);

end.
