<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Data Report</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body class=mt-1>
	<%@ include file = "header_health_report_card.jsp" %>
	<div class="container p-2 m-auto">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Data Report</h4>
		<f:form method="POST" modelAttribute="patientComcare" action="comcare_save">
		  <div class="form-row">
		  	 <div class="form-group col-md-2">
			      <label for="registration" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="registration" placeholder="Registration Number" path="patientDetails.registrationNumber" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="icmr" class="font-weight-bold">ICMR ID</label>
			      	<f:input class="form-control form-control-sm" id="icmr" placeholder="ICMR ID" path="patientDetails.icmrId" title="ICMR ID"/>
			    </div>	
			    <div class="form-group col-md-2">
			      	<label for="srf" class="font-weight-bold">SRF ID</label>
			      	<f:input class="form-control form-control-sm" id="srf" placeholder="SRF ID" path="srfId" title="SRF ID"/>
			    </div>	
			    <div class="form-group col-md-4">
			      <label for="name" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="name" placeholder="Patient Name" path="patientDetails.name"/>
			    </div>
			   
			    <div class="form-group col-md-2">
			      <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="phone" placeholder="Mobile Number" path="patientDetails.mobileNo" title="Valid Number"/>
			    </div>
			    
		   </div> 
		  <div class="form-row">
		  <div class="form-group col-md-2">
			      	<label for="gender" class="font-weight-bold">Gender <span class="text-danger">*</span></label>
			      	<div>
			      		<div class="form-check-inline">
    						<f:radiobutton class="form-check-input mx-2" name="gender" id="mgender" value="m" path="patientDetails.gender" /><span class="mx-2"> M</span> 
    						<f:radiobutton class="form-check-input ml-4" name="gender" id="fgender" value="f" path="patientDetails.gender" /><span class="mx-2">F</span>
    					</div>
    				</div>
			    </div>   
			    <div class="form-group col-md-2">
			      	<label for="age" class="font-weight-bold">Age <small>(years)</small></label>
			      	<f:input class="form-control form-control-sm" id="age" path="patientDetails.age" placeholder="Patient Age" />
			    </div>
			   
			    <div class="form-group col-md-2">
			      <label for="pincode" class="font-weight-bold">Pin Code <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="pincode" placeholder="Enter Pincode" path="patientDetails.pincode" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-4">
			      <label for="address" class="font-weight-bold">Address<span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="address_" placeholder="Patient Address" path="patientDetails.address" title="Valid Number"/>
			    </div>
			    
		   </div>
		   
		   <!-- Patient Vitals -->
		   <!--  <h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Report Card</h4>-->
		   <!-- Card Vitals -->
		   <div class="row border-top pt-2">
		   <div class="col">
		   <div class="card text-dark bg-light px-3 mb-3 w-75" >
  				<div class="card-header mt-1">Patient Analysis</div>
  				<div class="card-body">
  					<div class="row">
  						<div class="col-md-10">
  							<div class="form-check">
  								<label class="form-check-label font-weight-bold mb-3">
  									<f:checkbox id="repeat_test" class="form-check-input" path="repeatTest" /> Repeat Test
  								</label>
  							</div>
					    	<div class="form-group">
					      		<label id="test_label" class="font-weight-bold">First Test Result</label>
					      		<div>
				      				<div class=" form-check form-check-inline">
	    								<f:radiobutton class="form-check-input"  id="presult" value="positive" path="testResult" /><label class="form-check-label"> Positive</label>
	    							</div>
	    							<div class="form-check form-check-inline">
	    								<f:radiobutton class="form-check-input" id="preresult" value="presumptive" path="testResult" /><span class="form-check-label">Presumptive</span>
	    							</div>
	    							<div class="form-check form-check-inline">
	    								<f:radiobutton class="form-check-input" id="nresult" value="negative" path="testResult" /><span class="form-check-label">Negative</span>
	    							</div>
	    							<div class="form-check form-check-inline">
	    								<f:radiobutton class="form-check-input" id="nresult" value="inconclusive" path="testResult" /><span class="mx-2">Inconclusive</span>
	    							</div>
	    							<div class="form-check form-check-inline">
	    								<f:radiobutton class="form-check-input" id="nawaited" value="awaited" path="testResult" /><span class="mx-2">Awaited</span>
	    							</div>
    							</div>
					    	</div>
					    	<div class="form-group">
					      		<label id="collection_label" for="testDate" class="font-weight-bold">Test Sample Collection Date</label>
					      		<f:input type="date" id="testDate" class="form-control form-control-sm col-6 mx-2" path="testSampleCollectionDate" />
					    	</div>
					    	<div class="form-group">
					      		<label for="testDate" id="result_label" class="font-weight-bold">Covid Test Result Date</label>
					      		<f:input type="date" id="testDate" class="form-control form-control-sm col-6 mx-2" path="testResultDate" />
					    	</div>
					    	
					    	<div class="form-group">
					    		<div>
					      			<label class="font-weight-bold">Tested In</label>
					      		</div>
					      		<div class="form-check-inline py-1">
	    								<f:radiobutton class="form-check-input mx-2"  id="slocation" value="SGRH" path="testSite" /><span class="mx-2"> SGRH</span>
	    								<f:radiobutton class="form-check-input ml-4" id="olocation" value="Outside" path="testSite" /><span class="mx-2">Outside</span>
	    							</div>
					    	</div>
					    	<div class="form-group">
					      		<label for="lab_name" class="font-weight-bold">Lab Name</label>
					      		<f:input id="lab_name" class="form-control form-control-sm col-6 mx-2" path="labName" />
					    	</div>
					    	<div class="form-group">
					      		<label for="lab_code" class="font-weight-bold">Lab Code</label>
					      		<f:input id="lab_code" class="form-control form-control-sm col-6 mx-2" path="labCode" />
					    	</div>
					    	<div class="form-group">
					      		<label for="pCondition" class="font-weight-bold">Patient Condition</label>
					      		<f:select class="form-control form-control-sm col-6 mx-2" id="pCondition" path="patientCondition" placeholder="Patient Condition">
									<option selected>Asymptomatic</option>
									<option>Mild</option>
									<option>Severe</option>
									<option>In-ward without Oxygen</option>
									<option>In-ward with Oxygen</option>
									<option>ICU without Ventilator</option>
									<option>ICU with Ventilator</option>
								</f:select>
					    	</div>
					    	<div class="form-group">
					      		<label for="p_admission_status" class="font-weight-bold">Patient Admission Status</label>
					      		<f:select class="form-control form-control-sm col-6 mx-2" id="p_admission_status" path="admissionStatus" placeholder="Patient Admission Status">
									<option selected>Admitted</option>
									<option>Home Isolation</option>
									<option>Recovered</option>
									<option>Discharged</option>
									<option>Dead</option>
								</f:select>
					    	</div>
					    	
					    	<div class="form-group">
					      		<label for="admissionDate" class="font-weight-bold">Patient Admission Date</label>
					      		<f:input type="date" id="admissionDate" class="form-control form-control-sm col-6 mx-2" path="admissionDate" />
					    	</div>
					    	<div class="form-group">
					      		<label for="transffered_from" class="font-weight-bold">Patient Transfered From</label>
					      		<f:input id="transffered_from" class="form-control form-control-sm col-6 mx-2" path="transferedFrom" />
					    	</div>
					    	<!-- Symptoms -->
					    	<div>
					      		<label for="comorbidities" class="font-weight-bold">Patient Comorbidities</label>
									<div class="form-check">
					      				<f:checkbox class="form-check-input mr-3 ml-1" id="comorbidities" path="patientComorbidities" value="Pregnancy"/><label class="ml-4 px-2">Pregnancy</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Obesity"/><label class="ml-4 px-2">Obesity</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Cancer"/><label class="ml-4 px-2">Cancer</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Diabetes"/><label class="ml-4 px-2">Diabetes</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="HIV or Other immunodeficiency"/><label class="ml-4 px-2">HIV or Other immunodeficiency</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Heart Disease"/><label class="ml-4 px-2">Heart Disease</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Asthma"/><label class="ml-4 px-2">Asthma</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Chronic Lung Disease"/><label class="ml-4 px-2">Chronic Lung Disease</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Chronic Liver Disease"/><label class="ml-4 px-2">Chronic Liver Disease</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Chronic Neurological Impariment"/><label class="ml-4 px-2">Chronic Neurological Impariment</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Organ or Bone Marrow recipient"/><label class="ml-4 px-2">Organ or Bone Marrow recipient</label>
					      			</div>
					      			
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Loss of appetite"/><label class="ml-4 px-2">Loss of appetite</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="comorbidities" path="patientComorbidities" value="Dellirium"/><label class="ml-4 px-2">Dellirium</label>
					      			</div>
					      			<div class="form-check">
					      				<f:checkbox class="form-check-input mr-2 ml-1" id="o_comorbidities" path="patientComorbidities" value="Reduced Mobility"/><label class="ml-4 px-2">Other Co-morbidities</label>
					      			</div>
					      			<div class="from-group">
					      				<f:input class="form-control form-control-sm col-6 mx-2 ml-5 disabled" id="o_com_text" placeholder="Other Comorbidities" path="patientComorbidities" />
					      			</div>
					    	</div>
				    </div>
			  </div>
			  </div>
			  </div>
	</div>
	</div>
			    
	<input type="submit" class="btn btn-small btn-secondary btn-block w-75" value="Save Analysis"/>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
	<script>
		$(document).ready(
			function(){
				$("#name").attr("required","true");
				$("#phone").attr("required","true");
				$("#gender").attr("required","true");
				$("#address_").attr("required","true");
				$("#registration").attr("required","true");
				$("#dob").attr("required","true");	
				$("#o_com_text").attr("disabled",true);	
			});
		$(document).ready(e => {
			$("#home_icon").hover( e => {
				$("#home_icon").css({"cursor":"pointer"})
			});
			$("#report").hover( e => {
				$("#home_icon").css({"cursor":"pointer"})
			});

			$("#home_icon").click( e =>{
				window.location.href = "admin_panel";
			});
			$("#report").click(e =>{
				window.location.href = "comcare_report";
			});
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
		});

		// when other co-morbidities selected.
		
		$("#o_comorbidities").click( e=>{
			if($("#o_comorbidities").prop("checked") === true){
				$("#o_com_text").attr("disabled",false);
			}
			else{
				$("#o_com_text").attr("disabled",true);
			}
		})
		
		// set value of o_com_text into other comorbidities values on focus out.
		$("#o_com_text").focusout(e =>{
			$("#o_comorbidities").val($("#o_com_text").val());
		})
		
		// on registration focus out get employee details through ajax call 
		function ajax_call(param, data,type_param){
			$.ajax({
				type: "POST",
				url : "${home}fetch_patient_details",
				data : {param:data,"type":type_param},
				success: function(result, status, xhr){
					if(result != null && result != ""){
						let json = JSON.parse(result);
						console.log(json);
						$("#name").val(json.name);
						$("#phone").val(json.mobile);
						$("#registration").val(json.reg);
						$("#icmr").val(json.icmrId);
						$("#age").val(json['age']);
						$("#address_").val(json.address);
						$("#pincode").val(json.pincode);
						
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
					$("#name").attr("disabled",false);
					$("#phone").attr("disabled",false);
					$("#fgender").attr("disabled",false);
					$("#mgender").attr("disabled",false);
				}
			});
		};

		// function call on focus out
		$("#registration").focusout( e =>{
			let val = $("#registration").val();
			ajax_call("reg_no",val,"reg");
		});

		// on  icmr  
		$("#icmr").focusout(e =>{
			let val = $("#icmr").val();
			ajax_call("icmr_id",val,"icmr");
			/* if(!$("#registration").val()){
				ajax_call("icmr_id",val,"icmr");
			} */
		});

		// on date focus out
		$("#dob").focusout(e => {
			calculate_age($("#dob").val());
		})
		/// calculate age
		function calculate_age(birth_date){
			let dob = moment(birth_date);
			let current_date = moment(Date.now());
			$("#age").val(current_date.diff(dob,'Years'));
		}
		// change labels on repeat test checkbox click.
		$("#repeat_test").click(e =>{
			if($("#repeat_test").prop("checked") == true){
				$("#test_label").text("Repeat Test Result");
			}
			else{
				$("#test_label").text("First Test Result");
			}
		});

		// enable or disable lab name and code
		$("#slocation").click(e => {
			if($("#slocation").prop("checked") == true){
				$("#lab_name").attr('disabled',true);
				$("#lab_code").attr('disabled',true);
			}
		});
		$("#olocation").click(e =>{
			if($("#olocation").prop("checked")==true){
				$("#lab_name").attr('disabled',false);
				$("#lab_code").attr('disabled',false);
			}
		});
		
	</script>
</body>
</html>