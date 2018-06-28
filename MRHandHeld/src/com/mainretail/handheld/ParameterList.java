package com.mainretail.handheld;

import java.util.Vector;

public class ParameterList {

	public static final int  PARAM_TAX              = 1;
	public static final int  PARAM_SALEONNEGATIVE   = 2;
	public static final int  PARAM_FASTSALE         = 3;
	public static final int  PARAM_REFRESHONINSERT  = 4;
	public static final int  PARAM_REFRESHINTERVAL  = 5;
	public static final int  PARAM_REFRESHBROWSE    = 6;
	public static final int  PARAM_MAXROWS          = 7;
	public static final int  PARAM_MODIFYCOST       = 8;
	public static final int  PARAM_CASHREGRESTANT   = 9;
	public static final int  PARAM_LICENSE          = 10;
	public static final int  PARAM_MAXCASHALLOWED   = 11;
	public static final int  PARAM_CLOSECASHRANDOM  = 12;
	public static final int  PARAM_MAXQTYCOMPUTERREQ = 13;
	public static final int  PARAM_MINSALECOMPUTERREQ = 14;
	public static final int  PARAM_INCLUDEPREPURCHASE = 15;
	public static final int  PARAM_ANYONEMANAGECASHREG = 31;
	public static final int  PARAM_SHOWTABNOCUSTUMERREGISTER = 32;
	public static final int  PARAM_SHOWTABCUSTUMERREGISTER = 33;
	public static final int  PARAM_SHOWTABTOURGROUP = 34;
	public static final int  PARAM_COMMISSIONBONUS = 35;
	public static final int  PARAM_SHOWNAME_NOREGISTERCUSTUMER = 36;
	public static final int  PARAM_MAX_WORKING_HOUR_PER_DAY = 37;
	public static final int  PARAM_SHOW_PRICE_PRE_RECEIVE  = 38;
	public static final int  PARAM_SHOW_MENU_ICONS = 39;
	public static final int  PARAM_SHOW_LAYAWAY_CR_HIST = 41;
	public static final int  PARAM_SHOW_LAYAWAY_INVOICE_HIST = 40;
	public static final int  PARAM_PRINT_DEPOSIT = 42;
	public static final int  PARAM_SHOWTABLAYAWAY = 43;
	public static final int  PARAM_CHECKSERIALNUMBER = 44;
	public static final int  PARAM_MARKUPOVERCOST = 45;
	public static final int  PARAM_PRINT_ON_OPENCASHREG = 46;
	public static final int  PARAM_NUM_ITEM_TO_PRINT = 47;
	public static final int  PARAM_DISPLAY_PRE_DATADO = 48;
	public static final int  PARAM_CONFIRM_DELIVERY_ON_SALE = 49;
	public static final int  PARAM_DISPLAY_PAYMENT_PLACE = 50;
	public static final int  PARAM_ENTER_LAYAWAY_FULL_AMOUNT = 51;
	public static final int  PARAM_INVOICE_SHOW_TAB_OTHER_COSTS = 52;
	public static final int  PARAM_INVOICE_SHOW_TAB_PAYMENTS = 53;
	public static final int  PARAM_INVOICE_SHOW_TAB_AGENTS = 54;
	public static final int  PARAM_INVOICE_SHOW_TAB_DELIVERY = 55;
	public static final int  PARAM_INVOICE_SHOW_TAB_DEPOSIT_DATE = 56;
	public static final int  PARAM_INVOICE_SHOW_TAB_DISCOUNT = 57;
	public static final int  PARAM_MAX_NUMBER_PAYMENTS = 58;
	public static final int  PARAM_CONSULTA_SERASA = 59;
	public static final int  PARAM_CONSULTA_ZIPCODE = 60;
	public static final int  PARAM_MAX_NUMBER_DAYS_PAYING_NOW = 61;
	public static final int  PARAM_CONFIRM_DELIVERY_AFTER_FINISH_SALE = 62;
	public static final int  PARAM_SALE_SCREEN_TYPE = 63;
	public static final int  PARAM_TAX_EXEMPT_ON_SALE = 64;
	public static final int  PARAM_DISPLAY_QTY_FLOATING = 65;
	public static final int  PARAM_TAX_IN_COSTPRICE = 66;
	public static final int  PARAM_PETSHOP_OPTIONS = 67;
	public static final int  PARAM_USE_ESTIMATED_COST = 68;
	public static final int  PARAM_MARK_DELIVERY_HOUR = 69;
	public static final int  PARAM_DISPLAY_CUSTOMER_INFO = 70;
	public static final int  PARAM_VERIFY_PGTO_BEFORE_DELIVERY = 71;
	public static final int  PARAM_TAX_COST_USE_MARKUP_ON_COST = 72;
	public static final int  PARAM_PUPPY_TRACKER_INTEGRATION = 73;
	public static final int  PARAM_ASK_PASSWORD_BEFORE_OPEN_SOFTWARE = 74;
	public static final int  PARAM_CALC_MARGIN = 75;
	public static final int  PARAM_CALC_ROUNDING = 76;
	public static final int  PARAM_REMOVE_BARCODE_DIGIT = 77;
	public static final int  PARAM_SEARCH_MODEL_AFTER_BARCODE = 78;
	public static final int  PARAM_AUTO_GENERATE_MODEL = 79;
	public static final int  PARAM_APPLY_PROMO_ON_SALE = 80;
	public static final int  PARAM_PROMPT_COMMISSIONER_ON_SALE = 81;
	public static final int  PARAM_SALECODE_ON_CREATE_SALE = 82;
	public static final int  PARAM_TREAT_HOLD_AS_INVOICE = 83;
	public static final int  PARAM_SEND_ITEM_FOR_TRASH = 84;
	public static final int  PARAM_USE_FRACTIONARY_QTY = 85;
	public static final int  PARAM_GIFT_EXP_DATE       = 86;
	public static final int  PARAM_PROGRESSIVE_QTY_DISCOUNT = 87;
	public static final int  PARAM_USE_CATALOG = 88;
	public static final int  PARAM_ASK_SALEPRICE = 89;
	public static final int  PARAM_MIN_BARCODE_LENGTH = 90;	
	
	public Vector parameters;
	
	public ParameterList() {
		super();
		parameters = new Vector();
	}
	
	public ParameterList(Vector parameters) {
		super();
		this.parameters = parameters; 
	}
	
	public String toString() {
		return parameters.toString();
	}
	
	public Object getObjectValueAt(int idparam) {
		Object retorno = null;
		
		for (int i = 0; i < parameters.size(); i++) {
			Parameter parameter = (Parameter)parameters.elementAt(i);
			if (parameter.idparam == idparam) {
				retorno = parameter.srvvalue;
				break;
			}
				
		}		
		return retorno;
	}
	
	public Integer getIntegerValueAt(int idparam) {
		return (Integer)getObjectValueAt(idparam);
	}

	public Boolean getBooleanValueAt(int idparam) {
		return (Boolean)getObjectValueAt(idparam);
	}
	
	public String getStringValueAt(int idparam) {
		return (String)getObjectValueAt(idparam);
	}
	
	public Double getDoubleValueAt(int idparam) {
		return (Double)getObjectValueAt(idparam);
	}

}
