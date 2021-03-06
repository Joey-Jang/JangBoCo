package com.gdj37.jangboco.web.test.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class LocDaoCls implements LocDaoIF {
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public HashMap<String, Object> getMemberAddrs(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Loc.getMemberAddrs", params);
	}
	
	@Override
	public int cntRecentLoc(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Loc.cntRecentLoc", params);
	}
	
	@Override
	public HashMap<String, Object> getLatestLocData(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Loc.getLatestLocData", params);
	}

	@Override
	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Loc.getRecentLocList", params);
	}

	@Override
	public int addRecentLocData(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Loc.addRecentLocData", params);
	}

	@Override
	public int updateRecentLocData(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("Loc.updateRecentLocData", params);
	}
	
	@Override
	public int delRecentLocData(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Loc.delRecentLocData", params);
	}

}
