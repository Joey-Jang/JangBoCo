package com.gdj37.jangboco.web.diaryjj.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DiaryDaoIF {

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
	
	public int checkDiaryLike(HashMap<String, String> params) throws Throwable;
	
	public int cntDiaryLike(HashMap<String, String> params) throws Throwable;
	
	public int diaryLike(HashMap<String, String> params) throws Throwable;
	
	public int diaryUnlike(HashMap<String, String> params) throws Throwable;

	public int checkDiaryFolw(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getHastgList(HashMap<String, String> params) throws Throwable;
	
	public int diaryFolw(HashMap<String, String> params) throws Throwable;
	
	public int diaryUnfolw(HashMap<String, String> params) throws Throwable;

	public int addDiaryAccuseData(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getComntList(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, Object>> getRecomntList(int parentComntNo) throws Throwable;

	public int cntRecomnt(HashMap<String, String> params) throws Throwable;

	public int checkComntLike(HashMap<String, String> params) throws Throwable;

	public int cntComntLike(HashMap<String, String> params) throws Throwable;

	public int comntLike(HashMap<String, String> params) throws Throwable;

	public int comntUnlike(HashMap<String, String> params) throws Throwable;

	public int addComntAccuseData(HashMap<String, String> params) throws Throwable;

	public int addComntData(HashMap<String, String> params) throws Throwable;

}
