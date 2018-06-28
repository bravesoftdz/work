unit uRepYearFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepNumberFilter, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, StdCtrls, siComp;

type
  TRepYearFilter = class(TRepNumberFilter)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses DateUtils;

{$R *.dfm}

procedure TRepYearFilter.FormCreate(Sender: TObject);
begin
  inherited;
  seNumber.Value := YearOf(Now);
end;

initialization
  RegisterClass(TRepYearFilter)

end.
