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
		<div class="card bg-light my-3 mx-auto" style="max-width: 25rem">
  				<div class="card-header font-weight-light" style="font-size:25px" ><strong>Patient Vital Details</strong></div>
  				<div class="card-body">
  				<form method="POST" action="report">
    				<h5 class="card-title">Registration No</h5>
    				<input type="text" class="form-control form-control-sm card-text" id="registration" placeholder="Registration Number" name="regNo" title="Valid Number"/>
    				<input type="submit" class="btn btn-sm btn-secondary btn-block mx-auto mt-3" value="Get Report"/>
    			</form>
  			</div>
		</div>
	</div>
		
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script> 
	<%-- <script src="${pageContext.request.contextPath}/static_resources/js/header_manipulate.js"></script> --%>
	<script>
		$(document).ready(
			function(){
				$("#name").attr("required","true");
				$("#phone").attr("required","true");
				$("#gender").attr("required","true");
				$("#address").attr("required","true");
				// set value of parameter
				$("#name1").val($("#name_val").val());
				$("#name1").attr("readonly",true);
				$("#registration").val($("#reg_no").val());
				$("#phone1").val($("#phone_no").val());
				$("#phone1").attr("readonly",true);

				// hover effect
				$("#home_icon").hover( e => {
					$("#home_icon").css({"cursor":"pointer"})
				});

				$("#home_icon").click( e =>{
					window.location.href = "admin_panel";
				});
				// hide button
				$("#logout").hide();
			}
		);
		
		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report (Last 5 Records)</p></div>");
				$("#form_title").removeClass("m-3");	
			}
		})
	</script>
</body>
</html>