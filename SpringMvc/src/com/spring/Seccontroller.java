package com.spring;

import java.util.ArrayList;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;





@Controller
public class Seccontroller {
	
	
	@Autowired
	ProductsDAO pdao;

	@PostMapping("/payment")
	@ResponseBody
	public String processPayment(@RequestBody Map<String, Object> data) throws RazorpayException {
		Double amount = Double.parseDouble((String) data.get("amount"));

		System.out.println("Received payment request for amount: " + amount);

		RazorpayClient razorpay = new RazorpayClient("rzp_test_4jwnZunhRo2Y9N", "QJKxF1QeJtOSTtYDINz0Hcyy");

		JSONObject orderRequest = new JSONObject();
		orderRequest.put("amount", amount * 100);
		orderRequest.put("currency", "INR");
		orderRequest.put("receipt", "vamsi_tax");

		Order orders = razorpay.Orders.create(orderRequest);
		System.out.println(orders);
		return orders.toString();
	}
	
	
	
	@RequestMapping("/getcat" )
	@ResponseBody
	public ArrayList<Products> getCategories(@ModelAttribute Products prod) {
		ArrayList<Products> plist = (ArrayList<Products>) pdao.getall();
		return plist;
		
	}
	
	
	@RequestMapping(value="/getPrice",method=RequestMethod.POST)
	@ResponseBody
	public Double getTotalPrice(@RequestBody Map<String,Object> data) {
		String pname = (String) data.get("pname");
		int quant = Integer.parseInt((String) data.get("quant"));
		Products price = pdao.getProductPrice(pname);
		double total = price.getPrice()*quant;
		return total;
	}
	
}
