package com.gdj37.jangboco.web.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.common.bean.PagingBean;
import com.gdj37.jangboco.common.service.IPagingService;
import com.gdj37.jangboco.web.qna.service.qnaIService;


@Controller
public class qnaController {

	@Autowired
	qnaIService qnaiService;
	
	@Autowired
	IPagingService iPagingService;
	
	//기본 페이지를 띄워주기 위한 주소 mapping
	@RequestMapping(value = "/qnaR")
	public ModelAndView qnaR(@RequestParam HashMap<String, String> params,
								ModelAndView mav) {
		
		
		String page ="1";
		
		if(params.get("page")!=null) {
			page = params.get("page");	
		}
		
		mav.addObject("page",page);
		
		mav.setViewName("jangboco/qna/qnaR");
		
		return mav;
	}
	
	@RequestMapping(value = "/QnaListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody //view로 돌려주겠다
	public String QnaListAjax(@RequestParam HashMap<String, String>params)throws Throwable{
	
	ObjectMapper mapper = new ObjectMapper(); 
	
	Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터 담을 map
	
	//페이지 취득 
	int page = Integer.parseInt(params.get("page"));
	//개수 취득
	int cnt = qnaiService.getQnaCnt(params);
			
	//페이징 정보 취득 
	PagingBean pb = iPagingService.getPagingBean(page,cnt,10,5);
	
	//데이터 시작, 종료값 할당 
	params.put("startCnt", Integer.toString(pb.getStartCount()));
	params.put("endCnt", Integer.toString(pb.getEndCount()));
	
	//list 조회
	List<HashMap<String, String>> list = qnaiService.getQnaList(params);
	
	modelMap.put("list", list);
	modelMap.put("pb", pb);
	
	return mapper.writeValueAsString(modelMap);
}
	
}
