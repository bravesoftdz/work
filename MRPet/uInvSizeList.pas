unit uInvSizeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentToolBarList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, dxBar, mrConfigList, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, uParentList, StdCtrls, ImgList, cxContainer, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, XiButton, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo;

type
  TInvSizeList = class(TParentToolBarList)
    scCategoria: TmrSuperCombo;
    procedure ConfigListAfterStart(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter;

{$R *.dfm}

procedure TInvSizeList.ConfigListAfterStart(Sender: TObject);
begin
  inherited;
  scCategoria.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session);
end;

end.
