package com.gdj37.jangboco.web.priceschart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.priceschart.dao.IPricesChartDao;

@Primary
@Service
public class PricesChartService implements IPricesChartService {
	@Autowired
	public IPricesChartDao iPricesChartDao;

	@Override
	public List<HashMap<String, String>> getLineDataList(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getLineDataList(params);
	}

	@Override
	public List<String> getDateList(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getDateList(params);
	}

	@Override
	public List<HashMap<String, String>> getItemNameList(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getItemNameList(params);
	}

	@Override
	public List<HashMap<String, String>> getDisctDataList(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getDisctDataList(params);
	}

	@Override
	public List<HashMap<String, String>> getDisctItemsList(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getDisctItemsList(params);
	}

	@Override
	public List<HashMap<String, String>> getCategoryChartData(HashMap<String, String> params) throws Throwable {
		
		return iPricesChartDao.getCategoryChartData(params);
	}

}
