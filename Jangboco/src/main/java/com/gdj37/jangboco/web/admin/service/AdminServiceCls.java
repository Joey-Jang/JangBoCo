package com.gdj37.jangboco.web.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.admin.dao.AdminDaoIF;

@Service
public class AdminServiceCls implements AdminServiceIF {

	@Autowired
	public AdminDaoIF adminDao;
	
}
