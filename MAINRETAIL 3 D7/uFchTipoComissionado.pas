unit uFchTipoComissionado;

interface

uses                          
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, LblEffct, ExtCtrls, FormConfig, Grids,
  DBGrids, Buttons, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  SMDBGrid;

type
  TFchTipoComissionado = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    quProfile: TADOQuery;
    dsProfile: TDataSource;
    quDiscRange: TADOQuery;
    dsDiscRange: TDataSource;
    quDiscRangeIDTipoComissionado: TIntegerField;
    quDiscRangeTotVendaMin: TFloatField;
    quDiscRangePercDiscMax: TFloatField;
    quFormIDTipoComissionado: TIntegerField;
    quFormTipoComissionado: TStringField;
    quFormPathName: TStringField;
    quFormDefaultDiaPag: TIntegerField;
    quFormComissionOnProfit: TBooleanField;
    Label4: TLabel;
    DBSuperCombo1: TDBSuperComboADO;
    Label21: TLabel;
    Label7: TLabel;
    quProfileIDTipoComissionado: TIntegerField;
    quProfileName: TStringField;
    quProfileComission: TFloatField;
    quFormPath: TStringField;
    pnlPaymentDay: TPanel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    quProfileGroupID: TIntegerField;
    pnlHideDiscRange: TPanel;
    Label5: TLabel;
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    Panel11: TPanel;
    pnlHideComissao: TPanel;
    DBRadioGroup1: TDBRadioGroup;
    Panel5: TPanel;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    grdProfile: TSMDBGrid;
    grdDiscRange: TSMDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure quDiscRangeNewRecord(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure quDiscRangeAfterEdit(DataSet: TDataSet);
    procedure quProfileAfterEdit(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure dsDiscRangeStateChange(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure grdDiscRangeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure ProfileClose;
    procedure ProfileOpen;
    procedure ProfilePost;

    procedure DiscRangeClose;
    procedure DiscRangeOpen;
    procedure DiscRangePost;
    procedure DiscRangeRefresh;
    procedure DiscRangeCancel;

  public
    { Public declarations }
  end;

implementation

uses uDM, xBase, uMsgBox, uDMGlobal;

{$R *.DFM}

procedure TFchTipoComissionado.DiscRangeCancel;
begin

  with quDiscRange do
    if Active then
       if State in dsEditModes then
          Cancel;

end;

procedure TFchTipoComissionado.DiscRangeRefresh;
var
  iSalesValue: integer;
begin

  iSalesValue := quDiscRangeTotVendaMin.AsInteger;
  DiscRangeClose;
  DiscRangeOpen;
  quDiscRange.Locate('TotVendaMin', IntToStr(iSalesValue), [] );

end;

procedure TFchTipoComissionado.DiscRangeClose;
begin

   DiscRangePost;

   with quDiscRange do
      if Active then
         Close;

end;

procedure TFchTipoComissionado.DiscRangeOpen;
begin

  with quDiscRange do
     if not Active then
        begin
        Parameters.ParamByName('IDTipoComissionado').Value := quFormIDTipoComissionado.AsInteger;
        Open;
        end;

end;

procedure TFchTipoComissionado.DiscRangePost;
begin

  with quDiscRange do
     if Active then
        if State in dsEditModes then
           Post;

end;


procedure TFchTipoComissionado.ProfilePost;
begin

    with quProfile do
       if Active then
          if State in dsEditModes then
             Post;

end;

procedure TFchTipoComissionado.ProfileClose;
begin

   ProfilePost;

   with quProfile do
      if Active then
         Close;

end;

procedure TFchTipoComissionado.ProfileOpen;
begin

   with quProfile do
     begin
       if not Active then
          begin
          Parameters.ParamByName('IDTipoComissionado').Value := quFormIDTipoComissionado.AsInteger;
          Open;
          end;
     end;

end;


procedure TFchTipoComissionado.FormShow(Sender: TObject);
begin
  inherited;

  //Sales Person
  pnlHideDiscRange.Visible := (LeftStr(quFormPath.AsString, 8) = '.003.001');

  //Agencies
  pnlHideComissao.Visible  := not (LeftStr(quFormPath.AsString, 8) = '.003.003');


  //Sales Person, Agencies, Commissions
  pnlPaymentDay.Visible    := not ((LeftStr(quFormPath.AsString, 8) = '.003.001') or
                               (LeftStr(quFormPath.AsString, 8) = '.003.003') or
                               (LeftStr(quFormPath.AsString, 4) = '.003')   );

  quFormDefaultDiaPag.Required := pnlPaymentDay.Visible;

end;

procedure TFchTipoComissionado.btAddClick(Sender: TObject);
begin
  inherited;

  quDiscRange.Insert;
  grdDiscRange.SetFocus;
  quDiscRangeTotVendaMin.FocusControl;

end;

procedure TFchTipoComissionado.btRemoveClick(Sender: TObject);
begin
  inherited;

  quDiscRange.Delete;
  dsDiscRangeStateChange(nil);

end;

procedure TFchTipoComissionado.quDiscRangeNewRecord(DataSet: TDataSet);
begin
  inherited;
  
  quDiscRangeIDTipoComissionado.AsInteger := quFormIDTipoComissionado.AsInteger;

end;


procedure TFchTipoComissionado.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(311);
end;

procedure TFchTipoComissionado.quDiscRangeAfterEdit(DataSet: TDataSet);
begin
  inherited;

  quForm.Edit;

end;

procedure TFchTipoComissionado.quProfileAfterEdit(DataSet: TDataSet);
begin
  inherited;

  quForm.Edit;
  
end;

procedure TFchTipoComissionado.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;

  ProfileClose;
  DiscRangeClose;

end;

procedure TFchTipoComissionado.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  ProfileOpen;
  DiscRangeOpen;

end;

procedure TFchTipoComissionado.dsDiscRangeStateChange(Sender: TObject);
begin
  inherited;

  btAdd.Enabled := quDiscRange.Active;

  with quDiscRange do
    btRemove.Enabled := not (EOF AND BOF);

  btAdd.Visible    := not (quDiscRange.State in dsEditModes);
  btRemove.Visible := not (quDiscRange.State in dsEditModes);

  btPost.Visible       := (quDiscRange.State in dsEditModes);
  btCancelPost.Visible := (quDiscRange.State in dsEditModes);

end;

procedure TFchTipoComissionado.btPostClick(Sender: TObject);
begin
  inherited;

  DiscRangePost;
  DiscRangeRefresh;

end;

procedure TFchTipoComissionado.btCancelPostClick(Sender: TObject);
begin
  inherited;

  DiscRangeCancel;

end;

procedure TFchTipoComissionado.grdDiscRangeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) {and (grdDiscRange.FocusedField = quDiscRangePercDiscMax)} then
    btPostClick(nil);


end;

end.
