package com.sgrh.dao;

import java.math.BigInteger;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ReportDao {
	@Autowired
	@Qualifier(value="feedback_factory")
	SessionFactory sessionFactory;
	
	@Transactional("feedback")
	public List<String[]> pieChartDataAll() {
		Session session = sessionFactory.getCurrentSession();
		Query summaryData = session.createQuery("select c.answer, count(c.answer)from Patient p join p.feedbackList f join f.choiceList c"
				+ " group by c.answer");
		List<String[]> l = summaryData.getResultList();
		System.out.println(l.toString());
		return l;
	}
	
	/* Methods returns an object through which we may find out which answer has what type of category. 
	 * Like : Good is Positive. Ok is Neutral.
	 * Return Type : A List of Object arrays, index 0: answer, index 1: category. 
	 * 
	 * */
	@Transactional("feedback")
	public List<Object[]> getCategory() {
		//SessionFactory factory = feedbackFactoryBean;
		Session session = sessionFactory.getCurrentSession();
		NativeQuery<Object[]> query= session.createNativeQuery("SELECT answer,category FROM answer_cat");
		return query.getResultList();
	}
	
	/*
	 * Method : returns a count of feedback with in given date range.
	 * Parameter:
	 * 		Start Date : LocalDate
	 * 		End Date : LocalDate
	 * */
	@Transactional("feedback")
	public int getfeedbackCount(LocalDate sDate, LocalDate eDate) {
		Session session = sessionFactory.getCurrentSession();
		NativeQuery query =null;
		query = session.createNativeQuery("SELECT count(*) FROM feedback WHERE 1=1 AND "
				+ " feedback_Date between :sDate And :eDate");
		query.setParameter("sDate", sDate);
		query.setParameter("eDate", eDate);
		Object obj = query.getSingleResult();
		BigInteger i = (BigInteger)obj;
		return i.intValue();
	}
	
	
	@Transactional("feedback")
	public Object getQuestionCount() {
		Session session = sessionFactory.getCurrentSession();
		NativeQuery query = session.createNativeQuery("SELECT count(*) FROM questions");
		return query.getSingleResult();
	}
	
	/**
	 * Method returns a list of patientNo and count based on cateogery for user reply. Like how many positive, negative and neutral 
	 * answers are there for the patient.
	 * @param startDate
	 * @param endDate
	 * @return List of Objects arrays, index 0 : patientNo, index 1: positive, index 2: neutral, index 3: negative for that patient
	 */
	@Transactional("feedback")
	public List<Object[]> patientList(LocalDate startDate, LocalDate endDate){
		Session session = sessionFactory.getCurrentSession();
		NativeQuery query = session.createNativeQuery("CALL user_feedback_summary(:sDate, :eDate)");
		query.setParameter("sDate", startDate);
		query.setParameter("eDate", endDate);
		return query.getResultList();
	}
	
	/**
	 * Method simply returns a string query used in empList method.
	 * @param sDate
	 * @param eDate
	 * @return
	 */
	private String getQuery(LocalDate sDate, LocalDate eDate) {
		String query = "";
			query =  "SELECT Summary.patientNo, Summary.category, max(w) FROM(\r\n" + 
					"	SELECT patient.patientNo, answer_cat.category, count(answer_cat.category) as w FROM Patient INNER JOIN feedback ON feedback.patient_id = patient.patientNo INNER JOIN \r\n" + 
					"	user_question_mapping ON feedback.id = user_question_mapping.Feedback_id INNER JOIN answer_cat\r\n" + 
					"	ON user_question_mapping.answer = answer_cat.answer\r\n" + 
					"	WHERE 1=1\r\n" + 
					"   	AND feedback.feedback_date BETWEEN :sDate AND :eDate" +
					"	GROUP BY patient.patientNo, answer_cat.category ORDER BY patientNo,w desc\r\n" + 
					"	) AS Summary GROUP BY Summary.patientNo";
		return query;
	}
	/* Return a list of question with count of positive, negative and neutral answers. 
	 * 
	 * @param startDate LocalDate
	 * @param endDate LocalDate
	 * 
	 * @return List of questions with count of feedback type.
	 */
	@Transactional("feedback")
	public List<Object[]> feedbackDetails(LocalDate startDate, LocalDate endDate){
		Session session = sessionFactory.getCurrentSession();
		NativeQuery query = session.createNativeQuery(feedbackDetailsQuery(startDate,endDate));
		query.setParameter("sDate", startDate);
		query.setParameter("eDate", endDate);
		return query.getResultList();
	}
	
	/**Method returns a query that finds total count of positive, negative or neutral for all question.
	 * 
	 * @param sDate
	 * @param eDate
	 * @return String : query 
	 */
	private String feedbackDetailsQuery(LocalDate sDate, LocalDate eDate) {
		String query = null;
		query = "SELECT questionid, count(category), category FROM user_question_mapping JOIN "
				+ " answer_cat ON user_question_mapping.answer = answer_cat.answer WHERE 1=1 "
				+ "AND feedback_id IN (	SELECT ID FROM feedback WHERE 1=1 AND "
				+"feedback_date between  :sDate AND :eDate ) GROUP BY questionid, category";
		return query;
	}
}
