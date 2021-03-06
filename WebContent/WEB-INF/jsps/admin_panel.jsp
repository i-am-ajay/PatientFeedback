<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Data Panel</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resource/css/style.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/bootstrap_min.css" >

<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<%@ include file = "admin_panel_header.jsp" %>
	<div class="container mt-4">
	<div class="row mt-3">
		<div class="col-sm-12 col-md-3">
			<div class="card bg-light my-1 py-1" id="feedback">
			<article class="card-body mx-auto">
				<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Demographic </br> Details</h4>
				<p class="text-center mt-3"><i class="fa fa-comments-o fa-2x" aria-hidden="true"></i></p>	
			</article>
			</div>
		</div>
		<div class=" col-sm-12 col-md-3">
			<div class="card bg-light my-1 py-1" id="vitals">
			<article class="card-body mx-auto">
				<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Record<br/> Input</h4>
				<p class="text-center mt-3"><i class="fa fa fa-pencil-square-o fa-2x" aria-hidden="true"></i></p>
			</article>
			</div>
		</div>
		<div class=" col-sm-12 col-md-3">
			<div class="card bg-light my-1 py-1" id="report">
			<article class="card-body mx-auto">
				<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Patient </br> Report</h4>
				<p class="text-center mt-3"><i class="fa fa-file-text-o fa-2x" aria-hidden="true"></i></p>
			</article>
			</div>
		</div>
		
		<div class=" col-sm-12 col-md-3">
			<div class="card bg-light my-1 py-1" id="investigation">
			<article class="card-body mx-auto">
				<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Patient </br> Investigations</h4>
				<p class="text-center mt-3"><i class="fa fa-file-text-o fa-2x" aria-hidden="true"></i></p>
			</article>
			</div>
		</div>
	</div>
	
	<div class="row mt-3">
		<c:if test="${role.equalsIgnoreCase('admin')}">
			<div class="col-sm-12 col-md-3">
				<div class="card bg-light my-1 py-1" id="signup">
				<article class="card-body mx-auto">
					<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Register/<br/>Update User</h4>
					<p class="text-center mt-3"><i class="fa fa-user-plus fa-2x" aria-hidden="true"></i></p>	
				</article>
				</div>
			</div>
			<c:if test="false">
			<div class="col-sm-12 col-md-3">
				<div class="card bg-light my-1 py-1" id="analysis">
				<article class="card-body mx-auto">
					<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Data For Upload</h4>
					<p class="text-center mt-3"><i class="fa fa-comments-o fa-2x" aria-hidden="true"></i></p>	
				</article>
				</div>
			</div>
			</c:if>
			</c:if>
			<c:if test="${role.equalsIgnoreCase('user') }">
			<div class="col-sm-12 col-md-3">
				<div class="card bg-light my-1 py-1" id="password_change">
				<article class="card-body mx-auto">
					<h4 class="card-title text-center display-5 border-bottom border-danger my-2">Change/<br/>Password</h4>
					<p class="text-center mt-3"><i class="fa fa-user-plus fa-2x" aria-hidden="true"></i></p>	
				</article>
				</div>
			</div>
			</c:if>
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
		$("#feedback").click(function(e) {
			//$("#hidden_form").submit();
			window.location.href ="home";
		});
		
		// go to graphs
		$("#report").click( e=>{
			window.location.href ="report_panel";
		});
		// go to feedback
		$("#vitals").click( e=>{
			window.location.href ="patient_master";
		});

		$("#duration").click( e=>{
			window.location.href ="start_feedback";
		});

		$("#analysis").click(e => {
			window.location.href="patient_comcare";
		});

		$("#password_change").click(e =>{
			window.location.href="change_password";
		})

		$("#signup").click(e => {
			window.location.href="signup";
		});

		$("#investigation").click(e => {
			window.open("http://14.98.64.51/kiosklabresult/Login.aspx","_blank");
		});

		$(document).ready( e=>{
			$("#home_icon").hide();
		});

		

		// Changes the page heading for mobile screen and tablets.
		/* $(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#header_div").replaceWith("<h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6>" +
						"<p class='text-center'>Patient Data Portal</p>");
				$("#form_title").removeClass("m-3");
				
				//$("#farewell_note").removeClass("display-4").addClass("display-5");
			}
		}) */
		
		$(document).ready( e => {
				const screenSize = window.screen.width;
				if(screenSize < 1000){
					$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report Card</p></div>");
					$("#form_title").removeClass("m-3");	
				}
			});
	</script>
</body>
</html>