package com.gdj37.jangboco.web.test.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LocDaoIF {

	public Map<String, String> getMemberAddrs(HashMap<String, String> params) throws Throwable;
	
	public int cntRecentLoc(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable;

	public int addRecentLocData(HashMap<String, String> params) throws Throwable;

	public int updateRecentLocData(HashMap<String, String> params) throws Throwable;
	
	public int delRecentLocData(HashMap<String, String> params) throws Throwable;

}
