unit uFinChoicerFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Buttons, ExtCtrls, ImgList, siComp, siLangRT;

Const

  CHOICE_DOCUMENT_TYPE = 1;

type
  TFinChoicerFrm = class(TParentDialogFrm)
    gbxMain: TGroupBox;
    rdChoice1: TRadioButton;
    rdChoice2: TRadioButton;
    lbChoice1: TLabel;
    lbChoice2: TLabel;
    imgChoice1: TImage;
    imgChoice2: TImage;
    imgList: TImageList;
    procedure rdChoice1Click(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    iResult : Integer;
    //TRanslation
    sWhatKind,
    sSingle,
    sSingleEx,
    sDisbur,
    sDisburEx : String;

    procedure setChoicerType(iChoicer:integer);

  public
    { Public declarations }
    function Start(ChoiceType:integer):integer;
  end;

implementation

uses uDMGlobal;

{$R *.DFM}

function TFinChoicerFrm.Start(ChoiceType:integer):integer;
begin
   //Start the form

   iResult := 1;

   setChoicerType(ChoiceType);

   ShowModal;

   Result := iResult;

end;

procedure TFinChoicerFrm.setChoicerType(iChoicer:integer);
begin

  Case iChoicer of

      CHOICE_DOCUMENT_TYPE :
                begin
                gbxMain.Caption := sWhatKind;

                //First choice
                rdChoice1.Caption := sSingle;
                lbChoice1.Caption := sSingleEx;
                imgList.GetBitmap(0, imgChoice1.Picture.Bitmap);

                //Secound choice
                rdChoice2.Caption := sDisbur;
                lbChoice2.Caption := sDisburEx;
                imgList.GetBitmap(1, imgChoice2.Picture.Bitmap);
                end;


  end;

end;

procedure TFinChoicerFrm.rdChoice1Click(Sender: TObject);
begin
  inherited;

  iResult := TRadioButton(Sender).Tag;
  
end;

procedure TFinChoicerFrm.btCancelClick(Sender: TObject);
begin
  inherited;

  iResult := -1;

end;

procedure TFinChoicerFrm.FormCreate(Sender: TObject);
begin
  inherited;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sWhatKind := 'What kind of document you want to create ?';
           sSingle   := 'Single';
           sSingleEx := 'Single document does not allow you to split a document. ' +
                        'Chose this option if the document does not have sub-documents.';
           sDisbur   := 'Disbursement';
           sDisburEx := 'Allows you to split a document. ' +
                        'The document can be splited into sub documents.';
           end;
    LANG_PORTUGUESE :
           begin
           sWhatKind := 'Que tipo de documento voçê deseja criar ?';
           sSingle   := 'Simples';
           sSingleEx := 'Documento simples não permite que voçê crie parcelas. ' +
                        'Selecione esta opção se o documento não tiver parcelas.';
           sDisbur   := 'Desdobramento';
           sDisburEx := 'Permite que voçê crie parcelas. ' +
                        'O documento pode ser sub-dividido em várias parcelas.';
           end;

    LANG_SPANISH :
           begin
           sWhatKind := 'Qué tipo de documento desea crear ?';
           sSingle   := 'Unico';
           sSingleEx := 'Documento único no le permite fraccionar un documento. ' +
                        'Escoja esta opción si el documento no tiene sub-documentos.';
           sDisbur   := 'Fraccionamiento';
           sDisburEx := 'Le permite fraccionar un documento. ' +
                        'El documento puede ser fraccionado en varios documentos a la vez.';
           end;
  end;

end;

end.
