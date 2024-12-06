#!/usr/bin/perl


use strict;
use warnings;

print <<EOF;
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h2>Example FORM Using PERL + Bootstrap + jQuery + AJAX </h2>
  <form action="myScript.pl">
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
    </div>
    <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd">
    </div>
    <div class="form-group">
      <div id="respAjax" class="">5 - dic - 2024</div>
    </div>	
    
    <button id="submitNoAJAX" class="btn_submit btn btn-default">Submit without AJAX</button>
    <button id="submitAJAX"   class="btn_submit btn btn-default">Submit with AJAX</button>
  </form>
</div>
<script>

\$(document).ready(function() {

	\$('.btn_submit').on( 'click', function(e) {

         	

           	var objectEvent=\$(this);

           	if(objectEvent.attr('id')==='submitNoAJAX'){ 
			console.log("submitNoAJAX");                           
                	\$('form').attr('action','myScript.pl'); 
			return true;     
           	}

		e.preventDefault();
	   	if(objectEvent.attr('id')==='submitAJAX'){
			console.log("ajax");
			var dt={ 
		          email: \$("#email").val(),
			  pwd: \$("#pwd").val()
			};
			console.log(dt.email);

			var request =\$.ajax({
                                url: "myScriptAjax.pl",
                                type: "POST",
                                data: dt,
                                dataType: "json"
			});

			request.done(function(dataset){
				console.log("success");
				console.log(dataset);
				console.log(dataset.emailPERL);
				console.log(dataset.pwdPERL);
				\$('#respAjax').addClass("well");
				\$('#respAjax').html("This came from AJAX "+dataset.emailPERL+", pswd="+dataset.pwdPERL);
			}); 
			
			request.fail(function(jqXHR, textStatus) {
                		alert("Request failed: " + textStatus);
			});
	   	}

           //return true;            
	}); 

})



</script>
</body>
</html>
EOF