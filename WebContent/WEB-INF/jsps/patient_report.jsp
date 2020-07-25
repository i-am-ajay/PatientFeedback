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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/table_style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css" />
</head>
<body class=mt-1>
	<%@ include file = "header_health_report.jsp" %>
	<div class="container p-2 m-auto">
		<!-- <h4 class="border-bottom my-1 mx-3 text-muted pb-2" id="form_title">Patient Details</h4> -->
		<form method="POST" action="report">
		  <div class="form-row">
			    <div class="form-group col-md-4">
			      <!-- <label for="patientName" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label> -->
			      <input type="text" class="form-control form-control-sm" id="name1" placeholder="Patient Name" name="name"/>
			    </div>
			    <div class="form-group col-md-3">
			      <!-- <label for="phone" class="font-weight-bold">Reg No <span class="text-danger">*</span></label> -->
			      <input type="text" class="form-control form-control-sm" id="registration" placeholder="Registration Number" name="regNo" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-3">
			      <!-- <label for="phone" class="font-weight-bold">Phone No <span class="text-danger">*</span></label> -->
			      <input type="text" class="form-control form-control-sm" id="phone1" placeholder="Mobile Number" name="phone" title="Valid Number"/>
			    </div>  
			    <div class="col-md-2">
			    <!-- <label for="phone" class="font-weight-bold"></label> -->
			    	<input type="submit" class="btn btn-sm btn-secondary btn-block w-75 mx-auto" value="Save Report"/>
			    </div>
		   </div>	    
	<input type="hidden" id="role" value="${role}" />
	</form>
	<!-- Data Table -->
	<div class="tbl-header">
		<!--  <table class="table" id="example" class="display compact" style="width:100%">-->
		<table cellpadding="0" cellspacing="0" border="0">
	        <thead>
	            <tr>
	                <th>Parameter</th>
	                <th>${data[12][0]}</th>
	                <th>${data[12][1]}</th>
	                <th>${data[12][2]}</th>
	                <th>${data[12][3]}</th>
	                <th>${data[12][4]}</th>
	            </tr>
	        </thead>
	       </table>
	       </div>
	      <div class="tbl-content">
    		<table cellpadding="0" cellspacing="0" border="0">
	        <tbody>
	        	<c:forEach items="${data}" end="11" var="val">
	        		<tr>
	                <th>${val[5]}</th>
	                <td>${val[0]}</td>
	                <td>${val[1]}</td>
	                <td>${val[2]}</td>
	                <td>${val[3]}</td>
	                <td>${val[4]}</td>
	            </tr>
	        	</c:forEach>
	           
	    	</tbody>
	    </table>
	    </div>
    </div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
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
		$(window).on("load resize ", function() {
			  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
			  $('.tbl-header').css({'padding-right':scrollWidth});
			}).resize();
	</script>
</body>
</html>