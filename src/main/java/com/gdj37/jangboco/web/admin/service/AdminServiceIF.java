package com.gdj37.jangboco.web.admin.service;

import java.util.HashMap;
import java.util.List;

public interface AdminServiceIF {
	
	int cntMember(HashMap<String, String> params) throws Throwable;

	List<HashMap<String, Object>> getMemberList(HashMap<String, String> params) throws Throwable;

}
