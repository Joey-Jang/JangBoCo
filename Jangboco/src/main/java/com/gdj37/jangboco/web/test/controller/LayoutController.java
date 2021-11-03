package com.gdj37.jangboco.web.test.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.gdj37.jangboco.web.zzan.service.IZzanService;

@Controller
public class LayoutController {

	@Autowired
	public LocServiceIF locService;
	
	@Autowired
	public IZzanService iZzanService;
	
	@RequestMapping(value = "/layoutTopLeft")
	public ModelAndView layoutTopLeft(ModelAndView mav) throws Throwable {
		mav.setViewName("jangboco/layoutTopLeft");
		
		return mav;
	}
	
	@RequestMapping(value = "/home")
	public ModelAndView layoutConBlank(ModelAndView mav, HttpSession session,
									@RequestParam HashMap<String, String> params) throws Throwable {
		int homeFlag = 1;
		int menuIdx = 0;
		int subMenuIdx = 0;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		List<HashMap<String, String>> list = iZzanService.getMarketList(params);
		
		mav.addObject("list", list);
		
		mav.setViewName("jangboco/zzan/zzanMain");
		
		return mav;
	}

	@RequestMapping(value = "/reloadMainLocAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadMainLocAjax(HttpServletRequest request, @RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		if(!"".equals(params.get("member_no")) && params.get("member_no")!=null) {
			HashMap<String, Object> memberAddrs = locService.getMemberAddrs(params);
			modelMap.put("memberAddrs", memberAddrs);
			
			int cntRecentLoc = locService.cntRecentLoc(params);
			modelMap.put("cntRecentLoc", cntRecentLoc);
			
			HashMap<String, Object> latestLocData = locService.getLatestLocData(params);
			modelMap.put("latestLocData", latestLocData);
			
			List<HashMap<String, Object>> recentLocList = locService.getRecentLocList(params);
			modelMap.put("recentLocList", recentLocList);
		} else {
			Cookie[] cookies = request.getCookies();
			modelMap.put("cookies", cookies);
		}
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value = "/reloadRecentLocListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String reloadRecentLocListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 회원이 아니면 최근 위치 출력하지 않음 => AOP로 추후에 구현
		if(!"".equals(params.get("member_no")) && params.get("member_no")!=null) {
			String memberNo = params.get("member_no");
			params.put("member_no", memberNo);
		}
		
		List<HashMap<String, Object>> recentLocList = locService.getRecentLocList(params);
		modelMap.put("recentLocList", recentLocList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/setLocAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String setLocAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		// 회원이 아니면 최근 위치 저장하지 않음 => AOP로 추후에 구현
		if(!"".equals(session.getAttribute("sMNo")) && session.getAttribute("sMNo")!=null) {
			try {
				int cnt = 0;
				if(!"".equals(params.get("latest_loc_no")) && params.get("latest_loc_no")!=null) {
					cnt = locService.updateRecentLocData(params);
				} else {
					cnt = locService.addRecentLocData(params);
				}
				
				if(cnt==0) {
					msg = "FAILED";
				}
			} catch (Exception e) {
				e.printStackTrace();
				
				msg = "ERROR";
			}
		} else {
			try {
				Cookie zipcdCookie = new Cookie("nonmemberZipcd", URLEncoder.encode(params.get("zipcd"), "UTF-8"));
				zipcdCookie.setMaxAge(60*60*1);
				Cookie addrsCookie = new Cookie("nonmemberAddrs", URLEncoder.encode(params.get("addrs"), "UTF-8").replaceAll("\\+", "%20"));
				addrsCookie.setMaxAge(60*60*1);
				Cookie dtlAddrsCookie = new Cookie("nonmemberDtlAddrs", URLEncoder.encode(params.get("dtl_addrs"), "UTF-8").replaceAll("\\+", "%20"));
				dtlAddrsCookie.setMaxAge(60*60*1);
				
				response.addCookie(zipcdCookie);
				response.addCookie(addrsCookie);
				response.addCookie(dtlAddrsCookie);
			} catch (Exception e) {
				e.printStackTrace();
				
				msg = "ERROR";
			}
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
