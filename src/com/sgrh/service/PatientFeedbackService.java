package com.sgrh.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.conf.component.CurrentFeedbackDate;
import com.conf.component.Feedback;
import com.conf.component.Patient;
import com.conf.component.PatientAnalysis;
import com.conf.component.PatientComcare;
import com.conf.component.PatientInfo;
import com.conf.component.PatientMaster;
import com.conf.component.PatientMasterDetailed;
import com.conf.component.Roles;
import com.conf.component.User;
import com.sgrh.dao.PatientFeedback;
import com.sgrh.dao.TrakDAO;

@Service
public class PatientFeedbackService {
	@Autowired
	private PatientFeedback patientFeedback;
	
	@Autowired
	private TrakDAO trakDao;
	
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
	
	public User getUser(String emp) {
		User user = patientFeedback.getUser(emp);
		if(user != null) {
			return user;
		}
		else {
			return null;
		}
	}
	
	public boolean createUser(String username, String password, String role, String createdBy, boolean status) {
		User dbuser = getUser(username);
		boolean isCreated = false;
		if(dbuser == null) {
			isCreated = true;
			User user = new User();
			user.setUsername(username);
			user.setPassword(password);
			user.setRole(role);
			user.setCreatedBy(createdBy);
			user.setActive(status);
			dbuser = user;
		}
		else {
			if(password != null && password != "") {
				dbuser.setPassword(password);
			}
			dbuser.setCreatedBy(createdBy);
			dbuser.setActive(status);
			dbuser.setRole(role);
		}
		patientFeedback.saveUser(dbuser);
		return isCreated;
	}
	
	public void updatePassword(User user) {
		patientFeedback.updatePassword(user);
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
	
	public boolean savePatientAnalysis(PatientAnalysis analysis) {
		return patientFeedback.savePatientAnalysis(analysis);
	}
	
	public void savePatientComcare(PatientComcare comcare) {
		patientFeedback.savePatientComcare(comcare);
	}
	
	public PatientMaster getPatient5DayInfo(String regNo) {
		return patientFeedback.getPatientDetailsOfLast5Days(regNo);
	}
	
	public PatientMaster fetchPatientDetailed(String param, String type) {
		return patientFeedback.fetchPatientDetails(param, type);
	}
	
	public List<PatientComcare> getComcareList(){
		return patientFeedback.getPendingComcareList();
	}
	
	public void udpateRecord(int id, String icmrId, String srfid) {
		patientFeedback.updateRecord(id, icmrId, srfid);
	}
	
	public List<PatientComcare> searchPatientComcare(String patientName, String registration, String icmrId, String srfId, LocalDate fromDate, LocalDate toDate){
		return patientFeedback.patientComcareReport(patientName, registration, icmrId, srfId, fromDate, toDate);
	}
	
	public List<Feedback> searchFeedback(String name, String regNo, String phone, String address, LocalDate startDate,LocalDate endDate){
		return patientFeedback.searchFeedback(name, regNo, phone, address,startDate,endDate);
	}
	
	public List<PatientMaster> searchPatientMaster(String name, String regNo, String phone, String gender, 
			LocalDate startDate,LocalDate endDate){
		return patientFeedback.searchPatientMaster(regNo, name, phone, gender, startDate, endDate);
	}
}
