package com.gdj37.jangboco.web.dbapi.dao;

import java.util.HashMap;

public interface DBApiDaoIF {
	
	public int disctDuplctCheck(HashMap<String, Object> params) throws Throwable;

	public int addDisctData(HashMap<String, Object> params) throws Throwable;
	
	public int marketDuplctCheck(HashMap<String, Object> params) throws Throwable;
	
	public int addMarketData(HashMap<String, Object> params) throws Throwable;
	
	public int itemsDuplctCheck(HashMap<String, Object> params) throws Throwable;
	
	public int addItemsData(HashMap<String, Object> params) throws Throwable;
	
	public int addPricesData(HashMap<String, Object> params) throws Throwable;

	public int getMaxPricesNo() throws Throwable;

}
