package com.gdj37.jangboco.web.itemsinfo.service;

import java.util.HashMap;
import java.util.List;

public interface IItemsInfoService {

	public HashMap<String, String> getItemsInfo(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getItemsChoiceList(HashMap<String, String> params) throws Throwable;

}
