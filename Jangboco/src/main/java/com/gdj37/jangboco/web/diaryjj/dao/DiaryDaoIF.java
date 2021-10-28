package com.gdj37.jangboco.web.diaryjj.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DiaryDaoIF {

	public List<HashMap<String, Object>> getDisctList() throws Throwable;

	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable;

	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable;

	public int addToAccbk(Map<String, Object> accbkParams) throws Throwable;

}
