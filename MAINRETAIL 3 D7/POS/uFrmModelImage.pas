unit uFrmModelImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, ExtCtrls, DB, ADODB, Buttons,
  StdCtrls, ExtDlgs, uParentAll;

type
  TSubModelImage = class(TFrmParentAll)
    imgItem: TImage;
    quModelImage: TADODataSet;
    quModelImageLargeImage: TStringField;
    Bevel1: TBevel;
    pnlButtom: TPanel;
    hhh: TPanel;
    btClose: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    fLargeImagePath : String;
    fIDModel  : Integer;
    procedure LoadImage;
    procedure SetImage;
    procedure RefreshImage;
    procedure DataSetRefresh;
    procedure DataSetOpen;
    procedure DataSetClose;
  protected
  public
    { Public declarations }
    procedure Start(IDModel:String);
  end;

implementation

uses uDM, uParamFunctions;

{$R *.dfm}

procedure TSubModelImage.LoadImage;
begin

  If FileExists(fLargeImagePath) then
     imgItem.Picture.LoadFromFile(fLargeImagePath)
  else
     imgItem.Picture := nil; 

end;

procedure TSubModelImage.RefreshImage;
begin
  SetImage;
  LoadImage;
end;


procedure TSubModelImage.Start(IDModel:String);
var
 fStartImage : String;
 fColor      : String;
begin

  fIDModel := StrToInt(IDModel);

  DataSetRefresh;

  RefreshImage;

  ShowModal;
  
end;

procedure TSubModelImage.DataSetRefresh;
begin
   DataSetClose;
   DataSetOpen;
end;

procedure TSubModelImage.SetImage;
begin
   fLargeImagePath  := quModelImageLargeImage.AsString;
end;

procedure TSubModelImage.DataSetOpen;
begin

  with quModelImage do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := fIDModel;
        Open;
        end;

end;

procedure TSubModelImage.DataSetClose;
begin

  with quModelImage do
     if Active then
        Close;
        
end;


procedure TSubModelImage.FormDestroy(Sender: TObject);
begin
  inherited;
  DataSetClose;
end;

procedure TSubModelImage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSubModelImage.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
