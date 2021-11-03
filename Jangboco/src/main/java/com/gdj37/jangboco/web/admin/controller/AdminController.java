package com.gdj37.jangboco.web.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gdj37.jangboco.web.admin.service.AdminServiceIF;

@Controller
public class AdminController {

	@Autowired
	public AdminServiceIF adminService;
	
	@RequestMapping(value = "/memberManage")
	public ModelAndView memberManage(ModelAndView mav) throws Throwable {
		mav.setViewName("jangboco/admin/memberManage");
		
		return mav;
	}
	
}
