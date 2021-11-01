package com.gdj37.jangboco.web.notice.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.notice.dao.noticeIDao;

@Service
public class noticeService implements noticeIService {

	@Autowired
	public noticeIDao noticeiDao;

	@Override
	public int getNoticeCnt(HashMap<String, String> params) throws Throwable {
		return noticeiDao.getNoticeCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params) throws Throwable {
		return noticeiDao.getNoticeList(params);
	}
}
