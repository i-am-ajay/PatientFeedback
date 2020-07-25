package com.sgrh.service;

import java.time.LocalDate;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.conf.component.CurrentFeedbackDate;
import com.conf.component.Patient;
import com.conf.component.PatientInfo;
import com.conf.component.PatientMaster;
import com.conf.component.Roles;
import com.conf.component.User;
import com.sgrh.dao.PatientFeedback;

@Service
public class PatientFeedbackService {
	@Autowired
	private PatientFeedback patientFeedback;
	
	int count;
	
	public void generatedQuestions() {
		patientFeedback.saveQuestionMapInDB();
		//empFeedback.addQuestions();
	}
	
	/*public boolean isFeedbackExists(String empcode,LocalDate date) {
		Patient emp = empFeedback.isEmpFeedbackExists(empcode, date);
		boolean feedbackExists = false;
		if(emp != null) {
			feedbackExists = true;
		}
		return feedbackExists;
	}*/
	
	/* This method will save patient feedback in the database.
	 * 
	 */
	public Patient startPatientFeedback(String patientName, String phoneNo, String address, char gender, String regNo) {
		Patient emp = patientFeedback.createPatient(patientName, phoneNo, address, gender,regNo);
		int id = patientFeedback.addFeedback(emp);
		emp.setCurrentFeedbackId(id);
		return emp;
	}
	
	public void saveFeedback(Patient patient) {
		patientFeedback.savePatientFeedback(patient);
	}
	
	public void updateFeeback(Patient patient) {
		patientFeedback.updatePatientFeedback(patient);
	}
	
	public User authenticateUser(String emp, String password) {
		User user = patientFeedback.getUser(emp);
		if(user != null) {
			return user;
		}
		else {
			return null;
		}
	}
	
	public boolean createUser(String username, String password, String role, String createdBy) {
		User user = new User();
		Roles roles = new Roles();
		roles.setRole(role);
		roles.setCreatedBy(createdBy);
		roles.setActiveRole(true);
		
		user.setUsername(username);
		user.setPassword(password);
		user.getRoleList().add(roles);
		user.setCreatedBy(createdBy);
		user.setActive(true);
		return patientFeedback.saveUser(user);
	}
	
	public boolean saveCurrentDate(LocalDate date, int duration) {
		return patientFeedback.setCurrentFeedbackDate(date, duration);
	}
	
	public CurrentFeedbackDate getCurrentFeedbackDate() {
		return patientFeedback.getCurrentFeedbackDate();
	}
	
	public PatientMaster getPatient(String regNo) {
		return patientFeedback.getPatientFromMaster(regNo);
	}
	
	public boolean savePatientInfo(PatientInfo info) {
		return patientFeedback.savePatientInfo(info);
	}
	
	public PatientMaster getPatient5DayInfo(String regNo) {
		return patientFeedback.getPatientDetailsOfLast5Days(regNo);
	}
}
