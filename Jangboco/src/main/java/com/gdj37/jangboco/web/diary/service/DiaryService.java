package com.gdj37.jangboco.web.diary.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.diary.dao.IDiaryDao;
import com.gdj37.jangboco.web.join.dao.IJoinDao;

@Service
public class DiaryService implements IDiaryService{

	@Autowired
	public IDiaryDao iDiaryDao;
	
	@Override
	public int addMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.addMember(params);
	}

	@Override
	public int getAllDiaryCnt() throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getAllDiaryCnt();
	}

	@Override
	public List<HashMap<String, String>> getAllDiaryList(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getAllDiaryList(params);
	}

	@Override
	public int getSearchDiaryCnt(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getSearchDiaryCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getSearchDiaryList(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getSearchDiaryList(params);
	}

}
