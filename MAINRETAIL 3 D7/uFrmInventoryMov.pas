unit uFrmInventoryMov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, 
  LblEffct, ExtCtrls, FormConfig, DateBox, Buttons,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TbrwFrmInventoryMov = class(TbrwFrmParent)
    Label2: TLabel;
    quFormIDInventoryMov: TIntegerField;
    quFormInventMovTypeID: TIntegerField;
    quFormDocumentID: TIntegerField;
    quFormStoreID: TIntegerField;
    quFormModelID: TIntegerField;
    quFormMovDate: TDateTimeField;
    Label1: TLabel;
    edID: TDBEdit;
    Label3: TLabel;
    edQty: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    edDocument: TDBEdit;
    Label6: TLabel;
    scStore: TDBSuperComboADO;
    Label8: TLabel;
    scModel: TDBSuperComboADO;
    edMovDate: TDBDateBox;
    Label7: TLabel;
    scType: TDBSuperComboADO;
    Label9: TLabel;
    mmNotes: TDBMemo;
    Label21: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    scUser: TDBSuperComboADO;
    Label17: TLabel;
    quFormIDUser: TIntegerField;
    quFormQty: TFloatField;
    quMovComplement: TADODataSet;
    dsMovComplement: TDataSource;
    quMovComplementNotes: TStringField;
    lblReason: TLabel;
    scReason: TDBSuperComboADO;
    quMovComplementIDInventoryMov: TIntegerField;
    quMovComplementIDMovReason: TIntegerField;
    lblRequiredReason: TLabel;
    procedure FormShow(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure quMovComplementAfterOpen(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormAfterClose(DataSet: TDataSet);
    procedure dsMovComplementStateChange(Sender: TObject);
    procedure mmNotesChange(Sender: TObject);
    procedure quFormAfterPost(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
  private
    FInsMovComplement: Boolean;
  protected
    function OnValidadeField: boolean; override;
  end;

implementation

uses uDM, uSystemTypes, uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TbrwFrmInventoryMov.FormShow(Sender: TObject);
begin
  inherited;
  if frmCommand = btInc then
     scType.AddFilter(['System'], ['0'])
  else
     scType.ClearFilters;
end;

procedure TbrwFrmInventoryMov.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormQty.AsInteger      := 1;
  quFormMovDate.AsDateTime := Date;
  quFormIDUser.AsInteger   := DM.fUser.ID;  
end;

procedure TbrwFrmInventoryMov.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1730);
end;

function TbrwFrmInventoryMov.OnValidadeField: boolean;
begin
  Result := True;

  if (FInsMovComplement and (mmNotes.Text <> '') and (scReason.LookUpValue = '')) or
     ((not FInsMovComplement) and (scReason.LookUpValue = '')) then
  begin
    Result := False;
    MsgBox(MSG_CRT_NO_EMPTY_REASON, vbInformation + vbOKOnly);
  end;
end;

procedure TbrwFrmInventoryMov.quMovComplementAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.IsEmpty then
  begin
    DataSet.Append;
    DataSet.FieldByName('IDInventoryMov').Value := quForm.FieldByName('IDInventoryMov').Value;
    FInsMovComplement := True;
    lblRequiredReason.Visible := False;
  end
  else
  begin
    DataSet.Edit;
    FInsMovComplement := False;
    lblRequiredReason.Visible := True;
  end;
end;

procedure TbrwFrmInventoryMov.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  with quMovComplement do
  begin
    Parameters.ParamByName('IDInventoryMov').Value := DataSet.FieldByName('IDInventoryMov').Value;
    Open;
  end;
end;

procedure TbrwFrmInventoryMov.quFormAfterClose(DataSet: TDataSet);
begin
  inherited;
  quMovComplement.Close;
end;

procedure TbrwFrmInventoryMov.dsMovComplementStateChange(Sender: TObject);
begin
  inherited;
  if (dsMovComplement.State in dsEditModes) and not (dsForm.State in dsEditModes) then
    dsForm.Edit;
end;

procedure TbrwFrmInventoryMov.mmNotesChange(Sender: TObject);
begin
  inherited;
  lblRequiredReason.Visible := (FInsMovComplement and (mmNotes.Text <> '')) or (not FInsMovComplement);
end;

procedure TbrwFrmInventoryMov.quFormAfterPost(DataSet: TDataSet);
begin
  inherited;
  if FInsMovComplement and (scReason.LookUpValue = '') then
    quMovComplement.Cancel
  else
    quMovComplement.Post;
end;

procedure TbrwFrmInventoryMov.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quMovComplementIDInventoryMov.AsInteger := quFormIDInventoryMov.AsInteger;
end;

end.
