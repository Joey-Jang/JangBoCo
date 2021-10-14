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
	public int addApiData(HashMap<String, Object> params) throws Throwable {
		return DBApiDao.addApiData(params);
	}

	@Override
	public int getMaxPricesNo() throws Throwable {
		return DBApiDao.getMaxPricesNo();
	}

}
