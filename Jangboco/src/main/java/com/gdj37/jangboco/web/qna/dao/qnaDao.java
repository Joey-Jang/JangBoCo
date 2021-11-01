package com.gdj37.jangboco.web.qna.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class qnaDao implements qnaIDao{

	@Autowired
	SqlSession sqlsession;
}
