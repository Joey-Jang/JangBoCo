package com.gdj37.jangboco.web.diary.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DiaryDao implements IDiaryDao{
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int addMember(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("Member.addMember", params);
	}

	@Override
	public int getAllDiaryCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getAllDiaryCnt");
	}

	@Override
	public List<HashMap<String, String>> getAllDiaryList(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getAllDiaryList",params);
	}

	@Override
	public int getSearchDiaryCnt(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getSearchDiaryCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getSearchDiaryList(HashMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getSearchDiaryList",params);
	}

	@Override
	public int getLikeDiaryCnt(int member_no) throws Exception {
		return sqlSession.selectOne("DiarySW.getLikeDiaryCnt",member_no);
	}

	@Override
	public int getMemberNo(String email) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getMemberNo",email);
	}

	@Override
	public List<HashMap<String, String>> getLikeDiaryList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getLikeDiaryList", params);
	}

	@Override
	public int getDiaryPernlCnt(int member_no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getDiaryPernlCnt",member_no);
	}

	@Override
	public List<HashMap<String, String>> getDiaryPernlList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getDiaryPernlList",params);
	}

	@Override
	public String getMemberImg(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getMemberImg", params);
	}

	@Override
	public HashMap<String, Integer> getFolwrFolwng(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.getFolwrFolwng", params);
	}

	@Override
	public List<HashMap<String, String>> getFolwrList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getFolwrList", params);
	}

	@Override
	public List<HashMap<String, String>> getFolwngList(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DiarySW.getFolwngList", params);
	}

	@Override
	public int checkFolw(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("DiarySW.checkFolw", params);
	}

	@Override
	public void unflow(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("DiarySW.unfolw", params);
	}

	@Override
	public void folw(HashMap<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("DiarySW.folw",params);
	}

	
}
