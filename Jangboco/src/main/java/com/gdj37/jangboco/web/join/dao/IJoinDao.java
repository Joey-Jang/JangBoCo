package com.gdj37.jangboco.web.join.dao;

import java.util.HashMap;
import java.util.List;

public interface IJoinDao {

	public int addMember(HashMap<String, String> params) throws Exception;

	public int validEmail(String email) throws Exception;

	public List<HashMap<String, String>> getDisct() throws Exception;

	public List<HashMap<String, String>> getMarkets(HashMap<String, String> params) throws Exception;

	public List<HashMap<String, String>> getBranches(HashMap<String, String> params) throws Exception;

	public int checkRegnum(HashMap<String, String> params) throws Exception;

	public HashMap<String, String> checkAddMarket(HashMap<String, String> params) throws Exception;

	public int checkBranchName(HashMap<String, String> params) throws Exception;

	public int addMarketMember(HashMap<String, String> params) throws Exception;

	public int checkSocialEmail(String email)  throws Exception;

}
