<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Report Panel</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/style.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/bootstrap_min.css" >

<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file = "report_panel_header.jsp" %>
	<div class="container mt-4">
	<div class="row mt-3">
		<div class="col-sm-12 col-md-4">
			<div class="card bg-light my-1 py-1" id="feedback_report">
			<article class="card-body mx-auto">
				<h5 class="card-title text-center display-4 border-bottom border-danger py-2 my-2">Feedback Report</h5>
				<p class="text-center mt-3"><i class="fa fa-comments-o fa-3x" aria-hidden="true"></i></p>	
			</article>
			</div>
		</div>
		<div class=" col-sm-12 col-md-4">
			<div class="card bg-light my-1 py-1" id="vitals_report">
			<article class="card-body mx-auto">
				<h5 class="card-title text-center display-4 border-bottom border-danger py-2 my-2">Vital<br/> Reports</h5>
				<p class="text-center mt-3"><i class="fa fa fa-pencil-square-o fa-3x" aria-hidden="true"></i></p>
			</article>
			</div>
		</div>
		<div class=" col-sm-12 col-md-4">
			<div class="card bg-light my-1 py-1" id="5_day_analysis">
			<article class="card-body mx-auto">
				<h5 class="card-title text-center display-4 border-bottom border-danger py-2 my-2">Last 5 Records</h5>
				<p class="text-center mt-3"><i class="fa fa-file-text-o fa-3x" aria-hidden="true"></i></p>
			</article>
			</div>
		</div>
	</div>
	<div class="row mt-3">
			<div class="col-sm-12 col-md-4">
			<div class="card bg-light my-1 py-1" id="data">
			<article class="card-body mx-auto">
				<h4 class="card-title text-center display-4 border-bottom border-danger py-2 my-2">Data Upload Report</h4>
				<p class="text-center mt-3"><i class="fa fa-comments-o fa-3x" aria-hidden="true"></i></p>	
			</article>
			</div>
		</div>
		</div>
	</div> 
	
	<form id="hidden_form" action="home" method="POST">
		<input type="hidden" name="page" value="admin" />
	</form>
	
	
	<!--container end.//-->
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script>
		$(".card").hover(e => {
			$(".card").css({'cursor':'pointer'});
		});

		// go to create user
		$("#feedback_report").click(function(e) {
			window.location.href ="feedback_report"
		});
		
		// go to feedback
		$("#vitals_report").click( e=>{
			window.location.href ="patientmaster_report";
		});

		$("#5_day_analysis").click( e=>{
			window.location.href ="data_search";
		});

		$("#data").click( e=>{
			window.location.href ="comcare_report";
		})


		$("#home_icon").hover( e=>{
			$("#home_icon").css({"cursor":"pointer"});
		});

		$("#home_icon").click(e =>{
			window.location.href = "admin_panel"
		});

		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#header_div").replaceWith("<h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6>" +
						"<p class='text-center'>Patient Data Portal</p>");
				$("#form_title").removeClass("m-3");
				
				//$("#farewell_note").removeClass("display-4").addClass("display-5");
			}
		})
	</script>
</body>
</html>