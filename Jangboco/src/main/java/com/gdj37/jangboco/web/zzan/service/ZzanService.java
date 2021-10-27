package com.gdj37.jangboco.web.zzan.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.zzan.dao.IZzanDao;

@Service
public class ZzanService implements IZzanService {
	@Autowired
	public IZzanDao iZzanDao;

	@Override
	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iZzanDao.getMarketList(params);
	}

}
