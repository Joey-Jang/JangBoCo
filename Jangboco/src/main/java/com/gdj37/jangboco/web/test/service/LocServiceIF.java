package com.gdj37.jangboco.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface LocServiceIF {

	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable;

}
