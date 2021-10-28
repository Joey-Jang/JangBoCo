package com.gdj37.jangboco.web.diaryjj.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gdj37.jangboco.web.diaryjj.service.DiaryServiceIF;

@Controller
public class DairyjjController {

	@Autowired
	public DiaryServiceIF diaryService;
	
	@RequestMapping(value = "/writeDiary")
	public ModelAndView writeDiary(ModelAndView mav) {
		int menuIdx = 1;
		int subMenuIdx = 3;
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		mav.setViewName("jangboco/diary/writeDiary");
		
		return mav;
	}
	
	@RequestMapping(value = "/getDisctListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String getDisctListAjax() throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> disctList = diaryService.getDisctList();
		
		modelMap.put("disctList", disctList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/searchMarketDiaryAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchMarketDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> marketList = diaryService.getMarketList(params);
		
		modelMap.put("marketList", marketList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/searchBranchDiaryAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchBranchDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> branchList = diaryService.getBranchList(params);
		
		modelMap.put("branchList", branchList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/searchItemsDiaryAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchItemsDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> itemsList = diaryService.getItemsList(params);
		
		modelMap.put("itemsList", itemsList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/writeDiaryAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("unchecked")
	public String writeDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String memberNo = params.get("memberNo");
		String diaryImgJSONStr = params.get("diaryImgList");
		String itemTagJSONStr = params.get("itemTagList");
		String con = params.get("con");
		
		Map<String, Object> diaryParams = new HashMap<String, Object>();
		
		diaryParams.put("memberNo", memberNo);
		diaryParams.put("con", con);
		
		JSONParser parser = new JSONParser();
		JSONArray diaryImgListJSONArr = (JSONArray) parser.parse(diaryImgJSONStr);
		JSONArray itemTagListsJSONArr = (JSONArray) parser.parse(itemTagJSONStr);
		
		String msg = "SUCCESS";
		try {
			List<Map<String, Object>> diaryImgList = new ArrayList<Map<String, Object>>();
			
			// i번째 일기 번호에 해당하는 사진, 태그들
			for(int i=0; i<diaryImgListJSONArr.size(); i++) {
				Map<String, Object> diaryImgData = new HashMap<String, Object>();
				
				// i번째 diaryImgData에 i번째 일기 사진 추가
				diaryImgData.put("diaryImgUrl", (String) diaryImgListJSONArr.get(i));
				
				// i번째 일기 사진의 태그들 JOSNArray
				JSONArray itemTagListJSONArr = (JSONArray) itemTagListsJSONArr.get(i);
				// JSONArray<JSONObject>에서 ArrayList<HashMap>으로 변환
				List<Map<String, Object>> itemTaglist = new ArrayList<Map<String, Object>>();
				
				if(itemTagListJSONArr != null) {
					for(int j=0; j<itemTagListJSONArr.size(); j++) {
						JSONObject itemTagDataJSONObj = (JSONObject) itemTagListJSONArr.get(j);
						
						Map<String, Object> itemTagData = null;
						
						try {
							itemTagData = new ObjectMapper().readValue(itemTagDataJSONObj.toJSONString(), Map.class) ;
				        } catch (JsonParseException jpe) {
				            jpe.printStackTrace();
				        } catch (JsonMappingException jme) {
				            jme.printStackTrace();
				        } catch (IOException ioe) {
				            ioe.printStackTrace();
				        }
						
						itemTaglist.add(itemTagData);
					}
				}
				
				// i번째 diaryImgData에 i번째 일기 사진의 태그들 추가
				diaryImgData.put("itemTaglist", itemTaglist);
				// diaryImgList에 i번째 diaryImgList 추가
				diaryImgList.add(diaryImgData);
			}
			// diaryParams에 diaryImgList 추가
			diaryParams.put("diaryImgList", diaryImgList);
			
			// 일기 등록
			int cnt = diaryService.addDiaryData(diaryParams);
			if(cnt==0) {
				msg = "FAILED";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "ERROR";
		}
		
		modelMap.put("msg", msg);
		
		return mapper.writeValueAsString(modelMap);
	}
	
}
