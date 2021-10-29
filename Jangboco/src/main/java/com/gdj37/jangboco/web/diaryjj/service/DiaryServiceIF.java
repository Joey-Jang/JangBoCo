package com.gdj37.jangboco.web.diaryjj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DiaryServiceIF {

	public List<HashMap<String, Object>> getDisctList() throws Throwable;

	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable;
	
	public int hastgDuplctCheck(String hastgName) throws Throwable;
	
	public int addHastgData(Map<String, Object> diaryParams) throws Throwable;

	public int getHastgNo(String hastgName) throws Throwable;

	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable;

	public HashMap<String, Object> getDiaryData(HashMap<String, String> params) throws Throwable;
	
	public List<HashMap<String, Object>> getHastgListOnDiary(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getDiaryImgListOnDiary(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getItemTagListOnDiary(int imgNo) throws Throwable;

	public int addDiaryAccuse(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getProfileDiaryList(HashMap<String, String> params) throws Throwable;

	public int checkLike(HashMap<String, String> params) throws Throwable;
	
	public int cntDiaryLike(HashMap<String, String> params) throws Throwable;
	
	public int diaryLike(HashMap<String, String> params) throws Throwable;
	
	public int diaryUnlike(HashMap<String, String> params) throws Throwable;
	
	public int addDiaryAccuseData(HashMap<String, String> params) throws Throwable;

	public int checkFolw(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getHastgList(HashMap<String, String> params) throws Throwable;

}
