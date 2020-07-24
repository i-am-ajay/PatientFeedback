<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Report</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body class=mt-1>
	<%@ include file = "header_health_report.jsp" %>
	<div class="container p-2 m-auto">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Details</h4>
		<form method="POST" action="report">
		  <div class="form-row">
			    <div class="form-group col-md-4">
			      <label for="patientName" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <input type="text" class="form-control form-control-sm" id="name" placeholder="Patient Name" path="patientMaster.name"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <input type="text" class="form-control form-control-sm" id="registration" placeholder="Registration Number" path="patientMaster.registrationNumber" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label>
			      <f:input type class="form-control form-control-sm" id="phone" placeholder="Mobile Number" path="patientMaster.mobileNo" title="Valid Number"/>
			    </div>  
			    <div col-md-3>
			    	<input type="submit" class="btn btn-small btn-secondary btn-block w-75 mx-auto" value="Save Report"/>
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