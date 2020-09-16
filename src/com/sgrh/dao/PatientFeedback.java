package com.sgrh.dao;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Criteria;
import org.hibernate.Filter;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.orm.hibernate5.LocalSessionFactoryBuilder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ajay.others.QuestionBank;
import com.conf.component.CurrentFeedbackDate;


import com.conf.component.Feedback;
import com.conf.component.Patient;
import com.conf.component.PatientAnalysis;
import com.conf.component.PatientChoice;
import com.conf.component.PatientComcare;
import com.conf.component.PatientInfo;
import com.conf.component.PatientMaster;
import com.conf.component.PatientMasterDetailed;
import com.conf.component.Questions;
import com.conf.component.User;

@Repository
public class PatientFeedback{
	@Autowired
	@Qualifier(value="feedback_factory")
	SessionFactory feedbackFactoryBean;
	
	static int count;
	
	@Transactional("feedback")
	public Patient createPatient(String patientName, String phoneNo, String address, char gender, String regNo) {
		Patient patient = null;
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		patient = new Patient();
		patient.setName(patientName);
		patient.setPhoneNo(phoneNo);
		patient.setAddress(address);
		patient.setGender(gender);
		patient.setRegNo(regNo);
		session.persist(patient);
		return patient;
	}
	
	/* Returns the patient if feedback exists.
	 * Paramter :
	 * 		patientName : String,
	 * 		patientPhone : String,
	 * 		patientGender : char
	 * We'll use this method to keep a check same patient doesn't fill feedback again and again. 
	 */
	
	@Transactional("feedback")
	public void saveQuestionMapInDB() {
		PatientFeedback.count=1;
		if(PatientFeedback.count > 0) {
			return;
		}
		else {
			count++;
			//SessionFactory factory = feedbackFactoryBean.getObject();
			SessionFactory factory = feedbackFactoryBean;
			Session session = factory.getCurrentSession();
			Map<Integer,Questions> questionBank = QuestionBank.getInstance().getQuestionMap();
			for(Integer in: questionBank.keySet()) {
				session.save(questionBank.get(in));
				session.flush();
			}
		}
	}
	
	@Transactional("feedback")
	private Patient getPatient(String patientName, String patientPhone, char gender) {
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<Patient> criteriaQuery = builder.createQuery(Patient.class);
		Root<Patient> from = criteriaQuery.from(Patient.class);
		criteriaQuery.where(builder.and(builder.equal(from.get("patientName"), patientName),
				builder.equal(from.get("phoneNo"),patientPhone),builder.equal(from.get("gender"), gender)));
		TypedQuery<Patient>query = session.createQuery(criteriaQuery);
		//Filter filter = session.enableFilter("feedback_datewise");
		//filter.setParameter("feedback_date", date);
		Patient patient;
		try {
			patient = query.getSingleResult();
		}
		catch(NoResultException ex) {
			patient = null;
		}
		session.disableFilter("feedback_datewise");
		return patient;
	}
	
	@Transactional("feedback")
	public int addFeedback(Patient patient) {
		Feedback feedback = new Feedback();
		feedback.setFeedbackPeriod(LocalDate.now().withDayOfMonth(1));
		for(Integer i: QuestionBank.getInstance().getQuestionMap().keySet()){
			feedback.getChoiceList().put(i,new PatientChoice(i, ""));
		}
		
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		patient.getFeedbackList().add(feedback);
		feedback.setPatient(patient);
		session.persist(feedback);
		session.flush();
		return feedback.getId();
	}
	
	@Transactional("feedback")
	public void savePatientFeedback(Patient patient){
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		//Employee emp1 = session.get(Employee.class, emp.getEmpCode());
		//session.merge(emp.getFeedbackList().get(0));
		session.saveOrUpdate(patient);
		session.flush();
	}
	
	
	@Transactional("feedback")
	public void updatePatientFeedback(Patient patient){
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		Feedback feedback = null;
		feedback = session.get(Feedback.class,patient.getCurrentFeedbackId());
		feedback.setDonatePlasma(patient.getFeedbackList().get(0).getDonatePlasma());
		feedback.setExistingDisease(patient.getFeedbackList().get(0).getExistingDisease());
		feedback.setBloodGroup(patient.getFeedbackList().get(0).getBloodGroup());
		feedback.setChoiceList(patient.getFeedbackList().get(0).getChoiceList());
		session.flush();
	}
	
	/*@Transactional("feedback")
	public void addQuestions(){
		//SessionFactory factory = feedbackFactoryBean.getObject();
		SessionFactory factory = feedbackFactoryBean;
		Session session = factory.getCurrentSession();
		Questions question = new Questions();
		question.setQuestion("Do you know your rights");
		question.getChoices().add("Y");
		question.getChoices().add("N");
		question.getChoices().add("DN");
		
		Questions question1 = new Questions();
		question1.setQuestion("Do you know leaves are not your right?");
		question1.getChoices().add("Y");
		question1.getChoices().add("N");
		question1.getChoices().add("DN");
		session.persist(question);
		session.persist(question1);
	}*/
	
