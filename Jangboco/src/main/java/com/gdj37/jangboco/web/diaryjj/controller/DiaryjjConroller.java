package com.gdj37.jangboco.web.diaryjj.controller;

import java.io.IOException;
import java.math.BigDecimal;
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
import com.gdj37.jangboco.web.diaryjj.service.DiaryServiceIF;

@Controller
public class DiaryjjConroller {

	@Autowired
	public DiaryServiceIF diaryService;
	
	@RequestMapping(value = "/writeDiary")
	public ModelAndView writeDiary(HttpSession session, ModelAndView mav) {
		int homeFlag = 0;
		int menuIdx = 1;
		int subMenuIdx = 3;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		if(!"".equals(session.getAttribute("sMNo")) && session.getAttribute("sMNo")!=null) {
			mav.addObject("page_member_no", session.getAttribute("sMNo"));
			
			mav.setViewName("jangboco/diary/writeDiary");
		} else {
			mav.setViewName("jangboco/join/loginMain");
		}
		
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

		String msg = "SUCCESS";
		
		int memberNo = Integer.parseInt(params.get("memberNo"));
		String con = params.get("con");
		
		Map<String, Object> diaryParams = new HashMap<String, Object>();
		diaryParams.put("memberNo", memberNo);
		diaryParams.put("con", con);
		
		String diaryImgJSONStr = params.get("diaryImgList");
		String itemTagJSONStr = params.get("itemTagList");
		String hastgListJSONStr = params.get("hastgList");
		JSONParser parser = new JSONParser();
		JSONArray diaryImgListJSONArr = (JSONArray) parser.parse(diaryImgJSONStr);
		JSONArray itemTagListsJSONArr = (JSONArray) parser.parse(itemTagJSONStr);
		JSONArray hastgListJSONArr = (JSONArray) parser.parse(hastgListJSONStr);
		
		List<String> hastgNameList = new ArrayList<String>();
		for(int i=0; i<hastgListJSONArr.size(); i++) {
			hastgNameList.add((String) hastgListJSONArr.get(i));
		}
		
		List<Integer> hastgNoList = new ArrayList<Integer>();
		for(int i=0; i<hastgNameList.size(); i++) {
			String hastgName = hastgNameList.get(i);
			
			int hastgDuplctCheck = diaryService.hastgDuplctCheck(hastgName);
			if(hastgDuplctCheck==0) {
				diaryParams.put("hastgName", hastgName);
				try {
					int cnt = diaryService.addHastgData(diaryParams);
					
					if(cnt==0) {
						msg = "FAILED";
					}
					
				} catch (Exception e) {
					e.printStackTrace();
					
					msg = "ERROR";
				}
			}
			
			int hastgNo = diaryService.getHastgNo(hastgName);
			hastgNoList.add(hastgNo);
		}
		diaryParams.put("hastgNoList", hastgNoList);
		
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
		
		try {
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
	
	@RequestMapping(value = "/dtlDiary")
	public ModelAndView dilDiary(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		if(!"".equals(params.get("diary_no")) && params.get("diary_no")!=null) {
			int diaryNo = Integer.parseInt(params.get("diary_no"));
			mav.addObject("diaryNo", diaryNo);
		}
		
		mav.setViewName("jangboco/diary/dtlDiary");
		return mav;
	}
	
	@RequestMapping(value = "/getDiaryDataAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String getDiaryDataAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, Object> diaryData = diaryService.getDiaryData(params);
		
		modelMap.put("diaryData", diaryData);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getDiaryImgItemTagAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String getDiaryImgItemTagAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> diaryImgList = diaryService.getDiaryImgListOnDiary(params);
		for(HashMap<String, Object> diaryImgData : diaryImgList) {
			int imgNo = Integer.parseInt(String.valueOf(diaryImgData.get("IMG_NO")));
			
			List<HashMap<String, Object>> itemTagList = diaryService.getItemTagListOnDiary(imgNo);
			diaryImgData.put("itemTagList", itemTagList);
		}
		
		modelMap.put("diaryImgList", diaryImgList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getProfileDairyListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String getProfileDairyListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> profileDiaryList = diaryService.getProfileDiaryList(params);
			
		modelMap.put("profileDiaryList", profileDiaryList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/checkDiaryLikeAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String checkDiaryLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int checkDiaryLike = diaryService.checkDiaryLike(params);
		
		modelMap.put("checkDiaryLike", checkDiaryLike);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/cntDiaryLikeAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF8")
	@ResponseBody
	public String cntDiaryLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cntDiaryLike =  diaryService.cntDiaryLike(params);
		
		modelMap.put("cntDiaryLike", cntDiaryLike);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/diaryLikeAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF8")
	@ResponseBody
	public String diaryLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt =  diaryService.diaryLike(params);

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
	
	@RequestMapping(value = "/diaryUnlikeAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF8")
	@ResponseBody
	public String diaryUnlikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt =  diaryService.diaryUnlike(params);
			
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
	
	@RequestMapping(value = "/diaryAccuseAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF8")
	@ResponseBody
	public String diaryAccuseAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt = diaryService.addDiaryAccuseData(params);

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
	
	@RequestMapping(value = "/checkDiaryFolwAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String checkDiaryFolwAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int checkDiaryFolw = diaryService.checkDiaryFolw(params);
		
		modelMap.put("checkDiaryFolw", checkDiaryFolw);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/diaryFolwAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String diaryFolwAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt =  diaryService.diaryFolw(params);

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
	
	@RequestMapping(value = "/diaryUnfolwAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String diaryUnfolwAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt =  diaryService.diaryUnfolw(params);
			
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
	
	@RequestMapping(value = "/getHastgListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String getHastgListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> hastgList = diaryService.getHastgList(params);
		
		modelMap.put("hastgList", hastgList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/getComntListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String getComntListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		List<HashMap<String, Object>> comntList = diaryService.getComntList(params);
		for(HashMap<String, Object> comntData : comntList) {
			int comntDateInt = (int) Math.ceil(((BigDecimal) comntData.get("COMNT_DATE")).doubleValue()*86400);
			String comntDateStr = "";
			if(comntDateInt < 60) {
				comntDateStr = comntDateInt + "초 전";
			} else if(comntDateInt < 3600) {
				comntDateStr = comntDateInt/60 + "분 전";
			} else if(comntDateInt < 86400) {
				comntDateStr = comntDateInt/3600 + "시간 전";
			} else {
				comntDateStr = comntDateInt/86400 + "일 전";
			}
			System.out.println(comntDateInt);
			System.out.println(comntDateStr);
			comntData.put("COMNT_DATE", comntDateStr);
					
			int parentComntNo = Integer.parseInt(String.valueOf(comntData.get("COMNT_NO")));
			
			List<HashMap<String, Object>> recomntList = diaryService.getRecomntList(parentComntNo);
			for(HashMap<String, Object> recomntData : recomntList) {
				comntDateInt = (int) Math.ceil(((BigDecimal) recomntData.get("COMNT_DATE")).doubleValue()*86400);
				if(comntDateInt < 60) {
					comntDateStr = comntDateInt + "초 전";
				} else if(comntDateInt < 3600) {
					comntDateStr = comntDateInt/60 + "분 전";
				} else if(comntDateInt < 86400) {
					comntDateStr = comntDateInt/3600 + "시간 전";
				} else {
					comntDateStr = comntDateInt/86400 + "일 전";
				}
				recomntData.put("COMNT_DATE", comntDateStr);
			}
			
			comntData.put("recomntList", recomntList);
		}
		
		modelMap.put("comntList", comntList);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/cntRecomntAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String cntRecomntAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cntRecomnt = diaryService.cntRecomnt(params);
		
		modelMap.put("cntRecomnt", cntRecomnt);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/checkComntLikeAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String checkComntLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	int checkComntLike = diaryService.checkComntLike(params);
	
	modelMap.put("checkComntLike", checkComntLike);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/cntComntLikeAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String cntComntLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	int cntComntLike =  diaryService.cntComntLike(params);
	
	modelMap.put("cntComntLike", cntComntLike);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/comntLikeAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String comntLikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	String msg = "SUCCESS";
	try {
		int cnt =  diaryService.comntLike(params);
	
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
	
	@RequestMapping(value = "/comntUnlikeAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String comntUnlikeAjax(@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	String msg = "SUCCESS";
	try {
		int cnt =  diaryService.comntUnlike(params);
		
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
	
	@RequestMapping(value = "/comntAccuseAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String comntAccuseAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt = diaryService.addComntAccuseData(params);

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
	
	@RequestMapping(value = "/addComntAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF8")
	@ResponseBody
	public String addComntAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		try {
			int cnt = diaryService.addComntData(params);
			
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
	
	@RequestMapping(value = "/updateDiary")
	public ModelAndView updateDiary(@RequestParam HashMap<String, String> params, ModelAndView mav) {
		int diaryNo = 86;
		if(!"".equals(params.get("diary_no")) && params.get("diary_no")!=null) {
			diaryNo = Integer.parseInt(params.get("diary_no"));
		}
		mav.addObject("diaryNo", diaryNo);
		
		mav.setViewName("jangboco/diary/updateDiary");
		
		return mav;
	}
	
	@RequestMapping(value = "/updateDiaryAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	@SuppressWarnings("unchecked")
	public String updateDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String msg = "SUCCESS";
		
		int diaryNo = Integer.parseInt(params.get("diaryNo"));
		int memberNo = Integer.parseInt(params.get("memberNo"));
		String con = params.get("con");
		
		Map<String, Object> diaryParams = new HashMap<String, Object>();
		diaryParams.put("diaryNo", diaryNo);
		diaryParams.put("memberNo", memberNo);
		diaryParams.put("con", con);
		
		String diaryImgJSONStr = params.get("diaryImgList");
		String itemTagJSONStr = params.get("itemTagList");
		String hastgListJSONStr = params.get("hastgList");
		JSONParser parser = new JSONParser();
		JSONArray diaryImgListJSONArr = (JSONArray) parser.parse(diaryImgJSONStr);
		JSONArray itemTagListsJSONArr = (JSONArray) parser.parse(itemTagJSONStr);
		JSONArray hastgListJSONArr = (JSONArray) parser.parse(hastgListJSONStr);
		
		List<String> hastgNameList = new ArrayList<String>();
		for(int i=0; i<hastgListJSONArr.size(); i++) {
			hastgNameList.add((String) hastgListJSONArr.get(i));
		}
		
		List<Integer> hastgNoList = new ArrayList<Integer>();
		for(int i=0; i<hastgNameList.size(); i++) {
			String hastgName = hastgNameList.get(i);
			
			int hastgDuplctCheck = diaryService.hastgDuplctCheck(hastgName);
			if(hastgDuplctCheck==0) {
				diaryParams.put("hastgName", hastgName);
				try {
					int cnt = diaryService.addHastgData(diaryParams);
					
					if(cnt==0) {
						msg = "FAILED";
					}
					
				} catch (Exception e) {
					e.printStackTrace();
					
					msg = "ERROR";
				}
			}
			
			int hastgNo = diaryService.getHastgNo(hastgName);
			hastgNoList.add(hastgNo);
		}
		diaryParams.put("hastgNoList", hastgNoList);
		
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
		
		try {
			// 일기 수정
			int cnt = diaryService.deleteDiaryHastg(diaryNo);
			cnt = diaryService.deleteItemTag(diaryNo);
			cnt = diaryService.deleteDiaryImg(diaryNo);
			cnt = diaryService.updateDiaryData(diaryParams);
			cnt = diaryService.updateDiaryCon(diaryParams);
			
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
	
	@RequestMapping(value = "/deleteDiaryAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String deleteDiaryAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int diaryNo = Integer.parseInt(params.get("diaryNo"));
		
		String msg = "SUCCESS";
		try {
			int cnt = diaryService.deleteDiary(diaryNo);
			
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
