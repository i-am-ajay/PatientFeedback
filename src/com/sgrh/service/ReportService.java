package com.sgrh.service;

import java.math.BigInteger;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ajay.others.QuestionBank;

import com.sgrh.dao.ReportDao;

@Service
public class ReportService {
	@Autowired
	ReportDao reportDao;
	
	/**
	 * Returns a map that has categories as key and count percentage as value.
	 * All feedback replies are combined, to get a summary of the dataset percentage of positive, negative and neutral in total 
	 * replies. 
	 * @param startDate
	 * @param endDate
	 * @return a map with key as category and percentage share as value.
	 */
	public Map<String,Long> pieChart(LocalDate startDate, LocalDate endDate){
		System.out.println("Pie chart service.");
		List<String[]> summaryList = null;
		summaryList = reportDao.pieChartDataAll();
		Map<String,Long> map = null;
		if(summaryList != null && summaryList.size()>0) {
			map = convertUserInput(summaryList);
		}
		map.forEach((k,v) -> {
			System.out.println("Key : "+k +" -> Value: "+v);
		});
		return map;
	}
	
	/**
	 * Method find which type of choice has highest weightage in user feedback, based on that it analyse if user feedback is
	 * highly poisitve, positive, neutral, negative or highly negative. 
	 * @param sDate
	 * @param eDate
	 * @return Map of feedback type and it's count. 
	 * Like Very Positive : count
	 */
	public HashMap<String,Integer> patientWiseData(LocalDate sDate,LocalDate eDate) {
		List<Object[]> empFeedbackList = reportDao.patientList(sDate, eDate);

		BigInteger integer = (BigInteger)reportDao.getQuestionCount();
		int finalCount = integer.intValue();
		int size = empFeedbackList.size();
		HashMap<String,Integer> feedbackMap = new LinkedHashMap<>();
		feedbackMap.put("Very Positive",0);
		feedbackMap.put("Positive", 0);
		feedbackMap.put("Neutral", 0);
		feedbackMap.put("Negative", 0);
		feedbackMap.put("Very Negative", 0);
		
		for(Object[] objArray : empFeedbackList) {
			System.out.println(objArray[0]+" -> "+objArray[1]);
			feedbackAnalysis(feedbackMap, objArray, finalCount);
		}
		
		feedbackMap.forEach((k,v) -> {
			feedbackMap.put(k, (int)(((float)v/(float)size)*100));
		});
		return feedbackMap;
	}
	
	private void feedbackAnalysis(HashMap<String,Integer> map, Object[] obj, int finalCount) {
		//String feedbackType = (String)obj[1];
		BigInteger positiveCount = (BigInteger)obj[1];
		BigInteger neutralCount = (BigInteger)obj[2];
		BigInteger negativeCount = (BigInteger)obj[3];
		
		float positivePercentage = ((float)positiveCount.intValue() / (float)finalCount) * 100;
		float neutralPercentage  =((float)neutralCount.intValue() / (float)finalCount) * 100;
		float negativePercentage = ((float)negativeCount.intValue() / (float) finalCount) * 100;
		
		if(positivePercentage >= 80 )
			map.put("Very Positive", map.get("Very Positive")+1);
		else if(positivePercentage >=60 && positivePercentage<80)
			map.put("Positive", map.get("Positive")+1);
		else if(negativePercentage >= 80)
			map.put("Very Negative", map.get("Very Negative")+1);
		else if(negativePercentage >= 60 && negativePercentage < 80)
			map.put("Negative",map.get("Negative")+1);
		else if((positivePercentage >=40 && positivePercentage <60) || (negativePercentage >= 40 && negativePercentage < 60))
			map.put("Neutral", map.get("Neutral")+1);
		else if(neutralPercentage > 33)
			map.put("Neutral", map.get("Neutral")+1);
	}
	
	public Map<String,Long> convertUserInput(List<String[]> summaryList){
		List<Object[]> list = reportDao.getCategory();
		
		HashMap<String,Long> summaryMap = new HashMap<>();
		HashMap<String,String> categoryMap = new HashMap<>();
		// Convert list of values and category to map.
		for(Object[] obj : list) {
			categoryMap.put(((String)obj[0]).toLowerCase(),((String)obj[1]).toLowerCase());
		}
		for(Object[] str: summaryList) {
			String key = categoryMap.get(((String)str[0]).toLowerCase());
			summaryMap.put(key, summaryMap.getOrDefault(key, 0L)+(Long)str[1]);
		}
		return summaryMap;
	}
	
	public long feedbackCount(LocalDate startDate,LocalDate endDate) {
		return reportDao.getfeedbackCount(startDate, endDate);
	}
	
	public Map<String,Integer[]> feedbackDetailsList(LocalDate startDate,LocalDate endDate){
		List<Object[]> feedbackList = reportDao.feedbackDetails(startDate, endDate);
		
		// From feedbackList create a map question as keys and count array as values.
		Map<String,Integer[]> questionFeedbackSummary = new HashMap<>();
		for(Object[] obj : feedbackList) {
			String question = QuestionBank.getInstance().getQuestionStatement((int)obj[0]);
			/* summary Array will hold user count for each question, how many gave 
			 * positive/ negative / neutral reply for a question.
			 * index 0 has positive count
			 * index 1 has neutral count
			 * index 2 has negative count
			 */
			questionFeedbackSummary.put(question, questionFeedbackSummary.getOrDefault(question, new Integer[] {0,0,0}));
			Integer[] summaryArray = questionFeedbackSummary.get(question);
			if(obj[2].equals("Good")) {
				BigInteger integer = (BigInteger) obj[1];
				if(summaryArray[0] == null || summaryArray[0] == 0) {
					summaryArray[0] = integer.intValue();
				}
				else {
					summaryArray[0] += integer.intValue();
				}
			}
			else if(obj[2].equals("Bad")) {
				if(summaryArray[2] == null || summaryArray[2] == 0) {
					BigInteger integer = (BigInteger)obj[1];
					summaryArray[2] = integer.intValue();
				}
				else {
					BigInteger integer = (BigInteger)obj[1];
					summaryArray[2] += integer.intValue();
				}
			}
			else if(obj[2].equals("OK")) {
				if(summaryArray[1] == null || summaryArray[1] == 0) {
					BigInteger integer = (BigInteger)obj[1];
					summaryArray[1] = integer.intValue();
				}
				else {
					BigInteger integer = (BigInteger)obj[1];
					summaryArray[1] += integer.intValue();
				}
			}
		}
		return questionFeedbackSummary;
	}
	
	public Map<String,Integer> getPlasmaPie(LocalDate startDate, LocalDate endDate){
		List<Object[]> plasmaDonorList = reportDao.getPlasmaPie(startDate, endDate);
		Map<String, Integer> parameterMap = new HashMap<>();
		int totalCount = reportDao.getfeedbackCount(startDate, endDate);
		parameterMap.put("Total Count", totalCount);
		parameterMap.put((String)plasmaDonorList.get(0)[0], (Integer)plasmaDonorList.get(0)[1]);
		parameterMap.put((String)plasmaDonorList.get(1)[0],(Integer)plasmaDonorList.get(1)[1]);
		return parameterMap;
	}
}
