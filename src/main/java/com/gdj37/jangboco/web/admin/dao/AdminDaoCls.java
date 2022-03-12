package com.gdj37.jangboco.web.admin.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class AdminDaoCls implements AdminDaoIF {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int cntMember(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Admin.cntMember", params);
	}

	@Override
	public List<HashMap<String, Object>> getMemberList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Admin.getMemberList", params);
	}
	
}
