package com.gdj37.jangboco.web.marketinfo.dao;

import java.util.HashMap;
import java.util.List;

public interface IMarketInfoDao {

	public int getMarketEventCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEventList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMarketInfoU(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMarketInfoBU(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemsListNoChoice(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getItemsListChoice(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getEventData(HashMap<String, String> params) throws Throwable;

	

}
