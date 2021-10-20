package com.gdj37.jangboco.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface LocDaoIF {

	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable;

}
