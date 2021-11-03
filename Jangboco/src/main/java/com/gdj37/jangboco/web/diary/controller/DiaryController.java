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
		int homeFlag = 0;
		int menuIdx = 1;
		int subMenuIdx = 0;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
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
	public ModelAndView diaryLike(HttpSession session, ModelAndView mav) {
		int homeFlag = 0;
		int menuIdx = 1;
		int subMenuIdx = 1;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		if(!"".equals(session.getAttribute("sMNo")) && session.getAttribute("sMNo")!=null) {
			mav.addObject("page_member_no", session.getAttribute("sMNo"));
			
			mav.setViewName("jangboco/diary/diaryLike");
		} else {
			mav.setViewName("redirect:loginMain");
		}
		
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
	
	@RequestMapping(value = "/hastgListAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String hastgListAjax(@RequestParam HashMap<String,Object> params, HttpSession session) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
		list = iDiaryService.getHastgList(params);
		modelMap.put("list", list);
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/diaryPernlPage")
	public ModelAndView diaryMypage(HttpSession session, @RequestParam HashMap<String,Object> params, ModelAndView mav) {
		int homeFlag = 0;
		int menuIdx = 1;
		int subMenuIdx = 2;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		if(!"".equals(session.getAttribute("sMNo")) && session.getAttribute("sMNo")!=null) {
			mav.addObject("page_member_no", session.getAttribute("sMNo"));
			mav.setViewName("jangboco/diary/diaryPernlPage");
		} else if(!"".equals(params.get("diary_member_no")) && params.get("diary_member_no")!=null) {
			mav.addObject("page_member_no", params.get("diary_member_no"));
			mav.setViewName("jangboco/diary/diaryPernlPage");
		} else {
			mav.setViewName("redirect:loginMain");
		}
		
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
	
	
	@RequestMapping(value = "/getMemberImgAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String getMemberImgAjax(@RequestParam HashMap<String,Object> params) throws Throwable{
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		String img_url = iDiaryService.getMemberImg(params);
		modelMap.put("img_url",img_url);
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getFolwrFolwngAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String getFolwrFolwngAjax(@RequestParam HashMap<String,Object> params) throws Throwable{
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String,Integer> hm = iDiaryService.getFolwrFolwng(params);
		modelMap.put("folw",hm);
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value = "/getFolwrAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String getFolwrAjax(@RequestParam HashMap<String,Object> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
		list = iDiaryService.getFolwrList(params);
		modelMap.put("list",list);
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getFolwngAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String getFolwngAjax(@RequestParam HashMap<String,Object> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list  = new ArrayList();
		list = iDiaryService.getFolwngList(params);
		modelMap.put("list",list);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/checkFolwAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String checkFolwAjax(@RequestParam HashMap<String,Object> params,HttpSession session) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(session.getAttribute("sMNo")!=null&&!session.getAttribute("sMNo").equals("")) {
		params.put("my_member_no", session.getAttribute("sMNo"));
		int cnt = iDiaryService.checkFolw(params);
		modelMap.put("result", cnt);
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/doFolwUnFolwAjax", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String doFolwUnFolwAjax(@RequestParam HashMap<String,Object> params,HttpSession session) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(session.getAttribute("sMNo")!=null&&!session.getAttribute("sMNo").equals("")) {	
		params.put("my_member_no", session.getAttribute("sMNo"));
		String flag = (String) params.get("flag");
		if(flag.equals("unfolw")) {
			iDiaryService.unfolw(params);
		} else if(flag.equals("folw")) {
			iDiaryService.folw(params);
		}
		modelMap.put("result", "success");
		}
		return mapper.writeValueAsString(modelMap);
	}
}
