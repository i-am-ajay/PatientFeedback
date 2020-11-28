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
 		<label class="sr-only" for="inlineFormInputGroup">Reg No</label>
    	<div class="input-group input-group input-group mb-2">
      	<div class="input-group-prepend">
        <div class="input-group-text text-danger px-2"><i class="fa fa-hashtag" aria-hidden="true"></i></div>
      	</div>
        <input type="text" class="form-control form-control" id="reg_no" placeholder="Reg No">
      	</div>
    	</div>
		<div class="col-3">
   				<label class="sr-only" for="inlineFormInputGroup">IP No</label>
      			<div class="input-group input-group input-group mb-2">
        			<div class="input-group-prepend">
          			<div class="input-group-text text-primary px-2"><i class="fa fa-mobile" aria-hidden="true"></i></div>
        		</div>
        		<input type="text" class="form-control form-control" id="ip_no" placeholder="IP No" required>
      			</div>
    		</div>
	    	<button id="btn" class="btn btn-small">Get Investigation</button>
		</div>
		<iframe onload="iframeLoaded();" id="my_frame" width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
	
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/80a486f3d9.js"></script>
	<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	<script>

	$("document").ready(e =>{
		// hover effect
		$("#home_icon").hover( e => {
			$("#home_icon").css({"cursor":"pointer"})
		});
	
		$("#home_icon").click( e =>{
			window.location.href = "data_search";
		});
	})
	
	// load iframe on button click.
	$('#btn').click(
		e =>{
			let regNo = $("#reg_no").val();
			let ipNo = $("#ip_no").val();

			if(regNo=="" || ipNo == ""){
				alert("Registration Number and IP number both are required.")
			}
			else{
				let data = { 'url':'http://14.98.64.51/kiosklabresult/Login.aspx?',params:{
							'r':regNo.trim(),
							'e':ipNo.trim()
							}
				}
				console.log(data);
				let url = encodeQuery(data);
				console.log(url)
				$("#my_frame").attr("src",url);
			}
		}
	);

	function encodeQuery(data){
		let url = data.url;
		for(let d in data.params){
			url += encodeURIComponent(d)+'='+encodeURIComponent(data.params[d])+'&';
		}
		console.log(url);
		return url.slice(0,-1);
	}
	

	function iframeLoaded() {
		 console.log("resize");
        var iFrameID = document.getElementById('my_frame');

        /*if(iFrameID) {
              // here you can make the height, I delete it first, then I make it again
              iFrameID.style.height = iFrameID.contentWindow.document.body.scrollHeight + "px";
        }    */
        iFrameID.style.height = "700px";
    }

   // $("#my_frame").load(iframeLoaded);
	</script>
</body>
</html>