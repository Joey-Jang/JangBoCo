package com.gdj37.jangboco.web.dbapi.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DBApiDaoCls implements DBApiDaoIF {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int addApiData(HashMap<String, Object> params) throws Throwable {
		return sqlSession.insert("Api.addApiData", params);
	}

	@Override
	public int getMaxPricesNo() throws Throwable {
		return sqlSession.selectOne("Api.getMaxPricesNo");
	}

}
