unit uRepVendorFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentLookupFilter, DB, DBClient, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, StdCtrls, siComp;

type
  TRepVendorFilter = class(TRepParentLookupFilter)
  end;

implementation

uses uDMReport;

{$R *.dfm}

initialization
  RegisterClass(TRepVendorFilter)

end.
