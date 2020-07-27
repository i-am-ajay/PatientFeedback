<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Details</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body class=mt-1>
	<%@ include file = "header.jsp" %>
	<div class="container p-2 m-auto">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Details</h4>
		<f:form method="POST" modelAttribute="patient" action="feedback">
		  <div class="form-row">
		  		 <div class="form-group col-md-3">
			      <label for="patientName" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="name" placeholder="Patient Name" path="name"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="regNo" class="font-weight-bold">Registration No<span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="regNo" placeholder="Registration No" path="regNo"/>
			    </div>
			    <div class="form-group col-md-3">
			      <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="phone" placeholder="Phone Number" path="phoneNo" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-3">
			      	<label for="Gender" class="font-weight-bold">Gender <span class="text-danger">*</span></label>
			      	<div>
			      		<div class="form-check-inline">
    						<f:radiobutton class="form-check-input mx-2" name="gender" id="gender" value="m" path="gender" /><span class="mx-2"> Male</span> 
    						<f:radiobutton class="form-check-input ml-4" name="gender" id="gender" value="f" path="gender" /><span class="mx-2">Female</span>
    					</div>
    				</div>
			    </div>
		   </div>
		  
		<div class="form-row">
			<div class="form-group col">
			      <label for="address" class="font-weight-bold">Address <span class="text-danger">*</span></label>
			      <f:input class="form-control form-control-sm" id="address" placeholder="Address" path="address"/>
			</div>
		</div>
		  <!-- <!-- Alert
		  <div class="alert alert-danger alert-dismissible fade" role="alert" id="alert_id">
  			<span id="text">Replaceable Text</span>
  			 <button type="button" id="alert_" class="close" data-dismiss="alert" aria-label="Close">
    			<span aria-hidden="true">&times;</span>
  			</button>
		  </div> -->
		   <input type="submit" class="btn btn-small btn-secondary btn-block" value="Start Feedback"/>
		   <input type="hidden" id="role" value="${role}" />
		</f:form>
		
		<!-- <div class="mt-3">
			<p class="text-center"><i id="home_icon" class="fa fa-home fa-2x" aria-hidden="true"></i></p>
		</div> -->
		<div class="card mt-5">
	  		<div class="card-header">
	    		<strong>Important</strong>
	  		</div>
	  		<div class="card-body">
	    	<h5 class="card-title">Plasma Donation could give someone a chance to live.</h5>
	    		<p class="card-text">
	    			<ol>
	    				<li class="text-success font-weight-bold">Plasma Donation is completely safe and dosen't cause weakness.</li>
	    				<li class="text-danger font-weight-bold">If you are a Woman and you are Pregnant or have children or you have ever had abortion you can't donate the plasma. </li>
	    			</ol>
	    		</p>
	  		</div>
		</div>
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
				$("#regNo").attr("required","true");

				// hide button
				$("#home_icon").hide();
				$("#logout").hide();

				// hover effect
				$("#home_icon").hover( e => {
					//$("#home_icon").css({"cursor":"pointer"})
				})
				
				// link to admin_panel
				$("#home_icon").click( e =>{
					//window.location.href = "admin_panel";
				});
			}
		);
		
		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Feedback.</p></div>");
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