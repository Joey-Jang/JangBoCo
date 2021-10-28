package com.gdj37.jangboco.web.diaryjj.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DiaryDaoCls implements DiaryDaoIF {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return sqlSession.selectList("Diary.getDisctList");
	}

	@Override
	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getMarketList", params);
	}

	@Override
	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getBranchList", params);
	}

	@Override
	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getItemsList", params);
	}

	@Override
	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return sqlSession.insert("Diary.addDiaryData", diaryParams);
	}

	@Override
	public int addToAccbk(Map<String, Object> accbkParams) throws Throwable {
		return sqlSession.insert("Diary.addToAccbk", accbkParams);
	}

}
