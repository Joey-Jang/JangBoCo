package com.gdj37.jangboco.web.intgrevent.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.intgrevent.dao.IIntgrEventDao;

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
	public List<HashMap<String, String>> getEventBestList() throws Throwable {
		
		return iIntgrEventDao.getEventBestList();
	}

	@Override
	public HashMap<String, String> getEventDtl(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.getEventDtl(params);
	}

	@Override
	public int updateEventHit(HashMap<String, String> params) throws Throwable {
		
		return iIntgrEventDao.updateEventHit(params);
	}
}
