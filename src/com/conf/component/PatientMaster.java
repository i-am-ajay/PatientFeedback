package com.conf.component;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;
import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.ParamDef;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Entity
@FilterDef(name="date_filter",parameters= {
		@ParamDef(name="sDate",type="java.time.LocalDateTime"),
		@ParamDef(name="eDate",type="java.time.LocalDateTime")
})
@Inheritance(strategy = InheritanceType.JOINED)
public class PatientMaster {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Column(name="reg_no", unique=true)
	protected String registrationNumber;
	
	@Column
	protected String name;
	
	@Column
	protected String mobileNo;
	
	@Column
	protected String gender;
	
	
	@OneToMany(mappedBy="patientMaster",fetch=FetchType.EAGER, cascade= {CascadeType.ALL})
	@Filter(name="date_filter", condition="creation_time BETWEEN :sDate and :eDate")
	@OrderBy(clause = "creation_time DESC")
	private List<PatientInfo> patientInfoList =  new ArrayList<>();
	
	@OneToMany(mappedBy="patientMaster",fetch=FetchType.EAGER, cascade= {CascadeType.ALL})
	private Set<PatientAnalysis> patientAnalysisList = new HashSet();

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

	public Set<PatientAnalysis> getPatientAnalysisList() {
		return patientAnalysisList;
	}

	public void setPatientAnalysisList(Set<PatientAnalysis> patientAnalysisList) {
		this.patientAnalysisList = patientAnalysisList;
	}
}
