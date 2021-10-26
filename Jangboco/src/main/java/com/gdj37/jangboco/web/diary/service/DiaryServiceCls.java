package com.gdj37.jangboco.web.diary.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.diary.dao.DiaryDaoIF;

@Service
public class DiaryServiceCls implements DiaryServiceIF {

	@Autowired
	public DiaryDaoIF diaryDao;
	
	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return diaryDao.getDisctList();
	}

	@Override
	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getMarketList(params);
	}

	@Override
	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getBranchList(params);
	}

	@Override
	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getItemsList(params);
	}

	@Override
	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return diaryDao.addDiaryData(diaryParams);
	}

	@Override
	public int addToAccbk(Map<String, Object> accbkParams) throws Throwable {
		return diaryDao.addToAccbk(accbkParams);
	}

}
