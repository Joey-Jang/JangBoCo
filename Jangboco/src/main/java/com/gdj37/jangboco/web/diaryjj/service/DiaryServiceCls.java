package com.gdj37.jangboco.web.diaryjj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.diaryjj.dao.DiaryDaoIF;

@Service
public class DiaryServiceCls implements DiaryServiceIF {

	@Autowired
	public DiaryDaoIF diaryDao;
	
	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return diaryDao.getDisctList();
	}

	@Override
	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getMarketList(params);
	}

	@Override
	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getBranchList(params);
	}

	@Override
	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getItemsList(params);
	}
	
	@Override
	public int hastgDuplctCheck(String hastgName) throws Throwable {
		return diaryDao.hastgDuplctCheck(hastgName);
	}
	
	@Override
	public int addHastgData(Map<String, Object> diaryParams) throws Throwable {
		return diaryDao.addHastgData(diaryParams);
	}

	@Override
	public int getHastgNo(String hastgName) throws Throwable {
		return diaryDao.getHastgNo(hastgName);
	}

	@Override
	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return diaryDao.addDiaryData(diaryParams);
	}

	@Override
	public HashMap<String, Object> getDiaryData(HashMap<String, String> params) throws Throwable {
		return diaryDao.getDiaryData(params);
	}
	
	@Override
	public List<HashMap<String, Object>> getDiaryImgListOnDiary(HashMap<String, String> params) throws Throwable {
		return diaryDao.getDiaryImgListOnDiary(params);
	}

	@Override
	public List<HashMap<String, Object>> getItemTagListOnDiary(int imgNo) throws Throwable {
		return diaryDao.getItemTagListOnDiary(imgNo);
	}

	@Override
	public int addDiaryAccuse(HashMap<String, String> params) throws Throwable {
		return diaryDao.addDiaryAccuse(params);
	}

	@Override
	public List<HashMap<String, Object>> getProfileDiaryList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getProfileDiaryList(params);
	}

	@Override
	public int checkDiaryLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.checkDiaryLike(params);
	}
	
	@Override
	public int cntDiaryLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.cntDiaryLike(params);
	}
	
	@Override
	public int diaryLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.diaryLike(params);
	}
	
	@Override
	public int diaryUnlike(HashMap<String, String> params) throws Throwable {
		return diaryDao.diaryUnlike(params);
	}
	
	@Override
	public int addDiaryAccuseData(HashMap<String, String> params) throws Throwable {
		return diaryDao.addDiaryAccuseData(params);
	}

	@Override
	public int checkDiaryFolw(HashMap<String, String> params) throws Throwable {
		return diaryDao.checkDiaryFolw(params);
	}
	
	@Override
	public int diaryFolw(HashMap<String, String> params) throws Throwable {
		return diaryDao.diaryFolw(params);
	}
	
	@Override
	public int diaryUnfolw(HashMap<String, String> params) throws Throwable {
		return diaryDao.diaryUnfolw(params);
	}

	@Override
	public List<HashMap<String, Object>> getHastgList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getHastgList(params);
	}

	@Override
	public List<HashMap<String, Object>> getComntList(HashMap<String, String> params) throws Throwable {
		return diaryDao.getComntList(params);
	}

	@Override
	public List<HashMap<String, Object>> getRecomntList(int parentComntNo) throws Throwable {
		return diaryDao.getRecomntList(parentComntNo);
	}

	@Override
	public int cntRecomnt(HashMap<String, String> params) throws Throwable {
		return diaryDao.cntRecomnt(params);
	}

	@Override
	public int checkComntLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.checkComntLike(params);
	}

	@Override
	public int cntComntLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.cntComntLike(params);
	}

	@Override
	public int comntLike(HashMap<String, String> params) throws Throwable {
		return diaryDao.comntLike(params);
	}

	@Override
	public int comntUnlike(HashMap<String, String> params) throws Throwable {
		return diaryDao.comntUnlike(params);
	}

	@Override
	public int addComntAccuseData(HashMap<String, String> params) throws Throwable {
		return diaryDao.addComntAccuseData(params);
	}

	@Override
	public int addComntData(HashMap<String, String> params) throws Throwable {
		return diaryDao.addComntData(params);
	}
	
	@Override
	public int deleteDiaryHastg(int diaryNo) throws Throwable {
		return diaryDao.deleteDiaryHastg(diaryNo);
	}
	
	@Override
	public int deleteItemTag(int diaryNo) throws Throwable {
		return diaryDao.deleteItemTag(diaryNo);
	}
	
	@Override
	public int deleteDiaryImg(int diaryNo) throws Throwable {
		return diaryDao.deleteDiaryImg(diaryNo);
	}

	@Override
	public int updateDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return diaryDao.updateDiaryData(diaryParams);
	}

	@Override
	public int updateDiaryCon(Map<String, Object> diaryParams) throws Throwable {
		return diaryDao.updateDiaryCon(diaryParams);
	}

	@Override
	public int deleteDiary(int diaryNo) throws Throwable {
		return diaryDao.deleteDiary(diaryNo);
	}

}
