package com.sgrh.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.event.ListSelectionEvent;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.function.ServerRequest.Headers;

import com.conf.component.CurrentFeedbackDate;
import com.conf.component.Patient;
import com.conf.component.PatientAnalysis;
import com.conf.component.PatientComcare;
import com.conf.component.PatientInfo;
import com.conf.component.PatientMaster;
import com.conf.component.PatientMasterDetailed;
//import com.conf.component.PreAuth;
import com.conf.component.Feedback;
import com.conf.component.Roles;
import com.conf.component.User;
import com.sgrh.service.PatientFeedbackService;
//import com.sgrh.service.ReportService;
import com.sgrh.service.ReportService;

@Controller
@SessionAttributes({"patient","page"})
public class MainController{
	
	private LocalDate feedbackDate;
	int duration;
	String page;
	@Autowired
	PatientFeedbackService eFS;
	
	@Autowired
	ReportService service;
	
	
	Patient empGlobal;
	
	int feedbackId;
	
	Patient patient;
	private LocalDate feedbackEndDate;
	
	// User authentication related.
	@RequestMapping("signup")
	public String signup(Model model,HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		return "registration";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}
	
	@RequestMapping("create_user")
	public String createUser(@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam("role") String role,HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		String page;
		boolean status = eFS.createUser(username, password, role, session.getAttribute("username").toString());
		if(status == true) {
			page = "signup";
		}
		else {
			page = "already_exists";
		}
		return page;
	}
	
	@RequestMapping(value={"/","home"})
	public String home(Model model,HttpSession session,@RequestParam(name="page", required=false, defaultValue="source") String page){
		if(session.getAttribute("page") == null) {
			System.out.println("Called");
			session.setAttribute("page", page);
		}
		Patient patient = new Patient();
		model.addAttribute("patient", patient);
		model.addAttribute("page",session.getAttribute("page").toString());
		//model.addAttribute("role",session.getAttribute("role").toString());
		return "index";
	}
	
	@RequestMapping("authenticate_user")
	public String authenticateUser(Model model,HttpSession session, @RequestParam(name="username") String userName, @RequestParam(name="password") String password ) {
		String page = "login";
		userName = userName.toLowerCase();
		User user = eFS.authenticateUser(userName, password);
		if( user != null && user.isActive()) {
			if(user.getPassword().equals(password.trim())) {
				session.setAttribute("username", user.getUsername());
				session.setAttribute("role", user.getRoleList().get(0).getRole());
				List<Roles> roleList = user.getRoleList();
				String role = roleList.get(0).isActiveRole()? roleList.get(0).getRole() : "login";
				role = role.toLowerCase();
				if(role.equals("admin")) {
					page="redirect:admin_panel";
				}
				else if(role.equals("user")) {
					page = "redirect:/";
				}
				else {
					page = "login";
				}
			}
		}
		return page;
	}
	
	@RequestMapping("/feedback")
	public String feedback(Model model,HttpSession session,@ModelAttribute("patient") Patient patientInit){
		String landingPage = "";
		LocalDate date = this.feedbackDate;
		eFS.generatedQuestions();
		empGlobal = eFS.startPatientFeedback(patientInit.getName(), patientInit.getPhoneNo(), patientInit.getAddress(), patientInit.getGender(), patientInit.getRegNo());
		eFS.saveFeedback(empGlobal);
		model.addAttribute("patient", empGlobal);
		model.addAttribute("submitted","success");
		landingPage = "feedback";
		return landingPage;
	}
	
	@RequestMapping(value = "submit_form", method=RequestMethod.POST)
	public String formSubmission(Model model, @ModelAttribute("patient") Patient patient, HttpSession session){
		eFS.updateFeeback(patient);
		return "form_submitted";
	}
	
	@RequestMapping(value="admin_panel")
	public String adminPanel(Model model,HttpSession session) {
		/*if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		model.addAttribute("username",session.getAttribute("username").toString());*/
		page = "admin";
		return "admin_panel";
	}
	
	@RequestMapping(value="report_panel")
	public String reportPanel(Model model,HttpSession session) {
		/*if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		model.addAttribute("username",session.getAttribute("username").toString());*/
		page = "admin";
		return "report_panel";
	}            
	
	// Error Handling request
	/*@ExceptionHandler(Exception.class)
	public String handleAnyError(Model model, HttpSession session) {
			String page = "redirect:admin_panel";
		return page;
	}*/
	
