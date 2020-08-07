<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Details</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body class=mt-1>
	<%@ include file = "header_health_report_card.jsp" %>
	<div class="container p-2 m-auto">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Details</h4>
		<f:form method="POST" modelAttribute="patientInfo" action="save_report">
		  <div class="form-row">
		  	 <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="registration" placeholder="Registration Number" path="patientMaster.registrationNumber" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-4">
			      <label for="patientName" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="name" placeholder="Patient Name" path="patientMaster.name"/>
			    </div>
			   
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="phone" placeholder="Mobile Number" path="patientMaster.mobileNo" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="Gender" class="font-weight-bold">Gender <span class="text-danger">*</span></label>
			      	<div>
			      		<div class="form-check-inline">
    						<f:radiobutton class="form-check-input mx-2" name="gender" id="mgender" value="m" path="patientMaster.gender" /><span class="mx-2"> Male</span> 
    						<f:radiobutton class="form-check-input ml-4" name="gender" id="fgender" value="f" path="patientMaster.gender" /><span class="mx-2">Female</span>
    					</div>
    				</div>
			    </div>	    
		   </div>
		   
		   <!-- Patient Vitals -->
		   <!--  <h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Report Card</h4>-->
		   <!-- Card Vitals -->
		   <div class="row border-top pt-2">
		   <div class="col-md-6">
		   <div class="card text-white bg-success px-3 mb-3 ml-auto" style="max-width: 36rem;">
  				<div class="card-header">Patient Vitals And Breathing</div>
  				<div class="card-body">
  					<div class="row">
  						<div class="col-md-6">
					    	<div class="form-group">
					      		<label for="bloodPressure" class="font-weight-bold">Blood Pressure <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="bloodPressure" placeholder="Blood Pressure" path="bloodPressure"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="pulse" class="font-weight-bold">Pulse Rate <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="pulse" placeholder="Pulse Rate" path="pulseRate"/>
					    	</div>
				    	</div>
				    	<div class="col-md-6">
					    	<div class="form-group">
					      		<label for="temp" class="font-weight-bold">Temperature <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="temp" placeholder="Temp" path="temperature"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="respiratory" class="font-weight-bold">Respiratory Rate <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="respiratory" placeholder="Respiratory Rate" path="respiratoryRate"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="spo2" class="font-weight-bold">SpO2 <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="spo2" placeholder="SpO2" path="spO2"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="o2Supplementation" class="font-weight-bold">Oxygen Supplementation<span class="text-danger">*</span></label>
					      		<f:select class="form-control form-control-sm" id="o2Supplementation" path="oxygenSupplementation" placeholder="Select Ventilation Type">
									<option selected>Nil</option>
									<option>20-30%</option>
									<option>31-40%</option>
									<option>41-50%</option>
									<option>51-60%</option>
									<option>61-70%</option>
									<option>>70%</option>
							
								</f:select>
					    	</div>
					    	<div class="form-group">
					      		<label for="o2Device" class="font-weight-bold">Oxygenation Device<span class="text-danger">*</span></label>
					      		<f:select class="form-control form-control-sm" id="o2Device" path="oxygenationDevice" placeholder="Select Ventilation Type">
									<option selected>Nasal Prongs</option>
									<option>Face Mask</option>
									<option>NRBM</option>
									<option>HFNC</option>
									<option>Ventilator</option>
								</f:select>
					    	</div>
					    	 <div class="form-group">
			      				<label for="ventilator" class="font-weight-bold">Need For Ventilator <span class="text-danger">*</span></label>
			      				<div>
				      				<div class="form-check-inline">
	    								<f:radiobutton class="form-check-input mx-2" name="ventilator" id="yVent" value="true" path="ventilationNeeded" /><span class="mx-2"> Yes</span> 
	    								<f:radiobutton class="form-check-input ml-4" name="ventilator" id="fVent" value="false" path="ventilationNeeded" /><span class="mx-2">No</span>
	    							</div>
    							</div>
			    			</div>	 
					    	
					    	<div class="form-group">
					      		<label for="ventilatorMode" class="font-weight-bold">Mode of Ventilator <span class="text-danger">*</span></label>
					      		<f:select class="form-control form-control-sm" id="ventilatorMode" path="modeOfVentilator" placeholder="Select Ventilation Mode">
									<option selected>NIV</option>
									<option>Control Mode</option>
									<option>CPAP</option>
									<option>BIPAP</option>
								</f:select>
					    	</div>
					    	
					    	 <div class="form-group">
			      				<label for="Gender" class="font-weight-bold">Need For Proning <span class="text-danger">*</span></label>
			      				<div>
				      				<div class="form-check-inline">
	    								<f:radiobutton class="form-check-input mx-2" name="proning" id="mProning" value="true" path="proning" /><span class="mx-2"> Yes</span> 
	    								<f:radiobutton class="form-check-input ml-4" name="proning" id="nProning" value="false" path="proning" /><span class="mx-2">No</span>
	    							</div>
    							</div>
			    			</div>	    
				    	</div>
				    </div>
			    </div>
    		</div>
		</div>
		<div class="col-md-6 mr-auto">
			<div class="card text-white bg-primary px-3 mb-3 mr-auto" style="max-width: 36rem;">
  			<div class="card-header">Important Details</div>
  				<div class="card-body">
  					<div class="row">
  						<div class="col-md-6">
					    	<div class="form-group">
					      		<label for="dDimer" class="font-weight-bold">Current D-Dimer <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="dDimer" placeholder="D Dimer" path="dDimer"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="xRay" class="font-weight-bold">Latest Chest X-Ray <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="xRay" placeholder="Latest XRay" path="chestXRay"/>
					    	</div>
			    	</div>
			    	<div class="col-md-6">
				    	<div class="form-group">
				      		<label for="medicine" class="font-weight-bold">Principal Medicine <span class="text-danger">*</span></label>
				      		<f:input class="form-control form-control-sm" id="medicine" placeholder="Medicine Given" path="principalMedicineGiven"/>
				    	</div>
				    	
				    	<div class="form-group">
				      		<label for="investigation" class="font-weight-bold">Important Investigation (Last 24 hrs) <span class="text-danger">*</span></label>
				      		<f:input class="form-control form-control-sm" id="investigation" placeholder="Last 24 hrs reports comments" path="investigationAndReports"/>
				    	</div>
				    	
				    	 <div class="form-group">
			      				<label for="treatmentChange" class="font-weight-bold">Change In Treatment (Last 24 hrs) <span class="text-danger">*</span></label>
			      				<div>
				      				<div class="form-check-inline">
	    								<f:radiobutton class="form-check-input mx-2" name="treatmentChange" id="tTreatmentChange" value="true" path="changeInTreatment" /><span class="mx-2"> Yes</span> 
	    								<f:radiobutton class="form-check-input ml-4" name="treatmentChange" id="fTreatmentChange" value="false" path="changeInTreatment" /><span class="mx-2">No</span>
	    							</div>
    							</div>
			    		</div>	    
				    	<div class="form-group">
				      		<label for="reason" class="font-weight-bold">Reason Of Change <span class="text-danger">*</span></label>
				      		<f:input class="form-control form-control-sm" id="reason" placeholder="Reason Of Change" path="reasonOfChange"/>
				    	</div>
				    	<div class="form-group">
				      		<label for="plasma" class="font-weight-bold">Plasma Therapy <span class="text-danger">*</span></label>
				      		<f:select class="form-control form-control-sm" id="plasma" path="plasmaTherapy">
								<option selected>Not Needed</option>
								<option>Given</option>
								<option>Planned</option>
							</f:select>
				    	</div>
				    	<div class="form-group">
				      		<label for="condition" class="font-weight-bold">Patient Condition <span class="text-danger">*</span></label>
				      		<f:select class="form-control form-control-sm" id="condition" path="patientCondition">
								<option selected>Stable</option>
								<option>Stable Possibility of Deterioration</option>
								<option>Dete</option>
								<option>Guarded</option>
							</f:select>
				    	</div>
				    	<div class="form-group">
				      		<label for="assessment" class="font-weight-bold">Current Assessment <span class="text-danger">*</span></label>
				      		<f:select class="form-control form-control-sm" id="assessment" path="currentAssessment">
								<option selected>Stable</option>
								<option>Stable, possibility of Deterioration</option>
								<option>Deteriorating</option>
								<option>Critical</option>
							</f:select>
				    	</div>
				    </div>
    			</div>
    		</div>
		</div>
	</div>
	</div>
			    
	<input type="submit" class="btn btn-small btn-secondary btn-block w-75 mx-auto" value="Save Report"/>
	<input type="hidden" id="role" value="${role}" />
	</f:form>
	</div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<!--  <script src="${pageContext.request.contextPath}/static_resources/js/header_manipulate.js"></script>-->
	<script>
		$(document).ready(
			function(){
				$("#name").attr("required","true");
				$("#phone").attr("required","true");
				$("#gender").attr("required","true");
				$("#address").attr("required","true");
			}
		).ready(e => {
			$("#home_icon").hover( e => {
				$("#home_icon").css({"cursor":"pointer"})
			});

			$("#home_icon").click( e =>{
				window.location.href = "admin_panel";
			});
			$("#logout").hide();
			}
		);
		
		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report Card</p></div>");
				$("#form_title").removeClass("m-3");	
				//$("#farewell_note").removeClass("display-4").addClass("display-5");
			}
		})
		// on registration focus out get employee details through ajax call 
		$("#registration").focusout( e =>{
			$.ajax({
				type: "POST",
				url : "${home}patient_details",
				data : {"reg_no":$("#registration").val()},
				success: function(result, status, xhr){
					if(result != null && result != ""){
						let json = JSON.parse(result);
						console.log(json.name)
						$("#name").attr("disabled","true");
						$("#phone").attr("disabled","true");
						$("#fgender").attr("disabled","true");
						$("#mgender").attr("disabled","true");

						$("#name").val(json.name);
						$("#phone").val(json.phone);
						$("#reg_no").val(json.reg_no);
						let gender = json.gender;
						if(gender == 'm'){
							$("#mgender").prop("checked",true);
							
						}
						else{
							$("#fgender").prop("checked",true);
						}
					}
					else{
						$("#name").attr("disabled",false);
						$("#phone").attr("disabled",false);
						$("#fgender").attr("disabled",false);
						$("#mgender").attr("disabled",false);
					}
				},
				error : function(result,status,xhr){
					$("#name").attr("disabled","false");
					$("#phone").attr("disabled","false");
					$("#fgender").attr("disabled","false");
					$("#mgender").attr("disabled","false");
				}
			});
		});
	</script>
</body>
</html>