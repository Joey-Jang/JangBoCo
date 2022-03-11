package com.gdj37.jangboco.web.dbapi.service;

import com.gdj37.jangboco.web.dbapi.dao.DBApiDaoIF;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class DBApiServiceCls {

	@Autowired
	public DBApiDaoIF DBApiDao;
	
	public int disctDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.disctDuplctCheck(params);
	}
	
	public int addDisctData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addDisctData(params);
	}
	
	public int marketDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.marketDuplctCheck(params);
	}
	
	public int addMarketData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addMarketData(params);
	}
	
	public int itemsDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.itemsDuplctCheck(params);
	}
	
	public int addItemsData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addItemsData(params);
	}
	
	public int addPricesData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addPricesData(params);
	}

	public int getMaxPricesNo() throws Throwable {
		return DBApiDao.getMaxPricesNo();
	}

}
