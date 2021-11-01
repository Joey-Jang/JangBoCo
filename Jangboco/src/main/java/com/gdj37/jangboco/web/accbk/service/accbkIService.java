package com.gdj37.jangboco.web.accbk.service;

import java.util.HashMap;
import java.util.List;

public interface accbkIService {

	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params)throws Throwable;

	public int writeAccbk(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAccbkList(HashMap<String, String> params)throws Throwable;

	public int getAccbkCnt(HashMap<String, String> params)throws Throwable;

	public int delAccbk(List<Integer> list) throws Throwable;

	public HashMap<String, String> getAccbk(HashMap<String, String> params)throws Throwable;

	public int updateAccbk(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getMostSpendDay(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getLeastSpendDay(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getMostSpendItems(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getMostVisitMarket(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getThisMonthSpend(HashMap<String, String> params)throws Throwable;
	
	public HashMap<String, String> getMostSpendWeek(HashMap<String, String> params)throws Throwable;
	
	public HashMap<String, String> getLeastSpendWeek(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, Object>> getDisctList()throws Throwable;

	public List<HashMap<String, String>> getBranchList(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> searchMarket(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getAccbkPeriodChart(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getFiveItems(HashMap<String, String> params)throws Throwable;


	


}
