package com.gdj37.jangboco.web.accbk.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.accbk.dao.accbkIDao;

@Service
public class accbkService implements accbkIService {

	 @Autowired
	 public accbkIDao accbkiDao;

	@Override
	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMarketList(params);
	}

	@Override
	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getItemsList(params);
	}

	@Override
	public int writeAccbk(HashMap<String, String> params) throws Throwable {
		return accbkiDao.writeAccbk(params);
	}

	@Override
	public List<HashMap<String, String>> getAccbkList(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getAccbkList(params);
	}

	@Override
	public int getAccbkCnt(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getAccbkCnt(params);
	}

	@Override
	public int delAccbk(List<Integer> params) throws Throwable {
		return accbkiDao.delAccbk(params);
	}

	@Override
	public HashMap<String, String> getAccbk(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getAccbk(params);
	}

	@Override
	public int updateAccbk(HashMap<String, String> params) throws Throwable {
		return accbkiDao.updateAccbk(params);
	}

	@Override
	public HashMap<String, String> getMostSpendDay(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMostSpendDay(params);
	}

	@Override
	public HashMap<String, String> getLeastSpendDay(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getLeastSpendDay(params);
	}

	@Override
	public HashMap<String, String> getMostSpendItems(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMostSpendItems(params);
	}

	@Override
	public HashMap<String, String> getMostVisitMarket(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMostVisitMarket(params);
	}

	@Override
	public HashMap<String, String> getThisMonthSpend(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getThisMonthSpend(params);
	}
	
	@Override
	public HashMap<String, String> getMostSpendWeek(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMostSpendWeek(params);
	}
	
	@Override
	public HashMap<String, String> getLeastSpendWeek(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getLeastSpendWeek(params);
	}

	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return accbkiDao.getDisctList();
	}

	@Override
	public List<HashMap<String, String>> getBranchList(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getBranchList(params);
	}

	@Override
	public List<HashMap<String, String>> searchMarket(HashMap<String, String> params) throws Throwable {
		return accbkiDao.searchMarket(params);
	}

	@Override
	public List<HashMap<String, String>> getAccbkPeriodChart(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getAccbkPeriodChart(params);
	}

	@Override
	public List<HashMap<String, String>> getFiveItems(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getFiveItems(params);
	}

	@Override
	public List<HashMap<String, String>> getSpendSummr(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getSpendSummr(params);
	}

	@Override
	public List<HashMap<String, String>> getMinMax(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getMinMax(params);
	}

	@Override
	public List<HashMap<String, String>> getRichDayList(HashMap<String, String> params) throws Throwable {
		return accbkiDao.getRichDayList(params);
	}


}
