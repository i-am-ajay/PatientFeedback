package com.conf.component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Generated;
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
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.mapping.Bag;
import org.springframework.stereotype.Component;

@Component
@Entity
public class Feedback {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@CreationTimestamp
	private LocalDate creationDate;
	
	@Column(name="blood_group")
	private String bloodGroup;
	
	@Column(name = "donate_plasma")
	private String donatePlasma;
	
	@ElementCollection(fetch= FetchType.EAGER)
	@CollectionTable(name="existing_disease")
	@JoinColumn(name="patient_id")
	@Column(name="existing_disease")
	private List<String> existingDisease = new ArrayList<>(); 
	
	@Column(name="feedback_date")
	private LocalDate feedbackPeriod;
	
	@ManyToOne(cascade= {CascadeType.REFRESH})
	@JoinColumn(name="patient_id")
	private Patient patient;
	
	@Transient
	private PatientChoice currentQuestion;
	@Transient
	private int currentQuestionIndex;
	
	@ElementCollection(fetch=FetchType.EAGER)
	@CollectionTable(name="user_question_mapping")
	@Fetch(FetchMode.SUBSELECT)
	private Map<Integer,PatientChoice> choiceList = new HashMap<>();
	
	public LocalDate getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(LocalDate creationDate) {
		this.creationDate = creationDate;
	}
	public Map<Integer,PatientChoice> getChoiceList() {
		return choiceList;
	}
	public void setChoiceList(Map<Integer,PatientChoice> choiceList){
		this.choiceList = choiceList;
	}
	public int getId(){
		return id;
	}
	
	public LocalDate getFeedbackPeriod() {
		return feedbackPeriod;
	}
	public void setFeedbackPeriod(LocalDate feedbackPeriod) {
		this.feedbackPeriod = feedbackPeriod;
	}
	public Patient getPatient() {
		return patient;
	}
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	public String getBloodGroup() {
		return bloodGroup;
	}
	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}
	public List<String> getExistingDisease() {
		return existingDisease;
	}
	public void setExistingDisease(List<String> existingDisease) {
		this.existingDisease = existingDisease;
	}
	public PatientChoice getCurrentQuestion() {
		return currentQuestion;
	}
	public void setCurrentQuestion(PatientChoice currentQuestion) {
		this.currentQuestion = currentQuestion;
	}
	public String getDonatePlasma() {
		return donatePlasma;
	}
	public void setDonatePlasma(String doneatePlasma) {
		this.donatePlasma = doneatePlasma;
	}
	
	
	
}
