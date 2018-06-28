unit uWizSetupProgramsColumns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizard, ImgList, StdCtrls, ExtCtrls, ComCtrls, Grids, ADODB;

const

  STORE_GRID          = 0;
  CATEGORY_GRID       = 1;
  TAX_SCHEDULE_GRID   = 2;

  COLUMN_MAIN_RETAIL  = 1;
  COLUMN_OTHER_PROGR  = 2;

type
  TWizSetupProgramsColumns = class(TParentWizard)
    tsSoftware: TTabSheet;
    tsMas90: TTabSheet;
    pgMas90Option: TPageControl;
    tsStoreColumn: TTabSheet;
    tsCategoryColumn: TTabSheet;
    tsTaxScheduleColumn: TTabSheet;
    sgStoreColumns: TStringGrid;
    sgCategoryColumns: TStringGrid;
    sgTaxScheduleColumns: TStringGrid;
    treeSoftware: TTreeView;
    Label20: TLabel;
    lbSoftware: TLabel;
    Config: TTabSheet;
    lbCostAccount: TLabel;
    lbSalesAccount: TLabel;
    edCostAccount: TEdit;
    edSalesAccount: TEdit;
    lbGLSalesAccount: TLabel;
    edGLSalesAccount: TEdit;
    procedure treeSoftwareClick(Sender: TObject);
    procedure pgMas90OptionChange(Sender: TObject);
    procedure sgTaxScheduleColumnsExit(Sender: TObject);
    procedure sgCategoryColumnsExit(Sender: TObject);
    procedure sgStoreColumnsExit(Sender: TObject);
    procedure edCostAccountExit(Sender: TObject);
    procedure edSalesAccountExit(Sender: TObject);
    procedure edGLSalesAccountExit(Sender: TObject);
  private
    fGrid : TStringGrid;
    fGridType : Integer;
    procedure ClearColumns;
    procedure SaveGridColumns;
    procedure FillColumnGrid;
    procedure AddListToColumn;
    procedure GetGridColumn;
    procedure GetMas90Config;
    procedure GetArchiveName(var Friend:String);
  protected
    procedure OnAfterDoFinish; override;
    procedure OnBeforeBackClick; override;
    function TestBeforeNavigate:Boolean; override;
    function DoFinish:Integer; override;
    function OnAfterChangePage:Boolean; override;
  public
    { Public declarations }
  end;

var
  WizSetupProgramsColumns: TWizSetupProgramsColumns;

implementation

uses uDM, DB, uParamFunctions, uMsgBox;

{$R *.dfm}

procedure TWizSetupProgramsColumns.ClearColumns;
var i: integer;
begin

 for i:=1 to fGrid.RowCount-1 do
  begin
  fGrid.Cells[COLUMN_OTHER_PROGR,i] := '';
  fGrid.Cells[COLUMN_MAIN_RETAIL,i] := '';
  end;

end;

function TWizSetupProgramsColumns.DoFinish: Integer;
begin
 inherited;
end;

function TWizSetupProgramsColumns.OnAfterChangePage: Boolean;
begin
 if pgOption.ActivePage.Name = 'tsMas90' then
     begin
     pgMas90Option.ActivePageIndex := 0;
     GetMas90Config;
     end
end;

procedure TWizSetupProgramsColumns.OnAfterDoFinish;
begin
  inherited;
end;

procedure TWizSetupProgramsColumns.OnBeforeBackClick;
begin
 inherited;
end;

