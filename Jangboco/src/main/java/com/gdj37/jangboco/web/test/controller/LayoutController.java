package com.gdj37.jangboco.web.test.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.web.test.service.LocServiceIF;

@Controller
public class LayoutController {

	@Autowired
	public LocServiceIF locService;
	
	@RequestMapping(value = "/layoutTopLeft")
	public ModelAndView layoutTopLeft(ModelAndView mav) throws Throwable {
		mav.setViewName("jangboco/layoutTopLeft");
		
		return mav;
	}
	
	@RequestMapping(value = "/home")
	public ModelAndView layoutConBlank(ModelAndView mav, HttpSession session) throws Throwable {
		System.out.println("home test");
		System.out.println(session.getAttribute("email"));
		
		mav.setViewName("jangboco/home");
		
		return mav;
	}

	@RequestMapping(value = "/reloadMainLocAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadMainLocAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 추후에 세션 sMNo로 대체
		String memberNo = "2"; // 임시 회원번호
		if(!"".equals(params.get("member_no")) && params.get("member_no")!=null) {
			memberNo = params.get("member_no");
		}
		params.put("member_no", memberNo);
		
		if(!"".equals(memberNo) && memberNo!=null) {
			modelMap.put("memberNo", memberNo);
			
			HashMap<String, Object> memberAddrs = locService.getMemberAddrs(params);
			modelMap.put("memberAddrs", memberAddrs);
		}
		
		int cntRecentLoc = locService.cntRecentLoc(params);
		modelMap.put("cntRecentLoc", cntRecentLoc);
		
		HashMap<String, Object> latestLocData = locService.getLatestLocData(params);
		modelMap.put("latestLocData", latestLocData);
		
		List<HashMap<String, Object>> recentLocList = locService.getRecentLocList(params);
		modelMap.put("recentLocList", recentLocList);
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadRecentLocListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadRecentLocListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 회원이 아니면 최근 위치 출력하지 않음 => AOP로 추후에 구현
		String memberNo = "2"; // 임시 회원번호
		if(!"".equals(params.get("member_no")) && params.get("member_no")!=null) {
			memberNo = params.get("member_no");
		}
		params.put("member_no", memberNo);
		
		List<HashMap<String, Object>> recentLocList = locService.getRecentLocList(params);
		modelMap.put("recentLocList", recentLocList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/setLocAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String setLocAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 회원이 아니면 최근 위치 저장하지 않음 => AOP로 추후에 구현
		String msg = "FAILED";
		try {
			int cnt = 0;
			if(!"".equals(params.get("latest_loc_no")) && params.get("latest_loc_no")!=null) {
				cnt = locService.updateRecentLocData(params);
			} else {
				cnt = locService.addRecentLocData(params);
			}
			
			if(cnt > 0) {
				msg = "SUCCESS";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "ERROR";
		}
		
		modelMap.put("msg", msg);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/delRecentLocDataAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String delRecentLocDataAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
//		System.out.println("*** CHECK parms ***");
//		Set<Map.Entry<String, String>> entrySet = params.entrySet();
//		Iterator<Map.Entry<String, String>> entryIterator = entrySet.iterator();
//		while(entryIterator.hasNext()) {
//			Map.Entry<String, String> entry = entryIterator.next();
//			String key = entry.getKey();
//			String value = entry.getValue();
//			System.out.print("key: " + key);
//			System.out.print("value: " + value);
//			System.out.println();
//		}
		
		// 회원이 아니면 최근 위치 삭제하지 않음 => AOP로 추후에 구현
		String msg = "FAILED";
		try {
			int cnt = 0;
			cnt = locService.delRecentLocData(params);
			
			if(cnt > 0) {
				msg = "SUCCESS";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "ERROR";
		}
		
		modelMap.put("msg", msg);
		
		return mapper.writeValueAsString(modelMap);
	}

}
