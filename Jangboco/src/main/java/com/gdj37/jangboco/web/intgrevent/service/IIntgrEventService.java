package com.gdj37.jangboco.web.intgrevent.service;

import java.util.HashMap;
import java.util.List;

public interface IIntgrEventService {

	public List<HashMap<String, String>> getEventNormalList(HashMap<String, String> params) throws Throwable;

	public int getEventCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEventBestList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable;

	public int updateEventHit(HashMap<String, String> params) throws Throwable;

	public String getDisctNo(HashMap<String, String> params) throws Throwable;

	public String getDisctName(HashMap<String, String> params) throws Throwable;
	

}
