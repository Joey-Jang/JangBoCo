package com.gdj37.jangboco.web.notice.dao;

import java.util.HashMap;
import java.util.List;

public interface noticeIDao {

	public int getNoticeCnt(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params)throws Throwable;

	public int updateNoticeHot(HashMap<String, String> params)throws Throwable;

	public HashMap<String, String> getNoticeDtl(HashMap<String, String> params)throws Throwable;

	public List<HashMap<String, String>> getNoticeBestList(HashMap<String, String> params)throws Throwable;

	public int writeNotice(HashMap<String, String> params)throws Throwable;

	public int updateNotice(HashMap<String, String> params)throws Throwable;

	public int delNotice(HashMap<String, String> params)throws Throwable;

}
