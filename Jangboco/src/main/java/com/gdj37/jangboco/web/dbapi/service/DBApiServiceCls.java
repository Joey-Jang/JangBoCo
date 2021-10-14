package com.gdj37.jangboco.web.dbapi.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.dbapi.dao.DBApiDaoIF;
@Service
public class DBApiServiceCls implements DBApiServiceIF {

	@Autowired
	DBApiDaoIF DBApiDao;
	
	@Override
	public int addDisctData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addDisctData(params);
	}
	
	@Override
	public int marketDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.marketDuplctCheck(params);
	}
	
	@Override
	public int addMarketData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addMarketData(params);
	}
	
	@Override
	public int itemsDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.itemsDuplctCheck(params);
	}
	
	@Override
	public int addItemsData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addItemsData(params);
	}
	
	@Override
	public int addPricesData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addPricesData(params);
	}

	@Override
	public int getMaxPricesNo() throws Throwable {
		return DBApiDao.getMaxPricesNo();
	}

}