	@Transactional("feedback")
	// get user details for databse user table.
	public User getUser(String userName) {
		Session session = feedbackFactoryBean.getCurrentSession();
		User user = session.get(User.class, userName);
		return user;
	}
	
	@Transactional("feedback")
	public boolean saveUser(User user) {
		User tempUser = getUser(user.getUsername());
		boolean isUserCreated = false;
		if(tempUser == null) {
			Session session = feedbackFactoryBean.getCurrentSession();
			session.save(user);
			session.flush();
			isUserCreated = true;
		}
		return isUserCreated;
	}
	
	@Transactional("feedback")
	public boolean setCurrentFeedbackDate(LocalDate startDate, int duration) {
		LocalDate endDate = startDate.plusMonths(duration);
		Session session = feedbackFactoryBean.getCurrentSession();
		String queryString = "FROM CurrentFeedbackDate WHERE feedbackEndDate > :startDate AND open=true ";
		TypedQuery<CurrentFeedbackDate> selectionQuery = session.createQuery(queryString,CurrentFeedbackDate.class); 
		selectionQuery.setParameter("startDate", startDate);
		List<CurrentFeedbackDate> feedbackDateList = selectionQuery.getResultList();
		if(feedbackDateList.size() > 0) {
			return false;
		}
		String updateString = "UPDATE CurrentFeedbackDate SET isOpen = 0 WHERE isOpen = 1";
		Query updateQuery = session.createQuery(updateString);
		updateQuery.executeUpdate();
		session.flush();
		String insertString = "INSERT INTO current_feedback (feedback_date, duration, end_date,isopen ) VALUES (?, ?, ?,true)";
		NativeQuery insertQuery = session.createNativeQuery(insertString);
		insertQuery.setParameter(1, startDate);
		insertQuery.setParameter(2, duration);
		insertQuery.setParameter(3, endDate);
		int val = insertQuery.executeUpdate();
		if(val > 0) {
			return true;
		}
		return false;
	}
	
	@Transactional("feedback")
	public CurrentFeedbackDate getCurrentFeedbackDate(){
		Session session = feedbackFactoryBean.getCurrentSession();
		String queryString = "FROM CurrentFeedbackDate WHERE open=true";
		TypedQuery<CurrentFeedbackDate> selectionQuery = session.createQuery(queryString, CurrentFeedbackDate.class);
		CurrentFeedbackDate obj = null;
		try {
			obj = selectionQuery.getSingleResult();
		}
		catch(RuntimeException ex) {
			obj = null;
		}
		return obj;
	}
	
	@Transactional("feedback")
	public boolean savePatientInfo(PatientInfo info) {
		boolean successFlag = false;
		Session session = feedbackFactoryBean.getCurrentSession();
		PatientMaster master = getPatientFromMaster(info.getPatientMaster().getRegistrationNumber());
		if(master == null) {
			session.save(info.getPatientMaster());
		}
		else {
			info.setPatientMaster(master);
		}
		session.save(info);
		//session.flush();
		successFlag = true;
		return successFlag;
	}
	
	@Transactional("feedback")
	public boolean savePatientAnalysis(PatientAnalysis analysis) {
		boolean successFlag = false;
		Session session = feedbackFactoryBean.getCurrentSession();
		PatientMaster master = getPatientFromMaster(analysis.getPatientMaster().getRegistrationNumber());
		if(master == null) {
			session.save(analysis.getPatientMaster());
		}
		else {
			analysis.setPatientMaster(master);
		}
		session.save(analysis);
		return successFlag;
	}
	
	@Transactional("feedback")
	public void savePatientComcare(PatientComcare comcare) {
		PatientMaster detailed = comcare.getPatientDetails();
		
		Session session = feedbackFactoryBean.getCurrentSession();

		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientMaster> query = builder.createQuery(PatientMaster.class);
		Root<PatientMaster> from = query.from(PatientMaster.class);
		query.where(builder.equal(from.get("registrationNumber"), detailed.getRegistrationNumber()));
		TypedQuery<PatientMaster> detailedQuery = session.createQuery(query);
		PatientMaster tempDetailed = null;
		
		try {
			tempDetailed = detailedQuery.getSingleResult();
		}
		catch(NoResultException | NonUniqueResultException | IllegalStateException ex) {
			System.out.println("Error in save patient");
			//ex.printStackTrace();
		}
		if(tempDetailed == null) {
			session.save(detailed);
		}
		else {
			tempDetailed.setAddress(detailed.getAddress());
			tempDetailed.setDob(detailed.getDob());
			tempDetailed.setIcmrId(detailed.getIcmrId());
			tempDetailed.setMobileNo(detailed.getMobileNo());
			tempDetailed.setPincode(detailed.getPincode());
			session.saveOrUpdate(tempDetailed);
			comcare.setPatientDetails(tempDetailed);
		}
	
		session.save(comcare);
	}
	
