package com.gdj37.jangboco.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LocDaoCls implements LocDaoIF {
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, Object>> getRecentLocList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Loc.getRecentLocList", params);
	}

}