	@RequestMapping("start_feedback")
	public String feedbackGenerator(Model model, HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		model.addAttribute("date",feedbackDate);
		model.addAttribute("duration",duration);
		model.addAttribute("endDate",feedbackEndDate);
		return "feedback_generator";
	}
	
	@RequestMapping("generate_feedback_month")
	public String generateCurrentFeedback(@RequestParam("date") int month, @RequestParam("duration")int duration,HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		int year = LocalDate.now().getYear();
		LocalDate date = LocalDate.of(year, month, 1);
		
		boolean flag = eFS.saveCurrentDate(date, duration);
		if(flag) {
			feedbackDate = date;
			this.duration = duration;
			feedbackEndDate = date.plusMonths(duration).with(TemporalAdjusters.lastDayOfMonth());
		}
		return "redirect:start_feedback";
	}
	
	@PostConstruct
	public void getCurrentDate() {
		CurrentFeedbackDate date = eFS.getCurrentFeedbackDate();
		if(date != null) {
			this.feedbackDate = eFS.getCurrentFeedbackDate().getFeedbackDate();
			this.duration = eFS.getCurrentFeedbackDate().getDuration();
			this.feedbackEndDate = eFS.getCurrentFeedbackDate().getFeedbackEndDate();
		}
	}
	
	/*@RequestMapping("pre_auth")
	public String startPreAuth(Model model) {
		PreAuth auth = new PreAuth();
		model.addAttribute("preAuth", auth);
		return "pre_auth";
	}*/
	
	/*public String getPatient(String patientRegNo) {
		
	}*/
	
	@RequestMapping("patient_master")
	public String patientMaster(Model model){
		PatientMaster master = new PatientMaster();
		PatientInfo info = new PatientInfo();
		info.setPatientMaster(master);
		model.addAttribute("patientInfo",info);
		return "patient_master";
	}
	
	@RequestMapping("save_report")
	public String savePatientReport(@ModelAttribute PatientInfo info, Model model) {
		if(info != null) {
			eFS.savePatientInfo(info);
		}
		LocalDateTime dateTime = LocalDateTime.now();
		String date = dateTime.format(DateTimeFormatter.ofLocalizedDate(FormatStyle.LONG));
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		String time = dateTime.format(formatter);
		model.addAttribute("date",date);
		model.addAttribute("time",time);
		return "patient_info_saved";
	}
	
	@RequestMapping("patient_analysis")
	public String patientAnalysis(Model model) {
		PatientMaster master = new PatientMaster();
		PatientAnalysis analysis = new PatientAnalysis();
		analysis.setCovidResult("negative");
		analysis.setCovidTestDate(LocalDate.now());
		analysis.setPatientMaster(master);
		model.addAttribute("patientAnalysis",analysis);
		return "patient_analysis";
	}
	
	@RequestMapping("patient_comcare")
	public String patientComcare(Model model) {
		PatientMasterDetailed detailedMaster = new PatientMasterDetailed();
		
		PatientComcare comcare = new PatientComcare();
		comcare.setAdmissionDate(LocalDate.now());
		comcare.setTestResultDate(LocalDate.now());
		comcare.setTestSampleCollectionDate(LocalDate.now());
		comcare.setPatientDetails(detailedMaster);
		
		model.addAttribute("patientComcare",comcare);
		return "patient_comcare";
	}
	
	/*
	@RequestMapping("analysis_save")
	public String test(@ModelAttribute String analysis) {
		return "save_analysis";
	}*/
	
	@RequestMapping("analysis_save")
	public String savePatientAnalysis( @ModelAttribute PatientAnalysis patientAnalysis,Model model) {
		if(patientAnalysis != null) {
			eFS.savePatientAnalysis(patientAnalysis);
		}
		LocalDateTime dateTime = LocalDateTime.now();
		String date = dateTime.format(DateTimeFormatter.ofLocalizedDate(FormatStyle.LONG));
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		String time = dateTime.format(formatter);
		model.addAttribute("date",date);
		model.addAttribute("time",time);
		return "save_analysis";
	}
	
