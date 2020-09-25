<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Comcare</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/style.css" >
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/bootstrap_min.css">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
	
</head>
<body class=mt-1>
	<%@ include file = "../header_health_report_card.jsp" %>
	<div class="p-2 m-auto container">
		<h6 class="border-bottom m-1 text-muted pb-2" id="form_title">Patient Comcare Report</h6>
		<div class="mt-3">
			<form action="comcare_report" method="POST">
			 <div class="form-row search">
		  	 <div class="form-group col-md-2">
			      <label for="registration" class="font-weight-bold">Reg No <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="registration" placeholder="Registration Number" name="reg" title="Valid Number"/>
			    </div>
			    <div class="form-group col-md-2">
			      	<label for="icmr" class="font-weight-bold">ICMR ID</label>
			      	<input class="form-control form-control-sm" id="icmr" placeholder="ICMR ID" name="icmr_id" title="ICMR ID"/>
			    </div>	
			    <div class="form-group col-md-2">
			      	<label for="srf" class="font-weight-bold">SRF ID</label>
			      	<input class="form-control form-control-sm" id="srf" placeholder="SRF ID" name="srf_id" title="SRF ID"/>
			    </div>	
			    <div class="form-group col-md-2">
			      <label for="name" class="font-weight-bold">Patient Name <span class="text-danger">*</span></label>
			      <input class="form-control form-control-sm" id="name" placeholder="Patient Name" name="p_name"/>
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
		<h6 class="border-bottom mb-3 text-muted pb-2" id="form_title"></h6>
		<div id="table">
			<table id="example" class="display compact" style="width:220%">
	        	<thead>
	            	<tr>
	                	<th>Reg No</th>
		                <th>ICMR ID</th>
		                <th>SRF ID</th>
		                <th>Patient Name</th>
		                <th>Phone No</th>
		                <th>Age</th>
		                <th>Pincode</th>
		                <th>Address</th>
		                <th>Gender</th>
		                <th>Repeat Test</th>
		                <th>Test Result</th>
		                <th>Sample Collection Date</th>
		                <th>Test Result Date</th>
		                <th>Test Site</th>
		                <th>Lab Name</th>
		                <th>Lab Code</th>
		                <th>Patient Condition</th>
		                <th>Admission Status</th>
		                <th>Admission Date</th>
		                <th>Transfered From</th>
		                <th>Patient Comorbidities</th>
		            </tr>
	        	</thead>
	        	<tbody>
	        		
	        		<c:forEach var="item" items="${comcare_data}">
	        			<tr>
	        			<td>${item.patientDetails.registrationNumber}</td>
	        			<td>${item.patientDetails.icmrId}</td>
	        			<td>${item.srfId}</td>
	        			<td>${item.patientDetails.name}</td>
	        			<td>${item.patientDetails.mobileNo}</td>
	        			<td>${item.patientDetails.age}</td>
	        			<td>${item.patientDetails.pincode}</td>
	        			<td>${item.patientDetails.address}</td>
	        			<td>${item.patientDetails.gender}</td>
	        			<td>${item.repeatTest}</td>
	        			<td>${item.testResult}</td>
	        			<td>${item.testSampleCollectionDate}</td>
	        			<td>${item.testResultDate}</td>
	        			<td>${item.testSite}</td>
	        			<td>${item.labName}</td>
	        			<td>${item.labCode}</td>
	        			<td>${item.patientCondition}</td>
	        			<td>${item.admissionStatus}</td>
	        			<td>${item.admissionDate}</td>
	        			<td>${item.transferedFrom}</td>
	        			<td>${item.getComorbidities()}</td>
	        			</tr>
	        		</c:forEach>
	        	</tbody>
    		</table>
    		
		</div>
	</div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="${pageContext.request.contextPath}/static_resources/js/jquery_3.5.1_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/bootstrap_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/bootstrap_max_cdn_min.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/font_awesome.js"></script>
	<script src="${pageContext.request.contextPath}/static_resources/js/moment.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.21/af-2.3.5/b-1.6.3/b-html5-1.6.3/datatables.min.js"></script>
	<script>
	var table = null;
		$(document).ready(function() {
			table = $('#example').DataTable( {
		        "scrollY": 250,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth" : false,
		        "dom": 'Bfrtip',
		        "buttons": [
		        	 {extend : 'copyHtml5', className : 'btn btn-sm px-4'}
		        ]
		        });
		});
		
		/* /// calculate age
		function calculate_age(birth_date){
			let dob = moment(birth_date);
			let current_date = moment(Date.now());
			$("#age").val(current_date.diff(dob,'Years'));
		} */

		// Changes the page heading for mobile screen and tablets.
		$(document).ready( e => {
			const screenSize = window.screen.width;
			if(screenSize < 1000){
				$("#middle_col").replaceWith("<div id='middle_col' class='col-8'><h6 class='text-center display-5'>Sir Ganga Ram Hospital</h6><p class='text-center'>Patient Health Report Card</p></div>");
				$("#form_title").removeClass("m-3");	
			}
		}).ready(e =>{
			$(".fa").hover(e =>{
				$(".fa").css({"cursor":"pointer"});
			});

			$("#home_icon").click( e =>{
				window.location.href = "report_panel"
			})

			$("#report").hide();
			
		});

		// js for header icons

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