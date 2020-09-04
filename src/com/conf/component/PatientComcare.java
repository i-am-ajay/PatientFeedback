package com.conf.component;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

public class PatientComcare {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String srfId;
	
	private String testResult;
	
	private LocalDate testSampleCollectionDate;
	
	private LocalDate testResultDate;
	
	private String testSite;
	
	private String labName;
	
	private String labCode;
	
	private String patientCondition;
	
	private String addmissionStatus;
	
	private LocalDate admissionDate;
	
	private String transferedFrom;
	
	@ElementCollection
	@CollectionTable(name="comorbidities_table")
	@JoinColumn(name="patient_id")
	@Column(name="comorbidities")
	private List<String> patientComorbidities;
	
	@ManyToOne
	private PatientMasterDetailed patientDetails;

	public String getSrfId() {
		return srfId;
	}

	public void setSrfId(String srfId) {
		this.srfId = srfId;
	}

	public String getTestResult() {
		return testResult;
	}

	public void setTestResult(String testResult) {
		this.testResult = testResult;
	}

	public LocalDate getTestSampleCollectionDate() {
		return testSampleCollectionDate;
	}

	public void setTestSampleCollectionDate(LocalDate testSampleCollectionDate) {
		this.testSampleCollectionDate = testSampleCollectionDate;
	}

	public LocalDate getTestResultDate() {
		return testResultDate;
	}

	public void setTestResultDate(LocalDate testResultDate) {
		this.testResultDate = testResultDate;
	}

	public String getTestSite() {
		return testSite;
	}

	public void setTestSite(String testSite) {
		this.testSite = testSite;
	}

	public String getLabName() {
		return labName;
	}

	public void setLabName(String labName) {
		this.labName = labName;
	}

	public String getLabCode() {
		return labCode;
	}

	public void setLabCode(String labCode) {
		this.labCode = labCode;
	}

	public String getPatientCondition() {
		return patientCondition;
	}

	public void setPatientCondition(String patientCondition) {
		this.patientCondition = patientCondition;
	}

	public String getAddmissionStatus() {
		return addmissionStatus;
	}

	public void setAddmissionStatus(String addmissionStatus) {
		this.addmissionStatus = addmissionStatus;
	}

	public LocalDate getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(LocalDate admissionDate) {
		this.admissionDate = admissionDate;
	}

	public String getTransferedFrom() {
		return transferedFrom;
	}

	public void setTransferedFrom(String transferedFrom) {
		this.transferedFrom = transferedFrom;
	}

	public List<String> getPatientComorbidities() {
		return patientComorbidities;
	}

	public void setPatientComorbidities(List<String> patientComorbidities) {
		this.patientComorbidities = patientComorbidities;
	}

	public PatientMasterDetailed getPatientDetails() {
		return patientDetails;
	}

	public void setPatientDetails(PatientMasterDetailed patientDetails) {
		this.patientDetails = patientDetails;
	}

	public int getId() {
		return id;
	}
}
