unit uRepStoreListFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentListFilter, DB, DBClient, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Buttons, cxListBox;

type
  TRepStoreListFilter = class(TRepParentListFilter)
  end;

implementation

uses uDMReport;

{$R *.dfm}

initialization
  RegisterClass(TRepStoreListFilter);

end.