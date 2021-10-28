package com.gdj37.jangboco.web.intgrevent.dao;

import java.util.HashMap;
import java.util.List;

public interface IIntgrEventDao {

	public List<HashMap<String, String>> getEventNormalList(HashMap<String, String> params) throws Throwable;

	public int getEventCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEventBestList() throws Throwable;

	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable;

	public int updateEventHit(HashMap<String, String> params) throws Throwable;


}
