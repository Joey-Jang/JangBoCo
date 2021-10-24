package com.gdj37.jangboco.web.join.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinDao implements IJoinDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int addMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("Member.addMember", params);
	}

	@Override
	public int validEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.validEmail", email);
	}

	@Override
	public List<HashMap<String, String>> getDisct() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Member.getDisct");
	}

	@Override
	public List<HashMap<String, String>> getMarkets(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Member.getMarkets",params);
	}

	@Override
	public List<HashMap<String, String>> getBranches(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Member.getBranches",params);
	}

	@Override
	public int checkRegnum(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.checkRegnum", params);
	}

	@Override
	public HashMap<String, String> checkAddMarket(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.checkAddMarket", params);
	}

	@Override
	public int checkBranchName(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.checkBranchName",params);
	}

	@Override
	public int addMarketMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("Member.addMarketMember",params);
	}



	@Override
	public HashMap<String, Object> loginPernlCheck(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.loginPernlCheck",params);
	}

	@Override
	public int checkSocialEmail(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
