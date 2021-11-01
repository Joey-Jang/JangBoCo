package com.gdj37.jangboco.web.notice.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class noticeDao implements noticeIDao {

	@Autowired
	SqlSession sqlsession;

	@Override
	public int getNoticeCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("notice.getNoticeCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("notice.getNoticeList", params);
	}

	@Override
	public int updateNoticeHot(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("notice.updateNoticeHit", params);
	}

	@Override
	public HashMap<String, String> getNoticeDtl(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("notice.getNoticeDtl", params);
	}

	@Override
	public List<HashMap<String, String>> getNoticeBestList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("notice.getNoticeBestList", params);
	}

	@Override
	public int writeNotice(HashMap<String, String> params) throws Throwable {
		return sqlsession.insert("notice.writeNotice", params);
	}

	@Override
	public int updateNotice(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("notice.updateNotice", params);
	}

	@Override
	public int delNotice(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("notice.delNotice", params);
	}
}
