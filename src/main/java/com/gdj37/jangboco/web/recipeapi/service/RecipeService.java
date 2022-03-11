package com.gdj37.jangboco.web.recipeapi.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj37.jangboco.web.recipeapi.dao.IRecipeDao;

@Service
public class RecipeService implements IRecipeService {
	@Autowired
	public IRecipeDao iRecipeDao;

	@Override
	public int addRecipeData(HashMap<String, Object> params) throws Throwable {
		
		return iRecipeDao.addRecipeData(params);
	}

	@Override
	public int getChkValue(HashMap<String, Object> params) throws Throwable {
		
		return iRecipeDao.getChkValue(params);
	}

	@Override
	public HashMap<String, String> getRecipeDtl(HashMap<String, String> params) throws Throwable {
		
		return iRecipeDao.getRecipeDtl(params);
	}
	
}
