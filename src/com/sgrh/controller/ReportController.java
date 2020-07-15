package com.sgrh.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sgrh.service.PatientFeedbackService;
import com.sgrh.service.ReportService;

@Controller
@SessionAttributes()
public class ReportController {
	
	private LocalDate startDate;
	
	@Autowired
	private ReportService reportService;
	
	@RequestMapping("pie_chart")
	public @ResponseBody String generatePieChart() {
		System.out.println("Calling Pie chart controller");
		LocalDate startDate = LocalDate.of(2020, 7, 1);
		LocalDate endDate = LocalDate.of(2020, 7, 31);
		this.plasmaDetails(startDate, endDate);
		Map<String,Long> dataMap = reportService.pieChart(startDate, endDate);
		List<String> strList = new ArrayList<>();
		String result = "[]";
		if(dataMap!=null) {
		for(String str: dataMap.keySet()){
			if((str != null) && (str != " ") && (str !="") && str.length()>0){
				JSONObject obj = new JSONObject();
				obj.put("name", str);
				obj.put("value", dataMap.get(str));
				strList.add(obj.toString());
			}
			result = Arrays.toString(strList.toArray(new String[strList.size()]));
		}}
		return result;
	}
	
	/**
	 * This method will populate summary graph
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@RequestMapping(value="summary")
	public @ResponseBody String summary(LocalDate startDate, LocalDate endDate) {
		//long totalCount = reportService.empCount(dept);
		long feedbackCount = reportService.feedbackCount(startDate, endDate);
		//long totalCount = 10000;
		JSONObject obj = new JSONObject();
		//obj.put("total", totalCount);
		obj.put("feed", feedbackCount);
		//obj.put("no_feed", (totalCount - feedbackCount));
		
		return obj.toString();
	}
	
	@RequestMapping("barchart")
	public @ResponseBody String barchart(@RequestParam(name="dept") String dept) {
		HashMap<String,Integer> empFeedbackMap = reportService.patientWiseData(LocalDate.of(2020, 7, 1), LocalDate.of(2020, 7, 31));
		List<String> strList = new ArrayList<>();
		String result = "[]";
		if(empFeedbackMap !=null) {
			for(String str: empFeedbackMap.keySet()){
				if((str != null) && (str != " ") && (str !="") && str.length()>0){
					JSONObject obj = new JSONObject();
					obj.put("name", str);
					obj.put("value", empFeedbackMap.get(str));
					strList.add(obj.toString());
				}
			}
			result = Arrays.toString(strList.toArray(new String[strList.size()]));
		}
		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value ="graphs",method=RequestMethod.GET)
	public ModelAndView showGraph(Map<String,Object> model,HttpSession session, LocalDate startDate, LocalDate endDate){
		// fetch dept list and add to model attribute.
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return new ModelAndView("login");
		}
		// fetch a summary of of user feedback and return a json object. 
		Map<String,Long> map = reportService.pieChart(startDate, endDate);
		map.forEach((k,v) ->{
			System.out.println("Key: "+k +" -> Value: "+v);
		});
		JSONObject obj = new JSONObject();
		String jsonString = obj.toString();
		model.put("data",jsonString);
		return new ModelAndView("report");
	}
	
	@RequestMapping(value= "details")
	public ModelAndView detailsFeedbackPage(Map<String,Object> model,HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return new ModelAndView("login");
		}
		//empFeedbackDetails("Information Technology");
		return new ModelAndView("detailed_feedback");
	}
	
	@RequestMapping(value = "emp_details")
	public @ResponseBody String empFeedbackDetails(LocalDate startDate, LocalDate endDate) {
		// get list of question
		Map<String,Integer[]> summaryMap = reportService.feedbackDetailsList(startDate, endDate);
		
		List<JSONObject> listJsonObject = new ArrayList<>();
		
		summaryMap.forEach((k,v) -> {
			JSONObject obj = new JSONObject();
			obj.put(k,v);
			listJsonObject.add(obj);
		});
		return Arrays.toString(listJsonObject.toArray(new JSONObject[listJsonObject.size()]));
	}
	
	public @ResponseBody String plasmaDetails(LocalDate startDate, LocalDate endDate) {
		Map<String,Integer> plasmaResponse = reportService.getPlasmaPie(startDate, endDate);
		String plasmaString = null;
		if(plasmaResponse != null) {
			List<String> plasmaJson = new ArrayList<>();
			JSONObject object = new JSONObject();
			object.put("name","Total Count");
			object.put("value",plasmaResponse.get("Total Count"));
			plasmaJson.add(object.toString());
			
			object = new JSONObject();
			object.put("name","Yes");
			object.put("value",plasmaResponse.get("Yes"));
			plasmaJson.add(object.toString());
			
			object = new JSONObject();
			object.put("name", "No");
			object.put("value", plasmaResponse.get("No"));
			
			plasmaString = Arrays.toString(plasmaJson.toArray(new String[plasmaJson.size()]));
		}
		System.out.println(plasmaString);
		return plasmaString;
	}
}