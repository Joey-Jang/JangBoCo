package com.gdj37.jangboco.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.test.dao.LocDaoIF;

@Service
public class LocServiceCls implements LocServiceIF {

	@Autowired
	public LocDaoIF locDao;
	
	@Override
	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable {
		return locDao.getRecentLocList(params);
	}

}