	@RequestMapping(value="data_search")
	public String vitalReport() {
		return "patient_report";
	}
	@RequestMapping(value="report")
	public String patient5DayReport(Model model, @RequestParam(name="regNo", required=false)String regNo,
			@RequestParam(name="phone",required=false) String phoneNo, @RequestParam(name="name",required=false) String name) {
		PatientMaster master = null;
		String[] headerArray = new String[21];
		String[][] datatable = new String[21][5];
		// set header array
		headerArray[0] = "BP";
		headerArray[1] = "PR";
		headerArray[2] = "Temp";
		headerArray[3] = "Respiratory Rate";
		headerArray[4] = "SpO2";
		headerArray[5] = "O2 Supplementation";
		headerArray[6] = "O2 Device";
		headerArray[7] = "D-Dimer";
		headerArray[8] = "X-Ray";
		headerArray[9] = "Principal Medicine";
		headerArray[10] = "Ventilation Needed";
		headerArray[11] = "Ventilation Mode";
		headerArray[12] = "Need Of Proning";
		headerArray[13] = "Investigation Comment";
		headerArray[14] = "Change In Treatment";
		headerArray[15] = "Reason Of Change";
		headerArray[16] = "Current Asmt";
		headerArray[17] = "Experimental Therapy";
		headerArray[18] = "Any Comment";	
		headerArray[19] = "Date";
		headerArray[20] = "Time";
		// fill data array with NA
		for(String [] strArray : datatable) {
			Arrays.fill(strArray, "NA");	
		}
		
		if(regNo != null && regNo.length() > 0) {
			master = eFS.getPatient5DayInfo(regNo);
			// create a datatable matrix
			if(master != null) {
				model.addAttribute("name_val",master.getName());
				model.addAttribute("reg_no",master.getRegistrationNumber());
				model.addAttribute("phone_no",master.getMobileNo());
				
				int size = master.getPatientInfoList().size();
				if(size >5) {
					size = 5;
				}
				int count =0;
				while(count<size) {
					PatientInfo info = master.getPatientInfoList().get(count);
					datatable[0][count] = info.getBloodPressure();
					datatable[1][count] = info.getPulseRate();
					datatable[2][count] = info.getTemperature();
					datatable[3][count] = info.getRespiratoryRate();
					datatable[4][count] = info.getSpO2();
					datatable[5][count] = info.getOxygenSupplementation();
					datatable[6][count] = info.getOxygenationDevice();
					datatable[7][count] = info.getdDimer();
					datatable[8][count] = info.getChestXRay();
					datatable[9][count] = info.getPrincipalMedicineGiven();
					datatable[10][count] = info.isVentilationNeeded() == true ? "Yes":"No";
					datatable[11][count] = info.getModeOfVentilator();
					datatable[12][count] = info.isProning() == true ? "Yes" : "No";
					datatable[13][count] = info.getInvestigationAndReports();
					datatable[14][count] = info.isChangeInTreatment() == true ? "Yes" : "No";
					datatable[15][count] = info.getReasonOfChange();
					datatable[16][count] = info.getCurrentAssessment();
					datatable[17][count] = info.getExperimentalTherapy();
					datatable[18][count] = info.getComment();
					datatable[19][count] = info.getInfoCreationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
					datatable[20][count] = info.getInfoCreationDate().format(DateTimeFormatter.ofPattern("HH:mm"));
					count++;
				}
			}
		}
		model.addAttribute("data", datatable);
		model.addAttribute("header_array",headerArray);
		return "vital_result";
	}
	
	@RequestMapping("patient_details")
	public @ResponseBody String getEmpDetails(@RequestParam("reg_no")String regNo) {
		PatientMaster master = eFS.getPatient(regNo);
		String patientDetails = null;
		if(master != null) {
			JSONObject object = new JSONObject();
			object.put("name", master.getName());
			object.put("phone", master.getMobileNo());
			object.put("reg_no", master.getRegistrationNumber());
			object.put("gender", master.getGender());
			patientDetails = object.toString();
		}
		return patientDetails;
	}
	
	@RequestMapping("comcare_save")
	public String comcareSave(@ModelAttribute PatientComcare comcare) {
		eFS.savePatientComcare(comcare);
		return "redirect:patient_comcare";
	}
	
	@RequestMapping("fetch_patient_details")
	public @ResponseBody String fetchPatientDetails(@RequestParam("param") String param, @RequestParam("type") String type) {
		String resultString = null;
		PatientMaster details = eFS.fetchPatientDetailed(param, type);
		if(details != null) {
			JSONObject obj = new JSONObject();
			obj.put("name", details.getName());
			obj.put("mobile", details.getMobileNo());
			obj.put("gender", details.getGender());
			obj.put("reg", details.getRegistrationNumber());
			obj.put("address", details.getAddress());
			obj.put("age", details.getAge());
			obj.put("pincode", details.getPincode());
			obj.put("icmrId", details.getIcmrId());
			resultString = obj.toString();
		}
		return resultString;
	}
	
