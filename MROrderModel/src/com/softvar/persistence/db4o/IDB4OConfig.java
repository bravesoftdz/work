package com.softvar.persistence.db4o;

import java.util.Hashtable;

/**
 * @author Carlos Lima
 *
 */
public interface IDB4OConfig {
	public Class[] getCascadeClasses();
	public Hashtable getClassIndexes();
	public String getFileName();
}
