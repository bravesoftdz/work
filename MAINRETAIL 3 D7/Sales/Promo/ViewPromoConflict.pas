unit ViewPromoConflict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, contnrs, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient;

type
  TvwPromoConflict = class(TForm)
    lbTagSelected: TLabel;
    lbModelsToTagSelected: TLabel;
    Label1: TLabel;
    cxGridModelsInTagDBTableView1: TcxGridDBTableView;
    cxGridModelsInTagLevel1: TcxGridLevel;
    cxGridModelsInTag: TcxGrid;
    btnFixTagConfllict: TButton;
    btnSolvePromoConflict: TButton;
    dsModels: TDataSource;
    cxGridModelsInTagDBTableView1DBColumn1: TcxGridDBColumn;
    cxGridModelsInTagDBTableView1DBColumn2: TcxGridDBColumn;
    cxGridModelsInTagDBTableView1DBColumn3: TcxGridDBColumn;
    cxGridModelsInTagDBTableView1DBColumn4: TcxGridDBColumn;
    cxGridTagConflict: TcxGrid;
    cxGridDBTagConflict: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridPromoConfict: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    dsPromoConflict: TDataSource;
    dsTagConflict: TDataSource;
    cxGridDBTableView1DBColumn1: TcxGridDBColumn;
    cxGridDBTableView1DBColumn2: TcxGridDBColumn;
    procedure btnFixTagConfllictClick(Sender: TObject);
    procedure btnSolvePromoConflictClick(Sender: TObject);
  private
    { Private declarations }
    FIdModelListOnInsert: String;
    FPKTagModelListFromTagConflict: String;
    FPKTagModelListFromPromoConflict: String;

    procedure FillTagListGrid(idModelListOnInsert: String; idTagListConflict: String);
    procedure FillPromoListGrid(idModelListOnInsert: String; promoListConflict: TObjectList);

  public
    { Public declarations }
    FIsConflictFixed: Boolean;
    function Start(idTagOnInsert: Integer; idModelListOnInsert: String; idTagListConflict: String;
                   promoListConflict: TObjectList; var IsFixed: Boolean): Boolean;
  end;

var
  vwPromoConflict: TvwPromoConflict;

implementation
uses uDM, PromoDTO;

{$R *.dfm}

{ TvwPromoConflict }
procedure TvwPromoConflict.FillPromoListGrid(idModelListOnInsert: String; promoListConflict: TObjectList);
begin
  dsPromoConflict.dataset := dm.SeekForConflictOnPromo(promoListConflict, idModelListOnInsert, 1);

  while ( not dsPromoConflict.DataSet.eof ) do begin
      if ( self.FPKTagModelListFromPromoConflict = '' ) then begin
          self.FPKTagModelListFromPromoConflict := dsPromoConflict.DataSet.fieldByName('PKTagModel').AsString;
      end else begin
             self.FPKTagModelListFromPromoConflict := self.FPKTagModelListFromPromoConflict + ',' +
                                               dsPromoConflict.DataSet.fieldByName('PKTagModel').AsString;
          end;

      dsPromoConflict.DataSet.Next;
  end;
  dsPromoConflict.DataSet.EnableControls;

end;

procedure TvwPromoConflict.FillTagListGrid(idModelListOnInsert: String; idTagListConflict: String);
begin
  dsTagConflict.dataset := dm.SeekForConflictOnTag(idTagListConflict, idModelListOnInsert, 1);

  dsTagConflict.dataset.disableControls;
  while ( not dsTagConflict.Dataset.eof ) do begin
      if ( self.FPKTagModelListFromTagConflict = '' ) then begin
          self.FPKTagModelListFromTagConflict := dsTagConflict.DataSet.fieldByName('PKTagModel').AsString;
      end else begin
             self.FPKTagModelListFromTagConflict := self.FPKTagModelListFromTagConflict + ',' +
                                               dsTagConflict.DataSet.fieldByName('PKTagModel').AsString;
          end;

      dsTagConflict.DataSet.Next;
  end;
  dsTagConflict.DataSet.EnableControls;

end;

function TvwPromoConflict.Start(idTagOnInsert: Integer; idModelListOnInsert: String; idTagListConflict: String;
  promoListConflict: TObjectList; var IsFixed: Boolean): Boolean;
begin
  self.FIdModelListOnInsert := idModelListOnInsert;

  self.Caption := 'Tag Selected: '+ IntToStr(idTagOnInsert);
  dsModels.DataSet := dm.GetModelsFromTagModel(IntToStr(idTagOnInsert));

  if ( idTagListConflict <> '' ) then begin
     FillTagListGrid(idModelListOnInsert, idTagListConflict);
  end;

  if ( promoListConflict.count > 0 ) then begin
     FillPromoListGrid(idModelListOnInsert, promoListConflict);
  end;
  
  result := ShowModal = mrOK;

  IsFixed := FIsConflictFixed;

end;


procedure TvwPromoConflict.btnFixTagConfllictClick(Sender: TObject);
begin
   try
     dm.ActivateTagModelByPK(FPKTagModelListFromTagConflict);
     Self.FIsConflictFixed := TRUE;
   except
     on e:Exception do begin
        self.FIsConflictFixed := FALSE;
        raise e.Create('Cannot disable models in conflict to Tags: '+e.Message);
     end;
   end;
end;

procedure TvwPromoConflict.btnSolvePromoConflictClick(Sender: TObject);
begin
   try
     if ( length(FPKTagModelListFromTagConflict) > 0 ) then begin
        btnFixTagConfllictClick(sender);
     end;

     if ( length(FPKTagModelListFromPromoConflict) > 0 ) then begin
         dm.ActivateTagModelByPK(FPKTagModelListFromPromoConflict);
         ShowMessage('Promo Conflicts fixed.');
         self.FIsConflictFixed := self.FIsConflictFixed or TRUE;
     end;

     dsTagConflict.DataSet.Refresh;
     dsPromoConflict.DataSet.Refresh;

   except
     on e:Exception do begin
        self.FIsConflictFixed := Self.FIsConflictFixed or FALSE;
        raise e.Create('Cannot disable models in conflict to Promos: '+e.Message);
     end;
   end;
end;

end.
