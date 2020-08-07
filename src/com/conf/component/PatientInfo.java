package com.conf.component;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.annotations.ParamDef;

@Entity
public class PatientInfo {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	// vitals
	private String bloodPressure;
	
	private String respiratoryRate;
	
	private String pulseRate;
	
	private String temperature;
	
	private boolean vitalChange;
	
	private String oxygenSupplementation;
	
	private String oxygenationDevice;
	
	private boolean ventilationNeeded;
	
	private String modeOfVentilator;
	
	private String spO2;
	
	private boolean changeInSpO2;
	
	private String dDimer;
	
	private boolean changeIndDimer;
	
	private String chestXRay;
	
	private boolean changeFromPreviousXRay;
	
	private String principalMedicineGiven;
	
	private String plasmaTherapy;
	
	private String currentAssessment; // status quo / improving / unclear yet / guarded.
	
	// new fields
	
	private boolean proning;
	
	@Column(name="investigation_reports",columnDefinition="blob")
	private String investigationAndReports;
	
	private boolean changeInTreatment;
	
	@Column(name="change_reason",columnDefinition="blob")
	private String reasonOfChange;
	
	private String patientCondition;
	
	private String experimentalTherapy;
	
	@Column(name="comment",columnDefinition="blob")
	private String comment;
	
	@Column(name="creation_time",insertable=false, updatable=false)
	@Generated(GenerationTime.INSERT)
	private LocalDateTime infoCreationDate;
	
	@ManyToOne
	private PatientMaster patientMaster;

	public String getBloodPressure() {
		return bloodPressure;
	}

	public void setBloodPressure(String bloodPressure) {
		this.bloodPressure = bloodPressure;
	}

	public String getRespiratoryRate() {
		return respiratoryRate;
	}

	public void setRespiratoryRate(String respiration) {
		this.respiratoryRate = respiration;
	}

	public String getTemperature() {
		return temperature;
	}

	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}

	public boolean isVitalChange() {
		return vitalChange;
	}

	public void setVitalChange(boolean vitalChange) {
		this.vitalChange = vitalChange;
	}

	public String getSpO2() {
		return spO2;
	}

	public void setSpO2(String spO2) {
		this.spO2 = spO2;
	}

	public boolean isChangeInSpO2() {
		return changeInSpO2;
	}

	public void setChangeInSpO2(boolean changeInSpO2) {
		this.changeInSpO2 = changeInSpO2;
	}

	public String getdDimer() {
		return dDimer;
	}

	public void setdDimer(String dDimer) {
		this.dDimer = dDimer;
	}

	public boolean isChangeIndDimer() {
		return changeIndDimer;
	}

	public void setChangeIndDimer(boolean changeIndDimer) {
		this.changeIndDimer = changeIndDimer;
	}

	public String getChestXRay() {
		return chestXRay;
	}

	public void setChestXRay(String chestXRay) {
		this.chestXRay = chestXRay;
	}

	public boolean isChangeFromPreviousXRay() {
		return changeFromPreviousXRay;
	}

	public void setChangeFromPreviousXRay(boolean changeFromPreviousXRay) {
		this.changeFromPreviousXRay = changeFromPreviousXRay;
	}

	public String getPrincipalMedicineGiven() {
		return principalMedicineGiven;
	}

	public void setPrincipalMedicineGiven(String principalMedicineGiven) {
		this.principalMedicineGiven = principalMedicineGiven;
	}

	public String getPlasmaTherapy() {
		return plasmaTherapy;
	}

	public void setPlasmaTherapy(String plasmaTherapy) {
		this.plasmaTherapy = plasmaTherapy;
	}

	public String getCurrentAssessment() {
		return currentAssessment;
	}

	public void setCurrentAssessment(String currentAssessment) {
		this.currentAssessment = currentAssessment;
	}

	public PatientMaster getPatientMaster() {
		return patientMaster;
	}

	public void setPatientMaster(PatientMaster patientMaster) {
		this.patientMaster = patientMaster;
	}

	public int getId() {
		return id;
	}

	public String getPulseRate() {
		return pulseRate;
	}

	public void setPulseRate(String pulseRate) {
		this.pulseRate = pulseRate;
	}

	public LocalDateTime getInfoCreationDate() {
		return infoCreationDate;
	}

	public void setInfoCreationDate(LocalDateTime creationDate) {
		this.infoCreationDate = creationDate;
	}

	public String getOxygenSupplementation() {
		return oxygenSupplementation;
	}

	public void setOxygenSupplementation(String oxygenSupplementation) {
		this.oxygenSupplementation = oxygenSupplementation;
	}

	public String getOxygenationDevice() {
		return oxygenationDevice;
	}

	public void setOxygenationDevice(String oxygenationDevice) {
		this.oxygenationDevice = oxygenationDevice;
	}

	public boolean isVentilationNeeded() {
		return ventilationNeeded;
	}

	public void setVentilationNeeded(boolean ventilationNeeded) {
		this.ventilationNeeded = ventilationNeeded;
	}

	public String getModeOfVentilator() {
		return modeOfVentilator;
	}

	public void setModeOfVentilator(String modeOfVentilator) {
		this.modeOfVentilator = modeOfVentilator;
	}

	public boolean isProning() {
		return proning;
	}

	public void setProning(boolean proning) {
		this.proning = proning;
	}

	public String getInvestigationAndReports() {
		return investigationAndReports;
	}

	public void setInvestigationAndReports(String investigationAndReports) {
		this.investigationAndReports = investigationAndReports;
	}

	public boolean isChangeInTreatment() {
		return changeInTreatment;
	}

	public void setChangeInTreatment(boolean changeInTreatment) {
		this.changeInTreatment = changeInTreatment;
	}

	public String getReasonOfChange() {
		return reasonOfChange;
	}

	public void setReasonOfChange(String reasonOfChange) {
		this.reasonOfChange = reasonOfChange;
	}

	public String getPatientCondition() {
		return patientCondition;
	}

	public void setPatientCondition(String patientCondition) {
		this.patientCondition = patientCondition;
	}

	public String getExperimentalTherapy() {
		return experimentalTherapy;
	}

	public void setExperimentalTherapy(String experimentalTherapy) {
		this.experimentalTherapy = experimentalTherapy;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
