<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Daily Information Report</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style1.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
	<!-- <link rel="stylesheet" href="https://cdn.datatables.net/v/dt/dt-1.10.21/b-1.6.3/b-html5-1.6.3/fc-3.3.1/fh-3.1.7/datatables.min.css"/> -->
 
</head>
<body class=mt-1>
	<%@ include file = "../header_health_report_card.jsp" %>
	<div class="p-2 m-auto">
		<div class="container">
		<h6 class="border-bottom mx-1 text-muted pb-2" id="form_title">Patient Daily Information Report</h6>
		<div class="mt-3">
			<form action="patientmaster_report" method="POST">
			 <div class="form-row search">
		  	 <div class="form-group col-md-3">
			      <label for="registration" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="registration" placeholder="Registration Number" name="reg_no" title="Valid Number"/>
			    </div>
			     <div class="form-group col-md-3">
			      <label for="name" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="name" placeholder="Patient Name" name="p_name"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="icmr" class="font-weight-bold">Phone No</label>
			      	<input class="form-control form-control-sm" id="phone" placeholder="Phone No" name="phone_no" title="Phone No"/>
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
			    <input id="button" type="submit" class=" btn btn-secondary btn-sm btn-block w-50 mt-2 mx-auto text-center" value="search" />
			</form>
		</div>
		</div>
		<h6 class="border-bottom mb-1 text-muted pb-2" id="form_title"></h6>
		<div id="table">
			<table id="patientTable" class="display compact cell-border" style="width:100%">
	        	<thead>
	            	<tr>
	                	<th>Registration No</th>
		                <th>Name</th>
		                <th>Gender</th>
		                <th>Phone</th>
		                <!-- <th>Address</th>
		                <th>Blood Group</th>
		                <th>Donate Plasma</th>
		                <th>How was your experience?</th>
		                <th>How was the sanitation in the Hospital?</th>
		                <th>How was the Food?</th>
		                <th>How was the experience with the Doctors?</th>
		                <th>Existing Disease</th> -->
		                <th class="creation_date">Registration Date</th>
		            </tr>
	        	</thead>
	        	<tbody>
	        		<c:forEach var="patient" items="${patient_master}">
        			<tr class="py-2 text-justify">
        				<td class="px-2" class="reg_no"><a href="#" >${patient.registrationNumber}</a></td> <!-- creation_time -->
	        			<td class="px-2">${patient.name}</td>
	        			<td class="px-2">${patient.gender == "m" ? "Male" : "Female"}</td>
	        			<td class="px-2">${patient.mobileNo}</td>
	        			<%-- <td id="address">${feedback.patient.address}</td>
	        			<td class="ans">${feedback.bloodGroup}</td>
	        			<td class="ans">${feedback.donatePlasma}</td>
	        			<td class="ans">${feedback.choiceList[Integer.valueOf(1)].answer}</td>
	        			<td class="ans">${feedback.choiceList[Integer.valueOf(2)].answer}</td>
	        			<td class="ans">${feedback.choiceList[Integer.valueOf(3)].answer}</td>
	        			<td class="ans">${feedback.choiceList[Integer.valueOf(4)].answer}</td>
	        			<td id="disease">${feedback.getDisease()}</td> --%>
	        			<td class="px-2">${patient.creationDate}</td>
	        			</tr>
	        		</c:forEach>
	        	</tbody>
    		</table>
    		
    		<!-- Data Table Model -->
    		
    		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div id="modal" class="modal-dialog modal-xl" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h6 class="modal-title" id="exampleModalLabel">Modal title</h6>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			      <table id="example">
			      	<thead>
				        	<tr id="header">
			                	<th>BP</th>
				                <th>PR</th>
				                <th>Temp</th>
				                <th>Respiratory Rate</th>
				                <th>SpO2</th>
				                <th>O2 Supplementation</th>
				                <th>O2 Device</th>
				                <th>D-Dimer</th>
				                <th>X-Ray</th>
				                <th>Principal Medicine</th>
				                <th>Ventilation Needed</th>
				                <th>Need Of Proning</th>
				                <th>Investigation Comment</th>
				                <th>Change In Treatment</th>
				                <th>Reason Of Change</th>
				                <th>Current Asmt</th>
				                <th>Experimental Therapy</th>
				                <th>Any Comment</th>
			            	</tr>
			            </thead>
		            </table>
			      </div>
			    </div>
			  </div>
			</div>
    		
    		
    		
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
			table = $('#patientTable').DataTable( {
		        "scrollY": 300,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth" : false,
		        "dom": 'Bfrtip',
		        "buttons": [
		        	 {extend : 'copyHtml5', className : ' btn btn-sm px-4'}
		        ]
		        });
		});

		$(document).ready(function() {
			table = $('#example').DataTable( {
		        "scrollY": 300,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth" : false,
		        "dom": 'Bfrtip',
		        "fixedColumns": {
		            leftColumns: 1
		        },
		        "buttons": [
		        	 {extend : 'copyHtml5', className : ' btn btn-sm px-4'}
		        ]
		        });
		});

		// populate modal 
		$(".reg_no").click(e => {
			alert("modal");
				$.ajax({
					type: "POST",
					url : "${home}patient_modal_data",
					data : {"regNo":"12345"},
					success: function(result, status, xhr){
						let res = JSON.parse(result);
						console.log(res);
						let data_array = []
						if(res != null){
							res.forEach( (item,index) =>{
								temp = []
								temp.push(item.bp || 'NA')
								temp.push(item.pr);
								temp.push(item.temp);
								temp.push(item.respiratoryRate || 'NA');
								temp.push(item.spO2 || 'NA');
								temp.push(item.oxygenSuppl || 'NA');
								temp.push(item.oxygenationDevice || 'NA');
								temp.push(item.ddimer || 'NA');
								temp.push(item.chestXray || 'NA');
								temp.push(item.principlalMedicineGiven || 'NA');
								temp.push(item.ventilationNeeded || 'NA');
								temp.push(item.modeOfVentilator || 'NA');
								temp.push(item.proning || 'NA');
								temp.push(item.investigationReports || 'NA');
								temp.push(item.changeInTreatment || 'NA');
								temp.push(item.reasonOfChange || 'NA');
								temp.push(item.currentAssessment || 'NA');
								temp.push(item.experimentalTherapy || 'NA');
								temp.push(item.comment || 'NA');
								temp.push(item.creation_date || 'NA');
								temp.push(item.creation_time || 'NA');
								table.row.add(temp).draw(false).node().id = item.record_id;
								//data_array.push(temp);
							})
						}
				
				        
						table.draw();
					},
					error : function(result,status,xhr){
						$("#name").attr("disabled",false);
						$("#phone").attr("disabled",false);
						$("#fgender").attr("disabled",false);
						$("#mgender").attr("disabled",false);
					}
				});
			});
	
		// Changes the page heading for mobile screen and tablets.
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