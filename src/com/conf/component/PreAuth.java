package com.conf.component;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name="covid_pre_auth")
public class PreAuth {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(nullable=false)
	private String name;
	
	@Column(name="reg_no")
	private String regNo;
	
	@Column
	private String ward;
	
	@Column(name="doa")
	private LocalDateTime dateOfAddmission;
	
	@Column(name="disease_with_complaint", columnDefinition="longtext")
	private String diseaseWithComplaint;
	
	@Column(name="ailment_days", columnDefinition="int(11)")
	private int ailmentDays;
	
	@Column(name="dof_consultation")
	private int dateOfFirstConsultation;
	
	@Column(name="history_ailment", columnDefinition="longtext")
	private String pastHistoryAilment;
	
	@Column(name="provisional_diagnosis", columnDefinition="longtext")
	private String provisionalDiganosis;
	
	@Column(name="propose_treatment")
	private String proposedTreatment;
	
	@Column(name="investigation_details")
	private String investigationDetails;
	
	@Column
	private String route;
	
	@Column(name="surgery_name")
	private String surgeryName;
	
	@Column(name="icd_code")
	private String icdCode;
	
	@Column(name="other_treatment_details", columnDefinition="longtext")
	private String otherTreatmentDetails;
	
	@Column(name="date_fir_rta")
	private LocalDateTime dateFirRta;
	
	@Column(name="injury_disease_cause")
	private String injuryDiseaseCause;
	
	@Column(name="injury_disease_cause", columnDefinition="longtext")
	private String diabeteseHistory;
	
	@Column(name="heart_disease_history")
	private String heartDiseaseHistory;
	
	@Column
	private String hypertension;
	
	@Column
	private String hyperlipidemias;
	
	@Column
	private String osteoarthritis;
	
	@Column(name="lungs_issue")
	private String lungsIssue;
	
	@Column
	private String cancer;
	
	@Column
	private String drugs;
	
	@Column(name="hiv/Std")
	private String hivOrStd;
	
	@Column(columnDefinition="decimal(10,2)")
	private double expanses;
	
	@Column(name="expected_stay", columnDefinition="int(11)")
	private int expectedStay;
	
	@Column(name="expected_stay_icu", columnDefinition="int(11)")
	private int expectedStayIcu;
	
	@Column(name="room_type")
	private String roomType;
	
	@Column(name="room__rent_per_day", columnDefinition="double(10,2)")
	private double roomRentPerDay;
	
	@Column(name="approx_cost", columnDefinition="double(10,2)")
	private double approxCost;
	
	@Column(name="icu_charges", columnDefinition="double(10,2)")
	private double icuCharges;
	
	@Column(name="ot_charges", columnDefinition="double(10,2)")
	private double otCharges;
	
	@Column(name="professional_fees", columnDefinition="double(10,2")
	private double professionFees;
	
	@Column(name="consumable_cost", columnDefinition="double(10,2")
	private double consumableCost;
	
	@Column(name="other_charges", columnDefinition="double(10,2")
	private double otherCharges;
	
	@Column(name="package_charges", columnDefinition="double(10,2)")
	private double packageCharges;
	
