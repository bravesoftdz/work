unit AdjustQtyReasonUpsertView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,  AdjustReasonCls;

type
  TvwAdjustQtyReasonUpsert = class(TForm)
    pnBottom: TPanel;
    bbtnAdd: TBitBtn;
    btnCancel: TBitBtn;
    lblReason: TLabel;
    edtReason: TEdit;
    chkHidden: TCheckBox;
    chkSystem: TCheckBox;
    chkActive: TCheckBox;
    procedure bbtnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    reason: TAdjustReason;
    isInsert: Boolean;
    procedure MsgResultCmd();
    procedure ClearScreen();
    procedure MoveScreenToObject();
    procedure MoveObjectToScreen();
  public
    { Public declarations }
    function Start(argId: Integer): Boolean;
  end;

var
  vwAdjustQtyReasonUpsert: TvwAdjustQtyReasonUpsert;

implementation
{$R *.dfm}
uses uDM;

{ TForm1 }

function TvwAdjustQtyReasonUpsert.Start(argId: Integer): Boolean;
begin
   self.isInsert := ( argId = 0 );

   if ( not self.isInsert ) then begin
      Caption := 'Update Reason';
      reason := dm.ReadReason(argId);
      MoveObjectToScreen()
   end else begin
          Caption := 'Insert Reason';
          reason := TAdjustReason.Create();
       end;

   result := ( ShowModal = mrOK );
end;

procedure TvwAdjustQtyReasonUpsert.bbtnAddClick(Sender: TObject);
begin
   try
       MoveScreenToObject();
       if ( self.isInsert ) then begin
          dm.CreateReason(self.reason);
          ClearScreen();
       end else begin
                dm.UpdateReason(self.reason);
           end;
      MsgResultCmd()
   except
      on
      e: Exception do begin
         raise e.Create('Failed to save record ' + e.Message);
      end;
   end;


end;

procedure TvwAdjustQtyReasonUpsert.MsgResultCmd();
begin
   if ( self.isInsert ) then begin
      ShowMessage('Successfully inserted!');
   end else begin
          ShowMessage('Successfully updated!');
       end;
end;

procedure TvwAdjustQtyReasonUpsert.ClearScreen;
begin
   edtReason.Clear();
   chkHidden.Checked := FALSE;
   chkSystem.Checked := FALSE;
   chkActive.Checked := FALSE;

end;

procedure TvwAdjustQtyReasonUpsert.MoveObjectToScreen();
begin
   edtReason.Text := reason.Reason;
   chkHidden.Checked := reason.Hidden = 1;
   chkSystem.Checked := reason.System = 1;
   chkActive.Checked := reason.Activated = 1;
end;

procedure TvwAdjustQtyReasonUpsert.MoveScreenToObject();
begin
   reason.Reason := edtReason.Text;

   reason.Hidden := 0;
   reason.System := 0;
   reason.Activated := 0;

   if ( chkHidden.Checked ) then begin
      reason.Hidden := 1;
   end;

   if ( chkSystem.Checked ) then begin
      reason.System := 1;
   end;

   if ( chkActive.Checked ) then begin
      reason.Activated := 1;
   end;
   
end;

procedure TvwAdjustQtyReasonUpsert.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( reason <> nil ) then begin
     FreeAndNil(reason);
  end;
end;

end.
