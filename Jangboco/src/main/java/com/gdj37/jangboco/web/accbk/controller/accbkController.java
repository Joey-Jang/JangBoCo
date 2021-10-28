package com.gdj37.jangboco.web.accbk.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
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
import com.gdj37.jangboco.web.accbk.service.accbkIService;


@Controller
public class accbkController {

	@Autowired
	accbkIService accbkiService;
	
	@Autowired
	IPagingService iPagingService;
	
	//가계부 메인페이지
	@RequestMapping(value = "/accbkMain")
	public ModelAndView accbkMain(@RequestParam HashMap<String, String> params,
								 ModelAndView mav)throws Throwable {
		
		DecimalFormat df = new DecimalFormat("00");
        Calendar currentCalendar = Calendar.getInstance();
        String thisMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
		
		params.put("buy_date",thisMonth);
		
		HashMap<String, String> getThisMonthSpend = accbkiService.getThisMonthSpend(params);
		HashMap<String, String> getMostSpendDay = accbkiService.getMostSpendDay(params);
		HashMap<String, String> getMostVisitMarket = accbkiService.getMostVisitMarket(params);
		HashMap<String, String> getLeastSpendDay = accbkiService.getLeastSpendDay(params);
		HashMap<String, String> getMostSpendItems = accbkiService.getMostSpendItems(params);
		
		mav.addObject("getThisMonthSpend", getThisMonthSpend);
		mav.addObject("getMostSpendDay", getMostSpendDay);
		mav.addObject("getMostVisitMarket", getMostVisitMarket);
		mav.addObject("getLeastSpendDay", getLeastSpendDay);
		mav.addObject("getMostSpendItems", getMostSpendItems);
		
		mav.setViewName("jangboco/accbk/accbkMain");
		
		return mav;
	}
	
	
	//가계부 차트페이지
	@RequestMapping(value = "/accbkChart")
	public ModelAndView accbkChart(@RequestParam HashMap<String, String> params,
								 ModelAndView mav) {
		
		
		
		
		mav.setViewName("jangboco/accbk/accbkChart");
		
		return mav;
	}
	
	
	//기본 페이지를 띄워주기 위한 주소 mapping
	@RequestMapping(value = "/accbkR")
	public ModelAndView accbkR(@RequestParam HashMap<String, String> params,
								ModelAndView mav) {
		String page ="1";
		
		if(params.get("page")!=null) {
			page = params.get("page");	
		}
		
		mav.addObject("page",page);
		
		mav.setViewName("jangboco/accbk/accbkR");
		
		return mav;
	}
	
	@RequestMapping(value = "/accbkRAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody //view로 돌려주겠다
	public String accbkRAjax(@RequestParam HashMap<String, String>params)throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper(); 
		
		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터 담을 map
		
		//페이지 취득 
		int page = Integer.parseInt(params.get("page"));
		//개수 취득
		int cnt = accbkiService.getAccbkCnt(params);
				
		//페이징 정보 취득 
		PagingBean pb = iPagingService.getPagingBean(page,cnt,5,2);
		
		//데이터 시작, 종료값 할당 
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		//list 조회
		List<HashMap<String, String>> list = accbkiService.getAccbkList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	
	@RequestMapping(value = "/accbkC")
	public ModelAndView accbkC(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		//List<HashMap<String, String>> marketList =  accbkiService.getMarketList(params);
		List<HashMap<String, String>> itemsList = accbkiService.getItemsList(params);
		
		//mav.addObject("marketList", marketList);
		
		mav.addObject("itemsList", itemsList);
		
		mav.setViewName("jangboco/accbk/accbkC");
		return mav;
	}
	
	@RequestMapping(value = "/getAccbkDisctListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getAccbkDisctListAjax()throws Throwable{
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap =  new HashMap<String, Object>();
	
	List<HashMap<String, Object>> disctList = accbkiService.getDisctList();
	
	modelMap.put("disctList",disctList);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value = "/searchAccbkMarketAjax", method = RequestMethod.POST,
							produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchAccbkMarketAjax(@RequestParam HashMap<String, String> params)throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap =  new HashMap<String, Object>();
		
		List<HashMap<String, String >> marketList = accbkiService.searchMarket(params);
		
		modelMap.put("marketList", marketList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/searchAccbkBranchAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchAccbkBranchAjax(@RequestParam HashMap<String, String> params)throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap =  new HashMap<String, Object>();
		
		List<HashMap<String, String>> branchList = accbkiService.getBranchList(params);
		
		modelMap.put("branchList", branchList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	@RequestMapping(value = "/accbkCAjax", method = RequestMethod.POST,
							produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String accbkCAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "success";
		
		try {
			System.out.println("accbkCAjax params ====== "+params);
			int cnt =  accbkiService.writeAccbk(params);
			
			if(cnt == 0) {
				msg = "failed";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "error";
		} //try catch 끝
		
		modelMap.put("msg", msg);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/accbkU")
	public ModelAndView accbkU(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		if (params.get("update_no")!=null) {
			
			mav.setViewName("jangboco/accbk/accbkU");
			
			List<HashMap<String, String>> list =  accbkiService.getMarketList(params);
			List<HashMap<String, String>> itemsList = accbkiService.getItemsList(params);
			
			HashMap<String, String> data = accbkiService.getAccbk(params);
			mav.addObject("data", data);
			
			
			mav.addObject("list", list);
			mav.addObject("itemsList", itemsList);
		}else {
			mav.setViewName("redirect:accbkR");
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/accbkUAjax", method = RequestMethod.POST,
							produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String accbkUAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "success";
		
		try {
			System.out.println(params);
			int cnt =  accbkiService.updateAccbk(params);
			
			if(cnt == 0) {
				msg = "failed";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "error";
		} //try catch 끝
		
		modelMap.put("msg", msg);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	
	
	@RequestMapping(value = "/accbkDAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String accbkDAjax(@RequestParam HashMap<String,String> params) throws Throwable{
		JSONParser parser = new JSONParser();
		JSONArray array = (JSONArray)parser.parse(params.get("del_chkbx"));
		 ObjectMapper mapper = new ObjectMapper();
		 Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<Integer> list = new ArrayList<>();
		String msg = "success";
		try {
			for(int i = 0; i< array.size(); i++) {
				list.add(i, Integer.parseInt((String) array.get(i)));
				//accbkiService.delAccbk(Integer.parseInt((String) array.get(i)));
			}
			
			int cnt = accbkiService.delAccbk(list);
			
			if (cnt == 0) {
				msg = "failed";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "error";
		}
		

		modelMap.put("msg", msg);
//	return String.valueOf(params);
		return mapper.writeValueAsString(modelMap);
	}
}
