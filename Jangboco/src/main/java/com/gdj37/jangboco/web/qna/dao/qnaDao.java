package com.gdj37.jangboco.web.qna.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class qnaDao implements qnaIDao{

	@Autowired
	SqlSession sqlsession;

	@Override
	public int getQnaCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("qna.getQnaCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getQnaList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("qna.getQnaList", params);
	}
}
