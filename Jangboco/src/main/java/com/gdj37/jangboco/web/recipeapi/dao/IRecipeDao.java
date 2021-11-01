package com.gdj37.jangboco.web.recipeapi.dao;

import java.util.HashMap;

public interface IRecipeDao {

	public int addRecipeData(HashMap<String, Object> params) throws Throwable;

	public int getChkValue(HashMap<String, Object> params) throws Throwable;

	public HashMap<String, String> getRecipeDtl(HashMap<String, String> params) throws Throwable;

}
