package com.gdj37.jangboco.web.dbapi.service;

import java.util.HashMap;

public interface DBApiServiceIF {

	public int addApiData(HashMap<String, Object> params) throws Throwable;

	public int getMaxPricesNo() throws Throwable;

}
