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
<title>Feedback Form</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
	<%@ include file = "header.jsp" %>
	<div class="container p-2 m-auto">
	<h4 id="form_heading" class="border-bottom m-3 text-muted pb-2">Patient Feedback: All questions are mandatory, do choose an answer before submission.</h4>
	<f:form method="POST" modelAttribute="patient" action="submit_form">
		<f:hidden path="patientNo" value="${patient.patientNo}"/>
		<f:hidden path="name" vlaue="${patient.name}" />
		<f:hidden path="phoneNo" value="${patient.phoneNo}" />
		<f:hidden path="feedbackList[0].id" value="${patient.feedbackList.get(patient.feedbackList.size()-1).id}" /> 
		<f:hidden path="feedbackList[0].id" value="${patient.feedbackList.get(0).id}" /> 
		
	<!-- <nav>
		<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
			<a class="nav-item nav-link active text-secondary" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Section 1</a>
			<a class="nav-item nav-link text-secondary" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Section 2</a>
		</div>
	</nav> -->
	<!-- Tabs -->
	
		<div class="">
			<c:forEach var="i" items="${patient.feedbackList.get(patient.feedbackList.size()-1).choiceList.keySet()}" varStatus="count">
				<div class="border-top border-dark p-3 mb-2">
					<c:set var="question" value="${QuestionBank.getInstance().getQuestion(i)}" />
					<blockquote class="blockquote small bg-light">${question.question}</blockquote>
					<c:forEach var="c" items="${question.choices}">
						<div class="form-check form-check-inline px-2 py-1">
							<label class="form-check-label font-weight-bold pr-2" for="radio${i}">${c}</label>
							<f:radiobutton class="form-check-input" id="radio${i}" name="${i}" path="feedbackList[${patient.feedbackList.size()-1}].choiceList[${i}].answer" value="${c}"/>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
		
		<div class="border-top border-dark p-3 mb-2">
			<blockquote class="blockquote small bg-light">Would you like to donate Plasma to save someone's life?</blockquote>
				<div class="form-check form-check-inline px-4 py-2">
					<label class="form-check-label font-weight-bold pr-2" for="pyes">Yes</label>
					<f:radiobutton class="form-check-input" id="pyes" path="feedbackList[${patient.feedbackList.size()-1}].donatePlasma" value="YES"/>
				</div>
				<div class="form-check form-check-inline px-4 py-2">
					<label class="form-check-label font-weight-bold pr-2" for="pno">No</label>
					<f:radiobutton class="form-check-input" id="pno" path="feedbackList[${patient.feedbackList.size()-1}].donatePlasma" value="NO"/>
				</div>
			<div class="form-check form-check-inline">
			</div>
		</div>
		
		<div class="border-top border-dark p-3 mb-2">
			<blockquote class="blockquote small bg-light">Blood Group</blockquote>
				<f:select class="form-control w-75" id="bloodgroup" path="feedbackList[${patient.feedbackList.size()-1}].bloodGroup" placeholder="Select Blood Group">
					<option>Select Your Blood Group</option>
					<option>A+</option>
					<option>A-</option>
					<option>B+</option>
					<option>B-</option>
					<option>O+</option>
					<option>O-</option>
					<option>AB+</option>
					<option>AB-</option>
					<option>NA</option>
				</f:select>
		</div>
		
		<div class="border-top border-dark p-3 mb-2">
			<blockquote class="blockquote small bg-light">Do you have any of the diseases?</blockquote>
				<div class="form-check form-check-inline col-sm-6 mb-sm-4 col-md-2">
					<label class="form-check-label font-weight-bold" for="no">
					<f:checkbox class="form-check-input" id="no" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="No"/>
					No Disease</label>
				</div>
				<div class="form-check form-check-inline col-sm-6 col-md-2">
					<label class="form-check-label font-weight-bold" for="diabetic">
					<f:checkbox class="form-check-input ed" id="diabetic" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="Diabetes"/>
					Diabetes</label>
				</div>
				<div class="form-check form-check-inline col-sm-6 col-md-2">
					<label class="form-check-label font-weight-bold" for="bp">
					<f:checkbox class="form-check-input ed" id="bp" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="High BP"/>
					High BP</label>
				</div>
				<%-- <div class="form-check form-check-inline col-sm-6 col-md-2">
					<label class="form-check-label font-weight-bold" for="sugar">
					<f:checkbox class="form-check-input ed" id="sugar" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="Sugar"/>
					Sugar</label>
				</div> --%>
				<div class="form-check form-check-inline col-sm-6 col-md-2">
					<label class="form-check-label font-weight-bold" for="liver">
					<f:checkbox class="form-check-input ed" id="liver" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="Liver Disease"/>
					Liver Disease</label>
				</div>
				<div class="form-check form-check-inline col-sm-6 col-md-3">
					<label class="form-check-label font-weight-bold" for="kidney">
					<f:checkbox class="form-check-input ed" id="kidney" path="feedbackList[${patient.feedbackList.size()-1}].existingDisease" value="Kidney Disease"/>
					Kidney Disease</label>
				</div>
		</div>
		<%-- <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
			<c:forEach var="i" items="${emp.feedbackList.get(emp.feedbackList.size()-1).choiceList.keySet()}" varStatus="count">
			<c:if test="${count.index>=13}">
				<div class="border-top border-dark p-3 mb-2">
					<c:set var="question" value="${QuestionBank.getInstance().getQuestion(i)}" />
					<blockquote class="blockquote small bg-light">${question.question}</blockquote>
					<c:forEach var="c" items="${question.choices}">
						<div class="form-check form-check-inline px-4 py-2">
							<label class="form-check-label font-weight-bold pr-2" for="radio${i}">${c}</label>
							<f:radiobutton class="form-check-input" id="radio${i}" name="${i}" path="feedbackList[${ emp.feedbackList.size()-1}].choiceList[${i}].answer" value="${c}"/>
						</div>
					</c:forEach>
				</div>	
			</c:if>	
			</c:forEach>
		</div> --%>
	<input class="btn btn-small btn-secondary btn-block" id="submit" type="submit" value="Submit Feedback"/>
	</f:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/header_manipulate.js"></script>
	<script>
		$("#submit").on("click",() =>{
			if($("#bloodgroup").val() == ("Select Your Blood Group")){
				$("#bloodgroup").val("");
			}
		});
		$(document).ready(function(){
			// code for select box
			$("#bloodgroup").attr("required","true");
			const firstElement = $("#no");
			const otherElements = $("input:checkbox:not(#no)");
			$("input:radio").prop("required",true);
			firstElement.prop("checked",true);	
			otherElements.click(
					() => {
						if((otherElements[0].checked === true) || (otherElements[1].checked === true) 
								|| (otherElements[2].checked === true) || (otherElements[3].checked === true)
								|| (otherElements[4].checked === true)){
							firstElement.prop("checked",false);
						}
						else{
							firstElement.prop("checked",true);
						}
						//$("input:checkbox:first").prop("checked",true);	
					}
			);
			firstElement.click(
					() => {
						if(firstElement.prop("checked") == true){
							otherElements[0].checked = false;
							otherElements[1].checked = false;
							otherElements[2].checked = false;
							otherElements[3].checked = false;
							otherElements[4].checked = false;
						}
						else{
							firstElement.prop("checked",true);
						}
						//$("input:checkbox:first").prop("checked",true);	
					}	
			)
			
		});
		
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#header_div").replaceWith("<h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6>" +
						"<p class='text-center'>Patient Feedback.</p>");
				$("#form_title").removeClass("m-3");

				$("#form_heading").addClass("display-5");
				
				//$("#farewell_note").removeClass("display-4").addClass("display-5");
			}
		})		
	</script>
</body>
</html>