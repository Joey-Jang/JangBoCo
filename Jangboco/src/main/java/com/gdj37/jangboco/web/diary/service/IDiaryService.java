package com.gdj37.jangboco.web.diary.service;

import java.util.HashMap;
import java.util.List;

public interface IDiaryService {

	public int addMember(HashMap<String, String> params) throws Exception;

	public int getAllDiaryCnt() throws Exception;

	public List<HashMap<String, String>> getAllDiaryList(HashMap<String, String> params) throws Exception;

	public int getSearchDiaryCnt(HashMap<String, String> params) throws Exception;

	public List<HashMap<String, String>> getSearchDiaryList(HashMap<String, String> params) throws Exception;


}