<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Payment Form</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
    <div class="container mt-5">
        <form method="post">
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="text" class="form-control" id="amount" name="amount" placeholder="Enter amount">
            </div>
           <input type="button" class="btn btn-success" value="pay" onclick="pay()" />

        </form>
    </div>

    <script>
    function pay() {
        var x = $("#amount").val();

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
</body>
</html>
