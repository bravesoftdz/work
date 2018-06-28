unit uTerm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, dxTL, dxDBCtrl, dxDBGrid, dxCntner, StdCtrls,
  ExtCtrls;

type
  TTerm = class(TForm)
    Panel8: TPanel;
    Label14: TLabel;
    grdTerm: TdxDBGrid;
    grdTermDueDateShift: TdxDBGridMaskColumn;
    grdTermDiscount: TdxDBGridMaskColumn;
    btNew: TSpeedButton;
    btDelete: TSpeedButton;
    btPost: TSpeedButton;
    btCancelPost: TSpeedButton;
    quTerm: TQuery;
    quTermIDPessoa: TIntegerField;
    quTermDueDateShift: TIntegerField;
    quTermDiscount: TIntegerField;
    dsTerm: TDataSource;
    procedure btNewClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btCancelPostClick(Sender: TObject);
    procedure quTermNewRecord(DataSet: TDataSet);
    procedure dsTermStateChange(Sender: TObject);
    procedure grdTermKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    // Term
    procedure TermRefresh;
    procedure TermPost;
    procedure TermCancel;
    procedure TermOpen;
    procedure TermClose;

  public
    { Public declarations }
  end;

var
  Term: TTerm;

implementation

{$R *.DFM}

procedure TTerm.TermRefresh;
var
  iDueDateShift: integer;
begin
  iDueDateShift := quTermDueDateShift.AsInteger;
  TermClose;
  TermOpen;
  quTerm.Locate('DueDateShift', IntToStr(iDueDateShift), [] );
end;

procedure TTerm.TermOpen;
begin

  with quTerm do
    if not Active then
      Open;

end;

procedure TTerm.TermClose;
begin

  TermPost;

  quTerm.Close;

end;


procedure TTerm.TermPost;
begin

  with quTerm do
    if State in dsEditModes then
      Post;

end;

procedure TTerm.TermCancel;
begin

  with quTerm do
    if State in dsEditModes then
      Cancel;

end;


procedure TTerm.btNewClick(Sender: TObject);
begin
  inherited;
  quTerm.Insert;
  grdTerm.SetFocus;
  grdTerm.FocusedField := quTermDueDateShift;
end;

procedure TTerm.btDeleteClick(Sender: TObject);
begin
  inherited;
  quTerm.Delete;
  dsTermStateChange(Nil);
end;

procedure TTerm.dsTermStateChange(Sender: TObject);
begin
  inherited;

  btNew.Enabled := quTerm.Active;

  with quTerm do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quTerm.State in dsEditModes);
  btDelete.Visible := not (quTerm.State in dsEditModes);

  btPost.Visible := (quTerm.State in dsEditModes);
  btCancelPost.Visible := (quTerm.State in dsEditModes);

end;

procedure TTerm.quTermNewRecord(DataSet: TDataSet);
begin
  inherited;
  quTermIDLancamento.AsInteger := quFormIDLancamento.AsInteger;
  quTermDiscount.AsInteger := 0;
end;

procedure TTerm.btPostClick(Sender: TObject);
begin
  inherited;
  TermPost;
  TermRefresh;

end;

procedure TTerm.btCancelPostClick(Sender: TObject);
begin
  inherited;
  TermCancel;

end;

procedure TTerm.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (grdTerm.FocusedField = quTermDiscount) then
    btPostClick(nil);
end;


procedure TTerm.btNewClick(Sender: TObject);
begin
  quTerm.Insert;
  grdTerm.SetFocus;
  grdTerm.FocusedField := quTermDueDateShift;

end;

procedure TTerm.btDeleteClick(Sender: TObject);
begin
  quTerm.Delete;
  dsTermStateChange(Nil);

end;

procedure TTerm.btPostClick(Sender: TObject);
begin
  TermPost;
  TermRefresh;

end;

procedure TTerm.btCancelPostClick(Sender: TObject);
begin
  TermCancel;

end;

procedure TTerm.quTermNewRecord(DataSet: TDataSet);
begin

  quTermIDPessoa.AsInteger := quFormIDPessoa.AsInteger;
  quTermDiscount.AsInteger := 0;

end;

procedure TTerm.dsTermStateChange(Sender: TObject);
begin

  btNew.Enabled := quTerm.Active;

  with quTerm do
    btDelete.Enabled := not (EOF AND BOF);

  btNew.Visible := not (quTerm.State in dsEditModes);
  btDelete.Visible := not (quTerm.State in dsEditModes);

  btPost.Visible := (quTerm.State in dsEditModes);
  btCancelPost.Visible := (quTerm.State in dsEditModes);

end;

procedure TTerm.grdTermKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (grdTerm.FocusedField = quTermDiscount) then
    btPostClick(nil); 

end;

end.
