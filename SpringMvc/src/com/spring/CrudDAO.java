package com.spring;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class CrudDAO {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public CrudDAO(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	List<User> users = new ArrayList<User>();

	public List<User> getAllRecords() {
		String query = "SELECT * FROM emplo";

		RowMapper<User> rowMapper = new RowMapper<User>() {
			@Override
			public User mapRow(ResultSet resultSet, int rowNum) throws SQLException {
				User user = new User();
				user.setId(resultSet.getInt("id"));
				user.setName(resultSet.getString("name"));
				user.setDepartment(resultSet.getString("department"));
				user.setSalary(resultSet.getDouble("salary"));

				return user;
			}
		};

		users = jdbcTemplate.query(query, rowMapper);

		return users;
	}

	public User getFirst() {
		users = this.getAllRecords();
		int a = users.get(0).getId();
		String b = users.get(0).getName();
		String c = users.get(0).getDepartment();
		Double d = users.get(0).getSalary();
		User user = new User(a, b, c, d);

		return user;
	}

	public User getLast() {
		users = this.getAllRecords();
		int len = users.size() - 1;
		int a = users.get(len).getId();
		String b = users.get(len).getName();
		String c = users.get(len).getDepartment();
		Double d = users.get(len).getSalary();
		User user = new User(a, b, c, d);

		return user;
	}
}
