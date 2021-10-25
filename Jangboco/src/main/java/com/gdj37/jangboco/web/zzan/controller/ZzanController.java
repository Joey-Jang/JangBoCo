package com.gdj37.jangboco.web.zzan.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj37.jangboco.web.zzan.service.IZzanService;

@Controller
public class ZzanController {
	//@Autowired
	//public IZzanService iZzanService;
	
	@RequestMapping(value="/zzanMain")
	public ModelAndView zzanMain(@RequestParam HashMap<String,String> params,
			ModelAndView mav) {
		
		mav.setViewName("jangboco/zzan/zzanMain");
		
		return mav;
	}
}
