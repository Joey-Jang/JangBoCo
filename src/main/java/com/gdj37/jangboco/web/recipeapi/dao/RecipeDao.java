package com.gdj37.jangboco.web.recipeapi.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gdj37.jangboco.web.recipeapi.service.IRecipeService;

@Repository
public class RecipeDao implements IRecipeDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int addRecipeData(HashMap<String, Object> params) throws Throwable {
		
		return sqlSession.update("RecipeApi.addRecipeData", params);
	}

	@Override
	public int getChkValue(HashMap<String, Object> params) throws Throwable {
		
		return sqlSession.selectOne("RecipeApi.getChkValue", params);
	}

	@Override
	public HashMap<String, String> getRecipeDtl(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("RecipeApi.getRecipeDtl", params);
	}
}
