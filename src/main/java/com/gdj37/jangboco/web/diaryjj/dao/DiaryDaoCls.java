package com.gdj37.jangboco.web.diaryjj.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Primary
@Repository
public class DiaryDaoCls implements DiaryDaoIF {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return sqlSession.selectList("Diary.getDisctList");
	}

	@Override
	public List<HashMap<String, Object>> getMarketList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getMarketList", params);
	}

	@Override
	public List<HashMap<String, Object>> getBranchList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getBranchList", params);
	}

	@Override
	public List<HashMap<String, Object>> getItemsList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getItemsList", params);
	}
	
	@Override
	public int hastgDuplctCheck(String hastgName) throws Throwable {
		return sqlSession.selectOne("Diary.hastgDuplctCheck", hastgName);
	}
	
	@Override
	public int addHastgData(Map<String, Object> diaryParams) throws Throwable {
		return sqlSession.insert("Diary.addHastgData", diaryParams);
	}

	@Override
	public int getHastgNo(String hastgName) throws Throwable {
		return sqlSession.selectOne("Diary.getHastgNo", hastgName);
	}

	@Override
	public int addDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return sqlSession.insert("Diary.addDiaryData", diaryParams);
	}

	@Override
	public HashMap<String, Object> getDiaryData(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.getDiaryData", params);
	}
	
	@Override
	public List<HashMap<String, Object>> getDiaryImgListOnDiary(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getDiaryImgListOnDiary", params);
	}

	@Override
	public List<HashMap<String, Object>> getItemTagListOnDiary(int imgNo) throws Throwable {
		return sqlSession.selectList("Diary.getItemTagListOnDiary", imgNo);
	}

	@Override
	public int addDiaryAccuse(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.addDiaryAccuse", params);
	}

	@Override
	public List<HashMap<String, Object>> getProfileDiaryList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getProfileDiaryList", params);
	}

	@Override
	public int checkDiaryLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.checkDiaryLike", params);
	}
	
	@Override
	public int cntDiaryLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.cntDiaryLike", params);
	}
	
	@Override
	public int diaryLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.diaryLike", params);
	}
	
	@Override
	public int diaryUnlike(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Diary.diaryUnlike", params);
	}
	
	@Override
	public int addDiaryAccuseData(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.addDiaryAccuseData", params);
	}

	@Override
	public int checkDiaryFolw(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.checkDiaryFolw", params);
	}
	
	@Override
	public int diaryFolw(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.diaryFolw", params);
	}
	
	@Override
	public int diaryUnfolw(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Diary.diaryUnfolw", params);
	}

	@Override
	public List<HashMap<String, Object>> getHastgList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getHastgList", params);
	}

	@Override
	public List<HashMap<String, Object>> getComntList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("Diary.getComntList", params);
	}

	@Override
	public List<HashMap<String, Object>> getRecomntList(int parentComntNo) throws Throwable {
		return sqlSession.selectList("Diary.getRecomntList", parentComntNo);
	}

	@Override
	public int cntRecomnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.cntRecomnt", params);
	}

	@Override
	public int checkComntLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.checkComntLike", params);
	}

	@Override
	public int cntComntLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("Diary.cntComntLike", params);
	}

	@Override
	public int comntLike(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.comntLike", params);
	}

	@Override
	public int comntUnlike(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("Diary.comntUnlike", params);
	}

	@Override
	public int addComntAccuseData(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.addComntAccuseData", params);
	}

	@Override
	public int addComntData(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("Diary.addComntData", params);
	}
	
	@Override
	public int deleteDiaryHastg(int diaryNo) throws Throwable {
		return sqlSession.delete("Diary.deleteDiaryHastg", diaryNo);
	}
	
	@Override
	public int deleteItemTag(int diaryNo) throws Throwable {
		return sqlSession.delete("Diary.deleteItemTag", diaryNo);
	}
	
	@Override
	public int deleteDiaryImg(int diaryNo) throws Throwable {
		return sqlSession.delete("Diary.deleteDiaryImg", diaryNo);
	}

	@Override
	public int updateDiaryData(Map<String, Object> diaryParams) throws Throwable {
		return sqlSession.insert("Diary.updateDiaryData", diaryParams);
	}

	@Override
	public int updateDiaryCon(Map<String, Object> diaryParams) throws Throwable {
		return sqlSession.update("Diary.updateDiaryCon", diaryParams);
	}

	@Override
	public int deleteDiary(int diaryNo) throws Throwable {
		return sqlSession.update("Diary.deleteDiary", diaryNo);
	}

}
