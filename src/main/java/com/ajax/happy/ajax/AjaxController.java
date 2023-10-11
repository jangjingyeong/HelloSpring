package com.ajax.happy.ajax;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ajax.happy.user.domain.User;
import com.google.gson.Gson;

@Controller
public class AjaxController {
	@RequestMapping(value="/ajax/example.do", method=RequestMethod.GET)
	public String showAjaxExample() {
		return "ajax/ajaxExample"; // 기본적으로 ViewResolver를 탐
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ex01.do", method=RequestMethod.GET)
	public void ajaxExercise01(@RequestParam("msg") String msg) {
		System.out.println("전송 받은 데이터 : " + msg);
	}
	
	@ResponseBody
	@RequestMapping(
			value="/ajax/ex02.do"
			, produces="text/plain;charset=utf-8"
			, method=RequestMethod.GET)
	public String ajaxExercise02() {
		// 데이터 자체로 보내고 싶음, ViewResolver 태우지 말아야 함
//		return "I'm server message"; 
		return "서버에서 왔습니다."; 
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ex03.do", method=RequestMethod.GET)
	public String ajaxExercise03(
			@RequestParam("num1") Integer num1
			, @RequestParam("num2") Integer num2) {
		Integer result = num1 + num2;
//		return result+"";		
		return String.valueOf(result);		
	}
	
	@ResponseBody
	@RequestMapping(
			value="/ajax/ex04.do"
			, produces="application/json;charset=utf-8"
			, method=RequestMethod.POST)
	public String ajaxExercise04(@RequestParam("userNum") Integer userNum) {
		User user1 = new User("user01", "pass01");
		User user2 = new User("user02", "pass02");
		User user3 = new User("user03", "pass03");
		User user4 = new User("user04", "pass04");
		User user5 = new User("user05", "pass05");
		List<User> uList = new ArrayList<User>();
		uList.add(user1);
		uList.add(user2);
		uList.add(user3);
		uList.add(user4);
		uList.add(user5);
		
		// User객체를 json형태로 파싱을 하여 보내주어야 함!!
		//return uList.get(userNum); // User 객체를 그대로 보내주면 안됌!!
		//return "{}"
		// User => {} 할때 사용되는 라이브러리, json-simple
		// 
		JSONObject json = new JSONObject(); // json 객체 생성 -> {} 생성 완료
		User user = uList.get(userNum);
		json.put("userId", user.getUserId());
		json.put("userPw", user.getUserPw()); // { "userId" : "user01", "userPw" : "pass01" }
		return json.toString();				  // "{ "userId" : "user01", "userPw" : "pass01" }"
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ex05.do"
				, produces="application/json;charset=utf-8"
				, method=RequestMethod.GET)
	public String ajaxExercise05(@RequestParam("userNum") Integer userNum) {
		User user1 = new User("user01", "pass01");
		User user2 = new User("user02", "pass02");
		User user3 = new User("user03", "pass03");
		User user4 = new User("user04", "pass04");
		User user5 = new User("user05", "pass05");
		List<User> uList = new ArrayList<User>();
		uList.add(user1);
		uList.add(user2);
		uList.add(user3);
		uList.add(user4);
		uList.add(user5);
		JSONArray jsonArr = new JSONArray();
		if(userNum >= 0 && userNum < uList.size()) {
			User uOne = uList.get(userNum);
			JSONObject json = new JSONObject();
			json.put("userId", uOne.getUserId());
			json.put("userPw", uOne.getUserPw());
			jsonArr.add(json);
		}else {
			for(User userOne : uList) {
				JSONObject json = new JSONObject(); // {}
				json.put("userId", userOne.getUserId());
				json.put("userPw", userOne.getUserPw()); // { userId : "user01", userPw : "pass01" }
				jsonArr.add(json);						// [{ userId : "user01", userPw : "pass01" }]
			}
		}
		return jsonArr.toString();
	}
	@ResponseBody
	@RequestMapping(value="/ajax/ex06.do"
			, produces="application/json;charset=utf-8"
			, method=RequestMethod.GET)
	public String ajaxExercise06() {
		User user1 = new User("user01", "pass01");
		User user2 = new User("user02", "pass02");
		User user3 = new User("user03", "pass03");
		User user4 = new User("user04", "pass04");
		User user5 = new User("user05", "pass05");
		List<User> uList = new ArrayList<User>();
		uList.add(user1);
		uList.add(user2);
		uList.add(user3);
		uList.add(user4);
		uList.add(user5);
		Gson gson = new Gson();
		return gson.toJson(uList);
		
//		JSONArray jsonArr = new JSONArray();
//		JSONObject json = new JSONObject();
//		jsonArr.add(json);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}


















