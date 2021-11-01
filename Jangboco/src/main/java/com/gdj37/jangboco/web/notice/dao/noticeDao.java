package com.gdj37.jangboco.web.notice.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class noticeDao implements noticeIDao{

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
}
