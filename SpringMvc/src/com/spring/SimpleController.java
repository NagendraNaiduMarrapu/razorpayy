package com.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SimpleController {

	@Autowired
	EmpDAO edao;

	@Autowired
	private CrudDAO cdao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String crud() {

		return "crud";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String home(Model model) {

		return "home";
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String user(Employee e, Model model) throws Exception {
		System.out.println(e.getUserName());
		model.addAttribute("userName", e.getUserName());

		if (edao.userValidation(e)) {
			return "user";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/first", method = RequestMethod.GET)
	@ResponseBody
	public User first() {
		User users = cdao.getFirst();
		return users;
	}

	@RequestMapping(value = "/last", method = RequestMethod.GET)
	@ResponseBody
	public User last() {
		User users = cdao.getLast();
		return users;
	}

}