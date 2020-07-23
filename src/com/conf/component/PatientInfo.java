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
import org.hibernate.annotations.ParamDef;

@Entity
public class PatientInfo {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	// vitals
	private String heartRate;
	
	private String bloodPressure;
	
	private String oxygenSaturation;
	
	private String respiratoryRate;
	
	private String pulseRate;
	
	private String temperature;
	
	private boolean vitalChange;
	
	private String ventilation;
	
	private boolean changeInVentilation;
	
	private String spO2;
	
	private boolean changeInSpO2;
	
	private String dDimer;
	
	private boolean changeIndDimer;
	
	private String chestXRay;
	
	private boolean changeFromPreviousXRay;
	
	private String principalMedicineGiven;
	
	private String plasmaTherapy;
	
	private String currentAssessment; // status quo / improving / unclear yet / guarded.
	
	@Column(name="creation_time")
	private LocalDateTime creationDate;
	
	@ManyToOne
	private PatientMaster patientMaster;

	public String getHeartRate() {
		return heartRate;
	}

	public void setHeartRate(String heartRate) {
		this.heartRate = heartRate;
	}

	public String getBloodPressure() {
		return bloodPressure;
	}

	public void setBloodPressure(String bloodPressure) {
		this.bloodPressure = bloodPressure;
	}

	public String getOxygenSaturation() {
		return oxygenSaturation;
	}

	public void setOxygenSaturation(String oxygenSaturation) {
		this.oxygenSaturation = oxygenSaturation;
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

	public String getVentilation() {
		return ventilation;
	}

	public void setVentilation(String ventilation) {
		this.ventilation = ventilation;
	}

	public boolean isChangeInVentilation() {
		return changeInVentilation;
	}

	public void setChangeInVentilation(boolean changeInVentilation) {
		this.changeInVentilation = changeInVentilation;
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

	public LocalDateTime getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(LocalDateTime creationDate) {
		this.creationDate = creationDate;
	}
	
	
}
