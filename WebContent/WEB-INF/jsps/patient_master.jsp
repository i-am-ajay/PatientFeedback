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
	<%@ include file = "header_health_report.jsp" %>
	<div class="container p-2 m-auto">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Details</h4>
		<f:form method="POST" modelAttribute="patientInfo" action="save_report">
		  <div class="form-row">
			    <div class="form-group col-md-4">
			      <label for="patientName" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="name" placeholder="Patient Name" path="patientMaster.name"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="registration" placeholder="Registration Number" path="patientMaster.registrationNumber" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="phone" placeholder="Mobile Number" path="patientMaster.mobileNo" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="Gender" class="font-weight-bold">Gender <span class="text-danger">*</span></label>
			      	<div>
			      		<div class="form-check-inline">
    						<f:radiobutton class="form-check-input mx-2" name="gender" id="gender" value="m" path="patientMaster.gender" /><span class="mx-2"> Male</span> 
    						<f:radiobutton class="form-check-input ml-4" name="gender" id="gender" value="f" path="patientMaster.gender" /><span class="mx-2">Female</span>
    					</div>
    				</div>
			    </div>	    
		   </div>
		   
		   <!-- Patient Vitals -->
		   <h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Report Card</h4>
		   <!-- Card Vitals -->
		   <div class="row">
		   <div class="col-sm-6 col-md-6">
		   <div class="card text-white bg-success px-3 mb-3 ml-auto" style="max-width: 36rem;">
  				<div class="card-header">Patient Vitals</div>
  				<div class="card-body">
  					<div class="row">
  						<div class="col-sm-6">
		    				<div class="form-group">
					      		<label for="heartRate" class="font-weight-bold">Heart Rate <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="heartRate" placeholder="Heart Rate" path="heartRate"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="bloodPressure" class="font-weight-bold">Blood Pressure <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="bloodPressure" placeholder="Blood Pressure" path="bloodPressure"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="pulse" class="font-weight-bold">Pulse Rate <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="pulse" placeholder="Pulse Rate" path="pulseRate"/>
					    	</div>
				    	</div>
				    	<div class="col-sm-6">
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
				    	</div>
				    </div>
			    </div>
    		</div>
		</div>
		<div class="col-sm-6 col-md-6 mr-auto">
			<div class="card text-white bg-primary px-3 mb-3 mr-auto" style="max-width: 36rem;">
  			<div class="card-header">Important Details</div>
  				<div class="card-body">
  					<div class="row">
  						<div class="col-sm-6">
		    				<div class="form-group">
					      		<label for="ventilation" class="font-weight-bold">Ventilation<span class="text-danger">*</span></label>
					      		<f:select class="form-control form-control-sm" id="ventialation" path="ventilation" placeholder="Select Ventilation Type">
									<option selected>Room Air</option>
									<option>Oxygen Mask</option>
									<option>Spontaneous</option>
									<option>NIV</option>
									<option>Mechanical- Prone</option>
									<option>Mechanical- Supine</option>
							
								</f:select>
					    	</div>
					    	<div class="form-group">
					      		<label for="dDimer" class="font-weight-bold">Current D-Dimer <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="dDimer" placeholder="D Dimer" path="dDimer"/>
					    	</div>
					    	<div class="form-group">
					      		<label for="xRay" class="font-weight-bold">Latest Chest X-Ray <span class="text-danger">*</span></label>
					      		<f:input class="form-control form-control-sm" id="xRay" placeholder="Latest XRay" path="chestXRay"/>
					    	</div>
			    	</div>
			    	<div class="col-sm-6">
				    	<div class="form-group">
				      		<label for="medicine" class="font-weight-bold">Principal Medicine <span class="text-danger">*</span></label>
				      		<f:input class="form-control form-control-sm" id="medicine" placeholder="Medicine Given" path="principalMedicineGiven"/>
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
				      		<label for="assessment" class="font-weight-bold">Current Assessment <span class="text-danger">*</span></label>
				      		<f:select class="form-control form-control-sm" id="assessment" path="currentAssessment">
								<option selected>Unclear Yet</option>
								<option>Status Quo</option>
								<option>Improving</option>
								<option>Guarded</option>
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
				$("#home_icon").hide();
				$("#logout").hide();
			}
		);
		
		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 700){
				$("#header_div").replaceWith("<h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6>" +
						"<p class='text-center'>Patient Health Report</p>");
				$("#form_title").removeClass("m-3");
				
				//$("#farewell_note").removeClass("display-4").addClass("display-5");
			}
		})
		/*$('#phone_').on("focusout",function(e){
				const $reg = /GA[A,B]\d{4}$/;
				const emp = $('#empcode').val();
				const text = "Not a valid employee code."
				if(!emp.toUpperCase().match($reg)){
					$('#text').text(text);
					$("#department").val(null);
					$("#designation").val(null);
					$('#alert_id').addClass("show");
				}
				else{
					$('#alert_id').removeClass("show");
					$('#empcode').val(emp.toUpperCase());
					$.ajax({
						type: "POST",
						url: "${home}pisEmp",
						data: 'empCode='+this.value,
						success: function(result, status, xhr){
							if(result == null || result == ""){
								$('#text').text("Emp Code does not exists.");
								$('#alert_id').addClass("show");
								$("#department").val("");
								$("#designation").val("");
							}
							else{
								result=JSON.parse(result);
								$("#empcode").val(result.code);
								$("#department").val(result.dept);
								$("#designation").val(result.desig);
							}
						},
						error: function(result, status, xhr){
							
						}
					})
				}
			}
		});*/
		
	</script>
</body>
</html>