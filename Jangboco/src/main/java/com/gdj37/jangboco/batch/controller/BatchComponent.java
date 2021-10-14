package com.gdj37.jangboco.batch.controller;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdj37.jangboco.web.dbapi.service.DBApiServiceIF;

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
	DBApiServiceIF DBApiService;
	
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
					params.put("pricesNo", data.get("P_SEQ"));
					if(((Double) data.get("P_SEQ")).intValue()==oldMaxPricesNo) {
						flag = true;
						break;
					}
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

}
