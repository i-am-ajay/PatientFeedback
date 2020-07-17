package com.conf.component;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class PatientMaster {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Column(name="reg_no", unique=true, columnDefinition="")
	private String registrationNumber;
	
	@Column
	private String name;
	
	@Column
	private String mobileNo;
}
