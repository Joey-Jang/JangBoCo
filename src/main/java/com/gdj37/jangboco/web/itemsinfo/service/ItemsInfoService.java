package com.gdj37.jangboco.web.itemsinfo.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.itemsinfo.dao.IItemsInfoDao;

@Service
public class ItemsInfoService implements IItemsInfoService {
	@Autowired
	public IItemsInfoDao iItemsInfoDao;

	@Override
	public HashMap<String, String> getItemsInfo(HashMap<String, String> params) throws Throwable {
		
		return iItemsInfoDao.getItemsInfo(params);
	}

	@Override
	public List<HashMap<String, String>> getItemsChoiceList(HashMap<String, String> params) throws Throwable {
		
		return iItemsInfoDao.getItemsChoiceList(params);
	}
}
