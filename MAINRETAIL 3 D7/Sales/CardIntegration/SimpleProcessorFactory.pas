unit SimpleProcessorFactory;

interface
uses ProcessorInterface, MercuryProcessor, WorldPayProcessor, uSystemConst;

type
	TProcessorFactory = class
	public
		function CreateProcessor(arg_processorIndex: Integer): IProcessor;
	end;

implementation

function TProcessorFactory.CreateProcessor(arg_processorIndex: Integer): IProcessor;
begin
	case arg_processorIndex of
		PROCESSOR_MERCURY: result := TMercuryProcessor.create(); 
		
		PROCESSOR_WORLDPAY: result := TWorldPayProcessor.Create();
		
		//... to future processors...
		
	end;
end;

end.