	@RequestMapping("dashboard")
	public String comcareDashboard(Model model) {
		List<PatientComcare> patientComcareList = eFS.getComcareList();
		return "report/comcare_dashboard";
	}
	
	@RequestMapping("table_update")
	public @ResponseBody String updateRecords(@RequestParam(name="comorbidities_id", required=false)int id) {
		System.out.println(id);
		if(id != 0) {
			
		}
		List<PatientComcare> patientComcareList = eFS.getComcareList();
		List<JSONObject> listObject = new ArrayList<>();
		JSONObject obj = null;
		System.out.println("Size of patientComcareList"+patientComcareList.size());
		for(PatientComcare comcare : patientComcareList) {
			obj = new JSONObject();
			/*String [] strArray = new String[21];
			strArray[0] =comcare.getPatientDetails().getRegistrationNumber();
			strArray[1] = comcare.getPatientDetails().getIcmrId();
			strArray[2] = comcare.getSrfId();
			strArray[3] = comcare.getPatientDetails().getName();
			strArray[4] = comcare.getPatientDetails().getMobileNo();
			strArray[5] = comcare.getPatientDetails().getDob().toString();
			strArray[6] = comcare.getPatientDetails().getDob().toString();
			strArray[7] = comcare.getPatientDetails().getPincode();
			strArray[8] = comcare.getPatientDetails().getAddress();
			strArray[9] = comcare.getPatientDetails().getGender();
			strArray[10] = comcare.getTestResult();
			strArray[11] = comcare.getTestSampleCollectionDate().toString();
			strArray[12] = comcare.getTestResult();
			strArray[13] = comcare.getTestSite();
			strArray[14] = comcare.getLabName();
			strArray[15] = comcare.getLabCode();
			strArray[16] = comcare.getPatientCondition();
			strArray[17] = comcare.getAdmissionStatus();
			strArray[18] = comcare.getAdmissionDate().toString();
			strArray[19] = comcare.getTransferedFrom();
			strArray[20] = comcare.getComorbidities();
			
			listObject.add(strArray);*/
			
			obj.put("reg", comcare.getPatientDetails().getRegistrationNumber());
			obj.put("icmr", comcare.getPatientDetails().getIcmrId());
			obj.put("srfid", comcare.getSrfId());
			obj.put("name", comcare.getPatientDetails().getName());
			obj.put("phone", comcare.getPatientDetails().getMobileNo());
			obj.put("age", comcare.getPatientDetails().getAge());
			obj.put("pincode", comcare.getPatientDetails().getPincode());
			obj.put("address", comcare.getPatientDetails().getAddress());
			obj.put("gender", comcare.getPatientDetails().getGender());
			obj.put("repeat_test", comcare.isRepeatTest());
			obj.put("test_result", comcare.getTestResult());
			obj.put("collection_date", comcare.getTestSampleCollectionDate());
			obj.put("result_date", comcare.getTestResult());
			obj.put("test_site", comcare.getTestSite());
			obj.put("lab_name", comcare.getLabName());
			obj.put("lab_code", comcare.getLabCode());
			obj.put("patient_condition", comcare.getPatientCondition());
			obj.put("admission_status", comcare.getAdmissionStatus());
			obj.put("admission_date", comcare.getAdmissionDate());
			obj.put("transfer_from", comcare.getTransferedFrom());
			obj.put("patient_com", comcare.getComorbidities());
			obj.put("record_id",comcare.getId());
			listObject.add(obj);
		}
		//obj.put("data", objArray.toString());
		
		return Arrays.toString(listObject.toArray(new JSONObject[listObject.size()]));
	}
	
	@RequestMapping("update_data")
	public @ResponseBody String update(@RequestParam("id") String id, @RequestParam(name="icmr_id", required=false) String icmrId, @RequestParam(name="srf_id", required=false) String srfId) { //, @RequestParam("icmr_id") String icmrId, 
		String result = "not updated";
		int i = Integer.parseInt(id);
	
		eFS.udpateRecord(i, icmrId, srfId);
		result = "Done";
		return result;
	}
	
