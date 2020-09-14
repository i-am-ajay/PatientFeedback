<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Feedback Report</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
	
</head>
<body class=mt-1>
	<%@ include file = "../header_health_report_card.jsp" %>
	<div class="p-2 m-auto container">
		<h6 class="border-bottom mx-1 text-muted pb-2" id="form_title">Patient Feedback Report</h6>
		<div class="mt-3">
			<form action="feedback_report" method="POST">
			 <div class="form-row search">
		  	 <div class="form-group col-md-2">
			      <label for="registration" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="registration" placeholder="Registration Number" name="reg_no" title="Valid Number"/>
			    </div>
			     <div class="form-group col-md-2">
			      <label for="name" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="name" placeholder="Patient Name" name="p_name"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="icmr" class="font-weight-bold">Phone No</label>
			      	<input class="form-control form-control-sm" id="phone" placeholder="Phone No" name="phone_no" title="Phone No"/>
			    </div>	
			    <div class="form-group col-md-2">
			      	<label for="srf" class="font-weight-bold">Address</label>
			      	<input class="form-control form-control-sm" id="address" placeholder="Address" name="address" title="Address"/>
			    </div>	
			    <div class="form-group col-md-2">
			      	<label for="f_date" class="font-weight-bold">From Date</label>
			      	<input type="date" class="form-control form-control-sm" id="fDate" name="f_date"/>
			    </div>	
			    <div class="form-group col-md-2">
			      	<label for="tDate" class="font-weight-bold">To Date</label>
			      	<input type="date" class="form-control form-control-sm" id="tDate" name="t_date" />
			    </div>	
			   </div>
			    <input id="button" type="submit" class=" btn btn-secondary btn-sm btn-block mt-2 ml-2" value="search" />
			</form>
		</div>
		<h6 class="border-bottom mb-1 text-muted pb-2" id="form_title"></h6>
		<div id="table">
			<table id="example" class="display compact" style="width:100%">
	        	<thead>
	            	<tr>
	                	<th>Registration No</th>
		                <th>Name</th>
		                <th>Gender</th>
		                <th>Phone</th>
		                <th>Address</th>
		                <th>Blood Group</th>
		                <th>Donate Plasma</th>
		                <th>How was your experience?</th>
		                <th>How was the sanitation in the Hospital?</th>
		                <th>How was the Food?</th>
		                <th>How was the experience with the Doctors?</th>
		                <th>Existing Disease</th>
		                <th>Feedback Date</th>
		            </tr>
	        	</thead>
	        	<tbody>
	        		<c:forEach var="patient" items="${patient_list}">
        			<tr>
        				<td>${patient.regNo}</td>
	        			<td>${patient.name}</td>
	        			<td>${patient.gender}</td>
	        			<td>${patient.phoneNo}</td>
	        			<td id="address">${patient.address}</td>
	        			<td>${patient.feedbackList[0].bloodGroup}</td>
	        			<td>${patient.feedbackList[0].donatePlasma}</td>
	        			<td>${patient.feedbackList[0].choiceList[Integer.valueOf(1)].answer}</td>
	        			<td>${patient.feedbackList[0].choiceList[Integer.valueOf(2)].answer}</td>
	        			<td>${patient.feedbackList[0].choiceList[Integer.valueOf(3)].answer}</td>
	        			<td>${patient.feedbackList[0].choiceList[Integer.valueOf(4)].answer}</td>
	        			<td></td>
	        			<td>${patient.feedbackList[0].creationDate}</td>
	        			</tr>
	        		</c:forEach>
	        	</tbody>
    		</table>
    		
		</div>
	</div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<!--  <script src="${pageContext.request.contextPath}/static_resources/js/header_manipulate.js"></script>-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.21/af-2.3.5/b-1.6.3/b-html5-1.6.3/datatables.min.js"></script>
	<script>
	var table = null;
		$(document).ready(function() {
			table = $('#example').DataTable( {
		        "scrollY": 230,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth" : false,
		        "dom": 'Bfrtip',
		        "buttons": [
		        	 {extend : 'copyHtml5', className : ' btn btn-sm px-4'}
		        ]
		        });
		});
		
		/// calculate age
		function calculate_age(birth_date){
			let dob = moment(birth_date);
			let current_date = moment(Date.now());
			$("#age").val(current_date.diff(dob,'Years'));
		}

		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report Card</p></div>");
				$("#form_title").removeClass("m-3");	
			}
		});

		// on update checkbox click
		function updateFunction(x){
			let id = x.id.replace("c_","#");
			let id_server = id.replace("#","");
			let icmr_id = "#"+x.id.replace("c_","i_");
			let srf_id = "#"+x.id.replace("c_","s_")
			
			// ajax call to update data in database.
			$.ajax({
				type: "POST",
				url : "${home}update_data",
				data : {"id":id_server , "icmr_id": $(icmr_id).val(), "srf_id":$(srf_id).val() }, //,  , "srf_Id": srf_id
				success: function(result, status, xhr){
					console.log(result);
					//table.draw();
				},
				error : function(result,status,xhr){
					$("#name").attr("disabled",false);
					$("#phone").attr("disabled",false);
					$("#fgender").attr("disabled",false);
					$("#mgender").attr("disabled",false);
				}
			});
			
			table.row(id).remove().draw();
		}
		
		$("input[type=checkbox]").click( e => {
			alert('hello');
			console.log(this);
		});
	</script>
	
	
 

	
</body>
</html>