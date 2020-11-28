package com.sgrh.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.RowMapper;

@Repository
public class TrakDAO {
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	@Qualifier("trackDataSource")
	public void setDataSource(DataSource source) {
		jdbcTemplate = new JdbcTemplate(source);
	}
	
	public JdbcTemplate getDataSource() {
		return this.jdbcTemplate;
	}
	
	public	Object[] getDemographic(String regNo) {
		
		String query = "SELECT PAPMI_No RegNo, "
				+ "PAPMI_PAPER_DR->PAPER_NAME2  || ' ' || PAPMI_PAPER_DR->PAPER_NAME as PatientName,"
				+ "PAPMI_DOB DOB, "
				+ "PAPMI_PAPER_DR->PAPER_TelH Telephone, "
				+ "PAPMI_PAPER_DR->PAPER_MOBPHONE as Mobile,"
				+ "PAPMI_PAPER_DR->PAPER_AGEYR Age, "
				+ "PAPMI_Sex_DR->CTSEX_Desc Gender, "
				+ "PAPMI_PAPER_DR->PAPER_StName Address,"
				+ "PAPMI_PAPER_DR->PAPER_CityArea_DR->CITAREA_Desc Area,"
				+ "PAPMI_PAPER_DR->PAPER_CityCode_DR->CTCIT_Desc City,"
				+ "PAPMI_PAPER_DR->PAPER_CT_Province_DR->PROV_Desc State,"
				+ "PAPMI_PAPER_DR->PAPER_Country_Birth_DR->CTCOU_Desc Country,"
				+ "PAPMI_PAPER_DR->PAPER_Zip_DR->CTZIP_Code Zip "
				+ "FROM pa_patmas where PAPMI_No  = '" + regNo + "'";
		return jdbcTemplate.queryForObject(query, new RowMapper<Object[]>() {

			@Override
			public Object[] mapRow(ResultSet resultSet, int rownumber) throws SQLException {
				Object [] obj = new Object[13];
				System.out.println(resultSet.getObject(1));
				obj[0] = resultSet.getObject(1);
				obj[1] = resultSet.getObject(2);
				obj[2] = resultSet.getObject(3);
				obj[3] = resultSet.getObject(4);
				obj[4] = resultSet.getObject(5);
				obj[5] = resultSet.getObject(6);
				obj[6] = resultSet.getObject(7);
				obj[7] = resultSet.getObject(8);
				obj[8] = resultSet.getObject(9);
				obj[9] = resultSet.getObject(10);
				obj[10] = resultSet.getObject(11);
				obj[11] = resultSet.getObject(12);
				obj[12] = resultSet.getObject(13);
				return obj;
			}
			
		});
	}
}
