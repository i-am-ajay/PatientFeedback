package com.conf.component;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;
import org.hibernate.annotations.ParamDef;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Entity
@FilterDef(name="date_filter",parameters= {
		@ParamDef(name="sDate",type="java.time.LocalDateTime"),
		@ParamDef(name="eDate",type="java.time.LocalDateTime")
})
public class PatientMaster {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Column(name="reg_no", unique=true)
	private String registrationNumber;
	
	@Column
	private String name;
	
	@Column
	private String mobileNo;
	
	@Column
	private String gender;
	
	
	@OneToMany(mappedBy="patientMaster",fetch=FetchType.EAGER, cascade= {CascadeType.ALL})
	@Filter(name="date_filter", condition="creation_time BETWEEN :sDate and :eDate")
	private List<PatientInfo> patientInfoList =  new ArrayList<>();

	public String getRegistrationNumber() {
		return registrationNumber;
	}

	public void setRegistrationNumber(String registrationNumber) {
		this.registrationNumber = registrationNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public int getId() {
		return id;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public List<PatientInfo> getPatientInfoList() {
		return patientInfoList;
	}

	public void setPatientInfoList(List<PatientInfo> patientInfoList) {
		this.patientInfoList = patientInfoList;
	}
}
