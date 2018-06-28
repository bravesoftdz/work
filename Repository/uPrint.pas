unit uPrint;

interface

uses classes, printers;

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
        fFontName   : String;
        fFontSize   : Integer;
      public
        Constructor Create;
        Destructor Destroy; override;

        procedure StartPrinter; override;          //Prepare Win printer to print
        procedure ClosePrinter; override;          //Close the Win printer
        procedure PrintText(Text:String);          //Send Text to the printer
        procedure SetStartPos(iPos : Integer);     //Set left margem
        procedure SetFontName(FontName : String);  //Update Font Name
        procedure SetFontSize(FontSize : Integer); //Update the size of the font
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
  fLine := fLine + 50;
end;

// ********* WINDOWS PRINTER END ************** //


end.
