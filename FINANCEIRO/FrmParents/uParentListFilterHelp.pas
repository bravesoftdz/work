unit uParentListFilterHelp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Buttons, ExtCtrls, siComp, siLangRT;

type
  TParentListFilterHelp = class(TParentDialogFrm)
    Panel1: TPanel;
    Label3: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TParentListFilterHelp.btOkClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TParentListFilterHelp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;




end.
