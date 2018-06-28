unit uSubGridLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, StdCtrls, Buttons, Registry, siComp, siLangRT;

type
  TSubGridLayout = class(TParentSub)
    Label23: TLabel;
    btnEditL: TSpeedButton;
    Label24: TLabel;
    cbxLayout: TComboBox;
    cbxKind: TComboBox;
    cxGrid: TcxGrid;
    cxGridDB: TcxGridDBTableView;
    cxGridDBDBColumn1: TcxGridDBColumn;
    cxGridDBDBColumn2: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    procedure cbxLayoutChange(Sender: TObject);
    procedure cbxKindChange(Sender: TObject);
    procedure btnEditLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Reg : TRegistry;
    procedure FillGridLayouts;
    procedure SaveData;
  public
    { Public declarations }
  end;

implementation

uses uDM, cxLookAndFeels, cxStyleSheetEditor;

{$R *.dfm}

procedure TSubGridLayout.SaveData;
begin
  Reg.WriteInteger('GridLayout', cbxLayout.ItemIndex);
  Reg.WriteInteger('GridKind', cbxKind.ItemIndex);
  DM.fGrid.Layout := cbxLayout.ItemIndex;
  DM.fGrid.Kind   := cbxKind.ItemIndex;
end;

procedure TSubGridLayout.FillGridLayouts;
var
  i : integer;
begin

  //Fill out
  if cbxLayout.Items.Count = 0 then
     cbxLayout.Items := DM.fPredefinedStyle;

  //Initial pos
  cbxLayout.ItemIndex := DM.fGrid.Layout;
  cbxKind.ItemIndex   := DM.fGrid.Kind;

  if DM.fGrid.Layout <> -1 then
     cxGridDB.Styles.StyleSheet := TcxGridTableViewStyleSheet(cbxLayout.Items.Objects[cbxLayout.ItemIndex]);
end;


procedure TSubGridLayout.cbxLayoutChange(Sender: TObject);
begin
  inherited;
  SaveData;
  cxGridDB.Styles.StyleSheet := TcxGridTableViewStyleSheet(cbxLayout.Items.Objects[cbxLayout.ItemIndex]);
end;

procedure TSubGridLayout.cbxKindChange(Sender: TObject);
begin
  inherited;
  Case cbxKind.ItemIndex of
   0 : cxGrid.LookAndFeel.Kind := lfStandard;
   1 : cxGrid.LookAndFeel.Kind := lfFlat;
   2 : cxGrid.LookAndFeel.Kind := lfUltraFlat;
  end;
  SaveData;
end;

procedure TSubGridLayout.btnEditLClick(Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  inherited;
  if not ShowcxStyleSheetEditor(TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fPredefinedStyle.IndexOfObject(cxGridDB.Styles.StyleSheet)]), nil) then
     Exit;

  AList := TList.Create;
  try
    Screen.Cursor := crHourGlass;
    AList.Clear;
    with DM.strepPredefined do
       for I:= 0 to StyleSheetCount - 1 do
          AList.Add(StyleSheets[I]);
    SaveStyleSheetsToIniFile(DM.GridLayoutFileName, AList);
   finally
      AList.Free;
      Screen.Cursor := crDefault;
    end;

end;

procedure TSubGridLayout.FormCreate(Sender: TObject);
begin
  inherited;
  Reg := DM.CreateLocalRegistry;
  FillGridLayouts;
  //TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Values[0];
end;

procedure TSubGridLayout.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(Reg) then
     FreeAndNil(Reg);
end;

initialization RegisterClass(TSubGridLayout);

end.
