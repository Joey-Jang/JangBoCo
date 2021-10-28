package com.gdj37.jangboco.web.priceschart.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PricesChartDao implements IPricesChartDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getLineDataList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getLineDataList",params);
	}

	@Override
	public List<String> getDateList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getDateList",params);
	}

	@Override
	public List<HashMap<String, String>> getItemNameList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getItemNameList",params);
	}

	@Override
	public List<HashMap<String, String>> getDisctDataList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getDisctDataList",params);
	}

	@Override
	public List<HashMap<String, String>> getDisctItemsList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getDisctItemsList",params);
	}

	@Override
	public List<HashMap<String, String>> getCategoryChartData(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("pricesChart.getCategoryChartData",params);
	}

}
