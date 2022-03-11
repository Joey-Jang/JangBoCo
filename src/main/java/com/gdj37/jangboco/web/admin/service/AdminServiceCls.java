package com.gdj37.jangboco.web.admin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.admin.dao.AdminDaoIF;

@Service
public class AdminServiceCls implements AdminServiceIF {

	@Autowired
	public AdminDaoIF adminDao;
	
	@Override
	public int cntMember(HashMap<String, String> params) throws Throwable {
		return adminDao.cntMember(params);
	}

	@Override
	public List<HashMap<String, Object>> getMemberList(HashMap<String, String> params) throws Throwable {
		return adminDao.getMemberList(params);
	}
	
}
