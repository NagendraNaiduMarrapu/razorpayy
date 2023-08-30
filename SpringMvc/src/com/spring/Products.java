package com.spring;

public class Products {
int product_id,category_id;
String product_name;
String hsn_code;
double price;


public Products() {
	
}
public Products(int product_id, int category_id, String product_name, String hsn_code, double price) {
	super();
	this.product_id = product_id;
	this.category_id = category_id;
	this.product_name = product_name;
	this.hsn_code = hsn_code;
	this.price = price;
}
public int getProduct_id() {
	return product_id;
}
public void setProduct_id(int product_id) {
	this.product_id = product_id;
}
public int getCategory_id() {
	return category_id;
}
public void setCategory_id(int category_id) {
	this.category_id = category_id;
}
public String getProduct_name() {
	return product_name;
}
public void setProduct_name(String product_name) {
	this.product_name = product_name;
}
public String getHsn_code() {
	return hsn_code;
}
public void setHsn_code(String hsn_code) {
	this.hsn_code = hsn_code;
}
public double getPrice() {
	return price;
}
public void setPrice(double price) {
	this.price = price;
}




}