	// Various Reports
	// Comcare Report
	@RequestMapping("comcare_report")
	public String patientComcareSearch(Model model, @RequestParam(name="reg", required=false) String reg, 
			@RequestParam(name="icmr_id",required=false) String icmrId, 
			@RequestParam(name="srf_id",required=false) String srfId, 
			@RequestParam(name="p_name",required=false) String patientName,
			@RequestParam(name="f_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate fromDate,
			@RequestParam(name="t_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate toDate) {
		List<PatientComcare> list = eFS.searchPatientComcare(patientName, reg, icmrId, srfId, fromDate, toDate);
		model.addAttribute("comcare_data",list);
		return "report/comcare_report";
	}
	
	@RequestMapping("feedback_report")
	public String patientFeedbackReport(@RequestParam(name="p_name",required=false)String name,
				@RequestParam(name="phone_no", required=false)String phone,
				@RequestParam(name="reg_no", required=false)String regNo,
				@RequestParam(name="address",required=false) String address,
				@RequestParam(name="f_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate fromDate,
				@RequestParam(name="t_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate toDate, Model model) {
		List<Feedback> feedbackList = eFS.searchFeedback(name, regNo, phone, address,fromDate, toDate);
		model.addAttribute("feedback_list",feedbackList);
		
		return "report/patient_search";
	}
	
	@RequestMapping("patientmaster_report")
	public String patientSearch(@RequestParam(name="p_name",required=false)String name,
			@RequestParam(name="phone_no", required=false)String phone,
			@RequestParam(name="reg_no", required=false)String regNo,
			@RequestParam(name="address",required=false) String gender,
			@RequestParam(name="f_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate fromDate,
			@RequestParam(name="t_date", required=false) @DateTimeFormat(iso=ISO.DATE)LocalDate toDate, Model model) {
		List<PatientMaster> patientMasterList = eFS.searchPatientMaster(name, regNo, phone, gender, fromDate, toDate);
		model.addAttribute("patient_master",patientMasterList);
		return "report/patient_master_search";
	}
	
	@RequestMapping("patient_modal_data")
	public @ResponseBody String getPatientModalData(@RequestParam(name="regNo") String regNo) {
		PatientMaster master = null;
		List<JSONObject> patientInfoObject = new ArrayList<>();
		if(regNo != null && regNo.length() > 0) {
			master = eFS.getPatient5DayInfo(regNo);
		}
		
		String resultString = null;
		JSONObject jsonObj = null;
		if(master != null) {
			for(PatientInfo info: master.getPatientInfoList()) {
				jsonObj = new JSONObject();
				jsonObj.put("bp", info.getBloodPressure());
				jsonObj.put("pr", info.getPulseRate());
				jsonObj.put("temp", info.getTemperature());
				jsonObj.put("respiratoryRate", info.getRespiratoryRate());
				jsonObj.put("spO2", info.getSpO2());
				jsonObj.put("oxygenSuppl", info.getOxygenSupplementation());
				jsonObj.put("oxygenationDevice", info.getOxygenationDevice());
				jsonObj.put("ddimer", info.getdDimer());
				jsonObj.put("chestXray", info.getChestXRay());
				jsonObj.put("principlalMedicineGiven", info.getPrincipalMedicineGiven());
				jsonObj.put("ventilationNeeded", info.isVentilationNeeded() == true ? "Yes":"No");
				jsonObj.put("modeOfVentilator", info.getModeOfVentilator());
				jsonObj.put("proning", info.isProning() == true ? "Yes" : "No");
				jsonObj.put("investigationReports", info.getInvestigationAndReports());
				jsonObj.put("changeInTreatment", info.isChangeInTreatment() == true ? "Yes" : "No");
				jsonObj.put("reasonOfChange", info.getReasonOfChange());
				//jsonObj.put("reasonOfChange", info.getReasonOfChange());
				jsonObj.put("currentAssessment", info.getCurrentAssessment());
				jsonObj.put("experimentalTherapy", info.getExperimentalTherapy());
				jsonObj.put("comment", info.getComment());
				jsonObj.put("creation_date", info.getInfoCreationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
				jsonObj.put("creation_time", info.getInfoCreationDate().format(DateTimeFormatter.ofPattern("HH:mm")));

				patientInfoObject.add(jsonObj);
			}
			JSONObject [] jsonArray = patientInfoObject.toArray(new JSONObject[patientInfoObject.size()]);
			resultString = Arrays.toString(jsonArray);
		}
		return resultString;	
	}
	
}
