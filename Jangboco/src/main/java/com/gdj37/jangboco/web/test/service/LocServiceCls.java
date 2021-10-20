package com.gdj37.jangboco.web.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.test.dao.LocDaoIF;

@Service
public class LocServiceCls implements LocServiceIF {

	@Autowired
	public LocDaoIF locDao;
	
	@Override
	public HashMap<String, Object> getMemberAddrs(HashMap<String, String> params) throws Throwable {
		return locDao.getMemberAddrs(params);
	}
	
	@Override
	public int cntRecentLoc(HashMap<String, String> params) throws Throwable {
		return locDao.cntRecentLoc(params);
	}
	
	@Override
	public HashMap<String, Object> getLatestLocData(HashMap<String, String> params) throws Throwable {
		return locDao.getLatestLocData(params);
	}
	
	@Override
	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable {
		return locDao.getRecentLocList(params);
	}

	@Override
	public int addRecentLocData(HashMap<String, String> params) throws Throwable {
		return locDao.addRecentLocData(params);
	}

	@Override
	public int updateRecentLocData(HashMap<String, String> params) throws Throwable {
		return locDao.updateRecentLocData(params);
	}
	
	@Override
	public int delRecentLocData(HashMap<String, String> params) throws Throwable {
		return locDao.delRecentLocData(params);
	}

}
