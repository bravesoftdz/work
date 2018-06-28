unit uFrmSelectDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, siComp, StdCtrls, Mask, DateBox, Buttons, ExtCtrls;

type
  TfrmSelectDate = class(TForm)
    edtDate: TDateBox;
    lblDate: TLabel;
    siLang: TsiLang;
    Panel1: TPanel;
    Bevel1: TBevel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(var SelectedDate: TDateTime): Boolean;
  end;

var
  frmSelectDate: TfrmSelectDate;

implementation

{$R *.dfm}

procedure TfrmSelectDate.FormShow(Sender: TObject);
begin
  edtDate.Date := Date;
end;

function TfrmSelectDate.Start(var SelectedDate: TDateTime): Boolean;
begin
  Showmodal;
  Result := ModalResult = mrOK;
  if Result then
    SelectedDate := Trunc(edtDate.Date);
end;

procedure TfrmSelectDate.btnCancelClick(Sender: TObject);
begin
   Close;
end;

end.
