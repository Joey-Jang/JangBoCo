package com.gdj37.jangboco.web.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LayoutController {

	@RequestMapping(value = "/layoutTopLeft")
	public ModelAndView layoutTopLeft(ModelAndView mav) {
		mav.setViewName("jangboco/layoutTopLeft");
		
		return mav;
	}
	
	@RequestMapping(value = "/home")
	public ModelAndView layoutConBlank(ModelAndView mav) {
		mav.setViewName("jangboco/home");
		
		return mav;
	}

}
