package com.conf.component;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CascadeType;

@Entity
public class PatientInfo {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	// vitals
	private double heartRate;
	
	private String bloodPressure;
	
	private int oxygenSaturation;
	
	private int respiratoryRate;
	
	private int pulseRate;
	
	private double temperature;
	
	private boolean vitalChange;
	
	private String vitalRemarks;
	
	private String ventilation;
	
	private boolean changeInVentilation;
	
	private int spO2;
	
	private boolean changeInSpO2;
	
	private String spO2Remarks;
	
	private double dDimer;
	
	private boolean changeIndDimer;
	
	private String chestXRay;
	
	private boolean changeFromPreviousXRay;
	
	private String principalMedicineGiven;
	
	private String plasmaTherapy;
	
	private String currentAssessment; // status quo / improving / unclear yet / guarded.
	
	private String assessmentRemarks;
	
	@ManyToOne
	private PatientMaster patientMaster;

	public double getHeartRate() {
		return heartRate;
	}

	public void setHeartRate(double heartRate) {
		this.heartRate = heartRate;
	}

	public String getBloodPressure() {
		return bloodPressure;
	}

	public void setBloodPressure(String bloodPressure) {
		this.bloodPressure = bloodPressure;
	}

	public int getOxygenSaturation() {
		return oxygenSaturation;
	}

	public void setOxygenSaturation(int oxygenSaturation) {
		this.oxygenSaturation = oxygenSaturation;
	}

	public int getRespiratoryRate() {
		return respiratoryRate;
	}

	public void setRespiratoryRate(int respiration) {
		this.respiratoryRate = respiration;
	}

	public double getTemperature() {
		return temperature;
	}

	public void setTemperature(double temperature) {
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

	public int getSpO2() {
		return spO2;
	}

	public void setSpO2(int spO2) {
		this.spO2 = spO2;
	}

	public boolean isChangeInSpO2() {
		return changeInSpO2;
	}

	public void setChangeInSpO2(boolean changeInSpO2) {
		this.changeInSpO2 = changeInSpO2;
	}

	public double getdDimer() {
		return dDimer;
	}

	public void setdDimer(double dDimer) {
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

	public int getPulseRate() {
		return pulseRate;
	}

	public void setPulseRate(int pulseRate) {
		this.pulseRate = pulseRate;
	}

	public String getVitalRemarks() {
		return vitalRemarks;
	}

	public void setVitalRemarks(String vitalRemarks) {
		this.vitalRemarks = vitalRemarks;
	}

	public String getSpO2Remarks() {
		return spO2Remarks;
	}

	public void setSpO2Remarks(String vitalSpO2) {
		this.spO2Remarks = vitalSpO2;
	}

	public String getAssessmentRemarks() {
		return assessmentRemarks;
	}

	public void setAssessmentRemarks(String assessmentRemarks) {
		this.assessmentRemarks = assessmentRemarks;
	}
	
	
}
