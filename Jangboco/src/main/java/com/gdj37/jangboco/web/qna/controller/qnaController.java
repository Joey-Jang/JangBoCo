package com.gdj37.jangboco.web.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gdj37.jangboco.common.service.IPagingService;
import com.gdj37.jangboco.web.qna.service.qnaIService;

@Controller
public class qnaController {

	@Autowired
	qnaIService qnaiService;
	
	@Autowired
	IPagingService iPagingService;
}
