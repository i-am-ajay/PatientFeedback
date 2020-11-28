/* Ajax Method call */
		// Fetch patient demographic from track.
		$("#registration").focusout(e=>{
			console.log($("#registration").val());
			$.ajax({
				type: 'POST',
				url: "${home}fetch_trak_demographic",
				data:{"reg_no":$("#registration").val()},
				success : function(result, status, xhr){
					if(result){
						let jsonObj = JSON.parse(result);
						$("#name").val(jsonObj.name);
						if(jsonObj.phone){
							$("#phone").val(jsonObj.phone);
						}
						else if(jsonObj.tele){
							$("#phone").val(jsonObj.tele);
						}
							
						if(jsonObj.gender == 'Male'){
							$("#mgender").prop("checked",true);
						}
						else{
							$("#fgender").prop("checked",true);
						}
						let address = jsonObj.address+(jsonObj.city ? "; "+jsonObj.city : '')+(jsonObj.state ? "; "+jsonObj.state : '')+(jsonObj.country ? "; "+jsonObj.country : '')
						$("#iaddress").val(address);
					}
				},
				error : function(result, status, xhr){
				}
			});
		});