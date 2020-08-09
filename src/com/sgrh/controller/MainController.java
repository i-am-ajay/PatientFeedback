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

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.conf.component.PatientInfo;
import com.conf.component.PatientMaster;
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
}
