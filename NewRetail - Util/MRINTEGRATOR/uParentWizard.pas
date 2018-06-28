unit uParentWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, ImgList, siComp;

type
  TParentWizard = class(TForm)
    PTitle: TPanel;
    ShapeImage: TShape;
    lbEditName: TLabel;
    lbEditDescription: TLabel;
    ImageClass: TImage;
    Panel1: TPanel;
    BPrev: TButton;
    BNext: TButton;
    BClose: TButton;
    bvBottom: TBevel;
    pgOption: TPageControl;
    BHelp: TButton;
    imgSmall: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BPrevClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure UpdatePage;
    procedure InitForm;
  protected
    NoError   : Boolean;
    FTabList : TStringList;
    procedure OnAfterDoFinish; virtual;
    procedure OnBeforeBackClick; virtual;
    function DoFinish:Integer; virtual; abstract;
    function TestBeforeNavigate:Boolean; virtual;
    function OnAfterChangePage:Boolean; virtual;
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

{$R *.DFM}

procedure TParentWizard.OnBeforeBackClick;
begin

end;

procedure TParentWizard.OnAfterDoFinish;
begin

end;

function TParentWizard.OnAfterChangePage:Boolean;
begin
  Result := True;
end;

function TParentWizard.TestBeforeNavigate:Boolean;
begin
   Result := True;
end;

procedure TParentWizard.UpdatePage;
begin
  lbEditName.Caption := pgOption.ActivePage.Caption;
  lbEditDescription.Caption := pgOption.ActivePage.Hint;
end;

function TParentWizard.Start:Boolean;
begin

  InitForm;

  ShowModal;

  Result := NoError;

end;

procedure TParentWizard.InitForm;
var
  i : Integer;
begin

  pgOption.ActivePageIndex := 0;
  pgOption.Left := 0;
  pgOption.Top  := 41;
  UpdatePage;

  FTabList.Clear;

  for i:=0 to pgOption.PageCount-1 do
    FTabList.Add(IntToStr(pgOption.Pages[i].PageIndex));

  BNext.Caption := '&Next >';
  
end;

procedure TParentWizard.FormCreate(Sender: TObject);
begin
  inherited;
  FTabList := TStringList.Create;
end;

procedure TParentWizard.BCloseClick(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TParentWizard.BNextClick(Sender: TObject);
var
  index : integer;
begin
  inherited;

  if TButton(Sender).Caption = 'Finish' then
     begin
     DoFinish;
     OnAfterDoFinish;
     Close;
     Exit;
     end;

  if not TestBeforeNavigate then
     exit;

  index := pgOption.ActivePageIndex;

  if (FTabList.IndexOf(IntToStr(index))+1) = FTabList.Count-1 then
     TButton(Sender).Caption := 'Finish'
  else
     TButton(Sender).Caption := '&Next >';

  pgOption.ActivePageIndex := StrToInt(FTabList.Strings[FTabList.IndexOf(IntToStr(index))+1]);

  UpdatePage;

  OnAfterChangePage;

end;

procedure TParentWizard.BPrevClick(Sender: TObject);
begin
  inherited;

  if pgOption.ActivePageIndex = 0 then
     Exit;

  OnBeforeBackClick;

  pgOption.ActivePageIndex := StrToInt(FTabList.Strings[FTabList.IndexOf(IntToStr(pgOption.ActivePageIndex))-1]);

  BNext.Caption := '&Next >';

  UpdatePage;

end;

procedure TParentWizard.FormDestroy(Sender: TObject);
begin
  inherited;
  FTabList.Free;
end;

procedure TParentWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.


