package com.gdj37.jangboco.web.intgrevent.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class IntgrEventDao implements IIntgrEventDao {
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<HashMap<String, String>> getEventNormalList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("intgrEvent.getEventNormalList",params);
	}

	@Override
	public int getEventCnt(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.getEventCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getEventBestList() throws Throwable {
		
		return sqlSession.selectList("intgrEvent.getEventBestList");
	}

	@Override
	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.getEventDtl",params);
	}

	@Override
	public int updateEventHit(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.update("intgrEvent.updateEventHit", params);
	}

}