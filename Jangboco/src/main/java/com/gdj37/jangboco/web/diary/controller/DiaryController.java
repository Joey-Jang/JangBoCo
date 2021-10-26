package com.gdj37.jangboco.web.diary.controller;

import java.util.ArrayList;
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
import com.gdj37.jangboco.web.diary.service.IDiaryService;
import com.gdj37.jangboco.web.join.service.IJoinService;

@Controller
public class DiaryController {
	
    @Autowired
    public IDiaryService iDiaryService;
    
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value = "/diaryMain")
	public ModelAndView diaryMain(ModelAndView mav) {
		mav.setViewName("jangboco/diary/main");
		return mav;
	}
	
	@RequestMapping(value = "/diaryMain2")
	public ModelAndView diaryMain2(ModelAndView mav) {
		mav.setViewName("jangboco/diary/main2");
		return mav;
	}
	
	@RequestMapping(value = "/diaryListAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String diaryListAjax(@RequestParam HashMap<String,String> params) throws Throwable{
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
	
		int page = 1;
		int cnt = 0;
		
		// 넘어온 페이지 값이 있을 경우 페이지 값 셋팅
		if(!params.get("page").equals("")&&params.get("page")!=null) {
			page = Integer.parseInt(params.get("page"));
			System.out.println(page);
		}
		
		String searchTxt = params.get("searchTxt");
		
		//파람에 뭐가 있을때 계속실행
		if(!searchTxt.equals("")&&searchTxt != null) {
			cnt = iDiaryService.getSearchDiaryCnt(params);
		} else {
			cnt = iDiaryService.getAllDiaryCnt();
		}
		//비었을때
		//공통
		System.out.println("testtttttttt"+cnt);
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 8, 3);
		
		System.out.println(pb);
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		
		if(!searchTxt.equals("")&&searchTxt != null) {
			list = iDiaryService.getSearchDiaryList(params);
		} else {
			list = iDiaryService.getAllDiaryList(params);
		}
			
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		System.out.println("ttttttteeeeeeeeessssssssttttttttttt"+cnt);
		return mapper.writeValueAsString(modelMap);
	}


}
