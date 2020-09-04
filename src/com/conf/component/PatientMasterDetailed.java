package com.conf.component;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class PatientMasterDetailed{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	
	@Column(unique=true)
	private String icmrId;
	
	private LocalDate dob;
	
	private String address;
	
	private char pincode;
	
	@OneToOne
	private PatientMaster master;

	public String getIcmrId() {
		return icmrId;
	}

	public void setIcmrId(String icmrId) {
		this.icmrId = icmrId;
	}

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public char getPincode() {
		return pincode;
	}

	public void setPincode(char pincode) {
		this.pincode = pincode;
	}

	public PatientMaster getMaster() {
		return master;
	}

	public void setMaster(PatientMaster master) {
		this.master = master;
	}

	public String getId() {
		return id;
	}
	
	
}
