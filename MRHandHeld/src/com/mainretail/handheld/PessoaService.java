package com.mainretail.handheld;

import java.util.Hashtable;

import com.mainretail.util.KeyValueParser;
import com.mainretail.util.Util;

public class PessoaService {
	
	public static Hashtable toHashtable(Pessoa pessoa){
		return  pessoaToHashtable(pessoa,"P.");
	}
	
	public static Hashtable pessoaToHashtable(Pessoa pessoa, String aliaspessoa) {
	
		Hashtable hashPessoa = new Hashtable();
		
		if (pessoa.idpessoa != 0) {
			hashPessoa.put(aliaspessoa + "idpessoa", String.valueOf(pessoa.idpessoa));
		}
		
		if (pessoa.idtipopessoa != 0) {
			hashPessoa.put(aliaspessoa + "idtipopessoa", String.valueOf(pessoa.idtipopessoa));
		}
		
		if (pessoa.idstore != 0) {
			hashPessoa.put(aliaspessoa + "idstore", String.valueOf(pessoa.idstore));
		}
		
		if (pessoa.idestado != null) {
			hashPessoa.put(aliaspessoa + "idestado", Util.encodeURL(pessoa.idestado));
		}
		
		if (pessoa.idramoatividade != 0) {
			hashPessoa.put(aliaspessoa + "idramoatividade", String.valueOf(pessoa.idramoatividade));
		}
		
		if (pessoa.iduser != 0) {
			hashPessoa.put(aliaspessoa + "iduser", String.valueOf(pessoa.iduser));
		}
		
		if (pessoa.code != 0) {
			hashPessoa.put(aliaspessoa + "code", String.valueOf(pessoa.code));
		}
		
		if (pessoa.pessoa != null) {
			hashPessoa.put(aliaspessoa + "pessoa", Util.encodeURL(pessoa.pessoa));
		}
		
		if (pessoa.cpf != null) {
			hashPessoa.put(aliaspessoa + "cpf", Util.encodeURL(pessoa.cpf));
		}
		
		if (pessoa.cgc != null) {
			hashPessoa.put(aliaspessoa + "cgc", Util.encodeURL(pessoa.cgc));
		}
		
		if (pessoa.identidade != null) {
			hashPessoa.put(aliaspessoa + "identidade", Util.encodeURL(pessoa.identidade));
		}
		
		if (pessoa.usercode != null) {
			hashPessoa.put(aliaspessoa + "usercode", Util.encodeURL(pessoa.usercode));
		}
		
		if (pessoa.cartmotorista != null) {
			hashPessoa.put(aliaspessoa + "cartmotorista", Util.encodeURL(pessoa.cartmotorista));
		}
		
		return  hashPessoa;
	}

	public static Pessoa hashTableToPessoa(Hashtable hashPessoa) {
		return hashTableToPessoa(hashPessoa, "");
	}
   
	public static Pessoa hashTableToPessoa(Hashtable hashPessoa, String alias) {
		//return hashTableToPessoa(hashPessoa, "", "P.");
		return hashTableToPessoa(hashPessoa, alias, "P.");
	}
  
	public static Pessoa hashTableToPessoa(Hashtable hashPessoa, String alias, String aliaspessoa) {
	    Pessoa pessoa = new Pessoa ();
	    
	    if (hashPessoa.containsKey(alias + aliaspessoa + "idpessoa")) {
			pessoa.idpessoa = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "idpessoa"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "idtipopessoa")) {
			pessoa.idtipopessoa = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "idtipopessoa"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "idstore")) {
			pessoa.idstore = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "idstore"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "idestado")) {
			pessoa.idestado = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "idestado"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "idramoatividade")) {
			pessoa.idramoatividade = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "idramoatividade"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "iduser")) {
			pessoa.iduser = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "iduser"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "code")) {
			pessoa.code = Integer.parseInt((String)hashPessoa.get(alias + aliaspessoa + "code"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "pessoa")) {
			pessoa.pessoa = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "pessoa"));
		}

		if (hashPessoa.containsKey(alias + aliaspessoa + "cpf")) {
			pessoa.cpf = Util.decodeURL((String)hashPessoa.get(alias + "P.cpf"));
		}

		if (hashPessoa.containsKey(alias + aliaspessoa + "cgc")) {
			pessoa.cgc = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "cgc"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "identidade")) {
			pessoa.identidade = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "identidade"));
		}

		if (hashPessoa.containsKey(alias + aliaspessoa + "usercode")) {
			pessoa.usercode = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "usercode"));
		}
		
		if (hashPessoa.containsKey(alias + aliaspessoa + "cartmotorista")) {
			pessoa.cartmotorista = Util.decodeURL((String)hashPessoa.get(alias + aliaspessoa + "cartmotorista"));
		}

		return pessoa;
	}  
	
   public static String toQueryString(Pessoa pessoa) {
	   Hashtable ht = toHashtable(pessoa);
	   return Util.hashtableToQuery(ht);
	}
   
   // Otimizacao //
   
	public static Pessoa hashTableToPessoa(String query, String alias, String aliaspessoa) {
	    Pessoa pessoa = new Pessoa ();
	    
	    KeyValueParser hashPessoa = new KeyValueParser();
	    
	    if (hashPessoa.containsKey(query, alias + aliaspessoa + "idpessoa")) {
			pessoa.idpessoa = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "idtipopessoa")) {
			pessoa.idtipopessoa = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "idstore")) {
			pessoa.idstore = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "idestado")) {
			pessoa.idestado = Util.decodeURL((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "idramoatividade")) {
			pessoa.idramoatividade = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "iduser")) {
			pessoa.iduser = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "code")) {
			pessoa.code = Integer.parseInt((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "pessoa")) {
			pessoa.pessoa = Util.decodeURL((String)hashPessoa.get());
		}

		if (hashPessoa.containsKey(query, alias + aliaspessoa + "cpf")) {
			pessoa.cpf = Util.decodeURL((String)hashPessoa.get());
		}

		if (hashPessoa.containsKey(query, alias + aliaspessoa + "cgc")) {
			pessoa.cgc = Util.decodeURL((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "identidade")) {
			pessoa.identidade = Util.decodeURL((String)hashPessoa.get());
		}

		if (hashPessoa.containsKey(query, alias + aliaspessoa + "usercode")) {
			pessoa.usercode = Util.decodeURL((String)hashPessoa.get());
		}
		
		if (hashPessoa.containsKey(query, alias + aliaspessoa + "cartmotorista")) {
			pessoa.cartmotorista = Util.decodeURL((String)hashPessoa.get());
		}

		return pessoa;
	}

}