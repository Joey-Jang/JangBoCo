package com.gdj37.jangboco.web.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LocServiceIF {

	public HashMap<String, Object> getMemberAddrs(HashMap<String, String> params) throws Throwable;
	
	public int cntRecentLoc(HashMap<String, String> params) throws Throwable;
	
	public HashMap<String, Object> getLatestLocData(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable;

	public int addRecentLocData(HashMap<String, String> params) throws Throwable;

	public int updateRecentLocData(HashMap<String, String> params) throws Throwable;

	public int delRecentLocData(HashMap<String, String> params) throws Throwable;

}
