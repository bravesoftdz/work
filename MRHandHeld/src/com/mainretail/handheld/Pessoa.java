package com.mainretail.handheld;

public class Pessoa {
	
	public int idpessoa;
	public int idtipopessoa;
	public int idstore;	
	public int idramoatividade;
	public int iduser;
	public int code;
	public String idestado;
	public String pessoa;
	public String cpf;
	public String cgc;
	public String identidade;
	public String usercode;
	public String cartmotorista;
	
	 
	
	public Pessoa(int idpessoa, int idtipopessoa, int idstore, String idestado, int idramoatividade, int iduser, int code, String pessoa, String cpf, String cgc, String identidade, String usercode, String cartmotorista) {
		super();
		
		this.idpessoa = idpessoa;
		this.idtipopessoa = idtipopessoa;
		this.idstore = idstore;
		this.idestado = idestado;
		this.idramoatividade = idramoatividade;
		this.iduser = iduser;
		this.code = code;
		this.pessoa = pessoa;
		this.cpf = cpf;
		this.cgc = cgc;
		this.identidade = identidade;
		this.usercode = usercode;
		this.cartmotorista = cartmotorista;
		
	}

	public Pessoa() {

	}

	public String toString()
	{
		return idpessoa + " " + idtipopessoa + " " + idstore +  " " + idestado + " " + idramoatividade + " " + iduser + " " + code + " " + pessoa + " " + cpf + " " + cgc + " " + identidade + " " + usercode + " " + cartmotorista;
	}
	
}
