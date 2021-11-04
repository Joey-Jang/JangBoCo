package com.gdj37.jangboco.web.admin.dao;

import java.util.HashMap;
import java.util.List;

public interface AdminDaoIF {
	
	int cntMember(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, Object>> getMemberList(HashMap<String, String> params) throws Throwable;

}
