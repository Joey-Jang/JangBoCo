package com.gdj37.jangboco.web.intgrevent.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.intgrevent.dao.IIntgrEventDao;

@Primary
@Service
public class IntgrEventService implements IIntgrEventService {
	@Autowired
	public IIntgrEventDao iIntgrEventDao;

	@Override
	public List<HashMap<String, String>> getEventNormalList(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getEventNormalList(params);
	}

	@Override
	public int getEventCnt(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getEventCnt(params);
	}
	
	@Override
	public List<HashMap<String, String>> getEventBestList(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getEventBestList(params);
	}

	@Override
	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getEventDtl(params);
	}

	@Override
	public int updateEventHit(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.updateEventHit(params);
	}

	@Override
	public String getDisctNo(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getDisctNo(params);
	}

	@Override
	public String getDisctName(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getDisctName(params);
	}

	@Override
	public int checkEventLike(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.checkEventLike(params);
	}

	@Override
	public int cntEventLike(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.cntEventLike(params);
	}

	@Override
	public int addEventLike(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.addEventLike(params);
	}

	@Override
	public int deleteEventLike(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.deleteEventLike(params);
	}
}
