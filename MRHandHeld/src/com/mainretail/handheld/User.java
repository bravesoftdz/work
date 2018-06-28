package com.mainretail.handheld;
public class User {

	public int iduser;
	public int usertypeid;
	public int comissionid;
	public String systemuser;
	public String pw;
	public String system;
	public String desativado;
	public String hidden;
	public String codsystemuser;
	public String storesaccess;
	public String contadorclasse;
	 
	
	public User(int id, int usertypeid, int comissionid, String systemuser, String pw, String system, String desativado, String hidden, String codsystemuser, String storesaccess, String contadorclasse) {
		super();
		
		this.iduser = id;
		this.usertypeid = usertypeid;
		this.comissionid = comissionid;
		this.systemuser = systemuser;
		this.pw = pw;
		this.system = system;
		this.desativado = desativado;
		this.hidden = hidden;
		this.codsystemuser = codsystemuser;
		this.storesaccess = storesaccess;
		this.contadorclasse = contadorclasse;

	}

	public User() {
	
	}
	
	public String toString()
	{
		return iduser + " " + usertypeid + " "+ comissionid +  " " + systemuser + " " + pw + " " + system + " "+ desativado +  " " + hidden + " " + codsystemuser +  " " + storesaccess + " " + contadorclasse;
	}
	

}
