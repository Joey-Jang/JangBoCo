package com.gdj37.jangboco.web.dbapi.dao;

import java.util.HashMap;

public interface DBApiDaoIF {

	public int addApiData(HashMap<String, Object> params) throws Throwable;

	public int getMaxPricesNo() throws Throwable;

}
