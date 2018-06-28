unit uParentDualList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, uConfigDualList, mrConfigDualList;

type
  TParentDualList = class(TParentForm)
    ConfigDualList: TmrConfigDualList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
