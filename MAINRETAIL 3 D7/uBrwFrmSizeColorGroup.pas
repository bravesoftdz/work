unit uBrwFrmSizeColorGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, Grids,
  DBGrids, SMDBGrid, SuperComboADO;

type
  TbrwFrmSizeColorGroup = class(TbrwFrmParent)
    quFormIDSizeColorGroup: TIntegerField;
    quFormDescription: TStringField;
    quFormIsColor: TBooleanField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    edtDescription: TDBEdit;
    lblDescription: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    btAddCredit: TSpeedButton;
    btDelCredit: TSpeedButton;
    grdColor: TSMDBGrid;
    scColor: TSuperComboADO;
    lblColor: TLabel;
    scSize: TSuperComboADO;
    quInvColorToGroup: TADOQuery;
    quInvSizeToGroup: TADOQuery;
    dsColor: TDataSource;
    quInvColorToGroupIDSizeColorGroup: TIntegerField;
    quInvColorToGroupIDColor: TIntegerField;
    quInvSizeToGroupIDSizeColorGroup: TIntegerField;
    quInvSizeToGroupIDSize: TIntegerField;
    Label18: TLabel;
    quInvColorToGroupColor: TStringField;
    quInvSizeToGroupSizeName: TStringField;
    dsSize: TDataSource;
    grdSize: TSMDBGrid;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btAddCreditClick(Sender: TObject);
    procedure btDelCreditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fIsColor : Boolean;

    procedure SizeOpen;
    procedure SizeClose;
    procedure SizeRefresh;
    procedure SizeAdd;
    procedure SizeDelete;

    procedure ColorOpen;
    procedure ColorClose;
    procedure ColorRefresh;
    procedure ColorAdd;
    procedure ColorDelete;

  protected
    procedure OnBeforeStart; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
uses uDM, uParamFunctions;

procedure TbrwFrmSizeColorGroup.ColorAdd;
var
  sSQL : String;
begin
  if scColor.LookUpValue = '' then
     Exit;

  if quInvColorToGroup.Locate('IDColor', scColor.LookUpValue, []) then
     Exit;

  sSQL := 'INSERT Inv_ColorToGroup (IDSizeColorGroup,  IDColor) VALUES (' +
          IntToStr(quFormIDSizeColorGroup.AsInteger) + ', ' +
          scColor.LookUpValue + ')';

  DM.RunSQL(sSQL);
  ColorRefresh;
  scColor.LookUpValue := '';
  scColor.SetFocus;
end;

procedure TbrwFrmSizeColorGroup.ColorClose;
begin
  with quInvColorToGroup do
    if Active then
       Close;
end;

procedure TbrwFrmSizeColorGroup.ColorDelete;
var
  sSQL : String;
begin
  if (not quInvColorToGroup.Active) or
     (quInvColorToGroupIDSizeColorGroup.AsInteger = 0) then
     Exit;

  sSQL := 'DELETE Inv_ColorToGroup WHERE IDSizeColorGroup = ' +
          IntToStr(quInvColorToGroupIDSizeColorGroup.AsInteger) + ' AND ' +
          ' IDColor = ' + IntToStr(quInvColorToGroupIDColor.AsInteger);

  DM.RunSQL(sSQL);
  ColorRefresh;
end;

procedure TbrwFrmSizeColorGroup.ColorOpen;
begin
  with quInvColorToGroup do
    if not Active then
       begin
       Parameters.ParamByName('IDSizeColorGroup').Value := quFormIDSizeColorGroup.AsInteger;
       Open;
       end;
end;

procedure TbrwFrmSizeColorGroup.ColorRefresh;
begin
   ColorClose;
   ColorOpen;
end;

procedure TbrwFrmSizeColorGroup.OnBeforeStart;
begin
  inherited;
  fIsColor := (ParseParam(Self.sParam, 'IsColor')='1');

  scSize.Visible  := not fIsColor;
  grdSize.Visible := not fIsColor;

  scColor.Visible  := fIsColor;
  grdColor.Visible := fIsColor;

end;

procedure TbrwFrmSizeColorGroup.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if fIsColor then
     ColorRefresh
  else
     SizeRefresh;
end;

procedure TbrwFrmSizeColorGroup.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIsColor.AsBoolean := fIsColor;
end;

procedure TbrwFrmSizeColorGroup.SizeAdd;
var
  sSQL : String;
begin
  if scSize.LookUpValue = '' then
     Exit;

  if quInvSizeToGroup.Locate('IDSize', scSize.LookUpValue, []) then
     Exit;

  sSQL := 'INSERT Inv_SizeToGroup (IDSizeColorGroup,  IDSize) VALUES (' +
          IntToStr(quFormIDSizeColorGroup.AsInteger) + ', ' +
          scSize.LookUpValue + ')';

  DM.RunSQL(sSQL);
  SizeRefresh;
  scSize.LookUpValue := '';
  scSize.SetFocus; 
end;

procedure TbrwFrmSizeColorGroup.SizeClose;
begin
  with quInvSizeToGroup do
     if Active then
        Close;
end;

procedure TbrwFrmSizeColorGroup.SizeDelete;
var
  sSQL : String;
begin

  if (not quInvColorToGroup.Active) or
     (quInvColorToGroupIDSizeColorGroup.AsInteger = 0) then
     Exit;

  sSQL := 'DELETE Inv_SizeToGroup WHERE IDSizeColorGroup = ' +
          IntToStr(quInvColorToGroupIDSizeColorGroup.AsInteger) + ' AND ' +
          ' IDSize = ' + IntToStr(quInvSizeToGroupIDSize.AsInteger);

  DM.RunSQL(sSQL);
  SizeRefresh;
end;

procedure TbrwFrmSizeColorGroup.SizeOpen;
begin
  with quInvSizeToGroup do
     if not Active then
        begin
        Parameters.ParamByName('IDSizeColorGroup').Value := quFormIDSizeColorGroup.AsInteger;
        Open;
        end;
end;

procedure TbrwFrmSizeColorGroup.SizeRefresh;
begin
   SizeClose;
   SizeOpen;
end;

procedure TbrwFrmSizeColorGroup.btAddCreditClick(Sender: TObject);
begin
  inherited;
  if fIsColor then
     ColorAdd
  else
     SizeAdd;
end;

procedure TbrwFrmSizeColorGroup.btDelCreditClick(Sender: TObject);
begin
  inherited;
  if fIsColor then
     ColorDelete
  else
     SizeDelete; 
end;

procedure TbrwFrmSizeColorGroup.FormShow(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
     begin
     btAddCredit.Visible := False;
     btDelCredit.Visible := False;
     end;
end;

end.
