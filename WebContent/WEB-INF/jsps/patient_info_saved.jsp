<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<%@ page import="com.ajay.others.QuestionBank" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient Status Saved</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
	<%@ include file = "header_health_report_card.jsp" %>
	<div class="bg-light m-2 border-secondary mt-5">
		<div id="farewell_note" class="m-3 mt-2 pb-2 display-4"><strong class="">Dear User!</strong> Patient Health information of ${date} stored into the system on ${time}.</div>
	<!--<div class="text-center">
		<!-- <h6 class="m-3 mt-1 pb-2 text-primary">We wish you a good health!</h6>
	</div>-->
	</div>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<!--  <script src="${pageContext.request.contextPath}/static_resources/js/header_manipulate.js"></script> -->
	<script>
	$(document).ready( e => {
		const screenSize = window.screen.width;
		if(screenSize < 1000){
			$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report.</p></div>");
			$("#form_title").removeClass("m-3");
			$("#farewell_note").removeClass("display-4");
			$("#farewell_note").addClass("display-5");
		}
	})
		$("#home_icon").click( e =>{
			window.location.href = "patient_master";
		});

		$("#home_icon").hover( e => {
			$("#home_icon").css({"cursor":"pointer"})
		})
		
		$("#report").hover( e => {
			$("#report").css({"cursor":"pointer"})
		})
		
		$(document).ready( e => {
			$("#report").click(e=>{
				window.location.href = "patientmaster_report";
			});
		}
		);		
	</script>
</body>
</html>