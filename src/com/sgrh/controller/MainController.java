package com.sgrh.controller;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.conf.component.CurrentFeedbackDate;
import com.conf.component.Patient;
import com.conf.component.Feedback;
import com.conf.component.Roles;
import com.conf.component.User;
import com.sgrh.service.PatientFeedbackService;
//import com.sgrh.service.ReportService;

@Controller
@SessionAttributes({"patient"})
public class MainController{
	
	private LocalDate feedbackDate;
	int duration;
	@Autowired
	PatientFeedbackService eFS;
	
	//@Autowired
	//ReportService service;
	
	
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
	public String home(Model model,HttpSession session){
		Patient patient = new Patient();
		model.addAttribute("patient", patient);
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
				System.out.println(role);
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
		empGlobal = eFS.startPatientFeedback(patientInit.getName(), patientInit.getPhoneNo(), patientInit.getAddress(), patientInit.getGender());
		eFS.saveFeedback(empGlobal);
		model.addAttribute("patient", empGlobal);
		model.addAttribute("submitted","success");
		landingPage = "feedback";
		return landingPage;
	}
	
	@RequestMapping(value = "submit_form", method=RequestMethod.POST)
	public String formSubmission(Model model, @ModelAttribute("patient") Patient patient, HttpSession session){
		System.out.println(patient.getFeedbackList().get(0).getDonatePlasma());
		eFS.updateFeeback(patient);
		return "form_submitted";
	}
	
	@RequestMapping(value="admin_panel")
	public String adminPanel(Model model,HttpSession session) {
		if(session.getAttribute("username") == null || session.getAttribute("username").toString().length() == 0) {
			return "login";
		}
		model.addAttribute("username",session.getAttribute("username").toString());
		return "admin_panel";
	}
	
	// Error Handling request
	@ExceptionHandler(Exception.class)
	public String handleAnyError(Model model, HttpSession session) {
		String page = "redirect:login";
		String role = session.getAttribute("role").toString();
		if(role.equals("user")) {
			page = "redirect:home";
		}
		else if(role.equals("admin")) {
			page = "redirect:admin_panel";
		}
		return page;
	}
	
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
}
