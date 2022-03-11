package com.gdj37.jangboco.web.intgrevent.dao;

import java.util.HashMap;
import java.util.List;

public interface IIntgrEventDao {

	public List<HashMap<String, String>> getEventNormalList(HashMap<String, String> params) throws Throwable;

	public int getEventCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getEventBestList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable;

	public int updateEventHit(HashMap<String, String> params) throws Throwable;

	public String getDisctNo(HashMap<String, String> params) throws Throwable;

	public String getDisctName(HashMap<String, String> params) throws Throwable;

	public int checkEventLike(HashMap<String, String> params) throws Throwable;

	public int cntEventLike(HashMap<String, String> params) throws Throwable;

	public int addEventLike(HashMap<String, String> params) throws Throwable;

	public int deleteEventLike(HashMap<String, String> params) throws Throwable;


}
