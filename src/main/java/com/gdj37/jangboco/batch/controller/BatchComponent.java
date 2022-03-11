package com.gdj37.jangboco.batch.controller;

import com.gdj37.jangboco.web.dbapi.service.DBApiServiceCls;
import com.gdj37.jangboco.web.recipeapi.service.IRecipeService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

@Component
public class BatchComponent {

	// 초 분 시 일 월 요일
	// * - 모든
	// ? - 월, 요일에 사용. 신경안씀이라는 의미
	// 월은 1 - 12
	// 요일은 1(일) - 7(토). ,(컴마)로 복수지정가능. 예)월수금 - 2,4,6
	// 숫자1/숫자2의 경우 숫자1에서 시작하여 매 숫자2마다 실행. 예) 분에 0/5이면 0분부터 5분마다 실행
	// 일에서 L은 달의 마지막날. W는 지정일자가 휴일(토, 일)이면 인접한 평일에 수행.
	// 예) 25W인경우 25일이 일요일이면 26일 월요일 실행.
	// LW는 마지막 평일
	// 요일에서 숫자1#숫자2의경우 숫자2번째 주의 숫자1번 요일에 실행.
	// 예) 2#4 - 4번째주 월요일에 실행.
//	@Scheduled(cron = "0 0 0 * * *")
//	public void cronTest1() {
//		System.out.println("blank!!");
//	}
	
	@Autowired
	DBApiServiceCls DBApiService;
	
