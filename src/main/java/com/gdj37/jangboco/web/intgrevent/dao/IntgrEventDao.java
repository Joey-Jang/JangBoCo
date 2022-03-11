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
	public List<HashMap<String, String>> getEventBestList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("intgrEvent.getEventBestList",params);
	}

	@Override
	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.getEventDtl",params);
	}

	@Override
	public int updateEventHit(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.update("intgrEvent.updateEventHit", params);
	}

	@Override
	public String getDisctNo(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.getDisctNo",params);
	}

	@Override
	public String getDisctName(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.getDisctName",params);
	}

	@Override
	public int checkEventLike(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.checkEventLike",params);
	}

	@Override
	public int cntEventLike(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("intgrEvent.cntEventLike",params);
	}

	@Override
	public int addEventLike(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.update("intgrEvent.addEventLike", params);
	}

	@Override
	public int deleteEventLike(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.delete("intgrEvent.deleteEventLike", params);
	}

}
