<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>

<body>
<br><br><br>
<center>
<form onsubmit="return false">
<select id="getcat">
</select>
<button onclick="decrease()">-</button>
<input type="text" id="count" size="1px"/>
<button onclick="increase()">+</button><br><br><br>
<button onclick="calc()">calculate</button><br><br>

<input type="text" id="price" placeholder="price" /><br><br>
<input type="button" onclick="pay()" value="pay"/>
</form>
</center>
</body>

<script>
var count = 0;

function calc(){
	var q = document.getElementById("count").value;
	var cat = document.getElementById("getcat").value;
	
	var pricedata = {"quant":q,"pname":cat};
	var newdata = JSON.stringify(pricedata);
	
	$.ajax({
		url:"getPrice",
		method:"POST",
		contentType:"application/json",
		data:x=newdata,
		success:function(response){
			 console.log("i love you");
			var total = response;
			console.log(total);
			$('#price').val(total);
			
		}
		
	})
	
	
	
}

function increase(){
	count++;
	document.getElementById("count").value=count;
	
}

function decrease(){
	count--;
	if(count>0){
	document.getElementById("count").value=count;
	}
	if(count<=0){
		
		count=1
	}
	
}


var xhr = new XMLHttpRequest();
xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
        var data = JSON.parse(xhr.responseText);
        var getcategories = document.getElementById("getcat");
        

        getcategories.innerHTML = "";
        

       

        for (var j = 0; j < data.length; j++) {
            var categories = data[j].product_name;
            var option = document.createElement("option");
            option.value = categories;
            option.textContent = categories;
            getcategories.appendChild(option);
        }
        
        
        document.getElementById("count").value=1;
        

     
    }
};

xhr.open("GET", "getcat", true);
xhr.send();


function pay() {
    var x = $("#price").val();

    if (x === '' || x === null) {
        alert("Please enter amount");
        return;
    }

    console.log("hii");
    $.ajax({
        type: "POST",
        url: "http://localhost:8080/SpringMvc/payment",
        contentType: "application/json",
        data: JSON.stringify({ "amount": x }),
        success: function (response) {
            console.log("Payment started");
            var response=JSON.parse(response);
            

            if (response.status === "created") {
           		console.log("paymemnt");
                var options = {
                    "key": "rzp_test_4jwnZunhRo2Y9N",
                    "amount": response.amount,
                    "currency": "INR",
                    "name": "Rajesh",
                    "description": "Testing purpose",
                    "image": "https://www.hindustantimes.com/ht-img/img/2023/08/18/1600x900/kohli_71_1683829193033_1692354506172.webp",
                    "order_id": response.id,
                    "handler": function (response) {
                        console.log(response.razorpay_payment_id);
                        alert("payment successful");
                    },
                    "prefill": {
                        "name": "",
                        "email": "",
                        "contact": ""
                    },
                    "notes": {
                        "address": "Razorpay Corporate Office"
                    },
                    "theme": {
                        "color": "green"
                    }
                };
                console.log("hiifff");
                var rzp = new Razorpay(options);
                rzp.on('payment.failed', function (response){
                    console.log(response.error.code);
                });
                rzp.open();

            }
        },
        error: function (error) {
            console.error('Payment failed');
        }
    });
}




</script>
</html>
