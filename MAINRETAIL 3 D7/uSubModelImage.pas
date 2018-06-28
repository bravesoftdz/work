unit uSubModelImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, ExtCtrls, DB, ADODB, Buttons,
  StdCtrls, ExtDlgs;

type
  TSubModelImage = class(TParentSub)
    pnlImgPath: TPanel;
    imgItem: TImage;
    quModelImage: TADODataSet;
    quModelImageLargeImage: TStringField;
    edtLargeImage: TEdit;
    sbOpenFile: TSpeedButton;
    OP: TOpenPictureDialog;
    Label1: TLabel;
    ImageBevel: TBevel;
    quModelImageLargeImage2: TStringField;
    sbRemove: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbOpenFileClick(Sender: TObject);
    procedure sbRemoveClick(Sender: TObject);
  private
    { Private declarations }
    fLargeImagePath : String;
    fImageNum : Integer;

    fIDModel  : Integer;
    procedure LoadImage;
    procedure SetImage;
    procedure RefreshImage;
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uParamFunctions;

{$R *.dfm}

procedure TSubModelImage.LoadImage;
begin

  If (fLargeImagePath<>'') and FileExists(fLargeImagePath) then
     begin
     imgItem.Picture.LoadFromFile(fLargeImagePath);
     end
  else
     begin
     imgItem.Picture := nil;
     end;

end;

procedure TSubModelImage.RefreshImage;
begin
  SetImage;
  LoadImage;
end;


procedure TSubModelImage.AfterSetParam;
var
 fStartImage : String;
 fColor      : String;
begin

  if FParam = '' then
     Exit;

  fIDModel           := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
  fStartImage        := ParseParam(FParam, 'StartImage');
  pnlImgPath.Visible := (StrToIntDef(ParseParam(FParam, 'ShowOpen'),0)=1);
  fColor             := ParseParam(FParam, 'BackColor');
  imgItem.Stretch    := (ParseParam(FParam, 'Stretch')='T');
  fImageNum          := (StrToIntDef(ParseParam(FParam, 'ImageNum'),1));
  ImageBevel.Visible := not (ParseParam(FParam, 'Bevel')='F');

  if fColor <> '' then
     Self.Color := StringToColor(fColor);

  if fStartImage <> '' then
     begin
     fLargeImagePath := fStartImage;
     LoadImage;
     Exit;
     end;

  DataSetRefresh;

  RefreshImage;
  
end;

procedure TSubModelImage.DataSetRefresh;
begin
   DataSetClose;
   DataSetOpen;
end;

procedure TSubModelImage.SetImage;
begin
   case fImageNum of
    1 : fLargeImagePath := quModelImageLargeImage.AsString;
    2 : fLargeImagePath := quModelImageLargeImage2.AsString;
    else fLargeImagePath := quModelImageLargeImage.AsString;
   end;
   edtLargeImage.Text := fLargeImagePath;
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


procedure TSubModelImage.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_OPEN,sbOpenFile.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE,sbRemove.Glyph);
//  SetButtonOpenEnabled(True);
//  SetButtonRemoveEnabled(True);
end;

procedure TSubModelImage.FormDestroy(Sender: TObject);
begin
  inherited;
  DataSetClose;
end;

procedure TSubModelImage.sbOpenFileClick(Sender: TObject);
begin
  inherited;
  if OP.Execute then
     with quModelImage do
       if Active then
          begin
          Edit;
          case fImageNum of
           1 : quModelImageLargeImage.AsString  := OP.FileName;
           2 : quModelImageLargeImage2.AsString := OP.FileName;
           else quModelImageLargeImage.AsString  := OP.FileName;
          end;
          Post;
          RefreshImage;
          end;
end;

procedure TSubModelImage.sbRemoveClick(Sender: TObject);
begin
  inherited;
     with quModelImage do
       if Active then
          begin
          Edit;
          case fImageNum of
           1 : quModelImageLargeImage.AsString  := '';
           2 : quModelImageLargeImage2.AsString := '';
           else quModelImageLargeImage.AsString := '';
          end;
          Post;
          RefreshImage;
          end;
end;

initialization
   RegisterClass(TSubModelImage);

end.
