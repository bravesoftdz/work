unit AdjustQtyReasonView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, contnrs;

type
  TvwAdjustReason = class(TForm)
    pnTop: TPanel;
    pnBottom: TPanel;
    stgReason: TStringGrid;
    bbtnAdd: TBitBtn;
    procedure stgReasonDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stgReasonSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure bbtnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    reasons: TObjectList;

    procedure LoadHeader();
    procedure LoadReasons();
    procedure RefreshInfo();
    procedure CallReasonUpsert(argIsDelete: Boolean; argId: Integer);
  public
    { Public declarations }
    function Start(): Boolean;
  end;

var
  vwAdjustReason: TvwAdjustReason;

implementation
uses uDM, AdjustReasonCls, AdjustQtyReasonUpsertView;

{$R *.dfm}

{ TvwAdjustReason }

procedure TvwAdjustReason.LoadHeader;
var
   i: Integer;
begin
   stgReason.FixedRows := 1;

   stgReason.Cells[1, 0] := 'Reason';
   stgReason.ColWidths[1] := 200;
   stgReason.Cells[2, 0] := 'Hidden';
   stgReason.Cells[3, 0] := 'System';
   stgReason.Cells[4, 0] := 'Activated';
   stgReason.Cells[5, 0] := ' ';
   stgReason.Cells[6, 0] := ' ';

end;

procedure TvwAdjustReason.LoadReasons();
var
   i: Integer;
begin
   reasons := dm.ReadAllReason();
   stgReason.RowCount := 1;
   for i:= 0 to reasons.Count - 1 do begin
       stgReason.RowCount := stgReason.RowCount + 1;
       stgReason.Cells[0, i+1] := IntToStr(TAdjustReason(reasons.Items[i]).Id);
       stgReason.Cells[1, i+1] := TAdjustReason(reasons.Items[i]).Reason;

       stgReason.Cells[2, i+1] := InttoStr(TAdjustReason(reasons.Items[i]).Hidden);
       stgReason.Cells[3, i+1] := IntToStr(TAdjustReason(reasons.Items[i]).System);
       stgReason.Cells[4, i+1] := IntToStr(TAdjustReason(reasons.Items[i]).Activated);
       stgReason.Cells[5, i+1] := 'Update';
       stgReason.Cells[6, i+1] := 'Delete';

   end;
   pnBottom.Caption := format('records: %d',[(reasons.Count)]);


end;

function TvwAdjustReason.Start: Boolean;
begin
    LoadHeader();
    LoadReasons();
    result := ShowModal = mrOK;
end;

procedure TvwAdjustReason.stgReasonDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  canvas: TCanvas;
begin
     canvas := stgReason.Canvas;
     if ( ARow = 0 ) then begin
        canvas.Brush.Color := clBtnFace;
        canvas.Font.Color := clBlack;
        canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, stgReason.Cells[Acol, Arow]);
     end;



     if ( (ARow > 0) and (ACol > 0) ) then begin
         if ( Acol = 5 ) then begin
            canvas.Font.Color := clGreen;
            canvas.Font.Style := [fsBold];
            canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, stgReason.Cells[Acol, Arow]);
         end;

         if ( Acol = 6 ) then begin
            canvas.Font.Color := clRed;
            canvas.Font.Style := [fsBold];

            canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, stgReason.Cells[Acol, Arow]);
         end;
     end;
end;

procedure TvwAdjustReason.stgReasonSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
   view: TvwAdjustQtyReasonUpsert;
begin
   if ( ARow > 0 ) then begin
       if ( ACol = 5 ) then begin
           CallReasonUpsert(FALSE, StrToInt(stgReason.Cells[0, ARow]));
           RefreshInfo();
       end else if ( ACol = 6 ) then begin
               dm.DeleteReason(StrToInt(stgReason.Cells[0, Arow]));
               RefreshInfo();
           end;
   end;
end;

procedure TvwAdjustReason.bbtnAddClick(Sender: TObject);
begin
   CallReasonUpsert(False, 0);
   RefreshInfo();  
end;

procedure TvwAdjustReason.RefreshInfo;
begin
   FreeAndNil(reasons);
   LoadReasons();
end;

procedure TvwAdjustReason.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( reasons <> nil ) then begin
      FreeAndNil(reasons);
  end;
end;

procedure TvwAdjustReason.CallReasonUpsert(argIsDelete: Boolean; argId: Integer);
var
   view: TvwAdjustQtyReasonUpsert;
begin
   try
       if ( not argIsDelete ) then begin
          view := TvwAdjustQtyReasonUpsert.Create(nil);
          view.Start(argId);
       end;
   finally
       FreeAndNil(view);
   end;
end;

end.