	@Transactional("feedback")
	public void getPatientFromMaster(int id) {
		Session session = feedbackFactoryBean.getCurrentSession();
		session.get(PatientMaster.class, id);
	}
	@Transactional("feedback")
	public PatientMaster getPatientFromMaster(String regNo) {
		Session session = feedbackFactoryBean.getCurrentSession();

		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientMaster> query = builder.createQuery(PatientMaster.class);
		Root<PatientMaster> from = query.from(PatientMaster.class);
		query.where(builder.equal(from.get("registrationNumber"), regNo));
		
		TypedQuery<PatientMaster> masterQuery = session.createQuery(query);
		PatientMaster master = null;
		try {
			master = masterQuery.getSingleResult();
		}
		catch(Exception ex) {
			
		}
		return master;
	}
	
	@Transactional("feedback")
	public PatientMaster getPatientDetailsOfLast5Days(String regNo) {
		Session session = feedbackFactoryBean.getCurrentSession();
		
		//LocalDateTime endPeriod = LocalDateTime.now();
		//LocalDateTime startPeriod = endPeriod.minusDays(5);
		//startPeriod = LocalDateTime.of(startPeriod.getYear(), startPeriod.getMonth(), startPeriod.getDayOfMonth(),0,0);
		//Filter filter = session.enableFilter("date_filter");
		//filter.setParameter("sDate", startPeriod);
		//filter.setParameter("eDate", endPeriod);
		
		// Query to get Patient
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientMaster> query = builder.createQuery(PatientMaster.class);
		Root<PatientMaster> from = query.from(PatientMaster.class);
		query.where(builder.equal(from.get("registrationNumber"), regNo));
		TypedQuery<PatientMaster> masterQuery = session.createQuery(query);
		PatientMaster master = null;
		try {
			master = masterQuery.getSingleResult();
			
		}
		catch(Exception ex) {
		}
		return master;
	}
	
	@Transactional("feedback")
	public PatientMaster fetchPatientDetails(String param, String type) {
		Session session = feedbackFactoryBean.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientMaster> query = builder.createQuery(PatientMaster.class);
		Root<PatientMaster> from = query.from(PatientMaster.class);
		if(type.equals("reg")) {
			query.where(builder.equal(from.get("registrationNumber"), param));
		}
		else {
			query.where(builder.equal(from.get("icmrId"), param));
		}
		TypedQuery<PatientMaster> detailedQuery = session.createQuery(query);
		PatientMaster tempDetailed = null;
		try {
			tempDetailed = detailedQuery.getSingleResult();
		}
		catch(NoResultException | NonUniqueResultException | IllegalStateException ex) {
			//ex.printStackTrace();
		}
		return tempDetailed;
	}
	
	/***
	 * Provides list of all the Comcare records those are not yet updated on govt site.
	 * @return List of PatientComcare
	 */
	@Transactional("feedback")
	public List<PatientComcare> getPendingComcareList(){
		Session session = feedbackFactoryBean.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientComcare> criteria = builder.createQuery(PatientComcare.class);
		Root<PatientComcare> from = criteria.from(PatientComcare.class);
		criteria.where(builder.or(builder.isNull(from.get("updatedOnGovtSite")),
				builder.equal(from.get("updatedOnGovtSite"), false)));
		TypedQuery<PatientComcare> query = session.createQuery(criteria);
		List<PatientComcare> list = query.getResultList();
		for(PatientComcare com : list) {
			System.out.println(com.getComorbidities());
		}
		return list;
	}
	
	@Transactional("feedback")
	public void updateRecord(int id, String icmr, String srfid) {
		Session session = feedbackFactoryBean.getCurrentSession();
		PatientComcare comcare = session.get(PatientComcare.class, id);
		comcare.getPatientDetails().setIcmrId(icmr);
		comcare.setSrfId(srfid);
		comcare.setUpdatedOnGovtSite(true);
		session.saveOrUpdate(comcare);
	}
	