function TWizSetupProgramsColumns.TestBeforeNavigate: Boolean;
begin
  Result := True;

  if pgOption.ActivePage.Name = 'tsSoftware' then
     begin
     if treeSoftware.Selected.Index = -1 then
        begin
        MsgBox('Select Software to Export', vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
end;

procedure TWizSetupProgramsColumns.SaveGridColumns;
var
  sColumn, Friend : String;
  i : integer;
begin
  GetArchiveName(Friend);

  for i:=1 to fGrid.RowCount-1 do
      if Trim(fGrid.Cells[COLUMN_MAIN_RETAIL,i]) <> '' then
         if Pos(Trim(fGrid.Cells[COLUMN_OTHER_PROGR,i]), sColumn) = 0 then
            sColumn := sColumn + fGrid.Cells[COLUMN_MAIN_RETAIL,i]+'='+
                                 fGrid.Cells[COLUMN_OTHER_PROGR,i]+';';

  if sColumn = '' then
     Exit;

  DM.SetIniFileString('ColumnMas90Setup', Friend, sColumn);

end;

procedure TWizSetupProgramsColumns.FillColumnGrid;
var i : Integer;
begin
   fGrid.Cells[COLUMN_ID,0]          := 'Col';
   fGrid.Cells[COLUMN_OTHER_PROGR,0] := 'Mas90';
   fGrid.Cells[COLUMN_MAIN_RETAIL,0] := 'Main Retail';

   AddListToColumn;
end;

procedure TWizSetupProgramsColumns.AddListToColumn;
var Query: TADODataSet;
    i : Integer;
begin
   case fGridType of
    STORE_GRID         : begin
                          Query := DM.quStoreList;
                          DM.OpenStoreList;
                         end;
    CATEGORY_GRID      : begin
                          Query := DM.quCategoryList;
                          DM.OpenCategoryList;
                         end;
    TAX_SCHEDULE_GRID  : begin
                          Query := DM.quTaxScheduleList;
                          DM.OpenTaxScheduleList;
                         end;
   end;

   fGrid.RowCount := Query.RecordCount + 1;
   fGrid.ColCount := 3;

   Query.First;
   i := 1;

   while not Query.Eof do
    begin
     fGrid.Cells[1,i] := Query.Fields.Fields[1].AsString;
     Query.Next;
     inc(i);
    end;

   DM.CloseQuerysMas90List;
end;

procedure TWizSetupProgramsColumns.GetGridColumn;
var
  sColumn, Friend, sResult : String;
  i : integer;
begin
   GetArchiveName(Friend);

   sColumn := DM.GetIniFile('ColumnMas90Setup', Friend);

  if sColumn = '' then
     Exit;

  for i:=1 to fGrid.RowCount-1 do
      begin
      sResult := ParseParam(sColumn, Trim(fGrid.Cells[COLUMN_MAIN_RETAIL,i]));
      if sResult <> '' then
         fGrid.Cells[COLUMN_OTHER_PROGR,i] := sResult;
      end;

end;

procedure TWizSetupProgramsColumns.GetArchiveName(var Friend: String);
begin
 case fGridType of
   STORE_GRID        : Friend := 'Store';
   CATEGORY_GRID     : Friend := 'Category';
   TAX_SCHEDULE_GRID : Friend := 'TaxSchedule';
  end;
end;

procedure TWizSetupProgramsColumns.treeSoftwareClick(Sender: TObject);
begin
  lbSoftware.Visible := True;

  case treeSoftware.Selected.Index of
       0 : begin
            DM.iSoftware := SOFTWARE_MAS90;
            lbSoftware.Caption := 'Setup to Mas90.';
           end;
  end;
end;

procedure TWizSetupProgramsColumns.pgMas90OptionChange(Sender: TObject);
begin
 if pgMas90Option.ActivePage.Name = 'tsStoreColumn' then
     begin
      fGrid     := sgStoreColumns;
      fGridType := STORE_GRID;

      ClearColumns;

      FillColumnGrid;
      GetGridColumn;
     end
 else if pgMas90Option.ActivePage.Name = 'tsCategoryColumn' then
     begin
      fGrid := sgCategoryColumns;
      fGridType := CATEGORY_GRID;

      ClearColumns;

      FillColumnGrid;
      GetGridColumn;
     end
 else if pgMas90Option.ActivePage.Name = 'tsTaxScheduleColumn' then
     begin
      fGrid := sgTaxScheduleColumns;
      fGridType := TAX_SCHEDULE_GRID;

      ClearColumns;

      FillColumnGrid;
      GetGridColumn;
     end
end;

procedure TWizSetupProgramsColumns.sgTaxScheduleColumnsExit(
  Sender: TObject);
begin
  inherited;
  SaveGridColumns;
end;

procedure TWizSetupProgramsColumns.sgCategoryColumnsExit(Sender: TObject);
begin
  inherited;
  SaveGridColumns;
end;

procedure TWizSetupProgramsColumns.sgStoreColumnsExit(Sender: TObject);
begin
  inherited;
  SaveGridColumns;
end;

procedure TWizSetupProgramsColumns.edCostAccountExit(Sender: TObject);
begin
  inherited;
  DM.SetIniFileString('ColumnMas90Setup', 'Cost_Account', edCostAccount.Text);
end;

procedure TWizSetupProgramsColumns.edSalesAccountExit(Sender: TObject);
begin
  inherited;
  DM.SetIniFileString('ColumnMas90Setup', 'Sales_Account', edSalesAccount.Text);
end;

procedure TWizSetupProgramsColumns.GetMas90Config;
begin
  edCostAccount.Text    := DM.GetIniFile('ColumnMas90Setup', 'Cost_Account');
  edSalesAccount.Text   := DM.GetIniFile('ColumnMas90Setup', 'Sales_Account');
  edGLSalesAccount.Text := DM.GetIniFile('ColumnMas90Setup', 'GLSales_Account');
end;

procedure TWizSetupProgramsColumns.edGLSalesAccountExit(Sender: TObject);
begin
  inherited;
  DM.SetIniFileString('ColumnMas90Setup', 'GLSales_Account', edGLSalesAccount.Text);
end;

end.
