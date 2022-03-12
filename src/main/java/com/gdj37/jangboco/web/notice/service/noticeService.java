package com.gdj37.jangboco.web.notice.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.notice.dao.noticeIDao;

@Primary
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

	@Override
	public int updateNoticeHit(HashMap<String, String> params) throws Throwable {
		return noticeiDao.updateNoticeHot(params);
	}

	@Override
	public HashMap<String, String> getNoticeDtl(HashMap<String, String> params) throws Throwable {
		return noticeiDao.getNoticeDtl(params);
	}

	@Override
	public List<HashMap<String, String>> getNoticeBestList(HashMap<String, String> params) throws Throwable {
		return noticeiDao.getNoticeBestList(params);
	}

	@Override
	public int writeNotice(HashMap<String, String> params) throws Throwable {
		return noticeiDao.writeNotice(params);
	}

	@Override
	public int updateNotice(HashMap<String, String> params) throws Throwable {
		return noticeiDao.updateNotice(params);
	}

	@Override
	public int delNotice(HashMap<String, String> params) throws Throwable {
		return noticeiDao.delNotice(params);
	}
}
