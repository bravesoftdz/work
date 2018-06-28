unit MRPuppySchedule;

interface
uses classes, MRPuppyIntegrationsCls;

type
   TPuppySchedule = class(TThread)
   private


   protected
   procedure execcute; override;
   procedure ImportPuppy; virtual;

   public
   constructor create;



end;

implementation

end.
