package com.conf.component;

import javax.persistence.Entity;

@Entity
public class PatientInfo {
	// vitals
	private double heartRate;
	
	private String bloodPressure;
	
	private int oxygenSaturation;
	
	private int respiration;
	
	private double temperature;
	
	private boolean vitalChange;
	
	private String ventilation;
	
	private boolean changeInVentilation;
}
