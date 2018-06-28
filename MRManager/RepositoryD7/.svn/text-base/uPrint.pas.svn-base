unit uPrint;

interface

uses classes, printers, Windows;

Const
  PORT_LPT1 = 1;
  PORT_LPT2 = 2;
  PORT_WIN  = 3;

Type

   TPrinterDefaultClass = Class
      public
        procedure StartPrinter; virtual; abstract;
        procedure ClosePrinter; virtual; abstract;
   end;


  TLPTPrinter = Class(TPrinterDefaultClass)
     private
        fTextToPrint : TextFile;
        fPort        : String;
     public
        Constructor Create;
        Destructor Destroy; override;

        procedure StartPrinter; override;    //Assign the text file to the port
        procedure ClosePrinter; override;   //Close text file
        procedure PrintlnText(Text:String); //Send text to be printed Writeln
        procedure PrintText(Text:String);   //Send text to be printed Write

        procedure SetPort(Port:String);     //Set port to print
        function GetPort:String;            //Return actual port
      end;

   TWindowsPrinter = Class(TPrinterDefaultClass)
      private
        fStartPos   : Integer;
        fLine       : Integer;
        fLineSpace  : Integer;
        fFontName   : String;
        fFontSize   : Integer;
        FPrinterName: String;
    procedure SetPrinterName(const Value: String);
    procedure ResetPage;
      public
        Constructor Create;
        Destructor Destroy; override;

        property PrinterName: String read FPrinterName write SetPrinterName;

        procedure StartPrinter; override;          //Prepare Win printer to print
        procedure ClosePrinter; override;          //Close the Win printer
        procedure PrintText(Text:String);          //Send Text to the printer
        procedure SetStartPos(iPos : Integer);     //Set left margem
        procedure SetFontName(FontName : String);  //Update Font Name
        procedure SetLineSpace(LineSpace:Integer); //Update space between lines
        procedure SetFontSize(FontSize : Integer); //Update the size of the font
        procedure SendCommand(aPrinterCommands: String);
      end;

implementation

uses Sysutils;

// ********* LPT PRINTER BEGIN ************** //

Constructor TLPTPrinter.Create;
begin
  inherited Create;
end;

Destructor TLPTPrinter.Destroy;
begin
  inherited Destroy;
end;

procedure TLPTPrinter.SetPort(Port:String);
begin
  fPort := Port;
end;

function TLPTPrinter.GetPort:String;
begin
  Result := fPort;
end;

procedure TLPTPrinter.StartPrinter;
begin
   AssignFile(fTextToPrint, fPort);
   Rewrite(fTextToPrint);
end;

procedure TLPTPrinter.ClosePrinter;
begin
   CloseFile(fTextToPrint);
end;

procedure TLPTPrinter.PrintlnText(Text:String);
begin
  Writeln(fTextToPrint, Text);
end;

procedure TLPTPrinter.PrintText(Text:String);
begin
  Writeln(fTextToPrint, Text);
end;

// ********* LPT PRINTER END ************** //


// ********* WINDOWS PRINTER BEGIN ************** //

Constructor TWindowsPrinter.Create;
begin
  inherited Create;
  fFontName   := 'Courier New';
  fFontSize   := 10;
  fLineSpace  := 50;
end;

Destructor TWindowsPrinter.Destroy;
begin
  inherited Destroy;
end;

procedure TWindowsPrinter.SetStartPos(iPos : Integer);
begin
  fStartPos := iPos;
end;

procedure TWindowsPrinter.SetFontName(FontName : String);
begin
  fFontName := FontName;
end;

procedure TWindowsPrinter.SetFontSize(FontSize : Integer);
begin
  fFontSize := FontSize;
end;

procedure TWindowsPrinter.SetLineSpace(LineSpace:Integer);
begin
  fLineSpace := LineSpace;
end;

procedure TWindowsPrinter.StartPrinter;
begin
  Printer.BeginDoc;
  fLine := 1;
  Printer.canvas.Font.Name := fFontName;
  Printer.canvas.Font.Size := fFontSize;
end;

procedure TWindowsPrinter.ClosePrinter;
begin
  Printer.EndDoc;
  fLine := 1;
end;

procedure TWindowsPrinter.PrintText(Text:String);
begin
  Printer.Canvas.TextOut(fStartPos, fLine, Text);
  if ((fLine + fLineSpace) >= Printer.PageHeight) then
    ResetPage
  else
    fLine := fLine + fLineSpace;
end;

procedure TWindowsPrinter.ResetPage;
begin
  fLine := 1;
  Printer.NewPage;
end;

// ********* WINDOWS PRINTER END ************** //


procedure TWindowsPrinter.SetPrinterName(const Value: String);
var
  idx: Integer;
begin
  if (FPrinterName <> Value) then
  begin
    idx := Printer.Printers.IndexOf(Value);
    if idx >= 0 then
      begin
        Printer.PrinterIndex := idx;
        FPrinterName := Value;
      end
    else
      Raise Exception.CreateFmt('Printer %S not found', [Value]);
  end;
end;

procedure TWindowsPrinter.SendCommand(aPrinterCommands: String);
type
  TppEscapeDataRec = packed record
    DataLen: Word;
    DataBuf: Array [0..128] of Char;
  end;

var
  lEscapeDataRec: TppEscapeDataRec;
begin

  // setup the data
  lEscapeDataRec.DataLen := Length(aPrinterCommands);

  StrLCopy(lEscapeDataRec.DataBuf, PChar(aPrinterCommands), 128);

  // Windows API Escape call
  Escape(Printer.Canvas.Handle, PASSTHROUGH, 0, @lEscapeDataRec, nil);

end;

end.
