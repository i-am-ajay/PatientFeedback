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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/bootstrap_min.css" >
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head>
<body class=mt-1>
	<%@ include file = "../header_health_report_card.jsp" %>
	<div class="p-2 m-auto container">
		<h4 class="border-bottom m-3 text-muted pb-2" id="form_title">Patient Comcare</h4>
		<div id="table">
			<table id="example" class="display compact" style="width:220%">
	        	<thead>
	            	<tr>
	                	<th>Reg No</th>
		                <th>ICMR ID</th>
		                <th>SRF ID</th>
		                <th>Patient Name</th>
		                <th>Phone No</th>
		                <th>DOB</th>
		                <th>Age</th>
		                <th>Pincode</th>
		                <th>Address</th>
		                <th>Gender</th>
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
		                <th>Update</th>
		            </tr>
	        	</thead>
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
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	
	<script>
	var table = null;
		$(document).ready(function() {
			table = $('#example').DataTable( {
		        "scrollY": 300,
		        "scrollX" : true,
		        "info" : false,
		        "autoWidth" : false
		       
		        /* "columnDefs": [
		            { "width": "20%", "targets": }
		          ] */
		     
		        });
		        /* "ajax":{
			        url: "${home}table_update", 
			        data:{"comorbidities_id":0}, 
			        error: function(r,x,a){
					console.log(r);
			     } }
		     });*/
		    ajax_call();
		});
		
		$(document).ready(e =>{
			$("#test").click(e =>{
				ajax_call(null)
			})
		})
		.ready( e =>{
			$(".fa").hover(e =>{
					$(".fa").css({"cursor":"pointer"});
				}
			);

			// home icon link

			$("#home_icon").click(e =>{
				window.location.href = "admin_panel";
			})

			$("#report").click(e => {
				window.location.href = "comcare_report";
			})
		});
	
		// on registration focus out get employee details through ajax call 
		
		function ajax_call(param){
			let return_result = null;
			if(!param){
				param = 0
			}
			$.ajax({
				type: "POST",
				url : "${home}table_update",
				data : {"comorbidities_id":0},
				success: function(result, status, xhr){
					let res = JSON.parse(result);
					console.log(res);
					let data_array = []
					if(res != null){
						res.forEach( (item,index) =>{
							temp = []
							temp.push(item.reg || 'NA')
							temp.push("<input type='text' id=i_"+item.record_id+" name='icmr_id' value="+item.icmr+">");
							temp.push("<input type='text' id=s_"+item.record_id+" name='srf_id' value="+item.srfid+ ">");
							temp.push(item.name || 'NA');
							temp.push(item.phone || 'NA');
							temp.push(item.dob || 'NA');
							temp.push('');
							temp.push(item.pincode || 'NA');
							temp.push(item.address || 'NA');
							temp.push(item.gender || 'NA');
							temp.push(item.test_result || 'NA');
							temp.push(item.collection_date || 'NA');
							temp.push(item.result_date || 'NA');
							temp.push(item.test_site || 'NA');
							temp.push(item.lab_name || 'NA');
							temp.push(item.lab_code || 'NA');
							temp.push(item.patient_condition || 'NA');
							temp.push(item.admission_status || 'NA');
							temp.push(item.addmission_date || 'NA');
							temp.push(item.transform_from || 'NA');
							temp.push(item.patient_com || 'NA');
							temp.push("<input type='checkbox' id=c_"+item.record_id+" name='update_status' value='true' onclick= updateFunction(this); />" )
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
		};
		
		// function call on focus out
		$("#registration").focusout( e =>{
			let val = $("#registration").val();
			ajax_call("reg_no",val,"reg");
		});

		// on  icmr  
		$("#icmr").focusout( e =>{
			let val = $("#icmr").val();
			ajax_call("icmr_id",val,"icmr");
		});

		// on date focus out
		$("#dob").focusout(e => {
			calculate_age($("#dob").val());
		})
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