package com.gdj37.jangboco.web.priceschart.dao;

import java.util.HashMap;
import java.util.List;

public interface IPricesChartDao {

	public List<HashMap<String, String>> getLineDataList(HashMap<String, String> params) throws Throwable;

	public List<String> getDateList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemNameList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDisctDataList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getDisctItemsList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getCategoryChartData(HashMap<String, String> params) throws Throwable;

}
