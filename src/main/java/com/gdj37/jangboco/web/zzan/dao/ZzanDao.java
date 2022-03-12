package com.gdj37.jangboco.web.zzan.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class ZzanDao implements IZzanDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("zzan.getMarketList", params);
	}

	@Override
	public List<HashMap<String, String>> getItemList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.selectList("zzan.getItemList", params);
	}
}
