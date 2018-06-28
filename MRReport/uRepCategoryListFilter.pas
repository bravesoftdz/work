unit uRepCategoryListFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentListFilter, DB, DBClient, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Buttons, cxListBox;

type
  TRepCategoryListFilter = class(TRepParentListFilter)
  end;

implementation

uses uDMReport;

{$R *.dfm}

initialization
  RegisterClass(TRepCategoryListFilter)

end.
