unit uRepColorFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentLookupFilter, DB, DBClient, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, StdCtrls;

type
  TRepColorFilter = class(TRepParentLookupFilter)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepColorFilter: TRepColorFilter;

implementation

{$R *.dfm}

end.
