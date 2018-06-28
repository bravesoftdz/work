unit uFrmModelPicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SubListPanel;

type
  TFrmModelPicture = class(TFrmParentAll)
    SubWebModel: TSubListPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(IDModel:String);
  end;

implementation

{$R *.dfm}

procedure TFrmModelPicture.Start(IDModel:String);
begin

  SubWebModel.Param := 'IDModel='+IDModel+';ShowOpen=1;BackColor=;StartImage=;Stretch=F';
  ShowModal;

end;

procedure TFrmModelPicture.FormCreate(Sender: TObject);
begin
  inherited;

  SubWebModel.CreateSubList;

end;

procedure TFrmModelPicture.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmModelPicture.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
