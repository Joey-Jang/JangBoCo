package com.gdj37.jangboco.web.notice.service;

import java.util.HashMap;
import java.util.List;

public interface noticeIService {

	public int getNoticeCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params)throws Throwable;

	public int updateNoticeHit(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getNoticeDtl(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getNoticeBestList(HashMap<String, String> params)throws Throwable;

	public int writeNotice(HashMap<String, String> params)throws Throwable;

	public int updateNotice(HashMap<String, String> params)throws Throwable;

	public int delNotice(HashMap<String, String> params)throws Throwable;


}
