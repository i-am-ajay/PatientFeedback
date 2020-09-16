package com.conf.component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

@Entity
@Table(name="patient_comcare")
public class PatientComcare {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String srfId;
	
	private String testResult;
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate testSampleCollectionDate;
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate testResultDate;
	
	private String testSite;
	
	private String labName;
	
	private String labCode;
	
	private String patientCondition;
	
	private String admissionStatus;
	
	@Column(name="on_site_update")
	private Boolean updatedOnGovtSite;
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate admissionDate;
	
	private String transferedFrom;
	
	@ElementCollection(fetch=FetchType.EAGER)
	@CollectionTable(name="comorbidities_table")
	@JoinColumn(name="patient_id")
	@Column(name="comorbidities")
	@Fetch(FetchMode.SUBSELECT)
	private Set<String> patientComorbidities = new HashSet<String>();
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="patient_reg")
	private PatientMaster patientDetails;
	
	@Column(name="creation_date")
	@Generated(GenerationTime.INSERT)
	private LocalDateTime creationDate;

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

	public String getAdmissionStatus() {
		return admissionStatus;
	}

	public void setAdmissionStatus(String admissionStatus) {
		this.admissionStatus = admissionStatus;
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

	public Set<String> getPatientComorbidities() {
		return patientComorbidities;
	}

	public void setPatientComorbidities(Set<String> patientComorbidities) {
		this.patientComorbidities = patientComorbidities;
	}

	public PatientMaster getPatientDetails() {
		return patientDetails;
	}

	public void setPatientDetails(PatientMaster patientDetails) {
		this.patientDetails = patientDetails;
	}
	
	public boolean isUpdatedOnGovtSite() {
		return updatedOnGovtSite;
	}

	public void setUpdatedOnGovtSite(boolean updatedOnGovtSite) {
		this.updatedOnGovtSite = updatedOnGovtSite;
	}

	public int getId() {
		return id;
	}
	
	public String getComorbidities() {
		StringBuilder builder = new StringBuilder();
		for(String str : this.patientComorbidities) {
			builder.append(str).append(",");
		}
		if(builder.length() > 0)
			builder.delete(builder.length()-1,builder.length());
		return builder.toString();
	}

	public Boolean getUpdatedOnGovtSite() {
		return updatedOnGovtSite;
	}

	public void setUpdatedOnGovtSite(Boolean updatedOnGovtSite) {
		this.updatedOnGovtSite = updatedOnGovtSite;
	}

	public LocalDateTime getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(LocalDateTime creationDate) {
		this.creationDate = creationDate;
	}
	
	
}
