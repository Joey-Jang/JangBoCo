package com.gdj37.jangboco.web.dbapi.controller;

import com.gdj37.jangboco.web.dbapi.service.DBApiServiceCls;
import com.gdj37.jangboco.web.dbapi.service.DBApiServiceIF;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class DBApiController {
	
	@Autowired
	public DBApiServiceIF DBApiService;
	
	// Presetting API data complete 21.10.14
//	@RequestMapping(value = "/presetApiData")
//	public ModelAndView presetApiData(ModelAndView mav) throws Throwable {
//		URL req = new URL("http://openapi.seoul.go.kr:8088/74715463716a6a6f3436415553696d/json/ListNecessariesPricesService/1/1");
//		HttpURLConnection con = (HttpURLConnection)req.openConnection();
//		Object obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
//		
//		JSONObject jObj = (JSONObject) obj;
//		JSONObject jsonData = (JSONObject) jObj.get("ListNecessariesPricesService");
//		int maxCount = ((Long) jsonData.get("list_total_count")).intValue();
//		
//		HashMap<String, Object> params = new HashMap<String, Object>();
//		
//		int start = 1;
//		int end = 1000;
//		while(true) {
//			try {
//				req = new URL("http://openapi.seoul.go.kr:8088/74715463716a6a6f3436415553696d/json/ListNecessariesPricesService/"
//						+ start + "/" + end + "/");
//				con = (HttpURLConnection)req.openConnection();
//				obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
//				
//				jObj = (JSONObject) obj;
//				jsonData = (JSONObject) jObj.get("ListNecessariesPricesService");
//				JSONArray list = (JSONArray) jsonData.get("row");
//				
//				for(int i=0; i<list.size(); i++) {
//					JSONObject data = (JSONObject) list.get(i);
//					
//					params.put("disctNo", data.get("M_GU_CODE"));
//					params.put("disctName", data.get("M_GU_NAME"));
//					int disctDuplctCheck = DBApiService.disctDuplctCheck(params);
//					if(disctDuplctCheck==0) {
//						try {
//							int cnt = DBApiService.addDisctData(params);
//						} catch (Exception e2) {
//							e2.printStackTrace();
//							continue;
//						}
//					}
//					
//					params.put("marketNo", data.get("M_SEQ"));
//					params.put("typeNo", data.get("M_TYPE_CODE"));
//					params.put("marketName", data.get("M_NAME"));
//					int marketDuplctCheck = DBApiService.marketDuplctCheck(params);
//					if(marketDuplctCheck==0) {
//						try {
//							int cnt = DBApiService.addMarketData(params);
//						} catch (Exception e2) {
//							e2.printStackTrace();
//							continue;
//						}
//					}
//					
//					params.put("itemsNo", data.get("A_SEQ"));
//					params.put("itemsName", data.get("A_NAME"));
//					int itemsDuplctCheck = DBApiService.itemsDuplctCheck(params);
//					if(itemsDuplctCheck==0) {
//						try {
//							int cnt = DBApiService.addItemsData(params);
//						} catch (Exception e2) {
//							e2.printStackTrace();
//							continue;
//						}
//					}
//					
//					params.put("pricesNo", data.get("P_SEQ"));
//					params.put("updateDate", data.get("P_DATE"));
//					params.put("marketNo", data.get("M_SEQ"));
//					params.put("itemsNo", data.get("A_SEQ"));
//					params.put("sellStd", data.get("A_UNIT"));
//					params.put("price", data.get("A_PRICE"));
//					params.put("note", data.get("ADD_COL"));
//					try {
//						int cnt = DBApiService.addPricesData(params);
//					} catch (Exception e2) {
//						e2.printStackTrace();
//						continue;
//					}
//				}
//				
//				if(end==maxCount) {
//					break;
//				}
//				start += 1000;
//				end += 1000;
//				if(end > maxCount) {
//					end = maxCount;
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		mav.setViewName("DBApi/presetApiData");
//		
//		return mav;
//	}
	
	// Updating API data everyday midnight => add to batch program 21.10.14
//	@RequestMapping(value = "/updateApiData")
//	public ModelAndView updateApiData(ModelAndView mav) throws Throwable {
//		int oldMaxPricesNo = DBApiService.getMaxPricesNo();
//	
//		HashMap<String, Object> params = new HashMap<String, Object>();
//		
//		boolean flag = false;
//		int start = 1;
//		int end = 1000;
//		while(true) {
//			try {
//				URL req = new URL("http://openapi.seoul.go.kr:8088/74715463716a6a6f3436415553696d/json/ListNecessariesPricesService/"
//						+ start + "/" + end + "/");
//				HttpURLConnection con = (HttpURLConnection)req.openConnection();
//				Object obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
//				
//				JSONObject jObj = (JSONObject) obj;
//				JSONObject jsonData = (JSONObject) jObj.get("ListNecessariesPricesService");
//				JSONArray list = (JSONArray) jsonData.get("row");
//				
//				for(int i=0; i<list.size(); i++) {
//					JSONObject data = (JSONObject) list.get(i);
//					params.put("pricesNo", data.get("P_SEQ"));
//					if(((Double) data.get("P_SEQ")).intValue()==oldMaxPricesNo) {
//						flag = true;
//						break;
//					}
//					params.put("updateDate", data.get("P_DATE"));
//					params.put("marketNo", data.get("M_SEQ"));
//					params.put("itemsNo", data.get("A_SEQ"));
//					params.put("sellStd", data.get("A_UNIT"));
//					params.put("price", data.get("A_PRICE"));
//					params.put("note", data.get("ADD_COL"));
//					try {
//						int cnt = DBApiService.addPricesData(params);
//					} catch (Exception e2) {
//						e2.printStackTrace();
//						continue;
//					}
//				}
//				if(flag) {
//					break;
//				}
//				start += 1000;
//				end += 1000;
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		mav.setViewName("DBApi/updateApiData");
//		
//		return mav;
//	}
	
}
