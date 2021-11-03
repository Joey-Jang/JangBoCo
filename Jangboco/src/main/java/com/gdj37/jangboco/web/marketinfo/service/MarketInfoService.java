package com.gdj37.jangboco.web.marketinfo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.marketinfo.dao.IMarketInfoDao;

@Service
public class MarketInfoService implements IMarketInfoService {
	@Autowired
	public IMarketInfoDao iMarketInfoDao;

	@Override
	public int getMarketEventCnt(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getMarketEventCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getEventList(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getEventList(params);
	}

	@Override
	public HashMap<String, String> getMarketInfoU(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getMarketInfoU(params);
	}

	@Override
	public HashMap<String, String> getMarketInfoBU(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getMarketInfoBU(params);
	}

	@Override
	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getItemsList(params);
	}

	@Override
	public List<HashMap<String, String>> getItemsListNoChoice(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getItemsListNoChoice(params);
	}

	@Override
	public HashMap<String, String> getItemsListChoice(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getItemsListChoice(params);
	}

	@Override
	public HashMap<String, String> getEventData(HashMap<String, String> params) throws Throwable {
		
		return iMarketInfoDao.getEventData(params);
	}

	
}
