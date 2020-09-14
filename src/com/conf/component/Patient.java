package com.conf.component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Embeddable;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;
import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.ParamDef;
import org.springframework.stereotype.Component;

@Component
@Entity
@FilterDef(name="valid_feedback")
public class Patient {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(columnDefinition="int")
	private int patientNo;
	
	@Column
	private String name;
	
	@Column
	private String phoneNo;
	
	@Column
	private String address;
	
	@Column(name="reg_no")
	private String regNo;
	
	@Column
	private char gender;
	
	@Transient
	private int currentFeedbackId;
	
	@OneToMany(mappedBy="patient", cascade= {CascadeType.PERSIST, CascadeType.REMOVE, CascadeType.REFRESH})
	@Fetch(value=FetchMode.JOIN)
	@OrderBy(clause = "id ASC")
	@Filter(name = "valid_feedback", condition = "donate_plasma is not null and donate_plasma != ''")
	List<Feedback> feedbackList = new ArrayList<>();
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public int getPatientNo() {
		return patientNo;
	}
	public List<Feedback> getFeedbackList() {
		return feedbackList;
	}
	public void setFeedbackList(List<Feedback> list) {
		this.feedbackList = list;
	}
	
	public PatientChoice getQuestionChoice(int feedback, int questionId) {
		return null;//feedbackList.get(feedback).getChoiceList().get(questionId);
	}
	public int getCurrentFeedbackId() {
		return currentFeedbackId;
	}
	public void setCurrentFeedbackId(int currentFeedbackId) {
		this.currentFeedbackId = currentFeedbackId;
	}
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
}
