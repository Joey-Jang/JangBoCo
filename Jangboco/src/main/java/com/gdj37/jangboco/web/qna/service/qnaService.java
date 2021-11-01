package com.gdj37.jangboco.web.qna.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.qna.dao.qnaIDao;

@Service
public class qnaService implements qnaIService{

	@Autowired
	public qnaIDao qnaiDao;
}
