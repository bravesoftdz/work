unit WidgetDSIClientX;

interface
uses uCCMercuryIntegration;

type

   TWidgetDSIClientX = class(TCCWidget)
   public
     function creatDevice(): TDevice; override; 

   end;

implementation

end.
