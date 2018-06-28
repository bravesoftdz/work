package com.mainretail.handheld.purchase;

import java.util.Date;

import com.mainretail.handheld.Pessoa;

public class PO {
	
	public Pessoa vendor;
	
	public int idpo;
	public int idstore;
	public int paydays;
	public String obs;
	public double freight;
	public double charges;
	public double subtotal;
	public double paymentetype;
	public boolean aberto;
	public boolean atendido;
	public Date datapedido;
	public Date estarrival;
	
	public PO(Pessoa vendor, int idpo, int idstore, int paydays, String obs, double freight, double charges, double subtotal, double paymentetype, boolean aberto, boolean atendido, Date datapedido, Date estarrival) {
		super();
		
		this.idpo = idpo;
		this.vendor = vendor;
		this.idstore = idstore;
		this.paydays = paydays;
		this.obs = obs;
		this.freight = freight;
		this.charges = charges;
		this.subtotal = subtotal;
		this.paymentetype = paymentetype;
		this.aberto = aberto;
		this.atendido = atendido;
		this.datapedido = datapedido;
		this.estarrival = estarrival;
	}
	
	public PO() {

	}

	public String toString()
	{
		return idpo + " " + vendor.toString() + " " + idstore + " " + paydays + " " + obs + " " + freight + " " + charges + " " + subtotal + " " + paymentetype + " " + aberto + " " + atendido + " " + datapedido + " " + estarrival;
	}

}
