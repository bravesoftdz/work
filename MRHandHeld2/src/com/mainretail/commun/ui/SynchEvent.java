package com.mainretail.commun.ui;

public class SynchEvent {
	
	public static final int EVT_INITIALIZATION = 0;
	public static final int EVT_POSITION = 1;
	public static final int EVT_FINISH = 2;
	public static final int EVT_ERROR = 3;	
	public static final int EVT_EXCEPTION = 4;
	public static final int EVT_HANDLE_DATA = 5;
	public static final int EVT_DEFRAG = 6;
	public static final int EVT_REMOVE_BACKUP = 7;
	
	public static final SynchEvent SYNCH_INITIALIZATION	= new SynchEvent(EVT_INITIALIZATION);
	public static final SynchEvent SYNCH_POSITION		= new SynchEvent(EVT_POSITION);
	public static final SynchEvent SYNCH_FINISH			= new SynchEvent(EVT_FINISH);
	public static final SynchEvent SYNCH_ERROR			= new SynchEvent(EVT_ERROR);
	public static final SynchEvent SYNCH_EXCEPTION		= new SynchEvent(EVT_EXCEPTION);
	public static final SynchEvent SYNCH_HANDLE_DATA	= new SynchEvent(EVT_HANDLE_DATA);
	public static final SynchEvent SYNCH_DEFRAG			= new SynchEvent(EVT_DEFRAG);
	public static final SynchEvent SYNCH_REMOVE_BACKUP	= new SynchEvent(EVT_REMOVE_BACKUP);
	
	
	private int eventType;
	
	private SynchEvent(int eventType){
		this.eventType = eventType;
	}

	public int getEventType() {
		return eventType;
	}
	
	
}
