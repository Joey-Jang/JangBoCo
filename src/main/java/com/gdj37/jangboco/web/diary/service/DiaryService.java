package com.gdj37.jangboco.web.diary.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.diary.dao.IDiaryDao;
import com.gdj37.jangboco.web.join.dao.IJoinDao;

@Primary
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

	@Override
	public int getLikeDiaryCnt(int member_no) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getLikeDiaryCnt(member_no);
	}

	@Override
	public int getMemberNo(String email) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getMemberNo(email);
	}

	@Override
	public List<HashMap<String, String>> getLikeDiaryList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getLikeDiaryList(params);
	}

	@Override
	public int getDiaryPernlCnt(int member_no) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getDiaryPernlCnt(member_no);
	}

	@Override
	public List<HashMap<String, String>> getDiaryPernlList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getDiaryPernlList(params);
	}

	@Override
	public String getMemberImg(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getMemberImg(params);
	}

	@Override
	public HashMap<String, Integer> getFolwrFolwng(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getFolwrFolwng(params);
	}

	@Override
	public List<HashMap<String, String>> getFolwrList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getFolwrList(params);
	}

	@Override
	public List<HashMap<String, String>> getFolwngList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getFolwngList(params);
	}

	@Override
	public int checkFolw(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.checkFolw(params);
	}

	@Override
	public void unfolw(HashMap<String, Object> params) throws Exception {
		iDiaryDao.unflow(params);
		
	}

	@Override
	public void folw(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		iDiaryDao.folw(params);
	}

	@Override
	public List<HashMap<String, String>> getHastgList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return iDiaryDao.getHastgList(params);
	}



}
