package com.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAO {
	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public EmpDAO(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public boolean userValidation(Employee e) {
		String sql = "SELECT password FROM validation WHERE username=?";
		String username = e.getUserName();

		try {
			String password = jdbcTemplate.queryForObject(sql, String.class, username);
			return password != null;
		} catch (Exception ex) {
			return false;
		}
	}
}
