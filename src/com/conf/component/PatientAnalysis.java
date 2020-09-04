package com.conf.component;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Component;

@Entity
@Table(name="patient_analysis")
@Component
public class PatientAnalysis {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="analysis_id")
	private int id;
	
	@Column(name="covid_result")
	private String covidResult;
	
	@DateTimeFormat(iso=ISO.DATE)
	@Column(name="covid_testdate")
	private LocalDate covidTestDate;
	
	@Column(name="test_site")
	private String testSite;
	
	@Column(name="patient_condition")
	private String patientCondition;
	
	@Column(name="patient_category")
	private String patientCategory;
	
	@Column(name="clinical_status")
	private String clinicalStatus;
	
	@Column(name="symptoms")
	@ElementCollection
	@CollectionTable(name="patient_symptoms",joinColumns= {@JoinColumn(name="analysis_id")})
	private List<String> symptoms = new ArrayList<>();
	
	@Column(name="treatment_given")
	@ElementCollection
	@CollectionTable(name="treatment_given",joinColumns= {@JoinColumn(name="analysis_id")})
	private Set<String> treatmentGiven = new HashSet<>();
	
	@ManyToOne
	@JoinColumn(name="patient_id")
	private PatientMaster patientMaster;
	
	@Column(name="creation_date", insertable=false, updatable=false)
	@Generated(GenerationTime.INSERT)
	private LocalDate creationDate;

	public String getCovidResult() {
		return covidResult;
	}

	public void setCovidResult(String covidResult) {
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

	public List<String> getSymptoms() {
		return symptoms;
	}

	public void setSymptoms(List<String> symptoms) {
		this.symptoms = symptoms;
	}

	public Set<String> getTreatmentGiven() {
		return treatmentGiven;
	}

	public void setTreatmentGiven(Set<String> treatmentGiven) {
		this.treatmentGiven = treatmentGiven;
	}

	public PatientMaster getPatientMaster() {
		return patientMaster;
	}

	public void setPatientMaster(PatientMaster patient) {
		this.patientMaster = patient;
	}

	public int getId() {
		return id;
	}
	
	public LocalDate getCreationDate() {
		return creationDate;
	}
}
