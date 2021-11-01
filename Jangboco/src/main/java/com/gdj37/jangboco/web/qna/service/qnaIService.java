package com.gdj37.jangboco.web.qna.service;

import java.util.HashMap;
import java.util.List;

public interface qnaIService {

	public int getQnaCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getQnaList(HashMap<String, String> params)throws Throwable;

}