	@Transactional("feedback")
	public List<PatientComcare> patientComcareReport(String patientName, String registration, String icmrId, String srfId, LocalDate fromDate, LocalDate endDate) {
		Session session = feedbackFactoryBean.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientComcare> criteria = builder.createQuery(PatientComcare.class);
		Root<PatientComcare> from = criteria.from(PatientComcare.class);
		
		
		// List that will hold predicates.
		List<Predicate> predicateList = new ArrayList<>();
		// Define various predicates.
		if(patientName != null && patientName.length() > 0) {
			predicateList.add(builder.like(from.get("patientDetails").get("name"), "%"+patientName+"%"));
		}
		if(registration != null && registration.length() > 0) {
			predicateList.add(builder.equal(from.get("patientDetails").get("registrationNumber"), registration));
		}
		if(icmrId != null && icmrId.length() > 0) {
			predicateList.add(builder.equal(from.get("patientDetails").get("icmrId"), icmrId));
		}
		if(srfId != null && srfId.length() > 0) {
			predicateList.add(builder.equal(from.get("srfId"), srfId));
		}
		
		if(fromDate != null) {
			predicateList.add(builder.greaterThanOrEqualTo(from.get("creationDate"),LocalDateTime.of(fromDate, LocalTime.of(0, 0))));
		}
		
		if(endDate != null) {
			predicateList.add(builder.lessThanOrEqualTo(from.get("creationDate"),LocalDateTime.of(endDate, LocalTime.of(0, 0))));
		}
		
		Predicate [] predicateArray = predicateList.toArray(new Predicate[predicateList.size()]);
		
		criteria.where(builder.and(predicateArray));
		
		TypedQuery<PatientComcare> query = session.createQuery(criteria);
		return query.getResultList();
	}
	
	@Transactional("feedback")
	public List<Feedback> searchFeedback(String name, String regNo, String phone, String address, 
			LocalDate startDate, LocalDate endDate){
		Session session = feedbackFactoryBean.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<Feedback> criteria = builder.createQuery(Feedback.class);
		Root<Feedback> from = criteria.from(Feedback.class);
		
		List<Predicate> predicateList = new ArrayList<>();
		// get only those feedback where donate plasma option is not null.
		predicateList.add(builder.isNotNull(from.get("donatePlasma")));
		predicateList.add(builder.notEqual(from.get("donatePlasma"), ""));
		//predicateList.add(builder.isNotEmpty(from.get("donatePlasma")));
		if(name != null && name.length() > 0) {
			predicateList.add(builder.like(from.get("patient").get("name"),"%"+name+"%"));
		}
		if(regNo != null && regNo.length() >0) {
			predicateList.add(builder.equal(from.get("patient").get("regNo"), regNo));
		}
		
		if(phone !=null && phone.length() >0) {
			predicateList.add(builder.equal(from.get("patient").get("phonNo"), phone));
		}
		
		if(address !=null && address.length() >0) {
			predicateList.add(builder.like(from.get("patient").get("address"), "%"+address+"%"));
		}
		
		if(startDate != null) {
			predicateList.add(builder.greaterThanOrEqualTo(from.get("creationDate"), startDate));
		}
		
		if(endDate !=null) {
			predicateList.add(builder.lessThanOrEqualTo(from.get("creationDate"), endDate));
		}
		
		Predicate[] predicateArray = predicateList.toArray(new Predicate[predicateList.size()]);
		
		criteria.where(builder.and(predicateArray));
		
		session.enableFilter("valid_feedback");
		TypedQuery<Feedback> patientQuery = session.createQuery(criteria);
		return patientQuery.getResultList();
	}
	
	@Transactional("feedback")
	public List<PatientMaster> searchPatientMaster(String regNo, String name,
			String phone, String gender, LocalDate startDate, LocalDate endDate){
		Session session = feedbackFactoryBean.getCurrentSession();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<PatientMaster> criteria = builder.createQuery(PatientMaster.class);
		Root<PatientMaster> from = criteria.from(PatientMaster.class);
		
		List<Predicate> predicateList = new ArrayList<>();
		// get only those feedback where donate plasma option is not null.

		//predicateList.add(builder.isNotEmpty(from.get("donatePlasma")));
		if(name != null && name.length() > 0) {
			predicateList.add(builder.like(from.get("name"),"%"+name+"%"));
		}
		if(regNo != null && regNo.length() >0) {
			predicateList.add(builder.equal(from.get("regNo"), regNo));
		}
		
		if(phone !=null && phone.length() >0) {
			predicateList.add(builder.equal(from.get("phonNo"), phone));
		}
		
		if(gender !=null && gender.length() >0) {
			predicateList.add(builder.like(from.get("gender"), gender));
		}
		
		if(startDate != null) {
			predicateList.add(builder.greaterThanOrEqualTo(from.get("creationDate"), startDate));
		}
		
		if(endDate !=null) {
			predicateList.add(builder.lessThanOrEqualTo(from.get("creationDate"), endDate));
		}
		
		Predicate[] predicateArray = predicateList.toArray(new Predicate[predicateList.size()]);
		
		criteria.where(builder.and(predicateArray));
		
		TypedQuery<PatientMaster> typedQuery = session.createQuery(criteria);
		
		return typedQuery.getResultList();
	}
}
