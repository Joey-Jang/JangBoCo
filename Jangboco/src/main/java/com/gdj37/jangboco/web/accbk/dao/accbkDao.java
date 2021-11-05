package com.gdj37.jangboco.web.accbk.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class accbkDao implements accbkIDao{
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<HashMap<String, String>> getMarketList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getMarketList", params);
	}

	@Override
	public List<HashMap<String, String>> getItemsList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getItemsList", params);
	}

	@Override
	public int writeAccbk(HashMap<String, String> params) throws Throwable {
		return sqlsession.insert("accbk.writeAccbk", params);
	}

	@Override
	public List<HashMap<String, String>> getAccbkList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getAccbkList", params);
	}

	@Override
	public int getAccbkCnt(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getAccbkCnt", params);
	}

	@Override
	public int delAccbk(List<Integer> params) throws Throwable {
		return sqlsession.update("accbk.delAccbk", params);
	}

	@Override
	public HashMap<String, String> getAccbk(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getAccbk", params);
	}

	@Override
	public int updateAccbk(HashMap<String, String> params) throws Throwable {
		return sqlsession.update("accbk.updateAccbk", params);
	}

	@Override
	public HashMap<String, String> getMostSpendDay(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getMostSpendDay", params);
	}

	@Override
	public HashMap<String, String> getLeastSpendDay(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getLeastSpendDay", params);
	}

	@Override
	public HashMap<String, String> getMostSpendItems(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getMostSpendItems", params);
	}

	@Override
	public HashMap<String, String> getMostVisitMarket(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getMostVisitMarket", params);
	}

	@Override
	public HashMap<String, String> getThisMonthSpend(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getThisMonthSpend", params);
	}

	@Override
	public HashMap<String, String> getMostSpendWeek(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getMostSpendWeek", params);
	}
	
	@Override
	public HashMap<String, String> getLeastSpendWeek(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectOne("accbk.getLeastSpendWeek", params);
	}
	
	@Override
	public List<HashMap<String, Object>> getDisctList() throws Throwable {
		return sqlsession.selectList("accbk.getDisctList");
	}

	@Override
	public List<HashMap<String, String>> getBranchList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getBranchList", params);
	}

	@Override
	public List<HashMap<String, String>> searchMarket(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.searchMarket", params);
	}

	@Override
	public List<HashMap<String, String>> getAccbkPeriodChart(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getAccbkPeriodChart", params);
	}

	@Override
	public List<HashMap<String, String>> getFiveItems(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getFiveItems", params);
	}

	@Override
	public List<HashMap<String, String>> getSpendSummr(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlsession.selectList("accbk.getSpendSummr", params);
	}

	@Override
	public List<HashMap<String, String>> getMinMax(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getMinMax", params);
	}

	@Override
	public List<HashMap<String, String>> getRichDayList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getRichDayList", params);
	}

	@Override
	public List<HashMap<String, Object>> getCalendarList(HashMap<String, String> params) throws Throwable {
		return sqlsession.selectList("accbk.getCalendarList", params);
	}


	

	

}
