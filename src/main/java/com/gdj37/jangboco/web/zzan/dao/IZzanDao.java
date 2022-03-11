package com.gdj37.jangboco.web.zzan.dao;

import java.util.HashMap;
import java.util.List;

public interface IZzanDao {

	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemList(HashMap<String, String> params) throws Throwable;

}
