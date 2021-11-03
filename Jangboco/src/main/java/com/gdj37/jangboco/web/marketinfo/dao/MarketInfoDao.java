package com.gdj37.jangboco.web.marketinfo.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MarketInfoDao implements IMarketInfoDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getMarketEventCnt(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("marketInfo.getMarketEventCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getEventList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("marketInfo.getEventList",params);
	}

	@Override
	public HashMap<String, String> getMarketInfoU(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("marketInfo.getMarketInfoU",params);
	}

	@Override
	public HashMap<String, String> getMarketInfoBU(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("marketInfo.getMarketInfoBU",params);
	}

	@Override
	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("marketInfo.getItemsList",params);
	}

	@Override
	public List<HashMap<String, String>> getItemsListNoChoice(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("marketInfo.getItemsListNoChoice",params);
	}

	@Override
	public HashMap<String, String> getItemsListChoice(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("marketInfo.getItemsListChoice",params);
	}

	@Override
	public HashMap<String, String> getEventData(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("marketInfo.getEventData",params);
	}

	
	
}
