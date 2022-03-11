package com.gdj37.jangboco.web.itemsinfo.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ItemsInfoDao implements IItemsInfoDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public HashMap<String, String> getItemsInfo(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("itemsInfo.getItemsInfo", params);
	}

	@Override
	public List<HashMap<String, String>> getItemsChoiceList(HashMap<String, String> params) {
		
		return sqlSession.selectList("itemsInfo.getItemsChoiceList", params);
	}
}