	@Column(name="total_charges", columnDefinition="dobule(10,2)")
	private double totalCharges;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegNo() {
		return regNo;
	}

	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}

	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public LocalDateTime getDateOfAddmission() {
		return dateOfAddmission;
	}

	public void setDateOfAddmission(LocalDateTime dateOfAddmission) {
		this.dateOfAddmission = dateOfAddmission;
	}

	public String getDiseaseWithComplaint() {
		return diseaseWithComplaint;
	}

	public void setDiseaseWithComplaint(String diseaseWithComplaint) {
		this.diseaseWithComplaint = diseaseWithComplaint;
	}

	public int getAilmentDays() {
		return ailmentDays;
	}

	public void setAilmentDays(int ailmentDays) {
		this.ailmentDays = ailmentDays;
	}

	public int getDateOfFirstConsultation() {
		return dateOfFirstConsultation;
	}

	public void setDateOfFirstConsultation(int dateOfFirstConsultation) {
		this.dateOfFirstConsultation = dateOfFirstConsultation;
	}

	public String getPastHistoryAilment() {
		return pastHistoryAilment;
	}

	public void setPastHistoryAilment(String pastHistoryAilment) {
		this.pastHistoryAilment = pastHistoryAilment;
	}

	public String getProvisionalDiganosis() {
		return provisionalDiganosis;
	}

	public void setProvisionalDiganosis(String provisionalDiganosis) {
		this.provisionalDiganosis = provisionalDiganosis;
	}

	public String getProposedTreatment() {
		return proposedTreatment;
	}

	public void setProposedTreatment(String proposedTreatment) {
		this.proposedTreatment = proposedTreatment;
	}

	public String getInvestigationDetails() {
		return investigationDetails;
	}

	public void setInvestigationDetails(String investigationDetails) {
		this.investigationDetails = investigationDetails;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getSurgeryName() {
		return surgeryName;
	}

	public void setSurgeryName(String surgeryName) {
		this.surgeryName = surgeryName;
	}

	public String getIcdCode() {
		return icdCode;
	}

	public void setIcdCode(String icdCode) {
		this.icdCode = icdCode;
	}

	public String getOtherTreatmentDetails() {
		return otherTreatmentDetails;
	}

	public void setOtherTreatmentDetails(String otherTreatmentDetails) {
		this.otherTreatmentDetails = otherTreatmentDetails;
	}

	public LocalDateTime getDateFirRta() {
		return dateFirRta;
	}

	public void setDateFirRta(LocalDateTime dateFirRta) {
		this.dateFirRta = dateFirRta;
	}

	public String getInjuryDiseaseCause() {
		return injuryDiseaseCause;
	}

	public void setInjuryDiseaseCause(String injuryDiseaseCause) {
		this.injuryDiseaseCause = injuryDiseaseCause;
	}

	public String getDiabeteseHistory() {
		return diabeteseHistory;
	}

	public void setDiabeteseHistory(String diabeteseHistory) {
		this.diabeteseHistory = diabeteseHistory;
	}

	public String getHeartDiseaseHistory() {
		return heartDiseaseHistory;
	}

	public void setHeartDiseaseHistory(String heartDiseaseHistory) {
		this.heartDiseaseHistory = heartDiseaseHistory;
	}

	public String getHypertension() {
		return hypertension;
	}

	public void setHypertension(String hypertension) {
		this.hypertension = hypertension;
	}

	public String getHyperlipidemias() {
		return hyperlipidemias;
	}

	public void setHyperlipidemias(String hyperlipidemias) {
		this.hyperlipidemias = hyperlipidemias;
	}

	public String getOsteoarthritis() {
		return osteoarthritis;
	}

	public void setOsteoarthritis(String osteoarthritis) {
		this.osteoarthritis = osteoarthritis;
	}

	public String getLungsIssue() {
		return lungsIssue;
	}

	public void setLungsIssue(String lungsIssue) {
		this.lungsIssue = lungsIssue;
	}

	public String getCancer() {
		return cancer;
	}

	public void setCancer(String cancer) {
		this.cancer = cancer;
	}

	public String getDrugs() {
		return drugs;
	}

	public void setDrugs(String drugs) {
		this.drugs = drugs;
	}

	public String getHivOrStd() {
		return hivOrStd;
	}

	public void setHivOrStd(String hivOrStd) {
		this.hivOrStd = hivOrStd;
	}

	public double getExpanses() {
		return expanses;
	}

	public void setExpanses(double expanses) {
		this.expanses = expanses;
	}

	public int getExpectedStay() {
		return expectedStay;
	}

	public void setExpectedStay(int expectedStay) {
		this.expectedStay = expectedStay;
	}

	public int getExpectedStayIcu() {
		return expectedStayIcu;
	}

	public void setExpectedStayIcu(int expectedStayIcu) {
		this.expectedStayIcu = expectedStayIcu;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public double getRoomRentPerDay() {
		return roomRentPerDay;
	}

	public void setRoomRentPerDay(double roomRentPerDay) {
		this.roomRentPerDay = roomRentPerDay;
	}

	public double getApproxCost() {
		return approxCost;
	}

	public void setApproxCost(double approxCost) {
		this.approxCost = approxCost;
	}

	public double getIcuCharges() {
		return icuCharges;
	}

	public void setIcuCharges(double icuCharges) {
		this.icuCharges = icuCharges;
	}

	public double getOtCharges() {
		return otCharges;
	}

	public void setOtCharges(double otCharges) {
		this.otCharges = otCharges;
	}

	public double getProfessionFees() {
		return professionFees;
	}

	public void setProfessionFees(double professionFees) {
		this.professionFees = professionFees;
	}

	public double getConsumableCost() {
		return consumableCost;
	}

	public void setConsumableCost(double consumableCost) {
		this.consumableCost = consumableCost;
	}

	public double getOtherCharges() {
		return otherCharges;
	}

	public void setOtherCharges(double otherCharges) {
		this.otherCharges = otherCharges;
	}

	public double getPackageCharges() {
		return packageCharges;
	}

	public void setPackageCharges(double packageCharges) {
		this.packageCharges = packageCharges;
	}

	public double getTotalCharges() {
		return totalCharges;
	}

	public void setTotalCharges(double totalCharges) {
		this.totalCharges = totalCharges;
	}

	public int getId() {
		return id;
	}
}
