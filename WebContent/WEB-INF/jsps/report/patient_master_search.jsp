<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient Daily Information Report</title>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/bootstrap_min.css" >
	<!--  <link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/datatable_min.css" >-->
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
	<!--
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<!-- <link rel="stylesheet" href="https://cdn.datatables.net/v/dt/dt-1.10.21/b-1.6.3/b-html5-1.6.3/fc-3.3.1/fh-3.1.7/datatables.min.css"/> -->
</head>
<body class=mt-1>
	<%@ include file = "../header_health_report_card.jsp" %>
	<div class="p-2 m-auto">
		<div id="search_div" class="container">
		<h6 class="border-bottom mx-1 text-muted pb-2" id="form_title">Patient Daily Information Report</h6>
		<div class="mt-3">
			<form action="patientmaster_report" method="POST">
			 <div class="form-row search">
		  	 <div class="form-group col-sm-4 col-md-3">
			      <label for="registration" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="registration" placeholder="Registration Number" name="reg_no" title="Valid Number"/>
			    </div>
			     <div class="form-group col-sm-4 col-md-3">
			      <label for="name" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="name" placeholder="Patient Name" name="p_name"/>
			    </div>
			    <div class="form-group col-sm-4 col-md-2">
			      	<label for="icmr" class="font-weight-bold">Phone No</label>
			      	<input class="form-control form-control-sm" id="phone" placeholder="Phone No" name="phone_no" title="Phone No"/>
			    </div>	
	
			    <div class="form-group col-sx-6 col-md-2">
			      	<label for="f_date" class="font-weight-bold">From Date</label>
			      	<input type="date" class="form-control form-control-sm" id="fDate" name="f_date"/>
			    </div>	
			    <div class="form-group col-sx-6  col-md-2">
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
        			<tr class="py-2 text-justify" style="font-size: 20px;">
        				<td class="px-2" ><a href="#" id="${patient.registrationNumber}" class="reg_no">${patient.registrationNumber}</a></td> <!-- creation_time -->
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
    		
    		<div id="modal"  class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-xl mr-auto" role="document">
			    <div class="modal-content" style="width:118%; margin-left: -95px">
			      <div class="modal-header">
			        <h6 class="modal-title" id="exampleModalLabel">Patient Info</h6>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" id="modal_table">
			      <table id="example" class="table table-responsive" style="white-space: nowrap;">
			      	<thead id="thead">
			        	<tr>
			        		<th>Creation Date</th>
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
			                <th>Mode Of Ventilator</th>
			                <th>Need Of Proning</th>
			                <th>Investigation Comment</th>
			                <th>Change In Treatment</th>
			                <th>Reason Of Change</th>
			                <th>Current Asmt</th>
			                <th>Experimental Therapy</th>
			                <th>Any Comment</th>
		            	</tr>
			            </thead>
			            <tbody id="tbody">
			            
			            </tbody>
		            </table>
			      </div>
			    </div>
			  </div>
			</div>
    		
    		
    		
		</div>
	</div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
	 -->
	<script src="${pageContext.request.contextPath}/static_resources/js/jquery_3.5.1_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/bootstrap_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/bootstrap_max_cdn_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/font_awesome.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/moment.js"></script>
	
	<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.21/af-2.3.5/b-1.6.3/b-html5-1.6.3/datatables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/3.3.1/js/dataTables.fixedColumns.min.js"></script>
	<script>
	var table = null;
		$(document).ready(e =>{
				$(".fa").hover(e =>{
					$(".fa").css({"cursor":"pointer"});
				});

				$("#home_icon").click( e =>{
					window.location.href = "patient_master"
				});

				$("#report").hide();
			})
			.ready(function() {
			table = $('#patientTable').DataTable( {
		        "scrollY": 230,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth":false,
		        "dom": 'Bfrtip',
		        "buttons": [
		        	 {extend : 'copyHtml5', className : ' btn btn-sm px-4'}
		        ]
		        });
		});

		/* $(document).ready(function() {
			table = $('#example').DataTable( {
		        "scrollY": 300,
		        "scrollX": true,
		        "info" : false,
		        "autoWidth": false,
		        "dom": 'Bfrtip',
		        "buttons": [
		        	 {extend : 'copyHtml5', className : ' btn btn-sm px-4'}
		        ]
		        });
		}); */

		// populate modal 
		$(".reg_no").on('click',(e => {
			tableBody = $("#tbody");
			tableBody.empty();
			//table.clear();
				$.ajax({
					type: "POST",
					url : "${home}patient_modal_data",
					data : {"regNo":e.currentTarget.id},
					success: function(result, status, xhr){
						let res = JSON.parse(result);
						console.log(res);
						let data_array = []
						if(res != null){
								
							res.forEach( (item,index) =>{
								/*temp = []
								temp.push(item.creation_date || 'NA')
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
								
								table.row.add(temp).draw(false); */
								//data_array.push(temp);
								row = "<tr><td>"+
								item.creation_date +"</td><td>"+
								(item.bp || 'NA') +"</td><td>"+
								(item.pr || 'NA') +"</td><td>"+
								(item.temp || 'NA') +"</td><td>"+
								(item.respiratoryRate || 'NA') +"</td><td>"+
								(item.spO2 || 'NA') +"</td><td>"+
								(item.oxygenSuppl || 'NA') + "</td><td>" +
								(item.oxygenationDevice || 'NA') +"</td><td>"+
								(item.ddimer || 'NA') +"</td><td>"+
								(item.chestXray || 'NA') +"</td><td>"+
								(item.principlalMedicineGiven || 'NA') +"</td><td>"+
								(item.ventilationNeeded || 'NA') +"</td><td>"+
								(item.modeOfVentilator || 'NA') +"</td><td>"+
								(item.proning || 'NA') +"</td><td>"+
								(item.investigationReports || 'NA')+"</td><td>"+
								(item.changeInTreatment || 'NA') +"</td><td>"+
								(item.reasonOfChange || 'NA') +"</td><td>"+
								(item.currentAssessment || 'NA') +"</td><td>"+
								(item.experimentalTherapy || 'NA') +"</td><td>"+
								(item.comment || 'NA') +"</td></tr>";
								tableBody.append(row);
							})
						}
					},
					error : function(result,status,xhr){
					}
				});
				$("#modal").modal('show');
			}));
	
		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report</p></div>");
				$("#form_title").removeClass("m-3");	
				$("#search_div").hide();
			}
		});
	</script>	
	
</body>
</html>