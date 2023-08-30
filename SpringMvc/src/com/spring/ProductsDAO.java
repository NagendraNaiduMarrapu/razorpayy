package com.spring;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;



@Component
public class ProductsDAO {
	
	@Autowired
	JdbcTemplate jt;
	
	public List<Products> getall(){
		
		String SQL_query = "select * from rhcvProduct";
		
		//ArrayList<Products> al = new ArrayList<>();
		RowMapper rw = new RowMapper() {
			
			
			public Products mapRow(ResultSet resultSet,int rowNum) throws SQLException {
				Products p = new Products();
				p.setCategory_id(resultSet.getInt("category_id"));
				p.setProduct_id(resultSet.getInt("product_id"));
				p.setProduct_name(resultSet.getString("product_name"));
				p.setPrice(resultSet.getDouble("price"));
				p.setHsn_code(resultSet.getString("hsn_code"));
				return p;
			}
		};
		
		List<Products> prod = jt.query(SQL_query, rw);
		
		return prod;
		
		
		
		
	}
	
	
	public Products getProductPrice(String prod_name) {
		RowMapper rw = new RowMapper() {
			
			
			public Products mapRow(ResultSet resultSet,int rowNum) throws SQLException {
				Products p = new Products();
			
				p.setPrice(resultSet.getDouble(1));
				
				return p;
			}
		};
		Object[] x = {prod_name};
		String query = "select p.price*h.gst from rhcvProduct p,rhcvGst h where p.hsn_code=h.hsn_code and product_name=?";
		Products price =  (Products) jt.queryForObject(query,x,rw);
		return price;
	}
}
