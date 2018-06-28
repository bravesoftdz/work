unit uTEFTypes;

interface

type
  TVinculadoInfo = class
     CupomVinculado: String;
     FormaPagamento: String;
     IDMeioPag:      Integer;
     ValorAprovado: Currency;
     NumeroParcelas : Integer;
     PreDatado: TDateTime;
     PreDatadoComGarantia : Boolean;
  end;

  TTEFCallInfo = class
   PostDate : Boolean;
   IsMagnetico : Boolean;
   UsaCDC : Boolean;
   UsaPreAutorizacao : Boolean;
   Bandeira : Integer;
   TipoTEF : Integer;
  end;

  TTEFDialMessageType = (mtOperador, mtCliente, mtPendencia, mtAtividade, mtInatividade);

  TTEFPrintEvent              = procedure(Sender: TObject; var Printed: Boolean) of object;
  TTEFDialMessageEvent        = procedure(Sender: TObject; MessageType: TTEFDialMessageType = mtOperador; NeedUserOK: Boolean = True) of object;
  TTEFNeedOpenPrintVinculado  = procedure(Sender: TObject; AVinculadoInfo: TVinculadoInfo; var Opened: Boolean) of object;
  TTEFNeedOpenPrint           = procedure(Sender: TObject; var Opened: Boolean) of object;
  TTEFNeedClosePrint          = procedure(Sender: TObject; var Closed: Boolean) of object;
  TTEFNeedPrintLine           = procedure(Sender: TObject; LineToPrint: String; var LinePrinted: Boolean) of object;
  TTEFTryAgainDialog          = procedure(Sender: TObject; var TryAgain: Boolean) of object;
  TTEFStatusPrinter           = procedure(Sender: TObject; var Online: Boolean) of object;
  TTEFPerguntaCupom           = procedure(Sender: TObject; var TemCupom: Boolean) of object;

  TExecutaComandoMsg          = procedure(Sender: TObject; Msg: String) of Object;
  TExecutaComando             = procedure(Sender: TObject) of Object;



implementation

end.
