package com.gdj37.jangboco.web.test.controller;

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
	public ModelAndView layoutConBlank(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		mav.setViewName("jangboco/home");
		
		return mav;
	}

	@RequestMapping(value = "/reloadPageAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testAMCUDAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		params.put("memberNo", "1"); // 임시세팅 회원번호 1번
		List<HashMap<String, Object>> list = locService.getRecentLocList(params);
		
		modelMap.put("list", list);
		
		return mapper.writeValueAsString(modelMap);
	}
}
