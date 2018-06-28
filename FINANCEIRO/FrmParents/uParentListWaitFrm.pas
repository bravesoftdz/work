unit uParentListWaitFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, StdCtrls, ComCtrls, ExtCtrls, siComp, siLangRT;

type
  TParentListWaitFrm = class(TParentAllFrm)
    aviWait: TAnimate;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TParentListWaitFrm.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := Application.Title;
end;

procedure TParentListWaitFrm.FormCreate(Sender: TObject);
begin
  inherited;
  with aviWait do
    begin
      ResName := 'IDS_AVI_SQLWAIT';
      ResHandle := hInstance;
      Active := True;
    end;
end;

end.
