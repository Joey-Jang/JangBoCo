package com.gdj37.jangboco.web.qna.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.qna.dao.qnaIDao;

@Service
public class qnaService implements qnaIService{

	@Autowired
	public qnaIDao qnaiDao;

	@Override
	public int getQnaCnt(HashMap<String, String> params) throws Throwable {
		return qnaiDao.getQnaCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getQnaList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return qnaiDao.getQnaList(params);
	}
}
