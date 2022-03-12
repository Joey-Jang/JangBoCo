package com.gdj37.jangboco.web.dbapi.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class DBApiDaoCls implements DBApiDaoIF {
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int disctDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return sqlSession.selectOne("DBApi.disctDuplctCheck", params);
	}

	@Override
	public int addDisctData(HashMap<String, Object> params) throws Throwable {
		return sqlSession.insert("DBApi.addDisctData", params);
	}
	
	@Override
	public int marketDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return sqlSession.selectOne("DBApi.marketDuplctCheck", params);
	}
	
	@Override
	public int addMarketData(HashMap<String, Object> params) throws Throwable {
		return sqlSession.insert("DBApi.addMarketData", params);
	}
	
	@Override
	public int itemsDuplctCheck(HashMap<String, Object> params) throws Throwable {
		return sqlSession.selectOne("DBApi.itemsDuplctCheck", params);
	}
	
	@Override
	public int addItemsData(HashMap<String, Object> params) throws Throwable {
		return sqlSession.insert("DBApi.addItemsData", params);
	}
	
	@Override
	public int addPricesData(HashMap<String, Object> params) throws Throwable {
		return sqlSession.insert("DBApi.addPricesData", params);
	}

	@Override
	public int getMaxPricesNo() throws Throwable {
		return sqlSession.selectOne("DBApi.getMaxPricesNo");
	}

}
