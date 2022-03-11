package com.gdj37.jangboco.web.admin.controller;

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
import com.gdj37.jangboco.web.admin.service.AdminServiceIF;

@Controller
public class AdminController {

	@Autowired
	public AdminServiceIF adminService;
	
	@Autowired
	public IPagingService pagingService;
	
	@RequestMapping(value = "/memberManage")
	public ModelAndView memberManage(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		int page = 1;
		if(!"".equals(params.get("page")) && params.get("page")!=null) {
			page = Integer.parseInt(params.get("page"));
		}
		
		int maxCount = adminService.cntMember(params);
		PagingBean pb = pagingService.getPagingBean(page, maxCount, 10, 5);
		if(page > pb.getMaxPcount()) {
			page = pb.getMaxPcount();
		}
		
		mav.addObject("page", page);
		
		mav.setViewName("jangboco/admin/memberManage");
		
		return mav;
	}
	
	@RequestMapping(value = "/getMemberListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getMemberListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int page = Integer.parseInt(params.get("page"));
		int maxCount = adminService.cntMember(params);
		
		PagingBean pb = pagingService.getPagingBean(page, maxCount, 10, 5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String, Object>> list = adminService.getMemberList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
			
		return mapper.writeValueAsString(modelMap);
	}
	
}