	@Autowired
	IRecipeService iRecipeService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void updateApiDataEveryday() throws Throwable {
		int oldMaxPricesNo = DBApiService.getMaxPricesNo();
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		boolean flag = false;
		int start = 1;
		int end = 1000;
		while(true) {
			try {
				URL req = new URL("http://openapi.seoul.go.kr:8088/74715463716a6a6f3436415553696d/json/ListNecessariesPricesService/"
						+ start + "/" + end + "/");
				HttpURLConnection con = (HttpURLConnection)req.openConnection();
				Object obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
				
				JSONObject jObj = (JSONObject) obj;
				JSONObject jsonData = (JSONObject) jObj.get("ListNecessariesPricesService");
				JSONArray list = (JSONArray) jsonData.get("row");
				
				for(int i=0; i<list.size(); i++) {
					JSONObject data = (JSONObject) list.get(i);
					
					if(((Double) data.get("P_SEQ")).intValue()==oldMaxPricesNo) {
						flag = true;
						break;
					}
					
					params.put("disctNo", data.get("M_GU_CODE"));
					params.put("disctName", data.get("M_GU_NAME"));
					int disctDuplctCheck = DBApiService.disctDuplctCheck(params);
					if(disctDuplctCheck==0) {
						try {
							int cnt = DBApiService.addDisctData(params);
						} catch (Exception e2) {
							e2.printStackTrace();
							continue;
						}
					}
					
					params.put("marketNo", data.get("M_SEQ"));
					params.put("typeNo", data.get("M_TYPE_CODE"));
					params.put("marketName", data.get("M_NAME"));
					int marketDuplctCheck = DBApiService.marketDuplctCheck(params);
					if(marketDuplctCheck==0) {
						try {
							int cnt = DBApiService.addMarketData(params);
						} catch (Exception e2) {
							e2.printStackTrace();
							continue;
						}
					}
					
					params.put("itemsNo", data.get("A_SEQ"));
					params.put("itemsName", data.get("A_NAME"));
					int itemsDuplctCheck = DBApiService.itemsDuplctCheck(params);
					if(itemsDuplctCheck==0) {
						try {
							int cnt = DBApiService.addItemsData(params);
						} catch (Exception e2) {
							e2.printStackTrace();
							continue;
						}
					}
					
					params.put("pricesNo", data.get("P_SEQ"));
					params.put("updateDate", data.get("P_DATE"));
					params.put("marketNo", data.get("M_SEQ"));
					params.put("itemsNo", data.get("A_SEQ"));
					params.put("sellStd", data.get("A_UNIT"));
					params.put("price", data.get("A_PRICE"));
					params.put("note", data.get("ADD_COL"));
					try {
						int cnt = DBApiService.addPricesData(params);
					} catch (Exception e2) {
						e2.printStackTrace();
						continue;
					}
				}
				if(flag) {
					break;
				}
				start += 1000;
				end += 1000;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@Scheduled(cron = "0 0 0 1 * *")
	public void updateRecipeApiEveryMonth() throws Throwable {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		boolean flag = false;
		int start = 1;
		int end = 1000;
		String key ="121c409444094fdea525";
		String result = "";		
		
		while(true) {
			try {
				URL url = new URL("http://openapi.foodsafetykorea.go.kr/api/"+ key +
						"/COOKRCP01/json/"+ start +"/"+ end +"/");
	
				BufferedReader bf;
				bf = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
				
				result = bf.readLine();				
				
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
				JSONObject cookrcp01 = (JSONObject)jsonObject.get("COOKRCP01");				
			
				int totalCnt = Integer.parseInt((String)cookrcp01.get("total_count"));
				
				JSONArray recipeList = (JSONArray)cookrcp01.get("row");
				
				for(int i = 0; i<recipeList.size(); i++) {			
					JSONObject recipeRow = (JSONObject)recipeList.get(i);
					params.put("chkValue", recipeRow.get("RCP_SEQ"));
					int chkCnt = iRecipeService.getChkValue(params);
					if(chkCnt == 0) {						
						params.put("RCP_SEQ", recipeRow.get("RCP_SEQ"));
						params.put("RCP_NM", recipeRow.get("RCP_NM"));
						params.put("RCP_WAY2", recipeRow.get("RCP_WAY2"));
						params.put("RCP_PAT2", recipeRow.get("RCP_PAT2"));
						params.put("INFO_WGT", recipeRow.get("INFO_WGT"));
						params.put("INFO_ENG", recipeRow.get("INFO_ENG"));
						params.put("INFO_CAR", recipeRow.get("INFO_CAR"));
						params.put("INFO_PRO", recipeRow.get("INFO_PRO"));
						params.put("INFO_FAT", recipeRow.get("INFO_FAT"));
						params.put("INFO_NA", recipeRow.get("INFO_NA"));
						params.put("ATT_FILE_NO_MAIN", recipeRow.get("ATT_FILE_NO_MAIN"));
						params.put("RCP_PARTS_DTLS", recipeRow.get("RCP_PARTS_DTLS"));
						params.put("MANUAL01", recipeRow.get("MANUAL01"));
						params.put("MANUAL_IMG01", recipeRow.get("MANUAL_IMG01"));
						params.put("MANUAL02", recipeRow.get("MANUAL02"));
						params.put("MANUAL_IMG02", recipeRow.get("MANUAL_IMG02"));
						params.put("MANUAL03", recipeRow.get("MANUAL03"));
						params.put("MANUAL_IMG03", recipeRow.get("MANUAL_IMG03"));
						params.put("MANUAL04", recipeRow.get("MANUAL04"));
						params.put("MANUAL_IMG04", recipeRow.get("MANUAL_IMG04"));
						params.put("MANUAL05", recipeRow.get("MANUAL05"));
						params.put("MANUAL_IMG05", recipeRow.get("MANUAL_IMG05"));
						params.put("MANUAL06", recipeRow.get("MANUAL06"));
						params.put("MANUAL_IMG06", recipeRow.get("MANUAL_IMG06"));
						params.put("MANUAL07", recipeRow.get("MANUAL07"));
						params.put("MANUAL_IMG07", recipeRow.get("MANUAL_IMG07"));
						params.put("MANUAL08", recipeRow.get("MANUAL08"));
						params.put("MANUAL_IMG08", recipeRow.get("MANUAL_IMG08"));
						params.put("MANUAL09", recipeRow.get("MANUAL09"));
						params.put("MANUAL_IMG09", recipeRow.get("MANUAL_IMG09"));
						params.put("MANUAL10", recipeRow.get("MANUAL10"));
						params.put("MANUAL_IMG10", recipeRow.get("MANUAL_IMG10"));
						params.put("MANUAL11", recipeRow.get("MANUAL11"));
						params.put("MANUAL_IMG11", recipeRow.get("MANUAL_IMG11"));
						params.put("MANUAL12", recipeRow.get("MANUAL12"));
						params.put("MANUAL_IMG12", recipeRow.get("MANUAL_IMG12"));
						params.put("MANUAL13", recipeRow.get("MANUAL13"));
						params.put("MANUAL_IMG13", recipeRow.get("MANUAL_IMG13"));
						params.put("MANUAL14", recipeRow.get("MANUAL14"));
						params.put("MANUAL_IMG14", recipeRow.get("MANUAL_IMG14"));
						params.put("MANUAL15", recipeRow.get("MANUAL15"));
						params.put("MANUAL_IMG15", recipeRow.get("MANUAL_IMG15"));
						params.put("MANUAL16", recipeRow.get("MANUAL16"));
						params.put("MANUAL_IMG16", recipeRow.get("MANUAL_IMG16"));
						params.put("MANUAL17", recipeRow.get("MANUAL17"));
						params.put("MANUAL_IMG17", recipeRow.get("MANUAL_IMG17"));
						params.put("MANUAL18", recipeRow.get("MANUAL18"));
						params.put("MANUAL_IMG18", recipeRow.get("MANUAL_IMG18"));
						params.put("MANUAL19", recipeRow.get("MANUAL19"));
						params.put("MANUAL_IMG19", recipeRow.get("MANUAL_IMG19"));
						params.put("MANUAL20", recipeRow.get("MANUAL20"));
						params.put("MANUAL_IMG20", recipeRow.get("MANUAL_IMG20"));	
						int cnt = iRecipeService.addRecipeData(params);
					}					
					
				}
			
				if(flag) {
					break;
				}				
				start += 1000;
				end += 1000;
				
				if( end >= totalCnt) {
					end = totalCnt;
					flag = true;					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
}
