unit uParentWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, ImgList, siComp;

type
  TUpdatePage = (upFirst, upBack, upNext);

  TParentWizard = class(TForm)
    PTitle: TPanel;
    ShapeImage: TShape;
    lbEditName: TLabel;
    lbEditDescription: TLabel;
    ImageClass: TImage;
    Panel1: TPanel;
    btBack: TButton;
    btNext: TButton;
    btClose: TButton;
    pgOption: TPageControl;
    btHelp: TButton;
    imgSmall: TImageList;
    bvBottom: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btBackClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    procedure UpdateButtons;
    procedure UpdatePage(AUpdatePage: TUpdatePage);
  protected
    FLogError: TStringList;
    FTabList: TStringList;

    procedure OnAfterDoFinish; virtual;
    procedure OnBeforeBackClick; virtual;
    function DoFinish: Integer; virtual; abstract;
    function TestBeforeNavigate: Boolean; virtual;
    function OnAfterChangePage: Boolean; virtual;
    function OnBeforeNextClick : Boolean; virtual;
  public
    function Start: Boolean; virtual;
    property LogError: TStringList read FLogError write FLogError;
  end;

implementation

{$R *.DFM}

procedure TParentWizard.OnBeforeBackClick;
begin
  // para ser herdado
end;

procedure TParentWizard.OnAfterDoFinish;
begin
  // para ser herdado
end;

function TParentWizard.OnAfterChangePage: Boolean;
begin
  Result := True;
end;

function TParentWizard.TestBeforeNavigate: Boolean;
begin
   Result := True;
end;

procedure TParentWizard.UpdatePage(AUpdatePage: TUpdatePage);
var
  i, iPage : Integer;
begin
  with pgOption do
  begin
    iPage := 0;
    case AUpdatePage of
      upFirst: ActivePageIndex := 0;
      upBack: begin
                for i := (ActivePageIndex-1) downto 0 do
                begin
                  inc(iPage);
                  if pgOption.Pages[i].TabVisible then
                  begin
                    ActivePageIndex := ActivePageIndex - iPage;
                    Break;
                  end;
                end;
              end;
      upNext: begin
                for i := (ActivePageIndex+1) to pgOption.PageCount-1 do
                begin
                  inc(iPage);
                  if pgOption.Pages[i].TabVisible then
                  begin
                    ActivePageIndex := ActivePageIndex + iPage;
                    Break;
                  end;
                end;
              end;
    end;

    lbEditName.Caption := ActivePage.Caption;
    lbEditDescription.Caption := ActivePage.Hint;
  end;
end;

function TParentWizard.Start: Boolean;
var
  iPageIndex: Integer;
begin
  pgOption.Left := 0;
  pgOption.Top  := 41;
  UpdatePage(upFirst);
  UpdateButtons;
  FTabList.Clear;

  for iPageIndex := 0 to Pred(pgOption.PageCount) do
    FTabList.Add(IntToStr(pgOption.Pages[iPageIndex].PageIndex));

  ShowModal;
  Result := FLogError.Text <> '';
end;

procedure TParentWizard.FormCreate(Sender: TObject);
begin
  inherited;
  FLogError := TStringList.Create;
  FTabList := TStringList.Create;
end;

procedure TParentWizard.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TParentWizard.btNextClick(Sender: TObject);
begin
  inherited;

  OnBeforeNextClick;

  if pgOption.ActivePageIndex = Pred(pgOption.PageCount) then
  begin
    DoFinish;
    OnAfterDoFinish;
    Close;
  end
  else if TestBeforeNavigate then
  begin
    UpdatePage(upNext);
    UpdateButtons;
    OnAfterChangePage;
  end;

end;

procedure TParentWizard.btBackClick(Sender: TObject);
begin
  inherited;
  OnBeforeBackClick;
  UpdatePage(upBack);
  UpdateButtons;
end;

procedure TParentWizard.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLogError);
  FreeAndNil(FTabList);
  inherited;
end;

procedure TParentWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TParentWizard.UpdateButtons;
var
  bFirstPage, bLastPage: Boolean;
begin
  bFirstPage := pgOption.ActivePageIndex = 0;
  bLastPage := pgOption.ActivePageIndex = Pred(pgOption.PageCount);

  btBack.Enabled := (not bFirstPage) and (not bLastPage);
  if bLastPage then
    btNext.Caption := '&Finish'
  else
    btNext.Caption := '&Next >';
end;

function TParentWizard.OnBeforeNextClick: Boolean;
begin
  //
end;

end.
