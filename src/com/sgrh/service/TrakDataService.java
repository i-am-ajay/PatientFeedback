package com.sgrh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sgrh.dao.TrakDAO;

@Service
public class TrakDataService {
	@Autowired
	TrakDAO trakDao;
	
	
	// -------------------------------- Trak Services -------------------------------------------
	public Object[] demographicDetail(String regNo){
		return trakDao.getDemographic(regNo);
	}
		
		// -------------------------------- End Trak Services ---------------------------------------
}
