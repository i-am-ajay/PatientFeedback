package com.conf.component;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;

@Entity
public class PatientAnalysis {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="analysis_id")
	private int id;
	
	@Column(name="covid_result")
	private boolean covidResult;
	
	@Column(name="covid_testdate")
	private LocalDate covidTestDate;
	
	@Column(name="test_site")
	private String testSite;
	
	@Column(name="patient_condition")
	private String patientCondition;
	
	@Column(name="patient_category")
	private String patientCategory;
	
	@Column(name="patient_category")
	private String clinicalStatus;
	
	@Column(name="symptoms")
	private String symptoms;
	
	@Column(name="treatmetn_given")
	private String treatmentGiven;
	
	@OneToMany
	@JoinColumn(name="patient_id")
	private PatientMaster patientMaster;
	
	@Column(name="creation_date", insertable=false, updatable=false)
	@Generated(GenerationTime.INSERT)
	private LocalDate creationDate;

	public boolean isCovidResult() {
		return covidResult;
	}

	public void setCovidResult(boolean covidResult) {
		this.covidResult = covidResult;
	}

	public LocalDate getCovidTestDate() {
		return covidTestDate;
	}

	public void setCovidTestDate(LocalDate covidTestDate) {
		this.covidTestDate = covidTestDate;
	}

	public String getTestSite() {
		return testSite;
	}

	public void setTestSite(String testSite) {
		this.testSite = testSite;
	}

	public String getPatientCondition() {
		return patientCondition;
	}

	public void setPatientCondition(String patientCondition) {
		this.patientCondition = patientCondition;
	}

	public String getPatientCategory() {
		return patientCategory;
	}

	public void setPatientCategory(String patientCategory) {
		this.patientCategory = patientCategory;
	}

	public String getClinicalStatus() {
		return clinicalStatus;
	}

	public void setClinicalStatus(String clinicalStatus) {
		this.clinicalStatus = clinicalStatus;
	}

	public String getSymptoms() {
		return symptoms;
	}

	public void setSymptoms(String symptoms) {
		this.symptoms = symptoms;
	}

	public String getTreatmentGiven() {
		return treatmentGiven;
	}

	public void setTreatmentGiven(String treatmentGiven) {
		this.treatmentGiven = treatmentGiven;
	}

	public PatientMaster getPatientMaster() {
		return patientMaster;
	}

	public void setPatient(PatientMaster patient) {
		this.patientMaster = patient;
	}

	public int getId() {
		return id;
	}

	public LocalDate getCreationDate() {
		return creationDate;
	}
}
