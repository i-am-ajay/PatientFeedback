<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Last 5 Records</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/table_style.css" >
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static_resources/css/input_style.css" >
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css" />
</head>
<body>
	<div class="row mt-2 my-1 mx-auto">
			<div class="col-2">
				<p><i  id="home_icon" class="fa fa-home fa-2x" aria-hidden="true"></i></p>
			</div>
			<div class="col-3">
   				<label class="sr-only" for="inlineFormInputGroup">Name</label>
      			<div class="input-group input-group input-group mb-2">
        			<div class="input-group-prepend">
          			<div class="input-group-text text-success px-2"><i class="fa fa-user-circle" aria-hidden="true"></i></div>
        		</div>
        		<input type="text" class="form-control form-control" id="inlineFormInputGroup" placeholder="Username" value="${name_val}" disabled>
      			</div>
    		</div>
		<div class="col-3">
   				<label class="sr-only" for="inlineFormInputGroup">Reg No</label>
      			<div class="input-group input-group input-group mb-2">
        			<div class="input-group-prepend">
          			<div class="input-group-text text-danger px-2"><i class="fa fa-hashtag" aria-hidden="true"></i></div>
        		</div>
        		<input type="text" class="form-control form-control" id="inlineFormInputGroup" placeholder="Reg No" value="${reg_no}" disabled>
      			</div>
    		</div>
		<div class="col-3">
   				<label class="sr-only" for="inlineFormInputGroup">Phone No</label>
      			<div class="input-group input-group input-group mb-2">
        			<div class="input-group-prepend">
          			<div class="input-group-text text-primary px-2"><i class="fa fa-mobile" aria-hidden="true"></i></div>
        		</div>
        		<input type="text" class="form-control form-control" id="inlineFormInputGroup" placeholder="Phone No" value="${phone_no}" disabled>
      			</div>
    		</div>
	</div>
	<div class="mx-auto" style="width:90%">
	<div class="tbl-header mt-2 mx-2">
		<table cellpadding="0" cellspacing="0" border="0">
	        <thead>
	            <tr>
	                <th>Parameter</th>
	                <th>${data[19][0]}<br/>${data[20][0] !="NA" ? data[20][0]:""}</th>
	                <th>${data[19][1]}<br/>${data[20][1] !="NA" ? data[20][1]:""}</th>
	                <th>${data[19][2]}<br/>${data[20][2] !="NA" ? data[20][2]:""}</th>
	                <th>${data[19][3]}<br/>${data[20][3] !="NA" ? data[20][3]:""}</th>
	                <th>${data[19][4]}<br/>${data[20][4] !="NA" ? data[20][4]:""}</th>
	            </tr>
	        </thead>
	       </table>
	       </div>
	      <div class="tbl-content mx-2">
    		<table cellpadding="0" cellspacing="0" border="0">
	        <tbody>
	        	<c:forEach items="${data}" end="18" var="val" varStatus="loop">
	        		<tr>
	                <td id='title'>${header_array[loop.index]}</td>
	                <td>${val[0]}</td>
	                <td>${val[1]}</td>
	                <td>${val[2]}</td>
	                <td>${val[3]}</td>
	                <td>${val[4]}</td>
	            </tr>
	        	</c:forEach>     
	    	</tbody>
	    </table>
	    </div>
	    </div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	<script>$(window).on("load resize ", function() {
		  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
		  $('.tbl-header').css({'padding-right':scrollWidth});
		}).resize();

	$("document").ready(e =>{
		// hover effect
		$("#home_icon").hover( e => {
			$("#home_icon").css({"cursor":"pointer"})
		});
	
		$("#home_icon").click( e =>{
			window.location.href = "data_search";
		});
	})
	</script>
</body>
</html>