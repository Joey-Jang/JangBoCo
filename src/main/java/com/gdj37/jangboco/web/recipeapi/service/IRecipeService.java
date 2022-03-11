package com.gdj37.jangboco.web.recipeapi.service;

import java.util.HashMap;

public interface IRecipeService {

	public int addRecipeData(HashMap<String, Object> params) throws Throwable;

	public int getChkValue(HashMap<String, Object> params) throws Throwable;

	public HashMap<String, String> getRecipeDtl(HashMap<String, String> params) throws Throwable;

	

}
