package com.gdj37.jangboco.web.notice.service;

import java.util.HashMap;
import java.util.List;

public interface noticeIService {

	public int getNoticeCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params)throws Throwable;


}
