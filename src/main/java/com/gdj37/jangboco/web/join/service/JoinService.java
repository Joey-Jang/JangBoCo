package com.gdj37.jangboco.web.join.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.join.dao.IJoinDao;

@Primary
@Service
public class JoinService implements IJoinService{

	@Autowired
	public IJoinDao iJoinDao;
	
	@Override
	public int addMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.addMember(params);
	}

	@Override
	public int validEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.validEmail(email);
	}

	@Override
	public List<HashMap<String, String>> getDisct() throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.getDisct();
	}

	@Override
	public List<HashMap<String, String>> getMarkets(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.getMarkets(params);
	}

	@Override
	public List<HashMap<String, String>> getBranches(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.getBranches(params);
	}

	@Override
	public int checkRegnum(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.checkRegnum(params);
	}

	@Override
	public HashMap<String, String> checkAddMarket(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.checkAddMarket(params);
	}

	@Override
	public int checkBranchName(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.checkBranchName(params);
	}

	@Override
	public int addMarketMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.addMarketMember(params);
	}


	@Override
	public HashMap<String, Object> loginPernlCheck(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.loginPernlCheck(params);
	}

	@Override
	public HashMap<String, Object> getMemberInfo(String email) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.getMemberInfo(email);
	}

	@Override
	public int findPw(String email) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.findPw(email);
	}

	@Override
	public int setNewPw(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iJoinDao.setNewPw(params);
	}

}
