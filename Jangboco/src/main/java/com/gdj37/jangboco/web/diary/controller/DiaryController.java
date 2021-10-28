package com.gdj37.jangboco.web.diary.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.common.bean.PagingBean;
import com.gdj37.jangboco.common.service.IPagingService;
import com.gdj37.jangboco.web.diary.service.IDiaryService;

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
		return mapper.writeValueAsString(modelMap);
	}

	
	@RequestMapping(value = "/diaryLike")
	public ModelAndView diaryLike(ModelAndView mav) {
		mav.setViewName("jangboco/diary/diaryLike");
		return mav;
	}
	
	@RequestMapping(value = "/diaryLikeListAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String diaryLikeListAjax(@RequestParam HashMap<String,Object> params, HttpSession session) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
	
		int page = 1;
		int cnt = 0;
		
		// 넘어온 페이지 값이 있을 경우 페이지 값 셋팅
		if(!params.get("page").equals("")&&params.get("page")!=null) {
			page = Integer.parseInt((String) params.get("page"));
			System.out.println(page);
		}
		
		String email = (String) session.getAttribute("email");
		int member_no = iDiaryService.getMemberNo(email);
		cnt = iDiaryService.getLikeDiaryCnt(member_no);
		//비었을때
		//공통
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 8, 3);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		params.put("member_no", member_no);
		
		list = iDiaryService.getLikeDiaryList(params);
			
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/diaryPernlPage")
	public ModelAndView diaryMypage(ModelAndView mav) {
		mav.addObject("page_member_no", 1);
		mav.setViewName("jangboco/diary/diaryPernlPage");
		return mav;
	}
	
	@RequestMapping(value = "/diaryPernlListAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String diaryPernlListAjax(@RequestParam HashMap<String,Object> params, HttpSession session) throws Throwable{
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
		int page = 1;
		int cnt = 0;
		int pageMemberNo = Integer.parseInt((String) params.get("page_member_no"));
		// 넘어온 페이지 값이 있을 경우 페이지 값 셋팅
		if(!params.get("page").equals("")&&params.get("page")!=null) {
			page = Integer.parseInt((String) params.get("page"));
			System.out.println(page);
		}
		
		cnt = iDiaryService.getDiaryPernlCnt(pageMemberNo);
		//비었을때
		//공통
		PagingBean pb = iPagingService.getPagingBean(page, cnt, 6, 3);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		list = iDiaryService.getDiaryPernlList(params);
					
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		return mapper.writeValueAsString(modelMap);
	}
	
	
}
