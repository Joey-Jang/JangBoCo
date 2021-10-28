package com.gdj37.jangboco.web.diary.dao;

import java.util.HashMap;
import java.util.List;

public interface IDiaryDao {

	public int addMember(HashMap<String, String> params) throws Exception;

	public int getAllDiaryCnt() throws Exception;

	public List<HashMap<String, String>> getAllDiaryList(HashMap<String, String> params) throws Exception;

	public int getSearchDiaryCnt(HashMap<String, String> params) throws Exception;

	public List<HashMap<String, String>> getSearchDiaryList(HashMap<String, String> params) throws Exception;

	public int getLikeDiaryCnt(int member_no) throws Exception;

	public int getMemberNo(String email) throws Exception;

	public List<HashMap<String, String>> getLikeDiaryList(HashMap<String, Object> params) throws Exception;

	public int getDiaryPernlCnt(int member_no) throws Exception;

	public List<HashMap<String, String>> getDiaryPernlList(HashMap<String, Object> params) throws Exception;


}
